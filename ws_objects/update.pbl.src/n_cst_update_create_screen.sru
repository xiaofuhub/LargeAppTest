$PBExportHeader$n_cst_update_create_screen.sru
forward
global type n_cst_update_create_screen from nonvisualobject
end type
end forward

global type n_cst_update_create_screen from nonvisualobject autoinstantiate
end type

type variables
String is_sql_statements[]
String is_scr_picname = '2-01.jpg' //for credential screens - alfee 04.30.2010
end variables

forward prototypes
public function string of_get_table_name (integer ai_table_id)
public function integer of_execute (string as_sql, string as_title)
public function integer of_ver101_create_screen ()
public function integer of_insert_data_view (integer ai_screen_ids[], integer ai_table_ids[], str_reference_field astr_ref_fields[])
public function integer of_insert_sys_rpt_fields (integer ai_table_ids[])
public function integer of_insert_profile_dw (integer ai_screen_ids[], integer ai_table_ids[], integer ai_faci_specs[])
public function integer of_insert_verif_rules (integer ai_screen_ids[], integer ai_table_ids[])
public function string of_get_table_name_alias (integer ai_table_id)
public function integer of_insert_view_alias (integer ai_screen_ids[], integer ai_table_ids[])
public function integer of_insert_sys_fields (string as_tbl_names[], str_lookup_field astr_lu_flds[], long al_fld_begin)
public function integer of_ver101_extra_update ()
public function integer of_ver113_create_screen ()
public function integer of_ver142_create_screen ()
public function integer of_update_data_view_fields (integer ai_screen[])
public function integer of_ver151_create_screen ()
public function integer of_ver153_create_screen ()
public function integer of_ver154_create_screen ()
public function integer of_ver161_create_screen ()
end prototypes

public function string of_get_table_name (integer ai_table_id);//Get table alias - Nova 11.13.2010 
//Modified by alfee 01.21.2010

string ls_table

//select table_name into :ls_table from sys_tables where table_id = :ai_table_id;

ls_table = gnv_data.of_getitem("sys_tables","table_name", "table_id =" +string(ai_table_id))
if ls_table = "" then 
	gnv_data.of_retrieve("sys_tables")
	ls_table = gnv_data.of_getitem("sys_tables","table_name", "table_id =" +string(ai_table_id))		
end if

return ls_table




end function

public function integer of_execute (string as_sql, string as_title);Yield()

EXECUTE Immediate :as_sql Using Sqlca;
IF Sqlca.SQLCode <> 0 THEN
	
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(as_sql, Sqlca.SQLErrText,as_title)
	gb_upgrade_failed = TRUE
	RETURN -1
END IF
//IF Sqlca.AutoCommit = False THEN
	COMMIT Using Sqlca;
//END IF
 

RETURN 1

end function

public function integer of_ver101_create_screen ();//Added by  Nova 11.03.2009 --v10.1 Additional Data Screens
//Moved and reconstructed from n_cst_of_update_data - alfee 01.21.2010

//to create a new screen:
//1. create tables & views - n_cst_update_sql/n_cst_update_asa
//2. insert data into sys_tables, profile_reports & lookup tables - n_cst_update_data 
//3. insert data into sys_fields, data_view_screen, data_view_fields (for default view)
//4. insert data into sys_report_fields, profile_report_dw (for each prf view id) 
//5. insert data into view_alias, view_fields_alias (n_cst_update_view_fields_alias)
//6. insert data into facility_ver_rules 

Integer li_rtn
Long ll_field_begin = 31100 //
Long ll_table_ids[] = {70,71,72}
Long ll_screen_ids[] = {70,71,72}
Long ll_faci_specs[] = {1,1,0}
String ls_table_names[] = {'pd_other_verifications','pd_dues_fees','pd_health_history'} 
String ls_prf_dw_names[] = {'d_prf_other_verifications','d_prf_dues_fees','d_prf_health_history'}

str_lookup_field lstr_lookup_fields[]
str_reference_field lstr_ref_fields[]

//define lookup fields
lstr_lookup_fields[1].table_id = 70
lstr_lookup_fields[1].lookup_code = 'Fee Type'
lstr_lookup_fields[1].lookup_field = 'Y'
lstr_lookup_fields[1].lookup_field_name = 'Code'
lstr_lookup_fields[1].lookup_type = 'C'
lstr_lookup_fields[1].drop_down_width = 150
lstr_lookup_fields[1].field_name = 'fee_type'

lstr_lookup_fields[2].table_id = 70
lstr_lookup_fields[2].lookup_code = 'Payment Method'
lstr_lookup_fields[2].lookup_field = 'Y'
lstr_lookup_fields[2].lookup_field_name = 'Code'
lstr_lookup_fields[2].lookup_type = 'C'
lstr_lookup_fields[2].drop_down_width = 150
lstr_lookup_fields[2].field_name = 'payment_method'

lstr_lookup_fields[3].table_id = 71
lstr_lookup_fields[3].lookup_code = 'Health Assessment Type'
lstr_lookup_fields[3].lookup_field = 'Y'
lstr_lookup_fields[3].lookup_field_name = 'Code'
lstr_lookup_fields[3].lookup_type = 'C'
lstr_lookup_fields[3].drop_down_width = 150
lstr_lookup_fields[3].field_name = 'assess_type'

lstr_lookup_fields[4].table_id = 72
lstr_lookup_fields[4].lookup_code = 'Verification Type'
lstr_lookup_fields[4].lookup_field = 'Y'
lstr_lookup_fields[4].lookup_field_name = 'Code'
lstr_lookup_fields[4].lookup_type = 'C'
lstr_lookup_fields[4].drop_down_width = 150
lstr_lookup_fields[4].field_name = 'verif_type'

lstr_lookup_fields[5].table_id = 72
lstr_lookup_fields[5].lookup_code = 'Verification Method'
lstr_lookup_fields[5].lookup_field = 'Y'
lstr_lookup_fields[5].lookup_field_name = 'Code'
lstr_lookup_fields[5].lookup_type = 'C'
lstr_lookup_fields[5].drop_down_width = 150
lstr_lookup_fields[5].field_name = 'verif_method'

lstr_lookup_fields[6].table_id = 72
lstr_lookup_fields[6].lookup_code = 'Verification Entity'
lstr_lookup_fields[6].lookup_field = 'Y'
lstr_lookup_fields[6].lookup_field_name = 'entity_name'
lstr_lookup_fields[6].lookup_type = 'A'
lstr_lookup_fields[6].drop_down_width = 150
lstr_lookup_fields[6].field_name = 'verif_entity'

//define reference fields
lstr_ref_fields[1].table_id = 70
lstr_ref_fields[1].field_name = 'fee_type'
lstr_ref_fields[1].reference_field = 'reference_field_1'

lstr_ref_fields[2].table_id = 71
lstr_ref_fields[2].field_name = 'assess_type'
lstr_ref_fields[2].reference_field = 'reference_field_1'

lstr_ref_fields[3].table_id = 71
lstr_ref_fields[3].field_name = 'assess_date'
lstr_ref_fields[3].reference_field = 'reference_field_2'

lstr_ref_fields[4].table_id = 72
lstr_ref_fields[4].field_name = 'verif_type'
lstr_ref_fields[4].reference_field = 'reference_field_1'


IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - lnv_create_screen.of_ver101_create_screen()"
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_ver101_create_screen'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1, UpperBound(ll_screen_ids))

//insert data into sys_fields
li_rtn = of_insert_sys_fields(ls_table_names, lstr_lookup_fields, ll_field_begin)
if li_rtn < 0 then return -1

//insert data into data_view_screen, data_view_fields
li_rtn = of_insert_data_view(ll_screen_ids, ll_table_ids, lstr_ref_fields)
if li_rtn < 0 then return -1

//insert data into sys_reports_fields from sys_fields
li_rtn = of_insert_sys_rpt_fields(ll_table_ids)
if li_rtn < 0 then return -1

//insert data into profile_report_dw for each profile view
li_rtn = of_insert_profile_dw(ll_screen_ids, ll_table_ids, ll_faci_specs)
if li_rtn < 0 then return -1

//insert data into view_alias
li_rtn = of_insert_view_alias(ll_screen_ids, ll_table_ids)
if li_rtn < 0 then return -1

//insert data into facility_verif_rules for each facility
li_rtn = of_insert_verif_rules(ll_screen_ids, ll_table_ids)
if li_rtn < 0 then return -1

//modify screens additionally - alfee 04.30.2010
li_rtn = of_ver101_extra_update()
if li_rtn < 0 then return -1

RETURN 1



end function

public function integer of_insert_data_view (integer ai_screen_ids[], integer ai_table_ids[], str_reference_field astr_ref_fields[]);//Insert data into data_view_screen & data_view_fields - Nova 11.13.2009
//Reconstructed by alfee 01.21.2010

Integer li_nr, loop_cnt, li_rtn
Integer li_table_id, li_screen_id
Long i, j, k, ll_row, ll_ref_flds_cnt, ll_table_cnt, ll_sys_flds_cnt, ll_found
Long ll_label_x, ll_label_y, ll_field_x, ll_field_y
Long ll_field_id, ll_dv_field_id, ll_ref_field_id, ll_ref1, ll_ref2, ll_ref3
String ls_field, ls_screen_name, ls_table_name
string ls_crit, ls_Error

n_cst_datastore lds_data_view_screen
n_cst_datastore lds_sys_fields_for_screen
n_cst_datastore lds_data_view_fields

ll_table_cnt = UpperBound(ai_table_ids[])
ll_ref_flds_cnt = UpperBound(astr_ref_fields[])

IF ll_table_cnt < 1 THEN RETURN 0

//Initialize data
lds_sys_fields_for_screen = Create n_cst_datastore
lds_data_view_screen = Create n_cst_datastore
lds_data_view_fields = Create n_cst_datastore

lds_data_view_screen.DataObject = 'd_create_cust_screen_data_view_screen'
lds_data_view_fields.DataObject = 'd_data_view_fields_list'
lds_sys_fields_for_screen.DataObject = "d_sys_fields_for_new_screen"

lds_data_view_screen.SetTransObject(sqlca)
lds_data_view_fields.SetTransObject(sqlca)
lds_sys_fields_for_screen.SetTransObject( sqlca)

gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve("data_view_screen")
SELECT Max( data_view_field_id ) Into :ll_dv_field_id From data_view_fields;
gnv_appeondb.of_commitqueue( )

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - " + 'lnv_create_screen.of_insert_data_view' + "()"
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_insert_data_view'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_table_cnt)

//Loop for each table
FOR i = 1 To ll_table_cnt
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Modification ' +String(i) +' of '+ String(ll_table_cnt) +', Please stand by!'

	//1. Set data in data_view_screen
	li_table_id = ai_table_ids[i]
	li_screen_id = ai_screen_ids[i]
	ls_screen_name = of_get_table_name_alias(li_table_id)
	ls_table_name = of_get_table_name(li_table_id)

	//skip if the screen's existed
	IF gnv_data.of_getitem("data_view_screen", "table_id", "table_id = " + string(li_table_id)) <> "" THEN 
		Continue
	END IF

	//set screen data
	ll_row = lds_data_view_screen.InsertRow( 0 )
	lds_data_view_screen.SetItem( ll_row, "data_view_id", 1 )
	lds_data_view_screen.SetItem( ll_row, "screen_id", li_screen_id )
	lds_data_view_screen.SetItem( ll_row, "screen_order", li_screen_id )
	lds_data_view_screen.SetItem( ll_row, "screen_name", ls_screen_name )
	lds_data_view_screen.SetItem( ll_row, "screen_alias", ls_screen_name )
	lds_data_view_screen.SetItem( ll_row, "multi_record", 'Y'  ) //?
	lds_data_view_screen.SetItem( ll_row, "table_id", li_table_id)		

	//set screen reference fields 
	ll_sys_flds_cnt = lds_sys_fields_for_screen.Retrieve(li_table_id)	
	//--Begin added by alfee 03.31.2010---
	lds_sys_fields_for_screen.SetSort("field_order A") 
	lds_sys_fields_for_screen.Sort()
	//--End added -----------------------
	
	FOR k = 1 To ll_ref_flds_cnt //loop in ref fields array
		IF astr_ref_fields[k].table_id = li_table_id THEN
			ls_crit = "table_id = " + string(li_table_id) + " and lower(field_name) = '" + Lower(astr_ref_fields[k].field_name) + "'"
			ll_found = lds_sys_fields_for_screen.find(ls_crit, 1, ll_sys_flds_cnt)	
			if ll_found > 0 then 
				ll_ref_field_id = lds_sys_fields_for_screen.getitemnumber(ll_found, "field_id")
				lds_data_view_screen.SetItem( ll_row, astr_ref_fields[k].reference_field, ll_ref_field_id)
			end if
		END IF
	NEXT
	ll_ref1 = lds_data_view_screen.GetItemNumber( ll_row, "reference_field_1")
	ll_ref2 = lds_data_view_screen.GetItemNumber( ll_row, "reference_field_2")
	ll_ref3 = lds_data_view_screen.GetItemNumber( ll_row, "reference_field_3")	

	//2. Loop for each field, set data in data_view_fields for default view
	loop_cnt  = 0 //used to determine position
	ll_label_y = 100
	ll_field_y = 164
	ll_label_x = 100
	ll_field_x = 100
	
	FOR j = 1 To ll_sys_flds_cnt
		//skip fields of rec_id, prac_id & facility_id 
		ls_field = Lower(lds_sys_fields_for_screen.GetItemString( j, "field_name" ))
		IF ls_field = "rec_id" Or ls_field = "prac_id" Or ls_field = "facility_id" THEN
			CONTINUE
		END IF
		
		//determine position
		loop_cnt ++
		IF loop_cnt = 1 THEN //set the first field to x/100 - y/100 additional fields 3 across and down y/150 and back to x/100
			ll_field_x = 100 //y is also 100
		ELSEIF ll_field_x > 1400 THEN //x should be 100, 800 or 1500 if a 1500 reset x to 100
			ll_field_x = 100
			ll_label_y = ll_label_y + 150
			ll_field_y = ll_field_y + 150
		ELSE
			ll_field_x = ll_field_x + 700
		END IF
		ll_label_x = ll_field_x //label and field on the same vertical
		
		//set properties		
		ll_dv_field_id++
		li_nr = lds_data_view_fields.InsertRow( 0 )
		ll_field_id = lds_sys_fields_for_screen.GetItemNumber( j, "field_id" )
		lds_data_view_fields.SetItem( li_nr, "data_view_id", 1)
		lds_data_view_fields.SetItem( li_nr, "data_view_field_id", ll_dv_field_id )
		lds_data_view_fields.SetItem( li_nr, "screen_id", li_screen_id )
		lds_data_view_fields.SetItem( li_nr, "field_id", ll_field_id )
		lds_data_view_fields.SetItem( li_nr, "field_label",lds_sys_fields_for_screen.GetItemString( j, "field_name_allias" ) )
		lds_data_view_fields.SetItem( li_nr, "field_order", lds_sys_fields_for_screen.GetItemNumber( j, "field_order" ) )
		lds_data_view_fields.SetItem( li_nr, "required", "N" ) 
		lds_data_view_fields.SetItem( li_nr, "field_width", 500 )
		lds_data_view_fields.SetItem( li_nr, "field_label_width", 500 ) //30 per character
		lds_data_view_fields.SetItem( li_nr, "display_only", 'N' )
		lds_data_view_fields.SetItem( li_nr, "field_height", 64 )
		lds_data_view_fields.SetItem( li_nr, "edit_field_type", "E" )
		lds_data_view_fields.SetItem( li_nr, "field_x", ll_field_x )
		lds_data_view_fields.SetItem( li_nr, "field_label_x", ll_label_x )
		lds_data_view_fields.SetItem( li_nr, "field_label_y", ll_label_y )
		lds_data_view_fields.SetItem( li_nr, "field_y", ll_field_y )
		if LeftA(Lower(ls_field), 5) = 'cust_' then
			lds_data_view_fields.SetItem( li_nr, "visible", 'N')//default 'Y'
		end if
		if ll_field_id = ll_ref1 or ll_field_id = ll_ref2 or ll_field_id = ll_ref3 then
			lds_data_view_fields.SetItem( li_nr, "required", 'Y')	
			lds_data_view_fields.SetItem( li_nr, "label_underline", '1')		
		end if
	NEXT

	IF IsValid(w_infodisp) THEN w_infodisp.wf_step_pbar(1)
NEXT

//Update data
IF lds_data_view_screen.Update( ) = 1 THEN
	IF lds_data_view_fields.Update( ) = 1 THEN
		li_rtn = 1		
		COMMIT Using sqlca;
	ELSE
		li_rtn = -1
		ls_Error += "n_cst_update_create_screen.of_insert_data_view() Information: Update data_view_fields failed!"
		IF IsValid(gnv_logservice) THEN
			ROLLBACK Using sqlca;
			gnv_logservice.of_setloglevel(2) 
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = True
		END IF
	END IF
ELSE
	li_rtn = -1	
	ls_Error += "n_cst_update_create_screen.of_insert_data_view() Information: Update data_view_screen failed!"
	IF IsValid(gnv_logservice) THEN
		ROLLBACK Using sqlca;
		gnv_logservice.of_setloglevel(2) 
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	END IF
END IF

Destroy lds_data_view_screen
Destroy lds_sys_fields_for_screen
Destroy lds_data_view_fields

RETURN li_rtn
















end function

public function integer of_insert_sys_rpt_fields (integer ai_table_ids[]);//insert data to sys_report_fields - Nova 11.13.2009
//modified by alfee 01.21.2010

Integer i, li_rtn
String ls_sql, ls_tables

for i = 1 to UpperBound(ai_table_ids) 
	if i <> 1 then ls_tables += ", "
	ls_tables += string(ai_table_ids[i])
next

if LenA(ls_tables) < 1 then return 0

//ls_sql = "insert sys_report_fields select *  " + & //replaced the '*' by alfee 12.17.2015
ls_sql = "insert sys_report_fields " + &	
	"select table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias,field_case,lookup_type,lookup_field,lookup_code,lookup_field_name,validate_against_lookup,field_mask,valid_values,range_from,range_to,audit_fld,default_value,micro_help,key_field,drop_down_width,app_fill_field_len,sort_field,sort_order,use_validation	" + &	
	"  from sys_fields    " + &
	" where table_id in (" + ls_tables + ") and " + &
	"   NOT EXISTS (select * from sys_report_fields  " +&
	"					      where table_id=sys_fields.table_id and field_id=sys_fields.field_id)"

li_rtn = of_execute(ls_sql,"of_insert_sys_rpt_fields")

RETURN li_rtn


end function

public function integer of_insert_profile_dw (integer ai_screen_ids[], integer ai_table_ids[], integer ai_faci_specs[]);//Insert data into profile_report_dw for each profile view id - alfee 01.21.2010

Integer li_rtn, li_table_id, li_screen_id, li_prf_view_id
Long i, j, ll_cnt, ll_cnt_views, ll_cnt_dws, ll_row 
String ls_prf_dwname,ls_scr_dwname,ls_screen_name,ls_table_name
String ls_retrieval_aruments, ls_error
datastore lds_prf_views, lds_prf_rep_dws

ll_cnt = UpperBound(ai_screen_ids)
if ll_cnt < 1 then return -1

//set datastores
lds_prf_views = create datastore
lds_prf_rep_dws = create datastore
lds_prf_views.dataobject = "d_dddw_profile_views_new"
lds_prf_rep_dws.dataobject = "d_profile_report_dw" 
lds_prf_views.settransobject(sqlca)
lds_prf_rep_dws.settransobject(sqlca)

gnv_appeondb.of_startqueue()
lds_prf_views.retrieve()
lds_prf_rep_dws.retrieve() //999
gnv_appeondb.of_commitqueue()

ll_cnt_views = lds_prf_views.rowcount()
ll_cnt_dws = lds_prf_rep_dws.rowcount()

//Loop for each screen
for i = 1 to ll_cnt //screens
	//skip if existed
	if lds_prf_rep_dws.find("scr_id =" + string(ai_screen_ids[i]),1, ll_cnt_dws ) > 0 then		
		continue 
	end if
	
	//get data
	li_table_id = ai_table_ids[i]
	li_screen_id = ai_screen_ids[i]
	ls_table_name = of_get_table_name(li_table_id)
	ls_screen_name = of_get_table_name_alias(li_table_id)
	
	ls_prf_dwname = ReplaceA(ls_table_name, 1, 3, "d_prf_")
	ls_scr_dwname = ReplaceA(ls_table_name, 1, 3, "d_scr_")
	IF ai_faci_specs[i] = 1 THEN 
		ls_retrieval_aruments = 'PF'
	ELSE
		ls_retrieval_aruments = 'P'
	END IF 

	//insert data for each prf view
	for j = 1 to ll_cnt_views //prf views
		li_prf_view_id = lds_prf_views.getitemnumber(j, "profile_view_id")
		ll_row = lds_prf_rep_dws.insertrow(0)
		lds_prf_rep_dws.setitem(ll_row, "data_view_id", 1)
		lds_prf_rep_dws.setitem(ll_row, "cur_dw", ls_prf_dwname)		
		lds_prf_rep_dws.setitem(ll_row, "prf_dw", ls_prf_dwname)		
		lds_prf_rep_dws.setitem(ll_row, "scr_dw", ls_scr_dwname)	
		lds_prf_rep_dws.setitem(ll_row, "prf_id", li_screen_id)//generally same
		lds_prf_rep_dws.setitem(ll_row, "scr_id", li_screen_id)
		lds_prf_rep_dws.setitem(ll_row, "table_id", li_table_id)
		lds_prf_rep_dws.setitem(ll_row, "report_id", li_screen_id)//		
		lds_prf_rep_dws.setitem(ll_row, "dw_name", ls_screen_name)
		lds_prf_rep_dws.setitem(ll_row, "retrieval_aruments", ls_retrieval_aruments)		
		lds_prf_rep_dws.setitem(ll_row, "profile_view_id", li_prf_view_id)		
	next
next

//update data
IF lds_prf_rep_dws.Update( ) = 1 THEN
	li_rtn = 1
ELSE
	li_rtn = -1
	ls_Error += "n_cst_update_create_screen Information: Insert profile_report_dw failed!"
	if IsValid(gnv_logservice) then
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	end if
END IF

DESTROY lds_prf_views  
DESTROY lds_prf_rep_dws

RETURN li_rtn


end function

public function integer of_insert_verif_rules (integer ai_screen_ids[], integer ai_table_ids[]);//Create facility rules for each new screen - Nova 11.13.2009
//Reconstructed by alfee 01.21.2010

Integer li_rtn
Integer li_screen_id, li_table_id, li_facility_id
Long i, ll_i, ll_row 
Long ll_faci_cnt, ll_scr_cnt, ll_rules_cnt
String ls_ver_ltr_doc, ls_exp_doc_name
String ls_screen_name, ls_Error

n_cst_string lnv_string
datastore lds_facility, lds_facility_ver_rules

ll_scr_cnt = upperbound(ai_screen_ids)
if ll_scr_cnt < 1 then return 0

//set datastores
lds_facility = Create datastore
lds_facility_ver_rules = Create datastore
lds_facility.DataObject = 'd_facility_appeon'
lds_facility_ver_rules.DataObject = 'd_facility_ver_rules_appeon'
lds_facility.SetTransObject(sqlca)
lds_facility_ver_rules.SetTransObject(sqlca)

gnv_appeondb.of_startqueue()
lds_facility.Retrieve()
lds_facility_ver_rules.Retrieve()
gnv_appeondb.of_commitqueue()

ll_faci_cnt = lds_facility.rowcount()
ll_rules_cnt = lds_facility_ver_rules.rowcount()

//loop for each screen
FOR i = 1 to ll_scr_cnt
	li_table_id = ai_table_ids[i]
	li_screen_id = ai_screen_ids[i]	
	ls_screen_name = of_get_table_name_alias(li_table_id)
	ls_screen_name = lnv_string.of_globalreplace(Lower(ls_screen_name), ' ', '_')
	ls_screen_name = lnv_string.of_globalreplace(Lower(ls_screen_name), '/', '_') //V11.3 Issue Screen - alfee 07.14.2011	
	ls_ver_ltr_doc = "ind_" + ls_screen_name + "_letter.doc"
	ls_exp_doc_name = "ind_expiring_" + ls_screen_name + "_letter.doc" 
	
	//skip if existed
	if lds_facility_ver_rules.find("screen_id =" +string(li_screen_id),1, ll_rules_cnt) > 0 then
		Continue
	end if
	
	//set rules data for each facility
	FOR ll_i = 1 To ll_faci_cnt
		li_facility_id = lds_facility.GetItemNumber(ll_i,'facility_id')
		IF Not IsNull(li_facility_id) And Not IsNull(li_screen_id) THEN
			ll_row = lds_facility_ver_rules.InsertRow(0)
			lds_facility_ver_rules.SetItem(ll_row,'facility_id',li_facility_id)
			lds_facility_ver_rules.SetItem(ll_row,'screen_id',li_screen_id)
			lds_facility_ver_rules.SetItem(ll_row,'verify_data','N')
			lds_facility_ver_rules.SetItem(ll_row,'required','N')
			lds_facility_ver_rules.SetItem(ll_row,'send_exp_reminder','N')
			lds_facility_ver_rules.SetItem(ll_row,'exp_cred_que_letters_days',30)
			lds_facility_ver_rules.SetItem(ll_row,'init_veif_letter_doc_nm',ls_ver_ltr_doc)
			lds_facility_ver_rules.SetItem(ll_row,'exp_cred_letter_doc_nm',ls_exp_doc_name)
			lds_facility_ver_rules.SetItem(ll_row,'ver_letter_resend_days',30)
			lds_facility_ver_rules.SetItem(ll_row,'ver_letter_max_sends',3)
			lds_facility_ver_rules.SetItem(ll_row,'default_verif_means',15)
			lds_facility_ver_rules.SetItem(ll_row,'exp_reminder_doc','') //?
			lds_facility_ver_rules.SetItem(ll_row,'ver_ltr_doc','') //?
		END IF
	NEXT
NEXT	

//update data	
IF lds_facility_ver_rules.Update() = 1 THEN
	li_rtn = 1
	COMMIT Using sqlca;
ELSE
	li_rtn = -1
	ls_Error += "n_cst_update_create_screen.of_insert_verif_rules() Information: Create verif_rules failed!"
	IF IsValid(gnv_logservice) THEN
		ROLLBACK Using sqlca;
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	END IF
END IF

Destroy lds_facility
Destroy lds_facility_ver_rules

RETURN li_rtn



end function

public function string of_get_table_name_alias (integer ai_table_id);//Get table alias - Nova 11.13.2010 
//Modified by alfee 01.21.2010

string ls_table_name

//select table_name_allias into :ls_table_name from sys_tables where table_id = :as_table_id;

ls_table_name = gnv_data.of_getitem("sys_tables","table_name_allias", "table_id =" +string(ai_table_id))
if ls_table_name = "" then 
	gnv_data.of_retrieve("sys_tables")
	ls_table_name = gnv_data.of_getitem("sys_tables","table_name_allias", "table_id =" +string(ai_table_id))		
end if

return ls_table_name


end function

public function integer of_insert_view_alias (integer ai_screen_ids[], integer ai_table_ids[]);//Insert data into view_alias - Nova 11.13.2010
//Reconstructed by alfee 01.21.2010

Integer li_rtn
Long i, ll_cnt, ll_tbl_cnt, ll_row
String ls_view, ls_table, ls_table_alias, ls_Error

n_cst_datastore lds_view_alias

ll_tbl_cnt = UpperBound(ai_table_ids)
if ll_tbl_cnt < 1 then return 0

//set datastores
lds_view_alias = Create n_cst_datastore
lds_view_alias.DataObject = 'd_view_alias_rpt' //updatable
lds_view_alias.SetTransObject( sqlca)
ll_cnt = lds_view_alias.retrieve(2) //mudule = 2

//loop for each new table
for i = 1 to ll_tbl_cnt
	ls_table = of_get_table_name(ai_table_ids[i])
	ls_table_alias = of_get_table_name_alias(ai_table_ids[i])
	ls_view = "v_"  + MidA(ls_table,4)
	
	//skip if existed
	if lds_view_alias.find("lower(v_name) = '" + Lower(ls_view) + "'", 1, ll_cnt) > 0 then
		continue
	end if
	
	//insert in view_alias
	ll_row = lds_view_alias.InsertRow( 0)
	lds_view_alias.SetItem(ll_row,"module", 2)
	lds_view_alias.SetItem(ll_row,"v_name",ls_view)
	lds_view_alias.SetItem(ll_row,"v_alias",ls_table_alias)
	lds_view_alias.SetItem(ll_row,"screen",String(ai_screen_ids[i]))
	lds_view_alias.SetItem(ll_row,"sflag",'Y')
	lds_view_alias.SetItem(ll_row,"p_name",is_scr_picname) //alfee 04.30.2010
	lds_view_alias.SetItem(ll_row,"mflag",1) //alfee 04.30.2010
next

//update data
IF lds_view_alias.Update( ) = 1 THEN
	li_rtn = 1
	COMMIT Using sqlca;		
ELSE
	li_rtn = -1		
	ls_Error += "n_cst_update_create_screen.of_insert_view_alias() Information: Create view_alias failed!"
	IF IsValid(gnv_logservice) THEN

		ROLLBACK Using sqlca;
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	END IF
END IF

DESTROY lds_view_alias

RETURN li_rtn





end function

public function integer of_insert_sys_fields (string as_tbl_names[], str_lookup_field astr_lu_flds[], long al_fld_begin);//Insert data into sys_fields based on the physical tables - Nova 11.13.2009
//Reconstructed by alfee 01.21.2010

Integer li_rtn, li_order, li_field_len
Long i, j, ll_fld_cnt, ll_row_cnt, ll_lu_fld_cnt
Long ll_field_id, ll_table_id, ll_table_id_old
String ls_field, ls_field_allias, ls_table, ls_field_type, ls_table_ids[]
String ls_Error

n_cst_datastore lds_fields
n_cst_datastore lds_sys_fields

//set datastores
lds_fields = Create n_cst_datastore
lds_sys_fields  = Create n_cst_datastore
IF gs_dbtype = "ASA" THEN
	lds_fields.DataObject = "d_sys_fields_asa"
ELSE
	lds_fields.DataObject = "d_sys_fields_sql"
END IF
//lds_sys_fields.DataObject = "d_new_screen_columns_sys"
lds_sys_fields.DataObject = "d_sys_fields_list"
lds_fields.SetTransObject( sqlca)
lds_sys_fields.SetTransObject( sqlca)

ll_lu_fld_cnt = UpperBound(astr_lu_flds)
ll_fld_cnt = lds_fields.Retrieve(as_tbl_names)

//return if no additional fields
IF ll_fld_cnt < 1 THEN 
	DESTROY lds_fields 
	DESTROY lds_sys_fields	
	RETURN 0
END IF

ll_field_id = al_fld_begin
IF ll_field_id = 0 THEN 
	SELECT Max( field_id ) Into :ll_field_id From sys_fields ;
END IF

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - " + 'lnv_create_screen.of_insert_sys_fields' + "()"
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_insert_sys_fields'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_fld_cnt)

//set field properties - loop in tables & fields
FOR i = 1 To ll_fld_cnt
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Modification ' +String(i) +' of '+ String(ll_fld_cnt) +', Please stand by!'	
	
	ll_field_id ++
	ll_row_cnt = lds_sys_fields.InsertRow( 0)
	ll_table_id = lds_fields.GetItemNumber(i,"table_id")
	ls_field = lds_fields.GetItemString(i,"cname")
	
	//set field basic properties
	ls_field_type = lds_fields.GetItemString(i,"coltype")
	li_field_len = lds_fields.GetItemNumber(i,"length")
	lds_sys_fields.SetItem(ll_row_cnt,"table_id",ll_table_id)
	lds_sys_fields.SetItem(ll_row_cnt,"field_id",ll_field_id)
	lds_sys_fields.SetItem(ll_row_cnt,"field_type",ls_field_type)
	lds_sys_fields.SetItem(ll_row_cnt,"field_name",ls_field)	
	lds_sys_fields.SetItem(ll_row_cnt,"field_len",li_field_len)
	lds_sys_fields.SetItem(ll_row_cnt,"audit_fld","Y")	//default
	lds_sys_fields.SetItem(ll_row_cnt,"app_fill_field_len",li_field_len) //same as default
	if ls_field_type = 'D' then 
		lds_sys_fields.SetItem(ll_row_cnt,"field_mask",'mm/dd/yyyy')		
	end if

	//set field lookup properties
	FOR j = 1 To ll_lu_fld_cnt
		IF astr_lu_flds[j].table_id = ll_table_id And astr_lu_flds[j].field_name = ls_field THEN
			lds_sys_fields.SetItem(ll_row_cnt,"lookup_type",astr_lu_flds[j].lookup_type)
			lds_sys_fields.SetItem(ll_row_cnt,"lookup_field",astr_lu_flds[j].lookup_field)
			lds_sys_fields.SetItem(ll_row_cnt,"lookup_code",astr_lu_flds[j].lookup_code)
			lds_sys_fields.SetItem(ll_row_cnt,"lookup_field_name",astr_lu_flds[j].lookup_field_name) //lookup_field_name='Code'
			lds_sys_fields.SetItem(ll_row_cnt,"drop_down_width",astr_lu_flds[j].drop_down_width) //drop_dwon_width
			EXIT
			//CONTINUE
		END IF
	NEXT
	
	//set field order & other properties
	IF ll_table_id_old <> ll_table_id THEN //data ordered by table_id
		li_order = 0
		ll_table_id_old = ll_table_id
	END IF
	CHOOSE CASE Lower(ls_field)
		CASE "prac_id","facility_id","rec_id"
			lds_sys_fields.SetItem(ll_row_cnt,"field_order",0)
			lds_sys_fields.SetItem(ll_row_cnt,"audit_fld",'N') //
		CASE ELSE
			li_order ++
			lds_sys_fields.SetItem(ll_row_cnt,"field_order", li_order * 10)
	END CHOOSE
	
	//set field allias
	DO WHILE PosA(ls_field, "_") > 0
		ls_field = ReplaceA(ls_field, PosA(ls_field, "_") +1, 1, Upper(MidA(ls_field, PosA(ls_field, "_") +1,1)))
		ls_field = ReplaceA(ls_field, PosA(ls_field, "_"), 1, " ")
	LOOP
	ls_field_allias = ReplaceA(ls_field,1,1,Upper(MidA(ls_field,1,1)))
	lds_sys_fields.SetItem(ll_row_cnt,"field_name_allias",ls_field_allias)

	IF IsValid(w_infodisp) THEN w_infodisp.wf_step_pbar(1)
NEXT

//update data
IF lds_sys_fields.Update( ) = 1 THEN
	li_rtn = 1
ELSE
	li_rtn = -1
	ls_Error += "n_cst_update_create_screen Information: Insert sys_fields failed!"
	if IsValid(gnv_logservice) then
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	end if
END IF

DESTROY lds_fields 
DESTROY lds_sys_fields

RETURN li_rtn







end function

public function integer of_ver101_extra_update ();//Extra data modifications for new screens - alfee 01.21.2010
//e.g., for sys_fields: 
//		field_case, validate_against_lookup, field_mask, valid_values,
//		range_from, range_to, audit_fld, default_value, key_field,
//		app_fill_field_len, sort_field, sort_order, use_validation
//e.g., for data_view_fields: 
//		display_only, required, include_in_browse, visible

integer li_rtn
string ls_sql

//for view_alias - moved here by alfee 04.30.2010
ls_sql  = "UPDATE view_alias set p_name = '2-01.jpg', mflag=1 "
ls_sql += " WHERE mflag is null "
ls_sql += "   AND ((v_name = 'v_dues_fees' and screen = '70') "
ls_sql += "    OR (v_name = 'v_health_history' and screen = '71') "
ls_sql += "    OR (v_name = 'v_other_verifications' and screen = '72'))"

li_rtn = of_execute(ls_sql,"of_ver101_extra_update")

return li_rtn 

end function

public function integer of_ver113_create_screen ();//V11.3 Issue Screen - alfee 07.13.2011

//1. create tables & views - n_cst_update_sql/n_cst_update_asa
//2. insert data into sys_tables, sys_fields & lookup tables - n_cst_update_data 
//3. insert data into data_view_screen, data_view_fields (for default view) - n_cst_update_data 
//4. insert data into profile_reports - n_cst_update_data 
//5. insert data into sys_report_fields, profile_report_dw (for each prf view id) 
//6. insert data into view_alias, view_fields_alias (n_cst_update_view_fields_alias)
//7. update the update_view_fields.txt to set field_name for lookup fields in view_fields_alias (called in n_cst_update_view_fields_alias)
//8. insert data into facility_ver_rules 
//9. insert data into import_tables to support new tables in the import module - n_cst_update_data 
//10. create datawindows for profile report (d_prf_issues & d_scr_issues)


Integer li_rtn
Long ll_table_ids[] = {73}
Long ll_screen_ids[] = {73}
Long ll_faci_specs[] = {0}

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - lnv_create_screen.of_ver113_create_screen()"
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_ver113_create_screen'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1, UpperBound(ll_screen_ids))

//insert data into sys_reports_fields from sys_fields
li_rtn = of_insert_sys_rpt_fields(ll_table_ids)
if li_rtn < 0 then return -1

//insert data into profile_report_dw for each profile view
li_rtn = of_insert_profile_dw(ll_screen_ids, ll_table_ids, ll_faci_specs)
if li_rtn < 0 then return -1

//insert data into view_alias
li_rtn = of_insert_view_alias(ll_screen_ids, ll_table_ids)
if li_rtn < 0 then return -1

//insert data into facility_verif_rules for each facility
li_rtn = of_insert_verif_rules(ll_screen_ids, ll_table_ids)
if li_rtn < 0 then return -1

RETURN 1



end function

public function integer of_ver142_create_screen ();//====================================================================
//$<Function>: of_ver142_create_screen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.24.2014 (New IntelliCred Fields Ver 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_table_ids[] = {6,25,13,9,23,18,19,29}
long  ll_screen_ids[] = {1,5,7,9,10,13,23,26,27}
integer li_rtn

//insert data into sys_reports_fields from sys_fields
li_rtn = of_insert_sys_rpt_fields(ll_table_ids)
if li_rtn < 0 then return -1

//insert data into data_view_fields   
li_rtn = of_update_data_view_fields(ll_screen_ids)
if li_rtn < 0 then return -1
return 1
end function

public function integer of_update_data_view_fields (integer ai_screen[]);//====================================================================
//$<Function>: of_update_data_view_fields
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.15.2014 (New IntelliCred Fields Ver 14.2)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_screen_id
integer li_data_view_id, li_screen_cnt
integer li_cnt, li_i,  li_ret
integer li_rtn
long     ll_field_id, ll_row
string   ls_error
datastore lds_data_view_fields_from
datastore lds_data_view_fields_to
datastore lds_data_view

lds_data_view_fields_from = create datastore
lds_data_view_fields_to     = create datastore
lds_data_view     = create datastore

lds_data_view_fields_from.dataobject = 'd_update_data_view_fields'
lds_data_view_fields_from.settransobject(sqlca)
lds_data_view_fields_to.dataobject = 'd_data_view_fields'
lds_data_view_fields_to.settransobject(sqlca)
lds_data_view.dataobject = 'd_dddw_select_view'
lds_data_view.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
lds_data_view.retrieve()
SELECT Max( data_view_fields.data_view_field_id )  
INTO :ll_field_id  
FROM data_view_fields  ;
gnv_appeondb.of_commitqueue( )	

li_screen_cnt = upperbound(ai_screen)
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - " + 'lnv_create_screen.of_update_data_view_fields' + "()"
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_update_data_view_fields'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,li_screen_cnt)

li_rtn = 1
for li_i = 1 to li_screen_cnt
	li_screen_id = ai_screen[li_i]
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Modification ' +String(li_i) +' of '+ String(li_screen_cnt) +', Please stand by!'
	
	for li_cnt = 1 to lds_data_view.rowcount()
		li_data_view_id = lds_data_view.getitemnumber(li_cnt , "data_view_id")
		if li_data_view_id = 1 then continue
		
		gnv_appeondb.of_startqueue( )
		lds_data_view_fields_from.retrieve(1, li_screen_id, li_data_view_id)
		lds_data_view_fields_to.retrieve(li_data_view_id, li_screen_id)
		gnv_appeondb.of_commitqueue( )	
		if lds_data_view_fields_to.rowcount() < 1 or lds_data_view_fields_from.rowcount() < 1 then continue
		
		lds_data_view_fields_to.reset()
		li_ret = lds_data_view_fields_from.RowsCopy(1, lds_data_view_fields_from.RowCount(), Primary!, lds_data_view_fields_to, 1, Primary!)

		if lds_data_view_fields_from.RowCount() > 0 and  li_ret < 1 then 
			ls_Error += "n_cst_update_create_screen Information: Update data_view_fields failed!"
			li_rtn = -1
			exit
		end if
		FOR ll_row = 1 TO lds_data_view_fields_to.rowcount()
			lds_data_view_fields_to.SetItem( ll_row, "data_view_id", li_data_view_id )
			ll_field_id ++
			lds_data_view_fields_to.SetItem( ll_row, "data_view_field_id", ll_field_id )
		next
		
		IF lds_data_view_fields_to.Update( True, False ) = 1 THEN
			lds_data_view_fields_to.resetupdate()
		else
			ls_Error += "n_cst_update_create_screen Information: Update data_view_fields failed!"
			li_rtn = -1
			exit;
		END IF
	next
	IF IsValid(w_infodisp) THEN w_infodisp.wf_step_pbar(1)
next

if li_rtn = -1 then
	rollback using sqlca;
	if IsValid(gnv_logservice) then
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = True
	end if
end if
destroy lds_data_view_fields_from
destroy lds_data_view_fields_to
destroy lds_data_view

return li_rtn
end function

public function integer of_ver151_create_screen ();//====================================================================
//$<Function>: of_ver151_create_screen
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 03.05.2015 (V15.1-Additional data field : basic and address)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_table_ids[] = {25,20}
long  ll_screen_ids[] = {1,2}
integer li_rtn

//insert data into sys_reports_fields from sys_fields
li_rtn = of_insert_sys_rpt_fields(ll_table_ids)
if li_rtn < 0 then return -1

//insert data into data_view_fields   
li_rtn = of_update_data_view_fields(ll_screen_ids)
if li_rtn < 0 then return -1
return 1
end function

public function integer of_ver153_create_screen (); //Start Code Change ----04.05.2017 #V153 maha
Long ll_table_ids[] = {25}
long  ll_screen_ids[] = {27}
integer li_rtn

//insert data into sys_reports_fields from sys_fields
li_rtn = of_insert_sys_rpt_fields(ll_table_ids)
if li_rtn < 0 then return -1

//insert data into data_view_fields   
li_rtn = of_update_data_view_fields(ll_screen_ids)
if li_rtn < 0 then return -1
return 1
end function

public function integer of_ver154_create_screen ();return 1
end function

public function integer of_ver161_create_screen ();return 1
end function

on n_cst_update_create_screen.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_create_screen.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

