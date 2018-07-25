$PBExportHeader$w_import_audit.srw
forward
global type w_import_audit from w_response
end type
type dw_prac_change from datawindow within w_import_audit
end type
type st_2 from statictext within w_import_audit
end type
type cb_print from commandbutton within w_import_audit
end type
type dw_screen from u_dw within w_import_audit
end type
type dw_link_list from u_dw within w_import_audit
end type
type cb_view from commandbutton within w_import_audit
end type
type dw_import from datawindow within w_import_audit
end type
type st_1 from statictext within w_import_audit
end type
type cb_reset from commandbutton within w_import_audit
end type
type dw_date_range from u_dw within w_import_audit
end type
type cb_filter from commandbutton within w_import_audit
end type
type cb_close from commandbutton within w_import_audit
end type
type rb_rejected from radiobutton within w_import_audit
end type
type rb_previous from radiobutton within w_import_audit
end type
type rb_accept from radiobutton within w_import_audit
end type
type rb_all from radiobutton within w_import_audit
end type
type cb_reject from commandbutton within w_import_audit
end type
type cb_accept from commandbutton within w_import_audit
end type
type dw_detail from u_dw within w_import_audit
end type
type dw_prac from u_dw within w_import_audit
end type
type dw_list from datawindow within w_import_audit
end type
type gb_1 from groupbox within w_import_audit
end type
type gb_2 from groupbox within w_import_audit
end type
end forward

global type w_import_audit from w_response
integer width = 3767
integer height = 2332
string title = "Import Auditing"
boolean minbox = true
boolean maxbox = true
windowtype windowtype = popup!
long backcolor = 33551856
dw_prac_change dw_prac_change
st_2 st_2
cb_print cb_print
dw_screen dw_screen
dw_link_list dw_link_list
cb_view cb_view
dw_import dw_import
st_1 st_1
cb_reset cb_reset
dw_date_range dw_date_range
cb_filter cb_filter
cb_close cb_close
rb_rejected rb_rejected
rb_previous rb_previous
rb_accept rb_accept
rb_all rb_all
cb_reject cb_reject
cb_accept cb_accept
dw_detail dw_detail
dw_prac dw_prac
dw_list dw_list
gb_1 gb_1
gb_2 gb_2
end type
global w_import_audit w_import_audit

type variables
string is_original_sql

integer il_status = 0
datetime idt_CurrentTime

datastore ids_address_lookup, ids_code_lookup, ids_facility, ids_active_status, ids_question
datastore ids_qa_metrics, ids_committee
datastore ids_table_record
str_import_cur istr_screen_ds[]

pfc_n_cst_ai_action_items inv_action_items
pfc_cst_nv_data_entry_functions inv_data_entry
n_cst_dataflow inv_dataflow
n_import_ds ids_address, ids_hosp_facility, ids_spec_facility
n_import_ds ids_log_error, ids_audit_log_table
long il_hdr_id, il_import_id

constant long IL_ERRTYPE_OTHER          = 0
constant long IL_ERRTYPE_MAPDESIGN      = 1
constant long IL_ERRTYPE_VERIFYVALUE    = 2
constant long IL_ERRTYPE_DATAINTEGRITY  = 3
constant long IL_ERRTYPE_ADDVERIFY      = 4
constant long IL_ERRTYPE_UPDATE         = 5
constant long IL_MAX_ERRORCOUNT         = 100

// Group Practice datastore(use in match gp_id)
n_import_ds ids_group_practice
n_import_ds ids_group_practice_new
datastore ids_audit_item
datastore ids_prac_change
datastore ids_audit_facility
long il_group_practice_id
long il_table_records_id
boolean ib_check = true
string  is_error

end variables

forward prototypes
public function integer of_filter_dw ()
public function integer of_auto_filter (str_flag astr_flag)
public function integer of_filter_detail (long al_row)
public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess)
public function long of_get_next_seq_no (string as_dw, long al_rec_id)
public function integer of_dddw_field (datawindow adw_detail)
public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col)
public function integer of_audit (long al_prac_id, u_dw adw_detail)
public function integer of_audit_screen (string as_table_name, long al_seq_no, integer ai_table_id, datastore ads_detail)
public function integer of_update_address_link (long al_prac_id, long al_address_id, integer ai_facility_id)
public function integer of_update_hosp_link (long al_prac_id, long al_seq_no, integer ai_facility_id)
public function integer of_update_spec_link (long al_prac_id, long al_seq_no, integer ai_facility_id)
public function integer of_update_links (integer ai_table_id, long al_prac_id, long al_seq_no, integer ai_facility_id)
public function str_size of_get_facility (string as_table, long al_seq_no, datastore ads_detail)
public function integer of_update_affil_stat (integer ai_facility_new, integer ai_facility_old, long al_prac_id)
public function integer of_constract_dw ()
public function integer of_audit_error_log (integer ai_table_id, integer ai_err_type, string as_error, string as_field)
public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method, integer ai_table_id)
public subroutine of_open_processbar (integer ai_prac_count)
public function integer of_dyncreategpdw (string as_fields)
public function integer of_findgp (string as_finds, string as_fields[], string as_values[], string as_field_type[], ref long al_rec_id)
public function integer of_create_ds ()
public function integer of_create_screen_ds ()
public function integer of_set_pd_affil_stat_def (ref datastore ads_screen, ref long al_facility_id, long al_prac_id, long al_seq_no, long al_find_row, string as_new)
public function integer of_addverify (long al_seq, long al_prac_id, integer ai_screen_id, integer ai_table_id, long al_facility, string as_field_name[], string as_new, string as_audit_type, datastore ads_screen)
public function integer of_screen_update (integer ai_screen_id, long al_prac_id, integer ai_parent_facility_id, string as_field_name, string as_new, string as_audit_type, datastore ads_screen)
public function integer of_filter_prac ()
public function integer of_get_screen_ds (string as_tablename, integer ai_table_id, ref n_import_ds ads_screen)
end prototypes

public function integer of_filter_dw ();//////////////////////////////////////////////////////////////////////
// $<function> of_filter_dw
// $<arguments>
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.03.2013 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_from_date, ls_to_date
string ls_filter, ls_user
long   ll_import
string ls_sql

if dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "convert(varchar,create_date,120) >='"+ls_from_date +"'"
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and convert(varchar,create_date,120) <= '"+ls_to_date +"'"
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " convert(varchar,create_date,120) <= '"+ ls_to_date+"'"
else
	ls_filter = "1=1"
end if

ll_import = dw_import.getitemnumber(1, "import_id")
if not isnull(ll_import) then
	ls_filter = ls_filter + " and import_id = " + string(ll_import) +""
end if

ls_sql = is_original_sql + " where " + ls_filter

dw_list.setsqlselect(ls_sql)
dw_list.retrieve()

end function

public function integer of_auto_filter (str_flag astr_flag);//////////////////////////////////////////////////////////////////////
// $<function> of_auto_filter
// $<arguments>
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.03.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_import_id, ll_hdr_id, ll_row
string ls_sql, ls_filter

dw_import.enabled = false
dw_date_range.enabled =false
cb_reset.enabled =false
cb_filter.enabled =false

ll_import_id = astr_flag.l_mapid
ll_hdr_id = astr_flag.l_oriid
if isnull(ll_import_id) or isnull(ll_hdr_id) then return -1

ls_sql = dw_list.getsqlselect()

ls_sql = ls_sql + " where import_id = " +string(ll_import_id) +" and hdr_id = " +string(ll_hdr_id)
dw_list.setsqlselect(ls_sql)
dw_list.retrieve()

return 1

end function

public function integer of_filter_detail (long al_row);//////////////////////////////////////////////////////////////////////
// $<function> of_filter_detail
// $<arguments>
//              
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.03.2013
//////////////////////////////////////////////////////////////////////
long  ll_prac_id, ll_row, ll_hdr
string ls_filter

ll_row = dw_prac.rowcount()
if al_row < 1 or al_row > ll_row then
	if dw_prac.rowcount() < 1 then
		dw_detail.reset()
	end if
	return 1
end if

ll_prac_id = dw_prac.getitemnumber(al_row, "prac_id")
ls_filter = " 1 =1 "
if not isnull(ll_prac_id) then
	ls_filter = ls_filter + " and import_audit_item_prac_id = " + string(ll_prac_id)
end if
if il_status <> 9 then
	ls_filter = ls_filter + " and import_audit_item_status = " + string(il_status)
end if

dw_detail.setredraw(false)
dw_detail.setfilter(ls_filter)
dw_detail.filter()
dw_detail.setredraw(true)
return 1
end function

public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess);//////////////////////////////////////////////////////////////////////
// $<function> of_error_message
// $<arguments>
//              
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.04.2013
//////////////////////////////////////////////////////////////////////

integer res
string ls_plus

ls_plus = "~r~rData will not be saved for row " + string(ai_row) + "."

res = messagebox(as_title,as_mess + ls_plus,question!,ok!)
//if res = 1 then 
dw_detail.setitemstatus( ai_row, 0, primary!,notmodified!)
				
return 1


end function

public function long of_get_next_seq_no (string as_dw, long al_rec_id);//////////////////////////////////////////////////////////////////////
// $<function> of_get_next_seq_no
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//                       get next seq_no
//////////////////////////////////////////////////////////////////////
// $<add> 01.04.2013 by Stephen
//////////////////////////////////////////////////////////////////////
Integer li_row_cnt
Long ll_seq_no
n_ds l_ds

l_ds = CREATE n_ds

CHOOSE CASE as_dw
	CASE "department"
		l_ds.DataObject = "d_last_affill_dept_seq_no"
	CASE "staff cat"
		l_ds.DataObject = "d_last_affill_last_cat_seq_no"		
	CASE "comm review"
		l_ds.DataObject = "d_last_affill_comm_review_seq_no"			
	CASE "leave"
		l_ds.DataObject = "d_last_affill_leave"			
END CHOOSE

l_ds.SetTransObject( SQLCA )
li_row_cnt = l_ds.Retrieve( al_rec_id )
IF li_row_cnt > 0 THEN
	ll_seq_no = l_ds.GetItemNumber( 1, "last_seq_no" )
ELSE
	ll_seq_no = 0
END IF

IF IsNull( ll_seq_no ) THEN
	ll_seq_no = 1 
END IF

DESTROY l_ds

yield()
RETURN ll_seq_no

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
	//---------Begin Added by (Appeon)Stephen 12.20.2013 for Continuum Health Partners UAT testing--------
	ls_field_name = adw_detail.getitemstring(ll_row, 'import_audit_item_field_name') 
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

public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col);//////////////////////////////////////////////////////////////////////
// $<function> of_get_dddw_field
// $<arguments>
// $<returns> string
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
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

public function integer of_audit (long al_prac_id, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_audit
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row
integer li_status, li_table_id
long ll_rec
string ls_sql[]
string ls_table_name,  ls_table_name_pre, ls_opt_type
long   ll_seq_no, ll_seq_no_pre
string ls_field, ls_field_aar
string ls_value,ls_value_arr
string ls_field_type
long   ll_facility_id
integer li_return, li_find
string  ls_new
datastore lds_detail

lds_detail = create datastore
lds_detail.dataobject = adw_detail.dataobject
lds_detail.settransobject(sqlca)
adw_detail.rowscopy(1, adw_detail.rowcount(), primary!, lds_detail,1,primary!)
adw_detail.rowscopy(1,adw_detail.filteredcount(), filter!, lds_detail, lds_detail.rowcount() +1, primary!)
yield()
lds_detail.setfilter("import_audit_item_prac_id = " +string(al_prac_id))
lds_detail.filter()

// Set progress bar
if lds_detail.rowcount() < 1 then return -1
w_import_progressbar.of_auditnextstep()
	
//Basic Information
for ll_row = 1 to lds_detail.rowcount()
	li_status = lds_detail.getitemnumber(ll_row, "import_audit_item_status")
	ls_opt_type = lds_detail.getitemstring(ll_row, "opt_type")	
	if li_status = 0 and ls_opt_type = '1' then
		ls_table_name = lds_detail.getitemstring(ll_row, "sys_tables_table_name")
		if lower(ls_table_name) <> "pd_basic" then continue
		ll_seq_no = lds_detail.getitemnumber(ll_row, "import_audit_item_seq_no")
		li_table_id = lds_detail.getitemnumber(ll_row, "import_audit_item_table_id")
		// Set progress bar
		w_import_progressbar.of_setauditprocessdesc(ls_table_name)
		//audit screen data
		li_return = of_audit_screen(ls_table_name, ll_seq_no,li_table_id, lds_detail)		
		exit
	end if	
	yield()
next

//Other Screen
ls_table_name_pre = ""
ll_seq_no_pre = 0
for ll_row = 1 to lds_detail.rowcount()
	li_status = lds_detail.getitemnumber(ll_row, "import_audit_item_status")
	ls_opt_type = lds_detail.getitemstring(ll_row, "opt_type")	
			
	if li_status = 0 and ls_opt_type = '1' then
		ll_seq_no = lds_detail.getitemnumber(ll_row, "import_audit_item_seq_no")
		ls_table_name = lds_detail.getitemstring(ll_row, "sys_tables_table_name")
		li_table_id = lds_detail.getitemnumber(ll_row, "import_audit_item_table_id")
		
		if lower(ls_table_name) = "pd_basic" then continue
		select count(1) into :li_find from pd_basic where prac_id = :al_prac_id;
		if li_find < 1 then
			messagebox("Prompt", "For the new practitioner, you must save the basic information firstly.")
			return -1
		end if
	
		if ll_seq_no <> ll_seq_no_pre or ls_table_name <> ls_table_name_pre then
			ll_seq_no = lds_detail.getitemnumber(ll_row, "import_audit_item_seq_no")
			ls_table_name = lds_detail.getitemstring(ll_row, "sys_tables_table_name")
			
			// Set progress bar
			w_import_progressbar.of_setauditprocessdesc(ls_table_name)
		     //audit screen data
			li_return = of_audit_screen(ls_table_name, ll_seq_no,li_table_id, lds_detail)						
			ll_seq_no_pre = ll_seq_no
			ls_table_name_pre = ls_table_name
		end if
	end if	
	yield()
next

destroy lds_detail
return 1

end function

public function integer of_audit_screen (string as_table_name, long al_seq_no, integer ai_table_id, datastore ads_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_audit_basic
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.08.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row
integer li_status
long ll_rec, ll_facility_id, ll_facility_old, ll_facility_audit
string ls_sql
string  ls_opt_type, ls_facility_name
string ls_field, ls_field_arr
string ls_value,ls_value_old, ls_value_arr
string ls_field_type, ls_new
string    ls_field_gp[], ls_field_value_gp[], ls_field_type_gp[]
string ls_field_name[]
string  ls_audit_type
string ls_audit_sql[]
string    ls_key_field, ls_find_fields
string ls_err
integer li_screen_id
integer  li_affi_seq, li_return, li_i
integer  li_match_gp = 0
long      ll_rec_gp, ll_find, ll_screen_find
long ll_prac_id
str_size lstr_facility
datastore lds_detail
n_import_ds lds_screen, lds_affil_stat
			
lds_detail = create datastore
lds_detail.dataobject = ads_detail.dataobject
lds_detail.settransobject(sqlca)
ads_detail.rowscopy(1, ads_detail.rowcount(), primary!, lds_detail,1,primary!)
yield()
lds_detail.setfilter("sys_tables_table_name = '"+as_table_name+"' and import_audit_item_seq_no = "+string(al_seq_no))
lds_detail.filter()

gnv_appeondb.of_startqueue( )
ids_audit_item.retrieve()
SELECT top 1 screen_id INTO :li_screen_id FROM data_view_screen WHERE data_view_id = 1 AND table_id = :ai_table_id;
gnv_appeondb.of_CommitQueue( )

if ai_table_id = 25 then li_screen_id = 1

lstr_facility = of_get_facility(as_table_name, al_seq_no, lds_detail)
yield()
ll_facility_id = lstr_facility.x
ll_facility_old = lstr_facility.y
if ll_facility_id = 0 then
	ll_facility_id = lds_detail.getitemnumber(1, "import_audit_item_facility_id")
end if
if lds_detail.rowcount() < 1 then 
	destroy lds_detail
	return -1
end if

ls_new = lds_detail.getitemstring(1, "import_audit_item_new_prac")		
ll_prac_id = lds_detail.getitemnumber(1, "import_audit_item_prac_id")

//---------Begin Added by (Appeon)Stephen 2013-10-14 for Bug 3679--------
il_table_records_id = lds_detail.getitemnumber(1, "table_records_id")
if isnull(il_table_records_id) then il_table_records_id = 0
//---------End Added ------------------------------------------------------

ls_field_arr = ""
ls_value_arr = ""
ls_audit_type = lds_detail.getitemstring(1, "import_audit_item_audit_type")		
//get screen datastore
if of_get_screen_ds(as_table_name, ai_table_id, lds_screen) = -1 then return -1		

if ls_audit_type = "NW" then
	//New Practitioner
	for ll_row = 1 to lds_detail.rowcount()
		li_status = lds_detail.getitemnumber(ll_row, "import_audit_item_status")
		ls_opt_type = lds_detail.getitemstring(ll_row, "opt_type")
		if li_status = 0 and ls_opt_type = '1' then
			ls_field = lds_detail.getitemstring(ll_row, "import_audit_item_field_name")
			ls_field_type = lds_detail.getitemstring(ll_row, "sys_fields_field_type")
			ls_value = lds_detail.getitemstring(ll_row, 'import_audit_item_new_value')
			ll_rec = lds_detail.getitemnumber(ll_row, 'import_audit_item_rec_id') 
			if isnull(ls_value) then ls_value = ""
			
			//Group Practice
			if lower(as_table_name) = "pd_address" then
				if lds_detail.getitemstring(ll_row, "import_audit_item_key_field") = "Y" then
					ls_key_field = ls_key_field + ls_field +","
					ls_find_fields = ls_find_fields +" "+ ls_field +" = " 
					if ls_field_type='N' or ls_field_type='I' or ls_field_type='l' then //(Appeon)Stephen 10.10.2015 - add 'l'
						ls_find_fields = ls_find_fields +ls_value +" and"
					else
						ls_find_fields = ls_find_fields +"'" + ls_value +"'" +" and"
					end if
				end if
				ls_field_gp[upperbound(ls_field_gp)+1] = ls_field
				ls_field_value_gp[upperbound(ls_field_value_gp)+1] = ls_value
				ls_field_type_gp[upperbound(ls_field_type_gp)+1] = ls_field_type
			end if
			
			ll_find = ids_audit_item.find("rec_id = "+string(ll_rec), 1, ids_audit_item.rowcount())
			if ll_find > 0 then
				ids_audit_item.setitem(ll_find, "status", 1)
				ids_audit_item.setitem(ll_find, "audit_by", gs_user_id)
				ids_audit_item.setitem(ll_find, "audit_date", idt_CurrentTime)
			end if			
			
			choose case ls_field_type
				case 'D'
					ls_value = left(trim(ls_value), 10)
					ls_value = string(datetime(date(ls_value),time("00:00")), 'yyyy-mm-dd hh:mm')
					if isnull(ls_value) or ls_value = "1900-01-01 00:00" then
						continue
					end if
					lds_screen.setitem(1, ls_field, datetime(ls_value))
				case 'N','I', 'l'
					if not isnumber(trim(ls_value)) then continue
					lds_screen.setitem(1, ls_field, dec(ls_value))
				case else
					lds_screen.setitem(1, ls_field, ls_value)
			end choose	
			
		end if
		yield()
	next		
	ls_sql = " update import_audit_item set audit_type='EW' where import_id =" +string(il_import_id) +" and hdr_id =" +string(il_hdr_id)+&
	                                                                 " and table_id ="+string(ai_table_id) +" and seq_no = "+string(al_seq_no) 
	
	if lower(as_table_name) ="pd_affil_stat" then
		select max(seq_no) into :li_affi_seq from pd_affil_stat where prac_id =:ll_prac_id and parent_facility_id = :ll_facility_id using sqlca;
		if isnull(li_affi_seq) then li_affi_seq = 0
		li_affi_seq +=1
		lds_screen.setitem(1, "seq_no", li_affi_seq)
	end if
	
	if lower(as_table_name) = "pd_address" then
		// Check if address match gp_id
		ll_row = ids_table_record.find("isoft_table_id = 20 and address_link_set = 1", 1, ids_table_record.rowcount())
		if ll_row > 0 then
			if ids_table_record.object.lv_match_gp[ll_row] = 1 then
				if not isvalid(ids_group_practice) then
					ids_group_practice = Create n_import_ds
					of_dyncreategpdw(ls_key_field)
				end if
				li_match_gp = 1
			end if
		end if
	end if
	
	//Group Practice
	if lower(as_table_name) = "pd_address"  and isvalid(ids_group_practice) and li_match_gp = 1 then
		ids_group_practice.retrieve()
		if len(ls_find_fields) > 3 then ls_find_fields = left(ls_find_fields, len(ls_find_fields) - 3)
		if of_findgp(ls_find_fields, ls_field_gp, ls_field_value_gp, ls_field_type_gp, ll_rec_gp) = 1 then
              lds_screen.setitem(1, "gp_id", ll_rec_gp)
			if ids_group_practice_new.ModifiedCount() > 0 then
				ids_group_practice_new.update()
			end if
		end if
	end if
	////////
	
	//save data to pd_affil_stat
	if lower(as_table_name) ="pd_basic" then 
		yield()
		lds_affil_stat = create n_import_ds
		lds_affil_stat.dataobject = "d_import_ds_pd_affil_stat"
		lds_affil_stat.settransobject(sqlca)
		lds_affil_stat.insertrow(1)
		//---------Begin Added by (Appeon)Stephen 05.06.2015 for V15.1-Import Improvements 2015--------
		ids_audit_facility.setfilter("import_id = "+string(il_import_id) +" and hdr_id = " + string(il_hdr_id) + " and prac_id= " +string(ll_prac_id)+" and table_id = " +string(ai_table_id))
		ids_audit_facility.filter()
		if ids_audit_facility.rowcount() > 0 then
			for li_i = 1 to ids_audit_facility.rowcount()
				ls_facility_name = ids_audit_facility.getitemstring(li_i, "field_name")
				ll_facility_audit = long(ids_audit_facility.getitemstring(li_i, "new_value"))
				lds_affil_stat.setitem(1, ls_facility_name, ll_facility_audit)
			next
		end if
		ids_audit_facility.setfilter("")
		ids_audit_facility.filter()
		//---------End Added ------------------------------------------------------
		li_return = of_set_pd_affil_stat_def(lds_affil_stat, ll_facility_id, ll_prac_id, al_seq_no, 1, 'Y')
		if  li_return <>1 then
			is_error = "error"
			of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, lds_affil_stat.is_SQLErrText,"")
			destroy lds_detail
			destroy lds_screen
			return -1
		end if	
	elseif lower(as_table_name) ="pd_affil_stat" then
		yield()
		li_return = of_set_pd_affil_stat_def(lds_screen, ll_facility_id, ll_prac_id, al_seq_no, 1, 'N')
		if  li_return <>1 then 
			is_error = "error"
			of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, lds_affil_stat.is_SQLErrText,"")
			destroy lds_detail
			destroy lds_screen
			return -1
		end if	
	end if	
	//////////////////////
	
	lds_screen.setitem(1, "prac_id", ll_prac_id)
	lds_screen.setitem(1, "rec_id", al_seq_no)	
     lds_screen.accepttext()
	ids_audit_item.accepttext()
	
	if lds_screen.update(true, false) <> 1  then 
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE,  lds_screen.is_SQLErrText,"")
		is_error = "error"
		destroy lds_detail
		destroy lds_screen
		rollback using sqlca;
		return -1
	end if
	
	if  ids_audit_item.update(true, false)<>1 then
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE,  sqlca.SQLErrText,"")
		is_error = "error"
		destroy lds_detail
		destroy lds_screen
		rollback using sqlca;
		return -1
	end if
	
	if isvalid(lds_affil_stat) then
		if lds_affil_stat.update(true,false) <> 1 then
			of_audit_error_log(43, IL_ERRTYPE_UPDATE, lds_affil_stat.is_SQLErrText,"")
			is_error = "error"
			destroy lds_detail
			rollback using sqlca;
			return -1
		end if
	end if
	
	EXECUTE IMMEDIATE :ls_sql;
	if sqlca.sqlcode <> 0 then 
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, sqlca.sqlerrtext,"")
		is_error = "error"
		destroy lds_detail
		destroy lds_screen
		rollback using sqlca;
		return -1
	end if
	yield()
	commit using sqlca;
	
	if isvalid(lds_affil_stat) then destroy lds_affil_stat
else
	//modify Practitioner
	lds_screen.retrieve()
	lds_screen.setfilter("rec_id = "+string(al_seq_no))
	lds_screen.filter()
	ll_screen_find = lds_screen.rowcount()
	
	if ll_screen_find < 1 then 
		is_error = "error"
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, "Update failed, the matched record wasn’t found in the screen!","")
		destroy lds_screen
		return -1
	end if
	
	for ll_row = 1 to lds_detail.rowcount()
		li_status = lds_detail.getitemnumber(ll_row, "import_audit_item_status")
		ls_opt_type = lds_detail.getitemstring(ll_row, "opt_type")
		if li_status = 0 and ls_opt_type = '1' then
			ls_field = lds_detail.getitemstring(ll_row, "import_audit_item_field_name")
			ls_value = lds_detail.getitemstring(ll_row, 'import_audit_item_new_value')
			ls_value_old = lds_detail.getitemstring(ll_row, 'import_audit_item_old_value')
			ls_field_type = lds_detail.getitemstring(ll_row, "sys_fields_field_type")
			ll_rec = lds_detail.getitemnumber(ll_row, 'import_audit_item_rec_id') 
			
			ll_find = ids_audit_item.find("rec_id = "+string(ll_rec), 1, ids_audit_item.rowcount())
			if ll_find > 0 then
				ids_audit_item.setitem(ll_find, "status", 1)
				ids_audit_item.setitem(ll_find, "audit_by", gs_user_id)
				ids_audit_item.setitem(ll_find, "audit_date", idt_CurrentTime)
			end if
			
			if isnull(ls_value) then ls_value = ""
			if ls_value_old = ls_value then continue
			
			choose case ls_field_type
				case 'D'
					ls_value = left(trim(ls_value), 10)
					ls_value = string(datetime(date(ls_value),time("00:00")), 'yyyy-mm-dd hh:mm')
					if isnull(ls_value) or ls_value = "1900-01-01 00:00" then
						continue
					end if
					lds_screen.setitem(ll_screen_find, ls_field, datetime(ls_value))
				case 'N','I', 'l'
					if not isnumber(trim(ls_value)) then continue
					lds_screen.setitem(ll_screen_find, ls_field, dec(ls_value))
				case else
					lds_screen.setitem(ll_screen_find, ls_field, ls_value)
			end choose
		end if	
		yield()
	next
	
	//save data to pd_affil_stat
	if lower(as_table_name) = "pd_affil_stat" then
		yield()
		li_return = of_set_pd_affil_stat_def(lds_screen, ll_facility_id, ll_prac_id, al_seq_no, ll_screen_find, 'N') 
		if li_return <>1 then
			is_error = "error"
			destroy lds_screen
			return -1
		end if
	end if
	
	ids_audit_item.accepttext()
	lds_screen.accepttext()
	if lds_screen.update(true, false) <> 1 then
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, lds_screen.is_SQLErrText,"")
		is_error = "error"
		destroy lds_screen
		destroy lds_detail
		rollback using sqlca;
		return -1
	end if
	
	if  ids_audit_item.update(true, false)<>1 then
		of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, sqlca.SQLErrText,"")
		is_error = "error"
		destroy lds_screen
		destroy lds_detail
		rollback using sqlca;
		return -1
	end if
	
	commit using sqlca;
end if

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.30.2013
//$<reason> 12.3 Import testing --add Audit Trail records
if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if
inv_data_entry.of_field_audit(lds_screen, ls_err)
//------------------- APPEON END -------------------

yield()
if lower(as_table_name) <> "pd_affil_stat" then
	if of_addverify(al_seq_no, ll_prac_id, li_screen_id, ai_table_id, ll_facility_id, ls_field_name, ls_new, ls_audit_type, lds_screen) = -1 then 
		destroy lds_detail
		destroy lds_screen
		is_error = "error"
		return -1
	end if
end if

if isvalid(lds_screen) then destroy lds_screen
if isvalid(lds_detail) then destroy lds_detail

// Set progress bar
w_import_progressbar.of_auditnextstep()
//add screen link
if ls_audit_type = "NW" then
	yield()
	if of_update_links(ai_table_id, ll_prac_id, al_seq_no, ll_facility_id) = -1 then
		is_error = "error"
		return -1
	end if	
elseif ai_table_id = 43 and ll_facility_old <> ll_facility_id then
	yield()
	if of_update_affil_stat(ll_facility_id, ll_facility_old, ll_prac_id) = -1 then
		is_error = "error"
		return -1
	end if
		
	//add link
	yield()
	if of_update_links(ai_table_id, ll_prac_id, al_seq_no, ll_facility_id) = -1 then
		is_error = "error"
		return -1
	end if
end if
yield()
	
return 1

end function

public function integer of_update_address_link (long al_prac_id, long al_address_id, integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_address_link
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.10.2013 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_cnt, li_nr
integer li_data
long  ll_Row

//---------Begin Added by (Appeon)Stephen 04.07.2015 for Import Audit Trail Issue--------
select count(1) into :li_cnt from pd_address_link where prac_id = :al_prac_id and address_id = :al_address_id and facility_id = :ai_facility_id;
if li_cnt > 0 then return 1
//---------End Added ------------------------------------------------------

dw_link_list.dataobject = "d_addr_link_check_boxes"
dw_link_list.settransobject(sqlca)

//---------Begin Modified by (Appeon)Stephen 2013-10-14 for Bug 3679--------
//ll_row = ids_table_record.find("isoft_table_id = 20 and address_link_set = 1", 1, ids_table_record.rowcount())
ll_row = ids_table_record.find("isoft_table_id = 20 and address_link_set = 1 and records_id = "+string(il_table_records_id)+"", 1, ids_table_record.rowcount())
//---------End Modfiied ------------------------------------------------------


li_nr = dw_link_list.InsertRow( 0 )
dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
dw_link_list.SetItem( li_nr, "address_id", al_address_id )
dw_link_list.SetItem( li_nr, "facility_id", ai_facility_id )

if ll_row > 0 then 
	//---------Begin Modified by (Appeon)Stephen 2013-09-26 for Issue with an Import -bug 3769--------
	/*
	dw_link_list.SetItem( li_nr, "billing", ids_table_record.object.lv_billing[ll_Row])
	dw_link_list.SetItem( li_nr, "mailing", ids_table_record.object.lv_mailing[ll_Row])
	dw_link_list.SetItem( li_nr, "home_address", ids_table_record.object.lv_home_address[ll_Row])
	dw_link_list.SetItem( li_nr, "primary_office", ids_table_record.object.lv_primary_office[ll_Row])
	dw_link_list.SetItem( li_nr, "additional_office", ids_table_record.object.lv_additional_office[ll_Row])
	dw_link_list.SetItem( li_nr, "include_in_directory", ids_table_record.object.lv_include_in_directory[ll_Row])
	dw_link_list.SetItem( li_nr, "exp_letters", ids_table_record.object.lv_exp_letters[ll_Row])
	*/
	li_data = 0
	if not isnull(ids_table_record.object.lv_billing[ll_Row]) then li_data = ids_table_record.object.lv_billing[ll_Row]
	dw_link_list.SetItem( li_nr, "billing", li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_mailing[ll_Row]) then li_data = ids_table_record.object.lv_mailing[ll_Row]
	dw_link_list.SetItem( li_nr, "mailing", li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_home_address[ll_Row]) then li_data = ids_table_record.object.lv_home_address[ll_Row]
	dw_link_list.SetItem( li_nr, "home_address", li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_primary_office[ll_Row]) then li_data = ids_table_record.object.lv_primary_office[ll_Row] 
	dw_link_list.SetItem( li_nr, "primary_office",li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_additional_office[ll_Row]) then li_data =  ids_table_record.object.lv_additional_office[ll_Row]
	dw_link_list.SetItem( li_nr, "additional_office", li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_include_in_directory[ll_Row]) then li_data = ids_table_record.object.lv_include_in_directory[ll_Row]
	dw_link_list.SetItem( li_nr, "include_in_directory", li_data)
	li_data = 0
	if not isnull(ids_table_record.object.lv_exp_letters[ll_Row]) then li_data = ids_table_record.object.lv_exp_letters[ll_Row]
	dw_link_list.SetItem( li_nr, "exp_letters", li_data)
	//---------End Modfiied ------------------------------------------------------
else
	dw_link_list.SetItem( li_nr, "mailing", 0 )
	dw_link_list.SetItem( li_nr, "billing", 0 )
	dw_link_list.SetItem( li_nr, "home_address", 0 )
	dw_link_list.SetItem( li_nr, "primary_office", 0 )
	dw_link_list.SetItem( li_nr, "additional_office", 0 )
	dw_link_list.SetItem( li_nr, "include_in_directory", 0 )
	dw_link_list.SetItem( li_nr, "exp_letters", 0 )
end if
yield()
if dw_link_list.Update() <> 1 then 
	is_error = "error"
	of_audit_error_log(20, IL_ERRTYPE_UPDATE, sqlca.sqlerrtext,"address link")
	return -1
end if

return 1
end function

public function integer of_update_hosp_link (long al_prac_id, long al_seq_no, integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_hosp_link
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.10.2013 by Stephen
//////////////////////////////////////////////////////////////////////

Integer i
Integer li_nr
long     ll_row

//---------Begin Added by (Appeon)Stephen 04.07.2015 for Import Audit Trail Issue--------
select count(1) into :i from pd_hosp_facility_link where prac_id = :al_prac_id and hosp_affil_id = :al_seq_no and facility_id = :ai_facility_id;
if i > 0 then return 1
//---------End Added ------------------------------------------------------

dw_link_list.DataObject = "d_hf_link"
dw_link_list.setTransObject( SQLCA )

//---------Begin Modified by (Appeon)Stephen 2013-10-14 for Bug 3679--------
//ll_row = ids_table_record.find("isoft_table_id = 9 and hosp_facility_link_set = 1 ", 1, ids_table_record.rowcount())
ll_row = ids_table_record.find("isoft_table_id = 9 and hosp_facility_link_set = 1 and records_id = "+string(il_table_records_id)+"", 1, ids_table_record.rowcount())
//---------End Modfiied ------------------------------------------------------

li_nr = dw_link_list.InsertRow( 0 )	
dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
dw_link_list.SetItem( li_nr, "hosp_affil_id", al_seq_no )
if ll_row > 0 then
	dw_link_list.SetItem(li_nr, "primary_hosp", ids_table_record.object.lv_primary_hosp[ll_Row])
else
	dw_link_list.SetItem( li_nr, "primary_hosp", 582)	
end if
dw_link_list.SetItem( li_nr, "facility_id", ai_facility_id )

if dw_link_list.Update() <> 1 then 
	is_error = "error"
	of_audit_error_log(9, IL_ERRTYPE_UPDATE, sqlca.sqlerrtext,"Hospital Affiliation link")
	return -1
end if

Return 1
end function

public function integer of_update_spec_link (long al_prac_id, long al_seq_no, integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_spec_link
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.04.2013 by Stephen
//////////////////////////////////////////////////////////////////////

Integer i
Integer li_nr
long     ll_row

//---------Begin Added by (Appeon)Stephen 04.07.2015 for Import Audit Trail Issue--------
select count(1) into :i from pd_spec_facility_link where prac_id = :al_prac_id and specialty_id = :al_seq_no and facility_id = :ai_facility_id;
if i > 0 then return 1
//---------End Added ------------------------------------------------------

dw_link_list.DataObject = "d_sf_link"
dw_link_list.setTransObject( SQLCA )
//---------Begin Modified by (Appeon)Stephen 2013-10-14 for Bug 3679--------
//ll_row = ids_table_record.find("isoft_table_id = 2 and spec_facility_link_set = 1", 1, ids_table_record.rowcount())
ll_row = ids_table_record.find("isoft_table_id = 2 and spec_facility_link_set = 1 and records_id = "+string(il_table_records_id)+"", 1, ids_table_record.rowcount())
//---------End Modfiied ------------------------------------------------------

li_nr = dw_link_list.InsertRow( 0 )	
dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
dw_link_list.SetItem( li_nr, "specialty_id", al_seq_no )
if ll_row > 0 then
	dw_link_list.SetItem(li_nr, "practicing", ids_table_record.object.lv_practicing[ll_Row])
else
	dw_link_list.SetItem( li_nr, "practicing", 581)	
end if
dw_link_list.SetItem( li_nr, "facility_id", ai_facility_id )

if dw_link_list.Update() <> 1 then 
	is_error = "error"
	of_audit_error_log(2, IL_ERRTYPE_UPDATE, sqlca.sqlerrtext,"Board/Specialty link")
	return -1
end if

yield()
Return 1
end function

public function integer of_update_links (integer ai_table_id, long al_prac_id, long al_seq_no, integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_links
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2013 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_row_cnt, li_return
n_ds lds_parent_facilities
integer li_facility, li_cnt
long  ll_rec_id

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( al_prac_id )
ids_address.setfilter("")
ids_address.filter()
ids_address.setfilter("prac_id = "+string(al_prac_id))
ids_address.filter()

ids_hosp_facility.setfilter("")
ids_hosp_facility.filter()
ids_hosp_facility.setfilter("prac_id = "+string(al_prac_id))
ids_hosp_facility.filter()

ids_spec_facility.setfilter("")
ids_spec_facility.filter()
ids_spec_facility.setfilter("prac_id = "+string(al_prac_id))
ids_spec_facility.filter()

choose case ai_table_id
	case 20  //Address
		for li_cnt = 1 to lds_parent_facilities.rowcount()
			li_facility = lds_parent_facilities.GetItemNumber( li_cnt, "parent_facility_id" )
			li_return = of_update_address_link( al_prac_id, al_seq_no, li_facility) 
			if li_return = -1 then exit
			yield()
		next
	case 9  //Hospital Affiliation
		for li_cnt = 1 to lds_parent_facilities.rowcount()
			li_facility = lds_parent_facilities.GetItemNumber( li_cnt, "parent_facility_id" )
			li_return = of_update_hosp_link(al_prac_id, al_seq_no, li_facility) 
			if li_return = -1 then exit
			yield()
		next
	case 2  //Board/Specialty
		for li_cnt = 1 to lds_parent_facilities.rowcount()
			li_facility = lds_parent_facilities.GetItemNumber( li_cnt, "parent_facility_id" )
			li_return = of_update_spec_link(al_prac_id, al_seq_no, li_facility) 
			if li_return = -1 then exit
			yield()
		next
	case 43  //Affiliation Status
		//address
		for li_cnt = 1 to ids_address.rowcount()
			ll_rec_id = ids_address.getitemnumber(li_cnt, "rec_id")
			li_return = of_update_address_link( al_prac_id, ll_rec_id, ai_facility_id) 
			if li_return = -1 then exit
			yield()
		next
		//Hospital Affiliation
		for li_cnt = 1 to ids_hosp_facility.rowcount()
			ll_rec_id = ids_hosp_facility.getitemnumber(li_cnt, "rec_id")
			li_return = of_update_hosp_link( al_prac_id, ll_rec_id, ai_facility_id) 
			if li_return = -1 then exit
			yield()
		next
		 //Board/Specialty
		for li_cnt = 1 to ids_spec_facility.rowcount()
			ll_rec_id = ids_spec_facility.getitemnumber(li_cnt, "rec_id")
			li_return = of_update_spec_link( al_prac_id, ll_rec_id, ai_facility_id) 
			if li_return = -1 then exit
			yield()
		next
		
end choose
yield()

destroy lds_parent_facilities
return li_return
end function

public function str_size of_get_facility (string as_table, long al_seq_no, datastore ads_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_get_facility
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.08.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row, ll_facility_id
string ls_field
string ls_value
str_size lstr_facility

lstr_facility.x = 0
lstr_facility.y = 0
for ll_row = 1 to ads_detail.rowcount()
	ls_field = ads_detail.getitemstring(ll_row, "import_audit_item_field_name")
	ls_value = ads_detail.getitemstring(ll_row, 'import_audit_item_new_value')
	if lower(ls_field) = "facility_id" or  lower(ls_field)  = "parent_facility_id"  then
		if not isnumber(trim(ls_value)) then ls_value = '0'
		ll_facility_id = long(ls_value)
		lstr_facility.x = ll_facility_id
		if as_table = "pd_affil_stat" then
			ls_value = ads_detail.getitemstring(ll_row, 'import_audit_item_old_value')
			if not isnumber(trim(ls_value)) then ls_value = '0'
			lstr_facility.y = long(ls_value)
		end if
		return lstr_facility
	end if
next

return lstr_facility

end function

public function integer of_update_affil_stat (integer ai_facility_new, integer ai_facility_old, long al_prac_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_affil_stat
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2013 by Stephen
//////////////////////////////////////////////////////////////////////

gnv_appeondb.of_startqueue( )
//Address
DELETE FROM pd_address_link  WHERE facility_id = :ai_facility_old AND	prac_id	= :al_prac_id;
//Hospital Affiliation
DELETE FROM pd_hosp_facility_link  WHERE facility_id = :ai_facility_old AND prac_id	= :al_prac_id;		
//Board/Specialty
DELETE FROM pd_spec_facility_link  WHERE facility_id = :ai_facility_old AND prac_id	= :al_prac_id;		

update pd_questions set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_committee set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_contingency_fs set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_other_data set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_notes set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_rank set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_admin_role set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update pd_group_providers set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update net_dev_action_items set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;
update net_dev_ids set facility_id = :ai_facility_new where prac_id = :al_prac_id and facility_id = :ai_facility_old;

update verif_info 
set facility_id = :ai_facility_new, 
direct_parent_facility_link = :ai_facility_new,
doc_id = convert(varchar,rec_id) + "-" + convert(varchar,prac_id) + "-" + convert(varchar,:ai_facility_new) + "-" + convert(varchar,seq_no) 
where prac_id = :al_prac_id and facility_id = :ai_facility_old and screen_id = 1 and active_status = 1;

commit using sqlca;
gnv_appeondb.of_commitqueue( )	
yield()
return 1
end function

public function integer of_constract_dw ();//////////////////////////////////////////////////////////////////////
// $<Function> of_dddw_field
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
//////////////////////////////////////////////////////////////////////

ids_address_lookup = create datastore
ids_code_lookup = create datastore
ids_facility = create datastore
ids_active_status = create datastore
ids_question = create datastore
ids_qa_metrics = create datastore
ids_committee = create datastore

ids_address_lookup.DataObject = "d_import_ds_lu_address"
ids_code_lookup.DataObject = "d_import_ds_lu_code"
ids_facility.DataObject = "d_import_ds_lu_facility"
ids_active_status.DataObject = "d_import_ds_lu_activestatus"
ids_question.dataobject = "d_g_quest_lookup"
ids_committee.DataObject = "d_import_ds_lu_committee"
ids_qa_metrics.DataObject = "d_import_ds_lu_metrics"

ids_address_lookup.settransobject(sqlca)
ids_code_lookup.settransobject(sqlca)
ids_facility.settransobject(sqlca)
ids_active_status.settransobject(sqlca)
ids_question.settransobject(sqlca)
ids_committee.settransobject(sqlca)
ids_qa_metrics.settransobject(sqlca)

ids_audit_log_table = create n_import_ds
ids_log_error = create n_import_ds
ids_audit_log_table.dataobject = "d_import_ds_logtable_audit"
ids_log_error.dataobject = "d_import_ds_logerror"
ids_audit_log_table.settransobject(sqlca)  
ids_log_error.settransobject(sqlca)  

//get table link data
ids_address = Create n_import_ds
ids_hosp_facility = Create n_import_ds
ids_spec_facility = Create n_import_ds
ids_audit_facility = create datastore

ids_address.DataObject = "d_import_ds_pd_address"
ids_hosp_facility.DataObject = "d_import_ds_pd_hosp_affil"
ids_spec_facility.DataObject = "d_import_ds_pd_board_specialty"
ids_audit_facility.dataobject = "d_import_audit_facility"

ids_address.SetTransObject(SQLCA)
ids_hosp_facility.SetTransObject(SQLCA)
ids_spec_facility.SetTransObject(SQLCA)
ids_audit_facility.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
ids_address.Retrieve()
ids_hosp_facility.Retrieve()
ids_spec_facility.Retrieve()
gnv_appeondb.of_CommitQueue()

// Group Practice datastore(use in match gp_id)
ids_group_practice_new = Create n_import_ds
ids_group_practice_new.DataObject = "d_import_ds_group_practice_new"
ids_group_practice_new.settransobject(sqlca)

ids_prac_change = create datastore
ids_prac_change.dataobject = "d_import_audit_change"
ids_prac_change.settransobject(sqlca)
return 1
end function

public function integer of_audit_error_log (integer ai_table_id, integer ai_err_type, string as_error, string as_field);//////////////////////////////////////////////////////////////////////
// $<Event> of_audit_error_log
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2013 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_find, ll_Count, ll_row
long ll_process_table_id, ll_process_id

ll_find = ids_audit_log_table.find("table_id ="+string(ai_table_id), 1, ids_audit_log_table.rowcount())
if ll_find > 0 then
	ll_Count = ids_audit_log_table.object.error_count[ll_find] + 1
	ids_audit_log_table.object.error_count[ll_find] = ll_Count
	ll_process_table_id = ids_audit_log_table.getitemnumber(ll_find, "process_tables_id")
	ll_process_id = ids_audit_log_table.getitemnumber(ll_find, "process_id") 
	ll_row = ids_log_error.insertrow(0)
	ids_log_error.setitem(ll_row, "process_id", ll_process_id)
	ids_log_error.setitem(ll_row, "process_tables_id", ll_process_table_id)
	ids_log_error.setitem(ll_row, "error_field", as_field)
	ids_log_error.setitem(ll_row, "err_type", ai_err_type)
	ids_log_error.setitem(ll_row, "err_value", as_error)	
end if
yield()
return 1
end function

public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method, integer ai_table_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_add_verif_info
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.09.2013 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_nr
Integer li_nr2 
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
Integer ll_hc_code
Integer li_rsp_rc
Integer li_facility_id
Integer li_priority
Integer li_ver_priority
integer li_dupe_check 
integer resp 
integer li_parent_id 
integer li_date_check 
integer li_fac_ids
integer pc
integer pi
integer li_end_year
integer li_end_month
integer li_end_day
integer li_check_back_years
integer li_prime_check
integer li_isprime 
integer li_complete 
Long ll_seq_no
Long ll_default_verif_method
long ll_comp_method 
String ls_identifying_number
string ls_facility_name
String ls_doc_id
String ls_priority_user
String ls_ver_priority_user
string ls_primary_check 
string ls_screen_name 
string ls_appt_type = "R" 
string ls_verif_data 
datetime ld_verifdate 
datetime ld_dr 
date ld_hosp_check_date
date ld_data_check_date
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code
n_ds lds_parent_facilities
n_ds lds_verif_facilities
Long ll_i
Long li_facility_id_arr[],al_prac_id_arr[],al_rec_id_arr[]
datastore lds_facility
n_ds lds_detail

IF al_address_lookup_code = 0 THEN
	SetNull( al_address_lookup_code )
END IF

ls_identifying_number = MidA( as_reference, PosA( as_reference, "-") + 2, 100 )

if al_screen_id = 1 then
	return 1
end if

lds_verif_facilities = CREATE n_ds
lds_verif_facilities.DataObject = "d_verifying_orgs_facilities_of_pract"
lds_verif_facilities.of_SetTransObject( SQLCA )

li_rc = lds_verif_facilities.Retrieve( al_prac_id,al_screen_id )
lds_verif_facilities.setsort("verifying_facility A")
lds_verif_facilities.sort()

IF li_rc = 0 THEN			
	destroy lds_verif_facilities
	of_audit_error_log(ai_table_id, IL_ERRTYPE_VERIFYVALUE,  "Error adding verification. No active affiliation status records found(prac_id="+string(al_prac_id)+")", "") 
	is_error = "error"
	Return -1
END IF

i = lds_verif_facilities.Find("upper(verify_data) <> 'N' OR Isnull(verify_data)" ,1 ,li_rc)
If	Isnull(i) Or i <= 0 Then 
	destroy lds_verif_facilities
	//	of_audit_error_log()    //add audit_log
	Return 1
end if
lds_detail = CREATE n_ds
lds_detail.DataObject = 'd_ver_summary_record_view'
lds_detail.of_SetTransObject( SQLCA )

lds_dfl_rsp_code = CREATE n_ds
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.of_SetTransObject( SQLCA )

lds_ver_orgs_facilities = CREATE n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_forpt"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_verifying_parents_of_vers_forpt"
lds_parent_facilities.of_SetTransObject( SQLCA )

lds_last_verif_seq_no = CREATE n_ds
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt_pract"
lds_last_verif_seq_no.of_SetTransObject( SQLCA )

FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	li_facility_id_arr[i] = li_facility_id
END FOR

al_prac_id_arr[1] = al_prac_id
al_rec_id_arr[1] = al_rec_id

gnv_appeondb.of_startqueue( )

lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )
lds_parent_facilities.retrieve(li_facility_id_arr[],al_prac_id_arr[])
lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, al_screen_id )
lds_ver_orgs_facilities.Retrieve( li_facility_id_arr[], al_prac_id, al_screen_id )

if as_add_type <> "A" then 
	if al_screen_id = 10 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_hosp_affil
		where rec_id = :al_rec_id;
	end if
	if al_screen_id = 7 or al_screen_id = 6 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_training
		where rec_id = :al_rec_id;
	end if
end if

If al_screen_id = 10 Then
	Datastore lds_facility_ver_rules
	lds_facility_ver_rules = create datastore
	lds_facility_ver_rules.dataobject = "d_facility_ver_rules_forpt"
	lds_facility_ver_rules.Settransobject( SQLCA )
	lds_facility_ver_rules.Retrieve( li_facility_id_arr[] )
End If

lds_facility = create datastore
lds_facility.dataobject = "d_facility_forpt"
lds_facility.Settransobject( SQLCA )
lds_facility.Retrieve( li_facility_id_arr[] )

gnv_appeondb.of_commitqueue( )

li_rsp_rc = lds_dfl_rsp_code.Rowcount( )

If al_screen_id = 10 then
	Long li_parent_id_arr[]
	pc = lds_parent_facilities.Rowcount( )
	for pi = 1 to pc
		li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )
		li_parent_id_arr[pi] = li_parent_id
	next
	
	Datastore lds_pd_hosp_facility_link
	lds_pd_hosp_facility_link = create datastore
	lds_pd_hosp_facility_link.dataobject = "d_pd_hosp_facility_link_forpt"
	lds_pd_hosp_facility_link.Settransobject( SQLCA )
	lds_pd_hosp_facility_link.Retrieve( al_rec_id , li_parent_id_arr[] )
End If

Integer li_facility_id_first = -1

FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_date_check = 0
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	ls_facility_name = lds_verif_facilities.GetItemstring( i, "facility_name" )
	ls_verif_data = lds_verif_facilities.GetItemstring( i, "verify_data" )
	li_complete = lds_verif_facilities.GetItemNumber( i, "compl_at_create" )
	ll_comp_method = lds_verif_facilities.GetItemNumber( i, "compl_default" )
	if isnull(ll_comp_method) then ll_comp_method = 0
	if li_complete = 1 and ll_comp_method > 0 then
		al_complete_response = ll_comp_method
	end if
	if ls_verif_data = "N" then continue
	if isnull(ls_verif_data) then continue

	lds_parent_facilities.SetFilter("verifying_facility = "+string(li_facility_id) )	
	lds_parent_facilities.Filter( )
	pc = lds_parent_facilities.Rowcount( )

	if pc < 1 then messagebox("Error","No retrieval on parents of verif facility")
		ls_appt_type = "R"
	for pi = 1 to pc
		if ls_appt_type = "R" and lds_parent_facilities.GetItemstring( pi, "apptmnt_type" )  = "I" then
			ls_appt_type = "I"
		end if

		ld_verifdate = lds_parent_facilities.GetItemdatetime( pi, "date_verif_completed" )
		if not(isnull(ld_verifdate)) then
			li_date_check = 1
		end if
	next

	if ls_verif_data = "I" and ls_appt_type = "R" then continue
	
//	if li_date_check = 1 then
//		resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + ". Do you want to add the verification item.",question!,yesno!,2)
//		if resp = 2 then continue
//	end if
	
	lds_ver_orgs_facilities.SetFilter("verifying_facility = " + String(li_facility_id) ) 
	lds_ver_orgs_facilities.Filter()
	r = lds_ver_orgs_facilities.Rowcount( )

	if r < 1 then continue
	IF lds_ver_orgs_facilities.GetItemString( r, "verify_data" ) = "N" AND as_add_type = "A" THEN
		CONTINUE
	END IF
	if al_screen_id = 10 or al_screen_id = 7 or al_screen_id = 6 then 
		li_check_back_years = lds_ver_orgs_facilities.GetItemNumber(r,"check_back_years")
		if lds_ver_orgs_facilities.GetItemstring(r,"apptmnt_type") = "R" and li_check_back_years  > 0 then
			if as_add_type = "A" then
				li_end_year = as_end_year
				li_end_month = as_end_month
			end if
			if not(isnull(li_end_year)) or li_end_year = 0  then
				if not(isnull(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))) then
					if isnull(li_end_month) or li_end_month  = 0 then li_end_month = 12 
					choose case li_end_month
						case 2
							li_end_day = 28
						case 4,6,9,11
							li_end_day = 30
						case else
							li_end_day = 31
					end choose
					ld_hosp_check_date = date(li_end_year,li_end_month, li_end_day)
					ld_data_check_date = date(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))
					if relativedate(ld_hosp_check_date,li_check_back_years * 365) < ld_data_check_date then continue	
				end if
			end if
		end if
	end if
	if al_screen_id = 10 then
		ls_primary_check = ""
		ll_i = lds_facility_ver_rules.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility_ver_rules.Rowcount())
		If ll_i > 0 Then ls_primary_check = lds_facility_ver_rules.GetItemString(ll_i,"exp_reminder_doc")
		
		if ls_primary_check = "Y" then
			li_isprime = 0
			for pi = 1 to pc  
				li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )
				li_prime_check = 0
				ll_i = lds_pd_hosp_facility_link.Find("facility_id = " + String(li_parent_id), 1 , lds_pd_hosp_facility_link.Rowcount() )
				If ll_i > 0 Then li_prime_check = lds_pd_hosp_facility_link.Getitemnumber(ll_i , "primary_hosp")
				
				if li_prime_check = 581 then li_isprime = 1
			next
			if li_isprime = 0 then continue
		end if
	end if

	if al_method = -1 then
		ll_default_verif_method = lds_ver_orgs_facilities.GetItemNumbeR( r, "default_verif_means" )	
	else
		ll_default_verif_method = al_method
	end if

	li_nr = lds_detail.InsertRow( 0 )
	ls_priority_user = lds_ver_orgs_facilities.GetItemString( r, "priority_user" )	

	if isnull(ls_priority_user ) or LenA(ls_priority_user ) < 1 then ls_priority_user = "PUBLIC" 
	li_priority = lds_ver_orgs_facilities.GetItemNumber( r, "priority" )
	li_ver_priority = lds_ver_orgs_facilities.GetItemNumber( r, "facility_ver_rules_priority" )
	ls_ver_priority_user = lds_ver_orgs_facilities.GetItemString( r, "facility_ver_rules_priority_user")
	if isnull(ls_ver_priority_user ) or LenA(ls_ver_priority_user ) < 1 then
	else
		ls_priority_user = ls_ver_priority_user
	end if
	
	if isnull(li_ver_priority) or li_ver_priority  < 1 then
	else
		li_priority = li_ver_priority
	end if
	
	lds_detail.SetItem( li_nr, "prac_id", al_prac_id )
	lds_detail.SetItem( li_nr, "rec_id", al_rec_id )
	lds_detail.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
	lds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	lds_detail.SetItem( li_nr, "priority", li_priority )
	lds_detail.SetItem( li_nr, "number_sent", 0 )
	lds_detail.SetItem( li_nr, "exp_credential_flag", 0)
	lds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )	
	lds_detail.SetItem( li_nr, "verif_info_data_status", ai_data_status )
	
	IF al_complete_response > 0 THEN 
		  lds_detail.SetItem( li_nr, "response_code", al_complete_response )		
		  ld_dr = DateTime( Today(), Now() )
		  lds_detail.SetItem( li_nr, "date_recieved", ld_dr )					  
		  lds_detail.SetItem( li_nr, "user_name", gs_user_id )
		  if ai_data_status = 2 then lds_detail.SetItem( li_nr, "exp_credential_flag", 2) 
	END IF	

	if li_facility_id_first = li_facility_id then 
		ll_seq_no++
	else
		lds_last_verif_seq_no.SetFilter("facility_id = "+string(li_facility_id) )
		lds_last_verif_seq_no.Filter( )
		li_row_cnt = lds_last_verif_seq_no.Rowcount( )
	
		IF li_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		if isnull(ll_seq_no) then 	ll_seq_no = 1	
		li_facility_id_first = li_facility_id
	end if
	lds_detail.SetItem( li_nr, "seq_no", ll_seq_no )
		
	lds_detail.SetItem( li_nr, "screen_id", al_screen_id )
	lds_detail.SetItem( li_nr, "reference_value",MidA(as_reference,1,100)) 
	lds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	lds_detail.SetItem( li_nr, "screen_name", as_screen_name )
	lds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
	lds_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	
	lds_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	lds_detail.SetItem(li_nr, 'create_user', gs_user_id)

	li_dupe_check = 0
	ll_i = lds_facility.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility.Rowcount())
	If ll_i > 0 Then li_dupe_check = lds_facility.GetItemNumber(ll_i,"dupeset")
	if li_dupe_check = 1 then
		if al_screen_id = 7 or al_screen_id = 10 then
			ls_appt_type = lds_ver_orgs_facilities.GetItemString( 1, "apptmnt_type" )
			if ls_appt_type = "I" then
				li_nr2 = lds_detail.InsertRow( 0 )
				lds_detail.SetItem( li_nr2, "prac_id", al_prac_id )
				lds_detail.SetItem( li_nr2, "rec_id", al_rec_id )
				lds_detail.SetItem( li_nr2, "verif_info_facility_id", li_facility_id )
				lds_detail.SetItem( li_nr2, "priority_user", ls_priority_user )
				lds_detail.SetItem( li_nr2, "priority", li_priority )
				lds_detail.SetItem( li_nr2, "number_sent", 0 )
				lds_detail.SetItem( li_nr2, "exp_credential_flag", 0)
				IF li_rsp_rc = 1 THEN
					lds_detail.SetItem( li_nr2, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
					lds_detail.SetItem( li_nr2, "user_name", ls_priority_user )
					lds_detail.SetItem( li_nr2, "date_recieved", Today() )
					lds_detail.SetItem( li_nr2, "verification_method", ll_hc_code )				
				ELSE
					lds_detail.SetItem( li_nr2, "verification_method", ll_default_verif_method )		
				END IF
	
				ll_seq_no++	
				lds_detail.SetItem( li_nr2, "seq_no", ll_seq_no )
				lds_detail.SetItem( li_nr2, "screen_id", al_screen_id )
				lds_detail.SetItem( li_nr2, "reference_value", as_reference )
				lds_detail.SetItem( li_nr2, "expiration_date", adt_exp_date )
				ls_screen_name = as_screen_name + "_CC" 
				lds_detail.SetItem( li_nr2, "screen_name", ls_screen_name )
				lds_detail.SetItem( li_nr2, "verification_id", 2 )
				lds_detail.SetItem( li_nr2, "address_lookup_code", al_address_lookup_code )
				ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
				lds_detail.SetItem( li_nr2, "doc_id", ls_doc_id )
			end if
		end if
	end if	
	yield()
END FOR

DESTROY lds_ver_orgs_facilities
DESTROY lds_parent_facilities
DESTROY lds_verif_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

if IsValid(lds_pd_hosp_facility_link) then Destroy lds_pd_hosp_facility_link

If lds_detail.ModifiedCount( ) > 0 Then
	resp = lds_detail.Update()
	if resp < 1 then  
		is_error = "error"
		of_audit_error_log(ai_table_id, IL_ERRTYPE_VERIFYVALUE,  "Error adding verification", "") 
	end if
End If
Destroy lds_detail 

RETURN 1


end function

public subroutine of_open_processbar (integer ai_prac_count);//////////////////////////////////////////////////////////////////////
// $<Function> of_open_processbar
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.16.2013 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_row
integer li_pic_flag[4]

//Initialize progress bar
if IsValid(w_import_progressbar) then Close(w_import_progressbar)
Open(w_import_progressbar)
w_import_progressbar.title = "Auditing..."
w_import_progressbar.cb_break.visible = true

w_import_progressbar.of_SetImportID(il_import_id)
w_import_progressbar.of_SetpracCount(ai_prac_count)
w_import_progressbar.of_SetRemainprac(ai_prac_count)
w_import_progressbar.of_setmaxposition(ai_prac_count)
w_import_progressbar.dw_step.reset()

w_import_progressbar.dw_step.object.pic_flag[1,4] = li_pic_flag[]
w_import_progressbar.dw_step.object.step_desc[1] ="1. Get import data"
w_import_progressbar.dw_step.object.step_desc[2] ="2. Save data into IntelliSoft table"
w_import_progressbar.dw_step.object.step_desc[3] ="3. Add verify..."
w_import_progressbar.dw_step.object.step_desc[4] ="4.  Update log"
w_import_progressbar.dw_step.object.pic_flag[1] = 1
w_import_progressbar.hpb_progress.Position = 0

end subroutine

public function integer of_dyncreategpdw (string as_fields);//////////////////////////////////////////////////////////////////////
// $<function> of_dyncreategpdw
// $<arguments>
// $<returns> integer
// $<description> Dynamic create GP DW (V10.1 - Import Link Value)
//                        V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> Stephen 01.29.2012
//////////////////////////////////////////////////////////////////////

string  ls_Error
string  ls_Syntax
string  ls_Fields
string  ls_SQLSelect
string  ls_KeyField[]
integer li_KeyFieldIndex[]
integer i, li_KeyFieldCount
n_cst_dw_update_prop lnv_DwSyntax
long   ll_row

// Build sql select
ls_Fields = as_fields + "rec_id"

if AppeonGetClientType() = "PB" then
	ls_SQLSelect = "SELECT " + ls_Fields + ",'' sort_field FROM group_practice"
else
	ls_SQLSelect = "SELECT " + ls_Fields + " FROM group_practice"
end if

// Dynamic create datawindow
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "", ls_Error)
if LenA(ls_Error) > 0 then
	of_audit_error_log(20, IL_ERRTYPE_UPDATE, "Failed to dynamically create group_practice datawindow.","group_practice")
	Return -1
end if

// Modify datawindow update properties
ids_group_practice.Create(ls_Syntax, ls_Error)
ids_group_practice.SetTransObject(SQLCA)
 //---------Begin Modified by (Appeon)Stephen 2013-07-26 for IntelliImport "DB Update" error--------
 // if lnv_DwSyntax.of_ModifyUpdateProperty(ids_group_practice, "group_practice") = -1 then
 if lnv_DwSyntax.of_ModifyUpdateProperty(ids_group_practice, "group_practice", false) = -1 then
 //---------End Modfiied ------------------------------------------------------
	of_audit_error_log(20, IL_ERRTYPE_UPDATE, "Failed to dynamically create group_practice datawindow.","group_practice")
	Return -1
end if
ids_group_practice.object.datawindow.table.updatewhere = 0
ids_group_practice.Modify("sort_field.update='no'")

Return 1
end function

public function integer of_findgp (string as_finds, string as_fields[], string as_values[], string as_field_type[], ref long al_rec_id);//////////////////////////////////////////////////////////////////////
// $<function> of_findgp
// $<arguments>
//			 long		al_row
//		ref integer	ai_keyfieldindex[]
//			 integer	ai_keyfieldcount
// $<returns> integer
// $<description> Find group practice (V10.1 - Import Link Value)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.29.2010
//////////////////////////////////////////////////////////////////////

long ll_rec_id
long ll_MatchRow
long ll_ColCount
long i, ll_InsertRow
string ls_Value
string ls_Field
string ls_FindValue
n_cst_string lnv_string

// Find group practice
ll_MatchRow = ids_group_practice.Find(as_finds, 1, ids_group_practice.RowCount())
if ll_MatchRow > 0 then
	ll_rec_id = ids_group_practice.object.rec_id[ll_MatchRow]
else
	// Get max group practice id
	if il_group_practice_id = 0 then
		SELECT max(rec_id) INTO :il_group_practice_id FROM group_practice;
		if IsNull(il_group_practice_id) then il_group_practice_id = 0
	end if
	il_group_practice_id ++
	ll_rec_id = il_group_practice_id

	// Insert a new record into ids_group_practice_new for update data
	ll_InsertRow = ids_group_practice_new.InsertRow(0)
	ll_ColCount = upperbound(as_fields)
	for i = 1 to ll_ColCount
		ls_Field = as_fields[i]
		if ids_group_practice_new.of_FieldExists(ls_Field) then
			ids_group_practice_new.SetItem(ll_InsertRow, ls_Field, as_values[i])
		end if
	next
	ids_group_practice_new.SetItem(ll_InsertRow, "rec_id", il_group_practice_id)
end if

al_rec_id = ll_rec_id

Return 1
end function

public function integer of_create_ds ();//////////////////////////////////////////////////////////////////////
// $<function> of_create_ds
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> Dynamic create import_audit datastore
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 02.01.2013
//////////////////////////////////////////////////////////////////////

string ls_sql, ls_Syntax, ls_Error
n_cst_dw_update_prop lnv_DwSyntax

if isvalid(ids_audit_item) then destroy(ids_audit_item)

ids_audit_item = create datastore
ls_sql = " select rec_id, status, audit_by, audit_date from import_audit_item where import_id = "+string(il_import_id) +" and hdr_id=" +string(il_hdr_id)
ls_Syntax = SQLCA.SyntaxFromSQL(ls_sql, "Style(Type=Grid)", ls_Error)
IF LenA(ls_Error) > 0 THEN
	messagebox("Prompt", "Failed to dynamically create datawindow.")
	RETURN -1
END IF
ids_audit_item.Create(ls_Syntax, ls_Error)

IF LenA(ls_Error) > 0 THEN
	messagebox("Prompt", "Failed to dynamically create datawindow.")
	RETURN -1
END IF
ids_audit_item.settransobject(sqlca)
//---------Begin Added by (Appeon)Stephen 2013-07-26 for IntelliImport "DB Update" error--------
if lnv_DwSyntax.of_ModifyUpdateProperty(ids_audit_item, "import_audit_item", false) = -1 then
	of_audit_error_log(20, IL_ERRTYPE_UPDATE, "Failed to dynamically create import_audit_item datawindow.","import_audit_item")
	Return -1
end if
//---------End Added ------------------------------------------------------

gnv_appeondb.of_StartQueue()
SELECT getdate() INTO :idt_CurrentTime FROM ids;
ids_audit_item.retrieve()
gnv_appeondb.of_CommitQueue()

return 1
end function

public function integer of_create_screen_ds ();//////////////////////////////////////////////////////////////////////
// $<function> of_create_screen_ds
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> Dynamic create screen datastore
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 02.01.2013
//////////////////////////////////////////////////////////////////////

string ls_table_name[]
string ls_table, ls_opt_type
string ls_Syntax, ls_sqlselect, ls_error
long   ll_row, ll_cnt
integer li_status
boolean lb_in
n_import_ds lds_detail
str_import_cur lstr_null[]
n_cst_dw_update_prop lnv_DwSyntax

lds_detail = create n_import_ds
lds_detail.dataobject = dw_detail.dataobject
lds_detail.settransobject(sqlca)
dw_detail.rowscopy(1, dw_detail.rowcount(), primary!, lds_detail,1,primary!)
dw_detail.rowscopy(1,dw_detail.filteredcount(), filter!, lds_detail, lds_detail.rowcount() +1, primary!)

for ll_row = 1 to lds_detail.rowcount()
	ls_table = lds_detail.getitemstring(ll_row, "sys_tables_table_name")
	li_status = lds_detail.getitemnumber(ll_row, "import_audit_item_status")
	ls_opt_type = lds_detail.getitemstring(ll_row, "opt_type")
	if not(li_status = 0 and  ls_opt_type = '1')  then continue		
	lb_in = false
	for ll_cnt = 1 to upperbound(ls_table_name)
		if ls_table = ls_table_name[ll_cnt] then
			lb_in = true
			exit
		end if		
	next
	if lb_in = false then ls_table_name[upperbound(ls_table_name)+1] = ls_table
next

for ll_cnt = 1 to upperbound(istr_screen_ds)
	if isvalid(istr_screen_ds[ll_cnt].ds_rep) then destroy istr_screen_ds[ll_cnt].ds_rep
next
istr_screen_ds = lstr_null

for ll_cnt = 1 to upperbound(ls_table_name)	
	istr_screen_ds[ll_cnt].s_name = ls_table_name[ll_cnt]
	istr_screen_ds[ll_cnt].ds_rep = create n_import_ds
	ls_sqlselect = " select * from " + ls_table_name[ll_cnt]
	
	ls_Syntax = SQLCA.SyntaxFromSQL(ls_sqlselect, "", ls_error)
	
	if LenA(ls_Error) > 0 then
		messagebox("Prompt", "Failed to dynamically create updatable DataStore." )
		Return -1
	end if
	
	istr_screen_ds[ll_cnt].ds_rep.Create(ls_Syntax, ls_Error)
	istr_screen_ds[ll_cnt].ds_rep.SetTransObject(SQLCA)
	//---------Begin Added by (Appeon)Stephen 2013-07-26 for IntelliImport "DB Update" error--------	
	if lnv_DwSyntax.of_ModifyUpdateProperty(istr_screen_ds[ll_cnt].ds_rep, ls_table_name[ll_cnt], false) = -1 then
		of_audit_error_log(20, IL_ERRTYPE_UPDATE, "Failed to dynamically create "+ ls_table_name[ll_cnt] +" datawindow.", ls_table_name[ll_cnt])
		Return -1
	end if
	//---------End Added ------------------------------------------------------
next

return 1
end function

public function integer of_set_pd_affil_stat_def (ref datastore ads_screen, ref long al_facility_id, long al_prac_id, long al_seq_no, long al_find_row, string as_new);//////////////////////////////////////////////////////////////////////
// $<Function> of_set_pd_affil_stat_def
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2013 by Stephen
////////////////////////////////////////////////////////////////////// 
integer li_facility_def, li_veri_facility_def
integer li_audit_facility_def, li_active_status=-9
integer li_priority, li_prov_status
string  ls_apptmnt_type, ls_affi_status, ls_priority_user
datastore lds_import_hdr

lds_import_hdr = create datastore
lds_import_hdr.dataobject = "d_import_ds_hdr"
lds_import_hdr.settransobject(sqlca)
lds_import_hdr.retrieve(il_import_id)

li_facility_def  = ads_screen.object.parent_facility_id[al_find_row]
li_active_status  = ads_screen.object.active_status[al_find_row]
li_priority  = ads_screen.object.priority[al_find_row]
li_prov_status  = ads_screen.object.prov_status[al_find_row]
li_audit_facility_def  = ads_screen.object.application_audit_facility[al_find_row]
li_veri_facility_def  = ads_screen.object.verifying_facility[al_find_row]
ls_apptmnt_type  = ads_screen.object.apptmnt_type[al_find_row]
ls_affi_status  = ads_screen.object.affiliation_status[al_find_row]
ls_priority_user  = ads_screen.object.priority_user[al_find_row]
	
if lds_import_hdr.rowcount() > 0 then
	if isnull(li_facility_def) or li_facility_def = 0 then
		if not IsNull(lds_import_hdr.object.def_parent_id[1]) then
			li_facility_def = lds_import_hdr.object.def_parent_id[1]
		end if
	end if
	if isnull(li_audit_facility_def) or li_audit_facility_def = 0 then
		if not IsNull(lds_import_hdr.object.def_audit_id[1]) then
			li_audit_facility_def = lds_import_hdr.object.def_audit_id[1]
		end if
	end if
	if isnull(li_veri_facility_def) or li_veri_facility_def = 0 then
		if not IsNull(lds_import_hdr.object.def_verif_id[1]) then
			li_veri_facility_def = lds_import_hdr.object.def_verif_id[1]
		end if
	end if
	if isnull(ls_apptmnt_type) then
		if not IsNull(lds_import_hdr.object.def_appt_type[1]) then
			ls_apptmnt_type = lds_import_hdr.object.def_appt_type[1]
		end if
	end if
	if isnull(li_active_status) or li_active_status = -9 then
		if not IsNull(lds_import_hdr.object.def_status[1]) then
			li_active_status = lds_import_hdr.object.def_status[1]
		end if
	end if
	if isnull(ls_affi_status) then
		if not IsNull(lds_import_hdr.object.def_affil_stat[1]) and lena(lds_import_hdr.object.def_affil_stat[1]) = 1 then
			ls_affi_status = lds_import_hdr.object.def_affil_stat[1]
		end if
	end if
	if isnull(ls_priority_user) then
		if not IsNull(lds_import_hdr.object.def_user[1]) then
			ls_priority_user = lds_import_hdr.object.def_user[1]
		end if
	end if
end if
if isnull(li_facility_def) or li_facility_def = 0 then li_facility_def = al_facility_id
if isnull(li_audit_facility_def) or li_audit_facility_def = 0 then li_audit_facility_def = al_facility_id
if isnull(li_veri_facility_def)  or li_veri_facility_def =0 then li_veri_facility_def = al_facility_id
if isnull(ls_apptmnt_type) then ls_apptmnt_type = "I"
if isnull(li_active_status) or li_active_status = -9 then li_active_status = 1
if isnull(ls_affi_status) then ls_affi_status = 'M'
if isnull(ls_priority_user) then ls_priority_user = "PUBLIC"
if isnull(li_priority) or li_priority = 0 then li_priority = 1
if isnull(li_prov_status) then li_prov_status = 0

if as_new = 'Y' then
	ads_screen.setitem(al_find_row, "prac_id", al_prac_id)
	ads_screen.setitem(al_find_row, "rec_id", al_seq_no)
	ads_screen.setitem(al_find_row, "parent_facility_id", li_facility_def)
	ads_screen.setitem(al_find_row, "seq_no", 1)	
end if

ads_screen.setitem(al_find_row, "active_status", li_active_status)
ads_screen.setitem(al_find_row, "priority", li_priority)
ads_screen.setitem(al_find_row, "prov_status", li_prov_status)
ads_screen.setitem(al_find_row, "application_audit_facility", li_audit_facility_def)
ads_screen.setitem(al_find_row, "verifying_facility", li_veri_facility_def)
ads_screen.setitem(al_find_row, "apptmnt_type", ls_apptmnt_type)
ads_screen.setitem(al_find_row, "affiliation_status", ls_affi_status)
ads_screen.setitem(al_find_row, "priority_user", ls_priority_user)
ads_screen.accepttext()

al_facility_id = li_facility_def
return 1
end function

public function integer of_addverify (long al_seq, long al_prac_id, integer ai_screen_id, integer ai_table_id, long al_facility, string as_field_name[], string as_new, string as_audit_type, datastore ads_screen);//////////////////////////////////////////////////////////////////////
// $<Function> of_create_screen_dw
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.08.2013 by Stephen
//////////////////////////////////////////////////////////////////////

long  ll_row
string ls_field_name, ls_field_all

if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if

inv_data_entry.ib_report = false
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()

if as_audit_type = 'NW' then
	
else
	ls_field_all = ""
	for ll_row = 1 to upperbound(as_field_name)
		ls_field_name = as_field_name[ll_row]
		ads_screen.setitemstatus(1,ls_field_name,primary!, datamodified!)
		ls_field_all = ls_field_all +", " + as_field_name[ll_row]
	next
end if
yield()
if of_screen_update(ai_screen_id, al_prac_id, al_facility, ls_field_all, as_new, as_audit_type, ads_screen) = -1 then return -1

//if dw_screen.event ue_postupdate(al_prac_id, ai_screen_id, ai_table_id, al_facility) = -1 then return -1
return 1
end function

public function integer of_screen_update (integer ai_screen_id, long al_prac_id, integer ai_parent_facility_id, string as_field_name, string as_new, string as_audit_type, datastore ads_screen);//////////////////////////////////////////////////////////////////////
// $<Event> ue_update
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.09.2013 by Stephen
//////////////////////////////////////////////////////////////////////

DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  
long ll_templ_id[ ]  
long ll_verif_response  
long li_seq_no
long li_found
Long ll_rec_id_new 
Long ll_rec_id_changed[]
long ll_ver_method = -1 
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year 
integer li_month
integer li_validate
integer li_res  
integer li_complete[ ]   
integer li_auto_gen[ ] 
integer li_app_audit_facil 
integer li_appt_stat 
integer li_temp_cnt 
integer li_status = 1 
integer t  
integer li_set_mess 

string ls_use_as_ver
String ls_screen_name
String ls_ref_1, ls_ref_val1
String ls_val
String ls_ref_2, ls_ref_val2
String ls_ref_3, ls_ref_val3
String ls_exp_field
String ls_reference
String ls_rec_status
string ls_app_type 
string ls_mess 
string ls_type1
string ls_type2
string ls_type3
DataWindowChild dwchild
n_ds lds_aa_template 
n_ds lds_select_section
n_ds lds_parent_facilities
//n_ds lds_image_data
string  ls_appt_type

SetNull( ldt_null_date )
ads_screen.AcceptText()

li_rec_count = ads_screen.RowCount()
IF li_rec_count < 1 THEN
	RETURN -1
END IF

li_data_cr = ads_screen.GetRow()

/*
lds_image_data = create n_ds
lds_image_data.dataobject = 'd_image_scan_detail_inova'
lds_image_data.settransobject(sqlca)
*/

lds_select_section = create n_ds
lds_select_section.dataobject = 'd_data_view_screens_list'
lds_select_section.settransobject(sqlca)
lds_select_section.retrieve(1)
lds_select_section.setfilter("screen_id = "+string(ai_screen_id)+"")
lds_select_section.filter()

ls_ref_1 = lds_select_section.GetItemString( 1, "ref_field_1")
ls_ref_2 = lds_select_section.GetItemString( 1, "ref_field_2")
ls_ref_3 = lds_select_section.GetItemString( 1, "ref_field_3")
ls_type1 = lds_select_section.GetItemString( 1, "ref_1_type")//maha102501
ls_type2 = lds_select_section.GetItemString( 1, "ref_2_type")//maha102501
ls_type3 = lds_select_section.GetItemString( 1, "ref_3_type")//maha102501

ls_exp_field = lds_select_section.GetItemString( 1, "exp_field")
li_screen_id = lds_select_section.GetItemNumber( 1, "screen_id")
ls_screen_name = lds_select_section.GetItemString( 1, "screen_name")
li_table_id = lds_select_section.GetItemNumber( lds_select_section.GetRow(), "table_id" )
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//li_set_mess = of_get_app_setting("set_57","I")  //Start Code Change ----05.04.2009 #V92 maha
li_set_mess = of_get_app_setting("set_90","I") 
//---------End Modfiied ------------------------------------------------------
li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25
//$<add> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Use lds_parent_facilities to retrive all data
//$<modification> to be used by pfc_cst_u_data_entry. 
lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
lds_parent_facilities.Retrieve( al_prac_id )
//---------------------------- APPEON END ----------------------------

if isnull(ai_parent_facility_id) then
	li_app_audit_facil = -1
else
	lds_parent_facilities.setfilter("parent_facility_id = " + string(ai_parent_facility_id) + " and active_status in (1,4)")
	lds_parent_facilities.filter()
	li_app_audit_facil =  lds_parent_facilities.rowcount()
end if

if li_app_audit_facil > 1 then
	li_app_audit_facil = -1 //trap if there is improper data
elseif li_app_audit_facil = 1 then //normally should be one
	//get the template items for the screen
	lds_aa_template = CREATE n_ds
	lds_aa_template.DataObject = "d_app_audit_by_facility_screen"
	lds_aa_template.of_SetTransObject( SQLCA )
	ls_app_type = lds_parent_facilities.getitemstring(1,"apptmnt_type")
	li_app_audit_facil = lds_parent_facilities.getitemnumber(1,"application_audit_facility")
	ll_appt_stat_recid = lds_parent_facilities.getitemnumber(1,"rec_id")
	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ai_screen_id,ls_app_type)
	if li_temp_cnt < 1 then
		li_auto_gen[1] = 0
		li_complete[1] = 0
		ls_use_as_ver = "N"
		ll_verif_response = 0
	else //WHAT ABOUT MULTIPLES?
		for i = 1 to li_temp_cnt  //get each auto gen item
			ll_templ_id[i] = lds_aa_template.getitemnumber(i,"app_audit_id")
			li_auto_gen[i] = lds_aa_template.getitemnumber(i,"auto_generate")
			if isnull(li_auto_gen[i]) then li_auto_gen[i] = 0
			li_complete[i] = lds_aa_template.getitemnumber(i,"receive_from_de")
			if isnull(li_complete[i]) then li_complete[i] = 0
			if ls_use_as_ver <> "Y" then //if not already set to use as verification
				ls_use_as_ver = lds_aa_template.getitemstring(i,"use_as_verification")
				if isnull(ls_use_as_ver) then ls_use_as_ver = "N"
			end if
			if ll_verif_response = 0 or isnull(ll_verif_response) then //get response code if not set
				ll_verif_response = lds_aa_template.getitemnumber(i,"default_ver_response_code")
				if isnull(ll_verif_response) then ll_verif_response = 0
			end if
		next
		if ls_use_as_ver = "Y" then
			ls_mess = "Y"
		else
			ls_mess = "N"
		end if
		ls_mess = ls_mess +  "*" +string(ll_verif_response )
	end if
	DESTROY lds_aa_template
end if

lds_parent_facilities.setfilter("") 
lds_parent_facilities.filter()

FOR i = 1 TO li_rec_count
	//debugbreak()			
	SetNull( ll_address_code )
	IF as_audit_type  = 'NW'  THEN
		ls_rec_status = "New"
	ELSE
		ls_rec_status = "Modified"
	END IF
	
	ll_rec_id = ads_screen.GetItemNumber( i, "rec_id" )
	
	IF ads_screen.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
		IF ads_screen.GetItemNumber( i, "active_status" ) < 1 THEN  //Start Code Change ----01.24.2011 #V11 maha - changd from = 0
			if ls_rec_status = "New" then
				CONTINUE
			else				//\/maha 031601  //Start Code Change ----01.24.2011 #V11 maha - modified update query to include prac_id
				update verif_info
				set active_status = 0
				where rec_id = :ll_rec_id and prac_id = :al_prac_id and active_status = 1;
				continue		 //\maha/\
			end if
		END IF
	END IF
	
	//\/maha 031601 get month and year end for check back date passed in verification add
	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
		if ads_screen.Describe("year_thru.ColType") <> "!" then
			li_year = ads_screen.getitemnumber(i,"year_thru")
			if ads_screen.Describe("month_thru.ColType") <> "!" then
				li_month = ads_screen.getitemnumber(i,"month_thru")
			end if
			//maha added to using full end date field
		//--------Begin Modified by  Nova 07.15.2010------------------------
		elseif ads_screen.Describe("end_date.ColType") <> "!" then    
		//--------End Modified --------------------------------------------	
			li_year = year(date(ads_screen.getitemdatetime(i,"end_date")))
			li_month = month(date(ads_screen.getitemdatetime(i,"end_date")))
		end if
	end if
	//\maha
		
	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
	
	IF li_screen_id = 19 THEN //specialty
		if ads_screen.Describe("board_code.ColType") = "!" then continue //Start Code Change----06.01.2010 #V10 maha - added trap for hidden board code
		
		IF IsNull( ads_screen.GetItemNumber( i, "board_code" ) ) THEN
			CONTINUE
		  //Start Code Change ---- 10.26.2007 #V7 maha	
		ELSE
			ll_address_code = ads_screen.GetItemNumber( i, "board_code" ) 
			IF ls_rec_status = "Modified" THEN
				SELECT count(*)  
				INTO :li_cnt  
				FROM verif_info  
				WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
					( verif_info.active_status = 1 )   ;
				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
					ls_rec_status = "New"
				END IF
			end if //modified
			//End Code Change---10.26.2007
		END IF
	//jad 05/30/01 added to make any screen facility specific
	ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
		if ads_screen.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
			ads_screen.SetItem( i, "facility_id", ai_parent_facility_id )	
		end if	
	END IF
	
	//Start Code Change ----08.31.2011 #V11 maha 
	IF li_table_id = 72 THEN  //other verifications
		if ads_screen.Describe("verif_method.ColType") = "!" then 
			//leave as default -1
		else
			ll_ver_method = ads_screen.GetItemNumber( i, "verif_method" )
			if isnull( ll_ver_method) then ll_ver_method = -1
		end if
	end if
	//End Code Change ----08.31.2011
	
	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN

		//move expiration date to verif info table if there is one
		IF Len(ls_exp_field) > 0 THEN
			IF ls_exp_field = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( String( ads_screen.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())				
			ELSEIF ls_exp_field = "cert_expiration_year" THEN
				li_month = ads_screen.GetItemNumber( i, "cert_expiration_month" )
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( String( ads_screen.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())				
				else
					ldt_exp_date = DateTime(Date(String( ads_screen.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
				end if
			ELSE
				if ads_screen.Describe(ls_exp_field + ".ColType") <> "!" then
					ldt_exp_date = ads_screen.GetItemDateTime( i, ls_exp_field )
				else
					of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE, "The " + upper(ls_exp_field) + " field is required by your system settings", ls_exp_field)
					is_error = "error"
					if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
					if isvalid(lds_select_section) then DESTROY lds_select_section
					//if isvalid(lds_image_data) then DESTROY lds_image_data
                       RETURN -1
				end if
			END IF
		ELSE
			ldt_exp_date = ldt_null_date
		END IF
	
		//get reference 1 data 		
		if ads_screen.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
			of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE, "Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated", ls_ref_1)            
              is_error = "error"
			if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
			if isvalid(lds_select_section) then DESTROY lds_select_section
			//if isvalid(lds_image_data) then DESTROY lds_image_data
			RETURN -1
		end if
		li_retval = ads_screen.SetColumn( ls_ref_1 )
		IF li_retval = 1 THEN
			choose case ls_type1
				case 'I','N'
					ls_ref_val1 = string(ads_screen.getitemnumber(i, ls_ref_1))
				case 'D'
					if ads_screen.Describe(ls_ref_1 + ".ColType") = "date" then
						ls_ref_val1 = string(ads_screen.getitemdate(i, ls_ref_1), 'yyyy-mm-dd')
					else
						ls_ref_val1 = string(ads_screen.getitemdatetime(i, ls_ref_1), 'yyyy-mm-dd')
					end if
				case else
					ls_ref_val1 = ads_screen.getitemstring(i, ls_ref_1)
			end choose
			
			IF IsNull( ls_ref_val1 ) OR ls_ref_val1 = "" THEN
				SetRedraw( True )
				of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  "The data field " + ls_ref_1 + " is required", ls_ref_1)   
				is_error = "error"
				if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
				if isvalid(lds_select_section) then DESTROY lds_select_section
				//if isvalid(lds_image_data) then DESTROY lds_image_data
                  RETURN -1
			END IF
			li_retval = ads_screen.GetChild(ls_ref_1, dwchild)
			IF li_retval = -1 THEN
				ls_reference =  ls_ref_val1				
			ELSE
				ads_screen.SetColumn( ls_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + ls_ref_val1, 1, 100000 )
				IF li_found < 1 THEN 
					ls_reference = ls_ref_val1
				ELSEIF ads_screen.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
					ls_reference = dwchild.GetItemString( li_found, "code" )
					IF ai_screen_id = 4 THEN					
						if ads_screen.Describe("verifying_agency.ColType") = "!" then 
							of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " The verifying_agency field is a required field, and must be visible to enter Licence data", " verifying_agency")            
                     			is_error = "error"    
							if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
							if isvalid(lds_select_section) then DESTROY lds_select_section
							//if isvalid(lds_image_data) then DESTROY lds_image_data
							RETURN -1
						else
							ll_address_code = ads_screen.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(ads_screen.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = ads_screen.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
				ELSEIF ads_screen.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or ads_screen.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if ads_screen.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed ads_screen to aloways use the entity name originalf the of containg the code as well, 
					else
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						ll_address_code = long(ads_screen.GetItemstring( i, ls_ref_1 ))//maha 072501
					elseif ls_type1 = "N" then //maha 102501
						ll_address_code = ads_screen.GetItemNumber( i, ls_ref_1 )
					end if
				ELSEIF ads_screen.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					ls_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ai_screen_id = 4 THEN					
						if ads_screen.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " The verifying_agency field is a required field, and must be visible to enter Licence data", " verifying_agency")
							is_error = "error"
							if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
							if isvalid(lds_select_section) then DESTROY lds_select_section
							//if isvalid(lds_image_data) then DESTROY lds_image_data
                               RETURN -1
						else
							ll_address_code = ads_screen.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(ads_screen.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = ads_screen.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					ls_reference = ls_ref_val1		
				END IF
			END IF
		ELSE
			ls_reference = ""
		END IF

	   If NOT Isnull(ls_ref_2) THEN
			//get reference 2 data
			if ads_screen.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
				of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated", ls_ref_2) 
				is_error = "error"
				if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
				if isvalid(lds_select_section) then DESTROY lds_select_section
				//if isvalid(lds_image_data) then DESTROY lds_image_data
                  RETURN -1
			end if
			li_retval = ads_screen.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				choose case ls_type2
					case 'I','N'
						ls_ref_val2 = string(ads_screen.getitemnumber(i, ls_ref_2))
					case 'D'
						if ads_screen.Describe(ls_ref_1 + ".ColType") = "date" then
							ls_ref_val2 = string(ads_screen.getitemdate(i, ls_ref_2), 'yyyy-mm-dd')
						else
							ls_ref_val2 = string(ads_screen.getitemdatetime(i, ls_ref_2), 'yyyy-mm-dd')
						end if
					case else
						ls_ref_val2 = ads_screen.getitemstring(i, ls_ref_2)
				end choose
			
				IF IsNull( ls_ref_val2 ) OR ls_ref_val2 = "" THEN
					SetRedraw( True )
					of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated", ls_ref_2) 
					is_error = "error"
					if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
					if isvalid(lds_select_section) then DESTROY lds_select_section
					//if isvalid(lds_image_data) then DESTROY lds_image_data
                       RETURN -1
				END IF		
				li_retval = ads_screen.GetChild(ls_ref_2, dwchild)
				IF li_retval = -1 THEN
					ls_reference = ls_reference + " - " + ls_ref_val2		
				ELSE
					ads_screen.SetColumn( ls_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + ls_ref_val2, 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF ads_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF ads_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF ads_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or ads_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if ads_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							ls_reference = ls_reference + " - " + ls_ref_val2
						END IF
					else
						ls_reference = ls_reference + " - " + ""
					end if
				END IF
			ELSE
				ls_reference = ls_reference + " - " + ""
			END IF
			
			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
		END IF

		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
		if ads_screen.Describe("active_status.ColType") <> "!" then
			li_status = ads_screen.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
		end if
		//End Code Change---08.01.2008
		//Start Code Change ---- 10.26.2006 #1 maha
		IF ls_rec_status = "Modified" THEN
			if not isvalid(inv_action_items) then 
				inv_action_items = create pfc_n_cst_ai_action_items
			end if
			inv_action_items.of_update_reference(  ls_reference, ll_rec_id, ll_address_code, ldt_exp_date, li_screen_id, li_status, ll_ver_method)
			inv_data_entry.of_app_audit_update_ref( al_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> 
			IF  pos(as_field_name , ls_exp_field +",")> 0 THEN
				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
			END IF
			//---------------------------- APPEON END ----------------------------
		ELSE  //new
			for t = 1 to li_temp_cnt //check to see if completion is desired
				if li_complete[t] = 1 then 
					openwithparm(w_app_audit_complete_mes,  ls_mess) //asks user to complete and gets response code 
					ls_mess = message.stringparm
					if mid(ls_mess,1,1) = "N" then 
						li_complete[t] = 0
						ll_verif_response = 0
					else //yes
						ll_verif_response = long(mid(ls_mess,3))
					end if	
				else //Start Code Change ---- 05.09.2007 #V7 maha trap so verif does not get completed
					li_complete[t] = 0
					ll_verif_response = 0
				end if
				if li_auto_gen[t] = 1 then  //Start Code Change ---- 05.09.2007 #V7 maha only create if set to auto gen
					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,al_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )  //Start Code Change ----12.05.2016 #V153 maha
				end if
				yield()
			next
						
			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
			debugbreak()
			IF of_add_verif_info( al_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method, li_table_id) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument
				is_error = "error"
				if isvalid(lds_parent_facilities) then DESTROY lds_parent_facilities
				if isvalid(lds_select_section) then DESTROY lds_select_section
				//if isvalid(lds_image_data) then DESTROY lds_image_data
				RETURN -1
			end if
		END IF

	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	//$<delete>02.27.2013 by stephen
	/*
	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
	long ll_cnt_new
	select count(1) into :ll_cnt_new from pd_images where prac_id = :al_prac_id and rec_id = :ll_rec_id;
	if (ls_rec_status = "New" and ll_cnt_new = 0) then
		ll_de_queue = long(gnv_data.of_getitem('image_type','de_queue','link_to_screen = ' + string(li_screen_id)))
		if ll_de_queue = 1 then
			ll_image_type_id = long(gnv_data.of_getitem('image_type','image_type_id','link_to_screen = ' + string(li_screen_id)))
			ll_default_pages = long(gnv_data.of_getitem('image_type','default_pages','link_to_screen = ' + string(li_screen_id)))

			ll_row = lds_image_data.insertrow(0)
			
			SELECT Max( seq_no )  
			INTO :ll_seq_no  
			FROM pd_images  
			WHERE pd_images.rec_id = :ll_rec_id ;
			
			IF IsNull( ll_seq_no ) THEN
				ll_seq_no = 0
			END IF
			ll_seq_no++
			lds_image_data.SetItem( ll_row, "image_type_id", ll_image_type_id )
			lds_image_data.SetItem( ll_row, "prac_id", al_prac_id )
			lds_image_data.SetItem( ll_row, "seq_no", ll_seq_no )
			lds_image_data.SetItem( ll_row, "rec_id", ll_rec_id  )
			lds_image_data.SetItem( ll_row, "facility_id", ai_parent_facility_id  )	
			lds_image_data.SetItem( ll_row, "screen_id", li_screen_id )	
			lds_image_data.SetItem( ll_row, "reference_name", ls_reference )
			lds_image_data.SetItem( ll_row, "active_status", 1 )	
			lds_image_data.SetItem( ll_row, "num_pages", ll_default_pages )
			lds_image_data.SetItem( ll_row, "tif_start_page", 1 )
			lds_image_data.SetItem( ll_row, "de_queue", 0 )
		end if
	end if
	*/
	yield()
	//---------------------------- APPEON END ----------------------------
END FOR

//lds_image_data.update() //Queue Images for Scanning from Data Entry - Jack 10.12.2006 

DESTROY lds_parent_facilities
DESTROY lds_select_section
//DESTROY lds_image_data
//---------------------------- APPEON END ----------------------------


RETURN 1

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

dw_prac.retrieve(il_hdr_id)
if ls_change = '1' then
	for ll_row = dw_prac.rowcount() to 1 step -1
		ll_prac_id = dw_prac.getitemnumber(ll_row, "prac_id")
		ll_find = ids_prac_change.find("prac_id = "+string(ll_prac_id), 1, ids_prac_change.rowcount())
		if ll_find < 1 then dw_prac.deleterow(ll_row)
	next
elseif ls_change = '2' then
	for ll_row = dw_prac.rowcount() to 1 step -1
		ll_prac_id = dw_prac.getitemnumber(ll_row, "prac_id")
		ll_find = ids_prac_change.find("prac_id = "+string(ll_prac_id), 1, ids_prac_change.rowcount())
		if ll_find > 0 then dw_prac.deleterow(ll_row)
	next
end if

if dw_prac.rowcount() < 1 then
	dw_detail.setfilter("1<>1")
	dw_detail.filter()
end if
return 1
end function

public function integer of_get_screen_ds (string as_tablename, integer ai_table_id, ref n_import_ds ads_screen);//////////////////////////////////////////////////////////////////////
// $<function> of_get_screen_ds
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> get screen datastore
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 02.01.2013
//////////////////////////////////////////////////////////////////////

integer li_cnt
string   ls_Syntax, ls_Error

for li_cnt = 1 to upperbound(istr_screen_ds)
	if as_tablename = istr_screen_ds[li_cnt].s_name then
		if isvalid(istr_screen_ds[li_cnt].ds_rep) then
			ads_screen = create n_import_ds
			ls_Syntax = istr_screen_ds[li_cnt].ds_rep.object.datawindow.syntax
			ads_screen.Create(ls_Syntax, ls_Error)
			ads_screen.settransobject(sqlca)
			ads_screen.insertrow(1)
		else
			is_error = "Failed to dynamically create updatable DataStore"
			of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, is_error,"")
			return -1
		end if
	end if
next

if not isvalid(ads_screen) then
	is_error = "Failed to dynamically create updatable DataStore"
	of_audit_error_log(ai_table_id, IL_ERRTYPE_UPDATE, is_error,"")
	return -1
end if
return 1
end function

on w_import_audit.create
int iCurrent
call super::create
this.dw_prac_change=create dw_prac_change
this.st_2=create st_2
this.cb_print=create cb_print
this.dw_screen=create dw_screen
this.dw_link_list=create dw_link_list
this.cb_view=create cb_view
this.dw_import=create dw_import
this.st_1=create st_1
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.rb_rejected=create rb_rejected
this.rb_previous=create rb_previous
this.rb_accept=create rb_accept
this.rb_all=create rb_all
this.cb_reject=create cb_reject
this.cb_accept=create cb_accept
this.dw_detail=create dw_detail
this.dw_prac=create dw_prac
this.dw_list=create dw_list
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_prac_change
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.cb_print
this.Control[iCurrent+4]=this.dw_screen
this.Control[iCurrent+5]=this.dw_link_list
this.Control[iCurrent+6]=this.cb_view
this.Control[iCurrent+7]=this.dw_import
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_reset
this.Control[iCurrent+10]=this.dw_date_range
this.Control[iCurrent+11]=this.cb_filter
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.rb_rejected
this.Control[iCurrent+14]=this.rb_previous
this.Control[iCurrent+15]=this.rb_accept
this.Control[iCurrent+16]=this.rb_all
this.Control[iCurrent+17]=this.cb_reject
this.Control[iCurrent+18]=this.cb_accept
this.Control[iCurrent+19]=this.dw_detail
this.Control[iCurrent+20]=this.dw_prac
this.Control[iCurrent+21]=this.dw_list
this.Control[iCurrent+22]=this.gb_1
this.Control[iCurrent+23]=this.gb_2
end on

on w_import_audit.destroy
call super::destroy
destroy(this.dw_prac_change)
destroy(this.st_2)
destroy(this.cb_print)
destroy(this.dw_screen)
destroy(this.dw_link_list)
destroy(this.cb_view)
destroy(this.dw_import)
destroy(this.st_1)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.cb_filter)
destroy(this.cb_close)
destroy(this.rb_rejected)
destroy(this.rb_previous)
destroy(this.rb_accept)
destroy(this.rb_all)
destroy(this.cb_reject)
destroy(this.cb_accept)
destroy(this.dw_detail)
destroy(this.dw_prac)
destroy(this.dw_list)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.04.2013 by Stephen
//////////////////////////////////////////////////////////////////////

str_flag  lstr_audit
long ll_import_id, ll_hdr_id
datawindowchild ldwc_1
boolean lb_parm

// Set resize
this.setredraw(false)
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(dw_detail, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_list, inv_resize.SCALERIGHT)
inv_resize.of_Register(dw_prac, inv_resize.SCALEBOTTOM)

of_constract_dw()
dw_prac_change.setitem(1,"s_type",'0')

lstr_audit = Message.powerobjectParm
//---------Begin Modified by (Appeon)Stephen 10.28.2014 for Import Audit error--------
/*
if isvalid(lstr_audit) then
	of_auto_filter(lstr_audit)	
else
	is_original_sql = dw_list.getsqlselect()
	dw_import.getchild("import_id", ldwc_1)
	ldwc_1.settransobject(sqlca)
	ldwc_1.retrieve()
	ldwc_1.insertrow(1)
	ldwc_1.selectrow(0, false)
end if
*/
lb_parm = false
if isvalid(lstr_audit) then
	if lstr_audit.l_oriid<> - 999 then
		of_auto_filter(lstr_audit)	
	else
		lb_parm = true
	end if
else
	lb_parm = true	
end if
if lb_parm = true then
	is_original_sql = dw_list.getsqlselect()
	dw_import.getchild("import_id", ldwc_1)
	ldwc_1.settransobject(sqlca)
	ldwc_1.retrieve()
	ldwc_1.insertrow(1)
	ldwc_1.selectrow(0, false)
end if
//---------End Modfiied ------------------------------------------------------
this.setredraw(true)


end event

event pfc_postopen;call super::pfc_postopen;//////////////////////////////////////////////////////////////////////
// $<Event> pfc_postopen
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.02.2013 by Stephen
//////////////////////////////////////////////////////////////////////

dw_date_range.of_SetUpdateAble( False )
dw_date_range.of_SetTransObject( SQLCA )
dw_date_range.InsertRow( 0 )

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
dw_date_range.of_setupdateable(false) 
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<Event> closequery
// $<arguments> N/A
// $<returns> long
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_cnt

if isvalid(ids_address_lookup) then destroy ids_address_lookup
if isvalid(ids_facility) then destroy ids_facility
if isvalid(ids_active_status) then destroy ids_active_status
if isvalid(ids_question) then destroy ids_question
if isvalid(ids_code_lookup) then destroy ids_code_lookup
if isvalid(ids_committee) then destroy ids_committee
if isvalid(ids_qa_metrics) then destroy ids_qa_metrics

if isvalid(ids_log_error) then destroy ids_log_error
if isvalid(ids_audit_log_table) then destroy ids_audit_log_table

if isvalid(ids_table_record) then destroy ids_table_record
if isvalid(ids_address) then destroy ids_address
if isvalid(ids_hosp_facility) then destroy ids_hosp_facility
if isvalid(ids_spec_facility) then destroy ids_spec_facility

if isvalid(ids_group_practice) then destroy ids_group_practice
if isvalid(ids_group_practice_new) then destroy ids_group_practice_new
if isvalid(ids_audit_item) then destroy(ids_audit_item)

for ll_cnt = 1 to upperbound(istr_screen_ds) 
	if isvalid(istr_screen_ds[ll_cnt].ds_rep) then destroy istr_screen_ds[ll_cnt].ds_rep
next
end event

type dw_prac_change from datawindow within w_import_audit
integer x = 37
integer y = 660
integer width = 946
integer height = 76
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_import_change"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<Function> of_filter_prac
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//                       filter Prac
//////////////////////////////////////////////////////////////////////
// $<add> 03.13.2013 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_row

dw_detail.setredraw(false)
dw_prac.setredraw(false)
dw_detail.setfilter("")
dw_detail.filter()

for ll_row = 1 to dw_detail.rowcount()
	dw_detail.setitem(ll_row, "opt_type", "1")
next
of_filter_prac()
for ll_row = 1 to dw_prac.rowcount()
	dw_prac.setitem(ll_row, "opt_type", "1")
next

dw_prac.modify("b_1.text = 'Deselect All'")
if dw_prac.rowcount() > 0 then
	dw_prac.event rowfocuschanged(1)
end if

dw_detail.setredraw(true)
dw_prac.setredraw(true)

end event

type st_2 from statictext within w_import_audit
integer x = 46
integer y = 604
integer width = 480
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Practitioner Filter"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_import_audit
integer x = 2807
integer y = 40
integer width = 302
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "R&un Report"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2013 by Stephen
//////////////////////////////////////////////////////////////////////

long  ll_row, ll_hdr
str_size lstr_str

ll_row = dw_list.getrow()
if ll_row < 1 then return

ll_hdr = dw_list.getitemnumber(ll_row, "hdr_id")
lstr_str.x = il_import_id
lstr_str.y = ll_hdr
openwithparm(w_import_audit_report, lstr_str)
end event

type dw_screen from u_dw within w_import_audit
event type integer ue_update ( integer ai_screen_id,  long al_prac_id,  integer ai_parent_facility_id,  string as_field_name,  string as_new,  string as_audit_type )
event type integer ue_postupdate ( long al_prac_id,  integer ai_screen,  integer ai_table_id,  integer ai_parent_facility_id )
boolean visible = false
integer x = 1902
integer y = 780
integer taborder = 40
end type

event type integer ue_update(integer ai_screen_id, long al_prac_id, integer ai_parent_facility_id, string as_field_name, string as_new, string as_audit_type);//////////////////////////////////////////////////////////////////////
// $<Event> ue_update
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.09.2013 by Stephen
//////////////////////////////////////////////////////////////////////

DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  
long ll_templ_id[ ]  
long ll_verif_response  
long li_seq_no
long li_found
Long ll_rec_id_new 
Long ll_rec_id_changed[]
long ll_ver_method = -1 
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year 
integer li_month
integer li_validate
integer li_res  
integer li_complete[ ]   
integer li_auto_gen[ ] 
integer li_app_audit_facil 
integer li_appt_stat 
integer li_temp_cnt 
integer li_status = 1 
integer t  
integer li_set_mess 

string ls_use_as_ver
String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
string ls_app_type 
string ls_mess 
string ls_type1
string ls_type2
string ls_type3
DataWindowChild dwchild
n_ds lds_aa_template 
n_ds lds_select_section
n_ds lds_parent_facilities
n_ds lds_image_data
string  ls_appt_type

SetNull( ldt_null_date )
This.AcceptText()

//initialize variables for dataflow: alfee 01.07.2010
//////inv_dataflow.of_init_data() 

li_rec_count = This.RowCount()
IF li_rec_count < 1 THEN
	RETURN -1
END IF

SetRedraw( False )

li_data_cr = This.GetRow()

lds_image_data = create n_ds
lds_image_data.dataobject = 'd_image_scan_detail_inova'
lds_image_data.settransobject(sqlca)

lds_select_section = create n_ds
lds_select_section.dataobject = 'd_data_view_screens_list'
lds_select_section.settransobject(sqlca)
lds_select_section.retrieve(1)
lds_select_section.setfilter("screen_id = "+string(ai_screen_id)+"")
lds_select_section.filter()

ls_ref_1 = lds_select_section.GetItemString( 1, "ref_field_1")
ls_ref_2 = lds_select_section.GetItemString( 1, "ref_field_2")
ls_ref_3 = lds_select_section.GetItemString( 1, "ref_field_3")
ls_type1 = lds_select_section.GetItemString( 1, "ref_1_type")//maha102501
ls_type2 = lds_select_section.GetItemString( 1, "ref_2_type")//maha102501
ls_type3 = lds_select_section.GetItemString( 1, "ref_3_type")//maha102501

ls_exp_field = lds_select_section.GetItemString( 1, "exp_field")
li_screen_id = lds_select_section.GetItemNumber( 1, "screen_id")
ls_screen_name = lds_select_section.GetItemString( 1, "screen_name")
li_table_id = lds_select_section.GetItemNumber( lds_select_section.GetRow(), "table_id" )
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//li_set_mess = of_get_app_setting("set_57","I")  //Start Code Change ----05.04.2009 #V92 maha
li_set_mess = of_get_app_setting("set_90","I")
//---------End Modfiied ------------------------------------------------------
li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25
//$<add> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Use lds_parent_facilities to retrive all data
//$<modification> to be used by pfc_cst_u_data_entry. 
lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
lds_parent_facilities.Retrieve( al_prac_id )
//---------------------------- APPEON END ----------------------------

if isnull(ai_parent_facility_id) then
	li_app_audit_facil = -1
else
	lds_parent_facilities.setfilter("parent_facility_id = " + string(ai_parent_facility_id) + " and active_status in (1,4)")
	lds_parent_facilities.filter()
	li_app_audit_facil =  lds_parent_facilities.rowcount()
end if

if li_app_audit_facil > 1 then
	li_app_audit_facil = -1 //trap if there is improper data
elseif li_app_audit_facil = 1 then //normally should be one
	//get the template items for the screen
	lds_aa_template = CREATE n_ds
	lds_aa_template.DataObject = "d_app_audit_by_facility_screen"
	lds_aa_template.of_SetTransObject( SQLCA )
	ls_app_type = lds_parent_facilities.getitemstring(1,"apptmnt_type")
	li_app_audit_facil = lds_parent_facilities.getitemnumber(1,"application_audit_facility")
	ll_appt_stat_recid = lds_parent_facilities.getitemnumber(1,"rec_id")
	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ai_screen_id,ls_app_type)
	if li_temp_cnt < 1 then
		li_auto_gen[1] = 0
		li_complete[1] = 0
		ls_use_as_ver = "N"
		ll_verif_response = 0
	else //WHAT ABOUT MULTIPLES?
		for i = 1 to li_temp_cnt  //get each auto gen item
			ll_templ_id[i] = lds_aa_template.getitemnumber(i,"app_audit_id")
			li_auto_gen[i] = lds_aa_template.getitemnumber(i,"auto_generate")
			if isnull(li_auto_gen[i]) then li_auto_gen[i] = 0
			li_complete[i] = lds_aa_template.getitemnumber(i,"receive_from_de")
			if isnull(li_complete[i]) then li_complete[i] = 0
			if ls_use_as_ver <> "Y" then //if not already set to use as verification
				ls_use_as_ver = lds_aa_template.getitemstring(i,"use_as_verification")
				if isnull(ls_use_as_ver) then ls_use_as_ver = "N"
			end if
			if ll_verif_response = 0 or isnull(ll_verif_response) then //get response code if not set
				ll_verif_response = lds_aa_template.getitemnumber(i,"default_ver_response_code")
				if isnull(ll_verif_response) then ll_verif_response = 0
			end if
		next
		if ls_use_as_ver = "Y" then
			ls_mess = "Y"
		else
			ls_mess = "N"
		end if
		ls_mess = ls_mess +  "*" +string(ll_verif_response )
	end if
	DESTROY lds_aa_template
end if

lds_parent_facilities.setfilter("") 
lds_parent_facilities.filter()

FOR i = 1 TO li_rec_count
	//debugbreak()			
	SetNull( ll_address_code )
	IF as_audit_type  = 'NW'  THEN
		ls_rec_status = "New"
	ELSE
		ls_rec_status = "Modified"
	END IF
	
	ll_rec_id = This.GetItemNumber( i, "rec_id" )
	
	IF This.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
		IF This.GetItemNumber( i, "active_status" ) < 1 THEN  //Start Code Change ----01.24.2011 #V11 maha - changd from = 0
			if ls_rec_status = "New" then
				CONTINUE
			else				//\/maha 031601  //Start Code Change ----01.24.2011 #V11 maha - modified update query to include prac_id
				update verif_info
				set active_status = 0
				where rec_id = :ll_rec_id and prac_id = :al_prac_id and active_status = 1;
				continue		 //\maha/\
			end if
		END IF
	END IF
	
	//\/maha 031601 get month and year end for check back date passed in verification add
	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
		if This.Describe("year_thru.ColType") <> "!" then
			li_year = this.getitemnumber(i,"year_thru")
			if This.Describe("month_thru.ColType") <> "!" then
				li_month = this.getitemnumber(i,"month_thru")
			end if
			//maha added to using full end date field
		//--------Begin Modified by  Nova 07.15.2010------------------------
		elseif This.Describe("end_date.ColType") <> "!" then    
		//--------End Modified --------------------------------------------	
			li_year = year(date(this.getitemdatetime(i,"end_date")))
			li_month = month(date(this.getitemdatetime(i,"end_date")))
		end if
	end if
	//\maha
		
	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
	
	IF li_screen_id = 19 THEN //specialty
		if This.Describe("board_code.ColType") = "!" then continue //Start Code Change----06.01.2010 #V10 maha - added trap for hidden board code
		
		IF IsNull( This.GetItemNumber( i, "board_code" ) ) THEN
			CONTINUE
		  //Start Code Change ---- 10.26.2007 #V7 maha	
		ELSE
			ll_address_code = This.GetItemNumber( i, "board_code" ) 
			IF ls_rec_status = "Modified" THEN
				SELECT count(*)  
				INTO :li_cnt  
				FROM verif_info  
				WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
					( verif_info.active_status = 1 )   ;
				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
					ls_rec_status = "New"
				END IF
			end if //modified
			//End Code Change---10.26.2007
		END IF
	//jad 05/30/01 added to make any screen facility specific
	ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
		if This.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
			This.SetItem( i, "facility_id", ai_parent_facility_id )	
		end if	
	END IF
	
	//Start Code Change ----08.31.2011 #V11 maha 
	IF li_table_id = 72 THEN  //other verifications
		if This.Describe("verif_method.ColType") = "!" then 
			//leave as default -1
		else
			ll_ver_method = this.GetItemNumber( i, "verif_method" )
			if isnull( ll_ver_method) then ll_ver_method = -1
		end if
	end if
	//End Code Change ----08.31.2011
	
	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
		This.ScrollToRow( i )
		This.SetRow( i )

		//move expiration date to verif info table if there is one
		IF Len(ls_exp_field) > 0 THEN
			IF ls_exp_field = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())				
			ELSEIF ls_exp_field = "cert_expiration_year" THEN
				li_month = this.GetItemNumber( i, "cert_expiration_month" )
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())				
				else
					ldt_exp_date = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
				end if
			ELSE
				if This.Describe(ls_exp_field + ".ColType") <> "!" then
					ldt_exp_date = This.GetItemDateTime( i, ls_exp_field )
				else
					//of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
					of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE, "The " + upper(ls_exp_field) + " field is required by your system settings", ls_exp_field)
                       RETURN -1
				end if
			END IF
		ELSE
			ldt_exp_date = ldt_null_date
		END IF
	
		//get reference 1 data 		
		if This.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
			//messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
			of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE, "Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated", ls_ref_1)            
              RETURN -1
		end if
		li_retval = This.SetColumn( ls_ref_1 )
		IF li_retval = 1 THEN
			IF IsNull( GetText() ) OR GetText() = "" THEN
				SetRedraw( True )
				//of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
				of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  "The data field " + ls_ref_1 + " is required", ls_ref_1)            
                  RETURN -1
			END IF
			li_retval = This.GetChild(ls_ref_1, dwchild)
			IF li_retval = -1 THEN
				ls_reference =  This.GetText()				
			ELSE
				This.SetColumn( ls_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
					ls_reference = This.GetText()
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
					ls_reference = dwchild.GetItemString( li_found, "code" )
					IF ai_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							//of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
					         of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " The verifying_agency field is a required field, and must be visible to enter Licence data", " verifying_agency")            
                                RETURN -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
					else
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
					elseif ls_type1 = "N" then //maha 102501
						ll_address_code = This.GetItemNumber( i, ls_ref_1 )
					end if
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					ls_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ai_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							//of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " The verifying_agency field is a required field, and must be visible to enter Licence data", " verifying_agency")            
                               RETURN -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					ls_reference = This.GetText()			
				END IF
			END IF
		ELSE
			ls_reference = ""
		END IF

	   If NOT Isnull(ls_ref_2) THEN
			//get reference 2 data
			if This.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
				//messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated", ls_ref_2)            
                  RETURN -1
			end if
			li_retval = This.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( GetText() ) OR GetText() = "" THEN
					SetRedraw( True )
					//of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					of_audit_error_log(li_table_id, IL_ERRTYPE_VERIFYVALUE,  " Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated", ls_ref_2)            
                       RETURN -1
				END IF		
				li_retval = This.GetChild(ls_ref_2, dwchild)
				IF li_retval = -1 THEN
					ls_reference = ls_reference + " - " + This.GetText()				
				ELSE
					This.SetColumn( ls_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_screen.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							ls_reference = ls_reference + " - " + This.GetText()
						END IF
					else
						ls_reference = ls_reference + " - " + ""
					end if
				END IF
			ELSE
				ls_reference = ls_reference + " - " + ""
			END IF
			
			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
		END IF

		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
		if this.Describe("active_status.ColType") <> "!" then
			li_status = this.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
		end if
		//End Code Change---08.01.2008
		//Start Code Change ---- 10.26.2006 #1 maha
		IF ls_rec_status = "Modified" THEN
			if not isvalid(inv_action_items) then 
				inv_action_items = create pfc_n_cst_ai_action_items
			end if
			inv_action_items.of_update_reference(  ls_reference, ll_rec_id, ll_address_code, ldt_exp_date, li_screen_id, li_status, ll_ver_method)
			inv_data_entry.of_app_audit_update_ref( al_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> 
			IF  pos(as_field_name , ls_exp_field +",")> 0 THEN
				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
			END IF
			//---------------------------- APPEON END ----------------------------
		ELSE  //new
			for t = 1 to li_temp_cnt //check to see if completion is desired
				if li_complete[t] = 1 then 
					openwithparm(w_app_audit_complete_mes,  ls_mess) //asks user to complete and gets response code 
					ls_mess = message.stringparm
					if mid(ls_mess,1,1) = "N" then 
						li_complete[t] = 0
						ll_verif_response = 0
					else //yes
						ll_verif_response = long(mid(ls_mess,3))
					end if	
				else //Start Code Change ---- 05.09.2007 #V7 maha trap so verif does not get completed
					li_complete[t] = 0
					ll_verif_response = 0
				end if
				if li_auto_gen[t] = 1 then  //Start Code Change ---- 05.09.2007 #V7 maha only create if set to auto gen
					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,al_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )   //Start Code Change ----12.05.2016 #V153 maha
				end if
				yield()
			next
			
			if li_table_id = 43 then
				if this.Describe("apptmnt_type.ColType") <> "!" then
					ls_appt_type = this.GetItemString( i, "apptmnt_type" )
					IF ls_appt_type = 'I' THEN
						inv_data_entry.of_generate_attest_questions( "initial", ai_parent_facility_id, al_prac_id, ll_rec_id )		
					END IF
				end if
			end if
			
			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
			debugbreak()
			IF of_add_verif_info( al_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method, li_table_id) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument
				//
				//messagebox("Error","Error adding verification")				
				RETURN -1
			end if
		END IF

	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
	long ll_cnt_new
	select count(1) into :ll_cnt_new from pd_images where prac_id = :al_prac_id and rec_id = :ll_rec_id;
	if (ls_rec_status = "New" and ll_cnt_new = 0) then
		ll_de_queue = long(gnv_data.of_getitem('image_type','de_queue','link_to_screen = ' + string(li_screen_id)))
		//ll_de_queue = 0 //maha changed because it was not working properly
		if ll_de_queue = 1 then
			ll_image_type_id = long(gnv_data.of_getitem('image_type','image_type_id','link_to_screen = ' + string(li_screen_id)))
			ll_default_pages = long(gnv_data.of_getitem('image_type','default_pages','link_to_screen = ' + string(li_screen_id)))

			ll_row = lds_image_data.insertrow(0)
			
			SELECT Max( seq_no )  
			INTO :ll_seq_no  
			FROM pd_images  
			WHERE pd_images.rec_id = :ll_rec_id ;
			
			IF IsNull( ll_seq_no ) THEN
				ll_seq_no = 0
			END IF
			ll_seq_no++
			lds_image_data.SetItem( ll_row, "image_type_id", ll_image_type_id )
			lds_image_data.SetItem( ll_row, "prac_id", al_prac_id )
			lds_image_data.SetItem( ll_row, "seq_no", ll_seq_no )
			lds_image_data.SetItem( ll_row, "rec_id", ll_rec_id  )
			lds_image_data.SetItem( ll_row, "facility_id", ai_parent_facility_id  )	
			lds_image_data.SetItem( ll_row, "screen_id", li_screen_id )	
			lds_image_data.SetItem( ll_row, "reference_name", ls_reference )
			lds_image_data.SetItem( ll_row, "active_status", 1 )	
			lds_image_data.SetItem( ll_row, "num_pages", ll_default_pages )
			lds_image_data.SetItem( ll_row, "tif_start_page", 1 )
			lds_image_data.SetItem( ll_row, "de_queue", 0 )
		end if
	end if
	yield()
	//---------------------------- APPEON END ----------------------------
END FOR

//if inv_data_entry.of_field_audit( This ) = -1 then return -1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<modify> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<modification> 1)Modify the script in the pfc_Save from PT-28.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

lds_image_data.update() //Queue Images for Scanning from Data Entry - Jack 10.12.2006 

DESTROY lds_parent_facilities
DESTROY lds_select_section
DESTROY lds_image_data
//---------------------------- APPEON END ----------------------------

//keep qualified df ids - dataflow: alfee 12.24.2009
//////inv_dataflow.of_set_data_flow(this, li_table_id)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Automatically poping up Verification Update window once
//$<reason> value in exp_field changed.
//String ls_sql_where, ls_rec_id_str, ls_sql_original
//n_ds lds_verify
//gs_verif_update lstr_verif
//
//li_cnt = UpperBound( w_mdi.ii_security_action_id )
//FOR i = 1 TO li_cnt
//	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
//		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
//			Return 1; //No rights	
//		END IF
//	END IF		
//NEXT
//
//li_cnt = UpperBound( ll_rec_id_changed )
//IF li_cnt > 0 THEN
//	FOR i = 1 TO li_cnt
//		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
//	NEXt
//	lds_verify = Create n_ds
//	lds_verify.DataObject = "d_verification_facility_de_update_maha"
//	lds_verify.SetTransObject( SQLCA )
//	lstr_verif.sql_syntax = ""//ls_sql_original
//	lstr_verif.al_prac_id = al_prac_id
//	lstr_verif.al_screen_id = li_screen_id
//	lstr_verif.al_rec_id = ll_rec_id_changed
//	
//	OpenwithParm( w_verification_de_update, lstr_verif )
//END IF
//---------------------------- APPEON END ----------------------------

RETURN 1

end event

event type integer ue_postupdate(long al_prac_id, integer ai_screen, integer ai_table_id, integer ai_parent_facility_id);//////////////////////////////////////////////////////////////////////
// $<Event> ue_postupdate
// $<arguments>
// $<returns> integer
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.10.2013 by Stephen
//////////////////////////////////////////////////////////////////////

//Added for Work Flow trigger
string ls_module
long ll_screen_id[] 

If of_Get_app_setting("set_9" , "I") = 1 Then
	ls_module = '02'
Else
	ls_module = '01'
End if

If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers

	ll_screen_id[1] = ai_screen
	lnv_workflow.of_data_value_comparision( ll_screen_id, al_prac_id, ai_parent_facility_id, ls_module, 'I')
	yield()
	Destroy lnv_workflow
	
End If
inv_dataflow.of_init_data() 
inv_dataflow.of_set_data_flow(this, ai_table_id)
yield()
//run data flow if any - dataflow
inv_dataflow.of_run_data_flow()
yield()
String	ls_table_name
n_cst_notification_alert_upd	lnv_na

ls_table_name = This.Object.DataWindow.Table.UpdateTable
lnv_na.of_update_alert_records(ls_table_name, This)
yield()
Return 1

end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.08.2013 by Stephen
//////////////////////////////////////////////////////////////////////
This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)
//this.of_SetDropDownCalendar( TRUE )
this.of_setupdateable(false) 
end event

type dw_link_list from u_dw within w_import_audit
boolean visible = false
integer x = 2981
integer y = 764
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

type cb_view from commandbutton within w_import_audit
integer x = 3122
integer y = 40
integer width = 293
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View log"
end type

event clicked;
long  ll_row, ll_process
str_size lstr_str

ll_row = dw_list.getrow()
if ll_row < 1 then return

ll_process = dw_list.getitemnumber(ll_row, "process_id")
lstr_str.x = il_import_id
lstr_str.y = ll_process
openwithparm(w_import_audit_log, lstr_str)
end event

type dw_import from datawindow within w_import_audit
integer x = 37
integer y = 56
integer width = 946
integer height = 76
integer taborder = 50
string title = "none"
string dataobject = "d_dddw_import_audit"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_import_audit
integer x = 41
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
string text = "Import Name"
boolean focusrectangle = false
end type

type cb_reset from commandbutton within w_import_audit
integer x = 2199
integer y = 40
integer width = 247
integer height = 92
integer taborder = 40
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

type dw_date_range from u_dw within w_import_audit
integer x = 1024
integer y = 52
integer width = 1175
integer height = 80
integer taborder = 50
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type cb_filter from commandbutton within w_import_audit
integer x = 2501
integer y = 40
integer width = 293
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run &Filter"
end type

event clicked;of_filter_dw()
end event

type cb_close from commandbutton within w_import_audit
integer x = 3429
integer y = 40
integer width = 293
integer height = 92
integer taborder = 30
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

type rb_rejected from radiobutton within w_import_audit
integer x = 2921
integer y = 660
integer width = 549
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
 ll_row = dw_prac.getrow()
 of_filter_detail(ll_row)
end event

type rb_previous from radiobutton within w_import_audit
integer x = 2359
integer y = 660
integer width = 558
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
 ll_row = dw_prac.getrow()
 of_filter_detail(ll_row)
end event

type rb_accept from radiobutton within w_import_audit
integer x = 1883
integer y = 660
integer width = 457
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
boolean checked = true
end type

event clicked;long ll_row
 il_status = 0
 ll_row = dw_prac.getrow()
 of_filter_detail(ll_row)
end event

type rb_all from radiobutton within w_import_audit
integer x = 3470
integer y = 660
integer width = 160
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
end type

event clicked;long ll_row
 il_status = 9
 ll_row = dw_prac.getrow()
 of_filter_detail(ll_row)
end event

type cb_reject from commandbutton within w_import_audit
integer x = 1463
integer y = 640
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reject"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row
integer li_status
string   ls_opt_type
long ll_rec, ll_find
string ls_sql[]
datetime ldt_CurrentTime
string ls_CurrentTime
long   ll_list, ll_prac

SELECT getdate() INTO :ldt_CurrentTime FROM ids;
ls_CurrentTime = string(ldt_CurrentTime, "YYYY-MM-DD HH:MM:SS")

if of_create_ds() = -1 then
	
	return -1
end if

dw_detail.setredraw(false)
dw_detail.setfilter("1=1")
dw_detail.filter()

for ll_list = 1 to dw_prac.rowcount()
	ll_prac = dw_prac.getitemnumber(ll_list, "prac_id")
	dw_detail.setfilter("import_audit_item_prac_id = " +string(ll_prac))
	dw_detail.filter()

	for ll_row = 1 to dw_detail.rowcount()
		li_status = dw_detail.getitemnumber(ll_row, "import_audit_item_status")
		ls_opt_type = dw_detail.getitemstring(ll_row, "opt_type")
		if li_status = 0 and  ls_opt_type = '1'  then
			ll_rec = dw_detail.getitemnumber(ll_row, "import_audit_item_rec_id")
			ll_find = ids_audit_item.find("rec_id = "+string(ll_rec), 1, ids_audit_item.rowcount())
			if ll_find > 0 then
				ids_audit_item.setitem(ll_find, "status", -1)
				ids_audit_item.setitem(ll_find, "audit_by", gs_user_id)
				ids_audit_item.setitem(ll_find, "audit_date", ldt_CurrentTime)
			end if
		end if
	next
next

ids_audit_item.accepttext()
if ids_audit_item.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if
destroy ids_audit_item

ll_row = dw_list.getrow()
ib_check = false

dw_list.event rowfocuschanged(ll_row)
dw_detail.setredraw(true)


end event

type cb_accept from commandbutton within w_import_audit
integer x = 1093
integer y = 640
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Accept "
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> Clicked
// $<arguments>
// $<returns> long
// $<description>V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// $<add> 01.07.2013 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row, ll_count
integer li_status, li_table_id
long ll_rec
string ls_sql[]
string ls_table_name,  ls_table_name_pre, ls_opt_type
long   ll_seq_no, ll_seq_no_pre
string ls_field, ls_field_aar
string ls_value,ls_value_arr
string ls_field_type
long   ll_prac_id
integer li_return
string  ls_new, ls_prac_name

//get table link data
ids_table_record = create datastore
ids_table_record.dataobject = "d_import_audit_tablink"
ids_table_record.settransobject(sqlca)
ids_table_record.retrieve(il_import_id, il_hdr_id)

//Initialize progress bar
ll_count = 0
for ll_row = 1 to dw_prac.rowcount()
	ls_opt_type = dw_prac.getitemstring(ll_row, "opt_type")
	if ls_opt_type <>"1" then continue
	ll_count +=1
next
if ll_count < 1 then return
of_open_processbar(ll_count)
 
 //create audit_item datastore
 li_return = of_create_ds()
if li_return = -1 then return
//create screen datastore
li_return = of_create_screen_ds()
if li_return = -1 then return

//audit data
setnull(is_error)
for ll_row = 1 to dw_prac.rowcount()
	ls_opt_type = dw_prac.getitemstring(ll_row, "opt_type")
	if ls_opt_type <>"1" then continue
	ls_new = dw_prac.getitemstring(ll_row, "new_prac")
	ll_prac_id = dw_prac.getitemnumber(ll_row, "prac_id")
	yield()	
	// Set progress bar	
	if isvalid(w_import_progressbar) then
		w_import_progressbar.of_SkipNextPosition()
		if w_import_progressbar.ib_break then
			w_import_progressbar.cb_close.Enabled = true
			close(w_import_progressbar)
			exit
		else
			ls_prac_name = dw_prac.getitemstring(ll_row, "full_name")
			w_import_progressbar.of_setpracname(ls_prac_name)
			w_import_progressbar.of_setremainprac(ll_count)
			w_import_progressbar.dw_step.ScrolltoRow(1)
			w_import_progressbar.dw_step.object.pic_flag[1] = 1
			ll_count -=1 
		end if
	end if
	//audit data
	li_return = of_audit(ll_prac_id,dw_detail)
	if li_return = -1 then exit
next

// Set progress bar
if isvalid(w_import_progressbar) then w_import_progressbar.of_auditnextstep()
if ids_log_error.update() = 1 and ids_audit_log_table.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if
if isvalid(w_import_progressbar) then
	w_import_progressbar.cb_close.Enabled = true
	close(w_import_progressbar)
end if

if li_return <> -1 then
	if len(is_error) = 0 or isnull(is_error) then
		MessageBox("Prompt", "Accepting data is completed successfully!" )
	else
		MessageBox("Prompt", "Accepting data is completed with some errors. Click the View Log button to check the details." )
	end if
end if

if isvalid(ids_audit_item) then destroy(ids_audit_item)
ll_row = dw_list.getrow()
ib_check = false
dw_list.event rowfocuschanged(ll_row)

end event

type dw_detail from u_dw within w_import_audit
integer x = 1033
integer y = 752
integer width = 2702
integer height = 1476
integer taborder = 30
boolean titlebar = true
string title = "Data"
string dataobject = "d_import_audit_detail"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//              N/A
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.04.2013
//////////////////////////////////////////////////////////////////////

string ls_type
long ll_row, ll_prac_id
long ll_find
boolean lb_select

if row < 1 then return

if dwo.name = "opt_type" then
	ls_type = this.getitemstring(row, "opt_type")
	if ls_type = '1' then
		ls_type = '0'
	else
		ls_type = '1'
	end if
	
	this.setitem(row, "opt_type", ls_type)	
	ll_prac_id = this.getitemnumber(row, "import_audit_item_prac_id")
	ll_find = dw_prac.find("prac_id = "+string(ll_prac_id),1, dw_prac.rowcount())
		
	if ls_type = "1" then
		
		if ll_find > 0 then
			ls_type = dw_prac.getitemstring(ll_find, "opt_type")
			if ls_type <> "1" then
				dw_prac.setitem(ll_find, "opt_type", "1")
			end if
		end if
	else
		lb_select = false
		for ll_row = 1 to this.rowcount()
			if this.object.opt_type[ll_row] = '1' then
				lb_select = true
				continue
			end if
		next
			if lb_select = false then				
				if ll_find > 0 then
					ls_type = dw_prac.getitemstring(ll_find, "opt_type")
					if ls_type <> "0" then
						dw_prac.setitem(ll_find, "opt_type", "0")
					end if
				end if
			end if
	end if
end if

end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//              currentrow
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.04.2013
//////////////////////////////////////////////////////////////////////

if currentrow < 1 then return
this.selectrow(0, false)
this.selectrow(currentrow, true)
end event

type dw_prac from u_dw within w_import_audit
integer x = 32
integer y = 752
integer width = 987
integer height = 1476
integer taborder = 20
boolean titlebar = true
string title = "Practitioner"
string dataobject = "d_import_audit_prac_list"
end type

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//               long currentrow
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.03.2013
//////////////////////////////////////////////////////////////////////
long  ll_prac_id
string ls_filter

if currentrow < 1 then
	if this.rowcount() < 1 then
		dw_detail.reset()
	end if
	return
end if

this.selectrow(0, false)
this.selectrow(currentrow, true)

of_filter_detail(currentrow)
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//               long currentrow
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.03.2013
//////////////////////////////////////////////////////////////////////

string ls_type
long ll_row
integer li_status

if row < 1 then return

this.selectrow(0, false)
this.selectrow(row, true)

this.event rowfocuschanged(row)

//of_filter_detail(row)

if dwo.name = "opt_type" then
	ls_type = this.getitemstring(row, "opt_type")
	if ls_type = '1' then
		ls_type = '0'
	else
		ls_type = '1'
	end if
	
	this.setitem(row, "opt_type", ls_type)
	for ll_row = 1 to dw_detail.rowcount()
		li_status = dw_detail.getitemnumber(ll_row, "import_audit_item_status")
		if li_status = 0 then
			dw_detail.setitem(ll_row, "opt_type", ls_type)
		end if
	next
end if

end event

event constructor;call super::constructor;this.of_setupdateable(false) 
end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
//              N/A
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.03.2013
//////////////////////////////////////////////////////////////////////

string ls_type
long ll_row
integer li_status

if this.rowcount() < 1 then return

if dwo.name = "b_1" then
	if this.object.b_1.text = 'Select All' then
		ls_type = '1'
		this.object.b_1.text = 'Deselect All' 
	else
		ls_type = '0'
		this.object.b_1.text = 'Select All' 
	end if
	
	for ll_row = 1 to this.rowcount()
		this.setitem(ll_row, "opt_type", ls_type)
	next	
	
	dw_detail.setredraw(false)
	if il_status <> 9 then
		dw_detail.setfilter("import_audit_item_status = " + string(il_status))
	else
		dw_detail.setfilter("1=1")
	end if
	dw_detail.filter()	
	for ll_row = 1 to dw_detail.rowcount()
		li_status = dw_detail.getitemnumber(ll_row, "import_audit_item_status")
		if li_status = 0 then
			dw_detail.setitem(ll_row, "opt_type", ls_type)
		end if
	next	
	ll_row = row
	if ll_row < 1 or isnull(ll_row) then ll_row = 1
	this.event clicked(1,1,ll_row, this.object.datawindow)
	
	dw_detail.setredraw(true)
end if

end event

type dw_list from datawindow within w_import_audit
integer x = 32
integer y = 156
integer width = 3707
integer height = 444
integer taborder = 10
string title = "none"
string dataobject = "d_import_audit_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//               long currentrow
// $<returns> (long)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.02.2013
//////////////////////////////////////////////////////////////////////
long ll_process_id, ll_row

if currentrow < 1 then
	if this.rowcount() < 1 then
		dw_prac.reset()
		dw_detail.reset()
		setnull(il_hdr_id)
	end if
	return
end if

this.selectrow(0, false)
this.selectrow(currentrow, true)
il_hdr_id = this.getitemnumber(currentrow, "hdr_id")
il_import_id = this.getitemnumber(currentrow, "import_id")
ll_process_id = this.getitemnumber(currentrow, "process_id")

gnv_appeondb.of_startqueue( )
ids_audit_log_table.retrieve(ll_process_id)
parent.setredraw(false)
dw_prac.retrieve(il_hdr_id)
dw_detail.retrieve(il_hdr_id)

ids_prac_change.retrieve(il_hdr_id)
ids_audit_facility.retrieve(il_hdr_id) //(Appeon)Stephen 05.06.2015 - V15.1-Import Improvements 2015
gnv_appeondb.of_CommitQueue( )

dw_detail.setfilter("")
dw_detail.filter()

of_dddw_field(dw_detail)
of_filter_prac()
if ib_check = true then
	for ll_row = 1 to dw_prac.rowcount()
		dw_prac.setitem(ll_row, "opt_type", "1")
	next
	
	for ll_row = 1 to dw_detail.rowcount()
		dw_detail.setitem(ll_row, "opt_type", "1")
	next
else
	dw_prac.modify("b_1.text = 'Select All'")
end if
ib_check = true

if dw_prac.rowcount() > 0 then
	dw_prac.event rowfocuschanged(1)
end if
parent.setredraw(true)



end event

event constructor;this.settransobject(sqlca)

end event

event clicked;long ll_row

if row <1 then return
this.selectrow(0, false)
this.selectrow(row, true)


end event

type gb_1 from groupbox within w_import_audit
integer x = 1797
integer y = 600
integer width = 1842
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Data Filter"
end type

type gb_2 from groupbox within w_import_audit
integer x = 1010
integer width = 1463
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Date Range"
end type

