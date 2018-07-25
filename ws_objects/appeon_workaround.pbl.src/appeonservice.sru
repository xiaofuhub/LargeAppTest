$PBExportHeader$appeonservice.sru
forward
global type appeonservice from nonvisualobject
end type
end forward

global type appeonservice from nonvisualobject autoinstantiate
end type

type prototypes
Function long StringToInt(ref string as_hex) library "EonAXNVO.dll" alias for "StringToInt;Ansi"
Function long GetLocalIPAddr(ref string as_ip) library "EonAXNVO.dll" alias for "GetLocalIPAddr;Ansi"
Function int FreeMemory(long al_address) library "EonAXNVO.dll"

Function string GetWebPath(string as_filepath, ref long nRand, ref long address) library "EonAXNVO.dll" alias for "GetWebPath;Ansi"
end prototypes

type variables
private:
CONSTANT integer I_STRA_COUNT = 16
CONSTANT integer I_STRB_COUNT = 3
CONSTANT integer I_STRC_COUNT = 8
end variables

forward prototypes
public function string of_getfilepath ()
public function any of_getvalueany (string as_type, string as_value)
public function integer of_getipaddress (ref string as_ipaddress)
public function long of_fileread (readonly string as_filename, ref string as_data)
public function date of_date (readonly string as_datetime)
public subroutine of_decomposetoarray (readonly string as_data, readonly string as_delimiter, ref string as_array[])
public function integer of_getcolumntype (readonly string as_type)
public function integer of_getfilepath (ref string as_filepath, ref string as_filename, string as_filetype, readonly string as_dataobject, boolean ab_flag)
public function integer of_getpbchanges (readonly string as_xml, ref str_a astr_obj)
public function integer of_getpbchanges (readonly string as_xml, ref str_b astr_obj, readonly string as_type)
public function long of_parsetoarray (readonly string as_source, readonly string as_delimiter, ref string as_array[])
public function dwitemstatus of_statusfromcode (readonly string as_status)
public function string of_statustocode (readonly dwitemstatus adw_status)
public function time of_time (readonly string as_datetime)
public subroutine of_globalreplace (ref string as_source, string as_old, readonly string as_new, boolean ab_ignorecase)
end prototypes

public function string of_getfilepath ();////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetFilePath
//
//	Access:  public
//
//	Arguments:		
//
//	Returns:  
//		EAServer path it succeeds and space if error occurs
//
//	Description:  
//		Gets EAServer path 
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
INTEGER nPos
STRING strPath

strPath= Lower(GetLibraryList())

IF strPath= '' THEN Return ''

nPos = PosA(strPath, 'repository')

IF nPos > 0 THEN
	strPath = LeftA(strPath, nPos - 2)
ELSE
	strPath = ''
END IF

Return strPath

    

end function

public function any of_getvalueany (string as_type, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetValueAny
//
//	Access:    public
//
//	Arguments:
//		as_type			: The type of value
//   as_value		   : The string value
//
//	Returns:  any	
//	  The any value
//
//	Description:  
//	
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
any 	la_value
date	ld_val
time	ltm_val

CHOOSE CASE Lower ( LeftA ( as_type , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			la_value = as_value  
	
		CASE "date"			//  DATE DATATYPE
			la_value =  Date (as_value)  

		CASE "datet"		//  DATETIME DATATYPE
			ld_val = of_Date (as_value)
			If PosA ( as_value, " " ) > 0 Then
				/*  There was a time entered  */
				ltm_val = of_Time (as_value)
			Else
				ltm_val = Time ( "00:00:00" )
			End If
			la_value = DateTime (ld_val, ltm_val)
				
		CASE "decim"		//  DECIMAL DATATYPE
			la_value  = Dec (as_value)
					
		CASE "numbe", "doubl"			//  NUMBER DATATYPE	
			la_value = Double (as_value)
		CASE "real"				//  REAL DATATYPE	
			la_value = Real (as_value)
		CASE "long", "ulong"		//  LONG/INTEGER DATATYPE	
			la_value = Long (as_value)
		CASE "time", "times"		//  TIME DATATYPE
			la_value = Time ( as_value ) 
END CHOOSE

return la_value
end function

public function integer of_getipaddress (ref string as_ipaddress);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetIPAddress
//
//	Access:  public
//
//	Arguments:		
//	ref string	as_IPAddress:
//
//	Returns:  integer
//
//	Description:  
// Gets Local host IP Address
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
long ll_return

as_IPADDress = space(255)
ll_return = GetLocalIPAddr(ref as_IPAddress)

/*
as_IPAddress = GetLocalIPAddr()
as_IPAddress = trim(as_IPAddress)
*/
if ll_Return = 1 then 
	return 1
else
	return -1
end if


end function

public function long of_fileread (readonly string as_filename, ref string as_data);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_FileRead
//	Arguments:		as_FileName				The name of the file to read.
//						as_Data				The data from the file, passed by reference.
//	Returns:			Long - The size of the blob read, returns -1 if an error occurrs.
//	Description:	Open, read into a string, and close a file.  Handles files > 32,765 bytes.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////

integer		li_FileNo, li_Reads, li_Cnt
long			ll_FileLen
string		ls_CurData

ll_FileLen = FileLength(as_FileName)

li_FileNo = FileOpen(as_FileName, StreamMode!, Read!)
If li_FileNo < 0 Then Return -1

// Determine the number of reads required to read the entire file
If ll_FileLen > 32765 Then
	If Mod(ll_FileLen, 32765) = 0 Then
		li_Reads = ll_FileLen / 32765
	Else
		li_Reads = (ll_FileLen / 32765) + 1
	End if
Else
	li_Reads = 1
End if

// Empty the string argument
as_Data = ls_CurData

// Read the file and build the string with data from the file
For li_Cnt = 1 to li_Reads
	If FileRead(li_FileNo, ls_CurData) = -1 Then
		Return -1
	Else
		as_Data = as_Data + ls_CurData
	End if
Next

FileClose(li_FileNo)


Return ll_FileLen


end function

public function date of_date (readonly string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Date
//
//	Access:  public  
//    
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  date
//	If as_datetime does not contain a valid datetime value, return date
//	is 1900-01-01.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a date
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04	Enhanced to handle to more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

date	ld_rc = 1900-01-01
long	ll_count
string	ls_datetime[]


// Check arguments
if IsNull (as_datetime) then
	SetNull (ld_rc)
	return ld_rc
end if

// Validate datetime string ("1/1/95", "1/1/95 8:00", "1/1/95 8:00 PM")
ll_count = of_ParseToArray (as_datetime, " ", ls_datetime)
if ll_count <= 0 or ll_count > 3 then
	return ld_rc
end if

// Date string passed in
if ll_count = 1 then
	return Date (as_datetime)
end if

// Datetime string passed in
if ll_count = 2 or ll_count = 3 then
	return Date (ls_datetime[1])
end if

return ld_rc


end function

public subroutine of_decomposetoarray (readonly string as_data, readonly string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_decomposeToArray
//
//	Access: 			public
//
//	Arguments: 		
// 	as_data 			string
//		as_delimiter	string
//		as_array[]		string
//
//	Returns:  		
//		none
//	Description:  
//		Splits the string and assigns the value to the array.
//
//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
long		ll_startPos = 1, ll_endPos = 1, ll_row = 1

ll_endPos 	= PosA(as_data, as_delimiter)

do while ll_endPos <> 0
	as_array[ll_row]  = 	MidA(as_data, ll_startPos, ll_endPos - ll_startPos)
	ll_startPos 		= 	ll_endPos + 1
	ll_endPos 			= 	PosA(as_data, as_DELIMITER, ll_startPos)
	ll_row ++
loop

as_array[ll_row] 		= 	MidA(as_data,ll_startPos)

end subroutine

public function integer of_getcolumntype (readonly string as_type);//
//	Function:  of_GetColumnType
//
//	Access:    public
//
//	Arguments:
//		string as_type	
//
//	Returns:  integer	
//	  The type of column
//
//	Description:  
//	  	Gets the type of column.  
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
int li_ret

choose case as_type   
	case 'char' 
		li_ret = 1    
	case 'number' 
		li_ret = 2
	case 'date'
		li_ret = 3
	case 'time'
		li_ret = 4
	case 'datetime'
		li_ret = 5
	case 'decimal'
		li_ret = 6
	case 'real'
		li_ret = 7
	case 'long'
		li_ret = 8
end choose
	
return li_ret
end function

public function integer of_getfilepath (ref string as_filepath, ref string as_filename, string as_filetype, readonly string as_dataobject, boolean ab_flag);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetFilePath
//
//	Access:  public
//
//	Arguments:		
//	ref string	as_filepath
//	ref string	as_filename
//	string	as_filetype
//	string	as_dataobject
//	boolean	ab_flag
//	Returns:  
//		1 if it success and -1 if error occurs
//
//	Description:  
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//
////////////////////////////////////////////////////////////////////////////////

STRING strPath, strWebPath
LONG nAddress, nRand

// get EAServer path
strPath = of_GetFilePath()
// strPath = "C:\Program Files\Sybase\EAServer" 

// Client 
strWebPath = ""
IF strPath <> "" THEN
	strWebPath = GetWebPath(strPath, REF nRand, REF nAddress)	
	FreeMemory(nAddress)
END IF

// Replace '/' with '\'
strPath = trim(strWebPath)
of_GlobalReplace(strPath, '/', '\', TRUE)

CHOOSE CASE Lower(as_filetype)
	CASE 'txt'
		as_filename = as_dataobject + "_" + String(nRand) + ".txt"
		DO WHILE FileExists(strPath + "\" + as_filename)
			as_filename = as_dataobject + "_" + String(Cpu()) + ".txt"
		LOOP
		IF strPath <> '' THEN
			as_filepath = strPath + "\" + as_filename
		ELSE
			as_filepath = as_filename
		END IF
	CASE 'wmf'
		IF strPath = '' THEN RETURN -1
		strPath += "\imagefile\"
		//if ls_path no exists ,create it
		if not DirectoryExists (strPath) then CreateDirectory (strPath)
		
		IF ab_flag THEN
			// only one wmf file

			as_filename = as_dataobject + "_" + String(nRand)
			DO WHILE FileExists(strPath + as_FileName + ".wmf")
				as_filename = as_dataobject + "_" + String(Cpu())
			LOOP
			as_filepath = strPath + as_filename
			
		ELSE
			// multi wmf file
			as_filename = as_dataobject + "_" + String(nRand)
			DO WHILE FileExists(strPath + as_filename + "_1.wmf") 
				as_filename = as_dataobject + "_" + String(Cpu())
			LOOP
			as_filepath = strPath + as_filename
		END IF
	CASE ELSE
		Return -1
END CHOOSE

Return 1


end function

public function integer of_getpbchanges (readonly string as_xml, ref str_a astr_obj);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetPBChanges
//
//	Access:  public
//
//	Arguments:		
//	string	as_xml
//	ref str_a	astr_obj
//
//	Returns:  integer
//	Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:  
// Parses the string and converts the string information into relevant structure.  
//	In the first part of the string, every eight bytes refer to the length of a section
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
integer li_i
long ll_Start[],ll_Len[]
string	ls_temp


for li_i = 1 to I_STRA_COUNT
	ls_temp = MidA(as_xml,li_i*8 - 7,8)	
	
	//convert hex to dec
	ll_len[li_i] = StringToInt(ls_temp)
	
	
	if li_i = 1 then
		ll_Start[1] = 8*I_STRA_COUNT + 1
	else
		ll_Start[li_i] = ll_Start[li_i - 1] + ll_Len[li_i - 1]
	end if
next


astr_obj.s_type = MidA(as_xml,ll_Start[1],ll_len[1])
astr_obj.s_dataobject = MidA(as_xml,ll_Start[2],ll_len[2])
astr_obj.s_pbsyntax = MidA(as_xml,ll_Start[3],ll_len[3])
astr_obj.s_matchtype = MidA(as_xml,ll_Start[4],ll_len[4])
astr_obj.l_SetCount = long(MidA(as_xml,ll_Start[5],ll_len[5])) - 1
astr_obj.s_rowset = MidA(as_xml,ll_Start[6],ll_len[6])

//primary
astr_obj.s_pdata = MidA(as_xml,ll_Start[7],ll_len[7])
astr_obj.s_pstate = MidA(as_xml,ll_Start[8],ll_len[8])
astr_obj.s_pflag = MidA(as_xml,ll_Start[9],ll_len[9])

//filter
astr_obj.s_fdata = MidA(as_xml,ll_Start[10],ll_len[10])
astr_obj.s_fstate = MidA(as_xml,ll_Start[11],ll_len[11])
astr_obj.s_fflag = MidA(as_xml,ll_Start[12],ll_len[12])

//delete
astr_obj.s_ddata = MidA(as_xml,ll_Start[13],ll_len[13])
astr_obj.s_dstate = MidA(as_xml,ll_Start[14],ll_len[14])
astr_obj.s_dflag = MidA(as_xml,ll_Start[15],ll_len[15])

//web syntax
astr_obj.s_fullstate = MidA(as_xml,ll_Start[16],ll_len[16])

return 1
end function

public function integer of_getpbchanges (readonly string as_xml, ref str_b astr_obj, readonly string as_type);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_GetPBChanges
//
//	Access:  public
//
//	Arguments:		
//	astr_obj.	as_xml
//	ref str_b	astr_obj
//	string 		as_type:B or C
//
//	Returns:  integer
//	Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:  
// Parses the string and converts the string information into relevant structure.  
//	In the first part of the string, every eight bytes refer to the length of a section
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
integer li_i,ll_count
long ll_Start[],ll_Len[]
string	ls_temp
boolean lb_c

lb_c = ('43' = as_type or 'C' = Upper(as_type))
if lb_c then
	ll_count = I_STRC_COUNT
else
	ll_count = I_STRB_COUNT
end if

for li_i = 1 to ll_count
	ls_temp = MidA(as_xml,li_i*8 - 7,8)	
	
	//convert hex to dec
	ll_len[li_i] = StringToInt(ls_temp)
	
	if li_i = 1 then
		ll_Start[1] = 8*ll_count + 1
	else
		ll_Start[li_i] = ll_Start[li_i - 1] + ll_len[li_i - 1]
	end if
next

astr_obj.s_type = MidA(as_xml,ll_Start[1],ll_len[1])
astr_obj.s_dataobject = MidA(as_xml,ll_Start[2],ll_len[2])
astr_obj.s_fullstate = MidA(as_xml,ll_Start[3],ll_len[3])

if lb_c then
	astr_obj.s_url = MidA(as_xml,ll_Start[4],ll_len[4])
	astr_obj.i_count = long(MidA(as_xml,ll_Start[5],ll_len[5]))
	astr_obj.s_sql = MidA(as_xml,ll_Start[6],ll_len[6])
	astr_obj.s_filter = MidA(as_xml,ll_Start[7],ll_len[7])
	astr_obj.s_sort = MidA(as_xml,ll_Start[8],ll_len[8])
end if

return 1
end function

public function long of_parsetoarray (readonly string as_source, readonly string as_delimiter, ref string as_array[]);//////////////////////////////////////////////////////////////////////////////
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

public function dwitemstatus of_statusfromcode (readonly string as_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_statusfromcode
//
//	Access:  public
//
//	Arguments:		
//	string	as_status
//
//	Returns:  DWItemStatus
//
//
//	Description:  
// Gets the DWItemStatus from code
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
//0-notmodified;1-datamodified;2-new;3-newmodified
dwitemstatus	ldwi_null

choose case as_status
	case '1'
		return DataModified!
	case '3'
		return NewModified!
	case '2'
		return New!
	case '0'
		return NotModified!
	case else
		SetNull(ldwi_null)
		return ldwi_null
end choose
end function

public function string of_statustocode (readonly dwitemstatus adw_status);////////////////////////////////////////////////////////////////////////////////
//	Function :  of_StatusToCode
//
//	Access:  public
//
//	Arguments:		
//	DWItemStatus adw_status
//
//	Returns:  string
//
//
//	Description:  
// Gets the code from DWItemStatus
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//	
////////////////////////////////////////////////////////////////////////////////
//
//	Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////
//0-notmodified;1-datamodified;2-new;3-newmodified
string ls_null

choose case adw_status
	case DataModified!
		return '1'
	case NewModified!
		return '3'
	case New!
		return '2'
	case NotModified!
		return '0'
	case else
		SetNull(ls_null)
		return ls_null
end choose
end function

public function time of_time (readonly string as_datetime);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Time
//
//	Access:  public
//
//	Arguments:
//	as_datetime   Datetime value as a string
//
//	Returns:  time
//	If as_datetime does not contain a valid datetime value, return time
//	is 00:00:00.000000.  If as_datetime is NULL, function returns NULL.
//
//	Description:
//	Converts a string whose value is a valid datetime to a time value
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.02   Initial version
// 5.0.04 	Enhanced to handle more cases.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

time	ltm_rc = 00:00:00.000000
long	ll_count
string	ls_datetime[]


// Check arguments
if IsNull (as_datetime) then
	SetNull (ltm_rc)
	return ltm_rc
end if

// Validate datetime string
ll_count = of_ParseToArray (as_datetime, " ", ls_datetime)
if ll_count <= 0 or ll_count > 3 then
	return ltm_rc
end if

// Date string passed in ("8:00pm")
if ll_count = 1 then
	return Time (as_datetime)
end if

// Datetime string passed in ("1/1/95 8:00pm")
if ll_count = 2 then
	return Time (ls_datetime[2])
end if

// Datetime string passed in ("1/1/95 8:00 pm")
if ll_count = 3 then
	return Time (ls_datetime[2]+' '+ls_datetime[3])
end if

return ltm_rc
end function

public subroutine of_globalreplace (ref string as_source, string as_old, readonly string as_new, boolean ab_ignorecase);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GlobalReplace
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Old			The old string being replaced.
//	as_New			The new string.
// ab_IgnoreCase	A boolean stating to ignore case sensitivity.
//
//	Returns:  		string
//						as_Source with all occurrences of as_Old replaced with as_New.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Replace all occurrences of one string inside another with
//						a new string.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 2000-2006 appeon, Inc. and its subsidiaries.  All rights reserved.
//////////////////////////////////////////////////////////////////////////////

Long	ll_Start
Long	ll_OldLen
Long	ll_NewLen
String ls_Source

//Check parameters
If IsNull(as_source) or IsNull(as_old) or IsNull(as_new) or IsNull(ab_ignorecase) Then
	string ls_null
	SetNull(ls_null)
	as_source = ls_null
	return 
End If

//Get the string lenghts
ll_OldLen = LenA(as_Old)
ll_NewLen = LenA(as_New)

//Should function respect case.
If ab_ignorecase Then
	as_old = Lower(as_old)
	ls_source = Lower(as_source)
Else
	ls_source = as_source
End If

//Search for the first occurrence of as_Old
ll_Start = PosA(ls_Source, as_Old)

Do While ll_Start > 0
	// replace as_Old with as_New
	as_Source = ReplaceA(as_Source, ll_Start, ll_OldLen, as_New)
	
	//Should function respect case.
	If ab_ignorecase Then 
		ls_source = Lower(as_source)
	Else
		ls_source = as_source
	End If
	
	// find the next occurrence of as_Old
	ll_Start = PosA(ls_Source, as_Old, (ll_Start + ll_NewLen))
Loop

end subroutine

on appeonservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeonservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

