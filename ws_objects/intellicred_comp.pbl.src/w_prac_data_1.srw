$PBExportHeader$w_prac_data_1.srw
forward
global type w_prac_data_1 from w_main
end type
type dw_photo_settings from u_dw within w_prac_data_1
end type
type st_provider_border from statictext within w_prac_data_1
end type
type cb_rehelp from commandbutton within w_prac_data_1
end type
type cb_recred from commandbutton within w_prac_data_1
end type
type cb_5 from commandbutton within w_prac_data_1
end type
type cb_4 from commandbutton within w_prac_data_1
end type
type cb_3 from commandbutton within w_prac_data_1
end type
type cb_2 from commandbutton within w_prac_data_1
end type
type pb_home from picturebutton within w_prac_data_1
end type
type dw_red_flag_count from u_dw within w_prac_data_1
end type
type cb_close from commandbutton within w_prac_data_1
end type
type cb_notes from picturebutton within w_prac_data_1
end type
type cb_add from picturebutton within w_prac_data_1
end type
type p_prac_photo from picture within w_prac_data_1
end type
type cb_1 from commandbutton within w_prac_data_1
end type
type cb_save from commandbutton within w_prac_data_1
end type
type cb_addcb from commandbutton within w_prac_data_1
end type
type cb_print from commandbutton within w_prac_data_1
end type
type cb_next from commandbutton within w_prac_data_1
end type
type cb_prior from commandbutton within w_prac_data_1
end type
type cb_b3 from commandbutton within w_prac_data_1
end type
type cb_b4 from commandbutton within w_prac_data_1
end type
type cb_b5 from commandbutton within w_prac_data_1
end type
type cb_b6 from commandbutton within w_prac_data_1
end type
type cb_b7 from commandbutton within w_prac_data_1
end type
type cb_delete from picturebutton within w_prac_data_1
end type
type uo_app_stat from pfc_cst_u_app_status within w_prac_data_1
end type
type dw_standing from u_dw within w_prac_data_1
end type
type tab_1 from tab within w_prac_data_1
end type
type tabpage_search from userobject within tab_1
end type
type uo_search from pfc_cst_u_extended_search within tabpage_search
end type
type tabpage_search from userobject within tab_1
uo_search uo_search
end type
type tabpage_detail from userobject within tab_1
end type
type oval_2 from oval within tabpage_detail
end type
type uo_data_entry from pfc_cst_u_data_entry within tabpage_detail
end type
type p_face from picture within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
oval_2 oval_2
uo_data_entry uo_data_entry
p_face p_face
end type
type tabpage_app_audit from userobject within tab_1
end type
type uo_app_audit from pfc_cst_u_application_audit within tabpage_app_audit
end type
type tabpage_app_audit from userobject within tab_1
uo_app_audit uo_app_audit
end type
type tabpage_apptmnt_status from userobject within tab_1
end type
type uo_affill_status from pfc_cst_u_apptmnt_status within tabpage_apptmnt_status
end type
type tabpage_apptmnt_status from userobject within tab_1
uo_affill_status uo_affill_status
end type
type tabpage_verif from userobject within tab_1
end type
type uo_verif_summary from pfc_cst_u_verification_info within tabpage_verif
end type
type tabpage_verif from userobject within tab_1
uo_verif_summary uo_verif_summary
end type
type tabpage_profile from userobject within tab_1
end type
type uo_profile from pfc_cst_u_profile within tabpage_profile
end type
type tabpage_profile from userobject within tab_1
uo_profile uo_profile
end type
type tabpage_image from userobject within tab_1
end type
type uo_image from pfc_cst_u_imaging within tabpage_image
end type
type tabpage_image from userobject within tab_1
uo_image uo_image
end type
type tabpage_privileges from userobject within tab_1
end type
type uo_priv from uo_priv_data_ent within tabpage_privileges
end type
type tabpage_privileges from userobject within tab_1
uo_priv uo_priv
end type
type tabpage_net from userobject within tab_1
end type
type uo_net from pfc_ia_cst_nv_net_dev_new within tabpage_net
end type
type tabpage_net from userobject within tab_1
uo_net uo_net
end type
type tabpage_meetings from userobject within tab_1
end type
type uo_meetings from pfc_cst_u_meetings within tabpage_meetings
end type
type tabpage_meetings from userobject within tab_1
uo_meetings uo_meetings
end type
type tabpage_contract from userobject within tab_1
end type
type uo_contracts from pfc_cst_u_contracts_provider within tabpage_contract
end type
type tabpage_contract from userobject within tab_1
uo_contracts uo_contracts
end type
type tabpage_wf from userobject within tab_1
end type
type tabpage_wf from userobject within tab_1
end type
type tab_1 from tab within w_prac_data_1
tabpage_search tabpage_search
tabpage_detail tabpage_detail
tabpage_app_audit tabpage_app_audit
tabpage_apptmnt_status tabpage_apptmnt_status
tabpage_verif tabpage_verif
tabpage_profile tabpage_profile
tabpage_image tabpage_image
tabpage_privileges tabpage_privileges
tabpage_net tabpage_net
tabpage_meetings tabpage_meetings
tabpage_contract tabpage_contract
tabpage_wf tabpage_wf
end type
type dw_tab_buttons from u_dw within w_prac_data_1
end type
type st_tabname from statictext within w_prac_data_1
end type
type dw_p_data from u_dw within w_prac_data_1
end type
type p_buttons from picture within w_prac_data_1
end type
type st_buttons from statictext within w_prac_data_1
end type
end forward

global type w_prac_data_1 from w_main
integer x = 5
integer y = 260
integer width = 5362
integer height = 2488
string title = "Practitioner Data"
event ue_post_open ( )
event pfc_cst_app_audit_complete pbm_custom02
event pfc_cst_compose_request ( )
event pfc_cst_dial_phone ( )
event pfc_cst_de_complete ( )
event pfc_cst_print_letters ( )
event pfc_cst_copy_row ( )
event pfc_cst_field_defaults ( )
event pfc_cst_next_de_screen ( )
event pfc_cst_prior_de_screen ( )
event pfc_cst_reverify_data ( )
event pfc_cst_copy_verifications ( )
event pfc_cst_goto_web ( )
event pfc_cst_update_dddw ( )
event pfc_cst_retrieve_app_audit_data ( )
event pfc_cst_lookup_search ( )
event pfc_cst_delete_verification ( )
event pfc_cst_add_ver_entry ( )
event pfc_cst_npdb_export ( )
event pfc_cst_run_report ( )
event pfc_cst_print_report ( )
event pfc_cst_delete_survey ( )
event pfc_cst_print_survey ( )
event pfc_cst_priorpage ( )
event pfc_cst_nextpage ( )
event pfc_cst_batch_print ( )
event pfc_cst_a_select ( )
event pfc_cst_a_note ( )
event pfc_cst_a_highlight ( )
event pfc_cst_a_stamptext ( )
event pfc_cst_a_delete ( )
event pfc_cst_save_image ( )
event pfc_cst_page_properties ( )
event pfc_cst_clear_print ( )
event pfc_cst_straighten_page ( )
event pfc_cst_rotate ( )
event pfc_cst_undo ( )
event pfc_cst_print_net_dev_ltr ( )
event pfc_cst_print_net_dev_report ( )
event pfc_cst_iverify ( )
event pfc_cst_multi_app ( )
event pfc_cst_prac_notes ( )
event pfc_cst_null_affil_dates ( )
event pfc_cst_facility_specific_data ( )
event pfc_cst_net_dev_filter ( )
event pfc_cst_print_apps_from_pf ( )
event pfc_cst_refresh_net_dev_ai ( )
event pfc_cst_reappoint ( )
event pfc_cst_make_inactive ( )
event pfc_cst_make_active ( )
event pfc_cst_add_cme ( )
event pfc_cst_meeting_report ( )
event pfc_cst_appt_note ( )
event pfc_cst_scan_oig ( )
event pfc_cst_email_documents ( )
event pfc_cst_add_missing_audit_items ( )
event pfc_cst_priv_batch ( )
event pfc_cst_prac_invoice ( )
event pfc_cst_fax_image_documents ( )
event pfc_cst_screen_capture ( )
event pfc_cst_delete_all_images ( )
event pfc_cst_add_missing_audit_items_force ( )
event pfc_cst_verif_workflow ( )
event pfc_cst_application_workflow ( )
event pfc_cst_select_scanner ( )
event pfc_cst_import_photo ( )
event pfc_cst_verif_send_to_history ( )
event pfc_cst_find_missing_verifs ( )
event pfc_cst_clear_photo ( )
event pfc_cst_cvo_data ( )
event pfc_cst_clear_changes ( )
event type integer ue_refresh_tv_search ( )
event pfc_cst_add_redflagdata ( )
event pfc_cst_import_signature ( )
event pfc_cst_set_historical ( )
event pfc_cst_pop_website ( )
event pfc_cst_add_wv_user ( long al_prac_id )
event ue_undo_data ( )
event pfc_cst_zip_package ( )
event pfc_cst_relationship_report ( )
event pfc_cst_ama_api ( )
event pfc_cst_regen_track_ids ( )
event ue_refresh_dw_standing ( )
event ue_refresh_dw_red_flag ( )
event ue_facility_notes ( )
event pfc_cst_extract_ver_doc ( )
event pfc_cst_workflow_action_edit ( )
dw_photo_settings dw_photo_settings
st_provider_border st_provider_border
cb_rehelp cb_rehelp
cb_recred cb_recred
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
pb_home pb_home
dw_red_flag_count dw_red_flag_count
cb_close cb_close
cb_notes cb_notes
cb_add cb_add
p_prac_photo p_prac_photo
cb_1 cb_1
cb_save cb_save
cb_addcb cb_addcb
cb_print cb_print
cb_next cb_next
cb_prior cb_prior
cb_b3 cb_b3
cb_b4 cb_b4
cb_b5 cb_b5
cb_b6 cb_b6
cb_b7 cb_b7
cb_delete cb_delete
uo_app_stat uo_app_stat
dw_standing dw_standing
tab_1 tab_1
dw_tab_buttons dw_tab_buttons
st_tabname st_tabname
dw_p_data dw_p_data
p_buttons p_buttons
st_buttons st_buttons
end type
global w_prac_data_1 w_prac_data_1

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables
pfc_n_cst_ai_action_items inv_action_items
pfc_n_cst_ai_printletters inv_printletters
str_dashboard str_para  //Added by Nova on 2008-08-13
w_prac_data_1 iw_prac_data

long ii_verifying_facility_id
long ii_parent_facility_id
long ii_parent_facility_id_ori //SK Practitioner Folder - alfee 09.03.2010
Integer ii_column_cnt
integer ii_photo_search_only = 0  //maha 05-19-2011

Integer ii_org_id = 1
integer ii_wf_new_practitioner //Added for Work Flow 10/26/2006 Henry
integer  il_pd_notes_cnt
integer ii_prac_age

Long il_prac_id 
Long il_prac_id_ori //SK Practitioner Folder - alfee 09.03.2010
Long il_rec_id
Long il_data_view = 1
long	il_oriWidth , il_oriHeight
Long il_affil_rec_id  //maha 12.08.2014

Boolean ib_new_prac = False
Boolean ib_setup_dddw = True
Boolean ib_refresh_screen_list = False
Boolean ib_app_audit_complete = False
Boolean ib_win_just_opened = True
Boolean ib_app_audit_retrieved = False
Boolean ib_site_survey_retrieved = False
Boolean ib_meetings_retrieved = False
Boolean ib_affil_stat_retrieved = False
Boolean ib_verif_info_retrieved = False
Boolean ib_image_info_retrieved = False
Boolean ib_priv_retrieved
Boolean ib_net_retrieved = False
boolean ib_tab_seleted   // mbs 03 Jan 2006 
boolean ib_from_ssn = false  //maha 10.03.06 #631
Boolean ib_contract_retrieved = False//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)

//For identifying whether the tab page has been opended.
boolean	ib_page2_selected,ib_page3_selected,ib_page4_selected,ib_page5_selected,ib_page6_selected 
boolean  ib_page7_selected,ib_page8_selected,ib_page9_selected,ib_page10_selected 
Boolean ib_auto_locate
Boolean ib_imageocx_showed = False //Added by Ken.Guo on 2008-11-07
Boolean ib_page7_firsttime = TRUE //Alfee 03.03.2010
//For identifying whether the dw in the tab page needs to be updated by setting the value of them to TRUE/FALSE.
boolean  ib_page4_refresh, ib_page5_refresh //add by 04.11.2006
Boolean ib_save = FALSE //in save process or not; SK Practitioner Folder - alfee 09.07.2010
Boolean ib_validate_image = TRUE //SK Practitioner Folder - alfee 09.07.2010
boolean ib_skip_inactive_mess = false
boolean ib_run_profile = false //evan 06.06.2012
boolean ib_run_notification = false //maha 10.26.2012
boolean ib_recred = false  //maha 10.05.2015


String is_rec_id_col_nm
String is_column_names[]
String is_view_type = "D"
string	is_facility_name , is_full_name
string is_prac_title  //maha 03.08.2013

DateTime idt_de_complete , idt_audit_complete, idt_verif_complete, idt_approval_complete  






end variables

forward prototypes
public function integer of_setup_title ()
public function integer of_retrieve_prac ()
public function integer of_retrieve_data_entry ()
public function integer of_retrieve_app_audit ()
public function integer of_retrieve_verif_info ()
public function integer of_retrieve_affil_stat ()
public function integer of_retrieve_site_survey ()
public function integer of_retrieve_meetings ()
public function integer of_retrieve_images ()
public function integer of_retrieve_privs ()
public function integer of_retrieve_net ()
public function integer of_app_audit (long al_appt_stat_id)
public function integer of_get_parent_facility (integer ai_facil_id)
public function integer of_se ()
public subroutine of_registerresize (integer ai_index)
public function integer of_updatecheck (powerobject apo_control[], ref powerobject apo_control_update[])
public function integer of_is_de_complete ()
public function integer of_new_prac (string as_from)
public function integer of_setup_title_search ()
public function integer of_validate_image ()
public function integer of_setresize (boolean ab_switch)
public subroutine of_dashboard (string as_facility_name, long ai_prac_id, long ai_facility_id)
public function integer of_setfocus ()
public subroutine of_app_color (long al_rgb)
public function integer of_get_photo_data (long al_prac, long al_facil)
public function integer of_photo_hide ()
public function integer of_buttons_visible (boolean ab_save, boolean ab_add, boolean ab_delete, boolean ab_next, boolean ab_prior, boolean ab_notes, boolean ab_print, boolean ab_3, boolean ab_4, boolean ab_5, boolean ab_6, boolean ab_7)
public function integer of_facility_specific_data ()
public function integer of_button_settings ()
public function boolean of_isrunprofile ()
public function integer of_notification (long al_prac_id)
public function integer of_set_cb_notes_text ()
public function integer of_photo_visible_hide (integer ai_tab)
public function integer of_retrieve_contract ()
public function integer of_next_tab (string as_dir)
public function integer of_reset_prac ()
public function integer of_next_tab_visible (integer ai_from, boolean ab_forward)
public function boolean of_is_tab_visible (integer ai_tab)
public function string of_get_name (integer ai_tab)
public function integer of_button_recred ()
public function boolean of_is_recred (long al_prac, long al_facil)
public function integer of_photo_data_settings ()
public subroutine of_zoom ()
end prototypes

event ue_post_open();
if not ib_tab_seleted then 
  tab_1.SelectTab(2)
end if 

ib_tab_seleted = false
//tab_1.SetRedraw(True)


//GarbageCollect()
end event

event pfc_cst_app_audit_complete;tab_1.tabpage_app_audit.uo_app_audit.triggerevent("pfc_cst_app_audit_complete")//modified maha 042304   of_app_audit_complete()
tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()
//uo_app_stat.of_get_status( il_prac_id, tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id() )
uo_app_stat.of_get_status_rec( il_affil_rec_id )  //Start Code Change ----12.08.2014 #V14.2 maha - changed function

end event

event pfc_cst_compose_request;tab_1.tabpage_app_audit.uo_app_audit.TriggerEvent("pfc_cst_compose_request")
end event

event pfc_cst_dial_phone;IF tab_1.SelectedTab = 3 THEN
	tab_1.tabpage_app_audit.uo_app_audit.TriggerEvent("pfc_cst_dial_phone")
ELSE
	tab_1.tabpage_verif.uo_verif_summary.TriggerEvent("pfc_cst_dial_phone")
END IF
end event

event pfc_cst_de_complete();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
if of_validate_image() = 1 then return 
//---------------------------- APPEON END ----------------------------


tab_1.tabpage_detail.uo_data_entry.of_set_data_entry_complete()
tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()
//uo_app_stat.of_get_status( il_prac_id, tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id() )
uo_app_stat.of_get_status_rec( il_affil_rec_id )  //Start Code Change ----12.08.2014 #V14.2 maha - changed function
end event

event pfc_cst_print_letters;tab_1.tabpage_verif.uo_verif_summary.TriggerEvent( "pfc_cst_print_letters" )
end event

event pfc_cst_copy_row;tab_1.tabpage_app_audit.uo_app_audit.TriggerEvent( "pfc_cst_copy_row" )
end event

event pfc_cst_field_defaults;Tab_1.tabpage_detail.uo_data_entry.TriggerEvent( "pfc_cst_field_defaults" )
end event

event pfc_cst_next_de_screen;tab_1.tabpage_detail.uo_data_entry.of_select_de_screen("N")
end event

event pfc_cst_prior_de_screen;tab_1.tabpage_detail.uo_data_entry.of_select_de_screen("P")
end event

event pfc_cst_reverify_data;tab_1.tabpage_verif.uo_verif_summary.of_reverify_verif_data()
end event

event pfc_cst_copy_verifications;tab_1.tabpage_verif.uo_verif_summary.of_copy_verifications()
end event

event pfc_cst_goto_web;tab_1.tabpage_verif.uo_verif_summary.TriggerEvent("pfc_cst_goto_web")
end event

event pfc_cst_update_dddw;tab_1.tabpage_detail.uo_data_entry.TriggerEvent( "pfc_cst_update_dddw" )
end event

event pfc_cst_retrieve_app_audit_data;tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()
end event

event pfc_cst_lookup_search();tab_1.tabpage_detail.uo_data_entry.of_lookup_search("A")

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 06.18.2009
//$<reason> Menu readonly security
/*
IF IsValid(m_pfe_cst_data_entry) THEN
	m_pfe_cst_data_entry.m_edit.m_insert.enabled = True
	m_pfe_cst_data_entry.m_edit.m_delete1.enabled = True
END IF
*/
//------------------- APPEON END ---------------------
end event

event pfc_cst_delete_verification;tab_1.tabpage_verif.uo_verif_summary.of_Delete_Verification()
end event

event pfc_cst_add_ver_entry;tab_1.tabpage_detail.uo_data_entry.of_add_ver_entry()
end event

event pfc_cst_npdb_export;tab_1.tabpage_verif.uo_verif_summary.TriggerEvent( "pfc_cst_npdb_export" )
end event

event pfc_cst_run_report;tab_1.tabpage_profile.uo_profile.of_Run_Report()
end event

event pfc_cst_print_report();long Job

//maha 071105 cleaned up and added functioality for each tab where necessary
IF tab_1.SelectedTab = 1 THEN //search
	if gi_print_dialog = 1 then PrintSetup()  //Start Code Change ----10.03.2011 #V12 maha
	Job = PrintOpen() //maha 071105
	PrintScreen(Job, 50,50,7500,5600) //these are positions on the printed page
	PrintClose(Job)
ELSEIF tab_1.SelectedTab = 2 THEN	//cred data
	if gi_print_dialog = 1 then PrintSetup()  //Start Code Change ----10.03.2011 #V12 maha - modify to show print dialog box
	Job = PrintOpen() //maha 071105
	//tab_1.tabpage_detail.uo_data_entry.dw_detail.Print()
	PrintScreen(Job, 50,50,7500,5600) //these are positions on the printed page
	PrintClose(Job)
ELSEIF tab_1.SelectedTab = 3 THEN  //app_audit maha 082101
	tab_1.tabpage_app_audit.uo_app_audit.of_Print_list()
ELSEIF tab_1.SelectedTab = 4 THEN //appointment status
	if gi_print_dialog = 1 then PrintSetup()  //Start Code Change ----10.03.2011 #V12 maha
	Job = PrintOpen() //maha 071105
	PrintScreen(Job, 50,50,7500,5600) //these are positions on the printed page
	PrintClose(Job)
ELSEIF tab_1.SelectedTab = 5 THEN //verifs maha 071105
	tab_1.tabpage_verif.uo_verif_summary.of_print_report()
ELSEIF tab_1.SelectedTab = 6 THEN //profiles
	tab_1.tabpage_profile.uo_profile.of_Print_Report()
ELSEIF tab_1.SelectedTab = 7 THEN //images
	tab_1.tabpage_image.uo_image.of_Print()
ELSEIF tab_1.SelectedTab = 8 THEN  //privs maha 052901
	tab_1.tabpage_privileges.uo_priv.of_Print()
ELSEIF tab_1.SelectedTab = 9 then //application stat
	tab_1.tabpage_net.uo_net.of_gen_report( )
ELSEIF tab_1.SelectedTab = 10 then //meetings maha 071105
	tab_1.tabpage_meetings.uo_meetings.of_report( )

END IF
end event

event pfc_cst_delete_survey;//tab_1.tabpage_site.uo_survey.Event pfc_cst_delete_survey()
end event

event pfc_cst_print_survey;//tab_1.tabpage_site.uo_survey.Event pfc_cst_print_survey()
end event

event pfc_cst_priorpage();if tab_1.selectedtab = 4 then
	tab_1.tabpage_apptmnt_status.uo_affill_status.TriggerEvent( "pfc_cst_priorpage" )
elseif tab_1.selectedtab = 2 then //Start Code Change ----03.27.2012 #V12 maha
	tab_1.tabpage_detail.uo_data_entry.TriggerEvent(  "pfc_cst_priorrecord")
else	
	tab_1.tabpage_image.uo_image.TriggerEvent( "pfc_cst_priorpage" )
	
end if
end event

event pfc_cst_nextpage();///messagebox("","next page")
if tab_1.selectedtab = 4 then
	tab_1.tabpage_apptmnt_status.uo_affill_status.TriggerEvent( "pfc_cst_nextpage" )
elseif tab_1.selectedtab = 7 then	
	tab_1.tabpage_image.uo_image.TriggerEvent(  "pfc_cst_nextpage" )
elseif tab_1.selectedtab = 2 then
	tab_1.tabpage_detail.uo_data_entry.TriggerEvent(  "pfc_cst_nextrecord")
end if
end event

event pfc_cst_batch_print;tab_1.tabpage_image.uo_image.of_batch_print()
end event

event pfc_cst_a_select;tab_1.tabpage_image.uo_image.Event pfc_cst_a_select()
end event

event pfc_cst_a_note;tab_1.tabpage_image.uo_image.Event pfc_cst_a_note()
end event

event pfc_cst_a_highlight;tab_1.tabpage_image.uo_image.Event pfc_cst_a_highlight()
end event

event pfc_cst_a_stamptext;tab_1.tabpage_image.uo_image.Event pfc_cst_a_stamptext()
end event

event pfc_cst_a_delete;tab_1.tabpage_image.uo_image.Event pfc_cst_a_delete()
end event

event pfc_cst_save_image;tab_1.tabpage_image.uo_image.Event pfc_cst_save_image()
end event

event pfc_cst_page_properties;tab_1.tabpage_image.uo_image.Event pfc_cst_page_properties()
end event

event pfc_cst_clear_print;tab_1.tabpage_verif.uo_verif_summary.Event pfc_cst_clear_print()
end event

event pfc_cst_straighten_page;tab_1.tabpage_image.uo_image.TriggerEvent( "pfc_cst_straighten_page" )
end event

event pfc_cst_rotate;tab_1.tabpage_image.uo_image.TriggerEvent( "pfc_cst_rotate" )
end event

event pfc_cst_undo();tab_1.tabpage_image.uo_image.TriggerEvent( "pfc_cst_undo" )
end event

event pfc_cst_print_net_dev_ltr;tab_1.tabpage_net.uo_net.Event pfc_cst_print_net_dev_ltr( )
end event

event pfc_cst_print_net_dev_report;tab_1.tabpage_net.uo_net.Event pfc_cst_print_net_dev_report()


end event

event pfc_cst_iverify;tab_1.tabpage_verif.uo_verif_summary.TriggerEvent("pfc_cst_iverify")
end event

event pfc_cst_multi_app;tab_1.tabpage_apptmnt_status.uo_affill_status.Event pfc_cst_multi_app()
end event

event pfc_cst_prac_notes();string ls_parm

ls_parm = string(il_prac_id) + "*" + string(ii_parent_facility_id)

//openwithparm(w_prac_note,il_prac_id)
openwithparm(w_prac_note, ls_parm)

of_set_cb_notes_text() //Start Code Change ----03.20.2013 #V12 maha 

end event

event pfc_cst_null_affil_dates;tab_1.tabpage_apptmnt_status.uo_affill_status.of_null_dates()//maha 020702
end event

event pfc_cst_facility_specific_data();//OpenWithParm( w_facility_specific_data, String( ii_parent_facility_id ) + "-" + String( il_prac_id ) )
of_facility_specific_data()  //Start Code Change ----03.26.2012 #V12 maha - changed to function call
end event

event pfc_cst_net_dev_filter;tab_1.tabpage_net.uo_net.Event pfc_cst_net_dev_filter()
end event

event pfc_cst_print_apps_from_pf;tab_1.tabpage_net.uo_net.Event pfc_cst_print_apps_from_pf( )
end event

event pfc_cst_refresh_net_dev_ai;tab_1.tabpage_net.uo_net.Event pfc_cst_refresh_net_dev_ai( )
end event

event pfc_cst_reappoint;tab_1.tabpage_net.uo_net.Event pfc_cst_reappoint()
end event

event pfc_cst_make_inactive;tab_1.tabpage_net.uo_net.Event pfc_cst_make_inactive( )
end event

event pfc_cst_make_active;tab_1.tabpage_net.uo_net.Event pfc_cst_make_active( )
end event

event pfc_cst_add_cme();tab_1.tabpage_meetings.uo_meetings.Event pfc_cst_add_cme()
end event

event pfc_cst_meeting_report;tab_1.tabpage_meetings.uo_meetings.Event pfc_cst_meeting_report( )
end event

event pfc_cst_appt_note;tab_1.tabpage_apptmnt_status.uo_affill_status.of_appoint_note()
end event

event pfc_cst_scan_oig;tab_1.tabpage_verif.uo_verif_summary.TriggerEvent( "pfc_cst_scan_oig" )
end event

event pfc_cst_email_documents;tab_1.tabpage_image.uo_image.of_email_documents ( )
end event

event pfc_cst_add_missing_audit_items;tab_1.tabpage_app_audit.uo_app_audit.TriggerEvent( "pfc_cst_add_missing_items" )
end event

event pfc_cst_priv_batch;tab_1.tabpage_privileges.uo_priv.TriggerEvent( "pfc_cst_priv_batch" )
end event

event pfc_cst_prac_invoice();//Start Code Change ----08.17.2016 #V153 maha - modified for new coded window
integer li_set

li_set = integer(gnv_data.of_getitem( 'icred_settings', 'set_35', False))

if li_set = 2 then  //new window
	OpenwithParm ( w_invoice, gl_prac_id)	
elseif li_set = 1 then
	OpenwithParm ( w_invoice_14, gl_prac_id)
end if


end event

event pfc_cst_fax_image_documents;tab_1.tabpage_image.uo_image.Event pfc_cst_fax_image_documents( )
end event

event pfc_cst_screen_capture;tab_1.tabpage_verif.uo_verif_summary.Event pfc_cst_screen_capture()
end event

event pfc_cst_delete_all_images;tab_1.tabpage_image.uo_image.of_Delete_all_images()
end event

event pfc_cst_add_missing_audit_items_force();//////////////////////////////////////////////////////////////////////
// $<event>w_mainpfc_cst_add_missing_audit_items_force()
// $<arguments>(None)
// $<returns> 
// $<description> Required Documents Check Box on Data Entry Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.17.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
tab_1.tabpage_app_audit.uo_app_audit.TriggerEvent( "pfc_cst_add_missing_items_force" )

end event

event pfc_cst_verif_workflow();//Added for work flow. 14/11/2006 Henry

tab_1.tabpage_verif.uo_verif_summary.TriggerEvent("pfc_cst_manual_workflow")
end event

event pfc_cst_application_workflow();//Added for work flow. 14/11/2006 Henry
tab_1.tabpage_net.uo_net.TriggerEvent("pfc_cst_manual_workflow")
end event

event pfc_cst_select_scanner();//Start Code Change ----02.21.2008 #V8 maha - added
tab_1.tabpage_image.uo_image.of_scanner_select()
end event

event pfc_cst_import_photo();//------------------------------------------------------------------------------
// Event: pfc_cst_Import_Photo()
//------------------------------------------------------------------------------
// Description: Import Photo
// Arguments:
//		None
// Return Value: 
//		None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-10
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

//tab_1.tabpage_detail.uo_data_entry.Event pfc_cst_import_photo()
p_prac_photo.event doubleclicked( ) //alfee 10.08.2010

end event

event pfc_cst_verif_send_to_history();tab_1.tabpage_verif.uo_verif_summary.of_send_verif_to_history()
end event

event pfc_cst_find_missing_verifs();tab_1.tabpage_verif.uo_verif_summary.of_find_missing_verif()
end event

event pfc_cst_clear_photo();
//Start Code Change ----07.22.2009 #V92 maha - added
tab_1.tabpage_detail.uo_data_entry.of_delete_photo()
end event

event pfc_cst_cvo_data();long li_prac
long li_rec
long li_fac
long li_ver
integer r
gs_variable_array la_ids

r = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getrow()
if r < 1 then  return  //Start Code Change ----01.19.2016 #V15 maha - error trapping
//r = this.tab_1.tab  
li_prac = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(r,"prac_id")
li_rec = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(r,"rec_id")
li_fac = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(r,"parent_facility_id")
li_ver = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(r,"verifying_facility")

la_ids.as_number[1] = li_prac
la_ids.as_number[2] = li_rec
la_ids.as_number[3] = li_fac
la_ids.as_number[4] = li_ver


openwithparm(w_cvo_screen,la_ids)
end event

event pfc_cst_clear_changes();//Start Code Change ----03.18.2010 #V10 maha - Added to clears all changes made on a Screen.
integer li_tab
integer r
datawindow ldw_cur

debugbreak()
li_tab = tab_1.selectedtab

choose case li_tab
	case 2 //dataentry
		ldw_cur = tab_1.tabpage_detail.uo_data_entry.dw_detail
		ldw_cur.accepttext()
		r = tab_1.tabpage_detail.uo_data_entry.dw_detail.getrow()
		of_clear_changed_data(ldw_cur,r)
		ldw_cur.retrieve()
		ldw_cur.scrolltorow(r)
		
	case 4 //maha 10.31.2012  - will not work per current design of  of_clear_changed_data
//		choose case tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.selectedtab
//			case 2 
//				ldw_cur = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status
//				ldw_cur.accepttext()
//				r = ldw_cur.getrow()
//			case 3
//				ldw_cur = idw_active
//				ldw_cur.accepttext()
//				r = ldw_cur.getrow()
//		end choose
//		
//		of_clear_changed_data(ldw_cur,r)
		
end choose
end event

event type integer ue_refresh_tv_search();//SK Practitioner Folder - alfee 09.07.2010

return 1

end event

event pfc_cst_add_redflagdata();//==================================================
// $<Event> pfc_cst_add_redflagdata ()
// $<arguments>(none)
// $<returns> (none)
// $<description> red flag data:open w_red_flag_add and pass different parameter
// $<add> (Appeon) long.zhang 07.15.2011
//================================================== 
str_rfd_data ls_str_rfd
choose case  tab_1.selectedtab
	case 2 //Credentials
		ls_str_rfd.s_type = "DE"
		ls_str_rfd.u_datawindow =  tab_1.tabpage_detail.uo_data_entry.dw_detail
	case 4	//Appointments
		if tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.selectedtab = 4 then
			ls_str_rfd.s_type = "AttQ"
			ls_str_rfd.u_datawindow = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.dw_quest
		else
			ls_str_rfd.s_type = "APPT"
			ls_str_rfd.u_datawindow = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status
		end if
	case 5 //verifications	
		ls_str_rfd.s_type = "VER"
		ls_str_rfd.u_datawindow = tab_1.tabpage_verif.uo_verif_summary.dw_detail
	case 8	//privileges	
		ls_str_rfd.s_type = "PRIV"
		ls_str_rfd.u_datawindow = tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail
end choose
ls_str_rfd.w_prac = this
OpenWithParm(w_red_flag_add,ls_str_rfd)
end event

event pfc_cst_import_signature();//==================================================
// $<Event> pfc_cst_import_signature ()
// $<arguments>(none)
// $<returns> (none)
// $<description> E-sign: open import E-sign Window
// $<add> (Appeon) long.zhang 08.04.2011
//================================================== 
string ls_param
ls_param=string(il_prac_id) + "-" + string(ii_parent_facility_id)
OpenWithParm(w_prac_signature,ls_param)

end event

event pfc_cst_set_historical();tab_1.tabpage_image.uo_image.of_set_historical( )
end event

event pfc_cst_pop_website();tab_1.tabpage_net.uo_net.Event pfc_cst_pop_website( ) //Added by evan 11.01.2011 - V12.1 Website Population
end event

event pfc_cst_add_wv_user(long al_prac_id);if gl_prac_id = -999 then
	messagebox("Add WebView User","The provider record must be saved before the user record can be created.")
	return 
else
	openwithparm(w_security_user_add_wv, string(gl_prac_id) + "@0" )
end if
end event

event ue_undo_data();//Start Code Change ----09.25.2012 #V12 maha - added
Long li_index1
Long li_index2
li_index1 = tab_1.SelectedTab
Choose Case li_index1
	case 1 //search

	Case 2 //data entry
		tab_1.tabpage_detail.uo_data_entry.dw_detail.getrow()
 		tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_detail.uo_data_entry.dw_detail)
	Case	3	//Application Audit
		
		tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_app_audit.uo_app_audit.dw_detail )
	Case	4	//Appointment Status
		li_index2 = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectedTab
		Choose Case li_index2
			Case	1 //browse
				
			Case	2
				tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data( tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status )
			Case	3
				//tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.dw_staff_cat.Post SetFocus()
			Case	4
				//tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.dw_quest.Post SetFocus()
		End Choose
	Case	5 //Verification
		li_index2 = tab_1.tabpage_verif.uo_verif_summary.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
			Case	2
					tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_verif.uo_verif_summary.dw_detail)
			Case	3
		End Choose
	Case	6	//Profile

	Case	7 //Imaging
//		li_index2 = tab_1.tabpage_image.uo_image.tab_view.SelectedTab
//		Choose Case li_index2
//			Case	1
//			//	tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.Post SetFocus()
//			Case	2
//			//	tab_1.tabpage_image.uo_image.tab_view.tabpage_image.ole_scan_edit.Post SetFocus()
//			Case	3
//			//	tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_data.Post SetFocus()
//		End Choose
	Case	8 //Privs
		li_index2 = tab_1.tabpage_privileges.uo_priv.tab_1.SelectedTab
		Choose Case li_index2
			Case	1

			Case	2
					tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail )
			Case	3

		End Choose
	Case	9 //Net
		li_index2 = tab_1.tabpage_net.uo_net.tab_1.SelectedTab
		Choose Case li_index2
			Case	1
					tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev )
			Case	2
					tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_net.uo_net.tab_1.tabpage_ids.dw_ids)
			Case	3
					tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_net.uo_net.tab_1.tabpage_notes.dw_notes)
			Case	4
					//reports
		End Choose
	Case	10 //Meeting
		li_index2 = tab_1.tabpage_meetings.uo_meetings.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
			Case	2
				tab_1.tabpage_detail.uo_data_entry.inv_data_entry.of_undo_data(tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_detail.dw_detail )
		End Choose
End Choose

end event

event pfc_cst_zip_package();//====================================================================
//$<Event>: pfc_cst_zip_package
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-07-11 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

str_prac_id  lstr_open_from

lstr_open_from.types = 'ver-app'
lstr_open_from.prac_id = il_prac_id
lstr_open_from.facility_id = ii_parent_facility_id
Openwithparm( w_package_screen, lstr_open_from) //alfee 10.23.2013
//OpenSheetwithparm( w_package_screen, lstr_open_from, w_mdi, 0, Original!)
end event

event pfc_cst_relationship_report(); //Start Code Change ----03.03.2016 #V15 maha - added - migrated from button
gs_report_variables lst_val

lst_val.as_report_object = "d_rpt_entity_relations_tv"
//lst_val.as_report_object = "d_tv_smokey"
lst_val.as_value[1] = string(il_prac_id)
lst_val.ai_num_variables = 1
lst_val.as_var_type[1] = "N"
lst_val.ab_treeview = True
lst_val.as_single = "S"
 
 openwithparm(w_report_view,lst_val)
end event

event pfc_cst_ama_api();//Start Code Change ----05.23.2016 #V152 maha
tab_1.tabpage_verif.uo_verif_summary.of_ama_api()
end event

event pfc_cst_regen_track_ids();//Start Code Change ----06.29.2016 #V152 maha
tab_1.tabpage_net.uo_net.Event pfc_cst_regen_trackids( )
end event

event ue_refresh_dw_standing();//Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
dw_standing.retrieve( il_affil_rec_id )  

end event

event ue_refresh_dw_red_flag();//Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
dw_red_flag_count.retrieve( il_prac_id )

end event

event ue_facility_notes(); //Start Code Change ----05.02.2017 #V154 maha
 long ll_facility
 integer r

 
 choose case tab_1.selectedtab
	case 3	//checklist - not currently available (4-2017)
		r = tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities.getrow()
		ll_facility = tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities.GetItemNumber( r, "parent_facility_id" )
	case 4	//appointment
		r = tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities.getrow()
		ll_facility = tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities.GetItemNumber( r, "parent_facility_id" )
	case 5	//Verif
		r = tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.getrow()
		ll_facility = tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities	.GetItemNumber( r, "parent_facility_id" )
	case 8	//Priv
		r = tab_1.tabpage_privileges.uo_priv.dw_select.getrow()
		ll_facility = tab_1.tabpage_privileges	.uo_priv.dw_select.GetItemNumber( r, "parent_facility_id" )
	case 9	//Appl
		r =  tab_1.tabpage_net.uo_net.dw_orgs_facilities.getrow()
		ll_facility = tab_1.tabpage_net.uo_net.dw_orgs_facilities.GetItemNumber( r, "parent_facility_id" )
	case else
		 ll_facility = ii_parent_facility_id
end choose

openwithparm(w_facility_notes, ll_facility)

//messagebox("","Facility notes")
end event

event pfc_cst_extract_ver_doc();//Start Code Change ----11.16.2017 #V154 maha
gs_pass_ids lst_ids
string ls_path

ls_path = gs_temp_path
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)

lst_ids.s_stringval = ls_path
lst_ids.prac_id = il_prac_id
lst_ids.facility_id = ii_parent_facility_id

openwithparm(w_extract_prac_verif_docs, lst_ids)
end event

event pfc_cst_workflow_action_edit();//Start Code Change ----12.04.2017 #V16 maha
tab_1.tabpage_net.uo_net.of_edit_workflow_actions()
end event

public function integer of_setup_title ();String ls_name
String ls_facility_name
string ls_age //maha 10.24.2012
integer li_age //maha 10.24.2012
Integer li_parent_facility_id
integer li_set //maha 03.08.2013

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 01.25.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
li_parent_facility_id = tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id()

nv_prac_info lnv_full_name
lnv_full_name = CREATE nv_prac_info
ls_name = lnv_full_name.of_get_name( il_prac_id )
DESTROY lnv_full_name	
SELECT facility.facility_name  
INTO :ls_facility_name  
FROM facility  
WHERE facility.facility_id = :li_parent_facility_id   ;
*/
ls_name = is_full_name
ls_facility_name = is_facility_name
//---------------------------- APPEON END ----------------------------

//Start Code Change ----10.24.2012 #V12 maha
ii_prac_age = of_get_prac_age(il_prac_id)
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//li_set = of_get_app_setting("set_58","I")
li_set = of_get_app_setting("set_91","I")
//---------End Modfiied ------------------------------------------------------
//if of_get_app_setting("set_58","I") = 2 then
if li_set = 1 or li_set = 2  then  //Start Code Change ----03.08.2013 #V12 maha - change for both settings
	if ii_prac_age = -9999 then
		ls_age = " Age: Unknown"
	else
		ls_age = " Age: " + string(ii_prac_age)
	end if
else
	ls_age = ''
end if
//End Code Change ----10.24.2012

is_prac_title = ls_name + " - " + String( il_prac_id ) + "  (" + ls_facility_name + ")" + ls_age  //(Appeon)Stephen 11.07.2017 - Alpha Testing Bug # 5871- IntelliApp-> Refresh issue: Adding a new provider still shows previous providers name at bottom instead of new
This.Title = ls_name + " - " + String( il_prac_id ) + "  (" + ls_facility_name + ")" + ls_age





	
	
Return 0
end function

public function integer of_retrieve_prac ();
//il_prac_id = gl_prac_id		//commented by long.zhang 06.20.2013  Refreshing Issue
il_data_view = gl_data_view_id

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<comment> 01.13.2006 By: Ye KaiChun
//$<reason> The CreatePage function of UserObject object is currently unsupported.
//$<modification> Comment the following script and provide the same fucntionality by
//$<modification> using SelectTab function in the following script.

//Tab_1.tabpage_detail.CreatePage()
//Tab_1.tabpage_apptmnt_status.CreatePage()
//Tab_1.tabpage_verif.CreatePage()

//---------------------------- APPEON END ----------------------------

window lw
lw  = this


String ls_name
String ls_facility_name

ib_net_retrieved  = False
ib_affil_stat_retrieved = False
ib_meetings_retrieved = False
ib_site_survey_retrieved = False
ib_verif_info_retrieved = False
ib_app_audit_retrieved = False
ib_image_info_retrieved = False
ib_priv_retrieved = False //maha 012301
ib_contract_retrieved = False//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 01.23.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> 1)Check the CreateOnDemand property for tab_1. 
//$<modification> 2)Write the following script to create the tabpage_detail if it has not been created.
If not ib_page2_selected Then
	IF il_prac_id = -9 THEN
		ib_new_prac = TRUE
		of_photo_hide()  //Start Code Change ----01.24.2011 #V11 maha - moved
	end if
	tab_1.selecttab(2)
	//if ib_new_prac then of_photo_hide()  //Start Code Change ----01.12.2011 #V11 maha 
End If
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_apptmnt_status.uo_affill_status.of_Reset()
// mskinner 30 March 2005 -- begin
// getting argument error
//tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_Parent_Window( this)
tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_Parent_Window( lw )
// mskinner 30 March 2005 -- end 
if not ib_tab_seleted then 
  tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectTab(2)
end if 


ii_parent_facility_id = gi_parent_facility
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

SELECT pd_affil_stat.verifying_facility  
INTO :ii_verifying_facility_id
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :ii_parent_facility_id )   ;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//The varilable il_pd_notes_cnt will be used in of_menu_security function in w_mdi.\

//Start Code Change ----03.20.2013 #V12 maha - set notes text 
//select count(record_id) into :il_pd_notes_cnt from pd_notes where prac_id = :il_prac_id;
//of_set_cb_notes_text() //Commented by (Appeon)Stephen 2013-08-21 -Bug 3643: The Provider Notes are not counting correctly
//End Code Change ----03.20.2013

//The variable idt_de_complete will be used in the of_is_de_complete function in the pfc_cst_u_apptmnt_status useobject.
//The variable idt_audit_complete,variable idt_verif_complete, variable idt_de_complete and variable idt_approval_complete
//will be used in the of_get_status() function in pfc_cst_u_app_status user object.
SELECT pd_affil_stat.date_app_audit_completed,   
       pd_affil_stat.date_data_entry_completed,   
       pd_affil_stat.date_verif_completed,   
       pd_affil_stat.apptmnt_start_date  
INTO :idt_audit_complete,   
     :idt_de_complete,   
     :idt_verif_complete,   
     :idt_approval_complete  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :gi_parent_facility ) AND
		( pd_affil_stat.active_status in ( 1,4 ) ); 
		
//retrieve the facility name. The facility name will be used in the of_Setup_title function.
integer li_parent_facility_id
li_parent_facility_id = ii_parent_facility_id
SELECT facility.facility_name  
INTO :is_facility_name  
FROM facility  
WHERE facility.facility_id = :li_parent_facility_id   ;

//Retrieve the full name. The full name will be used in the of_setup_title function
SELECT v_full_name.full_name  
INTO :is_full_name  
FROM v_full_name  
WHERE v_full_name.prac_id = :il_prac_id   ;

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//gds_lookup = create datastore
if not IsValid(gds_lookup) then gds_lookup = Create datastore
//---------------------------- APPEON END ----------------------------
gds_lookup.dataobject = 'd_dddw_billing_addresses'
gds_lookup.settransobject( sqlca)
gds_lookup.retrieve(il_prac_id )

gnv_appeondb.of_commitqueue()
If isnull(is_facility_name) Then is_facility_name = ''
//---------------------------- APPEON END ----------------------------

of_set_cb_notes_text()//(Appeon)Stephen 2013-08-21 --Bug 3643: The Provider Notes are not counting correctly

of_reset_prac()   //Start Code Change ----07.10.2015 #V15 maha - added

of_retrieve_data_entry()

of_is_recred(  il_prac_id,  ii_parent_facility_id)

//setup profile tab
// mskinner 30 March 2005 -- begin
// tab_1.tabpage_image.uo_image.of_set_parent( This )
 tab_1.tabpage_image.uo_image.of_set_parent( lw )
// mskinner 30 March 2005 -- end

//setup profile tab
tab_1.tabpage_profile.uo_profile.of_set_facility_Id( ii_parent_facility_id )
tab_1.tabpage_profile.uo_profile.of_set_prac_id( il_prac_id )

//verif_info
//tab_1.tabpage_verif.uo_verif_summary.of_Reset( )  //Start Code Change ----07.10.2015 #V15 maha - moved to of_reset_prac
tab_1.tabpage_verif.uo_verif_summary.of_Set_facility_Id( ii_parent_facility_id )
tab_1.tabpage_verif.uo_verif_summary.of_Set_Prac_Id( il_prac_id )
tab_1.tabpage_verif.uo_verif_summary.of_Set_View_Id( il_data_view )

//appointment stat
tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_parent_facility_Id( ii_parent_facility_id )
tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_prac_id( il_prac_id )

//Meetings
//tab_1.tabpage_meetings.uo_meetings.of_Set_parent_facility_Id( ii_parent_facility_id )
//tab_1.tabpage_meetings.uo_meetings.of_set_prac_id( il_prac_id )


//tab_1.SetRedraw(False)
ib_win_just_opened  = True
//Start Code Change ----05.13.2010 #V10 maha - removed to not resize screen
//This.Width = 3657
//This.Height = 2108
//End Code Change ----05.13.2010
This.x=1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 01.23.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Validate whether tabpage_detail has been opened. If yes then trigger the ue_post_open
//$<modification> event. This is due to the usage of CreateOnDemand property.
//This.PostEvent("ue_post_open")
If ib_page2_selected Then This.PostEvent("ue_post_open")
//---------------------------- APPEON END ----------------------------

//uo_app_stat.of_get_status( il_prac_id, ii_parent_facility_id )
uo_app_stat.of_get_status_rec( il_affil_rec_id )  //Start Code Change ----1208.2014 #V14.2 maha - changed function

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.19.2016
//<$>reason:V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified

// //Start Code Change ----03.24.2015 #V15 maha
//dw_standing.retrieve( il_affil_rec_id )  
//dw_red_flag_count.retrieve( il_prac_id )
Event ue_refresh_dw_standing()
Event ue_refresh_dw_red_flag()
//------------------- APPEON END -------------------

//PostEvent("pfc_postopen")removed maha 041905

tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
of_new_prac( "of_retrieve_prac")

Return 0

end function

public function integer of_retrieve_data_entry ();//retrieve data entry
tab_1.tabpage_detail.uo_data_entry.of_set_verification_info( tab_1.tabpage_verif.uo_verif_summary )
tab_1.tabpage_detail.uo_data_entry.of_set_data_view_id( il_data_view )
tab_1.tabpage_detail.uo_data_entry.of_set_prac_id( il_prac_id )
tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id( ii_parent_facility_id )
tab_1.tabpage_detail.uo_data_entry.of_set_affil_recid(il_affil_rec_id)   //Start Code Change ----07.15.2015 #V15 maha - for attest quest

IF This.Title = "Screen Painter" THEN
	This.y = 194
	tab_1.tabpage_search.uo_search.Visible = False
ELSE
	This.y=1
END IF
IF il_prac_id = -9 THEN
	ib_new_prac = True
	il_prac_id = gnv_app.of_Get_Id("PRAC_ID")
		gl_prac_id = il_prac_id
	tab_1.tabpage_detail.uo_data_entry.of_set_prac_id( il_prac_id )	
	il_rec_id = gnv_app.of_Get_Id("RECORD_ID")
	This.Title = "New"
	uo_app_stat.of_Reset( )	
ELSE
	ib_new_prac = false
	of_setup_title()
END IF
// mskinner 30 March 2005 -- begin
window lw
lw = this
// tab_1.tabpage_detail.uo_data_entry.of_set_parent_window( This )
  tab_1.tabpage_detail.uo_data_entry.of_set_parent_window( lw )
// mskinner 30 March 2005 -- end
tab_1.tabpage_detail.uo_data_entry.of_setup( ib_new_prac )
tab_1.tabpage_detail.uo_data_entry.of_set_verifying_facility( ii_verifying_facility_id )

Return 0
end function

public function integer of_retrieve_app_audit ();//retrieve app audit
IF tab_1.tabpage_app_audit.Visible THEN
	//Start Code Change ----12.07.2010 #V10 maha - this should work like intelliapp - removed exception for sk
	IF Upper( gs_cust_type ) = "I" THEN
	//IF Upper( gs_cust_type ) = "I" AND NOT gb_sk_ver THEN //SK Practitioner Folder - alfee 11.02.2010
	//End Code Change ----12.07.2010
		tab_1.tabpage_app_audit.uo_app_audit.of_Set_parent_facility_Id( 1 )
	ELSE
		tab_1.tabpage_app_audit.uo_app_audit.of_Set_parent_facility_Id( ii_parent_facility_id )
	END IF
	tab_1.tabpage_app_audit.uo_app_audit.of_Retrieve( il_prac_id )	
END IF

//Start Code Change ----06.16.2009 #V92 maha
if w_mdi.of_security_access(90) = 1 then
	tab_1.tabpage_app_audit.uo_app_audit.of_set_security( )
	//-------------------appeon begin-------------
	//<$>added:long.zhang 02.28.2013
	//<$>reason refresh dddw  Bug 3420
	if appeonGetClientType() = "PB" then
		tab_1.tabpage_app_audit.uo_app_audit.of_refresh_dddw( )
	end if
	//-----------------appeon end----------------
else
	//Start Code Change ----09.12.2012 #V12 maha - no edit functionality
	if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
		tab_1.tabpage_app_audit.uo_app_audit.dw_detail.Modify( "notes.protect = '1'" )
		tab_1.tabpage_app_audit.uo_app_audit.dw_detail.Modify( "notes.background.color= '553648127'")
		tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.Modify( "notes.background.color= '553648127'")
		tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.Modify( "notes.protect = '1'" )
	end if
	//End Code Change ----09.12.2012
end if
//End Code Change---06.16.2009

if w_mdi.of_security_access(7840) > 0 then		 //Start Code Change ----02.08.2017 #V153 maha
	 tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_audit.visible = false
end if

if gb_sk_ver then tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_browse.visible = false  //Start Code Change ----06.24.2010 #V10 maha - SK mod

ib_app_audit_retrieved = TRUE
	
Return 0


end function

public function integer of_retrieve_verif_info ();//\/maha  01-11-00  moved from selection changed event of tab_1  ~line 55
String ls_screen_name
Long ll_screen_id

if tab_1.tabpage_detail.uo_data_entry.dw_select_section.GetRow() < 1 then Return -1 //Add by Evan on 11.26.2010
ll_screen_id = tab_1.tabpage_detail.uo_data_entry.dw_select_section.GetItemNumber( tab_1.tabpage_detail.uo_data_entry.dw_select_section.GetRow(), "screen_id" )
ls_screen_name = tab_1.tabpage_detail.uo_data_entry.dw_select_section.GetItemString( tab_1.tabpage_detail.uo_data_entry.dw_select_section.GetRow(), "screen_name" )
tab_1.tabpage_verif.uo_verif_summary.of_Set_Screen( ll_screen_id, ls_screen_name )
//\mike

//retrieve verif data


If not isvalid(inv_action_items) Then inv_action_items =  CREATE pfc_n_cst_ai_action_items
//If not isvalid(inv_printletters) Then inv_printletters =  CREATE pfc_n_cst_ai_printletters

tab_1.tabpage_verif.uo_verif_summary.of_set_inv_action_items( inv_action_items )
tab_1.tabpage_verif.uo_verif_summary.of_Retrieve( il_prac_id )
ib_verif_info_retrieved = True

Return 0
end function

public function integer of_retrieve_affil_stat ();//retrieve affil status

tab_1.tabpage_apptmnt_status.uo_affill_status.of_Retrieve( il_prac_id )

ib_affil_stat_retrieved = TRUE

Return 0
end function

public function integer of_retrieve_site_survey ();//// retrieve site surveys
//IF tab_1.tabpage_net.Visible THEN
////	tab_1.tabpage_net.uo_net.of_Reset()
//	tab_1.tabpage_net.uo_net.of_set_prac_id( il_prac_id )
//	tab_1.tabpage_net.uo_net.of_set_facility_id( ii_parent_facility_id )	
////	tab_1.tabpage_site.uo_survey.of_Retrieve_detail()
//END IF
//
//ib_net_retrieved  = True
//
Return 0
end function

public function integer of_retrieve_meetings ();//RETRIEVE MEETINGS DETAIL
IF tab_1.tabpage_meetings.Visible THEN
	tab_1.tabpage_meetings.uo_meetings.of_Set_Prac_Id( il_prac_id )
	tab_1.tabpage_meetings.uo_meetings.of_Set_Parent_Facility_Id( ii_parent_facility_id )
	tab_1.tabpage_meetings.uo_meetings.of_Retrieve( il_prac_id )
	tab_1.tabpage_meetings.uo_meetings.of_get_this_facility_data()
END IF

ib_meetings_retrieved = True

Return 0
end function

public function integer of_retrieve_images ();//retrieve image data

tab_1.tabpage_image.uo_image.of_Set_prac_id( il_prac_id )
tab_1.tabpage_image.uo_image.of_set_verifying_facility_id( ii_verifying_facility_id )

ib_image_info_retrieved = True

Return 0
end function

public function integer of_retrieve_privs ();//messagebox("","of_retrieve_privs")

//retrieve privileges
//integer	li_row
//	tab_1.tabpage_privileges.uo_priv.dw_select.settransobject(sqlca)
//	tab_1.tabpage_privileges.uo_priv.dw_select.retrieve(il_prac_id,gs_user_id)
//	li_row = tab_1.tabpage_privileges.uo_priv.dw_select.getrow()
//	tab_1.tabpage_privileges.uo_priv.dw_select.scrolltorow(li_row)
//	tab_1.tabpage_privileges.uo_priv.dw_select.setrow(li_row)
//	tab_1.tabpage_privileges.uo_priv.dw_select.selectrow(0,false)
//	tab_1.tabpage_privileges.uo_priv.dw_select.selectrow(li_row,true)
//	tab_1.tabpage_privileges.uo_priv.dw_select.triggerevent(rowfocuschanged!)
//ib_priv_retrieved = true
//
//Return 0

////retrieve app audit
//IF tab_1.tabpage_privileges.Visible THEN
//	//tab_1.tabpage_app_audit.uo_app_audit.of_Set_parent_facility_Id( ii_parent_facility_id )
//if not ib_priv_retrieved then
	tab_1.tabpage_privileges.uo_priv.of_Retrieve_priv( il_prac_id )
	ib_priv_retrieved = TRUE
//END IF
//
//
//	
Return 0
end function

public function integer of_retrieve_net ();// retrieve network dev 
//debugbreak()
IF tab_1.tabpage_net.Visible THEN
	tab_1.tabpage_net.uo_net.of_Reset()
	tab_1.tabpage_net.uo_net.of_set_prac_id( il_prac_id )
	tab_1.tabpage_net.uo_net.of_set_facility_id( ii_parent_facility_id )	
	tab_1.tabpage_net.uo_net.of_retrieve_facilities()
END IF

//Start Code Change ----06.16.2009 #V92 maha
if w_mdi.of_security_access(1400) = 1 then
	tab_1.tabpage_net.uo_net.of_set_security_nd( )
	//-------------------appeon begin-------------
	//<$>added:long.zhang 01.29.2013
	//<$>reason refresh dddw  Bug 3397
	if appeonGetClientType() = "PB" then
		tab_1.tabpage_net.uo_net.of_refresh_dddw( )
	end if
	//-----------------appeon end----------------
else
	//Start Code Change ----09.12.2012 #V12 maha - no edit functionality - moved here 10.10.2012
	if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
		tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev.Modify( "notes.protect = '1'" )
		tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev.Modify("notes.background.color= '553648127'")
	end if
	//End Code Change ----09.12.2012
end if
//End Code Change---06.16.2009

 //Start Code Change ----10.29.2015 #V15 maha - change facility button
if w_mdi.of_security_access(7804) = 0 then
	tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_tracking.Modify( "b_change.visible = '0'" )
end if
 //End Code Change ----10.29.2015

ib_net_retrieved  = True

Return 0
end function

public function integer of_app_audit (long al_appt_stat_id);//this function used for adding checklist data for App customers
n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
n_ds ldw_audit
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
String ls_version

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> There is no need for the Web application to read the local INI file. The Web application
//$<reason> reads INI file from the server.
//$<modification> Make the condition to ensure when the IntelliCred is running on the Web, it does not
//$<modification> reads the local INI file.
//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
//	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName ) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

//app audit
IF MidA( ls_version, 11, 1) <> "4" THEN
	RETURN 0
END IF

//al_appt_stat_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "rec_id" )

ldw_audit = CREATE n_ds
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.of_SetTransObject( SQLCA )

ldw_rqrd_data = CREATE n_ds
//ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data_ia"  //Start Code Change ----01.04.2012 #V12 maha - changed data object
ldw_rqrd_data.of_SetTransObject( SQLCA )

li_row_cnt = ldw_rqrd_data.Retrieve( 1, "I" )
//<add> 07/25/2007 by: Andy
ldw_rqrd_data.setsort( "app_audit_id A" )
ldw_rqrd_data.sort()

Long ll_app_audit_id_old = -1
//end of add

lds_last_app_audit_seq_no = CREATE n_ds
lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
lds_last_app_audit_seq_no.of_SetTransObject( SQLCA )

FOR i = 1 TO li_row_cnt
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.InsertRow( 0 )
	*/
	integer li_auto_generate,li_row	

	li_auto_generate = ldw_rqrd_data.getitemnumber(i,'auto_generate')
	if li_auto_generate = 1 then
		continue
	end if
	li_row = ldw_audit.InsertRow( 0 )
	//---------------------------- APPEON END ----------------------------
	ll_record_id = gnv_app.of_get_id("RECORD_ID")
	ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.18.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "rec_id", ll_record_id )
	ldw_audit.SetItem( i, "appt_stat_id", al_appt_stat_id )
	ldw_audit.SetItem( i, "prac_id", il_prac_id )
	ldw_audit.SetItem( i, "facility_id", 1 )
	ldw_audit.SetItem( i, "app_audit_id", ll_app_audit_id )
	*/
	ldw_audit.SetItem( li_row, "rec_id", ll_record_id )
	ldw_audit.SetItem( li_row, "appt_stat_id", al_appt_stat_id )
	ldw_audit.SetItem( li_row, "prac_id", il_prac_id )
	ldw_audit.SetItem( li_row, "facility_id", 1 )
	ldw_audit.SetItem( li_row, "app_audit_id", ll_app_audit_id )
	
	//---------------------------- APPEON END ----------------------------
	
	//<add> 07/25/2007 by: Andy
	if ll_app_audit_id_old = ll_app_audit_id then
		ll_seq_no ++
	else
	//end of add
		//find out the last seq no used
		ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, il_prac_id, 1 )	
		IF ll_seq_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		//<add> 07/25/2007 by: Andy
		ll_app_audit_id_old = ll_app_audit_id
	end if
	//end of add
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( i, "active_status", 1 )
	ldw_audit.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 	
	*/
	ldw_audit.SetItem( li_row, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( li_row, "active_status", 1 )
	ldw_audit.SetItem( li_row, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( li_row, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		

	ldw_audit.SetItem( li_row, "app_type", ldw_rqrd_data.GetItemString( i, "app_type" )	)		
	//---------------------------- APPEON END ----------------------------
END FOR

IF ldw_audit.Update() = -1 THEN
	messagebox("", sqlca.sqlerrtext)
	MessageBox( "Update Error" , "Error updating application audit data.")
	Return -1
END IF

DESTROY ldw_audit
DESTROY ldw_rqrd_data
DESTROY ldw_app_audit_facility
DESTROY lds_last_app_audit_seq_no


RETURN 0

end function

public function integer of_get_parent_facility (integer ai_facil_id);ii_parent_facility_id = ai_facil_id

return 0
end function

public function integer of_se ();// RP uo_app_stat.x = 1720

IF IsValid( m_pfe_cst_data_entry ) THEN
	m_pfe_cst_data_entry.m_file.m_multiapp.Visible = False
	//m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_multiapp,'ToolBarItemVisible', False)
END IF

Return 1
end function

public subroutine of_registerresize (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>w_prac_data_1of_registerresize()
// $<arguments>
//		value	integer	ai_index	, the index of the tab_1 control	
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.18.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

LONG LL_I
string ls_scale
powerobject lo_powerobjects[]

//this.inv_resize.of_SetOrigSize (il_oriWidth ,  il_oriHeight)
this.inv_resize.of_SetOrigSize (this.workspacewidth() ,  this.workspaceheight())

ls_scale = this.inv_resize.scale

Choose Case ai_index
	Case 2
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search uo_data_entry
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry, ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_details.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_details.CONTrol[LL_I]  , ls_scale )
		next
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_image.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_image.CONTrol[LL_I]  , ls_scale )
		next
		
	Case 3
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search uo_app_audit
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_detail.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_detail.CONTrol[LL_I]  , ls_scale )
		next

	Case 4
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search uo_affill_status
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.CONTrol[LL_I]  , ls_scale )
		next

		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.CONTrol) //alfee 11.18.2010
			this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.CONTrol[LL_I]  , ls_scale )
		next
		
	Case 7
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search tabpage_image
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_image.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_image.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_setup.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_setup.CONTrol[LL_I]  , ls_scale )
		next

	Case 10
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search uo_meetings
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail.CONTrol[LL_I]  , ls_scale )
		next

	Case 9
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search tabpage_net
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_ai.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_ai.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABpage_ids.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABpage_ids.CONTrol[LL_I]  , ls_scale )
		next 
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_notes.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_notes.CONTrol[LL_I]  , ls_scale )
		next 
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.tabpage_report.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.tabpage_report.CONTrol[LL_I]  , ls_scale )
		next

	Case 8
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search tabpage_privileges
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv.CONTrol[LL_I]  , ls_scale )
		next

	Case 6
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search tabpage_profile
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification.CONTrol[LL_I]  , ls_scale )
		next

	Case 5
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		// The search tabpage_verif
		////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		
		this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary , ls_scale  )
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_browse .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
		next
		
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_detail .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_detail.CONTrol[LL_I]  , ls_scale )
		next
		
		FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred .CONTrol)
			this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.CONTrol[LL_I]  , ls_scale )
		next

End Choose

//If il_oriWidth <> this.WorkSpaceWidth() Then this.triggerevent(resize!)
this.triggerevent(resize!)
end subroutine

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

public function integer of_is_de_complete ();
DateTime ldt_de_complete
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.13.2006 By: Cao YongWang
//$<reason> 
//IF IsValid( m_pfe_cst_data_entry) THEN
If w_mdi.menuname = 'm_pfe_cst_data_entry' Then
//---------------------------- APPEON END ----------------------------
	SELECT pd_affil_stat.date_data_entry_completed
	INTO :ldt_de_complete  
	FROM pd_affil_stat  
	WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND
			( pd_affil_stat.active_status in ( 1,4 ) ) and //maha  changed to include pending 072402
			(pd_affil_stat.parent_facility_id = :gi_parent_facility); //maha added 111300

	IF IsNull( ldt_DE_complete ) OR String(ldt_de_complete) = "1/1/00 00:00:00" THEN
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom027!"
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemname', "Custom027!")
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = True
		Return 0 
	ELSE
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "smiley.jpg"
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemname', "smiley.jpg")
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom026!"
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = False
		Return 1
	END IF
ELSE
	Return -1
END IF


end function

public function integer of_new_prac (string as_from);//Start Code Change ---- 03.30.2006 #361 maha new function
//maha created to hide screens and tabs with new practitioner addition

if ib_new_prac = true then
	tab_1.tabpage_detail.uo_data_entry.dw_select_section.setfilter("screen_id = 1")
	tab_1.tabpage_detail.uo_data_entry.dw_select_section.filter()
	tab_1.tabpage_app_audit.visible = false
	tab_1.tabpage_image.visible = false
	tab_1.tabpage_net.visible = false
	tab_1.tabpage_meetings.visible = false
	tab_1.tabpage_privileges.visible = false
	tab_1.tabpage_profile.visible = false
	tab_1.tabpage_verif.visible = false
	tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id( ii_parent_facility_id )
	of_photo_hide() //Bug 2381 - alfee 09.07.2011	
else
	tab_1.tabpage_detail.uo_data_entry.dw_select_section.setfilter("")
	tab_1.tabpage_detail.uo_data_entry.dw_select_section.filter()
	w_mdi.of_prac_folder_security(this)
	
end if

//Start Code Change ----12.18.2007 #V8 maha added to set parent facility id so that if DE compl is clicked while a new prac, the function will work
if MidA(as_from,1,22) = "postupdate(appt stat)@" then //when called from postupdate of affil_stat detail
	integer i
	i = integer(MidA(as_from,23,LenA(as_from) - 22))
	tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id(  i  )
	//-------Begin Added by alfee 09.30.2010 -----------------------------
	of_get_parent_facility( i ) 
	is_facility_name = gnv_data.of_getitem('facility','facility_name','facility_id = ' + String(i))
//-------End Added ----------------------------------------------------		

//Start Code Change ----10.26.2012 #V12 maha - run notification for new prac
debugbreak()
	if ib_run_notification = true then
		//of_notification( il_prac_id )
	end if
//End Code Change ----10.26.2012	

end if


//End Code Change---12.18.2007
	
return 1
end function

public function integer of_setup_title_search ();//////////////////////////////////////////////////////////////////////
// $<function>w_prac_data_1of_setup_title_search()
// $<arguments>(None)
// $<returns> integer
// $<description> Right Click Functionality on Practitioner Search Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.10.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////

String ls_name
String ls_facility_name
string ls_age
Integer li_parent_facility_id
long li_prac_id //maha 06.13.2013 change from integer

// Reset title when no prac_id. Added by Appeon long.zhang 11.09.2015 (V14.2 Applause Bug # 4829 - Previous provider details are shown when there is no search result)
If il_prac_id = 0 Then
	This.title = 'Practitioner Data'
	Return 1
End If

//Start Code Change ----05.17.2011 #V11 maha - modified to use instance variables
li_parent_facility_id = ii_parent_facility_id   // tab_1.tabpage_search.uo_search.dw_search.getitemnumber(tab_1.tabpage_search.uo_search.dw_search.getrow(),'parent_facility_id')
li_prac_id = il_prac_id    //tab_1.tabpage_search.uo_search.dw_search.getitemnumber(tab_1.tabpage_search.uo_search.dw_search.getrow(),'prac_id')
//Start Code Change ----05.17.2011

nv_prac_info lnv_full_name
lnv_full_name = CREATE nv_prac_info
ls_name = lnv_full_name.of_get_name( li_prac_id )
if isnull(ls_name) then ls_name = ''
DESTROY lnv_full_name	
SELECT facility.facility_name  
INTO :ls_facility_name  
FROM facility  
WHERE facility.facility_id = :li_parent_facility_id   ;

//Start Code Change ----10.24.2012 #V12 maha
ii_prac_age = of_get_prac_age(il_prac_id)
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//if of_get_app_setting("set_58","I") > 0 then
if of_get_app_setting("set_91","I") > 0 then
//---------End Modfiied ------------------------------------------------------
	if ii_prac_age = -9999 then
		ls_age = " Age: Unknown"
	else
		ls_age = " Age: " + string(ii_prac_age)
	end if
else
	ls_age = ''
end if

is_prac_title = ls_name + " - " + String( li_prac_id ) + "  (" + ls_facility_name + ")" + ls_age
this.Title = is_prac_title  //Start Code Change ----03.08.2013 #V12 maha - changed to variable
//End Code Change ----10.24.2012

return 1
end function

public function integer of_validate_image ();//////////////////////////////////////////////////////////////////////
// $<function>w_prac_data_1of_validate_image()
// $<arguments>(None)
// $<returns> (none)
// $<description>Queue Images for Scanning from Data Entry.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.12.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
try //alfee 12.11.2009
	
	if isvalid(tab_1.tabpage_detail.uo_data_entry) then
		if tab_1.tabpage_detail.uo_data_entry.of_validate_image() = -1 then
			Integer li_ans,i,ll_image_type_id,ll_find 	
			li_ans = MessageBox("Warning!", "The queued image records may be lost, Do you want to scan now?", Question!, YesNo!, 1)
			if li_ans = 1 then
				//tab_1.SelectTab( 7 )
				tab_1.Post SelectTab( 7 ) //to avoid a system error - alfee 12.11.2009				
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.cb_remove.enabled = true
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.cb_from_file.enabled = true
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.cb_scan.enabled = true
				ll_image_type_id = tab_1.tabpage_detail.uo_data_entry.ids_image_data.getitemnumber(1,'image_type_id')
				ll_find = tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_image_list.find("image_type_id = " + string(ll_image_type_id),1,100)
				if ll_find > 0 then
					tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_image_list.ScrollToRow( ll_find )
					tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_image_list.SetRow( ll_find )
				end if
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_image_data.setfocus()
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_image_data.setcolumn('notes')
				return 1
			else
				for i = 1 to tab_1.tabpage_detail.uo_data_entry.ids_image_data.rowcount()
					tab_1.tabpage_detail.uo_data_entry.ids_image_data.deleterow(i)
				next
				tab_1.tabpage_detail.uo_data_entry.ids_image_data.update()
				return 0
			end if
		end if
	end if

catch (throwable th1)
	//
end try
	
return 0

end function

public function integer of_setresize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_SetResize
//	Arguments:		ab_switch   starts/stops the window resize service
//	Returns:			Integer 		1 = success,  0 = no action necessary, -1 error
//	Description:		Starts or stops the window resize service
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//						8.0   Modified to initially set window dimensions based on the class definition
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2001 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
Integer	li_rc, li_v, li_vars
Integer li_origwidth, li_origheight

// Check arguments
If IsNull (ab_switch) Then
	Return -1
End If

If ab_switch Then
	If IsNull(inv_resize) Or Not IsValid (inv_resize) Then
		//Start Change Code By Jervis 01.09.2008
		//inv_resize = Create n_cst_resize
		//Support reisze when tab.CreateOnDemand = true
		inv_resize = Create n_cst_resize_prac
		//End Change by Jervis
		
		inv_resize.of_SetOrigSize ( this.width, this.height )
	
		li_rc = 1
	End If
Else
	If IsValid (inv_resize) Then
		Destroy inv_resize
		li_rc = 1
	End If
End If

Return li_rc


end function

public subroutine of_dashboard (string as_facility_name, long ai_prac_id, long ai_facility_id);Long ll_find
tab_1.tabpage_search.uo_search.dw_org_facility_select.setitem(1,"facility_id",ai_facility_id)
//tab_1.tabpage_search.uo_search.ddlb_search_type.SelectItem("I.D.", 1)
tab_1.tabpage_search.uo_search.ddlb_search_type.SelectItem("Prac ID", 1)  //Start Code Change ----01.30.2013 #V12 maha
tab_1.tabpage_search.uo_search.sle_srch_val.text=String(ai_prac_id)
tab_1.tabpage_search.uo_search.cb_search.event clicked( )
//find 
//ll_find = tab_1.tabpage_search.uo_search.dw_search.Find("prac_id="+String(ai_prac_id)+" and facility_name= '" + as_facility_name + "'",1,tab_1.tabpage_search.uo_search.dw_search.RowCount())
ll_find = tab_1.tabpage_search.uo_search.dw_search.Find("prac_id="+String(ai_prac_id)+" and facility_name= '" + of_ReviseExpValue(as_facility_name, "~~") + "'",1,tab_1.tabpage_search.uo_search.dw_search.RowCount()) //Evan 07.29.2009
IF ll_find > 0 THEN
	//scroll to row
	tab_1.tabpage_search.uo_search.dw_search.SelectRow(0,False)
	tab_1.tabpage_search.uo_search.dw_search.ScrollToRow(ll_find)
	tab_1.tabpage_search.uo_search.dw_search.SelectRow(ll_find,True)
	tab_1.tabpage_search.uo_search.Event ue_cb_select( )
	If This.WindowState = Minimized! Then This.windowstate = Normal!
END IF

//----Begin Added by alfee 10.09.2010 ----------------
//V10.5 SK Section D - Menu and Setup
//IF gb_sk_ver and IsValid(w_prac_data_sk)THEN
IF IsValid(w_prac_data_sk )  or IsValid(w_prac_data_sk_2 )   THEN	//Bug 3375 - Alfee 01.08.2013 		
	IF w_prac_data_sk.cb_filter.text = "Clear" THEN
		w_prac_data_sk.dw_prac_list.setfilter("")
		w_prac_data_sk.dw_prac_list.filter()
		w_prac_data_sk.cb_filter.text = "Filter"
	END IF
	w_prac_data_sk.of_find_tv_search(ai_facility_id, ai_prac_id)
END IF
//----End Added ------------------------------------------
end subroutine

public function integer of_setfocus ();//Start Code Change ----04.22.2010 #V10 maha - added to setfocus on the search screen
tab_1.tabpage_search.uo_search.sle_srch_val.setfocus()

return 1
end function

public subroutine of_app_color (long al_rgb);//Start Code Change ----05.24.2010 #V10 maha - to modify the prac folder backgrounds
long ll_color

ll_color = al_rgb
//ll_color = 16769510

this.backcolor = ll_color //alfee 12.06.2010
uo_app_stat.backcolor = ll_color
tab_1.backcolor = ll_color
tab_1.tabpage_search.backcolor = ll_color
tab_1.tabpage_app_audit.backcolor = ll_color
tab_1.tabpage_detail.backcolor = ll_color
tab_1.tabpage_apptmnt_status.backcolor = ll_color
tab_1.tabpage_image.backcolor = ll_color
tab_1.tabpage_meetings.backcolor = ll_color
tab_1.tabpage_net.backcolor = ll_color
tab_1.tabpage_privileges.backcolor = ll_color
tab_1.tabpage_profile.backcolor = ll_color
tab_1.tabpage_verif.backcolor = ll_color
tab_1.tabpage_contract.backcolor = ll_color   //Start Code Change ----09.09.2015 #V15 maha


tab_1.tabpage_search.uo_search.of_bg_color(ll_color )
tab_1.tabpage_detail.uo_data_entry.of_bg_color( ll_color)
tab_1.tabpage_app_audit.uo_app_audit.of_bg_color( ll_color)
tab_1.tabpage_net.uo_net.of_bg_color(ll_color )
tab_1.tabpage_apptmnt_status.uo_affill_status.of_bg_color( ll_color)
tab_1.tabpage_verif.uo_verif_summary.of_bg_color( ll_color)
tab_1.tabpage_profile.uo_profile.of_bg_color( ll_color)
tab_1.tabpage_image.uo_image.of_bg_color( ll_color)
tab_1.tabpage_privileges.uo_priv.of_bg_color( ll_color)
tab_1.tabpage_meetings.uo_meetings.of_bg_color( ll_color)
tab_1.tabpage_contract.uo_contracts.of_bg_color( ll_color)  //Start Code Change ----09.09.2015 #V15 maha




end subroutine

public function integer of_get_photo_data (long al_prac, long al_facil);//Start Code Change ----06.17.2010 #V10 maha //search screen photo
string ls_picname

//Start Code Change ----05.17.2011 #V11 maha - arguments no longer needed - modified to use the instance variable
//debugbreak()
//messagebox("ilprac",il_prac_id)
if il_prac_id > 0 then
	ls_picname = of_photo_download(il_prac_id)

	if 	ls_picname = "None" then
		p_prac_photo.PictureName = "nophoto2-demo.jpg"
	else
		if FileExists(ls_PicName) then
			p_prac_photo.PictureName = ls_picname
		//	tab_1.tabpage_search.p_prac_photo.PictureName = ls_picname
		end if
	end if

	dw_p_data.retrieve(il_prac_id, ii_parent_facility_id )
	
	//Start Code Change ----03.16.2016 #V15 maha - hide email address
	if w_mdi.of_security_access(7808) = 0 then
		dw_p_data.object.v_mailing_address_e_mail_address.visible = false
		dw_p_data.object.email_t.visible = false
	end if
	//End Code Change ----03.16.2016
	
	of_photo_data_settings( )
	
	 //Start Code Change ----10.26.2015 #V15 maha - removed
//	if tab_1.selectedtab < 2 then //for sk to hide photo when not on home tab
//		p_prac_photo.visible = true
//		dw_p_data.visible= true		
//	end if

	//Added by Appeon long.zhang 11.09.2015 (V14.2 Applause Bug # 4829 - Previous provider details are shown when there is no search result)
	If tab_1.selectedtab < 2 Then 
		of_photo_visible_hide(tab_1.selectedtab)
	End If
else
	p_prac_photo.visible = false
	dw_p_data.visible= false
	// RP added 1.7.2016
	st_provider_border.visible = dw_p_data.visible
	p_prac_photo.setPosition(ToTop!)
	dw_p_data.setPosition(ToTop!)
end if
	
return 1
//End Code Change ----06.17.2010
//End Code Change ----05.17.2010
	
//	dw_prac_photo_data.retrieve(il_prac_id, ii_parent_facility_id,  ls_picname)





end function

public function integer of_photo_hide ();//Start Code Change ----01.12.2011 #V11 maha 
p_prac_photo.picturename = 'nophoto2-demo.jpg'
dw_p_data.reset()

return 1
end function

public function integer of_buttons_visible (boolean ab_save, boolean ab_add, boolean ab_delete, boolean ab_next, boolean ab_prior, boolean ab_notes, boolean ab_print, boolean ab_3, boolean ab_4, boolean ab_5, boolean ab_6, boolean ab_7);//Start Code Change ----10.05.2011 #V12 maha - added


//if tab_1.selectedtab = 1 then   //Start Code Change ----03.27.2015 #V15 maha - removed
//	st_buttons.visible = false
//else
//	if gb_use_prac_toolbar then   //Start Code Change ----10.24.2012 #V12 maha - childrens hosp
//		st_buttons.visible = false
//	else
//		st_buttons.visible = true
//	end if
//end if



cb_save.visible = ab_save
cb_add.visible = ab_add
cb_delete.visible = ab_delete
cb_next.visible = ab_next
cb_prior.visible = ab_prior
if  w_mdi.of_security_access( 7340 ) = 0 then //Start Code Change ----09.12.2012 #V12 maha - added to block notes access
	cb_notes.visible = false
else
	cb_notes.visible = ab_notes
end if
cb_print.visible = ab_print
cb_b3.visible = ab_3
cb_b4.visible = ab_4
cb_b5.visible = ab_5
cb_b6.visible = ab_6
cb_b7.visible = ab_7
cb_add.enabled = true
cb_delete.enabled = true
cb_close.bringtotop = true   //Start Code Change ----03.27.2015 #V15 maha


return 1
end function

public function integer of_facility_specific_data ();//Start Code Change ----03.26.2012 #V12 maha function added
OpenWithParm( w_facility_specific_data, String( ii_parent_facility_id ) + "-" + String( il_prac_id ) )

return 1
end function

public function integer of_button_settings ();//Start Code Change ----03.28.2012 #V12 maha
integer li_tab  //maha 02.07.2017 - cklist

//Start Code Change ----10.05.2011 #V12 maha - buttons
//Hide All
of_buttons_visible( False, False, False, False, False, False, False, False, False, False, False, False )
//of_buttons_visible( Save, Add , Delete, Next, Prior, Notes, Print, B3, B4, B5, B6, B7 )
if gb_use_prac_toolbar then return -1

cb_add.text =  "Add"  //Start Code Change ----06.07.2012 #V12 maha
cb_print.text =  "Print"	
cb_next.text =  "Next ->"
cb_prior.text =  "<- Prior"
cb_next.enabled = true //Start Code Change ----01.31.2012 #V12 maha
cb_prior.enabled = true //Start Code Change ----04.27.2012 #V12 maha
cb_b7.enabled = true
cb_b3.enabled = true
cb_b4.enabled = true
cb_b5.enabled = true
cb_b6.enabled = true  //Start Code Change ----03.28.2012 #V12 maha
cb_b7.enabled = true  
cb_print.enabled = true

//of_buttons_visible( save, add, delete,   Next , Prior,  notes , print, b3, b4, b5, b6, b7 )

choose case tab_1.selectedtab
	case 1 //search
	case 2 //DE
//debugbreak()		
		tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable( )
		//tab_1.tabpage_detail.uo_data_entry.of_refresh_page_menu( ) //Start Code Change ----03.27.2012 #V12 maha
		//Start Code Change ----05.08.2012 #V12 maha - exception for smart
		if gb_sk_ver then 
			cb_b5.text =  "Batch Add"
		else
			cb_b3.text =  "DE Compl"
			cb_b4.text =  "Verify Cred"
			if gs_cust_type = "I" then
				cb_b5.text =  "Batch Add"
			else
				cb_b5.text =  "Facility Data"
			end if
			cb_b6.text =  "Add Cert Per"  //Start Code Change ----11.02.2017 #V16 maha
		end if
		//Start Code Change ----05.08.2012
		if w_mdi.of_security_access(50) = 1 then //read only
			of_buttons_visible( False,  False,  False,  True,  True,  True, False,  False, False, False,  False,  False)
		else
			if gb_sk_ver then   //Start Code Change ----05.08.2012 #V12 maha - exception for smart
				of_buttons_visible( True,  True,   True,  True,  True,  True, False,  False,  False, True,  False,  False)
			else
				of_buttons_visible( True,  True,   True,  True,  True,  True, False,  True,  True, True,  True,  False)
				if w_mdi.of_security_access(7772) = 0 then cb_b5.visible = false    //facility //Start Code Change ----03.11.2015 #V15 maha
				if w_mdi.of_security_access(7773) = 0 then cb_b4.visible = false    //verify //Start Code Change ----03.11.2015 #V15 maha
			end if
		end if
		tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable( )   //Start Code Change ----06.28.2012 #V12 maha
		if w_mdi.of_security_access(7771) = 0 then cb_delete.visible = false    //delete //Start Code Change ----03.11.2015 #V15 maha
		
		if of_get_app_setting("set_38","I") = 1 then cb_b5.visible = false
	case 3 //clist
	//debugbreak()	
		cb_b3.text =  "Letter"
		cb_b4.text =  "Copy Row"
		cb_b5.text =  "Add Missing"
		//Start Code Change ----02.07.2017 #V153 maha
		li_tab = tab_1.tabpage_app_audit.uo_app_audit.tab_view.selectedtab
		
		if w_mdi.of_security_access(90) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  False,  False,False, False,  False,  False)
		else
			choose case li_tab
				case 1,2
					of_buttons_visible( True,  False,   True,  False,  False,  True, True,  True,  True,  True,  False, False)

					if w_mdi.of_security_access(7786) = 0 then //missing //Start Code Change ----03.11.2015 #V15 maha
						cb_b5.visible = false    
						cb_b4.visible = false
					end if
					if w_mdi.of_security_access(7785) = 0 then cb_delete.visible = false    //delete //Start Code Change ----03.11.2015 #V15 maha
				case 3 	//review audit tab
					if w_mdi.of_security_access(7841) = 1 then //add button security
						of_buttons_visible( True,  True,  False,  False,   False,  True,  False,  False,False, True , False,  False)
					else
						of_buttons_visible( True,  False,  False,  False,   False,  True,  False,  False,False, True , False,  False)
					end if
			end choose
		end if
	case 4 //appointment
		
		cb_b3.text =  "DE Compl"
		cb_b4.text =  "PSV Data"
		cb_b5.text =  "Multi App"
		cb_b6.text =  "Appt Note"	
		if w_mdi.of_security_access(120) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  False,  False,False, False,  True,  False)
		else
			of_buttons_visible( True,  True,   True,  False,  False,  True, False,  True,  True,  True,  False, False)
			//messagebox("","of_button_settings")
		end if
		if w_mdi.of_security_access(7774) = 0 then cb_delete.visible = false    //delete //Start Code Change ----03.11.2015 #V15 maha
	debugbreak()
		//Start Code Change ----06.07.2017 #V154 maha
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_button_check()
		//End Code Change ----06.07.2017 
	case 5 //verifs
		cb_print.text = "Reverify"
		cb_prior.text =  "Find Missing" 
		cb_next.text = "Copy Verif"
		cb_b3.text =  "Clear Print"
		cb_b4.text =  "Letters"
		cb_b5.text =  "Go To Web"
		cb_b6.text =  "NPDB"
		cb_b7.text =  "OIG"
		if w_mdi.of_security_access(140) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  False,  False,False, False,  False,  False)
		else
			if w_mdi.of_security_access(150) = 1 then //process verif
				of_buttons_visible( True,  False,   True,  True,  True,  True, True,  True,  True,  True,    True, True)
			else  //can't process
				of_buttons_visible( True,  False,   True,  True,  False,  True, True,   False,  False,  False,  False, False)
			end if
			if w_mdi.of_security_access(170) = 0 then cb_prior.visible = false    //reverify
			if w_mdi.of_security_access(180) = 0 then cb_next.visible = false    //copy
			if w_mdi.of_security_access(7150) = 0 then cb_delete.visible = false    //delete
			if w_mdi.of_security_access(7788) = 0 then cb_b3.visible = false    //missing //Start Code Change ----03.11.2015 #V15 maha
		end if
		//---------------------------appeon begin-----------------------
		//<$>add long.zhang 06.21.2012
		//<$>reason:when this windows is actived should control the Go To Web/Letters/NPDB buttons -Bug 3151
		if IsValid(this.tab_1.tabpage_verif.uo_verif_summary) then
			this.tab_1.tabpage_verif.uo_verif_summary.of_set_button_enabled( )
		end if
		//---------------------------appeon end-------------------------
	case 6 //profiles
		of_buttons_visible( False, False, False, False , False, True, True, True, False,True, True, False )  //Start Code Change ----02.13.2013 #V12 maha - added true for notes
		cb_b3.text =  "Run Report"
		cb_b5.text =  "Save as PDF"
		cb_b6.text =  "Email Report"
	case 7 //documents
		//Start Code Change ----03.28.2012 #V12 maha - code dependant on sub tab
		tab_1.tabpage_image.uo_image.of_button_visible(  tab_1.tabpage_image.uo_image.tab_view.selectedtab )
		if w_mdi.of_security_access(7797) = 0 then cb_delete.visible = false    //delete //Start Code Change ----08.24.2015 #V15 maha
		
		
	case 8//privs
	
		cb_b3.text =  "Update"	
		cb_b4.text =  "Reports"
		cb_b5.text =  "Form"  //Start Code Change ----01.05.2017 #V153 maha - added button 5 and modified Visible settings
		if w_mdi.of_security_access(210) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  False,  False, True, True,  False,  False)
		else
			of_buttons_visible( True,  True,   True,  False,  False,  True, False,  True,  True,  True,  False, False)
		end if
		if w_mdi.of_security_access(7782) = 0 then cb_b4.visible = false    //reports //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7782) = 0 then cb_b5.visible = false   //form //Start Code Change ----01.05.2017 #V153 maha
		if w_mdi.of_security_access(7783) = 0 then cb_b3.visible = false    //update //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7784) = 0 then cb_delete.visible = false    //delete //Start Code Change ----03.11.2015 #V15 maha
	case 9 //apps
		
		cb_b3.text =  "Filter"
		cb_b4.text =  "Reappoint"
		cb_print.text =  "Print Report"
		cb_b5.text =  "Pop Apps"
		cb_b6.text =  "Web Pop"
		cb_b7.text =  "Tracking"
		cb_next.text =  "Email Payor"  //Start Code Change ----06.13.2013 #V14 maha
		if w_mdi.of_security_access(1400) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  True,  True, False, False,  False,  True)
		else
			of_buttons_visible( True,  True,   True,   True, False,  True,  True,  True,  True,  True,  True, True)
		end if
		if w_mdi.of_security_access(7775) = 0 then cb_delete.visible = false    //delete //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7778) = 0 then cb_b4.visible = false    //reappoint //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7779) = 0 then cb_b5.visible = false    //print apps //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7781) = 0 then cb_b6.visible = false    //ipop //Start Code Change ----03.11.2015 #V15 maha
		if w_mdi.of_security_access(7795) = 0 then cb_next.visible = false    //ipop //Start Code Change ----03.12.2015 #V15 maha
	case 10 //meetings
		of_buttons_visible( True,  True,   True,   False, False,  True,  True, False,  False,  False,  False, False)
		if w_mdi.of_security_access(190) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,  True,  True,  False, False, False,  False,  False)
		else
			of_buttons_visible( True,  True,   True,   False, False,  True,  True, False,  False,  False,  False, False)
		end if
	case 11//contracts//Start Code Change ----03.05.2014 #V14 maha
		of_buttons_visible( True,   False,   False ,   False, False,  False,   False, False,  False,  False,  False, False)
		if w_mdi.of_security_access(190) = 1 then //read only
			of_buttons_visible( False,  False,  False,  False,   False,   False,  False,  False, False, False,  False,  False)
		else
			of_buttons_visible(  True,   False,   False ,   False, False,  False,   False, False,  False,  False,  False, False)
		end if	
end choose

of_button_recred( )   //Start Code Change ----10.05.2015 #V15 maha

//Start Code Change ----09.30.2014 #V15 maha
//if tab_1.selectedtab = 1 then 
if tab_1.selectedtab = 1 or gs_cust_type = "I" then  //Start Code Change ----03.29.2016 #V15 maha - hide for app
	dw_standing.visible = false
	dw_red_flag_count.visible = false
else
	dw_standing.visible = true
	dw_red_flag_count.visible = true
end if
//End Code Change ----09.30.2014 

return 1

end function

public function boolean of_isrunprofile ();//////////////////////////////////////////////////////////////////////
// $<function> of_IsRunProfile
// $<arguments>
// $<returns> boolean
// $<description> Determine the profle if in running
//////////////////////////////////////////////////////////////////////
// $<add> 06.06.2012 by Evan
//////////////////////////////////////////////////////////////////////

Return ib_run_profile
end function

public function integer of_notification (long al_prac_id);//Start Code Change ----12.25.2012 #V12 maha - created to run new prac notifications

n_cst_notification_alert lo_alert

lo_alert = create n_cst_notification_alert

lo_alert.of_get_new_prac_alerts( )

destroy lo_alert


return 1
end function

public function integer of_set_cb_notes_text ();//Start Code Change ----03.20.2013 #V12 maha - added
select count(record_id) into :il_pd_notes_cnt from pd_notes where prac_id = :il_prac_id;

//Start Code Change ----03.18.2013 #V12 maha
if il_pd_notes_cnt > 0 then 
	string scnt
	if il_pd_notes_cnt > 9 then 
		scnt = "9+"
	else
		scnt = string(il_pd_notes_cnt)
	end if
	cb_notes.text =  scnt + " Notes"
	//cb_notes.textcolor = 16711680	//Start Code Change ----02.12.2016 #V15 maha - leave black
else
	cb_notes.text = "0 Notes"
	//cb_notes.textcolor = 0 //Start Code Change ----02.12.2016 #V15 maha - leave black
end if
//End Code Change ----03.18.2013

return 1
end function

public function integer of_photo_visible_hide (integer ai_tab);//Start Code Change ----03.27.2014 #V14.2 maha - created from code from selectionchanging event
integer li_hide
//debugbreak()
if gb_sk_ver then
	 li_hide = 1
elseif gs_cust_type = 'I' and gi_prac_tab = 10 then  //Start Code Change ----08.10.2016 #V152 maha - changed option number
	li_hide = 1 //  app sk tab in intelliapp
end if

 //Start Code Change ----10.26.2015 #V15 maha - no show photo
if ii_photo_search_only = 3 then 
	p_prac_photo.visible = false
	dw_p_data.visible = false
	// RP added 1.7.2016
	st_provider_border.visible = dw_p_data.visible
	p_prac_photo.setPosition(ToTop!)
	dw_p_data.setPosition(ToTop!)
	return 1
end if
 //End Code Change ----10.26.2015

choose case ai_tab
//	case 3,5,9, 4       
	case 3,5,9, 4,11	//Added by Appeon long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)       
		p_prac_photo.visible = false
		dw_p_data.visible = false
		
	case 1
		 //Start Code Change ----10.26.2015 #V15 maha - new setting 
		if ii_photo_search_only = 2 then //hide on search
			p_prac_photo.visible = false
			dw_p_data.visible = false
		else
			p_prac_photo.visible = true
			dw_p_data.visible = true
		end if
		 //End Code Change ----10.26.2015
		
	case else  //2,4,6,7,8
		if  li_hide = 1 then   //  app sk tab in intelliapp
			p_prac_photo.visible = false
			dw_p_data.visible = false
		elseif ai_tab > 2 and p_prac_photo.picturename = "nophoto2-demo.jpg" then
			p_prac_photo.visible = false
			dw_p_data.visible = false
		else
			if ii_photo_search_only = 1 then   //V11 - user option
				p_prac_photo.visible = false
				dw_p_data.visible = false
			else
				if ib_new_prac then // added to hide photo until provider saved
					p_prac_photo.visible = false
				else
					p_prac_photo.visible = true
					dw_p_data.visible = true
				end if
			end if
		end if
end choose


// RP added 1.7.2016
st_provider_border.visible = dw_p_data.visible
p_prac_photo.setPosition(ToTop!)
dw_p_data.setPosition(ToTop!)



return 1
end function

public function integer of_retrieve_contract ();//====================================================================
//$<Function>: of_retrieve_contract
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if tab_1.tabpage_contract.visible then
	this.tab_1.tabpage_contract.uo_contracts.of_set_prac_id( il_prac_id)
	this.tab_1.tabpage_contract.uo_contracts.of_retrieve( )
end if

return 1
end function

public function integer of_next_tab (string as_dir); //Start Code Change ----03.23.2015 #V15 maha - called from dw_tab_buttons
string s
integer t

t = tab_1.selectedtab

//find the next visible tab up or down
 //Start Code Change ----07.29.2015 #V15 maha
if as_dir = "+" then
	t = of_next_tab_visible( t,true)
else
	t = of_next_tab_visible( t,false)
end if
 //Start Code Change ----07.29.2015

if t = 0 then return 1 //stay on same tab if no next visible
tab_1.selecttab(t)



		
return 1

end function

public function integer of_reset_prac ();//Start Code Change ----07.10.2015 #V15 maha - added for refresh issues in Web
setredraw(false)
tab_1.tabpage_detail.uo_data_entry.of_reset( )
tab_1.tabpage_image.uo_image.of_reset()
tab_1.tabpage_verif.uo_verif_summary.of_reset( )
tab_1.tabpage_privileges.uo_priv.of_reset( )
tab_1.tabpage_net.uo_net.of_reset( )
setredraw(true)
 
 return 1



end function

public function integer of_next_tab_visible (integer ai_from, boolean ab_forward); //Start Code Change ----07.29.2015 #V15 maha - called from of_next_tab and selectionchanged
 integer t
 integer li_next
 integer i
 integer tc
 
//if ai_from > 6 then debugbreak()
 //loop through tabs to find the next visible
if ab_forward then
	t = ai_from + 1
	tc = 11
	
	for i = t to tc
		if i = tc and of_is_tab_visible( i ) = false then
			i = 0 
			exit
		end if
		if of_is_tab_visible( i ) = true then exit
	next
	
	li_next =  i

else
	t = ai_from - 1
	tc = 1
	
	for i = t to tc step -1 
		if i = tc and of_is_tab_visible( i ) = false then
			i = 0 
			exit
		end if
		if of_is_tab_visible( i ) = true then exit
	next
	
	li_next =  i
end if

return li_next




end function

public function boolean of_is_tab_visible (integer ai_tab); //Start Code Change ----07.29.2015 #V15 maha - called from of_next_tab_visible
integer t
boolean ab_return = true

t = ai_tab

choose case t
	case 1 //search
		if tab_1.tabpage_search.visible = false then ab_return  = false
	case 2 //DE
		if tab_1.tabpage_detail.visible = false then ab_return  = false
	case 3 //clist
		if tab_1.tabpage_app_audit.visible = false then ab_return  = false
	case 4 //appointment
		if 	tab_1.tabpage_apptmnt_status.visible = false then ab_return  = false
	case 5 //verifs
		if 	tab_1.tabpage_verif.visible = false then ab_return  = false
	case 6 //profiles
		if tab_1.tabpage_profile.visible =false then ab_return  = false
	case 7 //documents
		 if tab_1.tabpage_image.visible = false then ab_return  = false
	case 8 //privs
		if tab_1.tabpage_privileges.visible = false then ab_return  = false
	case 9 //apps
		if tab_1.tabpage_net.visible = false then ab_return  = false
	case 10 //meetings
		if tab_1.tabpage_meetings.visible = false then ab_return  = false
	case 11 //contracts
		if tab_1.tabpage_contract.visible = false then ab_return  = false
end choose

return ab_return
end function

public function string of_get_name (integer ai_tab); //Start Code Change ----07.29.2015 #V15 maha - called from selection changed event
string s

choose case ai_tab
	case 0
		s =  ""
	case 1
		s = "Search"
	case 2
		s = "Demographics"
	case 3
		s = "Checklist"
	case 4
		s = "Appointments"
	case 5
		s = "Verifications"
	case 6
		s = "Profile Reports"
	case 7
		s = "Documents/Images"
	case 8
		s = "Privileges"
	case 9
		s = "Applications"
	case 10
		s = "Meetings"		
	case 11
		s = "Contracts"
end choose

return s
end function

public function integer of_button_recred (); //Start Code Change ----10.05.2015 #V15 maha - added for recred button
 //called from of_button_settings
 //ib_recred set in of_retrieve_prac
 
 choose case tab_1.selectedtab
	case 4, 5
		//set further down
	case else
		cb_recred.visible = false
	 	cb_rehelp.visible = false
		return 1
end choose
 
if w_mdi.of_security_access(7798) = 0 then 
	cb_recred.visible = false
	cb_rehelp.visible = false
else
	cb_recred.visible = true
	cb_rehelp.visible = true
end if

if ib_recred then
	cb_recred.enabled = true
else
	cb_recred.enabled = false
end if
 
 
 return 1
end function

public function boolean of_is_recred (long al_prac, long al_facil);long ll_ver
integer r

ll_ver = long(gnv_data.of_getitem( "code_lookup", 'lookup_code', "upper(code) = upper('Exp Appt Ltr')"))
select count(rec_id) into :r from verif_info where prac_id = :al_prac and facility_id = :al_facil and active_status = 1 and verification_method = :ll_ver;

if r = 0 then
	ib_recred = false
else
	ib_recred =  true
end if

return ib_recred
end function

public function integer of_photo_data_settings (); //Start Code Change ----05.10.2017 #V154 maha
 integer r
 integer rc
 integer li_vis
 long ll_color
 string ls_field
 string ls_label
 string ls_text
 string ls_sql
 string ls_val
 string s
 string m
 
 if dw_p_data.dataobject = "d_personal_data_new" then //(Appeon)Stephen 07.06.2017 - Question ID #5718 for Case #71824 Intellisoft error msg
	of_photo_data_modify(dw_p_data, dw_photo_settings, il_prac_id, ii_parent_facility_id )
end if
 
 
 return 1
 
// rc = dw_photo_settings.rowcount()
// if rc = 0 then return 1
// debugbreak()
// for r = 1 to rc
//	li_vis = dw_photo_settings.getitemnumber(r, "is_visible")
//	ls_field = dw_photo_settings.getitemstring(r, "pb_field_name")	
//	ls_label = dw_photo_settings.getitemstring(r, "field_label_name")
//	
//	
//	if li_vis = 0 then
//		s = dw_p_data.modify( ls_field + ".visible=false")
//		s = dw_p_data.modify( ls_label + ".visible=false")
//	else
//		ls_text = dw_photo_settings.getitemstring(r, "field_label")
//		ll_color = dw_photo_settings.getitemnumber(r, "set_color")
//		
//		if ls_label = "@" or ls_text = "@" then
//			//no change
//		else
//			m = ls_label + ".text ='" + ls_text + "'"
//			s = dw_p_data.modify(m)
//		end if
//		
//		m = ls_field + ".color ='" + string(ll_color) + "'"
//		s = dw_p_data.modify( m )
//		
//		choose case ls_field
//			case "cust_1", "cust_2", "cust_3"
//				//of_photo_get cust_value
//			case else
//				//skip
//		end choose
//	end if
//next
//		
// return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
dw_p_data.Modify("DataWindow.Zoom=" + string(gi_zoom))  

end subroutine

on w_prac_data_1.create
int iCurrent
call super::create
this.dw_photo_settings=create dw_photo_settings
this.st_provider_border=create st_provider_border
this.cb_rehelp=create cb_rehelp
this.cb_recred=create cb_recred
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.pb_home=create pb_home
this.dw_red_flag_count=create dw_red_flag_count
this.cb_close=create cb_close
this.cb_notes=create cb_notes
this.cb_add=create cb_add
this.p_prac_photo=create p_prac_photo
this.cb_1=create cb_1
this.cb_save=create cb_save
this.cb_addcb=create cb_addcb
this.cb_print=create cb_print
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_b3=create cb_b3
this.cb_b4=create cb_b4
this.cb_b5=create cb_b5
this.cb_b6=create cb_b6
this.cb_b7=create cb_b7
this.cb_delete=create cb_delete
this.uo_app_stat=create uo_app_stat
this.dw_standing=create dw_standing
this.tab_1=create tab_1
this.dw_tab_buttons=create dw_tab_buttons
this.st_tabname=create st_tabname
this.dw_p_data=create dw_p_data
this.p_buttons=create p_buttons
this.st_buttons=create st_buttons
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_photo_settings
this.Control[iCurrent+2]=this.st_provider_border
this.Control[iCurrent+3]=this.cb_rehelp
this.Control[iCurrent+4]=this.cb_recred
this.Control[iCurrent+5]=this.cb_5
this.Control[iCurrent+6]=this.cb_4
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.pb_home
this.Control[iCurrent+10]=this.dw_red_flag_count
this.Control[iCurrent+11]=this.cb_close
this.Control[iCurrent+12]=this.cb_notes
this.Control[iCurrent+13]=this.cb_add
this.Control[iCurrent+14]=this.p_prac_photo
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.cb_save
this.Control[iCurrent+17]=this.cb_addcb
this.Control[iCurrent+18]=this.cb_print
this.Control[iCurrent+19]=this.cb_next
this.Control[iCurrent+20]=this.cb_prior
this.Control[iCurrent+21]=this.cb_b3
this.Control[iCurrent+22]=this.cb_b4
this.Control[iCurrent+23]=this.cb_b5
this.Control[iCurrent+24]=this.cb_b6
this.Control[iCurrent+25]=this.cb_b7
this.Control[iCurrent+26]=this.cb_delete
this.Control[iCurrent+27]=this.uo_app_stat
this.Control[iCurrent+28]=this.dw_standing
this.Control[iCurrent+29]=this.tab_1
this.Control[iCurrent+30]=this.dw_tab_buttons
this.Control[iCurrent+31]=this.st_tabname
this.Control[iCurrent+32]=this.dw_p_data
this.Control[iCurrent+33]=this.p_buttons
this.Control[iCurrent+34]=this.st_buttons
end on

on w_prac_data_1.destroy
call super::destroy
destroy(this.dw_photo_settings)
destroy(this.st_provider_border)
destroy(this.cb_rehelp)
destroy(this.cb_recred)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.pb_home)
destroy(this.dw_red_flag_count)
destroy(this.cb_close)
destroy(this.cb_notes)
destroy(this.cb_add)
destroy(this.p_prac_photo)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.cb_addcb)
destroy(this.cb_print)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_b3)
destroy(this.cb_b4)
destroy(this.cb_b5)
destroy(this.cb_b6)
destroy(this.cb_b7)
destroy(this.cb_delete)
destroy(this.uo_app_stat)
destroy(this.dw_standing)
destroy(this.tab_1)
destroy(this.dw_tab_buttons)
destroy(this.st_tabname)
destroy(this.dw_p_data)
destroy(this.p_buttons)
destroy(this.st_buttons)
end on

event activate; integer set_ck
 Integer li_index //Added By Ken.Guo 03.17.2008
 string   ls_old_menuname //(Appeon)Stephen 07.25.2017 - Bug ID #5715 for Case #00071338 Issue With IC
//setredraw(false)
gl_prac_id = il_prac_id //Start Code Change ----01.30.2013 #V12 maha
gw_prac_data = this	//Start Code Change ----03.05.2013 #V12 maha
gi_parent_facility = ii_parent_facility_id //Added by Appeon long.zhang 01.08.2016 (BugL010801)

ls_old_menuname = w_mdi.menuname  //(Appeon)Stephen 07.25.2017 - Bug ID #5715 for Case #00071338 Issue With IC
IF LeftA( This.Title, 14 ) = "Screen Painter" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_prac_data_design)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_prac_data_design' Then w_mdi.ChangeMenu( m_pfe_cst_prac_data_design )
	//---------------------------- APPEON END ----------------------------
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-08
	//$<add> 03.6.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Make a condition to ensure that when w_prac_data_1 is just opened,
	//$<modification> the following script will not be used. The script in the
	//$<modification> SelectionChanged of tab_1 has the same functionality.
	 If ib_win_just_opened Then return
	//---------------------------- APPEON END ----------------------------
	IF tab_1.SelectedTab = 1  THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
		*/
		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
		//---------------------------- APPEON END ----------------------------
	ELSEIF tab_1.SelectedTab = 2  THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu(m_pfe_cst_data_entry)
		*/
		//---------Begin Modified by (Appeon)Stephen 07.25.2017 for Bug ID #5715 for Case #00071338 Issue With IC--------
		//If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then w_mdi.ChangeMenu( m_pfe_cst_data_entry )
		If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then 
			w_mdi.setredraw(false)
			w_mdi.ChangeMenu( m_pfe_cst_data_entry )
		//---------------------------- APPEON END ----------------------------	
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
			tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable()
			tab_1.tabpage_detail.uo_data_entry.of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
			w_mdi.setredraw(true)
		end if
		//---------End Modfiied ------------------------------------------------------
	ELSEIF tab_1.SelectedTab = 3 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu(m_pfe_cst_app_audit)
		*/
		If w_mdi.menuname <> 'm_pfe_cst_app_audit' Then w_mdi.ChangeMenu( m_pfe_cst_app_audit )
		//---------------------------- APPEON END ----------------------------
	ELSEIF tab_1.SelectedTab = 4 THEN
		//comment 08/04/2007 by:Andy Reason:BugJ073009
		//After selecting this tab, switch to other applications and then return to this tab, 
		//there will be additional toolbar displayed, and 2 menus disappear.
		/*
		IF tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectedTab = 4 THEN //netdev tab
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-11-14 By: Allen
			//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
			/*
			w_mdi.ChangeMenu(m_pfe_cst_net_dev)
			*/
			If w_mdi.menuname <> 'm_pfe_cst_net_dev' Then w_mdi.ChangeMenu( m_pfe_cst_net_dev )
			//---------------------------- APPEON END ----------------------------
			w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		ELSE
		*/
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2006-11-14 By: Allen
			//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
			/*
			w_mdi.ChangeMenu(m_pfe_cst_data_entry)
			*/
			If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then w_mdi.ChangeMenu( m_pfe_cst_data_entry )
			//---------------------------- APPEON END ----------------------------
			//m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = False			
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', False)			
			//m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritemvisible = False
			w_mdi.SetToolbarPos ( 2, 1, 200, False)
			//select set_14 into :set_ck from icred_settings;
			set_ck = of_get_app_setting("set_14","I")
			if set_ck = 1 then //appointment note tool
				m_pfe_cst_data_entry.m_view.m_aptnote.visible = True //maha 111802
				//m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritemvisible = True //maha 111802
				gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_aptnote,'toolbaritemvisible', True)
			end if
		//END IF
	ELSEIF tab_1.SelectedTab = 5 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu( m_pfe_cst_verif_info )
		*/
		If w_mdi.menuname <> 'm_pfe_cst_verif_info' Then w_mdi.ChangeMenu( m_pfe_cst_verif_info )
		//---------------------------- APPEON END ----------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		w_mdi.SetToolbarPos ( 3, 1, 300, False)	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01/08/2008 By: Ken.Guo
	//$<reason> Lost menu items after switch to other window.
	ELSEIF tab_1.SelectedTab = 6 THEN
		If w_mdi.menuname <> 'm_pfe_cst_profile' Then w_mdi.ChangeMenu( m_pfe_cst_profile )
	ELSEIF tab_1.SelectedTab = 7 THEN
		//-------------Begin Modified by Alfee 10.10.2008 --------------------
		//<$Reason>A Web bug - the image toolbars can't work
		li_index = This.tab_1.tabpage_image.uo_image.tab_view.Selectedtab
		This.tab_1.tabpage_image.uo_image.of_set_menu(li_index)
		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		w_mdi.SetToolbarPos ( 3, 1, 300, False)
		/*
		If w_mdi.menuname <> 'm_pfe_cst_imaging' Then w_mdi.ChangeMenu( m_pfe_cst_imaging )
		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		w_mdi.SetToolbarPos ( 3, 1, 300, False)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 03/17/2008 By: Ken.Guo
		//$<reason> Refresh wdi menu items
		If ib_page7_selected Then
			li_index = This.tab_1.tabpage_image.uo_image.tab_view.Selectedtab
			This.tab_1.tabpage_image.uo_image.tab_view.trigger Event SelectionChanged(li_index,li_index)
		End If		
		//---------------------------- APPEON END ----------------------------
		*/
		//-------------End Modified ------------------------------------------
	ELSEIF tab_1.SelectedTab = 8 THEN
		If w_mdi.menuname <> 'm_pfe_cst_privileges' Then w_mdi.ChangeMenu( m_pfe_cst_privileges )
	ELSEIF tab_1.SelectedTab = 9 THEN
		If w_mdi.menuname <> 'm_pfe_cst_net_dev' Then w_mdi.ChangeMenu( m_pfe_cst_net_dev )
	ELSEIF tab_1.SelectedTab = 10 THEN		
		If w_mdi.menuname <> 'm_pfe_cst_prac_meetings' Then w_mdi.ChangeMenu( m_pfe_cst_prac_meetings )
	//---------------------------- APPEON END ----------------------------		
	END IF
END IF
if w_mdi.menuname <> ls_old_menuname then //(Appeon)Stephen 07.25.2017 - Bug ID #5715 for Case #00071338 Issue With IC
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<add> 01.13.2006 By: Rodger Wu
	//$<reason> The SetToolbarPos function is currently unsupported. 
	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
	//$<modification> the same functionality.
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	//---------------------------- APPEON END ----------------------------
	
	w_mdi.of_menu_security( w_mdi.MenuName )
	
	IF gb_se_version THEN
		of_se( )
	END IF
	
	If AppeonGetClientType() = "WEB" Then w_mdi.SetRedraw( False) //Added by Appeon long.zhang 04.24.2017 (BugL042401)
	
	of_button_settings()  //Start Code Change ----05.10.2012 #V12 maha
	
	If AppeonGetClientType() = "WEB" Then w_mdi.SetRedraw( True) //Added by Appeon long.zhang 04.24.2017 (BugL042401)
end if
//setredraw(true)



end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-14 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
*/
If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
//---------------------------- APPEON END ----------------------------

DESTROY inv_action_items
DESTROY inv_printletters

//w_mdi.iw_prac_cnt --

//START---Modify by Evan on 2008-03-14
//w_mdi.Post of_menu_security( w_mdi.MenuName )		//Modified by Scofield on 2007-12-19: Add Post Script
w_mdi.of_menu_security( w_mdi.MenuName )
//END---Modify by Evan on 2008-03-14

IF IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF

IF IsValid( w_capture ) THEN
	Close( w_capture )
END IF
//--------Begin Added by Nova 03.31.2010------------------------
IF IsValid( w_auto_schedule ) THEN
	w_auto_schedule.BringToTop = True
END IF
IF IsValid( w_schedule_logview ) THEN
	w_schedule_logview.BringToTop = True
END IF
//--------End Added --------------------------------------------

//--------Begin Modified by  Nova 09.07.2010-----------------------
// Begin Modified by  Nova 09.07.2010  V10.5 SK Section D - Menu and Setup
Window lw_null[]
w_mdi.iw_prac=lw_null
//--------End Modified --------------------------------------------

//garbagecollect()
post garbagecollect()//long.zhang 11/29/2013 program crashed if not using post BugT092702 
end event

event pfc_save;Integer li_retval
Long ll_rec_id
long ll_find, ll_prac_id

//IF tab_1.SelectedTab = 1 THEN
//	tab_1.tabpage_detail.uo_data_entry.Event pfc_cst_preupdate()
//END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 03.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Have the application only check the current tab page instead
//$<modification> chekcing the whole tab control before updating the database.

/*	
li_retval =  w_main::Event pfc_save()
*/

powerobject lpo_empty[], apo_control[]

if gi_user_readonly = 1 then return 1 //alfee 12.30.2009

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

//---------------------------- APPEON END ----------------------------

IF li_retval < 0 THEN
	RETURN -1
END IF
IF li_retval = 1 AND ib_new_prac THEN
	IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_rowcount() = 0 THEN
		IF gs_cust_type = 'I' THEN
			//---------Begin Added by (Appeon)Stephen 11.07.2017 for Alpha Testing Bug # 5871- IntelliApp-> Refresh issue: Adding a new provider still shows previous providers name at bottom instead of new--------
			select count(1) into :ll_find from pd_affil_stat where prac_id = :il_prac_id;
			if ll_find < 1 then
			//---------End Added ------------------------------------------------------
				ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
				INSERT INTO pd_affil_stat  
					( rec_id,   
					  prac_id,   
					  seq_no,
					  affiliation_status,   
					  parent_facility_id,   
					  apptmnt_type,   
					  verifying_facility,   
					  application_audit_facility,
					  active_status)  
				VALUES ( :ll_rec_id,   
					  :il_prac_id,   
					  1,
					  'M',   
					  1,   
					  'I',   
					  1,   
					  1,
					  1)  ;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL Error", SQLCA.SQLERRTEXT )
					Return -1
				END IF
				of_app_audit( ll_rec_id )
			end if
			ii_parent_facility_id = 1
			tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id( ii_parent_facility_id )
			ib_new_prac = False
			//Start Code Change ----03.30.2006 #362 maha
			of_new_prac( "pfc_save")
			//End Code Change---03.30.2006
			//IF gb_sk_ver THEN //SK Practitioner Folder - alfee 09.06.2010
			IF IsValid(w_prac_data_sk) THEN //Bug 3375 - Alfee 01.08.2013 	
				ib_save = TRUE
				Event ue_refresh_tv_search() 
				ib_save = FALSE
			END IF	
			
			//---------Begin Added by (Appeon)Stephen 11.07.2017 for Alpha Testing Bug # 5871- IntelliApp-> Refresh issue: Adding a new provider still shows previous providers name at bottom instead of new--------
			ll_prac_id = il_prac_id
			tab_1.tabpage_search.uo_search.of_search_new("")
			il_prac_id = ll_prac_id
			ll_find = tab_1.tabpage_search.uo_search.dw_search.find("prac_id = " +string(il_prac_id),1, tab_1.tabpage_search.uo_search.dw_search.rowcount())
			if ll_find > 0 then
				tab_1.tabpage_search.uo_search.dw_search.selectrow(0, false)
				tab_1.tabpage_search.uo_search.dw_search.selectrow(ll_find, true)
				tab_1.tabpage_search.uo_search.of_select_prac( ll_find)
			end if
			dw_p_data.retrieve(il_prac_id, ii_parent_facility_id)
			//---------End Added ------------------------------------------------------
			
		ELSE
			tab_1.SelectTab( 4 )
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_new_record( il_prac_id )
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_new_prac( True )
		END IF
	END IF
	//Return -99
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script is moved to tab_1.selectionchanged since
//$<modification> CreateOnDemand is checked.
//tab_1.tabpage_verif.uo_verif_summary.of_get_this_facility_data( ) 
IF tab_1.SelectedTab = 5 Then
	tab_1.tabpage_verif.uo_verif_summary.of_get_this_facility_data( )
Else
	ib_page5_refresh = true
End If
//---------------------------- APPEON END ----------------------------

Tab_1.tabpage_detail.uo_data_entry.of_btt_address_link_button()

Return li_retval
end event

event closequery;Long ll_rtn //alfee 11.19.2010
integer li_mes

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 04.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Have the application only check the data need to be updated to the database
//$<modification> before w_prac_data_1 is closed.
powerobject lpo_updatearray[]
lpo_updatearray = ipo_updateobjects
ipo_updateobjects = tab_1.Control[tab_1.SelectedTab].Control
//CALL SUPER::closequery
ll_rtn = SUPER::EVENT closequery() //alfee 11.19.2010
ipo_updateobjects = lpo_updatearray
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
if of_validate_image() = 1 then return 1
//---------------------------- APPEON END ----------------------------


IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_blank_record() THEN
	tab_1.SelectTab( 4 )
	MessageBox("Required Data", "Fill in required Appointment Status data before continuing")
	Return 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 02.13.2006 By: Cao Yongwang
//$<reason> Performance tuning.
//$<modification> Since CreateOnDemand is checked for tab_1, copy 
//$<modification> tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
//$<modification> here and rewrite it.
/*
IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete() = 0 AND gl_prac_id <> 0 THEN
*/
//Start Code Change ----08.01.2011 #V11 maha
if of_get_app_setting("set_62","I") = 0 then li_mes = 1  //message option
if gb_sk_ver then li_mes = 0  //Smart version always off

//if gs_cust_type <> "I" then //Start Code Change ----03.21.2011 #V11 maha - block message for app and smart customers //Start Code Change ----.008.012011 #V11 maha  - corrected from =
if li_mes = 1 then
//End Code Change ----08.01.2011
	IF of_is_de_complete() = 0 AND gl_prac_id <> 0 THEN
	//---------------------------- APPEON END ----------------------------
		Integer li_ans 	
		li_ans = MessageBox("Warning!", "You are closing without pressing the D/E Complete button, Are you sure you want to Continue?", Question!, YesNo!, 2 )
		IF li_ans = 2 THEN
			Return 1
		END IF
	END IF
end if

RETURN ll_rtn //alfee 11.19.2010
end event

event pfc_postopen;Integer li_app_audit_cnt  
Integer li_committee_cnt
integer li_meet //maha 100402

window lw
lw = this

IF gb_se_version THEN
	of_se( )
END IF


tab_1.tabpage_search.uo_search.cb_close.Visible = False
tab_1.tabpage_search.uo_search.of_set_parent( lw) //Start Code Change ----05.07.2015 #V15 maha - moved from below
tab_1.tabpage_search.uo_search.of_set_open_for( "DATAENTRY" )
tab_1.tabpage_search.uo_search.of_set_transaction( SQLCA )

tab_1.tabpage_search.uo_search.uo_grid.of_set_parent( lw)   //Start Code Change ----06.02.2015 #V15 maha
// mskinner 30 march 2005 -- begin
//from here
// mskinner 30 march 2005 -- end
String ls_version

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> There is no need for the Web application to read the local INI file. The Web application
//$<reason> reads INI file from the server.
//$<modification> Make the condition to ensure when the IntelliCred is running on the Web, it does not
//$<modification> reads the local INI file.

//IF NOT FileExists(gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
////	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
	//	Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

//IF ls_version = "None" THEN
//	MessageBox("Error", "Version number not setup.")
////	RETURN -1
//END IF

//site survey
//IF MID( ls_version, 9, 1) = "5" THEN
//	tab_1.tabpage_site.visible = True
//ELSE
//	tab_1.tabpage_site.visible = False
//END IF

//app audit
IF MidA( ls_version, 11, 1) = "4" THEN
	tab_1.tabpage_app_audit.Visible = True
ELSE
	tab_1.tabpage_app_audit.Visible = False
END IF
// mskinner 30 march 2005 -- begin
w_mdi.of_prac_folder_security(lw)
// mskinner 30 march 2005 -- end
//if data entry access off then select app audit tab 
IF tab_1.tabpage_detail.Visible = False AND +&
	tab_1.tabpage_app_audit.Visible = True THEN 
	tab_1.MoveTab( 2, 0 )	
ELSEIF tab_1.tabpage_detail.Visible = False AND +&
	tab_1.tabpage_app_audit.Visible = False AND +&
	tab_1.tabpage_apptmnt_status.Visible = True THEN 
	tab_1.MoveTab( 2, 0 )	
	tab_1.MoveTab( 2, 0 )	
ELSEIF tab_1.tabpage_detail.Visible = False AND +&
	tab_1.tabpage_app_audit.Visible = False AND +&
	tab_1.tabpage_apptmnt_status.Visible = False AND +& 
	tab_1.tabpage_verif.Visible = True THEN 
	tab_1.MoveTab( 2, 0 )	
	tab_1.MoveTab( 2, 0 )	
	tab_1.MoveTab( 2, 0 )	
END IF

//select set_meetings into :li_meet from icred_settings; //maha100402
li_meet = of_get_app_setting("set_meetings","I")
if li_meet = 0 then
	tab_1.tabpage_meetings.visible = false
end if

//-------------appeon begin----------------------
//<$>added:long.zhang 04.17.2014
//<$>reason:v14.2 Provider-Contract direct linking
if gs_cust_type = "I" or of_get_app_setting("set_9","I") = 0 then
	if gb_contract_module then
		if w_mdi.of_security_access(7731) <> 0 then
			this.tab_1.tabpage_contract.visible = true
		else
			this.tab_1.tabpage_contract.visible = false
		end if
	else
		this.tab_1.tabpage_contract.visible = false
	end if
else
	this.tab_1.tabpage_contract.visible = false
end if
//-------------appeon End------------------------

//Start Code Change ----08.01.2011 #V11 maha 
if of_get_app_setting("set_63","I") = 1 then 	ib_skip_inactive_mess = true 

//select prac_window_type into :ii_photo_search_only from security_users where user_id = :gs_user_id;  //Start Code Change ----10.26.2015 #V15 maha - moved to open       //Start Code Change ----05.19.2011 #V11 maha 

GarbageCollect ( )

//Added by Nova on 08.13.2008
if ib_auto_locate then of_dashboard(str_para.data_name,str_para.data_id,str_para.data_ext_id)
//
//Start Code Change ----09.10.2008 #V85 maha
inv_action_items =  CREATE pfc_n_cst_ai_action_items
//Start Code Change ----09.30.2008 #V85 maha
inv_printletters =  CREATE pfc_n_cst_ai_printletters

////----------- RP added 1.5.2016------------------------------------
//tab_1.tabpage_search.uo_search.height = tab_1.tabpage_search.uo_search.height + this.workspaceHeight() - tab_1.y - tab_1.height
//tab_1.height = this.workspaceHeight() - tab_1.y

//------------------ RP added 1.7.2016----------------------------------------------------------
tab_1.tabpage_search.uo_search.event post ue_setResize()
//tab_1.tabpage_search.uo_search.dw_search.event resize(0, tab_1.tabpage_search.uo_search.dw_search.width, tab_1.tabpage_search.uo_search.dw_search.height)


end event

event pfc_postupdate;call super::pfc_postupdate;IF ib_new_prac THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-15
	//$<add> 03.22.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	Integer li_parent_facility_id
	li_parent_facility_id = tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id()

	gnv_appeondb.of_startqueue( )

	//retrieve the facility name. The facility name will be used in the of_Setup_title function.
	SELECT facility.facility_name  
	INTO :is_facility_name  
	FROM facility  
	WHERE facility.facility_id = :li_parent_facility_id   ;
	
	//Retrieve the full name. The full name will be used in the of_setup_title function
	SELECT v_full_name.full_name
	INTO :is_full_name  
	FROM v_full_name  
	WHERE v_full_name.prac_id = :il_prac_id   ;
	
	//Added for Work flow. Get the related work flow for new practitioner added in IntelliApp. 10/30/2006 Henry
	If of_get_app_setting('set_9' , 'I') = 1 Then
		SELECT facility.facility_name, wf_new_practitioner  
		INTO :is_facility_name  , :ii_wf_new_practitioner
		FROM facility  
		WHERE facility.facility_id = 1   ;
		li_parent_facility_id = 1
	End if
	//End added for Work flow. 10/30/2006 Henry
	
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------

	//Added for Work flow. trigger off the related work flow for practitioner added. 10/30/2006 Henry
	If of_get_app_setting('set_9' , 'I') = 1 and  gb_workflow  Then
		If not isnull(ii_wf_new_practitioner) and ii_wf_new_practitioner > 0 Then
			n_cst_workflow_triggers lnv_workflow
			lnv_workflow = create n_cst_workflow_triggers
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 11.17.2006 By: Jervis
			//$<reason> 
			//lnv_workflow.of_workflow_create_action_items( il_prac_id, il_rec_id, 1, li_parent_facility_id, ii_wf_new_practitioner)
			str_action_item lstr_action
			lstr_action.prac_id = il_prac_id
			lstr_action.rec_id = il_rec_id
			lstr_action.facility_id = li_parent_facility_id
			lstr_action.screen_id = -10
			lstr_action.wf_id =ii_wf_new_practitioner
			lnv_workflow.of_workflow_create_action_items(lstr_action)
			destroy lnv_workflow
			//---------------------------- APPEON END ----------------------------
		End if
	End If
	//End added for Work flow. 10/30/2006 Henry
	
	of_setup_title()
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<modify> 04.04.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add a condition to have the application only refresh the data
//$<modification> in the tab page only when it is selected.
/*
IF tab_1.SelectedTab <> 2 THEN
	tab_1.tabpage_verif.uo_verif_summary.of_post_update()
END IF

IF tab_1.SelectedTab <> 2 THEN
	uo_app_stat.of_get_status( il_prac_id, tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id() )
	tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()	
END IF
*/

IF tab_1.SelectedTab <> 2 THEN
	tab_1.tabpage_verif.uo_verif_summary.of_post_update()

	IF tab_1.SelectedTab = 3 OR tab_1.SelectedTab = 5 THEN
		//uo_app_stat.of_get_status( il_prac_id, tab_1.tabpage_detail.uo_data_entry.of_get_parent_facility_id() )
		uo_app_stat.of_get_status_rec( il_affil_rec_id )  //Start Code Change ----12.08.2014 #V14.2 maha - changed function
	END IF
	
	IF tab_1.SelectedTab <> 4 THEN ib_page4_refresh = true
END IF
//---------------------------- APPEON END ----------------------------

//IF tab_1.SelectedTab = 7 THEN
//	tab_1.tabpage_site.uo_survey.of_Retrieve()
//END IF

RETURN 1
end event

event open;call super::open;integer c
long ll_app_color

//--------Begin Added by Nova 08.13.2008------------------------
If Isvalid(message.powerobjectparm) Then
	If message.powerobjectparm.classname() = 'str_dashboard' Then
		str_para=message.powerobjectparm
		ib_auto_locate = True
		//pfc_postopen calls of_dashboard to locate the provider
	End If
End If

//Start Code Change ----10.04.2012 #V12 maha
ll_app_color = gl_bg_color

if ib_auto_locate = True then
	ll_app_color = str_para.color
end if
//End Code Change ----10.04.2012

//if gb_sk_ver then  //Start Code Change ----05.24.2010 #V10 maha - special k screen colors
//Start Code Change ----10.04.2012 #V12 maha - changed to local variable
	if ll_app_color > 0 then
		//of_app_color( gl_bg_color )  //Start Code Change ----03.17.2016 #V15 maha - changed to blue in all variations
		of_app_color( ll_app_color )
	end if
//end if

//Start Code Change ----06.29.2012 #V12 maha - customization to switch button bar and lights box
c = of_get_app_setting("set_27","I")
if c = 5 then
	if not gb_sk_ver then
// RP		uo_app_stat.x = 10
// RP		st_buttons.x = uo_app_stat.x + uo_app_stat.width + 20
		cb_save.x = st_buttons.x + 20
		cb_add.x = cb_save.x + cb_save.width 
		cb_delete.x = cb_add.x + cb_add.width 
		cb_notes.x = cb_delete.x + cb_delete.width 
		cb_print.x = cb_notes.x + cb_notes.width
		cb_prior.x = cb_print.x + cb_print.width
		cb_next.x = cb_prior.x + cb_prior.width
		cb_b3.x = cb_next.x + cb_next.width
		cb_b4.x = cb_b3.x + cb_b3.width
		cb_b5.x = cb_b4.x + cb_b4.width
		cb_b6.x = cb_b5.x + cb_b5.width
		cb_b7.x = cb_b6.x + cb_b6.width
	end if
end if
//Start Code Change ----06.29.2012 

//Start Code Change ----10.24.2012 #V12 maha - use tool bar option for childrens hosp
if gb_use_prac_toolbar then
	tab_1.y = 8
	tab_1.bringtotop = true
	uo_app_stat.y = 124
	uo_app_stat.bringtotop = true
end if
//End Code Change ----10.24.2012

//--------End Added --------------------------------------------

gl_prac_id = 0 //readded maha 041805
 gw_prac_data = this	//Start Code Change ----03.05.2013 #V12 maha
gi_parent_facility = 0 //Reset gi_parent_facility, Added by Appeon long.zhang 01.08.2016 (BugL010801)

//Start Code Change ----10.26.2012 #V12 maha
select count(alert_id) into :c from alert_hdr where alert_type = 30 and run_from = 2 and active_status = 1;
if c > 0 then ib_run_notification = true
//End Code Change ----10.26.2012 

tab_1.tabpage_app_audit.uo_app_audit.of_set_window( this)   //Start Code Change ----02.07.2017 #V153 maha

select prac_window_type into :ii_photo_search_only from security_users where user_id = :gs_user_id;   //Start Code Change ----10.26.2015 #V15 maha - moved from postopen

//of_zoom()//Start Code Change ----07.13.2017 #V154 maha


end event

event pfc_preopen;call super::pfc_preopen;
LONG LL_I
string ls_scale
move(0,0)
powerobject lo_powerobjects[]

//Added by Appeon long.zhang 05.19.2016 (Bug ID #5161 for Case # 00063651: IntelliApp)
If appeongetclienttype() = 'WEB' Then
	//IF POSITION IS NOT CORRECT, REOPEN THIS WINDOW, modified by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)
	If w_mdi.of_check_provider_position(This) = False Then //Added by Appeon long.zhang 06.07.2016 (Bug ID #5189 for Case # 00064308: Problems after weekend update)
		//Post of_open_at_start_new(False) //Reopen this window (the same with the logic in w_home_buttons) 
		//Close(This) //moved to  w_mdi.of_check_provider_position, comment by Appeon long.zhang 04.07.2017
		Return
	End If
End If

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )

// RP added 1.7.2016
//this.inv_resize.of_setMinSize(2*p_buttons.x + p_buttons.width, 2408)
this.inv_resize.of_setMinSize(cb_b7.x + 24 + st_provider_border.width , 2408)  //Start Code Change ----05.19.2016 #V152 maha - tweaked

il_oriWidth = this.workspacewidth( )
il_oriHeight = this.workspaceheight( )

ls_scale = this.inv_resize.scale

//Start Code Change ----08.09.2012 #V12 maha - modified to stabilize the button bar
//FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
//   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
//NEXT

// RP Modified 1.5.2016---------------------------------------
//this.inv_resize.of_Register (this.tab_1, ls_scale)
this.inv_resize.of_Register (this.tab_1, 0, 0, 100, 100)


//this.inv_resize.of_Register (this.p_prac_photo, ls_scale)  //Start Code Change ----10.26.2015 #V15 maha - removed
//this.inv_resize.of_Register (this.dw_p_data, ls_scale) //Start Code Change ----10.26.2015 #V15 maha - removed
//End Code Change ----08.09.2012

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-17
//$<add> 01.18.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Add a condition to ensure that inv_resize will not be executed, since
//$<modification> the execution of inv_resize negatively affects the performance very much
If appeongetclienttype() = 'WEB' and gb_autoresize = false Then return
//---------------------------- APPEON END ----------------------------

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object  SEARCH
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//----------------------------- RP modified 1.5.2016-------------------------------------------
//this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search, ls_scale  )

//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_search.uo_search.CONTrol)	
//   this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search.CONTrol[LL_I]  , ls_scale )
//next

//----------------------------- RP modified 1.5.2016-------------------------------------------
// this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search.dw_search  , ls_scale )

//----------------------------- RP added 1.5.2016------------------------------------------------------------------------------------------
st_buttons.width = this.workspaceWidth() - 2*st_buttons.x
this.inv_resize.of_Register(st_buttons, 0, 0, 100, 0)
this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search, 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search.dw_search, 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_search.uo_search.st_dw_search_border, 0, 0, 100, 100)
this.inv_resize.of_Register(st_provider_border, 100, 0, 0, 100)
this.inv_resize.of_Register(dw_red_flag_count, 100, 0, 0, 0)
this.inv_resize.of_Register(dw_standing, 100, 0, 0, 0)
this.inv_resize.of_Register(uo_app_stat, 100, 0, 0, 0)
//tab_1.tabpage_search.uo_search.height = tab_1.tabpage_search.uo_search.height + this.workspaceHeight() - tab_1.y - tab_1.height
tab_1.height = this.workspaceHeight() - tab_1.y
tab_1.tabpage_search.uo_search.height = tab_1.tabpage_search.height - 12
tab_1.tabpage_search.uo_search.dw_search.height = tab_1.tabpage_search.uo_search.height - tab_1.tabpage_search.uo_search.dw_search.y - 4
tab_1.tabpage_search.uo_search.st_dw_search_border.height = tab_1.tabpage_search.uo_search.dw_search.height + 8
st_provider_border.height = tab_1.tabpage_search.uo_search.st_dw_search_border.height


//tab_1.tabpage_search.uo_search.dw_search.width = tab_1.tabpage_search.uo_search.width - 2*tab_1.tabpage_search.uo_search.dw_search.x
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search uo_data_entry DEMOGRAPHICS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------------- RP added 1.12.2016 ------------------------------------------------------------------------------------
//this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry, ls_scale  )
this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry, 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.dw_select_section, 0, 0, 0, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.st_dw_select_section_border, 0, 0, 0, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view, 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data , 0, 0, 100, 100)  //Start Code Change ----02.18.2016 #V15 maha
// Set sizes
tab_1.tabpage_detail.uo_data_entry.height = tab_1.tabpage_detail.height - 32
tab_1.tabpage_detail.uo_data_entry.tab_view.height = tab_1.tabpage_detail.uo_data_entry.height - tab_1.tabpage_detail.uo_data_entry.tab_view.y - 20
tab_1.tabpage_detail.uo_data_entry.st_dw_select_section_border.height = tab_1.tabpage_detail.uo_data_entry.height - tab_1.tabpage_detail.uo_data_entry.st_dw_select_section_border.y - 8
tab_1.tabpage_detail.uo_data_entry.dw_select_section.height = tab_1.tabpage_detail.uo_data_entry.st_dw_select_section_border.height - 8

 //Start Code Change ----02.18.2016 #V15 maha
FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data.CONTrol)
   this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data.CONTrol[LL_I]  , ls_scale )
next
 //End Code Change ----02.18.2016 


//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_browse.CONTrol) 
//	this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_details.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_details.CONTrol[LL_I]  , ls_scale )
//next
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_image.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_image.CONTrol[LL_I]  , ls_scale )
//next
//--------------------------------- end RP added 1.12.2016 ------------------------------------------------------------------------------------

//Start Code Change ----07.01.2014 #V14.2 maha
this.inv_resize.of_register( this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data, ls_scale)

For LL_I = 1 to UpperBound(this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data.control )
	this.inv_resize.of_register( this.tab_1.tabpage_detail.uo_data_entry.tab_view.tabpage_linked_data.uo_linked_data.control[LL_I] ,ls_scale)
next

//Start Code Change ----07.01.2014

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search uo_app_audit  CHECKLIST
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------------- RP added 1.12.2016 ------------------------------------------------------------------------------------
//this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit , ls_scale  )
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_browse.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_detail.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_detail.CONTrol[LL_I]  , ls_scale )
//next
this.inv_resize.of_register(this.tab_1.tabpage_app_audit.uo_app_audit , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities , 0, 0, 0, 100)
this.inv_resize.of_register(this.tab_1.tabpage_app_audit.uo_app_audit.st_dw_orgs_facilities_border, 0, 0, 0, 100)
this.inv_resize.of_register(this.tab_1.tabpage_app_audit.uo_app_audit.tab_view , 0, 0, 100, 100)
tab_1.tabpage_app_audit.uo_app_audit.height = tab_1.tabpage_app_audit.height - 32
tab_1.tabpage_app_audit.uo_app_audit.width = tab_1.tabpage_app_audit.width - 27
tab_1.tabpage_app_audit.uo_app_audit.tab_view.width = tab_1.tabpage_app_audit.uo_app_audit.width - tab_1.tabpage_app_audit.uo_app_audit.tab_view.x + 5
tab_1.tabpage_app_audit.uo_app_audit.tab_view.height = tab_1.tabpage_app_audit.uo_app_audit.height - tab_1.tabpage_app_audit.uo_app_audit.tab_view.y - 8
tab_1.tabpage_app_audit.uo_app_audit.st_dw_orgs_facilities_border.height = tab_1.tabpage_app_audit.uo_app_audit.height - tab_1.tabpage_app_audit.uo_app_audit.st_dw_orgs_facilities_border.y - 12
tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities.height = tab_1.tabpage_app_audit.uo_app_audit.st_dw_orgs_facilities_border.height - 8
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.dw_detail, 0, 0, 100, 74)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.st_1, 0, 74, 0, 0)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.cb_add, 0, 74, 0, 0)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.cb_delete, 0, 74, 0, 0)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.dw_tracker, 0, 74, 100, 26)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.dw_browse, 0, 0, 100, 100)
this.inv_resize.of_register(tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_audit.dw_audit, 0, 0, 100, 100)   //Start Code Change ----02.07.2017 #V153 maha 
tab_1.tabpage_app_audit.uo_app_audit.dw_browse.width = tab_1.tabpage_app_audit.uo_app_audit.tab_view.width - 55
tab_1.tabpage_app_audit.uo_app_audit.dw_browse.height = tab_1.tabpage_app_audit.uo_app_audit.tab_view.y + tab_1.tabpage_app_audit.uo_app_audit.tab_view.height - tab_1.tabpage_app_audit.uo_app_audit.dw_browse.y - 24
tab_1.tabpage_app_audit.uo_app_audit.dw_detail.width = tab_1.tabpage_app_audit.uo_app_audit.tab_view.width - 55
tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.width = tab_1.tabpage_app_audit.uo_app_audit.tab_view.width - 55
tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.height = tab_1.tabpage_app_audit.uo_app_audit.tab_view.y + tab_1.tabpage_app_audit.uo_app_audit.tab_view.height - tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.y - 55 //(Appeon)Stephen 02.24.2016 modified '24' to '55'- BugS012902
tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_audit.dw_audit.height = tab_1.tabpage_app_audit.uo_app_audit.dw_browse.height //Start Code Change ----02.07.2017 #V153 maha 
tab_1.tabpage_app_audit.uo_app_audit.tab_view.tabpage_audit.dw_audit.width = tab_1.tabpage_app_audit.uo_app_audit.dw_browse.width  //Start Code Change ----02.07.2017 #V153 maha 
// st_1, cb_add, cb_delete
//tab_1.tabpage_app_audit.uo_app_audit.event post ue_setResize()
//--------------------------------- end RP added 1.12.2016 ------------------------------------------------------------------------------------


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search uo_affill_status  APPOINTMENTS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.02.2016 #V15 maha
this.inv_resize.of_register(this.tab_1.tabpage_apptmnt_status.uo_affill_status , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities , 0, 0, 0, 100)
this.tab_1.tabpage_apptmnt_status.uo_affill_status.height = this.tab_1.tabpage_apptmnt_status.height  + 90
this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.height = this.tab_1.tabpage_apptmnt_status.uo_affill_status.height  - this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.y - 180
this.tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities.height = this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.height - 4
//this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status , ls_scale  )

//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.CONTrol[LL_I]  , ls_scale )
//next
//		
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.CONTrol) //alfee 11.18.2010
//	this.inv_resize.of_Register (this.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----02.02.2016
		
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search tabpage_image  IMAGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.02.2016 #V15 maha

this.inv_resize.of_register(this.tab_1.tabpage_image.uo_image , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_image.uo_image.tab_view , 0, 0, 100, 100)
this.tab_1.tabpage_image.uo_image.height =  this.tab_1.height - 180
this.tab_1.tabpage_image.uo_image.tab_view.height = this.tab_1.height - 190

//this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image , ls_scale  )

//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.CONTrol[LL_I]  , ls_scale )
//next
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_browse.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_image.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_image.CONTrol[LL_I]  , ls_scale )
//next
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_setup.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_image.uo_image.TAB_view.TABpage_setup.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----02.02.2016 


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search uo_meetings  MEETINGS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.03.2016 #V15 maha
//this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings , ls_scale  )
this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings , 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.tab_view , 0, 0, 100, 100)
this.tab_1.tabpage_meetings.uo_meetings.height =  this.tab_1.height - 180
this.tab_1.tabpage_meetings.uo_meetings.tab_view.height =  this.tab_1.height - 190

//Start Code Change ----08.09.2012 #V12 maha - resize cleanup
//this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view , ls_scale )
////this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse , ls_scale )  //Start Code Change ----10.15.2014 #V14.2 maha
////this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail, ls_scale )
//this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse.dw_browse , ls_scale )
//this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail.dw_detail  , ls_scale )
//End Code Change ----02.03.2016

//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.CONTrol[LL_I]  , ls_scale )
//next
//
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_meetings.uo_meetings.TAB_view.TABPage_detail.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----08.09.2012

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search tabpage_net  APPLICATIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.04.2016 #V15 maha
//this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net , ls_scale  )
this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net , 0, 0, 100, 100)
//this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.tab_1 , 0, 0, 100, 100)
//this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.dw_orgs_facilities , 0, 0, 100, 100)


this.tab_1.tabpage_net.uo_net.height = this.tab_1.tabpage_net.height  + 90
//this.tab_1.tabpage_net.uo_net.TAB_1.height = this.tab_1.tabpage_net.uo_net.height - this.tab_1.tabpage_net.uo_net.TAB_1.y  - 108 - 250



//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_ai.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_ai.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABpage_ids.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABpage_ids.CONTrol[LL_I]  , ls_scale )
//next 
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_notes.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.TABPage_notes.CONTrol[LL_I]  , ls_scale )
//next 
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_net.uo_net.TAB_1.tabpage_report.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_net.uo_net.TAB_1.tabpage_report.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----02.04.2016 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The tabpage_privileges PRIVILEGES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//Start Code Change ----01.28.2016 #V15 maha
//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv , ls_scale  )


	////Start Code Change ----08.09.2012 #V12 maha - cleanup of resize
	//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1  , ls_scale )
	////this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse  , ls_scale )
	////this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail  , ls_scale )
	////this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv  , ls_scale )
	//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.dw_select  , ls_scale )
	//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.dw_browse  , ls_scale )
	//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail  , ls_scale )
	//this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv.dw_expired  , ls_scale )
	////this.tab_1.tabpage_privileges.uo_priv.of_post_resize()

this.inv_resize.of_register(this.tab_1.tabpage_privileges.uo_priv , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_privileges.uo_priv.tab_1 , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_privileges.uo_priv.dw_select , 0, 0, 0, 100)
this.tab_1.tabpage_privileges.uo_priv.height = this.tab_1.tabpage_privileges.height  + 108
this.tab_1.tabpage_privileges.uo_priv.tab_1.height = this.tab_1.tabpage_privileges.uo_priv.height  - this.tab_1.tabpage_privileges.uo_priv.tab_1.y - 180
this.tab_1.tabpage_privileges.uo_priv.dw_select.height = this.tab_1.tabpage_privileges.uo_priv.tab_1.height
//Start Code Change ----01.28.2016 


//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----08.09.2012

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search tabpage_profile   PROFILES
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile , ls_scale  )

//Start Code Change ----02.03.2016 #V15 maha - 
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification.CONTrol[LL_I]  , ls_scale )
//next

this.inv_resize.of_register(this.tab_1.tabpage_profile.uo_profile , 0, 0, 100, 100)
this.inv_resize.of_register(this.tab_1.tabpage_profile.uo_profile.tab_report , 0, 0, 100, 100)
this.tab_1.tabpage_profile.uo_profile.height = this.tab_1.tabpage_profile.height + 108
this.tab_1.tabpage_profile.uo_profile.tab_report.height = this.tab_1.tabpage_profile.uo_profile.height  - this.tab_1.tabpage_profile.uo_profile.tab_report.y - 180
//End Code Change ----02.03.2016

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search tabpage_verif  VERIFICATIONS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Start Code Change ----08.10.2012 #V12 maha - modified registration
//this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary , ls_scale  )
//this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view , ls_scale  )
//this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.dw_browse  , ls_scale  )
//this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.dw_detail  , ls_scale  )
//this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities , ls_scale  )
//
//Start Code Change ----02.03.2016 #V15 maha
this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary  , 0, 0, 100, 100)
this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view  , 0, 0, 100, 100)
this.tab_1.tabpage_verif.uo_verif_summary.height =  this.tab_1.height - 180
this.tab_1.tabpage_verif.uo_verif_summary.tab_view.height = this.tab_1.height - 190
//End Code Change ----02.03.2016

//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_browse .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_browse.CONTrol[LL_I]  , ls_scale )
//next
//
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_detail .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_detail.CONTrol[LL_I]  , ls_scale )
//next
//
//FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred .CONTrol)
//   this.inv_resize.of_Register (this.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.CONTrol[LL_I]  , ls_scale )
//next
//End Code Change ----08.10.2012

//-------------appeon begin----------------------
//<$>added:long.zhang 04.17.2014
//<$>reason:v14.2 Provider-Contract direct linking

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// tabpage_contract  CONTRACTS
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.03.2016 #V15 maha
//this.inv_resize.of_register( this.tab_1.tabpage_contract.uo_contracts, ls_scale)
this.inv_resize.of_register( this.tab_1.tabpage_contract.uo_contracts, 0, 0, 100, 100)
this.tab_1.tabpage_contract.uo_contracts.height = this.tab_1.height - 180
//For LL_I = 1 to UpperBound(this.tab_1.tabpage_contract.uo_contracts.control )
//	this.inv_resize.of_register( this.tab_1.tabpage_contract.uo_contracts.control[LL_I] ,ls_scale)
//next
//End Code Change ----02.03.2016




IF appeongetclienttype()= 'WEB' THEN
	tab_1.tabpage_contract.PictureName='Handshake.jpg' //Alfee 10.28.2014 for BugA092601 
	
	Yield() //Work around for WEB Version, Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)  //Moved from open event by Appeon long.zhang 04.11.2017 (V15.3 Bug # 5597 - Provider folder: Getting syntax message when opening)
END IF


end event

event pfc_endtran;
IF ai_update_results = 1 THEN
	IF tab_1.SelectedTab <> 4 THEN
		COMMIT USING SQLCA;
	END IF
END IF

RETURN 1


end event

event resize;call super::resize;CONSTANT Integer ST_H = 64
//CONSTANT Integer TABHdr_H = 104 
Integer TABHdr_H = 104 //alfee 04.06.2010
integer li_sel_y, li_val
long ll_right_edge

this.setredraw(false)  //(Appeon)Stephen 06.29.2017 - Bug ID #5715 for Case #00071338 Issue With IC
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 02.05.2009 By: Nova
//$<Reason> Fix a defect. when window is resized,move the p_face position
//tab_1.tabpage_detail.p_face.move( tab_1.tabpage_detail.uo_data_entry.st_recs.x -343, tab_1.tabpage_detail.uo_data_entry.st_recs.y -904)
tab_1.tabpage_detail.p_face.move( tab_1.tabpage_detail.uo_data_entry.st_recs.x -343, tab_1.tabpage_detail.uo_data_entry.dw_detail.y + tab_1.tabpage_detail.uo_data_entry.dw_detail.height - 800) //alfee 03.15.2010
//---------------------------- APPEON END ----------------------------

tab_1.y = st_buttons.y + st_buttons.height + 10

//------------Begin Added by Alfee 04.01.2010 -----------------------
IF appeongetclienttype() = 'WEB' then TABHdr_H = TABHdr_H - 14 //04.06.2010

//Credential
if isvalid(tab_1.tabpage_detail.uo_data_entry.tab_view) then 
	//uo_app_stat
	//Start Code Change ----10.24.2012 #V12 maha
	if gb_use_prac_toolbar then
		IF appeongetclienttype() = 'WEB' then 
	// #V12 maha - readded for childres hosp option 
			uo_app_stat.y = tab_1.tabpage_detail.uo_data_entry.y + tab_1.tabpage_detail.uo_data_entry.tab_view.y + 88 //change from 128 to 118 - alfee 04.22.2010 
// RP			uo_app_stat.x = p_prac_photo.x - 165
			//st_buttons.y = tab_1.tabpage_detail.y + 20 //Start Code Change ----10.11.2011 #V12 maha
		ELSE
			uo_app_stat.y = tab_1.tabpage_detail.uo_data_entry.y + tab_1.tabpage_detail.uo_data_entry.tab_view.y + 118 //change from 128 to 118 - alfee 04.22.2010 
// RP			uo_app_stat.x =  p_prac_photo.x - 165
			//st_buttons.y = tab_1.tabpage_detail.y + 20 //Start Code Change ----10.11.2011 #V12 maha
		END IF
	end if

	uo_app_stat.height = 140    //84
	 //Start Code Change ----10.14.2015 #V15 maha
	 //---------Begin Modified by (Appeon)Stephen 03.11.2016 for ISG TEST--------
	//uo_app_stat.y =  tab_1.y + 110   //p_prac_photo.y - uo_app_stat.height - 20  
	IF appeongetclienttype() = 'WEB' then 
		uo_app_stat.y =  tab_1.y + 92
	else
		uo_app_stat.y =  tab_1.y + 104
	end if
	//---------End Modfiied ------------------------------------------------------

	dw_standing.y = uo_app_stat.y
	dw_red_flag_count.y = uo_app_stat.y
	
 //Start Code Change ----10.26.2015 #V15 maha  - modified to keep set the app stat and photo position and width base on the right edge of screen
	ll_right_edge = tab_1.x + tab_1.width - 30
// RP	uo_app_stat.x = ll_right_edge - uo_app_stat.width
	//uo_app_stat.x = p_prac_photo.x + p_prac_photo.width - uo_app_stat.width
//	dw_standing.x = uo_app_stat.x - dw_standing.width
// RP	dw_red_flag_count.x  =  dw_standing.x - dw_red_flag_count.width
	//messagebox("Y", string(dw_standing.y) )
	 //End Code Change ----10.14.2015

//---------------------RP modified 1.7.2016  V15----------------------------------	 
//	p_prac_photo.x = uo_app_stat.x
p_prac_photo.x = st_provider_border.x + (st_provider_border.width - p_prac_photo.width)/2

	//p_prac_photo.width = uo_app_stat.width   //Start Code Change ----11.03.2015 #V15 maha
	dw_p_data.x = uo_app_stat.x
//RP	dw_p_data.width = uo_app_stat.width
 //End Code Change ----10.26.2015	
	
	tab_1.tabpage_detail.uo_data_entry.st_recs.height = ST_H //st_recs
//	tab_1.tabpage_detail.uo_data_entry.st_select.height = ST_H //st_select
	tab_1.tabpage_detail.uo_data_entry.st_recs.y = tab_1.tabpage_detail.uo_data_entry.tab_view.y + 20 //alfee 04.22.2010	
//	tab_1.tabpage_detail.uo_data_entry.dw_select_section.y = tab_1.tabpage_detail.uo_data_entry.tab_view.y + TABHdr_H //dw_select_section
	li_val = tab_1.tabpage_detail.uo_data_entry.tab_view.height //- TABHdr_H 	
	tab_1.tabpage_detail.uo_data_entry.tab_view.width =  tab_1.tabpage_detail.uo_data_entry.width - 25 - tab_1.tabpage_detail.uo_data_entry.tab_view.x  //Start Code Change ----02.18.2016 #V15 maha
	if li_val < 0 then li_val = 0	
//	tab_1.tabpage_detail.uo_data_entry.dw_select_section.height = li_val
	tab_1.tabpage_detail.uo_data_entry.of_post_resize( )  //Start Code Change ----02.18.2016 #V15 maha
end if	


 //Start Code Change ----03.30.2015 #V15 maha - modifed for advanced search
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//SEARCH 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Start Code Change ----08.10.2012 #V12 maha

if isvalid(tab_1.tabpage_search.uo_search) then 
	tab_1.tabpage_search.uo_search.width = dw_p_data.x - 20  //Start Code Change ----06.01.2015 #V15 maha
	//for advanced adjust height
	if tab_1.tabpage_search.uo_search.ib_advanced then
		
		tab_1.tabpage_search.uo_search.dw_search.y =  tab_1.tabpage_search.uo_search.gb_department.y + 170  //Start Code Change ----05.12.2016 #V15 maha
		//gb_letters.y + tab_1.tabpage_search.uo_search.gb_letters.height + 16
		tab_1.tabpage_search.uo_search.dw_search.x = 14
		tab_1.tabpage_search.uo_search.dw_search.height =  st_provider_border.height - tab_1.tabpage_search.uo_search.dw_search.y + 150  //Start Code Change ----05.12.2016 #V15 maha
		//tab_1.tabpage_search.uo_search.height -  (tab_1.tabpage_search.uo_search.gb_letters.y + tab_1.tabpage_search.uo_search.gb_letters.height) -32
	
	else	
		tab_1.tabpage_search.uo_search.dw_search.y =  150  //425 //360    //516
		tab_1.tabpage_search.uo_search.dw_search.x = 14	
		tab_1.tabpage_search.uo_search.dw_search.height = st_provider_border.height  //Start Code Change ----05.12.2016 #V15 maha
		//tab_1.tabpage_search.uo_search.height - 180

	end if			
	 //Start Code Change ----05.07.2015 #V15 maha
	 //for actions grid adjust width
	if tab_1.tabpage_search.uo_search.ib_show_grid then

		tab_1.tabpage_search.uo_search.uo_grid.y = tab_1.tabpage_search.uo_search.dw_search.y
		tab_1.tabpage_search.uo_search.uo_grid.height = tab_1.tabpage_search.uo_search.dw_search.height  //Start Code Change ----05.12.2016 #V15 maha
		//do not change width of grid
		//tab_1.tabpage_search.uo_search.uo_grid.width = dw_p_data.x - tab_1.tabpage_search.uo_search.uo_grid.x - 100 

		tab_1.tabpage_search.uo_search.dw_search.width = dw_p_data.x - tab_1.tabpage_search.uo_search.dw_search.x - tab_1.tabpage_search.uo_search.uo_grid.width - 120 //maha 05.07.2015

		tab_1.tabpage_search.uo_search.uo_grid.x = tab_1.tabpage_search.uo_search.dw_search.x + tab_1.tabpage_search.uo_search.dw_search.width + 25

		tab_1.tabpage_search.uo_search.uo_grid.of_resize() //resizes the dw height
		
		
	else
		 //Start Code Change ----10.26.2015 #V15 maha
		if  dw_p_data.visible then
			tab_1.tabpage_search.uo_search.dw_search.width = dw_p_data.x - tab_1.tabpage_search.uo_search.dw_search.x - 50  //100 	
		else
			tab_1.tabpage_search.uo_search.dw_search.width = ll_right_edge - tab_1.tabpage_search.uo_search.dw_search.x - 50
		end if
		 //End Code Change ----10.26.2015
	end if
	 //End Code Change ----05.07.2015
end if
 //End Code Change ----03.30.2015
//messagebox("",string(tab_1.tabpage_search.uo_search.dw_search.width))

dw_p_data.height = st_provider_border.height +  st_provider_border.y - dw_p_data.y - 20  //Start Code Change ----05.19.2017 #V154 maha - resize photo data

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//checklist
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_app_audit.uo_app_audit.tab_view) then 	
	tab_1.tabpage_app_audit.uo_app_audit.st_recs.height = ST_H //st_recs
	tab_1.tabpage_app_audit.uo_app_audit.cb_add.height = 84 //st_recs
	tab_1.tabpage_app_audit.uo_app_audit.cb_delete.height = 84 //st_recs
//	tab_1.tabpage_app_audit.uo_app_audit.st_1.height = ST_H //st_1
	tab_1.tabpage_app_audit.uo_app_audit.st_recs.y = tab_1.tabpage_app_audit.uo_app_audit.tab_view.y + 20 //alfee 04.22.2010	
//	tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities.y = tab_1.tabpage_app_audit.uo_app_audit.tab_view.y + TABHdr_H //dw_orgs_facilities
	li_val = tab_1.tabpage_app_audit.uo_app_audit.tab_view.height // - TABHdr_H 	
	if li_val < 0 then li_val = 0	
// RP	tab_1.tabpage_app_audit.uo_app_audit.dw_orgs_facilities.height = li_val	
end if

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Appmt. Status
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view) then 	
	tab_1.tabpage_apptmnt_status.uo_affill_status.st_recs.height = ST_H //st_recs
	//tab_1.tabpage_apptmnt_status.uo_affill_status.st_1.height = ST_H //st_1
	tab_1.tabpage_apptmnt_status.uo_affill_status.st_recs.y = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.y + 20 //alfee 04.22.2010	
//	tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities.y = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.y + TABHdr_H //dw_orgs_facilities
	li_val = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.height // - TABHdr_H 	
	if li_val < 0 then li_val = 0	
	
	//Start Code Change ----02.02.2016 #V15 maha
	tab_1.tabpage_apptmnt_status.uo_affill_status.width = tab_1.width - 25
	 tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.width =  tab_1.tabpage_apptmnt_status.uo_affill_status.width - 25 - tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.x
	 
	 tab_1.tabpage_apptmnt_status.uo_affill_status.of_post_resize()
	//End Code Change ----02.02.2016 
// RP	tab_1.tabpage_apptmnt_status.uo_affill_status.dw_orgs_facilities.height = li_val	
end if

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Verification
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_verif.uo_verif_summary.tab_view) then 	
	tab_1.tabpage_verif.uo_verif_summary.st_recs.height = ST_H //st_recs
//	tab_1.tabpage_verif.uo_verif_summary.st_1.height = ST_H //st_1
	tab_1.tabpage_verif.uo_verif_summary.st_recs.y = tab_1.tabpage_verif.uo_verif_summary.tab_view.y + 20 //alfee 04.22.2010	
//	tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.y = tab_1.tabpage_verif.uo_verif_summary.tab_view.y + TABHdr_H //dw_orgs_facilities
	li_val = tab_1.tabpage_verif.uo_verif_summary.tab_view.height //- TABHdr_H 	
	if li_val < 0 then li_val = 0	
	tab_1.tabpage_verif.uo_verif_summary.width = tab_1.width - 25 
	 tab_1.tabpage_verif.uo_verif_summary.tab_view.width = tab_1.tabpage_verif.uo_verif_summary.width - 25 -  tab_1.tabpage_verif.uo_verif_summary.tab_view.y

	
// RP	tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities.height = li_val	
	tab_1.tabpage_verif.uo_verif_summary.of_post_resize( )
end if

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Profile
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_profile.uo_profile) then 	
//	tab_1.tabpage_profile.uo_profile.st_1.height = ST_H //st_1
	tab_1.tabpage_profile.uo_profile.st_1.y = tab_1.tabpage_profile.uo_profile.tab_report.y + 15 //20 -> 15 - alfee 11.18.2010	
	 //Start Code Change ----12.09.2015 #V15 maha
	tab_1.tabpage_profile.uo_profile.dw_select.height = 84
	tab_1.tabpage_profile.uo_profile.dw_select.width = 919
	 //Start Code Change ----12.09.2015
	 //Start Code Change ----02.03.2016 #V15 maha
	tab_1.tabpage_profile.uo_profile.width =  st_provider_border.x - 25
	tab_1.tabpage_profile.uo_profile.tab_report.width = tab_1.tabpage_profile.uo_profile.width  - 25 - tab_1.tabpage_profile.uo_profile.tab_report.x
	tab_1.tabpage_profile.uo_profile.of_post_resize()
	 //eND Code Change ----02.03.2016 
end if

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Image  Documents
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_image.uo_image.tab_view) then 
	//Start Code Change ----02.03.2016 #V15 maha - removed and added	
//	tab_1.tabpage_image.uo_image.st_recs.height = ST_H //st_recs
//	tab_1.tabpage_image.uo_image.st_page.height = ST_H //st_page
//	tab_1.tabpage_image.uo_image.cbx_show.height = ST_H//cbx_show
//	tab_1.tabpage_image.uo_image.st_zoom.height = ST_H//st_zoom
//	tab_1.tabpage_image.uo_image.st_format.height = ST_H//st_format
//	tab_1.tabpage_image.uo_image.cb_expand.height = 88 //maha 08.10.2012
//	tab_1.tabpage_image.uo_image.st_recs.y = tab_1.tabpage_image.uo_image.tab_view.y + 20 //alfee 04.22.2010
//	tab_1.tabpage_image.uo_image.st_page.y = tab_1.tabpage_image.uo_image.st_recs.y //st_page 12.06.2010
//	tab_1.tabpage_image.uo_image.cbx_show.y = tab_1.tabpage_image.uo_image.st_recs.y//cbx_show 12.06.2010
//	tab_1.tabpage_image.uo_image.st_zoom.y = tab_1.tabpage_image.uo_image.st_recs.y//st_zoom 12.06.2010
//	tab_1.tabpage_image.uo_image.st_format.y = tab_1.tabpage_image.uo_image.st_recs.y//st_format	 12.06.2010
//	tab_1.tabpage_image.uo_image.cb_expand.y =tab_1.tabpage_image.uo_image.ddlb_zoom.y + 4   //maha 08.10.2012

	tab_1.tabpage_image.uo_image.width = st_provider_border.x - 25
	tab_1.tabpage_image.uo_image.tab_view.width  = tab_1.tabpage_image.uo_image.width - 25 - tab_1.tabpage_image.uo_image.tab_view.x
	tab_1.tabpage_image.uo_image.of_post_resize( )
	//End Code Change ----02.03.2016	
	
end if



 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Privilege
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
if isvalid(tab_1.tabpage_privileges.uo_priv.tab_1) then 	
	tab_1.tabpage_privileges.uo_priv.st_recs.height = ST_H //st_recs
//	tab_1.tabpage_privileges.uo_priv.st_3.height = ST_H //st_3
	tab_1.tabpage_privileges.uo_priv.st_recs.y =tab_1.tabpage_privileges.uo_priv.tab_1.y + 20 //alfee 04.22.2010		
//	tab_1.tabpage_privileges.uo_priv.dw_select.y = tab_1.tabpage_privileges.uo_priv.tab_1.y + TABHdr_H //dw_select
	li_val = tab_1.tabpage_privileges.uo_priv.tab_1.height //- TABHdr_H 	

	if li_val < 0 then li_val = 0	
	//Start Code Change ----01.28.2016 #V15 maha
	//tab_1.tabpage_privileges.uo_priv.dw_select.height = li_val
	tab_1.tabpage_privileges.uo_priv.width = st_provider_border.x - 25
	tab_1.tabpage_privileges.uo_priv.tab_1.width = tab_1.tabpage_privileges.uo_priv.width - 25 - tab_1.tabpage_privileges.uo_priv.tab_1.x
	//tab_1.tabpage_privileges.uo_priv.height = st_provider_border.height + 10
	//End Code Change ----01.28.2016 
	tab_1.tabpage_privileges.uo_priv.of_post_resize( )    //Start Code Change ----08.09.2012 #V12 maha
end if

 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//Applications - alfee 10.08.2010
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 
//if isvalid(tab_1.tabpage_net.uo_net.cb_change) then 	
//	tab_1.tabpage_net.uo_net.cb_change.height = 84 //cb_1 	
//	tab_1.tabpage_net.uo_net.cbx_compl.height = ST_H //cbx_compl - alfee 10.21.2010
//	tab_1.tabpage_net.uo_net.cb_change.y =tab_1.tabpage_net.uo_net.tab_1.y + 10
//	tab_1.tabpage_net.uo_net.cbx_compl.y =tab_1.tabpage_net.uo_net.tab_1.y + 20	//alfee 10.21.2010
//	tab_1.tabpage_net.uo_net.st_filter.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
//	tab_1.tabpage_net.uo_net.dw_qf.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
//	tab_1.tabpage_net.uo_net.st_group_by.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
//	tab_1.tabpage_net.uo_net.st_zoom.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
//	tab_1.tabpage_net.uo_net.ddlb_group_by.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
//	tab_1.tabpage_net.uo_net.ddlb_zoom.y = tab_1.tabpage_net.uo_net.gb_filter_1.y + 50
////	tab_1.tabpage_net.uo_net.st_filter.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
////	tab_1.tabpage_net.uo_net.dw_qf.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
////	tab_1.tabpage_net.uo_net.st_group_by.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
////	tab_1.tabpage_net.uo_net.st_zoom.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
////	tab_1.tabpage_net.uo_net.ddlb_group_by.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
////	tab_1.tabpage_net.uo_net.ddlb_zoom.y = tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.gb_filter_1.y + 175
//	tab_1.tabpage_net.uo_net.tab_1.tabpage_report.cb_export.height = 84
//end if
//------------End Added -------------------------------------------

this.tab_1.tabpage_net.uo_net.dw_orgs_facilities.height = st_provider_border.height - 108
this.tab_1.tabpage_net.uo_net.width = tab_1.width - 25
this.tab_1.tabpage_net.uo_net.tab_1.width = this.tab_1.tabpage_net.uo_net.width - 25 - this.tab_1.tabpage_net.uo_net.tab_1.y
this.tab_1.tabpage_net.uo_net.of_post_resize()

////Start Code Change ----03.26.2012 #V12 maha - button placement
//cb_save.y = st_buttons.y + 20
//cb_add.y = st_buttons.y + 20
//cb_delete.y = st_buttons.y + 20
//cb_next.y = st_buttons.y + 20
//cb_prior.y = st_buttons.y + 20
//cb_notes.y = st_buttons.y + 20
//cb_print.y = st_buttons.y + 20
//cb_b3.y = st_buttons.y + 20
//cb_b4.y = st_buttons.y + 20
//cb_b5.y = st_buttons.y + 20
//cb_b6.y = st_buttons.y + 20
//cb_b7.y = st_buttons.y + 20
////End Code Change ----03.26.2012


//Start Code Change ----02.03.2016 #V15 maha - added
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//MEETINGS 
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
 if isvalid(tab_1.tabpage_meetings.uo_meetings) then
	tab_1.tabpage_meetings.uo_meetings.width = st_provider_border.x - 25
	tab_1.tabpage_meetings.uo_meetings.tab_view.width = tab_1.tabpage_meetings.uo_meetings.width - 25 - tab_1.tabpage_meetings.uo_meetings.tab_view.x
	tab_1.tabpage_meetings.uo_meetings.of_post_resize()
end if
//End Code Change ----02.03.2016 
 
 
 
 //Start Code Change ----02.04.2016 #V15 maha - added
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CONTRACTS
 ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  if isvalid(tab_1.tabpage_contract.uo_contracts) then
	tab_1.tabpage_contract.uo_contracts.width =  tab_1.width - 25
	tab_1.tabpage_contract.uo_contracts.of_post_resize()
end if
this.setredraw(true)   //(Appeon)Stephen 06.29.2017 - Bug ID #5715 for Case #00071338 Issue With IC 
end event

event key;call super::key;//Start Code Change ----10.23.2015 #V15 maha
//if tab_1.selectedtab = 1 then
//	messagebox("",string(key))
//	tab_1.tabpage_search.uo_search.sle_srch_val.postevent("modified")
//end if
end event

type dw_photo_settings from u_dw within w_prac_data_1
boolean visible = false
integer x = 1307
integer y = 2128
integer width = 297
integer height = 248
integer taborder = 60
string dataobject = "d_personal_data_settings"
boolean hscrollbar = true
end type

event constructor;call super::constructor; //Start Code Change ----05.10.2017 #V154 maha
this.of_setupdateable( false)
this.of_settransobject( sqlca)
this.retrieve()

//of_photo_data_settings( )
end event

type st_provider_border from statictext within w_prac_data_1
integer x = 4357
integer y = 400
integer width = 955
integer height = 1940
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33551856
long backcolor = 33551856
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event constructor;this.borderColor = rgb(184, 184, 184)  
this.backColor = rgb(240, 245, 255)           //rgb(240, 243, 244)  //Start Code Change ----11.07.2017 #V16 maha

end event

type cb_rehelp from commandbutton within w_prac_data_1
integer x = 4590
integer y = 28
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recred Help"
end type

event clicked;//The typical recredentialing process will create a new appointment record and new Verifications, sending the previous records to History.
//Process:
//The Appointment is approved, and the start and end dates are set.
//The Appointment End date reaches the defined pre-expiration number of days.  This prior-days value is set in the Facility Settings for each Facility.
//Once within the prescribed number of days, an Expiring Appointment Letter verification is created by the system.
//This may be a standard Expiring Appointment, an Expiring Provisional, or an Expiring Allied Health verification.  Which of these is defined by the following:
//Provisional: Based on the Provisional End date on the Appointment screen ONLY if the Provisional checkbox is checked.
//Allied Health: Based on the Practitioner Category on the Basic Information Screen.  Define a lookup item as Allied Health in the Lookup List by Entering AH in the desginated field.
//The credentialer sends the expiring notification to the provider, and when the reappointment information is received, runs the Initiate Reappointment function.
//This will create the create the verification records for PSV, and an new Appointment record.  Prior records are set to historical status.  In both cases, the new records are copied from the original ones.

open(w_recred_help)
end event

type cb_recred from commandbutton within w_prac_data_1
integer x = 4201
integer y = 28
integer width = 379
integer height = 92
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Initiate Recred"
end type

event clicked; //Start Code Change ----10.05.2015 #V15 maha - button added
gs_batch_search lstr_array

lstr_array.li_prac_id[1] = il_prac_id
lstr_array.ll_facility[1] = ii_parent_facility_id

openwithparm(w_recred_prac, lstr_array)
end event

type cb_5 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2738
integer y = 2260
integer width = 101
integer height = 92
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "/\"
end type

event clicked;tab_1.tabposition = tabsontop!
end event

type cb_4 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2889
integer y = 2272
integer width = 101
integer height = 92
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "->"
end type

event clicked;app_filler.toolbartext  = true
end event

type cb_3 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2633
integer y = 2260
integer width = 101
integer height = 92
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "\/"
end type

event clicked;tab_1.tabposition = tabsonbottom!


end event

type cb_2 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 3013
integer y = 2276
integer width = 101
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<-"
end type

event clicked;app_filler.toolbartext  =false
end event

type pb_home from picturebutton within w_prac_data_1
boolean visible = false
integer x = 4590
integer y = 188
integer width = 288
integer height = 92
integer taborder = 230
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Home"
boolean originalsize = true
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;open(w_home_screen)
end event

type dw_red_flag_count from u_dw within w_prac_data_1
integer x = 3982
integer y = 244
integer width = 206
integer height = 128
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_red_flag_count"
boolean vscrollbar = false
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if w_mdi.of_security_access(7170) =  0 then  //Start Code Change ----04.20.2016 #V15 maha
	//nothing
else
	Open(w_red_flag_view)
end if
end event

type cb_close from commandbutton within w_prac_data_1
integer x = 5001
integer y = 28
integer width = 283
integer height = 92
integer taborder = 50
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

type cb_notes from picturebutton within w_prac_data_1
integer x = 1074
integer y = 28
integer width = 338
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Notes"
long backcolor = 67108864
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded
parent.event pfc_cst_prac_notes( )
//changed to picture button 01.30.2013
end event

type cb_add from picturebutton within w_prac_data_1
integer x = 379
integer y = 28
integer width = 338
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
long backcolor = 67108864
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded

GraphicObject current_control
u_dw ldw_current

choose case tab_1.selectedtab
	case 2 //DE
		tab_1.tabpage_detail.uo_data_entry.dw_detail.event pfc_addrow( )
	case 4 //appointment
		m_pfe_cst_data_entry.m_edit.m_insert.triggerevent(clicked!)
	case 7 //print image //Start Code Change ----05.18.2012 #V12 maha
		tab_1.tabpage_image.uo_image.of_button_action( "ADD")
	case 8//privs
		tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.setfocus()
		tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail.triggerevent( "pfc_addrow")//modify Michael 03.26.2012 added 'dw_detail.'--BugE032308
	case 9 //apps
		m_pfe_cst_net_dev.m_edit.m_insert.triggerevent(clicked!)
	case 10 //meetings 
		//modify Michael 03.26.2012--BugE032310
		//tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_detail.triggerevent( "pfc_addrow")
		m_pfe_cst_prac_meetings.m_edit.m_insert.triggerevent(clicked!)
end choose
end event

type p_prac_photo from picture within w_prac_data_1
integer x = 4448
integer y = 420
integer width = 699
integer height = 812
boolean bringtotop = true
string picturename = "nophoto2-demo.jpg"
boolean focusrectangle = false
end type

event doubleclicked;//Start Code Change ----06.10.2010 #V10 maha - copied from of_load_photo and modified

String	ls_PicPath,ls_FullName,ls_PicName,ls_Postfix,ls_CurDirectory
string ls_userid
datetime ldt_today
long		ll_Rtn,ll_FileNo,ll_ReadCnts,ll_Cnts, ll_prac
long ll_row
Blob		lblb_ImageData,lblb_Buffer
datawindow dw_prac_list

//dw_prac_list = tab_1.tabpage_search.uo_search.dw_search


//if dw_prac_list.getrow() < 1 then
//	messagebox("Import Photo","Please select Practitioner first.")
//	return
//end if

//ll_prac = dw_prac_list.getitemnumber(dw_prac_list.getrow(),"prac_id")
ll_prac = il_prac_id

//Start Code Change ----11.15.2013 #V14 maha - Modifed for new added prac
if tab_1.selectedtab = 1 then
	if not IsValid(w_prac_data_sk) then //Bug 3375 - Alfee 01.08.2013 
		ll_row =  tab_1.tabpage_search.uo_search.dw_search.getrow()
		if ll_row > 0 then 
			ll_prac =  tab_1.tabpage_search.uo_search.dw_search.getitemnumber(ll_row, "prac_id")
		else
			ll_prac = 0
		end if
	end if	
else
	ll_prac = gl_prac_id
end if

////------Begin Addeded by alfee 11.05.2010 ------------------------
////<$Reason>BugA070708: the il_prac_id or gl_prac_id is not the current prac in some cases
//
////if not gb_sk_ver  then
//if not IsValid(w_prac_data_sk) then //Bug 3375 - Alfee 01.08.2013 
//	ll_row =  tab_1.tabpage_search.uo_search.dw_search.getrow()
//	if ll_row > 0 then 
//		ll_prac =  tab_1.tabpage_search.uo_search.dw_search.getitemnumber(ll_row, "prac_id")
//	else
//		ll_prac = 0
//	end if
//end if
////------End Added -------------------------------------------------
//End Code Change ----11.15.2013

if ll_prac < 1 then
	messagebox("Import Photo","Please select Practitioner first.")
	return
end if
debugbreak()
if this.PictureName <> "nophoto2-demo.jpg" then
	if MessageBox("Import Photo", "Re-importing the photo will replace the existing photo.  Do you want to continue?", Question!, YesNo!) = 2 then
		Return
	end if
end if
//------------------- APPEON END ---------------------

ls_CurDirectory = GetCurrentDirectory()


//Start Code Change ----08.05.2011 #V11 maha  - modified to default to the three types of files. 
//Commented lines below as the the png is supported in APB 7.0 now - alfee 03.31.2017
//IF appeongetclienttype() = "WEB" then
//	ll_Rtn = GetFileOpenName("Open",ls_FullName,ls_PicName,"bmp","Bitmap Files (*.bmp),*.bmp,JPG Files (*.jpg),*.jpg,GIF Files (*.GIF),*.gif")
//else//Start Code Change ----08.15.2012 #V12 maha - added ability to get png file (C/S only)
	ll_Rtn = GetFileOpenName("Open",ls_FullName,ls_PicName,"bmp","Graphic Files (*.bmp;*.gif;*.jpg;*.png),*.bmp;*.gif;*.jpg;*.png,Bitmap Files (*.bmp),*.bmp,JPG Files (*.jpg),*.jpg,GIF Files (*.GIF),*.gif, PNG Files (*.PNG),*.png")
//End if

if ll_Rtn <> 1 then Return

ChangeDirectory(ls_CurDirectory)

ls_Postfix = Mid(ls_PicName,LastPos(ls_PicName,".") + 1)

ll_FileNo = FileOpen(ls_FullName,StreamMode!,Read!,LockReadWrite!)
if ll_FileNo <= 0 then Return

ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
do while ll_ReadCnts > 0
	lblb_ImageData += lblb_Buffer
	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
loop

FileClose(ll_FileNo)

if Len(lblb_ImageData) <= 0 then Return

SELECT COUNT(*) INTO :ll_Cnts FROM pd_photo WHERE pd_photo.prac_id = :ll_prac ;
if ll_Cnts <= 0 then
	//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
	//INSERT INTO pd_photo (prac_id) VALUES (:ll_prac) ;
	ldt_today = datetime(today(),now())
	ls_userid = gs_user_id	
	INSERT INTO pd_photo(prac_id, create_date, create_user) VALUES(:ll_prac, :ldt_today, :ls_userid) ;
	//--------End Modified------------------------------
	
	commit using sqlca;
end if

SELECT COUNT(*) INTO :ll_Cnts FROM pd_photo WHERE pd_photo.prac_id = :ll_prac ;

//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
//UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :ll_prac ;
if isnull(ls_userid) or ls_userid = '' then
	ldt_today = datetime(today(),now())
	ls_userid = gs_user_id
	UPDATE pd_photo SET image_type = :ls_Postfix, mod_date = :ldt_today, mod_user = :ls_userid WHERE pd_photo.prac_id = :ll_prac ;
else
	UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :ll_prac ;	
end if
//--------End Modified------------------

UPDATEBLOB pd_photo SET image_data = :lblb_ImageData WHERE pd_photo.prac_id = :ll_prac ;
debugbreak()
ls_picname = ls_fullname  // of_photo_download(ll_prac)
	
if 	ls_picname = "None" then
	this.PictureName = "nophoto.bmp"
else
	if FileExists(ls_PicName) then
		this.PictureName = ls_picname
	end if
end if
end event

event rbuttondown;//Start Code Change ----05.17.2011 #V11 maha - copied from previous functionality added delete file
string ls_image_type
blob lblb_image_data
String	ls_PicName,ls_Postfix, ls_PicPath
datetime ldt_today

if MessageBox("Delete Photo", "Are you sure you want to delete the photo?", Question!, YesNo!) = 2 then
	Return
end if

SetNull(ls_image_type)
lblb_image_data = Blob(' ')
debugbreak()

SELECT image_type INTO :ls_Postfix from pd_photo WHERE pd_photo.prac_id = :il_prac_id ;
ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
ls_PicName = ls_PicPath + String( il_prac_id ) + "." + ls_Postfix

//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
//UPDATE pd_photo SET image_type = :ls_image_type WHERE pd_photo.prac_id = :il_prac_id;
ldt_today = datetime(today(),now())
UPDATE pd_photo SET image_type = :ls_image_type, mod_date = :ldt_today, mod_user = :gs_user_id WHERE pd_photo.prac_id = :il_prac_id;
//--------End Modified------------------------------

if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the photo.", StopSign!)
	Return
end if
UPDATEBLOB pd_photo SET image_data = :lblb_image_data WHERE pd_photo.prac_id = :il_prac_id;
if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the photo.", StopSign!)
	Return
end if

//Start Code Change ----03.20.2013 #V12 maha - changed from function as the profile would disappear when the photo was removed.
//of_photo_Hide()
p_prac_photo.picturename = 'nophoto2-demo.jpg'
//End Code Change ----03.20.2013

//messagebox("", ls_PicName)
filedelete(ls_PicName)
end event

type cb_1 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 4562
integer y = 1960
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "test"
end type

event clicked;messagebox("",string(ib_priv_retrieved) + "- -" + string(il_prac_id))
end event

type cb_save from commandbutton within w_prac_data_1
boolean visible = false
integer x = 32
integer y = 28
integer width = 338
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded
if tab_1.selectedtab = 7 then
	tab_1.tabpage_image.uo_image.of_button_action( "SAVE")
elseif tab_1.selectedtab = 2 then  //Start Code Change ----02.27.2014 #V14 maha - for auto save message
	tab_1.tabpage_detail.uo_data_entry.ib_test_save = false
	parent.triggerevent( "pfc_save")
else
	parent.triggerevent( "pfc_save")
end if

end event

type cb_addcb from commandbutton within w_prac_data_1
boolean visible = false
integer x = 4434
integer y = 156
integer width = 87
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded

GraphicObject current_control
u_dw ldw_current

choose case tab_1.selectedtab
	case 2 //DE
		tab_1.tabpage_detail.uo_data_entry.dw_detail.event pfc_addrow( )
	case 4 //appointment
		m_pfe_cst_data_entry.m_edit.m_insert.triggerevent(clicked!)
	case 7 //print image //Start Code Change ----05.18.2012 #V12 maha
		tab_1.tabpage_image.uo_image.of_button_action( "ADD")
	case 8//privs
		tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.setfocus()
		tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail.triggerevent( "pfc_addrow")//modify Michael 03.26.2012 added 'dw_detail.'--BugE032308
	case 9 //apps
		m_pfe_cst_net_dev.m_edit.m_insert.triggerevent(clicked!)
	case 10 //meetings 
		//modify Michael 03.26.2012--BugE032310
		//tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_detail.triggerevent( "pfc_addrow")
		m_pfe_cst_prac_meetings.m_edit.m_insert.triggerevent(clicked!)
end choose
end event

type cb_print from commandbutton within w_prac_data_1
boolean visible = false
integer x = 1422
integer y = 28
integer width = 338
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded

choose case tab_1.selectedtab
	case 5
		tab_1.tabpage_verif.uo_verif_summary.of_reverify_verif_data( )
		//tab_1.tabpage_verif.uo_verif_summary.of_find_missing_verif( )
	case 7
		tab_1.tabpage_image.uo_image.of_button_action( "PRINT")
	case else
		parent.event pfc_cst_print_report()
end choose
end event

type cb_next from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2117
integer y = 28
integer width = 338
integer height = 92
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Next->"
end type

event clicked;//Start Code Change ----12.19.2011 #V12 maha - coded

choose case tab_1.selectedtab
	case 2 //next
		parent.event pfc_cst_nextpage( )
	case 5 //verifs
		tab_1.tabpage_verif.uo_verif_summary.of_copy_verifications( )
	case 7 //images next
		tab_1.tabpage_image.uo_image.of_button_action( "NEXT")
	case 9 //Apps
		//email apps functionality
		tab_1.tabpage_net.uo_net.of_email_payor(tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev, 'Prac') //(Appeon)Stephen 2013-08-20 - V141 Email/Fax Applications to Payors
end choose
end event

type cb_prior from commandbutton within w_prac_data_1
boolean visible = false
integer x = 1769
integer y = 28
integer width = 338
integer height = 92
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<-Prior"
end type

event clicked;//Start Code Change ----12.19.2011 #V12 maha - coded

choose case tab_1.selectedtab
	case 2 //next
		parent.event pfc_cst_priorpage( )
	case 5 //verifs
		tab_1.tabpage_verif.uo_verif_summary.of_find_missing_verif( )
	case 7 //images next
		tab_1.tabpage_image.uo_image.of_button_action( "PRIOR")
end choose
end event

type cb_b3 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2464
integer y = 28
integer width = 338
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "B3"
end type

event clicked;//Start Code Change ----12.19.2011 #V12 maha - coded


choose case tab_1.selectedtab
	case 2 //de compl
		parent.event pfc_cst_de_complete( )
	case 3 //letter
		tab_1.tabpage_app_audit.uo_app_audit.event pfc_cst_compose_request( )
	case 4 //de comp
		parent.event pfc_cst_de_complete( )
	case 5 //verif
		tab_1.tabpage_verif.uo_verif_summary.of_clear_print( )
	case 6 //run report
		ib_run_profile = true  //evan 06.06.2012
		tab_1.tabpage_profile.uo_profile.of_run_report( )
		ib_run_profile = false //evan 06.06.2012
	case 7 //print image
		//parent.event pfc_cst_batch_print( )
		tab_1.tabpage_image.uo_image.of_button_action( "B3")
	case 8 //update
		parent.event pfc_cst_priv_batch( )
	case 9 //filter
		parent.event pfc_cst_net_dev_filter( )
end choose
end event

type cb_b4 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 2811
integer y = 28
integer width = 338
integer height = 92
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "B4"
end type

event clicked;//Start Code Change ----12.16.2011 #V12 maha - coded


choose case tab_1.selectedtab
	case 2 //verif cred
		tab_1.tabpage_detail.uo_data_entry.of_add_ver_entry() //Start Code Change ----01.31.2012 #V12 maha
	case 3 //copy
		tab_1.tabpage_app_audit.uo_app_audit.event pfc_cst_copy_row( )
	case 4 //psv
		parent.event pfc_cst_cvo_data( )
	case 5 //letters
		tab_1.tabpage_verif.uo_verif_summary.event pfc_cst_print_letters( )
	case 7 //email
		//tab_1.tabpage_image.uo_image.of_email_documents( )
		tab_1.tabpage_image.uo_image.of_button_action( "B4")
	case 8 //reports priv
		tab_1.tabpage_privileges.uo_priv.of_print( )
	case 9 //reapp
		tab_1.tabpage_net.uo_net.of_reappoint( )
end choose
end event

type cb_b5 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 3159
integer y = 28
integer width = 338
integer height = 92
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "B5"
end type

event clicked;//Start Code Change ----12.16.2011 #V12 maha - coded


choose case tab_1.selectedtab
	case 2 //data entry
		if gs_cust_type = "I" then  //Start Code Change ----05.08.2012 #V12 maha - exception for smart
			openwithparm(w_batch_add_apps_facilities, string(gl_prac_id) + "*F" )
		else
			of_facility_specific_data( )
		end if
	case 3 //missing
		tab_1.tabpage_app_audit.uo_app_audit.of_add_missing_item( )
	case 4 //appointment multi app
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_multi_app_new( )  //Start Code Change ----05.07.2014 #V14.2 maha
	case 5 //web
		tab_1.tabpage_verif.uo_verif_summary.event pfc_cst_goto_web( )
	case 6 //profile  //Start Code Change ----12.19.2012 #V12 maha
		tab_1.tabpage_profile.uo_profile.of_save_as_pdf( )
	case 7 //fax
		//	tab_1.tabpage_image.uo_image.of_fax_documents( )
		tab_1.tabpage_image.uo_image.of_button_action( "B5")
	case 8 //priv_form
		//messagebox("Privilege Form","Function in Development.")
		tab_1.tabpage_privileges.uo_priv.of_get_form( )
	case 9 //print apps
		tab_1.tabpage_net.uo_net.of_print_apps( )
end choose
end event

type cb_b6 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 3506
integer y = 28
integer width = 338
integer height = 92
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "B6"
end type

event clicked;//Start Code Change ----12.16.2011 #V12 maha - coded


choose case tab_1.selectedtab
	Case 2 //DE
		tab_1.tabpage_detail.uo_data_entry.of_add_cert_period( tab_1.tabpage_detail.uo_data_entry.ii_screen_id , 0,  tab_1.tabpage_detail.uo_data_entry.dw_detail.getrow() , True)
	case 4 //appointment app note
		tab_1.tabpage_apptmnt_status.uo_affill_status.of_appoint_note( )
	case 5 //verifs
		tab_1.tabpage_verif.uo_verif_summary.event pfc_cst_npdb_export( )
	case 6 //profile  //Start Code Change ----12.19.2012 #V12 maha
		tab_1.tabpage_profile.uo_profile.of_email_report( )
	case 7 //docs
		//tab_1.tabpage_image.uo_image.of_page_properties( )
		tab_1.tabpage_image.uo_image.of_button_action( "B6")
	case 9 //pop website
		tab_1.tabpage_net.uo_net.event pfc_cst_pop_website()
end choose
end event

type cb_b7 from commandbutton within w_prac_data_1
boolean visible = false
integer x = 3854
integer y = 28
integer width = 338
integer height = 92
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "B7"
end type

event clicked;//Start Code Change ----12.16.2011 #V12 maha - coded

choose case tab_1.selectedtab
	case 5 //verifs
		tab_1.tabpage_verif.uo_verif_summary.event pfc_cst_scan_oig( )
	case 7 //documents
		tab_1.tabpage_image.uo_image.of_button_action( "B7")
	case 9 //apps
		tab_1.tabpage_net.uo_net.of_open_tracking( )

end choose
end event

type cb_delete from picturebutton within w_prac_data_1
integer x = 727
integer y = 28
integer width = 338
integer height = 92
integer taborder = 450
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
long backcolor = 67108864
end type

event clicked;//Start Code Change ----12.13.2011 #V12 maha - coded
//Start Code Change ----02.17.2011 #V12 maha - rewritten
choose case tab_1.selectedtab
	case 1 //search
	case 2 //DE
		tab_1.tabpage_detail.uo_data_entry.dw_detail.event pfc_deleterow( )
	case 3 //clist
		tab_1.tabpage_app_audit.uo_app_audit.dw_detail.triggerevent( "pfc_deleterow")  //Start Code Change ----03.26.2012 #V12 maha - corrected bug

	case 4 //appointment
		m_pfe_cst_data_entry.m_edit.m_delete1.triggerevent(clicked!)
	case 5 //verifs
		tab_1.tabpage_verif.uo_verif_summary.of_Delete_Verification()
	case 6 //profiles

	case 7 //documents
		//tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.triggerevent("pfc_deleterow")//modify Michael 03.26.2012 added "dw_browse."--BugE032304
		tab_1.tabpage_image.uo_image.of_button_action( "DELETE")
	case 8//privs
		tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail.triggerevent("pfc_deleterow")
	case 9 //apps
		//Start Code Change ----07.12.2016 #V152 maha - changed to function call
		//m_pfe_cst_net_dev.m_edit.m_delete1.triggerevent(clicked!)
		tab_1.tabpage_net.uo_net.of_delete( )
		//End Code Change ----07.12.2016
	case 10 //meetings
		//modify Michael 03.26.2012--BugE032310
		//tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_browse.triggerevent("pfc_deleterow"
		m_pfe_cst_prac_meetings.m_edit.m_delete1.triggerevent(clicked!)
		

end choose
end event

type uo_app_stat from pfc_cst_u_app_status within w_prac_data_1
event destroy ( )
integer x = 4379
integer y = 244
integer width = 901
integer height = 132
integer taborder = 20
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_app_stat.destroy
call pfc_cst_u_app_status::destroy
end on

type dw_standing from u_dw within w_prac_data_1
integer x = 4183
integer y = 244
integer width = 206
integer height = 128
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_standing_flag_only"
boolean vscrollbar = false
end type

event constructor;this.settransobject(sqlca)
end event

type tab_1 from tab within w_prac_data_1
event pfc_cst_after_select ( )
event pfc_cst_post_open ( )
event create ( )
event destroy ( )
event type integer ue_selectionchanging ( integer oldindex,  integer newindex )
event type long selectionchanged_old ( integer oldindex,  integer newindex )
event ue_setselectedflag ( integer ai_newindex )
event ue_setsecurity ( integer ai_newindex )
integer y = 144
integer width = 5321
integer height = 2208
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 80269524
boolean raggedright = true
boolean powertips = true
boolean showpicture = false
boolean boldselectedtext = true
boolean createondemand = true
alignment alignment = center!
integer selectedtab = 1
tabpage_search tabpage_search
tabpage_detail tabpage_detail
tabpage_app_audit tabpage_app_audit
tabpage_apptmnt_status tabpage_apptmnt_status
tabpage_verif tabpage_verif
tabpage_profile tabpage_profile
tabpage_image tabpage_image
tabpage_privileges tabpage_privileges
tabpage_net tabpage_net
tabpage_meetings tabpage_meetings
tabpage_contract tabpage_contract
tabpage_wf tabpage_wf
end type

event pfc_cst_after_select();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/13/2008 By: Ken.Guo
//$<reason> Fix Issue from Mike.
//$When the program moves to that tab the focus is not on 
//$that tab but still on the Data entry tab
//messagebox("il_prac_id", il_prac_id)
Long li_index1
Long li_index2
li_index1 = This.SelectedTab
Choose Case li_index1
	case 1 //Start Code Change ----04.22.2010 #V10 maha
		of_setfocus()
	Case 2 //Start Code Change ----03.28.2012 #V12 maha
		tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable( )
		tab_1.tabpage_detail.uo_data_entry.of_refresh_page_menu( ) 
	Case	3	//Application Audit
		tab_1.tabpage_app_audit.uo_app_audit.dw_detail.Post SetFocus()	
//------------------------RP added 1.13.2016-----------------------------------
tab_1.tabpage_app_audit.uo_app_audit.event post ue_setResize()
	Case	4	//Appointment Status
		//if AppeonGetClientType() = "WEB" then w_mdi.of_prac_folder_security(Parent) //Added by Appeon long.zhang 06.23.2016 (Bug id 5211 - Cannot make Provider Documents tab Read Only)     //Comment by Appeon long.zhang 07.01.2016
		
		li_index2 = tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.dw_browse.Post SetFocus()
			Case	2
				tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Post SetFocus()
			Case	3
				tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.dw_staff_cat.Post SetFocus()
			Case	4
				tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.dw_quest.Post SetFocus()
		End Choose
	Case	5 //Verification
		li_index2 = tab_1.tabpage_verif.uo_verif_summary.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_verif.uo_verif_summary.dw_browse.Post SetFocus()
			Case	2
				tab_1.tabpage_verif.uo_verif_summary.dw_detail.Post SetFocus()
			Case	3
				tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.dw_recred_info.Post SetFocus()
		End Choose
	Case	6	//Profile
		li_index2 = tab_1.tabpage_profile.uo_profile.tab_report.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile.dw_profile.Post SetFocus()
			Case	2
				tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification.dw_verification.Post SetFocus()
		End Choose
	Case	7 //Imaging
		//if AppeonGetClientType() = "WEB" then w_mdi.of_prac_folder_security(Parent) //Added by Appeon long.zhang 06.23.2016 (Bug id 5211 - Cannot make Provider Documents tab Read Only) //Comment by Appeon long.zhang 07.01.2016
				
		li_index2 = tab_1.tabpage_image.uo_image.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.Post SetFocus()
			Case	2
				tab_1.tabpage_image.uo_image.tab_view.tabpage_image.ole_scan_edit.Post SetFocus()
			Case	3
				tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.dw_data.Post SetFocus()
		End Choose
	Case	8 //Pri
		li_index2 = tab_1.tabpage_privileges.uo_priv.tab_1.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_browse.dw_browse.Post SetFocus()
			Case	2
				tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail.Post SetFocus()
			Case	3
				tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv.dw_expired.Post SetFocus()
		End Choose
	Case	9 //Net
		li_index2 = tab_1.tabpage_net.uo_net.tab_1.SelectedTab
 //Start Code Change ----08.25.2015 #V15 maha - change the set focus
		tab_1.tabpage_net.uo_net.dw_orgs_facilities.setfocus()
//		Choose Case li_index2  
//			Case	1
//				tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev.Post SetFocus()
//			Case	2
//				tab_1.tabpage_net.uo_net.tab_1.tabpage_ids.dw_ids.Post SetFocus()
//			Case	3
//				tab_1.tabpage_net.uo_net.tab_1.tabpage_notes.dw_notes.Post SetFocus()
//			Case	4
//				tab_1.tabpage_net.uo_net.tab_1.tabpage_report.dw_report_data.Post SetFocus()
//		End Choose
//End Code Change ----08.25.2015
	Case	10 //Meeting
		li_index2 = tab_1.tabpage_meetings.uo_meetings.tab_view.SelectedTab
		Choose Case li_index2
			Case	1
				tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_browse.Post SetFocus()
			Case	2
				tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_detail.dw_detail.Post SetFocus()
		End Choose
End Choose
//---------------------------- APPEON END ----------------------------

//of_button_settings()  //Start Code Change ----03.28.2012 #V12 maha
if li_index1 = 2 then tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable( )  //Start Code Change ----04.27.2012 #V12 maha
//------------------- APPEON BEGIN -------------------
//$<delete> Evan 06.18.2009
//$<reason> Menu readonly security.
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-23 By: Scofield
//$<Reason> Set the ToolbarItemVisible property to true or false

if IsValid(m_pfe_cst_data_entry) then
	if li_index1 = 2 then
		m_pfe_cst_data_entry.m_file.m_importphoto.Visible = true
		m_pfe_cst_data_entry.m_file.m_importphoto.ToolbarItemVisible = true
	else
		m_pfe_cst_data_entry.m_file.m_importphoto.Visible = false
		m_pfe_cst_data_entry.m_file.m_importphoto.ToolbarItemVisible  = false
	end if
end if
//---------------------------- APPEON END ----------------------------
*/
//------------------- APPEON END ---------------------
end event

on tab_1.create
this.tabpage_search=create tabpage_search
this.tabpage_detail=create tabpage_detail
this.tabpage_app_audit=create tabpage_app_audit
this.tabpage_apptmnt_status=create tabpage_apptmnt_status
this.tabpage_verif=create tabpage_verif
this.tabpage_profile=create tabpage_profile
this.tabpage_image=create tabpage_image
this.tabpage_privileges=create tabpage_privileges
this.tabpage_net=create tabpage_net
this.tabpage_meetings=create tabpage_meetings
this.tabpage_contract=create tabpage_contract
this.tabpage_wf=create tabpage_wf
this.Control[]={this.tabpage_search,&
this.tabpage_detail,&
this.tabpage_app_audit,&
this.tabpage_apptmnt_status,&
this.tabpage_verif,&
this.tabpage_profile,&
this.tabpage_image,&
this.tabpage_privileges,&
this.tabpage_net,&
this.tabpage_meetings,&
this.tabpage_contract,&
this.tabpage_wf}
end on

on tab_1.destroy
destroy(this.tabpage_search)
destroy(this.tabpage_detail)
destroy(this.tabpage_app_audit)
destroy(this.tabpage_apptmnt_status)
destroy(this.tabpage_verif)
destroy(this.tabpage_profile)
destroy(this.tabpage_image)
destroy(this.tabpage_privileges)
destroy(this.tabpage_net)
destroy(this.tabpage_meetings)
destroy(this.tabpage_contract)
destroy(this.tabpage_wf)
end on

event type integer ue_selectionchanging(integer oldindex, integer newindex);Integer li_retval 

IF ib_new_prac AND oldindex = 4 THEN
	tab_1.tabpage_detail.uo_data_entry.of_set_verifying_facility( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_verifying_facility_id() )
	tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )
	tab_1.tabpage_verif.uo_verif_summary.of_set_facility_id(tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id())	
	tab_1.tabpage_profile.uo_profile.of_Set_facility_Id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_verifying_facility_id() )
	tab_1.tabpage_app_audit.uo_app_audit.of_set_parent_facility_id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )	
	of_get_parent_facility( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )	
END IF


IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_new_record() THEN
	tab_1.tabpage_app_audit.uo_app_audit.of_Set_parent_facility_Id( ii_parent_facility_id )
	tab_1.tabpage_app_audit.uo_app_audit.of_Retrieve( il_prac_id )
	tab_1.tabpage_verif.uo_verif_summary.of_Retrieve( il_prac_id )
	tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_new_record( False )
END IF


IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_changed_app_audit() = True THEN
	of_retrieve_app_audit()
END IF

IF newindex = 3 AND NOT ib_app_audit_retrieved THEN //app audit
	of_retrieve_app_audit()
ELSEIF newindex = 4 AND NOT ib_affil_stat_retrieved THEN //appointment status
	of_retrieve_affil_stat()
	ib_page4_refresh = false	//add by 04.11.2006
ELSEIF newindex = 5 AND NOT ib_verif_info_retrieved THEN	//verifications
	of_retrieve_verif_info()
	ib_page5_refresh = false	//add by 04.11.2006
ELSEIF newindex = 6 then      //Start Code Change ----12.15.2014 #V14.2 maha - added for midcycle                                 previous code:  AND NOT ib_site_survey_retrieved THEN	
	tab_1.tabpage_profile.uo_profile.il_appt_rec = il_affil_rec_id
ELSEIF newindex = 10 AND NOT ib_meetings_retrieved THEN		//meetings
	 of_retrieve_meetings()
ELSEIF newindex = 7 AND NOT ib_image_info_retrieved THEN		//images
	of_retrieve_images()	
//maha082200
ELSEIF newindex = 8 and not ib_priv_retrieved then //privileges
	of_retrieve_privs()	
ELSEIF newindex = 9 AND NOT ib_net_retrieved THEN //Application status
	of_retrieve_net()
ELSEIF newindex = 11 and not ib_contract_retrieved then//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
	of_retrieve_contract()
END IF

//Start Code Change ----06.13.2011 #V11 maha - movrd to select prac function on profiles
//IF oldindex = 6 THEN
//	tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification.dw_verification.DataObject = "d_profile_message"
//	tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile.dw_profile.DataObject =  "d_profile_message"
//END IF
//Start Code Change ----06.13.2011

IF oldindex = 9 AND IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF

//This.SetRedraw( True )

//This.PostEvent( "pfc_cst_after_select" )

ib_win_just_opened  = False

return 0
end event

event type long selectionchanged_old(integer oldindex, integer newindex);integer set_ck //maha 111802
integer li_index //alfee 10.13.2008

//if oldindex = -1 or newindex = -1 then return
//setredraw(false)

IF gs_cust_type <> "I" THEN
	IF newindex = 1 OR newindex = 7 THEN
		uo_app_stat.Visible = False
	ELSE
		uo_app_stat.Visible = True
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<modify> 02.17.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> The following script is moved from the SelectoinChanging event.
//$<modification> This changes is due to the usage of CreateOnDemand property.
if this.tabpage_search.uo_search.dw_search.rowcount() > 0 then
	if oldindex = 1 AND  (gl_prac_id <> -9 AND NOT ib_new_prac AND /*Added by Appeon*/ gl_prac_id <> this.tabpage_search.uo_search.dw_search.object.PRAC_ID[this.tabpage_search.uo_search.dw_search.GETROW()] ) THEN 
		ib_tab_seleted = true
		this.tabpage_search.uo_search.of_select_prac( this.tabpage_search.uo_search.dw_search.getrow() )		
	END IF 
End if 
//---------------------------- APPEON END ----------------------------

IF oldindex = 1 and newindex > 1  AND gl_prac_id = 0 THEN
	SelectTab( 1 )
	MessageBox("Invalid Selection", "You must first select a practitioner.")
	//setredraw(true)
	Return 1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-20
//$<add> 01.18.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Set values to the variables defined by Appeon. This change
//$<modification> is due to usage of CreateOnDemand.
window lw
lw = parent

Choose Case newindex
	Case 2
		If not ib_page2_selected Then
			//of_registerresize(newindex)
			ib_page2_selected = true
		End if
	Case 3
		If not ib_page3_selected Then
			//of_registerresize(newindex)
			ib_page3_selected = true
		End if
	Case 4
		If not ib_page4_selected Then
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Reset()
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_Parent_Window( lw )
			
			if not ib_tab_seleted then 
			  tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectTab(2)
			end if 
			//appointment stat
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_parent_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_prac_id( il_prac_id )
			
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
			//of_registerresize(newindex)
			ib_page4_selected = true
		End if
				
		// added by 04.11.2006
		If ib_page4_refresh Then
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()	
			ib_page4_refresh = False
		End if
	Case 5
		If not ib_page5_selected Then
			tab_1.tabpage_detail.uo_data_entry.of_set_verification_info( tab_1.tabpage_verif.uo_verif_summary )
			//verif_info
			tab_1.tabpage_verif.uo_verif_summary.of_Reset( )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_Prac_Id( il_prac_id )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_View_Id( il_data_view )

			//of_registerresize(newindex)
			ib_page5_selected = true
		End If

		// added by 04.11.2006
		If ib_page5_refresh Then
			tab_1.tabpage_verif.uo_verif_summary.of_get_this_facility_data( )
			ib_page5_refresh = False
		End if
	Case 6
		If not ib_page6_selected Then
			//setup profile tab
			tab_1.tabpage_profile.uo_profile.of_set_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_profile.uo_profile.of_set_prac_id( il_prac_id )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2008-08-19 By: Alan
			//$<reason> setup parameter
			tab_1.tabpage_profile.uo_profile.of_set_view_id( il_data_view )
			//---------------------------- APPEON END ----------------------------
			//of_registerresize(newindex)
			ib_page6_selected = true
		End if
	Case 7
		
		//Added by Ken.Guo on 2008-11-07
		If Not ib_imageocx_showed Then
			gnv_reg_ocx.of_check_ocx(3,'',True)
			ib_imageocx_showed = True
		End If
		
		If not ib_page7_selected Then
			tab_1.tabpage_image.uo_image.of_set_parent( lw )
			//of_registerresize(newindex)
			ib_page7_selected = true
			w_mdi.of_prac_folder_security(Parent) //Added by Ken.Guo 2008-02-25
			of_ImagingWarning()			//Added by Scofield on 2007-09-21
		End if
	Case 8
		If not ib_page8_selected Then
			//of_registerresize(newindex)
			ib_page8_selected = true
		End if
	Case 9
		If not ib_page9_selected Then
			//of_registerresize(newindex)
			ib_page9_selected = true
		End if
	Case 10
		If not ib_page10_selected Then
			//of_registerresize(newindex)
			ib_page10_selected = true
		End if
End Choose

//
This.event ue_selectionchanging(oldindex, newindex)
//

//---------------------------- APPEON END ----------------------------


//setredraw(true)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-21
//$<add> 01.26.2006 By: Cao YongWang
//$<reason> Performacne tuning
//$<modification> Add the following script to make sure that w_mdi will not be
//$<modification> be redrawed until the following operations are done. Refer to
//$<modification> PT-22 for more information.

//---------------------------- APPEON END ----------------------------

IF newindex = 2 THEN
	IF tab_1.tabpage_detail.uo_data_entry.of_get_selected_view_tab() = 1 THEN
		tab_1.tabpage_detail.uo_data_entry.of_setfocus_browse() 
		tab_1.tabpage_detail.uo_data_entry.of_btt_browse()
	ELSE
		tab_1.tabpage_detail.uo_data_entry.of_setfocus_detail() 
		tab_1.tabpage_detail.uo_data_entry.of_btt_detail()
		tab_1.tabpage_detail.uo_data_entry.of_btt_address_link_button()
	END IF
END IF

IF newindex = 3 THEN
	tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_app_audit_complete()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_app_audit)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_app_audit' Then w_mdi.ChangeMenu( m_pfe_cst_app_audit )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_app_audit" )		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.15.2006 By: LeiWei
	//$<reason> Fix a defect.
	tab_1.tabpage_app_audit.uo_app_audit.dw_detail.post setfocus()
	//---------------------------- APPEON END ----------------------------
ELSEIF newindex = 10 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_prac_meetings)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_prac_meetings' Then w_mdi.ChangeMenu( m_pfe_cst_prac_meetings )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_prac_meetings" )				
ELSEIF newindex = 9 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_net_dev)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_net_dev' Then w_mdi.ChangeMenu( m_pfe_cst_net_dev )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_net_dev" )
	
		
//\/maha82200  privileges
elseIF newindex = 8 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_privileges)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_privileges' Then w_mdi.ChangeMenu( m_pfe_cst_privileges )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_privileges" )		
ELSEIF newindex = 1 THEN	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_mdi_menu" )		
ELSEIF newindex = 6 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_profile)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_profile' Then w_mdi.ChangeMenu( m_pfe_cst_profile )
	//---------------------------- APPEON END ----------------------------
	w_mdi.of_menu_security( "m_pfe_cst_profile" )		
ELSEIF newindex = 5 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_verif_info)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_verif_info' Then w_mdi.ChangeMenu( m_pfe_cst_verif_info )
	//---------------------------- APPEON END ----------------------------
	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
	w_mdi.SetToolbarPos ( 3, 1, 300, False)	
	//If the inv_action_items not is valid the create it
	If not isvalid(inv_action_items) Then inv_action_items = create pfc_n_cst_ai_action_items
	//
	inv_action_items.of_enable_action_menu( tab_1.tabpage_verif.uo_verif_summary.of_get_dw() , "1",2 )
	w_mdi.of_menu_security( "m_pfe_cst_verif_info" )
	
	//MAHA note - this code should not be moved to the of_prac_window_security function of w_mdi becaues it will not be effective (object not instanciated?)
	//set priority
	IF w_mdi.of_security_access( 182 ) = 0 THEN
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.protect = '1'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.background.color= '12632256'")
	END IF
	//priority user
	IF w_mdi.of_security_access( 185 ) = 0 THEN
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.protect = '1'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.background.color= '12632256'")
	END IF	
	//post results
	IF w_mdi.of_security_access( 160 ) = 0 THEN
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.protect = '1'")
		//tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.background.color= '12632256'") //Delete by Evan 01/21/2009---Use dw property express instead
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.protect = '1'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.background.color= '12632256'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '12632256'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '12632256'")
	END IF		
ELSEIF newindex = 7 THEN
	//-----------Begin Modified by Alfee on 10.13.2008------------------------
	li_index = tab_1.tabpage_image.uo_image.tab_view.Selectedtab
	tab_1.tabpage_image.uo_image.of_set_menu(li_index)
	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
	w_mdi.SetToolbarPos ( 3, 1, 300, False)
	/* Note: some functions have been moved into of_set_menu(...) 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	//	w_mdi.ChangeMenu(m_pfe_cst_imaging)
	If w_mdi.menuname <> 'm_pfe_cst_imaging' Then w_mdi.ChangeMenu( m_pfe_cst_imaging )
	//---------------------------- APPEON END ----------------------------
	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
	w_mdi.SetToolbarPos ( 3, 1, 300, False)	
	tab_1.tabpage_image.uo_image.of_enable_next_prev_buttons( "Browse" )
	tab_1.tabpage_image.uo_image.of_set_menu( 1 )	
	w_mdi.of_menu_security( "m_pfe_cst_imaging" )	
	*/ 
	//---------End Modified --------------------------------------------------
ELSEIF newindex = 2 or newindex = 4 THEN
	//IF Not IsValid( m_pfe_cst_data_entry ) THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu(m_pfe_cst_data_entry)
		*/
		If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then w_mdi.ChangeMenu( m_pfe_cst_data_entry )
		//---------------------------- APPEON END ----------------------------
		tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
		w_mdi.of_menu_security( "m_pfe_cst_data_entry" )
		if newindex = 4 then
			m_pfe_cst_data_entry.m_view.m_aptnote.visible = true
		else
			m_pfe_cst_data_entry.m_view.m_aptnote.visible = False
		end if
		tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable()
	//END IF
END IF

w_mdi.SetToolbarPos ( 2, 1, 200, False)	

IF newindex = 3 THEN
	IF IsValid(m_pfe_cst_data_entry) THEN
//		m_pfe_cst_data_entry.m_edit.m_insert.enabled = False
//		m_pfe_cst_data_entry.m_edit.m_delete1.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', False)
	END IF
ELSE
	IF IsValid(m_pfe_cst_data_entry) THEN
//		m_pfe_cst_data_entry.m_edit.m_insert.enabled = True
//		m_pfe_cst_data_entry.m_edit.m_delete1.enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', True)
	END IF
END IF


//IF newindex = 5 THEN
//	w_mdi.ChangeMenu( m_pfe_cst_verif_info )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//	w_mdi.SetToolbarPos ( 3, 1, 300, False)	
//	inv_action_items.of_enable_action_menu( tab_1.tabpage_verif.uo_verif_summary.of_get_dw() , "1" )
//	w_mdi.of_menu_security( "m_pfe_cst_verif_info" )	
//	//set priority
//	IF w_mdi.of_security_access( 182 ) = 0 THEN
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.background.color= '12632256'")
//	END IF
//	//priority user
//	IF w_mdi.of_security_access( 185 ) = 0 THEN
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.background.color= '12632256'")
//	END IF	
//	//post results
//	IF w_mdi.of_security_access( 160 ) = 0 THEN
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.background.color= '12632256'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.background.color= '12632256'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '12632256'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
//		tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '12632256'")
//	END IF		
//END IF

IF newindex = 2 THEN
	//<add> 08/04/2007 by:Andy
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.visible = True
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritemvisible = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'toolbaritemvisible', True)
	//end of add
	tab_1.tabpage_detail.uo_data_entry.of_get_record_verif( tab_1.tabpage_detail.uo_data_entry.of_get_row( ))
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_delete1.enabled = False
		//m_pfe_cst_data_entry.m_edit.m_insert.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', False)
		m_pfe_cst_data_entry.m_system.m_nulldate.visible = false //maha020702
		m_pfe_cst_data_entry.m_view.m_aptnote.visible = False //maha 111802
		//m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritemvisible = False //maha 111802
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_aptnote,'toolbaritemvisible', False)
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = false
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', False)			
		m_pfe_cst_data_entry.m_file.m_multiapp.Visible = False
		//m_pfe_cst_data_entry.m_file.m_multiapp.toolbaritemvisible = False	
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_multiapp,'ToolBarItemVisible', False)
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritemvisible = false		
	END IF
END IF

////only show multi add on the appointment status screen
//IF IsValid(m_pfe_cst_data_entry) THEN
//	m_pfe_cst_data_entry.m_file.m_multiapp.Visible = False moved up maha 070104
//	m_pfe_cst_data_entry.m_file.m_multiapp.toolbaritemvisible = False	
//END IF	

IF newindex = 4 THEN  //appointment status tab
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.visible = False
	tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()
	//modify record status
	IF w_mdi.of_security_access( 125 ) = 0 THEN
		tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("active_status.protect = '1'")
		tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("active_status.background.color= '12632256'")
	END IF
	IF IsValid(m_pfe_cst_data_entry) THEN
//		m_pfe_cst_data_entry.m_file.m_multiapp.visible = True maha removed
//		m_pfe_cst_data_entry.m_file.m_multiapp.enabled = True
//		m_pfe_cst_data_entry.m_file.m_multiapp.toolbaritemvisible = True
		//select set_14 into :set_ck from icred_settings;
		set_ck = of_get_app_setting("set_14","I")
		if set_ck = 1 then //appointment note tool
			m_pfe_cst_data_entry.m_view.m_aptnote.visible = True //maha 111802
			//m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritemvisible = True //maha 111802
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_aptnote,'toolbaritemvisible', True)
		end if
		//m_pfe_cst_data_entry.m_system.m_nulldate.visible = true //maha020702
	END IF	
END IF

//IF newindex = 7 THEN
//	w_mdi.ChangeMenu( m_pfe_cst_imaging )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//	w_mdi.SetToolbarPos ( 3, 1, 300, False)	
//	tab_1.tabpage_image.uo_image.of_enable_next_prev_buttons( "Browse" )
//	tab_1.tabpage_image.uo_image.of_set_menu( 1 )	
//END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------

IF newindex = 4 THEN
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.visible = False
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritemvisible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'toolbaritemvisible', False)
END IF



This.PostEvent( "pfc_cst_after_select" )

IF newindex = 2 THEN
	tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable()
END IF

IF NOT ib_new_prac THEN
	GarbageCollect ( )
END IF

IF gb_se_version THEN
	of_se()
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-22
//$<add> 01.26.2006 By: Cao YongWang
//$<reason> Performacne tuning
//$<modification> Add the following script to make sure that w_mdi will be
//$<modification> be redrawed when the previous operations are done. Refer to
//$<modification> PT-21 for more information.

//---------------------------- APPEON END ----------------------------
//--------Begin Added by Nova 08.13.2008------------------------
IF newindex <> 1 THEN
	IF Not IsValid(gnv_dashboard_data) THEN gnv_dashboard_data = Create n_cst_dashboard_data
	IF gi_parent_facility <> 0 THEN
		gnv_dashboard_data.of_update_gadgets_recent( 'PRAC', il_prac_id, gi_parent_facility)
	END IF
END IF
//--------End Added --------------------------------------------
RETURN 1





end event

event ue_setselectedflag(integer ai_newindex);//////////////////////////////////////////////////////////////////////
// $<event> ue_setselectedflag
// $<arguments>
//		integer	ai_newindex
// $<returns> (None)
// $<description> Set selected flag of tab page (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.18.2009
//////////////////////////////////////////////////////////////////////

window lw
lw = parent

Choose Case ai_NewIndex
	Case 2
		If not ib_page2_selected Then
			//of_registerresize(newindex)
			ib_page2_selected = true
		End if
	Case 3
		If not ib_page3_selected Then
			//of_registerresize(newindex)
			ib_page3_selected = true
		End if
	Case 4
		If not ib_page4_selected Then
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Reset()
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_Parent_Window( lw )
			
			if not ib_tab_seleted then 
			  tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.SelectTab(2)
			end if 
			//appointment stat
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_Set_parent_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_prac_id( il_prac_id )
			
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
			//of_registerresize(newindex)
			ib_page4_selected = true
		End if
				
		// added by 04.11.2006
		If ib_page4_refresh Then
			tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_detail()	
			ib_page4_refresh = False
		End if
	Case 5
		If not ib_page5_selected Then
			tab_1.tabpage_detail.uo_data_entry.of_set_verification_info( tab_1.tabpage_verif.uo_verif_summary )
			//verif_info
			tab_1.tabpage_verif.uo_verif_summary.of_Reset( )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_Prac_Id( il_prac_id )
			tab_1.tabpage_verif.uo_verif_summary.of_Set_View_Id( il_data_view )

			//of_registerresize(newindex)
			ib_page5_selected = true
		End If

		// added by 04.11.2006
		If ib_page5_refresh Then
			tab_1.tabpage_verif.uo_verif_summary.of_get_this_facility_data( )
			ib_page5_refresh = False
		End if
	Case 6
		If not ib_page6_selected Then
			//setup profile tab
			tab_1.tabpage_profile.uo_profile.of_set_facility_Id( ii_parent_facility_id )
			tab_1.tabpage_profile.uo_profile.of_set_prac_id( il_prac_id )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2008-08-19 By: Alan
			//$<reason> setup parameter
			tab_1.tabpage_profile.uo_profile.of_set_view_id( il_data_view )
			//---------------------------- APPEON END ----------------------------
			//of_registerresize(newindex)
			ib_page6_selected = true
		End if
	Case 7
		
		//Added by Ken.Guo on 2008-11-07
		If Not ib_imageocx_showed Then
			gnv_reg_ocx.of_check_ocx(3,'',True)
			ib_imageocx_showed = True
		End If
		
		If not ib_page7_selected Then
			tab_1.tabpage_image.uo_image.of_set_parent( lw )
			//of_registerresize(newindex)
			ib_page7_selected = true
//			w_mdi.of_prac_folder_security(Parent) //Added by Ken.Guo 2008-02-25  //Start Code Change ----09.24.2010 #V10 maha - removed because redundant to post open

			//For a Web version bug if the meetings tab is invisible - alfee 03.03.2010
			if appeongetclienttype() = 'WEB' and ib_page7_firsttime then
				ib_page7_firsttime = FALSE
				this.post selecttab(7)					
			end if
						
			of_ImagingWarning()			//Added by Scofield on 2007-09-21
		End if
	Case 8
		If not ib_page8_selected Then
			//of_registerresize(newindex)
			ib_page8_selected = true
		End if
	Case 9
		If not ib_page9_selected Then
			//of_registerresize(newindex)
			ib_page9_selected = true
		End if
	Case 10
		If not ib_page10_selected Then
			//of_registerresize(newindex)
			ib_page10_selected = true
		End if
End Choose
end event

event ue_setsecurity(integer ai_newindex);//////////////////////////////////////////////////////////////////////
// $<event> ue_setsecurity
// $<arguments>
//		integer	ai_newindex
// $<returns> (None)
// $<description> Set menu and tab page security (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.18.2009
//////////////////////////////////////////////////////////////////////

integer set_ck
integer li_index

choose case ai_NewIndex
	case 1 //search
		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
		w_mdi.of_menu_security( "m_pfe_cst_mdi_menu" )
	case 2 //demographics
		IF tab_1.tabpage_detail.uo_data_entry.of_get_selected_view_tab() = 1 THEN
			tab_1.tabpage_detail.uo_data_entry.of_setfocus_browse() 
			tab_1.tabpage_detail.uo_data_entry.of_btt_browse()
		ELSE
			tab_1.tabpage_detail.uo_data_entry.of_setfocus_detail() 
			tab_1.tabpage_detail.uo_data_entry.of_btt_detail()
			tab_1.tabpage_detail.uo_data_entry.of_btt_address_link_button()
		END IF		
		If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then w_mdi.ChangeMenu( m_pfe_cst_data_entry )
		tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
		w_mdi.of_menu_security( "m_pfe_cst_data_entry" )
	case 3 //checklist
		tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_app_audit_complete()
		If w_mdi.menuname <> 'm_pfe_cst_app_audit' Then w_mdi.ChangeMenu( m_pfe_cst_app_audit )
		w_mdi.of_menu_security( "m_pfe_cst_app_audit" )
		tab_1.tabpage_app_audit.uo_app_audit.dw_detail.post setfocus()
	case 4 //appointments
		If w_mdi.menuname <> 'm_pfe_cst_data_entry' Then w_mdi.ChangeMenu( m_pfe_cst_data_entry )
		tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_de_complete()
		w_mdi.of_menu_security( "m_pfe_cst_data_entry" )
		if w_mdi.of_security_access( 125 ) = 0 then  
			tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("active_status.protect = '1'")
			tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("active_status.background.color= '16120575'")  //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
			//Start Code Change ----03.05.2010 #V10 maha
			tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("in_good_standing.protect = '1'")
			tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("in_good_standing.background.color= '553648127'") //Start Code Change ----10.10.2012 #V12 maha - changed to transparent
			//End Code Change ----03.05.2010 
		end if
		if w_mdi.of_security_access( 128 ) = 0 then
			tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_quest.hide()
		end if
		tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()
	case 5 //verifications
		If w_mdi.menuname <> 'm_pfe_cst_verif_info' Then w_mdi.ChangeMenu( m_pfe_cst_verif_info )
		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		w_mdi.SetToolbarPos ( 3, 1, 300, False)

		//If the inv_action_items not is valid the create it
		If not isvalid(inv_action_items) Then inv_action_items = create pfc_n_cst_ai_action_items
		inv_action_items.of_enable_action_menu( tab_1.tabpage_verif.uo_verif_summary.of_get_dw() , "1",2 )
		w_mdi.of_menu_security( "m_pfe_cst_verif_info" )
		
		//MAHA note - this code should not be moved to the of_prac_window_security function of w_mdi becaues it will not be effective (object not instanciated?)
		//set priority
//Start Code Change ----10.10.2012 #V12 maha - moved to user object
		tab_1.tabpage_verif.uo_verif_summary.of_security( )
		
//		IF w_mdi.of_security_access( 182 ) = 0 THEN
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.protect = '1'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority.background.color= '553648127'")
//		END IF
//		//priority user
//		IF w_mdi.of_security_access( 185 ) = 0 THEN
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.protect = '1'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("priority_user.background.color= '553648127'")
//		END IF	
//		//post results
//		IF w_mdi.of_security_access( 160 ) = 0 THEN
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.protect = '1'")
//			//tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.background.color= '553648127'") //Delete by Evan 01/21/2009---Use dw property express instead
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.protect = '1'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("user_name.background.color= '553648127'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '553648127'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.protect = '1'")
//			tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("date_recieved.background.color= '553648127'")
//		END IF
//End Code Change ----10.10.2012 
	case 6 //profile
		If w_mdi.menuname <> 'm_pfe_cst_profile' Then w_mdi.ChangeMenu( m_pfe_cst_profile )
		w_mdi.of_menu_security( "m_pfe_cst_profile" )
	case 7 //images
		li_index = tab_1.tabpage_image.uo_image.tab_view.Selectedtab
		tab_1.tabpage_image.uo_image.of_set_menu(li_index)
		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
		w_mdi.SetToolbarPos ( 3, 1, 300, False)		
	case 8 //privileges
		If w_mdi.menuname <> 'm_pfe_cst_privileges' Then w_mdi.ChangeMenu( m_pfe_cst_privileges )
		w_mdi.of_menu_security( "m_pfe_cst_privileges" )				
	case 9  //applications
		If w_mdi.menuname <> 'm_pfe_cst_net_dev' Then w_mdi.ChangeMenu( m_pfe_cst_net_dev )
		w_mdi.of_menu_security( "m_pfe_cst_net_dev" )
		//Start Code Change ----08.16.2011 #V12 maha - appointment record security
		IF w_mdi.of_security_access( 120 ) = 1 THEN
			tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_appoint_stat.enabled = false
		end if
		IF w_mdi.of_security_access( 125 ) = 0 THEN
			tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_appoint_stat.Modify("active_status.protect = '1'")
		end if
		//End Code Change ----08.16.2011 
	case 10 //meetings
		If w_mdi.menuname <> 'm_pfe_cst_prac_meetings' Then w_mdi.ChangeMenu( m_pfe_cst_prac_meetings )
		w_mdi.of_menu_security( "m_pfe_cst_prac_meetings" )
end choose
end event

event selectionchanging;Integer li_retval 
integer li_hide //maha 01.01.2011
PowerObject apo_control_update[]

if ib_from_ssn = true then return  //Start Code Change ----01.25.2014 #V14 maha
//This.SetRedraw( False )
ChangeDirectory(Gs_Current_Directory)//Added By Ken.Guo 06.17.2008. For picture object using picture file in current directory.
if this.tabpage_search.uo_search.dw_search.rowcount() > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	if newindex = 1 THEN
		if of_validate_image() = 1 then return 1
	end if
	//---------------------------- APPEON END ----------------------------

// mskinner 17 jan 2005 - begin
	//if not(ib_new_prac) and  oldindex = 1 AND  (gl_prac_id <> this.tabpage_search.uo_search.dw_search.object.PRAC_ID[this.tabpage_search.uo_search.dw_search.GETROW()] ) THEN 
//Start Code Change ----11.08.2013 #V14 maha = added test for parent facility and split into two statements
//	if not(ib_new_prac) and  oldindex = 1 AND not(ib_from_ssn) and (il_prac_id <> this.tabpage_search.uo_search.dw_search.object.PRAC_ID[this.tabpage_search.uo_search.dw_search.GETROW()] ) THEN 
	IF not(ib_new_prac) and  oldindex = 1 AND not(ib_from_ssn) then
		if il_prac_id <> this.tabpage_search.uo_search.dw_search.object.PRAC_ID[this.tabpage_search.uo_search.dw_search.GETROW()]   or gi_parent_facility <> ii_parent_facility_id THEN 
			ib_tab_seleted = true
			this.tabpage_search.uo_search.of_select_prac( this.tabpage_search.uo_search.dw_search.getrow() )
		end if
	END IF 
// mskinner 17 jan 2005 - end
//End Code Change ----11.08.2013

end if 

//if ib_from_ssn then of_setup_title_search( )  //Start Code Change ----01.14.2014 #V14 maha //Start Code Change ----01.25.2014 #V14 maha removed

ib_from_ssn = false
//End Code Change---10.03.2006


IF tab_1.tabpage_detail.uo_data_entry.of_get_row_count_detail() = 0 THEN
	//This.SetRedraw(TRUE)
	Return 0
END IF

IF NOT ib_win_just_opened AND oldindex <> 1 THEN
	li_retval = Parent.Event pfc_save()
	
	IF li_retval < 0 THEN
		//This.SetRedraw(TRUE)
		Return 1
	ELSEIF li_retval = 0 AND tab_1.tabpage_detail.uo_data_entry.of_get_row_selector() = 1 AND tab_1.tabpage_detail.uo_data_entry.of_is_prac_id_null() AND newindex > 3 THEN
		MessageBox("Missing Data", "You must first complete Basic Information to continue.")
		//This.SetRedraw(TRUE)
		Return 1
	END IF
END IF


//Start Code Change ----03.27.2014 #V14.2 maha - moved to function and  selectionchanged (of_photo_visible_hide)
////Start Code Change ----06.22.2010 #V10 maha - photo visibility
////Start Code Change ----05.03.2011 #V11 maha -  modified so the hide is uneffected in IntelliCred
//if gb_sk_ver then
//	 li_hide = 1
//elseif gs_cust_type = 'I' and gi_prac_tab = 1 then
//	li_hide = 1 //Start Code Change ----01.01.2011 #V11 maha - app sk tab in app
//end if
////End Code Change ----05.03.2011
//
//choose case newindex
//	case 3,5,9, 4 , 11      //Start Code Change ----03.29.2012 #V12 maha - added appl tab  //Start Code Change ----04.13.2012 #V12 maha - added appointment tab //03.05.2014 maha added contract
//		p_prac_photo.visible = false
//		dw_p_data.visible = false
//		
//	case 1
//		p_prac_photo.visible = true
//		dw_p_data.visible = true
//		
//	case else
//		if  li_hide = 1 then   //Start Code Change ----01.01.2011 #V11 maha - app sk tab in app
//			p_prac_photo.visible = false
//			dw_p_data.visible = false
//		elseif newindex > 2 and p_prac_photo.picturename = "nophoto2-demo.jpg" then
//			p_prac_photo.visible = false
//			dw_p_data.visible = false
//		else
//			if ii_photo_search_only = 1 then   //Start Code Change ----05.19.2011 #V11 maha - user option
//				p_prac_photo.visible = false
//				dw_p_data.visible = false
//			else
//				if ib_new_prac then //Start Code Change ----11.15.2013 #V14 maha - added to hide photo until provider saved
//					p_prac_photo.visible = false
//				else
//					p_prac_photo.visible = true
//					dw_p_data.visible = true
//				end if
//			end if
//		end if
//end choose

//IF ib_win_just_opened then
//	p_prac_photo.visible = false
//	dw_p_data.visible = false
//end if

//End Code Change---06.22.2010

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<comment> 01.23.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Move the following script to ue_selectionchanging. ue_selectionchanging will be 
//$<modification> called in selectionchanged event. This change is due to usage of CreateOnDemand.

//---------------------------- APPEON END ----------------------------
/*
IF ib_new_prac AND oldindex = 4 THEN
	tab_1.tabpage_detail.uo_data_entry.of_set_verifying_facility( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_verifying_facility_id() )
	tab_1.tabpage_detail.uo_data_entry.of_set_parent_facility_id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )
	tab_1.tabpage_verif.uo_verif_summary.of_set_facility_id(tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id())	
	tab_1.tabpage_profile.uo_profile.of_Set_facility_Id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_verifying_facility_id() )
	tab_1.tabpage_app_audit.uo_app_audit.of_set_parent_facility_id( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )	
	of_get_parent_facility( tab_1.tabpage_apptmnt_status.uo_affill_status.of_get_parent_facility_id() )	
END IF


IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_is_new_record() THEN
	tab_1.tabpage_app_audit.uo_app_audit.of_Set_parent_facility_Id( ii_parent_facility_id )
	tab_1.tabpage_app_audit.uo_app_audit.of_Retrieve( il_prac_id )
	tab_1.tabpage_verif.uo_verif_summary.of_Retrieve( il_prac_id )
	tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_new_record( False )
END IF


IF tab_1.tabpage_apptmnt_status.uo_affill_status.of_changed_app_audit() = True THEN
	of_retrieve_app_audit()
END IF

IF newindex = 3 AND NOT ib_app_audit_retrieved THEN
	of_retrieve_app_audit()
ELSEIF newindex = 4 AND NOT ib_affil_stat_retrieved THEN
	of_retrieve_affil_stat()
ELSEIF newindex = 5 AND NOT ib_verif_info_retrieved THEN	
	of_retrieve_verif_info()
	//ELSEIF newindex = 6 AND NOT ib_site_survey_retrieved THEN	
	//	of_retrieve_site_survey()
ELSEIF newindex = 10 AND NOT ib_meetings_retrieved THEN		
	 of_retrieve_meetings()
ELSEIF newindex = 7 AND NOT ib_image_info_retrieved THEN		
	of_retrieve_images()	
//maha082200
ELSEIF newindex = 8 and not ib_priv_retrieved then
	of_retrieve_privs()	
ELSEIF newindex = 9 AND NOT ib_net_retrieved THEN
	of_retrieve_net()
END IF

IF oldindex = 6 THEN
	tab_1.tabpage_profile.uo_profile.tab_report.tabpage_verification.dw_verification.DataObject = ""
	tab_1.tabpage_profile.uo_profile.tab_report.tabpage_profile.dw_profile.DataObject = ""	
END IF


IF oldindex = 9 AND IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF




This.PostEvent( "pfc_cst_after_select" )



ib_win_just_opened  = False

*/

end event

event selectionchanged;//////////////////////////////////////////////////////////////////////
// $<event> selectionchanged
// $<arguments>
//		integer	oldindex
//		integer	newindex
// $<returns> long
// $<description> Reconstruct this event for menu readonly security.
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.18.2009
//////////////////////////////////////////////////////////////////////

long ll_Handle
string s
string ls_name_up //maha 07.29.2015
string ls_name_down //maha 07.29.2015
integer li_next_vis_tab

// RP added 1.6.2016
IF this.selectedTab = 1 THEN
	this.tabpage_search.uo_search.event post ue_setResize()
END IF

IF newindex = 1 then tab_1.tabpage_search.uo_search.cb_search.default = true  //Start Code Change ----08.05.2014 #V14.2 maha - reset focus to the search button.

IF gs_cust_type <> "I" THEN
	IF newindex = 1 then  //OR newindex = 7 THEN //Start Code Change ----10.05.2011 #V12 maha - removed tab seven(documents)
		uo_app_stat.Visible = False
	ELSE
		uo_app_stat.Visible = True
	END IF
END IF

of_photo_visible_hide( newindex) //Start Code Change ----03.27.2014 #V14.2 maha - moved from selectionchanging event (org code)

IF this.tabpage_search.uo_search.dw_search.rowcount() > 0 THEN
	IF oldindex = 1 AND (gl_prac_id <> -9 AND NOT ib_new_prac AND gl_prac_id <> this.tabpage_search.uo_search.dw_search.object.PRAC_ID[this.tabpage_search.uo_search.dw_search.GETROW()]) THEN
		ib_tab_seleted = true
		if ib_from_ssn = false then  //Start Code Change ----01.25.2014 #V14 maha - added exception
			this.tabpage_search.uo_search.of_select_prac( this.tabpage_search.uo_search.dw_search.getrow() )
		end if
	END IF
End IF
IF oldindex = 1 AND newindex > 1 AND gl_prac_id = 0 THEN
	SelectTab(1)
	MessageBox("Invalid Selection", "You must first select a practitioner.")
	Return -1
END IF

// Set selected flag of tab page
this.Event ue_SetSelectedFlag(NewIndex)

// Invoke ue_SelectionChanging event
this.Event ue_SelectionChanging(OldIndex, NewIndex)

// Set menu and tab page security
//w_mdi.SetRedraw(false)   //Start Code Change ----05.24.2011 #V11 maha - removed for bleedthrough issues
IF appeongetclienttype() = "WEB" THEN w_mdi.SetRedraw(false) //alfee 08.18.2011

of_button_settings()  //Start Code Change ----01.16.2014 #V14 maha - moved from pfc_cst_after_select

this.Event ue_SetSecurity(NewIndex)
w_mdi.SetToolbarPos(2, 1, 200, False)
ll_Handle = Handle(w_mdi)
gnv_appeondll.of_SetToolbarPos(ll_Handle)
IF gb_se_version THEN of_se()
IF appeongetclienttype() = "WEB" THEN w_mdi.SetRedraw(true) //alfee 08.18.2011
//w_mdi.SetRedraw(true)   //Start Code Change ----05.24.2011 #V11 maha - removed for bleedthrough issues

// Update dashboard gadgets
IF NewIndex <> 1 THEN
	IF Not IsValid(gnv_dashboard_data) THEN gnv_dashboard_data = Create n_cst_dashboard_data
	IF gi_parent_facility <> 0 THEN
		gnv_dashboard_data.of_update_gadgets_recent('PRAC', il_prac_id, gi_parent_facility)
	END IF
END IF

//Start Code Change ----10.07.2009 #V10 maha - for Lehigh
if of_get_app_setting("set_58","I") = 1 and newindex  <> 2 then
	//parent.title = parent.is_full_name  + " - " + String( parent.il_prac_id ) + "  (" + parent.is_facility_name + ")" 
	if Len(parent.is_prac_title) > 0 then //(Appeon)Harry 09.09.2014 - V142 ISG-CLX for Testing v14.2 UI Issues
		parent.title = parent.is_prac_title   //Start Code Change ----03.08.2013 #V12 maha - changed to variable
	end if
end if
//End Code Change---10.07.2009

//Start Code Change ----02.26.2010 #V10 maha - auto refresh search
IF NewIndex = 1 and of_get_app_setting("set_49","I") = 10 THEN
	if isvalid(tab_1.tabpage_search.uo_search.SQLCA_1) then
		tab_1.tabpage_search.uo_search.of_search_new("Refresh")
	end if
End if
//End Code Change---02.26.2010	

 //Start Code Change ----07.29.2015 #V15 maha - set button name based on next visible tab

//set the tab label
 s = of_get_name(newindex)		
st_tabname.text = s

//set the up button
 li_next_vis_tab = of_next_tab_visible( newindex, true)
 ls_name_up = of_get_name( li_next_vis_tab)	
 
if  ls_name_up = "" then
	dw_tab_buttons.modify( "b_forward.text = ''")
else
	dw_tab_buttons.modify( "b_forward.text = '>> " +  ls_name_up + " >>'")
end if 
 
 //set the downbutton
 li_next_vis_tab = of_next_tab_visible( newindex, false)
 ls_name_down = of_get_name( li_next_vis_tab)	

if  ls_name_down = "" then
	dw_tab_buttons.modify( "b_back.text = ''")
else
	dw_tab_buttons.modify( "b_back.text = '<< " +  ls_name_down + " <<'")
end if

//End Code Change ----07.29.2015 #V15 maha
//choose case newindex
//	case 1
//		dw_tab_buttons.modify( "b_forward.text = '>> Demographics >>'")
//		dw_tab_buttons.modify( "b_back.text = ''")
//	case 2
//		dw_tab_buttons.modify( "b_forward.text = '>> Checklist >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Search <<'")
//	case 3
//		dw_tab_buttons.modify( "b_forward.text = '>> Appointments >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Demographics <<'")
//	case 4
//		dw_tab_buttons.modify( "b_forward.text = '>> Verifications >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Checklist <<'")
//	case 5
//		dw_tab_buttons.modify( "b_forward.text = '>> Profiles >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Appointments <<'")
//	case 6
//		dw_tab_buttons.modify( "b_forward.text = '>> Documents >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Verifications <<'")
//	case 7
//		dw_tab_buttons.modify( "b_forward.text = '>> Privileges >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Profiles <<'")
//	case 8
//		dw_tab_buttons.modify( "b_forward.text = '>> Applications >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Documents <<'")
//	case 9
//		dw_tab_buttons.modify( "b_forward.text = '>> Meetings >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Privileges <<'")
//	case 10
//		dw_tab_buttons.modify( "b_forward.text = '>> Contracts >>'")
//		dw_tab_buttons.modify( "b_back.text = '<< Applications <<'")
//	case 11
//		dw_tab_buttons.modify( "b_forward.text = ''")
//		dw_tab_buttons.modify( "b_back.text = '<< Meetings <<'")
//end choose

if newindex = 1 then
	dw_tab_buttons.modify( "b_back.enabled = 'False'")
else
	dw_tab_buttons.modify( "b_back.enabled = 'True'")
end if

 //End Code Change ----05.21.2015 
	
ib_from_ssn = false  //Start Code Change ----01.25.2014 #V14 maha

// Invoke pfc_cst_after_select event
this.PostEvent("pfc_cst_after_select")
IF NOT ib_new_prac THEN GarbageCollect()



Return 1
end event

type tabpage_search from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 79741120
string text = "Search"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 16777215
string powertiptext = "Provider Search"
uo_search uo_search
end type

on tabpage_search.create
this.uo_search=create uo_search
this.Control[]={this.uo_search}
end on

on tabpage_search.destroy
destroy(this.uo_search)
end on

type uo_search from pfc_cst_u_extended_search within tabpage_search
integer width = 4302
integer height = 2004
integer taborder = 60
boolean bringtotop = true
end type

on uo_search.destroy
call pfc_cst_u_extended_search::destroy
end on

type tabpage_detail from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 67108864
string text = "Demographics"
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Provider Demographics and Credentials"
oval_2 oval_2
uo_data_entry uo_data_entry
p_face p_face
end type

on tabpage_detail.create
this.oval_2=create oval_2
this.uo_data_entry=create uo_data_entry
this.p_face=create p_face
this.Control[]={this.oval_2,&
this.uo_data_entry,&
this.p_face}
end on

on tabpage_detail.destroy
destroy(this.oval_2)
destroy(this.uo_data_entry)
destroy(this.p_face)
end on

type oval_2 from oval within tabpage_detail
integer linethickness = 4
long fillcolor = 255
integer x = -32768
integer y = 364
integer width = 78
integer height = 60
end type

type uo_data_entry from pfc_cst_u_data_entry within tabpage_detail
event destroy ( )
integer x = 18
integer y = 44
integer width = 4315
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_data_entry.destroy
call pfc_cst_u_data_entry::destroy
end on

type p_face from picture within tabpage_detail
boolean visible = false
integer x = 2743
integer y = 2024
integer width = 101
integer height = 80
boolean bringtotop = true
string picturename = "nophoto.bmp"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

event rbuttondown;//////////////////////////////////////////////////////////////////////
// $<event> rbuttondown
// $<arguments>
//			unsignedlong	flags
//			integer			xpos
//			integer			ypos
// $<returns> integer
// $<description> Clears photo (Corrected BugA090201)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.14.2009
//////////////////////////////////////////////////////////////////////

string ls_image_type
blob lblb_image_data
datetime ldt_today

if MessageBox("Delete Photo", "Are you sure you want to delete the photo?", Question!, YesNo!) = 2 then
	Return
end if

SetNull(ls_image_type)
lblb_image_data = Blob(' ',EncodingAnsi!) //Encoding – Nova 11.16.2010
//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
//UPDATE pd_photo SET image_type = :ls_image_type WHERE pd_photo.prac_id = :il_prac_id;
ldt_today = datetime(today(),now())
UPDATE pd_photo SET image_type = :ls_image_type, mod_date = :ldt_today, mod_user = :gs_user_id WHERE pd_photo.prac_id = :il_prac_id;
//--------End Modified------------------------------

if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the photo.", StopSign!)
	Return
end if
UPDATEBLOB pd_photo SET image_data = :lblb_image_data WHERE pd_photo.prac_id = :il_prac_id;
if SQLCA.SQLCode <> 0 then
	MessageBox("Error", "Failed to delete the photo.", StopSign!)
	Return
end if

this.Hide()
end event

type tabpage_app_audit from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 80269524
string text = "Checklist"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Process Checklist"
uo_app_audit uo_app_audit
end type

on tabpage_app_audit.create
this.uo_app_audit=create uo_app_audit
this.Control[]={this.uo_app_audit}
end on

on tabpage_app_audit.destroy
destroy(this.uo_app_audit)
end on

type uo_app_audit from pfc_cst_u_application_audit within tabpage_app_audit
event destroy ( )
integer x = 5
integer y = 36
integer height = 2016
integer taborder = 20
boolean bringtotop = true
end type

on uo_app_audit.destroy
call pfc_cst_u_application_audit::destroy
end on

type tabpage_apptmnt_status from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 80269524
string text = "Appointments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Appointment Periods"
uo_affill_status uo_affill_status
end type

on tabpage_apptmnt_status.create
this.uo_affill_status=create uo_affill_status
this.Control[]={this.uo_affill_status}
end on

on tabpage_apptmnt_status.destroy
destroy(this.uo_affill_status)
end on

type uo_affill_status from pfc_cst_u_apptmnt_status within tabpage_apptmnt_status
event destroy ( )
integer y = 48
integer width = 4635
integer height = 2044
integer taborder = 30
boolean bringtotop = true
boolean border = false
end type

on uo_affill_status.destroy
call pfc_cst_u_apptmnt_status::destroy
end on

type tabpage_verif from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 79741120
string text = "Verifications"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Verification information"
uo_verif_summary uo_verif_summary
end type

on tabpage_verif.create
this.uo_verif_summary=create uo_verif_summary
this.Control[]={this.uo_verif_summary}
end on

on tabpage_verif.destroy
destroy(this.uo_verif_summary)
end on

type uo_verif_summary from pfc_cst_u_verification_info within tabpage_verif
event destroy ( )
integer y = 48
integer width = 4626
integer taborder = 30
boolean bringtotop = true
long backcolor = 32891346
end type

on uo_verif_summary.destroy
call pfc_cst_u_verification_info::destroy
end on

type tabpage_profile from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 80269524
string text = "Profiles"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = " Data and Verification profiles"
uo_profile uo_profile
end type

on tabpage_profile.create
this.uo_profile=create uo_profile
this.Control[]={this.uo_profile}
end on

on tabpage_profile.destroy
destroy(this.uo_profile)
end on

type uo_profile from pfc_cst_u_profile within tabpage_profile
event destroy ( )
integer y = 32
integer width = 4631
integer height = 2036
integer taborder = 30
boolean bringtotop = true
end type

on uo_profile.destroy
call pfc_cst_u_profile::destroy
end on

type tabpage_image from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 79741120
string text = "Documents"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Document/Image storage."
uo_image uo_image
end type

on tabpage_image.create
this.uo_image=create uo_image
this.Control[]={this.uo_image}
end on

on tabpage_image.destroy
destroy(this.uo_image)
end on

type uo_image from pfc_cst_u_imaging within tabpage_image
event destroy ( )
integer y = 52
integer width = 4119
integer height = 2040
integer taborder = 30
boolean bringtotop = true
end type

on uo_image.destroy
call pfc_cst_u_imaging::destroy
end on

type tabpage_privileges from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 80269524
string text = "Privileges"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
string powertiptext = "Privileges that have been Requested/Granted."
uo_priv uo_priv
end type

on tabpage_privileges.create
this.uo_priv=create uo_priv
this.Control[]={this.uo_priv}
end on

on tabpage_privileges.destroy
destroy(this.uo_priv)
end on

type uo_priv from uo_priv_data_ent within tabpage_privileges
event destroy ( )
integer x = 5
integer y = 44
integer height = 2076
integer taborder = 10
boolean bringtotop = true
end type

on uo_priv.destroy
call uo_priv_data_ent::destroy
end on

type tabpage_net from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 80269524
string text = "Applications"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 12632256
string powertiptext = "Actions and Ids related to the Application process."
uo_net uo_net
end type

on tabpage_net.create
this.uo_net=create uo_net
this.Control[]={this.uo_net}
end on

on tabpage_net.destroy
destroy(this.uo_net)
end on

type uo_net from pfc_ia_cst_nv_net_dev_new within tabpage_net
integer y = 20
integer width = 4704
integer height = 2064
integer taborder = 20
boolean bringtotop = true
long backcolor = 81324524
end type

on uo_net.destroy
call pfc_ia_cst_nv_net_dev_new::destroy
end on

type tabpage_meetings from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 32891346
string text = "Meetings"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 12632256
string powertiptext = "Meetings to which the Provider is connected."
uo_meetings uo_meetings
end type

on tabpage_meetings.create
this.uo_meetings=create uo_meetings
this.Control[]={this.uo_meetings}
end on

on tabpage_meetings.destroy
destroy(this.uo_meetings)
end on

type uo_meetings from pfc_cst_u_meetings within tabpage_meetings
integer y = 48
integer width = 4622
integer height = 2040
integer taborder = 20
boolean bringtotop = true
end type

on uo_meetings.destroy
call pfc_cst_u_meetings::destroy
end on

type tabpage_contract from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
long backcolor = 32891346
string text = "Contracts"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
string powertiptext = "Contracts connected to the Provider"
uo_contracts uo_contracts
end type

on tabpage_contract.create
this.uo_contracts=create uo_contracts
this.Control[]={this.uo_contracts}
end on

on tabpage_contract.destroy
destroy(this.uo_contracts)
end on

type uo_contracts from pfc_cst_u_contracts_provider within tabpage_contract
integer x = 27
integer y = 152
integer width = 4590
integer taborder = 360
end type

on uo_contracts.destroy
call pfc_cst_u_contracts_provider::destroy
end on

type tabpage_wf from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 5285
integer height = 2092
boolean enabled = false
long backcolor = 80269524
string text = "WorkFlow Actions"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type dw_tab_buttons from u_dw within w_prac_data_1
boolean visible = false
integer x = 146
integer y = 164
integer width = 1147
integer height = 80
integer taborder = 21
string title = "none"
string dataobject = "d_tab_forward_back"
boolean border = false
end type

event buttonclicked;if dwo.name = "b_back" then
	of_next_tab("-")
elseif dwo.name = "b_forward" then
	of_next_tab("+")
end if
end event

event constructor;this.settransobject(sqlca)
this.insertrow(1)
end event

type st_tabname from statictext within w_prac_data_1
boolean visible = false
integer x = 1289
integer y = 164
integer width = 2094
integer height = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "Search"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_p_data from u_dw within w_prac_data_1
integer x = 4384
integer y = 1240
integer width = 910
integer height = 1244
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_personal_data_new"
boolean hscrollbar = true
boolean border = false
end type

event constructor;//Start Code Change ----11.07.2017 #V16 maha - removed switch
//if gs_cust_type = 'I' then
//	//this.dataobject = "d_sk_personal_data"
//	this.dataobject = "d_personal_data_app"  //Start Code Change ----02.20.2015 #V15 maha - changed dw object
//else
//	this.dataobject = "d_personal_data_new"
//end if

this.settransobject(sqlca)

// RP
this.object.datawindow.color = rgb(240, 245, 255)           //rgb(240, 243, 244)  //Start Code Change ----11.07.2017 #V16 maha

//Start Code Change ----02.27.2013 #V12 maha - hide the dob data if setting is turned off
if of_get_app_setting("set_42", "I") = 1 then
	this.object.date_of_birth.visible = false
	this.object.compute_age.visible = false   //Start Code Change ----05.10.2017 #V153 maha - chage field name (compute_1)
	this.object.t_dob.visible = false
	this.object.t_age.visible = false  
end if
//End Code Change ----02.27.2013
end event

event doubleclicked;
//Start Code Change ----12.20.2011 #V11 maha - added for email functionality
string s
string ls_email_address
string ls_subject
string ls_notetext
string ls_attach
long ll_return

if w_mdi.of_security_access(7843) = 0 then return 1

ls_email_address = this.getitemstring(1,"v_mailing_address_e_mail_address")

if isnull( ls_email_address) or ls_email_address = "" then
//	Messagebox("Email Address",  "There is is email address for this provider")
		Messagebox("Email Address",  "There is no email address for this provider")//long.zhang 11.20.2013 BugL111201 
	return 1
elseif  pos(ls_email_address, "@",1) = 0 then
	Messagebox("Email Address",  "Invalid email address for this provider")
	return 1	
end if


if  gi_email_type = 0 then //Start Code Change ----12.11.2012 #V12 maha - easymail changed to global variable
	open(w_general_email_send)
	w_general_email_send.sle_sendto.text = ls_email_address
elseif gi_email_type = 1 then //Start Code Change ----12.17.2012 #V12 maha - added outlook support
	n_cst_outlook lnv_Outlook
	
	Open( w_email_subject )
	IF Message.StringParm = "Cancel" THEN
		Return 1
	END IF
	
	ls_subject = Mid( Message.StringParm, 1, POS( Message.StringParm, "*" ) -1)
	ls_notetext = Mid( Message.StringParm, POS( Message.StringParm, "*" ) +1, 4000)	
	
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return 1
	end if
	
	ls_attach = ""
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return 1
	end if	

	
end if
end event

event buttonclicked;call super::buttonclicked; //Start Code Change ----02.10.2017 #V153 maha
string s
string ls_subject
string ls_notetext
string ls_attach
long ll_return
string ls_email_address
string ls_carrier
string ls_carrier_name  //maha 06.01.2017
string ls_addresser

if dwo.name = "b_text" then
	ls_email_address = this.getitemstring(1, "car_phone_1")
	ls_carrier = this.getitemstring(1, "sms")
	 ls_carrier_name = this.getitemstring(1, "carrier_name")   //Start Code Change ----06.01.2017 #V154 maha - for log
	
	if isnull(ls_email_address) or len(ls_email_address) = 0 then
		MessageBox("Texting", "This provider does not have a Mobile Number.")
		return
	end if
	
	if isnull(ls_carrier) or len(ls_carrier) = 0 then
		MessageBox("Texting", "This provider does not have a Mobile Carrier.")
		return
	end if
	
	ls_email_address = of_strip_char("",ls_email_address ,"@NUM@" )   //Start Code Change ----02.16.2017 #V153 maha
	
	ls_email_address = ls_email_address + "@" + ls_carrier
	
		Open( w_text_message )
		IF Message.StringParm = "Cancel" THEN
			Return 1
		END IF
		
		ls_subject = ""
		ls_notetext = Message.StringParm	
	
	if  gi_email_type = 0 then //easymail 
		n_cst_easymail_smtp 	lnv_Mail
		
//		MessageBox("Texting", "Not yet supported for Easymail")
//		return -1
		
//MUST GET EMAIL ADDRESS FROM USER

		IF lnv_Mail.of_CreateObject() = -1 THEN
			f_show_message('create Email object','','','','')
			RETURN -1
		END IF
	
		lnv_Mail.ib_combine_mail = false //Commented by (Appeon)Harry 06.10.2013 - V141 ISG-CLX
		ll_Return = lnv_Mail.of_SendText(GS_USER_ID, ls_email_address, "", "","", ls_notetext, "")

		IF ll_Return <> 0 THEN
			//Added by Nova.zhang on 2008-11-07
			//---------Begin Modified by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
			//f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
			If lnv_Mail.is_sendprotocol = 'SMTP' Then
				f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
			Else
				f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
			End If
		End if
			
			lnv_Mail.of_DeleteObject()
		//open(w_general_email_send)
		//w_general_email_send.sle_sendto.text = ls_email_address
	elseif gi_email_type = 1 then //Start Code Change ----12.17.2012 #V12 maha - added outlook support
		n_cst_outlook lnv_Outlook
		
		//---------Begin Commented by (Appeon)Stephen 05.25.2017 for Bug id 5653 - Texting in Intellicred/App V15.3 SaaS 05182017 and C/S 15.309 05112017--------
		/*
		Open( w_text_message )
		IF Message.StringParm = "Cancel" THEN
			Return 1
		END IF
		
		ls_subject = ""
		ls_notetext = Message.StringParm
		*/
		//---------End Commented ------------------------------------------------------

		if lnv_Outlook.of_Logon() = -1 then
			MessageBox("Text", "Mail Logon failed.  Check to make sure you have an email id setup in the user painter.")
			Return 1
		end if
		
		ls_attach = ""
		ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach) 
		lnv_Outlook.of_Logoff()
		if ll_Return <> 1 then
			of_log_text(il_prac_id, ls_email_address, ls_carrier_name, ls_notetext, 0 , "P")  //application function   //Start Code Change ----06.01.2017 #V154 maha - log
			MessageBox("Text Send", "Text not sent.")
			Return 1
		else
			of_log_text(il_prac_id, ls_email_address, ls_carrier_name, ls_notetext, 1 , "P")  //application function   //Start Code Change ----06.01.2017 #V154 maha - log
		end if	
	end if //email type
//EMAIL	
elseif  dwo.name = "b_email" then   //Start Code Change ----05.10.2017 #V153 maha
	this.triggerevent("doubleclicked")	
elseif  dwo.name = "b_test" then
	of_photo_data_settings( )
end if
	

end event

type p_buttons from picture within w_prac_data_1
integer x = 27
integer y = 24
integer width = 5262
integer height = 100
boolean originalsize = true
string picturename = "button_bar_background.png"
boolean focusrectangle = false
end type

type st_buttons from statictext within w_prac_data_1
integer x = 9
integer y = 8
integer width = 5298
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

