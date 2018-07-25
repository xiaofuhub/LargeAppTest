$PBExportHeader$w_import_audit_report.srw
forward
global type w_import_audit_report from w_response
end type
type st_2 from statictext within w_import_audit_report
end type
type dw_prac_change from datawindow within w_import_audit_report
end type
type cb_export from commandbutton within w_import_audit_report
end type
type rb_all from radiobutton within w_import_audit_report
end type
type rb_accept from radiobutton within w_import_audit_report
end type
type rb_previous from radiobutton within w_import_audit_report
end type
type rb_rejected from radiobutton within w_import_audit_report
end type
type cb_print from commandbutton within w_import_audit_report
end type
type dw_report from u_dw within w_import_audit_report
end type
type cb_close from commandbutton within w_import_audit_report
end type
type gb_1 from groupbox within w_import_audit_report
end type
end forward

global type w_import_audit_report from w_response
integer width = 3762
integer height = 2288
string title = "Import Audit Report"
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_2 st_2
dw_prac_change dw_prac_change
cb_export cb_export
rb_all rb_all
rb_accept rb_accept
rb_previous rb_previous
rb_rejected rb_rejected
cb_print cb_print
dw_report dw_report
cb_close cb_close
gb_1 gb_1
end type
global w_import_audit_report w_import_audit_report

type variables
datastore ids_address_lookup, ids_code_lookup, ids_facility, ids_active_status, ids_question
datastore ids_qa_metrics, ids_committee, ids_prac_change
long il_status = 9
long   il_import_id, il_hdr

end variables

forward prototypes
public function integer of_constract_dw ()
public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col)
public function integer of_dddw_field (datawindow adw_detail)
public function integer of_filter_detail ()
public function integer of_set_changes ()
public function integer of_filter_prac ()
end prototypes

public function integer of_constract_dw ();//////////////////////////////////////////////////////////////////////
// $<Function> of_dddw_field
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2013 by Stephen
//////////////////////////////////////////////////////////////////////

ids_address_lookup = create datastore
ids_code_lookup = create datastore
ids_facility = create datastore
ids_active_status = create datastore
ids_question = create datastore
ids_qa_metrics = create datastore
ids_committee = create datastore
ids_prac_change = create datastore

ids_address_lookup.DataObject = "d_import_ds_lu_address"
ids_code_lookup.DataObject = "d_import_ds_lu_code"
ids_facility.DataObject = "d_import_ds_lu_facility"
ids_active_status.DataObject = "d_import_ds_lu_activestatus"
ids_question.dataobject = "d_g_quest_lookup"
ids_committee.DataObject = "d_import_ds_lu_committee"
ids_qa_metrics.DataObject = "d_import_ds_lu_metrics"
ids_prac_change.dataobject = "d_import_audit_change"

ids_address_lookup.settransobject(sqlca)
ids_code_lookup.settransobject(sqlca)
ids_facility.settransobject(sqlca)
ids_active_status.settransobject(sqlca)
ids_question.settransobject(sqlca)
ids_committee.settransobject(sqlca)
ids_qa_metrics.settransobject(sqlca)
ids_prac_change.settransobject(sqlca)
return 1
end function

public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col);//////////////////////////////////////////////////////////////////////
// $<function> of_get_dddw_field
// $<arguments>
// $<returns> string
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2013 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_display
long   ll_find

// Retrieve lookup data
choose case as_lookuptype
	case "A" //Address
		if ids_address_lookup.RowCount()  <= 0 then
			ids_address_lookup.Retrieve()
		end if
		ll_find = ids_address_lookup.find("lookup_code = " +as_code,1, ids_address_lookup.rowcount())
		if ll_find > 0 then
			ls_display = ids_address_lookup.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
	case "C" //Code
		if ids_code_lookup.RowCount()  <= 0 then
			ids_code_lookup.Retrieve()
		end if
		ll_find = ids_code_lookup.find("lookup_code = " +as_code,1, ids_code_lookup.rowcount())
		if ll_find > 0 then
			ls_display = ids_code_lookup.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if				
	case "F" ,"I" //Facility
		if ids_facility.RowCount() <= 0 then ids_facility.Retrieve()
		ll_find = ids_facility.find("facility_id = " +as_code,1, ids_facility.rowcount())
		if ll_find > 0 then
			ls_display = ids_facility.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if			
	case "S" //Active Status 
		if ids_active_status.RowCount() <= 0 then ids_active_status.Retrieve()
		ll_find = ids_active_status.find("active_status_id = " +as_code,1, ids_active_status.rowcount())
		if ll_find > 0 then
			ls_display = ids_active_status.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if			
	case "Q" //QUESTION
		if ids_question.RowCount() <= 0 then ids_question.Retrieve()
		ll_find = ids_question.find("quest_id = " +as_code,1, ids_question.rowcount())
		if ll_find > 0 then
			ls_display = ids_question.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
	case "N_Q"  //QA Metrics
		if ids_qa_metrics.RowCount() <= 0 then ids_qa_metrics.Retrieve()
		ll_find = ids_qa_metrics.find("qam_id = " +as_code,1, ids_qa_metrics.rowcount())
		if ll_find > 0 then
			ls_display = ids_qa_metrics.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
	case "M"  //Committee
		if ids_committee.RowCount() <= 0 then ids_committee.Retrieve()
		ll_find = ids_committee.find("committee_id = " +as_code,1, ids_committee.rowcount())
		if ll_find > 0 then
			ls_display = ids_committee.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
end choose

Return ls_display
end function

public function integer of_dddw_field (datawindow adw_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_dddw_field
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.04.2013 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_field_type, ls_lookup_name
long ll_row, ll_rec, ll_j
string ls_lookup_code, ls_lookup_code_old
string ls_field, ls_type, ls_value
string ls_sql, ls_field_name, ls_table_name
string  ls_syntax, ls_error_create, ls_error_syntax

ll_j = 1
for ll_row = 1 to adw_detail.rowcount()
	//---------Begin Added by (Appeon)Stephen 12.19.2013 for Continuum Health Partners UAT testing--------
	ls_field_name = adw_detail.getitemstring(ll_row, 'sys_fields_field_name') 
	if ls_field_name = 'active_status' then
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'import_audit_item_new_value')
		ls_table_name = adw_detail.getitemstring(ll_row, 'sys_tables_table_name')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'new_value', ls_value) 
		
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'import_audit_item_old_value')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'old_value', ls_value) 
		continue
	end if
	//---------End Added ------------------------------------------------------
	
	//import data dddw
	ls_type = adw_detail.getitemstring(ll_row, 'import_audit_item_field_lu_type') 
	if isnull(ls_type) or ls_type = '' then 
		adw_detail.setitem(ll_row, 'new_value',  adw_detail.getitemstring(ll_row, 'import_audit_item_new_value'))
	end if
	ls_lookup_name = ''
	ls_lookup_name = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	
	choose case ls_type
		case "A"
			if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
		case "C"
			ls_lookup_name = 'description'
		case "F","I"
			ls_lookup_name = 'facility_name'
		case "Q"
			ls_type = "N_Q"
			ls_lookup_name = 'description'
		case "M" 
			ls_lookup_name = 'committee_name'
		case "S" 
			ls_lookup_name = 'active_status_name'
	end choose
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'import_audit_item_new_value')
	if isnull(ls_lookup_code) or ls_lookup_code = '' then 
		ls_value = ls_lookup_code
	else
		//---------Begin Modified by (Appeon)Stephen 11.07.2013 for Existing Import Advanced Audit issues--------
		//ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)	
		if not(isnull(ls_type) or ls_type = '') then
			ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
		else
			ls_value = ls_lookup_code
		end if
		//---------End Modfiied ------------------------------------------------------
	end if
	adw_detail.setitem(ll_row, 'new_value', ls_value)
	
	//current data dddw
	ls_field_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		adw_detail.setitem(ll_row, 'old_value',  adw_detail.getitemstring(ll_row, 'import_audit_item_old_value'))
		continue
	end if
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	if ls_type = 'A' then
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_lookup_name = 'short_quest'
	else
		ls_lookup_name = 'description'
	end if	
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'import_audit_item_old_value')
	if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
	adw_detail.setitem(ll_row, 'old_value', ls_value)
next

adw_detail.accepttext()
return 1
end function

public function integer of_filter_detail ();//////////////////////////////////////////////////////////////////////
// $<function> of_filter_detail
// $<arguments>
//              
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.03.2013
//////////////////////////////////////////////////////////////////////
string ls_filter
integer f

//Start Code Change ----11.04.2013 #V14 maha
//ls_filter = " 1 =1 "
ls_filter = ""

//if il_status <> 9 then 	ls_filter = ls_filter + " and import_audit_item_status = " + string(il_status)
if il_status <> 9 then 	ls_filter = ls_filter + " status = " + string(il_status)

dw_report.setredraw(false)
f = dw_report.setfilter(ls_filter)
if f < 0 then messagebox("Filter failed",ls_filter)
//End Code Change ----11.04.2013
dw_report.filter()
dw_report.setredraw(true)
return 1
end function

public function integer of_set_changes ();//Start Code Change ----03.11.2013 #V12 maha - added
long r
integer li_change

for r = 1 to dw_report.rowcount()
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.19.2013
	//$<reason> Adding a changed field 
	/*dw_report.setitem( r, "has_changed", dw_report.getitemnumber(r , "is_changed"))*/
	li_change = dw_report.getitemnumber(r , "is_changed")
	if li_change = 1 then
		dw_report.setitem( r, "has_changed","Yes")
	else
		dw_report.setitem( r, "has_changed","No")
	end if
	//------------------- APPEON END -------------------
next

return 1
end function

public function integer of_filter_prac ();//////////////////////////////////////////////////////////////////////
// $<Function> of_filter_prac
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//                       filter Prac
//////////////////////////////////////////////////////////////////////
// $<add> 03.12.2013 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_change
long   ll_prac_id, ll_row, ll_find

dw_prac_change.accepttext()
if dw_prac_change.getrow() < 1 then return 1
ls_change = dw_prac_change.getitemstring(1,"s_type")

dw_report.setredraw(false)
dw_report.retrieve(il_import_id, il_hdr)

if ls_change = '1' then
	for ll_row = dw_report.rowcount() to 1 step -1
		ll_prac_id = dw_report.getitemnumber(ll_row, "import_audit_item_prac_id")
		ll_find = ids_prac_change.find("prac_id = "+string(ll_prac_id), 1, ids_prac_change.rowcount())
		if ll_find < 1 then dw_report.deleterow(ll_row)
	next
elseif ls_change = '2' then
	for ll_row = dw_report.rowcount() to 1 step -1
		ll_prac_id = dw_report.getitemnumber(ll_row, "import_audit_item_prac_id")
		ll_find = ids_prac_change.find("prac_id = "+string(ll_prac_id), 1, ids_prac_change.rowcount())
		if ll_find > 0 then dw_report.deleterow(ll_row)
	next
end if

of_dddw_field(dw_report)
dw_report.setredraw(true)
return 1
end function

on w_import_audit_report.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_prac_change=create dw_prac_change
this.cb_export=create cb_export
this.rb_all=create rb_all
this.rb_accept=create rb_accept
this.rb_previous=create rb_previous
this.rb_rejected=create rb_rejected
this.cb_print=create cb_print
this.dw_report=create dw_report
this.cb_close=create cb_close
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_prac_change
this.Control[iCurrent+3]=this.cb_export
this.Control[iCurrent+4]=this.rb_all
this.Control[iCurrent+5]=this.rb_accept
this.Control[iCurrent+6]=this.rb_previous
this.Control[iCurrent+7]=this.rb_rejected
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.dw_report
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.gb_1
end on

on w_import_audit_report.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_prac_change)
destroy(this.cb_export)
destroy(this.rb_all)
destroy(this.rb_accept)
destroy(this.rb_previous)
destroy(this.rb_rejected)
destroy(this.cb_print)
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2013 by Stephen
//////////////////////////////////////////////////////////////////////

str_size lstr_str
integer li_count , li_new

lstr_str = Message.powerobjectParm
il_import_id = lstr_str.x
il_hdr = lstr_str.y
of_constract_dw()

gnv_appeondb.of_startqueue( )
dw_report.setredraw(false)
dw_report.retrieve(il_import_id, il_hdr)
ids_prac_change.retrieve(il_hdr)
gnv_appeondb.of_CommitQueue( )

of_dddw_field(dw_report)
dw_report.setredraw(true)
of_set_changes()

dw_report.modify("t_change.text = '"+string(ids_prac_change.rowcount()) +"'")
if dw_report.rowcount() > 0 then
	li_count = dw_report.getitemnumber(1,"compute_2")
	li_new = dw_report.getitemnumber(1, "import_audit_hdr_num_new")  //add by stephen 04.30.2013 -- 12.3 Import testing 
	dw_report.modify("t_nochange.text = '"+string(li_count - li_new - ids_prac_change.rowcount()) +"'")
end if



end event

event resize;call super::resize;//////////////////////////////////////////////////////////////////////
// $<Event> resize
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2013 by Stephen
//////////////////////////////////////////////////////////////////////

dw_report.width = newwidth - 30
dw_report.height = newheight - 180

//Start Code Change ----03.18.2013 #V12 maha - removed
//cb_close.x = newwidth - cb_close.width - 30
//cb_print.x = cb_close.x -  cb_close.width - 50
//cb_export.x = cb_print.x -  cb_print.width - 50
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<Event> closequery
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2013 by Stephen
//////////////////////////////////////////////////////////////////////

if isvalid(ids_address_lookup) then destroy ids_address_lookup
if isvalid(ids_facility) then destroy ids_facility
if isvalid(ids_active_status) then destroy ids_active_status
if isvalid(ids_question) then destroy ids_question
if isvalid(ids_code_lookup) then destroy ids_code_lookup
if isvalid(ids_committee) then destroy ids_committee
if isvalid(ids_qa_metrics) then destroy ids_qa_metrics


end event

type st_2 from statictext within w_import_audit_report
integer x = 32
integer y = 8
integer width = 416
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217751
long backcolor = 33551856
string text = "Practitioner Filter"
boolean focusrectangle = false
end type

type dw_prac_change from datawindow within w_import_audit_report
integer x = 23
integer y = 64
integer width = 946
integer height = 76
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_import_change"
boolean border = false
boolean livescroll = true
end type

event itemchanged;of_filter_prac()
end event

type cb_export from commandbutton within w_import_audit_report
integer x = 2743
integer y = 36
integer width = 370
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export to Excel"
end type

event clicked;integer i
string ls_path = ""


//i = dw_report.SaveAs( "", Text!, True )
gnv_dw.of_SaveAs(dw_report,"",Excel8!,true)
end event

type rb_all from radiobutton within w_import_audit_report
integer x = 2546
integer y = 60
integer width = 146
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;long ll_row
il_status = 9
of_filter_detail()
end event

type rb_accept from radiobutton within w_import_audit_report
integer x = 1019
integer y = 60
integer width = 439
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To be Accepted"
end type

event clicked;long ll_row
 il_status = 0
 of_filter_detail()
end event

type rb_previous from radiobutton within w_import_audit_report
integer x = 1463
integer y = 60
integer width = 544
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Accepted"
end type

event clicked;long ll_row
 il_status = 1
 of_filter_detail()
end event

type rb_rejected from radiobutton within w_import_audit_report
integer x = 2007
integer y = 60
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Rejected"
end type

event clicked;long ll_row
 il_status = -1
 of_filter_detail()
end event

type cb_print from commandbutton within w_import_audit_report
integer x = 3127
integer y = 36
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;
if dw_report.rowcount() < 1 then return
dw_report.event pfc_print()
end event

type dw_report from u_dw within w_import_audit_report
integer x = 18
integer y = 156
integer width = 3707
integer height = 1988
integer taborder = 20
string dataobject = "d_rpt_import_audit_report"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

type cb_close from commandbutton within w_import_audit_report
integer x = 3438
integer y = 36
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type gb_1 from groupbox within w_import_audit_report
integer x = 983
integer width = 1719
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Data Filter"
end type

