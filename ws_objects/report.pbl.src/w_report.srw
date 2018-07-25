$PBExportHeader$w_report.srw
forward
global type w_report from w_main
end type
type cb_store from commandbutton within w_report
end type
type tab_rpt from u_tab_report_tab within w_report
end type
type tab_rpt from u_tab_report_tab within w_report
end type
type cb_close from u_cb within w_report
end type
type dw_report_log from datawindow within w_report
end type
end forward

global type w_report from w_main
integer x = 0
integer y = 0
integer width = 4096
integer height = 2452
string title = "Reports and Graphs"
long backcolor = 33551856
event pfc_cst_print_report ( )
cb_store cb_store
tab_rpt tab_rpt
cb_close cb_close
dw_report_log dw_report_log
end type
global w_report w_report

type variables

pfc_cst_u_reports inv_reports

boolean ib_peer_data
boolean ib_oppe
boolean ib_tracking_step = false //maha 07.16.2012

Integer Ii_num_of_departments
Integer ii_num_of_departments_user_has_access_to
Integer ii_dept_security_on = 0
Integer il_current_wizard_step = 0
Integer il_wizard_step_cnt = 0
Integer il_facility_ids_all[]
Integer il_facility_id
Integer il_profile_view_id
Integer ii_prac_cnt

integer ii_multi_grp_id
integer ii_prime_dept_only
integer ii_appt_stat[]
integer ii_batch_button
integer ii_export_id = 0
integer ii_using_export = 0
integer ii_staff_cat_status
integer ii_prov_status
integer ii_report_id = 0
integer ii_tracking_step = 0 //maha 07.16.2012

String is_group_name
String is_address_types
String is_facility_name
String is_provider_type
String is_users[]
String is_user
String is_user_name
String is_date_range_name
String is_sql
String is_sql_mod
String is_specialties
String is_net_dev_types
String is_department
String is_group
String is_group_id
string is_appmnt_status
string is_contracts
string is_assn_user
string is_priv_stat
string is_division
string is_section
string is_staff_cat
string is_affil_status
string is_sex
string  is_lookupcomm //add by stephen on 08-15-2011
string is_appl_track_field
string is_health_type = "ALL"   //Start Code Change ----09.01.2015 #V15 maha
string is_report_name  //maha 07.25.2016 - for run audit
string is_prov_name  //maha 07.25.2016 - for run audit
string is_cpr_type = "ALL"  //maha 10.26.2016
string is_verif_type  = "ALL" //maha 10.26.2016
string is_fee_type = "ALL"  //maha 10.26.2016
string is_verif_entity = "ALL"  //maha 10.26.2016

Long il_prac_id
long il_clin_id
long il_num_days
long il_dept[]
long il_prac_ids[]
long il_sex
long il_zoom
long il_multi_grp_id[]//add by Michael on 01.18.2012
long il_priv_stat[]  //maha 07.26.2012

String ls_group_id

long il_grp_loc

Date id_from
Date id_to
Date id_appt_from
Date id_appt_to
Date id_meet_from
Date id_meet_to
Date id_prov_from
Date id_prov_to

/* Contract Variables*/

long il_contact_id[] /* Contracts related to to the contact*/
long ll_ctx_status[] /* Contract Status*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.27.2006 By: Rodger Wu (Contract)
//$<reason> Define new variable used for Contract reports.

unsignedint ii_ctx_grouping = 1 //Grouping Way for contract list report;
string is_ctx_status, is_ctx_owner, is_ctx_category, is_ctx_service,is_ctx_Track_status
string is_ctx_data_contract, is_ctx_data_cptcode
string is_cptcode[]
Long il_ctxid[]
int ii_ctx_days = 0

//---------------------------- APPEON END ----------------------------

long il_StartYear // Add by Evan on 11.06.2007

String 	is_ctx_type,is_ctx_user						//Added by Scofield on 2008-05-22
long		il_Start_Status,il_End_Status				//Added by Scofield on 2008-05-26
long		il_StartStatus_1,il_EndStatus_1			//Added by Scofield on 2008-08-13
long		il_StartStatus_2,il_EndStatus_2			//Added by Scofield on 2008-08-13
long		il_StartStatus_3,il_EndStatus_3			//Added by Scofield on 2008-08-13
long		il_StartStatus_4,il_EndStatus_4			//Added by Scofield on 2008-08-13

str_dashboard str_para//For dashborad  Added by Nova 08.13.2008
Integer il_screen_view_id //Added by Alan on 2008-09-08
boolean ib_enabled        //Added by Alan on 2008-09-18
Boolean ib_auto_locate //Added By Ken.Guo 2008-09-27
//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
DataStore ids_ctx_user_noaccess //Added by Ken.Guo on 2009-04-20
Boolean ib_access_filter //Added by Ken.Guo on 2009-04-21
//---------End Added ------------------------------------------------------------------

end variables

forward prototypes
public function integer of_wizard (string as_direction)
public function integer of_run ()
public function integer of_run_graph ()
public function integer of_quick_ver (integer al_facility)
public function integer of_run_export_report (integer ai_export_id)
public function integer of_labels (string as_doc, string as_doc_path)
public subroutine of_contract_run (ref string as_sql)
public subroutine of_contract_wizard_current (string as_wizard_dw)
public function integer of_contract_wizard_next ()
public subroutine of_contract_wizard_prior ()
public subroutine of_contract_calc_crosstab ()
public subroutine of_dashboard (long ai_report_id)
public function integer of_log_report (integer ai_report)
public subroutine of_get_filter_status ()
public function integer of_filter_noaccess ()
public function long of_find_sql_key (string as_source, string as_sql_key)
end prototypes

event pfc_cst_print_report();//Start Code Change ----09.30.2011 #V12 maha - modify to show print dialog box`
boolean lb_dialog = false

if gi_print_dialog = 1 then
	lb_dialog = true
end if

tab_rpt.tabpage_report.dw_report.of_print(true,lb_dialog) //Change the "print" to "of_print" - alfee 01.05.2012

//tab_rpt.tabpage_report.dw_report.Modify("DataWindow.Print.Prompt=No")
//tab_rpt.tabpage_report.dw_report.Print()
//End Code Change ----09.30.2011


end event

public function integer of_wizard (string as_direction);String ls_sql_1
String ls_wizard_dw
String ls_last_wizard
String ls_val
String ls_dummy_array[]
String ls_action_status
String ls_action_type
string ls_export
Integer p
Integer li_rc
Integer li_found
Integer i
Integer li_dummy_array[]
Integer li_appt_row //maha073002
integer li_as_cnt = 0 //maha080902
DataWindowChild dwchild
Long    ll_Null[] //$<add> 04.07.2008 by Andy
integer li_appt_stat[]

tab_rpt.tabpage_criteria.dw_criteria.AcceptText()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.09.2007 By: Jack 
//$<reason> Fix a defect.
//If tab_rpt.tabpage_criteria.dw_wizard_seq.rowcount() < 1 Or tab_rpt.tabpage_criteria.dw_criteria.rowcount() < 1 Then
//	Return -1
//End If
If tab_rpt.tabpage_criteria.dw_wizard_seq.rowcount() < 1 then return -1	//05/10/2007 By Jervis
//---------------------------- APPEON END ----------------------------
IF as_direction = "Next" AND il_current_wizard_step > 0 THEN
	if tab_rpt.tabpage_criteria.dw_criteria.rowcount() < 1 then return -1	//05/10/2007 By Jervis
	tab_rpt.tabpage_criteria.cbx_peer.visible = false
	CHOOSE CASE tab_rpt.tabpage_criteria.dw_criteria.DataObject
		CASE "d_crit_address_type"
			is_address_types = " And ("
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "primary" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.primary_office = 1 OR "
			END IF
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "additional" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.additional_office = 1 OR "
			END IF			
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "billing" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.billing = 1 OR "
			END IF						
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "home" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.home_address = 1 OR "
			END IF
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "mailing" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.mailing = 1 OR "
			END IF
			is_address_types = MidA( is_address_types, 1, LenA( is_address_types ) -3 ) + ")"

			IF is_address_types = " And (" THEN
				MessageBox("Selection Error", "You must select at least one address Type. ")
				Return -1
			END IF
			
		CASE "d_crit_specialties"

			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_specialties = "ALL"
			ELSE
				is_specialties = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_specialties = is_specialties + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_specialties = MidA( is_specialties, 1, LenA( is_specialties ) -2 )
			END IF
			IF is_specialties  = "" THEN
				MessageBox("Selection Error", "You must check off at least one Specialty or select ALL." )
				Return -1
			END IF		

		CASE "d_crit_department", "d_crit_department_with_security", "d_crit_department_oppe"  //Start Code Change ----07.17.2009 #V92 maha (oppe)
			//if ii_num_of_departments_user_has_access_to = ii_num_of_departments then that means that the
			//department security is turned off OR the user has access to all departments
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 AND +&
			   ii_num_of_departments_user_has_access_to = ii_num_of_departments THEN
				is_department = "ALL"
			ELSE
				is_department = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 OR ii_num_of_departments_user_has_access_to <> ii_num_of_departments THEN
						IF tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "code" ) = "ALL" THEN
							CONTINUE
						END IF
						//Modify 07/31/2007 by: Andy
						//is_department = is_department + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "code" )) + "', "
						is_department = is_department + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( i, "lookup_code" )) + "', "
						//end of Modify
						il_dept[i] = tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( i, "lookup_code" )
					END IF
				END FOR
				is_department = MidA( is_department, 1, LenA( is_department ) -2 )
			END IF
			IF is_department = "" THEN
				MessageBox("Selection Error", "You must check off at least one department or select ALL." )
				Return -1
			END IF
			//Start Code Change ----09.25.2008 #V85 maha - removed because it was resetting the value at the wrong time
			//\/maha 061102
//			if this.tab_rpt.tabpage_criteria.cbx_primary_only.visible = true then
//				ii_prime_dept_only = 1
//			else
//				ii_prime_dept_only = 0
//			end if
			//\maha
			//End Code Change---09.25.2008
			if  tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_department_oppe" then ib_oppe = true
			
		//------------------- APPEON BEGIN -------------------
		//$<add> Stephen 08.15.2011
		//$<reason> Add Committee Criteria selector  <V11.3 Meeting Upgrade>
		case "d_crit_lookupcomme"
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 then
			   is_lookupcomm = "ALL"
			ELSE
				is_lookupcomm = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 then 
						IF tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "code" ) = "ALL" THEN
							CONTINUE
						END IF
						is_lookupcomm = is_lookupcomm + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( i, "lookup_code" )) + "', "
						il_dept[i] = tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( i, "lookup_code" )
					END IF
				END FOR
				is_lookupcomm = MidA( is_lookupcomm, 1, LenA( is_lookupcomm ) -2 )
			END IF
			IF is_lookupcomm = "" THEN
				MessageBox("Selection Error", "You must check off at least one Committee or select ALL." )
				Return -1
			END IF
           //------------------- APPEON END -------------------

		CASE "d_crit_net_dev_type"
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_net_dev_types = "ALL"
			ELSE
				is_net_dev_types = " AND "
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						ls_action_status = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "custom_3" ) 
						IF ls_action_status = '' OR IsNull( ls_action_status ) THEN
							MessageBox("Incomplete", "If you select an Action Type you must select and Action Status." )
							Return -1
						END IF
						ls_action_type =  tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "code" )
						is_net_dev_types = "( action_type = '" + ls_action_type + "' AND action_status = '" + ls_action_status + "') OR"
						//is_net_dev_types = is_net_dev_types + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "code" )) + "', "
					END IF
				END FOR
				is_net_dev_types = MidA( is_net_dev_types, 1, LenA( is_net_dev_types ) -2 )

				IF LenA( is_net_dev_types ) < 4 THEN
					MessageBox("Selection Error", "You must check off at least one Action Type or select ALL." )
					Return -1
				END IF		
			END IF			
			//Messagebox("", is_net_dev_types )
			//tab_rpt.tabpage_criteria.dw_criteria.Retrieve()			
		CASE "d_crit_provider_type"
			is_provider_type = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( 1, "provider_type" )
		CASE "d_crit_user"
			is_user = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( 1, "user_id" )
			is_users = ls_dummy_array
			IF is_user = "0" THEN
				li_rc = dwchild.RowCount()
				FOR i = 2 TO li_rc
					is_users[i] = dwchild.GetItemString( i, "user_id" )
				END FOR
				is_user_name = "ALL"					
			ELSE
				il_facility_ids_all[1] = il_facility_id
				li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
				IF li_found > 0 THEN
					is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
				END IF
			END IF
			//Start Code Change ----04.06.2009 #V92 maha - ameripath
		CASE "d_crit_user_multi"
			if tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( 1, "selected" ) = 1 then
				//skip for ALL
			else
				//debugbreak()
				p = 0
				is_users = ls_dummy_array
				for i = 2 to tab_rpt.tabpage_criteria.dw_criteria.rowcount()
					if tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( i, "selected" ) = 1 then
						p++
						is_users[p] = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "user_id" )
					end if 
				next
			end if
			//End Code Change---04.06.2009
		CASE "d_crit_date_range"
			id_from = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "from_date" )
			id_to = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "to_date" )
			IF IsNull( id_from ) AND NOT IsNull( id_to ) THEN
				MessageBox( "Required Data", "You must enter in a From Date." )
				Return -1
			ELSEIF IsNull( id_to ) AND NOT IsNull( id_from ) THEN
				MessageBox( "Required Data", "You must enter in a To Date." )
				Return -1
			ELSEIF IsNull( id_to ) AND IsNull( id_from ) THEN   //Start Code Change ----12.07.2011 #V12 maha - trap for no dates
				MessageBox( "Required Data", "Date Range is required." )
				Return -1
			END IF
			tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()
			is_date_range_name = String( id_from, "mm/dd/yyyy" ) + " - " + String( id_to, "mm/dd/yyyy" )
		CASE "d_crit_appt_date_range" ,  "d_crit_appt_date_range_inova"   //Start Code Change ----11.28.2011 #V12 maha - added inova date range
			id_appt_from = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "from_date" )
			id_appt_to = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "to_date" )
			IF IsNull( id_appt_from ) AND NOT IsNull( id_appt_to ) THEN
				MessageBox( "Required Data", "You must enter in a From Date." )
				Return -1
			ELSEIF IsNull( id_appt_to ) AND NOT IsNull( id_appt_from ) THEN
				MessageBox( "Required Data", "You must enter in a To Date." )
				Return -1
			ELSEIF IsNull( id_appt_from ) AND IsNull( id_appt_to ) THEN    //Start Code Change ----12.07.2011 #V12 maha - trap for no dates
				MessageBox( "Required Data", "Date Range Required" )
				Return -1
			END IF
			tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()
			is_date_range_name = String( id_from, "mm/dd/yyyy" ) + " - " + String( id_to, "mm/dd/yyyy" )
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-05-26 By: Scofield
		//$<Reason> Force the user to input start status and end status
		
		Case "d_rpt_ctx_wiz_status_select"
			il_Start_Status = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus")
			il_End_Status = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus")
			IF IsNull( il_Start_Status ) THEN
				MessageBox( "Required Data", "You must enter in start status." )
				tab_rpt.tabpage_criteria.dw_criteria.SetColumn("as_startstatus")
				tab_rpt.tabpage_criteria.dw_criteria.SetFocus()
				Return -1
			ELSEIF IsNull( il_End_Status ) THEN
				MessageBox( "Required Data", "You must enter in end status." )
				tab_rpt.tabpage_criteria.dw_criteria.SetColumn("as_endstatus")
				tab_rpt.tabpage_criteria.dw_criteria.SetFocus()
				Return -1
			END IF
		//---------------------------- APPEON END ----------------------------
		CASE "d_crit_prov_date_range" //maha 042804 inova readded 033005
			//messagebox("","date range")
			id_prov_from = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "from_date" )
			id_prov_to = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "to_date" )
			ii_prov_status = tab_rpt.tabpage_criteria.dw_criteria.Getitemnumber( 1, "p_status" )
			if ii_prov_status <> 1 then ii_prov_status = 0
			IF IsNull( id_prov_from ) AND NOT IsNull( id_prov_to ) THEN
				MessageBox( "Required Data", "You must enter a From Date." )
				Return -1
			ELSEIF IsNull( id_prov_to ) AND NOT IsNull( id_prov_from ) THEN
				MessageBox( "Required Data", "You must enter a To Date." )
				Return -1
			END IF
			tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()			
		CASE "d_crit_meeting_date_range"
			id_meet_from = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "from_date" )
			id_meet_to = tab_rpt.tabpage_criteria.dw_criteria.GetItemDate( 1, "to_date" )
			IF IsNull( id_meet_from ) AND NOT IsNull( id_meet_to ) THEN
				MessageBox( "Required Data", "You must enter in a From Date." )
				Return -1
			ELSEIF IsNull( id_to ) AND NOT IsNull( id_from ) THEN
				MessageBox( "Required Data", "You must enter in a To Date." )
				Return -1
			END IF
			tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_UnRegister()
			is_date_range_name = String( id_from, "mm/dd/yyyy" ) + " - " + String( id_to, "mm/dd/yyyy" )			
		CASE "d_crit_pracs"
			ii_prac_cnt = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			IF ii_prac_cnt = 0 THEN
				MessageBox("Selection Error", "You must select at least one practitioner." )
				Return -1
			END IF
			FOR p = 1 TO ii_prac_cnt
				il_prac_ids[p] = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( p, "prac_id" )
				//messagebox("il_prac_ids",ii_prac_cnt)
			END FOR
		CASE "d_crit_org_facility"
			tab_rpt.tabpage_criteria.dw_criteria.GetChild( "facility_id", dwchild )				
			//dwchild.SetTransObject( SQLCA )
			//dwchild.Retrieve( gs_user_id )
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()  
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a specific Facility. ")
				Return -1
			ELSE
				il_facility_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "facility_id" )			
				li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
				IF li_found > 0 THEN
					is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
				END IF
			END IF
			IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN
				il_facility_ids_all = li_dummy_array
				IF il_facility_id = 0 THEN
					li_rc = dwchild.RowCount()
					FOR i = 2 TO li_rc
						il_facility_ids_all[i -1] = dwchild.GetItemNumber( i, "facility_id" )
					END FOR
					is_facility_name = "ALL"
					//$<add> 05.22.2008 by Andy
					//$<Reason> fixed BugN050605,BugN050608
					if UpperBound(il_facility_ids_all) = 0 then il_facility_ids_all[1] = 0
					//end 05.22.2008 
				ELSE
					il_facility_ids_all[1] = il_facility_id
					li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
					IF li_found > 0 THEN
						is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
					END IF
				END IF
			END IF

		CASE "d_crit_group"
			tab_rpt.tabpage_criteria.dw_criteria.GetChild( "group_id", dwchild )				
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a specific Group. ")
				Return -1
			ELSE
				ls_group_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( 1, "group_id" )			
				li_found = dwchild.Find( "group_id = '" + ls_group_id + "'" , 1, 1000 )					
				IF li_found > 0 THEN
					is_group_name = dwchild.GetItemString( li_found, "description" )					
					is_group_id = dwchild.GetItemString( li_found, "lookup_code" )					
				ELSE
					is_group_name = "ALL"
				END IF
			END IF
			
		CASE "d_crit_group_pract" //maha modified 080902
			tab_rpt.tabpage_criteria.dw_criteria.GetChild( "group_id", dwchild )				
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()
			//MessageBox("ls_val","Im here")
				//ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText() 
				il_grp_loc = long(ls_val)
			//	MessageBox("ls_val",il_grp_loc)
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a specific Group. ")
				Return -1

			END IF
		CASE "d_crit_multi_group"
 			//------------------- APPEON BEGIN -------------------
			//$<modify> Michael 01.18.2012
			//$<reason>Bug 2870 enhancement request 
			/*
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText() 
			ii_multi_grp_id = integer(ls_val)
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a Goup Practice. ")
				Return -1
			ELSE
				ii_multi_grp_id = long(ls_val)
			END IF
			*/			
			il_multi_grp_id[] = li_appt_stat[]
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			for i = 2 TO li_rc 
				if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1  then
					il_multi_grp_id[i] = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "rec_id" )
				else
					if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 then
						il_multi_grp_id[i] = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "rec_id" )
					end if
				end if
			next
			if UpperBound(il_multi_grp_id) < 1 then
				MessageBox("Selection Error", "You must select a Goup Practice. " )
				Return -1
			end if		
			//------------------- APPEON END ---------------------
		CASE "d_crit_profile_view"

			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()  
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a Profile View. ")
				Return -1
			ELSE
				il_profile_view_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "profile_view_id" )				
			END IF
			//\/maha073002
		CASE "d_crit_screen_view"
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()  
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a Screen View. ")
				Return -1
			ELSE
				il_screen_view_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "data_view_id" )				
			END IF

		CASE "d_crit_appmnt_status"
			is_appmnt_status = ""
			ii_appt_stat[] = li_appt_stat[]  //add by stephen 09.28.2011 -bug 2676
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "active" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "1,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 1
			END IF
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "pending" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "4,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 4
			END IF			
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "inactive" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "3,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 3
			END IF						
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "history1" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "0,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 0
			END IF
			//Start Code Change ----10.10.2014 #V14.2 maha
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "midcycle" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "6,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 0
			END IF
			//End Code Change ----10.10.2014
			if is_appmnt_status = "" then
				MessageBox("Selection Error", "You must select at least one status. ")
				Return -1
			ELSE
				is_appmnt_status =  MidA( is_appmnt_status, 1, LenA( is_appmnt_status ) -1 )
			end if
			

			//\maha
					//*mike 01-13-00
		CASE "d_crit_clin_area"
			ls_val = tab_rpt.tabpage_criteria.dw_criteria.GetText()
				il_clin_id = integer(ls_val)			
			//MessageBox("il_clin_id ", il_clin_id )
			
			IF ls_val = "" OR IsNull( ls_val ) THEN
				MessageBox("Selection Error", "You must select a specific Clinical Area. ")
				Return -1
			END IF
		//\maha
			//*maha 05-30-00
		CASE "d_crit_num_days"
			ls_val = string(tab_rpt.tabpage_criteria.dw_criteria.getitemnumber(1,"num_days"))
				il_num_days = long(ls_val)			
				//MessageBox("il_clin_id ", il_clin_id )
				
				IF ls_val = "" OR IsNull( ls_val ) or il_num_days < 1  THEN   //Start Code Change ----12.18.2015 #V15 maha added trap on num of days.
				//IF ls_val = "" OR IsNull( ls_val )  then THEN
					MessageBox("Selection Error", "You must select an Expiration period in days greater than 0. ")
					Return -1
				END IF

		CASE "d_crit_contract" //maha 021803 for ultimed
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_contracts = "ALL"
			ELSE
				is_contracts = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_contracts = is_contracts + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_contracts = MidA( is_contracts, 1, LenA( is_contracts ) -2 )
			END IF
			IF is_contracts  = "" THEN
				MessageBox("Selection Error", "You must check off at least one Contract or select ALL." )
				Return -1
			END IF
		case "d_crit_assigned_user" //maha 091103
			//<modify> 08/24/2007 by: Andy
			is_assn_user = trim(tab_rpt.tabpage_criteria.dw_criteria.GetItemstring( 1, "user_id" ))
			
		CASE "d_crit_export" //maha 021803 for ultimed	
			ii_export_id = integer(tab_rpt.tabpage_criteria.dw_select_report.getitemstring(tab_rpt.tabpage_criteria.dw_select_report.getrow(),"graph_dw"))
			ii_using_export = 1
			select export_name into :ls_export from export_header where export_id = :ii_export_id;
			tab_rpt.tabpage_criteria.dw_criteria.object.exp_name.text = ls_export
			
		case "d_crit_priv_status" //maha 091803

				is_priv_stat = ""
				il_priv_stat[] =  li_dummy_array[]  //Start Code Change ----10.22.2012 #V12 maha
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_priv_stat = is_priv_stat + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
						il_priv_stat[upperbound(il_priv_stat) + 1] =  tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )  //Start Code Change ----07.26.2012 #V12 maha
					END IF
				END FOR
				is_priv_stat = MidA( is_priv_stat, 1, LenA( is_priv_stat ) - 2 )

			IF is_priv_stat  = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case "d_crit_division" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_division = "ALL"
			else
				is_division = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_division = is_division + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_division = MidA( is_division, 1, LenA( is_division ) -2 )
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-05-27 By: Scofield
			//$<Reason> At least select one check box.

			IF is_division = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case "d_crit_section" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_section = "ALL"
			else
				is_section = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_section = is_section + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_section = MidA( is_section, 1, LenA( is_section ) -2 )
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-05-27 By: Scofield
			//$<Reason> At least select one check box.

			IF is_section = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case "d_crit_staff_cat" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_staff_cat = "ALL"
			else
				is_staff_cat = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_staff_cat = is_staff_cat + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_staff_cat = MidA( is_staff_cat, 1, LenA( is_staff_cat ) -2 )
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-05-27 By: Scofield
			//$<Reason> At least select one check box.

			IF is_staff_cat = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case "d_crit_gender" //maha 020204
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_sex = "ALL"
			else
				is_sex = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_sex = is_sex + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_sex = MidA( is_sex, 1, LenA( is_sex ) -2 )
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-05-27 By: Scofield
			//$<Reason> At least select one check box.

			IF is_sex = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case "d_crit_affil_status" //maha 021704
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_affil_status = "ALL"
			else
				is_affil_status = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_affil_status = is_affil_status + "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemstring( i, "code" )) + "', "
					END IF
				END FOR
				is_affil_status = MidA( is_affil_status, 1, LenA( is_affil_status ) -2 )
			end if
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2008-05-27 By: Scofield
			//$<Reason> At least select one check box.

			IF is_affil_status = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			//---------------------------- APPEON END ----------------------------
		case 'd_crit_contract_det_contact'
			   long ll_i
				il_contact_id = ll_null //$<add> 04.07.2008 by Andy
				tab_rpt.tabpage_criteria.dw_criteria.accepttext( )
			
			   for ll_i = 1 to tab_rpt.tabpage_criteria.dw_criteria.rowcount()
						if long(tab_rpt.tabpage_criteria.dw_criteria.object.selected[ll_i]) = 1 then 
				   		il_contact_id[upperbound(il_contact_id) + 1] = long(tab_rpt.tabpage_criteria.dw_criteria.object.contact_id[ll_i])
			    		end if 
			   next
			 
		case 'd_crit_contract_status'
			ll_ctx_status = ll_null //$<add> 04.07.2008 by Andy
			tab_rpt.tabpage_criteria.dw_criteria.accepttext( )
			for ll_i = 1 to tab_rpt.tabpage_criteria.dw_criteria.rowcount()
				if long(tab_rpt.tabpage_criteria.dw_criteria.object.selected[ll_i]) = 1 then 
					ll_ctx_status[upperbound(ll_ctx_status) + 1] = long(tab_rpt.tabpage_criteria.dw_criteria.object.lookup_code[ll_i])
			 	end if 
			 next
			 
	//Start Code Change ----07.16.2012 #V12 maha - code for tracking step 
		case 'd_crit_appl_tracking_step'
			tab_rpt.tabpage_criteria.dw_criteria.accepttext( )
			ii_tracking_step = tab_rpt.tabpage_criteria.dw_criteria.GetItemnumber( 1, "selected" )
			choose case ii_tracking_step
				case 1
					is_appl_track_field = "step_1"
				case 2
					is_appl_track_field =  "step_2" 
				case 3
					is_appl_track_field =  "step_3" 
				case 4
					is_appl_track_field = "step_4" 
				case 5
					is_appl_track_field = "step_5"
				case 6
					is_appl_track_field = "step_6"
				case 7
					is_appl_track_field = "step_7" 
				case 8
					is_appl_track_field =  "step_8" 
				case 9
					is_appl_track_field =  "step_9" 
				case 10
					is_appl_track_field =  "step_10" 
			end choose
	//Start Code Change ----07.16.2012			
	
	 //Start Code Change ----09.01.2015 #V15 maha		
		case "d_crit_health" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_health_type = "ALL"
			else
				is_health_type = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_health_type = is_health_type +  String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" ))  + ", "
					END IF
				END FOR
				is_health_type = MidA(is_health_type, 1, LenA( is_health_type ) -2 )
			end if

			IF is_health_type = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
		//End Code Change ----09.01.2015
		
	 //Start Code Change ----10.26.2016 #V15.3 maha		
		case "d_crit_verif_type" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_verif_type = "ALL"
			else
				is_verif_type = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_verif_type = is_verif_type + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_verif_type = MidA(is_verif_type, 1, LenA( is_verif_type ) -2 )
			end if

			IF is_verif_type = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			
		case "d_crit_fee_type" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_fee_type = "ALL"
			else
				is_fee_type = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_fee_type = is_fee_type + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_fee_type = MidA(is_fee_type, 1, LenA( is_fee_type ) -2 )
			end if

			IF is_fee_type = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF

		case "d_crit_cpr" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_cpr_type = "ALL"
			else
				is_cpr_type = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_cpr_type = is_cpr_type + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_cpr_type = MidA(is_cpr_type, 1, LenA( is_cpr_type ) -2 )
			end if

			IF is_cpr_type = "" THEN
				MessageBox("Selection Error", "You must at least select one check box." )
				Return -1
			END IF
			
		case "d_crit_verif_entity" //maha 091803
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
				is_verif_entity = "ALL"
			else
				is_verif_entity = ""
				li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_verif_entity = is_verif_entity + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_verif_entity = MidA(is_verif_entity, 1, LenA( is_verif_entity ) -2 )
			end if
			
		//End Code Change ----10.26.2016		

		CASE ELSE
			if of_contract_wizard_next() < 0 then Return -1
		
	END CHOOSE
	
//@@@@@@@@@@@@@@@@RUN@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

	IF tab_rpt.tabpage_criteria.cb_next.Text = "Run" THEN

		IF tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_pracs" and ii_using_export <> 1 then

			choose case tab_rpt.tabpage_report.dw_report.DataObject
				case "d_prf_master"//,"d_prf_ver_results,d_rpt_priv_list_of_prac_all_facil,d_rpt_grant_priv_list_by_clin_area,d_rpt_prac_granted_priv_list"  // loop through the prac list and print
					FOR i = 1 TO ii_prac_cnt
						tab_rpt.tabpage_criteria.dw_criteria.SelectRow( 0, False )
						tab_rpt.tabpage_criteria.dw_criteria.SelectRow( i, True )
						tab_rpt.tabpage_criteria.dw_criteria.SetRow( i )
						il_prac_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "prac_id" )
						of_run()
					END FOR
				case else
					of_run()
			end choose
		ELSE
			of_run()
		END IF
		Return 0
	END IF
ELSE //  NOT: as_direction = "Next" AND il_current_wizard_step > 0 
	CHOOSE CASE tab_rpt.tabpage_criteria.dw_criteria.DataObject
		CASE "d_crit_address_type"
			is_address_types = ""
		CASE "d_crit_specialties"
			is_specialties = ""
		CASE "d_crit_provider_type"
			is_provider_type = ""
		CASE "d_crit_user"
			is_users[] = ls_dummy_array
		CASE "d_crit_user_multi" ////Start Code Change ----04.06.2009 #V92 maha - ameripath
			is_users[] = ls_dummy_array
		CASE "d_crit_date_range"
			SetNull( id_from )
			SetNull( id_to )
			is_date_range_name = ""
		CASE "d_crit_appt_date_range"
			SetNull( id_appt_from )
			SetNull( id_appt_to )
		CASE "d_crit_appt_date_range_inova"  //Start Code Change ----11.28.2011 #V12 maha - added
			SetNull( id_appt_from )
			SetNull( id_appt_to )
			is_date_range_name = ""
		CASE "d_crit_prov_date_range"
			SetNull( id_prov_from )
			SetNull( id_prov_to )
			ii_prov_status = 0
			is_date_range_name = ""
		CASE "d_crit_meeting_date_range"
			SetNull( id_meet_from )
			SetNull( id_meet_to )
			is_date_range_name = ""
		CASE "d_crit_pracs"
			
		CASE "d_crit_org_facility"
			SetNull( il_facility_id )
			is_facility_name = ""
			il_facility_ids_all = li_dummy_array
		CASE "d_crit_profile_view"
			SetNull( il_profile_view_id )
		CASE "d_crit_screen_view"
			SetNull( il_screen_view_id )	
		CASE "d_crit_contracts"	
			is_contracts = ""
		CASE "d_crit_priv_status"   //maha 091803 
			is_priv_stat = ""
			il_priv_stat = ll_null
		Case"d_crit_division"  //maha 091803 
			is_division = ""
		CASE "d_crit_section"   //maha 091803 
			is_section = ""
		CASE "d_crit_staff_cat"    //maha 091803 
			is_staff_cat = ""
			ii_staff_cat_status = -1
		CASE "d_crit_affil_status"   //maha 010103 	
			is_affil_status = "ALL"
		case "d_crit_assigned_user" //maha 020204
			is_assn_user = "ALL"
		case "d_crit_gender"   //maha 020204 	
			is_sex = "ALL"
		 //Start Code Change ----09.01.2015 #V15 maha	
		case "d_crit_num_days"   
			il_num_days = 0
		Case"d_crit_health"  
			is_health_type = "ALL"
	//Start Code Change ----10.26.2016 #V153 maha - added
		Case"d_crit_cpr"  
			is_cpr_type = "ALL"
		Case"d_crit_verif_type"  
			is_verif_type = "ALL"
		Case"d_crit_fee"   
			is_fee_type = "ALL"
		Case"d_crit_verif_entity"  
			is_verif_entity = "ALL"
	//End Code Change ----10.26.2016
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-08-01 By: Rodger Wu (Contract)
		//$<reason> Modification for contract report.
		case else
			of_contract_wizard_prior()
		//---------------------------- APPEON END ----------------------------
	END CHOOSE
END IF

IF as_direction = "Next" THEN
	il_current_wizard_step = il_current_wizard_step + 1
ELSE
	il_current_wizard_step = il_current_wizard_step - 1
END IF

tab_rpt.tabpage_criteria.cb_search.Visible = False
tab_rpt.tabpage_criteria.cb_batch.Visible = False

ls_last_wizard = tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "wizard_last_step" )
ls_wizard_dw = tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "wizard_dw" )
//if security is on and user does not have access to all departments then do this
IF ls_wizard_dw = "d_crit_department" AND ii_num_of_departments_user_has_access_to <> ii_num_of_departments THEN
	tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_department_with_security"
ELSE
	tab_rpt.tabpage_criteria.dw_criteria.DataObject = ls_wizard_dw
END IF
tab_rpt.tabpage_criteria.dw_criteria.Reset()
tab_rpt.tabpage_criteria.dw_criteria.of_SetTransObject( SQLCA )
//$<modify> 07.09.2008 by Andy
String ls_help_text,ls_label
ls_help_text = tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString(il_current_wizard_step , "help_text" )
IF ls_wizard_dw = "d_crit_org_facility" THEN
	SELECT TOP 1 app_stat_facility_label INTO :ls_label FROM icred_settings;	
	if LenA(trim(ls_label)) > 0 then 
		ls_help_text = 'Select ' + ls_label
	end if
END IF
//tab_rpt.tabpage_criteria.st_help_text.Text = tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString(il_current_wizard_step , "help_text" )
tab_rpt.tabpage_criteria.st_help_text.Text = ls_help_text
//end modify 07.09.2008
IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
	tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 0 )
END IF
IF ls_wizard_dw = "d_crit_specialties"  THEN    //OR ls_wizard_dw = "d_crit_address_type"
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Specialties" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )		
	END IF	
ELSEIF ls_wizard_dw = "d_crit_department" OR ls_wizard_dw = "d_crit_department_with_security" OR ls_wizard_dw = "d_crit_department_oppe" THEN    
	//if security is on and user does not have access to all departments then do this
	IF ls_wizard_dw = "d_crit_department" AND ii_num_of_departments_user_has_access_to <> ii_num_of_departments THEN
		tab_rpt.tabpage_criteria.dw_criteria.Retrieve( gs_user_id )
	ELSE
		tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	END IF
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Departments" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
		// mbs migration this.tab_rpt.tabpage_criteria.cbx_primary_only.visible = true
		this.tab_rpt.tabpage_criteria.cbx_primary_only.checked = true
ELSEIF ls_wizard_dw = "d_crit_net_dev_type"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Selections" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )		
	END IF
ELSEIF ls_wizard_dw = "d_crit_appmnt_status"  THEN   		//maha 073002
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "active", 1 )		
ELSEIF ls_wizard_dw = "d_crit_date_range" THEN
	tab_rpt.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
ELSEIF ls_wizard_dw = "d_crit_appt_date_range" THEN
	tab_rpt.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
ELSEIF ls_wizard_dw = "d_crit_appt_date_range_inova" THEN  //Start Code Change ----11.28.2011 #V12 maha
	tab_rpt.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
ELSEIF ls_wizard_dw = "d_crit_prov_date_range" THEN
	tab_rpt.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
	tab_rpt.tabpage_criteria.dw_criteria.setitem(1,"p_status",1)	
ELSEIF ls_wizard_dw = "d_crit_meeting_date_range" THEN
	tab_rpt.tabpage_criteria.dw_criteria.of_SetDropDownCalendar( TRUE )
	tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.of_Register(tab_rpt.tabpage_criteria.dw_criteria.iuo_calendar.DDLB)
ELSEIF ls_wizard_dw = "d_crit_pracs" THEN
	tab_rpt.tabpage_criteria.cb_search.Visible = True
	if tab_rpt.tabpage_criteria.dw_select_report.GetItemString( tab_rpt.tabpage_criteria.dw_select_report.getrow(), "graph_dw" ) = "X" then
		tab_rpt.tabpage_criteria.cb_batch.Visible = false
	else
		IF not gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
			tab_rpt.tabpage_criteria.cb_batch.Visible = true
		end if
	end if
	if tab_rpt.tabpage_criteria.dw_select_report.getitemnumber(tab_rpt.tabpage_criteria.dw_select_report.getrow(),"report_id") = 2 then //make peer checkbox visible only for profile report
		if gi_case_review = 1 then
			tab_rpt.tabpage_criteria.cbx_peer.visible = true
		else
			tab_rpt.tabpage_criteria.cbx_peer.visible = false
		end if
	end if
	tab_rpt.tabpage_criteria.dw_criteria.Title = "Select Practitioner"
ELSEIF ls_wizard_dw = "d_crit_user" THEN
	tab_rpt.tabpage_criteria.cb_search.Visible = False
	tab_rpt.tabpage_criteria.cb_batch.Visible = false
	tab_rpt.tabpage_criteria.dw_criteria.GetChild( "user_id", dwchild )				
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN				 		
		dwchild.InsertRow(1)
		dwchild.SetItem( 1, "user_id", "ALL")
	END IF
//Start Code Change ----04.06.2009 #V92 maha - ameripath
elseif  ls_wizard_dw =  "d_crit_user_multi" then
	tab_rpt.tabpage_criteria.cb_search.Visible = False
	tab_rpt.tabpage_criteria.cb_batch.Visible = false
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "user_id", "Include ALL Users" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )		
	END IF	
//End Code Change---04.06.2009
ELSEIF ls_wizard_dw = "d_crit_org_facility" THEN
	tab_rpt.tabpage_criteria.dw_criteria.GetChild( "facility_id", dwchild )				
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( gs_user_id )	
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN				 		
		dwchild.InsertRow(1)
		dwchild.SetItem( 1, "facility_id", 0 )
		dwchild.SetItem( 1, "facility_name", "ALL")
	END IF

	
ELSEIF ls_wizard_dw = "d_crit_clin_area" then //maha 01-13-00

	tab_rpt.tabpage_criteria.dw_criteria.settransobject(sqlca)
	DataWindowChild dwchild1
	//------------------- APPEON BEGIN -------------------
	//$<delete> Michael 09.30.2011
	//$<reason> Bug 2685 vertical scroll bar active
	/*
	tab_rpt.tabpage_criteria.dw_criteria.retrieve()
	tab_rpt.tabpage_criteria.dw_criteria.insertrow(1)
	*/
	//------------------- APPEON END ---------------------
	tab_rpt.tabpage_criteria.dw_criteria.GetChild( "clinical_area_description", dwchild1 )
	dwchild1.settransobject(sqlca)
	dwchild1.retrieve(il_facility_id)
	
ELSEIF ls_wizard_dw = "d_crit_contract"  THEN   //maha 02-18-03 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "entity_name", "Include ALL Products/Contracts" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_assigned_user" then //maha 091103 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	//tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
	If tab_rpt.tabpage_criteria.dw_criteria.rowcount( ) <= 0 Then tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )  //Modified by (Appeon) Harry 05.30.2016 For Bug # 5182
	tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "user_id", "ALL" )
	
ELSEIF ls_wizard_dw = "d_crit_priv_status"  THEN   //maha 091803 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
//		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )  //Start Code Change ----07.26.2012 #V12 maha - removed
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Statuses" )		
//		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_division"  THEN   //maha 091803 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Divisions" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_section"  THEN   //maha 091803 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Sections" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
ELSEIF ls_wizard_dw = "d_crit_staff_cat"  THEN   //maha 091803 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Staff Categories" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
		ii_staff_cat_status = 1
	END IF	
ELSEIF ls_wizard_dw = "d_crit_affil_status"  THEN   //maha 100103 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Statuses" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
ELSEIF ls_wizard_dw = "d_crit_gender"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Genders" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
ELSEIF ls_wizard_dw = "d_crit_num_days"  THEN     //Start Code Change ----09.01.2015 #V15 maha - set default days
		if tab_rpt.tabpage_criteria.dw_criteria.rowcount() < 1 then //(Appeon)Stephen 05.16.2016 - V15.1 Bug # 5160 - Standard Reports->Expiring DEA list by Dept shows 2 areas for select # of days to expiration
			tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		end if
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "num_days", 30 )

	
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 08.15.2011
//$<reason> Add Committee Criteria selector  <V11.3 Meeting Upgrade>
ELSEIF ls_wizard_dw = "d_crit_lookupcomme"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Committee" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF	
//------------------- APPEON END -------------------	
	
ELSEIF ls_wizard_dw = "d_crit_contract_det_contact"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
ELSEIF ls_wizard_dw = "d_crit_contract_status"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
ELSEIF ls_wizard_dw = "d_crit_multi_group" THEN //Michael 01.30.2012 Bug 2870 enhancement request
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.insertrow( 1)
		tab_rpt.tabpage_criteria.dw_criteria.setitem( 1,"gp_name","Include ALL")
		tab_rpt.tabpage_criteria.dw_criteria.setitem( 1,"rec_id",0)
		tab_rpt.tabpage_criteria.dw_criteria.setitem( 1,"selected",0)
	END IF	
	
ELSEIF  ls_wizard_dw =  'd_crit_appl_tracking_step' then //Start Code Change ----07.16.2012 #V12 maha
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
		
 //Start Code Change ----09.01.2015 #V15 maha		
ELSEIF ls_wizard_dw = "d_crit_health"  THEN   //maha 091803 
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Types" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF		
 //End Code Change ----09.01.2015	
 
 //Start Code Change ----10.26.2016 #V153 maha
ELSEIF ls_wizard_dw = "d_crit_cpr"  THEN  
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Types" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_verif_type"  THEN   
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Types" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_fee_type"  THEN    
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL Types" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
	
ELSEIF ls_wizard_dw = "d_crit_verif_entity"  THEN   
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "entity_name", "Include ALL Entities" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF	
 //End Code Change ----10.26.2016
 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-01 By: Rodger Wu (Contract)
//$<reason> Modification for contract report.
Else
	of_contract_wizard_current( ls_wizard_dw )
//---------------------------- APPEON END ----------------------------
END IF
	
if tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_department" OR +&
   tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_department_with_security" then
	this.tab_rpt.tabpage_criteria.cbx_primary_only.visible = true
	ii_prime_dept_only = 1//Start Code Change ----09.25.2008 #V85 maha - added to reset this value
else
	this.tab_rpt.tabpage_criteria.cbx_primary_only.visible =  false
end if
if tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_staff_cat" then //maha 092303
	//ls_sql_1 = tab_rpt.tabpage_report.dw_report.GetSQLSelect( )
	//IF POS( UPPER( ls_sql_1), "PD_AFFIL_STAFF_CAT")  > 1 THEN
	this.tab_rpt.tabpage_criteria.ddlb_status.visible = true
	this.tab_rpt.tabpage_criteria.ddlb_status.selectitem( 1)   //Start Code Change ----11.06.2015 #V15 maha - default to active
	tab_rpt.tabpage_criteria.st_status.visible = true
	//END IF
else
 tab_rpt.tabpage_criteria.ddlb_status.visible = false
 tab_rpt.tabpage_criteria.st_status.visible = false
end if
IF il_current_wizard_step = 1 THEN
	tab_rpt.tabpage_criteria.cb_prior.Enabled = False
ELSE
	tab_rpt.tabpage_criteria.cb_prior.Enabled = True
END IF

IF il_current_wizard_step = il_wizard_step_cnt  THEN
	//here check to see 
//	if 1 =1 then //of_check_for_appt_stat then
//		if ii_appt_stat = 0 then
//			il_wizard_step_cnt ++
//			ii_appt_stat = 1
//			li_appt_row = tab_rpt.tabpage_criteria.dw_wizard_seq.insertrow(0)
//			tab_rpt.tabpage_criteria.dw_wizard_seq.setitem(li_appt_row,"wizard_last_step","Y")
//			tab_rpt.tabpage_criteria.dw_wizard_seq.setitem(li_appt_row,"wizard_dw","d_crit_appmnt_status")
//			tab_rpt.tabpage_criteria.dw_wizard_seq.setitem(li_appt_row,"insert_blank_row","Y")
//			tab_rpt.tabpage_criteria.dw_wizard_seq.setitem(li_appt_row,"report_id",0)
//		end if
//	else
		tab_rpt.tabpage_criteria.cb_next.Text = "Run"
//	end if
ELSE
	tab_rpt.tabpage_criteria.cb_next.Text = "Next->"
END IF

tab_rpt.tabpage_criteria.dw_criteria.SetFocus()

IF as_direction = "Prior" THEN
	CHOOSE CASE tab_rpt.tabpage_criteria.dw_criteria.DataObject
		CASE "d_crit_address_type"
			is_address_types = ""
		CASE "d_crit_specialties"
			is_specialties = ""
		CASE "d_crit_provider_type"
			is_provider_type = ""
		CASE "d_crit_user"
			is_users[] = ls_dummy_array
		CASE "d_crit_date_range"
			SetNull( id_from )
			SetNull( id_to )
			is_date_range_name = ""
		CASE "d_crit_appt_date_range"
			SetNull( id_appt_from )
			SetNull( id_appt_to )
			is_date_range_name = ""
		CASE "d_crit_appt_date_range_inova"  //Start Code Change ----11.28.2011 #V12 maha - added
			SetNull( id_appt_from )
			SetNull( id_appt_to )
			is_date_range_name = ""
		CASE "d_crit_prov_date_range"
			SetNull( id_prov_from )
			SetNull( id_prov_to )
			ii_prov_status = -1
			is_date_range_name = ""
		CASE "d_crit_meeting_date_range"
			SetNull( id_meet_from )
			SetNull( id_meet_to )
			is_date_range_name = ""
		CASE "d_cs"
			SetNull( il_prac_id )
			il_prac_ids[] = li_dummy_array
		CASE "d_crit_org_facility"
			SetNull( il_facility_id )
			is_facility_name = ""
			il_facility_ids_all = li_dummy_array
		CASE "d_crit_profile_view"
			SetNull( il_profile_view_id )
		CASE "d_crit_screen_view"
			SetNull( il_screen_view_id )			
		CASE "d_crit_priv_status"   //maha 091803 
			is_priv_stat = ""
			il_priv_stat = ll_null
			Case"d_crit_division"  //maha 091803 
			is_division = ""
		CASE "d_crit_section"   //maha 091803 
			is_section = ""
		CASE "d_crit_staff_cat"    //maha 091803 
			is_staff_cat = ""
			ii_staff_cat_status = -1
		CASE "d_crit_affil_status"   //maha 010103 	
			is_affil_status = "ALL"
		case "d_crit_assigned_user" //maha 020204
			is_assn_user = "ALL"
		CASE "d_crit_genger"   //maha 020204 	
			is_sex = "ALL"
		case "d_crit_pracs" //maha 051005
			SetNull( il_prac_id )
			il_prac_ids[] = li_dummy_array
			
	//Start Code Change ----10.26.2016 #V153 maha - added			
		Case"d_crit_health"   
			is_health_type = "ALL"
		Case"d_crit_cpr"  
			is_cpr_type = "ALL"
		Case"d_crit_verif_type"   
			is_verif_type = "ALL"
		Case"d_crit_fee" 
			is_fee_type = "ALL"
		Case"d_crit_verif_entity"   
			is_verif_type = "ALL"
	//End Code Change ----10.26.2016
	
	END CHOOSE
END IF

Return 0

end function

public function integer of_run ();long p
String ls_sql
String ls_word_path
string ls_report
Integer i
integer li_speclink
string ls_from
string ls_to
string ls_prac_ids
//integer res
long res//long.zhang 11.20.2012	
integer li_user_cnt //maha 062509
integer li_facility_cnt//nova 02.21.2010
string ls_facility_list//nova 02.21.2010
//////
integer li_set6
long ll_log  //maha 06.06.2016
string ls_prac_name
string ls_stataus
string ls_departmen
string ls_provider_id
string ls_apptmnt_start_date
string ls_last_reappointment_date
string ls_staff_category
string ls_division
string ls_primary_speciality,ls_department
string ls_list //maha 062509
datetime ldt_from, ldt_to //stephen 05.10.2011
integer li_new[]   //stephen 09.30.2011 -Bug 2686 
time lt_start
time lt_end

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-28 By: Cao YongWang
//$<reason> 
string ls_filter
long   li_prac_cnt //Stephen 05/20/2011
ls_filter = ''
//---------------------------- APPEON END ----------------------------

//--------------NOTES--------------
//Start Code Change ----08.06.2010 #V10 maha - for all date range functions modified to include time for the To Date.
//
lt_start = time(now())

ll_log = of_log_sys_report("S","MAN","", ii_report_id , is_report_name )  //Start Code Change ----06.06.2016 #V152 maha
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.13.2006 By: Cao YongWang
//$<modification> Create the downloading directory if it does not exist.
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
	Upper( appeongetclienttype() ) = 'WEB' Then
	n_appeon_download lnv_downlaod
	lnv_downlaod.of_parsepath( gs_temp_path + "Letters\data\")
End If
//---------------------------- APPEON END ----------------------------

is_sql_mod = ""
IF tab_rpt.tabpage_criteria.dw_criteria.DataObject = "d_crit_pracs" THEN
    il_prac_ids = li_new //add by stephen 09.30.2011 -Bug 2686 
	ii_prac_cnt = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
	IF ii_prac_cnt = 0 THEN
		MessageBox("Selection Error", "You must select at least one practitioner." )
		Return -1
	END IF
	il_prac_id = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( tab_rpt.tabpage_criteria.dw_criteria.GetRow(), "prac_id" )
	FOR p = 1 TO ii_prac_cnt
		il_prac_ids[p] = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( p, "prac_id" )
		//messagebox("il_prac_ids",ii_prac_cnt)
	END FOR	
end if
//IF tab_rpt.tabpage_report.dw_report.DataObject <> "d_rpt_quick_verification" THEN

ls_sql = is_sql
ls_report = tab_rpt.tabpage_report.dw_report.DataObject

if ii_using_export = 1 then //export based report
	//messagebox("ii_export_id",ii_export_id)
	if ii_export_id > 0 then
		of_run_export_report(ii_export_id)
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
	else
		messagebox("Run Error","This report is expecting an export id.  Check report data (from graph_dw field)")
		return -1
	end if
else //all other reports
//messagebox("ls_report",ls_report)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-01 By: Rodger Wu (Contract)
//$<reason> Running contract report according to the judgement of datawindow name.
//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
  /*
     IF Left( ls_report, 10 ) = "d_rpt_ctx_" THEN 
  */
 IF Left( ls_report, 10 ) = "d_rpt_ctx_" or ls_report = 'r_ctx_contracts_by_assn'  THEN
//---------End Modfiied ------------------------------------------------------------------
	of_contract_run( ls_sql )
ELSE
//---------------------------- APPEON END ----------------------------
 ldt_from = datetime(id_from,time('00:00:00')) //Add by Stephen 05.10.2011 --- Fixed a bug 2395.
 ldt_to     = datetime(id_to, time('23:59:59'))    //Add by Stephen 05.10.2011 --- Fixed a bug 2395.
 
//debugbreak()
CHOOSE CASE tab_rpt.tabpage_report.dw_report.DataObject
	//CASE "d_rpt_prac_participation_status"
	//	//debugbreak()
	//	IF Upper( is_facility_name ) <> "ALL" THEN
	//		ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
	//	END IF		
	//	tab_rpt.tabpage_report.dw_report.retrieve( )			
	CASE "d_rpt_meetings_cme", "d_rpt_meetings_department","d_rpt_meetings_committee", "d_rpt_meetings_section","d_rpt_meetings_cme_lowell", "d_rpt_lookup_committee"

		//--------Begin Modified by  Nova 02.21.2010------------------------
//		IF Upper( is_facility_name ) <> "ALL" THEN
//			ls_sql = ls_sql + " AND ( facility = " + String( il_facility_id ) + ")"		
//		END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND ( facility = " + String( il_facility_id ) + ")"  //Start Code Change ----08.03.2010 #V10 maha - changed from facility_id
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND ( facility  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010

		
		IF is_department <> "ALL" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The column alias('department_desc') can not be used in WHERE clause in SQL  Server database
			//ls_sql = ls_sql + " AND ( department_desc IN ( " + is_department + "))"	
			//ls_sql = ls_sql + " AND ( code_lookup.code IN ( " + is_department + "))"//commented by  Nova 09.03.2009
			  ls_sql = ls_sql + " AND ( code_lookup.lookup_code IN ( " + is_department + "))"//added by Nova 09.03.2009
			//---------------------------- APPEON END ----------------------------
		END IF
		
		//------------------- APPEON BEGIN -------------------
		//$<add> Stephen 08.15.2011
		//$<reason> Add Committee Criteria selector  <V11.3 Meeting Upgrade>
		if is_lookupcomm <>'ALL' and tab_rpt.tabpage_report.dw_report.DataObject ='d_rpt_lookup_committee' THEN
			ls_sql = ls_sql + " AND ( code_lookup.lookup_code IN ( " + is_lookupcomm + "))"
		end if
		//------------------- APPEON BEGIN -------------------

		IF Not IsNull( id_meet_from ) THEN  //maha 012904
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The date function DATE type is unsupported by SQL Server
			//ls_sql = ls_sql + " AND ( Date( meetings.start_date )  >= Cast('" + String( id_meet_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( meetings.start_date )  <= Cast('" + String( id_meet_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND ( ( meetings.start_date )  >= Cast('" + String( id_meet_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( meetings.start_date )  <= Cast('" + String( id_meet_to, 'yyyy/mm/dd' ) + " 23:59:59" +  "' AS DATETIME ) )"		
			//---------------------------- APPEON END ----------------------------			
		//-------Begin Modified by alfee 08.29.2011 (BugS081701 )-----------
		END IF					
		
		IF is_section <> "ALL" THEN  
				ls_sql = ls_sql + " AND ( code_lookup.lookup_code IN ( " + is_section + "))"			
		END IF
		////Start Code Change ----08.22.2011 #V11 maha - added missing code
		//IF is_section <> "ALL" THEN  
		//		ls_sql = ls_sql + " AND ( code_lookup.lookup_code IN ( " + is_section + "))"			
		//	END IF
		//END IF
		////Start Code Change ----08.22.2011	
		//-------End Modified ------------------------------------------------------
		
//		IF Upper( is_facility_name ) <> "ALL" OR is_department <> "ALL" THEN
			//openwithparm(w_sql_msg, ls_sql)
			tab_rpt.tabpage_report.dw_report.SetSQLSelect( ls_sql )			
			tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )									
			res = tab_rpt.tabpage_report.dw_report.Retrieve( )						
//		ELSE
//			tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
//			tab_rpt.tabpage_report.dw_report.Retrieve( )			
//		END IF		

		//--------Begin Added by Alfee 01.02.2014------------------------
		//<$Reason>For Web version issue.
		IF tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_meetings_cme_lowell" THEN
			DataWindowChild dwc_rpt_lowell_header
			tab_rpt.tabpage_report.dw_report.getchild ("dw_1",dwc_rpt_lowell_header)
			dwc_rpt_lowell_header.settransobject(sqlca)
			res = dwc_rpt_lowell_header.retrieve()
		END IF
		//--------End Added --------------------------------------------------

	CASE "d_rpt_par_numbers_detailed"
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_prac_ids )	
	CASE "d_rpt_par_numbers_details_new"   //Start Code Change ----07.15.2013 #V14 maha - new version
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_prac_ids )	
		//---------Begin Added by (Appeon)Stephen 06.09.2015 for Bug id 4555 - Plan Type not showing in the Participation Number Detail Report V14--------
		tab_rpt.tabpage_report.dw_report.GetChild( "net_dev_ids_plan_type", dwc_rpt_lowell_header )
		dwc_rpt_lowell_header.SetTransObject( SQLCA )
		dwc_rpt_lowell_header.Retrieve("Plan Type")
		//---------End Added ------------------------------------------------------
	CASE "d_rpt_par_numbers_details_new_addr"   //Start Code Change ----09.23.2013 #V14 maha - new version
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_prac_ids )	
		//---------Begin Added by (Appeon)Stephen 06.09.2015 for Bug id 4555 - Plan Type not showing in the Participation Number Detail Report V14--------
		tab_rpt.tabpage_report.dw_report.GetChild( "net_dev_ids_plan_type", dwc_rpt_lowell_header )
		dwc_rpt_lowell_header.SetTransObject( SQLCA )
		dwc_rpt_lowell_header.Retrieve("Plan Type")
		//---------End Added ------------------------------------------------------
	CASE "d_rpt_par_numbers"
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_prac_ids )		
	CASE "d_rpt_quick_verification"
		tab_rpt.tabpage_report.dw_report.Reset()
		of_quick_ver( il_facility_id ) 
		res = tab_rpt.tabpage_report.dw_report.rowcount()   //Start Code Change ----07.25.2016 #V152 maha
	CASE "d_rpt_specialties_brd_or_not_master"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.28.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id )
		*/
		tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id, is_facility_name)
		//---------------------------- APPEON END ----------------------------
		//Start Code Change ----07.18.2016 #V152 maha - added for log
		tab_rpt.tabpage_report.dw_report.getchild ("dw_1",dwc_rpt_lowell_header)
		dwc_rpt_lowell_header.settransobject(sqlca)
		res = dwc_rpt_lowell_header.rowcount()
		//End Code Change ----07.18.2016
	CASE "d_prf_master"
		if tab_rpt.tabpage_criteria.cbx_peer.checked then 
			ib_peer_data = true
		else
			ib_peer_data = false
		end if
		inv_reports.of_profile_report_v8( tab_rpt.tabpage_report.dw_report, il_facility_id, il_prac_id, il_profile_view_id,ib_peer_data, tab_rpt.tabpage_criteria.dw_profile_temp,il_screen_view_id  )	
		select full_name into :is_prov_name from v_full_name where prac_id = :il_prac_id;
		//inv_reports.of_profile_report_v8( tab_rpt.tabpage_report.dw_report, il_facility_id, il_prac_id, il_profile_view_id,ib_peer_data )
		res = 1  //Start Code Change ----07.25.2016 #V152 maha
	CASE "d_prf_ver_results"
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all, il_prac_ids[])		
	CASE "d_rpt_expiring_provisional_appoints", "d_rpt_expiring_provisional_by_dept" //maha 091103 inova
		ls_sql = is_sql
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//		IF Upper( is_facility_name ) <> "ALL" THEN
		//			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		//		END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010

		IF Not IsNull( id_appt_from ) THEN	
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> the date() function and DATE type in ASA database is unsupported by SQL Server
			//ls_sql = ls_sql + " AND	 ( Date( pd_AFFIL_STAT.init_prov_period_to )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//"Date( pd_AFFIL_STAT.init_prov_period_to )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND	 ( ( pd_AFFIL_STAT.init_prov_period_to )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
			"( pd_AFFIL_STAT.init_prov_period_to )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' )  + " 23:59:59" + "' AS DATETIME ) )"		

			//---------------------------- APPEON END ----------------------------

		End if	
		if upper(is_assn_user) <> "ALL" then
			//modify 08/24/2007 by: Andy
			ls_sql = ls_sql + " AND ( Ltrim(RTRIM(pd_AFFIL_STAT.priority_user)) = '" + is_assn_user + "')"
		end if
		if tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_expiring_provisional_by_dept" then
			IF Upper( is_department ) <> "ALL" THEN
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2005-11-28 By: Cao YongWang
				//$<reason> The column alias('dep') can not be used in WHERE clause in SQL Server, Using SetFilter() function to filter data
				//ls_sql = ls_sql + " AND ( dep IN ( " + is_department + "))"
				//<Modify> 07/31/2007 by: Andy
				//ls_filter = "dep IN ( " + is_department + ")"
				ls_sql = ls_sql + " AND ( pd_affil_dept.department IN ( " + is_department + "))"
				//end of modify
				//---------------------------- APPEON END ----------------------------
			END IF
			
			IF ii_prime_dept_only = 1 THEN
				ls_sql = ls_sql + " AND (pd_affil_dept.primary_dept = 1)"
			END IF
			IF Upper( is_division ) <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_dept.rank IN ( " + is_division + "))"			
			END IF
			IF Upper(is_section ) <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_dept.section IN ( " + is_section + "))"			
			END IF
			IF Upper( is_staff_cat ) <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_staff_cat.staff_category IN ( " + is_staff_cat + "))"			
			END IF
			IF ii_staff_cat_status  > -1 and ls_report <> "d_rpt_expiring_provisional_by_dept"THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_staff_cat.requested = " + string(ii_staff_cat_status)	+ ")"			
			END IF
			IF Upper( is_affil_status ) <> "ALL" THEN  //maha 010103
				ls_sql = ls_sql + " AND ( pd_affil_stat.Affiliation_status IN ( " + is_affil_status + "))"				
			END IF
		end if
		
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-28 By: Cao YongWang
		//$<reason> 
		If ls_filter <> '' Then
			tab_rpt.tabpage_report.dw_report.setfilter(ls_filter)
			tab_rpt.tabpage_report.dw_report.filter()
		End If
		//---------------------------- APPEON END ----------------------------
	CASE "d_rpt_expiring_appointments_by_dept", "d_rpt_expiring_appointments", "d_rpt_expiring_appointments_by_month" , "d_rpt_expiring_ah_appointments_by_dept" //maha 091103 inova //maha 03.07.2013 added AH report
		ls_sql = is_sql
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//IF Upper( is_facility_name ) <> "ALL" THEN
		//	ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010
		
		if upper(is_assn_user) <> "ALL" then
			//modify 08/24/2007 by: Andy
			ls_sql = ls_sql + " AND ( Ltrim(RTRIM(pd_AFFIL_STAT.priority_user)) = '" + is_assn_user + "')"
		end if
		
		IF Not IsNull( id_appt_from ) THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason>The date() function and DATE data type in ASA database is unsupported by SQL Server database
			//ls_sql = ls_sql + " AND	 ( Date( pd_AFFIL_STAT.apptmnt_end_date )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( pd_AFFIL_STAT.apptmnt_end_date )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND	 ( ( pd_AFFIL_STAT.apptmnt_end_date )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( pd_AFFIL_STAT.apptmnt_end_date )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) )"		
			//---------------------------- APPEON END ----------------------------
		end if	
		
		if tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_expiring_appointments_by_dept" then
			IF is_department <> "ALL" THEN
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 2005-11-28 By: Cao YongWang
				//$<reason> The column alias('dep') can not be used in WHERE clause in SQL Server, Using SetFilter() function to filter data
				//ls_sql = ls_sql + " AND ( dep IN ( " + is_department + "))"
				//<Modify> 07/31/2007 by: Andy
				//ls_filter = "dep IN ( " + is_department + ")"
				ls_sql = ls_sql + " AND ( pd_affil_dept.department IN ( " + is_department + "))"
				//end of modify
				//---------------------------- APPEON END ----------------------------
			END IF
			
			IF ii_prime_dept_only = 1 THEN
				ls_sql = ls_sql + " AND (pd_affil_dept.primary_dept = 1)"
			END IF
			IF is_division <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_dept.rank IN ( " + is_division + "))"			
			END IF
			IF is_section <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_dept.section IN ( " + is_section + "))"			
			END IF
			IF is_staff_cat <> "ALL" THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_staff_cat.staff_category IN ( " + is_staff_cat + "))"			
			END IF
			IF ii_staff_cat_status > -1 THEN  //maha 091803
				ls_sql = ls_sql + " AND ( pd_affil_staff_cat.requested = " + string(ii_staff_cat_status)+ ")"				
			END IF
			IF is_affil_status <> "ALL" THEN  //maha 010103
				ls_sql = ls_sql + " AND ( pd_affil_stat.Affiliation_status IN ( " + is_affil_status + "))"				
			END IF
		end if

		
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-28 By: Cao YongWang
		//$<reason> 
		If ls_filter <> '' Then
			tab_rpt.tabpage_report.dw_report.setfilter(ls_filter)
			tab_rpt.tabpage_report.dw_report.filter()
		End If
		//---------------------------- APPEON END ----------------------------
	//CASE 	"d_rpt_dir_by_prac_name_by_dept"
	//	tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all)

	CASE "d_rpt_workflow_dates"
		if IsNull(id_from) then id_from = 1800-01-01				//Added by Scofield on 2008-05-27
		if IsNull(id_to) then id_to = 3000-12-31					//Added by Scofield on 2008-05-27
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all, id_from, id_to )
	CASE "d_rpt_workflow_crosstab_master"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.28.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		tab_rpt.tabpage_report.dw_report.retrieve( id_from, id_to, il_facility_id )
		*/
		
		if IsNull(id_from) then id_from = 1800-01-01							//Added by Scofield on 2008-05-27
		if IsNull(id_to) then id_to = 3000-12-31								//Added by Scofield on 2008-05-27
		
		res = tab_rpt.tabpage_report.dw_report.retrieve( id_from, id_to, il_facility_id, is_facility_name)
		//---------------------------- APPEON END ----------------------------
	CASE "d_rpt_workflow_crosstab_master_all"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.28.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		tab_rpt.tabpage_report.dw_report.retrieve( id_from, id_to )
		*/
		
		if is_date_range_name = " - " then is_date_range_name = ""		//Added by Scofield on 2008-05-27
		if IsNull(id_from) then id_from = 1800-01-01							//Added by Scofield on 2008-05-27
		if IsNull(id_to) then id_to = 3000-12-31								//Added by Scofield on 2008-05-27
		
		res = tab_rpt.tabpage_report.dw_report.retrieve( id_from, id_to, is_date_range_name)
		//---------------------------- APPEON END ----------------------------
	CASE "d_rpt_labels"
	
	

		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010	

		ls_sql = is_sql
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//IF Upper( is_facility_name ) <> "ALL" THEN
		//	ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		//	ls_sql = ls_sql + " AND ( pd_spec_facility_link.facility_id = " + String( il_facility_id) + ")"
		//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
			ls_sql = ls_sql + " AND ( pd_spec_facility_link.facility_id = " + String( il_facility_id) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
					ls_sql = ls_sql + " AND ( pd_spec_facility_link.facility_id in (" + ls_facility_list + "))"
			end if
		End If
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010	

		IF is_provider_type <> "ALL" THEN
			ls_sql = ls_sql + " AND (code_lookup_h.code IN ( '" + is_provider_type  + "'))"			
		END IF
		IF is_specialties <> "ALL" THEN
			ls_sql = ls_sql + " AND ( pd_board_specialty.specialty IN ( " + is_specialties + "))"
		END IF		
		IF is_address_types <> "ALL" THEN
			ls_sql = ls_sql + is_address_types
		END IF	
		ls_sql = ls_sql + " AND ( pd_AFFIL_STAT.ACTIVE_STATUS IN ( " + is_appmnt_status + "))" //maha073102
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )

		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		IF tab_rpt.tabpage_report.dw_report.RowCount() > 0 THEN
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.txt", TEXT!, True )	
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.xls", excel!, True )
			if li_set6 = 5 then //maha readdd to allow old method
				ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-02
				//$<modify> 01.17.2006 By: Cao YongWang
				//$<reason> The Web application does not need to check whether there is an INI file on local machine.
				//$<modification> Make an condition that when the application runs on the Web, the application does not check
				//$<modification> the local INI file.
				//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
				//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
				//	Return -1
				//END IF	
				If appeongetclienttype() = 'PB' Then
					IF NOT FileExists( gs_IniFilePathName ) THEN
						MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
						Return -1
					END IF	
				End If
				//---------------------------- APPEON END ----------------------------
		
				Run(ls_word_path + " " +  gs_temp_path + "letters\standard\mailing_labels.doc" + " /mpreview", Minimized!)
			else
				of_labels("mailing_labels.doc",gs_temp_path + "letters\standard\mailing_labels.doc")
			end if
		END IF
	CASE "d_rpt_labels_by_dept"
		
		ls_sql = is_sql
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//IF Upper( is_facility_name ) <> "ALL" THEN
		//	ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010

		IF is_department <> "ALL" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The column alias('dep') can not be used in WHERE clause in SQL Server, Using SetFilter() function to filter data
			//ls_sql = ls_sql + " AND ( dep IN ( " + is_department + "))"
			//<Modify> 07/31/2007 by: Andy
			//ls_filter = "dep IN ( " + is_department + ")"
			ls_sql = ls_sql + " AND ( pd_affil_dept.department IN ( " + is_department + "))"
			//end of modify
			//---------------------------- APPEON END ----------------------------
		END IF
		
		IF ii_prime_dept_only = 1 THEN
			ls_sql = ls_sql + " AND (pd_affil_dept.primary_dept = 1)"
		END IF
		IF is_specialties <> "ALL" THEN
			ls_sql = ls_sql + " AND ( pd_board_specialty.specialty IN ( " + is_specialties + "))"
		END IF		
		IF is_address_types <> "ALL" THEN
			ls_sql = ls_sql + is_address_types
		END IF
		IF is_division <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.rank IN ( " + is_division + "))"			
		END IF
		IF is_section <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.section IN ( " + is_section + "))"			
		END IF
//		IF is_staff_cat <> "ALL" THEN  //maha 091803
//			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.staff_category IN ( " + is_staff_cat + "))"			
//		END IF
		IF ii_staff_cat_status > -1 THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.requested = " + string(ii_staff_cat_status)	+ ")"			
		END IF
		IF is_affil_status <> "ALL" THEN  //maha 010103
			ls_sql = ls_sql + " AND ( pd_affil_stat.Affiliation_status IN ( " + is_affil_status + "))"				
		END IF
		ls_sql = ls_sql + " AND ( pd_AFFIL_STAT.ACTIVE_STATUS IN ( " + is_appmnt_status + "))"
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-28 By: Cao YongWang
		//$<reason> 
		If ls_filter <> '' Then
			tab_rpt.tabpage_report.dw_report.setfilter(ls_filter)
			tab_rpt.tabpage_report.dw_report.filter()
		End If
		//---------------------------- APPEON END ----------------------------
		IF tab_rpt.tabpage_report.dw_report.RowCount() > 0 THEN
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.txt", TEXT!, True )	
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.xls", excel!, True )
			if li_set6 = 5 then //maha readdd to allow old method
				ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-03
				//$<modify> 01.17.2006 By: Cao YongWang
				//$<reason> The Web application does not need to check whether there is an INI file on local machine.
				//$<modification> Make an condition that when the application runs on the Web, the application does not check
				//$<modification> the local INI file.
				//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
				//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
				//	Return -1
				//END IF			
				If appeongetclienttype() = 'PB' Then
					IF NOT FileExists(gs_IniFilePathName) THEN
						MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
						Return -1
					END IF	
				End If
				//---------------------------- APPEON END ----------------------------

				Run(ls_word_path + " " +  gs_temp_path + "letters\standard\mailing_labels.doc" + " /mpreview", Minimized!)
			else
				of_labels("mailing_labels.doc",gs_temp_path + "letters\standard\mailing_labels.doc")
			end if			
		END IF
	CASE "d_rpt_labels_by_dept_sc"
		
		ls_sql = is_sql
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//IF Upper( is_facility_name ) <> "ALL" THEN
		//	ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010
		IF is_department <> "ALL" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The column alias('dep') can not be used in WHERE clause in SQL Server, Using SetFilter() function to filter data
			//ls_sql = ls_sql + " AND ( dep IN ( " + is_department + "))"
			//<Modify> 07/31/2007 by: Andy
			//ls_filter = "dep IN ( " + is_department + ")"
			ls_sql = ls_sql + " AND ( pd_affil_dept.department IN ( " + is_department + "))"
			//end of modify
			//---------------------------- APPEON END ----------------------------
		END IF
		
		IF ii_prime_dept_only = 1 THEN
			ls_sql = ls_sql + " AND (pd_affil_dept.primary_dept = 1)"
		END IF
		IF is_specialties <> "ALL" THEN
			ls_sql = ls_sql + " AND ( pd_board_specialty.specialty IN ( " + is_specialties + "))"
		END IF		
		IF is_address_types <> "ALL" THEN
			ls_sql = ls_sql + is_address_types
		END IF
		IF is_division <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.rank IN ( " + is_division + "))"			
		END IF
		IF is_section <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.section IN ( " + is_section + "))"			
		END IF
		IF is_staff_cat <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.staff_category IN ( " + is_staff_cat + "))"			
		END IF
		IF ii_staff_cat_status > -1 THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.requested = " + string(ii_staff_cat_status)	+ ")"			
		END IF
		IF is_affil_status <> "ALL" THEN  //maha 010103
			ls_sql = ls_sql + " AND ( pd_affil_stat.Affiliation_status IN ( " + is_affil_status + "))"				
		END IF
		ls_sql = ls_sql + " AND ( pd_AFFIL_STAT.ACTIVE_STATUS IN ( " + is_appmnt_status + "))"
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-28 By: Cao YongWang
		//$<reason> 
		If ls_filter <> '' Then
			tab_rpt.tabpage_report.dw_report.setfilter(ls_filter)
			tab_rpt.tabpage_report.dw_report.filter()
		End If
		//---------------------------- APPEON END ----------------------------
		IF tab_rpt.tabpage_report.dw_report.RowCount() > 0 THEN
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.txt", TEXT!, True )	
			tab_rpt.tabpage_report.dw_report.SaveAs(gs_temp_path + "letters\data\mailing_labels.xls", excel!, True )
			if li_set6 = 5 then //maha readdd to allow old method
				ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-04
				//$<modify> 01.17.2006 By: Cao YongWang
				//$<reason> The Web application does not need to check whether there is an INI file on local machine.
				//$<modification> Make an condition that when the application runs on the Web, the application does not check
				//$<modification> the local INI file.
				//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
				//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
				//	Return -1
				//END IF
				If appeongetclienttype() = 'PB' Then
					IF NOT FileExists(gs_IniFilePathName) THEN
						MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName)
						Return -1
					END IF
				End If
				//---------------------------- APPEON END ----------------------------
			
				Run(ls_word_path + " " +  gs_temp_path + "letters\standard\mailing_labels.doc" + " /mpreview", Minimized!)
			else
				of_labels("mailing_labels.doc",gs_temp_path + "letters\standard\mailing_labels.doc")
			end if				
		END IF
		//*maha 06/20/00
	CASE "d_rpt_priv_list_of_prac_all_facil"// report down below
		//tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all, il_prac_id )
		//messagebox("", res )
 //*maha 06/20/00
	CASE "d_rpt_grant_priv_list_by_clin_area"
		res = tab_rpt.tabpage_report.dw_report.retrieve(  /*il_prac_id*/ il_prac_ids ,il_facility_ids_all ) //modify by stephen 09.30.2011 -Bug 2686
 //*maha 07/31/02
	CASE "d_rpt_grant_priv_list_in_a_clin_area"
		res = tab_rpt.tabpage_report.dw_report.retrieve(  il_clin_id,il_facility_ids_all )
	//CASE "d_rpt_prac_participation_status_by_prac"
	//*\maha
		//tab_rpt.tabpage_report.dw_report.retrieve(  il_prac_id,il_facility_ids_all )	
	
	//JAD 03/28/02	
	//CASE "d_rpt_prac_part_status_by_grp_by_pln"
		
	//*maha 06/20/00		
	CASE "d_rpt_clin_area_by_facility"
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id )
	//*\maha	
	//*maha 06/21/00	
	CASE "d_rpt_priv_by_clin_area_by_facil"
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id, il_clin_id)
	//*\maha	
	//*maha 01/12/00   
	CASE "d_rpt_prac_priv_list_by_clin_area"
		res = tab_rpt.tabpage_report.dw_report.retrieve(  il_clin_id, il_facility_id )
	//*\maha	
	//*maha 05/30/00  
	CASE "d_rpt_release_expires_60_days"
		res = tab_rpt.tabpage_report.dw_report.retrieve(  il_facility_ids_all,il_num_days,ii_appt_stat[] )
	//*\maha
	//*maha 06/08/00  
	CASE "d_rpt_verifs_inc_on_files_closed"
		res = tab_rpt.tabpage_report.dw_report.retrieve(  id_from, id_to , il_facility_ids_all,ii_appt_stat[])
	//*\maha
	//*maha 10/30/00  
//	CASE "d_rpt_maxed_attempts"
//		tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all )
	//\/maha 02/16/01
	CASE "d_rpt_group_practitioner_list_1_group"
		//messagebox("il_grp_loc",il_grp_loc)
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_grp_loc,ii_appt_stat[] )
	CASE "d_rpt_group_practs_all_location_in_multi"
		//messagebox("ii_multi_grp_id",ii_multi_grp_id)
		//Modify Michael 01.18.2012 Bug 2870 enhancement request
		//res = tab_rpt.tabpage_report.dw_report.retrieve( ii_multi_grp_id,ii_appt_stat[]) 
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_multi_grp_id[],ii_appt_stat[],il_facility_ids_all[])  
	//*\maha
	CASE "d_rpt_inova_staffcat_speclty_composite"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.28.2006 By: LiuHongXin
		//$<reason> Fix a defect.
		/*
		tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id)
		*/
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_id, is_facility_name)
		//---------------------------- APPEON END ----------------------------
	CASE "d_rpt_meetings_all_inova" //maha 020204
		res = tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all, id_from, id_to, il_prac_ids[] )
	// MSKINNER 25 OCT 2004 -- BEGIN
	CASE 'd_rpt_pd_qa_detail', 'd_rpt_pd_qa_detail_comparison'
			if il_facility_id = 0 then setnull(il_facility_id)
			if tab_rpt.tabpage_report.dw_report.retrieve(il_prac_id,il_facility_id, ii_appt_stat ) > 0 then
			datawindowchild dw_child
			// note the processing has been changed to 5 from 0 inorder for the getchild() to work
			n_cst_report_helper l_nvo 
			long  ll_department_code
			l_nvo = create n_cst_report_helper
			l_nvo.of_set_prac_header(gl_prac_id, &
											 ls_prac_name,  &
											 ls_stataus,  &
											 ls_department, &
											 ls_provider_id, &
											 ls_apptmnt_start_date,  &
											 ls_last_reappointment_date,&
											 ls_staff_category,  &
											 ls_division,  &
											 ls_primary_speciality, ll_department_code,il_facility_id)//Start Code Change ----10.04.2006 #670 maha
				
			 tab_rpt.tabpage_report.dw_report.object.prac_name[1] = ls_prac_name
			 tab_rpt.tabpage_report.dw_report.object.stataus[1] = ls_stataus
			 tab_rpt.tabpage_report.dw_report.object.department[1] = ls_department
			 tab_rpt.tabpage_report.dw_report.object.provider_id[1] = ls_provider_id
			 tab_rpt.tabpage_report.dw_report.object.apptmnt_start_date[1] = ls_apptmnt_start_date
			 tab_rpt.tabpage_report.dw_report.object.last_reappointment_date[1] = ls_last_reappointment_date
			 tab_rpt.tabpage_report.dw_report.object.staff_category[1] = ls_staff_category
			 tab_rpt.tabpage_report.dw_report.object.division[1] = ls_division
			 tab_rpt.tabpage_report.dw_report.object.primary_speciality[1] = ls_primary_speciality
			 tab_rpt.tabpage_report.dw_report.object.report_name[1] = tab_rpt.tabpage_report.dw_report.Describe("DataWindow.Print.DocumentName")
         destroy l_nvo
				end if 

//Start Code Change ----09.03.2008 #V85 maha	 - recred log report added
	CASE "d_rpt_recred_log"
		if IsNull(id_from) then 
			ls_from = "2000-01-01 00:00:00"
		else
			ls_from  = string(id_from)
		end if
		
		if IsNull(id_to) then
			ls_to = "2199-12-31 00:00:00"	
		else
			ls_to  = string(id_to)
		end if
		
		//--------Begin Modified by  Nova 02.21.2010------------------------
		//IF Upper( is_facility_name ) <> "ALL" AND NOT IsNull( il_facility_id ) THEN
		//	ls_sql = ls_sql + " AND (sys_recred_log.facility_id = " + String( il_facility_id ) + ")"
		//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		IF Upper( is_facility_name ) <> "ALL" AND NOT IsNull( il_facility_id ) THEN
			ls_sql = ls_sql + " AND (sys_recred_log.facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (sys_recred_log.facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change ----06.25.2010	
		
		ls_sql = ls_sql + " AND (sys_recred_log.date_run >= Cast('" + String( id_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) )"
		ls_sql = ls_sql + " AND (sys_recred_log.date_run <= Cast('" + String( id_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) )"
		 
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
//End Code Change---09.03.2008

//Start Code Change ----10.29.2008 #V85 maha	 - CCVS custom
	CASE "d_rpt_ccvs_cust_app_detail"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  )
	
//Start Code Change ----06.24.2009 #V92 maha - Ameripath custom
//	CASE "d_rpt_ccvs_user_role_detail"
//		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
//		res = tab_rpt.tabpage_report.dw_report.Retrieve(is_users  )

//Start Code Change ----02.04.2010 #V10 maha - CVO reports
	CASE "d_rpt_cvo_grid"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,id_from,id_to )
		
	CASE "d_rpt_cvo_review_status"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,id_from,id_to )
		
	CASE "d_rpt_cvo_review_status_by_user"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,id_from, id_to )
			
	CASE "d_rpt_cvo_invoice"  //Start Code Change ----02.05.2013 #V12 maha
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(id_from,id_to )
		
	CASE "d_rpt_cvo_invoice_one_facil"  //Start Code Change ----02.05.2013 #V12 maha
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,id_from, id_to )
		
	CASE "d_rpt_cvo_invoice_w_verif"  //Start Code Change ----02.05.2013 #V12 maha
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,id_from, id_to )
		
//End Code Change---02.04.2010		

//Start Code Change ----12.08.2010 #V10 maha - App Tracking reports
	CASE "d_rpt_pd_appl_tracking_by_app_1_5"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,/*id_from, id_to*/ ldt_from, ldt_to )  //Modify by Stephen 05.10.2011 --- Fixed a bug 2395.
	CASE "d_rpt_pd_appl_tracking_by_prac_1_5"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,/*id_from, id_to*/ ldt_from, ldt_to )  //Modify by Stephen 05.10.2011 --- Fixed a bug 2395.
	CASE "d_rpt_pd_appl_tracking_by_app_6_10"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,/*id_from, id_to*/ ldt_from, ldt_to )  //Modify by Stephen 05.10.2011 --- Fixed a bug 2395.
	CASE "d_rpt_pd_appl_tracking_by_prac_6_10"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,/*id_from, id_to*/ ldt_from, ldt_to )  //Modify by Stephen 05.10.2011 --- Fixed a bug 2395.
	CASE "d_rpt_pd_appl_tracking_by_user"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,/*id_from, id_to*/ ldt_from, ldt_to )  //Modify by Stephen 05.10.2011 --- Fixed a bug 2395.
//Start Code Change ----08.23.2011 #V11 maha - new for AIA
	CASE "d_rpt_pd_appl_track_w_days_by_prac_6_10"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  , ldt_from, ldt_to ) 
	CASE "d_rpt_pd_appl_track_w_days_by_app_6_10"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  , ldt_from, ldt_to )  
//End Code Change ----08.23.2011	
	CASE "d_rpt_pd_appl_tracking"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id  ,il_prac_ids[] )
	CASE "d_rpt_priv_list_by_status"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve( il_priv_stat    , il_facility_id   )
//Start Code Change ----01.04.2013 #V12 maha		
	CASE "d_rpt_appl_status_sel_facil"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_prac_ids[], gs_user_id, il_facility_id )
	CASE "d_rpt_appl_status_all_facil"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_prac_ids[], gs_user_id  )
//End Code Change ----01.04.2013	
		
//@@@@@@@@@@@@@@@@@@@ end of report specific @@@@@@@@@@@@@@@@@@@@@@@@@@@
	CASE ELSE 
		
	
		
		if ii_using_export <> 1 then //maha 021803
			//--------Begin Modified by  Nova 02.21.2010------------------------
			//IF Upper( is_facility_name ) <> "ALL" AND NOT IsNull( il_facility_id ) THEN
			//	ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
			//END IF
//Start Code Change ----06.25.2010 #V10 maha - recorrected
		//IF Upper( is_facility_name ) <> "ALL" THEN
		IF Upper( is_facility_name ) <> "ALL" AND NOT IsNull( il_facility_id ) THEN //alfee 01.13.2011			
			ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id = " + String( il_facility_id ) + ")"
		else
			li_facility_cnt = upperbound(il_facility_ids_all) 
			if li_facility_cnt > 0 then
				for i = 1 to li_facility_cnt
					ls_facility_list+=  string(il_facility_ids_all[i])
					if i < li_facility_cnt then ls_facility_list+= ","
				next
					ls_sql = ls_sql + " AND (pd_affil_stat.parent_facility_id  in (" + ls_facility_list + "))"
			end if
		End if
		//--------End Modified --------------------------------------------
//End Code Change 06.25.2010
	
		
		end if
		//JAD 03/28/02 Added group wizard
		IF is_group_id <> "ALL" THEN
			ls_sql = ls_sql + " AND (pd_basic.cust_4 = '" + ls_group_id +"' )"
		END IF
		IF is_provider_type <> "ALL" THEN
			ls_sql = ls_sql + " AND (code_lookup_h.code IN ( '" + is_provider_type  + "'))"			
		END IF
		IF is_specialties <> "ALL" THEN
			ls_sql = ls_sql + " AND ( pd_board_specialty.specialty IN ( " + is_specialties + "))"
		END IF		
		IF is_department <> "ALL" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The column alias('dep') can not be used in WHERE clause in SQL Server, Using SetFilter() function to filter data
			//ls_sql = ls_sql + " AND ( dep IN ( " + is_department + "))"
			//<Modify> 07/31/2007 by: Andy
			//ls_filter = "dep IN ( " + is_department + ")"
			//Start Code Change ----07.17.2009 #V92 maha - oppe reports
			if ib_oppe = true then
				ls_sql = ls_sql + " AND ( pd_oppe_hrd.department IN ( " + is_department + "))"
			else
				ls_sql = ls_sql + " AND ( pd_affil_dept.department IN ( " + is_department + "))"
			end if
			//End Code Change---07.17.2009
			//end of modify
			//---------------------------- APPEON END ----------------------------
			
		END IF	
		IF ii_prime_dept_only = 1 THEN
			ls_sql = ls_sql + " AND (pd_affil_dept.primary_dept = 1)"
		END IF		
		IF is_address_types <> "ALL" THEN			
			ls_sql = ls_sql + is_address_types
		END IF
		IF is_net_dev_types <> "ALL" THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The column alias('action_type') can not be used in WHERE clause in SQL Server ,Using setfilter() funcion to filter data
			//ls_sql = ls_sql + " AND " + is_net_dev_types //" AND ( action_type IN ( " + is_net_dev_types  + "))"						
			If ls_filter <> '' Then
				ls_filter = ls_filter + ' AND ' + is_net_dev_types
			Else
				ls_filter = is_net_dev_types
			End If
			//---------------------------- APPEON END ----------------------------
		END IF
		IF is_appmnt_status <> "" THEN  //maha 073102
			ls_sql = ls_sql + " AND ( pd_AFFIL_STAT.ACTIVE_STATUS IN ( " + is_appmnt_status + "))"			
		END IF
		
		//IF Not IsNull( id_from ) THEN
		IF Not IsNull( id_from ) and  ii_tracking_step = 0 THEN  //Start Code Change ----07.17.2012 #V12 maha
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The date() function and date data type in ASA is unsupported by SQL Server
			//ls_sql = ls_sql + " AND ( Date( net_dev_action_items.action_date )  >= Cast('" + String( id_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( net_dev_action_items.action_date )  <= Cast('" + String( id_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND ( ( net_dev_action_items.action_date )  >= Cast('" + String( id_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( net_dev_action_items.action_date )  <= Cast('" + String( id_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) )"		
//***************				
			//---------------------------- APPEON END ----------------------------

		END IF
		IF Not IsNull( id_appt_from ) THEN //maha 012904
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The date() function and date data type in ASA is unsupported by SQL Server
			//ls_sql = ls_sql + " AND ( Date( pd_affil_stat.apptmnt_end_date )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( pd_affil_stat.apptmnt_end_date )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND ( ( pd_affil_stat.apptmnt_end_date )  >= Cast('" + String( id_appt_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( pd_affil_stat.apptmnt_end_date )  <= Cast('" + String( id_appt_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) )"		
			//---------------------------- APPEON END ----------------------------

		END IF
		IF Not IsNull( id_prov_from ) THEN //maha 042804 inova

			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The date() function and date data type in ASA is unsupported by SQL Server
			//ls_sql = ls_sql + " AND ( Date( pd_affil_stat.init_prov_period_to )  >= Cast('" + String( id_prov_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( pd_affil_stat.init_prov_period_to )  <= Cast('" + String( id_prov_to, 'yyyy/mm/dd' ) + "' AS DATE )) AND " +&
			//									"( pd_affil_stat.prov_status = " + string(ii_prov_status) + ")"
			ls_sql = ls_sql + " AND ( ( pd_affil_stat.init_prov_period_to )  >= Cast('" + String( id_prov_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( pd_affil_stat.init_prov_period_to )  <= Cast('" + String( id_prov_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME )) AND " +&
												"( pd_affil_stat.prov_status = " + string(ii_prov_status) + ")"
			
			//---------------------------- APPEON END ----------------------------

		end if
		IF Not IsNull( id_meet_from ) THEN  //maha 012904
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-11-28 By: Cao YongWang
			//$<reason> The date() function and date data type is unsupported by SQL Server
			//ls_sql = ls_sql + " AND ( Date( meetings.start_date )  >= Cast('" + String( id_meet_from, 'yyyy/mm/dd' ) + "' AS DATE ) AND " +&
			//	                           "Date( meetings.start_date )  <= Cast('" + String( id_meet_to, 'yyyy/mm/dd' ) + "' AS DATE ) )"		
			ls_sql = ls_sql + " AND ( ( meetings.start_date )  >= Cast('" + String( id_meet_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) AND " +&
				                           "( meetings.start_date )  <= Cast('" + String( id_meet_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) )"		
	
			//---------------------------- APPEON END ----------------------------
		END IF
		
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 05.20.2011
		//$<reason> prints the prac you did not select
		/*
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.13.2006 By: Cao YongWang
		//$<reason> Fix a defect.
		//IF tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_prac_participation_status_by_prac" THEN
		IF tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_prac_participation_status_by_prac" AND not isnull(il_prac_id) THEN
		//---------------------------- APPEON END ----------------------------
			ls_sql = ls_sql + " AND  pd_affil_stat.prac_id = " + String( il_prac_id )
		END IF
		*/
		IF tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_prac_participation_status_by_prac" AND upperbound(il_prac_ids) > 0 THEN
				li_prac_cnt = upperbound(il_prac_ids) 
			if li_prac_cnt > 0 then
				for i = 1 to li_prac_cnt
					ls_prac_ids+=  string(il_prac_ids[i])
					if i < li_prac_cnt then ls_prac_ids+= ","
				next
				ls_sql = ls_sql + " AND  pd_affil_stat.prac_id in (" + String( ls_prac_ids ) + ")"
			end if
		END IF
		//---------------------------- APPEON END ----------------------------
		
		IF is_contracts <> "ALL" THEN  //maha 021803
			ls_sql = ls_sql + " AND ( pd_contract.group_plan IN ( " + is_appmnt_status + "))"			
		END IF
		
		IF is_priv_stat <> "ALL" and is_priv_stat <> "" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_priv_list.status IN ( " + is_priv_stat + "))"			
		END IF
		IF is_division <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.rank IN ( " + is_division + "))"			
		END IF

		IF is_section <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_dept.section IN ( " + is_section + "))"			
		END IF
		IF is_staff_cat <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.staff_category IN ( " + is_staff_cat + "))"			
		END IF
		IF ii_staff_cat_status > -1 and ls_report <> 'd_rpt_exp_oth_id_list_dept_sc'THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_affil_staff_cat.requested = " + string(ii_staff_cat_status) + ")"			
		END IF
		IF is_affil_status <> "ALL" THEN  //maha 010103
			ls_sql = ls_sql + " AND ( pd_affil_stat.Affiliation_status IN ( " + is_affil_status + "))"				
		END IF	
		If upper(is_assn_user) <> "ALL" then //maha 012904
			//modify 08/24/2007 by: Andy
			ls_sql = ls_sql + " AND ( Ltrim(RTRIM(pd_AFFIL_STAT.priority_user)) = '" + is_assn_user + "')"
		end if
		If is_sex <> "ALL" then //maha 020204
			ls_sql = ls_sql + " AND ( pd_basic.sex in (" + is_sex + "))"
		end if
//Start Code Change ----06.25.2009 #V92 maha	 - for ameripath
		li_user_cnt = upperbound(is_users) 
		if upperbound(is_users) > 0 then
			for i = 1 to li_user_cnt
				ls_list+=  "'" + is_users[i] + "'" 
				if i < li_user_cnt then ls_list+= ","
			next
			If ls_list <> "'ALL'" then
				ls_sql = ls_sql + " AND ( user_id in (" + ls_list + "))"
			end if
		end if
//End Code Change---06.25.2009

//Start Code Change ----07.16.2012 #V12 maha - application tracking step
		if ii_tracking_step > 0 then
			ls_sql = ls_sql + " AND ( ( pd_appl_tracking." + is_appl_track_field + "  >= Cast('" + String( id_from, 'yyyy/mm/dd' ) + "' AS DATETIME ) )AND " +&
				                           "(pd_appl_tracking." + is_appl_track_field + "  <= Cast('" + String( id_to, 'yyyy/mm/dd' )  + " 23:59:59" +  "' AS DATETIME ) ))"	
		end if			
//End Code Change ----07.16.2012 

 //Start Code Change ----09.01.2015 #V15 maha
		if il_num_days > 0 then
			choose case tab_rpt.tabpage_report.dw_report.DataObject
				case "d_rpt_exp_lisc_list", "d_rpt_exp_lisc_list_dept",  "d_rpt_exp_lisc_list_dept_sc"
					ls_sql = ls_sql + " AND  ( pd_license.expiration_date - " + string(il_num_days) + " < getdate() )  "  
				case "d_rpt_exp_dea_list", "d_rpt_exp_dea_list_dept",  "d_rpt_exp_dea_list_dept_sc"
					ls_sql = ls_sql + " AND  ( pd_dea_state_csr.expiration_date - " + string(il_num_days) + " < getdate() )  "  
				case  "d_rpt_exp_ins_list", "d_rpt_exp_ins_list_dept",  "d_rpt_exp_ins_list_dept_sc"
					ls_sql = ls_sql + " AND  ( pd_insurance.coverage_to - " + string(il_num_days) + " < getdate() )  "  
				case  "d_rpt_exp_oth_id_list", "d_rpt_exp_oth_id_list_dept",  "d_rpt_exp_oth_id_list_dept_sc"
					ls_sql = ls_sql + " AND  ( pd_other_ids.exp_date - " + string(il_num_days) + " < getdate() )  "   //Start Code Change ----05.02.2016 #V15 maha - corrected field name
				case "d_rpt_exp_board_list", "d_rpt_exp_board_list_dept",  "d_rpt_exp_board_list_dept_sc"
					ls_sql = ls_sql + " AND  ( pd_board_specialty.expiration_date - " + string(il_num_days) + " < getdate() )  "
//				case "d_rpt_exp_spec_cert" //
//					ls_sql = ls_sql + " AND  ( pd_special_certs.expiration_date - " + string(il_num_days) + " < getdate() )  "
				case "d_rpt_appnt_expiration_ib"
					ls_sql = ls_sql + " AND  ( pd_affil_stat.apptmnt_end_date - " + string(il_num_days) + " < getdate() )  "
				case "d_rpt_expiring_credentials_list_ib", "d_rpt_expiring_credentials_detail"
					ls_sql = ls_sql + " AND  ( verif_info.expiration_date - " + string(il_num_days) + " < getdate() )  "	
				case "d_rpt_exp_health_hist_list"
					ls_sql = ls_sql + " AND  ( pd_health_history.exp_date - " + string(il_num_days) + " < getdate() )  "	
				case "d_rpt_exp_cpr_list"      //Start Code Change ----10.27.2016 #V153 maha
					ls_sql = ls_sql + " AND  ( pd_cpr_certifiation.expiration_date - " + string(il_num_days) + " < getdate() )  "
				case "d_rpt_exp_dues_list"      //Start Code Change ----10.27.2016 #V153 maha
					ls_sql = ls_sql + " AND  ( pd_dues_fees.exp_date - " + string(il_num_days) + " < getdate() )  "
				case "d_rpt_exp_other_verif"      //Start Code Change ----10.27.2016 #V153 maha
					ls_sql = ls_sql + " AND  ( pd_other_verifications.exp_date - " + string(il_num_days) + " < getdate() )  "	
					
			end choose
		end if
 //End Code Change ----09.01.2015
 

 //Start Code Change ----09.01.2015 #V15 maha
		IF Upper( is_health_type ) <> "ALL" THEN  //maha 091803
			ls_sql = ls_sql + " AND ( pd_health_history.assess_type IN ( " + is_health_type + "))"			
		END IF
 //End Code Change ----09.01.2015
 
//Start Code Change ----10.26.2016 #V153 maha 
		IF Upper( is_cpr_type ) <> "ALL" THEN 
			ls_sql = ls_sql + " AND ( pd_cpr_certifiation.cert_type IN ( " + is_cpr_type + "))"			
		END IF
		
		IF Upper( is_verif_type ) <> "ALL" THEN  
			ls_sql = ls_sql + " AND ( pd_other_verifications.verif_type IN ( " + is_verif_type + "))"			
		END IF
		
		IF Upper( is_fee_type ) <> "ALL" THEN  
			ls_sql = ls_sql + " AND ( pd_dues_fees.fee_type IN ( " + is_fee_type + "))"			
		END IF
		
		IF Upper( is_verif_entity ) <> "ALL" THEN  
			ls_sql = ls_sql + " AND ( pd_other_verifications.verif_entity IN ( " + is_verif_entity + "))"			
		END IF		
 //End Code Change ----10.26.2016


//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( ls_sql )
		//clipboard( ls_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2005-11-28 By: Cao YongWang
		//$<reason> 1. Cann't Modify selected_facility_t in web
		/**
		res = tab_rpt.tabpage_report.dw_report.Retrieve()
		*/
		res = tab_rpt.tabpage_report.dw_report.Retrieve(il_facility_id, is_facility_name)
		If ls_filter <> '' Then
			res = tab_rpt.tabpage_report.dw_report.setfilter(ls_filter)
			if res = -1 then messagebox("Filter error",ls_filter)
			tab_rpt.tabpage_report.dw_report.filter()
		End If
		//---------------------------- APPEON END ----------------------------
		//tab_rpt.tabpage_report.dw_report.retrieve( il_facility_ids_all )		
END CHOOSE

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-01 By: Rodger Wu (Contract)
//$<reason> A END IF statement for IF statement at line 75.
END IF
//---------------------------- APPEON END ----------------------------

end if

//of_log_sys_report_end( ll_log, res)  //Start Code Change ----06.06.2016 #V152 maha - moved below

integer set10
//select set_10 into :set10 from icred_settings;
set10 = of_get_app_setting("set_10","I")
if set10 = 1 then
		openwithparm(w_sql_msg, ls_sql)
		if res = -1 then messagebox("Program error","Data window syntax error.  Call technical support. ("  +  tab_rpt.tabpage_report.dw_report.DataObject + ")"   )
end if

if res < 0 then  messagebox("Program error","Data window syntax error.  Call technical support.  ("  +  tab_rpt.tabpage_report.dw_report.DataObject + ")"   )

tab_rpt.tabpage_report.Enabled = True
IF tab_rpt.tabpage_graph.dw_graph.DataObject = "" THEN
	tab_rpt.tabpage_graph.Enabled = False
ELSE
	tab_rpt.tabpage_graph.Enabled = True
END IF

tab_rpt.tabpage_report.dw_report.Modify( "selected_facility_t.text = '" + is_facility_name + "'" )
tab_rpt.tabpage_report.dw_report.Modify( "date_range_t.text = '" + is_date_range_name + "'" )

IF ii_prac_cnt > 1  and ii_using_export <> 1 THEN 
	choose case ls_report
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.13.2006 By: LiuHongXin
			//$<reason> Fix a defect.
			/*
			case "d_prf_master","d_prf_ver_results,d_rpt_priv_list_of_prac_all_facil,d_rpt_grant_priv_list_by_clin_area,d_rpt_prac_granted_priv_list"
			*/
			case "d_prf_master"
			//---------------------------- APPEON END ----------------------------
			tab_rpt.tabpage_report.cb_prac_filt.enabled = false
			tab_rpt.tabpage_report.dw_report.Print( True )
			res = 1  //Start Code Change ----07.25.2016 #V152 maha
		case else
			//---------Begin Added by Alfee 10.08.2013 ---------------------------------------
			//<$Reason>For Bug 3689 - Workaround the bug in APB 6.5.1065
			IF appeongetclienttype() = "WEB" THEN 
				tab_rpt.tabpage_report.dw_report.Modify("DataWindow.Print.Prompt=No")
			END IF			
			//---------End Added ------------------------------------------------------------------				
			tab_rpt.tabpage_report.dw_report.Modify("DataWindow.Print.Preview=Yes")
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 04.26.2006 By: Rodger Wu
			//$<reason> Fix a defect.
			/* if pos(ls_sql,".prac_id") > 0 then */
			if pos(ls_sql,".prac_id") > 0 or pos( ls_sql,'."prac_id' ) > 0 then
			//---------------------------- APPEON END ----------------------------
				tab_rpt.tabpage_report.cb_prac_filt.enabled = true
			else
				tab_rpt.tabpage_report.cb_prac_filt.enabled = false
			end if
			tab_rpt.tabpage_report.st_rec_cnt.Text = "Record Count: " + String( tab_rpt.tabpage_report.dw_report.RowCount() )
			tab_rpt.SelectTab(2)
	end choose

ELSE
	//---------Begin Added by Alfee 10.08.2013 ---------------------------------------
	//<$Reason>For Bug 3689 - Workaround the bug in APB 6.5.1065
	IF appeongetclienttype() = "WEB" THEN 
		tab_rpt.tabpage_report.dw_report.Modify("DataWindow.Print.Prompt=No")
	END IF			
	//---------End Added ------------------------------------------------------------------		
	tab_rpt.tabpage_report.dw_report.Modify("DataWindow.Print.Preview=Yes")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.26.2006 By: Rodger Wu
	//$<reason> Fix a defect.
	/* if pos(ls_sql,".prac_id") > 0 then */
	choose case ls_report
		case "d_prf_master"
			//---------------------------- APPEON END ----------------------------
			tab_rpt.tabpage_report.cb_prac_filt.enabled = false
		case else
			if pos(ls_sql,".prac_id") > 0 or pos( ls_sql,'."prac_id' ) > 0 then
			//---------------------------- APPEON END ----------------------------
				tab_rpt.tabpage_report.cb_prac_filt.enabled = true
			else
				tab_rpt.tabpage_report.cb_prac_filt.enabled = false
			end if
	end choose
	tab_rpt.tabpage_report.st_rec_cnt.Text = "Record Count: " + String( tab_rpt.tabpage_report.dw_report.RowCount() )
	tab_rpt.SelectTab(2)
END IF
//clipboard(ls_sql)
is_sql_mod = ls_sql

if gb_sk_ver then  //Start Code Change ----12.10.2010 #V10 maha
	tab_rpt.tabpage_report.cb_prac_filt.visible = false
	tab_rpt.tabpage_report.cb_7.visible = false
end if

//Start Code Change ----01.29.2013 #V12 maha
CHOOSE CASE tab_rpt.tabpage_report.dw_report.DataObject
	Case "d_rpt_dir_by_prac_name_w_photo"
		long ll_r
		long ll_prac
		string ll_path
		for ll_r = 1 to  tab_rpt.tabpage_report.dw_report.rowcount()
			ll_path =  tab_rpt.tabpage_report.dw_report.getitemstring(ll_r, "photo_pathname")
			if not fileexists(ll_path) then
				ll_prac = tab_rpt.tabpage_report.dw_report.getitemnumber(ll_r, "v_full_name_prac_id")
				of_photo_download(ll_prac)
			end if
		next
end choose
//End Code Change ----01.29.2013
lt_end = time(now())
//messagebox("Time to run (seconds)", string(secondsafter(lt_start,lt_end)))  //Commented by (Appeon)Harry 02.26.2015 - (for Allegheny- Time to Run message in Standard Reports)

tab_rpt.tabpage_report.is_syntax = ls_sql
//clipboard(ls_report)
//of_log_report( ii_report_id)  //Start Code Change ----06.06.2016 #V152 maha - removed

if tab_rpt.tabpage_report.cbx_hide_banner.checked then tab_rpt.tabpage_report.of_hide_banner(false)  //Start Code Change ----11.05.2013 #V14 maha
of_log_sys_report_end( ll_log, res, is_prov_name )  //Start Code Change ----07.25.2016 #V152 maha - moved from above


Return 0
end function

public function integer of_run_graph ();CHOOSE CASE tab_rpt.tabpage_graph.dw_graph.DataObject
	CASE "d_expiring_credentials_graph"
		tab_rpt.tabpage_graph.dw_graph.Retrieve(Today(), RelativeDate( Today(), 30 ), RelativeDate( Today(), 60 ), RelativeDate( Today(), 90 ))
END CHOOSE

Return 0
end function

public function integer of_quick_ver (integer al_facility);n_ds lds_qv_data
n_ds lds_qv_rpt
long li_row_cnt
long li_current_dea_cred_cnt
long i
long li_nr
long li_current_cred_cnt
long li_max
Long ll_last_prac_id
Long ll_prac_id
Long ll_last_rec_id
Long ll_rec_id
String ls_credential
String ls_last_credential
String ls_rpt_fld_nm
String ls_ref_val
String ls_display
String ls_retval

lds_qv_data = CREATE	n_ds
lds_qv_data.DataObject = "d_rpt_quick_verification_data"
lds_qv_data.SetTransObject( SQLCA )
li_row_cnt = lds_qv_data.Retrieve( al_facility )

//lds_qv_rpt = CREATE	n_ds
//lds_qv_rpt.DataObject = "d_rpt_quick_verification"
//lds_qv_rpt.SetTransObject( SQLCA )
//lds_qv_rpt.ShareData( tab_rpt.tabpage_report.dw_report )

ll_last_prac_id = 0
ls_last_credential = ""
ll_last_rec_id = 0
FOR i = 1 TO li_row_cnt
	ll_prac_id = lds_qv_data.GetItemNumber( i, "v_full_name_prac_id" )
	ll_rec_id = lds_qv_data.GetItemNumber( i, "rec_id" )
	IF ll_rec_id = ll_last_rec_id THEN
		CONTINUE
	ELSE
		ll_last_rec_id = ll_rec_id
	END IF
	IF ll_prac_id <> ll_last_prac_id THEN
		ll_last_prac_id = ll_prac_id
		li_nr = tab_rpt.tabpage_report.dw_report.InsertRow(0)
		tab_rpt.tabpage_report.dw_report.SetItem( li_nr, "name", lds_qv_data.GetItemString( i, "full_name" ) )
		li_current_cred_cnt = 1		
		ls_last_credential = ""		
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
				li_current_cred_cnt = 1
			ELSE
				li_current_dea_cred_cnt++
				li_current_cred_cnt = li_current_dea_cred_cnt
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
		CASE ELSE
			CONTINUE
	END CHOOSE
	IF IsNull( lds_qv_data.GetItemNumber( i, "response_code" ) ) OR lds_qv_data.GetItemNumber( i, "response_code" ) = 0 THEN
		ls_display = String(lds_qv_data.GetItemNumber( i, "number_sent" ) ) 	
		IF IsNull( ls_display ) THEN
			ls_display = "0"
		END IF
	ELSEIF NOT IsNull( lds_qv_data.GetItemNumber( i, "response_code" ) ) THEN
		ls_display = "*"
	END IF
	ls_retval = tab_rpt.tabpage_report.dw_report.Describe( ls_rpt_fld_nm + String( li_current_cred_cnt) + ".x" )
	IF ls_retval <> "!" THEN
		tab_rpt.tabpage_report.dw_report.SetItem( li_nr, ls_rpt_fld_nm + String( li_current_cred_cnt), ls_display )
	ELSE
		//MessageBox("", ls_rpt_fld_nm + String( li_current_cred_cnt) )
	END IF
	tab_rpt.tabpage_report.dw_report.SetItem( li_nr, "due", lds_qv_data.GetItemDateTime( i, "date_app_signed" ) )	
END FOR

destroy lds_qv_data //maha 052703

Return 0

end function

public function integer of_run_export_report (integer ai_export_id);//pfc_n_cst_ai_export  n_export
string ls_path
long i

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-15 By: Wang Chao
//$<reason> Replaced by an NVO
//pfc_n_cst_ai_export  n_export
//n_export = CREATE pfc_n_cst_ai_export
pfc_n_cst_ai_export_apb  n_export
n_export = CREATE pfc_n_cst_ai_export_apb
//---------------------------- APPEON END ----------------------------

select save_path into :ls_path from export_header where export_id = :ii_export_id;

//messagebox("ls_path",ls_path)
if isnull(ls_path) then
	ls_path = gs_temp_path
end if
n_export.is_called_type = '4'	//08.29.2007 Export format set to .txt By Jervis
n_export.of_export_data_with_text( ii_export_id, il_prac_ids,ls_path,1,"","","",2,"" )




return 1















end function

public function integer of_labels (string as_doc, string as_doc_path);//maha created 032105 when using citrix copy letters must be yes
//debugbreak()
string ls_doc
string ls_path
string ls_data
long ll_loop_count

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<add> 06.08.2006 By: Rodger Wu
//$<reason> Download the file from Database.

//Missing Info Letter:Store the letter_path in variable from facility_id = 1
String ls_letter_path
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	
	n_appeon_storage_area lnv_storage_area
	IF lnv_storage_area.of_retrieve_doc_from_db( 1, as_doc, ls_letter_path) < 0 THEN
		Messagebox("Download File",'The MSWord document '+  as_doc  +'  does not exist in the database.')
		RETURN -1
	END IF
	
	as_doc_path = ls_letter_path + as_doc
End If
//---------------------------- APPEON END ----------------------------

IF NOT FileExists( as_doc_path ) THEN
	MessageBox("Print Error", "Cannot find word label document " + as_doc_path  )
	Return -1
end if

//Start Code Change ---- 01.23.2006 #215 maha
ls_doc = of_letter_paths("L")
ls_data = of_letter_paths("D")
ls_path = ls_data //Start Code Change ---- 10.03.2006 #669 maha
CreateDirectoryA(ls_doc, 0)
ls_doc = ls_doc + as_doc
if gi_citrix = 1 then
	FileDelete( ls_doc)
	CopyFileA( as_doc_path, ls_doc, true )
	DO WHILE NOT FileExists( ls_doc )
		ll_loop_count++
		IF ll_loop_count = 1000000 THEN
			MessageBox("Timeout", "Timed out trying to copy Word file." )
			EXIT
		END IF
	LOOP
else
	ls_doc = as_doc_path //Added by Evan 09.16.2011
end if
//End Code Change---01.23.20

//if gi_citrix = 1 then
//	ls_path = gs_dir_path + "intellicred\letters\standard\" + gs_user_id + "\"
//	ls_doc = ls_path + as_doc
//	CreateDirectoryA(ls_path, 0)
//	FileDelete( ls_doc)
//	CopyFileA( as_doc_path, ls_doc, true )
//	DO WHILE NOT FileExists( ls_doc )
//		ll_loop_count++
//		IF ll_loop_count = 1000000 THEN
//			MessageBox("Timeout", "Timed out trying to copy Word file." )
//			EXIT
//		END IF
//	LOOP
//else
//	ls_path = gs_dir_path + "intellicred\letters\data\"
//	ls_doc = as_doc_path
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 01.13.2006 By: Cao YongWang
//$<modification> Create the downloading directory if it does not exist.
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
	Upper( appeongetclienttype() ) = 'WEB' Then
	n_appeon_download lnv_downlaod
	lnv_downlaod.of_parsepath( ls_path)
End If
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
gnv_rights.of_check_dir_right(ls_path, true, 'Report Lable')
//---------End Added ------------------------------------------------------------------


//------------------- APPEON BEGIN -------------------
//$<modify> Evan 09.16.2011
//$<reason> Fix double quote issue
//tab_rpt.tabpage_report.dw_report.SaveAs(ls_path + "\mailing_labels.txt", TEXT!, True )
gnv_app.gnvlo_msword.of_CreateDatasource(tab_rpt.tabpage_report.dw_report, ls_path + "\mailing_labels.txt")
//------------------- APPEON END ---------------------

tab_rpt.tabpage_report.dw_report.SaveAs(ls_path + "\mailing_labels.xls", excel!, True )
ls_path = ls_path + "\mailing_labels.txt"

// mskinner 04 oct 2005 - begin
gnv_app.gnvlo_msword.of_open_word_document(ls_doc,ls_path,"Reports")
//of_open_letter(ls_doc,ls_path,"Reports")
// mskinner 04 oct 2005 - end

return 1
end function

public subroutine of_contract_run (ref string as_sql);//////////////////////////////////////////////////////////////////////
// $<function>w_report.of_contract_run()
// $<arguments>
//		ref	string	as_sql		
// $<returns> (none)
// $<description> Run contract reports after the last step of wizard.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-08-01 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////

Integer li_cols, li_rowcount, i, j, k, li_count, li_temp, li_found
Dec{2} ld_max = 0, ld_min = 0, ld_current, ld_sum[], ld_temp, ld_sort[]
DataWindowChild	ldw_Child

String	ls_InsSynatx
long		ll_OrderByPos

constant integer ci_start = 5
//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Generating the Report...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)	
End If

tab_rpt.tabpage_report.dw_report.SetRedraw(False)	//Added by Ken.Guo on 2009-04-20	
//---------End Added ------------------------------------------------------------------
		
Choose Case tab_rpt.tabpage_report.dw_report.DataObject
	CASE "d_rpt_ctx_contractlist_byowner", "d_rpt_ctx_contractlist_bytype", "d_rpt_ctx_contractlist_bystatus"
		Choose Case ii_ctx_grouping
			Case 1
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_contractlist_byowner"
			Case 2
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_contractlist_bytype"
			Case 3
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_contractlist_bystatus"
		End Choose
		
		if is_ctx_status <> "ALL" then
			as_sql += " AND ctx_basic_info.status in ( " + is_ctx_status + " ) "
		end if
		
		if is_ctx_owner <> "ALL" then
			as_sql += " AND ctx_contract_contacts.contact_id in ( " + is_ctx_owner + " ) "
		end if

		tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		tab_rpt.tabpage_report.dw_report.Retrieve()
		
	CASE "d_rpt_ctx_needreview_byowner", "d_rpt_ctx_needreview_bytype", "d_rpt_ctx_needreview_byentity"
		Choose Case ii_ctx_grouping
			Case 1
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_needreview_byowner"
			Case 2
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_needreview_bytype"
			Case 3
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_needreview_byentity"
		End Choose
		
		Choose Case ii_ctx_days
			Case -1//Expired
				as_sql += " AND DATEDIFF(day, getdate(), ctx_basic_info.review_date) < 0 "
			Case 0 //All
			Case Else
				as_sql += " AND DATEDIFF(day, getdate(), ctx_basic_info.review_date) <= " + string( ii_ctx_days) + &
				          " AND DATEDIFF(day, getdate(), ctx_basic_info.review_date) >= 0 "
		End Choose

		if is_ctx_status <> "ALL" then
			as_sql += " AND ctx_basic_info.status in ( " + is_ctx_status + " ) "
		end if
		
		if is_ctx_owner <> "ALL" then
			as_sql += " AND ctx_contract_contacts.contact_id in ( " + is_ctx_owner + " ) "
		end if
		
		tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		tab_rpt.tabpage_report.dw_report.Retrieve()

	CASE "d_rpt_ctx_expiring_byowner", "d_rpt_ctx_expiring_bytype", "d_rpt_ctx_expiring_byentity"
		Choose Case ii_ctx_grouping
			Case 1
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_expiring_byowner"
			Case 2
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_expiring_bytype"
			Case 3
				tab_rpt.tabpage_report.dw_report.dataobject = "d_rpt_ctx_expiring_byentity"
		End Choose
		
		Choose Case ii_ctx_days
			Case -1//Expired
				as_sql += " AND DATEDIFF(day, getdate(), ctx_basic_info.expriation_date) < 0 "
			Case 0 //All
			Case Else
				as_sql += " AND DATEDIFF(day, getdate(), ctx_basic_info.expriation_date) <= " + string( ii_ctx_days) + &
				          " AND DATEDIFF(day, getdate(), ctx_basic_info.expriation_date) >= 0 "
		End Choose
		
		if is_ctx_status <> "ALL" then
			as_sql += " AND ctx_basic_info.status in ( " + is_ctx_status + " ) "
		end if
		
		if is_ctx_owner <> "ALL" then
			as_sql += " AND ctx_contract_contacts.contact_id in ( " + is_ctx_owner + " ) "
		end if
		
		tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		tab_rpt.tabpage_report.dw_report.Retrieve()
		
	CASE "d_rpt_ctx_feeschedule"
		//$<modify> 03.24.2008 by Andy
		//$Reason:  Fixed BugN030708 add:if statement.
		IF Not IsNull( id_from ) THEN
			as_sql += " AND ctx_basic_info.effective_date >= '" + string( id_from, 'yyyy-mm-dd' ) + &
						 "' AND ctx_basic_info.effective_date <= '" + string( id_to, 'yyyy-mm-dd' ) + "' "
		end if
		//end of modify 03.24.2008
		if is_ctx_category <> "ALL" then
			as_sql += " AND ctx_basic_info.category in ( " + is_ctx_category + " ) "
		end if
		if is_ctx_service <> "ALL" then
			as_sql += " AND ctx_fee_sched_nm.service_item in ( " + is_ctx_service + " ) "
		end if
		if is_ctx_status <> "ALL" then
			as_sql += " AND ctx_basic_info.status in ( " + is_ctx_status + " ) "
		end if
		
		tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		tab_rpt.tabpage_report.dw_report.Retrieve()
	Case "d_rpt_ctx_analysis"
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		
		if IsNull(id_from) then id_from = 1800-01-01				//Added by Scofield on 2008-05-27
		if IsNull(id_to) then id_to = 3000-12-31					//Added by Scofield on 2008-05-27		

		//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
		as_sql =  tab_rpt.tabpage_report.dw_report.GetSQLSelect()	//Added by Ken.Guo on 2009-02-20		
		//---------End Added ------------------------------------------------------------------

		tab_rpt.tabpage_report.dw_report.Retrieve( id_from, id_to, il_ctxid, is_cptcode )
		
		Post of_contract_calc_crosstab()
Case "d_rpt_ctx_feescheduleaudit"
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 11.06.2007 By: Evan
	//$<Reason> Add Fee Schedule Audit Report.
	string ls_SQLSelect
	long ll_year20_start,ll_year20_end
	
	ll_year20_start = il_StartYear + 5
	ll_year20_end = ll_year20_start + 19	
	ls_SQLSelect = &
	"SELECT " + &
	"  category = B.description, " + &
	"  company = C.facility_name, " 	
	//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
	ls_SQLSelect += "  ctx_basic_info_ctx_id = A.ctx_id, " 
	//---------End Added ------------------------------------------------------------------	 
	ls_SQLSelect += "  effective_date = A.effective_date, " + &
	"  expriation_date = A.expriation_date, " + &
	"  suite_id = ( " + &
	"	 select " + &
	"		top 1 E.street " + &
	"	 from " + &
	"		ctx_loc D inner join group_practice E on D.loc_id = E.rec_id " + &
	"		left outer join code_lookup F on E.state = F.lookup_code " + &
	"	 where D.ctx_id = A.ctx_id), " + &
	"  year1 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and (datepart(year,start_date) = " + String(il_StartYear) + " or datepart(year,end_date) = " + String(il_StartYear) + ")), " + &
	"  year2 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and (datepart(year,start_date) = " + String(il_StartYear + 1) + " or datepart(year,end_date) = " + String(il_StartYear + 1) + ")), " + &
	"  year3 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and (datepart(year,start_date) = " + String(il_StartYear + 2) + " or datepart(year,end_date) = " + String(il_StartYear + 2) + ")), " + &
	"  year4 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and (datepart(year,start_date) = " + String(il_StartYear + 3) + " or datepart(year,end_date) = " + String(il_StartYear + 3) + ")), " + &
	"  year5 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and (datepart(year,start_date) = " + String(il_StartYear + 4) + " or datepart(year,end_date) = " + String(il_StartYear + 4) + ")), " + &
	"  beyond_year5 = (select sum(fee) from ctx_fee_sched_nm where (ctx_id = A.ctx_id) and " + &
	"						 ((datepart(year,start_date) between " + String(ll_year20_start) + " and " + String(ll_year20_end) + ") " + &
	"						 or (datepart(year,end_date) between " + String(ll_year20_start) + " and " + String(ll_year20_end) + "))) " + &
	"FROM " + &
	"  ctx_basic_info A LEFT OUTER JOIN code_lookup B ON A.category = B.lookup_code " + &
	"  LEFT OUTER JOIN app_facility C ON A.app_facility = C.facility_id "
	if is_ctx_category <> "ALL" then
		ls_SQLSelect += " WHERE A.category in (" + is_ctx_category + ")"
	else
		ls_SQLSelect += " WHERE not A.category is null"
	end if
		
	tab_rpt.tabpage_report.dw_report.Modify('DataWindow.Table.Select = "' + ls_SQLSelect + '"')
	tab_rpt.tabpage_report.dw_report.object.t_startyear.text = "(Five Year Minimum Rent  - Start Year = " + String(il_StartYear) + ")"
	tab_rpt.tabpage_report.dw_report.SetTransObject(SQLCA)
	tab_rpt.tabpage_report.dw_report.Retrieve()
	//---------------------------- APPEON END ----------------------------		
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-05-22 By: Scofield
	//$<Reason> Add d_rpt_ctx_status_statistics_1 Report
	
	Case "d_rpt_ctx_status_statistics_1","d_rpt_ctx_status_statistics_2","d_rpt_ctx_status_summary"
		UPDATE A
			SET A.delay_days = DATEDIFF(DAY,A.start_time,B.start_time)
		  FROM sys_StatusAudit A,sys_StatusAudit B
		 WHERE A.ctx_id = B.ctx_id AND A.seq_no = B.seq_no - 1 AND A.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');
		
		UPDATE sys_StatusAudit
			SET sys_StatusAudit.delay_days = 0
		 WHERE sys_StatusAudit.status Not In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');
		
		UPDATE A
			SET A.delay_days = DATEDIFF(DAY,A.start_time,getdate())
		  FROM sys_StatusAudit A
		 WHERE A.seq_no = (SELECT Max(B.seq_no) From sys_StatusAudit B Where A.ctx_id = B.ctx_id) AND A.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');

		if is_ctx_category <> "ALL" and Trim(is_ctx_category) <> '' then
			ls_InsSynatx += " AND ctx_basic_info.category in ( " + is_ctx_category + " ) "
		end if
		
		if is_ctx_status <> "ALL" and Trim(is_ctx_status) <> '' then
			ls_InsSynatx += " AND ctx_basic_info.status in ( " + is_ctx_status + " ) "
		end if
		
		if is_ctx_Track_status <> "ALL" and Trim(is_ctx_Track_status) <> '' then
			ls_InsSynatx += " AND sys_statusaudit.status in ( " + is_ctx_Track_status + " ) "
		end if
		
		if is_ctx_type <> "ALL" and Trim(is_ctx_type) <> '' then
			ls_InsSynatx += " AND ctx_basic_info.contract_type in ( " + is_ctx_type + " ) "
		end if
		
		/*if is_ctx_user <> "ALL" and Trim(is_ctx_user) <> '' then
			ls_InsSynatx += " AND sys_statusaudit.user_id in ( " + is_ctx_user + " ) "
		end if*/
		
		if is_ctx_owner <> "ALL" and Trim(is_ctx_owner) <> '' then
			ls_InsSynatx += " AND ctx_contract_contacts.contact_id in ( " + is_ctx_owner + " ) "
		end if
		
		if Not IsNull(id_from) then
			ls_InsSynatx += " AND sys_statusaudit.start_time >= '" + String(id_from) + "' "
		end if
		
		if Not IsNull(id_to) then
			ls_InsSynatx += " AND sys_statusaudit.start_time <= '" + String(id_to) + "' "
		end if
		//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
		//temporary process-- jervis 04.27.2011
		ls_InsSynatx+= " and sys_statusaudit.field_name = 'status' "		
		//---------End Added ------------------------------------------------------------------

		if tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_ctx_status_summary" then
			tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_ctx_status_summary"		//Notice: This statement can't be deleted! Add this in order to can modify the datawindowchild's sql syntax
			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
			as_sql = ldw_Child.GetSQLSelect()															//Save SQL Syntax
			
			if LenA(Trim(ls_InsSynatx)) > 0 then
				as_sql += ls_InsSynatx
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)
				ldw_Child.Retrieve("complete")					//CrossTab Report must one by one retrieve
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_2",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)
				ldw_Child.Retrieve("on")							//CrossTab Report must one by one retrieve
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_3",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)
				ldw_Child.Retrieve("off")							//CrossTab Report must one by one retrieve
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_4",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)
				ldw_Child.Retrieve("na")							//CrossTab Report must one by one retrieve
			else
				tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
				tab_rpt.tabpage_report.dw_report.Retrieve("complete","on","off","na")
			end if
		else
			if LenA(Trim(ls_InsSynatx)) > 0 then
				ll_OrderByPos = PosA(Upper(as_sql),"ORDER BY")
				if ll_OrderByPos > 0 then
					as_sql = LeftA(as_sql,ll_OrderByPos - 1) + ls_InsSynatx + MidA(as_sql,ll_OrderByPos)
				else
					as_sql += ls_InsSynatx
				end if
				tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
			end if
			
			as_sql = tab_rpt.tabpage_report.dw_report.GetSQLSelect()									//Save SQL Syntax
			
			tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
			tab_rpt.tabpage_report.dw_report.Retrieve()
		end if
		
		if Not IsNull(id_from) and Not IsNull(id_to) then
			tab_rpt.tabpage_report.dw_report.Modify( "t_daterange.Text = '" + String(id_from) + " To " + String(id_to) + "'" )
		elseif IsNull(id_from) and IsNull(id_to) then
			tab_rpt.tabpage_report.dw_report.Modify( "t_daterange.Text = 'All'" )
		end if
	Case "d_rpt_ctx_status_metrics_1","d_rpt_ctx_status_metrics_2"
		UPDATE A
			SET A.delay_days = DATEDIFF(DAY,A.start_time,B.start_time)
		  FROM sys_StatusAudit A,sys_StatusAudit B
		 WHERE A.ctx_id = B.ctx_id AND A.seq_no = B.seq_no - 1 AND A.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');
		
		UPDATE sys_StatusAudit
			SET sys_StatusAudit.delay_days = 0
		 WHERE sys_StatusAudit.status Not In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');
		
		UPDATE A
			SET A.delay_days = DATEDIFF(DAY,A.start_time,getdate())
		  FROM sys_StatusAudit A
		 WHERE A.seq_no = (SELECT Max(B.seq_no) From sys_StatusAudit B Where A.ctx_id = B.ctx_id) AND A.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On');

		if is_ctx_category <> "ALL" and Trim(is_ctx_category) <> '' then
			ls_InsSynatx += " AND ctx_basic_info.category in ( " + is_ctx_category + " ) "
		end if
		
		if is_ctx_type <> "ALL" and Trim(is_ctx_type) <> '' then
			ls_InsSynatx += " AND ctx_basic_info.contract_type in ( " + is_ctx_type + " ) "
		end if
		
		/*if is_ctx_user <> "ALL" and Trim(is_ctx_user) <> '' then
			ls_InsSynatx += " AND A.user_id in ( " + is_ctx_user + " ) " + " AND B.user_id in ( " + is_ctx_user + " ) "
		end if*/
		
		if is_ctx_owner <> "ALL" and Trim(is_ctx_owner) <> '' then
			ls_InsSynatx += " AND ctx_contract_contacts.contact_id in ( " + is_ctx_owner + " ) "
		end if
		
		if Not IsNull(id_from) then
			ls_InsSynatx += " AND B.start_time >= '" + String(id_from) + "' "
		end if
		
		if Not IsNull(id_to) then
			ls_InsSynatx += " AND A.start_time <= '" + String(id_to) + "' "
		end if
		
		if tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_ctx_status_metrics_2" then
			tab_rpt.tabpage_report.dw_report.DataObject = "d_rpt_ctx_status_metrics_2"		//Notice: This statement can't be deleted! Add this in order to can modify the datawindowchild's sql syntax
			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
			as_sql = ldw_Child.GetSQLSelect()															//Save SQL Syntax
			
			if LenA(Trim(ls_InsSynatx)) > 0 then
				ll_OrderByPos = PosA(Upper(as_sql),"ORDER BY")
				if ll_OrderByPos > 0 then
					as_sql = LeftA(as_sql,ll_OrderByPos - 1) + ls_InsSynatx + MidA(as_sql,ll_OrderByPos)
				else
					as_sql += ls_InsSynatx
				end if
				//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------				
				  /*						
					tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
					ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )			
					
					tab_rpt.tabpage_report.dw_report.GetChild("dw_2",ldw_Child)
					ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
					
					tab_rpt.tabpage_report.dw_report.GetChild("dw_3",ldw_Child)
					ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
					
					tab_rpt.tabpage_report.dw_report.GetChild("dw_4",ldw_Child)
					ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				end if
				tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
				tab_rpt.tabpage_report.dw_report.Retrieve(il_StartStatus_1,il_EndStatus_1,il_StartStatus_2,il_EndStatus_2,il_StartStatus_3,il_EndStatus_3,il_StartStatus_4,il_EndStatus_4)
				  */
				tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)										//Added by Scofield on 2009-08-20
				ldw_Child.Retrieve(il_StartStatus_1,il_EndStatus_1)			//Added by Scofield on 2009-08-20
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_2",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)										//Added by Scofield on 2009-08-20
				ldw_Child.Retrieve(il_StartStatus_2,il_EndStatus_2)			//Added by Scofield on 2009-08-20
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_3",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)										//Added by Scofield on 2009-08-20
				ldw_Child.Retrieve(il_StartStatus_3,il_EndStatus_3)			//Added by Scofield on 2009-08-20
				
				tab_rpt.tabpage_report.dw_report.GetChild("dw_4",ldw_Child)
				ldw_Child.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
				ldw_Child.SetTransObject(SQLCA)										//Added by Scofield on 2009-08-20
				ldw_Child.Retrieve(il_StartStatus_4,il_EndStatus_4)			//Added by Scofield on 2009-08-20
			else
				tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
				tab_rpt.tabpage_report.dw_report.Retrieve(il_StartStatus_1,il_EndStatus_1,il_StartStatus_2,il_EndStatus_2,il_StartStatus_3,il_EndStatus_3,il_StartStatus_4,il_EndStatus_4)			 
				//---------End Modfiied ------------------------------------------------------------------
			end if


			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_1",ldw_Child)
			ldw_Child.Modify("compute_2.Expression='Min(compute_17 for group 1)'")
			ldw_Child.Modify("compute_8.Expression='Min(compute_19 for all)'")
			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_2",ldw_Child)
			ldw_Child.Modify("compute_2.Expression='Min(compute_17 for group 1)'")
			ldw_Child.Modify("compute_8.Expression='Min(compute_19 for all)'")
			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_3",ldw_Child)
			ldw_Child.Modify("compute_2.Expression='Min(compute_17 for group 1)'")
			ldw_Child.Modify("compute_8.Expression='Min(compute_19 for all)'")
			
			tab_rpt.tabpage_report.dw_report.GetChild("dw_4",ldw_Child)
			ldw_Child.Modify("compute_2.Expression='Min(compute_17 for group 1)'")
			ldw_Child.Modify("compute_8.Expression='Min(compute_19 for all)'")
		else
			if LenA(Trim(ls_InsSynatx)) > 0 then
				ll_OrderByPos = PosA(Upper(as_sql),"ORDER BY")
				if ll_OrderByPos > 0 then
					as_sql = LeftA(as_sql,ll_OrderByPos - 1) + ls_InsSynatx + MidA(as_sql,ll_OrderByPos)
				else
					as_sql += ls_InsSynatx
				end if
				tab_rpt.tabpage_report.dw_report.Modify( 'DataWindow.Table.Select = "' + as_sql + '"' )
			end if
			
			as_sql = tab_rpt.tabpage_report.dw_report.GetSQLSelect()									//Save SQL Syntax
			
			tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
			tab_rpt.tabpage_report.dw_report.Retrieve(il_Start_Status,il_End_Status)
		end if
		
		if Not IsNull(id_from) and Not IsNull(id_to) then
			tab_rpt.tabpage_report.dw_report.Modify( "t_daterange.Text = '" + String(id_from) + " To " + String(id_to) + "'" )
		elseif IsNull(id_from) and IsNull(id_to) then
			tab_rpt.tabpage_report.dw_report.Modify( "t_daterange.Text = 'All'" )
		end if
	//---------------------------- APPEON END ----------------------------
//---------Begin Modified by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
  /*
    End Choose  
  */
Case 'r_ctx_contracts_by_assn'
		 string ls_array[]
		 string ls_array2[]
		 string ls_delimiter
		 string ls_out
		 long ll_i
		 N_cst_string inv_string
		 
		 ls_delimiter = "," //$<add> 04.07.2008 by Andy
		 if upperbound(il_contact_id) > 0 then
			for ll_i = 1 to upperbound(il_contact_id)
				 ls_array[upperbound(ls_array) + 1] = string(il_contact_id[ll_i])
			next
			 
			 inv_string.of_ArrayToString(ls_array, ls_delimiter, ls_out)
						 as_sql = as_sql + ' AND ctx_contract_contacts.contact_id in ' + '(' + ls_out  + ')' 
       end if

		 if upperbound(ll_ctx_status) > 0 then
			
			for ll_i = 1 to upperbound(ll_ctx_status)
				 ls_array2[upperbound(ls_array2) + 1] = string(ll_ctx_status[ll_i])
			next
			inv_string.of_ArrayToString(ls_array2, ls_delimiter, ls_out)
	      as_sql = as_sql + ' AND ctx_basic_info.status in ' + '(' + ls_out  + ')' 	
	
      end if
		tab_rpt.tabpage_report.dw_report.SetSQLSelect ( as_sql )
		tab_rpt.tabpage_report.dw_report.SetTransObject( SQLCA )
		tab_rpt.tabpage_report.dw_report.Retrieve()
End Choose
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(50)
of_filter_noaccess() //Added by Ken.Guo on 2009-04-20
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(100)
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
tab_rpt.tabpage_report.dw_report.SetRedraw(True) //Added by Ken.Guo on 2009-04-20  
//---------End Modfiied ------------------------------------------------------------------



end subroutine

public subroutine of_contract_wizard_current (string as_wizard_dw);//////////////////////////////////////////////////////////////////////
// $<function>w_report.of_contract_wizard_current()
// $<arguments>
//		value	string	as_wizard_dw		
// $<returns> (none)
// $<description> After click next button, the datawindow appears and
// $<description> is set data through this function.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-08-01 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////
Long ll_found, ll_rowcount

IF as_wizard_dw = "d_rpt_ctx_wiz_grouping1" or as_wizard_dw = "d_rpt_ctx_wiz_grouping2" THEN
	tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 0 )
	tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, 1, ii_ctx_grouping )
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_status1" THEN
	ll_rowcount = tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		ll_rowcount ++;
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL" )
	END IF
	
	ll_found = tab_rpt.tabpage_criteria.dw_criteria.Find( "Upper( code ) = 'ALL'", 1, ll_rowcount )
	IF ll_found > 0 THEN
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( ll_found, "selected", 1 )
	ELSE
		IF ll_rowcount > 0 THEN
			tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
		END IF
	END IF
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_status2" THEN
	ll_rowcount = tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		ll_rowcount ++;
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL" )
	END IF
	
	ll_found = tab_rpt.tabpage_criteria.dw_criteria.Find( "Upper( code ) = 'ACTIVE'", 1, ll_rowcount )
	IF ll_found > 0 THEN
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( ll_found, "selected", 1 )
	ELSE
		IF ll_rowcount > 0 THEN
			tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
		END IF
	END IF
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_category1" OR &
		 as_wizard_dw = "d_rpt_ctx_wiz_service1" THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "description", "Include ALL" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_owner1" THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "c_fullname", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	END IF
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_days" THEN
	tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 0 )
	tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, 1, ii_ctx_days )
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_select" THEN
	IF is_ctx_data_contract <> '' THEN
		tab_rpt.tabpage_criteria.dw_criteria.ImportString( is_ctx_data_contract )
	END IF
ELSEIF as_wizard_dw = "d_rpt_ctx_wiz_select_cptcode" THEN
	IF is_ctx_data_cptcode <> '' THEN
		tab_rpt.tabpage_criteria.dw_criteria.ImportString( is_ctx_data_cptcode )
	END IF
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-22 By: Scofield
//$<Reason> Add d_rpt_ctx_wiz_type1 and d_rpt_ctx_wiz_user process.

elseif as_wizard_dw = "d_rpt_ctx_wiz_type1"  THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	
	if tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" then
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "code", "ALL" )		
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
	end if
elseif as_wizard_dw = "d_rpt_ctx_wiz_user"  THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	
	if tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" then
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "lookup_code", 0 )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "user_id", "ALL" )
		tab_rpt.tabpage_criteria.dw_criteria.SetItem( 1, "selected", 1 )
		tab_rpt.tabpage_criteria.dw_criteria.Modify( "user_id.TabSequence = 0" )
	end if
elseif as_wizard_dw = "d_rpt_ctx_wiz_status_select"  THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	
	if tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" then
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
	end if
elseif as_wizard_dw = "d_rpt_ctx_wiz_multi_status_select"  THEN
	tab_rpt.tabpage_criteria.dw_criteria.Retrieve()
	
	if tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" then
		tab_rpt.tabpage_criteria.dw_criteria.InsertRow( 1 )
	end if
//---------------------------- APPEON END ----------------------------
ELSE
	
END IF
end subroutine

public function integer of_contract_wizard_next ();//////////////////////////////////////////////////////////////////////
// $<function> w_report.of_contract_wizard_next()
// $<arguments> (None)
// $<returns>   (None)
// $<description> While click next button, the current datawindow is checked
// $<description> and data is stored through this function.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-08-01 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////

Integer li_rc
Integer i
Long ll_dummy[], j
String ls_dummy[]

Choose Case tab_rpt.tabpage_criteria.dw_criteria.DataObject
	case "d_rpt_ctx_wiz_grouping1", "d_rpt_ctx_wiz_grouping2"
		ii_ctx_grouping = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "grouping" )
	case "d_rpt_ctx_wiz_status1"
		IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
			is_ctx_status = "ALL"
		else
			is_ctx_status = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			FOR i = 1 TO li_rc
				IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
					is_ctx_status += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				END IF
			END FOR
			is_ctx_status = LeftA( is_ctx_status, LenA( is_ctx_status ) -2 )
		end if
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-05-27 By: Scofield
		//$<Reason> At least select one check box.

		IF is_ctx_status = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
		//---------------------------- APPEON END ----------------------------
	case "d_rpt_ctx_wiz_status2"
		IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
			is_ctx_Track_status = "ALL"
		else
			is_ctx_Track_status = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			FOR i = 1 TO li_rc
				IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
					is_ctx_Track_status += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				END IF
			END FOR
			is_ctx_Track_status = LeftA( is_ctx_Track_status, LenA( is_ctx_Track_status ) -2 )
		end if
		IF is_ctx_Track_status = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
	case "d_rpt_ctx_wiz_owner1"
		IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
			is_ctx_owner = "ALL"
		else
			is_ctx_owner = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			FOR i = 1 TO li_rc
				IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
					is_ctx_owner += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				END IF
			END FOR
			is_ctx_owner = LeftA( is_ctx_owner, LenA( is_ctx_owner ) -2 )
		end if
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-05-27 By: Scofield
		//$<Reason> At least select one check box.

		IF is_ctx_owner = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
		//---------------------------- APPEON END ----------------------------
	case "d_rpt_ctx_wiz_days"
		ii_ctx_days = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "days" )
		
	case "d_rpt_ctx_wiz_category1"
		IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
			is_ctx_category = "ALL"
		else
			is_ctx_category = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			FOR i = 1 TO li_rc
				IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
					is_ctx_category += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				END IF
			END FOR
			is_ctx_category = LeftA( is_ctx_category, LenA( is_ctx_category ) -2 )
		end if
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-05-27 By: Scofield
		//$<Reason> At least select one check box.

		IF is_ctx_category = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
		//---------------------------- APPEON END ----------------------------
	case "d_rpt_ctx_wiz_service1"
		IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
			is_ctx_service = "ALL"
		else
			is_ctx_service = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			FOR i = 1 TO li_rc
				IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
					is_ctx_service += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				END IF
			END FOR
			is_ctx_service = LeftA( is_ctx_service, LenA( is_ctx_service ) -2 )
		end if
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-05-27 By: Scofield
		//$<Reason> At least select one check box.

		IF is_ctx_service = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
		//---------------------------- APPEON END ----------------------------
	case "d_rpt_ctx_wiz_select"
		il_ctxid = ll_dummy
		
		li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
		FOR i = 1 TO li_rc
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selectitem" ) = 1 THEN
				j++
				il_ctxid[ j ] = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )
			END IF
		END FOR
		IF j = 0 THEN
			MessageBox( "Selection Error", "You must select at least one contract." )
			Return -1;
		END IF
		is_ctx_data_contract = tab_rpt.tabpage_criteria.dw_criteria.Describe( "DataWindow.Data" )
	
	case "d_rpt_ctx_wiz_select_cptcode"
		is_cptcode = ls_dummy
		
		li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
		FOR i = 1 TO li_rc
			IF tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selectitem" ) = 1 THEN
				j++
				is_cptcode[ j ] = tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "cptcode" )
			END IF
		END FOR
		IF j = 0 THEN
			MessageBox( "Selection Error", "You must select at least one CPT code." )
			Return -1;
		END IF
		is_ctx_data_cptcode = tab_rpt.tabpage_criteria.dw_criteria.Describe( "DataWindow.Data" )
	case "d_rpt_ctx_wiz_startyear"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 11.06.2007 By: Evan
		//$<Reason> Add Fee Schedule Audit Report.
		tab_rpt.tabpage_criteria.dw_criteria.AcceptText()
		il_StartYear = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1, "year")	
		if IsNull(il_StartYear) then
			MessageBox("Specify Error", "You must specify start year.")
			tab_rpt.tabpage_criteria.dw_criteria.SetFocus()
			Return -1
		end if	
		//--------------------------- APPEON END -----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-05-22 By: Scofield
	//$<Reason> Save user select for d_rpt_ctx_wiz_type1 and d_rpt_ctx_wiz_user.
	
	Case "d_rpt_ctx_wiz_type1"
		if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 then
			is_ctx_type = "ALL"
		else
			is_ctx_type = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			for i = 1 to li_rc
				if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 then
					is_ctx_type += String( tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
				end if
			next
			is_ctx_type = LeftA( is_ctx_type, LenA( is_ctx_type ) -2 )
		end if
		IF is_ctx_type = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
	Case "d_rpt_ctx_wiz_user"
		if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( 1, "selected" ) = 1 then
			is_ctx_user = "ALL"
		else
			is_ctx_user = ""
			li_rc = tab_rpt.tabpage_criteria.dw_criteria.RowCount()
			for i = 1 to li_rc
				if tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber( i, "selected" ) = 1 then
					is_ctx_user += "'" + String( tab_rpt.tabpage_criteria.dw_criteria.GetItemString( i, "user_id" )) + "', "
				end if
			next
			is_ctx_user = LeftA( is_ctx_user, LenA( is_ctx_user ) -2 )
		end if
		IF is_ctx_user = "" THEN
			MessageBox("Selection Error", "You must at least select one check box." )
			Return -1
		END IF
	Case "d_rpt_ctx_wiz_status_select"
		il_Start_Status = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus")
		il_End_Status = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus")
	//---------------------------- APPEON END ----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-08-13 By: Scofield
	//$<Reason> Add multi status process

	Case "d_rpt_ctx_wiz_multi_status_select"
		il_StartStatus_1 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus_1")
		if IsNull(il_StartStatus_1) then il_StartStatus_1 = 0
		il_EndStatus_1 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus_1")
		if IsNull(il_EndStatus_1) then il_EndStatus_1 = 0
		
		il_StartStatus_2 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus_2")
		if IsNull(il_StartStatus_2) then il_StartStatus_2 = 0
		il_EndStatus_2 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus_2")
		if IsNull(il_EndStatus_2) then il_EndStatus_2 = 0
		
		il_StartStatus_3 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus_3")
		if IsNull(il_StartStatus_3) then il_StartStatus_3 = 0
		il_EndStatus_3 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus_3")
		if IsNull(il_EndStatus_3) then il_EndStatus_3 = 0
		
		il_StartStatus_4 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_startstatus_4")
		if IsNull(il_StartStatus_4) then il_StartStatus_4 = 0
		il_EndStatus_4 = tab_rpt.tabpage_criteria.dw_criteria.GetItemNumber(1,"as_endstatus_4")
		if IsNull(il_EndStatus_4) then il_EndStatus_4 = 0
	//---------------------------- APPEON END ----------------------------
End Choose

Return 0;

end function

public subroutine of_contract_wizard_prior ();//////////////////////////////////////////////////////////////////////
// $<function>w_report.of_contract_wizard_prior()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description> While click Prior button, data of current datawindow
// $<description> is stored through this function.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-08-01 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////
Choose Case tab_rpt.tabpage_criteria.dw_criteria.DataObject
	case "d_rpt_ctx_wiz_select"
		is_ctx_data_contract = tab_rpt.tabpage_criteria.dw_criteria.Describe( "Datawindow.Data" )
	case "d_rpt_ctx_wiz_select_cptcode"
		is_ctx_data_cptcode = tab_rpt.tabpage_criteria.dw_criteria.Describe( "Datawindow.Data" )
End Choose
end subroutine

public subroutine of_contract_calc_crosstab ();//////////////////////////////////////////////////////////////////////
// $<function>w_report/of_contract_calc_crosstab()
// $<arguments> (none)
// $<returns>   (none)
// $<description> Calculate the fields of contract crosstab report.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-09-30 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////

Integer li_cols, li_rowcount, i, j, k, li_count, li_temp, li_found
Dec{2} ld_max = 0, ld_min = 0, ld_current, ld_sum[], ld_temp, ld_sort[]
constant integer ci_start = 5
string ls_out

li_rowcount = tab_rpt.tabpage_report.dw_report.Rowcount()

For i = 1 to li_rowcount
	li_temp = tab_rpt.tabpage_report.dw_report.GetItemNumber( i, "c_count" )
	if li_temp > li_cols then li_cols = li_temp
Next

li_cols += ci_start - 1

For i = 1 to li_rowcount
	For j = ci_start to li_cols
		
		For k = 1 to li_rowcount

			ld_current = tab_rpt.tabpage_report.dw_report.GetitemNumber( k, j )
			if isnull( ld_current ) then continue;
			li_count++;
			if li_count = 1 then
				ld_max = ld_current
				ld_min = ld_current
			end if
			
			if ld_current > ld_max then ld_max = ld_current
			if ld_current < ld_min then ld_min = ld_current
		Next
		
		if li_count > 0 then
			if ld_max = tab_rpt.tabpage_report.dw_report.GetItemNumber( i, j ) and ld_max > 0 then
				tab_rpt.tabpage_report.dw_report.SetItem( i, "maxcount", tab_rpt.tabpage_report.dw_report.GetItemNumber( i, "maxcount" ) + 1 )
			end if
			if ld_min = tab_rpt.tabpage_report.dw_report.GetItemNumber( i, j ) and ld_min > 0 then
				tab_rpt.tabpage_report.dw_report.SetItem( i, "mincount", tab_rpt.tabpage_report.dw_report.GetItemNumber( i, "mincount" ) + 1 )
			end if
		end if
		li_count = 0
	Next
Next

// sort of sum
For i = 1 to li_rowcount
	ld_sum[i] = tab_rpt.tabpage_report.dw_report.GetItemNumber( i, "c_total" )
Next

For i = 1 to li_rowcount
	For j = 1 to li_rowcount
		if ld_sum[ i ] > ld_sum[ j ] then
			ld_temp = ld_sum[ j ]
			ld_sum[ j ] = ld_sum[ i ]
			ld_sum[ i ] = ld_temp
		end if
	Next
Next

k = 0;
For i = 1 to li_rowcount
	if i > 1 then
		if ld_sum[i] = ld_sum[i - 1] then continue;
	end if
	
	k++;
	ld_sort[ k ] = ld_sum[ i ]
Next

For i = 1 to k
	Do
		li_found = tab_rpt.tabpage_report.dw_report.Find( "c_total = " + string( ld_sort[ i ] ), li_found, li_rowcount )
		if li_found > 0 then
			tab_rpt.tabpage_report.dw_report.SetItem( li_found, "feerating", i )
			li_found ++;
		end if
	Loop While li_found > 0 and li_found <= li_rowcount
	li_found = 1
Next
end subroutine

public subroutine of_dashboard (long ai_report_id);Long ll_find
ll_find = tab_rpt.tabpage_criteria.dw_select_report.Find("report_id="+String(ai_report_id), 1, tab_rpt.tabpage_criteria.dw_select_report.RowCount())
IF ll_find > 0 THEN
	tab_rpt.tabpage_criteria.dw_select_report.SelectRow(0 , False)
	tab_rpt.tabpage_criteria.dw_select_report.ScrollToRow(ll_find)
	tab_rpt.tabpage_criteria.dw_select_report.SelectRow(ll_find , True)
	If This.WindowState = Minimized! Then This.windowstate = Normal!
END IF


end subroutine

public function integer of_log_report (integer ai_report);integer nr
long ll_id
datetime ldt_date

ldt_date = datetime(today(),now())

nr = dw_report_log.insertrow(0)

dw_report_log.setitem(nr,"report_id",ai_report)
dw_report_log.setitem(nr,"user_id",gs_user_id )
dw_report_log.setitem(nr,"date_run",ldt_date)
//Start Code Change ----01.20.2015 #V14.2 maha
dw_report_log.setitem(nr,"run_from","MAN")
dw_report_log.setitem(nr,"rpt_type","S")
//End Code Change ----01.20.2015

select max(log_id  ) into :ll_id from sys_report_log;
if isnull(ll_id) then ll_id = 0
ll_id++
dw_report_log.setitem(nr,"log_id",ll_id)
dw_report_log.update()

return 1
end function

public subroutine of_get_filter_status ();//////////////////////////////////////////////////////////////////////
// $<function>w_report::of_get_filter_status()
// $<arguments>(None)
// $<description>
// $<description> Get access filter status.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-21 by Ken.Guo
//(Appeon)Toney 06.07.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Integer li_except_reports,li_except_current_user

gnv_appeondb.of_startqueue( )
	Select reports_use_access Into :li_except_reports From icred_settings;
	Select count(1) Into :li_except_current_user From 
	(
		Select user_id from reports_except_users where user_id = :gs_user_id
		Union
		Select user_id from reports_except_roles,security_users
		Where reports_except_roles.roles_id = security_users.role_id and security_users.user_id = :gs_user_id
	) users;
gnv_appeondb.of_commitqueue( )

If li_except_reports = 0 or li_except_current_user > 0 Then
	ib_access_filter = False
Else
	ib_access_filter = True
End If

end subroutine

public function integer of_filter_noaccess ();//////////////////////////////////////////////////////////////////////
// $<function>w_report::of_filter_noaccess()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Filter data that login user have no right to access.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-20 by Ken.Guo
//(Appeon)Toney 06.07.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////

Integer li_access
Long ll_cnt,i,j,k,ll_ctx_id
String ls_objects,ls_sub_objects,ls_objects_arr[],ls_sub_objects_arr[]
String ls_ctx_id_col
String ls_filter
Long ll_max_row
n_cst_string_appeon lnv_string
Datawindow dw_report
DatawindowChild ldwc_report

//If Need not filter by access. 
If ib_access_filter = False Then Return 1

If AppeonGetClientType() = 'WEB' Then
	ll_max_row = 30 //30 is fastest
Else
	ll_max_row = -1
End If

k = 0
dw_report = tab_rpt.tabpage_report.dw_report

//Check Setting

//If user have full Access, then return
ll_cnt = ids_ctx_user_noaccess.RowCount()
If ll_cnt = 0 Then Return 1

If dw_report.Describe('Datawindow.processing') = '5' Then
	//For Composite DW
	ls_objects = dw_report.Describe("DataWindow.Objects")
	lnv_string.of_parsetoarray(ls_objects ,'~t',ls_objects_arr[] )
	For j = 1 To UpperBound(ls_objects_arr[])
		If Lower(dw_report.Describe(ls_objects_arr[j]+".type")) = 'report' Then
			//Filter sub-report data
			If dw_report.GetChild(ls_objects_arr[j],ldwc_report) = 1 Then
				If ldwc_report.RowCount() = 0 Then Continue
				//Get ctx_id column
				If ldwc_report.Describe('ctx_basic_info_ctx_id.type') = 'column' Then
					ls_ctx_id_col = "ctx_basic_info_ctx_id"
				Else
					ls_sub_objects = ldwc_report.Describe("DataWindow.Objects")
					lnv_string.of_parsetoarray(ls_sub_objects ,'~t',ls_sub_objects_arr[] )
					For i = 1 To UpperBound(ls_sub_objects_arr[])
						If Pos(Lower(ls_sub_objects_arr[i]),'_ctx_id') > 0 And &
							ldwc_report.Describe(ls_sub_objects_arr[i] + '.type') = 'column' And &
							Pos(Lower(ls_sub_objects_arr[i]),'ctx_id_') = 0	Then
							ls_ctx_id_col = ls_sub_objects_arr[i]
							Exit
						End If
					Next
				End If
				
				//Gen filter condition by ctx_id
				If ls_ctx_id_col <> '' Then
					ldwc_report.RowsDiscard(1,ldwc_report.filteredcount(),filter!)
					For i = 1 To ll_cnt
						k++
						ll_ctx_id = ids_ctx_user_noaccess.GetItemNumber(i,'ctx_id')
						If ls_filter = '' Then
							ls_filter = ls_ctx_id_col + ' <> ' + String(ll_ctx_id)
						Else
							ls_filter = ls_filter + ' And ' + ls_ctx_id_col + ' <> ' + String(ll_ctx_id)
						End If
						//Filter data per 30 steps.
						If k = ll_max_row or i = ll_cnt Then
							If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(5)
							ldwc_report.SetFilter(ls_filter)
							ldwc_report.Filter()
							If AppeonGetClientType() = 'WEB' Then
								//Only Web need delete. If PB delete it, Crash. PB's Bug.
								ldwc_report.RowsDiscard(1,ldwc_report.filteredcount(),filter!)
							End If
							ls_filter = ''
							k = 0				
						End If
					Next
				End If
				ldwc_report.groupcalc()			
			End If
		End If
	Next
Else //For non-composite DW
	If dw_report.Rowcount() = 0 Then Return 1
	//Get ctx_id column
	If dw_report.Describe('ctx_basic_info_ctx_id.type') = 'column' Then
		ls_ctx_id_col = "ctx_basic_info_ctx_id"
	Else
		ls_objects = dw_report.Describe("DataWindow.Objects")
		lnv_string.of_parsetoarray(ls_objects ,'~t',ls_objects_arr[] )
		For i = 1 To UpperBound(ls_objects_arr[])
			If Pos(Lower(ls_objects_arr[i]),'_ctx_id') > 0 And &
				dw_report.Describe(ls_objects_arr[i] + '.type') = 'column' And &
				Pos(Lower(ls_objects_arr[i]),'ctx_id_') = 0  Then
				ls_ctx_id_col = ls_objects_arr[i]
				Exit
			End If
		Next
	End If
	
	//Gen filter condition by ctx_id
	If ls_ctx_id_col <> '' Then
		dw_report.RowsDiscard(1,dw_report.filteredcount(),filter!)
		For i = 1 To ll_cnt
			k++
			ll_ctx_id = ids_ctx_user_noaccess.GetItemNumber(i,'ctx_id')
			If ls_filter = '' Then
				ls_filter = ls_ctx_id_col + ' <> ' + String(ll_ctx_id)
			Else
				ls_filter = ls_filter + ' And ' + ls_ctx_id_col + ' <> ' + String(ll_ctx_id)
			End If
			//Filter data per 30 steps.
			If k = ll_max_row or i = ll_cnt Then
				If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(5)				
				dw_report.SetFilter(ls_filter)
				dw_report.Filter()
				If AppeonGetClientType() = 'WEB' Then
					//Only Web need delete. If PB delete it, Crash. PB's Bug.
					dw_report.RowsDiscard(1,dw_report.filteredcount(),filter!)
				End If
				ls_filter = ''
				k = 0				
			End If
		Next
	End If
	dw_report.groupcalc()
End If

Return 1
end function

public function long of_find_sql_key (string as_source, string as_sql_key);//////////////////////////////////////////////////////////////////////
// $<function>w_report::of_find_sql_key()
// $<arguments>
//		value	string	as_source 		
//		value	string	as_sql_key "select", "where","from","group by","order by"		 
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.20.2009 by Ken.Guo
//(Appeon)Toney 06.07.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////


//Only support sample SQL. if include sub query, error???
Long ll_pos

as_sql_key = upper(as_sql_key)

If Pos(Upper(as_source),as_sql_key + ' ') > 0 Then //Empty string
	ll_pos = Pos(Upper(as_source),as_sql_key + ' ')
ELSEIf Pos(Upper(as_source),as_sql_key + '~t') > 0 Then//Tab 
	ll_pos = Pos(Upper(as_source),as_sql_key + '~t')
ElseIf Pos(Upper(as_source),as_sql_key + '~r~n') > 0 Then //~r~n
	ll_pos = Pos(Upper(as_source),as_sql_key + '~r~n') 
Else
	ll_pos = 0
End If

Return ll_pos
end function

on w_report.create
int iCurrent
call super::create
this.cb_store=create cb_store
this.tab_rpt=create tab_rpt
this.cb_close=create cb_close
this.dw_report_log=create dw_report_log
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_store
this.Control[iCurrent+2]=this.tab_rpt
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_report_log
end on

on w_report.destroy
call super::destroy
destroy(this.cb_store)
destroy(this.tab_rpt)
destroy(this.cb_close)
destroy(this.dw_report_log)
end on

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
/*
w_mdi.ChangeMenu( m_pfe_cst_reports )
*/
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)

If w_mdi.menuname <> 'm_pfe_cst_reports' Then w_mdi.ChangeMenu( m_pfe_cst_reports )
//---------------------------- APPEON END ----------------------------

w_mdi.SetToolbarPos ( 2, 1, 200, False)	
w_mdi.of_menu_security( w_mdi.MenuName )


end event

event open;call super::open;//This.Width = 3657
//This.Height = 2060
This.x = 0
This.y = 0
Integer li_dept_secure_setting

il_zoom = 100

inv_reports = CREATE pfc_cst_u_reports

w_mdi.of_menu_security( w_mdi.MenuName )

gnv_appeondb.of_startqueue( )

SELECT set_37
INTO: ii_dept_security_on
FROM icred_settings;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_commitqueue()
	RETURN 1
END IF

SELECT Count( lookup_code )
INTO :ii_num_of_departments
FROM code_lookup
WHERE lookup_name = 'department';
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_commitqueue()
	RETURN -1
END IF

SELECT Count( department_id )
INTO :ii_num_of_departments_user_has_access_to
FROM security_user_department
WHERE user_id = :gs_user_id AND
		access_rights = 1;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
	gnv_appeondb.of_commitqueue()
	RETURN 1
END IF

gnv_appeondb.of_commitqueue( )

//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
ids_ctx_user_noaccess = Create DataStore
ids_ctx_user_noaccess.Dataobject = 'd_ctx_user_noaccess'
ids_ctx_user_noaccess.SetTransObject(SQLCA)
ids_ctx_user_noaccess.Retrieve(gs_user_id)
//---------End Added ------------------------------------------------------------------


IF ii_dept_security_on <> 1 THEN
	ii_num_of_departments = 0
	ii_num_of_departments_user_has_access_to = 0
END IF

//---------------------------- APPEON END ----------------------------

//--------Begin Added by Nova 08.13.2008------------------------
If Isvalid(message.powerobjectparm) Then
	If message.powerobjectparm.classname() = 'str_dashboard' Then
		str_para=message.powerobjectparm
		ib_auto_locate = True
	End If
End If
//--------End Added --------------------------------------------
 
//---------Begin Added by (Appeon)Stephen 06.02.2017 for V15.4-WebView Reporting Functionality--------
if w_mdi.of_security_access( 7848 ) = 0 then 
	cb_store.visible = false
end if
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
//Added by Ken.Guo on 2009-04-21
of_get_filter_status()
//---------End Added ------------------------------------------------------------------


end event

event close;call super::close;DESTROY inv_reports
//---------Begin Added by (Appeon)Toney 06.07.2013 for V141 ISG-CLX--------
If isvalid(ids_ctx_user_noaccess) Then Destroy ids_ctx_user_noaccess
//---------End Added ------------------------------------------------------------------

w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

w_mdi.of_menu_security( w_mdi.MenuName )


end event

event pfc_preopen;call super::pfc_preopen;//this.of_SetResize(TRUE)
//this.inv_resize.of_SetOrigSize (this.width, this.height)
//string ls_resize_method
////this.tab_rpt.of_SetResize(TRUE)
////ls_resize_method = inv_resize.fixedbottom_scaleright
////ls_resize_method = inv_resize.fixedbottom
////ls_resize_method = inv_resize.fixedright
////ls_resize_method = inv_resize.fixedright_scalebottom
////ls_resize_method = inv_resize.fixedrightbottom
////ls_resize_method = inv_resize.fixedrightbottom
////ls_resize_method = inv_resize.scalebottom
////ls_resize_method = inv_resize.scalerightbottom
////ls_resize_method = inv_resize.scaleright
//ls_resize_method = inv_resize.scale
//
//LONG LL_I
//
//FOR LL_I =  1 TO UPPERBOUND(THIS.CONTrol)
//   this.inv_resize.of_Register (THIS.CONTrol[LL_I]  , ls_resize_method  )
//NEXT
//
////FOR LL_I =  1 TO UPPERBOUND(THIS.tab_rpt.tabpage_criteria.CONTrol)
////   this.inv_resize.of_Register (THIS.tab_rpt.tabpage_criteria.CONTrol[LL_I]  , ls_resize_method  )
////NEXT
////FOR LL_I =  1 TO UPPERBOUND(THIS.tab_rpt.tabpage_graph.CONTrol)
////   this.inv_resize.of_Register (THIS.tab_rpt.tabpage_graph.CONTrol[LL_I]  , ls_resize_method )
////NEXT
////
////FOR LL_I =  1 TO UPPERBOUND(THIS.tab_rpt.tabpage_report.CONTrol)
////   this.inv_resize.of_Register (THIS.tab_rpt.tabpage_report.CONTrol[LL_I]  ,  ls_resize_method)
////NEXT

this.of_SetResize(TRUE)
this.inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
this.inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_register(cb_close,inv_resize.fixedrightbottom)
this.inv_resize.of_register(tab_rpt,inv_resize.scalerightbottom)

//this.inv_resize.of_Register (this.tab_rpt, 0, 0, 100, 100)
//this.inv_resize.of_register(tab_rpt.tabpage_criteria,inv_resize.scalerightbottom)
//this.inv_resize.of_register(tab_rpt.tabpage_report,inv_resize.scalerightbottom)
//this.inv_resize.of_register(tab_rpt.tabpage_report.st_rec_cnt, inv_resize.scalerightbottom)
//this.inv_resize.of_register(tab_rpt.tabpage_report.cb_print , inv_resize.scalerightbottom)
//this.inv_resize.of_register(tab_rpt.tabpage_report,  0, 0, 100,100)
//this.inv_resize.of_register(tab_rpt.tabpage_report.cb_print,  0, 0, 0, 0)



end event

event resize;call super::resize;//dont do it //Start Code Change ---- 05.09.2006 #435 maha

cb_close.y = tab_rpt.y  //Add by Stephen 04.14.2011 --- N/A
end event

event pfc_postopen;call super::pfc_postopen; 
//For dashborad  Added by Nova 08.13.2008
if ib_auto_locate then of_dashboard(str_para.data_id)
end event

event pfc_preclose;call super::pfc_preclose;//====================================================================
//$<Event>: pfc_preclose
//$<Arguments>:
//$<Return>:  integer
//$<Description>: check before close window.
//$<Author>: (Appeon) long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Boolean lb_allow_close_window

lb_allow_close_window = tab_rpt.of_is_closewindow_allowed()
If lb_allow_close_window Then
	Return 1
Else
	Messagebox(gnv_app.iapp_object.DisplayName, 'Current window is still processing data. Please wait a moment.')
	Return -1
End If
end event

type cb_store from commandbutton within w_report
integer x = 3109
integer y = 12
integer width = 439
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "S&tore Report"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.02.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_path
string ls_filename
string ls_note
integer li_ret
long   ll_report_storage_id
long ll_row
boolean ab_Version
str_b    lstr_rpt
appeon_pdfservice lnv_pdf
n_cst_excel lnv_excel

ll_row = tab_rpt.tabpage_report.dw_report.rowcount()
if ll_row < 1 then return

if ii_report_id < 1 or isnull(ii_report_id) then return

openwithparm(w_rpt_storage_select, "R-S:"+string(ii_report_id))
lstr_rpt = message.powerobjectparm
ll_report_storage_id = lstr_rpt.i_count
ls_note = lstr_rpt.s_type
if ll_report_storage_id < 1 then
	messagebox("Prompt", "This record doesn’t have report storage information. Please set it up in Saved Report Setup window. ")
	return
end if

li_ret = getfilesavename("Save As File", ls_path, ls_filename, "PDF", "Excel (*.xlsx),*.xlsx,Excel (*.xls),*.xls,PDF(*.pdf),*.pdf")///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
ChangeDirectory(gs_current_path)
if li_ret <> 1 then return

choose case upper(right(ls_filename,4))
	case ".PDF"
		lnv_pdf = Create appeon_pdfservice
		li_ret = lnv_pdf.of_Print(tab_rpt.tabpage_report.dw_report, ls_path)
		Destroy lnv_pdf
	case ".XLS",  "XLSX"	///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
		if integer(tab_rpt.tabpage_report.dw_report.describe("Datawindow.Processing")) > 1 then
			tab_rpt.tabpage_report.dw_report.SaveAs(ls_path, Excel!, true)
		else
			lnv_excel = create n_cst_excel
			if Integer( gf_GetExcelVersion( ) ) >=12 then
				ab_Version = true
			end if
			lnv_excel.ib_read = false
			lnv_excel.of_saveas_excel( tab_rpt.tabpage_report.dw_report, ls_path, true, ab_Version )
			destroy lnv_excel
		end if
end choose

datetime ldt_null
if fileexists(ls_path) and ll_report_storage_id>0 then
	f_report_storage(ll_report_storage_id, ls_path, ll_row, ldt_null, ldt_null, ls_note, 'M')
end if

end event

type tab_rpt from u_tab_report_tab within w_report
integer y = 16
integer width = 4059
integer height = 2324
integer taborder = 11
integer weight = 700
fontcharset fontcharset = ansi!
end type

event selectionchanged;call super::selectionchanged;
if newindex = 2 then
	cb_store.visible = true
else
	cb_store.visible = false
end if
end event

type cb_close from u_cb within w_report
integer x = 3671
integer y = 12
integer width = 375
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type dw_report_log from datawindow within w_report
boolean visible = false
integer x = 2386
integer y = 1496
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_report_log_de"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

