$PBExportHeader$n_cst_filesrv.sru
$PBExportComments$Extension File handler service
forward
global type n_cst_filesrv from pfc_n_cst_filesrv
end type
end forward

global type n_cst_filesrv from pfc_n_cst_filesrv
end type
global n_cst_filesrv n_cst_filesrv

type prototypes
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
// HANDLE GetProcessHeap(VOID); 
// obtains a handle to the heap of the calling process 
Function ulong GetProcessHeap() Library "KERNEL32.DLL" 

// LPVOID HeapAlloc(HANDLE hHeap, DWORD dwFlags, DWORD dwBytes); 
// allocates a block of memory from a heap 
Function ulong HeapAlloc (ulong hMem, uint uFlags, ulong uBytes) Library "KERNEL32.DLL"
 
// BOOL HeapFree(HANDLE hHeap, DWORD dwFlags, LPVOID lpMem); 
// frees a memory block allocated from a heap 
Function long HeapFree (ulong hMem, uint uFlags, ulong uMemPoint) Library "KERNEL32.DLL"
 
// LPTSTR lstrcpy(LPTSTR lpString1, LPCTSTR lpString2); 
// copies a string to a buffer 
Function ulong lstrcpy (REF string lpString1, ulong lpString2) Library "KERNEL32.DLL" alias for "lstrcpy;Ansi"
 
// VOID MoveMemory (PVOID Destination, CONST VOID *Source, SIZE_T Length); 
// moves a block of memory from one location to another 
Subroutine MoveMemory (REF string sbytes, ulong lpbytes, ulong uLen) library "KERNEL32.DLL" alias for "RtlMoveMemory;Ansi"
 
// DWORD GetFileVersionInfoSize( LPTSTR lptstrFilename, LPDWORD lpdwHandle); 
// returns the size, in bytes, of version information about a specified file 
Function long GetFileVersionInfoSize (string sFile, REF ulong uDummy) library "VERSION.DLL" alias for "GetFileVersionInfoSizeA;Ansi"
 
// BOOL GetFileVersionInfo(LPTSTR lptstrFilename,DWORD dwHandle, DWORD dwLen, LPVOID lpData);
 // returns version information about a specified file 
Function long GetFileVersionInfo (REF string sFile, ulong uDummy, ulong uLen, ulong uPoint) library "VERSION.DLL" alias for "GetFileVersionInfoA;Ansi"
 
// BOOL VerQueryValue( const LPVOID pBlock, LPTSTR lpSubBlock, LPVOID *lplpBuffer, PUINT puLen);
 // returns selected version information from the specified version-information resource
 Function long VerQueryValue (ulong uPoint, string sValue, REF ulong uPoint, REF ulong uLen) library "VERSION.DLL" alias for "VerQueryValueA;Ansi"
 
 Function Long GetFileVer (string sFile,REF String sValue) library "Appeondll.DLL" alias for "GetFileVer;Ansi"
//---------End Added ------------------------------------------------------------------

end prototypes

forward prototypes
public function integer of_filesaveas (string as_sourcefile, boolean ab_open)
public subroutine of_runfile (string as_filename)
public function long of_genfilesize (long al_size, ref string as_unit)
public function string of_getfileinfo (string as_filename, string as_filepropertiesname)
public function string of_getfiletypedes (string as_filename)
public function string of_getfileversion (string as_filename)
end prototypes

public function integer of_filesaveas (string as_sourcefile, boolean ab_open);//====================================================================
//$<Function>: of_filesaveas
//$<Arguments>:
// 	value    string     as_sourcefile
// 	value    boolean    ab_open
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_path, ls_file,ls_ext,ls_filetype
int li_rc,li_pos

gf_load_dir_path()

li_pos = lastpos(as_sourcefile,'.')
If li_pos > 0 Then
	ls_ext = Mid(as_sourcefile,li_pos + 1,len(as_sourcefile) )
	If ls_ext = '' Then ls_ext = '*'
Else
	ls_ext = '*'
End If

If ls_ext = '*' Then
	ls_filetype = 'All'
Else
	ls_filetype = Upper(ls_ext)
End If

ls_file = Mid(as_sourcefile,LastPos(as_sourcefile,'\') + 1,Len(as_sourcefile))
ls_path = GetCurrentDirectory ( ) + '\' + ls_file

li_rc = GetFileSaveName ( "Select File", ls_path, ls_file, ls_ext, &
	      ls_filetype + " Files (*." + Upper(ls_ext) + "),*."+ Upper(ls_ext) )

gf_save_dir_path(ls_path)

IF li_rc <> 1 Then Return 0

If FileExists(ls_path) Then
	If Messagebox('Confirm Save As',ls_file + ' already exists. ~r~nDo you want to replace it?',Question!,YesNo!) = 2 Then Return 0
End If

If FileCopy(as_sourcefile,ls_path,True) <> 1 Then
	Messagebox('Save As','Failed to save it. ')
	Return 1
End If

If ab_open Then
	This.of_runfile(ls_path)
End If

Return 1

end function

public subroutine of_runfile (string as_filename);//====================================================================
//$<Function>: of_runfile
//$<Arguments>:
// 	value    string    as_filename
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_ext,ls_null

If lastpos(as_filename,'.') > 0 Then
	ls_ext = Mid(as_filename,lastpos(as_filename,'.') + 1, Len(as_filename) )
End If

Setnull(ls_null)
Choose Case Upper(ls_ext)
	Case 'HTML','HTM'	
		//ShellExecuteA ( Handle( w_mdi ), "open", 'IEXPLORE', as_filename , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA ( Handle( w_mdi ), "open", of_getbrowserversion( ), as_filename, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	Case Else
		ShellExecuteA ( Handle( w_mdi ), ls_Null, as_filename , ls_Null, ls_Null, 4)
End Choose

end subroutine

public function long of_genfilesize (long al_size, ref string as_unit);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_filesrv.of_genfilesize()
// $<arguments>
//		value    	long	al_size		
//		reference	string  	as_unit		
// $<returns> long
// $<description> Return the size and unit. for display attachment's size&unit.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-13 by Ken.Guo
////$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Decimal ldec_size
as_unit = ' KB'
ldec_size = al_size / 1024
If ldec_size >= 1000 Then
	ldec_size = ldec_size/1024
	as_unit = ' MB'
End If
Return Ceiling(ldec_size)
end function

public function string of_getfileinfo (string as_filename, string as_filepropertiesname);//////////////////////////////////////////////////////////////////////
// Function: of_getfileinfo
// Arguments:
// 	as_filename					file path and name
//  as_filepropertiesname    file properties name : FileVersion,CompanyName, FileDescription, InternalName, 
// 																LegalCopyright,	ProductName or ProductVersion
//--------------------------------------------------------------------
// Return:  string
//--------------------------------------------------------------------
// Author:	 Ken.Guo 09/27/2011.
//--------------------------------------------------------------------
// Description: Get File Properties 
//--------------------------------------------------------------------
//$<Modify History>:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////


//Warning!!!   WEB Not Support This function.  reason: MoveMemory


string  ls_query, ls_version, ls_langcodepage, ls_bytes = space(256) 
ulong ll_dummy, ll_size, hMem, lpInfo, lpPoint, ll_len 
long ll_ret 
int i, arr_int[4] 
char arr_hex[16] = {'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'}
 
// e.g. retrieve file version for Microsoft ODBC Text driver 
//as_filename = "F:\ContractLogix_VSS\SourceCode\Version 10.5\emssl.dll"

// return the number of bytes of the file information for as_filename 
ll_size = GetFileVersionInfoSize (as_filename, ll_dummy) 

// obtain handle to the process heap 
hMem = GetProcessHeap() 

// allocate the number of bytes needed to store version information on the heap 
lpInfo = HeapAlloc(hMem, 0, ll_size) 

// write the file version information to the allocated memory 
ll_ret = GetFileVersionInfo(as_filename, ll_dummy, ll_size, lpInfo) 

// lpPoint is a pointer to 4 bytes where the first two bytes 
// represent the language id and the last two bytes the code page 
// query the file information on the heap for language id and code page: 
ls_query = "\VarFileInfo\Translation" 
ll_ret = VerQueryValue(lpInfo, ls_query, lpPoint, ll_len) 

// copy the 4 bytes from the heap into a PowerBuilder storage location (ls_bytes)
 MoveMemory(ls_bytes, lpPoint, ll_len) 

// on an Intel computer, the little end is stored first (Little Endian) 
// this means a Hex word like 0x1234 (two bytes) is stored in memory as (0x34 0x12)
 // copy the 4 bytes into ASCII integers and perform byte swapping: 
arr_int[1] = AscA(MidA(ls_bytes, 2, 1)) 
arr_int[2] = AscA(MidA(ls_bytes, 1, 1)) 
arr_int[3] = AscA(MidA(ls_bytes, 4, 1)) 
arr_int[4] = AscA(MidA(ls_bytes, 3, 1)) 

// to query the FileVersion in a subsequent call to VerQueryValue 
// we need the language id and code page in a Hex string representation 
// for example, it may look like 040904E4 - as in: 
// 04------ = SUBLANG_ENGLISH_USA 
// --09---- = LANG_ENGLISH 
// ----04E4 = 1252 = Codepage for Windows:Multilingual 
// convert the 4 bytes of ASCII integers into a Hex string: 
for i=1 to 4 
if arr_int[i] < 16 then 
ls_langcodepage = ls_langcodepage + '0' + arr_hex[arr_int[i] +1] 
else 
ls_langcodepage = ls_langcodepage + arr_hex[arr_int[i]/16 +1] + arr_hex[mod(arr_int[i], 16) +1]
 end if 
next 

// at this point we could also query for 
// CompanyName, FileDescription, InternalName, LegalCopyright 
// ProductName or ProductVersion by replacing the string literal FileVersion below
 // lpPoint is a pointer to the FileVersion string on the heap: 
//ls_query = "\StringFileInfo\" + ls_langcodepage + "\FileVersion" 
ls_query = "\StringFileInfo\" + ls_langcodepage + "\"  + as_filepropertiesname
//ls_query = "\StringFileInfo\" + ls_langcodepage + "\CompanyName" 
ll_ret = VerQueryValue(lpInfo, ls_query, lpPoint, ll_len) 

// copy the version string into a PowerBuilder string location 
ls_version = space(255) 
lstrcpy(ls_version, lpPoint) 

// free the memory on the heap 
HeapFree(hMem, 0, lpInfo);

If ls_version <> space(255)  Then
	Return ls_version
Else
	Return ''
End If

end function

public function string of_getfiletypedes (string as_filename);//====================================================================
//$<Function>: of_getfiletypedes
//$<Arguments>:
// 	value    string    as_filename
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//as_filename : file name or file ext name

String ls_file_type,ls_file_type_des,ls_file_ext
Integer li_ret

If Lastpos(as_filename, '.') > 0 Then
	ls_file_ext = right(as_filename, Len(as_filename) - Lastpos(as_filename, '.') )
Else
	ls_file_ext = as_filename
End If

li_ret = RegistryGet("HKEY_CLASSES_ROOT\." + ls_file_ext, "", RegString!, ls_file_type)
If  li_ret = 1 Then
	RegistryGet("HKEY_CLASSES_ROOT\" + ls_file_type, "", RegString!, ls_file_type_des)
End If

If Len(ls_file_type_des) > 0 Then
	ls_file_type_des = ls_file_type_des + " (."+lower(ls_file_ext)+")"
Else
	ls_file_type_des = " (."+ls_file_ext+")"
End If

Return ls_file_type_des

end function

public function string of_getfileversion (string as_filename);//====================================================================
//$<Function>: of_getfileversion
//$<Arguments>:
// 	value    string    as_filename
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Return of_getfileinfo(as_filename, 'FileVersion')

String ls_version

ls_version = Space(50)
GetFileVer(as_filename, ls_version)

Return ls_version



end function

on n_cst_filesrv.create
call super::create
end on

on n_cst_filesrv.destroy
call super::destroy
end on

