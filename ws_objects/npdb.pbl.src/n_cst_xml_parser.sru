$PBExportHeader$n_cst_xml_parser.sru
forward
global type n_cst_xml_parser from nonvisualobject
end type
end forward

global type n_cst_xml_parser from nonvisualobject autoinstantiate
end type

type variables
string is_DocText
string is_DocLowerText
n_cst_string inv_string
end variables

forward prototypes
public function integer of_createfromstring (string as_text)
public function string of_getelementtext (string as_path)
public function integer of_createfromfile (string as_filename)
public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[])
public function boolean of_elementexists (string as_path)
public function integer of_getelementtext (string as_element, ref string as_text[])
public function long of_findendmark (string as_element, long al_startpos)
end prototypes

public function integer of_createfromstring (string as_text);//////////////////////////////////////////////////////////////////////
// $<function> of_createfromstring
// $<arguments>
//			string	as_text
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.05.2009
//////////////////////////////////////////////////////////////////////

if IsNull(as_Text) or Trim(as_Text) = "" then
	Return -1
end if

// Initialize document content
is_DocText = as_Text
is_DocLowerText = Lower(as_Text)

Return 1
end function

public function string of_getelementtext (string as_path);//////////////////////////////////////////////////////////////////////
// $<function> of_getelementtext
// $<arguments>
//			string	as_path
// $<returns> string
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.05.2009
//////////////////////////////////////////////////////////////////////

long ll_Pos
long ll_MidStart
long ll_MidEnd
long ll_Start = 1
string ls_Element[]
string ls_ElementText
integer i, li_ElementCount

// Get element name from path
of_ParseToArray(Lower(as_Path), "\", ls_Element[])

// Get start and end postion of element
li_ElementCount = UpperBound(ls_Element[])
for i = 1 to li_ElementCount
	ll_Pos = PosA(is_DocLowerText, "<" + ls_Element[i], ll_Start)
	if ll_Pos > 0 then
		ll_Start = ll_Pos + LenA(ls_Element[i]) + 1
	else
		SetNull(ls_ElementText)
		Return ls_ElementText
	end if
next
ll_MidStart = PosA(is_DocLowerText, ">", ll_Start) + 1
ll_MidEnd= PosA(is_DocLowerText, "</" + ls_Element[li_ElementCount] + ">", ll_MidStart)

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.18.2012
//modify by stephen 11.08.2012
//$<reason> get ..report/statement --v12.2 modify NPDB qrxs report
if Lower(as_Path) = 'subjectstatement\statement'  or Lower(as_Path) = 'secretarystatement\statement' then
	ll_Pos = posa(is_DocLowerText, "</" + ls_Element[1] + ">", ll_Start)
	do while PosA(is_DocLowerText, "<" + ls_Element[li_ElementCount] + ">", ll_Start) > 0 and PosA(is_DocLowerText, "<" + ls_Element[li_ElementCount] + ">", ll_Start) < ll_Pos
		ll_MidStart = PosA(is_DocLowerText, "<" + ls_Element[li_ElementCount] + ">", ll_Start) + LenA(ls_Element[li_ElementCount])+ 2
		ll_Start = ll_MidStart
	loop	
end if

if Lower(as_Path) = 'statement' then
	do while PosA(is_DocLowerText, "</" + ls_Element[li_ElementCount] + ">", ll_MidEnd +1) > 0
		ll_MidEnd= PosA(is_DocLowerText, "</" + ls_Element[li_ElementCount] + ">", ll_MidEnd +1)
	loop	
end if
//------------------- APPEON BEGIN -------------------

// Get element text
ls_ElementText = MidA(is_DocText, ll_MidStart, ll_MidEnd - ll_MidStart)
if LenA(ls_ElementText) < 1 then SetNull(ls_ElementText)

//---------- APPEON BEGIN ----------
//$<add> Evan 05.11.2012
//$<reason> trap for some specific characters 
ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&amp;", "&")
ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&apos;", "'")
ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&quot;", "~"")
//---------- APPEON END ------------

Return ls_ElementText
end function

public function integer of_createfromfile (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function> of_createfromfile
// $<arguments>
//			string	as_filename
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.05.2009
//////////////////////////////////////////////////////////////////////

blob lblb_Data
long ll_FileLength
long ll_ReadLength

is_DocText = ""
is_DocLowerText = ""

// Read file content
if not FileExists(as_FileName) then Return -1
ll_FileLength = FileLength(as_FileName)
lblb_Data = Blob(Space(ll_FileLength),EncodingAnsi!) //Encoding – Nova 11.16.2010
ll_ReadLength = AppeonReadFile(as_FileName, lblb_Data, ll_FileLength)
if ll_ReadLength < 0 then Return -1

// Initialize document content
is_DocText = String(lblb_Data,EncodingAnsi!) //Encoding – Nova 11.16.2010
is_DocLowerText = Lower(is_DocText)

Return 1
end function

public function long of_parsetoarray (string as_source, string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_ParseToArray
//
//	Access:  public
//
//	Arguments:
//	as_Source   The string to parse.
//	as_Delimiter   The delimeter string.
//	as_Array[]   The array to be filled with the parsed strings, passed by reference.
//
//	Returns:  long
//	The number of elements in the array.
//	If as_Source or as_Delimeter is NULL, function returns NULL.
//
//	Description:  Parse a string into array elements using a delimeter string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.02   Fixed problem when delimiter is last character of string.

//	   Ref array and return code gave incorrect results.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_DelLen, ll_Pos, ll_Count, ll_Start, ll_Length
string 	ls_holder

//Check for NULL
IF IsNull(as_source) or IsNull(as_delimiter) Then
	long ll_null
	SetNull(ll_null)
	Return ll_null
End If

//Check for at leat one entry
If Trim (as_source) = '' Then
	Return 0
End If

//Get the length of the delimeter
ll_DelLen = LenA(as_Delimiter)

ll_Pos =  PosA(Upper(as_source), Upper(as_Delimiter))

//Only one entry was found
if ll_Pos = 0 then
	as_Array[1] = as_source
	return 1
end if

//More than one entry was found - loop to get all of them
ll_Count = 0
ll_Start = 1
Do While ll_Pos > 0
	
	//Set current entry
	ll_Length = ll_Pos - ll_Start
	ls_holder = MidA (as_source, ll_start, ll_length)

	// Update array and counter
	ll_Count ++
	as_Array[ll_Count] = ls_holder
	
	//Set the new starting position
	ll_Start = ll_Pos + ll_DelLen

	ll_Pos =  PosA(Upper(as_source), Upper(as_Delimiter), ll_Start)
Loop

//Set last entry
ls_holder = MidA (as_source, ll_start, LenA (as_source))

// Update array and counter if necessary
if LenA (ls_holder) > 0 then
	ll_count++
	as_Array[ll_Count] = ls_holder
end if

//Return the number of entries found
Return ll_Count

end function

public function boolean of_elementexists (string as_path);//////////////////////////////////////////////////////////////////////
// $<function> of_elementexists
// $<arguments>
//			string	as_path
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.05.2009
//////////////////////////////////////////////////////////////////////

long ll_Pos
long ll_Start = 1
string ls_Element[]
integer i, li_ElementCount

// Get element name from path
of_ParseToArray(Lower(as_Path), "\", ls_Element[])

// Get postion of element
li_ElementCount = UpperBound(ls_Element[])
for i = 1 to li_ElementCount
	ll_Pos = PosA(is_DocLowerText, "<" + ls_Element[i], ll_Start)
	if ll_Pos > 0 then
		ll_Start = ll_Pos + LenA(ls_Element[i]) + 1
	else
		Return false
	end if
next

Return true
end function

public function integer of_getelementtext (string as_element, ref string as_text[]);//////////////////////////////////////////////////////////////////////
// $<function> of_getelementtext
// $<arguments>
//				 string 	as_element
//			ref string	as_text[]
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.05.2009
//////////////////////////////////////////////////////////////////////

long ll_Pos
long ll_MidStart
long ll_MidEnd
long ll_Start = 1
string ls_Char
string ls_Null[]
string ls_CurrElement
string ls_ElementText
integer i, li_ElementCount

as_Text[] = ls_Null[]
if LenA(as_Element) > 0 then
	as_Element = Lower(as_Element)
else
	SetNull(as_Element)
end if

// Get elements text process
do while true
	ll_Pos = PosA(is_DocLowerText, "<", ll_Start)
	if ll_Pos > 0 then
		// Get element name
		ls_CurrElement = ""
		for i = 1 to 1000
			ls_Char = MidA(is_DocLowerText, ll_Pos + i, 1)
			if ls_Char = ' ' or ls_Char = '>' then
				Exit
			else
				ls_CurrElement += ls_Char
			end if
		next
		
		// Get element start position
		ll_MidStart = ll_Pos + LenA(ls_CurrElement) + 1
		ll_MidStart = PosA(is_DocLowerText, ">", ll_MidStart) + 1
		
		// Get element end position
		ll_Pos = of_FindEndMark(ls_CurrElement, ll_Pos)
		ll_MidEnd = ll_Pos
		
		// Get element text
		if ll_Pos > 0 then
			li_ElementCount ++ // Increase element count
			ll_Start = ll_Pos + LenA(ls_CurrElement) + 3
			// Get element text
			if IsNull(as_Element) or as_Element = ls_CurrElement then
				ls_ElementText = MidA(is_DocText, ll_MidStart, ll_MidEnd - ll_MidStart)
				if LenA(ls_ElementText) < 1 then SetNull(ls_ElementText)
				//---------- APPEON BEGIN ----------
				//$<add> Evan 05.11.2012
				//$<reason> trap for some specific characters 
				ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&amp;", "&")
				ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&apos;", "'")
				ls_ElementText = inv_string.of_GlobalReplace(ls_ElementText, "&quot;", "~"")
				//---------- APPEON END ------------
				as_Text[UpperBound(as_Text) + 1] = ls_ElementText
			end if
		else
			Return -1
		end if
	else
		Exit
	end if
loop

Return UpperBound(as_Text)
end function

public function long of_findendmark (string as_element, long al_startpos);//////////////////////////////////////////////////////////////////////
// $<function> of_findendmark
// $<arguments>
//			string	as_element
//			long		al_startpos
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.23.2009
//////////////////////////////////////////////////////////////////////

long   ll_Pos
long   ll_EndPos
long   ll_MidStart
long   ll_MidEnd
long   ll_OldLen
long   ll_NewLen
string ls_LeftStr
string ls_RightStr
string ls_NewDocLowerText
string ls_MarkStart
string ls_MarkEnd

ls_MarkStart = "<" + as_Element + ">" // Element not include property
ls_MarkEnd = "</" + as_Element + ">"

ls_NewDocLowerText = is_DocLowerText
ll_OldLen = LenA(ls_NewDocLowerText)
ll_NewLen = ll_OldLen

do while true
	ll_EndPos = PosA(ls_NewDocLowerText, ls_MarkEnd, al_StartPos)
	if ll_EndPos < 1 then Return -1
	
	ll_Pos = LastPos(ls_NewDocLowerText, ls_MarkStart, ll_EndPos)
	if ll_Pos < 1 then Return -1
	
	if ll_Pos <> al_StartPos then
		ll_Pos -= 1
		ll_EndPos = ll_NewLen - ll_EndPos - LenA(ls_MarkEnd) + 1
		ls_LeftStr = LeftA(ls_NewDocLowerText, ll_Pos)
		ls_RightStr = RightA(ls_NewDocLowerText, ll_EndPos)
		ls_NewDocLowerText = ls_LeftStr + ls_RightStr
		ll_NewLen = LenA(ls_NewDocLowerText)
	else
		ll_EndPos = ll_EndPos + (ll_OldLen - ll_NewLen)
		Return ll_EndPos
	end if
loop

Return -1
end function

on n_cst_xml_parser.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_xml_parser.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

