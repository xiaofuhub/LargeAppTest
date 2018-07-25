$PBExportHeader$appeon_pdfservice.sru
forward
global type appeon_pdfservice from nonvisualobject
end type
end forward

global type appeon_pdfservice from nonvisualobject
end type
global appeon_pdfservice appeon_pdfservice

type prototypes
private function boolean SHGetSpecialFolderPathA(Long  hwndOwner, ref string docPath,int nFolder, boolean fCreate) library "shell32.dll" alias for "SHGetSpecialFolderPathA;Ansi"
private function boolean Sleep(Long dwMilliseconds) library "kernel32.dll"

end prototypes

type variables
private:

CONSTANT String APPEON_PATH = "<PATH>="
CONSTANT String PRINTER_DIR = "Appeon Printer"
CONSTANT Long	NULL_HANDLE = 0
CONSTANT int	CSIDL_PERSONAL = 5

//query interval for print
int ii_queryinterval = 1
//related datawindow with save as pdf
datastore ids_source
//related datastore with save as pdf
datawindow idw_source
//PDF Printer Name
String is_printername = "Customer PDFPrinter"
//error code
int ii_errorcode = 0

//the max seconds when waiting to write pdf file
int ii_waittime 

n_cst_pdf invo_pdf //alfee 02.19.2014
n_cst_message inv_message //stephen 05.06.2014
boolean ib_sche = false        //stephen 05.06.2014
end variables

forward prototypes
public function string of_getdocumentname ()
public function integer of_writepathfile (string as_filename, string as_pdffilename)
public function string of_getprinterpath ()
public function String of_getpathdelimiter ()
public subroutine of_setqueryinterval (integer ai_interval)
public subroutine of_setrelateddw (ref datawindow ad_dw)
public subroutine of_setrelatedds (ref datastore ad_ds)
public subroutine of_setprintername (string as_printername)
public function string of_getlasterror ()
public function integer of_saveas (string as_filename, boolean ab_sync)
public function integer of_syncprintwork (string as_pdffilename)
public function integer of_print (powerobject apo_data, string as_file)
public function string of_printas (powerobject apo_data)
public function integer of_saveas (powerobject apo_data, string as_file)
public function integer of_set_schedule (boolean ab_schedule)
end prototypes

public function string of_getdocumentname ();string ls_docname

Randomize (cpu())

ls_docname = "PDF"+string(Rand(999999))

return ls_docname
end function

public function integer of_writepathfile (string as_filename, string as_pdffilename);int fhandle,li_rtn
string ls_file

ls_file = of_getprinterpath() + of_getpathdelimiter() + PRINTER_DIR

if not DirectoryExists (ls_file) then
	CreateDirectory(ls_file)
end if

ls_file = ls_file + of_getpathdelimiter() + as_filename

fhandle = FileOpen(ls_file, StreamMode!, Write!, LockWrite!, Replace!)

if fhandle = 0 then
	return -1
end if

if (lower(RightA(as_pdffilename,4)) = ".pdf") then
	as_pdffilename = LeftA(as_pdffilename,LenA(as_pdffilename) - 4 )
end if

li_rtn = FileWrite(fhandle,as_pdffilename)

if li_rtn < 0 then
	return -1
end if

li_rtn = FileClose(fhandle)

if li_rtn <> 1 then
	return -1
end if

return 1
end function

public function string of_getprinterpath ();String ls_path

ls_path = space(255)

SHGetSpecialFolderPathA(NULL_HANDLE,ls_path,CSIDL_PERSONAL,false)

return ls_path;
end function

public function String of_getpathdelimiter ();return "\"
end function

public subroutine of_setqueryinterval (integer ai_interval);
this.ii_queryinterval = ai_interval
end subroutine

public subroutine of_setrelateddw (ref datawindow ad_dw);this.idw_source = ad_dw
setnull(ids_source)
end subroutine

public subroutine of_setrelatedds (ref datastore ad_ds);this.ids_source = ad_ds
setnull(idw_source)
end subroutine

public subroutine of_setprintername (string as_printername);this.is_printername = as_printername
end subroutine

public function string of_getlasterror ();String ls_error

choose case ii_errorcode
	case 0
		ls_error = ""
	case 1
		ls_error = "set printer error or invalid printer name!"
	case 2
		ls_error = "datastore or datawindow is a invalid object!"
	case 3
		ls_error = "write file error!"
	case 4
		ls_error = "print pdf file error!"
	case 5
		ls_error = "sync print pdf file error!"
end choose

return ls_error
end function

public function integer of_saveas (string as_filename, boolean ab_sync);string 	ls_docname
int 		li_rtn

as_filename = lower(trim(as_filename))

if RightA(as_filename,4) <> ".pdf" then 
	messagebox("Prompt","Please input the PDF type file.")
	return -1
end if

if PosA(as_filename,":\",1) <> 2 then 
	messagebox("Prompt","Please input the full path file.")
	return -1
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-11-09 By: Scofield
//$<Reason> Install printers

li_rtn = f_PrinterSetup(1)
if li_rtn = 1 then
	ii_errorcode = 1
	return -1
elseif li_rtn = 4 then
	return 1
end if
//---------------------------- APPEON END ----------------------------

//delete the same name file 
if fileexists(as_filename) then filedelete(as_filename)

ls_docname = of_getdocumentname()

li_rtn = PrintSetPrinter(this.is_printername)

if li_rtn <> 1 then
	ii_errorcode = 1
	return -1
end if

if (isnull(this.idw_source)) and (isnull(this.ids_source)) then
	ii_errorcode = 2
	return -1
end if


li_rtn = of_writepathfile(ls_docname,as_filename)

if li_rtn <> 1 then
	ii_errorcode = 3
	return -1
end if

if (not isnull(this.ids_source)) then
	this.ids_source.Object.DataWindow.Print.DocumentName = APPEON_PATH +ls_docname
	this.ids_source.Object.DataWindow.Print.Prompt= "no"
	li_rtn = this.ids_source.print(false)
end if

if (not isnull(this.idw_source)) then
	this.idw_source.Object.DataWindow.Print.DocumentName = APPEON_PATH +ls_docname
	this.idw_source.Object.DataWindow.Print.Prompt= "no"
	li_rtn = this.idw_source.print(false)
end if

if li_rtn <> 1 then
	ii_errorcode = 4
	return -1
end if

if (ab_sync) then
	li_rtn = of_syncprintwork(as_filename)
	if li_rtn <> 1 then
		ii_errorcode = 5
		return -1
	end if
end if

ii_errorcode = 0

return 1
end function

public function integer of_syncprintwork (string as_pdffilename);boolean lb_continue = true
Long ll_handle
Long ll_second

//Sleep(2000)
do while ll_second <= ii_waittime
	sleep(50)
	ll_second = ll_second + 50
	if FileExists(as_pdffilename) then exit
loop

if (lower(RightA(as_pdffilename,4))) <> ".pdf" then
	as_pdffilename = as_pdffilename + ".pdf"
end if

do while lb_continue
	
	if (FileExists(as_pdffilename)) then
		ll_handle = FileOpen(as_pdffilename,StreamMode!,Write!,LockWrite!,Append!);
	
		if ll_handle < 0 then
			lb_continue = true
			Sleep(this.ii_queryinterval)
		else
			FileClose(ll_handle)
			lb_continue = false
		end if
	else
		return -1
	end if
loop

return 1
end function

public function integer of_print (powerobject apo_data, string as_file);//////////////////////////////////////////////////////////////////////
// $<function> of_print
// $<arguments>
//		powerobject	apo_data
//		string		as_file
// $<returns> integer
// $<description> Print data as PDF file using IntelliSoft PDF Writer
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.27.2010
//////////////////////////////////////////////////////////////////////

string ls_Syntax
string ls_OldPrinter
string ls_OldPrinterDW
string ls_OldFileName
string ls_SourceFile
integer li_File
integer li_Return
integer li_ret
long     ll_cpu
boolean lb_msg = true
datastore lds_data
datawindow ldw_data
n_cst_filesrvwin32 lnv_FileSrv

//---------Begin Added by (Appeon)Alfee 02.19.2014 ------ -------------------
If appeongetclienttype() = 'PB' And gi_citrix = 1 Then
	li_ret = of_saveas(apo_data, as_file)	
	ChangeDirectory(gs_current_path)  //(Appeon)Stephen 02.21.2014 - set current path
	If li_ret > 0 Then Return 1
	If li_ret = -2 Then Return -1 
End If
//---------End Added --------------------------------------------------------------

if not IsValid(apo_Data) then Return -1
if IsNull(as_File) or LenA(as_File) < 1 then Return -1

// Check IntelliSoft PDF Writer if setup
if f_PrinterSetup(2) >= 2 then
	Return -1
end if

// Delete PDF files if exists
ls_SourceFile = gs_temp_pdf
if FileExists(ls_SourceFile) then
	//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
	/*
	if not FileDelete(ls_SourceFile) then
		MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")
		Return -1
	end if
	*/
	ll_cpu = cpu()
	li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
	do while li_ret = 1
		li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
	loop
	if li_ret = -1 then 				
		return -1
	end if
	//---------End Modfiied ------------------------------------------------------	
	
end if
if FileExists(as_File) then
	if not FileDelete(as_File) then
		//---------Begin Modified by (Appeon)Stephen 05.06.2014 for V142 Schedule IntelliReport--------
		//MessageBox("Printer Error", "Please delete the file of '" + as_File + "' first! ")
		inv_message.of_messagebox("Printer Error", "Please delete the file of '" + as_File + "' first! ", true)
		//---------End Modfiied ------------------------------------------------------
		Return -1
	end if
end if

// Print data as PDF file
if apo_data.TypeOf() = datawindow! then
	// Check dataobject if exists
	ldw_data = apo_data
	ls_Syntax = ldw_data.Describe("datawindow.syntax")
	if ls_Syntax = "" or ls_Syntax = "?" or IsNull(ls_Syntax) then
		Return -1
	end if
	// Disable out file
	ldw_data.SetRedraw(false)
	ls_OldFileName = ldw_data.Describe("dataWindow.print.filename")
	if LenA(ls_OldFileName) > 0 then
		ldw_data.Modify("dataWindow.print.filename = ''")
	end if
	// Print data as PDF format using IntelliSoft PDF Writer
	ls_OldPrinter = PrintGetPrinter()
	ls_OldPrinterDW = ldw_data.Describe("dataWindow.printer")
	ldw_data.Modify("dataWindow.printer = 'IntelliSoft PDF Writer'")
	PrintSetPrinter("IntelliSoft PDF Writer")
	//ldw_data.Print(false) 
	li_Return = ldw_data.Print(false)	//long.zhang 10.12.2011
	// Restore printer properties
	ldw_data.Modify("dataWindow.print.filename = '" + ls_OldFileName + "'")
	ldw_data.Modify("dataWindow.printer = '" + ls_OldPrinterDW + "'")
	PrintSetPrinter(ls_OldPrinter)
	ldw_data.SetRedraw(true)
elseif apo_data.TypeOf() = datastore! then
	// Check dataobject if exists
	lds_data = apo_data
	ls_Syntax = lds_data.Describe("datawindow.syntax")
	if ls_Syntax = "" or ls_Syntax = "?" or IsNull(ls_Syntax) then
		Return -1
	end if
	// Disable out file
	ls_OldFileName = lds_data.Describe("dataWindow.print.filename")
	if LenA(ls_OldFileName) > 0 then
		lds_data.Modify("dataWindow.print.filename = ''")
	end if
	// Print data as PDF format using IntelliSoft PDF Writer
	ls_OldPrinter = PrintGetPrinter()
	ls_OldPrinterDW = lds_data.Describe("dataWindow.printer")
	lds_data.Modify("dataWindow.printer = 'IntelliSoft PDF Writer'")
	PrintSetPrinter("IntelliSoft PDF Writer")
	//lds_data.Print(false)
	li_Return = lds_data.Print(false)	//long.zhang 10.12.2011
	// Restore printer properties
	lds_data.Modify("dataWindow.print.filename = '" + ls_OldFileName + "'")
	lds_data.Modify("dataWindow.printer = '" + ls_OldPrinterDW + "'")
	PrintSetPrinter(ls_OldPrinter)
else
	Return -1
end if

if li_Return <> 1 then //added by long.zhang 10.12.2011	check if print is successful
	//---------Begin Modified by (Appeon)Stephen 05.06.2014 for V142 Schedule IntelliReport--------
	//MessageBox("Information","Failed to print the data. Please check if the ‘IntelliSoft PDF Writer’ was installed correctly on your computer")
	inv_message.of_messagebox("Information","Failed to print the data. Please check if the ‘IntelliSoft PDF Writer’ was installed correctly on your computer", true)
	//---------End Modfiied ------------------------------------------------------
	Return -1	
end if	


// Copy PDF file to specified path
do while true
	Yield()
	if FileExists(ls_SourceFile) then
		li_File = FileOpen(ls_SourceFile, StreamMode!, Write!)
		if li_File <> -1 then Exit
	end if
loop
FileClose(li_File)
lnv_FileSrv = Create n_cst_filesrvwin32
li_Return = lnv_FileSrv.of_FileCopy(ls_SourceFile, as_File)
Destroy lnv_FileSrv
if li_Return <> 1 then Return -1

Return 1
end function

public function string of_printas (powerobject apo_data);//////////////////////////////////////////////////////////////////////
// $<function> of_printas
// $<arguments>
//		powerobject	apo_data
// $<returns> string
// $<description> Print data as PDF file using IntelliSoft PDF Writer
//////////////////////////////////////////////////////////////////////
// $<modify> Evan 05.06.2010
//////////////////////////////////////////////////////////////////////

integer li_Return
string ls_FileName
string ls_FullFileName

// Select file path
li_Return = GetFileSaveName("Select File", ls_FullFileName, ls_FileName, "PDF", "All PDF Files (*.pdf),*.pdf", gs_temp_path, 32770)
if li_Return < 1 then Return ""

// Print data as PDF file
li_Return = of_Print(apo_Data, ls_FullFileName)
if li_Return = 1 then
	Return ls_FullFileName
else
	Return ""
end if
end function

public function integer of_saveas (powerobject apo_data, string as_file);/////////////////////////////////////////////////////////////////////////////////
// $<function> of_saveas
// $<arguments>
//		powerobject	apo_data
//		string		as_file
// $<returns> integer 
// $<description> Save data as PDF file using Sybase PS for Citrix users
/////////////////////////////////////////////////////////////////////////////////
// $<add> Alfee 02.19.2014
/////////////////////////////////////////////////////////////////////////////////
Long	ll_Rtn, ll_Ret
String	ls_Syntax,ls_PathName,ls_FileName,ls_WinDir
String	ls_Null, ls_ARCHITECTURE
DataStore lds_data
DataWindow ldw_data
n_cst_systeminfo lnv_systeminfo
n_cst_filesrvwin32 inv_filesrv

If appeongetclienttype() <> 'PB'Or gi_citrix <> 1 Then Return 0

if not IsValid(apo_Data) then Return -1
if IsNull(as_File) or LenA(as_File) < 1 then Return -1
if apo_data.TypeOf() <> datawindow! and apo_data.TypeOf() <> datastore! then Return -1

SetNull(ls_Null)

inv_filesrv = create n_cst_filesrvwin32
IF NOT inv_filesrv.of_DirectoryExists (gs_dir_path + gs_DefDirName + '\Mail') THEN
       inv_filesrv.of_CreateDirectory (gs_dir_path + gs_DefDirName + '\Mail')
END IF

//lnv_systeminfo = create n_cst_systeminfo
//If lnv_systeminfo.of_get_envvar('ProgramW6432') <> '' or lnv_systeminfo.of_get_envvar('ProgramFiles(x86)')  <> '' Then 
//	ls_ARCHITECTURE = '64-bit'
//Else
//	ls_ARCHITECTURE = '32-bit'
//End If
//Destroy lnv_systeminfo

if invo_pdf.of_set_path( ) = -1 then return -2

if invo_pdf.of_add_pdf_printer() = -1 then return  -2

if apo_data.TypeOf() = datawindow! then
	ldw_data = apo_data
	ls_Syntax = ldw_data.Describe("DataWindow.Syntax") 
	if Len(ls_Syntax) = 0 then return -1
	
	ldw_data.Object.DataWindow.Export.PDF.Method = Distill!
	ldw_data.Object.DataWindow.Printer = invo_pdf.IS_PDF_PRINTER
	//If ls_ARCHITECTURE = '64-bit' Then//added by gavins 20140218
	//Else
		ldw_data.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
	//End If
	
	ll_ret = ldw_data.SaveAs(as_file, pdf!,True)	
	if ll_ret = -1 then
		if Len(Trim(as_file)) = 0 and ldw_data.saveas(gs_dir_path + gs_DefDirName + '\' + ldw_data.Object.DataWindow.Print.DocumentName + ".PDF" ,pdf!,True) > 0 then 
			 messagebox('Saved File Location','The pdf file:  ' + string(ldw_data.Object.DataWindow.Print.DocumentName) + ' has been saved into the following directory:' + gs_dir_path + gs_DefDirName + '\')
			 ShellExecuteA ( Handle( This ), "open", gs_dir_path + gs_DefDirName + '\' + ldw_data.Object.DataWindow.Print.DocumentName + ".PDF"  , ls_Null, ls_Null,4)
		else
			Messagebox('Save','Failed to save as PDF.',Exclamation!)
		end if 
	end if 
elseif apo_data.TypeOf() = datastore! then
	lds_data = apo_data
	ls_Syntax = lds_data.Describe("DataWindow.Syntax") 
	if Len(ls_Syntax) = 0 then return -1
	
	lds_data.Object.DataWindow.Export.PDF.Method = Distill!
	lds_data.Object.DataWindow.Printer = invo_pdf.IS_PDF_PRINTER
	//If ls_ARCHITECTURE = '64-bit' Then//added by gavins 20140218
	//Else
		lds_data.Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"
	//End If
	
	ll_ret = lds_data.SaveAs(as_file, pdf!,True)	
	if ll_ret = -1 then
		if Len(Trim(as_file)) = 0 and lds_data.saveas(gs_dir_path + gs_DefDirName + '\' + lds_data.Object.DataWindow.Print.DocumentName + ".PDF" ,pdf!,True) > 0 then 
			 messagebox('Saved File Location','The pdf file:  ' + string(lds_data.Object.DataWindow.Print.DocumentName) + ' has been saved into the following directory:' + gs_dir_path + gs_DefDirName + '\')
			 ShellExecuteA ( Handle( This ), "open", gs_dir_path + gs_DefDirName + '\' + lds_data.Object.DataWindow.Print.DocumentName + ".PDF"  , ls_Null, ls_Null,4)
		Else
			Messagebox('Save','Failed to save as PDF.',Exclamation!)
		end if 
	end if 
end if
	
RETURN ll_ret
end function

public function integer of_set_schedule (boolean ab_schedule);//====================================================================
//$<Function>: of_set_schedule
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.06.2014 (V142 Schedule IntelliReport)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_sche = ab_schedule
IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ib_sche)		
END IF
return 1
end function

on appeon_pdfservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeon_pdfservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;setNull(ids_source)
setNull(idw_source)

//init the max time when waiting to write pdf file
//ii_waittime = long(ProfileString(theprogram.g_ini, "time", "waittime",'2000'))
//is_printername = trim(ProfileString(theprogram.g_ini, "PROGRAM", "PDFPRINTER",'Customer PDFPrinter'))

end event

