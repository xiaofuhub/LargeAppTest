$PBExportHeader$n_cst_appeondll.sru
forward
global type n_cst_appeondll from nonvisualobject
end type
end forward

global type n_cst_appeondll from nonvisualobject autoinstantiate
end type

type prototypes
Function int GetRegistryKeys(string key,ref string subkeys[]) library 'appeondll.dll' alias for "GetRegistryKeys;Ansi"
Function int GetRegistryValues(string key,ref string values[]) library 'appeondll.dll' alias for "GetRegistryValues;Ansi"
Function int GetRegValue(string key,string valuename,ulong dtype, ref string value1) library 'appeondll.dll' alias for "GetRegValue;Ansi"
Function int SetRegValue(string key,string valuename, ulong datatype, string value1) library 'appeondll.dll' alias for "SetRegValue;Ansi"
Function int DeleteRegKey(string key, string valueName)  library 'appeondll.dll' alias for "DeleteRegKey;Ansi"
Function int GetRegKeyInfo(string key,ref long subKeyCount,ref long maxKey,ref long valueCount,ref long maxvalue,ref long maxvlauesize) library 'appeondll.dll' alias for "GetRegKeyInfo;Ansi"

Function int BeepMsg(int n) library 'appeondll.dll'
Function int GetFonts(ref string fonts[]) library 'appeondll.dll' alias for "GetFonts;Ansi"
//Function int AdjustToolBarPos(ulong hwnd) library 'appeondll.dll'
Function int AdjustToolBarPos(ulong hwnd) library 'appeondll.dll'
Function int SetToolBarEx(ulong hwnd, uint id, uint visible) library 'appeondll.dll' //Modify by Evan 08.21.2009
Function long InitToolBarBandID(long al_WndMDI) library "appeondll.dll" //alfee 04.29.2010

function int of_encrypt(string ls_str, string ga , int li_val , ref string enstr) library "appeondll.dll" alias for "of_encrypt;Ansi"
function int of_decrypt(string ls_str, string ga , int li_val , ref string enstr) library "appeondll.dll" alias for "of_decrypt;Ansi"


Function long ClientToScreen (long hwnd , ref POINTAPI lpPoint) Library "user32" alias for "ClientToScreen;Ansi" 
Function long GetWindowRect (long hwnd , ref rect lpRect) Library "user32" alias for "GetWindowRect;Ansi" 

function int ChangeEditStyle(ref string syntax, string cols[], int colscount,int targettype) library "appeondll.dll" alias for "ChangeEditStyle;Ansi"

function int Output(string dbfname, string datafile, string tablename)  library "readdbf.dll" alias for "Output;Ansi"
function long ConvertDbf2Txt(string as_DBFFile, string as_TxtFile) library "appeondll.dll" alias for "ConvertDbf2Txt;Ansi" //Evan 12/13/2011

//Paste the file from clipboard
function long PasteFromclipboard(string filePath, ref string fileName) library "appeondll.dll" alias for "PasteFromclipboard;Ansi" //"ConvertPDF.dll" //Modify by Evan 10/08/2008

//encrypt sql file
FUNCTION long EncryptSql(string inPath, string inName,string outPath,boolean bEncrypt) LIBRARY "appeondll.dll" alias for "EncryptSql;Ansi" //"ConvertPDF.dll" //Modify by Evan 10/08/2008

//Auto close save HTML dialog
FUNCTION long AutoCloseSaveHTMLDlg(string as_FileName, long	al_Flags) LIBRARY "appeondll.dll" alias for "AutoCloseSaveHTMLDlg;Ansi" //Modify by Evan 04.16.2010

//Get file save name
FUNCTION long GetFileSaveNameEx(string as_Title, ref string as_File, ref long al_FilterIndex, string as_Filter, string as_InitDir, long al_Flags) LIBRARY "appeondll.dll" alias for "GetFileSaveNameEx;Ansi" //Add by Evan 05.10.2010

FUNCTION long BringTopMergeFieldDlg(long al_Flags) LIBRARY "appeondll.dll" //add by Kater 03.28.2011

// Profile string
function long GetPrivateProfileString(string lpAppName, string lpKeyName, string lpDefault, ref string lpReturnedString, long nSize, string lpFileName) library "Kernel32.dll" alias for "GetPrivateProfileStringW" //Add by Evan 10.09.2011
function long WritePrivateProfileString(string lpAppName, string lpKeyName, string lpString, string lpFileName) library "Kernel32.dll" alias for "WritePrivateProfileStringW" //Add by Evan 10.09.2011

//alfee 03.26.2014
function ulong RegOpenKeyEx( ulong hkey, string subkey, ulong uloptions, long samdesired, ref long result ) library "Advapi32.dll"  alias for "RegOpenKeyExW"
function long RegQueryValueEx( long hkey, string lpvaluename, long lpReserved, ref long lptype, ref string lpdata, ref long lpcbdata ) library "Advapi32.dll" alias for "RegQueryValueExW"
function long  RegCloseKey ( Long hkey )    Library "advapi32.dll" Alias for "RegCloseKey" 

end prototypes

type variables
constant int MAX_ARRAY_LENGTH  = 500
constant int MAX_KEY_LENGTH    = 256
constant int MAX_VALUE_SIZE    = 16383
constant int MAX_FONT_NUMBER   = 1000
constant int MAX_FONTNAME_SIZE = 100
end variables

forward prototypes
public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, string value)
public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, unsignedlong value)
public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, blob value)
public function integer of_registrykeys (string key, ref string subkeys[])
public function integer of_registryvalues (string key, ref string valuenames[])
public function integer of_registryget (string key, string valuename, ref string value)
public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string value)
public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref unsignedlong value)
public function integer of_getfonts (ref string fontnames[])
public function integer of_settoolbarpos (unsignedlong hwnd)
public subroutine of_beep (integer n)
public function integer of_registrydelete (string key, string valuename)
public function integer of_getwindowrect (long hwnd, ref rect a_rect)
public function integer of_settoolbar (long al_handle, integer ai_id, boolean ab_visible)
public function integer of_changeeditstyle (ref string as_syntax, string as_cols[], long al_ccount, long al_type)
public subroutine of_parsepath (string as_filepath)
public function long of_output (string as_dbffile, string as_datafile, string as_tablename)
public function integer of_pastefromclipboard (string as_filepath, ref string as_filename)
public function integer of_autoclosesavehtmldlg (string as_filename, long al_flags)
public function integer of_inittoolbarbandid (long al_wndmdi)
public function integer of_getfilesavename (string as_title, ref string as_pathname, ref long al_filterindex, string as_filter, string as_initdir)
public function integer of_bringtopmergefielddlg (long al_flags)
public function integer of_setprofilestring (string as_filename, string as_section, string as_key, string as_value)
public function string of_profilestring (string as_filename, string as_section, string as_key, string as_default)
public function long of_convertdbf2txt (string as_dbffile, string as_txtfile)
public function integer of_open_file (string as_filename, string as_message)
public subroutine of_open_file (string as_filename, boolean ab_prompty)
public function integer of_registerget64 (string as_subkey, string as_keyname, ref string as_value)
end prototypes

public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, string value);int li_type
choose case valuetype
	case RegString!
		li_type = 1
	case ReguLong!
		li_type = 4
	case RegBinary!
		li_type = 3
	case else
		return -1
end choose		

return SetRegValue(key, valuename, li_type, value)
end function

public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, unsignedlong value);string ls_value

ls_value = string(value)

return of_registryset(key, valuename, valuetype, ls_value)
end function

public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, blob value);string ls_value
ls_value = string(value )

return of_registryset(key, valuename, valuetype, ls_value)
end function

public function integer of_registrykeys (string key, ref string subkeys[]);long subKeyCount
long maxKey
long valueCount
long maxvalue
long maxvlauesize
int  li_rtn
int  i

li_rtn = GetRegKeyInfo(key, subKeyCount, maxKey, valueCount, maxvalue, maxvlauesize)

if li_rtn = 1 then
	for i = 1 to subKeyCount
		subkeys[i] = space(maxKey)
	next
	if GetRegistryKeys(key, subkeys) <> 1 then return -1
else
	return -1
end if

return 1


end function

public function integer of_registryvalues (string key, ref string valuenames[]);long subKeyCount
long maxKey
long valueCount
long maxvalue
long maxvlauesize
int  li_rtn
int  i

li_rtn = GetRegKeyInfo(key, subKeyCount, maxKey, valueCount, maxvalue, maxvlauesize)

if li_rtn = 1 then
	for i = 1 to subKeyCount
		valuenames[i] = space(maxvalue)
	next
	if GetRegistryKeys(key, valuenames) <> 1 then return -1
else
	return -1
end if

return 1

end function

public function integer of_registryget (string key, string valuename, ref string value);return of_registryget(key, valuename, RegString!, value)
end function

public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string value);//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
/*

/*
ulong dtype

choose case valuetype
	case RegString!
		dtype = 1
	case ReguLong!
		dtype = 4
	case else
		return -1
end choose

value = space(MAX_VALUE_SIZE)

if GetRegValue(key, valuename, dtype, value) <> 1 then 
	value = ""
	return -1
end if
*/
RegistryGet(key,valuename, valuetype, value)
return 1
*/

//Modified By Ken.Guo 03/14/2014
ulong dtype

choose case valuetype
	case RegString!
		dtype = 1
	case ReguLong!
		dtype = 4
	case else
		//return -1
end choose

value = space(MAX_VALUE_SIZE)

if GetRegValue(key, valuename, dtype, value) <> 1 then 
	value = ""
	//return -1
end if

If value = "" or value = space(MAX_VALUE_SIZE) Then //Added By Ken.Guo 03/14/2014
	RegistryGet(key,valuename, valuetype, value)
End If

return 1
//---------End Modfiied ------------------------------------------------------


end function

public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref unsignedlong value);string ls_value
long   ll_rtn
ll_rtn = of_registryget(key, valuename, ReguLong!, ls_value)
value = long(ls_value)
return ll_rtn


end function

public function integer of_getfonts (ref string fontnames[]);int i
string ls_dummy[]

for i = 1 to 10000 // Evan 08.31.2010 --- change 1000 into 10000
	fontnames[i] = space(200) // Evan 08.31.2010 --- change 100 into 200
next
//---------Begin Modified by (Appeon)Toney 06.05.2013 for V141 ISG-CLX--------
  /*
     if GetFonts(fontnames) <> 1 then
		fontnames = ls_dummy
	end if 
  */
 Try
	if GetFonts(fontnames) <> 1 then
		fontnames = ls_dummy
	end if
Catch (RuntimeError E1)
	fontnames = ls_dummy
End Try
//---------End Modfiied ------------------------------------------------------------------



return 1
end function

public function integer of_settoolbarpos (unsignedlong hwnd);
return AdjustToolBarPos(hwnd)
end function

public subroutine of_beep (integer n);
BeepMsg(n)


end subroutine

public function integer of_registrydelete (string key, string valuename);
return DeleteRegKey(key, valuename)
end function

public function integer of_getwindowrect (long hwnd, ref rect a_rect);long	ll_rtn
rect	l_rect

ll_rtn  = getwindowrect(hwnd , l_rect)

a_rect = l_rect

return ll_rtn
end function

public function integer of_settoolbar (long al_handle, integer ai_id, boolean ab_visible);uint lu_visible
int li_rtn 

//Convert boolean to uint
if ab_visible then
	lu_visible = 1
else
	lu_visible = 0
end if

//Call DLL
li_rtn = SetToolBarEx(al_handle, ai_id , lu_visible); //Modify by Evan 08.21.2009

//Return 1 if successful, or -1 otherwise.
return li_rtn 
end function

public function integer of_changeeditstyle (ref string as_syntax, string as_cols[], long al_ccount, long al_type);long li_rtn
//al_type . 1 : DDDW , 2: EditMask
li_rtn = ChangeEditStyle(as_syntax , as_cols , al_ccount , al_type)

return li_rtn

end function

public subroutine of_parsepath (string as_filepath);string	ls_filepath , ls_tempPath  , ls_path
long		ll_pos

n_cst_filesrvwin32  lnv_filesvr
If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32

If lnv_filesvr.of_directoryexists( as_filepath) Then return
	
ls_filepath = as_filepath
ll_pos = PosA(ls_filepath , '\')
ls_tempPath = ''

Do While ll_pos > 0
	ls_tempPath = LeftA(ls_filepath , ll_pos)
	ls_path     = ls_path + ls_tempPath 
	ls_filepath = MidA(ls_filepath , ll_pos + 1)
	If MidA(ls_tempPath,2,1) = ':' Then 
		ll_pos = PosA(ls_filepath , '\')
		continue
	End If
	
	If not lnv_filesvr.of_directoryexists( ls_path) Then
		lnv_filesvr.of_createdirectory( ls_path)
	End If
	
	ll_pos = PosA(ls_filepath , '\')
Loop
//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
//$Reason:To prevent creating a directory with a file name
  /*
     If LenA(ls_filepath) > 0 Then 
  */
 If len(ls_filepath) > 0  and pos(ls_filepath,".") = 0 Then // jervis 07.22.2009
//---------End Modfiied ------------------------------------------------------------------
	ls_path     = ls_path + ls_filepath 
	If not lnv_filesvr.of_directoryexists( ls_path) Then
		lnv_filesvr.of_createdirectory( ls_path)
	End If
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lnv_filesvr) then Destroy lnv_filesvr
//---------------------------- APPEON END ----------------------------
end subroutine

public function long of_output (string as_dbffile, string as_datafile, string as_tablename);
//Output the data from the 'as_dbffile' into the 'as_datafile' file
long ll_rtn , i
n_cst_string_appeon lnv_string
string	ls_paths[] , ls_path

lnv_string.of_parsetoarray(as_dbffile , '\' , ls_paths)

For i = 1 to upperbound(ls_paths) - 1
	ls_path = ls_path + ls_paths[i] + "\\"
Next

ll_rtn = Output(ls_path, as_datafile, as_tablename)

return ll_rtn

end function

public function integer of_pastefromclipboard (string as_filepath, ref string as_filename);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_pastefromclipboard
//
//	Access:  			public
//
//	Arguments:
//	as_filepath			A local folder where to store the file pasted from clipboard.
//	as_filename  	   reference value.A string value return the file name in clipboard
//
//	Returns:  			integer  1:Sucessed, -1: Unsupport format, -2:Clipboard is empty, -3:Unkonw error, -4:Copy Failed
//
//	Description:
//	
//	
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	7.0   Initial version
////////////////////////////////////////////////////////////////////////////////
//Added for paste document from clipboard 1/13/2007 @Henry
Long ll_rtn

as_filename = space(256)

ll_rtn = PasteFromclipboard(as_filepath , as_filename)

Choose Case ll_rtn
	Case -1
		Messagebox("Information","Failed to paste file from Clipboard. Please make sure you have copied a valid document to Clipboard.")
	Case -2
		Messagebox("Information","Clipboard is empty. Please make sure you have copied a valid document to Clipboard.")
	Case -3
		//Messagebox("Information","Unknow error when pasting from Clipboard.")
		Messagebox("Information","Unknown error when pasting from Clipboard.")
	Case -4
		Messagebox("Information","Failed to paste file from Clipboard.")
End Choose

Return ll_rtn
end function

public function integer of_autoclosesavehtmldlg (string as_filename, long al_flags);//////////////////////////////////////////////////////////////////////
// $<function> of_autoclosesavehtmldlg
// $<arguments>
//			string	as_filename
//			long		al_flags
//                0-Terminate thread
//                1-Click save button
//                2-Do not click save button
// $<returns> integer
// $<description> Auto close save HTML dialog
//////////////////////////////////////////////////////////////////////
// $<add> Evan 08.14.2009
//////////////////////////////////////////////////////////////////////

AutoCloseSaveHTMLDlg(as_FileName, al_Flags) //Modify by Evan 04.16.2010 - add al_Flags argument

Return 1
end function

public function integer of_inittoolbarbandid (long al_wndmdi);//initialize toolbars - alfee 04.29.2010

InitToolBarBandID(al_WndMDI)

Return 1
end function

public function integer of_getfilesavename (string as_title, ref string as_pathname, ref long al_filterindex, string as_filter, string as_initdir);//////////////////////////////////////////////////////////////////////
// $<function> of_getfilesavename
// $<arguments>
//			string		as_title
//			ref string	as_pathname
//			ref long		al_filterindex
//			string		as_filter
//			string		as_initdir
// $<returns> integer
//			Returns 1 if it succeeds, 0 if the user clicks the Cancel
//			button or Windows cancels the display.
// $<description> Get file save name
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.10.2010
//////////////////////////////////////////////////////////////////////

long ll_Return
long ll_Index
string ls_File

if IsNull(as_Title) then as_Title = ""
if IsNull(as_InitDir) then as_InitDir = ""

// Initialize file name buffer
if IsNull(as_PathName) then
	ls_File = Space(255)
else
	ls_File = as_PathName + Space(255)
end if

// Get filter parameters
if LenA(as_Filter) > 0 then
	as_Filter += ","
else
	as_Filter = ""
end if
ll_Index = al_FilterIndex
al_FilterIndex = 0

// Open file save dialog
GetFileSaveNameEx(as_Title, ls_File, ll_Index, as_Filter, as_InitDir, 0)

// Get dialog return value
ll_Return = GetFileSaveNameEx(as_Title, ls_File, ll_Index, as_Filter, as_InitDir, 1)
if ll_Return = 1 then
	as_PathName = ls_File
	al_FilterIndex = ll_Index
	Return 1
end if

Return 0
end function

public function integer of_bringtopmergefielddlg (long al_flags);//////////////////////////////////////////////////////////////////////
// $<function> of_bringtopmergefielddlg
// $<arguments>
//               long al_flags
// $<returns> 1 
// $<description> Bring to Top dialog "Invalid Merge Field"
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Kater 03.28.2011
//////////////////////////////////////////////////////////////////////

BringTopMergeFieldDlg(al_flags)

return 1
end function

public function integer of_setprofilestring (string as_filename, string as_section, string as_key, string as_value);//////////////////////////////////////////////////////////////////////
// $<function> of_setprofilestring
// $<arguments>
//		string	as_filename
//		string	as_section
//		string	as_key
//		string	as_value
// $<returns> integer
// $<description> Write ini file
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.09.2011
//////////////////////////////////////////////////////////////////////

integer li_Result

if IsNull(as_FileName) or IsNull(as_Section) or IsNull(as_Key) or IsNull(as_Value) then
	SetNull(li_Result)
	Return li_Result
end if

if not FileExists(as_FileName) then
	Return -1
end if

li_Result = WritePrivateProfileString(as_Section, as_Key, as_Value, as_FileName)
if li_Result = 1 then
	Return 1
else
	Return -1
end if
end function

public function string of_profilestring (string as_filename, string as_section, string as_key, string as_default);//////////////////////////////////////////////////////////////////////
// $<function> of_profilestring
// $<arguments>
//		string	as_filename
//		string	as_section
//		string	as_key
//		string	as_default
// $<returns> string
// $<description> Read ini file
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.09.2011
//////////////////////////////////////////////////////////////////////

string ls_Value

if IsNull(as_FileName) or IsNull(as_Section) or IsNull(as_Key) or IsNull(as_Default) then
	SetNull(ls_Value)
	Return ls_Value
end if

ls_Value = Space(4096)
GetPrivateProfileString(as_Section, as_Key, as_Default, ls_Value, 4096, as_FileName)

Return ls_Value
end function

public function long of_convertdbf2txt (string as_dbffile, string as_txtfile);//////////////////////////////////////////////////////////////////////
// $<function> of_convertdbf2txt
// $<arguments>
//			string	as_dbffile
//			string	as_txtfile
// $<returns> long
// $<description> Convert dbf to text
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.13.2011
//////////////////////////////////////////////////////////////////////

long ll_RowCount

ll_RowCount = ConvertDbf2Txt(as_DBFFile, as_TxtFile)

Return ll_RowCount
end function

public function integer of_open_file (string as_filename, string as_message);//====================================================================
//$<Function>: of_open_file
//$<Arguments>:
// 	value    string    as_filename
// 	value    string    as_message
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If Messagebox('Open',as_message,Question!,Yesno!) = 1 Then
	of_open_file(as_filename,False)
	Return 1
Else
	Return 0
End If

Return 0
end function

public subroutine of_open_file (string as_filename, boolean ab_prompty);//////////////////////////////////////////////////////////////////////
// $<function>of_open_file()
// $<arguments>
//		value	string	as_filename	
//		value boolean 	ab_prompty
// $<returns> (none)
// $<description>
// $<description> Open the file.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-13 by Ken.Guo
//(Appeon)Toney 06.06.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

String ls_null
Setnull(ls_null)

If Not FileExists(as_filename) Then Return

If ab_prompty Then
	If Messagebox('Open','Would you like to open the file now?',Question!,Yesno!) = 1 Then
		ShellExecuteA ( Handle( w_mdi ), "open", as_filename , ls_Null, ls_Null, 1)
	End If
Else
	ShellExecuteA ( Handle( w_mdi ), "open", as_filename , ls_Null, ls_Null, 1)
End If
end subroutine

public function integer of_registerget64 (string as_subkey, string as_keyname, ref string as_value);//====================================================================
//$<Function>: of_registerget64()
//$<Arguments>:
// 	value    string    as_subkey
// 	value    string    as_keyname
//  reference    string    as_value
//$<Return>:  integer
//$<Description>: The PB registryget fun may not work for the keys under HKEY_LOCAL_MACHINE on 64 bit OS 
//$<Description>: as the limit of Win 7 UAC.  This fun is for keys under HKEY_LOCAL_MACHINE and 64 bit OS only.
//$<Author>: (Appeon) Alfee 03.26.2014
//-------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long handle, lptype, resultsize
long hk_machine = 2147483650
string	keyname, subkey, result 

result = space( 1024 )
resultsize = 1024
lptype = 0

subkey = as_subkey // like "SOFTWARE\AFPL Ghostscript\8.53"
keyname =  as_keyname // like "GS_DLL"

RegOpenKeyEx( hk_machine, subkey, 0,257, ref  handle ) //257 - KEY_WOW64_64KEY (0x0100) + KEY_QUERY_VALUE (0x0001)

RegQueryValueEx( handle, keyname , 0, ref lptype,ref result , ref resultsize )

as_value = result

RegCloseKey( handle )

Return 0
end function

on n_cst_appeondll.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_appeondll.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

