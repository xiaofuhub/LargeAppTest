$PBExportHeader$w_train_app.srw
$PBExportComments$from 12-2001
forward
global type w_train_app from w_main
end type
type cb_preview from picturebutton within w_train_app
end type
type st_field_name from statictext within w_train_app
end type
type st_page_num from statictext within w_train_app
end type
type st_msg from statictext within w_train_app
end type
type st_connect from statictext within w_train_app
end type
type tab_1 from tab within w_train_app
end type
type tabpage_select from userobject within tab_1
end type
type st_app from statictext within tabpage_select
end type
type st_org from statictext within tabpage_select
end type
type cb_find from commandbutton within tabpage_select
end type
type cb_import from commandbutton within tabpage_select
end type
type cb_set_save from commandbutton within tabpage_select
end type
type cb_set_delete from commandbutton within tabpage_select
end type
type cb_set_add from commandbutton within tabpage_select
end type
type dw_org_detail from u_dw within tabpage_select
end type
type p_1 from picture within tabpage_select
end type
type dw_appl_detail from u_dw within tabpage_select
end type
type dw_app_tv from datawindow within tabpage_select
end type
type tab_facility from tab within tabpage_select
end type
type tabpage_facility from userobject within tab_facility
end type
type dw_facility_detail from datawindow within tabpage_facility
end type
type dw_facility_browse from datawindow within tabpage_facility
end type
type tabpage_facility from userobject within tab_facility
dw_facility_detail dw_facility_detail
dw_facility_browse dw_facility_browse
end type
type tabpage_apps from userobject within tab_facility
end type
type cb_upload from commandbutton within tabpage_apps
end type
type dw_app_browse from datawindow within tabpage_apps
end type
type dw_app_detail_org from datawindow within tabpage_apps
end type
type dw_app_detail from u_dw within tabpage_apps
end type
type tabpage_apps from userobject within tab_facility
cb_upload cb_upload
dw_app_browse dw_app_browse
dw_app_detail_org dw_app_detail_org
dw_app_detail dw_app_detail
end type
type tabpage_images from userobject within tab_facility
end type
type dw_image_defaults from u_dw within tabpage_images
end type
type cb_2 from commandbutton within tabpage_images
end type
type dw_image_list from u_dw within tabpage_images
end type
type tabpage_images from userobject within tab_facility
dw_image_defaults dw_image_defaults
cb_2 cb_2
dw_image_list dw_image_list
end type
type tab_facility from tab within tabpage_select
tabpage_facility tabpage_facility
tabpage_apps tabpage_apps
tabpage_images tabpage_images
end type
type st_org_name from statictext within tabpage_select
end type
type tabpage_select from userobject within tab_1
st_app st_app
st_org st_org
cb_find cb_find
cb_import cb_import
cb_set_save cb_set_save
cb_set_delete cb_set_delete
cb_set_add cb_set_add
dw_org_detail dw_org_detail
p_1 p_1
dw_appl_detail dw_appl_detail
dw_app_tv dw_app_tv
tab_facility tab_facility
st_org_name st_org_name
end type
type tabpage_scan from userobject within tab_1
end type
type tabpage_scan from userobject within tab_1
end type
type tabpage_design from userobject within tab_1
end type
type ole_scan from olecustomcontrol within tabpage_design
end type
type dw_buttons_webform from datawindow within tabpage_design
end type
type cb_1 from commandbutton within tabpage_design
end type
type cb_screen from commandbutton within tabpage_design
end type
type ole_thumb from olecustomcontrol within tabpage_design
end type
type ole_img_admin from olecustomcontrol within tabpage_design
end type
type dw_field_tv from datawindow within tabpage_design
end type
type cb_goto_page from commandbutton within tabpage_design
end type
type sle_goto_page from singlelineedit within tabpage_design
end type
type gb_3 from groupbox within tabpage_design
end type
type st_field from statictext within tabpage_design
end type
type dw_screen from datawindow within tabpage_design
end type
type dw_field from datawindow within tabpage_design
end type
type uo_bar from pfc_cst_build_annotation_bar within tabpage_design
end type
type dw_2 from datawindow within tabpage_design
end type
type dw_1 from datawindow within tabpage_design
end type
type tab_fld_prop from tab within tabpage_design
end type
type tabpage_1 from userobject within tab_fld_prop
end type
type cb_3 from commandbutton within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type tabpage_1 from userobject within tab_fld_prop
cb_3 cb_3
st_1 st_1
st_2 st_2
end type
type tabpage_2 from userobject within tab_fld_prop
end type
type tabpage_2 from userobject within tab_fld_prop
end type
type tabpage_3 from userobject within tab_fld_prop
end type
type tabpage_3 from userobject within tab_fld_prop
end type
type tabpage_4 from userobject within tab_fld_prop
end type
type tabpage_4 from userobject within tab_fld_prop
end type
type tabpage_5 from userobject within tab_fld_prop
end type
type tabpage_5 from userobject within tab_fld_prop
end type
type tab_fld_prop from tab within tabpage_design
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type dw_fld_prop from datawindow within tabpage_design
end type
type cb_apply from commandbutton within tabpage_design
end type
type cb_view from commandbutton within tabpage_design
end type
type dw_quick_filters from datawindow within tabpage_design
end type
type dw_buttons from datawindow within tabpage_design
end type
type cb_fast from commandbutton within tabpage_design
end type
type ole_edit from olecustomcontrol within tabpage_design
end type
type uo_sitefield_map from pfc_cst_u_sitefield_mapping within tabpage_design
end type
type dw_preview_buttons from datawindow within tabpage_design
end type
type uo_preview from pfc_cst_u_create_app2 within tabpage_design
end type
type tabpage_design from userobject within tab_1
ole_scan ole_scan
dw_buttons_webform dw_buttons_webform
cb_1 cb_1
cb_screen cb_screen
ole_thumb ole_thumb
ole_img_admin ole_img_admin
dw_field_tv dw_field_tv
cb_goto_page cb_goto_page
sle_goto_page sle_goto_page
gb_3 gb_3
st_field st_field
dw_screen dw_screen
dw_field dw_field
uo_bar uo_bar
dw_2 dw_2
dw_1 dw_1
tab_fld_prop tab_fld_prop
dw_fld_prop dw_fld_prop
cb_apply cb_apply
cb_view cb_view
dw_quick_filters dw_quick_filters
dw_buttons dw_buttons
cb_fast cb_fast
ole_edit ole_edit
uo_sitefield_map uo_sitefield_map
dw_preview_buttons dw_preview_buttons
uo_preview uo_preview
end type
type tabpage_merge from userobject within tab_1
end type
type uo_create_app11 from pfc_cst_u_create_app2 within tabpage_merge
end type
type tabpage_merge from userobject within tab_1
uo_create_app11 uo_create_app11
end type
type tab_1 from tab within w_train_app
tabpage_select tabpage_select
tabpage_scan tabpage_scan
tabpage_design tabpage_design
tabpage_merge tabpage_merge
end type
type st_align from statictext within w_train_app
end type
end forward

global type w_train_app from w_main
integer x = 5
integer y = 4
integer width = 4750
integer height = 2400
string title = "Application Mapping"
long backcolor = 33551856
event pfc_addrow ( )
event pfc_deleterow ( )
event pfc_save_setup ( )
event pfc_select_row ( )
event pfc_test_app ( )
event pfc_delete_anno ( )
event pfc_change_org ( )
event pfc_image_path ( )
event pfc_test_all_apps ( )
event pfc_find ( )
event pfc_scan ( )
event pfc_blank_page ( )
event pfc_additional_info ( )
event pfc_straighten_page ( )
event pfc_page_properties ( )
event pfc_special_fields ( )
event pfc_field_exceptions ( )
event pfc_preview_page ( )
event pfc_preview_all ( )
event pfc_set_default_preview_prac ( )
event pfc_next_preview_page ( )
event pfc_prior_preview_page ( )
event pfc_align_tops ( )
event pfc_align_sides ( )
event pfc_align ( )
event pfc_connect_field ( )
event pfc_setup_connect_field ( )
event pfc_print_preview_app ( )
event pfc_prac_search ( )
event pfc_cst_goto_page ( )
event pfc_cst_highlighter ( )
event pfc_cst_scan_for_tifs ( )
event pfc_cst_copy_app ( )
event pfc_cst_insert_app ( )
event pfc_query_batch ( )
event pfc_cst_select_scanner ( )
event pfc_refresh_annotations ( )
event pfc_delete_page ( )
event pfc_insert_page ( )
event pfc_searchapp ( )
event ue_open_template ( )
event ue_save_mapping ( )
event ue_cut ( )
event ue_paste ( )
event ue_remove_object ( )
event ue_copyfields ( )
event ue_rope_select ( )
event ue_draw_box ( )
event ue_create_text ( )
event ue_auto_align_tops ( )
event ue_auto_align_sides ( )
event ue_clear_annos ( )
event ue_next_page ( )
event ue_prior_page ( )
event ue_preview_remove_object ( )
event ue_preview_create_text ( )
event pfc_pop_website ( )
cb_preview cb_preview
st_field_name st_field_name
st_page_num st_page_num
st_msg st_msg
st_connect st_connect
tab_1 tab_1
st_align st_align
end type
global w_train_app w_train_app

type prototypes

end prototypes

type variables
n_tr  tr_training_data

pfc_cst_nv_image_functions image_functions

Boolean ib_personal_data = False
Boolean ib_auto_align_all = False
Boolean ib_contol_key_down = False
Boolean ib_wide_screen = False
Boolean ib_skip = False
Boolean ib_skip_temp
Boolean ib_pause_temp = False
Boolean ib_rectangle_selected = False
boolean ib_is_group
boolean ib_audit = false //maha 022206
boolean ib_query_batch = false
boolean ib_rope = false

Boolean ib_moving_field = False
Boolean ib_placing_template = False
Boolean ib_loading_annotations = False
Boolean ib_deleted_app = False
Boolean ib_new_field_selection = False
Boolean ib_label_selected = False
Boolean ib_label_tool = False
Boolean ib_click_position = False
Boolean ib_fix_fields = False
Boolean ib_saved = True
Boolean ib_group = False

Long ii_label_y
Long ii_label_x
Long ii_cf_record_number
Long ii_shift_down_count = 0
Long li_last_fld_prop_tab = 1
Long ii_cf_past_years_query
Long ii_copy_fields
Long ii_connect_fields = 0
Long ii_ancor_count
Long ii_ancor_x
Long ii_ancor_y
Long il_AnnoPosX, il_AnnoPosY //evan 12.16.2010
Long ii_align = 0
Long ii_facility_id
Long ii_app_id
long ii_app_field_id
long ii_app_field_ids[]
Long ii_current_page = 1
Long ii_x[]
Long ii_y[]
Long ii_height[]
Long ii_copy_ancor_x
Long ii_copy_ancor_y
Long ii_page_count
Long ii_selected_fields_cnt
Long ii_first_clicked_field
Long ii_first_clicked_field_x
Long ii_first_clicked_field_y
Long il_prac_id
Long ii_record_number
Long ii_addr_record_number
Long ii_billing_address_flag
Long ii_addr_billing_flag
Long ii_shrink
long il_app_id_audit
long il_loc_id  //maha 05.19.2014
integer ii_cf_skip_query  //Start Code Change ---- 06.14.2006 #539 maha
integer ii_cf_skip_record_number = 0 //Added by Appeon long.zhang 08.16.2016 (Application Mapping)
integer ii_cf_fontsize  //Start Code Change ----02.01.2011 #V11 maha 
integer ii_cf_do_fonts  //Start Code Change ----02.01.2011 #V11 maha 
integer ii_start_char  //Start Code Change ----06.06.2011 #V11 maha 
String is_preview_mode = "Train"
String ii_cf_query_field
String ii_cf_query_operator
String ii_cf_query_value
String is_label_id
String is_app_path
String is_selected_fields[]
String is_image_name
String is_select_field_dw =  "d_app_field_properties"
String is_last_key = ""
String is_query_field
String is_query_operator
String is_query_value
String is_addr_query_field
String is_addr_query_operator
String is_addr_query_value
String is_fld_nm

Boolean ib_hold_on_retrieve_end = False
Boolean ib_applied = False
Boolean ib_selected = False
Boolean ib_new_select = False
Boolean ib_drag_drop = False
Datawindow idw

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Declare a datastore for caching data.
datastore ids_queryfield
boolean is_IsRectangle = False		//used for copy/cut with rope select
//---------------------------- APPEON END ----------------------------

boolean ib_IsDeleteAnnotation = true //Add by Evan 05.27.2009

datawindow idw_Current
long il_TvCurrentRow
long il_default_view
long il_screen_id
long il_TvScrRow //alfee 12.02.2010
boolean ib_IsDragAnnotation //evan 12.16.2010
long il_mapping_type //evan 10.18.2011
boolean ib_insert_scan = false  //stephen 02.13.2012
end variables

forward prototypes
public function long of_update_field (string as_groupname, long left, long top, long width1, long height1)
public function long of_align (string as_align_type)
public function long of_copy_fields ()
public function long of_add_objects (string ls_object, long ai_font, long ai_bold)
public function long of_load_image ()
public function long of_delete_annotations ()
public function long of_load_annotations ()
public function long of_disable_buttons ()
public function long of_enable_buttons ()
public function long of_show_record ()
public function long of_delete_records ()
public function Long of_save_load ()
public function long of_auto_align ()
public function long of_select_app ()
public function long of_goto_fix_page (long row)
public function long of_select_button ()
public function long of_save_mapping ()
public function long of_save (string as_tab)
public function long of_remove_object ()
public function long of_open_template ()
public function long of_prior_page ()
public function long of_next_page ()
public function long of_select_field ()
public function long of_rope_select ()
public function long of_create_text ()
public function long of_draw_box ()
public function long of_copy ()
public function long of_paste ()
public function long of_cut ()
public function long of_add_row ()
public function long of_delete_row ()
public function long of_test_application ()
public function long of_delete_anno_files ()
public function long of_change_org ()
public function Long of_check_row ()
public function Long of_check_all_apps ()
public function Long of_find ()
public function long of_scan ()
public function long of_blank_page ()
public function Long of_additional_info ()
public function long of_straighten_page ()
public function long of_special_fields ()
public function Long of_field_exceptions ()
public function long of_page_properties ()
public function long of_preview (string as_type)
public function Long of_set_default_preview_prac ()
public function Long of_next_preview_page ()
public function long of_prior_preview_page ()
public function long of_setup_align ()
public function long of_setup_connect_field ()
public function long of_connect_field ()
public function long of_select_field_info ()
public function Long of_print_preview_app ()
public function long of_prac_search ()
public function long of_retrieve_end ()
public function long of_create_annotations (long ai_field_id)
public function integer of_auto_align_all ()
public function integer of_auto_align_tops ()
public function integer of_auto_align_sides ()
public function integer of_add_hollow_box ()
public function integer of_clear_annotations ()
public function integer of_clear_annos ()
public function integer of_clear_annos_one_page (integer ai_old_page, integer ai_new_page)
public function integer of_dw_field_dclick ()
public function integer of_field_name_visible ()
public function integer of_clean_data ()
public function integer of_addr_query_setup ()
public function integer of_check_for_image ()
public function integer of_set_query_lookup (string as_lookup, string as_data, string as_lookup_code, string as_field)
public function integer of_app_audit_track (long ai_appid)
private function integer of_cleanup (integer ai_prev_scrollx, integer ai_prev_scrolly)
public function integer of_query_batch_update ()
public function integer of_dupe_field_test (string as_field)
public function long of_get_app_field_id (string as_selected_field)
public subroutine of_retrieve_tables_fields ()
public function integer of_set_yes_no_box (datawindow as_dw, string as_data)
public function integer of_scanner_select ()
public function integer of_set_preview_mode (string as_mode)
public function integer of_clear_annos_single_page (integer ai_page)
public function integer of_troubleshoot_page (integer ai_page)
public function integer of_refresh_page ()
public function integer of_scan_insert ()
public function integer of_delete_pages ()
public function integer of_insert_pages ()
public function long of_goto_page (integer as_page)
public function long of_preview_add_objects (string ls_object, long ai_font, long ai_bold)
public function long of_preview_create_text ()
public function integer of_preview_remove_object ()
public function integer of_setbackgoundcolor (string as_dw)
public function integer of_savedata ()
public function integer of_addrow ()
public function integer of_deleterow ()
public function integer of_uploadimage (long al_app_id)
public function integer of_findapp ()
public function boolean of_imageisnull ()
public function long of_retrievefields ()
public function integer of_addlookupfield (string as_lookup_type)
public function integer of_setfilterfromsp ()
public function integer of_addfieldfromsp ()
public function long of_blank_page_old ()
public function integer of_hidemenuitems (long al_mapping_type)
public function integer of_correctaddrfieldlable (datastore ads_field_data)
public function integer of_draw_signature (long ai_x, long ai_y, string as_align_type, string as_field)
public function integer of_tips ()
public function integer of_org_inactivate (integer ai_status)
public subroutine of_sync_button_menu ()
end prototypes

event pfc_addrow();choose case tab_1.SelectedTab
	case 1
		of_AddRow()
	case 3 //Added by Evan 11.02.2011 - V12.1 Website Population
		tab_1.tabpage_design.uo_sitefield_map.Event ue_add(2)
end choose
end event

event pfc_deleterow();choose case tab_1.SelectedTab
	case 1
		of_DeleteRow()
	case 3 //Added by Evan 11.02.2011 - V12.1 Website Population
		tab_1.tabpage_design.uo_sitefield_map.TriggerEvent("ue_delete")
end choose
end event

event pfc_save_setup();//------------------- APPEON BEGIN -------------------
//$<modify> Evan 10.20.2010
//$<reason> V10.5-App Mapping
/*
IF tab_1.tabpage_select.tab_facility.SelectedTab = 1 THEN
	of_save( "facility" )
//$<modify> 07.10.2008 by Andy
//ELS
ELSEif tab_1.tabpage_select.tab_facility.SelectedTab = 2 then
	of_save( "apps" )
ELSE
	of_save( "images" )
//end modify 07.10.2008
END IF
*/
of_SaveData()
//------------------- APPEON END ---------------------
end event

event pfc_select_row();IF tab_1.tabpage_select.tab_facility.SelectedTab = 1 THEN
	 tab_1.tabpage_select.tab_facility.SelectTab( 2 )
	 ib_deleted_app = False
ELSE
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-09-27 By: Rodger Wu
	//$<reason> Fix a defect.
	Integer li_currentrow
	
	li_currentrow = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetSelectedRow( 0 )
	IF li_currentrow > 0 THEN
		IF ii_app_id <> tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( li_currentrow, "app_id" ) THEN
			tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Trigger Event Clicked( 0, 0, li_currentrow, tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.object.application_name )
		END IF
	END IF
	
	//---------------------------- APPEON END ----------------------------

	of_select_app( )
END IF
end event

event pfc_test_app;of_test_application( )
end event

event pfc_delete_anno;of_delete_anno_files( )
end event

event pfc_change_org;of_change_org( )
end event

event pfc_image_path;Open( w_get_path )

IF Message.StringParm <> "Cancel" THEN
	is_app_path = Message.StringParm
	gs_app_image_path = Message.StringParm
END IF


end event

event pfc_test_all_apps;of_check_all_apps( )
end event

event pfc_find();//------------------- APPEON BEGIN -------------------
//$<modify> Evan 10.22.2010
//$<reason> V10.5-App Mapping
//of_find( )
of_FindApp()
//------------------- APPEON END ---------------------


end event

event pfc_scan;of_scan( )
end event

event pfc_blank_page;of_blank_page()
end event

event pfc_additional_info;of_additional_info()
end event

event pfc_straighten_page;of_straighten_page()
end event

event pfc_page_properties;of_page_properties( )
end event

event pfc_special_fields;of_special_fields()
end event

event pfc_field_exceptions;of_field_exceptions()
end event

event pfc_preview_page();//Start Code Change ----12.03.2008 #V85 maha - modified to allow call to of_set_preview_mode
String ls_actual_current_page //Added by ken for save actual current page.
long ll_page,ll_pagecount

if of_check_for_image() = -1 then return//maha 031505

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> Define local variable to get the handle of w_mdi.
long ll_handle
ll_handle = handle(w_mdi)
//---------------------------- APPEON END ----------------------------
	
IF is_preview_mode = "Train" THEN  //from train to preview 
	//tab_1.tabpage_design.uo_preview.Visible = True
	//tab_1.tabpage_design.uo_preview.BringToTop = True
	//m_pfe_train_app.m_file.m_previewpage.toolbaritemname = "Custom041!"
	//m_pfe_train_app.m_file.m_previewpage.toolbaritemtext = "Train"
	//st_field_name.Visible = False
	//of_field_name_visible( )
	//st_page_num.Visible = False	
	//tab_1.tabpage_design.dw_field.Visible = False
//	tab_1.tabpage_design.ole_edit.Visible = False
//	is_preview_mode = "Preview"
//	w_mdi.ChangeMenu( m_pfe_train_app_preview )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<add> 01.13.2006 By: Rodger Wu
	//$<reason> The SetToolbarPos function is currently unsupported. 
	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
	//$<modification> the same functionality.
//	If appeongetclienttype() <> 'PB' Then 
//		gnv_appeondll.of_settoolbarpos(ll_handle)
//		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
//	End If
	//---------------------------- APPEON END ----------------------------
	of_set_preview_mode( "Preview")
//	w_mdi.of_menu_security( "m_pfe_train_app_preview" )
	of_preview( "Page" )	
	//st_field_name.Visible = False
//	st_page_num.Visible = False	
	

	ll_page = tab_1.tabpage_design.uo_preview.ole_edit.object.Page()
	ll_pagecount = tab_1.tabpage_design.uo_preview.ole_edit.object.PageCount()
	IF ll_page = 1 and ll_page = ll_pagecount Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ElseIf ll_page = ll_pagecount Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ElseIf ll_page < ll_pagecount and ll_page > 1 Then 
		m_pfe_train_app.m_view.m_priorpage.Enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = True
		//tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = True //Added by Appeon long.zhang 03.08.2016 (BugL030803)
	ElseIf ll_page < ll_pagecount and ll_page = 1 Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = True		
		//tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = True //Added by Appeon long.zhang 03.08.2016 (BugL030803)
	End If



ELSE //from preview to train
	//m_pfe_train_app.m_file.m_previewpage.toolbaritemname = "ExecuteSQL5!"
	//m_pfe_train_app.m_file.m_previewpage.toolbaritemtext = "Preview"	

//	tab_1.tabpage_design.uo_preview.Visible = False
//	tab_1.tabpage_design.uo_preview.BringToTop = False
	
	tab_1.tabpage_design.uo_preview.of_load_app() //Added By Ken.Guo at 2007-06-19

	IF tab_1.tabpage_design.ole_edit.Object.Image() <> '' THEN
		tab_1.tabpage_design.ole_edit.Object.ShowAnnotationGroup( )
	END IF
	
	of_set_preview_mode( "Train")
	//st_field_name.Visible = True
//	st_page_num.Visible = True	
//	tab_1.tabpage_design.dw_field.Visible = True
//	tab_1.tabpage_design.ole_edit.Visible = True
//	is_preview_mode = "Train"		
//	w_mdi.ChangeMenu( m_pfe_train_app )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<add> 01.13.2006 By: Rodger Wu
	//$<reason> The SetToolbarPos function is currently unsupported. 
	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
	//$<modification> the same functionality.
//	If appeongetclienttype() <> 'PB' Then 
//		gnv_appeondll.of_settoolbarpos(ll_handle)
//		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
//	End If
	//---------------------------- APPEON END ----------------------------
	
//	w_mdi.of_menu_security( "m_pfe_train_app" )
//	IF tab_1.tabpage_design.ole_edit.Object.Image <> '' THEN	
//		IF tab_1.tabpage_design.ole_edit.Object.PageCount() = ii_current_page THEN
//			m_pfe_train_app.m_view.m_priorpage.Enabled = True
//			m_pfe_train_app.m_view.m_nextpage.Enabled = False
//		ELSEIF ii_current_page < tab_1.tabpage_design.ole_edit.Object.PageCount() AND ii_current_page > 1 THEN
//			m_pfe_train_app.m_view.m_priorpage.Enabled = True
//			m_pfe_train_app.m_view.m_nextpage.Enabled = True
//		END IF	
//	END IF
END IF
//
//of_field_name_visible( ) //Start Code Change ----11.06.2008 #V85 maha
//

//org code 12.02.2008 \/

//String ls_actual_current_page //Added by ken for save actual current page.
//
//
//if of_check_for_image() = -1 then return//maha 031505
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<add> 01.13.2006 By: Rodger Wu
////$<reason> Define local variable to get the handle of w_mdi.
//long ll_handle
//ll_handle = handle(w_mdi)
////---------------------------- APPEON END ----------------------------
//	
//IF is_preview_mode = "Train" THEN  //from train to preview 
//	tab_1.tabpage_design.uo_preview.Visible = True
//	tab_1.tabpage_design.uo_preview.BringToTop = True
//	//m_pfe_train_app.m_file.m_previewpage.toolbaritemname = "Custom041!"
//	//m_pfe_train_app.m_file.m_previewpage.toolbaritemtext = "Train"
//	//st_field_name.Visible = False
//	of_field_name_visible( )
//	st_page_num.Visible = False	
//	tab_1.tabpage_design.dw_field.Visible = False
//	tab_1.tabpage_design.ole_edit.Visible = False
//	is_preview_mode = "Preview"
//	w_mdi.ChangeMenu( m_pfe_train_app_preview )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> UM-01
//	//$<add> 01.13.2006 By: Rodger Wu
//	//$<reason> The SetToolbarPos function is currently unsupported. 
//	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//	//$<modification> the same functionality.
//	If appeongetclienttype() <> 'PB' Then 
//		gnv_appeondll.of_settoolbarpos(ll_handle)
//		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
//	End If
//	//---------------------------- APPEON END ----------------------------
//
//	w_mdi.of_menu_security( "m_pfe_train_app_preview" )
//	of_preview( "Page" )	
//	//st_field_name.Visible = False
//	st_page_num.Visible = False	
//	
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 06/19/2007 By: Ken.Guo
////$<reason> For Page menu control.
///*
//	IF tab_1.tabpage_design.ole_edit.Object.PageCount() = ii_current_page THEN
//		m_pfe_train_app.m_view.m_priorpage.Enabled = True
//		m_pfe_train_app.m_view.m_nextpage.Enabled = False
//	ELSEIF ii_current_page < tab_1.tabpage_design.ole_edit.Object.PageCount() AND ii_current_page > 1 THEN
//		m_pfe_train_app.m_view.m_priorpage.Enabled = True
//		m_pfe_train_app.m_view.m_nextpage.Enabled = True
//	END IF
//*/
//	long ll_page,ll_pagecount
//	ll_page = tab_1.tabpage_design.uo_preview.ole_edit.object.Page()
//	ll_pagecount = tab_1.tabpage_design.uo_preview.ole_edit.object.PageCount()
//	IF ll_page = 1 and ll_page = ll_pagecount Then
//		m_pfe_train_app.m_view.m_priorpage.Enabled = False
//		m_pfe_train_app.m_view.m_nextpage.Enabled = False
//	ElseIf ll_page = ll_pagecount Then
//		m_pfe_train_app.m_view.m_priorpage.Enabled = True
//		m_pfe_train_app.m_view.m_nextpage.Enabled = False
//	ElseIf ll_page < ll_pagecount and ll_page > 1 Then 
//		m_pfe_train_app.m_view.m_priorpage.Enabled = True
//		m_pfe_train_app.m_view.m_nextpage.Enabled = True
//	ElseIf ll_page < ll_pagecount and ll_page = 1 Then
//		m_pfe_train_app.m_view.m_priorpage.Enabled = False
//		m_pfe_train_app.m_view.m_nextpage.Enabled = True		
//	End If
////---------------------------- APPEON END ----------------------------
//
//
//ELSE //from preview to train
//	//m_pfe_train_app.m_file.m_previewpage.toolbaritemname = "ExecuteSQL5!"
//	//m_pfe_train_app.m_file.m_previewpage.toolbaritemtext = "Preview"	
//
//	tab_1.tabpage_design.uo_preview.Visible = False
//	tab_1.tabpage_design.uo_preview.BringToTop = False
//	
//	tab_1.tabpage_design.uo_preview.of_load_app() //Added By Ken.Guo at 2007-06-19
//
//	IF tab_1.tabpage_design.ole_edit.Object.Image() <> '' THEN
//		tab_1.tabpage_design.ole_edit.Object.ShowAnnotationGroup( )
//	END IF
//	//st_field_name.Visible = True
//	st_page_num.Visible = True	
//	tab_1.tabpage_design.dw_field.Visible = True
//	tab_1.tabpage_design.ole_edit.Visible = True
//	is_preview_mode = "Train"		
//	w_mdi.ChangeMenu( m_pfe_train_app )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> UM-02
//	//$<add> 01.13.2006 By: Rodger Wu
//	//$<reason> The SetToolbarPos function is currently unsupported. 
//	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//	//$<modification> the same functionality.
//	If appeongetclienttype() <> 'PB' Then 
//		gnv_appeondll.of_settoolbarpos(ll_handle)
//		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
//		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
//	End If
//	//---------------------------- APPEON END ----------------------------
//	
//	w_mdi.of_menu_security( "m_pfe_train_app" )
//	IF tab_1.tabpage_design.ole_edit.Object.Image <> '' THEN	
//		IF tab_1.tabpage_design.ole_edit.Object.PageCount() = ii_current_page THEN
//			m_pfe_train_app.m_view.m_priorpage.Enabled = True
//			m_pfe_train_app.m_view.m_nextpage.Enabled = False
//		ELSEIF ii_current_page < tab_1.tabpage_design.ole_edit.Object.PageCount() AND ii_current_page > 1 THEN
//			m_pfe_train_app.m_view.m_priorpage.Enabled = True
//			m_pfe_train_app.m_view.m_nextpage.Enabled = True
//		END IF	
//	END IF
//END IF
//of_field_name_visible( ) //Start Code Change ----11.06.2008 #V85 maha
end event

event pfc_preview_all();
string ls_page_from
string ls_page_to
string ls_prac
string ls_print
string ls_param

open(w_preview_params)

ls_param = message.stringparm

if isnull(ls_param) or ls_param = "" or ls_param = "Cancel" then
	return
end if

//Comment by Appeon long.zhang 03.09.2016 (BugL030901)
//IF is_preview_mode = "Train" THEN
//	tab_1.tabpage_design.uo_preview.Visible = True
//	tab_1.tabpage_design.uo_preview.BringToTop = True
//	//st_field_name.Visible = False
//	tab_1.tabpage_design.dw_field.Visible = False
//	tab_1.tabpage_design.ole_edit.Visible = False
//	is_preview_mode = "Preview"
//	w_mdi.ChangeMenu( m_pfe_train_app_preview )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)
//	w_mdi.of_menu_security( "m_pfe_train_app_preview" )
//end if
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-03
////$<add> 01.13.2006 By: Rodger Wu
////$<reason> The SetToolbarPos function is currently unsupported. 
////$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
////$<modification> the same functionality.
//If appeongetclienttype() <> 'PB' Then
//	long ll_handle
//	ll_handle = handle(w_mdi)
//	gnv_appeondll.of_settoolbarpos(ll_handle)
//	gnv_appeondll.of_SetToolbar(ll_handle,3, False )
//	gnv_appeondll.of_SetToolbar(ll_handle,4, False )
//	gnv_appeondll.of_SetToolbar(ll_handle,5, False )
//End If
////---------------------------- APPEON END ----------------------------

IF is_preview_mode = "Train" THEN of_set_preview_mode( "Preview") //Added by Appeon long.zhang 03.09.2016 (BugL030901)

of_preview( ls_param)	
	
//ELSE maha removed 042604
//	tab_1.tabpage_design.uo_preview.Visible = False
//	tab_1.tabpage_design.uo_preview.BringToTop = False
//	tab_1.tabpage_design.ole_edit.Object.ShowAnnotationGroup( )
//	//st_field_name.Visible = True
//	tab_1.tabpage_design.dw_field.Visible = True
//	tab_1.tabpage_design.ole_edit.Visible = True
//	is_preview_mode = "Train"		
//	w_mdi.ChangeMenu( m_pfe_train_app )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//END IF

of_field_name_visible()


end event

event pfc_set_default_preview_prac;of_set_default_preview_prac( )
end event

event pfc_next_preview_page;of_Next_Preview_page( )


end event

event pfc_prior_preview_page;of_Prior_Preview_page( )
end event

event pfc_align_tops;of_align( "Top" )
end event

event pfc_align_sides;of_align( "Sides" )
end event

event pfc_align;of_Setup_Align( )
end event

event pfc_connect_field;of_connect_field( )
end event

event pfc_setup_connect_field;of_setup_connect_field( )
end event

event pfc_print_preview_app;of_print_preview_app()
end event

event pfc_prac_search;of_prac_search( )
end event

event pfc_cst_goto_page();of_goto_page(0)//0:open w_goto_page  Added by  Nova 05.19.2009------------------------
end event

event pfc_cst_highlighter;of_add_hollow_box()
end event

event pfc_cst_scan_for_tifs;integer i

open(w_scan_for_tifs) 


end event

event pfc_cst_copy_app();Integer li_cr
long ll_find //add by Michael 10.12.2011
integer res = 1

 //Start Code Change ----02.12.2015 #V15 maha - multiple copy - mednax
do until res = 2
	OpenWithParm(w_copy_application, ii_app_id)
	IF Message.StringParm = "Cancel" THEN
		Return
	END IF
	
	res = messagebox("Copy","Do you wish to copy this Application again?", question!, yesno!,2)
loop
 //End Code Change ----02.12.2015	
	

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.05.2006 By: Rodger Wu
//$<reason> Performance tuning and Original code bug fixing
//$<modification> Add a messagebox to reduce the unnecessary calls to server.
/*
gs_pass_ids pass_ids
pass_ids = Message.PowerObjectParm
ii_app_id = pass_ids.l_app_id
ii_facility_id = pass_ids.facility_id
of_select_app( )
*/
gs_pass_ids pass_ids
pass_ids = Message.PowerObjectParm

tab_1.tabpage_select.dw_app_tv.Retrieve()//add by Michael 10.12.2011 Bug id 2738 - Copy application not refreshing

If Messagebox( "Option", "Do you want to edit application '" + pass_ids.sl_label1 + &
								 "' now?", Question!, YesNo!, 2 ) = 2 Then Return;
ii_app_id = pass_ids.l_app_id
ii_facility_id = pass_ids.facility_id

//------------------- APPEON BEGIN -------------------
//$<add> Michael 10.12.2011 
//$<reason>Bug id 2738 - Copy application not refreshing 
ll_find = tab_1.tabpage_select.dw_app_tv.Find("facility_id="+String(ii_facility_id), 1, tab_1.tabpage_select.dw_app_tv.RowCount())
IF ll_find > 0 THEN
	IF tab_1.tabpage_select.dw_app_tv.isexpanded( ll_find, 1) = False THEN
		tab_1.tabpage_select.dw_app_tv.expand( ll_find, 1)
	END IF
	ll_find = tab_1.tabpage_select.dw_app_tv.Find("facility_id="+String(ii_facility_id)+" and app_id="+String(ii_app_id) , 1, tab_1.tabpage_select.dw_app_tv.RowCount())
	IF ll_find > 0 THEN
		tab_1.tabpage_select.dw_app_tv.ScrollToRow(ll_find)
		tab_1.tabpage_select.dw_app_tv.SelectTreeNode( ll_find,2,True)
	END IF
END IF
//------------------- APPEON END ---------------------

of_select_app( )
//Show the current application's name.
This.Title = "IntelliApp  ( " + pass_ids.sl_label1 +  " )"
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_insert_app;Integer li_cr

li_cr = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetRow()


Open( w_insert_application )
IF Message.StringParm = "Cancel" THEN
	Return 
END IF


end event

event pfc_query_batch();//Start Code Change ---- 05.24.2006 #480 maha //created 05.24.06
Long li_dummy[]
String ls_dummy[]

if of_check_for_image() = -1 then Return // Add by Evan 05.07.2009 --- Corrected BugS122713

if ib_query_batch = false then //called from query batch on tool menu
	of_disable_buttons( )   //Start Code Change ----03.23.2016 #V15 maha
	w_train_app.tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
	w_train_app.ii_align = 0
	w_train_app.ii_ancor_count = 0
	w_train_app.is_selected_fields = ls_dummy
	w_train_app.ii_x = li_dummy
	w_train_app.ii_y = li_dummy
	w_train_app.ii_copy_fields = 1	
	w_train_app.tab_1.tabpage_design.ole_edit.object.AnnotationType( 11 )	
	
	m_pfe_train_app.m_tools.m_connectfields.ToolbaritemVisible = False
	m_pfe_train_app.m_edit.m_cut.ToolbaritemVisible = False
	m_pfe_train_app.m_edit.m_paste.ToolbaritemVisible = False
	m_pfe_train_app.m_edit.m_copy.ToolbaritemVisible = False
	m_pfe_train_app.m_edit.m_update.ToolbaritemVisible = True
	m_pfe_train_app.m_edit.m_update.enabled = True
	
	w_mdi.SetToolbarPos(3, 100, 400, 400, 1)
	
	w_mdi.SetToolbar(3, TRUE, Floating!, "")
	
	//-----------------APPEON BEGIN----------------------
	//<$>add long.zhang 04.23.2012
	//<$> Reason:	 The SetToolbarPos function is currently unsupported. 
	If appeongetclienttype() <> 'PB' Then
		long ll_handle
		ll_handle = handle(w_mdi)
		gnv_appeondll.of_SetToolbar( ll_handle , 3, True )  
		gnv_appeondll.of_settoolbarpos(ll_handle)
	End If
	//-----------------APPEOND END-----------------------
	w_train_app.st_msg.Text = " Click on each field you want to update then click the Update icon."
	w_train_app.st_msg.Visible = True
	ib_query_batch = true
else //called from update on the file menu
	w_train_app.st_msg.Visible = False
	of_query_batch_update( )
	of_select_field()
	m_pfe_train_app.m_edit.m_update.ToolbaritemVisible = False
	ib_query_batch = false
	of_enable_buttons( )   //Start Code Change ----03.23.2016 #V15 maha
end if
end event

event pfc_cst_select_scanner();of_scanner_select( )  //Start Code Change ----02.21.2008 #V8 maha -  added
end event

event pfc_refresh_annotations();of_refresh_page( )
end event

event pfc_delete_page();of_delete_pages()

end event

event pfc_insert_page();of_insert_pages()
end event

event pfc_searchapp();//////////////////////////////////////////////////////////////////////
// $<event> pfc_searchapp
// $<arguments>
// $<returns> integer
// $<description> V10.5-App Mapping
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.22.2010
//////////////////////////////////////////////////////////////////////

long ll_facility_id
long ll_app_id

open(w_search_for_app)
ll_app_id = message.doubleparm

// Find application
if ll_app_id > 0 then
	select facility_id into: ll_facility_id from app_hdr where app_id = :ll_app_id;	
	tab_1.tabpage_select.dw_app_tv.Event ue_Locate(ll_facility_id, ll_app_id)
end if
end event

event ue_open_template();//////////////////////////////////////////////////////////////////////
// $<event> ue_open_template
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_open_template( )

end event

event ue_save_mapping();//////////////////////////////////////////////////////////////////////
// $<event> ue_save_mapping
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

choose case il_mapping_type
	case 1 //TifForm
		of_save_mapping()
	case 2 //WebsiteForm (Evan 10.25.2011 - V12.1 Website Population)
		tab_1.tabpage_design.uo_sitefield_map.TriggerEvent("ue_save")
end choose
end event

event ue_cut();//////////////////////////////////////////////////////////////////////
// $<event> ue_cut
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_cut( )
end event

event ue_paste();//////////////////////////////////////////////////////////////////////
// $<event> ue_paste
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

if tab_1.selectedtab = 3 then
	of_paste( )
	st_msg.Visible = False
	st_msg.Text = "Click the position on the image where you want field placed."
	m_pfe_train_app.m_edit.m_copy.Enabled = True
end if

of_enable_buttons( )  //Start Code Change ----03.23.2016 #V15 maha
end event

event ue_remove_object();//////////////////////////////////////////////////////////////////////
// $<event> ue_remove_object
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

if il_mapping_type = 1 then //evan 11.17.2011
	of_remove_object()
end if
end event

event ue_copyfields();//////////////////////////////////////////////////////////////////////
// $<event> ue_copyfields
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

Long li_dummy[]
String ls_dummy[]

if of_check_for_image() = -1 then Return // Add by Evan 05.07.2009 --- Corrected BugS122711
//of_disable_buttons( ) //Start Code Change ----03.23.2016 #V15 maha  //Commented by (Appeon)Stephen 05.11.2016 - Bug ID #5149 for Case # 00063706: Issue Copying Fields to Another Page 

tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
ii_align = 0
ii_ancor_count = 0
is_selected_fields = ls_dummy
ii_x = li_dummy
ii_y = li_dummy
ii_copy_fields = 1	
tab_1.tabpage_design.ole_edit.object.AnnotationType( 11 )	

m_pfe_train_app.m_edit.m_cut.ToolbaritemVisible = False
m_pfe_train_app.m_edit.m_paste.Enabled = True
m_pfe_train_app.m_edit.m_copy.ToolbaritemVisible = False
//Start Code Change ----03.23.2016 #V15 maha
m_pfe_train_app.m_edit.m_update.ToolbaritemVisible = False  
m_pfe_train_app.m_edit.m_paste.ToolbaritemVisible =  True
//End Code Change ----03.23.2016

w_mdi.SetToolbarPos(3, 100, 400, 400, 1)

w_mdi.SetToolbar(3, TRUE, Floating!, "")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 04.10.2006 By: Cao YongWang
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
If appeongetclienttype() <> 'PB' Then
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbar(ll_handle , 3, true)
End if
//---------------------------- APPEON END ----------------------------

st_msg.Text = " Click on each field that you want to copy then click the PASTE icon."
st_msg.Visible = True

//tab_1.tabpage_design.ole_edit.object.AnnotationType( 0 )
end event

event ue_rope_select();//////////////////////////////////////////////////////////////////////
// $<event> ue_rope_select
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_rope_select()
end event

event ue_draw_box();//////////////////////////////////////////////////////////////////////
// $<event> ue_draw_box
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_draw_box()
end event

event ue_create_text();//////////////////////////////////////////////////////////////////////
// $<event> ue_create_text
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_Create_Text()
end event

event ue_auto_align_tops();//////////////////////////////////////////////////////////////////////
// $<event> ue_auto_align_tops
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_auto_align_tops()
end event

event ue_auto_align_sides();//////////////////////////////////////////////////////////////////////
// $<event> ue_auto_align_sides
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_auto_align_sides()
end event

event ue_clear_annos();//////////////////////////////////////////////////////////////////////
// $<event> ue_clear_annos
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_clear_annos( )
end event

event ue_next_page();//////////////////////////////////////////////////////////////////////
// $<event> ue_next_page
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_next_page()
end event

event ue_prior_page();//////////////////////////////////////////////////////////////////////
// $<event> ue_prior_page
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_prior_page( )
end event

event ue_preview_remove_object();//////////////////////////////////////////////////////////////////////
// $<event> ue_preview_remove_object
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_preview_remove_object( )
end event

event ue_preview_create_text();//////////////////////////////////////////////////////////////////////
// $<event> ue_preview_create_text
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

of_preview_create_text()
end event

event pfc_pop_website();//====================================================================
// $<event> pfc_pop_website()
// $<arguments>
// $<returns> integer
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 01.09.2012
//====================================================================

long ll_app_id
string ls_site_url
datawindow ldw_appl_detail
integer li_page

ldw_appl_detail = tab_1.tabpage_select.dw_appl_detail
if ldw_appl_detail.GetRow() < 1 then Return

ll_app_id = ldw_appl_detail.GetItemNumber(ldw_appl_detail.GetRow(), "app_id")
ls_site_url = ldw_appl_detail.GetItemString(ldw_appl_detail.GetRow(), "site_url")

if IsValid(w_intelliapp_popwebsite) then
	Close(w_intelliapp_popwebsite)
end if

Open(w_intelliapp_popwebsite)
li_page =  tab_1.tabpage_design.uo_sitefield_map.il_page

w_intelliapp_popwebsite.of_Populate(ll_app_id, ls_site_url)

w_intelliapp_popwebsite.of_setpage(li_page)
end event

public function long of_update_field (string as_groupname, long left, long top, long width1, long height1);//Start Code Change ---- 02.07.2006 # maha
DataWindowChild dwchild
Long li_tbl_id
String ls_query_fld
String ls_lookup_code
String ls_fld_type 
String ls_lookup_type
Long li_found
Long li_row_cnt
Long li_scroll_position_y
Long li_scroll_position_x
long li_current_app_field_id //modified 071802 maha
integer li_cnt

SetPointer( Arrow! )
//messagebox("","ofupdatefield")
//SetRedraw( False ) //avoiding screen blinks in web application

IF PosA( as_groupname, "Rectangle," ) > 0 THEN
	li_current_app_field_id = Long( MidA( as_groupname, 11, 100 ) )
	UPDATE app_field_prop  
   SET x_pos = :left,   
       y_pos = :top,   
       box_height = :height1,   
       box_width = :width1
	WHERE app_field_id = :li_current_app_field_id
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox("Database Error", tr_training_data.SQLERRTEXT )
	END IF		 
	//SetRedraw( True )	 //avoiding screen blinks in web application
	RETURN 1
END IF

IF tab_1.tabpage_design.dw_fld_prop.RowCount() > 0  THEN
	li_current_app_field_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber(1, "app_field_id" )
ELSE 
	li_current_app_field_id = 0
END IF

IF ii_app_field_id <>  li_current_app_field_id THEN
	IF tab_1.tabpage_design.dw_fld_prop.RowCount() > 0 THEN
		IF IsNull( tab_1.tabpage_design.dw_fld_prop.GetItemString(1, "field_description" ) )  THEN
			tab_1.tabpage_design.dw_fld_prop.DeleteRow( 1 )
			tab_1.tabpage_design.dw_fld_prop.Update()
			ib_new_field_selection = False
			ib_click_position = False
		END IF
	END IF

	tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
	if dwchild.RowCount() = 0 then dwchild.InsertRow(0)
	li_row_cnt = tab_1.tabpage_design.dw_fld_prop.Retrieve( ii_app_field_id )	
	//Start Code Change ----07.20.2009 #V92 maha -  if open get the current field
	if isvalid(w_app_prop_view) then w_app_prop_view.dw_prop.retrieve( ii_app_field_id )	
	//End Code Change---07.20.2009

	tab_1.tabpage_design.cb_apply.Visible = True
	IF ii_copy_fieldS = 0 THEN
		w_train_app.st_msg.Visible = False
	END IF
	IF li_row_cnt = 0 THEN
		MessageBox("Error", "The link between the IntelliApp Database and the Application image has been broken for this field. Refreshing annotations on this page.")   //Remove this field and place it again on the application image." )
		of_refresh_page( )   //Start Code Change ----03.15.2015 #V15 maha
		//w_select_fields.SetRedraw( True )		
		//SetRedraw( True )		 //avoiding screen blinks on web application
		Return 0
	END IF
	//Start Code Change ----09.25.2008 #V85 maha -  trap for fields from another application
	if tab_1.tabpage_design.dw_fld_prop.getitemnumber(1,"app_id") <> ii_app_id then
		MessageBox("Mapping Error", "This mapping field is not connected to this application.~rThis may have been caused by copying the original application image.~r~rRefreshing annotations on this page.") 
		of_refresh_page()   //Start Code Change ----03.15.2015 #V15 maha
	end if
	//End Code Change---09.25.2008
END IF

li_scroll_position_y = w_train_app.tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()
li_scroll_position_x = w_train_app.tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "x_pos", left + li_scroll_position_x )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "y_pos", top + li_scroll_position_y )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "annotation_width", width1 )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "height", height1 )
tab_1.tabpage_design.dw_fld_prop.AcceptText()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_design.dw_fld_prop.Update()

integer i

//Setup query fields
li_tbl_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "table_id" )
i = tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
dwchild.SetTransObject( SQLCA )
i = dwchild.Retrieve( li_tbl_id )
//query field


ls_query_fld = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "query_field" )
li_found = dwchild.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
	ls_fld_type = dwchild.GetItemString( li_found, "field_type" )
	of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value") //maha 042205
END IF
//address query field
i = tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field_addr", dwchild )
dwchild.SetTransObject( SQLCA )
i = dwchild.Retrieve( 20 )

ls_query_fld = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "query_field_addr" )
li_found = dwchild.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
	ls_fld_type = dwchild.GetItemString( li_found, "field_type" )
	of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value_addr") //maha 042205
END IF
*/
datawindowchild dwc_addr

li_tbl_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "table_id" )
tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
dwchild.SetTransObject( SQLCA )
tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field_addr", dwc_addr )
dwc_addr.SetTransObject( SQLCA )

gnv_appeondb.of_StartQueue()
tab_1.tabpage_design.dw_fld_prop.Update()
dwchild.Retrieve( li_tbl_id )
dwc_addr.Retrieve( 20 )
gnv_appeondb.of_CommitQueue()

//---------Begin Added by (Appeon)Stephen 04.14.2015 for V14.2 Bug # 4482  case# 00053227 - Address type is missing from the Filter Query Field and other issues--------
li_tbl_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "table_id" )
if li_tbl_id = 20 then
	li_cnt = dwchild.InsertRow(1)
	dwchild.setitem( li_cnt, "lookup_code", "Address Type" )
	dwchild.setitem( li_cnt, "field_name_allias", "Address Type" )
	dwchild.setitem( li_cnt, "field_name", "address_type" )
	dwchild.setitem( li_cnt, "lookup_type", "C" )
	dwchild.setitem( li_cnt, "field_type", "N" )
	
	//------------------- APPEON BEGIN -------------------
	//<$>comment:long.zhang 07.28.2017
	//<$>reason:Don't need to setitem, for Bug id 5735 - Partial address query when mapping new Address fields. 
//	if isnull(tab_1.tabpage_design.dw_fld_prop.getitemstring(1, "query_field")) or tab_1.tabpage_design.dw_fld_prop.getitemstring(1, "query_field") = '' then //(Appeon)Stephen 07.02.2015 - Bug id 4583 - Application Mapping, Copy Fields. SAAS Build 6/30/2015
//		tab_1.tabpage_design.dw_fld_prop.setitem(1, "query_field", "address_type")
//	end if
	//------------------- APPEON END -------------------	
end if 
//---------End Added ------------------------------------------------------

//query field
ls_query_fld = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "query_field" )
li_found = dwchild.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
	ls_fld_type = dwchild.GetItemString( li_found, "field_type" )
	of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value") //maha 042205
END IF

//address query field
ls_query_fld = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "query_field_addr" )
li_found = dwc_addr.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = dwc_addr.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = dwc_addr.GetItemString( li_found, "lookup_type" )
	ls_fld_type = dwc_addr.GetItemString( li_found, "field_type" )
	of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value_addr") //maha 042205
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-04
//$<Modify> 02.23.2006 By: Liang QingShi
//$<reason> VerticalScrollPosition is currently unsupported.
//$<modification> Comment out the following script.

//set position of datawindow object
/*IF li_last_fld_prop_tab = 1 THEN	
	tab_1.tabpage_design.dw_fld_prop.Object.DataWindow.VerticalScrollPosition='0'
ELSEIF li_last_fld_prop_tab = 2 THEN
	tab_1.tabpage_design.dw_fld_prop.Object.DataWindow.VerticalScrollPosition='580'
ELSEIF li_last_fld_prop_tab = 3 THEN
	tab_1.tabpage_design.dw_fld_prop.Object.DataWindow.VerticalScrollPosition='1340'
ELSEIF li_last_fld_prop_tab = 4 THEN	
	tab_1.tabpage_design.dw_fld_prop.Object.DataWindow.VerticalScrollPosition='2000'
END IF
*/
IF li_last_fld_prop_tab = 2 THEN
	long ll_table_id
	if tab_1.tabpage_design.dw_fld_prop.rowcount() > 0 then
		ll_table_id = tab_1.tabpage_design.dw_fld_prop.getitemnumber(tab_1.tabpage_design.dw_fld_prop.getrow(),'table_id')
	end if
	if ll_table_id = 20 then
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_poq.visible = 1")
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_aoq.visible = 1")
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_haq.visible = 1")
	else
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_poq.visible = 0")
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_aoq.visible = 0")
		tab_1.tabpage_design.dw_fld_prop.Modify( "b_haq.visible = 0")		
	end if		
end if
//---------------------------- APPEON END ----------------------------

//SetRedraw( True )	//avoiding screen blinks on web application
	
tab_1.tabpage_design.dw_fld_prop.BringToTop = True	
//Start Code Change ----05.02.2016 #V15 maha
tab_1.tabpage_design.cb_apply.BringToTop  = True
tab_1.tabpage_design.cb_fast.BringToTop  = True
//End Code Change ----05.02.2016
	
Return 0
end function

public function long of_align (string as_align_type);Long li_selected_cnt
Long li_rc
Long i
Long li_font_size
Long li_field_len
Long li_dummy[]
Long li_prev_scrollY
Long li_prev_scrollX
//Start Code Change ---- 01.31.2006 #227 maha
long li_newx //maha 120605
long li_newy //maha 120605
long li_sx //maha 120605
long li_sy //maha 120605
String ls_object_type 
String ls_stamp_text
String ls_font_name
String ls_field_type
String ls_lookup_link_type
String ls_lookup_link_field
String ls_fld_display
String ls_dummy[]
String ls_special_field

if of_check_for_image() = -1 then return -1//maha 031505

//This.SetRedraw( False )  //avoiding screen blinks on web application

li_selected_cnt = UpperBound( is_selected_fields )

li_prev_scrollY = tab_1.tabpage_design.ole_edit.object.ScrollPositionY( )
li_prev_scrollX = tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )
//Start Code Change ---- 05.04.2006 #438 maha
//tab_1.tabpage_design.ole_edit.object.ScrollImage(1,li_prev_scrollY)
//End Code Change---05.04.2006
FOR i = 1 TO li_selected_cnt
	ls_object_type = ""
	//MessageBox("ii_app_field_id",is_selected_fields[i])
	IF Upper(RightA( is_selected_fields[i], 6 )) = "YESBOX" THEN
		ii_app_field_id = long( MidA( is_selected_fields[i], 1, LenA( is_selected_fields[i] ) - 6) )
	ELSEIF Upper(RightA( is_selected_fields[i], 5 )) = "NOBOX" THEN
		ii_app_field_id = long( MidA( is_selected_fields[i], 1, LenA( is_selected_fields[i] ) - 5) )	
	ELSEIF Upper(LeftA( is_selected_fields[i], 3 )) = "SP-" THEN		
		ii_app_field_id = long( MidA( is_selected_fields[i], PosA( is_selected_fields[i], "," ) + 1, 100 ) )
	ELSEIF Upper(RightA( is_selected_fields[i], 5 )) = "CHECK" THEN		
		ii_app_field_id = long( MidA( is_selected_fields[i], 1, LenA( is_selected_fields[i] ) - 5) )	
		ls_object_type = "Check"
	ELSEIF Upper(LeftA( is_selected_fields[i], 5 )) = "LABEL" THEN	//maha for labels 091404
		integer lp = 1, nlp
		lp = 1 //added by evan 04.28.2012
		do while lp > 0 //find the location of the last ;
			lp = PosA(is_selected_fields[i],";",lp + 1)
			if lp > 0 then nlp = lp
		loop
		ii_app_field_id = long( MidA( is_selected_fields[i], nlp + 1, LenA( is_selected_fields[i] )) )	
		ls_object_type = "Label"
	ELSE
		ii_app_field_id = long( is_selected_fields[i] )
	END IF	

	//tab_1.tabpage_design.dw_fld_prop.SetTransObject( tr_training_data )
//MessageBox("ii_app_field_id",ii_app_field_id)
	li_rc = tab_1.tabpage_design.dw_fld_prop.Retrieve( ii_app_field_id )
	
	IF li_rc = 0 THEN
		MessageBox("Align", "Error during alignment, please retry." )
		This.SetRedraw( True )
		Return -1
	END IF

	//Handle special fields
	IF Upper(LeftA( is_selected_fields[i], 3 )) = "SP-" THEN		
		ls_special_field = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_description" )		
		IF PosA( ls_special_field, "Todays Date" ) > 0 THEN
			ls_fld_display = "MM/DD/YYYY"
		ELSEIF PosA( ls_special_field, "Current Time" ) > 0 THEN			
			ls_fld_display = "HH:MMa"
		ELSEIF PosA( ls_special_field, "User Id" ) > 0 THEN			
			ls_fld_display = "XXXXXXXXXX"
		ELSEIF PosA( ls_special_field, "Future Date" ) > 0 THEN			
			ls_fld_display = "FUTURE DATE"
		ELSEIF PosA( ls_special_field, "Signature" ) > 0 THEN	//added by long.zhang 04.20.2012 Fixed a detect BugL042001
			of_draw_signature( ii_x[i],ii_y[i],as_align_type, is_selected_fields[i] )
			continue
		END IF	
	END IF
	//debugbreak()
	if ls_object_type <> "Label" then //maha label trap 091404
		ls_object_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "object_type" )
	end if
	if ls_object_type <> "Label" then //maha label trap 091404
		ls_field_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "sys_fields_field_type" )	
	else
		ls_field_type = ls_object_type
	end if
	ls_lookup_link_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_type" )
	ls_lookup_link_field = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_field" )
	li_field_len = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "width" )	
	IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
		ls_field_type = "C"
		IF ls_lookup_link_type = "A" THEN
			w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->address_lookup->" + ls_lookup_link_field
		ELSE
			w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->code_lookup->" + ls_lookup_link_field				
		END IF
	END IF

	CHOOSE CASE Upper( ls_field_type )
		CASE "C"
			IF ls_object_type = "C" THEN
				ls_fld_display = FillA( "X", 1 )
			ELSE
				ls_fld_display = FillA( "x", li_field_len )
			END IF
		CASE "I"
			ls_fld_display = FillA( "#", li_field_len )				
		CASE "D"
			ls_fld_display = "mm/dd/yyyy"
		CASE "N"
			ls_fld_display = FillA( "#", li_field_len )
		CASE "LABEL" //maha091404
			//---------- APPEON BEGIN ----------
			//$<modify> Evan 04.28.2012
			//$<reason> The text be truncated.
			//integer li
			//li = 	LenA(is_selected_fields[i]) - 6 - LenA(MidA(is_selected_fields[i],nlp)) //get the length of just the text
			//ls_fld_display = MidA( is_selected_fields[i],7,li )
			ls_fld_display = MidA(tab_1.tabpage_design.dw_fld_prop.GetItemString(1, "field_description"), 7, 240)  //Start Code Change ----08.26.2015 #V15 maha - changed from 100
			//---------- APPEON END ------------
	END CHOOSE

	IF LenA(ls_fld_display) > 255 THEN ls_fld_display = LeftA(ls_fld_display, 255) //limit 260 - alfee 11.03.2009
	
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( is_selected_fields[i] )
	tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( is_selected_fields[i] )
	tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
	tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
	CHOOSE CASE tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "font_size" )
		CASE 1
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
		CASE 2
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
		CASE 3
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
	END CHOOSE
	IF tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "font_bold" ) = 1 THEN
		tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
	ELSE
		tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
	END IF	
	tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
	//maha 120605
	li_sx = tab_1.tabpage_design.ole_edit.object.ScrollPositionx()
	li_sy = tab_1.tabpage_design.ole_edit.object.ScrollPositionY()
	//messagebox(string(i),string(ii_y[i]))
	li_newy = ii_y[i] - li_sy
	li_newx = ii_x[i] - li_sx
	//messagebox(string(i),string(li_newy))
	IF as_align_type = "Top" THEN
		tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
		//tab_1.tabpage_design.ole_edit.object.Draw( ii_x[i], ii_ancor_y,  0, 0)
		tab_1.tabpage_design.ole_edit.object.Draw( li_newx, ii_ancor_y,  0, 0)
	ELSE
		tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )
		//tab_1.tabpage_design.ole_edit.object.Draw( ii_ancor_x, ii_y[i],  0, 0)
		tab_1.tabpage_design.ole_edit.object.Draw( ii_ancor_x, li_newy,  0, 0)
	END IF

//End Code Change---01.31.2006
	tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
END FOR

//ii_align = 0
ii_ancor_count = 0
is_selected_fields = ls_dummy
ii_x = li_dummy
ii_y = li_dummy
tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
//tab_1.tabpage_design.cbx_align.Enabled = False

tab_1.tabpage_design.ole_edit.object.ScrollPositionY( li_prev_ScrollY )
tab_1.tabpage_design.ole_edit.object.ScrollPositionX( li_prev_ScrollX )
//Start Code Change ---- 05.04.2006 #438 maha
//tab_1.tabpage_design.ole_edit.object.ScrollImage(0,li_prev_scrollY)
//End Code Change---05.04.2006
//This.SetRedraw( True )  // avoiding screen blinks on web application

of_setup_align( )

w_mdi.SetToolbar( 4, False, Floating!)		
w_mdi.SetToolbarPos( 4, 75, 400, 100, 1)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.

If appeongetclienttype() <> 'PB' Then
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_SetToolbar( ll_handle , 4, False )		
	gnv_appeondll.of_settoolbarpos(ll_handle)
End If
//---------------------------- APPEON END ----------------------------

Return 0
end function

public function long of_copy_fields ();//called from of_paste
Long li_null
Long li_next_id
Long li_new_page
Long li_rec_no
Long li_selected_cnt
long li_last_app_field_id  //modified 071802 maha
Long i
Long li_x
Long li_y
Long li_font_size
Long li_field_len
Long li_dummy[]
Long li_prev_scrollY
Long li_prev_scrollX
Long li_first_fld_x
Long li_first_fld_y
Long li_new_x
Long li_new_y
String ls_object_type
String ls_copy_type
String ls_stamp_text
String ls_font_name
String ls_field_type
String ls_lookup_link_type
String ls_lookup_link_field
String ls_fld_display
String ls_dummy[]


//This.SetRedraw( False )	  //avoiding screen blinks on web application

SetNull( li_null )

w_train_app.of_disable_buttons()
//w_select_fields.Visible = False

ii_copy_fields = 0
ii_align = 0

li_selected_cnt = UpperBound( is_selected_fields )  // I made it -1 because it made it work but not sure why???

li_prev_scrollY = tab_1.tabpage_design.ole_edit.object.ScrollPositionY( )
li_prev_scrollX = tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )

//SELECT Max( connect_field_id )  
//INTO :li_next_id  
//FROM app_field_prop 
//WHERE app_id = :ii_app_id;
//
//li_next_id++
//This.SetRedraw( False )
//messagebox("", li_selected_cnt )

if gi_test_mode = 1 then
	messagebox("Field count",li_selected_cnt)
end if

FOR i = 1 TO li_selected_cnt
	//Start Code Change ---- 06.05.2006 #512 maha  //replaced with function
	ii_app_field_id = of_get_app_field_id(is_selected_fields[i])
	
//	IF Upper(Right( is_selected_fields[i], 6 )) = "YESBOX" THEN
//		ii_app_field_id = long( Mid( is_selected_fields[i], 1, Len( is_selected_fields[i] ) - 6) )
//	ELSEIF Upper(Right( is_selected_fields[i], 5 )) = "NOBOX" THEN
//		ii_app_field_id = long( Mid( is_selected_fields[i], 1, Len( is_selected_fields[i] ) - 5) )	
//	ELSEIF Upper(Left( is_selected_fields[i], 3 )) = "SP-" THEN		
//		ii_app_field_id = long( Mid( is_selected_fields[i], Pos( is_selected_fields[i], "," ) + 1, 100 ) )
//	ELSEIF Upper(Right( is_selected_fields[i], 5 )) = "CHECK" THEN		
//		ii_app_field_id = long( Mid( is_selected_fields[i], 1, Len( is_selected_fields[i] ) - 5) )	
//	ELSE
//		ii_app_field_id = long( is_selected_fields[i] )
//	END IF
	//End Code Change---06.05.2006


	//tab_1.tabpage_design.dw_fld_prop.DataObject = ""
	//tab_1.tabpage_design.dw_fld_prop.DataObject = is_select_field_dw
	//tab_1.tabpage_design.dw_fld_prop.SetTransObject( tr_training_data )	
	tab_1.tabpage_design.dw_fld_prop.Retrieve( ii_app_field_id )
 	IF tab_1.tabpage_design.dw_fld_prop.RowCount( ) < 1 THEN return -1  //(Appeon)Stephen 06.13.2014  from 'return 0' to 'return -1'- Can't copy a text field in App Mapping //Nova 08.28.2009
 	IF i = 1 THEN
		IF tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "table_id" ) = 99 then return -1  //(Appeon)Stephen 06.13.2014  from 'return 0' to 'return -1'- Can't copy a text field in App Mapping //Nova 08.28.2009
		li_rec_no = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "record_number" )		
		li_rec_no++

		OpenWithParm( w_get_query_data, String( ii_app_field_id ) )
		//Start Code Change ---- 05.24.2006 #481 maha
		if message.stringparm = "Cancel" then return 0
		//End Code Change---05.24.2006
		//li_rec_no = Long( Message.StringParm )
		IF li_selected_cnt > 1 THEN
			IF (ii_y[2] > ii_y[1] + 10) OR (ii_y[2] < ii_y[1] - 10) THEN
				ls_copy_type = "Vertical"
			ELSE
				ls_copy_type = "Horizontal"
			END IF
		END IF
		tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
		ib_click_position = True
		st_msg.Text = "Click the position on the image where you want to place copy of fields."
		st_msg.Visible = True
		tab_1.tabpage_design.ole_edit.object.AnnotationType( 0 )
		tab_1.tabpage_design.ole_edit.object.SelectionRectangle( True )		
		//This.SetRedraw( True )		//avoiding screen blinks on web application
		DO WHILE ib_click_position
			Yield()
		LOOP
		//This.SetRedraw( False )			//avoiding screen blinks on web application
		ib_click_position = False
		tab_1.tabpage_design.ole_edit.object.AnnotationType( 11 )
	END IF

	tab_1.tabpage_design.dw_fld_prop.RowsCopy( 1, 1, Primary!, tab_1.tabpage_design.dw_fld_prop, 100, Primary! )

	SELECT Max( app_field_id )  
	INTO :li_last_app_field_id  
	FROM app_field_prop  
	USING tr_training_data;		

	li_new_page = tab_1.tabpage_design.ole_edit.object.Page()

	li_last_app_field_id++
	
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "app_field_id", li_last_app_field_id )
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "page", li_new_page )

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 08.16.2016
	//<$>reason:Issue Application Mapping
	If ii_cf_skip_record_number = 0 Then
		tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "record_number", ii_cf_record_number )	
	End If
	//------------------- APPEON END -------------------
	
//Start Code Change ---- 06.14.2006 #540 maha
	if ii_cf_skip_query = 0 then //do not set if set to record num only
		tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "query_field", ii_cf_query_field )	
		tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "query_operator", ii_cf_query_operator )	
		tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "query_value", ii_cf_query_value )	
	end if
//End Code Change---06.14.2006
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "past_years_query", ii_cf_past_years_query )
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "connect_field_id", li_null )			
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "connect_field_sort", li_null )		
	
	tab_1.tabpage_design.dw_fld_prop.SetItem( 2, "start_char", ii_start_char )  //Start Code Change ----06.06.2011 #V11 maha 
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 04.04.2006 By: Rodger Wu
	//$<reason> Performance Tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	tab_1.tabpage_design.dw_fld_prop.Update()
	ii_app_field_id = li_last_app_field_id  
	//tab_1.tabpage_design.dw_fld_prop.DataObject = ""
	//tab_1.tabpage_design.dw_fld_prop.DataObject = is_select_field_dw
	//tab_1.tabpage_design.dw_fld_prop.SetTransObject( tr_training_data )		
	tab_1.tabpage_design.dw_fld_prop.Retrieve( ii_app_field_id )	
	*/
	ii_app_field_id = li_last_app_field_id
	gnv_appeondb.of_StartQueue()
	tab_1.tabpage_design.dw_fld_prop.Update()
	tab_1.tabpage_design.dw_fld_prop.Retrieve( li_last_app_field_id )
	gnv_appeondb.of_CommitQueue()
	//---------------------------- APPEON END ----------------------------

	IF tab_1.tabpage_design.dw_fld_prop.RowCount( ) = 0 THEN
		MessageBox("Copy Error", "Error Copying field " + String( ii_app_field_id ) )
		Continue
	END IF
	ls_field_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "sys_fields_field_type" )
	ls_object_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "object_type" )
	li_x = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "x_pos" )
	li_y = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "y_pos" )
	IF i = 1 THEN
		li_first_fld_x = li_x
		li_first_fld_Y = li_y
	END IF
	ls_lookup_link_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_type" )
	ls_lookup_link_field = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_field" )
	li_field_len = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "width" )	
	IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
		ls_field_type = "C"
		IF ls_lookup_link_type = "A" THEN
			w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->address_lookup->" + ls_lookup_link_field
		ELSE
			w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->code_lookup->" + ls_lookup_link_field				
		END IF
	END IF


	tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
	tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )			



	
//Start Code Change ---- 12.05.2005 #161 maha	
	li_new_x = li_x + (ii_copy_ancor_x - li_first_fld_x ) 
	li_new_x = li_new_x - tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )
	
	li_new_y = li_y + (ii_copy_ancor_y - li_first_fld_y ) 
	li_new_y = li_new_y - tab_1.tabpage_design.ole_edit.object.ScrollPositiony( )
//End Code Change---12.05.2005

//	tab_1.tabpage_design.ole_edit.object.Draw( li_new_x, li_new_y,  0, 0)

	
	
CHOOSE CASE ls_object_type
	CASE "T"
		//ii_app_field_id = ii_app_field_id
		//ls_field_type = dw_fld_prop.GetItemString( 1, "sys_fields_field_type" )
		//ls_lookup_link_type = dw_fld_prop.GetItemString( 1, "lookup_link_type" )
		//ls_lookup_link_field = dw_fld_prop.GetItemString( 1, "lookup_link_field" )
		IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
			ls_field_type = "C"
			IF ls_lookup_link_type = "A" THEN
				w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->address_lookup->" + ls_lookup_link_field 
			ELSE
				w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->code_lookup->" + ls_lookup_link_field		
			END IF
		END IF
		CHOOSE CASE Upper( ls_field_type )
			CASE "C"
				ls_fld_display = FillA( "x", li_field_len )
			CASE "I"
				ls_fld_display = FillA( "#", li_field_len )				
			CASE "D"
				ls_fld_display = "mm/dd/yyyy"
			CASE "N"
				ls_fld_display = FillA( "#", li_field_len )								
		END CHOOSE
		
		IF LenA(ls_fld_display) > 255 THEN ls_fld_display = LeftA(ls_fld_display, 255) //limit 260 - alfee 11.03.2009
		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(ii_app_field_id) )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
		CHOOSE CASE tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 5				
				END IF
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 8
				END IF
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12		
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 10
				END IF
		END CHOOSE
		IF tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "font_bold" ) = 1 THEN
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x, li_new_y, 0, 0)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	CASE "B"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( tab_1.tabpage_design.dw_fld_prop.GetItemNumber( tab_1.tabpage_design.dw_fld_prop.GetRow(), "field_id" ) )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x, li_new_y, 20,20)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)			
	CASE "Y1"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(ii_app_field_id) + "YesBox")
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 255 )		
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x, li_new_y, 20,20)
		

		//no
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(ii_app_field_id) + "NoBox")
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 0 )
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x + 30, li_new_y, 20,20)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)					
	CASE "Y2"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(ii_app_field_id) + "YesCheck")
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x, li_new_y, 10,10)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)							
	CASE "C"		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String( ii_app_field_id ) + "Check" )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		CHOOSE CASE tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 5				
				END IF
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8			
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 8	
				END IF
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 10
				END IF
		END CHOOSE
		tab_1.tabpage_design.ole_edit.object.Draw(li_new_x, li_new_y, 10,10)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
END CHOOSE
	
	
	tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
END FOR

ii_cf_skip_query = 0 //reset the value //Start Code Change ---- 06.14.2006 #540 maha
ii_cf_skip_record_number = 0 //reset the value, Added by Appeon long.zhang 08.16.2016 (Application Mapping)

tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( li_new_y )
tab_1.tabpage_design.ole_edit.object.ScrollPositionX( li_prev_ScrollX )

w_train_app.of_enable_buttons()
//w_select_fields.Visible = True

st_msg.Visible = False
ib_saved = False

//This.SetRedraw( True )	//avoiding screen blinks on web application

Return 0
end function

public function long of_add_objects (string ls_object, long ai_font, long ai_bold);String ls_type
String ls_text
Long li_app_id
Long ll_field_id
Long li_page
try

li_page = w_train_app.ii_current_page
li_app_id = w_train_app.ii_app_id

if of_check_for_image() = -1 then return -1//maha 031505

SELECT Max( app_field_id )  
INTO :ll_field_id  
FROM app_field_prop 
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox("Database Error", tr_training_data.SQLERRTEXT )
END IF
ll_field_id++

CHOOSE CASE Upper( ls_object )
	CASE "TODAYS DATE"
		ls_type = "Todays Date"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-TODAYSDATE," + String( ll_field_id ) )		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "MM/DD/YYYY" )		
	CASE "CURRENT TIME"
		ls_type = "Current Time"		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-CURRENTTIME," + String( ll_field_id ))				
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "HH:MMa" )		
	CASE "USER ID"
		ls_type = "User Id"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERID," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Id" )
	CASE "USER NAME"  //Start Code Change ----04.08.2013 #V12 maha
		ls_type = "User Name"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERNAME," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Name" )	
	CASE "USER EMAIL"  //Start Code Change ----04.08.2013 #V12 maha
		ls_type = "User Email"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USEREMAIL," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Email" )	
	CASE "SIGNATURE"	// E-Sign : added by long.zhang 06.13.2011
		ls_type = "Signature"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-SIGNATURE," + String( ll_field_id ))	
		IF AppeonGetClientType() = "PB" THEN
			tab_1.tabpage_design.ole_edit.Object.AnnotationImage = Gs_Current_Directory + "\Signature.jpg"
		ELSE
			tab_1.tabpage_design.ole_edit.Object.AnnotationImage = tab_1.tabpage_merge.uo_create_app11.of_get_signaturepath()
		END IF
		tab_1.tabpage_design.ole_edit.Object.AnnotationFillStyle(0)
		tab_1.tabpage_design.ole_edit.Object.AnnotationType(5)
		tab_1.tabpage_design.ole_edit.Object.Draw(0,0)
		tab_1.tabpage_design.ole_edit.Object.SelectTool(1)	
	CASE "FUTURE DATE" ////Start Code Change ----09.26.2011 #V12 maha
		open (w_future_days)
		ls_text = message.stringparm
		ls_type = "Future Date" + ls_text + "@"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-FUTUREDATE," + String( ll_field_id ) )		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "FUTUREDATE" + ls_text )	
	//Start Code Change ----11.03.2016 #V153 maha
	CASE "USER STREET" 
		ls_type = "User Street"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTREET," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Street" )		
	CASE "USER STREET2" 
		ls_type = "User Stree2"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTREE2," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Street2" )		
	CASE "USER CITY" 
		ls_type = "User City"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERCITY," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User City" )
	CASE "USER STATE" 
		ls_type = "User State"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTATE," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User State" )	
	CASE "USER ZIP" 
		ls_type = "User Zip"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERZIP," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Zip" )	
	CASE "USER PHONE" 
		ls_type = "User Phone"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERPHONE," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Phone" )	
	CASE "USER FAX" 
		ls_type = "User Fax"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERFAX," + String( ll_field_id ))		
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Fax" )	
	//Start Code Change ----11.03.2016
	CASE ELSE
		//debugbreak()
		ls_type = ls_object   //Upper( Mid( ls_object, 7, 100 ) )
		ls_text = MidA( ls_object, 7, 240 )    //Start Code Change ----08.26.2015 #V15 maha - changed from 100
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "LABEL-" + MidA( ls_text, 1, 5 ) + ";" + String( ll_field_id ))	//maha changed from 20 031405	
		tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( ls_text  )
END CHOOSE

	  INSERT INTO app_field_prop  
         ( app_field_id,   
           app_id,   
           table_id,   
           field_id,   
           lookup_link_type,   
           lookup_link_field,   
           record_number,   
           x_pos,   
           y_pos,   
           width,   
           query_field,   
           query_value,   
           page,   
           box_type,   
           box_height,   
           box_width,   
           box_yes_x,   
           box_yes_y,   
           box_yes_value,   
           box_no_x,   
           box_no_y,   
           box_no_value,   
           font_type,   
           font_size,   
           font_color,   
           font_background,   
           font_underline,   
           font_bold,   
           query_operator,   
           field_description,   
           personal_data,   
           height,   
           annotation_width,   
           past_years_query,   
           format,   
           connect_field_id,   
           connect_field_sort )  
  VALUES ( :ll_field_id,   
           :li_app_id,   
           99,   
           0,   
           null,   
           null,   
           null,   
           0,   
           0,   
           null,   
           null,   
           null,   
           :li_page,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
			  null,
           :ai_font,   
           null,   
           null,   
           null,   
           :ai_bold,   
           null,   
           :ls_type,   
           'N',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )
		 USING tr_training_data;
		IF tr_training_data.SQLCODE = -1 THEN
			MessageBox("Database Error", tr_training_data.SQLERRTEXT )
		END IF
IF ls_type = "Signature" THEN Return 1	//E-Sign: added by long.zhang 06.13.2011
tab_1.tabpage_design.ole_edit.Object.AnnotationFontColor(255)
tab_1.tabpage_design.ole_edit.Object.Annotationtype(8)		
CHOOSE CASE ai_font
	CASE 1
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Name = "MS Serif"
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Size = 7
	CASE 2
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Size = 8				
	CASE 3
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Name = "Times New Roman"
		tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Size = 12
END CHOOSE
IF ai_bold = 1 THEN
	tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Bold = True
ELSE
	tab_1.tabpage_design.ole_edit.Object.AnnotationFont.Bold = False
END IF

tab_1.tabpage_design.ole_edit.Object.Draw( 0, 0, 0, 0 )
tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	

catch (runtimeerror ret)
	
end try
Return 1
end function

public function long of_load_image ();Long li_page_cnt
string ls_file

ls_file = is_app_path + String( ii_app_id ) + ".tif"
//$<reason> Download image file from Database.
n_appeon_storage_area lnv_storage_area
w_mdi.setredraw(false)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
lnv_storage_area.of_retrieve_image_from_db( ii_app_id, ls_file) 
w_mdi.setredraw(true)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
	
tab_1.tabpage_design.ole_edit.Object.Image(ls_file)
tab_1.tabpage_design.ole_edit.Object.Page(1)
tab_1.tabpage_design.ole_edit.Object.FitTo(3)
tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	
//Start Code Change ---- 11.10.2005 #84 maha
tab_1.tabpage_design.ole_edit.Object.DisplayScaleAlgorithm = 4
//End Code Change---11.10.2005 

if not fileexists(ls_file) then 
	messagebox("File does not exist",ls_file)
	return -1
end if

//Start Code Change ---- 05.05.2005 #437 maha
try
tab_1.tabpage_design.ole_edit.Object.Display()
catch (runtimeerror a)
end try
//End Code Change---05.05.2005
tab_1.tabpage_design.ole_edit.Object.ImageResolutionx( 300 )
tab_1.tabpage_design.ole_edit.Object.ImageResolutionY( 300 )
ii_current_page = 1

w_mdi.setredraw(false)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
of_delete_annotations()
of_load_annotations()

li_page_cnt = tab_1.tabpage_design.ole_edit.Object.PageCount()
ii_page_count = li_page_cnt

if isvalid(m_pfe_train_app) then //add by stephen 08.07.2012 -bug 3221 Null object reference for m_pfe_train_app
	IF li_page_cnt = 1 THEN
		m_pfe_train_app.m_view.m_nextpage.enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	elseif 	li_page_cnt > 1 then	//long.zhang 01.16.2013 Bug 3386 
		m_pfe_train_app.m_view.m_nextpage.enabled = true
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	END IF
	m_pfe_train_app.m_view.m_priorpage.enabled = False
	tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
end if

st_page_num.Text =  "Page 1 Of " +  String(li_page_cnt)
	
tab_1.tabpage_design.uo_preview.of_load_app()
//--------Begin Commented by  Nova 08.27.2009------------------------
//tab_1.tabpage_design.uo_preview.ole_edit.Object.HideAnnotationGroup()
//--------End Commented --------------------------------------------
w_mdi.setredraw(true)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
	
Return 1
end function

public function long of_delete_annotations ();//Long li_Cnt
//li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()
////
//IF li_cnt = 0 THEN
//	Return  0
//END IF
////
////tab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ii_app_id ) + "-" +String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 1 )
////
////tab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ii_app_id ) + ".ano",ii_current_page ,ii_current_page , 1 )
//
//Long i
//String ls_annotation_group
////Long li_cnt
////
//IF tab_1.tabpage_design.ole_edit.Object.Image = "" THEN
//	Return 0
//END IF
////
////IF tab_1.tabpage_design.p_rec_num.BorderStyle = StyleLowered! THEN
////	tab_1.tabpage_design.p_rec_num.BorderStyle = StyleRaised!
////	of_delete_records()
////END IF
////
////This.SetRedraw( False )
////
//tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
////
//li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()
////
//FOR i = 0 TO li_cnt -1
//	ls_annotation_group = tab_1.tabpage_design.ole_edit.Object.GetAnnotationGroup( 0 )
//	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ls_annotation_group )		
//END FOR
////
////This.SetRedraw( True )
////
Return 0

end function

public function long of_load_annotations ();SetPointer( HourGlass! )
integer li_anno_cnt
integer li_fld_cnt

//IF FileExists( is_app_path + String( ii_app_id ) +  "-" + String( ii_current_page ) + ".ano" ) THEN
//	tab_1.tabpage_design.ole_edit.object.LoadAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 0 )
//ELSE
//	of_create_annotations( 0 )
//END IF
//debugbreak()

if of_check_for_image() = -1 then return -1//maha 031505

//Start Code Change ----01.20.2009 #V92 maha - added auto regenerate if annos out of sync
li_anno_cnt = tab_1.tabpage_design.ole_edit.object.AnnotationGroupCount( )

IF li_anno_cnt  = 0 THEN
	of_create_annotations( 0 )
ELSE  //maha added to auto regenerate page if out of sync
	select count(app_field_id) into :li_fld_cnt from app_field_prop where app_id = :ii_app_id and page = :ii_current_page;
	if li_fld_cnt <> li_anno_cnt then
		//messagebox("Not equal","Regenerating.")
		of_refresh_page( )
	end if
END IF
//End Code Change---01.20.2009

RETURN 0


end function

public function long of_disable_buttons ();w_train_app.tab_1.tabpage_design.dw_buttons.enabled = False  //Start Code Change ----03.23.2016 #V15 maha	
cb_preview.visible = false
	
	Return 0
end function

public function long of_enable_buttons ();w_train_app.tab_1.tabpage_design.dw_buttons.enabled = true  //Start Code Change ----03.23.2016 #V15 maha
cb_preview.visible = true

	RETURN 0
end function

public function long of_show_record ();String ls_rec_num
Long li_x_pos
Long li_y_pos
Long li_rec_num
Long ll_scroll_pos_y


//This.SetRedraw( False )	//avoiding screen blinks on web application

ib_loading_annotations = True

DECLARE g_show_record_num CURSOR FOR  
SELECT app_field_prop.x_pos,   
       app_field_prop.y_pos,
		 app_field_prop.record_number
FROM app_field_prop  
WHERE ( app_field_prop.app_id = :ii_app_id ) AND  
      ( app_field_prop.page = :ii_current_page )   
USING tr_training_data;
		
OPEN g_show_record_num;

FETCH g_show_record_num INTO :li_x_pos, :li_y_pos, :li_rec_num;

ll_scroll_pos_y = tab_1.tabpage_design.ole_edit.Object.ScrollPositionY( )		

tab_1.tabpage_design.ole_edit.Object.ScrollPositionY( 1 )		

tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "rec_num" )		

IF IsNull( li_rec_num ) OR li_rec_num = 0 THEN
	CLOSE g_show_record_num;
	//This.SetRedraw( True )	//avoiding screen blinks on web application
	tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
	ib_loading_annotations = False
	RETURN -1
END IF

DO WHILE tr_training_data.SQLCODE = 0 
    li_y_pos = li_y_pos - 5 -  tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()
    ls_rec_num = String( li_rec_num )
    tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( ls_rec_num )		
    tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(8404992)
    tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
    tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
    tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
    tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)		 
    FETCH g_show_record_num INTO :li_x_pos, :li_y_pos, :li_rec_num;	
LOOP

CLOSE g_show_record_num;

tab_1.tabpage_design.ole_edit.Object.ScrollPositionY( ll_scroll_pos_y )		
//This.SetRedraw( True )	//avoiding screen blinks on web application

tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )

ib_loading_annotations = False



Return 0
end function

public function long of_delete_records ();if of_check_for_image() = -1 then return -1//maha 031505

tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "rec_num" )		

Return 0
end function

public function Long of_save_load ();tab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 0 )
tab_1.tabpage_design.ole_edit.object.LoadAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 0 )

RETURN 0
end function

public function long of_auto_align ();

String ls_rec_num
String ls_dummy[]
Long li_x_pos
Long li_y_pos
Long li_rec_num
long li_field_id //modified 071802 maha
Long ll_top_mark
Long ll_bottom_mark
Long ll_y
Long ll_x
Long ll_height
long li_dummy[] //modified 071802 maha
Long li_scroll_position_y
Long li_scroll_position_x

if of_check_for_image() = -1 then return -1//maha 031505

ib_saved = False

li_scroll_position_y = w_train_app.tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()
li_scroll_position_x = w_train_app.tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()

ii_app_field_ids[] = li_dummy[]
is_selected_fields[] = ls_dummy[]

SELECT app_field_prop.y_pos  
INTO :ll_y  
FROM app_field_prop  
WHERE app_field_prop.app_field_id = :ii_app_field_id   ;

ii_ancor_y = ll_y - li_scroll_position_y


ll_top_mark = ll_y - 12
ll_bottom_mark = ll_y + 12

DECLARE g_show_record_num CURSOR FOR 
SELECT app_field_prop.app_field_id, app_field_prop.x_pos  , app_field_prop.y_pos , app_field_prop.height   
FROM app_field_prop  
WHERE ( app_field_prop.app_id = :ii_app_id ) AND  
      ( app_field_prop.page = :ii_current_page ) AND
	 ( app_field_prop.y_pos >= :ll_top_mark AND app_field_prop.y_pos <= :ll_bottom_mark ) AND
	 ( app_field_prop.app_field_id <> :ii_app_field_id ) 
ORDER BY ba.app_field_prop.x_pos
USING tr_training_data;
		
OPEN g_show_record_num;

FETCH g_show_record_num INTO :li_field_id, :ll_x, :ll_y, :ll_height;

ii_selected_fields_cnt = 0
DO WHILE tr_training_data.SQLCODE = 0 
	ii_selected_fields_cnt++
	is_selected_fields[ ii_selected_fields_cnt ] = String( li_field_id )
	ii_app_field_ids[ ii_selected_fields_cnt ] = li_field_id
	ii_x[ ii_selected_fields_cnt ] = ll_x  //- li_scroll_position_x
	ii_y[ii_selected_fields_cnt ] = ii_ancor_y  
	ii_height[ ii_selected_fields_cnt ] = ll_height	
	FETCH g_show_record_num INTO :li_field_id, :ll_x, :ll_y, :ll_height;
LOOP

CLOSE g_show_record_num;

of_align( "Top" )

st_align.Visible = False

ii_align = 0

RETURN 0
end function

public function long of_select_app ();//////////////////////////////////////////////////////////////////////
// $<function> of_select_app
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.26.2010
//////////////////////////////////////////////////////////////////////

String	ls_Rtn
Long 		li_page_cnt,li_cnt,ll_last_app_id
n_appeon_storage_area lnv_storage_area

// Do some checks
IF tab_1.tabpage_select.dw_appl_detail.RowCount() = 0 THEN
	MessageBox("Select", "No record to select." )
	Return -1
END IF
If ii_app_id  = 0 or isnull(ii_app_id) Then
	Return -1
End If
if IsNull(is_app_path) or Trim(is_app_path) = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"The Application Storage/Download Location is empty, please go to the System->utility->Application Setting and fill in the Application Storage/Download Location field.",Exclamation!)
	Return -1
end if

gnv_appeondll.of_parsepath(is_app_path) //alfee 09.04.2014 - Bug #4176

ls_Rtn = f_ExaWriteRight(is_app_path)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

w_mdi.setredraw(false)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
// Upload last application according to settings
ll_last_app_id = tab_1.tabpage_design.uo_preview.ii_app_id	
IF ll_last_app_id <> ii_app_id and ll_last_app_id > 0 THEN
	IF Not ib_saved or tab_1.tabpage_design.ole_edit.Object.ImageModified THEN
		of_delete_annotations()
		tab_1.tabpage_design.ole_edit.Object.Save()		
		IF gnv_data.of_GetItem( "icred_settings", "image_storage_type", False ) = '1' or appeongetclienttype() = "WEB" THEN
			lnv_storage_area.of_upload_app_image( ll_last_app_id, is_app_path + String( ll_last_app_id ) + ".tif")
			ib_saved = TRUE
		END IF
	END IF
END IF

// Download specified application from database
tab_1.tabpage_design.uo_preview.of_set_app_id( ii_app_id )
tab_1.tabpage_design.uo_preview.of_set_facility_id( ii_facility_id )
This.Title = "IntelliApp   (" + tab_1.tabpage_select.dw_appl_detail.GetItemString(1, "application_name" ) +  " )"

IF gnv_data.of_GetItem( "icred_settings", "image_storage_type", False ) = '1' or appeongetclienttype() = "WEB" THEN
	lnv_storage_area.of_retrieve_image_from_db( ii_app_id, is_app_path + String( ii_app_id ) + ".tif" )
END IF

// Load image file to OLE control
IF FileExists( is_app_path + String( ii_app_id ) + ".tif" ) THEN
	of_delete_anno_files() //052203 maha to eliminate problems with existing ano files
	tab_1.tabpage_design.ole_edit.Object.Image = ""
	tab_1.tabpage_design.uo_preview.ole_edit.Object.Image = ""
	tab_1.tabpage_design.uo_preview.ole_edit.Object.ClearDisplay()

	tab_1.tabpage_merge.Enabled = True
	//tab_1.tabpage_scan.Enabled = True
	tab_1.tabpage_design.Enabled = True	
	//tab_1.tabpage_batch.Enabled = True		
	//tab_1.tabpage_scan.cb_prior_scan.Enabled = True
	//tab_1.tabpage_scan.cb_next_scan.Enabled = True
	//tab_1.tabpage_scan.cb_page_prop.Enabled = True	
	//tab_1.tabpage_scan.ole_scan_edit.Object.ClearDisplay()
	tab_1.tabpage_design.ole_edit.Object.ClearDisplay()

//	tab_1.SelectTab( 3 )
	of_load_image()
	
	tab_1.tabpage_design.ole_edit.Object.ShowAnnotationGroup( )
	il_app_id_audit = ii_app_id
	ib_audit = true
	tab_1.tabpage_design.ole_edit.Object.Save()
ELSE
	tab_1.tabpage_merge.Enabled = False
	//tab_1.tabpage_scan.Enabled = True
	//tab_1.tabpage_design.Enabled = False
	//tab_1.tabpage_batch.Enabled = False
	//tab_1.tabpage_scan.cb_prior_scan.Enabled = False
	//tab_1.tabpage_scan.cb_next_scan.Enabled = False
	//tab_1.tabpage_scan.cb_page_prop.Enabled = False
	tab_1.tabpage_design.ole_edit.Object.ClearDisplay()	
//	tab_1.SelectTab( 3 )
	tab_1.tabpage_design.dw_fld_prop.reset() //maha 101804
	//m_pfe_train_app.m_file.m_scanapplication.enabled = True
	//m_pfe_train_app.m_file.m_scanapplication.ToolBarItemVisible = True
END IF
w_mdi.setredraw(true)  //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
is_preview_mode = "Train"
of_ImagingWarning()

Return 1
end function

public function long of_goto_fix_page (long row);Long ll_y_pos
Long li_row
String ls_field

ib_fix_fields = True
w_train_app.ii_app_id = w_check_intelliapp_fields.dw_2.GetItemNumber( row, "app_id" )
w_train_app.ii_facility_id = w_check_intelliapp_fields.dw_2.GetItemNumber( row, "facility_id" )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 04.07.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Comment out redundant script lines since they will be executed when switching between tab pages.
/*
li_row = w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Find( "facility_id = " + String( w_check_intelliapp_fields.dw_2.GetItemNumber( row, "facility_id" )), 1, 10000 )

w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_row )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_row )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SelectRow( 0, False )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SelectRow( li_row , True )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.TriggerEvent( DoubleClicked! )

li_row = w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Find( "app_id = " + String( w_check_intelliapp_fields.dw_2.GetItemNumber( row, "app_id" )), 1, 10000 )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( li_row )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SelectRow( 0, False )
w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SelectRow( li_row, True )

li_row = w_train_app.of_select_app()
w_train_app.tab_1.tabpage_design.sle_goto_page.Text = String( w_check_intelliapp_fields.dw_2.GetItemNumber( row, "page" ) )
w_train_app.tab_1.tabpage_design.cb_goto_page.TriggerEvent( Clicked! )
*/

tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.Retrieve( ii_app_id )
w_train_app.of_select_app()
	
tab_1.tabpage_design.sle_goto_page.Text = String( w_check_intelliapp_fields.dw_2.GetItemNumber( row, "page" ) )
tab_1.tabpage_design.cb_goto_page.TriggerEvent( Clicked! )
//---------------------------- APPEON END ----------------------------

ls_field = String( w_check_intelliapp_fields.dw_2.GetItemNumber( row, "field_id" ) )
ll_y_pos = w_check_intelliapp_fields.dw_2.GetItemNumber( row, "y_pos" ) 

try 
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_field )	 
catch (runtimeerror ret) 
end try

try 
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( ll_y_pos )
catch (runtimeerror rrr)
end try

//w_select_fields.tab_1.tabpage_properties.PostEvent( Clicked! )//(SelectTab(2)
//ii_ancor_y = ll_y_pos //(tab_1.tabpage_design.ole_edit.Object.ScrollPositionY() -3) + (tab_1.tabpage_design.ole_edit.Object.ScrollPositionY() -3) - UnitsToPixels (ll_y_pos, YUnitsToPixels! )  
//ii_ancor_x = 
//ii_ancor_y = UnitsToPixels (ll_y_pos, YUnitsToPixels! ) + tab_1.tabpage_design.ole_edit.Object.ScrollPositionY() -3
//ii_ancor_y = UnitsToPixels ( ll_y_pos, YUnitsToPixels! ) -10

//Open( w_select_fields, w_train_app )
//w_select_fields.tab_1.SelectTab( 2 )
ib_fix_fields = False

Return 1
end function

public function long of_select_button ();//Note: This is the first half of the placement code  for drag drop, dclick and place and selection from the open data screen
// The second half is in cb_apply.clicked.  For drag drop, and place and selection from the open data screen, both take place sequentially; dclick and place allows user modifications between parts.

DataWindowChild dwchild
Long  ll_fld_id
Long li_page_num
Long li_screen_id
Long li_tbl_id
Long li_last_app_field_id  
Long li_row
long li_app_field_id //modified to long maha071802
Long li_field_len
String ls_lookup_type
String ls_lu_fld_nm
String ls_field_type
String ls_sub_lookup_type
string ls_fld_nm  //maha 06.12.2012
string ls_format //maha 06.12.2012

if of_check_for_image() = -1 then return -1//maha 031505


m_pfe_train_app.m_edit.m_removeobject.Enabled = True
m_pfe_train_app.m_edit.m_copyfields.Enabled = True
m_pfe_train_app.m_view.m_templates.Enabled = True
m_pfe_train_app.m_tools.m_selectfield.Checked = True
m_pfe_train_app.m_tools.m_ropeselect.Checked = False
m_pfe_train_app.m_tools.m_drawbox.Checked = False
m_pfe_train_app.m_tools.m_Text.Checked = False

w_mdi.SetToolbar(3, False, Floating!, "")
w_mdi.SetToolbar(4, False, Floating!, "")
w_mdi.SetToolbar(5, False, Floating!, "")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-06
//$<add> 01.13.2006 By: Cao YongWang
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
If appeongetclienttype() <> 'PB' Then
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbar( ll_handle, 3 , false)
	gnv_appeondll.of_settoolbar( ll_handle, 4 , false)
	gnv_appeondll.of_settoolbar( ll_handle, 5 , false)
End If
//---------------------------- APPEON END ----------------------------

li_row = tab_1.tabpage_design.dw_field_tv.GetRow()
ll_fld_id = tab_1.tabpage_design.dw_field_tv.GetItemNumber( li_row, "field_id" )
li_tbl_id = tab_1.tabpage_design.dw_field_tv.GetItemNumber( li_row, "table_id" )
ls_lookup_type = tab_1.tabpage_design.dw_field_tv.GetItemString( li_row, "lookup_type" )
ls_field_type = tab_1.tabpage_design.dw_field_tv.GetItemString( li_row, "field_type" )
li_screen_id = tab_1.tabpage_design.dw_field_tv.GetItemNumber( li_row, "data_view_screen_screen_id" )

if li_tbl_id >= 80 and li_tbl_id < 90 then //maha 030905
	ib_group = true
else
	ib_group = false
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 04.03.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
tab_1.tabpage_design.dw_fld_prop.Update()
tab_1.tabpage_design.dw_fld_prop.Reset()
tab_1.tabpage_design.dw_fld_prop.InsertRow( 0 )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "app_id", w_train_app.ii_app_id )

SELECT Max( app_field_id )  
INTO :li_last_app_field_id  
FROM app_field_prop  
USING w_train_app.tr_training_data;
//WHERE app_field_prop.app_id = :w_train_app.ii_app_id  ;
*/

gnv_appeondb.of_StartQueue()
tab_1.tabpage_design.dw_fld_prop.Update()

SELECT Max( app_field_id )  
INTO :li_last_app_field_id  
FROM app_field_prop  
USING w_train_app.tr_training_data;
gnv_appeondb.of_CommitQueue()

tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
if dwchild.RowCount() = 0 then dwchild.InsertRow(0)

tab_1.tabpage_design.dw_fld_prop.Reset()
tab_1.tabpage_design.dw_fld_prop.InsertRow( 0 )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "app_id", w_train_app.ii_app_id )
//---------------------------- APPEON END ----------------------------

IF li_last_app_field_id = 0 OR IsNull( li_last_app_field_id ) THEN
	li_last_app_field_id = 1
ELSE
	li_last_app_field_id++
END IF

tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "app_field_id", li_last_app_field_id )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "field_id", ll_fld_id )
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "table_id", li_tbl_id )
//if this is a field that directly references the address lookup table
IF ls_lookup_type = 'A' THEN
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_field", "entity name" )
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_type", "E" )
	li_field_len = 50
ELSEIF ls_lookup_type = 'C' THEN
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_field", "Code" )
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_type", "C" )
	li_field_len = 50	
//if this is a sub field of the lookup table
ELSEIF ls_field_type = 'AL' OR ls_field_type = 'CL' THEN	
	ls_lu_fld_nm = tab_1.tabpage_design.dw_field_tv.GetItemString( tab_1.tabpage_design.dw_field_tv.GetRow(), "field_name_allias" )
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_field", ls_lu_fld_nm )
	CHOOSE CASE Upper( ls_lu_fld_nm )
		CASE "ENTITY_NAME"
			li_field_len = 35
			ls_sub_lookup_type = "A"
		CASE "STREET1", "STREET2"
			li_field_len = 35
			ls_sub_lookup_type = "A"			
		CASE "CITY"
			li_field_len = 15
			ls_sub_lookup_type = "A"			
		CASE "STATE"
			li_field_len = 2
			ls_sub_lookup_type = "A"			
		CASE "ZIP"
			li_field_len = 12
			ls_sub_lookup_type = "A"			
		CASE "COUNTRY"
			li_field_len = 10
			ls_sub_lookup_type = "A"			
		CASE "PHONE"
			li_field_len = 13
			ls_sub_lookup_type = "A"						
		CASE "FAX"
			li_field_len = 13
			ls_sub_lookup_type = "A"						
		CASE "CODE"
			li_field_len = 15
			ls_sub_lookup_type = "C"			
		CASE "DESCRIPTION"	
			li_field_len = 25		
			ls_sub_lookup_type = "C"	
		//Start Code Change ---- 10.03.2006 #644 maha
		CASE "CAQH_CODE"	
			li_field_len = 3		
			ls_sub_lookup_type = "C"
		CASE "CONTACT_NAME"	
			li_field_len = 20	
			ls_sub_lookup_type = "A"
		//End Code Change---10.03.2006
		//Start Code Change ----08.20.2008 #V85 maha - added email field
		CASE "EMAIL_ADDRESS"
			li_field_len = 30
			ls_sub_lookup_type = "A"
		//End Code Change---08.20.2008
		CASE ELSE
	END CHOOSE	
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "lookup_link_type", ls_sub_lookup_type )	
	//tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "width", li_field_len )	
	//tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "width", li_field_len)		
ELSE
	ls_lu_fld_nm = tab_1.tabpage_design.dw_field_tv.GetItemString( tab_1.tabpage_design.dw_field_tv.GetRow(), "data_view_fields_field_label" )
	CHOOSE CASE Upper( ls_lu_fld_nm )
		CASE "LAST NAME"
			li_field_len = 25
		CASE "STATE"
			li_field_len = 2
		CASE "CITY"
			li_field_len = 15
	END CHOOSE
END IF

li_app_field_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "app_field_id" )


//get the page number and assign it to the property page
li_page_num = tab_1.tabpage_design.ole_edit.Object.Page()
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "page", li_page_num )	

//if it was a personal data field selected set the appropriate flags
//debugbreak()
IF li_screen_id = 27 THEN
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "personal_data", "Y" )
ELSE
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "personal_data", "N" )	
END IF

if li_screen_id >= 80 and li_screen_id < 90 THEN //maha 020706
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "record_num_addr", 1 )
end if
//Start Code Change ---- 02.07.2006 #255 maha

//if there was a query on the previous selected field copy the query values over
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "record_number", ii_record_number )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_field", is_query_field )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_operator", is_query_operator )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_value", is_query_value )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "x_pos", 0 )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "y_pos", 0 )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "billing_address_flag", ii_billing_address_flag )	
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "loc_id_passed", il_loc_id )	 //Start Code Change ----05.19.2014 #V14.2 maha

//tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "billing_link_addr", 0 )

IF is_query_field = "" THEN
	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "record_number", 1 )		
END IF

dwchild.SetTransObject( SQLCA )
//update and retrieve to get additional values
gnv_appeondb.of_StartQueue()
tab_1.tabpage_design.dw_fld_prop.Update()
dwchild.Retrieve( li_tbl_id )
tab_1.tabpage_design.dw_fld_prop.Retrieve( li_app_field_id )
gnv_appeondb.of_CommitQueue()

//Start Code Change ----06.12.2012 #V12 maha - moved from cb_apply
ls_fld_nm = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_name" )
 
//set default width
CHOOSE CASE Upper( ls_fld_nm )
	CASE "STATE"
		li_field_len = 2
	CASE "PLACE OF BIRTH STATE"
		li_field_len = 2
	CASE "TITLE"
		li_field_len = 6
	CASE "NAME SUFFIX"
		li_field_len = 6			
	CASE "SUFFIX"
		li_field_len = 6
	CASE "LAST NAME"
		li_field_len = 15
	CASE "PROFESSIONAL SUFFIX","PROFFESIONAL SUFFIX"
		li_field_len = 6
	CASE "COVERAGE LIMIT FROM", "COVERAGE LIMIT TO"
		li_field_len = 12
	CASE "NAME/STREET 1"
		li_field_len = 45
	CASE "STREET"
		li_field_len = 45
	CASE "ID NUMBER"
		li_field_len = 15
	CASE "LICENSE NUMBER"
		li_field_len = 15			
END CHOOSE

//set default format
CHOOSE CASE Upper( ls_fld_nm )
	CASE "SS #"
		ls_format = "SS#"
	CASE "COVERAGE LIMIT FROM", "COVERAGE LIMIT TO"
		ls_format = "Money"			
END CHOOSE
tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "format", ls_format )	
//End Code Change ----06.12.2012

IF li_field_len = 0 OR IsNull( li_field_len ) THEN
	//li_field_len = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "sys_fields_field_len" )	
	li_field_len = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "app_fill_field_len" )
END IF

IF li_field_len = 0 OR IsNull( li_field_len ) THEN //maha 061303 if no value picked up
	li_field_len = 25
END IF

tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "width", li_field_len )

tab_1.tabpage_design.dw_fld_prop.SetColumn( "record_number" )

w_train_app.ii_ancor_x = 0
w_train_app.ii_ancor_y = 0
w_train_app.ib_click_position = True

ib_applied = False
ib_selected = True

w_train_app.ib_new_field_selection = True
w_train_app.st_msg.Text = " Click the position on the image where you want field placed."
w_train_app.st_msg.Visible = True
tab_1.tabpage_design.cb_apply.Visible = False
w_train_app.tab_1.tabpage_design.ole_edit.object.AnnotationType( 0 )
w_train_app.tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	

//tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<comment> 04.03.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Move the following script to PT-08. It is integrated into Appeon
//$<modification> Queue labels with other SQLs to reduce client-server interactions.
/*
tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( li_tbl_id )
*/
//---------------------------- APPEON END ----------------------------

//Comment out the following script base on the customer requirement. Do not need to change the tab when click the 
//field 
//tab_1.tabpage_design.tab_fld_prop.SelectTab( 1 )

Return 0
end function

public function long of_save_mapping ();String	ls_Rtn

if of_check_for_image() = -1 then Return -1 //Add by Evan 03.03.2011

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-17 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 06.08.2012
//$<reason>Bug id 3134: Format width in application mapping
tab_1.tabpage_design.dw_fld_prop.accepttext()
if tab_1.tabpage_design.dw_fld_prop.modifiedcount() > 0 then
	tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )	
end if
//------------------- APPEON END -------------------

//of_delete_annotations( )

IF m_pfe_train_app.m_view.m_recordnumbers.checked THEN
	m_pfe_train_app.m_view.m_recordnumbers.checked = False
	of_delete_records()
END IF

of_app_audit_track(ii_app_id)
tab_1.tabpage_design.ole_edit.Object.Save()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-19 By: Liu Hongxin
//$<reason> Fix defect: After add a page, update it to database.
n_appeon_storage_area lnv_storage_area

IF Not ib_saved THEN//Rodger Wu added, Sept 27, 2006
	IF gnv_data.of_GetItem( "icred_settings", "image_storage_type", False ) = '1' or appeongetclienttype() = "WEB" THEN//Rodger Wu added, Sept 27, 2006
		lnv_storage_area.of_upload_app_image( ii_app_id, is_app_path + String( ii_app_id ) + ".tif")
	END IF
END IF
//---------------------------- APPEON END ----------------------------
COMMIT USING tr_training_data;

//of_load_annotations()

//SetRedraw( True )		//avoiding screen blinks on web application

ib_saved = True

Return 1
end function

public function long of_save (string as_tab);Long li_found
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 04.07.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Define local variable to be used by subsequent script.
dwItemStatus ldws_status
//---------------------------- APPEON END ----------------------------

IF as_tab = "facility" THEN
	IF tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.AcceptText() = -1 THEN
		Return -1
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-11
	//$<modify> 04.07.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<reason> 1)Add a condition to avoid redundant function call.
	//$<reason> 2)Add Appeon Queue labels to reduce lient-server interactions.
	/*
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.Update()
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.retrieve()

	li_found = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Find( "facility_id = " + String( ii_facility_id ) , 1, 100000 )	
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_found )
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_found )
	*/
	ldws_status = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.GetItemStatus( 1, 0, Primary! )
	If ldws_status = DataModified! or ldws_status = NewModified! Then
		gnv_appeondb.of_StartQueue()
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.Update()
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.retrieve()
		gnv_appeondb.of_CommitQueue()
		
		li_found = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Find( "facility_id = " + String( ii_facility_id ) , 1, 100000 )	
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_found )
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_found )
	End If
	//---------------------------- APPEON END ----------------------------

ELSEIF as_tab = "apps" THEN
	IF	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.AcceptText( ) = -1 THEN
		Return -1
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<modify> 04.07.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<reason> 1)Add a conditionto avoid redundant function call.
	//$<reason> 2)Add Appeon Queue labels to reduce client-server interactions.
	/*
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.Update()
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Retrieve( ii_facility_id )
	
	li_found = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Find( "app_id = " + String( ii_app_id ) , 1, 1000 )
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( li_found )
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.ScrolltoRow( li_found )
	*/
	ldws_status = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetItemStatus( 1, 0, Primary! )
	If ldws_status = DataModified! or ldws_status = NewModified! Then
		gnv_appeondb.of_startqueue( )
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.Update()
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Retrieve( ii_facility_id )
		gnv_appeondb.of_commitqueue( )
		
		li_found = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Find( "app_id = " + String( ii_app_id ) , 1, 1000 )
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( li_found )
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.ScrolltoRow( li_found )
	End If
	
	//---------------------------- APPEON END ----------------------------

//$<add> 07.10.2008 by Andy
ELSEIF as_tab = "images" THEN
	IF tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.AcceptText() = -1 THEN
		Return -1
	END IF
	
	Long ll_Cnt,ll_Cnt2,ll_Row,ll_Find
	Long ll_image_type,ll_selected
	dec{0} ldec_app_image_id
	Long ll_New,ll_app_id
	
	if tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.Modifiedcount( ) > 0 then
		//Get max(app_image_id)+1
		SELECT max(app_image_id) INTO :ldec_app_image_id from app_image_defaults;
		if IsNull(ldec_app_image_id) or ldec_app_image_id = 0 then 
			ldec_app_image_id = 1
		else
			ldec_app_image_id ++
		end if
		//Get app_id
		ll_Row    = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetRow( )
		if ll_Row > 0 then
			ll_app_id = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber(ll_Row,"app_id")
		end if 
		//Make changes to dw_image_defaults
		ll_Cnt = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.RowCount()
		ll_Cnt2= tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.RowCount()
		FOR ll_Row = 1 to ll_Cnt2
			ldws_status = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.GetItemStatus( ll_Row, 0, Primary! )
			If ldws_status = NotModified! or ldws_status = New! Then	Continue
			
			ll_selected   = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.GetItemNumber(ll_Row,"selected")
			ll_image_type = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.GetItemNumber(ll_Row,"image_type_id")
			ll_Find = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.Find("image_type=" + String(ll_image_type),1,ll_Cnt)
			if ll_Find > 0 then
				if ll_selected = 0 then tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.deleterow(ll_Find)
			else
				if ll_selected = 1 then
					ll_New = tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.insertRow(0)
					tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.SetItem(ll_New,"app_image_id",ldec_app_image_id)
					tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.SetItem(ll_New,"app_id",ll_app_id)
					tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.SetItem(ll_New,"image_type",ll_image_type)
					ldec_app_image_id ++
				end if
			end if
		Next
		//commit to DB
		tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_defaults.update( )
		tab_1.tabpage_select.tab_facility.tabpage_images.dw_image_list.ResetUpdate( )
	end if
//End add 07.10.2008
END IF

Return 1
end function

public function long of_remove_object ();String ls_label_id

if tab_1.selectedtab = 1 then return 0 //maha 051904 crash trap 
if not ib_IsDeleteAnnotation then Return 0 //Add by Evan 05.27.2009
if of_check_for_image() = -1 then return -1//maha 031505

IF ib_label_selected OR ib_rectangle_selected THEN
	IF MidA( is_label_id, 1, 3 ) = "SP-" OR  MidA( is_label_id, 1, 6 ) = "LABEL-" OR Upper( MidA( is_label_id, 1, 9)) = "RECTANGLE" OR Upper( MidA( is_label_id, 1, 15)) = "HOLLOWRECTANGLE" THEN
		DELETE FROM app_field_prop  
	  	WHERE ( app_field_prop.app_field_id = :ii_app_field_id ) AND  
   	      ( app_field_prop.app_id = :ii_app_id )
		USING tr_training_data;		
		COMMIT USING tr_training_data;
	END IF
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( is_label_id )
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "Rectangle," + String( ii_app_field_id ))		
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "HollowRectangle," + String( ii_app_field_id ))				
	Return 1
END IF

IF tab_1.tabpage_design.dw_fld_prop.RowCount() > 0 THEN
	CHOOSE CASE  tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "object_type" ) 
		CASE "B"
		CASE "C"
			tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"Check" )				
		CASE "Y1"		
			tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"NoBox" )				
			tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"YesBox")				
		CASE "T"
			tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id) )
	END CHOOSE

	tab_1.tabpage_design.dw_fld_prop.DeleteRow(0)
	tab_1.tabpage_design.dw_fld_prop.Update()	
	COMMIT USING tr_training_data;
ELSE
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "Rectangle," + String( ii_app_field_id ))		
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "HollowRectangle," + String( ii_app_field_id ))			
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"Check" )				
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"NoBox" )				
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id)+"YesBox")	
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( is_label_id )		
	tab_1.tabpage_design.ole_edit.object.DeleteAnnotationGroup( String(ii_app_field_id) )			
END IF

//tab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 1 )
tab_1.tabpage_design.dw_quick_filters.Event ue_ShowWindow() //evan 12.15.2010

Return 0

end function

public function long of_open_template ();if of_check_for_image() = -1 then return -1//maha 031505

//Open( w_section_templates )
Open( w_templates_v9)

Return 1
end function

public function long of_prior_page ();String	ls_Rtn

if of_check_for_image() = -1 then Return -1 //Add by Evan 03.03.2011

tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
IF ii_current_page > 1 THEN
	//of_delete_annotations( )	
	ii_current_page --
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_design.ole_edit.Object.Save()
	COMMIT USING tr_training_data;
	tab_1.tabpage_design.ole_edit.object.Page( ii_current_page  )
	tab_1.tabpage_design.ole_edit.object.Display()
	of_load_annotations()
	IF ii_current_page = 1 THEN
		m_pfe_train_app.m_view.m_priorpage.enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ELSE
		this.enabled = True
	END IF
	IF ii_current_page < tab_1.tabpage_design.ole_edit.object.PageCount() THEN
		m_pfe_train_app.m_view.m_nextpage.enabled = True
	END IF
	st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )
END IF

Return 0

end function

public function long of_next_page ();String	ls_Rtn

if of_check_for_image() = -1 then return -1//maha 031505

tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
IF tab_1.tabpage_design.ole_edit.Object.PageCount() > ii_current_page THEN
	//of_delete_annotations( )				
	ii_current_page ++
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_design.ole_edit.Object.Save()
	COMMIT USING tr_training_data;
	tab_1.tabpage_design.ole_edit.object.Page( ii_current_page  )
	tab_1.tabpage_design.ole_edit.object.Display()
	of_load_annotations()
	m_pfe_train_app.m_view.m_priorpage.enabled = True
	IF ii_current_page = tab_1.tabpage_design.ole_edit.Object.PageCount() THEN
		m_pfe_train_app.m_view.m_nextpage.enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ELSE
		m_pfe_train_app.m_view.m_nextpage.enabled = True	
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	END IF
	//w_select_fields.tab_1.SelectTab( 1 )	
	st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )
END IF

Return 0
end function

public function long of_select_field ();if of_check_for_image() = -1 then return -1//maha 031505

ib_label_tool = False

ii_align = 0
ii_copy_fields = 0
st_align.Visible = False
st_connect.Visible = False
st_msg.Visible = False

of_delete_records()
tab_1.tabpage_design.ole_edit.object.AnnotationType( 11 )
tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	

Return 0
end function

public function long of_rope_select ();w_mdi.SetToolbarPos(3, 100, 400, 400, 1)
w_mdi.SetToolbar(3, TRUE, Floating!, "")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-07
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
If appeongetclienttype() <> 'PB' Then
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	gnv_appeondll.of_SetToolbar(ll_handle , 3, TRUE)
End If
//---------------------------- APPEON END ----------------------------


ib_label_tool = False
tab_1.tabpage_design.ole_edit.object.AnnotationType( 0 )

ii_copy_fields = 0
//---------Begin Added by (Appeon)Stephen 05.23.2016 for Bug ID 5173 for Case # 00063954: Mapping Issues --------
m_pfe_train_app.m_edit.m_update.ToolbaritemVisible = true
m_pfe_train_app.m_tools.m_connectfields.ToolbaritemVisible = true
m_pfe_train_app.m_edit.m_cut.ToolbaritemVisible = true
m_pfe_train_app.m_edit.m_paste.ToolbaritemVisible = true
m_pfe_train_app.m_edit.m_copy.ToolbaritemVisible = true
//---------End Added ------------------------------------------------------

Return 0
end function

public function long of_create_text ();
if of_check_for_image() = -1 then return -1//maha 031505

	ib_label_tool = True
	//Open( w_get_label )
	OpenwithParm(w_get_label, "train setup") //alfee 06.29.2010
	w_get_label.io_image_edit = tab_1.tabpage_design.ole_edit	
//END IF

ib_saved = False

Return 0
end function

public function long of_draw_box ();String ls_type
String ls_text
Long li_app_id
Long ll_field_id
Long li_page

if of_check_for_image() = -1 then return -1//maha 031505

li_page = w_train_app.ii_current_page
li_app_id = w_train_app.ii_app_id

SELECT Max( app_field_id )  
INTO :ll_field_id  
FROM app_field_prop 
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox("Database Error", tr_training_data.SQLERRTEXT )
END IF

ll_field_id++

ib_loading_annotations = True
tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "HollowRectangle," + String( ll_field_id ))		
tab_1.tabpage_design.ole_edit.object.Annotationtype(3)		
tab_1.tabpage_design.ole_edit.object.Draw( 1, 1,30,30)	
//tab_1.tabpage_design.ole_edit.object.SetSelectedAnnotationFillColor( 8454143 )
ib_loading_annotations = False

INSERT INTO app_field_prop  
         ( app_field_id,   
           app_id,   
           table_id,   
           field_id,   
           lookup_link_type,   
           lookup_link_field,   
           record_number,   
           x_pos,   
           y_pos,   
           width,   
           query_field,   
           query_value,   
           page,   
           box_type,   
           box_height,   
           box_width,   
           box_yes_x,   
           box_yes_y,   
           box_yes_value,   
           box_no_x,   
           box_no_y,   
           box_no_value,   
           font_type,   
           font_size,   
           font_color,   
           font_background,   
           font_underline,   
           font_bold,   
           query_operator,   
           field_description,   
           personal_data,   
           height,   
           annotation_width,   
           past_years_query,   
           format,   
           connect_field_id,   
           connect_field_sort )  
  VALUES ( :ll_field_id,   
           :li_app_id,   
           99,   
           0,   
           null,   
           null,   
           null,   
           1,   
           1,   
           null,   
           null,   
           null,   
           :li_page,   
           null,   
           30,   
           30,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
			  null,
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
           'HollowRectangle',   
           'N',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox("Database Error", tr_training_data.SQLERRTEXT )
END IF

//COMMIT USING tr_training_data;

try 
	tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	
catch (runtimeerror rte)
end try

Return 1
//Long li_font_type
//String ls_box_object_name
//
//ib_label_tool = False
//
//ls_box_object_name = "box-"+String( Today() ) + String( Now() )
//
//tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( ls_box_object_name )
//tab_1.tabpage_design.ole_edit.Object.AnnotationLineColor( 0 )
//tab_1.tabpage_design.ole_edit.Object.Annotationtype(3)		
//tab_1.tabpage_design.ole_edit.Object.Draw(0, 0, 20, 20)
//tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	
//
//ib_saved = False

Return 0
end function

public function long of_copy ();if of_check_for_image() = -1 then return -1//maha 031505
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-15 By: Liu Hongxin
//$<reason> If have not rope select, couldn't to copy.
if is_IsRectangle = False then return -2
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_design.ole_edit.object.ClipBoardCopy()

ii_copy_fields = 0

Return 0
end function

public function long of_paste ();Long li_dummy[]
String ls_dummy[]
Integer li_ans

if of_check_for_image() = -1 then return -1//maha 031505

//IF m_pfe_train_app.m_tools.m_ropeselect.checked THEN
if ib_rope then //Start Code Change ----05.09.2013 #V12 maha	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2006-08-15 By: Liu Hongxin
	//$<reason> If no data, don't to paste.
	if tab_1.tabpage_design.ole_edit.object.IsClipboardDataAvailable() = False then return -2
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_design.ole_edit.object.ClipboardPaste()
	//ib_rope = false
ELSE
	DO WHILE TRUE
		//---------Begin Modified by (Appeon)Stephen 06.13.2014 for Can't copy a text field in App Mapping--------
		//of_copy_fields( )	
		if of_copy_fields( )	= -1 then
			messagebox("Prompt", "'Copy Fields' is only applicable for the field(s) selected on the data screen.")  //Modified by (Appeon)Harry 08.04.2016 for Bug ID #5273 modify 'Copy fileds' to 'Copy Fields'
			exit
		end if
		//---------End Modfiied ------------------------------------------------------			
		li_ans = MessageBox( "Copy Fields", "Would you like to paste the same fields again?", Question!, YesNo!, 2 )		
		IF li_ans = 2 THEN
			//Clear out copy fields vars
			ii_align = 0
			ii_ancor_count = 0
			is_selected_fields = ls_dummy
			ii_x = li_dummy
			ii_y = li_dummy
			ii_copy_fields = 0
			ii_shift_down_count = 0
			Exit
		END IF
	LOOP
END IF

ib_saved = False

Return 0
end function

public function long of_cut ();if of_check_for_image() = -1 then return -1//maha 031505
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-15 By: Liu Hongxin
//$<reason> If have not rope select, couldn't to cut.
if is_IsRectangle = False then return -2
//---------------------------- APPEON END ----------------------------
tab_1.tabpage_design.ole_edit.object.ClipBoardCut()

ii_copy_fields = 0

ib_saved = False

Return 0
end function

public function long of_add_row ();Long li_nr
Long li_next_id
String ls_install_type



IF tab_1.tabpage_select.tab_facility.SelectedTab = 1 THEN
	IF of_save( "facility" ) = -1 THEN
		Return -1
	END IF

	SELECT Max( facility_id )  
	INTO :li_next_id  
	FROM app_facility
	USING tr_training_data;

	IF IsNull( li_next_id ) OR li_next_id = 0 THEN
		li_next_id = 1
	ELSE
		li_next_id ++
	END IF

	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.Reset()
	li_nr = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.InsertRow( 0 )
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.SetItem( li_nr, "facility_id", li_next_id )
	ii_facility_id = li_next_id
	ii_app_id = 0
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.SetItem( li_nr, "ctx_app", "B" )   //Start Code Change ----05.11.2015 #V15 maha - set type value
//	tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_nr )	
//	tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_nr )		
//	tab_facility.tabpage_facility.dw_facility_browse.SelectRow( 0, False )
//	tab_facility.tabpage_facility.dw_facility_browse.SelectRow( li_nr, True )	
	tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.SetFocus()
ELSE
	IF of_save( "apps" ) = -1 THEN
		Return -1
	END IF

	SELECT Max( app_id )  
	INTO :li_next_id  
	FROM app_hdr
	USING tr_training_data;

	IF IsNull( li_next_id ) OR li_next_id = 0 THEN
		li_next_id = 1
	ELSE
		li_next_id ++
	END IF

	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.Reset()
	li_nr = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.InsertRow( 0 )
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.SetItem( li_nr, "app_id", li_next_id )
	ii_app_id =li_next_id
	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.SetItem( li_nr, "facility_id", ii_facility_id )	

//	tab_facility.tabpage_apps.dw_app_browse.SelectRow( 0, False )
//	tab_facility.tabpage_apps.dw_app_browse.SelectRow( li_nr, True )	
//	tab_facility.tabpage_apps.dw_app_browse.SetRow( li_nr )
//	tab_facility.tabpage_apps.dw_app_browse.ScrollToRow( li_nr )	

	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.SetFocus()	
END IF

Return 0
end function

public function long of_delete_row ();Long li_ans
Long li_app_id
string ls_facil_name //maha101501
long  ll_facil_id //maha101501
Long li_apps

IF tab_1.tabpage_select.tab_facility.SelectedTab = 1 THEN
	IF tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.GetItemStatus( tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.GetRow(), 0, Primary! ) = New!  OR +&
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.GetItemStatus( tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.GetRow(), 0, Primary! ) = NewModified!  THEN
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.DeleteRow( 0 )			
	ELSE	
		ls_facil_name = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.GetItemstring(tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Getrow(),"facility_name")//maha 101501
		ll_facil_id = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.GetItemnumber(tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Getrow(),"facility_id")//maha 101501
		li_ans = MessageBox( "Delete", "Are you sure you want to delete " + ls_facil_name, Question!, YesNo!, 2 )
		IF li_ans = 2 THEN
			Return 0
		END IF
		
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 05.11.2009
		//$<reason> Corrected BugJ062701
		//select count(app_id) into :li_apps from app_hdr where facility_id = :ll_facil_id;//\/maha 101501
		long ll_contacts
		gnv_appeondb.of_startqueue()
		select count(*) into :ll_contacts from ctx_contacts where facility_id = :ll_facil_id;
		select count(*) into :li_apps from app_hdr where facility_id = :ll_facil_id;
		gnv_appeondb.of_commitqueue()
		if ll_contacts > 0 then
			MessageBox("Delete Error","There are " + string(ll_contacts) + " contacts connected to this facility. Delete the contacts before deleting the facility.")
			return -1
		end if
		//------------------- APPEON END ---------------------
		
		if li_apps > 0 then 
			messagebox("Delete Error","There are " + string(li_apps) + "apps connected to this facility. Delete the apps before deleting the facility.")
			return -1
		else
			tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.DeleteRow( 0 )		
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-13
			//$<modify> 02.16.2006 By: owen chen
			//$<reason> Performance tuning
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			/*
			tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Update()
			COMMIT USING SQLCA;
			*/
			gnv_appeondb.of_startqueue( )
			
			tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Update()
			COMMIT USING SQLCA;
			
			gnv_appeondb.of_commitqueue( )
			
			//---------------------------- APPEON END ----------------------------
		
		end if //\ maha 
	END IF	
	IF tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.RowCount() > 0 THEN
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( 1 )
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( 1 )
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SelectRow( 1, True )	
		tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_detail.Retrieve( tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.GetItemNumber( 1, "facility_id" ))
	END IF
ELSE
	IF tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetItemStatus( tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetRow(), 0, Primary! ) = New!  OR +&
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetItemStatus( tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetRow(), 0, Primary! ) = NewModified!  THEN
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.DeleteRow( 0 )	//new unsaved record		
	ELSE
		li_ans = MessageBox( "Delete", "Are you sure you want to delete this record? ", Question!, YesNo!, 2 )
		IF li_ans = 2 THEN
			Return 0
		END IF	
		li_ans = MessageBox( "Delete", "This will delete all the training that has been done for this application and the application image will be deleted.  Are you VERY sure? ", Question!, YesNo!, 2 )	
		IF li_ans = 2 THEN
			Return -1
		end if
		//\/maha 080404
		if  tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.rowcount( )=0 then return -1//Added by  Nova 10.26.2009
		li_app_id =	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetRow(), "app_id" )
		openwithparm(w_app_delete_message,li_app_id)
		li_ans = message.doubleparm
		IF li_ans = -1 THEN
			return -1
		//\
		ELSE
		//	li_app_id =	tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetRow(), "app_id" )
			tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.DeleteRow( 0 )	
			FileDelete( is_app_path + String( li_app_id ) + ".tif" )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-14
			//$<modify> 02.16.2006 By: owen chen
			//$<reason> Performance tuning
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			/*
			DELETE FROM app_field_prop  
		   WHERE app_field_prop.app_id = :li_app_id   ;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox( "Error", "There was an error deleting from the app_field_prop table." )
				Return -1
			END IF	

			tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Update()
			COMMIT USING SQLCA;			
			*/
			gnv_appeondb.of_startqueue( )

			DELETE FROM app_field_prop  
		   WHERE app_field_prop.app_id = :li_app_id   ;

			tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Update()
			
			//Add by appeon 09.20.2006
			DELETE FROM app_blob  
		   WHERE app_id = :li_app_id   ;
			//Add by appeon 09.20.2006

			COMMIT USING SQLCA;	
			
			gnv_appeondb.of_commitqueue( )
			
			//---------------------------- APPEON END ----------------------------
		
		END IF
	END IF
	IF tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.RowCount() > 0 THEN
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( 1 )
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.ScrollToRow( 1 )
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SelectRow( 1, True )	
		tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.Retrieve( tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( 1 ,"app_id" ) )
	END IF

END IF

Return 1
end function

public function long of_test_application ();if of_check_for_image() = -1 then Return -1 // Add by Evan 05.07.2009 --- Corrected BugS122713

OpenWithParm( w_check_intelliapp_fields, "SINGLE-" + String(ii_app_id), w_train_app )

Return 1
end function

public function long of_delete_anno_files ();Long res
Long i

//res = messagebox("","Do you really want to delete all annotation files for this App?",question!,yesno!,2)
 if res = 1 then
	FOR i = 1 TO 100
		FILEDELETE( is_app_path + string(ii_app_id) + "-" + String( i ) + ".ano" )
	END FOR
end if

Return 1
end function

public function long of_change_org ();//////////////////////////////////////////////////////////////////////
// $<function> of_change_org
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.11.2010
//////////////////////////////////////////////////////////////////////

long li_new_facility_id
long li_old_facility_id
long li_old_app_id

if tab_1.tabpage_select.Event of_DataChanged() then
	MessageBox("Prompt", "Please save data first!")
	Return -1
end if

// Get new facility id
li_old_facility_id = ii_facility_id
li_old_app_id = ii_app_id
OpenWithParm(w_app_new_org, li_old_facility_id)
li_new_facility_id = Message.DoubleParm
if li_new_facility_id < 1 then Return -1

// Change facility id
tab_1.tabpage_select.dw_app_tv.SetRedraw(false)
gnv_appeondb.of_StartQueue()
UPDATE app_hdr SET facility_id = :li_new_facility_id WHERE app_id = :ii_app_id;
COMMIT;
tab_1.tabpage_select.dw_app_tv.Retrieve()
gnv_appeondb.of_CommitQueue()

// Refresh UI
tab_1.tabpage_select.dw_app_tv.Event ue_Locate(li_new_facility_id, li_old_app_id)
tab_1.tabpage_select.dw_app_tv.SetRedraw(true)

ii_facility_id = li_new_facility_id
ii_app_id = li_old_app_id

Return 1
end function

public function Long of_check_row ();
Open( w_iapp_fix_login )

if Lower( Message.StringParm ) = "cancel"  THEN
	return -1
elseIF Lower( Message.StringParm ) = "intelliappfix"  THEN
	Open( w_iapp_find_row )
ELSE
	MessageBox( "Sorry", "Wrong password." )
END IF


Return 1
end function

public function Long of_check_all_apps ();Open( w_check_intelliapp_fields, w_train_app )

Return 1
end function

public function Long of_find ();Long ll_app_id
Long li_facility_id
Long li_found

Open( w_find_app )

IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

li_facility_id = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ) )

ll_app_id = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1 , 100 ) )

li_found = tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Find( "facility_id = " + String( li_facility_id ) , 1, 100000 )

IF li_found < 1 THEN
	MessageBox("Error", "Could not find facility id" )
	Return -1
END IF

tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_found )
tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_found )
tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.TriggerEvent( DoubleClicked! )


li_found = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Find( "app_id = " + String( ll_app_id ) , 1, 100000 )

//messagebox("app_id row", tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( li_found, "app_id" ) )

IF li_found < 1 THEN
	MessageBox("Error", "Could not find App id" )
	Return -1
END IF

tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( li_found )
tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.ScrollToRow( li_found )


ii_app_id = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( li_found, "app_id" )
ii_facility_id = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.GetItemNumber( li_found, "facility_id" )

of_select_app( )


//tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.TriggerEvent( DoubleClicked! )


Return 1
end function

public function long of_scan ();boolean lb_exists = false //maha 061708
Long i
Long li_ans
long ll_size //maha 061708

//Start Code Change ----.2008 #V81 maha - slight rearrangement of code added exists trap for store in db
Integer li_image_storage_type

li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0

IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN
	select datalength(app_image) into :ll_size from app_blob;
	if ll_size > 0 then lb_exists = true
else //hard drive
	IF FileExists( is_app_path + String( ii_app_id ) + ".tif")  THEN lb_exists = true
end if

if lb_exists then
	li_ans = MessageBox( "OverWrite", "Are you sure you want to rescan application " + is_app_path + String( ii_app_id ) + ".tif ?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		Return -1
	END IF
END IF


tab_1.tabpage_design.ole_edit.Object.Image = ""
tab_1.tabpage_design.ole_edit.Object.ClearDisplay()

//Added By Ken.Guo 2008-07-11. Workaround Scan bug: First page displayed will be the original page.
tab_1.tabpage_design.uo_preview.ole_edit.Object.Image = ""
tab_1.tabpage_design.uo_preview.ole_edit.Object.ClearDisplay()	


IF FileExists( is_app_path ) OR FileExists( MidA( is_app_path, 1, LenA( is_app_path ) -1)) THEN
	//li_ans = MessageBox( "OverWrite", "Are you sure you want to rescan application " + is_app_path + "?", Question!, YesNo!, 1 )
	//IF li_ans = 2 THEN
	//	Return -1
	//END IF
ELSE
	MessageBox("Image Path", "The application image path " + is_app_path + " is invalid.  Go to the Setup->Organization tab and click on the Set Image Path button to set the appropriate Application Image path." )
	Return -1
END IF

IF image_functions.of_Setup_Scan( tab_1.tabpage_design.ole_scan, is_app_path + String(ii_app_id) + ".tif", 1 ) = -1 THEN
	of_Select_App()
	Return -1
END IF


IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN
	n_appeon_storage_area lnv_storage_area	
	lnv_storage_area.of_upload_app_image( ii_app_id, is_app_path + String(ii_app_id) + ".tif" )
END IF

//End Code Change---06.17.2008

of_load_image( )

//\/the following appear to be redundant - called in of load image
tab_1.tabpage_design.ole_edit.Object.Page(1)
tab_1.tabpage_design.ole_edit.Object.FitTo(3)
tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	
tab_1.tabpage_design.ole_edit.Object.Display()
tab_1.tabpage_design.ole_edit.Object.ImageResolutionx( 300 )
tab_1.tabpage_design.ole_edit.Object.ImageResolutionY( 300 )
//\

//Added by Appeon. After you scanning for an new application, if the tables and fields list not appear then retrieve it.
If not tab_1.tabpage_design.dw_screen.Rowcount() > 0 Then of_retrieve_tables_fields()
Return 1


end function

public function long of_blank_page ();//====================================================================
// $<function> of_blank_page()
// $<arguments>
// $<returns> long
// $<description> Copy page
// $<add> (Appeon) evan 08.26.2011
//====================================================================

Integer li_first_record_number
Integer li_rec_num_incriment
integer li_max_rec_screen //maha 04.26.2017
integer li_table_test  //maha 04.26.2017
Integer li_new_rec_num
Integer li_old_rec_num
Integer i, f, li_ans, li_row_cnt
Integer li_last_record_number
Integer li_count
Integer li_copy_page
Long ll_next_app_field_id
Long li_insert_after
long ll_find //maha 04.26.2017
String ls_blankpage
string ls_mess  //maha 04.26.2017
n_appeon_download lnv_down
n_appeon_storage_area lnv_storage_area
DataStore ds_field_prop_from
DataStore ds_field_prop_to

if of_check_for_image() = -1 then return -1//maha 031505

Open( w_insert_page )
IF Message.StringParm = "Cancel" THEN
	Return -1
END IF
li_insert_after = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-") -1) ) + 1	
li_copy_page = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-")+1, 100) ) 

// Download files
ls_blankpage = is_app_path + "\blankpage.tif"
lnv_storage_area.of_retrieve_image_from_db( ii_app_id, is_app_path + String( ii_app_id ) + ".tif" )
if not fileexists(ls_blankpage) Then ls_blankpage = gs_current_path + "\blankpage.tif" //add by stephen 02.28.2013 -Bug 3425 -Mapping is missing from the application
if not fileexists(ls_blankpage) Then lnv_down.of_downloadfile("" ,ls_blankpage)

// When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
tab_1.tabpage_design.ole_img_admin.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )
If tab_1.tabpage_design.ole_img_admin.Object.pagecount() > 0 and tab_1.tabpage_design.ole_img_admin.Object.FileType <> 1 Then
	Messagebox('Image','The current image file must be in "TIF" format.')
	Return -1			
End If

// Copy image page
IF li_copy_page = 0 THEN
	tab_1.tabpage_design.ole_img_admin.Object.Insert( /*is_app_path + "\blankpage.tif"*/ls_blankpage, 1, li_insert_after , 1 )//modify by stephen 02.28.2013 -Bug 3425 -Mapping is missing from the application
ELSE
	if li_insert_after > tab_1.tabpage_design.ole_edit.Object.PageCount() then
		li_insert_after = tab_1.tabpage_design.ole_edit.Object.PageCount() + 1
	end if
	tab_1.tabpage_design.ole_img_admin.Object.Insert( is_app_path + "\" + String( ii_app_id ) + ".tif", li_copy_page, li_insert_after , 1 )
	of_clear_annos_one_page( li_copy_page, li_insert_after )
END IF
FOR i = li_insert_after TO 100
	FILEDELETE( is_app_path + string(ii_app_id) + "-" + String( i ) + ".ano" )
END FOR

// Update page number for existent mapping fields
gnv_appeondb.of_StartQueue()
UPDATE app_field_prop
SET page = page + 1
WHERE app_id = :ii_app_id AND
      page >= :li_insert_after
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF
gnv_appeondb.of_CommitQueue()

// Copy mapping fields
IF li_copy_page > 0 THEN
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 08.26.2011
	//$<reason> The mapping fields connot be copied.
	if li_insert_after <= li_copy_page then
		li_copy_page += 1
	end if
	if li_insert_after <= ii_current_page then
		ii_current_page ++
		tab_1.tabpage_design.ole_edit.Object.Page(ii_current_page)
		tab_1.tabpage_design.ole_edit.Object.Display()
	end if
	//------------------- APPEON END ---------------------
	
	ds_field_prop_from = CREATE DataStore;
	ds_field_prop_to = CREATE DataStore;
	ds_field_prop_from.DataObject = "d_app_field_properties_copy"
	ds_field_prop_from.SetTransObject( SQLCA )
	
//	gnv_appeondb.of_StartQueue() //Commented by (Appeon)Stephen 06.08.2017 - Application Mapping annotations do not copy Case#71418 Bug ID#5676
	ds_field_prop_from.Retrieve( ii_app_id, li_copy_page )
	
	SELECT Max( app_field_id )
	INTO :ll_next_app_field_id
	FROM app_field_prop
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
		gnv_appeondb.of_CommitQueue()
		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
		Return -1
	END IF
	gnv_appeondb.of_CommitQueue()


 //Start Code Change ----04.27.2017 #V153 maha- changed logic so that incrementing is only on the max screen record; gets variable values from data store	
	ds_field_prop_from.setsort("record_number desc")
	ds_field_prop_from.sort()
//debugbreak()	
	li_row_cnt = ds_field_prop_from.RowCount( )
	
	//get highest record number
	for f = 1 to li_row_cnt
		ll_find = ds_field_prop_from.getitemnumber(f, "record_number")
		if isnull(ll_find) then
			continue
		else
			li_last_record_number = ds_field_prop_from.getitemnumber(f, "record_number")
			li_max_rec_screen = ds_field_prop_from.getitemnumber(f, "table_id")
			exit
		end if
	next
	
	//get lowest value for record for the high screen
	FOR f = li_row_cnt  to 1 step -1
		if ds_field_prop_from.getitemnumber(f, "table_id") = li_max_rec_screen then
			li_first_record_number = ds_field_prop_from.getitemnumber(f, "record_number")
			EXIT
		end if
	NEXT
		

//	SELECT Max( record_number )
//	INTO :li_last_record_number
//	FROM app_field_prop
//	WHERE app_id = :ii_app_id AND
//   	   page = :li_copy_page
//	USING tr_training_data;
//	IF tr_training_data.SQLCODE = -1 THEN
//		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
//		gnv_appeondb.of_CommitQueue()
//		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
//		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to		
//		Return -1
//	END IF
//	
//	 SELECT top 1 table_id, Min( record_number )
//	INTO :li_max_rec_screen , :li_first_record_number
//	FROM app_field_prop
//	WHERE app_id = :ii_app_id AND
//   	   page = :li_copy_page AND  record_number = :li_last_record_number
//	USING tr_training_data;
//	IF tr_training_data.SQLCODE = -1 THEN
//		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
//		gnv_appeondb.of_CommitQueue()
//		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
//		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to		
//		Return -1
//	END IF
//	
//	SELECT top 1 table_id, Min( record_number )
//	INTO :li_max_rec_screen , :li_first_record_number
//	FROM app_field_prop
//	WHERE app_id = :ii_app_id AND
//   	   page = :li_copy_page AND  record_number = :li_last_record_number
//	USING tr_training_data;
//	IF tr_training_data.SQLCODE = -1 THEN
//		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
//		gnv_appeondb.of_CommitQueue()
//		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
//		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to		
//		Return -1
//	END IF
//	//End Code Change ----04.27.2017
 
//	SELECT Max( app_field_id )
//	INTO :ll_next_app_field_id
//	FROM app_field_prop
//	USING tr_training_data;
//	IF tr_training_data.SQLCODE = -1 THEN
//		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
//		gnv_appeondb.of_CommitQueue()
//		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
//		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
//		Return -1
//	END IF
//	gnv_appeondb.of_CommitQueue()
	
	ds_field_prop_to.DataObject = "d_app_field_properties_copy"
	ds_field_prop_to.SetTransObject( SQLCA )
	ds_field_prop_from.RowsCopy( 1, 10000, Primary!, ds_field_prop_to, 1, Primary! )
	
	 //Start Code Change ----04.26.2017 #V153 maha - modified message
	ls_mess = "The maximum record number on the page you are copying is " + String( li_last_record_number ) + ".  Would you like to increment the record numbers for the new page based on this value (this will only increment records on the same data screen)?"
	ls_mess =  ls_mess + "~r~rNote: Please check your record numbers after the copy to be sure they are set appropriately, particularly if there is mapping from multiple data screens."
	ls_mess =  ls_mess + "~r~rClick no if you wish to copy the record numbers as they are."
	li_ans = MessageBox( "Record Number", ls_mess,  Question!, YesNo!, 1 )
	 //End Code Change ----04.26.2017 	
	 
	li_rec_num_incriment =  li_last_record_number - li_first_record_number
	li_row_cnt = ds_field_prop_to.RowCount( )
	
	FOR f = 1 TO li_row_cnt
		ll_next_app_field_id++
		ds_field_prop_to.SetItem( f, "app_field_id", ll_next_app_field_id )
 //Start Code Change ----04.26.2017 #V153 maha - modified to increment for only the screen connected to the max rec no	
		ds_field_prop_to.SetItem( f, "page", li_insert_after )
		li_table_test =  ds_field_prop_to.GetItemNumber( f, "table_id" )
		IF li_ans = 1 and li_table_test = li_max_rec_screen THEN
			li_old_rec_num = ds_field_prop_to.GetItemNumber( f, "record_number" )
			li_new_rec_num = li_old_rec_num + li_rec_num_incriment + 1
			ds_field_prop_to.SetItem( f, "record_number", li_new_rec_num )
		else
			//leave the original record number
		END IF
 //End Code Change ----04.26.2017
	END FOR
	
	ds_field_prop_to.Update( )
	if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
	if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
END IF

// Set navigation menu items
if ii_current_page = 1 then
	m_pfe_train_app.m_view.m_priorpage.enabled = false
	tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	m_pfe_train_app.m_view.m_nextpage.enabled = true
	tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
elseif ii_current_page = tab_1.tabpage_design.ole_edit.Object.PageCount() then
	m_pfe_train_app.m_view.m_priorpage.enabled = true
	tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	m_pfe_train_app.m_view.m_nextpage.enabled = false
	tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
else
	m_pfe_train_app.m_view.m_priorpage.enabled = true
	tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	m_pfe_train_app.m_view.m_nextpage.enabled = true
	tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
end if
st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )

Return 1
end function

public function Long of_additional_info ();Open( w_get_additional_info_pages )

Return 1
end function

public function long of_straighten_page ();if of_check_for_image() = -1 then return -1//maha 031505

tab_1.tabpage_design.ole_edit.object.ManualDeSkew()

Return 1
end function

public function long of_special_fields ();if of_check_for_image() = -1 then return -1//maha 031505

Open( w_special_fields )
w_special_fields.io_image_edit = tab_1.tabpage_design.ole_edit	

Return 1
end function

public function Long of_field_exceptions ();OpenWithParm( w_field_exceptions, String( ii_app_id ) )

Return 1
end function

public function long of_page_properties ();if of_check_for_image() = -1 then return -1//maha 031505

tab_1.tabpage_design.ole_edit.Object.ShowPageProperties( False )

Return 1
end function

public function long of_preview (string as_type);Long li_current_page
Long li_page_cnt
string ls_loc //maha 04.10.2014
string ls_state //maha 06.10.2014
String ls_prac_id
String ls_facility_id
string ls_page_from
string ls_page_to
string ls_prac
integer p1
integer p2
integer p3
integer res //maha01.05.2008

if of_check_for_image() = -1 then return -1//maha 031505
//debugbreak()
st_page_num.Visible = False		
//st_field_name.Visible = False
of_field_name_visible( )

if as_type = "Page" then //maha 042604 
	ls_prac = "D"
else //modified maha 082205 to strip parameters correctly
	p1 = PosA(as_type,"@",1)
	p2 = PosA(as_type,"@",p1 + 1)
	p3 = PosA(as_type,"@",p2 + 1)
	ls_page_from = MidA(as_type,1,p1 - 1)
	ls_page_to = MidA(as_type,p1 + 1,p2 - p1 - 1)
	ls_prac = MidA(as_type,p2 + 1,p3 - p2 - 1)
//	ls_prac = mid(as_type,5,1)
//	ls_page_from = mid(as_type,1,1)
//	ls_page_to = mid(as_type,3,1)
end if

//return 1 
ls_prac_id = ProfileString(gs_IniFilePathName, "Setup", "default_practitioner", "None")
ls_facility_id = ProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", "None")

 //Start Code Change ----04.10.2014 #V14.2 maha - location default
ls_loc = ProfileString(gs_IniFilePathName, "Setup", "default_location", "None") 
if isnumber(ls_loc) then tab_1.tabpage_design.uo_preview.il_loc_id = long(ls_loc)
 //Start Code Change ----04.10.2014
  //Start Code Change ----06.10.2014 #V14.2 maha -state default
ls_state = ProfileString(gs_IniFilePathName, "Setup", "default_state", "None") 
if isnumber(ls_state) then tab_1.tabpage_design.uo_preview.il_state_passed = long(ls_state)
//messagebox("state",ls_state)
 //Start Code Change ----06.10.2014
 
IF ls_prac_id = "" or ls_prac <> "D" THEN //maha mod 042604
	//Start Code Change ----01.09.2009 #V92 maha
	res = tab_1.tabpage_design.uo_preview.of_populate( )
	if res < 0 then return -1 //added to all canceling
	//End Code Change---01.09.2009
ELSE
	tab_1.tabpage_design.uo_preview.ii_prac_id = Long( ls_prac_id )
	gi_parent_facility = Long( ls_facility_id )	
END IF

tab_1.tabpage_design.uo_preview.ole_edit.Object.HideAnnotationGroup()

IF as_type = "Page" THEN
	li_current_page = tab_1.tabpage_design.ole_edit.object.Page()
	tab_1.tabpage_design.uo_preview.of_setup( ii_app_id, li_current_page, li_current_page, gi_parent_facility )	
ELSE
	if ls_page_from = "D" then ls_page_from = "1" //maha mod 042604  else use
	li_page_cnt = tab_1.tabpage_design.ole_edit.object.PageCount()
	if ls_page_to = "D" then 
		//use the default count of li_page_cnt
	else
		if integer(ls_page_to) <= li_page_cnt then //maha corrected 070904 was using page from value
			li_page_cnt = integer(ls_page_to)
		end if
	end if
	tab_1.tabpage_design.uo_preview.of_setup( ii_app_id, integer(ls_page_from), li_page_cnt, gi_parent_facility )		
END IF

Return 1
end function

public function Long of_set_default_preview_prac ();
tab_1.tabpage_design.uo_preview.of_set_default_preview_prac( )


Return 1
end function

public function Long of_next_preview_page ();
Tab_1.Tabpage_design.uo_preview.of_Next_page( )

Return 1
end function

public function long of_prior_preview_page ();Tab_1.Tabpage_design.uo_preview.of_Prior_page( )
		
Return 1
end function

public function long of_setup_align ();if of_check_for_image() = -1 then return -1//maha 031505

String ls_dummy[]
is_selected_fields[] = ls_dummy
ii_ancor_count = 0
ii_connect_fields = 0
tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
IF ii_align = 0 THEN
	ii_align = 1
	IF ib_auto_align_all = True THEN
		st_align.Visible = False
	ELSE
		st_align.Visible = True		
	END IF
ELSE
	ii_align = 0
	st_align.Visible = False
END IF


Return 1
end function

public function long of_setup_connect_field ();if of_check_for_image() = -1 then return -1//maha 031505

String ls_dummy[]
ii_ancor_count = 0
is_selected_fields = ls_dummy
tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )

IF ii_connect_fields = 0 THEN
	ii_connect_fields = 1
	st_connect.Visible = True
ELSE
	ii_connect_fields = 0
	st_connect.Visible = False	
END IF

Return 1
end function

public function long of_connect_field ();Long li_next_id  
Long li_selected_cnt
Long i
Long ll_field_id

if of_check_for_image() = -1 then return -1//maha 031505

SELECT Max( connect_field_id )  
INTO :li_next_id  
FROM app_field_prop 
WHERE app_id = :ii_app_id
USING tr_training_data;

li_next_id++

li_selected_cnt = UpperBound( is_selected_fields )

IF li_next_id = 0 or IsNull( li_next_id ) THEN
	li_next_id = 1
END IF

if gi_test_mode = 1 then
	messagebox("Field count",li_selected_cnt)
end if

FOR i = 1 TO li_selected_cnt
	
	IF Upper(RightA( is_selected_fields[i], 6 )) = "YESBOX" THEN
		ii_app_field_id = long( MidA( is_selected_fields[i], 1, LenA( is_selected_fields[i] ) - 6) )
	ELSEIF Upper(RightA( is_selected_fields[i], 5 )) = "NOBOX" THEN
		ii_app_field_id = long( MidA( is_selected_fields[i], 1, LenA( is_selected_fields[i] ) - 5) )	
	ELSE
		ii_app_field_id = long( is_selected_fields[i] )
	END IF		

	Update app_field_prop
	Set connect_field_id = :li_next_id,
		 connect_field_sort = :i
	WHERE app_field_id = :ii_app_field_id
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "Error", tr_training_data.SQLERRTEXT )
		Return 0
	END IF
	
END FOR

of_setup_connect_field()

w_mdi.SetToolbar( 5, False, Floating!)		
w_mdi.SetToolbarPos( 5, 75, 400, 100, 1)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-08
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
If appeongetclienttype() <> 'PB' Then
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	gnv_appeondll.of_SetToolbar( ll_handle , 5, False)		
End If
//---------------------------- APPEON END ----------------------------

//Refresh in dw_fld_prp - alfee 11.04.2009
IF tab_1.tabpage_design.dw_fld_prop.RowCount() > 0 THEN 
	ll_field_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "app_field_id" )
	tab_1.tabpage_design.dw_fld_prop.Retrieve(ll_field_id)
END IF

Return 1
end function

public function long of_select_field_info ();DataWindowChild dwchild
Long li_table_id
String ls_tbl_nm
String ls_lookup_link_type
String ls_fld_desc
String ls_lookup_link_field

IF ii_align  = 0 THEN
	li_table_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "table_id" )
	tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field", dwchild )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-19
	//$<modify> 04.04.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	dwchild.SetTransObject( w_train_app.tr_training_data )
	dwchild.Retrieve( li_table_id )
	*/
	dwchild.Reset()
	ids_queryfield.RowsCopy( 1, ids_queryfield.rowcount(), Primary!, dwchild, 1, Primary! )
	//---------------------------- APPEON END ----------------------------
END IF

is_fld_nm = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_name" )
ls_tbl_nm = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "table_name" )
ls_fld_desc = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_description" )
ls_lookup_link_field = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_field" )
ls_lookup_link_type = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "lookup_link_type" )



IF IsNull( ls_lookup_link_field ) OR ls_lookup_link_field = "" THEN
	st_field_name.Text =  ls_tbl_nm + ">" + is_fld_nm
ELSE
	IF ls_lookup_link_type = "C" THEN
		st_field_name.Text =  ls_tbl_nm + ">" + is_fld_nm + "->" + ls_lookup_link_field
	ELSE
		st_field_name.Text =  ls_tbl_nm + ">" + ls_lookup_link_field
	END IF
END IF

Return 1

end function

public function Long of_print_preview_app ();tab_1.tabpage_design.uo_preview.of_Print( )

Return 1
end function

public function long of_prac_search ();//////////////////////////////////////////////////////////////////////
// $<function> of_prac_search
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.12.2010
//////////////////////////////////////////////////////////////////////

long li_current_page

if tab_1.tabpage_design.uo_preview.of_populate() = -1 then
	Return -1
end if

li_current_page = tab_1.tabpage_design.ole_edit.object.Page()
tab_1.tabpage_design.uo_preview.ole_edit.Object.HideAnnotationGroup() //(Appeon)Stephen 05.19.2015 - Willis-Knighton Case#54704
tab_1.tabpage_design.uo_preview.of_setup( ii_app_id, li_current_page, li_current_page, gi_parent_facility )

m_pfe_train_app.m_view.m_priorpage.enabled = false
tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
m_pfe_train_app.m_view.m_nextpage.enabled = true
tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha

Return 1
end function

public function long of_retrieve_end ();Long i
Long l
Long li_nr
Long rowcount
Long li_rc
String ls_address_fields[]
String ls_code_fields[]
string ls_field_name //maha 11.17.09

IF NOT ib_hold_on_retrieve_end THEN
//Start Code Change ---- 02.21.2006 #279 maha	
if tab_1.tabpage_design.dw_field.rowcount() < 1 then return 0 
//End Code Change---02.21.2006

IF tab_1.tabpage_design.dw_field.GetItemNumber( 1, "table_id" ) = 25 AND ib_personal_data = False THEN //personal data
	tab_1.tabpage_design.dw_field.SetFilter("(field_id >= 298 and field_id <= 319) or (field_id >= 325 and field_id <= 329)")
	tab_1.tabpage_design.dw_field.Filter( )
	li_rc = tab_1.tabpage_design.dw_field.RowCount( )
	FOR i = 1 TO li_rc
		tab_1.tabpage_design.dw_field.DeleteRow( 1 )
	END FOR
	tab_1.tabpage_design.dw_field.SetFilter("")
	tab_1.tabpage_design.dw_field.Filter( )		
ELSEIF ib_personal_data THEN //basic info
	tab_1.tabpage_design.dw_field.SetFilter("(field_id < 298 or (field_id >= 320 and field_id <= 324))")
	
	tab_1.tabpage_design.dw_field.Filter( )
	li_rc = tab_1.tabpage_design.dw_field.RowCount( )
	FOR i = 1 TO li_rc
		tab_1.tabpage_design.dw_field.DeleteRow( 1 )
	END FOR
	tab_1.tabpage_design.dw_field.SetFilter("")
	tab_1.tabpage_design.dw_field.Filter( )		
END IF


ls_code_fields[2] = "Code"
ls_code_fields[1] = "Description"
//to add additional fields from the lookup table add the field name with the appropriate array number.  
//In the code below up the array count
//also in of_select_button add the new field to the case list
//ls_address_fields[12] = "Code"
ls_address_fields[11] = "Entity_Name"
ls_address_fields[10] = "Street1"
ls_address_fields[9] = "Street2"
ls_address_fields[8] = "City"
ls_address_fields[7] = "State"
ls_address_fields[6] = "Zip"
ls_address_fields[5] = "Country"
ls_address_fields[4] = "Phone"
ls_address_fields[3] = "Fax"
ls_address_fields[2] = "Contact_Name"
ls_address_fields[1] = "Email_Address"  //Start Code Change ----08.20.2008 #V85 maha

rowcount = tab_1.tabpage_design.dw_field.RowCount()

FOR i = 1 TO rowcount
	IF tab_1.tabpage_design.dw_field.GetItemString( i, "lookup_type" ) = "A" THEN
		FOR l = 1 TO 11 //array count
			li_nr = tab_1.tabpage_design.dw_field.InsertRow( i + 1)
			rowcount = rowcount + 1
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "parent_field", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" ))
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_name_allias", ls_address_fields[l] )
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_type", "AL" )
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" )) 
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "table_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "table_id" )) 			
		END FOR

		//JAD 08/06 CAQH CODE
		li_nr = tab_1.tabpage_design.dw_field.InsertRow( i + 11 ) //array count plus 1
		rowcount = rowcount + 1
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "parent_field", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" ))
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_name_allias", "CAQH_Code" )
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_type", "AL" )
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" )) 
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "table_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "table_id" )) 			
		
	ELSEIF tab_1.tabpage_design.dw_field.GetItemString( i, "lookup_type" ) = "C" THEN
		FOR l = 1 TO 2
			li_nr = tab_1.tabpage_design.dw_field.InsertRow( i + 1)
			rowcount = rowcount + 1
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "parent_field", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" ))
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_name_allias", ls_code_fields[l] )
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_type", "CL" )
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" )) 
			tab_1.tabpage_design.dw_field.SetItem( li_nr, "table_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "table_id" )) 
		END FOR		
		
		//JAD 08/06 CAQH CODE
		li_nr = tab_1.tabpage_design.dw_field.InsertRow( i + 3 ) 
		rowcount = rowcount + 1
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "parent_field", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" ))
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_name_allias", "CAQH_Code" ) //Start Code Change ---- 02.23.2007 #V7 maha
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_type", "CL" )
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" )) 
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "table_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "table_id" )) 			
//Start Code Change ----11.17.2009 #V92 maha - ALLOW MAPPING OF FACILITY_NAME
	ELSEIF UPPER(ls_field_name) = "PARENT FACILITY ID" OR UPPER(ls_field_name) = "FACILITY ID" THEN
		li_nr = tab_1.tabpage_design.dw_field.InsertRow( i + 1 ) //array count plus 1
		rowcount = rowcount + 1
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "parent_field", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" ))
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_name_allias", "Facility Name" )
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_type", "FC" )
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "field_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "field_id" )) 
		tab_1.tabpage_design.dw_field.SetItem( li_nr, "table_id", tab_1.tabpage_design.dw_field.GetItemNumber( i, "table_id" )) 
//End Code Change---11.17.2009		
	END IF
END FOR

IF rowcount > 0 THEN
	tab_1.tabpage_design.dw_field.SetRow( 1 )
	tab_1.tabpage_design.dw_field.SelectRow( 1, True )
END IF

END IF

RETURN 0
end function

public function long of_create_annotations (long ai_field_id);Long li_cnt

if of_check_for_image() = -1 then return -1//maha 031505

w_train_app.tab_1.tabpage_design.st_field.Text = "Loading application page, please wait."

IF NOT ib_placing_template THEN
	tab_1.tabpage_design.uo_bar.Visible = True
END IF

IF ai_field_id > 0 THEN
	ib_loading_annotations = False
ELSE
	ib_loading_annotations = True
END IF

//tab_1.tabpage_design.ole_edit.SetRedraw( False ) //avoiding screen blinks

tab_1.tabpage_design.uo_bar.r_bar.Width = 0

String ls_label_data
String ls_field_description
String ls_object_type
String ls_field_type
String ls_lookup_link_type
String ls_group_nm
String ls_fld_desc
String ls_lookup_link_field
String ls_fld_display
String ls_font_type
Long ll_width
Long ll_height
Long ll_field_id
Long ll_table_id
Long li_field_len
long li_app_field_id //modified 071802 maha
long ll_color //maha 06.19.2012
String ls_fld_nm
String ls_tbl_nm
string ls_color //maha 06.19.2012
n_ds ds_field_properties
long li_fld_cnt
Long li_x_pos
Long li_y_pos
Long li_fld_loop
Long li_prev_scrollY
Long li_prev_scrollX
Long li_step
Boolean lb_autorefresh //alfee 01.04.2010

li_prev_scrollY = tab_1.tabpage_design.ole_edit.object.ScrollPositionY( )
li_prev_scrollX = tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )

lb_autorefresh = tab_1.tabpage_design.ole_edit.object.autorefresh //alfee 01.04.2010
if ib_loading_annotations then tab_1.tabpage_design.ole_edit.object.autorefresh = TRUE //for an issue to place template fields - alfee 10.19.2010
//tab_1.tabpage_design.ole_edit.object.autorefresh = TRUE //for an issue to refresh annotations - alfee 01.04.2010

tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )			

tab_1.tabpage_design.ole_edit.object.autorefresh = lb_autorefresh //alfee 01.04.2010			

ds_field_properties = CREATE n_ds
ds_field_properties.DataObject = "d_app_field_properties_all"
ds_field_properties.SetTransObject( tr_training_data )
li_fld_cnt = ds_field_properties.Retrieve( ii_app_id, ii_current_page )

IF ai_field_id > 0 THEN
	ds_field_properties.SetFilter( "app_field_id = " + String( ai_field_id ) )
	ds_field_properties.Filter()
	li_fld_cnt = 	ds_field_properties.RowCount( )
END IF

IF li_fld_cnt = 0 THEN
	ib_loading_annotations = False
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-09
	//$<modify> 01.13.2006 By: Wang Chao
	//$<reason> The GOTO statement is currently unsupported.
	//$<modification> Encapsualte the script associated with the label into of_cleanup,
	//$<modification> and call of_cleanup to provide the same functionaltiy.
	
	//GOTO cleanup
	Return of_cleanup(li_prev_scrollX,li_prev_scrollY)
	//---------------------------- APPEON END ----------------------------	
END IF

li_step = (( 1000 )/li_fld_cnt) 

FOR li_fld_loop = 1 TO li_fld_cnt
	ls_object_type = ds_field_properties.GetItemString( li_fld_loop, "object_type" )
	li_app_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "app_field_id" )
	li_field_len = ds_field_properties.GetItemNumber( li_fld_loop, "width" )
	li_x_pos = ds_field_properties.GetItemNumber( li_fld_loop, "x_pos" )
	li_y_pos = ds_field_properties.GetItemNumber( li_fld_loop, "y_pos" )
	ll_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "field_id" )	
	ll_table_id = ds_field_properties.GetItemNumber( li_fld_loop, "table_id" )	
	ll_width = ds_field_properties.GetItemNumber( li_fld_loop, "box_width" )	
	ll_height = ds_field_properties.GetItemNumber( li_fld_loop, "box_height" )		
	ls_field_description = ds_field_properties.GetItemString( li_fld_loop, "field_description" )
	ls_color = ds_field_properties.GetItemString( li_fld_loop, "font_background" )  //Start Code Change ----06.18.2012 #V12 maha = added
		
	IF ll_table_id = 99 THEN
		CHOOSE CASE Upper( ls_field_description )
			CASE "TODAYS DATE"
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-TODAYSDATE," + String( li_app_field_id ) )		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "MM/DD/YYYY" )		
			CASE "CURRENT TIME"
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-CURRENTTIME," + String( li_app_field_id ))				
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "HH:MMa" )		
			CASE "USER ID"
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERID," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Id" )
			//Start Code Change ----04.08.2013 #V12 maha
			CASE "USER NAME"
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERNAME," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Name" )
			CASE "USER EMAIL"
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USEREMAIL," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Email" )
			//End Code Change ----04.08.2013	
			CASE "SIGNATURE"	//E-Sign : added by long.zhang 06.13.2011
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-SIGNATURE," + String( li_app_field_id ))	
				IF AppeonGetClientType() = "PB" THEN
					tab_1.tabpage_design.ole_edit.Object.AnnotationImage = Gs_Current_Directory + "\Signature.jpg"
				ELSE
					tab_1.tabpage_design.ole_edit.Object.AnnotationImage = tab_1.tabpage_merge.uo_create_app11.of_get_signaturepath()
				END IF
				tab_1.tabpage_design.ole_edit.Object.AnnotationFillStyle(0)
				tab_1.tabpage_design.ole_edit.Object.AnnotationType(5)
				tab_1.tabpage_design.ole_edit.Object.Draw(li_x_pos,li_y_pos)
				tab_1.tabpage_design.ole_edit.Object.SelectTool(1)	
				CONTINUE
			//Start Code Change ----11.03.2016 #V153 maha
			CASE "USER STREET" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTREET," + String(  li_app_field_id  ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Street" )		
			CASE "USER STREE2" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTREE2," + String(  li_app_field_id  ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Street2" )		
			CASE "USER CITY" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERCITY," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User City" )
			CASE "USER STATE" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERSTATE," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User State" )	
			CASE "USER ZIP" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERZIP," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Zip" )	
			CASE "USER PHONE" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERPHONE," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Phone" )	
			CASE "USER FAX" 
				tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-USERFAX," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "User Fax" )	
			//Start Code Change ----11.03.2016
		END CHOOSE
		
		IF MidA( Upper ( ls_field_description ), 1, 5 ) = "LABEL" THEN
			ls_label_data =  MidA( ls_field_description, 7, 240 )  //Start Code Change ----08.26.2015 #V15 maha - modified length from 100
			tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "LABEL-" + MidA(ls_label_data, 1, 5 ) + ";" + String( li_app_field_id ))
			tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( ls_label_data  )		
		ELSEIF Upper( ls_field_description) = "RECTANGLE" THEN
			tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "Rectangle," + String( li_app_field_id ))		
			tab_1.tabpage_design.ole_edit.object.Annotationtype(4)		
			tab_1.tabpage_design.ole_edit.object.Draw( li_x_pos, li_y_pos, ll_width, ll_height )	
			ll_color = of_highlight_color(ls_color)
			tab_1.tabpage_design.ole_edit.object.SetSelectedAnnotationFillColor( ll_color )	
			//tab_1.tabpage_design.ole_edit.object.SetSelectedAnnotationFillColor( 8454143 )	
			CONTINUE
		ELSEIF Upper( ls_field_description) = "HOLLOWRECTANGLE" THEN
			tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "HollowRectangle," + String( li_app_field_id ))		
			tab_1.tabpage_design.ole_edit.object.Annotationtype(3)		
			tab_1.tabpage_design.ole_edit.object.Draw( li_x_pos, li_y_pos, ll_width, ll_height )				
			CONTINUE	
		ELSEIF MidA( Upper ( ls_field_description ), 1, 6 ) = "FUTURE" THEN  //Start Code Change ----09.27.2011 #V12 maha
			tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "SP-FUTUREDATE," + String( li_app_field_id) )		
			tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( MidA( Upper ( ls_field_description ), 1, len(ls_field_description) -1 )  )	
		END IF
	
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
		END CHOOSE
		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)	
		CONTINUE
	END IF
	
	//w_train_app.tab_1.tabpage_design.st_field.Text = ls_tbl_nm + "->" + ls_fld_nm
	CHOOSE CASE ls_object_type
		CASE "T"
			ls_field_type = ds_field_properties.GetItemString( li_fld_loop, "sys_fields_field_type" )
			ls_lookup_link_type = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_type" )
			ls_lookup_link_field = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_field" )
			IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
				ls_field_type = "C"			
			END IF
		CHOOSE CASE Upper( ls_field_type )
			CASE "C"
				ls_fld_display = FillA( "x", li_field_len )
			CASE "I"
				ls_fld_display = FillA( "#", li_field_len )				
			CASE "D"
				ls_fld_display = "mm/dd/yyyy"
			CASE "N"
				ls_fld_display = FillA( "#", li_field_len )								
		END CHOOSE

		if IsNull(ls_fld_display) then ls_fld_display = "" //Add by Evan on 08.04.2009
		IF LenA(ls_fld_display) > 255 THEN ls_fld_display = LeftA(ls_fld_display, 255) //limit 260 - alfee 11.03.2009
		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
		END CHOOSE
		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	CASE "B"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( ds_field_properties.GetItemNumber( ds_field_properties.GetRow(), "field_id" ) )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)			
	CASE "Y1"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "YesBox")
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 255 )		
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
		
		//no
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "NoBox")
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 0 )
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos + 30, li_y_pos, 20,20)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)					
	CASE "Y2"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "YesCheck")
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)							
	CASE "C"		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String( li_app_field_id ) + "Check" )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
		END CHOOSE
		tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	END CHOOSE
	tab_1.tabpage_design.uo_bar.r_bar.Width = tab_1.tabpage_design.uo_bar.r_bar.Width + li_step
END FOR

IF ai_field_id = 0 THEN
	//jadtab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 0 )
	//jadtab_1.tabpage_design.ole_edit.object.LoadAnnotations( is_app_path + String( ii_app_id ) + "-" + String( ii_current_page ) + ".ano",ii_current_page ,ii_current_page , 0 )
END IF




//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-10
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> The GOTO statement is currently unsuported.
//$<modification> Encapsulate the following script into of_cleanup and have the application
//$<modification> call of_cleanup to provide the same functionality. 
//Cleanup:
//
//ib_loading_annotations = False
//
//tab_1.tabpage_design.ole_edit.object.ScrollPositionX( li_prev_scrollX )		
//tab_1.tabpage_design.ole_edit.object.ScrollPositionY( li_prev_scrollY )			
//
//tab_1.tabpage_design.ole_edit.SetRedraw( True )
//
//w_train_app.tab_1.tabpage_design.st_field.Text = "Loading complete."
//
//tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
//
//tab_1.tabpage_design.uo_bar.Visible = False
//
//Return 0

Return of_cleanup(li_prev_scrollX,li_prev_scrollY)
//---------------------------- APPEON END ----------------------------



end function

public function integer of_auto_align_all ();Long ll_min_x
Long ll_y_scan = 1
Long ll_y_pos
Long ll_app_field_id
Long ll_max_y
String ls_app_field_id
Long ll_min_y
Long ll_x_scan = 1
Long ll_x_pos
Long ll_max_x
Integer i

//ALIGN TOP
if of_check_for_image() = -1 then return -1//maha 031505

SELECT MAX( y_pos )
INTO :ll_max_y
FROM app_field_prop
WHERE app_id = :ii_app_id AND
  	   page = :ii_current_page;

ib_loading_annotations = True

ll_max_y = ll_max_y + 100

DO WHILE TRUE
	
	SELECT Min( x_pos )
	INTO :ll_min_x
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	y_pos >= :ll_y_scan AND y_pos <=:ll_y_scan + 25;

	SELECT y_pos, app_field_id
	INTO: ll_y_pos, :ll_app_field_id
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	( y_pos >= :ll_y_scan AND y_pos < :ll_y_scan + 25 ) AND
			  x_pos = :ll_min_x;

	ls_app_field_id = String( ll_app_field_id )
	ii_app_field_id = ll_app_field_id
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )

	tab_1.tabpage_design.dw_1.Retrieve( ii_app_id, ii_current_page, ll_y_pos )
	
	if tab_1.tabpage_design.dw_1.rowcount( ) > 1 THEN
		ll_y_scan = ll_y_scan + 10
		ib_auto_align_all = True
		of_auto_align()
		ib_auto_align_all = False		
	END IF

	FOR i = 1 TO tab_1.tabpage_design.dw_1.RowCount( )
		ls_app_field_id = String( tab_1.tabpage_design.dw_1.GetItemNumber( i, "app_field_id" ) )
		tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ll_app_field_id )			
	END FOR
	
	IF ll_y_scan > ll_max_y + 30 THEN
		EXIT
	END IF
	
	ll_y_scan = ll_y_scan + 20
	
LOOP

ib_loading_annotations = False

COMMIT;

SELECT MAX( x_pos )
INTO :ll_max_x
FROM app_field_prop
WHERE app_id = :ii_app_id AND
  	   page = :ii_current_page;

//messagebox("", ll_max_y )


DO WHILE TRUE
	
	SELECT Min( y_pos )
	INTO :ll_min_y
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	x_pos >= :ll_x_scan AND x_pos <=:ll_x_scan + 25;

	SELECT x_pos, app_field_id
	INTO: ll_x_pos, :ll_app_field_id
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	( x_pos >= :ll_x_scan AND x_pos < :ll_x_scan + 25 ) AND
			y_pos = :ll_min_y;

	ls_app_field_id = String( ll_app_field_id )
	ii_app_field_id = ll_app_field_id
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )

	tab_1.tabpage_design.dw_2.Retrieve( ii_app_id, ii_current_page, ll_x_pos, ll_min_y )
	
	if tab_1.tabpage_design.dw_2.rowcount( ) > 1 THEN
		ll_x_scan = ll_x_scan + 10
		//of_auto_align()
	END IF

	FOR i = 1 TO tab_1.tabpage_design.dw_2.RowCount( )
		ll_app_field_id =  tab_1.tabpage_design.dw_2.GetItemNumber( i, "app_field_id" ) 
		//tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )			
		tab_1.tabpage_design.dw_fld_prop.Retrieve( ll_app_field_id )
		tab_1.tabpage_design.dw_2.SetItem( i, "x_pos", ll_x_pos )
		ii_ancor_x = ll_x_pos
		ii_ancor_y = tab_1.tabpage_design.dw_2.GetItemNumber( i, "y_pos" )
		tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )		
		//MESSAGEBOX(String(ll_app_field_id), "AlignNext")		
		//dw_2.Update( )
		//of_delete_annotations( )
		//of_create_annotations( 0 )
	END FOR
	
	//MessageBox("", dw_1.RowCount())
	
	IF ll_x_scan > ll_max_x + 30 THEN
		EXIT
	END IF
	
	ll_x_scan = ll_x_scan + 10
	
LOOP

ib_loading_annotations = False
ib_moving_field = False

	//301 - 50 = 251
//	SELECT *
//	FROM app_field_prop
//	WHERE app_id = 84 AND
//   	   page = 10 AND
//			y_pos >= 301 -50 AND
//	    	y_pos <= 301 + 50;
//
//LOOP


//tab_1.Tabpage_design.SetRedraw( True )

Return 0
end function

public function integer of_auto_align_tops ();Long ll_min_x
Long ll_y_scan = 1
Long ll_y_pos
Long ll_app_field_id
Long ll_max_y
String ls_app_field_id
Long ll_min_y
Long ll_x_scan = 1
Long ll_x_pos
Long ll_max_x
Integer i

//ALIGN TOP
if of_check_for_image() = -1 then return -1//maha 031505

SELECT MAX( y_pos )
INTO :ll_max_y
FROM app_field_prop
WHERE app_id = :ii_app_id AND
  	   page = :ii_current_page;

ib_loading_annotations = True
ib_moving_field = True

ll_max_y = ll_max_y + 100

DO WHILE TRUE
	
	SELECT Min( x_pos )
	INTO :ll_min_x
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	y_pos >= :ll_y_scan AND y_pos <=:ll_y_scan + 25;

	SELECT y_pos, app_field_id
	INTO: ll_y_pos, :ll_app_field_id
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	( y_pos >= :ll_y_scan AND y_pos < :ll_y_scan + 25 ) AND
			  x_pos = :ll_min_x;

	ls_app_field_id = String( ll_app_field_id )
	ii_app_field_id = ll_app_field_id
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )

	tab_1.tabpage_design.dw_1.Retrieve( ii_app_id, ii_current_page, ll_y_pos )
	
	if tab_1.tabpage_design.dw_1.rowcount( ) > 1 THEN
		ll_y_scan = ll_y_scan + 10
		ib_auto_align_all = True
		of_auto_align()
		ib_auto_align_all = False		
	END IF

	FOR i = 1 TO tab_1.tabpage_design.dw_1.RowCount( )
		ls_app_field_id = String( tab_1.tabpage_design.dw_1.GetItemNumber( i, "app_field_id" ) )
		tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ll_app_field_id )			
	END FOR
	
	IF ll_y_scan > ll_max_y + 30 THEN
		EXIT
	END IF
	
	ll_y_scan = ll_y_scan + 20
	
LOOP

ib_loading_annotations = False
ib_moving_field = False


RETURN 0
end function

public function integer of_auto_align_sides ();Long ll_min_x
Long ll_y_scan = 1
Long ll_y_pos
Long ll_app_field_id
Long ll_max_y
String ls_app_field_id
Long ll_min_y
Long ll_x_scan = 1
Long ll_x_pos
Long ll_max_x
Integer i

if of_check_for_image() = -1 then return -1//maha 031505

ib_loading_annotations = True
ib_moving_field = True

SELECT MAX( x_pos )
INTO :ll_max_x
FROM app_field_prop
WHERE app_id = :ii_app_id AND
  	   page = :ii_current_page;

//messagebox("", ll_max_y )


DO WHILE TRUE
	
	SELECT Min( y_pos )
	INTO :ll_min_y
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	x_pos >= :ll_x_scan AND x_pos <=:ll_x_scan + 25;

	SELECT x_pos, app_field_id
	INTO: ll_x_pos, :ll_app_field_id
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :ii_current_page AND
      	( x_pos >= :ll_x_scan AND x_pos < :ll_x_scan + 25 ) AND
			y_pos = :ll_min_y;

	ls_app_field_id = String( ll_app_field_id )
	ii_app_field_id = ll_app_field_id
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )

	tab_1.tabpage_design.dw_2.Retrieve( ii_app_id, ii_current_page, ll_x_pos, ll_min_y )
	
	if tab_1.tabpage_design.dw_2.rowcount( ) > 1 THEN
		ll_x_scan = ll_x_scan + 10
		//of_auto_align()
	END IF

	FOR i = 1 TO tab_1.tabpage_design.dw_2.RowCount( )
		ll_app_field_id =  tab_1.tabpage_design.dw_2.GetItemNumber( i, "app_field_id" ) 
		//tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( ls_app_field_id )			
		tab_1.tabpage_design.dw_fld_prop.Retrieve( ll_app_field_id )
		tab_1.tabpage_design.dw_2.SetItem( i, "x_pos", ll_x_pos )
		ii_ancor_x = ll_x_pos
		ii_ancor_y = tab_1.tabpage_design.dw_2.GetItemNumber( i, "y_pos" )
		tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )		
		//MESSAGEBOX(String(ll_app_field_id), "AlignNext")		
		//dw_2.Update( )
		//of_delete_annotations( )
		//of_create_annotations( 0 )
	END FOR
	
	//MessageBox("", dw_1.RowCount())
	
	IF ll_x_scan > ll_max_x + 30 THEN
		EXIT
	END IF
	
	ll_x_scan = ll_x_scan + 10
	
LOOP

ib_loading_annotations = False
ib_moving_field = False

RETURN 0
end function

public function integer of_add_hollow_box ();String ls_type
String ls_text
Long li_app_id
Long ll_field_id
Long li_page
long ll_color //maha 06.19.2012
string ls_color //maha 06.19.2012
gs_pass_ids lgs_color

if of_check_for_image() = -1 then return -1//maha 031505

li_page = w_train_app.ii_current_page
li_app_id = w_train_app.ii_app_id

SELECT Max( app_field_id )  
INTO :ll_field_id  
FROM app_field_prop 
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox("Database Error", tr_training_data.SQLERRTEXT )
END IF

ll_field_id++

//Start Code Change ----06.18.2012 #V12 maha
open(w_select_highlight_color)
lgs_color = message.powerobjectparm
ls_color = lgs_color.ls_ref_value
ll_color = lgs_color.l_app_id
//End Code Change ----06.18.2012

ib_loading_annotations = True
tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( "Rectangle," + String( ll_field_id ))		
tab_1.tabpage_design.ole_edit.object.Annotationtype(4)		
tab_1.tabpage_design.ole_edit.object.Draw( 1, 1,30,30)	
tab_1.tabpage_design.ole_edit.object.SetSelectedAnnotationFillColor( ll_color )  //Start Code Change ----06.18.2012 #V12 maha 
//tab_1.tabpage_design.ole_edit.object.SetSelectedAnnotationFillColor( 8454143 )
ib_loading_annotations = False

INSERT INTO app_field_prop  
         ( app_field_id,   
           app_id,   
           table_id,   
           field_id,   
           lookup_link_type,   
           lookup_link_field,   
           record_number,   
           x_pos,   
           y_pos,   
           width,   
           query_field,   
           query_value,   
           page,   
           box_type,   
           box_height,   
           box_width,   
           box_yes_x,   
           box_yes_y,   
           box_yes_value,   
           box_no_x,   
           box_no_y,   
           box_no_value,   
           font_type,   
           font_size,   
           font_color,   
           font_background,   
           font_underline,   
           font_bold,   
           query_operator,   
           field_description,   
           personal_data,   
           height,   
           annotation_width,   
           past_years_query,   
           format,   
           connect_field_id,   
           connect_field_sort )  
  VALUES ( :ll_field_id,   
           :li_app_id,   
           99,   
           0,   
           null,   
           null,   
           null,   
           1,   
           1,   
           null,   
           null,   
           null,   
           :li_page,   
           null,   
           30,   
           30,   
           null,   
           null,   
           null,   
           null,   
           null,   
           null,   
			  null,
           null,   
           null,   
          :ls_color,   
           null,   
           null,   
           null,   
           'Rectangle',   
           'N',   
           null,   
           null,   
           null,   
           null,   
           null,   
           null )
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox("Database Error", tr_training_data.SQLERRTEXT )
END IF

//COMMIT USING tr_training_data;

tab_1.tabpage_design.ole_edit.Object.Annotationtype(11)	

Return 1
end function

public function integer of_clear_annotations ();Long li_Cnt
Long i
Long p
String ls_annotation_group
Integer li_page_cnt

if of_check_for_image() = -1 then return -1//maha 031505

li_page_cnt = tab_1.tabpage_design.ole_edit.Object.PageCount()

FOR p = 1 TO li_page_cnt

	tab_1.tabpage_design.ole_edit.Object.Page( p )
	tab_1.tabpage_design.ole_edit.Object.Display()
	
	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	

	li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()

	FOR i = 0 TO li_cnt - 1
		ls_annotation_group = tab_1.tabpage_design.ole_edit.Object.GetAnnotationGroup( 0 )
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ls_annotation_group )		
	END FOR
	
	tab_1.tabpage_design.ole_edit.Object.save()  //Start Code Change ----01.19.2010 #V10 maha - each page has to be saved separately.

END FOR


Return 0
end function

public function integer of_clear_annos ();//Start change 01.19.2009 - maha - replaced orig code with that from of_clear annotations

//Start Code Change ----01.19.2010 #V10 maha - changed to call other function
of_clear_annotations( )

return 0

//Long li_Cnt
//Long i
//Long p
//String ls_annotation_group
//Integer li_page_cnt
//
//if of_check_for_image() = -1 then return -1//maha 031505
//
//li_page_cnt = tab_1.tabpage_design.ole_edit.Object.PageCount()
//
//FOR p = 1 TO li_page_cnt
//
//	tab_1.tabpage_design.ole_edit.Object.Page( p )
//	tab_1.tabpage_design.ole_edit.Object.Display()
//	
//	tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )	
//
//	li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()
//
//	FOR i = 0 TO li_cnt - 1
//		ls_annotation_group = tab_1.tabpage_design.ole_edit.Object.GetAnnotationGroup( 0 )
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ls_annotation_group )		
//	END FOR
//
//END FOR
//
//Return 0
//


//Long li_cnt
//Integer p
//INTEGER LI_PAGE_CNT
//String ls_label_data,ls_Rtn
//String ls_field_description
//String ls_object_type
//String ls_field_type
//String ls_lookup_link_type
//String ls_group_nm
//String ls_fld_desc
//String ls_lookup_link_field
//String ls_fld_display
//String ls_font_type
//Long ll_field_id
//Long ll_table_id
//Long li_field_len
//long li_app_field_id //modified 071802 maha
//String ls_fld_nm
//String ls_tbl_nm
//n_ds ds_field_properties
//long li_fld_cnt
//Long li_x_pos
//Long li_y_pos
//Long li_fld_loop
//Long li_prev_scrollY
//Long li_prev_scrollX
////Long li_step
//
//if of_check_for_image() = -1 then return -1//maha 031505
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-07-17 By: Scofield
////$<Reason> Verify if the directory has write right for the current user.
//
//ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
//if Len(ls_Rtn) > 0 then
//	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
//	Return -1
//end if
////---------------------------- APPEON END ----------------------------
//
//li_page_cnt = tab_1.tabpage_design.ole_edit.Object.PageCount()
//
//ds_field_properties = CREATE n_ds
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-20
////$<modify> 04.05.2006 By: Rodger Wu
////$<reason> Performance Tuning
////$<modification> Write script to retrieve data from a cache instead of from the database.
//
///*
//ds_field_properties.DataObject = "d_app_field_properties_all"
//ds_field_properties.SetTransObject( tr_training_data )
//*/
//ds_field_properties.DataObject = "d_app_field_properties_for_copying"
//ds_field_properties.SetTransObject( tr_training_data )
//ds_field_properties.Retrieve( ii_app_id )
////---------------------------- APPEON END ----------------------------
//
//FOR p = 1 TO li_page_cnt
//
//	tab_1.tabpage_design.ole_edit.Object.Page( p )
//	tab_1.tabpage_design.ole_edit.Object.Display()
//
//
//	ib_loading_annotations = True
//
//tab_1.tabpage_design.uo_bar.r_bar.Width = 0
//
//li_prev_scrollY = tab_1.tabpage_design.ole_edit.object.ScrollPositionY( )
//li_prev_scrollX = tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )
//
//tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
//tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )			
//
////ds_field_properties = CREATE n_ds
////ds_field_properties.DataObject = "d_app_field_properties_all"
////ds_field_properties.SetTransObject( tr_training_data )
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-21
////$<modify> 04.05.2006 By: Rodger Wu
////$<reason> Performance Tuning
////$<modification> Write script to retrieve data from a cache instead of from the database.
//
///* li_fld_cnt = ds_field_properties.Retrieve( Ii_app_id, p ) */
//ds_field_properties.SetFilter( "page = " + string( p ) )
//ds_field_properties.Filter()
//li_fld_cnt = ds_field_properties.Rowcount()
////---------------------------- APPEON END ----------------------------
//
//FOR li_fld_loop = 1 TO li_fld_cnt
//	ls_object_type = ds_field_properties.GetItemString( li_fld_loop, "object_type" )
//	li_app_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "app_field_id" )
//	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id))		
//	li_field_len = ds_field_properties.GetItemNumber( li_fld_loop, "width" )
//	li_x_pos = ds_field_properties.GetItemNumber( li_fld_loop, "x_pos" )
//	li_y_pos = ds_field_properties.GetItemNumber( li_fld_loop, "y_pos" )
//	ll_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "field_id" )	
//	ll_table_id = ds_field_properties.GetItemNumber( li_fld_loop, "table_id" )	
//	ls_field_description = ds_field_properties.GetItemString( li_fld_loop, "field_description" )
//			
//	IF ll_table_id = 99 THEN
//		CHOOSE CASE Upper( ls_field_description )
//			CASE "TODAYS DATE"
//				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-TODAYSDATE," + String( li_app_field_id ) )		
//				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "MM/DD/YYYY" )		
//			CASE "CURRENT TIME"
//				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-CURRENTTIME," + String( li_app_field_id ))				
//				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "HH:MMa" )		
//			CASE "USER ID"
//				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERID," + String( li_app_field_id ))		
//				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "XXXXXXXXXX" )		
//		END CHOOSE
//		
//		IF Mid( Upper ( ls_field_description ), 1, 5 ) = "LABEL" THEN
//			ls_label_data =  Mid( ls_field_description, 7, 100 ) 
//			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "LABEL-" + Mid(ls_label_data, 1, 20 ) + ";" + String( li_app_field_id ))		
//			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "LABEL-" + Mid(ls_label_data, 1, 5 ) + ";" + String( li_app_field_id ))
//		ELSEIF Upper( ls_field_description) = "RECTANGLE" THEN
//			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "Rectangle," + String( li_app_field_id ))		
//		ELSEIF Upper( ls_field_description) = "HOLLOWRECTANGLE" THEN
//			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "HollowRectangle," + String( li_app_field_id ))		
//		END IF
//			
//	
//		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
//		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
//			CASE 1
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
//			CASE 2
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
//			CASE 3
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
//		END CHOOSE
//		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
//			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
//		ELSE
//			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
//		END IF
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)	
//		CONTINUE
//	END IF
//	
//	//w_train_app.tab_1.tabpage_design.st_field.Text = ls_tbl_nm + "->" + ls_fld_nm
//
//
//	CHOOSE CASE ls_object_type
//		CASE "T"
//			ls_field_type = ds_field_properties.GetItemString( li_fld_loop, "sys_fields_field_type" )
//			ls_lookup_link_type = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_type" )
//			ls_lookup_link_field = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_field" )
//			IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
//				ls_field_type = "C"			
//			END IF
//		CHOOSE CASE Upper( ls_field_type )
//			CASE "C"
//				ls_fld_display = Fill( "x", li_field_len )
//			CASE "I"
//				ls_fld_display = Fill( "#", li_field_len )				
//			CASE "D"
//				ls_fld_display = "mm/dd/yyyy"
//			CASE "N"
//				ls_fld_display = Fill( "#", li_field_len )
//			CASE else //maha app100305
//				ls_fld_display = "XXXXXXXXXXXXX"
//		END CHOOSE
//					
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) )
//		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
//		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
//		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
//			CASE 1
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
//			CASE 2
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
//			CASE 3
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
//		END CHOOSE
//		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
//			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
//		ELSE
//			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
//		END IF
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
//	CASE "B"
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ds_field_properties.GetItemNumber( ds_field_properties.GetRow(), "field_id" ) )
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)			
//	CASE "Y1"
//		//yes box
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox")
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
//		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 255 )		
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
//		
//		//no
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox")
//		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 0 )
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos + 30, li_y_pos, 20,20)		
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)					
//	CASE "Y2"
//		//yes box
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesCheck")
//		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)		
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)							
//	CASE "C"		
//		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) + "Check" )
//		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
//		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
//			CASE 1
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
//			CASE 2
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
//			CASE 3
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
//				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
//		END CHOOSE
//		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)
//		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
//	END CHOOSE
//	//tab_1.tabpage_design.uo_bar.r_bar.Width = tab_1.tabpage_design.uo_bar.r_bar.Width + li_step
//END FOR
//
////IF ai_field_id = 0 THEN
//	//jadtab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ai_app_id ) + "-" + String( ai_page ) + ".ano",ai_page ,ai_page , 0 )
//	//jadtab_1.tabpage_design.ole_edit.object.LoadAnnotations( is_app_path + String( ai_app_id ) + "-" + String( ai_page ) + ".ano",ai_page ,ai_page , 0 )
////END IF
//
//	tab_1.tabpage_design.ole_edit.Object.Save()
//END FOR
//
////Cleanup:
//DESTROY ds_field_properties //maha added 031405
//
//ib_loading_annotations = False
//
//tab_1.tabpage_design.ole_edit.object.ScrollPositionX( li_prev_scrollX )		
//tab_1.tabpage_design.ole_edit.object.ScrollPositionY( li_prev_scrollY )			
//
////tab_1.tabpage_design.ole_edit.SetRedraw( True )
//
//w_train_app.tab_1.tabpage_design.st_field.Text = "Loading complete."
//
//tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		
//
//tab_1.tabpage_design.uo_bar.Visible = False
//
//Return 0
//
end function

public function integer of_clear_annos_one_page (integer ai_old_page, integer ai_new_page);Long 		li_cnt
Integer 	li_current_page
Integer 	p
INTEGER 	LI_PAGE_CNT
String	ls_Rtn

p = ai_new_page

if of_check_for_image() = -1 then return -1//maha 031505

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-17 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

li_current_page = tab_1.tabpage_design.ole_edit.Object.Page(  )

tab_1.tabpage_design.ole_edit.Object.Page( p )
tab_1.tabpage_design.ole_edit.Object.Display()

ib_loading_annotations = True

tab_1.tabpage_design.uo_bar.r_bar.Width = 0

String ls_label_data
String ls_field_description
String ls_object_type
String ls_field_type
String ls_lookup_link_type
String ls_group_nm
String ls_fld_desc
String ls_lookup_link_field
String ls_fld_display
String ls_font_type
Long ll_field_id
Long ll_table_id
Long li_field_len
long li_app_field_id //modified 071802 maha
String ls_fld_nm
String ls_tbl_nm
n_ds ds_field_properties
long li_fld_cnt
Long li_x_pos
Long li_y_pos
Long li_fld_loop
Long li_prev_scrollY
Long li_prev_scrollX
//Long li_step


li_prev_scrollY = tab_1.tabpage_design.ole_edit.object.ScrollPositionY( )
li_prev_scrollX = tab_1.tabpage_design.ole_edit.object.ScrollPositionX( )

tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )			

ds_field_properties = CREATE n_ds
ds_field_properties.DataObject = "d_app_field_properties_all"
ds_field_properties.SetTransObject( tr_training_data )
li_fld_cnt = ds_field_properties.Retrieve( ii_app_id, ai_old_page )

FOR li_fld_loop = 1 TO li_fld_cnt
	ls_object_type = ds_field_properties.GetItemString( li_fld_loop, "object_type" )
	li_app_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "app_field_id" )
	li_field_len = ds_field_properties.GetItemNumber( li_fld_loop, "width" )
	li_x_pos = ds_field_properties.GetItemNumber( li_fld_loop, "x_pos" )
	li_y_pos = ds_field_properties.GetItemNumber( li_fld_loop, "y_pos" )
	ll_field_id = ds_field_properties.GetItemNumber( li_fld_loop, "field_id" )	
	ll_table_id = ds_field_properties.GetItemNumber( li_fld_loop, "table_id" )	
	ls_field_description = ds_field_properties.GetItemString( li_fld_loop, "field_description" )
			
	IF ll_table_id = 99 THEN
		CHOOSE CASE Upper( ls_field_description )
			CASE "TODAYS DATE"
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-TODAYSDATE," + String( li_app_field_id ) )		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "MM/DD/YYYY" )		
			CASE "CURRENT TIME"
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-CURRENTTIME," + String( li_app_field_id ))				
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "HH:MMa" )		
			CASE "USER ID"
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERID," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "XXXXXXXXXX" )
			CASE 	"SIGNATURE"	// E-Sign:	added by long.zhang 06.13.2011
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-SIGNATURE," + String( ll_field_id ))
			CASE 	"FUTURE DATE"	// E-Sign:	added by long.zhang 06.13.2011
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-FUTURE DATE," + String( ll_field_id ))
		//Start Code Change ----11.03.2016 #V153 maha
			CASE "USER ID"
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERID," + String( li_app_field_id ))		
				tab_1.tabpage_design.ole_edit.Object.AnnotationStampText( "XXXXXXXXXX" )
			CASE "USER STREET" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERSTREET," + String(  ll_field_id  ))			
			CASE "USER STREE2" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERSTREE2," + String(  ll_field_id  ))		
			CASE "USER CITY" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERCITY," + String( ll_field_id ))		
			CASE "USER STATE" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERSTATE," + String( ll_field_id ))		
			CASE "USER ZIP" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERZIP," + String( ll_field_id ))			
			CASE "USER PHONE" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERPHONE," + String( ll_field_id ))			
			CASE "USER FAX" 
				tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "SP-USERFAX," + String( ll_field_id ))			
			//Start Code Change ----11.03.2016
				CONTINUE	
		END CHOOSE
		
		IF MidA( Upper ( ls_field_description ), 1, 5 ) = "LABEL" THEN
			ls_label_data =  MidA( ls_field_description, 7, 100 ) 
			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "LABEL-" + MidA(ls_label_data, 1, 20 ) + ";" + String( li_app_field_id ))
			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "LABEL-" + MidA(ls_label_data, 1, 5 ) + ";" + String( li_app_field_id )) //maha 031405

		ELSEIF Upper( ls_field_description) = "RECTANGLE" THEN
			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "Rectangle," + String( li_app_field_id ))		
		ELSEIF Upper( ls_field_description) = "HOLLOWRECTANGLE" THEN
			tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( "HollowRectangle," + String( li_app_field_id ))		
		END IF
			
	
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
		END CHOOSE
		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)	
		CONTINUE
	END IF
	
	//w_train_app.tab_1.tabpage_design.st_field.Text = ls_tbl_nm + "->" + ls_fld_nm
	CHOOSE CASE ls_object_type
		CASE "T"
			ls_field_type = ds_field_properties.GetItemString( li_fld_loop, "sys_fields_field_type" )
			ls_lookup_link_type = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_type" )
			ls_lookup_link_field = ds_field_properties.GetItemString( li_fld_loop, "lookup_link_field" )
			IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
				ls_field_type = "C"			
			END IF
		CHOOSE CASE Upper( ls_field_type )
			CASE "C"
				ls_fld_display = FillA( "x", li_field_len )
			CASE "I"
				ls_fld_display = FillA( "#", li_field_len )				
			CASE "D"
				ls_fld_display = "mm/dd/yyyy"
			CASE "N"
				ls_fld_display = FillA( "#", li_field_len )
			CASE else //maha app100305
				ls_fld_display = "XXXXXXXXXXXXX"
		END CHOOSE
					
		IF LenA(ls_fld_display) > 255 THEN ls_fld_display = LeftA(ls_fld_display, 255) //limit 260 - alfee 11.03.2009
					
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12			
		END CHOOSE
		IF ds_field_properties.GetItemNumber( li_fld_loop, "font_bold" ) = 1 THEN
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 0, 0)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	CASE "B"
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ds_field_properties.GetItemNumber( ds_field_properties.GetRow(), "field_id" ) )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)			
	CASE "Y1"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox")
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 255 )		
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 20,20)
		
		//no
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox")
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 0 )
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos + 30, li_y_pos, 20,20)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)					
	CASE "Y2"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesCheck")
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)							
	CASE "C"		
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String( li_app_field_id ) + "Check" )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		CHOOSE CASE ds_field_properties.GetItemNumber( li_fld_loop, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
		END CHOOSE
		//tab_1.tabpage_design.ole_edit.object.Draw(li_x_pos, li_y_pos, 10,10)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	END CHOOSE
	//tab_1.tabpage_design.uo_bar.r_bar.Width = tab_1.tabpage_design.uo_bar.r_bar.Width + li_step
END FOR

//IF ai_field_id = 0 THEN
	//jadtab_1.tabpage_design.ole_edit.object.SaveAnnotations( is_app_path + String( ai_app_id ) + "-" + String( ai_page ) + ".ano",ai_page ,ai_page , 0 )
	//jadtab_1.tabpage_design.ole_edit.object.LoadAnnotations( is_app_path + String( ai_app_id ) + "-" + String( ai_page ) + ".ano",ai_page ,ai_page , 0 )
//END IF
	tab_1.tabpage_design.ole_edit.Object.Save()

//Cleanup:

ib_loading_annotations = False

tab_1.tabpage_design.ole_edit.object.ScrollPositionX( li_prev_scrollX )		
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( li_prev_scrollY )			

//tab_1.tabpage_design.ole_edit.SetRedraw( True )

w_train_app.tab_1.tabpage_design.st_field.Text = "Loading complete."

tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		

tab_1.tabpage_design.uo_bar.Visible = False

tab_1.tabpage_design.ole_edit.Object.Page( li_current_page )
tab_1.tabpage_design.ole_edit.Object.Display()


Return 0
end function

public function integer of_dw_field_dclick ();long	ll_Row

//created maha 042004 called frim dw_field double click as well as ole_edit dragdrop for to trap for address type

IF ii_align = 1 OR ii_copy_fields = 1 THEN
	MessageBox("Tools", "You must select the SELECT FIELD tool from the tools menu to select a field." )
	Return -1
END IF
ib_new_select = True

ll_Row = tab_1.tabpage_design.dw_field_tv.GetRow()			//Added by Scofield on 2008-11-28
if ll_Row <= 0 or ll_Row > tab_1.tabpage_design.dw_field_tv.RowCount() then Return -1

//maha 042004 address link trap
if tab_1.tabpage_design.dw_field_tv.GetItemNumber( ll_Row,"field_id") = 91125 or tab_1.tabpage_design.dw_field_tv.GetItemNumber( ll_Row,"parent_field") = 91125 then
	messagebox("Mapping error","The field Address Type cannot be mapped.  It can only be used for Query Filters.")
	return -1
end if
//maha 020405 billing address trap
if tab_1.tabpage_design.dw_field_tv.GetItemNumber( ll_Row,"field_id") = 11223361 or tab_1.tabpage_design.dw_field_tv.GetItemNumber( ll_Row,"parent_field") = 11223361 then
	messagebox("Mapping error","The field Billing Address Id cannot be mapped.  It can only be used in a Query.")
	return -1
end if

of_select_button()
return 1

end function

public function integer of_field_name_visible ();//function created maha 032304

if tab_1.selectedtab = 3 and is_preview_mode = "Train" then
	st_field_name.visible = true
else
	st_field_name.visible = false
end if

return 1
end function

public function integer of_clean_data ();//------------------- APPEON BEGIN -------------------
//$<modify> Evan 10.25.2011
//$<reason> V12.1 Website Population
/*
gnv_appeondb.of_startqueue( )

Delete From app_field_prop 
Where field_description Is Null
USING tr_training_data;

Delete From app_field_prop 
Where y_pos < 1
USING tr_training_data;

Delete From app_field_prop 
Where x_pos < 1
USING tr_training_data;

COMMIT USING SQLCA;

update app_field_prop 
set width = 1 
Where width < 1 or width is null
USING tr_training_data;

COMMIT USING SQLCA;

gnv_appeondb.of_commitqueue( )
*/
gnv_appeondb.of_startqueue( )
Delete app_field_prop From app_hdr, app_field_prop
Where (app_hdr.app_id = app_field_prop.app_id and app_hdr.mapping_type = 1) and
		(app_field_prop.field_description Is Null or
		app_field_prop.y_pos < 1 or
		app_field_prop.x_pos < 1)
USING SQLCA;

update app_field_prop 
set app_field_prop.width = 1
From app_hdr, app_field_prop
Where (app_hdr.app_id = app_field_prop.app_id and app_hdr.mapping_type = 1) and
		(app_field_prop.width < 1 or app_field_prop.width is null)
USING SQLCA;
gnv_appeondb.of_commitqueue( )
//------------------- APPEON END ---------------------

return 1
end function

public function integer of_addr_query_setup ();//maha created 030905 for the address query fields for group data

Integer li_found
Integer li_retval
String ls_lookup_code
String ls_lookup_type
String ls_data
integer chk
DataWindowChild dwchild
		
li_retval = tab_1.tabpage_design.dw_fld_prop.GetChild( "query_field_addr", dwchild )
	dwchild.SetTransObject( w_train_app.tr_training_data )
	dwchild.Retrieve( 20)//address table
	ls_data = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "query_field_addr" )
	li_found = dwchild.Find( "field_name = '" + ls_data + "'", 1, 10000 )
	IF li_found > 0 THEN
		IF upper(ls_data) = "ACTIVE_STATUS" THEN
			tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.name = 'd_code_lookup_active_inactive'")
			tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.datacolumn = 'lookup_code'")			
			tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.displaycolumn = 'description'")
			tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.UseAsBorder = 'Yes'")
		else
			ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
			ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
			if ls_lookup_type = "C" or ls_lookup_type = "A" then
				IF ls_lookup_type = "C" THEN
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.name = 'd_dddw_code_lookup'")
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.datacolumn = 'lookup_code'")			
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.displaycolumn = 'description'")						
				ELSEIF ls_lookup_type = "A" THEN
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.name = 'd_dddw_address_lookup'")
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.datacolumn = 'lookup_code'")			
					tab_1.tabpage_design.dw_fld_prop.Modify( "query_value_addr.dddw.displaycolumn = 'entity_name'")
				end if
				tab_1.tabpage_design.dw_fld_prop.GetChild( "query_value_addr", dwchild )
				dwchild.SetTransObject( w_train_app.tr_training_data )
				dwchild.Retrieve( ls_lookup_code )
			end if
		end if
	END IF
	
	
return 1
end function

public function integer of_check_for_image ();//maha created 031505 to trap for functions run with no image available

if tab_1.tabpage_design.ole_edit.Object.Imagedisplayed = false then
	messagebox("Application","There is no Application Image.")
	return -1 //maha 031505
else 
	return 1
end if
end function

public function integer of_set_query_lookup (string as_lookup, string as_data, string as_lookup_code, string as_field);//maha created 042205 for setting the the query value lookups
//called from dw_fld_prop itemchanged and retrieveend as well as of_update

datawindowchild dwchild
		
//messagebox("of_setup_query_lookup","")
//debugbreak()
//Start Code Change ---- 02.09.2006 #256 maha	
iF as_lookup = "C" or as_lookup = "A" or as_lookup = "Q"  then
	IF as_lookup = "C" THEN
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.name = 'd_dddw_code_lookup'")
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.datacolumn = 'lookup_code'")			
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.displaycolumn = 'description'")						
	ELSEIF as_lookup = "A" THEN
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.name = 'd_dddw_address_lookup'")
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.datacolumn = 'lookup_code'")			
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.displaycolumn = 'entity_name'")
	
	ELSEIF as_lookup = "Q" THEN
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.name = 'd_dddw_quest_lookup_ia'")
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.datacolumn = 'quest_id'")			
		tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.displaycolumn = 'short_quest'")
		as_lookup_code = ""
	END IF
//End Code Change---02.09.2006	
	tab_1.tabpage_design.dw_fld_prop.GetChild( as_field , dwchild )
	dwchild.SetTransObject( w_train_app.tr_training_data )
	dwchild.Retrieve( as_lookup_code )
	dwchild.insertrow(0)  //Start Code Change ---- 05.30.2007 #V7 maha added to make the dropdown open another line deeper
	dwchild.scrolltorow(0)
	dwchild.setrow(0)
ELSEIF Upper( as_data ) = "ACTIVE_STATUS" THEN
	tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.name = 'd_code_lookup_active_inactive'")
	tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.datacolumn = 'lookup_code'")			
	tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.displaycolumn = 'description'")	
//Start Code Change ---- 06.15.2006 #548 maha	
else //not a lookup
	tab_1.tabpage_design.dw_fld_prop.Modify( as_field + ".dddw.name = ''")
END IF

return 1
end function

public function integer of_app_audit_track (long ai_appid);//Start Code Change ---- 02.22.2006 #280 maha
//function created maha 022206 to create audit records for applications
string ls_sql
string ls_date
date ld_today
time lt_now
long ll_rec
//string q = "'"
//Start Code Change ----10.09.2012 #V12 maha - moved the variable setting out of the declaration
ld_today = today()
lt_now = now()
//end Code Change ----10.09.2012

ls_date = string(year(ld_today)) + "-" + string(month(ld_today)) + "-" + string(day(ld_today))
ls_date = ls_date + " " + string(lt_now)
if ib_audit then
	select max(rec_id) into :ll_rec from app_hdr_audit;
	if isnull(ll_rec) then ll_rec = 0
	ll_rec++
	ls_sql = "Insert into app_hdr_audit(rec_id,app_id,change_date,user_id) values (" + string(ll_rec) + "," + string(ai_appid) + ",'" + ls_date +  "','" + gs_user_id + "' )" 
	//messagebox("",ls_sql)
	execute immediate :ls_sql using tr_training_data;
	ib_audit = false
end if

return 1
//End Code Change---02.22.2006

end function

private function integer of_cleanup (integer ai_prev_scrollx, integer ai_prev_scrolly);//////////////////////////////////////////////////////////////////////
// $<function>w_train_appof_cleanup()
// $<arguments> value	integer	ai_prev_scrollx
//	$<arguments> value	integer	ai_prev_scrolly						
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////
boolean lb_autorefresh //alfee 01.04.2010

ib_loading_annotations = False

lb_autorefresh = tab_1.tabpage_design.ole_edit.object.autorefresh //alfee 01.04.2010
tab_1.tabpage_design.ole_edit.object.autorefresh = TRUE //alfee 01.04.2010

tab_1.tabpage_design.ole_edit.object.ScrollPositionX( ai_prev_scrollX )		
tab_1.tabpage_design.ole_edit.object.ScrollPositionY( ai_prev_scrollY )			

tab_1.tabpage_design.ole_edit.object.autorefresh = lb_autorefresh //alfee 01.04.2010

//tab_1.tabpage_design.ole_edit.SetRedraw( True ) //avoiding screen blinks

w_train_app.tab_1.tabpage_design.st_field.Text = "Loading complete."

tab_1.tabpage_design.ole_edit.object.Annotationtype(11)		

tab_1.tabpage_design.uo_bar.Visible = False

Return 0
end function

public function integer of_query_batch_update ();integer li_selected_cnt
integer i

//msg.Text = " Click on each field that you want to copy then click the PASTE icon."
//w_train_app.st_msg.Visible = True

li_selected_cnt = UpperBound( is_selected_fields )  // I made it -1 because it made it work but not sure why???


FOR i = 1 TO li_selected_cnt
	
	
	ii_app_field_id = of_get_app_field_id(is_selected_fields[i])
	tab_1.tabpage_design.dw_fld_prop.Retrieve( ii_app_field_id )
//Start Code Change ---- 06.14.2006 #541 maha
	IF i = 1 THEN //for the first field only
		OpenWithParm( w_get_query_data, String( ii_app_field_id ) )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 2006-08-15 By: Liu Hongxin
		//$<reason> the window is invalid.
		/*
		w_get_query_data.cbx_only.visible = true
		*/
		//---------------------------- APPEON END ----------------------------
	end if
	
	if message.stringparm = "Cancel" then 
		//do nothing
		exit
	else
		If ii_cf_skip_record_number = 0 Then//Added by Appeon long.zhang 08.16.2016 (issue Application Mapping)
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "record_number", ii_cf_record_number )	
		End If
		
		if ii_cf_skip_query = 0 then //do not set if set to record num only
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_field", ii_cf_query_field )	
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_operator", ii_cf_query_operator )	
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "query_value", ii_cf_query_value )	
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "past_years_query", ii_cf_past_years_query )
		end if	
		//Start Code Change ----02.01.2011 #V11 maha 
		if ii_cf_do_fonts = 1 then
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "font_size", ii_cf_fontsize )
		end if
			
		tab_1.tabpage_design.dw_fld_prop.Update()
		if ii_cf_do_fonts = 1 then
			of_refresh_page( )
		end if
	end if
next

ii_cf_skip_query = 0 //reset the value
ii_cf_skip_record_number = 0  //reset the value, Added by Appeon long.zhang 08.16.2016 (issue Application Mapping)
//End Code Change---06.14.2006
w_train_app.of_enable_buttons()

return 1
end function

public function integer of_dupe_field_test (string as_field);//Start Code Change ---- 05.30.2006 #490 maha  //added to check for duplicate selected fields

integer i
integer ic

for i = 1 to upperbound(is_selected_fields)
	if as_field = is_selected_fields[i] then
		return 1
	end if
next

return 0
	

end function

public function long of_get_app_field_id (string as_selected_field);//Start Code Change ---- 05.05.2006 #514 maha //maha added to strip app_id 
long ll_ret
string ls_field

ls_field = as_selected_field


IF Upper(RightA( ls_field, 6 )) = "YESBOX" THEN
		ll_ret = long( MidA( ls_field, 1, LenA( ls_field ) - 6) )
	ELSEIF Upper(RightA( ls_field, 5 )) = "NOBOX" THEN
		ll_ret = long( MidA( ls_field, 1, LenA( ls_field ) - 5) )	
	ELSEIF Upper(LeftA( ls_field, 3 )) = "SP-" THEN		
		ll_ret = long( MidA( ls_field, PosA( ls_field, "," ) + 1, 100 ) )
	ELSEIF Upper(RightA( ls_field, 5 )) = "CHECK" THEN		
		ll_ret = long( MidA( ls_field, 1, LenA( ls_field ) - 5) )	
	ELSE
		ll_ret = long( ls_field)
END IF

return ll_ret
end function

public subroutine of_retrieve_tables_fields ();//Added to retrieve tables and fields

tab_1.tabpage_design.dw_fld_prop.SetTransObject( w_train_app.tr_training_data )
tab_1.tabpage_design.dw_field.SetTransObject( w_train_app.tr_training_data )
tab_1.tabpage_design.dw_screen.SetTransObject( w_train_app.tr_training_data )

gnv_appeondb.of_startqueue( )

tab_1.tabpage_design.dw_field.Retrieve( 1 )	
tab_1.tabpage_design.dw_screen.Retrieve( )

gnv_appeondb.of_commitqueue( )

tab_1.tabpage_design.dw_screen.SelectRow( 1, True )
tab_1.tabpage_design.dw_screen.SetRow( 1 )
end subroutine

public function integer of_set_yes_no_box (datawindow as_dw, string as_data);//Start Code Change ---- 08.29.2007 #V7 maha
//function created maha 8-29-07 to correct old bug (orig code) 

datawindowchild dwchild
string ls_lookup_code
integer li_nr
string ls_val

//IF This.GetColumnName() = "object_type" AND (data = 'Y1' OR data = 'Y2' OR data = "C" OR data = "B" ) THEN

as_dw.GetChild( "box_yes_value", dwchild )
ls_lookup_code = as_dw.GetItemString( 1, "lookup_code")
as_dw.GetChild( "box_yes_value", dwchild )
dwchild.SetTransObject( w_train_app.tr_training_data )
dwchild.Retrieve( ls_lookup_code )		
 as_dw.GetChild( "box_no_value", dwchild )
ls_lookup_code =  as_dw.GetItemString( 1, "lookup_code")
as_dw.GetChild( "box_no_value", dwchild )
dwchild.SetTransObject( w_train_app.tr_training_data )
//messagebox("2", ls_lookup_code )	
dwchild.Retrieve( ls_lookup_code )			

 as_dw.GetChild( "box_yes_value", dwchild )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "code", "Is Null" )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "code", "Is Not Null" )	
 as_dw.GetChild( "box_no_value", dwchild )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "code", "Is Null" )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "code", "Is Not Null" )	

//ls_val = as_data
//messagebox("",ls_val)

//this functionality is in the dw itself
//if ls_val = "Y1" then //select box
//	as_dw.Modify( "box_no_value_t.visible = 1")
//	as_dw.Modify( "box_no_value.visible = 1")
//else
//	as_dw.Modify( "box_no_value_t.visible = 0")
//	as_dw.Modify( "box_no_value.visible = 0")
//end if	
//
//if ls_val = "T" then //text
//	as_dw.Modify( "box_yes_value.visible = 0")
//	as_dw.Modify( "box_yes_value_t.visible = 0")
//else
//	as_dw.Modify( "box_yes_value.visible = 1")
//	as_dw.Modify( "box_yes_value_t.visible = 1")
//end if


return 1
end function

public function integer of_scanner_select ();//Start Code Change ----02.21.2008 #V8 maha -  added new
image_functions.of_select_scanner(   tab_1.tabpage_design.ole_scan)  

return 1
end function

public function integer of_set_preview_mode (string as_mode);//Start Code Change ----12.03.2008 #V85 maha - function created to set train/preview objects
long ll_handle
long ll_page,ll_pagecount

ll_handle = handle(w_mdi)

IF as_mode = "Preview" THEN  //from train to preview 
	tab_1.tabpage_design.uo_preview.Visible = True
	tab_1.tabpage_design.uo_preview.BringToTop = True
	st_page_num.Visible = False	
	tab_1.tabpage_design.dw_field.Visible = False
	tab_1.tabpage_design.ole_edit.Visible = False
	is_preview_mode = "Preview"
	w_mdi.ChangeMenu( m_pfe_train_app_preview )
	//w_mdi.SetToolbarPos ( 2, 1, 200, False)
	
	cb_preview.text = "Mapping"  //Start Code Change ----02.19.2016 #V15 maha
	cb_preview.y = 124  //Start Code Change ----03.23.2016 #V15 maha
	//Start Code Change ----02.22.2016 #V15 maha
	tab_1.tabpage_design.dw_preview_buttons.visible = true
	tab_1.tabpage_design.dw_buttons.visible = false
	tab_1.tabpage_design.dw_buttons_webform.visible = false
	//End Code Change ----02.22.2016
	
	If appeongetclienttype() <> 'PB' Then 
		gnv_appeondll.of_settoolbarpos(ll_handle)
		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
	End If

	w_mdi.of_menu_security( "m_pfe_train_app_preview" )
	st_page_num.Visible = False	
	

	ll_page = tab_1.tabpage_design.uo_preview.ole_edit.object.Page()
	ll_pagecount = tab_1.tabpage_design.uo_preview.ole_edit.object.PageCount()
	IF ll_page = 1 and ll_page = ll_pagecount Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ElseIf ll_page = ll_pagecount Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
	ElseIf ll_page < ll_pagecount and ll_page > 1 Then 
		m_pfe_train_app.m_view.m_priorpage.Enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = True
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	ElseIf ll_page < ll_pagecount and ll_page = 1 Then
		m_pfe_train_app.m_view.m_priorpage.Enabled = False
		tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		m_pfe_train_app.m_view.m_nextpage.Enabled = True		
		tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
	End If
//---------------------------- APPEON END ----------------------------


ELSE //from preview to train
	tab_1.tabpage_design.uo_preview.Visible = False
	tab_1.tabpage_design.uo_preview.BringToTop = False
	
	st_page_num.Visible = True	
	//tab_1.tabpage_design.dw_field.Visible = True
	tab_1.tabpage_design.ole_edit.Visible = True
	is_preview_mode = "Train"		
	
	w_mdi.ChangeMenu( m_pfe_train_app )
	if appeongetclienttype() <> 'PB' then gnv_appeondll.of_inittoolbarbandid(ll_handle ) //alfee 04.29.2010					
	w_mdi.of_menu_security( "m_pfe_train_app" )//moved here for App Mapping tools issue - Ticket #00024923 - alfee 04.29.2010	
	//of_HideMenuItems(1) //alfee 10.29.2013
	//w_mdi.SetToolbarPos ( 2, 1, 200, False)
	
	cb_preview.text = "Preview"  //Start Code Change ----02.19.2016 #V15 maha
	cb_preview.y = 164  //Start Code Change ----03.23.2016 #V15 maha
	//Start Code Change ----02.22.2016 #V15 maha
	tab_1.tabpage_design.dw_preview_buttons.visible = false
	tab_1.tabpage_design.dw_buttons.visible = true
	tab_1.tabpage_design.dw_buttons_webform.visible = false
	//End Code Change ----02.22.2016
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<add> 01.13.2006 By: Rodger Wu
	//$<reason> The SetToolbarPos function is currently unsupported. 
	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
	//$<modification> the same functionality.
	If appeongetclienttype() <> 'PB' Then 
		gnv_appeondll.of_settoolbarpos(ll_handle)
		gnv_appeondll.of_SetToolbar(ll_handle,3, False )
		gnv_appeondll.of_SetToolbar(ll_handle,4, False )
		gnv_appeondll.of_SetToolbar(ll_handle,5, False )
	End If
	//---------------------------- APPEON END ----------------------------

	//w_mdi.of_menu_security( "m_pfe_train_app" ) -- commented by alfee 04.29.2010
	//IF tab_1.tabpage_design.ole_edit.Object.Image <> '' THEN	
	if tab_1.tabpage_design.ole_edit.Object.Imagedisplayed <> false then //Modify by Evan 03.03.2011
		IF tab_1.tabpage_design.ole_edit.Object.PageCount() = ii_current_page THEN
			m_pfe_train_app.m_view.m_priorpage.Enabled = True
			tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
			m_pfe_train_app.m_view.m_nextpage.Enabled = False
			tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = false  //Start Code Change ----2.22.2016 #V15 maha
		ELSEIF ii_current_page < tab_1.tabpage_design.ole_edit.Object.PageCount() AND ii_current_page > 1 THEN
			m_pfe_train_app.m_view.m_priorpage.Enabled = True
			tab_1.tabpage_design.dw_preview_buttons.object.b_prior.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
			m_pfe_train_app.m_view.m_nextpage.Enabled = True
			tab_1.tabpage_design.dw_preview_buttons.object.b_next.enabled = true  //Start Code Change ----2.22.2016 #V15 maha
		END IF	
	END IF
END IF

of_field_name_visible( ) //Start Code Change ----11.06.2008 #V85 maha

return 1
end function

public function integer of_clear_annos_single_page (integer ai_page);//Start Code Change ----01.19.2009 #V92 maha - added for refresh function
//clears annotations from the current page

Long li_Cnt
Long i
Long p
String ls_annotation_group
Integer li_page_cnt

if of_check_for_image() = -1 then return -1//maha 031505

li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()

FOR i = 0 TO li_cnt - 1
	ls_annotation_group = tab_1.tabpage_design.ole_edit.Object.GetAnnotationGroup( 0 )
	tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( ls_annotation_group )		
END FOR

Return 0
end function

public function integer of_troubleshoot_page (integer ai_page);//Start Code Change ----01.19.2009 #V92 maha - created to troubleshoot individual page problems

integer li_cnt

of_clear_annos_single_page( ai_page)

li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()

if li_cnt > 0 then
	messagebox("Annotations","Unable to clear all annotations.")
	return -1
end if

of_create_annotations(0)

return 1

end function

public function integer of_refresh_page ();//Start Code Change ----01.19.2009 #V92 maha - created to troubleshoot individual page problems

integer li_cnt

if of_check_for_image() = -1 then Return -1 // Add by Evan 05.07.2009 --- Corrected BugS122713

of_clear_annos_single_page( 0)

li_cnt = tab_1.tabpage_design.ole_edit.Object.AnnotationGroupCount()

if li_cnt > 0 then
	messagebox("Annotations","Unable to clear all annotations.")
	return -1
end if

of_create_annotations(0)

return 1

end function

public function integer of_scan_insert ();boolean lb_exists = false //maha 061708
Long i
Long li_ans
long ll_size //maha 061708

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 02.13.2012
//$<reason> Bug 2912: can not append pages from the scanner
/*
tab_1.tabpage_design.ole_edit.Object.Image = ""
tab_1.tabpage_design.ole_edit.Object.ClearDisplay()
//Added By Ken.Guo 2008-07-11. Workaround Scan bug: First page displayed will be the original page.
tab_1.tabpage_design.uo_preview.ole_edit.Object.Image = ""
tab_1.tabpage_design.uo_preview.ole_edit.Object.ClearDisplay()	
*/
if ib_insert_scan = false then 
	tab_1.tabpage_design.ole_edit.Object.Image = ""
	tab_1.tabpage_design.ole_edit.Object.ClearDisplay()
	
	//Added By Ken.Guo 2008-07-11. Workaround Scan bug: First page displayed will be the original page.
	tab_1.tabpage_design.uo_preview.ole_edit.Object.Image = ""
	tab_1.tabpage_design.uo_preview.ole_edit.Object.ClearDisplay()	
end if
ib_insert_scan = false
//------------------- APPEON END -------------------

IF FileExists( is_app_path ) OR FileExists( MidA( is_app_path, 1, LenA( is_app_path ) -1)) THEN

ELSE
	MessageBox("Image Path", "The application image path " + is_app_path + " is invalid.  Go to the Setup->Organization tab and click on the Set Image Path button to set the appropriate Application Image path." )
	Return -1
END IF

IF image_functions.of_Setup_Scan( tab_1.tabpage_design.ole_scan, is_app_path + "scanappend.tif", 1 ) = -1 THEN
	of_Select_App()
	Return -1
END IF

Return 1

end function

public function integer of_delete_pages ();//Delete specified pages in current image - Nova 04.20.2009
//Modified by Alfee 05.22.2009

Long ll_delete_start, ll_delete_end, ll_delete_pages, ll_page_cnt
String ls_blankfile 

n_appeon_download lnv_down
n_appeon_storage_area lnv_storage_area

//Verification on the Image
IF of_check_for_image() = -1 THEN RETURN -1

TRY
	
	tab_1.tabpage_design.ole_img_admin.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )
	IF tab_1.tabpage_design.ole_img_admin.Object.FileType <> 1 THEN
		MessageBox('Warning','The current image file must be in "TIF" format.')
		RETURN -1
	END IF
	
	//Get an user-specified range of pages 
	Open( w_delete_pages )
	IF Message.StringParm = "Cancel" THEN RETURN -1
	IF MessageBox("Delete","Are you sure you want to delete the selected pages?",Question!,YesNo!,1) <> 1 THEN
		RETURN -1
	END IF
	
	ll_page_cnt = tab_1.tabpage_design.ole_img_admin.Object.PageCount()
	ll_delete_start = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-") -1) )
	ll_delete_end = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-")+1, 100) )
	IF ll_delete_start = 0 And ll_delete_start = ll_delete_end THEN //current page
		ll_delete_start = ii_current_page
		ll_delete_end = ll_delete_start
	END IF
	ll_delete_pages = ll_delete_end - ll_delete_start + 1
	
	if ll_delete_pages>ll_page_cnt then ll_delete_pages=ll_page_cnt
	
	IF ll_delete_start <= 0 Or ll_delete_end < ll_delete_start THEN RETURN -1
	IF ll_delete_start > ll_page_cnt THEN
		MessageBox("Warning","The selected page #"+string(ll_delete_start)+" cannot be found in the current image!")
		RETURN -1
	END IF
	
	//Append a blank page if all pages selected
	IF ll_delete_end >= ll_page_cnt AND ll_delete_start = 1 THEN 
		ls_blankfile = is_app_path + "blankpage.tif"
		IF Not FileExists(ls_blankfile) THEN lnv_down.of_downloadfile("" ,ls_blankfile)
		IF FileExists(ls_blankfile)  THEN 
			tab_1.tabpage_design.ole_img_admin.Object.Insert(ls_blankfile, 1, ll_page_cnt + 1, 1 )
		END IF
		IF tab_1.tabpage_design.ole_img_admin.Object.PageCount() <= ll_page_cnt THEN
			IF ll_delete_end = ll_delete_start THEN RETURN -1
			ll_delete_start ++
		END IF
	END IF
	
	//Delete the specified pages
	tab_1.tabpage_design.ole_edit.Object.ClearDisplay() 
	tab_1.tabpage_design.uo_preview.ole_edit.Object.ClearDisplay() 
	tab_1.tabpage_design.ole_img_admin.Object.DeletePages(ll_delete_start,ll_delete_pages)
	
	gnv_appeondb.of_startqueue( )
	DELETE FROM app_field_prop	WHERE app_id=:ii_app_id AND page >= :ll_delete_start AND page <= :ll_delete_end ;
	UPDATE app_field_prop SET page= page- :ll_delete_pages WHERE app_id = :ii_app_id And page > :ll_delete_start ;
	gnv_appeondb.of_commitqueue( )
	
	//Refresh current page
	IF ii_current_page > tab_1.tabpage_design.ole_img_admin.Object.PageCount() THEN 
		ii_current_page = 1
	END IF
	tab_1.tabpage_design.ole_edit.object.Page(ii_current_page)
	tab_1.tabpage_design.ole_edit.object.display()
	of_goto_page(ii_current_page)	
	tab_1.tabpage_design.uo_preview.ole_edit.object.Page(ii_current_page)
	tab_1.tabpage_design.uo_preview.ole_edit.object.display()

CATCH (throwable th1)
	MessageBox("Delete", "Failed to delete page(s) due to " + th1.text )
	RETURN -1
END TRY

//Update the image and field properties
lnv_storage_area.of_upload_app_image( ii_app_id, is_app_path + String( ii_app_id ) + ".tif")


RETURN 1









end function

public function integer of_insert_pages ();//append pages to an existing application - Nova 04.20.2009

Integer li_i, li_j, li_k
Long li_insert_before, ll_page_count,li_goto_page
String ls_page_count, ls_insert_file, ls_from_method, ls_append_method, ls_parm
n_appeon_download lnv_down
n_appeon_storage_area lnv_storage_area

IF of_check_for_image() = -1 THEN RETURN -1

OpenWithParm (w_append_pages,is_app_path)

IF Message.StringParm = "Cancel" THEN
	RETURN -1
END IF

//closewithreturn(parent,ls_from_method+'-'+ls_append_method+'\'+string(li_page_count))
li_i = PosA( Message.StringParm, "-")
ls_from_method =  MidA( Message.StringParm, 1, li_i -1)
li_j = PosA( Message.StringParm, "\")
ll_page_count = Long(MidA( Message.StringParm, li_j+1, LenA( Message.StringParm) -li_j))
ls_append_method =  MidA( Message.StringParm, li_i+1,li_j -1 -li_i )

li_k = PosA( ls_append_method, "0/")

IF li_k > 0 THEN
	ls_append_method = '0'
ELSE
	li_insert_before = Long(MidA(ls_append_method,PosA(ls_append_method,"/") +1 ,LenA(ls_append_method) -PosA(ls_append_method,"/") ))
	ls_append_method = '1'
END IF

IF ls_from_method = '0' THEN
	ls_insert_file = is_app_path + "temp.tif"
ELSEIF ls_from_method = '1' THEN
	ls_insert_file = is_app_path+ "scanappend.tif"
ELSEIF ls_from_method = '2' THEN
	ls_insert_file = is_app_path + "blankpage.tif"
	if not fileexists(ls_insert_file) Then ls_insert_file = gs_current_path + "\blankpage.tif" //add by stephen 02.28.2013 -Bug 3425 -Mapping is missing from the application
	IF Not FileExists(ls_insert_file) THEN lnv_down.of_downloadfile("" ,ls_insert_file)
END IF

IF Not FileExists(ls_insert_file) THEN RETURN -1

tab_1.tabpage_design.ole_img_admin.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )

IF tab_1.tabpage_design.ole_img_admin.Object.PageCount() > 0 And tab_1.tabpage_design.ole_img_admin.Object.FileType <> 1 THEN
	MessageBox('Image','The current image file must be in "TIF" format.')
	RETURN -1
END IF

IF ls_append_method = '0' OR tab_1.tabpage_design.ole_img_admin.Object.PageCount() < li_insert_before THEN
	li_insert_before = tab_1.tabpage_design.ole_img_admin.Object.PageCount() +1
END IF

li_goto_page=	li_insert_before
//Inserts one or more user-specified pages into the current image file
tab_1.tabpage_design.ole_img_admin.Object.Insert(ls_insert_file, 1, li_insert_before, ll_page_count )

//ls_page_count = String( tab_1.tabpage_design.ole_edit.Object.PageCount() )//Nova 09.22.2009
//delete temp image file 
//IF ls_insert_file <> is_app_path + "blankpage.tif" THEN FileDelete(ls_insert_file)  --delete by stephen 02.28.2013
IF pos(ls_insert_file,"blankpage.tif") < 1 THEN FileDelete(ls_insert_file)   //add by stephen 02.28.2013 -Bug 3425 -Mapping is missing from the application
//Update the image and field properties

lnv_storage_area.of_upload_app_image( ii_app_id, is_app_path + String( ii_app_id ) + ".tif")// Added by  Nova 05.20.2009
//update Annotation 
UPDATE app_field_prop
	SET page = page + :ll_page_count
	WHERE app_id = :ii_app_id AND
	page >= :li_insert_before
	Using tr_training_data;

IF tr_training_data.SQLCode = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLErrText )
	RETURN -1
END IF
//make the inserted page to the current page  
of_goto_page(li_goto_page)

RETURN 1




end function

public function long of_goto_page (integer as_page);//add a argument: as_page(0: open w_goto_page  else goto as_page)  Added by  Nova 05.19.2009------------------------
//Parent.SetRedraw( False )
String	ls_Rtn
Long 		li_goto_page

IF as_page = 0 THEN //For XXXX  Added by  Nova 05.20.2009------------------------
	Open( w_goto_page )
	li_goto_page = Long( Message.StringParm )
ELSE                //For XXXX  Added by  Nova 05.20.2009------------------------
	li_goto_page = as_page
END IF

IF li_goto_page < 1 THEN RETURN 0


tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
IF tab_1.tabpage_design.ole_edit.Object.PageCount() >= li_goto_page THEN
	ii_current_page = li_goto_page
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
	IF LenA(ls_Rtn) > 0 THEN
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		RETURN -1
	END IF
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_design.ole_edit.Object.Save()
	COMMIT Using tr_training_data;
	tab_1.tabpage_design.ole_edit.Object.Page( ii_current_page  )
	tab_1.tabpage_design.ole_edit.Object.Display()
	of_load_annotations()
	IF ii_current_page > 1 THEN
		m_pfe_train_app.m_view.m_priorpage.Enabled = True
	END IF
	IF ii_current_page = 1 THEN
		m_pfe_train_app.m_view.m_priorpage.Enabled = False
	END IF
	IF ii_current_page = tab_1.tabpage_design.ole_edit.Object.PageCount() THEN
		m_pfe_train_app.m_view.m_nextpage.Enabled = False
	ELSE
		m_pfe_train_app.m_view.m_nextpage.Enabled = True
	END IF
	st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )
ELSE
	MessageBox( "Invalid Page", "Invalid Page Number." )
END IF

RETURN 0


end function

public function long of_preview_add_objects (string ls_object, long ai_font, long ai_bold);//Add text under preview mode - alfee 06.29.2010

RETURN tab_1.tabpage_design.uo_preview.of_create_text(ls_object, ai_font, ai_bold)

end function

public function long of_preview_create_text ();//Create text under preview mode - alfee 06.29.2010

OpenwithParm(w_get_label, "train preview") 

Return 1
end function

public function integer of_preview_remove_object ();//Remove object under preview mode - alfee 06.29.2010

RETURN tab_1.tabpage_design.uo_preview.of_remove_object()


end function

public function integer of_setbackgoundcolor (string as_dw);//////////////////////////////////////////////////////////////////////
// $<function> of_setbackgoundcolor
// $<arguments>
//		string	as_dw
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

long ll_get
long ll_lose

ll_get = 16777215      //16120575 //maha change to white 08.11.2015
//ll_lose = 16638439 //lavender
ll_lose = 16774640    //16114130 //maha change to light blue 08.11.2015

choose case as_dw
	case "BROW"
		tab_1.tabpage_select.dw_org_detail.Object.DataWindow.Color = ll_get
		tab_1.tabpage_select.dw_appl_detail.Object.DataWindow.Color = ll_lose
	case "DET"
		tab_1.tabpage_select.dw_org_detail.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_select.dw_appl_detail.Object.DataWindow.Color = ll_get
end choose
		
return 1
end function

public function integer of_savedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedata
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

long ll_FindRow
long li_facility_id
long ll_curr_app_id
long li_app_id, ll_Count

// Checking field if null
if not tab_1.tabpage_select.Event of_DataChanged() then Return 1

if tab_1.tabpage_select.dw_org_detail.RowCount() > 0 then
	if Len(tab_1.tabpage_select.dw_org_detail.GetItemString(1, "facility_name")) > 0 then
	else
		MessageBox("Prompt", "Company name connot be null.")
		tab_1.tabpage_select.dw_org_detail.SetColumn("facility_name")
		tab_1.tabpage_select.dw_org_detail.SetFocus()
		Return -1
	end if
end if

if tab_1.tabpage_select.dw_appl_detail.RowCount() > 0 then
	ll_curr_app_id = tab_1.tabpage_select.dw_appl_detail.GetItemNumber(1, "app_id") //evan 03.16.2012
	//if Len(String(tab_1.tabpage_select.dw_appl_detail.GetItemNumber(1, "application_type"))) > 0 then
	if Len(String(tab_1.tabpage_select.dw_appl_detail.GetItemNumber(1, "application_type"))) > 0 or tab_1.tabpage_select.dw_appl_detail.GetItemStatus(1, 0, Primary!) = New! then //alfee 11.05.2010
	else
		MessageBox("Prompt", "Application type connot be null.")
		tab_1.tabpage_select.dw_appl_detail.SetColumn("application_type")
		tab_1.tabpage_select.dw_appl_detail.SetFocus()
		Return -1
	end if
	//if Len(tab_1.tabpage_select.dw_appl_detail.GetItemString(1, "application_name")) > 0 then
	if Len(tab_1.tabpage_select.dw_appl_detail.GetItemString(1, "application_name")) > 0 or tab_1.tabpage_select.dw_appl_detail.GetItemStatus(1, 0, Primary!) = New! then //alfee 11.05.2010
	else
		MessageBox("Prompt", "Application description connot be null.")
		tab_1.tabpage_select.dw_appl_detail.SetColumn("application_name")
		tab_1.tabpage_select.dw_appl_detail.SetFocus()
		Return -1
	end if
	if tab_1.tabpage_select.dw_appl_detail.GetItemString(1, "site_url", Primary!, true) = tab_1.tabpage_select.dw_appl_detail.GetItemString(1, "site_url") then //evan 03.16.2012
	else
		if tab_1.tabpage_select.dw_appl_detail.GetItemNumber(1, "mapping_type") = 2 then //evan 04.13.2012 - added a trap
			tab_1.tabpage_design.uo_sitefield_map.il_curr_app_id = 0
			select count(*) into :ll_Count from app_field_prop where app_id = :ll_curr_app_id using tr_training_data;
			if ll_Count > 0 then
				if MessageBox("Delete", "Changing the website url will delete all mapping fields that are connected to " + &
					"the current application, do you want to continue?", Exclamation!, YesNo!, 2) = 2 then
					tab_1.tabpage_select.dw_appl_detail.SetColumn("site_url")
					tab_1.tabpage_select.dw_appl_detail.SetFocus()
					Return -1				
				end if
			end if
		end if
	end if
end if

// Update data
li_facility_id	= ii_facility_id
li_app_id =	ii_app_id

tab_1.tabpage_select.SetRedraw(false)
gnv_appeondb.of_StartQueue()
if ll_Count > 0 then //evan 03.16.2012
	delete from app_field_prop where app_id = :ll_curr_app_id using tr_training_data;
	//---------Begin Added by (Appeon)Stephen 2013-08-08 for V141 Web Population Part 3--------
	DELETE FROM app_page_steps WHERE app_id = :ll_curr_app_id using tr_training_data;
	DELETE FROM app_page_data WHERE app_id = :ll_curr_app_id using tr_training_data;
	//---------End Added ------------------------------------------------------
end if
tab_1.tabpage_select.dw_org_detail.Update()
tab_1.tabpage_select.dw_appl_detail.Update()
COMMIT USING tr_training_data;
tab_1.tabpage_select.dw_app_tv.Retrieve()
gnv_appeondb.of_CommitQueue()

// Refresh tree view datawindow
tab_1.tabpage_select.dw_app_tv.Event ue_Locate(li_facility_id, li_app_id)
tab_1.tabpage_select.SetRedraw(true)

Return 1
end function

public function integer of_addrow ();//////////////////////////////////////////////////////////////////////
// $<function> of_addrow
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

long ll_next_id
long ll_InsertRow

if tab_1.tabpage_select.Event of_DataChanged() then
	MessageBox("Prompt", "Please save data first!")
	Return -1
end if

if idw_Current.ClassName() = "dw_org_detail" then
	idw_Current.Reset()
	ll_InsertRow = idw_Current.InsertRow(0)

	SELECT max(facility_id) INTO :ll_next_id FROM app_facility;
	if IsNull(ll_next_id) then ll_next_id = 0
	ll_next_id ++
	
	idw_Current.SetItem(ll_InsertRow, "facility_id", ll_next_id)	
	idw_Current.SetItem(ll_InsertRow, "active_status", 1)	   //Start Code Change ----03.13.2015 #V15 maha
	idw_Current.SetItemStatus(ll_InsertRow, 0, Primary!, NotModified!) //New- alfee 11.15.2010	
	ii_facility_id = ll_next_id
	ii_app_id = 0	
	
	tab_1.tabpage_select.dw_appl_detail.Reset()
else
	if tab_1.tabpage_select.dw_org_detail.GetRow() < 1 then
		MessageBox("Prompt", "Please add organization first!")
		Return -1
	end if
	
	idw_Current.Reset()
	ll_InsertRow = idw_Current.InsertRow(0)
	
	SELECT max(app_id) INTO :ll_next_id FROM app_hdr;
	if IsNull(ll_next_id) then ll_next_id = 0
	ll_next_id ++

	idw_Current.SetItem(ll_InsertRow, "app_id", ll_next_id)
	idw_Current.SetItem(ll_InsertRow, "facility_id", ii_facility_id)
	idw_Current.SetItemStatus(ll_InsertRow, 0, Primary!, NotModified!) //New- alfee 11.15.2010	
	ii_app_id = ll_next_id
end if

Return 1
end function

public function integer of_deleterow ();//////////////////////////////////////////////////////////////////////
// $<function> of_deleterow
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

long li_apps
long ll_contacts
string ls_Null
integer li_Return

SetNull(ls_Null)
if idw_Current.RowCount() < 1 then Return 1
if il_TvCurrentRow < 1 then Return 1

if idw_Current.ClassName() = "dw_org_detail" then
	if idw_Current.GetItemStatus(1, 0, Primary!) = New! or idw_Current.GetItemStatus(1, 0, Primary!) = NewModified! then
		idw_Current.DeleteRow(0)
		tab_1.tabpage_select.dw_appl_detail.Reset()
		SetNull(ii_facility_id)
		SetNull(ii_app_id)
		Return 1
	end if
	
	// Delete confirmation
	li_Return = MessageBox("Delete Organization", "Are you sure you want to delete this Organization? ", Question!, YesNo!, 2)
	if li_Return = 2 then Return 0
					
	gnv_appeondb.of_startqueue()
	select count(*) into :ll_contacts from ctx_contacts where facility_id = :ii_facility_id;
	select count(*) into :li_apps from app_hdr where facility_id = :ii_facility_id;
	gnv_appeondb.of_commitqueue()
	if ll_contacts > 0 then
		MessageBox("Delete Error", "There are " + string(ll_contacts) + " contacts connected to this organization. Delete the contacts before deleting the organization.", StopSign!)
		Return -1
	end if
	if li_apps > 0 then 
		MessageBox("Delete Error", "There are " + string(li_apps) + " apps connected to this organization. Delete the apps before deleting the organization.", StopSign!)
		Return -1
	end if
	
	// Delete organization
	idw_Current.DeleteRow(0)
	gnv_appeondb.of_startqueue()
	idw_Current.Update()
	COMMIT USING SQLCA;
	gnv_appeondb.of_commitqueue()
	
	// Delete tree view datawindow record
	tab_1.tabpage_select.dw_app_tv.DeleteRow(il_TvCurrentRow)

	//re-locate the 1st row in the tree view datawindow - alfee 11.15.2010
	if tab_1.tabpage_select.dw_app_tv.rowcount() > 0 then		
		tab_1.tabpage_select.dw_app_tv.ScrollToRow(1)
		tab_1.tabpage_select.dw_app_tv.Expand(1, 1)
		tab_1.tabpage_select.dw_app_tv.SelectTreeNode(1, 2, true)		
	end if	
else///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if idw_Current.GetItemStatus(1, 0, Primary!) = New! or idw_Current.GetItemStatus(1, 0, Primary!) = NewModified! then
		idw_Current.DeleteRow(0)
		SetNull(ii_app_id)
		Return 1
	end if
	debugbreak()
	// Delete confirmation
	//Start Code Change ----01.30.2014 #V14 maha - modified order of actions
	OpenWithParm(w_app_delete_message, ii_app_id)
	li_Return = Message.DoubleParm
	if li_Return = -1 then Return 0
	if li_return = 2 then //no connections found
		li_Return = MessageBox("Delete Application", "There are no Action records connected to this Application.  Are you sure you want to delete this record? ", Question!, YesNo!, 2)
		if li_Return = 2 then Return 0
		li_Return = MessageBox("Delete Application", "This will delete all the mapping that has been done for this application and the application image will be deleted.  Are you VERY sure? ", Question!, YesNo!, 2)
		if li_Return = 2 then Return 0
	end if
//	OpenWithParm(w_app_delete_message, ii_app_id)
//	li_Return = Message.DoubleParm
//	if li_Return = -1 then Return -1
	//End Code Change ----01.30.2014

	// Delete application and update reference tables
	idw_Current.DeleteRow(0)
	FileDelete(is_app_path + String(ii_app_id) + ".tif")		
	gnv_appeondb.of_startqueue()
	DELETE FROM app_field_prop WHERE app_field_prop.app_id = :ii_app_id;		
	DELETE FROM app_blob WHERE app_id = :ii_app_id;
	//---------Begin Added by (Appeon)Stephen 2013-08-07 for V141 Web Population Part 3--------
	DELETE FROM app_page_steps WHERE app_id = :ii_app_id;
	DELETE FROM app_page_data WHERE app_id = :ii_app_id;
	//---------End Added ------------------------------------------------------
	
	tab_1.tabpage_select.dw_org_detail.Update()
	idw_Current.Update()
	COMMIT USING SQLCA;
	gnv_appeondb.of_commitqueue()
	
	// Delete tree view datawindow record
	if tab_1.tabpage_select.dw_app_tv.object.app_count[il_TvCurrentRow] > 1 then
		tab_1.tabpage_select.dw_app_tv.DeleteRow(il_TvCurrentRow)
		// Refresh tree view datawindow
		il_TvCurrentRow -= 1
		if il_TvCurrentRow > 0 then
			if ii_facility_id = tab_1.tabpage_select.dw_app_tv.GetItemNumber(il_TvCurrentRow, "facility_id") then
				ii_app_id = tab_1.tabpage_select.dw_app_tv.GetItemNumber(il_TvCurrentRow, "app_id")
				tab_1.tabpage_select.dw_app_tv.Event ue_Locate(ii_facility_id, ii_app_id)
			else
				il_TvCurrentRow += 1
				ii_app_id = tab_1.tabpage_select.dw_app_tv.GetItemNumber(il_TvCurrentRow, "app_id")
				tab_1.tabpage_select.dw_app_tv.Event ue_Locate(ii_facility_id, ii_app_id)
			end if
		else
			il_TvCurrentRow = 1
			ii_app_id = tab_1.tabpage_select.dw_app_tv.GetItemNumber(1, "app_id")
			tab_1.tabpage_select.dw_app_tv.Event ue_Locate(ii_facility_id, ii_app_id)
		end if
		idw_Current.Retrieve(ii_app_id)
	else
		SetNull(ii_app_id)
		tab_1.tabpage_select.dw_app_tv.SetItem(il_TvCurrentRow, "app_id", ii_app_id)
		tab_1.tabpage_select.dw_app_tv.SetItem(il_TvCurrentRow, "application_name", ls_Null)		
	end if
end if

Return 1
end function

public function integer of_uploadimage (long al_app_id);//////////////////////////////////////////////////////////////////////
// $<function> of_uploadimage
// $<arguments>
//		long	al_app_id
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.21.2010
//////////////////////////////////////////////////////////////////////

string docpath, docname
integer li_rtn
Long ll_row
Long ll_app_id
string is_file_name
string ls_format
integer li_return

//Start Code Change ----08.23.2011 #V11 maha - modified to allow upload of pdf files
//li_rtn = GetFileOpenName("Select File",    docpath, docname, "TIF",    "Image Files (*.TIF),*.TIF", is_app_path )
//Start Code Change ----07.18.2014 #V14.2 maha - modified to allow selection of .tiff files.
li_rtn = GetFileOpenName("Select File", 	docpath, docname, "TIF",  "TIFF Files (*.tif;*.tiff),*.tif;*.tiff, PDF Files (*.pdf),*.pdf") 

ChangeDirectory(gs_current_path)

IF Upper(RightA(Trim(docname),4)) = '.PDF' THEN
	IF gnv_reg_ocx.of_check_ocx(4,'',True) = '' THEN //check ImageViewer2.OCX 
	
		n_cst_image_functions_cp inv_image_func
		inv_image_func = Create n_cst_image_functions_cp
		
		//get tif filename
		is_file_name = LeftA(docname, LastPos(docname,".") - 1)
	//	is_file_name =  gs_dir_path + "IntelliCred\" + LeftA(is_file_name,LenA(is_file_name) - LastPos(docname,"\") )+'.tif'
		is_file_name =  gs_temp_path + is_file_name +'.tif'
		//pdf2tif
		//li_return = inv_image_func.of_pdf2tif( docpath, is_file_name, "BW", 400) //maha 07.28.2015
		
		
//Start Code Change ----06.30.2016 #V152 maha - format selection
		open(w_convert_format)
		ls_format = message.stringparm
		
		openwithparm( w_appeon_gifofwait, "Converting PDF to TIF..." )
		choose case ls_format
			case "BW"
				li_return =  inv_image_func.of_pdf2tifbw(docpath, is_file_name ) 
			case "TC"
				li_return = inv_image_func.of_pdf2tif( docpath, is_file_name) //restored for exception by alfee 03.20.2013
		end choose
		if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
// End Code Change ----06.30.2016

		//li_return = inv_image_func.of_pdf2tif( docpath, is_file_name, false) //Ticket #00039904 - alfee 02.18.2013	
		//destroy
		Destroy inv_image_func
		IF li_return <> 0 THEN
			docpath = is_file_name
		ELSE
			ChangeDirectory(gs_current_path)
			RETURN -1
		END IF
	ELSE
		RETURN -1
	END IF
END IF
//End Code Change ----08.23.2011

IF li_rtn < 1 THEN RETURN -1

// Upload Image file
n_appeon_storage_area lnv_storage_area
li_rtn = lnv_storage_area.of_upload_app_image(al_app_id, docpath)

IF li_rtn > 0 THEN	
	tab_1.tabpage_select.dw_appl_detail.setitem(1,'datalen',1)
	tab_1.tabpage_select.dw_appl_detail.SetItemStatus(1, 'datalen', Primary!, NotModified!) //evan 03.16.2012
	Messagebox("Upload Image","Complete!")
ELSE
	Return -1
END IF

Return 1
end function

public function integer of_findapp ();//////////////////////////////////////////////////////////////////////
// $<function> of_findapp
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.22.2010
//////////////////////////////////////////////////////////////////////

long ll_app_id
long ll_facility_id
long ll_FoundRow

// Get facility and app id
Open(w_find_app)
if Message.StringParm = "Cancel" then Return 0
ll_facility_id = Long(MidA( Message.StringParm, 1, PosA(Message.StringParm, "-" ) - 1))
ll_app_id = Long(MidA(Message.StringParm, PosA(Message.StringParm, "-" ) + 1, 100))

// Find application
ll_FoundRow = tab_1.tabpage_select.dw_app_tv.Event ue_Locate(ll_facility_id, ll_app_id)
if ll_FoundRow < 1 then
	MessageBox("Error", "Failed to find application.")
	Return -1
end if

Return 1
end function

public function boolean of_imageisnull ();//////////////////////////////////////////////////////////////////////
// $<function> of_imageisnull
// $<arguments>
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
//////////////////////////////////////////////////////////////////////

if tab_1.tabpage_select.dw_appl_detail.GetRow() > 0 then
	if tab_1.tabpage_select.dw_appl_detail.object.datalen[1] > 0 then
	else
		MessageBox("Prompt", "Please upload image first!")
		Return true
	end if
else
	MessageBox("Prompt", "Please upload image first!")
	Return true
end if

Return false
end function

public function long of_retrievefields ();//////////////////////////////////////////////////////////////////////
// $<function> of_retrievefields
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.26.2010
//////////////////////////////////////////////////////////////////////

long i, l, ll_nr
long ll_RowCount
string ls_Filter
string ls_field_name
string ls_code_fields[]
string ls_address_fields[]
datawindow ldw_field_tv
datastore lds_field_data

ldw_field_tv = tab_1.tabpage_design.dw_field_tv
ll_RowCount = ldw_field_tv.RowCount()
if ll_RowCount > 0 then Return ll_RowCount

// Retrieve fields for all screen
lds_field_data = Create datastore
lds_field_data.dataobject = "d_app_screen_field"
lds_field_data.SetTransObject(tr_training_data)
ll_RowCount = lds_field_data.Retrieve(il_default_view)

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 02.17.2011
//$<reason> The tree fields need as same as data screen
/*
// Delete basic information fields
ls_Filter = "(table_id = 25 and data_view_screen_screen_alias <> 'Personal Data') AND " + &
				"(field_id >= 298 and field_id <= 319) or (field_id >= 325 and field_id <= 329)"
lds_field_data.SetFilter(ls_Filter)
lds_field_data.Filter()
lds_field_data.RowsMove(1, lds_field_data.RowCount(), Primary!, lds_field_data, 1, Delete!)
lds_field_data.RowsDiscard(1, lds_field_data.DeletedCount(), Delete!)

// Delete personal data fields
ls_Filter = "(data_view_screen_screen_alias = 'Personal Data') AND " + &
				"(field_id < 298 or (field_id >= 320 and field_id <= 324))"
lds_field_data.SetFilter(ls_Filter)
lds_field_data.Filter()
lds_field_data.RowsMove(1, lds_field_data.RowCount(), Primary!, lds_field_data, 1, Delete!)
lds_field_data.RowsDiscard(1, lds_field_data.DeletedCount(), Delete!)

lds_field_data.SetFilter("")
lds_field_data.Filter()
*/
//------------------- APPEON END ---------------------

of_CorrectAddrFieldLable(lds_field_data) //Added by Evan 11.21.2011 --- Ticket # 00032865: office hours

// Insert lookup fields to lds_field_data
ls_code_fields[2] = "Code"
ls_code_fields[1] = "Description"
//ls_address_fields[12] = "Code"
ls_address_fields[11] = "Entity_Name"
ls_address_fields[10] = "Street1"
ls_address_fields[9] = "Street2"
ls_address_fields[8] = "City"
ls_address_fields[7] = "State"
ls_address_fields[6] = "Zip"
ls_address_fields[5] = "Country"
ls_address_fields[4] = "Phone"
ls_address_fields[3] = "Fax"
ls_address_fields[2] = "Contact_Name"
ls_address_fields[1] = "Email_Address"

ll_RowCount = lds_field_data.RowCount()
FOR i = 1 TO ll_RowCount
	IF Len(lds_field_data.GetItemString(i, "data_view_fields_field_label")) > 0 then
	else
		lds_field_data.SetItem(i, "data_view_fields_field_label", lds_field_data.object.field_name_allias[i])
	end if
	
	IF lds_field_data.GetItemString( i, "lookup_type" ) = "A" THEN
		FOR l = 1 TO 11 //array count
			ll_nr = lds_field_data.InsertRow(i + 1)
			ll_RowCount = ll_RowCount + 1
			lds_field_data.SetItem( ll_nr, "parent_field", lds_field_data.GetItemNumber( i, "field_id" ))
			lds_field_data.SetItem( ll_nr, "field_name_allias", ls_address_fields[l] )
			lds_field_data.SetItem( ll_nr, "data_view_fields_field_label", "[" + ls_address_fields[l] + "]")
			lds_field_data.SetItem( ll_nr, "field_type", "AL" )
			lds_field_data.SetItem( ll_nr, "field_id", lds_field_data.GetItemNumber( i, "field_id" )) 
			lds_field_data.SetItem( ll_nr, "table_id", lds_field_data.GetItemNumber( i, "table_id" ))
			lds_field_data.SetItem( ll_nr, "data_view_screen_screen_id", lds_field_data.GetItemNumber( i, "data_view_screen_screen_id" ))
			lds_field_data.SetItem( ll_nr, "data_view_screen_screen_alias", lds_field_data.GetItemString( i, "data_view_screen_screen_alias" ))
		END FOR

		//JAD 08/06 CAQH CODE
		ll_nr = lds_field_data.InsertRow(i + 11) //array count plus 1
		ll_RowCount = ll_RowCount + 1
		lds_field_data.SetItem( ll_nr, "parent_field", lds_field_data.GetItemNumber( i, "field_id" ))
		lds_field_data.SetItem( ll_nr, "field_name_allias", "CAQH_Code" )
		lds_field_data.SetItem( ll_nr, "data_view_fields_field_label", "[CAQH_Code]" )
		lds_field_data.SetItem( ll_nr, "field_type", "AL" )
		lds_field_data.SetItem( ll_nr, "field_id", lds_field_data.GetItemNumber( i, "field_id" )) 
		lds_field_data.SetItem( ll_nr, "table_id", lds_field_data.GetItemNumber( i, "table_id" ))
		lds_field_data.SetItem( ll_nr, "data_view_screen_screen_id", lds_field_data.GetItemNumber( i, "data_view_screen_screen_id" ))
		lds_field_data.SetItem( ll_nr, "data_view_screen_screen_alias", lds_field_data.GetItemString( i, "data_view_screen_screen_alias" ))
	ELSEIF lds_field_data.GetItemString( i, "lookup_type" ) = "C" THEN
		FOR l = 1 TO 2
			ll_nr = lds_field_data.InsertRow(i + 1)
			ll_RowCount = ll_RowCount + 1
			lds_field_data.SetItem( ll_nr, "parent_field", lds_field_data.GetItemNumber( i, "field_id" ))
			lds_field_data.SetItem( ll_nr, "field_name_allias", ls_code_fields[l] )
			lds_field_data.SetItem( ll_nr, "data_view_fields_field_label", "[" + ls_code_fields[l] + "]")
			lds_field_data.SetItem( ll_nr, "field_type", "CL" )
			lds_field_data.SetItem( ll_nr, "field_id", lds_field_data.GetItemNumber( i, "field_id" )) 
			lds_field_data.SetItem( ll_nr, "table_id", lds_field_data.GetItemNumber( i, "table_id" ))
			lds_field_data.SetItem( ll_nr, "data_view_screen_screen_id", lds_field_data.GetItemNumber( i, "data_view_screen_screen_id" ))
			lds_field_data.SetItem( ll_nr, "data_view_screen_screen_alias", lds_field_data.GetItemString( i, "data_view_screen_screen_alias" ))
		END FOR		
		
		//JAD 08/06 CAQH CODE
		ll_nr = lds_field_data.InsertRow(i + 3) 
		ll_RowCount = ll_RowCount + 1
		lds_field_data.SetItem( ll_nr, "parent_field", lds_field_data.GetItemNumber( i, "field_id" ))
		lds_field_data.SetItem( ll_nr, "field_name_allias", "CAQH_Code" )
		lds_field_data.SetItem( ll_nr, "data_view_fields_field_label", "[CAQH_Code]" )
		
		lds_field_data.SetItem( ll_nr, "field_type", "CL" )
		lds_field_data.SetItem( ll_nr, "field_id", lds_field_data.GetItemNumber( i, "field_id" )) 
		lds_field_data.SetItem( ll_nr, "table_id", lds_field_data.GetItemNumber( i, "table_id" ))
		lds_field_data.SetItem( ll_nr, "data_view_screen_screen_id", lds_field_data.GetItemNumber( i, "data_view_screen_screen_id" ))
		lds_field_data.SetItem( ll_nr, "data_view_screen_screen_alias", lds_field_data.GetItemString( i, "data_view_screen_screen_alias" ))
	END IF
END FOR

// Move lds_field_data's data to ldw_field_tv
ll_RowCount = lds_field_data.RowCount()
lds_field_data.RowsMove(1, ll_RowCount, Primary!, ldw_field_tv, 1, Primary!)
ldw_field_tv.SetRow(1)
ldw_field_tv.CollapseAll() //add by evan 12.15.2010

//---Begin Modifed by alfee 11.14.2010 ---
ldw_field_tv.ScrolltoRow(1)
//ldw_field_tv.Expand(1,1) //delete by evan 12.15.2010
ldw_field_tv.SelectTreeNode(1,2, true)
//ldw_field_tv.SelectRow(0, false)
//ldw_field_tv.SelectRow(1, true)
//---End Modified ---------------------------

Destroy lds_field_data

Return ll_RowCount
end function

public function integer of_addlookupfield (string as_lookup_type);//////////////////////////////////////////////////////////////////////
// $<function> of_addlookupfield
// $<arguments>
//		string	as_lookup_type
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_field_id
string ls_Find
string ls_field_name[]
integer i, li_FieldCount
n_cst_string lnv_string
datawindow ldw_field_tv

// Select lookup fields
OpenWithParm(w_app_lookup_fields_sel, as_lookup_type)
if Message.StringParm = "Cancel!" then Return -1
lnv_string.of_ParseToArray(Message.StringParm, ",", ls_field_name)

ldw_field_tv = tab_1.tabpage_design.dw_field_tv
ll_Row = ldw_field_tv.GetRow()
if ll_Row < 1 then Return -1

// Find lookup field from dw_field_tv and insert it to OLE control
ll_field_id = ldw_field_tv.GetItemNumber(ll_Row, "field_id")
li_FieldCount = UpperBound(ls_field_name)
for i = 1 to li_FieldCount
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 08.09.2011
	//$<reason> Need to add field_id as filter criteria
	//ls_Find = "data_view_screen_screen_id=" + String(w_app_screen.il_screen_id) + " AND lower(field_name_allias)='" + ls_field_name[i] + "'"
	ls_Find = "data_view_screen_screen_id=" + String(w_app_screen.il_screen_id) + &
				 " AND field_id = " + String(ll_field_id) + &
				 " AND lower(field_name_allias)='" + ls_field_name[i] + "'"
	//------------------- APPEON END ---------------------
	
	ll_Row = ldw_field_tv.Find(ls_Find, 1, ldw_field_tv.RowCount())
	if ll_Row > 0 then
		ldw_field_tv.SetRow(ll_Row)
		if of_dw_field_dclick() > 0 then
			of_SetFilterFromSP()
			tab_1.tabpage_design.ole_edit.TriggerEvent("Click")
		end if
	end if
next

Return 1
end function

public function integer of_setfilterfromsp ();//////////////////////////////////////////////////////////////////////
// $<function> of_setfilterfromsp
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
//////////////////////////////////////////////////////////////////////

string ls_screen_field
string ls_operator
string ls_filter_value
integer li_record_number
datawindow ldw_fld_prop

ldw_fld_prop = tab_1.tabpage_design.dw_fld_prop
if not IsValid(w_app_screen) then Return -1
if ldw_fld_prop.GetRow() < 1 then Return -1

w_app_screen.dw_filter.AcceptText()
ls_screen_field = w_app_screen.dw_filter.getitemstring(1, "screen_field")
ls_operator = Trim(w_app_screen.dw_filter.getitemstring(1, "operator"))
ls_filter_value = w_app_screen.dw_filter.getitemstring(1, "filter_value")
li_record_number = w_app_screen.dw_filter.getitemnumber(1, "record_number")

if Len(ls_screen_field) > 0 then
	ldw_fld_prop.SetItem(1, "query_field", ls_screen_field)
end if
if Len(ls_operator) > 0 then
	ldw_fld_prop.SetItem(1, "query_operator", ls_operator)
end if
if Len(ls_filter_value) > 0 then
	ldw_fld_prop.SetItem(1, "query_value", ls_filter_value)
end if
if li_record_number > 0 then
	ldw_fld_prop.SetItem(1, "record_number", li_record_number)
end if

Return 1
end function

public function integer of_addfieldfromsp ();//////////////////////////////////////////////////////////////////////
// $<function> of_addfieldfromsp
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.02.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
string ls_Find
string ls_lookup_type
datawindow ldw_field_tv

ldw_field_tv = tab_1.tabpage_design.dw_field_tv
ll_Row = ldw_field_tv.GetRow()
if ll_Row < 1 then Return -1

// Find field_name from dw_field_tv
ls_Find = "data_view_screen_screen_id=" + String(w_app_screen.il_screen_id) + " AND lower(field_name)='" + Lower(w_app_screen.is_drag_field_name) + "'"
ll_Row = ldw_field_tv.Find(ls_Find, 1, ldw_field_tv.RowCount())
if ll_Row > 0 then
	ldw_field_tv.SetRow(ll_Row)
	ls_lookup_type = ldw_field_tv.GetItemString(ll_Row, "lookup_type")
else
	Return -1
end if

// Insert field_name to OLE control
ldw_field_tv.SetRedraw(false)
if AppeonGetClientType() = "WEB" or w_app_screen.ib_dw_field_dclick then
	// Execute double clicked action
	if ls_lookup_type = "A" or ls_lookup_type = "C" then
		of_AddLookupField(ls_lookup_type)
	else
		of_dw_field_dclick()
		of_SetFilterFromSP()
	end if
else
	// Execute drag action
	if ls_lookup_type = "A" or ls_lookup_type = "C" then
		of_AddLookupField(ls_lookup_type)
	else
		if of_dw_field_dclick() > 0 then
			of_SetFilterFromSP()
			tab_1.tabpage_design.ole_edit.TriggerEvent("Click")
		end if
	end if
end if
ldw_field_tv.SetRedraw(true)

Return 1
end function

public function long of_blank_page_old ();Integer li_first_record_number
Integer li_rec_num_incriment
Integer li_new_rec_num
Integer li_old_rec_num
Integer li_ans
Integer li_row_cnt
Integer f
Integer li_last_record_number
Long ll_next_app_field_id
Integer li_goto_page
Integer p
Integer li_count
Integer li_add_page[]
Integer i
Integer li_copy_page
String ls_auto_replicate[]
String ls_additional_info_pages
String ls_page_count
String ls_auto_rep
Long li_insert_after
DataStore ds_field_prop_from
DataStore ds_field_prop_to

if of_check_for_image() = -1 then return -1//maha 031505

Open( w_insert_page )

IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

//This.SetRedraw( False )	 //avoiding screen blinks on web application

li_insert_after = Long( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-") -1) ) + 1	
li_copy_page = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-")+1, 100) ) 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.08.2006 By: LeiWei
//$<reason> Download image file from database. 
n_appeon_storage_area lnv_storage_area
n_appeon_download lnv_down
string ls_blankpage
ls_blankpage = is_app_path + "\blankpage.tif"
lnv_storage_area.of_retrieve_image_from_db( ii_app_id, is_app_path + String( ii_app_id ) + ".tif" )
if not fileexists(ls_blankpage) Then lnv_down.of_downloadfile("" ,ls_blankpage)
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_design.ole_img_admin.Object.Image( is_app_path + String( ii_app_id ) + ".tif" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
If tab_1.tabpage_design.ole_img_admin.Object.pagecount() > 0 and tab_1.tabpage_design.ole_img_admin.Object.FileType <> 1 Then
	Messagebox('Image','The current image file must be in "TIF" format.')
	Return -1			
End If
//---------------------------- APPEON END ----------------------------


IF li_copy_page = 0 THEN
	tab_1.tabpage_design.ole_img_admin.Object.Insert( is_app_path + "\blankpage.tif", 1, li_insert_after , 1 )
ELSE
	//tab_1.tabpage_design.ole_edit.object.Page( ii_current_page  )
	//tab_1.tabpage_design.ole_edit.object.Display()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-15
	//$<comment> 04.04.2006 By: Rodger Wu
	//$<reason> Performance Tuning
	//$<reason> Comment out the following script.
	/*
	IF ii_current_page > 1 THEN
		of_prior_page( )
	ELSE
		of_next_page( )
	END IF
	*/
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_design.ole_img_admin.Object.Insert( is_app_path + "\" + String( ii_app_id ) + ".tif", li_copy_page, li_insert_after , 1 )
	of_clear_annos_one_page( li_copy_page, li_insert_after )
END IF

ls_page_count = String( tab_1.tabpage_design.ole_edit.Object.PageCount() )

//--------Begin Commented by  Nova 06.01.2009------------------------
//$<reason>remove the modification to the Additional Page data 
/*
ls_additional_info_pages = tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.GetItemString( 1, "additional_info_pages" )

IF Len(ls_additional_info_pages) > 0 THEN
	IF Pos( ls_additional_info_pages, "," ) = 0 THEN
		li_add_page[ 1 ] = Integer( ls_additional_info_pages )
		ls_auto_replicate[1] = ""
	ELSE
		DO WHILE TRUE
			li_count++
			ls_auto_replicate[li_count] = ""
			IF Mid( ls_additional_info_pages, 1, 1 ) = "A" THEN
				ls_auto_replicate[ li_count ]  = "A"
				li_add_page[li_count] = Integer( Mid( ls_additional_info_pages, 2, Pos( ls_additional_info_pages, "," ) -1) )
			ELSE		
				ls_auto_replicate[ li_count ]  = ""				
				li_add_page[li_count] = Integer( Mid( ls_additional_info_pages, 1, Pos( ls_additional_info_pages, "," ) -1) )				
			END IF
			ls_additional_info_pages = Mid( ls_additional_info_pages, Pos( ls_additional_info_pages, "," ) +1, 1000 )				
			IF Pos( ls_additional_info_pages, "," ) = 0 THEN
				li_count++				
				IF Mid( ls_additional_info_pages, 1, 1 ) = "A" THEN
					ls_auto_replicate[ li_count ]  = "A"
					li_add_page[li_count] = Integer( Mid( ls_additional_info_pages, 2, 10))
				ELSE
					ls_auto_replicate[ li_count ]  = ""				
					li_add_page[li_count] = Integer( ls_additional_info_pages )					
				END IF
				Exit
			END IF
		LOOP
	END IF	
	
	FOR p = 1 TO UpperBound( li_add_page )
		IF li_add_page[p] >= li_insert_after THEN
			li_add_page[p]++
		END IF
	END FOR
	
	ls_additional_info_pages = ""	
	FOR p = 1 TO UpperBound( li_add_page )
		ls_additional_info_pages = ls_additional_info_pages + ls_auto_replicate[P] + String(li_add_page[p]) + ","
	END FOR
	
	ls_additional_info_pages = Mid( ls_additional_info_pages, 1, Len(ls_additional_info_pages) -1 )
	
	ls_additional_info_pages = ls_additional_info_pages + "," + ls_auto_rep + String( li_insert_after ) 
ELSE
	ls_additional_info_pages = ls_auto_rep + String( li_insert_after )
END IF

tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_detail.SetItem( 1, "additional_info_pages", ls_additional_info_pages )
*/
//--------End Commented --------------------------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<add> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
UPDATE app_field_prop
SET page = page + 1
WHERE app_id = :ii_app_id AND
      page >= :li_insert_after
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
	Return -1
END IF

UPDATE app_hdr
SET additional_info_pages = :ls_additional_info_pages
WHERE app_id = :ii_app_id
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
	Return -1
END IF
*/
gnv_appeondb.of_StartQueue()
UPDATE app_field_prop
SET page = page + 1
WHERE app_id = :ii_app_id AND
      page >= :li_insert_after
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF

//--------Begin Commented by  Nova 06.01.2009------------------------
//$<reason>remove the modification to the Additional Page data 
/*
UPDATE app_hdr
SET additional_info_pages = :ls_additional_info_pages
WHERE app_id = :ii_app_id
USING tr_training_data;
IF tr_training_data.SQLCODE = -1 THEN
	MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
	gnv_appeondb.of_CommitQueue()
	Return -1
END IF
*/

//--------End Commented --------------------------------------------
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

FOR i = li_insert_after TO 100
	FILEDELETE( is_app_path + string(ii_app_id) + "-" + String( i ) + ".ano" )
END FOR

IF li_copy_page > 0 THEN
	ds_field_prop_from = CREATE DataStore;
	ds_field_prop_to = CREATE DataStore;

	ds_field_prop_from.DataObject = "d_app_field_properties_copy"
	ds_field_prop_from.SetTransObject( SQLCA )
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-17
	//$<add> 04.04.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	ds_field_prop_from.Retrieve( ii_app_id, li_copy_page )

	ds_field_prop_to.DataObject = "d_app_field_properties_copy"
	ds_field_prop_to.SetTransObject( SQLCA )

	ds_field_prop_from.RowsCopy( 1, 10000, Primary!, ds_field_prop_to, 1, Primary! )

	SELECT Max( record_number ), Min( record_number ) 
	INTO :li_last_record_number, :li_first_record_number
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :li_copy_page
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
		Return -1
	END IF

	SELECT Max( app_field_id )
	INTO :ll_next_app_field_id
	FROM app_field_prop
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
		Return -1
	END IF
	*/
	gnv_appeondb.of_StartQueue()
	ds_field_prop_from.Retrieve( ii_app_id, li_copy_page )

	SELECT Max( record_number ), Min( record_number ) 
	INTO :li_last_record_number, :li_first_record_number
	FROM app_field_prop
	WHERE app_id = :ii_app_id AND
   	   page = :li_copy_page
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
		gnv_appeondb.of_CommitQueue()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.23.2007 By: Evan
		//$<Reason> Need to destroy object.
		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
		//---------------------------- APPEON END ----------------------------		
		Return -1
	END IF

	SELECT Max( app_field_id )
	INTO :ll_next_app_field_id
	FROM app_field_prop
	USING tr_training_data;
	IF tr_training_data.SQLCODE = -1 THEN
		MessageBox( "SQL Error", tr_training_data.SQLERRTEXT )
		gnv_appeondb.of_CommitQueue()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.23.2007 By: Evan
		//$<Reason> Need to destroy object.
		if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
		if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
		//---------------------------- APPEON END ----------------------------		
		Return -1
	END IF
	gnv_appeondb.of_CommitQueue()
	
	ds_field_prop_to.DataObject = "d_app_field_properties_copy"
	ds_field_prop_to.SetTransObject( SQLCA )

	ds_field_prop_from.RowsCopy( 1, 10000, Primary!, ds_field_prop_to, 1, Primary! )
	
	//---------------------------- APPEON END ----------------------------
	li_ans = MessageBox( "Record Number", "The maximum record number on the page you are copying is " + String( li_last_record_number ) + " Would you like to start the record numbers for the new page at " + String( li_last_record_number +1 ), Question!, YesNo!, 1 )

	li_rec_num_incriment =  li_last_record_number - li_first_record_number

	li_row_cnt = ds_field_prop_to.RowCount( )
	FOR f = 1 TO li_row_cnt
		ll_next_app_field_id++
		ds_field_prop_to.SetItem( f, "app_field_id", ll_next_app_field_id )
		ds_field_prop_to.SetItem( f, "page", li_insert_after )
		IF li_ans = 1 THEN
			li_old_rec_num = ds_field_prop_to.GetItemNumber( f, "record_number" )
			li_new_rec_num = li_old_rec_num + li_rec_num_incriment + 1
			ds_field_prop_to.SetItem( f, "record_number", li_new_rec_num )			
		END IF
	END FOR

	ds_field_prop_to.Update( )
	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<comment> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<reason> Comment out following redundant script lines.
/*
IF ii_current_page > 1 THEN
	IF ii_current_page > 1 THEN
		of_next_page( )
	ELSE
		of_prior_page( )	
	END IF

END IF
*/
//---------------------------- APPEON END ----------------------------

//This.SetRedraw( True )	//avoiding screen blinks on web application

st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ds_field_prop_from) then Destroy ds_field_prop_from
if IsValid(ds_field_prop_to) then Destroy ds_field_prop_to
//---------------------------- APPEON END ----------------------------

Return 1



end function

public function integer of_hidemenuitems (long al_mapping_type);//====================================================================
// $<function> of_hidemenuitems()
// $<arguments>
// 	value	long	al_mapping_type
// $<returns> integer
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.18.2011
//====================================================================
choose case al_mapping_type
	case 1 //TifForm
		m_pfe_train_app.m_file.m_save.toolbaritemvisible = false		
	case 2 //WebsiteForm
		m_pfe_train_app.m_file.m_scanapplication.visible = false
		m_pfe_train_app.m_file.m_scanapplication.toolbaritemvisible = false
		m_pfe_train_app.m_file.m_previewpage.visible = false
		m_pfe_train_app.m_file.m_previewpage.toolbaritemvisible = false
		m_pfe_train_app.m_file.m_populatewebsite.visible = true
		m_pfe_train_app.m_file.m_populatewebsite.toolbaritemvisible = true
		m_pfe_train_app.m_file.m_save.toolbaritemvisible = true
		//set true and then false to work around the refresh issue for m_popluatewebsite - alfee 10.29.2013
		m_pfe_train_app.m_file.m_save.toolbaritemvisible = false 
		
		m_pfe_train_app.m_tools.visible = false
		m_pfe_train_app.m_tools.toolbaritemvisible = false
		
		m_pfe_train_app.m_page.visible = false
		m_pfe_train_app.m_page.toolbaritemvisible = false
					
		m_pfe_train_app.m_view.visible = false
		m_pfe_train_app.m_view.m_priorpage.toolbaritemvisible = false
		m_pfe_train_app.m_view.m_nextpage.toolbaritemvisible = false
		m_pfe_train_app.m_view.m_templates.toolbaritemvisible = false
		
		m_pfe_train_app.m_edit.m_removeobject.visible = false
		m_pfe_train_app.m_edit.m_removeobject.toolbaritemvisible = false			
		m_pfe_train_app.m_edit.m_copyfields.visible = false
		m_pfe_train_app.m_edit.m_copyfields.toolbaritemvisible = false
		//m_pfe_train_app.m_edit.m_insert.toolbaritemvisible = true - commented by alfee 10.29.2013
		//m_pfe_train_app.m_edit.m_delete1.toolbaritemvisible = true - commented by alfee 10.29.2013
end choose

Return 1
end function

public function integer of_correctaddrfieldlable (datastore ads_field_data);//====================================================================
// $<function> of_CorrectAddrFieldLable()
// $<arguments>
// 	value	datastore	ads_field_data
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 11.21.2011
//====================================================================

long ll_Row
long ll_RowCount
string ls_field_label

ads_field_data.SetFilter("data_view_screen_screen_id = 2")
ads_field_data.Filter()
ll_RowCount = ads_field_data.RowCount()

// mon_from
ll_Row = ads_field_data.Find("lower(field_name) = 'mon_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'mon_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// tue_from
ll_Row = ads_field_data.Find("lower(field_name) = 'tue_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'tue_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// wed_from
ll_Row = ads_field_data.Find("lower(field_name) = 'wed_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'wed_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// thu_from
ll_Row = ads_field_data.Find("lower(field_name) = 'thu_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'thu_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// fri_from
ll_Row = ads_field_data.Find("lower(field_name) = 'fri_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'fri_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// sat_from
ll_Row = ads_field_data.Find("lower(field_name) = 'sat_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'sat_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// sun_from
ll_Row = ads_field_data.Find("lower(field_name) = 'sun_from'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'sun_from2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

////////////////////////////////////////////////////////////////////////////////////////////////

// mon_to
ll_Row = ads_field_data.Find("lower(field_name) = 'mon_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'mon_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// tue_to
ll_Row = ads_field_data.Find("lower(field_name) = 'tue_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'tue_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// wed_to
ll_Row = ads_field_data.Find("lower(field_name) = 'wed_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'wed_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// thu_to
ll_Row = ads_field_data.Find("lower(field_name) = 'thu_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'thu_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// fri_to
ll_Row = ads_field_data.Find("lower(field_name) = 'fri_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'fri_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// sat_to
ll_Row = ads_field_data.Find("lower(field_name) = 'sat_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'sat_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

// sun_to
ll_Row = ads_field_data.Find("lower(field_name) = 'sun_to'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Upper(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if
ll_Row = ads_field_data.Find("lower(field_name) = 'sun_to2'", 1, ll_RowCount)
if ll_Row > 0 then
	ls_field_label = Lower(ads_field_data.GetItemString(ll_Row, "data_view_fields_field_label"))
	ads_field_data.SetItem(ll_Row, "data_view_fields_field_label", ls_field_label)
end if

ads_field_data.SetFilter("")
ads_field_data.Filter()

Return 1
end function

public function integer of_draw_signature (long ai_x, long ai_y, string as_align_type, string as_field);//==========================================
// $<Function>  of_draw_signature ()
// $<arguments>
// 	value    Integer      ai_x: the x position
//	value    Integer      ai_y: the y position
//	value     string 		as_align_type: align type
//  value    string        as_field: the fied need to draw
// description:called from of_align() function
// $<returns> integer 1 - success; -1 - failure 
// $<add> (Appeon) Long.zhang 04.20.2012
//==========================================
long li_sx
long li_sy
long li_newy
long li_newx

tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup(as_field )
tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup(as_field)
IF AppeonGetClientType() = "PB" THEN
	tab_1.tabpage_design.ole_edit.Object.AnnotationImage = Gs_Current_Directory + "\Signature.jpg"
ELSE
	tab_1.tabpage_design.ole_edit.Object.AnnotationImage = tab_1.tabpage_merge.uo_create_app11.of_get_signaturepath()
END IF
tab_1.tabpage_design.ole_edit.Object.AnnotationFillStyle(0)
tab_1.tabpage_design.ole_edit.Object.AnnotationType(5)

li_sx = tab_1.tabpage_design.ole_edit.object.ScrollPositionx()
li_sy = tab_1.tabpage_design.ole_edit.object.ScrollPositionY()
li_newy = ai_y - li_sy
li_newx = ai_x - li_sx
IF as_align_type = "Top" THEN
	tab_1.tabpage_design.ole_edit.object.ScrollPositionX( 0 )		
		tab_1.tabpage_design.ole_edit.object.Draw( li_newx, ii_ancor_y,  0, 0)
ELSE
	tab_1.tabpage_design.ole_edit.object.ScrollPositionY( 0 )
	tab_1.tabpage_design.ole_edit.object.Draw( ii_ancor_x, li_newy,  0, 0)
END IF
tab_1.tabpage_design.ole_edit.Object.AnnotationType(11)
return 1
end function

public function integer of_tips ();string s

s = "The Login page is only used when the website requires an Entity level login, that is one that your organization uses for all log-ins"
s+= "~rFor Provider level logins, store that data on a provider Demographic screen (Basic Information, Other Ids, ect.) and map the login data like other data fields."
s+= "~r~rTo map a website field, double-click the field; this will add it to the mapped field list for that page.  You can then map the field from the IntelliSoft data screens."
s+= "~r~rFor drop down fields, hold down the Enter key while double-clicking the website field in order to add it to the mapping list."

messagebox("iPop mapping tips", s)

return 1
end function

public function integer of_org_inactivate (integer ai_status); //Start Code Change ----08.10.2015 #V15 maha - funciton to make all apps connected to an org inactive
long r
long rc
long ll_org
datawindow ldw_list
 
ll_org = tab_1.tabpage_select.dw_org_detail.getitemnumber(1,"facility_id")
ldw_list = tab_1.tabpage_select.dw_app_tv
rc = ldw_list.rowcount()
 
 for r = 1 to rc
	if ldw_list.getitemnumber(r,"facility_id") = ll_org then
		ldw_list.setitem(r,"active_status", ai_status)
	end if
next

ldw_list.update()
tab_1.tabpage_select.dw_org_detail.update()

return 1
 
end function

public subroutine of_sync_button_menu ();//====================================================================
//$<Function>: of_sync_button_menu
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: set Preview prior and next button's enabled properties by menu item.
//$<Author>: (Appeon) long.zhang 03.08.2016 (BugL030803)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Tab_1.Tabpage_design.dw_preview_buttons.object.b_prior.enabled = m_pfe_train_app_preview.m_view.m_priorpage.enabled
Tab_1.Tabpage_design.dw_preview_buttons.object.b_next.enabled = m_pfe_train_app_preview.m_view.m_nextpage.enabled
			
end subroutine

on w_train_app.create
int iCurrent
call super::create
this.cb_preview=create cb_preview
this.st_field_name=create st_field_name
this.st_page_num=create st_page_num
this.st_msg=create st_msg
this.st_connect=create st_connect
this.tab_1=create tab_1
this.st_align=create st_align
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_preview
this.Control[iCurrent+2]=this.st_field_name
this.Control[iCurrent+3]=this.st_page_num
this.Control[iCurrent+4]=this.st_msg
this.Control[iCurrent+5]=this.st_connect
this.Control[iCurrent+6]=this.tab_1
this.Control[iCurrent+7]=this.st_align
end on

on w_train_app.destroy
call super::destroy
destroy(this.cb_preview)
destroy(this.st_field_name)
destroy(this.st_page_num)
destroy(this.st_msg)
destroy(this.st_connect)
destroy(this.tab_1)
destroy(this.st_align)
end on

event key;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.13.2006 By: Cao YongWang
//$<reason> 
//$<modification>  The following scripts moved to the key_down event in ole_edit control
/*
Long li_x_pos
Long li_y_pos

SetPointer( Arrow! )

ib_contol_key_down = False

if tab_1.selectedtab = 3 then //maha changed 11-28-00 to allow enter key on other tabs  
	IF tab_1.tabpage_design.dw_fld_prop.RowCount() = 1 AND +&
		( key = KeyDownArrow! OR key = KeyUpArrow! OR key =  KeyLeftArrow! OR key = KeyRightArrow! ) AND +&
		ib_label_selected = False THEN
		//This.tab_1.tabpage_design.ole_edit.SetRedraw( False )	//avoiding screen blinks on web application
		li_x_pos = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "x_pos" )
		li_y_pos = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "y_pos" )
		IF KeyDown( KeyControl! ) AND KeyDown( KeyRightArrow! ) THEN 
			of_auto_align()
			//This.tab_1.tabpage_design.ole_edit.SetRedraw( True )			//avoiding screen blinks on web application
			Return
		ELSEIF key = KeyDownArrow! THEN
			ib_moving_field = True
			li_y_pos = li_y_pos + 1 - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()
			li_x_pos = li_x_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()
		ELSEIF key = KeyUpArrow! THEN
			ib_moving_field = True
			li_y_pos = li_y_pos - 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositiony()
			li_x_pos = li_x_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()	
		ELSEIF key = KeyLeftArrow! THEN
			li_x_pos = li_x_pos - 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()
			li_y_pos = li_y_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()	
		ELSEIF key = KeyRightArrow! THEN
			li_x_pos = li_x_pos + 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()	
			li_y_pos = li_y_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()	
		END IF
	
		ii_ancor_x = li_x_pos
		ii_ancor_y = li_y_pos
	
		IF key = KeyDownArrow! OR key = KeyUpArrow! THEN
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "y_pos", ii_ancor_y )
		ELSEIF key = KeyLeftArrow! OR key = KeyRightArrow! THEN
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "x_pos", ii_ancor_x )
		END IF
	
		tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )
		ib_moving_field = False
		//This.tab_1.tabpage_design.ole_edit.SetRedraw( True )	//avoiding screen blinks on web application
	ELSEIF ib_label_selected THEN
		MessageBox("Invalid", "Only the mouse can be used to adjust objects that are not fields.")
	END IF
	
	IF KeyDown( KeyControl! ) THEN
		ib_contol_key_down = True
		w_train_app.title = "key control"
	END IF

end if
*/
//---------------------------- APPEON END ----------------------------
end event

event closequery;String	ls_Rtn
Long 		li_ans

IF ib_saved = False and il_mapping_type = 1 then //evan 10.27.2011 //tab_1.tabpage_design.ole_edit.Object.ImageModified = True AND tab_1.SelectedTab = 3 THEN
	li_ans = MessageBox( "Save", "Save changes to application?", Question!, YesNo!, 1 )
	IF li_ans = 1 THEN
		COMMIT USING tr_training_data;
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-17 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			Return 1
		end if
		//---------------------------- APPEON END ----------------------------
		
		of_delete_annotations( )
		tab_1.tabpage_design.ole_edit.Object.Save()

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-09-27 By: Rodger Wu
		//$<reason> Fix a defect.
		
		n_appeon_storage_area lnv_storage_area
		
		IF gnv_data.of_GetItem( "icred_settings", "image_storage_type", False ) = '1' or appeongetclienttype() = "WEB" THEN
			lnv_storage_area.of_upload_app_image( ii_app_id, is_app_path + String( ii_app_id ) + ".tif")
		END IF
		
		//---------------------------- APPEON END ----------------------------

	ELSE
		ROLLBACK USING tr_training_data;
	END IF
END IF	
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-23
//$<add> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<reason> Destroy the datastore to release the memory.
If isvalid( ids_queryfield ) Then DESTROY ids_queryfield;
//---------------------------- APPEON END ----------------------------

DISCONNECT USING tr_training_data;
DESTROY tr_training_data;

//DISCONNECT USING SQLCA; //removed maha 032304
//
//SQLCA.DBMS = "ODBC"
//
//if gi_test_database = 1 then //maha 123102
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Test;UID=" + gs_user_id + ";PWD=" + gs_password + "',DelimitIdentifier='No'"
//else
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=" + gs_user_id + ";PWD=" + gs_password + "',DelimitIdentifier='No'"
//end if
//
//SQLCA.AutoCommit = TRUE
//	
//CONNECT USING SQLCA;

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 10.26.2011
//$<reason> V12.1 Website Population
/*
try
	Delete From app_field_prop //maha 050102
	Where field_description Is Null
	USING SQLCA;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", sqlca.SQLERRTEXT )
	END IF
	COMMIT USING SQLCA;
catch (runtimeerror a)
end try
*/
of_clean_data()
//------------------- APPEON END ---------------------

Long i
//the followint does nothing
//FOR i = 1 TO 100
//	FILEDELETE( gs_dir_path + "printtemp" + String( i ) + ".tif" )
//END FOR

DESTROY image_functions

w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
w_mdi.of_menu_security( "m_pfe_cst_mdi_menu" )

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 04.03.2009
//$<reason> New feature for App Mapping Addition Filters
/*
IF IsValid( w_section_templates ) THEN
	Close( w_section_templates )
END IF
*/
IF IsValid(w_templates_v9) THEN
	Close(w_templates_v9)
END IF
//------------------- APPEON END ---------------------

IF IsValid( w_place_template_msg ) THEN
	Close( w_place_template_msg )
END IF
IF IsValid( w_app_screen ) THEN
	Close( w_app_screen )
END IF
end event

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
//////////////////////////////////////////////////////////////////////

// Connect database use tr_training_data transaction object
tr_training_data = CREATE n_tr
IF Message.StringParm = "iApply" THEN
	tr_training_data = tab_1.tabpage_design.uo_preview.of_connections( "iApply", "IntelliCred Client46" )
ELSE
	tr_training_data = tab_1.tabpage_design.uo_preview.of_connections( "IntelliCred", "0" )
END IF
if tr_training_data.sqlcode < 0 then 
	close(this)
	return
end if

// Set dw transaction object and retrieve data
tab_1.tabpage_select.dw_app_tv.SetTransObject(tr_training_data)
tab_1.tabpage_select.dw_org_detail.SetTransObject(tr_training_data)
tab_1.tabpage_select.dw_appl_detail.SetTransObject(tr_training_data)
tab_1.tabpage_design.dw_field_tv.SetTransObject(tr_training_data)
tab_1.tabpage_design.dw_fld_prop.SetTransObject(tr_training_data)
ids_queryfield = CREATE datastore
ids_queryfield.DataObject = "d_dddw_system_fields"
ids_queryfield.SetTransObject(tr_training_data)

tab_1.tabpage_select.dw_app_tv.Retrieve()
//----Begin Modified by Alfee 12.02.2010 -----------
//<$Reason>Use the facility-specific view instead if no default view assigned
//SELECT default_view INTO :il_default_view FROM security_users WHERE user_id = :gs_user_id;
Long ll_temp_view
SELECT security_users.default_view, facility.default_data_view_id INTO :il_default_view, :ll_temp_view 
   FROM security_users LEFT OUTER JOIN facility on security_users.default_search_facility = facility.facility_id 
 WHERE user_id = :gs_user_id ;
if IsNull(il_default_view) then il_default_view = ll_temp_view
//---End Modified --------------------------------------
if IsNull(il_default_view) then il_default_view = 1
//----Begin Modified by Alfee 11.14.2010 -----------
if tab_1.tabpage_select.dw_app_tv.rowcount() > 0 then
	tab_1.tabpage_select.dw_app_tv.SetRow(1)
	tab_1.tabpage_select.dw_app_tv.ScrolltoRow(1)	
	tab_1.tabpage_select.dw_app_tv.Expand(1, 1)
	tab_1.tabpage_select.dw_app_tv.SelectTreeNode(1, 2, true)
end if
//tab_1.tabpage_select.dw_app_tv.Expand(1, 1)
//----End Modified -------------------------------------
// Do other actions
is_app_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)
gs_app_image_path = is_app_path
image_functions = CREATE pfc_cst_nv_image_functions 
of_clean_data()


end event

event activate;call super::activate;//make the copy, cut, paste toolbar invisible


//IF tab_1.SelectedTab = 1 THEN
//	w_mdi.ChangeMenu( m_pfe_train_app_setup )
//	w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//	IF tab_1.tabpage_select.tab_facility.SelectedTab = 1 THEN
//		m_pfe_train_app_setup.m_tools.visible = False
//		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = False
//		m_pfe_train_app_setup.m_tools.m_testapplication.visible = False
//		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = False			
//	ELSE
//		m_pfe_train_app_setup.m_tools.visible = True
//		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = True
//		m_pfe_train_app_setup.m_tools.m_testapplication.visible = True
//		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = True			
//	END IF
//ELSEIF tab_1.SelectedTab = 2 THEN
//	IF is_preview_mode = "Train" THEN
//		w_mdi.ChangeMenu( m_pfe_train_app )
//		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//	ELSE
//		w_mdi.ChangeMenu( m_pfe_train_app_preview )
//		w_mdi.SetToolbarPos ( 2, 1, 200, False)	
//	END IF
//END IF
//
//
//w_mdi.SetToolbar( 3, False )
//w_mdi.SetToolbar( 4, False)		
//w_mdi.SetToolbar( 5, False)		
//
long ll_handle
ll_handle = handle(w_mdi) //moved above - alfee 04.29.2010

w_mdi.setredraw(false)
//st_field_name.Visible = False

//change menus
IF tab_1.SelectedTab = 3 THEN
	//st_field_name.Visible = True
	IF is_preview_mode = "Train" THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.10.2006 By: Cao YongWang
		//$<reason>Fix a defect.
		/*
		w_mdi.ChangeMenu( m_pfe_train_app )
		*/
		If w_mdi.menuname <> 'm_pfe_train_app' Then 
			w_mdi.ChangeMenu( m_pfe_train_app )
			if appeongetclienttype() <> 'PB' then gnv_appeondll.of_inittoolbarbandid(ll_handle ) //alfee 04.29.2010				
		End If
		//---------------------------- APPEON END ----------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False)
		w_mdi.of_menu_security( "m_pfe_train_app" )
		if il_mapping_type = 2 then of_HideMenuItems(2) //evan 11.17.2011
	ELSE
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.10.2006 By: Cao YongWang
		//$<reason> Fix a defect.
		/*
		w_mdi.ChangeMenu( m_pfe_train_app_preview )
		*/
		If w_mdi.menuname <> 'm_pfe_train_app_preview' Then w_mdi.ChangeMenu( m_pfe_train_app_preview )
		//---------------------------- APPEON END ----------------------------
		w_mdi.SetToolbarPos ( 2, 1, 200, False)
		w_mdi.of_menu_security( "m_pfe_train_app_preview" )
	END IF
ELSEIF tab_1.SelectedTab = 1 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.10.2006 By: Cao YongWang
	//$<reason> Fix a defect.
	/*
	w_mdi.ChangeMenu( m_pfe_train_app_setup )
	*/
	If w_mdi.menuname <> 'm_pfe_train_app_setup' Then 
		w_mdi.ChangeMenu( m_pfe_train_app_setup )
		if appeongetclienttype() <> 'PB' then gnv_appeondll.of_inittoolbarbandid(ll_handle ) //alfee 04.29.2010						
	End If
	//---------------------------- APPEON END ----------------------------
	w_mdi.SetToolbar(3, False )
	w_mdi.of_menu_security( "m_pfe_train_app_setup" )
	
	IF tab_1.tabpage_select.tab_facility.SelectedTab = 2 THEN
		m_pfe_train_app_setup.m_tools.visible = True
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = True	
	ELSEIF tab_1.SelectedTab = 1 THEN
		m_pfe_train_app_setup.m_tools.visible = False
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = False	
	END IF	
	
END IF

w_mdi.SetToolbarPos ( 2, 1, 200, False)
w_mdi.SetToolbar( 3, False )
w_mdi.SetToolbar( 4, False)		
w_mdi.SetToolbar( 5, False)		

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-11
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
If appeongetclienttype() <> 'PB' Then
	gnv_appeondll.of_settoolbarpos(ll_handle)
	gnv_appeondll.of_SetToolbar(ll_handle,3, False )
	gnv_appeondll.of_SetToolbar(ll_handle,4, False )
	gnv_appeondll.of_SetToolbar(ll_handle,5, False )
End If
w_mdi.setredraw(true)
of_field_name_visible( )
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Stephen 03.15.2017 for V15.3-Bug # 5455 - Security Added: Still able to import Applications after unchecking in role admin--------
IF w_mdi.of_security_access(7844) = 1 then
	tab_1.tabpage_select.cb_import.enabled = true
else
	tab_1.tabpage_select.cb_import.enabled = false
end if
IF w_mdi.of_security_access(7789) = 1 then
	tab_1.tabpage_select.cb_set_delete.enabled = true
else
	tab_1.tabpage_select.cb_set_delete.enabled = false
end if
//---------End Added ------------------------------------------------------



end event

event pfc_save;Return 0
end event

event pfc_close;garbagecollect()
close(this)
end event

event pfc_postopen;call super::pfc_postopen;gnv_reg_ocx.of_check_ocx( 3, '', True) //Added by Ken.Guo on 2008-11-07
tab_1.tabpage_select.dw_appl_detail.Post SetFocus()

//Start Code Change ----03.24.2016 #V15 maha - overwrite program defaults
cb_preview.weight = 700
cb_preview.textsize = 16
//End Code Change ----03.24.2016


tab_1.tabpage_design.uo_sitefield_map.of_set_parent_window (this) //alfee 10.29.2013
end event

event pfc_preopen;call super::pfc_preopen;//Register controls
this.Move(0, 0)
this.of_SetResize(True)
//inv_resize.of_SetMinSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
inv_resize.of_SetMinSize(This.WorkSpaceWidth() * 0.8,This.WorkSpaceHeight() * 0.8)//add 0.8, modified by Appeon long.zhang 11.03.2015 (V14.2 Bug #4819 -  Maximizing IE (SaaS) on laptop causes display issues)
inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())

// Setup tab page
inv_resize.of_Register(tab_1, inv_resize.SCALE)
inv_resize.of_Register(tab_1.tabpage_select.dw_app_tv, inv_resize.SCALEBOTTOM)
inv_resize.of_Register(tab_1.tabpage_select.dw_org_detail, inv_resize.SCALERIGHT)
//Start Code Change ----05.11.2016 #V15 maha
inv_resize.of_Register(tab_1.tabpage_select.st_org, inv_resize.SCALERIGHT)
inv_resize.of_Register(tab_1.tabpage_select.st_app, inv_resize.SCALERIGHT)
//End Code Change ----05.11.2016
inv_resize.of_Register(tab_1.tabpage_select.dw_appl_detail, inv_resize.SCALERIGHTBOTTOM)

// Design tab page (Evan 10.18.2011 - V12.1 Website Population)
inv_resize.of_Register(tab_1.tabpage_design.dw_field_tv, inv_resize.SCALEBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.ole_edit, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.uo_sitefield_map, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.uo_sitefield_map.dw_field, inv_resize.SCALEBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.uo_sitefield_map.ole_browser, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.dw_buttons, inv_resize.SCALERIGHT) //alfee 10.29.2013
inv_resize.of_Register(tab_1.tabpage_design.dw_buttons_webform, inv_resize.SCALERIGHT) //alfee 10.29.2013

//inv_resize.of_Register(tab_1.tabpage_design.tab_fld_prop, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(tab_1.tabpage_design.tab_fld_prop, inv_resize.FIXEDBOTTOM) //BugA103001 - alfee 10.30.2012
inv_resize.of_Register(tab_1.tabpage_design.dw_fld_prop, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.dw_fld_prop, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.dw_quick_filters , inv_resize.FIXEDBOTTOM)//Start Code Change ----05.16.2016 #V15 maha


inv_resize.of_Register(st_field_name, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.cb_apply, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(tab_1.tabpage_design.cb_fast, inv_resize.FIXEDBOTTOM) // add by stephen 10.19.2012 --BugS101601

inv_resize.of_Register(tab_1.tabpage_design.uo_preview, inv_resize.SCALE)
inv_resize.of_Register(tab_1.tabpage_design.dw_preview_buttons, inv_resize.SCALERIGHT)  //Start Code Change ----02.22.2016 #V15 maha
end event

type cb_preview from picturebutton within w_train_app
boolean visible = false
integer x = 3314
integer y = 164
integer width = 270
integer height = 96
integer taborder = 90
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview"
boolean originalsize = true
alignment htextalign = left!
long textcolor = 16711680
long backcolor = 67108864
end type

event clicked;w_train_app.triggerevent( "pfc_preview_page" )
end event

type st_field_name from statictext within w_train_app
integer x = 951
integer y = 1824
integer width = 1513
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "No Field Selected"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

event constructor;if appeongetclienttype() <> 'PB'  then this.Y = this.Y - 20 //BugA103001 - alfee 11.01.2012

end event

type st_page_num from statictext within w_train_app
boolean visible = false
integer x = 823
integer y = 28
integer width = 443
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Page 1 of 100"
boolean focusrectangle = false
end type

type st_msg from statictext within w_train_app
boolean visible = false
integer x = 1577
integer y = 12
integer width = 2126
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = " Click the position on the image where you want field placed."
boolean focusrectangle = false
end type

event constructor;this.Backcolor = parent.Backcolor
end event

type st_connect from statictext within w_train_app
boolean visible = false
integer x = 1221
integer y = 16
integer width = 2359
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Select each field you want to Connect then click the connect icon."
alignment alignment = right!
boolean focusrectangle = false
end type

type tab_1 from tab within w_train_app
event create ( )
event destroy ( )
integer x = 5
integer y = 8
integer width = 4718
integer height = 2288
integer taborder = 10
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
integer selectedtab = 1
tabpage_select tabpage_select
tabpage_scan tabpage_scan
tabpage_design tabpage_design
tabpage_merge tabpage_merge
end type

on tab_1.create
this.tabpage_select=create tabpage_select
this.tabpage_scan=create tabpage_scan
this.tabpage_design=create tabpage_design
this.tabpage_merge=create tabpage_merge
this.Control[]={this.tabpage_select,&
this.tabpage_scan,&
this.tabpage_design,&
this.tabpage_merge}
end on

on tab_1.destroy
destroy(this.tabpage_select)
destroy(this.tabpage_scan)
destroy(this.tabpage_design)
destroy(this.tabpage_merge)
end on

event selectionchanging;//////////////////////////////////////////////////////////////////////
// $<event> selectionchanging
// $<arguments>
//		integer	oldindex
//		integer	newindex
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_Handle
dwitemstatus ldis_status

//------------------- APPEON BEGIN -------------------
//$<add> Evan 03.16.2011
//$<reason> V12.1 Website Population
ll_Row = tabpage_select.dw_appl_detail.GetRow()
if ll_Row < 1 then Return 1
tabpage_select.dw_appl_detail.AcceptText()
ldis_status = tabpage_select.dw_appl_detail.GetItemStatus(1, 0, Primary!)
if ldis_status <> NotModified! then
	MessageBox("Prompt", "Please save data first!")
	Return 1
end if
il_mapping_type = tabpage_select.dw_appl_detail.GetItemNumber(ll_Row, "mapping_type")
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 03.03.2011
//$<reason> The following codes lead to user cannot
//          scan image in Train tab page.
// Check image if null
/*
if NewIndex = 3 then
	if of_ImageIsNull() then Return 1
end if
*/
//------------------- APPEON END ---------------------

// Do actions according to new index
ll_handle = handle(w_mdi)
w_mdi.setredraw(false)
IF newindex = 3 THEN
	IF is_preview_mode = "Train" THEN
		w_mdi.ChangeMenu( m_pfe_train_app )
		if appeongetclienttype() <> 'PB' then gnv_appeondll.of_inittoolbarbandid(ll_handle ) //alfee 04.29.2010						
		w_mdi.SetToolbarPos ( 2, 1, 200, False)
		w_mdi.of_menu_security( "m_pfe_train_app" )

		st_page_num.Visible = True	
	ELSE
		st_page_num.Visible = False		
		w_mdi.ChangeMenu( m_pfe_train_app_preview )
		w_mdi.SetToolbarPos ( 2, 1, 200, False)
		w_mdi.of_menu_security( "m_pfe_train_app_preview" )
//		m_pfe_train_app.m_view.m_nextpage.toolbaritemvisible = true
//		m_pfe_train_app.m_view.m_templates.toolbaritemvisible = true
	END IF
	
//	cb_preview.visible = True //Added by Appeon long.zhang 03.08.2016 (BugL030801) //Commented by (Appeon)Stephen 03.17.2016 - BugS031601	
ELSEIF newindex = 1 THEN
	w_mdi.ChangeMenu( m_pfe_train_app_setup )
	if appeongetclienttype() <> 'PB' then gnv_appeondll.of_inittoolbarbandid(ll_handle ) //alfee 04.29.2010							
	w_mdi.SetToolbar(3, False )
	w_mdi.of_menu_security( "m_pfe_train_app_setup" )
	st_page_num.visible = False //Added by Appeon long.zhang 03.08.2016 (BugL030801)
	cb_preview.visible = False //Added by Appeon long.zhang 03.08.2016 (BugL030801)
	
	IF tab_1.tabpage_select.tab_facility.SelectedTab = 2 THEN
		m_pfe_train_app_setup.m_tools.visible = True
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = True	
	ELSEIF newindex = 1 THEN
		m_pfe_train_app_setup.m_tools.visible = False
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = False	
	END IF	
ELSEIF newindex = 4 THEN
	st_page_num.Visible = False
END IF

w_mdi.SetToolbarPos ( 2, 1, 200, False)	
If appeongetclienttype() <> 'PB' Then
	gnv_appeondll.of_settoolbarpos(ll_handle)
	gnv_appeondll.of_SetToolbar( ll_handle,3, False )
	gnv_appeondll.of_SetToolbar( ll_handle, 4, False)		
	gnv_appeondll.of_SetToolbar(  ll_handle,5, False)
End If
w_mdi.setredraw(true)
end event

event selectionchanged;//////////////////////////////////////////////////////////////////////
// $<event> selectionchanged
// $<arguments>
//		integer	oldindex
//		integer	newindex
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
//////////////////////////////////////////////////////////////////////

string ls_Rtn
string ls_ImageFile

w_mdi.setredraw(false) //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
choose case il_mapping_type
	case 1 //TifForm
		if tabpage_design.uo_sitefield_map.visible then
			tabpage_design.dw_fld_prop.Event ue_Reset()
		end if
		if is_preview_mode = "Train" then
			tabpage_design.ole_edit.Show()
		else
			tabpage_design.ole_edit.Hide() //evan 03.25.2012
		end if

		tabpage_design.uo_sitefield_map.Hide()
		tabpage_design.dw_buttons.show()    //Start Code Change ----02.11.2013 #V12 maha
		tabpage_design.dw_buttons_webform.hide() //alfee 10.29.2013
		
		// Save image file if contents was changed
		if OldIndex = 3 and tabpage_design.ole_edit.Object.Image <> "" then
			if tab_1.tabpage_design.ole_edit.Object.ImageModified = true then
				ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
				if LenA(ls_Rtn) > 0 then
					MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
					w_mdi.setredraw(true) //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
					Return 0
				end if
				tab_1.tabpage_design.ole_edit.Object.Save()
			end if
		end if
		
		// Do actions according to new index
		ls_ImageFile = Lower(is_app_path) + String(ii_app_id) + ".tif"
		choose case NewIndex
			case 2
				if FileExists(ls_ImageFile) AND tab_1.tabpage_design.ole_edit.Object.Image <> "" then
					ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
					if LenA(ls_Rtn) > 0 then
						MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
						w_mdi.setredraw(true) //(Appeon)Stephen 09.23.2016 - Video / Redraw and refresh issue - not yet a bug opened. Two issues
						Return 0
					end if
					tab_1.tabpage_design.ole_edit.Object.Save()
				end if
			case 3
				of_RetrieveFields()
				if Lower(tabpage_design.ole_edit.Object.Image) = ls_ImageFile then
					If is_preview_mode <> "Train" Then of_set_preview_mode(is_preview_mode) //Added by Appeon long.zhang 03.08.2016 (BugL030802)
				else
					of_set_preview_mode("Train")
					of_select_app()
				end if
				cb_preview.visible = True //(Appeon)Stephen 03.17.2016 - BugS031601
				//of_HideMenuItems(1) //alfee 10.29.2013
			case 4
				tab_1.tabpage_design.uo_preview.of_load_app()
		end choose
		
		// Do other actions
		st_page_num.Show()
		If newindex = 1 or is_preview_mode <> "Train" Then st_page_num.visible = False //Added by Appeon long.zhang 03.08.2016 (BugL030801)
		tabpage_design.ole_edit.SetFocus()
		tabpage_design.uo_sitefield_map.il_curr_app_id = 0
		tabpage_design.tab_fld_prop.Event ue_showtabpage(1)
		tabpage_design.dw_fld_prop.Event ue_init(1)
	case 2 //WebsiteForm (Evan 10.18.2011 - V12.1 Website Population)
		if NewIndex = 3 then
			of_HideMenuItems(2)
			st_page_num.Hide()
			tabpage_design.ole_edit.Hide()
			tabpage_design.uo_sitefield_map.Show()
			tabpage_design.ole_edit.Object.ClearDisplay()
			tabpage_design.ole_edit.Object.Image("")
			of_RetrieveFields()
			tabpage_design.dw_fld_prop.Event ue_init(2)
			tabpage_design.dw_buttons.hide()  //Start Code Change ----02.11.2013 #V12 maha
			tabpage_design.dw_buttons_webform.show() //alfee 10.29.2013
			tabpage_design.uo_sitefield_map.Event ue_AppChanged()
			cb_preview.visible = false //(Appeon)Stephen 03.17.2016 - BugS031601
		end if
end choose

//---------Begin Added by (Appeon)Stephen 09.23.2016 for V15.2-Application Tracking full Auditing--------
sleep(100)
w_mdi.setredraw(true) 
//---------End Added ------------------------------------------------------

of_field_name_visible()
end event

event key;w_train_app.TriggerEvent( Key!)
end event

type tabpage_select from userobject within tab_1
event create ( )
event destroy ( )
event type boolean of_datachanged ( )
integer x = 18
integer y = 100
integer width = 4681
integer height = 2172
long backcolor = 33551856
string text = "Setup"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
st_app st_app
st_org st_org
cb_find cb_find
cb_import cb_import
cb_set_save cb_set_save
cb_set_delete cb_set_delete
cb_set_add cb_set_add
dw_org_detail dw_org_detail
p_1 p_1
dw_appl_detail dw_appl_detail
dw_app_tv dw_app_tv
tab_facility tab_facility
st_org_name st_org_name
end type

on tabpage_select.create
this.st_app=create st_app
this.st_org=create st_org
this.cb_find=create cb_find
this.cb_import=create cb_import
this.cb_set_save=create cb_set_save
this.cb_set_delete=create cb_set_delete
this.cb_set_add=create cb_set_add
this.dw_org_detail=create dw_org_detail
this.p_1=create p_1
this.dw_appl_detail=create dw_appl_detail
this.dw_app_tv=create dw_app_tv
this.tab_facility=create tab_facility
this.st_org_name=create st_org_name
this.Control[]={this.st_app,&
this.st_org,&
this.cb_find,&
this.cb_import,&
this.cb_set_save,&
this.cb_set_delete,&
this.cb_set_add,&
this.dw_org_detail,&
this.p_1,&
this.dw_appl_detail,&
this.dw_app_tv,&
this.tab_facility,&
this.st_org_name}
end on

on tabpage_select.destroy
destroy(this.st_app)
destroy(this.st_org)
destroy(this.cb_find)
destroy(this.cb_import)
destroy(this.cb_set_save)
destroy(this.cb_set_delete)
destroy(this.cb_set_add)
destroy(this.dw_org_detail)
destroy(this.p_1)
destroy(this.dw_appl_detail)
destroy(this.dw_app_tv)
destroy(this.tab_facility)
destroy(this.st_org_name)
end on

event type boolean of_datachanged();//////////////////////////////////////////////////////////////////////
// $<function> of_datachanged
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

dw_org_detail.AcceptText()
dw_appl_detail.AcceptText()

if dw_org_detail.ModifiedCount() + dw_org_detail.DeletedCount() > 0 then
	Return true
end if

if dw_appl_detail.ModifiedCount() + dw_appl_detail.DeletedCount() > 0 then
	if dw_appl_detail.RowCount() > 0 then //alfee 11.15.2010
		if dw_appl_detail.GetItemStatus(1, 0, Primary!) = New! then Return false
	end if
	Return true
end if

Return false
end event

type st_app from statictext within tabpage_select
integer x = 1646
integer y = 1128
integer width = 3031
integer height = 104
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Application Detail"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_org from statictext within tabpage_select
integer x = 1646
integer y = 96
integer width = 3031
integer height = 104
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Organization Folder"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_find from commandbutton within tabpage_select
integer x = 4018
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;w_train_app.triggerevent("pfc_searchapp")
end event

type cb_import from commandbutton within tabpage_select
integer x = 3607
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import Apps"
end type

event clicked; Open( w_import_apps )
end event

type cb_set_save from commandbutton within tabpage_select
integer x = 2441
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;w_train_app.triggerevent("pfc_save_setup") 

end event

type cb_set_delete from commandbutton within tabpage_select
integer x = 3200
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;w_train_app.triggerevent ("pfc_deleterow")
end event

type cb_set_add from commandbutton within tabpage_select
integer x = 2848
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;w_train_app.triggerevent ("pfc_addrow")
end event

type dw_org_detail from u_dw within tabpage_select
integer x = 1646
integer y = 200
integer width = 3031
integer height = 928
integer taborder = 31
string title = "Organization Folder"
string dataobject = "d_facility_detail_bak"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-07-31 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm
long ll_org  //maha 11.30.2015

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
	 //Start Code Change ----11.30.2015 #V15 maha
	elseif dwo.name = 'b_notes' then
			ll_org = this.getitemnumber(1,"facility_id")
			openwithparm(w_entity_note, string( ll_org ) + "*ORG")
	//End Code Change ----11.30.2015
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//Start Code Change ----03.12.2015 #V15 maha - note security
integer r
r =  w_mdi.of_security_access(7793)

if r = 0 then
	this.modify( "notes.visible = false")
	this.modify( "b_notes.visible = false")
elseif r = 1 then
	this.modify( "notes.protect = true")
	this.modify( "notes.background.color =  67108864")
	this.modify( "b_notes.visible = false")
end if

if w_mdi.of_security_access(7792) = 0 then
	this.modify( "active_status.protect = true")
	this.modify( "active_status.background.color =  67108864")
end if
end event

event getfocus;call super::getfocus;// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

idw_Current = this
of_SetBackgoundColor("BROW")
end event

event itemchanged;call super::itemchanged;//Start Code Change ----03.13.2015 #V15 maha
integer res
integer li_stat
string s, s1


if dwo.name = "active_status" then
	  //Start Code Change ----0811.2015 #V15 maha
	choose case data
		case "0"
			s = "INACTIVE"
			s1 = "active"
			li_stat = 0
		case "1"
			s = "ACTIVE"
			s1 = "inactive"
			li_stat = 1
	end choose

	res = messagebox("Active Status","You are changing the status on this organization to " + s + ".  Do you want to change all connected Applications as well?",question!,yesno!,2)
	if res = 1 then
		res = messagebox("Active Status","If you make the connected Applications  " + s + ", to make them  " + s1 + " again, you will have to change each one manually. Continue?",question!,yesno!,2)
		if res = 1 then
			of_org_inactivate(li_stat)
			//messagebox("Status change","Click save to commit changes.")
		  //End Code Change ----0811.2015 	
		end if
	end if

end if

 //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(1,"zip")
	of_zip_fill(val, "ORG", this)
end if
end event

event itemerror;call super::itemerror;Return 1
end event

type p_1 from picture within tabpage_select
boolean visible = false
integer x = 4261
integer y = 36
integer width = 169
integer height = 116
string picturename = "Signature.jpg"
boolean focusrectangle = false
end type

type dw_appl_detail from u_dw within tabpage_select
integer x = 1646
integer y = 1232
integer width = 3031
integer height = 936
integer taborder = 40
string title = "Application Detail"
string dataobject = "d_app_detail_sk"
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

integer r  //maha 03.12.2015

this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)


//Start Code Change ----03.12.2015 #V15 maha - note security
r =  w_mdi.of_security_access(7794)

if r = 0 then
	this.modify( "notes.visible = false")
	this.modify( "b_notes.visible = false")
elseif r = 1 then
	this.modify( "notes.protect = true")
	this.modify( "notes.background.color =  67108864")
	this.modify( "b_notes.visible = false")
end if
//End Code Change ----03.12.2015


end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
//		long	row
//		long	actionreturncode
//		dwobject	dwo
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.21.2010
//////////////////////////////////////////////////////////////////////

Long 		ll_facil
String	ls_Phone,ls_fax,ls_RetParm

choose case dwo.name
	case "b_phone"
		ls_Phone = This.GetItemString(row,'contact_phone')
		OpenWithParm(w_phonedetail,ls_Phone)		
		ls_RetParm = Message.StringParm		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'contact_phone',ls_RetParm)
		end if
		This.SetColumn('contact_phone')
	case "b_uploadimage"
		if this.GetItemStatus(1, 0, Primary!) = New! or this.GetItemStatus(1, 0, Primary!) = NewModified! then
			MessageBox("Prompt", "Please save data first!")
		else
			if of_UploadImage(ii_app_id) = 1 then
				tab_1.tabpage_design.ole_edit.Object.ClearDisplay() //Add by Evan 04.15.2011
				tab_1.tabpage_design.ole_edit.Object.Image("")
			end if
			this.SetFocus()
		end if
	case "b_attach"
		OpenWithParm(w_app_image_defaults, ii_app_id)
	 //Start Code Change ----11.30.2015 #V15 maha	
	case "b_notes"
		openwithparm(w_entity_note, string( ii_app_id ) + "*PAY")
	 //End Code Change ----11.30.2015	
end choose
end event

event getfocus;call super::getfocus;//////////////////////////////////////////////////////////////////////
// $<function> getfocus
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
//////////////////////////////////////////////////////////////////////

idw_Current = this
of_SetBackgoundColor("DET")
end event

event itemerror;Return 1
end event

event retrieveend;call super::retrieveend;//alfee 11.14.2010

Integer li_next_id, li_nr

IF rowcount < 1 THEN
	SELECT Max( app_id ) INTO :li_next_id  FROM app_hdr USING tr_training_data;
	IF IsNull( li_next_id ) THEN li_next_id = 0
	li_next_id ++
	ii_app_id =li_next_id
	
	li_nr = this.InsertRow( 0 )
	this.SetItem( li_nr, "app_id", li_next_id )
	this.SetItem( li_nr, "facility_id", ii_facility_id )	
	this.SetItemStatus(li_nr, 0, Primary!, NotModified!) //New
END IF
end event

event itemchanged;call super::itemchanged;//====================================================================
// $<event> itemchange
// $<arguments>
// 	value	long		row
// 	value	dwobject	dwo
// 	value	string	data
// $<returns> integer
// $<description> N/A
// $<add> (Appeon) evan 10.17.2011
//====================================================================

long ll_Count
long ll_app_id
long ll_mapping_type

// Delete all mapping fields
if dwo.name = "mapping_type" then
	ll_app_id = this.GetItemNumber(Row, "app_id")
	select count(*) into :ll_Count from app_field_prop where app_id = :ll_app_id;
	if ll_Count > 0 then
		if MessageBox("Delete", "Changing the mapping type will delete all mapping fields that are connected to " + &
			"the current application, do you want to continue?", Exclamation!, YesNo!, 2) = 1 then
			this.AcceptText()
			gnv_appeondb.of_StartQueue()
			delete from app_field_prop where app_id = :ll_app_id;
			//---------Begin Added by (Appeon)Stephen 2013-08-07 for V141 Web Population Part 3--------
			DELETE FROM app_page_steps WHERE app_id = :ll_app_id;
			DELETE FROM app_page_data WHERE app_id = :ll_app_id;
			//---------End Added ------------------------------------------------------
			this.update()
			commit;
			gnv_appeondb.of_CommitQueue()
			tab_1.tabpage_design.uo_sitefield_map.il_curr_app_id = 0
		else
			ll_mapping_type = this.GetItemNumber(Row, "mapping_type", Primary!, true)
			this.Post SetItem(Row, "mapping_type", ll_mapping_type)
			//this.Post SetItemStatus(Row, "mapping_type", Primary!, NotModified!)
		end if
	end if
end if
end event

type dw_app_tv from datawindow within tabpage_select
event type long ue_locate ( long al_facility_id,  long al_app_id )
event ue_rightclick ( string as_parm,  long al_row,  long al_level )
integer width = 1637
integer height = 2168
integer taborder = 30
boolean titlebar = true
string title = "Organization/Application "
string dataobject = "d_app_facility_tv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_locate(long al_facility_id, long al_app_id);//////////////////////////////////////////////////////////////////////
// $<event> ue_locate
// $<arguments>
//			long	al_facility_id
//			long	al_app_id
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.20.2010
// Reconstructed by Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

long ll_Return
long ll_FindRow
long ll_RowCount

ll_RowCount = this.RowCount()

ll_FindRow = this.Find("app_id=" + String(al_app_id), 1, ll_RowCount)
if ll_FindRow > 0 then
	this.ScrollToRow(ll_FindRow)
	this.Expand(ll_FindRow, 1)
	this.SelectTreeNode(ll_FindRow, 2, true)	
	Return ll_FindRow	
end if

ll_FindRow = this.Find("facility_id=" + String(al_facility_id), 1, ll_RowCount)
if ll_FindRow > 0 then
	this.ScrollToRow(ll_FindRow)
	this.Expand(ll_FindRow, 1)	
	this.SelectTreeNode(ll_FindRow, 1, true)
end if

Return ll_FindRow

//ll_RowCount = this.RowCount()
//this.SelectRow(0, false) 
//
//ll_FindRow = this.Find("facility_id=" + String(al_facility_id), 1, ll_RowCount)
//if ll_FindRow > 0 then
//	this.Expand(ll_FindRow, 1)
//	this.ScrollToRow(ll_FindRow)
//	ll_Return = ll_FindRow
//	this.SelectRow(ll_FindRow, true)
//end if
//
//ll_FindRow = this.Find("app_id=" + String(al_app_id), 1, ll_RowCount)
//if ll_FindRow > 0 then
//	this.ScrollToRow(ll_FindRow)
//	ll_Return = ll_FindRow
//	this.SelectRow(ll_FindRow, true)	
//end if
//
//Return ll_Return
end event

event ue_rightclick(string as_parm, long al_row, long al_level);//Alfee 11.15.2010

CHOOSE CASE Lower(as_parm)
	CASE 'expand'
		if al_row > 0 and al_level > 0 then this.expandallchildren( al_row, al_level)
	CASE 'expand all'
		this.expandall( )
	CASE 'collapse'
		if al_row > 0 and al_level > 0 then this.collapseallchildren(al_row, al_level)
	CASE 'collapse all'
		this.collapseall( )
END CHOOSE
end event

event doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event> doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
//////////////////////////////////////////////////////////////////////
long ll_appid


if Row > 0 then
	if this.getitemnumber(row,"mapping_type") = 3 then
		ll_appid = this.getitemnumber(row,"app_id")
		OpenSheetwithparm( w_ocr_import_applications, ll_appid ,  w_mdi, 4, Original!) 
	else
		tab_1.SelectTab(3)
	end if
end if
end event

event rbuttondown;//////////////////////////////////////////////////////////////////////
// $<event> rbuttondown
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.25.2010
// Reconstructed by Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SetRow(Row)

long ll_grouplevel, ll_row
string  ls_dw_band
str_dw_band lstr_band
m_popup_tv lm_tv

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	ll_grouplevel = 1
elseif lstr_band.band = 'detail' then
	ll_grouplevel = 2
end if
ll_row = lstr_band.row

if ll_grouplevel > 0 and ll_row > 0 then
	//locate current row
	this.setrow(ll_row)
	this.scrolltorow(ll_row)
	this.selecttreenode(ll_row, ll_grouplevel, true)

	//Popup menu
	if ll_grouplevel = 1 then
		lm_tv = Create m_popup_tv	
		lm_tv.of_set_parent (this, ll_row, ll_grouplevel )
		if this.isexpanded(ll_row, ll_grouplevel) then
			lm_tv.m_expand.enabled = false
			lm_tv.m_collapse.enabled = true			
		else
			lm_tv.m_expand.enabled = true
			lm_tv.m_collapse.enabled = false
		end if		
		lm_tv.m_expandall.enabled = true	
		lm_tv.m_collapseall.enabled = true			
		//---------Begin Modified by (Appeon)Toney 11.21.2013 for V141 ISG-CLX--------
		//$Reason:Fix history BugT082601,  Popup menu with new function, that can supply the right coordinate for it. 
		  /*
			lm_tv.PopMenu (PixelsToUnits(xpos , XPixelsToUnits! ) + This.X + Parent.X +30 , PixelsToUnits(ypos, YPixelsToUnits! ) +This.Y + Parent.Y + 130 )				
		  */
		 gnv_app.of_popmenu(this,lm_tv)
		//---------End Modfiied ------------------------------------------------------------------
		Destroy lm_tv		
	end if		
end if

end event

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.26.2010
//////////////////////////////////////////////////////////////////////

//-----Begin Added by alfee 11.14.2010-------
string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	if this.isexpanded(lstr_band.row, 1)  then
		this.collapse( lstr_band.row, 1)
	else
		this.expand( lstr_band.row, 1)
	end if
end if
//-----End Added -------------------------------

if Row > 0 then
	if il_app_id_audit > 0 then
		ib_audit = true
		of_app_audit_track(il_app_id_audit)
		il_app_id_audit = 0
	end if
end if
end event

event expanded;//////////////////////////////////////////////////////////////////////
// $<function> expanded
// $<arguments>
//		long	row
//		long	grouplevel
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
// Commented by alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SetRow(Row)
//this.SelectRow(0, false)
//this.SelectRow(Row, true)
end event

event treenodeselected;//moved here and modified by alfee 11.14.2010

il_TvCurrentRow = row

if row > 0 then
	w_train_app.Title = "IntelliApp   (" + this.GetItemString(row, "application_name") +  " )"
	ii_facility_id = this.GetItemNumber(row, "facility_id")
	ii_app_id  = this.GetItemNumber(row, "app_id")
	if grouplevel = 1 then ii_app_id = 0
	
	gnv_appeondb.of_StartQueue()
	dw_org_detail.Retrieve(ii_facility_id)
	dw_appl_detail.Retrieve(ii_app_id)
	gnv_appeondb.of_CommitQueue()
else
	dw_org_detail.Reset()
	dw_appl_detail.Reset()
end if

if grouplevel = 1 then 
	dw_org_detail.SetFocus()
elseif grouplevel  = 2 then
	dw_appl_detail.SetFocus()
end if

end event

event rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.19.2010
// Moved to treenodeselected() - Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SelectRow(0, false)
//this.SelectRow(CurrentRow, true)
//il_TvCurrentRow = CurrentRow
//
//if CurrentRow > 0 then
//	w_train_app.Title = "IntelliApp   (" + this.GetItemString(CurrentRow, "application_name") +  " )"
//	ii_facility_id = this.GetItemNumber(CurrentRow, "facility_id")
//	ii_app_id  = this.GetItemNumber(CurrentRow, "app_id")
//	gnv_appeondb.of_StartQueue()
//	dw_org_detail.Retrieve(ii_facility_id)
//	dw_appl_detail.Retrieve(ii_app_id)
//	gnv_appeondb.of_CommitQueue()
//else
//	dw_org_detail.Reset()
//	dw_appl_detail.Reset()
//end if
//
//if IsValid(idw_Current) then
//	if idw_Current.ClassName() <> "dw_appl_detail" then
//		dw_appl_detail.SetFocus()
//	end if
//end if
end event

event resize;//Start Code Change ----08.01.2014 #V14.2 maha - migrated from 12.4
long n

n = this.x + this.width
dw_org_detail.x = n + 15
dw_appl_detail.x = n+ 15

//Start Code Change ----03.07.2017 #V153 maha - readded
st_org.x = n+ 15
st_app.x = n+ 15
//end Code Change ----03.07.2017
end event

type tab_facility from tab within tabpage_select
event create ( )
event destroy ( )
boolean visible = false
integer x = 9
integer y = 16
integer width = 3506
integer height = 1736
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 79741120
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_facility tabpage_facility
tabpage_apps tabpage_apps
tabpage_images tabpage_images
end type

on tab_facility.create
this.tabpage_facility=create tabpage_facility
this.tabpage_apps=create tabpage_apps
this.tabpage_images=create tabpage_images
this.Control[]={this.tabpage_facility,&
this.tabpage_apps,&
this.tabpage_images}
end on

on tab_facility.destroy
destroy(this.tabpage_facility)
destroy(this.tabpage_apps)
destroy(this.tabpage_images)
end on

event selectionchanging;//IF oldindex = 1 THEN
//	IF of_save( "facility" ) = -1 THEN
//		Return 1
//	END IF
//ELSE
//	IF of_save( "apps" ) = -1 THEN
//		Return 1
//	END IF	
//END IF

//$<add> 07.10.2008 by Andy
Integer li

IF oldindex = 3 THEN
	if tabpage_images.dw_image_list.Modifiedcount( ) > 0 then
		li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
		IF li = 1 THEN
			IF of_save( 'images' ) < 0 THEN
				return 1
			END IF
		ELSEIF li = 3 THEN
			return 1
		END IF
	end if
END IF
//end add

end event

event selectionchanged;IF newindex = 2 THEN
	//$<modify> 07.11.2008 by Andy add:if statement
	if oldindex = 1 then
		tabpage_apps.dw_app_detail.Reset()
		tabpage_apps.dw_app_browse.Reset()
		tabpage_apps.dw_app_browse.SetTransObject( tr_training_data )
		tabpage_apps.dw_app_browse.Retrieve( ii_facility_id )
	end if
	
	IF IsValid(	m_pfe_train_app_setup ) THEN
		m_pfe_train_app_setup.m_tools.visible = True
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = True
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = True
//Start Code Change ----05.13.2009 #V92 maha - REMOVED - should never be visible on this tab
//		m_pfe_train_app_setup.m_file.m_copyapplication.visible = True		
//		m_pfe_train_app_setup.m_file.m_copyapplication.ToolBarItemVisible = True
//End Code Change---05.13.2009	
		m_pfe_train_app_setup.m_tools.m_highlighter.visible = False
		m_pfe_train_app_setup.m_tools.m_highlighter.ToolBarItemvisible = False			
				
		m_pfe_train_app_setup.m_tools.m_specialfields.visible = False
		m_pfe_train_app_setup.m_tools.m_specialfields.ToolBarItemvisible = False			
		
		m_pfe_train_app_setup.m_tools.m_connect.visible = False
		m_pfe_train_app_setup.m_tools.m_connect.ToolBarItemvisible = False			

		m_pfe_train_app_setup.m_tools.m_connectfields.visible = False
		m_pfe_train_app_setup.m_tools.m_connectfields.ToolBarItemvisible = False			

		m_pfe_train_app_setup.m_tools.m_deleteannotationfiles.visible = False
		m_pfe_train_app_setup.m_tools.m_deleteannotationfiles.ToolBarItemvisible = False					
	END IF
	
//ELSEIF newindex = 1 THEN
ELSEIF newindex = 1 or newindex = 3 THEN
	
	IF IsValid(	m_pfe_train_app_setup ) THEN	
		m_pfe_train_app_setup.m_file.m_copyapplication.visible = False
		m_pfe_train_app_setup.m_file.m_copyapplication.ToolBarItemVisible = False
		m_pfe_train_app_setup.m_tools.visible = False
		m_pfe_train_app_setup.m_tools.ToolBarItemVisible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.visible = False
		m_pfe_train_app_setup.m_tools.m_testapplication.ToolBarItemvisible = False	

		m_pfe_train_app_setup.m_tools.m_highlighter.visible = False
		m_pfe_train_app_setup.m_tools.m_highlighter.ToolBarItemvisible = False			
		m_pfe_train_app_setup.m_tools.m_specialfields.visible = False
		m_pfe_train_app_setup.m_tools.m_specialfields.ToolBarItemvisible = False			
		
		m_pfe_train_app_setup.m_tools.m_connect.visible = False
		m_pfe_train_app_setup.m_tools.m_connect.ToolBarItemvisible = False			

		m_pfe_train_app_setup.m_tools.m_connectfields.visible = False
		m_pfe_train_app_setup.m_tools.m_connectfields.ToolBarItemvisible = False			

		m_pfe_train_app_setup.m_tools.m_deleteannotationfiles.visible = False
		m_pfe_train_app_setup.m_tools.m_deleteannotationfiles.ToolBarItemvisible = False							
	END IF
	
END IF

//$<add> 07.10.2008 by Andy
IF newindex = 3 THEN
	IF IsValid(	m_pfe_train_app_setup ) THEN	
		m_pfe_train_app_setup.m_edit.m_insert.visible = False
		m_pfe_train_app_setup.m_edit.m_insert.ToolBarItemVisible = False
		m_pfe_train_app_setup.m_edit.m_delete1.visible = False
		m_pfe_train_app_setup.m_edit.m_delete1.ToolBarItemVisible = False
	END IF
	
	Long   ll_app_id[],ll_Row
	Long   ll_Cnt,ll_Cnt2
	Long   ll_Find,ll_image_type
	
	ll_Row    = tab_facility.tabpage_apps.dw_app_browse.GetRow( )
	if ll_Row > 0 then
		ll_app_id[1] = tab_facility.tabpage_apps.dw_app_browse.GetItemNumber(ll_Row,"app_id")
	else
		ll_app_id[1] = 0
	end if
	
	tab_facility.tabpage_images.dw_image_defaults.Reset()
	tab_facility.tabpage_images.dw_image_list.Reset()
	
	gnv_appeondb.of_startqueue( )
	tab_facility.tabpage_images.dw_image_list.Retrieve()
	tab_facility.tabpage_images.dw_image_defaults.Retrieve(ll_app_id)
	gnv_appeondb.of_commitqueue( )
	
	ll_Cnt = tab_facility.tabpage_images.dw_image_defaults.RowCount()
	ll_Cnt2= tab_facility.tabpage_images.dw_image_list.RowCount()
	For ll_Row = 1 to ll_Cnt
		ll_image_type = tab_facility.tabpage_images.dw_image_defaults.GetItemNumber(ll_Row,"image_type")
		ll_Find = tab_facility.tabpage_images.dw_image_list.Find("image_type_id=" + String(ll_image_type),1,ll_Cnt2)
		if ll_Find > 0 then 
			tab_facility.tabpage_images.dw_image_list.SetItem(ll_Find,"selected",1)
		end if
	Next
	if ll_Cnt > 0 then tab_facility.tabpage_images.dw_image_list.ResetUpdate( )
ELSE
	IF IsValid(	m_pfe_train_app_setup ) THEN	
		m_pfe_train_app_setup.m_edit.m_insert.visible = true
		m_pfe_train_app_setup.m_edit.m_insert.ToolBarItemVisible = true
		m_pfe_train_app_setup.m_edit.m_delete1.visible = true
		m_pfe_train_app_setup.m_edit.m_delete1.ToolBarItemVisible = true
	END IF	
END IF
//end add 07.10.2008

end event

type tabpage_facility from userobject within tab_facility
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3470
integer height = 1620
long backcolor = 79741120
string text = "  Organization  "
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_facility_detail dw_facility_detail
dw_facility_browse dw_facility_browse
end type

on tabpage_facility.create
this.dw_facility_detail=create dw_facility_detail
this.dw_facility_browse=create dw_facility_browse
this.Control[]={this.dw_facility_detail,&
this.dw_facility_browse}
end on

on tabpage_facility.destroy
destroy(this.dw_facility_detail)
destroy(this.dw_facility_browse)
end on

type dw_facility_detail from datawindow within tabpage_facility
integer x = 1257
integer width = 2135
integer height = 1584
integer taborder = 30
string dataobject = "d_facility_detail_bak"
boolean livescroll = true
end type

event buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-07-31 By: Scofield
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

type dw_facility_browse from datawindow within tabpage_facility
integer x = 23
integer y = 12
integer width = 1202
integer height = 1584
integer taborder = 30
string dataobject = "d_facility_browse"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;Long li_row


li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )
	This.SelectRow( 0 , False )
	This.SelectRow( li_row, True )
END IF
end event

event doubleclicked; tab_1.tabpage_select.tab_facility.SelectTab( 2 )
 ib_deleted_app = False
end event

event retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<comment> 04.03.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<reason> Comment out redundant script lines.
/*
IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	dw_facility_detail.Retrieve( This.GetItemNumber( 1,"facility_id" ) )
END IF
*/
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;
IF currentrow >0 THEN
	tab_1.tabpage_select.st_org_name.Text = This.GetItemString( currentrow, "facility_name" )
	This.SetRow( currentrow )
	This.SelectRow( 0 , False )
	This.SelectRow( currentrow, True )
	ii_facility_id = This.GetItemNumber( currentrow ,"facility_id" )
	dw_facility_detail.Retrieve( ii_facility_id )
END IF
end event

event rowfocuschanging;Long li_ans

dw_facility_detail.AcceptText( )
IF dw_facility_detail.GetItemStatus( currentrow, 0, Primary! ) = NewModified! OR dw_facility_detail.GetItemStatus( currentrow, 0, Primary! ) = DataModified! THEN
	li_ans = MessageBox( "Modifed Facility Data",  "Save changes made to facility detail data?", Question!, YesNo! )
	IF li_ans = 1 THEN
		of_save( "facility" )
	END IF
END IF
end event

type tabpage_apps from userobject within tab_facility
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3470
integer height = 1620
long backcolor = 79741120
string text = "  Applications"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_upload cb_upload
dw_app_browse dw_app_browse
dw_app_detail_org dw_app_detail_org
dw_app_detail dw_app_detail
end type

on tabpage_apps.create
this.cb_upload=create cb_upload
this.dw_app_browse=create dw_app_browse
this.dw_app_detail_org=create dw_app_detail_org
this.dw_app_detail=create dw_app_detail
this.Control[]={this.cb_upload,&
this.dw_app_browse,&
this.dw_app_detail_org,&
this.dw_app_detail}
end on

on tabpage_apps.destroy
destroy(this.cb_upload)
destroy(this.dw_app_browse)
destroy(this.dw_app_detail_org)
destroy(this.dw_app_detail)
end on

type cb_upload from commandbutton within tabpage_apps
integer x = 1303
integer y = 1304
integer width = 480
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upload Image..."
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>cb_1constructor()
// $<arguments>(None)
// $<returns> long
// $<description> The Upload Image button is enabled only when Store to DB is selected.
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

Integer li_image_storage_type
li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_image_storage_type = 0 THEN
	THIS.visible = FALSE
ELSE
	THIS.BringToTop = TRUE	
END IF


end event

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_1clicked()
// $<arguments>(None)
// $<returns> long
// $<description> Add a button to upload an image file to database
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

string docpath, docname
integer li_rtn
Long ll_row
Long ll_app_id

ll_row = dw_app_detail.GetRow( )
IF ll_row = 0 THEN RETURN

ll_app_id = dw_app_detail.GetItemNumber(ll_row, "app_id")

li_rtn = GetFileOpenName("Select File", &
    docpath, docname, "TIF", &
    "Image Files (*.TIF),*.TIF", is_app_path )
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF li_rtn < 1 THEN RETURN

// Upload Image file
n_appeon_storage_area lnv_storage_area

li_rtn = lnv_storage_area.of_upload_app_image( ll_app_id, docpath)

IF li_rtn > 0 THEN
	Messagebox("Upload Image","Complete!")
	dw_app_detail.setitem(ll_row,'datalen',1) //Start Code Change ----04.10.2008 #V8 maha
END IF
end event

type dw_app_browse from datawindow within tabpage_apps
integer x = 23
integer y = 56
integer width = 1202
integer height = 1520
integer taborder = 30
string dataobject = "d_app_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-09-27 By: Rodger Wu
//$<reason> Fix a defect.

/*
Long li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )
	This.SelectRow( 0 , False )
	This.SelectRow( li_row, True )
	//\/maha moved from doubleclicked event 091300
	ii_app_id = This.GetItemNumber( row, "app_id" )
	//Start Code Change ---- 02.22.2006 #281 maha
	if il_app_id_audit > 0 then //creates audit record for previously selected app
		ib_audit = true
		of_app_audit_track(il_app_id_audit)
		il_app_id_audit = 0
	end if
	//End Code Change---02.22.2006
	ii_facility_id = This.GetItemNumber( row, "facility_id" )
//\maha
	
END IF
*/

IF row > 0 THEN
	This.SetRow( row )
	This.SelectRow( 0 , False )
	This.SelectRow( row, True )

	ii_app_id = This.GetItemNumber( row, "app_id" )

	if il_app_id_audit > 0 then
		ib_audit = true
		of_app_audit_track(il_app_id_audit)
		il_app_id_audit = 0
	end if

	ii_facility_id = This.GetItemNumber( row, "facility_id" )
END IF

//---------------------------- APPEON END ----------------------------




end event

event doubleclicked;of_set_preview_mode( "Train") //Start Code Change ----12.03.2008 #V85 maha - added to reset to train mode when new app selected
of_select_app( )

end event

event retrieveend;IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	dw_app_detail.Retrieve( This.GetItemNumber( 1,"app_id" ) )
END IF
end event

event rowfocuschanged;
IF currentrow >0 THEN
	This.SetRow( currentrow )
	This.SelectRow( 0 , False )
	This.SelectRow( currentrow, True )
	dw_app_detail.Retrieve( This.GetItemNumber( currentrow ,"app_id" ) )
END IF
end event

event rowfocuschanging;Long li_ans
dw_app_detail.AcceptText( )
IF dw_app_detail.GetItemStatus( currentrow, 0, Primary! ) = NewModified! OR dw_app_detail.GetItemStatus( currentrow, 0, Primary! ) = DataModified! THEN
	li_ans = MessageBox( "Modifed Application Data",  "Save changes made to application detail data?", Question!, YesNo! )
	IF li_ans = 1 THEN
		of_save( "apps" )
	END IF
END IF
end event

type dw_app_detail_org from datawindow within tabpage_apps
boolean visible = false
integer x = 1038
integer y = 1364
integer width = 270
integer height = 224
integer taborder = 40
string dataobject = "d_app_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Long li_facil

openwithparm( w_app_new_org,ii_facility_id )

li_facil = message.doubleparm

if li_facil < 1 then 
	return
else
	ii_facility_id = li_facil
	
end if
	
this.setitem(row,"facility_id",li_facil)

this.update()
commit using tr_training_data;

dw_app_browse.retrieve(li_facil)
dw_app_browse.setfocus()
end event

type dw_app_detail from u_dw within tabpage_apps
integer x = 1243
integer y = 56
integer width = 2203
integer height = 1524
integer taborder = 11
string dataobject = "d_app_detail"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-08-11 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm
Long 		ll_facil

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'contact_phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'contact_phone',ls_RetParm)
		end if
		This.SetColumn('contact_phone')
	else
		OpenWithParm(w_app_new_org,ii_facility_id)
		ll_facil = Message.DoubleParm
		if ll_facil < 1 then Return
		
		ii_facility_id = ll_facil
		this.SetItem(Row,"facility_id",ll_facil)
		
		this.Update()
		COMMIT USING tr_training_data;
		
		dw_app_browse.retrieve(ll_facil)
		dw_app_browse.setfocus()
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type tabpage_images from userobject within tab_facility
integer x = 18
integer y = 100
integer width = 3470
integer height = 1620
long backcolor = 79741120
string text = "Default Image Types"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_image_defaults dw_image_defaults
cb_2 cb_2
dw_image_list dw_image_list
end type

on tabpage_images.create
this.dw_image_defaults=create dw_image_defaults
this.cb_2=create cb_2
this.dw_image_list=create dw_image_list
this.Control[]={this.dw_image_defaults,&
this.cb_2,&
this.dw_image_list}
end on

on tabpage_images.destroy
destroy(this.dw_image_defaults)
destroy(this.cb_2)
destroy(this.dw_image_list)
end on

type dw_image_defaults from u_dw within tabpage_images
boolean visible = false
integer x = 1307
integer y = 140
integer width = 1298
integer height = 420
integer taborder = 11
string dataobject = "d_app_image_defaults"
boolean livescroll = false
end type

type cb_2 from commandbutton within tabpage_images
integer x = 18
integer y = 1512
integer width = 389
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;Long 	ll_rc
Long 	i
Long	ll_Value

if This.Text = "Select &All" then
	ll_Value = 1
	This.Text = "Deselect &All"
else
	ll_Value = 0
	This.Text = "Select &All"
end if

ll_rc = dw_image_list.RowCount( )
for I = 1 to ll_rc
	dw_image_list.SetItem( i, "selected", ll_Value )
next


end event

type dw_image_list from u_dw within tabpage_images
integer x = 18
integer y = 20
integer width = 1161
integer height = 1476
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Select Image Type"
string dataobject = "d_image_image_type_list_set_defaults"
boolean livescroll = false
end type

event constructor;call super::constructor;//$<add> 07.10.2008 by Andy
this.of_setupdateable( false )
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

type st_org_name from statictext within tabpage_select
boolean visible = false
integer x = 1911
integer y = 36
integer width = 1595
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type tabpage_scan from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 4681
integer height = 2172
boolean enabled = false
long backcolor = 80269524
string text = "Scan"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
end type

type tabpage_design from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4681
integer height = 2172
long backcolor = 33551856
string text = "Mapping"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
ole_scan ole_scan
dw_buttons_webform dw_buttons_webform
cb_1 cb_1
cb_screen cb_screen
ole_thumb ole_thumb
ole_img_admin ole_img_admin
dw_field_tv dw_field_tv
cb_goto_page cb_goto_page
sle_goto_page sle_goto_page
gb_3 gb_3
st_field st_field
dw_screen dw_screen
dw_field dw_field
uo_bar uo_bar
dw_2 dw_2
dw_1 dw_1
tab_fld_prop tab_fld_prop
dw_fld_prop dw_fld_prop
cb_apply cb_apply
cb_view cb_view
dw_quick_filters dw_quick_filters
dw_buttons dw_buttons
cb_fast cb_fast
ole_edit ole_edit
uo_sitefield_map uo_sitefield_map
dw_preview_buttons dw_preview_buttons
uo_preview uo_preview
end type

on tabpage_design.create
this.ole_scan=create ole_scan
this.dw_buttons_webform=create dw_buttons_webform
this.cb_1=create cb_1
this.cb_screen=create cb_screen
this.ole_thumb=create ole_thumb
this.ole_img_admin=create ole_img_admin
this.dw_field_tv=create dw_field_tv
this.cb_goto_page=create cb_goto_page
this.sle_goto_page=create sle_goto_page
this.gb_3=create gb_3
this.st_field=create st_field
this.dw_screen=create dw_screen
this.dw_field=create dw_field
this.uo_bar=create uo_bar
this.dw_2=create dw_2
this.dw_1=create dw_1
this.tab_fld_prop=create tab_fld_prop
this.dw_fld_prop=create dw_fld_prop
this.cb_apply=create cb_apply
this.cb_view=create cb_view
this.dw_quick_filters=create dw_quick_filters
this.dw_buttons=create dw_buttons
this.cb_fast=create cb_fast
this.ole_edit=create ole_edit
this.uo_sitefield_map=create uo_sitefield_map
this.dw_preview_buttons=create dw_preview_buttons
this.uo_preview=create uo_preview
this.Control[]={this.ole_scan,&
this.dw_buttons_webform,&
this.cb_1,&
this.cb_screen,&
this.ole_thumb,&
this.ole_img_admin,&
this.dw_field_tv,&
this.cb_goto_page,&
this.sle_goto_page,&
this.gb_3,&
this.st_field,&
this.dw_screen,&
this.dw_field,&
this.uo_bar,&
this.dw_2,&
this.dw_1,&
this.tab_fld_prop,&
this.dw_fld_prop,&
this.cb_apply,&
this.cb_view,&
this.dw_quick_filters,&
this.dw_buttons,&
this.cb_fast,&
this.ole_edit,&
this.uo_sitefield_map,&
this.dw_preview_buttons,&
this.uo_preview}
end on

on tabpage_design.destroy
destroy(this.ole_scan)
destroy(this.dw_buttons_webform)
destroy(this.cb_1)
destroy(this.cb_screen)
destroy(this.ole_thumb)
destroy(this.ole_img_admin)
destroy(this.dw_field_tv)
destroy(this.cb_goto_page)
destroy(this.sle_goto_page)
destroy(this.gb_3)
destroy(this.st_field)
destroy(this.dw_screen)
destroy(this.dw_field)
destroy(this.uo_bar)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.tab_fld_prop)
destroy(this.dw_fld_prop)
destroy(this.cb_apply)
destroy(this.cb_view)
destroy(this.dw_quick_filters)
destroy(this.dw_buttons)
destroy(this.cb_fast)
destroy(this.ole_edit)
destroy(this.uo_sitefield_map)
destroy(this.dw_preview_buttons)
destroy(this.uo_preview)
end on

type ole_scan from olecustomcontrol within tabpage_design
event scanstarted ( )
event scandone ( )
event pagedone ( long pagenumber )
event scanuidone ( )
event filenamerequest ( long pagenumber )
boolean visible = false
integer width = 146
integer height = 128
integer taborder = 31
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_train_app.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_buttons_webform from datawindow within tabpage_design
boolean visible = false
integer x = 5
integer width = 4416
integer height = 188
integer taborder = 40
string dataobject = "d_app_webform_buttons"
boolean border = false
boolean livescroll = true
end type

event constructor;//====================================================================
//$<Event>: constructor()
//$<Arguments>:
//$<Return>:  long
//$<Description>: initialize data 
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i
String ls_ddlb_page

this.insertrow(1)

//DDLB for Page
ls_ddlb_page = "Page of Login~t0/"
for i = 1 to 200  
	ls_ddlb_page += "Page " + String(i) + "~t" + String(i)
	if i<> 200 then ls_ddlb_page += "/"
next

this.Modify("page.Values = '" + ls_ddlb_page + "'")

this.object.datawindow.color = gl_button_bar_color  //Start Code Change ----02.17.2016 #V15 maha

end event

event itemchanged;//====================================================================
//$<Event>: itemchanged()
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

CHOOSE CASE Lower(dwo.name) 
	CASE "page" 
		uo_sitefield_map.of_change_page (Integer (data) + 1)
	CASE "data_screen"
		uo_sitefield_map.of_set_screen_name (data)	
END CHOOSE


end event

event buttonclicked;//====================================================================
//$<Event>: buttonclicked()
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

CHOOSE CASE Lower(dwo.name) 
	CASE "b_add"
		Event pfc_addrow ()
	CASE "b_delete"
		Event pfc_deleterow ()	
	CASE "b_save"
		Event pfc_save_setup ()
	CASE "b_prior" 
		uo_sitefield_map.of_next_prior_page("D")
	CASE "b_next" 
		uo_sitefield_map.of_next_prior_page("U")
	CASE "b_forward"
		uo_sitefield_map.of_forward_back ("forward")
	CASE "b_back"
		uo_sitefield_map.of_forward_back ("back")
	CASE "b_steps"		
		uo_sitefield_map.of_page_steps ()
	CASE "b_notes"				
		uo_sitefield_map.of_page_notes ()
	CASE "b_tips"				
		of_tips()
	CASE ELSE
		//Do Nothing
END CHOOSE

RETURN 1
end event

type cb_1 from commandbutton within tabpage_design
boolean visible = false
integer x = 3333
integer y = 1736
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

type cb_screen from commandbutton within tabpage_design
integer x = 434
integer y = 216
integer width = 475
integer height = 88
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Open Data Screen"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.01.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
string ls_msg
string ls_screen_id
string ls_screen_name

//---Begin Modified by Alfee 12.02.2010--------------
//ll_Row = dw_field_tv.GetRow()
//if ll_Row > 0 then
ll_Row = il_TvScrRow
if ll_Row > 0 and ll_row <= dw_field_tv.RowCount() then
//---End Modified -----------------------------------------
	ls_screen_id = String(dw_field_tv.object.data_view_screen_screen_id[ll_Row])
	ls_screen_name = String(dw_field_tv.object.data_view_screen_screen_alias[ll_Row])
	choose case ls_screen_id
		case '32','43','44','80','81','82','83','84','85'
			messagebox("Open Data Screen","The screen View function cannot be used for the " + ls_screen_name + " screen.") 
			return
	end choose
	ls_msg = String(il_default_view) + "," + ls_screen_id + "," + ls_screen_name
	if IsValid(w_app_screen) then
		Close(w_app_screen)
	end if
	OpenWithParm(w_app_screen, ls_msg)
end if
end event

type ole_thumb from olecustomcontrol within tabpage_design
integer x = -1413
integer y = -832
integer width = 457
integer height = 200
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_train_app.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_img_admin from olecustomcontrol within tabpage_design
event filepropertiesclose ( )
boolean visible = false
integer x = -1413
integer y = -832
integer width = 155
integer height = 136
integer taborder = 10
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_train_app.win"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_field_tv from datawindow within tabpage_design
event ue_rightclick ( string as_parm,  long al_row,  long al_level )
integer y = 308
integer width = 910
integer height = 1860
integer taborder = 21
string dragicon = "droparrow.ico"
string title = "none"
string dataobject = "d_app_screen_field_tv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_rightclick(string as_parm, long al_row, long al_level);//Alfee 11.15.2010

CHOOSE CASE Lower(as_parm)
	CASE 'expand'
		if al_row > 0 and al_level > 0 then this.expandallchildren( al_row, al_level)
	CASE 'expand all'
		this.expandall( )
	CASE 'collapse'
		if al_row > 0 and al_level > 0 then this.collapseallchildren(al_row, al_level)
	CASE 'collapse all'
		this.collapseall( )
END CHOOSE
end event

event rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.26.2010
// Moved to the treenodeselected() - Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SelectRow(0, false)
//this.SelectRow(CurrentRow, true)
//
//if CurrentRow > 0 then
//	if il_screen_id <> this.GetItemNumber(CurrentRow, "data_view_screen_screen_id") then
//		il_screen_id = this.GetItemNumber(CurrentRow, "data_view_screen_screen_id")
//		ids_queryfield.Retrieve(this.GetItemNumber(CurrentRow, "table_id"))
//		is_query_field = ""
//		is_query_operator = ""
//		is_query_value = ""
//	end if
//end if
end event

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.27.2010
//////////////////////////////////////////////////////////////////////

//-----Begin Added by alfee 11.14.2010-------
string  ls_dw_band
integer li_screen
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	if this.isexpanded(lstr_band.row, 1)  then
		this.collapse( lstr_band.row, 1)
	else
		this.expand( lstr_band.row, 1)
	end if
	
end if
//-----End Added --------------------------------

if il_mapping_type = 1 then
	if Row > 0 then this.Drag(Begin!)
elseif il_mapping_type = 2 then
	if Row > 0 and uo_sitefield_map.il_Page > 0 then this.Drag(Begin!)
end if

end event

event doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event> doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.27.2010
//////////////////////////////////////////////////////////////////////

if Row > 0 and il_mapping_type = 1 then //evan 11.27.2011
	of_dw_field_dclick()
end if
end event

event rbuttondown;//////////////////////////////////////////////////////////////////////
// $<event> rbuttondown
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.29.2010
// Reconstructed by Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SetRow(Row)

long ll_grouplevel, ll_row
string  ls_dw_band
str_dw_band lstr_band
m_popup_tv lm_tv

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	ll_grouplevel = 1
elseif lstr_band.band = 'detail' then
	ll_grouplevel = 2
end if
ll_row = lstr_band.row

if ll_grouplevel > 0 and ll_row > 0 then
	//locate current row
	this.setrow(ll_row)
	this.scrolltorow(ll_row)
	this.selecttreenode(ll_row, ll_grouplevel, true)
	
	//Popup menu
	if ll_grouplevel = 1 then
		lm_tv = Create m_popup_tv	
		lm_tv.of_set_parent (this, ll_row, ll_grouplevel )
		if this.isexpanded(ll_row, ll_grouplevel) then
			lm_tv.m_expand.enabled = false
			lm_tv.m_collapse.enabled = true			
		else
			lm_tv.m_expand.enabled = true
			lm_tv.m_collapse.enabled = false
		end if		
		lm_tv.m_expandall.enabled = true	
		lm_tv.m_collapseall.enabled = true			
		lm_tv.PopMenu (PixelsToUnits(xpos , XPixelsToUnits! ) + This.X + Parent.X +30 , PixelsToUnits(ypos, YPixelsToUnits! ) +This.Y + Parent.Y + 130)
		Destroy lm_tv		
	end if			
end if
end event

event collapsed;//////////////////////////////////////////////////////////////////////
// $<event> collapsed
// $<arguments>
//		long	row
//		long	grouplevel
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
// Commentd by Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SetRow(Row)
//this.SelectRow(0, false)
//this.SelectRow(Row, true)
end event

event expanded;//////////////////////////////////////////////////////////////////////
// $<function> expanded
// $<arguments>
//		long	row
//		long	grouplevel
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2010
// Commented by Alfee 11.14.2010
//////////////////////////////////////////////////////////////////////

//this.SetRow(Row)
//this.SelectRow(0, false)
//this.SelectRow(Row, true)
end event

event treenodeselected;//moved here and modified by alfee 11.14.2010
long ll_Null
datawindowchild ldwc_child

if row > 0 then
	il_TvScrRow = row //12.02.2010
	if il_screen_id <> this.GetItemNumber(row, "data_view_screen_screen_id") then
		il_screen_id = this.GetItemNumber(row, "data_view_screen_screen_id")
		dw_quick_filters.GetChild("app_filter_id", ldwc_child)
		ldwc_child.SetTransObject(SQLCA)
		
		gnv_appeondb.of_StartQueue()
		ldwc_child.Retrieve(il_screen_id) //evan 12.16.2010		
		ids_queryfield.Retrieve(this.GetItemNumber(row, "table_id"))
		gnv_appeondb.of_CommitQueue()
		
		SetNull(ll_Null)
		ldwc_child.InsertRow(1)
		dw_quick_filters.SetItem(1, "app_filter_id", ll_Null)
		
		is_query_field = ""
		is_query_operator = ""
		is_query_value = ""
		
		//Start Code Change ----04.13.2011 #V11 maha - disable screen view button for some screens
		choose case il_screen_id
			//case 32,43,44,80,81,82,83,84,85
			case 32,43,44,80,81,82,83,84,85,86	//long.zhang 07.09.2012 v12.2 group location mini-painter
				cb_screen.enabled = false
			case else
				cb_screen.enabled = true
		end choose
		//Start Code Change ----04.13.2011
	end if
end if
end event

event retrieveend;debugbreak()
end event

type cb_goto_page from commandbutton within tabpage_design
boolean visible = false
integer x = 3218
integer y = 1952
integer width = 146
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Goto "
boolean default = true
end type

event clicked;////Parent.SetRedraw( False )
//
//ole_edit.Object.SelectAnnotationGroup( "" )
//IF ole_edit.Object.PageCount() >= Long (sle_goto_page.Text) AND +&
//	Long(sle_goto_page.Text) > 0 THEN
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.15.2006 By: LeiWei
//$<reason> Fix a defect.
Long 		li_goto_page
String	ls_Rtn

li_goto_page = Long (sle_goto_page.Text)

if li_goto_page < 1 then
	sle_goto_page.Text = ""
	return 
end if

tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
IF tab_1.tabpage_design.ole_edit.Object.PageCount() >= li_goto_page THEN
	ii_current_page = li_goto_page
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-17 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(tab_1.tabpage_design.ole_edit.Object.Image)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return
	end if
	//---------------------------- APPEON END ----------------------------
	
	tab_1.tabpage_design.ole_edit.Object.Save()
	COMMIT USING tr_training_data;
	tab_1.tabpage_design.ole_edit.object.Page( ii_current_page  )
	tab_1.tabpage_design.ole_edit.object.Display()
	of_load_annotations()	
	IF ii_current_page > 1 THEN
		m_pfe_train_app.m_view.m_priorpage.enabled = True
	END IF
	IF ii_current_page = 1 THEN
		m_pfe_train_app.m_view.m_priorpage.enabled = False
	END IF
	IF ii_current_page = tab_1.tabpage_design.ole_edit.Object.PageCount() THEN
		m_pfe_train_app.m_view.m_nextpage.enabled = False
	ELSE
		m_pfe_train_app.m_view.m_nextpage.enabled = True		
	END IF
	st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( tab_1.tabpage_design.ole_edit.Object.PageCount() )	
END IF

sle_goto_page.Text = ""

Return 0
//---------------------------- APPEON END ----------------------------

//	of_delete_annotations( )	
//	ii_current_page = Long( sle_goto_page.Text )
//	//IF ole_edit.Object.ImageModified = True THEN
//	//	Long li_ans
//	//	li_ans = MessageBox( "Save", "Save changes to application?", Question!, YesNo!, 1 )
//	//	IF li_ans = 1 THEN
//			ole_edit.Object.Save()
//			COMMIT USING tr_training_data;
//	//	END IF
//	//END IF
//	ole_edit.object.Page( ii_current_page  )
//	ole_edit.object.Display()
//	of_load_annotations()
//	cb_previous.Enabled = True
//	st_page_num.Text = "Page " + String( ii_current_page ) + " Of " + String( ole_edit.Object.PageCount() )
//	sle_goto_page.Text = ""
//s.tab_1.SelectTab( 1 )	
//	IF ii_current_page = ole_edit.Object.PageCount() THEN
//		cb_next.Enabled = False
//	END IF	
//	IF ii_current_page = 1 THEN
//		cb_next.Enabled = True
//		cb_previous.Enabled = False
//	END IF		
//ELSE
//	sle_goto_page.Text = ""
//END IF
//
////Parent.SetRedraw( True )
end event

type sle_goto_page from singlelineedit within tabpage_design
boolean visible = false
integer x = 3369
integer y = 1952
integer width = 96
integer height = 88
integer taborder = 70
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

type gb_3 from groupbox within tabpage_design
boolean visible = false
integer x = 2939
integer y = 1896
integer width = 549
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Page"
end type

type st_field from statictext within tabpage_design
boolean visible = false
integer x = 3451
integer y = 2924
integer width = 137
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "N"
boolean focusrectangle = false
end type

type dw_screen from datawindow within tabpage_design
event ue_key pbm_dwnkey
event ue_after_open ( )
boolean visible = false
integer x = 14
integer y = 1248
integer width = 709
integer height = 580
integer taborder = 40
string dataobject = "d_app_select_tables"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;String ls_ltr
Long li_found
Long li_start_row

IF KeyDown( KeyA! )  THEN
	ls_ltr = "A"
ELSEIF KeyDown( KeyB! )  THEN
	ls_ltr = "B"
ELSEIF KeyDown( KeyC! )  THEN
	ls_ltr = "C"
ELSEIF KeyDown( KeyD! )  THEN
	ls_ltr = "D"	
ELSEIF KeyDown( KeyE! )  THEN
	ls_ltr = "E"	
ELSEIF KeyDown( KeyF! )  THEN
	ls_ltr = "F"	
ELSEIF KeyDown( KeyG! )  THEN
	ls_ltr = "G"	
ELSEIF KeyDown( KeyH! )  THEN
	ls_ltr = "H"	
ELSEIF KeyDown( KeyI! )  THEN
	ls_ltr = "I"	
ELSEIF KeyDown( KeyJ! )  THEN
	ls_ltr = "J"		
ELSEIF KeyDown( KeyK! )  THEN
	ls_ltr = "K"	
ELSEIF KeyDown( KeyL! )  THEN
	ls_ltr = "L"		
ELSEIF KeyDown( KeyM! )  THEN
	ls_ltr = "M"	
ELSEIF KeyDown( KeyN! )  THEN
	ls_ltr = "N"	
ELSEIF KeyDown( KeyO! )  THEN
	ls_ltr = "O"	
ELSEIF KeyDown( KeyP! )  THEN
	ls_ltr = "P"	
ELSEIF KeyDown( KeyQ! )  THEN
	ls_ltr = "Q"	
ELSEIF KeyDown( KeyR! )  THEN
	ls_ltr = "R"		
ELSEIF KeyDown( KeyS! )  THEN
	ls_ltr = "S"	
ELSEIF KeyDown( KeyT! )  THEN
	ls_ltr = "T"	
ELSEIF KeyDown( KeyU! )  THEN
	ls_ltr = "U"	
ELSEIF KeyDown( KeyV! )  THEN
	ls_ltr = "V"	
ELSEIF KeyDown( KeyW! )  THEN
	ls_ltr = "W"	
ELSEIF KeyDown( KeyX! )  THEN
	ls_ltr = "X"	
ELSEIF KeyDown( KeyY! )  THEN
	ls_ltr = "Y"	
ELSEIF KeyDown( KeyZ! )  THEN
	ls_ltr = "Z"		
END IF

IF ls_ltr = is_last_key THEN
	li_start_row = This.GetRow()
ELSE
	li_start_row = 0
END IF

li_found = This.Find( "Mid(data_view_screen_screen_name,1,1 ) = '" + ls_ltr + "'", li_start_row +1, 10000)

IF li_found <=0 THEN
	is_last_key = ""
	Return
END IF

This.ScrollToRow( li_found )
This.SetRow( li_found )
This.SelectRow( 0, False )
This.SelectRow( li_found, True )

is_last_key = ls_ltr
end event

event ue_after_open;//This.SetTransObject( w_train_app.tr_training_data )
//This.Retrieve( )
//This.SelectRow( 1, True )
//This.SetRow( 1 )
//
end event

event clicked;Long li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )
	This.SelectRow( 0 , False )
	This.SelectRow( li_row, True )
END IF
end event

event constructor;//PostEvent("ue_after_open")
//This.SetFocus()
end event

event getfocus;idw = This
This.BorderStyle = StyleLowered!
dw_field.BorderStyle = StyleBox!
end event

event retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-29
//$<comment> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<reason> Comment out redundant script lines.
/*
IF rowcount > 0 THEN
	dw_field.Retrieve( This.GetItemNumber( 1, "table_id" ) )
	dw_field.SelectRow( 1 , True)
	dw_field.SetRow( 1 )
END IF
*/
//---------------------------- APPEON END ----------------------------
end event

event rowfocuschanged;Integer li_Rc
Integer i

ib_personal_data = False
IF currentrow > 0 THEN
	Long li_table_id 
	li_table_id = This.GetItemNumber( currentrow, "table_id" )
	IF This.GetItemString( currentrow, "data_view_screen_screen_alias" ) = "Personal Data"  THEN
		ib_personal_data = True
		li_table_id = 25
	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-30
	//$<modify> 04.04.2006 By: Rodger Wu
	//$<reason> Performance Tuning
	//$<modification> Define the datastore for caching data.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	dw_field.Retrieve(  li_table_id )
	dw_field.SelectRow( 1 , True)
	dw_field.SetRow( 1 )
	*/
	If Not isvalid( ids_queryfield ) Then
		ids_queryfield = CREATE datastore
		ids_queryfield.DataObject = "d_dddw_system_fields"
		ids_queryfield.SetTransObject( tr_training_data )
	End If
	gnv_appeondb.of_StartQueue()
	ids_queryfield.Retrieve( li_table_id )
	dw_field.Retrieve(  li_table_id )
	gnv_appeondb.of_CommitQueue()
	
	dw_field.SelectRow( 1 , True)
	dw_field.SetRow( 1 )
	//---------------------------- APPEON END ----------------------------
END IF

is_query_field = ""
is_query_operator = ""
is_query_value = ""
end event

type dw_field from datawindow within tabpage_design
event ue_key pbm_dwnkey
event ue_after_open ( )
boolean visible = false
integer x = 750
integer y = 1248
integer width = 709
integer height = 584
integer taborder = 50
string dragicon = "AppRectangle!"
string dataobject = "d_app_select_field"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;String ls_ltr
Long li_found
Long li_start_row

IF KeyDown( KeyA! )  THEN
	ls_ltr = "A"
ELSEIF KeyDown( KeyB! )  THEN
	ls_ltr = "B"
ELSEIF KeyDown( KeyC! )  THEN
	ls_ltr = "C"
ELSEIF KeyDown( KeyD! )  THEN
	ls_ltr = "D"	
ELSEIF KeyDown( KeyE! )  THEN
	ls_ltr = "E"	
ELSEIF KeyDown( KeyF! )  THEN
	ls_ltr = "F"	
ELSEIF KeyDown( KeyG! )  THEN
	ls_ltr = "G"	
ELSEIF KeyDown( KeyH! )  THEN
	ls_ltr = "H"	
ELSEIF KeyDown( KeyI! )  THEN
	ls_ltr = "I"	
ELSEIF KeyDown( KeyJ! )  THEN
	ls_ltr = "J"		
ELSEIF KeyDown( KeyK! )  THEN
	ls_ltr = "K"	
ELSEIF KeyDown( KeyL! )  THEN
	ls_ltr = "L"		
ELSEIF KeyDown( KeyM! )  THEN
	ls_ltr = "M"	
ELSEIF KeyDown( KeyN! )  THEN
	ls_ltr = "N"	
ELSEIF KeyDown( KeyO! )  THEN
	ls_ltr = "O"	
ELSEIF KeyDown( KeyP! )  THEN
	ls_ltr = "P"	
ELSEIF KeyDown( KeyQ! )  THEN
	ls_ltr = "Q"	
ELSEIF KeyDown( KeyR! )  THEN
	ls_ltr = "R"		
ELSEIF KeyDown( KeyS! )  THEN
	ls_ltr = "S"	
ELSEIF KeyDown( KeyT! )  THEN
	ls_ltr = "T"	
ELSEIF KeyDown( KeyU! )  THEN
	ls_ltr = "U"	
ELSEIF KeyDown( KeyV! )  THEN
	ls_ltr = "V"	
ELSEIF KeyDown( KeyW! )  THEN
	ls_ltr = "W"	
ELSEIF KeyDown( KeyX! )  THEN
	ls_ltr = "X"	
ELSEIF KeyDown( KeyY! )  THEN
	ls_ltr = "Y"	
ELSEIF KeyDown( KeyZ! )  THEN
	ls_ltr = "Z"		
END IF

IF ls_ltr = is_last_key THEN
	li_start_row = This.GetRow()
ELSE
	li_start_row = 0
END IF

li_found = This.Find( "Mid(field_name_allias,1,1 ) = '" + ls_ltr + "'", li_start_row +1, 10000)

IF li_found <=0 THEN
	is_last_key = ""
	Return
END IF

This.ScrollToRow( li_found )
This.SetRow( li_found )
This.SelectRow( 0, False )
This.SelectRow( li_found, True )

is_last_key = ls_ltr
end event

event ue_after_open;//This.SetTransObject( w_train_app.tr_training_data )
//This.Retrieve( 1 )
end event

event clicked;Long li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
	This.SelectRow( 0 , False )
	This.SelectRow( li_row, True )	
END IF

//This.DragIcon = "field.ico"
This.Drag(Begin! )
end event

event constructor;//PostEvent( "ue_after_open" )
end event

event doubleclicked;//IF ii_align = 1 OR ii_copy_fields = 1 THEN
//	MessageBox("Tools", "You must select the SELECT FIELD tool from the tools menu to select a field." )
//	Return 0
//END IF
//ib_new_select = True
//
//if this.getitemnumber(row,"field_id") = 91125 or this.getitemnumber(row,"parent_field") = 91125 then
//	messagebox("Mapping error","The field Address Type cannot be mapped.  It can only be used for Query Filters.")
//	return -1
//end if
//
//of_select_button()

of_dw_field_dclick()


end event

event getfocus;idw = This
This.BorderStyle = StyleLowered!
//dw_screen.BorderStyle = StyleBox!
end event

event retrieveend;//IF NOT ib_hold_on_retrieve_end THEN
	of_retrieve_end()
//END IF


//Long i
//Long l
//Long li_nr
//String ls_address_fields[]
//String ls_code_fields[]
//
//ls_code_fields[2] = "Code"
//ls_code_fields[1] = "Description"
//
//ls_address_fields[9] = "Entity_Name"
//ls_address_fields[8] = "Street1"
//ls_address_fields[7] = "Street2"
//ls_address_fields[6] = "City"
//ls_address_fields[5] = "State"
//ls_address_fields[4] = "Zip"
//ls_address_fields[3] = "Country"
//ls_address_fields[2] = "Phone"
//ls_address_fields[1] = "Fax"
//
//
//FOR i = 1 TO rowcount
//	IF This.GetItemString( i, "lookup_type" ) = "A" THEN
//		FOR l = 1 TO 9
//			li_nr = This.InsertRow( i + 1)
//			rowcount = rowcount + 1
//			This.SetItem( li_nr, "parent_field", This.GetItemNumber( i, "field_id" ))
//			This.SetItem( li_nr, "field_name_allias", ls_address_fields[l] )
//			This.SetItem( li_nr, "field_type", "AL" )
//			This.SetItem( li_nr, "field_id", This.GetItemNumber( i, "field_id" )) 
//			This.SetItem( li_nr, "table_id", This.GetItemNumber( i, "table_id" )) 
//		END FOR
//	ELSEIF This.GetItemString( i, "lookup_type" ) = "C" THEN
//		FOR l = 1 TO 2
//			li_nr = This.InsertRow( i + 1)
//			rowcount = rowcount + 1
//			This.SetItem( li_nr, "parent_field", This.GetItemNumber( i, "field_id" ))
//			This.SetItem( li_nr, "field_name_allias", ls_code_fields[l] )
//			This.SetItem( li_nr, "field_type", "CL" )
//			This.SetItem( li_nr, "field_id", This.GetItemNumber( i, "field_id" )) 
//			This.SetItem( li_nr, "table_id", This.GetItemNumber( i, "table_id" )) 
//		END FOR		
//	END IF
//END FOR
//
//IF rowcount > 0 THEN
//	This.SetRow( 1 )
//	This.SelectRow( 1, True )
//END IF
end event

event dragleave;//ib_drag_drop = True
//This.TriggerEvent( DoubleClicked! )
end event

type uo_bar from pfc_cst_build_annotation_bar within tabpage_design
boolean visible = false
integer x = 23
integer y = 1140
integer width = 1001
integer height = 56
integer taborder = 40
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_bar.destroy
call pfc_cst_build_annotation_bar::destroy
end on

type dw_2 from datawindow within tabpage_design
boolean visible = false
integer x = 206
integer y = 952
integer width = 1339
integer height = 716
integer taborder = 70
string dataobject = "d_auto_align_side"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject( sqlca )
end event

type dw_1 from datawindow within tabpage_design
boolean visible = false
integer x = 192
integer y = 960
integer width = 1339
integer height = 680
integer taborder = 50
string dataobject = "d_auto_align"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject( sqlca )
end event

type tab_fld_prop from tab within tabpage_design
event ue_showtabpage ( integer ai_flag )
integer x = 2441
integer y = 1712
integer width = 1993
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

event ue_showtabpage(integer ai_flag);if ai_Flag = 0 then
	this.selectedtab = 3
	this.tabpage_1.Hide()
	this.tabpage_2.Hide()
	//this.tabpage_4.Hide()
	this.tabpage_5.Hide()
elseif ai_Flag = 1 then
	this.tabpage_1.Show()
	this.tabpage_2.Show()
	//this.tabpage_4.Show()
	this.tabpage_5.Show()
	this.selectedtab = 1
end if
end event

event selectionchanged;
IF newindex = 1 THEN
	li_last_fld_prop_tab = 1
	dw_fld_prop.Object.DataWindow.VerticalScrollPosition='0'
	dw_fld_prop.SetColumn( "width" )
ELSEIF newindex = 2 THEN
	li_last_fld_prop_tab = 2
	dw_fld_prop.Object.DataWindow.VerticalScrollPosition='580'
	dw_fld_prop.SetColumn( "record_number" )	
ELSEIF newindex = 3 THEN
	li_last_fld_prop_tab = 3
	dw_fld_prop.Object.DataWindow.VerticalScrollPosition='1340'
	dw_fld_prop.SetColumn( "object_type" )
ELSEIF newindex = 4 THEN //address query //maha 030705
	li_last_fld_prop_tab = 4
	dw_fld_prop.Object.DataWindow.VerticalScrollPosition='2000'
	dw_fld_prop.SetColumn( "record_num_addr" )
ELSEIF newindex = 5 THEN //Add by Evan 04.08.2009 --- New feature for App Mapping Addition Filters
	li_last_fld_prop_tab = 5
	dw_fld_prop.Object.DataWindow.VerticalScrollPosition='2800'
	dw_fld_prop.SetColumn( "addtl_filters" )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liu Hongxin
//$<reason> Fix defect.
tab_1.tabpage_design.dw_fld_prop.SetRedraw(True)
//---------------------------- APPEON END ----------------------------

dw_quick_filters.Event ue_ShowWindow() //evan 12.15.2010
end event

on tab_fld_prop.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_fld_prop.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event constructor;//tabpage_4.visible = false
end event

type tabpage_1 from userobject within tab_fld_prop
integer x = 18
integer y = 100
integer width = 1957
integer height = -20
long backcolor = 32891346
string text = "Format"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_3 cb_3
st_1 st_1
st_2 st_2
end type

on tabpage_1.create
this.cb_3=create cb_3
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.cb_3,&
this.st_1,&
this.st_2}
end on

on tabpage_1.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.st_2)
end on

type cb_3 from commandbutton within tabpage_1
integer x = 1001
integer y = 40
integer width = 261
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fast View"
end type

event clicked;long ll_app_field_id

if tab_1.tabpage_design.dw_fld_prop.GetRow() < 1 then Return
ll_app_field_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber(1, "app_field_id")

openwithparm(w_app_prop_view, ll_app_field_id) //evan 10.27.2011
end event

type st_1 from statictext within tabpage_1
integer y = 160
integer width = 791
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "No Field Selected"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_1
boolean visible = false
integer x = 347
integer y = 24
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type tabpage_2 from userobject within tab_fld_prop
integer x = 18
integer y = 100
integer width = 1957
integer height = -20
long backcolor = 32891346
string text = "Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_fld_prop
integer x = 18
integer y = 100
integer width = 1957
integer height = -20
long backcolor = 32891346
string text = "Display Type"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_fld_prop
boolean visible = false
integer x = 18
integer y = 100
integer width = 1957
integer height = -20
long backcolor = 32891346
string text = "Addr Query"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_fld_prop
integer x = 18
integer y = 100
integer width = 1957
integer height = -20
long backcolor = 32891346
string text = "Addtl Filters"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type dw_fld_prop from datawindow within tabpage_design
event ue_reset ( )
event ue_init ( integer ai_mapping_type )
integer x = 919
integer y = 1816
integer width = 3511
integer height = 352
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_app_field_properties"
end type

event ue_reset();//====================================================================
// $<event> ue_Reset()
// $<arguments>
// $<returns> (None)
// $<description> N/A
// $<add> (Appeon) evan 10.28.2011
//====================================================================

this.Reset()
st_field_name.Text = "No Field Selected"
dw_quick_filters.Event ue_ShowWindow()
end event

event ue_init(integer ai_mapping_type);//====================================================================
// $<event> ue_init()
// $<arguments>
//		integer	ai_mapping_type
// $<returns> integer
// $<description> initialize dw - V12.1 Website Population
// $<add> (Appeon) evan 01.20.2012
//====================================================================

datawindowchild ldw_child

// Filter object type of child
this.GetChild("object_type", ldw_child)
ldw_child.SetFilter("mapping_type = " + String(ai_mapping_type))
ldw_child.Filter()

// Show or hide some fields
this.Modify('mapping_type.expression="' + String(ai_mapping_type) + '"')
end event

event buttonclicked;string nullval

SetNull( nullval )
//Start Code Change ---- 06.08.2006 #533 maha modified as choose from if and added address type options
choose case dwo.Name
	case "b_1"  //main query
		This.SetItem( 1, "query_field", nullval )
		This.SetItem( 1, "query_operator", nullval )
		This.SetItem( 1, "query_value", nullval )
		This.SetItem( 1, "billing_address_flag", 0 )
	case "b_2"  //address query
		This.SetItem( 1, "query_field_addr", nullval )
		This.SetItem( 1, "query_operator_addr", nullval )
		This.SetItem( 1, "query_value_addr", nullval )
		This.SetItem( 1, "billing_link_addr", 0 )
	case "b_disconnect"  //connect data
		This.SetItem( 1, "connect_field_id", long(nullval) )
		This.SetItem( 1, "connect_field_sort", long(nullval ) )
	case "b_poq" //prime office
		This.SetItem( 1, "query_field", "address_type" )
		This.SetItem( 1, "query_operator", "="  )
		This.SetItem( 1, "query_value", "647" )
	case "b_aoq" //add office
		This.SetItem( 1, "query_field", "address_type" )
		This.SetItem( 1, "query_operator", "="  )
		This.SetItem( 1, "query_value", "256" )
	case "b_haq" //home addr
		This.SetItem( 1, "query_field", "address_type" )
		This.SetItem( 1, "query_operator", "="  )
		This.SetItem( 1, "query_value", "648" )
	case "b_po" //prime office gp
		This.SetItem( 1, "query_field_addr", "address_type" )
		This.SetItem( 1, "query_operator_addr", "="  )
		This.SetItem( 1, "query_value_addr", "647" )
	case "b_ao" //add office gp
		This.SetItem( 1, "query_field_addr", "address_type" )
		This.SetItem( 1, "query_operator_addr", "="  )
		This.SetItem( 1, "query_value_addr", "256" )
	case "b_ha" //home addr gp
		This.SetItem( 1, "query_field_addr", "address_type" )
		This.SetItem( 1, "query_operator_addr", "="  )
		This.SetItem( 1, "query_value_addr", "648" )
	case "b_filter_wizard" //Add by Evan 04.09.2009 --- New feature for App Mapping Addition Filters
		string ls_Message
		integer li_table_id
		li_table_id = this.GetItemNumber(1, "table_id")
		ls_Message = "APPLICATION|" + String(li_table_id) + "|NULL|NULL"
		OpenWithParm(w_query_wizard, ls_Message)
		ls_Message = Message.StringParm
		if ls_Message <> "Cancel" then
			this.SetItem(1, "addtl_filters", ls_Message)
		end if
end choose
//End Code Change---06.08.2006

end event

event editchanged;ib_saved = False
end event

event itemchanged;DataWindowChild dwchild
String ls_lookup_code 
Long li_found
Long li_rc
Long li_nr
String ls_query_field
String ls_fld_type
String ls_lookup_type
String nullval
integer c

SetNull( nullval )

IF This.GetColumnName() = "query_field" THEN
		
	c = This.GetChild( "query_field", dwchild )
	li_found = dwchild.Find( "field_name = '" + GetText() + "'", 1, 10000 )
	IF li_found > 0 THEN
		ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
		ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
		ls_fld_type = dwchild.GetItemString( li_found, "field_type" )
		
		ls_query_field = This.GetItemString( row, "query_field" )
		of_set_query_lookup(ls_lookup_type,data,ls_lookup_code,"query_value")
	END IF
	This.SetItem( row, "query_value", nullval )
	This.SetItem( row, "query_operator", "=" )
//Start Code Change ---- 02.07.2006 #257 maha
ELSEIF This.GetColumnName() = "query_field_addr" THEN
	c = This.GetChild( "query_field_addr", dwchild )
	li_found = dwchild.Find( "field_name = '" + GetText() + "'", 1, 10000 )
	IF li_found > 0 THEN
		ls_lookup_code = dwchild.GetItemString( li_found, "lookup_code" )
		ls_lookup_type = dwchild.GetItemString( li_found, "lookup_type" )
		ls_fld_type = dwchild.GetItemString( li_found, "field_type" )
		
		ls_query_field = This.GetItemString( row, "query_field_addr" )
		of_set_query_lookup(ls_lookup_type,data,ls_lookup_code,"query_value_addr")
	END IF
//Start Code Change ----11.15.2011 #V12 maha - corrected field names
//	This.SetItem( row, "query_value", nullval )
//	This.SetItem( row, "query_operator", "=" )	
	This.SetItem( row, "query_value_addr", nullval )
	This.SetItem( row, "query_operator_addr", "=" )	
//End Code Change ----11.15.2011	

ELSEIF This.GetColumnName() = "object_type" AND (data = 'Y1' OR data = 'Y2' OR data = "C" OR data = "B" ) THEN
//Start Code Change ---- 08.29.2007 #V7 maha changed to function call
//-------------appeon begin--------------
//<$>added:long.zhang 01.17.2013
//<$>reason:mapping issue bug 3385
	if data = "C" and row > 0 then
		if Upper(this.getitemstring( row,"lookup_link_field")) = "DESCRIPTION" then
			this.Modify( "box_yes_value.dddw.datacolumn = 'description'")	
		elseif 	Upper(this.getitemstring( row,"lookup_link_field"))  = "CODE" then
			this.Modify( "box_yes_value.dddw.datacolumn = 'code'")	
		end if
	end if
//-----------appeon end--------------
	of_set_yes_no_box( this, data)
//	This.GetChild( "box_yes_value", dwchild )
//	ls_lookup_code = This.GetItemString( row, "lookup_code")
//	dw_fld_prop.GetChild( "box_yes_value", dwchild )
//	dwchild.SetTransObject( w_train_app.tr_training_data )
//	dwchild.Retrieve( ls_lookup_code )		
//	This.GetChild( "box_no_value", dwchild )
//	ls_lookup_code = This.GetItemString( row, "lookup_code")
//	dw_fld_prop.GetChild( "box_no_value", dwchild )
//	dwchild.SetTransObject( w_train_app.tr_training_data )
//	//messagebox("2", ls_lookup_code )	
//	dwchild.Retrieve( ls_lookup_code )			
//END IF
//
//IF This.GetColumnName() = "object_type" THEN
//	This.GetChild( "box_yes_value", dwchild )
//	li_nr = dwchild.InsertRow( 0 )
//	dwchild.SetItem( li_nr, "code", "Is Null" )
//	li_nr = dwchild.InsertRow( 0 )
//	dwchild.SetItem( li_nr, "code", "Is Not Null" )	
//	This.GetChild( "box_no_value", dwchild )
//	li_nr = dwchild.InsertRow( 0 )
//	dwchild.SetItem( li_nr, "code", "Is Null" )
//	li_nr = dwchild.InsertRow( 0 )
//	dwchild.SetItem( li_nr, "code", "Is Not Null" )		
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 04.01.2006 By: Liang QingShi
//	//$<reason> Fix a defect.	
//	if data = "C" then
//		dw_fld_prop.Modify( "box_no_value_t.visible = 0")
//		dw_fld_prop.Modify( "box_no_value.visible = 0")
//	else
//		dw_fld_prop.Modify( "box_no_value_t.visible = 1")
//		dw_fld_prop.Modify( "box_no_value.visible = 1")
//	end if	
//	//---------------------------- APPEON END ----------------------------
END IF
//End Code Change---08.29.2007			


IF This.GetColumnName() = "object_type" THEN
	This.GetChild( "box_yes_value", dwchild )
	li_nr = dwchild.InsertRow( 0 )
	dwchild.SetItem( li_nr, "code", "Is Null" )
	li_nr = dwchild.InsertRow( 0 )
	dwchild.SetItem( li_nr, "code", "Is Not Null" )	
	This.GetChild( "box_no_value", dwchild )
	li_nr = dwchild.InsertRow( 0 )
	dwchild.SetItem( li_nr, "code", "Is Null" )
	li_nr = dwchild.InsertRow( 0 )
	dwchild.SetItem( li_nr, "code", "Is Not Null" )		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.01.2006 By: Liang QingShi
	//$<reason> Fix a defect.	
	if data = "C" then
		dw_fld_prop.Modify( "box_no_value_t.visible = 0")
		dw_fld_prop.Modify( "box_no_value.visible = 0")
	else
		dw_fld_prop.Modify( "box_no_value_t.visible = 1")
		dw_fld_prop.Modify( "box_no_value.visible = 1")
	end if	
	//---------------------------- APPEON END ----------------------------
END IF


ib_saved = False
end event

event retrieveend;//maha modified 042505 to use of_set_query_lookup function
//Start Code Change ---- 02.09.2006 #258 maha  removed query field dw setup is set in of_update_field
Integer li_found
Integer li_retval
integer li_table
String ls_lookup_code
String ls_data
DataWindowChild dwchild
string ls_query_fld
string ls_lookup_type
string ls_fld_type
string ls_find
integer i

dw_quick_filters.Event ue_ShowWindow() //evan 12.15.2010
if this.rowcount() < 1 then return //maha 020906

of_select_field_info( ) //updates the selected field label 
		
//Group related
li_table = This.GetItemNumber( 1, "table_id")
if li_table >= 80 and li_table < 90 then //maha 020106 
	tab_1.tabpage_design.tab_fld_prop.tabpage_4.visible = true
	this.object.st_addr.visible = true
else
	tab_1.tabpage_design.tab_fld_prop.tabpage_4.visible = false
	this.object.st_addr.visible = false
	if tab_1.tabpage_design.tab_fld_prop.selectedtab = 4 then
		tab_1.tabpage_design.tab_fld_prop.selecttab(1)
	end if
end if
//End Code Change---02.09.2006

//fix issues. 
//if tab_1.tabpage_design.tab_fld_prop.selectedtab <> 4 then  //Commented By Ken.Guo 12/11/2007 For Focus can Not jump to tabpage_4 after click Apply button.
	long ll_tab
	ll_tab = tab_1.tabpage_design.tab_fld_prop.selectedtab
	tab_1.tabpage_design.dw_fld_prop.SetRedraw(False)
	tab_1.tabpage_design.tab_fld_prop.Post event selectionchanged(1 , ll_tab)
//End if //Commented By Ken.Guo 12/11/2007 

//Start Code Change ---- 08.29.2007 #V7 maha
of_set_yes_no_box( this,this.getitemstring(1, "object_type"))
//End Code Change---08.29.2007
end event

event retrievestart;//maha added 030205 to set the query_value field to text type rather than dddw that was causing a retrieval box.
//dddw retrieval takes place in the retrieveend event.



//this.Modify( "query_value.dddw.name = ''")
//this.Modify( "query_value.dddw.DataColumn = 'code'")
//this.Modify( "query_value_addr.dddw.name = ''")
//this.Modify( "query_value_addr.dddw.DataColumn = 'code'")
//maha removed 042505with additional modification to retrieveend
end event

event getfocus;ib_IsDeleteAnnotation = false //Add by Evan 05.27.2009
end event

event losefocus;ib_IsDeleteAnnotation = true //Add by Evan 05.27.2009

////------------------- APPEON BEGIN ------------------- //Start Code Change ----06.12.2012 #V12 maha - removed
////$<add> Stephen 06.08.2012
////$<reason>Bug id 3134: Format width in application mapping
//tab_1.tabpage_design.dw_fld_prop.accepttext()
//if tab_1.tabpage_design.dw_fld_prop.modifiedcount() > 0 then
//	tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )	
//end if
////------------------- APPEON END -------------------
end event

type cb_apply from commandbutton within tabpage_design
event ue_apply ( )
integer x = 3877
integer y = 1980
integer width = 261
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Apply"
boolean default = true
end type

event ue_apply();//====================================================================
// $<event> ue_apply()
// $<arguments>
// $<returns> (None)
// $<description> N/A
// $<add> (Appeon) evan 10.27.2011
//====================================================================

if dw_fld_prop.rowcount() = 0 then Return

// Get field information
dw_fld_prop.AcceptText()
ii_record_number = dw_fld_prop.GetItemNumber( 1, "record_number" )
is_query_field = dw_fld_prop.GetItemString( 1, "query_field" )
is_query_operator = dw_fld_prop.GetItemString( 1, "query_operator" )
is_query_value = dw_fld_prop.GetItemString( 1, "query_value" )
ii_billing_address_flag = dw_fld_prop.GetItemNumber( 1, "billing_address_flag" )
ii_addr_record_number = dw_fld_prop.GetItemNumber( 1, "record_num_addr" )
is_addr_query_field = dw_fld_prop.GetItemString( 1, "query_field_addr" )
is_addr_query_operator = dw_fld_prop.GetItemString( 1, "query_operator_addr" )
is_addr_query_value = dw_fld_prop.GetItemString( 1, "query_value_addr" )
ii_addr_billing_flag = dw_fld_prop.GetItemNumber( 1, "billing_link_addr" )
il_loc_id = dw_fld_prop.GetItemNumber( 1, "loc_id_passed" ) //Start Code Change ----05.19.2014 #V14.2 maha

// Check query criteria
IF NOT IsNull( is_query_field ) AND IsNull( is_query_operator ) THEN
	MessageBox("Error", "Need to put a Query Field Operator." )
	dw_fld_prop.SetColumn( "query_operator" )
	Return
END IF

// Update data
gnv_appeondb.of_StartQueue()
dw_fld_prop.Update()
Commit;
gnv_appeondb.of_CommitQueue()
end event

event clicked;//------------------- APPEON BEGIN -------------------
//$<add> Evan 10.27.2011
//$<reason> V12.1 Website Population
if il_mapping_type = 2 then
	this.Event ue_Apply()
	Return
end if
//------------------- APPEON END ---------------------


SetPointer( Arrow! )
dw_fld_prop.SetRedraw( False )

String ls_format
String ls_object_type
String ls_field_type
String ls_lookup_link_type
String ls_group_nm
String ls_fld_desc
String ls_lookup_link_field
String ls_fld_display
String ls_font_type
Long ll_field_id
Long li_field_len
long li_app_field_id //modified 071802 maha
String ls_fld_nm
String ls_tbl_nm
String ls_box_yes_value

dw_fld_prop.AcceptText()
if dw_fld_prop.rowcount() = 0 then return //maha 101804

ls_object_type = dw_fld_prop.GetItemString( 1, "object_type" )
ls_box_yes_value = ""
li_app_field_id = dw_fld_prop.GetItemNumber( 1, "app_field_id" )
tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) )		

CHOOSE CASE Upper( ls_object_type )
	CASE "Y1"
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox" )
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox" )		
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "Check" )  //add by stephen 06.13.2012 --delete check mark and select box when changed to text
	CASE "C"
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "Check" )	
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox" ) //add by stephen 06.13.2012 --delete check mark and select box when changed to text
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox" )		
		ls_box_yes_value = dw_fld_prop.GetItemString( 1, "box_yes_value" )
	CASE "T"  //add by stephen 06.13.2012 --delete check mark and select box when changed to text
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "YesBox" )
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "NoBox" )		
		tab_1.tabpage_design.ole_edit.Object.DeleteAnnotationGroup( String(li_app_field_id) + "Check" )	
END CHOOSE

gnv_appeondb.of_StartQueue()
dw_fld_prop.Update()
dw_fld_prop.Retrieve( li_app_field_id )
gnv_appeondb.of_CommitQueue()

if dw_fld_prop.rowcount() = 0 then return //Nova 2010.08.05
ls_fld_nm = dw_fld_prop.GetItemString( 1, "field_name" )
ls_tbl_nm = dw_fld_prop.GetItemString( 1, "table_name" )
li_field_len = dw_fld_prop.GetItemNumber( 1, "width" )

ii_record_number = dw_fld_prop.GetItemNumber( 1, "record_number" )
is_query_field = dw_fld_prop.GetItemString( 1, "query_field" )
is_query_operator = dw_fld_prop.GetItemString( 1, "query_operator" )
is_query_value = dw_fld_prop.GetItemString( 1, "query_value" )
ii_billing_address_flag = dw_fld_prop.GetItemNumber( 1, "billing_address_flag" )
ii_addr_record_number = dw_fld_prop.GetItemNumber( 1, "record_num_addr" )
is_addr_query_field = dw_fld_prop.GetItemString( 1, "query_field_addr" )
is_addr_query_operator = dw_fld_prop.GetItemString( 1, "query_operator_addr" )
is_addr_query_value = dw_fld_prop.GetItemString( 1, "query_value_addr" )
ii_addr_billing_flag = dw_fld_prop.GetItemNumber( 1, "billing_link_addr" )
il_loc_id = dw_fld_prop.GetItemNumber( 1, "loc_id_passed" )  //Start Code Change ----05.19.2014 #V14.2 maha

//Start Code Change ----01.10.2011 #V11 maha - trap for width
//if li_field_len > 255 or li_field_len = 0 then
if li_field_len > 255  then
	MessageBox("Mapping Error", "The field Width must be between 1 and 255." )
	dw_fld_prop.SetColumn( "width" )
	dw_fld_prop.Setfocus(  )
	dw_fld_prop.SetRedraw( True )
	Return -1
end if
//Start Code Change ----01.10.2011


IF NOT IsNull( is_query_field ) AND IsNull( is_query_operator ) THEN
	MessageBox("Error", "Need to put a Query Field Operator." )
	dw_fld_prop.SetColumn( "query_operator" )
	dw_fld_prop.SetRedraw( True )
	Return -1
END IF

w_train_app.tab_1.tabpage_design.st_field.Text = ls_tbl_nm + "->" + ls_fld_nm

//Start Code Change ----06.12.2012 #V12 maha - moved to of_select_button
//IF w_train_app.ib_new_field_selection THEN
//	ls_fld_nm = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_name" )
//	CHOOSE CASE Upper( ls_fld_nm )
//		CASE "STATE"
//			li_field_len = 2
//		CASE "PLACE OF BIRTH STATE"
//			li_field_len = 2
//		CASE "TITLE"
//			li_field_len = 6
//		CASE "NAME SUFFIX"
//			li_field_len = 6			
//		CASE "SUFFIX"
//			li_field_len = 6
//		CASE "LAST NAME"
//			li_field_len = 15
//		CASE "PROFESSIONAL SUFFIX","PROFFESIONAL SUFFIX"
//			li_field_len = 6
//		CASE "SS #"
//			ls_format = "SS#"
//		CASE "COVERAGE LIMIT FROM", "COVERAGE LIMIT TO"
//			li_field_len = 12
//			ls_format = "Money"
//		CASE "NAME/STREET 1"
//			li_field_len = 45
//		CASE "STREET"
//			li_field_len = 45
//		CASE "ID NUMBER"
//			li_field_len = 15
//		CASE "LICENSE NUMBER"
//			li_field_len = 15			
//	END CHOOSE
//	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "width", li_field_len )	
//	tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "format", ls_format )	
//END IF

//	w_train_app.tab_1.tabpage_design.ole_edit.Object.SelectAnnotationGroup( "" )
//	w_train_app.ib_click_position = True
//	w_train_app.tab_1.tabpage_design.st_click_msg.Visible = True
//	w_train_app.tab_1.tabpage_design.ole_edit.object.AnnotationType( 0 )
//	w_train_app.tab_1.tabpage_design.ole_edit.object.SelectionRectangle( True )		
//	w_train_app.of_disable_buttons()
//	DO WHILE w_train_app.ib_click_position
//		Yield()
//	LOOP
//	w_train_app.ib_click_position = False
//	w_train_app.tab_1.tabpage_design.ole_edit.object.AnnotationType( 11 )
//	w_train_app.tab_1.tabpage_design.st_click_msg.Visible = False
//	w_train_app.ib_new_field_selection = False
//	w_train_app.of_enable_buttons()
//END IF

CHOOSE CASE ls_object_type
	CASE "T"
		ll_field_id = dw_fld_prop.GetItemNumber( 1, "field_id" )
		ls_field_type = dw_fld_prop.GetItemString( 1, "sys_fields_field_type" )
		ls_lookup_link_type = dw_fld_prop.GetItemString( 1, "lookup_link_type" )
		ls_lookup_link_field = dw_fld_prop.GetItemString( 1, "lookup_link_field" )
		IF ls_lookup_link_type = "A" OR ls_lookup_link_type = "C" THEN
			ls_field_type = "C"
			IF ls_lookup_link_type = "A" THEN
				w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->address_lookup->" + ls_lookup_link_field 
			ELSE
				w_train_app.tab_1.tabpage_design.st_field.Text = w_train_app.tab_1.tabpage_design.st_field.Text + "->code_lookup->" + ls_lookup_link_field		
			END IF
		END IF
		CHOOSE CASE Upper( ls_field_type )
			CASE "C"
				ls_fld_display = FillA( "x", li_field_len )
			CASE "I"
				ls_fld_display = FillA( "#", li_field_len )				
			CASE "D"
				ls_fld_display = "mm/dd/yyyy"
			CASE "N"
				ls_fld_display = FillA( "#", li_field_len )								
		END CHOOSE

		IF LenA(ls_fld_display) > 255 THEN ls_fld_display = LeftA(ls_fld_display, 255) //limit 260 - alfee 11.03.2009
		if IsNull(ls_fld_display) then ls_fld_display=""//Nova 05.18.2010
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( ls_fld_display )
		tab_1.tabpage_design.ole_edit.object.AnnotationFontColor(255)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)		

		CHOOSE CASE dw_fld_prop.GetItemNumber( 1, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 5				
				END IF
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8				
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 8
				END IF
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12		
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 10
				END IF
		END CHOOSE
		IF dw_fld_prop.GetItemNumber( 1, "font_bold" ) = 1 THEN
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = True
		ELSE
			tab_1.tabpage_design.ole_edit.object.AnnotationFont.Bold = False
		END IF
		if ib_IsDragAnnotation then
			tab_1.tabpage_design.ole_edit.object.Draw(il_AnnoPosX, il_AnnoPosY, 0, 0) //evan 12.16.2010
		else
			tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x, w_train_app.ii_ancor_y, 0, 0)
		end if
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
	CASE "B"
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( dw_fld_prop.GetItemNumber( dw_fld_prop.GetRow(), "field_id" ) )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x, w_train_app.ii_ancor_y, 20,20)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)			
	CASE "Y1"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "YesBox")
		tab_1.tabpage_design.ole_edit.object.Annotationtype(3)
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 255 )		
		tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x, w_train_app.ii_ancor_y, 20,20)
		
		//no
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "NoBox")
		tab_1.tabpage_design.ole_edit.object.AnnotationLineColor( 0 )
		tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x + 30, w_train_app.ii_ancor_y, 20,20)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)					
	CASE "Y2"
		//yes box
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String(li_app_field_id) + "YesCheck")
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x, w_train_app.ii_ancor_y, 10,10)		
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)							
	CASE "C"		
		tab_1.tabpage_design.ole_edit.Object.AddAnnotationGroup( String( li_app_field_id ) + "Check" )
		tab_1.tabpage_design.ole_edit.object.AnnotationStampText( "X" )
		tab_1.tabpage_design.ole_edit.object.Annotationtype(8)
		CHOOSE CASE dw_fld_prop.GetItemNumber( 1, "font_size" )
			CASE 1
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "MS Serif"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 7
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 5				
				END IF
			CASE 2
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 8			
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 8	
				END IF
			CASE 3
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Name = "Times New Roman"
				tab_1.tabpage_design.ole_edit.object.AnnotationFont.Size = 12
				IF w_train_app.ib_moving_field OR Not ib_new_select THEN
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y
				ELSE
					w_train_app.ii_ancor_y = w_train_app.ii_ancor_y - 10
				END IF
		END CHOOSE
		tab_1.tabpage_design.ole_edit.object.Draw(w_train_app.ii_ancor_x, w_train_app.ii_ancor_y, 10,10)
		tab_1.tabpage_design.ole_edit.object.Annotationtype(11)	
END CHOOSE

ls_fld_desc = 	w_train_app.tab_1.tabpage_design.st_field.Text   //+ " (" + ls_object_type + "-" + ls_box_yes_value + ")"		
//messagebox("", ls_fld_desc)
	
dw_fld_prop.SetItem( 1, "field_description", ls_fld_desc )

IF IsNull( ls_fld_desc ) OR ls_fld_desc = "" THEN
	w_train_app.ib_new_field_selection = False
	MessageBox("Error", "Invalid field description" )
	dw_fld_prop.SetRedraw( True )	
	Return -1
END IF

dw_fld_prop.Update()

ib_applied = True
ib_selected = False
//st_msg.Visible = False

ib_new_select = False
w_train_app.ib_new_field_selection = False
dw_fld_prop.SetRedraw( True )	

end event

type cb_view from commandbutton within tabpage_design
integer x = 5
integer y = 216
integer width = 311
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select View"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Alfee 12.02.2010
//////////////////////////////////////////////////////////////////////

String ls_msg

ls_msg = "A" +String(il_default_view) 
OpenWithParm(w_select_view, ls_msg)

ls_msg = Message.StringParm
IF Pos(ls_msg, "~t") > 0 THEN
	il_default_view = Long(Left(ls_msg, Pos(ls_msg, "~t") - 1) )
	dw_field_tv.Reset()
	of_retrievefields()
END If


end event

type dw_quick_filters from datawindow within tabpage_design
event ue_showwindow ( )
event type long ue_retrievedddw ( )
boolean visible = false
integer x = 1230
integer y = 1824
integer width = 850
integer height = 124
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_app_quick_filters"
boolean border = false
boolean livescroll = true
end type

event ue_showwindow();long ll_Row
long ll_Null

ll_Row = dw_fld_prop.GetRow()
if ll_Row < 1 or tab_fld_prop.SelectedTab <> 2 then
	this.Hide()
	Return
end if

SetNull(ll_Null)
this.SetItem(1, "app_filter_id", ll_Null)
this.Show()
this.Post SetPosition(ToTop!)
end event

event type long ue_retrievedddw();long ll_Null
long ll_FindRow
long ll_table_id
long ll_screen_id
datawindowchild ldwc_child

this.SetPosition(ToTop!)

if dw_fld_prop.GetRow() < 1 then Return -1
this.GetChild("app_filter_id", ldwc_child)

ll_table_id = dw_fld_prop.object.table_id[1]
ll_FindRow = dw_field_tv.Find("table_id=" + String(ll_table_id), 1, dw_field_tv.RowCount())
if ll_FindRow > 0 then
	ll_screen_id = dw_field_tv.GetItemNumber(ll_FindRow, "data_view_screen_screen_id")
else
	ldwc_child.Reset() //evan 10.28.2011
	Return -1
end if

ldwc_child.SetTransObject(SQLCA)
if ldwc_child.GetRow() > 0 then
	if ldwc_child.GetItemNumber(ldwc_child.RowCount(), "screen_id") = ll_screen_id then
		//Do not retrieve for performance
		Return 0
	else
		ldwc_child.Retrieve(ll_screen_id)
	end if
else
	ldwc_child.Retrieve(ll_screen_id)
end if

SetNull(ll_Null)
ldwc_child.InsertRow(1)
this.SetItem(1, "app_filter_id", ll_Null)

Return 1
end event

event constructor;this.Hide()
this.Post SetPosition(ToTop!)
end event

event itemchanged;long ll_Row
datawindowchild ldwc_child

dw_quick_filters.GetChild("app_filter_id", ldwc_child)
ll_Row = ldwc_child.GetRow()

if ll_Row > 0 and dw_fld_prop.GetRow() > 0 then
	dw_fld_prop.SetItem(1, "query_field", ldwc_child.GetItemString(ll_Row, "screen_field"))
	dw_fld_prop.SetItem(1, "query_operator", ldwc_child.GetItemString(ll_Row, "operator"))
	//---------Begin Added by (Appeon)Stephen 04.14.2015 for V14.2 Bug # 4482  case# 00053227 - Address type is missing from the Filter Query Field and other issues--------
	dw_fld_prop.setcolumn("query_field")
	dw_fld_prop.event itemchanged(1, dw_fld_prop.object, "query_field")
	//---------End Added ------------------------------------------------------
	dw_fld_prop.SetItem(1, "query_value", ldwc_child.GetItemString(ll_Row, "filter_value"))
end if


end event

type dw_buttons from datawindow within tabpage_design
integer width = 4649
integer height = 188
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_app_training_buttons2"
boolean border = false
boolean livescroll = true
end type

event constructor;this.insertrow(1)
this.object.datawindow.color = gl_button_bar_color  //Start Code Change ----02.17.2016 #V15 maha
end event

event buttonclicked;//Start Code Change ----09.2012 #V12 maha - started coding
long ll_handle
string ls_page
//debugbreak()

ib_rope = false //Start Code Change ----05.09.2013 #V12 maha
this.accepttext()
//Aligns - tops
if dwo.name = "b_align_top" then
	if this.getitemstring(row,"align") = '1' then
		of_align("Top")
		this.setitem(1,"align", "0") 
		this.accepttext( )
	end if
//	-Sides
elseif dwo.name = "b_align_side" then
	if this.getitemstring(row,"align") = '1' then
		of_align("Side")
		this.setitem(1,"align", "0") 
		this.accepttext( )
	end if
//connect	
elseif dwo.name = "b_chain" then
	if this.getitemstring(row,"connect") = '1' then
		of_connect_field( )
	end if
	this.setitem(row,"connect", "0") 
	this.accepttext( )
//select
elseif dwo.name = "b_select" then
	IF IsValid(w_train_app) THEN
		w_train_app.of_select_Field()	
	END IF
//rope	
elseif dwo.name = "b_rope" then
	ib_rope = true  //Start Code Change ----05.09.2013 #V12 maha
	w_train_app.triggerevent("ue_rope_select")
//text	
elseif dwo.name = "b_text" then
	If appeongetclienttype() <> 'PB' Then
		ll_handle = handle(w_mdi)
		gnv_appeondll.of_SetToolbar( ll_handle , 3, False )  
		gnv_appeondll.of_settoolbarpos(ll_handle)
	End If
	w_train_app.triggerevent("ue_create_text")
//box	
elseif dwo.name = "b_box" then
	If appeongetclienttype() <> 'PB' Then
		ll_handle = handle(w_mdi)
		gnv_appeondll.of_SetToolbar( ll_handle , 3, False )  
		gnv_appeondll.of_settoolbarpos(ll_handle)
	End If
	w_train_app.triggerevent("ue_draw_box")
// save
elseif dwo.name = "b_save" then
	//of_savedata()
	w_train_app.triggerevent("ue_save_mapping")  //Start Code Change ----02.25.2013 #V12 maha

//scan
elseif dwo.name = "b_scan" then
	of_scan()


elseif dwo.name = "b_append" then
	//of_blank_page( )
	of_insert_pages( )  //Start Code Change ----02.25.2013 #V12 maha


elseif dwo.name = "b_delete_p" then
	of_delete_pages( )


elseif dwo.name = "b_straight" then
	of_straighten_page( )


elseif dwo.name = "b_prop" then
	of_page_properties( )


elseif dwo.name = "b_copy_p" then
//	of_copy( )
	w_train_app.triggerevent("pfc_blank_page")  //Start Code Change ----02.25.2013 #V12 maha - corrected


elseif dwo.name = "b_copy_f" then
	//of_copy_fields( )
	w_train_app.triggerevent("ue_copyfields")  //Start Code Change ----02.25.2013 #V12 maha - corrected

//templates
elseif dwo.name = "b_temp" then
	w_train_app.triggerevent("ue_open_template")

//highlighter
elseif dwo.name = "b_high" then
	of_add_hollow_box()

//query filters
elseif dwo.name = "b_filters" then
	//of_query_batch_update( )
	w_train_app.triggerevent("pfc_query_batch")  //Start Code Change ----02.11.2013 #V12 maha - corrected
//test app
elseif dwo.name = "b_test" then
	of_test_application( )

//special fields
elseif dwo.name = "b_special" then
	of_special_fields( )

//remove object
elseif dwo.name = "b_remove" then
	//of_remove_object( )
	w_train_app.triggerevent("ue_remove_object")

//prio page
elseif dwo.name = "b_prior" then
	of_prior_page( )

//next page
elseif dwo.name = "b_next" then
	of_next_page( )

//goto page
elseif dwo.name = "b_goto" then
	this.accepttext()
	ls_page = this.getitemstring(1,"page")
	if isnumber(ls_page) then
		of_goto_page(integer(ls_page))
	else
		of_goto_page(0)
	end if
	this.setitem(1,"page","")
end if

	
end event

event itemchanged;long ll_handle

if dwo.name = 'align' then
	if data = "1" then
		If appeongetclienttype() <> 'PB' Then
			ll_handle = handle(w_mdi)
			gnv_appeondll.of_SetToolbar( ll_handle , 4, True )  
			gnv_appeondll.of_settoolbarpos(ll_handle)
		End If
		w_train_app.triggerevent( "pfc_align" )
	end if
elseif dwo.name = 'connect' then
	if data = "1" then
		of_setup_connect_field( )
	end if
end if
end event

type cb_fast from commandbutton within tabpage_design
integer x = 3877
integer y = 1876
integer width = 256
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fast View"
end type

event clicked;long ll_app_field_id

if tab_1.tabpage_design.dw_fld_prop.GetRow() < 1 then Return
ll_app_field_id = tab_1.tabpage_design.dw_fld_prop.GetItemNumber(1, "app_field_id")

openwithparm(w_app_prop_view, ll_app_field_id) //evan 10.27.2011
end event

type ole_edit from olecustomcontrol within tabpage_design
event keydown ( ref long keycode,  long shift )
event keyup ( ref long keycode,  long shift )
event keypress ( ref long keyascii )
event mousedown ( long button,  long shift,  long ocx_x,  long ocx_y )
event mousemove ( long button,  long shift,  long ocx_x,  long ocx_y )
event mouseup ( long button,  long shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( long number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  long marktype,  string groupname )
event toolselected ( long toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( long index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( long button,  long shift,  long left,  long top,  long ocx_width,  long ocx_height,  long marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( long marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  long status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  ref boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( long hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( ref long mode )
event baddocumentfiletype ( long page,  ref boolean errorout,  ref boolean skippage,  ref boolean overwritepage )
event readystatechange ( long readystate )
event key_dowm pbm_keydown
event key_up pbm_keyup
integer x = 914
integer y = 196
integer width = 3488
integer height = 1500
integer taborder = 40
boolean bringtotop = true
string binarykey = "w_train_app.win"
integer binaryindex = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click();//takes place after markselect
IF ib_pause_temp  = True THEN
	Return
END IF
//messagebox("","click")
IF ii_align = 1 THEN//OR ii_copy_fields = 1  THEN
	Return
END IF

IF ib_click_position THEN
	IF ib_new_field_selection THEN
		//jad 7/30  
		ii_ancor_x = UnitsToPixels (This.PointerX ( ), XUnitsToPixels! ) + 1//+ This.Object.ScrollPositionX()
		//IF ii_ancor_x = 0 THEN
		//	GOTO leave
		//END IF
		ii_ancor_y = UnitsToPixels (This.PointerY ( ), YUnitsToPixels! ) -6//+ This.Object.ScrollPositionY() -3		
		cb_apply.TriggerEvent( Clicked! )		
		cb_apply.Visible = True
		st_msg.Visible = False
	ELSE
		ii_ancor_x = UnitsToPixels (This.PointerX ( ), XUnitsToPixels! ) + This.Object.ScrollPositionX()
		ii_ancor_y = UnitsToPixels (This.PointerY ( ), YUnitsToPixels! ) + This.Object.ScrollPositionY() -3
		ii_copy_ancor_x = UnitsToPixels (This.PointerX ( ), XUnitsToPixels! ) + This.Object.ScrollPositionX()
		ii_copy_ancor_y = UnitsToPixels (This.PointerY ( ), YUnitsToPixels! ) + This.Object.ScrollPositionY() -12		
	END IF
	ib_click_position = False
	IF ib_placing_template = True THEN
		//ib_placing_template = False	
		//w_section_templates.of_place_template()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 08.16.2006 By: LeiWei
		//$<reason> Fix a defect.
		//w_section_templates.of_place_template1() //Delete by Evan 04.03.2009 --- New feature for App Mapping Addition Filters
		w_templates_v9.of_place_template1() //Add by Evan 04.03.2009 --- New feature for App Mapping Addition Filters
		//---------------------------- APPEON END ----------------------------
	END IF	
	Return
ELSEIF ib_label_tool THEN
	
END IF

//leave:
end event

event selectionrectdrawn(long left, long top, long ocx_width, long ocx_height);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-15 By: Liu Hongxin
//$<reason> After this, can do copy and cut.
if (ocx_width + ocx_height = 0) then
	is_IsRectangle = False
else
	is_IsRectangle = True
end if
//---------------------------- APPEON END ----------------------------
//Long ll_app_field_id
//Long ll_x_end
//Long ll_y_end
//
//IF ii_copy_fields = 1 THEN
//
//	ll_x_end = left + ocx_width
//	ll_y_end = top + ocx_height
//
//   debugbreak()
//
//   DECLARE c_app_field_id CURSOR FOR  
//   SELECT app_field_prop.app_field_id  
//   FROM app_field_prop  
//   WHERE ( app_field_prop.app_id = :ii_app_id ) AND
//        ( app_field_prop.page = :ii_current_page ) AND
//  	     ( app_field_prop.x_pos >= :left AND app_field_prop.x_pos <= :ll_x_end ) AND
//        ( app_field_prop.y_pos >= :top  AND app_field_prop.y_pos <= :ll_y_end )   ;
//			
//	OPEN c_app_field_id;  
//
//   FETCH c_app_field_id INTO :ll_app_field_id;
//  
//   DO WHILE SQLCA.SQLCODE = 0
//	   ii_ancor_count++	
//	   ole_edit.Object.SelectAnnotationGroup( ll_app_field_id )	  	  	  
//		messagebox("", ll_app_field_id )
//	   FETCH c_app_field_id INTO :ll_app_field_id;
//   LOOP
//
//END IF
end event

event markselect(long button, long shift, long left, long top, long ocx_width, long ocx_height, long marktype, string groupname);//ib_saved = False

String ls_field_description
string ls_test_group //Start Code Change ---- 05.30.2006 #489 maha
long li_field_id
Long li_x
Long li_y

if gi_test_mode = 1 then
	messagebox("markselect (test mode)", "markselect event" )
end if

ib_rectangle_selected = False

IF ib_loading_annotations = True THEN
	Return
END IF
if ib_moving_field then Return //Add by Evan on 05.06.2011


IF marktype = 4 THEN
	is_label_id = groupname
	li_field_id = Long( MidA( groupname, 11, 100) )
	ii_app_field_id = li_field_id
	li_x = left + This.Object.ScrollPositionX()
	li_y = top +  This.Object.ScrollPositionY()
	of_update_field( groupname, li_x, li_y, ocx_width, ocx_height )
	ib_rectangle_selected = True
	Return 
END IF

li_x = left + This.Object.ScrollPositionX()

li_y = top + This.Object.ScrollPositionY()

ib_label_selected = False

IF ii_align = 1 OR ii_copy_fields = 1 OR ii_connect_fields = 1 THEN
	//Start Code Change ---- 05.30.2006 #489 maha
	ls_test_group = groupname
	//if of_dupe_field_test(ls_test_group) = 0 then
	if of_dupe_field_test(ls_test_group) = 0 and Len(ls_test_group) > 0 then   //Modified by (Appeon)Harry 08.04.2016 for Bug ID #5273
		ii_ancor_count ++
		is_selected_fields[ ii_ancor_count] = ls_test_group	
		//MESSAGEBOX("", is_selected_fields[ ii_ancor_count]  )
		ii_x[ii_ancor_count] = left + This.Object.ScrollPositionX()
		ii_y[ii_ancor_count] = top + This.Object.ScrollPositionY()
		ii_height[ ii_ancor_count ] = ocx_height
	end if
	//End Code Change---05.30.2006
END IF
//MESSAGEBOX("", ii_ancor_count )

IF ib_fix_fields THEN
	ii_ancor_x = left
	ii_ancor_y = top	
END IF

IF ii_ancor_count = 1 OR ii_copy_fields = 1 OR ii_connect_fields = 1 THEN
	ii_ancor_x = left
	ii_ancor_y = top
	ii_copy_ancor_x = left
	ii_copy_ancor_y = top	
END IF

IF Upper(RightA( groupname, 6 )) = "YESBOX" THEN
	ii_app_field_id = long( MidA( groupname, 1, LenA( groupname ) - 6) )
ELSEIF Upper(RightA( groupname, 5 )) = "NOBOX" THEN
	ii_app_field_id = long( MidA( groupname, 1, LenA( groupname ) - 5) )	
ELSEIF Upper(LeftA( groupname, 9 )) = "RECTANGLE" THEN
	is_label_id = LeftA( groupname, 9 )	
	ib_rectangle_selected = True
	ii_app_field_id = long( MidA( groupname, 11, 100 ))		
	UPDATE app_field_prop
   SET x_pos = :li_x,   
       y_pos = :li_y,
		 box_width = :ocx_width,
		 box_height = :ocx_height
	WHERE app_field_id = :ii_app_field_id
	USING tr_training_data;
	Return 		
ELSEIF Upper(LeftA( groupname, 15 )) = "HOLLOWRECTANGLE" THEN
	ib_rectangle_selected = True	
	ii_app_field_id = long( MidA( groupname, 17, 100 ))			
	is_label_id = LeftA( groupname, 15 )
	UPDATE app_field_prop
   SET x_pos = :li_x,   
       y_pos = :li_y,
		 box_width = :ocx_width,
		 box_height = :ocx_height
	WHERE app_field_id = :ii_app_field_id
	USING tr_training_data;
	Return 		
ELSEIF Upper(RightA( groupname, 5 )) = "CHECK" THEN
	ii_app_field_id = long( MidA( groupname, 1, LenA( groupname ) - 5) )		
ELSEIF Upper( MidA( groupname, 1, 6 )) = "LABEL-" THEN
   ib_label_selected = True
	is_label_id = groupname
	ii_app_field_id = long( MidA( groupname, PosA( groupname, ";" ) + 1, 100 ) )
	UPDATE app_field_prop
     SET x_pos = :li_x,   
          y_pos = :li_y
	WHERE app_field_id = :ii_app_field_id
	USING tr_training_data;	
	Return 	
ELSEIF Upper( MidA( groupname, 1, 3 )) = "SP-" THEN
   ib_label_selected = True
	is_label_id = groupname
	ii_app_field_id = long( MidA( groupname, PosA( groupname, "," ) + 1, 100 ) )
	UPDATE app_field_prop
     SET x_pos = :li_x,   
         y_pos = :li_y
	WHERE app_field_id = :ii_app_field_id
	USING tr_training_data;
	Return 	
ELSEIF Upper( MidA( groupname, 1, 3 )) = "BOX" THEN
   ib_label_selected = True
	is_label_id = groupname
	Return 	
ELSE
	ii_app_field_id = long( groupname )
END IF

IF ii_copy_fields = 1 THEN
	IF ii_app_field_id > 0 THEN
		ii_app_field_ids[ ii_ancor_count ] = ii_app_field_id
		//messagebox("", ii_app_field_id )
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-31
//$<modify> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT app_field_prop.field_description  
INTO :ls_field_description  
FROM app_field_prop  
WHERE app_field_prop.app_field_id = :ii_app_field_id 
USING tr_training_data;
*/
If tab_1.tabpage_design.dw_fld_prop.rowcount() > 0 Then
	ls_field_description = tab_1.tabpage_design.dw_fld_prop.GetItemString( 1, "field_description" )
End If
//---------------------------- APPEON END ----------------------------

IF ii_align <> 1 AND ii_copy_fields <> 1 AND ii_connect_fields <> 1 THEN
	ii_ancor_x = left
	ii_ancor_y = top 
END IF

IF IsNull( ls_field_description ) OR ls_field_description = "" THEN
ELSE
	tab_1.tabpage_design.st_field.Text = ls_field_description
END IF

IF shift <> 0 THEN
	Return
END IF
IF IsNull( groupname ) OR groupname = "" THEN
	Return
END IF

of_update_field( groupname, left, top,ocx_width, ocx_height )
tab_1.tabpage_design.dw_quick_filters.Event ue_RetrieveDddw() //evan 12.16.2010

//tab_fld_prop.SelectTab( 1 )

This.SetFocus()

ib_saved = False
end event

event key_dowm;//////////////////////////////////////////////////////////////////////
// $<event>ole_edit.key_dowm()
// $<arguments>
//		value	keycode     	key     		
//		value	unsignedlong	keyflags		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.13.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
Long li_x_pos
Long li_y_pos

SetPointer( Arrow! )

ib_contol_key_down = False
tab_1.tabpage_design.ole_edit.Object.scrollbars = false

if tab_1.selectedtab = 3 then //maha changed 11-28-00 to allow enter key on other tabs  
	IF tab_1.tabpage_design.dw_fld_prop.RowCount() = 1 AND +&
		( key = KeyDownArrow! OR key = KeyUpArrow! OR key =  KeyLeftArrow! OR key = KeyRightArrow! ) AND +&
		ib_label_selected = False THEN
		//This.tab_1.tabpage_design.ole_edit.SetRedraw( False )	//avoiding screen blinks on web application
		li_x_pos = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "x_pos" )
		li_y_pos = tab_1.tabpage_design.dw_fld_prop.GetItemNumber( 1, "y_pos" )
		IF KeyDown( KeyControl! ) AND KeyDown( KeyRightArrow! ) THEN 
			of_auto_align()
			//This.tab_1.tabpage_design.ole_edit.SetRedraw( True )			//avoiding screen blinks on web application
			tab_1.tabpage_design.ole_edit.Object.scrollbars = True
			Return
		ELSEIF key = KeyDownArrow! THEN
			ib_moving_field = True
			li_y_pos = li_y_pos + 1 - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()
			li_x_pos = li_x_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()
		ELSEIF key = KeyUpArrow! THEN
			ib_moving_field = True
			li_y_pos = li_y_pos - 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositiony()
			li_x_pos = li_x_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()	
		ELSEIF key = KeyLeftArrow! THEN
			ib_moving_field = True //Add by Evan on 05.06.2011
			li_x_pos = li_x_pos - 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()
			li_y_pos = li_y_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()	
		ELSEIF key = KeyRightArrow! THEN
			ib_moving_field = True //Add by Evan on 05.06.2011
			li_x_pos = li_x_pos + 1	- tab_1.tabpage_design.ole_edit.Object.ScrollPositionX()	
			li_y_pos = li_y_pos - tab_1.tabpage_design.ole_edit.Object.ScrollPositionY()	
		END IF
	
		ii_ancor_x = li_x_pos
		ii_ancor_y = li_y_pos
	
		IF key = KeyDownArrow! OR key = KeyUpArrow! THEN
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "y_pos", ii_ancor_y + tab_1.tabpage_design.ole_edit.Object.ScrollPositionY())//Modify by Evan on 05.06.2011
		ELSEIF key = KeyLeftArrow! OR key = KeyRightArrow! THEN
			tab_1.tabpage_design.dw_fld_prop.SetItem( 1, "x_pos", ii_ancor_x + tab_1.tabpage_design.ole_edit.Object.ScrollPositionX())//Modify by Evan on 05.06.2011
		END IF
	
		tab_1.tabpage_design.cb_apply.TriggerEvent( Clicked! )
		ib_moving_field = False
		//This.tab_1.tabpage_design.ole_edit.SetRedraw( True )	//avoiding screen blinks on web application
	ELSEIF ib_label_selected THEN
		MessageBox("Invalid", "Only the mouse can be used to adjust objects that are not fields.")
	END IF
	
	IF KeyDown( KeyControl! ) THEN
		ib_contol_key_down = True
		//title = "key control"  //Delete by Stephen 05.17.2011 --- Fixed a bug for title bar and the window menu error.
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 08.14.2006 By: LeiWei
	//$<reason> Fix a defect.
	IF KeyDown( KeyDelete! ) THEN
		of_remove_object( )
	END IF
	tab_1.tabpage_design.ole_edit.Object.scrollbars = True
	//---------------------------- APPEON END ----------------------------
end if
end event

event dragdrop;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<modify> 01.13.2006 By: Ye KaiChun
//$<reason> In w_train_app, an OLE control ole_eidt is used as the target control 
//$<reason> to carry the objects dragged from other control/object.  However, after analysis, 
//$<reason> Appeon did not find any object that can be dragged and dropped to ole_edit.
//$<modification> Comment out the following script.
//integer i
////dw_field.triggerevent(doubleclicked!)
//i = of_dw_field_dclick() //maha 042004
//
//if i > 0 then
//	This.TriggerEvent( "Click" )
//end if

il_AnnoPosX = UnitsToPixels (This.PointerX ( ), XUnitsToPixels! ) + 1 //evan 12.16.2010
il_AnnoPosY = UnitsToPixels (This.PointerY ( ), YUnitsToPixels! ) - 6 //evan 12.16.2010

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 11.02.2010
//$<reason> V10.5-App Mapping
/*
if appeongetclienttype() = 'PB' then	
	integer i
	//dw_field.triggerevent(doubleclicked!)
	i = of_dw_field_dclick() //maha 042004
	
	if i > 0 then
		This.TriggerEvent( "Click" )
	end if
end if
*/
if AppeonGetClientType() = "PB" then
	if Source.ClassName() = "dw_detail" then
		ib_IsDragAnnotation = true //evan 12.16.2010
		of_AddFieldFromSP()
		ib_IsDragAnnotation = false //evan 12.16.2010
	else	
		if of_dw_field_dclick() > 0 then
			this.TriggerEvent("Click")
		end if
	end if
end if
//------------------- APPEON END ---------------------

//---------------------------- APPEON END ----------------------------
end event

type uo_sitefield_map from pfc_cst_u_sitefield_mapping within tabpage_design
boolean visible = false
integer x = 919
integer y = 200
integer width = 3470
integer taborder = 20
boolean bringtotop = true
end type

on uo_sitefield_map.destroy
call pfc_cst_u_sitefield_mapping::destroy
end on

type dw_preview_buttons from datawindow within tabpage_design
integer width = 4443
integer height = 120
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_app_preview_buttons"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;//Start Code Change ----2.22.2016 #V15 maha - menuit ot button migration
long ll_handle
string ls_page
string ls_prior_enable
string ls_next_enable

//Select Provider
if dwo.name = "b_select" then
	w_train_app.triggerevent( "pfc_prac_search" )
//add edit
elseif dwo.name = "b_add" then
	w_train_app.triggerevent("ue_preview_create_text")
//Delete	
elseif dwo.name = "b_delete" then
	w_train_app.triggerevent("ue_preview_remove_object")
//prio page
elseif dwo.name = "b_prior" then
	w_train_app.triggerevent( "pfc_prior_preview_page" )

//next page
elseif dwo.name = "b_next" then
	w_train_app.triggerevent( "pfc_next_preview_page" )

//print
elseif dwo.name = "b_print" then
	w_train_app.triggerevent( "pfc_print_preview_app" )
end if

//---------Begin Added by (Appeon)Stephen 05.13.2016 for Bug id 5154 - Application Mapping Prior and Next buttons--------
if m_pfe_train_app_preview.m_view.m_nextpage.enabled = true then
	ls_next_enable = 'yes'
else
	ls_next_enable = 'no'
end if
if m_pfe_train_app_preview.m_view.m_priorpage.enabled  = true then
	ls_prior_enable = 'yes'
else
	ls_prior_enable = 'no'
end if

this.modify("b_prior.enabled='"+ls_prior_enable+"'")
this.modify("b_next.enabled='"+ls_next_enable+"'")
//---------End Added ------------------------------------------------------

end event

event constructor;this.insertrow(1)
this.object.datawindow.color = gl_button_bar_color  //Start Code Change ----02.22.2016 #V15 maha
end event

type uo_preview from pfc_cst_u_create_app2 within tabpage_design
event ue_resize pbm_size
event ue_doresize ( )
boolean visible = false
integer y = 120
integer width = 4439
integer height = 2028
integer taborder = 20
boolean border = false
long backcolor = 80269524
end type

event ue_resize;//////////////////////////////////////////////////////////////////////
// $<event> ue_resize
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

this.Event ue_DoResize()
end event

event ue_doresize();//////////////////////////////////////////////////////////////////////
// $<event> ue_doresize
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.28.2010
//////////////////////////////////////////////////////////////////////

ole_edit.width = this.width - 20
ole_edit.height = this.height - 70
st_name.width = this.width - st_name.x - 20
end event

on uo_preview.destroy
call pfc_cst_u_create_app2::destroy
end on

event constructor;call super::constructor;this.Event ue_DoResize()
this.BackColor = parent.BackColor
end event

type tabpage_merge from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 100
integer width = 4681
integer height = 2172
boolean enabled = false
long backcolor = 33551856
string text = "Preview "
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
uo_create_app11 uo_create_app11
end type

on tabpage_merge.create
this.uo_create_app11=create uo_create_app11
this.Control[]={this.uo_create_app11}
end on

on tabpage_merge.destroy
destroy(this.uo_create_app11)
end on

type uo_create_app11 from pfc_cst_u_create_app2 within tabpage_merge
integer y = 128
integer width = 3602
integer height = 1796
integer taborder = 10
boolean border = false
long backcolor = 80269524
end type

on uo_create_app11.destroy
call pfc_cst_u_create_app2::destroy
end on

type st_align from statictext within w_train_app
boolean visible = false
integer x = 1230
integer y = 16
integer width = 2094
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "Select each field you want to align then click the appropriate align icon."
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Bw_train_app.bin 
2400000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000006495adc001d3075200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000013d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b1113000000006495adc001d307526495adc001d30752000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000480000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002010684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b000000300000010d0000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000007400000000000000880000000300010000000000030000034f000000030000034f00000003000000000000001e0000000945676d4931746964000000000000001e0000000b53206f4e6e6e61630000726500000007000000000000000100010500000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f697300000000000100000000034f0000034f00000000676d490874696445000100310001000000007fff00000001000100000003000100000008000000000142c800206f4e0a6e6163530072656e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000006495adc001d3075200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000013e00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003e1a6b8a0101c360302046eac029c0024000000006495adc001d307526495adc001d30752000000000000000000000000006f00430074006e006e006500730074
2300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000005000000460000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106e1a6b8a0101c360302046eac029c002400000001fb8f0821101b01640008ed8413c72e2b000000300000010e000000080000010000000048000001010000005000000102000000580000010300000060000001040000006800000105000000700000010600000078000000000000008000000003000200020000000300000a56000000030000052b00000003000000610000000300c0c0c0000000020000000100000003000000780000000800000000000000010001030000000c0074735f00706b636f73706f720001050000000c00726f620073726564656c79740001040000000a00636162006c6f636b0600726f0c00000174000000626d75686769656801007468090000015f000000657478650078746e00000102000000097478655f79746e65000100000000090065765f006f6973720000006e0002000200000a560000052b0000006100c0c0c0c00100018000c0c00100808000005500000078000000000000010000ff0001010000000000000000ff000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000006495adc001d3075200000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000006495adc001d307526495adc001d30752000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000003840000038400000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000006495adc001d3075200000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000006495adc001d307526495adc001d30752000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300004edc00000003000026c2000000030000006000000002000000010000001e0000000945676d493274696400000000
2A000000031b57dfff0000000b0000ffff000000020000bb30000000020000bb300000000357c2a7e40000000357c2a7e40000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500004edc000026c20000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000ff000000001b57df0000000060000100bc300000ffffbc30ffffffff0000ffff0000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Bw_train_app.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
