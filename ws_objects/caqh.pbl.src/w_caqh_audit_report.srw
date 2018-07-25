$PBExportHeader$w_caqh_audit_report.srw
forward
global type w_caqh_audit_report from w_popup
end type
type dw_change_filter from datawindow within w_caqh_audit_report
end type
type cb_filter from commandbutton within w_caqh_audit_report
end type
type cb_reset from commandbutton within w_caqh_audit_report
end type
type dw_date_range from u_dw within w_caqh_audit_report
end type
type dw_prac_finished from datawindow within w_caqh_audit_report
end type
type cb_export from commandbutton within w_caqh_audit_report
end type
type cb_print from commandbutton within w_caqh_audit_report
end type
type dw_report from u_dw within w_caqh_audit_report
end type
type cb_close from commandbutton within w_caqh_audit_report
end type
type gb_2 from groupbox within w_caqh_audit_report
end type
type gb_3 from groupbox within w_caqh_audit_report
end type
type gb_4 from groupbox within w_caqh_audit_report
end type
end forward

global type w_caqh_audit_report from w_popup
integer x = 214
integer y = 221
integer width = 3758
integer height = 2192
string title = "CAQH Audit Report"
long backcolor = 33551856
boolean ib_isupdateable = false
dw_change_filter dw_change_filter
cb_filter cb_filter
cb_reset cb_reset
dw_date_range dw_date_range
dw_prac_finished dw_prac_finished
cb_export cb_export
cb_print cb_print
dw_report dw_report
cb_close cb_close
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_caqh_audit_report w_caqh_audit_report

type variables
string is_original_sql


datastore ids_address_lookup, ids_code_lookup, ids_facility, ids_active_status, ids_question
datastore ids_committee
end variables

forward prototypes
public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col)
public function integer of_dddw_field (datawindow adw_detail)
public function integer of_retrieve ()
public function integer of_create_dw ()
public subroutine of_set_sumary ()
end prototypes

public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col);//////////////////////////////////////////////////////////////////////
// $<function> of_get_dddw_field
// $<arguments>
// $<returns> string
// $<description> Appeon long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------
//$<Modify History>: copied from n_cst_import.of_get_dddw_field, Appeon long.zhang 03.30.2015
//====================================================================

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
//	case "N_Q"  //QA Metrics
//		if ids_qa_metrics.RowCount() <= 0 then ids_qa_metrics.Retrieve()
//		ll_find = ids_qa_metrics.find("qam_id = " +as_code,1, ids_qa_metrics.rowcount())
//		if ll_find > 0 then
//			ls_display = ids_qa_metrics.getitemstring(ll_find, as_sel_col)
//			return ls_display
//		else			
//			return as_code
//		end if		
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

public function integer of_dddw_field (datawindow adw_detail);//====================================================================
//$<Function>: of_dddw_field
//$<Arguments>:
// 	value    datawindow    adw_detail
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>: copied n_cst_import.of_dddw_field and modified it.  (Appeon) long.zhang 03.30.2015
//====================================================================

string ls_field_type, ls_lookup_name
long ll_row, ll_rec, ll_j
string ls_lookup_code, ls_lookup_code_old
string ls_field, ls_type, ls_value
string ls_sql, ls_field_name, ls_table_name
string  ls_syntax, ls_error_create, ls_error_syntax

ll_j = 1
for ll_row = 1 to adw_detail.rowcount()
	ls_field_name = adw_detail.getitemstring(ll_row, 'caqh_audit_item_field_name') 
	if ls_field_name = 'active_status' then
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value')
		ls_table_name = adw_detail.getitemstring(ll_row, 'sys_tables_table_name')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'new_value', ls_value) 
		
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'old_value', ls_value) 
		continue
	end if
	
	//import data dddw
	//ls_type = adw_detail.getitemstring(ll_row, 'caqh_audit_item_field_lu_type') 
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	if isnull(ls_type) or ls_type = '' or ls_type = 'N' then //add 'N', Added by Appeon long.zhang 03.10.2016 ( V15.1 Bug # 5032 - CAQH Import Audit Report is not showing Board expiration date)
		adw_detail.setitem(ll_row, 'new_value',  adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value'))
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
		case "Q" //Question
			ls_lookup_name = 'full_quest'
		case "M" 
			ls_lookup_name = 'committee_name'
		case "S" 
			ls_lookup_name = 'active_status_name'
	end choose
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value')
	
	if isnull(ls_lookup_code) or ls_lookup_code = '' then 
		ls_value = ls_lookup_code
	else
		if not(isnull(ls_type) or ls_type = '' or ls_type = 'N') then //add 'N', Added by Appeon long.zhang 03.10.2016 ( V15.1 Bug # 5032 - CAQH Import Audit Report is not showing Board expiration date)
			//get lookup value
			ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
		else
			ls_value = ls_lookup_code
		end if
	end if
	adw_detail.setitem(ll_row, 'new_value', ls_value)
	
	//current data dddw
	ls_field_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		adw_detail.setitem(ll_row, 'old_value',  adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value'))
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
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value')
	if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
	adw_detail.setitem(ll_row, 'old_value', ls_value)
next

adw_detail.accepttext()
return 1
end function

public function integer of_retrieve ();//====================================================================
//$<Function>: of_retrieve
//$<Arguments>:
//$<Return>:  integer
//$<Description>: retrieve dw_report
//$<Author>: (Appeon) long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
int i
string ls_from_date, ls_to_date
string ls_filter, ls_user
long   ll_import
string ls_sql
string ls_change, ls_date_condition, ls_change_condition, ls_finished_condition

//date condition
if dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "convert(varchar,cl.log_date,120) >='"+ls_from_date +"'"
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and convert(varchar,cl.log_date,120) <= '"+ls_to_date +"'"
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " convert(varchar,cl.log_date,120) <= '"+ ls_to_date+"'"
else
	ls_filter = " 1 = 1 "
end if
ls_date_condition = ls_filter

//changes
dw_change_filter.accepttext()
if dw_change_filter.getrow() < 1 then return 1
ls_change = dw_change_filter.getitemstring(1,"s_type")

if ls_change = '1' then //changes
	ls_change_condition = 'ca.value_changed = 1'
elseif ls_change = '0' then //no changes
	ls_change_condition = 'ca.value_changed = 0'
else //both
	ls_change_condition = " 1 = 1 "
end if

//status condition, user can't change it.
dw_prac_finished.accepttext()
if dw_prac_finished.getrow() < 1 then return 1
ls_change = dw_prac_finished.getitemstring(1,"s_type")

if ls_change = '1' then //to be audit
	ls_finished_condition = 'cl.audit_finished = 0'
elseif ls_change = '2' then //finished
	ls_finished_condition =  'cl.audit_finished = 1'
else //both
	ls_finished_condition = " 1 = 1 "
end if

//setsql
dw_report.setsqlselect (is_original_sql + ' and ' + ls_change_condition + ' and ' +  ls_date_condition + ' and ' +  ls_finished_condition)

//retrieve
SetPointer ( HourGlass! )
dw_report.setredraw(false)
i = dw_report.retrieve()

of_dddw_field(dw_report)

//set sumary
of_set_sumary()

dw_report.setredraw(true)

SetPointer ( Arrow! )

return i

end function

public function integer of_create_dw ();//====================================================================
//$<Function>: of_create_dw
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.31.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ids_address_lookup = create datastore
ids_code_lookup = create datastore
ids_facility = create datastore
ids_active_status = create datastore
ids_question = create datastore
ids_committee = create datastore

ids_address_lookup.DataObject = "d_import_ds_lu_address"
ids_code_lookup.DataObject = "d_import_ds_lu_code"
ids_facility.DataObject = "d_import_ds_lu_facility"
ids_active_status.DataObject = "d_import_ds_lu_activestatus"
ids_question.dataobject = "d_g_quest_lookup"
ids_committee.DataObject = "d_import_ds_lu_committee"

ids_address_lookup.settransobject(sqlca)
ids_code_lookup.settransobject(sqlca)
ids_facility.settransobject(sqlca)
ids_active_status.settransobject(sqlca)
ids_question.settransobject(sqlca)
ids_committee.settransobject(sqlca)

return 1
end function

public subroutine of_set_sumary ();
int i,li_prac_cnt,li_new,li_match,li_changed,li_notchanged
int li_prac_ids[],li_prac_empty[],j
long ll_prac_id
boolean lb_find = false

if dw_report.rowcount() = 0 then return

//li_prac_cnt
For i = 1 to dw_report.rowcount()
	ll_prac_id = dw_report.getitemnumber(i,'caqh_log_prac_id')
	
	If upperbound(li_prac_ids[]) = 0 Then
		li_prac_ids[1] = ll_prac_id
		lb_find = true
	Else 
		//find prac_id in array
		lb_find = false
		for j = 1 to upperbound(li_prac_ids[])
			If li_prac_ids[j] = ll_prac_id Then
				lb_find = true
				Exit
			End If
		Next
	End If
	
	If lb_find Then li_prac_cnt++
Next

//li_new,li_match,li_changed,li_notchanged
For i = 1 to upperbound(li_prac_ids[])
	ll_prac_id = li_prac_ids[i]
	If dw_report.find("caqh_log_imp_type = 'N' and caqh_log_prac_id = " +string(ll_prac_id),1,dw_report.rowcount()) > 0 Then li_new++
	If dw_report.find("caqh_log_imp_type = 'U' and caqh_log_prac_id = " +string(ll_prac_id),1,dw_report.rowcount()) > 0 Then li_match++
	If dw_report.find("has_changed = 'Yes' and caqh_log_prac_id = " +string(ll_prac_id),1,dw_report.rowcount()) > 0 Then li_changed++
	If dw_report.find("has_changed = 'No' and caqh_log_prac_id = " +string(ll_prac_id),1,dw_report.rowcount()) > 0 Then li_notchanged++
Next

//li_match
dw_report.modify("t_new.text = '"+ string(li_new) +"'")
dw_report.modify("t_match.text = '"+ string(li_match) +"'")
dw_report.modify("t_change.text = '"+ string(li_changed) +"'")
dw_report.modify("t_nochange.text = '"+ string(li_notchanged) +"'")
end subroutine

on w_caqh_audit_report.create
int iCurrent
call super::create
this.dw_change_filter=create dw_change_filter
this.cb_filter=create cb_filter
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.dw_prac_finished=create dw_prac_finished
this.cb_export=create cb_export
this.cb_print=create cb_print
this.dw_report=create dw_report
this.cb_close=create cb_close
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_change_filter
this.Control[iCurrent+2]=this.cb_filter
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.dw_date_range
this.Control[iCurrent+5]=this.dw_prac_finished
this.Control[iCurrent+6]=this.cb_export
this.Control[iCurrent+7]=this.cb_print
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
end on

on w_caqh_audit_report.destroy
call super::destroy
destroy(this.dw_change_filter)
destroy(this.cb_filter)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.dw_prac_finished)
destroy(this.cb_export)
destroy(this.cb_print)
destroy(this.dw_report)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;//initial change condition:to be audited
dw_prac_finished.setitem(1,"s_type",'2')
dw_change_filter.setitem(1,"s_type",'1')

is_original_sql = dw_report.getsqlselect()

of_create_dw()

gnv_appeondb.of_startqueue( )
dw_report.setredraw(false)
//dw_report.retrieve(il_import_id, il_hdr)
gnv_appeondb.of_CommitQueue( )

of_dddw_field(dw_report)
dw_report.setredraw(true)

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


end event

event pfc_postopen;call super::pfc_postopen;dw_date_range.of_SetUpdateAble( False )
dw_date_range.of_SetTransObject( SQLCA )
dw_date_range.InsertRow( 0 )

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
dw_date_range.of_setupdateable(false) 
end event

type dw_change_filter from datawindow within w_caqh_audit_report
integer x = 55
integer y = 56
integer width = 453
integer height = 76
integer taborder = 70
string title = "none"
string dataobject = "d_dddw_caqh_import_change"
boolean border = false
boolean livescroll = true
end type

type cb_filter from commandbutton within w_caqh_audit_report
integer x = 2368
integer y = 40
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
boolean default = true
end type

event clicked;//retrieve
of_retrieve()
end event

type cb_reset from commandbutton within w_caqh_audit_report
integer x = 1659
integer y = 40
integer width = 183
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re&set"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.04.2013 by Stephen
//////////////////////////////////////////////////////////////////////

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
end event

type dw_date_range from u_dw within w_caqh_audit_report
integer x = 530
integer y = 56
integer width = 1147
integer height = 80
integer taborder = 60
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.insertrow(1)
this.setitem(1,'from_date', RelativeDate ( today(), -1 ))
this.setitem(1,'to_date', today())

end event

type dw_prac_finished from datawindow within w_caqh_audit_report
integer x = 1883
integer y = 56
integer width = 453
integer height = 76
integer taborder = 60
string title = "none"
string dataobject = "d_dddw_caqh_import_finished"
boolean border = false
boolean livescroll = true
end type

type cb_export from commandbutton within w_caqh_audit_report
integer x = 2729
integer y = 40
integer width = 375
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save As.."
end type

event clicked;integer i
string ls_path = ""


//i = dw_report.SaveAs( "", Text!, True )
gnv_dw.of_SaveAs(dw_report,"",Excel8!,true)
end event

type cb_print from commandbutton within w_caqh_audit_report
integer x = 3109
integer y = 40
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

type dw_report from u_dw within w_caqh_audit_report
integer x = 37
integer y = 176
integer width = 3680
integer height = 1900
integer taborder = 20
string dataobject = "d_rpt_caqh_audit_report"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

event clicked;call super::clicked;if row < 1 then return

//select row
this.selectrow(0, false)
this.selectrow(row, true)

end event

type cb_close from commandbutton within w_caqh_audit_report
integer x = 3410
integer y = 40
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

type gb_2 from groupbox within w_caqh_audit_report
integer x = 1861
integer width = 498
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status Option"
end type

type gb_3 from groupbox within w_caqh_audit_report
integer x = 521
integer width = 1335
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

type gb_4 from groupbox within w_caqh_audit_report
integer x = 27
integer width = 489
integer height = 144
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Changes Filter"
end type

