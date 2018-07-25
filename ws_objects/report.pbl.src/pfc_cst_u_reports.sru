$PBExportHeader$pfc_cst_u_reports.sru
forward
global type pfc_cst_u_reports from nonvisualobject
end type
type istr_intellireport from structure within pfc_cst_u_reports
end type
end forward

type istr_intellireport from structure
	string		s_column_name[]
	string		s_label_name[]
	integer		i_return
end type

global type pfc_cst_u_reports from nonvisualobject
end type
global pfc_cst_u_reports pfc_cst_u_reports

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
public function string of_intellireport_preview (integer ai_view_id, ref datawindow adw_preview, boolean ib_preview, boolean ib_new, integer ii_with_data, string is_facility_name, string is_filter, string is_sort_synt, boolean ib_group_report, string is_report_type, integer ai_facil_security, integer ai_dept_security_on)
public subroutine of_get_rowcount (ref datastore ads_profile_view, ref long al_count[], integer ai_facility_id, long al_prac_id)
public function string of_get_dw_syntax (long al_data_view_id, long al_screen_id)
public function integer of_library_check (string as_path)
public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn)
public function string of_mod_syntax_for_profile (string as_sql, long al_prac, long al_facility, string as_args)
public subroutine of_create_dwdata (string as_dataobject)
public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn, long al_view_id)
public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn, long al_view_id, boolean ab_msg)
public function string of_get_report_filter ()
public function integer of_activity_report (n_ds ads_reports)
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

//2007.7.18 By Jervis
if isvalid(lds_qv_data) then destroy lds_qv_data
if isvalid(lds_qv_rpt) then destroy lds_qv_rpt
//end jervis


Return 0


end function

public function integer of_custom_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id);String ls_report_dw
String ls_retval
Integer i
Integer li_row_cnt
Integer li_screen_id
string ls_facility_name
n_ds lds_profile_view

/*
//delete By Jervis 2007.7.18 
pfc_cst_nv_data_entry_functions nv_de_func
nv_de_func = CREATE pfc_cst_nv_data_entry_functions
*/
lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_pfc_selected_custom_profile_reports"
lds_profile_view.of_SetTransObject( SQLCA )

FOR i = 1 TO 40
	adw_report.Modify("rpt_" + String( i ) + ".Visible='0'")
	adw_report.Modify("rpt_" + String( i ) + ".DataObject='' ")
END FOR

li_row_cnt = lds_profile_view.Retrieve( ai_profile_view_id )

FOR i = 1 TO li_row_cnt
	
	li_screen_id = lds_profile_view.GetItemNumber( i, "screen_id" )
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

if isvalid(lds_profile_view) then destroy lds_profile_view

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
//n_ds lds_grades

lds_peer = CREATE n_ds;
lds_peer.DataObject = "d_case_peer_profile"
lds_peer.SetTransObject( SQLCA )
lds_peer.Retrieve( )

li_grades_cnt = lds_peer.RowCount( )


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

if isvalid(lds_peer) then destroy lds_peer //2007.7.18 By Jervis
Return 1
end function

public function integer of_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile);String ls_report_dw
String ls_retval
Integer i,j
Integer li_row_cnt
n_ds lds_profile_view
string ls_facility_name
Long ll_dept_code  
long ll_count[]
datawindowchild ldwc_child
long ll_y,ll_ret


adw_report.dataobject = "d_prf_master"

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_pfc_selected_reports"
lds_profile_view.of_SetTransObject( SQLCA )

FOR i = 1 TO 52 //42 to 50 maha 012507
	adw_report.Modify('rpt_' + String( i ) + '.Visible="0"')
	adw_report.Modify('rpt_' + String( i ) + '.DataObject="" ')	
END FOR

adw_report.setredraw(false)
li_row_cnt = lds_profile_view.Retrieve( ai_profile_view_id )
string ls_ret
FOR i = 1 TO li_row_cnt
	ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	IF ls_report_dw = "d_prf_" THEN
		Continue
	END IF
	ls_ret = adw_report.Modify("rpt_" + String( i ) + ".Visible='1'")
	ls_ret = adw_report.Modify("rpt_" + String( i ) + ".DataObject='" + ls_report_dw + "' ")

	IF lds_profile_view.GetItemString( i , "retrieval_arguments" ) = "P" THEN
		ls_ret = adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")
	ELSE
 	     ls_ret = adw_report.Modify("rpt_" + String( i ) + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")	
	END IF
END FOR

gnv_appeondb.of_startqueue() //$<add> 02.20.2006 By: Cao YongWang

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

//adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<comment> 02.28.2006 By: Liang QingShi


adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )

gnv_appeondb.of_commitqueue()//$<add> 02.20.2006 By: Cao YongWang
adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<add> 02.20.2006 By: Cao YongWang


//--------------------------- APPEON BEGIN ---------------------------
/*
Maybe PB's bug, after getchild, it can't get rowcount.???
//$<add> 05/11/2007 By: Ken.Guo
//$<reason> Fix a bug: Have blank space being generated between data pages
long ll_value[]

//Get which child reports have data. 
//Because can't get child report that is nest report itselt use GetChild function,
//So deal with them specially. Nest child reports: "d_prf_personal","d_prf_att_quest_master","d_prf_att_quest_master"
//clipboard(adw_report.object.datawindow.syntax)
FOR i = 1 TO li_row_cnt
	ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	ll_ret = adw_report.getchild("rpt_" + String( i ) ,ldwc_child)
	if (ldwc_child.rowcount() > 0 and adw_report.describe("rpt_" + String( i ) + ".Visible") = '1') &
		or ls_report_dw = 'd_prf_personal' & 
		or ls_report_dw = 'd_prf_att_quest_master' & 
		or ls_report_dw = 'd_prf_workgap'  then
		ll_value[i] = 1 
	else
		ll_value[i] = 0 
	end if
Next

//Reset the Dataobject and modify it again.
adw_report.reset()
adw_report.dataobject = "d_prf_master"
FOR i = 1 TO 50 //42 to 50 maha 012507
	adw_report.Modify('rpt_' + String( i ) + '.Visible="0"')
	adw_report.Modify('rpt_' + String( i ) + '.DataObject="" ')	
END FOR
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

//Regenerate Child Reports only that have data. 
j = 0
For i = 1 To upperbound(ll_value)
	If ll_value[i] = 1 Then
		J++
		If j = 1 Then
			//Becaues child report that is nest report itself maybe have no data.So Set height to 1 for reduce blank space.
			adw_report.Modify("rpt_" + String( i ) + ".y = ~"10~"" + " rpt_" + String( i ) + ".height = ~"1~"") 
		Else
			ll_y = 1 + long(adw_report.Describe("rpt_" + String( J - 1 ) + ".Y")) + 20
			adw_report.Modify("rpt_" + String( i ) + ".y = ~"" +string(ll_y)+"~"" + " rpt_" + String( i ) + ".height = ~"1~"")			
		End If
	Else
		adw_report.Modify("rpt_" + String( i ) + ".Visible='0'")
	End If
Next
//Retrive again
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )
*/
//---------------------------- APPEON END ----------------------------

adw_report.setredraw(true)
IF ai_print_peer_review_profile  THEN
	of_peer_review_profile ( al_prac_id, ai_facility_id )
END IF

if isvalid(lds_profile_view) then destroy lds_profile_view //2007.7.18 By Jervis

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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 04.05.2006 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;

SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;
*/

gnv_appeondb.of_startqueue( )

SELECT conv_view.distinct_sql
INTO :li_distinct_sql  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;

SELECT conv_view.add_rec_id_fld  
INTO :li_add_rec_fld  
FROM conv_view  
WHERE conv_view.view_id = :ii_view_id   ;

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------


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

public function string of_intellireport_preview (integer ai_view_id, ref datawindow adw_preview, boolean ib_preview, boolean ib_new, integer ii_with_data, string is_facility_name, string is_filter, string is_sort_synt, boolean ib_group_report, string is_report_type, integer ai_facil_security, integer ai_dept_security_on);//ls_valid = dw_composite.Object.rpt_employee. Object.emp_id.Validation

//dwsyntax = dw_1.Describe("DataWindow.Syntax")
//rtncode = LibraryImport("c:\pb\dwTemp.pbl", "d_emp", ImportDataWindow!, dwsyntax, ErrorBuffer, "Employee DataWindow 1")

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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 04.05.2006 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
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
*/

ids_column_data = CREATE datastore;
ids_column_data.DataObject = "d_view_selected_fields"
ids_column_data.SetTransObject( SQLCA )

ids_header_data = CREATE datastore;
ids_header_data.DataObject = "d_cust_report_detail"
ids_header_data.SetTransObject( SQLCA )

ids_filter_data = CREATE datastore;
ids_filter_data.DataObject = "d_view_where"
ids_filter_data.SetTransObject( SQLCA )

ids_table_data = CREATE datastore;

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.08.2016
//<$>reason:Issue id 5351 - SQL Server 2014 and 2016 Partial Contained Databases and High Availability Groups
//ids_table_data.DataObject = "d_conv_view_tables_report"
if gs_DbType = 'SQL' THEN
	ids_table_data.dataobject = 'd_conv_view_tables_report_sql'
Else
	ids_table_data.dataobject = 'd_conv_view_tables_report_asa'
End If
//------------------- APPEON END -------------------

ids_table_data.SetTransObject( SQLCA )

ids_link_data = CREATE datastore;
ids_link_data.DataObject = "d_conv_view_links"
ids_link_data.SetTransObject( SQLCA )

ids_sort_data = CREATE datastore;
ids_sort_data.DataObject = "dw_view_sort"
ids_sort_data.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

ids_header_data.Retrieve( ii_view_id )
ids_column_data.Retrieve( ii_view_id )
ids_filter_data.Retrieve( ii_view_id )
ids_table_data.Retrieve( ii_view_id )
ids_link_data.Retrieve( ii_view_id )
ids_sort_data.Retrieve( ii_view_id )

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------




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
	RETURN 'ERROR'
END IF

adw_preview.Create( ls_dwsyntax_str, ERRORS)

IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"Create cause these errors: " + ERRORS)
	RETURN 'ERROR'
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
					ls_retval = adw_preview.Modify('create text(band=Header.1 alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="12" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				END IF
			ELSE
				IF ii_with_data = 0 THEN
					ls_retval = adw_preview.Modify('create text(band=Detail alignment="0" text="' + ls_column + '" border="0" color="0" x="' + ls_x + '" y="' + ls_fld_y + '" height="83" width="' + String( ll_width ) + '"  name=' + ls_column + '_label font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field								
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
	adw_preview.Modify("create text(band=header alignment='2' text='" + ls_profile_title + "' border='0' color='0' x='0' y='0' height='76' width='3333'  font.face='Times New Roman' font.height='-12' font.weight='700'  font.family='1' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name=profile_title)" )	
ELSE
	adw_preview.Modify("create text(band=header text='Report: " + ls_title +"' border='0' color='0' x='10' y='10' height='60' width='2000'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title1_t)" )
	adw_preview.Modify("create text(band=header text='Date: " + String( Today() ) + "' border='0' color='0' x='10' y='80' height='60' width='1400'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title2_t)" )
	adw_preview.Modify("create text(band=header text='Filter: " + is_filter + "' border='0' color='0' x='10' y='150' height='130' width='4500'  font.face='Segoe UI' font.height='-8' font.weight='600'  font.family='2' font.pitch='2' font.charset='0' background.mode='1' background.color='553648127' name=title3_t)" )
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
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_sum_agg_y = 22				
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_sum_agg_y = 108				
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_sum_agg_y = 195								
			END IF
		END IF

		IF li_agg_cnt_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_cnt_agg_y = 22								
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_cnt_agg_y = 108							
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_cnt_agg_y = 195							
			END IF
		END IF		
		
		IF li_agg_avg_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_avg_agg_y = 22								
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_avg_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=trailer.1 alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=group_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_avg_agg_y = 195							
			END IF
		END IF				
	END IF
	
	li_cnt = 0
	IF li_sum_agg = 1 THEN
		IF li_agg_sum_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_sum_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_sum_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Sum "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_sum_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_sum_agg_y = 195			
			END IF
		END IF

		IF li_agg_cnt_1 = 1 THEN

			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_cnt_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_cnt_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Count "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_count_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_cnt_agg_y = 195
			END IF
		END IF		
		
		IF li_agg_avg_1 = 1 THEN
			li_cnt++
			IF li_cnt = 1 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="12" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field						
				ll_avg_agg_y = 22
			ELSEIF li_cnt = 2 THEN
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="98" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
				ll_avg_agg_y = 108
			ELSE
				ls_retval = adw_preview.Modify('create text(band=Summary alignment="0" text="Average "border="2" color="0" x="25" y="185" height="83" width="' + String( ll_total_field_width ) + '"  name=sum_avg_text  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )//computed field											
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
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="count(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_count  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
		END IF
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_cnt[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=summary alignment="0" expression="Count(#' + ls_agg_fld_num[i] + ' for all )"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_cnt_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=summary_count  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
		END IF
		
		//sum
		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '" format="#,##0"  name=group_sum  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
		END IF
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_sum[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="sum(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_sum_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=summary_sum  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
		END IF		
		
		//averge
		IF (ls_agg_type[i] = "GL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=trailer.1 alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for group 1)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=group_avg  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
		END IF		
		IF (ls_agg_type[i] = "SL" OR ls_agg_type[I] = "GLSL") AND li_agg_avg[i] = 1 THEN
			ls_retval = adw_preview.Modify('create compute(band=Summary alignment="0" expression="Avg(#' + ls_agg_fld_num[i] + ' for all)"border="0" color="0" x="' + String(ls_agg_fld_x[i] ) + '" y="' + String( ll_avg_agg_y ) + '" height="166" width="' + ls_agg_fld_width[i] + '"  format="#,##0"  name=sumary_avg  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912")' )						
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

Return ls_sql
end function

public subroutine of_get_rowcount (ref datastore ads_profile_view, ref long al_count[], integer ai_facility_id, long al_prac_id);//
//long i
//long ll_dwcount
//string ls_report_dw
//datastore lds_childreport[] 
//
//
//ll_dwcount = ads_profile_view.rowcount()
//gnv_appeondb.of_startqueue()
//For i = 1 to ll_dwcount
//	lds_childreport[i] = Create Datastore
//	ls_report_dw = ads_profile_view.GetItemString( i, "report_dw" )
//	IF ls_report_dw = "d_prf_" THEN
//		lds_childreport[i].dataobject = ''
//		Continue
//	END IF
//
//	lds_childreport[i].dataobject = ls_report_dw + '_0ref'
//	lds_childreport[i].settransobject(sqlca)
//	IF ads_profile_view.GetItemString( i , "retrieval_arguments" ) = "P" THEN
//		lds_childreport[i].retrieve(al_prac_id) 
//	ELSE
//		lds_childreport[i].retrieve(ai_facility_id, al_prac_id) 
//	END IF
//Next
//gnv_appeondb.of_commitqueue()
//
//for i = 1 to ll_dwcount
//	al_count[i] = lds_childreport[i].rowcount()
//	destroy lds_childreport[i]
//next 
//
//
////messagebox('f',string(al_count[1]) +string(al_count[2]))
end subroutine

public function string of_get_dw_syntax (long al_data_view_id, long al_screen_id);//not used calling generic function instead of_get_profile_screen_syntax

//Start Code Change ----11.30.2007 #V8 maha
//new function added for dynamic dw in profile  copied from f_get_screen_sql
//Long ll_data_length
//Integer li_counter
//Integer li_loops
//String ls_sql
////String ls_all_sql
//Long ll_start
//
//// Get file data from database
//SELECT Datalength(dw_syntax)
//INTO :ll_data_length
//FROM profile_view_reports
//WHERE profile_view_id = :al_data_view_id
//AND profile_report_id = :al_screen_id;
//
//IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
//	return "NULL"
//	//Messagebox("Get sql error","Failed to get datawindow syntax from DB, Please report this to support.")
//	//RETURN ''
//END IF
//
////Messagebox("Gll_data_length",ll_data_length)
//debugbreak()
//IF ll_data_length > 32000 THEN 
//  	 IF Mod(ll_data_length,32000) = 0 THEN 
//        li_loops = ll_data_length/32000 
//    ELSE 
//  	     li_loops = (ll_data_length/32000) + 1 
//    END IF 
//ELSE 
//  	 li_loops = 1 
//END IF 
//
//FOR li_counter = 1 to li_loops
//	ll_start = (li_counter - 1) * 32000 + 1
//	SELECT substring(dw_syntax,:ll_start,32000)
//	INTO :ls_sql
//	FROM profile_view_reports
//WHERE profile_view_id = :al_data_view_id
//AND profile_report_id = :al_screen_id;
//
//	ls_all_sql += ls_sql
//NEXT 
//
//If not len(ls_all_sql) > 0 Then
//	Messagebox("Get sql error in of_get_dw_syntax of pfc_cst_u_reports","Failed to get datawindow syntax from DB, Please report this to support.")
//	Return "ERROR"
//End If

//Return ls_all_sql

return "no"
end function

public function integer of_library_check (string as_path);//maha 12.03.07
string s

if  not fileexists(as_path) then
	librarycreate(as_path)
end if

if  not fileexists(as_path) then
	messagebox("Error in dynamic profile","Unable to create temp Library")
	return -1
end if

AddToLibraryList ( as_path)

return 1
end function

public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn);//Start Code Change ---- 11.07.2007 #V7 maha new function will be used to create dynamic profiles.

Integer i,j
Integer li_row_cnt
integer li_report_id
integer li_screen_id
integer li_view_id
integer pos1
integer pos2
integer ret
n_ds lds_profile_view
string ls_facility_name
string ls_syntax
blob lb_syntax
string ls_rtp_object
String ls_report_dw
String ls_retval
string ErrorBuffer
string ls_ret
Long ll_dept_code  
long ll_count[]
datawindowchild ldwc_child
long ll_y,ll_ret
long ll_len
string ls_mod_string
string ls_temp_name
string ls_screen
string method = 'A'
string ls_arg
pfc_cst_nv_data_entry_functions luo_def

//notes on methods
//A = syntax is set in the screen painter.  Modfied here for retrieval arguments
//B = screen painter set view and screen.  Syntax is generated here and modified here
//C = syntax created as in A, but does not use the libraryimport method of A&B; rather sets the syntax of the subreport directly
//		which should not be possible		


adw_report.dataobject = "d_prf_master"

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_pfc_profile_reports"
lds_profile_view.of_SetTransObject( SQLCA )

//make all reports invisible
FOR i = 1 TO 50 //42 to 50 maha 012507
	adw_report.Modify('rpt_' + String( i ) + '.Visible="0"')
	adw_report.Modify('rpt_' + String( i ) + '.DataObject="" ')	
END FOR

 luo_def = CREATE pfc_cst_nv_data_entry_functions

adw_report.setredraw(false)
li_row_cnt = lds_profile_view.Retrieve( ai_profile_view_id )
//debugbreak()
FOR i = 1 TO li_row_cnt
	
	ls_rtp_object = "rpt_" + String( i ) 
	ls_temp_name = "d_temprpt_" + String( i )
	
	//ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	li_report_id =  lds_profile_view.GetItemnumber( i, "profile_report_id" )
	ls_arg = lds_profile_view.GetItemString( i , "retrieval_arguments" )
	
	//for each report in the profile, make it visible
	ls_ret = adw_report.Modify(ls_rtp_object + ".Visible='1'")
	
	if method = "A" or method = "C" then
		//check to see if there is a syntax saved from the screen painter of_get_profile_screen_syntax() is in the intellicred.pbl
		ls_syntax = of_get_profile_screen_syntax(ai_profile_view_id  ,li_report_id ) //method A	
		if ls_syntax = "NULL" or ls_syntax = "ERROR" then ls_syntax = ""
	elseif method  = "B"	then	
		ls_syntax = lds_profile_view.GetItemstring( i, "dw_syntax" ) //method B
	end if
	

	IF isnull(ls_syntax) or LenA(ls_syntax) = 0 then //no syntax use default
		ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
			IF ls_report_dw = "d_prf_" THEN
				Continue
			END IF	
		ls_mod_string = ls_rtp_object + ".DataObject='" + ls_report_dw + "' " //maha 011508
	ELSE
		//view@screenid&screen name
	//	debugbreak()
		if method = "A" then
			//modify the syntax to include the prac argument
			ls_syntax  = of_mod_syntax_for_profile( ls_syntax, al_prac_id, ai_facility_id,ls_arg) //method A
		elseif  method = "B" then
			pos1 = PosA(ls_syntax,"@" , 1)
			pos2 = PosA(ls_syntax,"&" , 1)
			li_view_id = integer(MidA(ls_syntax, 1, pos1 - 1))
			li_screen_id = integer(MidA(ls_syntax, pos1 + 1, pos2 - pos1 - 1 ))
			ls_screen = MidA(ls_syntax,  pos2 + 1)
			luo_def.of_create_dynamic_dw_4_prof (al_prac_id, li_view_id,li_screen_id,adw_profile_syn,  false, ai_facility_id)
			//ls_syntax = dw_dyn_profile.Describe("DataWindow.Syntax")
			ls_syntax  = of_modify_dw_for_dyn_profile(adw_profile_syn,li_screen_id,ls_screen, "P")// method B
			//\/test code	
			adw_profile_syn.visible = true
			adw_profile_syn.bringtotop = true
			//messagebox("","pause")
			//\ test code		
		elseif method = "C" then
			//ls_syntax  = of_mod_syntax_for_profile( ls_syntax, al_prac_id, ai_facility_id)	
		end if
		
		//openwithparm(w_sql_msg,ls_syntax )  //for testing

		choose case method
			case "A","B"
				of_library_check( gs_dir_path + "intellicred\report_temp.pbd") 
				j = LibraryImport( gs_dir_path + "intellicred\report_temp.pbd",ls_temp_name, ImportDataWindow!, ls_syntax, ErrorBuffer)
				//	messagebox(string(j),gs_dir_path + "intellicred\report_temp.pbd")
				if LenA(ErrorBuffer ) > 1 then
					messagebox("Syntax error during LibraryImport of screen "   , errorBuffer)
					continue
				end if
	debugbreak()			
				ls_mod_string = ls_rtp_object + ".DataObject='" + ls_temp_name + "' "
				
				//messagebox("ls_mod_string",ls_mod_string)
			case "C"
				ls_mod_string = ls_rtp_object + ".DataObject='" + ls_report_dw + "' " //method C	
		end choose
	END IF
	
	ls_ret = adw_report.Modify(ls_mod_string)
	if LenA(ls_ret ) > 1 then
		messagebox("Syntax error during modify: "+ ls_mod_string, ls_ret)
	end if
	//Start Code Change ----03.28.2008 #V8 maha
	if method = 'A' then	
		ls_ret = adw_report.Modify( ls_rtp_object + ".width=3290")
		if LenA(ls_ret ) > 1 then
			messagebox("Syntax error during modify:"," report width")
		end if
	end if
	//End Code Change---03.28.2008
	
	if method = 'C' then
		adw_report.Modify(ls_rtp_object + ".DataWindow.Syntax=" + ls_syntax) //method C
	end if

	IF ls_arg = "P" THEN
		ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")
	ELSE
     		 ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")	
	END IF
next


gnv_appeondb.of_startqueue() //$<add> 02.20.2006 By: Cao YongWang

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

//adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<comment> 02.28.2006 By: Liang QingShi

//messagebox("","test2")
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )

gnv_appeondb.of_commitqueue()//$<add> 02.20.2006 By: Cao YongWang
adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<add> 02.20.2006 By: Cao YongWang


adw_report.setredraw(true)
IF ai_print_peer_review_profile  THEN
	of_peer_review_profile ( al_prac_id, ai_facility_id )
END IF

if isvalid(lds_profile_view) then destroy lds_profile_view //2007.7.18 By Jervis
if isvalid( luo_def) then destroy  luo_def


Return 0

//from PowerBuilder journal
//Nested Reports and the getchild() Method
//Earlier, I mentioned that report objects nested within a DataWindow are not DataWindow children, thus any call to getchild() will fail. There is a way around this. In the source editor, open the base DataWindow and change "processing=0" (or whatever it is) to "processing=5". This is the actual trick to change the base DataWindow's presentation style to "composite". The getchild function can now be used to access the nested report. 
//
//This is a cool trick because it opens up all methods that can be called for DataWindow children. A drawback of this method is that since the base DataWindow's presentation style has been changed to composite and composite windows have no data source, the base DataWindow's data source cannot be changed unless processing is changed back from "5". Also, it should be pointed out that the above technique is not supported by Sybase and should be used with extreme caution. 
//
end function

public function string of_mod_syntax_for_profile (string as_sql, long al_prac, long al_facility, string as_args);long pos_where
long pos2
long pos3
long pos4
long pos5
long pos6
long pos_from
long pos_addr
long pos_order
string ls_syn1
string s1
string s2
string s3
string s4
string s5
string ls_arg_string
string ls_from
string ls_where
string ls_order //maha03.27.2008

ls_syn1 = as_sql

if gi_test_mode = 1 then
	openwithparm(w_sql_msg,as_sql)
end if

if as_args = "P" then
	ls_arg_string = '" arguments=(("prac_id", number)) '
else
	ls_arg_string = '" arguments=(("facility", number),("prac_id", number)) '
end if


pos_addr = PosA(ls_syn1," FROM pd_address ",1)
pos_where = PosA(ls_syn1," WHERE ",1)
pos_from = PosA(ls_syn1," FROM ",1)


if pos_addr > 0 then
	ls_from  = ' FROM pd_address, pd_address_link '
	ls_where = ' WHERE  ( pd_address.rec_id = pd_address_link.address_id ) and   ( pd_address.prac_id = :prac_id ) AND  pd_address.active_status = 1 AND   (pd_address_link.primary_office = 1 OR  pd_address_link.additional_office = 1) AND  pd_address_link.facility_id = :facility  ' 
else
	ls_from = MidA(ls_syn1,pos_from  , pos_where - pos_from + 1)  //get the existing from statement
	
	
	pos_order = PosA(ls_syn1," ORDER BY ",pos_where) 
	////Start Code Change ----03.27.2008 #V8 maha - recorrected again
	//Start Code Change ----04.08.2008 #V8 maha - corrected order section for non-standard order by
	pos5 = PosA(ls_syn1,'"' , pos_order)
	//ls_order = mid(ls_syn1, pos_order,16)
	ls_order = MidA(ls_syn1, pos_order, pos5 -  pos_order )
	//pos5 = pos_order + 17
	s5 = MidA(ls_syn1, pos5 + 1)
	//End Code Change---04.08.2008
	////End Code Change---03.27.2008
	ls_where = MidA(ls_syn1,pos_where  , pos_order - pos_where + 1)
	pos2 = PosA(ls_where,".prac_id",1) 
	pos3 = pos2 + 11 //'.prac_id = '
	s2 = MidA(ls_where,1 , pos3)
	
	pos4 = PosA(ls_where,".facility_id",pos3) 
	if pos4 > 0 then //add facility variable if appropriate
		s4 = MidA(ls_where, pos3, pos4 - pos3 + 1 ) + ".facility_id = :facility "
	else
		s4 = ""
	end if
		
	ls_where = s2 + ':prac_id ' + s4
end if

	
//FROM pd_address WHERE pd_address.prac_id  = 1 ORDER BY street ASC"
// ( pd_basic.prac_id = :prac_id )
//FROM pd_group_providers WHERE pd_group_providers.prac_id  = 1 AND pd_group_providers.facility_id  = 2 ORDER BY rec_id"
debugbreak()

//pos5 = pos(ls_syn1,'"',pos3) 

// prior to from
s1 = MidA(ls_syn1,1 , pos_from) 

////Start Code Change ----03.27.2008 #V8 maha - recorrected again
//s5 = mid(ls_syn1, pos_order + 1)

//ls_syn1 = s1 + ls_from + ls_where + ls_arg_string + s5
ls_syn1 = s1 + ls_from + ls_where + ls_order +ls_arg_string + s5//s3 = mid(ls_syn1, pos4, pos5  - pos4 + 1)
////End Code Change---03.27.2008

if gi_test_mode = 1 then
	openwithparm(w_sql_msg,ls_syn1)
end if


return ls_syn1



end function

public subroutine of_create_dwdata (string as_dataobject);//

datastore	lds_data
string		ls_objects,ls_obj
string		ls_objtype
int			li_prfid,li_scrid,li_tableid
boolean		lb_exists=false
string		ls_case,ls_mask
long			ll_x,ll_y,ll_width,ll_height,ll_weight,ll_italic,ll_just,ll_underline
string		ls_just,ls_visible,ls_underline
string		ls_text
long			ll_dataview_fieldid,ll_fieldid,ll_objectid
long			li_fieldid

lds_data=create datastore

lds_data.dataobject=as_dataobject
ls_objects=lds_data.describe("datawindow.objects")+'~t'
ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
do while LenA(ls_obj)>0
	//
	ls_visible=lds_data.describe(ls_obj+".visible")
	if ls_visible='0' then
		ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
		ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
		continue
	end if
	if LenA(ls_visible)>1 then setnull(ls_visible)
	ls_visible='Y'		
	ls_case=lower(lds_data.describe(ls_obj+".Edit.Case"))
	if ls_case='?' or ls_case='any' then
		ls_case='0'
	elseif ls_case='upper' then
		ls_case='1'
	elseif ls_case='lower' then	
		ls_case='2'
	end if		
	ls_mask=lds_data.describe(ls_obj+".format")
	ll_x=long(lds_data.describe(ls_obj+".x"))
	ll_y=long(lds_data.describe(ls_obj+".y"))
	ll_width=long(lds_data.describe(ls_obj+".width"))
	ll_height=long(lds_data.describe(ls_obj+".height"))
	ls_just=lds_data.describe(ls_obj+".Alignment")
	ll_just=long(ls_just)	
	ll_weight=long(lds_data.describe(ls_obj+".Font.Weight"))
	ls_underline=lds_data.describe(ls_obj+".Font.Underline")
	if ls_underline='?' then ls_underline='0'
	ll_underline=long(ls_underline)
	ll_italic=long(lds_data.describe(ls_obj+".Font.Italic"))
	ls_text=lds_data.describe(ls_obj+".text")
	
	ls_objtype=lds_data.describe(ls_obj+".type")
	if ls_objtype='column' then		
		select prf_id,scr_id,table_id into :li_prfid,:li_scrid,:li_tableid from profile_report_dw where prf_dw=:as_dataobject;
		if li_scrid=0 or isnull(li_scrid) then
			lb_exists=false
		else
			select field_id into :li_fieldid from sys_report_fields where table_id=:li_tableid and field_name=:ls_obj;
			if sqlca.sqlcode=0 and li_fieldid<>0 then
				lb_exists=true
			else
				lb_exists=false
			end if
		end if
		//max data_view_field_id
		select max(data_view_field_id) into :ll_dataview_fieldid from data_view_report_fields;
		if isnull(ll_dataview_fieldid) then ll_dataview_fieldid=0
		ll_dataview_fieldid=ll_dataview_fieldid+1		
		select max(field_id) into :ll_fieldid from sys_report_fields;
		if isnull(ll_fieldid) then ll_fieldid=0
		ll_fieldid=ll_fieldid+1	
		
		if lb_exists=true then //sys_report_fields exists column,only insert into data_view_report_fields
			insert data_view_report_fields(data_view_field_id,data_view_id,screen_id,field_id,field_x,field_y,field_width,field_height,justification,font_wieght,field_underline,field_font_italic,visible,profile_view_id)
			values(:ll_dataview_fieldid,1,:li_prfid,:li_fieldid,:ll_x,:ll_y,:ll_width,:ll_height,:ls_just,:ll_weight,:ls_underline,:ll_italic,:ls_visible,999);
			if sqlca.sqlcode<>0 then messagebox('data_view_report_fields:'+as_dataobject+'/'+ls_obj,sqlca.sqlerrtext)
		else	//insert into sys_report_fields,data_view_report_fields
			insert sys_report_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias,field_case,field_mask)
			values(:li_tableid,:ll_fieldid,0,:ls_obj,'C',50,:ls_obj,:ls_case,:ls_mask);
			if sqlca.sqlcode<>0 then messagebox('sys_report_fields:'+as_dataobject+'/'+ls_obj,sqlca.sqlerrtext)
			insert data_view_report_fields(data_view_field_id,data_view_id,screen_id,field_id,field_x,field_y,field_width,field_height,justification,font_wieght,field_underline,field_font_italic,visible,profile_view_id)
			values(:ll_dataview_fieldid,1,:li_prfid,:ll_fieldid,:ll_x,:ll_y,:ll_width,:ll_height,:ls_just,:ll_weight,:ls_underline,:ll_italic,:ls_visible,999);
			if sqlca.sqlcode<>0 then messagebox('data_view_report_fields:'+as_dataobject+'/'+ls_obj,sqlca.sqlerrtext)
		end if				
	else //other object,insert into screen_report_objects
		select max(data_view_object_id) into :ll_objectid from screen_report_objects;
		if isnull(ll_objectid) then ll_objectid=0
		ll_objectid=ll_objectid+1	

		select prf_id into :li_prfid from profile_report_dw where prf_dw=:as_dataobject;
		
		insert screen_report_objects(data_view_object_id,data_view_id,screen_id,object_name,object_text,object_width,object_height,object_x,object_y,object_alignment,object_italic,object_bold,object_underline,visible,profile_view_id)
		values(:ll_objectid,1,:li_prfid,:ls_obj,:ls_text,:ll_width,:ll_height,:ll_x,:ll_y,:ll_just,:ll_italic,:ll_weight,:ll_underline,:ls_visible,999);
		if sqlca.sqlcode<>0 then messagebox('screen_report_objects:'+as_dataobject+'/'+ls_obj,sqlca.sqlerrtext)
	end if
	ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
	ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
loop

sleep(1)

end subroutine

public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn, long al_view_id);//Current profile function version 9  /copied from original and modified 

Integer i,j
Integer li_row_cnt
integer li_report_id
integer li_screen_id
integer li_view_id
integer pos1
integer pos2
integer ret
integer li_set_fullname, li_set_hidessn //alfee 12.29.2014
n_ds lds_profile_view
string ls_expression //alfee 12.28.2014
string ls_facility_name
string ls_syntax
blob lb_syntax
string ls_rtp_object
String ls_report_dw
String ls_retval
string ErrorBuffer
string ls_ret
Long ll_dept_code  
long ll_count[]
datawindowchild ldwc_child
long ll_y,ll_ret
long ll_len
string ls_mod_string
string ls_temp_name
string ls_screen
string method = 'A'
string ls_arg
string ls_reportfrom
string ls_user //maha 01.17.2012
datawindowchild	ldc_dw
pfc_cst_nv_data_entry_functions	luo_report

//notes on methods
//A = syntax is set in the screen painter.  Modfied here for retrieval arguments
//B = screen painter set view and screen.  Syntax is generated here and modified here
//C = syntax created as in A, but does not use the libraryimport method of A&B; rather sets the syntax of the subreport directly
//		which should not be possible		
//

al_view_id = 1 //Alfee 02.16.2009

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Running Profile Report...')
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(10)

luo_report = create pfc_cst_nv_data_entry_functions
luo_report.ib_report = true
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Getting Profile Screen Data...')  //Start Code Change ----02.10.2009 #V92 maha
luo_report.of_setup_cache()

adw_report.dataobject = "d_prf_master"

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_profile_report_list_new"
lds_profile_view.of_SetTransObject( SQLCA )

//make all reports invisible
FOR i = 1 TO 51 //42 to 50 maha 012507
	adw_report.Modify('rpt_' + String( i ) + '.Visible="0"')
	adw_report.Modify('rpt_' + String( i ) + '.DataObject="" ')	
END FOR
adw_report.Modify("DataWindow.Detail.Height='10'")// For blank page on report  Added by Nova 02.12.2009
adw_report.setredraw(false)
li_row_cnt = lds_profile_view.Retrieve(al_view_id, ai_profile_view_id )
//Added by Alan on 16.10.2008
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Creating Profile Screens...')  //Start Code Change ----02.10.2009 #V92 maha
app_filler.ids_report_fields_cache.Retrieve(al_view_id,ai_profile_view_id)
app_filler.ids_report_objects_cache.Retrieve(al_view_id,ai_profile_view_id)
app_filler.ids_screen_report_objects_cache.Retrieve(al_view_id,ai_profile_view_id)

//Start Code Change ----04.25.2016 #V15 maha
//Select top 1 set_fullname, set_hidessn into :li_set_fullname, :li_set_hidessn from icred_settings; //alfee 12.29.2014
li_set_fullname = of_get_app_setting("set_fullname","I")
li_set_hidessn = of_get_app_setting("set_hidessn","I")
//End Code Change ----04.25.2016



FOR i = 1 TO li_row_cnt
	
	ls_rtp_object = "rpt_" + String( i ) 
	ls_temp_name = "d_temprpt_" + String( i )
	
	//ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	li_report_id =  lds_profile_view.GetItemnumber( i, "report_id" )
	ls_arg = trim(lds_profile_view.GetItemString( i , "retrieval_aruments" ))
	
	//for each report in the profile, make it visible
	ls_ret = adw_report.Modify(ls_rtp_object + ".Visible='1'")
	
	ls_report_dw = lds_profile_view.GetItemString( i, "cur_dw" )
	IF ls_report_dw = "d_prf_" THEN
		Continue
	END IF	
//debugbreak()	
	IF li_set_hidessn > 0 AND ls_report_dw = "d_prf_personal" THEN ls_report_dw = "d_prf_personal_alt" //alfee 12.29.2014	
	ls_mod_string = ls_rtp_object + ".DataObject='" + ls_report_dw + "' " //maha 011508
	
	ls_ret = adw_report.Modify(ls_mod_string)
	if LenA(ls_ret ) > 1 then
		messagebox("Syntax error during modify: "+ ls_mod_string, ls_ret)
	end if

	//Start Code Change ----03.28.2008 #V8 maha
	if method = 'A' then	
		ls_ret = adw_report.Modify( ls_rtp_object + ".width=3290")
		if LenA(ls_ret ) > 1 then
			messagebox("Syntax error during modify:"," report width")
		end if
	end if
	//End Code Change---03.28.2008

	IF ls_arg = "P" THEN
		ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")
	ELSE
     		 ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")	
	END IF
next

//adw_report.Modify()

gnv_appeondb.of_startqueue() //$<add> 02.20.2006 By: Cao YongWang

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<comment> 02.28.2006 By: Liang QingShi

If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Running Profile Report...')//Start Code Change ----02.10.2009 #V92 maha
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )

gnv_appeondb.of_commitqueue()//$<add> 02.20.2006 By: Cao YongWang
adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<add> 02.20.2006 By: Cao YongWang

//Start Code Change ----01.17.2013 #V12 maha
ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
adw_report.Modify( ls_user )
//End Code Change ----01.17.2013 
//
adw_report.setredraw(true)
//
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(28)

adw_report.setredraw(false)
////////////////////////////
FOR i = 1 TO li_row_cnt	
	//
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(2)
	
	ls_rtp_object = "rpt_" + String( i ) 
	ls_temp_name = "d_temprpt_" + String( i )
	
	ls_report_dw = lds_profile_view.GetItemString( i, "cur_dw" )
	IF ls_report_dw = "d_prf_" or ls_report_dw = "d_prf_att_quest_master" or ls_report_dw = "d_prf_personal" or ls_report_dw = "d_prf_personal_alt" THEN//Added by  Nova 10.26.2009
		Continue
	END IF	
//	messagebox(string(i),ls_report_dw)
//	of_create_dwdata(ls_report_dw)
	//modify dw properties
	if PosA(ls_report_dw,'_prf_')>0 then
		li_screen_id = lds_profile_view.GetItemNumber(i, "prf_id")
		ls_reportfrom = 'P'
	else
		li_screen_id = lds_profile_view.GetItemNumber(i, "scr_id")
		ls_reportfrom = 'S'
	end if
//	messagebox('',adw_report.describe(ls_rtp_object+".dataobject"))
	if adw_report.getchild(ls_rtp_object,ldc_dw)= -1 then
		messagebox("Getchild Error: ",ls_rtp_object+"/"+adw_report.describe(ls_rtp_object+".dataobject"))
	end if
//	messagebox(string(i),ldc_dw.rowcount())
	if ldc_dw.rowcount() > 0 then luo_report.of_mod_report_dw(al_prac_id, al_view_id, li_screen_id, ldc_dw, False, ai_facility_id,ls_report_dw,ls_reportfrom,ai_profile_view_id )
     //------------------- APPEON BEGIN -------------------
	//$<add> Stephen 03.28.2013
	//$<reason> Bug 3467 Profile Personal with Photo is not populating
	if ls_report_dw = 'd_prf_personal_w_photo' then
		long ll_r
		string ll_path
		for ll_r = 1 to  ldc_dw.rowcount()
			ll_path =  ldc_dw.getitemstring(ll_r, "photo_pathname")
			if not fileexists(ll_path) then
				of_photo_download(al_prac_id)				
			end if
			
		next
	end if
	//------------------- APPEON BEGIN -------------------
next
//
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//////////////////////////
//debugbreak()
//Change fullname in profile header -alfee 12.28.2014
IF li_set_fullname = 1 THEN
	IF adw_report.getchild('rpt_header',ldc_dw)= -1 THEN
		messagebox("Getchild Error: ","rpt_header/"+adw_report.describe("rpt_header.dataobject"))
	ELSE
		//ls_expression = '"Profile for " +  Trim(v_full_name_first_name) + " " +  Trim(v_full_name_middle_name) + " " + Trim(v_full_name_last_name) +", " +  Trim(v_full_name_prof_suffix)'
		ls_expression = '"Profile for " +  if(isNull(v_full_name_first_name), " ", Trim(v_full_name_first_name) + " " ) +   if(isNull(v_full_name_middle_name), "", Trim(v_full_name_middle_name) + " " ) +  if(isNull(v_full_name_last_name), " ", Trim(v_full_name_last_name))  +  if(isNull(v_full_name_prof_suffix), "", ", " + Trim(v_full_name_prof_suffix)) ' //alfee 02.04.2015		
		ls_ret = ldc_dw.Modify("compute_2.Expression='" + ls_expression  + "'")
		//ldc_dw.Object.compute_2.Expression = ls_expression
	END IF
END IF

//Start Code Change ----12.21.2011 #V11 maha - Hide some of the header firlds of App or SK
if gs_cust_type = "I" then 
	adw_report.getchild("rpt_header",ldc_dw)
	
	ldc_dw.modify("compute_4.visible = false")
	ldc_dw.modify("date_comm_review_completed.visible = false")
	ldc_dw.modify("staff_cat.visible = false")
	ldc_dw.modify("t_ititial.visible = false")
	ldc_dw.modify("inital_appmnt_date.visible = false")
	//additional SK objects to hide
	if gb_sk_ver then
		ldc_dw.modify("t_app_dates.visible = false")
		ldc_dw.modify("apptmnt_start_date.visible = false")
		ldc_dw.modify("compute_3.visible = false")
		ldc_dw.modify("apptmnt_end_date.visible = false")

		ldc_dw.modify("t_apptype.visible = false")
		ldc_dw.modify("appt_type.visible = false")
	end if		
end if
//End Code Change ----12.21.2011

adw_report.setredraw(true)
IF ai_print_peer_review_profile  THEN
	of_peer_review_profile ( al_prac_id, ai_facility_id )
END IF

if isvalid(lds_profile_view) then destroy lds_profile_view //2007.7.18 By Jervis
if isvalid( luo_report) then destroy  luo_report


Return 0

//from PowerBuilder journal
//Nested Reports and the getchild() Method
//Earlier, I mentioned that report objects nested within a DataWindow are not DataWindow children, thus any call to getchild() will fail. 
//There is a way around this. In the source editor, open the base DataWindow and change "processing=0" (or whatever it is) to "processing=5". 
//This is the actual trick to change the base DataWindow's presentation style to "composite". 
//The getchild function can now be used to access the nested report. 
//
//This is a cool trick because it opens up all methods that can be called for DataWindow children. 
//A drawback of this method is that since the base DataWindow's presentation style has been changed to composite
//and composite windows have no data source, the base DataWindow's data source cannot be changed unless processing
//is changed back from "5". Also, it should be pointed out that the above technique is not supported by Sybase and should be used
//with extreme caution. 
//
end function

public function integer of_profile_report_v8 (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile, datawindow adw_profile_syn, long al_view_id, boolean ab_msg);//====================================================================
//$<Function>: of_profile_report_v8
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: add ab_msg -shield w_appeon_gifofwait
//$<Author>: (Appeon) Stephen 10.22.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


Integer i,j
Integer li_row_cnt
integer li_report_id
integer li_screen_id
integer li_view_id
integer pos1
integer pos2
integer ret
n_ds lds_profile_view
string ls_facility_name
string ls_syntax
blob lb_syntax
string ls_rtp_object
String ls_report_dw
String ls_retval
string ErrorBuffer
string ls_ret
Long ll_dept_code  
long ll_count[]
datawindowchild ldwc_child
long ll_y,ll_ret
long ll_len
string ls_mod_string
string ls_temp_name
string ls_screen
string method = 'A'
string ls_arg
string ls_reportfrom
string ls_user //maha 01.17.2012
datawindowchild	ldc_dw
pfc_cst_nv_data_entry_functions	luo_report

//notes on methods
//A = syntax is set in the screen painter.  Modfied here for retrieval arguments
//B = screen painter set view and screen.  Syntax is generated here and modified here
//C = syntax created as in A, but does not use the libraryimport method of A&B; rather sets the syntax of the subreport directly
//		which should not be possible		
//

al_view_id = 1 //Alfee 02.16.2009

if ab_msg then
	If Not Isvalid(w_appeon_gifofwait) Then 
		Open(w_appeon_gifofwait)
	End If
end if
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Running Profile Report...')
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(10)

luo_report = create pfc_cst_nv_data_entry_functions
luo_report.ib_report = true
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Getting Profile Screen Data...')  //Start Code Change ----02.10.2009 #V92 maha
luo_report.of_setup_cache()


adw_report.dataobject = "d_prf_master"

lds_profile_view = CREATE n_ds
lds_profile_view.DataObject = "d_profile_report_list_new"
lds_profile_view.of_SetTransObject( SQLCA )

//make all reports invisible
FOR i = 1 TO 51 //42 to 50 maha 012507
	adw_report.Modify('rpt_' + String( i ) + '.Visible="0"')
	adw_report.Modify('rpt_' + String( i ) + '.DataObject="" ')	
END FOR
adw_report.Modify("DataWindow.Detail.Height='10'")// For blank page on report  Added by Nova 02.12.2009
adw_report.setredraw(false)
li_row_cnt = lds_profile_view.Retrieve(al_view_id, ai_profile_view_id )
//Added by Alan on 16.10.2008
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Creating Profile Screens...')  //Start Code Change ----02.10.2009 #V92 maha
app_filler.ids_report_fields_cache.Retrieve(al_view_id,ai_profile_view_id)
app_filler.ids_report_objects_cache.Retrieve(al_view_id,ai_profile_view_id)
app_filler.ids_screen_report_objects_cache.Retrieve(al_view_id,ai_profile_view_id)

//debugbreak()
FOR i = 1 TO li_row_cnt
	
	ls_rtp_object = "rpt_" + String( i ) 
	ls_temp_name = "d_temprpt_" + String( i )
	
	//ls_report_dw = lds_profile_view.GetItemString( i, "report_dw" )
	li_report_id =  lds_profile_view.GetItemnumber( i, "report_id" )
	ls_arg = trim(lds_profile_view.GetItemString( i , "retrieval_aruments" ))
	
	//for each report in the profile, make it visible
	ls_ret = adw_report.Modify(ls_rtp_object + ".Visible='1'")
	
	ls_report_dw = lds_profile_view.GetItemString( i, "cur_dw" )
	IF ls_report_dw = "d_prf_" THEN
		Continue
	END IF	
	ls_mod_string = ls_rtp_object + ".DataObject='" + ls_report_dw + "' " //maha 011508
	
	ls_ret = adw_report.Modify(ls_mod_string)
	if LenA(ls_ret ) > 1 then
		messagebox("Syntax error during modify: "+ ls_mod_string, ls_ret)
	end if

	//Start Code Change ----03.28.2008 #V8 maha
	if method = 'A' then	
		ls_ret = adw_report.Modify( ls_rtp_object + ".width=3290")
		if LenA(ls_ret ) > 1 then
			messagebox("Syntax error during modify:"," report width")
		end if
	end if
	//End Code Change---03.28.2008

	IF ls_arg = "P" THEN
		ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" +String(al_prac_id) + "~"))")
	ELSE
     		 ls_ret = adw_report.Modify(ls_rtp_object + ".Nest_Arguments=((~"" + String(ai_facility_id) + "~"),(~"" +String(al_prac_id) + "~"))")	
	END IF
next

//adw_report.Modify()

gnv_appeondb.of_startqueue() //$<add> 02.20.2006 By: Cao YongWang

//\/maha081700
select facility_name into
:ls_facility_name
from facility
where facility_id = :ai_facility_id;

adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<comment> 02.28.2006 By: Liang QingShi

If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Running Profile Report...')//Start Code Change ----02.10.2009 #V92 maha
adw_report.of_SetTransObject( SQLCA )
adw_report.Retrieve( ai_facility_id, al_prac_id )

gnv_appeondb.of_commitqueue()//$<add> 02.20.2006 By: Cao YongWang
adw_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" ) //$<add> 02.20.2006 By: Cao YongWang

//Start Code Change ----01.17.2013 #V12 maha
ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
adw_report.Modify( ls_user )
//End Code Change ----01.17.2013 
//
adw_report.setredraw(true)
//
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(28)

adw_report.setredraw(false)
////////////////////////////
FOR i = 1 TO li_row_cnt	
	//
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(2)
	
	ls_rtp_object = "rpt_" + String( i ) 
	ls_temp_name = "d_temprpt_" + String( i )
	
	ls_report_dw = lds_profile_view.GetItemString( i, "cur_dw" )
	IF ls_report_dw = "d_prf_" or ls_report_dw = "d_prf_att_quest_master" or ls_report_dw = "d_prf_personal" or ls_report_dw = "d_prf_personal_alt" THEN//Added by  Nova 10.26.2009
		Continue
	END IF	
//	messagebox(string(i),ls_report_dw)
//	of_create_dwdata(ls_report_dw)
	//modify dw properties
	if PosA(ls_report_dw,'_prf_')>0 then
		li_screen_id = lds_profile_view.GetItemNumber(i, "prf_id")
		ls_reportfrom = 'P'
	else
		li_screen_id = lds_profile_view.GetItemNumber(i, "scr_id")
		ls_reportfrom = 'S'
	end if
//	messagebox('',adw_report.describe(ls_rtp_object+".dataobject"))
	if adw_report.getchild(ls_rtp_object,ldc_dw)= -1 then
		messagebox("Getchild Error: ",ls_rtp_object+"/"+adw_report.describe(ls_rtp_object+".dataobject"))
	end if
//	messagebox(string(i),ldc_dw.rowcount())
	if ldc_dw.rowcount() > 0 then luo_report.of_mod_report_dw(al_prac_id, al_view_id, li_screen_id, ldc_dw, False, ai_facility_id,ls_report_dw,ls_reportfrom,ai_profile_view_id )
     //------------------- APPEON BEGIN -------------------
	//$<add> Stephen 03.28.2013
	//$<reason> Bug 3467 Profile Personal with Photo is not populating
	if ls_report_dw = 'd_prf_personal_w_photo' then
		long ll_r
		string ll_path
		for ll_r = 1 to  ldc_dw.rowcount()
			ll_path =  ldc_dw.getitemstring(ll_r, "photo_pathname")
			if not fileexists(ll_path) then
				of_photo_download(al_prac_id)				
			end if
			
		next
	end if
	//------------------- APPEON BEGIN -------------------
next
//
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
//////////////////////////

//Start Code Change ----12.21.2011 #V11 maha - Hide some of the header firlds of App or SK
if gs_cust_type = "I" then 
	adw_report.getchild("rpt_header",ldc_dw)
	
	ldc_dw.modify("compute_4.visible = false")
	ldc_dw.modify("date_comm_review_completed.visible = false")
	ldc_dw.modify("staff_cat.visible = false")
	ldc_dw.modify("t_ititial.visible = false")
	ldc_dw.modify("inital_appmnt_date.visible = false")
	//additional SK objects to hide
	if gb_sk_ver then
		ldc_dw.modify("t_app_dates.visible = false")
		ldc_dw.modify("apptmnt_start_date.visible = false")
		ldc_dw.modify("compute_3.visible = false")
		ldc_dw.modify("apptmnt_end_date.visible = false")

		ldc_dw.modify("t_apptype.visible = false")
		ldc_dw.modify("appt_type.visible = false")
	end if
		
end if
//End Code Change ----12.21.2011

adw_report.setredraw(true)
IF ai_print_peer_review_profile  THEN
	of_peer_review_profile ( al_prac_id, ai_facility_id )
END IF

if isvalid(lds_profile_view) then destroy lds_profile_view //2007.7.18 By Jervis
if isvalid( luo_report) then destroy  luo_report


Return 0

//from PowerBuilder journal
//Nested Reports and the getchild() Method
//Earlier, I mentioned that report objects nested within a DataWindow are not DataWindow children, thus any call to getchild() will fail. 
//There is a way around this. In the source editor, open the base DataWindow and change "processing=0" (or whatever it is) to "processing=5". 
//This is the actual trick to change the base DataWindow's presentation style to "composite". 
//The getchild function can now be used to access the nested report. 
//
//This is a cool trick because it opens up all methods that can be called for DataWindow children. 
//A drawback of this method is that since the base DataWindow's presentation style has been changed to composite
//and composite windows have no data source, the base DataWindow's data source cannot be changed unless processing
//is changed back from "5". Also, it should be pointed out that the above technique is not supported by Sybase and should be used
//with extreme caution. 
//
end function

public function string of_get_report_filter ();//====================================================================
//$<Function>: of_get_report_filter
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  String
//$<Description>: get filter of Standard reports
//$<Author>: (Appeon) Harry 11.20.2013 (V141 )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_filter
integer i
integer priv
integer meet
integer appmap
integer peer
integer ctx
integer cnt
string s

if gb_contract_version then
	ls_filter = "Lower(r_type) = 'x'"
	Return ls_filter
end if


//$<ID> PT-01
//$<modify> 02.13.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*select set_34,set_priv,set_meetings,set_iapps,set_peer into :i,:priv,:meet,:appmap,:peer from icred_settings;*/
//Start Code Change ----11.02.2010 #V10 maha - rebuilt filter code based on program setting
//i = Integer( gnv_data.of_GetItem( "icred_settings", "set_34", False ))
i = Integer( gnv_data.of_GetItem( "icred_settings", "set_9", False ))
priv = Integer( gnv_data.of_GetItem( "icred_settings", "set_priv", False ))
meet = Integer( gnv_data.of_GetItem( "icred_settings", "set_meetings", False ))
appmap = Integer( gnv_data.of_GetItem( "icred_settings", "set_iapps", False ))
peer = Integer( gnv_data.of_GetItem( "icred_settings", "set_peer", False ))
ctx = Integer( gnv_data.of_GetItem( "icred_settings", "set_cont", False ))
//---------------------------- APPEON END ----------------------------

//if i > 0 then  //maha 100404 filtering reports based on program settings
s = "('D'"

choose case i
	case 0 //cred
		 s = s + ",'C','B','M'"
		if appmap = 1 then s = s + ",'A'"
	case 1 //app
		 s = s + ",'A','B','M'"
	case 2 //se
		 s = s + ",'C'"
	case 3 //credapp
		 s = s + ",'C','B','A','M'"
	case 4 //ctx
		s = s + ",'X'"
	case 5 //SK
		 s = s + ",'A','B'"
end choose
		
	
if i <> 4 then //if not contracts
	if priv = 1 then s = s + ",'P'"
	if peer = 1 then s = s + ",'R'"
	if ctx  = 1 then s = s + ",'X'"
end if
		
s = s + ")"

ls_filter = "upper(r_type) in " + s

	
Return ls_filter
end function

public function integer of_activity_report (n_ds ads_reports);//Start Code Change ----10.03.2017 #V16 maha
integer r
integer rc
string ls_query
string ls_table
string ls_table_sql



ads_reports.setfilter("report_order > 0") 
ads_reports.filter()
ads_reports.setsort("report_order ASC") 
ads_reports.sort()

rc = ads_reports.rowcount()

if rc < 1 then return 0

ls_table = string(time(now()))
ls_table = "activity" + ls_table

ls_table_sql = "Create table " + ls_table + "( user_id varchar(50), "

for r = 1 to rc
	
next


return 1
end function

on pfc_cst_u_reports.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_u_reports.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//Add 2007.7.19 By Jervis
//Destroy  an object instance
if isvalid(ids_column_data) then destroy ids_column_data
if isvalid(ids_sort_data) then destroy ids_sort_data
if isvalid(ids_table_data) then destroy ids_table_data
if isvalid(ids_link_data) then destroy ids_link_data
if isvalid(ids_filter_data) then destroy ids_filter_data
if isvalid(ids_header_data) then destroy ids_header_data
//End 
end event

