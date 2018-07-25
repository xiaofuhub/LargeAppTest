$PBExportHeader$pfc_cst_u_reports4.sru
forward
global type pfc_cst_u_reports4 from nonvisualobject
end type
end forward

global type pfc_cst_u_reports4 from nonvisualobject
end type
global pfc_cst_u_reports4 pfc_cst_u_reports4

forward prototypes
public function integer of_quick_ver (long al_prac_id, w_report aw_report_win)
public function integer of_custom_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id)
public function integer of_peer_review_profile (long al_prac_id, integer ai_facility_id)
public function integer of_profile_report (u_dw adw_report, integer ai_facility_id, long al_prac_id, integer ai_profile_view_id, boolean ai_print_peer_review_profile)
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

FOR i = 1 TO 45
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


Return 0
end function

on pfc_cst_u_reports4.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_u_reports4.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

