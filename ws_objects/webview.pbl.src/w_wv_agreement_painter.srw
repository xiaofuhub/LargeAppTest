$PBExportHeader$w_wv_agreement_painter.srw
forward
global type w_wv_agreement_painter from w_sheet
end type
type rb_b from radiobutton within w_wv_agreement_painter
end type
type rb_r from radiobutton within w_wv_agreement_painter
end type
type rb_i from radiobutton within w_wv_agreement_painter
end type
type cb_upload from commandbutton within w_wv_agreement_painter
end type
type cb_preview from commandbutton within w_wv_agreement_painter
end type
type cb_add from commandbutton within w_wv_agreement_painter
end type
type dw_agreement from u_dw within w_wv_agreement_painter
end type
type cb_delete from commandbutton within w_wv_agreement_painter
end type
type cb_save from commandbutton within w_wv_agreement_painter
end type
type dw_facility from u_dw within w_wv_agreement_painter
end type
type cb_close from commandbutton within w_wv_agreement_painter
end type
type gb_4 from groupbox within w_wv_agreement_painter
end type
type gb_1 from groupbox within w_wv_agreement_painter
end type
type dw_detail from u_dw within w_wv_agreement_painter
end type
end forward

global type w_wv_agreement_painter from w_sheet
integer width = 3680
integer height = 1920
string title = "WebView Agreement Setup"
boolean maxbox = false
long backcolor = 33551856
rb_b rb_b
rb_r rb_r
rb_i rb_i
cb_upload cb_upload
cb_preview cb_preview
cb_add cb_add
dw_agreement dw_agreement
cb_delete cb_delete
cb_save cb_save
dw_facility dw_facility
cb_close cb_close
gb_4 gb_4
gb_1 gb_1
dw_detail dw_detail
end type
global w_wv_agreement_painter w_wv_agreement_painter

type variables
long il_facility_id = 0
long il_agreement_id = 0
boolean ib_RetrieveDetail = true
string is_ViewDocPath
end variables

forward prototypes
public function blob of_downloadfile (long al_agreement_id)
public function integer of_setappointmentstate ()
end prototypes

public function blob of_downloadfile (long al_agreement_id);//////////////////////////////////////////////////////////////////////
// $<function> of_downloadfile
// $<arguments>
//		long	al_agreement_id
// $<returns> blob
// $<description> Download file from database
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.23.2012
//////////////////////////////////////////////////////////////////////

blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

SetPointer(HourGlass!)

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then
	SELECTBLOB file_data INTO :lb_all_data
	FROM wv_agreement_documents
	WHERE agreement_id = :al_agreement_id;
Else			
	SELECT DataLength(file_data) INTO :ll_data_length
	FROM wv_agreement_documents
	WHERE agreement_id = :al_agreement_id;
	
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
		SELECTBLOB substring(file_data,:ll_start,8000) INTO :lb_data
		FROM wv_agreement_documents
		WHERE agreement_id = :al_agreement_id;			
		lb_all_data += lb_data
	Next
End If
If isnull(lb_all_data) Then lb_all_data = blob('',EncodingAnsi!)

SetPointer(Arrow!)

Return lb_all_data
end function

public function integer of_setappointmentstate ();//////////////////////////////////////////////////////////////////////
// $<function> of_setappointmentstate
// $<arguments>
// $<returns> integer
// $<description> Set appointment state
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.23.2012
//////////////////////////////////////////////////////////////////////

string ls_appoint_type

ls_appoint_type = dw_detail.GetItemString(1, "appoint_type")
choose case ls_appoint_type
	case "R"
		rb_r.Checked = true
	case "B"
		rb_b.Checked = true
	case else
		rb_i.Checked = true
end choose

Return 1
end function

on w_wv_agreement_painter.create
int iCurrent
call super::create
this.rb_b=create rb_b
this.rb_r=create rb_r
this.rb_i=create rb_i
this.cb_upload=create cb_upload
this.cb_preview=create cb_preview
this.cb_add=create cb_add
this.dw_agreement=create dw_agreement
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.dw_facility=create dw_facility
this.cb_close=create cb_close
this.gb_4=create gb_4
this.gb_1=create gb_1
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_b
this.Control[iCurrent+2]=this.rb_r
this.Control[iCurrent+3]=this.rb_i
this.Control[iCurrent+4]=this.cb_upload
this.Control[iCurrent+5]=this.cb_preview
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.dw_agreement
this.Control[iCurrent+8]=this.cb_delete
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.dw_facility
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.dw_detail
end on

on w_wv_agreement_painter.destroy
call super::destroy
destroy(this.rb_b)
destroy(this.rb_r)
destroy(this.rb_i)
destroy(this.cb_upload)
destroy(this.cb_preview)
destroy(this.cb_add)
destroy(this.dw_agreement)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.dw_facility)
destroy(this.cb_close)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.dw_detail)
end on

event open;call super::open;integer li_Exists

gnv_appeondb.of_StartQueue()
if gs_DBType = "ASA" then
	select Count(*) into :li_Exists from sys.syscolumn c,sys.systable t where c.table_id=t.table_id and
	c.column_name='esign_required' and t.table_name='wv_agreement_documents';
else
	select Count(*) into :li_Exists from syscolumns c, sysobjects t where c.id=t.id and
	c.name='esign_required' and t.name='wv_agreement_documents' and t.type = 'U';
end if
dw_facility.Retrieve(gs_user_id)
gnv_appeondb.of_CommitQueue()

if IsNull(li_Exists) or li_Exists <> 1 then
	MessageBox("Warning", "This module is unavailable currently because the wv_agreement_documents table hasn't been upgraded in WebView.", Exclamation!)
	Close(this)
	Return
end if

is_ViewDocPath = gs_temp_path + "temp\webview\"
gnv_appeondll.of_ParsePath(is_ViewDocPath)
end event

type rb_b from radiobutton within w_wv_agreement_painter
integer x = 2016
integer y = 248
integer width = 215
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Both"
end type

event clicked;dw_detail.SetItem(1, "appoint_type", "B")
end event

type rb_r from radiobutton within w_wv_agreement_painter
integer x = 1495
integer y = 248
integer width = 475
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reappointment"
end type

event clicked;dw_detail.SetItem(1, "appoint_type", "R")
end event

type rb_i from radiobutton within w_wv_agreement_painter
integer x = 1179
integer y = 248
integer width = 343
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Initial"
end type

event clicked;dw_detail.SetItem(1, "appoint_type", "I")
end event

type cb_upload from commandbutton within w_wv_agreement_painter
integer x = 2025
integer y = 36
integer width = 466
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upload Document"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Upload document
// $<add> (Appeon) evan 02.22.2012
//====================================================================

long ll_Pos
long ll_Return
long ll_agreement_id
string ls_DocPath
string ls_DocName
string ls_Ext
blob lblb_Data
n_cst_dm_utils lnv_file

// Check the current record if be saved
dw_detail.AcceptText()
ll_agreement_id = dw_detail.GetItemNumber(1, "agreement_id")
if IsNull(ll_agreement_id) then
	MessageBox("Upload Document", "Please save the new record before uploading document.", Exclamation!)
	Return
end if

// Get file name
ll_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "doc", &
									 "All Files (*.*),*.*," + &
									 "Word Document (*.docx),*.docx," + &
									 "Word 97-2003 Document (*.doc),*.doc," + &
									 "PDF Files (*.pdf),*.pdf," + &
									 "TIFF Files (*.tif),*.tif," + &
									 "JPG Files (*.jpg),*.jpg," + &
									 "JPEG Files (*.jpeg),*.jpeg," + &
									 "Bitmap Files (*.bmp),*.bmp," + &
									 "HTML Documents (*.htm;*html),*.htm;*html", &
									 gs_current_path)
ChangeDirectory(gs_current_path)
if ll_Return <> 1 then Return

// Read file content
if lnv_file.of_ReadBlob(ls_DocPath, lblb_Data) <> 1 then
	MessageBox("Upload Document", "Failed to read file.", StopSign!)
	Return
end if
ll_Pos = LastPos(ls_DocPath, '.')
ls_Ext = Mid(ls_DocPath, ll_Pos + 1, 255)

// Upload file content to database
UPDATEBLOB wv_agreement_documents SET file_data = :lblb_data WHERE agreement_id = :ll_agreement_id;
if SQLCA.SQLCode = 0 then
	dw_detail.SetItem(1, "file_data_len", 1)
	dw_detail.SetItem(1, "file_type", Lower(ls_Ext))
	dw_detail.SetItem(1, "last_updated_by", gs_user_id)
	dw_detail.SetItem(1, "last_updated_date", DateTime(today(), now()))
	gnv_appeondb.of_StartQueue()
	dw_detail.Update()
	COMMIT;
	gnv_appeondb.of_CommitQueue()
	MessageBox("Upload Document", "Upload document successful!")
else
	ROLLBACK;
	MessageBox("Upload Document", "Failed to upload document.~r~n" + SQLCA.SQLErrText, StopSign!)
end if
end event

type cb_preview from commandbutton within w_wv_agreement_painter
integer x = 1696
integer y = 36
integer width = 320
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Preview"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Preview document
// $<add> (Appeon) evan 02.23.2012
//====================================================================

blob lblb_Data
string ls_DocPath
string ls_DocName
string ls_file_type
long ll_agreement_id
long ll_file_data_len
n_cst_dm_utils lnv_file

// Check the document if available.
dw_detail.AcceptText()
ll_agreement_id = dw_detail.GetItemNumber(1, "agreement_id")
ll_file_data_len = dw_detail.GetItemNumber(1, "file_data_len")
ls_file_type = dw_detail.GetItemString(1, "file_type")
if IsNull(ll_file_data_len) or ll_file_data_len < 1 then
	MessageBox("Preview", "Relative document on server is unavailable. It can not be previewed.", Exclamation!)
	Return
end if

// Download file from database
ls_DocName = "view_document." + ls_file_type
ls_DocPath = is_ViewDocPath + ls_DocName
lblb_Data = of_DownloadFile(ll_agreement_id)
if lnv_file.of_SaveBlob(ls_DocPath, lblb_Data) <> 1 then
	MessageBox("Preview", "Failed to write file: " + ls_DocPath, StopSign!)
	Return
end if

// Open document
choose case Upper(ls_file_type)
	case "TIF", "BMP", "JPG", "JPEG" //, "PDF"  //(Appeon)Stephen 06.23.2015 -  Issue Viewing Documents Uploaded in WebView Agreements Case#55228 Bug_id 4562
		OpenWithParm(w_image_display, ls_DocPath + '|' + ls_DocName)
	case "DOC", "DOCX" , "XLS", "XLSX"
		ls_DocName = "Document Preview"
		OpenWithParm(w_document_display, ls_DocPath + "|" + ls_DocName)
	case else
		ShellExecuteA(0, "open", ls_DocPath, "", "", 1)
end choose
end event

type cb_add from commandbutton within w_wv_agreement_painter
integer x = 379
integer y = 36
integer width = 320
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Add
// $<add> (Appeon) evan 02.21.2012
//====================================================================

integer li_rc
dwitemstatus ldwi_status

dw_detail.AcceptText()
ldwi_status = dw_detail.GetItemStatus(1, 0, Primary!)

if ldwi_status = New! then
	dw_detail.SetColumn("agreement_name")
	dw_detail.SetFocus()
	Return
end if

if ldwi_status <> NotModified! then
	li_rc = MessageBox("Add", "Current agreement has been modified. Are you sure you want to add new one without saving these data?", Question!, OkCancel!)
	if li_rc = 2 then Return
end if

dw_detail.Reset()
dw_detail.InsertRow(0)
of_SetAppointmentState()
dw_detail.SetColumn("agreement_name")
dw_detail.SetFocus()
end event

type dw_agreement from u_dw within w_wv_agreement_painter
integer x = 64
integer y = 980
integer width = 937
integer height = 752
integer taborder = 20
string dataobject = "d_wv_agreement_doc_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.21.2012
//====================================================================

// Retrieve detail
if CurrentRow > 0 then
	this.SelectRow(0, false)
	this.SelectRow(CurrentRow, true)
	il_agreement_id = this.GetItemNumber(CurrentRow, "agreement_id")
	if ib_RetrieveDetail then
		dw_detail.Retrieve(il_agreement_id)
	end if
else
	dw_detail.Reset()
end if
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

type cb_delete from commandbutton within w_wv_agreement_painter
integer x = 713
integer y = 36
integer width = 320
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Delete
// $<add> (Appeon) evan 02.21.2012
//====================================================================

integer li_rc
long ll_agreement_id

dw_detail.AcceptText()
ll_agreement_id = dw_detail.GetItemNumber(1, "agreement_id")

if IsNull(ll_agreement_id) then
	dw_detail.Reset()
	dw_detail.InsertRow(0)
	dw_detail.SetColumn("agreement_name")
	dw_detail.SetFocus()
	Return
end if

li_rc = MessageBox("Delete", "Are you sure you want to permanently delete current agreement?", Question!, OkCancel!)
if li_rc = 1 then
	gnv_appeondb.of_StartQueue()
	DELETE FROM wv_agreement_documents WHERE agreement_id = :ll_agreement_id;
	COMMIT;
	gnv_appeondb.of_CommitQueue()
	dw_facility.Event RowFocusChanged(dw_facility.GetRow())
end if
end event

type cb_save from commandbutton within w_wv_agreement_painter
integer x = 23
integer y = 36
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Save
// $<add> (Appeon) evan 02.22.2012
//====================================================================

integer li_rc
integer li_Row
string ls_agreement_name
dwitemstatus ldwi_status

// Check agreement name if null
dw_detail.AcceptText()
ls_agreement_name = dw_detail.GetItemString(1, "agreement_name")
if IsNull(ls_agreement_name) or Trim(ls_agreement_name) = "" then
	MessageBox("Save", "Agreement Name can not be empty or null.", Exclamation!)
	dw_detail.SetColumn("agreement_name")
	dw_detail.SetFocus()
	Return
end if

// Set items
ldwi_status = dw_detail.GetItemStatus(1, 0, Primary!)
choose case ldwi_status
	case NewModified!
		dw_detail.SetItem(1, "facility_id", il_facility_id)
		dw_detail.SetItem(1, "create_by", gs_user_id)
		dw_detail.SetItem(1, "create_date", DateTime(today(), now()))
	case DataModified!
		dw_detail.SetItem(1, "last_updated_by", gs_user_id)
		dw_detail.SetItem(1, "last_updated_date", DateTime(today(), now()))
	case else
		Return
end choose

// Save data
if dw_detail.Update() = 1 then
	Commit;
	if ldwi_status = NewModified! then
		ib_RetrieveDetail = false
		li_Row = dw_agreement.InsertRow(0)
		dw_agreement.SetItem(li_Row, "agreement_id", dw_detail.GetItemNumber(1, "agreement_id"))
		dw_agreement.SetItem(li_Row, "agreement_name", ls_agreement_name)
		dw_agreement.ScrollToRow(li_Row)
		ib_RetrieveDetail = true
	else
		dw_agreement.SetItem(dw_agreement.GetRow(), "agreement_name", ls_agreement_name)
	end if
else
	Rollback;
	MessageBox("Save", "Failed to save agreement.", StopSign!)
end if
end event

type dw_facility from u_dw within w_wv_agreement_painter
integer x = 64
integer y = 220
integer width = 937
integer height = 648
integer taborder = 10
string dataobject = "d_wv_facility_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.21.2012
//====================================================================

// Reset detail data
dw_detail.Reset()
dw_agreement.Reset()

// Retrieve agreements
if CurrentRow > 0 then
	this.SelectRow(0, false)
	this.SelectRow(CurrentRow, true)
	il_facility_id = this.GetItemNumber(CurrentRow, "facility_id")
	dw_agreement.Retrieve(il_facility_id)
	if dw_detail.RowCount() < 1 then
		dw_detail.InsertRow(0)
		of_SetAppointmentState()
	end if
end if
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type cb_close from commandbutton within w_wv_agreement_painter
integer x = 3150
integer y = 36
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 02.22.2012
//====================================================================

Close(Parent)
end event

type gb_4 from groupbox within w_wv_agreement_painter
integer x = 32
integer y = 908
integer width = 1006
integer height = 852
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Agreement"
end type

type gb_1 from groupbox within w_wv_agreement_painter
integer x = 32
integer y = 148
integer width = 1006
integer height = 748
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Facility"
end type

type dw_detail from u_dw within w_wv_agreement_painter
integer x = 1029
integer y = 136
integer width = 2601
integer height = 1644
integer taborder = 60
string dataobject = "d_wv_agreement_doc_detail"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

event retrieveend;call super::retrieveend;of_SetAppointmentState()
end event

