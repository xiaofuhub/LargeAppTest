$PBExportHeader$w_letter_generator.srw
$PBExportComments$[letters.pbl]
forward
global type w_letter_generator from w_main
end type
type tab_ltr from tab within w_letter_generator
end type
type tabpage_criteria from userobject within tab_ltr
end type
type cb_search from commandbutton within tabpage_criteria
end type
type st_help_text from statictext within tabpage_criteria
end type
type cb_prior from u_cb within tabpage_criteria
end type
type dw_criteria from u_dw within tabpage_criteria
end type
type cb_batch from commandbutton within tabpage_criteria
end type
type gb_filter from groupbox within tabpage_criteria
end type
type ddplb_filter from dropdownpicturelistbox within tabpage_criteria
end type
type dw_criteria_box from u_dw within tabpage_criteria
end type
type dw_letter from u_dw within tabpage_criteria
end type
type dw_wizard_seq from u_dw within tabpage_criteria
end type
type st_1 from statictext within tabpage_criteria
end type
type dw_1 from u_dw within tabpage_criteria
end type
type cb_next from u_cb within tabpage_criteria
end type
type dw_corro from u_dw within tabpage_criteria
end type
type dw_select_report from u_dw within tabpage_criteria
end type
type tabpage_criteria from userobject within tab_ltr
cb_search cb_search
st_help_text st_help_text
cb_prior cb_prior
dw_criteria dw_criteria
cb_batch cb_batch
gb_filter gb_filter
ddplb_filter ddplb_filter
dw_criteria_box dw_criteria_box
dw_letter dw_letter
dw_wizard_seq dw_wizard_seq
st_1 st_1
dw_1 dw_1
cb_next cb_next
dw_corro dw_corro
dw_select_report dw_select_report
end type
type tab_ltr from tab within w_letter_generator
tabpage_criteria tabpage_criteria
end type
type cb_close from commandbutton within w_letter_generator
end type
end forward

global type w_letter_generator from w_main
integer x = 5
integer y = 224
integer width = 3570
integer height = 1928
string title = "Provider Correspondence Generator"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
tab_ltr tab_ltr
cb_close cb_close
end type
global w_letter_generator w_letter_generator

type variables
Boolean ib_fax_num_email_search = False
Boolean ib_from_net_dev = False
Boolean ib_from_prac_folder=True
Boolean ib_from_case_review = False
boolean ib_qa_letter // mskinner 16 nov 2004


pfc_cst_u_reports inv_reports

Integer il_current_wizard_step = 0
Integer il_wizard_step_cnt = 0
Integer il_facility_ids_all[]
Integer ii_app_ids[]
Integer il_facility_id
Integer il_profile_view_id
Integer ii_letter_id
integer ii_batch_button

Decimal 	idec_case_number
Long 		il_prac_ids[]
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.24.2006 By: Jervis
//$<reason> 
//Long il_action_type[]
//Long il_action_status[]
//---------------------------- APPEON END ----------------------------

Date id_from
Date id_to

String is_facility_name



////////////////////////////////////////////
n_ds ids_physician
long il_header_id
long il_action_to
str_pass istr_pass

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.24.2006 By: Jervis
//$<reason> 
boolean ib_corro_flag = false
u_dw idw_action_item
//---------------------------- APPEON END ----------------------------
str_dashboard str_para

Boolean ib_auto_locate
end variables

forward prototypes
public function integer of_wizard (string as_direction)
public function integer of_run ()
public function integer of_app_rcvd_prac ()
public function integer of_case_review_letter (long al_prac_ids[], decimal aldec_case_number, integer ai_facility_id)
public function integer of_fax_num_email_search ()
public function long of_quality_profile_letter (long al_prac_id, long al_header_id, long al_facility_id)
public subroutine of_add_record ()
public function integer of_copy_file ()
public function integer of_filter_child_dw (string as_data)
public function string of_qa_letter_merge (string as_path)
public function integer of_print_corro ()
public function integer of_net_dev_ltr (long al_prac_id[], integer ai_facility_ids[], integer ai_app_ids[], u_dw adw_printed)
public function integer of_run_export (long ai_pracs[], integer ai_exp_id, ref string as_path)
public subroutine of_dashboard (long ai_id)
end prototypes

public function integer of_wizard (string as_direction);String ls_wizard_dw
String ls_last_wizard
String ls_val
Integer li_rc
Integer li_found
Integer i
Integer li_dummy_array[]
integer li_facility_id
DataWindowChild dwchild

tab_ltr.tabpage_criteria.ddplb_filter.Visible = False	
tab_ltr.tabpage_criteria.gb_filter.Visible = False
tab_ltr.tabpage_criteria.cb_search.Visible = False
tab_ltr.tabpage_criteria.cb_batch.Visible = False

tab_ltr.tabpage_criteria.dw_criteria.AcceptText()

IF as_direction = "Next" AND il_current_wizard_step > 0 THEN
	

	CHOOSE CASE tab_ltr.tabpage_criteria.dw_criteria.DataObject
		CASE "d_crit_date_range"
			id_from = tab_ltr.tabpage_criteria.dw_criteria.GetItemDate( 1, "from_date" )
			id_to = tab_ltr.tabpage_criteria.dw_criteria.GetItemDate( 1, "to_date" )
			IF IsNull( id_from ) THEN
				MessageBox( "Required Data", "You must enter in a From Date." )
				Return -1
			ELSEIF IsNull( id_to ) THEN
				MessageBox( "Required Data", "You must enter in a To Date." )
				Return -1
			END IF
			tab_ltr.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()
		
		CASE "d_crit_pracs"
			IF tab_ltr.tabpage_criteria.dw_criteria.RowCount() = 0 THEN
				MessageBox("Selection Error", "You must select at least one Provider." )
				tab_ltr.tabpage_criteria.cb_search.Visible = true
				Return -1
			END IF

		CASE "d_crit_org_facility"

			tab_ltr.tabpage_criteria.dw_criteria.GetChild( "facility_id", dwchild )		
			//---------Begin Commented by (Appeon)Toney 05.31.2013 for V141 ISG-CLX--------
			//$Reason:Fix History BugT111402
			  /*
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( gs_user_id )
			 */
			//---------End Commented ------------------------------------------------------
			ls_val = tab_ltr.tabpage_criteria.dw_criteria.GetText()  
			IF ls_val = "" OR IsNull( ls_val ) OR ls_val = "0" THEN//(Appeon)Toney 11.19.2013 - V141 ISG-CLX,Fix History BugT111402,append condition ls_val="0"
				MessageBox("Selection Error", "You must select a specific Facility. ")
				Return -1
			ELSE
				il_facility_id = tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( 1, "facility_id" )			
				li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
				IF li_found > 0 THEN
					is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
				END IF
			END IF
			IF tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN				 
				il_facility_ids_all = li_dummy_array
				IF il_facility_id = 0 THEN
					li_rc = dwchild.RowCount()
					FOR i = 2 TO li_rc
						il_facility_ids_all[i] = dwchild.GetItemNumber( i, "facility_id" )
					END FOR
					is_facility_name = "All"					
				ELSE
					il_facility_ids_all[1] = il_facility_id
					li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
					IF li_found > 0 THEN
						is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
					END IF
				END IF
			END IF
	
		CASE "d_crit_profile_view"

			ls_val = tab_ltr.tabpage_criteria.dw_criteria.GetText()  
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a Profile View. ")
				Return -1
			ELSE
				il_profile_view_id = tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( 1, "profile_view_id" )				
			END IF

	END CHOOSE

	IF	tab_ltr.tabpage_criteria.cb_next.Text = "Run" THEN
		of_run()
		Return 0
	END IF

END IF


IF as_direction = "Next" THEN
	il_current_wizard_step = il_current_wizard_step + 1
ELSE
	il_current_wizard_step = il_current_wizard_step - 1
END IF

//tab_ltr.tabpage_criteria.cb_search.Visible = False
//tab_ltr.tabpage_criteria.cb_batch.Visible = False

ls_last_wizard = tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "wizard_last_step" )
ls_wizard_dw = tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "wizard_dw" )
tab_ltr.tabpage_criteria.dw_criteria.DataObject = ls_wizard_dw
tab_ltr.tabpage_criteria.dw_criteria.Reset()
tab_ltr.tabpage_criteria.dw_criteria.of_SetTransObject( SQLCA )
tab_ltr.tabpage_criteria.st_help_text.Text = tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString(il_current_wizard_step , "help_text" )
IF tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
	tab_ltr.tabpage_criteria.dw_criteria.InsertRow( 0 )
END IF
IF ls_wizard_dw = "d_crit_date_range" THEN
	tab_ltr.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_ltr.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_ltr.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
ELSEIF ls_wizard_dw = "d_crit_pracs" THEN
	tab_ltr.tabpage_criteria.gb_filter.Visible = True
	tab_ltr.tabpage_criteria.ddplb_filter.Visible = True
	IF not gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
		tab_ltr.tabpage_criteria.cb_batch.Visible = True
	end if
	tab_ltr.tabpage_criteria.cb_search.Visible = True
	tab_ltr.tabpage_criteria.dw_criteria.Title = "Select Provider"
ELSEIF ls_wizard_dw = "d_crit_org_facility" THEN
	tab_ltr.tabpage_criteria.dw_criteria.GetChild( "facility_id", dwchild )				
	dwchild.SetTransObject( SQLCA )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<add> 02.09.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------
	dwchild.Retrieve( gs_user_id )
	//code modified maha 081403 to get default facility
	SELECT security_users.default_search_facility  
	INTO :li_facility_id  
	FROM security_users  
	WHERE security_users.user_id = :gs_user_id;
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<add> 02.08.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
	IF  li_facility_id > 0 THEN //set user default facility
		tab_ltr.tabpage_criteria.dw_criteria.SetItem( 1, "facility_id", li_facility_id )
		il_facility_id = li_facility_id
	else
		dwchild.InsertRow(1)
		dwchild.SetItem( 1, "facility_id", 0 )
	end if

END IF

IF il_current_wizard_step = 1 THEN
	tab_ltr.tabpage_criteria.cb_prior.Enabled = False
ELSE
	tab_ltr.tabpage_criteria.cb_prior.Enabled = True
END IF


IF il_current_wizard_step = il_wizard_step_cnt  THEN
//	IF tab_ltr.tabpage_criteria.rb_fax.Checked = True THEN
//			tab_ltr.tabpage_criteria.cb_next.Text = "Fax"
//	ELSEIF tab_ltr.tabpage_criteria.rb_email.Checked THEN
//		tab_ltr.tabpage_criteria.cb_next.Text = "Email"
//	ELSE
		tab_ltr.tabpage_criteria.cb_next.Text = "Run"
//END IF
ELSE
	tab_ltr.tabpage_criteria.cb_next.Text = "Next->"
END IF

tab_ltr.tabpage_criteria.dw_criteria.SetFocus()

Return 0

end function

public function integer of_run ();

// MSKINNER COMMENTED OUT THE -- /mmail_labels PORTION OF THE STRING

Integer li_ans
Integer e
Integer li_error_cnt
Integer li_prc
Integer p
Integer li_case_review_letter_type
Integer li_row_cnt
Integer li_cr
Integer i
Integer i2
Integer i3
Integer li_check
Integer li_nr
Integer li_num_pracs
Long ll_seq_no
Integer li_response_required
Integer li_export_id //maha 073002
Integer li_export_on = 0 //maha 022505
String ls_exportname //maha 022505
Long ll_severity_grade
Long ll_prac_corro
Long nulllong
Long ll_ver_response
Long ll_prac_id
Long ll_prac_id_check
Long ll_prac_exp[]  //maha 05.05.2015
Long ll_rec_id
Long ll_empty_pracs[] //maha 030306
String ls_severity_grade_desc
String ls_letter_type
String ls_full_name
String ls_doc_name
String ls_letter_path
String ls_letter_name
String ls_word_path
String ls_open_merge
String ls_doc_id
String ls_run_path
Integer res
DateTime nulldate

Integer li_set6
String ls_from
String ls_to
String ls_file_name
Integer wer, li_col

Long ll_loop_count
Boolean lb_error_rec

String ls_doc_name_nopath //Ken.Guo 11/01/2007
window activesheet //Added by  Nova 02.24.2010
activesheet = w_mdi.GetActiveSheet()

SetNull( nulldate )
SetNull( nulllong )

gl_export_rows_count = 0  //Start Code Change ----05.06.2015 #V15 maha - part of export rows trap

//Start Code Change ---- 03.03.2006 # maha
IF Not ib_qa_letter And Not ib_from_case_review And Not ib_from_net_dev THEN //Start Code Change ---- 05.05.2006 #446 maha
	il_prac_ids = ll_empty_pracs
END IF
tab_ltr.tabpage_criteria.dw_letter.Reset()
//End Code Change---03.03.2006
li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
//<add> 08/03/2007 by: Andy Reason:BugJ080204
//If li_cr equal 0,the system will crash
IF li_cr < 1 THEN RETURN failure
//end of add

//Start Code Change ---- 01.23.2006 #214 maha
//gs_save_path = gs_dir_path + "Intellicred\Standard\Letters\"
//debugbreak()
ls_run_path = of_letter_paths("L")
ls_open_merge = of_letter_paths("D")
//End Code Change---01.23.2006 


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Cao YongWang
//$<modification> Create the downloading directory if it does not exist.

n_appeon_storage_area lnv_storage_area
n_appeon_download lnv_download
IF gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' Or &
	Upper( appeongetclienttype() ) = 'WEB' THEN
	lnv_download.of_parsepath( ls_open_merge)
END IF
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////// //
// mskinner 16 Nov 2004 -- begin
IF ib_qa_letter THEN
	//Start Code Change ---- 10.03.2006 #646 maha
	ls_open_merge = of_qa_letter_merge(ls_open_merge)
	IF ls_open_merge = "fail" THEN
		MessageBox(This.Title, 'No doctor was returned for this report. Please check to see if an mailing address was selected.')
		RETURN failure
	END IF
	//End Code Change---10.03.2006
ELSE
	
	IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_module" ) = 2 THEN
		// start code change --- 11.04.2005 MSKINNER
		li_case_review_letter_type =  tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_destination" )
		// end code change --- 11.04.2005 MSKINNER
		CHOOSE CASE li_case_review_letter_type
		//Practitioner Letter
			CASE 1
				IF UpperBound( il_prac_ids[] ) = 0 THEN
					MessageBox("Selection Error", "There were no physicians selected.  Please select the physicians to which you want to send a letter, from the Attributing Physicians list on the Case Information tab." ) //Start Code Change ---- 05.05.2006 #447 maha corrected message
					RETURN -1
				END IF
				ls_letter_type = "Practitioner"
				tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_case_ltr_physician"
				tab_ltr.tabpage_criteria.dw_letter.of_SetTransObject( SQLCA )
				li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.Retrieve( idec_case_number, il_prac_ids )
				//Committee Letter
			CASE 2
				ls_letter_type = "Committee"
				tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_case_ltr_committee"
				tab_ltr.tabpage_criteria.dw_letter.of_SetTransObject( SQLCA )
				tab_ltr.tabpage_criteria.dw_letter.Retrieve( )
				tab_ltr.tabpage_criteria.dw_letter.SetFilter( "case_number = " + String(  idec_case_number ) )
				tab_ltr.tabpage_criteria.dw_letter.Filter( )
				li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.RowCount( )
				FOR i = 1 To li_row_cnt
					//--------Begin Modified by  Nova 02.24.2010------------------------
					//	li_prc = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
					IF IsValid(activesheet) THEN
						IF  activesheet.Tag = 'Case/Peer Review'  THEN
							li_prc = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
						ELSEIF  activesheet.Tag = 'Quality Profiles' THEN
							li_prc = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
						END IF
					ELSE
						RETURN -1
					END IF
					//--------End Modified --------------------------------------------
					FOR p = 1 To li_prc
						//--------Begin Modified by  Nova 02.24.2010------------------------
						//	ll_severity_grade = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
						//	ll_prac_id =  w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
						IF IsValid(activesheet) THEN
							IF  activesheet.Tag = 'Case/Peer Review'  THEN
								ll_severity_grade = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
								ll_prac_id =  w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
							ELSEIF  activesheet.Tag = 'Quality Profiles' THEN
								ll_severity_grade = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
								ll_prac_id = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
							END IF
						ELSE
							RETURN -1
						END IF
						
						SELECT description Into :ls_severity_grade_desc From code_lookup Where lookup_code = :ll_severity_grade;
						SELECT full_name Into :ls_full_name From v_full_name Where prac_id = :ll_prac_id;
						tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "other_attributing_doctor_" + String( p ), ls_full_name )
						tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "other_attributing_severity_grade_" + String( p ), ls_severity_grade_desc )
					NEXT
				NEXT
				//Department Chair Letter
			CASE 3
				ls_letter_type = "Depart Chair"
				tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_case_ltr_dept_chair"
				tab_ltr.tabpage_criteria.dw_letter.of_SetTransObject( SQLCA )
				tab_ltr.tabpage_criteria.dw_letter.Retrieve( )
				tab_ltr.tabpage_criteria.dw_letter.SetFilter( "case_number = " + String(  idec_case_number ) )
				tab_ltr.tabpage_criteria.dw_letter.Filter( )
				li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.RowCount( )
				FOR i = 1 To li_row_cnt
					//--------Begin Modified by  Nova 02.24.2010------------------------
					//	li_prc = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
					IF IsValid(activesheet) THEN
						IF  activesheet.Tag = 'Case/Peer Review'  THEN
							li_prc = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
						ELSEIF  activesheet.Tag = 'Quality Profiles' THEN
							li_prc = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.RowCount( )
						END IF
					ELSE
						RETURN -1
					END IF
					//--------End Modified --------------------------------------------
					FOR p = 1 To li_prc
						//--------Begin Modified by  Nova 02.24.2010------------------------
						//	ll_severity_grade = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
						//	ll_prac_id =  w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
						IF IsValid(activesheet) THEN
							IF  activesheet.Tag = 'Case/Peer Review'  THEN
								ll_severity_grade = w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
								ll_prac_id =  w_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
							ELSEIF  activesheet.Tag = 'Quality Profiles' THEN
								ll_severity_grade = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "severity_grade" )
								ll_prac_id = w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.GetItemNumber( p, "prac_id" )
							END IF
						ELSE
							RETURN -1
						END IF
						SELECT description Into :ls_severity_grade_desc From code_lookup Where lookup_code = :ll_severity_grade;
						SELECT full_name Into :ls_full_name From v_full_name Where prac_id = :ll_prac_id;
						tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "other_attributing_doctor_" + String( p ), ls_full_name )
						tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "other_attributing_severity_grade_" + String( p ), ls_severity_grade_desc )
					NEXT
				NEXT
		END CHOOSE
		
	END IF
	
	IF tab_ltr.tabpage_criteria.dw_criteria.DataObject = "d_crit_pracs" THEN
		tab_ltr.tabpage_criteria.dw_criteria.SetSort( "full_name" )
		tab_ltr.tabpage_criteria.dw_criteria.Sort( )
		li_num_pracs = tab_ltr.tabpage_criteria.dw_criteria.RowCount()
		FOR i = 1 To li_num_pracs
			il_prac_ids[i] = tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( i, "prac_id" )
		NEXT
	END IF
	
	//Credentialing Application Signature Follow up letter
	CHOOSE CASE tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( tab_ltr.tabpage_criteria.dw_select_report.GetRow( ), "letter_id" )
	//Credentialing Application Signature Follow up letter( INDIVIDUAL PRACTITIONER)
		CASE 1001
			tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac"
			//Credentialing Application Signature Follow up letter( ALL PRACTITIONERS)		
		CASE 1002
			tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac_all"
			//Payer Follow up Letter (Individual)
		CASE 1003
			tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_payer"
			//Payer Follow up Letter (Individual)		
		CASE 1004
			tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_payer_all"
	END CHOOSE //default is "d_ltr_general_corrospondence"
	
	
	
	CHOOSE CASE tab_ltr.tabpage_criteria.dw_letter.DataObject
		CASE "d_ltr_general_corrospondence", "d_ltr_net_dev"
			tab_ltr.tabpage_criteria.dw_letter.of_SetTransObject( SQLCA )
			li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.Retrieve( il_facility_id, il_prac_ids, gs_user_id )   //Start Code Change ----02.02.2017 #V153 maha - added user fields
		CASE "d_ltr_net_dev_app_rcvd_prac", "d_ltr_net_dev_app_rcvd_payer"
			tab_ltr.tabpage_criteria.dw_letter.of_SetTransObject( SQLCA )
			tab_ltr.tabpage_criteria.dw_letter.Retrieve( il_prac_ids, il_facility_ids_all, ii_app_ids, gs_user_id )  //Start Code Change ----02.02.2017 #V153 maha - added user fields
			li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.RowCount( )
			IF li_row_cnt = 0 THEN
				//Start Code Change ----06.22.2016 #V152 maha - cleaned up messaging
				Choose case  tab_ltr.tabpage_criteria.dw_letter.DataObject
					Case "d_ltr_net_dev_app_rcvd_prac"
						MessageBox( "No Data", "No data was returned.~rCheck the following:~r~rYou need to have and Action Type of  APP RCVD PRAC with an action status of INCOMPLETE.~r You need to have a mailing address setup for an Active Address. ")
						RETURN -1
					Case "d_ltr_net_dev_app_rcvd_payer"
						MessageBox( "No Data", "No data was returned.~rCheck the following:~r~rYou need to have and Action Type of  PAR with an action status of INCOMPLETE.~r You need to have a mailing address setup for an Active Address. ")
						RETURN -1
				end choose
				//End Code Change ----06.22.2016
			END IF
			IF tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac" THEN
				of_app_rcvd_prac( )
			END IF
			li_row_cnt = 1
		CASE "d_ltr_net_dev_app_rcvd_prac_all", "d_ltr_net_dev_app_rcvd_payer_all"
			tab_ltr.tabpage_criteria.dw_letter.SetTransObject( SQLCA )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.18.2006 By: Liang QingShi
			//$<reason> Fix a defect.
			IF UpperBound(il_prac_ids) <= 0 THEN il_prac_ids[1] = 0
			IF UpperBound(il_facility_ids_all) <= 0 THEN il_facility_ids_all[1] = 0
			IF UpperBound(ii_app_ids) <= 0 THEN ii_app_ids[1] = 0
			
			//---------------------------- APPEON END ----------------------------
			li_row_cnt = tab_ltr.tabpage_criteria.dw_letter.Retrieve( il_prac_ids, il_facility_ids_all, ii_app_ids, gs_user_id )   //Start Code Change ----02.02.2017 #V153 maha - added user fields
			IF li_row_cnt = 0 THEN
				//Start Code Change ----06.22.2016 #V152 maha - cleaned up messaging
				Choose case  tab_ltr.tabpage_criteria.dw_letter.DataObject
					Case "d_ltr_net_dev_app_rcvd_prac_all"
						MessageBox( "No Data", "No data was returned.~rCheck the following:~r~rYou need to have and Action Type of  APP RCVD PRAC with an action status of INCOMPLETE.~r You need to have a mailing address setup for an Active Address. ")
						RETURN -1
					Case "d_ltr_net_dev_app_rcvd_payer_all"
						MessageBox( "No Data", "No data was returned.~rCheck the following:~r~rYou need to have and Action Type of  PAR with an action status of INCOMPLETE.~r You need to have a mailing address setup for an Active Address. ")
						RETURN -1
				end choose	
				//End Code Change ----06.22.2016
			END IF
			IF tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac_all" THEN
				//tab_ltr.tabpage_criteria.dw_letter.saveas( "c:\jad.txt" , Text!, True )			
				of_app_rcvd_prac( )
			END IF
			li_row_cnt =  tab_ltr.tabpage_criteria.dw_letter.RowCount( )
	END CHOOSE
	
	IF li_row_cnt = 0 THEN
		MessageBox( "Letter Generation Error", "No rows were returned.  Data incomplete for the selected practitioners." )
		RETURN -1
	END IF
	
	//sort the dw_letters table so that the sort matches the criteria table
	IF tab_ltr.tabpage_criteria.dw_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
		tab_ltr.tabpage_criteria.dw_letter.SetSort( "v_full_name_full_name" )
		tab_ltr.tabpage_criteria.dw_letter.Sort( )
	ELSEIF tab_ltr.tabpage_criteria.dw_letter.Describe( "full_name.border" ) <> "!" THEN
		tab_ltr.tabpage_criteria.dw_letter.SetSort( "full_name" )
		tab_ltr.tabpage_criteria.dw_letter.Sort( )
	ELSEIF tab_ltr.tabpage_criteria.dw_letter.Describe( "last_name.border" ) <> "!" THEN
		tab_ltr.tabpage_criteria.dw_letter.SetSort( "last_name" )
		tab_ltr.tabpage_criteria.dw_letter.Sort( )
	ELSE
		li_ans = MessageBox("No full name", "If you plan on using FAXING there must be a v_full_name_full_name or full_name or last_name column included in the letter query for sorting.  If you are not faxing this letter then click YES to continue or if you plan on faxing this letter then contact support.", StopSign!, YesNo!, 1)
		IF li_ans = 2 THEN
			RETURN -1
		END IF
	END IF
	
	//\/maha081600
	FOR i = 1 To li_num_pracs
		li_check = 0
		il_prac_ids[i] = tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( i, "prac_id" )
		ls_full_name = tab_ltr.tabpage_criteria.dw_criteria.GetItemString( i, "full_name" )
		FOR i2 = 1 To li_row_cnt
			ll_prac_id_check = tab_ltr.tabpage_criteria.dw_letter.GetItemNumber( i2, "prac_id" )
			IF il_prac_ids[i] = ll_prac_id_check THEN
				li_check = 1
				ll_prac_exp[upperbound(ll_prac_exp)+ 1] = il_prac_ids[i]     //Start Code Change ----05.05.2015 #V15 maha - prevent export from including provider with inadequare addresses.
				CONTINUE
			END IF
		NEXT
		IF li_check = 0 THEN MessageBox("Data Error", "Unable to create data source for practitioner # " + String(il_prac_ids[i]) + " ("+ ls_full_name +") ~n~r1) Check to see if there is a Mailing address link for the selected facility.~n~r2) Make sure that address is active.~n~r3) Make sure the Appointment Status for this practitioner is active or pending for the selected facility.~n~r4) Be sure the practitioner has a specialty of Primary order.")
	NEXT
	//\maha
	
	il_prac_ids = ll_prac_exp  //Start Code Change ----05.05.2015 #V15 maha - 
	
	//IF tab_ltr.tabpage_criteria.dw_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
	//	tab_ltr.tabpage_criteria.dw_letter.SetSort( "v_full_name_full_name" )
	//ELSE
	//	tab_ltr.tabpage_criteria.dw_letter.SetSort( "full_name" )
	//END IF
	//tab_ltr.tabpage_criteria.dw_letter.Sort( )
	
	IF li_row_cnt = 0 THEN
		MessageBox("Error", "No letters to print.")
		RETURN -1
	ELSE
		//\/maha 073002 check and create export file for merge document 
		IF gi_export_on = 1 THEN //maha 102302
			IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( tab_ltr.tabpage_criteria.dw_select_report.GetRow( ),  "use_export" ) = 1 THEN
				li_export_id = tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( tab_ltr.tabpage_criteria.dw_select_report.GetRow( ), "export_id" )
				res = of_run_export(il_prac_ids[],li_export_id,ls_open_merge)
				IF res < 1 THEN
					MessageBox("Export Error","Failed to create file from export.")
					li_export_on = 0
				ELSE
					//Modify 08/29/2007 by: Andy Reason:ls_open_merge rewrited by of_run_export 
					//select export_name into :ls_exportname from export_header where export_id = :li_export_id;
					li_export_on = 1
					//ls_exportname = ls_open_merge + ls_exportname + ".txt"
					//---------Begin Added by (Appeon)Stephen 02.09.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
					for li_col = 1 to integer(tab_ltr.tabpage_criteria.dw_letter.object.datawindow.column.count)
						if lower(tab_ltr.tabpage_criteria.dw_letter.describe("#" +string(li_col)+".name")) = "prac_id" or lower(tab_ltr.tabpage_criteria.dw_letter.describe("#" +string(li_col)+".name")) = "v_full_name_prac_id" then
							tab_ltr.tabpage_criteria.dw_letter.setsort("prac_id")
							tab_ltr.tabpage_criteria.dw_letter.sort()
							exit
						end if							
					next
					//---------End Added ------------------------------------------------------
				END IF
			END IF
		END IF
		
		IF li_export_on <> 1 THEN //add 08/29/2007 by: Andy
			//\maha
			CHOOSE CASE tab_ltr.tabpage_criteria.dw_letter.DataObject
				CASE "d_ltr_net_dev"
					tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "net_dev_ai.txt", Text!, True )
					ls_open_merge = ls_open_merge + "net_dev_ai.txt"
				CASE "d_ltr_net_dev_app_rcvd_prac", "d_ltr_net_dev_app_rcvd_prac_all"
					tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "net_dev_app_rcvd_prac.txt", Text!, True )
					ls_open_merge = ls_open_merge + "net_dev_app_rcvd_prac.txt"
				CASE "d_ltr_net_dev_app_rcvd_payer", "d_ltr_net_dev_app_rcvd_payer_all"
					tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "net_dev_app_rcvd_payer.txt", Text!, True )
					ls_open_merge = ls_open_merge + "net_dev_app_rcvd_payer.txt"
				CASE ELSE
					// start code change --- 11.01.2005 MSKINNER
					//IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "case_review_letter" ) = 1 THEN			
					IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_module" ) = 2 THEN
						// end change --- 11.01.2005 MSKINNER
						CHOOSE CASE li_case_review_letter_type
						//Practitioner Letter
							CASE 1
								tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "case_review_practitioner.txt", Text!, True )
								ls_open_merge = ls_open_merge + "case_review_practitioner.txt"
								//Committee Letter
							CASE 2
								tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "case_review_committee.txt", Text!, True )
								ls_open_merge = ls_open_merge + "case_review_committee.txt"
								//Department Chair Letter
							CASE 3
								tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "case_review_depart_chair.txt", Text!, True )
								ls_open_merge = ls_open_merge + "case_review_depart_chair.txt"
						END CHOOSE
						
					ELSE
						//Start Code Change ----01.30.2013 #V12 maha
						//messagebox("facil name",is_facility_name)
						for i = 1 to tab_ltr.tabpage_criteria.dw_letter.rowcount()
							tab_ltr.tabpage_criteria.dw_letter.setitem(1, "cparent_facility_name", is_facility_name )
						next
						//End Code Change ----01.30.2013
						tab_ltr.tabpage_criteria.dw_letter.SaveAs( ls_open_merge + "ind_generic_corrospondence.txt", Text!, True )
						ls_open_merge = ls_open_merge +  "ind_generic_corrospondence.txt"
						
					END IF
			END CHOOSE
		END IF
		/*comment 08/29/2007 by: Andy
														//if using an export set the merge file path to the export file
														if li_export_on = 1 then
															ls_open_merge = ls_exportname
														end if
		*/
		
	END IF
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.04.2006 By: LeiWei
//$<reason> Download the file from database
					/*
						IF gs_cust_type = "I" THEN //intelliapp
							SELECT facility.letter_path  
					   	INTO :ls_letter_path  
						   FROM facility  
					   	WHERE facility.facility_id = 1;		
						ELSE
							SELECT facility.letter_path  
					   	INTO :ls_letter_path  
						   FROM facility  
					   	WHERE facility.facility_id = :il_facility_id;
						END IF
						
						//ls_letter_path = "'" + ls_letter_path + "'"
						IF IsNull( ls_letter_path ) OR ls_letter_path = "" THEN
							MessageBox("Data Error", "You must define a letter path in the facility painter for selected facility.")
							Return -1 
						END IF
						li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
						li_response_required = 	tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" )
						ls_doc_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "document_name" )
						ls_word_path = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "paths", "word", "None")
*/

Integer li_word_storage_type
Integer li_facility_id

li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", False))
IF IsNull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" And li_word_storage_type = 0 THEN
	IF gs_cust_type = "I" THEN //intelliapp
		SELECT facility.letter_path
			INTO :ls_letter_path
			FROM facility
			Where facility.facility_id = 1;
	ELSE
		SELECT facility.letter_path
			INTO :ls_letter_path
			FROM facility
			Where facility.facility_id = :il_facility_id;
	END IF
	
	//ls_letter_path = "'" + ls_letter_path + "'"
	IF IsNull( ls_letter_path ) Or ls_letter_path = "" THEN
		MessageBox("Data Error", "You must define a letter path in the facility painter for selected facility.")
		RETURN -1
	END IF
	
	li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
	li_response_required = 	tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" )
	ls_doc_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "document_name" )
	ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
ELSE
	li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
	li_response_required = 	tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" )
	ls_doc_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "document_name" )
	ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
	
	IF gs_cust_type = "I" THEN //intelliapp
		li_facility_id = 1
	ELSE
		li_facility_id = il_facility_id
	END IF
	
	IF lnv_storage_area.of_retrieve_doc_from_db( li_facility_id, ls_doc_name, ls_letter_path) < 0 THEN
		MessageBox("Download File",'Unable to find MSWord document '+  ls_doc_name  +' for the Storage Area connected to the Selected Facility.')  //Start Code Change ----10.14.2014 #V14.2 maha
		RETURN -1
	END IF
	
END IF
ls_doc_name_nopath = ls_doc_name //Ken.Guo 11/01/2007
//---------------------------- APPEON END ----------------------------

//copy down to local drive from network? //maha copied from ver letters 06/11/03	
//SELECT set_6 INTO :li_set6 FROM icred_settings;
li_set6 = of_get_app_setting("set_6","I")
IF li_set6 = 1 THEN
	IF Upper(ls_letter_path) = Upper(ls_run_path ) THEN //maha 050602 trap against copying to same location
		MessageBox("Path error","Your letter path is set to " + gs_dir_path + "intellicred\letters\standard\ ~rand the Copy Letters setting is turned on. ~rGo to system->utilities->Application settings and set copy letters to No to run letters normally.")
		RETURN -1
	END IF
	
	//check to make sure letter and path exists
	IF Not FileExists( ls_letter_path + ls_doc_name ) THEN
		MessageBox("Print Error", "Cannot find word letter " + ls_doc_name + " in directory: " + ls_letter_path )
		RETURN -1
	ELSE
		ls_from  = ls_letter_path + ls_doc_name
	END IF
	
	//ls_to = gs_dir_path + "intellicred\letters\standard\" + ls_doc_name
	ls_to = ls_run_path + ls_doc_name
	//copy letter to c drive then run 
	//FileDelete( gs_dir_path + "intellicred\letters\standard\" + ls_doc_name )
	IF FileExists(ls_to) THEN //maha042805
		IF FileDelete( ls_to) = False THEN //maha040705
			MessageBox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in  " + ls_to + " prior to copy.~r  Check letter properties to see if letter is Read Only.")
		END IF
	END IF
	
	CopyFileA( ls_from, ls_to, True )
	//reset ls_doc_name
	ls_doc_name = ls_to //"c:\intellicred\letters\standard\" + ls_file_name
	DO WHILE Not FileExists( ls_doc_name )
		ll_loop_count++
		IF ll_loop_count = 100000 THEN
			MessageBox("Timeout", "Timed out trying to copy Word file." )
			EXIT
		END IF
	LOOP
ELSE
	ls_doc_name = ls_letter_path + ls_doc_name
END IF

IF Not FileExists( ls_doc_name ) THEN //maha 101504
	MessageBox("Unable to find letter:",ls_doc_name)
	//messagebox("to",ls_to)
	RETURN -1
END IF
// mskinner 04 oct 2005 -- begin
// mbs 22 Nov 2004 -- begin fax modification
//Run( ls_word_path + " " + ls_doc_name + " /mpreview", Maximized!)
//Start Code Change ---- 03.27.2006 #348 maha added trap return
IF gnv_app.gnvlo_msword.of_open_word_document( ls_doc_name, ls_open_merge, "Correspondence") = -1 THEN
	RETURN -1
END IF
//End Code Change---03.27.2006
// mbs 22 Nov 2004 -- end	fax modificationfax modification
//of_open_letter(ls_doc_name,ls_open_merge,"Correspondence") //maha 022505
// mskinner 04 oct 2005 -- end 
ls_letter_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "letter_name" )

gs_fax lgs_fax
n_ds lds_letters
Integer li_Retval

lds_letters = Create n_ds;

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.04.2006 By: LeiWei
//$<reason> Doc save to db
						/*
						IF ii_letter_id = 1001 OR ii_letter_id = 1002 THEN
							lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_action_items_letters.doc" // /mmail_labels"
						ELSEIF ii_letter_id = 1003 OR ii_letter_id = 1004 THEN
							lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_net_dev_payer_letters.doc" // /mmail_labels"
						ELSE
							// start change --- 11.01.2005 MSKINNER
							//IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "case_review_letter" ) = 1 THEN			
							IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_module" ) = 2 THEN		
							// end change --- 11.01.2005 MSKINNER
								CHOOSE CASE li_case_review_letter_type
									//Practitioner Letter
									CASE 1			
										lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_physician.doc" // /mmail_labels"
									//Committee Letter
									CASE 2
										lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_committee.doc" // /mmail_labels"
									//Department Chair Letter
									CASE 3		
										lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_department.doc" // /mmail_labels"
								END CHOOSE
							ELSE
								lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_prac_corro_letters.doc" // /mmail_labels"
							END IF			
						END IF
*/

IF Upper( AppeonGetClientType() ) = "PB" And li_word_storage_type = 0 THEN
	IF ii_letter_id = 1001 Or ii_letter_id = 1002 THEN
		lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_action_items_letters.doc" // /mmail_labels"
	ELSEIF ii_letter_id = 1003 Or ii_letter_id = 1004 THEN
		lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_net_dev_payer_letters.doc" // /mmail_labels"
	ELSE
		// start change --- 11.01.2005 MSKINNER
		//IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "case_review_letter" ) = 1 THEN			
		IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_module" ) = 2 THEN
			// end change --- 11.01.2005 MSKINNER
			CHOOSE CASE li_case_review_letter_type
			//Practitioner Letter
				CASE 1
					lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_physician.doc" // /mmail_labels"
					//Committee Letter
				CASE 2
					lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_committee.doc" // /mmail_labels"
					//Department Chair Letter
				CASE 3
					lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_case_review_department.doc" // /mmail_labels"
			END CHOOSE
		ELSE
			lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_prac_corro_letters.doc" // /mmail_labels"
		END IF
	END IF
ELSE
	IF ii_letter_id = 1001 Or ii_letter_id = 1002 THEN
		lgs_fax.ss_mail_label_doc = "mailing_labels_action_items_letters.doc" // /mmail_labels"
	ELSEIF ii_letter_id = 1003 Or ii_letter_id = 1004 THEN
		lgs_fax.ss_mail_label_doc = "mailing_labels_net_dev_payer_letters.doc" // /mmail_labels"
	ELSE
		// start change --- 11.01.2005 MSKINNER
		//IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "case_review_letter" ) = 1 THEN			
		IF tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "letter_module" ) = 2 THEN
			// end change --- 11.01.2005 MSKINNER
			CHOOSE CASE li_case_review_letter_type
			//Practitioner Letter
				CASE 1
					lgs_fax.ss_mail_label_doc =  "mailing_labels_case_review_physician.doc" // /mmail_labels"
					//Committee Letter
				CASE 2
					lgs_fax.ss_mail_label_doc = "mailing_labels_case_review_committee.doc" // /mmail_labels"
					//Department Chair Letter
				CASE 3
					lgs_fax.ss_mail_label_doc = "mailing_labels_case_review_department.doc" // /mmail_labels"
			END CHOOSE
		ELSE
			lgs_fax.ss_mail_label_doc = "mailing_labels_prac_corro_letters.doc" // /mmail_labels"
		END IF
	END IF
END IF

//---------------------------- APPEON END ----------------------------

lds_letters.DataObject = tab_ltr.tabpage_criteria.dw_letter.DataObject
li_Retval = tab_ltr.tabpage_criteria.dw_letter.RowsCopy( 1, 100000, Primary!, lds_letters, 1, Primary!  )

lgs_fax.ss_message = "If the " + upper(ls_letter_name) + " letter generated properly, select process options below and click Continue. "  //Start Code Change ----01.28.2014 #V14 maha - changed message
//lgs_fax.ss_letter_document_name = ls_doc_name + " /mpreview"
lgs_fax.ss_letter_document_name = ls_doc_name_nopath //Ken.Guo 11/01/2007
lgs_fax.ss_letter_name = ls_letter_name
lgs_fax.sdw_letter = lds_letters
lgs_fax.ss_letter_type = "Corro"
lgs_fax.ss_merge_file_path = ls_open_merge //Added By Ken.Guo 03.25.2008
if li_export_on=  1 then lgs_fax.ss_process_type = "Export"   //Start Code Change ----05.06.2015 #V15 maha  - part of trap for unmatched provider data in faxing

OpenWithParm( w_ai_print_msg_box, lgs_fax  )

gs_fax_error_records lst_fax_error_records
lst_fax_error_records = Message.PowerObjectParm
IF lst_fax_error_records.il_error_rec_num[ 1 ] = -2 THEN
	RETURN -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 02.20.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
					/*
						SELECT code_lookup.lookup_code  
						INTO :ll_prac_corro
						FROM code_lookup  
						WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
						  	   ( code_lookup.code = 'prac corre'  )   ;
						IF SQLCA.SQLCODE = -1 THEN
							MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
							RETURN -1
						END IF
					
						SELECT code_lookup.lookup_code  
						INTO :ll_ver_response
						FROM code_lookup  
						WHERE ( code_lookup.lookup_name = 'Credentials Verification Response' ) AND  
						  	   ( code_lookup.code = 'N/A'  )   ;
						IF SQLCA.SQLCODE = -1 THEN
							MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
							RETURN -1
						END IF
*/
n_ds lds_verif_info
Long ll_rows_verifinfo, ll_found

lds_verif_info = Create n_ds
lds_verif_info.DataObject = "ds_verif_info_maxseqno"
lds_verif_info.of_SetTransObject( SQLCA )

gnv_appeonDb.of_StartQueue()
lds_verif_info.Retrieve( il_facility_id )

SELECT code_lookup.lookup_code
	INTO :ll_prac_corro
	FROM code_lookup
	WHERE ( code_lookup.lookup_name = 'verification method' ) AND
	( code_lookup.code = 'prac corre'  )   ;
	
SELECT code_lookup.lookup_code
	INTO :ll_ver_response
	FROM code_lookup
	WHERE ( code_lookup.lookup_name = 'Credentials Verification Response' ) AND
	( code_lookup.code = 'N/A'  )   ;
	
gnv_appeonDb.of_CommitQueue()

IF SQLCA.SQLCode = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLErrText)
	RETURN -1
END IF
ll_rows_verifinfo = lds_verif_info.RowCount()
//---------------------------- APPEON END ----------------------------

n_ds lds_verif_rec

lds_verif_rec = Create n_ds
lds_verif_rec.DataObject = "d_ver_summary_record_view"
lds_verif_rec.of_SetTransObject( SQLCA )
li_row_cnt = UpperBound( il_prac_ids )

li_error_cnt = UpperBound( lst_fax_error_records.il_error_rec_num )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.21.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
IF li_row_cnt > 0 THEN
	ll_rec_id = gnv_app.of_get_id( "RECORD_ID", li_row_cnt ) - 1
END IF
//---------------------------- APPEON END ----------------------------
FOR i = 1 To li_row_cnt
	
	//check to see if there was records with no fax numbers when faxing.  if so skip over those records
	lb_error_rec = False
	FOR e = 1 To li_error_cnt
		IF lst_fax_error_records.il_error_rec_num[e] = i THEN
			lb_error_rec = True
			EXIT
		END IF
	NEXT
	IF lb_error_rec THEN
		CONTINUE
	END IF
	
	li_nr = lds_verif_rec.InsertRow( 0 )
	ll_prac_id = il_prac_ids[i]
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-08
	//$<modify> 02.20.2006 By: Rodger Wu
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	//$<modification> Comment out the following script to reduce client-server interaction.
	//$<modification> refer to PT-07 and of_get_id for more information.
	
	
	/*
										SELECT Max( verif_info.seq_no )  
								 		INTO :ll_seq_no  
									   FROM verif_info  
									   WHERE ( verif_info.facility_id = :il_facility_id ) AND  
								         		( verif_info.prac_id = :ll_prac_id  )   ;
										IF IsNull( ll_seq_no ) THEN
											ll_seq_no = 0
										END IF
										ll_seq_no++
										ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
	*/
	ll_found = lds_verif_info.Find( "prac_id = " + String( ll_prac_id ), &
		1, ll_rows_verifinfo )
	IF ll_found < 1 THEN
		ll_seq_no = 0
	ELSE
		ll_seq_no = lds_verif_info.GetItemNumber( ll_found, "maxseqno" )
	END IF
	ll_seq_no++
	ll_rec_id++
	//---------------------------- APPEON END ----------------------------
	
	lds_verif_rec.SetItem( li_nr, "reference_value", ls_letter_name )
	lds_verif_rec.SetItem( li_nr , "rec_id", ll_rec_id )
	lds_verif_rec.SetItem( li_nr , "seq_no", ll_seq_no )
	lds_verif_rec.SetItem( li_nr, "screen_id", 1 )
	lds_verif_rec.SetItem( li_nr, "prac_id",  il_prac_ids[i] )
	lds_verif_rec.SetItem( li_nr, "verif_info_facility_id", il_facility_id )
	lds_verif_rec.SetItem( li_nr, "first_sent", DateTime( Today(),Now()) )
	lds_verif_rec.SetItem( li_nr, "last_sent", DateTime( Today(),Now()) )
	lds_verif_rec.SetItem( li_nr, "number_sent", 1 )
	lds_verif_rec.SetItem( li_nr, "priority_user", gs_user_id )
	lds_verif_rec.SetItem( li_nr, "priority", 2 )
	lds_verif_rec.SetItem( li_nr, "date_recieved", nulldate )
	lds_verif_rec.SetItem( li_nr, "response_code", nulllong )
	lds_verif_rec.SetItem( li_nr, "verification_method", ll_prac_corro )
	lds_verif_rec.SetItem( li_nr, "active_status", 1 )
	lds_verif_rec.SetItem( li_nr, "print_flag", 0 )
	ls_doc_id = String( ll_rec_id ) + "-" + String( ll_prac_id ) + "-" + String( il_facility_id ) +  "-" + String( ll_seq_no ) //maha added "-"s 101504
	lds_verif_rec.SetItem( li_nr, "doc_id", ls_doc_id )
	lds_verif_rec.SetItem( li_nr, "exp_credential_flag", 0 )
	IF li_response_required = 0 THEN
		lds_verif_rec.SetItem( li_nr, "response_code", ll_ver_response )
		lds_verif_rec.SetItem( li_nr, "date_recieved", DateTime( Today(),Now()) )
		lds_verif_rec.SetItem( li_nr, "user_name", gs_user_id ) //End Code Change---04.10.2008 changed from 'Public'
		//lds_verif_rec.SetItem( li_nr, "priority", 2 )
	END IF
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 02.20.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
							/*	IF lds_verif_rec.Update() = -1 THEN
									MessageBox("Update Error", SQLCA.SQLERRTEXT )
									Return -1
								END IF
								COMMIT USING SQLCA;
*/
gnv_appeonDb.of_StartQueue()
IF lds_verif_rec.Update() = -1 THEN
	MessageBox("Update Error", SQLCA.SQLErrText )
	gnv_appeonDb.of_CommitQueue()
	RETURN -1
END IF
COMMIT Using SQLCA;
gnv_appeonDb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

Destroy lds_verif_rec
//END IF

IF ib_qa_letter THEN
	IF IsValid(istr_pass.w_parent_window) THEN
		istr_pass.w_parent_window.Function Dynamic of_insert_action_item('Sent: ' + ls_doc_name,il_action_to)
	END IF
END IF
//w_reappointment_measurements_search.

IF ib_from_case_review THEN
	//--------Begin Modified by  Nova 02.24.2010------------------------
	//	w_case_review.uo_case_review.of_letter_ai( ls_letter_name, ls_letter_type, tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" ), il_prac_ids )
	IF IsValid(activesheet) THEN
		IF  activesheet.Tag = 'Case/Peer Review'  THEN
			w_case_review.uo_case_review.of_letter_ai( ls_letter_name, ls_letter_type, tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" ), il_prac_ids )
		ELSEIF  activesheet.Tag = 'Quality Profiles' THEN
			w_qa_peer_profile_screen.tab_qa.tabpage_case_review.uo_case.of_letter_ai( ls_letter_name, ls_letter_type, tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" ), il_prac_ids )
		END IF
	ELSE
		RETURN -1
	END IF
	//--------End Modified --------------------------------------------
	
END IF


//messagebox("", tab_ltr.tabpage_criteria.dw_letter.DataObject )
CHOOSE CASE tab_ltr.tabpage_criteria.dw_letter.DataObject
	CASE "d_ltr_net_dev_app_rcvd_prac_all", "d_ltr_net_dev_app_rcvd_prac"
		IF IsValid( w_action_items ) THEN
			w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_set_next_due_date( "App Rcvd Prac" )
		ELSEIF IsValid( w_action_items_ia ) THEN
			w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_set_next_due_date( "App Rcvd Prac" )
		ELSEIF IsValid( w_prac_data_1 ) THEN
			w_prac_data_1.tab_1.tabpage_net.uo_net.of_set_next_due_date( "App Rcvd Prac" )
		ELSEIF IsValid( w_prac_data_intelliapp ) THEN
			w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.of_set_next_due_date( "App Rcvd Prac" )
		ELSEIF IsValid( w_prac_data_sk ) THEN //Practitioner Folder - alfee 09.28.2010
			w_prac_data_sk.tab_1.tabpage_net.uo_net.of_set_next_due_date( "App Rcvd Prac" )			
		END IF
	CASE "d_ltr_net_dev_app_rcvd_payer", "d_ltr_net_dev_app_rcvd_payer_all"
		IF IsValid( w_action_items ) THEN
			w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_set_next_due_date( "Par" )
		ELSEIF IsValid( w_action_items_ia ) THEN
			w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_set_next_due_date( "Par" )
		ELSEIF IsValid( w_prac_data_1 ) THEN
			w_prac_data_1.tab_1.tabpage_net.uo_net.of_set_next_due_date( "Par" )
		ELSEIF IsValid( w_prac_data_intelliapp ) THEN
			w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.of_set_next_due_date( "Par" )
		ELSEIF IsValid( w_prac_data_sk ) THEN //Practitioner Folder - alfee 09.28.2010
			w_prac_data_sk.tab_1.tabpage_net.uo_net.of_set_next_due_date( "Par" )			
		END IF
END CHOOSE


RETURN 0


end function

public function integer of_app_rcvd_prac ();Integer li_rc
Integer z
Integer i
Integer p
Integer li_cnt
Integer li_first_record
Integer li_remove_rc
Integer r
String ls_fld_1
String ls_fld_2
Long ll_prac_id[]
Long ll_temp_id
Long ll_action_status
Long ll_action_type
Boolean ll_found_id = False
DataStore ds_temp_data
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 03.22.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
END IF

select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF
*/
ll_action_status = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name) = 'ACTION STATUS' and upper(code) = 'INCOMPLETE'"))
IF ll_action_status = 0 THEN
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
END IF
ll_action_type = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP RCVD PRAC'"))
IF ll_action_type = 0 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF
//---------------------------- APPEON END ----------------------------


li_rc = tab_ltr.tabpage_criteria.dw_letter.RowCount()

ll_temp_id = 0
FOR i = 1 TO li_rc
	ll_temp_id = tab_ltr.tabpage_criteria.dw_letter.GetItemNumber( i, "prac_id" )
	ll_found_id = False
	FOR p = 1 TO UpperBound( ll_prac_id )
		IF ll_prac_id[ p ] = ll_temp_id THEN
			ll_found_id = True
		END IF
	END FOR
	IF ll_found_id = False THEN
		IF tab_ltr.tabpage_criteria.dw_letter.GetItemNumber( i, "action_type" ) = ll_action_type AND tab_ltr.tabpage_criteria.dw_letter.GetItemNumber( i, "action_status" ) = ll_action_status THEN
			li_cnt++
			tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "removeit", 0 )			
			ll_prac_id[ li_cnt ] = ll_temp_id
		ELSE
			tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "removeit", 1 )					
		END IF
	ELSE
		tab_ltr.tabpage_criteria.dw_letter.SetItem( i, "removeit", 1 )		
	END IF
END FOR

IF li_cnt = 0 THEN
		MessageBox( "No Data", "No data was returned.  Check the following: You need to have an App Rcvd Payor Action Type with an action status of Incomplete.  You need to have a mailing address setup.  ")
		Return -1	
END IF

//messagebox("li_cnt", li_cnt)

FOR z = 1 TO li_cnt
	tab_ltr.tabpage_criteria.dw_letter.SetFilter( "prac_id = " + String( ll_prac_id[z] ) )
	tab_ltr.tabpage_criteria.dw_letter.Filter( )
	li_rc = tab_ltr.tabpage_criteria.dw_letter.RowCount( )
	//messagebox(String( ll_prac_id[z]), li_rc )
	FOR i = 1 TO li_rc
		IF	tab_ltr.tabpage_criteria.dw_letter.GetItemNumber( i, "removeit" ) = 0 THEN
			//messagebox(String( ll_prac_id[z]), "remove it 0" )			
			li_first_record = i
		END IF
	END FOR

	FOR i = 1 TO li_rc
		ls_fld_1 = "app_name_" + String( i )
		ls_fld_2 = "date_" + String( i )
		tab_ltr.tabpage_criteria.dw_letter.SetItem( li_first_record, ls_fld_1, tab_ltr.tabpage_criteria.dw_letter.GetItemString( i, "application_name" ) )
		tab_ltr.tabpage_criteria.dw_letter.SetItem( li_first_record, ls_fld_2, String( tab_ltr.tabpage_criteria.dw_letter.GetItemDateTime( i, "action_date" ), "mm/dd/yyyy") )	
	END FOR

	//FOR i = 2 TO li_rc
	//	tab_ltr.tabpage_criteria.dw_letter.DeleteRow( tab_ltr.tabpage_criteria.dw_letter.RowCount() )
	//END FOR 
END FOR

//delete duplicates
tab_ltr.tabpage_criteria.dw_letter.SetFilter( "removeit = 1" )
tab_ltr.tabpage_criteria.dw_letter.Filter( )
li_remove_rc =	tab_ltr.tabpage_criteria.dw_letter.RowCount( )
FOR r = 1 TO li_remove_rc
	tab_ltr.tabpage_criteria.dw_letter.DeleteRow( 0 )
END FOR
tab_ltr.tabpage_criteria.dw_letter.SetFilter( "" )
tab_ltr.tabpage_criteria.dw_letter.Filter( )


li_rc = tab_ltr.tabpage_criteria.dw_letter.RowCount( )


Return 0
end function

public function integer of_case_review_letter (long al_prac_ids[], decimal aldec_case_number, integer ai_facility_id);ib_from_case_review = True

This.Width = 1522
This.X = 400

tab_ltr.tabpage_criteria.cb_next.x = 1070
tab_ltr.tabpage_criteria.cb_next.y = 1560
cb_close.x = 1110
tab_ltr.tabpage_criteria.cb_next.Text = "Run..."
tab_ltr.tabpage_criteria.dw_select_report.Height = 1500

il_prac_ids = al_prac_ids[]

idec_case_number = aldec_case_number
il_facility_id = ai_facility_id
tab_ltr.tabpage_criteria.dw_1.setitem(1,'module',2)

// start code change --- 11.01.2005 MSKINNER
//tab_ltr.tabpage_criteria.dw_select_report.SetFilter( "case_review_letter = 2" )
tab_ltr.tabpage_criteria.dw_select_report.SetFilter( "letter_module = 2" )
tab_ltr.tabpage_criteria.dw_select_report.Filter()
// end code change --- 11.01.2005 MSKINNER
//tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev"
//tab_ltr.tabpage_criteria.dw_letter.SetTransObject( SQLCA )
//
//	of_filter_child_dw( "2" )


Return 0


end function

public function integer of_fax_num_email_search ();String ls_letter_name
String ls_fax_number
String ls_email
Integer li_rc
Integer L
Long ll_prac_id
Integer li_facility_id
Integer li_grow
Integer li_tick

IF ib_fax_num_email_search THEN
	RETURN 1
END IF

//r_bar.Visible = True
//r_bar_outside.Visible = True
//st_bar.Visible = True

li_rc = tab_ltr.tabpage_criteria.dw_criteria.RowCount( )

//li_tick = Round( r_bar.Width/li_rc, 0 )
//r_bar.Width = 1	

FOR l = 1 TO li_rc
	li_grow = li_grow + li_tick
	//r_bar.Width = r_bar.width + li_grow 
	//ls_letter_name = Upper( dw_letters.GetItemString( l, "letter_alias" ) )
	ll_prac_id =  tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( l, "prac_id" )
	li_facility_id = il_facility_id
	SELECT fax, e_mail_address
	INTO :ls_fax_number,
		  :ls_email
	FROM pd_address,
	     pd_address_link
	WHERE (pd_address.rec_id = pd_address_link.address_id ) AND
			(pd_address_link.prac_id = :ll_prac_id ) AND
			(pd_address_link.facility_id = :li_facility_id ) AND
			(pd_address.active_status = 1 ) AND
			(pd_address_link.mailing = 1 );
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	tab_ltr.tabpage_criteria.dw_criteria.SetItem( l, "fax_number", ls_fax_number )					
	tab_ltr.tabpage_criteria.dw_criteria.SetItem( l, "email_address", ls_email )						
END FOR

ib_fax_num_email_search = True

//r_bar.Visible = False
//r_bar_outside.Visible = False
//st_bar.Visible = False


Return 0
end function

public function long of_quality_profile_letter (long al_prac_id, long al_header_id, long al_facility_id);	/****************************************************************************************************************
** [PUBLIC] FUNCTION of_quality_profile_letter
**--------------------------------------------------------------------------------------------------------------
** Description    :  This function will retrieve the information needed for the word document 
**							open Word,  and report any arrors.
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[LONG]  al_prac_id     - Practitioner ID
**						:  [LONG]  al_header_id   - Quality Profile ID
**				      :	[LONG]  al_facility_id - The doctors facility
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[LONG]  1 - success
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/


//////////////////////////////////////////////////////////////////////
// adjust the presentaion of the window
//////////////////////////////////////////////////////////////////////

ib_qa_letter = True
This.Width = 1522
This.X = 400
tab_ltr.tabpage_criteria.cb_next.x = 1070
tab_ltr.tabpage_criteria.cb_next.y = 1560
cb_close.x = 1110
tab_ltr.tabpage_criteria.cb_next.Text = "Run..."
tab_ltr.tabpage_criteria.dw_select_report.Height = 1500


il_prac_ids[1]  = al_prac_id
il_facility_id  =  al_facility_id
il_header_id    = al_header_id


//////////////////////////////////////////////////////////////////////
// filter out all rows that do not pertain the quality profile
//////////////////////////////////////////////////////////////////////

//tab_ltr.tabpage_criteria.dw_select_report.SetFilter( "qa_letter = 1" )
//tab_ltr.tabpage_criteria.dw_select_report.Filter()

if tab_ltr.tabpage_criteria.dw_select_report.rowcount( ) < 1 then
	 if of_messagebox( '' ,this.title, 'No letters listed for Quality Profile. If you have created Quality Profile letters make sure the USE IN QUALITY PROFILE check box is selected. Would you like to open the letter painter?', information!, yesno!, 2) = 1 then  
		 close(this)
		 open(w_letter_painter)
	 end if
	ELSE 
		
		
end if

return success
end function

public subroutine of_add_record ();

////

this.tab_ltr.tabpage_criteria.dw_select_report.insertrow(0)

end subroutine

public function integer of_copy_file ();/****************************************************************************************************************
** [PUBLIC] FUNCTION   w_letter_generation:: of_copy_file
**--------------------------------------------------------------------------------------------------------------
** Description    : looks to see if we need to copy a file from the network
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[integer] 1 - sucess  or  -1 - failure
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
****************************************************************************************************************/
long   li_set6
long   ll_loop_count
long   ll_return
string ls_letter_path  
string ls_doc_name// need
string ls_from
string ls_to
DATAWINDOW ldw_select_report

ldw_select_report = tab_ltr.tabpage_criteria.dw_select_report
/////////////////////////////////////////////////////////////////////////////
// find out the letter path
/////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.04.2006 By: LeiWei
//$<reason> Download file from database
/*
IF gs_cust_type = "I" THEN //intelliapp
	SELECT facility.letter_path  
  	INTO :ls_letter_path  
   FROM facility  
  	WHERE facility.facility_id = 1;		
ELSE
	SELECT facility.letter_path  
  	INTO :ls_letter_path  
   FROM facility  
  	WHERE facility.facility_id = :il_facility_id;
END IF

ls_doc_name = ldw_select_report.GetItemString( ldw_select_report.getrow(), "document_name" )
*/

n_appeon_storage_area lnv_storage_area
Integer li_facility_id
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	IF gs_cust_type = "I" THEN
		li_facility_id = 1
	ELSE
		li_facility_id = il_facility_id
	END IF

	IF lnv_storage_area.of_retrieve_doc_from_db( li_facility_id, ls_doc_name, ls_letter_path) < 0 THEN
		Messagebox("Download File",'The MSWord document '+  ls_doc_name  +'  does not exist in the database.')
		RETURN -1
	END IF
End If

//---------------------------- APPEON END ----------------------------


// getthe name of the document


//copy down to local drive from network?	//maha copied from ver letters 06/11/03	
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<modify> 03.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT set_6 INTO :li_set6 FROM icred_settings;
*/
li_set6 = integer(gnv_data.of_getitem("icred_settings" , "set_6" , False))
//---------------------------- APPEON END ----------------------------

IF li_set6 = 1 THEN
			if upper(ls_letter_path) = upper(gs_temp_path + "letters\standard\") then //maha 050602 trap against copying to same location
				messagebox("Path error","Your letter path is set to " + gs_temp_path + "letters\standard\ ~rand the Copy Letters setting is turned on. ~rGo to system->utilities->Application settings and set copy letters to No to run letters normally.")
				RETURN  failure
			end if
			//check to make sure letter and path exists
			IF NOT FileExists( ls_letter_path + ls_doc_name ) THEN
				MessageBox("Print Error", "Cannot find word letter " + ls_doc_name + " in directory: " + ls_letter_path )
				RETURN failure
			else
				ls_from  = ls_letter_path + ls_doc_name
			END IF
				
			ls_to = gs_temp_path + "letters\standard\" + ls_doc_name
			//copy letter to c drive then run 
			FileDelete( gs_temp_path + "letters\standard\" + ls_doc_name )
			
			ll_return = FileCopy ( ls_from, ls_to , TRUE)
			
			CHOOSE CASE ll_return
				CASE -1 
					MESSAGEBOX(THIS.TITLE, 'The source file could not be opened (' + ls_from + ')'  + 'Please check to see if the files exists and you have permisions to copy the file.')
				   RETURN Failure
				CASE -2 
					MESSAGEBOX(THIS.TITLE, 'The source file could not be copied to the location: (' + ls_to + ')'  + 'Please check to see if have permisions to copy the file to this location.')
					RETURN Failure
				CASE ELSE 
					// ALL OK
			END CHOOSE 
			
			ls_doc_name = ls_to //"c:\intellicred\letters\standard\" + ls_file_name
					
			DO WHILE NOT FileExists( ls_doc_name )
				ll_loop_count++
				IF ll_loop_count = 1000000 THEN
					MessageBox("Timeout", "Timed out trying to copy Word file." )
					RETURN Failure
					EXIT
				END IF
			LOOP
	ELSE
			ls_doc_name = ls_letter_path + ls_doc_name
END IF

return success

end function

public function integer of_filter_child_dw (string as_data);// start code change --- 11.01.2005 MSKINNER
/******************************************************************************************************************
**  [PUBLIC]   : of_filter_child_dw( /*string as_data */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
datawindowchild dw_child
long ll_null
long ll_current_data
string ls_filter
setnull(ll_null)

if ib_from_net_dev = true then return 0 //Start Code Change ----04.22.2008 #V8 maha - prevent from overwriting filter

//this.dw_1.getchild( 'module', dw_child)
//
//ll_current_data = dw_child.getitemNumber(1,'letter_module')

//ls_filter = "letter_module =  "+ as_data 
//---------Begin Modified by (Appeon)Stephen 06.24.2016 for V15.1 Bug # 5209 - Letters: Issue with the Payor letters--------
//ls_filter = "letter_module =  "+ as_data + " and (net_dev_letter <> 1or isnull(net_dev_letter))"  //Start Code Change ----06.22.2016 #V152 maha - filter out net dev letters
ls_filter = "letter_module =  "+ as_data + " and (net_dev_letter <> 1 or isnull(net_dev_letter))"  
//---------End Modfiied ------------------------------------------------------

this.tab_ltr.tabpage_criteria.dw_select_report.setfilter( ls_filter)
this.tab_ltr.tabpage_criteria.dw_select_report.filter()
// end code change --- 11.01.2005 MSKINNER

//<add> 08/02/2007 by: Andy Reason:BugJ080205(Web)
if this.tab_ltr.tabpage_criteria.dw_select_report.Rowcount( ) > 0 then
	this.tab_ltr.tabpage_criteria.dw_select_report.event rowfocuschanged( 1 )
end if
//end of add

return 0
end function

public function string of_qa_letter_merge (string as_path);/****************************************************************************************************************
** [PUBLIC] FUNCTION w_letter_generator :: of_qa_letter_merge
**--------------------------------------------------------------------------------------------------------------
** Description    :
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/
//Start Code Change ---- 10.03.2006 #645 maha  //recoded
LONG ll_qa_profile_level
long ll_current_row
string ls_letter_type
string ls_lookup_code_desc =  'Case/Peer Review Action Item To'
string ls_path
// make sure there are rows
if tab_ltr.tabpage_criteria.dw_select_report.rowcount() < 1 then 
	RETURN "fail"
end if 

ids_physician = create n_ds

ll_current_row = tab_ltr.tabpage_criteria.dw_select_report.getrow() 
// start code change --- 11.04.2005 MSKINNER
ll_qa_profile_level = tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( ll_current_row, "letter_destination" )//qa_letter_level
// end code change --- 11.04.2005 MSKINNER
CHOOSE CASE ll_qa_profile_level
		//Practitioner Letter
	CASE 1
		
		ls_letter_type = "Practitioner"
		ids_physician.DataObject = "d_qa_ltr_physician"
		ids_physician.of_SetTransObject( SQLCA)
		ids_physician.retrieve(il_prac_ids[1], gs_user_id)   //Start Code Change ----02.02.2017 #V153 maha - added user fields

				 
		   //Committee Letter
	CASE 2
		ls_letter_type = "Committee"
		ids_physician.DataObject = "d_qa_commitee_chair"
		ids_physician.of_SetTransObject( SQLCA)
 		ids_physician.retrieve(il_facility_id, gs_user_id)   //Start Code Change ----02.02.2017 #V153 maha - added user fields
		
		if ids_physician.rowcount( ) < 1 then
			if messagebox(this.title, 'No committees were found for this letter. Please check to see if a Department Chair exists. Would you like to open the Facility Painter in order to check the Committe tab ?', question!, yesno!,1) = 1 then
				open(w_facility_setup)
			end if 
	   end if 
	CASE 3		
		ls_letter_type = "Depart Chair"
		ids_physician.DataObject = "d_qa_department_chair"
		ids_physician.of_SetTransObject( SQLCA)
 		ids_physician.retrieve(il_prac_ids[1], gs_user_id)    //Start Code Change ----02.02.2017 #V153 maha - added user fields
		if ids_physician.rowcount( ) < 1 then
			if messagebox(this.title, 'No Department Chair were found for this letter. Please check to see if a Department Chair exists. Would you like to open the Facility Painter in order to check the Departmant Chair tab ?', question!, yesno!,1) = 1 then
				open(w_facility_setup)
			end if 
	   end if 
	case else 
		of_messagebox( '', this.title , 'This letter does not have a selection in the profile box.', information!, ok!, 1)
		return "fail"
	END CHOOSE

if ids_physician.rowcount() > 0   then 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<add> 01.13.2006 By: Cao YongWang
	//$<modification> Create the downloading directory if it does not exist.
	If appeongetclienttype() <> 'PB' Then
		n_appeon_download lnv_downlaod
		lnv_downlaod.of_parsepath( gs_temp_path + "letters\data")
	End If
	//---------------------------- APPEON END ----------------------------

	CHOOSE CASE ll_qa_profile_level
		CASE 1
			ls_path = as_path + "qa_practitioner.txt"
		CASE 2
			ls_path =  as_path + "qa_Committee.txt"
		CASE 3
			ls_path = as_path + "qa_Depart_Chair.txt"
	END CHOOSE
	
	if ids_physician.SaveAs( ls_path, Text!, True )	<> 1 then
		messagebox(this.title, ls_path + "  Failed to save. Make sure you have permissions to save to this directory")
		return "fail"
	end if
	
end if
	
////////////////////////////////////////////////////////////////////////
//  get the action code to value from the database
////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<modify> 03.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
select code_lookup.lookup_code 
into  :il_action_to
from  code_lookup
where code_lookup.lookup_name = : ls_lookup_code_desc and 
      code_lookup.code =  :ls_letter_type
using sqlca;

if SQLCA.sqlcode <> 0 then
	messagebox('SQL Error','The action to was not retrievd in of_qa_letter_merge')
end if 
*/
il_action_to=Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='"+upper(ls_lookup_code_desc) + "' and upper(code)='" +upper(ls_letter_type) +"'"))

if il_action_to = 0 then
	messagebox('SQL Error','The action to was not retrievd in of_qa_letter_merge')
end if 
//---------------------------- APPEON END ----------------------------

return ls_path
//End Code Change---10.03.2006
end function

public function integer of_print_corro ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.24.2006 By: Jervis
//$<reason> print Correspondence letters for work flow
long ll_letter_id,ll_row
long ll_rec_id[],ll_prac_id[],ll_facility_id[],ll_seq_no[],ll_app_id[]
n_cst_print_letter   lnv_print_letter

ll_row = tab_ltr.tabpage_criteria.dw_corro.GetRow()

if ll_row > 0 then
	ll_letter_id = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_letter_id")
	ll_rec_id[1] = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_rec_id")
	ll_prac_id[1] = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_prac_id")
	ll_facility_id[1] = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_facility_id")
	ll_seq_no[1] = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_seq_no")
	ll_app_id[1] = tab_ltr.tabpage_criteria.dw_corro.GetItemNumber(ll_row,"net_dev_action_items_app_id")
else
	return 1
end if
lnv_print_letter.of_init_net_dev( )
if lnv_print_letter.of_print_letter(ll_letter_id,ll_rec_id,ll_prac_id,ll_facility_id,ll_seq_no,ll_app_id) = 1 then
	tab_ltr.tabpage_criteria.dw_corro.SetItem(ll_row,"print_status",1)
	tab_ltr.tabpage_criteria.dw_corro.filter()
	//refresh data
	if idw_action_item.retrieve() < 1 then
		idw_action_item.insertrow(1)
	end if
	idw_action_item.sort()
end if
//---------------------------- APPEON END ----------------------------
return 1
end function

public function integer of_net_dev_ltr (long al_prac_id[], integer ai_facility_ids[], integer ai_app_ids[], u_dw adw_printed);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: ???
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**    MSkinner 			17 event dec 2005                                 check for nulls
********************************************************************************************************************/
integer li_ret

if upperbound(ai_facility_ids) < 1 then 
	setredraw(true)
	return failure
end if

IF ib_from_prac_folder THEN
	li_ret = tab_ltr.tabpage_criteria.dw_select_report.SetFilter( "letter_id in (1001, 1003)" )	//Start Code Change ----06.22.2016 #V152 maha		//SetFilter( "letter_name = 'Credentialing Application Signature Follow up (Individual)' OR letter_name = 'Payer Follow up Letter (Individual)'" )
	tab_ltr.tabpage_criteria.dw_select_report.Filter( )
ELSE
	li_ret = tab_ltr.tabpage_criteria.dw_select_report.SetFilter( "letter_id in (1002, 1004)" )	//Start Code Change ----06.22.2016 #V152 maha		//SetFilter( "letter_name = 'Credentialing Application Signature Follow up (ALL)' OR letter_name = 'Payer Follow up Letter (All)'" )
	tab_ltr.tabpage_criteria.dw_select_report.Filter( )
END IF

w_letter_generator.SetRedraw( True )

ib_from_net_dev = True
idw_action_item = adw_printed

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.24.2006 By: Jervis
//$<reason> 
//il_action_type[] = al_action_type[]
//il_action_status[] = al_action_status[]
long ll_count
if gb_workflow then
	ll_count = tab_ltr.tabpage_criteria.dw_corro.retrieve(al_prac_id,ai_facility_ids)
	if ll_count > 0 then
		tab_ltr.tabpage_criteria.dw_select_report.height = 676 
		tab_ltr.tabpage_criteria.dw_corro.visible = true
		tab_ltr.tabpage_criteria.cb_next.bringtotop = true
	end if
end if
//---------------------------- APPEON END ----------------------------
ii_app_ids[] = ai_app_ids[]


This.Width = 1522
This.X = 400


tab_ltr.tabpage_criteria.cb_next.x = 1015
tab_ltr.tabpage_criteria.cb_next.y = 1560
cb_close.x = 1050
tab_ltr.tabpage_criteria.cb_next.Text = "Run..."

il_prac_ids = al_prac_id
il_facility_id = ai_facility_ids[1]
il_facility_ids_all[] = ai_facility_ids[]

tab_ltr.tabpage_criteria.dw_letter.DataObject = "d_ltr_net_dev"
tab_ltr.tabpage_criteria.dw_letter.SetTransObject( SQLCA )

This.Show( ) //(Appeon)Harry 11.12.2014 - Bug # 4292 

Return 0


end function

public function integer of_run_export (long ai_pracs[], integer ai_exp_id, ref string as_path);//maha 073002

Long prac_ids[]

string ls_exp_name

string ls_path
integer res

pfc_n_cst_ai_export_apb  n_export

long ll_export_id
integer i


ls_path = as_path//022305 

n_export = CREATE pfc_n_cst_ai_export_apb

n_export.is_called_type = '4'	//08.29.2007 Export format set to .txt By Jervis

res = n_export.of_export_data_with_text( ai_exp_id, ai_pracs[],ls_path,0,string(il_facility_id ),"","",2,"" ) ////Start Code Change ----01.06.2010 #V10 maha - added param 1

destroy n_export
as_path = ls_path
//messagebox("res",res)
if res < 0 then
	return -1
else

	return 1
end if


end function

public subroutine of_dashboard (long ai_id);long ll_find
ll_find=tab_ltr.tabpage_criteria.dw_select_report.find("letter_id="+string(ai_id), 1, tab_ltr.tabpage_criteria.dw_select_report.rowcount())
if ll_find>0 then
	tab_ltr.tabpage_criteria.dw_select_report.selectrow( 0, false)
	tab_ltr.tabpage_criteria.dw_select_report.scrolltorow(ll_find)
	tab_ltr.tabpage_criteria.dw_select_report.selectrow(ll_find, true)
	If This.WindowState = Minimized! Then This.windowstate = Normal!
end if 
end subroutine

on w_letter_generator.create
int iCurrent
call super::create
this.tab_ltr=create tab_ltr
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_ltr
this.Control[iCurrent+2]=this.cb_close
end on

on w_letter_generator.destroy
call super::destroy
destroy(this.tab_ltr)
destroy(this.cb_close)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.19.2006 By: Davis
//$<reason> Fix a defect.
IF Message.StringParm = "HIDE" THEN This.Hide( ) //(Appeon)Harry 11.12.2014 - Bug # 4292 
IF gb_contract_version THEN
	This.title = "Contract Correspondence Generator"
END IF

//---------------------------- APPEON END ----------------------------



// start code change --- 11.04.2005 MSKINNER
//This.Width = 3657
//This.Height = 2060
// end code change --- 11.04.2005 MSKINNER
//This.x = 1
//This.y = 1

inv_reports = CREATE pfc_cst_u_reports

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<modify> 02.09.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select set_13 into :ii_batch_button from icred_settings; //maha 102302 for batch button
*/

//ii_batch_button = integer(gnv_data.of_getitem("icred_settings","set_13",false))//Start Code Change ----12.15.2009 #V10 maha - removed, redundant
//---------------------------- APPEON END ----------------------------

//tab_ltr.tabpage_criteria.cb_batch.Visible = True


///////////////////////////////////////////////////////////
// mskinner 18 Nov 2004
///////////////////////////////////////////////////////////

//istr_pass = message.powerobjectparm

//--------Begin Added by Nova 08.13.2008------------------------
//Ken.Guo 2008-09-27
If Isvalid(message.powerobjectparm) Then
	If message.powerobjectparm.classname() = 'str_dashboard' Then
		str_para=message.powerobjectparm
		ib_auto_locate = True
	Else
		istr_pass = message.powerobjectparm
	End If
End If
//--------End Added --------------------------------------------

end event

event close;call super::close;DESTROY inv_reports
end event

event pfc_postopen;call super::pfc_postopen;if ib_auto_locate then of_dashboard(str_para.data_id) //For dashboard Added by Nova on 2008-08-13
end event

type tab_ltr from tab within w_letter_generator
event create ( )
event destroy ( )
integer width = 3557
integer height = 1844
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_criteria tabpage_criteria
end type

on tab_ltr.create
this.tabpage_criteria=create tabpage_criteria
this.Control[]={this.tabpage_criteria}
end on

on tab_ltr.destroy
destroy(this.tabpage_criteria)
end on

type tabpage_criteria from userobject within tab_ltr
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3520
integer height = 1716
long backcolor = 33551856
string text = "Select Letter/Criteria"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom002!"
long picturemaskcolor = 553648127
cb_search cb_search
st_help_text st_help_text
cb_prior cb_prior
dw_criteria dw_criteria
cb_batch cb_batch
gb_filter gb_filter
ddplb_filter ddplb_filter
dw_criteria_box dw_criteria_box
dw_letter dw_letter
dw_wizard_seq dw_wizard_seq
st_1 st_1
dw_1 dw_1
cb_next cb_next
dw_corro dw_corro
dw_select_report dw_select_report
end type

on tabpage_criteria.create
this.cb_search=create cb_search
this.st_help_text=create st_help_text
this.cb_prior=create cb_prior
this.dw_criteria=create dw_criteria
this.cb_batch=create cb_batch
this.gb_filter=create gb_filter
this.ddplb_filter=create ddplb_filter
this.dw_criteria_box=create dw_criteria_box
this.dw_letter=create dw_letter
this.dw_wizard_seq=create dw_wizard_seq
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_next=create cb_next
this.dw_corro=create dw_corro
this.dw_select_report=create dw_select_report
this.Control[]={this.cb_search,&
this.st_help_text,&
this.cb_prior,&
this.dw_criteria,&
this.cb_batch,&
this.gb_filter,&
this.ddplb_filter,&
this.dw_criteria_box,&
this.dw_letter,&
this.dw_wizard_seq,&
this.st_1,&
this.dw_1,&
this.cb_next,&
this.dw_corro,&
this.dw_select_report}
end on

on tabpage_criteria.destroy
destroy(this.cb_search)
destroy(this.st_help_text)
destroy(this.cb_prior)
destroy(this.dw_criteria)
destroy(this.cb_batch)
destroy(this.gb_filter)
destroy(this.ddplb_filter)
destroy(this.dw_criteria_box)
destroy(this.dw_letter)
destroy(this.dw_wizard_seq)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_next)
destroy(this.dw_corro)
destroy(this.dw_select_report)
end on

type cb_search from commandbutton within tabpage_criteria
integer x = 1545
integer y = 1344
integer width = 512
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Practitioner Search"
end type

event clicked;Integer li_nr
//Integer li_find
Long ll_find //replace all 'li_find' to 'll_find', by Appeon long.zhang 09.21.2015 (V14.1 Bug # 4734 - Some provider names are not showing when selecting for correspondence letters)
integer i
integer ic
Long ll_prac_id
String ls_full_name
gs_search lstr_search
gs_batch_search ist_search

ib_fax_num_email_search = False

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String( il_facility_id ) 

//Start Code Change ----12.13.2010 #V10 maha - for sk
if gb_sk_ver then
	lstr_search.ls_open_for = "SKS"
	OpenWithParm( w_extended_search_app , lstr_search )
else
	OpenWithParm( w_extended_search_new , lstr_search )
end if
//Start Code Change ----12.13.2010


IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.13.2006 By: Cao YongWang
//$<reason> Fix a defect.
If not isvalid(ist_search) Then return 
//---------------------------- APPEON END ----------------------------

//maha 091605 allowing for multi selection

// mskinner 20 dec 2005 -- begin 
if not isvalid(message.powerobjectparm) then return 0
// mskinner 20 dec 2005 -- end 

ic = upperbound(ist_search.li_prac_id[])
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<modify> 02.08.2006 By: Liang QingShi
//$<reason> Performance tuning 
//$<modification> Use datastores to cache data to be used in front of the loop, instead of using
//$<modification> SQLs in the loop. The modification reduces client-server interactions.

/*
for i = 1 to ic
//ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )
//ls_full_name = Mid( Message.StringParm, Pos( Message.StringParm, "-" ) +1, 100 )
	ll_prac_id = ist_search.li_prac_id[i] //maha 091605
	select full_name into :ls_full_name from v_full_name where prac_id = :ll_prac_id;
	//ls_full_name = ist_search.ls_name[i] //maha 091605


	ll_find = dw_criteria.Find( "prac_id = " + String( ll_prac_id ), 1, 1000 )
	
	IF ll_find > 0 THEN
		MessageBox("Select Error", "You have allready selected this person to attend!, Please reselect." )
		Return -1
	END IF
	
	li_nr = dw_criteria.InsertRow( 0 )
	
	dw_criteria.SetItem( li_nr, "prac_id", ll_prac_id )
	//messagebox("", ll_prac_id )
	dw_criteria.SetItem( li_nr, "full_name", ls_full_name )
next
*/

datastore lds_full_name
long ll_rowcount

lds_full_name = create datastore
lds_full_name.dataobject = 'd_v_full_name'
lds_full_name.settransobject(sqlca)
ll_rowcount = lds_full_name.retrieve()

for i = 1 to ic
	ll_prac_id = ist_search.li_prac_id[i] 

	ll_find = dw_criteria.Find( "prac_id = " + String( ll_prac_id ), 1, 1000 )
	
	IF ll_find > 0 THEN
		MessageBox("Select Error", "You have allready selected this person to attend!, Please reselect." )
		Return -1
	END IF
	
	li_nr = dw_criteria.InsertRow( 0 )
	
	dw_criteria.SetItem( li_nr, "prac_id", ll_prac_id )

	ll_find = lds_full_name.Find( "prac_id = " + String( ll_prac_id ), 1, ll_rowcount )
   if ll_find > 0 then
		ls_full_name = lds_full_name.getitemstring(ll_find,'full_name')
		dw_criteria.SetItem( li_nr, "full_name", ls_full_name )
	end if

next
destroy lds_full_name
//---------------------------- APPEON END ----------------------------

dw_criteria.SetFocus( )
dw_criteria.SelectRow( 0 , False )
dw_criteria.ScrollToRow( li_nr )
dw_criteria.SetRow ( li_nr )
dw_criteria.SelectRow( li_nr , True )


end event

type st_help_text from statictext within tabpage_criteria
integer x = 1550
integer y = 228
integer width = 1637
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Provider(s)"
boolean focusrectangle = false
end type

type cb_prior from u_cb within tabpage_criteria
integer x = 2670
integer y = 1344
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "<- Prior"
end type

event clicked;of_wizard( "Prior" )
end event

type dw_criteria from u_dw within tabpage_criteria
event pfc_cst_set_focus ( )
integer x = 1550
integer y = 308
integer width = 1838
integer height = 996
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_crit_org_facility"
boolean hscrollbar = true
end type

event pfc_cst_set_focus;This.SetFocus()
end event

event constructor;This.of_Setupdateable(False )
end event

type cb_batch from commandbutton within tabpage_criteria
integer x = 2066
integer y = 1344
integer width = 512
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
end type

event clicked;
gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
string ls_openstring

ib_fax_num_email_search = False

if il_facility_id > 0 then
	ls_openstring = "R*" + string(il_facility_id)
elseif il_facility_id = 0 then 
	ls_openstring = "R*ALL" 
else 
	ls_openstring = "R"
end if
	


openwithparm(w_batch_prac_select_new,ls_openstring)


if message.stringparm = "Cancel" then return
//names[] = lst 
lst_search = message.powerobjectparm
pracids[] = lst_search.li_prac_id[]
names[] = lst_search.ls_name[]
 ic = upperbound(pracids[]) 
 
 //---------Begin Added by (Appeon)Harry 05.05.2015 for  Issues running a custom correspondence letter against an IntelliBatch--------
long ll_findrow, ll_rowcount
 if il_facility_id > 0 then
	datastore lds_find
	lds_find = create datastore
	lds_find.dataobject = 'd_facility_filter'
	lds_find.settransobject(sqlca)
	ll_rowcount = lds_find.retrieve(il_facility_id)
 end if
 //---------End Added ------------------------------------------------------
 
 for i = 1 to ic
	//---------Begin Added by (Appeon)Harry 05.05.2015 for  Issues running a custom correspondence letter against an IntelliBatch--------
	if il_facility_id > 0 then
		ll_findrow = lds_find.find( "prac_id = " + String(  pracids[i] ), 1, ll_rowcount)
		if ll_findrow <= 0 then continue
	end if
	 //---------End Added ------------------------------------------------------
	r = dw_criteria.InsertRow( 0 )
	dw_criteria.SetItem( r, "prac_id", pracids[i])
	dw_criteria.SetItem( r, "full_name", names[i] )
next

if isvalid (lds_find) then destroy lds_find  //(Appeon)Harry 05.05.2015 

dw_criteria.SetFocus( )
dw_criteria.SelectRow( 0 , False )
dw_criteria.ScrollToRow( 1 )
dw_criteria.SetRow ( 1 )
dw_criteria.SelectRow( 1 , True )
//if dw_criteria.rowcount() > 1 then
////	st_batch.visible = true
//end if
end event

type gb_filter from groupbox within tabpage_criteria
integer x = 1545
integer y = 1460
integer width = 933
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

type ddplb_filter from dropdownpicturelistbox within tabpage_criteria
integer x = 1577
integer y = 1516
integer width = 869
integer height = 488
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Show All Letters","Faxable Letters","Faxable Letters with NO email","Emailable Letters","Emailable Letters with NO Fax #","Letters with no Fax or Email"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {4,3,3,2,2,1}
string picturename[] = {"Report5!","Globals!","Custom020!","Report!"}
long picturemaskcolor = 553648127
end type

event selectionchanged;of_fax_num_email_search( )
tab_ltr.tabpage_criteria.dw_criteria.AcceptText()

//show all
IF index = 1 THEN
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )		
//faxable letters	
ELSEIF index = 2 THEN
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "Len( fax_number ) > 0" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )					
//faxable letters	with NO email
ELSEIF index = 3 THEN
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "Len( fax_number ) > 0 AND (Len( email_address ) = 0 OR email_address = '' OR IsNull(email_address))" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )						
//emailable letters
ELSEIF index = 4 THEN
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "Len( email_address ) > 0" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )					
//emailable letters with NO fax	
ELSEIF index = 5 THEN
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "Len( email_address ) > 0 AND (Len( fax_number ) = 0 OR fax_number = '' OR IsNull(fax_number))" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )					
//print only
ELSE
	tab_ltr.tabpage_criteria.dw_criteria.SetFilter( "(Len( fax_number ) = 0 OR fax_number = '' OR IsNull(fax_number)) AND (Len( email_address ) = 0 OR email_address = '' OR IsNull(email_address))" )
	tab_ltr.tabpage_criteria.dw_criteria.Filter( )						
END IF


	
end event

type dw_criteria_box from u_dw within tabpage_criteria
integer x = 1477
integer y = 24
integer width = 1979
integer height = 1664
integer taborder = 20
boolean enabled = false
boolean titlebar = true
string title = "Letter Criteria"
string dataobject = "d_crit_background"
boolean vscrollbar = false
end type

event clicked;call super::clicked;Integer li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SelectRow( 0, False )
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
	This.SelectRow( li_row, True )
END IF
end event

event constructor;This.of_Setupdateable(False )
end event

type dw_letter from u_dw within tabpage_criteria
boolean visible = false
integer x = 2670
integer y = 276
integer width = 256
integer height = 104
integer taborder = 11
string dataobject = "d_ltr_general_corrospondence"
end type

event retrievestart;call super::retrievestart;Return 2
end event

event constructor;call super::constructor;This.of_Setupdateable(False )
end event

type dw_wizard_seq from u_dw within tabpage_criteria
boolean visible = false
integer x = 2958
integer y = 276
integer width = 256
integer height = 104
integer taborder = 11
string dataobject = "d_letter_wizard_sequence"
end type

event constructor;This.of_Setupdateable(False )
This.of_SetTransObject( SQLCA )
end event

type st_1 from statictext within tabpage_criteria
integer x = 14
integer y = 36
integer width = 302
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Letter Type:"
boolean focusrectangle = false
end type

type dw_1 from u_dw within tabpage_criteria
integer x = 279
integer y = 24
integer width = 1134
integer height = 84
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ext_module"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 04 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



/////////////////////////////////////////////////////////////////////////////////////////////////
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//    	IF ANY MODIFICATIONS ARE MADE TT THE FILTER LOGIC; MODS NEED TO BE MADE IN PFC_U_LETTER_PAINTER 
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
/////////////////////////////////////////////////////////////////////////////////////////////////




insertrow(0)

this.object.module[1] = 1
string ls_current_filter

datawindowchild dw_child

this.getchild( 'module', dw_child)

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.13.2006 By: Rodger Wu
//$<reason> Fix a defect.
//this.getchild( 'letter_module', dw_child)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
//$<reason> When the Product Setting is set to IntelliContract then the Letter 
//$<reason> type drop down should only have contract in list 
IF gb_contract_version THEN
	dw_child.setfilter("module_data = 4")
	dw_child.filter()

	st_1.VISible = FALSE
	THIS.VISible = FALSE
   PARENT.DW_select_report.X = 27
	PARENT.DW_select_report.Y = 32
	PARENT.DW_select_report.width =1394 
	PARENT.DW_select_report.Height =1656 
	
	of_filter_child_dw( "4" )
	
	RETURN
END IF
//---------------------------- APPEON END ----------------------------


ls_current_filter = dw_child.Describe("DataWindow.Table.Filter")	

IF NOT F_VALIDSTR(ls_current_filter) OR  ls_current_filter = '?' THEN 
	ls_current_filter = ''
END IF

//////////////////////////////////////////////////////////////////////////
// filter out the peer review
//////////////////////////////////////////////////////////////////////////

if of_get_app_setting("set_peer","I") = 0 AND ls_current_filter <> '?' then
    dw_child.setfilter("module_data <> 2")
    dw_child.filter()
end if 

//////////////////////////////////////////////////////////////////////////
// filter out the QA stuff
//////////////////////////////////////////////////////////////////////////

ls_current_filter = dw_child.Describe("DataWindow.Table.Filter")	

if of_get_app_setting("set_qa","I") = 0 then
	 if f_validstr(ls_current_filter) AND ls_current_filter <> '?' then 
		 dw_child.setfilter(ls_current_filter + ' and ' + "module_data <> 3")
	 else 
		 dw_child.setfilter( "module_data <> 3")
	end if 
   dw_child.filter()
end if

//////////////////////////////////////////////////////////////////////////
// filter out the contract
//////////////////////////////////////////////////////////////////////////

ls_current_filter = dw_child.Describe("DataWindow.Table.Filter")	

if of_get_app_setting("set_cont","I") = 0 AND ls_current_filter <> '?'then
	 if f_validstr(ls_current_filter) then 
		 dw_child.setfilter(ls_current_filter + ' and ' + "module_data <> 4")
	 else 
		 dw_child.setfilter("module_data <> 4")
	 end if 
    dw_child.filter()
end if

/////////////////////////////////////////////////////////////////////////////
// IF THE USER ONLY HAS ACCESS TO PRACTITIONER LETTERS THE TO THE FOLLOWING
/////////////////////////////////////////////////////////////////////////////

IF dw_child.ROWCOUNT( ) = 1 THEN 
	st_1.VISible = FALSE
	THIS.VISible = FALSE
   PARENT.DW_select_report.X = 27
	PARENT.DW_select_report.Y = 32
	PARENT.DW_select_report.width =1394 
	PARENT.DW_select_report.Height =1656 
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/09/2008 By: Ken.Guo
//$<reason> Fix BugK111901: Not filter data after open window.
If Not Isnull(This.GetItemNumber(1,'module')) Then
	This.Post Event ItemChanged(1,this.object.module,String(This.GetItemNumber(1,'module')))
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/10/2008 By: Evan
//$<reason> Fix BugS122903: The number of letters in the popup dialog is different.
this.Modify("datawindow.readonly = 'yes'")
this.Modify("module.background.color = 67108864")
//---------------------------- APPEON END ----------------------------
end event

event itemchanged;call super::itemchanged;if not ib_qa_letter and not ib_from_case_review and not ib_from_net_dev then //Start Code Change ---- 05.02.2008 V8 maha - trap filter bug
	if f_validstr(data) then 
		of_filter_child_dw(data)
	  
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 11.24.2006 By: Jervis
		//$<reason> 
		dw_corro.visible = false	
		dw_select_report.height = 1568
		cb_next.bringtotop = true
		//---------------------------- APPEON END ----------------------------
	end if 
end if
end event

type cb_next from u_cb within tabpage_criteria
integer x = 3035
integer y = 1344
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Next->"
end type

event clicked;/****************************************************************************************************************
** [PUBLIC] EVENT    w_letter_generator::cb_next:: clicked()
**--------------------------------------------------------------------------------------------------------------
** Description    : 
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	?
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
**  Date             Who                    Change  	
**--------------------------------------------------------------------------------------------------------------
** 17 Nov	2004 		MSKINNER 				  Added code for quality letters
**
****************************************************************************************************************/



Integer li_prac_cnt
Integer li_nr
Integer i

IF ib_from_net_dev THEN
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 11.24.2006 By: Jervis
	//$<reason> 
	/*
	li_prac_cnt = UpperBound( il_prac_ids[] )
	tab_ltr.tabpage_criteria.dw_criteria.DataObject = "d_crit_pracs"
	FOR i = 1 TO li_prac_cnt
	   li_nr = tab_ltr.tabpage_criteria.dw_criteria.InsertRow( 0 )
	   tab_ltr.tabpage_criteria.dw_criteria.SetItem( li_nr, "prac_id", il_prac_ids[ i ] )
	END FOR
	of_run()
	*/
	if ib_corro_flag then
		of_print_corro()
	else
		li_prac_cnt = UpperBound( il_prac_ids[] )
		tab_ltr.tabpage_criteria.dw_criteria.DataObject = "d_crit_pracs"
		FOR i = 1 TO li_prac_cnt
			li_nr = tab_ltr.tabpage_criteria.dw_criteria.InsertRow( 0 )
			tab_ltr.tabpage_criteria.dw_criteria.SetItem( li_nr, "prac_id", il_prac_ids[ i ] )
		END FOR
		of_run()
	end if
	//---------------------------- APPEON END ----------------------------
	
	Close( w_letter_generator )
//credentialing application signature follow up letter (all)  OR follow up with payer
// mskinner 17 nov 2004 -- begin
// add  -  or ib_qa_letter
ELSEIF ii_letter_id = 1002 OR ii_letter_id = 1004 OR ib_from_case_review  or ib_qa_letter THEN
// mskinner 17 nov 2004 -- end 
	of_run()
	Close( w_letter_generator )	
ELSE
	of_wizard( "Next" )
END IF





end event

type dw_corro from u_dw within tabpage_criteria
event pfc_after_select ( )
boolean visible = false
integer y = 816
integer width = 1472
integer height = 872
integer taborder = 21
boolean titlebar = true
string title = "Select Letter For Work Flow"
string dataobject = "d_letter_corro"
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )
IF li_row < 1 THEN
	Return
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
dw_select_report.selectrow(0,false)

end event

event constructor;This.of_Setupdateable(False )
This.of_SetTransObject( SQLCA)
//This.Retrieve()


end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event getfocus;call super::getfocus;ib_corro_flag = true
end event

event losefocus;call super::losefocus;this.selectrow(0,false)
end event

event other;call super::other;//------------------------------------------------------------- 
// Check to see if the title bar for this datawindow has been 
// clicked and prevent it
//-------------------------------------------------------------
If Message.WordParm = 61458 Then 
		Message.Processed = True
		Message.ReturnValue = 0 
End If
end event

type dw_select_report from u_dw within tabpage_criteria
event pfc_after_select ( )
integer y = 120
integer width = 1472
integer height = 1568
integer taborder = 11
boolean titlebar = true
string title = "Select Letter"
string dataobject = "d_letter_list"
boolean ib_isupdateable = false
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )
IF li_row < 1 THEN
	Return
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )


end event

event constructor;This.of_Setupdateable(False )
This.of_SetTransObject( SQLCA)
This.Retrieve()

// start code change --- 11.04.2005 MSKINNER
// not needed will filter out in drop doen
//if gi_case_review = 0 then //maha 100104
//    this.setfilter("letter_module <> 2")
//	this.filter()
//end if
// end code change --- 11.04.2005 MSKINNER

//Needed: If does not have intelliapp module filter out App status letters.
This.SelectRow( 1, True )
This.ScrollToRow( 1 )
This.SetRow( 1 )
end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_letter_dw
String ls_wizard_dw
Long ll_prac_ids[]

// mbs 06 dec 2004 -- begin
// if we are coming from quality profile do not do this code
if ib_qa_letter then return

// start code change --- 11.01.2005 MSKINNER
if rowcount() < 1 then return 
// end code change --- 11.01.2005 MSKINNER

// mbs 06 dec 2004 -- end
dw_letter.Reset()
dw_letter.of_SetTransObject( SQLCA )

il_current_wizard_step = 0
il_wizard_step_cnt = 0


IF NOT ib_from_net_dev AND NOT ib_from_case_review THEN
	SetNull( il_facility_id )
END IF
SetNull( il_profile_view_id )
SetNull( id_from )
SetNull( id_to )

dw_criteria.Visible = True
st_help_text.Text = ""
cb_next.Text = 'Next ->'

IF NOT ib_from_net_dev AND NOT ib_from_case_review THEN

	il_prac_ids = ll_prac_ids

	IF tab_ltr.tabpage_criteria.dw_criteria.DataObject = "d_crit_date_range" THEN
		tab_ltr.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()
	END IF

	ii_letter_id = This.GetItemNumber( currentrow, "letter_id" )
	ls_letter_dw = This.GetItemString( currentrow, "letter_dw" )

	tab_ltr.tabpage_criteria.dw_wizard_seq.of_SetTransObject( SQLCA )
	il_wizard_step_cnt  = tab_ltr.tabpage_criteria.dw_wizard_seq.Retrieve( 1 )
	il_current_wizard_step = 0

	IF il_wizard_step_cnt = 0 THEN
		tab_ltr.tabpage_criteria.dw_criteria.DataObject = ""
	ELSE
		of_wizard("Next")
	END IF

	tab_ltr.tabpage_criteria.dw_criteria.SetFocus()
	tab_ltr.SelectTab( 1 )
ELSE
	ii_letter_id = This.GetItemNumber( currentrow, "letter_id" )
	ls_letter_dw = This.GetItemString( currentrow, "letter_dw" )	
END IF

//net dev follow up with prac letter AND net dev follow up with payer letter	(ALL)
IF ii_letter_id = 1002 OR ii_letter_id = 1004 THEN
	dw_criteria.Visible = False
	st_help_text.Text = "Click Run to generate letter."
	cb_next.Text = 'Run'
//net dev follow up with prac letter AND net dev follow up with payer letter	(Individual)
ELSEIF ii_letter_id = 1001 OR ii_letter_id = 1003 THEN
	il_current_wizard_step = 1
	dw_criteria.DataObject = "d_crit_pracs"
	tab_ltr.tabpage_criteria.dw_criteria.Reset()
	tab_ltr.tabpage_criteria.dw_criteria.of_SetTransObject( SQLCA )
	tab_ltr.tabpage_criteria.st_help_text.Text = tab_ltr.tabpage_criteria.dw_wizard_seq.GetItemString(il_current_wizard_step , "help_text" )
	tab_ltr.tabpage_criteria.cb_search.Visible = True	
	il_facility_id = 1
	cb_next.Text = 'Run'
END IF



tab_ltr.tabpage_criteria.dw_criteria.PostEvent("pfc_cst_set_focus")
end event

event doubleclicked;call super::doubleclicked;IF ib_from_case_review THEN
	cb_next.TriggerEvent( Clicked! )
END IF
end event

event getfocus;call super::getfocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.24.2006 By: Jervis
//$<reason> 
ib_corro_flag = false
//---------------------------- APPEON END ----------------------------


end event

event other;call super::other;//------------------------------------------------------------- 
// Check to see if the title bar for this datawindow has been 
// clicked and prevent it
//-------------------------------------------------------------
If Message.WordParm = 61458 Then 
		Message.Processed = True
		Message.ReturnValue = 0 
End If
end event

type cb_close from commandbutton within w_letter_generator
integer x = 3186
integer width = 352
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//CloseWithReturn( Parent, "Cancel" )
Close( Parent )
end event

