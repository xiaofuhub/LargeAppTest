$PBExportHeader$pfc_cst_nv_data_entry_functions.sru
forward
global type pfc_cst_nv_data_entry_functions from nonvisualobject
end type
end forward

global type pfc_cst_nv_data_entry_functions from nonvisualobject
end type
global pfc_cst_nv_data_entry_functions pfc_cst_nv_data_entry_functions

type variables
Integer ii_column_cnt

long		il_values[]

String is_sort_syntax
String is_column_names[]
String is_column_default[]
String is_rec_id_col_nm
String is_first_column 
String is_table_name
String	is_types[] , is_froms[] , is_dddwcolumns[] , is_lu_tables[] //$<add> 01.25.2006 By: Cao YongWang
string is_sort_lookup_fields[]  //maha 11.10.2016

n_ds ids_lookup_code
n_ds ids_lookup_address
n_ds ids_screen_fields
n_ds ids_screen_objects
n_ds ids_sys_audit
n_ds ids_report_objects  //$<add> 25/08/2008 By: Alan
DataStore ids_address_lookup  //$<add> 07.26.2007 By: Evan
DataStore ids_application

Boolean ib_vscroll = False
Boolean ib_retrieve_enabled = TRUE //used in of_create_dynamic_ds() - alfee 09.08.2009
Boolean ib_caqh_import = FALSE //caqh 2 - alfee 12.18.2009
boolean	ib_report = false   //$<add> 25/08/2008 By: Alan
datetime idt_screen_cache







end variables

forward prototypes
public function string of_get_first_column ()
public function integer of_set_defaults (u_dw a_dw, integer ai_row)
public function integer of_setup_cache ()
public function integer of_itemchanged (u_dw a_dw, string as_data)
public function integer of_record_validation (u_dw a_dw)
public function integer of_update_dddw (u_dw a_dw_detail, u_dw a_dw_browse)
public function integer of_create_dynamic_dw_browse (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_browse)
public function integer of_create_dynamic_ds_old (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail)
public function integer of_refresh_cache ()
public function integer of_get_next_seq_no (string as_dw, long al_rec_id)
public function integer of_add_address_link (long al_prac_id, integer ai_facility_id)
public function string of_create_dynamic_profile_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id)
public function integer of_get_facil_specific (integer ai_table)
public function integer of_add_hosp_link (long ai_facility_id, long al_prac_id)
public function integer of_add_spec_link (integer al_facil_id, long al_prac_id)
public function string of_get_reference_val (long al_table)
public function integer of_field_audit_delete_last (u_dw adw, integer ai_row)
public function integer of_dwchild_retrieve (string as_lu_table, string as_type, u_dw adw_dw, string as_from, long al_value, string as_column_nm)
public function integer of_rec_count (integer ai_tid, integer ai_facility)
public function integer of_add_questions (string as_from, datawindow adw_detail, integer ai_facility, long al_prac, long al_app_stat)
public function integer of_validate_year (u_dw a_dw, string as_type, integer ai_row)
public function integer of_set_mod_date (long al_prac)
public function integer of_create_dynamic_ds (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail, integer ai_facility_id, n_tr atr_sqlca)
public function integer of_add_committees (long al_prac_id, integer ai_facility_id, long al_rec_id)
public function integer of_change_to_dddw (ref string as_syntax, string as_colname[])
public function integer of_change_to_editmask (ref string as_syntax, string as_colname[])
public function integer of_dwchild_after_retrieve (u_dw adw_dw)
public subroutine of_dwchild_after_retrieve_2 (u_dw adw_dw)
public function string of_create_dynamic_dw_local (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id)
public function integer of_field_audit_update ()
public function integer of_create_option (integer ai_data_view_id, integer ai_screen_id, string as_detail, string as_calltype, string as_updatedate, boolean ab_screen_painter)
public function integer of_save_create_syntax (integer ai_data_view_id, integer ai_screen_id, datawindow adw_save, string as_detail, string as_currentdate, string as_calltype, boolean ab_screen_painter)
public function integer of_get_create_syntax (integer ai_data_view_id, integer ai_screen_id, ref string as_dwsyntax, string as_detail, string as_calltype, boolean ab_screen_painter)
public subroutine of_create_application_audit_record (string as_rec_status, long al_prac_id[], long al_screen_id, long al_rec_id[], string as_reference)
public function integer of_app_audit_update_ref (long al_prac, long al_de_recid, string as_ref)
public function integer of_app_audit_items_add (long al_facility, long al_prac, long al_affil_rec_id, long al_template, string as_from, datawindow adw_existing, string as_appt_type)
public function integer of_field_audit (datastore ads_data, ref string as_errortext)
public function string of_create_dynamic_dw_4_prof (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, boolean ab_screen_painter, integer ai_facility_id)
public function integer of_app_audit_date_reset (long ai_app_stat_recid, long ai_prac)
public function integer of_detail_preupdate (u_dw adw_detail)
public function integer of_dwchild_retrieve (string as_lu_table, string as_type, datawindowchild adw_dw, string as_from, long al_value, string as_column_nm)
public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, string as_curdw, string as_reportfrom, integer ai_profile_view_id)
public function string of_mod_report_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, datawindowchild adw_detail, boolean ab_screen_painter, integer ai_facility_id, string as_curdw, string as_reportfrom, integer ai_profile_view_id)
public function integer of_field_audit_upd4caqh ()
public function integer of_generate_attest_questions (string as_from, integer ai_facility_id, long al_prac_id, long al_appt_id)
public function integer of_undo_data (datawindow adw_data)
public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add)
public function integer of_lookup_search_dddw (string as_type, u_dw as_dw, string as_column)
public function integer of_field_audit_delete_last (datastore ads_data, long al_row)
public function string of_create_dynamic_dw_pending (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add)
public function string of_create_dynamic_dw_pending_bk (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add, long al_rec_id)
public function integer of_get_id_count (n_ds ads_cache, long ai_facility_ids[])
public function integer of_add_data_links (long al_prac_id, string as_from)
public function integer of_create_checklist (long al_temp, string as_app_type, long al_appt_stat_id, long al_parent, long al_prac_id)
public function string of_change_dddw (datastore ads_data, string as_column, string as_value)
public function string of_change_ddlb (datastore ads_data, string as_column, string as_value)
public function string of_change_checkbox (datastore ads_data, string as_column, string as_value)
public function integer of_field_audit_de_compl (long al_rec, long al_prac, string as_field, datetime ad_old, datetime ad_new, long al_facility)
public function integer of_validate_dea (string as_data, string as_name)
public function integer of_check_required_data (integer ai_dvid, long al_prac, long al_facil)
public function integer of_applfield_audit (datastore ads_data, ref string as_errortext, boolean ab_batch, long al_batch_id)
public function integer of_check_required_documents (integer ai_dataview, long al_prac, long al_facil)
public function integer of_required_data_error (long al_prac, long al_facil, long al_recid, string as_error, n_ds ads_error, integer ai_type, string as_screen, string as_field, integer ai_screenid, string as_from)
public function integer of_get_rec_ids_for_screen (long al_prac, string as_table, ref long al_recids[])
public function integer of_applfield_audit_delete_last (datastore ads_data, long al_row)
public function integer of_field_audit (datawindow adw)
public function integer of_sqlfield_audit (long al_prac_id, long al_rec_id, integer ai_facility_id, integer ai_table_id, string as_field_name, string as_new_value, string as_old_value, string as_audit_type)
public function integer of_sort_evaluate (u_dw adw_data, string as_to_field)
public function integer of_app_audit_item_create (integer al_facility, long al_prac, long al_temp_item_id, long al_affil_recid, long al_de_recid, string as_from, integer ai_complete, string as_ref)
public function integer of_field_audit (datastore ads)
public function string of_create_dynamic_dw_display (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add)
public function integer of_set_exp_appt_inactive (long al_prac, long al_parent)
end prototypes

public function string of_get_first_column ();Return is_first_column
end function

public function integer of_set_defaults (u_dw a_dw, integer ai_row);//called from pfc_add also called from address find (buttonclicked event)

Integer li_fld_cnt
Integer i
datawindowchild ld_child
li_fld_cnt = UpperBound( is_column_names[] )

FOR i = 1 TO li_fld_cnt
	IF Not IsNull(is_column_names[ i ]) AND Not IsNull( is_column_default[i]) THEN
		if a_dw.Describe( is_column_names[ i ] + ".ColType") <> "!" then //Start Code Change ----09.11.2008 #V85 maha -  check to make sure the column exists
			a_dw.SetColumn( is_column_names[ i ] )

			if isnull(a_dw.gettext()) or len(a_dw.gettext()) = 0 then  //Start Code Change ----09.11.2012 #V12 maha - added to prevent null values from overwriting defaults on address find
				a_dw.SetText( is_column_default[ i ] )
			end if
		else
			if gi_test_mode = 1 then
				Messagebox("of_set_defaults", "Error trap.  Field does not exist on screen: " + is_column_names[ i ])
			end if
		end if
	END IF
END FOR

a_dw.AcceptText()

RETURN 0
end function

public function integer of_setup_cache ();//if gi_cache_set = 0 then //maha 092701 - removed 01.09.08
if ib_report = false then
	ids_screen_fields = CREATE n_ds
	ids_screen_fields.DataObject = "d_screen_fields_cache"
	ids_screen_fields.of_SetTransObject( SQLCA )
	
	ids_screen_objects = CREATE n_ds
	ids_screen_objects.DataObject = "d_screen_objects_cache"
	ids_screen_objects.of_SetTransObject( SQLCA )
else
	ids_screen_fields = CREATE n_ds
	ids_screen_fields.DataObject = "d_report_fields_cache"
	ids_screen_fields.of_SetTransObject( SQLCA )
	
	ids_screen_objects = CREATE n_ds
	ids_screen_objects.DataObject = "d_report_objects_cache"
	ids_screen_objects.of_SetTransObject( SQLCA )

	ids_report_objects = CREATE n_ds
	ids_report_objects.DataObject = "d_screen_report_objects_cache"
	ids_report_objects.of_SetTransObject( SQLCA )
end if

return 0

//IF gnv_app.of_get_field_object_cache()  THEN
//	ids_screen_fields.DataObject = "d_screen_fields_all"
//	ids_screen_fields.of_SetTransObject( SQLCA )
//	gnv_app.inv_dwcache.of_GetRegistered("SCREEN_FIELDS", ids_screen_fields)
//
//	ids_screen_objects.DataObject = "d_screen_objects_all"
//	ids_screen_objects.of_SetTransObject( SQLCA )
//	gnv_app.inv_dwcache.of_GetRegistered("SCREEN_OBJECTS", ids_screen_objects)
//END IF
//
//Return 0
//
end function

public function integer of_itemchanged (u_dw a_dw, string as_data);

CHOOSE CASE is_table_name
	CASE "pd_basic"
		IF a_dw.GetColumnName() = "middle_name" AND LenA(as_data) = 1 THEN
			as_data = as_data + "."
			a_dw.SetItem( a_dw.GetRow(), "middle_name", as_data )
			Return 1
		END IF

END CHOOSE


RETURN 0
end function

public function integer of_record_validation (u_dw a_dw);//rebuilt maha 090805

Integer i
Integer li_rc
Integer li_last_row
Integer li_year_from = -1
Integer li_year_thru = -1
Integer li_found
Integer li_cnt
integer res = 1
Long ll_val
Long ll_linkval
String ls_val
DataWindowChild dwchild

//Start Code Change ----06.16.2008 #V81 maha - removed now usingfield validation//if of_get_app_setting("set_1","I") = 2 then return 1 //Start Code Change ----05.21.2008 #V8 maha - option added to turn off validation


a_dw.AcceptText()
li_rc = a_dw.RowCount()
li_last_row = a_dw.GetRow()
//first check if both from and to exist
//Start Code Change ----10.04.2011 #V12 maha - modified to check the date fields first as they are default in the program
if a_dw.Describe("start_date.ColType") <> "!"  and a_dw.Describe("end_date.ColType") <> "!" then
	ls_val = "DATE"
elseif a_dw.Describe("year_from.ColType") <> "!"  and a_dw.Describe("year_thru.ColType") <> "!" then
	ls_val = "YEAR"
//if not, check start and end dates
//if a_dw.Describe("start_date.ColType") <> "!"  and a_dw.Describe("end_date.ColType") <> "!" then
//	ls_val = "DATE"
//if also not skip validation
else
	return 1
end if
	
	
CHOOSE CASE is_table_name
	CASE "pd_training"
		FOR i = 1 TO li_rc
			res = of_validate_year(a_dw,ls_val,i) //maha moved to function 090705
		END FOR					
	CASE "pd_other_affill"
		FOR i = 1 TO li_rc
			res = of_validate_year(a_dw,ls_val,i) 
		END FOR			
	CASE "pd_acedemic_appointments"
		FOR i = 1 TO li_rc		
			res = of_validate_year(a_dw,ls_val,i) 		
		END FOR			
	CASE "pd_hosp_affil"
		//maha 010301 code removed per pix request readded 090705
		FOR i = 1 TO li_rc
			res = of_validate_year(a_dw,ls_val,i) 
		END FOR					
END CHOOSE
		

RETURN res
end function

public function integer of_update_dddw (u_dw a_dw_detail, u_dw a_dw_browse);n_ds lds_lookup_fields
Integer li_col_cnt
Integer i
String ls_table_name
String ls_fld_nm
String ls_lookup_code
DataWindowChild dwchild

ls_table_name = a_dw_detail.Object.DataWindow.Table.UpdateTable

lds_lookup_fields = CREATE n_ds
lds_lookup_fields.DataObject = "d_lookup_fields"
lds_lookup_fields.of_SetTransObject( SQLCA )
li_col_cnt = lds_lookup_fields.Retrieve( ls_table_name )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-23
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
FOR i = 1 TO li_col_cnt
	//ls_fld_nm = Mid( ls_table_name, 5, 100) + "_" + lds_lookup_fields.GetItemString( i, "field_name" )	
	ls_fld_nm = lds_lookup_fields.GetItemString( i, "field_name" )
	ls_lookup_code = lds_lookup_fields.GetItemString( i, "lookup_code" )
	//detail dw
	IF a_dw_detail.GetChild( ls_fld_nm, dwchild ) = 1 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ls_lookup_code )
	END IF
	//browse dw
	IF a_dw_browse.GetChild( ls_fld_nm, dwchild ) = 1 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ls_lookup_code )
	END IF
END FOR
*/
gnv_appeondb.of_startqueue()

FOR i = 1 TO li_col_cnt
	//ls_fld_nm = Mid( ls_table_name, 5, 100) + "_" + lds_lookup_fields.GetItemString( i, "field_name" )	
	ls_fld_nm = lds_lookup_fields.GetItemString( i, "field_name" )
	ls_lookup_code = lds_lookup_fields.GetItemString( i, "lookup_code" )
	//detail dw
	IF a_dw_detail.GetChild( ls_fld_nm, dwchild ) = 1 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ls_lookup_code )
	END IF
END FOR

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
RETURN 1
end function

public function integer of_create_dynamic_dw_browse (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_browse);SetPointer(HourGlass!)

Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
String ls_background = "16120575" //alfee 11.18.2010
Long ll_detail_height
DataWindowChild dwchild
DataWindowChild dwchild_browse

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

of_setup_cache()

IF gnv_app.of_get_field_object_cache()  THEN
	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
								     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter()
	li_row_cnt = ids_screen_fields.RowCount()


	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
									     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter()								
	li_obj_cnt = ids_screen_objects.RowCount()
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-24
	//$<add> 02.15.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------

	ids_screen_fields.DataObject = "d_screen_fields"
	ids_screen_fields.of_SetTransObject( SQLCA )
	li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )

	ids_screen_objects.DataObject = "d_screen_objects"
	ids_screen_objects.of_SetTransObject( SQLCA )
	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-25
	//$<add> 02.15.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue()
	li_row_cnt = ids_screen_fields.Rowcount()
	li_obj_cnt = ids_screen_objects.Rowcount()
	//---------------------------- APPEON END ----------------------------

END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0


//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/15/2007 By: Jervis
//$<reason> Fix a defect
if li_table_cnt = 0 then
	Messagebox("Caution","Failed to create SELECT syntax for datawindow. ")
	return -1
end if
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )


//CREATE SYNTAX FOR BROWSE DW
//ls_grey = String(rgb(192,192,192))
ls_grey = "80269524" //alfee 11.18.2010
ls_white =String(rgb(255 ,255 ,255))  //Start Code Change ----changed to transparent.2016 #V15 maha  "553648127"   //
//ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
//ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_background + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"  //alfee 11.18.2010
ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"  //Start Code Change ----03.23.2015 #V15 maha

//ls_presentation_str+= 'datawindow(units=0 timer_interval=0 color=16777215 brushmode=0 transparency=0 gradient.angle=0 gradient.color=8421504 gradient.focus=0 gradient.repetition.count=0 gradient.repetition.length=100 gradient.repetition.mode=0 gradient.scale=27 gradient.spread=100 gradient.transparency=0 picture.blur=0 picture.clip.bottom=0 picture.clip.left=0 picture.clip.right=0 picture.clip.top=0 picture.mode=0 picture.scale.x=100 picture.scale.y=100 picture.transparency=0 processing=0 HTMLDW=no print.printername="" print.documentname="" print.orientation = 0 print.margin.left = 110 print.margin.right = 110 print.margin.top = 96 print.margin.bottom = 96 print.paper.source = 0 print.paper.size = 0 print.canusedefaultprinter=yes print.prompt=no print.buttons=no print.preview.buttons=no print.cliptext=no print.overrideprintjob=no print.collate=yes print.background=no print.preview.background=no print.preview.outline=yes hidegrayline=no showbackcoloronxp=no picture.file="" ) '
//ls_presentation_str+= 'header(height=88 color="16777215" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="2" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="28" gradient.spread="100" ) '
//ls_presentation_str+= 'summary(height=0 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" ) '
//ls_presentation_str+= 'footer(height=92 color="536870912" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" ) '
//ls_presentation_str+= 'detail(height=92 color="536870912~tif( getrow() = currentrow(), rgb(168, 205, 241), if (mod(getrow(),2) = 0, 16445680,16777215 ))" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" ) '


//messagebox('ls_presentation_str',ls_presentation_str)
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_browse.SetRedraw(False)

adw_browse.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	adw_browse.SetRedraw(True)
	RETURN -1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-04
//$<add> 01.13.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.

If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[]
	long li_appeon_index
	
	ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
	li_appeon_index = 1
	
	FOR i = 1 TO li_row_cnt
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
		
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	END FOR
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	adw_browse.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
		clipboard(ls_dwsyntax_str)
		RETURN -1
	End if
End If
//---------------------------- APPEON END ----------------------------	

adw_browse.of_SetTransObject( SQLCA )
li_prac_row_cnt = adw_browse.Retrieve()


//adw_browse.Object.DataWindow.Detail.Height= 5000
//adw_browse.Modify("active_status.Initial='1'")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<add> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
//	IF ab_screen_painter THEN
//		IF ids_screen_fields.GetItemString(i, "") = "N" THEN
//			adw_browse.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
//			adw_browse.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
//			adw_browse.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
//		ELSE
//			adw_browse.Modify(ls_dw_field_names[i] + ".color = '0'") 
//			adw_browse.Modify(ls_dw_field_names[i] + "_t.color = '0'")
//			adw_browse.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
//		END IF
//	END IF

//	IF ab_screen_painter THEN
//		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
//		adw_browse.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
//	ELSE
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		//adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		
//	END IF
	adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_browse.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
	adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")
	adw_browse.Modify( ls_dw_field_names[i] + "_t.background.mode = '0'") //alfee 11.18.2010
	adw_browse.Modify( ls_dw_field_names[i] + "_t.font.face='Segoe UI'" )  //Start Code Change ----07.13.2017 #V154 maha
	
	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 

	//Uncomment by Appeon long.zhang 07.19.2016 (BugL071401)
	adw_browse.Modify( ls_dw_field_names[i] + ".font.face='Segoe UI'" )   //Start Code Change ----07.13.2017 #V154 maha
	
	adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_browse.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_browse.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF li_fld_width < li_fld_label_width THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
	ELSE
		adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
	END IF

	
//	IF ls_field_x[i] = "0" THEN
//		adw_browse.Modify( ls_dw_field_names[i] + ".x = 750")
//		adw_browse.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )
//
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.x = 100")
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
//	ELSE
//		adw_browse.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
//		adw_browse.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )
//
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
//	END IF
//
	//tag value set to field id //Uncomment by Appeon long.zhang 07.19.2016 (BugL071401)
	adw_browse.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_browse.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment //Uncomment by Appeon long.zhang 07.19.2016 (BugL071401)
	adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_browse.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_browse.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_browse.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
		END IF
		
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-27
		//$<comment> 02.15.2006 By: Cao YongWang
		//$<reason> Performance tuning. 
		//$<modification> Comment out the redundant script, since adw_browse.GetChild( ls_dw_field_names[i] , dwchild )
		//$<modification> provides the same functionality.
		/*
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
		*/
		//---------------------------- APPEON END ----------------------------

		dwchild.SetTransObject( SQLCA )

		is_dddwcolumns[upperbound(is_dddwcolumns) + 1] = ls_dw_field_names[i]

		dwchild.Retrieve(ls_lookup_code)	
		dwchild.InsertRow(1)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-28
		//$<comment> 02.15.2006 By: Cao YongWang
		//$<reason> Performance tuning. 
		//$<modification> Comment out the redundant script, since dwchild.InsertRow(1)
		//$<modification> provides the same functionality.
		/*
		dwchild.ShareData( dwchild_browse )
		*/
		//---------------------------- APPEON END ----------------------------
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_browse.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_browse.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_browse.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_browse.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_browse.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_browse.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_browse.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )		//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")								
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_browse.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_browse.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_browse.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_browse.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
			END IF
		END IF	
	END IF
END FOR
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-30
//$<add> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve_2(adw_browse)
//---------------------------- APPEON END ----------------------------

adw_browse.Modify( "rec_id.visible = '0'")
adw_browse.Modify( "prac_id.visible = '0'")

adw_browse.SetRedraw(True)

//adw_browse.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
//FOR i = 1 TO li_obj_cnt
//	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
//	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
//	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
//	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
//	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
//	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
//	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
//	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
//	CHOOSE CASE ls_obj_type
//		CASE "B"
//			adw_browse.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name )
//		CASE "T"
//			adw_browse.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t" )
//	END CHOOSE
//END FOR
//

//adw_browse.Modify( 'detail(height=92 color="536870912~tif( getrow() = currentrow(), rgb(168, 205, 241), if (mod(getrow(),2) = 0, 16445680,16777215 ))" transparency="0" gradient.color="8421504" gradient.transparency="0" gradient.angle="0" brushmode="0" gradient.repetition.mode="0" gradient.repetition.count="0" gradient.repetition.length="100" gradient.focus="0" gradient.scale="100" gradient.spread="100" ) ')


IF li_prac_row_cnt > 0 THEN 
	adw_browse.SetRow( 1 )
	//adw_browse.SelectRow( 1, True )   //Start Code Change ----01.20.2016 #V15 maha - removed
	adw_browse.SetFocus()
END IF


//Start Code Change ----07.13.2017 #V154 maha - added for font increase
adw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  


RETURN 0

end function

public function integer of_create_dynamic_ds_old (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail);SetPointer(HourGlass!)

//This.of_Setup_Cache()
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
Long ll_detail_height
DataWindowChild dwchild

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]


IF gnv_app.of_get_field_object_cache()  THEN
	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
								     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter()
	li_row_cnt = ids_screen_fields.RowCount()


	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
									     " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter()								
	li_obj_cnt = ids_screen_objects.RowCount()
ELSE
	ids_screen_fields.DataObject = "d_screen_fields"
	ids_screen_fields.of_SetTransObject( SQLCA )
	li_row_cnt = ids_screen_fields.Retrieve( ai_data_view_id, ai_screen_id )

	ids_screen_objects.DataObject = "d_screen_objects"
	ids_screen_objects.of_SetTransObject( SQLCA )
	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )
END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

//adw_detail.SetRedraw(False)

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD GROUP BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
END IF
ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//CREATE SYNTAX FOR DETAIL DW
ls_grey = String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN -1
END IF



adw_detail.of_SetTransObject( SQLCA )
li_prac_row_cnt = adw_detail.Retrieve()

IF li_prac_row_cnt = 0 THEN 
	adw_detail.InsertRow(0)
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	FOR i = 1 TO li_row_cnt
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
		END IF
	END FOR
END IF

adw_detail.Object.DataWindow.Detail.Height= 5000
adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt
	
	//visible
	IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
	ELSE
		adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
		adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
		adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
	END IF


	IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
		lb_first_field = False
		is_first_column = ls_dw_field_names[i]
	END IF
	adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		


	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	


	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve(ls_lookup_code)
		dwchild.InsertRow(1)
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")								
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
			END IF
		END IF	
	END IF
END FOR


FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
END FOR

ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//adw_detail.SetRedraw(True)

adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")")
		CASE "T"
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t)" )
	END CHOOSE
END FOR

IF ls_table_name = "pd_address" THEN
	adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1875' y='300' height='104' width='475' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
END IF


//This.SetRedraw(True)
//Messagebox('', ls_dw_field_names[1])
//adw_detail.SetColumn( ls_dw_field_names[1] )

RETURN 0
end function

public function integer of_refresh_cache ();DateTime ldt_lookup_cache
DateTime ldt_screen_cache
DateTime ldt_screen_obj_cache

if gi_cache_set = 0 then //maha 092701
   //--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-35
	//$<add> 01.17.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------

	Select lookup_cache INTO :ldt_lookup_cache FROM ids;
	Select screen_cache INTO :ldt_screen_cache FROM ids;
	Select screen_obj_cache INTO :ldt_screen_obj_cache FROM ids;
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-36
	//$<add> 01.17.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_commitqueue()
	idt_screen_cache = ldt_screen_cache
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-37
	//$<comment> 01.17.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
	/*
	IF ldt_lookup_cache <> gdt_lookup_cache THEN
		app_filler.ids_address_dddw.Retrieve()
	END IF
	*/
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-38
	//$<add> 01.17.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------
	IF ldt_screen_cache <> gdt_screen_cache THEN
			//MessageBox("", "Screen Cache Refreshed")
		if ib_report=false then
			app_filler.ids_screen_fields_cache.Retrieve()
		else
//			app_filler.ids_report_fields_cache.Retrieve()
		end if
	END IF
	
	
	IF ldt_screen_obj_cache <> gdt_screen_obj_cache THEN
		if ib_report=false then
			app_filler.ids_screen_objects_cache.Retrieve()
		else
//			app_filler.ids_report_objects_cache.Retrieve()
//			app_filler.ids_screen_report_objects_cache.Retrieve()
		end if
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-39
	//$<add> 01.17.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue()
	//---------------------------- APPEON END ----------------------------
End if

Return 1
end function

public function integer of_get_next_seq_no (string as_dw, long al_rec_id);Integer li_row_cnt
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

public function integer of_add_address_link (long al_prac_id, integer ai_facility_id);//called from net dev of_add_multi

Integer li_address_cnt
Integer i
Integer li_nr
Long ll_address_id
n_ds lds_address_link
n_ds lds_all_addresses

lds_address_link = CREATE n_ds
lds_address_link.DataObject = "d_address_link"
long ll_addr_id //maha 02-26-01
integer cnt

lds_address_link.of_SetTransObject( SQLCA )

lds_all_addresses = CREATE n_ds
lds_all_addresses.DataObject = "d_address_link_all_addresses"
lds_all_addresses.of_SetTransObject( SQLCA )
li_address_cnt = lds_all_addresses.Retrieve( al_prac_id )

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	//\/maha 02-26-01 check to see if link already exists 
	ll_addr_id = lds_all_addresses.GetItemNumber( i, "rec_id" )	
	select count(*)
	into :cnt
	from pd_address_link
	where prac_id = :al_prac_id and facility_id = :ai_facility_id and address_id = :ll_addr_id;
	if cnt > 0 then continue
	//\maha
	li_nr = lds_address_link.InsertRow( 0 )	
	lds_address_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	lds_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
	lds_address_link.SetItem( li_nr, "billing", 0 )//maha app100305
	lds_address_link.SetItem( li_nr, "mailing", 0 )//maha app100305
//Start Code Change ---- 01.25.2006 #221 maha
	lds_address_link.SetItem( li_nr, "home_address", 0 )
	lds_address_link.SetItem( li_nr, "primary_office", 0 )
	lds_address_link.SetItem( li_nr, "additional_office", 0 )
	lds_address_link.SetItem( li_nr, "include_in_directory", 0 )
	lds_address_link.SetItem( li_nr, "exp_letters", 0 )
//End Code Change---01.25.2006 			
			
	
END FOR

IF lds_address_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating address link table." )
	DESTROY lds_address_link
	DESTROY lds_all_addresses
	RETURN -1
END IF


DESTROY lds_address_link
DESTROY lds_all_addresses

RETURN 1


end function

public function string of_create_dynamic_profile_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id);SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_italic
String ls_weight
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_label_font_weight[]
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_field_underline[]
String ls_field_label_underline[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.13.2006 By: Luke
//$<reason> Define a variable to be used in subsequent script.
integer set1
//---------------------------- APPEON END ----------------------------
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS

//IF gnv_app.of_get_field_object_cache()  THEN
//	ids_screen_fields.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//								     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_fields.Filter()
//	li_row_cnt = ids_screen_fields.RowCount()
//
//
//	ids_screen_objects.SetFilter( "data_view_id = " + String( ai_data_view_id ) +&
//									     " AND screen_id = " + String( ai_screen_id ) )
//	ids_screen_objects.Filter()								
//	li_obj_cnt = ids_screen_objects.RowCount()
//ELSE

	app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	

	app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
	
//	ids_screen_objects.DataObject = "d_screen_objects"
//	ids_screen_objects.of_SetTransObject( SQLCA )
//	li_obj_cnt = ids_screen_objects.Retrieve( ai_data_view_id, ai_screen_id )

////END IF


ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

adw_detail.SetRedraw(False)


//messagebox("", li_row_cnt )
//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_underline[i] = ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) 
	ls_field_label_underline[i] = ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) 	
	ls_label_font_weight[i] = String( ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) 	 )
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF	
	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	IF ai_screen_id = 61 THEN
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
	END IF	
		
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//CREATE SORT ORDER
ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD GROUP BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
END IF
ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//CREATE SYNTAX FOR DETAIL DW

ls_grey = "80269524"//String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=2 ) Datawindow(Color=16777215 )" + "Text(Background.Color=16777215)"  
//openwithparm( w_sql_msg, ls_sql_syntax )
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-08
//$<add> 01.13.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.

If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[]
	long li_appeon_index
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	
	FOR i = 1 TO li_row_cnt
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	END FOR
	
	//specail code for pd_address
	IF ls_table_name = "pd_address" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
		clipboard(ls_dwsyntax_str)
		RETURN "-1"
	End if
End If
//---------------------------- APPEON END ----------------------------



//CREATE SYNTAX FOR BROWSE DW
ib_create_browse = False
IF ib_create_browse THEN
	//ls_grey = String(rgb(192,192,192))
	ls_white = String(rgb(255,255,255))
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"


	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-09
	//$<add> 01.13.2006 By: Luke
	//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
	//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
	//$<modification> implement the functionality of changing a column's edit style.
	If appeongetclienttype()<> 'PB' Then
		ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
		li_appeon_index = 1
		
		FOR i = 1 TO li_row_cnt
			IF ls_dw_field_names[i] = "active_status" THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		
			IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		END FOR
		
		//specail code for pd_address
		IF ls_table_name = "pd_address" THEN
			set1 = of_get_app_setting("set_1","I")
			
			if set1 = 1 then //maha 072301 create populate button only if using addresses for find
				ls_appeon_colname[li_appeon_index] = 'street'
				li_appeon_index++
			end if
						
			ls_appeon_colname[li_appeon_index] = 'billing_address_id'
			li_appeon_index++
		END IF	
	
		of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
		adw_browse.Create( ls_dwsyntax_str, ERRORS)
		
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution", &
			"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
			clipboard(ls_dwsyntax_str)
			RETURN "-1"
		End If
	End If
	//---------------------------- APPEON END ----------------------------
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	adw_detail.InsertRow(0)
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', False)
		//---------End Modfiied ------------------------------------------------------
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', True)
		//---------End Modfiied ------------------------------------------------------
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	FOR i = 1 TO li_row_cnt		
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
		END IF
	END FOR
END IF

IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
//adw_detail.Object.DataWindow.Detail.Height= 5000
adw_detail.Modify("active_status.Initial='1'")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-40
//$<add> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 		
		END IF
	END IF

	IF ab_screen_painter THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
	ELSE
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )		
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Underline = '" + ls_field_label_underline[i] + "'") 
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Underline = '" + ls_field_underline[i] + "'") 	
	
	IF adw_detail.tag = "Preview" THEN
		adw_detail.Modify( ls_dw_field_names[i] + "_t.Border = '0'")
		adw_detail.Modify( ls_dw_field_names[i] + ".Border = '0'")
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + "_t.Border = '2'")
		adw_detail.Modify( ls_dw_field_names[i] + ".Border = '2'")		
	END IF

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + String(ls_label_font_weight[i]) + "'")	

	//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	


	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = No")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = No")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = No")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
				END IF
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
			END IF
		END IF
		
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
		dwchild.SetTransObject( SQLCA )
		//END IF
	
	
		is_dddwcolumns[upperbound(is_dddwcolumns) + 1] = ls_dw_field_names[i]


		IF ls_lookup_type = "A" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-41
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
//			app_filler.ids_address_dddw.ShareData( dwchild )
//			dwchild.SetFilter( "lookup_name = '" + ls_lookup_code + "'" )
//			dwchild.Filter()	
			dwchild.Retrieve(ls_lookup_code)
			//---------------------------- APPEON END ----------------------------
		ELSE
			dwchild.Retrieve(ls_lookup_code)
		END IF		
		dwchild.InsertRow(1)
		dwchild.ShareData( dwchild_browse )
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )		//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-42
//$<add> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve_2(adw_detail)
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR


//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_weight =  String( ids_screen_objects.GetItemNumber(i, "object_bold")  )
	ls_italic =  String( ids_screen_objects.GetItemNumber(i, "object_italic")  )	
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")")
		CASE "T"
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + "_t)" )
			adw_detail.Modify( ls_obj_name + "_t.alignment='"  + ls_justification + "'" )
			adw_detail.Modify( ls_obj_name + "_t.font.weight='"  + ls_weight + "'" )			
			adw_detail.Modify( ls_obj_name + "_t.font.italic='"  + ls_italic + "'" )						
	END CHOOSE
END FOR

IF ls_table_name = "pd_address" THEN
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	//adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
	set1 = of_get_app_setting("set_1","I")
	
	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	adw_detail.GetChild( "billing_address_id", dwchild )
	IF LenA( ls_retval ) = 0 THEN
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( al_prac_id )
	END IF
	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "N/A" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "Same" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )
//	dwchild.SetItem( 1, "pd_address_rec_id", 0 )
//	dwchild.InsertRow( 1 )
//	dwchild.SetItem( 1, "pd_address_street", "" )	
//	dwchild.SetItem( 1, "pd_address_city", "" )
//	dwchild.SetItem( 1, "code_lookup_code", "" )

	
END IF

//\/maha 062701
IF li_prac_row_cnt = 0 THEN 
	of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ls_detail_band_height)

//adw_detail.Modify("DataWindow.Print.Margin.Bottom='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Top='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Left='1'")
//adw_detail.Modify("DataWindow.Print.Margin.Right='1'")

IF adw_detail.tag = "Preview" THEN
	adw_detail.Modify("DataWindow.Print.Preview=Yes")
	adw_detail.Modify("DataWindow.Print.Preview.Rulers=Yes")
END IF


RETURN ls_return_syntax
end function

public function integer of_get_facil_specific (integer ai_table);//this is for checking if a table is facility specific mmaha 111502

integer li_fs
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-43
//$<modify> 02.13.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
select facility_specific into :li_fs from sys_tables where table_id = :ai_table;
*/
li_fs = integer(gnv_data.of_getitem("sys_tables" , "facility_specific" , "table_id = " + string(ai_table)))
//---------------------------- APPEON END ----------------------------

return li_fs
end function

public function integer of_add_hosp_link (long ai_facility_id, long al_prac_id);//called from net dev of_add_multi  maha 011003

Integer li_hosp_cnt
Integer i
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id
n_ds lds_hosp_link
n_ds lds_all_hosp


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-44
//$<add> 02.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<Modification> Reduce the client-server interactions to improve runtime performance.
//$<Modification> Add the Appeon Start Queue label. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link"
lds_hosp_link.of_SetTransObject( SQLCA )
lds_hosp_link.Retrieve( al_prac_id )

lds_all_hosp = CREATE n_ds
lds_all_hosp.DataObject = "d_hosp_affil_prac"
lds_all_hosp.of_SetTransObject( SQLCA )
li_hosp_cnt = lds_all_hosp.Retrieve( al_prac_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-45
//$<add> 02.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<Modification> Reduce the client-server interactions to improve runtime performance.
//$<Modification> Add the Appeon Commit Queue label. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
	//debugbreak()
	li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = lds_hosp_link.InsertRow( 0 )	
	lds_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	lds_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
END FOR

IF lds_hosp_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating Hospital link table." )
	DESTROY lds_hosp_link
	DESTROY lds_all_hosp
	RETURN -1
END IF


DESTROY lds_hosp_link
DESTROY lds_all_hosp

RETURN 1


end function

public function integer of_add_spec_link (integer al_facil_id, long al_prac_id);//called from net dev of_add_multi maha 011003

Integer li_spec_cnt
Integer i
Integer li_nr
Integer li_found
Long ll_spec_id
long ll_rec
n_ds lds_spec_link
n_ds lds_all_spec

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-46
//$<add> 02.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<Modification> Reduce the client-server interactions to improve runtime performance.
//$<Modification> Add the Appeon Start Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link"
lds_spec_link.of_SetTransObject( SQLCA )
lds_spec_link.Retrieve( al_prac_id )

lds_all_spec = CREATE n_ds
lds_all_spec.DataObject = "d_spec_of_prac"
lds_all_spec.of_SetTransObject( SQLCA )
li_spec_cnt = lds_all_spec.Retrieve( al_prac_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-47
//$<add> 02.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<Modification> Reduce the client-server interactions to improve runtime performance.
//$<Modification> Add the Appeon Commit Queue Labels. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = lds_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = lds_spec_link.Find( "facility_id = " + String( al_facil_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = lds_spec_link.InsertRow( 0 )	
	lds_spec_link.SetItem( li_nr, "prac_id", al_prac_id )
	lds_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	lds_spec_link.SetItem( li_nr, "facility_id", al_facil_id )
	lds_spec_link.SetItem( li_nr, "practicing", 582 )
next

IF lds_spec_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating specialty link table." )
	DESTROY lds_spec_link
	DESTROY lds_all_spec
	RETURN -1
END IF


DESTROY lds_spec_link
DESTROY lds_all_spec

RETURN 1


end function

public function string of_get_reference_val (long al_table);string ls_new_value
string ls_value1
string ls_value2
string ls_fld_nm1
string ls_fld_nm2
string ls_fld_type
string ls_fld_type1
string ls_lookup_type
datawindow adw
long ll_field_id1
long ll_field_id2
long ll_new_value
integer i
				
				
				
				
				//get reference field 1
				select reference_field_1 into :ll_field_id1 from data_view_screen where table_id = :al_table and data_view_id = 1;
				if isnull(ll_field_id1) or ll_field_id1 < 1 then ll_field_id1 = 0//lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :al_table and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = 0//lds_audit_fields.GetItemNumber( 2, "field_id" )

				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-48
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<Modification> Write script to retrieve data from a cache instead of from the database.

				/*
				//get reference field name 1
				select field_name into :ls_fld_nm1 from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm1) or ls_fld_nm1 = "" then ls_fld_nm1 = "" //lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = "" //lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;
				*/

				//get reference field name 1
				//select field_name into :ls_fld_nm1 from sys_fields where field_id = :ll_field_id1;
				ls_fld_nm1 = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + String(ll_field_id1))
				if isnull(ls_fld_nm1) or ls_fld_nm1 = "" then ls_fld_nm1 = "" //lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				//select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				ls_fld_nm2 = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + String(ll_field_id2))
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = "" //lds_audit_fields.GetItemString( 2, "field_name" )
				
				//ref 1 data
				//datatype and lookup field
				//select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				//select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;
				ls_fld_type = gnv_data.of_getitem("sys_fields", "field_type", "field_id = " + String(ll_field_id1))
				ls_lookup_type = gnv_data.of_getitem("sys_fields", "lookup_type", "field_id = " + String(ll_field_id1))
				//---------------------------- APPEON END ----------------------------

				//ls_fld_type = Upper( adw.Describe( ls_fld_nm1 + ".ColType" ) )
//				IF Pos( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF Pos( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF Pos( ls_fld_type, "LONG" ) > 0 OR Pos( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//					//CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type1 + " for field " + ls_fld_nm1 )
//					Return ""
//				END IF
				//data value
				if ls_fld_nm1 = "" then
					ls_value1 = ""
				else
					choose case ls_fld_type
						case "C","V"
							ls_value1 = adw.GetItemString( i, ls_fld_nm1 )
						case "N", "I"
							ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm1 ))
						case "D"
							ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm1 ))
						case else
							ls_value1 = ""
					end choose
				end if
					
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-49
					//$<modify> 02.27.2006 By: LeiWei
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
					ls_value1 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
					//---------------------------- APPEON END ----------------------------	
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;

//				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
//				IF Pos( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF Pos( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF Pos( ls_fld_type, "LONG" ) > 0 OR Pos( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
////					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm1 )
//					Return ""
//				END IF
				if ls_fld_nm2 = "" then
					ls_value2 = ""
				else
					choose case ls_fld_type
						case "C","V"
							ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
						case "N", "I"
							ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
						case "D"
							ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
						case else
							ls_value2 = ""
					end choose
				end if
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-50
					//$<modify> 02.27.2006 By: LeiWei
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					//select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
					ls_value2 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
					//---------------------------- APPEON END ----------------------------	
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
//				MessageBox("ls_value1",ls_value1)
//				MessageBox("ls_value2",ls_value2)

		
				ls_new_value = ls_value1 + "-" + ls_value2
				
				
	return ls_new_value
end function

public function integer of_field_audit_delete_last (u_dw adw, integer ai_row);//maha created for sys audit when deleting 083104  called from of_delete_record (pfc_cst_u_data_entry) as well as other dws
Integer i
Integer c
Integer li_rc
Integer li_lu_rc
Long ll_seq_rc
Long ll_seq_no
Integer li_nr
Integer li_col_cnt
Integer li_table_id
integer li_fs //maha 111502
integer li_set85
Long ll_rec_id
Long ll_field_id
Long ll_field_id2
Long ll_field_id1
Long ll_old_value
Long ll_new_value
long ll_facility_id //maha111802
long ll_prac
String ls_lookup_type
String ls_is_lookup
String ls_lookup_field_name
String ls_retval
String ls_old_value
String ls_new_value
String ls_value1
String ls_value2
String ls_table_name
String ls_fld_nm
String ls_fld_nm2
String ls_fld_type
n_ds lds_lookup_code
n_ds lds_lookup_address
n_ds lds_sys_audit
n_ds lds_last_seq_no

if ai_Row <= 0 then Return 1 //Add by Evan 01/09/2008
ls_table_name = adw.Object.DataWindow.Table.UpdateTable
//MessageBox("of audit trail", ls_table_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.06.2015
//<$>reason: (Bug 4379 created for Case# 00051492: Audit Trail Issue)
If ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items' or  ls_table_name = 'pd_appl_tracking' Then
	//---------Begin Modified by (Appeon)Stephen 06.02.2016 for V15.2-Application Tracking full Auditing--------
	li_set85 = of_get_app_setting("set_85","I")
	if ls_table_name = 'net_dev_action_items' or li_set85 = 2 then
		datastore lds_data
		lds_data = create datastore
		lds_data.dataobject = adw.dataobject
		lds_data.settransobject(sqlca)
		adw.rowscopy(1, adw.rowcount(), primary!, lds_data,1,primary!)
		of_applfield_audit_delete_last(lds_data, ai_row)
		destroy lds_data
		return 1
	elseif li_set85 = 1 and (ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items') then
		//go on
	else
		return 1
	end if 
	/*
	If of_get_app_setting("set_85","I") = 1 Then
		//go on		
	Else
		Return 1
	End if	
	*/
	//---------End Added ------------------------------------------------------
	
End If
//------------------- APPEON END -------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-51
//$<modify> 04.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
 
/*
n_ds lds_audit_fields

lds_sys_audit = CREATE n_ds
lds_sys_audit.DataObject = "d_view_audit"
lds_sys_audit.of_SetTransObject( SQLCA )

lds_last_seq_no = CREATE n_ds
lds_last_seq_no.DataObject = "d_get_last_field_audit_seq_no"
lds_last_seq_no.of_SetTransObject( SQLCA )

lds_lookup_code = CREATE n_ds
lds_lookup_code.DataObject = "d_lookup_code_search"
lds_lookup_code.of_SetTransObject( SQLCA )

lds_lookup_address = CREATE n_ds
lds_lookup_address.DataObject = "d_lookup_address_search"
lds_lookup_address.of_SetTransObject( SQLCA )

lds_audit_fields = CREATE n_ds
lds_audit_fields.DataObject = "d_audit_fields"
lds_audit_fields.of_SetTransObject( SQLCA )
li_col_cnt = lds_audit_fields.Retrieve( ls_table_name )
*/
datastore lds_audit_fields

IF NOT IsValid(ids_sys_audit) THEN
	ids_sys_audit = CREATE n_ds
	ids_sys_audit.DataObject = "d_view_audit"
	ids_sys_audit.SetTransObject( SQLCA )
END IF
lds_sys_audit = ids_sys_audit

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("sys_fields", FALSE)
//------------------------------------------------------------------------------------------------------
lds_audit_fields = gnv_data.ids_sys_fields
lds_audit_fields.SetFilter( "sys_tables_table_name = '" + ls_table_name + "' AND sys_fields_audit_fld = 'Y'" )
lds_audit_fields.Filter()
li_col_cnt =  lds_audit_fields.Rowcount( )

//---------------------------- APPEON END ----------------------------


//messagebox("audit fields",li_col_cnt)
IF li_col_cnt < 1 THEN
//	messagebox("audit fields",li_col_cnt)
	Return -1
END IF

li_rc = adw.RowCount()
//messagebox("adw count",li_rc)
li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
li_fs = of_get_facil_specific(li_table_id)


i = ai_row


///************************DELETE	
 		
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		//ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
		if li_table_id = 95 then //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
			if adw.Describe("prac_id.ColType") <> "!" then
				ll_prac = adw.GetItemNumber(i, "prac_id")
			else
				ll_prac = adw.GetItemNumber(i, "pd_images_prac_id")
			end if
			ll_rec_id = adw.GetItemNumber(i, "image_pk")
			ls_old_value = string(ll_rec_id) + "-" + string(ll_prac)
		else
			ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 
			ll_prac = adw.GetItemNumber( i, "prac_id" )
		end if
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
		ll_field_id = lds_audit_fields.GetItemNumber( 1, "field_id" )


		choose case ls_table_name
			case "pd_affil_stat"
				ll_new_value = adw.GetItemnumber( i, "parent_facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-52
				//$<modify> 02.27.2006 By: LeiWei
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_value2 = adw.GetItemstring( i, "apptmnt_type" )
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_dept"
				ll_new_value = adw.GetItemnumber( i, "department" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-53
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				ls_value2=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-54
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_cat"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-55
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = adw.GetItemnumber( i, "staff_category" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-56
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_leave"
				ll_new_value = adw.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-57
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = long(adw.GetItemstring( i, "leave_of_absence_reason" ))
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-58
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case 'net_dev_ids','net_dev_action_items', 'pd_images' //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
				ls_old_value = string(ll_rec_id) + "-" + string(ll_prac)
			case else //data entry screens
								//ls_new_value = of_get_reference_val(li_table_id)
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-59
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				/*
				//get reference field 1
				select reference_field_1 into :ll_field_id1  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then 
					if lds_audit_fields.rowcount() > 1 then //trap added maha 060305
						ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
					end if
				end if				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;
				*/
	
				//get reference field 1
				ll_field_id1 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_1", "data_view_id = 1 and table_id = " + String(li_table_id)))
				//get reference field 2
				ll_field_id2 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_2", "data_view_id = 1 and table_id = " + String(li_table_id)))
				
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				if isnull(ll_field_id2) or ll_field_id2 < 1 then 
					If lds_audit_fields.Rowcount() > 1 Then  //Added trap By Ken.Guo 06.25.2008
						ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
					End If
				End If

				//get reference field name 1
				ls_fld_nm = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(ll_field_id1))
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				ls_fld_nm2 = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(ll_field_id2))
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then 
					if lds_audit_fields.rowcount() > 1 then //trap added maha 060305
						ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
					end if
				end if				//ref 1 data
				//datatype and lookup field
				ls_fld_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(ll_field_id1))
				ls_lookup_type = gnv_data.of_getitem( "sys_fields","lookup_type", "field_id = "+String(ll_field_id1))
				//---------------------------- APPEON END ----------------------------
				
				ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					//return -1   //Commented by (Appeon)Harry 05.13.2015 
					ls_fld_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				//data value
				choose case ls_fld_type
					case "C","V"
						ls_value1 = adw.GetItemString( i, ls_fld_nm )
					case "N", "I"
						ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm ))
					case "D"
						ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm ))
					case else
						ls_value1 = ""
				end choose
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-60
					//$<modify> 03.23.2006 By: LeiWei
					//$<reason> Performance tuning
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
					ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
					//---------------------------- APPEON END ----------------------------
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-61
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				/*
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;
				*/
				ls_fld_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(ll_field_id2))
				ls_lookup_type = gnv_data.of_getitem( "sys_fields","lookup_type", "field_id = "+String(ll_field_id2))
				//---------------------------- APPEON END ----------------------------

				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
					//return -1   //Commented by (Appeon)Harry 05.13.2015 
					ls_fld_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				ELSE				
					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				
				choose case ls_fld_type
					case "C","V"
						ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
					case "N", "I"
						ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
					case "D"
						ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
					case else
						ls_value2 = ""
				end choose		
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-62
					//$<modify> 03.23.2006 By: LeiWei
					//$<reason> Performance tuning
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					/*
					select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
					*/
					ls_value2 = gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
					//---------------------------- APPEON END ----------------------------
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)
				ls_old_value = ls_new_value
		end choose
		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-63
		//$<comment> 02.27.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> The following script moved to the of_field_audit_update function
		//$<modification> to reduce client-server interactions.
		/*
		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
		IF ll_seq_rc > 0 THEN
			ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
		END IF
		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			ll_seq_no = 1
		ELSE
			ll_seq_no++
		END IF
		*/
		//---------------------------- APPEON END ----------------------------

		if IsNull(ll_rec_id) then return -1 //e.g. delete a new row-  alfee 11.18.2010
		
		li_nr = lds_sys_audit.InsertRow( 0 )
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
		lds_sys_audit.SetItem( li_nr, "prac_id", ll_prac )					
		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
		lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
		lds_sys_audit.SetItem( li_nr, "old_value", ls_old_value )
		lds_sys_audit.SetItem( li_nr, "new_value", "Deleted" )
		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
		lds_sys_audit.SetItem( li_nr, "audit_type", "D" )					
		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )

// adw.RowsDiscard (1, 100,delete! )

//if lds_sys_audit.rowcount() > 1 then maha 102003 trap not completed for multiple staff cat records
//	for i = 1 to ds_sys_audit.rowcount()
//		lds_sys_audit.getItemnumber( i ,"rec_id" )
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-64
//$<comment> 02.27.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script moved to the of_field_audit_update function
//$<modification> to reduce client-server interactions.
/*
IF lds_sys_audit.Update() = -1 THEN
	MessageBox("", "Update to sys_audit table Failed!")
	Return -1
END IF

//Start Code Change ---- 11.03.2005 #18 maha
of_set_mod_date(ll_prac)
//End Code Change---11.03.2005 

COMMIT USING SQLCA;
*/

THIS.POST of_field_audit_update()

//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_dwchild_retrieve (string as_lu_table, string as_type, u_dw adw_dw, string as_from, long al_value, string as_column_nm);//created maha 060805 to add search item in each lookup.  Called from of_create_dynamic_dw and the date entry user object of_lookup_function
//debugbreak()
//Start Code Change ---- 12.15.2005 #171 maha
//works for all dropdowns except insurance carrier??????
long ll_val
datawindowchild dwchild
long ll_find
long ert
//debugbreak()
adw_dw.GetChild( as_column_nm, dwchild )
adw_dw.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-65
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
/*
if as_from = "RET" and as_type = "A" then //when treturning from search refresh cache for address lookups
	ert = app_filler.ids_address_dddw.Retrieve()
	//messagebox("",ert)
end if
*/
//---------------------------- APPEON END ----------------------------

IF as_type = "C" THEN
	choose case as_lu_table
		case "Address Type", "Yes/No","Specialty Order"
			//exceptions
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-66
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
			/*
			dwchild.retrieve(as_lu_table)
			*/
			gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(as_lu_table)+"'",dwchild)
			//---------------------------- APPEON END ----------------------------
		case else
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-67
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> After Appeon's modification, the ids_address_dddw cache cache is no longer used in IntelliCred.
			/*
			dwchild.retrieve(as_lu_table)
			*/
			gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(as_lu_table)+"'",dwchild)
			//---------------------------- APPEON END ----------------------------
			dwchild.InsertRow(1)
			dwchild.setitem(1,"code",'-SEARCH/Add-')
			dwchild.setitem(1,"lookup_code",-777)
			dwchild.setitem(1,"description","-Search/Add for " + as_lu_table +" -")
	end choose
ELSEIF as_type = "A" THEN
	//debugbreak()
	if dwchild.Describe("entity_name_original.ColType") <> "!" then
		//messagebox("1",string(dwchild.rowcount()))
		//--------------------------- APPEON BEGIN ---------------------------
		////$<ID> PT-68
		//$<modify> 01.17.2006 By: Cao YongWang
		//$<reason> After Appeon's modification, the ids_address_dddw cache cache is no longer used in IntelliCred.
		//app_filler.ids_address_dddw.ShareData( dwchild )
		//dwchild.SetFilter( "lookup_name = '" + as_lu_table + "'" )
		//dwchild.Filter()
		dwchild.retrieve(as_lu_table)
		//---------------------------- APPEON END ----------------------------
		
		dwchild.InsertRow(1)
		//messagebox("2",string(dwchild.rowcount()))
		dwchild.setitem(1,"code",'-SEARCH/ADD-')
		dwchild.setitem(1,"lookup_code",-888)
		dwchild.setitem(1,"entity_name_original","-Search/Add for " + as_lu_table +" -")
		dwchild.setitem(1,"entity_name","-Search/Add for " + as_lu_table +" -")		//Added by Scofield on 2007-08-31
	end if
elseif as_type = "Q" THEN
		dwchild.Retrieve()
end if
dwchild.InsertRow(1) //blank row

//End Code Change---12.15.2005 

if as_from = "RET" then
	ll_val = al_value
	adw_dw.SetItem( adw_dw.GetRow(), as_column_nm, ll_val )
	adw_dw.accepttext()
	ll_find = dwchild.find("lookup_code = " + string(ll_val),1,dwchild.rowcount())
	if ll_find > 0 then
		dwchild.scrolltorow(ll_find)
	end if
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-69
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Specify values to arrays.

is_types[upperbound(is_types) + 1] 					= as_type
is_froms[upperbound(is_froms) + 1] 					= as_from
is_dddwcolumns[upperbound(is_dddwcolumns) + 1] 	= as_column_nm
is_lu_tables[upperbound(is_lu_tables) + 1] 		= as_lu_table
il_values[upperbound(il_values) + 1] 				= al_value
//---------------------------- APPEON END ----------------------------

return 1
end function

public function integer of_rec_count (integer ai_tid, integer ai_facility);//this function called from of_screen_color() (pfc_cst_u_data_entry) used to set screen complete icon //,maha 061705 
//maha app081805 added ai_facility argument

integer cnt = 0
integer w
string tname
string is_sql
string ls_presentation_str
string ls_dwsyntax_str
string errors
n_ds lds_prac_list
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-70
//$<modify> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select table_name into :tname from sys_tables where table_id = :ai_tid;
*/
tname = gnv_data.of_getitem("sys_tables","table_name","table_id = " + string(ai_tid))
//---------------------------- APPEON END ----------------------------

//maha 122305
if PosA(tname,"dba",1 ) > 0 then
	tname = MidA(tname,5,100)
end if
//$<ID> PT-

	is_sql = "select count(rec_id) cnt from " + tname + " where prac_id = " + string(gl_prac_id) 
	if ai_facility > 0 then //maha app081805
		is_sql = is_sql + " and facility_id = " + string(ai_facility) + ";"
	else
		is_sql = is_sql + ";"
	end if

//messagebox("is_sql",is_sql)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-71
//$<modify> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<reason> Use cursor to retrieve the data instead of using DataWindow to retrieve data.
/*

		ls_presentation_str = "style(type=grid)"		
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(is_sql, ls_presentation_str, ERRORS)
		IF Len(ERRORS) > 0 THEN
			MessageBox("Caution on export field " + is_sql, &
			"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + is_sql)
		//	MessageBox("ls_select_table",ls_select_table)	
			RETURN -0
		END IF
		lds_prac_list = CREATE n_ds
		w = lds_prac_list.Create( ls_dwsyntax_str, ERRORS)
		if w < 1 then messagebox("error on create",errors)
		lds_prac_list.settransobject(sqlca)
		lds_prac_list.retrieve()
		if lds_prac_list.rowcount() > 0 then
			cnt = lds_prac_list.getitemnumber(1,1)
		else
			//messagebox("error on create","no data")
		end if

*/
DECLARE rec_cursor DYNAMIC CURSOR FOR SQLSA ;

PREPARE SQLSA FROM :is_sql ;

OPEN DYNAMIC rec_cursor;

FETCH rec_cursor INTO :cnt ;

CLOSE rec_cursor ;
//---------------------------- APPEON END ----------------------------

return cnt
end function

public function integer of_add_questions (string as_from, datawindow adw_detail, integer ai_facility, long al_prac, long al_app_stat);//function created maha app081705 for adding attest questions in a batch.  Called from dw_detail pfc_addrow also from appointment attestation tab



integer i
integer r
integer c
integer cr
integer ck = 0
long ls_exist_id
long ls_new_id
gs_variable_array ls_array
long il_id[]
integer cnt
string ls_no //maha 061709
integer ll_no_answer[]  //maha 061709

cr = adw_detail.rowcount()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09/18/2007 By: Ken.Guo
//$<reason> For Performance
long ll_ques_id[],ll_prac_id[],ll_appt_stat_id[]
Integer li_facility_id[],li_active_status[]
Integer j
//---------------------------- APPEON END ----------------------------

open (w_question_select)
if message.stringparm = "Cancel" then
	return 0
else
	ls_array = message.powerobjectparm
	// mskinner 17 dec 2005 -- begin
	// fix appeon defect 1.2
	if not isvalid(ls_array) then return -1
	// mskinner 17 dec 2005 -- end 
	il_id = ls_array.as_number
	ls_no = ls_array.as_string[1] //Start Code Change ----06.17.2009 #V92 maha

	for i = 1 to upperbound(il_id)
		ls_new_id = il_id[i]
		ck = 0
		for c = 1 to cr  //check existing records to avoid duplicates
			ls_exist_id = adw_detail.getitemnumber(c,"question_id")
			if ls_new_id = ls_exist_id then ck = 1
		next
		if ck = 1 then  //if exists skip
			continue
		else
 //Start Code Change ----08.17.2015 #V15 maha - cleaned up an replaced old code (see v14.2 code base for org)
			r = adw_detail.insertrow(0)
			
			If as_from <> "PQ" Then //practice questions
				adw_detail.setitem(r,"facility_id",ai_facility)
				adw_detail.setitem(r,"active_status",1)
				adw_detail.setitem(r,"appt_stat_id",al_app_stat)
			end if
			adw_detail.setitem(r,"prac_id",al_prac)
			adw_detail.setitem(r,"question_id",ls_new_id)
			if ls_no = "NO" then
				adw_detail.setitem(r,"answer_code",-103)
			end if
			adw_detail.setitemstatus(r,0, primary!, newmodified!)  
		end if	
		
	next
				
	return 1
 //End Code Change ----08.17.2015 	
	

end if


end function

public function integer of_validate_year (u_dw a_dw, string as_type, integer ai_row);//created maha 090705 called from of_record_validation

integer li_year_from = -1
integer li_year_thru = -1
integer i
datetime ldt_from
datetime ldt_to

i = ai_row

//debugbreak()
if as_type = "YEAR" then
	li_year_from = a_dw.GetItemNumber( i, "year_from" )
	li_year_thru = a_dw.GetItemNumber( i, "year_thru" )
elseif as_type = "DATE" then
	if isnull(a_dw.GetItemdatetime( i, "start_date" )) then
		setnull(li_year_from)
	else
		li_year_from = 1
	end if
	if isnull(a_dw.GetItemdatetime( i, "end_date" )) then
		setnull(li_year_thru)
	else
		li_year_thru = 1
	end if
end if


if  li_year_from = -1 AND li_year_thru = -1 then //trapped in of_record_validation
	//fields not visible do nothing
	return 1
elseif IsNull( li_year_from ) AND IsNull( li_year_thru ) THEN
	a_dw.SetRow( i )
	a_dw.ScrollToRow( i )
	if as_type = "YEAR" then
		a_dw.SetColumn( "year_from" )
		MessageBox("Incomplete Data", "Both the year from and year thru fields are blank. At least one must be completed.  Please Correct!" )
		return -1
	elseif as_type = "DATE" then
		a_dw.SetColumn( "start_date" )
		MessageBox("Incomplete Data", "Both the Start Date and End Date fields are blank. At least one must be completed.  Please Correct!" )
		Return -1
	end if

END if
//debugbreak()
//Start Code Change ----06.16.2008 #V81 maha - check for start before end date
if as_type = "DATE" then
	if a_dw.GetItemdatetime( i, "start_date" ) > a_dw.GetItemdatetime( i, "end_date" ) then
		MessageBox("Invalid Data", "The Start Date cannot be greater then the End Date.  Please Check your data." )
		Return -1
	end if
end if
//End Code Change---06.16.2008

return 1
end function

public function integer of_set_mod_date (long al_prac);//Start Code Change ---- 11.03.2005 #17 maha created
//debugbreak()
datetime ldt_date
ldt_date = datetime(today(),now())
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-72
//$<modify> 02.21.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
update pd_basic set date_last_mod = :ldt_date where prac_id = :al_prac;
commit using sqlca;
*/
gnv_appeondb.of_startqueue( )
 
update pd_basic set date_last_mod = :ldt_date where prac_id = :al_prac;
commit using sqlca;

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

return 1
//End Code Change---11.03.2005 
end function

public function integer of_create_dynamic_ds (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, n_ds adw_detail, integer ai_facility_id, n_tr atr_sqlca);SetPointer(HourGlass!)

//This.of_Setup_Cache()
Integer li_retval
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer ll_ret
integer s	  //maha - 11.10.2016
integer rc //maha - 11.10.2016
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
string ls_sqlsyn
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string ls_sort_fields //maha 032204
string ls_sort_field[]   //maha 11.10.2016
string ls_sort_dir[]   //maha 11.10.2016
string ls_sort_add_field[]   //maha 11.10.2016
string ls_sort_lu_field[]   //maha 11.10.2016
string ls_sort_lu_type[]   //maha 11.10.2016
string ls_sort_name  //maha 11.10.2016
string ls_null_array[]  //maha 11.10.2016
string ls_dir //maha 032204
Long ll_detail_height
string ls_table_prefix //Start Code Change ---- 06.20.2006 #564 maha
string ls_ret
DataWindowChild dwchild
integer li_master
//Start Code Change ---- 11.21.2005 #101 maha 
integer cnt
string recIdSortTableName    //(Appeon)Gavin 10.26.2017 - V15 ISG-CLX FW: Application Mapping

is_sort_lookup_fields = ls_null_array  //Start Code Change ----11.10.2016 #V153 maha

if isnull(ai_screen_id) then return -1	//06.28.2007 By Jervis
if ai_screen_id < 0 then return -1 //12.12.2008 By Jervis WorkFlow = -10

//Start Code Change ---- 12.13.05 #167 maha
if gs_dbtype = "ASA" then
	select count(*) into :cnt from pbcatedt; //maha 011806
		//messagebox("count from pbcat",cnt)
	if cnt < 1 then 
		li_master = 0
	else
		li_master = 1
	end if
else
	li_master = 0
end if
//messagebox("li_master",li_master)
//End Code Change---12.13.2005 

//Start Code Change ---- 06.20.2006 #564 maha
choose case ai_screen_id
	case 2
		ls_table_prefix = "pd_address_"
		lb_multi_tablE = True   //Added by ken at 2007-06-26
	case 31 
		ls_table_prefix = "pd_address_2_"
		lb_multi_tablE = True	//Added by ken at 2007-06-26
	case 10
		ls_table_prefix = "pd_hosp_affil_"
		lb_multi_tablE = True	//Added by ken at 2007-06-26	
	case else
		ls_table_prefix = ""
end choose 
//End Code Change---06.20.2006

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

of_setup_cache()



app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	
//-------End Modified ---------------------------------------------

//Start Code Change ----11.10.2016 #V153 maha - get info for later sorting
ids_screen_fields.SetSort( "sort_field A" )
ids_screen_fields.Sort()


for i = 1 to li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		ls_sort_name =  ids_screen_fields.GetItemString( i, "db_field_name" )
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN //set direction
			ls_dir = " D,"
		else
			ls_dir = " A,"
		end if
		if  ids_screen_fields.GetItemString( i, "lookup_field" ) = "Y" then
			ls_sort_name = "sort4_" + ls_sort_name 
			ls_sort_add_field[ upperbound(ls_sort_add_field) + 1 ] = ls_sort_name   //add to array for fields to be added
			ls_sort_lu_type[upperbound(ls_sort_lu_type) + 1 ] = ids_screen_fields.GetItemString( i, "lookup_type" )
			ls_sort_lu_field[upperbound(ls_sort_lu_field) + 1 ] = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		end if
		
		ls_sort_field[upperbound(ls_sort_field) + 1] = ls_sort_name
		ls_sort_dir[upperbound(ls_sort_dir) + 1] = ls_dir
	End if
next
//Start Code Change ----11.10.2016 


ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

recIdSortTableName = ""
//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	//IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
	//	CONTINUE
	//END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	is_table_name = ls_table_name
	if PosA(ls_table_name,"dba.", 1) = 1 then ls_table_name = MidA(ls_table_name,5) //maha 032006
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	//if li_master = 1 then //maha 121305
		ls_table_field_names[i] =  ls_table_name + "_" + ls_field_name
//	else
	//	ls_table_field_names[i] = Mid( ls_table_name,5,100 ) + "_" + ls_field_name
	//end if
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
	If  Len(recIdSortTableName ) = 0 And lower(ls_field_name ) = 'rec_id' Then recIdSortTableName = ls_table_name   //(Appeon)Gavin 10.26.2017 - V15 ISG-CLX FW: Application Mapping
		
END FOR //FOR i = 1 TO li_row_cnt

//Start Code Change ----11.10.2016 #V153 maha
if  upperbound(ls_sort_add_field) > 0 then  //adds the sort4 fields
	for s = 1 to  upperbound(ls_sort_add_field)
		ls_sql_syntax = ls_sql_syntax + ls_sort_add_field[s] + " = '', "
		//ls_field_names[upperbound(ls_field_names) + 1] = ls_sort_add_field[s]
	next
end if
//Start Code Change ----11.10.2016

if li_table_cnt < 1 then Return -1 //Added by Evan 02.17.2012

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

IF ai_screen_id = 2 THEN
	ls_sql_syntax = ls_sql_syntax + ",                                                pd_address_link.home_address,                                                pd_address_link.primary_office,                                                pd_address_link.additional_office, " +&
	"                                               pd_address_link.billing,                                                pd_address_link.mailing,                                                pd_address_link.exp_letters,                                                pd_address.rec_id"
ELSEIF ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + ",                                                pd_address_link.home_address,                                                pd_address_link.primary_office,                                                pd_address_link.additional_office, " +&
	"                                               pd_address_link.billing,                                                pd_address_link.mailing,                                                pd_address_link.exp_letters,                                                pd_address_2.rec_id"
END IF
//\/maha 100702 for primary hosp link
IF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + ",                                                pd_hosp_facility_link.primary_hosp,                                                pd_hosp_facility_link.hosp_affil_id"
END IF
//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
	li_key_cnt ++
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "prac_id"
	END IF

	li_key_cnt ++
	ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
	ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
	IF li_table_cnt > 1 THEN
		ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	ELSE
		ls_key_fields_col_nm[li_key_cnt] = "rec_id"
		is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
	END IF		
END FOR

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)


//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		//if len(ls_table_field_names[i]) < 1 then MessageBox( "","")
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
//	lb_multi_table = False  //Commented by ken at 2007-06-26
	FOR i = 1 TO li_row_cnt
		IF ai_screen_id = 2 OR ai_screen_id = 31  or ai_screen_id = 10 THEN
			ls_dw_field_names[i] = ls_table_field_names[i]			
			if li_master = 1 then //IF Upper( gs_user_id ) <> 'MASTER' THEN
				ls_dw_field_names[i] = ls_field_names[i]							
			END IF
		ELSE
			ls_dw_field_names[i] = ls_field_names[i]
		END IF
	END FOR
END IF

//Start Code Change ----11.17.2009 #V92 maha - check for facility_id in query for dept and staff cat
if ai_screen_id = 32 or ai_screen_id = 45 then
	if PosA(ls_sql_syntax ,"facility_id",1) = 0 then
		ls_sql_syntax = ls_sql_syntax + ", " + ls_table_names[1] + ".facility_id"
	end if
end if
//End Code Change---11.17.2009

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

IF ai_screen_id = 2 OR ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + ",                                                pd_address_link"
END IF

IF ai_screen_id = 10 then
	ls_sql_syntax = ls_sql_syntax + ",                                                pd_hosp_facility_link"
END IF

//ADD WHERE CLAUSE
if ai_screen_id = 86 then	//added by long.zhang 07.03.2012 v12.2 group location mini-painter
	ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".rec_id  = " + String( al_prac_id )
else
	ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )
end if


IF ids_screen_fields.GetItemNumber(1, "facility_specific" ) = 1  and ai_screen_id <> 43 THEN //exception added for affil stat maha050403
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
ELSEIF ai_screen_id = 2  OR ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_address_link.facility_id = " + String( ai_facility_id )
ELSEIF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_hosp_facility_link.facility_id = " + String( ai_facility_id )
//ELSEIF ai_screen_id = 43 then //Start Code Change ---- 10.23.2006 # maha //Start Code Change ----11.17.2009 #V10 maha - removed
//	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".parent_facility_id  = " + String( ai_facility_id )
END IF

IF ai_screen_id = 2 THEN
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_address_link.address_id =                                                pd_address.rec_id "	

ELSEIF ai_screen_id = 31 THEN
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_address_link.address_id =                                                pd_address_2.rec_id "
END IF

IF ai_screen_id = 10 THEN
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_hosp_facility_link.hosp_affil_id =                                                pd_hosp_affil.rec_id "	
END IF

//---------------------appeon begin---------------------
//<$>added:long.zhang 01.17.2013
//<$>reason:Bug 3385 staff category  mapping issue
if ai_screen_id = 33 then
	ls_sql_syntax = ls_sql_syntax + " AND                                                pd_affil_staff_cat.active_status in(1,4)  and pd_affil_staff_cat.requested = 1 "	
end if
//---------------------appeon end-----------------------

//CREATE SORT ORDER
ids_screen_fields.SetSort( "sort_field A" )
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO ids_screen_fields.rowcount()
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			IF ai_screen_id = 2 THEN
				ls_sort_syntax = ls_sort_syntax + "                                               pd_address." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			ELSEIF ai_screen_id = 31 THEN	//06.28.2007 By Jervis:Add ai_screen_id = 31
				ls_sort_syntax = ls_sort_syntax + "                                               pd_address_2." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			ELSEIF ai_screen_id = 10 THEN
				ls_sort_syntax = ls_sort_syntax + "                                               pd_hosp_affil." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			ELSE
				ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"
			END IF
		ELSE
			IF ai_screen_id = 2 THEN
				ls_sort_syntax = ls_sort_syntax + "                                               pd_address." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			ELSEIF ai_screen_id = 31 THEN	//06.28.2007 By Jervis:Add ai_screen_id = 31
				ls_sort_syntax = ls_sort_syntax + "                                               pd_address_2." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			ELSEIF ai_screen_id = 10 THEN
				ls_sort_syntax = ls_sort_syntax + "                                               pd_hosp_affil." +ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			ELSE
				ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"
			END IF		
		END IF
		li_sort_data_cnt ++
	END IF
END FOR

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
ELSE //if no sort fields sort on rec_id
	IF ai_screen_id = 2  THEN //maha added 032204
		ls_sql_syntax = ls_sql_syntax + " ORDER BY                                                pd_address.rec_id "
	ELSEIF ai_screen_id = 31 THEN
		ls_sql_syntax = ls_sql_syntax + " ORDER BY                                                pd_address_2.rec_id "
	ELSEIF ai_screen_id = 10 THEN
		ls_sql_syntax = ls_sql_syntax + " ORDER BY                                                pd_hosp_affil.rec_id"
	else
		If Len( recIdSortTableName )>0 Then  //(Appeon)Gavin 10.26.2017 - V15 ISG-CLX FW: Application Mapping
			ls_sql_syntax = ls_sql_syntax + " ORDER BY " + recIdSortTableName + ".rec_id"
		Else
			ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id"
		End If
	end if
END IF

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//messagebox("syntax",ls_sql_syntax)
//	clipboard(ls_sql_syntax)
//CREATE SYNTAX FOR DETAIL DW
ls_grey = String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = ATR_SQLCA.SyntaxFromSQL(ls_sql_syntax, ls_presentation_str, ERRORS)

if ai_screen_id = 65 then
	//messagebox("65",ls_sql_syntax)
	
end if

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	messagebox("1",  ls_dwsyntax_str)
	RETURN -1
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

rc = adw_detail.rowcount()


IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", "Create cause these errors: " + ERRORS)
	RETURN -1
END IF


 // mskinner 29 december 2005 -- begin
for i = 1 to upperbound(ls_dw_field_names)

	if gs_dbtype = "ASA" then
	//Start Code Change ---- 06.20.2006 #564 maha
		choose case ai_screen_id
			case 2, 31, 18,10
				ls_dw_field_names[i] = ls_table_prefix + ls_dw_field_names[i]
		end choose
				

	end if

	
next
// mskinner 29 december 2005 -- end

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-10
//$<add> 01.24.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.
long set1
If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
		
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
	END FOR
	
	//special code for pd_address
	IF ls_table_name = "pd_address" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
		clipboard(ls_dwsyntax_str)
		RETURN -1
	END IF
End If
//---------------------------- APPEON END ----------------------------
rc = adw_detail.rowcount()


//ls_sqlsyn = adw_detail.describe("datawindow.Objects")
//	openwithparm(w_sql_msg,ls_sqlsyn)
//messagebox("", ls_Sql_syntax)

adw_detail.of_SetTransObject( ATR_SQLCA )
IF ib_retrieve_enabled THEN li_prac_row_cnt = adw_detail.Retrieve() //for performance tuning in print applications fun. - alfee 09.08.2009
//li_prac_row_cnt = adw_detail.Retrieve()
rc = adw_detail.rowcount()
//adw_detail.Object.DataWindow.Detail.Height= 5000
//adw_detail.Modify("active_status.Initial='1'")

FOR i = 1 TO li_row_cnt


	
	IF PosA(ls_dw_field_names[i],"active_status") > 0 then //ls_dw_field_names[i] = "active_status" THEN

		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
	END IF
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" THEN
		//if ai_screen_id = 81 then debugbreak()
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		ls_lookup_type = Upper(Trim(ls_lookup_type)) //Add by Evan on 07.16.2009(Corrected BugE071402)


		IF ls_lookup_type = "C" THEN
			ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup_ds'")//Start Code Change ---- 06.06.2006 #510 maha
			 //Start Code Change ----10.11.2011 #V12 maha - exception for appt ststus custom fields
			if ls_field_id[i] = "100008" or ls_field_id[i] = "100009" or  ls_field_id[i] = "100010" then
				//messagebox("","appt stat field")
				ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'description'")
			else
				ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")
			end if	
			 //Start Code Change ----10.11.2011
			IF Upper( ls_lookup_field ) = "CODE" THEN
				ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")				
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			ls_ret =adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup_for_lookup_code'")			
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			ls_ret =adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				ls_ret =adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE
				ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
			END IF
//Start Code Change ---- 02.09.2006 #261 maha			
		ELSEIF ls_lookup_type = "Q" THEN
			ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup_ds'")//Start Code Change ---- 06.07.2006 #524 maha
			ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")			
			ls_ret = adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
				//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
//End Code Change---02.09.2006				
		END IF
   
		li_retval = adw_detail.GetChild(ls_dw_field_names[i] , dwchild )
		IF li_retval = -1 THEN
			//if len(ls_dw_field_names[i]) < 1 then MessageBox( "","")
			MessageBox( string(ai_screen_id) + "-" + ls_dw_field_names[i], "dwchild error in of_create_dynamic_ds function." )
		END IF
	
	
		dwchild.SetTransObject( ATR_SQLCA )
		//messagebox("", ls_lookup_code )
		IF ls_lookup_type = "C" THEN
			IF ib_retrieve_enabled THEN dwchild.Retrieve(ls_lookup_code) //for performance tuning in print applications fun. - alfee 09.08.2009				
			//dwchild.Retrieve(ls_lookup_code)	
		END IF
		

	END IF
END FOR


//CREATE SORT ORDER //maha remodified this code 032204 for resetting the sort in application printing
ids_screen_fields.SetSort( "sort_field A" )
ids_screen_fields.Sort()
ls_sort_fields = ""

//Start Code Change ----11.10.2016 #V153 maha - modified to use sort field list
//FOR i = 1 TO li_row_cnt
//	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
//		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN //set direction
//			ls_dir = " D,"
//		else
//			ls_dir = " A,"
//		end if
//		
//		//if li_master = 1  then //upper(gs_user_id) = "MASTER" then
//		if lb_multi_tablE then		//Modified by ken at 2007-06-26	
//			ls_sort_fields = ls_sort_fields + ls_table_prefix + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir
//		else
//			ls_sort_fields = ls_sort_fields + ids_screen_fields.GetItemString( i, "db_field_name" ) + ls_dir
//		end if
//
//		
//		li_sort_data_cnt ++
//	END IF
//END FOR

FOR i = 1 TO upperbound(ls_sort_field)
	if lb_multi_tablE then			
		if left(ls_sort_field[i], 5) = 'sort4' then
			ls_sort_fields = ls_sort_fields + ls_sort_field[i] + ls_sort_dir[i] //Start Code Change ----10.16.2017 #V154 maha - corrected by adding to existing variable
		else
			ls_sort_fields = ls_sort_fields + ls_table_prefix +  ls_sort_field[i] + ls_sort_dir[i] 
		end if
	else
		ls_sort_fields = ls_sort_fields +ls_sort_field[i] + ls_sort_dir[i] 
	end if
		
END FOR

li_sort_data_cnt = upperbound(ls_sort_field)
//End Code Change ----11.10.2016

IF li_sort_data_cnt > 0 THEN
	ls_sort_fields = MidA( ls_sort_fields, 1, LenA( ls_sort_fields )-1 ) //take out the last comma
ELSE
	ls_sort_fields = "rec_id A" //set to recid then overwrite for exceptions
//Start Code Change ---- 06.20.2006 #564 maha	
	choose case ai_screen_id
		case 2, 31, 18,10	//06.28.2007 By Jervis Add 10
			ls_sort_fields = ls_table_prefix + "rec_id A"
		case 43,44,45,32 //affil tables  //Start Code Change ---- 10.25.2006 # maha
			If Len( recIdSortTableName )>0 Then  //(Appeon)Gavin 10.26.2017 - V15 ISG-CLX FW: Application Mapping
				 ls_sort_fields = recIdSortTableName + "_rec_id D"
			Else
				ls_sort_fields = "rec_id D"
			End If
	end choose

END IF

is_sort_lookup_fields = ls_sort_add_field

//maha - note: sort here will be overwritten in app population; setting the values in the sort4_... fields takes place in n_cst_app_population.of_getallscreendata

s = adw_detail.SetSort( ls_sort_fields)
if s < 0 then MessageBox("dynamic dw", ls_sort_fields )

is_sort_syntax = ls_sort_fields
adw_detail.Sort()

//End Code Change---11.21.2005 

RETURN 0
end function

public function integer of_add_committees (long al_prac_id, integer ai_facility_id, long al_rec_id);//maha created 011706.  //called from net dev of_add_multi and w_batch_add_new_app of_batch_add_apps
//Start Code Change ---- 01.17.2006 #201 maha
n_ds lds_cred_comms
n_ds lds_cred_committees
Integer li_num_comms
Integer c
Integer li_nr
long ll_comm_id

lds_cred_committees = CREATE n_ds
lds_cred_committees.DataObject = "d_pd_comm_review" 
lds_cred_committees.of_SetTransObject( SQLCA )

lds_cred_comms = CREATE n_ds
lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
lds_cred_comms.of_SetTransObject( SQLCA )
li_num_comms = lds_cred_comms.Retrieve( ai_facility_id )
//debugbreak()	
FOR c = 1 TO li_num_comms
	li_nr = lds_cred_committees.InsertRow( 0 )
	ll_comm_id = lds_cred_comms.GetItemNumber( c, "committee_id" )
	lds_cred_committees.SetItem( li_nr, "facility_id", ai_facility_id )
	lds_cred_committees.SetItem( li_nr, "committee_id", ll_comm_id )
	lds_cred_committees.SetItem( li_nr, "active_status", 1 )
	lds_cred_committees.SetItem( li_nr, "rec_id", al_rec_id )
	lds_cred_committees.SetItem( li_nr, "prac_id", al_prac_id )
	lds_cred_committees.SetItem( li_nr, "seq_no", 1 )
END FOR
	
lds_cred_committees.Update( )

DESTROY lds_cred_comms;
DESTROY lds_cred_committees;


Return 1

//End Code Change---01.17.2005 
end function

public function integer of_change_to_dddw (ref string as_syntax, string as_colname[]);//////////////////////////////////////////////////////////////////////
// $<function>of_change_colname_dddw()
// $<arguments>
//		string as_syntax - daatawindow  syntax .
//  	string as_colname - the columns that need change style to dddw
// $<returns> integer  -1 - error 1 - success
// $<description> This function using for change the column style before dynamic creating datawindow.
// $<description> This function only used in web application.
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Luke
//////////////////////////////////////////////////////////////////////

if upperbound(as_colname) <=0 then return -1

gnv_appeondll.of_changeeditstyle( as_syntax, as_colname, upperbound(as_colname) , 1)

Return 1


end function

public function integer of_change_to_editmask (ref string as_syntax, string as_colname[]);//////////////////////////////////////////////////////////////////////
// $<function>of_change_colname_dddw()
// $<arguments>
//		string as_syntax - daatawindow  syntax .
//  	string as_colname - the columns which need to change edit style as editmask
// $<returns> integer  -1 - error 1 - success
// $<description> This function using to change the column style before dynamic creating datawindow. 
// $<description> This function only used in web application 
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Luke
//////////////////////////////////////////////////////////////////////
if upperbound(as_colname) <=0 then return -1

gnv_appeondll.of_changeeditstyle( as_syntax, as_colname, upperbound(as_colname) , 2)

Return 1
end function

public function integer of_dwchild_after_retrieve (u_dw adw_dw);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functionsof_dwchild_after_retrieve()
// $<arguments>
//		value	u_dw	adw_dw		
// $<returns> integer
// $<description> This function is used to retrieve data from the database for DDDWs stored in is_dddwcolumns.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.25.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

long ll_val
datawindowchild dwchild
long ll_find
long ert , ll_row
String	ls_columnname
String	ls_types[] , ls_froms[] , ls_dddwcolumns[] , ls_lu_tables[] 
long		ll_values[]
If appeongetservertype() = 2 Then //APB 6.0 .Net
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.24.2008 By: Ken.Guo
	//$<reason> Workaround APB6.0's Bug before Appeon fixed it
	For ll_row = 1 to upperbound(is_dddwcolumns)
		ls_columnname = is_dddwcolumns[ll_row]
		adw_dw.GetChild( ls_columnname, dwchild )
		IF is_types[ll_row] = "A" THEN
			If dwchild.GetItemnumber(1,'lookup_code') <> 0 And Not isnull( dwchild.GetItemnumber(1,'lookup_code')) Then 
				if dwchild.Describe("entity_name_original.ColType") <> "!" then
					dwchild.InsertRow(1)
					dwchild.setitem(1,"code",'-SEARCH/ADD-')
					dwchild.setitem(1,"lookup_code",-888)
					dwchild.setitem(1,"entity_name_original","-Search/Add for " + is_lu_tables[ll_row] +" -")
					dwchild.setitem(1,"entity_name","-Search/Add for " + is_lu_tables[ll_row] +" -")
					dwchild.InsertRow(1) //blank row
				end if
			End If
		End if

		If is_froms[ll_row] = "RET" then
			ll_val = il_values[ll_row]
			ll_find = dwchild.find("lookup_code = " + string(ll_val),1,dwchild.rowcount())
			if ll_find > 0 then
				dwchild.scrolltorow(ll_find)
			end if
		End if
	Next
	is_types[] = ls_types[]
	is_froms[] = ls_froms[]
	is_dddwcolumns[] = ls_dddwcolumns[]
	is_lu_tables[] = ls_lu_tables[]
	il_values[] = ll_values[]	
	//---------------------------- APPEON END ----------------------------
Else  //APB 5.0 j2EE
	For ll_row = 1 to upperbound(is_dddwcolumns)
		ls_columnname = is_dddwcolumns[ll_row]
		adw_dw.GetChild( ls_columnname, dwchild )
	
		if is_froms[ll_row] = "RET" and is_types[ll_row] = "A" then 
			//app_filler.ids_screen_objects_cache.Retrieve()
		end if

		IF is_types[ll_row] = "C" THEN
			choose case is_lu_tables[ll_row]
				case "Address Type", "Yes/No","Specialty Order"
					//exceptions
					//dwchild.retrieve(as_lu_table)
				case else
					//dwchild.retrieve(as_lu_table)
					//dwchild.InsertRow(1)
					//dwchild.setitem(1,"code",'-SEARCH/Add-')
					//dwchild.setitem(1,"lookup_code",-777)
					//dwchild.setitem(1,"description","-Search/Add for " + is_lu_tables[ll_row] +" -")
			end choose
		ELSEIF is_types[ll_row] = "A" THEN
			//debugbreak()
			/*
			//comment by appeon 2006.07.11
			if dwchild.Describe("entity_name_original.ColType") <> "!" then
							
				dwchild.InsertRow(1)
				//messagebox("2",string(dwchild.rowcount()))
				dwchild.setitem(1,"code",'-SEARCH/ADD-')
				dwchild.setitem(1,"lookup_code",-888)
				dwchild.setitem(1,"entity_name_original","-Search/Add for " + is_lu_tables[ll_row] +" -")
				//ert = dwchild.getitemnumber(1,"lookup_code")
				//messagebox("",as_lu_table)
			end if
			*/
		elseif is_types[ll_row] = "Q" THEN
				//dwchild.Retrieve()
		end if
		if is_types[ll_row] = "A" then
			//dwchild.InsertRow(1)
		end if
		//	dwchild.InsertRow(1) //blank row
		if is_froms[ll_row] = "RET" then
			ll_val = il_values[ll_row]
			ll_find = dwchild.find("lookup_code = " + string(ll_val),1,dwchild.rowcount())
			if ll_find > 0 then
				dwchild.scrolltorow(ll_find)
			end if
		end if
	Next
	is_types[] = ls_types[]
	is_froms[] = ls_froms[]
	is_dddwcolumns[] = ls_dddwcolumns[]
	is_lu_tables[] = ls_lu_tables[]
	il_values[] = ll_values[]
End If
return 1
end function

public subroutine of_dwchild_after_retrieve_2 (u_dw adw_dw);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_dwchild_after_retrieve_2
// $<arguments>
//		value	u_dw	adw_dw		
// $<returns> integer
// $<description> This function is used to add a blank row for each DDDW stored in is_dddwcolumns.  
// $<description> At the same time, the application clears the values of is_types[], is_froms[],
// $<description> is_dddwcolumns[], is_lu_tables[] and il_values[]
//////////////////////////////////////////////////////////////////////
// $<add> 01.25.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

long ll_val
datawindowchild dwchild
long ll_find
long ert , ll_row
String	ls_columnname
String	ls_types[] , ls_froms[] , ls_dddwcolumns[] , ls_lu_tables[] 
long		ll_values[]

For ll_row = 1 to upperbound(is_dddwcolumns)
	ls_columnname = is_dddwcolumns[ll_row]
	adw_dw.GetChild( ls_columnname, dwchild )
   
	dwchild.InsertRow(1) //blank row
	
Next
//Set null
is_types[] = ls_types[]
is_froms[] = ls_froms[]
is_dddwcolumns[] = ls_dddwcolumns[]
is_lu_tables[] = ls_lu_tables[]
il_values[] = ll_values[]

end subroutine

public function string of_create_dynamic_dw_local (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_create_dynamic_dw_local()
// $<arguments>
//		value	long   	al_prac_id       		
//		value	integer	ai_data_view_id  		
//		value	integer	ai_screen_id     		
//		value	u_dw   	adw_detail       		
//		value	u_dw   	adw_browse       		
//		value	boolean	ab_screen_painter		
//		value	integer	ai_facility_id   		
// $<returns> string
// $<description> Create the datawindow by using local datawindow syntax.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
boolean	ib_create_browse
String	ls_dummy_array[]
integer	li_row_cnt
integer  li_set
integer	li_obj_cnt
integer	li_table_cnt
integer	i
string	ls_table_name
string	ls_table_field_names[]
string	ls_field_name
string	ls_field_names[]
integer  t
string	ls_table_names[]
boolean	lb_table_found
boolean  lb_multi_table
string	ls_dw_field_names[]
string	ls_sql_syntax
integer	li_facility_specific
string	ls_dwsyntax_str
string	ERRORS
string	ls_return_syntax
integer	li_prac_row_cnt
boolean	lb_first_field = true
string	ls_lookup_code
string	ls_lookup_field
string	ls_lookup_type
integer	res
string	ls_retval
long     ll_max_height
DataWindowChild dwchild
DataWindowChild dwchild_browse

long 		set1 , ll_recreate
string	ls_sqlselect , ls_column_list,table_list,ls_where_clause,ls_group_by_clause,ls_order_by_clause,ls_having_clause,ls_modify_error

//debugbreak()

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//---------Begin Commented by (Appeon)Stephen 04.07.2017 for V15.3 Bug # 5593 - Issues with Data preview in IPop and Application Edit--------
/*
//UNREGISTER ALL CALENDAR FIELDS
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_UnRegister()		
END IF
*/
//---------End Commented ------------------------------------------------------

app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
//messagebox("", "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	

app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_objects.Filter( )
li_obj_cnt = ids_screen_objects.RowCount()

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

li_table_cnt = 0

adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wer  //#####

wer = ids_screen_fields.SetSort( "field_order A" )
//messagebox("field_order",wer)
//ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	is_table_name = ls_table_name
	ls_field_names[i] = ls_field_name
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

li_row_cnt = UpperBound(ls_field_names)

FOR i = 1 TO li_table_cnt
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
	END IF	
END FOR  

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	FOR i = 1 TO li_row_cnt
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//ADD WHERE CLAUSE
ls_sql_syntax = " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//CREATE SORT ORDER code moved to top of function //maha 051905
ls_dwsyntax_str=''
ll_recreate = of_get_create_syntax(ai_data_view_id,ai_screen_id , ls_dwsyntax_str , 'Y' , 'D', ab_screen_painter)
adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	RETURN "-1"
END IF

//Add where clause
If not ab_screen_painter Then
	adw_detail.settransobject(SQLCA)
	ls_sqlselect = adw_detail.getsqlselect()
	parse_sql2(ls_sqlselect,ls_column_list,ls_where_clause,ls_group_by_clause,ls_order_by_clause,ls_having_clause)
	ls_sqlselect = ls_column_list + ' ' + ls_sql_syntax + ' ' +  ls_order_by_clause
	ls_return_syntax = ls_column_list 
	
	//adw_detail.setsqlselect(ls_sqlselect)
	//------------appeon begin--------------
	//<$>Modified:long.zhang appeon 06.11.2013
	//<$>reason:refresh Error
	//adw_detail.modify("datawindow.table.select = '" + ls_sqlselect + "'")
	ls_modify_error = adw_detail.modify("datawindow.table.select = '" + ls_sqlselect + "'")
	if lenA(ls_modify_error) > 0 then return "-1"
	//-----------appeon end-----------------
End If

//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	ls_dwsyntax_str=''
	ll_recreate = of_get_create_syntax(ai_data_view_id,ai_screen_id , ls_dwsyntax_str , 'N' , 'D', ab_screen_painter)
	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		RETURN "-1"
	END IF
//	ls_sqlselect = adw_browse.getsqlselect()
//	parse_sql(ls_sqlselect,ls_column_list,table_list,ls_where_clause,ls_group_by_clause,ls_order_by_clause,ls_having_clause)
//	ls_sqlselect = ls_column_list + ' ' + table_list + ' ' + ls_sql_syntax + ls_order_by_clause
//	adw_browse.setsqlselect(ls_sqlselect)
END IF
	
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2007.08.17 By: Jack
//$<reason> In order to retrieve the DDDW first, and then retrieve the main window, I moved the following scripts to below.
/*
IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	if ai_screen_id = 65 and  not ab_screen_painter then //maha app081705
		//don't add row in prac folder
	else	
		adw_detail.InsertRow(0) //maha app081705
	end if
END IF

//debugbreak()
IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
*/
//---------------------------- APPEON END ----------------------------

//adw_detail.Modify("active_status.Initial='1'")

gnv_appeondb.of_startqueue()

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	
	IF not ab_screen_painter THEN
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
	END IF
	
	
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
	
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
		adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
		dwchild.SetTransObject( SQLCA )
		//END IF

		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		dwchild.ShareData( dwchild_browse )
	END IF
END FOR

gnv_appeondb.of_commitqueue()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.08.17 By: Jack
//$<reason>  In order to retrieve the DDDW first, and then retrieve the main window, I moved the following scripts from the above to here.
IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	if ai_screen_id = 65 and  not ab_screen_painter then //maha app081705
		//don't add row in prac folder
	else	
		adw_detail.InsertRow(0) //maha app081705
	end if
END IF

IF ib_create_browse THEN
//	adw_detail.ShareData(adw_browse)
	if adw_detail.ShareData(adw_browse) <> 1 then//long.zhang 06.11.2013
			return "-1"
	end if
END IF
//---------------------------- APPEON END ----------------------------

If appeongetclienttype() <> 'PB' Then 
	If not ab_screen_painter Then of_dwchild_after_retrieve(adw_detail)
End If

//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()

//---------Begin Commented by (Appeon)Stephen 04.07.2017 for V15.3 Bug # 5593 - Issues with Data preview in IPop and Application Edit--------
/*
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
	adw_detail.of_SetReqColumn(TRUE)
END IF
*/
//---------------------------- APPEON END ----------------------------

adw_detail.SetRedraw(True)

//CREATE ANY SCREEN OBJECTS THAT WERE ADDED

//Start Code Change ---- 01.18.2006 #203 maha
IF ls_table_name = "pd_address" or ls_table_name = "dba.pd_address" THEN //maha 011806
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	//adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	adw_detail.Modify("destroy populatebutton")
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
	set1 = of_get_app_setting("set_1","I")

	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	/*
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")							
	*/
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
//		des = dwchild.Describe("DataWindow.Objects")
//			openwithparm(w_sql_msg,des)
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" THEN //maha 011806
//End Code Change---01.18.2005 
	li_set = of_get_app_setting("set_5","I")
	adw_detail.Modify("destroy peerbutton")
	if li_set = 0 then
		//messagebox("","ref button")
		//adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")//(Appeon)Toney 11.07.2013 - V141 ISG-CLX,Fix BugT110603
		adw_detail.Modify("create button(band=header text='Select Peer' filename=''action='0' border='1' color='128' x='1100' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")//(Appeon)Toney 11.07.2013 - V141 ISG-CLX,Fix BugT110603 Create Button in header band
		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
	end if
end if
//\maha


IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	//adw_detail.AcceptText() //Nova 2010/10/27 ??? 
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

RETURN ls_return_syntax
end function

public function integer of_field_audit_update ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_update_audit_update()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> Performance tuning
// $<description> The following script moved from of_field_audit
//////////////////////////////////////////////////////////////////////
// $<add> 04.10.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

IF ids_sys_audit.modifiedcount( ) + ids_sys_audit.Deletedcount( ) <=0 Then Return 0

LONG  ll_prac,ll_prac_arr[] ,ll_prac_i,ll_prac_OLD
Integer ll_Rows,  i
Long ll_seq_no

//update begin
FOR ll_Rows =  1 to ids_sys_audit.rowcount()
	IF ids_sys_audit.GetItemStatus( ll_Rows, 0 , Primary!) = newmodified! THEN
		ll_prac = ids_sys_audit.GetItemNumber( ll_Rows, "prac_id" )

		IF ll_prac <> ll_prac_OLD THEN
			ll_prac_i ++
			ll_prac_arr[ll_prac_i] = ll_prac
		END IF
		ll_prac_OLD = ll_prac

		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			SELECT Max( sys_audit.seq_no )  
			INTO :ll_seq_no
   		FROM sys_audit;
			
			IF IsNull(ll_seq_no) THEN ll_seq_no = 0
		END IF

		ll_seq_no++
		
		ids_sys_audit.SetItem( ll_Rows, "seq_no", ll_seq_no )
	END IF
NEXT

gnv_appeondb.of_startqueue( )

IF ids_sys_audit.modifiedcount( ) > 0 THEN
	i = ids_sys_audit.Update()
	COMMIT USING SQLCA;
	IF i = -1 THEN
		//MessageBox("", "Update to sys_audit table Failed!")
		MessageBox("of_field_audit_update", "Failed to update sys_audit table!")
		Return -1
	END IF
END IF

FOR i = 1 TO ll_prac_i
	of_set_mod_date(ll_prac_arr[i])
END FOR

gnv_appeondb.of_commitqueue( )

ids_sys_audit.Reset()

RETURN 1
end function

public function integer of_create_option (integer ai_data_view_id, integer ai_screen_id, string as_detail, string as_calltype, string as_updatedate, boolean ab_screen_painter);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_get_create_syntax()
// $<arguments>
//		value    	integer	ai_screen_id		
//		reference	string 	as_dwsyntax 		
//		value    	string 	as_detail   		
// $<returns> integer
// $<description> Verify whether DataWindow syntax has already been stored on local machine. If yes, the application
// $<description> directly gets the dw syntas from local SRD files; if not, the application gets the dw syntax from
// $<description> the database
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
string ls_syntaxfile,ls_regedit_value //Added by Nova on 12.31.2008
string ls_lastupdate
long	 ll_getupdate

If as_detail = 'Y' Then
	IF ab_screen_painter THEN
		ls_syntaxfile = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '_s.srd'
		ls_regedit_value='-s'//Added by Nova on 12.31.2008
	ELSE
		ls_syntaxfile = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '.srd'
		ls_regedit_value='-'//Added by Nova on 12.31.2008
	END IF
Else
	ls_syntaxfile = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '_b.srd'
	ls_regedit_value='-b'//Added by Nova on 12.31.2008
End If

If not fileexists(ls_syntaxfile) Then
	return -1
End If

//--------Begin Modified by Nova on 12.31.2008-----------
//ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Screens List", "Screen-"+string(ai_data_view_id) + '-'+as_calltype+'-'+string(ai_screen_id), regstring!, ls_lastupdate)
ll_getupdate = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Screens List", "Screen-"+string(ai_data_view_id) + ls_regedit_value + as_calltype+'-'+string(ai_screen_id), regstring!, ls_lastupdate)
//--------End Modified -------------------------------

If ll_getupdate <> 1 Then return -1
If as_updatedate <> ls_lastupdate Then return -1

return 0
end function

public function integer of_save_create_syntax (integer ai_data_view_id, integer ai_screen_id, datawindow adw_save, string as_detail, string as_currentdate, string as_calltype, boolean ab_screen_painter);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_save_create_syntax()
// $<arguments>
//		value    	integer	ai_screen_id		
//		reference	string 	as_dwsyntax 		
//		value    	string 	as_detail   		
// $<returns> integer
// $<description> save the dw syntax in SRD files on local machine.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

string		ls_filename,ls_regedit_value //Added by Nova on 12.31.2008 
blob     	lblb_Data, lb_syntax 
string		ls_dwsyntax 
integer		li_FileNum , li_write , li_Writes , li_Cnt
long			ll_BlobLen , ll_CurrentPos

//If the directory is not exists then create it 
gnv_appeondll.of_parsepath(gs_temp_path + "DWSyntax\")

If as_detail = 'Y' Then
	IF ab_screen_painter THEN
		ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '_s.srd'
		ls_regedit_value='-s'//Added by Nova on 12.31.2008 
	ELSE
		ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '.srd'
		ls_regedit_value='-'//Added by Nova on 12.31.2008 
	END IF
Else
	ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) + as_calltype + '_b.srd'
	ls_regedit_value='-b'//Added by Nova on 12.31.2008 
End If

ls_dwsyntax = adw_save.describe("datawindow.syntax")
lb_syntax = blob(ls_dwsyntax,EncodingAnsi!) //Encoding – Nova 11.16.2010
//
ll_BlobLen = LenA(lb_syntax)
// Determine the number of writes required 
// to write the entire blob
If ll_BlobLen > 32765 Then
    If Mod(ll_BlobLen, 32765) = 0 Then
       li_Writes = ll_BlobLen / 32765
    Else
       li_Writes = (ll_BlobLen / 32765) + 1
    End if
 Else
    li_Writes = 1
End if

ll_CurrentPos = 1

//
//li_flen = FileLength(ls_filename)
li_FileNum = FileOpen(ls_filename , StreamMode!, Write!, LockWrite!,Replace!)
If li_FileNum = -1 Then return -1

//
For li_Cnt = 1 To li_Writes
    lblb_Data = BlobMid(lb_syntax, ll_CurrentPos, 32765)
    ll_CurrentPos += 32765
    If FileWrite(li_FileNum, lblb_Data) = -1 Then
       Return -1
    End if
Next
//

FileClose(li_FileNum)
//--------Begin Modified by Nova 12.31.2008-----------
//Save the latest update date of the current screen in Registry
//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Screens List", 'Screen-'+string(ai_data_view_id) + '-'+as_calltype + '-'+string(ai_screen_id), regstring!, as_currentdate)
gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Screens List", 'Screen-'+string(ai_data_view_id) + ls_regedit_value + as_calltype + '-'+string(ai_screen_id), regstring!, as_currentdate)
//--------End Modified -------------------------------
return 0
end function

public function integer of_get_create_syntax (integer ai_data_view_id, integer ai_screen_id, ref string as_dwsyntax, string as_detail, string as_calltype, boolean ab_screen_painter);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions.of_get_create_syntax()
// $<arguments>
//		value    	integer	ai_screen_id		
//		reference	string 	as_dwsyntax 		
//		value    	string 	as_detail   		
// $<returns> integer
// $<description> Get the dw syntax from local SRD files.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

string		ls_filename , ls_filename_b
blob     	lb_bytes_read, lb_syntax , lb_syntax_b
string		ls_detail_syntax , ls_browse_syntax
long		   ll_FileNum , ll_flen , ll_loops , ll_new_pos , i , ll_read

If as_detail = 'Y' Then
	IF ab_screen_painter THEN
		ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) +as_calltype+ '_s.srd'
	ELSE
		ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) +as_calltype+ '.srd'
	END IF
Else
	ls_filename = gs_temp_path + "DWSyntax\" + string(ai_data_view_id)+'-'+string(ai_screen_id) +as_calltype+ '_b.srd'
End If

//Get the syntax for detail datawindow
ll_flen = FileLength(ls_filename)
ll_FileNum = FileOpen(ls_filename , StreamMode!, Read!, LockWrite!)
If ll_FileNum = -1 Then return -1

IF ll_flen > 32765 THEN
	IF Mod(ll_flen, 32765) = 0 THEN
       ll_flen = ll_flen/32765
   ELSE
       ll_loops = (ll_flen/32765) + 1
   END IF
ELSE
   ll_loops = 1
END IF

// Read the file

ll_new_pos = 1

FOR i = 1 to ll_loops
    ll_read = FileRead(ll_FileNum, lb_bytes_read)
    lb_syntax = lb_syntax + lb_bytes_read
NEXT

FileClose(ll_FileNum)
as_dwsyntax = string(lb_syntax,EncodingAnsi!)//(Appeon)Toney 11.07.2013 - V141 ISG-CLX, Fix BugT110602, Add EncodingAnsi!

return 0
end function

public subroutine of_create_application_audit_record (string as_rec_status, long al_prac_id[], long al_screen_id, long al_rec_id[], string as_reference);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functionsof_create_application_audit_record()
// $<arguments>
//		value	string	as_rec_status		
//		value	long  	al_prac_id[]   		
//		value	long  	al_screen_id
//		value	long  	al_rec_id
//		value	string  	as_reference
//
// $<returns> (none)
// $<description> Required Documents Check Box on Data Entry Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.13.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
return //not using this code

//long ii,i,j,k,ll_rowcount,ll_rowcount1,ll_rowcount2,ll_appt_stat_id,ll_app_audit_id,ll_parent_facility_id,ll_appt_stat_id_new
//long ll_application_audit_facility,ll_prac_id,ll_auto_generate,ll_receive_from_de,ll_record_id,ll_de_rec_id
//long ll_screen_num,ll_screen_id,ll_find,ll_insrow,ll_seq_row_cnt,ll_seq_no,ll_mes,ll_data_status,ll_rec_id
//string ls_filter,ls_fax_message,ls_description
//datetime ldt_date_completed
//datastore lds_pd_app_audit_rqrd_data
//datastore lds_pd_affil_status_inova
//datastore lds_last_app_audit_seq_no
//datastore lds_app_audit_rqrd_data
//
//lds_pd_app_audit_rqrd_data = create datastore
//lds_pd_app_audit_rqrd_data.dataobject = 'd_pd_app_audit_rqrd_data_inova' //from pd_app_audit_temp table.
//lds_pd_app_audit_rqrd_data.settransobject(sqlca)
//
//lds_pd_affil_status_inova = create datastore
//lds_pd_affil_status_inova.dataobject = 'd_pd_affil_status_inova' //from pd_affil_stat table
//lds_pd_affil_status_inova.settransobject(sqlca)
//
//lds_last_app_audit_seq_no = create datastore
//lds_last_app_audit_seq_no.dataobject = 'd_last_app_audit_seq_no_all_inova'// from pd_app_audit table.
//lds_last_app_audit_seq_no.settransobject(sqlca)
//
//lds_app_audit_rqrd_data = create datastore
//lds_app_audit_rqrd_data.dataobject = 'd_app_audit_rqrd_data_inova' // from data_view_app_audit table.
//lds_app_audit_rqrd_data.settransobject(SQLCA)
//
//gnv_appeondb.of_startqueue()
//lds_pd_app_audit_rqrd_data.retrieve()
//lds_pd_affil_status_inova.retrieve(al_prac_id,gs_user_id)
//lds_last_app_audit_seq_no.retrieve()
//lds_app_audit_rqrd_data.retrieve()		
//gnv_appeondb.of_commitqueue()
//	
//if al_screen_id > 0 then	
//	ll_data_status = long(.of_getitem("code_lookup","lookup_code","lookup_name = 'Required Data Status' and code = 'Satisfactory'"))
//	for ii = 1 to upperbound(al_prac_id)
//		ll_prac_id = al_prac_id[ii]
//		ll_rec_id = al_rec_id[ii]
//		
//		ls_filter = 'prac_id = ' + string(ll_prac_id)
//		lds_pd_affil_status_inova.setfilter(ls_filter)  
//		lds_pd_affil_status_inova.filter()
//		ll_rowcount = lds_pd_affil_status_inova.rowcount()
//		
//		for i = 1 to ll_rowcount
//			ll_appt_stat_id = lds_pd_affil_status_inova.getitemnumber(i,'rec_id')
//			ll_application_audit_facility = lds_pd_affil_status_inova.getitemnumber(i,'application_audit_facility')
//			ll_parent_facility_id = lds_pd_affil_status_inova.getitemnumber(i,'parent_facility_id')
//			ll_prac_id = lds_pd_affil_status_inova.getitemnumber(i,'prac_id')
//		
//			ls_filter = 'facility_id = ' + string(ll_application_audit_facility)
//			lds_app_audit_rqrd_data.setfilter(ls_filter)  
//			lds_app_audit_rqrd_data.filter()
//			ll_rowcount1 = lds_app_audit_rqrd_data.rowcount()
//			ll_find = lds_app_audit_rqrd_data.find("screen_id = " + string(al_screen_id),1,ll_rowcount1)
//			
//			if ll_find > 0 then
//				ll_auto_generate = lds_app_audit_rqrd_data.getitemnumber(ll_find,'auto_generate')
//				ll_receive_from_de = lds_app_audit_rqrd_data.getitemnumber(ll_find,'receive_from_de')
//				
//				if ll_auto_generate = 1 then
//					if as_rec_status = 'New' then
//						
//						ll_record_id = gnv_app.of_get_id("RECORD_ID")
//						ll_app_audit_id = Integer( gnv_app.of_get_id("APPAUDIT") )
//						
//						ll_insrow = lds_pd_app_audit_rqrd_data.InsertRow( 0 )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "record_id", ll_record_id )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "appt_stat_id", ll_appt_stat_id )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "prac_id", ll_prac_id )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "facility_id", ll_parent_facility_id )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "app_audit_id", ll_app_audit_id )
//					
//						lds_last_app_audit_seq_no.setfilter("prac_id = " + string(ll_prac_id) + " and facility_id = " + string(ll_parent_facility_id) + " and app_audit_id = " + string(ll_app_audit_id)	)
//						lds_last_app_audit_seq_no.filter()
//						ll_seq_row_cnt = lds_last_app_audit_seq_no.RowCount()
//						IF ll_seq_row_cnt < 1 THEN
//							ll_seq_no = 1 
//						ELSE
//							ll_seq_no = lds_last_app_audit_seq_no.rowcount() + 1
//						END IF	
//						
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "seq_no", ll_seq_no	) 		
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "active_status", 1 )
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "fax_message", as_reference	) 	
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "description", as_reference	) 	
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "de_rec_id", ll_rec_id)
//						lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "app_type", 'I'	)		
//	
//						if ll_receive_from_de = 1 then
//							ll_mes = MessageBox("Change Audit item", 'Would you like to set the Application Audit status for (description from app audit painter) as Satisfactory?', Question!, YesNo!, 1 )								
//							if ll_mes = 1 then
//								lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "data_status", ll_data_status) 		
//								lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "date_completed", today()) 		
//							end if	
//						end if
//					else
//						ls_filter = "de_rec_id = " + string(ll_rec_id) + " and facility_id = " + string(ll_parent_facility_id)
//						lds_pd_app_audit_rqrd_data.setfilter(ls_filter)
//						lds_pd_app_audit_rqrd_data.filter()
//						ll_rowcount2 = lds_pd_app_audit_rqrd_data.rowcount()
//						for k = 1 to ll_rowcount2
//							ldt_date_completed = lds_pd_app_audit_rqrd_data.getitemdatetime(k,'date_completed')
//							if as_reference <> '' then
//								lds_pd_app_audit_rqrd_data.SetItem( k, "fax_message", as_reference	) 	
//								lds_pd_app_audit_rqrd_data.SetItem( k, "description", as_reference	) 	
//							end if	
//							if ll_receive_from_de = 1 then
//								if isnull(ldt_date_completed) then
//									ll_mes = MessageBox("Change Audit item", 'Would you like to set the Application Audit status for (description from app audit painter) as Satisfactory?', Question!, YesNo!, 1 )								
//									if ll_mes = 1 then
//										lds_pd_app_audit_rqrd_data.SetItem( k, "data_status", ll_data_status) 		
//										lds_pd_app_audit_rqrd_data.SetItem( k, "date_completed", today())
//									end if
//								end if
//							end if
//						next											
//					end if
//				end if		
//			end if	
//		next
//	next
//	gnv_appeondb.of_startqueue()
//	lds_pd_app_audit_rqrd_data.update()
//	for i = 1 to upperbound(al_rec_id)
//		ll_rec_id = al_rec_id[i]		
//		delete from pd_app_audit where de_rec_id = :ll_rec_id;
//		insert into pd_app_audit (record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type)
//		  select record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type from pd_app_audit_temp where de_rec_id = :ll_rec_id;
//	next
//	commit;
//	gnv_appeondb.of_commitqueue()	
//else
//	if as_rec_status = 'R' then
//		ll_prac_id = al_prac_id[1]
//		ll_appt_stat_id = al_rec_id[1]
//		ll_appt_stat_id_new = al_rec_id[2]
//		
//		ls_filter = "appt_stat_id = " + string(ll_appt_stat_id)
//		lds_pd_app_audit_rqrd_data.setfilter(ls_filter)
//		lds_pd_app_audit_rqrd_data.filter()
//		ll_rowcount = lds_pd_app_audit_rqrd_data.rowcount()
//		for i = 1 to ll_rowcount
//			ll_record_id = gnv_app.of_get_id("RECORD_ID")
//			ll_app_audit_id = Integer( gnv_app.of_get_id("APPAUDIT") )
//		   ll_parent_facility_id = lds_pd_app_audit_rqrd_data.getitemnumber(i,'facility_id')
//		   ll_de_rec_id = lds_pd_app_audit_rqrd_data.getitemnumber(i,'de_rec_id')
//			
//			ls_fax_message = lds_pd_app_audit_rqrd_data.getitemstring(i,'fax_message')
//			ls_description = lds_pd_app_audit_rqrd_data.getitemstring(i,'description')
//			
//			lds_last_app_audit_seq_no.setfilter("prac_id = " + string(ll_prac_id) + " and facility_id = " + string(ll_parent_facility_id) + " and app_audit_id = " + string(ll_app_audit_id)	)
//			lds_last_app_audit_seq_no.filter()
//			ll_seq_row_cnt = lds_last_app_audit_seq_no.RowCount()
//			IF ll_seq_row_cnt < 1 THEN
//				ll_seq_no = 1 
//			ELSE
//				ll_seq_no = lds_last_app_audit_seq_no.rowcount() + 1
//			END IF	
//			ll_insrow = lds_pd_app_audit_rqrd_data.InsertRow( 0 )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "record_id", ll_record_id )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "appt_stat_id", ll_appt_stat_id_new )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "prac_id", ll_prac_id )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "facility_id", ll_parent_facility_id )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "app_audit_id", ll_app_audit_id )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "seq_no", ll_seq_no	) 		
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "active_status", 1 )
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "fax_message", ls_fax_message	) 	
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "description", ls_description	) 	
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "de_rec_id", ll_de_rec_id)
//			lds_pd_app_audit_rqrd_data.SetItem( ll_insrow, "app_type", 'R'	)					
//		next
//		gnv_appeondb.of_startqueue()
//		lds_pd_app_audit_rqrd_data.update()
//		insert into pd_app_audit (record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type)
//		  select record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type from pd_app_audit_temp where appt_stat_id = :ll_appt_stat_id_new;
//		commit;
//		gnv_appeondb.of_commitqueue()			
//	else
//		gnv_appeondb.of_startqueue()
//		delete from pd_app_audit where de_rec_id is not null;
//		insert into pd_app_audit (record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type)
//		  select record_id,prac_id,facility_id,seq_no,app_audit_id,completed,fax_message,active_status,date_completed,data_status,identifying_number,appt_stat_id,conv_prac_id,de_rec_id,description,app_type from pd_app_audit_temp;
//		commit;
//		gnv_appeondb.of_commitqueue()	
//	end if
//end if
//if isvalid(w_prac_data_1) then
//	w_prac_data_1.ib_app_audit_retrieved = False
//end if
//destroy lds_pd_app_audit_rqrd_data
//destroy lds_pd_affil_status_inova
//destroy lds_last_app_audit_seq_no
//destroy lds_app_audit_rqrd_data
//
end subroutine

public function integer of_app_audit_update_ref (long al_prac, long al_de_recid, string as_ref);//Start Code Change ---- 10.26.2006 #1 maha
//function created maha 102606 to update the reference value for dynamically created audit items.

update pd_app_audit set fax_message = :as_ref where prac_id = :al_prac and de_rec_id = :al_de_recid;

return 1
end function

public function integer of_app_audit_items_add (long al_facility, long al_prac, long al_affil_rec_id, long al_template, string as_from, datawindow adw_existing, string as_appt_type);//Start Code Change ---- 10.02.2006 #628 maha
//created maha 10-02-06  called from recred process, add missing
integer li_auto_gen
integer li_found
integer li_do = 1
integer li_complete = 0
integer li_screen
integer tes
integer li_cnt //maha 03.19.2008
long ll_aat_recid
long t
long tc
long d
long dc
n_ds lds_temp
n_ds lds_refs
n_ds lds_data
long ll_de_recid
string ls_ref
string ls_ref_temp
string ls_found

lds_temp = CREATE n_ds
lds_temp.dataobject = "d_app_audit_rqrd_data"
lds_temp.settransobject(sqlca)
//tc = lds_temp.retrieve(al_template,as_appt_type)//Start Code Change ----09.20.2010 #V10 maha - changed retrival args
tc = lds_temp.retrieve(al_template)

lds_refs = CREATE n_ds
lds_refs.dataobject = "d_screen_reference_fields"
tes = lds_refs.settransobject(sqlca)
if tes < 1 then messagebox("","settrans failure")

lds_data = CREATE n_ds
//messagebox("rqd data",tc)


//Start Code Change ----09.20.2010 #V10 maha
choose case as_appt_type
	case "I","R"        
		lds_temp.setfilter("(upper(app_type)='" + upper(as_appt_type) + "' or upper(app_type)= 'B')")
		lds_temp.filter()
		tc = lds_temp.rowcount( )
	case "M"  //Start Code Change ----12.25.2014 #V14.2 maha - added M
		lds_temp.setfilter("upper(app_type)= 'M' ")
		lds_temp.filter()
		tc = lds_temp.rowcount( )
	case else
		return 0
end choose
//End Code Change ----09.20.2010

for t = 1 to tc   //get the template list for each item check auto generate value
	li_auto_gen = lds_temp.getitemnumber(t,"auto_generate")
	if isnull(li_auto_gen) then li_auto_gen = 0  //Start Code Change ---- 01.25.2007 #V7 maha
	li_complete = lds_temp.getitemnumber(t,"receive_from_de")
	if isnull(li_complete) then li_complete = 0  //Start Code Change ---- 01.25.2007 #V7 maha
	ll_aat_recid = lds_temp.getitemnumber(t,"app_audit_id")
	li_screen = lds_temp.getitemnumber(t,"screen_id")
	
	if li_screen = 13 then
	//	debugbreak()
	end if

	//ls_ref = lds_temp.getitemstring(t,"description")
	ls_ref = lds_temp.getitemstring(t,"fax_description")//Start Code Change ---- 09.17.2007 #V7 maha
	
	if as_from = "Reapp" then 
		li_complete = 0 //for recred process do not complete
		li_do = 1
	end if
	choose case li_auto_gen
		case 0 //from the template directly
			setnull(ll_de_recid)
			if as_from  = "Missing" then
				li_found = adw_existing.find("app_audit_id = " + string(ll_aat_recid),1,1000) 
				if li_found  > 0 then 
					li_do = 0
					
				end if
			end if
			if li_do = 1 then
				li_cnt += of_app_audit_item_create( al_facility, al_prac, ll_aat_recid, al_affil_rec_id,ll_de_recid,"Audit" , li_complete,ls_ref)
			end if
			li_do = 1
		case 1 //from the data
			//debugbreak()
			if isnull(li_screen) then continue //(Appeon)Stephen 03.16.2017 - Alpha id 5557 - Unable to Get Screen Data Info SaaS V15.3 Build 03082017
			tes = of_create_dynamic_ds( al_prac,1, li_screen, lds_data, al_facility,sqlca)
			
			tes = lds_refs.retrieve(1,li_screen) //view and screen
			if tes < 1 then 
				messagebox("App Audit add","Unable to get screen data info")
				continue
			end if
			dc = lds_data.rowcount()
			for d = 1 to dc
				//Start Change code by Jervis 06.28.2007
				//For screen = 2,31,10,The column name include table name
				//get the recid from the data record
				/*
				ll_de_recid = lds_data.getitemnumber(d,"rec_id")
				*/
				if li_screen = 2 then
					ll_de_recid = lds_data.getitemnumber(d,"pd_address_rec_id")
				elseif li_screen = 31 then
					ll_de_recid = lds_data.getitemnumber(d,"pd_address_2_rec_id")
				elseif li_screen = 10 then
					ll_de_recid = lds_data.getitemnumber(d,"pd_hosp_affil_rec_id")
				else
					ll_de_recid = lds_data.getitemnumber(d,"rec_id")
				end if
				//End Change Code by jervis 06.28.2007
				
					
				//messagebox(string(li_screen),ll_de_recid)
				if as_from  = "Missing" then
					ls_found = "de_rec_id = " + string(ll_de_recid)
					li_found = adw_existing.find(ls_found,1,1000)
					if li_found > 0 then li_do = 0
				//	messagebox(string(li_found),ls_found)

				end if
				if li_do = 1 then
					ls_ref_temp = MidA(ls_ref,1,5) + "-" //get first 5 characters of description
					ls_ref_temp = ls_ref_temp + of_get_reference_value(li_screen, d , lds_data, lds_refs)  //screen row,data, refence ds 
					li_cnt += of_app_audit_item_create( al_facility, al_prac, ll_aat_recid, al_affil_rec_id,ll_de_recid,"Audit" , li_complete,ls_ref_temp)
				end if
				li_do = 1
			next
	end choose
next
	
destroy lds_temp
destroy lds_refs

//return 1
return li_cnt
end function

public function integer of_field_audit (datastore ads_data, ref string as_errortext);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.26.2007 By: Evan
//$<reason> New feature of import module.
long li_seq_rc
long ll_seq_no
long ll_rec_id
long ll_field_id
long ll_field_id2
long ll_field_id1
long ll_old_value
long ll_new_value
long ll_facility_id
long ll_prac_id
long ll_value_arr[]
long ll_reference_field_1
long ll_reference_field_2
long i, j
long ll_RowCount
long ll_InsertRow
long ll_FindRow
long ll_lu_rc
string ls_lookup_type
string ls_is_lookup
string ls_lookup_field_name
string ls_retval
string ls_old_value
string ls_new_value
string ls_value1
string ls_value2
string ls_table_name
string ls_field_name
string ls_field_name2
string ls_field_type
string ls_field_type_arr[]
integer li_table_id
integer li_AuditFieldCount
integer li_facility_specific
integer li_set85
DWItemStatus ldis_Status
DataStore lds_audit_fields
String ls_lookup_name //(Appeon)Harry 04.09.2015
String ls_datavalue_dddw //(Appeon)Harry 04.09.2015

//Create audit view datatore
if not IsValid(ids_sys_audit) then
	ids_sys_audit = Create n_ds
	ids_sys_audit.DataObject = "d_view_audit"
	ids_sys_audit.SetTransObject(SQLCA)
end if
//ls_table_name = ads_data.Object.DataWindow.Table.UpdateTable //Commented By Ken.Guo 06.16.2008
ls_table_name = ads_data.Describe("DataWindow.Table.UpdateTable") //Added By Ken.Guo 06.16.2008
//li_facility_specific = of_get_facil_specific(li_table_id)	//commented by long.zhang 09.08.2011

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.06.2015
//<$>reason: (Bug 4379 created for Case# 00051492: Audit Trail Issue)
If ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items' or ls_table_name = 'pd_appl_tracking' Then
	li_set85 = of_get_app_setting("set_85","I")
	If li_set85 = 2 Then //(Appeon)Stephen 07.18.2016 - add li_set85 = 2
		//---------Begin Added by (Appeon)Stephen 05.12.2016 for V15.2-Application Tracking full Auditing--------
		of_applfield_audit(ads_data, as_errortext, false, 0) 
		return 1
		//---------End Added ------------------------------------------------------
	Elseif li_set85 = 1 and (ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items' ) then //(Appeon)Stephen 07.18.2016 - add li_set85 = 2
		//go on
	else
		Return 1
	End if	
End If
//------------------- APPEON END -------------------
	
ll_RowCount = ads_data.RowCount()

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("sys_fields", FALSE)
//------------------------------------------------------------------------------------------------------
//Retrieve address lookup and get field type
lds_audit_fields = gnv_data.ids_sys_fields
lds_audit_fields.SetFilter("sys_tables_table_name = '" + ls_table_name + "' AND sys_fields_audit_fld = 'Y'")
lds_audit_fields.Filter()
li_AuditFieldCount = lds_audit_fields.Rowcount()

//-----Begin Added by alfee 12.18.2009 ----------------
//for caqh xml import('Attest Questions' & 'Work Gap') - caqh 2 
if li_AuditFieldCount < 1 and ib_caqh_import then
	lds_audit_fields.SetFilter("sys_tables_table_name = '" + ls_table_name + "'" )
	lds_audit_fields.Filter()
	li_AuditFieldCount = lds_audit_fields.Rowcount()
end if
//-----End Added ---------------------------------------

//---------Begin Added by (Appeon)Harry 04.15.2015 for V142 ISG-CLXBug 4478--------
if ls_table_name = "pd_clinical_specialties" then
	lds_audit_fields.SetSort("field_id ASC ")
	lds_audit_fields.Sort()
end if
//---------End Added ------------------------------------------------------

//<Modify> 08/04/2007 by: Andy Reason:BugJ073004 
//If no audit fields, the system will pop a messagebox that it is not necessary.
//if li_AuditFieldCount < 1 then Return -1
if li_AuditFieldCount < 1 then Return 1//success
//end of modify

for i = 1 to li_AuditFieldCount
	//Retrieve address lookup
	ls_lookup_type = lds_audit_fields.GetItemString(i, "lookup_type")
	if ls_lookup_type = "A" then
		if not IsValid(ids_address_lookup) then
			ids_address_lookup = Create DataStore
			ids_address_lookup.DataObject = "d_import_ds_lu_address"
			ids_address_lookup.SetTransObject(SQLCA)			
		end if
		ll_lu_rc = ids_address_lookup.RowCount()
		if ll_lu_rc <= 0 then ll_lu_rc = ids_address_lookup.Retrieve()
		//ids_address_lookup data from import module when being data import
	end if
	//Get field type
	ls_field_name = lds_audit_fields.GetItemString(i, "field_name")

	ls_field_type = Upper(ads_data.Describe(ls_field_name + ".ColType"))	
	
	//---------Begin Added by (Appeon)Stephen 11.02.2016 for V15.3-Image Auditing in IntelliCred--------
	if ls_table_name = "pd_images" and ls_field_type = "!" then
		ls_field_type = Upper(ads_data.Describe(ls_table_name + "_" + ls_field_name + ".ColType"))	
	end if
	//---------End Added ------------------------------------------------------
	
	if PosA(ls_field_type, "CHAR") > 0 then
		ls_field_type = "C"
	elseif PosA(ls_field_type, "DATE") > 0 then
		ls_field_type = "D"
	elseif PosA(ls_field_type, "LONG") > 0 or PosA(ls_field_type, "DECIMAL") > 0 or PosA(ls_field_type, "REAL") > 0 then
		ls_field_type = "N"
	elseif ls_field_type = "!" then
		ls_field_type = "!"
	else
		as_ErrorText = "Unknown data type " + ls_field_type + " for field " + ls_field_name
		Return -1
	end if
	ls_field_type_arr[UpperBound(ls_field_type_arr) + 1] = ls_field_type
next
li_table_id = lds_audit_fields.GetItemNumber(1, "table_id")
li_facility_specific = of_get_facil_specific(li_table_id)	//added by long.zhang 09.08.2011

//Execute field audit process
for i = 1 to ll_RowCount	
	if li_table_id = 95 then //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
		if ads_data.Describe("prac_id.ColType") <> "!" then
			ll_prac_id = ads_data.GetItemNumber(i, "prac_id")
		else
			ll_prac_id = ads_data.GetItemNumber(i, "pd_images_prac_id")
		end if
		ldis_Status = ads_data.GetItemStatus(i, 0, Primary!)
		if ldis_Status = newmodified! then
			select max(image_pk) into :ll_rec_id from pd_images ;
			if isnull(ll_rec_id) then ll_rec_id = 0
			ll_rec_id +=1			
		else
			ll_rec_id = ads_data.GetItemNumber(i, "image_pk")
		end if
	else
		ll_rec_id = ads_data.GetItemNumber(i, "rec_id") 
		ll_prac_id = ads_data.GetItemNumber(i, "prac_id")
	end if
	if li_facility_specific = 1 then
		if ls_table_name = "pd_affil_stat" then
			if ads_data.Describe("parent_facility_id.ColType") <> "!" then ll_facility_id = ads_data.GetItemNumber(i, "parent_facility_id") //evan 04.12.2012-added a trap
		else
			if ads_data.Describe("facility_id.ColType") <> "!" then 
				ll_facility_id = ads_data.GetItemNumber(i, "facility_id") //evan 04.12.2012-added a trap
			else //(Appeon)Stephen 11.04.2016 - V15.3-Image Auditing in IntelliCred
				if li_table_id = 95 and ads_data.Describe("pd_images_facility_id.ColType") <> "!" then
					ll_facility_id = ads_data.GetItemNumber(i, "pd_images_facility_id")
				end if
			end if
		end if
	end if 
	ldis_Status = ads_data.GetItemStatus(i, 0, Primary!)
	
	if ldis_Status = DataModified! then
	////////////////////////[1-Current row is DataModified!]///////////////////////////////////
		for j = 1 to li_AuditFieldCount			
			ll_field_id = lds_audit_fields.GetItemNumber(j, "field_id")
			ls_field_name = lds_audit_fields.GetItemString(j, "field_name")
			if ls_field_type_arr[j] = "!" then Continue
			
			//---------Begin Added by (Appeon)Stephen 11.02.2016 for V15.3-Image Auditing in IntelliCred--------
			if li_table_id = 95 and ads_data.Describe(ls_field_name + ".ColType") = '!' then
				ls_field_name = ls_table_name + "_" + ls_field_name
			end if
			//---------End Added ------------------------------------------------------
			if ads_data.GetItemStatus(i, ls_field_name, Primary!) = DataModified! then
				ls_lookup_field_name = UPPER(lds_audit_fields.GetItemString(j, "lookup_field_name"))
				ls_is_lookup = lds_audit_fields.GetItemString(j, "lookup_field")
				ls_lookup_type = lds_audit_fields.GetItemString(j, "lookup_type")	
				choose case ls_field_type_arr[j]
					case "C"
						ls_old_value = ads_data.GetItemString(i, ls_field_name, Primary!, True)
						ls_new_value = ads_data.GetItemString(i, ls_field_name)		
						//---------Begin Added by (Appeon)Harry 04.09.2015 for  Bug 4478-------- 
						if ls_is_lookup = "Y"  then
							ls_datavalue_dddw = ads_data.Describe( ls_field_name+ ".DDDW.DataColumn")
							if lower(ls_lookup_field_name) <> lower(ls_datavalue_dddw) then
								ls_lookup_name = lds_audit_fields.GetItemString(j, "lookup_code")
								if ls_lookup_type = "C" then
									//get the old value / get the new value
									choose case Lower(ls_datavalue_dddw)
										case 'lookup_code' 
											ls_old_value = gnv_data.of_getitem('code_lookup', trim(lower(ls_lookup_field_name)), 'lookup_code=' + ls_old_value)
											ls_new_value = gnv_data.of_getitem('code_lookup', trim(lower(ls_lookup_field_name)), 'lookup_code=' + ls_new_value)
										case 'code'
											ls_old_value = gnv_data.of_getitem('code_lookup',  trim(lower(ls_lookup_field_name)), "code='" + ls_old_value + "' and lookup_name = '" + ls_lookup_name + "'")
											ls_new_value = gnv_data.of_getitem('code_lookup',  trim(lower(ls_lookup_field_name)), "code='" + ls_new_value + "' and lookup_name = '" + ls_lookup_name + "'")
										case else
									end choose					
								//else
								elseif ls_lookup_type = "A" then //Start Code Change ----12.17.2008 #V85 maha - changed to elseif
									//get the old value
									if Lower(ls_datavalue_dddw) = 'lookup_code' then
										ll_FindRow = ids_address_lookup.Find("lookup_code = " + ls_old_value, 1, ll_lu_rc)
									elseif  Lower(ls_datavalue_dddw) = 'code' then
										ll_FindRow = ids_address_lookup.Find("code = '" + ls_old_value + "' and lookup_name = '" + ls_lookup_name + "'", 1, ll_lu_rc)
									end if
									
									if ll_FindRow <= 0 then
										ls_old_value = ""
									elseif ls_lookup_field_name = "CODE" then
										ls_old_value = ids_address_lookup.GetItemString(ll_FindRow, "code")				//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1					
									else
										ls_old_value = ids_address_lookup.GetItemString(ll_FindRow, "entity_name")		//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
									end if
		
									//get the new value								
									if Lower(ls_datavalue_dddw) = 'lookup_code' then
										ll_FindRow = ids_address_lookup.Find("lookup_code = " + ls_new_value, 1, ll_lu_rc)
									elseif  Lower(ls_datavalue_dddw) = 'code' then
										ll_FindRow = ids_address_lookup.Find("code = '" + ls_new_value + "' and lookup_name = '" + ls_lookup_name + "'", 1, ll_lu_rc)
									end if
									if ll_FindRow = 0 then
										ls_new_value = ""
									elseif ls_lookup_field_name = "CODE" then
										ls_new_value = ids_address_lookup.GetItemString(ll_FindRow, "code")		//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
									else
										ls_new_value = ids_address_lookup.GetItemString(ll_FindRow, "entity_name")	//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
									end if
								end if
							end if
						end if
						//---------End Added ------------------------------------------------------
					case "N"
						ll_old_value = ads_data.GetItemNumber(i, ls_field_name, Primary!, True) 
						ll_new_value = ads_data.GetItemNumber(i, ls_field_name) 												
						if ls_is_lookup = "Y" then
							if ls_lookup_type = "C" then
								//get the old value						
								if ls_lookup_field_name = "CODE" then
									ls_old_value = gnv_data.of_getitem('code_lookup', 'code', 'lookup_code=' + string(ll_old_value))
								else
									ls_old_value = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code=' + string(ll_old_value))
								end if
	
								//get the new value
								if ls_lookup_field_name = "CODE" then
									ls_new_value = gnv_data.of_getitem('code_lookup', 'code', 'lookup_code=' + string(ll_new_value))
								else
									ls_new_value = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code=' + string(ll_new_value))
								end if							
							//else
							elseif ls_lookup_type = "A" then //Start Code Change ----12.17.2008 #V85 maha - changed to elseif
								//get the old value
								ll_FindRow = ids_address_lookup.Find("lookup_code = " + string(ll_old_value), 1, ll_lu_rc)
								if ll_FindRow <= 0 then
									ls_old_value = ""
								elseif ls_lookup_field_name = "CODE" then
									ls_old_value = ids_address_lookup.GetItemString(ll_FindRow, "code")				//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1					
								else
									ls_old_value = ids_address_lookup.GetItemString(ll_FindRow, "entity_name")		//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
								end if
	
								//get the new value								
								ll_FindRow = ids_address_lookup.Find("lookup_code = " + string(ll_new_value), 1, ll_lu_rc)								
								if ll_FindRow = 0 then
									ls_new_value = ""
								elseif ls_lookup_field_name = "CODE" then
									ls_new_value = ids_address_lookup.GetItemString(ll_FindRow, "code")		//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
								else
									ls_new_value = ids_address_lookup.GetItemString(ll_FindRow, "entity_name")	//Start Code Change ----02.15.2011 #V11 maha	- changed to ll_findrow from 1	
								end if
							elseif ls_lookup_type = 'D' or ls_lookup_type = 'G' then //(Appeon)Stephen 12.30.2015 - Other audit trail data missing change values
								ls_old_value = of_change_dddw(ads_data, ls_field_name, string(ll_old_value))
								ls_new_value = of_change_dddw(ads_data, ls_field_name, string(ll_new_value))
							end if
						else
							ls_old_value = String(ads_data.GetItemNumber(i, ls_field_name, Primary!, True))
							ls_new_value = String(ads_data.GetItemNumber(i, ls_field_name))	
							if ls_field_name = 'active_status' then
								ls_old_value = of_active_status_value(ls_old_value ,ls_table_name )
								ls_new_value = of_active_status_value(ls_new_value ,ls_table_name )
							end if
						end if					
					case else
						ls_old_value = String(Date(ads_data.GetItemDateTime(i, ls_field_name, Primary!, True)))
						ls_new_value = String(Date(ads_data.GetItemDateTime(i, ls_field_name)))	
				end choose
				
				//---------Begin Added by (Appeon)Harry 04.09.2015 for  Bug 4478--------
				if ls_is_lookup = "Y" or ls_field_name = 'active_status' then //(Appeon)Stephen 06.26.2015 - add "ls_field_name = 'active_status'" --Bug # 4577 - Audit trail is not recording the Old and New values for the Status field Case # 55462
				else
					choose case Lower(ads_data.Describe( ls_field_name + ".edit.style"))
						case  "checkbox"
							ls_old_value = of_change_checkbox(ads_data, ls_field_name, ls_old_value)
							ls_new_value = of_change_checkbox(ads_data, ls_field_name, ls_new_value)
						case "ddlb"
							if ls_field_name <> 'active_status' and mid (Lower(ads_data.Describe( ls_field_name + ".coltype")), 1, 4) <> 'date' then
								ls_old_value = of_change_ddlb(ads_data, ls_field_name, ls_old_value)
								ls_new_value = of_change_ddlb(ads_data, ls_field_name, ls_new_value)
							end if
						case "dddw"	
							ls_old_value = of_change_dddw(ads_data, ls_field_name, ls_old_value)
							ls_new_value = of_change_dddw(ads_data, ls_field_name, ls_new_value)
					end choose
				end if
				//---------End Added ------------------------------------------------------
				
				//---------Begin Added by (Appeon)Stephen 11.07.2016 for V15.3-Image Auditing in IntelliCred--------
				if ls_old_value = ls_new_value then continue
				if (isnull(ls_old_value) and isnull(ls_new_value)) then continue
				//---------End Added ------------------------------------------------------

				//Insert a new audit record
				ll_InsertRow = ids_sys_audit.InsertRow(0)
				ids_sys_audit.SetItem(ll_InsertRow, "rec_id", ll_rec_id)
				ids_sys_audit.SetItem(ll_InsertRow, "prac_id", ll_prac_id)					
				ids_sys_audit.SetItem(ll_InsertRow, "seq_no", ll_seq_no)										
				ids_sys_audit.SetItem(ll_InsertRow, "table_id", li_table_id)
				ids_sys_audit.SetItem(ll_InsertRow, "field_id", ll_field_id)
				ids_sys_audit.SetItem(ll_InsertRow, "old_value", MidA(ls_old_value,1,100))
				ids_sys_audit.SetItem(ll_InsertRow, "new_value", MidA(ls_new_value,1 ,100))
				ids_sys_audit.SetItem(ll_InsertRow, "user_id", gnv_app.of_getuserid())
				ids_sys_audit.SetItem(ll_InsertRow, "audit_type", "E")	
				ids_sys_audit.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))
				ids_sys_audit.SetItem(ll_InsertRow, "sys_audit_exported", 1)
				if li_facility_specific = 1 then
					ids_sys_audit.SetItem(ll_InsertRow, "facility_id", ll_facility_id)
				else
					ids_sys_audit.SetItem(ll_InsertRow, "facility_id", 0)
				end if
			end if
		next

	elseif ldis_Status = NewModified! then
	////////////////////////[2-Current row is NewModified!]///////////////////////////////////	
		ll_field_id = 1000 
		choose case ls_table_name
			case "pd_affil_stat"
				if ads_data.Describe("parent_facility_id.ColType") = "!" then Continue
				if ads_data.Describe("apptmnt_type.ColType") = "!" then Continue
				ll_new_value = ads_data.GetItemnumber(i, "parent_facility_id")
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))				
				ls_value2 = ads_data.GetItemstring(i, "apptmnt_type")
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_dept"
				if ads_data.Describe("department.ColType") = "!" then Continue
				if ads_data.Describe("facility_id.ColType") = "!" then Continue
				ll_new_value = ads_data.GetItemnumber(i, "department")
				ls_value2 = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code='+string(ll_new_value))
				ll_new_value = ads_data.GetItemnumber(i, "facility_id")
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_cat"
				if ads_data.Describe("facility_id.ColType") = "!" then Continue
				if ads_data.Describe("staff_category.ColType") = "!" then Continue
				ll_new_value = ads_data.GetItemnumber(i, "facility_id")
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				ll_new_value = ads_data.GetItemnumber(i, "staff_category")
				ls_value1 = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code='+string(ll_new_value))				
				ls_new_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_leave"
				if ads_data.Describe("facility_id.ColType") = "!" then Continue
				if ads_data.Describe("leave_of_absence_reason.ColType") = "!" then Continue
				ll_new_value = ads_data.GetItemnumber(i, "facility_id")
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				ll_new_value = long(ads_data.GetItemstring(i, "leave_of_absence_reason"))
				ls_value1 = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code='+string(ll_new_value))				
				ls_new_value = ls_value1 + "-" + ls_value2
			case 'net_dev_ids','net_dev_action_items', 'pd_images' //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
				ls_new_value = string(ll_rec_id) + "-" + string(ll_prac_id)
			case else
				//--------Begin Added by Nova 06.01.2009------------------------
				ll_reference_field_1 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_1", "data_view_id = 1 and table_id = " + String(li_table_id)))
				ll_reference_field_2 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_2", "data_view_id = 1 and table_id = " + String(li_table_id)))
				//--------End Added --------------------------------------------
				
				//get reference field 1
				ll_field_id1 = ll_reference_field_1
				if li_AuditFieldCount > 0 then
					if isnull(ll_field_id1) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber(1, "field_id")
				end if

				//get reference field 2
				ll_field_id2 = ll_reference_field_2
				if li_AuditFieldCount > 1 then
					if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber(2, "field_id")
				end if

				//get reference field name 1
				ls_field_name = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + String(ll_field_id1))
				if li_AuditFieldCount > 0 then
					if isnull(ls_field_name) or ls_field_name = "" then ls_field_name = lds_audit_fields.GetItemString(1, "field_name")
				end if

				//get reference field name 2
				ls_field_name2 = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + String(ll_field_id2))
				if li_AuditFieldCount > 1 then
					if isnull(ls_field_name2) or ls_field_name2 = "" then ls_field_name2 = lds_audit_fields.GetItemString(2, "field_name")
				end if
				
				//datatype and lookup field
				ls_field_type = gnv_data.of_getitem("sys_fields", "field_type", "field_id = " + String(ll_field_id1))
				ls_lookup_type = gnv_data.of_getitem("sys_fields", "lookup_type", "field_id = " + String(ll_field_id1))

				ls_field_type = Upper(ads_data.Describe(ls_field_name + ".ColType"))
				if PosA(ls_field_type, "CHAR") > 0 then
					ls_field_type = "C"
				elseif PosA(ls_field_type, "DATE") > 0 then
					ls_field_type = "D"
				elseif PosA(ls_field_type, "LONG") > 0 OR PosA(ls_field_type, "DECIMAL") > 0 then
					ls_field_type = "N"
				elseif ls_field_type = "!" then
					//Continue  //Commented by (Appeon)Harry 05.13.2015 
					ls_field_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				else
					as_ErrorText = "Unknown data type " + ls_field_type + " for field " + ls_field_name
					Return -1
				end if
		
				//data value1
				choose case ls_field_type
					case "C","V"
						ls_value1 = ads_data.GetItemString(i, ls_field_name)
					case "N", "I"
						ls_value1 = string(ads_data.GetItemnumber(i, ls_field_name))
					case "D"
						ls_value1 = string(ads_data.GetItemdatetime(i, ls_field_name))
					case else
						ls_value1 = ""
				end choose

				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1)
					ls_value1 = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code='+string(ll_new_value))
					if LenA(ls_value1) < 1 then ls_value1 = String(ll_new_value) //caqh 2 - alfee 11.03.2009
				elseif ls_lookup_type = "A" then
					//--------Begin Added by alfee 01.19.2010 ----------
					//<$Reason>The reference field may not be a audit field
					if not IsValid(ids_address_lookup) then
						ids_address_lookup = Create DataStore
						ids_address_lookup.DataObject = "d_import_ds_lu_address"
						ids_address_lookup.SetTransObject(SQLCA)			
					end if
					ll_lu_rc = ids_address_lookup.RowCount()
					if ll_lu_rc <= 0 then ll_lu_rc = ids_address_lookup.Retrieve()
					//--------End Added ----------------------------------									
					ll_new_value = long(ls_value1)
					ll_FindRow = ids_address_lookup.Find("lookup_code = " + string(ll_new_value),1, ll_lu_rc)
					if ll_FindRow > 0 then ls_value1 = ids_address_lookup.GetItemString(ll_FindRow , "entity_name")
				end if

				ls_field_type = gnv_data.of_getitem("sys_fields", "field_type", "field_id = " + String(ll_field_id2))
				ls_lookup_type = gnv_data.of_getitem("sys_fields", "lookup_type", "field_id = " + String(ll_field_id2))

				ls_field_type = Upper(ads_data.Describe(ls_field_name2 + ".ColType"))
				if PosA(ls_field_type, "CHAR") > 0 then
					ls_field_type = "C"
				elseif PosA(ls_field_type, "DATE") > 0 then
					ls_field_type = "D"
				elseif PosA(ls_field_type, "LONG") > 0 OR PosA(ls_field_type, "DECIMAL") > 0 then
					ls_field_type = "N"
				elseif ls_field_type = "!" then
					//Continue  //Commented by (Appeon)Harry 05.13.2015 
					ls_field_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				else
					as_ErrorText = "Unknown data type " + ls_field_type + " for field " + ls_field_name
					Return -1
				end if
				
				//data value2
				choose case ls_field_type
					case "C","V"
						ls_value2 = ads_data.GetItemString(i, ls_field_name2)
					case "N", "I"
						ls_value2 = string(ads_data.GetItemnumber(i, ls_field_name2))
					case "D"
						ls_value2 = string(ads_data.GetItemdatetime(i, ls_field_name2))
					case else
						ls_value2 = ""
				end choose		

				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					ls_value2 = gnv_data.of_getitem('code_lookup', 'description', 'lookup_code='+string(ll_new_value))
					if LenA(ls_value2) < 1 then ls_value2 = String(ll_new_value) //caqh 2 - alfee 11.03.2009					
				elseif ls_lookup_type = "A" then
					//--------Begin Added by alfee 01.19.2010 ----------
					//<$Reason>The reference field may not be a audit field
					if not IsValid(ids_address_lookup) then
						ids_address_lookup = Create DataStore
						ids_address_lookup.DataObject = "d_import_ds_lu_address"
						ids_address_lookup.SetTransObject(SQLCA)			
					end if
					ll_lu_rc = ids_address_lookup.RowCount()
					if ll_lu_rc <= 0 then ll_lu_rc = ids_address_lookup.Retrieve()
					//--------End Added ----------------------------------							
					ll_new_value = long(ls_value2)
					ll_FindRow = ids_address_lookup.Find("lookup_code = " + string(ll_new_value),1, ll_lu_rc)
					if ll_FindRow > 0 then ls_value2 = ids_address_lookup.GetItemString(ll_FindRow , "entity_name")					
				end if
				
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)
		end choose
		
		//Insert a new audit record
		ll_InsertRow = ids_sys_audit.InsertRow(0)
		ids_sys_audit.SetItem(ll_InsertRow, "rec_id", ll_rec_id)
		ids_sys_audit.SetItem(ll_InsertRow, "prac_id", ll_prac_id)
		ids_sys_audit.SetItem(ll_InsertRow, "seq_no", ll_seq_no)
		ids_sys_audit.SetItem(ll_InsertRow, "table_id", li_table_id)
		ids_sys_audit.SetItem(ll_InsertRow, "field_id", 1000)
		ids_sys_audit.SetItem(ll_InsertRow, "new_value", ls_new_value)
		ids_sys_audit.SetItem(ll_InsertRow, "user_id", gnv_app.of_getuserid())
		ids_sys_audit.SetItem(ll_InsertRow, "audit_type", "I")	
		ids_sys_audit.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))		
		ids_sys_audit.SetItem(ll_InsertRow, "sys_audit_exported", 1)
		if li_facility_specific = 1 then
			ids_sys_audit.SetItem(ll_InsertRow, "facility_id", ll_facility_id)
		else
			ids_sys_audit.SetItem(ll_InsertRow, "facility_id", 0)
		end if
	end if
next

//of_field_audit_update()
if not ib_caqh_import then of_field_audit_update() //caqh 2 - alfee 12.18.2009

Return 1
//---------------------------- APPEON END ----------------------------
end function

public function string of_create_dynamic_dw_4_prof (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, boolean ab_screen_painter, integer ai_facility_id);SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
Long ll_detail_height
string widt
integer wer
DataWindowChild dwchild
DataWindowChild dwchild_browse
datastore lds_screen_fields

long set1 , ll_recreate
String ls_Bold, ls_italic

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add a condition to make sure that: 1) DataWindow syntax will be stored in SRD files
//$<modification> in local machine; 2) the application directly gets the DataWindow syntax from local
//$<modification> machine instead of from the database when the same DataWindow is needed for a second time.

If appeongetclienttype() <> 'PB' Then
	ll_recreate = of_create_option(ai_data_view_id,ai_screen_id,'Y','D',string(idt_screen_cache),ab_screen_painter)
	If ll_recreate = 0 Then
//		ls_return_syntax = of_create_dynamic_dw_local(al_prac_id,ai_data_view_id,ai_screen_id,adw_detail,adw_browse,ab_screen_painter,ai_facility_id)
		If ls_return_syntax <> "-1" Then return ls_return_syntax
	End If
End If
//---------------------------- APPEON END ----------------------------

//debugbreak()



is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

of_setup_cache()

	app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
//messagebox("", "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	

	app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
	
	ids_screen_fields.SetSort( "field_order A" )
	ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

//adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wervv  //#####
wervv = ids_screen_fields.SetSort( "sort_field A" ) //maha corrected 051005
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD order BY CLAUSE
//IF li_sort_data_cnt > 0 THEN
//	ls_sort_syntax = Mid( ls_sort_syntax, 1, Len( ls_sort_syntax )-1 )
//	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
//else
//	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
//END IF
wer = ids_screen_fields.SetSort( "field_order A" )
//messagebox("field_order",wer)
//ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/15/2007 By: Jervis
//$<reason> Fix a defect
if li_table_cnt = 0 then
	Messagebox("Caution","Failed to create SELECT syntax for datawindow. ")
	return '-1'
end if
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

  
//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
//li_test = pos(ls_sql_syntax,"prac_id",1)
	//messagebox("pos",li_test)
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	//if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------	
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "prac_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03/16/2007 By: Jervis
	//$<reason> Fixed a defect
	/*
	li_key_cnt ++
	if pos(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making prac_id visible
	*/
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making prac_id visible
		li_key_cnt ++
	//---------------------------- APPEON END ----------------------------
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "rec_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 03/16/2007 By: Jervis
		//$<reason> Fixed a defect
		if PosA(ls_sql_syntax,"facility_id",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "facility_id"
			end if
		end if
		//---------------------------- APPEON END ----------------------------

	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.13.2006 By: Liang QingShi
	//$<reason> Fix a defect in the original unmodified PowerBuilder application. After analyze the
	//$<reason> original application, one constraint is missed in the condition.
	/*
	IF ai_screen_id = 61 THEN
	*/
	IF ai_screen_id = 61 or ai_screen_id = 33 THEN
	
	//---------------------------- APPEON END ----------------------------
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			//ls_key_fields_col_nm[li_key_cnt] = "facility_id" Fixed By Jervis 03/16/2007 is seq_no not facility_id
			ls_key_fields_col_nm[li_key_cnt] = "seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 03/16/2007 By: Jervis
		//$<reason> Fixed a defect
		if PosA(ls_sql_syntax,"seq_no",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "seq_no"
			end if
		end if
		//---------------------------- APPEON END ----------------------------
	END IF	
		
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/16/2007 By: Jervis
//$<reason> Fixed a defect
integer li_row_cnt_new
li_row_cnt_new = UpperBound(ls_field_names)	
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	//FOR i = 1 TO li_row_cnt	03/16/2007
	For i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	//FOR i = 1 TO li_row_cnt	03/16/2007
	for i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//CREATE SORT ORDER code moved to top of function //maha 051905

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
else
	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
END IF

//CREATE SYNTAX FOR DETAIL DW
ls_grey = "80269524"//String(rgb(192,192,192))
ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=" + ls_grey + ")"  
//ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=0)"  //testing
//openwithparm( w_sql_msg, ls_sql_syntax )

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<add> 01.13.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.
If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			CONTINUE
		END IF
		/*
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
		*/
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		//--> Begin change Editmask 
			IF ls_dw_field_names[i] <> "active_status" THEN
				IF ls_mask[i] <> "" THEN
					IF ls_mask[i] = "##" THEN
					ELSEIF ls_mask[i] = "(###)###-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='(###)###-####'"
						Li_appeon_index2 ++				//Comment by Scofield on 2008-08-12
					ELSEIF ls_mask[i] = "###-##-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='###-##-####'"
						Li_appeon_index2 ++
					ELSEIF ls_mask[i] = "#####-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='#####-####'"
						Li_appeon_index2 ++
					END IF
				END IF	
			END IF
			//--< end change Editmask 
	END FOR
	
	//specail code for pd_address
	IF ls_table_name = "pd_address" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	of_change_to_editmask(ls_dwsyntax_str, ls_editmask_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)

		RETURN "-1"
	END IF
End If

//	//---------------------------- APPEON END ----------------------------	
//	
//END IF
	


	adw_detail.SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()


IF li_prac_row_cnt = 0 THEN 
	return "NONE"
	//Start Code Change ---- 06.09.2006 #531 maha
	
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

//debugbreak()
IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	//FOR i = 1 TO li_row_cnt		03/16/2007
	For i = 1 to li_row_cnt_new
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
	next
	//03/16/2007 
	For i = 1 to li_row_cnt
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" then //maha 041404 to allow single fields to be read only
			//messagebox("display only",ls_dw_field_names[i])
			adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //set below
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
		end if
	END FOR
END IF
//debugbreak()
//IF ib_create_browse THEN
//	adw_detail.ShareData(adw_browse)
//END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
//ll_max_height = ll_max_height + 50 
////adw_detail.Object.DataWindow.Detail.Height= 5000 //maha moved to end
//adw_detail.Object.DataWindow.Detail.Height= ll_max_height
adw_detail.Modify("active_status.Initial='1'")
//messagebox("cash",ids_screen_fields.rowcount())
//messagebox("field names",string(upperbound(ls_dw_field_names[])))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Pervformance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 
		END IF
	END IF

	IF ab_screen_painter THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-07
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> The "dbname" property is readonly on the Web after migration.
		//$<modification> In order to make the functionality the same to that in PowerBuilder, 
		//$<modification> change it to the writable TabSequence property
		//adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		//adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String( i * 10) + "'" )
		//---------------------------- APPEON END ----------------------------
	ELSE
		
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" then //maha 041404
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
			adw_detail.Modify( ls_dw_field_names[i] + ".border = '2'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
//	IF ib_create_browse THEN
//		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
//	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

//	IF ib_create_browse THEN
//		IF li_fld_width < li_fld_label_width THEN
//			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
//		ELSE
//			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
//		END IF
//	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

//	IF ib_create_browse THEN
//		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
//		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
//	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						


	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			

			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")

			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		


			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")

			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2007.08.11 By: Jack
				//$<reason> Fix a defect.	
				
				/*
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 09.07.2006 By: Liang QingShi
				//$<reason> Fix a defect.
				/*
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				*/
				
				IF appeongetclienttype() = 'PB' THEN
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
					END IF
				ELSE
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")						
					END IF
				END IF
				//---------------------------- APPEON END ----------------------------
				*/
				
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
//				IF ib_create_browse = True THEN								
//					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
//				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")

		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )




		res = of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		if res < 0 then messagebox("","dwchild retrieve failed")
//		dwchild.ShareData( dwchild_browse )
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
//				IF ib_create_browse = True THEN				
//					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
//				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
//				IF ib_create_browse = True THEN								
//					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
//				END IF
			END IF
		END IF	
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-34
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label.

gnv_appeondb.of_commitqueue()
//If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)
//---------------------------- APPEON END ----------------------------


//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()
// messagebox("li_row_cnt",li_row_cnt)
 // messagebox("cols",cc)
  // messagebox("fields",wer)
//if  ib_create_browse = True then
//	for i = 1 to li_row_cnt//ids_screen_fields.rowcount()
//		adw_browse.Modify( ls_field_names[i] + ".TabSequence = '0'" )
//	next
//end if

//clipboard(adw_detail.Describe("datawindow.syntax"))
FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
//	IF ib_create_browse = True THEN					
//		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
//		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
//	END IF
END FOR

//IF NOT ab_screen_painter THEN
//	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
//	adw_detail.of_SetReqColumn(TRUE)
//END IF

//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

//adw_detail.SetRedraw(True)

adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-08-31 By: Liu HongXin
			//$<reason> 
			/*
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")" )
			*/
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			//---------------------------- APPEON END ----------------------------

	END CHOOSE
END FOR
//Start Code Change ---- 01.18.2006 #203 maha
IF ls_table_name = "pd_address" or ls_table_name = "dba.pd_address" THEN //maha 011806
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
	set1 = of_get_app_setting("set_1","I")

	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
//		des = dwchild.Describe("DataWindow.Objects")
//			openwithparm(w_sql_msg,des)
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" THEN //maha 011806
//End Code Change---01.18.2005 
	li_set = of_get_app_setting("set_5","I")
	if li_set = 0 then
		//messagebox("","ref button")
		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
	end if
end if
//\maha

IF li_prac_row_cnt = 0 THEN 
//	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if
//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ll_max_height)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
//of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
//of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
//---------------------------- APPEON END ----------------------------
//if ab_screen_painter = true then adw_detail.hscrollbar = true


RETURN ls_return_syntax
end function

public function integer of_app_audit_date_reset (long ai_app_stat_recid, long ai_prac);////Start Code Change ----03.20.2008 #V8 maha - created to reset App audit complete date when missinng items are added.
//of_app_audit_date_reset(ll_appt_stat_id,il_prac_id)
update pd_affil_stat set date_app_audit_completed = null where rec_id = :ai_app_stat_recid;
commit using sqlca;

return 1

end function

public function integer of_detail_preupdate (u_dw adw_detail);//Start Code Change ----08.04.2008 #V85 maha - this function added to this object to be called from 
//prac folder DE; action items, batch add insurance
//not completed

String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  //#1 maha 101606
long ll_templ_id[ ]  //#1 maha 101606
long ll_verif_response  //#1 maha 101606  completion response code for verif; if 0 will not be completed.
long li_seq_no
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
long li_found
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year //maha031601
integer li_month//maha031601
integer li_validate//maha080803
integer li_res //maha 032406
integer li_complete[ ] //#1 maha 101606
integer li_auto_gen[ ] //#1 maha 101606
integer li_app_audit_facil //#1 maha 101606
integer li_appt_stat //#1 maha 101606
integer li_temp_cnt //#1 maha 101606
integer li_status = 1 //maha 080108
string ls_use_as_ver //#1 maha 101606
integer t  //#1 maha 101606
string ls_app_type //#1 maha 101606
string ls_mess //#1 maha 101706
string ls_type1//maha102501
string ls_type2//maha102501
string ls_type3//maha102501
DataWindowChild dwchild
n_ds lds_aa_template //#1 maha 101606
Long ll_new_cnt //Added By Ken.Guo 03.31.2008
Long ll_rec_id_new //Added By Ken.Guo 05.29.2008. Replace il_rec_id
n_ds ids_parent_facilities

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Define several variable for checking if value in exp_field changed.

DateTime ldt_exp_date_original
Long ll_rec_id_changed[]

//---------------------------- APPEON END ----------------------------

//SetNull( ldt_null_date )
//
//adw_detail.AcceptText()
//
//li_rec_count = adw_detail.RowCount()
//
////IF li_rec_count < 1 THEN
////	IF ib_deleting THEN
////		RETURN 1
////	ELSE
////		RETURN -1
////	END IF
////END IF
//
////SetRedraw( False )
//
//
////il_last_de_row = adw_detail.GetRow()
//
//li_data_cr = adw_detail.GetRow()
//
////ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
////ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
////ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
//
////ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")//maha102501
////ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")//maha102501
////ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")//maha102501
//
////ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
////
////li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
////ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
////
////li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-23
////$<modify> 03.01.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Write script to retrieve data from a cache instead of from the database.
///*
//select count(field_id) into :li_validate from sys_fields where table_id = :li_table_id and use_validation > 0; //maha 072304 see if ay fields need validation 
//*/
//li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))
////---------------------------- APPEON END ----------------------------
//
////li_validate = dw_select_section.GetItemnumber( il_last_row, "sys_fields_use_validation")
//
//
////select set_31 into :li_validate from icred_settings; maha changed use of variable in v4.5 072304
//
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-30
////$<add> 03.16.2006 By: Liang QingShi
////$<reason> Performance tuning
////$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
////$<modification> value into database.
//ll_new_cnt = 0
//FOR i = 1 TO li_rec_count
//	IF adw_detail.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
//		ll_new_cnt++
//	End IF
//END FOR
//If ll_new_cnt > 0 Then
//	ll_rec_id_new = gnv_app.of_Get_Id("RECORD_ID" , ll_new_cnt) - 1
//	If ll_rec_id_new < 0 Then //Added By Ken.Guo 04.24.2008.
//		Messagebox('Error','Failed to get Record_ID value, Please call support.')
////		SetRedraw( True ) 
//		Return -1
//	End If
//End If
////---------------------------- APPEON END ----------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-25
////$<add> 2006-04-11 By: owen chen
////$<reason> Performance tuning modification
////$<modification> Use ids_parent_facilities to retrive all data
////$<modification> to be used by pfc_cst_u_data_entry. 
// 
//ids_parent_facilities = CREATE n_ds
//ids_parent_facilities.DataObject = "d_address_link_parent_facility_id"
//ids_parent_facilities.of_SetTransObject( SQLCA )
//ids_parent_facilities.Retrieve( il_prac_id )
//
////---------------------------- APPEON END ----------------------------
////@@@@@@@@
////Start Code Change ---- 10.25.2006 #1 maha  getting values for app audit creation
//ids_parent_facilities.setfilter("parent_facility_id = " + string(ii_parent_facility_id) + " and active_status in (1,4)")
//ids_parent_facilities.filter()
//li_app_audit_facil =  ids_parent_facilities.rowcount()
////select count(rec_id) into :li_app_audit_facil from pd_affil_stat where prac_id = :il_prac_id and parent_facility_id = :ii_parent_facility_id and active_status in (1,4);
//if li_app_audit_facil > 1 then
//	li_app_audit_facil = -1 //trap if there is improper data
//elseif li_app_audit_facil = 1 then //normally should be one
//	//get the template items for the screen
//	lds_aa_template = CREATE n_ds
//	lds_aa_template.DataObject = "d_app_audit_by_facility_screen"
//	lds_aa_template.of_SetTransObject( SQLCA )
//	ls_app_type = ids_parent_facilities.getitemstring(1,"apptmnt_type")
//	li_app_audit_facil = ids_parent_facilities.getitemnumber(1,"application_audit_facility")
//	ll_appt_stat_recid = ids_parent_facilities.getitemnumber(1,"rec_id")
//	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ii_screen_id,ls_app_type)
//	if li_temp_cnt < 1 then
//		li_auto_gen[i] = 0
//		li_complete[i] = 0
//		ls_use_as_ver = "N"
//		ll_verif_response = 0
//	else //WHAT ABOUT MULTIPLES?
//		for i = 1 to li_temp_cnt  //get each auto gen item
//			ll_templ_id[i] = lds_aa_template.getitemnumber(i,"app_audit_id")
//			li_auto_gen[i] = lds_aa_template.getitemnumber(i,"auto_generate")
//			if isnull(li_auto_gen[i]) then li_auto_gen[i] = 0
//			li_complete[i] = lds_aa_template.getitemnumber(i,"receive_from_de")
//			if isnull(li_complete[i]) then li_complete[i] = 0
//			if ls_use_as_ver <> "Y" then //if not already set to use as verification
//				ls_use_as_ver = lds_aa_template.getitemstring(i,"use_as_verification")
//				if isnull(ls_use_as_ver) then ls_use_as_ver = "N"
//			end if
//			if ll_verif_response = 0 or isnull(ll_verif_response) then //get response code if not set
//				ll_verif_response = lds_aa_template.getitemnumber(i,"default_ver_response_code")
//				if isnull(ll_verif_response) then ll_verif_response = 0
//			end if
//		next
//		if ls_use_as_ver = "Y" then
//			ls_mess = "Y"
//		else
//			ls_mess = "N"
//		end if
//		ls_mess = ls_mess +  "*" +string(ll_verif_response )
//	end if
//end if
////w_app_audit_complete_mes
//ids_parent_facilities.setfilter("") //reset the filter
//ids_parent_facilities.filter()
////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
////End Code Change---10.25.2006
//
//FOR i = 1 TO li_rec_count
//	//debugbreak()			
//	SetNull( ll_address_code )
//	IF adw_detail.GetItemStatus( i, 0, Primary!) <> NewModified! AND +&
//		adw_detail.GetItemStatus( i, 0, Primary!) <> DataModified! THEN
//		CONTINUE
//	ELSEIF adw_detail.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
//		ls_rec_status = "New"
//		//messagebox("", "dw_detail1")
//		//if li_validate > 0 then //if one or more fields uses validation  //Start Code Change ---- 10.02.2006 #634 maha  removed
////			if of_validate(li_table_id,i) < 0 then  //Start Code Change ----06.16.2008 #V81 maha - moved to pfc_validation
////				SetRedraw( True )
////				RETURN -1
////			end if
//		//end if
//		ll_rec_id_new ++
//
//		adw_detail.SetItem( i, "prac_id", il_prac_id)
//		IF li_screen_id = 61 or li_screen_id = 32 or li_screen_id = 33 THEN		
//			SELECT pd_affil_stat.rec_id  
//    		INTO :ll_rec_id_new  
//    		FROM pd_affil_stat  
//   		WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
//         		( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) AND  
//         		( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
//			IF SQLCA.SQLCODE = -1 THEN
//				MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
//				Return -1
//			END IF
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 05/05/2008 By: Ken.Guo
//			//$<reason> Fix BugK050504.Duplicate PK when save staff category data.
//			//li_seq_no = inv_data_entry.of_get_next_seq_no( "department", il_rec_id )
//			Choose Case li_screen_id
//				Case	32 //Depart/Div/Section
//					li_seq_no = of_get_next_seq_no( "department", ll_rec_id_new )
//				Case	33 //Staff Category
//					li_seq_no = of_get_next_seq_no( "staff cat", ll_rec_id_new )
//				Case	61 //No this screen id in DB???
//					li_seq_no = of_get_next_seq_no( "department", ll_rec_id_new )
//			End Choose
//			//---------------------------- APPEON END ----------------------------
//
//			li_seq_no++
//			adw_detail.SetItem( i, "seq_no", li_seq_no )				
//			adw_detail.SetItem( i, "rec_id", ll_rec_id_new )			
//		ELSE
//			adw_detail.SetItem( i, "rec_id", ll_rec_id_new )			
//		END IF
//		IF li_screen_id = 2 then //Upper(ls_screen_name) = "ADDRESS" THEN
////			of_add_address_link( ll_rec_id_new )
//		elseIF ii_screen_id = 10 THEN		// "HOSPITAL AFFILIATION"
////			of_add_hosp_link( ll_rec_id_new )
//		elseIF ii_screen_id = 19 THEN			//"BOARD/SPECIALTY"
////			of_add_spec_link( ll_rec_id_new )
//		END IF
//		
//	ELSE
//		ls_rec_status = "Modified"
//		//if li_validate > 0 then //maha 080803 for LIJ
////			if of_validate(li_table_id,i) < 0 then //Start Code Change ---- 10.02.2006 #633 maha  removed
////				SetRedraw( True )
////				RETURN -1
////			end if
//		//end if
//	END IF
//	
//	ll_rec_id = adw_detail.GetItemNumber( i, "rec_id" )
//	
////	IF Upper(ls_screen_name) = "LICENSURE" OR +&
////		Upper(ls_screen_name) = "INSURANCE" OR +&
////		Upper(ls_screen_name) = "DEA REGISTRATION" THEN
//	IF ii_screen_id = 4 OR ii_screen_id = 15 OR ii_screen_id = 5 THEN
//		IF adw_detail.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
//			IF adw_detail.GetItemNumber( i, "active_status" ) = 0 THEN
//				if ls_rec_status = "New" then
//					CONTINUE
//				else				//\/maha 031601
//					update verif_info
//					set active_status = 0
//					where rec_id = :ll_rec_id and active_status = 1;
//					continue		 //\maha
//				end if
//			END IF
//		END IF
//	END IF	
//	
//	//\/maha 031601 get month and year end for check back date passed in verification add
//	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
//		if adw_detail.Describe("year_thru.ColType") <> "!" then
//			li_year = adw_detail.getitemnumber(i,"year_thru")
//			if adw_detail.Describe("month_thru.ColType") <> "!" then
//				li_month = adw_detail.getitemnumber(i,"month_thru")
//			end if
//			//maha added to using full end date field
//		elseif adw_detail.Describe("end _date.ColType") <> "!" then
//			li_year = year(date(adw_detail.getitemdatetime(i,"end_date")))
//				li_month = month(date(adw_detail.getitemdatetime(i,"end_date")))
//		end if
//	end if
//	//\maha
//	
//	
//	//jad 05/30/01 added to make any screen facility specific
//
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-27
//	//$<modify> 03.01.2006 By: LeiWei
//	//$<reason> Performance tuning
//	//$<modification> Write script to retrieve data from a cache instead of from the database.
//
//	/*	
//	
//		SELECT sys_tables.facility_specific  
//		INTO :li_facility_specific  
//		FROM sys_tables  
//		WHERE sys_tables.table_id = :li_table_id   ;
//				
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Error", SQLCA.SQLERRTEXT )
//		END IF
//	*/
//	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
//	//---------------------------- APPEON END ----------------------------
//
//	IF li_screen_id = 19 THEN //specialty
//		IF IsNull( adw_detail.GetItemNumber( i, "board_code" ) ) THEN
//			CONTINUE
//		  //Start Code Change ---- 10.26.2007 #V7 maha	
//		ELSE
//			ll_address_code = adw_detail.GetItemNumber( i, "board_code" ) 
//			IF ls_rec_status = "Modified" THEN
//		//ELSEIF ls_rec_status = "Modified" THEN
//				SELECT count(*)  
//				INTO :li_cnt  
//						FROM verif_info  
//						WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
//							( verif_info.active_status = 1 )   ;
//				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
//					ls_rec_status = "New"
//				END IF
//			end if //modified
//			//End Code Change---10.26.2007
//		END IF
//	//jad 05/30/01 added to make any screen facility specific
//	ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
//	//ELSEIF li_screen_id = 21 OR li_screen_id = 26 THEN //attest quest or group cov
//	//ELSEIF li_screen_id = 21 OR li_screen_id = 26 THEN //attest quest or group cov
////		IF li_screen_id = 61 THEN //had been removed in version 3.75 but didn't make it to 4 removed again 061604 for v4.187 maha
////			adw_detail.SetItem( i, "facility_id", 1 )		
////		ELSE
//			if adw_detail.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
//				adw_detail.SetItem( i, "facility_id", ii_parent_facility_id )	
//			end if	
////		END IF
//	END IF
//	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
//		adw_detail.ScrollToRow( i )
//		adw_detail.SetRow( i )
//
//		//move expiration date to verif info table if there is one
//		IF Len(ls_exp_field) > 0 THEN
//			IF ls_exp_field = "certification_expires" THEN	
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 05.25.2007 By: Jack
//				//$<reason> Fix a defect.
//				/*
//				ldt_exp_date = DateTime(Date( "12-30-" + String( adw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())//maha changed 080101
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<add> 2006-10-11 By: Rodger Wu (Inova)
//				//$<reason> Get Original value of exp_field.
//				ldt_exp_date_original = DateTime(Date( "12-30-" + String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) ),Now())
//				//---------------------------- APPEON END ----------------------------
//				*/				
//				ldt_exp_date = DateTime(Date( String( adw_detail.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
//				ldt_exp_date_original = DateTime(Date( String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
//				//---------------------------- APPEON END ----------------------------
//				//ldt_exp_date = DateTime(Date( "1-1-" + String( adw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())
//			ELSEIF ls_exp_field = "cert_expiration_year" THEN
//				li_month = adw_detail.GetItemNumber( i, "cert_expiration_month" )
//				if isnull(li_month) then
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<modify> 05.25.2007 By: Jack
//					//$<reason> Fix a defect.
//					/*
//					ldt_exp_date = DateTime(Date( "12-30-" + String( adw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())//maha 061402 fo spec. certs
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<add> 2006-10-11 By: Rodger Wu (Inova)
//					//$<reason> Get Original value of exp_field.
//					ldt_exp_date_original = DateTime(Date( "12-30-" + String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) ),Now())
//					//---------------------------- APPEON END ----------------------------
//					*/
//					ldt_exp_date = DateTime(Date( String( adw_detail.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
//					ldt_exp_date_original = DateTime(Date( String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
//					//---------------------------- APPEON END ----------------------------
//				else
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<modify> 05.25.2007 By: Jack
//					//$<reason> Fix a defect.
//					/*
//					ldt_exp_date = DateTime(Date(String(li_month) + "-28-" + String( adw_detail.GetItemNumber( i, ls_exp_field ) ) ),Now())
//
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<add> 2006-10-11 By: Rodger Wu (Inova)
//					//$<reason> Get Original value of exp_field.
//					ldt_exp_date_original = DateTime(Date(String(li_month) + "-28-" + String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) ),Now())
//					//---------------------------- APPEON END ----------------------------
//					*/
//					ldt_exp_date = DateTime(Date(String( adw_detail.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
//					ldt_exp_date_original = DateTime(Date(String( adw_detail.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-" + String(li_month) + "-28"),Now())
//					//---------------------------- APPEON END ----------------------------
//				end if
//			ELSE
//				//Start Code Change ---- 03.24.2006 #341 maha  trap for invisible field
//				if adw_detail.Describe(ls_exp_field + ".ColType") <> "!" then
//					ldt_exp_date = adw_detail.GetItemDateTime( i, ls_exp_field )
//
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<add> 2006-10-11 By: Rodger Wu (Inova)
//					//$<reason> Get Original value of exp_field.
//					ldt_exp_date_original = adw_detail.GetItemDateTime( i, ls_exp_field, Primary!, True )
//					//---------------------------- APPEON END ----------------------------
//				else
////					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
//					return -1
//				end if
//			END IF
//		ELSE
//			ldt_exp_date = ldt_null_date
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 2006-10-11 By: Rodger Wu (Inova)
//			//$<reason> Get Original value of exp_field.
//			SetNull( ldt_exp_date_original )
//			//---------------------------- APPEON END ----------------------------
//			
//		END IF
//	
//		//get reference 1 data 
//		
//		if adw_detail.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
//			messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
//			return 1
//		end if
//		li_retval = adw_detail.SetColumn( ls_ref_1 )
//		IF li_retval = 1 THEN
////			IF IsNull( adw_detail.object. ) OR GetText() = "" THEN
////				SetRedraw( True )
////				//MessageBox( "Required", "The reference field " + ls_ref_1 + " is required." )
////				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
////				Return -1
////			END IF
//			li_retval = adw_detail.GetChild(ls_ref_1, dwchild)
//			IF li_retval = -1 THEN
//				ls_reference =  adw_detail.GetText()				
//			ELSE
//				adw_detail.SetColumn( ls_ref_1 )
//				li_found = dwchild.Find( "lookup_code = " + adw_detail.GetText(), 1, 100000 )	
//				//messagebox("li_found",li_found)
//				IF adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
//					ls_reference = dwchild.GetItemString( li_found, "code" )
//
//					//IF ls_screen_name = "Licensure" THEN
//					IF ii_screen_id = 4 THEN					
//						if adw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
//	//						of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
//							//messagebox("Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter")
//							return -1
//						else
//							ll_address_code = adw_detail.GetItemNumber( i, "verifying_agency" )
//						end if
//					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
//						//do nothing, got the address code further up
//					ELSE
//						if ls_type1 = "C" then //maha 050802 
//							ll_address_code = long(adw_detail.GetItemstring( i, ls_ref_1 ))//maha 072501
//						elseif ls_type1 = "N" then //maha 050802
//							ll_address_code = adw_detail.GetItemNumber( i, ls_ref_1 )
//						end if
//					END IF
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 03/16/2007 By: Jervis
//				//$<reason> PB:entity_name,APB WEB:entity_name_original ,
//				//				pfc_cst_nv_data_entry_functions.of_create_dynamic_dw line 840 modified by Liang QingShi,i don't know why.
//				/*
//				ELSEIF adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" THEN
//				*/
//				//---------------------------- APPEON END ----------------------------
//				ELSEIF adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
//					if adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
//						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
//					else
//						ls_reference = dwchild.GetItemString( li_found, "entity_name" )
//					end if
//					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
//						ll_address_code = long(adw_detail.GetItemstring( i, ls_ref_1 ))//maha 072501
//					elseif ls_type1 = "N" then //maha 102501
//						ll_address_code = adw_detail.GetItemNumber( i, ls_ref_1 )
//					end if
//				ELSEIF adw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
//					ls_reference = dwchild.GetItemString( li_found, "description" )
//					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
//					IF ii_screen_id = 4 THEN					
//						if adw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
////							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
//							//messagebox("Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter")
//							return -1
//						else
//							ll_address_code = adw_detail.GetItemNumber( i, "verifying_agency" )
//						end if
//					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
//						//do nothing, got the address code further up
//					ELSE
//						if ls_type1 = "C" then //maha 050802 
//							ll_address_code = long(adw_detail.GetItemstring( i, ls_ref_1 ))//maha 072501
//						elseif ls_type1 = "N" then //maha 050802
//							ll_address_code = adw_detail.GetItemNumber( i, ls_ref_1 )
//						end if
//					END IF
//					//End Code Change---10.10.2007
//				ELSE
//					ls_reference = adw_detail.GetText()			
//				END IF
//			END IF
//		ELSE
//			ls_reference = ""
//		END IF
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03.01.2006 By: LeiWei
//		//$<reason> Fix a defect.
//		If NOT Isnull(ls_ref_2) THEN
//		//---------------------------- APPEON END ----------------------------
//
//		//get reference 2 data
//		if adw_detail.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
//			messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
//			return 1
//		end if
//		li_retval = adw_detail.SetColumn( ls_ref_2 )
//		IF li_retval = 1 THEN
////			IF IsNull( GetText() ) OR GetText() = "" THEN
//	//			SetRedraw( True )
//		//		//MessageBox( "Required", "The reference field " + ls_ref_2 + " is required." )				
//			//	of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
////				Return -1
//				//End Code Change---03.24.2006
////			END IF		
//			li_retval = adw_detail.GetChild(ls_ref_2, dwchild)
//			IF li_retval = -1 THEN
//				ls_reference = ls_reference + " - " + adw_detail.GetText()				
//			ELSE
//				adw_detail.SetColumn( ls_ref_2 )
//				li_found = dwchild.Find( "lookup_code = " + adw_detail.GetText(), 1, 100000 )
//				if li_found > 0 then //trap added maha 021704
//					IF adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
//						ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
//					ELSEIF adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
//						ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<modify> 03/16/2007 By: Jervis
//					//$<reason> PB:entity_name,APB WEB:entity_name_original ,
//					//				pfc_cst_nv_data_entry_functions.of_create_dynamic_dw line 840 modified by Liang QingShi,i don't know why.
//					/*
//					ELSEIF adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" THEN
//					*/
//					//---------------------------- APPEON END ----------------------------
//					ELSEIF adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
//						if adw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
//							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
//						else
//							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
//						end if
//					ELSE
//						ls_reference = ls_reference + " - " + adw_detail.GetText()
//					END IF
//				else
//					ls_reference = ls_reference + " - " + ""
//				end if
//			END IF
//		ELSE
//			ls_reference = ls_reference + " - " + ""
//		END IF
//		
//		ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03.01.2006 By: LeiWei
//		//$<reason> Fix a defect.
//		END IF
//		//---------------------------- APPEON END ----------------------------
////@@@@@
//
//		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
//		if adw_detail.Describe("active_status.ColType") <> "!" then
//			li_status = adw_detail.getitemnumber(li_data_cr,"active_status")
//		end if
//		//End Code Change---08.01.2008
//		//Start Code Change ---- 10.26.2006 #1 maha
//		IF ls_rec_status = "Modified" THEN
////			parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_update_reference( ls_reference,  ll_rec_id, ll_address_code,  ldt_exp_date , li_screen_id,li_status)  //Start Code Change ----04.22.2008 #V8 maha - added screen id argument ; 08.01.2008 added li_status argument
//			of_app_audit_update_ref( il_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 2006-10-11 By: Rodger Wu (Inova)
//			//$<reason> 
//			IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
//				( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
//				( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
//				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
//			END IF
//			//---------------------------- APPEON END ----------------------------
//		ELSE  //new
//			for t = 1 to li_temp_cnt //check to see if completion is desired
//				if li_complete[t] = 1 then 
//					openwithparm(w_app_audit_complete_mes,  ls_mess) //asks user to complete and gets response code 
//					ls_mess = message.stringparm
//					if mid(ls_mess,1,1) = "N" then 
//						li_complete[t] = 0
//						ll_verif_response = 0
//					else //yes
//						ll_verif_response = long(mid(ls_mess,3))
//					end if	
//				else //Start Code Change ---- 05.09.2007 #V7 maha trap so verif does not get completed
//					li_complete[t] = 0
//					ll_verif_response = 0
//				end if
//				if li_auto_gen[t] = 1 then  //Start Code Change ---- 05.09.2007 #V7 maha only create if set to auto gen
//					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,il_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )
//				end if
//			next
//			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
//			IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_record( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status) = -1 THEN  //Start Code Change ----.2008 #V85 maha - added li_status argument
//					Return -1
//					messagebox("Error","Error adding verification")
//				end if
//			END IF
//			parent_window.ib_app_audit_retrieved = false //Start Code Change ---- 10.30.2006 #1 maha
//		//End Code Change---10.26.2006
////@@@@@
//
//	END IF
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 10.12.2006 By: Jack (Inova)
//	//$<reason> Queue Images for Scanning from Data Entry.
//	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
//	if ls_rec_status = "New" then
//		ll_de_queue = long(gnv_data.of_getitem('image_type','de_queue','link_to_screen = ' + string(li_screen_id)))
//	//ll_de_queue = 0 //maha changed because it was not working properly
//		if ll_de_queue = 1 then
//			ll_image_type_id = long(gnv_data.of_getitem('image_type','image_type_id','link_to_screen = ' + string(li_screen_id)))
//			ll_default_pages = long(gnv_data.of_getitem('image_type','default_pages','link_to_screen = ' + string(li_screen_id)))
//
//			ll_row = ids_image_data.insertrow(0)
//			
//			SELECT Max( seq_no )  
//			INTO :ll_seq_no  
//			FROM pd_images  
//			WHERE pd_images.rec_id = :ll_rec_id ;
//			
//			IF IsNull( ll_seq_no ) THEN
//				ll_seq_no = 0
//			END IF
//			ll_seq_no++
//			ids_image_data.SetItem( ll_row, "image_type_id", ll_image_type_id )
//			ids_image_data.SetItem( ll_row, "prac_id", il_prac_id )
//			ids_image_data.SetItem( ll_row, "seq_no", ll_seq_no )
//			ids_image_data.SetItem( ll_row, "rec_id", ll_rec_id  )
//			ids_image_data.SetItem( ll_row, "facility_id", ii_parent_facility_id  )	
//			ids_image_data.SetItem( ll_row, "screen_id", li_screen_id )	
//			ids_image_data.SetItem( ll_row, "reference_name", ls_reference )
//			ids_image_data.SetItem( ll_row, "active_status", 1 )	
//			ids_image_data.SetItem( ll_row, "num_pages", ll_default_pages )
//			ids_image_data.SetItem( ll_row, "tif_start_page", 1 )
//			ids_image_data.SetItem( ll_row, "de_queue", 0 )
//		end if
//	end if
//	//---------------------------- APPEON END ----------------------------
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 10.17.2006 By: Jack (Inova)
////Start Code Change ---- 10.26.2006 #1 maha  removed .  not using
//	//$<reason> Required Documents Check Box on Data Entry Screen.
////	long ll_prac_id[]
////	long li_rec_id[]
////	ll_prac_id[1] = il_prac_id
////	li_rec_id[1] = ll_rec_id
//////	inv_data_entry.of_create_application_audit_record(ls_rec_status,ll_prac_id,li_screen_id,li_rec_id,ls_reference)
////End Code Change---10.26.2006
//	//---------------------------- APPEON END ----------------------------
//END FOR
//
//adw_detail.ScrollToRow( li_data_cr )
//adw_detail.SetRow( li_data_cr )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 06/03/2008 By: Ken.Guo
////$<reason> Fix issue. After save address data, address link data disappear.
//if li_data_cr > 0 then
//	il_rec_id = adw_detail.GetItemNumber( li_data_cr, "rec_id" )
//end if
////---------------------------- APPEON END ----------------------------
//
//adw_detail.BringToTop = True
//of_get_record_verif( li_data_cr )
//
////IF is_screen_name = "Hospital Affiliation" or is_screen_name = "Address"  then //\/maha 082101 
////if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
//IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19  then
//	dw_link_list.bringtotop = True
//end if
//
//adw_detail.SetRedraw( True )
//
//dw_detail.SetColumn( is_first_column_detail_1 )
//
//dw_detail.SetFocus()
//
////debugbreak()
//inv_data_entry.of_field_audit( This )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-26
////$<modify> 2006-04-11 By: owen chen
////$<reason> Performance tuning modification
////$<modification> 1)Modify the script in the pfc_Save from PT-28.
////$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_startqueue( )
//
//IF ids_parent_facilities.rowcount( ) > 0 THEN
//	dw_link_list.Update()
//	dw_link_list.Retrieve( il_rec_id )
//END IF
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.12.2006 By: Jack (Inova)
////$<reason> Queue Images for Scanning from Data Entry.
//ids_image_data.update()
////---------------------------- APPEON END ----------------------------
//
//gnv_appeondb.of_commitqueue( )
//
//DESTROY ids_parent_facilities
//
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-10-11 By: Rodger Wu (Inova)
////$<reason> Automatically poping up Verification Update window once
////$<reason> value in exp_field changed.
//
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
////	ls_sql_where = " AND security_user_facilities.user_id = '" + gs_user_id + "' " + &
////						" AND pd_affil_stat.prac_id = " + string( il_prac_id ) + &
////						" AND verif_info.screen_id = " + string( li_screen_id )
////												
//	FOR i = 1 TO li_cnt
//		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
//	NEXt
////	ls_rec_id_str = Left( ls_rec_id_str, Len( ls_rec_id_str ) - 2 )
////	ls_sql_where += " AND verif_info.rec_id in ( " + ls_rec_id_str + " ) "
////
//	lds_verify = Create n_ds
//	lds_verify.DataObject = "d_verification_facility_de_update_maha"
//	lds_verify.SetTransObject( SQLCA )
//	
////	ls_sql_original = lds_verify.Describe( "Datawindow.Table.Select" )
////	ls_sql_original += ls_sql_where
//	
////	lds_verify.Modify( 'Datawindow.Table.Select = "' + ls_sql_original + '"' )
//
//	//IF lds_verify.Retrieve() > 0 THEN
//	//	IF MessageBox( "IntelliSoft", "Do you want to update the verification(s)?", Question!, YesNo!, 1 ) = 2 THEN Return 1;
//		
//		lstr_verif.sql_syntax = ""//ls_sql_original
//		lstr_verif.al_prac_id = il_prac_id
//		lstr_verif.al_screen_id = li_screen_id
//		lstr_verif.al_rec_id = ll_rec_id_changed
//		
//		OpenwithParm( w_verification_de_update, lstr_verif )
//	///END IF
//END IF
//
////---------------------------- APPEON END ----------------------------
//
RETURN 1

end function

public function integer of_dwchild_retrieve (string as_lu_table, string as_type, datawindowchild adw_dw, string as_from, long al_value, string as_column_nm);//created maha 060805 to add search item in each lookup.  Called from of_create_dynamic_dw and the date entry user object of_lookup_function
//debugbreak()
//Start Code Change ---- 12.15.2005 #171 maha
//works for all dropdowns except insurance carrier??????
long ll_val
datawindowchild dwchild
long ll_find
long ert
//debugbreak()
long ll_ret
ll_ret=adw_dw.GetChild( as_column_nm, dwchild )
adw_dw.settransobject(sqlca)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-65
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
/*
if as_from = "RET" and as_type = "A" then //when treturning from search refresh cache for address lookups
	ert = app_filler.ids_address_dddw.Retrieve()
	//messagebox("",ert)
end if
*/
//---------------------------- APPEON END ----------------------------

IF as_type = "C" THEN
	choose case as_lu_table
		case "Address Type", "Yes/No","Specialty Order"
			//exceptions
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-66
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> After Appeon's modification, the ids_address_dddw cache is no longer used in IntelliCred.
			/*
			dwchild.retrieve(as_lu_table)
			*/
			gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(as_lu_table)+"'",dwchild)
			//---------------------------- APPEON END ----------------------------
		case else
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-67
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> After Appeon's modification, the ids_address_dddw cache cache is no longer used in IntelliCred.
			/*
			dwchild.retrieve(as_lu_table)
			*/
			gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(as_lu_table)+"'",dwchild)
//			//---------------------------- APPEON END ----------------------------
//			dwchild.InsertRow(1)
//			dwchild.setitem(1,"code",'-SEARCH/Add-')
//			dwchild.setitem(1,"lookup_code",-777)
//			dwchild.setitem(1,"description","-Search/Add for " + as_lu_table +" -")
	end choose
ELSEIF as_type = "A" THEN
	//debugbreak()
	if dwchild.Describe("entity_name_original.ColType") <> "!" then
		//messagebox("1",string(dwchild.rowcount()))
		//--------------------------- APPEON BEGIN ---------------------------
		////$<ID> PT-68
		//$<modify> 01.17.2006 By: Cao YongWang
		//$<reason> After Appeon's modification, the ids_address_dddw cache cache is no longer used in IntelliCred.
		//app_filler.ids_address_dddw.ShareData( dwchild )
		//dwchild.SetFilter( "lookup_name = '" + as_lu_table + "'" )
		//dwchild.Filter()
		dwchild.retrieve(as_lu_table)

		//---------------------------- APPEON END ----------------------------
//		
//		dwchild.InsertRow(1)
//		//messagebox("2",string(dwchild.rowcount()))
//		dwchild.setitem(1,"code",'-SEARCH/ADD-')
//		dwchild.setitem(1,"lookup_code",-888)
//		dwchild.setitem(1,"entity_name_original","-Search/Add for " + as_lu_table +" -")
//		dwchild.setitem(1,"entity_name","-Search/Add for " + as_lu_table +" -")		//Added by Scofield on 2007-08-31
	end if
elseif as_type = "Q" THEN
//		dwchild.Retrieve()
		gnv_data.of_set_dwchild_fromcache('question_lookup',"",dwchild)
end if

//dwchild.InsertRow(1) //blank row

//End Code Change---12.15.2005 

if as_from = "RET" then
	ll_val = al_value
	adw_dw.SetItem( adw_dw.GetRow(), as_column_nm, ll_val )
	adw_dw.accepttext()
	ll_find = dwchild.find("lookup_code = " + string(ll_val),1,dwchild.rowcount())
	if ll_find > 0 then
		dwchild.scrolltorow(ll_find)
	end if
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-69
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Specify values to arrays.

is_types[upperbound(is_types) + 1] 					= as_type
is_froms[upperbound(is_froms) + 1] 					= as_from
is_dddwcolumns[upperbound(is_dddwcolumns) + 1] 	= as_column_nm
is_lu_tables[upperbound(is_lu_tables) + 1] 		= as_lu_table
il_values[upperbound(il_values) + 1] 				= al_value
//---------------------------- APPEON END ----------------------------

return 1
end function

public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, string as_curdw, string as_reportfrom, integer ai_profile_view_id);//for dynamic profiles
SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
string ls_sort_field[]   //maha 11.10.2016
string ls_sort_add_field[]   //maha 11.10.2016
string ls_sort_name  //maha 11.10.2016	
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
Integer li_repobj_cnt
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-31
//$<add> 01.13.2006 By: Luke
//$<reason> Performance tuing
//$<modification> Define variables to be used in subsequent script.
long set1 , ll_recreate
String ls_Bold, ls_italic

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//
	app_filler.ids_report_fields_cache.ShareData( ids_screen_fields )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	
//
	app_filler.ids_report_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
//alan	
	app_filler.ids_screen_report_objects_cache.ShareData( ids_report_objects )
	ids_report_objects.SetFilter( "data_view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_report_objects.Filter( )
	li_repobj_cnt = ids_report_objects.RowCount()
	
	ids_screen_fields.SetSort( "field_order A" )
	ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_report_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

//special datawindow and compute column count
int 		li_row_cnt_new

adw_detail.dataobject=as_curdw
li_row_cnt_new = UpperBound(ls_field_names)	
for i = 1 to li_row_cnt_new
	ls_dw_field_names[i] = ls_field_names[i]
END FOR
li_row_cnt_new=integer(adw_detail.object.datawindow.column.count)

//Start Code Change ---- 06.09.2006 #531 maha
adw_detail.InsertRow(0) 

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Pervformance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 
		END IF
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	
//	messagebox(as_curdw+'/'+ls_dw_field_names[i],adw_detail.describe(ls_dw_field_names[i]+".type"))
	adw_detail.Modify( ls_dw_field_names[i] + ".border = '5'") 
	//
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04/01/2008 By: Ken.Guo
	//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
	//UnderLine
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_report_fields_field_underline" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_report_fields_label_underline" ) + "'" )	

	//Italic
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_field_font_italic" ) ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_italic" ) ) + "'" )	

	//Weight
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_font_wieght" )) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_weight" ) ) + "'" )	
	//---------------------------- APPEON END ----------------------------


	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Autoretrieve = No") //alfee 01.13.2009
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'") //for a Web version issue - alfee 09.07.2011
				IF ib_create_browse = True THEN				
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011	
				END IF
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
			END IF
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )
		dwchild.SetTransObject( SQLCA )
		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
//		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
//		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
//			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
//			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
//		END IF	
//		IF ls_mask[i] <> "" THEN
//			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
//			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
//			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
//			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
//			IF ls_mask[i] = "##" THEN
//				FOR m = 1 TO 12
//					ls_month = String(m)
//					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
//					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
//				END FOR
//				m1 = 0
//				FOR m = 13 TO 21
//					m1++
//					ls_month = "0" + String(m1)
//					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
//				END FOR
//				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
//				
//			ELSEIF ls_mask[i] = "(###)###-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
//			ELSEIF ls_mask[i] = "###-##-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
//			ELSEIF ls_mask[i] = "#####-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
//			ELSEIF ls_mask[i] = "####" THEN
//				li_index = 0
//				FOR m = 1880 TO 2050
//					li_index++
//					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
//				END FOR
//				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
//				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
//			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
//				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
//				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
//			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
//				IF ib_create_browse = True THEN				
//					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
//				END IF
//			ELSEIF ls_mask[i] = "#,##0.00" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
//				IF ib_create_browse = True THEN								
//					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
//				END IF
//			END IF
//		END IF	
	END IF
END FOR

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-08-31 By: Liu HongXin
			//$<reason> 
			/*
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")" )
			*/
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
			//---------------------------- APPEON END ----------------------------

	END CHOOSE
END FOR
//Start Code Change ---- 01.18.2006 #203 maha


//alan
long	ll_obj_id
//if as_reportfrom='P' then
if as_reportfrom='P' or as_reportfrom = 'S' then //for report header under screen mode - alfee 02.09.2010	
	FOR i = 1 TO li_repobj_cnt		
		if ids_report_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
			li_uls = 1
		else 
			li_uls = 0
		end if
		ls_obj_name = ids_report_objects.GetItemstring(i, "object_name")
		ll_obj_id = ids_report_objects.GetItemNumber(i, "data_view_object_id")
		ls_width = string(ids_report_objects.GetItemNumber(i, "object_width")) 
		ls_height = string(ids_report_objects.GetItemNumber(i, "object_height")) 
		ls_x = string(ids_report_objects.GetItemNumber(i, "object_x")) 
		ls_y = string(ids_report_objects.GetItemNumber(i, "object_y")) 
		ls_text = ids_report_objects.GetItemString(i, "object_text") 
		ls_justification = string(ids_report_objects.GetItemNumber(i, "object_alignment"))
		if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-08-31 By: Liu HongXin
		//$<reason> Fix defect: display the bold and italic of stand-alone text
		ls_Bold		= string(ids_report_objects.GetItemNumber(i, "object_bold"))
		ls_italic	= string(ids_report_objects.GetItemNumber(i, "object_italic"))
		if IsNull(ls_Bold) then ls_Bold = "400"
		if IsNull(ls_italic) then ls_italic = "0"
		//
		IF ab_screen_painter THEN
			IF ids_report_objects.GetItemString(i, "visible") = "N" THEN
				adw_detail.Modify(ls_obj_name + ".color = '8421504'") 
				adw_detail.Modify(ls_obj_name + ".background.color = '12632256'") 
			ELSE
				adw_detail.Modify(ls_obj_name + ".color = '0'") 
			   //--------Begin Modified by Nova 02.17.2009-----------
				//adw_detail.Modify(ls_obj_name + ".background.color = '16777215'") 
				if adw_detail.Describe(ls_obj_name+".Background.Color")<>'12632256' then
					adw_detail.Modify(ls_obj_name + ".background.color = '16777215'") 
				end if
				//--------End Modified -------------------------------
			END IF
		END IF	
		
		adw_detail.modify(ls_obj_name+".text='"+ls_text+"'")
		adw_detail.modify(ls_obj_name+".x='"+ls_x+"'")
		adw_detail.modify(ls_obj_name+".y='"+ls_y+"'")
		adw_detail.modify(ls_obj_name+".width='"+ls_width+"'")
		adw_detail.modify(ls_obj_name+".height='"+ls_height+"'")
		adw_detail.modify(ls_obj_name+".Alignment='"+ls_justification+"'")
		adw_detail.modify(ls_obj_name+".font.weight='"+ls_Bold+"'")
		adw_detail.modify(ls_obj_name+".font.italic='"+ls_italic+"'")
		adw_detail.modify(ls_obj_name+".font.underline='"+string(li_uls)+"'")
		adw_detail.modify(ls_obj_name+".tag='"+string(ll_obj_id)+"'")
		if adw_detail.describe(ls_obj_name+".type")="compute" then
			adw_detail.Modify( ls_obj_name + ".border = '5'") 
		end if
	NEXT
end if
//

if as_reportfrom='S' then
IF ls_table_name = "pd_address" or ls_table_name = "dba.pd_address" THEN //maha 011806
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	
	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
	set1 = of_get_app_setting("set_1","I")

	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
		adw_detail.Modify( "street.dddw.useasborder = Yes")			
		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
		//adw_detail.Modify( "street.dddw.Lines= 15")
		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
//		des = dwchild.Describe("DataWindow.Objects")
//			openwithparm(w_sql_msg,des)
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" THEN //maha 011806
//End Code Change---01.18.2005 
	li_set = of_get_app_setting("set_5","I")
	if li_set = 0 then
		//messagebox("","ref button")
		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
	end if
end if
end if


IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if
//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ll_max_height)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
//of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
//of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
//---------------------------- APPEON END ----------------------------
if ab_screen_painter = true then adw_detail.hscrollbar = true

//string ls_test_syn
//ls_test_syn = adw_detail.Describe("DataWindow.Syntax")
//openwithparm(w_sql_msg,ls_test_syn)

RETURN ls_return_syntax
end function

public function string of_mod_report_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, datawindowchild adw_detail, boolean ab_screen_painter, integer ai_facility_id, string as_curdw, string as_reportfrom, integer ai_profile_view_id);SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
string ls_band //alfee 06.16.2009
String ls_field_type //alfee 11.13.2010
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
Integer li_repobj_cnt

boolean	lb_con=false //alan
string	ls_coltype
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-31
//$<add> 01.13.2006 By: Luke
//$<reason> Performance tuing
//$<modification> Define variables to be used in subsequent script.
long set1 , ll_recreate
String ls_Bold, ls_italic
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add a condition to make sure that: 1) DataWindow syntax will be stored in SRD files
//$<modification> in local machine; 2) the application directly gets the DataWindow syntax from local
//$<modification> machine instead of from the database when the same DataWindow is needed for a second time.


is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//of_setup_cache()

//UNREGISTER ALL CALENDAR FIELDS
	app_filler.ids_report_fields_cache.ShareData( ids_screen_fields )
	ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_screen_fields.Filter( )	
	li_row_cnt = ids_screen_fields.RowCount()	
//
	app_filler.ids_report_objects_cache.ShareData( ids_screen_objects )
	ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_screen_objects.Filter( )
	li_obj_cnt = ids_screen_objects.RowCount()
//alan	
	app_filler.ids_screen_report_objects_cache.ShareData( ids_report_objects )
	ids_report_objects.SetFilter( "data_view_id = " + String (ai_data_view_id) + " AND profile_view_id = " + String(ai_profile_view_id) + " AND screen_id = " + String( ai_screen_id ) + " AND report_from = '" + as_reportfrom + "'")
	ids_report_objects.Filter( )
	li_repobj_cnt = ids_report_objects.RowCount()
	
	ids_screen_fields.SetSort( "field_order A" )
	ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
//	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
//		CONTINUE //for visible =N do not add to the DE screen dw
//	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if ids_screen_fields.GetItemString(i, "visible") = "Y" then
		if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	end if
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
//	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_report_fields_font_wieght" ) )	
	lb_table_found = False
//	FOR t = 1 TO li_table_cnt
//		IF ls_table_names[t] = ls_table_name THEN
//			lb_table_found = True
//		   EXIT
//		END IF
//	END FOR
//	IF NOT lb_table_found THEN
//		li_table_cnt ++
//		ls_table_names[ li_table_cnt ] = ls_table_name
//	END IF
END FOR

Integer	li_row_cnt_new

li_row_cnt_new = UpperBound(ls_field_names)	
for i = 1 to li_row_cnt_new
	ls_dw_field_names[i] = ls_field_names[i]
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Pervformance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF as_reportfrom = 'S' THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".border = '0'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = no")			//useasborder=no
	END IF
	lb_con=false
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "ismodify") = "0" THEN
		if ids_screen_fields.GetItemString( i, "lookup_field") = "N" then
			CONTINUE
		else
			lb_con=true
		end if
	END IF
	
	if lb_con=false then
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".visible = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.visible = '0'")
			CONTINUE
		END IF
		//visible
		
			IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
				adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
				adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
				adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
			ELSE
				adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
				adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
				adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
				adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") 
				//--------Begin Added by Nova 12.25.2008------------------------
				adw_detail.Modify(ls_dw_field_names[i] + ".visible = '1'") 
				adw_detail.Modify(ls_dw_field_names[i] + "_t.visible = '1'")
				//--------End Added --------------------------------------------
			END IF
		
		if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
		
		if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
			//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
			adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
		end if
	
		li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
		li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
		adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )
	
	
		IF ls_field_x[i] = "0" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
			adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )
	
			adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
			adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
		ELSE
			adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
			adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )
	
			adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
			adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
		END IF
	
		//tag value set to field id
		adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )
	
		//alignment
		adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04/01/2008 By: Ken.Guo
		//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
		//UnderLine
		adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_report_fields_field_underline" ) + "'" )	
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_report_fields_label_underline" ) + "'" )	
	
		//Italic
		adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_field_font_italic" ) ) + "'" )	
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_italic" ) ) + "'" )	
	
		//Weight
		adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_font_wieght" )) + "'" )	
	//	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_weight" ) ) + "'" )	
		//---------------------------- APPEON END ----------------------------
		//
		if as_reportfrom='S' then
			adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")
			adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")
			adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
			adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )
			adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
			adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_report_fields_label_underline" ) + "'" )			
			adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_italic" ) ) + "'" )	
			adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_report_fields_label_font_weight" ) ) + "'" )	
		end if
	end if
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = no")			//useasborder=no
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
//		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
//		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")						

	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = no")			//useasborder=no
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Autoretrieve = No") //alfee 01.13.2009		
		//Start Code Change ---- 03.08.2006 #317 maha readded
//		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
//		//End Code Change---03.08.2006
//		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
//			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
//			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
//		END IF	

		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'") //for a Web version issue - alfee 09.07.2011
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
			ELSE

				
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )
		dwchild.SetTransObject( SQLCA )
		////////// 
		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		//////////
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		ls_coltype = adw_detail.describe(ls_dw_field_names[i]+".coltype")
//		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
//			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
//			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
//		END IF	
		IF isnull(ls_mask[i]) THEN
		ELSE
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".format='mm'" )
			ELSEIF ls_mask[i] = "(###)###-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
				if LeftA(ls_coltype,3)='int' or LeftA(ls_coltype,3)='lon' or LeftA(ls_coltype,3)='dec' or LeftA(ls_coltype,3)='num' then  
					adw_detail.Modify( ls_dw_field_names[i] + ".format='(###)###-####'" )
				end if
			ELSEIF ls_mask[i] = "###-##-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
				if LeftA(ls_coltype,3)='int' or LeftA(ls_coltype,3)='lon' or LeftA(ls_coltype,3)='dec' or LeftA(ls_coltype,3)='num' then  
					adw_detail.Modify( ls_dw_field_names[i] + ".format='###-##-####'")		
				end if
			ELSEIF ls_mask[i] = "#####-####" THEN
//				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
				if LeftA(ls_coltype,3)='int' or LeftA(ls_coltype,3)='lon' or LeftA(ls_coltype,3)='dec' or LeftA(ls_coltype,3)='num' then  
					adw_detail.Modify( ls_dw_field_names[i] + ".format='#####-####'" )				
				end if
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
//				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
				adw_detail.Modify( ls_dw_field_names[i] + ".format='yyyy'" )				
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
			
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
			ELSEIF ls_mask[i] = "[general]" THEN
			ELSE
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='"+ls_mask[i]+"'")
			END IF
		END IF
		END IF	
	END IF
	
	//For a history bug about formats of custom fields - alfee 11.13.2010
	IF Left(Lower(ls_dw_field_names[i]), 7) = 'custom_' OR Left(Lower(ls_dw_field_names[i]), 5) = 'cust_' THEN
		ls_field_type = ids_screen_fields.GetItemString(i, "field_type")
		IF Upper(ls_field_type) <> 'D' AND Lower(adw_detail.Describe(ls_dw_field_names[i] +".Format"))='mm/dd/yyyy' THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Format=''")
		END IF
	END IF		
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-34
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label.

gnv_appeondb.of_commitqueue()
///////////If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)

//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  )


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			adw_detail.setposition(ls_obj_name, "detail", false)  //(Appeon)Stephen 04.13.2015 - Printing issues for groupbox
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-08-31 By: Liu HongXin
			//$<reason> 
			/*
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")" )
			*/
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
			//---------------------------- APPEON END ----------------------------

	END CHOOSE
END FOR
//Start Code Change ---- 01.18.2006 #203 maha


//alan
//if as_reportfrom='P' then -  commented by alfee 12.30.2014
	FOR i = 1 TO li_repobj_cnt
		//IF ids_report_objects.GetItemString(i, "ismodify") = "0" THEN CONTINUE - commented by alfee 05.06.2009
		if ids_report_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
			li_uls = 1
		else 
			li_uls = 0
		end if
		ls_visible = ids_report_objects.GetItemstring(i, "visible")
		if ls_visible='N' then
			ls_visible = '0'
		else
			ls_visible = '1'
		end if
		ls_obj_name = ids_report_objects.GetItemstring(i, "object_name")
		ls_width = string(ids_report_objects.GetItemNumber(i, "object_width")) 
		ls_height = string(ids_report_objects.GetItemNumber(i, "object_height")) 
		ls_x = string(ids_report_objects.GetItemNumber(i, "object_x")) 
		ls_y = string(ids_report_objects.GetItemNumber(i, "object_y")) 
		ls_text = ids_report_objects.GetItemString(i, "object_text") 
		ls_justification = string(ids_report_objects.GetItemNumber(i, "object_alignment"))
		//---Begin Modified by Alfee 06.16.2007 ---------------------
		ls_band = adw_detail.Describe(ls_obj_name + ".Band")
		if ls_visible='1' AND ls_band = 'detail' then
		//if ls_visible='1' then			
		//---End Modified -------------------------------------------	
			if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
		end if

		IF ids_report_objects.GetItemString(i, "ismodify") = "0" THEN CONTINUE //alfee 05.06.2009
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-08-31 By: Liu HongXin
		//$<reason> Fix defect: display the bold and italic of stand-alone text
		ls_Bold		= string(ids_report_objects.GetItemNumber(i, "object_bold"))
		ls_italic	= string(ids_report_objects.GetItemNumber(i, "object_italic"))
		if IsNull(ls_Bold) then ls_Bold = "400"
		if IsNull(ls_italic) then ls_italic = "0"
		
		adw_detail.modify(ls_obj_name+".text='"+ls_text+"'")
		adw_detail.modify(ls_obj_name+".x='"+ls_x+"'")
		adw_detail.modify(ls_obj_name+".y='"+ls_y+"'")
		adw_detail.modify(ls_obj_name+".width='"+ls_width+"'")
		adw_detail.modify(ls_obj_name+".height='"+ls_height+"'")
		adw_detail.modify(ls_obj_name+".Alignment='"+ls_justification+"'")
		adw_detail.modify(ls_obj_name+".font.weight='"+ls_Bold+"'")
		adw_detail.modify(ls_obj_name+".font.italic='"+ls_italic+"'")
		adw_detail.modify(ls_obj_name+".font.underline='"+string(li_uls)+"'")
		adw_detail.modify(ls_obj_name+".visible='"+ls_visible+"'")
	NEXT
//end if  -  commented by alfee 12.30.2014

//--------Begin Modified by Nova 02.17.2009-----------
//reason:special process
if as_reportfrom='S' then
IF ls_table_name = "pd_address" or ls_table_name = "dba.pd_address" THEN //maha 011806
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	//address drop down
	//	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	//	integer set1
	//	select set_1
	//	into :set1
	//	from icred_settings;
	//	set1 = of_get_app_setting("set_1","I")
	//
	//	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
	//		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
	//		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
	//		adw_detail.Modify( "street.dddw.useasborder = Yes")			
	//		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
	//		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
	//		//adw_detail.Modify( "street.dddw.Lines= 15")
	//		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
	//		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
	//		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
	//		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
	//	end if
	
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.UseAsBorder= No")
	
	adw_detail.Modify( "billing_address_id..DDDW.ShowList=No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

//IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" THEN //maha 011806
////End Code Change---01.18.2005 
//	li_set = of_get_app_setting("set_5","I")
//	if li_set = 0 then
//		//messagebox("","ref button")
//		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
//		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
//	end if
//end if
end if
//--------End Modified -------------------------------
IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.modify("datawindow.detail.height=2000")
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	//----------Begin Modified by Alfee 06.03.2009------------------------
	//<$Reason>The height may be wrong if there are any objects in Head band
	adw_detail.modify("datawindow.detail.height="+string(ll_max_height)) //restored and modified the ll_max_height - Alfee 06.16.2009
	//adw_detail.modify("datawindow.detail.height.autosize = 'Yes'") 
	//----------End Modified --------------------------------------------
//	messagebox('',ll_max_height)
end if

RETURN ls_return_syntax

end function

public function integer of_field_audit_upd4caqh ();//CAQH 2: Set audit info for a caqh XML import call - alfee 11.03.2009
//Called in n_cst_caqh_import.of_save()

Integer ll_Rows,  li_rtn = 1
Long ll_seq_no

IF ids_sys_audit.modifiedcount( ) + ids_sys_audit.Deletedcount( ) <=0 Then Return 1

//Set other audit fields
FOR ll_Rows = 1 to ids_sys_audit.rowcount()
	IF ids_sys_audit.GetItemStatus(ll_Rows, 0 , Primary!) = newmodified! THEN
		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			SELECT Max( sys_audit.seq_no ) INTO :ll_seq_no FROM sys_audit;			
			IF IsNull(ll_seq_no) THEN ll_seq_no = 0
		END IF
		ll_seq_no++		
		ids_sys_audit.SetItem( ll_Rows, "seq_no", ll_seq_no )
		ids_sys_audit.SetItem( ll_Rows, "audit_type", 'X') //XML import
	END IF
NEXT

//Update in DW (don't commit here) 
IF ids_sys_audit.modifiedcount( ) > 0 THEN
	li_rtn = ids_sys_audit.Update()
END IF

//Don't reset the datastore here before commit/rollback
//ids_sys_audit.Reset()

RETURN li_rtn
end function

public function integer of_generate_attest_questions (string as_from, integer ai_facility_id, long al_prac_id, long al_appt_id);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_data_entry_functions / of_generate_attest_questions()
// $<arguments>
//		value	string 	as_from       		
//		value	integer	ai_facility_id		
//		value	long   	al_prac_id    		
//		value	long   	al_appt_id    		
// $<returns> integer
// $<description> Generate attest questions automatically.
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-25 by Rodger Wu (attest quest)
//////////////////////////////////////////////////////////////////////
//Start Code Change ----12.09.2009 #V10 maha - changed al_appt_id from integer to long to correct wrapping error of the number


Long ll_template_init, ll_template_reapp, ll_template_selected, ll_rec_id
Long ll_question_id
integer li_rowcount, i, li_inserted
n_ds lds_attest_detail, lds_questions

  SELECT facility.default_question_init,   
         facility.default_question_reapp  
    INTO :ll_template_init,   
         :ll_template_reapp  
    FROM facility  
   WHERE facility.facility_id = :ai_facility_id   ; 
if sqlca.sqlcode <> 0 then return -1;

if isnull( ll_template_init ) then ll_template_init = 0
if isnull( ll_template_reapp ) then ll_template_reapp = 0

if as_from = "reapp" then
	if ll_template_reapp = 0 then return 0
	ll_template_selected = ll_template_reapp
else
	if ll_template_init = 0 then return 0
	ll_template_selected = ll_template_init
end if

lds_questions = create n_ds
lds_questions.dataobject = "d_quest_items"
lds_questions.settransobject( SQLCA )
li_rowcount = lds_questions.Retrieve( ll_template_selected )
if li_rowcount < 1 then
	DESTROY lds_questions;
	return 0;
end if

lds_attest_detail = create n_ds
lds_attest_detail.dataobject = "d_attest_quest_appt_stat"
lds_attest_detail.settransobject( SQLCA )

ll_rec_id = gnv_app.of_get_id("RECORD_ID",li_rowcount ) - 1
for i = 1 to li_rowcount
	ll_rec_id++;
	li_inserted = lds_attest_detail.InsertRow(0)
	
	lds_attest_detail.SetItem( li_inserted, "rec_id", ll_rec_id )
	lds_attest_detail.SetItem( li_inserted, "facility_id", ai_facility_id )
	lds_attest_detail.SetItem( li_inserted, "active_status", 1 )
	lds_attest_detail.SetItem( li_inserted, "appt_stat_id", al_appt_id )
	lds_attest_detail.SetItem( li_inserted, "prac_id", al_prac_id )
	
	ll_question_id = lds_questions.GetItemNumber( i, "quest_id" )
	lds_attest_detail.SetItem( li_inserted, "question_id", ll_question_id )
next

lds_attest_detail.Update()

destroy lds_attest_detail//added by long.zhang appeon 03.21.2014
destroy lds_questions//added by long.zhang appeon 03.21.2014
Return 1;
end function

public function integer of_undo_data (datawindow adw_data);//Start Code Change ----09.25.2012 #V12 maha - added
integer c
integer ans
integer li_stat
string ls_col

adw_data.accepttext()

choose case adw_data.getitemstatus(adw_data.getrow(),0, Primary!)
	case datamodified!
		li_stat = 1
	case new!, newmodified!
		li_stat = 2
	case else
		li_stat = 0
end choose
		
if li_stat = 2 then
	messagebox("Undo","The current row is new and cannot be undone.")

elseIf li_stat = 1 then
	ans = messagebox("Undo","Do you wish to undo values changed since the last save for the current record>",question!, yesno!, 2)
	if ans = 1 then
		adw_data.reselectrow(adw_data.getrow())
//		for c = 1 to adw_data.Object.DataWindow.Column.Count
//			if  adw_data.getitemstatus(adw_data.getrow(), c , Primary!) = datamodified! then
//				ls_col = adw_data.describe('#' + string(c) + '.name')
//				
//				adw_data.setitem()
//				
//			end if		
//		next
	end if
else
//	messagebox("Undo","The current row has not been modified.")
end if

return 1
end function

public function string of_create_dynamic_dw (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add);//for data entry screens

SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
integer li_access //maha 05.26.2009
integer s //maha 11.10.2016
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
Boolean lb_reset_sort = true  //maha 09.08.2017
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
string ls_yellow //maha 111909
string ls_background
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
string ls_font = "Segoe UI"
string ls_sort_field[]   //maha 11.10.2016
string ls_sort_add_field[]   //maha 11.10.2016
string ls_sort_name  //maha 11.10.2016
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
long set1 , ll_recreate
String ls_Bold, ls_italic

if isnull(ai_screen_id) or ai_screen_id < 0  then return "-1"	//12.12.2008 By Jervis WorkFlow = -10

ls_white = String(rgb(255,255,255))
ls_grey = "80269524"//String(rgb(192,192,192))
ls_yellow = string(gl_req_yellow)   //Start Code Change ----01.20.2016 #V15 maha   //"8257535" old yellow  
ls_background = "16777215"  //"16120575"   //Start Code Change ----03.23.2015 #V15 maha - change to white

If appeongetclienttype() <> 'PB' Then
	ll_recreate = of_create_option(ai_data_view_id,ai_screen_id,'Y','D',string(idt_screen_cache),ab_screen_painter)
	If ll_recreate = 0 Then
		ls_return_syntax = of_create_dynamic_dw_local(al_prac_id,ai_data_view_id,ai_screen_id,adw_detail,adw_browse,ab_screen_painter,ai_facility_id)
		If ls_return_syntax <> "-1" Then return ls_return_syntax
	End If
End If

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_UnRegister()		
END IF

app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	

app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_objects.Filter( )
li_obj_cnt = ids_screen_objects.RowCount()

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wer  //#####
wer = ids_screen_fields.SetSort( "sort_field A" ) //maha corrected 051005
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		//Start Code Change ----11.10.2016 #V153 maha - get info for later sorting
		ls_sort_name =  ids_screen_fields.GetItemString( i, "db_field_name" )
		
		if ids_screen_fields.GetItemString( i, "visible" ) <> "Y" then lb_reset_sort = false  //Start Code Change ----09.08.2017 #V154 maha
		
				//Start Code Change ----06.20.2017 #V154 maha - readded
		if  ids_screen_fields.GetItemString( i, "lookup_field" ) = "Y" then
			ls_sort_name = "sort4_" + ls_sort_name
			ls_sort_add_field[ upperbound(ls_sort_add_field) + 1 ] = ls_sort_name   //add to array for fields to be added  //Added by Harry 2017-09-29 Sort order not working Case#73029 Bug_id#5819 
			//Start Code Change ----08.17.2017 #V154 maha
			IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
				ls_sort_name+= "D"
			else
				ls_sort_name+= "A"
			end if
			//End Code Change ----08.17.2017
			
			//ls_sort_add_field[ upperbound(ls_sort_add_field) + 1 ] = ls_sort_name   //add to array for fields to be added  //commented by Harry 2017-09-29 Sort order not working Case#73029 Bug_id#5819 
		else //(Appeon)Stephen 09.20.2017 - Sort Order on Screen design not working Case#73029 Bug_id#5806
			IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
				ls_sort_name+= "D"
			else
				ls_sort_name+= "A"
			end if
		end if

		//---------End Commented ------------------------------------------------------

		ls_sort_field[upperbound(ls_sort_field) + 1] = ls_sort_name
		//Start Code Change ----11.10.2016 
			
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR

wer = ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

//Start Code Change ----11.10.2016 #V153 maha
if  upperbound(ls_sort_add_field) > 0 then
	for s = 1 to  upperbound(ls_sort_add_field)
		ls_sql_syntax = ls_sql_syntax + ls_sort_add_field[s] + " = '', "
		//ls_field_names[upperbound(ls_field_names) + 1] = ls_sort_add_field[s]
	next
end if
//Start Code Change ----11.10.2016

if li_table_cnt = 0 then
	Messagebox("Caution","Unable to create SELECT syntax for datawindow. ~rPossibly caused by no data view fields for screen_id " + string(ai_screen_id) + " and data_view_id " + string(ai_data_view_id) + ".~r~r" + ls_sql_syntax)
	return '-1'
end if

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	//Start Code Change ----09.15.2016 #V152 maha - changed back to the original code because it prevents adjusting the prac_id field if intended to appear on the screen
	//if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
			ls_field_names[upperbound(ls_field_names) + 1] = "prac_id"
		END IF
	end if
	
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			ls_field_names[upperbound(ls_field_names) + 1] = "rec_id"
		END IF
	end if
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF

		if PosA(ls_sql_syntax,"facility_id",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "facility_id"
			end if
		end if
	END IF
	
	IF ai_screen_id = 61 or ai_screen_id = 33 or ai_screen_id = 32 THEN	//alfee 09.03.2009
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
		
		if PosA(ls_sql_syntax,"seq_no",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "seq_no"
			end if
		end if
	END IF	
	
	//Start Code Change ----03.22.2010 #V10 maha - to hide the active and appt_stat_id fields that do not need to be visible.
	IF ai_screen_id = 65 then // attest questions  
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".active_status, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".active_status"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "active_status"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
		END IF	

		if PosA(ls_sql_syntax,"active_status",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "active_status"
			end if
		end if
		
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".appt_stat_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".appt_stat_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "appt_stat_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
		END IF	

		if PosA(ls_sql_syntax,"appt_stat_id",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "appt_stat_id"
			end if
		end if
	end if	
	//End Code Change ----03.22.2010
	
	//------Begin Added by alfee 11.17.2016 -----------------------
	IF ai_screen_id = 2 then //For gp_id update in Address screen
		IF PosA(ls_sql_syntax, "gp_id",1) = 0 then 
			ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".gp_id, "
			li_key_cnt ++
			ls_key_fields[li_key_cnt] = ls_table_names[i] + ".gp_id"
			IF li_table_cnt > 1 THEN
				ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_gp_id"
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			ELSE
				ls_key_fields_col_nm[li_key_cnt] = "gp_id"
				ls_field_names[upperbound(ls_field_names) + 1] = "gp_id"
			END IF			
		END IF
	END IF
	//------End Added --------------------------------------------------
	
	//Start Code Change ----11.13.2017 #V16 maha
	IF ai_screen_id = 74 then //For gp_id update in Address screen
		IF PosA(ls_sql_syntax, "screen_id",1) = 0 then 
			ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".screen_id, "
			li_key_cnt ++
			ls_key_fields[li_key_cnt] = ls_table_names[i] + ".screen_id"
			IF li_table_cnt > 1 THEN
				ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_screen_id"
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			ELSE
				ls_key_fields_col_nm[li_key_cnt] = "screen_id"
				ls_field_names[upperbound(ls_field_names) + 1] = "screen_id"
			END IF			
		END IF
		IF PosA(ls_sql_syntax, "data_rec_id",1) = 0 then 
			ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".data_rec_id, "
			li_key_cnt ++
			ls_key_fields[li_key_cnt] = ls_table_names[i] + ".data_rec_id"
			IF li_table_cnt > 1 THEN
				ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_data_rec_id"
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			ELSE
				ls_key_fields_col_nm[li_key_cnt] = "data_rec_id"
				ls_field_names[upperbound(ls_field_names) + 1] = "data_rec_id"
			END IF			
		END IF
		
	END IF
	//End Code Change ----11.13.2017 
		
END FOR

integer li_row_cnt_new
li_row_cnt_new = UpperBound(ls_field_names)	

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)


//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	//FOR i = 1 TO li_row_cnt	03/16/2007
	For i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	//FOR i = 1 TO li_row_cnt	03/16/2007
	for i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//---------Begin Commented by (Appeon)Stephen 07.16.2015 for Bug id 4601 - Allegheny Webview Data Audit Case# 55838, 55847--------
/*
//Start Code Change ----11.05.2009 #V10 maha
if PosA(upper(ls_table_name), "PD_ATTEST_QUESTIONS",1) > 0 then
	 //Start Code Change ----07.15.2015 #V15 maha - for attest_quest
	if gl_prac_de_appt_id > 0 then
		ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.appt_stat_id = " + string(gl_prac_de_appt_id )
	else
		ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.active_status in ( 1,4) " 
	end if
	 //End Code Change ----07.15.2015
end if
//End Code Change---11.05.2009
*/
//---------End Commented ------------------------------------------------------

//CREATE SORT ORDER code moved to top of function //maha 051905

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
else
	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
END IF

//CREATE SYNTAX FOR DETAIL DW

ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_background + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			CONTINUE
		END IF

		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		//--> Begin change Editmask 
			IF ls_dw_field_names[i] <> "active_status" THEN
				IF ls_mask[i] <> "" THEN
					IF ls_mask[i] = "##" THEN
					ELSEIF ls_mask[i] = "(###)###-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='(###)###-####'"
						Li_appeon_index2 ++					//Comment by Scofield on 2008-08-12
					ELSEIF ls_mask[i] = "###-##-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='###-##-####'"
						Li_appeon_index2 ++
					ELSEIF ls_mask[i] = "#####-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='#####-####'"
						Li_appeon_index2 ++
					END IF
				END IF	
			END IF
			//--< end change Editmask 
	END FOR
	
	//specail code for pd_address
	IF ls_table_name = "pd_address" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	of_change_to_editmask(ls_dwsyntax_str, ls_editmask_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)

		RETURN "-1"
	END IF
End If
//---------------------------- APPEON END ----------------------------

//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_background + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-06
	//$<add> 01.13.2006 By: Luke
	//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
	//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
	//$<modification> implement the functionality of changing a column's edit style.
	If appeongetclienttype() <> 'PB' Then
		ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
		li_appeon_index = 1
		
		FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
			IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
				CONTINUE
			END IF
		
			IF ls_dw_field_names[i] = "active_status" THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
			
			IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		END FOR
		
		//specail code for pd_address
		IF ls_table_name = "pd_address" THEN
			set1 = of_get_app_setting("set_1","I")
			
			if set1 = 1 then //maha 072301 create populate button only if using addresses for find
				ls_appeon_colname[li_appeon_index] = 'street'
				li_appeon_index++
			end if
						
			ls_appeon_colname[li_appeon_index] = 'billing_address_id'
			li_appeon_index++
		END IF
	
		of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
		adw_browse.Create( ls_dwsyntax_str, ERRORS)
		
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution", &
			"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
			clipboard(ls_dwsyntax_str)
			RETURN "-1"
		END IF
	End If
	//---------------------------- APPEON END ----------------------------	
	
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	//Start Code Change ---- 06.09.2006 #531 maha
	if ai_screen_id = 65 or ai_screen_id = 54 or ab_add = false  then  //Start Code Change ----01.15.2013 #V12 maha - added ab_add variable
		if not ab_screen_painter then 
			//don't add row in prac folder
		else	
			adw_detail.InsertRow(0) //maha app081705
		end if
			
	else
		adw_detail.InsertRow(0) 
	end if
	//End Code Change---06.09.2006
	
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	//FOR i = 1 TO li_row_cnt		03/16/2007
	For i = 1 to li_row_cnt_new
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
	next
	//03/16/2007 
	li_access = w_mdi.of_security_access( 50 )  //Start Code Change ----05.26.2009 #V92 maha - security
	For i = 1 to li_row_cnt
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.14.2014
		//<$>reason:deal with li_access at last
		//if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 to allow single fields to be read only-//Start Code Change ----05.26.2009 #V92 maha
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y"  then //remove li_access
		//<$>reason:v14.2 Provider-Contract direct linking
		//------------------- APPEON END -------------------
			adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //these values will be reset below
			//adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '553648127'") //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
		elseif  ids_screen_fields.GetItemstring( i, "display_only" ) = "P" then
			adw_detail.Modify(ls_dw_field_names[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
		end if
	END FOR
	//Start Code Change ----11.10.2016 #V153 maha - reset lookup sort fields
	if  upperbound(ls_sort_add_field) > 0 then
		
		for i = 1 to upperbound(ls_sort_add_field)
			adw_detail.Modify(	ls_sort_add_field[i] + ".Update= No"  )
			adw_detail.Modify(ls_sort_add_field[i] + ".TabSequence = '0'"  )
			adw_detail.Modify(ls_sort_add_field[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
			adw_detail.Modify(ls_sort_add_field[i] + ".Visible=False") //Added by Appeon long.zhang 09.01.2017 (Bug id 5703 - Getting sort error when trying to preview a page in Application Mapping. C/S Version 15.309 Build Date 5/11/2017)
			adw_detail.Modify(ls_sort_add_field[i] + "_t.Visible=False") //Added by Appeon long.zhang 09.01.2017 (Bug id 5703 - Getting sort error when trying to preview a page in Application Mapping. C/S Version 15.309 Build Date 5/11/2017)
		next
		
		if ib_create_browse then
			for i = 1 to upperbound(ls_sort_add_field)
				adw_browse.Modify(	ls_sort_add_field[i] + ".Update=No"  )
				adw_browse.Modify(ls_sort_add_field[i] + ".TabSequence = '0'"  )
				adw_browse.Modify(ls_sort_add_field[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
				adw_browse.Modify(ls_sort_add_field[i] + ".Visible=False")
			next
		end if
		
	end if
	//End Code Change ----11.10.2016 
END IF
//debugbreak()
IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF

adw_detail.Modify("active_status.Initial='1'")

gnv_appeondb.of_startqueue()
FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF

	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") //restored by alfee 03.26.2010 
			//adw_detail.Modify(ls_dw_field_names[i] + "_t.background.color = '" + ls_white + "'") //Start Code Change ----11.19.2009 #V10 maha
		END IF
	else
		adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ----11.19.2009 #V92 maha
	END IF

	IF ab_screen_painter THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String( i * 10) + "'" )
	ELSE
		
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.14.2014
		//if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 - //Start Code Change ----05.26.2009 #V92 maha
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y"  then //remove li_access
		//<$>reason:deal with li_access at last
		//------------------- APPEON END -------------------
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
			adw_detail.Modify( ls_dw_field_names[i] + ".border = '2'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.face = '" + ls_font + "'")  //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + ".font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + ".font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + ".font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + ".font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
		

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
		if ai_screen_id > 100 then adw_detail.Modify( ls_dw_field_names[i] + ".edit.VScrollBar = True") //Start Code Change ----12.06.2017 #V154 maha
		if ai_screen_id = 73 then adw_detail.Modify( ls_dw_field_names[i] + ".edit.VScrollBar = True") //V11.3 Issue Screen - Alfee 08.05.2011		
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )
	//adw_detail.Modify( ls_dw_field_names[i] + "_t.height = '" + String(64 ) + "'" ) //Start Code Change ----03.20.2017 #V153 maha - testing (the program does not explicity specify the label height)

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04/01/2008 By: Ken.Guo
	//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
	//UnderLine
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) + "'" )	

	//Italic
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_field_font_italic" ) ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_italic" ) ) + "'" )	

	//Weight
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" )) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_weight" ) ) + "'" )	
	//---------------------------- APPEON END ----------------------------

	adw_detail.Modify( ls_dw_field_names[i] + ".Edit.FocusRectangle = True") //Start Code Change ----07.30.2014 #V14.2 maha

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		//Start Code Change ----05.09.2013 #V14 maha
//		if is_table_name = "pd_address" then
//			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
//		else
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
//		end if
		//Start Code Change ----05.09.2013		
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")	
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '200'")
		adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----12.14.2009 #V92 maha
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.tip='Verification creation: Historical- PSV verification; Inactive- No verification; Active- PSV and expiring verification")
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.enabled= Yes")
		

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")	 //Start Code Change ----03.14.2017 #V153 maha - changed from Yes to remove dd arrow
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			//Start Code Change ----05.09.2013 #V14 maha
		//	if is_table_name = "pd_address" then
		//		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
	//		else
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
	//		end if
			//Start Code Change ----05.09.2013		
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF

	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '" + ls_yellow +  "'")//Start Code Change ----12.14.2009 #V10 maha
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")//for a Web version issue - alfee 09.07.2011
				IF ib_create_browse = True THEN				
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011
				END IF
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE			
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
			END IF
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		dwchild.ShareData( dwchild_browse )
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----11.19.2009 #V92 maha
					//	yellow 65535
		 
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )	
			elseif ls_mask[i] = "INTPHONE" THEN //Start Code Change ----02.02.2009 #V92 maha - added for dclick format phone function
				//do nothing for int phone
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR

gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)

//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()
if  ib_create_browse = True then
	for i = 1 to li_row_cnt//ids_screen_fields.rowcount()
		adw_browse.Modify( ls_field_names[i] + ".TabSequence = '0'" )
	next
end if

FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR

IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
	adw_detail.of_SetReqColumn(TRUE)
END IF

//Start Code Change ----11.10.2016 #V153 maha - resort if using lookups for sort
//Start Code Change ----09.08.2017 #V154 maha - only do resort if variable true
if lb_reset_sort = true then
	if  upperbound(ls_sort_add_field) > 0 then
		ls_sort_name = ""
		//set display values
		for s = 1 to upperbound(ls_sort_add_field)
			of_sort_evaluate( adw_detail, ls_sort_add_field[s] )
		next
		//reset sort
		for s = 1 to  upperbound(ls_sort_field)
			//Start Code Change ----08.17.2017 #V154 maha - add descending
			if rightA(ls_sort_field[s], 1) = "D" then
			//---------Begin Modified by (Appeon)Stephen 09.20.2017 for Sort Order on Screen design not working Case#73029 Bug_id#5806--------
			/*
				ls_sort_name += ls_sort_field[s] + " DESC,"
			else
				ls_sort_name += ls_sort_field[s] + " ASC,"
			*/
				ls_sort_name += left(ls_sort_field[s], len(ls_sort_field[s]) - 1) + " DESC,"
			else
				ls_sort_name += left(ls_sort_field[s], len(ls_sort_field[s]) - 1)  + " ASC,"	
			//---------End Modfiied ------------------------------------------------------
			end if
			//End Code Change ----08.17.2017
		next
		ls_sort_name = mid(ls_sort_name, 1, len(ls_sort_name) - 1)
		res = adw_detail.setsort(ls_sort_name)
		adw_detail.sort()
	end if
end if
//End Code Change ----09.08.2017
//Start Code Change ----11.10.2016

adw_detail.SetRedraw(True)

//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='8388608' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )  //Start Code Change ----01.25.2016 #V15 maha - changed font color to Navy
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
	END CHOOSE
END FOR

//------------------- APPEON BEGIN ------------------
//$<modify>long.zhang 11.14.2014
//$<reason> Move to pfc_cst_nv_data_entry.of_modify_dw_access //restored by Appeon long.zhang 02.02.2015 (address screen error)
//Start Code Change ---- 01.18.2006 #203 maha
//---------Begin Modified by (Appeon)Stephen 11.19.2013 for  Bug 3755: Billing Address Link field displays a number when set as read-only--------
//IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and li_access = 2 THEN //alfee 06.01.2009
boolean lb_bo =false
for i = 1 to upperbound(ls_dw_field_names) 
	if ls_dw_field_names[i] = "billing_address_id" then
		lb_bo = true
		exit
	end if
next
		
IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and (li_access = 2 or li_access = 1) and lb_bo THEN //alfee 06.01.2009
//---------End Modfiied ------------------------------------------------------
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF

		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF
//------------------- APPEON END -------------------

IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
if AppeonGetClientType() <> "PB" then // Evan 02.10.2009
	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
end if
//---------------------------- APPEON END ----------------------------
if ab_screen_painter = true then adw_detail.hscrollbar = true

//Start Code Change ----07.13.2017 #V154 maha
adw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
adw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))
//Start Code Change ----07.13.2017


RETURN ls_return_syntax
end function

public function integer of_lookup_search_dddw (string as_type, u_dw as_dw, string as_column);//Start Code Change ----07.25.2013 #V14 maha - moved from pfc_cst_u_data_entry so could be used in action items

DataWindowChild dwchild
any l_any
long li_row_cnt
long ll_val
long ll_find
String ls_column_nm
String ls_retval
String ls_search_type
String ls_value
any ll_null
setnull(ll_null)
u_dw dw_detail

dw_detail = as_dw

n_cst_dwsrv lnv_dwsrv
lnv_dwsrv = create n_cst_dwsrv
lnv_dwsrv.of_setrequestor( dw_detail)

ls_column_nm = dw_detail.GetColumnName()

ls_retval = dw_detail.Describe( ls_column_nm + ".DDDW.DisplayColumn" )

dw_detail.getchild( ls_column_nm, dwchild)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.14.2006 By: Liang QingShi
//$<reason> Fix a defect.

If appeongetclienttype() <> 'PB' Then
   dw_detail.triggerevent('itemfocuschanged')
end if
//---------------------------- APPEON END ----------------------------
OpenWithParm( w_lookup_search_dddw,as_type + "@" + as_column )

IF Message.StringParm = "Cancel" THEN
	
	ls_value = lnv_dwsrv.of_getitem( dw_detail.GetRow(), ls_column_nm , primary!,true)
	if string(ls_value) = "-777" OR string(ls_value) = "-888" or not f_validstr(ls_value) then
		setnull(ls_value)
	end if

	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, ls_value)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.23.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
	//---------------------------- APPEON END ----------------------------	
	RETURN -1
else
	l_any = Message.DoubleParm
	
	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, string(l_any))
	
	dw_detail.accepttext()
	of_dwchild_retrieve(as_column,as_type,dw_detail,"RET",l_any,ls_column_nm)
end if

IF IsValid( m_pfe_cst_data_entry ) THEN
	m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
//---------------------------- APPEON END ----------------------------

Return 0


end function

public function integer of_field_audit_delete_last (datastore ads_data, long al_row);//====================================================================
//$<Function>: of_field_audit_delete_last
//$<Arguments>:
// 	value    datastore    ads_data
// 	value    long         al_row
//$<Return>:  integer
//$<Description>: Called from n_cst_pending_change.of_deleteaddress
//$<Author>: (Appeon) long.zhang 09.26.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
Integer c
Integer li_rc
Integer li_lu_rc
Long ll_seq_rc
Long ll_seq_no
Integer li_nr
Integer li_col_cnt
Integer li_table_id
integer li_fs //maha 111502
integer li_set85
Long ll_rec_id
Long ll_field_id
Long ll_field_id2
Long ll_field_id1
Long ll_old_value
Long ll_new_value
long ll_facility_id //maha111802
long ll_prac
String ls_lookup_type
String ls_is_lookup
String ls_lookup_field_name
String ls_retval
String ls_old_value
String ls_new_value
String ls_value1
String ls_value2
String ls_table_name
String ls_fld_nm
String ls_fld_nm2
String ls_fld_type
n_ds lds_lookup_code
n_ds lds_lookup_address
n_ds lds_sys_audit
n_ds lds_last_seq_no

if al_row <= 0 then Return 1 //Add by Evan 01/09/2008
ls_table_name = ads_data.Object.DataWindow.Table.UpdateTable
//MessageBox("of audit trail", ls_table_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.06.2015
//<$>reason: (Bug 4379 created for Case# 00051492: Audit Trail Issue)
If ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items' or  ls_table_name = 'pd_appl_tracking' Then	
	//---------Begin Modified by (Appeon)Stephen 06.15.2016 for V15.2-Application Tracking full Auditing--------
	/*
	If of_get_app_setting("set_85","I") = 1 Then
		//go on		
	Else
		Return 1
	End if	
	*/
	li_set85 = of_get_app_setting("set_85","I")
	if li_set85 = 2 or ls_table_name = 'net_dev_action_items' then
		of_applfield_audit_delete_last(ads_data, al_row) //(Appeon)Stephen 06.15.2016 - V15.2-Application Tracking full Auditing	
	     Return 1
	elseif li_set85 = 1 and (ls_table_name = 'net_dev_ids' or ls_table_name = 'net_dev_action_items') then
		// go on		
	else
		Return 1
	end if
	//---------End Modfiied ------------------------------------------------------

End If
//------------------- APPEON END -------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-51
//$<modify> 04.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
 
/*
n_ds lds_audit_fields

lds_sys_audit = CREATE n_ds
lds_sys_audit.DataObject = "d_view_audit"
lds_sys_audit.of_SetTransObject( SQLCA )

lds_last_seq_no = CREATE n_ds
lds_last_seq_no.DataObject = "d_get_last_field_audit_seq_no"
lds_last_seq_no.of_SetTransObject( SQLCA )

lds_lookup_code = CREATE n_ds
lds_lookup_code.DataObject = "d_lookup_code_search"
lds_lookup_code.of_SetTransObject( SQLCA )

lds_lookup_address = CREATE n_ds
lds_lookup_address.DataObject = "d_lookup_address_search"
lds_lookup_address.of_SetTransObject( SQLCA )

lds_audit_fields = CREATE n_ds
lds_audit_fields.DataObject = "d_audit_fields"
lds_audit_fields.of_SetTransObject( SQLCA )
li_col_cnt = lds_audit_fields.Retrieve( ls_table_name )
*/
datastore lds_audit_fields

IF NOT IsValid(ids_sys_audit) THEN
	ids_sys_audit = CREATE n_ds
	ids_sys_audit.DataObject = "d_view_audit"
	ids_sys_audit.SetTransObject( SQLCA )
END IF
lds_sys_audit = ids_sys_audit

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("sys_fields", FALSE)
//------------------------------------------------------------------------------------------------------

lds_audit_fields = gnv_data.ids_sys_fields
lds_audit_fields.SetFilter( "sys_tables_table_name = '" + ls_table_name + "' AND sys_fields_audit_fld = 'Y'" )
lds_audit_fields.Filter()
li_col_cnt =  lds_audit_fields.Rowcount( )

//---------------------------- APPEON END ----------------------------


//messagebox("audit fields",li_col_cnt)
IF li_col_cnt < 1 THEN
//	messagebox("audit fields",li_col_cnt)
	Return -1
END IF

li_rc = ads_data.RowCount()
//messagebox("ads_data count",li_rc)
li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
li_fs = of_get_facil_specific(li_table_id)


i = al_row


///************************DELETE	
 		
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		//ls_fld_type = Upper( ads_data.Describe( ls_fld_nm + ".ColType" ) )
		if li_table_id = 95 then //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
			if ads_data.Describe("prac_id.ColType") <> "!" then
				ll_prac = ads_data.GetItemNumber( i, "prac_id" )
			else
				ll_prac = ads_data.GetItemNumber(i, "pd_images_prac_id")
			end if
			ll_rec_id = ads_data.GetItemNumber(i, "image_pk") 	
			ls_old_value = string(ll_rec_id) + "-" + string(ll_prac)
		else
			ll_rec_id = ads_data.GetItemNumber( i, "rec_id" ) 
			ll_prac = ads_data.GetItemNumber( i, "prac_id" )
		end if
		li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
		ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
		ll_field_id = lds_audit_fields.GetItemNumber( 1, "field_id" )


		choose case ls_table_name
			case "pd_affil_stat"
				ll_new_value = ads_data.GetItemnumber( i, "parent_facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-52
				//$<modify> 02.27.2006 By: LeiWei
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_value2 = ads_data.GetItemstring( i, "apptmnt_type" )
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_dept"
				ll_new_value = ads_data.GetItemnumber( i, "department" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-53
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
				ls_value2=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = ads_data.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-54
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_cat"
				ll_new_value = ads_data.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-55
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = ads_data.GetItemnumber( i, "staff_category" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-56
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case "pd_affil_staff_leave"
				ll_new_value = ads_data.GetItemnumber( i, "facility_id" )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-57
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ll_new_value = long(ads_data.GetItemstring( i, "leave_of_absence_reason" ))
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-58
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
				ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
				//---------------------------- APPEON END ----------------------------
				ls_old_value = ls_value1 + "-" + ls_value2
			case 'net_dev_ids','net_dev_action_items', 'pd_images' //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
				ls_old_value = string(ll_rec_id) + "-" + string(ll_prac)
			case else //data entry screens
								//ls_new_value = of_get_reference_val(li_table_id)
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-59
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				/*
				//get reference field 1
				select reference_field_1 into :ll_field_id1  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				//get reference field 2
				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
				//get reference field name 1
				select field_name into :ls_fld_nm from sys_fields where field_id = :ll_field_id1;
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then 
					if lds_audit_fields.rowcount() > 1 then //trap added maha 060305
						ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
					end if
				end if				//ref 1 data
				//datatype and lookup field
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;
				*/
	
				//get reference field 1
				ll_field_id1 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_1", "data_view_id = 1 and table_id = " + String(li_table_id)))
				//get reference field 2
				ll_field_id2 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_2", "data_view_id = 1 and table_id = " + String(li_table_id)))
				
				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
				if isnull(ll_field_id2) or ll_field_id2 < 1 then 
					If lds_audit_fields.Rowcount() > 1 Then  //Added trap By Ken.Guo 06.25.2008
						ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
					End If
				End If

				//get reference field name 1
				ls_fld_nm = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(ll_field_id1))
				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
				//get reference field name 2
				ls_fld_nm2 = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(ll_field_id2))
				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then 
					if lds_audit_fields.rowcount() > 1 then //trap added maha 060305
						ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
					end if
				end if				//ref 1 data
				//datatype and lookup field
				ls_fld_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(ll_field_id1))
				ls_lookup_type = gnv_data.of_getitem( "sys_fields","lookup_type", "field_id = "+String(ll_field_id1))
				//---------------------------- APPEON END ----------------------------
				
				ls_fld_type = Upper( ads_data.Describe( ls_fld_nm + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, ads_data.Describe( ls_fld_nm + ".ColType" ) )
					//return -1   //Commented by (Appeon)Harry 05.13.2015 
					ls_fld_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				ELSE				
					//MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				//data value
				choose case ls_fld_type
					case "C","V"
						ls_value1 = ads_data.GetItemString( i, ls_fld_nm )
					case "N", "I"
						ls_value1 = string(ads_data.GetItemnumber( i, ls_fld_nm ))
					case "D"
						ls_value1 = string(ads_data.GetItemdatetime( i, ls_fld_nm ))
					case else
						ls_value1 = ""
				end choose
				//if lookup get lookup value
//					MessageBox("ls_lookup_type 1", ls_lookup_type)
//					messagebox("ls_fld_nm",ls_fld_nm)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value1) //convert to number
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-60
					//$<modify> 03.23.2006 By: LeiWei
					//$<reason> Performance tuning
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
					ls_value1=gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
					//---------------------------- APPEON END ----------------------------
				elseif ls_lookup_type = "A" then
//					messagebox("in","addr lookup")
//					MessageBox("ls_value1 a", ls_value1)
					ll_new_value = long(ls_value1)
					select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
					//MessageBox("ls_value1 after lookup", ls_value1)
				end if
				
	
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-61
				//$<modify> 03.23.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.
				/*
				//reference 2 info
				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;
				*/
				ls_fld_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(ll_field_id2))
				ls_lookup_type = gnv_data.of_getitem( "sys_fields","lookup_type", "field_id = "+String(ll_field_id2))
				//---------------------------- APPEON END ----------------------------

				ls_fld_type = Upper( ads_data.Describe( ls_fld_nm2 + ".ColType" ) )
				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
					ls_fld_type = "C"
				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
					ls_fld_type = "D"
				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
					ls_fld_type = "N"
				ELSEIF ls_fld_type = "!" THEN
					//messagebox(ls_fld_nm, ads_data.Describe( ls_fld_nm + ".ColType" ) )
					//return -1   //Commented by (Appeon)Harry 05.13.2015 
					ls_fld_type = "O" //(Appeon)Harry 05.13.2015 - For Audit trail and Screen View Util
				ELSE				
					//MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
					Return -1
				END IF
				
				choose case ls_fld_type
					case "C","V"
						ls_value2 = ads_data.GetItemString( i, ls_fld_nm2 )
					case "N", "I"
						ls_value2 = string(ads_data.GetItemnumber( i, ls_fld_nm2 ))
					case "D"
						ls_value2 = string(ads_data.GetItemdatetime( i, ls_fld_nm2 ))
					case else
						ls_value2 = ""
				end choose		
				//MessageBox("ls_lookup_type 2", ls_lookup_type)
				if ls_lookup_type = "C" then
					ll_new_value = long(ls_value2)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> PT-62
					//$<modify> 03.23.2006 By: LeiWei
					//$<reason> Performance tuning
					//$<modification> Write script to retrieve data from a cache instead of from the database.
					/*
					select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
					*/
					ls_value2 = gnv_data.of_getitem( "code_lookup","description", "lookup_code = "+String(ll_new_value))
					//---------------------------- APPEON END ----------------------------
				elseif ls_lookup_type = "A" then
					ll_new_value = long(ls_value2)
					select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
				end if
				//check for nulls
				if isnull(ls_value1) then ls_value1  = ""
				if isnull(ls_value2) then ls_value2  = ""
				ls_new_value = ls_value1 + "-" + ls_value2
				ls_new_value = MidA(ls_new_value,1,100)
				ls_old_value = ls_new_value
		end choose
		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-63
		//$<comment> 02.27.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> The following script moved to the of_field_audit_update function
		//$<modification> to reduce client-server interactions.
		/*
		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
		IF ll_seq_rc > 0 THEN
			ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
		END IF
		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
			ll_seq_no = 1
		ELSE
			ll_seq_no++
		END IF
		*/
		//---------------------------- APPEON END ----------------------------

		if IsNull(ll_rec_id) then return -1 //e.g. delete a new row-  alfee 11.18.2010
		
		li_nr = lds_sys_audit.InsertRow( 0 )
		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
		lds_sys_audit.SetItem( li_nr, "prac_id", ll_prac )					
		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
		lds_sys_audit.SetItem( li_nr, "field_id", 1001 )
		lds_sys_audit.SetItem( li_nr, "old_value", ls_old_value )
		lds_sys_audit.SetItem( li_nr, "new_value", "Deleted" )
		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
		lds_sys_audit.SetItem( li_nr, "audit_type", "D" )					
		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )

// ads_data.RowsDiscard (1, 100,delete! )

//if lds_sys_audit.rowcount() > 1 then maha 102003 trap not completed for multiple staff cat records
//	for i = 1 to ds_sys_audit.rowcount()
//		lds_sys_audit.getItemnumber( i ,"rec_id" )
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-64
//$<comment> 02.27.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script moved to the of_field_audit_update function
//$<modification> to reduce client-server interactions.
/*
IF lds_sys_audit.Update() = -1 THEN
	MessageBox("", "Update to sys_audit table Failed!")
	Return -1
END IF

//Start Code Change ---- 11.03.2005 #18 maha
of_set_mod_date(ll_prac)
//End Code Change---11.03.2005 

COMMIT USING SQLCA;
*/

//THIS.POST of_field_audit_update()
of_field_audit_update()
//---------------------------- APPEON END ----------------------------

RETURN 1

end function

public function string of_create_dynamic_dw_pending (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add);//====================================================================
//$<Function>: of_create_dynamic_dw_pending
//$<Arguments>:
// 	value    long       al_prac_id
// 	value    integer    ai_data_view_id
// 	value    integer    ai_screen_id
// 	value    u_dw       adw_detail
// 	value    u_dw       adw_browse
// 	value    boolean    ab_screen_painter
// 	value    integer    ai_facility_id
// 	value    boolean    ab_add
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.29.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: Alfee 11.09.2013
//====================================================================

SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
integer li_access //maha 05.26.2009
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
string ls_yellow //maha 111909
string ls_background
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
Datastore lds_address_pending
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-31
//$<add> 01.13.2006 By: Luke
//$<reason> Performance tuing
//$<modification> Define variables to be used in subsequent script.
long set1 , ll_recreate
String ls_Bold, ls_italic
//---------------------------- APPEON END ----------------------------

String ls_pk

if isnull(ai_screen_id) or ai_screen_id < 0  then return "-1"	//12.12.2008 By Jervis WorkFlow = -10

ls_white = String(rgb(255,255,255))
ls_grey = "80269524"//String(rgb(192,192,192))
ls_yellow = "8257535"
ls_background = "16120575"

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add a condition to make sure that: 1) DataWindow syntax will be stored in SRD files
//$<modification> in local machine; 2) the application directly gets the DataWindow syntax from local
//$<modification> machine instead of from the database when the same DataWindow is needed for a second time.

If appeongetclienttype() <> 'PB' Then
//	ll_recreate = of_create_option(ai_data_view_id,ai_screen_id,'Y','D',string(idt_screen_cache),ab_screen_painter)
//	If ll_recreate = 0 Then
//		ls_return_syntax = of_create_dynamic_dw_local(al_prac_id,ai_data_view_id,ai_screen_id,adw_detail,adw_browse,ab_screen_painter,ai_facility_id)
//		If ls_return_syntax <> "-1" Then return ls_return_syntax
//	End If
End If
//---------------------------- APPEON END ----------------------------

//debugbreak()

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_UnRegister()		
END IF

app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
//messagebox("", "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
//ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) +" AND sys_fields_field_id <> 11223361")
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) ) //recover billing_address_id by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	

app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
//ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) +" And sys_fields_field_id <> 11223361" )
ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id )  )//recover billing_address_id by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
ids_screen_objects.Filter( )
li_obj_cnt = ids_screen_objects.RowCount()

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0
ls_pk = 'pd_address_change_pending.pending_id,pd_address_change_pending.change_type,pd_address_change_pending.effective_date,pd_address_change_pending.create_date,pd_address_change_pending.create_user,pd_address_change_pending.pending_status,pd_address_change_pending.push_date,pd_address_change_pending.update_status,pd_address_change_pending.error_info,'
ls_sql_syntax = "SELECT "
ls_sql_syntax += ls_pk

li_table_cnt = 0

adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wer  //#####
wer = ids_screen_fields.SetSort( "sort_field A" ) //maha corrected 051005
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD order BY CLAUSE
//IF li_sort_data_cnt > 0 THEN
//	ls_sort_syntax = Mid( ls_sort_syntax, 1, Len( ls_sort_syntax )-1 )
//	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
//else
//	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
//END IF
wer = ids_screen_fields.SetSort( "field_order A" )
//messagebox("field_order",wer)
//ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()

lds_address_pending = create datastore
lds_address_pending.dataobject = 'd_ds_address_pending'

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	if ls_table_name = 'pd_address' then ls_table_name = 'pd_address_change_pending'
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
//	if lower(ls_field_name) = 'send_corresp_here' then continue
	if lds_address_pending.describe( ls_field_name+'.ColType') = '!' then
		continue
	end if
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

destroy lds_address_pending
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/15/2007 By: Jervis
//$<reason> Fix a defect
if li_table_cnt = 0 then
	Messagebox("Caution","Failed to create SELECT syntax for datawindow. ~rPossibly caused by no data view fields for screen_id " + string(ai_screen_id) + " and data_view_id " + string(ai_data_view_id) + ".~r~r" + ls_sql_syntax)
	return '-1'
end if
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

  
//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
//li_test = pos(ls_sql_syntax,"prac_id",1)
	//messagebox("pos",li_test)
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	//if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------	
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "prac_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03/16/2007 By: Jervis
	//$<reason> Fixed a defect
	/*
	li_key_cnt ++
	if pos(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
	*/
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
		li_key_cnt ++
	//---------------------------- APPEON END ----------------------------
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "rec_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	li_key_cnt++
	ls_key_fields_col_nm[li_key_cnt] = "pending_id"
	
	
//	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
//		li_facility_specific = 1
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//		END IF
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03/16/2007 By: Jervis
//		//$<reason> Fixed a defect
//		if PosA(ls_sql_syntax,"facility_id",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "facility_id"
//			end if
//		end if
//		//---------------------------- APPEON END ----------------------------
//
//	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.13.2006 By: Liang QingShi
	//$<reason> Fix a defect in the original unmodified PowerBuilder application. After analyze the
	//$<reason> original application, one constraint is missed in the condition.
	/*
	IF ai_screen_id = 61 THEN
	*/
	//IF ai_screen_id = 61 or ai_screen_id = 33 THEN
//	IF ai_screen_id = 61 or ai_screen_id = 33 or ai_screen_id = 32 THEN	//alfee 09.03.2009
//	//---------------------------- APPEON END ----------------------------
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//		ELSE
//			//ls_key_fields_col_nm[li_key_cnt] = "facility_id" Fixed By Jervis 03/16/2007 is seq_no not facility_id
//			ls_key_fields_col_nm[li_key_cnt] = "seq_no"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//		END IF	
//		
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03/16/2007 By: Jervis
//		//$<reason> Fixed a defect
//		if PosA(ls_sql_syntax,"seq_no",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "seq_no"
//			end if
//		end if
//		//---------------------------- APPEON END ----------------------------
//	END IF	
	
	//Start Code Change ----03.22.2010 #V10 maha - to hide the active and appt_stat_id fields that do not need to be visible.
//	IF ai_screen_id = 65 then // attest questions  
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".active_status, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".active_status"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "active_status"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//		END IF	
//
//		if PosA(ls_sql_syntax,"active_status",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "active_status"
//			end if
//		end if
//		
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".appt_stat_id, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".appt_stat_id"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "appt_stat_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//		END IF	
//
//		if PosA(ls_sql_syntax,"appt_stat_id",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "appt_stat_id"
//			end if
//		end if
//	end if
	
	//End Code Change ----03.22.2010
		
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/16/2007 By: Jervis
//$<reason> Fixed a defect
integer li_row_cnt_new
li_row_cnt_new = UpperBound(ls_field_names)	
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address_change_pending" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	//FOR i = 1 TO li_row_cnt	03/16/2007
	For i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	//FOR i = 1 TO li_row_cnt	03/16/2007
	for i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax

//ADD WHERE CLAUSE - commented by alfee 11.09.2013
//ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )
//IF li_facility_specific = 1 THEN
//	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
//END IF

//Start Code Change ----11.05.2009 #V10 maha
//if PosA(upper(ls_table_name), "PD_ATTEST_QUESTIONS",1) > 0 then
//	ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.active_status in ( 1,4) " 
//end if
//End Code Change---11.05.2009

//CREATE SORT ORDER code moved to top of function //maha 051905

//ADD order BY CLAUSE - commented by alfee 11.09.2013
//IF li_sort_data_cnt > 0 THEN
//	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
//	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
//else
//	ls_sql_syntax = ls_sql_syntax + " ORDER BY pending_id" //maha 111604
//END IF


//CREATE SYNTAX FOR DETAIL DW
ls_presentation_str = "style(type=form)" + " Column(Border=5) Datawindow(Color=" + ls_background + " )" + "Text(Background.Color=" + ls_grey + ")"  
//ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=0)"  //testing
//openwithparm( w_sql_msg, ls_sql_syntax )

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<add> 01.13.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.
If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			CONTINUE
		END IF
		/*
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
		*/
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		//--> Begin change Editmask 
			IF ls_dw_field_names[i] <> "active_status" THEN
				IF ls_mask[i] <> "" THEN
					IF ls_mask[i] = "##" THEN
					ELSEIF ls_mask[i] = "(###)###-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='(###)###-####'"
						Li_appeon_index2 ++					//Comment by Scofield on 2008-08-12
					ELSEIF ls_mask[i] = "###-##-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='###-##-####'"
						Li_appeon_index2 ++
					ELSEIF ls_mask[i] = "#####-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='#####-####'"
						Li_appeon_index2 ++
					END IF
				END IF	
			END IF
			//--< end change Editmask 
	END FOR
	
	//specail code for pd_address_change_pending
	IF ls_table_name = "pd_address_change_pending" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	of_change_to_editmask(ls_dwsyntax_str, ls_editmask_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)

		RETURN "-1"
	END IF
End If
//---------------------------- APPEON END ----------------------------

//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	//ls_grey = String(rgb(192,192,192))

//	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_background + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"


	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-06
	//$<add> 01.13.2006 By: Luke
	//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
	//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
	//$<modification> implement the functionality of changing a column's edit style.
	If appeongetclienttype() <> 'PB' Then
		ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
		li_appeon_index = 1
		
		FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
			IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
				CONTINUE
			END IF
		
			IF ls_dw_field_names[i] = "active_status" THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
			
			IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		END FOR
		
		//specail code for pd_address_change_pending
		IF ls_table_name = "pd_address_change_pending" THEN
			set1 = of_get_app_setting("set_1","I")
			
			if set1 = 1 then //maha 072301 create populate button only if using addresses for find
				ls_appeon_colname[li_appeon_index] = 'street'
				li_appeon_index++
			end if
						
			ls_appeon_colname[li_appeon_index] = 'billing_address_id'
			li_appeon_index++
		END IF
	
		of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
		adw_browse.Create( ls_dwsyntax_str, ERRORS)
		
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution", &
			"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
			clipboard(ls_dwsyntax_str)
			RETURN "-1"
		END IF
	End If
	//---------------------------- APPEON END ----------------------------	
	
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	//li_prac_row_cnt = adw_detail.Retrieve() - commented by alfee 11.09.2013
END IF

//---------Begin Commented by (Appeon)Alfee 11.09.2013-----------------
//IF li_prac_row_cnt = 0 THEN 
//	//Start Code Change ---- 06.09.2006 #531 maha
//	if ai_screen_id = 65 or ai_screen_id = 54 or ab_add = false  then  //Start Code Change ----01.15.2013 #V12 maha - addd ab_add variable
//		if not ab_screen_painter then 
//		//don't add row in prac folder
//		else	
//			adw_detail.InsertRow(0) //maha app081705
//		end if			
//	else
//		adw_detail.InsertRow(0) 
//	end if
//	//End Code Change---06.09.2006
//	
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
//	END IF
//ELSE
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
//	END IF
//	//of_set_defaults( adw_detail, 1 )
//	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
//END IF
//---------End Commented ----------------------------------------------------------------

//debugbreak()
IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	//FOR i = 1 TO li_row_cnt		03/16/2007
	For i = 1 to li_row_cnt_new
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		//IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
		IF PosA( ls_dw_field_names[i], "pending_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
	next
	//03/16/2007 
	li_access = w_mdi.of_security_access( 50 )  //Start Code Change ----05.26.2009 #V92 maha - security
	For i = 1 to li_row_cnt
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 to allow single fields to be read only-//Start Code Change ----05.26.2009 #V92 maha
			//messagebox("display only",ls_dw_field_names[i])
			adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //these values will be reset below
			//adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '553648127'") //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
		end if
	END FOR
END IF
//debugbreak()
IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
//ll_max_height = ll_max_height + 50 
////adw_detail.Object.DataWindow.Detail.Height= 5000 //maha moved to end
//adw_detail.Object.DataWindow.Detail.Height= ll_max_height
adw_detail.Modify("active_status.Initial='1'")
//messagebox("cash",ids_screen_fields.rowcount())
//messagebox("field names",string(upperbound(ls_dw_field_names[])))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Pervformance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") //restored by alfee 03.26.2010 
			//adw_detail.Modify(ls_dw_field_names[i] + "_t.background.color = '" + ls_white + "'") //Start Code Change ----11.19.2009 #V10 maha
		END IF
	else
		adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ----11.19.2009 #V92 maha
	END IF

	IF ab_screen_painter THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-07
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> The "dbname" property is readonly on the Web after migration.
		//$<modification> In order to make the functionality the same to that in PowerBuilder, 
		//$<modification> change it to the writable TabSequence property
		//adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		//adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String( i * 10) + "'" )
		//---------------------------- APPEON END ----------------------------
	ELSE
		
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 - //Start Code Change ----05.26.2009 #V92 maha
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
			adw_detail.Modify( ls_dw_field_names[i] + ".border = '2'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
	//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.height = '8'")	

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
		if ai_screen_id = 73 then adw_detail.Modify( ls_dw_field_names[i] + ".edit.VScrollBar = True") //V11.3 Issue Screen - Alfee 08.05.2011		
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04/01/2008 By: Ken.Guo
	//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
	//UnderLine
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) + "'" )	

	//Italic
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_field_font_italic" ) ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_italic" ) ) + "'" )	

	//Weight
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" )) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_weight" ) ) + "'" )	
	//---------------------------- APPEON END ----------------------------

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		//Start Code Change ----05.09.2013 #V14 maha
//		if is_table_name = "pd_address_change_pending" then
//			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
//		else
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
//		end if
		//Start Code Change ----05.09.2013		
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")	
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '200'")
		adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----12.14.2009 #V92 maha
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.tip='Verification creation: Historical- PSV verification; Inactive- No verification; Active- PSV and expiring verification")
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.enabled= Yes")
		

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		//	adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			//Start Code Change ----05.09.2013 #V14 maha
		//	if is_table_name = "pd_address_change_pending" then
		//		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
	//		else
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
	//		end if
			//Start Code Change ----05.09.2013		
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '" + ls_yellow +  "'")//Start Code Change ----12.14.2009 #V10 maha
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")//for a Web version issue - alfee 09.07.2011
				IF ib_create_browse = True THEN				
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011
				END IF
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2007.08.11 By: Jack
				//$<reason> Fix a defect.	
				
				/*
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 09.07.2006 By: Liang QingShi
				//$<reason> Fix a defect.
				/*
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				*/
				
				IF appeongetclienttype() = 'PB' THEN
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
					END IF
				ELSE
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")						
					END IF
				END IF
				//---------------------------- APPEON END ----------------------------
				*/
				
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
			END IF
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

//Start Code Change ---- 12.15.2005 #170 maha
//		IF ls_lookup_type = "A" THEN
//			app_filler.ids_address_dddw.ShareData( dwchild )
//			dwchild.SetFilter( "lookup_name = '" + ls_lookup_code + "'" )
//			dwchild.Filter()	
//		ELSEif ls_lookup_type = "C" THEN
//			dwchild.Retrieve(ls_lookup_code)
//		ELSEif ls_lookup_type = "Q" THEN
//			dwchild.Retrieve()	
//		END IF		


		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		dwchild.ShareData( dwchild_browse )
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			//adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes") //for pending changes
			adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----11.19.2009 #V92 maha
					//	yellow 65535
		 
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )	
			elseif ls_mask[i] = "INTPHONE" THEN //Start Code Change ----02.02.2009 #V92 maha - added for dclick format phone function
				//do nothing for int phone
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-34
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label.

gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)
//---------------------------- APPEON END ----------------------------


//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()
// messagebox("li_row_cnt",li_row_cnt)
 // messagebox("cols",cc)
  // messagebox("fields",wer)
if  ib_create_browse = True then
	for i = 1 to li_row_cnt//ids_screen_fields.rowcount()
		adw_browse.Modify( ls_field_names[i] + ".TabSequence = '0'" )
	next
end if

//clipboard(adw_detail.Describe("datawindow.syntax"))
FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR

IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
	adw_detail.of_SetReqColumn(TRUE)
END IF

//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  ) - commented by Alfee 04.28.2009


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			//------------------- APPEON BEGIN -------------------
			//$<modify> Evan 12.14.2010
			//$<reason> add bold, italic and underline properties.
			//adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			//------------------- APPEON END ---------------------
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-08-31 By: Liu HongXin
			//$<reason> 
			/*
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")" )
			*/
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
			//---------------------------- APPEON END ----------------------------

	END CHOOSE
END FOR
//Start Code Change ---- 01.18.2006 #203 maha
IF (ls_table_name = "pd_address_change_pending" or ls_table_name = "dba.pd_address_change_pending") and li_access = 2 THEN //alfee 06.01.2009
//IF ls_table_name = "pd_address_change_pending" or ls_table_name = "dba.pd_address_change_pending" and li_access = 2 THEN //maha 011806   //Start Code Change ----05.26.2009 #V92 maha - access added
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	//Start Code Change ----02.08.2013 #V12 maha - moved to selection changed event
//	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
//	set1 = of_get_app_setting("set_1","I")
////Start Code Change ----02.08.2013 #V12 maha - removed support for legacy populate button
//	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
//		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
//		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
//		adw_detail.Modify( "street.dddw.useasborder = Yes")			
//		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
//		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
//		//adw_detail.Modify( "street.dddw.Lines= 15")
//		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
//		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
//		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
//		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
//	end if
	
	//add drop down for billing address //uncomment by Appeon long.zhang 04.28.2015 (Bug id 4507  Billing address field missing)
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF
//		des = dwchild.Describe("DataWindow.Objects")
//			openwithparm(w_sql_msg,des)
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF

//Start Code Change ----02.08.2013 #V12 maha - moved to selection chenged event
//IF (ls_table_name = "pd_references" or ls_table_name = "dba.pd_references") and li_access = 2 THEN //alfee 06.01.2009
////IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" and li_access = 2 THEN //maha 011806   //Start Code Change ----05.26.2009 #V92 maha - access added
////End Code Change---01.18.2005 
//	li_set = of_get_app_setting("set_5","I")
//	if li_set = 0 then
//		//messagebox("","ref button")
//		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
//		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
//	end if
//end if
//\maha

IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if
//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ll_max_height)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
if AppeonGetClientType() <> "PB" then // Evan 02.10.2009
//	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
//	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
end if
//---------------------------- APPEON END ----------------------------
if ab_screen_painter = true then adw_detail.hscrollbar = true

//string ls_test_syn
//ls_test_syn = adw_detail.Describe("DataWindow.Syntax")
//openwithparm(w_sql_msg,ls_test_syn)

RETURN ls_return_syntax

end function

public function string of_create_dynamic_dw_pending_bk (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add, long al_rec_id);//====================================================================
//$<Function>: of_create_dynamic_dw_pending
//$<Arguments>:
// 	value    long       al_prac_id
// 	value    integer    ai_data_view_id
// 	value    integer    ai_screen_id
// 	value    u_dw       adw_detail
// 	value    u_dw       adw_browse
// 	value    boolean    ab_screen_painter
// 	value    integer    ai_facility_id
// 	value    boolean    ab_add
// 	value    long       al_rec_id
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.29.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

//For backup only - callled in w_pending_changes_address_bk - alfee 11.09.2013

SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
integer li_access //maha 05.26.2009
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
string ls_yellow //maha 111909
string ls_background
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
Datastore lds_address_pending
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-31
//$<add> 01.13.2006 By: Luke
//$<reason> Performance tuing
//$<modification> Define variables to be used in subsequent script.
long set1 , ll_recreate
String ls_Bold, ls_italic
//---------------------------- APPEON END ----------------------------

String ls_pk

if isnull(ai_screen_id) or ai_screen_id < 0  then return "-1"	//12.12.2008 By Jervis WorkFlow = -10

ls_white = String(rgb(255,255,255))
ls_grey = "80269524"//String(rgb(192,192,192))
ls_yellow = "8257535"
ls_background = "16120575"

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add a condition to make sure that: 1) DataWindow syntax will be stored in SRD files
//$<modification> in local machine; 2) the application directly gets the DataWindow syntax from local
//$<modification> machine instead of from the database when the same DataWindow is needed for a second time.

If appeongetclienttype() <> 'PB' Then
//	ll_recreate = of_create_option(ai_data_view_id,ai_screen_id,'Y','D',string(idt_screen_cache),ab_screen_painter)
//	If ll_recreate = 0 Then
//		ls_return_syntax = of_create_dynamic_dw_local(al_prac_id,ai_data_view_id,ai_screen_id,adw_detail,adw_browse,ab_screen_painter,ai_facility_id)
//		If ls_return_syntax <> "-1" Then return ls_return_syntax
//	End If
End If
//---------------------------- APPEON END ----------------------------

//debugbreak()

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

IF adw_detail = adw_browse THEN
	ib_create_browse = False
END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

//UNREGISTER ALL CALENDAR FIELDS
IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_UnRegister()		
END IF

app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
//messagebox("", "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) +" AND sys_fields_field_id <> 11223361")
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	

app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) +" And sys_fields_field_id <> 11223361" )
ids_screen_objects.Filter( )
li_obj_cnt = ids_screen_objects.RowCount()

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0
ls_pk = 'pd_address_change_pending.pending_id,pd_address_change_pending.change_type,pd_address_change_pending.effective_date,pd_address_change_pending.create_date,pd_address_change_pending.create_user,pd_address_change_pending.pending_status,pd_address_change_pending.push_date,pd_address_change_pending.update_status,pd_address_change_pending.error_info,'
ls_sql_syntax = "SELECT "
ls_sql_syntax += ls_pk

li_table_cnt = 0

adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wer  //#####
wer = ids_screen_fields.SetSort( "sort_field A" ) //maha corrected 051005
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR
//ADD order BY CLAUSE
//IF li_sort_data_cnt > 0 THEN
//	ls_sort_syntax = Mid( ls_sort_syntax, 1, Len( ls_sort_syntax )-1 )
//	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
//else
//	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
//END IF
wer = ids_screen_fields.SetSort( "field_order A" )
//messagebox("field_order",wer)
//ids_screen_fields.SetSort( "field_sort A" )
ids_screen_fields.Sort()

lds_address_pending = create datastore
lds_address_pending.dataobject = 'd_ds_address_pending'

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	if ls_table_name = 'pd_address' then ls_table_name = 'pd_address_change_pending'
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
//	if lower(ls_field_name) = 'send_corresp_here' then continue
	if lds_address_pending.describe( ls_field_name+'.ColType') = '!' then
		continue
	end if
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	//if i < 2 then messagebox(ls_field_names[i],ls_field_label_height[i])
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

destroy lds_address_pending
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/15/2007 By: Jervis
//$<reason> Fix a defect
if li_table_cnt = 0 then
	Messagebox("Caution","Failed to create SELECT syntax for datawindow. ~rPossibly caused by no data view fields for screen_id " + string(ai_screen_id) + " and data_view_id " + string(ai_data_view_id) + ".~r~r" + ls_sql_syntax)
	return '-1'
end if
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )

li_row_cnt = UpperBound(ls_field_names)

  
//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
//li_test = pos(ls_sql_syntax,"prac_id",1)
	//messagebox("pos",li_test)
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	//if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------		
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "prac_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03/16/2007 By: Jervis
	//$<reason> Fixed a defect
	/*
	li_key_cnt ++
	if pos(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
	*/
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
		li_key_cnt ++
	//---------------------------- APPEON END ----------------------------
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			//---------------------------- APPEON END ----------------------------
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/16/2007 By: Jervis
			//$<reason> Fixed a defect
			ls_field_names[upperbound(ls_field_names) + 1] = "rec_id"
			//---------------------------- APPEON END ----------------------------

		END IF
	end if
	
	li_key_cnt++
	ls_key_fields_col_nm[li_key_cnt] = "pending_id"
	
	
//	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
//		li_facility_specific = 1
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
//		END IF
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03/16/2007 By: Jervis
//		//$<reason> Fixed a defect
//		if PosA(ls_sql_syntax,"facility_id",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "facility_id"
//			end if
//		end if
//		//---------------------------- APPEON END ----------------------------
//
//	END IF
	
	//added for tables with seq_no fields   JAD-6/06/02
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.13.2006 By: Liang QingShi
	//$<reason> Fix a defect in the original unmodified PowerBuilder application. After analyze the
	//$<reason> original application, one constraint is missed in the condition.
	/*
	IF ai_screen_id = 61 THEN
	*/
	//IF ai_screen_id = 61 or ai_screen_id = 33 THEN
//	IF ai_screen_id = 61 or ai_screen_id = 33 or ai_screen_id = 32 THEN	//alfee 09.03.2009
//	//---------------------------- APPEON END ----------------------------
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//		ELSE
//			//ls_key_fields_col_nm[li_key_cnt] = "facility_id" Fixed By Jervis 03/16/2007 is seq_no not facility_id
//			ls_key_fields_col_nm[li_key_cnt] = "seq_no"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
//		END IF	
//		
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 03/16/2007 By: Jervis
//		//$<reason> Fixed a defect
//		if PosA(ls_sql_syntax,"seq_no",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "seq_no"
//			end if
//		end if
//		//---------------------------- APPEON END ----------------------------
//	END IF	
	
	//Start Code Change ----03.22.2010 #V10 maha - to hide the active and appt_stat_id fields that do not need to be visible.
//	IF ai_screen_id = 65 then // attest questions  
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".active_status, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".active_status"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "active_status"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
//		END IF	
//
//		if PosA(ls_sql_syntax,"active_status",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "active_status"
//			end if
//		end if
//		
//		li_key_cnt ++
//		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".appt_stat_id, "
//		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".appt_stat_id"
//		IF li_table_cnt > 1 THEN
//			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//		ELSE
//			ls_key_fields_col_nm[li_key_cnt] = "appt_stat_id"
//			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
//		END IF	
//
//		if PosA(ls_sql_syntax,"appt_stat_id",1) = 0 then
//			if li_table_cnt > 1 then
//				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
//			else
//				ls_field_names[upperbound(ls_field_names) + 1] = "appt_stat_id"
//			end if
//		end if
//	end if
	
	//End Code Change ----03.22.2010
		
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/16/2007 By: Jervis
//$<reason> Fixed a defect
integer li_row_cnt_new
li_row_cnt_new = UpperBound(ls_field_names)	
//---------------------------- APPEON END ----------------------------

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//IF ls_table_name = "pd_address_change_pending" THEN  // instead of following run 2.0 update group Practice button.
//	ls_sql_syntax = ls_sql_syntax + ", gp_id"
//END IF
//messagebox("", ls_sql_syntax)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	//FOR i = 1 TO li_row_cnt	03/16/2007
	For i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	//FOR i = 1 TO li_row_cnt	03/16/2007
	for i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )


IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//Start Code Change ----11.05.2009 #V10 maha
//if PosA(upper(ls_table_name), "PD_ATTEST_QUESTIONS",1) > 0 then
//	ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.active_status in ( 1,4) " 
//end if
//End Code Change---11.05.2009

//CREATE SORT ORDER code moved to top of function //maha 051905

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
else
	ls_sql_syntax = ls_sql_syntax + " ORDER BY pending_id" //maha 111604
END IF

//CREATE SYNTAX FOR DETAIL DW

ls_presentation_str = "style(type=form)" + " Column(Border=5) Datawindow(Color=" + ls_background + " )" + "Text(Background.Color=" + ls_grey + ")"  
//ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_grey + " )" + "Text(Background.Color=0)"  //testing
//openwithparm( w_sql_msg, ls_sql_syntax )

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<add> 01.13.2006 By: Luke
//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
//$<modification> implement the functionality of changing a column's edit style.
If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			CONTINUE
		END IF
		/*
		IF ls_dw_field_names[i] = "active_status" THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
		*/
		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		//--> Begin change Editmask 
			IF ls_dw_field_names[i] <> "active_status" THEN
				IF ls_mask[i] <> "" THEN
					IF ls_mask[i] = "##" THEN
					ELSEIF ls_mask[i] = "(###)###-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='(###)###-####'"
						Li_appeon_index2 ++					//Comment by Scofield on 2008-08-12
					ELSEIF ls_mask[i] = "###-##-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='###-##-####'"
						Li_appeon_index2 ++
					ELSEIF ls_mask[i] = "#####-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='#####-####'"
						Li_appeon_index2 ++
					END IF
				END IF	
			END IF
			//--< end change Editmask 
	END FOR
	
	//specail code for pd_address_change_pending
	IF ls_table_name = "pd_address_change_pending" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	of_change_to_editmask(ls_dwsyntax_str, ls_editmask_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)

		RETURN "-1"
	END IF
End If
//---------------------------- APPEON END ----------------------------

//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	//ls_grey = String(rgb(192,192,192))

//	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_grey + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_background + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"


	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-06
	//$<add> 01.13.2006 By: Luke
	//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
	//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
	//$<modification> implement the functionality of changing a column's edit style.
	If appeongetclienttype() <> 'PB' Then
		ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
		li_appeon_index = 1
		
		FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
			IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
				CONTINUE
			END IF
		
			IF ls_dw_field_names[i] = "active_status" THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
			
			IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		END FOR
		
		//specail code for pd_address_change_pending
		IF ls_table_name = "pd_address_change_pending" THEN
			set1 = of_get_app_setting("set_1","I")
			
			if set1 = 1 then //maha 072301 create populate button only if using addresses for find
				ls_appeon_colname[li_appeon_index] = 'street'
				li_appeon_index++
			end if
						
			ls_appeon_colname[li_appeon_index] = 'billing_address_id'
			li_appeon_index++
		END IF
	
		of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
		adw_browse.Create( ls_dwsyntax_str, ERRORS)
		
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution", &
			"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
			clipboard(ls_dwsyntax_str)
			RETURN "-1"
		END IF
	End If
	//---------------------------- APPEON END ----------------------------	
	
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	//Start Code Change ---- 06.09.2006 #531 maha
	if ai_screen_id = 65 or ai_screen_id = 54 or ab_add = false  then  //Start Code Change ----01.15.2013 #V12 maha - addd ab_add variable
		if not ab_screen_painter then 
		//don't add row in prac folder
		else	
			adw_detail.InsertRow(0) //maha app081705
		end if
			
	else
		adw_detail.InsertRow(0) 
	end if
	//End Code Change---06.09.2006
	
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

//debugbreak()
IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	//FOR i = 1 TO li_row_cnt		03/16/2007
	For i = 1 to li_row_cnt_new
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		//IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
		IF PosA( ls_dw_field_names[i], "pending_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
	next
	//03/16/2007 
	li_access = w_mdi.of_security_access( 50 )  //Start Code Change ----05.26.2009 #V92 maha - security
	For i = 1 to li_row_cnt
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 to allow single fields to be read only-//Start Code Change ----05.26.2009 #V92 maha
			//messagebox("display only",ls_dw_field_names[i])
			adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //these values will be reset below
			//adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '553648127'") //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
		end if
	END FOR
END IF
//debugbreak()
IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF
//messagebox("",  Long( adw_detail.Object.DataWindow.Detail.Height) )
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > 1800 THEN
//IF Long( adw_detail.Object.DataWindow.Detail.Height) > ( adw_detail.Height + 50 ) THEN
//ll_max_height = ll_max_height + 50 
////adw_detail.Object.DataWindow.Detail.Height= 5000 //maha moved to end
//adw_detail.Object.DataWindow.Detail.Height= ll_max_height
adw_detail.Modify("active_status.Initial='1'")
//messagebox("cash",ids_screen_fields.rowcount())
//messagebox("field names",string(upperbound(ls_dw_field_names[])))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Pervformance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF
	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") //restored by alfee 03.26.2010 
			//adw_detail.Modify(ls_dw_field_names[i] + "_t.background.color = '" + ls_white + "'") //Start Code Change ----11.19.2009 #V10 maha
		END IF
	else
		adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ----11.19.2009 #V92 maha
	END IF

	IF ab_screen_painter THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-07
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> The "dbname" property is readonly on the Web after migration.
		//$<modification> In order to make the functionality the same to that in PowerBuilder, 
		//$<modification> change it to the writable TabSequence property
		//adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		//adw_detail.Modify( ls_dw_field_names[i] + ".dbname = '" + String( i * 10) + "'" )
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String( i * 10) + "'" )
		//---------------------------- APPEON END ----------------------------
	ELSE
		
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 - //Start Code Change ----05.26.2009 #V92 maha
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
			adw_detail.Modify( ls_dw_field_names[i] + ".border = '2'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
	//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.height = '8'")	

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
		if ai_screen_id = 73 then adw_detail.Modify( ls_dw_field_names[i] + ".edit.VScrollBar = True") //V11.3 Issue Screen - Alfee 08.05.2011		
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04/01/2008 By: Ken.Guo
	//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
	//UnderLine
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) + "'" )	

	//Italic
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_field_font_italic" ) ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_italic" ) ) + "'" )	

	//Weight
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" )) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_weight" ) ) + "'" )	
	//---------------------------- APPEON END ----------------------------

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		//Start Code Change ----05.09.2013 #V14 maha
//		if is_table_name = "pd_address_change_pending" then
//			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
//		else
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
//		end if
		//Start Code Change ----05.09.2013		
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")	
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '200'")
		adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----12.14.2009 #V92 maha
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.tip='Verification creation: Historical- PSV verification; Inactive- No verification; Active- PSV and expiring verification")
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.enabled= Yes")
		

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		//	adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			//Start Code Change ----05.09.2013 #V14 maha
		//	if is_table_name = "pd_address_change_pending" then
		//		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
	//		else
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
	//		end if
			//Start Code Change ----05.09.2013		
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF
		IF UPPER(ls_lookup_field) = "ENTITY_NAME" THEN

		END IF
	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '" + ls_yellow +  "'")//Start Code Change ----12.14.2009 #V10 maha
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")//for a Web version issue - alfee 09.07.2011
				IF ib_create_browse = True THEN				
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011
				END IF
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2007.08.11 By: Jack
				//$<reason> Fix a defect.	
				
				/*
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 09.07.2006 By: Liang QingShi
				//$<reason> Fix a defect.
				/*
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				*/
				
				IF appeongetclienttype() = 'PB' THEN
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
					END IF
				ELSE
					adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")			
					IF ib_create_browse = True THEN								
						adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name_original'")						
					END IF
				END IF
				//---------------------------- APPEON END ----------------------------
				*/
				
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
			END IF
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

//Start Code Change ---- 12.15.2005 #170 maha
//		IF ls_lookup_type = "A" THEN
//			app_filler.ids_address_dddw.ShareData( dwchild )
//			dwchild.SetFilter( "lookup_name = '" + ls_lookup_code + "'" )
//			dwchild.Filter()	
//		ELSEif ls_lookup_type = "C" THEN
//			dwchild.Retrieve(ls_lookup_code)
//		ELSEif ls_lookup_type = "Q" THEN
//			dwchild.Retrieve()	
//		END IF		


		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		dwchild.ShareData( dwchild_browse )
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			//adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----11.19.2009 #V92 maha
					//	yellow 65535
		 
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )	
			elseif ls_mask[i] = "INTPHONE" THEN //Start Code Change ----02.02.2009 #V92 maha - added for dclick format phone function
				//do nothing for int phone
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-34
//$<add> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label.

gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)
//---------------------------- APPEON END ----------------------------


//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()
// messagebox("li_row_cnt",li_row_cnt)
 // messagebox("cols",cc)
  // messagebox("fields",wer)
if  ib_create_browse = True then
	for i = 1 to li_row_cnt//ids_screen_fields.rowcount()
		adw_browse.Modify( ls_field_names[i] + ".TabSequence = '0'" )
	next
end if

//clipboard(adw_detail.Describe("datawindow.syntax"))
FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR

IF NOT ab_screen_painter THEN
	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
	adw_detail.of_SetReqColumn(TRUE)
END IF

//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height) - 200)

//messagebox("ls_detail_band_height",ls_detail_band_height)

adw_detail.SetRedraw(True)

//adw_detail.Modify("create groupbox(band=detail text='End of Detail border='5' color='255' x='1' y='" + ls_detail_band_height + "' height='50' width='3000'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=detail_band)"  ) - commented by Alfee 04.28.2009


//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			//------------------- APPEON BEGIN -------------------
			//$<modify> Evan 12.14.2010
			//$<reason> add bold, italic and underline properties.
			//adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='128' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )
			//------------------- APPEON END ---------------------
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-08-31 By: Liu HongXin
			//$<reason> 
			/*
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name +")" )
			*/
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
			//---------------------------- APPEON END ----------------------------

	END CHOOSE
END FOR
//Start Code Change ---- 01.18.2006 #203 maha
IF (ls_table_name = "pd_address_change_pending" or ls_table_name = "dba.pd_address_change_pending") and li_access = 2 THEN //alfee 06.01.2009
//IF ls_table_name = "pd_address_change_pending" or ls_table_name = "dba.pd_address_change_pending" and li_access = 2 THEN //maha 011806   //Start Code Change ----05.26.2009 #V92 maha - access added
	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
	
	//address drop down
	//Start Code Change ----02.08.2013 #V12 maha - moved to selection changed event
//	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
	
//	integer set1
//	select set_1
//	into :set1
//	from icred_settings;
//	set1 = of_get_app_setting("set_1","I")
////Start Code Change ----02.08.2013 #V12 maha - removed support for legacy populate button
//	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
//		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
//		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
//		adw_detail.Modify( "street.dddw.useasborder = Yes")			
//		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
//		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
//		//adw_detail.Modify( "street.dddw.Lines= 15")
//		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
//		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
//		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
//		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
//	end if
	
	//add drop down for billing address
//	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
//	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
//	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
//	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
//	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
//	adw_detail.Modify( "billing_address_id.dddw.Required = No")
//	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
//	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_change_pending_rec_id'")			
//	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
//	res  = adw_detail.GetChild( "billing_address_id", dwchild )
//	if res = 1 then
//		IF LenA( ls_retval ) = 0 THEN
//			dwchild.SetTransObject( SQLCA )
//			dwchild.Retrieve( al_prac_id )
//		END IF
////		des = dwchild.Describe("DataWindow.Objects")
////			openwithparm(w_sql_msg,des)
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_change_pending_street", "N/A" )	
//		dwchild.SetItem( 1, "pd_address_change_pending_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//		dwchild.SetItem( 1, "pd_address_change_pending_rec_id", -1 )	
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_change_pending_street", "Same" )	
//		dwchild.SetItem( 1, "pd_address_change_pending_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//		dwchild.SetItem( 1, "pd_address_change_pending_rec_id", 0 )
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_change_pending_street", "" )	
//		dwchild.SetItem( 1, "pd_address_change_pending_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//	end if
	
END IF

//Start Code Change ----02.08.2013 #V12 maha - moved to selection chenged event
//IF (ls_table_name = "pd_references" or ls_table_name = "dba.pd_references") and li_access = 2 THEN //alfee 06.01.2009
////IF ls_table_name = "pd_references" or ls_table_name = "dba.pd_references" and li_access = 2 THEN //maha 011806   //Start Code Change ----05.26.2009 #V92 maha - access added
////End Code Change---01.18.2005 
//	li_set = of_get_app_setting("set_5","I")
//	if li_set = 0 then
//		//messagebox("","ref button")
//		adw_detail.Modify("create button(band=detail text='Select Peer' filename=''action='0' border='1' color='128' x='1102' y='1285' height='85' width='400' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
//		if ll_max_height < 1400 then ll_max_height = 1400 //maha 060805 button was disappearing
//	end if
//end if
//\maha

IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if
//adw_detail.Object.DataWindow.Detail.Height.AutoSize  //maha 092702 playing with size
//ls_detail_band_height = String(Integer(adw_detail.Object.DataWindow.Detail.Height))
//messagebox("ls_detail_band_height",ll_max_height)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
if AppeonGetClientType() <> "PB" then // Evan 02.10.2009
//	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
//	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
end if
//---------------------------- APPEON END ----------------------------
if ab_screen_painter = true then adw_detail.hscrollbar = true

//string ls_test_syn
//ls_test_syn = adw_detail.Describe("DataWindow.Syntax")
//openwithparm(w_sql_msg,ls_test_syn)

RETURN ls_return_syntax

end function

public function integer of_get_id_count (n_ds ads_cache, long ai_facility_ids[]);//Start Code Change ----06.04.2014 #V14.2 maha - added copied from pfc_ia_cst_nv_net_dev_new
long	ll_id_count = 0
long	ll_i , ll_find

For ll_i = 1 To upperbound(ai_facility_ids[])
	ll_find = ads_cache.find("parent_facility_id = "  +string(ai_facility_ids[ll_i]) , 1 , ads_cache.Rowcount())
	If not ll_find > 0 Then ll_id_count++
Next

return ll_id_count
end function

public function integer of_add_data_links (long al_prac_id, string as_from);//Start Code Change ----05.07.2014 #V14.2 maha - added
Long rc
Integer r
Integer nr
Integer f
Integer fc
Integer facid
Long recid
Long spec
Long prac[]
Long pracing
Long runcnt = 0
Integer p
integer u
integer lc
integer ac
integer a
Long pc
Integer s
Long sc
Long ll_rowcount
string findfield
datastore lds_affil
datastore lds_hosp
datastore lds_hlink

lds_affil = create datastore
lds_hosp = create datastore
lds_hlink = create datastore

lds_affil.dataobject = "d_prac_affils"
lds_affil.settransobject(sqlca)
ac = lds_affil.retrieve(al_prac_id)

For u = 1 to 3
	Choose Case u
		Case 1
			lds_hosp.DataObject = "d_addresses_for_prac"
			lds_hlink.DataObject = "d_addr_link_prac"
			findfield = "rec_id"
			pracing = 0
		Case 2
			lds_hosp.DataObject = "d_hosp_for_prac"
			lds_hlink.DataObject = "d_hf_link_prac"
			findfield = "rec_id"
			pracing = 581
		Case 3
			lds_hosp.DataObject = "d_spec_for_prac"
			lds_hlink.DataObject = "d_spec_link_prac"
			findfield = "rec_id"
			pracing = 581
	End Choose

	lds_hlink.SetTransObject(sqlca)
	lds_hosp.SetTransObject(sqlca)
	
	rc = lds_hosp.Retrieve(al_prac_id)
	lc = lds_hlink.Retrieve(al_prac_id)


	For r = 1 To rc
		recid = lds_hosp.GetItemNumber(r,"rec_id")
		for a = 1 to ac
			facid = lds_affil.getitemnumber(a,"parent_facility_id")
			f = lds_hlink.find( findfield + " = " + string(recid) + " and  facility_id = " + string(facid),1, lc)
			if f < 0 then
				messagebox("","Program error")
				return - 1
			elseif f > 0 then
				continue
			else  //create link record
				runcnt++
				nr = lds_hlink.InsertRow(0)
				lds_hlink.SetItem(nr,"rec_id",recid)
				lds_hlink.SetItem(nr,"facility_id",facid)
				lds_hlink.SetItem(nr,"p_set",pracing)
				lds_hlink.SetItem(nr,"prac_id",al_prac_id)
				If u = 1 Then //addresses
					lds_hlink.SetItem(nr,"billing",0)
					lds_hlink.SetItem(nr,"home_address",0)
					lds_hlink.SetItem(nr,"primary_office",0)
					lds_hlink.SetItem(nr,"additional_office",0)
					lds_hlink.SetItem(nr,"exp_letters",0)
					lds_hlink.SetItem(nr,"include_in_directory",0)
				End If
			end if
		next //facility record
	Next //data record
	
	lds_hlink.Update()
	Commit Using sqlca;
Next

destroy lds_affil
destroy lds_hosp
destroy lds_hlink

return 1
end function

public function integer of_create_checklist (long al_temp, string as_app_type, long al_appt_stat_id, long al_parent, long al_prac_id);//Start Code Change ----06.04.2014 #V14.2 maha - copied from of_copy_required_data (appointment status) and modified for checklist creation

n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds idw_rqrd_data
n_ds idw_audit
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
integer ll_template[]
Long ll_appt_stat_id
String ls_types[]
Long   ll_app_audit_id_old = -1
long ll_insrow
string ls_filter

ll_template[1] = al_temp
ls_types[1] = as_app_type  //going to be 'I' from applications tab
ls_types[2] = "B"

idw_rqrd_data = create n_ds
idw_rqrd_data.dataobject = 'd_app_audit_rqrd_data_all_pt'
idw_rqrd_data.settransobject(sqlca)
idw_rqrd_data.retrieve(ll_template,ls_types)

idw_audit = create n_ds
idw_audit.dataobject = 'd_pd_app_audit_rqrd_data'
idw_audit.settransobject(sqlca)


choose case as_app_type
	case "I","R"
		ls_filter = "facility_id="+string(al_temp) + " and (upper(app_type)='" + upper(as_app_type) + "' or upper(app_type)= 'B')"
	case else  //anything else return
		return 0
end choose

li_row_cnt = idw_rqrd_data.setfilter(ls_filter)
li_row_cnt = idw_rqrd_data.filter()
li_row_cnt = idw_rqrd_data.RowCount()

if li_row_cnt = 0 then return 0

SELECT ids.record_id  
INTO :ll_record_id
FROM ids;

UPDATE ids  
SET record_id = :ll_record_id  + :li_row_cnt;


idw_rqrd_data.setsort( "app_audit_id A")
idw_rqrd_data.sort( )

FOR i = 1 TO li_row_cnt
	integer li_auto_generate
	li_auto_generate = idw_rqrd_data.getitemnumber(i,'auto_generate')
	if li_auto_generate = 1 then
		continue
	end if

	ll_insrow = idw_audit.InsertRow( 0 )

	ll_record_id = ll_record_id + 1
		
	ll_app_audit_id = idw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	idw_audit.SetItem( ll_insrow, "rec_id", ll_record_id )
	idw_audit.SetItem( ll_insrow, "appt_stat_id", al_appt_stat_id )
	idw_audit.SetItem( ll_insrow, "prac_id", al_prac_id )
	idw_audit.SetItem( ll_insrow, "facility_id", al_parent ) 
	idw_audit.SetItem( ll_insrow, "app_audit_id", ll_app_audit_id )
	idw_audit.SetItem( ll_insrow, "seq_no", 1	) 		
	idw_audit.SetItem( ll_insrow, "active_status", 1 )
	idw_audit.SetItem( ll_insrow, "pd_app_audit_fax_message", idw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	idw_audit.SetItem( ll_insrow, "description", idw_rqrd_data.GetItemString( i, "description" )	) 		
	idw_audit.SetItem( ll_insrow, "app_type", idw_rqrd_data.GetItemString( i, "app_type" )	)		

END FOR

idw_audit.update()

//---------------------------- APPEON END ----------------------------

RETURN 0
end function

public function string of_change_dddw (datastore ads_data, string as_column, string as_value);//====================================================================
//$<Function>: of_change_dddw
//$<Arguments>:
// 	value    datastore       ads_data
// 	value    string    as_column
// 	value    string    as_value
//$<Return>:  string
//$<Description>: Return display value in dddw
//$<Author>: (Appeon) Harry 04.09.2015 (Allegheny Audit Report - Altschuler, Eric Case#53159 Bug 4478)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================
String ls_new_value, ls_displayname, ls_dataname, ls_field_type
Long ll_findrow
long  ll_prac_id, ll_data

DataWindowChild ldwc_child

if ads_data.GetChild(as_column, ldwc_child) <> 1 then return ''

ls_displayname = ads_data.Describe(as_column + ".DDDW.DisplayColumn")
ls_dataname = ads_data.Describe(as_column + ".DDDW.DataColumn")

if ls_displayname = ls_dataname then return as_value
//---------Begin Added by (Appeon)Stephen 12.23.2015 for IPN billing address ID change values not recorded in the audit trail--------
ldwc_child.settransobject(sqlca)
if ldwc_child.rowcount() < 1 then //(Appeon)Stephen 07.19.2017 - Bug id 5719 - Workflow Step Execution Lag Issue V15.3 SaaS Build 06232017
	choose case lower(as_column)
		case "billing_address_id", "gp_id", "gp_id_1", "address_id"
			ll_prac_id = ads_data.getitemnumber(1, "prac_id")
			ldwc_child.retrieve(ll_prac_id)
		case "verifying_facility", "parent_facility_id", "pd_images_facility_id"
			ldwc_child.retrieve(gs_user_id)
		case "committee_id"
			ll_data = ads_data.getitemnumber(1, "facility_id")
			ldwc_child.retrieve(ll_data)		
		case "plan_type" //(Appeon)Stephen 07.08.2016 ---BugH062801
			ldwc_child.retrieve("Plan Type")	
		case "tier" //(Appeon)Stephen 07.08.2016 ---BugH062801
			ldwc_child.retrieve("Tier")	
		case else
			ldwc_child.retrieve()
	end choose
end if
if ldwc_child.rowcount() < 1 then return as_value
//---------End Added ------------------------------------------------------

ls_field_type =Upper( ldwc_child.Describe(ls_dataname + ".coltype"))
if PosA(ls_field_type, "CHAR") > 0 then
	ll_findrow = ldwc_child.find(ls_dataname + "='" + as_value +"'", 1, ldwc_child.rowcount())
elseif PosA(ls_field_type, "LONG") > 0 or PosA(ls_field_type, "DECIMAL") > 0 or PosA(ls_field_type, "REAL") > 0 then
	ll_findrow = ldwc_child.find(ls_dataname + "=" + as_value , 1, ldwc_child.rowcount())
end if

if ll_findrow > 0 then
	ls_field_type = Upper(ldwc_child.Describe(ls_displayname + ".ColType"))
	if PosA(ls_field_type, "CHAR") > 0 then
		ls_new_value = ldwc_child.getitemstring(ll_findrow, ls_displayname)
	//elseif PosA(ls_field_type, "DATE") > 0 then
	elseif PosA(ls_field_type, "LONG") > 0 or PosA(ls_field_type, "DECIMAL") > 0 or PosA(ls_field_type, "REAL") > 0 then
		ls_new_value = String( ldwc_child.getitemnumber(ll_findrow, ls_displayname))
	else
	end if
end if

return ls_new_value
end function

public function string of_change_ddlb (datastore ads_data, string as_column, string as_value);//====================================================================
//$<Function>: of_change_ddlb
//$<Arguments>:
// 	value    datastore       ads_data
// 	value    string    as_column
// 	value    string    as_value
//$<Return>:  string
//$<Description>: Return display value in ddlb
//$<Author>: (Appeon) Harry 04.09.2015 (Allegheny Audit Report - Altschuler, Eric Case#53159 Bug 4478)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

String ls_new_value, ls_values, ls_findvalue

Long ll_pos

if Isnull(as_column) or as_column = "" then return ""

//ls_new_value = ads_data.describe("Evaluate('LookUpDisplay( " + as_column + ")', " + String(ads_data.getrow()) + ")")

ls_values = ads_data.Describe(as_column + ".Values")
ls_values = "/" + ls_values
ls_findvalue = char(9) + as_value + "/"

ll_pos = pos(ls_values, ls_findvalue)

ls_values =Reverse( mid(ls_values, 1, ll_pos - 1))
ll_pos = pos(ls_values, "/")


ls_new_value =Reverse( mid(ls_values, 1, ll_pos - 1))


return ls_new_value
end function

public function string of_change_checkbox (datastore ads_data, string as_column, string as_value);//====================================================================
//$<Function>: of_change_checkbox
//$<Arguments>:
// 	value    datastore       ads_data
// 	value    string    as_column
// 	value    string    as_value
//$<Return>:  string
//$<Description>: Return On/Off/Other
//$<Author>: (Appeon) Harry 04.09.2015 (Allegheny Audit Report - Altschuler, Eric Case#53159 Bug 4478)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

String ls_new_value

if Isnull(as_column) or as_column = "" then return ""

if ads_data.Describe( as_column + ".CheckBox.On") = as_value then
	ls_new_value = "On"
elseif ads_data.Describe( as_column + ".CheckBox.Off") = as_value then
	ls_new_value = "Off"
else
	ls_new_value = "Other"
end if

return ls_new_value
end function

public function integer of_field_audit_de_compl (long al_rec, long al_prac, string as_field, datetime ad_old, datetime ad_new, long al_facility); //Start Code Change ----05.20.2015 #V15 maha - create audit records for DE complete, Verifi complete etc.
integer ll_InsertRow
long ll_field_id
long ll_seq_no
string ls_old
string ls_new
n_ds lds_sys_audit

lds_sys_audit = Create n_ds
lds_sys_audit.DataObject = "d_view_audit"
lds_sys_audit.SetTransObject(SQLCA)


choose case as_field
	case "de_comp_date"
		ll_field_id = 100018
	case "verif_comp_date"
		ll_field_id = 100023
	case "checklist_comp_date"
		ll_field_id = 100013
	case "start_date"
		ll_field_id = 100005
end choose

select max(seq_no) into :ll_seq_no from sys_audit where rec_id = :al_rec and field_id = :ll_field_id;

if isnull(ll_seq_no) then ll_seq_no = 0
ll_seq_no++

ls_old = string(ad_old)
ls_new = string(ad_new)
	
ll_InsertRow = lds_sys_audit.InsertRow(0)
lds_sys_audit.SetItem(ll_InsertRow, "rec_id", al_rec)
lds_sys_audit.SetItem(ll_InsertRow, "prac_id", al_prac)					
lds_sys_audit.SetItem(ll_InsertRow, "seq_no", ll_seq_no)										
lds_sys_audit.SetItem(ll_InsertRow, "table_id", 43)
lds_sys_audit.SetItem(ll_InsertRow, "field_id", ll_field_id)
lds_sys_audit.SetItem(ll_InsertRow, "old_value", MidA(ls_old,1,100))
lds_sys_audit.SetItem(ll_InsertRow, "new_value", MidA(ls_new,1 ,100))
lds_sys_audit.SetItem(ll_InsertRow, "user_id", gs_user_id)
lds_sys_audit.SetItem(ll_InsertRow, "audit_type", "E-S")	
lds_sys_audit.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))
lds_sys_audit.SetItem(ll_InsertRow, "sys_audit_exported", 1)
lds_sys_audit.SetItem(ll_InsertRow, "facility_id", al_facility)

lds_sys_audit.update()

destroy lds_sys_audit

return 1
end function

public function integer of_validate_dea (string as_data, string as_name);
//Start Code Change ----02.25.2014 #V14 maha - funtion created for NYH
integer c
integer cl
string s
integer li_sum ,n1 ,n2
integer li_n

cl = len(as_data)

if cl <> 9 then return -1

for c = 1 to cl
	s = mid(as_data, c,1)
	choose case c
		case 1
			if isnumber(s) then return -2
			choose case upper(s)
				case 'A','B','F','G','M','P', 'R'
					//ok
				case else
					return -6
			end choose
		case 2
			if isnumber(s) then return -2
			//if lower(mid(as_name, 1,1)) <> lower(s) then return -4
		case 3,4,5,6,7,8,9
			if not isnumber(s) then return -3
	end choose
next

//checksum
for c = 3 to cl
	li_n = integer(mid(as_data, c,1))
	choose case c
		case 3
			n1 = li_n
		case 4
			n2 = li_n
		case 5
			n1+= li_n
		case 6
			n2+= li_n
		case 7
			n1+= li_n
		case 8
			n2+= li_n
	end choose
next

n2 = 2 * n2

li_sum = n1 + n2

s = right(string(li_sum), 1)

if mid(as_data, 9,1) <> s then return -5

return 1
	

end function

public function integer of_check_required_data (integer ai_dvid, long al_prac, long al_facil);//Start Code Change ----03.25.2016 #V15.2 maha - added new function for validating data entry complete
boolean lb_addr_type = false
integer li_return
integer li_screen
integer li_scrn_cnt
integer li_rec_cnt
integer s, w
integer r, rc 
integer a, ac
integer f, fc
integer l,lc
integer addp, addm, addx, addb, addh, specp
integer li_req_screen
integer li_rfields
integer li_req_lookup
integer li_find
integer li_test
integer li_pass
long ll_recid
long ll_type
long ll_addr_ids[]
string ls_primary
string ls_type
string ls_field
string ls_field_string
string ls_data_field
string ls_table
string ls_screen
string ls_value
string ls_sql
string ls_lu_type
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_error


n_ds lds_detail
n_ds lds_screens
n_ds lds_errors
n_ds lds_types
n_ds lds_req_fields
n_ds lds_addr_type

//create the data stores
lds_screens = create n_ds
lds_screens.dataobject = "d_data_view_screen_req_data_list" 
lds_screens.settransobject(sqlca)

lds_req_fields = create n_ds
lds_req_fields.dataobject = "d_de_comp_required_field_list"  //either required or req_for_compl
lds_req_fields.settransobject(sqlca)


lds_errors = create n_ds
lds_errors.dataobject = "d_req_data_errors_list" 
lds_errors.settransobject(sqlca)

lds_types = create n_ds
lds_types.dataobject = "d_data_view_screen_req_lookups"
lds_types.settransobject(sqlca)

lds_detail = CREATE n_ds

//get screens data
li_test = lds_screens.retrieve(ai_dvid)
li_test = lds_req_fields.retrieve(ai_dvid)

//delete existing errors for provider
delete from req_data_error where prac_id = :al_prac;


//check to see if any screens has valid check setup 
//Start Code Change ----05.15.2016 #V15 maha
li_test =  lds_screens.setfilter("rec_req = 1 or req_fields = 1")
lds_screens.filter()
if lds_screens.rowcount() = 0 then
	if isvalid(lds_errors) then destroy(lds_errors)
	if isvalid(lds_screens) then destroy lds_screens
	if isvalid(lds_detail) then destroy(lds_detail)
	if isvalid(lds_types) then destroy(lds_types)
	if isvalid(lds_req_fields) then destroy(lds_req_fields)
	return 0
end if
//End Code Change ----05.15.2016

//for each screen check for req rules or continue
for s = 1 to lds_screens.rowcount()
	li_req_screen = lds_screens.getitemnumber(s,"rec_req")
	li_rfields = lds_screens.getitemnumber(s,"req_fields")
	li_req_lookup = lds_screens.getitemnumber(s,"req_type_field")
	addp = lds_screens.getitemnumber(s,"address_p")
	addm = lds_screens.getitemnumber(s,"address_m")
	addb = lds_screens.getitemnumber(s,"address_b")
	addx = lds_screens.getitemnumber(s,"address_x")
	addh = lds_screens.getitemnumber(s,"address_h")
	specp = lds_screens.getitemnumber(s,"specialty_p")
	ls_field = lds_screens.getitemstring(s,"req_type_field_name")
	ls_table = lds_screens.getitemstring(s,"table_name")
	li_screen = lds_screens.getitemnumber(s,"screen_id")
	ls_screen = lds_screens.getitemstring(s,"screen_name") 
	
	if addp = 1 or addm = 1 or addb = 1 or addx = 1 or addh = 1 then lb_addr_type = true
	
	//filter required fields
	li_test = 	lds_req_fields.setfilter("screen_id = " + string(li_screen))
	lds_req_fields.filter()
		
	//get data from screen
	ls_sql = "Select * from " + ls_table + " where prac_id = " + string(al_prac)
	

	ls_presentation_str = "style(type=form)"		

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF Len(ERRORS) > 0 THEN
		MessageBox("Caution on export field " + ls_sql, &
			"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
		//	MessageBox("ls_select_table",ls_select_table)
			continue
	END IF

	w = lds_detail.Create( ls_dwsyntax_str, ERRORS)
	if len(ERRORS) > 0 then
		messagebox("error on create",errors)
	end if
	
	lds_detail.settransobject( sqlca)
	lds_detail.retrieve()
	
	rc = lds_detail.rowcount()
	
// do any records exist
	if li_req_screen = 1 and rc < 1 then
		ls_error = "Data is required for the " + ls_screen + " screen."
		of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 1 , ls_screen , "" ,li_screen, "D")
		continue
	end if

// check required fields
	if li_rfields  = 1 then
		fc = lds_req_fields.rowcount()
		for f = 1 to fc //for each required
			
			ls_type = lds_req_fields.getitemstring(f, "field_type")
			 ls_data_field  = lds_req_fields.getitemstring(f, "field_name")
			 ls_field_string =  ls_data_field + ".ColType"
			 if lds_detail.Describe(ls_field_string) = "!" then CONTINUE
			
			for r = 1 to rc
				ll_recid = lds_detail.getitemnumber(r, "rec_id")
				//messagebox("req col name", ls_data_field)
				choose case ls_type
					case "I","N"	
						ls_value = string(lds_detail.getitemnumber(r,  ls_data_field))
					case "D"
						ls_value = string(lds_detail.getitemdatetime(r,  ls_data_field))
					case else
						ls_value = lds_detail.getitemstring(r,  ls_data_field)
				end choose
				
				if isnull( ls_value) or ls_value = "" then
	
					ls_error = "Data is required for the " + ls_screen + " screen, " + ls_data_field + " column."
					of_required_data_error(al_prac, al_facil, ll_recid, ls_error, lds_errors, 2 , ls_screen , ls_data_field ,li_screen, "D")
				end if
			next //record
			
		next //field
		
	end if  //required fields
	
	//check for lookup types
	if li_req_lookup =  1 then
		lc = lds_types.retrieve(ai_dvid, li_screen)
		for l = 1 to lc
			ll_type = lds_types.getitemnumber(l, "lookup_code")
			li_find = lds_detail.find(ls_field + " = " + string(ll_type), 1, rc)
			if li_find = 0 then
				ls_type = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_type))
				ls_error = "For the " + ls_screen + " screen, the " + ls_data_field + " column requires a type of " + ls_type + "."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 3 , ls_screen , ls_data_field ,li_screen, "D")
			end if
		next
	end if
	
	//address links
	if li_screen = 2 and lb_addr_type = true then
		for a = 1 to rc
			ll_addr_ids[a] = lds_detail.getitemnumber(a,"rec_id")
		next
		
		lds_addr_type = create n_ds
		lds_addr_type.dataobject = "d_addr_link_for_req_data_check" 
		lds_addr_type.settransobject(sqlca)
		ac = lds_addr_type.retrieve(ll_addr_ids, al_facil)
		
		if addp  =  1 then
			li_find = lds_addr_type.find("primary_office = 1", 1, ac)
			if li_find = 0 then
				ls_error = "For the Address screen, a Primary Office link is required."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 4 , ls_screen , "Primary" ,li_screen, "D")
			end if
		end if
		if addm = 1 then
			li_find = lds_addr_type.find("mailing = 1", 1, ac)
			if li_find = 0 then
				ls_error = "For the Address screen, a Mailing address link is required."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 4 , ls_screen , "Mailing" ,li_screen, "D")
			end if
		end if
		if addb = 1 then
			li_find = lds_addr_type.find("billing = 1", 1, ac)
			if li_find = 0 then
				ls_error = "For the Address screen, a Billing address link is required."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 4 , ls_screen , "Billing" ,li_screen, "D")
			end if
		end if
		if addx = 1 then
			li_find = lds_addr_type.find("exp_cred = 1", 1, ac)
			if li_find = 0 then
				ls_error = "For the Address screen, an Expiring Credential link is required."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 4 , ls_screen , "Exp Cred" ,li_screen, "D")
			end if
		end if
		if addh = 1 then
			li_find = lds_addr_type.find("home = 1", 1, ac)
			if li_find = 0 then
				ls_error = "For the Address screen, a Home Address is required."
				of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 4 , ls_screen , "Home" ,li_screen, "D")
			end if
		end if
		destroy lds_addr_type
	end if
	
	//primary specialty
	if li_screen = 19 and specp = 1 then
		ls_primary =  gnv_data.of_getitem( "code_lookup", "lookup_code", "description = 'Primary Specialty'")
		li_find = lds_detail.find("specialty_order = " + ls_primary, 1, rc)
		if li_find = 0 then
			ls_error = "For the Board Specialty screen, a Primary Specialty is required."
			of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 5 , ls_screen , "Primary" ,li_screen, "D")
		end if
	end if
next

rc = lds_errors.rowcount()

w = lds_errors.update()

//Start Code Change ----06.02.2016 #V152 maha - modified for allow completion with failure
if rc > 0 then
	//openwithparm(w_req_data_error_list, al_prac)
	select allow_de_req_fail into :li_pass from data_view where data_view_id = :ai_dvid;
	if li_pass = 1 then
		li_return = -2
	else
		li_return = -1
	end if
else
	//messagebox("Data Requirements Validation","No errors found")
	li_return = 1
end if
//End Code Change ----06.02.2016

//select count(prac_id) into :w from req_data_error where prac_id = :al_prac;
//messagebox("Error count in DB",w)

//cleanup
if isvalid(lds_errors) then destroy(lds_errors)
if isvalid(lds_screens) then destroy lds_screens
if isvalid(lds_detail) then destroy(lds_detail)
if isvalid(lds_types) then destroy(lds_types)
if isvalid(lds_req_fields) then destroy(lds_req_fields)

return li_return
end function

public function integer of_applfield_audit (datastore ads_data, ref string as_errortext, boolean ab_batch, long al_batch_id);//====================================================================
//$<Function>: of_applfield_audit
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.12.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long li_seq_rc
long ll_seq_no
long ll_rec_id
long ll_field_id
long ll_field_id2
long ll_field_id1
long ll_old_value
long ll_new_value
long ll_facility_id
long ll_prac_id
long ll_value_arr[]
long ll_reference_field_1
long ll_reference_field_2
long i, j
long ll_RowCount
long ll_InsertRow
long ll_FindRow
long ll_lu_rc
long ll_gp_id
long ll_app_id
long ll_audit_id
long ll_audit_id_new
long ll_batch_id
string ls_app_name
string ls_lookup_type
string ls_is_lookup
string ls_lookup_field_name
string ls_retval
string ls_old_value
string ls_new_value
string ls_value1
string ls_value2
string ls_table_name
string ls_field_name
string ls_field_type
string ls_field_alias
string ls_field_type_arr[]
string ls_field_edittype
integer li_table_id
integer li_AuditFieldCount
integer li_facility_specific
integer li_add_row
integer li_find
DWItemStatus ldis_Status
DataStore lds_sys_audit_appl
String ls_lookup_name 
String ls_datavalue_dddw 

If of_get_app_setting("set_85","I") < 2 Then return 1
if not IsValid(lds_sys_audit_appl) then
	lds_sys_audit_appl = Create n_ds
	lds_sys_audit_appl.DataObject =  "d_view_sys_audit_appl_add"  //Start Code Change ----07.19.2017 #V154 maha
	lds_sys_audit_appl.SetTransObject(SQLCA)
end if
ls_table_name = ads_data.Describe("DataWindow.Table.UpdateTable") 

choose case ls_table_name
	case 'net_dev_action_items' 
		li_table_id = 51
	case 'net_dev_ids'
		li_table_id = 52	
	case  'pd_appl_tracking'
		li_table_id = 54
end choose	
	
ll_RowCount = ads_data.RowCount()

li_AuditFieldCount = integer(ads_data.describe("datawindow.column.count"))
if li_AuditFieldCount < 1 then 
	if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl	
	Return 1//success
end if

//---------Begin Commented by (Appeon)Stephen 07.20.2017 for Critical performance issue with workflow action completion--------
/*
if not isvalid(ids_application) then
	ids_application = create datastore
	ids_application.dataobject = "d_dddw_apps"
	ids_application.settransobject(sqlca)
	ids_application.retrieve()
end if
*/
//---------End Commented ------------------------------------------------------

for i = 1 to li_AuditFieldCount
	ls_field_name = ads_data.describe("#"+string(i)+".name")
	ls_field_type = Upper(ads_data.Describe(ls_field_name + ".ColType"))	
	if PosA(ls_field_type, "CHAR") > 0 then
		ls_field_type = "C"
	elseif PosA(ls_field_type, "DATE") > 0 then
		ls_field_type = "D"
	elseif PosA(ls_field_type, "LONG") > 0 or PosA(ls_field_type, "DECIMAL") > 0 or PosA(ls_field_type, "REAL") > 0 or PosA(ls_field_type, "NUM") > 0 then
		ls_field_type = "N"    
	elseif ls_field_type = "!" then
		ls_field_type = "!"
	else
		
	end if
	ls_field_type_arr[UpperBound(ls_field_type_arr) + 1] = ls_field_type
next
//li_table_id = lds_audit_fields.GetItemNumber(1, "table_id")
li_facility_specific = of_get_facil_specific(li_table_id)	//added by long.zhang 09.08.2011

//Execute field audit process
li_add_row = 0
for i = 1 to ll_RowCount
	ldis_Status = ads_data.GetItemStatus(i, 0, Primary!)
	if ldis_Status = notmodified! then continue //(Appeon)Stephen 07.20.2017 - Critical performance issue with workflow action completion	
	ll_prac_id = ads_data.GetItemNumber(i, "prac_id")
	if ads_data.Describe("facility_id.ColType") <> "!" then ll_facility_id = ads_data.GetItemNumber(i, "facility_id") 
	ll_app_id = ads_data.GetItemNumber(i, "app_id") 
	//---------Begin Modified by (Appeon)Stephen 07.20.2017 for Critical performance issue with workflow action completion--------
	/*
	li_find = ids_application.find("app_hdr_app_id="+string(ll_app_id), 1, ids_application.rowcount())	
	if li_find > 0 then
		ls_app_name = ids_application.getitemstring(li_find, "app_hdr_application_name")
	else
		ls_app_name = ""
	end if
	*/
	if ls_table_name = 'net_dev_ids' then
		ls_app_name = ads_data.describe("evaluate('lookupdisplay(app_id)',"+string( i)+")")	
	//Start Code Change ----07.20.2017 #V154 maha - error trapping
	elseif 	ads_data.dataobject = "d_appeon_net_dev_action_items_save" then 
		select application_name into :ls_app_name from app_hdr where app_id = :ll_app_id; 
	//End Code Change ----07.20.2017
	else
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 07.25.2017
		//<$>reason:Pikeville-Application Pop App error Bug_id#5727 Case#72096
		//ls_app_name = ads_data.getitemstring(i, "app_hdr_application_name")
		If  ads_data.describe("app_hdr_application_name.x")	<>'!' Then 
			ls_app_name = ads_data.getitemstring(i, "app_hdr_application_name")
		Else
			ls_app_name = ads_data.describe("evaluate('lookupdisplay(app_id)',"+string( i)+")")	
		End If
		//------------------- APPEON END -------------------
	end if
	//---------End Modfiied ------------------------------------------------------
	
	if ldis_Status = DataModified! then
	////////////////////////[1-Current row is DataModified!]///////////////////////////////////
		for j = 1 to li_AuditFieldCount			
			ls_field_name = ads_data.describe("#"+string(j)+".name")
			if ls_field_type_arr[j] = "!" then Continue
			if pos(ls_field_name , "mod_date") > 0 or pos(ls_field_name , "mod_user") > 0 then continue
			
			if ads_data.GetItemStatus(i, ls_field_name, Primary!) = DataModified! then
				ls_field_edittype = ads_data.describe(ls_field_name+".Edit.Style")
				choose case ls_field_type_arr[j]
					case "C"
						ls_old_value = ads_data.GetItemString(i, ls_field_name, Primary!, True)
						ls_new_value = ads_data.GetItemString(i, ls_field_name)
					case "N"
						ll_old_value = ads_data.GetItemNumber(i, ls_field_name, Primary!, True) 
						ll_new_value = ads_data.GetItemNumber(i, ls_field_name) 												

						if ls_field_name = 'active_status' then
							ls_old_value = string(ll_old_value)
							ls_new_value = string(ll_new_value)
							ls_old_value = of_active_status_value(ls_old_value ,ls_table_name )
							ls_new_value = of_active_status_value(ls_new_value ,ls_table_name )
						else
							ls_old_value = string(ll_old_value)
							ls_new_value = string(ll_new_value)
						end if			
					case else
						ls_old_value = String(Date(ads_data.GetItemDateTime(i, ls_field_name, Primary!, True)))
						ls_new_value = String(Date(ads_data.GetItemDateTime(i, ls_field_name)))	
				end choose
				
				if ls_old_value = ls_new_value then continue //(Appeon)Stephen 07.20.2017 - Critical performance issue with workflow action completion
				if (isnull(ls_old_value) and isnull(ls_new_value)) then continue //(Appeon)Stephen 07.20.2017 - Critical performance issue with workflow action completion				
				//---------Begin Added by (Appeon)Harry 04.09.2015 for  Bug 4478--------
				if ls_field_name = 'active_status' then //(Appeon)Stephen 06.26.2015 - add "ls_field_name = 'active_status'" --Bug # 4577 - Audit trail is not recording the Old and New values for the Status field Case # 55462
				else
					choose case Lower(ads_data.Describe( ls_field_name + ".edit.style"))
						case  "checkbox"
							ls_old_value = of_change_checkbox(ads_data, ls_field_name, ls_old_value)
							ls_new_value = of_change_checkbox(ads_data, ls_field_name, ls_new_value)
						case "ddlb"
							if ls_field_name <> 'active_status' and mid (Lower(ads_data.Describe( ls_field_name + ".coltype")), 1, 4) <> 'date' then
								ls_old_value = of_change_ddlb(ads_data, ls_field_name, ls_old_value)
								ls_new_value = of_change_ddlb(ads_data, ls_field_name, ls_new_value)
							end if
						case "dddw"	
							ls_old_value = of_change_dddw(ads_data, ls_field_name, ls_old_value)
							ls_new_value = of_change_dddw(ads_data, ls_field_name, ls_new_value)
					end choose
				end if
				//---------End Added ------------------------------------------------------
				
				if ls_old_value = ls_new_value then continue
				if (isnull(ls_old_value) and isnull(ls_new_value)) then continue
				//Insert a new audit record
				ll_InsertRow = lds_sys_audit_appl.InsertRow(0)
				choose case ls_table_name			
					case 'pd_appl_tracking'
						ll_rec_id = ads_data.GetItemNumber(i, "track_id") 
						ll_gp_id  = ads_data.GetItemNumber(i, "gp_id") 
						lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_track_id", ll_rec_id)
						lds_sys_audit_appl.SetItem(ll_InsertRow, "gp_id", ll_gp_id)
					case 'net_dev_ids','net_dev_action_items' 
						ll_rec_id = ads_data.GetItemNumber(i, "rec_id") 
						lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_rec_id", ll_rec_id)
						if ls_table_name = 'net_dev_action_items'  then
							ll_gp_id  = ads_data.GetItemNumber(i, "gp_id") 
							lds_sys_audit_appl.SetItem(ll_InsertRow, "gp_id", ll_gp_id)
						end if
				end choose
				
				ls_field_alias = ads_data.describe(ls_field_name+"_t.text")
				if isnull(ls_field_alias) or ls_field_alias = "" or ls_field_alias = "!" then
					ls_field_alias = ls_field_name
				end if	
				ls_field_alias = trim(ls_field_alias)
				if right(ls_field_alias, 1) = ":" then ls_field_alias = left(ls_field_alias, len(ls_field_alias) - 1)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "prac_id", ads_data.GetItemNumber(i, "prac_id"))					
				lds_sys_audit_appl.SetItem(ll_InsertRow, "table_id", li_table_id)
//				lds_sys_audit_appl.SetItem(ll_InsertRow, "field_id", ll_field_id)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "table_name", ls_table_name)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "field_name", ls_field_alias)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "old_value", MidA(ls_old_value,1,100))
				lds_sys_audit_appl.SetItem(ll_InsertRow, "new_value", MidA(ls_new_value,1 ,100))
				lds_sys_audit_appl.SetItem(ll_InsertRow, "user_id", gnv_app.of_getuserid())
				lds_sys_audit_appl.SetItem(ll_InsertRow, "audit_type", "E")	
				lds_sys_audit_appl.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))
				lds_sys_audit_appl.SetItem(ll_InsertRow, "facility_id", ll_facility_id)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "app_id", ll_app_id)
				lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_name", ls_app_name)
				li_add_row = li_add_row + 1
			end if
		next

	elseif ldis_Status = NewModified! then
	////////////////////////[2-Current row is NewModified!]///////////////////////////////////	
		ll_field_id = 1000 
		ll_app_id = ads_data.GetItemNumber(i, "app_id") 
		//Insert a new audit record
		ll_InsertRow = lds_sys_audit_appl.InsertRow(0)		
		choose case ls_table_name			
			case 'net_dev_ids','net_dev_action_items' //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
				ll_rec_id = ads_data.GetItemNumber(i, "rec_id") 
				lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_rec_id", ll_rec_id)		
				if ls_table_name = 'net_dev_action_items'  then
					ll_gp_id  = ads_data.GetItemNumber(i, "gp_id") 
					lds_sys_audit_appl.SetItem(ll_InsertRow, "gp_id", ll_gp_id)
				end if
			case 'pd_appl_tracking'
				ll_rec_id = ads_data.GetItemNumber(i, "track_id") 
				lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_track_id", ll_rec_id)		
				ll_gp_id  = ads_data.GetItemNumber(i, "gp_id") 
				lds_sys_audit_appl.SetItem(ll_InsertRow, "gp_id", ll_gp_id)
		end choose
		
		ls_new_value = string(ll_rec_id) + "-" + string(ll_prac_id)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "prac_id", ads_data.GetItemNumber(i, "prac_id"))
		lds_sys_audit_appl.SetItem(ll_InsertRow, "table_id", li_table_id)
//		lds_sys_audit_appl.SetItem(ll_InsertRow, "field_id", 1000)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "field_name", "")
		lds_sys_audit_appl.SetItem(ll_InsertRow, "table_name", ls_table_name)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "new_value", ls_new_value)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "user_id", gnv_app.of_getuserid())
		lds_sys_audit_appl.SetItem(ll_InsertRow, "audit_type", "I")	
		lds_sys_audit_appl.SetItem(ll_InsertRow, "date_time_modified", DateTime(Today(), Now()))		
		lds_sys_audit_appl.SetItem(ll_InsertRow, "facility_id", ll_facility_id)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "app_id", ll_app_id)
		lds_sys_audit_appl.SetItem(ll_InsertRow, "appl_name", ls_app_name)
		li_add_row = li_add_row + 1
	end if
next

//field audit update
if li_add_row > 0 then
	gnv_appeondb.of_startqueue( )
	select ids.sys_appaudit_id into :ll_audit_id_new from ids;
	update ids set sys_appaudit_id = (isnull(sys_appaudit_id,0)  + :li_add_row);	//(Appeon)Stephen 10.12.2017 - V15.3 Bug # 5832 - Keep getting Failed to update sys_audit table on Applications tab Case 73449
	//select max(audit_id) into :ll_audit_id from sys_audit_appl ; //Commented by (Appeon)Stephen 10.12.2017 - V15.3 Bug # 5832
	gnv_appeondb.of_commitqueue( )
	
	if isnull(ll_audit_id_new) then ll_audit_id_new = 0
	//---------Begin Commented by (Appeon)Stephen 10.12.2017 for V15.3 Bug # 5832 - Keep getting Failed to update sys_audit table on Applications tab Case 73449--------
	/*
	if isnull(ll_audit_id) then ll_audit_id = 0
	if ll_audit_id > ll_audit_id_new then 
		ll_audit_id_new = ll_audit_id
		update ids set ids.sys_appaudit_id = :ll_audit_id_new + :li_add_row;
	end if
	*/
	//---------End Commented ------------------------------------------------------
	
	//---------Begin Added by (Appeon)Stephen 05.17.2017 for : Concentra - error when adding workflow--------
	if sqlca.sqlcode < 0 then
		ROLLBACK USING SQLCA;	
		MessageBox("of_appfield_audit", "Failed to update sys_audit_id!")
		if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl
		Return -1
	end if
	//---------End Added ------------------------------------------------------
	
	for i = 1 to lds_sys_audit_appl.rowcount()
		IF lds_sys_audit_appl.GetItemStatus( i, 0 , Primary!) = newmodified! THEN
			ll_audit_id_new +=1
			lds_sys_audit_appl.setitem(i, "audit_id", ll_audit_id_new)
			if ab_batch = true then
				lds_sys_audit_appl.setitem(i, "batch_id", al_batch_id)
			end if
		end if		
	next		
end if

IF lds_sys_audit_appl.modifiedcount( ) > 0 THEN
	i = lds_sys_audit_appl.Update()
	IF i = -1 THEN
		ROLLBACK USING SQLCA;	
		MessageBox("of_appfield_audit", "Failed to update sys_audit table!~r~n" +sqlca.sqlerrtext) //(Appeon)Stephen 10.12.2017 -add 'sqlca.sqlerrtext' -- V15.3 Bug # 5832
		if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl
		Return -1
	else
		COMMIT USING SQLCA;	
	END IF
END IF

if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl	
	
Return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_check_required_documents (integer ai_dataview, long al_prac, long al_facil);//Start Code Change ----05.25.2016 #V15.2 maha - added new function for validating data entry complete
boolean lb_addr_type = false
integer li_return
integer li_screen
integer li_all
integer li_template
integer s, w
integer r, rc 
integer a, ac
integer f, fc
integer li_rec_cnt
integer li_id
integer li_items[]
integer li_docs
integer li_find
integer li_pass // maha 06.02.2016
//integer li_test
long ll_recid[]
//long ll_type
//long ll_addr_ids[]
//string ls_primary
//string ls_type
string ls_find
string ls_type
//string ls_data_field
string ls_table
string ls_screen
string ls_error


n_ds lds_temp_items
n_ds lds_docs
n_ds lds_errors

//check to see if there is an image template
select image_req_temp into :li_template from data_view where data_view_id = :ai_dataview;
if isnull(li_template) or li_template = 0 then return 1
	

//create the data stores
lds_temp_items  = create n_ds
lds_temp_items.dataobject = "d_image_req_temp_view" 
lds_temp_items.settransobject(sqlca)

lds_docs = create n_ds
lds_docs.dataobject = "d_pd_image_list_required" 
lds_docs.settransobject(sqlca)

lds_errors = create n_ds
lds_errors.dataobject = "d_req_data_errors_list" 
lds_errors.settransobject(sqlca)


//get screens data
fc = lds_temp_items.retrieve(li_template, ai_dataview)
//---------Begin Added by (Appeon)Stephen 07.20.2016 for BugS070501--------
if fc < 1 then
	if isvalid(lds_temp_items ) then destroy(lds_temp_items)
	if isvalid(lds_docs) then destroy lds_docs
	if isvalid(lds_errors) then destroy lds_errors
	return 1
end if
//---------End Added ------------------------------------------------------

for f = 1 to fc
	li_items[f] = lds_temp_items.getitemnumber(f,"image_type")	
next	

li_docs = lds_docs.retrieve(al_prac, li_items[]  , al_facil)
if li_docs < 0 then messagebox("","image data retrieval failed")


for f = 1 to upperbound(li_items)
	li_screen =  lds_temp_items.getitemnumber(f,"screen_id")
	li_id =  lds_temp_items.getitemnumber(f, "image_type")
	ls_type =  lds_temp_items.getitemstring(f, "image_type_description")
	ls_screen =  lds_temp_items.getitemstring(f, "screen_alias")
	li_all =  lds_temp_items.getitemnumber(f, "all_active")
	ls_table =  lds_temp_items.getitemstring(f, "table_name")
	
	if li_all = 0  or  li_screen = 1 then
		if li_screen > 0 then
			//check to see if there are ant data records; if not continue
			select count(rec_id) into :li_rec_cnt from pd_basic where prac_id = :al_prac;
			if li_rec_cnt = 0 then continue
		end if
		ls_find = "image_type_id = " + string(li_id)
		li_find = lds_docs.find( ls_find, 1, li_docs)
		if li_find > 0  then	
			continue
		else
			li_return = -1
			ls_error = "An active Document is required for the " + ls_type + " Image Type.~r"
			of_required_data_error(al_prac, al_facil, 0, ls_error, lds_errors, 6 , ls_screen , "" ,li_screen, "I")
		end if
	else  //checking all data records
		//find the num of records; get recids
		debugbreak()
		rc = of_get_rec_ids_for_screen(al_prac, ls_table, ll_recid[])
		if rc = 0 then continue
		
		for r = 1 to rc
			ls_find = "image_type_id = " + string(li_id) + " and pd_images_rec_id = " + string(ll_recid[r])
			li_find = lds_docs.find( ls_find, 1, li_docs)
			if li_find > 0  then
				continue
			else
				li_return = -1
				ls_error = "An active Document is required for the " + ls_type + " Image Type.~r"
				of_required_data_error(al_prac, al_facil, ll_recid[r] , ls_error, lds_errors, 6 , ls_screen , "" ,li_screen, "I")
			end if
		next
	end if

next

rc = lds_errors.rowcount()

//Start Code Change ----06.02.2016 #V152 maha - modified for allow completion with failure
if rc > 0 then
	w = lds_errors.update()
	select allow_image_req_fail into :li_pass from data_view where data_view_id = :ai_dataview;
	if li_pass = 1 then
		li_return = -2
	else
		li_return = -1
	end if
else

	li_return = 1
end if
//End Code Change ----06.02.2016


//cleanup
if isvalid(lds_temp_items ) then destroy(lds_temp_items)
if isvalid(lds_docs) then destroy lds_docs
if isvalid(lds_errors) then destroy lds_errors

return li_return
end function

public function integer of_required_data_error (long al_prac, long al_facil, long al_recid, string as_error, n_ds ads_error, integer ai_type, string as_screen, string as_field, integer ai_screenid, string as_from);//Start Code Change ----03.28.2016 #V15 maha -added; called from of_check_req_data
integer r

r = ads_error.insertrow(0)
ads_error.setitem(r, "prac_id", al_prac)
ads_error.setitem(r, "rec_id", al_recid)
ads_error.setitem(r, "err_description", as_error)
ads_error.setitem(r, "screen_name", as_screen)
ads_error.setitem(r, "field_name", as_field)
ads_error.setitem(r, "err_type", ai_type)
ads_error.setitem(r, "screen_id", ai_screenid)
ads_error.setitem(r, "data_doc", as_from)

return 1

end function

public function integer of_get_rec_ids_for_screen (long al_prac, string as_table, ref long al_recids[]);//Start Code Change ----05.26.2016 #V152 maha - created; called from of_check_required_documents
string ls_sql
string ERRORS
string ls_dwsyntax_str
string ls_presentation_str
integer r
integer rc
integer w
datastore lds_detail

lds_detail = create datastore

//get data from screen
ls_sql = "Select * from " + as_table + " where prac_id = " + string(al_prac)

ls_presentation_str = "style(type=form)"		
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)

IF Len(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_sql, &
		"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
	//	MessageBox("ls_select_table",ls_select_table)
	return -1
END IF
	w = lds_detail.Create( ls_dwsyntax_str, ERRORS)
if len(ERRORS) > 0 then
	messagebox("error on create",errors)
end if

lds_detail.settransobject( sqlca)
rc = lds_detail.retrieve()

for r = 1 to rc
	al_recids[r] = lds_detail.getitemnumber(r, "rec_id")
next

return rc
end function

public function integer of_applfield_audit_delete_last (datastore ads_data, long al_row);//====================================================================
//$<Function>: of_applfield_audit_delete_last
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.02.2016 (V15.2-Application Tracking full Auditing)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer i
Integer li_rc
Integer li_nr
Integer li_table_id
Integer li_find
Long ll_rec_id
long ll_gp_id
long ll_app_id
long ll_prac
long ll_facility_id
long ll_audit_id
long ll_audit_id_new
long ll_insert
String ls_old_value
String ls_table_name
String ls_app_name
datetime ldt_today
datastore lds_data_del

if al_row < 1 then return -1
ls_table_name = ads_data.Object.DataWindow.Table.UpdateTable

//copy the delete records to the sys_audit_net_dev_action_delete table
if ls_table_name = 'net_dev_action_items' then
	ll_rec_id = ads_data.GetItemNumber(al_row, "rec_id") 
	select count(1) into :ll_insert from sys_audit_net_dev_action_delete  where rec_id = :ll_rec_id;
	if ll_insert > 0 then return -1
	
	ldt_today = datetime(today(), now())
	//insert into sys_audit_net_dev_action_delete
	insert into sys_audit_net_dev_action_delete( 
		rec_id, prac_id ,action_type , action_date ,action_dept ,action_user ,next_action_date ,notes , 
		action_contact ,action_status ,facility_id ,app_id , conv_prac_id ,active_status ,seq_no ,app_type , 
		due_date ,app_print_id ,wf_step ,letter_id ,wf_id ,wf_action_type_id ,wf_assigned_by ,wf_complete_flag , 
		print_flag ,first_sent ,last_sent ,number_sent ,create_date ,create_user ,gp_id , 
		track_id ,prac_approve ,prac_approve_date,prac_approve_user ,sig_status ,sig_out_date,sig_in_date , 
		sig_doc_link,es_apicode ,es_fileid ,es_docid ,es_sender ,es_sender_email,mod_date ,mod_user)
	select rec_id, prac_id ,action_type , action_date ,action_dept ,action_user ,next_action_date ,notes , 
		action_contact ,action_status ,facility_id ,app_id , conv_prac_id ,active_status ,seq_no ,app_type , 
		due_date ,app_print_id ,wf_step ,letter_id ,wf_id ,wf_action_type_id ,wf_assigned_by ,wf_complete_flag , 
		print_flag ,first_sent ,last_sent ,number_sent ,create_date ,create_user ,gp_id , 
		track_id ,prac_approve ,prac_approve_date,prac_approve_user ,sig_status ,sig_out_date,sig_in_date , 
		sig_doc_link,es_apicode ,es_fileid ,es_docid ,es_sender ,es_sender_email, :ldt_today, :gs_user_id
	from net_dev_action_items where net_dev_action_items.rec_id = :ll_rec_id using sqlca;
	if SQLCA.sqlcode = 0 then
		COMMIT USING SQLCA;
	else
		rollback using sqlca;
		//insert into sys_audit_net_dev_action_delete
		lds_data_del = create datastore
		lds_data_del.dataobject = "d_view_audit_net_dev_actions_del"
		lds_data_del.settransobject(sqlca)
		ll_insert = lds_data_del.insertrow(0)
		lds_data_del.setitem(ll_insert, "rec_id", ads_data.getitemnumber(al_row, "rec_id"))
		lds_data_del.setitem(ll_insert, "prac_id", ads_data.getitemnumber(al_row, "prac_id"))
		lds_data_del.setitem(ll_insert, "action_type", ads_data.getitemnumber(al_row, "action_type"))
		lds_data_del.setitem(ll_insert, "action_date", ads_data.getitemdatetime(al_row, "action_date"))
		lds_data_del.setitem(ll_insert, "action_dept", ads_data.getitemnumber(al_row, "action_dept"))
		lds_data_del.setitem(ll_insert, "next_action_date", ads_data.getitemdatetime(al_row, "net_dev_action_items_next_action_date"))
		lds_data_del.setitem(ll_insert, "action_contact", ads_data.getitemstring(al_row, "action_contact"))
		lds_data_del.setitem(ll_insert, "action_status", ads_data.getitemnumber(al_row, "action_status"))
		lds_data_del.setitem(ll_insert, "action_user", ads_data.getitemstring(al_row, "action_user"))
		lds_data_del.setitem(ll_insert, "facility_id", ads_data.getitemnumber(al_row, "facility_id"))
		lds_data_del.setitem(ll_insert, "app_id", ads_data.getitemnumber(al_row, "app_id"))
		lds_data_del.setitem(ll_insert, "seq_no", ads_data.getitemnumber(al_row, "seq_no"))
		lds_data_del.setitem(ll_insert, "gp_id", ads_data.getitemnumber(al_row, "gp_id"))
		lds_data_del.setitem(ll_insert, "active_status", ads_data.getitemnumber(al_row, "active_status"))
		lds_data_del.setitem(ll_insert, "app_type", ads_data.getitemstring(al_row, "app_type"))
		lds_data_del.setitem(ll_insert, "due_date", ads_data.getitemdatetime(al_row, "due_date"))
		lds_data_del.setitem(ll_insert, "notes", ads_data.getitemstring(al_row, "notes"))
		lds_data_del.setitem(ll_insert, "wf_step", ads_data.getitemnumber(al_row, "net_dev_action_items_wf_step"))
		lds_data_del.setitem(ll_insert, "letter_id", ads_data.getitemnumber(al_row, "net_dev_action_items_letter_id"))
		lds_data_del.setitem(ll_insert, "wf_id", ads_data.getitemnumber(al_row, "net_dev_action_items_wf_id"))
		lds_data_del.setitem(ll_insert, "wf_action_type_id", ads_data.getitemnumber(al_row, "net_dev_action_items_wf_action_type_id"))
		lds_data_del.setitem(ll_insert, "wf_assigned_by", ads_data.getitemstring(al_row, "net_dev_action_items_wf_assigned_by"))
		lds_data_del.setitem(ll_insert, "sig_status", ads_data.getitemnumber(al_row, "sig_status"))
		lds_data_del.setitem(ll_insert, "wf_complete_flag", ads_data.getitemstring(al_row, "net_dev_action_items_wf_complete_flag"))
		lds_data_del.setitem(ll_insert, "create_date", ads_data.getitemdatetime(al_row, "net_dev_action_items_create_date"))
		lds_data_del.setitem(ll_insert, "create_user", ads_data.getitemstring(al_row, "net_dev_action_items_create_user"))
		lds_data_del.setitem(ll_insert, "mod_date", datetime(today(), now()))
		lds_data_del.setitem(ll_insert, "mod_user", gs_user_id)
		
		IF lds_data_del.Update() = -1 THEN
			MessageBox("Prompt", "Failed to update sys_audit_net_dev_action_delete table!~r~nERROR: " +sqlca.sqlerrtext)
			rollback using sqlca;
			destroy lds_data_del
			Return -1
		else
			COMMIT USING SQLCA;
		END IF
		destroy lds_data_del
	end if
end if

If of_get_app_setting("set_85","I") = 2 Then
	
	datastore lds_sys_audit_appl
	
	if  ads_data.RowCount() < 1 then return 1
	if not IsValid(lds_sys_audit_appl) then
		lds_sys_audit_appl = Create n_ds
		lds_sys_audit_appl.DataObject =  "d_view_sys_audit_appl_add"  //Start Code Change ----07.19.2017 #V154 maha
		lds_sys_audit_appl.SetTransObject(SQLCA)
	end if
	
	//---------Begin Commented by (Appeon)Stephen 07.20.2017 for Critical performance issue with workflow action completion--------
	/*
	if not isvalid(ids_application) then
		ids_application = create datastore
		ids_application.dataobject = "d_dddw_apps"
		ids_application.settransobject(sqlca)
		ids_application.retrieve()
	end if
	*/
	//---------End Commented ------------------------------------------------------

	li_rc = ads_data.RowCount()
	i = al_row	
	
	ll_prac = ads_data.GetItemNumber( i, "prac_id" )
	ll_app_id = ads_data.GetItemNumber(i, "app_id") 
	choose case ls_table_name
		case 'net_dev_action_items' 
			li_table_id = 51
			ll_rec_id = ads_data.GetItemNumber( i, "rec_id" ) 
			ll_gp_id  = ads_data.GetItemNumber(i, "gp_id")
		case 'net_dev_ids'
			ll_rec_id = ads_data.GetItemNumber( i, "rec_id" ) 
			li_table_id = 52	
		case  'pd_appl_tracking'
			ll_rec_id = ads_data.GetItemNumber(i, "track_id") 
			ll_gp_id  = ads_data.GetItemNumber(i, "gp_id") 
			li_table_id = 54
	end choose	
	
	ls_old_value = string(ll_rec_id) + "-" + string(ll_prac)
	if IsNull(ll_rec_id) then return -1
	
	//---------Begin Modified by (Appeon)Stephen 07.20.2017 for Critical performance issue with workflow action completion--------
	/*
	li_find = ids_application.find("app_hdr_app_id="+string(ll_app_id), 1, ids_application.rowcount())	
	if li_find > 0 then
		ls_app_name = ids_application.getitemstring(li_find, "app_hdr_application_name")
	else
		ls_app_name = ""
	end if
	*/
	if ls_table_name = 'net_dev_ids' then
		ls_app_name = ads_data.describe("evaluate('lookupdisplay(app_id)',"+string( i)+")")
	//Start Code Change ----07.20.2017 #V154 maha - error trapping
	elseif 	ads_data.dataobject = "d_appeon_net_dev_action_items_save" then 
		select application_name into :ls_app_name from app_hdr where app_id = :ll_app_id; 
	//End Code Change ----07.20.2017
	else
		ls_app_name = ads_data.getitemstring(i, "app_hdr_application_name")
	end if
	//---------End Modfiied ------------------------------------------------------
	
	if ads_data.Describe("facility_id.ColType") <> "!" then ll_facility_id = ads_data.GetItemNumber(i, "facility_id") 
	li_nr = lds_sys_audit_appl.InsertRow( 0 )	
	lds_sys_audit_appl.SetItem( li_nr, "prac_id", ll_prac )					
	lds_sys_audit_appl.SetItem( li_nr, "table_id", li_table_id )
	lds_sys_audit_appl.SetItem( li_nr, "field_id", 1001 )
	lds_sys_audit_appl.SetItem( li_nr, "old_value", ls_old_value )
	lds_sys_audit_appl.SetItem( li_nr, "new_value", "Deleted" )
	lds_sys_audit_appl.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
	lds_sys_audit_appl.SetItem( li_nr, "audit_type", "D" )					
	lds_sys_audit_appl.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
	lds_sys_audit_appl.SetItem(li_nr, "app_id", ll_app_id)
	lds_sys_audit_appl.SetItem(li_nr, "appl_name", ls_app_name)
	lds_sys_audit_appl.SetItem(li_nr, "facility_id", ll_facility_id)
	lds_sys_audit_appl.SetItem(li_nr, "table_name", ls_table_name)
	
	choose case ls_table_name
		case 'net_dev_action_items' 
			lds_sys_audit_appl.SetItem( li_nr, "appl_rec_id", ll_rec_id )
			lds_sys_audit_appl.SetItem(li_nr, "gp_id", ll_gp_id)
		case 'net_dev_ids'
			lds_sys_audit_appl.SetItem( li_nr, "appl_rec_id", ll_rec_id )
		case 'pd_appl_tracking'		
			lds_sys_audit_appl.SetItem(li_nr, "appl_track_id", ll_rec_id)
			lds_sys_audit_appl.SetItem(li_nr, "gp_id", ll_gp_id)
	end choose
	
	//field audit update
	gnv_appeondb.of_startqueue( )
	select ids.sys_appaudit_id into :ll_audit_id_new from ids;
	update ids set sys_appaudit_id = (isnull(sys_appaudit_id,0)  + 1);	//(Appeon)Stephen 10.12.2017 - V15.3 Bug # 5832 - Keep getting Failed to update sys_audit table on Applications tab Case 73449
	//select max(audit_id) into :ll_audit_id from sys_audit_appl ;	
	gnv_appeondb.of_commitqueue( )
	
	if isnull(ll_audit_id_new) then ll_audit_id_new = 0
	ll_audit_id_new +=1	
	//---------Begin Commented by (Appeon)Stephen 10.12.2017 for V15.3 Bug # 5832 - Keep getting Failed to update sys_audit table on Applications tab Case 73449--------
	/*
	if isnull(ll_audit_id) then ll_audit_id = 0
	if ll_audit_id > ll_audit_id_new then ll_audit_id_new = ll_audit_id
	update ids set ids.sys_appaudit_id = :ll_audit_id_new;
	*/
	//---------End Commented ------------------------------------------------------
	
	//---------Begin Added by (Appeon)Stephen 05.17.2017 for : Concentra - error when adding workflow--------
	if sqlca.sqlcode < 0 then
		ROLLBACK USING SQLCA;	
		MessageBox("of_appfield_audit_delete_last", "Failed to update sys_audit_id!")
		if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl
		Return -1
	end if
	//---------End Added ------------------------------------------------------
	
	lds_sys_audit_appl.setitem(li_nr, "audit_id", ll_audit_id_new)	
	i = lds_sys_audit_appl.Update()
	IF i = -1 THEN
		ROLLBACK USING SQLCA;	
		MessageBox("of_appfield_audit_delete_last", "Failed to update sys_audit table!~r~n" + sqlca.sqlerrtext) //(Appeon)Stephen 10.12.2017 -add 'sqlca.sqlerrtext' -- V15.3 Bug # 5832
		if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl
		Return -1
	else
		COMMIT USING SQLCA;	
	END IF
	if IsValid(lds_sys_audit_appl) then destroy lds_sys_audit_appl
end if
return 1
end function

public function integer of_field_audit (datawindow adw);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.26.2007 By: Evan
//$<reason> New feature of import module.  replaces original function
string ls_Syntax
string ls_ErrorText
integer li_Return
DataStore lds_Data

//Dynamic create datawindow
lds_Data = Create DataStore
ls_Syntax = adw.object.datawindow.syntax
lds_Data.Create(ls_Syntax, ls_ErrorText)
adw.ShareData(lds_Data)

//Execute field audit
li_Return = of_field_audit(lds_Data, ls_ErrorText)
Destroy lds_Data
if li_Return = -1 then MessageBox("", ls_ErrorText)

Return li_Return
//---------------------------- APPEON END ----------------------------

//Integer i
//Integer c
//Integer li_rc
//Integer li_lu_rc
//Long li_seq_rc
//Long ll_seq_no
//Integer li_nr
//Integer li_col_cnt
//Integer li_table_id
//integer li_fs //maha 111502
//Long ll_rec_id
//Long ll_field_id
//Long ll_field_id2
//Long ll_field_id1
//Long ll_old_value
//Long ll_new_value
//long ll_facility_id //maha111802
//long ll_prac
//String ls_lookup_type
//String ls_is_lookup
//String ls_lookup_field_name
//String ls_retval
//String ls_old_value
//String ls_new_value
//String ls_value1
//String ls_value2
//String ls_table_name
//String ls_fld_nm
//String ls_fld_nm2
//String ls_fld_type
//
//n_ds lds_lookup_address
//n_ds lds_sys_audit
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<modify> 04.10.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Use pre-select approaches to improve the runtime performance of 
////$<modification> IntelliCred Web application.
///*
//n_ds lds_audit_fields
//n_ds lds_lookup_code
//n_ds lds_last_seq_no
//
//ls_table_name = adw.Object.DataWindow.Table.UpdateTable
////MessageBox("of audit trail", ls_table_name)
//
//lds_sys_audit = CREATE n_ds
//lds_sys_audit.DataObject = "d_view_audit"
//lds_sys_audit.of_SetTransObject( SQLCA )
//
//lds_last_seq_no = CREATE n_ds
//lds_last_seq_no.DataObject = "d_get_last_field_audit_seq_no"
//lds_last_seq_no.of_SetTransObject( SQLCA )
//
//lds_lookup_code = CREATE n_ds
//lds_lookup_code.DataObject = "d_lookup_code_search"
//lds_lookup_code.of_SetTransObject( SQLCA )
//
//lds_lookup_address = CREATE n_ds
//lds_lookup_address.DataObject = "d_lookup_address_search"
//lds_lookup_address.of_SetTransObject( SQLCA )
//
//lds_audit_fields = CREATE n_ds
////Start Code Change ---- 03.28.2006 #358 maha
//if gs_dbtype = "SQL" then
//	lds_audit_fields.DataObject = "d_audit_fields_sql"
//else
//	lds_audit_fields.DataObject = "d_audit_fields"
//end if
////End Code Change---03.28.2006
//lds_audit_fields.of_SetTransObject( SQLCA )
//li_col_cnt = lds_audit_fields.Retrieve( ls_table_name )
//
////messagebox("audit fields",li_col_cnt)
//IF li_col_cnt < 1 THEN
////	messagebox("audit fields",li_col_cnt)
//	Return -1
//END IF
//
//li_rc = adw.RowCount()
////messagebox("adw count",li_rc)
//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
//li_fs = of_get_facil_specific(li_table_id)
//*/
//datastore lds_audit_fields
//
//IF NOT IsValid(ids_sys_audit) THEN
//	ids_sys_audit = CREATE n_ds
//	ids_sys_audit.DataObject = "d_view_audit"
//	ids_sys_audit.SetTransObject( SQLCA )
//END IF
//lds_sys_audit = ids_sys_audit
//
//ls_table_name = adw.Object.DataWindow.Table.UpdateTable
//
//lds_audit_fields = gnv_data.ids_sys_fields
//lds_audit_fields.SetFilter( "sys_tables_table_name = '" + ls_table_name + "' AND sys_fields_audit_fld = 'Y'" )
//lds_audit_fields.Filter()
//li_col_cnt =  lds_audit_fields.Rowcount( )
//IF li_col_cnt < 1 THEN
//	Return -1
//END IF
//
//li_rc = adw.RowCount()
//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
//li_fs = of_get_facil_specific(li_table_id)
//
//Long ll_value_arr[],ll_j
//Boolean lb_data_view_screen
//Long ll_reference_field_1,ll_reference_field_2
//Date ld_today
//Time lt_today
//
//FOR i = 1 TO li_rc
//	ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 
//	ll_prac = adw.GetItemNumber( i, "prac_id" )
//	if li_fs = 1 then
//		if ls_table_name = "pd_affil_stat" then
//			ll_facility_id = adw.GetItemNumber( i, "parent_facility_id" )
//		else
//			ll_facility_id = adw.GetItemNumber( i, "facility_id" )
//		end if
//	end if
//
//	IF adw.GetItemStatus( i, 0, Primary! ) = DataModified! THEN
//		FOR c = 1 TO li_col_cnt
//			ll_field_id = lds_audit_fields.GetItemNumber( c, "field_id" )
//			ls_fld_nm = lds_audit_fields.GetItemString( c, "field_name" )
//			ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
//
//			IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//				ls_fld_type = "C"
//			ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//				ls_fld_type = "D"
//			ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 OR PosA( ls_fld_type, "REAL" ) > 0 THEN
//				ls_fld_type = "N"
//			ELSEIF ls_fld_type = "!" THEN
//				CONTINUE
//			ELSE				
//				MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//				Return -1
//			END IF
//
//			IF adw.GetItemStatus( i, ls_fld_nm, Primary! ) = DataModified! THEN
//				ls_lookup_field_name = UPPER( lds_audit_fields.GetItemString( c, "lookup_field_name" ) )
//				ls_is_lookup = lds_audit_fields.GetItemString( c, "lookup_field" )
//				ls_lookup_type = lds_audit_fields.GetItemString( c, "lookup_type" )								
//				IF ls_fld_type = "N" AND ls_is_lookup = "Y" AND ls_lookup_type <> "C" THEN
//					ll_old_value = adw.GetItemNumber( i, ls_fld_nm, Primary!, True ) 
//					ll_j ++
//					ll_value_arr[ll_j] = ll_old_value
//					ll_new_value = adw.GetItemNumber( i, ls_fld_nm )
//					ll_j ++
//					ll_value_arr[ll_j] = ll_new_value
//				END IF
//			END IF
//		END FOR
//	END IF
//
//	IF adw.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
//		choose case ls_table_name
//			case "pd_affil_stat","pd_affil_dept","pd_affil_staff_cat","pd_affil_staff_leave"
//			case else
//				lb_data_view_screen = TRUE
//
//				/*
//				select reference_field_1,reference_field_2
//				into :ll_reference_field_1 , :ll_reference_field_2
//				from data_view_screen 
//				where table_id = :li_table_id and data_view_id = 1;
//				*/
//
//				ll_reference_field_1 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_1", "data_view_id = 1 and table_id = " + String(li_table_id)))
//				ll_reference_field_2 = Long(gnv_data.of_getitem( "data_view_screen", "reference_field_2", "data_view_id = 1 and table_id = " + String(li_table_id)))
//			
//				ll_field_id1 = ll_reference_field_1
//				if lds_audit_fields.rowcount() > 0 then
//					if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
//				end if
//
//				ll_field_id2 = ll_reference_field_2
//				if lds_audit_fields.rowcount() > 1 then
//					if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
//				end if
//
//				//get reference field name 1
//				ls_fld_nm = gnv_data.of_getitem( "sys_fields", "field_name", "field_id = " + String(ll_field_id1) )
//				if lds_audit_fields.rowcount() > 0 then
//					if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
//				end if
//
//				//get reference field name 2
//				ls_fld_nm2 = gnv_data.of_getitem( "sys_fields", "field_name", "field_id = " + String(ll_field_id2) )
//				if lds_audit_fields.rowcount() > 1 then
//					if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
//				end if
//				
//				//datatype and lookup field
//				ls_fld_type = gnv_data.of_getitem( "sys_fields", "field_type", "field_id = " + String(ll_field_id1) )
//				ls_lookup_type = gnv_data.of_getitem( "sys_fields", "lookup_type", "field_id = " + String(ll_field_id1) )
//
//				ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
//				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//					Return -1
//				END IF
//
//				choose case ls_fld_type
//					case "C","V"
//						ls_value1 = adw.GetItemString( i, ls_fld_nm )
//					case "N", "I"
//						ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm ))
//					case "D"
//						ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm ))
//					case else
//						ls_value1 = ""
//				end choose
//
//				IF ls_lookup_type = "A" THEN
//					ll_j ++
//					ll_value_arr[ll_j] = Long(ls_value1)
//				END IF
//				
//				ls_fld_type = gnv_data.of_getitem( "sys_fields", "field_type", "field_id = " + String(ll_field_id2) )
//				ls_lookup_type = gnv_data.of_getitem( "sys_fields", "lookup_type", "field_id = " + String(ll_field_id2) )
//
//				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
//				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//					Return -1
//				END IF
//				
//				choose case ls_fld_type
//					case "C","V"
//						ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
//					case "N", "I"
//						ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
//					case "D"
//						ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
//					case else
//						ls_value2 = ""
//				end choose		
//
//				IF ls_lookup_type = "A" THEN
//					ll_j ++
//					ll_value_arr[ll_j] = Long(ls_value2)
//				END IF
//		end choose
//	END IF
//END FOR
//
//IF ll_j > 0 THEN
//	lds_lookup_address = CREATE n_ds
//	lds_lookup_address.DataObject = "d_lookup_address_search_all"
//	lds_lookup_address.settransObject( SQLCA )
//	lds_lookup_address.Retrieve( ll_value_arr[] )
//END IF
//
////---------------------------- APPEON END ----------------------------
//
//FOR i = 1 TO li_rc
//		ll_rec_id = adw.GetItemNumber( i, "rec_id" ) 
//		ll_prac = adw.GetItemNumber( i, "prac_id" )
//		if li_fs = 1 then
//			if ls_table_name = "pd_affil_stat" then
//				ll_facility_id = adw.GetItemNumber( i, "parent_facility_id" )
//			else
//				ll_facility_id = adw.GetItemNumber( i, "facility_id" )
//			end if
//		end if
//	IF adw.GetItemStatus( i, 0, Primary! ) = DataModified! THEN
//		//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
//		//messagebox("audit fields","data modified")
//		FOR c = 1 TO li_col_cnt
//			
//			ll_field_id = lds_audit_fields.GetItemNumber( c, "field_id" )
//			ls_fld_nm = lds_audit_fields.GetItemString( c, "field_name" )
//			ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
//			//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//			
//			IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//				ls_fld_type = "C"
//			ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//				ls_fld_type = "D"
//			ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 OR PosA( ls_fld_type, "REAL" ) > 0 THEN
//				ls_fld_type = "N"
//			ELSEIF ls_fld_type = "!" THEN
//				//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//				CONTINUE
//			ELSE				
//				MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//				Return -1
//			END IF
//			//ls_fld_type = lds_audit_fields.GetItemString( c, "field_type" )
//			IF adw.GetItemStatus( i, ls_fld_nm, Primary! ) = DataModified! THEN
//				ls_lookup_field_name = UPPER( lds_audit_fields.GetItemString( c, "lookup_field_name" ) )
//				ls_is_lookup = lds_audit_fields.GetItemString( c, "lookup_field" )
//				ls_lookup_type = lds_audit_fields.GetItemString( c, "lookup_type" )								
//				IF ls_fld_type = "C" THEN
//					ls_old_value = adw.GetItemString( i, ls_fld_nm, Primary!, True )
//					ls_new_value = adw.GetItemString( i, ls_fld_nm )
//				ELSEIF ls_fld_type = "N" THEN
//					ll_old_value = adw.GetItemNumber( i, ls_fld_nm, Primary!, True ) 
//					ll_new_value = adw.GetItemNumber( i, ls_fld_nm ) 												
//					IF ls_is_lookup = "Y" THEN
//						IF ls_lookup_type = "C" THEN
//							//--------------------------- APPEON BEGIN ---------------------------
//							//$<ID> PT-03
//							//$<modify> 02.27.2006 By: LeiWei
//							//$<reason> Performance tuning
//							//$<modification> Write script to retrieve data from a cache instead of from the database.
//
//							/*
//							//get the old value
//							li_lu_rc = lds_lookup_code.Retrieve( ll_old_value )
//							IF li_lu_rc = 0 THEN
//								ls_old_value = ""
//							ELSEIF ls_lookup_field_name = "CODE" THEN
//								ls_old_value = lds_lookup_code.GetItemString( 1, "code" )									
//							ELSE
//								ls_old_value = lds_lookup_code.GetItemString( 1, "description" )								
//							END IF
//							//get the new value
//							li_lu_rc = lds_lookup_code.Retrieve( ll_new_value )
//							IF li_lu_rc = 0 THEN
//								ls_new_value = ""
//							ELSEIF ls_lookup_field_name = "CODE" THEN
//								ls_new_value = lds_lookup_code.GetItemString( 1, "code" )									
//							ELSE
//								ls_new_value = lds_lookup_code.GetItemString( 1, "description" )								
//							END IF								
//							*/
//
//							//get the old value						
//							IF ls_lookup_field_name = "CODE" THEN
//								ls_old_value = gnv_data.of_getitem( 'code_lookup', 'code', 'lookup_code='+string(ll_old_value))
//							ELSE
//								ls_old_value = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_old_value))
//							END IF
//
//							//get the new value
//							IF ls_lookup_field_name = "CODE" THEN
//								ls_new_value = gnv_data.of_getitem( 'code_lookup', 'code', 'lookup_code='+string(ll_new_value))
//							ELSE
//								ls_new_value = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//							END IF							
//							//---------------------------- APPEON END ----------------------------
//						ELSE
//							//--------------------------- APPEON BEGIN ---------------------------
//							//$<ID> PT-04
//							//$<modify> 02.27.2006 By: LeiWei
//							//$<reason> Performance tuning
//							//$<modification> Write script to retrieve data from a cache instead of from the database.
//							/*
//							//get the old value
//							li_lu_rc = lds_lookup_address.Retrieve( ll_old_value )
//							*/
//							//get the old value
//							lds_lookup_address.SetFilter("lookup_code = " + string(ll_old_value))
//							lds_lookup_address.Filter()
//							li_lu_rc = lds_lookup_address.Rowcount()
//							//---------------------------- APPEON END ----------------------------
//							
//							IF li_lu_rc = 0 THEN
//								ls_old_value = ""
//							ELSEIF ls_lookup_field_name = "CODE" THEN
//								ls_old_value = lds_lookup_address.GetItemString( 1, "code" )									
//							ELSE
//								ls_old_value = lds_lookup_address.GetItemString( 1, "entity_name" )								
//							END IF
//
//							//--------------------------- APPEON BEGIN ---------------------------
//							//$<ID> PT-05
//							//$<modify> 02.27.2006 By: LeiWei
//							//$<reason> Performance tuning
//							//$<modification> Write script to retrieve data from a cache instead of from the database.
//							/*
//							//get the new value
//							li_lu_rc = lds_lookup_address.Retrieve( ll_new_value )
//							*/
//							//get the new value
//							lds_lookup_address.SetFilter("lookup_code = " + string(ll_new_value))
//							lds_lookup_address.Filter()
//							li_lu_rc = lds_lookup_address.Rowcount()
//							//---------------------------- APPEON END ----------------------------
//							
//							IF li_lu_rc = 0 THEN
//								ls_new_value = ""
//							ELSEIF ls_lookup_field_name = "CODE" THEN
//								ls_new_value = lds_lookup_address.GetItemString( 1, "code" )									
//							ELSE
//								ls_new_value = lds_lookup_address.GetItemString( 1, "entity_name" )																
//							END IF
//						END IF
//					ELSE
//						ls_old_value = String( adw.GetItemNumber( i, ls_fld_nm, Primary!, True ) )
//						ls_new_value = String( adw.GetItemNumber( i, ls_fld_nm ) )						
//					END IF
//				ELSE
//					ls_old_value = String( Date( adw.GetItemDateTime( i, ls_fld_nm, Primary!, True ) ) )
//					ls_new_value = String( Date( adw.GetItemDateTime( i, ls_fld_nm ) ) )												
//				END IF
//				
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-06
//				//$<comment> 02.27.2006 By: LeiWei
//				//$<reason> Performance tuning
//				//$<reason> The following script is moved to the function of_field_audit_update
//				//$<reason> and they are integrated with other SQL statements together into Appeon Queue
//				//$<reason> labels for performance tuning.
//				/*
//				ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
//				IF ll_seq_rc > 0 THEN
//					ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
//				END IF
//				IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
//					ll_seq_no = 1
//				ELSE
//					ll_seq_no++
//				END IF
//				*/
//				//---------------------------- APPEON END ----------------------------
//
//				li_nr = lds_sys_audit.InsertRow( 0 )
//				lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
//				lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
//				lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
//				lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
//				lds_sys_audit.SetItem( li_nr, "field_id", ll_field_id )
//				lds_sys_audit.SetItem( li_nr, "old_value", MidA(ls_old_value,1,100) )
//				lds_sys_audit.SetItem( li_nr, "new_value", MidA(ls_new_value,1 ,100 ))
//				lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
//				lds_sys_audit.SetItem( li_nr, "audit_type", "E" )					
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> UM-03
//				//$<modify> 02.28.2006 By: LeiWei
//				//$<reason> DateTime( Date(Today()), Time(Now()) ) is currently unsupported.
//				//$<modification> Modify it to DateTime( Today(), Now() ).
//				/*
//				lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Date(Today()), Time(Now()) ) )
//				*/
//				lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ))
//				//---------------------------- APPEON END ----------------------------
//
//				lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
//				if li_fs = 1 then
//					lds_sys_audit.SetItem( li_nr, "facility_id", ll_facility_id )
//				else
//					lds_sys_audit.SetItem( li_nr, "facility_id", 0 )
//				end if
//			END IF
//		END FOR
//////***********************************INSERT \/		
//	elseif adw.GetItemStatus( i, 0, Primary! ) = NewModified! THEN //maha 070902 for INSERTS
//		//li_table_id = lds_audit_fields.GetItemNumber( 1, "table_id" )
//		ll_field_id = 1000 
//		//messagebox("li_table_id",li_table_id)
//
//		//messagebox("of_audit","in insert code")
//		choose case ls_table_name
//			case "pd_affil_stat"
//				ll_new_value = adw.GetItemnumber( i, "parent_facility_id" )
//				
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-07
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
//				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
//				//---------------------------- APPEON END ----------------------------
//				
//				ls_value2 = adw.GetItemstring( i, "apptmnt_type" )
//				ls_new_value = ls_value1 + "-" + ls_value2
//			case "pd_affil_dept"
//				ll_new_value = adw.GetItemnumber( i, "department" )
//				
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-08
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
//				ls_value2 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//				//---------------------------- APPEON END ----------------------------
//
//				ll_new_value = adw.GetItemnumber( i, "facility_id" )
//
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-09
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select facility_name into :ls_value1 from facility where facility_id = :ll_new_value;
//				ls_value1 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
//				//---------------------------- APPEON END ----------------------------
//
//				ls_new_value = ls_value1 + "-" + ls_value2
//			case "pd_affil_staff_cat"
//				ll_new_value = adw.GetItemnumber( i, "facility_id" )
//
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-10
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
//				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
//				//---------------------------- APPEON END ----------------------------
//
//				ll_new_value = adw.GetItemnumber( i, "staff_category" )
//
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-11
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
//				ls_value1 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//				//---------------------------- APPEON END ----------------------------	
//				
//				ls_new_value = ls_value1 + "-" + ls_value2
//			case "pd_affil_staff_leave"
//				ll_new_value = adw.GetItemnumber( i, "facility_id" )
//
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-12
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select facility_name into :ls_value2 from facility where facility_id = :ll_new_value;
//				ls_value2 = gnv_data.of_getitem("facility","facility_name","facility_id = " + String(ll_new_value))
//				//---------------------------- APPEON END ----------------------------
//
//				ll_new_value = long(adw.GetItemstring( i, "leave_of_absence_reason" ))
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-13
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
//				ls_value1 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//				//---------------------------- APPEON END ----------------------------	
//
//				ls_new_value = ls_value1 + "-" + ls_value2
//			case else //data entry screens
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-14
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//$<reason> Performance tuning
//				
//				/*
//				//ls_new_value = of_get_reference_val(li_table_id)
//				//get reference field 1
//				select reference_field_1 into :ll_field_id1  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
//				if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
//				//get reference field 2
//				select reference_field_2 into :ll_field_id2  from data_view_screen where table_id = :li_table_id and data_view_id = 1;
//				if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
//				//get reference field name 1
//				select field_name into :ls_fld_nm from sys_fields where field_id = :ll_field_id1;
//				if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
//				//get reference field name 2
//				select field_name into :ls_fld_nm2 from sys_fields where field_id = :ll_field_id2;
//				if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
//
//				//ref 1 data
//				//datatype and lookup field
//				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id1;
//				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id1;
//				*/	
//
//				//get reference field 1
//				ll_field_id1 = ll_reference_field_1
//				if lds_audit_fields.rowcount() > 0 then
//					if isnull(ll_field_id) or ll_field_id1 < 1 then ll_field_id1 = lds_audit_fields.GetItemNumber( 1, "field_id" )
//				end if
//
//				//get reference field 2
//				ll_field_id2 = ll_reference_field_2
//				if lds_audit_fields.rowcount() > 1 then
//					if isnull(ll_field_id2) or ll_field_id2 < 1 then ll_field_id2 = lds_audit_fields.GetItemNumber( 2, "field_id" )
//				end if
//
//				//get reference field name 1
//				ls_fld_nm = gnv_data.of_getitem( "sys_fields", "field_name", "field_id = " + String(ll_field_id1) )
//				if lds_audit_fields.rowcount() > 0 then
//					if isnull(ls_fld_nm) or ls_fld_nm = "" then ls_fld_nm = lds_audit_fields.GetItemString( 1, "field_name" )
//				end if
//
//				//get reference field name 2
//				ls_fld_nm2 = gnv_data.of_getitem( "sys_fields", "field_name", "field_id = " + String(ll_field_id2) )
//				if lds_audit_fields.rowcount() > 1 then
//					if isnull(ls_fld_nm2) or ls_fld_nm2 = "" then ls_fld_nm2 = lds_audit_fields.GetItemString( 2, "field_name" )
//				end if
//				
//				//datatype and lookup field
//				ls_fld_type = gnv_data.of_getitem( "sys_fields", "field_type", "field_id = " + String(ll_field_id1) )
//				ls_lookup_type = gnv_data.of_getitem( "sys_fields", "lookup_type", "field_id = " + String(ll_field_id1) )
//
//				//---------------------------- APPEON END ----------------------------
//
//
//				ls_fld_type = Upper( adw.Describe( ls_fld_nm + ".ColType" ) )
//				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//					Return -1
//				END IF
//				//data value
//				choose case ls_fld_type
//					case "C","V"
//						ls_value1 = adw.GetItemString( i, ls_fld_nm )
//					case "N", "I"
//						ls_value1 = string(adw.GetItemnumber( i, ls_fld_nm ))
//					case "D"
//						ls_value1 = string(adw.GetItemdatetime( i, ls_fld_nm ))
//					case else
//						ls_value1 = ""
//				end choose
//				//if lookup get lookup value
////					MessageBox("ls_lookup_type 1", ls_lookup_type)
////					messagebox("ls_fld_nm",ls_fld_nm)
//				if ls_lookup_type = "C" then
//					ll_new_value = long(ls_value1) //convert to number
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-15
//					//$<modify> 02.27.2006 By: LeiWei
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//					//select description into :ls_value1 from code_lookup where lookup_code = :ll_new_value;
//					ls_value1 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//					//---------------------------- APPEON END ----------------------------	
//				elseif ls_lookup_type = "A" then
////					messagebox("in","addr lookup")
////					MessageBox("ls_value1 a", ls_value1)
//					ll_new_value = long(ls_value1)
//
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-16
//					//$<modify> 02.27.2006 By: LeiWei
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//					//$<reason> Performance tuning 
//					/*
//						select entity_name into :ls_value1 from address_lookup where lookup_code = :ll_new_value;
//					*/
//					ll_j = lds_lookup_address.Find("lookup_code = " + string(ll_new_value),1, lds_lookup_address.Rowcount())
//					IF ll_j > 0 THEN ls_value1 = lds_lookup_address.GetItemString(ll_j , "entity_name" )
//					//---------------------------- APPEON END ----------------------------
//
//					//MessageBox("ls_value1 after lookup", ls_value1)
//				end if
//				
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-17
//				//$<modify> 02.27.2006 By: LeiWei
//				//$<modification> Write script to retrieve data from a cache instead of from the database.
//				//$<reason> Performance tuning
//				/*
//				//reference 2 info
//				select field_type into :ls_fld_type from sys_fields where field_id = :ll_field_id2;
//				select lookup_type into :ls_lookup_type from sys_fields where field_id = :ll_field_id2;
//				*/
//				ls_fld_type = gnv_data.of_getitem( "sys_fields", "field_type", "field_id = " + String(ll_field_id2) )
//				ls_lookup_type = gnv_data.of_getitem( "sys_fields", "lookup_type", "field_id = " + String(ll_field_id2) )
//				//---------------------------- APPEON END ----------------------------
//
//				ls_fld_type = Upper( adw.Describe( ls_fld_nm2 + ".ColType" ) )
//				IF PosA( ls_fld_type, "CHAR" ) > 0 THEN
//					ls_fld_type = "C"
//				ELSEIF PosA( ls_fld_type, "DATE" ) > 0 THEN
//					ls_fld_type = "D"
//				ELSEIF PosA( ls_fld_type, "LONG" ) > 0 OR PosA( ls_fld_type, "DECIMAL" ) > 0 THEN
//					ls_fld_type = "N"
//				ELSEIF ls_fld_type = "!" THEN
//					//messagebox(ls_fld_nm, adw.Describe( ls_fld_nm + ".ColType" ) )
//					CONTINUE
//				ELSE				
//					MessageBox("", "Unknown data type " + ls_fld_type + " for field " + ls_fld_nm )
//					Return -1
//				END IF
//				
//				choose case ls_fld_type
//					case "C","V"
//						ls_value2 = adw.GetItemString( i, ls_fld_nm2 )
//					case "N", "I"
//						ls_value2 = string(adw.GetItemnumber( i, ls_fld_nm2 ))
//					case "D"
//						ls_value2 = string(adw.GetItemdatetime( i, ls_fld_nm2 ))
//					case else
//						ls_value2 = ""
//				end choose		
//				//MessageBox("ls_lookup_type 2", ls_lookup_type)
//				if ls_lookup_type = "C" then
//					ll_new_value = long(ls_value2)
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-18
//					//$<modify> 02.27.2006 By: LeiWei
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//					//select description into :ls_value2 from code_lookup where lookup_code = :ll_new_value;
//					ls_value2 = gnv_data.of_getitem( 'code_lookup', 'description', 'lookup_code='+string(ll_new_value))
//					//---------------------------- APPEON END ----------------------------	
//				elseif ls_lookup_type = "A" then
//					ll_new_value = long(ls_value2)
//					
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> PT-19
//					//$<modify> 02.27.2006 By: LeiWei
//					//$<modification> Write script to retrieve data from a cache instead of from the database.
//					//$<reason> Performance tuning 
//					/*
//						select entity_name into :ls_value2 from address_lookup where lookup_code = :ll_new_value;
//					*/
//					ll_j = lds_lookup_address.Find("lookup_code = " + string(ll_new_value),1, lds_lookup_address.Rowcount())
//					IF ll_j > 0 THEN ls_value2 = lds_lookup_address.GetItemString(ll_j , "entity_name" )
//					//---------------------------- APPEON END ----------------------------
//					
//				end if
//				//check for nulls
//				if isnull(ls_value1) then ls_value1  = ""
//				if isnull(ls_value2) then ls_value2  = ""
//				ls_new_value = ls_value1 + "-" + ls_value2
//				ls_new_value = MidA(ls_new_value,1,100)
//////				MessageBox("ls_value1",ls_value1)
//////				MessageBox("ls_value2",ls_value2)
//		end choose
//		
//		//ls_new_value = ls_value1 + "-" + ls_value2
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-20
//		//$<comment> 02.27.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Move the following script to the of_field_audit_update function
//		//$<modification> and they are integrated with other SQL statements together into Appeon Queue labels
//		//$<modification> for performance tuning.
//		/*
//		ll_seq_rc = lds_last_seq_no.Retrieve( ll_rec_id, ll_field_id )
//		IF ll_seq_rc > 0 THEN
//			ll_seq_no = lds_last_seq_no.GetItemNumber(1, "last_seq_no" ) 
//		END IF
//		IF ll_seq_no = 0 OR IsNull( ll_seq_no ) THEN
//			ll_seq_no = 1
//		ELSE
//			ll_seq_no++
//		END IF
//		*/
//		//---------------------------- APPEON END ----------------------------
//
////		messagebox("rec_id", ll_rec_id )
////		messagebox("ll_field_id", ll_field_id )
////		messagebox("ll_seq_no",ll_seq_no)
//		li_nr = lds_sys_audit.InsertRow( 0 )
//		lds_sys_audit.SetItem( li_nr, "rec_id", ll_rec_id )
//		lds_sys_audit.SetItem( li_nr, "prac_id", adw.GetItemNumber( i, "prac_id" ) )					
//		lds_sys_audit.SetItem( li_nr, "seq_no", ll_seq_no )										
//		lds_sys_audit.SetItem( li_nr, "table_id", li_table_id )
//		lds_sys_audit.SetItem( li_nr, "field_id", 1000 )
//		//lds_sys_audit.SetItem( li_nr, "old_value", "INSERT" )
//		lds_sys_audit.SetItem( li_nr, "new_value", ls_new_value )
//		lds_sys_audit.SetItem( li_nr, "user_id", gnv_app.of_getuserid() )
//		lds_sys_audit.SetItem( li_nr, "audit_type", "I" )					
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-21
//		//$<modify> 02.28.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Write script to retrieve data from a cache instead of from the database.
//		/*
//		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Date(Today()), Time(Now()) ) )
//		*/
//		lds_sys_audit.SetItem( li_nr, "date_time_modified", DateTime( Today(), Now() ) )
//		//---------------------------- APPEON END ----------------------------
//		
//		lds_sys_audit.SetItem( li_nr, "sys_audit_exported", 1 )
//		if li_fs = 1 then
//			lds_sys_audit.SetItem( li_nr, "facility_id", ll_facility_id )
//		else
//			lds_sys_audit.SetItem( li_nr, "facility_id", 0)
//		end if
//		
/////************************DELETE code moved to separate function
//	
//	END IF
//END FOR
//
////if lds_sys_audit.rowcount() > 1 then maha 102003 trap not completed for multiple staff cat records
////	for i = 1 to ds_sys_audit.rowcount()
////		lds_sys_audit.getItemnumber( i ,"rec_id" )
////end if
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-22
////$<modify> 02.27.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Call the of_field_audit_update() function when the loop is done.  Refer to
////$<modification> PT-06, PT-20 for more information.
///*
//IF lds_sys_audit.Update() = -1 THEN
//	MessageBox("", "Update to sys_audit table Failed!")
//	Return -1
//END IF
//
////Start Code Change ---- 11.03.2005 #18 maha
//of_set_mod_date(ll_prac)
////End Code Change---11.03.2005 
//
//COMMIT USING SQLCA;
//*/
//
//THIS.POST of_field_audit_update()
//
////---------------------------- APPEON END ----------------------------
//RETURN 1
end function

public function integer of_sqlfield_audit (long al_prac_id, long al_rec_id, integer ai_facility_id, integer ai_table_id, string as_field_name, string as_new_value, string as_old_value, string as_audit_type);//====================================================================
//$<Function>: of_sqlfield_audit
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.03.2016 (V15.3-Image Auditing in IntelliCred)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_sys_seq
long ll_field_id
datetime ldt_now
string   ls_user_name

ls_user_name = gnv_app.of_getuserid()

gnv_appeondb.of_startqueue()
SELECT Max( sys_audit.seq_no )  
		INTO :ll_sys_seq
		FROM sys_audit;		

select field_id into :ll_field_id from sys_fields where table_id = :ai_table_id and field_name = :as_field_name;
gnv_appeondb.of_commitqueue()

IF IsNull(ll_sys_seq) THEN ll_sys_seq = 0
ll_sys_seq +=1
ldt_now = datetime( today(),now())

choose case as_audit_type 
	case "I" 
		insert into sys_audit(rec_id, prac_id, seq_no, table_id, field_id, new_value, user_id, audit_type, date_time_modified, facility_id, exported)
					values(:al_rec_id, :al_prac_id, :ll_sys_seq, :ai_table_id, 1000, :as_new_value, :ls_user_name, 'I', :ldt_now, :ai_facility_id, 1); 
	
	case "E"
		insert into sys_audit(rec_id, prac_id, seq_no, table_id, field_id, new_value, old_value, user_id, audit_type, date_time_modified, facility_id, exported)
					values(:al_rec_id, :al_prac_id, :ll_sys_seq, :ai_table_id, :ll_field_id, :as_new_value, :as_old_value, :ls_user_name, 'E', :ldt_now, :ai_facility_id, 1); 
	case "D"
		insert into sys_audit(rec_id, prac_id, seq_no, table_id, field_id, new_value, old_value, user_id, audit_type, date_time_modified, facility_id, exported)
					values(:al_rec_id, :al_prac_id, :ll_sys_seq, :ai_table_id, 1001, 'Deleted', :as_old_value, :ls_user_name, 'D', :ldt_now, :ai_facility_id, 1); 
end choose

of_set_mod_date(al_prac_id)
return 1
end function

public function integer of_sort_evaluate (u_dw adw_data, string as_to_field);//Start Code Change ----11.10.2016 #V153 maha - for setting the lookup display value for sorting
integer r
integer rc
string ls_value
string ls_describe
string ls_from_field

//messagebox("evaluate", ls_from_field)
ls_from_field = mid(as_to_field, 7)
//ls_from_field = leftA(ls_from_field , len(ls_from_field ) - 1)  //Start Code Change ----08.17.2017 #V154 maha - remove last char(asc,desc)   //commented by Harry 2017-09-29 Sort order not working Case#73029 Bug_id#5819 

if adw_data.describe(ls_from_field + ".ColType") = "!" then return 0  //Start Code Change ----09.08.2017 #V154 maha - trap for invisible field

for r = 1 to adw_data.rowcount()
	ls_describe = "Evaluate('LookUpDisplay(" + ls_from_field + ")', " + string(r) + ")"  
	ls_value = adw_data.Describe(ls_describe)  
	adw_data.setitem(r, as_to_field, ls_value)
	adw_data.setitemstatus(r, as_to_field, primary!, Notmodified!)
next

return 1

end function

public function integer of_app_audit_item_create (integer al_facility, long al_prac, long al_temp_item_id, long al_affil_recid, long al_de_recid, string as_from, integer ai_complete, string as_ref);long ll_recid
string ls_compl
datetime ldt_now
long ll_status
integer uu

if ai_complete = 1 then
	ls_compl = "Y"
	 ldt_now = datetime(today(),now())
	 ll_status = 662
else
	ls_compl = "N"
	setnull( ldt_now)
	setnull( ll_status)
end if

	
ll_recid = gnv_app.of_Get_Id("RECORD_ID")

insert into pd_app_audit (record_id,	prac_id ,facility_id , seq_no, app_audit_id,	completed , fax_message, 	active_status, date_completed , data_status , 	appt_stat_id , de_rec_id ) values (:ll_recid, :al_prac,:al_facility,1,:al_temp_item_id,:ls_compl,:as_ref,1,:ldt_now,:ll_status,:al_affil_recid,:al_de_recid);
//messagebox("sqlca.sqlcode",string(sqlca.sqlcode))
if sqlca.sqlcode < 0 then
	messagebox("Auto Generate App Audit Record Failed",sqlca.SQLErrText)
end if
commit using sqlca;


return 1
end function

public function integer of_field_audit (datastore ads);//Start Code Change ----12.12.2016 #V153 maha - copied datawindow to use with datastore
string ls_Syntax
string ls_ErrorText
integer li_Return
DataStore lds_Data

//Dynamic create datawindow
lds_Data = Create DataStore
ls_Syntax = ads.object.datawindow.syntax
lds_Data.Create(ls_Syntax, ls_ErrorText)
ads.ShareData(lds_Data)

//Execute field audit
li_Return = of_field_audit(lds_Data, ls_ErrorText)
Destroy lds_Data
if li_Return = -1 then MessageBox("", ls_ErrorText)

Return li_Return

end function

public function string of_create_dynamic_dw_display (long al_prac_id, integer ai_data_view_id, integer ai_screen_id, u_dw adw_detail, u_dw adw_browse, boolean ab_screen_painter, integer ai_facility_id, boolean ab_add); //Start Code Change ----02.28.2017 #V153 maha
//for data entry screens

SetPointer(HourGlass!)
Integer li_facility_specific
Integer li_sort_data_cnt
Integer m1
Integer li_dddw_code_cnt
Integer li_dddw_address_cnt
Integer li_row_cnt
Integer m
integer res //maha110602
Integer li_index
Integer li_obj_cnt
Integer i
Integer li_key_cnt
Integer li_prac_row_cnt
Integer t
Integer li_col_cnt
Integer li_fld_label_width
Integer li_fld_width
Integer li_table_cnt
integer li_set //maha030702
integer li_uls //maha082305
integer li_access //maha 05.26.2009
integer s //maha 11.10.2016
long ll_max_height
Boolean ib_create_browse 
Boolean lb_table_found
Boolean lb_multi_tablE
Boolean lb_first_field = True
Boolean lb_has_active_status = False
String ls_retval
String ls_sort_syntax
String ls_month
String ls_fld_lbl_font_wght
String ls_detail_band_height
String ls_dummy_array[]
String ls_width
String ls_return_syntax
String ls_dddw_width[]
String ls_height
String ls_x
String ls_y
String ls_justification
String ls_text
String ls_obj_type
String ls_obj_name
String ls_field_x[] 
String ls_visible
String ls_field_y[]
String ls_field_label_x[]
String ls_field_label_height[]
String ls_field_label_y[] 
String ls_field_label[]
String ls_field_id[]
String ls_mask[]
String ls_table_names[]
String ls_field_names[]
String ls_table_field_names[]
String ls_dw_field_names[]
String ls_key_fields_col_nm[]
String ls_temp_table
String ls_table_name
String ls_field_name
String ls_sql_syntax
String ls_grey
String ls_white
string ls_yellow //maha 111909
string ls_background
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_lookup_code
String ls_lookup_type
String ls_lookup_field
String ls_key_fields_syntax
String ls_key_fields[]
string des
string ls_color
string ls_font = "Segoe UI"
string ls_sort_field[]   //maha 11.10.2016
string ls_sort_add_field[]   //maha 11.10.2016
string ls_sort_name  //maha 11.10.2016
Long ll_detail_height
string widt
DataWindowChild dwchild
DataWindowChild dwchild_browse
long set1 , ll_recreate
String ls_Bold, ls_italic

if isnull(ai_screen_id) or ai_screen_id < 0  then return "-1"	//12.12.2008 By Jervis WorkFlow = -10

ls_white = String(rgb(255,255,255))
ls_grey = "80269524"//String(rgb(192,192,192))
ls_yellow = string(gl_req_yellow)   //Start Code Change ----01.20.2016 #V15 maha   //"8257535" old yellow  
ls_background = "16777215"  //"16120575"   //Start Code Change ----03.23.2015 #V15 maha - change to white

If appeongetclienttype() <> 'PB' Then
	ll_recreate = of_create_option(ai_data_view_id,ai_screen_id,'Y','D',string(idt_screen_cache),ab_screen_painter)
	If ll_recreate = 0 Then
		ls_return_syntax = of_create_dynamic_dw_local(al_prac_id,ai_data_view_id,ai_screen_id,adw_detail,adw_browse,ab_screen_painter,ai_facility_id)
		If ls_return_syntax <> "-1" Then return ls_return_syntax
	End If
End If

//li_row_cnt is all the screen's fields
//upperbound- ls_dw_field_names[] is all visible fields only
ib_create_browse = True

//IF adw_detail = adw_browse THEN
//	ib_create_browse = False
//END IF

is_column_default[] = ls_dummy_array[]
is_column_names[] = ls_dummy_array[]

////UNREGISTER ALL CALENDAR FIELDS
////IF NOT ab_screen_painter THEN
////	adw_detail.iuo_calendar.of_UnRegister()		
////END IF

app_filler.ids_screen_fields_cache.ShareData( ids_screen_fields )
ids_screen_fields.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_fields.Filter( )	
li_row_cnt = ids_screen_fields.RowCount()	

app_filler.ids_screen_objects_cache.ShareData( ids_screen_objects )
ids_screen_objects.SetFilter( "view_id = " + String (ai_data_view_id) + " AND screen_id = " + String( ai_screen_id ) )
ids_screen_objects.Filter( )
li_obj_cnt = ids_screen_objects.RowCount()

ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.sort( ) //should be by field_order maha 051905 ######

ii_column_cnt = 0

ls_sql_syntax = "SELECT "
li_table_cnt = 0

adw_detail.SetRedraw(False)

//CREATE SORT ORDER
integer wer  //#####
wer = ids_screen_fields.SetSort( "sort_field A" ) //maha corrected 051005
ids_screen_fields.Sort()
ls_sort_syntax = " ORDER BY "
FOR i = 1 TO li_row_cnt
	IF ids_screen_fields.GetItemNumber( i, "sort_field" ) > 0 THEN
		//Start Code Change ----11.10.2016 #V153 maha - get info for later sorting
		ls_sort_name =  ids_screen_fields.GetItemString( i, "db_field_name" )
		
		if  ids_screen_fields.GetItemString( i, "lookup_field" ) = "Y" then
			ls_sort_name = "sort4_" + ls_sort_name
			ls_sort_add_field[ upperbound(ls_sort_add_field) + 1 ] = ls_sort_name   //add to array for fields to be added
		end if
		
		ls_sort_field[upperbound(ls_sort_field) + 1] = ls_sort_name
		//Start Code Change ----11.10.2016 
			
		IF ids_screen_fields.GetItemString( i, "sort_order" ) = "D" THEN
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " DESC,"			
		ELSE
			ls_sort_syntax = ls_sort_syntax + ids_screen_fields.GetItemString( i, "db_field_name" ) + " ASC,"			
		END IF
		li_sort_data_cnt ++
	END IF
END FOR

wer = ids_screen_fields.SetSort( "field_order A" )
ids_screen_fields.Sort()

//BUILD SELECT 
FOR i = 1 TO li_row_cnt
	IF ( NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" ) THEN
		CONTINUE //for visible =N do not add to the DE screen dw
	END IF
	ii_column_cnt++
	ls_table_name = Trim( ids_screen_fields.GetItemString( i, "db_table_name" ))
	ls_field_name = Trim( ids_screen_fields.GetItemString( i, "db_field_name" ))
	is_table_name = ls_table_name
	is_column_names[ii_column_cnt] = ls_field_name	
	is_column_default[ii_column_cnt] = ids_screen_fields.GetItemString( i, "default_value" )
	ls_mask[i] = ids_screen_fields.GetItemString( i, "field_mask" ) 
	ls_field_names[i] = ls_field_name
	ls_field_id[i] = String (ids_screen_fields.GetItemNumber( i, "field_id" ) )
	ls_field_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_x" ) )
	ls_field_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_y" ) )
	ls_field_label_height[i] = String (ids_screen_fields.GetItemNumber( i, "field_height" ) )
	if long(ls_field_y[i]) + long(ls_field_label_height[i]) > ll_max_height then ll_max_height = long(ls_field_y[i]) + long(ls_field_label_height[i])  //maha 051205
	ls_dddw_width[i] = String(ids_screen_fields.GetItemNumber(i, "drop_down_width"))
	ls_field_label_x[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_x" ) )
	ls_field_label_y[i] = String (ids_screen_fields.GetItemNumber( i, "field_label_y" ) )	
	ls_table_field_names[i] = MidA( ls_table_name,5,100 ) + "_" + ls_field_name
	ls_field_label[i] = ids_screen_fields.GetItemString( i, "field_label" )
	ls_sql_syntax = ls_sql_syntax + ls_table_name + "." + ls_field_name + ", "
	ls_fld_lbl_font_wght = String (ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" ) )	
	lb_table_found = False
	FOR t = 1 TO li_table_cnt
		IF ls_table_names[t] = ls_table_name THEN
			lb_table_found = True
		   EXIT
		END IF
	END FOR
	IF NOT lb_table_found THEN
		li_table_cnt ++
		ls_table_names[ li_table_cnt ] = ls_table_name
	END IF
END FOR

//Start Code Change ----11.10.2016 #V153 maha
if  upperbound(ls_sort_add_field) > 0 then
	for s = 1 to  upperbound(ls_sort_add_field)
		ls_sql_syntax = ls_sql_syntax + ls_sort_add_field[s] + " = '', "
		//ls_field_names[upperbound(ls_field_names) + 1] = ls_sort_add_field[s]
	next
end if
//Start Code Change ----11.10.2016

if li_table_cnt = 0 then
	Messagebox("Caution","Unable to create SELECT syntax for datawindow. ~rPossibly caused by no data view fields for screen_id " + string(ai_screen_id) + " and data_view_id " + string(ai_data_view_id) + ".~r~r" + ls_sql_syntax)
	return '-1'
end if

ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
li_row_cnt = UpperBound(ls_field_names)

//ADD KEY FIELDS TO SELECT
li_key_cnt = 0
FOR i = 1 TO li_table_cnt
	//---------Begin Modified by (Appeon)Stephen 08.08.2014 for BugL073101--------
	if PosA(ls_sql_syntax,"prac_id",1) = 0 then //maha 051503 for lehigh to allow making prac_id visible
	//Start Code Change ----09.15.2016 #V152 maha - changed back to the original code because it prevents adjusting the prac_id field if intended to appear on the screen
	//if f_get_pos(ls_sql_syntax, "prac_id", true) < 1 then
	//---------End Modfiied ------------------------------------------------------
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".prac_id, "
		li_key_cnt ++
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".prac_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_prac_id"
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "prac_id"
			ls_field_names[upperbound(ls_field_names) + 1] = "prac_id"
		END IF
	end if
	
	if PosA(ls_sql_syntax,"rec_id",1) = 0 then  //maha 051503 to allow making rec_id visible
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".rec_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".rec_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "rec_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_rec_id"
			ls_field_names[upperbound(ls_field_names) + 1] = "rec_id"
		END IF
	end if
	
	IF ids_screen_fields.GetItemNumber(i, "facility_specific" ) = 1 THEN
		li_facility_specific = 1
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".facility_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".facility_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "facility_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_facility_id"
		END IF

		if PosA(ls_sql_syntax,"facility_id",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "facility_id"
			end if
		end if
	END IF
	
	IF ai_screen_id = 61 or ai_screen_id = 33 or ai_screen_id = 32 THEN	//alfee 09.03.2009
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".seq_no, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".seq_no"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "seq_no"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_seq_no"
		END IF	
		
		if PosA(ls_sql_syntax,"seq_no",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "seq_no"
			end if
		end if
	END IF	
	
	//Start Code Change ----03.22.2010 #V10 maha - to hide the active and appt_stat_id fields that do not need to be visible.
	IF ai_screen_id = 65 then // attest questions  
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".active_status, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".active_status"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "active_status"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_active_status"
		END IF	

		if PosA(ls_sql_syntax,"active_status",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "active_status"
			end if
		end if
		
		li_key_cnt ++
		ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".appt_stat_id, "
		ls_key_fields[li_key_cnt] = ls_table_names[i] + ".appt_stat_id"
		IF li_table_cnt > 1 THEN
			ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
		ELSE
			ls_key_fields_col_nm[li_key_cnt] = "appt_stat_id"
			is_rec_id_col_nm = MidA(ls_table_names[ i ], 5, 100)  + "_appt_stat_id"
		END IF	

		if PosA(ls_sql_syntax,"appt_stat_id",1) = 0 then
			if li_table_cnt > 1 then
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = is_rec_id_col_nm
			else
				ls_field_names[upperbound(ls_field_names) + 1] = "appt_stat_id"
			end if
		end if
	end if	
	//End Code Change ----03.22.2010
	
	//------Begin Added by alfee 11.17.2016 -----------------------
	IF ai_screen_id = 2 then //For gp_id update in Address screen
		IF PosA(ls_sql_syntax, "gp_id",1) = 0 then 
			ls_key_fields_syntax = ls_key_fields_syntax + ls_table_names[ i ] + ".gp_id, "
			li_key_cnt ++
			ls_key_fields[li_key_cnt] = ls_table_names[i] + ".gp_id"
			IF li_table_cnt > 1 THEN
				ls_key_fields_col_nm[li_key_cnt] = MidA(ls_table_names[ i ], 5, 100)  + "_gp_id"
				ls_table_field_names[upperbound(ls_table_field_names) + 1] = ls_key_fields_col_nm[li_key_cnt]
			ELSE
				ls_key_fields_col_nm[li_key_cnt] = "gp_id"
				ls_field_names[upperbound(ls_field_names) + 1] = "gp_id"
			END IF			
		END IF
	END IF
	//------End Added --------------------------------------------------
		
END FOR

integer li_row_cnt_new
li_row_cnt_new = UpperBound(ls_field_names)	

ls_sql_syntax = MidA( ls_sql_syntax, 1, 7 ) + ls_key_fields_syntax + MidA(ls_sql_syntax, 8, 10000)

//ASSIGN DW FIELD NAMES
IF li_table_cnt > 1 THEN
	lb_multi_table = True
	//FOR i = 1 TO li_row_cnt	03/16/2007
	For i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_table_field_names[i]
	END FOR	
ELSE
	lb_multi_table = False
	//FOR i = 1 TO li_row_cnt	03/16/2007
	for i = 1 to li_row_cnt_new
		ls_dw_field_names[i] = ls_field_names[i]
	END FOR
END IF

//BUILD FROM CLAUSE
ls_sql_syntax = ls_sql_syntax + " FROM "
FOR i = 1 TO li_table_cnt
	ls_sql_syntax = ls_sql_syntax + ls_table_names[i] + ", "
END FOR
ls_sql_syntax = LeftA( ls_sql_syntax, LenA(ls_sql_syntax) -2 )
ls_return_syntax = ls_sql_syntax
//ADD WHERE CLAUSE
ls_sql_syntax = ls_sql_syntax + " WHERE " + ls_table_names[1] + ".prac_id  = " + String( al_prac_id )

IF li_facility_specific = 1 THEN
	ls_sql_syntax = ls_sql_syntax + " AND " + ls_table_names[1] + ".facility_id  = " + String( ai_facility_id )
END IF

//---------Begin Commented by (Appeon)Stephen 07.16.2015 for Bug id 4601 - Allegheny Webview Data Audit Case# 55838, 55847--------
/*
//Start Code Change ----11.05.2009 #V10 maha
if PosA(upper(ls_table_name), "PD_ATTEST_QUESTIONS",1) > 0 then
	 //Start Code Change ----07.15.2015 #V15 maha - for attest_quest
	if gl_prac_de_appt_id > 0 then
		ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.appt_stat_id = " + string(gl_prac_de_appt_id )
	else
		ls_sql_syntax = ls_sql_syntax + " AND pd_attest_questions.active_status in ( 1,4) " 
	end if
	 //End Code Change ----07.15.2015
end if
//End Code Change---11.05.2009
*/
//---------End Commented ------------------------------------------------------

//CREATE SORT ORDER code moved to top of function //maha 051905

//ADD order BY CLAUSE
IF li_sort_data_cnt > 0 THEN
	ls_sort_syntax = MidA( ls_sort_syntax, 1, LenA( ls_sort_syntax )-1 )
	ls_sql_syntax = ls_sql_syntax + ls_sort_syntax
else
	ls_sql_syntax = ls_sql_syntax + " ORDER BY rec_id" //maha 111604
END IF

//CREATE SYNTAX FOR DETAIL DW

ls_presentation_str = "style(type=form)" + " Column(Border=5 ) Datawindow(Color=" + ls_background + " )" + "Text(Background.Color=" + ls_grey + ")"  

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
	ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN "-1"
END IF

adw_detail.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN "-1"
END IF

If appeongetclienttype() <> 'PB' Then
	string ls_appeon_colname[],ls_editmask_colname[],ls_editmask_modify[]
	long li_appeon_index ,li_appeon_index2 
	
	ls_dwsyntax_str = adw_detail.describe("datawindow.syntax")
	li_appeon_index = 1
	li_appeon_index2 = 1
	
	FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
		IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			CONTINUE
		END IF

		IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
			ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
			li_appeon_index++
		END IF
	
		//--> Begin change Editmask 
			IF ls_dw_field_names[i] <> "active_status" THEN
				IF ls_mask[i] <> "" THEN
					IF ls_mask[i] = "##" THEN
					ELSEIF ls_mask[i] = "(###)###-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='(###)###-####'"
						Li_appeon_index2 ++					//Comment by Scofield on 2008-08-12
					ELSEIF ls_mask[i] = "###-##-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='###-##-####'"
						Li_appeon_index2 ++
					ELSEIF ls_mask[i] = "#####-####" THEN
						//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )				
						ls_editmask_colname[Li_appeon_index2] = ls_dw_field_names[i]
						ls_editmask_modify[Li_appeon_index2] = "EditMask.Mask='#####-####'"
						Li_appeon_index2 ++
					END IF
				END IF	
			END IF
			//--< end change Editmask 
	END FOR
	
	//specail code for pd_address
	IF ls_table_name = "pd_address" THEN
		set1 = of_get_app_setting("set_1","I")
		
		if set1 = 1 then //maha 072301 create populate button only if using addresses for find
			ls_appeon_colname[li_appeon_index] = 'street'
			li_appeon_index++
		end if
					
		ls_appeon_colname[li_appeon_index] = 'billing_address_id'
		li_appeon_index++
	END IF
	
	of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
	of_change_to_editmask(ls_dwsyntax_str, ls_editmask_colname)
	
	adw_detail.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS + ls_dwsyntax_str)

		RETURN "-1"
	END IF
End If
//---------------------------- APPEON END ----------------------------

//CREATE SYNTAX FOR BROWSE DW
IF ib_create_browse THEN
	ls_presentation_str = "style(type=grid)" + " Column(Border=0) Datawindow(Color=" + ls_background + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_syntax, &
		ls_presentation_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN "-1"
	END IF

	adw_browse.Create( ls_dwsyntax_str, ERRORS)

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN "-1"
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-06
	//$<add> 01.13.2006 By: Luke
	//$<reason> It is currently unsupported to automatically change a column's edit style on the Web.
	//$<modification> Modify the DataWindow syntax and then rebuild the DataWindow to
	//$<modification> implement the functionality of changing a column's edit style.
	If appeongetclienttype() <> 'PB' Then
		ls_dwsyntax_str = adw_browse.describe("datawindow.syntax")
		li_appeon_index = 1
		
		FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
			IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
				CONTINUE
			END IF
		
			IF ls_dw_field_names[i] = "active_status" THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
			
			IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
				ls_appeon_colname[li_appeon_index] = ls_dw_field_names[i]
				li_appeon_index++
			END IF
		END FOR
		
		//specail code for pd_address
		IF ls_table_name = "pd_address" THEN
			set1 = of_get_app_setting("set_1","I")
			
			if set1 = 1 then //maha 072301 create populate button only if using addresses for find
				ls_appeon_colname[li_appeon_index] = 'street'
				li_appeon_index++
			end if
						
			ls_appeon_colname[li_appeon_index] = 'billing_address_id'
			li_appeon_index++
		END IF
	
		of_change_to_dddw (ls_dwsyntax_str,ls_appeon_colname)
		adw_browse.Create( ls_dwsyntax_str, ERRORS)
		
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution", &
			"Create cause these errors: " + ERRORS + ls_dwsyntax_str)
			clipboard(ls_dwsyntax_str)
			RETURN "-1"
		END IF
	End If
	//---------------------------- APPEON END ----------------------------	
	
END IF
	

IF NOT ab_screen_painter THEN
	adw_detail.of_SetTransObject( SQLCA )
	li_prac_row_cnt = adw_detail.Retrieve()
END IF

IF li_prac_row_cnt = 0 THEN 
	//Start Code Change ---- 06.09.2006 #531 maha
	if ai_screen_id = 65 or ai_screen_id = 54 or ab_add = false  then  //Start Code Change ----01.15.2013 #V12 maha - addd ab_add variable
		if not ab_screen_painter then 
		//don't add row in prac folder
		else	
			adw_detail.InsertRow(0) //maha app081705
		end if
			
	else
		adw_detail.InsertRow(0) 
	end if
	//End Code Change---06.09.2006
	
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
	END IF
ELSE
	IF IsValid( m_pfe_cst_data_entry ) THEN
	//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True  maha removed 082503
	END IF
	//of_set_defaults( adw_detail, 1 )
	//adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF


IF	lb_multi_table THEN
	//adw_detail.of_SetMultiTable(TRUE)
	//FOR i = 1 TO li_table_cnt
		//adw_detail.inv_multitable.of_Register( ls_table_names[I], ls_table_2_fields, ls_table_2_update_fields, TRUE, 0)
	//END FOR
ELSE
	adw_detail.Object.DataWindow.Table.UpdateTable= ls_table_names[1]
	adw_detail.Object.DataWindow.Table.UpdateWhere= '0'
	adw_detail.Object.DataWindow.Table.UpdateKeyinPlace = 'Yes'
	//FOR i = 1 TO li_row_cnt		03/16/2007
	For i = 1 to li_row_cnt_new
		adw_detail.Modify( ls_dw_field_names[i] + ".Update= Yes")	
		IF PosA( ls_dw_field_names[i], "prac_id" ) > 0  OR PosA( ls_dw_field_names[i], "rec_id" ) > 0 THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Key=Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.DisplayOnly=Yes")
		END IF
	next
	//03/16/2007 
	li_access = w_mdi.of_security_access( 50 )  //Start Code Change ----05.26.2009 #V92 maha - security
	For i = 1 to li_row_cnt
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.14.2014
		//<$>reason:deal with li_access at last
		//if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 to allow single fields to be read only-//Start Code Change ----05.26.2009 #V92 maha
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y"  then //remove li_access
		//<$>reason:v14.2 Provider-Contract direct linking
		//------------------- APPEON END -------------------
			adw_detail.Modify(ls_dw_field_names[i] + ".TabSequence = '0'" ) //these values will be reset below
			//adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '553648127'") //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
		elseif  ids_screen_fields.GetItemstring( i, "display_only" ) = "P" then
			adw_detail.Modify(ls_dw_field_names[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
		end if
	END FOR
	//Start Code Change ----11.10.2016 #V153 maha - reset lookup sort fields
	if  upperbound(ls_sort_add_field) > 0 then
		
		for i = 1 to upperbound(ls_sort_add_field)
			adw_detail.Modify(	ls_sort_add_field[i] + ".Update= No"  )
			adw_detail.Modify(ls_sort_add_field[i] + ".TabSequence = '0'"  )
			adw_detail.Modify(ls_sort_add_field[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
		next
		
		if ib_create_browse then
			for i = 1 to upperbound(ls_sort_add_field)
				adw_browse.Modify(	ls_sort_add_field[i] + ".Update=No"  )
				adw_browse.Modify(ls_sort_add_field[i] + ".TabSequence = '0'"  )
				adw_browse.Modify(ls_sort_add_field[i] + ".Protect='1~tIf(IsNull( " + ls_dw_field_names[i] + " ),0,1)'")
				adw_browse.Modify(ls_sort_add_field[i] + ".Visible=False")
			next
		end if
		
	end if
	//End Code Change ----11.10.2016 
END IF
//debugbreak()
IF ib_create_browse THEN
	adw_detail.ShareData(adw_browse)
END IF

adw_detail.Modify("active_status.Initial='1'")

gnv_appeondb.of_startqueue()
FOR i = 1 TO li_row_cnt//ids_screen_fields.rowcount()
	IF NOT ab_screen_painter AND ids_screen_fields.GetItemString(i, "visible") = "N" THEN
		CONTINUE
	END IF

	//visible
	IF ab_screen_painter THEN
		IF ids_screen_fields.GetItemString(i, "visible") = "N" THEN
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '8421504'") 
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '12632256'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '8421504'") 
		ELSE
			adw_detail.Modify(ls_dw_field_names[i] + ".color = '0'") 
			adw_detail.Modify(ls_dw_field_names[i] + "_t.color = '0'")
			adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ---- 10.22.2007 #V7 maha added to make labels transparent
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '16777215'") //restored by alfee 03.26.2010 
			//adw_detail.Modify(ls_dw_field_names[i] + "_t.background.color = '" + ls_white + "'") //Start Code Change ----11.19.2009 #V10 maha
		END IF
	else
		adw_detail.Modify(ls_dw_field_names[i] + "_t.background.mode = '1'") //Start Code Change ----11.19.2009 #V92 maha
	END IF

	IF ab_screen_painter THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String( i * 10) + "'" )
	ELSE
		
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		IF LenA(ls_dw_field_names[i]) > 0 AND lb_first_field THEN
			lb_first_field = False
			is_first_column = ls_dw_field_names[i]
		END IF
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.14.2014
		//if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y" or li_access = 1 then //maha 041404 - //Start Code Change ----05.26.2009 #V92 maha
		if ids_screen_fields.GetItemstring( i, "display_only" ) = "Y"  then //remove li_access
		//<$>reason:deal with li_access at last
		//------------------- APPEON END -------------------
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
			adw_detail.Modify( ls_dw_field_names[i] + ".border = '2'" )
		else
			adw_detail.Modify( ls_dw_field_names[i] + ".TabSequence = '" + String(i) + "'" )
		end if
			
	END IF
	
	if isnull(ls_field_label[i]) then ls_field_label[i] = '' //Jervis 02.18.2008
	
	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".TabSequence = '0'" )
		adw_browse.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.face = '" + ls_font + "'")  //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + "_t.font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + ".font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
		adw_browse.Modify( ls_dw_field_names[i] + ".font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
	END IF
	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.text = '" + ls_field_label[i] + "'")
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + ".font.face = '" + ls_font + "'")   //Start Code Change ----01.25.2016 #V15 maha
	adw_detail.Modify( ls_dw_field_names[i] + ".font.height = '" + "-8" + "'")   //Start Code Change ----01.25.2016 #V15 maha

	//bold or not?
	adw_detail.Modify( ls_dw_field_names[i] + "_t.font.weight = '" + ls_fld_lbl_font_wght + "'")	
		

	if integer(ls_field_label_height[i]) > 120 then //maha added to allow multi line fields to wrap 011504
		//messagebox(ls_dw_field_names[i],ls_field_label_height[i])
		adw_detail.Modify( ls_dw_field_names[i] + ".edit.AutoHScroll = No")
		if ai_screen_id = 73 then adw_detail.Modify( ls_dw_field_names[i] + ".edit.VScrollBar = True") //V11.3 Issue Screen - Alfee 08.05.2011		
	end if

	li_fld_label_width = ids_screen_fields.GetItemNumber( i, "field_label_width" )
	li_fld_width = ids_screen_fields.GetItemNumber( i, "field_width" ) 
	adw_detail.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.width = '" + String( li_fld_label_width ) + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + ".height = '" + String( ls_field_label_height[i] ) + "'" )

	IF ib_create_browse THEN
		IF li_fld_width < li_fld_label_width THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_label_width ) + "'" )
		ELSE
			adw_browse.Modify( ls_dw_field_names[i] + ".width = '" + String( li_fld_width ) + "'" )
		END IF
	END IF

	
	IF ls_field_x[i] = "0" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".x = 750")
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + String(i*100) )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = 100")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + String(i*100) )
	ELSE
		adw_detail.Modify( ls_dw_field_names[i] + ".x = " + ls_field_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + ".y = " + ls_field_y[i] )

		adw_detail.Modify( ls_dw_field_names[i] + "_t.x = " + ls_field_label_x[i] )
		adw_detail.Modify( ls_dw_field_names[i] + "_t.y = " + ls_field_label_y[i] )		
	END IF

	//tag value set to field id
	adw_detail.Modify( ls_dw_field_names[i] + ".tag = '" + ls_field_id[i] + "'" )
	adw_detail.Modify( ls_dw_field_names[i] + "_t.tag = '" + ls_field_id[i] + "'" )

	//alignment
	adw_detail.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04/01/2008 By: Ken.Guo
	//$<reason> Added new properties: Font.UnderLine, Font.Italic, Font.Weight.
	//UnderLine
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_field_underline" ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.UnderLine = '" + 	ids_screen_fields.GetItemString( i, "data_view_fields_label_underline" ) + "'" )	

	//Italic
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.Italic = '" + 	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_field_font_italic" ) ) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.Italic = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_italic" ) ) + "'" )	

	//Weight
	adw_detail.Modify( ls_dw_field_names[i] + ".Font.weight = '" +		String(ids_screen_fields.GetItemNumber( i, "data_view_fields_font_wieght" )) + "'" )	
	adw_detail.Modify( ls_dw_field_names[i] + "_t.Font.weight = '" +	String(ids_screen_fields.GetItemNumber( i, "data_view_fields_label_font_weight" ) ) + "'" )	
	//---------------------------- APPEON END ----------------------------

	adw_detail.Modify( ls_dw_field_names[i] + ".Edit.FocusRectangle = True") //Start Code Change ----07.30.2014 #V14.2 maha

	IF ib_create_browse THEN
		adw_browse.Modify( ls_dw_field_names[i] + ".alignment = '" + ids_screen_fields.GetItemString( i, "justification" ) + "'" )	
		adw_browse.Modify( ls_dw_field_names[i] + "_t.alignment = '" + String( ids_screen_fields.GetItemNumber( i, "field_label_justification" ) ) + "'" )	
	END IF
	
	IF ls_dw_field_names[i] = "active_status" THEN
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
		adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
		//Start Code Change ----05.09.2013 #V14 maha
//		if is_table_name = "pd_address" then
//			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
//		else
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
//		end if
		//Start Code Change ----05.09.2013		
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")	
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '200'")
		adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----12.14.2009 #V92 maha
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.tip='Verification creation: Historical- PSV verification; Inactive- No verification; Active- PSV and expiring verification")
//		adw_detail.Modify(ls_dw_field_names[i] + ".tooltip.enabled= Yes")
		

		IF ib_create_browse THEN
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			adw_browse.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			//Start Code Change ----05.09.2013 #V14 maha
		//	if is_table_name = "pd_address" then
		//		adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_address'")
	//		else
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_code_lookup_active_inactive'")
	//		end if
			//Start Code Change ----05.09.2013		
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")								
		END IF
	END IF

	IF ids_screen_fields.GetItemString( i, "lookup_field") = "Y" AND NOT ab_screen_painter THEN
		ls_lookup_code = ids_screen_fields.GetItemString( i, "lookup_code" )
		ls_lookup_field = ids_screen_fields.GetItemString( i, "lookup_field_name" )
		ls_lookup_type = ids_screen_fields.GetItemString( i, "lookup_type" )
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = Yes")			
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
		//Start Code Change ---- 03.08.2006 #317 maha readded
		adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
		//End Code Change---03.08.2006
		
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")
			adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".background.color = '" + ls_yellow +  "'")//Start Code Change ----12.14.2009 #V10 maha
		END IF	
		IF ls_lookup_type = "C" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_code_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")	
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-07-12 By: Scofield
				//$<Reason> Change 'description' to ls_lookup_field
				
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")//for a Web version issue - alfee 09.07.2011
				IF ib_create_browse = True THEN				
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'description'")
					//adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = '"+Lower(ls_lookup_field)+"'")	//for a Web version issue - alfee 09.07.2011
				END IF
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "A" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")		

			IF ib_create_browse = True THEN				
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_address_lookup'")						
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'lookup_code'")			
			END IF
			
			IF Upper( ls_lookup_field ) = "CODE" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'code'")
				END IF
			ELSE			
				adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")			
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'entity_name'")						
				END IF
				
				//---------------------------- APPEON END ----------------------------
			END IF
		ELSEIF ls_lookup_type = "Q" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")	
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'short_quest'")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.useasborder = No")
			adw_detail.Modify( ls_dw_field_names[i] + ".dddw.vscrollbar = Yes")
			IF ib_create_browse = True THEN
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.name = 'd_dddw_quest_lookup'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.datacolumn = 'quest_id'")
				adw_browse.Modify( ls_dw_field_names[i] + ".dddw.displaycolumn = 'full_quest'")						
			END IF
		END IF
	
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AllowEdit = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VScrollBar = Yes")
		//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HScrollBar = Yes")
		adw_detail.Modify( ls_dw_field_names[i] + ".dddw.PercentWidth = '" + ls_dddw_width[i] + "'")
		adw_detail.GetChild( ls_dw_field_names[i] , dwchild )

		//IF ib_create_browse = True THEN						
			adw_browse.GetChild( ls_dw_field_names[i] , dwchild_browse )
			dwchild.SetTransObject( SQLCA )
		//END IF

		of_dwchild_retrieve(ls_lookup_code,ls_lookup_type,adw_detail,"CREATE",0,ls_dw_field_names[i]) //maha app081705
		dwchild.ShareData( dwchild_browse )
//End Code Change---12.15.2005
	ELSEIF ls_dw_field_names[i] <> "active_status" THEN
		adw_detail.Modify(ls_dw_field_names[i] + ".Edit.NilIsNull= Yes")
		IF ids_screen_fields.GetItemString(i, "required") = "Y" THEN
			adw_detail.Modify(ls_dw_field_names[i] + "_t.font.underline = '1'")			
			adw_detail.Modify(ls_dw_field_names[i] + ".Edit.Required = Yes")
			adw_detail.Modify(ls_dw_field_names[i] + ".Background.Color = '" + ls_yellow + "'")  //Start Code Change ----11.19.2009 #V92 maha
					//	yellow 65535
		 
		END IF	
		IF ls_mask[i] <> "" THEN
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.CodeTable = Yes")
			adw_detail.Modify( ls_dw_field_names[i] + ".Edit.ValidateCode = Yes" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='" + ls_mask[i] + "'")
			IF ls_mask[i] = "##" THEN
				FOR m = 1 TO 12
					ls_month = String(m)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
					adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Month, Select a number from 1 and 12.'" )//maha moved 092605
				END FOR
				m1 = 0
				FOR m = 13 TO 21
					m1++
					ls_month = "0" + String(m1)
					adw_detail.SetValue( ls_dw_field_names[i], m, ls_month + "~t" + ls_month )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '2'" )			
				
			ELSEIF ls_mask[i] = "(###)###-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='(###)###-####'" )	//Comment by Scofield on 2008-08-12
			ELSEIF ls_mask[i] = "###-##-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='###-##-####'")		
			ELSEIF ls_mask[i] = "#####-####" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask='#####-####'" )	
			elseif ls_mask[i] = "INTPHONE" THEN //Start Code Change ----02.02.2009 #V92 maha - added for dclick format phone function
				//do nothing for int phone
			ELSEIF ls_mask[i] = "####" THEN
				li_index = 0
				FOR m = 1880 TO 2050
					li_index++
					adw_detail.SetValue( ls_dw_field_names[i], li_index, String(m) + "~t" + String(m) )
				END FOR
				adw_detail.Modify( ls_dw_field_names[i] + ".Edit.Limit = '4'" )			
				adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Year, Select a number between 1880 and 2050.'" )
			ELSEIF ls_mask[i] = "mm/dd/yyyy" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".EditMask.Mask ='mm/dd/yyyy'")
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
			//	adw_detail.Modify( ls_dw_field_names[i] + ".ValidationMsg = 'Invalid Date, Please reenter.'" ) //maha 092605
				IF ib_create_browse = True THEN				
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='mm/dd/yyyy'")
				END IF
			ELSEIF ls_mask[i] = "#,##0.00" THEN
				adw_detail.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				IF ib_create_browse = True THEN								
					adw_browse.Modify( ls_dw_field_names[i] + ".Format='#,##0'")
				END IF
			END IF
		END IF	
	END IF
END FOR

gnv_appeondb.of_commitqueue()
If appeongetclienttype() <> 'PB' Then of_dwchild_after_retrieve(adw_detail)

//reset all browse fields //maha 051005
integer cc
cc = upperbound( ls_dw_field_names)//integer(adw_browse.Object.DataWindow.Column.Count)
wer = ids_screen_fields.rowcount()
if  ib_create_browse = True then
	for i = 1 to li_row_cnt//ids_screen_fields.rowcount()
		adw_browse.Modify( ls_field_names[i] + ".TabSequence = '0'" )
	next
end if

FOR i = 1 TO li_key_cnt
	adw_detail.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
	adw_detail.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	IF ib_create_browse = True THEN					
		adw_browse.Modify( ls_key_fields_col_nm[i] + ".visible = '0'")
		adw_browse.Modify( ls_key_fields_col_nm[i] + "_t.visible = '0'")
	END IF
END FOR

//IF NOT ab_screen_painter THEN
//	adw_detail.iuo_calendar.of_Register(adw_detail.iuo_calendar.DDLB)		
//	adw_detail.of_SetReqColumn(TRUE)
//END IF

//Start Code Change ----11.10.2016 #V153 maha - resort if using lookups for sort
if  upperbound(ls_sort_add_field) > 0 then
	ls_sort_name = ""
	//set display values
	for s = 1 to upperbound(ls_sort_add_field)
		of_sort_evaluate( adw_detail, ls_sort_add_field[s] )
	next
	//reset sort
	for s = 1 to  upperbound(ls_sort_field)
		ls_sort_name += ls_sort_field[s] + " ASC,"	 			
	next
	ls_sort_name = mid(ls_sort_name, 1, len(ls_sort_name) - 1)
	res = adw_detail.setsort(ls_sort_name)
	adw_detail.sort()
end if
//Start Code Change ----11.10.2016

adw_detail.SetRedraw(True)

//CREATE ANY SCREEN OBJECTS THAT WERE ADDED
FOR i = 1 TO li_obj_cnt
	if ids_screen_objects.GetItemnumber(i, "object_underline") = 1 then //maha 082305 for use in modify below for underline
		li_uls = 1
	else 
		li_uls = 0
	end if
	ls_obj_type = ids_screen_objects.GetItemString(i, "object_type") 
	ls_obj_name = "object"+String( ids_screen_objects.GetItemNumber(i, "data_view_object_id") )
	ls_width = String( ids_screen_objects.GetItemNumber(i, "object_width") )
	ls_height = String( ids_screen_objects.GetItemNumber(i, "object_height") )
	ls_x = String( ids_screen_objects.GetItemNumber(i, "object_x") )
	ls_y = String( ids_screen_objects.GetItemNumber(i, "object_y") )
	ls_text = ids_screen_objects.GetItemString(i, "object_text") 
	ls_justification = String( ids_screen_objects.GetItemNumber(i, "object_alignment") )
	if long(ls_y) + long(ls_height) > ll_max_height then ll_max_height = long(ls_y) + long(ls_height)  //maha 051205
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-31 By: Liu HongXin
	//$<reason> Fix defect: display the bold and italic of stand-alone text
	ls_Bold		= String(ids_screen_objects.GetItemNumber(i, "object_bold") )
	ls_italic	= String(ids_screen_objects.GetItemNumber(i, "object_italic") )
	if IsNull(ls_Bold) then ls_Bold = "400"
	if IsNull(ls_italic) then ls_italic = "0"
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ls_obj_type
		CASE "B"
			adw_detail.Modify("create groupbox(band=detail text='" + ls_text + "' border='5' color='8388608' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' name=" + ls_obj_name + ")" )  //Start Code Change ----01.25.2016 #V15 maha - changed font color to Navy
		CASE "T"  //maha 051809 ######
			if ab_screen_painter then
				ls_color = "128"
			else
				ls_color = "0"
			end if
			adw_detail.Modify("create text(band=detail text='" + ls_text + "' border='0' color='" + ls_color + "' x='" + ls_x + "' y='" + ls_y + "' height='" + ls_height + "' width='" + ls_width + "'  font.face='Segoe UI' font.height='-8' font.family='2' font.pitch='2' font.underline='" + string(li_uls) + "' font.weight='" + ls_bold + "' font.italic='" + ls_italic + "' font.charset='0' background.mode='1' background.color='553648127' Alignment='"+ls_justification+"' name=" + ls_obj_name + ")" )
	END CHOOSE
END FOR

//------------------- APPEON BEGIN ------------------
//$<modify>long.zhang 11.14.2014
//$<reason> Move to pfc_cst_nv_data_entry.of_modify_dw_access //restored by Appeon long.zhang 02.02.2015 (address screen error)
//Start Code Change ---- 01.18.2006 #203 maha
//---------Begin Modified by (Appeon)Stephen 11.19.2013 for  Bug 3755: Billing Address Link field displays a number when set as read-only--------
//IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and li_access = 2 THEN //alfee 06.01.2009
boolean lb_bo =false
for i = 1 to upperbound(ls_dw_field_names) 
	if ls_dw_field_names[i] = "billing_address_id" then
		lb_bo = true
		exit
	end if
next
		
IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and (li_access = 2 or li_access = 1) and lb_bo THEN //alfee 06.01.2009
//---------End Modfiied ------------------------------------------------------
	//add drop down for billing address
	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
	adw_detail.Modify( "billing_address_id.dddw.Required = No")
	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
	res  = adw_detail.GetChild( "billing_address_id", dwchild )
	if res = 1 then
		IF LenA( ls_retval ) = 0 THEN
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( al_prac_id )
		END IF

		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
	end if
	
END IF
//------------------- APPEON END -------------------

IF li_prac_row_cnt = 0 THEN 
	If not ab_screen_painter Then of_set_defaults( adw_detail, 1 )
	adw_detail.SetItemStatus( 1, 0, Primary!, NotModified! )
END IF

IF ab_screen_painter THEN //maha 051305 ####
	adw_detail.Object.DataWindow.Detail.Height= 20000
else
	choose case ai_screen_id  
		case  - 20
			ll_max_height = 1480
		case else
			ll_max_height = ll_max_height + 20 
	end choose
	adw_detail.Object.DataWindow.Detail.Height= ll_max_height
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<add> 03.13.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//<modification> Save the datawindow syntax in the SDR files on local machine.
if AppeonGetClientType() <> "PB" then // Evan 02.10.2009
	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_detail,'Y',string(idt_screen_cache),'D',ab_screen_painter)
	of_save_create_syntax(ai_data_view_id,ai_screen_id,adw_browse,'N',string(idt_screen_cache),'D',ab_screen_painter)
end if
//---------------------------- APPEON END ----------------------------
if ab_screen_painter = true then adw_detail.hscrollbar = true

RETURN ls_return_syntax

end function

public function integer of_set_exp_appt_inactive (long al_prac, long al_parent);//Start Code Change ----08.30.2017 #V154 maha - added to clear still active exp appt verif - called from apptmnt screen and return from committee.

datetime ld_now
string ls_mod
integer r

ld_now = datetime(today(),now())
ls_mod = gs_user_id + "-sys"

//select count(rec_id) into :r from verif_info where prac_id = :al_prac and facility_id = :al_parent and active_status = 1 and screen_id = 1 and verification_method = 10015;
//messagebox("",r)
update verif_info set active_status = 0, mod_user = :ls_mod, mod_date = :ld_now where prac_id = :al_prac and facility_id = :al_parent and active_status = 1 and screen_id = 1 and verification_method = 10023;
//commit using sqlca;

return 1
end function

on pfc_cst_nv_data_entry_functions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nv_data_entry_functions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.26.2007 By: Evan
//$<reason> New feature of import module.
if IsValid(ids_address_lookup) then Destroy ids_address_lookup
//---------------------------- APPEON END ----------------------------

if IsValid(ids_application) then destroy ids_application //(Appeon)Stephen 06.15.2016 - V15.2-Application Tracking full Auditing
end event

