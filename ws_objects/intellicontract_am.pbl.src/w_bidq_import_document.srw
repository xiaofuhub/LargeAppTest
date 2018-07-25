$PBExportHeader$w_bidq_import_document.srw
forward
global type w_bidq_import_document from w_sheet
end type
type cb_log from commandbutton within w_bidq_import_document
end type
type cb_stop from commandbutton within w_bidq_import_document
end type
type cb_save2 from commandbutton within w_bidq_import_document
end type
type cb_select from commandbutton within w_bidq_import_document
end type
type cbx_attachall from checkbox within w_bidq_import_document
end type
type cb_scan from commandbutton within w_bidq_import_document
end type
type cb_preview from commandbutton within w_bidq_import_document
end type
type cb_clearcriteria from commandbutton within w_bidq_import_document
end type
type cb_search from commandbutton within w_bidq_import_document
end type
type cb_selectfile from commandbutton within w_bidq_import_document
end type
type dw_document from u_dw within w_bidq_import_document
end type
type cb_save from commandbutton within w_bidq_import_document
end type
type cb_add from commandbutton within w_bidq_import_document
end type
type cb_delete from commandbutton within w_bidq_import_document
end type
type cb_attach from commandbutton within w_bidq_import_document
end type
type cbx_pdf from checkbox within w_bidq_import_document
end type
type cb_setdef from commandbutton within w_bidq_import_document
end type
type cbx_preview from checkbox within w_bidq_import_document
end type
type hpb_progress from hprogressbar within w_bidq_import_document
end type
type cb_createqueue from u_cb within w_bidq_import_document
end type
type cb_close from u_cb within w_bidq_import_document
end type
type cb_deletequeue from u_cb within w_bidq_import_document
end type
type dw_bidq from u_dw within w_bidq_import_document
end type
type gb_view from groupbox within w_bidq_import_document
end type
type gb_document from groupbox within w_bidq_import_document
end type
type uo_search from uo_bidq_search_contract within w_bidq_import_document
end type
type gb_contract from groupbox within w_bidq_import_document
end type
type lb_tempfile from listbox within w_bidq_import_document
end type
type st_progress from statictext within w_bidq_import_document
end type
end forward

global type w_bidq_import_document from w_sheet
string tag = "Batch Import Document Queue"
integer width = 3973
integer height = 2232
string title = "Batch Import Document Queue"
windowstate windowstate = maximized!
long backcolor = 33551856
event type integer ue_save ( )
cb_log cb_log
cb_stop cb_stop
cb_save2 cb_save2
cb_select cb_select
cbx_attachall cbx_attachall
cb_scan cb_scan
cb_preview cb_preview
cb_clearcriteria cb_clearcriteria
cb_search cb_search
cb_selectfile cb_selectfile
dw_document dw_document
cb_save cb_save
cb_add cb_add
cb_delete cb_delete
cb_attach cb_attach
cbx_pdf cbx_pdf
cb_setdef cb_setdef
cbx_preview cbx_preview
hpb_progress hpb_progress
cb_createqueue cb_createqueue
cb_close cb_close
cb_deletequeue cb_deletequeue
dw_bidq dw_bidq
gb_view gb_view
gb_document gb_document
uo_search uo_search
gb_contract gb_contract
lb_tempfile lb_tempfile
st_progress st_progress
end type
global w_bidq_import_document w_bidq_import_document

type variables
long il_bidq_id
boolean ib_Doing = false
string  is_FileType

n_cst_dm_utils inv_utils
n_cst_pdf2text inv_cst_pdf2text
n_cst_ocr inv_cst_tif2text
n_cst_image_cp_ocr inv_ocr

str_batch_doc istr_batch_doc
String is_download_files[],is_empty[]
boolean	ib_stop	=	false		// 03/12/12 Added By mark 
long		il_count = 0			// 03/12/12 Added By mark 
end variables

forward prototypes
public function integer of_getqueuename (ref string as_name)
public function long of_retrievequeue (long al_bidq_id)
public function integer of_readfile (string as_file, ref blob ablb_data)
public function blob of_downloadfile (long al_bidq_doc_id)
public function integer of_writefile (ref string as_filename, ref blob ablb_data)
public function integer of_preview (boolean ab_download)
public function integer of_waitprintcomplete (string as_pdffile)
public function string of_getimportdir ()
public function integer of_deletetempfile ()
public function boolean of_isdatachanged ()
public function integer of_controlenabled (boolean ab_enabled)
public function integer of_attach (boolean ab_dragimport)
public function integer of_check (boolean ab_dragimport)
public function integer of_checkrecord (long al_row)
public function integer of_wordtopdf (string as_wordfile, ref string as_pdffile)
public function integer of_imagetopdf (string as_imagefile, ref string as_pdffile)
public function integer of_uploadfile (ref string as_filefullname, string as_displayname)
public function integer of_deleteattachedrecord (boolean ab_dragimport)
public function integer of_selectall (integer ai_check)
public function integer of_check_required ()
public function integer of_download_attachfiles ()
public subroutine of_adddocumentlog (string as_style, string as_doc_name, string as_paths, integer ai_ctx_id)
end prototypes

event type integer ue_save();Return 1
end event

public function integer of_getqueuename (ref string as_name);Open(w_bidq_getname)

if Message.StringParm = "cancel!" then
	Return -1
else
	as_Name = Message.StringParm
	Return 1
end if
end function

public function long of_retrievequeue (long al_bidq_id);long ll_RowCount

if IsNull(al_bidq_id) or al_bidq_id <= 0 then
	dw_document.Reset()
	Return 0
end if

ll_RowCount = dw_document.Retrieve(al_bidq_id)
dw_document.SelectRow(0, false)
dw_document.SelectRow(1, true)

Return ll_RowCount
end function

public function integer of_readfile (string as_file, ref blob ablb_data);
Return inv_utils.of_readblob(as_file,ablb_data) //Alfee 09.28.2008
/*
long ll_Byte
integer li_FileNum
blob lblb_Buf

li_FileNum = FileOpen(as_File, StreamMode!, Read!, Shared!)
if li_FileNum = -1 then 
	SetNull(ablb_Data)
	Return -1
end if

do
	ll_Byte = FileRead(li_FileNum, lblb_Buf)
	if ll_Byte > 0 then
		ablb_Data += lblb_Buf
	else
		Exit
	end if
loop while true
FileClose(li_FileNum)

Return 1*/
end function

public function blob of_downloadfile (long al_bidq_doc_id);blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then		
	SELECTBLOB image_file INTO :lb_all_data
	FROM ctx_bidq_doc
	WHERE bidq_doc_id = :al_bidq_doc_id;
Else			
	SELECT DataLength(image_file) INTO :ll_data_length
	FROM ctx_bidq_doc
	WHERE bidq_doc_id = :al_bidq_doc_id;
	
	If isnull(ll_data_length) Then ll_data_length = 0
	
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			ll_loops = ll_data_length / 8000 
		Else
			ll_loops = (ll_data_length / 8000) + 1
		End If 
	ElseIf ll_data_length > 0 Then 
		ll_loops = 1 
	End If 
	
	For ll_counter = 1 To ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
		FROM ctx_bidq_doc
		WHERE bidq_doc_id = :al_bidq_doc_id;
		lb_all_data += lb_data
	Next
End If

//---------Begin Modified by (Appeon)Harry 06.26.2013 for V141 ISG-CLX--------
If isnull(lb_all_data) Then lb_all_data = blob('') //restored by alfee 11.15.2013
//If isnull(lb_all_data) Then lb_all_data = blob('',EncodingAnsi!) //Encoding – Nova 11.16.2010
//---------End Modfiied ------------------------------------------------------


Return lb_all_data
end function

public function integer of_writefile (ref string as_filename, ref blob ablb_data);blob lblb_Buf
long ll_BlobLen
long ll_CurrentPos
long l, ll_Writes
integer li_FileNum
string ls_FileType
DateTime ldt_Time

// Get file name
ldt_Time = DateTime(Today(), Now())
ls_FileType = Lower(inv_utils.of_get_fileext(as_FileName))
choose case Lower(ls_FileType)
	case "doc", "docx"		
		as_FileName = of_GetImportDir() + "\temp_" + String(ldt_Time, "yyyymmddhhmmss") + ".doc"
	case else
		as_FileName = of_GetImportDir() + "\temp_" + String(ldt_Time, "yyyymmddhhmmss") + "." + ls_FileType
end choose

RETURN inv_utils.of_saveblob(as_FileName, ablb_Data) //Alfee 09.28.2008
/*
// Create a new file with blob data
li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, Replace!)
if li_FileNum < 0 then Return -1
ll_BlobLen = Len(ablb_Data)

if ll_BlobLen > 32765 then
	 if Mod(ll_BlobLen, 32765) = 0 then
		 ll_Writes = ll_BlobLen / 32765
	 else
		 ll_Writes = (ll_BlobLen / 32765) + 1
	 end if
else
	ll_Writes = 1
end if
ll_CurrentPos = 1

For l = 1 To ll_Writes
	lblb_Buf = BlobMid(ablb_Data, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	if FileWrite(li_FileNum, lblb_Buf) = -1 then
		FileClose(li_FileNum)
	 	Return -1
	end if
Next
FileClose(li_FileNum)

Return 1
*/
end function

public function integer of_preview (boolean ab_download);blob lblb_Data
long ll_CurrentRow
long ll_bidq_doc_id
string ls_Title
string ls_FileFullName

// Return if no document content
ll_CurrentRow = dw_document.GetRow()
if ll_CurrentRow <= 0 then Return -1
ls_FileFullName = dw_document.object.filename[ll_CurrentRow]
if IsNull(ls_FileFullName) then Return -1

// Get preview title
ls_Title = inv_utils.of_get_filename(ls_FileFullName) + "." + inv_utils.of_get_fileext(ls_FileFullName)
//ls_Title = "Preview - [" + ls_Title + "]"

// Open progress bar
OpenWithParm(w_appeon_gifofwait, "Opening the document..." )
Timer(0, w_appeon_gifofwait)
w_appeon_gifofwait.of_SetMaxPosition(3)
w_appeon_gifofwait.of_SetMinPosition(0)
w_appeon_gifofwait.of_SetPosition(0)
w_appeon_gifofwait.of_SkipNextPosition(1)

// Preview document
if IsValid(w_bidq_preview) then Close(w_bidq_preview)
if ab_Download then
	// Download file	
	ll_bidq_doc_id = dw_document.object.bidq_doc_id[ll_CurrentRow]
	lblb_Data = of_DownloadFile(ll_bidq_doc_id)
	w_appeon_gifofwait.of_SkipNextPosition(1)
	
	// Write and open file
	if of_WriteFile(ls_FileFullName, lblb_Data) = 1 then
		w_appeon_gifofwait.of_SkipNextPosition(1)
		OpenWithParm(w_bidq_preview, ls_Title + "|" + ls_FileFullName)
	else
		Close(w_appeon_gifofwait)
		MessageBox("Error", "Failed to write the file.", StopSign!)
	end if
else
	w_appeon_gifofwait.of_SetPosition(3)
	OpenWithParm(w_bidq_preview, ls_Title + "|" + ls_FileFullName)
end if

// Close progress bar if is open
if IsValid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)

Return 1
end function

public function integer of_waitprintcomplete (string as_pdffile);integer li_FileNum

do 
	Yield()
	if FileExists(as_PDFFile) then
		li_FileNum = FileOpen(as_PDFFile, StreamMode!)
	else
		li_FileNum = -1
	end if
loop while li_FileNum = -1
FileClose(li_FileNum)
		
Return 1
end function

public function string of_getimportdir ();string ls_Path
n_cst_import lnv_import

lnv_import = Create n_cst_import
ls_Path = lnv_import.of_GetImportDir()
Destroy lnv_import

Return ls_Path
end function

public function integer of_deletetempfile ();long i, ll_Count

lb_tempfile.DirList(of_GetImportDir(), 0 + 1 + 2 + 4 + 32)
ll_Count = lb_tempfile.TotalItems()

for i = 1 to ll_Count
	FileDelete(lb_tempfile.Text(i))
next
ChangeDirectory(gs_current_path)

Return 1
end function

public function boolean of_isdatachanged ();dw_document.AcceptText()

if dw_document.ModifiedCount() + dw_document.DeletedCount() > 0 then
	Return true
else
	Return false
end if
end function

public function integer of_controlenabled (boolean ab_enabled);integer i, li_Count
CheckBox lck_CheckBox
CommandButton lcb_Button
DataWindow ldw_DataWindow

li_Count = UpperBound(this.Control[])
for i = 1 to li_Count
	choose case this.Control[i].TypeOf()
		case CommandButton!
			lcb_Button = this.Control[i]			
			lcb_Button.Enabled = ab_Enabled
		case CheckBox!
			lck_CheckBox = this.Control[i]		
			lck_CheckBox.Enabled = ab_Enabled
		case DataWindow!
			ldw_DataWindow = this.Control[i]
			ldw_DataWindow.Enabled = ab_Enabled
	end choose
next

uo_search.dw_search.Enabled = ab_Enabled
uo_search.dw_search_det1.Enabled = ab_Enabled

Return 1
end function

public function integer of_attach (boolean ab_dragimport);// 03/14/12 Added By mark added batch import documents of log 
long ll_Return
n_cst_bidq_import lnv_import
long		ll_attachfile = 0 ,	ll_failedcnt = 0 		// 03/13/12 Added By mark 
string 	ls_msg

// Return -1 if failed to save data
ll_Return = cb_save.Event Clicked()
if ll_Return = -1 then Return -1

// Return -1 if failed to check data
if of_Check(ab_DragImport) = -1 then Return -1
//if cbx_attachall.Checked then
If istr_batch_doc.as_from = 'dm'	Then
	//ll_Return = MessageBox("Attach to All", "Are you sure you want to attach the document to the All contracts?", Question!, YesNo!)
	ll_Return = MessageBox("Attach", "Are you sure you want to attach the document to this contract?", Question!, YesNo!)
else
	ll_Return = MessageBox("Attach", "Are you sure you want to attach the document to the selected contract(s)?", Question!, YesNo!)
end if

if ll_Return = 2 then Return -1

// Execute import progress
ib_Doing = true
this.Title = this.Tag + " -> Importing..."
lnv_import = Create n_cst_bidq_import
lnv_import.of_Execute(this, ab_DragImport)
// added the variable of the values for account
ll_attachfile = lnv_import.il_attachfile
ll_failedcnt	=	lnv_import.il_failedcnt
Destroy lnv_import

// Refresh document if Contract Folder is opened
if IsValid(gw_contract) then
	gw_contract.tab_contract_details.of_RefreshDocument()
end if

// Attach progress completed
ib_Doing = false
this.Title = this.Tag

//Download attached files to local //Added By Ken.Guo 2010-07-08.
str_ctx_email lstr_ctx_email
If istr_batch_doc.as_from = 'search_tab' Then
	If MessageBox("Email", "Attaching document to contracts completed. ~r~nWould you like to email the added document to the Contracted Company Default To contact?", question!,yesno!) = 1 Then
		of_download_attachfiles( )//Download attached files to local
		lstr_ctx_email.ctx_id_list[] = istr_batch_doc.al_ctx_id[]
		lstr_ctx_email.as_batch_file[] = is_download_files[]
		lstr_ctx_email.doc_from = 'CTXS_IMPORT'
		OpenWithParm(w_dm_email_document_send, lstr_ctx_email)	
		
		//Delete was attached record(s).
		of_DeleteAttachedRecord(ab_DragImport)
		
		If istr_batch_doc.as_from = 'search_tab' Then
			Close(This)
			Return 1
		End If		
		
	End If
Else
	// 03/13/12 Added By mark change the information of the messagebox
//	MessageBox("Completed", "Attaching document to contracts completed!")
	if not isnull(ll_attachfile) and ll_attachfile > 0 then
		ls_msg = "Attaching of "+string(ll_attachfile)+" document(s) to contracts completed.~r~n~r~n" 		
		if ll_failedcnt > 0 then
			ls_msg +=string(ll_attachfile - ll_failedcnt) + " Success~r~n"+string(ll_failedcnt) + " Failure~r~n"+&
					"~r~nWould you like to open the log?"
			If MessageBox("Attach Result",ls_msg , question!,yesno!) = 1 Then
				cb_log.Event Clicked()
				w_bidq_import_log.tab_1.post selecttab(w_bidq_import_log.tab_1.tabpage_2)
			End if
		else
			ls_msg +="All Success"
			MessageBox("Attach Result",ls_msg , Information!,OK!)		
		end if 
	else
		MessageBox("Attach Result", "Attaching document to contracts completed.")
	end if 
End If

st_progress.Text = st_progress.Tag
hpb_progress.Position = 0

// Delete was attached record(s). move to bottom.
of_DeleteAttachedRecord(ab_DragImport)


Return 1
end function

public function integer of_check (boolean ab_dragimport);long ll_Row
long ll_DocCount

// Return -1 if no document
dw_document.AcceptText()
if dw_document.RowCount() <= 0 then
	MessageBox("Prompt", "There is no document that can be attached.")
	dw_bidq.SetFocus()
	Return -1
end if

// Return -1 if document field is null
if ab_DragImport then
	ll_Row = dw_document.GetRow()
	if of_CheckRecord(ll_Row) = -1 then Return -1
	ll_DocCount = 1
else
	for ll_Row = 1 to dw_document.RowCount()
		if dw_document.object.selected[ll_Row] = 1 then
			if of_CheckRecord(ll_Row) = -1 then Return -1
			ll_DocCount ++
		end if
	next
end if

// Return -1 if no selected document
if ll_DocCount <= 0 then
	MessageBox("Prompt", "Please select documents.")
	dw_bidq.SetFocus()
	Return -1
end if

// Return -1 if no selected contract
if uo_search.dw_search_det1.RowCount() <= 0 then
	MessageBox("Prompt", "There is no contract that can be attached to. Please search contracts.")
	cb_search.SetFocus()
	Return -1
end if

Return 1
end function

public function integer of_checkrecord (long al_row);if Len(dw_document.GetItemString(al_Row, "doc_name")) > 0 then
else
	dw_document.ScrollToRow(al_Row)
	MessageBox("Check Null", "The document name cannot be null.")
	dw_document.SetColumn("doc_name")			
	dw_document.SetFocus()
	Return -1
end if

if IsNull(dw_document.object.doc_type[al_Row]) then
	dw_document.ScrollToRow(al_Row)
	MessageBox("Check Null", "The document type cannot be null.")
	dw_document.SetColumn("doc_type")			
	dw_document.SetFocus()
	Return -1
end if

if IsNull(dw_document.object.category[al_Row]) then
	dw_document.ScrollToRow(al_Row)
	MessageBox("Check Null", "The document category cannot be null.")
	dw_document.SetColumn("category")			
	dw_document.SetFocus()
	Return -1
end if

if IsNull(dw_document.object.filename[al_Row]) then
	dw_document.ScrollToRow(al_Row)
	MessageBox("Select File", "Please select or scan a file.")
	cb_selectfile.SetFocus()
	Return -1
end if

Return 1
end function

public function integer of_wordtopdf (string as_wordfile, ref string as_pdffile);string ls_Printer
string ls_PDFTempFile
string ls_DefPrinter
DateTime ldt_Time
OLEObject lole_Word
integer li_ret
long     ll_cpu
long ll_Size = 100
boolean lb_msg = true
n_cst_filesrvwin32 lnv_FileSvr

try
	// Setup Contract Logix PDF Writer if not exists
	if f_PrinterSetup(2) >= 2 then Return -1
	
	//---------Begin Modified by (Appeon)Harry 06.26.2013 for V141 ISG-CLX--------
	// Check Contract Logix PDF Writer if exists
	//ls_Printer = PrintGetPrinters()
	//if not Pos(ls_Printer, "Contract Logix PDF Writer") > 0 then
	ls_Printer = Lower(PrintGetPrinters())
	if not PosA(ls_Printer, "intellisoft pdf writer") > 0 then
		MessageBox("Warning", "The IntelliSoft PDF Writer is not configured correctly!", Exclamation!)
		Return -1
	end if
	//---------End Modfiied ------------------------------------------------------
	
	//---------Begin Modified by (Appeon)Harry 06.26.2013 for V141 ISG-CLX--------
	// Delete temp PDF file before print
	//ls_PDFTempFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"	
	ls_PDFTempFile = gs_temp_pdf	
	//---------End Modfiied ------------------------------------------------------

	if FileExists(ls_PDFTempFile) then
		//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
		/*
		if not FileDelete(ls_PDFTempFile) then
			MessageBox("Error", "Please delete the file of '" + ls_PDFTempFile + "' first.", StopSign!)
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
		
	// Open file with word appliction
	lole_Word = Create OLEObject
	if lole_Word.ConnectToNewObject("Word.Application") <> 0 then
		Destroy lole_Word
		MessageBox("Error", "Could not connect to Microsoft Word. Please make sure it is properly installed.", StopSign!)
		Return -1
	end if
	Openwithparm(w_appeon_gifofwait, "Converting to PDF...")
	lole_Word.Visible = false
	lole_Word.Application.NormalTemplate.saved = true
	lole_Word.Application.Documents.Open(as_WordFile, false, true)
	//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	//---------End Added ------------------------------------------------------
	gnv_shell.of_delete_recent( as_WordFile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		
	// Set PDF Printer and print as PDF format
	ls_DefPrinter = Space(100)
	GetDefaultPrinter(ls_DefPrinter, ll_Size)
	lole_Word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
	lole_Word.ActiveDocument.Printout(0)
	lole_Word.ActiveDocument.Close(0)
	lole_Word.Quit(0)
	lole_Word.DisconnectObject()
	Destroy lole_Word
	SetDefaultPrinter(ls_DefPrinter)
	of_WaitPrintComplete(ls_PDFTempFile)
	Close(w_appeon_gifofwait)
catch (RuntimeError e)
	if Isvalid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
	if IsValid(lole_Word) then
		lole_Word.ActiveDocument.Close(0)
		lole_Word.Quit(0)
		lole_Word.DisconnectObject()
		Destroy lole_Word
	end if
	// 03/08/12 Added By mark 
//	MessageBox("Error", "Failed to convert from Word format to PDF format.", StopSign!)
	if gb_recordlog = true then
		gs_errmsg = "Error ->Failed to convert from Word format to PDF format."
	else
		MessageBox("Error", "Failed to convert from Word format to PDF format.", StopSign!)
	end if
	Return -1
end try

// Return PDF file path
ldt_Time = DateTime(Today(), Now())
as_PDFFile = of_GetImportDir() + "\temp_" + String(ldt_Time, "yyyymmddhhmmss") + ".pdf"
//lnv_FileSvr = Create n_cst_filesrvwin32
//lnv_FileSvr.of_FileCopy(ls_PDFTempFile, as_PDFFile)
FileCopy(ls_PDFTempFile, as_PDFFile,true) //APB Blob Bug - jervis 03.23.2010
//Destroy lnv_FileSvr

Return 1
end function

public function integer of_imagetopdf (string as_imagefile, ref string as_pdffile);integer  li_Return
DateTime ldt_Time
n_cst_image_functions_cp lnv_image

// Convert image to PDF and return file path
lnv_image = Create n_cst_image_functions_cp
ldt_Time = DateTime(Today(), Now())
as_PDFFile = of_GetImportDir() + "\temp_" + String(ldt_Time, "yyyymmddhhmmss") + ".pdf"
li_Return = lnv_image.of_Convert2Pdf(as_ImageFile, as_PDFFile)
Destroy lnv_image

Return li_Return
end function

public function integer of_uploadfile (ref string as_filefullname, string as_displayname);string ls_FileName
string ls_FileType
string ls_PDFFile
string ls_ImageFile
string ls_image_text
blob lblb_Data
long ll_bidq_doc_id
long ll_CurrentRow
integer li_Return

// Get file information
ll_CurrentRow = dw_document.GetRow()
if ll_CurrentRow <= 0 then Return - 1
ls_FileName = inv_utils.of_get_filename(as_FileFullName)
ls_FileType = Lower(inv_utils.of_get_fileext(as_FileFullName))
ls_ImageFile = as_FileFullName

// Convert to PDF
if cbx_pdf.Checked then
	if ls_FileType = "doc" or ls_FileType = "docx" then	
		if of_WordToPDF(as_FileFullName, ls_PDFFile) = -1 then Return -1
		as_FileFullName = ls_PDFFile
		ls_FileType = "pdf"
		ls_FileName += ".pdf"
	elseif ls_FileType = "tif" then
		if of_ImageToPDF(as_FileFullName, ls_PDFFile) = -1 then Return -1		
		as_FileFullName = ls_PDFFile
		ls_FileName += ".pdf"
	else
		ls_FileName += "." + ls_FileType
	end if
else
	ls_FileName += "." + ls_FileType
end if
if Len(as_DisplayName) > 0 then ls_FileName = as_DisplayName

// 03/08/12 Added By mark 
// Read file to blob
//if of_ReadFile(as_FileFullName, lblb_Data) = -1 then Return - 1
if of_ReadFile(as_FileFullName, lblb_Data) = -1 then 
	if	gb_recordlog = true then
		gs_errmsg = 'Error ->Read file to blob failed.'
	end if 
	Return - 1
end if 

// Set document name and save data
dw_document.SetItem(ll_CurrentRow, "filename", as_FileFullName)
dw_document.SetItem(ll_CurrentRow, "doc_name", ls_FileName)
li_Return = cb_save.Event Clicked()
if li_Return = -1 then Return -1

// Upload file to database
ll_bidq_doc_id = dw_document.object.bidq_doc_id[ll_CurrentRow]
UPDATEBLOB ctx_bidq_doc SET image_file = :lblb_Data WHERE bidq_doc_id = :ll_bidq_doc_id;

// Upload text of file to database
If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1'  /*Global Search module is On*/ &
and gnv_data.of_getitem('icred_settings' ,'auto_ocr' , False ) = '1'  Then //Auto OCR is Yes
	choose case ls_FileType
		case "pdf"
			inv_cst_pdf2text.of_pdf2text(as_FileFullName, ls_image_text)
			
			//Added By Ken.Guo 2009-10-20. Use Image CP OCR
			If ls_image_text = '' Then
				ls_image_text = inv_ocr.of_ocr(as_FileFullName)
			End If
			
			UPDATE ctx_bidq_doc SET image_text = :ls_image_text WHERE bidq_doc_id = :ll_bidq_doc_id;
		case "tif",'bmp','tiff','gif','jpg'
			ib_Doing = true
			of_ControlEnabled(false)
			//li_Return = inv_cst_tif2text.of_tif2text(ls_ImageFile, ls_image_text)
			ls_image_text = inv_ocr.of_ocr(ls_ImageFile) //Modified By Ken.Guo 2009-10-20/ Replace with image cp OCR
			of_ControlEnabled(true)
			ib_Doing = false
			if ls_image_text <> '' then
				UPDATE ctx_bidq_doc SET image_text = :ls_image_text WHERE bidq_doc_id = :ll_bidq_doc_id;
			end if
	end choose
End If

Return 1
end function

public function integer of_deleteattachedrecord (boolean ab_dragimport);long ll_Row
long ll_FindRow
long ll_Return

if ab_DragImport then
	ll_Row = dw_document.GetRow()
	if ll_Row > 0 then
		If dw_document.GetItemNumber(ll_row,'delete_flag') = 1 Then
			dw_document.DeleteRow(ll_Row)
		End If
	end if
else
	do while true
		ll_FindRow = dw_document.Find("selected=1 and delete_flag = 1", 1, dw_document.RowCount())
		if ll_FindRow > 0 then
			dw_document.DeleteRow(ll_FindRow)
		else
			exit
		end if			
	loop	
end if

ll_Return = cb_save.Event Clicked()
if dw_document.RowCount() <= 0 then
	cbx_pdf.Checked = false
	cbx_pdf.Enabled = true
end if

Return ll_Return
end function

public function integer of_selectall (integer ai_check);long ll_Row

dw_document.SetRedraw(false)
for ll_Row = 1 to dw_document.RowCount()
	dw_document.SetItem(ll_Row, "selected", ai_Check)
	dw_document.SetItemStatus(ll_Row, "selected", Primary!, NotModified!)
next
dw_document.SetRedraw(true)

Return 1
end function

public function integer of_check_required ();Long i,ll_row
If dw_document.Rowcount() = 0 Then Return 1
dw_document.accepttext( )
For i = 1 To dw_document.RowCount()
	If This.of_checkrecord(i) < 0 Then 
		dw_document.SetRow(i)
		dw_document.ScrolltoRow(i)
		Return -1
	End If
	/*
	If Isnull(dw_document.GetItemNumber(i,'doc_type')) or Isnull(Isnull(dw_document.GetItemNumber(i,'Category'))) Then
		dw_document.SetRow(i)
		dw_document.ScrolltoRow(i)
		Return -1
	End If
	*/
Next

Return 1

end function

public function integer of_download_attachfiles ();//////////////////////////////////////////////////////////////////////
// $<function>w_bidq_import_documentof_download_attachfiles()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Download attached file to local for batch email.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_cnt,i,j,ll_row,ll_bidq_doc_id,ll_selected_cnt
Blob lb_filedata
String ls_filedir,ls_docname,ls_filefullname

is_download_files[] = is_empty[]
ll_cnt = dw_document.rowcount()
If ll_cnt = 0 Then Return 0

ll_selected_cnt = dw_document.GetItemNumber(ll_cnt,'selected_cnt')

st_progress.Text = 'Download...'
hpb_progress.Maxposition = ll_selected_cnt
hpb_progress.Position = 0

j = 0
For i = 1 To ll_cnt
	If dw_document.GetItemNumber(i,'Selected') = 1 Then
		j++
		st_progress.Text = 'Download...'
		hpb_progress.Position = j
		dw_document.SetRow(i)
		dw_document.ScrolltoRow(i)
		dw_document.SelectRow(0,False)
		dw_document.SelectRow(i,True)
		ll_bidq_doc_id = dw_document.GetItemNumber(i,'bidq_doc_id')
		ls_docname = dw_document.GetItemString(i,'doc_name')
		lb_filedata = This.of_downloadfile(ll_bidq_doc_id)
		ls_filedir =  gs_dir_path + gs_DefDirName + "\Agreement\Batch Import\Doc" + String(ll_bidq_doc_id) + '\'
		f_createdirectory(ls_filedir)
		ls_filefullname = ls_filedir + ls_docname
		If inv_utils.of_saveblob( ls_filefullname, lb_filedata ) > 0 Then
			is_download_files[UpperBound(is_download_files[]) + 1] = ls_filefullname
		End If
	End If
Next
hpb_progress.Position = 100
Return 1

end function

public subroutine of_adddocumentlog (string as_style, string as_doc_name, string as_paths, integer ai_ctx_id);//====================================================================
// Function: of_adddocumentlog
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_style
//                as_doc_name
//                as_paths
//                ai_ctx_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	mark		Date: 03/08/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long 			ll_ctx_bidq
string			ls_pass_fail
Datetime		ldt_now
ldt_now = DateTime(Today(),Now())

IF ISNULL(as_doc_name) OR TRIM(as_doc_name)=''THEN
	RETURN
END IF 

If dw_bidq.rowcount() > 0 then 
	ll_ctx_bidq = dw_bidq.GetItemNumber(dw_bidq.getrow(),'bidq_id')
Else
	setnull(ll_ctx_bidq)
End if 

If isnull(gs_errmsg) Or trim(gs_errmsg) = '' Then
	ls_pass_fail = 'Success'
Else
	ls_pass_fail = 'Failure'
	il_count ++
End if
	
INSERT INTO bidq_log_info
		  (style, doc_name, ctx_bidq,  paths,  errmsg, 
		  pass_fail, user_id, log_date, ctx_id)
VALUES(:as_style, :as_doc_name, :ll_ctx_bidq, :as_paths, :gs_errmsg,
			:ls_pass_fail, :gs_user_id, :ldt_now , :ai_ctx_id)
Using Sqlca;
  
If sqlca.sqlcode = 0 Then 
	COMMIT;
Else
	ROLLBACK;
End If 
end subroutine

on w_bidq_import_document.create
int iCurrent
call super::create
this.cb_log=create cb_log
this.cb_stop=create cb_stop
this.cb_save2=create cb_save2
this.cb_select=create cb_select
this.cbx_attachall=create cbx_attachall
this.cb_scan=create cb_scan
this.cb_preview=create cb_preview
this.cb_clearcriteria=create cb_clearcriteria
this.cb_search=create cb_search
this.cb_selectfile=create cb_selectfile
this.dw_document=create dw_document
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_attach=create cb_attach
this.cbx_pdf=create cbx_pdf
this.cb_setdef=create cb_setdef
this.cbx_preview=create cbx_preview
this.hpb_progress=create hpb_progress
this.cb_createqueue=create cb_createqueue
this.cb_close=create cb_close
this.cb_deletequeue=create cb_deletequeue
this.dw_bidq=create dw_bidq
this.gb_view=create gb_view
this.gb_document=create gb_document
this.uo_search=create uo_search
this.gb_contract=create gb_contract
this.lb_tempfile=create lb_tempfile
this.st_progress=create st_progress
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_log
this.Control[iCurrent+2]=this.cb_stop
this.Control[iCurrent+3]=this.cb_save2
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cbx_attachall
this.Control[iCurrent+6]=this.cb_scan
this.Control[iCurrent+7]=this.cb_preview
this.Control[iCurrent+8]=this.cb_clearcriteria
this.Control[iCurrent+9]=this.cb_search
this.Control[iCurrent+10]=this.cb_selectfile
this.Control[iCurrent+11]=this.dw_document
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.cb_add
this.Control[iCurrent+14]=this.cb_delete
this.Control[iCurrent+15]=this.cb_attach
this.Control[iCurrent+16]=this.cbx_pdf
this.Control[iCurrent+17]=this.cb_setdef
this.Control[iCurrent+18]=this.cbx_preview
this.Control[iCurrent+19]=this.hpb_progress
this.Control[iCurrent+20]=this.cb_createqueue
this.Control[iCurrent+21]=this.cb_close
this.Control[iCurrent+22]=this.cb_deletequeue
this.Control[iCurrent+23]=this.dw_bidq
this.Control[iCurrent+24]=this.gb_view
this.Control[iCurrent+25]=this.gb_document
this.Control[iCurrent+26]=this.uo_search
this.Control[iCurrent+27]=this.gb_contract
this.Control[iCurrent+28]=this.lb_tempfile
this.Control[iCurrent+29]=this.st_progress
end on

on w_bidq_import_document.destroy
call super::destroy
destroy(this.cb_log)
destroy(this.cb_stop)
destroy(this.cb_save2)
destroy(this.cb_select)
destroy(this.cbx_attachall)
destroy(this.cb_scan)
destroy(this.cb_preview)
destroy(this.cb_clearcriteria)
destroy(this.cb_search)
destroy(this.cb_selectfile)
destroy(this.dw_document)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_attach)
destroy(this.cbx_pdf)
destroy(this.cb_setdef)
destroy(this.cbx_preview)
destroy(this.hpb_progress)
destroy(this.cb_createqueue)
destroy(this.cb_close)
destroy(this.cb_deletequeue)
destroy(this.dw_bidq)
destroy(this.gb_view)
destroy(this.gb_document)
destroy(this.uo_search)
destroy(this.gb_contract)
destroy(this.lb_tempfile)
destroy(this.st_progress)
end on

event closequery;//Override
if ib_Doing then Return 1

if of_IsDataChanged() then
	if MessageBox("Save", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if
end if
end event

event pfc_preopen;call super::pfc_preopen;//Inherit
uo_search.of_SetInitSize()
//
this.of_SetResize(true)
inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
inv_resize.of_SetMinSize(this.WorkSpaceWidth(),this.WorkSpaceHeight())
//
inv_resize.of_Register(gb_view, inv_resize.SCALERIGHT)
inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHT)
//
inv_resize.of_Register(gb_document, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_document, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(cb_select, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_add, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_delete, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_selectfile, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_scan, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_preview, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_log, inv_resize.FIXEDBOTTOM)	// 03/09/12 Added By mark 
inv_resize.of_Register(cb_stop, inv_resize.FIXEDBOTTOM)	// 03/09/12 Added By mark 
inv_resize.of_Register(cbx_pdf, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cbx_preview, inv_resize.FIXEDRIGHTBOTTOM)
//
inv_resize.of_Register(gb_contract, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(uo_search, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(st_progress, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(hpb_progress, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(cbx_attachall, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_attach, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_search, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_clearcriteria, inv_resize.FIXEDRIGHTBOTTOM)
end event

event close;call super::close;// Inherit
of_DeleteTempFile()

If isvalid(inv_ocr) Then Destroy inv_ocr
end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-12-29 By Jervis
//$<Reason> Switch MDI menu while Batch import document window get the focus.
if w_mdi.MenuName <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
//---------------------------- APPEON END ----------------------------

end event

event open;call super::open;inv_ocr = Create n_cst_image_cp_ocr
end event

type cb_log from commandbutton within w_bidq_import_document
integer x = 2190
integer y = 884
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Lo&g"
end type

event clicked;
// 03/09/12 Added By mark 
open(w_bidq_import_log)
end event

type cb_stop from commandbutton within w_bidq_import_document
integer x = 2542
integer y = 884
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Stop"
end type

event clicked;
//ib_stop
// 03/09/12 Added By mark 
ib_stop = true
end event

type cb_save2 from commandbutton within w_bidq_import_document
integer x = 2871
integer y = 68
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;If parent.of_check_required( ) < 0 Then Return -1

cb_save.Trigger Event clicked() 
end event

type cb_select from commandbutton within w_bidq_import_document
integer x = 50
integer y = 884
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select A&ll"
end type

event clicked;long ll_Row

if this.Text = "Select A&ll" then
	this.Text = "Deselect A&ll"
	of_SelectAll(1)
else
	this.Text = "Select A&ll"
	of_SelectAll(0)
end if
end event

type cbx_attachall from checkbox within w_bidq_import_document
integer x = 2423
integer y = 2000
integer width = 366
integer height = 64
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Attach to All"
end type

event clicked;uo_search.ib_AttachAll = this.Checked
uo_search.of_select_row(uo_search.dw_search_det1.GetRow()) //Added by Ken.Guo on 2009-01-05
end event

type cb_scan from commandbutton within w_bidq_import_document
integer x = 1477
integer y = 884
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sca&n"
end type

event clicked;long ll_CurrentRow
string ls_FileFullName

// Return if no document record
ll_CurrentRow = dw_document.GetRow()
if ll_CurrentRow <= 0 then
	MessageBox("Prompt", "Please select the document queue and add a document.")
	Return
end if

// Scan a file
if gi_ImageOcx = 1 then
	Open(w_ctx_doc_scan)
else
	Open(w_ctx_doc_scan_cp)
end if
ls_FileFullName = Message.StringParm
if not FileExists(ls_FileFullName) then Return
if is_FileType = "pdf" then
	cbx_pdf.Checked = false
	cbx_pdf.Enabled = true
end if

// Upload file to database
if of_UploadFile(ls_FileFullName, "") = -1 then
	MessageBox("Error", "Failed to upload file.", StopSign!)
	Return
end if
dw_document.Event RowFocusChanged(dw_document.GetRow())

// Preview document with local file directly
if cbx_preview.Checked then of_Preview(false)
end event

type cb_preview from commandbutton within w_bidq_import_document
integer x = 1833
integer y = 884
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Preview"
end type

event clicked;// Preview document with database blob data
of_Preview(true)
end event

type cb_clearcriteria from commandbutton within w_bidq_import_document
integer x = 3520
integer y = 1980
integer width = 343
integer height = 92
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clea&r Criteria"
end type

event clicked;uo_search.of_ClearCriteria()
end event

type cb_search from commandbutton within w_bidq_import_document
integer x = 3159
integer y = 1980
integer width = 343
integer height = 92
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Searc&h"
end type

event clicked;uo_search.of_Search()
end event

type cb_selectfile from commandbutton within w_bidq_import_document
integer x = 1120
integer y = 884
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &File"
end type

event clicked;// 03/14/12 Added By mark added batch import documents of log 
string ls_FilePath
string ls_FileName[]
string ls_FileFullName
integer i, li_FileCount
integer li_Return
long ll_CurrentRow
long ll_bidq_doc_id
blob lblb_Data
boolean lb_ConvertPDF
long 	ll_ctx_id	 , ll_filecont	// 03/08/12 Added By mark 
string 	ls_msg

// Select import files
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_Return = GetFileOpenName("Select File", &
		+ ls_FilePath, ls_FileName[], "DOC", &
		+ "Doc Files (*.DOCX;*.DOC),*.DOCX;*.DOC," &
		+ "Tif Files (*.TIF),*.TIF," &
		+ "Pdf Files (*.PDF),*.PDF," &
		+ "All Files (*.*), *.*")
gf_save_dir_path(ls_FilePath) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path)
if li_Return <> 1 then Return

li_FileCount = UpperBound(ls_FileName[])
if li_FileCount > 1 then cbx_preview.Checked = false
lb_ConvertPDF = cbx_pdf.Checked

// set default the values
gb_recordlog = true
st_progress.Text = 'Select File...'
hpb_progress.Maxposition = li_FileCount
hpb_progress.Position = 0
cb_stop.enabled = true		
il_count	= 0
ll_filecont = 0 
// Upload import files to database
SetPointer(HourGlass!)
for i = 1 to li_FileCount	
	//stop executing the process 
	yield()
	if ib_stop = true then 
		ll_filecont = i - 1
		exit
	end if 

	if li_FileCount > 1 or dw_document.GetRow() <= 0 then
		ll_CurrentRow = dw_document.InsertRow(0)
		dw_document.ScrollToRow(ll_CurrentRow)
		dw_document.SetItem(ll_CurrentRow, "bidq_id", il_bidq_id)
	end if
	if li_FileCount > 1 then
		ls_FileFullName = ls_FilePath + "\" + ls_FileName[i]
	else
		ls_FileFullName = ls_FilePath
	end if
	
	// Upload import file to database
	if lb_ConvertPDF then
		cbx_pdf.Checked = true
		cbx_pdf.Enabled = true
	end if
	
	if of_UploadFile(ls_FileFullName, "") = -1 then
		// 03/08/12 Added By mark  change the information of the messagebox .
//		SetPointer(Arrow!)
//		MessageBox("Error", "Failed to upload file.", StopSign!)
//		Return
		setnull(ll_ctx_id)
		of_adddocumentlog('1',ls_FileName[i],ls_FileFullName,ll_ctx_id)
		continue
	else
		//  insert logs
		if gb_recordlog = true then
			gs_errmsg = ''
			setnull(ll_ctx_id)
			of_adddocumentlog('1',ls_FileName[i],ls_FileFullName,ll_ctx_id)
		end if 
	end if
	dw_document.Event RowFocusChanged(dw_document.GetRow())
	
	// Preview document with local file directly
	if cbx_preview.Checked then of_Preview(false)
	// set  the value of progress
	st_progress.Text = 'Select File '+string( Int( i / li_FileCount * 100) )+'%'
	hpb_progress.Position = i
	ll_filecont = i 
next
SetPointer(Arrow!)
// clear the variables the values
gb_recordlog = false
st_progress.Text = st_progress.Tag
hpb_progress.Position = 0
cb_stop.enabled = false
ib_stop = false
// Prompt message setting
ls_msg = "Import of "+string(ll_filecont)+" document(s) completed. ~r~n~r~n"
If il_count = 0  Then 
	ls_msg	+=	"All Success"
	MessageBox("Import Result",ls_msg , Information!,OK! ) 
Else
	ls_msg 	+= string(ll_filecont - il_count)+" Success ~r~n"+ &
					string(il_count)+" Failure~r~n~r~nDo you want to open the log files?"
	If MessageBox("Import Result",ls_msg , question!,yesno!) = 1 Then
		cb_log.Event Clicked()
	End if
End if 

end event

type dw_document from u_dw within w_bidq_import_document
integer x = 55
integer y = 264
integer width = 3803
integer height = 608
integer taborder = 120
string dragicon = "droparrow.ico"
boolean bringtotop = true
string dataobject = "d_bidq_document"
boolean hscrollbar = true
end type

event constructor;// Inherit
DataWindowChild ldwc_child

this.SetTransObject(SQLCA)
this.GetChild("doc_from_name", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(-1)
ldwc_child.SetSort("id A")
ldwc_child.Sort()
ldwc_child.InsertRow(1)

DataWindowChild ldwc_child_doctype
this.SetTransObject(SQLCA)
this.GetChild("doc_type", ldwc_child_doctype)
ldwc_child_doctype.SetTransObject(SQLCA)
ldwc_child_doctype.Retrieve('Contract Document Type')

end event

event rowfocuschanged;call super::rowfocuschanged;// Inherit
string ls_FileFullName

if CurrentRow <= 0 then Return
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

ls_FileFullName = dw_document.object.filename[CurrentRow]
is_FileType = Lower(inv_utils.of_get_fileext(ls_FileFullName))

if IsNull(is_FileType) or is_FileType = "" then
	cbx_pdf.Checked = false
	cbx_pdf.Enabled = true
else
	choose case is_FileType
		case "doc", "docx", "tif"
			cbx_pdf.Checked = false
			cbx_pdf.Enabled = true
		case "pdf"
			cbx_pdf.Checked = true
			cbx_pdf.Enabled = false
		case else
			cbx_pdf.Checked = false
			cbx_pdf.Enabled = false
	end choose
end if
end event

event retrieveend;//
end event

event retrievestart;//
end event

event dberror;// Inherit
Return 1
end event

event clicked;call super::clicked;//Inherit
if Row > 0 then
	this.SetRow(Row)
	this.SelectRow(0, false)
	this.SelectRow(Row, true)
	if dwo.name = "selected" then
		this.Post SetItemStatus(Row, "selected", Primary!, NotModified!)
	end if
end if
end event

event mousemove;call super::mousemove;if KeyDown(KeyLeftButton!) then
	if GetRow() > 0 then
		this.Drag(Begin!)
	end if
end if
end event

type cb_save from commandbutton within w_bidq_import_document
boolean visible = false
integer x = 2871
integer y = 68
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;// Check data if changed
dw_document.AcceptText()
if dw_document.ModifiedCount() + dw_document.DeletedCount() = 0 then
	Return 0
end if

// Save data
if dw_document.Update() = 1 then
	Commit;
	Return 1
else
	Rollback;
	// 03/08/12 Added By mark 
//	MessageBox("Save", "Failed to save data.", StopSign!)
	if gb_recordlog = true then 
		gs_errmsg = "Save ->Failed to save data."
	else
		MessageBox("Save", "Failed to save data.", StopSign!)
	end if
	Return -1
end if
end event

type cb_add from commandbutton within w_bidq_import_document
integer x = 407
integer y = 884
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long ll_InsertRow

// Prompt user
if IsNull(il_bidq_id) or il_bidq_id <= 0 then
	MessageBox("Prompt", "Please select a document queue.")
	Return 0
end if

// Insert row
ll_InsertRow = dw_document.InsertRow(0)
dw_document.SetItem(ll_InsertRow, "bidq_id", il_bidq_id)
dw_document.ScrollToRow(ll_InsertRow)
dw_document.SetColumn("doc_name")
dw_document.SetFocus()
end event

type cb_delete from commandbutton within w_bidq_import_document
integer x = 763
integer y = 884
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long ll_Return

// Prompt user
if dw_document.RowCount() <= 0 then Return
ll_Return = MessageBox("Delete Document", "Are you sure you want to delete the selected document?", Question!, YesNo!, 2)
if ll_Return = 2 then Return

// Delete selected document
dw_document.DeleteRow(0)
dw_document.SelectRow(0, false)
dw_document.SelectRow(dw_document.GetRow(), true)

if dw_document.RowCount() <= 0 then
	cbx_pdf.Checked = false
	cbx_pdf.Enabled = true
end if
end event

type cb_attach from commandbutton within w_bidq_import_document
integer x = 2798
integer y = 1980
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&ttach"
end type

event clicked;of_Attach(false)
end event

type cbx_pdf from checkbox within w_bidq_import_document
integer x = 2889
integer y = 896
integer width = 448
integer height = 76
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Convert to PDF "
end type

event clicked;long ll_CurrentRow
long ll_bidq_doc_id
string ls_FineName
string ls_FileType
string ls_FileFullName
blob lblb_Data
string ls_printer, ls_PDFTempFile		// 03/08/12 Added By mark 
OLEObject	lole_Word

// 03/08/12 Added By mark  checked Contract Logix PDF Writer exisited -begin
// Setup Contract Logix PDF Writer if not exists
if f_PrinterSetup(2) >= 2 then Return -1

//---------Begin Modified by (Appeon)Harry 06.26.2013 for V141 ISG-CLX--------
// Check Contract Logix PDF Writer if exists
//ls_Printer = PrintGetPrinters()
//if not Pos(ls_Printer, "Contract Logix PDF Writer") > 0 then
ls_Printer = Lower(PrintGetPrinters())
if not PosA(ls_Printer, "intellisoft pdf writer") > 0 then
	MessageBox("Warning", "The IntelliSoft PDF Writer is not configured correctly!", Exclamation!)
	Return -1
end if
//---------End Modfiied ------------------------------------------------------

//---------Begin Modified by (Appeon)Harry 06.26.2013 for V141 ISG-CLX--------
// Delete temp PDF file before print
//ls_PDFTempFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"	
ls_PDFTempFile = gs_temp_pdf
//---------End Modfiied ------------------------------------------------------
if FileExists(ls_PDFTempFile) then
	if not FileDelete(ls_PDFTempFile) then
		MessageBox("Error", "Please delete the file of '" + ls_PDFTempFile + "' first.", StopSign!)
		Return -1
	end if
end if	
	
// Open file with word appliction
lole_Word = Create OLEObject
if lole_Word.ConnectToNewObject("Word.Application") <> 0 then
	Destroy lole_Word
	MessageBox("Error", "Could not connect to Microsoft Word. Please make sure it is properly installed.", StopSign!)
	Return -1
end if
// 03/08/12 Added By mark  checked Contract Logix PDF Writer exisit -end

ll_CurrentRow = dw_document.GetRow()
if ll_CurrentRow <= 0 then Return -1

// Get file name
ls_FileFullName = dw_document.object.filename[ll_CurrentRow]
if IsNull(ls_FileFullName) or ls_FileFullName = "" then Return -1
ls_FineName = dw_document.object.doc_name[ll_CurrentRow]
choose case is_FileType
	case "doc", "docx", "tif"
		ls_FineName = inv_utils.of_get_filename(ls_FineName)
		ls_FineName += ".pdf"
	case else
		Return -1
end choose

// Download file
OpenWithParm(w_appeon_gifofwait, "Downloading the document..." )
Timer(0, w_appeon_gifofwait)
w_appeon_gifofwait.of_SetMaxPosition(4)
w_appeon_gifofwait.of_SetMinPosition(0)
w_appeon_gifofwait.of_SetPosition(0)
w_appeon_gifofwait.of_SkipNextPosition(1)

ll_bidq_doc_id = dw_document.object.bidq_doc_id[ll_CurrentRow]
lblb_Data = of_DownloadFile(ll_bidq_doc_id)
if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(1)

// Write file
if of_WriteFile(ls_FileFullName, lblb_Data) = -1 then
	cbx_pdf.Checked = false
	if IsValid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
	MessageBox("Error", "Failed to write the file.", StopSign!)
	Return -1
end if
if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(1)

// Upload file after convert file
w_appeon_gifofwait.of_SetText("Converting and uploading the document...")
if of_UploadFile(ls_FileFullName, ls_FineName) = -1 then
	cbx_pdf.Checked = false
	if IsValid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
	MessageBox("Error", "Failed to convert file.", StopSign!)
end if

if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(1)
if IsValid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)
dw_document.Event RowFocusChanged(dw_document.GetRow())
end event

type cb_setdef from commandbutton within w_bidq_import_document
integer x = 2418
integer y = 68
integer width = 434
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set Defa&ults"
end type

event clicked;OpenWithParm(w_bidq_setdefaults, dw_document)
end event

type cbx_preview from checkbox within w_bidq_import_document
integer x = 3337
integer y = 896
integer width = 553
integer height = 76
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preview after Import"
end type

type hpb_progress from hprogressbar within w_bidq_import_document
integer x = 581
integer y = 1980
integer width = 1810
integer height = 92
unsignedinteger maxposition = 100
integer setstep = 10
end type

type cb_createqueue from u_cb within w_bidq_import_document
integer x = 1513
integer y = 68
integer width = 434
integer taborder = 20
boolean bringtotop = true
string text = "&Create Queue"
end type

event clicked;call super::clicked;long ll_bidq_id
long ll_InsertRow
long ll_Return
string ls_bidq_name

// Prompt save data if data is changed
if of_IsDataChanged() then
	ll_Return = MessageBox("Create Queue", "The data is changed, would you like to save data?", Question!, YesNo!, 2)
	if ll_Return = 1 then
		ll_Return = cb_save.Event Clicked()
		if ll_Return = -1 then Return
	end if
end if

// Get queue name
if of_GetQueueName(ls_bidq_name) = -1 then Return

// Create a document queue
ll_InsertRow = dw_bidq.InsertRow(0)
dw_bidq.SetItem(ll_InsertRow, "bidq_name", ls_bidq_name)
if dw_bidq.Update() = 1 then
	Commit;
	ll_bidq_id = dw_bidq.object.bidq_id[ll_InsertRow]
	dw_bidq.Reset()
	dw_bidq.InsertRow(0)
	dw_bidq.Event ue_DDDWInsert(ll_bidq_id, ls_bidq_name)
else
	dw_bidq.DeleteRow(2)
	dw_bidq.ResetUpdate()
	MessageBox("Create Queue", "Failed to create a document queue.", StopSign!)	
end if
end event

type cb_close from u_cb within w_bidq_import_document
integer x = 3429
integer y = 68
integer width = 343
integer taborder = 210
boolean bringtotop = true
string text = "Clos&e"
end type

event clicked;call super::clicked;Close(Parent)

end event

type cb_deletequeue from u_cb within w_bidq_import_document
integer x = 1966
integer y = 68
integer width = 434
integer taborder = 30
string text = "Delete &Queue"
end type

event clicked;call super::clicked;long ll_Return
long ll_bidq_id

// Prompt user
//Added By mark 03/14/12 added to delete data of log 
//ll_Return = MessageBox("Delete Queue", "Are you sure you want to delete the selected document queue?", Question!, YesNo!, 2)
ll_Return = MessageBox("Delete Queue", "Are you sure you want to delete the selected document queue and its corresponding import of log?", Question!, YesNo!, 2)
if ll_Return = 2 then Return

// Delete selected queue and correlative records
gnv_appeondb.of_StartQueue()
DELETE FROM bidq_log_info WHERE ctx_bidq = :il_bidq_id;	 // 03/14/12 Added By mark 
DELETE FROM ctx_bidq_doc WHERE bidq_id = :il_bidq_id;
DELETE FROM ctx_bidq WHERE bidq_id = :il_bidq_id;
COMMIT;
gnv_appeondb.of_CommitQueue()

// Refresh datawindow
dw_bidq.Event ue_DDDWDelete(il_bidq_id)
end event

type dw_bidq from u_dw within w_bidq_import_document
event ue_dddwinsert ( long al_bidq_id,  string as_bidq_name )
event ue_setitem ( long al_bidq_id )
event ue_dddwdelete ( long al_bidq_id )
integer x = 41
integer y = 68
integer width = 1449
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_bidq_select"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dddwinsert(long al_bidq_id, string as_bidq_name);long ll_InsertRow
DataWindowChild ldwc_child

this.GetChild("bidq_id", ldwc_child)

ll_InsertRow = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_InsertRow, "bidq_id", al_bidq_id)
ldwc_child.SetItem(ll_InsertRow, "bidq_name", as_bidq_name)

this.Event ue_SetItem(al_bidq_id)
end event

event ue_setitem(long al_bidq_id);this.SetItem(1, "bidq_id", al_bidq_id)
this.Event ItemChanged(1, this.object.bidq_id, String(al_bidq_id))
end event

event ue_dddwdelete(long al_bidq_id);long ll_Null
long ll_FindRow
DataWindowChild ldwc_child

this.GetChild("bidq_id", ldwc_child)

ll_FindRow = ldwc_child.Find("bidq_id=" + String(al_bidq_id), 1, ldwc_child.RowCount())
ldwc_child.DeleteRow(ll_FindRow)

SetNull(ll_Null)
this.Event ue_SetItem(ll_Null)
end event

event constructor;DataWindowChild ldwc_child

this.SetTransObject(SQLCA)
this.InsertRow(0)

// Retrieve document queue
this.GetChild("bidq_id", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve()
end event

event itemchanged;call super::itemchanged;//Inherit
il_bidq_id = Long(data)
of_RetrieveQueue(il_bidq_id)
end event

type gb_view from groupbox within w_bidq_import_document
integer x = 23
integer y = 12
integer width = 3872
integer height = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Document Queue"
end type

type gb_document from groupbox within w_bidq_import_document
integer x = 23
integer y = 204
integer width = 3872
integer height = 792
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Define Imported Documents"
end type

type uo_search from uo_bidq_search_contract within w_bidq_import_document
integer x = 46
integer y = 1064
integer taborder = 150
end type

on uo_search.destroy
call uo_bidq_search_contract::destroy
end on

event ue_dragdrop;call super::ue_dragdrop;if dw_document.GetRow() > 0 then
	of_Attach(true)
end if
end event

event resize;//Override
dw_search.Width = dw_document.Width
dw_search_det1.Width = dw_document.Width
end event

type gb_contract from groupbox within w_bidq_import_document
integer x = 23
integer y = 1012
integer width = 3872
integer height = 1084
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Attach Documents to Contracts"
end type

type lb_tempfile from listbox within w_bidq_import_document
boolean visible = false
integer x = 3259
integer y = 344
integer width = 567
integer height = 516
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_progress from statictext within w_bidq_import_document
string tag = "Attach Progress ( % ) :"
integer x = 69
integer y = 2000
integer width = 507
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attach Progress ( % ) :"
boolean focusrectangle = false
end type

