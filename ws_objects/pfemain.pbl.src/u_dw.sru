$PBExportHeader$u_dw.sru
$PBExportComments$Extension DataWindow class
forward
global type u_dw from pfc_u_dw
end type
end forward

global type u_dw from pfc_u_dw
integer width = 1600
integer height = 984
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
event ue_mail ( string as_subject,  string as_notetext )
event ue_save_as_pdf ( )
event type long ue_save_pdf_for_mailing ( )
event ue_mail_bak ( string as_subject,  string as_notetext )
event ue_email_current_dw ( )
event ue_nchittest pbm_nchittest
event type integer ue_isudw ( )
event mousemove pbm_mousemove
event ue_key pbm_dwnkey
event ue_saveas_excel ( boolean ab_header )
event ue_afterpowerfilter ( )
event ue_dwsyscommand pbm_syscommand
event ue_mail_outlook64 ( string as_subject,  string as_notetext )
end type
global u_dw u_dw

type prototypes
FUNCTION ulong GetCurrentDirectoryA(ulong BufferLen, ref string currentdir) LIBRARY "Kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
FUNCTION ulong GetEnvironmentVariableA( string szVarName,REF string lpValue, ulong dwSize ) LIBRARY "kernel32.dll" alias for "GetEnvironmentVariableA;Ansi" 
//Then, use SetEnvironmentVariable to change it: 
FUNCTION boolean SetEnvironmentVariableA( string szVarName, string szValue ) LIBRARY "kernel32.dll" alias for "SetEnvironmentVariableA;Ansi" 
end prototypes

type variables
long ll_original_width
CONSTANT STRING IS_PDF_PRINTER = 'Intellisoft PDF Printer'///'IntelliPDF' //'Sybase Datawindow PS' 
window iw_parent

// start code change --- 10.31.2005
constant string word_2003_pth = 'C:\Program Files\Microsoft Office\OFFICE11\WINWORD.EXE'
// end   code change --- 10.31.2005

string is_notify_who[]

//n_cst_pdf invo_pdf //Only create it when needed. Comment by Appeon long.zhang 03.03.2017 (Contracts Module Slowness)

long	il_ViewId,il_ScreenId		//Added by Scofield on 2007-10-25

//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
boolean ib_showtipshelp = true
boolean ib_typedown
boolean ib_zoom_triggered
string    is_last_object_tips
string    is_ori_filter
string    is_typedown_name
string    is_typedown_value
uo_tooltips iuo_tips
boolean lbn_ignore_idle = true
//---------End Added ------------------------------------------------------------------

Protected:
boolean ib_outputing_flag = False //e.g. Is printing, Added by Appeon long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)

end variables

forward prototypes
public function long of_get_next_record_id ()
public function integer of_notify_error (string as_subject, string as_notetext, string as_person[])
public subroutine of_setrmbmenu (boolean ab_show)
public subroutine of_autodatafill (long al_viewid, long al_screenid, string as_fieldname, long al_row, string as_data)
public subroutine of_setviewscreen (long al_viewid, long al_screenid)
public function integer of_showphonenumberdlg (string as_colname)
public function integer of_print (boolean ab_canceldialog, boolean ab_showprintdialog)
public function boolean of_isallowedit (long al_row, string as_colname)
public function integer of_get_typedown_value (keycode key, unsignedinteger keyflag)
public subroutine of_fielddependfilter (long al_viewid, long al_screenid, string as_fieldname, long al_row, boolean ab_filter, string as_ori_filter)
public subroutine of_set_idle_flag (boolean abn_idle_flag)
public subroutine of_setzoomtriggered (boolean ab_value)
public function integer of_save_as_pdf (string as_pathfile, ref string as_error)
public function integer of_print_pdf (string as_filename)
public function boolean of_get_outputing_flag ()
protected subroutine of_set_outputing_flag (boolean ab_flag)
end prototypes

event ue_mail(string as_subject, string as_notetext);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_mail
//==================================================================================================================
//  Purpose   	: Saves a datawindow to PDF and mails it
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Scofield  Monday  December 3, 2007
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


String	ls_MailDir,ls_Attach,ls_DispName
long 		ll_Cycle,ll_FileCnt

n_Cst_FileSrvWin32 	lnv_FileSrv
n_cst_dirattrib   	lnv_dirlist[]

if LenA(Describe("DataWindow.Syntax") ) = 0 then return

SetPointer(HourGlass!)
//ls_MailDir = gs_DefDirName + 'Mail' //Commented by (Appeon)Harry 04.15.2015 - for Bug 4488
ls_MailDir = gs_temp_path + 'Mail' //(Appeon)Harry 04.15.2015 - for Bug 4488

lnv_FileSrv = Create n_Cst_FileSrvWin32
if Not lnv_FileSrv.of_DirectoryExists (ls_MailDir) then
	lnv_FileSrv.of_CreateDirectory (ls_MailDir)
end if
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
     ll_FileCnt = lnv_FileSrv.of_DirList (ls_MailDir + '\*.*', 0, lnv_dirlist )

	for ll_Cycle = 1 to  ll_FileCnt
		if ll_Cycle <> 1 then
			ls_Attach +=  ','
			ls_DispName += ','
		end if
		ls_Attach +=  ls_MailDir + '\' + lnv_dirlist[ll_Cycle].is_filename
		ls_DispName += lnv_dirlist[ll_Cycle].is_filename
	next 
  */
  long ll_sum = 0
 ll_FileCnt = lnv_FileSrv.of_DirList (ls_MailDir + '\*.*', 55, lnv_dirlist )

for ll_Cycle = 1 to  ll_FileCnt
	If lnv_dirlist[ll_Cycle].is_filename =  "[..]" Then Continue //Added By Ken.Guo 2010-10-13.
	ll_sum++
	if ll_sum <> 1 then
		ls_Attach +=  ','
		ls_DispName += ','
	end if
	ls_Attach +=  ls_MailDir + '\' + lnv_dirlist[ll_Cycle].is_filename
	ls_DispName += lnv_dirlist[ll_Cycle].is_filename
next
//---------End Modfiied ------------------------------------------------------------------


Open(w_general_email_send)

//Wait until w_general_email_send is valid
do while Not IsValid(w_general_email_send)
	Yield()
loop

w_general_email_send.SetRedraw(false)
w_general_email_send.Ole_Message.of_InsertTextFirst(as_notetext)
w_general_email_send.ole_message.object.ActiveDocument.ActiveWindow.Selection.GoTo(1, 1)
w_general_email_send.sle_Subject.Text = as_Subject
w_general_email_send.sle_attach.Text = ls_DispName
w_general_email_send.is_attach_file = ls_Attach
w_general_email_send.SetRedraw(true)

destroy lnv_FileSrv
SetPointer(Arrow!)

end event

event ue_save_as_pdf();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT ue_save_as_pdf
//==================================================================================================================
//  Purpose   	: save a data window as pdf file
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B Skinner  23 Febuary 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Added by Evan 05.06.2010
string ls_Null
string ls_FileName
appeon_pdfservice lnv_pdf

of_set_outputing_flag(True) //Added by Appeon long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)

// Save as PDF file
lnv_pdf = Create appeon_pdfservice
ls_FileName = lnv_pdf.of_PrintAs(this)
Destroy lnv_pdf

// Open PDF file
if LenA(ls_FileName) > 0 then
	ShellExecuteA(Handle(this), "open", ls_FileName, ls_Null, ls_Null, 4)
end if

of_set_outputing_flag(False) //Added by Appeon long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 04.06.2010
//$<reason> Using IntelliSoft PDF Writer to convert
/*
long ll_ret
string ls_filename, ls_syntax, ls_null
string ls_file

setnull(ls_null)
ls_syntax = Describe("DataWindow.Syntax") 
if Len(ls_syntax) = 0 then return

n_cst_filesrvwin32 inv_filesrv
inv_filesrv = create n_cst_filesrvwin32
IF NOT inv_filesrv.of_DirectoryExists (gs_DefDirName + 'Mail') THEN
   inv_filesrv.of_CreateDirectory (gs_DefDirName + 'Mail')
END IF

// save the datawindow as a Pdf file
object.DataWindow.Export.PDF.Method = Distill!
Object.DataWindow.Printer = invo_pdf.is_pdf_printer
Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"

If appeongetclienttype() = 'PB' Then
	//Start Code Change ----10.27.2009 #V10 maha - rewrote to get file name for message display
	// changed to use Customer pdf printer for all OS for windows 7
	if f_PrinterSetup(1) = 1 then return 
	Object.DataWindow.Printer = "Customer PDFPrinter"

	ll_ret = GetFileSaveName ( "Select File",    ls_filename, ls_file, "PDF",    "All PDF Files (*.pdf*),*.pdf*" , gs_DefDirName,    32770)
	if ll_ret < 1 then return //allow to cancel
	//get save name
	ll_ret = saveas(ls_filename,pdf!,True)	
	if ll_ret <> -1 then

	if gi_test_mode = 1 then //test mode path message
		messagebox("Saved file",ls_filename)
	end if
	//open the file
	 ShellExecuteA ( Handle( This ), "open", ls_filename  , ls_Null, ls_Null,4)

	end if 
	//OLD CODE
//	if invo_pdf.of_set_path( ) = failure then return 
//	//----------Begin Modified by Alfee on 12.24.2008-------------
//	//<$Reason>As the PDF driver from PB is not supported in Vista, 
//	//<$Reason>using Customer PDFPrinter instead of it.
//	If Pos(appeonGetOSType(),"6.") > 0 THEN //Vista
//		if f_PrinterSetup(1) = 1 then return 
//		Object.DataWindow.Printer = "Customer PDFPrinter"
//	Else
//		if invo_pdf.of_add_pdf_printer() = failure then return 		
//	End If
//	//if invo_pdf.of_add_pdf_printer() = failure then return 
//	//	---------End Modified -------------------------------------
//	
//	ll_ret = saveas('',pdf!,True)	
//	if ll_ret = -1 then
//		if saveas(gs_dir_path + 'intellicred\' + Object.DataWindow.Print.DocumentName + ".PDF" ,pdf!,True) > 0 then 
//			 messagebox('Saved File Location','The pdf file:  ' + string(Object.DataWindow.Print.DocumentName) + ' has been saved into the following directory:' + gs_dir_path + 'intellicred\')
//			 ShellExecuteA ( Handle( This ), "open", gs_dir_path + 'intellicred\' + Object.DataWindow.Print.DocumentName + ".PDF"  , ls_Null, ls_Null,4)
//		end if 
//	end if 
	//End Code Change---10.27.2009
Else
	//ls_filename = gs_dir_path + 'intellicred\' + Object.DataWindow.Print.FileName + ".PDF"
	ls_filename = gs_dir_path + 'intellicred\.PDF' //Andy  09/28/2007 
	IF Object.DataWindow.Print.FileName <> "" THEN Object.DataWindow.Print.FileName = ""

	f_savedatawindow(this , ls_filename, '')
	Object.DataWindow.Print.FileName = ls_filename	//avoid popuping the saveas window while print.
End If
*/
//------------------- APPEON END ---------------------
end event

event type long ue_save_pdf_for_mailing();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT ue_save_pdf_for_mailing
//==================================================================================================================
//  Purpose   	: save a data window as pdf file
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B Skinner  23 Febuary 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Added by Evan 05.06.2010
string ls_Null
string ls_FileName
string ls_DocumentName
string ls_MailDir
integer li_Return
appeon_pdfservice lnv_pdf
n_cst_filesrvwin32 lnv_filesrv
n_cst_string lnv_string

of_set_outputing_flag(True) //Added by Appeon long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)

// Create Mail directory if not exists
ls_MailDir = gs_temp_path + "Mail"
lnv_filesrv = Create n_cst_filesrvwin32
lnv_FileSrv.of_DelTree(ls_MailDir)
if not lnv_FileSrv.of_DirectoryExists(ls_MailDir) then
	lnv_FileSrv.of_CreateDirectory(ls_MailDir)
end if
Destroy lnv_filesrv

// Get attachment file name
ls_DocumentName = Trim(this.Describe("DataWindow.Print.DocumentName"))
if IsNull(ls_DocumentName) then ls_DocumentName = ""
if ls_DocumentName = "?" or ls_DocumentName = "!" or ls_DocumentName = "" then
	ls_FileName = ls_MailDir + "\MAttachment.PDF"
else
	ls_FileName = ls_MailDir + "\" + ls_DocumentName + ".PDF"
	ls_FileName = lnv_string.of_GlobalReplace(ls_FileName, ",", " ")
end if

// Save as PDF file
lnv_pdf = Create appeon_pdfservice
li_Return = lnv_pdf.of_Print(this, ls_FileName)
Destroy lnv_pdf

of_set_outputing_flag(False) //Added by Appeon long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)

if li_Return = -1 then Return -1

Return 0

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 05.06.2010
//$<reason> Using IntelliSoft PDF Writer to convert
/*
string ls_syntax,ls_CurPrinter, ls_MailDir
n_cst_filesrvwin32 lnv_FileSrv

ls_syntax = Describe("DataWindow.Syntax") 
if Len(ls_syntax) = 0 then return -1	

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-12-03 By: Scofield
//$<Reason> Clean the Mail's temp files
ls_MailDir = gs_temp_path + "Mail"
lnv_filesrv = create n_cst_filesrvwin32

lnv_FileSrv.of_deltree(ls_MailDir)

if Not lnv_FileSrv.of_DirectoryExists (ls_MailDir) then
	lnv_FileSrv.of_CreateDirectory (ls_MailDir)
end if
//---------------------------- APPEON END ----------------------------

// save the datawindow as a Pdf file
object.DataWindow.Export.PDF.Method = Distill!
Object.DataWindow.Printer = invo_pdf.is_pdf_printer
Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"

If appeongetclienttype() = 'PB' Then
	//Start Code Change ----10.27.2009 #V10 maha - rewrote to get file name for message display
	// changed to use Customer pdf printer for all OS for windows 7
//	if invo_pdf.of_set_path( ) = failure then return -1
	//----------Begin Modified by Alfee on 12.24.2008-------------
	//<$Reason>As the PDF driver from PB is not supported in Vista, 
	//<$Reason>using Customer PDFPrinter instead of it.
//	If Pos(appeonGetOSType(),"6.") > 0 THEN //Vista
	if f_PrinterSetup(1) = 1 then return -1
	Object.DataWindow.Printer = "Customer PDFPrinter"
//	Else
//		if invo_pdf.of_add_pdf_printer() = failure then return -1	
//	End If
	//if invo_pdf.of_add_pdf_printer() = failure then return -1	
	//	---------End Modified -------------------------------------

	//$<modify> 03.13.2008 by: Andy
	//saveas(gs_dir_path + 'intellicred\Mail\' + Object.DataWindow.Print.DocumentName + ".PDF" ,pdf!,True) //Start Code Change ---- 04.26.2006 #419 maha
	if Object.DataWindow.Print.DocumentName = "?" or Object.DataWindow.Print.DocumentName = "!" or &
		trim(Object.DataWindow.Print.DocumentName) = "" then
		saveas(gs_temp_path + 'Mail\MAttachment.PDF' ,pdf!,True)
	else
		saveas(gs_temp_path + 'Mail\' + Object.DataWindow.Print.DocumentName + ".PDF" ,pdf!,True) //Start Code Change ---- 04.26.2006 #419 maha
	end if
	//end of modify 03.13.2008
	//End Code Change---10.27.2009
Else
	//<add> 10/22/2007 by: Andy
	String 	ls_prntrs,ls_SourceFile,ls_filename
	integer 	li_file
	
	//Check PDF Printer
	if f_PrinterSetup(2) >= 2 then return -1	//Added by Scofield on 2007-11-09
	ls_prntrs = PrintGetPrinters ( )
	IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
		MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
		RETURN -1
	END IF
	
	//Convert to PDF, get & convert all Word documents 
	ls_SourceFile = gs_temp_pdf
	
	//Delete temporary pdf file 
	IF FileExists(ls_SourceFile) THEN 
		IF Not FileDelete(ls_SourceFile) THEN 
			MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")						
			RETURN -1
		END IF
	END IF
	
	//Start Code By Jervis 04.17.2008
	//Get file name
	ls_filename = object.DataWindow.Print.DocumentName
	if ls_filename = '?' or ls_filename = '!' or trim(ls_filename) = '' or isnull(ls_filename) or Pos(ls_filename,"<PATH>=") > 0 then 
		ls_filename = 'MAttachment.pdf'
	end if
	//End Code By Jervis 04.17.2008

		
	//Set pdf Printer and print to PDF format
	Try
		IF Object.DataWindow.Print.FileName <> "" THEN 
			Object.DataWindow.Print.FileName = ""
		end if
		if object.DataWindow.Print.DocumentName <> "" then 
			object.DataWindow.Print.DocumentName = ""
		end if
		if f_PrinterSetup(2) >= 2 then return -1					//Added by Scofield on 2007-11-09
		
		ls_CurPrinter = PrintGetPrinter()							//Added by Scofield on 2008-05-12
		
		PrintSetPrinter("IntelliSoft PDF Writer")
		this.print( false )
		
		PrintSetPrinter(ls_CurPrinter)								//Added by Scofield on 2008-05-12
	Catch(Throwable th1)
		MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")			
		RETURN -1
	End Try
	
	//ls_filename = 'MAttachment.pdf'	04.17.2008 By Jervis
	ls_filename = gs_temp_path + 'Mail\'  + ls_filename
	
	Do 
		Yield()
		If FileExists(ls_sourcefile) Then 
			li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
		Else
			li_file = -1
		End If
	Loop While li_file = -1
	FileClose(li_file)
	lnv_filesrv.of_filecopy(ls_sourcefile, ls_filename )

End If

Destroy lnv_filesrv
Return 0  
//---------------------------- APPEON END ----------------------------
*/
//---------------------------- APPEON END ----------------------------
end event

event ue_mail_bak(string as_subject, string as_notetext);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_mail
//==================================================================================================================
//  Purpose   	: Saves a datawindow to PDF and mails it OUTLOOK
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Use OLE for Outlook 64-bit, Added by Appeon long.zhang 05.03.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
If gb_outlook_64bit Then 
	Event ue_mail_outlook64(as_subject, as_notetext)
	Return 
End If

mailSession				mSes
mailReturnCode			mRet
mailMessage			   mMsg
mailFileDescription	mAttach
string					ls_ret, ls_syntax, ls_name, ls_open_pathname, ls_filename
string			      ls_attach_name				
int						li_index, li_nret, li_nrecipients, li_nfile
boolean 				   lb_noerrors
n_cst_dirattrib   lnv_dirlist[]

n_cst_filesrvwin32 inv_filesrv

inv_filesrv = create n_cst_filesrvwin32

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check to see the directory exists if it does not then create it
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ---- 04.26.2006 #421 maha  changed path to gs_dir_path + 'intellicred\'
IF NOT inv_filesrv.of_DirectoryExists (gs_temp_path + 'Mail') THEN
       inv_filesrv.of_CreateDirectory (gs_temp_path + 'Mail')
END IF


/// if ther is no dataobject retuen
if LenA(Describe("DataWindow.Syntax") ) = 0 then 
 // no datawindow
  return
end if

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Establish an instance of the Mail Session object, and log on
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
mMsg.notetext = as_notetext
mMsg.Subject =  as_subject


mSes = create mailSession
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2006 By: LeiWei
//$<reason> 
mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Note: If the mail-system user ID and password are known, they could be hard-coded here, as shown in the
//			commented-out statement that follows.  If user ID and password are not supplied, it is assumed that they
//			are stored in MSMAIL.INI
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mRet = mSes.mailLogon ( mailNewSession! )
If mRet <> mailReturnSuccess! Then
	MessageBox ("Mail Logon", 'Return Code <> mailReturnSuccess!' )
	return
End If


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Copy user's subject to the mail message.
//	Set return receipt flag If needed.
//	Build an Attachment structure, and assign it to the mail message.
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_file_count
long ll_count 
string res

ll_file_count = inv_filesrv.of_DirList ( gs_temp_path + 'Mail\*.*', 0, lnv_dirlist )

for ll_count = 1 to  ll_file_count
	mAttach.FileType = mailAttach!
   mAttach.PathName =  gs_temp_path + 'Mail\' +lnv_dirlist[ll_count].is_filename
   mAttach.FileName =  gs_temp_path + 'Mail\' +lnv_dirlist[ll_count].is_filename

   mAttach.Position = LenA(mMsg.notetext)  -1	
	mMsg.AttachmentFile[ll_count] = mAttach
next

mRet = mSes.mailsend ( mMsg )
//res = string(mRet)
//messagebox("Email send", res)

mSes.mailLogOff()
destroy mSes //added by long.zhang 10.12.2011 need destroy

for ll_count = 1 to  ll_file_count
	FileDelete ( gs_temp_path + 'Mail\' +lnv_dirlist[ll_count].is_filename )
next
//End Code Change---04.26.2006
destroy inv_filesrv

end event

event ue_email_current_dw();//Start Code Change ----08.25.2009 #V92 maha - added as a generic call to email a dw

long ll_Rtn

//ll_Rtn = this.triggerevent("ue_save_pdf_for_mailing")
ll_Rtn = this.event ue_save_pdf_for_mailing()	//long.zhang 10.12.2011
if ll_Rtn < 0 then return

if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	//this.triggerevent("ue_mail_bak" ,1,'Report' )
	
	this.event ue_mail_bak('1','Report')	//long.zhang 10.10.2011
else
	//this.triggerevent("ue_mail", 1, 'Report' )
	this.event ue_mail('1', 'Report' )	//long.zhang 10.10.2011
end if

//End Code Change---08.25.2009
end event

event ue_nchittest;//Make it immovable for Bug 2683 - alfee 09.30.2011

if this.titlebar then 
	//return 1
	return 0  //maha 10.01.2011 - changed because it broke other things like the scroll bar.
end if
end event

event type integer ue_isudw();//====================================================================
//$<Event>: ue_isudw
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Added By Ken.Guo 11/14/2011. 
Return 0

end event

event mousemove;//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
//Show Tips
String 	ls_object,ls_tips,ls_tag
long		ll_start,ll_end
object	lo_null

if ib_ShowTipsHelp then 
	ls_Object = GetObjectAtPointer()
	ls_Object = left(ls_Object,Pos(ls_Object,"~t") -1)
	If AppeonGetClientType() = 'PB' Then
//		If is_last_object_tips  = ls_object Then Return
	End If
	if len(ls_Object)>0 then 
		ls_tag = this.describe(ls_Object + ".tag")  //the tip contain in .{}
		if len(ls_tag) > 0 then 
			ll_start = Pos(ls_tag,".{")
			if ll_start > 0 then 
				ll_End = Pos(ls_tag,"}.",ll_start)
				if ll_End >0 then 
					ls_tips = mid(ls_tag,ll_start + 2,ll_end - ll_start - 2) 
					iuo_tips.settiptext(this,1,ls_tips)
				else
					iuo_tips.settiptext(this,1,"")
				end if
			else
				iuo_tips.settiptext(this,1,"")
			end if
		else
			iuo_tips.settiptext(this,1,"")
		end if 
	else
		iuo_tips.settiptext(this,1,"")
	end if 
	iuo_tips.relaymsg(this)
	is_last_object_tips  = ls_object 
end if 


//---------End Added ------------------------------------------------------------------

end event

event ue_key;//====================================================================
//$<Event>: ue_key
//$<Arguments>:
// 	value    keycode         key
// 	value    unsignedlong    keyflags
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add by jervis 06.25.2010
//Add Type down capability Feature
long ll_find
string ls_style
if ib_typedown then
	if of_get_typedown_value(key,keyflags) = 1 then
		ls_style =  this.Describe( is_typedown_name + ".edit.style")
		if ls_style = '!' then ls_style = 'edit'
		if ls_style = 'dddw' or ls_style = 'ddlb' then
			ll_find = this.find("Upper(LookUpDisplay(" + is_typedown_name + ")) like '" + is_typedown_value + "%'", 1, this.RowCount())	
		elseif ls_style = 'edit' then
			ll_find = this.find("Upper(" + is_typedown_name + ") like '" + is_typedown_value + "%'", 1, this.RowCount())	
		else
			return
		end if
		if ll_find > 0 then
			this.Scrolltorow( ll_find)
			this.selectrow( 0,false)
			this.selectrow(ll_find,true)
		else
			is_typedown_value = ""
			if of_get_typedown_value(key,keyflags) = 1 then
				if ls_style = 'dddw' or ls_style = 'ddlb' then
					ll_find = this.find("Upper(LookUpDisplay(" + is_typedown_name + ")) like '" + is_typedown_value + "%'", 1, this.RowCount())	
				elseif ls_style = 'edit' then
					ll_find = this.find("Upper(" + is_typedown_name + ") like '" + is_typedown_value + "%'", 1, this.RowCount())	
				else
					return
				end if
				if ll_find > 0 then
					this.Scrolltorow( ll_find)
					this.selectrow( 0,false)
					this.selectrow(ll_find,true)
				else
					is_typedown_value = ""
				end if
			end if
		end if
	end if
end if

end event

event ue_saveas_excel(boolean ab_header);//====================================================================
//$<Event>: ue_saveas_excel
//$<Arguments>:
// 	value    boolean    ab_header
//$<Return>:  (None)
//$<Description>: Depends n_cst_excel and gf_GetExcelVersion object in appeon_contract.pbl
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add by jervis 01.05.2010
//Export to excel format

n_cst_excel lnv_excel
string ls_path,ls_file
integer li_rc
boolean	ab_Version

gf_load_dir_path()

If Integer( gf_GetExcelVersion( ) ) >=12 Then
	li_rc = GetFileSaveName ( "SaveAs Excel", ls_path, ls_file, "EXCEL", "Excel Files (*.xlsx),*.xlsx" )	
	ab_Version = true
Else
	li_rc = GetFileSaveName ( "SaveAs Excel", ls_path, ls_file, "EXCEL", "Excel Files (*.xls),*.xls" )
End If

if li_rc = 1 then
	lnv_excel = create n_cst_excel
	lnv_excel.of_saveas_excel( this,ls_path,ab_header, ab_Version )
	destroy lnv_excel
end if
gf_Save_dir_path(ls_path)

end event

event ue_afterpowerfilter();// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//Added By Ken.Guo 10/30/2012. Support PowerFilter.
Return
end event

event ue_dwsyscommand;//====================================================================
// Event: ue_dwsyscommand
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	commandtype
// 	xpos
// 	ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-12-05
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History: moved from u_dw_contract by alfee 10.09.2014
//====================================================================

if commandtype = 61458 and ib_move_dw = False Then
	message.processed = true
	message.returnvalue = 0
end if

end event

event ue_mail_outlook64(string as_subject, string as_notetext);//====================================================================
//$<Event>: ue_mail_outlook64
//$<Arguments>:
// 	value    string    as_subject
// 	value    string    as_notetext
//$<Return>:  (None)
//$<Description>: Saves a datawindow to PDF and mails it OUTLOOK, Used for Outlook 64-bits, called by ue_mail_bak() event
//$<Author>: (Appeon) long.zhang 05.03.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

n_cst_outlook lnv_Outlook
n_cst_filesrvwin32 inv_filesrv
n_cst_dirattrib   lnv_dirlist[]
Long ll_file_count
Long ll_count 
Long ll_Return
string res
String ls_FileName
String ls_AttachmentFiles


inv_filesrv = create n_cst_filesrvwin32

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check to see the directory exists if it does not then create it
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
IF NOT inv_filesrv.of_DirectoryExists (gs_temp_path + 'Mail') THEN
       inv_filesrv.of_CreateDirectory (gs_temp_path + 'Mail')
END IF

//if there is no dataobject return
if LenA(Describe("DataWindow.Syntax") ) = 0 then 
	return
end if

if lnv_Outlook.of_Logon() = -1 then
	MessageBox("Mail Logon", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
	Return
end if

//AttachmentFiles
ll_file_count = inv_filesrv.of_DirList ( gs_temp_path + 'Mail\*.*', 0, lnv_dirlist )

for ll_count = 1 to  ll_file_count
   	ls_FileName =  gs_temp_path + 'Mail\' +lnv_dirlist[ll_count].is_filename
	If ll_count= 1 Then
		ls_AttachmentFiles = ls_FileName
	Else
		ls_AttachmentFiles = ',' + ls_FileName //sperated by comma
	End If	
next

//Send Mail
ll_Return = lnv_Outlook.of_Send("", "", "", as_subject, as_notetext, ls_AttachmentFiles)
lnv_Outlook.of_Logoff()
if ll_Return <> 1 then
	MessageBox("Mail Send", "Mail not sent.")
	Return
end if

//Delete file
For ll_count = 1 to  ll_file_count
	FileDelete ( gs_temp_path + 'Mail\' +lnv_dirlist[ll_count].is_filename )
Next

Destroy inv_filesrv

Return
end event

public function long of_get_next_record_id ();
/******************************************************************************************************************
**  [PUBLIC]   : of_get_next_record_id
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

// start code change --- 11.01.2005 MSKINNER
return gnv_app.of_get_id('RECORD_ID')
// end code change --- 11.01.2005 MSKINNER
end function

public function integer of_notify_error (string as_subject, string as_notetext, string as_person[]);/****************************************************************************************************************
** [PUBLIC] Function of_notify_error 
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] string as_subject      <Description>
**	[value] string as_notetext      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(INTEGER) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
** 02 March 2006     mskinner 				moved the for loop to the top
**                                        added BOOLEAN LB_SHOW_MESSAGE
****************************************************************************************************************/

BOOLEAN LB_SHOW_MESSAGE = TRUE

String				ls_notesubject
String				ls_notetext
string 				ls_Recipient
string 				ls_userName
Integer				li_i
Integer				li_count
Integer				li_addresscount
Integer				li_rc
mailReturnCode		lmrc_mRet
mailMessage  		lmm_mMsg
mailSession  	ims_mSes		

// do not send message during development
//IF Handle(GetApplication()) = 0 THEN 
//	return success
//end if 


ims_mSes=  CREATE mailsession 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2006 By: LeiWei
//$<reason> 
lmrc_mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------

ims_mSes.mailLogon(mailNewSession!)
string ls_first_name,ls_first_nameA
string  ls_last_name

// start code change --- 10.31.2005 MSKINNER
if FileExists ( word_2003_pth ) then 
			IF LB_SHOW_MESSAGE THEN 
			   Messagebox('IntelliCred','Please allow the following email to be sent to IntellisoftGroup. This will allow us to better serve you, thank you.')
			   LB_SHOW_MESSAGE = FALSE
		   END IF
end if 
// end   code change --- 10.31.2005 MSKINNER


If IsNull(ims_mSes) Or Not IsValid(ims_mSes) Then
	Messagebox("Mail Error", "A Mail connection  could no be made")
	Return 0
End If

FOR  li_i = 1 TO UPPERBOUND(as_person)
	//////////////////////////////////////////////////////////////////////////////
	// Populate the Message Recipients
	//////////////////////////////////////////////////////////////////////////////

	lmm_mMsg.Recipient[li_i].Name = as_person[li_i]
	
	//---------- APPEON BEGIN ----------
	//$<add> Evan 06.13.2012
	//$<reason> V12.2-Email Logging
	if Len(ls_Recipient) > 0 then ls_Recipient += "; "
	ls_Recipient += as_person[li_i]
	//---------- APPEON END ------------
	
	string ls_notetext1
	ls_notetext1 = as_notetext
	
	// Populate the Message Subject.
	lmm_mMsg.Subject = as_subject
	
	// Populate the Message Text. 
	lmm_mMsg.NoteText = ls_notetext1
NEXT		
	
// Send the mail.
lmrc_mRet = ims_mSes.mailSend ( lmm_mMsg )

// Check for a succesful Send Mail.
If lmrc_mRet <> mailReturnSuccess! Then
	destroy ims_mSes
	Messagebox("Mail Error", "The mail was not properly sent!!")
	Return -1
End If
destroy ims_mSes

//---------- APPEON BEGIN ----------
//$<add> Evan 06.13.2012
//$<reason> V12.2-Email Logging
blob lblb_MailContent
n_cst_email_log lnv_EmailLog
lblb_MailContent = Blob(ls_notetext1, EncodingANSI!)
lnv_EmailLog.of_SaveSentItem(gs_user_id,as_Subject,"",ls_Recipient,"","","",2,2,lblb_MailContent)
//---------- APPEON END ------------

Return success
end function

public subroutine of_setrmbmenu (boolean ab_show);//////////////////////////////////////////////////////////////////////
// $<function>u_dwof_setrmbmenu()
// $<arguments>
//		value	blob	ab_show		True: Enabled RMB menu; False: Disable RMB menu
// $<returns> (none)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08/21/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
ib_RMBmenu = ab_show
end subroutine

public subroutine of_autodatafill (long al_viewid, long al_screenid, string as_fieldname, long al_row, string as_data);/******************************************************************************************************************
**  [PUBLIC]   : of_autodatafill
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: long al_viewid,long al_screenid,string as_fieldname,long al_row,string as_data
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Scofield 2007-10-25  © Appeon, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long		ll_Cycle,ll_RowCnt,ll_LookUpCode,ll_FillStrLen
String	ls_FillField,ls_MapField,ls_ColType,ls_FillData,ls_Date,ls_Time
Date		ld_FillData
Time		lt_FillData
DateTime	ldt_FillData

DataStore	lds_FieldFill

ll_LookUpCode = long(as_data)
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
If al_viewid = 0 Then al_viewid = gi_contract_view_id //Added By Ken.Guo 07/11/2012. use current view
//---------End Added ------------------------------------------------------------------

if al_viewid <= 0 or al_screenid <= 0 or ll_LookUpCode = -777 or IsNull(ll_LookUpCode) then return

lds_FieldFill = Create DataStore

lds_FieldFill.DataObject = "d_contract_field_properties_datafill"
lds_FieldFill.SetTransObject(SQLCA)
lds_FieldFill.Retrieve(al_ViewId,al_ScreenId,as_FieldName)

ll_RowCnt = lds_FieldFill.RowCount()
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
string ls_reftype
long   ll_days
ls_RefType = Lower(This.Describe(as_FieldName + ".Coltype"))

if Upper(ls_RefType) = Upper('datetime') or Upper(ls_RefType) = Upper('date') then
	for ll_Cycle = 1 to ll_RowCnt
		ls_FillField = lds_FieldFill.GetItemString(ll_Cycle,'field_name_fill')
		
		if Not of_IsAllowEdit(al_Row,ls_FillField) then Continue
		
		ll_Days = lds_FieldFill.GetItemNumber(ll_Cycle,'relative_days')
		if IsNull(ll_Days) then ll_Days = 0
				
		if Upper(ls_RefType) = Upper('datetime') then
			ldt_FillData = DateTime(RelativeDate(Date(as_data),ll_Days),Time(as_data))
			This.SetItem(al_Row,ls_FillField,ldt_FillData)
		else
			ld_FillData = RelativeDate(Date(as_data),ll_Days)
			This.SetItem(al_Row,ls_FillField,ld_FillData)
		end if
	next
else
//---------End Added ------------------------------------------------------------------

	for ll_Cycle = 1 to ll_RowCnt
		ls_FillField = lds_FieldFill.GetItemString(ll_Cycle,'field_name_fill')
		if Not of_IsAllowEdit(al_Row,ls_FillField) then Continue//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
		ls_MapField = lds_FieldFill.GetItemString(ll_Cycle,'field_name_map')
		
		ls_FillData = gnv_data.of_getitem('code_lookup', ls_MapField, "lookup_code=" + String(ll_LookUpCode))
		
		if Not IsNull(ls_FillData) then
			ls_ColType = Lower(This.Describe(ls_FillField + ".Coltype"))
			Choose Case ls_ColType
				Case 'date'
					if IsDate(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Date(ls_FillData))
					elseif PosA(ls_FillData,' ') > 0 then
						ls_Date = LeftA(ls_FillData,PosA(ls_FillData,' ') - 1)
						if IsDate(ls_Date) then
							This.SetItem(al_row,ls_FillField,Date(ls_Date))
						end if
					end if
				Case 'time'
					if IsTime(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Time(ls_FillData))
					elseif PosA(ls_FillData,' ') > 0 then
						ls_Time = MidA(ls_FillData,PosA(ls_FillData,' ') + 1)
						if IsTime(ls_Time) then
							This.SetItem(al_row,ls_FillField,Time(ls_Time))
						end if
					end if
				Case 'datetime'
					if PosA(ls_FillData,' ') > 0 then
						ls_Date = LeftA(ls_FillData,PosA(ls_FillData,' ') - 1)
						ls_Time = MidA(ls_FillData,PosA(ls_FillData,' ') + 1)
						
						if IsDate(ls_Date) and IsTime(ls_Time) then
							ldt_FillData = DateTime(Date(ls_Date),Time(ls_Time))
							This.SetItem(al_row,ls_FillField,ldt_FillData)
						end if
					else
						if IsDate(ls_FillData) then
							ld_FillData = Date(ls_FillData)
							lt_FillData = 00:00:00
							
							ldt_FillData = DateTime(ld_FillData,lt_FillData)
							This.SetItem(al_row,ls_FillField,ldt_FillData)
						elseif IsTime(ls_FillData) then
							lt_FillData = Time(ls_FillData)
							ld_FillData = 1900-01-01
							
							ldt_FillData = DateTime(ld_FillData,lt_FillData)
							This.SetItem(al_row,ls_FillField,ldt_FillData)
						end if
					end if
				Case 'int'
					if IsNumber(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Integer(ls_FillData))
					end if
				Case 'long'
					if IsNumber(ls_FillData) then
						This.SetItem(al_row,ls_FillField,long(ls_FillData))
					end if
				Case 'number'
					if IsNumber(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Double(ls_FillData))
					end if
				Case 'real'
					if IsNumber(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Real(ls_FillData))
					end if
				Case 'ulong'		//Have not find the becomingly data type conversion function
					if IsNumber(ls_FillData) then
						This.SetItem(al_row,ls_FillField,Double(ls_FillData))
					end if
				Case else
					if PosA(ls_ColType,'char') > 0 then
						if PosA(ls_ColType,'(') > 0 and PosA(ls_ColType,')') > 0 then
							ll_FillStrLen = long(MidA(ls_ColType,PosA(ls_ColType,'(') + 1,PosA(ls_ColType,')') - PosA(ls_ColType,'(') - 1))
							if ll_FillStrLen < LenA(ls_FillData) then
								ls_FillData = LeftA(ls_FillData,ll_FillStrLen)
							end if
						end if
						This.SetItem(al_row,ls_FillField,ls_FillData)
					elseif PosA(ls_ColType,'decimal') > 0 then
						if IsNumber(ls_FillData) then
							This.SetItem(al_row,ls_FillField,Dec(ls_FillData))
						end if
					end if
			End Choose
		end if
	next
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
end if
//---------End Added ------------------------------------------------------------------

Destroy lds_FieldFill

end subroutine

public subroutine of_setviewscreen (long al_viewid, long al_screenid);il_ViewId = al_ViewId
il_ScreenId = al_ScreenId
end subroutine

public function integer of_showphonenumberdlg (string as_colname);//////////////////////////////////////////////////////////////////////
// $<function> of_showphonenumberdlg
// $<arguments>
//			string	as_ColName
// $<returns> integer
// $<description> Popup a dialog to input the phone.
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.19.2009
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_FieldID
String ls_Mask,ls_Phone,ls_RetParm

ll_Row = this.GetRow()
if ll_Row <= 0 or as_ColName = "datawindow" then Return -1

ll_FieldID = long(This.Describe(as_ColName + ".Tag"))
SELECT field_mask INTO :ls_Mask FROM sys_fields WHERE field_id = :ll_FieldID and field_name = :as_ColName;

if Trim(ls_Mask) = "INTPHONE" then
	this.AcceptText()
	ls_Phone = this.GetItemString(ll_Row, as_ColName)
	OpenWithParm(w_phonedetail, ls_Phone)
	ls_RetParm = Message.StringParm
	if ls_RetParm <> "Cancel" then
		this.SetItem(ll_Row, as_ColName, ls_RetParm)
	end if
	this.SetColumn(as_ColName)
else
	Return -1
end if

Return 1
end function

public function integer of_print (boolean ab_canceldialog, boolean ab_showprintdialog);/******************************************************************************************************************
**  [PUBLIC]   : of_print
**==================================================================================================================
**  Purpose   	: To workaound the Print function with 2 arguments in a Web application (Ticket # 00033410）
**==================================================================================================================
**  Arguments : Boolean ab_canceldialog, ab_showprintdialog
**==================================================================================================================
**  Returns   	: Integer
**==================================================================================================================
**  Notes     	: The CancelDialog argument specified in the Print function will be ignored in a Web application, and no Cancel dialog will be displayed on the Web to cancel printing. 
					  The ShowPrintDialog argument specified in the Print function is unsupported and will cause the Print function failed in a Web application.
**==================================================================================================================
**  Created By	: Alfee 01.05.2012  © Appeon, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
Integer li_rtn

IF appeongetclienttype() = "PB" THEN		//PB version
	li_rtn = This.Print(ab_canceldialog, ab_showprintdialog)
ELSE												//Web version
	IF ab_showprintdialog THEN
		IF PrintSetup () <> 1 THEN RETURN -1
	END IF
	li_rtn = This.Print (ab_canceldialog)		
END IF

RETURN li_rtn

end function

public function boolean of_isallowedit (long al_row, string as_colname);//====================================================================
// Function: of_IsAllowEdit()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_Row
// 	value    string    as_ColName
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//====================================================================

String	ls_TabOrder,ls_ProExp,ls_Protect
		
ls_TabOrder = This.Describe(as_ColName + ".TabSequence")
if ls_TabOrder = '0' then Return false

ls_ProExp = Trim(This.Describe(as_ColName + ".Protect"))

if Left(ls_ProExp,1) = '"' and Right(ls_ProExp,1) = '"' or Left(ls_ProExp,1) = "'" and Right(ls_ProExp,1) = "'" then
	ls_ProExp = Mid(ls_ProExp,2,Len(ls_ProExp) - 2)
end if

if Pos(ls_ProExp,"~t") > 0 then
	ls_ProExp = Mid(ls_ProExp,Pos(ls_ProExp,"~t") + Len("~t"))
end if

ls_Protect = This.Describe("Evaluate('" + ls_ProExp + "'," + String(al_Row) + ")")
if ls_Protect = '1' then Return false

Return True

end function

public function integer of_get_typedown_value (keycode key, unsignedinteger keyflag);//====================================================================
//$<Function>: of_get_typedown_value
//$<Arguments>:
// 	value    keycode            key
// 	value    unsignedinteger    keyflag
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add type down feature - jervis 06.25.2010
//of_get_typedown_value
STRING ls_key
if keyflag > 0 then return 0

choose case key
	case keyA!
		ls_key  = "A"
	case keyB!
		ls_key  = "B"
	case keyC!
		ls_key  = "C"
	case keyD!
		ls_key  = "D"
	case keyE!
		ls_key  = "E"
	case keyF!
		ls_key  = "F"
	case keyG!
		ls_key  = "G"
	case keyH!
		ls_key  = "H"
	case keyI!
		ls_key  = "I"
	case keyJ!
		ls_key  = "J"
	case keyK!
		ls_key  = "K"
	case keyL!
		ls_key  = "L"
	case keyM!
		ls_key  = "M"
	case keyN!
		ls_key  = "N"
	case keyO!
		ls_key  = "O"
	case keyP!
		ls_key  = "P"
	case keyQ!
		ls_key  = "Q"
	case keyR!
		ls_key  = "R"
	case keyS!
		ls_key  = "S"
	case keyT!
		ls_key  = "T"
	case keyU!
		ls_key  = "U"
	case keyV!
		ls_key  = "V"
	case keyW!
		ls_key  = "W"
	case keyX!
		ls_key  = "X"
	case keyY!
		ls_key  = "Y"
	case keyZ!
		ls_key  = "Z"
	case key1!
		ls_key  = "1"
	case key2!
		ls_key  = "2"
	case key3!
		ls_key  = "3"
	case key4!
		ls_key  = "4"
	case key5!
		ls_key  = "5"
	case key6!
		ls_key  = "6"
	case key7!
		ls_key  = "7"
	case key8!
		ls_key  = "8"
	case key9!
		ls_key  = "9"
	case key0!
		ls_key  = "0"
	case else
		return 0
end choose
is_typedown_value += ls_key
return 1
end function

public subroutine of_fielddependfilter (long al_viewid, long al_screenid, string as_fieldname, long al_row, boolean ab_filter, string as_ori_filter);/******************************************************************************************************************
**  [PUBLIC]   : of_fielddependfilter
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: long al_viewid,long al_screenid,string as_fieldname,long al_Row
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: jervis 09.27.2009
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**(Appeon)Toney 06.04.2013 - V141 ISG-CLX depends n_cst_globaldata object in appeon_workaround.pbl
********************************************************************************************************************/
long ll_Count,ll_i
string ls_ori_filter
n_cst_string lnv_string
datastore lds_base
datastore lds_lookup_depend
string ls_base_lookup_name[]
string ls_base_lookupnames
string ls_depend_lookup_name
string ls_base_field[]
string ls_base_table[]
string ls_base_sql[]
long ll_depend_code[]
long 	ll_base_screen[]
long 		ll_base_code_single[]
long 		ll_base_code_multi[]
string ls_base_screen_type[]
string ls_base_codes
string ls_depend_codes
string ls_coltype
string ls_style
string ls_SQL
string ls_add_lookup
long ll_ctx_id
datawindow ldw_screen

datawindowchild ldwc_child
if al_viewid <= 0 or al_screenid <= 0 then Return
if this.GetChild(as_fieldname,ldwc_child) <> 1 then return

//Added By Ken.Guo 02/22/2012. Reset it. Because some using depend data's DDDW display as numeric.
//If you want to filter the DWC data, you can use other way to do it. 
//e.g.  set sharedata to off, then copy the data to dwc, then filter data and delete filter data.
as_ori_filter = '' 

if len(as_ori_filter) > 2 then ls_ori_filter = "(" + as_ori_filter + ") and  "

gnv_data.of_retrieveIfNecessary("depend_field", FALSE)//Added by Appeon long.zhang 03.18.2016 (for v151 performance changes)

//Get Base Fields
gnv_data.ids_field_depend.setfilter("view_id = " + string(al_viewid) + " and depend_screen_id =" + string(al_screenid) + " and depend_field ='" + as_fieldname + "'")
gnv_data.ids_field_depend.Filter( )
ll_Count = gnv_data.ids_field_depend.Rowcount( )
//if ll_Count < 1 then return

if ab_filter then
	//Get "Add on Fly " access - jervis 01.26.2011
	select field_add into :ls_add_lookup from ctx_screen_field_ex 
	where data_view_id = :al_viewid and screen_id = :al_screenid and field_name = :as_fieldname;
	
	if ll_count > 0 then
		//Get base field name
		ls_base_field[] = gnv_data.ids_field_depend.object.base_field.primary
		ll_base_screen[] = gnv_data.ids_field_depend.object.base_screen_id.primary
		ls_base_table[] = gnv_data.ids_field_depend.object.base_table.primary
		ls_base_screen_type = gnv_data.ids_field_depend.object.base_screen_type.primary

	

	
		//Get base_code
		for ll_i = 1 to ll_Count
			if ls_base_screen_type[ll_i] = "S" then //Get Base code - Single Screen Type
				if isvalid(gw_contract) and gw_contract.tab_contract_details.ib_select2 then
					choose case ll_base_screen[ll_i]
						case 3
							ldw_screen = gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1
						case 5
							ldw_screen = gw_contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates
						case 9
							ldw_screen = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1
					end choose
					if isvalid(ldw_screen) and ldw_screen.rowcount( ) > 0 then
						if ldw_screen.Describe( ls_base_field[ll_i] + ".edit.style") = 'dddw' then
							ls_coltype = ldw_screen.Describe( ls_base_field[ll_i]+".coltype")
							CHOOSE CASE Left ( ls_coltype , 5 )
								CASE "char(", "char"				//  CHARACTER DATATYPE
									ll_base_code_multi[ll_i] = long(ldw_screen.GetItemString ( 1, ls_base_field[ll_i]) )
								CASE "decim"				//  DECIMAL DATATYPE
									ll_base_code_multi[ll_i] = long(ldw_screen.GetItemDecimal (1, ls_base_field[ll_i])) 
								CASE "numbe", "doubl", "real","long", "ulong", "int"		//  DOUBLE and LONG DATATYPE	
									ll_base_code_multi[ll_i] = long(ldw_screen.GetItemNumber (1, ls_base_field[ll_i])) 
							END CHOOSE
						end if
					else
						ll_ctx_id = gw_contract.tab_contract_details.tabpage_search.inv_contract_details.of_get_ctx_id( )
						choose case ll_base_screen[ll_i]
							case 3,5,9
								ls_base_sql[ll_i] = "select convert(int," + ls_base_field[ll_i] + ") as base_field_value from " + ls_base_table[ll_i] + " where ctx_id = " + string(ll_ctx_id)
							end choose
					end if
				end if
			else //Get Base code - Multi Screen Type
				if this.Describe( ls_base_field[ll_i] + ".edit.style") = 'dddw' then
					ls_coltype = this.Describe( ls_base_field[ll_i]+".coltype")
					CHOOSE CASE Left ( ls_coltype , 5 )
						CASE "char(", "char"				//  CHARACTER DATATYPE
							ll_base_code_multi[ll_i] = long(this.GetItemString ( al_row, ls_base_field[ll_i]) )
						CASE "decim"				//  DECIMAL DATATYPE
							ll_base_code_multi[ll_i] = long(this.GetItemDecimal (al_row, ls_base_field[ll_i])) 
						CASE "numbe", "doubl", "real","long", "ulong", "int"		//  DOUBLE and LONG DATATYPE	
							ll_base_code_multi[ll_i] = long(this.GetItemNumber (al_row, ls_base_field[ll_i])) 
					END CHOOSE
				end if
			end if
		next
	
	
		//Get Base code - Single screen type
		lnv_string.of_arraytostring(ls_base_sql,' Union ',false,ls_SQL)
		if ls_sql <> "" then
			lds_base = create datastore
			lds_base.dataobject = 'd_base_field_value'
			lds_base.SetTransObject(sqlca)
			lds_base.SetSqlSelect( ls_sql)
			lds_base.Retrieve()
			ll_base_code_single[] = lds_base.object.base_field_value.primary
			destroy lds_base
		end if
	
	
	
		//Get Depend Codes by base code
		//ls_sql = select depend_lookup_code 
		//from ctx_lookup_depend 
		//where base_lookup_code = 117402 and depend_lookup_code in (select depend_lookup_code 
		//from ctx_lookup_depend 
		//where (base_lookup_code = 114821)) and depend_lookup_code in (....)
		ll_count = UpperBound(ll_base_code_multi)
		ls_sql = ""
		for ll_i = 1 to ll_count
			if ll_base_code_multi[ll_i] = 0 then continue
			if ls_sql = "" then
				//Modified By Mark Lee 04/17/12 fixed bug
//				ls_sql = "select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_multi[ll_i]) 
				ls_sql = "select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_multi[ll_i]) + " and view_id = " + string(al_viewid)
			else
				ls_sql = ls_sql + " and depend_lookup_code in (select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_multi[ll_i]) + ")"
			end if
		next
		ll_count = UpperBound(ll_base_code_single)
		//ls_sql = ""
		for ll_i = 1 to ll_count
			if ll_base_code_single[ll_i] = 0 then continue
			if ls_sql = "" then
				//Modified By Mark Lee 04/17/12  fixed bug
//				ls_sql = "select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_single[ll_i]) 
				ls_sql = "select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_single[ll_i]) + " and view_id = " + string(al_viewid)
			else
				ls_sql = ls_sql + " and depend_lookup_code in (select depend_lookup_code from ctx_lookup_depend where base_lookup_code = " + string(ll_base_code_single[ll_i]) + ")"
			end if
		next
	end if
	
	if ls_sql <> "" then
		lds_lookup_depend = create Datastore
		lds_lookup_depend.dataobject = "d_depend_lookup_code"
		lds_lookup_depend.SetTransobject( sqlca)
		lds_lookup_depend.Setsqlselect(ls_sql)
		lds_lookup_depend.retrieve( )
		//gnv_data.ids_lookup_depend.SetFilter("base_lookup_code in(" + ls_base_codes + ")")
		//gnv_data.ids_lookup_depend.Filter( )
		if lds_lookup_depend.RowCount( ) > 0 then
			ll_depend_code[] = lds_lookup_depend.object.depend_lookup_code.primary
				
			lnv_string.of_arraytostring(ll_depend_code,',',ls_depend_codes)
			//add 'ls_add_lookup <> 'N' -- jervis 01.26.2011
			If (w_mdi.of_security_access(2075) <> 0 and ls_add_lookup <> 'N') and al_screenid <> 1 Then //Allow access for Add LookUp Data and not Search Screen
				//ll_depend_code[UpperBound(ll_depend_code) + 1] = -777
				ldwc_child.SetFilter(ls_ori_filter +  " (lookup_code in (" +ls_depend_codes+ ") or lookup_code = -1 or lookup_code = -777 or lookup_code = -999 or isnull(lookup_code))" )
			else
				ldwc_child.SetFilter(ls_ori_filter +  " (lookup_code in (" +ls_depend_codes+ ") or lookup_code = -1 or lookup_code = -999 or isnull(lookup_code))" )
			end if
		else
			if ls_add_lookup = 'N' then //add by jervis 01.26.2011
				ldwc_child.SetFilter(ls_ori_filter + " (lookup_code <> -777 or isnull(lookup_code))")
			else
				//ldwc_child.SetFilter("")
				ldwc_child.SetFilter(as_ori_filter) //added by jervis 08.02.2011
			end if
		end if
		destroy lds_lookup_depend
	else
		if ls_add_lookup = 'N' then //add by jervis 01.26.2011
			ldwc_child.SetFilter(ls_ori_filter + " (lookup_code <> -777 or isnull(lookup_code))")
		else
			//ldwc_child.SetFilter("")
			ldwc_child.SetFilter(as_ori_filter) //added by jervis 08.02.2011
		end if
	end if	
else
	//ldwc_child.SetFilter("")
	ldwc_child.SetFilter(as_ori_filter) //add jervis 08.02.2011
end if
ldwc_child.Filter( )


 
end subroutine

public subroutine of_set_idle_flag (boolean abn_idle_flag);//====================================================================
// Function: of_set_idle_flag
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_idle_flag
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 08/07/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.04.2013 - V141 ISG-CLX
//====================================================================
If abn_idle_flag = True Then
	lbn_ignore_idle = True 
Else
	lbn_ignore_idle = False
End If
end subroutine

public subroutine of_setzoomtriggered (boolean ab_value);//====================================================================
//$<Function>: of_setzoomtriggered
//$<Arguments>:
// 	value    boolean    ab_value
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ib_zoom_triggered = ab_value
end subroutine

public function integer of_save_as_pdf (string as_pathfile, ref string as_error);//====================================================================
// Function: of_save_as_pdf
//--------------------------------------------------------------------
// Description: Save as PDF for a specail file
//--------------------------------------------------------------------
// Arguments:
//                as_pathfile
//                as_error
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 08/13/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================


String	ls_Syntax,ls_PathName,ls_FileName,ls_WinDir
String	ls_Null, ls_dir
long		ll_Rtn, ll_ret
n_cst_pdf lnvo_pdf //Replay all lnvo_pdf to lnvo_pdf, Added by Appeon long.zhang 03.03.2017

SetNull(ls_Null)

//Check DW syntax
ls_Syntax = Describe("DataWindow.Syntax") 
if Len(ls_Syntax) = 0 then 
	as_error = 'Error -1, The datawindow syntax is empty.'
	Return -1
end if

If Lower(Right(as_pathfile,3)) <> 'pdf' Then
	as_error = 'Error -1, The file type should be PDF.'
	Return -1	
End If

//Detele the file first
If FileExists(as_pathfile) Then
	If Not FileDelete(as_pathfile) Then
		as_error = 'Error, failed to delete the temp file "'+as_pathfile+'".'
		Return -1
	End If
End If

//Create Dir
gnv_appeondll.of_parsepath(as_pathfile)

//Set DW PDF 
object.DataWindow.Export.PDF.Method = Distill!
Object.DataWindow.Printer = lnvo_pdf.is_pdf_printer
Object.DataWindow.Export.PDF.Distill.CustomPostScript="Yes"


If appeongetclienttype() = 'PB' Then
	if lnvo_pdf.of_set_path( ) = failure then return -2
	if lnvo_pdf.of_add_pdf_printer() = failure then return -3

	ll_ret = saveas(as_pathfile ,pdf!,True)
	If ll_ret > 0 then 
		Return 1
	Else
		as_error = 'Error '+String(ll_ret)+', failed to save as PDF file.'
		Return -1
	end if 

Else
	If gnv_data.of_getitem( 'icred_settings', 'dwsavepdfway', False) = '2' Then //Using PDF Printer
		If of_print_pdf(as_pathfile) <> 0 Then
			as_error = 'Error -6, failed to save as PDF file with PDF printer.'
			Return -6
		End If
		SetPointer(Arrow!)
		If FileExists(as_pathfile) Then
			Return 1
		Else
			as_error = 'Error, failed to save as PDF file, PDF file is not exists.'
			Return -1
		End If
	Else
		//Use APB Save As PDF
		SetPointer(HourGlass!)
		If saveas(as_pathfile ,pdf!,True)  <> 1 Then
			as_error = 'Error -10. Failed to save as PDF file.'
			Return -1
		Else
			If FileExists(as_pathfile) Then
				Return 1
			End If
		End If	
	End If
End If

//Last Check
If FileExists(as_pathfile) Then
	Return 1
Else
	Return -1
End If

end function

public function integer of_print_pdf (string as_filename);// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//Print datawindow to PDF File -- Add by jervis  02.16.2011
//<add> 10/22/2007 by: Andy
String 	ls_prntrs,ls_SourceFile,ls_filename
integer 	li_file
string ls_CurPrinter

//Check PDF Printer
if f_PrinterSetup(2) >= 2 then return -1	//Added by Scofield on 2007-11-09
ls_prntrs = PrintGetPrinters ( )
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//IF NOT Pos(lower(ls_prntrs),lower("Contract Logix PDF Writer")) > 0 THEN
	//MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")
IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
	MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
	RETURN -1
END IF
//---------End Modfiied ------------------------------------------------------

//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//Convert to PDF, get & convert all Word documents 
//ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
ls_SourceFile = gs_temp_pdf
//---------End Modfiied ------------------------------------------------------
	
//Delete temporary pdf file 
IF FileExists(ls_SourceFile) THEN 
	IF Not FileDelete(ls_SourceFile) THEN 
		MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")						
		RETURN -1
	END IF
END IF

if as_filename = "" then
	//Start Code By Jervis 04.17.2008
	//Get file name
	ls_filename = object.DataWindow.Print.DocumentName
	if ls_filename = '?' or ls_filename = '!' or trim(ls_filename) = '' or isnull(ls_filename) or Pos(ls_filename,"<PATH>=") > 0 then 
		ls_filename = 'MAttachment.pdf'
	end if
	//End Code By Jervis 04.17.2008
	
	//ls_filename = 'MAttachment.pdf'	04.17.2008 By Jervis
	ls_filename = gs_dir_path + gs_DefDirName + '\Mail\'  + ls_filename
else
	ls_filename = as_filename
end if


	
//Set pdf Printer and print to PDF format
Try
	IF Object.DataWindow.Print.FileName <> "" THEN 
		Object.DataWindow.Print.FileName = ""
	end if
	if object.DataWindow.Print.DocumentName <> "" then 
		object.DataWindow.Print.DocumentName = ""
	end if
	if f_PrinterSetup(2) >= 2 then return -1					//Added by Scofield on 2007-11-09
	
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//Object.DataWindow.Printer = 'Contract Logix PDF Writer' //Added By Ken.Guo 2011-03-24.
	Object.DataWindow.Printer = 'IntelliSoft PDF Writer' 
	//---------End Modfiied ------------------------------------------------------
	
	//Commented By Ken.Guo 2011-03-24
	//ls_CurPrinter = PrintGetPrinter()							//Added by Scofield on 2008-05-12
	//PrintSetPrinter("Contract Logix PDF Writer")
	
	this.print( false )
	
	//Commented By Ken.Guo 2011-03-24
	//PrintSetPrinter(ls_CurPrinter)								//Added by Scofield on 2008-05-12
Catch(Throwable th1)
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")		
	MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")	
	//---------End Modfiied -----------------------------------------------------
	RETURN -1
End Try



Do 
	Yield()
	If FileExists(ls_sourcefile) Then 
		li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
	Else
		li_file = -1
	End If
Loop While li_file = -1
FileClose(li_file)
//lnv_filesrv.of_filecopy(ls_sourcefile, ls_filename )

Integer li_ret
li_ret = filecopy(ls_sourcefile, ls_filename ,true) //APB Blob Bug - jervis 03.23.2010

//Added By Ken.Guo 07/27/2012
If li_ret <> 1 Then
	Messagebox('Error ' + String(li_ret),'Failed to create PDF file.')
	Return -1
End If

return 0
end function

public function boolean of_get_outputing_flag ();//====================================================================
//$<Function>: of_get_outputing_flag
//$<Arguments>:
// 	value    integer    ab_flag
//$<Return>:  (None)
//$<Description>: Whether u_dw is outputing
//$<Author>: (Appeon) long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return ib_outputing_flag
end function

protected subroutine of_set_outputing_flag (boolean ab_flag);//====================================================================
//$<Function>: of_set_outputing_flag
//$<Arguments>:
// 	value    integer    ab_flag
//$<Return>:  (None)
//$<Description>: Whether it is outputing
//$<Author>: (Appeon) long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_outputing_flag = ab_flag 

Return
end subroutine

event constructor;ib_rmbmenu	= False

//if not isvalid(gnv_app.inv_debug) then
//	gnv_app.of_setdebug(true)
//end if
//
//
//
//if isvalid(gnv_app.inv_debug) then
//			gnv_app.inv_debug.of_SetSQLSpy(TRUE)
//			gnv_app.inv_debug.inv_sqlspy.of_opensqlspy( true)
//			gnv_app.inv_debug.of_SetAlwaysOnTop(true)
//end if
//

of_setbase( true)
inv_base.of_SetColumnDisplayNameStyle ( inv_base.HEADER )
of_settransobject( sqlca)
////////////////////////////////////////////////////////////////////
// do not display filter errors
////////////////////////////////////////////////////////////////////
//if GetApplication ( ) <> 0 then 
 // do not display eval/ filter error to the user
 Modify("DataWindow.NoUserPrompt='yes'")
//end if


is_notify_who[1] =  'mskinner@intellisoftgroup.com'
is_notify_who[2] =  'maha@intellisoftgroup.com'
//is_notify_who[3] =  'jdamelio@intellisoftgroup.com'

//Add tool only when need, Comment by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)
////---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
////Added By Ken.Guo 2011-07-22. 
//if ib_ShowTipsHelp  then 
//	iuo_tips.addtool(this,"",0) 
//end if 
////---------End Added ------------------------------------------------------------------










end event

on u_dw.create
call super::create
end on

on u_dw.destroy
call super::destroy
end on

event destructor;call super::destructor;
//if isvalid(gnv_app.inv_debug) then
//   gnv_app.inv_debug.inv_sqlspy.of_opensqlspy( false)
//END IF
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;
of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )
as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

event dberror;//////////////////////////////////////////////////////////////////////////////
//	Event:			dberror
//	Description:		Display messagebox that a database error has occurred.
// 						If appropriate delay displaying the database error until the appropriate
// 						Rollback has been performed.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0			Initial version
// 						5.0.02		Suppress error messages until after a rollback has been performed
// 						6.0 		Enhanced to use new dberrorattrib to support all error attributes.
// 						6.0			Enhanced to support Transaction Management by other objects
// 						6.0 		Enhanced to send notification to the SqlSpy service.
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
w_master	lw_parent
string	ls_message
string	ls_sqlspyheading
string	ls_sqlspymessage
string	ls_msgparm[1]
powerobject lpo_updaterequestor
n_cst_dberrorattrib lnv_dberrorattrib

// The error message.
ls_message = " A database error has occurred." + &
             " Database error code:  " + String (sqldbcode)  + &
	           " Database error message:" + sqlerrtext  + "~r~n Data Object: " + string(dataobject)

//------Begin Added by Alfee 08.23.2007 - both for asa and sql server--- 
IF sqldbcode = -198 or sqldbcode = 547 THEN
	ls_message = 'The row cannot be deleted from the database. ' + &
					 'It is being referenced by another record.'		
END IF
//------End Added -------------------------------------------------------

// Set the error attributes.
lnv_dberrorattrib.il_sqldbcode = sqldbcode
lnv_dberrorattrib.is_sqlerrtext = sqlerrtext
lnv_dberrorattrib.is_sqlsyntax = sqlsyntax
lnv_dberrorattrib.idwb_buffer = buffer
lnv_dberrorattrib.il_row = row
lnv_dberrorattrib.is_errormsg = ls_message
lnv_dberrorattrib.ipo_inerror = this

//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2011-01-21. Write to log file.
String ls_logtext
ls_logtext = This.ClassName() + ', Dataobject is ' + This.Dataobject + '.' + '~r~n' +  ls_message 
gnv_debug.of_output(true, ls_logtext )
//---------End Added ------------------------------------------------------------------


// If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) then

		// Create the heading and message for the SQLSpy.
		ls_sqlspyheading = "  DBError - " + this.ClassName() + "(" + string(row) + ")"
		ls_sqlspymessage = " Database error code:  " + String (sqldbcode) + "~r~n" + &
			" Database error message:  " + sqlerrtext
		
		// Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, "/*** " + ls_sqlspymessage + " ***/")
	end if
end if

// Determine if Transaction Management is being performed by another object.
If IsValid(ipo_UpdateRequestor) then
	lpo_updaterequestor = ipo_UpdateRequestor
else
	// Determine if the window is in the save process. 
	this.of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) then
		If lw_parent.TriggerEvent ("pfc_descendant") = 1 then	
			If lw_parent.of_GetSaveStatus() then
				lpo_updaterequestor = lw_parent
			end if
		end if
	end if
end if

If IsValid(lpo_updaterequestor) then
	// Suppress the error message (let the UpdateRequestor display it).
	// MetaClass check, Dynamic Function Call.
	lpo_updaterequestor.Dynamic Function of_SetDBErrorMsg(lnv_dberrorattrib)
else
	// Display the message immediately.
	
	If IsValid(gnv_app.inv_error) then
		ls_msgparm[1] = ls_message
		//gnv_app.inv_error.of_Message ("pfc_dwdberror", ls_msgparm, gnv_app.iapp_object.DisplayName)
	else
		//of_MessageBox ("pfc_dberror", gnv_app.iapp_object.DisplayName, ls_message, StopSign!, Ok!, 1)
	end if
	
	
end if


// msskiner 10 March 2006 -- begin
// do not send -198 messages to us
//Start Code Change ---- 03.29.2006 #369 maha reworked
choose case sqldbcode
	//case -198  //Moved the code to the above - By Alfee 08.23.2007
		//messagebox(iw_parent.title, 'The row cannot be deleted from the database. It is being referenced by another record.',information! )	
	case  -308, -85 
	//messagebox('Database error', 'You have lost your connection with the database.  You will have to close the program and restart. ',information! )
		f_system_error_handler (ls_message)
		open (w_dissconnect)
	case else 
		f_system_error_handler (ls_message)
end choose
// msskiner 10 March 2006 -- end

return 1
end event

event getfocus;call super::getfocus;
/////////////////////////////////////////////////////////
// get a referance to the parent window
/////////////////////////////////////////////////////////

of_getparentwindow(iw_parent )

if classname(iw_parent) = 'w_contract' then 
	this.border = false
	
	this.borderstyle = StyleRaised!
	
end if 
end event

event losefocus;call super::losefocus;


/////////////////////////////////////////////////////////
// get a referance to the parent window
/////////////////////////////////////////////////////////

of_getparentwindow(iw_parent )


if classname(iw_parent) = 'w_contract' then 
	this.border = true
	this.borderstyle = StyleLowered!
	
end if 

end event

event retrievestart;call super::retrievestart;//Start Code Change ---- 02.15.2006 #287 maha
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
    of_idle_value(0)  
  */
If lbn_ignore_idle = True Then 
	of_idle_value(0)	
End If 	
//---------End Modfiied ------------------------------------------------------------------

//End Code Change---02.15.2006
end event

event retrieveend;call super::retrieveend;//Start Code Change ---- 02.15.2006 #286 maha
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
     of_idle_value(1) 
  */
If lbn_ignore_idle = True Then 
	of_idle_value(1)
End If	
//---------End Modfiied ------------------------------------------------------------------
//End Code Change---02.15.2006
end event

event itemchanged;call super::itemchanged;//of_AutoDataFill(il_ViewId,il_ScreenId,dwo.name,row,data)	//Move it to u_dw_contract
end event

event rowfocuschanging;call super::rowfocuschanging;//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 11/14/2011. 
//---------End Added ------------------------------------------------------------------

end event

event dropdown;call super::dropdown;////====================================================================
//$<Event>: dropdown
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Gavin 11.06.2017 (V154 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String		ls_Column
DataWindowChild		ldwc_Child


ls_Column = This.GetColumnName ( )

If  GetChild( ls_column ,ldwc_child ) = 1 Then
	ldwc_Child.Modify("DataWindow.Zoom=" + string(gi_zoom)) 
	
End If


end event

