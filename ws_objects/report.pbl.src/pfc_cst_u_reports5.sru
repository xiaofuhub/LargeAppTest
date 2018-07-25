$PBExportHeader$pfc_cst_u_reports5.sru
forward
global type pfc_cst_u_reports5 from nonvisualobject
end type
end forward

type istr_intellireport from structure
	string		s_column_name[]
	string		s_label_name[]
	integer		i_return
end type

global type pfc_cst_u_reports5 from nonvisualobject
end type
global pfc_cst_u_reports5 pfc_cst_u_reports5

type variables
DataStore ids_column_data
DataStore ids_sort_data
DataStore ids_table_data
DataStore ids_link_data
DataStore ids_filter_data
DataStore ids_header_data

String is_sql_where

Integer ii_facil_security
Integer ii_dept_security_on
Integer ii_view_id
Integer ii_col_count


String is_column_name[]
String is_label_name[]



end variables

forward prototypes
public function integer of_quick_ver (long al_prac_id, w_report aw_report_win)
public function integer of_custom_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id)
public function integer of_peer_review_profile (long al_prac_id, integer ai_facility_id)
public function integer of_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile)
public function string of_intellireport_build_sql ()
public function integer of_intellireport_preview (integer ai_view_id, ref datawindow adw_preview, boolean ib_preview, boolean ib_new, integer ii_with_data, string is_facility_name, string is_filter, string is_sort_synt, boolean ib_group_report, string is_report_type, integer ai_facil_security, integer ai_dept_security_on)
end prototypes

public function integer of_quick_ver (long al_prac_id, w_report aw_report_win);n_ds lds_qv_data
n_ds lds_qv_rpt
long li_row_cnt
long i
long li_nr
long li_current_cred_cnt
long li_max
Long ll_last_prac_id
Long ll_prac_id
String ls_credential
String ls_last_credential
String ls_rpt_fld_nm
String ls_ref_val
String ls_display
String ls_retval

lds_qv_data = CREATE	n_ds
lds_qv_data.DataObject = "d_rpt_quick_verification_data"
lds_qv_data.SetTransObject( SQLCA )
li_row_cnt = lds_qv_data.Retrieve( al_prac_id )
//messagebox("li_row_cnt",li_row_cnt)

lds_qv_rpt = CREATE	n_ds
lds_qv_rpt.DataObject = "d_rpt_quick_verification"
lds_qv_rpt.SetTransObject( SQLCA )

lds_qv_rpt.ShareData( aw_report_win.tab_rpt.tabpage_report.dw_report )

ll_last_prac_id = 0
ls_last_credential = ""
FOR i = 1 TO li_row_cnt
	ll_prac_id = lds_qv_data.GetItemNumber( i, "prac_id" )
	IF ll_prac_id <> ll_last_prac_id THEN
		ll_last_prac_id = ll_prac_id
		li_nr = lds_qv_rpt.InsertRow(0)
		lds_qv_rpt.SetItem( li_nr, "name", lds_qv_data.GetItemString( i, "full_name" ) )
	END IF
	ls_credential = lds_qv_data.GetItemString( i, "screen_name" )
	ls_ref_val = lds_qv_data.GetItemString( i, "reference_value" )
	IF ls_credential <> ls_last_credential THEN
		ls_last_credential = ls_credential
		li_current_cred_cnt = 1
	ELSE
		li_current_cred_cnt ++
	END IF
	CHOOSE CASE Upper(ls_credential)
		CASE "LICENSURE"
			ls_rpt_fld_nm = "lic_"
		CASE "DEA REGISTRATION"
			IF PosA(ls_ref_val , "US -") > 0 THEN
				ls_rpt_fld_nm = "dea_"
			ELSE
				ls_rpt_fld_nm = "state_csr_"
			END IF
		CASE "EDUCATION"
			ls_rpt_fld_nm = "educ_"
		CASE "TRAINING"
			ls_rpt_fld_nm = "train_"
		CASE "HOSPITAL AFFILIATION"
			ls_rpt_fld_nm = "hosp_"
		CASE "PROFFESIONAL EXPERIENCE"
			ls_rpt_fld_nm = "work_hist_"
		CASE "REFERENCES"
			ls_rpt_fld_nm = "ref_"
		CASE "INSURANCE"
			ls_rpt_fld_nm = "ins_"
		CASE "BOARD/SPECIALTY"
			ls_rpt_fld_nm = "board_"
		CASE "ECFMG"
			ls_rpt_fld_nm = "ecfmg_"
	END CHOOSE
	IF IsNull( lds_qv_data.GetItemNumber( i, "response_code" ) ) THEN
		ls_display = String(lds_qv_data.GetItemNumber( i, "number_sent" ) ) 	
	ELSE
		ls_display = "*"
	END IF
	ls_retval = lds_qv_rpt.Describe( ls_rpt_fld_nm + String( li_current_cred_cnt) + ".x" )
	IF ls_retval <> "!" THEN
		//messagebox("", ls_rpt_fld_nm + String( li_current_cred_cnt) )
		lds_qv_rpt.SetItem( li_nr, ls_rpt_fld_nm + String( li_current_cred_cnt), ls_display )
	END IF
END FOR

//messagebox("", lds_qv_rpt.rowcount())


Return 0


end function

public function integer of_custom_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id);String ls_report_dw
String ls_retval
Integer i
Integer li_row_cnt
Integer li_screen_id



n_ds lds_profile_view
string ls_facility_name
pfc_cst_nv_data_entry_functions nv_de_func


nv_de_func = CREATE pfc_cst_nv_data_entry_functions

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_pfc_selected_custom_profile_reports"
lds_profile_view.of_SetTransObject( SQLCA )

FOR i = 1 TO 40
	adw_report.Modify("rpt_" + String( i ) + ".Visible='0'")
END FOR

li_row_cnt = lds_profile_view.Retrieve( ai_profile_view_id )

FOR i = 1 TO li_row_cnt
	
	li_screen_id = lds_profile_view.GetItemNumber( i, "screen_id" )
//	nv_de_func.of_create_dynamic_profile_dw( al_prac_id, ai_profile_view_id, li_screen_id, dw_detail, dw_browse, True, ai_facility_id )	
	
	ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	IF ls_report_dw = "d_prf_" THEN
		Continue
	END IF
	adw_report.Modify("rpt_" + String( i ) + ".Visible='1'")
	adw_report.Modify("rpt_" + String( i ) + ".DataObject='" + ls_report_dw + "' ")
	IF lds_profile_view.GetItemString( i , "retrieval_arguments" ) = "P" THEN
		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")	
	ELSE
		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")			
	END IF
END FOR

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" )
//\maha
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )


Return 0
end function

public function integer of_peer_review_profile (long al_prac_id, integer ai_facility_id);String ls_full_name
Long ll_dept_code
Long ll_grade
Long ll_prac_cnt_for_dept
Long ll_count_of_grade_for_dept
Long ll_hosp_wide_prac_cnt
Long ll_hosp_wide_grade_cnt
Decimal li_count_for_grade
Integer li_grades_cnt
Integer li_dept_cnt
Integer g
n_ds lds_peer
n_ds lds_grades

lds_peer = CREATE n_ds;
lds_peer.DataObject = "d_case_peer_profile"
lds_peer.SetTransObject( SQLCA )
lds_peer.Retrieve( )

li_grades_cnt = lds_peer.RowCount( )

debugbreak()

SELECT Count( pd_affil_dept.department )
INTO :li_dept_cnt
FROM pd_affil_dept  
WHERE ( pd_affil_dept.prac_id = :al_prac_id ) AND  
      ( pd_affil_dept.active_status = 1 ) AND  
      ( pd_affil_dept.facility_id = :ai_facility_id );
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
	Return -1
END IF

IF li_dept_cnt = 0 THEN
	MessageBox("Department", "You must setup a department for this practitioner to use the Peer Review Profile." )
	Return -1
ELSEIF li_dept_cnt = 1 THEN
	SELECT pd_affil_dept.department  
	INTO :ll_dept_code  
	FROM pd_affil_dept  
	WHERE ( pd_affil_dept.prac_id = :al_prac_id ) AND  
      ( pd_affil_dept.active_status = 1 ) AND  		
      ( pd_affil_dept.facility_id = :ai_facility_id );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
		Return -1
	END IF
ELSE
	SELECT Count( pd_affil_dept.department )
	INTO :li_dept_cnt
	FROM pd_affil_dept  
	WHERE ( pd_affil_dept.prac_id = :al_prac_id ) AND  
   	   ( pd_affil_dept.active_status = 1 ) AND  
	      ( pd_affil_dept.primary_dept = 1 ) AND  			
      	( pd_affil_dept.facility_id = :ai_facility_id );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	IF li_dept_cnt > 1 THEN
		MessageBox("Department", "This practitioner has more than 1 department.  You must select one as the primary department." )
		Return -1
	END IF
		
	SELECT pd_affil_dept.department  
	INTO :ll_dept_code  
	FROM pd_affil_dept  
	WHERE ( pd_affil_dept.prac_id = :al_prac_id ) AND  
      ( pd_affil_dept.active_status = 1 ) AND  	
      ( pd_affil_dept.primary_dept = 1 ) AND  					
      ( pd_affil_dept.facility_id = :ai_facility_id );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
		Return -1
	END IF	
END IF


FOR g = 1 TO li_grades_cnt
	ll_grade = lds_peer.GetItemNumber( g, "lookup_code" )
	SELECT Count( severity_grade )
	INTO :li_count_for_grade
	FROM pd_peer_review_pracs
	WHERE prac_id = :al_prac_id AND
			severity_grade = :ll_grade AND
			active_status = 1;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 2", SQLCA.SQLERRTEXT )
		Return -1
	END IF				

	lds_peer.SetItem( g, "prac_count", li_count_for_grade )

	SELECT Count( prac_id )  
   INTO :ll_prac_cnt_for_dept  
   FROM pd_affil_dept  
   WHERE ( pd_affil_dept.department = :ll_dept_code ) AND  
         ( pd_affil_dept.active_status = 1 ) AND
			( pd_affil_dept.facility_id = :ai_facility_id );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 3", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	
	SELECT Count( pd_peer_review_pracs.prac_id)  
   INTO :ll_count_of_grade_for_dept
   FROM pd_affil_dept,   
        pd_peer_review_pracs,   
        pd_peer_review  
   WHERE ( pd_affil_dept.prac_id = pd_peer_review_pracs.prac_id ) AND
         ( pd_peer_review_pracs.case_number = pd_peer_review.case_number ) AND
         ( pd_peer_review.facility_id = pd_affil_dept.facility_id ) AND  			
         ( pd_affil_dept.facility_id = :ai_facility_id ) AND  			
         ( pd_peer_review_pracs.severity_grade = :ll_grade ) AND  
         ( pd_affil_dept.department = :ll_dept_code ) AND
         ( pd_peer_review_pracs.active_status = 1 ) AND  
         ( pd_affil_dept.active_status = 1 );	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 4", SQLCA.SQLERRTEXT )
		Return -1
	END IF				
	
debugbreak()	
	IF ll_prac_cnt_for_dept = 0  THEN
		li_count_for_grade = 0
	ELSE
		li_count_for_grade = ll_count_of_grade_for_dept/ll_prac_cnt_for_dept
	END IF
	
	lds_peer.SetItem( g, "department_count", li_count_for_grade )	
	
	
	SELECT Count( pd_basic.prac_id )  
   INTO :ll_hosp_wide_prac_cnt  
   FROM pd_affil_stat,   
        pd_basic  
   WHERE ( pd_affil_stat.prac_id = pd_basic.prac_id ) AND
         ( pd_affil_stat.parent_facility_id = :ai_facility_id ) AND  
         ( pd_affil_stat.active_status = 1 )   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 5", SQLCA.SQLERRTEXT )
		Return -1
	END IF				

	SELECT Count( pd_basic.prac_id )  
   INTO :ll_hosp_wide_grade_cnt  
   FROM pd_affil_stat,   
        pd_basic,   
        pd_peer_review_pracs  
   WHERE ( pd_affil_stat.prac_id = pd_basic.prac_id ) AND
         ( pd_basic.prac_id = pd_peer_review_pracs.prac_id ) AND
         ( pd_affil_stat.parent_facility_id = :ai_facility_id ) AND  
         ( pd_affil_stat.active_status = 1 ) AND  
         ( pd_peer_review_pracs.active_status = 1 ) AND  
         ( pd_peer_review_pracs.severity_grade = :ll_grade );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL Error 6", SQLCA.SQLERRTEXT )
		Return -1
	END IF				


	IF ll_hosp_wide_prac_cnt = 0 THEN
		li_count_for_grade = 0
	ELSE
		li_count_for_grade = ll_hosp_wide_grade_cnt/ll_hosp_wide_prac_cnt
	END IF
	
	lds_peer.SetItem( g, "hospital_count", li_count_for_grade )	

	
END FOR

SELECT v_full_name.full_name  
INTO :ls_full_name  
FROM v_full_name  
WHERE v_full_name.prac_id = :al_prac_id   ;

lds_peer.Modify( "full_name.Text = " + ls_full_name )


lds_peer.Print( )

Return 1
end function

public function integer of_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile);String ls_report_dw
String ls_retval
Integer i
Integer li_row_cnt
n_ds lds_profile_view
string ls_facility_name
Long ll_dept_code  

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_pfc_selected_reports"
lds_profile_view.of_SetTransObject( SQLCA )

FOR i = 1 TO 40
	adw_report.Modify("rpt_" + String( i ) + ".Visible='0'")
END FOR

li_row_cnt = lds_profile_view.Retrieve( ai_profile_view_id )

FOR i = 1 TO li_row_cnt
	ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	IF ls_report_dw = "d_prf_" THEN
		Continue
	END IF
	adw_report.Modify("rpt_" + String( i ) + ".Visible='1'")
	adw_report.Modify("rpt_" + String( i ) + ".DataObject='" + ls_report_dw + "' ")
	IF lds_profile_view.GetItemString( i , "retrieval_arguments" ) = "P" THEN
		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")	
	ELSE
		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")			
	END IF
END FOR

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" )
//\maha
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )
debugbreak()
IF ai_print_peer_review_profile  THEN
	of_peer_review_profile ( al_prac_id, ai_facility_id )
END IF
//	i++
//	adw_report.Modify("rpt_" + String( i ) + ".Visible='1'")
//	adw_report.Modify("rpt_" + String( i ) + ".DataObject='d_case_peer_profile' ")
//	IF lds_profile_view.GetItemString( i , "retrieval_arguments" ) = "P" THEN
//		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")	
//	ELSE
//		adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")			
//	END IF
//
//	SELECT pd_affil_dept.department  
//   INTO :ll_dept_code  
//   FROM pd_affil_dept  
//   WHERE ( pd_affil_dept.prac_id = :al_prac_id ) AND  
//         ( pd_affil_dept.primary_dept = 1 ) AND  
//         ( pd_affil_dept.facility_id = :ai_facility_id );
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
//		Return -1
//	END IF

	
	
//END IF


Return 0
end function

public function string of_intellireport_build_sql ();Integer i
Integer li_add_rec_fld  
Integer li_distinct_sql
Integer li_rc
Integer li_remove_len = 5
String ls_sql
String ls_sort_synt
String ls_table_name
String ls_tname
String ls_table_field
string ls_dir //maha 111802
string ls_sort //maha 111802
Boolean 	lb_multi_table
integer p
//DataStore lds_column_data
//DataStore lds_sort_data
//DataStore lds_table_data
//DataStore lds_link_data
//DataStore lds_filter_data
//
//lds_column_data = CREATE datastore;
//lds_column_data.DataObject = "d_view_selected_fields"
//lds_column_data.SetTransObject( SQLCA )
//lds_column_data.Retrieve( il_view_id )
//
//lds_filter_data = CREATE datastore;
//lds_filter_data.DataObject = "d_view_where"
//lds_filter_data.SetTransObject( SQLCA )
//lds_filter_data.Retrieve( il_view_id )
//
//lds_table_data = CREATE datastore;
//lds_table_data.DataObject = "d_conv_view_tables_report"
//lds_table_data.SetTransObject( SQLCA )
//lds_table_data.Retrieve( il_view_id )
//
//lds_link_data = CREATE datastore;
//lds_link_data.DataObject = "d_conv_view_links"
//lds_link_data.SetTransObject( SQLCA )
//lds_link_data.Retrieve( il_view_id )
//
//lds_sort_data = CREATE datastore;
//lds_sort_data.DataObject = "dw_view_sort"
//lds_sort_data.SetTransObject( SQLCA )
//ids_sort_data.Retrieve( ii_view_id )


lb_multi_table = False
//ls_sort_synt = ""
//of_save()

SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;

IF li_distinct_sql  = 1 THEN
	ls_sql = "SELECT DISTINCT"  + "~n"
ELSE
	ls_sql = "SELECT "  + "~n"
END IF

//build the select field 
li_rc = ids_column_data.RowCount()
//debugbreak()
FOR i = 1 TO li_rc
	ls_table_name =  ids_column_data.GetItemString( i, "table_name" )
	IF PosA( ids_column_data.GetItemString( i, "compute_name" ), "=" ) > 0 THEN //trap for computed fields
		ls_table_field = ids_column_data.GetItemString( i, "table_field" )
		ls_table_field = MidA( ls_table_field, PosA( ls_table_field, "=" ) + 1 , 1000 )
		ls_sql = ls_sql + "~t" + ids_column_data.GetItemString( i, "field_alias" ) + " = " + ls_table_field + ",  " + "~n"
		//ls_sql = ls_sql + "~t" + ids_column_data.GetItemString( i, "field_alias" ) + " = " + ls_table_name + "." + ls_table_field + ",  " + "~n"			
	ELSE
		ls_sql = ls_sql + "~t" + ids_column_data.GetItemString( i, "field_alias" ) + " = " + ls_table_name + "." + ids_column_data.GetItemString( i, "table_field" ) + ",  " + "~n"	
	END IF
END FOR


ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 4 ) + "~n"

SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;

IF li_add_rec_fld  = 1 THEN
	ls_sql = ls_sql + "~t, rec_id = 100000000~n"
END IF


//build from clause
ls_sql = ls_sql + "FROM " + "~n"
li_rc = ids_table_data.RowCount()

FOR i = 1 TO li_rc
	ls_sql = ls_sql + "~t" + "" + ids_table_data.GetItemString( i, "table_name" ) + ", "  + "~n"
END FOR

if ii_facil_security = 1 then
	ls_sql = ls_sql + "~t" + "security_user_facilities" + ", " + "~n"
end if

IF ii_dept_security_on = 1 then
	ls_sql = ls_sql + "~t" + "security_user_department" + "  " + "~n"		
END IF

ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 3 ) + "~n"

//build where clause for joins
li_rc = ids_link_data.RowCount()

IF li_rc > 0 THEN
	ls_sql = ls_sql + "WHERE " + "~n"	
	FOR i = 1 TO li_rc
		lb_multi_table = True
		ls_sql = ls_sql + "~t" + "(" + ids_link_data.GetItemString( i, "from_table_field" ) 
		ls_sql = ls_sql + " " + ids_link_data.GetItemString( i, "link_type" ) + " "
		ls_sql = ls_sql + ids_link_data.GetItemString( i, "to_table_field" ) 	+ ") AND ~n"
	END FOR

	ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 5 ) 
END IF

//build where filter
li_rc = ids_filter_data.RowCount()
IF li_rc > 0 THEN
	IF lb_multi_table = True THEN
		ls_sql = ls_sql + " AND ~n"
	ELSE
		ls_sql = ls_sql + " WHERE " + "~n"	
	END IF
	FOR i = 1 TO li_rc
		ls_tname = ids_filter_data.GetItemString( i, "table_field_name" )
		
		if PosA(ls_tname,"v_",1) > PosA(ls_tname,".",1) then //would designate a computed field //maha 020304
			ls_sql = ls_sql + "~t" + "(" + MidA(ls_tname,1,PosA(ls_tname,".",1) - 1) //get computed field name
		else //all other fields
			ls_sql = ls_sql + "~t" + "(" + ls_tname 
		end if
		ls_sql = ls_sql + " " + ids_filter_data.GetItemString( i, "operator" ) + " "
		IF ids_filter_data.GetItemString( i, "operator" ) = "In" THEN
			ls_sql = ls_sql + "(" + ids_filter_data.GetItemString( i, "value" ) + ")"
		else
			ls_sql = ls_sql + ids_filter_data.GetItemString( i, "value" )
		END IF	
			//li_remove_len = 6
		
		ls_sql = ls_sql +  ") AND ~n"	
	END FOR
	ls_sql = LeftA( ls_sql, LenA( ls_sql ) - 5 ) + "~n"	
END IF

//bring in wizard SQL
IF LenA( is_sql_where ) > 0 THEN 
	ls_sql = ls_sql + is_sql_where
END IF

//build order by clause
li_rc = ids_sort_data.RowCount()
IF li_rc > 0 THEN
	
	IF RightA( ls_sql, 5 ) = " AND " THEN
		ls_sql = MidA( ls_sql, 1, LenA( ls_sql ) -5 )
	END IF
	
	ls_sql = ls_sql + "ORDER BY " + "~n"
	FOR i = 1 TO li_rc	
		//ls_sort_synt maha modified 012704 to put sort fields into variable to be used after end of group by
//		ls_sql = ls_sql + "~t" + ids_sort_data.GetItemString( i, "table_name" ) + "."
		ls_sql = ls_sql + ids_sort_data.GetItemString( i, "field_name" ) + " "
		ls_sort_synt = ls_sort_synt + ids_sort_data.GetItemString( i, "field_name" ) + " " //which is really the field alias maha 012704
		//ls_sql = ls_sql + ids_sort_data.GetItemString( i, "field_alias" ) + " "
		
		ls_dir = ids_sort_data.GetItemString( i, "sort_dir" )
		if ls_dir = "D" then
			ls_sort = "DESC"
		else
			ls_dir = "A"
			ls_sort = "ASC"
		end if
		ls_sql = ls_sql + ls_sort + ","
		ls_sort_synt = ls_sort_synt + ls_dir + ","
	END FOR
	ls_sql = LeftA(ls_sql, LenA( ls_sql ) - 1 ) + "~n"	//get rid of extra comma
	ls_sort_synt = LeftA( ls_sort_synt, LenA( ls_sort_synt ) - 1 ) + "~n"	//get rid of extra comma
	//ls_sql = ls_sql + ls_sort_synt
	
END IF
IF RightA( is_sql_where, 5 ) = " AND " THEN
	ls_sql = MidA( ls_sql, 1, LenA( ls_sql ) -5 )
END IF

//tab_1.tabpage_run.st_sql.Text = ls_sql
//ClipBoard( ls_sql )
//tab_1.tabpage_run.st_sql.Visible = True



Return ls_sql



end function

public function integer of_intellireport_preview (integer ai_view_id, ref datawindow adw_preview, boolean ib_preview, boolean ib_new, integer ii_with_data, string is_facility_name, string is_filter, string is_sort_synt, boolean ib_group_report, string is_report_type, integer ai_facil_security, integer ai_dept_security_on);//string ls_valid
//ls_valid = dw_composite.Object.rpt_employee. Object.emp_id.Validation

//dwsyntax = dw_1.Describe("DataWindow.Syntax")
//rtncode = LibraryImport("c:\pb\dwTemp.pbl", &
//"d_emp", ImportDataWindow!, &
//dwsyntax, ErrorBuffer, &
//"Employee DataWindow 1")

//LibraryDelete("c:\pb\dwTemp.pbl", "d_emp", ImportDataWindow!)

//this builds the datawindow calls of_build_view_sql()
//messagebox("of_preview","")

istr_intellireport ls_ir_struct 
String ls_profile_title
String ls_header_height
String ls_detail_height
String ls_fld_y
String ls_y
String ls_return
String ls_font_style
String ls_orientation
String ls_width
String ls_retval
String ls_label
String ls_column
String ls_label_text
String ls_title
String ls_x
String ls_field_allias
String ls_table_field
String ls_group_syntax
String ls_grey
String ls_align
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String ls_sql
String Errors
String ls_font
String ls_agg_type[]
String ls_agg_fld_nm[]
String ls_aggregate
String ls_agg_fld_num[ ]
Integer li_fld_height
Integer li_label_height
Integer f
Integer li_agg_cnt[]
Integer li_agg_sum[]
Integer li_agg_avg[]
Integer li_agg_cnt_1
Integer li_agg_sum_1
Integer li_agg_avg_1
integer res
Integer li_grp_agg
Integer li_sum_agg
Integer ls_agg_fld_x[]
Integer li_rc
Integer z
Integer li_cnt
Integer li_return
Integer i
Integer li_FileNum
Integer li_aggregate_cnt
Long ll_label_width
Long ll_total_field_width
Long ll_sum_agg_y
Long ll_cnt_agg_y
Long ll_avg_agg_y
Long ll_width
Long ll_last_fld_width
Long ll_start_position
Long ll_longest_width
Long ll_fld_x
Long ll_fld_y
Long ll_label_y
Long ll_last_fld_x
Long ll_fld_id
Long ll_fld_width
String ls_agg_fld_width[ ]
String ls_db_nm
String ls_imp_file_nm
String ls_data_line
String ls_data_all
string ls_syntax
//maha 111502
//DataStore lds_column_data
//DataStore lds_sort_data
//DataStore lds_table_data
//DataStore lds_link_data
//DataStore ids_filter_data
//DataStore ids_header_data

ii_view_id = ai_view_id

ids_column_data = CREATE datastore;
ids_column_data.DataObject = "d_view_selected_fields"
ids_column_data.SetTransObject( SQLCA )
ids_column_data.Retrieve( ii_view_id )

ids_header_data = CREATE datastore;
ids_header_data.DataObject = "d_cust_report_detail"
ids_header_data.SetTransObject( SQLCA )
ids_header_data.Retrieve( ii_view_id )

ids_filter_data = CREATE datastore;
ids_filter_data.DataObject = "d_view_where"
ids_filter_data.SetTransObject( SQLCA )
ids_filter_data.Retrieve( ii_view_id )

ids_table_data = CREATE datastore;
ids_table_data.DataObject = "d_conv_view_tables_report"
ids_table_data.SetTransObject( SQLCA )
ids_table_data.Retrieve( ii_view_id )

ids_link_data = CREATE datastore;
ids_link_data.DataObject = "d_conv_view_links"
ids_link_data.SetTransObject( SQLCA )
ids_link_data.Retrieve( ii_view_id )

ids_sort_data = CREATE datastore;
ids_sort_data.DataObject = "dw_view_sort"
ids_sort_data.SetTransObject( SQLCA )
ids_sort_data.Retrieve( ii_view_id )



ib_group_report = False
//tab_1.tabpage_preview.st_normal.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_bold.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_italic.BorderStyle = StyleRaised!
//tab_1.tabpage_preview.st_underline.BorderStyle = StyleRaised!


is_report_type = ids_header_data.GetItemString(1, "report_type" )

IF IsNull( is_report_type ) OR is_report_type = "" THEN
	is_report_type = "List"
END IF


SetPointer( HourGlass! )

ls_sql = of_intellireport_build_sql()


adw_preview.Reset()
adw_preview.DataObject = ''

li_rc = ids_column_data.RowCount()
ii_col_count = li_rc

ls_group_syntax = "Group("
FOR i = 1 TO li_rc
	IF ids_column_data.GetItemNumber( i, "group_by_field" ) = 1 THEN
		ls_group_syntax = ls_group_syntax + String( i ) + ","
		ib_group_report = True
	END IF
END FOR
ls_group_syntax = MidA( ls_group_syntax, 1 ,LenA( ls_group_syntax )-1)
ls_group_syntax = ls_group_syntax + ")"

FOR i = 1 TO li_rc
	ls_aggregate = ids_column_data.GetItemString( i, "aggregate_type" ) 
	IF NOT IsNull( ls_aggregate ) AND ls_aggregate <> "None" THEN
		li_aggregate_cnt ++
		ls_agg_fld_nm[ li_aggregate_cnt ] = ids_column_data.GetItemString( i, "field_name" ) 
		ls_agg_fld_x[ li_aggregate_cnt ] = ids_column_data.GetItemNumber( i, "field_x" ) 		
		ls_agg_type[li_aggregate_cnt ] = ids_column_data.GetItemString( i, "aggregate_type" )
		ls_agg_fld_num[ li_aggregate_cnt ] = String( i )
		IF ids_column_data.GetItemNumber( i, "count_fld" ) > 0 THEN
			li_agg_cnt[li_aggregate_cnt] = 1
			li_agg_cnt_1 = 1
		ELSE
			li_agg_cnt[li_aggregate_cnt] = 0
		END IF
		IF ids_column_data.GetItemNumber( i, "sum_fld" ) > 0 THEN
			li_agg_sum[li_aggregate_cnt] = 1
			li_agg_sum_1 = 1
		ELSE
			li_agg_sum[li_aggregate_cnt] = 0			
		END IF		
		IF ids_column_data.GetItemNumber( i, "avg_fld" ) > 0 THEN
			li_agg_avg[li_aggregate_cnt] = 1
			li_agg_avg_1 = 1
		ELSE
			li_agg_avg[li_aggregate_cnt] = 0			
		END IF		
	END IF
END FOR

ls_grey = String(rgb(192,192,192))
ls_white = String(rgb(255,255,255))
IF is_report_type = "Profile" or is_report_type = "Form" THEN
	ls_presentation_str = "style( type=Form) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=0 Background.Color=" + ls_white + ")"	
ELSEIF ib_group_report then
	ls_presentation_str = "style( type=Group ) " + ls_group_syntax + " Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
ELSE
	ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"	
END IF

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", "SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF

adw_preview.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN -1
END IF

adw_preview.SetTransObject( SQLCA )

FOR i = 1 TO li_rc
	ls_field_allias = ids_column_data.GetItemString( i, "field_alias" ) 
	ls_label = ls_field_allias + "_t"
	ls_column = ls_field_allias
	

	ls_column = MidA( ls_column, 1, 40 )
	ls_label = MidA( ls_label, 1, 40 )
	
	ls_label_text = ids_column_data.GetItemString( i, "label_text" ) 	

	adw_preview.Modify( ls_label + ".Text='" + ls_label_text + "'")	
	
	IF is_report_type <> "Profile" AND is_report_type <> "Form" THEN
		ls_return = adw_preview.Modify( ls_label + ".y='260'")	
		adw_preview.Modify( ls_label + ".height='120'")		
		adw_preview.Modify( ls_label + ".Border='1'")		
	END IF

	is_label_name[i] = adw_preview.Describe( ls_label + ".name")			
	is_column_name[i] = adw_preview.Describe( ls_column + ".name")			
	adw_preview.Modify( ls_label + ".tag ='" + String( i ) + "'")			
	adw_preview.Modify( ls_column + ".tag ='" + String( i ) + "'")			
	
	IF ib_preview THEN
		adw_preview.Modify(ls_column + ".Border='2'")
	END IF
	
	IF IsNull( ids_column_data.GetItemString( i, "field_display_width" ) ) OR +&
		ids_column_data.GetItemString( i, "field_display_width" ) = ""  THEN		
		ll_width = Long( adw_preview.Describe( ls_column + ".width") )
		ids_column_data.SetItem( i, "field_display_width", String( ll_width ) )	
	ELSE
		ll_width = Long(ids_column_data.GetItemString( i, "field_display_width" ))
	END IF
	
	
	IF ids_column_data.GetItemNumber( i, "field_height" )  < 1 THEN	
		li_fld_height = Integer( adw_preview.Describe( ls_column + ".height") )
		ids_column_data.SetItem( i, "field_height",  li_fld_height )	
	ELSE
		li_fld_height = ids_column_data.GetItemNumber( i, "field_height" )
	END IF
	
	IF ids_column_data.GetItemNumber( i, "label_height" )  < 1 THEN	
		li_label_height = Integer( adw_preview.Describe( ls_label + ".height") )
		ids_column_data.SetItem( i, "label_height",  li_label_height )	
	ELSE
		li_label_height = ids_column_data.GetItemNumber( i, "label_height" )
	END IF

	
	IF is_report_type = "Profile" OR is_report_type = "Form" THEN
		IF IsNull( ids_column_data.GetItemString( i, "label_width" ) ) OR +&
			ids_column_data.GetItemString( i, "label_width" ) = ""  THEN		
			ll_label_width = Long( adw_preview.Describe( ls_label + ".width") )
			ids_column_data.SetItem( i, "label_width", String( ll_label_width ) )	
		ELSE
			ll_label_width = Long(ids_column_data.GetItemString( i, "label_width" ))
		END IF	
	END IF


//	IF ids_column_data.GetItemNumber( i, "field_visible" ) = 0 THEN				
//		ll_width = 0
//	END IF
	
	IF is_report_type = "Profile" OR is_report_type = "Form" THEN
		adw_preview.Modify( ls_label + ".width ='" + String( ll_label_width ) + "'")			
		adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")				
	ELSE
		adw_preview.Modify( ls_label + ".width ='" + String( ll_width ) + "'")			
		adw_preview.Modify( ls_column + ".width ='" + String( ll_width ) + "'")			
	END IF


	adw_preview.Modify( ls_label + ".height ='" + String( li_label_height ) + "'")			
	adw_preview.Modify( ls_column + ".height ='" + String( li_fld_height ) + "'")				


		IF is_report_type = "Profile" OR is_report_type = "Form" THEN

			IF IsNull( ids_column_data.GetItemNumber( i, "label_x" ) ) OR +&
				ids_column_data.GetItemNumber( i, "label_x" ) = 0  THEN
				ls_x =  adw_preview.Describe( ls_label + ".x") 
				ids_column_data.SetItem( i, "label_x", Long(ls_x)  )								
			ELSE
				ls_x = String(ids_column_data.GetItemNumber( i, "label_x" ))
				adw_preview.Modify( ls_label + ".x ='" + ls_x  + "'")					
			END IF	

			IF IsNull( ids_column_data.GetItemNumber( i, "field_x" ) ) OR +&
				ids_column_data.GetItemNumber( i, "field_x" ) = 0  THEN
				ls_x =  adw_preview.Describe( ls_column + ".x") 
				ids_column_data.SetItem( i, "field_x", Long(ls_x)  )								
			ELSE
				ls_x = String(ids_column_data.GetItemNumber( i, "field_x" ))
				adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")					
			END IF	
			
			
		ELSE
			IF IsNull( ids_column_data.GetItemNumber( i, "field_x" ) ) OR +&
				ids_column_data.GetItemNumber( i, "field_x" ) = 0  THEN
				IF NOT ib_new THEN
					ll_last_fld_x = 0
					FOR z = 1 TO li_rc
						ll_fld_x = ids_column_data.GetItemNumber( z, "field_x" ) 
						IF ll_fld_x > ll_last_fld_x THEN
							ll_last_fld_x = ll_fld_x
							ll_last_fld_width = Long( ids_column_data.GetItemString( z, "field_display_width" ) )
						END IF
					END FOR
					ls_x = String( ll_last_fld_x + ll_last_fld_width + 20 )
					ids_column_data.SetItem( i, "field_x", ll_last_fld_x + ll_last_fld_width + 20 )			
					adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
					adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")										
				ELSE	
					ls_x = adw_preview.Describe( ls_column + ".x") 
					ids_column_data.SetItem( i, "field_x", Long(ls_x)  )
				END IF
			ELSE
				ls_x = String(ids_column_data.GetItemNumber( i, "field_x" ))
				adw_preview.Modify( ls_label + ".x ='"  + ls_x  + "'")			
				adw_preview.Modify( ls_column + ".x ='" + ls_x  + "'")					
				ids_column_data.SetItem( i, "field_x", Long(ls_x)  )								
			END IF	
			
		END IF


		
		
		//y coord
		IF IsNull( ids_column_data.GetItemNumber( i, "field_y" ) ) OR +&
			ids_column_data.GetItemNumber( i, "field_y" ) = 0  THEN
				ls_fld_y = adw_preview.Describe( ls_column + ".y") 
				ids_column_data.SetItem( i, "field_y", Long(ls_fld_y)  )
				
				ls_y = adw_preview.Describe( ls_label + ".y") 
				ids_column_data.SetItem( i, "label_y", Long(ls_y)  )
				
		ELSE
			ls_fld_y = String(ids_column_data.GetItemNumber( i, "field_y" ))
			adw_preview.Modify( ls_column + ".y ='" + ls_fld_y  + "'")					

			
			ls_y = String(ids_column_data.GetItemNumber( i, "label_y" ))
			adw_preview.Modify( ls_label + ".y ='"  + ls_y  + "'")						
		END IF	
		
		IF ii_with_data = 0 THEN
			IF ids_column_data.GetItemNumber( i, "group_by_field" ) = 1 THEN
				IF ii_with_data = 0 THEN
					ls_retval = adw_preview.Modify('create text(band=Header.1 alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="12" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				END IF
			ELSE
				IF ii_with_data = 0 THEN
					ls_retval = adw_preview.Modify('create text(band=Detail alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="' + ls_fld_y + '" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field								
				END IF
			END IF
			adw_preview.Modify( ls_column + "_label.tag ='" + String( i ) + "'")			
		END IF
		
		ls_font_style = ids_column_data.GetItemString( i, "label_font_style" )
		
		IF PosA( ls_font_style,"B" ) > 0 THEN
			adw_preview.Modify( ls_label + ".font.weight ='700'")			
		END IF
		
		IF PosA( ls_font_style,"I" ) > 0 THEN
			adw_preview.Modify( ls_label + ".font.italic ='1'")			
		END IF
			
		IF PosA( ls_font_style,"U" ) > 0 THEN
			adw_preview.Modify( ls_label + ".font.underline ='1'")			
		END IF	
		
		IF PosA( ls_font_style,"N" ) > 0 THEN
			adw_preview.Modify( ls_label + ".font.weight ='400'")			
		END IF	
		
		
		ls_font_style = ids_column_data.GetItemString( i, "field_font_style" )
		
		IF PosA( ls_font_style,"B" ) > 0 THEN
			adw_preview.Modify( ls_column + ".font.weight ='700'")							
			adw_preview.Modify( ls_column + "_label.font.weight ='700'")										
		END IF
		
		IF PosA( ls_font_style,"I" ) > 0 THEN
			adw_preview.Modify( ls_column + ".font.italic ='1'")									
			adw_preview.Modify( ls_column + "_label.font.italic ='1'")												
		END IF
			
		IF PosA( ls_font_style,"U" ) > 0 THEN
			adw_preview.Modify( ls_column + ".font.underline ='1'")													
			adw_preview.Modify( ls_column + "_label.font.underline ='1'")																
		END IF	
		
		IF PosA( ls_font_style,"N" ) > 0 THEN
			adw_preview.Modify( ls_column + ".font.weight ='400'")							
			adw_preview.Modify( ls_column + "_label.font.weight ='400'")										
		END IF	
			
		IF ib_preview AND ii_with_data = 0 THEN			
			adw_preview.Modify( ls_column + ".border ='2'")												
		ELSEIF ib_preview AND ii_with_data = 1 THEN						
			adw_preview.Modify( ls_column + ".border ='0'")															
		END IF


END FOR

ls_title = ids_header_data.GetItemString( 1, "view_name" )

ids_header_data.AcceptText()

if LenA(is_facility_name) > 0 then
	is_facility_name = " :  " + is_facility_name
end if

//IF ib_group_report THEN
//	adw_preview.Modify("create text(band=header text='Report: " + ls_title + is_facility_name +"' border='0' color='0' x='10' y='80' height='60' width='2000'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t" )
//	//adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='110' height='60' width='1400'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t" )
//	adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='145' height='60' width='1400'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t" )
//ELSE


IF is_report_type = "Profile" THEN
	ls_profile_title = String( ids_header_data.GetItemString( 1, "profile_title" ) )	
	adw_preview.Modify("create text(band=header alignment='2' text='" + ls_profile_title + "' border='0' color='0' x='0' y='0' height='76' width='3333'  font.face='Times New Roman' font.height='-12' font.weight='700'  font.family='1' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name=profile_title" )	
ELSE
	adw_preview.Modify("create text(band=header text='Report: " + ls_title +"' border='0' color='0' x='10' y='10' height='60' width='2000'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t" )
	adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='80' height='60' width='1400'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t" )
	adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='150' height='130' width='4500'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t" )
END IF


ls_syntax = adw_preview.describe("DataWindow.Syntax")

Long ll_begin_pos
Long ll_end_pos
String ls_line
String ls_first_part
String ls_last_part

//***** set up grouping *****************************
//openwithparm(w_sql_msg,ls_syntax)
IF ib_group_report THEN
	//remove rectangles with no names from group report
	ll_begin_pos = PosA( ls_syntax, "rectangle" ) -1
	ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
	ll_end_pos = PosA( ls_syntax, ")", ll_begin_pos )
	ll_end_pos = ll_end_pos - ll_begin_pos +1
	ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
	ls_syntax = ls_first_part + ls_last_part

	ll_begin_pos = PosA( ls_syntax, "rectangle" ) -1
	ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
	ll_end_pos = PosA( ls_syntax, ")", ll_begin_pos )
	ll_end_pos = ll_end_pos - ll_begin_pos +1
	ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
	ls_syntax = ls_first_part + ls_last_part
	
	//remove default computed columns with no names from group report	
	ll_begin_pos = PosA( ls_syntax, "compute(" ) -1
	ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
	ll_end_pos = PosA( ls_syntax, "no )", ll_begin_pos )+ 3
	ll_end_pos = ll_end_pos - ll_begin_pos +1
	ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
	ls_syntax = ls_first_part + ls_last_part

	ll_begin_pos = PosA( ls_syntax, "compute(" ) -1
	ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
	ll_end_pos = PosA( ls_syntax, "no )", ll_begin_pos ) + 3
	ll_end_pos = ll_end_pos - ll_begin_pos +1
	ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
	ls_syntax = ls_first_part + ls_last_part	
	
	ll_begin_pos = PosA( ls_syntax, "compute(" ) -1
	IF ll_begin_pos > 0 THEN
		ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
		ll_end_pos = PosA( ls_syntax, "no )", ll_begin_pos ) + 3
		ll_end_pos = ll_end_pos - ll_begin_pos +1
		ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
		ls_syntax = ls_first_part + ls_last_part		
	END IF

	ll_begin_pos = PosA( ls_syntax, "compute(" ) -1
	IF ll_begin_pos > 0 THEN	
		ls_first_part = MidA( ls_syntax, 1, ll_begin_pos )
		ll_end_pos = PosA( ls_syntax, "no )", ll_begin_pos ) + 3
		ll_end_pos = ll_end_pos - ll_begin_pos +1
		ls_last_part = MidA( ls_syntax, ll_begin_pos + ll_end_pos, 100000 )
		ls_syntax = ls_first_part + ls_last_part			
	END IF
	
END IF	
	
adw_preview.Create(ls_syntax)
adw_preview.settransobject(sqlca)
adw_preview.InsertRow( 0 )

////get the width of all fields together
FOR i = 1 TO 100
	ls_width = adw_preview.Describe( "#" + String( i ) + ".width" )
	IF IsNumber( ls_width ) THEN
		ll_total_field_width = ll_total_field_width + Long( ls_width )
	END IF
	FOR f = 1 TO li_aggregate_cnt
		IF ls_agg_fld_num[ f ] = String( i ) THEN
			ls_agg_fld_width[ f ] = ls_width 
		END IF
	END FOR
END FOR

ll_total_field_width = ll_total_field_width + 100
ls_orientation = ids_header_data.GetItemString( 1, "orientation" )
IF ls_orientation = "P" and ll_total_field_width > 3500 THEN
	ll_total_field_width = 3500
ELSEIF ls_orientation = "L" and ll_total_field_width > 4500 then
	ll_total_field_width = 4500
END IF




//debugbreak()
IF li_aggregate_cnt > 0 THEN
	FOR i = 1 TO li_aggregate_cnt
		//if there is a count or sum funtion at the GROUP level then put in space for calc field
		IF ls_agg_type[i] = "GL" or ls_agg_type[I] = "GLSL" THEN
			li_grp_agg = 1
			CHOOSE CASE li_agg_cnt_1 + li_agg_sum_1 + li_agg_avg_1
				CASE 1
					adw_preview.Modify("DataWindow.trailer.1.Height='100'")	
				CASE 2
					adw_preview.Modify("DataWindow.trailer.1.Height='200'")						
				CASE 3					
					adw_preview.Modify("DataWindow.trailer.1.Height='300'")						
			END CHOOSE
		END IF			
		//if there is a count or sum funtion at the SUMMARY level then put in space for calc field
		IF ls_agg_type[i] = "SL" or ls_agg_type[I] = "GLSL" THEN
			li_sum_agg = 1
			CHOOSE CASE li_agg_cnt_1 + li_agg_sum_1 + li_agg_avg_1
				CASE 1
					adw_preview.Modify("DataWindow.Summary.Height='100'")	
				CASE 2
					adw_preview.Modify("DataWindow.Summary.Height='200'")						
				CASE 3					
					adw_preview.Modify("DataWindow.Summary.Height='300'")						
			END CHOOSE
		END IF					
	END FOR

	IF li_grp_agg = 1 THEN
		IF li_agg_sum_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_sum_agg_y = 22				
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_sum_agg_y = 108				
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_sum_agg_y = 195								
			END IF
		END IF

		IF li_agg_cnt_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_cnt_agg_y = 22								
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_cnt_agg_y = 108							
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_cnt_agg_y = 195							
			END IF
		END IF		
		
		IF li_agg_avg_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_avg_agg_y = 22								
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_avg_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_avg_agg_y = 195							
			END IF
		END IF				
	END IF
	
	li_cnt = 0
	IF li_sum_agg = 1 THEN
		IF li_agg_sum_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_sum_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_sum_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_sum_agg_y = 195			
			END IF
		END IF

		IF li_agg_cnt_1 = 1 THEN

			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_cnt_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_cnt_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_cnt_agg_y = 195
			END IF
		END IF		
		
		IF li_agg_avg_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field						
				ll_avg_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_avg_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field											
				ll_avg_agg_y = 195
			END IF
		END IF				
	END IF	
	
	FOR i = 1 TO li_aggregate_cnt
		IF ls_agg_fld_x[i] < 100 THEN  // added ls_agg_fld_x[1] < 400, hope this doesnt screw up things.
			ls_agg_fld_x[i] = ls_agg_fld_x[i] + 400
		END IF
		
		//count
		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_cnt[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_count  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_cnt[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=summary alignment="0" expression="Count(#' + ls_agg_fld_num[i] + ' for all )"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=summary_count  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF
		
		//sum
		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_sum  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_sum  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF		
		
		//averge
		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=group_avg  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF		
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=sumary_avg  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )						
		END IF				
	END FOR
END IF

//ls_grp_fld_nm
//ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Calc 1 "border="0" color="0" x="25" y="30" height="166" width="1302"  name=group_1_header_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field
//ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#1 for group 1)"border="0" color="0" x="' + ls_agg_fld_width[i] + '"  y="11" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )
//ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Calc 2 "border="0" color="0" x="600" y="30" height="166" width="1302"  name=group_1_header_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )//computed field
//ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#2 for group 1 )"border="0" color="0" x="750" y="11" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )
//ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="count(#1 for all)"border="1" color="0" x="500" y="8" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_count_group_1  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912"' )

//******************  retrieve data ********************
IF NOT ib_preview OR ii_with_data = 1 THEN
	adw_preview.Retrieve()
END IF
IF ib_group_report THEN
	res = adw_preview.setsort(is_sort_synt)
	if res < 1 then messagebox("","Sort Error")
	adw_preview.sort()
	adw_preview.groupcalc()
end if

IF IsNull( ids_header_data.GetItemNumber( 1, "font_size" ) ) THEN
	ls_font = MidA( adw_preview.Describe( is_column_name[ 1 ] + ".Font.Height" ),2,100)	
ELSE
	ls_font = String( ids_header_data.GetItemNumber( 1, "font_size" ))
END IF

FOR i = 1 TO ii_col_count
	adw_preview.Modify( is_column_name[ i ] + ".Font.Face='Segoe UI'")		
	adw_preview.Modify( is_column_name[ i ] + ".Font.Height='-" + ls_font + "'")	
	adw_preview.Modify( is_column_name[ i ] + "_label.Font.Height='-" + ls_font + "'")		
	adw_preview.Modify( is_label_name[ i ] + ".Font.Height='-" + ls_font + "'")	
	IF adw_preview.Describe( is_column_name[ i ] + ".coltype" ) = "datetime" THEN
		adw_preview.SetFormat( is_column_name[ i ], "mm/dd/yyyy" )
	END IF	
	ls_align = String( ids_column_data.GetItemNumber( i, "field_align" )	)
	adw_preview.Modify( is_column_name[ i ] + ".alignment = '" + ls_align + "'" )		
	ls_align = String( ids_column_data.GetItemNumber( i, "label_align" )	)
	adw_preview.Modify( is_label_name[ i ] + ".alignment = '" + ls_align + "'" )			
END FOR


IF adw_preview.Title = "" THEN
	adw_preview.Modify("DataWindow.Print.Preview=No")
ELSE
	adw_preview.Modify("DataWindow.Print.Preview=Yes")
END IF

adw_preview.Modify("DataWindow.Grid.Lines='1'" )


IF is_report_type = "Profile" OR is_report_type = "Form" THEN
	IF ib_new THEN
		IF is_report_type = "Profile" THEN
			adw_preview.Modify( "DataWindow.Header.Height='90'" )
		   ids_header_data.SetItem( 1, "header_height", 90 ) 
			IF ib_preview THEN
				ls_Return = adw_preview.Modify("create rectangle(band=header x='0' y='80' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Header )")
			END IF
		ELSE
			adw_preview.Modify( "DataWindow.Header.Height='270'" )
		   ids_header_data.SetItem( 1, "header_height", 270 ) 
			IF ib_preview THEN
				ls_Return = adw_preview.Modify("create rectangle(band=header x='0' y='260' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Header )")
			END IF			
		END IF
	ELSE
		ls_header_height = String( ids_header_data.GetItemNumber( 1, "header_height" ) )
		adw_preview.Modify("DataWindow.Header.Height='" + ls_header_height + "'")				
		ls_header_height = String( Long( ls_header_height )-10 )	
		IF ib_preview THEN
			ls_Return = adw_preview.Modify("create rectangle(band=header x='0' y='" + ls_header_height + "' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Header )")		
		ELSE
			
		END IF
	END IF
ELSE
	adw_preview.Modify("DataWindow.Header.Height='400'")	
END IF

adw_preview.Modify("DataWindow.Detail.Height.AutoSize=Yes")

IF ib_new THEN
	ls_detail_height = adw_preview.Describe( "DataWindow.Detail.Height" )
	ids_header_data.SetItem( 1, "detail_height", Long( ls_detail_height ) )		
	ls_detail_height = String( Long( ls_detail_height )-10 )
ELSE
	ls_detail_height = String( ids_header_data.GetItemNumber( 1, "detail_height" ) )
	adw_preview.Modify("Datawindow.Detail.Height='" + ls_detail_height + "'" )	
	ls_detail_height = String( Long( ls_detail_height )-10 )	
END IF

IF ib_preview THEN
	ls_Return = adw_preview.Modify("create rectangle(band=detail x='0' y='" + ls_detail_height + "' height='10' width='3500' brush.hatch='6' brush.color='0' pen.style='5' pen.width='10' pen.color='553648127'  background.mode='1' background.color='553648127' name=Detail )")
END IF

ids_header_data.Update()

ls_ir_struct.s_column_name[] = is_column_name[]
ls_ir_struct.s_label_name[] = is_label_name[]

Return 1



end function

on pfc_cst_u_reports5.create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_u_reports5.destroy
TriggerEvent( this, "destructor" )
end on

