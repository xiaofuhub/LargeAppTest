$PBExportHeader$w_wv_audit_trail.srw
forward
global type w_wv_audit_trail from pfc_w_response
end type
type st_select from statictext within w_wv_audit_trail
end type
type dw_select from datawindow within w_wv_audit_trail
end type
type dw_prac_facil from datawindow within w_wv_audit_trail
end type
type cb_close from commandbutton within w_wv_audit_trail
end type
type dw_link_list from datawindow within w_wv_audit_trail
end type
type dw_addresses from u_dw within w_wv_audit_trail
end type
type tab_1 from tab within w_wv_audit_trail
end type
type tabpage_1 from userobject within tab_1
end type
type gb_opt1 from groupbox within tabpage_1
end type
type dw_pd_images1 from u_dw within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type cb_reject1 from commandbutton within tabpage_1
end type
type cb_skip1 from commandbutton within tabpage_1
end type
type cb_accept1 from commandbutton within tabpage_1
end type
type cb_audit from commandbutton within tabpage_1
end type
type dw_audit1 from u_dw within tabpage_1
end type
type rb_de1 from radiobutton within tabpage_1
end type
type rb_doc1 from radiobutton within tabpage_1
end type
type dw_list1 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_opt1 gb_opt1
dw_pd_images1 dw_pd_images1
st_1 st_1
cb_reject1 cb_reject1
cb_skip1 cb_skip1
cb_accept1 cb_accept1
cb_audit cb_audit
dw_audit1 dw_audit1
rb_de1 rb_de1
rb_doc1 rb_doc1
dw_list1 dw_list1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_pd_images2 from u_dw within tabpage_2
end type
type rb_de2 from radiobutton within tabpage_2
end type
type st_2 from statictext within tabpage_2
end type
type cb_reject2 from commandbutton within tabpage_2
end type
type cb_skip2 from commandbutton within tabpage_2
end type
type cb_accept2 from commandbutton within tabpage_2
end type
type cb_next from commandbutton within tabpage_2
end type
type dw_audit2 from u_dw within tabpage_2
end type
type gb_opt2 from groupbox within tabpage_2
end type
type dw_list2 from u_dw within tabpage_2
end type
type rb_doc2 from radiobutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_pd_images2 dw_pd_images2
rb_de2 rb_de2
st_2 st_2
cb_reject2 cb_reject2
cb_skip2 cb_skip2
cb_accept2 cb_accept2
cb_next cb_next
dw_audit2 dw_audit2
gb_opt2 gb_opt2
dw_list2 dw_list2
rb_doc2 rb_doc2
end type
type tabpage_3 from userobject within tab_1
end type
type dw_audit3 from u_dw within tabpage_3
end type
type dw_list3 from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_audit3 dw_audit3
dw_list3 dw_list3
end type
type tabpage_4 from userobject within tab_1
end type
type cb_lookup from commandbutton within tabpage_4
end type
type dw_lookup_main from u_dw within tabpage_4
end type
type dw_lookup_list from u_dw within tabpage_4
end type
type dw_lookup_detail from u_dw within tabpage_4
end type
type dw_lookup_search from u_dw within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_lookup cb_lookup
dw_lookup_main dw_lookup_main
dw_lookup_list dw_lookup_list
dw_lookup_detail dw_lookup_detail
dw_lookup_search dw_lookup_search
end type
type tab_1 from tab within w_wv_audit_trail
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type dw_detail from u_dw within w_wv_audit_trail
end type
end forward

global type w_wv_audit_trail from pfc_w_response
integer width = 4535
integer height = 2404
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
st_select st_select
dw_select dw_select
dw_prac_facil dw_prac_facil
cb_close cb_close
dw_link_list dw_link_list
dw_addresses dw_addresses
tab_1 tab_1
dw_detail dw_detail
end type
global w_wv_audit_trail w_wv_audit_trail

type variables
integer ii_screen_id
long il_prac_id, il_rec_id
long  il_rec_id_spe = 0
long il_facility = 0  //maha 05.17.2016
string is_sql_syntax
string is_sql_err
boolean ib_edit = false
boolean ib_addaddress = false
boolean ib_audit_doc1 = false //(V15.1 WV Audit of Images) - Alfee 08.07.2015
boolean ib_audit_doc2 = false //(V15.1 WV Audit of Images) - Alfee 08.07.2015

datastore ids_pd_images //(V15.1 WV Audit of Images) - Alfee 08.14.2015
u_dw     idw_audit_detail

pfc_cst_nv_data_entry_functions inv_data_entry
pfc_n_cst_ai_action_items inv_action_items


end variables

forward prototypes
public function integer of_retrieve_dw (integer ai_tab)
public function integer of_dddw_field (u_dw adw_detail)
public function integer of_audit_list_clicked (integer ai_tab, long al_row, u_dw adw_list, u_dw adw_detail)
public function integer of_create_insertdata (integer ai_tab, u_dw adw_audit)
public function integer of_update_detail ()
public function integer of_audit (integer ai_tab, u_dw adw_detail)
public function integer of_update_screen (long al_row, u_dw adw_detail)
public function integer of_update_address_link (string as_opt_type, long al_prac_id, long al_address_id)
public function integer of_update_hosp_link (string as_opt_type, long al_prac_id, long al_seq_no)
public function integer of_update_spec_link (string as_opt_type, long al_prac_id, long al_seq_no)
public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method)
public function integer of_create_dynamic_dw (integer ai_tab, long al_row, u_dw adw_detail, string as_type)
public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess)
public function integer of_audit_update_accept (u_dw adw_detail, long al_row)
public function integer of_lookup_accept (u_dw adw_detail, u_dw adw_list)
public function long of_get_next_seq_no (string as_dw, long al_rec_id)
public function integer of_update_screen_new (string as_table_name, long al_seq_no, u_dw adw_detail)
public function integer of_audit_new (integer ai_tab, u_dw adw_detail)
public function integer of_create_dynamic_dw_new (integer ai_tab, long al_row, u_dw adw_detail, string as_type, long al_seq_no, string as_rec_id_sql)
public function integer of_adjust_ui ()
public function integer of_change_dw (string as_opt)
public function integer of_retrieve_dw_doc (integer ai_tab)
public function integer of_retrieve_detail_doc (long al_row, u_dw adw_list, u_dw adw_detail)
public function integer of_audit_rowfocuschanged (integer ai_tab, long al_currentrow)
public function integer of_get_image (long al_image_pk, ref blob ablb_image_data, boolean ab_wv_image)
public function integer of_audit_image (integer ai_tab, u_dw adw_detail)
public function integer of_insert_image (u_dw adw_detail, long al_row)
public function integer of_filter_by_facility (u_dw adw_list)
public function integer of_display_image (long al_image_pk, long al_prac_id, boolean ab_wv_image, string as_file_name)
public function integer of_resize ()
end prototypes

public function integer of_retrieve_dw (integer ai_tab);//////////////////////////////////////////////////////////////////////
// $<Function> of_retrieve_dw
// $<arguments>
// $<returns> integer
// $<description>Retrieve data  (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_row, ll_prac_id
string ls_type[]
u_dw  ldw_list, ldw_detail
string ls_fullname, ls_fullname_old
string  ls_code
long    ll_lookup_code

if (ai_tab = 1 and ib_audit_doc1 ) or (ai_tab = 2 and ib_audit_doc2) then
	return of_retrieve_dw_doc(ai_tab)	//(V15.1 WV Audit of Images) - Alfee 08.07.2015
end if


choose case ai_tab
	case 1
		ldw_list =  tab_1.tabpage_1.dw_list1
		ldw_detail = tab_1.tabpage_1.dw_audit1
		ls_type[1] = 'I-W'
		ls_type[2] = 'E-W'
		
		ldw_list.setredraw( false) //Start Code Change ----05.17.2016 #V15 maha
		ldw_list.retrieve(ls_type, gs_user_id) //(Appeon)Stephen 07.21.2015 - add 'gs_user_id' NYHH requests
		
	case 2
		ldw_list =  tab_1.tabpage_2.dw_list2
		ldw_detail = tab_1.tabpage_2.dw_audit2
		ls_type[1] = 'IQW'
		ls_type[2] = 'EQW'
		ls_type[3] = 'QQW'
		
		ldw_list.setredraw( false) //Start Code Change ----05.17.2016 #V15 maha
		ldw_list.retrieve(ls_type, gs_user_id) //(Appeon)Stephen 07.21.2015 - add 'gs_user_id' NYHH requests

	case 3
		ldw_list =  tab_1.tabpage_3.dw_list3
		ldw_detail = tab_1.tabpage_3.dw_audit3
		ls_type[1] = 'INW'
		ls_type[2] = 'ENW'
		
		ldw_list.setredraw( false) //Start Code Change ----05.17.2016 #V15 maha
		ldw_list.retrieve(ls_type, gs_user_id) //(Appeon)Stephen 07.21.2015 - add 'gs_user_id' NYHH requests
		
		for ll_row = ldw_list.rowcount() to 1 step -1
			ls_fullname = ldw_list.getitemstring(ll_row, 'v_full_name_full_name')
			if isnull(ls_fullname_old) then
				ls_fullname_old = ls_fullname
				continue
			end if
			
			if ls_fullname = ls_fullname_old then
				ldw_list.deleterow(ll_row)
			end if
			ls_fullname_old = ls_fullname
		next
		
	case 4
		ldw_list =  tab_1.tabpage_4.dw_lookup_list
		ldw_detail = tab_1.tabpage_4.dw_lookup_detail
		ldw_list.retrieve()
		if ldw_list.rowcount() > 0 then
			 ldw_list.scrolltorow(1)
			 ldw_list.selectrow(0, false)
			 ldw_list.selectrow(1, true) 
			 ls_code = ldw_list.getitemstring(1, "code")
			 ll_lookup_code = ldw_list.getitemnumber(1, "lookup_code")
			 ldw_detail.retrieve(ls_code, ll_lookup_code)
		end if
		this.title = 'Audit Trail - Practitioner Add Lookups'
		return 1
end choose

for ll_row = ldw_list.rowcount() to 1 step -1
	if isnull(ldw_list.getitemnumber(ll_row, 'v_full_name_prac_id')) then ldw_list.deleterow(ll_row)
next

//Start Code Change ----05.17.2016 #V15 maha
if isvalid( ldw_list) then
	if ai_tab < 4 then   //Start Code Change ----03.21.2017 #V153 maha - no filter on lookups
		of_filter_by_facility( ldw_list)
		ldw_list.setredraw( true)
	end if
end if
//End Code Change ----05.17.2016 

ldw_detail.setredraw(false)
if ldw_list.rowcount() > 0 then
	 ldw_list.scrolltorow(1)
	 ldw_list.selectrow(0, false)
	 ldw_list.selectrow(1, true) 
	 
	ll_prac_id = ldw_list.getitemnumber(1,'v_full_name_prac_id')
	ldw_detail.retrieve(ls_type, ll_prac_id)	
	
	for ll_row = 1 to ldw_detail.rowcount()
		ldw_detail.setitem(ll_row, 'opt_type', 'Accept')
	next
	
	of_create_insertdata(ai_tab, ldw_detail)
else
	ldw_detail.reset()
end if
this.title = 'Audit Trail - Approve or Reject Practitioner Data Entry Only'

of_dddw_field(ldw_detail)
ldw_detail.setredraw(true)

return 1
end function

public function integer of_dddw_field (u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_dddw_field
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB   (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_field_type, ls_lookup_name
long ll_row, ll_rec, ll_j
string ls_lookup_code, ls_lookup_code_old
string ls_field, ls_type, ls_value
string ls_sql, ls_table
datastore lds_lookup_new[]
datastore lds_lookup_old[]
string  ls_syntax, ls_error_create, ls_error_syntax
string ls_lookup_new[],ls_type_list[],ls_lookup_old[]
boolean lb_lookup
string   ls_sel_col

ll_j = 1
for ll_row = 1 to adw_detail.rowcount()
	ls_field_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		adw_detail.setitem(ll_row, 'new_value',  adw_detail.getitemstring(ll_row, 'sys_audit_new_value'))
		adw_detail.setitem(ll_row, 'old_value',  adw_detail.getitemstring(ll_row, 'sys_audit_old_value'))
		continue
	end if
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'sys_audit_new_value')
	
	//---------Begin Modified by (Appeon)Stephen 07.10.2015 for Allegheny Issue accepting data from webview audit--------
	//if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	if isnull(ls_lookup_code) or ls_lookup_code = '' then 
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'sys_audit_old_value')
		if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	end if
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'sys_audit_new_value')
	//---------End Modfiied ------------------------------------------------------
	
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	ls_lookup_name = ''
	ls_lookup_name = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	ll_rec = adw_detail.getitemnumber(ll_row, 'sys_audit_rec_id') 
	if ls_type = 'A' then
		ls_table = 'address_lookup' 
		ls_sel_col = 'lookup_code'
		//if ls_lookup_name = 'Description' then ls_lookup_name = 'Entity_Name'
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_table = 'question_lookup'
		ls_sel_col = 'quest_id'
		ls_lookup_name = 'short_quest'
	else
		ls_table = 'code_lookup'
		ls_sel_col = 'lookup_code'
		ls_lookup_name = 'description'
	end if

    //if isnull(ls_lookup_code) then ls_lookup_code =''
	if isnull(ls_lookup_code) or Trim(ls_lookup_code) = '' then ls_lookup_code = '0' //For Error converting data type varchar to numeric db error, Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)
	
	ls_sql = "select " + ls_lookup_name + " from " + ls_table + " where " + ls_sel_col+" = '"+ls_lookup_code+"'"
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql,  'Style(Type=Form)', ls_error_syntax)
	IF Len(ls_error_syntax) > 0 THEN
		messagebox('prompt', ls_error_syntax)
		for ll_j = 1 to upperbound(lds_lookup_new) 
			destroy lds_lookup_new[ll_j]
			destroy lds_lookup_old[ll_j]
		next
		return -1
	ELSE
		 // Generate new DataWindow
		 lds_lookup_new[ll_j] = create datastore
	     lds_lookup_new[ll_j].Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			messagebox('prompt', ls_error_create)
			for ll_j = 1 to upperbound(lds_lookup_new) 
				destroy lds_lookup_new[ll_j]
				destroy lds_lookup_old[ll_j]
			next
			return -1
		END IF
	end if
	ls_lookup_new[ll_j] = ls_lookup_code
	
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'sys_audit_old_value')
	
	//if isnull(ls_lookup_code) then ls_lookup_code = ''
	if isnull(ls_lookup_code) or Trim(ls_lookup_code) = '' then ls_lookup_code = '0' //For Error converting data type varchar to numeric db error, Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)	
	
	ls_sql = "select " + ls_lookup_name + " from " + ls_table +  " where " + ls_sel_col+" = '"+ls_lookup_code+"'"
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql,  'Style(Type=Form)', ls_error_syntax)
	IF Len(ls_error_syntax) > 0 THEN
		messagebox('prompt', ls_error_syntax)
		for ll_j = 1 to upperbound(lds_lookup_old) 
			destroy lds_lookup_new[ll_j]
			destroy lds_lookup_old[ll_j]
		next
		return -1
	ELSE
		 // Generate new DataWindow
		 lds_lookup_old[ll_j] = create datastore
	     lds_lookup_old[ll_j].Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			messagebox('prompt', ls_error_create)
			for ll_j = 1 to upperbound(lds_lookup_old) 
				destroy lds_lookup_new[ll_j]
				destroy lds_lookup_old[ll_j]
			next
			return -1
		END IF
	end if

	ls_lookup_old[ll_j] = ls_lookup_code
	ls_type_list[ll_j] = ls_type
	ll_j++
next

gnv_appeondb.of_startqueue()
for ll_j = 1 to upperbound(ls_type_list)
	lds_lookup_new[ll_j].settransobject(sqlca)
	lds_lookup_old[ll_j].settransobject(sqlca)
	
	lds_lookup_new[ll_j].retrieve()
	lds_lookup_old[ll_j].retrieve()
next
gnv_appeondb.of_CommitQueue()

for ll_row = 1 to adw_detail.rowcount()
	ls_field_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		adw_detail.setitem(ll_row, 'new_value',  adw_detail.getitemstring(ll_row, 'sys_audit_new_value'))
		adw_detail.setitem(ll_row, 'old_value',  adw_detail.getitemstring(ll_row, 'sys_audit_old_value'))
		continue
	end if
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'sys_audit_new_value')
	ls_lookup_code_old = adw_detail.getitemstring(ll_row, 'sys_audit_old_value')  //add by stephen 03.27.2012 -fax bug BugS032701
	//---------Begin Modified by (Appeon)Stephen 02.03.2017 for Bug id 5483 - WebView Audit Values not showing--------
	//if isnull(ls_lookup_code) then ls_lookup_code = '' 
	//if isnull(ls_lookup_code_old) then ls_lookup_code_old = '' 
	if isnull(ls_lookup_code) or ls_lookup_code = ''  then ls_lookup_code = '0'
	if isnull(ls_lookup_code_old) or ls_lookup_code_old = ''  then ls_lookup_code_old = '0'
	//---------End Modfiied ------------------------------------------------------
	
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	ls_lookup_name = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	if ls_type = 'A' then
		//if ls_lookup_name = 'Description' then ls_lookup_name = 'Entity_Name'
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_lookup_name = 'short_quest'
	else
		ls_lookup_name = 'description'
	end if
	
	lb_lookup = false
	for ll_j = 1 to upperbound(ls_type_list)
		if ls_lookup_code = ls_lookup_new[ll_j] and ls_type = ls_type_list[ll_j] and ls_lookup_code_old = ls_lookup_old[ll_j] then
			lb_lookup = true
			exit
		end if
	next
	
	if lb_lookup = false then continue
	if lds_lookup_new[ll_j].rowcount() > 0 then
		ls_value = lds_lookup_new[ll_j].getitemstring(1,ls_lookup_name)
		adw_detail.setitem(ll_row, 'new_value', ls_value)
	end if
	
	
	if lds_lookup_old[ll_j].rowcount() > 0 then
		ls_value = lds_lookup_old[ll_j].getitemstring(1,ls_lookup_name)
		adw_detail.setitem(ll_row, 'old_value', ls_value)
	end if
next

for ll_j = 1 to upperbound(lds_lookup_old) 
	destroy lds_lookup_new[ll_j]
	destroy lds_lookup_old[ll_j]
next
			
return 1
end function

public function integer of_audit_list_clicked (integer ai_tab, long al_row, u_dw adw_list, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_audit_list_clicked
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.26.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_row, ll_prac_id
string ls_type[]

if al_row < 1 then return 0

//---------Begin Added by (V15.1 WV Audit of Images) Alfee 08.10.2015-----------
if (ai_tab = 1 and ib_audit_doc1 ) or (ai_tab = 2 and ib_audit_doc2) then
	return of_retrieve_detail_doc(al_row, adw_list, adw_detail )
end if
//---------End Added ---------------------------------------------------------------------

if of_update_detail() = -1 then return -1

adw_list.selectrow(0,false)
adw_list.scrolltorow(al_row)
adw_list.selectrow(al_row, true)

ll_prac_id = adw_list.getitemnumber(al_row,'v_full_name_prac_id')
choose case ai_tab
	case 1
		ls_type[1] = 'I-W'
		ls_type[2] = 'E-W'
	case 2
		ls_type[1] = 'IQW'
		ls_type[2] = 'EQW'
		ls_type[3] = 'QQW'
	case 3
		ls_type[1] = 'INW'
		ls_type[2] = 'ENW'
end choose

adw_detail.setredraw(false)
adw_detail.retrieve(ls_type, ll_prac_id)	

if ai_tab <> 3 then
	for ll_row = 1 to adw_detail.rowcount()
		adw_detail.setitem(ll_row, 'opt_type', 'Accept')
	next
end if

of_create_insertdata(ai_tab, adw_detail)

of_dddw_field(adw_detail)
adw_detail.setredraw(true)

return 1
end function

public function integer of_create_insertdata (integer ai_tab, u_dw adw_audit);//////////////////////////////////////////////////////////////////////
// $<Function> of_create_insertdata
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB   (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long   ll_screenid, ll_seq_no
long   ll_table_id, ll_prac_id
string ls_tablename
string ls_syntax, ls_sql, ls_cur
string ls_error_syntax, ls_error_create
string ls_field, ls_allias, ls_field_type
datastore lds_insert_data[]
long  ll_row, ll_insert, ll_cnt, ll_i
string  ls_type, ls_userid
datetime ldt_modify
datastore lds_audit
string  ls_lookup_field, ls_lookup_type, ls_audit_type[]
string  ls_lookup_field_name
datastore lds_visible_field[]
long ll_table[], ll_seq[], ll_screen[]
long ll_j
boolean lb_audit

if adw_audit.rowcount() < 1 then return 0

adw_audit.setredraw(false)
lds_audit = create datastore
lds_audit.dataobject = adw_audit.dataobject

if ai_tab = 2 then
	for ll_row = adw_audit.rowcount() to 1 step -1
		if adw_audit.getitemstring(ll_row, "sys_audit_audit_type") <> 'QQW' then CONTINUE
		ll_seq_no = adw_audit.getitemnumber(ll_row, "sys_audit_seq_no")
		ls_tablename = adw_audit.getitemstring(ll_row, "sys_tables_table_name")
		ll_cnt = adw_audit.find("sys_tables_table_name = '"+ls_tablename+"' and sys_audit_seq_no = "+string(ll_seq_no)+" and sys_audit_audit_type = 'IQW' ",1, adw_audit.rowcount())
		IF ll_cnt < 1 then adw_audit.deleterow(ll_row)
	next
	
	adw_audit.setredraw(true)
	destroy lds_audit
	return 1
end if

adw_audit.rowscopy(1, adw_audit.rowcount(),primary!, lds_audit,1, primary!)

ll_j = 1
for ll_row = 1 to lds_audit.rowcount()
	ls_type = lds_audit.getitemstring(ll_row, 'sys_audit_audit_type')
	if isnull(ls_type) then ls_type = ''
	if not(ls_type = 'I-W' or ls_type = 'INW') then
		continue
	end if
	
	ls_tablename = lds_audit.getitemstring(ll_row, 'sys_tables_table_name')
	ll_screenid = lds_audit.getitemnumber(ll_row, 'sys_audit_screen_id')
	ll_table_id =  lds_audit.getitemnumber(ll_row, 'sys_audit_table_id')
	ll_seq_no = lds_audit.getitemnumber(ll_row, 'sys_audit_seq_no')
	
	ls_sql = 'select * from ' + ls_tablename + ' where rec_id = ' + string(ll_seq_no)
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql,  'Style(Type=Form)', ls_error_syntax)
	IF Len(ls_error_syntax) > 0 THEN
		messagebox('prompt', ls_error_syntax)
		for ll_j = 1 to upperbound(lds_insert_data) 
			destroy lds_insert_data[ll_j]
			destroy lds_visible_field[ll_j]
		next
		return -1
	ELSE
		 // Generate new DataWindow
		 lds_insert_data[ll_j] = create datastore
	     lds_insert_data[ll_j].Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			messagebox('prompt', ls_error_create)
			for ll_j = 1 to upperbound(lds_insert_data) 
				destroy lds_insert_data[ll_j]
				destroy lds_visible_field[ll_j]
			next
			return -1
		END IF
		lds_insert_data[ll_j].settransobject(sqlca)
		lds_visible_field[ll_j] = create datastore
		lds_visible_field[ll_j].dataobject = "d_audit_visible_field"
		lds_visible_field[ll_j].settransobject(sqlca)
		ll_table[ll_j] = ll_table_id
		ll_seq[ll_j] = ll_seq_no
		ll_screen[ll_j] = ll_screenid
		ll_j++
	END IF
next

gnv_appeondb.of_startqueue()
for ll_j = 1 to upperbound(ll_seq)
	lds_insert_data[ll_j].retrieve()
	lds_visible_field[ll_j].retrieve(ll_screen[ll_j], ll_table[ll_j])
next
gnv_appeondb.of_CommitQueue()

ll_cnt = 1
for ll_row = 1 to lds_audit.rowcount()
	ls_type = lds_audit.getitemstring(ll_row, 'sys_audit_audit_type')
	if isnull(ls_type) then ls_type = ''
	if not(ls_type = 'I-W' or ls_type = 'INW') then
		continue
	end if
	
	ls_tablename = lds_audit.getitemstring(ll_row, 'sys_tables_table_name')
	ll_screenid = lds_audit.getitemnumber(ll_row, 'sys_audit_screen_id')
	ll_table_id =  lds_audit.getitemnumber(ll_row, 'sys_audit_table_id')
	ll_seq_no = lds_audit.getitemnumber(ll_row, 'sys_audit_seq_no')
	ls_userid = lds_audit.getitemstring(ll_row, 'sys_audit_user_id')
	ldt_modify = lds_audit.getitemdatetime(ll_row, 'sys_audit_date_time_modified') 
	
	lb_audit = false
	for ll_j = 1 to upperbound(ll_seq)
		if ll_screenid = ll_screen[ll_j] and ll_table_id = ll_table[ll_j] and ll_seq_no = ll_seq[ll_j] then
			lb_audit = true
			exit
		end if
	next
	
	if lb_audit = false then continue
	for ll_i = 1 to lds_visible_field[ll_j].rowcount()
		ls_field = lds_visible_field[ll_j].getitemstring(ll_i, "field_name")
		ls_allias = lds_visible_field[ll_j].getitemstring(ll_i, "field_label") 
		ls_field_type = lds_visible_field[ll_j].getitemstring(ll_i, "field_type") 
		ls_lookup_field = lds_visible_field[ll_j].getitemstring(ll_i, "lookup_field") 
		ls_lookup_type = lds_visible_field[ll_j].getitemstring(ll_i, "lookup_type") 
		ls_lookup_field_name = lds_visible_field[ll_j].getitemstring(ll_i, "lookup_field_name") 
		
		ll_insert = adw_audit.insertrow(ll_row + ll_cnt)
		adw_audit.setitem(ll_insert, 'sys_fields_field_name_allias', ls_allias)
		if lds_insert_data[ll_j].rowcount() >0  then
			choose case ls_field_type
				case 'N','I'
					adw_audit.setitem(ll_insert, 'sys_audit_new_value', string(lds_insert_data[ll_j].getitemnumber(1, ls_field )))
				case 'C'
					adw_audit.setitem(ll_insert, 'sys_audit_new_value', lds_insert_data[ll_j].getitemstring(1, ls_field ))
				case 'D'
					adw_audit.setitem(ll_insert, 'sys_audit_new_value', string(lds_insert_data[ll_j].getitemdatetime(1, ls_field ),'mm/dd/yyyy'))
			end choose
		end if 
		adw_audit.setitem(ll_insert, 'sys_audit_table_id', ll_table_id)
		adw_audit.setitem(ll_insert, 'sys_audit_screen_id', ll_screenid)
		adw_audit.setitem(ll_insert, 'sys_tables_table_name', ls_tablename)
		adw_audit.setitem(ll_insert, 'sys_audit_seq_no', ll_seq_no)
		adw_audit.setitem(ll_insert, 'sys_audit_user_id', ls_userid)
		adw_audit.setitem(ll_insert, 'sys_audit_date_time_modified', ldt_modify)
		adw_audit.setitem(ll_insert, 'sys_fields_lookup_type', ls_lookup_type)
		adw_audit.setitem(ll_insert, 'sys_fields_lookup_field', ls_lookup_field)
		adw_audit.setitem(ll_insert, 'sys_fields_lookup_field_name', ls_lookup_field_name)
		ll_cnt +=1
	next
	
next

adw_audit.setredraw(true)
destroy lds_audit
for ll_j = 1 to upperbound(lds_insert_data) 
	destroy lds_insert_data[ll_j]
	destroy lds_visible_field[ll_j]
next
return 1
end function

public function integer of_update_detail ();//////////////////////////////////////////////////////////////////////
// $<function> of_update_detail
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_facility
long     ll_row
string   ls_audit_type
string   ls_field_name
string   ls_old_value, ls_new_value //(V15 DE Update) alfee 11.16.2016

if ib_edit then
	if dw_detail.accepttext() = -1 then return -1
	if dw_detail.modifiedcount() > 0 then
		ll_row = idw_audit_detail.getrow()
		if ll_row > 0 then
			li_facility      =   idw_audit_detail.getitemnumber(ll_row, "sys_audit_facility_id") 
			ls_audit_type = idw_audit_detail.getitemstring(ll_row, "sys_audit_audit_type") 
			ls_field_name = idw_audit_detail.getitemstring(ll_row, "sys_fields_field_name")
			ls_old_value = idw_audit_detail.getitemstring(ll_row, "sys_audit_old_value") //(V15 DE Update) alfee 11.16.2016
			ls_new_value = idw_audit_detail.getitemstring(ll_row, "sys_audit_new_value") //(V15 DE Update) alfee 11.16.2016
			
//			if super::event pfc_save() <> 1 then return -1   //Commented by (Appeon)Stephen 11.09.2015 - Questions on Audit trail
			//dw_detail.event ue_update(ls_audit_type, li_facility, ls_field_name)
			dw_detail.event ue_update(ls_audit_type, li_facility, ls_field_name, ls_old_value, ls_new_value) //(V15 DE Update) alfee 11.16.2016
			
			if dw_detail.visible = false then //modify by stephen 04.09.2012 --BugS040102
				if dw_detail.update()	= 1  then  
					if of_audit_update_accept(idw_audit_detail, ll_row) = -1 then 
						rollback using sqlca;
						return -1
					end if
					commit using sqlca;
				else
					rollback using sqlca;
					return -1
				end if
			else
				if dw_detail.update()	<> 1 then
					rollback using sqlca;
					return -1
				else  //(Appeon)Stephen 01.20.2016 - V14.2 Bug # 4936 - Transaction error when you edit WebView audit data
					commit using sqlca;
				end if
			end if
		end if
	end if
	ib_edit = false
	idw_audit_detail.visible = true
	dw_detail.visible = false
	this.setredraw(true)
end if
return 1
end function

public function integer of_audit (integer ai_tab, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_audit
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_cnt, ll_rec_id,ll_screen_id
string ls_opt_type, ls_audit_type
datetime ldt_date
long ll_table_id, ll_seq_no
string ls_table_name, ls_sql, ls_value_old
string ls_field_type, ls_value_new
integer  li_pos
datetime ldt_value_date
string  ls_field
long  ll_field_id, ll_prac_id

if adw_detail.accepttext() = -1 then return -1

if ib_edit then
	if of_update_detail() = -1 then return -1
	of_retrieve_dw(ai_tab)
	return 1
end if

if adw_detail.rowcount() < 1 then return -1
ldt_date = datetime( today(),now())

ll_cnt = messagebox('Prompt', 'Are you sure you want to perform the selected action for each audit record?',question!, YesNo!, 1)
if ll_cnt = 2 then return -1

for ll_cnt = 1 to adw_detail.rowcount()
	ls_audit_type = adw_detail.getitemstring(ll_cnt, "sys_audit_audit_type")
	if isnull(ls_audit_type) or ls_audit_type = '' or ls_audit_type = 'QQW' then continue
	ls_opt_type = adw_detail.getitemstring(ll_cnt, "opt_type") 
	ll_rec_id     = adw_detail.getitemnumber(ll_cnt, "sys_audit_rec_id") 
	ll_table_id   = adw_detail.getitemnumber(ll_cnt, "sys_audit_table_id") 
	ll_seq_no   = adw_detail.getitemnumber(ll_cnt, "sys_audit_seq_no") 
	ll_screen_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_screen_id") 
	ls_table_name = adw_detail.getitemstring(ll_cnt, "sys_tables_table_name") 
	ls_value_old = adw_detail.getitemstring(ll_cnt, "sys_audit_old_value") 
	ls_field_type = adw_detail.getitemstring(ll_cnt, "sys_fields_field_type")
	ls_field = adw_detail.getitemstring(ll_cnt, "sys_fields_field_name")
	ll_field_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_field_id") 
	ll_prac_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_prac_id")
	
	choose case ls_opt_type
		case "Skip"
			continue
		case "Accept"
			if ls_audit_type = 'IQW' then
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where table_id = :ll_table_id
					 and seq_no  = :ll_seq_no;
			else
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where rec_id   = :ll_rec_id
					 and seq_no  = :ll_seq_no
					 and field_id  = :ll_field_id;
			end if
			
			if sqlca.sqlcode <> 0 then
				return -1
			end if
			if ai_tab = 2 then
				if of_update_screen(ll_cnt, adw_detail) = -1 then 
					return -1
				end if
				
				if of_audit_update_accept(adw_detail, ll_cnt) = -1 then 
					return -1
				end if
				
				if of_create_dynamic_dw(ai_tab, ll_cnt, adw_detail, 'Save') = -1 then
					return -1
				end if
			end if
			
		case "Reject"
			if  ls_audit_type = 'IQW' then
				//(Appeon)Stephen 09.16.2015 - modify 'audit_rejected = 0' to 'audit_rejected = 1' --Issues with WebView columns in Audit trail 
				update sys_audit
					  set audit_pending = 0,
							audit_rejected = 1,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				 where table_id = :ll_table_id
					 and seq_no  = :ll_seq_no;
			else
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where rec_id   = :ll_rec_id
					 and seq_no  = :ll_seq_no
					 and field_id  = :ll_field_id;
			end if
				 
			if sqlca.sqlcode <> 0 then return -1			
			if ai_tab = 1  then 
				if  ls_audit_type = 'I-W' then
					gnv_appeondb.of_startqueue( )
					
					Delete from pd_images where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from verif_info where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from pd_app_audit_temp where de_rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from pd_app_audit where de_rec_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
						
					choose case ll_screen_id
						case 2
							Delete from pd_address_link  where address_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
						case 10
							Delete from pd_hosp_facility_link where hosp_affil_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
						case 19
							Delete from pd_spec_facility_link  where specialty_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
					end choose					
					ls_sql = "delete from " + ls_table_name +  " where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id)
					gnv_appeondb.of_commitqueue( )	
					
					EXECUTE IMMEDIATE :ls_sql;
					if sqlca.sqlcode <> 0 then return -1
				elseif ls_audit_type = 'E-W' then
					if isnull(ls_field) or ls_field = '' then continue
					ls_value_new = ''
					
					choose case ls_field_type
						case 'D'
							if Len(ls_value_old) > 0 then //add if statement for Bug 4370 - alfee 12.18.2014
								li_pos = lastpos(ls_value_old, '/')	
								ls_value_new = mid(ls_value_old, li_pos + 1)  
								ls_value_old = left(ls_value_old, li_pos - 1)
								ls_value_old = ls_value_new + '/' + ls_value_old
								ldt_value_date = datetime(date(ls_value_old),time("00:00"))
								ls_value_old = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
							end if
						case 'C' //(Appeon)Stephen 05.04.2015 - Allegheny Webview Acceptance Issue Case#54392 Bug_Id 4511
								ls_value_old = of_strip_char("'", ls_value_old, "''")
					end choose
					
					ls_sql = "update " + ls_table_name +" set " + ls_field + " = '" + ls_value_old + "' where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id)
					
					if ls_field_type = 'D' and (isnull(ls_value_old) or ls_value_old = '') then
						ls_sql = "update " + ls_table_name +" set " + ls_field + " = Null where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id) //Bug 4370 - alfee 12.18.2014
					end if
					
					EXECUTE IMMEDIATE :ls_sql;
					if sqlca.sqlcode <> 0 then return -1
		
					if of_create_dynamic_dw(ai_tab, ll_cnt, adw_detail, 'Save') = -1 then
						return -1
					end if
				end if
			elseif ai_tab = 2  then
				if ls_audit_type = 'IQW' then
					Delete from pd_images where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
				end if
			end if
			
	end choose
	 
next
commit using sqlca;
of_retrieve_dw(ai_tab)

return 1
end function

public function integer of_update_screen (long al_row, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_update_screen
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_table, ls_field, ls_type
string ls_sql, ls_value
long   ll_seq_no, ll_cnt
string ls_field_arr, ls_value_arr
string ls_msg, ls_field_type
string ls_update_field
long   ll_recid, ll_prac_id
integer  li_pos
datetime ldt_date, ldt_value_date
string ls_value_new, ls_opt_type
long  ll_facility_specific, ll_facility_id
long  ll_screen_id, ll_seq_num

if al_row < 1 then return -1
ls_type  = adw_detail.getitemstring(al_row, "sys_audit_audit_type")
ls_table = adw_detail.getitemstring(al_row, "sys_tables_table_name")
ll_seq_no = adw_detail.getitemnumber(al_row, "sys_audit_seq_no")
ll_recid  =  adw_detail.getitemnumber(al_row, "sys_audit_rec_id")
ldt_date = datetime( today(),now())
ll_prac_id = adw_detail.getitemnumber(al_row, "sys_audit_prac_id")
il_rec_id_spe = 0

choose case ls_type
	case 'EQW'
		ls_field = adw_detail.getitemstring(al_row, "sys_fields_field_name")
		ls_field_type = adw_detail.getitemstring(al_row, "sys_fields_field_type")
		ls_value = adw_detail.getitemstring(al_row, "sys_audit_new_value") 
		ls_value_new = ''
		
		choose case ls_field_type
			case 'D'
				if Len(ls_value) > 0 then //add if statement for Bug 4370 - alfee 12.18.2014
				//---------Begin Commented by (Appeon)Stephen 11.13.2015 for V14.2 WebView Bug #4845 - Entering dates with a 2 digit year (11/12/15) in WebView causes date to change to 1/1/1900 after acceptance --------
							/*
					li_pos = lastpos(ls_value, '/')	
					ls_value_new = mid(ls_value, li_pos + 1)  
					ls_value = left(ls_value, li_pos - 1)
					ls_value = ls_value_new + '/' + ls_value
					*/
				//------------------- APPEON End -------------------
					ldt_value_date = datetime(date(ls_value),time("00:00"))
					ls_value = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
					ls_value_new = trim(ls_value)  //(Appeon)Stephen 12.16.2015 - V14.2 Bug #4894 - Modifying an existing date in WebView causes it to be removed after being accepted
				end if
			case 'C' //(Appeon)Stephen 05.20.2015 - Bug #4533 - Cannot edit record in WebView Audit when it contains an apostrophe Case # 54718
					ls_value = of_strip_char("'", ls_value, "''")
			case 'N', 'I', 'L'  //(Appeon)Stephen 01.20.2016 - V14.2 Bug # 4936 - Transaction error when you edit WebView audit data
					ls_value_new = trim(ls_value)
					if not isnumber(ls_value_new) then ls_value_new = '' 
		end choose
		
		//---------Begin Modified by (Appeon)Stephen 01.18.2016 for V14.2 Bug # 4936 - Transaction error when you edit WebView audit data--------
		/*
		ls_sql = "update " + ls_table +" set " + ls_field + " = '" + ls_value + "' where rec_id = " + string(ll_seq_no) +" and prac_id = " + string(ll_prac_id)
		
		if ls_field_type = 'D' and (isnull(ls_value_new) or ls_value_new = '') then
			ls_sql = "update " + ls_table +" set " + ls_field + " = Null where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id) //Bug 4370 - alfee 12.18.2014
		end if
		*/
		if (ls_field_type = 'D' or ls_field_type ='N' or ls_field_type ='L' or ls_field_type ='I') and (isnull(ls_value_new) or ls_value_new = '') then 
			ls_update_field = ls_field + " = Null "
		else
			ls_update_field = ls_field + " = '" + ls_value + "'"
		end if
		ls_sql = "update " + ls_table +" set " + ls_update_field + " where rec_id = " + string(ll_seq_no) +" and prac_id = " + string(ll_prac_id)
		//---------End Modfiied ------------------------------------------------------
		
		EXECUTE IMMEDIATE :ls_sql;
		if sqlca.sqlcode <> 0 then 
			messagebox("Prompt", "Update Screen Data failed. Please make sure the data are correct!~r~n" + sqlca.sqlerrtext) //(Appeon)Stephen 11.04.2015 - Bug id 4820 - Cannot edit WebView Audit Function
			return -1
		end if
		
	case 'IQW'
		ls_table = adw_detail.getitemstring(al_row, "sys_tables_table_name")
		ll_seq_no = adw_detail.getitemnumber(al_row, "sys_audit_seq_no")
		ll_facility_specific = adw_detail.getitemnumber(al_row, "sys_tables_facility_specific")
		ll_screen_id = adw_detail.getitemnumber(al_row, "sys_audit_screen_id")
		ll_facility_id = adw_detail.getitemnumber(al_row, "sys_audit_facility_id")
		if isnull(ll_facility_id) then ll_facility_id = 0
						
		ls_field_arr = ''
		ls_value_arr = ''
		for ll_cnt = al_row to adw_detail.rowcount()
			
			if ls_table <> adw_detail.getitemstring(ll_cnt, "sys_tables_table_name") then exit
			ls_type = adw_detail.getitemstring(ll_cnt, "sys_audit_audit_type")
			if ll_seq_no <> adw_detail.getitemnumber(ll_cnt, "sys_audit_seq_no")  then exit
			
			if ls_type <> 'QQW' then continue
			ls_field = adw_detail.getitemstring(ll_cnt, "sys_fields_field_name")
			if isnull(ls_field) or ls_field = '' then continue
			ls_value = adw_detail.getitemstring(ll_cnt, "sys_audit_new_value") 
			if isnull(ls_value) then continue
			ls_field_type = adw_detail.getitemstring(ll_cnt, "sys_fields_field_type")
			
			ls_value_new = ''
			choose case ls_field_type
				case 'D'
					if isnull(ls_value) or ls_value = '' then continue //Bug 4370 - alfee 12.18.2014
					//---------Begin Commented by (Appeon)Stephen 11.13.2015 for V14.2 WebView Bug #4845 - Entering dates with a 2 digit year (11/12/15) in WebView causes date to change to 1/1/1900 after acceptance --------
							/*
					li_pos = lastpos(ls_value, '/')	
					ls_value_new = mid(ls_value, li_pos + 1)  
					ls_value = left(ls_value, li_pos - 1)
					ls_value = ls_value_new + '/' + ls_value
					*/
				     //------------------- APPEON End -------------------
					ldt_value_date = datetime(date(ls_value),time("00:00"))
					ls_value = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
				case 'N','I', 'l'
					if isnull(ls_value) or ls_value = '' then continue
				case 'C' //(Appeon)Stephen 05.20.2015 - Bug #4533 - Cannot edit record in WebView Audit when it contains an apostrophe Case # 54718
					ls_value = of_strip_char("'", ls_value, "''")
			end choose
			
			ls_value = "'" + ls_value + "'"
			ls_field_arr   = ls_field_arr + ls_field + ','
			ls_value_arr = ls_value_arr + ls_value + ','						
		next
		
		if isnull(ls_field_arr) or ls_field_arr = '' then return -1
		
		//------------------- APPEON BEGIN -------------------
		//$<add>Stephen 04.11.2012
		//$<reason>set seq_no
		IF ll_screen_id = 61 or ll_screen_id = 32 or ll_screen_id = 33 THEN	
			
			SELECT pd_affil_stat.rec_id  
				INTO :il_rec_id_spe  
				FROM pd_affil_stat  
				WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
         		( pd_affil_stat.parent_facility_id = :ll_facility_id ) AND  
         		( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
				Return -1
			END IF
			
			ll_seq_no = il_rec_id_spe
			Choose Case ll_screen_id
				Case	32 //Depart/Div/Section
					ll_seq_num = of_get_next_seq_no( "department", ll_seq_no )
				Case	33 //Staff Category
					ll_seq_num = of_get_next_seq_no( "staff cat", ll_seq_no )
				Case	61 //No this screen id in DB???
					ll_seq_num = of_get_next_seq_no( "department", ll_seq_no )
			End Choose
			
			ll_seq_num = ll_seq_num +1
			ls_field_arr = ls_field_arr + ' seq_no, '
			ls_value_arr = ls_value_arr + string(ll_seq_num) + ', '
		end if
		//------------------- APPEON End -------------------
		
		if ll_facility_specific <> 1 then
			ls_field_arr = ls_field_arr + ' rec_id, prac_id '
			ls_value_arr = ls_value_arr + string(ll_seq_no) +', ' + string(ll_prac_id) 
		else
			//------------------- APPEON BEGIN -------------------
			//$<add>Stephen 04.05.2012
			//$<reason>set facility_id
			ls_field_arr = ls_field_arr + ' rec_id, prac_id, facility_id '
			ls_value_arr = ls_value_arr + string(ll_seq_no) +', ' + string(ll_prac_id) +', ' + string(ll_facility_id)
			//------------------- APPEON END -------------------
		end if
				
		ls_sql = "insert into " + ls_table +" ( " + ls_field_arr + " ) values( " + ls_value_arr + " ) " 
		EXECUTE IMMEDIATE :ls_sql;
		if sqlca.sqlcode <> 0 then 
			messagebox("Prompt", "Update Screen Data failed. Please make sure the data are correct!~r~n" + sqlca.sqlerrtext) //(Appeon)Stephen 11.04.2015 - Bug id 4820 - Cannot edit WebView Audit Function
			return -1
		end if
end choose

if sqlca.sqlcode <> 0 then 
	rollback using sqlca;
	return -1
end if

return 1
		
end function

public function integer of_update_address_link (string as_opt_type, long al_prac_id, long al_address_id);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_address_link
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_cnt, li_nr
datastore lds_facility

lds_facility = create datastore
lds_facility.dataobject = 'd_address_link_parent_facility_id'
lds_facility.settransobject(sqlca)
lds_facility.retrieve(al_prac_id)

if as_opt_type = 'Accept' then
	dw_link_list.dataobject = "d_addr_link_check_boxes"
	dw_link_list.settransobject(sqlca)
	
	for li_cnt = 1 to lds_facility.rowcount()
		li_nr = dw_link_list.InsertRow( 0 )
		dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
		dw_link_list.SetItem( li_nr, "address_id", al_address_id )
		dw_link_list.SetItem( li_nr, "facility_id", lds_facility.GetItemNumber( li_cnt, "parent_facility_id" ) )
		dw_link_list.SetItem( li_nr, "mailing", 0 )
		dw_link_list.SetItem( li_nr, "billing", 0 )
		dw_link_list.SetItem( li_nr, "home_address", 0 )
		dw_link_list.SetItem( li_nr, "primary_office", 0 )
		dw_link_list.SetItem( li_nr, "additional_office", 0 )
		dw_link_list.SetItem( li_nr, "include_in_directory", 0 )
		dw_link_list.SetItem( li_nr, "exp_letters", 0 )
	
	next
	if dw_link_list.Update() <> 1 then 
		is_sql_err = sqlca.sqlerrtext
		return -1
	end if
elseif as_opt_type = 'Reject' then
	delete  from pd_address_link where address_id = :al_address_id and prac_id = :al_prac_id using sqlca;
end if

destroy lds_facility
return 1
end function

public function integer of_update_hosp_link (string as_opt_type, long al_prac_id, long al_seq_no);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_hosp_link
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////

n_ds lds_parent_facilities
Integer li_row_cnt
Integer i
Integer li_nr

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( al_prac_id )

if as_opt_type = 'Accept' then
	dw_link_list.DataObject = "d_hf_link"
	dw_link_list.setTransObject( SQLCA )
	FOR i = 1 TO li_row_cnt
		li_nr = dw_link_list.InsertRow( 0 )	
		dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
		dw_link_list.SetItem( li_nr, "hosp_affil_id", al_seq_no )
		dw_link_list.SetItem( li_nr, "primary_hosp", 582)	
		dw_link_list.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
	next
	
	IF li_row_cnt > 0 THEN		
		if dw_link_list.Update() <> 1 then 
			is_sql_err = sqlca.sqlerrtext
			return -1
		end if
	END IF
elseif as_opt_type = 'Reject' then
	delete  from pd_hosp_facility_link where hosp_affil_id = :al_seq_no and prac_id = :al_prac_id using sqlca;
end if

DESTROY lds_parent_facilities
Return 1
end function

public function integer of_update_spec_link (string as_opt_type, long al_prac_id, long al_seq_no);//////////////////////////////////////////////////////////////////////
// $<Function> of_update_spec_link
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////

n_ds lds_parent_facilities
Integer li_row_cnt
Integer i
Integer li_nr

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( al_prac_id )

IF as_opt_type = 'Accept' then
	dw_link_list.DataObject = "d_sf_link"
	dw_link_list.setTransObject( SQLCA )

	FOR i = 1 TO li_row_cnt
		li_nr = dw_link_list.InsertRow( 0 )	
		dw_link_list.SetItem( li_nr, "prac_id", al_prac_id )
		dw_link_list.SetItem( li_nr, "specialty_id", al_seq_no )
		dw_link_list.SetItem( li_nr, "practicing", 581)	
		dw_link_list.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
	END FOR
	
	IF li_row_cnt > 0 THEN
		if dw_link_list.Update() <> 1 then 
			is_sql_err = sqlca.sqlerrtext
			return -1
		end if
	END IF
elseif as_opt_type = 'Reject' then
	delete from pd_spec_facility_link where prac_id = :al_prac_id and specialty_id = :al_seq_no using sqlca;
end if

DESTROY lds_parent_facilities

Return 1
end function

public function integer of_add_verif_info (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method);//////////////////////////////////////////////////////////////////////
// $<function> of_add_verif_info
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.29.2011 by Stephen
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
	MessageBox("Error in function of_add_verif_info", "No active affiliation status records found.  Be sure there is an active appointment status record for this practitioner." ) 
	destroy lds_verif_facilities
	Return -1
END IF

i = lds_verif_facilities.Find("upper(verify_data) <> 'N' OR Isnull(verify_data)" ,1 ,li_rc)
If	Isnull(i) Or i <= 0 Then 
	destroy lds_verif_facilities
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
	
	if li_date_check = 1 then
		resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + ". Do you want to add the verification item.",question!,yesno!,2)
		if resp = 2 then continue
	end if
	
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
		messagebox("Update failure in of_add_verif_info (Audit Trail)", "Verification not created.")
	end if
End If
Destroy lds_detail 

RETURN 1


end function

public function integer of_create_dynamic_dw (integer ai_tab, long al_row, u_dw adw_detail, string as_type);//////////////////////////////////////////////////////////////////////
// $<function> of_create_dynamic_dw
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.26.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string    ls_sql_syntax
long      ll_row, ll_prac_id, ll_seq, ll_pos
integer  li_screen_id,  li_facility
string    ls_audit_type, ls_fieldname
long      ll_rec_id, ll_field_id, ll_table_id
datetime ldt_date
string ls_msg
string   ls_old_value, ls_new_value //(V15 DE Update) alfee 11.16.2016
dwitemstatus lds_status

if al_row < 1 then return -1

if as_type = 'edit' then 
	ls_msg = "Are you sure you want to edit the current record? ~r~n" + &
				 "By proceeding to 'Edit Data' the changes logged in this audit record ~r~n" + &
			 	 "will be fully committed and saved to the database. ~r~n" +&
				 "Any changes you make on the Edit screen will also be committed immediately."
	
	if messagebox("Prompt", ls_msg, Exclamation!, okcancel!, 2) = 2 then 
		adw_detail.setitem(al_row, 'opt_type', adw_detail.getitemstring(al_row,  'opt_type', primary!, false))
		return -1
	end if
	
	if ai_tab = 2 then
		if of_update_screen(al_row, adw_detail) <> 1 then return -1
		if of_audit_update_accept(adw_detail, al_row) = -1 then 
			messagebox("Prompt", "Update Screen Data failed. Please make sure the data are correct!~r~n" + is_sql_err) //(Appeon)Stephen 11.04.2015 - Bug id 4820 - Cannot edit WebView Audit Function
			return -1
		end if
	end if
	
	ll_rec_id = adw_detail.getitemnumber(al_row, "sys_audit_rec_id")
	ll_field_id = adw_detail.getitemnumber(al_row, "sys_audit_field_id")
	ll_seq = adw_detail.getitemnumber(al_row, "sys_audit_seq_no")
	ldt_date = datetime(today(), now())
	ll_table_id   = adw_detail.getitemnumber(al_row, "sys_audit_table_id") 
	ls_audit_type = adw_detail.getitemstring(al_row, "sys_audit_audit_type") 
	
	if ai_tab = 2 then
		if ls_audit_type = 'EQW' then //add by stephen 04.01.2012 BugS040101
			update sys_audit
			  set audit_pending = 0,
				  auditor = :gs_user_id,
				  audit_date = :ldt_date
		  where  rec_id  = :ll_rec_id
			  and field_id = :ll_field_id
			and seq_no = :ll_seq using sqlca;
		else
			update sys_audit
				  set audit_pending = 0,
					  auditor = :gs_user_id,
					  audit_date = :ldt_date
			  where table_id = :ll_table_id
				 and seq_no  = :ll_seq using sqlca;
		end if
	else	 
		update sys_audit
			  set audit_pending = 0,
				  auditor = :gs_user_id,
				  audit_date = :ldt_date
		  where  rec_id  = :ll_rec_id
			  and field_id = :ll_field_id
			and seq_no = :ll_seq using sqlca;
	end if
		
	if sqlca.sqlcode = 0 then 
		commit using sqlca;
	else
		rollback using sqlca;
		return -1
	end if
end if
		
ll_prac_id    =   adw_detail.getitemnumber(al_row, "sys_audit_prac_id")
li_screen_id =   adw_detail.getitemnumber(al_row, "sys_audit_screen_id") 
li_facility      =   adw_detail.getitemnumber(al_row, "sys_audit_facility_id") 
ll_seq          =   adw_detail.getitemnumber(al_row, "sys_audit_seq_no") 
ls_audit_type = adw_detail.getitemstring(al_row, "sys_audit_audit_type") 
ls_fieldname = adw_detail.getitemstring(al_row, "sys_fields_field_name")
ls_old_value = adw_detail.getitemstring(al_row, "sys_audit_old_value") //(V15 DE Update) alfee 11.16.2016
ls_new_value = adw_detail.getitemstring(al_row, "sys_audit_new_value") //(V15 DE Update) alfee 11.16.2016

if isnull(li_facility) then li_facility = 0

//------------------- APPEON BEGIN -------------------
//$<add>Stephen 04.11.2012
//$<reason>get rec_id
IF li_screen_id = 61 or li_screen_id = 32 or li_screen_id = 33 THEN
	if ls_audit_type = 'IQW' and il_rec_id_spe <> 0 then
		ll_seq = il_rec_id_spe
	end if
end if
//------------------- APPEON END -------------------			
					
if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if

inv_data_entry.ib_report = false
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()

ls_sql_syntax = inv_data_entry.of_create_dynamic_dw( ll_prac_id, 1, li_screen_id, dw_detail, dw_detail, false, li_facility, true )

ls_sql_syntax = dw_detail.getsqlselect()
ll_pos = pos(lower(ls_sql_syntax), 'order by' )
	
if pos(lower(ls_sql_syntax), 'where') > 0 then
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " and rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " and rec_id = "+string(ll_seq)+" "
	end if
else
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " where rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " where rec_id = "+string(ll_seq)+" "
	end if
end if

dw_detail.setsqlselect(ls_sql_syntax)
ll_row = dw_detail.retrieve()

il_prac_id = ll_prac_id
il_rec_id  = ll_seq
ii_screen_id = li_screen_id

if as_type = 'edit' then
	//---------Begin Modified by (Appeon)Stephen 08.28.2015 for Allegheny having an issue with audit trail for a provider--------
	//if ll_row = 0 then dw_detail.insertrow(0)
	//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname) //add by stephen 04.01.2012 --BugS040102
	if ll_row = 0 then 
		dw_detail.insertrow(0)
	else
		//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname)
		dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname, ls_old_value, ls_new_value) //(V15 DE Update) alfee 11.16.2016
	end if
	//---------End Modfiied ------------------------------------------------------

	adw_detail.visible = false
	idw_audit_detail = adw_detail
	ib_edit = true
	dw_detail.visible = true
else
	if ll_row < 1 then return 1
	//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname)
	dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname, ls_old_value, ls_new_value) //(V15 DE Update) alfee 11.16.2016
	lds_status =  dw_detail.getitemstatus(1, 0,primary!)
	if lds_status <> notmodified! then
		dw_detail.setitemstatus(1,0,primary!,notmodified!)
	end if
end if

return 1
end function

public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess);
//Start Code Change ---- 03.24.2006 #340 maha

integer res
string ls_plus

ls_plus = "~r~rData will not be saved for row " + string(ai_row) + "."

res = messagebox(as_title,as_mess + ls_plus,question!,ok!)
//if res = 1 then 
dw_detail.setitemstatus( ai_row, 0, primary!,notmodified!)
				
return 1

//End Code Change---03.24.2006
end function

public function integer of_audit_update_accept (u_dw adw_detail, long al_row);//////////////////////////////////////////////////////////////////////
// $<function> of_audit_update_accept
// $<arguments>
// $<returns> integer
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.28.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string    ls_audit_type
long      ll_screen_id, ll_prac_id, ll_seq_no

ls_audit_type = adw_detail.getitemstring(al_row, "sys_audit_audit_type")
if not(ls_audit_type = 'IQW' or ls_audit_type = 'EQW' ) then return 1

choose case ls_audit_type
	case 'IQW'
		ll_screen_id = adw_detail.getitemnumber(al_row, "sys_audit_screen_id") 
		ll_prac_id    = adw_detail.getitemnumber(al_row, "sys_audit_prac_id") 
		ll_seq_no    = adw_detail.getitemnumber(al_row, "sys_audit_seq_no")
		
		choose case ll_screen_id
			case 2
				if of_update_address_link('Accept', ll_prac_id, ll_seq_no) = -1 then return -1
			case 10
				if of_update_hosp_link('Accept', ll_prac_id, ll_seq_no) = -1 then return -1
			case 19
				if of_update_spec_link('Accept', ll_prac_id, ll_seq_no) = -1 then return -1				
		end choose
		
	case 'EQW'
		
end choose

return 1
end function

public function integer of_lookup_accept (u_dw adw_detail, u_dw adw_list);//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row, ll_lookup_code
string  ls_code

ll_row = adw_detail.getrow()
if ll_row < 1 then return -1

ll_lookup_code = adw_detail.getitemnumber(ll_row, 'lookup_code')

UPDATE  address_lookup
      SET  audit_flag = 'WA' , avail_status = 1
WHERE   lookup_code	= :ll_lookup_code using sqlca;
if sqlca.sqlcode <> 0 then
	rollback using sqlca;
	return -1
else
	commit using sqlca;
end if

adw_list.retrieve()
if adw_list.rowcount() < 1 then 
	adw_detail.reset()
	adw_detail.insertrow(0)
	return 1
end if
adw_list.selectrow(0,false)
adw_list.scrolltorow(1)
adw_list.selectrow(1, true)

 ls_code = adw_list.getitemstring(1, "code")
 ll_lookup_code = adw_list.getitemnumber(1, "lookup_code")
 adw_detail.retrieve(ls_code, ll_lookup_code)
 
 return 1



end function

public function long of_get_next_seq_no (string as_dw, long al_rec_id);//////////////////////////////////////////////////////////////////////
// $<function> of_get_next_seq_no
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//                       get next seq_no
//////////////////////////////////////////////////////////////////////
// $<add> 04.11.2012 by Stephen
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


RETURN ll_seq_no

end function

public function integer of_update_screen_new (string as_table_name, long al_seq_no, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_update_screen_new
// $<arguments>
// $<returns> integer
// $<description>Allegheny issue with webview audit accepting data
//////////////////////////////////////////////////////////////////////
// $<add> 02.05.2015 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_table, ls_field, ls_type
string ls_sql, ls_value
long   ll_seq_no, ll_seq_no_pred, ll_cnt
string ls_field_arr, ls_value_arr
string ls_msg, ls_field_type
string ls_update_field
long   ll_recid, ll_prac_id
integer  li_pos
datetime ldt_date, ldt_value_date
string ls_value_new, ls_opt_type
long  ll_facility_specific, ll_facility_id
long  ll_screen_id, ll_screen_id_pred, ll_seq_num
long ll_appt_stat_id //alfee 03.25.2015
long ll_find

datastore lds_detail
//n_import_ds lds_screen, lds_affil_stat
			
lds_detail = create datastore
lds_detail.dataobject = adw_detail.dataobject
lds_detail.settransobject(sqlca)
adw_detail.rowscopy(1, adw_detail.rowcount(), primary!, lds_detail,1,primary!)
yield()
lds_detail.setfilter("sys_tables_table_name = '"+as_table_name+"' and sys_audit_seq_no = "+string(al_seq_no))
lds_detail.filter()

if lds_detail.rowcount() < 1 then return -1
ls_type  = lds_detail.getitemstring(1, "sys_audit_audit_type")
ls_table = lds_detail.getitemstring(1, "sys_tables_table_name")
ll_seq_no = lds_detail.getitemnumber(1, "sys_audit_seq_no")
ll_recid  =  lds_detail.getitemnumber(1, "sys_audit_rec_id")
ldt_date = datetime( today(),now())
ll_prac_id = lds_detail.getitemnumber(1, "sys_audit_prac_id")
il_rec_id_spe = 0

is_sql_err = "" //(Appeon)Stephen 03.05.2015 - Allegheny Webview Audit
choose case ls_type
	case 'EQW'
		for ll_cnt = 1 to lds_detail.rowcount()
			
			ls_field = lds_detail.getitemstring(ll_cnt, "sys_fields_field_name")
			//---------Begin Added by (Appeon)Stephen 06.05.2015 for V15.1-Additional TDL type of Recruitment Task--------
			ll_find = lds_detail.find("sys_fields_field_name = '"+ls_field+"'", ll_cnt +1,  lds_detail.rowcount())
			if ll_find > 0 and ll_find <> ll_cnt then continue
			//---------End Added ------------------------------------------------------
			ls_field_type = lds_detail.getitemstring(ll_cnt, "sys_fields_field_type")
			ll_seq_no = lds_detail.getitemnumber(ll_cnt, "sys_audit_seq_no")
			ls_table = lds_detail.getitemstring(ll_cnt, "sys_tables_table_name")
			ll_screen_id = lds_detail.getitemnumber(ll_cnt, "sys_audit_screen_id")
			ls_value = lds_detail.getitemstring(ll_cnt, "sys_audit_new_value") 
			ls_opt_type = lds_detail.getitemstring(ll_cnt, "opt_type") 
			ls_value_new = ''
			if ls_opt_type = "Skip" or ls_opt_type = "Reject" then continue
			ls_field_type = upper(ls_field_type) //(Appeon)Stephen 10.10.2015 - WebView Audit -- Butler Case #56897
				
			choose case ls_field_type
				case 'D'
					if Len(ls_value) > 0 then //add if statement for Bug 4370 - alfee 12.18.2014
					//---------Begin Commented by (Appeon)Stephen 11.13.2015 for V14.2 WebView Bug #4845 - Entering dates with a 2 digit year (11/12/15) in WebView causes date to change to 1/1/1900 after acceptance --------
							/*
						li_pos = lastpos(ls_value, '/')	
						ls_value_new = mid(ls_value, li_pos + 1)  
						ls_value = left(ls_value, li_pos - 1)
						ls_value = ls_value_new + '/' + ls_value
						*/
				//------------------- APPEON End -------------------
						ldt_value_date = datetime(date(ls_value),time("00:00"))
						ls_value = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
						ls_value_new = trim(ls_value)  //(Appeon)Stephen 12.16.2015 - V14.2 Bug #4894 - Modifying an existing date in WebView causes it to be removed after being accepted
					end if
				case 'C' //(Appeon)Stephen 05.04.2015 - Allegheny Webview Acceptance Issue Case#54392 Bug_Id 4511
					ls_value = of_strip_char("'", ls_value, "''")
				case 'N', 'I', 'L'  //(Appeon)Stephen 07.10.2015 - Allegheny Issue accepting data from webview audit
					ls_value_new = trim(ls_value)
					if not isnumber(ls_value_new) then ls_value_new = '' //(Appeon)Stephen 09.30.2015 - WebView Audit -- Butler Case #56897
			end choose			
			
			//---------Begin Modified by (Appeon)Stephen 07.10.2015 for V15.1-Additional TDL type of Recruitment Task--------
			/*
			ls_update_field = ls_update_field + "," + ls_field + " = '" + ls_value + "'"
			if ls_field_type = 'D' and (isnull(ls_value_new) or ls_value_new = '') then
				ls_update_field = ls_update_field + "," + ls_field + " = Null "
			end if
			*/
			if (ls_field_type = 'D' or ls_field_type ='N' or ls_field_type ='L' or ls_field_type ='I') and (isnull(ls_value_new) or ls_value_new = '') then //(Appeon)Stephen 10.10.2015 - -add 'L'  WebView Audit -- Butler Case #56897
				ls_update_field = ls_update_field + "," + ls_field + " = Null "
			else
				ls_update_field = ls_update_field + "," + ls_field + " = '" + ls_value + "'"
			end if
			//---------End Modfiied ------------------------------------------------------
			
		next
		
		if left(ls_update_field, 1) = "," then ls_update_field = mid(ls_update_field, 2)
		ls_sql = "update " + ls_table +" set " + ls_update_field + " where rec_id = " + string(ll_seq_no) +" and prac_id = " + string(ll_prac_id)
						
		EXECUTE IMMEDIATE :ls_sql;
		//---------Begin Modified by (Appeon)Stephen 03.05.2015 for Allegheny Webview Audit--------
		//if sqlca.sqlcode <> 0 then return -1
		if sqlca.sqlcode <> 0 then
			is_sql_err = sqlca.sqlerrtext
			return -1
		end if
		//---------End Modfiied ------------------------------------------------------
		
	case 'IQW'
		ls_table = lds_detail.getitemstring(1, "sys_tables_table_name")
		ll_seq_no = lds_detail.getitemnumber(1, "sys_audit_seq_no")
		ll_facility_specific = lds_detail.getitemnumber(1, "sys_tables_facility_specific")
		ll_screen_id = lds_detail.getitemnumber(1, "sys_audit_screen_id")
		ll_facility_id = lds_detail.getitemnumber(1, "sys_audit_facility_id")
		if isnull(ll_facility_id) then ll_facility_id = 0
						
		ls_field_arr = ''
		ls_value_arr = ''
		for ll_cnt = 1 to lds_detail.rowcount()
			
			if ls_table <> lds_detail.getitemstring(ll_cnt, "sys_tables_table_name") then exit
			ls_type = lds_detail.getitemstring(ll_cnt, "sys_audit_audit_type")
			if ll_seq_no <> lds_detail.getitemnumber(ll_cnt, "sys_audit_seq_no")  then exit
			
//			if ls_type <> 'QQW' then continue
			ls_field = lds_detail.getitemstring(ll_cnt, "sys_fields_field_name")
			if isnull(ls_field) or ls_field = '' then continue
			//---------Begin Added by (Appeon)Stephen 06.05.2015 for V15.1-Additional TDL type of Recruitment Task--------
			ll_find = lds_detail.find("sys_fields_field_name = '"+ls_field+"'", ll_cnt +1,  lds_detail.rowcount())
			if ll_find > 0 and ll_find <> ll_cnt then continue
			//---------End Added ------------------------------------------------------
			ls_value = lds_detail.getitemstring(ll_cnt, "sys_audit_new_value") 
			if isnull(ls_value) then continue
			ls_field_type = lds_detail.getitemstring(ll_cnt, "sys_fields_field_type")
			ls_field_type = upper(ls_field_type) //(Appeon)Stephen 10.10.2015 - WebView Audit -- Butler Case #56897
			
			ls_value_new = ''
			choose case ls_field_type
				case 'D'
					if isnull(ls_value) or ls_value = '' then continue //Bug 4370 - alfee 12.18.2014
					//---------Begin Commented by (Appeon)Stephen 11.13.2015 for V14.2 WebView Bug #4845 - Entering dates with a 2 digit year (11/12/15) in WebView causes date to change to 1/1/1900 after acceptance --------
							/*
					li_pos = lastpos(ls_value, '/')	
					ls_value_new = mid(ls_value, li_pos + 1)  
					ls_value = left(ls_value, li_pos - 1)
					ls_value = ls_value_new + '/' + ls_value
					*/
				//------------------- APPEON End -------------------
					ldt_value_date = datetime(date(ls_value),time("00:00"))
					ls_value = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
				case 'N','I', 'L' //(Appeon)Stephen 10.10.2015 - -add 'L'  WebView Audit -- Butler Case #56897
					if isnull(ls_value) or ls_value = '' then continue
					//---------Begin Added by (Appeon)Stephen 09.30.2015 for WebView Audit -- Butler Case #56897--------
					ls_value = trim(ls_value)
					if not isnumber(ls_value) then continue 
					//---------End Added ------------------------------------------------------	
				case 'C' //(Appeon)Stephen 05.04.2015 - Allegheny Webview Acceptance Issue Case#54392 Bug_Id 4511
					ls_value = of_strip_char("'", ls_value, "''")	
			end choose
			
			ls_value = "'" + ls_value + "'"
			ls_field_arr   = ls_field_arr + ls_field + ','
			ls_value_arr = ls_value_arr + ls_value + ','						
		next
		
		if isnull(ls_field_arr) or ls_field_arr = '' then return -1
		
		//------------------- APPEON BEGIN -------------------
		//$<add>Stephen 04.11.2012
		//$<reason>set seq_no
		IF ll_screen_id = 61 or ll_screen_id = 32 or ll_screen_id = 33 THEN	
			
			SELECT pd_affil_stat.rec_id  
				INTO :il_rec_id_spe  
				FROM pd_affil_stat  
				WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
         		( pd_affil_stat.parent_facility_id = :ll_facility_id ) AND  
         		( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
				Return -1
			END IF
			
			ll_seq_no = il_rec_id_spe
			Choose Case ll_screen_id
				Case	32 //Depart/Div/Section
					ll_seq_num = of_get_next_seq_no( "department", ll_seq_no )
				Case	33 //Staff Category
					ll_seq_num = of_get_next_seq_no( "staff cat", ll_seq_no )
				Case	61 //No this screen id in DB???
					ll_seq_num = of_get_next_seq_no( "department", ll_seq_no )
			End Choose
			
			ll_seq_num = ll_seq_num +1
			ls_field_arr = ls_field_arr + ' seq_no, '
			ls_value_arr = ls_value_arr + string(ll_seq_num) + ', '
		end if
		//------------------- APPEON End -------------------
		
		if ll_facility_specific <> 1 then
			ls_field_arr = ls_field_arr + ' rec_id, prac_id '
			ls_value_arr = ls_value_arr + string(ll_seq_no) +', ' + string(ll_prac_id) 
		else
			//------------------- APPEON BEGIN -------------------
			//$<add>Stephen 04.05.2012
			//$<reason>set facility_id
			ls_field_arr = ls_field_arr + ' rec_id, prac_id, facility_id '
			ls_value_arr = ls_value_arr + string(ll_seq_no) +', ' + string(ll_prac_id) +', ' + string(ll_facility_id)
			//------------------- APPEON END -------------------
		end if

		//---------Begin Added by (V14.2 AQ Audit) Alfee 03.25.2015  -------------------
		IF ll_screen_id = 65 THEN	
			SELECT rec_id 	INTO :ll_appt_stat_id 
			  FROM pd_affil_stat 
			 WHERE prac_id = :ll_prac_id AND parent_facility_id = :ll_facility_id AND active_status in (1,4) ;  

			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL Error 2", SQLCA.SQLERRTEXT )
				Return -1
			END IF				

			IF IsNull(ll_appt_stat_id) THEN ll_appt_stat_id = 0
			ls_field_arr = ls_field_arr + ', appt_stat_id, active_status'
			ls_value_arr = ls_value_arr + ',' + string(ll_appt_stat_id) +',  1' 
		END IF
		//---------End Added ---------------------------------------------------------------------	
		
		ls_sql = "insert into " + ls_table +" ( " + ls_field_arr + " ) values( " + ls_value_arr + " ) " 
		EXECUTE IMMEDIATE :ls_sql;
		//---------Begin Modified by (Appeon)Stephen 03.05.2015 for Allegheny Webview Audit--------
		//if sqlca.sqlcode <> 0 then return -1
		if sqlca.sqlcode <> 0 then
			is_sql_err = sqlca.sqlerrtext
			return -1
		end if
		//---------End Modfiied ------------------------------------------------------
end choose

if sqlca.sqlcode <> 0 then 
	is_sql_err = sqlca.sqlerrtext  //(Appeon)Stephen 03.05.2015 - Allegheny Webview Audit
	rollback using sqlca;
	return -1
end if

return 1
		
end function

public function integer of_audit_new (integer ai_tab, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_audit_new
// $<arguments>
// $<returns> integer
// $<description>Allegheny issue with webview audit accepting data
//////////////////////////////////////////////////////////////////////
// $<add> 02.05.2015 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_cnt, ll_rec_id,ll_screen_id
string ls_opt_type, ls_audit_type
string ls_opt_type_next
datetime ldt_date
long ll_table_id, ll_table_id_next,  ll_seq_no, ll_seq_no_next
string ls_table_name, ls_sql, ls_value_old
string ls_field_type, ls_value_new
integer  li_pos
datetime ldt_value_date
string  ls_field, ls_screen_name
string  ls_rec_id_sql, ls_audit_type_next
long  ll_field_id, ll_prac_id

if adw_detail.accepttext() = -1 then return -1

if ib_edit then
	if of_update_detail() = -1 then 
		return -1
	end if
	of_retrieve_dw(ai_tab)
	return 1
end if

if adw_detail.rowcount() < 1 then return -1
ldt_date = datetime( today(),now())

ll_cnt = messagebox('Prompt', 'Are you sure you want to perform the selected action for each audit record?',question!, YesNo!, 1)
if ll_cnt = 2 then return -1

//if of_create_screen_ds(adw_detail) = -1 then	
//	return -1
//end if

for ll_cnt = 1 to adw_detail.rowcount()
	ls_audit_type = adw_detail.getitemstring(ll_cnt, "sys_audit_audit_type")
	if isnull(ls_audit_type) or ls_audit_type = '' or ls_audit_type = 'QQW' then continue
	ls_opt_type = adw_detail.getitemstring(ll_cnt, "opt_type") 
	ll_rec_id     = adw_detail.getitemnumber(ll_cnt, "sys_audit_rec_id") 
	ll_table_id   = adw_detail.getitemnumber(ll_cnt, "sys_audit_table_id") 
	ll_seq_no   = adw_detail.getitemnumber(ll_cnt, "sys_audit_seq_no") 
	ll_screen_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_screen_id") 
	ls_table_name = adw_detail.getitemstring(ll_cnt, "sys_tables_table_name") 
	ls_value_old = adw_detail.getitemstring(ll_cnt, "sys_audit_old_value") 
	ls_field_type = adw_detail.getitemstring(ll_cnt, "sys_fields_field_type")
	ls_field = adw_detail.getitemstring(ll_cnt, "sys_fields_field_name")
	ll_field_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_field_id") 
	ll_prac_id = adw_detail.getitemnumber(ll_cnt, "sys_audit_prac_id")
	ls_screen_name = adw_detail.getitemstring(ll_cnt, "data_view_screen_screen_alias")
	
	if ll_cnt < adw_detail.rowcount() then
		ll_seq_no_next = adw_detail.getitemnumber(ll_cnt + 1, "sys_audit_seq_no") 
		ll_table_id_next = adw_detail.getitemnumber(ll_cnt + 1, "sys_audit_table_id") 
		ls_opt_type_next = adw_detail.getitemstring(ll_cnt + 1, "opt_type") 
		ls_audit_type_next = adw_detail.getitemstring(ll_cnt +1, "sys_audit_audit_type")
	else
		ll_table_id_next = 0
	end if
	
	if ls_audit_type = 'EQW' then
		ls_rec_id_sql = ls_rec_id_sql + string(ll_rec_id) + ","
		if ll_seq_no_next <> ll_seq_no or ll_table_id_next<>ll_table_id or ls_opt_type_next <> ls_opt_type or ls_audit_type_next<> 'EQW' then
			
		else			
			continue
		end if
	end if
	
	if not isvalid(w_package_gifofwait) then
		open(w_package_gifofwait)
		 w_package_gifofwait.st_2.visible = false
		 w_package_gifofwait.hpb_1.MaxPosition = adw_detail.rowcount()
		 w_package_gifofwait.title = "Auditing..." 
	end if
	
	w_package_gifofwait.st_1.text = "Auditing " + ls_screen_name + " in process " +", Please stand by!"
	w_package_gifofwait.BringToTop = TRUE
	w_package_gifofwait.hpb_1.Position = ll_cnt
	
	if len(ls_rec_id_sql) > 0 then ls_rec_id_sql = left(ls_rec_id_sql, len(ls_rec_id_sql) - 1)
	choose case ls_opt_type
		case "Skip"
			ls_rec_id_sql = ""
			continue
		case "Accept"			
			if ai_tab = 2 then
				if of_update_screen_new(ls_table_name, ll_seq_no, adw_detail) = -1 then 
					Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
					messagebox("Prompt", "Update Screen Data failed. Please make sure the data are correct!~r~n" + is_sql_err)
					return -1
				end if
				
				if of_audit_update_accept(adw_detail, ll_cnt) = -1 then 
					Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
					messagebox("Prompt", "Screen Data audit failed. Please make sure the data are correct!")
					return -1
				end if
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 11.23.2015
				//<$>reason:Moved to below because there is 'Commit using sqlca' in it.  For Bug id #4853 -Show Save Approval on Demographics tab Functionality
//				if of_create_dynamic_dw_new(ai_tab, ll_cnt, adw_detail, 'Save', ll_seq_no, ls_rec_id_sql) = -1 then
//					messagebox("Prompt", "Failed to dynamically create datawindow.")
//					return -1
//				end if
				//------------------- APPEON END -------------------
			end if
			
			//---------Begin Moved by (Appeon)Stephen 01.29.2015 for Allegheny issue with webview audit accepting data--------
			if ls_audit_type = 'IQW'  then
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where table_id = :ll_table_id
					 and seq_no  = :ll_seq_no;
					 
			elseif  ls_audit_type = 'EQW' then	
				//---------Begin Modified by (Appeon)Stephen 06.12.2016 for v14.2  failing WV Audit update--------
				/*
				ls_sql = "update sys_audit set audit_pending = 0, auditor ='" + gs_user_id + "', audit_date = '" + string(ldt_date) + "' where table_id = " + string(ll_table_id) +&
						   " and seq_no  = " + string(ll_seq_no) + " and rec_id in(" + ls_rec_id_sql +")"
							*/
				ls_sql = "update sys_audit set audit_pending = 0, auditor ='" + gs_user_id + "', audit_date = '" + string(ldt_date, 'yyyy-mm-dd hh:mm:ss') + "' where table_id = " + string(ll_table_id) +&
						   " and seq_no  = " + string(ll_seq_no) + " and rec_id in(" + ls_rec_id_sql +")"
				//---------End Modfiied ------------------------------------------------------
				
				EXECUTE IMMEDIATE :ls_sql;	
			else
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where rec_id   = :ll_rec_id
					 and seq_no  = :ll_seq_no
					 and field_id  = :ll_field_id;
			end if
			
			if sqlca.sqlcode <> 0 then
				Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
				messagebox("Prompt", "Update audit data failed!~r~n" + sqlca.sqlerrtext)
				return -1
			end if
			//---------End Modfiied ------------------------------------------------------
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 11.23.2015
			//<$>reason:Moved from above because there is 'Commit using sqlca' in it. For Bug id #4853 -Show Save Approval on Demographics tab Functionality
			if ai_tab = 2 then
				if of_create_dynamic_dw_new(ai_tab, ll_cnt, adw_detail, 'Save', ll_seq_no, ls_rec_id_sql) = -1 then
					Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
					messagebox("Prompt", "Failed to dynamically create datawindow.")
					return -1
				end if
			end if
			
			//------------------- APPEON END -------------------
		case "Reject"
				
			if ai_tab = 1  then 
				if  ls_audit_type = 'I-W' then
					gnv_appeondb.of_startqueue( )
					
					Delete from pd_images where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from verif_info where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from pd_app_audit_temp where de_rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
					Delete from pd_app_audit where de_rec_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
						
					choose case ll_screen_id
						case 2
							Delete from pd_address_link  where address_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
						case 10
							Delete from pd_hosp_facility_link where hosp_affil_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
						case 19
							Delete from pd_spec_facility_link  where specialty_id = :ll_seq_no and prac_id = :ll_prac_id  using sqlca;
					end choose					
					ls_sql = "delete from " + ls_table_name +  " where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id)
					gnv_appeondb.of_commitqueue( )	
					
					EXECUTE IMMEDIATE :ls_sql;
					if sqlca.sqlcode <> 0 then
						Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
						messagebox("Prompt", "Update Screen Data failed!~r~n" + sqlca.sqlerrtext )
						return -1
					end if
				elseif ls_audit_type = 'E-W' then
					if isnull(ls_field) or ls_field = '' then continue
					ls_value_new = ''
					
					choose case ls_field_type
						case 'D'
							if Len(ls_value_old) > 0 then //add if statement for Bug 4370 - alfee 12.18.2014
							//---------Begin Commented by (Appeon)Stephen 11.13.2015 for V14.2 WebView Bug #4845 - Entering dates with a 2 digit year (11/12/15) in WebView causes date to change to 1/1/1900 after acceptance --------
							/*
								li_pos = lastpos(ls_value_old, '/')	
								ls_value_new = mid(ls_value_old, li_pos + 1)  
								ls_value_old = left(ls_value_old, li_pos - 1)
								ls_value_old = ls_value_new + '/' + ls_value_old
								*/
							//------------------- APPEON End -------------------
								ldt_value_date = datetime(date(ls_value_old),time("00:00"))
								ls_value_old = string(ldt_value_date, 'yyyy-mm-dd hh:mm')
							end if
						case 'C' //(Appeon)Stephen 05.04.2015 - Allegheny Webview Acceptance Issue Case#54392 Bug_Id 4511
								ls_value_old = of_strip_char("'", ls_value_old, "''")
					end choose
					
					ls_sql = "update " + ls_table_name +" set " + ls_field + " = '" + ls_value_old + "' where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id)
					
					if (ls_field_type = 'D' or ls_field_type = 'N' or ls_field_type='l' or ls_field_type='I' or (ll_table_id = 9 and ls_field = 'admitting_priv')) and (isnull(ls_value_old) or ls_value_old = '') then //add 'or (ll_table_id = 9 and ls_field = 'admitting_priv')' from v14.2, by Appeon long.zhang 11.23.2015
						ls_sql = "update " + ls_table_name +" set " + ls_field + " = Null where rec_id = " + string(ll_seq_no) + " and prac_id = " + string(ll_prac_id) //Bug 4370 - alfee 12.18.2014
					end if
					
					EXECUTE IMMEDIATE :ls_sql;
					if sqlca.sqlcode <> 0 then
						Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
						messagebox("Prompt", "Update Screen Data failed!~r~n" + sqlca.sqlerrtext )
						return -1
					end if
		
					//------------------- APPEON BEGIN -------------------
					//<$>added:long.zhang 11.25.2015
					//<$>reason:It may commit tran. So move it to the end of the script, for Bug id #4853 -Show Save Approval on Demographics tab Functionality.					
//					if of_create_dynamic_dw(ai_tab, ll_cnt, adw_detail, 'Save') = -1 then
//						messagebox("Prompt", "Failed to dynamically create datawindow.")
//						return -1
//					end if
					//------------------- APPEON END -------------------
				end if
			elseif ai_tab = 2  then
				if ls_audit_type = 'IQW' then
					Delete from pd_images where rec_id = :ll_seq_no and prac_id = :ll_prac_id using sqlca;
				end if
			end if
			//---------Begin Moved by (Appeon)Stephen 01.29.2015 for Allegheny issue with webview audit accepting data--------
			if  ls_audit_type = 'IQW'  then
				//(Appeon)Stephen 09.16.2015 - modify 'audit_rejected = 0' to 'audit_rejected = 1' --Issues with WebView columns in Audit trail
				update sys_audit
					  set audit_pending = 0,
							audit_rejected = 1,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				 where table_id = :ll_table_id
					 and seq_no  = :ll_seq_no;
			elseif  ls_audit_type = 'EQW' then
				//---------Begin Modified by (Appeon)Stephen 06.12.2016 for v14.2  failing WV Audit update--------
				/*
				ls_sql = "update sys_audit set audit_pending = 0, auditor ='" + gs_user_id + "', audit_date = '" + string(ldt_date) + "' where table_id = " + string(ll_table_id) +&
						   " and seq_no  = " + string(ll_seq_no) + " and rec_id in(" + ls_rec_id_sql +")"
							*/
				ls_sql = "update sys_audit set audit_pending = 0, auditor ='" + gs_user_id + "', audit_date = '" + string(ldt_date, 'yyyy-mm-dd hh:mm:ss') + "' where table_id = " + string(ll_table_id) +&
						   " and seq_no  = " + string(ll_seq_no) + " and rec_id in(" + ls_rec_id_sql +")"
				//---------End Modfiied ------------------------------------------------------
				
				EXECUTE IMMEDIATE :ls_sql;	
			else
				update sys_audit
					  set audit_pending = 0,
						  auditor = :gs_user_id,
						  audit_date = :ldt_date
				  where rec_id   = :ll_rec_id
					 and seq_no  = :ll_seq_no
					 and field_id  = :ll_field_id;
			end if
			
			if sqlca.sqlcode <> 0 then
				Rollback Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
				messagebox("Prompt", "Update audit data failed!~r~n" + sqlca.sqlerrtext )
				return -1
			end if
			//---------End Modfiied ------------------------------------------------------
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 11.25.2015
			//<$>reason:It may commit SQLCA. So move it from above, for Bug id #4853 -Show Save Approval on Demographics tab Functionality.
			If ai_tab = 1  then 
				If ls_audit_type = 'E-W' then
					if of_create_dynamic_dw(ai_tab, ll_cnt, adw_detail, 'Save') = -1 then
						Rollback Using SQLCA;
						messagebox("Prompt", "Failed to dynamically create datawindow.")
						return -1
					end if
				End If
			End If
			//------------------- APPEON END -------------------
	end choose
	ls_rec_id_sql = ""	 
	 
	Commit Using SQLCA;//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	Yield()//Refresh UI, Added by Appeon long.zhang 11.23.2015
next
commit using sqlca;
of_retrieve_dw(ai_tab)

return 1
end function

public function integer of_create_dynamic_dw_new (integer ai_tab, long al_row, u_dw adw_detail, string as_type, long al_seq_no, string as_rec_id_sql);//////////////////////////////////////////////////////////////////////
// $<function> of_create_dynamic_dw
// $<arguments>
// $<returns> integer
// $<description>Allegheny issue with webview audit accepting data
//////////////////////////////////////////////////////////////////////
// $<add> 02.06.2015 by Stephen
//////////////////////////////////////////////////////////////////////

string    ls_sql_syntax, ls_sql
long      ll_row, ll_prac_id, ll_seq, ll_pos
integer  li_screen_id,  li_facility
string    ls_audit_type, ls_fieldname
long      ll_rec_id, ll_field_id, ll_table_id
datetime ldt_date
string ls_msg, ls_table_name
string   ls_old_value, ls_new_value //(V15 DE Update) alfee 11.16.2016
dwitemstatus lds_status
datastore lds_detail

if al_row < 1 then return -1

//n_import_ds lds_screen, lds_affil_stat
			
//lds_detail = create datastore
//lds_detail.dataobject = adw_detail.dataobject
//lds_detail.settransobject(sqlca)
//adw_detail.rowscopy(1, adw_detail.rowcount(), primary!, lds_detail,1,primary!)
//yield()
//lds_detail.setfilter("sys_tables_table_name = '"+as_table_name+"' and import_audit_item_seq_no = "+string(al_seq_no))
//lds_detail.filter()
//
//if lds_detail.rowcount() < 1 then return -1

if as_type = 'edit' then 
	ls_msg = "Are you sure you want to edit the current record? ~r~n" + &
				 "By proceeding to 'Edit Data' the changes logged in this audit record ~r~n" + &
			 	 "will be fully committed and saved to the database. ~r~n" +&
				 "Any changes you make on the Edit screen will also be committed immediately."
	
	if messagebox("Prompt", ls_msg, Exclamation!, okcancel!, 2) = 2 then 
		adw_detail.setitem(al_row, 'opt_type', adw_detail.getitemstring(al_row,  'opt_type', primary!, false))
		return -1
	end if
	
	ll_seq = adw_detail.getitemnumber(al_row, "sys_audit_seq_no")
	ls_table_name = adw_detail.getitemstring(al_row, "sys_tables_table_name") 
	if ai_tab = 2 then
		if of_update_screen_new(ls_table_name, ll_seq, adw_detail) <> 1 then return -1
		if of_audit_update_accept(adw_detail, al_row) = -1 then return -1
	end if
	
	ll_rec_id = adw_detail.getitemnumber(al_row, "sys_audit_rec_id")
	ll_field_id = adw_detail.getitemnumber(al_row, "sys_audit_field_id")
	ldt_date = datetime(today(), now())
	ll_table_id   = adw_detail.getitemnumber(al_row, "sys_audit_table_id") 
	ls_audit_type = adw_detail.getitemstring(al_row, "sys_audit_audit_type") 
	
	if ai_tab = 2 then
//		if ls_audit_type = 'EQW' then //add by stephen 04.01.2012 BugS040101
//			update sys_audit
//			  set audit_pending = 0,
//				  auditor = :gs_user_id,
//				  audit_date = :ldt_date
//		  where  rec_id  = :ll_rec_id
//			  and field_id = :ll_field_id
//			and seq_no = :ll_seq using sqlca;
//		else
		if  ls_audit_type = 'IQW'  then
			update sys_audit
				  set audit_pending = 0,
					  auditor = :gs_user_id,
					  audit_date = :ldt_date
			  where table_id = :ll_table_id
				 and seq_no  = :ll_seq using sqlca;
		end if
		if ls_audit_type = 'EQW' then			
			ls_sql = "update sys_audit set audit_pending = 0, auditor ='" + gs_user_id + "', audit_date = '" + string(ldt_date) + "' where table_id = " + string(ll_table_id) +&
						   " and seq_no  = " + string(ll_seq) + " and rec_id in(" + as_rec_id_sql +")"
			EXECUTE IMMEDIATE :ls_sql;	
		end if
	else	 
		update sys_audit
			  set audit_pending = 0,
				  auditor = :gs_user_id,
				  audit_date = :ldt_date
		  where  rec_id  = :ll_rec_id
			  and field_id = :ll_field_id
			and seq_no = :ll_seq using sqlca;
	end if
		
	if sqlca.sqlcode = 0 then 
		commit using sqlca;
	else
		rollback using sqlca;
		return -1
	end if
end if
		
ll_prac_id    =   adw_detail.getitemnumber(al_row, "sys_audit_prac_id")
li_screen_id =   adw_detail.getitemnumber(al_row, "sys_audit_screen_id") 
li_facility      =   adw_detail.getitemnumber(al_row, "sys_audit_facility_id") 
ll_seq          =   adw_detail.getitemnumber(al_row, "sys_audit_seq_no") 
ls_audit_type = adw_detail.getitemstring(al_row, "sys_audit_audit_type") 
ls_fieldname = adw_detail.getitemstring(al_row, "sys_fields_field_name")
ls_old_value = adw_detail.getitemstring(al_row, "sys_audit_old_value") //(V15 DE Update) alfee 11.16.2016
ls_new_value = adw_detail.getitemstring(al_row, "sys_audit_new_value") //(V15 DE Update) alfee 11.16.2016

if isnull(li_facility) then li_facility = 0

//------------------- APPEON BEGIN -------------------
//$<add>Stephen 04.11.2012
//$<reason>get rec_id
IF li_screen_id = 61 or li_screen_id = 32 or li_screen_id = 33 THEN
	if ls_audit_type = 'IQW' and il_rec_id_spe <> 0 then
		ll_seq = il_rec_id_spe
	end if
end if
//------------------- APPEON END -------------------			
					
if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if

inv_data_entry.ib_report = false
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()

ls_sql_syntax = inv_data_entry.of_create_dynamic_dw( ll_prac_id, 1, li_screen_id, dw_detail, dw_detail, false, li_facility, true )

ls_sql_syntax = dw_detail.getsqlselect()
ll_pos = pos(lower(ls_sql_syntax), 'order by' )
	
if pos(lower(ls_sql_syntax), 'where') > 0 then
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " and rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " and rec_id = "+string(ll_seq)+" "
	end if
else
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " where rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " where rec_id = "+string(ll_seq)+" "
	end if
end if

dw_detail.setsqlselect(ls_sql_syntax)
ll_row = dw_detail.retrieve()

il_prac_id = ll_prac_id
il_rec_id  = ll_seq
ii_screen_id = li_screen_id

if as_type = 'edit' then
	//---------Begin Modified by (Appeon)Stephen 08.28.2015 for Allegheny having an issue with audit trail for a provider--------
	//if ll_row = 0 then dw_detail.insertrow(0)
	//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname) //add by stephen 04.01.2012 --BugS040102
	if ll_row = 0 then 
		dw_detail.insertrow(0)
	else
		//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname) //add by stephen 04.01.2012 --BugS040102
		dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname, ls_old_value, ls_new_value) //(V15 DE Update) alfee 11.16.2016
	end if
	//---------End Modfiied ------------------------------------------------------
	
	adw_detail.visible = false
	idw_audit_detail = adw_detail
	ib_edit = true
	dw_detail.visible = true
else
	if ll_row < 1 then return 1
	//dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname) //add by stephen 04.01.2012 --BugS040102
	dw_detail.event ue_update(ls_audit_type, li_facility, ls_fieldname, ls_old_value, ls_new_value) //(V15 DE Update) alfee 11.16.2016
	lds_status =  dw_detail.getitemstatus(1, 0,primary!)
	if lds_status <> notmodified! then
		dw_detail.setitemstatus(1,0,primary!,notmodified!)
	end if
end if

return 1
end function

public function integer of_adjust_ui ();//====================================================================
//$<Function>: of_adjust_ui()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Adjust UI for V15.1 WV Audit of Images
//$<Author>: Alfee 08.05.2015
//====================================================================

//---------Begin Modified by (Appeon)Stephen 12.12.2015 for BugS112601--------
/*
This.SetRedraw(False)
tab_1.tabpage_1.dw_list1.height = tab_1.tabpage_1.dw_list1.height - (tab_1.tabpage_1.dw_audit1.y - tab_1.tabpage_1.dw_list1.y)
tab_1.tabpage_1.dw_list1.y = tab_1.tabpage_1.dw_audit1.y
tab_1.tabpage_2.dw_list2.height = tab_1.tabpage_2.dw_list2.height - (tab_1.tabpage_2.dw_audit2.y - tab_1.tabpage_2.dw_list2.y)
tab_1.tabpage_2.dw_list2.y = tab_1.tabpage_2.dw_audit2.y
tab_1.tabpage_1.dw_list1.height = tab_1.tabpage_1.dw_list1.height - (tab_1.tabpage_1.dw_audit1.y - tab_1.tabpage_1.dw_list1.y)
tab_1.tabpage_1.dw_list1.y = tab_1.tabpage_1.dw_audit1.y
*/
tab_1.tabpage_1.dw_list1.y = tab_1.tabpage_1.dw_audit1.y
tab_1.tabpage_2.dw_list2.y = tab_1.tabpage_2.dw_audit2.y
//---------End Modified ------------------------------------------------------

tab_1.tabpage_1.gb_opt1.visible = True
tab_1.tabpage_1.rb_de1.visible = True
tab_1.tabpage_1.rb_doc1.visible = True

tab_1.tabpage_2.gb_opt2.visible = True
tab_1.tabpage_2.rb_de2.visible = True
tab_1.tabpage_2.rb_doc2.visible = True

//This.SetRedraw(True)  //Commented by (Appeon)Stephen 12.12.2015 - BugS112601

RETURN 1
end function

public function integer of_change_dw (string as_opt);//====================================================================
//$<Function>: of_change_dw()
//$<Arguments>:string as_opt
//$<Return>:  integer
//$<Description>:Set and refresh DataWindows while changing the options for V15.1 WV Audit of Images
//$<Author>: Alfee 08.10.2015
//====================================================================
Integer li_tab
u_dw ldw_list, ldw_detail, ldw_pd_images

//Set dataobjects
CHOOSE CASE Upper(as_opt)
	CASE 'DE1'
		IF NOT ib_audit_doc1 THEN RETURN 1

		li_tab = 1
		ib_audit_doc1 = FALSE
		ldw_list = tab_1.tabpage_1.dw_list1
		ldw_detail = tab_1.tabpage_1.dw_audit1
		ldw_pd_images = tab_1.tabpage_1.dw_pd_images1
		ldw_list.dataobject = 'd_prac_audit_list'
		ldw_detail.dataobject = 'd_prac_audit_detail'
	CASE 'DOC1'
		IF ib_audit_doc1 THEN RETURN 1		
		
		li_tab = 1
		ib_audit_doc1 = TRUE
		ldw_list = tab_1.tabpage_1.dw_list1
		ldw_detail = tab_1.tabpage_1.dw_audit1
		ldw_pd_images = tab_1.tabpage_1.dw_pd_images1
		ldw_list.dataobject = 'd_prac_audit_list_images'
		ldw_detail.dataobject = 'd_prac_audit_detail_wvimages1'				
	CASE 'DE2'
		IF NOT ib_audit_doc2 THEN RETURN 1

		li_tab = 2
		ib_audit_doc2 = FALSE
		ldw_list = tab_1.tabpage_2.dw_list2
		ldw_detail = tab_1.tabpage_2.dw_audit2		
		ldw_pd_images = tab_1.tabpage_2.dw_pd_images2
		ldw_list.dataobject = 'd_prac_audit_list'
		ldw_detail.dataobject = 'd_prac_audit_detail'
	CASE 'DOC2'
		IF ib_audit_doc2 THEN RETURN 1		

		li_tab = 2
		ib_audit_doc2 = TRUE
		ldw_list = tab_1.tabpage_2.dw_list2
		ldw_detail = tab_1.tabpage_2.dw_audit2
		ldw_pd_images = tab_1.tabpage_2.dw_pd_images2
		ldw_list.dataobject = 'd_prac_audit_list_images'
		ldw_detail.dataobject = 'd_prac_audit_detail_wvimages2'		
END CHOOSE

//Retrieve datails
ldw_list.SetTransObject(SQLCA)
ldw_detail.SetTransObject(SQLCA)				
of_retrieve_dw(li_tab)		

//Adjust positions of DWs
This.SetRedraw(False)
IF Upper(Left(as_opt,2)) = 'DE' THEN
	ldw_pd_images.visible = FALSE
	//---------Begin Modified by (Appeon)Stephen 12.12.2015 for BugS112601--------
	//ldw_detail.height = 1776 
	 ldw_detail.height = tab_1.height - 250
	//---------End Modfiied ------------------------------------------------------
ELSE
	ldw_pd_images.visible = TRUE
	//---------Begin Modified by (Appeon)Stephen 12.12.2015 for BugS112601--------
	//ldw_detail.height = 1412  
	ldw_detail.height = tab_1.height - ldw_pd_images.height - 260
	ldw_pd_images.y = ldw_detail.y + ldw_detail.height + 4
	//---------End Modfiied ------------------------------------------------------
END IF
This.SetRedraw(True)

RETURN 1
end function

public function integer of_retrieve_dw_doc (integer ai_tab);//////////////////////////////////////////////////////////////////////
// $<Function> of_retrieve_dw_doc
// $<arguments>integer ai_tab
// $<returns> integer
// $<description>Retrieve data for documents audit
//////////////////////////////////////////////////////////////////////
// $<add> (V15.1 WV Audit of Images) - Alfee 08.07.2015
//////////////////////////////////////////////////////////////////////

long    ll_lookup_code
long ll_row, ll_prac_id
string ls_fullname, ls_fullname_old
string  ls_code
string ls_type[]

datawindowchild ldwc_1
u_dw  ldw_list, ldw_detail

choose case ai_tab
	case 1
		ldw_list =  tab_1.tabpage_1.dw_list1
		ldw_detail = tab_1.tabpage_1.dw_audit1
		ls_type[1] = 'I-W'
		ls_type[2] = 'E-W'
		ldw_list.retrieve(ls_type, gs_user_id)
		
	case 2
		ldw_list =  tab_1.tabpage_2.dw_list2
		ldw_detail = tab_1.tabpage_2.dw_audit2
		ls_type[1] = 'IQW'
		ls_type[2] = 'EQW'
		ldw_list.retrieve(ls_type, gs_user_id) 
end choose

for ll_row = ldw_list.rowcount() to 1 step -1
	if isnull(ldw_list.getitemnumber(ll_row, 'v_full_name_prac_id')) then ldw_list.deleterow(ll_row)
next

ldw_detail.setredraw(false)
if ldw_list.rowcount() > 0 then
	 ldw_list.scrolltorow(1)
	 ldw_list.selectrow(0, false)
	 ldw_list.selectrow(1, true) 
	 
	ll_prac_id = ldw_list.getitemnumber(1,'v_full_name_prac_id')
	ldw_detail.retrieve(ll_prac_id, gs_user_id)	
	
	if ldw_detail.getchild("facility_id", ldwc_1 ) = 1 then
		ldwc_1.settransobject(sqlca)
		ldwc_1.retrieve(gs_user_id)
	end if
	
	for ll_row = 1 to ldw_detail.rowcount()
		ldw_detail.setitem(ll_row, 'opt_type', 'Accept')
	next
else
	ldw_detail.reset()
end if
this.title = 'Audit Trail - Approve or Reject Documents for Provider'

ldw_detail.setredraw(true)

return 1
end function

public function integer of_retrieve_detail_doc (long al_row, u_dw adw_list, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<Function> of_retrieve_detail_doc
// $<arguments>long al_row, u_dw adw_list, adw_detail
// $<returns> integer
// $<description>Retrieve data in the document detail
//////////////////////////////////////////////////////////////////////
// $<add> (V15.1 WV Audit of Images) - Alfee 08.07.2015
//////////////////////////////////////////////////////////////////////
long  ll_prac_id, ll_row

if al_row < 1 then return 0

adw_list.selectrow(0,false)
adw_list.scrolltorow(al_row)
adw_list.selectrow(al_row, true)

ll_prac_id = adw_list.getitemnumber(al_row,'v_full_name_prac_id')

adw_detail.setredraw(false)

adw_detail.retrieve(ll_prac_id, gs_user_id)	

for ll_row = 1 to adw_detail.rowcount()
	adw_detail.setitem(ll_row, 'opt_type', 'Accept')
next

adw_detail.setredraw(true)

return 1
end function

public function integer of_audit_rowfocuschanged (integer ai_tab, long al_currentrow);//(V15.1 WV Audit of Images) - Alfee 08.10.2015
Long ll_image_pk, ll_image_pk_hist
String ls_audit_type
u_dw ldw_audit, ldw_pd_images
datawindowchild ldwc_1

//Choose DataWindows
CHOOSE CASE ai_tab
	CASE 1
		ldw_audit = tab_1.tabpage_1.dw_audit1
		ldw_pd_images = tab_1.tabpage_1.dw_pd_images1
	CASE 2
		ldw_audit = tab_1.tabpage_2.dw_audit2
		ldw_pd_images = tab_1.tabpage_2.dw_pd_images2
	CASE ELSE
		RETURN 0
END CHOOSE

ldw_pd_images.SetRedraw (FALSE)

IF al_currentrow < 1 THEN
	ldw_pd_images.Reset()
ELSE
	//Select row
	IF ldw_audit.IsSelected(al_currentrow) = FALSE THEN
		ldw_audit.SelectRow(0, FALSE)
		ldw_audit.SelectRow(al_currentrow, TRUE)			
	END IF

	ll_image_pk = ldw_audit.GetItemNumber(al_currentrow, "image_pk")
	ll_image_pk_hist = ldw_audit.GetItemNumber(al_currentrow, "image_pk_hist")
	ls_audit_type = ldw_audit.GetItemString(al_currentrow, "audit_type")
	
	//Retrieve DDDW
	IF ldw_pd_images.GetChild ("facility_id", ldwc_1 ) = 1 THEN
		ldwc_1.SetTransObject(SQLCA)
		IF ldwc_1.RowCount () < 1 THEN ldwc_1.Retrieve (gs_user_id)		
	END IF		
	
	//Retrieve image records
	CHOOSE CASE ls_audit_type
		CASE 'IQW', 'I-W'
			ldw_pd_images.Reset()
		CASE 'EQW'
			ldw_pd_images.Retrieve(ll_image_pk, gs_user_id)
		CASE 'E-W'	
			ldw_pd_images.Retrieve(ll_image_pk_hist, gs_user_id)
	END CHOOSE
END IF

IF	ldw_pd_images.RowCount () < 1 THEN
//	ldw_pd_images.InsertRow(0)	- commented by alfee 03.24.2016
END IF

ldw_pd_images.SetRedraw (TRUE)		
	
RETURN 1
end function

public function integer of_get_image (long al_image_pk, ref blob ablb_image_data, boolean ab_wv_image);//Get image data from pd_images/wv_pd_images (V15.1 WV Audit of Images) - Alfee 08.12.2015
Integer li_counter, li_loops
Long ll_data_length, ll_start
Blob lb_data, lb_all_data
	
//For WEB version or ASA DB
IF appeongetclienttype() <> 'PB'  OR gs_dbtype <> 'SQL' THEN
	IF ab_wv_image THEN
		SELECTBLOB image_data INTO :ablb_image_data FROM wv_pd_images WHERE wv_image_pk = :al_image_pk; 
	ELSE
		SELECTBLOB image_data INTO :ablb_image_data FROM pd_images WHERE image_pk = :al_image_pk; 
	END IF
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		RETURN -1
	END IF
	
	RETURN 1
END IF

//For PB and SQL Server
IF ab_wv_image THEN
	SELECT Datalength(image_data) INTO :ll_data_length FROM wv_pd_images WHERE wv_image_pk = :al_image_pk;
ELSE
	SELECT Datalength(image_data) INTO :ll_data_length FROM pd_images WHERE image_pk = :al_image_pk;
END IF

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	RETURN 0
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	Yield()
	SetPointer(HourGlass!)
	
	ll_start = (li_counter - 1) * 8000 + 1
	
	IF ab_wv_image THEN
		SELECTBLOB substring(image_data,:ll_start,8000) INTO :lb_data FROM wv_pd_images WHERE wv_image_pk = :al_image_pk;
	ELSE
		SELECTBLOB substring(image_data,:ll_start,8000) INTO :lb_data FROM pd_images WHERE image_pk = :al_image_pk;
	END IF

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		RETURN -1
	END IF

	lb_all_data += lb_data
NEXT 

ablb_image_data = lb_all_data

RETURN 1
	
	
end function

public function integer of_audit_image (integer ai_tab, u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function> of_audit_image
// $<arguments>integer ai_tab; u_dw adw_detail
// $<returns> integer
// $<description>Audit image records
//////////////////////////////////////////////////////////////////////
// $<add>(V15.1 WV Audit of Images) - Alfee 08.12.2015
//////////////////////////////////////////////////////////////////////
Integer li_rtn
Long ll_cnt, ll_rec_id, ll_prac_id, ll_facility_id
Long ll_wv_image_pk, ll_image_pk, ll_image_pk_hist
Long ll_screen_id, ll_seq_no, ll_image_type_id, ll_audit_rejected
String ls_opt_type, ls_audit_type, ls_image_desc
String ls_user_name, ls_notes, ls_reference_name, ls_file_name
DateTime ldt_date, ldt_date_scanned, ldt_date_recieved, ldt_modify_date

IF adw_detail.RowCount() < 1 THEN RETURN 0
IF adw_detail.AcceptText() = -1 THEN RETURN -1

ll_cnt = MessageBox('Prompt', 'Are you sure you want to perform the selected action for each audit record?',Question!, YesNo!, 1)
IF ll_cnt = 2 THEN RETURN 0

ldt_date = DateTime( Today(), Now())
ids_pd_images.Reset()
//---------Begin Added by (Appeon)Stephen 11.03.2016 for V15.3-Image Auditing in IntelliCred--------
if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if
//---------End Added ------------------------------------------------------

FOR ll_cnt = 1 TO adw_detail.RowCount()
	//Get key values
	ls_opt_type = adw_detail.getitemstring(ll_cnt, "opt_type") 
	ls_audit_type = adw_detail.getitemstring(ll_cnt, "audit_type")
	IF IsNull(ls_opt_type) OR ls_opt_type = 'Skip' THEN CONTINUE
	IF IsNull(ls_audit_type) OR ls_audit_type = '' THEN CONTINUE
	
	ll_wv_image_pk	= adw_detail.GetItemNumber(ll_cnt, "wv_image_pk")   
	ll_image_pk			= adw_detail.GetItemNumber(ll_cnt, "image_pk")   
	ll_image_pk_hist	= adw_detail.GetItemNumber(ll_cnt, "image_pk_hist")  
	ls_image_desc		= adw_detail.GetItemString(ll_cnt, "image_type_description")  
	
	//Set progress info
	IF NOT IsValid(w_package_gifofwait) THEN
		OPEN(w_package_gifofwait)
		 w_package_gifofwait.st_2.Visible = FALSE
		 w_package_gifofwait.hpb_1.MaxPosition = adw_detail.RowCount()
		 w_package_gifofwait.title = "Auditing..." 
	END IF
	w_package_gifofwait.st_1.text = "Auditing " + ls_image_desc + " in process " +", Please stand by!"
	w_package_gifofwait.BringToTop = TRUE
	w_package_gifofwait.hpb_1.Position = ll_cnt
	
	Yield ()
	
	//Process data
	CHOOSE CASE ls_opt_type
		CASE "Accept"
			//Accept for Level 1
			IF ai_tab = 2 THEN 
				//Insert new image, set history for EQW and update other data
				li_rtn = of_insert_image (adw_detail, ll_cnt) //included code in a single fun for performance
				CONTINUE
			//Accept for Level 2	
			ELSE 
				//Do nothing in pd_images
			END IF	
			SetNull (ll_audit_rejected)						
		CASE "Reject"		
			//Reject for Level 2
			IF ai_tab = 1 THEN 
//				gnv_appeondb.of_startqueue()
				//Delete current record for both I-W & E-W
				Delete From pd_images Where image_pk = :ll_image_pk;	
				//---------Begin Added by (Appeon)Stephen 11.03.2016 for V15.3-Image Auditing in IntelliCred--------
				ll_prac_id = adw_detail.GetItemNumber(ll_cnt, "prac_id") 
				ll_facility_id = adw_detail.GetItemNumber(ll_cnt, "facility_id") 
				inv_data_entry.of_sqlfield_audit(ll_prac_id, ll_image_pk, ll_facility_id, 95, "1001", 'Delete', string(ll_image_pk) + '-'+ string(ll_prac_id), 'D')
				//---------End Added ------------------------------------------------------

				//Restore history to current for E-W
				IF  ls_audit_type = 'E-W' THEN
					Update pd_images Set active_status = 1 Where image_pk = :ll_image_pk_hist; 
					inv_data_entry.of_sqlfield_audit(ll_prac_id, ll_image_pk_hist, ll_facility_id, 95, "active_status", '1', '0', 'E') //(Appeon)Stephen 11.03.2016 - V15.3-Image Auditing in IntelliCred
				END IF
//				gnv_appeondb.of_commitqueue()
				
			//Reject for Level 1
			ELSE
				//Do nothing in pd_images
			END IF
			ll_audit_rejected = 1
	END CHOOSE
	
	IF SQLCA.SQLCode < 0 THEN 
		MessageBox ("Warning", "Failed to update the record due to ~r~n" + SQLCA.SQLErrText)
		CONTINUE
	END IF
		
	//Update audit record for Level 1 & 2 
	Update wv_pd_images Set audit_pending=0, audit_rejected=:ll_audit_rejected, auditor=:gs_user_id, audit_date=:ldt_date Where wv_image_pk=:ll_wv_image_pk;
	
	IF SQLCA.SQLCode <> 0 THEN 
		MessageBox ("Warning", "Failed to update the audit record due to ~r~n" + SQLCA.SQLErrText)
	END IF
NEXT

//Refresh records
of_retrieve_dw (ai_tab)

RETURN 1

end function

public function integer of_insert_image (u_dw adw_detail, long al_row);//====================================================================
//$<Function>: of_insert_image()
//$<Arguments>:
// 	value    u_dw    adw_detail
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: Insert new image record to pd_images
//$<Author>: (V15.1 WV Audit of Images) - Alfee 08.13.2015
//====================================================================
Long ll_wv_image_pk, ll_image_pk, ll_image_pk_ori, ll_cnt
Long ll_rec_id, ll_prac_id, ll_facility_id
Long ll_screen_id, ll_seq_no, ll_image_type_id
String ls_user_name, ls_notes, ls_reference_name, ls_file_name
String ls_image_desc, ls_audit_type, ls_find
DateTime ldt_now, ldt_date_scanned, ldt_date_recieved, ldt_modify_date

IF IsNull(al_row) OR al_row < 1 THEN RETURN -1
IF IsNull(adw_detail) OR al_row > adw_detail.RowCount () THEN RETURN -1

ldt_now				= DateTime(Today(), Now())
ll_image_pk_ori 	= adw_detail.GetItemNumber(al_row, "image_pk") //for EQW
ll_wv_image_pk 	= adw_detail.GetItemNumber(al_row, "wv_image_pk") 
ll_rec_id  			= adw_detail.GetItemNumber(al_row, "rec_id") 
ll_prac_id 			= adw_detail.GetItemNumber(al_row, "prac_id")
ll_facility_id			= adw_detail.GetItemNumber(al_row, "facility_id")
//ll_seq_no			= adw_detail.GetItemNumber(al_row, "seq_no") 
ll_screen_id 		= adw_detail.GetItemNumber(al_row, "screen_id") 
ldt_date_scanned  = adw_detail.GetItemDateTime(al_row, "date_scanned") 
ls_user_name		= adw_detail.GetItemString(al_row, "user_name") 
ldt_date_recieved  = adw_detail.GetItemDateTime(al_row, "date_recieved") 
ls_notes				= adw_detail.GetItemString(al_row, "notes") 
ls_reference_name= adw_detail.GetItemString(al_row, "reference_name") 
ll_image_type_id   = adw_detail.GetItemNumber(al_row, "image_type_id") 
ls_file_name 		= adw_detail.GetItemString(al_row, "file_name") 
ldt_modify_date	= adw_detail.GetItemDateTime(al_row, "modify_date") 
ls_audit_type 		= adw_detail.GetItemString(al_row, "audit_type")
ls_image_desc		= adw_detail.GetItemString(al_row, "image_type_description")  

//Check duplicate record
IF Upper(ls_audit_type) = 'IQW' THEN
	IF ids_pd_images.RowCount () < 1 THEN ids_pd_images.Retrieve (ll_prac_id)
	ll_cnt = ids_pd_images.RowCount ()
	IF ll_cnt > 0 THEN
		ls_find = "rec_id=" + String(ll_rec_id)  + " and facility_id in (0," + String(ll_facility_id)+ ") and "
		ls_find = ls_find + " ((screen_id<>1 and screen_id=" + String(ll_screen_id) + ") or (screen_id=1 and image_type_id=" + String(ll_image_type_id) + "))"
		IF ids_pd_images.Find (ls_find, 1, ll_cnt) > 0 THEN
			MessageBox("Duplicate Record","The image for " + ls_image_desc + " connected to the record '" + ls_reference_name + "' already exists for this Group/Facility.")
			RETURN -1
		END IF
	END IF
END IF

//Get the seq no. - alfee 09.09.2015
SELECT IsNull(Max(seq_no),0) INTO :ll_seq_no 
  FROM pd_images 
 WHERE prac_id =:ll_prac_id AND facility_id in (:ll_facility_id, 0)
	AND ((screen_id<>1 and screen_id =:ll_screen_id and rec_id = :ll_rec_id)  OR 
	        (screen_id=1 and  screen_id =:ll_screen_id and image_type_id=:ll_image_type_id));

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
END IF

ll_seq_no ++

gnv_appeondb.of_startqueue ()
//Modified by (APPEON) Harry 12.07.2017 (V161 Storage of Documents as PDFs) - Add image_ext
//Insert new record
INSERT INTO pd_images 
			       ( rec_id, prac_id, facility_id, seq_no, screen_id, date_scanned, user_name, date_recieved, active_status, 
				    notes, reference_name,	tif_start_page, image_type_id,	file_name, modify_date, image_ext)
        VALUES ( :ll_rec_id, :ll_prac_id, :ll_facility_id, :ll_seq_no, :ll_screen_id, :ldt_date_scanned, :ls_user_name, :ldt_date_recieved, 1,
					 'Uploaded through WebView', :ls_reference_name,	1, 	:ll_image_type_id, :ls_file_name, :ldt_modify_date, 'TIF');
	
//Select the new image_pk
SELECT MAX(image_pk) INTO :ll_image_pk 
  FROM pd_images 
 WHERE rec_id=:ll_rec_id  AND prac_id =:ll_prac_id AND facility_id = :ll_facility_id
      AND screen_id = :ll_screen_id AND image_type_id =:ll_image_type_id
	 AND seq_no = :ll_seq_no  AND  active_status = 1	; 	
	
gnv_appeondb.of_commitqueue ()

IF SQLCA.SQLCode <> 0 OR ll_image_pk = 0 THEN 
	MessageBox ("Warning", "Failed to insert the record due to ~r~n" + SQLCA.SQLErrText)
	RETURN -1
END IF
inv_data_entry.of_sqlfield_audit(ll_prac_id, ll_image_pk, ll_facility_id, 95, '1000', string(ll_image_pk) +"-"+string(ll_prac_id), '', 'I') //(Appeon)Stephen 11.03.2016 - V15.3-Image Auditing in IntelliCred
gnv_appeondb.of_startqueue ()

//Update blob data
UPDATE pd_images 
	  SET image_data = wv_pd_images.image_data
	FROM wv_pd_images
  WHERE wv_pd_images.wv_image_pk = :ll_wv_image_pk
  	  AND pd_images.image_pk = :ll_image_pk ;
//	  AND pd_images.rec_id = :ll_rec_id AND pd_images.prac_id = :ll_prac_id AND pd_images.facility_id IN (0, :ll_facility_id) 
//	  AND pd_images.active_status = 1 AND 	pd_images.seq_no = :ll_seq_no  
// 	  AND ((pd_images.screen_id <> 1 AND pd_images.screen_id = :ll_screen_id) OR (pd_images.screen_id = 1 AND pd_images.image_type_id =:ll_image_type_id)) ;

//Set current to history for EQW and update data in wv_pd_images
IF ls_audit_type = 'EQW' THEN  
	UPDATE pd_images SET active_status = 0 WHERE image_pk = :ll_image_pk_ori;
	inv_data_entry.of_sqlfield_audit(ll_prac_id, ll_image_pk_ori, ll_facility_id, 95, "active_status", '0', '1', 'E') //(Appeon)Stephen 11.03.2016 - V15.3-Image Auditing in IntelliCred

	UPDATE wv_pd_images SET image_pk_hist=image_pk, image_pk=:ll_image_pk, seq_no=:ll_seq_no, audit_pending=0, auditor=:gs_user_id, audit_date=:ldt_now WHERE wv_image_pk=:ll_wv_image_pk;		
ELSE	//IQW
	UPDATE wv_pd_images SET image_pk=:ll_image_pk, seq_no=:ll_seq_no, audit_pending=0, auditor=:gs_user_id, audit_date=:ldt_now WHERE wv_image_pk=:ll_wv_image_pk;	
END IF	
gnv_appeondb.of_commitqueue ()

IF SQLCA.SQLCode <> 0 THEN 
	MessageBox ("Warning", "Failed to update the image due to ~r~n" + SQLCA.SQLErrText)
	RETURN -1
END IF

RETURN 1



end function

public function integer of_filter_by_facility (u_dw adw_list);//Start Code Change ----05.17.2016 #V15 maha - added for filter by facility
string ls_filter
string ls_pracs
integer res
integer r
long pc
long ll_prac
long ll_pracs[]


//clear filter
adw_list.setfilter("")
adw_list.filter()

//traps
if il_facility = 0 then	return 1
if adw_list.rowcount() < 1 then return 1


//get the list of providers
for r = 1 to adw_list.rowcount()
	ll_pracs[r] = adw_list.getitemnumber(r, "v_full_name_prac_id")
next

//get list of appointment pracs
dw_prac_facil.settransobject(sqlca)
pc = dw_prac_facil.retrieve(ll_pracs, il_facility, gs_user_id )


//create filter 
if pc < 1  then
	ls_pracs = "-1000000"
else
	for r = 1 to pc
		ll_prac = dw_prac_facil.getitemnumber(r, "prac_id")
		ls_pracs+= string(ll_prac) + ","
	next
	ls_pracs = leftA(ls_pracs, len(ls_pracs) - 1)
end if

ls_filter =  "v_full_name_prac_id in (" + ls_pracs + ")"

res = adw_list.setfilter(ls_filter)
if res < 0 then 
	messagebox("Facility_filter failed",ls_filter)
	return res
end if

adw_list.filter()

return 1



end function

public function integer of_display_image (long al_image_pk, long al_prac_id, boolean ab_wv_image, string as_file_name);//Display document in wv_pd_images/pd_images - (V15.1 WV Audit of Images) - Alfee 08.11.2015
//added the argument "as_file_name" by alfee 07.12.2016
Long li_filenum, ll_filelen
String ls_file, ls_filename, ls_null
String ls_filedate_local, ls_filedate_server, ls_flag
Datetime ldt_filedate_server
Boolean lb_file_existed = FALSE
Blob  lb_image_data

SetPointer(HourGlass!)

//Set file path and name
ls_flag = 'Prac'
IF ab_wv_image THEN ls_flag = 'WV'

ls_file = gs_temp_path + "images\" 
gnv_appeondll.of_parsepath(ls_file)

//-------Begin Modified by Alfee 07.12.2016 ----------------------------
//<$Reason>Issue with previewing jpg files in WebView Audit
Long ll_pos
String ls_file_ext = ".tif"

ll_pos = LastPos(as_file_name, ".")
IF ll_pos > 0 THEN
	ls_file_ext = Mid (as_file_name, ll_pos)	
END IF
ls_filename = String(al_prac_id) + "_" + String(al_image_pk) + ls_file_ext
//ls_filename = String(al_prac_id) + "_" + String(al_image_pk) + ".tif"
//-------End Modified --------------------------------------------------------

IF ab_wv_image THEN ls_filename = ls_flag + "_" + ls_filename
ls_file = ls_file + ls_filename

//Determine if the file already existed and unchanged
IF ab_wv_image THEN
	SELECT modify_date INTO :ldt_filedate_server FROM wv_pd_images WHERE wv_image_pk = :al_image_pk; 
ELSE
	SELECT modify_date INTO :ldt_filedate_server FROM pd_images WHERE image_pk = :al_image_pk; 
END IF
ls_filedate_server = String(ldt_filedate_server, 'mm/dd/yyyy hh:mm:ss')
IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN 	ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

IF FileExists(ls_file) THEN
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\" + ls_flag + " Images", ls_filename, RegString!, ls_filedate_local)
	IF ls_filedate_local = ls_filedate_server THEN lb_file_existed = TRUE
END IF

//Get the file if not existed
IF NOT lb_file_existed THEN
	//Download image to blob data
	OpenWithParm( w_appeon_gifofwait, "Downloading Image from Database..." )
	IF of_get_image( al_image_pk, lb_image_data, ab_wv_image)	 = -1 THEN RETURN -1
	IF IsValid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

	ll_filelen = LenA( lb_image_data )
	IF IsNull(lb_image_data) OR ll_filelen = 0 THEN
		MessageBox("Error", "The image file's length is 0.  Return -1." )
		RETURN -1
	END IF
	
	//Write blob to the file
	FileDelete( ls_file )
	li_filenum = AppeonWriteFile(ls_file, lb_image_data, ll_filelen)
	
	if li_filenum < 0 then
		MessageBox("Error", "Error with  AppeonWriteFile command.  Return -1." )
		RETURN -1
	end if
	
	IF Not FileExists( ls_file) THEN  
		MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_temp_path + "images\ is valid." )
		RETURN -1
	END IF

	//Set last modify date to registry
	gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\" + ls_flag + " Images", ls_filename, RegString!, ls_filedate_server)	
END IF

//Dispaly the file
SetNull (ls_null)
ShellExecuteA ( Handle( This ), "open", ls_file, ls_Null, ls_Null, 1)

RETURN 1

end function

public function integer of_resize ();long ll_w
long ll_h
//long ll_th
//long ll_tw
//long ll_split


long ll_tw
long ll_th
long ll_dwy
long ll_dww
long ll_dwheight
long ll_dwwidth

ll_w = this.workspacewidth( )
ll_h = this.workspaceheight( )

ll_tw = ll_w - 10
ll_th = ll_h - 12
tab_1.width = ll_tw
tab_1.height = ll_th
cb_close.x = ll_w - cb_close.width - 30

ll_dwheight = ll_th - 260
if tab_1.tabpage_1.rb_de1.checked then
	tab_1.tabpage_1.dw_audit1.height = ll_dwheight
else
	tab_1.tabpage_1.dw_audit1.height = ll_dwheight - tab_1.tabpage_1.dw_pd_images1.height - 10
	tab_1.tabpage_1.dw_pd_images1.y = tab_1.tabpage_1.dw_audit1.y + tab_1.tabpage_1.dw_audit1.height +4
end if
if tab_1.tabpage_2.rb_de2.checked then
	tab_1.tabpage_2.dw_audit2.height = ll_dwheight
else
	tab_1.tabpage_2.dw_audit2.height = ll_dwheight - tab_1.tabpage_2.dw_pd_images2.height - 10
	tab_1.tabpage_2.dw_pd_images2.y = tab_1.tabpage_2.dw_audit2.y + tab_1.tabpage_2.dw_audit2.height +4
end if

tab_1.tabpage_1.dw_list1.height = ll_dwheight + (tab_1.tabpage_1.dw_audit1.y - tab_1.tabpage_1.dw_list1.y) - 100

tab_1.tabpage_2.dw_list2.height =ll_dwheight + (tab_1.tabpage_2.dw_audit2.y - tab_1.tabpage_2.dw_list2.y) - 100

ll_dwy =  tab_1.tabpage_1.dw_list1.height + tab_1.tabpage_1.dw_list1.y
tab_1.tabpage_1.cb_audit.y = ll_dwy + 8
tab_1.tabpage_2.cb_next.y = ll_dwy + 8

ll_dwwidth = tab_1.tabpage_1.dw_list1.width
tab_1.tabpage_1.dw_audit1.width = ll_tw -ll_dwwidth - 60
tab_1.tabpage_1.dw_pd_images1.width = ll_tw - ll_dwwidth - 60

ll_dwwidth = tab_1.tabpage_2.dw_list2.width
tab_1.tabpage_2.dw_audit2.width = ll_tw - ll_dwwidth - 60
tab_1.tabpage_2.dw_pd_images2.width = ll_tw - ll_dwwidth - 60

tab_1.tabpage_3.dw_list3.height = ll_th - 150 - 124
tab_1.tabpage_3.dw_audit3.height = ll_th - 150
ll_dwwidth = tab_1.tabpage_3.dw_list3.width
tab_1.tabpage_3.dw_audit3.width = ll_tw - ll_dwwidth - 60

tab_1.tabpage_4.dw_lookup_list.height =  ll_th - 250
ll_dwy =  tab_1.tabpage_4.dw_lookup_list.height + tab_1.tabpage_4.dw_lookup_list.y
tab_1.tabpage_4.cb_lookup.y = ll_dwy + 15
tab_1.tabpage_4.dw_lookup_main.height = ll_th - 1400
ll_dwwidth = tab_1.tabpage_4.dw_lookup_list.width
tab_1.tabpage_4.dw_lookup_detail.width = ll_tw - ll_dwwidth - 40
tab_1.tabpage_4.dw_lookup_main.width = ll_tw - ll_dwwidth - 40



dw_detail.height = tab_1.tabpage_1.cb_audit.y + tab_1.tabpage_1.cb_audit.height - tab_1.tabpage_1.dw_list1.x
dw_detail.width =  tab_1.tabpage_1.dw_audit1.width




return 1

end function

on w_wv_audit_trail.create
int iCurrent
call super::create
this.st_select=create st_select
this.dw_select=create dw_select
this.dw_prac_facil=create dw_prac_facil
this.cb_close=create cb_close
this.dw_link_list=create dw_link_list
this.dw_addresses=create dw_addresses
this.tab_1=create tab_1
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_select
this.Control[iCurrent+2]=this.dw_select
this.Control[iCurrent+3]=this.dw_prac_facil
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.dw_link_list
this.Control[iCurrent+6]=this.dw_addresses
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.dw_detail
end on

on w_wv_audit_trail.destroy
call super::destroy
destroy(this.st_select)
destroy(this.dw_select)
destroy(this.dw_prac_facil)
destroy(this.cb_close)
destroy(this.dw_link_list)
destroy(this.dw_addresses)
destroy(this.tab_1)
destroy(this.dw_detail)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments>
// $<returns> long
// $<description>security control  (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////
//---------Begin Added by (V15.1 WV Audit of Images) Alfee 08.07.2015-------------------
integer li_audit_documents

ids_pd_images = create datastore
ids_pd_images.dataobject = "d_pd_images_byprac"
ids_pd_images.settransobject(sqlca)

select setting_value into :li_audit_documents from wv_setting where wv_setting_id = 9;
if li_audit_documents > 0 then
	of_adjust_ui ()
end if
//---------End Added ----------------------------------------------------------------------------

tab_1.tabpage_3.dw_audit3.modify("opt_type.visible = '0'")
of_retrieve_dw(1)



end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<Event> closequery
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if isvalid(inv_data_entry) then destroy inv_data_entry
if isvalid(inv_action_items) then destroy inv_action_items
end event

event close;call super::close;
Destroy ids_pd_images // (V15.1 WV Audit of Images) Alfee 08.14.2015

end event

event resize;call super::resize; //Start Code Change ----09.28.2015 #V15 maha - added
long ll_tw
long ll_th
long ll_dwy
long ll_dww
long ll_dwheight
long ll_dwwidth

of_resize( )
return

//---------Begin Modified by (Appeon)Stephen 12.12.2015 for BugS112601--------
/*
ll_dww = ll_tw - 1150
tab_1.tabpage_1.dw_audit1.width = ll_dww
dw_detail.height = ll_th - 250
//tab_1.tabpage_1.dw_pd_images1.height = ll_dwy - 15
//tab_1.tabpage_1.dw_pd_images1.width = ll_dww

tab_1.tabpage_2.dw_list2.height = ll_th - 250
tab_1.tabpage_2.cb_next.y = ll_dwy + 15
tab_1.tabpage_2.dw_audit2.height = ll_dwy - 15
tab_1.tabpage_2.dw_audit2.width = ll_dww

tab_1.tabpage_3.dw_list3.height = ll_th - 150
tab_1.tabpage_3.dw_audit3.height = ll_th - 150
tab_1.tabpage_3.dw_audit3.width = ll_dww

tab_1.tabpage_4.dw_lookup_list.height =  ll_th - 250
tab_1.tabpage_4.cb_lookup.y = ll_dwy + 15
tab_1.tabpage_4.dw_lookup_main.height = ll_th - 1400

//---------Begin Added by (Appeon)Stephen 09.29.2015 --------
dw_detail.height = ll_dwy - 15
dw_detail.width =  ll_dww
//---------End Added ------------------------------------------------------
*/
ll_tw = newwidth - 50
ll_th = newheight - 250
tab_1.width = ll_tw
tab_1.height = ll_th
cb_close.x = newwidth - cb_close.width - 30

ll_dwheight = ll_th - 250
if tab_1.tabpage_1.rb_de1.checked then
	tab_1.tabpage_1.dw_audit1.height = ll_dwheight
else
	tab_1.tabpage_1.dw_audit1.height = ll_dwheight - tab_1.tabpage_1.dw_pd_images1.height - 10
	tab_1.tabpage_1.dw_pd_images1.y = tab_1.tabpage_1.dw_audit1.y + tab_1.tabpage_1.dw_audit1.height +4
end if
if tab_1.tabpage_2.rb_de2.checked then
	tab_1.tabpage_2.dw_audit2.height = ll_dwheight
else
	tab_1.tabpage_2.dw_audit2.height = ll_dwheight - tab_1.tabpage_2.dw_pd_images2.height - 10
	tab_1.tabpage_2.dw_pd_images2.y = tab_1.tabpage_2.dw_audit2.y + tab_1.tabpage_2.dw_audit2.height +4
end if

tab_1.tabpage_1.dw_list1.height = ll_dwheight + (tab_1.tabpage_1.dw_audit1.y - tab_1.tabpage_1.dw_list1.y) - 100

tab_1.tabpage_2.dw_list2.height =ll_dwheight + (tab_1.tabpage_2.dw_audit2.y - tab_1.tabpage_2.dw_list2.y) - 100

ll_dwy =  tab_1.tabpage_1.dw_list1.height + tab_1.tabpage_1.dw_list1.y
tab_1.tabpage_1.cb_audit.y = ll_dwy + 15
tab_1.tabpage_2.cb_next.y = ll_dwy + 15

ll_dwwidth = tab_1.tabpage_1.dw_list1.width
tab_1.tabpage_1.dw_audit1.width = ll_tw - ll_dwwidth - 100
tab_1.tabpage_1.dw_pd_images1.width = ll_tw - ll_dwwidth - 100
ll_dwwidth = tab_1.tabpage_2.dw_list2.width
tab_1.tabpage_2.dw_audit2.width = ll_tw - ll_dwwidth - 100
tab_1.tabpage_2.dw_pd_images2.width = ll_tw - ll_dwwidth - 100

tab_1.tabpage_3.dw_list3.height = ll_th - 150
tab_1.tabpage_3.dw_audit3.height = ll_th - 150
ll_dwwidth = tab_1.tabpage_3.dw_list3.width
tab_1.tabpage_3.dw_audit3.width = ll_tw - ll_dwwidth - 100

tab_1.tabpage_4.dw_lookup_list.height =  ll_th - 250
ll_dwy =  tab_1.tabpage_4.dw_lookup_list.height + tab_1.tabpage_4.dw_lookup_list.y
tab_1.tabpage_4.cb_lookup.y = ll_dwy + 15
tab_1.tabpage_4.dw_lookup_main.height = ll_th - 1400
ll_dwwidth = tab_1.tabpage_4.dw_lookup_list.width
tab_1.tabpage_4.dw_lookup_detail.width = ll_tw - ll_dwwidth - 100
tab_1.tabpage_4.dw_lookup_main.width = ll_tw - ll_dwwidth - 100
//---------End Modfiied ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 04.18.2016
//<$>reason:Issues with V15 Build 4/13/16
dw_detail.height = tab_1.tabpage_1.cb_audit.y + tab_1.tabpage_1.cb_audit.height - tab_1.tabpage_1.dw_list1.x
dw_detail.width =  tab_1.tabpage_1.dw_audit1.width
//------------------- APPEON END -------------------



end event

type st_select from statictext within w_wv_audit_trail
integer x = 50
integer y = 120
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Facility Filter"
boolean focusrectangle = false
end type

type dw_select from datawindow within w_wv_audit_trail
integer x = 37
integer y = 172
integer width = 1001
integer height = 80
integer taborder = 20
string title = "none"
string dataobject = "d_facility_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//Start Code Change ----05.17.2016 #V15 maha
u_dw ldw_list

il_facility = long(data)

choose case tab_1.selectedtab
	case 1
		ldw_list =  tab_1.tabpage_1.dw_list1
	case 2
		ldw_list =  tab_1.tabpage_2.dw_list2
	case 3
		ldw_list =  tab_1.tabpage_3.dw_list3
	case 4
		return 1
end choose

ldw_list.setredraw( false)
of_filter_by_facility( ldw_list)
ldw_list.setredraw( true)


end event

event constructor;//Start Code Change ----05.17.2016 #V15 maha - added facility filter

datawindowchild dwchild
integer res

this.settransobject(sqlca)
this.insertrow(1)
res = this.getchild( "facility_name",dwchild)
dwchild.settransobject(sqlca)
res = dwchild.retrieve(gs_user_id )
dwchild.insertrow(1)
dwchild.setitem(1,"facility_id",0)
dwchild.setitem(1,"facility_facility_name","All")

end event

type dw_prac_facil from datawindow within w_wv_audit_trail
boolean visible = false
integer x = 3424
integer y = 68
integer width = 91
integer height = 72
integer taborder = 50
string title = "none"
string dataobject = "w_wv_audit_facil_filter"
boolean livescroll = true
end type

type cb_close from commandbutton within w_wv_audit_trail
integer x = 4155
integer y = 12
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close "
end type

event clicked;close (parent)
end event

type dw_link_list from datawindow within w_wv_audit_trail
boolean visible = false
integer x = 809
integer y = 2332
integer width = 686
integer height = 400
integer taborder = 50
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_addresses from u_dw within w_wv_audit_trail
boolean visible = false
integer x = 2665
integer y = 2088
integer width = 279
integer height = 100
integer taborder = 40
string dataobject = "d_group_data_entry"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-08-01 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

type tab_1 from tab within w_wv_audit_trail
integer y = 12
integer width = 4494
integer height = 2268
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;//////////////////////////////////////////////////////////////////////
// $<Event> selectionchanged
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if of_update_detail() = -1 then return -1
of_retrieve_dw(newindex)


 //Start Code Change ----03.21.2017 #V153 maha
choose case newindex
	case 1,2,3
		dw_select.visible = true
		st_select.visible = true
	case else
		dw_select.visible = false
		st_select.visible = false
end choose
	//End Code Change ----03.21.2017	
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4457
integer height = 2152
long backcolor = 33551856
string text = "Review Required"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
gb_opt1 gb_opt1
dw_pd_images1 dw_pd_images1
st_1 st_1
cb_reject1 cb_reject1
cb_skip1 cb_skip1
cb_accept1 cb_accept1
cb_audit cb_audit
dw_audit1 dw_audit1
rb_de1 rb_de1
rb_doc1 rb_doc1
dw_list1 dw_list1
end type

on tabpage_1.create
this.gb_opt1=create gb_opt1
this.dw_pd_images1=create dw_pd_images1
this.st_1=create st_1
this.cb_reject1=create cb_reject1
this.cb_skip1=create cb_skip1
this.cb_accept1=create cb_accept1
this.cb_audit=create cb_audit
this.dw_audit1=create dw_audit1
this.rb_de1=create rb_de1
this.rb_doc1=create rb_doc1
this.dw_list1=create dw_list1
this.Control[]={this.gb_opt1,&
this.dw_pd_images1,&
this.st_1,&
this.cb_reject1,&
this.cb_skip1,&
this.cb_accept1,&
this.cb_audit,&
this.dw_audit1,&
this.rb_de1,&
this.rb_doc1,&
this.dw_list1}
end on

on tabpage_1.destroy
destroy(this.gb_opt1)
destroy(this.dw_pd_images1)
destroy(this.st_1)
destroy(this.cb_reject1)
destroy(this.cb_skip1)
destroy(this.cb_accept1)
destroy(this.cb_audit)
destroy(this.dw_audit1)
destroy(this.rb_de1)
destroy(this.rb_doc1)
destroy(this.dw_list1)
end on

type gb_opt1 from groupbox within tabpage_1
boolean visible = false
integer x = 1102
integer y = 24
integer width = 951
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
end type

type dw_pd_images1 from u_dw within tabpage_1
boolean visible = false
integer x = 1111
integer y = 1696
integer width = 2418
integer height = 440
integer taborder = 30
string dataobject = "d_prac_audit_detail_pdimages"
boolean hscrollbar = true
boolean livescroll = false
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////
Long ll_prac_id, ll_image_pk
String ls_file_name //alfee 07.12.2016

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

//(V15.1 WV Audit of Images) - Alfee 08.11.2015
if dwo.name = 'p_image' then
	ll_prac_id = this.GetItemNumber(row, "prac_id")
	ll_image_pk = this.GetItemNumber(row, "image_pk")
	ls_file_name = this.GetItemString(row, "file_name") //alfee 07.12.2016
	
	//of_display_image (ll_image_pk, ll_prac_id, FALSE)
	of_display_image (ll_image_pk, ll_prac_id, FALSE, ls_file_name) // alfee 07.12.2016
end if
end event

event constructor;call super::constructor;// (V15.1 WV Audit of Images) - Alfee 08.10.2015

this.settransobject(sqlca) 
//this.insertrow(0) - commented by alfee 03.24.2016
end event

type st_1 from statictext within tabpage_1
integer x = 3072
integer y = 64
integer width = 1326
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "--Click these buttons to change all Actions at one time"
boolean focusrectangle = false
end type

type cb_reject1 from commandbutton within tabpage_1
integer x = 2752
integer y = 48
integer width = 311
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reject All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit1.rowcount() < 1 then return

for ll_row = 1 to dw_audit1.rowcount() 
	dw_audit1.setitem(ll_row, 'opt_type', 'Reject')
next
end event

type cb_skip1 from commandbutton within tabpage_1
integer x = 2441
integer y = 48
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Skip All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit1.rowcount() < 1 then return

for ll_row = 1 to dw_audit1.rowcount() 
	dw_audit1.setitem(ll_row, 'opt_type', 'Skip')
next
end event

type cb_accept1 from commandbutton within tabpage_1
integer x = 2126
integer y = 48
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit1.rowcount() < 1 then return

for ll_row = 1 to dw_audit1.rowcount() 
	dw_audit1.setitem(ll_row, 'opt_type', 'Accept')
next
end event

type cb_audit from commandbutton within tabpage_1
integer x = 210
integer y = 2056
integer width = 631
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process Audit Actions"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.30.2011 by Stephen
//////////////////////////////////////////////////////////////////////
//---------Begin Added by (V15.1 WV Audit of Images) - Alfee 08.13.2015----------------
if ib_audit_doc1 then 
	of_audit_image (1, tab_1.tabpage_1.dw_audit1)
else
//---------End Added ----------------------------------------------------------------------------	

	SQLCA.AutoCommit = False //Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	
	if of_audit_new(1, tab_1.tabpage_1.dw_audit1) = -1 then
		messagebox("Prompt", "Data audit failed. Please make sure the data are correct!")  //(Appeon)Stephen 01.29.2015 - Allegheny issue with webview audit accepting data
		//rollback using sqlca;//Comment by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	end if
	
	SQLCA.AutoCommit = True //Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	
end if  //(V15.1 WV Audit of Images) - Alfee 08.13.2015

//---------Begin Added by (Appeon)Stephen 02.06.2015 for Allegheny issue with webview audit accepting data--------
if isvalid(w_package_gifofwait) then
	close(w_package_gifofwait)
end if
//---------End Added ------------------------------------------------------
end event

type dw_audit1 from u_dw within tabpage_1
event ue_audit_rowfocuschanged ( integer ai_tab )
integer x = 1106
integer y = 144
integer width = 3328
integer height = 1992
integer taborder = 20
string dataobject = "d_prac_audit_detail"
boolean hscrollbar = true
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<Event> itemchanged
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.26.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long   ll_rec_id, ll_field_id, ll_seq_no
string ls_msg
datetime ldt_date

if row < 1 then return
choose case dwo.name
	case 'opt_type' 
		if data = 'Edit Data' then
			if of_create_dynamic_dw(1, row, this, 'edit') <> 1 then return  2
		end if
end choose
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false) 
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////
Long ll_prac_id, ll_wv_image_pk, ll_image_pk //Bug #5339 - alfee 09.20.2016
String ls_file_name //alfee 07.12.2016	

if row < 1 then return

this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

//(V15.1 WV Audit of Images) - Alfee 08.11.2015
if dwo.name = 'p_image' then
	ll_prac_id = this.GetItemNumber(row, "prac_id")
	ll_image_pk = this.GetItemNumber(row, "image_pk") //Bug #5339 - alfee 09.20.2016
	ll_wv_image_pk = this.GetItemNumber(row, "wv_image_pk")
	ls_file_name = this.GetItemString(row, "file_name") //alfee 07.12.2016	
	
	//of_display_image (ll_wv_image_pk, ll_prac_id, TRUE)
	//of_display_image (ll_wv_image_pk, ll_prac_id, TRUE, ls_file_name) //alfee 07.12.2016	
	of_display_image (ll_image_pk, ll_prac_id, FALSE, ls_file_name) //Bug #5339 - alfee 09.20.2016
end if



end event

event rowfocuschanged;call super::rowfocuschanged;//(V15.1 WV Audit of Images) - Alfee 08.10.2015
Long ll_rtn

IF ib_audit_doc1 THEN
	ll_rtn =  of_audit_rowfocuschanged (1, currentrow)
END IF

RETURN 0

end event

event retrieveend;call super::retrieveend;//(V15.1 WV Audit of Images) - Alfee 08.11.2015
Long ll_current_row

IF ib_audit_doc1 THEN
	IF rowcount > 0 THEN ll_current_row = 1
	of_audit_rowfocuschanged (1, ll_current_row)
END IF

RETURN 0
end event

type rb_de1 from radiobutton within tabpage_1
boolean visible = false
integer x = 1202
integer y = 64
integer width = 466
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Demographics"
boolean checked = true
end type

event clicked;of_change_dw ('DE1') //(V15.1 WV Audit of Images) - Alfee 08.10.2015
end event

type rb_doc1 from radiobutton within tabpage_1
boolean visible = false
integer x = 1650
integer y = 64
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Documents"
end type

event clicked;of_change_dw ('DOC1') //(V15.1 WV Audit of Images) - Alfee 08.10.2015
end event

type dw_list1 from u_dw within tabpage_1
integer y = 148
integer width = 1097
integer height = 1880
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_prac_audit_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////

of_audit_list_clicked(1, row, this, tab_1.tabpage_1.dw_audit1)

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4457
integer height = 2152
long backcolor = 33551856
string text = "Queued  for Approval"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_pd_images2 dw_pd_images2
rb_de2 rb_de2
st_2 st_2
cb_reject2 cb_reject2
cb_skip2 cb_skip2
cb_accept2 cb_accept2
cb_next cb_next
dw_audit2 dw_audit2
gb_opt2 gb_opt2
dw_list2 dw_list2
rb_doc2 rb_doc2
end type

on tabpage_2.create
this.dw_pd_images2=create dw_pd_images2
this.rb_de2=create rb_de2
this.st_2=create st_2
this.cb_reject2=create cb_reject2
this.cb_skip2=create cb_skip2
this.cb_accept2=create cb_accept2
this.cb_next=create cb_next
this.dw_audit2=create dw_audit2
this.gb_opt2=create gb_opt2
this.dw_list2=create dw_list2
this.rb_doc2=create rb_doc2
this.Control[]={this.dw_pd_images2,&
this.rb_de2,&
this.st_2,&
this.cb_reject2,&
this.cb_skip2,&
this.cb_accept2,&
this.cb_next,&
this.dw_audit2,&
this.gb_opt2,&
this.dw_list2,&
this.rb_doc2}
end on

on tabpage_2.destroy
destroy(this.dw_pd_images2)
destroy(this.rb_de2)
destroy(this.st_2)
destroy(this.cb_reject2)
destroy(this.cb_skip2)
destroy(this.cb_accept2)
destroy(this.cb_next)
destroy(this.dw_audit2)
destroy(this.gb_opt2)
destroy(this.dw_list2)
destroy(this.rb_doc2)
end on

type dw_pd_images2 from u_dw within tabpage_2
boolean visible = false
integer x = 1106
integer y = 1708
integer width = 2418
integer height = 440
integer taborder = 40
string dataobject = "d_prac_audit_detail_pdimages"
boolean hscrollbar = true
boolean livescroll = false
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////
Long ll_prac_id, ll_image_pk
String ls_file_name //alfee 07.12.2016	

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

//(V15.1 WV Audit of Images) - Alfee 08.11.2015
if dwo.name = 'p_image' then
	ll_prac_id = this.GetItemNumber(row, "prac_id")
	ll_image_pk = this.GetItemNumber(row, "image_pk")
	ls_file_name = this.GetItemString(row, "file_name") //alfee 07.12.2016
	
	//of_display_image (ll_image_pk, ll_prac_id, FALSE)
	of_display_image (ll_image_pk, ll_prac_id, FALSE, ls_file_name) // alfee 07.12.2016	
end if
end event

event constructor;call super::constructor;// (V15.1 WV Audit of Images) - Alfee 08.10.2015

this.settransobject(sqlca) 
//this.insertrow(0) - commented by alfee 03.24.2016

end event

type rb_de2 from radiobutton within tabpage_2
boolean visible = false
integer x = 1207
integer y = 56
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Demographics"
boolean checked = true
end type

event clicked;of_change_dw ('DE2') //(V15.1 WV Audit of Images) - Alfee 08.10.2015
end event

type st_2 from statictext within tabpage_2
integer x = 3205
integer y = 60
integer width = 1216
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean italic = true
long textcolor = 33554432
long backcolor = 33551856
string text = "--Click these buttons to change all Actions at one time"
boolean focusrectangle = false
end type

type cb_reject2 from commandbutton within tabpage_2
integer x = 2875
integer y = 44
integer width = 311
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reject All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit2.rowcount() < 1 then return

for ll_row = 1 to dw_audit2.rowcount() 
	dw_audit2.setitem(ll_row, 'opt_type', 'Reject')
next
end event

type cb_skip2 from commandbutton within tabpage_2
integer x = 2560
integer y = 44
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Skip All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit2.rowcount() < 1 then return

for ll_row = 1 to dw_audit2.rowcount() 
	dw_audit2.setitem(ll_row, 'opt_type', 'Skip')
next
end event

type cb_accept2 from commandbutton within tabpage_2
integer x = 2249
integer y = 44
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if dw_audit2.rowcount() < 1 then return

for ll_row = 1 to dw_audit2.rowcount() 
	dw_audit2.setitem(ll_row, 'opt_type', 'Accept')
next
end event

type cb_next from commandbutton within tabpage_2
integer x = 247
integer y = 2044
integer width = 631
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process and Next"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.30.2011 by Stephen
//////////////////////////////////////////////////////////////////////
//---------Begin Added by (V15.1 WV Audit of Images) - Alfee 08.13.2015----------------
if ib_audit_doc2 then 
	of_audit_image (2, tab_1.tabpage_2.dw_audit2)
else
//---------End Added ----------------------------------------------------------------------------	

	SQLCA.AutoCommit = False //Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	
	if of_audit_new(2, tab_1.tabpage_2.dw_audit2)= -1 then
		messagebox("Prompt", "Data audit failed. Please make sure the data are correct!")  //(Appeon)Stephen 01.29.2015 - Allegheny issue with webview audit accepting data
		//rollback using sqlca; //Comment by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	end if
	
	SQLCA.AutoCommit = True //Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	
end if  //(V15.1 WV Audit of Images) - Alfee 08.13.2015

//---------Begin Added by (Appeon)Stephen 02.06.2015 for Allegheny issue with webview audit accepting data--------
if isvalid(w_package_gifofwait) then
	close(w_package_gifofwait)
end if
//---------End Added ------------------------------------------------------
end event

type dw_audit2 from u_dw within tabpage_2
integer x = 1106
integer y = 144
integer width = 3323
integer height = 2008
integer taborder = 30
string dataobject = "d_prac_audit_detail"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
this.of_setupdateable(false) 
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////
Long ll_prac_id, ll_wv_image_pk
String ls_file_name  //alfee 07.12.2016

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

//(V15.1 WV Audit of Images) - Alfee 08.11.2015
if dwo.name = 'p_image' then
	ll_prac_id = this.GetItemNumber(row, "prac_id")
	ll_wv_image_pk = this.GetItemNumber(row, "wv_image_pk")
	ls_file_name = this.GetItemString(row, "file_name") //alfee 07.12.2016
	
	//of_display_image (ll_wv_image_pk, ll_prac_id, TRUE)
	of_display_image (ll_wv_image_pk, ll_prac_id, TRUE, ls_file_name) // alfee 07.12.2016			
end if
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<Event> itemchanged
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.26.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long   ll_seq_no,  ll_table_id
string ls_msg
datetime ldt_date

if row < 1 then return
choose case dwo.name
	case 'opt_type' 
		if data = 'Edit Data' then
			if of_create_dynamic_dw(2, row, this, 'edit') <> 1 then return 2
			
		end if
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;//(V15.1 WV Audit of Images) - Alfee 08.10.2015
Long ll_rtn

IF ib_audit_doc2 THEN
	ll_rtn =  of_audit_rowfocuschanged (2, currentrow)
END IF

RETURN 0

end event

event retrieveend;call super::retrieveend;//(V15.1 WV Audit of Images) - Alfee 08.11.2015
Long ll_current_row

IF ib_audit_doc2 THEN
	IF rowcount > 0 THEN ll_current_row = 1
	of_audit_rowfocuschanged (2, ll_current_row)
END IF

RETURN 0
end event

type gb_opt2 from groupbox within tabpage_2
boolean visible = false
integer x = 1111
integer y = 20
integer width = 1047
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
end type

type dw_list2 from u_dw within tabpage_2
integer y = 144
integer width = 1097
integer height = 1880
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_prac_audit_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////

of_audit_list_clicked(2, row, this, tab_1.tabpage_2.dw_audit2)

end event

type rb_doc2 from radiobutton within tabpage_2
boolean visible = false
integer x = 1714
integer y = 56
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Documents"
end type

event clicked;of_change_dw ('DOC2') //(V15.1 WV Audit of Images) - Alfee 08.10.2015
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4457
integer height = 2152
long backcolor = 33551856
string text = "No Review Required"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_audit3 dw_audit3
dw_list3 dw_list3
end type

on tabpage_3.create
this.dw_audit3=create dw_audit3
this.dw_list3=create dw_list3
this.Control[]={this.dw_audit3,&
this.dw_list3}
end on

on tabpage_3.destroy
destroy(this.dw_audit3)
destroy(this.dw_list3)
end on

type dw_audit3 from u_dw within tabpage_3
integer x = 1106
integer y = 28
integer width = 3328
integer height = 2124
integer taborder = 30
string dataobject = "d_prac_audit_detail"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
this.of_setupdateable(false) 
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)
end event

type dw_list3 from u_dw within tabpage_3
integer y = 152
integer width = 1097
integer height = 2000
integer taborder = 10
string dataobject = "d_prac_audit_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.20.2011 by Stephen
//////////////////////////////////////////////////////////////////////

of_audit_list_clicked(3, row, this, tab_1.tabpage_3.dw_audit3)

end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4457
integer height = 2152
long backcolor = 33551856
string text = "Lookup Entries"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_lookup cb_lookup
dw_lookup_main dw_lookup_main
dw_lookup_list dw_lookup_list
dw_lookup_detail dw_lookup_detail
dw_lookup_search dw_lookup_search
end type

on tabpage_4.create
this.cb_lookup=create cb_lookup
this.dw_lookup_main=create dw_lookup_main
this.dw_lookup_list=create dw_lookup_list
this.dw_lookup_detail=create dw_lookup_detail
this.dw_lookup_search=create dw_lookup_search
this.Control[]={this.cb_lookup,&
this.dw_lookup_main,&
this.dw_lookup_list,&
this.dw_lookup_detail,&
this.dw_lookup_search}
end on

on tabpage_4.destroy
destroy(this.cb_lookup)
destroy(this.dw_lookup_main)
destroy(this.dw_lookup_list)
destroy(this.dw_lookup_detail)
destroy(this.dw_lookup_search)
end on

type cb_lookup from commandbutton within tabpage_4
integer x = 274
integer y = 2044
integer width = 590
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept and Next"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row, ll_lookup_code
string  ls_code

ll_row = dw_lookup_list.getrow()
if ll_row < 1 then return

if messagebox("Prompt", "Are you sure you want to accept this new lookup entry?",question!,okcancel!) = 2 then return

of_lookup_accept(dw_lookup_detail, dw_lookup_list)




end event

type dw_lookup_main from u_dw within tabpage_4
integer x = 1106
integer y = 1276
integer width = 3351
integer height = 876
integer taborder = 11
string dataobject = "d_lookup_audit_main"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<Event> doubleclicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_row
long     ll_cnt
string ls_lookup_name, ls_sql
string ls_table[], ls_field[]
long   ll_value_new, ll_value_old, ll_value_audit
long   ll_field_id[], ll_table_id[]
string ls_audit_type
string ls_sql_upd = "begin "
boolean lb_sql = false
datastore lds_find
long ll_i

if row < 1 then return
li_row = dw_lookup_list.getrow()
if li_row < 1 then return
li_row = dw_lookup_detail.getrow()

if messagebox("Prompt", "Are you sure you want to use the selected replacement ?",question!,okcancel!) = 2 then return

ls_lookup_name = dw_lookup_detail.getitemstring(li_row, 'lookup_name')
ll_value_new = this.getitemnumber(row, 'lookup_code')
ll_value_old  = dw_lookup_detail.getitemnumber(li_row, 'lookup_code')

declare c_table cursor for
	select b.table_name,a.field_name, b.table_id, a.field_id from sys_fields a , sys_tables b 
	where lookup_code = :ls_lookup_name and a.table_id = b.table_id;

open c_table;
ll_cnt = 1
fetch c_table into :ls_table[ll_cnt], :ls_field[ll_cnt], :ll_table_id[ll_cnt], :ll_field_id[ll_cnt];

do while sqlca.sqlcode = 0
	ll_cnt = ll_cnt + 1
	fetch c_table into :ls_table[ll_cnt], :ls_field[ll_cnt], :ll_table_id[ll_cnt], :ll_field_id[ll_cnt];
loop
close c_table;

lds_find = create datastore
lds_find.dataobject = 'd_lookup_audit_find'
lds_find.settransobject(sqlca)
lds_find.retrieve(ll_table_id, ll_field_id, string(ll_value_old)) //modify by stephen 03.28.2012 -BugS032801

for ll_cnt = 1 to upperbound(ls_table)
	if not(isnull( ll_table_id[ll_cnt]) or  ls_table[ll_cnt] = '' or isnull( ll_field_id[ll_cnt]) or  ls_field[ll_cnt] ='') then
		
		lds_find.setfilter("table_id = "+string(ll_table_id[ll_cnt])+" and field_id = "+string(ll_field_id[ll_cnt])+" ")
		lds_find.filter()
		for ll_i = 1 to lds_find.rowcount()
			ls_audit_type = lds_find.getitemstring(ll_i, "audit_type")
			ll_value_audit = long(lds_find.getitemstring(ll_i, "old_value"))
			if ls_audit_type = 'EQW' or ls_audit_type = 'QQW' then
			else
				ls_sql = "update " + ls_table[ll_cnt] + " set "+ ls_field[ll_cnt] + " = "+string(ll_value_new) + " where "+ ls_field[ll_cnt] + " = '"+string(ll_value_old)+"'"
				ls_sql_upd =ls_sql_upd + " " + ls_sql
			end if
		next
		if lds_find.rowcount() > 0 then
			lb_sql = true
			ls_sql_upd =ls_sql_upd +  " update sys_audit set new_value = "+string(ll_value_new)+" where audit_pending = 1 and table_id = " + string(ll_table_id[ll_cnt]) + " and field_id = " + string(ll_field_id[ll_cnt]) +" and new_value ='" + string(ll_value_old)+"'"
		end if
		
	end if
next
destroy lds_find

if lb_sql then
	ls_sql_upd = ls_sql_upd + " end"
	EXECUTE IMMEDIATE :ls_sql_upd;
	if sqlca.sqlcode <> 0 then return -1
end if

delete from address_lookup where lookup_code = :ll_value_old;
if of_lookup_accept(dw_lookup_detail, dw_lookup_list) = -1 then return -1


	

end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

end event

type dw_lookup_list from u_dw within tabpage_4
integer y = 4
integer width = 1102
integer height = 2024
integer taborder = 40
string dataobject = "d_lookup_audit_list"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
string  ls_code
long    ll_lookup_code

if row < 1 then return
this.selectrow(0,false)
this.scrolltorow(row)
this.selectrow(row, true)

 ls_code = this.getitemstring(row, "code")
 ll_lookup_code = this.getitemnumber(row, "lookup_code")
 dw_lookup_detail.retrieve(ls_code, ll_lookup_code)
end event

type dw_lookup_detail from u_dw within tabpage_4
integer x = 1106
integer y = 4
integer width = 3351
integer height = 1044
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_lookup_audit_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
this.of_setupdateable(false) 
end event

event losefocus;call super::losefocus;//////////////////////////////////////////////////////////////////////
// $<Event> losefocus
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 03.19.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.accepttext()
if this.modifiedcount() > 0 then
	this.update()
end if
end event

type dw_lookup_search from u_dw within tabpage_4
integer x = 1106
integer y = 1072
integer width = 3022
integer height = 184
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_lookup_audit_search"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////

datawindowchild ldc_1

this.insertrow(1)
this.setitem(1, 's_type','2')

this.getchild("s_name", ldc_1)
ldc_1.settransobject(sqlca)
ldc_1.retrieve('State')
ldc_1.insertrow(1)
ldc_1.setitem(1, 'code', '9999')
ldc_1.setitem(1, 'description', 'ALL')

this.of_setupdateable(false) 


end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<Event> itemchanged
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
datawindowchild ldc_1

if dwo.name = 's_type' then
	choose case data
		case '1'
			this.modify("s_city.visible = 1")
			this.modify("s_name.visible = 0")
		case '2'
		     this.modify("s_city.visible = 0")
			this.modify("s_name.visible = 1")
			if this.getchild('s_name', ldc_1) = -1 then return
			
			ldc_1.settransobject(sqlca)
			ldc_1.retrieve('state')
			ldc_1.insertrow(1)
			ldc_1.setitem(1, 'code', '9999')
			ldc_1.setitem(1, 'description', 'ALL')
		case '3'
			this.modify("s_city.visible = 0")
			this.modify("s_name.visible = 1")
			if this.getchild('s_name', ldc_1) = -1 then return
			
			ldc_1.settransobject(sqlca)
			ldc_1.retrieve('country')
			ldc_1.insertrow(1)
			ldc_1.setitem(1, 'code', '9999')
			ldc_1.setitem(1, 'description', 'ALL')
	end choose	
	
	this.setitem(1, 's_city', '')
	this.setitem(1, 's_name', '')
end if
end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<Event> buttonclicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.31.2011 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_type, ls_code

if dwo.name = 'b_find' then
	if this.accepttext() = -1 then return
	ls_type = this.getitemstring(1, 's_type')
	choose case ls_type
		case '1'
			ls_code = this.getitemstring(1, 's_city')
			dw_lookup_main.retrieve(ls_code, '9999', '9999')
		case '2'
			ls_code = this.getitemstring(1, 's_name')
			dw_lookup_main.retrieve( '9999', ls_code, '9999')
		case '3'
			ls_code = this.getitemstring(1, 's_name')
			dw_lookup_main.retrieve( '9999', '9999', ls_code)
	end choose
end if
end event

type dw_detail from u_dw within w_wv_audit_trail
event type integer ue_update ( string as_audit_type,  integer ai_parent_facility_id,  string as_field_name,  string as_old_value,  string as_new_value )
boolean visible = false
integer x = 1143
integer y = 188
integer width = 3323
integer height = 2100
integer taborder = 30
boolean hscrollbar = true
end type

event type integer ue_update(string as_audit_type, integer ai_parent_facility_id, string as_field_name, string as_old_value, string as_new_value);//////////////////////////////////////////////////////////////////////
// $<Event> ue_update
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.30.2011 by Stephen
// Added arguments 'as_old_value', 'as_new_value' (V15 DE Update) alfee 11.16.2016
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
long ll_old_val, ll_new_val //(V15 DE Update) alfee 11.16.2016
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
lds_select_section.setfilter("screen_id = "+string(ii_screen_id)+"")
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
lds_parent_facilities.Retrieve( il_prac_id )
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
	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ii_screen_id,ls_app_type)
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
	IF as_audit_type  = 'IQW'  and dw_detail.visible = false THEN
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
				where rec_id = :ll_rec_id and prac_id = :il_prac_id and active_status = 1;
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
					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Design for the view you are using.")
					return -1
				end if
			END IF
		ELSE
			ldt_exp_date = ldt_null_date
		END IF
	
		//get reference 1 data 		
		if This.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
			messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
			return 1
		end if
		li_retval = This.SetColumn( ls_ref_1 )
		IF li_retval = 1 THEN
			IF IsNull( GetText() ) OR GetText() = "" THEN
				SetRedraw( True )
				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
				Return -1
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
					IF ii_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the Screen Design.")
							return -1
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
					IF ii_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the Screen Design.")
							return -1
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
				messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				return 1
			end if
			li_retval = This.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( GetText() ) OR GetText() = "" THEN
					SetRedraw( True )
					of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					Return -1
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
						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
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
			inv_data_entry.of_app_audit_update_ref( il_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )

			//Update address_id in net_dev_ids for gp_id changed in address screen - (V15 DE Update) alfee 11.16.2016
			if li_screen_id = 2 and Lower(as_field_name) = "gp_id" and IsNumber(as_old_value) and IsNumber(as_new_value) then
				ll_old_val = Long(as_old_value)
				ll_new_val = Long(as_new_value)
				if ll_new_val <> ll_old_val then
					if Upper(as_audit_type) = "EQW" then //Accept for Level 1
						update net_dev_ids set address_id = :ll_new_val where prac_id = :il_prac_id and address_id = :ll_old_val;							
					elseif Upper(as_audit_type) = "E-W" then //Reject for Level 2
						update net_dev_ids set address_id = :ll_old_val where prac_id = :il_prac_id and address_id = :ll_new_val;
					end if									
				end if	
			end if

			IF  as_field_name = ls_exp_field THEN
				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
			END IF
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
//					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,il_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference ,  mid(ls_screen_name,1,5) + "-" + ls_reference )   //Start Code Change ----12.05.2016 #V153 maha
					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,il_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )   //argument not correct, modified by Appeon long.zhang 12.30.2016
				end if
			next
			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
			debugbreak()
			IF of_add_verif_info( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument
					Return -1
					messagebox("Error","Error adding verification")
				end if
			END IF

	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
	long ll_cnt_new
	select count(1) into :ll_cnt_new from pd_images where prac_id = :il_prac_id and rec_id = :ll_rec_id;
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
			lds_image_data.SetItem( ll_row, "prac_id", il_prac_id )
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
	//---------------------------- APPEON END ----------------------------
END FOR

if inv_data_entry.of_field_audit( This ) = -1 then return -1

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
String ls_sql_where, ls_rec_id_str, ls_sql_original
n_ds lds_verify
gs_verif_update lstr_verif

li_cnt = UpperBound( w_mdi.ii_security_action_id )
FOR i = 1 TO li_cnt
	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
			Return 1; //No rights	
		END IF
	END IF		
NEXT

li_cnt = UpperBound( ll_rec_id_changed )
IF li_cnt > 0 THEN
	FOR i = 1 TO li_cnt
		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
	NEXt
	lds_verify = Create n_ds
	lds_verify.DataObject = "d_verification_facility_de_update_maha"
	lds_verify.SetTransObject( SQLCA )
	lstr_verif.sql_syntax = ""//ls_sql_original
	lstr_verif.al_prac_id = il_prac_id
	lstr_verif.al_screen_id = li_screen_id
	lstr_verif.al_rec_id = ll_rec_id_changed
	
	OpenwithParm( w_verification_de_update, lstr_verif )
END IF
//---------------------------- APPEON END ----------------------------

//------------------appeon begin------------------
//<$>added:long.zhang 06.04.2013
//<$>reason: Bug 3557  Issue with Notifications
if upper(as_audit_type) = 'EQW' or  upper(as_audit_type) = 'E-W' then
	String	ls_table_name
	n_cst_notification_alert_upd	lnv_na
	If this.Describe(as_field_name + ".ColType") <> "!" Then
			if this.getItemStatus(1,as_field_name,primary!) <> DataMOdified! then
					this.setitemstatus( 1, as_field_name,primary!, DataModified!)
			end if
	end if		
	ls_table_name = This.Object.DataWindow.Table.UpdateTable
	lnv_na.of_update_alert_records(ls_table_name, This)
end if	
//------------------appeon end--------------------

RETURN 1

end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////

This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)
this.of_SetDropDownCalendar( TRUE )
end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<Event> buttonclicked
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
DataWindowChild dwchild
string s
string ls_phone

IF dwo.Name = "linkbutton" THEN
	IF This.GetItemStatus( row, 0, Primary! ) = New! or This.GetItemStatus( row, 0, Primary! ) = NewModified! THEN
		MessageBox("Save", "You need to first save the address record before applying address links." )
		Return
	ELSE
		OpenWithParm( w_address_link, String( il_prac_id ) + "-" + String( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) )	
	END IF
ELSEIF dwo.Name = "findbutton" THEN
	integer set1
	set1 = of_get_app_setting("set_1","I")
	
	long ll_addr[ ]
	Integer li_cr
	Integer a
	Integer li_address_cnt
	gs_pass_ids ids
	
	if set1 <> 1 then 
		
		Open(w_practice_to_addr_find_new) 
			
		ids = Message.PowerObjectParm
			
		IF ids.l_ids[1] = 0 THEN
			Return
		END IF
			
		ll_addr[] = ids.l_ids[]
			
		li_address_cnt = UpperBound( ids.l_ids[] )
	
		dw_addresses.dataobject = "d_group_data_entry_for_pt"
		dw_addresses.SetTransObject( SQLCA )
		
		if upperbound(ll_addr)>0 then
			dw_addresses.Retrieve( ll_addr )
		end if
			
		FOR a = 1 TO li_address_cnt
			dw_addresses.setfilter('rec_id = '+ string ( ll_addr[a] ))
			dw_addresses.filter( )
			li_cr = dw_detail.getRow()

			if This.Describe("gp_id.ColType") <> "!" then
				dw_detail.setitem( li_cr,"gp_id", ll_addr[a] )
			end if
			if This.Describe("street.ColType") <> "!" then
				dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street"))
			end if

			if This.Describe("street_2.ColType") <> "!" then			
				dw_detail.setitem( li_cr,"street_2",dw_addresses.getitemstring( 1,"street_2"))
			end if
			if This.Describe("city.ColType") <> "!" then
				dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
			end if
			if This.Describe("state.ColType") <> "!" then
				dw_detail.setitem( li_cr,"state",dw_addresses.getitemnumber( 1,"state") )
			end if
			if This.Describe("zip.ColType") <> "!" then
				dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
			end if
			if This.Describe("county.ColType") <> "!" then
				dw_detail.setitem( li_cr,"county",dw_addresses.getitemnumber( 1,"county"))
			end if
			if This.Describe("country.ColType") <> "!" then
				dw_detail.setitem( li_cr,"country",dw_addresses.getitemnumber( 1,"country"))
			end if
			if This.Describe("phone.ColType") <> "!" then
				//Start Code Change ----02.02.2009 #V92 maha - added if statement
				//Start Code Change ----06.10.2008 #V81 maha - strip format characters
				ls_phone = dw_addresses.getitemstring( 1,"phone") 
				if this.describe("phone.EditMask.Mask") = "(###)###-####" then
					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
				end if
				
				dw_detail.setitem( li_cr,"phone",ls_phone)
					//End Code Change---06.10.2008
				//End Code Change---02.02.2009
			end if
			
			if This.Describe("ext.ColType") <> "!" then  //Start Code Change ----08.12.2011 #V11 maha -  added extension field
				dw_detail.setitem( li_cr,"ext",dw_addresses.getitemstring( 1,"ext"))
			end if
			
			if This.Describe("fax.ColType") <> "!" then
				//Start Code Change ----02.02.2009 #V92 maha - added trap for formatted field
				ls_phone = dw_addresses.getitemstring( 1,"fax") 
				if this.describe("fax.EditMask.Mask") = "(###)###-####" then
					ls_phone =  of_strip_char("", ls_phone, "@NUM@")
				end if
				dw_detail.setitem( li_cr,"fax",ls_phone)
				//End Code Change---02.02.2009
			end if
			if This.Describe("e_mail_address.ColType") <> "!" then
				dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"e_mail_address"))
			end if
			if This.Describe("web_address.ColType") <> "!" then
				dw_detail.setitem( li_cr,"web_address",dw_addresses.getitemstring( 1,"web_address"))
			end if
			if This.Describe("contact_person.ColType") <> "!" then
				dw_detail.setitem( li_cr,"contact_person",dw_addresses.getitemstring( 1,"contact_person"))
			end if
			if This.Describe("business_mgr.ColType") <> "!" then
				dw_detail.setitem( li_cr,"business_mgr",dw_addresses.getitemstring( 1,"business_mgr"))
			end if
			if This.Describe("office_mgr.ColType") <> "!" then
				dw_detail.setitem( li_cr,"office_mgr",dw_addresses.getitemstring( 1,"office_mgr"))
			end if
			if This.Describe("tax_id.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tax_id",dw_addresses.getitemstring( 1,"tax_id"))
			end if
			if This.Describe("tax_id_other_1.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tax_id_other_1",dw_addresses.getitemstring( 1,"tax_id_other_1"))
			end if
			if This.Describe("tax_id_other_2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tax_id_other_2",dw_addresses.getitemstring( 1,"tax_id_other_2"))
			end if
			if This.Describe("routine_visit_appt.ColType") <> "!" then
				dw_detail.setitem( li_cr,"routine_visit_appt",dw_addresses.getitemstring( 1,"routine_visit_appt"))
			end if
			if This.Describe("urgent_visit_appt.ColType") <> "!" then
				dw_detail.setitem( li_cr,"urgent_visit_appt",dw_addresses.getitemstring( 1,"urgent_visit_appt"))
			end if
			if This.Describe("emergency_visit_appt.ColType") <> "!" then
				dw_detail.setitem( li_cr,"emergency_visit_appt",dw_addresses.getitemstring( 1,"emergency_visit_appt"))
			end if
	
			if This.Describe("handicapped_access.ColType") <> "!" then
				dw_detail.setitem( li_cr,"handicapped_access",dw_addresses.getitemnumber( 1,"handicapped_access"))
			end if
				if This.Describe("public_transportation.ColType") <> "!" then
				dw_detail.setitem( li_cr,"public_transportation",dw_addresses.getitemnumber( 1,"public_transportation"))
			end if
			if This.Describe("non_emergency_appt.ColType") <> "!" then
				dw_detail.setitem( li_cr,"non_emergency_appt",dw_addresses.getitemstring( 1,"non_emergency_appt"))
			end if
		
			if This.Describe("mon_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"mon_from",dw_addresses.getitemstring( 1,"mon_from"))
			end if
			if This.Describe("mon_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"mon_to",dw_addresses.getitemstring( 1,"mon_to"))
			end if
			if This.Describe("tue_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tue_from",dw_addresses.getitemstring( 1,"tue_from"))
			end if
			if This.Describe("tue_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tue_to",dw_addresses.getitemstring( 1,"tue_to"))
			end if
			if This.Describe("wed_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"wed_from",dw_addresses.getitemstring( 1,"wed_from"))
			end if
			if This.Describe("wed_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"wed_to",dw_addresses.getitemstring( 1,"wed_to"))
			end if
			if This.Describe("thu_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"thu_from",dw_addresses.getitemstring( 1,"thu_from"))
			end if
			if This.Describe("thu_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"thu_to",dw_addresses.getitemstring( 1,"thu_to"))
			end if
			if This.Describe("fri_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"fri_from",dw_addresses.getitemstring( 1,"fri_from"))
			end if
			if This.Describe("fri_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"fri_to",dw_addresses.getitemstring( 1,"fri_to"))
			end if
			if This.Describe("sat_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sat_from",dw_addresses.getitemstring( 1,"sat_from"))
			end if
			if This.Describe("sat_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sat_to",dw_addresses.getitemstring( 1,"sat_to"))
			end if
			if This.Describe("sun_from.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sun_from",dw_addresses.getitemstring( 1,"sun_from"))
			end if
			if This.Describe("sun_to.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sun_to",dw_addresses.getitemstring( 1,"sun_to"))
			end if
			if This.Describe("mon_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"mon_from2",dw_addresses.getitemstring( 1,"mon_from2"))
			end if
			if This.Describe("mon_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"mon_to2",dw_addresses.getitemstring( 1,"mon_to2"))
			end if
			if This.Describe("tue_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tue_from2",dw_addresses.getitemstring( 1,"tue_from2"))
			end if
			if This.Describe("tue_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"tue_to2",dw_addresses.getitemstring( 1,"tue_to2"))
			end if
			if This.Describe("wed_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"wed_from2",dw_addresses.getitemstring( 1,"wed_from2"))
			end if
			if This.Describe("wed_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"wed_to2",dw_addresses.getitemstring( 1,"wed_to2"))
			end if
			if This.Describe("thu_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"thu_from2",dw_addresses.getitemstring( 1,"thu_from2"))
			end if
			if This.Describe("thu_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"thu_to2",dw_addresses.getitemstring( 1,"thu_to2"))
			end if
			if This.Describe("fri_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"fri_from2",dw_addresses.getitemstring( 1,"fri_from2"))
			end if
			if This.Describe("fri_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"fri_to2",dw_addresses.getitemstring( 1,"fri_to2"))
			end if
			if This.Describe("sat_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sat_from2",dw_addresses.getitemstring( 1,"sat_from2"))
			end if
			if This.Describe("sat_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sat_to2",dw_addresses.getitemstring( 1,"sat_to2"))
			end if
			if This.Describe("sun_from2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sun_from2",dw_addresses.getitemstring( 1,"sun_from2"))
			end if
			if This.Describe("sun_to2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"sun_to2",dw_addresses.getitemstring( 1,"sun_to2"))
			end if
			if This.Describe("cust_1.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"cust_1"))
			end if
			if This.Describe("cust_2.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"cust_2"))
			end if
			if This.Describe("cust_3.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"cust_3"))
			end if
			if This.Describe("cust_4.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_4",dw_addresses.getitemstring( 1,"cust_4"))
			end if
			if This.Describe("cust_5.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"cust_5"))
			end if
			if This.Describe("cust_6.ColType") <> "!" then
				dw_detail.setitem( li_cr,"cust_6",dw_addresses.getitemstring( 1,"cust_6"))
			end if
			//Start Code Change ---- 12.21.2006 #V7 maha
			if This.Describe("suite_apart.ColType") <> "!" then
				dw_detail.setitem( li_cr,"suite_apart",dw_addresses.getitemstring( 1,"suite_apart"))
			end if
			//End Code Change---12.21.2006
			inv_data_entry.of_set_defaults( This, This.RowCount() )
		END FOR	
 
 		ib_addaddress = false

	else //old find function based on addresses
		This.GetChild( "street", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( "%" + This.GetText() + "%" )
		//This.SetText( "" )
	end if
	
ELSEIF dwo.Name = "populatebutton" THEN //used with old find function

	Integer li_row_cnt
	String ls_rec_id	
	String ls_grey
	String ls_presentation_str
	String ls_dwsyntax_str
	String ERRORS
	String ls_syntax
	
	ls_syntax = is_sql_syntax
	

	This.AcceptText()
	ls_rec_id = This.GetItemString( row, "street" ) 
	
	///Start Code Change ----.2010 #V10 maha/--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.30.2006 By: Liang QingShi
	//$<reason> Fix a bug
	if long(ls_rec_id) <= 0 then return -1
	//---------------------------- APPEON END ----------------------------

	ls_syntax = ls_syntax + " WHERE pd_address.rec_id = " + ls_rec_id
	
	ls_grey = String(rgb(192,192,192))
	ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_syntax, &
		ls_presentation_str, ERRORS)

	IF Len(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	END IF

	dw_addresses.Create( ls_dwsyntax_str, ERRORS)

	IF Len(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN -1
	END IF
	
	dw_addresses.of_SetTransObject( SQLCA )
	li_row_cnt = dw_addresses.Retrieve(  )
	IF li_row_cnt = 0 THEN
		MessageBox("Error", "Nothing to select.")
		Return -1
	END IF

	This.DeleteRow( row )
	
	dw_addresses.RowsCopy ( 1, 1, Primary!, This, 1000, Primary! )

	This.ScrollToRow( This.RowCount() )
	This.SetRow( This.RowCount() )	
	
	This.AcceptText()

	This.GetChild( "street", dwchild )
	dwchild.Reset()
//\/maha 062801  peer lookup select
elseif dwo.Name = "peerbutton" THEN
	
	OpenWithParm(w_peer_reference_select, this)
	//------------------- APPEON END ---------------------
ELSEIF dwo.Name = "imgbutton" THEN //SK Practitioner Folder - alfee 09.10.2010
	if of_get_app_setting("image_storage_type","I") = 0 then//Start Code Change ----05.11.2011 #V11 maha - trap for images on hard drive
		messagebox("View Images","This functionality is only available if your images are stored in the database.  Please view your images from the Documents tab.~r~rContact ISG support for assistance in migrating your images to the database.")
		return
	end if
	IF il_prac_id > 0 and ii_screen_id > 0 THEN
		//-------------------------------APPEON BEGIN--------------------
		//$<Modified> long.zhang 11.04.2011
		//$<Reason> view image
		IF IsValid(w_image_preview) then
			w_image_preview.of_get_image(string(il_prac_id) + '||' + string(ii_screen_id),il_rec_id)
		else
			OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
		end if
		//----------------------------APPEON END-------------------------
	END IF		
ELSEIF dwo.Name = "gapbutton" THEN  //Start Code Change ----12.02.2010 #V10 maha - Work Gap Calculate
	of_calc_work_gap(il_prac_id)
END IF
this.accepttext()


end event

event rbuttondown;call super::rbuttondown;//////////////////////////////////////////////////////////////////////
// $<Event> rbuttondown
// $<arguments>
// $<returns> long
// $<description>WV audit acceptance code migration to PB    (V12.1 Audit Trail)
//////////////////////////////////////////////////////////////////////
// $<add> 12.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

