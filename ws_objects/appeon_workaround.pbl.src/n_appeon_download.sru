$PBExportHeader$n_appeon_download.sru
forward
global type n_appeon_download from nonvisualobject
end type
end forward

global type n_appeon_download from nonvisualobject autoinstantiate
end type

type prototypes
Function long URLDownloadToFile (long pCaller, String szURL, String szFileName, long dwReserved, long lpfnCB) library "urlmon.dll" Alias for "URLDownloadToFileA;Ansi"

Function int fnGetDocTime(string ip , string url, int port , ref string doctime) library "appeondll.dll" alias for "fnGetDocTime;Ansi"

Function long GetSystemDirectory(ref string lpBuffer, long uSize) library "kernel32.dll" alias for "GetSystemDirectoryA;Ansi"
end prototypes

type variables

String is_downurl = 'http:\\172.17.3.2:8080\intellicred\Templates\'

string is_ip
int    ii_port
string is_url
end variables

forward prototypes
public function integer of_downloadpdf (string as_url)
public function integer of_downloadfile (string as_url, string as_filename)
public function string of_parsefile (string as_filepath)
public subroutine of_parsepath (string as_filepath)
public function integer of_downloaddll ()
public function integer of_downloadqrxsjar ()
public function integer of_downloadletterdatasource (string as_filefullname)
public function integer of_downloadhtmhelp (string as_filefullname, string as_images[])
public function integer of_downloadpdfhelp (string as_filefullname)
end prototypes

public function integer of_downloadpdf (string as_url);
inet  linet_web

linet_web = create inet

linet_web.hyperlinktourl( as_url)

return 1
end function

public function integer of_downloadfile (string as_url, string as_filename);
long	ll_pcaller , ll_reserved, ll_lpfn
long		ll_rtn
string	ls_filename , ls_url
string  ls_filedate_local,ls_filedate_server
String ls_downurl

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Zhang XingRen
//$<reason> 
if as_url = "" then
	//$<Modify> 02.26.2008 by Andy
	//ls_downurl = gnv_data.of_getitem( "icred_settings", "downloadurl", false)
	SELECT TOP 1 downloadurl INTO :ls_downurl FROM icred_settings;
	//end of modify 02.26.2008
else
	ls_downurl = as_url
end if
//---------------------------- APPEON END ----------------------------


IF LenA(ls_downurl)>0 THEN is_downurl = ls_downurl

ls_filename = of_parsefile( as_filename)

setnull(ll_pcaller)
setnull(ll_lpfn)

ls_url = is_downurl + ls_filename

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.03.2008 By: Ken.Guo
//$<reason> Set file's readonly property to False. Otherwise download failed.
n_cst_filesrvwin32 lnv_FileSrv
lnv_FileSrv = Create n_cst_filesrvwin32 
IF fileexists( as_filename ) THEN
	lnv_FileSrv.of_setfilereadonly( as_filename, False)
END IF
//---------------------------- APPEON END ----------------------------

//download file from web server as_url to local disk as_filename
ll_rtn = URLDownloadToFile(ll_pcaller, ls_url, as_filename, 0, ll_lpfn)

If isvalid(lnv_FileSrv) Then Destroy lnv_FileSrv

return ll_rtn
end function

public function string of_parsefile (string as_filepath);string	ls_filename , ls_tempPath  , ls_path
long		ll_pos

n_cst_filesrvwin32  lnv_filesvr
If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32

ls_filename = as_filepath
ll_pos = PosA(ls_filename , '\')
ls_tempPath = ''

Do While ll_pos > 0
	ls_tempPath = LeftA(ls_filename , ll_pos)
	ls_path     = ls_path + ls_tempPath 
	ls_filename = MidA(ls_filename , ll_pos + 1)
	If MidA(ls_tempPath,2,1) = ':' Then 
		ll_pos = PosA(ls_filename , '\')
		continue
	End If
	
	If not lnv_filesvr.of_directoryexists( ls_path) Then
		lnv_filesvr.of_createdirectory( ls_path)
	End If
	
	ll_pos = PosA(ls_filename , '\')
Loop

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lnv_filesvr) then Destroy lnv_filesvr
//---------------------------- APPEON END ----------------------------

return ls_filename
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

If LenA(ls_filepath) > 0 Then
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

public function integer of_downloaddll ();integer i
integer li_FileCount
string  ls_Sys32Path
string  ls_SourceFile
string  ls_FileFullName
string  ls_FileName[] = {"ConvertPDF.dll", "zlib1.dll"}

// Get system directory
ls_Sys32Path = Space(255)
GetSystemDirectory(ls_Sys32Path, 255)
if Trim(ls_Sys32Path) = "" then
	MessageBox("Error", "Failed to get system directory.")
	Return -1
end if

// Download DLLs if not exists in system directory
n_cst_filesrvwin32  lnv_filesvr
lnv_FileSvr = Create n_cst_filesrvwin32
li_FileCount = UpperBound(ls_FileName[])

string sss

sss = AppeonGetClientType()
messagebox("appeon client type",sss)


for i = 1 to li_FileCount
	ls_FileFullName = ls_Sys32Path + "\" + ls_FileName[i]
	if FileExists(ls_FileFullName) then Continue
	
	if AppeonGetClientType() = "PB" then
		ls_SourceFile = gs_current_path + "\" + ls_FileName[i]
		lnv_FileSvr.of_FileCopy(ls_SourceFile, ls_FileFullName)
		if not FileExists(ls_FileFullName) then
			//Start Code Change ----09.09.2008 #V85 maha - modified message to display file paths
			MessageBox("Copy File", "Failed to copy '" + ls_SourceFile + "' file to system directory(" + ls_Sys32Path + "). Please contact the system administrator.")
			//MessageBox("Copy File", "Failed to copy '" + ls_FileName[i] + "' file to system directory. Please contact the system administrator.")
			//End Code Change---09.09.2008
		end if
	else
		of_DownloadFile("", ls_FileFullName)
		if not FileExists(ls_FileFullName) then
			MessageBox("Download DLLs", "Failed to download '" + ls_FileName[i] + "' file. Please contact the system administrator.")
		end if
	end if
next
Destroy lnv_FileSvr

Return 1
end function

public function integer of_downloadqrxsjar ();//////////////////////////////////////////////////////////////////////
// $<function> of_downloadqrxsjar
// $<arguments>
// $<returns> integer
// $<description> Download qrxs files (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.24.2009
//////////////////////////////////////////////////////////////////////

string  ls_QrxsJarPath
string  ls_FileFullName
integer i, li_FileCount
n_cst_filesrvwin32 lnv_FileSrv
string  ls_FileName[] = {"commons-codec-1.3.jar", "commons-fileupload-1.1.jar", "commons-httpclient-2.0.jar", "commons-logging.jar", "qrxs-v1_05.jar"}

if AppeonGetClientType() = "PB" then
	Return 1
end if

// Get qrxs jar file directory
ls_QrxsJarPath = gs_temp_path + "qrxsjarfiles"

// Check qrxs jar files if exists
ls_FileFullName = ls_QrxsJarPath + "\commons-codec-1.3.jar"
if FileExists(ls_FileFullName) then
	Return 1
end if

// Create qrxs directory if not exists
lnv_FileSrv = Create n_cst_filesrvwin32
if not lnv_FileSrv.of_DirectoryExists(ls_QrxsJarPath) then
	lnv_FileSrv.of_CreateDirectory(ls_QrxsJarPath)
end if
Destroy lnv_FileSrv

// Download qrxs jar files
li_FileCount = UpperBound(ls_FileName[])
for i = 1 to li_FileCount
	ls_FileFullName = ls_QrxsJarPath + "\" + ls_FileName[i]
	of_DownloadFile("", ls_FileFullName)
	if not FileExists(ls_FileFullName) then
		MessageBox("Download Files", "Failed to download '" + ls_FileName[i] + "' file. Please contact the system administrator.")
		Return -1
	end if
next

Return 1
end function

public function integer of_downloadletterdatasource (string as_filefullname);//////////////////////////////////////////////////////////////////////
// $<function> of_downloadletterdatasource
// $<arguments>
//		value	string	as_filefullname
// $<returns> integer
// $<description> Download letter's data source file
//////////////////////////////////////////////////////////////////////
// $<add> 04.10.2012 by Evan
//////////////////////////////////////////////////////////////////////

string ls_URL

// Get downloading URL
SELECT TOP 1 downloadurl INTO :ls_URL FROM icred_settings;
if IsNull(ls_URL) or ls_URL = "" then
	Return -1
end if

if Right(ls_URL, 1) = "/" or Right(ls_URL, 1) = "\" then
	ls_URL += "Letters/"
else
	ls_URL += "/Letters/"
end if

// Download letter's data source file
FileDelete(as_FileFullName)
of_DownloadFile(ls_URL, as_FileFullName)

if FileExists(as_FileFullName) then
	Return 1
else
	Return -1
end if
end function

public function integer of_downloadhtmhelp (string as_filefullname, string as_images[]);//////////////////////////////////////////////////////////////////////
// $<function> of_downloadhtmhelp
// $<arguments>
//		value	string	as_filefullname
//		value	string	as_images[] , filenames in htm
// $<returns> integer
// $<description> Download htm's d file and related 
//////////////////////////////////////////////////////////////////////
// $<add> Appeon long.zhang 12.31.2015
//////////////////////////////////////////////////////////////////////

string ls_URL, ls_htm_name, ls_other_file_path, ls_other_file_fullpath
Int i, j

// Get downloading URL
SELECT TOP 1 downloadurl INTO :ls_URL FROM icred_settings;
if IsNull(ls_URL) or ls_URL = "" then
	Return -1
end if

if Right(ls_URL, 1) = "/" or Right(ls_URL, 1) = "\" then
	ls_URL += "Help/"
else
	ls_URL += "/Help/"
end if

// Download letter's data source file
FileDelete(as_FileFullName) 
of_DownloadFile(ls_URL, as_FileFullName)

if FileExists(as_FileFullName) then
	j =  UpperBound(as_images[])
	If j > 0 Then
		//Subfolder name
		ls_htm_name = MidA(as_filefullname, LastPos(as_filefullname,'\') + 1)
		If PosA(ls_htm_name, '.') > 0 Then
			ls_htm_name = LeftA(ls_htm_name, PosA(ls_htm_name, '.')  - 1 )
		End If
		
		//Change URL
		ls_URL +=   ls_htm_name + "/"
		
		//Other file path
		ls_other_file_path =  LeftA(as_filefullname, LastPos(as_filefullname,'\') ) +ls_htm_name + '\' 
		For i = 1 to j
			ls_other_file_fullpath = ls_other_file_path + as_images[i]
			
			FileDelete(ls_other_file_fullpath) 
			
			of_DownloadFile(ls_URL, ls_other_file_fullpath)
			If Not FileExists(as_FileFullName) Then
				FileDelete(as_FileFullName) 
				Return -1
			End If
		Next
	End If
	Return 1
else
	Return -1
end if

end function

public function integer of_downloadpdfhelp (string as_filefullname);//////////////////////////////////////////////////////////////////////
// $<function> of_downloadpdfhelp
// $<arguments>
//		value	string	as_filefullname
// $<returns> integer
// $<description> Download pdf file
//////////////////////////////////////////////////////////////////////
// $<add> Appeon long.zhang 01.07.2016
//////////////////////////////////////////////////////////////////////

string ls_URL, ls_pdf_name
Int i, j

// Get downloading URL
SELECT TOP 1 downloadurl INTO :ls_URL FROM icred_settings;
if IsNull(ls_URL) or ls_URL = "" then
	Return -1
end if

if Right(ls_URL, 1) = "/" or Right(ls_URL, 1) = "\" then
	ls_URL += "Help/"
else
	ls_URL += "/Help/"
end if

// Download letter's data source file
FileDelete(as_FileFullName) 
of_DownloadFile(ls_URL, as_FileFullName)

if FileExists(as_FileFullName) then
	Return 1
else
	Return -1
end if

end function

on n_appeon_download.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_appeon_download.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

