$PBExportHeader$w_import_pre_process_setup.srw
forward
global type w_import_pre_process_setup from window
end type
type st_1 from statictext within w_import_pre_process_setup
end type
type cb_add from commandbutton within w_import_pre_process_setup
end type
type cb_delete from commandbutton within w_import_pre_process_setup
end type
type cb_close from commandbutton within w_import_pre_process_setup
end type
type cb_save from commandbutton within w_import_pre_process_setup
end type
type dw_records from u_dw within w_import_pre_process_setup
end type
type dw_field_list from u_dw within w_import_pre_process_setup
end type
type dw_map_fields from u_dw within w_import_pre_process_setup
end type
type dw_fields from u_dw within w_import_pre_process_setup
end type
type dw_tables from u_dw within w_import_pre_process_setup
end type
end forward

global type w_import_pre_process_setup from window
integer width = 3950
integer height = 2192
boolean titlebar = true
string title = "Import Pre-process Setup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_add cb_add
cb_delete cb_delete
cb_close cb_close
cb_save cb_save
dw_records dw_records
dw_field_list dw_field_list
dw_map_fields dw_map_fields
dw_fields dw_fields
dw_tables dw_tables
end type
global w_import_pre_process_setup w_import_pre_process_setup

type variables
integer il_dragrow
long il_DragValue[]
long il_import
long il_SelectedCount
end variables

forward prototypes
public function integer of_begindrag (datawindow adw_data)
end prototypes

public function integer of_begindrag (datawindow adw_data);if KeyDown(KeyLeftButton!) and il_DragRow > 0 then //and not ib_LockFile then
	adw_data.Drag(Begin!)
end if

Return 1
end function

on w_import_pre_process_setup.create
this.st_1=create st_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_records=create dw_records
this.dw_field_list=create dw_field_list
this.dw_map_fields=create dw_map_fields
this.dw_fields=create dw_fields
this.dw_tables=create dw_tables
this.Control[]={this.st_1,&
this.cb_add,&
this.cb_delete,&
this.cb_close,&
this.cb_save,&
this.dw_records,&
this.dw_field_list,&
this.dw_map_fields,&
this.dw_fields,&
this.dw_tables}
end on

on w_import_pre_process_setup.destroy
destroy(this.st_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_records)
destroy(this.dw_field_list)
destroy(this.dw_map_fields)
destroy(this.dw_fields)
destroy(this.dw_tables)
end on

event open;il_import = message.doubleparm

dw_tables.settransobject( sqlca)
dw_tables.retrieve()
dw_tables.insertrow(1)

dw_fields.settransobject( sqlca)
dw_fields.retrieve()

dw_fields.setfilter("table_id = -12345")  //clear the fields
dw_fields.filter()

dw_records.settransobject( sqlca)
dw_records.retrieve(il_import)

dw_map_fields.settransobject( sqlca)
dw_records.sharedata( dw_map_fields)

dw_field_list.settransobject( sqlca)
dw_field_list.retrieve(il_import)
end event

type st_1 from statictext within w_import_pre_process_setup
integer x = 18
integer y = 24
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Table"
boolean focusrectangle = false
end type

type cb_add from commandbutton within w_import_pre_process_setup
integer x = 2734
integer y = 80
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;integer nr

nr = dw_map_fields.insertrow(0)
dw_map_fields.setitem(nr, "imp_id", il_import)
dw_map_fields.setitem(nr, "process_order", nr)
dw_map_fields.setrow(nr)
dw_map_fields .scrolltorow(nr)

end event

type cb_delete from commandbutton within w_import_pre_process_setup
integer x = 3090
integer y = 80
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Delete"
end type

type cb_close from commandbutton within w_import_pre_process_setup
integer x = 3506
integer y = 80
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

type cb_save from commandbutton within w_import_pre_process_setup
integer x = 2373
integer y = 80
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_records.update()
end event

type dw_records from u_dw within w_import_pre_process_setup
event ue_dragdrop ( long al_row )
string tag = "dw_records"
integer x = 754
integer y = 204
integer width = 2094
integer height = 680
integer taborder = 30
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Pre-Process Steps"
string dataobject = "d_import_pre_process_browse"
boolean hscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

event ue_dragdrop(long al_row);long ll_InsertRow
long i, ll_RowCount
long ll_dv_table_id

//ll_dv_table_id = dw_tables.object.table_id[il_DragRow]
//Parent.SetRedraw(false)
//
//// Insert a import table record
//ll_InsertRow = of_GetInsertRow(ll_dv_table_id)
//ll_InsertRow = this.InsertRow(ll_InsertRow)
//this.object.isoft_table_id[ll_InsertRow] = ll_dv_table_id
//this.object.import_id[ll_InsertRow] = il_curr_import_id
//this.ScrollToRow(ll_InsertRow)
//
//// Set sort number
//for i = 1 to this.RowCount()
//	this.SetItem(i, "sort_no", i)
//next
//
//// Update import table records
//if this.Update() <> 1 then
//	of_CompleteTrans(false)
//	Parent.SetRedraw(true)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	Return
//end if
//this.Event RowFocusChanged(this.GetRow())
//
//// Update mapped record fields
//if dw_map_fields.Update() = 1 then
//	of_CompleteTrans(true)
//else
//	of_CompleteTrans(false)
//	Parent.SetRedraw(true)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//end if
//
//Parent.SetRedraw(true)
end event

event clicked;call super::clicked;//inherit
long ll_table_id

il_DragRow = Row
//if dwo.name = "p_1" or dwo.name = "p_2" then //V10.1 - Import Link Value
//	ll_table_id = this.object.isoft_table_id[Row]
//	if ll_table_id = 2 or ll_table_id = 9 or ll_table_id = 20 then
//		this.SetRow(Row)
//		OpenWithParm(w_import_linkvalue_setting, this)
//	end if
//end if
dw_map_fields.scrolltorow(row)
end event

event constructor;call super::constructor;//Inherit
//this.DragIcon = gs_current_path + "\row.ico"
end event

event dberror;//override
//is_mapfield_errinfo = SQLErrText

Return 1
end event

event doubleclicked;call super::doubleclicked;//if not ib_LockFile and Row > 0 then
//	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
//		il_DragRow = Row
//		dw_tables.Event ue_DragDrop()
//	end if
//elseif row = 0 then //Start Code Change ----02.04.2008 #V8 maha
//	if this.height < 400 then
//		this.height = 768
//	else
//		this.height = 396
//	end if
//end if
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_tables" then
	this.Event ue_DragDrop(Row)
end if
end event

event dragwithin;call super::dragwithin;/*
if Source.tag = "dw_tables" then
	// Select row	
	if Row >0 then
		if not IsSelected(Row) then
			this.SelectRow(0, false)
			this.SelectRow(Row, true)
		end if		
	else
		this.SelectRow(0, false)
	end if
end if
*/
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;////inherit
//long ll_FindRow
//long ll_isoft_table_id
//long ll_table_records_id
//string ls_table_name_allias
//DataWindowChild ldwc_Child
//
//if CurrentRow >0 then
//	this.SelectRow(0, false)
//	this.SelectRow(CurrentRow, true)
//end if
//	
//	// Filter Mapped record fields
//	ll_table_records_id = this.object.table_records_id[CurrentRow]
//	if IsNull(ll_table_records_id) then
//		dw_map_fields.SetFilter("1 <> 1")
//	else
//		dw_map_fields.SetFilter("table_records_id = " + String(ll_table_records_id))
//	end if
//	dw_map_fields.Filter()
//	dw_map_fields.ScrollToRow(1)
//	dw_map_fields.Event RowFocusChanged(1)
//	
//	// Filter Provider Identification Field(s)
//	/*
//	dw_prac_cont_id.SetRedraw(false)
//	dw_prac_cont_id.Reset()
//	dw_map_fields.RowsCopy(1, dw_map_fields.RowCount(), Primary!, dw_prac_cont_id, 1, Primary!)	
//	dw_prac_cont_id.SetFilter("id_field = 1")
//	dw_prac_cont_id.Filter()
//	dw_prac_cont_id.SetRedraw(true)
//	*/
//	
//	// Set IntelliSoft Table display name in dw_detail
//	ll_isoft_table_id = this.object.isoft_table_id[CurrentRow]
//	if not IsNull(ll_isoft_table_id) then
//		ll_FindRow = dw_tables.Find("table_id=" + String(ll_isoft_table_id), 1, dw_tables.RowCount())
//		if ll_FindRow > 0 then
//			ls_table_name_allias = dw_tables.object.table_name_allias[ll_FindRow]
//			dw_detail.object.t_intellisoft_table.text = ls_table_name_allias			
//			is_curr_table_name = Lower(dw_tables.object.table_name[ll_FindRow]) // Get current table_name
//			dw_tables.ScrollToRow(ll_FindRow)
//		end if
//	end if
//	if ll_FindRow <= 0 then
//		dw_detail.object.t_intellisoft_table.text = ""
//		is_curr_table_name = ""
//	end if
//	
//	//	Set null_value list of dw_detail
//	dw_detail.GetChild("null_value", ldwc_Child)
//	choose case is_curr_table_name
//		case "pd_address", "pd_hosp_affil", "pd_board_specialty"
//			if is_curr_table_name = "pd_address" then
//				ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *', 'Address Type')")
//			else
//				ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *', 'Yes/No')")
//			end if
//		case else
//			ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *')")
//	end choose
//	ldwc_Child.Filter()
//	
//	// Set facility_id of dw_detail enabled
//	choose case is_curr_table_name
//		case "pd_affil_stat", "pd_address", "pd_hosp_affil", "pd_board_specialty"
//			dw_detail.object.facility_id.protect = 0
//			dw_detail.object.facility_id.background.color = 16777215
//		case else
//			dw_detail.object.facility_id.protect = 1
//			dw_detail.object.facility_id.background.color = 67108864
//	end choose
//else
//	dw_map_fields.SetFilter("1 <> 1")
//	dw_map_fields.Filter()
//	//dw_prac_cont_id.Reset()
//end if
end event

event mousemove;//of_BeginDrag(this)
end event

type dw_field_list from u_dw within w_import_pre_process_setup
string tag = "dw_field_list"
integer x = 2889
integer y = 204
integer width = 946
integer height = 1780
integer taborder = 20
string dragicon = "droparrow.ico"
boolean bringtotop = true
boolean titlebar = true
string title = "Import Fields"
string dataobject = "d_import_fields"
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;integer li_Return

choose case dwo.name
	case "b_add"
//		Event pfc_cst_add()
	case "b_delete"
//		Event pfc_cst_delete()
	case "b_compare"
//		li_Return = tab_1.tabpage_field_data.Event ue_save()
//		if li_Return = 1 then
//			Open(w_import_comparefield)
//		end if
end choose
end event

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
//		[il_SelectedCount] = this.object.rec_id[i]
	end if
next

Drag(begin!)
end event

event constructor;call super::constructor;//inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

end event

event dberror;//override
//is_mapfield_errinfo = SQLErrText

Return 1
end event

event doubleclicked;call super::doubleclicked;//if not ib_LockFile and Row > 0 then
//	il_DragRow = Row
//	if ii_CurrMappedDW = 1 then
//		dw_prac_cont_id.Event ue_impfield_dragdrop(0)
//	else
//		dw_map_fields.Event ue_impfield_dragdrop(0)
//	end if
//end if
end event

event dragdrop;call super::dragdrop;//long ll_DeleteRow
//long ll_dv_mapped_field_id
//
//if Source.tag = "dw_prac_cont_id" then
//	ll_dv_mapped_field_id = dw_prac_cont_id.object.rec_id[il_DragRow]
//elseif Source.tag = "dw_map_fields" then
//	ll_dv_mapped_field_id = dw_map_fields.object.rec_id[il_DragRow]
//else
//	Return
//end if
//
//ll_DeleteRow = dw_prac_cont_id.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_prac_cont_id.RowCount())
//if ll_DeleteRow > 0 then dw_prac_cont_id.DeleteRow(ll_DeleteRow)
//
//ll_DeleteRow = dw_map_fields.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_map_fields.RowCount())
//if ll_DeleteRow > 0 then dw_map_fields.DeleteRow(ll_DeleteRow)
//dw_detail.ScrollToRow(dw_map_fields.GetRow())
//
//if dw_map_fields.Update() = 1 then
//	of_CompleteTrans(true)
//else
//	of_CompleteTrans(false)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//end if
end event

event dragenter;call super::dragenter;//tab_1.tabpage_field_data.Event ue_save()
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;////inherit
//string ls_comp_def
//
//if CurrentRow > 0 then
//	dw_imp_field_detail.ScrollToRow(CurrentRow)
//	
//	ls_comp_def = Trim(this.object.comp_def[CurrentRow])
//	if IsNull(ls_comp_def) then ls_comp_def = ""
//	if ib_LockFile or LenA(ls_comp_def) > 0 then
//		cb_create_value_list.Enabled = false
//	else
//		cb_create_value_list.Enabled = true
//	end if
//end if
end event

event mousemove;of_BeginDrag(this)
end event

type dw_map_fields from u_dw within w_import_pre_process_setup
event ue_sysfield_dragdrop ( long al_row )
event ue_impfield_dragdrop ( long al_row )
string tag = "dw_map_fields"
integer x = 763
integer y = 916
integer width = 2080
integer height = 1068
integer taborder = 20
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Process Mapping"
string dataobject = "d_import_pre_process_detail"
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event ue_sysfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long i, ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_field_id

//// Get field ID and table ID
//ll_table_id = dw_tables.object.table_id[dw_tables.GetRow()]
//if dw_records.GetRow() > 0 then
//	ll_isoft_table_id = dw_records.object.isoft_table_id[dw_records.GetRow()]
//else
//	ll_isoft_table_id = -1
//end if
//
//// Check field of drag whether already exists
//if ll_table_id = ll_isoft_table_id then
//	for i = 1 to il_SelectedCount
//		ll_FindRow = dw_map_fields.Find("isoft_field_id=" + String(il_DragValue[i]), 1, dw_map_fields.RowCount())
//		if ll_FindRow > 0 then
//			dw_map_fields.ScrollToRow(ll_FindRow)
//			dw_map_fields.SelectRow(0, false)
//			dw_map_fields.SelectRow(ll_FindRow, true)
//			MessageBox("Prompt", "The Intellisoft Field already exists.")
//			Return
//		end if
//	next
//end if
//
//if ll_table_id = ll_isoft_table_id and al_Row > 0 then
//	// Replace a mapped field record
//	ll_dv_field_id = dw_fields.object.field_id[il_DragRow]	
//	ll_mapped_field_id = dw_map_fields.object.rec_id[al_Row]
//	ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_prac_cont_id.RowCount())
//	if ll_FindRow > 0 then 
//		dw_prac_cont_id.object.isoft_field_id[ll_FindRow] = ll_dv_field_id
//		dw_prac_cont_id.ScrollToRow(ll_FindRow)	
//	end if
//	dw_map_fields.object.isoft_field_id[al_Row] = ll_dv_field_id	
//	if dw_map_fields.Update() = 1 then
//		of_CompleteTrans(true)
//	else
//		of_CompleteTrans(false)
//		MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	end if
//else
//	// Insert a import table record
//	if ll_table_id <> ll_isoft_table_id then
//		ll_InsertRow = dw_records.InsertRow(0)
//		ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
//		dw_records.object.import_id[ll_InsertRow] = tab_1.tabpage_hdr.dw_browse.object.import_id[ll_CurrentRow]
//		dw_records.object.isoft_table_id[ll_InsertRow] = ll_table_id
//		dw_records.ScrollToRow(ll_InsertRow)
//		dw_prac_cont_id.Reset()
//		
//		// Set sort number (25:pd_basic, 1001:ctx_basic_info)
//		if ll_table_id = 25 or ll_table_id = 1001 then
//			for i = 1 to dw_records.RowCount()
//				dw_records.SetItem(i, "sort_no", i)
//			next
//			dw_records.SetItem(dw_records.GetRow(), "sort_no", 0)
//			dw_records.Sort()
//			dw_records.ScrollToRow(1)
//		elseif ll_InsertRow > 1 then
//			dw_records.SetItem(ll_InsertRow, "sort_no", dw_records.object.sort_no[ll_InsertRow - 1] + 1)
//		else
//			dw_records.SetItem(ll_InsertRow, "sort_no", 1)
//		end if		
//		
//		// Update import table records
//		if dw_records.Update() <> 1 then
//			of_CompleteTrans(false)
//			MessageBox("Error", is_mapfield_errinfo, StopSign!)
//			Return
//		end if
//	end if
//	ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
//	
//	// Insert mapped field records
//	for i = 1 to il_SelectedCount
//		ll_InsertRow = dw_map_fields.InsertRow(0)
//		dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
//		dw_map_fields.object.isoft_field_id[ll_InsertRow] = il_DragValue[i]
//		dw_map_fields.object.id_field[ll_InsertRow] = 0		
//	next
//	dw_map_fields.ScrollToRow(ll_InsertRow)
//	
//	// Update mapped field records
//	if dw_map_fields.Update() = 1 then
//		of_CompleteTrans(true)
//		dw_detail.SetRedraw(true)
//	else
//		of_CompleteTrans(false)
//		MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	end if
//end if
end event

event ue_impfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_import_field_id
long i, ll_Null

//SetNull(ll_Null)
//if dw_records.GetRow() <= 0 then
//	MessageBox("Prompt", "There is no import table record.")
//	Return	
//end if
//
//// Insert or replace a mapped field record
//if al_Row > 0 then
//	// Replace a mapped field record	
//	ll_dv_import_field_id = dw_field_list.object.rec_id[il_DragRow]	
//	ll_mapped_field_id = dw_map_fields.object.rec_id[al_Row]	
//	ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_prac_cont_id.RowCount())
//	if ll_FindRow > 0 then
//		dw_prac_cont_id.object.import_field_id[ll_FindRow] = ll_dv_import_field_id
//		dw_prac_cont_id.ScrollToRow(ll_FindRow)
//	end if
//	dw_map_fields.object.import_field_id[al_Row] = ll_dv_import_field_id
//	dw_map_fields.object.facility_id[al_Row] = ll_Null
//	if dw_map_fields.Update() = 1 then
//		of_CompleteTrans(true)
//	else
//		of_CompleteTrans(false)
//		MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	end if
//else
//	// Insert a mapped field record
//	for i = 1 to il_SelectedCount
//		ll_InsertRow = dw_map_fields.InsertRow(0)
//		ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
//		dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
//		dw_map_fields.object.import_field_id[ll_InsertRow] = il_DragValue[i]
//		dw_map_fields.object.id_field[ll_InsertRow] = 0		
//	next
//	dw_map_fields.ScrollToRow(ll_InsertRow)
//
//	if dw_map_fields.Update() = 1 then
//		of_CompleteTrans(true)
//		dw_detail.SetRedraw(true)
//	else
//		of_CompleteTrans(false)
//		MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	end if
//end if
end event

event clicked;//inherit
//il_DragRow = Row
//this.ScrollToRow(Row)
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
//this.DragIcon = gs_current_path + "\row.ico"
end event

event dberror;//override
//is_mapfield_errinfo = SQLErrText

Return 1
end event

event doubleclicked;call super::doubleclicked;//if not ib_LockFile and Row > 0 then
//	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
//		il_DragRow = Row
//		dw_fields.Event ue_DragDrop(this.tag)
//	end if
//end if
end event

event dragdrop;call super::dragdrop;//Start Code Change ----07.19.2013 #V14 maha
string ls_val
string ls_table
string ls_field = "NONE"
long ll_tid
datawindow idw_data


choose case  source.tag
	case  "dw_fields"
		choose case dwo.name
			case "isg_field1", "isg_field2", "isg_field3", "get_field"
				idw_data = dw_fields
				ls_field = "field_name"
		end choose
	case "dw_field_list"
		choose case dwo.name
			case  "imp_field1", "imp_field2", "imp_field3", "prac_field", "result_field"
				idw_data =dw_field_list
				ls_field = "imp_field_name"
			end choose
end choose	

if  ls_field = "NONE" then
	//nothing
else	
	ls_val = idw_data.getitemstring(idw_data.getrow(), ls_field)
		
	if source.tag  = "dw_fields" then
		if isnull(this.getitemstring(row, "isg_table")) then
			ll_tid = idw_data.getitemnumber(idw_data.getrow(), "table_id")
			select table_name into :ls_table from sys_tables where table_id = :ll_tid;
			this.setitem(row, "isg_table", ls_table)
		end if
	end if
		
	this.setitem(row, dwo.name, ls_val)
end if

		




end event

event dragwithin;call super::dragwithin;//if Source.tag = "dw_fields" or Source.tag = "dw_field_list" then
//	// Select row	
//	if Row >0 then
//		if not IsSelected(Row) then
//			this.SelectRow(0, false)
//			this.SelectRow(Row, true)
//			this.ScrollToRow(Row)
//		end if		
//	else
//		this.SelectRow(0, false)
//	end if
//end if
end event

event getfocus;call super::getfocus;//inherit
//of_SetMappedDWTitle(2)
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;//inherit
//dw_detail.ScrollToRow(CurrentRow)

end event

event mousemove;//of_BeginDrag(this)
end event

type dw_fields from u_dw within w_import_pre_process_setup
event ue_dragdrop ( string as_dw )
string tag = "dw_fields"
integer y = 200
integer width = 736
integer height = 1784
integer taborder = 20
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "IntelliSoft Fields"
string dataobject = "d_import_intellisoftfields"
borderstyle borderstyle = stylebox!
end type

event ue_dragdrop(string as_dw);//long ll_DeleteRow
//long ll_dv_mapped_field_id
//
//if as_dw = "dw_prac_cont_id" then
//	ll_dv_mapped_field_id = dw_prac_cont_id.object.rec_id[il_DragRow]
//elseif as_dw = "dw_map_fields" then
//	ll_dv_mapped_field_id = dw_map_fields.object.rec_id[il_DragRow]
//else
//	Return
//end if
//
//ll_DeleteRow = dw_prac_cont_id.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_prac_cont_id.RowCount())
//if ll_DeleteRow > 0 then dw_prac_cont_id.DeleteRow(ll_DeleteRow)
//
//ll_DeleteRow = dw_map_fields.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_map_fields.RowCount())
//if ll_DeleteRow > 0 then dw_map_fields.DeleteRow(ll_DeleteRow)
//dw_detail.ScrollToRow(dw_map_fields.GetRow())
//
//if dw_map_fields.Update() = 1 then
//	of_CompleteTrans(true)
//else
//	of_CompleteTrans(false)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//end if
end event

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
		il_DragValue[il_SelectedCount] = this.object.field_id[i]
	end if
next

Drag(begin!)
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)

end event

event doubleclicked;call super::doubleclicked;//if not ib_LockFile and Row > 0 then
//	il_DragRow = Row
//	if ii_CurrMappedDW = 1 then
//		dw_prac_cont_id.Event ue_sysfield_dragdrop(0)
//	else
//		dw_map_fields.Event ue_sysfield_dragdrop(0)
//	end if
//end if
end event

event dragdrop;call super::dragdrop;//this.Event ue_DragDrop(Source.tag)
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event mousemove;of_BeginDrag(this)
end event

type dw_tables from u_dw within w_import_pre_process_setup
event ue_dragdrop ( )
string tag = "dw_tables"
integer x = 5
integer y = 88
integer width = 1070
integer height = 80
integer taborder = 10
string dragicon = "row.ico"
string title = "IntelliSoft Tables"
string dataobject = "d_table_list_table"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dragdrop();//long ll_DeleteRow
//long ll_CurrentRow
//long ll_dv_table_records_id
//
//// Delete import table records and mapped record fields
//ll_dv_table_records_id = dw_records.object.table_records_id[il_DragRow]
//
//ll_DeleteRow = dw_records.Find("table_records_id=" + String(ll_dv_table_records_id), 1, dw_records.RowCount())
//if ll_DeleteRow <= 0 then Return
//
//dw_map_fields.SetFilter("table_records_id = " + String(ll_dv_table_records_id))
//dw_map_fields.Filter()
//dw_map_fields.RowsMove(1, dw_map_fields.RowCount(), Primary!, dw_map_fields, 1, Delete!)
//
//dw_records.DeleteRow(ll_DeleteRow)
//if dw_records.GetSelectedRow(1) <= 0 then
//	dw_records.SelectRow(dw_records.GetRow(), true)
//end if
//
//// Update all
//if dw_records.Update() <> 1 then
//	of_CompleteTrans(false)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//	Return
//end if
//
//if dw_map_fields.Update() = 1 then
//	of_CompleteTrans(true)
//else
//	of_CompleteTrans(false)
//	MessageBox("Error", is_mapfield_errinfo, StopSign!)
//end if
//
//// Filter dw_prac_cont_id and mapped fields
//dw_records.Event RowFocusChanged(dw_records.GetRow())
end event

event clicked;call super::clicked;//inherit
il_DragRow = Row
end event

event constructor;call super::constructor;//Inherit
//this.DragIcon = gs_current_path + "\row.ico"
end event

event doubleclicked;call super::doubleclicked;//if not ib_LockFile and Row > 0 then
//	il_DragRow = Row
//	dw_records.Event ue_DragDrop(0)
//end if
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_records" then 
	this.Event ue_DragDrop()
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;////inherit
//string ls_Filter
//
////if Current row less than 1
//if CurrentRow <= 0 then
//	dw_fields.SetFilter("1 <> 1")
//	dw_fields.Filter()
//	Return
//end if
//this.SelectRow(0, false)
//this.SelectRow(CurrentRow, true)
//
////Filter data of dw_fields
//if ii_curr_isoft_module = 1 then
//	//IntelliCred/App module
//	ls_Filter = "table_id = " + String(this.object.table_id[CurrentRow])
//	ls_Filter += " AND Lower(field_name) not in ('rec_id','prac_id','seq_no', 'lookup_code', 'gp_id', 'qam_id')" //V11.3 QA Import
//else
//	//IntelliContract module
//	ls_Filter = of_GetContractFieldFilter(this)
//end if
//dw_fields.SetFilter(ls_Filter)
//dw_fields.Filter()
//
//dw_fields.SetRow(1)
//dw_fields.SelectRow(0, false)
//dw_fields.SelectRow(1, true)
end event

event mousemove;//of_BeginDrag(this)
end event

event itemchanged;call super::itemchanged;integer t
integer f
string ls_table
datawindowchild dwchild

t = integer(data)

this.getchild( "data_view_screen_screen_name", dwchild )

f = dwchild.find( "sys_tables_table_id = " + data ,1, dwchild.rowcount())
if f > 0 then
	ls_table = dwchild.getitemstring(f, "sys_tables_table_name")
	if dw_map_fields.getrow() > 0 then   //(Appeon)Harry 11.28.2013 - V141 for BugH092401 of History Issues
		if isnull(dw_map_fields.getitemstring(dw_map_fields.getrow(), "isg_table") )  or dw_map_fields.getitemstring(dw_map_fields.getrow(), "isg_table") = "" then
			dw_map_fields.setitem(dw_map_fields.getrow(), "isg_table", ls_table)
		end if
	end if
end if

//messagebox(string(f), ls_table)


dw_fields.setfilter("table_id = " + string(t))
dw_fields.filter()
end event

