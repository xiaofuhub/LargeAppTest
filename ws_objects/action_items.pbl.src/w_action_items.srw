$PBExportHeader$w_action_items.srw
forward
global type w_action_items from w_sheet
end type
type cb_bb10 from commandbutton within w_action_items
end type
type cb_bb9 from commandbutton within w_action_items
end type
type cb_bb8 from commandbutton within w_action_items
end type
type cb_bb7 from commandbutton within w_action_items
end type
type cb_bb6 from commandbutton within w_action_items
end type
type cb_bb5 from commandbutton within w_action_items
end type
type cb_bb4 from commandbutton within w_action_items
end type
type cb_bb3 from commandbutton within w_action_items
end type
type cb_bb2 from commandbutton within w_action_items
end type
type cb_save from commandbutton within w_action_items
end type
type p_buttons from picture within w_action_items
end type
type dw_filter from datawindow within w_action_items
end type
type p_1 from picture within w_action_items
end type
type st_filter from statictext within w_action_items
end type
type dw_select_org_facility from pfc_cst_u_org_facility_selector_horiz within w_action_items
end type
type dw_user from pfc_cst_u_user_selector within w_action_items
end type
type tab_1 from tab within w_action_items
end type
type tabpage_analysis from userobject within tab_1
end type
type tab_analysis from tab within tabpage_analysis
end type
type tabpage_last_attempt from userobject within tab_analysis
end type
type dw_last_attemp_graph from u_dw within tabpage_last_attempt
end type
type tabpage_last_attempt from userobject within tab_analysis
dw_last_attemp_graph dw_last_attemp_graph
end type
type tabpage_total_attempts from userobject within tab_analysis
end type
type dw_total_attempts from u_dw within tabpage_total_attempts
end type
type tabpage_total_attempts from userobject within tab_analysis
dw_total_attempts dw_total_attempts
end type
type tabpage_expiring_credentials from userobject within tab_analysis
end type
type dw_expiring_credential_graph from u_dw within tabpage_expiring_credentials
end type
type tabpage_expiring_credentials from userobject within tab_analysis
dw_expiring_credential_graph dw_expiring_credential_graph
end type
type tabpage_exp_appointments from userobject within tab_analysis
end type
type dw_expiring_appointments_graph from u_dw within tabpage_exp_appointments
end type
type tabpage_exp_appointments from userobject within tab_analysis
dw_expiring_appointments_graph dw_expiring_appointments_graph
end type
type tabpage_audit from userobject within tab_analysis
end type
type dw_app_audit_graph from u_dw within tabpage_audit
end type
type tabpage_audit from userobject within tab_analysis
dw_app_audit_graph dw_app_audit_graph
end type
type tabpage_process from userobject within tab_analysis
end type
type dw_process_graph from u_dw within tabpage_process
end type
type tabpage_process from userobject within tab_analysis
dw_process_graph dw_process_graph
end type
type tab_analysis from tab within tabpage_analysis
tabpage_last_attempt tabpage_last_attempt
tabpage_total_attempts tabpage_total_attempts
tabpage_expiring_credentials tabpage_expiring_credentials
tabpage_exp_appointments tabpage_exp_appointments
tabpage_audit tabpage_audit
tabpage_process tabpage_process
end type
type st_msg from statictext within tabpage_analysis
end type
type cb_refresh from commandbutton within tabpage_analysis
end type
type tabpage_analysis from userobject within tab_1
tab_analysis tab_analysis
st_msg st_msg
cb_refresh cb_refresh
end type
type tabpage_detail from userobject within tab_1
end type
type cbx_preserve from checkbox within tabpage_detail
end type
type cbx_add_missing from checkbox within tabpage_detail
end type
type tab_view from tab within tabpage_detail
end type
type tabpage_browse from userobject within tab_view
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_view
dw_browse dw_browse
end type
type tabpage_details from userobject within tab_view
end type
type dw_detail from u_dw within tabpage_details
end type
type dw_dummy_browse from u_dw within tabpage_details
end type
type st_name from statictext within tabpage_details
end type
type tabpage_details from userobject within tab_view
dw_detail dw_detail
dw_dummy_browse dw_dummy_browse
st_name st_name
end type
type tab_view from tab within tabpage_detail
tabpage_browse tabpage_browse
tabpage_details tabpage_details
end type
type sle_doc_find from singlelineedit within tabpage_detail
end type
type cb_find from commandbutton within tabpage_detail
end type
type st_find from statictext within tabpage_detail
end type
type cb_init_recred from commandbutton within tabpage_detail
end type
type st_1 from statictext within tabpage_detail
end type
type cb_recred_no_ver from commandbutton within tabpage_detail
end type
type dw_tracker from datawindow within tabpage_detail
end type
type cbx_priv from checkbox within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
cbx_preserve cbx_preserve
cbx_add_missing cbx_add_missing
tab_view tab_view
sle_doc_find sle_doc_find
cb_find cb_find
st_find st_find
cb_init_recred cb_init_recred
st_1 st_1
cb_recred_no_ver cb_recred_no_ver
dw_tracker dw_tracker
cbx_priv cbx_priv
end type
type tabpage_ready from userobject within tab_1
end type
type rb_meet from radiobutton within tabpage_ready
end type
type rb_record from radiobutton within tabpage_ready
end type
type tab_ready from tab within tabpage_ready
end type
type tabpage_ready_to_send from userobject within tab_ready
end type
type dw_ready from u_dw within tabpage_ready_to_send
end type
type tabpage_ready_to_send from userobject within tab_ready
dw_ready dw_ready
end type
type tabpage_sent_to_comm from userobject within tab_ready
end type
type uo_meeting from uo_meet_approval within tabpage_sent_to_comm
end type
type dw_sent_to_comm from u_dw within tabpage_sent_to_comm
end type
type tabpage_sent_to_comm from userobject within tab_ready
uo_meeting uo_meeting
dw_sent_to_comm dw_sent_to_comm
end type
type tab_ready from tab within tabpage_ready
tabpage_ready_to_send tabpage_ready_to_send
tabpage_sent_to_comm tabpage_sent_to_comm
end type
type cb_send from commandbutton within tabpage_ready
end type
type dw_committee from u_dw within tabpage_ready
end type
type st_committee from statictext within tabpage_ready
end type
type cb_post from commandbutton within tabpage_ready
end type
type cb_1 from commandbutton within tabpage_ready
end type
type tabpage_ready from userobject within tab_1
rb_meet rb_meet
rb_record rb_record
tab_ready tab_ready
cb_send cb_send
dw_committee dw_committee
st_committee st_committee
cb_post cb_post
cb_1 cb_1
end type
type tabpage_net_dev from userobject within tab_1
end type
type uo_net_dev from pfc_ia_cst_nv_net_dev_new_action_items within tabpage_net_dev
end type
type tabpage_net_dev from userobject within tab_1
uo_net_dev uo_net_dev
end type
type tabpage_contract from userobject within tab_1
end type
type uo_1 from uo_ctx_ai within tabpage_contract
end type
type tabpage_contract from userobject within tab_1
uo_1 uo_1
end type
type tabpage_document_manager from uo_ctx_ai_doc within tab_1
end type
type tabpage_document_manager from uo_ctx_ai_doc within tab_1
end type
type tab_1 from tab within w_action_items
tabpage_analysis tabpage_analysis
tabpage_detail tabpage_detail
tabpage_ready tabpage_ready
tabpage_net_dev tabpage_net_dev
tabpage_contract tabpage_contract
tabpage_document_manager tabpage_document_manager
end type
type uo_lights from uo_filter_lights within w_action_items
end type
type cbx_checklist from checkbox within w_action_items
end type
type st_buttons from statictext within w_action_items
end type
type cb_close from commandbutton within w_action_items
end type
type ddplb_filters from dropdownpicturelistbox within w_action_items
end type
end forward

global type w_action_items from w_sheet
integer x = 5
integer y = 224
integer width = 4626
integer height = 2492
string title = "Action Items"
long backcolor = 33551856
boolean clientedge = true
event pfc_filter_wizard ( )
event pfc_grph_by_total_attempts ( )
event pfc_grph_by_last_attempt ( )
event pfc_cst_print_letters ( )
event pfc_cst_goto_web ( )
event pfc_cst_edit ( )
event pfc_cst_dial_phone ( )
event pfc_cst_refresh ( )
event pfc_cst_npdb_export ( )
event pfc_cst_print_report ( )
event pfc_cst_print_net_dev_ltr ( )
event pfc_cst_print_net_dev_report ( )
event pfc_cst_iverify ( )
event pfc_cst_net_dev_filter ( )
event pfc_cst_scan_oig ( )
event pfc_cst_intellibatch_filter ( )
event pfc_cst_missing_info ( )
event pfc_cst_batch_response ( )
event pfc_cst_addtl_filters ( )
event pfc_cst_capture_image ( )
event se_post_event ( )
event ue_postupdate ( )
event pfc_cst_batch_recredential ( )
event pfc_cst_clear_print ( )
event pfc_cst_batch_update ( )
event pfc_email_payor ( )
event pfc_cst_print_apps_from_pf ( )
event pfc_cst_ama_api ( )
cb_bb10 cb_bb10
cb_bb9 cb_bb9
cb_bb8 cb_bb8
cb_bb7 cb_bb7
cb_bb6 cb_bb6
cb_bb5 cb_bb5
cb_bb4 cb_bb4
cb_bb3 cb_bb3
cb_bb2 cb_bb2
cb_save cb_save
p_buttons p_buttons
dw_filter dw_filter
p_1 p_1
st_filter st_filter
dw_select_org_facility dw_select_org_facility
dw_user dw_user
tab_1 tab_1
uo_lights uo_lights
cbx_checklist cbx_checklist
st_buttons st_buttons
cb_close cb_close
ddplb_filters ddplb_filters
end type
global w_action_items w_action_items

type variables
integer ii_dashboard_macro = -1

pfc_cst_nv_data_entry_functions inv_data_entry
pfc_n_cst_ai_printletters inv_printletters
pfc_n_cst_ai_action_items inv_action_items
n_cst_process_actions inv_pro_actions //maha 07.06.2011
n_cst_datetime inv_datetime //maha 09.30.2014
n_cst_dataflow inv_dataflow[6] //maha 09.14.2017
n_cst_dataflow inv_dataflows //maha 09.14.2017

String is_display_text
String is_current_graph = "last_attempt"
String is_filter
String is_user_id = "All"
string is_batch_filter = ""
string is_addtl_filter = ""
string is_ir_filter = ""
string is_screen_filter = ""
string is_combined_filters
string is_lookup_search_column_table //maha 07.25.2013
string is_other_method   //maha 11.01.2017

Long il_prac_ids[]

Boolean lb_response_cd_entered = False
boolean ib_letters
boolean ib_cache = false
boolean ib_privs
boolean ib_netdev_retr = false
boolean ib_clist_filter = false  //maha 11.09.2012 - used in conjunction with the clist checkbox to filter for completed checklist
boolean ib_incomplete_only = true //maha 07.30.2015 - appl actions

// mskinner 22 March 2006 -- begin
boolean ib_original_sql_set
// mskinner 22 March 2006 -- end
Integer ii_facility_ids[]
Integer ii_screen_ids[]
Integer il_total_filter_items 
Integer il_selected_cnt = 0
Integer ii_filter_index
Integer ii_cr
Integer ii_org_id = 0 
Integer ii_facility_id = 0
Integer ii_facility_ids_all[]
Integer ii_comm_id = 0
Integer ii_comm_ids_all[]
integer ii_egg

u_dw idw_focus

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-12 By: Rodger Wu (Inova)
//$<reason> Set a flag for refresh verification records once Practitioner Data changed.

Boolean ib_prac_data_changed = False

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Jervis
//$<reason> modify work flow
str_action_item istr_action[]

//---------------------------- APPEON END ----------------------------

//Added By Jervis 12.5.2006
string is_prior


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.07.2006 By: Davis
//$<reason> For dashboard
STRING ii_dashboard_where
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> Michael 10.25.2011
//$<reason>V12.1 Migrate AI addtl filters
boolean ib_prac = False
boolean ib_ir = False
boolean ib_screen = False
//---------------------------- APPEON END ----------------------------
boolean ib_data_entry = false //long.zhang 09.29.2012
//---------Begin Added by (Appeon)Stephen 08.28.2013 for V141 Email/Fax Applications to Payors--------
boolean ib_dev_net_access = false 
boolean ib_dev_net_print = false
//---------End Added ------------------------------------------------------

DataStore ids_app_hdr_all //alfee 04.01.2014
boolean ib_check_role = false

end variables

forward prototypes
public function integer of_get_ready_for_committee ()
public function integer of_filter_by_intellibatch (datawindow adw_dw)
public function string of_get_filter (string as_type)
public function string of_addtl_filter (integer ai_for)
public function integer of_filter_lights (string as_type)
public function integer of_graph_case (integer ai_case)
public function integer of_goto_net_dev_tab ()
public function integer of_dash_goto_overdue_net_dev ()
public function integer of_se ()
public function integer of_net_dev_ai_menu ()
public function integer of_web_crawl ()
public function integer of_updatecheck (powerobject apo_control[], ref powerobject apo_control_update[])
public function integer of_batch_recred ()
public function integer of_clear_print ()
public function integer of_get_items_list ()
public function integer of_browse_security ()
public function integer of_graph_post_click ()
public function integer of_get_table_id (integer ai_screen_id)
public function boolean of_find_print_flag ()
public function integer of_filter_visible (boolean ab_true)
public function integer of_app_print_menu (u_dw adw_net_dev, long al_row, integer ai_select)
public subroutine of_refresh_appl_data ()
public function integer of_select_prac (integer al_row, u_dw adw_record)
public function integer of_buttons_prop (integer ai_tab)
public function integer of_enable_action_buttons ()
public function integer of_ama_api ()
public subroutine of_zoom ()
end prototypes

event pfc_filter_wizard();string f

setnull( f)

choose case tab_1.selectedtab
	case 1
		tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.setfilter( f)
		tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.filter()
	case 2
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.setfilter( f)
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.filter()
end choose
end event

event pfc_grph_by_last_attempt();tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.DataObject = "d_verification_graph_by_last_attemp"
tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.of_SetTransObject( SQLCA )
tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.Event pfc_Retrieve( )
end event

event pfc_cst_print_letters();gs_pass_ids lstr_ids
Integer li_rc
Integer i
Integer li_print_cnt
long ll_ver_method_ver_ltr 
long ll_ver_method_corre_ltr 
long ll_ver_method_exp_ltr 
long ll_ver_method_exp_appt_ltr
long ll_method
string ls_filter
boolean lb_ofe = false

// start code change --- 11.14.2005 MSKINNER

if w_mdi.menuname = 'm_pfe_cst_action_items'  then 
	if m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Contract' then 
		this.tab_1.tabpage_contract.uo_1.tab_1.tabpage_2.event ue_print_letters( )
		return 
	end if 
end if
  
  
// regular letter processing stuff
lstr_ids.s_stringval = ddplb_filters.Text
lstr_ids.dw = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
//Start Code Change ----07.06.2011 #V11 maha -Process letters
if ddplb_filters.Text = "PROCESS ACTIONS LETTERS to be printed" or ls_filter =  "PROCESS ACTIONS LETTERS awaiting response" THEN
	lstr_ids.committee_id = 1
	lb_ofe = true
end if
//End Code Change ----07.06.2011

li_rc = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount()

ls_filter =  ddplb_filters.Text



//Start Code Change ---- 10.18.2007 #V7 maha
if ls_filter = "PRACTITIONER                  All Action Items For A Practitioner" or ls_filter =  "PRACTITIONER - All Action Items For A Practitioner" THEN
	//messagebox("", ddplb_filters.Text)
	ll_ver_method_ver_ltr = long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('verification method') + "'" + " and upper(code) = '" + upper('verif ltr') + "'"))
	ll_ver_method_corre_ltr = long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('verification method') + "'" + " and upper(code) = '" + upper('prac corre') + "'"))
	ll_ver_method_exp_ltr = long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('verification method') + "'" + " and upper(code) = '" + upper('exp cred ltr') + "'"))
	ll_ver_method_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('verification method') + "'" + " and upper(code) = '" + upper('exp appt ltr') + "'"))
END IF
//End Code Change---10.18.2007

FOR i = 1 TO li_rc
	//debugbreak()
	if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" ) = 1 THEN //maha 082203
		//Start Code Change ---- 10.1.2007 #V7 maha  trap for the following filter, otherwise non letters show up in the print window
		IF ddplb_filters.Text = "PRACTITIONER                  All Action Items For A Practitioner" or ls_filter =  "PRACTITIONER - All Action Items For A Practitioner" THEN
			ll_method =  tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "verification_method" )
			choose case ll_method
				case ll_ver_method_ver_ltr , ll_ver_method_corre_ltr , ll_ver_method_exp_ltr , ll_ver_method_exp_appt_ltr
					//Is a letter
				case else
					//not a letter skip
					continue
			end choose
		end if
		//End Code Change---10.18.2007
		IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "print_flag" ) = 1 THEN
			li_print_cnt++
			//Start Code Change ----07.06.2011 #V11 maha -Process letters
			if lb_ofe then
				lstr_ids.l_ids[Upperbound(lstr_ids.l_ids[]) + 1] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemnumber( i, "rec_id" )
			else //all other letters
			//lstr_ids.s_ids[i] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( i, "doc_id" )
				lstr_ids.s_ids[Upperbound(lstr_ids.s_ids[]) + 1] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( i, "doc_id" ) //Ken.Guo 10/31/2007
			end if
			//End Code Change ----07.06.2011
		END IF
	end if
END FOR

lstr_ids.ls_from_window = "w_action _items" //Start Code Change ----12.08.2008 #V85 maha - pass window name

if ii_facility_id > 0 then //Start Code Change ----03.07.2012 #V12 maha - pass selected facility
	lstr_ids.facility_id = ii_facility_id
else
	lstr_ids.facility_id = 0
end if

IF li_print_cnt > 0 THEN
	OpenWithParm( w_ai_print_letters, lstr_ids )
ELSE
	//MessageBox("Print", "There no selected entries on this view that need to be printed." )
	MessageBox("Print", "There are no selected entries on this view that need to be printed." )//Modified by Appeon long.zhang 12.16.2014
	Return
END IF
// end code change --- 11.14.2005 MSKINNER
end event

event pfc_cst_goto_web();//inv_printletters.of_connecttoweb( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString(+& 
//tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow(), "web_address") )

Integer li_cr
gs_pass_ids ls_pass_ids
String ls_web_address
String ls_web_title
Long ll_verification_id

//Start Code Change ---- 03.12.2007 #V7 maha all web functionality moved to crawler window
// of_get_app_setting("web_crawl","I") = 1 then
	of_web_crawl( )
//	return
//end if

//li_cr = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow( )
//
//ll_verification_id = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "address_lookup_code")
//
//ls_web_address = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "web_address")
//
////Start Code Change ---- 03.03.2006 #314 maha
//IF len(ls_web_address ) < 1 THEN
//	MessageBox("Invalid WEB Address", "There is no web address setup in the lookup table for the selected entity." )
//	Return
//END IF
////End Code Change---03.03.2006
//
//ls_pass_ids.ls_doc_id = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "doc_id" )
//ls_pass_ids.ls_ref_value = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "reference_value" )
//ls_pass_ids.ls_from_window = "Action_Items"
//ls_pass_ids.ll_verification_id = ll_verification_id
//IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "verification_picture_flag" ) = 1 THEN
//	ls_pass_ids.ls_image_available = True
//ELSE
//	ls_pass_ids.ls_image_available = False
//END IF
//
//if of_get_app_setting("set_13","I") = 1 then //line added maha 122205
//	IF Not IsValid( w_capture ) THEN
//		OpenWithParm( w_capture,  ls_pass_ids )
//	ELSE
//		w_capture.of_setup( ls_pass_ids )
//	END IF
//end if
//
//pfc_n_cst_ai_printletters lnv_printletters
//
//lnv_printletters = CREATE pfc_n_cst_ai_printletters
//
//lnv_printletters.of_connecttoweb( ls_web_address )
//
//DESTROY lnv_printletters
//
//End Code Change---03.12.2007








end event

event pfc_cst_edit;tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetItem( +&
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow(), "selected", 1) 

end event

event pfc_cst_dial_phone;inv_printletters.of_dialphone( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString(+& 
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow(), "phone") )
end event

event pfc_cst_refresh();//Start Code Change ----04.22.2008 #V8 maha - corrected refresh bug; simplifed code
Integer li_index
datawindow ldw_graph 
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08/22/2007 By: Ken.Guo
//$<reason> Refresh Other Tabpages Data
li_index = Tab_1.Selectedtab
This.Tab_1.Trigger Event SelectionChanged(li_index,li_index)
//---------------------------- APPEON END ----------------------------

IF li_index <> 1 THEN RETURN //BugL083102 - Alfee 09.06.2011

CHOOSE CASE tab_1.tabpage_analysis.tab_analysis.SelectedTab

	CASE 1 //verification status
		debugbreak()
		ldw_graph = tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph
	CASE 2 //total attempts
		ldw_graph =  tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts
	CASE 3 //expiring credentials
		ldw_graph =  tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph
	CASE 4//expiring appointments	
		ldw_graph =  tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph
	CASE 5
		ldw_graph = tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph
	CASE 6
		ldw_graph = tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph
END CHOOSE

inv_action_items.of_filter_graph( ii_facility_id, ldw_graph, is_user_id )
of_filter_by_intellibatch( ldw_graph)
//End Code Change---04.22.2008

end event

event pfc_cst_npdb_export();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_cst_npdb_export
//==================================================================================================================
//  Purpose   	: CONTROL FUNCTION TO SEND FOR THE NPDB MENTHOD (IPT OR QPRAC)
//==================================================================================================================
//  Arguments 	: [NONE] 
//==================================================================================================================
//  Returns   	: [NONE]     
//==================================================================================================================
//  Notes     	: Changes here must be made to pfc_u_varification_info :: pfc_cst_npdb_export as well
//==================================================================================================================
//  Created By	: ???
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                   Reason
// ------------------------------------------------------------------------------------------------------------------
// MSKINNER 					07 Feb 2005                    Added modification for NPDB IPT interface
//																			 added case statement
//																			 Added calls to of_start_npdb
// MSKINNER                15 March 2005                  added code to open w_npdb_reports
// MSKINNER						18 MARCH 2005						 Moved the new npdb locic to a user object
// MSKINNER 					04 March 2004						 We are now passing the datawindow, to be used as a doc_id source
// mskinner                07 mARCH 2006                  aDDED lnvo = create n_cst_npdb_control 
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CONSTANT LONG ITP_INTERFACE  = 1 // USED FOR READ-ABILITY
CONSTANT LONG QRXS_INTERFACE = 2
//not coded to use checkboxes


integer li_8
integer ck
long i //maha 05.05.08
long cnt //maha05.05.08
u_dw ldw_data

ldw_data = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

li_8 = of_get_app_setting("set_8","I")

CHOOSE CASE li_8
	CASE ITP_INTERFACE, QRXS_INTERFACE //Evan 12.29.2009 -- add QRXS_INTERFACE (V10.1 - NPDB QRXS)
		n_cst_npdb_control lnvo
		lnvo = CREATE n_cst_npdb_control
		lnvo.ib_do_not_open = true
		
		if ddplb_filters.text = "                                             NPDB Queries Previously Exported"  or ddplb_filters.text = "NPDB - NPDB Queries To Previously Exported" then
			message.doubleparm = 1 //RECIEVE
			

		elseif ddplb_filters.text = "NPDB                                   NPDB Queries To Be Exported" or ddplb_filters.text = "NPDB - NPDB Queries To Be Exported" then //send
			for i = 1 to ldw_data.rowcount( )
				if ldw_data.getitemnumber(i,"selected") = 1 then
					if ldw_data.getitemnumber(i,"number_sent") >0 then
						cnt++
					end if
				end if
			next
			if cnt > 0 then
				ck = MessageBox("NPDB",  string(cnt ) + " of the records selected have previously been exported and may be files received with errors.    Do you wish to resend these files to the NPDB?",question!,yesno!,2 )
				if ck = 2 then
					Return
				else
					message.doubleparm = 2  //SEND
				end if
			else
				message.doubleparm = 2  //SEND
			end if
		else
			messagebox("Program Error","This filter will not run the npdb export")
			openwithparm(w_sql_msg,ddplb_filters.text)
		end if

//run the function	
		lnvo.of_run_npdb(ldw_data)

		if IsValid(lnvo) then Destroy lnvo
		
		inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )

	CASE ELSE
    		ck = inv_action_items.of_npdb_export_old(ldw_data,ii_facility_id,"A" )
		//open browser to npdb website
		if ck >= 0 then //Start Code Change ---- 04.12.2007 #V7 maha changed from ck > 0 to correct bug
			//String ls_url = "http://www.npdb-hipdb.hrsa.gov/"//Start Code Change ----10.03.2006 #637 maha
			String ls_url = "https://www.npdb-hipdb.hrsa.gov/" //Add by Evan 08.25.2011
			//String ls_url = "http://www.npdb-hipdb.com"
			inet iinet_base 
			GetContextService("Internet", iinet_base)
			if gi_citrix = 1 then
				of_open_web(ls_url)
			else
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 06.23.2006 By: Liang QingShi
				//$<reason>  GetContextService is currently unsupported. 
				//$<modification> Replace GetContextService with ShellExecuteA to provide the
				//$<modification> same functionality.
				/*
				GetContextService("Internet", iinet_base)
				iinet_base.HyperlinkToURL(ls_url)
				*/
				String ls_null
				setnull(ls_null)
				//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
				//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
				ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
				//---------End Modfiied ------------------------------------------------------
				//---------------------------- APPEON END ----------------------------
			end if
		end if
END CHOOSE

end event

event pfc_cst_print_report();
CHOOSE CASE tab_1.SelectedTab
	CASE 1
		//\/maha 021501 to print all graphs
		choose case tab_1.tabpage_analysis.tab_analysis.selectedtab 
			case 1
				tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.Print()
			case 2
				tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.Print()
			case 3
				tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.Print()
			case 4
				tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.Print()
		end choose
		//\maha 
	CASE 2
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Print()
	CASE 3
		IF tab_1.tabpage_ready.tab_ready.SelectedTab = 1 THEN
			tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Print()
		ELSE
			tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Print()
		END IF
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 08/21/2007 By: Ken.Guo
	//$<reason> Fxied BugA081403: Added for Printing dw data 
	Case 4
		If tab_1.tabpage_net_dev.uo_net_dev.tab_1.selectedtab = 1 Then	
			tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.Print()
		Else
			tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.dw_report_data.Print()		
		End If
	Case 5
		If tab_1.tabpage_contract.uo_1.tab_1.Selectedtab = 1 Then
			tab_1.tabpage_contract.uo_1.tab_1.tabpage_1.dw_1.Print()
		Else
			tab_1.tabpage_contract.uo_1.tab_1.tabpage_2.dw_details.Print()
		End If
	Case 6
		If tab_1.tabpage_document_manager.tab_1.Selectedtab = 1 Then
			tab_1.tabpage_document_manager.tab_1.tabpage_1.dw_1.Print()
		Else
			tab_1.tabpage_document_manager.tab_1.tabpage_2.dw_details.Print()
		End If
	//---------------------------- APPEON END ----------------------------
END CHOOSE
end event

event pfc_cst_print_net_dev_ltr;tab_1.tabpage_net_dev.uo_net_dev.Event pfc_cst_print_net_dev_ltr()
end event

event pfc_cst_print_net_dev_report;tab_1.tabpage_net_dev.uo_net_dev.Event pfc_cst_print_net_dev_report()
end event

event pfc_cst_iverify();//gs_pass_ids gs_passed_parms
//
//
//gs_passed_parms.prac_id = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getrow ( ), "prac_id" )
//gs_passed_parms.s_ids[1] = "Old"
//gs_passed_parms.s_stringval = "Action_Items"
//gs_passed_parms.i_facility_ids[1] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getrow ( ), "parent_facility_id" )
//gs_passed_parms.i_facility_ids[2] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getrow ( ), "verifying_facility" )
//
//OpenWithParm( w_iverify_summary, gs_passed_parms )
//
//Return 0
end event

event pfc_cst_net_dev_filter;
IF tab_1.SelectedTab = 4 THEN
	tab_1.tabpage_net_dev.uo_net_dev.Event pfc_cst_net_dev_filter()
END IF
end event

event pfc_cst_scan_oig();long ll_oig
long pracids[]
string docids[]
integer i
integer ic
string ls_filter
string ls_type
string ls_parm
integer ifirst
integer ilast
integer idob
integer praccnt

if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount() < 1 then return

for i = 1 to tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount()
	if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"selected") = 1 then //maha 082203
   	pracids[i] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"prac_id")
	   docids[i] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemstring(i,"doc_id")
		praccnt++
	end if
next

if praccnt < 1 then //maha 082203
	messagebox("None Selected","There are no records selected.")
	return 
end if
//manual or automatic
//if automatic get search parameters
open(w_oig_type)
ls_type = message.stringparm


if ls_type = "A" then
	ls_parm = 'VAA'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<add> 02.20.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	select oig_auto_fname into :ifirst from facility;
	select oig_auto_lname into :ilast from facility;
	select oig_auto_dob into :idob from facility;

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<add> 02.20.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
	
	if ifirst <> 1 and ilast <> 1 and idob <> 1 then
		messagebox("Auto OIG","There are no selection parameters for Auto selection of OIG for this facility.")
		return
	end if
elseif ls_type = "M" then
	ls_parm = 'VMA'
else
	return
end if


openwithparm(w_oig_on_demand,ls_parm)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.20.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//$<modification> Fix the original code bug.
/*
w_oig_on_demand.dw_prac_list.retrieve(pracids[])
w_oig_on_demand.dw_verifs.retrieve(docids[])

if ls_type = "A" then
	w_oig_on_demand.of_scan_oig_data("A",ilast,ifirst,idob,"S")
end if
*/
If isvalid(w_oig_on_demand) Then
	gnv_appeondb.of_startqueue( )
	
	w_oig_on_demand.dw_prac_list.retrieve(pracids[])
	w_oig_on_demand.dw_verifs.retrieve(docids[])
	
	gnv_appeondb.of_commitqueue( )
	
	if ls_type = "A" then
		w_oig_on_demand.of_scan_oig_data("A",ilast,ifirst,idob,"S", 0) 
	end if
End if
//---------------------------- APPEON END ----------------------------

//inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
end event

event pfc_cst_intellibatch_filter;//maha 071403

string f
gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
string ls_openstring
string ls_pracs

ls_openstring = "R"

openwithparm(w_batch_prac_select_new,ls_openstring)


if message.stringparm = "Cancel" then
	return
else 
	lst_search = message.powerobjectparm
	
	pracids[] = lst_search.li_prac_id[]
	names[] = lst_search.ls_name[]
	ic = upperbound(pracids[]) 
	
	if ic > 0 then
		ls_pracs = " prac_id in ("
		
		for i = 1 to ic
			ls_pracs = ls_pracs + string(pracids[i])
			if i < ic then ls_pracs = ls_pracs  + ","
		next 
		ls_pracs = ls_pracs  + ")"
	end if
	
	is_batch_filter = ls_pracs
end if
gs_fil_batch = ""
of_filter_by_intellibatch(tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse)
//tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.setfilter(ls_pracs)
//tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.filter()
end event

event pfc_cst_missing_info();//maha created 08-03

if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject  <> "d_app_audit_missing_ai" then
	messagebox("Information","You can only run this function with the App Audit filter")
	return
end if



Long ll_prac_ids[]
Long ll_rec
Long ll_rec_ids[]
Integer li_org_ids[]
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility_ids[]
Long li_facility_ids[]
//---------End Modfiied ------------------------------------------------------
integer li_ir_set
long rc
long r
long a
long ac = 0
integer ck = 0
string ls_ir

//li_ir_set = of_get_app_setting("set_???", "I")

//Start Code Change ----06.20.2011 #V11 maha - modified to reflect change in browse data to single record - as well as correct issue with selected items
//for r = 1 to tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.rowcount()
//	ck = 0
//	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.AcceptText()
//
//	ll_rec = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "appt_stat_id" )
//	for a = 1 to upperbound(ll_rec_ids[])
//		if ll_rec_ids[a] = ll_rec then  //based on rec_id get distinct records
//			ck = 1
//			continue
//		end if
//	next
//	if ck = 1 then
//		continue
//	else
//		ac++
//		ll_rec_ids[ac] = ll_rec
//		li_facility_ids[ac] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "facility_id" )
//		ll_prac_ids[ac] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "prac_id" )
//		//is_app_type = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( r, "app_type" )
//	
//	//tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Update()
//	//dw_detail.Retrieve( li_rec_ids[1] 
//	end if
//next

for r = 1 to tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.rowcount()
	if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "selected" ) = 1 then
		ll_rec = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "appt_stat_id" )
		ac++
		ll_rec_ids[ac] = ll_rec
		li_facility_ids[ac] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "facility_id" )
		ll_prac_ids[ac] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( r, "prac_id" )
	end if
next
//End Code Change ----06.20.2011

ck = upperbound(ll_rec_ids[])
//messagebox("count",ck)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replace the visual object with a non-visual object.
//pfc_cst_u_generate_miss_info_rqst lnvo_letter
//
//lnvo_letter = create pfc_cst_u_generate_miss_info_rqst
pfc_cst_u_generate_miss_info_rqst_apb lnvo_letter

lnvo_letter = create pfc_cst_u_generate_miss_info_rqst_apb

//---------------------------- APPEON END ----------------------------

lnvo_letter.of_generate_miss_info_letter( li_facility_ids, ll_prac_ids, ll_rec_ids, tab_1.tabpage_detail.dw_tracker )

DESTROY lnvo_letter
end event

event pfc_cst_batch_response();//created 072503 maha

if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject  = "d_app_audit_missing_ai" then
	//messagebox("parm","A")
	openwithparm(w_ai_update_values,"A")
else
	openwithparm(w_ai_update_values,"V")
	//messagebox("parm","V")
end if

this.triggerevent("pfc_save")
end event

event pfc_cst_addtl_filters();//------------------- APPEON BEGIN -------------------
//$<delete> Michael 10.25.2011
//$<reason> V12.1 Migrate AI addtl filters
/*
open(w_additional_filters_ai)

if message.stringparm = "Cancel" then
	return
else
*/
//------------------- APPEON END ---------------------
	CHOOSE CASE tab_1.SelectedTab
		CASE 1
			CHOOSE CASE tab_1.tabpage_analysis.tab_analysis.SelectedTab
				//verification status
				CASE 1
					of_filter_by_intellibatch( tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph )
				CASE 2 //add by Michael 10.28.2011 total attempts
					of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts)
				//expiring credentials
				CASE 3
					of_filter_by_intellibatch( tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph)
				//expiring appointments	
				CASE 4
					of_filter_by_intellibatch( tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph)
				CASE 5
					of_filter_by_intellibatch( tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph )
				CASE 6// add Michael 10.26.2011 process tracking
					of_filter_by_intellibatch( tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph )
			END CHOOSE
		//action item detail tab
		CASE 2
			//inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse)	
			of_filter_by_intellibatch(tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse)
		CASE 3
			of_get_ready_for_committee()
			of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready)
			of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm)
		CASE 4
			//tab_1.tabpage_net_dev.uo_net_dev.of_Retrieve_Detail( ii_facility_id )
		//	of_filter_by_intellibatch(tab_1.tabpage_net_dev.tabpage_browse.dw_browse)
	END CHOOSE
	//of_filter_by_intellibatch(tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse)
/*end if*///delete Michael 10.25.2011 V12.1 Migrate AI addtl filters
end event

event pfc_cst_capture_image;
gs_pass_ids ls_pass_ids
Integer li_cr	
	
li_cr = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow( )

If li_cr > 0 Then
	ls_pass_ids.ls_doc_id = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "doc_id" )
	ls_pass_ids.ls_ref_value = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "reference_value" )
	ls_pass_ids.ls_from_window = "Action_Items"
	IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "verification_picture_flag" ) = 1 THEN
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF
End If

IF Not IsValid( w_capture ) THEN
	OpenWithParm( w_capture,  ls_pass_ids )
ELSE
	w_capture.of_setup( ls_pass_ids )
END IF
end event

event se_post_event;tab_1.SelectTab(2)
end event

event ue_postupdate();//////////////////////////////////////////////////////////////////////
// $<event>w_sheetue_postupdate()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.05.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

Integer i
Integer li_rc
Integer li_cnt
DateTime ldt_todaysDate
datastore ds_ver
integer li_vfacil
integer fac
integer cnt
integer ck = 0
integer li_j //(Appeon)Stephen 11.05.2013 - Bug 3727 Select Update Questions

//maha 10.02.08 note: ii_facility_ids, il_prac_ids[] are created in dw_browse,pfc_preupdate and are a list of distinct prac and facility for the list of verifications in dw_browse
li_rc = UpperBound( ii_facility_ids  )
IF li_rc <=0 THEN RETURN

ds_ver = create datastore
//ds_ver.dataobject = "d_ai_appt_stat_4_verif_compl"
ds_ver.dataobject = "d_ai_appt_stat_4_verif_compl_forpt"
ds_ver.settransobject(sqlca)

Datastore lds_verif_info
lds_verif_info = create datastore
lds_verif_info.dataobject = "d_verif_info_forpt"
lds_verif_info.settransobject(sqlca)

Datastore lds_affil_stat
lds_affil_stat = create datastore
lds_affil_stat.dataobject = "d_pd_affil_stat_forpt1"
lds_affil_stat.settransobject(sqlca)

Datastore lds_app_audit
lds_app_audit = create datastore
lds_app_audit.dataobject = "d_app_audit_forpt"
lds_app_audit.settransobject(sqlca)

gnv_appeondb.of_startqueue()
//Start Code Change ----01.02.2008 #V8 maha  -- changed code below to reflect appropriate functionality based on dw_browse data object
//lds_verif_info.Retrieve(ii_facility_ids[], il_prac_ids[])  //Start Code Change ----01.02.2008 #V8 maha moved below
lds_affil_stat.Retrieve(ii_facility_ids[], il_prac_ids[])
//lds_app_audit.Retrieve(ii_facility_ids[], il_prac_ids[]) //Start Code Change ----01.02.2008 #V8 maha moved below

gnv_appeondb.of_commitqueue()

Integer li_vfacil_arr[]

ldt_todaysdate = DateTime( Today(), Now() )

IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject  <> "d_app_audit_missing_ai" then //all verif infos 
	lds_verif_info.Retrieve(ii_facility_ids[], il_prac_ids[])
	FOR i = 1 TO li_rc
		fac = ii_facility_ids[i]
		
		if ii_screen_ids[i] = 1 then //if a screen 1 verification get the verifying facility for that parent id
	//		SELECT pd_affil_stat.verifying_facility  
	//		INTO :li_vfacil 
	//		FROM pd_affil_stat  
	//		WHERE ( pd_affil_stat.parent_facility_id = :ii_facility_ids[i] ) AND  
	//				( pd_affil_stat.prac_id = :il_prac_ids[i] ) and				
	//				( pd_affil_stat.active_status in (1,4));
			li_cnt = lds_affil_stat.Find("parent_facility_id = " + string(ii_facility_ids[i]) + " and prac_id = " + String(il_prac_ids[i]), 1, lds_affil_stat.rowcount())
			If li_cnt > 0 Then li_vfacil = lds_affil_stat.GetitemNumber(li_cnt, "verifying_facility")
		else
			li_vfacil = fac
		end if
	
		li_vfacil_arr[i] = li_vfacil
	END FOR

	ds_ver.retrieve(il_prac_ids[], li_vfacil_arr[])
	
	ldt_todaysdate = DateTime( Today(), Now() )
	
	gnv_appeondb.of_startqueue()
	
	FOR i = 1 TO li_rc
		//$<reason> inv_action_items.of_is_last_verif( ii_facility_ids[ i ], il_prac_ids[ i ] ,ii_screen_ids[i])
		//$<reason> The following script is a copy from of_is_last_verif function in the pfc_n_cst_ai_action_items userobject
		fac = ii_facility_ids[i]
		
		if li_vfacil_arr[i] = ii_facility_ids[i] then ck = 1 //if parent and ver are the same then skip some work later down
		
		//cnt = ds_ver.retrieve(il_prac_ids[i],li_vfacil)
		ds_ver.Setfilter("prac_id = " + String(il_prac_ids[i]) + " And verifying_facility = " + String(li_vfacil) )
		ds_ver.Filter( )
		cnt = ds_ver.Rowcount( )
		
		IF cnt >= 0 THEN
			li_cnt = lds_verif_info.Find("facility_id = " + string(li_vfacil) + " and prac_id = " + String(il_prac_ids[i]) + " and active_status = 1", 1, lds_verif_info.rowcount())
			IF li_cnt = 0 THEN 
				if cnt > 0 then //redundant trap
					if ck = 1 then  //parent and verif are different
						for li_j = 1 to cnt //test for npdb,oig etc.   //(Appeon)Stephen 11.05.2013 -modify 'i' to 'li_j' Bug 3727 Select Update Questions
							fac = ds_ver.getitemnumber(li_j,"parent_facility_id") //(Appeon)Stephen 11.05.2013 -modify 'i' to 'li_j' Bug 3727 Select Update Questions

							li_cnt = lds_verif_info.Find("facility_id = " + string(fac) + " and prac_id = " + String(il_prac_ids[i]) , 1, lds_verif_info.rowcount())
							if li_cnt = 0 then
								ds_ver.setitem(li_j,"date_verif_completed",ldt_todaysDate) //(Appeon)Stephen 11.05.2013 -modify 'i' to 'li_j' Bug 3727 Select Update Questions
							end if
						next
					else //same parent and ver facility;  should normally be 1
						for li_j = 1 to cnt //already tested for verification above so just set date  //(Appeon)Stephen 11.05.2013 -modify 'i' to 'li_j' Bug 3727 Select Update Questions
							ds_ver.setitem(li_j,"date_verif_completed",ldt_todaysDate)  //(Appeon)Stephen 11.05.2013 -modify 'i' to 'li_j' Bug 3727 Select Update Questions
						next
					end if
				END IF
				ds_ver.update()
				COMMIT USING SQLCA;
			END IF
		END IF
	NEXT
	
ELSE //app audit missing dw -- check for app audit complete
//Start Code Change ----09.22.2010 #V10 maha - moved from dw_browse pfc_postupdate
//	lds_app_audit.Retrieve(ii_facility_ids[], il_prac_ids[])
//
//	//$<reason> inv_action_items.of_is_app_audit_compl( il_prac_ids[ i ],ii_facility_ids[ i ] )
//	FOR i = 1 TO li_rc
//		li_cnt = lds_affil_stat.Find("parent_facility_id = " + string(ii_facility_ids[i]) + " and prac_id = " + String(il_prac_ids[i])+ " and isnull(date_app_audit_completed)", 1, lds_affil_stat.rowcount())
//
//		if li_cnt > 0 then //if not check for incomplete app audits
//
//			li_cnt = lds_app_audit.Find("facility_id = " + string(ii_facility_ids[i]) + " and prac_id = " + String(il_prac_ids[i]) + " and isnull(date_app_audit_completed)", 1, lds_app_audit.rowcount())
//	
//			IF li_cnt = 0 THEN //if none set date
//				UPDATE pd_affil_stat  
//				SET date_app_audit_completed = :ldt_todaysDate  
//				WHERE ( pd_affil_stat.parent_facility_id = :ii_facility_ids[ i ] ) AND  
//						( pd_affil_stat.active_status in ( 1,4 ) ) AND
//						( pd_affil_stat.prac_id = :il_prac_ids[ i ] ) and
//						( pd_affil_stat.date_app_audit_completed is NULL );	
//				COMMIT USING SQLCA;
//			END IF
//		END IF
//	NEXT
	long ll_pracs[]
	long ll_recs[]
	long ll_comp[]
	long ll_prac_id
	long ll_rec_id
	long r
	long ll_i
	integer li_test = 0
	datetime ldt_date
	datawindow ldw_verif
	
	ldw_verif =  tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

	for ll_i = 1 to ldw_verif.rowcount()
		li_test = 0
		ll_prac_id = ldw_verif.getitemnumber(ll_i,"prac_id")
		ll_rec_id = ldw_verif.getitemnumber(ll_i,"appt_stat_id")
		ldt_date =  ldw_verif.getitemdatetime(ll_i,"date_completed")
		for r = 1 to upperbound(ll_pracs[])
			if ll_prac_id = ll_pracs[r] then
				if ll_rec_id = ll_recs[r] then
					li_test = r //if found set r for checking compl
					continue
				end if
			end if
		next
		if li_test = 0 then //if you dont find the prac and rec add a new to array
			cnt = upperbound(ll_pracs[])
			cnt++
			ll_pracs[cnt] = ll_prac_id
			ll_recs[cnt] = ll_rec_id
			if isnull(ldt_date) then //set the complete value
				ll_comp[cnt] = 0
			else
				ll_comp[cnt] = 1
			end if
		else //found prac and rec check complete
			if ll_comp[li_test] = 0 then //is already set as incomplete skip
				continue
			else //if set as completed
				if isnull(ldt_date) then ll_comp[cnt] = 0 //set as incomplete 
			end if
		end if 			
	next
	//call function to set comple date 
	inv_action_items.of_app_audit_complete( ll_pracs[],ll_recs[], ll_comp[])
END IF

gnv_appeondb.of_commitqueue()

DESTROY ds_ver

end event

event pfc_cst_batch_recredential();//Start Code Change ----06.10.2008 #V81 maha - for batch recred function
of_batch_recred( )
end event

event pfc_cst_clear_print();of_clear_print()

this.triggerevent("pfc_save")
end event

event pfc_cst_batch_update();tab_1.tabpage_net_dev.uo_net_dev.of_batch_update_actions()	//long.zhang 06.18.2012 v12.2 app batch update
end event

event pfc_email_payor();//====================================================================
//$<Event>: pfc_Email_Payor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.21.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
tab_1.tabpage_net_dev.uo_net_dev.of_email_payor(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev, 'Action') 
if tab_1.selectedtab = 4 then w_mdi.of_menu_shrink_action_items( ) 

end event

event pfc_cst_print_apps_from_pf();//====================================================================
//$<Event>: pfc_cst_print_apps_from_pf
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.28.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Open( w_IntelliApp_Print )

w_IntelliApp_Print.uo_print.of_app_print_action( tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev )
if tab_1.selectedtab = 4 then w_mdi.of_menu_shrink_action_items( ) 
ib_dev_net_print = true
end event

event pfc_cst_ama_api();//Start Code Change ----06.01.2016 #V152 maha - added 
of_ama_api()
end event

public function integer of_get_ready_for_committee ();DataWindowChild dwchild
Integer li_rc
Integer i
Integer li_found

IF ii_facility_id = 0 THEN
	dw_select_org_facility.GetChild( "facility_id", dwchild )
	li_rc = dwchild.RowCount()
	FOR i = 2 TO li_rc
		ii_facility_ids_all[i] = dwchild.GetItemNumber( i, "facility_id" )
	END FOR
	tab_1.tabpage_ready.dw_committee.GetChild( "credentialing_committee", dwchild )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-05-04 By: Liu Hongxin
	//$<reason> Fix a defect.
	/*
	dwchild.SetFilter( "" )
	*/
	dwchild.SetFilter( "committee_name <> 'All' ")	
	//---------------------------- APPEON END ----------------------------

	dwchild.Filter( )
ELSE
	ii_facility_ids_all[1] = ii_facility_id
	tab_1.tabpage_ready.dw_committee.GetChild( "credentialing_committee", dwchild )	
	dwchild.SetFilter( "facility_id = " + String(ii_facility_id ))
	dwchild.Filter( )
END IF

li_found = dwchild.Find( "committee_name = 'All'" , 1,100)
IF li_found < 1 THEN
	dwchild.InsertRow(1)
	dwchild.SetItem( 1, "committee_id", 0 )
	dwchild.SetItem( 1, "committee_name", "All" )
END IF

tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Event pfc_retrieve()
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()

RETURN 0
end function

public function integer of_filter_by_intellibatch (datawindow adw_dw);//maha 072303
string ls_filter
string ls_facil_user_filter = ""
string ls_facil_field //maha 08.22.2011
integer li_use_f_u = 0
integer c, r

//----------------------------- <RP> modified 4.21.2016-----------------------------------------------------
//-- In certain cases, don't perform the actual filter. The DW will be retrieved with arguments.
boolean lb_filter = TRUE
//----------------------------------------------------------------------------------------------------------------

//messagebox("is_batch_filter",is_batch_filter)
adw_dw.setredraw(false)
CHOOSE CASE tab_1.SelectedTab
	//analysis graphs
	CASE 1
		c = tab_1.tabpage_analysis.tab_analysis.SelectedTab
		//messagebox("",c)
		CHOOSE CASE c
//Start Code Change ----08.22.2011 #V11 maha - modifed to use facility filter name field
			//verification status
			CASE 1
				is_addtl_filter = of_addtl_filter(1)
				ls_facil_field = "parent_facility_id"
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 05.04.2016
				//<$>reason:add gs_cust_type, For V15.1 IntelliApp Bug # 5128 - Action Items: Analysis -> Application Status tab is displaying Verification Status
//				//----------------------------- <RP> 4.21.2016-------------
//				if gs_dbtype = "SQL" then 	lb_filter = FALSE
//				//--------------------------------------------------------------						
				If Not( gs_dbtype = "ASA" or gs_cust_type = "I" ) then lb_filter = False
				//------------------- APPEON END -------------------
			CASE 2
				is_addtl_filter = of_addtl_filter(2)
				if gs_dbtype = "SQL" then ls_facil_field = "parent_facility_id"
				//----------------------------- <RP> 4.22.2016-------------
				lb_filter = FALSE
				//--------------------------------------------------------------
				//expiring credentials
			CASE 3
				is_addtl_filter = of_addtl_filter(3)
				ls_facil_field = "parent_facility_id"
			//expiring appointments	
			CASE 4
				is_addtl_filter = of_addtl_filter(4)
				ls_facil_field = "parent_facility_id"
			CASE 5
				is_addtl_filter = of_addtl_filter(5)
				ls_facil_field = "facility_id"
			//process steps
			CASE 6
				is_addtl_filter = of_addtl_filter(6)
				ls_facil_field = "facility_id"
		END CHOOSE
//		debugbreak()
		//because facility and user are filtered after the retrieve for graphs (the others are part of the retrieval query)
		IF is_user_id = "All" AND ii_facility_id <> 0 THEN
			ls_facil_user_filter = ls_facil_field + " = " + String( ii_facility_id ) 
		ELSEIF ii_facility_id = 0 AND is_user_id <> "All" THEN
			ls_facil_user_filter = "priority_user = '" + is_user_id + "'" 
		ELSEIF is_user_id <> "All" AND ii_facility_id <> 0 THEN
			ls_facil_user_filter = ls_facil_field + " = " + String( ii_facility_id ) + " AND priority_user = '" + is_user_id + "'" 
		ELSE
			ls_facil_user_filter = ""
		END IF
		li_use_f_u = 1
	
	CASE 2  //action item detail tab
		is_addtl_filter = of_addtl_filter(20)
		
	CASE 3  //ready for committee
		is_addtl_filter = of_addtl_filter(30)
		
	CASE 4  //net dev
		is_addtl_filter = of_addtl_filter(40)
END CHOOSE


if is_addtl_filter = "NONE" then
	ls_filter = ""
else
	if len(is_addtl_filter) > 0 and len(is_batch_filter) > 0 then//if both in use then add 'and'
	  ls_filter = is_addtl_filter + " and " +  is_batch_filter
	else
		ls_filter = is_addtl_filter + is_batch_filter
	end if
end if

//this will only change the filter for a graph
if li_use_f_u = 1 then
	
	//messagebox("","graph filter")
	if len(ls_filter) > 0 and len(ls_facil_user_filter) > 0 then//if both in use then add 'and'
	  ls_filter = ls_filter + " and " +  ls_facil_user_filter
	else
		ls_filter = ls_filter + ls_facil_user_filter
	end if
end if

//------------------- APPEON BEGIN -------------------
//$<add> Michael 10.26.2011
//$<reason> V12.1 Migrate AI addtl filters
n_cst_string_appeon ln_cst_string_appeon
if  tab_1.SelectedTab = 1 and tab_1.tabpage_analysis.tab_analysis.SelectedTab = 6 then
	ls_filter = ln_cst_string_appeon.of_globalreplace(ls_filter, 'prac_id', 'pd_process_actions_prac_id')
end if
//------------------- APPEON END -------------------
//debugbreak()
//messagebox("",ls_filter)

//----------------------------- <RP> modified 4.21.2016-----------------------------------------------------
//-- In certain cases, don't perform the actual filter. The DW will be retrieved with arguments.
IF lb_filter THEN
	r = adw_dw.rowcount()
	c = adw_dw.setfilter(ls_filter)
	if c < 1 then messagebox("Bad filter",ls_filter)
	adw_dw.filter()
	r = adw_dw.rowcount()
END IF
//-----------------------------------------------------------------------------------------------------------------
adw_dw.setredraw(true) 

 is_combined_filters = ls_filter  //Start Code Change ----12.05.2008 #V85 maha
 of_enable_action_buttons( )  //Start Code Change ----02.16.2016 #V15 maha

return 1
end function

public function string of_get_filter (string as_type);//function created 073003 maha called by of_addtl_filters

string ls_filt

choose case as_type
	case "S"
		ls_filt = is_screen_filter
	case "I"
		ls_filt = is_ir_filter
	case "B"
		//Start Code Change ----09.13.2011 #V12 maha - modify to allow both to work (for the first time)
		if len(is_screen_filter) = 0 and len(is_ir_filter) = 0 then
			ls_filt = ""
		elseif len(is_screen_filter) = 0 then
			ls_filt = is_ir_filter
		elseif len(is_ir_filter) = 0 then
			ls_filt = is_screen_filter
		else //both
			ls_filt = is_screen_filter + " AND " + is_ir_filter
		end if
		//End Code Change ----09.13.2011
	case "N"
		ls_filt = ""	
	case "U"
		ls_filt = "NONE"	
	case else
		ls_filt = ""
end choose

//Start Code Change ----11.09.2012 #V12 maha
if ib_clist_filter = true and cbx_checklist.checked and cbx_checklist.visible = true then
	if len( ls_filt)  > 0 then ls_filt+= " AND"
	ls_filt+= "  (not isnull( pd_affil_stat_date_app_audit_completed )) "
end if
//Start Code Change ----11.09.2012 #V12 maha

return ls_filt

end function

public function string of_addtl_filter (integer ai_for);//function created maha 073003 called from of_intellibatch_filter
string ls_return
string ls_filter
string ls_type

CHOOSE CASE ai_for
	case 1 //verification graph
		if isvalid(w_action_items) then
			ls_type = "S"
		else //trap for intelliapp netdev graph
			ls_type = "U"
		end if
		ib_clist_filter = true //maha 11.09.2012
	case 2
		ls_type = "S"
		ib_clist_filter = false //maha 11.09.2012
	case 3 //exp creds graph
		ls_type = "S"
		ib_clist_filter = true //maha 11.09.2012
	case 4 //exp appts graph
		ls_type = "I"
		ib_clist_filter = true //maha 11.09.2012
	case 5 //app audit graph 
		ls_type = "I"
		ib_clist_filter = false //maha 11.09.2012
	case 6 //add Michael 10.26.2011 process tracking only batch filer
		ls_type = "N"
		ib_clist_filter = true //maha 11.09.2012
	case 20 //browse tab
		ls_filter = ddplb_filters.text
		ib_clist_filter = true //maha 11.09.2012
		//Start Code Change ----09.13.2011 #V12 maha
		IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject = "d_ver_summary_record_view_for_ai" then
			ls_type = "B"
		Else
			CHOOSE CASE ls_filter
				CASE "EXPIRING ELEMENTS        All Expiring Appointments" , "EXPIRING ELEMENTS - All Expiring Appointments"   //Start Code Change ----.12.07.2011 #V12 maha
					ls_type = "I"
				CASE "                                             Exp. Appt. Letters"
					ls_type = "I"
				CASE "RED FLAG                           Verifications In Process 120+"
					ls_type = "S"
				CASE "TO BE PRINTED                 Verifications Letters"
					ls_type = "S"
				CASE "                                             All Letters Needing Reprinted"
					ls_type = "S"
				CASE "                                             Expiration Letters" , "Expiration Letters Needing Printing"
					ls_type = "S"
				CASE "                                             Practitioner Correspondence Letters"
					ls_type = "N"	
				CASE "TO BE PRINTED - All Credential Letters Needing Reprinting" //add Michael 11.01.2011 Fixed a bug:Filter failure
					ls_type = "S"	
				CASE "AWAITING RESPONSE      Verification  Letters"
					ls_type = "S"
				CASE "iVerify                                  Verify using iVerify database"
					ls_type = "S"
				CASE "                                             All Letters Previously Mailed"
					ls_type = "S"
				CASE "                                             Expiration  Letters", "Expiration Letters Awaiting Response"
					ls_type = "S"
				CASE "                                             Practitioner  Correspondence"
					ls_type = "N"
				CASE "                                             Expiring Credential Letters"
					ls_type = "S"
				CASE "                                             Expiring Credential  Letters" //add by appeon:Michael 08.17.2011 Fixed a bug:The additional filters are not working on the "Awaiting Response"
					ls_type = "S"
				CASE "HIGH PRIORITY                 High Priority Action Items"
					ls_type = "N"
				CASE "VERIFICATIONS                  WEB"
					ls_type = "S"
				CASE "                                             CALLS"
					ls_type = "S"
				CASE "                                             COMPENDIUM"
					ls_type = "S"					  
				CASE "EXPIRING CREDENTIALS  Credentials Expiring 61 - 90 Days From Today"
					ls_type = "S"														
				CASE "                                             Expiring Appointments"
					ls_type = "I"
				CASE "                                             All Expiring Credentials"
					ls_type = "S"  					  
				CASE "PRACTITIONER                  All Action Items For A Practitioner", "All Action Items For A Practitioner"
					ls_type = "S"
				CASE "FSMB                                   FSMB Queries To Be Exported"
					ls_type = "N"
				CASE "                                             FSMB Queries Previously Exported"
					ls_type = "N"
				CASE "NPDB                                   NPDB Queries To Be Exported"  //NPDB
					ls_type = "I"
				CASE 	"                                             NPDB Queries Previously Exported"
					ls_type = "I"
				CASE	"MAXED ATTEMPTS           Verification letters at max attempts"
					ls_type = "S"
				CASE	"OIG                                     OIG Queries To Be Scanned"
					ls_type = "I"	
				CASE	"                                           OIG Queries Flagged"
					ls_type = "I"
				CASE	"                                             HARD COPY"
					ls_type = "S"
				CASE	"APPLICATION AUDIT          Missing Items" 
					ls_type = "I"
			//after selected names
				CASE "EXPIRING ELEMENTS        All Expiring Appointments"
					ls_type = "S"
				CASE "TO BE PRINTED - Exp. Appt. Letters"
					ls_type = "I"
				CASE "RED FLAG - Verifications In Process 120+"
					ls_type = "S"
				CASE "TO BE PRINTED - Verifications Letters"
					ls_type = "S"
				CASE "TO BE PRINTED - All Letters Needing Reprinted", "                                             All Credential Letters Needing Reprinting"  //Start Code Change ----.08.222011 #V11 maha  - added for bug correction
					ls_type = "S"
				CASE "TO BE PRINTED - Expiration Letters", "TO BE PRINTED - Expiring Credential Letters"
					ls_type = "S"
				CASE "TO BE PRINTED - Practitioner Correspondence Letters"
					ls_type = "N"				
				CASE "AWAITING RESPONSE - Verification Letters"
					ls_type = "S"
				CASE "Verify using iVerify database"
					ls_type = "S"
				CASE "AWAITING RESPONSE - All Letters Previously Mailed"
					ls_type = "S"
				CASE "AWAITING RESPONSE - Expiration Letters"
					ls_type = "S"
				CASE "AWAITING RESPONSE - Expiring Credential  Letters" //add by appeon:Michael 08.17.2011 Fixed a bug:The additional filters are not working on the "Awaiting Response"
					ls_type = "S"				
				CASE "AWAITING RESPONSE - Practitioner Correspondence"
					ls_type = "N"
				CASE "HIGH PRIORITY - High Priority Action Items"
					ls_type = "S"
				CASE "VERIFICATIONS - WEB"
					ls_type = "S"
				CASE "VERIFICATIONS - CALLS"
					ls_type = "S"
				CASE "VERIFICATIONS - COMPENDIUM"
					ls_type = "S"
				CASE "EXPIRING CREDENTIALS - Credentials Expiring 61 - 90 Days From Today"
					ls_type = "S"				
				CASE "AWAITING RESPONSE - All Expiring Appointments"
					ls_type = "I"
				CASE "EXPIRING CREDENTIALS - All Expiring Credentials"
					ls_type = "S"
				CASE "PRACTITIONER - All Action Items For A Practitioner"
					ls_type = "S"
				CASE "FSMB                                   FSMB Queries To Be Exported"
					ls_type = "N"
				CASE "                                             FSMB Queries Previously Exported"
					ls_type = "N"
				CASE "NPDB - NPDB Queries To Be Exported"
					ls_type = "I"
				CASE 	"NPDB - NPDB Queries To Previously Exported"
					ls_type = "I"
				CASE	"MAXED ATTEMPTS           Verification letters at max attempts"
					ls_type = "S"
				CASE	"OIG - OIG Queries To Be Scanned"
					ls_type = "I"
				CASE	"OIG - OIG Queries Flagged"
					ls_type = "I"
				CASE	"Hard Copy - Hard Copy Verifications"
					ls_type = "S"			
				CASE	"APPLICATION AUDIT  -  Missing Items", "CHECKLIST          Missing Items", "CHECKLIST  -  Missing Items", "Incomplete Checklist Items" //evan 08.05.2011
					ls_type = "I"
				CASE	"Incomplete App Audit Items"
					ls_type = "I"
				CASE	"                                             Exp. Provisional. Letters","TO BE PRINTED - Exp. Provisional Letters"
					ls_type = "I"
				CASE	"                                             Exp. Allied Health Letters", "TO BE PRINTED - Exp. Allied Health Letters"
					ls_type = "I"
				Case "PROCESS ACTIONS LETTERS to be printed", "PROCESS ACTIONS LETTERS awaiting response"
					ls_type = "I"
				Case "" //Start Code Change ----08.22.2011 #V11 maha - trap for blank (TDL)
					ls_type = "N"
				Case "DOC-ID                                Find Document" //Start Code Change ----08.22.2011 #V11 maha - trap for find 
					ls_type = "N"
		//Start Code Change ----12.07.2011 #V12 maha	- added	
				Case "MISS ITEM 90    Checklist Missing Items 90 days To Be Printed"  ,"Checklist Missing Items 90 days To Be Printed" 
					ls_type = "I"
				Case "Checklist Missing Items 90 days Awaiting Response"  ,"                           Checklist Missing Items 90 days Awaiting Response"
					ls_type = "I"	
				Case "VERIFICATIONS                  WEB Crawler Processed"  ,  "VERIFICATIONS - WEB Crawler Processed"
					ls_type = "S"
		//End Code Change ----12.07.2011 
		//Start Code Change ----06.01.2016 #V152 maha
				Case "AMA API"
					ls_type = "S"
		//End Code Change ----06.01.2016
				Case  "Other - No Functionality"  //Start Code Change ----11.01.2017 #V16 maha
					ls_type = "S"
				CASE ELSE
					messagebox("Filter failure in of_addtl_filter",ls_filter)
					ls_type = "N"
			END CHOOSE
		End If
	CASE 30 //ready for committee
		ls_type = "I"
		ib_clist_filter = false //maha 11.09.2012
	CASE 40 //net dev
		ls_type = "U"
		ib_clist_filter = false //maha 11.09.2012
	case else
		ls_return = ""
		ib_clist_filter = false //maha 11.09.2012
end choose


//if ii_facility_id > 0 then //Start Code Change ----01.23.2013 #V12 maha - allow the checklist filter only if facility selected.
if ii_facility_id > 0 and ib_clist_filter = true then //Start Code Change ----07.07.2015 #V15 maha - don't set true if already set false
	ib_clist_filter = true
else
	ib_clist_filter = false
end if


ls_return = of_get_filter(ls_type)
//messagebox("Filter",ls_return)
of_filter_lights(ls_type)
//messagebox("",ls_return)
return ls_return

end function

public function integer of_filter_lights (string as_type);choose case as_type
	case "I"
		if len(is_ir_filter) > 1 then
			uo_lights.rr_ir.fillcolor = RGB(0,255,0)  //green;  
		else
			uo_lights.rr_ir.fillcolor = RGB(255,0,0) //red
		end if
		if len(is_screen_filter) > 1 then
			uo_lights.rr_s.fillcolor = RGB(192,192,192)  //grey;  
		else
			uo_lights.rr_s.fillcolor = RGB(255,0,0) //red
		end if
	case "S"
		if len(is_ir_filter) > 1 then
			uo_lights.rr_ir.fillcolor = RGB(192,192,192)  //grey;  
		else
			uo_lights.rr_ir.fillcolor = RGB(255,0,0) //red
		end if
		if len(is_screen_filter) > 1 then
			uo_lights.rr_s.fillcolor = RGB(0,255,0)  //green;  
		else
			uo_lights.rr_s.fillcolor = RGB(255,0,0) //red
		end if
		
	case "N","U"
		if len(is_ir_filter) > 1 then
			uo_lights.rr_ir.fillcolor = RGB(192,192,192)  //grey;  
		else
			uo_lights.rr_ir.fillcolor = RGB(255,0,0) //red
		end if
		if len(is_screen_filter) > 1 then
			uo_lights.rr_s.fillcolor = RGB(192,192,192)  //grey;  
		else
			uo_lights.rr_s.fillcolor = RGB(255,0,0) //red
		end if
	case "B"
		if len(is_ir_filter) > 1 then
			uo_lights.rr_ir.fillcolor = RGB(0,255,0)  //green;  
		else
			uo_lights.rr_ir.fillcolor = RGB(255,0,0) //red
		end if
		if len(is_screen_filter) > 1 then
			uo_lights.rr_s.fillcolor = RGB(0,255,0)  //green;  
		else
			uo_lights.rr_s.fillcolor = RGB(255,0,0) //red
		end if

end choose

if len(is_batch_filter) > 1 then
	if as_type = "U" then
		uo_lights.rr_p.fillcolor = RGB(192,192,192)  //grey;
	else
		uo_lights.rr_p.fillcolor = RGB(0,255,0)  //green;
	end if
else
	uo_lights.rr_p.fillcolor = RGB(255,0,0) //red
end if	

 //Start Code Change ----07.07.2015 #V15 maha - removed; set elsewhere
//if ii_facility_id > 0 then //Start Code Change ----01.23.2013 #V12 maha - allow the checklist filter only if facility selected.
//	ib_clist_filter = true
//else
//	ib_clist_filter = false
//end if


//Start Code Change ----11.09.2012 #V12 maha
if ib_clist_filter = true then
	cbx_checklist.visible = true
else
	cbx_checklist.visible = false
end if
//End Code Change ----11.09.2012




return 1
end function

public function integer of_graph_case (integer ai_case);long ll_ret  //<RP> 04.25.2016
//created maha 8-03 called from facility itemchange, user itemchange, and selected tab of analysis tab
CHOOSE CASE ai_case
	//verification status
	CASE 1	
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of verification type by process type."
		//-------------------------------<RP> modified 4.21.2016----------------------------------------------------------------------
		
		if gs_dbtype = "ASA" then //Start Code Change ----04.16.2016 #V15 maha - legacy code
			inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
			of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph)
		else //--Retrieve with arguments rather than filtering for SQL
			ll_ret = tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.event pfc_retrieve()
		end if
	//total attempts
	CASE 2
		//-------------------------------<RP> modified 4.21.2016----------------------------------------------------------------------
		//--Retrieve with arguments rather than filtering
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of verification type for awaiting response."
		if gs_dbtype = "ASA" then  //Start Code Change ----04.16.2016 #V15 maha - legacy code
			inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts, is_user_id )
			of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts)
		else
			ll_ret = tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.event pfc_retrieve()
		End if
	//expiring credentials
	CASE 3
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of All Expiring Credential verifications."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph)
	//expiring appointments	
	CASE 4
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of All Expiring Appointment verifications."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph)
	//app audit
	CASE 5
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of All Missing Required Documents."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph)
	//process tracking
	CASE 6
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of Process Action by Type."
		inv_action_items.of_filter_graph( ii_facility_id,tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph , is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph)
END CHOOSE	

return 1
end function

public function integer of_goto_net_dev_tab ();tab_1.SelectTab( 4 )

Return 1
end function

public function integer of_dash_goto_overdue_net_dev ();String ls_filter_syntax
DataWindowChild dwchild
Integer li_found

This.SetRedraw( False )

tab_1.SelectTab( 4 )

tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )

li_found = dwchild.Find( "filter_code = 'Items Over Due'", 1, 199 )

ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )

tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )

tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )

This.SetRedraw( True )

Return 1
end function

public function integer of_se ();//tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.Visible = False
tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.Visible = False
tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.Visible = False
tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.Visible = False
tab_1.tabpage_analysis.tab_analysis.tabpage_audit.Visible = False



dw_select_org_facility.x = 10000
dw_user.x = 10000
//tab_1.tabpage_analysis.Visible = False  //tab_analysis.tabpage_total_attempts.Visible = False
tab_1.tabpage_net_dev.Visible = False
st_filter.x = 73
ddplb_filters.x = 73
//This.PostEvent( "se_post_event" )


ddplb_filters.DeleteItem( 30 )
ddplb_filters.DeleteItem( 29 )
ddplb_filters.DeleteItem( 27 )
ddplb_filters.DeleteItem( 24 )
ddplb_filters.DeleteItem( 23 )
ddplb_filters.DeleteItem( 22 )
ddplb_filters.DeleteItem( 21 )
ddplb_filters.DeleteItem( 20 )
ddplb_filters.DeleteItem( 5 )
ddplb_filters.DeleteItem( 4 )


//tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.Visible = False
//tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.Visible = False
//tab_1.tabpage_analysis.tab_analysis.tabpage_audit.Visible = False
Return 1


end function

public function integer of_net_dev_ai_menu ();//maha 062905 called from window.activate and tab1.selectionchanged

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
w_mdi.ChangeMenu(m_pfe_cst_net_dev_action_items)
*/
If w_mdi.menuname <> 'm_pfe_cst_net_dev_action_items' Then w_mdi.ChangeMenu( m_pfe_cst_net_dev_action_items )
//---------------------------- APPEON END ----------------------------
m_pfe_cst_net_dev.m_action.m_initiatereappointment.visible = False
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
/*
m_pfe_cst_net_dev.m_action.m_initiatereappointment.toolbaritemvisible = False
m_pfe_cst_net_dev.m_view.m_notes.visible = False
m_pfe_cst_net_dev.m_view.m_notes.toolbaritemvisible = False
*/
gnv_app.of_modify_menu_attr( m_pfe_cst_net_dev.m_action.m_initiatereappointment,'toolbaritemvisible', False)
m_pfe_cst_net_dev.m_view.m_notes.visible = False
gnv_app.of_modify_menu_attr( m_pfe_cst_net_dev.m_view.m_notes,'toolbaritemvisible', False)
//---------End Modfiied ------------------------------------------------------

//---------Begin Added by (Appeon)Stephen 08.22.2013 for V141 Email/Fax Applications to Payors--------
if w_mdi.of_security_access(5200) = 2 then
	m_pfe_cst_net_dev_action_items.m_action.m_email_payor.visible = true
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	/*
	m_pfe_cst_net_dev_action_items.m_action.m_email_payor.toolbaritemvisible = true
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.visible = true
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.toolbaritemvisible = true
	*/
	//gnv_app.of_modify_menu_attr( m_pfe_cst_net_dev_action_items.m_action.m_email_payor,'toolbaritemvisible', true)  //Start Code Change ----02.16.2016 #V15 maha - removed
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.visible = true
	//gnv_app.of_modify_menu_attr( m_pfe_cst_net_dev_action_items.m_file.m_printapps,'toolbaritemvisible', true)  //Start Code Change ----02.16.2016 #V15 maha - removed
	//---------End Modfiied ------------------------------------------------------
	//m_pfe_cst_net_dev_action_items.m_file.m_printapps.ToolbarItemBarIndex	 = 2  //Start Code Change ----02.16.2016 #V15 maha - removed
	ib_dev_net_access = true
	
	of_app_print_menu(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev, 0, 0)
end if
//---------End Added ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.20.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------

return 1
end function

public function integer of_web_crawl ();str_web_crawler lstr_web_crawler
long ll_cnt
long i
integer s
integer cnt
long ll_code
long ll_test

select lookup_code into :ll_code from code_lookup where code = 'Web' and lookup_name = 'Verification Method';
//should be 16
for i = 1 to tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.rowcount()
	s = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"selected")
	ll_test = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"verification_method")
	if s = 1 and ll_test = ll_code then
		cnt++
		lstr_web_crawler.sl_prac_ids[i] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"v_full_name_prac_id")
		lstr_web_crawler.si_facility_ids[i] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemnumber(i,"verif_info_facility_id")
		//Start Code Change ---- 05.03.2006 #445 maha
		lstr_web_crawler.ss_docid[cnt] = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemstring(i,"doc_id")
		//End Code Change---05.03.2006
	end if
next

		//open up Web Crawler window and pass structure with prac and facility id(s)
OpenWithParm(w_web_crawler_verifications, lstr_web_crawler )
		//THIS IS A RESPONSE WINDOW SO DO A RE-RETRIEVE WHEN IT COMES BACK TO
		//UPDATE DATA WINDOW BECAUSE IN MY WEBVIEW WINDOW USERS CAN
		//COMPLETE ACTION ITEMS
//of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
		
return 1
end function

public function integer of_updatecheck (powerobject apo_control[], ref powerobject apo_control_update[]);//////////////////////////////////////////////////////////////////////
// $<function>w_prac_data_1of_updatecheck()
// $<arguments>
//		value    	PowerObject	apo_control         		
//		reference	PowerObject	apo_control_update[]		
// $<returns> integer
// $<description> Performance tunging
//////////////////////////////////////////////////////////////////////
// $<add> 02.23.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

Integer		li_max, li_i, li_max_updatecontrol, li_rc
Powerobject	lpo_tocheck
UserObject	luo_control
tab			ltab_control
Window		lw_control
Datawindow 	ldw_nonpfc
pfc_u_dw		ldw_u_dw
String ls_UpdateTable

// Loop thru all the objects
li_max = UpperBound (apo_control)
For li_i = 1 To li_max
	lpo_tocheck = apo_control[li_i]
	If IsNull(lpo_tocheck) Or Not IsValid(lpo_tocheck) Then Continue
	
	Choose Case TypeOf ( lpo_tocheck )
	
		Case Window!
			// Test for Window Controls
			lw_control = lpo_tocheck
			This.of_updatecheck ( lw_control.Control, apo_control_update[] )
			
		Case tab!
			// Test for tab controls 
			ltab_control = lpo_tocheck
			This.of_updatecheck ( ltab_control.Control, apo_control_update[] )
			
		Case UserObject!
			// Test for UserObjects 
			luo_control = lpo_tocheck
			This.of_updatecheck ( luo_control.Control, apo_control_update[] )

		Case DataWindow!
			ldw_nonpfc = lpo_tocheck
			
			// Perform AcceptText, check rc
			li_rc = ldw_nonpfc.AcceptText()
			If li_rc < 0 Then 
				ldw_nonpfc.SetFocus()
				Return FAILURE
			end if

			IF ldw_nonpfc.ModifiedCount() + ldw_nonpfc.DeletedCount() = 0 Then
				Continue
			End If

			ls_UpdateTable = Trim(ldw_nonpfc.Describe("Datawindow.Table.UpdateTable"))
			IF Isnull(ls_UpdateTable) Or ls_UpdateTable="" Or ls_UpdateTable="?" Or ls_UpdateTable="!" Then
				Continue
			End If

			If ldw_nonpfc.TriggerEvent ("pfc_descendant") = 1 Then
				ldw_u_dw = ldw_nonpfc
				If Not ldw_u_dw.of_isupdateable() Then
					Continue
				End If
			End If
			
			li_max_updatecontrol = UpperBound(apo_control_update)
			apo_control_update[li_max_updatecontrol + 1] = lpo_tocheck
	End Choose
Next

Return UpperBound (apo_control_update)

end function

public function integer of_batch_recred ();//Start Code Change ----06.10.2008 #V81 maha
long p
long pc
long cnt 
long ll_expappt = 10023 //maha 041509

long ll_facil
integer ck = 0
gs_batch_search lstr_pracs
datawindow ldw_browse


ldw_browse =  tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
pc = ldw_browse.rowcount()
//messagebox("Batch recred for 8.5","Testing")
if pc <= 0 then Return -1 //Add by Evan 09/19/2008

//trap for multiple facil
ll_facil =  ldw_browse.getitemnumber(1,"verif_info_facility_id") //***

for p = 1 to pc
	if ll_facil <>  ldw_browse.getitemnumber(p,"verif_info_facility_id") then
		ck = 1
	end if
	//Start Code Change ----04.15.2009 #V92 maha
	if ldw_browse.getitemnumber(p,"verification_method") <> ll_expappt then
		messagebox("Batch Recred", "The Batch Recredential function can only be run for Expiring Appointment type verifications.")
		return -1
	end if
	//End Code Change---04.15.2009	
next

if ck = 1 then
	messagebox("Batch Recred", "The batch recredential function can only be run for one facility at a time.")
	return -1
end if

		

for p = 1 to pc
	if ldw_browse.getitemnumber(p,"selected") = 1 then
		cnt++
		lstr_pracs.li_prac_id[cnt] = ldw_browse.getitemnumber(p,"prac_id") 
		lstr_pracs.ll_facility [cnt] = ll_facil
	end if
next

if cnt = 0 then
	messagebox("Batch Recred", "There are no providers selected.")
	return -1
end if

lstr_pracs.ls_name[1] = "AI"

openwithparm(  w_recred_batch, lstr_pracs)


return 1
end function

public function integer of_clear_print ();//Start Code Change ----04.13.2010 #V10 maha - clear print function added
Integer i
Integer li_ans
Integer li_rc
String ls_null_string
u_dw dw_browse

dw_browse =tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse 

SetNull( ls_null_string )
li_rc = dw_browse.RowCount()

if not of_find_print_flag() then return -1	//added long.zhang 10.12.2012 Invalid DataWindow row/column 

dw_browse.AcceptText()

li_ans = messagebox("Clear Print Flag","Are you sure you wish to reset the print flag of the selected records?",question!,yesno!,2)
if li_ans = 2 then return -1

FOR i = 1 TO li_rc
	
	IF dw_browse.GetItemNumber( i, "selected" ) = 0 THEN
		CONTINUE
	END IF

	dw_browse.SetItem( i, "print_flag", 1 )
	
END FOR

return 1
end function

public function integer of_get_items_list ();long ll_app_stat
integer r
datawindow ldw_browse
datawindow ldw_detail

ldw_browse = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
ldw_detail = tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail
 ll_app_stat = ldw_browse.getitemnumber(ldw_browse.getrow(),"appt_stat_id")
 
 
IF ldw_detail.DataObject <> "d_app_audit_missing_ai_list" THEN
	ldw_detail.DataObject = "d_app_audit_missing_ai_list"
	ldw_detail.SetTransObject( SQLCA )
END IF	

ldw_detail.retrieve(ll_app_stat)


return 1
end function

public function integer of_browse_security ();//Start Code Change ----07.12.2011 #V11 maha - added to protect 

datawindow ldw_data
integer cc
integer c
string ls_name

ldw_data = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

if ldw_data.rowcount( ) = 0 then return 0
debugbreak()
cc = integer(ldw_data.object.DataWindow.Column.Count)
 for c = 1 to cc
	 ldw_data.setcolumn( c)
	 ls_name = ldw_data.getcolumnname( )
	 ldw_data.modify( ls_name + ".Protect=1")  
	  ldw_data.modify( ls_name + ".Background.Color=14803425")
next

ldw_data.modify( "sall.Enabled = 'No'") //Added by Appeon long.zhang 12.09.2015 (V14.2 Applause Cycle 2 Bug #4874 - Setting access to Read Only for Action Item Details you can select/deselect all but can't do single selection)

return 1
end function

public function integer of_graph_post_click ();if w_mdi.of_security_access( 255 ) > 0 then
	tab_1.SelectTab( 2 )
	ddplb_filters.Event SelectionChanged( ii_filter_index )
end if

return 1
end function

public function integer of_get_table_id (integer ai_screen_id);//==========================================
// $<Function>  of_get_table_id ()
// $<arguments>
//	value 	integer	ai_screen_id:screen_id
// $<returns> table_id
// $<description> get table_id from screen_id
//this function called from tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail.preupdate()
// $<add> (Appeon) Long.zhang 09.29.2012
//==========================================
n_ds lds_select_section
integer li_table_id

lds_select_section = create n_ds
lds_select_section.dataobject = 'd_data_view_screens_list'

lds_select_section.settransobject(sqlca)
lds_select_section.retrieve(1)
lds_select_section.setfilter("screen_id = "+string(ai_screen_id)+"")
lds_select_section.filter()

li_table_id = lds_select_section.GetItemNumber( lds_select_section.GetRow(), "table_id" )

destroy lds_select_section

return li_table_id
end function

public function boolean of_find_print_flag ();//-----------------------------------------------------
//<$>added:long.zhang 10.12.2012
//<$>reason:check whether print_flag field exists in dw_browse
//<$> This function called from of_clear_print
//-----------------------------------------------------
u_dw dw_browse
String ls_colname
long LL_COLUMN_COUNT
long LL_I

dw_browse =tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse 

LL_COLUMN_COUNT = LONG(dw_browse.Describe("DataWindow.Column.Count"))

FOR LL_I = 1 TO LL_COLUMN_COUNT
	
	ls_colname = dw_browse.Describe("#" +STRING(LL_I) + ".Name")
	
	IF lower(ls_colname) = "print_flag" then return true
		
END FOR

Return false
end function

public function integer of_filter_visible (boolean ab_true);//Start Code Change ----02.28.2013 #V12 maha - functionalized

dw_filter.visible = ab_true
uo_lights.visible = ab_true
cbx_checklist.visible = ab_true


return 1
end function

public function integer of_app_print_menu (u_dw adw_net_dev, long al_row, integer ai_select);//====================================================================
//$<Function>: of_app_print_menu
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.28.2013 (V141 Print Apps From Action Items)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================
integer li_select
long     ll_action_type_stan, ll_action_status_stan
long     ll_action_type, ll_action_status
long     ll_app_id, ll_map_type
long     ll_row
long     ll_found, ll_cnt //alfee 04.01.2014
boolean lb_print

if not ib_dev_net_access then return 1

//---------Begin Modified by (Appeon)Alfee 04.01.2014------------------------------------
ll_action_type_stan = Long(gnv_data.of_getitem("code_lookup","lookup_code", "lookup_name = 'Action Type' and code = 'App Out To MD'"))
ll_action_status_stan = Long(gnv_data.of_getitem("code_lookup","lookup_code", "lookup_name = 'Action Status' and code = 'Incomplete'"))
//gnv_appeondb.of_startqueue()
//select lookup_code into :ll_action_type_stan from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
//select lookup_code into :ll_action_status_stan from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
//gnv_appeondb.of_commitqueue()	
//---------End Modfiied -------------------------------------------------------------------------

lb_print = false
for ll_row = 1 to adw_net_dev.rowcount()
	if ll_row = al_row then
		li_select = ai_select
	else
		li_select = adw_net_dev.getitemnumber(ll_row, "selected")
	end if
	if li_select = 1 then
		ll_app_id = adw_net_dev.getitemnumber(ll_row, "app_id")
		ll_action_type = adw_net_dev.getitemnumber(ll_row, "action_type")
		ll_action_status = adw_net_dev.getitemnumber(ll_row, "action_status")

		//---------Begin Modified by (Appeon)Alfee 04.01.2014 for V142 ISG-CLX-----------------
		//---------Begin Modified by (Appeon)Harry 08.05.2014 for BugS071801 in V14.2 Issues of New Feature--------
		//if ids_app_hdr_all.rowcount () < 1 then ll_cnt = ids_app_hdr_all.Retrieve () 
		if ids_app_hdr_all.rowcount () < 1 then ids_app_hdr_all.Retrieve ()
		ll_cnt = ids_app_hdr_all.rowcount ()
		//---------End Modfiied ------------------------------------------------------
		ll_found =  ids_app_hdr_all.Find("app_id = " + String(ll_app_id), 1, ll_cnt)
		if ll_cnt > 0 and ll_found > 0  then
			ll_map_type= ids_app_hdr_all.GetItemNumber(ll_found,"mapping_type")
		end if
		//select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id using sqlca;	
		//---------End Modfiied -------------------------------------------------------------------------
		
		if ll_map_type = 1 and ll_action_type = ll_action_type_stan and  ll_action_status = ll_action_status_stan then
			lb_print = true
			exit
		end if
	end if
next

if lb_print then
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.enabled = true
	cb_bb7.enabled = true  //Start Code Change ----02.16.2016 #V15 maha
else
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.enabled = false
	cb_bb7.enabled = false //Start Code Change ----02.16.2016 #V15 maha
end if
	
return 1
end function

public subroutine of_refresh_appl_data (); //Start Code Change ----08.10.2015 #V15 maha - added for call for postupdate of actions tree-view retrieval.

inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only, is_user_id)
end subroutine

public function integer of_select_prac (integer al_row, u_dw adw_record); //Start Code Change ----10.16.2015 #V15 maha - added; copied from recent prac gadget and modified
str_dashboard str_para
w_prac_data_1 lw_prac  // maha 04.27.2012
w_prac_data_2 lw_prac1  //maha 06.18.2013
w_prac_data_intelliapp_2 lw_prac2 //maha 06.18.2013
w_prac_data_sk_2 lw_prac3 //maha 06.18.2013

If al_row <= 0 Then Return 1

//ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_recent_data_id')
str_para.data_id = adw_record.Object.prac_id[al_row]
//str_para.prac_id = adw_record.Object.prac_id[al_row]
str_para.data_name = adw_record.Object.facility_facility_name[al_row]
str_para.data_ext_id = adw_record.Object.facility_id[al_row]
str_para.color = gl_bg_color  //16773365 //Start Code Change ----10.04.2012 #V12 maha - for 12.3

IF gs_cust_type = "I" THEN
	IF gb_sk_ver = False THEN	//app
		OpenSheetWithParm(lw_prac2 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac2
	ELSEIF gb_sk_ver = true  THEN//sk
		OpenSheetWithParm(lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3
	END IF
	IF gi_prac_tab = 1 THEN
		OpenSheetWithParm( lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3 //Bug 3375 - Alfee 01.08.2013 
	end if
ELSE //cred
	OpenSheetWithParm(lw_prac1 ,str_para,w_mdi,4,Original!)
	lw_prac = lw_prac1  //12.04.2012  maha - changed from w_prac_data_1
END IF

w_mdi.iw_prac_window = lw_prac //add Michael 05.07.2012 System Error:Null object reference

return 1

end function

public function integer of_buttons_prop (integer ai_tab);//Start Code Change ----02.12.2016 #V15 maha

cb_save.visible = False
cb_bb2.visible = False
cb_bb3.visible = False
cb_bb4.visible = False
cb_bb5.visible = False
cb_bb6.visible = False
cb_bb7.visible = False
cb_bb8.visible = False
cb_bb9.visible = False
cb_bb10.visible = False	

//Visible
choose case ai_tab
	case 1 //graphs
		cb_bb2.visible = true
		cb_bb3.visible = true	
	case 2 //detail
		if  w_mdi.of_security_access(255) < 2 or  w_mdi.of_security_access(260) = 0 then
			//leave invisible
		else
			cb_save.visible = true
			cb_bb3.visible = true
			cb_bb4.visible = true
			cb_bb5.visible = true
			cb_bb6.visible = true
			cb_bb7.visible = true
			cb_bb8.visible = true
			cb_bb9.visible = true
			cb_bb10.visible = true	
		end if  
	case 3 //committee
		//all hidden
	case 4 //appls
		if  w_mdi.of_security_access(255) < 2 then
			//leave invisible
		else
			cb_save.visible = true
			cb_bb2.visible = true
			cb_bb3.visible = true
			cb_bb7.visible = true
			cb_bb8.visible = true
			cb_bb9.visible = true  //Start Code Change ----03.22.2016 #V15 maha - added
		end if
	case 5 //CTX
		cb_bb3.visible = true
		cb_bb4.visible = true	
	case 6 //documents
		cb_bb3.visible = true
		cb_bb4.visible = true	
end choose

choose case ai_tab
	case 1 //graphs
		cb_bb2.text = "Refresh"
		cb_bb3.text = "Print Data"
	case 2
		cb_bb3.text = "Print Data"
		cb_bb7.text = "Scan OIG"
		cb_bb8.text = "Missing Letter"
		 of_enable_action_buttons( )  //Start Code Change ----02.16.2016 #V15 maha
	case 4 //apps
		cb_bb2.text = "Filter"
		cb_bb3.text = "Print Report"
		cb_bb7.text = "Print Apps"
		cb_bb8.text = "Email Payor"
		of_enable_action_buttons( )  //Start Code Change ----02.16.2016 #V15 maha
end choose



return 1
end function

public function integer of_enable_action_buttons ();//Start Code Change ----02.03.2010 #V10 maha - added ai_tab argument 
boolean lb_letter //maha 02.15.2016
String ls_find
String ls_verif_method
Integer li_picture_index
Integer li_index
integer i
Long ll_verif_method
long ll_find
datawindow au_dw

//Start Code Change ----03.11.2016 #V15 maha - corrected for some buttons being always disbled.
//disable all
//cb_save.enabled = True
//cb_bb2.enabled = True
cb_bb3.enabled = False
cb_bb4.enabled = False
cb_bb5.enabled = False
cb_bb6.enabled = False
cb_bb7.enabled = False
cb_bb8.enabled = False
//cb_bb9.enabled = True
//cb_bb10.enabled = True

//no process rights
if  w_mdi.of_security_access(260) = 0 then 
	cb_save.enabled = False
	cb_bb2.enabled = False
	cb_bb9.enabled = False
	cb_bb10.enabled = False
	return -1 
end if
//End Code Change ----03.11.2016

//trap for other tabs
choose case tab_1.selectedtab
	case 1, 2
		cb_bb3.enabled = true    //Start Code Change ----04.04.2016 #V15 maha - corrected invisible print button
	case 4
		if w_mdi.of_security_access(5200) = 2 then
			cb_bb2.enabled = true
			cb_bb3.enabled = true
			cb_bb7.enabled = true
			cb_bb8.enabled = true
			return 1
		end if
	case 5, 6 
		cb_bb3.enabled = true
		cb_bb4.enabled = true
		return 1   
	case else
		return -1   
end choose
	
au_dw = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

IF au_dw.RowCount() > 0 AND au_dw.GetRow() > 0 THEN
 	if au_dw.dataobject = "d_app_audit_missing_ai" then 
		//app audit missing items
		ls_verif_method = "MISSING AUDIT"
		cb_bb8.enabled = True
	elseif au_dw.dataobject = "d_process_actions_ofe_ai" then // OFE
		ls_verif_method = "OFE LETTER"
		cb_bb4.enabled = True
	else//any verifications

		for i = 1 to 10  //check for each type
			lb_letter = false
			choose case i
				case 1
					ls_verif_method = "VERIF LTR"
					lb_letter = true
				case 2
					ls_verif_method = "PRAC CORRE"	
					lb_letter = true
				case 3
					ls_verif_method = "EXP CRED LTR"
					lb_letter = true
				case 4
					ls_verif_method = "EXP APPT LTR"
					lb_letter = true
				case 5
					ls_verif_method =" FAX"
				case 6
					ls_verif_method = "MISS ITEM 90"
					lb_letter = true
				case 7
					ls_verif_method = "OFE LETTER"
					lb_letter = true
				case 8
					ls_verif_method = "WEB"
				case 9
					ls_verif_method = "NPDB QUERY"
				case 10
					ls_verif_method = "OIG QUERY"
			end choose
			
			ll_verif_method = long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name) = '" + upper("verification method") + "' and upper(code) = '" + ls_verif_method + "'"))
			ls_find = "verification_method = " + string(ll_verif_method)
			ll_find = au_dw.find( ls_find  , 1 , au_dw.rowcount())
			if ll_find < 0 then messagebox("Find failed","failure in of_enable_action_buttons:  ")
			
			if ll_find > 0 then
				choose case i 
					case 8  //web
						cb_bb5.enabled = True
					case 9
						// NPDB QUERY
						cb_bb6.enabled = True
					case 10
						//OIG QUERY
						cb_bb7.enabled = True
					case else
						//messagebox("","enable buttons")
						if lb_letter then cb_bb4.enabled = True
				end choose
			end if
		next  //of 10
	end if

END IF



Return 0

end function

public function integer of_ama_api ();//Start Code Change ----06.01.2016 #V152 maha
Integer li_cr
integer cnt
integer res
integer li_sent
integer li_flag
String ls_note
String ls_docids[]
Long ll_pracid[]
long ll_method
datetime ldt_now
u_dw dw_browse

dw_browse = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse

ll_method = -570 // long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_code = -570" ))

ldt_now = datetime(today(), Now())

for cnt = 1 to dw_browse.rowcount()
	if dw_browse.getitemnumber(cnt,"selected") = 0 then continue
	if dw_browse.getitemnumber(cnt,"verification_method") <> ll_method then continue
	if dw_browse.getitemnumber(cnt, "print_flag") = 0 then continue
	
	ls_docids[1] = dw_browse.getitemstring(cnt,"doc_id")
	ll_pracid[1] = dw_browse.getitemnumber(cnt, "prac_id")

	res =inv_printletters.of_ama_profile( ll_pracid[] , ls_docids[] , True, "A", 0)	
	if res = 1 then		
		ls_note = dw_browse.getitemstring(cnt,"notes")
		if len(ls_note) > 0 then 
			ls_note = "AMA API Profile " + string(today()) + " - " + ls_note
		else
			ls_note = "AMA API Profile " + string(today())
		end if
		
		dw_browse.setitem(cnt, "notes", ls_note) 
		dw_browse.setitem(cnt, "last_sent", ldt_now) 
		
		if isnull(dw_browse.getitemdatetime(cnt,"first_sent")) then dw_browse.setitem(cnt,"first_sent",ldt_now)
	
		li_sent = dw_browse.getitemnumber(cnt,"number_sent")
		if isnull(li_sent) then
			dw_browse.setitem(cnt ,"number_sent",1)
		else
			li_sent++
			dw_browse.setitem(cnt,"number_sent",li_sent)
		end if
		dw_browse.setitem(cnt,"print_flag",0)
		
		dw_browse.setitem(cnt,"mod_user", gs_user_id )
		dw_browse.setitem(cnt,"mod_date", ldt_now )
	else
		ls_note = dw_browse.getitemstring(cnt,"notes")
		if len(ls_note) > 0 then 
			ls_note = "FAILED: AMA API Profile " + string(today()) + " - " + ls_note
		else
			ls_note = "FAILED: AMA API Profile " + string(today())
		end if
	end if	
	
next

dw_browse.update()
//of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
//of_ver_filter()

return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha - added for font increase
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_net_dev.uo_net_dev.of_zoom()

end subroutine

on w_action_items.create
int iCurrent
call super::create
this.cb_bb10=create cb_bb10
this.cb_bb9=create cb_bb9
this.cb_bb8=create cb_bb8
this.cb_bb7=create cb_bb7
this.cb_bb6=create cb_bb6
this.cb_bb5=create cb_bb5
this.cb_bb4=create cb_bb4
this.cb_bb3=create cb_bb3
this.cb_bb2=create cb_bb2
this.cb_save=create cb_save
this.p_buttons=create p_buttons
this.dw_filter=create dw_filter
this.p_1=create p_1
this.st_filter=create st_filter
this.dw_select_org_facility=create dw_select_org_facility
this.dw_user=create dw_user
this.tab_1=create tab_1
this.uo_lights=create uo_lights
this.cbx_checklist=create cbx_checklist
this.st_buttons=create st_buttons
this.cb_close=create cb_close
this.ddplb_filters=create ddplb_filters
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_bb10
this.Control[iCurrent+2]=this.cb_bb9
this.Control[iCurrent+3]=this.cb_bb8
this.Control[iCurrent+4]=this.cb_bb7
this.Control[iCurrent+5]=this.cb_bb6
this.Control[iCurrent+6]=this.cb_bb5
this.Control[iCurrent+7]=this.cb_bb4
this.Control[iCurrent+8]=this.cb_bb3
this.Control[iCurrent+9]=this.cb_bb2
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.p_buttons
this.Control[iCurrent+12]=this.dw_filter
this.Control[iCurrent+13]=this.p_1
this.Control[iCurrent+14]=this.st_filter
this.Control[iCurrent+15]=this.dw_select_org_facility
this.Control[iCurrent+16]=this.dw_user
this.Control[iCurrent+17]=this.tab_1
this.Control[iCurrent+18]=this.uo_lights
this.Control[iCurrent+19]=this.cbx_checklist
this.Control[iCurrent+20]=this.st_buttons
this.Control[iCurrent+21]=this.cb_close
this.Control[iCurrent+22]=this.ddplb_filters
end on

on w_action_items.destroy
call super::destroy
destroy(this.cb_bb10)
destroy(this.cb_bb9)
destroy(this.cb_bb8)
destroy(this.cb_bb7)
destroy(this.cb_bb6)
destroy(this.cb_bb5)
destroy(this.cb_bb4)
destroy(this.cb_bb3)
destroy(this.cb_bb2)
destroy(this.cb_save)
destroy(this.p_buttons)
destroy(this.dw_filter)
destroy(this.p_1)
destroy(this.st_filter)
destroy(this.dw_select_org_facility)
destroy(this.dw_user)
destroy(this.tab_1)
destroy(this.uo_lights)
destroy(this.cbx_checklist)
destroy(this.st_buttons)
destroy(this.cb_close)
destroy(this.ddplb_filters)
end on

event activate;call super::activate;IF w_mdi.Menuid <> m_pfe_cst_action_items AND tab_1.SelectedTab <> 4 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-15 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_action_items)
	*/
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.17.2007 By: Machongmin
	//$<reason> Fix a defect.
	/*
	If w_mdi.menuname <> 'm_pfe_cst_action_items' Then w_mdi.ChangeMenu( m_pfe_cst_action_items )
	*/
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Michael 10.27.2011
	//$<reason> V12.1 Migrate AI addtl filters
	/*
	If w_mdi.menuname <> 'm_pfe_cst_action_items' Then 
		w_mdi.ChangeMenu( m_pfe_cst_action_items )
		if gb_contract_version then
			m_pfe_cst_action_items.m_view.m_addtlfilters.toolbaritemvisible = false
		end if
	else
		if gb_contract_version then
			m_pfe_cst_action_items.m_view.m_addtlfilters.toolbaritemvisible = false
		end if
	end if
	*/
	If w_mdi.menuname <> 'm_pfe_cst_action_items' Then 
		w_mdi.ChangeMenu( m_pfe_cst_action_items)
	end if
	//---------------------------- APPEON END ----------------------------	
	
	//---------------------------- APPEON END ----------------------------
	
	//---------------------------- APPEON END ----------------------------
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	w_mdi.SetToolbarPos ( 3, 1, 200, False )
	inv_action_items.of_enable_action_menu( +&
	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse , dw_select_org_facility.GetText() , tab_1.SelectedTab) 
//\/maha 091800 to fix problem of net dev menu showing after closing printletters
elseif w_mdi.Menuid = m_pfe_cst_action_items then
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	w_mdi.SetToolbarPos ( 3, 1, 200, False )
	inv_action_items.of_enable_action_menu( +&
	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse , dw_select_org_facility.GetText() , tab_1.SelectedTab) 
//\maha
ELSE
	//w_mdi.ChangeMenu( m_pfe_cst_net_dev )
	of_net_dev_ai_menu() //maha 062905
	
	//---------Begin Added by (Appeon)Stephen 08.28.2013 for V141 Email/Fax Applications to Payors--------
	if ib_dev_net_print then
		tab_1.tabpage_net_dev.uo_net_dev.triggerevent("pfc_cst_retrieve_detail")
		ib_dev_net_print = false
	end if
	//---------End Added ------------------------------------------------------	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> SetToolbarPos is unsupported. 
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)

gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------

w_mdi.of_menu_security( w_mdi.MenuName )

//Adjust menu when changing back from other App, added by Appeon long.zhang 01.08.2016 (BugL010805)
if tab_1.SelectedTab = 4 then 
	w_mdi.post of_menu_shrink_action_items( )  
end if

////Hide toolbar 2&3, Added by Appeon long.zhang 03.23.2016 (V15.1 Bug # 5060 - Action Items: Application Status - Batch update button is missing)
//If appeongetclienttype() <> 'PB' Then 
//	gnv_appeondll.of_SetToolbar(ll_handle,2, False )
//	gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//End If

end event

event close;call super::close;
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
*/
If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
//---------------------------- APPEON END ----------------------------
//Destroy inv_action_items //Evan 01/04/2009---Move to tab_1.desturctor() event

//w_mdi.iw_action_items_cnt --
gs_fil_screen = ""
gs_fil_batch = ""
gs_fil_status = ""
w_mdi.of_menu_security( w_mdi.MenuName )

IF IsValid( w_capture ) THEN
	Close( w_capture )
END IF
//--------Begin Added by Nova 07.10.2009------------------------
// It needs to close the Filter window synchronously.(Corrected BugN062602)
IF IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF
//--------End Added --------------------------------------------

//Start Code Change ----07.06.2011 #V11 maha - moved from various locations
destroy inv_pro_actions
//destroy inv_action_items //delete Michael 12.14.2011---Move to tab_1.desturctor() event
destroy inv_data_entry
destroy inv_printletters

IF IsValid(ids_app_hdr_all) THEN Destroy ids_app_hdr_all //alfee 04.01.2014
end event

event open;call super::open;IF gb_se_version THEN
	of_se()
END IF

integer set28
idw_active = tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.16.2016
//<$>reason:Moved back. BugL021601
This.x = 1
This.y = 1
This.Width = 4660
This.Height = 2512

//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.width = tab_1.tabpage_net_dev.uo_net_dev.tab_1.x - tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.x - 10 //add by stephen 08.03.2012 resize control's width
//------------------- APPEON END -------------------

//This.x = 1
//This.y = 1
//This.Width = this.tab_1.width + 120//3621
//This.Height = this.tab_1.height + 200// 2080

//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.width = tab_1.tabpage_net_dev.uo_net_dev.tab_1.x - tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.x - 10 //add by stephen 08.03.2012 resize control's width
//
st_filter.Visible = False
ddplb_filters.Visible = False

tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetFocus( )

//select set_28 into :set28 from icred_settings;
set28 = of_get_app_setting("set_28","I")

//---------------------<RP> modified - the call to pfc_retrieve() is redundant - tab_analysis.selectionchanged() will retrieve the graph------------
//if set28 <> 1 AND NOT gb_se_version then
//	//inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
//	tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.Event pfc_retrieve()
//end if
//-----------------------------------------------------------------------------------------------------------------------------------------
//mskinner 22 March 2006 -- begin
//inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
//inv_action_items.of_set_original_sql( tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph)
//mskinner 22 March 2006 -- end
il_total_filter_items = ddplb_filters.TotalItems()

ii_facility_id = 0 //maha 050802
//ddplb_filters.SelectItem( 1 )
//ddplb_filters.TriggerEvent( SelectionChanged! )
//
//w_mdi.of_action_items_security( This )

idw_active = tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08/21/2007 By: Ken.Guo
//$<reason> Fixed BugA081303. For disable RMB menu.
Tab_1.tabpage_contract.uo_1.tab_1.tabpage_2.dw_details.of_setRMBmenu(False)
Tab_1.tabpage_document_manager.tab_1.tabpage_2.dw_details.of_setRMBmenu(False)
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<comment> 01.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to the Constructor event of pfc_ia_cst_nv_net_dev_new_action_items.
//$<modification> due to the usage of CreateOnDemand property. Refer to PT-19 for more information.
//tab_1.tabpage_net_dev.uo_net_dev.of_Set_Facility_id( 0 )
//tab_1.tabpage_net_dev.uo_net_dev.of_sql()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product.
//03/24/2007 By Jervis move to pfc_postopen
//IF gb_contract_version and  THEN
//	This.tab_1.post selecttab(5)
//END IF
//---------------------------- APPEON END ----------------------------

if gb_contract_version then
	uo_lights.Visible = false
	cbx_checklist.Visible = false //maha 11.09.2012
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2008 By: Evan
//$<reason> Fix BugJ122702 about Document Manager Tab still displays.
if gnv_data.of_getitem("icred_settings", "set_cont", false) = "0" then
	tab_1.tabpage_document_manager.Hide()
end if
//---------------------------- APPEON END ----------------------------

//Start Code Change ----11.09.2012 #V12 maha
integer ll_set_4
long ll_default
select set_4, default_search_facility into :ll_set_4, :ll_default from security_users where user_id = :gs_user_id;

if ll_set_4 = 1 and ii_dashboard_macro = -1 then

	//Start Code Change ----03.15.2016 #V15 maha - modified to only set if there is a default facility
	if ll_default > 0 then
		dw_select_org_facility.SetItem( 1, "facility_id", ll_default)
		ii_facility_id = ll_default
	end if
	//End Code Change ----03.15.2016
	dw_user.SetItem( 1, "user_id",gs_user_id )
	is_user_id = gs_user_id
	
	inv_action_items.of_filter_graph( ll_default,tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph , gs_user_id)
end if
//Start Code Change ----11.09.2012	
	
tab_1.tabpage_net_dev.uo_net_dev.iw_action_items = this	 //(Appeon)Stephen 10.16.2013 - BugL101501	(w_sheet)
tab_1.tabpage_net_dev.uo_net_dev.iw_actions = this  //Start Code Change ----08.07.2015 #V15 maha (w_action_items)

//Comment by Appeon long.zhang 02.17.2016 (BugL021702)
//if appeongetClientType() = 'WEB' then//long.zhang 11.20.2013 need adjust position under web BugL111402
//	cb_close.x = 3799
//	cb_close.y = 32
//	cb_close.width = 219
//	cb_close.height = 92
//end if	
of_zoom()  //Start Code Change ----07.13.2017 #V154 maha

	
	
	
	
	
	


end event

event pfc_save;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 03.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Modify the script to have the application only check the current
//$<modification> tab page before updating the database.
/*
Integer li_cr

li_cr = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow()
//tab_1.tabpage_detail.dw_detail.SetItem(li_cr , "selected", 0) 

IF AncestorReturnValue = 1 THEN
	IF lb_response_cd_entered THEN
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Event pfc_Retrieve()
	END IF
	IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount() > ii_cr THEN
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetRow( ii_cr )
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.ScrollToRow( ii_cr )
	END IF
END IF

//m_pfe_cst_action_items.m_file.m_save.Enabled = False

Return AncestorReturnValue
*/
Integer li_retval
powerobject lpo_empty[], apo_control[]

// Check all object
li_retval = This.of_updatecheck( tab_1.Control[tab_1.SelectedTab].Control, apo_control )

If li_retval > 0 Then
	// Initialize array holding the objects that need to be updated.
	ipo_tempupdateobjects = apo_control
	
	// Perform the actual update(s).
	li_retval = Super::Event pfc_save()
	
	// Clear array holding the objects that were just updated.
	ipo_tempupdateobjects = lpo_empty
End If

Integer li_cr

li_cr = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow()
//tab_1.tabpage_detail.dw_detail.SetItem(li_cr , "selected", 0) 

IF li_retval = 1 THEN
	IF lb_response_cd_entered THEN
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Event pfc_Retrieve()
	END IF
	IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount() > ii_cr THEN
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetRow( ii_cr )
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.ScrollToRow( ii_cr )
	END IF
END IF

//m_pfe_cst_action_items.m_file.m_save.Enabled = False

Return li_retval
//---------------------------- APPEON END ----------------------------


end event

event pfc_preupdate;call super::pfc_preupdate;ii_cr = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetRow()

Return AncestorReturnValue
end event

event pfc_postupdate;call super::pfc_postupdate;Integer li_rc
Integer i
Integer ll_facility_ids[]
Long ll_prac_ids[]
Integer li_screen_ids[]

// mskinner 20dec 2005 -- begin
//Start Code Change ----09.22.2010 #V10 maha - added trap so if app audit will go to ue_postupdate
if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject <> "d_app_audit_missing_ai" then
	if upperbound(ii_facility_ids) < 1 or upperbound(il_prac_ids) < 1 or upperbound(ii_screen_ids) < 1 then 
		return 0
	end if 
end if
// mskinner 20dec 2005 -- end


//messagebox("upperbound","li_rc")
//messagebox("upperbound",li_rc)

//--------------------------- APPEON BEGIN ---------------------------
//<ID> PT-07
//$<modify> 04.05.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Copy the script in of_is_last_verif and of_is_app_audit_compl to the loop. 
//$<modification> 2)Encapsulate the script into ue_postupdate.
//$<modification> 3)Use Appeon Queue label to reduce client-server interactions.
//$<modification> 4)Call ue_postupdate.
/*
li_rc = UpperBound( ii_facility_ids )
FOR i = 1 TO li_rc
	inv_action_items.of_is_last_verif( ii_facility_ids[ i ], il_prac_ids[ i ] ,ii_screen_ids[i])
	inv_action_items.of_is_app_audit_compl( il_prac_ids[ i ],ii_facility_ids[ i ] )
END FOR
*/

Trigger Event ue_postupdate()

//---------------------------- APPEON END ----------------------------

ii_facility_ids = ll_facility_ids
il_prac_ids = il_prac_ids
ii_screen_ids = li_screen_ids

Return 1

end event

event pfc_postopen;call super::pfc_postopen;String ls_filter_syntax
DataWindowChild dwchild
Integer li_found

//if this is not IntelliApp only then do not use any of this stuff
//IF gs_cust_type <> "I" THEN
//	Return
//END IF
//inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )

tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.rb_par_sum.visible = false
tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.rb_par.visible = false



//------------Begin Commented by alfee 09.17.2010 -----------------
//SK Practitioner Folder
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SetRow( 1 )
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 0, False )
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 1, True )
//
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SetRow( 1 )
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 0, False )
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 1, True )
//------------End Commented -----------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product.
IF gb_contract_version and this.ii_dashboard_macro <> 104 THEN
	This.tab_1.selecttab(5)
END IF
//---------------------------- APPEON END ----------------------------

CHOOSE CASE ii_dashboard_macro
	//Items over due Today
	CASE 0
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
		li_found = dwchild.Find( "filter_code = 'Items Due TODAY'", 1, 199 )
		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )
		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )
		
	//overdue net dev action items
	CASE 1
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
		li_found = dwchild.Find( "filter_code = 'Items Over Due'", 1, 199 )
		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )
		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )
		
	CASE 2
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
		li_found = dwchild.Find( "filter_code = 'Applications Needing Printed'", 1, 199 )
		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )		
		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
	
	//You have # App Rcvd Prac follow letters to send	
	CASE 3
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
		li_found = dwchild.Find( "filter_code = 'Applications Not Back From Provider'", 1, 199 )
		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )		
		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
		
	//You have # Par Rcvd Payor follow letters to send	
	CASE 4
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
		li_found = dwchild.Find( "filter_code = 'PAR # Not Back From Payor'", 1, 199 )
		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )				
		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
		
	//You have # Expiring letters to send	
	CASE 5
		tab_1.SelectTab( 2 )
		if gs_cust_type = "I" THEN
			ddplb_filters.SelectItem( 1 ) 
		else
			ddplb_filters.SelectItem( 2 )
		end if

		if gs_cust_type = "I" THEN
			ii_filter_index = 1 
		else
			ii_filter_index = 2
		end if
		

		is_filter = ddplb_filters.Text
		//Start Code Change ---- 03.27.2006 #343 maha
		inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
		//End Code Change---03.27.2006
		is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )

		IF is_display_text = "-1" THEN
			Return 
		END IF
		
		This.Event pfc_cst_print_letters()

	//Application Status Report by Practitioner
	CASE 6
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 4 ) 
		
	//Application Status Report by Plan
	CASE 7
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 4 ) 		
		tab_1.tabpage_net_dev.uo_net_dev.ddlb_group_by.SelectItem( 2 )
		tab_1.tabpage_net_dev.uo_net_dev.ddlb_group_by.triggerevent(selectionchanged!)
	//You have # Missing Information Items
	CASE 8 //maha 101204
		tab_1.SelectTab( 4 )
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 4 ) 
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.rb_par_sum.checked = true
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.rb_par_sum.triggerevent(clicked!)
	CASE 10
		tab_1.SelectTab( 2 )
		ddplb_filters.Visible = True
		if gs_cust_type = "I" THEN
			ddplb_filters.SelectItem( 4 ) 
		else
			ddplb_filters.SelectItem( 27 )
		end if
				
		if gs_cust_type = "I" THEN
			ii_filter_index = 4 
		else
			ii_filter_index = 27
		end if
		ii_filter_index = 4

		is_filter = ddplb_filters.Text
		
		is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )

		IF is_display_text = "-1" THEN
			Return 
		END IF
				
END CHOOSE

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.07.2006 By: Davis
//$<reason> Go to the appropriate tab within the tab folder depending on the 
//$<reason> module that the To Do list is for.  
//$<reason> The system apply the same filter that is associated with the Action
//$<reason> Item Record Criteria so the that all the detailed Action Items records 
//$<reason> related to the To Do Entry are displayed. 

String ls_sql
CHOOSE CASE ii_dashboard_macro
	CASE 101		//INTELLICRED GO TO Action Items->Action Item Detail
		tab_1.SelectTab( 2 )
		
		IF ii_facility_id = 0 THEN
			IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.DataObject <> "d_ver_summary_record_view_for_ai_all" THEN
				tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.DataObject = "d_ver_summary_record_view_for_ai_all"
				tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetTransObject( SQLCA )
				inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
			END IF
		ELSE
			IF tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.DataObject <> "d_ver_summary_record_view_for_ai" THEN
				tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.DataObject = "d_ver_summary_record_view_for_ai"
				tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetTransObject( SQLCA )
				inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
			END IF	
		END IF

		ls_sql = inv_action_items.of_get_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )

		// use 1=1 instead of action_status is null
		Integer li_pos
		li_pos = POS(Lower(ls_sql), Lower("verif_info.response_code IS NULL"))
		IF li_pos > 0 THEN
			ls_sql = Left(ls_sql, li_pos - 1) + "1=1" + Mid(ls_sql, li_pos + 32)
		END IF

		IF f_validstr(ii_dashboard_where) THEN ls_sql = ls_sql + " AND " + ii_dashboard_where

		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetTransObject( SQLCA )
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Modify('DataWindow.Table.Select="' + ls_sql + '"')
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Setfilter( "" )
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Event pfc_Retrieve( )

	CASE 102		//INTELLIAPP GO TO Action Items->Application Status
		tab_1.SelectTab( 4 )
		
		ls_sql = tab_1.tabpage_net_dev.uo_net_dev.is_sql
		IF f_validstr(ii_dashboard_where) THEN ls_sql = ls_sql + " AND " + ii_dashboard_where
		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.POST SetItem( 1, "quick_filter", "" )
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.POST Modify('DataWindow.Table.Select="' + ls_sql + '"')
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.POST Setfilter( "" )
		tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.POST Retrieve( )
	CASE 103		//INTELLICONTRACT GO TO Action Items->Contract
		tab_1.SelectTab( 5 )
		//tab_1.tabpage_document_manager.visible = false
		tab_1.tabpage_contract.uo_1.tab_1.SelectTab( 2 )
		
		Long ll_null
		SetNull(ll_null)
		u_tabpage_ctx_ai_details lu_ctx_actionitem
		lu_ctx_actionitem = tab_1.tabpage_contract.uo_1.tab_1.tabpage_2
		//lu_ctx_actionitem = tab_1.tabpage_contract.uo_1.tab_1.tabpage_2
		lu_ctx_actionitem.of_reset_details( lu_ctx_actionitem.astr_sql)
		IF f_validstr(ii_dashboard_where) THEN lu_ctx_actionitem.astr_sql[1].s_where += " AND " + ii_dashboard_where
		lu_ctx_actionitem.dw_details.Modify('DataWindow.Table.Select="' + lu_ctx_actionitem.inv_cst_sql.of_Assemble(lu_ctx_actionitem.astr_sql) + '"')
		//lu_ctx_actionitem.dw_1.setItem(1,'ctx_id',ll_null)
		lu_ctx_actionitem.dw_details.setfilter( "" )
		lu_ctx_actionitem.dw_details.retrieve()	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.22.2007 By: Machongmin
	//$<reason> Fix a defect.
	CASE 104
		string ls_temp,ls_where
		
		tab_1.SelectTab(6)
		//tab_1.tabpage_contract.visible = false
		tab_1.tabpage_document_manager.tab_1.post selecttab(2)
		tab_1.tabpage_document_manager.tab_1.tabpage_1.dw_1.settransobject(sqlca)

		SetNull(ll_null)
		u_tabpage_ctx_doc_details lu_ctx_actionitem_doc
		//u_tabpage_ctx_doc_graph   lu_ctx_actionitem_doc_graph
		
		lu_ctx_actionitem_doc = tab_1.tabpage_document_manager.tab_1.tabpage_2
		lu_ctx_actionitem_doc.of_reset_details( lu_ctx_actionitem_doc.astr_sql)
		IF f_validstr(ii_dashboard_where) THEN lu_ctx_actionitem_doc.astr_sql[1].s_where += " AND " + ii_dashboard_where
		
		ls_temp = lu_ctx_actionitem_doc.inv_cst_sql.of_Assemble(lu_ctx_actionitem_doc.astr_sql)
		lu_ctx_actionitem_doc.dw_details.Modify('DataWindow.Table.Select="' + ls_temp + '"')
		
		/*
		ls_where = lu_ctx_actionitem_doc.astr_sql[1].s_where
		if len(ls_where ) > 0 then
			ls_temp = "SELECT COUNT_1 = COUNT(1), letter_status = 'Awaiting Response' FROM ctx_am_action_item,wf_action_types,code_lookup,ctx_am_document  WHERE " + ls_where + " and not (ctx_am_action_item.print_flag >= 0 ) union SELECT COUNT_1 = COUNT(1), letter_status = ' Needs Processing' FROM ctx_am_action_item,wf_action_types,code_lookup,ctx_am_document  WHERE  " + ls_where + " and  ctx_am_action_item.print_flag >= 0"
		else
			ls_temp = "SELECT COUNT_1 = COUNT(1), letter_status = 'Awaiting Response' FROM ctx_am_action_item,wf_action_types,code_lookup,ctx_am_document  WHERE not (ctx_am_action_item.print_flag >= 0 ) union SELECT COUNT_1 = COUNT(1), letter_status = ' Needs Processing' FROM  ctx_am_action_item,wf_action_types,code_lookup,ctx_am_document  WHERE ctx_am_action_item.print_flag >= 0"
		end if
		tab_1.tabpage_document_manager.tab_1.tabpage_1.dw_1.setsqlselect(ls_temp)
		*/
		lu_ctx_actionitem_doc.dw_details.setfilter("")
		lu_ctx_actionitem_doc.dw_details.retrieve()	
		
		/*
		tab_1.tabpage_document_manager.tab_1.tabpage_1.dw_1.setfilter("")
		tab_1.tabpage_document_manager.tab_1.tabpage_1.dw_1.retrieve()
		*/
	//---------------------------- APPEON END ----------------------------	
END CHOOSE

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.14.2008 By: Evan  ;Ken.Guo 2008-04-10
//$<reason> Fix BugG122503 about the Analysis tab still displays.
integer li_VisibleTab
integer li_SelectedTab

li_SelectedTab = tab_1.SelectedTab
if (li_SelectedTab = 1 and not tab_1.tabpage_analysis.Visible) or &
   (li_SelectedTab = 2 and not tab_1.tabpage_detail.Visible) or &
   (li_SelectedTab = 3 and not tab_1.tabpage_ready.Visible) or &
   (li_SelectedTab = 4 and not tab_1.tabpage_net_dev.Visible) or &
   (li_SelectedTab = 5 and not tab_1.tabpage_contract.Visible) or &
   (li_SelectedTab = 6 and not tab_1.tabpage_document_manager.Visible) &
then
	if tab_1.tabpage_analysis.Visible then
		li_VisibleTab = 1
	elseif tab_1.tabpage_detail.Visible then 
		li_VisibleTab = 2
	elseif tab_1.tabpage_ready.Visible then
		li_VisibleTab = 3
	elseif tab_1.tabpage_net_dev.Visible then
		li_VisibleTab = 4
	elseif tab_1.tabpage_contract.Visible then
		li_VisibleTab = 5
	elseif tab_1.tabpage_document_manager.Visible then
		li_VisibleTab = 6
	else
		li_VisibleTab = 0
	end if
	if li_VisibleTab > 0 then tab_1.SelectTab(li_VisibleTab)
end if
//---------------------------- APPEON END ----------------------------
end event

event pfc_preopen;call super::pfc_preopen;//Start Code Change ----07.06.2011 #V11 maha - moved here
inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
inv_action_items = CREATE pfc_n_cst_ai_action_items 
inv_pro_actions = create n_cst_process_actions
inv_printletters = CREATE pfc_n_cst_ai_printletters
//inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
//End Code Change ----07.06.2011

//alfee 04.01.2014
ids_app_hdr_all = Create DataStore
ids_app_hdr_all.DataObject = "d_app_hdr_mapping_type"
ids_app_hdr_all.SetTransObject (SQLCA)

////Start Code Change ----02.09.2016 #V15 maha - readded partial code
this.of_SetResize(true)

this.inv_resize.of_SetOrigSize(4571,2371 )
this.inv_resize.of_setMinSize( 4146, 2232)

//il_oriWidth = this.workspacewidth( )
//il_oriHeight = this.workspaceheight( )

this.inv_resize.of_Register(tab_1, this.inv_resize.scale)
////	this.inv_resize.of_Register(uo_lights, this.inv_resize.scale)
////	this.inv_resize.of_Register(dw_select_org_facility, this.inv_resize.scale)
////	this.inv_resize.of_Register(dw_user, this.inv_resize.scale)
////	this.inv_resize.of_Register(ddplb_filters, this.inv_resize.scale)
////	this.inv_resize.of_Register(st_filter, this.inv_resize.scale)
////this.inv_resize.of_Register(tab_1.tabpage_analysis.tab_analysis, this.inv_resize.scale)
////this.inv_resize.of_Register(tab_1.tabpage_detail.tab_view, this.inv_resize.scale)
////this.inv_resize.of_Register(tab_1.tabpage_ready.tab_ready, this.inv_resize.scale)
////this.inv_resize.of_Register(tab_1.tabpage_net_dev.uo_net_dev, this.inv_resize.scale)
this.inv_resize.of_Register(tab_1.tabpage_contract.uo_1, this.inv_resize.scale)
this.inv_resize.of_Register(tab_1.tabpage_contract.uo_1.tab_1, this.inv_resize.scale)
//	
////End Code Change ----02.09.2016 

end event

event resize;call super::resize;//tab_1.tabpage_net_dev.uo_net_dev.of_post_resize_ai( tab_1.tabpage_net_dev.uo_net_dev.height,  tab_1.tabpage_net_dev.uo_net_dev.width ) //Start Code Change ----02.10.2016 #V15 maha
//Start Code Change ----02.09.2016 #V15 maha - added resize code
long li_wid
long li_high
long li_dwh

li_wid =tab_1.width - 60
li_high = tab_1.height - 120

//dw_filter.y = tab_1.height - 200
dw_filter.y = tab_1.y + tab_1.height - 250 //Modified by Appeon long.zhang 02.16.2016 (BugL021601)
uo_lights.y = dw_filter.y - 20
cbx_checklist.y = uo_lights.y +120

//Start Code Change ----02.12.2016 #V15 maha
dw_select_org_facility.y = tab_1.y + 120
dw_user.y = dw_select_org_facility.y
st_filter.y = dw_select_org_facility.y + 12
ddplb_filters.y = st_filter.y + 60
st_buttons.width = newwidth - 20
//End Code Change ----02.09.2016

//graphs
tab_1.tabpage_analysis.tab_analysis.width =li_wid
tab_1.tabpage_analysis.tab_analysis.height = li_high - tab_1.tabpage_analysis.tab_analysis.y
li_dwh =  tab_1.tabpage_analysis.tab_analysis.height - 360

tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.height = li_dwh

tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.height = li_dwh

tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.height = li_dwh

tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.height = li_dwh

tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.height = li_dwh

tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph.width = li_wid - 60
tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph.height = li_dwh

//Detail
tab_1.tabpage_detail.tab_view.width = li_wid
tab_1.tabpage_detail.tab_view.height = tab_1.tabpage_analysis.tab_analysis.height + 48
li_dwh =  tab_1.tabpage_detail.tab_view.height - 360
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.width = li_wid - 60
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.height = li_dwh
tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail.width = li_wid - 60
tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail.height = li_dwh - 80 //Start Code Change ----03.22.2016 #V15 maha - subtract height of st_name

//Committee
tab_1.tabpage_ready.tab_ready.width = li_wid
tab_1.tabpage_ready.tab_ready.height = tab_1.tabpage_analysis.tab_analysis.height + 48
tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.width = li_wid - 60
tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.height = li_dwh
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.width = li_wid - 60
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.height = li_dwh

//Actions
tab_1.tabpage_net_dev.uo_net_dev.width = li_wid
tab_1.tabpage_net_dev.uo_net_dev.height = tab_1.tabpage_analysis.tab_analysis.height + 48
tab_1.tabpage_net_dev.uo_net_dev.of_post_resize_ai( tab_1.tabpage_net_dev.uo_net_dev.height, li_wid )

//Contracts 
//is self contained

return 1


end event

type cb_bb10 from commandbutton within w_action_items
integer x = 3726
integer y = 16
integer width = 471
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Recred"
end type

event clicked;event pfc_cst_batch_recredential()
end event

type cb_bb9 from commandbutton within w_action_items
integer x = 3273
integer y = 16
integer width = 439
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Update"
end type

event clicked;
//Start Code Change ----03.22.2016 #V15 maha - added the app update
if tab_1.selectedtab = 4 then
	event pfc_cst_batch_update()
else
	event pfc_cst_batch_response()
end if


end event

type cb_bb8 from commandbutton within w_action_items
integer x = 2866
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Missing Letter"
end type

event clicked;if tab_1.selectedtab = 4 then
	event pfc_email_payor()
else
	event pfc_cst_missing_info()
end if
end event

type cb_bb7 from commandbutton within w_action_items
integer x = 2459
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan OIG"
end type

event clicked;choose case tab_1.selectedtab
	case 2
		event pfc_cst_scan_oig()
	case 4
		event pfc_cst_print_apps_from_pf()
end choose

end event

type cb_bb6 from commandbutton within w_action_items
integer x = 2053
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "NPDB"
end type

event clicked;event pfc_cst_npdb_export()

end event

type cb_bb5 from commandbutton within w_action_items
integer x = 1646
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Web "
end type

event clicked;event pfc_cst_goto_web()
end event

type cb_bb4 from commandbutton within w_action_items
integer x = 1239
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Letters"
end type

event clicked;event pfc_cst_print_letters( )
end event

type cb_bb3 from commandbutton within w_action_items
integer x = 832
integer y = 16
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Data"
end type

event clicked;choose case tab_1.selectedtab
	case 1, 2 ,5, 6
		event pfc_cst_print_report()
	case 4
		event pfc_cst_print_net_dev_report()
		
end choose


end event

type cb_bb2 from commandbutton within w_action_items
integer x = 425
integer y = 16
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;choose case tab_1.selectedtab
	case 1 
		event pfc_cst_refresh()
	case 4
		event pfc_cst_net_dev_filter()
end choose
	



end event

type cb_save from commandbutton within w_action_items
integer x = 18
integer y = 16
integer width = 393
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;parent.triggerevent("pfc_save")
end event

type p_buttons from picture within w_action_items
integer x = 14
integer y = 16
integer width = 4530
integer height = 100
string picturename = "button_bar_back_actions.png"
boolean focusrectangle = false
end type

type dw_filter from datawindow within w_action_items
integer x = 46
integer y = 2104
integer width = 2633
integer height = 200
integer taborder = 40
string title = "none"
string dataobject = "d_ai_filter"
boolean livescroll = true
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 10.25.2011 V12.1 Migrate AI addtl filters
//////////////////////////////////////////////////////////////////////
long ll_Find
DataWindowChild ldwc_Child

insertrow(0)
dw_filter.GetChild("screen", ldwc_Child)
ldwc_Child.settransobject(sqlca)
ldwc_Child.retrieve( )
ldwc_Child.insertrow(1)
ldwc_Child.setitem(1,'screen_id',-999)
ll_Find = ldwc_Child.Find("screen_id=-10", 1, ldwc_Child.RowCount())
if ll_Find > 0 then ldwc_Child.DeleteRow(ll_Find)

dw_filter.GetChild("batch", ldwc_Child)
ldwc_Child.settransobject(sqlca)
ldwc_Child.retrieve( )
ldwc_Child.insertrow(1)
ldwc_Child.setitem(1,'batch_id',-999)
end event

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> 
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 10.25.2011 V12.1 Migrate AI addtl filters
//////////////////////////////////////////////////////////////////////
long i
long ic
long ll_batch_id
string ls_pracids = ""
n_ds lds_batch

//---------------------- <RP> added 4.21.2016------------------------
IF tab_1.selectedTab = 1 THEN
	tab_1.tabpage_analysis.tab_analysis.event post selectionchanged(0, tab_1.tabpage_analysis.tab_analysis.selectedTab)
END IF
//-----------------------<RP>---------------------------

choose case lower(dwo.name)
	case 'status'
		ib_ir = true
		if data = '1' then
			is_ir_filter = "apptmnt_type = 'I'" 
			//gs_fil_status = "Initial"	
		elseif data = '2' then
			is_ir_filter = "apptmnt_type = 'R'"
			//gs_fil_status = "Recred"	
		elseif data = '6' then  //Start Code Change ----12.08.2014 #V14.2 maha - midcycle
			is_ir_filter = "apptmnt_type = 'M'"
		else
			is_ir_filter = ""
			//gs_fil_status = ""
		end if
	case 'screen'
		ib_screen = true		
		if long(data) < 1 then			
			is_screen_filter = ""
		else
			is_screen_filter = "screen_id = " + data			
		end if
	case 'batch'
		ll_batch_id  = long(data)
		ib_prac = true
		
		if ll_batch_id < 1 then			
			is_batch_filter = ""
		else
			lds_batch = CREATE n_ds
			lds_batch.DataObject = "d_batch_items_list"
			lds_batch.of_SetTransObject( SQLCA )
			ic = lds_batch.retrieve(ll_batch_id) 
			for i = 1 to ic
				ls_pracids = ls_pracids + string(lds_batch.getitemnumber(i,"prac_id"))
				if i < ic then ls_pracids = ls_pracids + ","
			next			
			
			if ic < 1 then
				is_batch_filter = ""
			else
				is_batch_filter = "prac_id in (" + ls_pracids + ")"
			end if	
			if isvalid(lds_batch) then destroy lds_batch
		end if
end choose
if ib_ir  and ib_screen then
	is_addtl_filter = ""
end if
parent.event pfc_cst_addtl_filters( )

end event

event buttonclicked;//Start Code Change ----04.25.2012 #V12 maha - added clear button.

is_ir_filter = ""
is_screen_filter = ""
is_batch_filter = ""

this.reset()
this.insertrow(1)

parent.event pfc_cst_addtl_filters( )

//--------------------- <RP> added 4.22.2016 ------------------------------------
CHOOSE CASE tab_1.SelectedTab
	//analysis graphs
	CASE 1
		CHOOSE CASE tab_1.tabpage_analysis.tab_analysis.SelectedTab
			CASE 1, 2
				of_graph_case(tab_1.tabpage_analysis.tab_analysis.SelectedTab)
		END CHOOSE
END CHOOSE
//---------------------------------------------------------------------------------------
end event

type p_1 from picture within w_action_items
boolean visible = false
integer x = 3319
integer y = 148
integer width = 82
integer height = 60
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type st_filter from statictext within w_action_items
boolean visible = false
integer x = 1833
integer y = 288
integer width = 283
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Filter"
boolean focusrectangle = false
end type

type dw_select_org_facility from pfc_cst_u_org_facility_selector_horiz within w_action_items
event ue_setfacilitylabel ( )
integer x = 50
integer y = 272
integer width = 1211
integer height = 164
integer taborder = 50
end type

event ue_setfacilitylabel();//////////////////////////////////////////////////////////////////////
// $<function> ue_setfacilitylabel
// $<arguments>
// $<returns> (None)
// $<description> Corrected BugA090104
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.12.2009
//////////////////////////////////////////////////////////////////////

// Changes facility lable if is IntelliApp module
if of_get_app_setting("set_9", "I") = 1 then
	if IsNull(gs_app_stat_facility_label) then gs_app_stat_facility_label = "Facility"
	this.Post Modify("facilities_t.text = '" + gs_app_stat_facility_label + "'")
else
	if gs_cust_type = "CVO" then
		this.Post Modify("facilities_t.text = 'Customer'")
	end if
end if
end event

event itemchanged;call super::itemchanged;Integer i
Integer li_rc
Integer li_dummy_array[]
DatawindowChild dwchild

ii_facility_ids_all = li_dummy_array

AcceptText()
//debugbreak()
IF This.GetColumnName() = "facility_id" THEN
	ii_facility_id = Integer( data )
	//tab_1.tabpage_net_dev.uo_net_dev.of_Set_Facility_id( ii_facility_id )	
END IF


// ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph
CHOOSE CASE tab_1.SelectedTab
	//analysis graphs
	CASE 1
		of_graph_case(tab_1.tabpage_analysis.tab_analysis.SelectedTab)
	//action item detail tab
	CASE 2
		inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters)	
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Added by (Appeon)10.23.2017 #V161 Gavin  Alpha Testing V15.4 Bug # 5850

		//of_filter_by_intellibatch(tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse)
	CASE 3
		of_get_ready_for_committee()
		of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready)
		of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm)
	CASE 4
		 //Start Code Change ----07.30.2015 #V15 maha
		 tab_1.tabpage_net_dev.uo_net_dev.of_set_facility_id( ii_facility_id )   //Start Code Change ----07.30.2015 maha - change from 0
		inv_action_items.il_facility = ii_facility_id
		inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only,  is_user_id)
		//tab_1.tabpage_net_dev.uo_net_dev.of_Retrieve_Detail( ii_facility_id )
	//	of_filter_by_intellibatch(tab_1.tabpage_net_dev.tabpage_browse.dw_browse)
		of_filter_by_intellibatch(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev)
		//End Code Change ----07.30.2015
END CHOOSE

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.18.2011
//$<reason> fixed a bug
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetRowFocusIndicator( p_1 )
//------------------- APPEON END ---------------------
	
idw_active.SetFocus()
end event

event constructor;call super::constructor;AcceptText()

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 05.12.2009
//$<reason> Corrected BugA090104
/*
IF gs_cust_type = "CVO" THEN
	This.Modify( "facilities_t.text = 'Customer'" )
ELSEIF gs_cust_type = "I" THEN
	This.Modify( "facilities_t.text = 'Payor/Hospital'" )
END IF
*/
//------------------- APPEON END ---------------------
end event

type dw_user from pfc_cst_u_user_selector within w_action_items
integer x = 1262
integer y = 276
integer width = 475
integer height = 164
integer taborder = 40
end type

event itemchanged;AcceptText()
is_user_id =  GetText()


CHOOSE CASE tab_1.SelectedTab
	//last attemp graph tab
	CASE 1
		of_graph_case(tab_1.tabpage_analysis.tab_analysis.SelectedTab)
//		CHOOSE CASE tab_1.tabpage_analysis.tab_analysis.SelectedTab
//			//verification status
//			CASE 1
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
//				//total attempts
//			CASE 2
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts, is_user_id )
//			
//			CASE 3
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph, is_user_id )
//			//expiring appointments	
//			CASE 4
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph, is_user_id )
//			CASE 5
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph, is_user_id )
//		END CHOOSE		
	//action item detail tab
	CASE 2
		inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters)
		tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Added by (Appeon)10.23.2017 #V161 Gavin  Alpha Testing V15.4 Bug # 5850

	CASE 4
		 //Start Code Change ----08.03.2015 #V15 maha - added
		 tab_1.tabpage_net_dev.uo_net_dev.of_set_user_ai( is_user_id)
		inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only,  is_user_id)
		of_filter_by_intellibatch(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev)
		 //Start Code Change ----08.03.2015
END CHOOSE

idw_active.SetFocus()


//inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only, ii_facility_id, is_user_id)
end event

event constructor;call super::constructor;This.SetItem( 1, "user_id", "All" )


end event

event getfocus;



end event

type tab_1 from tab within w_action_items
event create ( )
event destroy ( )
event u_post_selection_changed ( )
integer x = 9
integer y = 156
integer width = 4549
integer height = 2204
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
boolean createondemand = true
alignment alignment = center!
integer selectedtab = 1
tabpage_analysis tabpage_analysis
tabpage_detail tabpage_detail
tabpage_ready tabpage_ready
tabpage_net_dev tabpage_net_dev
tabpage_contract tabpage_contract
tabpage_document_manager tabpage_document_manager
end type

on tab_1.create
this.tabpage_analysis=create tabpage_analysis
this.tabpage_detail=create tabpage_detail
this.tabpage_ready=create tabpage_ready
this.tabpage_net_dev=create tabpage_net_dev
this.tabpage_contract=create tabpage_contract
this.tabpage_document_manager=create tabpage_document_manager
this.Control[]={this.tabpage_analysis,&
this.tabpage_detail,&
this.tabpage_ready,&
this.tabpage_net_dev,&
this.tabpage_contract,&
this.tabpage_document_manager}
end on

on tab_1.destroy
destroy(this.tabpage_analysis)
destroy(this.tabpage_detail)
destroy(this.tabpage_ready)
destroy(this.tabpage_net_dev)
destroy(this.tabpage_contract)
destroy(this.tabpage_document_manager)
end on

event u_post_selection_changed();
if gi_intelliapp_type > 0 then return //SK Practitioner Folder - alfee 09.15.2010

tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.setrow(1)
tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.selectrow(0,false)
tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.selectrow(1,true)
	
end event

event selectionchanged;long ll_handle
integer res
integer li_col, li_i //(Appeon)Stephen 12.08.2015 - V14.2 Applause Cycle 2 Bug # 4870 
		
SetPointer(HourGlass!)

w_mdi.SetRedraw(False)

//------------------- APPEON BEGIN -------------------
//$<modify> Michael 10.27.2011
//$<reason> V12.1 Migrate AI addtl filters
/*
If w_mdi.menuname <> 'm_pfe_cst_action_items' Then 
	w_mdi.ChangeMenu( m_pfe_cst_action_items )
	if gb_contract_version then
		m_pfe_cst_action_items.m_view.m_addtlfilters.toolbaritemvisible = false
	end if
else
	if gb_contract_version then
		m_pfe_cst_action_items.m_view.m_addtlfilters.toolbaritemvisible = false
	end if
end if
*/
If w_mdi.menuname <> 'm_pfe_cst_action_items' Then 
	w_mdi.ChangeMenu( m_pfe_cst_action_items )
	
	//Refresh toolbar for Web Version. Added by Appeon long.zhang 01.08.2016 (BugL010804)
	ll_handle = handle(w_mdi)
	
	gnv_appeondll.of_settoolbarpos(ll_handle)	
end if
//------------------- APPEON END ---------------------

//set user; facility; filter dws visible
choose case newindex
	case 1 //graphs
		dw_user.Visible = True
		dw_select_org_facility.Visible = True
		st_filter.Visible = False
		ddplb_filters.Visible = False
		//dw_filter.visible = true //add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		if gs_cust_type = "I" then
			of_filter_visible(False)  //Start Code Change ----03.30.2016 #V15 maha --App exception
		else
			of_filter_visible(true)  //Start Code Change ----02.28.2013 #V12 maha
		end if
	case 2 //details
		dw_user.Visible = True
		dw_select_org_facility.Visible = True
		st_filter.Visible = True
		ddplb_filters.Visible = True
		tab_1.tabpage_detail.tab_view.SelectedTab = 1 
		//dw_filter.visible = true //add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		 //Start Code Change ----01.13.2017 #V153 maha - readded to details for app
		 of_filter_visible(true)
//		if gs_cust_type = "I" then
//			of_filter_visible(false)  //Start Code Change ----03.30.2016 #V15 maha --App exception
//		else
//			of_filter_visible(true)  //Start Code Change ----02.28.2013 #V12 maha
//		end if
		 //End Code Change ----01.13.2017
	case 3 //committees
		//dw_user.Visible = True
		dw_user.Visible = false	//04.29.2008 By Jervis
		dw_select_org_facility.Visible = True
		st_filter.Visible = False
		ddplb_filters.Visible = False
		//dw_filter.visible = true //add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		if gs_cust_type = "I" then
			of_filter_visible(False)  //Start Code Change ----03.30.2016 #V15 maha --App exception
		else
			of_filter_visible(true)  //Start Code Change ----02.28.2013 #V12 maha
		end if
	case 4 //applications
		dw_user.Visible =  true   //Start Code Change ----08.03.2015 #V15 maha - from False
		dw_select_org_facility.Visible = true   //Start Code Change ----07.30.2015 #V15 maha - from False
		st_filter.Visible = False
		ddplb_filters.Visible = False
		//dw_filter.visible = false //add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		of_filter_visible(false)  //Start Code Change ----02.28.2013 #V12 maha
	case 5
		dw_user.Visible = False
		dw_select_org_facility.Visible =  False
		st_filter.Visible = False
		ddplb_filters.Visible = False
		//dw_filter.visible = false //add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		of_filter_visible(false)  //Start Code Change ----02.28.2013 #V12 maha
	case 6
		dw_user.Visible = False
		dw_select_org_facility.Visible = False
		st_filter.Visible = False
		ddplb_filters.Visible = False
		dw_filter.visible = false//add by Michael 10.25.2011 V12.1 Migrate AI addtl filters
		of_filter_visible(False)  //Start Code Change ----02.28.2013 #V12 maha
end choose

//Start Code Change ----02.03.2010 #V10 maha - rebuilt all the if statements into a single case statement to clarify and correct some enabled issues
choose case newindex
	case 1,2
		//debugbreak()
		inv_action_items.of_enable_action_menu( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse,"1",newindex ) //Start Code Change ----02.02.2010 #V10 maha
		m_pfe_cst_action_items.m_action.m_printallletters.tag = ''
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname= 'Custom002!'
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'toolbaritemname', 'Custom002!')
		//---------End Modfiied ------------------------------------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False )
		w_mdi.SetToolbarPos ( 3, 1, 200, False )
	case 3
		inv_action_items.of_enable_action_menu( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse,"1",3 ) 
		dw_select_org_facility.DeleteRow( 0 )
		dw_select_org_facility.InsertRow( 1 )
		dw_select_org_facility.SetItem( 1, "facility_id", 0 )
		of_get_ready_for_committee()
		of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready)
		of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm)
		m_pfe_cst_action_items.m_action.m_printallletters.tag = ''
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname= 'Custom002!'
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'toolbaritemname', 'Custom002!')
		//---------End Modfiied ------------------------------------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False )
		w_mdi.SetToolbarPos ( 3, 1, 200, False )
		
		//---------Begin Added by (Appeon)Stephen 12.08.2015 for V14.2 Applause Cycle 2 Bug # 4870 - Can't use scroll bar when Committee Status is set to Read Only--------
		if ib_check_role = false then
			if w_mdi.of_security_access(310 ) = 1 then
				li_col = long(tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.object.DataWindow.Column.Count)
				for li_i = 1 to li_col
					tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.modify("#"+string(li_i)+".tabsequence='0'")
				next	
				
				li_col = long(tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.object.DataWindow.Column.Count)
				for li_i = 1 to li_col
					tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.modify("#"+string(li_i)+".tabsequence='0'")
				next					
			end if
			ib_check_role = true
		end if
		//---------End Added ------------------------------------------------------

	case 4
		of_net_dev_ai_menu() 
	
		if ib_netdev_retr = false then
			tab_1.tabpage_net_dev.uo_net_dev.of_set_facility_id( ii_facility_id )   //Start Code Change ----07.30.2015 maha - change from 0
			tab_1.tabpage_net_dev.uo_net_dev.ib_retr_for_aciton_item = true  
			 //Start Code Change ----07.30.2015 #V15 maha
			 inv_action_items.il_facility = ii_facility_id
			inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only, is_user_id)
			//res = tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.Retrieve( gs_user_id )
			//if res < 0 then messagebox("Retreival error","dw_orgs_facilities") //Start Code Change ----10.23.2012 #V12 maha
			//Start Code Change ----07.30.2015
			tab_1.tabpage_net_dev.uo_net_dev.ib_retr_for_aciton_item = false
			postevent( "u_post_selection_changed") 
			ib_netdev_retr = true
		end if
		w_mdi.SetToolbarPos ( 2, 1, 200, False ) //alfee 09.29.2010		
		of_filter_by_intellibatch(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev )
		
		if w_mdi.of_security_access(5200) = 1 then	//added by long.zhang  06.19.2012 for v12.2 app batch update readonly access right
			this.tabpage_net_dev.uo_net_dev.postEvent('pfc_cst_set_security_na')
		end if
	case 5
		ll_handle = handle(w_mdi)
		gnv_appeondll.of_settoolbarpos(ll_handle)
		dw_select_org_facility.Visible = False
		dw_user.Visible = False
		TAb_1.TABpage_contract.uo_1.Tab_1.TABpage_1.DW_1.event pfc_retrieve( )
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_printallletters.Enabled = False
		//m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Contract'
		//m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname = 'Module-Contract- Contact.bmp'
		
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', False)
		m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Contract'
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'toolbaritemname', 'Module-Contract- Contact.bmp')
		//---------End Modfiied ------------------------------------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False )
		w_mdi.SetToolbarPos ( 3, 1, 200, False )
	case 6
		dw_select_org_facility.Visible = False
		dw_user.Visible = False
		TAb_1.Tabpage_document_manager.Tab_1.TABpage_1.DW_1.event pfc_retrieve( )
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_printallletters.Enabled = False
		//m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Document'
		//m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname = 'Module-Contract- Contact.bmp'
		
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', False)
		m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Document'
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'toolbaritemname', 'Module-Contract- Contact.bmp')
		//---------End Modfiied ------------------------------------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False )
		w_mdi.SetToolbarPos ( 3, 1, 200, False )
end choose

w_mdi.of_menu_security( w_mdi.MenuName )
if newindex = 4 then w_mdi.of_menu_shrink_action_items( )  //(Appeon)Alfee 08.06.2013 - V141 ISG-CLX
w_mdi.SetRedraw(True)
//------------------- APPEON BEGIN -------------------
//$<add> Kater 04.01.2011
//$<reason> SetToolbarPos
w_mdi.SetToolbarPos ( 2, 1, 200, False )
w_mdi.SetToolbarPos ( 3, 1, 200, False )
//------------------- APPEON END ---------------------

of_buttons_prop( newindex)  //Start Code Change ----02.12.2016 #V15 maha
if newindex = 5 or newindex = 6 then of_enable_action_buttons( )  //Start Code Change ----02.16.2016 #V15 maha

////Hide toolbar 2&3, Added by Appeon long.zhang 03.23.2016 (V15.1 Bug # 5060 - Action Items: Application Status - Batch update button is missing)
//If appeongetclienttype() <> 'PB' Then 
//	ll_handle = handle(w_mdi)
//	gnv_appeondll.of_SetToolbar(ll_handle,2, False )
//	gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//End If
	
//tab specific menus and actions
//IF newindex = 1 THEN // Graphs
//	m_pfe_cst_action_items.m_action.m_printallletters.Enabled = False
//	m_pfe_cst_action_items.m_action.m_exportdata.Enabled = False
//	m_pfe_cst_action_items.m_action.m_connecttoweb.Enabled = False
//	m_pfe_cst_action_items.m_action.m_phonedialer.Enabled = False	
//	m_pfe_cst_action_items.m_action.m_editverificationdata.Enabled = False
//	m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = False //Start Code Change ----02.02.2010 #V10 maha
//ELSE
//	inv_action_items.of_enable_action_menu( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse,"1",newindex )	
//END IF
//
//IF newindex = 2 THEN // batch update tool
//	m_pfe_cst_action_items.m_action.m_batchresponse.Enabled = True
//ELSE
//	m_pfe_cst_action_items.m_action.m_batchresponse.Enabled = False	
//END IF
//
//IF newindex = 3 THEN  //Committee
//	dw_select_org_facility.DeleteRow( 0 )
//	dw_select_org_facility.InsertRow( 1 )
//	dw_select_org_facility.SetItem( 1, "facility_id", 0 )
//	of_get_ready_for_committee()
//	of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready)
//	of_filter_by_intellibatch(tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm)
//end if
//
//IF newindex = 4 THEN //Application Status
//	of_net_dev_ai_menu() 
//	
//	if ib_netdev_retr = false then
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_facility_id( 0 )
//		tab_1.tabpage_net_dev.uo_net_dev.ib_retr_for_aciton_item = true
//		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.Retrieve( gs_user_id )
//		tab_1.tabpage_net_dev.uo_net_dev.ib_retr_for_aciton_item = false
//		postevent( "u_post_selection_changed")
//		ib_netdev_retr = true
//	end if
//	
//	of_filter_by_intellibatch(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev)
//ELSE
//	w_mdi.SetToolbarPos ( 2, 1, 200, False )
//	w_mdi.SetToolbarPos ( 3, 1, 200, False )
//	inv_action_items.of_enable_action_menu( +&
//	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse , dw_select_org_facility.GetText() , newindex) 
//END IF
//
////Contracts code
//ll_handle = handle(w_mdi)
//gnv_appeondll.of_settoolbarpos(ll_handle)
//
//IF newindex = 5  THEN
//	dw_select_org_facility.Visible = False
//	dw_user.Visible = False
//   TAb_1.TABpage_contract.uo_1.Tab_1.TABpage_1.DW_1.event pfc_retrieve( )
//elseif newindex = 6 then
//	dw_select_org_facility.Visible = False
//	dw_user.Visible = False
//   TAb_1.Tabpage_document_manager.Tab_1.TABpage_1.DW_1.event pfc_retrieve( )
//end if
	
// the following code is needed o that we know for sure that we are in the contract module or not
//if newindex = 5 then
//	m_pfe_cst_action_items.m_action.m_printallletters.Enabled = False
//	m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Contract'
//	m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname = 'Module-Contract- Contact.bmp'
//elseif newindex = 6 then
//	m_pfe_cst_action_items.m_action.m_printallletters.Enabled = False
//	m_pfe_cst_action_items.m_action.m_printallletters.tag = 'Document'
//	m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname = 'Module-Contract- Contact.bmp'
//else 
//	if w_mdi.menuname = 'm_pfe_cst_action_items' then 
//	m_pfe_cst_action_items.m_action.m_printallletters.tag = ''
//	m_pfe_cst_action_items.m_action.m_printallletters.toolbaritemname= 'Custom002!'
//	end if
//
//end if 



//w_mdi.of_menu_security( w_mdi.MenuName )
//w_mdi.SetRedraw(True)
end event

event selectionchanging;IF Parent.Event pfc_save() < 0 THEN
	Return 1
END IF
end event

event constructor;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 25 October 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//Start Code Change ----07.06.2011 #V11 maha - moved to window open event
//inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
//inv_action_items = CREATE pfc_n_cst_ai_action_items 



long ll_count
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.18.2006 By: Cao YongWang
//$<reason> The sys.systable table not exists in SQL Server,
//$<reason> Replace it with v_systable if the appliation running in SQL Server.
/*
select count(*)
into :ll_count
from sys.systable 
where table_name='CTX_BASIC_INFO' ;
*/
Choose Case gs_dbType
	Case 'ASA'
		select count(*) into :ll_count from sys.systable where table_name = 'CTX_BASIC_INFO';
	Case 'SQL'
		select count(*) into :ll_count from v_systable where table_name = 'CTX_BASIC_INFO';
End Choose
//---------------------------- APPEON END ----------------------------

	  
if of_get_app_setting("set_cont","I") = 0 or ll_count < 1 then
		 this.tabpage_contract.visible=  false
	else 
		//this.tabpage_contract.visible=  true
		this.tabpage_contract.uo_1.tab_1.tabpage_1.dw_1.settransobject( sqlca)
		this.tabpage_contract.uo_1.tab_1.of_retrive( )
end if
end event

event destructor;//Destroy inv_action_items //delete Michael 12.07.2011 moved to w_action_items.open by Mike
Destroy inv_action_items //add Michael 12.14.2011
end event

type tabpage_analysis from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
long backcolor = 33551856
string text = "Analysis"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
tab_analysis tab_analysis
st_msg st_msg
cb_refresh cb_refresh
end type

on tabpage_analysis.create
this.tab_analysis=create tab_analysis
this.st_msg=create st_msg
this.cb_refresh=create cb_refresh
this.Control[]={this.tab_analysis,&
this.st_msg,&
this.cb_refresh}
end on

on tabpage_analysis.destroy
destroy(this.tab_analysis)
destroy(this.st_msg)
destroy(this.cb_refresh)
end on

type tab_analysis from tab within tabpage_analysis
event create ( )
event destroy ( )
integer y = 252
integer width = 4503
integer height = 1576
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean createondemand = true
integer selectedtab = 1
tabpage_last_attempt tabpage_last_attempt
tabpage_total_attempts tabpage_total_attempts
tabpage_expiring_credentials tabpage_expiring_credentials
tabpage_exp_appointments tabpage_exp_appointments
tabpage_audit tabpage_audit
tabpage_process tabpage_process
end type

on tab_analysis.create
this.tabpage_last_attempt=create tabpage_last_attempt
this.tabpage_total_attempts=create tabpage_total_attempts
this.tabpage_expiring_credentials=create tabpage_expiring_credentials
this.tabpage_exp_appointments=create tabpage_exp_appointments
this.tabpage_audit=create tabpage_audit
this.tabpage_process=create tabpage_process
this.Control[]={this.tabpage_last_attempt,&
this.tabpage_total_attempts,&
this.tabpage_expiring_credentials,&
this.tabpage_exp_appointments,&
this.tabpage_audit,&
this.tabpage_process}
end on

on tab_analysis.destroy
destroy(this.tabpage_last_attempt)
destroy(this.tabpage_total_attempts)
destroy(this.tabpage_expiring_credentials)
destroy(this.tabpage_exp_appointments)
destroy(this.tabpage_audit)
destroy(this.tabpage_process)
end on

event selectionchanged;//st_msg.Visible = False //removed maha 072303

//CHOOSE CASE newindex
	of_graph_case(newindex)
//	CASE 1
//		
//		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
//	CASE 2
////		tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.SetRedraw ( false )
////		IF tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.RowCount() = 0 THEN
////			tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.Event pfc_retrieve()
////		end if
//		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts, is_user_id )
//	//	tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.SetRedraw ( true )
//	CASE 3
////		tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.SetRedraw ( false )
////		IF tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.RowCount() = 0 THEN
////			tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.Event pfc_retrieve()
////		end if
//		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph, is_user_id )
////		tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.SetRedraw ( true )
//	CASE 4
////		IF tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.RowCount() = 0 THEN
////			tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.Event pfc_retrieve()
////		end if
//			inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph, is_user_id )
//			
//	CASE 5
////		IF tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.RowCount() = 0 THEN
////				tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.Event pfc_retrieve()
////		end if
//			inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph, is_user_id )
		
//END CHOOSE
end event

type tabpage_last_attempt from userobject within tab_analysis
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Verification Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_last_attemp_graph dw_last_attemp_graph
end type

on tabpage_last_attempt.create
this.dw_last_attemp_graph=create dw_last_attemp_graph
this.Control[]={this.dw_last_attemp_graph}
end on

on tabpage_last_attempt.destroy
destroy(this.dw_last_attemp_graph)
end on

type dw_last_attemp_graph from u_dw within tabpage_last_attempt
integer width = 4462
integer height = 1452
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_verification_graph_by_last_attemp_sum"
end type

event constructor;This.of_SetUpdateable(False)

//Start Code Change ----04.26.2016 #V15 maha
//Start Code Change ----05.03.2016 #V15 maha - added trap for App
if  gs_cust_type =  "I" then
	//don't change for App
else
	if gs_dbtype = "ASA" then 
		this.dataobject = "d_verification_graph_by_last_attemp_sum_asa"
	end if
end if
//End Code Change ----05.03.2016
//End Code Change ----04.26.2016

This.of_SetTransObject( SQLCA )
//This.of_Retrieve( )
end event

event doubleclicked;Integer SeriesNbr
Integer ItemNbr
Long ll_ver_method
String ls_series_name
String ls_category_name
String ls_where, ls_sql
String ls_from, ls_to

double data_value

grObjectType MouseHit

MouseHit = This.ObjectAtPointer("gr_1", SeriesNbr, ItemNbr)

data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
ls_category_name = This.CategoryName("gr_1", ItemNbr)
ls_series_name = This.SeriesName("gr_1", SeriesNbr)

IF MouseHit = 	TypeCategory!  THEN
	IF is_current_graph = "last_attempt" THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-09
		//$<modify> 03.03.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.

		/*
		SELECT code_lookup.lookup_code  
	   INTO :ll_ver_method  
   	FROM code_lookup  
	   WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
   	      ( code_lookup.code = :ls_category_name  )   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
			RETURN -1
		END IF
		*/
		ll_ver_method = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", &
		"upper(lookup_name) = upper('verification method') and upper(code) = '" + upper(ls_category_name) + "'"))
		//---------------------------- APPEON END ----------------------------
	  	ls_where = " AND (verif_info.verification_method = " + String( ll_ver_method ) + ")"			
	END IF
ELSEIF MouseHit = TypeData! THEN
	data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
	ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
	ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))
	CHOOSE CASE ls_category_name 
		CASE "FAX"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 1
					ddplb_filters.SelectItem( 1 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 8
					ddplb_filters.SelectItem( 8 )					
			END CHOOSE			
		CASE "EXP APPT LTR"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 3
					ddplb_filters.SelectItem( 3 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 11
					ddplb_filters.SelectItem( 11 )
			END CHOOSE
		CASE "VERIF LTR"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 1
					ddplb_filters.SelectItem( 1 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 8
					ddplb_filters.SelectItem( 8 )					
			END CHOOSE
		CASE "IVERIFY"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 24
					ddplb_filters.SelectItem( 24 )
			END CHOOSE
			
		CASE "EXP CRED LTR"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 2
					ddplb_filters.SelectItem( 2 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 9
					ddplb_filters.SelectItem( 9 )					
			END CHOOSE
		CASE "PRAC CORRE"
			CHOOSE CASE ls_series_name 
				CASE " NEED PROCESSED"
					ii_filter_index = 6
					ddplb_filters.SelectItem( 6 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 10
					ddplb_filters.SelectItem( 10 )					
			END CHOOSE			
		CASE "COMPENDIUM"
			CHOOSE CASE Upper( ls_series_name )
				CASE " NEED PROCESSED"
					ii_filter_index = 16
					ddplb_filters.SelectItem( 16 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 16
					ddplb_filters.SelectItem( 16 )													
				END CHOOSE								
		CASE "CALL"
			CHOOSE CASE Upper( ls_series_name )
				CASE " NEED PROCESSED"
					ii_filter_index = 15
					ddplb_filters.SelectItem( 15 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 15
					ddplb_filters.SelectItem( 15 )										
			END CHOOSE			
		CASE "WEB"
			CHOOSE CASE Upper( ls_series_name )
				CASE " NEED PROCESSED"
					ii_filter_index = 14
					ddplb_filters.SelectItem( 14 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 33
					ddplb_filters.SelectItem( 33 )	
			END CHOOSE			
		CASE "NPDB QUERY"
			CHOOSE CASE Upper( ls_series_name )
				CASE " NEED PROCESSED"
					ii_filter_index = 12
					ddplb_filters.SelectItem( 12 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 13
					ddplb_filters.SelectItem( 13 )
			END CHOOSE
		CASE "OIG QUERY"
			CHOOSE CASE Upper( ls_series_name )
				CASE " NEED PROCESSED"
					ii_filter_index = 25
					ddplb_filters.SelectItem( 25 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 26
					ddplb_filters.SelectItem( 26 )
			END CHOOSE
					
		CASE "HARD COPY"  //maha 032703
					ii_filter_index = 17
					ddplb_filters.SelectItem( 17 )
		/////////////////////////////////////////////				
		// MSKINNER 1 Feb 2005 -- begin
		CASE "NPDB/HIPDB"
			//n_cst_npdb LNVO
			CHOOSE CASE trim(Upper(ls_series_name))
				CASE "NEED PROCESSED" //print flag =1 
//					if messagebox('ITP Send','Do you want to send NEED PROCESSED records to the npdb?',Question!,yesno!,1) = 1 then
//					 	LNVO.of_start_npdb(lnvo.is_send)
//					end if
					ii_filter_index = 12
					ddplb_filters.SelectItem(12)
				CASE "AWAITING RESPONSE" //print flag =0 
					// do the recieve functionality
//					if messagebox('ITP Send','Do you want to recieve AWAITING RESPONSE records from the npdb?',Question!,yesno!,1) = 1 then
//					  LNVO.of_start_npdb(lnvo.is_recieve)
//				   end if
					ii_filter_index = 13
					ddplb_filters.SelectItem(13)
			END CHOOSE
		//Start Code Change ---- 10.25.2006 #1 maha
		CASE "MISS ITEM 90"
			CHOOSE CASE trim(Upper(ls_series_name))
				CASE "NEED PROCESSED" //print flag =1 
//					if messagebox('ITP Send','Do you want to send NEED PROCESSED records to the npdb?',Question!,yesno!,1) = 1 then
//					 	LNVO.of_start_npdb(lnvo.is_send)
//					end if
					ii_filter_index = 31
					ddplb_filters.SelectItem(31)
				CASE "AWAITING RESPONSE" //print flag =0 
					// do the recieve functionality
//					if messagebox('ITP Send','Do you want to recieve AWAITING RESPONSE records from the npdb?',Question!,yesno!,1) = 1 then
//					  LNVO.of_start_npdb(lnvo.is_recieve)
//				   end if
					ii_filter_index = 32
					ddplb_filters.SelectItem(32)
			END CHOOSE
		//Start Code Change ----06.01.2016 #V152 maha
		CASE "AMA API"
			ii_filter_index = 36
			ddplb_filters.SelectItem(36)
		//End Code Change ----06.01.2016
		//End Code Change---10.28.2006
		// MSKINNER 1 Feb 2005 -- end
		//Start Code Change ----12.07.2017 #V16 maha
		CASE ELSE
			ii_filter_index = 37
			ddplb_filters.SelectItem(37)
			is_other_method = ls_category_name
		//End Code Change ----12.07.2017 	
		//	RETURN 1
	END CHOOSE
ELSE
	RETURN 1
END IF

	//Start Code Change ----07.12.2011 #V11 maha 
	//tab_1.SelectTab( 2 )
	//ddplb_filters.Event SelectionChanged( ii_filter_index )
	of_graph_post_click()
	//End Code Change ----07.12.2011 

end event

event pfc_retrieve;call super::pfc_retrieve;long ll_ret


//----------------------- <RP> modified 4.21.2016---------------------------------------------
long ll_facility_id, ll_screen_id, ll_batch_id
string ls_user_id, ls_apptmnt_type
// Retrieve with arguments rather than filtering at client

if gs_dbtype = "ASA" or gs_cust_type = "I" then   //Start Code Change ----05.03.2016 #V15 maha - added cust type for app
	IF This.DataObject = "d_verification_graph_by_last_attemp_sum_asa" THEN
		ll_ret = This.Retrieve( )
	ELSE
		ll_ret = This.Retrieve( gs_user_id )
	END IF
else //SQL Cred
	IF dw_select_org_facility.rowCount() > 0 THEN
		ll_facility_id = dw_select_org_facility.object.facility_id[1]
	ELSE
		setNull(ll_facility_id)
	END IF
	IF dw_user.rowCount() > 0 THEN
		ls_user_id = dw_user.object.user_id[1]
	END IF
	IF dw_filter.rowCount() > 0 THEN
		ls_apptmnt_type = dw_filter.object.status[1]
		ll_screen_id = dw_filter.object.screen[1]
		ll_batch_id = dw_filter.object.batch[1]
	ELSE
		setNull(ll_screen_id)
		setNull(ll_batch_id)
	END IF
	
	ll_ret = this.retrieve( &
		gs_user_id, &
		ll_facility_id, &
		ls_user_id, &
		ls_apptmnt_type, &
		ll_screen_id, &
		ll_batch_id )
end if

return ll_ret

//prior code
//IF This.DataObject = "d_verification_graph_by_last_attemp" THEN
//	Return This.Retrieve( )
//ELSE
//	Return This.Retrieve( gs_user_id )
//END IF
end event

event getfocus;call super::getfocus;idw_active = This
end event

type tabpage_total_attempts from userobject within tab_analysis
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Verification Attempts"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_total_attempts dw_total_attempts
end type

on tabpage_total_attempts.create
this.dw_total_attempts=create dw_total_attempts
this.Control[]={this.dw_total_attempts}
end on

on tabpage_total_attempts.destroy
destroy(this.dw_total_attempts)
end on

type dw_total_attempts from u_dw within tabpage_total_attempts
integer width = 4462
integer height = 1452
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_verification_graph_by_total_attemp_sum"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

event pfc_retrieve;call super::pfc_retrieve;long ll_ret


//----------------------- <RP> modified 4.21.2016---------------------------------------------
long ll_facility_id, ll_screen_id, ll_batch_id
string ls_user_id, ls_apptmnt_type
// Retrieve with arguments rather than filtering at client
//
//Return This.Retrieve(gs_user_id)
//
IF dw_select_org_facility.rowCount() > 0 THEN
	ll_facility_id = dw_select_org_facility.object.facility_id[1]
ELSE
	setNull(ll_facility_id)
END IF
IF dw_user.rowCount() > 0 THEN
	ls_user_id = dw_user.object.user_id[1]
END IF
IF dw_filter.rowCount() > 0 THEN
	ls_apptmnt_type = dw_filter.object.status[1]
	ll_screen_id = dw_filter.object.screen[1]
	ll_batch_id = dw_filter.object.batch[1]
ELSE
	setNull(ll_screen_id)
	setNull(ll_batch_id)
END IF

ll_ret = this.retrieve( &
	gs_user_id, &
	ll_facility_id, &
	ls_user_id, &
	ls_apptmnt_type, &
	ll_screen_id, &
	ll_batch_id &
)

return ll_ret


//prior code
//Return This.Retrieve(gs_user_id)
end event

event getfocus;call super::getfocus;idw_active = This
end event

event doubleclicked;call super::doubleclicked;

Integer SeriesNbr
Integer ItemNbr
Long ll_ver_method
String ls_series_name
String ls_category_name
String ls_where, ls_sql
String ls_from, ls_to

double data_value

grObjectType MouseHit

MouseHit = This.ObjectAtPointer("gr_1", SeriesNbr, ItemNbr)

data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
ls_category_name = This.CategoryName("gr_1", ItemNbr)
ls_series_name = This.SeriesName("gr_1", SeriesNbr)
debugbreak()
//IF MouseHit = 	TypeCategory!  THEN
//	IF is_current_graph = "last_attempt" THEN
//		SELECT code_lookup.lookup_code  
//	   INTO :ll_ver_method  
//   	FROM code_lookup  
//	   WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
//   	      ( code_lookup.code = :ls_category_name  )   ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
//			RETURN -1
//		END IF
//	  	ls_where = " AND (verif_info.verification_method = " + String( ll_ver_method ) + ")"			
//	END IF
//ELSE
	IF MouseHit = TypeData! THEN
	data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
	ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
	ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))
	CHOOSE CASE ls_category_name 
		CASE "EXP APPT LTR"
			//CHOOSE CASE ls_series_name 
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 3
			//		ddplb_filters.SelectItem( 3 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 11
					ddplb_filters.SelectItem( 11 )
			//END CHOOSE
		CASE "VERIF LTR"
			//CHOOSE CASE ls_series_name 
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 1
			//		ddplb_filters.SelectItem( 1 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 8
					ddplb_filters.SelectItem( 8 )					
			//END CHOOSE
		CASE "IVERIFY"
			//CHOOSE CASE ls_series_name 
			//	CASE " NEED PROCESSED"
					ii_filter_index = 24
					ddplb_filters.SelectItem( 24 )
			//END CHOOSE
			
		CASE "EXP CRED LTR"
			//CHOOSE CASE ls_series_name 
				//CASE " NEED PROCESSED"
				///	ii_filter_index = 2
				//	ddplb_filters.SelectItem( 2 )
				//CASE "AWAITING RESPONSE"
					ii_filter_index = 9
					ddplb_filters.SelectItem( 9 )					
			//END CHOOSE
		CASE "PRAC CORRE"
			//CHOOSE CASE ls_series_name 
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 4
			//		ddplb_filters.SelectItem( 4 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 10
					ddplb_filters.SelectItem( 10 )					
			//END CHOOSE			
		CASE "COMPENDIUM"
			//CHOOSE CASE Upper( ls_series_name )
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 16
			//		ddplb_filters.SelectItem( 16 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 16
					ddplb_filters.SelectItem( 16 )													
			//	END CHOOSE								
		CASE "CALL"
			//CHOOSE CASE Upper( ls_series_name )
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 15
			//		ddplb_filters.SelectItem( 15 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 15
					ddplb_filters.SelectItem( 15 )										
			//END CHOOSE			
		CASE "WEB"
		//	CHOOSE CASE Upper( ls_series_name )
			//	CASE " NEED PROCESSED"
					ii_filter_index = 14
					ddplb_filters.SelectItem( 14 )
			//END CHOOSE			
		CASE "NPDB QUERY"
			//CHOOSE CASE Upper( ls_series_name )
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 12
			//		ddplb_filters.SelectItem( 12 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 13
					ddplb_filters.SelectItem( 13 )
			//END CHOOSE
		CASE "OIG QUERY"
			//CHOOSE CASE Upper( ls_series_name )
			//	CASE " NEED PROCESSED"
			//		ii_filter_index = 25
			//		ddplb_filters.SelectItem( 25 )
			//	CASE "AWAITING RESPONSE"
					ii_filter_index = 26
					ddplb_filters.SelectItem( 26 )
			//END CHOOSE
					
		CASE "HARD COPY"  //maha 032703
					ii_filter_index = 17
					ddplb_filters.SelectItem( 17 )
						
			
		CASE ELSE
			RETURN 1
	END CHOOSE

	//Start Code Change ----07.12.2011 #V11 maha 
	//tab_1.SelectTab( 2 )
	//ddplb_filters.Event SelectionChanged( ii_filter_index )
	of_graph_post_click()
	//End Code Change ----07.12.2011 


ELSE
	RETURN 1
END IF


end event

type tabpage_expiring_credentials from userobject within tab_analysis
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Expiring Credentials"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_expiring_credential_graph dw_expiring_credential_graph
end type

on tabpage_expiring_credentials.create
this.dw_expiring_credential_graph=create dw_expiring_credential_graph
this.Control[]={this.dw_expiring_credential_graph}
end on

on tabpage_expiring_credentials.destroy
destroy(this.dw_expiring_credential_graph)
end on

type dw_expiring_credential_graph from u_dw within tabpage_expiring_credentials
integer width = 4462
integer height = 1452
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_expiring_credentials_graph"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( Today(),gs_user_id )
end event

event getfocus;call super::getfocus;idw_active = This
end event

event doubleclicked;call super::doubleclicked;//maha 072303

ii_filter_index = 19
//Start Code Change ----07.12.2011 #V11 maha 
ddplb_filters.SelectItem(19)
//is_filter = ddplb_filters.Text
//
//tab_1.SelectTab(2)
//inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
of_graph_post_click()
//End Code Change ----07.12.2011

end event

type tabpage_exp_appointments from userobject within tab_analysis
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Expiring Appointments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_expiring_appointments_graph dw_expiring_appointments_graph
end type

on tabpage_exp_appointments.create
this.dw_expiring_appointments_graph=create dw_expiring_appointments_graph
this.Control[]={this.dw_expiring_appointments_graph}
end on

on tabpage_exp_appointments.destroy
destroy(this.dw_expiring_appointments_graph)
end on

type dw_expiring_appointments_graph from u_dw within tabpage_exp_appointments
integer width = 4462
integer height = 1452
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_expiring_appointments"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

event getfocus;call super::getfocus;idw_active = This
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( Today(),gs_user_id)
end event

event doubleclicked;ii_filter_index = 18
//Start Code Change ----07.12.2011 #V11 maha 
ddplb_filters.SelectItem(18)
//is_filter = ddplb_filters.Text
//tab_1.SelectTab(2)
//inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
of_graph_post_click()
	//End Code Change ----07.12.2011





end event

type tabpage_audit from userobject within tab_analysis
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Missing Checklist"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_app_audit_graph dw_app_audit_graph
end type

on tabpage_audit.create
this.dw_app_audit_graph=create dw_app_audit_graph
this.Control[]={this.dw_app_audit_graph}
end on

on tabpage_audit.destroy
destroy(this.dw_app_audit_graph)
end on

type dw_app_audit_graph from u_dw within tabpage_audit
integer width = 4462
integer height = 1452
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_app_audit_graph"
end type

event doubleclicked;call super::doubleclicked;
// mskinner 20 dec 2005 -- begin
if dw_app_audit_graph.rowcount() < 1 then return 0
// mskinner 20 dec 2005 -- end


//Start Code Change ----07.12.2011 #V11 maha 
ii_filter_index = 27
ddplb_filters.SelectItem(27)
//is_filter = ddplb_filters.Text
of_graph_post_click()
//tab_1.SelectTab(2)
//inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
//End Code Change ----07.12.2011

end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( gs_user_id)
end event

event constructor;call super::constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

type tabpage_process from userobject within tab_analysis
integer x = 18
integer y = 100
integer width = 4466
integer height = 1460
long backcolor = 33551856
string text = "Process Tracking"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_process_graph dw_process_graph
end type

on tabpage_process.create
this.dw_process_graph=create dw_process_graph
this.Control[]={this.dw_process_graph}
end on

on tabpage_process.destroy
destroy(this.dw_process_graph)
end on

type dw_process_graph from u_dw within tabpage_process
integer width = 4462
integer height = 1452
integer taborder = 11
string dataobject = "d_process_graph"
end type

event getfocus;call super::getfocus;idw_active = This
end event

event doubleclicked;call super::doubleclicked;//
//ii_filter_index = 34
//ddplb_filters.SelectItem(34)
//
//of_graph_post_click()
//return 1



Integer SeriesNbr
Integer ItemNbr
Long ll_ver_method
String ls_series_name
String ls_category_name
String ls_where, ls_sql
String ls_from, ls_to
double data_value
grObjectType MouseHit

MouseHit = This.ObjectAtPointer("gr_1", SeriesNbr, ItemNbr)

IF MouseHit = 	TypeCategory!  THEN
 //nothing
ELSEIF MouseHit = Typedata! THEN
	data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
	ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
	ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))
	CHOOSE CASE ls_category_name 
		CASE "LETTER"
			CHOOSE CASE upper(ls_series_name )
				CASE " NEEDS PROCESSING"
					ii_filter_index = 34
					ddplb_filters.SelectItem( 34 )
				CASE "AWAITING RESPONSE"
					ii_filter_index = 35
					ddplb_filters.SelectItem( 35 )					
			END CHOOSE			


	END CHOOSE
ELSE
	RETURN 1
END IF

of_graph_post_click()




end event

type st_msg from statictext within tabpage_analysis
integer x = 32
integer y = 184
integer width = 2363
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Double click graph to view detail"
boolean focusrectangle = false
end type

type cb_refresh from commandbutton within tabpage_analysis
integer x = 3378
integer y = 252
integer width = 343
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;integer t

t = tab_analysis.selectedtab
of_graph_case(t)
end event

type tabpage_detail from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
long backcolor = 33551856
string text = "Action Item Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
cbx_preserve cbx_preserve
cbx_add_missing cbx_add_missing
tab_view tab_view
sle_doc_find sle_doc_find
cb_find cb_find
st_find st_find
cb_init_recred cb_init_recred
st_1 st_1
cb_recred_no_ver cb_recred_no_ver
dw_tracker dw_tracker
cbx_priv cbx_priv
end type

on tabpage_detail.create
this.cbx_preserve=create cbx_preserve
this.cbx_add_missing=create cbx_add_missing
this.tab_view=create tab_view
this.sle_doc_find=create sle_doc_find
this.cb_find=create cb_find
this.st_find=create st_find
this.cb_init_recred=create cb_init_recred
this.st_1=create st_1
this.cb_recred_no_ver=create cb_recred_no_ver
this.dw_tracker=create dw_tracker
this.cbx_priv=create cbx_priv
this.Control[]={this.cbx_preserve,&
this.cbx_add_missing,&
this.tab_view,&
this.sle_doc_find,&
this.cb_find,&
this.st_find,&
this.cb_init_recred,&
this.st_1,&
this.cb_recred_no_ver,&
this.dw_tracker,&
this.cbx_priv}
end on

on tabpage_detail.destroy
destroy(this.cbx_preserve)
destroy(this.cbx_add_missing)
destroy(this.tab_view)
destroy(this.sle_doc_find)
destroy(this.cb_find)
destroy(this.st_find)
destroy(this.cb_init_recred)
destroy(this.st_1)
destroy(this.cb_recred_no_ver)
destroy(this.dw_tracker)
destroy(this.cbx_priv)
end on

type cbx_preserve from checkbox within tabpage_detail
boolean visible = false
integer x = 1097
integer y = 144
integer width = 608
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Keep EXP APPT Active"
end type

event clicked;//if this.checked then  //Start Code Change ----08.31.2017 #V154 maha - removed
//	gb_preserve_exp_appt_verif = true
//else
//	gb_preserve_exp_appt_verif = false
//end if
end event

event constructor;if gb_preserve_exp_appt_verif = true then this.checked = true   //Start Code Change ----07.22.2015 #V15 maha
end event

type cbx_add_missing from checkbox within tabpage_detail
boolean visible = false
integer x = 1097
integer y = 80
integer width = 562
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Add Missing Verifs"
boolean checked = true
end type

type tab_view from tab within tabpage_detail
event create ( )
event destroy ( )
integer y = 212
integer width = 4498
integer height = 1620
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
tabpage_browse tabpage_browse
tabpage_details tabpage_details
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_details=create tabpage_details
this.Control[]={this.tabpage_browse,&
this.tabpage_details}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_details)
end on

event selectionchanging;
Long ll_prac_id
Long ll_rec_id 
Integer li_parent_facility_id
Integer li_v_facility_id
Integer li_data_view_id
Integer li_screen_id 
Integer li_len
Integer i
Integer li_cr
integer li_rc //maha 090401
integer v  //maha 090401
integer t  //maha 090401
long ll_test1  //maha 090401
long ll_test2  //maha 090401
integer del
Boolean ib_found = False
String ls_full_name
String ls_val
Long ll_exp_appt_ltr


if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.rowcount() < 1 then//maha 101200 error trap
	tabpage_details.dw_detail.Reset()
	tabpage_details.st_name.text = ""   //(Appeon)Stephen 08.14.2014 - IC - Action Items Issue - Issue #6
	return  
end if

IF oldindex = 1 AND newindex = 1 THEN
	Return
END IF

if tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.dataobject = "d_app_audit_missing_ai" then
	of_get_items_list()
	tabpage_details.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.13.2017 #V154 maha
	return	
end if

cb_recred_no_ver.Visible = false
cb_init_recred.Visible = False
cbx_priv.Visible = false
cbx_add_missing.Visible = false  //End Code Change---03.04.2009
IF oldindex = 1 Then
	li_cr = tabpage_browse.dw_browse.GetRow()
	IF Upper( tabpage_browse.dw_browse.GetItemString( li_cr, "reference_value" ) ) = "NPDB QUERY" THEN
		MessageBox( "Detail", "There is no detail for the selected entry" )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.29.2006 By: LeiWei
		//$<reason> Fix a defect
		cb_recred_no_ver.Visible = true
		cb_init_recred.Visible = true
		cbx_priv.Visible = true
		cbx_add_missing.Visible = true  //End Code Change---03.04.2009
		//---------------------------- APPEON END ----------------------------
		Return 1
	END IF	
	st_filter.Visible = False
	ddplb_filters.Visible = False
	dw_user.Visible = False
	dw_select_org_facility.Visible = False
	sle_doc_find.Visible = False
	st_find.Visible = False
	cb_find.Visible = False
	ib_data_entry = false //added by long.zhang 09.29.2012
	IF tabpage_browse.dw_browse.GetRow() > 0 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-10
		//$<modify> 03.03.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.

		/*		
		SELECT code_lookup.lookup_code  
		INTO :ll_exp_appt_ltr
		FROM code_lookup  
		WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
  	   	( code_lookup.code = 'EXP APPT LTR'  )   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
			RETURN -1
		END IF
		*/
		
		ll_exp_appt_ltr = Long(gnv_data.of_getitem("code_lookup","lookup_code", "upper(lookup_name) = upper('verification method') and upper(code) = upper('EXP APPT LTR')"))
		
		//---------------------------- APPEON END ----------------------------
		ll_rec_id = tabpage_browse.dw_browse.GetItemNumber( li_cr, "rec_id" )
		ll_prac_id = tabpage_browse.dw_browse.GetItemNumber( li_cr, "prac_id" )
		//exp appointments recred
		IF tabpage_browse.dw_browse.GetItemNumber( li_cr, "verification_method" ) = ll_exp_appt_ltr THEN
			if w_mdi.of_security_access(7798) = 0 then     //Start Code Change ----10.05.2015 #V15 maha - added security
				cb_init_recred.Visible = false
				cb_recred_no_ver.Visible = false
				cbx_priv.Visible = false
				cbx_add_missing.Visible = false
			else
				cb_init_recred.Visible = True
				cb_recred_no_ver.Visible = True
				cbx_priv.Visible = true //maha081403
				cbx_add_missing.Visible = true //End Code Change---03.04.2009
			end if
//Start Code Change ----03.04.2009 #V92 maha	 - corrected to work like pract folder	
			IF tabpage_details.dw_detail.DataObject <> "d_copy_verification" THEN
				tabpage_details.dw_detail.DataObject = "d_copy_verification"
				tabpage_details.dw_detail.of_SetTransObject( SQLCA )
			END IF	
			
			li_v_facility_id = tabpage_browse.dw_browse.GetItemNumber( li_cr, "verif_info_facility_id" )
			//	li_parent_facility_id = tabpage_browse.dw_browse.GetItemNumber( li_cr, "parent_facility_id" )
			
			//debugbreak()
			inv_printletters.of_retrieve_recred(tabpage_details.dw_detail, ll_prac_id,li_v_facility_id )
			
			tabpage_details.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.13.2017 #V154 maha
//			tabpage_details.dw_detail.Retrieve( ll_prac_id,li_parent_facility_id )	
//			//\/maha 090401 test for duplicates and delete from datawindow
//			FOR i = 1 TO li_rc
//				ll_test1 = tabpage_details.dw_detail.GetItemNumber( v, "rec_id" )
//				del = tabpage_details.dw_detail.GetItemNumber( v, "del" )
//				if del = 1 then continue
//				for t = 1 to li_rc
//						ll_test2 = tabpage_details.dw_detail.GetItemNumber( t, "rec_id" )
//						if v <> t and ll_test1 = ll_test2 and isnull(tabpage_details.dw_detail.GetItemnumber( v, "verification_id" )) and isnull(tabpage_details.dw_detail.GetItemnumber( t, "verification_id" )) then
//								tabpage_details.dw_detail.SetItem( t, "del", 1 )
//						end if
//				next
//			next
//			FOR i =  li_rc to 1 step -1
//			if tabpage_details.dw_detail.getItemnumber( i, "del") = 1 then
//				tabpage_details.dw_detail.deleterow(i)
//			end if
//			next
//End Code Change---03.04.2009
		elseif tabpage_browse.dw_browse.GetItemNumber( li_cr, "screen_id" ) = 1 then //all basic info except for exp appt letter.
			MessageBox( "Detail", "There is no detail for the selected entry" )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 04.29.2006 By: LeiWei
			//$<reason> Fix a defect
			st_filter.Visible = True
			ddplb_filters.Visible = True
			dw_user.Visible = True
			dw_select_org_facility.Visible = True
			sle_doc_find.Visible = True
			st_find.Visible = True
			cb_find.Visible = True
			//---------------------------- APPEON END ----------------------------
			Return 1
		ELSE //D.E. detail
			ib_data_entry = true	//added by long.zhang 09.29.2012
			IF tabpage_details.dw_detail.RowCount() = 1 THEN
				IF ll_rec_id = tabpage_details.dw_detail.GetItemNumber( 1, "rec_id" ) THEN
					ib_found = TRUE
					//messagebox("1 ll_rec_id", ll_rec_id)
				END IF
			END IF
			IF NOT ib_found THEN
				if ib_cache = false then
					inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
					inv_data_entry.of_setup_cache()
					inv_data_entry.of_refresh_cache()
					ib_cache = true
				end if
				li_data_view_id = 1
				li_screen_id = tabpage_browse.dw_browse.GetItemNumber( li_cr, "screen_id" )
				inv_data_entry.of_create_dynamic_dw( +&
								ll_prac_id, li_data_view_id, li_screen_id, +&
								tabpage_details.dw_detail, tabpage_details.dw_dummy_browse, False,0, true )				
				 //messagebox("3","after create dynamic " + string(ib_found))				
				sleep(50) //(Appeon)Stephen 09.22.2014 - IC - Action Items Issue - Issue #6
				tabpage_details.dw_detail.SetFilter( "rec_id = " + String( ll_rec_id ) )
				tabpage_details.dw_detail.Filter( )
				if tabpage_details.dw_detail.rowcount() > 0 then //trap added 061804 maha 4.187
					ll_prac_id = tabpage_details.dw_detail.GetItemNumber( 1, "prac_id" )
					
					//---------Begin Added by (Appeon)Stephen 08.14.2014 for IC - Action Items Issue - Issue #6--------
					tabpage_details.setredraw(false)
					sleep(50)
					tabpage_details.setredraw(true)
					//---------End Added ------------------------------------------------------
					
					SELECT v_full_name.full_name  
					INTO :ls_full_name  
					FROM v_full_name  
					WHERE v_full_name.prac_id = :ll_prac_id ;
					li_len = Len( ls_full_name )
					FOR i = 1 TO li_len
						IF Mid( ls_full_name, i, 1 ) = "'" THEN
							ls_full_name = Mid( ls_full_name, 1, i -1 ) + '"' + Mid( ls_full_name, i+1, 100 )
						END IF
					END FOR
					tabpage_details.st_name.text = ls_full_name
					
					tabpage_details.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.13.2017 #V154 maha
				else
					messagebox("Data Error","No data available for the selected record.")
				end if
				//ls_val = tabpage_details.dw_detail.Modify("create text(band=detail alignment='0' text='" + ls_full_name + "' border='0' color='255' x='130' y='10' height='45' width='1000'  name=section_name_t  font.face='Segoe UI' font.height='-8' font.weight='500'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' )")
			END IF
		END IF
	END IF
ELSE
	IF tab_1.SelectedTab <> 1 THEN
		st_filter.Visible = True
		ddplb_filters.Visible = True
	END IF
	dw_user.Visible = True
	dw_select_org_facility.Visible = True
	sle_doc_find.Visible = True
	st_find.Visible = True
	cb_find.Visible = True
END IF
end event

event destructor;if ib_cache = true then
//	DESTROY pfc_cst_nv_data_entry_functions//Start Code Change ----07.06.2011 #V11 maha - moved to window close
end if
end event

type tabpage_browse from userobject within tab_view
integer x = 18
integer y = 100
integer width = 4462
integer height = 1504
long backcolor = 33551856
string text = "Outstanding Action Items"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer width = 4453
integer height = 1504
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view_for_ai_all"
end type

event clicked;call super::clicked;if this.rowcount() < 1 then return

This.ScrollToRow( This.GetClickedRow( ) )
This.SetRow( This.GetClickedRow( ) )

string ls_docid  //maha 08.21.2017

if this.getitemnumber(this.getrow(),"selected") = 1 then
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	//m_pfe_cst_action_items.m_action.m_batchresponse.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_batchresponse,'Enabled', True)
	//---------End Modfiied ------------------------------------------------------
end if

//Start Code Change ----10.24.2016 #V153 maha - moved from buttonclicked event
IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
	Long ll_verification_id
	gs_pass_ids ls_pass_ids
	integer li_type
	string ls_file
	long ll_ver_method //maha 10.24.2016
	long ll_facil  //maha 10.24.2016
	string ls_ext  //maha 10.24.2016
	gs_pass_ids lst_ids
	//messagebox(string(row), "ff")
	li_type = this.GetItemNumber( row,"verification_picture_flag")
	choose case li_type
		//case 1 = HTML
		Case 2
			ls_file = "display.pdf"
		Case 3
			ls_file = "display.htm"	
		Case 4
			ls_file = "display.bmp"
		Case 5 //Start Code Change ----06.01.2016 #V15 maha
			ls_file = "display.png"
		Case 6  //Start Code Change ----06.01.2016 #V152 maha
			ls_file = "display.xml"
		Case 7  //Start Code Change ----10.24.2016 #V152 maha
			ls_file = "display.jpg"	
	end choose
	
	ll_verification_id = this.GetItemNumber( row, "address_lookup_code")
	ll_ver_method = This.GetItemnumber( row, "verification_method" )  //Start Code Change ----07.15.2016 #V153 maha
	
	ls_pass_ids.ls_doc_id = This.GetItemString( row, "doc_id" )
	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
	ls_pass_ids.ls_from_window = "Prac_Folder"
	ls_pass_ids.ll_verification_id = ll_verification_id
	
	
	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF
	
//Start Code Change ----10.24.2016 #V152 maha - split code for the two buttons
	if dwo.name = "image_button_no_image" THEN
		if w_mdi.of_security_access(260) = 0 then return //trap for readonly
		
		ls_ext = inv_action_items.of_upload_document( This.GetItemString( row, "doc_id" )) 
		if ls_ext = "F" then 
			//failed
		else
			choose case upper(ls_ext)
				case "XML"
					li_type = 6
				case "PNG"
					li_type = 5
				case "BMP"
					li_type = 4
				case "HTM"
					li_type = 3
				case "PDF"
					li_type = 2
				case "JPG"
					li_type = 7	
			end choose
			this.SetItem( row,"verification_picture_flag", li_type)
		//Start Code Change ----08.17.2017 #V154 maha - stamp upload values
			this.SetItem( row, "image_stamp", datetime( today(), (Now()) ) )
			this.SetItem( row, "image_stamp_user", gs_user_id )
			this.SetItem( row, "image_stamp_site", "Manual Upload")
		//End Code Change ----08.17.2017 
			 this.update()
		end if
		
	else  //display image
	//Start Code Change ----07.15.2016 #V153 maha - for AMA xml 
		ls_docid = This.GetItemString( row, "doc_id" )
		if ll_ver_method = -570 and li_type = 6 then  //AMA & XML
			//Start Code Change ----10.24.2016 #V153 maha - change to use ama verif window
			ll_facil =this.GetItemNumber( row , "verif_info_facility_id" )
			lst_ids.facility_id = ll_facil
			lst_ids.sl_prac_ids[1]  = this.getitemnumber(row, "prac_id")
			openwithparm(w_ama_verifications, lst_ids)

			//End Code Change ----10.20.2016 
		else
			//Start Code Change ----08.21.2017 #V154 maha  changed to use display window
		//	if li_type > 1 then			
			choose case li_type
				case 1
					IF Not IsValid( w_capture ) THEN
						OpenWithParm( w_capture,  ls_pass_ids )
					ELSE
						w_capture.of_setup( ls_pass_ids )
					END IF	
				case 2 //pdf
					inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
				case else
					gs_pass_ids lst_data
					lst_data.s_stringval = "Verif"
					lst_data.ls_doc_id = ls_docid 
					openwithparm(w_verif_image_view , lst_data)
			end choose
				//End Code Change ----08.21.2017						
//			if li_type > 1 then
//				inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//			else
//				IF Not IsValid( w_capture ) THEN
//					OpenWithParm( w_capture,  ls_pass_ids )
//				ELSE
//					w_capture.of_setup( ls_pass_ids )
//				END IF
//			end if
		end if
	//End Code Change ----07.15.2016
	End if
//End Code Change ----10.24.2016	
END IF
end event

event constructor;//inv_printletters = CREATE pfc_n_cst_ai_printletters //Start Code Change ----07.06.2011 #V11 maha - moved to preopen event
This.SetRowFocusIndicator( p_1 )
This.of_SetDropDownCalendar( TRUE )
This.of_SetUpdateable( True )
This.of_SetTransObject( SQLCA )
inv_printletters.of_setdetaildw( This )

This.iuo_calendar.of_Register(This.iuo_calendar.DDLB)		

This.of_SetSort( True )
This.inv_sort.of_SetColumnnameSource( This.inv_sort.HEADER )
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )
This.inv_sort.of_SetStyle( This.inv_sort.DROPDOWNLISTBOX )
This.inv_sort.of_SetColumnHeader( TRUE )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 01.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Copy the script from the Open event of w_action_items due to the usage
//$<modification> of CreateOnDemand.
inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse ) //Start Code Change ----07.06.2011 #V11 maha - moved to preopen event
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "response_code" THEN
	This.SetItem( row, "user_name", gs_user_id )
	This.SetItem( row, "print_flag", 0 )
	//Start Code Change ----07.06.2011 #V11 maha  - separated out updates by dwobject type
	if this.dataobject  = "d_process_actions_ofe_ai" then 
		This.SetItem( row, "complete_date", Today() )
	else //verifications
		This.SetItem( row, "source", "P" )
		This.SetItem( row, "date_recieved", Today() )
		This.SetItem( row, "exp_credential_flag", 0 )
	end if
	//End Code Change ----07.06.2011 #V11 maha
	lb_response_cd_entered = True
END IF

IF This.GetColumnName() = "selected" THEN
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	//m_pfe_cst_action_items.m_action.m_batchresponse.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_batchresponse,'Enabled', True)
	//---------End Modfiied ------------------------------------------------------
end if

//Start Code Change ----06.29.2009 #V92 maha - copied from verif info screen
IF This.GetColumnName() = "verification_method" THEN 
	if messagebox("Verification method","Are you sure you want to change the Verification Method?",question!,Yesno!,2) = 2 then
		return 2
	else
		this.accepttext()
		if this.getitemnumber( row, "verification_method" ) = 10015 then
			if isnull(this.getitemnumber(row,"response_code")) then  //Start Code Change ----11.08.2011 #V12 maha - trap for change after completed.
				This.SetItem( row, "exp_credential_flag", 1 )
			end if
		end if
	end if
end if
//End Code Change---06.29.2009


end event

event retrieveend;call super::retrieveend;inv_action_items.of_enable_action_menu(This,dw_select_org_facility.GetText(),2)

of_filter_by_intellibatch(this) //maha 073003

if RowCount > 0 then
//	m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = true		//Added by Scofield on 2008-12-11
	This.ScrollToRow( 1 )
	This.SetRow( 1 )
else
	if isvalid(m_pfe_cst_action_items) then	//added by long.zhang 07.17.2012 Null object reference 
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = false		//Added by Scofield on 2008-12-11
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_batchrecred,'Enabled', false)		//Added by Scofield on 2008-12-11
		//---------End Modfiied ------------------------------------------------------
	end if	
end if

lb_response_cd_entered = False

end event

event rowfocuschanged;call super::rowfocuschanged;inv_action_items.of_enable_action_menu( This, dw_select_org_facility.GetText() ,2)

//if this.dataobject <> "d_app_audit_missing_ai" then
if this.dataobject <> "d_process_actions_ofe_ai" and this.dataobject <> "d_app_audit_missing_ai" then	 //Start Code Change ----09.08.2011 #V11 maha 
	tab_1.tabpage_detail.tab_view.tabpage_details.enabled = true  
	This.SetColumn( "response_code" )
else
//------------------Appeon Begin ------------------------
	//<$Modified > long.zhang 03.28.2012
	//<$Reason> Fixed bug 2954
	//tab_1.tabpage_detail.tab_view.tabpage_details.enabled = false
	 if this.dataobject = "d_app_audit_missing_ai" then
			tab_1.tabpage_detail.tab_view.tabpage_details.enabled = true
	else
		tab_1.tabpage_detail.tab_view.tabpage_details.enabled = false
	end if
	//------------------APPEON End---------------------------
	this.SetRow(currentrow)
end if

IF IsValid( w_capture ) THEN
	gs_pass_ids ls_pass_ids
	
	ls_pass_ids.ls_doc_id = This.GetItemString( currentrow, "doc_id" )
	ls_pass_ids.ls_ref_value = This.GetItemString( currentrow, "reference_value" )
	ls_pass_ids.ls_from_window = "Prac_Folder"
	IF This.GetItemNumber( currentrow, "verification_picture_flag" ) = 1 THEN
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF

	w_capture.of_setup( ls_pass_ids )
END IF

end event

event pfc_retrieve;call super::pfc_retrieve;Integer li_retval
DatawindowChild dwchild

This.GetChild("response_code", dwchild)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 02.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

SetRedraw ( false )//Rodger Wu put these three lines here ahead of dwchild retrieving. Oct. 23, 2006
li_retval =  This.Retrieve( )
SetRedraw ( true )

dwchild.SetTransObject( SQLCA )

dwchild.Retrieve("Credentials Verification Response")
      
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 02.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue( )
li_retval = This.Rowcount( )
//---------------------------- APPEON END ----------------------------

if this.dataobject <> "d_app_audit_missing_ai" then
//set priority
	IF w_mdi.of_security_access( 290 ) = 0 THEN
		This.Modify( "priority.protect = '1'" )
		This.Modify( "priority.background.color= '12632256'" )		
	END IF
	//priority user
	IF w_mdi.of_security_access( 300 ) = 0 THEN
		This.Modify("priority_user.protect = '1'" )
		This.Modify("priority_user.background.color= '12632256'" )
	END IF	
	//post results
	IF w_mdi.of_security_access( 270 ) = 0 THEN
		This.Modify("response_code.protect = '1'" )
		This.Modify("response_code.background.color= '12632256'" )
		This.Modify("user_name.protect = '1'")
		This.Modify("user_name.background.color= '12632256'")
		This.Modify("date_recieved.protect = '1'")
		This.Modify("date_recieved.background.color= '12632256'")
		This.Modify("date_recieved.protect = '1'")
		This.Modify("date_recieved.background.color= '12632256'")
	END IF	
else
	IF w_mdi.of_security_access( 270 ) = 0 THEN
		This.Modify("date_completed.protect = '1'" )
		This.Modify("date_completed.background.color= '12632256'" )
		This.Modify("data_status.protect = '1'" )
		This.Modify("data_status.background.color= '12632256'" )
		This.Modify("identifying_number.protect = '1'" )
		This.Modify("identifying_number.background.color= '12632256'" )
	end if
	
end if

if w_mdi.of_security_access( 255 ) < 2 then of_browse_security()


Return li_retval
end event

event doubleclicked;
//if this.dataobject <> "d_app_audit_missing_ai" then//Start Code Change ----05.20.2011 #V11 maha - removed
if this.dataobject = "d_process_actions_ofe_ai" then  //add by stephen --09.09.2011 Process Actions in Action Items Data Error bug id 2618
else
	tab_1.tabpage_detail.tab_view.SelectTab( 2 )
end if
//end if
end event

event getfocus;call super::getfocus;idw_active = This
end event

event pfc_sortdlg;call super::pfc_sortdlg;
RETURN 1
end event

event pfc_validation;call super::pfc_validation;IF inv_action_items.of_Validate_Receive( This ) = -1 THEN
	Return -1
ELSE
	Return AncestorReturnValue
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer z
Integer li_cnt,li_seq
Long ll_prac_id
Long ll_prac_ids[]
long ll_ori,ll_cur
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility_id
//Integer li_facility_ids[]
Long li_facility_id
Long li_facility_ids[]
//---------End Modfiied ------------------------------------------------------
Boolean lb_found
datetime ldt_today //maha 07.06.2011

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.20.2006 By: Jervis
//$<reason> 
str_action_item lstr_init[]

//Reset str_action_item value
istr_action = lstr_init
li_seq = 1
ldt_today = datetime(today(),now())  //Start Code Change ----07.06.2011 #V11 maha 

//---------------------------- APPEON END ----------------------------

ii_facility_ids = li_facility_ids
il_prac_ids = ll_prac_ids
li_rc = This.RowCount()

//debugbreak()
this.settransobject(sqlca)

//Start Code Change ----07.06.2011 #V11 maha - rearranged code and added process actions
if this.dataobject  = "d_app_audit_missing_ai" then //missing items
//	FOR i = 1 TO li_rc   //Start Code Change ----09.09.2011 #V12 maha - removed code as these records are not updated.
//		IF This.GetItemStatus( i, "date_completed", Primary! ) = DataModified! THEN
//			li_facility_id = This.GetItemNumber( i, "facility_id" )
//			ll_prac_id = This.GetItemNumber( i, "prac_id" )
//			lb_found = False
//			FOR z = 1 TO li_cnt
//				IF li_facility_id = ii_facility_ids[ z ] AND ll_prac_id = il_prac_ids[ z ] THEN
//					lb_found = True
//					Exit
//				END IF
//			END FOR
//			IF NOT lb_found THEN
//				li_cnt++
//				ii_facility_ids[ li_cnt ] = li_facility_id
//				il_prac_ids[ li_cnt ] = ll_prac_id
//			END IF
//		END IF
//	END FOR
//Start Code Change ----07.06.2011 #V11 maha - process actions  
elseif this.dataobject  = "d_process_actions_ofe_ai" then 
	long ll_templ
	long ll_step
	long ll_hdr
	FOR i = 1 TO li_rc
		IF This.GetItemStatus( i, 0, Primary! ) = DataModified! THEN
			this.setitem( i , "mod_date" , ldt_today)
			this.setitem( i , "mod_user" , gs_user_id)
			IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
				if not isnull(this.getitemnumber( i, "response_code")) then
					ll_step = this.getitemnumber( i, "process_step")
					li_facility_id = This.GetItemNumber( i, "facility_id" )
					ll_prac_id = This.GetItemNumber( i, "prac_id" )
					ll_hdr = This.GetItemNumber( i, "function_id" )
					ll_templ = long(gnv_data.of_getitem( "process_steps", "temp_id", "item_id = " + string(ll_step)))
					inv_pro_actions.of_add_next_process_action( ll_templ, ll_hdr,  ll_step,  ll_prac_id , li_facility_id, this )
				end if
			end if
		end if
	next
//Start Code Change ----07.06.2011
else
	FOR i = 1 TO li_rc
		IF This.GetItemStatus( i, 0, Primary! ) = DataModified! THEN  //maha added for verification update
			//Start Code Change ----08.03.2011 #V11 maha - modification tracking
			this.setitem( i , "mod_date" , ldt_today)
			this.setitem( i , "mod_user" , gs_user_id)
			//End Code Change ----08.03.2011 #V11 maha 
			IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
				li_facility_id = This.GetItemNumber( i, "verif_info_facility_id" )
				ll_prac_id = This.GetItemNumber( i, "prac_id" )
				lb_found = False
				FOR z = 1 TO li_cnt
					IF li_facility_id = ii_facility_ids[ z ] AND ll_prac_id = il_prac_ids[ z ] THEN
						lb_found = True
						Exit
					END IF
				END FOR
				IF NOT lb_found THEN
					li_cnt++
					ii_facility_ids[ li_cnt ] = li_facility_id
					il_prac_ids[ li_cnt ] = ll_prac_id
					ii_screen_ids[li_cnt] = This.GetItemNumber( i, "screen_id" )
				END IF
			END IF
		End If
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 11.02.2006 By: Jervis
		//$<reason> modify work flow
		If gb_workflow Then
			IF This.GetItemStatus( i, 0, Primary! ) = DataModified! then
				ll_ori = this.GetItemNumber(i,"response_code",primary!,true)
				ll_cur = this.GetItemNumber(i,"response_code")
				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
					istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
					istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
					istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
					istr_action[li_seq].wf_id = this.GetItemNumber(i,"verif_info_wf_id")
					istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
					istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
					istr_action[li_seq].status_changed_flag = false
					istr_action[li_seq].module = "01"	//IntelliGred
					istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[li_seq].screen_id = -10
					if istr_action[li_seq].wf_id > 0 and this.GetItemString(i,"verif_info_wf_complete_flag") = "N" THEN
						istr_action[li_seq].seq_no = This.getItemnumber( i, "seq_no" )
						istr_action[li_seq].wf_step_id = this.GetItemNumber(i,"verif_info_wf_action_type_id")
						istr_action[li_seq].notes = this.GetItemString(i,"notes")
						istr_action[li_seq].status_changed_flag = true
					end if
					li_seq++
				else
					ll_ori = this.GetItemNumber(i,"verification_method",primary!,true)
					ll_cur = this.GetItemNumber(i,"verification_method")
					if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
						istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
						istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
						istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
						istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
						istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
						istr_action[li_seq].status_changed_flag = false
						istr_action[li_seq].module = "01"	//IntelliGred
						istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
						istr_action[li_seq].screen_id = -10
						li_seq++
					end if
				end if
			END IF
		End if
		//---------------------------- APPEON END ----------------------------
	END FOR
end if
//Start Code Change ----07.06.2011
Return 1
end event

event rbuttondown;call super::rbuttondown;
integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.20.2006 By: LeiWei
//$<reason> Fix a defect
//col = this.getclickedcolumn()
col = this.getcolumn()
//---------------------------- APPEON END ----------------------------
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,1 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF



end event

event buttonclicked;long 		i
long 		ic
integer	li_Cycle,li_Count,li_Value[],li_CurRow


//Start Code Change ----07.29.2009 #V92 maha - copied from prac folder
//IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
//	Long ll_verification_id
//	gs_pass_ids ls_pass_ids
//	integer li_type
//	string ls_file
//	long ll_ver_method //maha 10.24.2016
//	long ll_facil  //maha 10.24.2016
//	string ls_ext  //maha 10.24.2016
//	gs_pass_ids lst_ids
//	//messagebox(string(row), "ff")
//	li_type = this.GetItemNumber( row,"verification_picture_flag")
//	choose case li_type
//		//case 1 = HTML
//		Case 2
//			ls_file = "display.pdf"
//		Case 3
//			ls_file = "display.htm"	
//		Case 4
//			ls_file = "display.bmp"
//		Case 5 //Start Code Change ----06.01.2016 #V15 maha
//			ls_file = "display.png"
//		Case 6  //Start Code Change ----06.01.2016 #V152 maha
//			ls_file = "display.xml"
//	end choose
//	
//	ll_verification_id = this.GetItemNumber( row, "address_lookup_code")
//	ll_ver_method = This.GetItemnumber( row, "verification_method" )  //Start Code Change ----07.15.2016 #V153 maha
//	
//	ls_pass_ids.ls_doc_id = This.GetItemString( row, "doc_id" )
//	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	ls_pass_ids.ll_verification_id = ll_verification_id
//	
//	
//	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
//	
//	//Start Code Change ----06.01.2016 #V152 maha - changed to case statement
//	//if li_type > 1 then  
//	Choose case li_type
//		case is > 1   //Start Code Change ----06.13.2016 #V152 maha - change to > 1
//			inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//		case else
//			IF Not IsValid( w_capture ) THEN
//				OpenWithParm( w_capture,  ls_pass_ids )
//			ELSE
//				w_capture.of_setup( ls_pass_ids )
//			END IF
//	End choose
//	//Start Code Change ----06.01.2016
//	//end if
//END IF

////Start Code Change ----10.24.2016 #V152 maha - split code for the two buttons
//	if dwo.name = "image_button_no_image" THEN
//		ls_ext = inv_action_items.of_upload_document( This.GetItemString( row, "doc_id" )) 
//		if ls_ext = "F" then 
//			//failed
//		else
//			choose case upper(ls_ext)
//				case "XML"
//					li_type = 6
//				case "PNG"
//					li_type = 5
//				case "BMP"
//					li_type = 4
//				case "HTM"
//					li_type = 3
//				case "PDF"
//					li_type = 2
//			end choose
//			 this.SetItem( row,"verification_picture_flag", li_type)
//			 this.update()
//		end if
//		
//	else  //display image
//	//Start Code Change ----07.15.2016 #V153 maha - for AMA xml 
//		if ll_ver_method = -570 and li_type = 6 then  //AMA & XML
//			//Start Code Change ----10.24.2016 #V153 maha - change to use ama verif window
//			ll_facil =this.GetItemNumber( row , "verif_info_facility_id" )
//			lst_ids.facility_id = ll_facil
//			lst_ids.sl_prac_ids[1]  = this.getitemnumber(row, "prac_id")
//			openwithparm(w_ama_verifications, lst_ids)
//
//			//End Code Change ----10.20.2016 
//		else
//			
//			if li_type > 1 then
//				inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//			else
//				IF Not IsValid( w_capture ) THEN
//					OpenWithParm( w_capture,  ls_pass_ids )
//				ELSE
//					w_capture.of_setup( ls_pass_ids )
//				END IF
//			end if
//		end if
//	//End Code Change ----07.15.2016
//	End if
////End Code Change ----10.24.2016	
//End if


IF w_mdi.of_security_access( 270 ) = 1 THEN
	if dwo.name = "sall" then
		li_Count = This.RowCount()
		if li_Count < 1 then return
		
		This.SetRedraw(false)
		li_CurRow = This.GetRow()
		if this.object.sall.text = "Select All" then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2007-08-14 By: Scofield
			//$<Reason> Performance truing.
			
			//for i = 1 to this.rowcount()
			//	this.setitem(i,"selected",1)
			//next
			
			for li_Cycle = 1 to li_Count
				li_Value[li_Cycle] = 1
			next
			
			This.Object.selected.Primary = li_Value
			//---------------------------- APPEON END ----------------------------
			this.object.sall.text = "Deselect All"
		else
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2007-08-14 By: Scofield
			//$<Reason> Fix a defect.
			
			//for i = 1 to this.rowcount()
			//	this.setitem(i,"selected",0)
			//next
			
			for li_Cycle = 1 to li_Count
				li_Value[li_Cycle] = 0
			next
			
			This.Object.selected.Primary = li_Value
			//---------------------------- APPEON END ----------------------------
			this.object.sall.text = "Select All"
		end if
		//------------------- APPEON BEGIN -------------------
		//$<add> Evan 09.13.2011
		//$<reason> Fixed BugE090701
		for li_Cycle = 1 to li_Count
			this.SetItemStatus(li_Cycle, "selected", Primary!, NotModified!)
		next
		//------------------- APPEON END ---------------------		
		This.SetRow(li_CurRow)
		This.SetRedraw(true)
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_action_items.m_action.m_batchresponse.Enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_batchresponse,'Enabled', True)
		//---------End Modfiied ------------------------------------------------------
	elseif dwo.name = "comp" then
		This.SetItem( row, "data_status", 662 )
		This.SetItem( row, "date_completed", DateTime( Today(), Now() ) )
		lb_response_cd_entered = true
	end if
else
end if

if dwo.name  = "b_npdb" then//Start Code Change ----05.05.2008 #V8 maha - added functionality
 	 //window w_npdb_report
	  Openwithparm(w_npdb_reports, This.GetItemnumber( row, "prac_id" ) )  //Start Code Change ----09.12.2012 #V12 maha - added parm
	//OpenSheetWithParm(w_npdb_report, this.GetItemstring( row, "doc_id"), "w_npdb_report", w_mdi, 0, original!)
end if 

//Start Code Change ----08.04.2009 #V92 maha - added expanded notes
IF dwo.name = 'b_notes' THEN
	string s
	//Start Code Change ----09.12.2012 #V12 maha - nue exp. notes screen
	
	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
	
	//------Begin Modified by Alfee 01.15.2010 ---------------
	//<$Reason> for a richtext bug in APB 6.0 
//	IF appeongetclienttype() = 'WEB' THEN  
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
//	ELSE		
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	END IF		
	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
	//------End Modified --------------------------------------

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
//		if len(s) > 255 then    //Start Code Change ----11.4.2010 #V10 maha - removed with change to varchar
//			s = mid(s,1,255)
//			messagebox("Notes","This Notes field is limited to 255 characters.")
//		end if
		This.SetItem( row, "notes", s )
	END IF
End if
//End Code Change---08.04.2009


end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Jervis
//$<reason> modify work flow
long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger

//Start Code Change ----09.22.2010 #V10 maha - changed because did not work if did not have workflow
//If not gb_workflow then return 1
If gb_workflow then 
	lnv_trigger = create n_cst_workflow_triggers
	ll_count = UpperBound(istr_action)
	for ll_i = 1 to ll_count
		if istr_action[ll_i].status_changed_flag then
			lnv_trigger.of_status_changed( istr_action[ll_i])
		end if
	next

	//2006-11-20 by jervis
	//Create Work Flow By Action Item Changed
	lnv_trigger.of_workflow_triggers(istr_action)   
	//2006-11-20
	destroy lnv_trigger
end if
//End Code Change ----09.22.2010 

//---------------------------- APPEON END ----------------------------

//Start Code Change ----09.09.2008 #V85 maha
//set app audit complete if appropriate 
//if this.dataobject  = "d_app_audit_missing_ai" then //app audit
//	long ll_pracs[]
//	long ll_recs[]
//	long ll_comp[]
//	long ll_prac_id
//	long ll_rec_id
//	long cnt
//	long r
//	integer li_test = 0
//	datetime ldt_date
////debugbreak()
//	for ll_i = 1 to this.rowcount()
//		li_test = 0
//		ll_prac_id = this.getitemnumber(ll_i,"prac_id")
//		ll_rec_id = this.getitemnumber(ll_i,"appt_stat_id")
//		ldt_date =  this.getitemdatetime(ll_i,"date_completed")
//		for r = 1 to upperbound(ll_pracs[])
//			if ll_prac_id = ll_pracs[r] then
//				if ll_rec_id = ll_recs[r] then
//					li_test = r //if found set r for checking compl
//					continue
//				end if
//			end if
//		next
//		if li_test = 0 then //if you dont find the prac and rec add a new to array
//			cnt = upperbound(ll_pracs[])
//			cnt++
//			ll_pracs[cnt] = ll_prac_id
//			ll_recs[cnt] = ll_rec_id
//			if isnull(ldt_date) then //set the complete value
//				ll_comp[cnt] = 0
//			else
//				ll_comp[cnt] = 1
//			end if
//		else //found prac and rec check complete
//			if ll_comp[li_test] = 0 then //is already set as incomplete skip
//				continue
//			else //if set as completed
//				if isnull(ldt_date) then ll_comp[cnt] = 0 //set as incomplete 
//			end if
//		end if 			
//	next
//
//	//call function to set comple date 
//	inv_action_items.of_app_audit_complete( ll_pracs[],ll_recs[], ll_comp[])
//	
//end if
//End Code Change---09.09.2008

return 1


end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.05.2006 By: Jervis
//$<reason> Filter Status
datawindowchild ldwc
long ll_wf_id,ll_wf_step_id
string ls_filter
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.01.2007 By: Frank.Gui
//$<reason> 
IF row < 1 or isnull(row) THEN return
//---------------------------- APPEON END ----------------------------

TRY
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 12.03.2009 By: Andy
	//$<reason> Fixed BUG BugA120301.
	if dwo.name = "response_code" Then
		ll_wf_id = this.GetItemNumber(row,"verif_info_wf_id")
		ll_wf_step_id = this.GetItemNumber(row,"verif_info_wf_action_type_id")
		
		//if dwo.name = "response_code" and ll_wf_id > 0 then
		if ll_wf_id > 0 then
			if this.GetChild(dwo.name,ldwc) = 1 then
				ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
				ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
				if ls_filter <> "" then
					ls_filter += " or isnull(lookup_code) or lookup_code = -777"
				else
					ls_filter = "isnull(lookup_code) or lookup_code = -777"
				end if
				ldwc.SetFilter( ls_filter)
				ldwc.Filter()
				//this.SetRedraw( false)
				is_prior = dwo.name
			end if
		elseif is_prior = "response_code" then
			if this.GetChild(is_prior,ldwc) = 1 then
				ldwc.SetFilter("")
				ldwc.Filter()
				is_prior = ""
				this.SetRedraw( true )
			end if
		end if
	end if	
	//---------------------------- APPEON END ----------------------------
CATCH(THROWABLE th)
END TRY
end event

type tabpage_details from userobject within tab_view
integer x = 18
integer y = 100
integer width = 4462
integer height = 1504
long backcolor = 33551856
string text = "Detail"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_detail dw_detail
dw_dummy_browse dw_dummy_browse
st_name st_name
end type

on tabpage_details.create
this.dw_detail=create dw_detail
this.dw_dummy_browse=create dw_dummy_browse
this.st_name=create st_name
this.Control[]={this.dw_detail,&
this.dw_dummy_browse,&
this.st_name}
end on

on tabpage_details.destroy
destroy(this.dw_detail)
destroy(this.dw_dummy_browse)
destroy(this.st_name)
end on

type dw_detail from u_dw within tabpage_details
integer y = 80
integer width = 4462
integer height = 1416
integer taborder = 11
boolean bringtotop = true
end type

event constructor;This.of_SetDropDownCalendar( TRUE )
This.of_SetUpdateAble( True )
end event

event getfocus;call super::getfocus;idw_active = This
end event

event pfc_preupdate;call super::pfc_preupdate;//debugbreak()
String ls_ref_1
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_screen_name
String ls_rec_status
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
long		ll_found
Integer li_retval
//-----------appeon begin---------------
//<$>added long.zhang 09.29.2012
//<$>reason: for update verif record
Integer li_status = 1
long ll_ver_method = -1
integer li_table_id
//----------appeon end------------------
DataWindowChild dwchild
String ls_user
DateTime ldt_date

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Define several variable for checking if value in exp_field changed.

DateTime ldt_exp_date_original
Long ll_rec_id_changed[]

//---------------------------- APPEON END ----------------------------
setNull(ll_address_code)
SetNull( ldt_null_date )

This.AcceptText()

if this.dataobject = "d_app_audit_missing_ai_list" then return 1  //Start Code Change ----05.20.2011 #V11 maha 

li_screen_id = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.GetItemNumber( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getrow(), "screen_id" )

n_ds lds_screen_param

lds_screen_param = CREATE n_ds
lds_screen_param.DataObject = "d_get_screen_params"
lds_screen_param.SetTransObject( SQLCA )

lds_screen_param.Retrieve( li_screen_id )

ls_screen_name = lds_screen_param.GetItemString( 1, "screen_name" )
ls_ref_1 = lds_screen_param.GetItemString( 1, "ref_field_1" ) 
ls_ref_2 = lds_screen_param.GetItemString( 1, "ref_field_2" )
ls_exp_field = lds_screen_param.GetItemString( 1, "exp_field" )
destroy lds_screen_param	//added by long.zhang 04.11.2013 need destroy

IF This.GetItemStatus( 1,0, Primary!) <> NewModified! AND +&
	This.GetItemStatus( 1,0, Primary!) <> DataModified! THEN
	Return 0
END IF
		
ll_rec_id = This.GetItemNumber( 1,"rec_id" )

IF li_screen_id = 19 THEN
	IF IsNull( This.GetItemNumber( 1, "board_code" ) ) THEN
		RETURN 0
	ELSEIF ls_rec_status = "Modified" THEN
		SELECT count(*)  
  	   INTO :li_cnt  
     	FROM verif_info  
      WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
              ( verif_info.active_status = 1)   ;
		IF IsNull( li_cnt ) OR li_cnt = 0 THEN
			ls_rec_status = "New"
		END IF
	END IF
END IF

IF NOT IsNull(ls_ref_1) AND ls_ref_1 <> "" AND this.Describe(ls_ref_1 + ".ColType") <> "!" THEN //Modify by Evan 07.09.2009(Corrected BugE063002) --- Checks column if exists by ColType property
	This.ScrollToRow( i )
	This.SetRow( i )

	//move expiration date to verif info table if there is one
	IF Len(ls_exp_field) > 0 AND this.Describe(ls_exp_field + ".ColType") <> "!" THEN //Modify by Evan 07.09.2009(Corrected BugE063002) --- Checks column if exists by ColType property
		IF ls_exp_field = "certification_expires" THEN				
			ldt_exp_date = DateTime(Date( "1-1-" + String( This.GetItemNumber( 1,ls_exp_field ) ) ),Now())

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> Get Original value of exp_field.
			ldt_exp_date_original = DateTime(Date( "12-30-" + String( This.GetItemNumber( 1, ls_exp_field, Primary!, True ) ) ),Now())
			//---------------------------- APPEON END ----------------------------

		ELSE
			ldt_exp_date = This.GetItemDateTime( 1,ls_exp_field )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> Get Original value of exp_field.
			ldt_exp_date_original = This.GetItemDateTime( 1, ls_exp_field, Primary!, True )
			//---------------------------- APPEON END ----------------------------

		END IF
	ELSE
		ldt_exp_date = ldt_null_date

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-10-11 By: Rodger Wu (Inova)
		//$<reason> Get Original value of exp_field.
		SetNull( ldt_exp_date_original )
		//---------------------------- APPEON END ----------------------------

	END IF

	//get reference 1,data
	li_retval = This.GetChild(ls_ref_1, dwchild)
	IF li_retval = -1 THEN
		This.SetColumn( ls_ref_1)
		ls_reference =  This.GetText()				
	ELSE
		This.SetColumn( ls_ref_1)
		ll_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, dwchild.rowcount() )	//Start Code Change ----05.21.2008 #V8 maha - changed 10000 to dw_child.rowcount()
		IF ll_found > 0 and This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
			ls_reference = dwchild.GetItemString( ll_found, "code" )
			IF ls_screen_name = "Licensure" THEN
				ll_address_code = This.GetItemNumber( 1,"verifying_agency" )
			ELSE
				ll_address_code = This.GetItemNumber( 1,ls_ref_1)
			END IF
		//Start Code Change ----05.07.2008 #V8 maha - error trap	
		ELSEIF ll_found > 0 and This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN  
			ls_reference = dwchild.GetItemString( ll_found, "entity_name_original" )
		//End Code Change---05.07.2008
			ll_address_code = This.GetItemNumber( 1,ls_ref_1)
		ELSE
			ls_reference = This.GetText()				
		END IF
	END IF

	//get reference 2 data
	IF this.Describe(ls_ref_2 + ".ColType") <> "!" THEN //Modify by Evan 07.09.2009(Corrected BugE063002) --- Checks column if exists by ColType property
		li_retval = This.GetChild(ls_ref_2, dwchild)
		IF li_retval = -1 THEN
			This.SetColumn( ls_ref_2 )
			ls_reference = ls_reference + " - " + This.GetText()				
		ELSE
			This.SetColumn( ls_ref_2 )
			ll_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, dwchild.rowcount() )	//Start Code Change ----05.21.2008 #V8 maha - changed 10000 to dw_child.rowcount()
			IF ll_found > 0 and This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
				ls_reference = ls_reference + " - " + dwchild.GetItemString( ll_found, "code" )
			ELSEIF ll_found > 0 and This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" THEN
				ls_reference = ls_reference + " - " + dwchild.GetItemString( ll_found, "entity_name" )
				ll_address_code = This.GetItemNumber( 1,ls_ref_1)							
			ELSE
				ls_reference = ls_reference + " - " + This.GetText()
			END IF
		END IF
	END IF
END IF

//-----------------appeon begin------------------
//<$>added:long.zhang 09.29.2012
//<$>reason:For  Disconnected Verification/expiring cred records
//Copied and Modified from pfc_cst_u_data_entry.dw_detail.preupdate()
if ib_data_entry then
	li_table_id = of_get_table_id(li_screen_id)
	IF li_table_id = 72 THEN  //other verifications
			if This.Describe("verif_method.ColType") = "!" then 
				//leave as default -1
			else
				ll_ver_method = this.GetItemNumber( 1, "verif_method" )
				if isnull( ll_ver_method) then ll_ver_method = -1
			end if
	end if
	
	if this.Describe("active_status.ColType") <> "!" then
			li_status = this.getitemnumber(1,"active_status") 
	end if
	
	if this.getitemstatus( 1, 0,primary!) = DataModified! then
			if not isValid(inv_action_items) then inv_action_items = create pfc_n_cst_ai_action_items	//added by long.zhang 04.11.2013
			inv_action_items.of_update_reference(ls_reference,ll_rec_id, ll_address_code, ldt_exp_date,li_screen_id, li_status, ll_ver_method)
			inv_data_entry.of_app_audit_update_ref(this.getitemnumber( 1, "prac_id") , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )
	end if
end if
//-----------------appeon end--------------------

inv_data_entry.of_field_audit( This )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Automatically poping up Verification Update window once
//$<reason> value in exp_field changed.

String ls_sql_where, ls_rec_id_str, ls_sql_original
Long ll_prac_id
n_ds lds_verify
gs_verif_update lstr_verif

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.10.2014
//<$>reason: walkaround the logic 'Null <> 0 '  for web version

//IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
//	( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
//	( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
//	ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
//END IF

If Not ( IsNull(ldt_exp_date_original) and IsNull( ldt_exp_date ) ) Then
	IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
		( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
		( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
		ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
	END IF
End If
//------------------- APPEON END -------------------

li_cnt = UpperBound( w_mdi.ii_security_action_id )
FOR i = 1 TO li_cnt
	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
			Return 1; //No rights	
		END IF
	END IF		
NEXT

//Start Code Change ----09.14.2017 #V154 maha - data flow
inv_dataflows.of_set_data_flow(this, li_table_id)  

li_cnt = UpperBound( ll_rec_id_changed )
IF li_cnt > 0 THEN
	ll_prac_id = This.GetItemNumber( 1,"prac_id" )
	
	//------------------- APPEON BEGIN -------------------
	//$<delete> Stephen 05.21.2013
	//$<reason> Bug 3437-Expiring Cred update Window is not always appearing
	/*
	ls_sql_where = " AND security_user_facilities.user_id = '" + gs_user_id + "' " + &
						" AND pd_affil_stat.prac_id = " + string( ll_prac_id ) + &
						" AND verif_info.screen_id = " + string( li_screen_id )
												
	FOR i = 1 TO li_cnt
		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
	NEXt
	ls_rec_id_str = Left( ls_rec_id_str, Len( ls_rec_id_str ) - 2 )
	ls_sql_where += " AND verif_info.rec_id in ( " + ls_rec_id_str + " ) "

	lds_verify = Create n_ds
	lds_verify.DataObject = "d_verification_facility_de_update"
	lds_verify.SetTransObject( SQLCA )
	
	ls_sql_original = lds_verify.Describe( "Datawindow.Table.Select" )
	ls_sql_original += ls_sql_where
	
	lds_verify.Modify( 'Datawindow.Table.Select = "' + ls_sql_original + '"' )

	IF lds_verify.Retrieve() > 0 THEN
		//IF MessageBox( "IntelliSoft", "Do you want to update the verification(s)?", Question!, YesNo!, 1 ) = 2 THEN Return 1; //Start Code Change ---- 11.162006 #V7 maha removed
		
		lstr_verif.sql_syntax = ls_sql_original
		*/
	//------------------- APPEON End -------------------
	
	lstr_verif.al_prac_id = ll_prac_id
	lstr_verif.al_screen_id = li_screen_id
	lstr_verif.al_rec_id = ll_rec_id_changed
	
	OpenwithParm( w_verification_de_update, lstr_verif )
	IF Message.StringParm = "OK" THEN ib_prac_data_changed = True
	
	//END IF
END IF

//---------------------------- APPEON END ----------------------------

RETURN 1
end event

event pfc_postupdate;
inv_dataflows.of_run_data_flow()  //Start Code Change ----09.14.2017 #V154 maha

//------------------appeon begin------------------
//<$>added:long.zhang 06.04.2013
//<$>reason: Bug 3557  Issue with Notifications
String	ls_table_name
n_cst_notification_alert_upd	lnv_na
if ib_data_entry then
	ls_table_name = This.Object.DataWindow.Table.UpdateTable
	lnv_na.of_update_alert_records(ls_table_name, This)
end if	
Call Super::pfc_postupdate
//------------------appeon end--------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-12 By: Rodger Wu (Inova)
//$<reason> Refresh browse DataWindow while verification is set Response Code.

IF ib_prac_data_changed THEN
	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Retrieve()
	tab_1.tabpage_detail.tab_view.selecttab( 1 )
	ib_prac_data_changed = FALSE
END IF
Return 1;

//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//Start Code Change ----08.01.2008 #V85 maha - added to duplicate data entry screen function
long ll_rec_id
integer li_stat
integer li_ans
integer li_screen
string ls_type  //maha 07.25.2013
datawindow ldw_browse
If This.GetColumnName() = "active_status" then
	li_stat = integer(data)
	IF li_stat = 0 THEN //if inactive display message
		li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", StopSign!, YesNo!, 1 )
		IF li_ans = 1 THEN
			li_ans = MessageBox("Active Status", "Are you sure?", StopSign!, YesNo!, 1	)
			IF li_ans = 2 THEN //if no set active
				this.setitem(row,this.getcolumn( ),1 )
				return
			end if
		end if
	End if	
	ldw_browse = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
	ll_rec_id = This.GetItemNumber( row, "rec_id" )
	li_screen = ldw_browse.GetItemNumber( ldw_browse.getrow(), "screen_id" )
	inv_action_items.of_update_verif_status( ll_rec_id, li_screen , li_stat )
END IF
//End Code Change---08.01.2008

//Start Code Change ----07.25.2013 #V14 maha - copied from prac data entry for lookup search and modified
IF Long(Data) = -777 THEN
	ls_type = "C"
	AcceptText( )
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 10.27.2014
	//<$>reason:for an issue of Foreign key constraint error
	//inv_data_entry.of_lookup_search_dddw(ls_type,this,is_lookup_search_column_table)
	inv_data_entry.post of_lookup_search_dddw(ls_type,this,is_lookup_search_column_table)
	//------------------- APPEON END -------------------
	
ELSEIF Long(Data) = -888 THEN
	ls_type = "A"
	AcceptText( )
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 10.27.2014
	//<$>reason:for an issue of Foreign key constraint error
	//inv_data_entry.of_lookup_search_dddw(ls_type,this,is_lookup_search_column_table)
	inv_data_entry.post of_lookup_search_dddw(ls_type,this,is_lookup_search_column_table)
	//------------------- APPEON END -------------------
	
	inv_data_entry.of_refresh_cache( ) 
END IF
//End Code Change---07.25.2013


end event

event buttonclicked;call super::buttonclicked;integer res  //maha 10.27.2016
integer r
string ls_notes

//Start Code Change ----05.20.2011 #V11 maha 
if dwo.name = "comp" then
	This.SetItem( row, "data_status", 662 )
	This.SetItem( row, "date_completed", DateTime( Today(), Now() ) )
	lb_response_cd_entered = true
end if

IF dwo.name = 'b_notes' THEN
	string s

	//Start Code Change ----09.12.2012 #V12 maha - nue exp. notes screen

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
	
//	IF appeongetclienttype() = 'WEB' THEN  
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
//	ELSE		
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	END IF		

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row, "notes", s )
	END IF
End if

//Start Code Change ----10.27.2016 #V153 maha
if dwo.name  = "compl_all" then
	//Start Code Change ----08.01.2017 #V16 maha - for V16
//	open(w_checklist_batch_compl)
//	if message.doubleparm = -1 then 
//		return
//	else
//		gs_pass_ids lst_ids
//		datetime ld_date
//		long ll_status
//		
//		ld_date = lst_ids.dt_from[1]
//		ls_notes = lst_ids.ls_ref_value
//		ll_status = lst_ids.l_app_id
//		lst_ids.dt_from[1] = ld_date
//		
//		for r = 1 to this.rowcount()
//			if isnull(this.getitemdatetime(r,"date_completed")) then
//				This.SetItem( r, "data_status", ll_status )
//				This.SetItem( r, "date_completed", ld_date)
//				This.SetItem( r, "notes" , ls_notes)
//			end if
//		next
//		this.update()
//	end if
	
	res = messagebox("Complete All","This will complete ALL incomplete Checklist items with Satisfactory status.~r~rDo you wish to continue?",question!,yesno!,2)
	if res = 2 then return
	res = messagebox("Complete All","Are you sure you want to complete ALL incomplete Checklist items with Satisfactory status?",question!,yesno!,2)
	if res = 1 then
		for r = 1 to this.rowcount()
			if isnull(this.getitemdatetime(r,"date_completed")) then
				This.SetItem( r, "data_status", 662 )
				This.SetItem( r, "date_completed", DateTime( Today(), Now() ) )
			end if
		next
		this.update()
	end if
end if
//End Code Change ----10.27.2016
end event

event itemfocuschanged;call super::itemfocuschanged;//Start Code Change ----07.25.2013 #V14 maha - copied from prac data entry for lookup search
DataWindowChild dwchild
String ls_column_name
integer res	
	debugbreak()
ls_column_name =This.GetColumnName()
res = This.GetChild( ls_column_name, dwchild )
if res > 0 then
	IF dwchild.RowCount() > 2 THEN 
		IF ls_column_name <> "street" and ls_column_name <> "active_status"  and ls_column_name <> "new_verification_method" THEN  //Start Code Change ----07.23.2008 #V85 maha - added active_status exception //Start Code Change ----12.18.2013 #V14 maha added new_verification_method
			is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605
		END IF
	END IF
end if


end event

type dw_dummy_browse from u_dw within tabpage_details
boolean visible = false
integer x = 41
integer y = 1004
integer width = 462
integer height = 384
integer taborder = 11
boolean bringtotop = true
end type

type st_name from statictext within tabpage_details
integer width = 1659
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type sle_doc_find from singlelineedit within tabpage_detail
integer x = 2665
integer y = 196
integer width = 494
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;cb_find.Default = True
end event

type cb_find from commandbutton within tabpage_detail
integer x = 3168
integer y = 196
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;cb_find.Default = False

ddplb_filters.SelectItem(23)

IF inv_action_items.of_filter( 0, 0, sle_doc_find.Text, +&
				tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters   ) = "Found" THEN
	sle_doc_find.Text = ""
ELSE
	sle_doc_find.SetFocus()
END IF

end event

type st_find from statictext within tabpage_detail
integer x = 2245
integer y = 212
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Doc_id Search:"
boolean focusrectangle = false
end type

type cb_init_recred from commandbutton within tabpage_detail
boolean visible = false
integer x = 27
integer y = 76
integer width = 882
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Initiate Recredentialing Process"
end type

event clicked;Integer li_cr
Integer li_parent_facility_id
long ll_prac
string ls_type
u_dw dw_browse //maha 10.22.2015
u_dw dw_detail	//maha 10.22.2015

 //Start Code Change ----10.22.2015 #V15 maha - modified to use dw variables
dw_browse = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
dw_detail = tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail

li_cr = dw_browse.GetRow()
//ls_type =  tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.getitemstring(li_cr ,"apptmnt_type")//Start Code Change ----05.10.2010 #V10 maha - hardcoded to R
li_parent_facility_id = dw_browse.GetItemNumber( li_cr, "verif_info_facility_id" )
ll_prac = dw_browse.GetItemNumber( li_cr, "prac_id" )

if tab_1.tabpage_detail.cbx_add_missing.checked then
	//inv_printletters.of_find_missing_verifs( ll_prac, li_parent_facility_id, 0, ls_type)
	inv_printletters.of_find_missing_verifs( ll_prac, li_parent_facility_id, 0, "R")  //Start Code Change ----05.10.2010 #V10 maha - hardcoded to R
end if

//Start Code Change ----08.31.2017 #V154 maha - for variable change
if tab_1.tabpage_detail.cbx_preserve.checked then
	inv_printletters.ib_preserve_exp_appt = true
else
	inv_printletters.ib_preserve_exp_appt = false
end if
//End Code Change ----08.31.2017

IF inv_printletters.of_start_reappointment_processing_new( dw_detail, dw_browse,  li_parent_facility_id,ll_prac,"RECRED",0) = 1 THEN 	 //Start Code Change ----10.22.2015 #V15 maha - change to new function
//IF inv_printletters.of_start_reappointment_processing( +&
//	tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail, +&
//	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, li_parent_facility_id,ll_prac,"RECRED" ) = 1 THEN
	tab_1.tabpage_detail.tab_view.SelectTab( 1 )
	dw_browse.Event pfc_retrieve()
END IF

 //End Code Change ----10.22.2015

 //Start Code Change ----11.16.2011 #V12 maha - added option for add window
if ib_privs then //open privilege batch window maha 081203
	if of_get_app_setting("set_65","I") = 1 then  //Start Code Change ----09.26.2011 #V12 maha - added option for add window
		openwithparm(w_renew_priv_form,ll_prac)
	else
		openwithparm(w_clin_area_select, "R*" + string(li_parent_facility_id ) + "@" + string(ll_prac))
	end if
end if
//		openwithparm(w_renew_priv_form,ll_prac)
//Start Code Change ----11.16.2011


end event

type st_1 from statictext within tabpage_detail
integer x = 2368
integer y = 8
integer width = 55
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
boolean enabled = false
boolean focusrectangle = false
end type

event clicked;if this.text = "" then
	ii_egg = 1
	this.text = "on"
else
	ii_egg = 0
	this.text = ""
end if
end event

type cb_recred_no_ver from commandbutton within tabpage_detail
boolean visible = false
integer x = 1719
integer y = 84
integer width = 832
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recredential without Verifications"
end type

event clicked;Integer li_cr
Integer li_parent_facility_id
long ll_prac

u_dw dw_browse //maha 10.22.2015
u_dw dw_detail	//maha 10.22.2015

 //Start Code Change ----10.22.2015 #V15 maha - modified to use dw variables
dw_browse = tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
dw_detail = tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail

//---------Begin Modified by (Appeon)Stephen 08.29.2016 for BugS081501--------
//dw_browse.GetRow()
li_cr = dw_browse.GetRow()
//---------End Modfiied ------------------------------------------------------

li_parent_facility_id = dw_browse.GetItemNumber( li_cr, "verif_info_facility_id" )
ll_prac = dw_browse.GetItemNumber( li_cr, "prac_id" )

//Start Code Change ----08.31.2017 #V154 maha - for variable change
if tab_1.tabpage_detail.cbx_preserve.checked then
	inv_printletters.ib_preserve_exp_appt = true
else
	inv_printletters.ib_preserve_exp_appt = false
end if
//End Code Change ----08.31.2017

IF inv_printletters.of_start_reappointment_processing_new( dw_detail, dw_browse,  li_parent_facility_id,ll_prac,"NOVER",0) = 1 THEN 	 //Start Code Change ----10.22.2015 #V15 maha - change to new function
//IF inv_printletters.of_start_reappointment_processing( +&
//	tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail, +&
//	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, li_parent_facility_id,ll_prac,"NOVER" ) = 1 THEN
	tab_1.tabpage_detail.tab_view.SelectTab( 1 )
	dw_browse.Event pfc_retrieve()
END IF

 //End Code Change ----10.22.2015

 //Start Code Change ----11.16.2011 #V12 maha - added option for add window
if ib_privs then //open privilege batch window maha 081203
	if of_get_app_setting("set_65","I") = 1 then  //Start Code Change ----09.26.2011 #V12 maha - added option for add window
		openwithparm(w_renew_priv_form,ll_prac)
	else
		openwithparm(w_clin_area_select, "R*" + string(li_parent_facility_id ) + "@" + string(ll_prac))
	end if
end if
//		openwithparm(w_renew_priv_form,ll_prac)
//Start Code Change ----11.16.2011

end event

type dw_tracker from datawindow within tabpage_detail
boolean visible = false
integer x = 581
integer y = 1244
integer width = 366
integer height = 336
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_pd_app_audit_tracker"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_priv from checkbox within tabpage_detail
boolean visible = false
integer x = 1097
integer y = 8
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Privileges"
end type

event clicked;if this.checked = true then
	ib_privs = true
else
	ib_privs = false
end if
end event

type tabpage_ready from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
long backcolor = 33551856
string text = "Committee Status"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 12632256
rb_meet rb_meet
rb_record rb_record
tab_ready tab_ready
cb_send cb_send
dw_committee dw_committee
st_committee st_committee
cb_post cb_post
cb_1 cb_1
end type

on tabpage_ready.create
this.rb_meet=create rb_meet
this.rb_record=create rb_record
this.tab_ready=create tab_ready
this.cb_send=create cb_send
this.dw_committee=create dw_committee
this.st_committee=create st_committee
this.cb_post=create cb_post
this.cb_1=create cb_1
this.Control[]={this.rb_meet,&
this.rb_record,&
this.tab_ready,&
this.cb_send,&
this.dw_committee,&
this.st_committee,&
this.cb_post,&
this.cb_1}
end on

on tabpage_ready.destroy
destroy(this.rb_meet)
destroy(this.rb_record)
destroy(this.tab_ready)
destroy(this.cb_send)
destroy(this.dw_committee)
destroy(this.st_committee)
destroy(this.cb_post)
destroy(this.cb_1)
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.03.2009
//////////////////////////////////////////////////////////////////////

if AppeonGetClientType() = "WEB" then
	st_committee.Y += 10
	dw_committee.Y += 10
	//cb_1.Y += 10 //not needed, Comment by Appeon long.zhang 04.19.2017 (BugL041901)
	cb_1.Y -= 4
	cb_send.Y += 10
	cb_post.Y += 10
end if
end event

type rb_meet from radiobutton within tabpage_ready
boolean visible = false
integer x = 2130
integer y = 228
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "By Meeting"
boolean checked = true
end type

event clicked;tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.visible = true
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.uo_meeting.visible = false
end event

type rb_record from radiobutton within tabpage_ready
boolean visible = false
integer x = 1746
integer y = 228
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "By Record"
end type

event clicked;tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.visible = false
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.uo_meeting.visible = true
end event

type tab_ready from tab within tabpage_ready
event create ( )
event destroy ( )
integer y = 212
integer width = 4507
integer height = 1616
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean pictureonright = true
integer selectedtab = 1
tabpage_ready_to_send tabpage_ready_to_send
tabpage_sent_to_comm tabpage_sent_to_comm
end type

on tab_ready.create
this.tabpage_ready_to_send=create tabpage_ready_to_send
this.tabpage_sent_to_comm=create tabpage_sent_to_comm
this.Control[]={this.tabpage_ready_to_send,&
this.tabpage_sent_to_comm}
end on

on tab_ready.destroy
destroy(this.tabpage_ready_to_send)
destroy(this.tabpage_sent_to_comm)
end on

event selectionchanged;IF newindex = 1 THEN
	cb_send.Visible = True
	cb_post.Visible = False
	tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.SetFocus()
	tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Modify("DataWindow.Zoom=" + string(gi_zoom)) //Start Code Change ----08.01.2017 #V154 maha
ELSE
	cb_send.Visible = False
	cb_post.Visible = True
	tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.SetFocus()
	tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Modify("DataWindow.Zoom=" + string(gi_zoom))   //Start Code Change ----08.01.2017 #V154 maha
END IF


end event

type tabpage_ready_to_send from userobject within tab_ready
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4471
integer height = 1500
long backcolor = 33551856
string text = "Ready For Committee"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_ready dw_ready
end type

on tabpage_ready_to_send.create
this.dw_ready=create dw_ready
this.Control[]={this.dw_ready}
end on

on tabpage_ready_to_send.destroy
destroy(this.dw_ready)
end on

type dw_ready from u_dw within tabpage_ready_to_send
integer width = 4457
integer height = 1496
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_ready_for_comm"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;This.ScrollToRow( This.GetClickedRow( ) )
This.SetRow( This.GetClickedRow( ) )

end event

event constructor;//This.SetRowFocusIndicator( Hand! )
This.of_SetTransObject( SQLCA )
This.of_SetSort( True )

This.inv_sort.of_SetColumnnameSource( This.inv_sort.HEADER )
This.inv_sort.of_SetStyle( This.inv_sort.DROPDOWNLISTBOX )
This.inv_sort.of_SetColumnHeader( TRUE )
This.inv_sort.of_SetColumnDisplayNameStyle( 3 )

This.of_SetUpdateAble( False )


end event

event pfc_retrieve;call super::pfc_retrieve;
Return Retrieve( ii_facility_ids_all[], ii_comm_ids_all[] )
end event

event getfocus;call super::getfocus;idw_active = This
end event

event doubleclicked;call super::doubleclicked; //Start Code Change ----10.19.2015 #V15 maha
of_select_prac(row,this)
end event

type tabpage_sent_to_comm from userobject within tab_ready
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4471
integer height = 1500
long backcolor = 33551856
string text = "Post Committee Results"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_meeting uo_meeting
dw_sent_to_comm dw_sent_to_comm
end type

on tabpage_sent_to_comm.create
this.uo_meeting=create uo_meeting
this.dw_sent_to_comm=create dw_sent_to_comm
this.Control[]={this.uo_meeting,&
this.dw_sent_to_comm}
end on

on tabpage_sent_to_comm.destroy
destroy(this.uo_meeting)
destroy(this.dw_sent_to_comm)
end on

type uo_meeting from uo_meet_approval within tabpage_sent_to_comm
boolean visible = false
integer taborder = 31
end type

on uo_meeting.destroy
call uo_meet_approval::destroy
end on

type dw_sent_to_comm from u_dw within tabpage_sent_to_comm
integer width = 4462
integer height = 1496
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sent_to_comm"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetSort( True )

This.inv_sort.of_SetColumnnameSource( This.inv_sort.HEADER )
This.inv_sort.of_SetStyle( This.inv_sort.DROPDOWNLISTBOX )
This.inv_sort.of_SetColumnHeader( TRUE )
This.inv_sort.of_SetColumnDisplayNameStyle( 3 )

This.of_SetUpdateAble( False )


end event

event pfc_retrieve;call super::pfc_retrieve;Return Retrieve( ii_facility_ids_all[], ii_comm_ids_all[] )
end event

event getfocus;call super::getfocus;idw_active = This
end event

event doubleclicked;call super::doubleclicked; //Start Code Change ----10.16.2015 #V15 maha
of_select_prac(row,this)
end event

type cb_send from commandbutton within tabpage_ready
integer x = 2958
integer y = 84
integer width = 667
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send To Committee"
end type

event clicked;Integer i
Integer li_rc
Integer li_cnt
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility_id_selected
//Integer li_committee_id_selected
Long li_facility_id_selected
Long li_committee_id_selected
//---------End Modfiied ------------------------------------------------------
Integer num_selected
Integer li_selected_row
Long ll_prac_ids[]
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility
Long li_facility
//---------End Modfiied ------------------------------------------------------
gs_pass_ids lst_ids
long     ll_meet_select

lst_ids.l_ids = ll_prac_ids


	IF tab_ready.tabpage_ready_to_send.dw_ready.RowCount() = 0 THEN
		num_selected = 0
	ELSE //num_selected is a computed field in the DW based on the total of the selected records
		num_selected =  tab_ready.tabpage_ready_to_send.dw_ready.getitemnumber(1,"num_selected")
	END IF

	IF num_selected = 0 THEN
		MessageBox("Select Error", "No practitioners selected!")
		Return
	END IF
	
	li_rc = tab_ready.tabpage_ready_to_send.dw_ready.RowCount( )

	FOR i = 1 TO li_rc
		IF tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "selected") = 1 THEN
			li_cnt++
			//Start Code Change ----10.10.2014 #V14.2 maha - changed prac variable and added rec id.
			lst_ids.l_ids[li_cnt] = tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "rec_id")
			lst_ids.sl_prac_ids[li_cnt] = tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "prac_id")
			//End Code Change ----10.10.2014
			IF li_cnt = 1 THEN
				li_facility_id_selected = tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "facility_id")
				li_committee_id_selected = tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "committee_id")
				ll_meet_select = tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "pd_comm_review_meeting_id") //add by Stephen 06-23-2011 V11.3 Committee Proc Upd
			ELSE
				IF li_facility_id_selected <> tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "facility_id") THEN
					MessageBox("Select Error", "Only practitioners from the same facility can be selected.")					
					Return
				END IF
				IF li_committee_id_selected <> tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(i, "committee_id") THEN
					MessageBox("Select Error", "Only one committee at a time can be selected.")										
					Return
				END IF				
			END IF
		END IF
	END FOR
	
	li_facility = li_facility_id_selected
	tab_ready.tabpage_ready_to_send.dw_ready.GetItemNumber(1, "num_selected" )


	lst_ids.i_ids[1]    = li_facility
	lst_ids.i_ids[2]    = li_committee_id_selected
	lst_ids.l_app_id  = ll_meet_select  //add by Stephen 06-23-2011 	V11.3 Committee Proc Upd

	OpenWithParm( w_send_to_committee, lst_ids )

	IF Message.StringParm <> "Cancel" THEN
		tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Event pfc_retrieve()
		tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()
	END IF

end event

type dw_committee from u_dw within tabpage_ready
integer x = 1275
integer y = 84
integer width = 1623
integer height = 100
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_select_credentialing_committee"
boolean vscrollbar = false
boolean border = false
end type

event constructor;DataWindowChild dwchild
Integer i
Integer li_rc

This.of_SetupdateAble( False )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.09.2006 By: LeiWei
//$<reason> Fix a defect.
/*
This.SetTransObject( SQLCA )
This.InsertRow( 0 )

This.GetChild( "credentialing_committee", dwchild )
dwchild.SetTransObject( SQLCA )
li_rc = dwchild.Retrieve( 1 )
*/
This.SetTransObject( SQLCA )

This.GetChild( "credentialing_committee", dwchild )
dwchild.SetTransObject( SQLCA )
li_rc = dwchild.Retrieve( gs_user_id )
if li_rc < 1 then dwchild.insertrow( 0)	//04.15.2008 By Jervis

This.InsertRow( 0 )
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow(1)
dwchild.SetItem( 1, "committee_id", 0 )
dwchild.SetItem( 1, "committee_name", "All" )
This.SetItem(1, "credentialing_committee", 0 )

FOR i = 1 TO li_rc +1
	ii_comm_ids_all[i] = dwchild.GetItemNumber( i, "committee_id" )
END FOR
end event

event itemchanged;call super::itemchanged;Integer i
Integer li_rc
Integer li_dummy_array[]
DatawindowChild dwchild

ii_comm_ids_all = li_dummy_array

AcceptText()

ii_comm_id = Integer( GetText() )

IF ii_comm_id = 0 THEN
	This.GetChild( "credentialing_committee", dwchild )
	li_rc = dwchild.RowCount()
	FOR i = 2 TO li_rc 
		ii_comm_ids_all[i] = dwchild.GetItemNumber( i, "committee_id" )
	END FOR
ELSE
	ii_comm_ids_all[1] = ii_comm_id
END IF

tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Event pfc_retrieve()
tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()




end event

type st_committee from statictext within tabpage_ready
integer x = 1285
integer y = 16
integer width = 594
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
boolean enabled = false
string text = "Credentialing Committee"
boolean focusrectangle = false
end type

type cb_post from commandbutton within tabpage_ready
integer x = 2958
integer y = 84
integer width = 667
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Post Committee Results"
end type

event clicked;// all code changed maha 08-01
datetime ldt_return
datetime ldt_start
datetime ldt_end
datetime ldt_pstart
datetime ldt_pend
datetime ldt_set_start   //maha 01.03.2017
datetime ldt_set_end	  //maha 01.03.2017
date ld_enddate  //maha 09.30.2014
integer r
integer li_prov
Integer i      
Integer li_rc
Integer li_cnt
integer li_mcnt //maha 10.31.2014
integer li_rcnt  //maha 10.31.2014
Integer li_committee_id_selected
Integer num_selected
Integer li_selected_row
integer li_years // maha 09.30.2014
integer li_stat //maha 10.24.2014
Integer pos1  
Integer pos2
Integer pos3
Integer pos4  
Integer pos5
Integer pos6
Integer pos7  //maha 01.03.2017
Integer li_prior  //maha 01.03.2017
integer li_active
integer cnt
string ret
string ls_batch_info
string ls_type
string ls_return
string ls_start
string ls_end
string ls_pstart
string ls_pend
datetime ldt_nulldate //maha 041603
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility_id_selected
long li_facility_id_selected
//---------End Modfiied ------------------------------------------------------
long ll_code
Long ll_prac_ids[]
long ll_recid
long ll_facility  //maha 10.31.2014
long ll_prac   //maha 10.31.2014
//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//Integer li_facility
Long li_facility
//---------End Modfiied ------------------------------------------------------

boolean lb_mess = false
n_ds lds_appt_stat
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 02.20.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define the variables to be used by subsequent script.
DATASTORE lds_verif_info_seq_no
DATASTORE lds_pd_comm_review_recid
LONG ll_verif_info_row
LONG ll_arr_prac_ids[]
LONG ll_arr_facility_ids[]
LONG ll_selected
LONG ll_arr_recids[]
LONG ll_arr_recids_cnt
integer li_col
//---------------------------- APPEON END ----------------------------

//gs_pass_ids lst_ids

setnull(ldt_nulldate) //maha 041603



IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.RowCount() = 0 THEN
	num_selected = 0
ELSE //num_selected is a computed field in the DW based on the total of the selected records
	num_selected =  tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.getitemnumber(1,"num_selected")
END IF
IF num_selected = 0 THEN
	MessageBox("Select Error", "No practitioners selected!")	
	Return
END IF
li_rc = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.RowCount( )

//Start Code Change ----10.31.2014 #V14.2 maha - trap for midcycle and recred mix
FOR i = 1 TO li_rc
	IF  tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 1 THEN
		cnt = 	tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "pd_comm_review_active_status")
		if cnt = 6 then
			li_mcnt++
		else
			li_rcnt++
		end if
		
		if li_mcnt > 0 and li_rcnt > 0 then 
			MessageBox("Select Error", "Midcycle Appointments should be processed separately from other Appointment Types .")	
			Return
		end if
	END IF
END FOR

if li_mcnt > 0 then
	li_active = 6
else
	li_active = 1
end if
	
open(w_committee_return_type) //find batch type: batch or individual
ls_type = message.stringparm

if ls_type = "C" then 
	return	//cancel
	
elseif ls_type = "B" then //batch
	//Start Code Change ----03.03.2010 #V10 maha
	long f1 = -1
	long f2

	for i = 1 to li_rc //check for 
		if tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.getitemnumber(i,"selected") = 1 then
			if f1 = -1 then //for the first selected set f1
				f1 = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.getitemnumber(i,"facility_id")
				li_facility_id_selected = f1
			else //for all the other records set f2 for comparison
				f2 = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.getitemnumber(i,"facility_id")
				if f1 <> f2 then //if multiple facility records selected
					li_facility_id_selected = -1
					exit
				end if
			end if
		end if
	next
	
	gi_comm_return_facil_bypass = li_facility_id_selected
	open(w_batch_approval) //_v16) //maha 03.2010 - it is not possible to pass a parm to this window because it gets overwritten by the calendar set function.  Thus the global variable used
	//End Code Change ----03.03.2010
	
	ls_batch_info = message.stringparm

	//messagebox("ls_batch_info",ls_batch_info)
	if ls_batch_info = "C" then return //if canceled
	pos1 = pos(ls_batch_info,";")
	//messagebox("pos1",pos1)
	pos2 = pos(ls_batch_info,";",pos1 + 1)
	//messagebox("pos2",pos2)
	pos3 = pos(ls_batch_info,";",pos2 + 1)
	//messagebox("pos3",pos3)
	pos4 = pos(ls_batch_info,";",pos3 + 1)
	pos5 = pos(ls_batch_info,";",pos4 + 1)
	pos6 = pos(ls_batch_info,";",pos5 + 1)
	pos7 = pos(ls_batch_info,";",pos6 + 1)

	ll_code = long(Mid ( ls_batch_info, 1 , pos1 - 1 ))
	
	ls_return = Mid ( ls_batch_info, pos1 + 1,pos2 - pos1 - 1 )
	if ls_return = "1/1/1900" or ls_return = "1/1/2000" then
		setnull(ldt_return)// = ldt_nulldate
	else
		ldt_return = datetime(date(ls_return),now())
	end if
	
	ls_start = Mid ( ls_batch_info, pos2 + 1,pos3 - pos2 - 1 )
	//messagebox("ls_start",ls_start)
	if ls_start = "1/1/1900" or ls_start = "1/1/2000" then
		setnull(ldt_start)// = ldt_nulldate
	else
		ldt_start = datetime(date(ls_start),now())
	end if	
	
	ls_end = Mid ( ls_batch_info, pos3 + 1,pos4 - pos3 - 1 )
	//messagebox("ls_end",ls_end)
	if ls_end = "1/1/1900" or ls_end = "1/1/2000" then
		setnull( ldt_end) //= ldt_nulldate
	else
		ldt_end = datetime(date(ls_end),now())
	end if
	//\/maha 091103
		ls_pstart = Mid ( ls_batch_info, pos4 + 1,pos5 - pos4 - 1 )
	//	messagebox("ls_pstart",ls_pstart)
	if ls_pstart = "1/1/1900" or ls_pstart = "1/1/2000" then
		setnull(ldt_pstart)// = ldt_nulldate
	else
		ldt_pstart = datetime(date(ls_pstart),now())
	end if	
	
	ls_pend = Mid ( ls_batch_info, pos5 + 1,pos6 - pos5 - 1 )
	//messagebox("ls_pend",ls_pend)
	if ls_pend = "1/1/1900" or ls_pend = "1/1/2000" then
		setnull( ldt_pend) //= ldt_nulldate
	else
		ldt_pend = datetime(date(ls_pend),now())
	end if
//return	
	li_prov = integer(Mid ( ls_batch_info, pos6 + 1,1 ))
	li_prior = integer(Mid ( ls_batch_info, pos7 + 1,1 ))
	//ldt_end = datetime(date(Mid ( ls_batch_info, pos3 + 1)),now())
//	li_active = 1
//	messagebox("ll_code",ll_code)
//	messagebox("ldt_return",string(ldt_return))
//	messagebox("ldt_start",string(ldt_start))
//	messagebox("ldt_end",string(ldt_end))
//	messagebox("ldt_pstart",string(ldt_pstart))
//	messagebox("ldt_pend",string(ldt_pend))
//	messagebox("li_prov",string(li_prov))
	


	IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Find('selected = 1',1,li_rc) > 0 THEN
		lds_appt_stat = CREATE n_ds
		//lds_appt_stat.DataObject = "d_pd_affil_status_back_forpt"  //Start Code Change ----10.31.2014 #V14.2 maha - changed dw
		//lds_appt_stat.DataObject = "d_pd_affil_status_back_forpt_recid"
		lds_appt_stat.DataObject = "d_pd_affil_status_back_recid" //alfee 11.13.2014 (BugA102103)
		lds_appt_stat.of_SetTransObject( SQLCA )
		
		lds_pd_comm_review_recid = CREATE DATASTORE
		lds_pd_comm_review_recid.Dataobject = "d_pd_comm_review_recid_for_pt"
		lds_pd_comm_review_recid.SetTransObject( SQLCA )

		FOR i = 1 TO li_rc
			IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 1  THEN
				li_selected_row = i
				//Start Code Change ----10.31.2014 #V14.2 maha - redesigned based on rec_id
//				gl_prac_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "prac_id")
//				gl_facility_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "facility_id")			
				ll_recid = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "rec_id")
				ll_arr_recids[upperbound(ll_arr_recids) + 1] = ll_recid

//				ll_selected++
//				ll_arr_prac_ids[ ll_selected ] = gl_prac_id
//				ll_arr_facility_ids[ ll_selected ] = gl_facility_id
				//End Code Change ----10.31.2014
			END IF
		NEXT	

		gnv_appeondb.of_startqueue( )
		
		datawindowchild dwchild
		lds_appt_stat.GetChild( "parent_facility_id", dwchild )
		dwchild.settransobject(sqlca)
		dwchild.retrieve(gs_user_id)
		lds_appt_stat.GetChild( "verifying_facility", dwchild )
		dwchild.settransobject(sqlca)
		dwchild.retrieve(gs_user_id)

		//lds_appt_stat.Retrieve( ll_arr_prac_ids, ll_arr_facility_ids, gs_user_id )
		lds_appt_stat.Retrieve( ll_arr_recids )
		ll_arr_recids_cnt = lds_pd_comm_review_recid.Retrieve( ll_arr_recids ) 
		
		gnv_appeondb.of_commitqueue( )
	
//		FOR i = 1 TO lds_appt_stat.Rowcount( )
//			ll_arr_recids[i] = lds_appt_stat.getitemnumber(i,"rec_id")
//		NEXT
//		ll_arr_recids_cnt = lds_pd_comm_review_recid.Retrieve( ll_arr_recids ) 

		gnv_appeondb.of_startqueue( )
		
		FOR i = 1 TO li_rc
			IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 1  THEN
				li_selected_row = i
			else 
				continue
			END IF
			//Start Code Change ----10.31.2014 #V14.2 maha - changed based on recid
			ll_recid = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "rec_id")
			//gl_prac_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "prac_id")
			gl_prac_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "prac_id") //restored by alfee 11.13.2014 (BugA102103 )
			ll_facility = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "facility_id")
			gl_committee_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "committee_id")
			select appointment_years into :li_years from facility where facility_id = :ll_facility;   //Start Code Change ----09.30.2014 #V14.2 maha = based on DOB
	
			tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.setitem(i,"pd_comm_review_date_back_from_review",ldt_return)
			tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.setitem(i,"pd_comm_review_review_results",ll_code)
			tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.setitem(i,"pd_comm_review_approved_user",gs_user_id)
			
		//	lds_appt_stat.Setfilter( "prac_id = " + String(gl_prac_id) + " and parent_facility_id = " + String(gl_facility_id) )
			lds_appt_stat.Setfilter( "rec_id = " + String(ll_recid) )
		    lds_appt_stat.Filter()
			//ll_recid = lds_appt_stat.getitemnumber(1,"rec_id")
			
			//Fix a defect. Rodger Wu on Sept 20, 2006
			Integer li_found
			li_found = lds_pd_comm_review_recid.Find( "rec_id = " + string( ll_recid ) + " and committee_id = " + string( gl_committee_id ), 1, ll_arr_recids_cnt )
			IF li_found > 0 THEN
				lds_pd_comm_review_recid.DeleteRow( li_found )
				ll_arr_recids_cnt --
			END IF
			//////////////////////////////////////////
			
			cnt = lds_pd_comm_review_recid.Find("rec_id = " + String(ll_recid), 1, ll_arr_recids_cnt)
			if cnt < 1 then  //if there are no remaining committees to be completed set the appt dates
				//if not(isnull(ldt_start)) then lds_appt_stat.setitem(1,"apptmnt_start_date",ldt_start)		
				//Start Code Change ---- 04.26.2006 #413 maha
		 //Start Code Change ----01.03.2017 #V153 maha - setting start date from prior date
				if li_prior = 1 then  //use prior
					//get the prior end date and add a day
					ldt_set_start = lds_appt_stat.getitemdatetime(1,"prior_appt_end")
					if isnull(ldt_set_start) then
						ldt_set_start = ldt_start
					else
						ldt_set_start = datetime(relativedate(date (ldt_set_start), 1), time("00:00:00"))
					end if
						
				else
					ldt_set_start = ldt_start
				end if
				if not(isnull(ldt_set_start)) then 
					lds_appt_stat.setitem(1,"apptmnt_start_date",ldt_set_start)   //Start Code Change ----01.03.2017 #V153 maha - change variable
					if isnull(lds_appt_stat.getitemdatetime(1,"inital_appmnt_date")) and lds_appt_stat.getitemstring(1,"apptmnt_type") = "I" then
						lds_appt_stat.setitem(1,"inital_appmnt_date",ldt_set_start) //Start Code Change ----01.03.2017 #V153 maha - change variable
					end if
					
					if li_years < 0 then //Start Code Change ----09.30.2014 #V14.2 maha = based on DOB
						ld_enddate = inv_datetime.of_exp_date_birthday( abs(li_years), date(ldt_start), gl_prac_id )  
						ldt_end  = datetime(ld_enddate, time("00:00:00"))
					 //Start Code Change ----01.03.2017 #V153 maha
					else // = 1 set from prior date
						if li_prior = 1 then
							ld_enddate = inv_datetime.of_relativeyear(date(ldt_set_start) ,li_years)
							ld_enddate = RelativeDate(ld_enddate, -1 )
							ldt_end  = datetime(ld_enddate, time("00:00:00"))
						else
							//leave end date as is
						end if
					end if
					 //End Code Change ----01.03.2017
					 
					 //Start Code Change ----08.30.2017 #V154 maha - check completion of exp appt letter
					 inv_data_entry.of_set_exp_appt_inactive(gl_prac_id , ll_facility )
					//End Code Change ----08.30.2017
					
				end if //start not null
				//End Code Change---04.26.2006
				
				

				if not(isnull(ldt_end)) then lds_appt_stat.setitem(1,"apptmnt_end_date",ldt_end)
				if not(isnull(ldt_pstart)) then lds_appt_stat.setitem(1,"init_prov_period_from",ldt_pstart)		
				if not(isnull(ldt_pend)) then lds_appt_stat.setitem(1,"init_prov_period_to",ldt_pend)
				lds_appt_stat.setitem(1,"prov_status",li_prov)
				if li_active < 6 then //only update if not midcycle - maha 10.31.2014
					lds_appt_stat.setitem(1,"active_status",li_active)
					update pd_affil_staff_cat set active_status = 1 where rec_id = :ll_recid;
					update pd_affil_dept set active_status = 1 where rec_id = :ll_recid;
				end if
			else
				if not lb_mess then
					lb_mess = true
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 2007.08.31 By: Jack
					//$<reason> Fix a defect.
					/*
					messagebox("Notice","The appointment start and end dates have not been set for one or more practitoners in the batch because of additional committee records without a return date."  )
					*/
					//moved message outside of loop - maha 10.13.2014
   			//	messagebox("Notice","The appointment start and end dates have not been set for one or more practitioners in the batch because of additional committee records without a return date."  )
					//---------------------------- APPEON END ----------------------------
				end if
			end if
		NEXT

		tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.update()
		//lds_appt_stat.update() //commented and movied to below by long.zhang 11.08.2013 Bug 3732
		COMMIT USING SQLCA;

		gnv_appeondb.of_commitqueue( )
		
		//-------------appeon begin----------------------
		//<$>added:long.zhang 11.08.2013
		//<$>reason:need audit for pd_affil_stat Bug 3732
		lds_appt_stat.setfilter( '')
		lds_appt_stat.filter( )
		
		String ls_error_text
		
		if not isValid(inv_data_entry) then inv_data_entry = create pfc_cst_nv_data_entry_functions
		
		inv_data_entry.of_field_audit( lds_appt_stat,ls_error_text)
		
		 //Start Code Change ----09.14.2017 #V16 maha - data flow components
		inv_dataflow[1].of_set_data_flow(lds_appt_stat, 43)
				
		lds_appt_stat.update()
		COMMIT USING SQLCA;	

		inv_dataflow[1].of_run_data_flow() 
		 //End Code Change ----09.14.2017
		
		if lb_mess then
			messagebox("Notice","The appointment start and end dates have not been set for one or more practitioners in the batch because of additional committee records without a return date."  )
		end if	
		//End Code Change ----13.31.2014 - modifcation for midcycle
		
		DESTROY lds_appt_stat
		DESTROY lds_pd_comm_review_recid
	END IF
	
	
else //****************** INDIVIDUAL************************


	FOR i = 1 TO li_rc
		IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 1  THEN
			li_selected_row = i
		else 
			continue
		END IF
	
		gl_prac_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "prac_id")
		gl_facility_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "facility_id")
		gl_committee_id = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "committee_id")
		
		//Start Code Change ----10.24.2014 #V14.2 maha -  modified code for midcycle committees
		li_stat =  tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "pd_comm_review_active_status")
		if li_stat = 6 then
			ll_recid = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(li_selected_row, "rec_id")
		else
			ll_recid = 0
		end if
		Openwithparm(w_back_from_committee, ll_recid) 
		//Open(w_back_from_committee)
		//Start Code Change ----10.24.2014 #V14.2 maha
		
		IF Message.StringParm = "Cancel" THEN
			tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.setItem(li_selected_row, "selected",0)
			continue
		ELSE
			//tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()		
		END IF

	next
//	IF Message.StringParm <> "Cancel" THEN
//			tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.Event pfc_retrieve()
//		tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()
//	END IF
	
end if

	if ib_letters then //if approval letters were selected create letter verifications
		
		n_ds lds_verif_rec
		integer li_nr
//		long ll_prac_id
//		long ll_facility_id
		Long ll_seq_no
		string ls_letter_name
		long ll_prac_corro
		string ls_doc_id
		
		
		open(w_select_letter)
		
		ls_letter_name = message.stringparm
		if ls_letter_name = "C" then
			//skip letter creation
		else
  
			lds_verif_rec = CREATE n_ds
			lds_verif_rec.DataObject = "d_ver_summary_record_view"
			lds_verif_rec.of_SetTransObject( SQLCA )
	
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-16
			//$<add> 02.20.2006 By: LeiWei
			//$<reason> Performance tuning
			//$<modification> 1)Use lds_verif_info_seq_no to cache data instead of using SQL statements in the following loop.
			//$<modification> 2)Write script to retrieve data from a cache instead of from the database.
			IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Find('selected <> 0',1,li_rc) > 0 THEN
				lds_verif_info_seq_no = CREATE Datastore
				lds_verif_info_seq_no.Dataobject = "d_verif_info_max_seq_no_forpt"
				lds_verif_info_seq_no.SetTransObject( SQLCA )
				lds_verif_info_seq_no.Retrieve( ls_letter_name )
				
				ll_prac_corro = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(description) = upper('Practitioner Correspondence')" ))
			
				ll_seq_no++
				ll_recid = gnv_app.of_get_id( "RECORD_ID" , li_rc ) - 1
			END IF
			//---------------------------- APPEON END ----------------------------

			FOR i = 1 TO li_rc
			IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 0  THEN
				continue
			else 
				li_nr = lds_verif_rec.InsertRow( 0 )
				ll_prac = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "prac_id")
				ll_facility = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "facility_id")

				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-17
				//$<modify> 02.20.2006 By: LeiWei
				//$<reason> Performance tuning
				//$<modification> Write script to retrieve data from a cache instead of from the database.

				/*
				SELECT Max( seq_no )  
				into :ll_seq_no
				 FROM verif_info  
				WHERE ( facility_id = :ll_facility_id ) AND  
							( prac_id = :ll_prac_id  )  and 
								(reference_value = :ls_letter_name);
				IF IsNull( ll_seq_no ) THEN
					ll_seq_no = 0
					
				END IF
				
				select lookup_code
				into :ll_prac_corro
				from code_lookup
				where description = 'Practitioner Correspondence' using sqlca;
								
				ll_seq_no++
				ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
				*/
				
				ll_verif_info_row = lds_verif_info_seq_no.Find("facility_id = " + string(ll_facility) + " and prac_id = " + string(ll_prac),1,lds_verif_info_seq_no.RowCount())
				IF ll_verif_info_row > 0 THEN
					ll_seq_no = lds_verif_info_seq_no.GetItemNumber( ll_verif_info_row, "max_seq_no" ) + 1
				ELSE
					ll_seq_no = 1
				END IF
				
				ll_recid ++
				//---------------------------- APPEON END ----------------------------

				lds_verif_rec.SetItem( li_nr, "reference_value", ls_letter_name )
				lds_verif_rec.SetItem( li_nr , "rec_id", ll_recid )
				lds_verif_rec.SetItem( li_nr , "seq_no", ll_seq_no )
				lds_verif_rec.SetItem( li_nr, "screen_id", 1 )			
				lds_verif_rec.SetItem( li_nr, "prac_id",  ll_prac )			
				lds_verif_rec.SetItem( li_nr, "verif_info_facility_id", ll_facility )			
				lds_verif_rec.SetItem( li_nr, "priority_user", "PUBLIC" )
				lds_verif_rec.SetItem( li_nr, "priority", 2 )
				lds_verif_rec.SetItem( li_nr, "verification_method", ll_prac_corro )
				lds_verif_rec.SetItem( li_nr, "active_status", 1 )
				lds_verif_rec.SetItem( li_nr, "print_flag", 1)
				ls_doc_id = String( ll_recid ) + "-" + String( ll_prac ) + "-" + String( ll_facility ) + "-" + String( ll_seq_no )
				lds_verif_rec.SetItem( li_nr, "doc_id", ls_doc_id )		
				lds_verif_rec.SetItem( li_nr, "exp_credential_flag", 0 )			
			END IF
			END FOR
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-18
			//$<add> 02.20.2006 By: LeiWei
			//$<reason> Performance tuning
			//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_autocommit( )
			//---------------------------- APPEON END ----------------------------

			IF lds_verif_rec.Update() = -1 THEN
				MessageBox("Update Error", SQLCA.SQLERRTEXT )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Add> 08.22.2007 By: Evan
				//$<Reason> Need to destroy object.
				if IsValid(lds_verif_info_seq_no) then Destroy lds_verif_info_seq_no
				//---------------------------- APPEON END ----------------------------				
				Return -1
			else
				MessageBox("Approval letters","The Approval Letter Action Items have been created, and can be run using the Practitioner Correspondence filter")
			END IF
			COMMIT USING SQLCA;
			
			DESTROY lds_verif_rec
		end if
	end if

if ib_privs then //open privilege batch window maha 081203
	long prac[]
	long app[]
	integer facil[]
	gs_batch_search lst_sent

	app[1] = 1 //reappoint
	
	facil[1] = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(1, "facility_id")

	li_col = 0
	FOR i = 1 TO li_rc
		IF tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "selected") = 1  THEN
			//------------------- APPEON BEGIN -------------------
			//$<modify> Stephen 04.26.2012
			//$<reason> Electronic Meeting, Privilege Update to Granted
			/*
			prac[i] = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "prac_id")
			*/
			li_col += 1
			prac[li_col] = tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.GetItemNumber(i, "prac_id")
			//------------------- APPEON END -------------------
		end if
	next
	lst_sent.li_prac_id[] = prac[]
	lst_sent.ll_app[] = app[]
	lst_sent.ll_facility[] = facil[]
	
	openwithparm(w_batch_privilege_update,lst_sent)
end if


tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.Event pfc_retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_verif_info_seq_no) then Destroy lds_verif_info_seq_no
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from commandbutton within tabpage_ready
integer x = 1280
integer y = 220
integer width = 279
integer height = 80
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;integer i
integer rc

if tab_1.tabpage_ready.tab_ready.selectedtab = 2 then	
	rc = tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.rowcount()
	for i = 1 to rc
		tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.setitem(i,"selected",1)
	next

elseif tab_1.tabpage_ready.tab_ready.selectedtab = 1 then
	rc = tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.rowcount()
	for i = 1 to rc
		tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.setitem(i,"selected",1)
	next
end if
end event

type tabpage_net_dev from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
long backcolor = 33551856
string text = "Application Status"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 12632256
uo_net_dev uo_net_dev
end type

on tabpage_net_dev.create
this.uo_net_dev=create uo_net_dev
this.Control[]={this.uo_net_dev}
end on

on tabpage_net_dev.destroy
destroy(this.uo_net_dev)
end on

type uo_net_dev from pfc_ia_cst_nv_net_dev_new_action_items within tabpage_net_dev
integer y = 192
integer width = 4494
integer height = 1892
integer taborder = 50
boolean bringtotop = true
boolean border = true
end type

event pfc_cst_net_dev_filter;
Open( w_net_dev_filter)

IF gs_cust_type = "I" THEN
	w_net_dev_filter.is_open_from1 = "PFIA"
ELSE
	w_net_dev_filter.is_open_from1 = "PFCA"	
END IF
w_net_dev_filter.y = w_net_dev_filter.y + 200

end event

on uo_net_dev.destroy
call pfc_ia_cst_nv_net_dev_new_action_items::destroy
end on

event constructor;call super::constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<add> 01.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Copy the following script from the Open event of w_action_items due
//$<modification> to the usage of CreateOnDemand. Refer to PT-05 for more information.
This.of_Set_Facility_id( 0 )
This.of_sql()
//---------------------------- APPEON END ----------------------------

end event

type tabpage_contract from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
long backcolor = 33551856
string text = "Contract"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
uo_1 uo_1
end type

on tabpage_contract.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on tabpage_contract.destroy
destroy(this.uo_1)
end on

type uo_1 from uo_ctx_ai within tabpage_contract
integer width = 3950
integer height = 1956
integer taborder = 31
end type

on uo_1.destroy
call uo_ctx_ai::destroy
end on

event rbuttondown;Return 1
end event

type tabpage_document_manager from uo_ctx_ai_doc within tab_1
integer x = 18
integer y = 100
integer width = 4512
integer height = 2088
string text = "Document Manager"
end type

type uo_lights from uo_filter_lights within w_action_items
integer x = 2688
integer y = 2084
integer height = 220
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_lights.destroy
call uo_filter_lights::destroy
end on

type cbx_checklist from checkbox within w_action_items
boolean visible = false
integer x = 2839
integer y = 2208
integer width = 695
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
string text = "Checklist Completed Only"
end type

event clicked;parent.event pfc_cst_addtl_filters( )
end event

type st_buttons from statictext within w_action_items
integer width = 4558
integer height = 132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean border = true
boolean focusrectangle = false
end type

event constructor;// RP
this.borderColor = rgb(192, 192, 192)

integer c

c = of_get_app_setting("set_27","I")
this.backcolor = gl_button_bar_color  //Start Code Change ----02.16.2016 #V15 maha
//if c = 20 then //red
//	this.backcolor = 255
//elseif c = 30 then //green
//	this.backcolor = 65280
//else //yellow
//	this.backcolor = 8454143 
//end if
end event

event doubleclicked;//open(w_color_find_res) 

//if message.stringparm = "Cancel"  then return

//this.backcolor = message.doubleparm
end event

type cb_close from commandbutton within w_action_items
integer x = 4210
integer y = 16
integer width = 325
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type ddplb_filters from dropdownpicturelistbox within w_action_items
event after_select ( )
boolean visible = false
integer x = 1746
integer y = 344
integer width = 1719
integer height = 1756
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"TO BE PRINTED                 Verifications Letters","                                             Expiring Credential Letters","                                             Exp. Appt. Letters","                                             Exp. Provisional. Letters","                                             Exp. Allied Health Letters","                                             Practitioner Correspondence Letters","                                             All Credential Letters Needing Reprinting","AWAITING RESPONSE      Verification  Letters","                                             Expiring Credential  Letters","                                             Practitioner  Correspondence","                                             Expiring Appointments","NPDB                                   NPDB Queries To Be Exported","                                             NPDB Queries Previously Exported","VERIFICATIONS                  WEB","                                             CALLS","                                             COMPENDIUM","                                             HARD COPY","EXPIRING ELEMENTS        All Expiring Appointments","                                             All Expiring Credentials","RED FLAG                           Verifications In Process 120+","HIGH PRIORITY                 High Priority Action Items","MAXED ATTEMPTS           Verification letters at max attempts","DOC-ID                                Find Document","","OIG                                     OIG Queries To Be Scanned","                                           OIG Queries Flagged","CHECKLIST          Missing Items","PRACTITIONER                  All Action Items For A Practitioner","FSMB                                   FSMB Queries To Be Exported","                                             FSMB Queries Previously Exported","MISS ITEM 90    Checklist Missing Items 90 days To Be Printed","                           Checklist Missing Items 90 days Awaiting Response","VERIFICATIONS                  WEB Crawler Processed","PROCESS ACTIONS LETTERS to be printed","PROCESS ACTIONS LETTERS awaiting response","AMA API","Other - No Functionality"}
borderstyle borderstyle = stylelowered!
integer itempictureindex[] = {1,0,0,0,0,0,0,16,0,0,0,2,0,13,0,0,0,14,0,12,1,18,11,0,4,0,10,7,9,0,8,0,20,1,16,21,22}
string picturename[] = {"Custom002!","Export!","Globals!","EditDataGrid!","Custom026!","Custom073!","Custom076!","EditDataTabular!","Custom079!","DosEdit5!","Custom083!","red_flag.bmp","Custom038!","Watcom!","Custom023!","Custom025!","ViewPainter!","Count!","DeleteWatch!","Start5!","InkEdit!","Help!"}
long picturemaskcolor = 16777215
end type

event after_select();This.Text = is_display_text

of_enable_action_buttons( )  //Start Code Change ----02.16.2016 #V15 maha


end event

event selectionchanged;Integer li_picture_index
Integer li_index
Integer li_index_1
Integer i

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 12.08.2010
//$<reason> The following code duplicate with dw_browse constructor event
/*
//debugbreak()
//mskinner 22 March 2006 -- begin
// moved from the open event to prevent crash
if not ib_original_sql_set then 
   inv_action_items.of_set_original_sql( tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse )
	ib_original_sql_set =  true
end if
//mskinner 22 March 2006 -- begin
*/
//------------------- APPEON END ---------------------

ii_filter_index = index

is_filter = ddplb_filters.Text

if is_filter = "Other - No Functionality" then  //Start Code Change ----11.01.2017 #V16 maha
	is_filter = is_filter + is_other_method
end if
			
debugbreak()
is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )

tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.13.2017 #V154 maha


IF is_display_text = "-1" THEN
	Return 1
END IF

if w_mdi.of_security_access( 255 ) > 0 then //Start Code Change ----07.12.2011 #V11 maha - skip if no access
	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetFocus()
end if

This.PostEvent( "after_select" )
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetRowFocusIndicator( p_1 ) //add by stephen ---09.09.2011  cannot click a record to get a green arrow Bug id 2618
Return 0
end event

