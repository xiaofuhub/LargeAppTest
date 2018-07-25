$PBExportHeader$w_process_setup.srw
forward
global type w_process_setup from w_sheet
end type
type cb_audit from commandbutton within w_process_setup
end type
type cb_copy_step from commandbutton within w_process_setup
end type
type cb_1 from commandbutton within w_process_setup
end type
type dw_step_detail from u_dw within w_process_setup
end type
type dw_step_browse from u_dw within w_process_setup
end type
type dw_template_detail from u_dw within w_process_setup
end type
type dw_template from u_dw within w_process_setup
end type
type cb_add_temp from commandbutton within w_process_setup
end type
type cb_del_alert from commandbutton within w_process_setup
end type
type cb_save from commandbutton within w_process_setup
end type
type cb_close from commandbutton within w_process_setup
end type
type cb_copy_alert from commandbutton within w_process_setup
end type
type cb_add_step from commandbutton within w_process_setup
end type
type cb_del_step from commandbutton within w_process_setup
end type
type gb_2 from groupbox within w_process_setup
end type
type gb_1 from groupbox within w_process_setup
end type
end forward

global type w_process_setup from w_sheet
integer width = 3913
integer height = 2368
string title = "Process Setup"
long backcolor = 33551856
cb_audit cb_audit
cb_copy_step cb_copy_step
cb_1 cb_1
dw_step_detail dw_step_detail
dw_step_browse dw_step_browse
dw_template_detail dw_template_detail
dw_template dw_template
cb_add_temp cb_add_temp
cb_del_alert cb_del_alert
cb_save cb_save
cb_close cb_close
cb_copy_alert cb_copy_alert
cb_add_step cb_add_step
cb_del_step cb_del_step
gb_2 gb_2
gb_1 gb_1
end type
global w_process_setup w_process_setup

type variables
boolean ib_CopyAlert = false
boolean ib_DeleteAlert = false
end variables

forward prototypes
public function integer of_savemaster ()
public function integer of_savedata ()
public function integer of_savedetail ()
public function integer of_selectemail ()
public function boolean of_datachanged (datawindow adw_data)
public function integer of_selectdoc ()
end prototypes

public function integer of_savemaster ();//////////////////////////////////////////////////////////////////////
// $<function> of_savemaster
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_temp_id
long i, ll_NewRowCount
string ls_Label
string ls_Column
DWItemStatus ldis_Status

// Check data
//if not of_DataChanged(dw_template) then Return 1
for i = 1 to dw_template_detail.RowCount()
	ldis_Status = dw_template_detail.GetItemStatus(i, 0, Primary!)
	if ldis_Status = NotModified! then Continue
	if ldis_Status = New! or ldis_Status = NewModified! then
		ll_NewRowCount ++
	end if
	ls_Column = ""
//check for required fields

//	if ls_Column <> "" then
//		ls_Label = dw_template_detail.Describe(ls_Column + "_t.text")
//		dw_template.ScrollToRow(i)
//		dw_template_detail.SetColumn(ls_Column)
//		MessageBox("Prompt", "The " + ls_Label + " cannot be null.")
//		dw_template_detail.SetFocus()
//		Return -1
//	end if
next

// Set primary key
if ll_NewRowCount > 0 then
	SELECT max(temp_id) INTO :ll_temp_id FROM process_template;
	if IsNull(ll_temp_id) then ll_temp_id = 0
	for i = 1 to dw_template_detail.RowCount()
		if dw_template_detail.GetItemStatus(i, 0, Primary!) = NewModified! then
			ll_temp_id ++
			dw_template_detail.SetItem(i, "temp_id", ll_temp_id)
		end if
	next
end if

// Save data
if dw_template_detail.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
	Return -1
end if

Return 1
end function

public function integer of_savedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedata
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

if of_SaveMaster() = -1 then Return -1
if of_SaveDetail() = -1 then Return -1

Return 1
end function

public function integer of_savedetail ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedetail
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_item_id
long ll_alert_type
long ll_upper_range
long ll_MasterRow
long i, ll_NewRowCount
string ls_Label
string ls_Column
DWItemStatus ldis_Status

ll_MasterRow = dw_template.GetRow()
if ll_MasterRow < 1 then Return 1
//if not of_DataChanged(dw_step_browse) then Return 1


// Check data
dw_step_detail.accepttext( )
for i = 1 to dw_step_detail.RowCount()
	ldis_Status = dw_step_detail.GetItemStatus(i, 0, Primary!)
	if ldis_Status = NotModified! then Continue
	if ldis_Status = New! or ldis_Status = NewModified! then
		ll_NewRowCount ++
	end if
next


if dw_step_browse.RowCount() > 0 then
	dw_step_browse.Sort()
	dw_step_browse.ScrollToRow(1)
	dw_step_detail.ScrollToRow(1)
	dw_step_browse.SelectRow(0, false)
	dw_step_browse.SelectRow(1, true)
	for i = 1 to dw_step_browse.RowCount()
		if isnull(dw_step_browse.getItemnumber(i, "step_order")) then dw_step_browse.SetItem(i, "step_order", i)
	next
end if

// Set primary and foreign key
if ll_NewRowCount > 0 then
	SELECT max(item_id) INTO :ll_item_id FROM process_steps;
	if IsNull(ll_item_id) then ll_item_id = 0
	for i = 1 to dw_step_browse.RowCount()
		if dw_step_browse.GetItemStatus(i, 0, Primary!) = NewModified! then
			ll_item_id ++
			dw_step_browse.SetItem(i, "item_id", ll_item_id)
			//dw_step_browse.SetItem(i, "alert_id", dw_template.object.=temp_id[ll_MasterRow])
		end if
	next
end if

// Save data
if dw_step_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save step data.", StopSign!)
	Return -1
end if

Return 1
end function

public function integer of_selectemail ();long    j

Open(w_email_select)
j = Message.doubleparm
if j  < 1 THEN 
	RETURN 0
else
	dw_step_detail.setitem(dw_step_detail.getrow(),"document_id",j)
end if
end function

public function boolean of_datachanged (datawindow adw_data);//////////////////////////////////////////////////////////////////////
// $<function> of_datachanged
// $<arguments>
//			datawindow	adw_data
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

adw_data.AcceptText()
dw_template_detail.AcceptText()
dw_step_detail.AcceptText()

if adw_data.ModifiedCount() + adw_data.DeletedCount() > 0 then
	Return true
else
	Return false
end if
end function

public function integer of_selectdoc ();long j
long f

f = dw_template_detail.getitemnumber(dw_template_detail.getrow(),"facility_id")

Openwithparm(w_document_select,f)
j = Message.doubleparm
if j  < 1 THEN 
	RETURN 0
else
	dw_step_detail.setitem(dw_step_detail.getrow(),"document_id",j)
end if
end function

on w_process_setup.create
int iCurrent
call super::create
this.cb_audit=create cb_audit
this.cb_copy_step=create cb_copy_step
this.cb_1=create cb_1
this.dw_step_detail=create dw_step_detail
this.dw_step_browse=create dw_step_browse
this.dw_template_detail=create dw_template_detail
this.dw_template=create dw_template
this.cb_add_temp=create cb_add_temp
this.cb_del_alert=create cb_del_alert
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_copy_alert=create cb_copy_alert
this.cb_add_step=create cb_add_step
this.cb_del_step=create cb_del_step
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_audit
this.Control[iCurrent+2]=this.cb_copy_step
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_step_detail
this.Control[iCurrent+5]=this.dw_step_browse
this.Control[iCurrent+6]=this.dw_template_detail
this.Control[iCurrent+7]=this.dw_template
this.Control[iCurrent+8]=this.cb_add_temp
this.Control[iCurrent+9]=this.cb_del_alert
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.cb_copy_alert
this.Control[iCurrent+13]=this.cb_add_step
this.Control[iCurrent+14]=this.cb_del_step
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_1
end on

on w_process_setup.destroy
call super::destroy
destroy(this.cb_audit)
destroy(this.cb_copy_step)
destroy(this.cb_1)
destroy(this.dw_step_detail)
destroy(this.dw_step_browse)
destroy(this.dw_template_detail)
destroy(this.dw_template)
destroy(this.cb_add_temp)
destroy(this.cb_del_alert)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_copy_alert)
destroy(this.cb_add_step)
destroy(this.cb_del_step)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;long ll_alert_type
string ls_table_name
DataWindowChild ldwc_child

dw_template.SetTransObject(SQLCA)
dw_template_detail.SetTransObject(SQLCA)
dw_step_browse.SetTransObject(SQLCA)
dw_step_detail.SetTransObject(SQLCA)

dw_template.ShareData(dw_template_detail)
dw_step_browse.ShareData(dw_step_detail)
dw_template.Retrieve()

dw_template.GetChild("facility_id", ldwc_child)
ldwc_child.insertrow(1)
ldwc_child.setitem(1,"facility_id",0)
ldwc_child.setitem(1,"facility_name","ANY")

dw_template_detail.GetChild("facility_id", ldwc_child)
ldwc_child.insertrow(1)
ldwc_child.setitem(1,"facility_id",0)
ldwc_child.setitem(1,"facility_name","ANY")

//dw_step_detail.GetChild("email_template", ldwc_child)
//ldwc_child.InsertRow(1)
//dw_step_detail.GetChild("email_from", ldwc_child)
//ldwc_child.InsertRow(1)
//dw_step_detail.GetChild("action_type", ldwc_child)
//ldwc_child.InsertRow(1)
//dw_step_detail.GetChild("app_id", ldwc_child)
//ldwc_child.InsertRow(1)

//of_InitTableNameDddw()
//of_InitFieldNameDddw()

end event

event closequery;//Override
integer li_Result

//if of_DataChanged(dw_alert_browse) or of_DataChanged(dw_step_browse) then
//	li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
//	choose case li_Result
//		case 1
//			if of_SaveData() = -1 then Return 1
//		case 2
//			Return 0
//		case 3
//			Return 1
//	end choose
//end if

Return 0
end event

event activate;call super::activate;//Inherit
if w_mdi.menuname <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
end event

event pfc_preopen;call super::pfc_preopen;this.of_SetResize(true)
inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

inv_resize.of_Register(gb_1, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_template, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_template_detail, inv_resize.FIXEDBOTTOM_SCALERIGHT)

//inv_resize.of_Register(cb_add_step, inv_resize.FIXEDBOTTOM)
//inv_resize.of_Register(cb_del_step, inv_resize.FIXEDBOTTOM)

inv_resize.of_Register(gb_2, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(dw_step_browse, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(dw_step_detail, inv_resize.FIXEDBOTTOM_SCALERIGHT)

//-----Begin Added by Alfee 10.29.2012 (BugS102302)------
inv_resize.of_Register(cb_add_temp, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(cb_del_alert, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(cb_copy_alert, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(cb_1, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(cb_save, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHT)

inv_resize.of_Register(cb_add_step, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_del_step, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_copy_step, inv_resize.FIXEDRIGHTBOTTOM)
//-----End Added -------------------------------------------------	

end event

type cb_audit from commandbutton within w_process_setup
boolean visible = false
integer x = 2674
integer y = 68
integer width = 187
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&lert Audit"
end type

event clicked;//Start Code Change ----04.12.2010 #V10 maha
open(w_alert_audit)
end event

type cb_copy_step from commandbutton within w_process_setup
integer x = 704
integer y = 1188
integer width = 302
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Step"
end type

event clicked;//Start Code Change ----03.23.2010 #V10 maha
long ll_Row
long ll_temp_id
//long ll_alert_type

ll_Row = dw_template.GetRow()
if ll_Row < 1 then Return
ll_temp_id = dw_template.object.temp_id[ll_Row]
//ll_alert_type = dw_template.object.alert_type[ll_Row]


ll_Row = dw_step_browse.GetRow()
if ll_Row < 1 then Return


dw_step_browse.rowscopy( ll_row, ll_row,primary!, dw_step_browse, 100, primary!)

dw_step_browse.SetItem(ll_Row, "temp_id", ll_temp_id)
//dw_step_browse.SetItem(ll_Row, "email_from", "MASTER")
//dw_step_browse.SetItem(ll_Row, "email_prac", 0)

dw_step_browse.ScrollToRow(ll_Row)
dw_step_detail.SetColumn("item_name")
dw_step_detail.SetFocus()
end event

type cb_1 from commandbutton within w_process_setup
integer x = 1769
integer y = 36
integer width = 425
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Email Templates"
end type

event clicked;//Start Code Change ----03.23.2010 #V10 maha
open(w_email_painter)

////------------------- APPEON BEGIN -------------------
////$<add> Evan 05.12.2010
////$<reason> Refresh template DDDW data
//datawindowchild ldwc_child1
//datawindowchild ldwc_child2
//dw_step_browse.GetChild("email_template", ldwc_child1)
//dw_step_detail.GetChild("email_template", ldwc_child2)
//ldwc_child1.SetTransObject(SQLCA)
//ldwc_child1.Retrieve()
//ldwc_child2.Reset()
//ldwc_child1.RowsCopy(1, ldwc_child1.RowCount(), Primary!, ldwc_child2, 1, Primary!)
////------------------- APPEON END ---------------------
end event

type dw_step_detail from u_dw within w_process_setup
integer x = 55
integer y = 1936
integer width = 3749
integer height = 224
integer taborder = 140
string dataobject = "d_process_steps_detail"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event other;call super::other;if Message.Number = 522 then
	Return 1
end if
end event

event buttonclicked;call super::buttonclicked;integer t

if dwo.name = "b_select" then	
	
	t = this.getitemnumber( row, "process_type")
	
	if isnull(t) then
		messagebox("Process Type","Please select the process type first.")
		return
	end if
	
	choose case t
		case 1
			messagebox("Notification","Templates are not used for Notation type processes.")
			return
		case 2
			of_selectdoc( )
		case 3
			of_SelectEmail()
	end choose

end if
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type dw_step_browse from u_dw within w_process_setup
integer x = 55
integer y = 1284
integer width = 3749
integer height = 608
integer taborder = 130
string dataobject = "d_process_steps_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_step_detail.ScrollToRow(CurrentRow)
end event

event clicked;call super::clicked;this.SetRow(Row)
dw_step_detail.ScrollToRow(Row)
end event

event dberror;Return 1
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type dw_template_detail from u_dw within w_process_setup
integer x = 55
integer y = 704
integer width = 3749
integer height = 348
integer taborder = 120
string dataobject = "d_process_templ_Detail"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event other;call super::other;if Message.Number = 522 then
	Return 1
end if
end event

event itemchanged;call super::itemchanged;long ll_Null
long ll_alert_type
string ls_Null

SetNull(ll_Null)
SetNull(ls_Null)

//choose case dwo.name
//	case "alert_category"
//		this.SetItem(Row, "alert_type", ll_Null)
//		this.SetItem(Row, "run_from", ll_Null)
//		this.SetItem(Row, "table_name", ls_Null)
//		this.SetItem(Row, "field_name", ls_Null)
//		this.SetItem(Row, "upper_range", ll_Null)
//		this.SetItem(Row, "active_only", ll_Null)
//		this.SetItem(Row, "facility_id", ll_Null)
//		of_FilterAlertTypeDddw(Long(Data))
//	case "alert_type"
//		// Do not have two New Practitioners alert type
//		ll_alert_type = Long(Data)
//		if ll_alert_type = 30 then
//			if of_AlertTypeExists(ll_alert_type) then
//				Post SetItem(Row, "alert_type", ll_Null)
//				Return 1 // Do not accept text
//			end if
//		end if
//		
//		// Set some fields status
//		this.SetItem(Row, "table_name", ls_Null)
//		this.SetItem(Row, "field_name", ls_Null)
//		this.SetItem(Row, "upper_range", ll_Null)
//		this.SetItem(Row, "active_only", ll_Null)
//		this.SetItem(Row, "facility_id", ll_Null)
//		of_FilterTableNameDddw(ll_alert_type)
//		of_SetActionItemEnabled(ll_alert_type, true)
//		Post of_SetAdvanceDaysEnabled()
//		
//		// There is one step only if alert type is New Practitioner
//		if ll_alert_type = 30 then
//			dw_step_browse.RowsMove(1, dw_step_browse.RowCount(), Primary!, dw_step_browse, 1, Delete!)
//			dw_step_detail.InsertRow(0)
//			dw_step_detail.SetItem(1, "step_order", 1)
//			dw_step_detail.ScrollToRow(1)
//		end if
//				
//		// Determine run from value
//		of_DetermineRunFrom(ll_alert_type, Row)
//	case "table_name"
//		this.SetItem(Row, "field_name", ls_Null)
//		of_FilterFieldNameDddw(Data)
//end choose
end event

event clicked;call super::clicked;choose case dwo.name
	case "alert_type"
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
	case "table_name"
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.alert_type[Row]) then
			MessageBox("Prompt", "Please select Alert Type first.")
			this.SetColumn("alert_type")
			this.SetFocus()
			Return 1
		end if
	case "field_name"
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.alert_type[Row]) then
			MessageBox("Prompt", "Please select Alert Type first.")
			this.SetColumn("alert_type")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.table_name[Row]) then
			MessageBox("Prompt", "Please select Table Name first.")
			this.SetColumn("table_name")
			this.SetFocus()
			Return 1
		end if
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_alert_type
long ll_alert_category
string ls_table_name
string ls_field_name
DWItemStatus ldis_ColStatus
DWItemStatus ldis_RowStatus

//if CurrentRow > 0 then
//	ll_alert_category = this.object.alert_category[CurrentRow]
//	ll_alert_type = this.object.alert_type[CurrentRow]
//	ls_table_name = this.object.table_name[CurrentRow]
//	ls_field_name = this.object.field_name[CurrentRow]
//	of_FilterAlertTypeDddw(ll_alert_category)
//	of_FilterTableNameDddw(ll_alert_type)
//	of_FilterFieldNameDddw(ls_table_name)
//	
//	// The following codes correct PB bug about dddw display
//	ldis_RowStatus = this.GetItemStatus(CurrentRow, 0, Primary!)
//	ldis_ColStatus = this.GetItemStatus(CurrentRow, "alert_type", Primary!)
//	this.SetItem(CurrentRow, "alert_type", ll_alert_type)
//	this.SetItemStatus(CurrentRow, "alert_type", Primary!, ldis_ColStatus)
//	ldis_ColStatus = this.GetItemStatus(CurrentRow, "table_name", Primary!)		
//	this.SetItem(CurrentRow, "table_name", ls_table_name)
//	this.SetItemStatus(CurrentRow, "table_name", Primary!, ldis_ColStatus)
//	ldis_ColStatus = this.GetItemStatus(CurrentRow, "field_name", Primary!)		
//	this.SetItem(CurrentRow, "field_name", ls_field_name)
//	this.SetItemStatus(CurrentRow, "field_name", Primary!, ldis_ColStatus)
//	this.SetItemStatus(CurrentRow, 0, Primary!, ldis_RowStatus)
//end if
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_upperhelp" then
	messagebox("Upper Range","Upper Range is how many days in the future the oldest alert will be.~rFor example, if the steps are at 90, 60 and 30 days, the upper range should be 90.")
end if
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type dw_template from u_dw within w_process_setup
integer x = 55
integer y = 224
integer width = 3749
integer height = 468
integer taborder = 110
string dataobject = "d_process_templ_browse"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//this.SetRow(Row)
//dw_alert_detail.ScrollToRow(Row)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_temp_id
long ll_alert_type

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_template_detail.ScrollToRow(CurrentRow)

if CurrentRow > 0 then	
	// Retrieve alert step
	if not ib_CopyAlert then
		ll_temp_id = this.object.temp_id[CurrentRow]
		//-----Begin Modified by Alfee 10.29.2012 (BugS102301 )------
		if IsNull(ll_temp_id) then
			dw_step_browse.Reset()
		else
			dw_step_browse.Retrieve(ll_temp_id)
			dw_step_browse.SelectRow(0, false)
			dw_step_browse.SelectRow(1, true)
		end if
		//dw_step_browse.Retrieve(ll_temp_id)
		//dw_step_browse.SelectRow(0, false)
		//dw_step_browse.SelectRow(1, true)		
		//-----End Modified -------------------------------------------------			
	end if
	
	// Set action item options status
	//ll_alert_type = this.object.alert_type[CurrentRow]
	//of_SetActionItemEnabled(ll_alert_type, false)
	
	// Set advance_days status
	//of_SetAdvanceDaysEnabled()
else
	dw_step_browse.Reset()
end if
end event

event dberror;Return 1
end event

event rowfocuschanging;//Override
integer li_Result

//if ib_CopyAlert or ib_DeleteAlert then
//	Return 0
//end if
//
//if of_DataChanged(dw_step_browse) then
//	li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
//	choose case li_Result
//		case 1
//			if of_SaveData() = -1 then Return 1
//		case 2
//			dw_step_browse.Reset()
//		case 3
//			Return 1
//	end choose
//end if

Return 0
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type cb_add_temp from commandbutton within w_process_setup
integer x = 352
integer y = 36
integer width = 562
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Process Template"
end type

event clicked;long ll_Row

//if of_DataChanged(dw_step_browse) then
//	MessageBox("Prompt", "Please save data first.")
//	Return
//end if

//-----Begin Modified by Alfee 10.29.2012 (BugS102301 )------
//ll_Row = dw_template_detail.InsertRow(0)
//dw_template_detail.ScrollToRow(ll_Row)
//dw_template_detail.ScrollToRow(ll_Row)
//
//dw_template_detail.SetItem(ll_Row, "active_status", 1)
//dw_template_detail.SetItem(ll_Row, "function_type", 1)
//dw_template_detail.SetItem(ll_Row, "facility_id", 0)
//dw_template_detail.SetColumn("temp_name")
//dw_template_detail.SetFocus()

ll_Row = dw_template.InsertRow(0)
dw_template.SetRow(ll_Row)
dw_template.ScrollToRow(ll_Row)

dw_template.SetItem(ll_Row, "active_status", 1)
dw_template.SetItem(ll_Row, "function_type", 1)
dw_template.SetItem(ll_Row, "facility_id", 0)

dw_template_detail.SetColumn("temp_name")
dw_template_detail.SetFocus()
//-----End Modified -------------------------------------------------	
end event

type cb_del_alert from commandbutton within w_process_setup
integer x = 1330
integer y = 36
integer width = 430
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Template"
end type

event clicked;long ll_Row
long ll_template_id
long ll_count	//long.zhang 09.19.2011

ll_Row = dw_template.GetRow()
if ll_Row < 1 then Return

ll_template_id = dw_template.object.temp_id[ll_Row]
if MessageBox("Delete", "Are you sure you want to delete the selected Process Template?", Question!, YesNo!) = 2 then
	Return
end if

//-------------------------APPEON BEGIN----------------------------
//$<add> long.zhang 09.19.2011
//$<Reason>Before delete this process template find whether this Template is using
select count(*) into :ll_count from pd_oppe_hrd where process_template = :ll_template_id;
if ll_count > 0 then
	MessageBox("Delete Error", "There are " + string(ll_count) + " oppe/fppe records connected to this template. Change or delete these records before deleting the selected Process Template.", StopSign!)
	return
end if
//-------------------------APPEON END------------------------------

// Delete notification alert
ib_DeleteAlert = true
dw_template.DeleteRow(ll_Row)

gnv_appeondb.of_StartQueue()
DELETE FROM process_steps WHERE temp_id = :ll_template_id;
//CHECK FOR CONNECTED PRACTITIONER DATA??
dw_template.Update()
gnv_appeondb.of_CommitQueue()

ll_Row = dw_template.GetRow()
dw_template.Event RowFocusChanged(ll_Row)
ib_DeleteAlert = false
end event

type cb_save from commandbutton within w_process_setup
integer x = 37
integer y = 36
integer width = 302
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;
integer li_ret

li_ret = of_SaveData()


if li_ret = 1 then
	gnv_data.of_retrieve('process_steps')
end if
end event

type cb_close from commandbutton within w_process_setup
integer x = 3529
integer y = 36
integer width = 302
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_copy_alert from commandbutton within w_process_setup
integer x = 928
integer y = 36
integer width = 398
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&opy Template"
end type

event clicked;long ll_MasterRow
long ll_DetailRowCount
long ll_alert_type
long ll_tempid, ll_row  //add by Stephen 09.08.2011

ll_MasterRow = dw_template.GetRow()
if ll_MasterRow < 1 then Return

if of_DataChanged(dw_template) or of_DataChanged(dw_step_browse) then
	MessageBox("Prompt", "Please save data first.")
	Return
end if
//ll_alert_type = dw_template.object.alert_type[ll_MasterRow]
//if ll_alert_type = 30 then
//	MessageBox("Prompt", "The New Practitioner alert type cannot be copied.")
//	Return
//end if

// Copy master record
ll_MasterRow = dw_template.InsertRow(0)
dw_template.object.data[ll_MasterRow] = dw_template.object.data[dw_template.getrow()]
if of_SaveMaster() = -1 then Return

if ll_MasterRow > dw_template_detail.rowcount() then return  //add by Stephen 09.08.2011 --Bug id 2608
ll_tempid = dw_template_detail.getitemnumber(ll_MasterRow, "temp_id") //add by Stephen 09.08.2011 --Bug id 2608

// Copy detail records
ll_DetailRowCount = dw_step_browse.RowCount()
if ll_DetailRowCount > 0 then
	dw_step_browse.RowsCopy(1, ll_DetailRowCount, Primary!, dw_step_browse, ll_DetailRowCount + 1, Primary!)
	dw_step_browse.RowsMove(1, ll_DetailRowCount, Primary!, dw_step_browse, 1, Delete!)
	dw_step_browse.RowsDiscard(1, dw_step_browse.DeletedCount(), Delete!)
	ib_CopyAlert = true
	dw_template.ScrollToRow(ll_MasterRow)
	dw_step_browse.SelectRow(1, true)
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 09.08.2011
	//$<reason> Bug id 2608
	for ll_row = 1 to dw_step_browse.rowcount()
		dw_step_browse.setitem(ll_row, "temp_id", ll_tempid)
	next
	//------------------- APPEON END -------------------
	
	of_SaveDetail()
	ib_CopyAlert = false
else
	dw_template.ScrollToRow(ll_MasterRow)
end if
end event

type cb_add_step from commandbutton within w_process_setup
integer x = 59
integer y = 1188
integer width = 302
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Step"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_temp_id
long ll_function_type

ll_Row = dw_template.GetRow()
if ll_Row < 1 then Return
ll_temp_id = dw_template.object.temp_id[ll_Row]
ll_function_type = dw_template.object.function_type[ll_Row]


ll_Row = dw_step_browse.InsertRow(0)
dw_step_browse.SetItem(ll_Row, "temp_id", ll_temp_id)
dw_step_browse.SetItem(ll_Row, "active_status", 1)
dw_step_browse.SetItem(ll_Row, "auto_complete", 0)
dw_step_browse.SetItem(ll_Row, "step_order", ll_row)
dw_step_browse.SetItem(ll_Row, "due_days", 0)

dw_step_browse.ScrollToRow(ll_Row)
dw_step_detail.SetColumn("item_name")
dw_step_detail.SetFocus()
end event

type cb_del_step from commandbutton within w_process_setup
integer x = 370
integer y = 1188
integer width = 329
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Step"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row

ll_Row = dw_step_browse.GetRow()
if ll_Row < 1 then Return


if MessageBox("Delete", "Are you sure you want to delete the selected Process step?", Question!, YesNo!) = 2 then
	Return
end if

dw_step_browse.DeleteRow(ll_Row)
ll_Row = dw_step_browse.GetRow()
dw_step_browse.Event RowFocusChanged(ll_Row)
end event

type gb_2 from groupbox within w_process_setup
integer x = 23
integer y = 1120
integer width = 3813
integer height = 1088
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Process Steps"
end type

type gb_1 from groupbox within w_process_setup
integer x = 23
integer y = 160
integer width = 3813
integer height = 912
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Process Templates"
end type

