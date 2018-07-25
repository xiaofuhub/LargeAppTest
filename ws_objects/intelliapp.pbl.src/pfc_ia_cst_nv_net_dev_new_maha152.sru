$PBExportHeader$pfc_ia_cst_nv_net_dev_new_maha152.sru
forward
global type pfc_ia_cst_nv_net_dev_new_maha152 from pfc_cst_nv_net_dev_prac_folder
end type
type dw_appoint_stat from u_dw within tabpage_ai
end type
type dw_tracking from u_dw within tabpage_ai
end type
type gb_filter_2 from groupbox within tabpage_report
end type
type cb_2 from commandbutton within tabpage_report
end type
type tabpage_ar from userobject within tab_1
end type
type dw_ar from u_dw within tabpage_ar
end type
type tabpage_ar from userobject within tab_1
dw_ar dw_ar
end type
type gb_filter_1 from groupbox within pfc_ia_cst_nv_net_dev_new_maha152
end type
type cb_ma from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
end type
type dw_payors from u_dw within pfc_ia_cst_nv_net_dev_new_maha152
end type
type st_as_msg from statictext within pfc_ia_cst_nv_net_dev_new_maha152
end type
type dw_facility_add from u_dw within pfc_ia_cst_nv_net_dev_new_maha152
end type
type cb_batch from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
end type
type p_1 from picture within pfc_ia_cst_nv_net_dev_new_maha152
end type
type cbx_compl from checkbox within pfc_ia_cst_nv_net_dev_new_maha152
end type
type cb_change from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
end type
type st_filter from statictext within pfc_ia_cst_nv_net_dev_new_maha152
end type
type dw_qf from datawindow within pfc_ia_cst_nv_net_dev_new_maha152
end type
type st_group_by from statictext within pfc_ia_cst_nv_net_dev_new_maha152
end type
type ddlb_group_by from dropdownlistbox within pfc_ia_cst_nv_net_dev_new_maha152
end type
type st_zoom from statictext within pfc_ia_cst_nv_net_dev_new_maha152
end type
type ddlb_zoom from dropdownlistbox within pfc_ia_cst_nv_net_dev_new_maha152
end type
type cb_3 from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
end type
end forward

global type pfc_ia_cst_nv_net_dev_new_maha152 from pfc_cst_nv_net_dev_prac_folder
integer width = 4512
integer height = 2008
boolean border = false
long backcolor = 33551856
event pfc_cst_reappoint ( )
event pfc_cst_manual_workflow ( )
event ue_filter_from_grid ( integer al_type )
gb_filter_1 gb_filter_1
cb_ma cb_ma
dw_payors dw_payors
st_as_msg st_as_msg
dw_facility_add dw_facility_add
cb_batch cb_batch
p_1 p_1
cbx_compl cbx_compl
cb_change cb_change
st_filter st_filter
dw_qf dw_qf
st_group_by st_group_by
ddlb_group_by ddlb_group_by
st_zoom st_zoom
ddlb_zoom ddlb_zoom
cb_3 cb_3
end type
global pfc_ia_cst_nv_net_dev_new_maha152 pfc_ia_cst_nv_net_dev_new_maha152

type variables
Boolean ib_payors_just_retrieved = True
Boolean ib_save = False
boolean ib_show_ids_addr = false  //maha 06.12.2013

Boolean ib_done_retrieving_orgs = False
Boolean ib_report_filter = false

string is_assn_user
string is_tree_level //maha 08.18.2015

pfc_cst_nv_data_entry_functions inv_data_entry //maha 011706

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.16.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Define DataStores to be used in subsequent script.
datastore ids_spec_link
datastore ids_all_spec
datastore ids_address_link
datastore ids_all_addresses
datastore ids_hosp_link
datastore ids_all_hosp
datastore ids_cred_comms
datastore ids_cred_committees
datastore ids_address_linked
//w_action_items iw_action_items
w_sheet iw_action_items //Modified to w_sheet by Appeon long.zhang 11.13.2014
//---------------------------- APPEON END ----------------------------
w_action_items iw_actions  //maha 08.10.2015

long il_flag =1 //add Michael 11.08.2011
long il_track_id  //maha 09.04.2015
end variables

forward prototypes
public function integer of_multi_add ()
public function integer of_reappoint ()
public function integer of_filter_ids ()
public function integer of_save ()
public function integer of_set_quick_filter (string as_filter_syntax)
public function long of_get_id_count (n_ds ads_cache, integer ai_facility_ids[])
public subroutine of_add_data_links (long al_prac_id, integer ai_facility_id, integer al_rec_id)
public function integer of_refresh_data ()
public function long of_down_image (long al_rec_id, long al_prac_id, long al_app_id, string as_picname)
public function integer of_report_selected_ver9 (string as_report)
public function integer of_par_report_filter ()
public function integer of_set_security_nd ()
public function integer of_bg_color (long al_rgb)
public function integer of_open_tracking ()
public function integer of_retrieve_detail ()
public function integer of_retrieve_tracking ()
public function integer of_change_facility ()
public function integer of_set_par_status ()
public function integer of_refresh_dddw ()
public function integer of_imp_appfile (integer al_row, datawindow adw_net_dev, string as_type)
public function integer of_email_payor_complete (u_dw adw_net_dev, long al_row)
public function integer of_email_payor (u_dw adw_net_dev, string as_type)
public function integer of_send_email_payor (integer ai_export_id, long al_prac_id, string as_email, string as_emailcc, string as_notetext, string as_filename, string as_subject, blob ab_attach)
public function integer of_email_errors (string as_errors[])
public function integer of_create_checklist (long al_temp, string as_app_type, long al_appt_stat_id, long al_parent)
public function integer of_out_to_md_ai (integer ai_facility_id, long ai_app_id, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type, boolean ab_complete)
public subroutine of_resize_manual ()
public function integer of_hide_fields ()
public function string of_down_notes (long al_rec_id)
public function integer of_hide_tracking_fields ()
public function integer of_set_tree_level (string as_level)
public function integer of_goto_app (long al_fac, long al_loc, integer al_app)
public function integer of_check_tracking_id ()
public function long of_retrieve_detail_retry ()
public function integer of_filter_from_grid (long al_type)
public function integer of_post_resize ()
public function integer of_app_view_load (long al_row, datawindow adw_net_dev, long al_type, string as_file)
end prototypes

event pfc_cst_reappoint;of_reappoint()
end event

event pfc_cst_manual_workflow();//Added for work flow trigger. 14/11/2006 Henry
String ls_rtn

str_manual_wf lstr_workflow

lstr_workflow.is_module = '02'

lstr_workflow.il_prac_id =  il_prac_id

lstr_workflow.il_facility_id = ii_facility_id

OpenWithParm(w_manual_workflow_list , lstr_workflow)

ls_rtn = Message.stringparm

If ls_rtn = 'OK' then of_retrieve_facilities()
end event

event ue_filter_from_grid(integer al_type); //Start Code Change ----01.04.2016 #V15 maha - corrected to work
string ls_filter
integer i
long li_act


dw_orgs_facilities.CollapseAll()
dw_orgs_facilities.selecttreenode( 1, 1, true)

li_act = message.doubleparm

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 05.05.2016
//<$>reason:Bug id 5133 - Expression is not Valid error SaaS build 05042016
//ls_filter = "net_dev_action_items.action_type = " + string(li_act)  + " and net_dev_action_items.action_status = 90742" 
ls_filter = "action_type = " + string(li_act)  + " and action_status = 90742" 
//------------------- APPEON END -------------------

i = tab_1.tabpage_ai.dw_net_dev.setfilter(ls_filter)
tab_1.tabpage_ai.dw_net_dev.filter()


end event

public function integer of_multi_add ();//Start Code Change ----10.02.2014 #V14.2 maha - new function where data creation is on the Multi-App screen

openwithparm(w_multi_app_select, il_prac_id ) 

IF Message.StringParm = "Cancel" THEN
	Return 0
ELSE
	of_refresh_data()

END IF


Return 1



//Long z
//Long li_rc
//Long li_fac_cnt = 0
//Long f
//Long li_user //maha 04.03.2012
//Long li_facility_id
//Long li_facility_cnt
//Long li_address_cnt
//Long li_cnt
//Long i
//Long li_facility_ids[]
//Long li_ver_facility //maha 011706
//Long li_app_audit_facility //maha 011706
//Long ll_rec_id
//long ll_pracids[]
//string ls_action_type			
//Long ll_action_status
//Long ll_action_dept
//long	ll_recid_app  //Start Code Change ----04.16.2008 #V8 maha - changed from inappropriate integer to long also changed variable name and all code refering to it
//Long ll_loc_id //maha 05.05.2014
//long ll_template //maha 05.05.2014
//long ll_locations[] //maha 05.05.2014
//long ll_maid[] //maha 07.02.2014
//long ll_find , ll_id_count
//String ls_app_id
//String ls_app_type
//String ls_action_notes
////string ls_assn_user //maha 04.03.2012 - removed 06.18.2014 maha
//DateTime ldt_action_date
//Boolean lb_facility_created
//boolean lb_create_address  //maha 05.05.2014
//boolean lb_complete  //maha 07.02.2014
//gs_pass_ids lstr_ids
//datastore lds_facility
//datastore lds_template  //maha 05.05.2014
//n_ds lds_facility_cnt
//
////Start Code Change ----05.05.2014 #V14.2 maha
////Open( w_select_payor )
//open(w_multi_app_select)  
//
//
//IF Message.StringParm = "Cancel" THEN
//	Return 0
//ELSE
//	lstr_ids = Message.PowerObjectParm
//END IF
//
//li_cnt = UpperBound( lstr_ids.i_facility_ids )
//ll_template = lstr_ids.ll_verification_id //05.05.2014 maha
//ls_action_type = lstr_ids.s_action_type[1]  //05.06.2014 maha
//lb_create_address = lstr_ids.ls_image_available
//is_assn_user = lstr_ids.s_stringval
//
//dw_facility_add.reset()  //Start Code Change ----07.13.2012 #V12 maha - moved from inside add loop
//li_facility_cnt = -9
////Add Appeon start queue label
//gnv_appeondb.of_startqueue()
//
//ids_address_link = CREATE datastore
//ids_address_link.DataObject = "d_address_link_prac"
//ids_address_link.settransobject( SQLCA)
//
//
//lds_template = CREATE datastore
//lds_template.DataObject = "d_multi_app_list"
//lds_template.settransobject( SQLCA)
//lds_template.retrieve(ll_template)
////End Code Change ----05.05.2014
//
//ids_all_addresses = CREATE datastore
//ids_all_addresses.DataObject = "d_address_link_all_addresses"
//ids_all_addresses.settransobject( SQLCA)
//ids_all_addresses.retrieve( il_prac_id )
//
//
//ids_address_linked = CREATE datastore
//ids_address_linked.DataObject = "d_pd_address_link_all_pt"
//ids_address_linked.settransobject( SQLCA)
//ids_address_linked.retrieve( il_prac_id , lstr_ids.i_facility_ids[])
//
//
//ids_hosp_link = CREATE datastore
//ids_hosp_link.DataObject = "d_hf_link"
//ids_hosp_link.SetTransObject( SQLCA )
//ids_hosp_link.Retrieve( il_prac_id )
//
//ids_all_hosp = CREATE datastore
//ids_all_hosp.DataObject = "d_hosp_affil_prac"
//ids_all_hosp.SetTransObject( SQLCA )
//ids_all_hosp.Retrieve( il_prac_id )
//
//ids_spec_link = CREATE datastore
//ids_spec_link.DataObject = "d_sf_link"
//ids_spec_link.SetTransObject( SQLCA )
//ids_spec_link.Retrieve( il_prac_id )
//
//ids_all_spec = CREATE datastore
//ids_all_spec.DataObject = "d_spec_of_prac"
//ids_all_spec.SetTransObject( SQLCA )
//
//
//lds_facility_cnt = create n_ds
//lds_facility_cnt.dataobject= "d_pd_affil_stat_parent_facility_id_cnt"
//lds_facility_cnt.settransobject(SQLCA)
//li_facility_cnt = lds_facility_cnt.retrieve(il_prac_id , lstr_ids.i_facility_ids[])
////
//lds_facility = create datastore
//lds_facility.dataobject = 'd_facility_id_list'
//lds_facility.settransobject(SQLCA)
//lds_facility.retrieve(lstr_ids.i_facility_ids[])
////
//ids_cred_comms = create datastore
//ids_cred_comms.dataobject = 'd_dddw_credentialing_committees_all_pt'
//ids_cred_comms.settransobject(sqlca)
//ids_cred_comms.retrieve(lstr_ids.i_facility_ids[])
//
//ids_cred_committees = create datastore
//ids_cred_committees.dataobject = 'd_pd_comm_review'
//ids_cred_committees.settransobject(sqlca)
//
//gnv_appeondb.of_commitqueue()
//
//ll_id_count = of_get_id_count(lds_facility_cnt , lstr_ids.i_facility_ids[])
//If ll_id_count > 0 Then ll_rec_id = gnv_app.of_Get_Id("RECORD_ID" , ll_id_count) - 1
//ll_recid_app = gnv_app.of_Get_Id("RECORD_ID" , (li_cnt + li_cnt * upperbound(lstr_ids.s_action_type))) - 1
//
//gnv_appeondb.of_startqueue()
//
//debugbreak()
//dw_facility_add.settransobject(sqlca)
//li_cnt = lds_template.rowcount()
//
//FOR i = 1 TO upperbound(lstr_ids.s_ids[ ])
////FOR i = 1 TO li_cnt
//	li_facility_id = lstr_ids.i_facility_ids[ i ]
//	ls_app_id = lstr_ids.s_ids[ i ]
//	//Start Code Change ----05.06.2014 #V14.2 maha
//	ll_loc_id = lstr_ids.l_loc_ids[ i ]
//	z = 0
//	//for addresses get unique locations
//	if lb_create_address then
//		if ll_loc_id > 0 then
//			for f = 1 to upperbound(ll_locations[])
//				if ll_loc_id = ll_locations[f] then
//					z = 1
//					exit
//				end if
//			next
//			if z = 0 then ll_locations[upperbound(ll_locations) + 1] = ll_loc_id
//		end if
//		ll_pracids[1] = il_prac_id
//	end if
//	//Start Code Change ----05.06.2014
//	debugbreak()
////	li_facility_id = lds_template.getitemnumber(i, "parent_facility_id")
////	ls_app_id = string(lds_template.getitemnumber(i, "app_id"))
////	ll_loc_id = lds_template.getitemnumber(i, "gp_id")
//	//Start Code Change ---05.05.2014 #V14.2 maha - change from passed variables to template values
//	IF gs_cust_type = "I" THEN
//		li_app_audit_facility = 1   
//		li_ver_facility = 1
//		ls_app_type = "I"
//	ELSE   //Start Code Change ----05.19.2014 #V14.2 maha - check template first then facility defaults
//		ll_find = lds_template.find( "parent_facility_id="+string(li_facility_id), 1,lds_template.RowCount())
//		if ll_find > 0 then
//			li_app_audit_facility = lds_template.getitemnumber(i, "application_audit_facility")
//			li_ver_facility = lds_template.getitemnumber(i, "verifying_facility")
//			ls_app_type = lds_template.getitemstring(i, "apptmnt_type")
//		else
//			ll_find = lds_facility.find( "facility_id="+string(li_facility_id), 1,lds_facility.RowCount())
//			If not ll_find > 0 Then 
//				li_app_audit_facility = 1
//				li_ver_facility = 1
//				ls_app_type = 'I'
//			Else
//				li_app_audit_facility = lds_facility.getitemnumber(ll_find,'default_audit_temp')
//				li_ver_facility =  lds_facility.getitemnumber(ll_find,'default_verif_facility')
//				ls_app_type = 'I'
//			End If   //facility find
//		end if  //template find
//		//End Code Change ----05.19.2014
//	END IF
//
//
////		//set the checklist and verif facility
////	ll_find = lds_facility.find( "facility_id="+string(li_facility_id), 1,lds_facility.RowCount())
////	If not ll_find > 0 Then 
////		li_app_audit_facility = 1
////		li_ver_facility = 1
////	Else
////		li_app_audit_facility = lds_facility.getitemnumber(ll_find,'default_audit_temp')
////		li_ver_facility =  lds_facility.getitemnumber(ll_find,'default_verif_facility')
////	End If
//
//
//	//debugbreak()
////check if the provider has the facility
//	ll_find = lds_facility_cnt.find( "parent_facility_id="+string(li_facility_id), 1,lds_facility_cnt.RowCount())
//	If ll_find > 0 Then
//		li_facility_cnt = ll_find   //lds_facility_cnt.getitemnumber(ll_find,'cnt')
//	else
//		li_facility_cnt = 0
//	end if
//
//	
//	if li_facility_cnt = 0 then
//		
//			ll_rec_id++
//
//			//dw_facility_add.reset()   //Start Code Change ----07.13.2012 #V12 maha - moved above
//			dw_facility_add.insertrow(1)
//			dw_facility_add.setitem(1,"rec_id",ll_rec_id)
//			dw_facility_add.setitem(1,"prac_id",il_prac_id)
//			dw_facility_add.setitem(1,"seq_no",1)
//			dw_facility_add.setitem(1,"affiliation_status","M")		
//			dw_facility_add.setitem(1,"parent_facility_id",li_facility_id)  //Start Code Change ---- 03.08.2006 #315 maha
//			dw_facility_add.setitem(1,"apptmnt_type", ls_app_type) //Start Code Change ----05.05.2014 #V14.2 maha - changed to variable
//			dw_facility_add.setitem(1,"verifying_facility",li_ver_facility)
//			dw_facility_add.setitem(1,"application_audit_facility",li_app_audit_facility)
//			dw_facility_add.setitem(1,"active_status",1)
//			dw_facility_add.setitem(1,"priority",1)
//			
//			//Start Code Change ----04.03.2012 #V12 maha - modifed to use facility setting
//			//Start Code Change ----06.18.2014 #V14.2 maha - removed as user is assigned from dropdown
////				select reap_user into :li_user from facility where facility_id = :li_facility_id;
////				if isnull(li_user) then li_user = 0
////				choose case li_user
////					case 2 //current use	
////						ls_assn_user = gs_user_id
////					case else //default
////						ls_assn_user = "PUBLIC"
////				end choose
//			//End Code Change ----06.18.2014
//			dw_facility_add.setitem(1,"priority_user",is_assn_user)
//			//End Code Change ----04.03.2012	
//			
//
//			ids_cred_comms.setfilter("facility_id=" + string(li_facility_id))
//			ids_cred_comms.filter( )
//			of_add_data_links(il_prac_id , li_facility_id , ll_rec_id)
//			
//			//Start Code Change ----08.09.2012 #V12 maha - trap if more than 1 facility records are added
//			f = lds_facility_cnt.insertrow(0)
//			lds_facility_cnt.setitem( f ,"parent_facility_id", li_facility_id )
//			lds_facility_cnt.setitem( f ,"cnt", 1 )
//			//Start Code Change ----08.09.2012
//			
////			Start Code Change ----03.17.2014 #V14.2 maha - added checklist creation
//			IF of_create_checklist(  li_app_audit_facility, "I", ll_rec_id, li_facility_id)  = -1 THEN
//				Return -1
//			END IF
//			//End Code Change ----03.17.2014
//
//	END IF
//
//
////	ll_recid_app++
////	IF of_out_to_md_ai( li_facility_id, long( ls_app_id ), "App Out To MD" ,ll_recid_app, ll_loc_id ) = -1 THEN  //Start Code Change ----05.05.2014 #V14.2 maha - added loc id  //Start Code Change ----04.16.2008 #V8 maha - corrected for variable
////		Return -1
////	END IF
//
////	li_rc = UpperBound( lstr_ids.s_action_type[] )
//
////	FOR z = 1 TO li_rc
//
//		ll_recid_app++
//	//	IF of_out_to_md_ai( li_facility_id, Integer( ls_app_id ), lstr_ids.s_action_type[1],ll_recid_app, ll_loc_id, ls_app_type) = -1 THEN  //Start Code Change ----05.05.2014 #V14.2 maha - added loc id  //Start Code Change ----04.16.2008 #V8 maha - corrected for variable
//			Return -1
//	//	END IF
//
////	END FOR
//
//END FOR
////messagebox("cnt",dw_facility_add.rowcount())
//dw_facility_add.update() 
//
//ids_spec_link.update()
//ids_address_link.update()
//ids_hosp_link.update()
//ids_cred_committees.update()
//gnv_appeondb.of_commitqueue()
//
//
//if lb_create_address then
//	for f = 1 to upperbound(ll_locations[])
//		ll_loc_id = ll_locations[f]
//		of_create_address_from_location(ll_pracids[], ll_loc_id, "")
//	next
//end if
//
//
//destroy ids_spec_link
//destroy ids_all_spec
//destroy ids_address_link
//destroy ids_all_addresses
//destroy ids_hosp_link
//destroy ids_all_hosp
//destroy lds_facility_cnt
//destroy ids_cred_committees
//destroy ids_cred_comms
//destroy lds_facility
//destroy lds_template  //Start Code Change ----05.05.2014 #V14.2 maha
////---------------------------- APPEON END ----------------------------
//
//MessageBox( "Data Links", "Make sure you update your Address, Hospital and Specialty links for the new Payer/Hospitals you have added.", Information! )
//
//
//dw_orgs_facilities.SetRedraw(False) //alfee 11.22.2010
//dw_orgs_facilities.Retrieve( il_prac_id, gs_user_id )
//dw_orgs_facilities.SetRedraw(True) //alfee 11.22.2010
//
//tab_1.tabpage_ai.dw_net_dev.SetRedraw( True )
//
//IF  Isvalid(w_prac_data_1) then  //Start Code Change ---- 02.07.2007 #V7 maha added trap for intelliapp window.
//	w_prac_data_1.ib_app_audit_retrieved = False
//	w_prac_data_1.ib_affil_stat_retrieved = False
//	w_prac_data_1.ib_verif_info_retrieved = False
//	w_prac_data_1.ib_priv_retrieved = False
//end if
//
//
//Return 1
//
//
end function

public function integer of_reappoint ();Integer li_rc
Integer i
Integer li_ans
Integer li_facility_id
Long ll_action_type
Long ll_app_id
long ll_loc //maha 05.05.2014
String ls_payor

// mskinner 17 Dec 2005 -- begin
// due to menu management issues the function is being call at inappropriate time
// added trap to prevent the crash. Need to fix the menus
if dw_orgs_facilities.GetRow( ) < 1 then return -1
// mskinner 17 Dec 2005 -- end

setnull(ll_loc) //Start Code Change ----05.05.2014 #V14.2 maha

ls_payor = dw_orgs_facilities.GetItemString( dw_orgs_facilities.GetRow( ), "parent_facility" )
li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow( ), "parent_facility_id" )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT lookup_code INTO :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Error 1", "To automatically create an Network Development Action item for IntelliApp you will need to add 'App Out To MD' to the Action Type lookup table." )
	Return -1
END IF
*/
ll_action_type = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP OUT TO MD'"))
//---------------------------- APPEON END ----------------------------

IF gi_intelliapp_type > 0 THEN
	IF il_app_id = 0 THEN
		MessageBox("Reappointment", "You must select a specific payor/hospital.  Please try again." )
		Return -1
	END IF
	ll_app_id = il_app_id
ELSE
	SELECT Distinct net_dev_action_items.app_id  
	INTO :ll_app_id  
	FROM net_dev_action_items  
	WHERE ( net_dev_action_items.prac_id = :il_prac_id ) AND  
      ( net_dev_action_items.facility_id = :li_facility_id ) AND  
      ( net_dev_action_items.active_status = 1 ) AND  
      ( net_dev_action_items.action_type = :ll_action_type )   ;
END IF
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error 2", SQLCA.SQLERRTEXT )
	Return 0
END IF

IF IsNull( ll_app_id ) THEN
	ll_app_id = 0
END IF

 //Start Code Change ----04.22.2015 #V15 maha
//OpenWithParm( w_initiate_reappointment, ls_payor + "-" + String( ll_app_id ) )
OpenWithParm( w_initiate_reappointment, string( il_prac_id ) + "-" + String( li_facility_id ) )

IF Message.StringParm = "Cancel" THEN
	Return 0
END IF
		
//UPDATE net_dev_action_items
//SET active_status = 0
//WHERE prac_id = :il_prac_id AND
//      facility_id = :li_facility_id AND
//		active_status = 1;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox( "SQL Error 3", SQLCA.SQLERRTEXT )
//	Return 0
//END IF
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-33
////$<modify> 02.15.2006 By: Cao YongWang 
////$<reason> Performance tuning.
////$<modification> Use li_recids to get the IDs instead of using SQLs in of_out_to_md_ai.
////$<modification> And then pass li_receds to of_out_to_md_ai as an argument to reduce client
////$<modification> -server interactions.
///*
//IF of_out_to_md_ai( li_facility_id, ll_app_id, "App Out To MD" ) = -1 THEN
//	Return -1
//END IF
//*/
//long ll_rec_id
//ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
//IF of_out_to_md_ai( li_facility_id, ll_app_id, "App Out To MD" ,ll_rec_id, ll_loc, "R", false) = -1 THEN
//	Return -1
//END IF
////---------------------------- APPEON END ----------------------------
//End Code Change ----04.22.2015	

of_retrieve_detail( li_facility_id )
of_report_selected_ver9( "NONE") //Start Code Change ----11.10.2008 #V85 maha

Return 0
end function

public function integer of_filter_ids ();////Start Code Change ----05.28.2014 #V14.2 maha - rewrote function
Integer li_rc
Integer i
String ls_filter = ""

//debugbreak()

if ii_facility_id > 0 THEN
	ls_filter = ls_filter + "facility_id = " + String( ii_facility_id ) 
end if

IF il_app_id > 0 then
	if len(ls_filter) > 0  then ls_filter+= " and "
	ls_filter+= " app_id = " + String( il_app_id ) 
end if


if gi_intelliapp_type < 3 then 	//Start Code Change ----05.03.2016 #V15 maha  - exception for two level treeview (3) - copied from 14.2
	//If il_loc_id > 0 then   //Commented by (Appeon)Harry 11.27.2014
	If Not isnull(il_loc_id) and il_loc_id >= 0 then  //(Appeon)Harry 11.27.2014 - for Testing Bug #4324  //(Appeon)Harry 12.18.2014 - add Not isnull(il_loc_id) 
		if len(ls_filter) > 0  then ls_filter+= " and "
		ls_filter+= " address_id = " + String( il_loc_id ) 
	end if
end if


i = tab_1.tabpage_ids.dw_ids.SetFilter( ls_filter )
//messagebox("Ids Records filter", ls_filter )
if i < 0 then
	messagebox("Ids Records filter failed", ls_filter )
end if

tab_1.tabpage_ids.dw_ids.Filter( )

IF tab_1.tabpage_ids.dw_ids.RowCount( ) > 0 THEN
	IF tab_1.tabpage_ids.dw_ids.GetItemStatus( 1, 0, Primary! ) = New! THEN
		tab_1.tabpage_ids.dw_ids.DeleteRow( 1 )
	END IF
END IF

RETURN 0


//org code
//Integer li_rc
//Integer i
//String ls_filter
//
////-----Begin Modified by alfee 09.14.2010 -----------------------
//// SK Practitioner Folder 
////IF dw_payors.RowCount( ) = 1 THEN
////	tab_1.tabpage_ids.dw_ids.SetFilter( "facility_id = 999" )
////	tab_1.tabpage_ids.dw_ids.Filter( )	
////	Return 1
////END IF
//
////IF il_app_id > 0 THEN
////	ls_filter = "app_id = " + String( il_app_id )
//
////Start Code Change ----05.28.2014 #V14.2 maha
//If il_loc_id > 0 then
//	ls_filter = " address_id = " + String( il_loc_id )
//else
//	ls_filter = " address_id = 0 " 
//end if
//
//IF il_app_id > 0 OR IsNull(il_app_id) THEN
//	IF il_app_id > 0 THEN
//		ls_filter+= " and app_id = " + String( il_app_id ) 
//	ELSE
//		ls_filter+= " and isnull(app_id)"
//	END IF
////-----End Modified ------------------------------------------------	
//	IF ii_facility_id > 0 THEN
//		ls_filter = ls_filter + " AND facility_id = " + String( ii_facility_id ) 	
//	END IF
//	tab_1.tabpage_ids.dw_ids.SetFilter( ls_filter )
//	tab_1.tabpage_ids.dw_ids.Filter( )
//	//-----Begin Modified by alfee 09.14.2010 -----------------------
//	//SK Practitioner Folder 
//	//dw_payors.PostEvent( "ue_after_retrieve" )
//	IF tab_1.tabpage_ids.dw_ids.RowCount() = 0 and ii_facility_id > 0 THEN  //Start Code Change ----01.25.2012 #V12 maha - added trap for 0 facility
//		tab_1.tabpage_ids.dw_ids.InsertRow( 0 )
//	END IF	
//	//-----End Modified ------------------------------------------------
//	//messagebox("1", ls_filter )
//elseif ii_facility_id > 0 THEN
//	ls_filter = ls_filter + " facility_id = " + String( ii_facility_id ) 
//	tab_1.tabpage_ids.dw_ids.SetFilter( ls_filter )
//	tab_1.tabpage_ids.dw_ids.Filter( )	
//	//messagebox("2", ls_filter )	
//ELSE
//	tab_1.tabpage_ids.dw_ids.SetFilter( "" )
//	tab_1.tabpage_ids.dw_ids.Filter( )		
//	IF tab_1.tabpage_ids.dw_ids.RowCount( ) > 0 THEN
//		IF tab_1.tabpage_ids.dw_ids.GetItemStatus( 1, 0, Primary! ) = New! THEN
//			tab_1.tabpage_ids.dw_ids.DeleteRow( 1 )
//		END IF
//	END IF
//	//messagebox("1", "none" )	
//END IF
//
//
//messagebox("", ls_filter )
//
//RETURN 0
//
//
end function

public function integer of_save ();Integer li_retval = 0

IF ib_save THEN
	tab_1.tabpage_ids.dw_ids.AcceptText()
	tab_1.tabpage_ai.dw_net_dev.AcceptText()	
	tab_1.tabpage_ai.dw_appoint_stat.AcceptText()
	IF lb_from_prac_folder THEN
		IF IsValid( w_prac_data_intelliapp ) THEN
			li_retval = w_prac_data_intelliapp.Event pfc_save()
		ELSEIF IsValid( w_prac_data_1 ) THEN
			li_retval = w_prac_data_1.Event pfc_save()
		ELSEIF IsValid( w_prac_data_sk ) THEN	//SK Practitioner Folder - alfee 09.28.2010		
			li_retval = w_prac_data_sk.Event pfc_save()
		END IF
	ELSE
		IF IsValid( w_action_items ) THEN
			li_retval = w_action_items.Event pfc_save()
		END IF
	END IF
	ib_save = False
END IF

Return li_retval
end function

public function integer of_set_quick_filter (string as_filter_syntax);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/18/2008 By: Ken.Guo
//$<reason> Save data before filter,Fix BugJ022705.
Long li_retval
li_retval = of_save()
IF li_retval < 0 THEN
	Return 1
END IF
//---------------------------- APPEON END ----------------------------


dwitemstatus idw
if tab_1.tabpage_ai.dw_net_dev.rowcount() = 1 then
	idw =  tab_1.tabpage_ai.dw_net_dev.getitemstatus(1,0,primary!)
	Choose Case idw
		case new!
			tab_1.tabpage_ai.dw_net_dev.deleterow(1)
	End choose
end if

String ls_filter

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.08.2006 By: Jervis
//$<reason> modify work flow
/*
ls_filter = as_filter_syntax
IF IsNull( ls_filter ) OR ls_filter = "" THEN
	tab_1.tabpage_ai.dw_net_dev.SetFilter( "" )
ELSE
	tab_1.tabpage_ai.dw_net_dev.SetFilter( ls_filter)
END IF
*/
ls_filter = as_filter_syntax
IF IsNull( ls_filter ) OR ls_filter = "" THEN
	tab_1.tabpage_ai.dw_net_dev.SetFilter( "active_status >= 0" )
ELSE
	tab_1.tabpage_ai.dw_net_dev.SetFilter( ls_filter ) // + " and active_status >= 0" )
END IF
//---------------------------- APPEON END ----------------------------


//messagebox("", ls_filter )
//clipboard(ls_filter)

ib_filter_set = True

tab_1.tabpage_ai.dw_net_dev.Filter( )
tab_1.tabpage_ai.dw_net_dev.GroupCalc ( ) //maha 062905
st_as_msg.visible = false //maha 062905

//------Begin Added by Alfee 11.12.2009 --------------
//$<Reason>no filter and share data for these 2 options, or it will cause an exception
if tab_1.tabpage_report.rb_par.checked or tab_1.tabpage_report.rb_par_sum.checked then 
	 return 1 
end if
//------End Added-------------------------------------


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 04.29.2015
//<$>reason:use rowscopy instead of sharedata
//				(Discrepancy on the order of the incomplete action items for C/S and Web in V14.2)

////--------Begin Modified by alfee 03.08.2010 ----------
////$<reason>for ticket #23349 - Window freezed when trying 
////to navigate to the Application Status tab in Action Item 
//tab_1.tabpage_ai.dw_net_dev.sharedata(tab_1.tabpage_report.dw_report_data)
tab_1.tabpage_report.dw_report_data.Reset()
if tab_1.tabpage_ai.dw_net_dev.RowCount() > 0 then
	tab_1.tabpage_ai.dw_net_dev.rowscopy(1, tab_1.tabpage_ai.dw_net_dev.RowCount(), Primary!, tab_1.tabpage_report.dw_report_data, 1, Primary!)
end if
//////------------------- APPEON BEGIN -------------------
//////$<add> Evan 07.09.2009
//////$<reason> APB have a bug for ShareData function (Corrected BugE062602)
////tab_1.tabpage_report.dw_report_data.Reset()
////if tab_1.tabpage_ai.dw_net_dev.RowCount() > 0 then
////	tab_1.tabpage_report.dw_report_data.object.data = tab_1.tabpage_ai.dw_net_dev.object.data
////end if
//////------------------- APPEON END ---------------------
////---------End Modified --------------------------------

//------------------- APPEON END -------------------


//---------Begin Added by (Appeon)Stephen 08.28.2013 for V141 Print Apps From Action Items--------
If w_mdi.menuname = 'm_pfe_cst_net_dev_action_items'  and (isvalid(w_action_items) or isvalid(w_action_items_ia)) then
	//---------Begin Added by (Appeon)Stephen 01.16.2014 for Bug #3832 Error when printing app from the action items--------
	if isvalid(w_action_items) then
		iw_action_items = w_action_items
	else
		iw_action_items = w_action_items_ia
	end if 
	//---------End Added ------------------------------------------------------

	//iw_action_items.of_app_print_menu(tab_1.tabpage_ai.dw_net_dev, 0, 0)
	iw_action_items.dynamic of_app_print_menu(tab_1.tabpage_ai.dw_net_dev, 0, 0) //Modified by Appeon long.zhang 11.13.2014
end if
//---------End Added ------------------------------------------------------		

Return 1

end function

public function long of_get_id_count (n_ds ads_cache, integer ai_facility_ids[]);//////////////////////////////////////////////////////////////////////
// $<function>pfc_ia_cst_nv_net_dev_new.of_get_id_count()
// $<arguments>
//		value	n_ds   	ads_cache        		
//		value	integer	ai_facility_ids[]		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.16.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
long	ll_id_count = 0
long	ll_i , ll_find

For ll_i = 1 To upperbound(ai_facility_ids[])
	ll_find = ads_cache.find("parent_facility_id = "  +string(ai_facility_ids[ll_i]) , 1 , ads_cache.Rowcount())
	If not ll_find > 0 Then ll_id_count++
Next

return ll_id_count
end function

public subroutine of_add_data_links (long al_prac_id, integer ai_facility_id, integer al_rec_id);//////////////////////////////////////////////////////////////////////
// $<function>pfc_ia_cst_nv_net_dev_new.of_add_data_links()
// $<arguments>
//		value	long	al_prac_id    		
//		value	long	al_facility_id		
// $<returns> (none)
// $<description> Add data links. Add address link , Add hospital link, Add specialty link.
// $<description> This function contain the funtion of of_add_address_link funtion,of_add_hosp_link function 
// $<description> and of_add_spec_link function in pfc_cst_nv_data_entry_functions userobject
//////////////////////////////////////////////////////////////////////
// $<add> 02.16.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

Integer li_hosp_cnt , li_spec_cnt , li_address_cnt
Integer i 
Integer li_nr 
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id , ll_address_id , ll_addr_id //maha 02-26-01
integer li_num_comms , c , cnt
long ll_comm_id

//Add address link
 
li_address_cnt = ids_all_addresses.Rowcount()

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	//\/maha 02-26-01 check to see if link already exists 
	ll_addr_id = ids_all_addresses.GetItemNumber( i, "rec_id" )	
	
	cnt = ids_address_linked.find("facility_id = " + String( ai_facility_id ) + " and address_id =" + string(ll_addr_id),1,ids_address_linked.Rowcount())
	if cnt > 0 then continue
	//\maha
	li_nr = ids_address_link.InsertRow( 0 )	
	ids_address_link.SetItem( li_nr, "prac_id", il_prac_id )
	ids_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	ids_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
	ids_address_link.SetItem( li_nr, "billing", 0 )//maha app100305
	ids_address_link.SetItem( li_nr, "mailing", 0 )//maha app100305
//Start Code Change ---- 01.25.2006 #221 maha
	ids_address_link.SetItem( li_nr, "home_address", 0 )
	ids_address_link.SetItem( li_nr, "primary_office", 0 )
	ids_address_link.SetItem( li_nr, "additional_office", 0 )
	ids_address_link.SetItem( li_nr, "include_in_directory", 0 )
	ids_address_link.SetItem( li_nr, "exp_letters", 0 )
//End Code Change---01.25.2006 			
			
	
END FOR



//Add the hosp link
li_hosp_cnt = ids_all_hosp.Rowcount()

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = ids_all_hosp.GetItemNumber( i, "rec_id" )

	li_found = ids_hosp_link.Find( "facility_id = " + String( ai_facility_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = ids_hosp_link.InsertRow( 0 )	
	ids_hosp_link.SetItem( li_nr, "prac_id", al_prac_id )
	ids_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	ids_hosp_link.SetItem( li_nr, "facility_id", ai_facility_id )
END FOR

//Add specialty link
li_spec_cnt = ids_all_spec.Rowcount()

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = ids_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = ids_spec_link.Find( "facility_id = " + String( ai_facility_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = ids_spec_link.InsertRow( 0 )	
	ids_spec_link.SetItem( li_nr, "prac_id", al_prac_id )
	ids_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	ids_spec_link.SetItem( li_nr, "facility_id", ai_facility_id )
	ids_spec_link.SetItem( li_nr, "practicing", 582 )
next

//Add committee lind
if gs_cust_type <> "I" then

	li_num_comms = ids_cred_comms.RowCount()
	FOR c = 1 TO li_num_comms
		li_nr = ids_cred_committees.InsertRow( 0 )
		ll_comm_id = ids_cred_comms.GetItemNumber( c, "committee_id" )
		ids_cred_committees.SetItem( li_nr, "facility_id", ai_facility_id )
		ids_cred_committees.SetItem( li_nr, "committee_id", ll_comm_id )
		ids_cred_committees.SetItem( li_nr, "active_status", 1 )
		ids_cred_committees.SetItem( li_nr, "rec_id", al_rec_id )
		ids_cred_committees.SetItem( li_nr, "prac_id", al_prac_id )
		ids_cred_committees.SetItem( li_nr, "seq_no", 1 )
	END FOR
End If
end subroutine

public function integer of_refresh_data ();//------------Begin Added by alfee 09.17.2010 ---------------------
//SK Practitioner Folder
long li_facility_id_last 
long ll_app_id_last, ll_found
long ll_gpid_last // maha 05.21.2014
string ls_find

if gi_intelliapp_type > 0 then //non single group
	li_facility_id_last = ii_facility_id
	ll_app_id_last = il_app_id
	ll_gpid_last = il_loc_id  //Start Code Change ----05.21.2014 #V14.2 maha
	//retrieve data in the treeview datawindow
	dw_orgs_facilities.SetRedraw( False) //alfee 11.22.2010
	if lb_from_prac_folder then
		dw_orgs_facilities.retrieve(il_prac_id, gs_user_id)
	else
	//	messagebox("","refresh")//commented by long.zhang appeon 01.28.2013
		dw_orgs_facilities.retrieve(gs_user_id)
	end if
	
	//Locate the last facility in the treeview datawindow
	//Start Code Change ----05.21.2014 #V14.2 maha
	if li_facility_id_last <> ii_facility_id or ll_app_id_last <> il_app_id or ll_gpid_last <> il_loc_id then  
	//if li_facility_id_last <> ii_facility_id or ll_app_id_last <> il_app_id then
		ls_find = "parent_facility_id = " + String(li_facility_id_last) 
		if ll_app_id_last > 0 then 
			ls_find += " and app_id = " + String(ll_app_id_last)
		elseif isnull(ll_app_id_last) then
			ls_find += " and isnull(app_id) "
		end if
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 04.15.2015
		//<$>reason:add IF condition, Bug 4485 for Case # 00053246: Issue with new release- application tracking
		If ll_gpid_last <> -1 Then
			ls_find += " and gp_id = " + String(ll_gpid_last)  //Start Code Change ----05.21.2014 #V14.2 maha
		End If
		//------------------- APPEON END -------------------
		
		ll_found = dw_orgs_facilities.find(ls_find, 1, dw_orgs_facilities.rowcount())
		if ll_found > 0 then
			dw_orgs_facilities.collapseall()					
			dw_orgs_facilities.expand(ll_found, 1)
			dw_orgs_facilities.expand(ll_found, 2)  //Start Code Change ----05.21.2014 #V14.2 maha - added
			dw_orgs_facilities.setrow(ll_found)
			dw_orgs_facilities.scrolltorow(ll_found)
			if ll_app_id_last = 0 then //parent node
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 04.15.2015
				//<$>reason:Bug 4485 for Case # 00053246: Issue with new release- application tracking
				//dw_orgs_facilities.selecttreenode(ll_found, 1, true)	
				If ll_gpid_last = -1 Then //parent facility node ( 'two level' or 'three level')
					dw_orgs_facilities.selecttreenode(ll_found, 1, true)	
				Else //Location level (it must be 'three level' )
					dw_orgs_facilities.selecttreenode(ll_found, 2, true)	
				End If
				//------------------- APPEON END -------------------
			else
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 04.15.2015
				//<$>reason:Bug 4485 for Case # 00053246: Issue with new release- application tracking
				//dw_orgs_facilities.selecttreenode(ll_found, 3, true)   //Start Code Change ----05.21.2014 #V14.2 maha - changed from 2
				If gi_intelliapp_type = 3 Then//two level
					dw_orgs_facilities.selecttreenode(ll_found, 2, true) 
				Else //1,2 //three level
					dw_orgs_facilities.selecttreenode(ll_found, 3, true) 
				End If
				//------------------- APPEON END -------------------
				
			end if
		end if		
	end if	
	dw_orgs_facilities.SetRedraw( True) //alfee 11.22.2010
	//
	return 1
end if
//-------------End Added ----------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.08.2006 By: Jervis
//$<reason> modify workflow,refresh data when active status changed
integer li_rc

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 06.03.2009
//$<reason> Needs to refresh dw_payors data (Corrected BugA120805)
//li_rc = tab_1.tabpage_ai.dw_net_dev.Retrieve( )
if dw_orgs_facilities.GetRow() > 0 then
	dw_orgs_facilities.Event RowFocusChanged(dw_orgs_facilities.GetRow())
	if gi_intelliapp_type > 0 THEN //add if statement - alfee 11.01.2010
		if dw_payors.GetRow() > 0 then
			dw_payors.ScrollToRow(1)
		else
			tab_1.tabpage_ai.dw_net_dev.Reset()
		end if
	end if
else
	dw_payors.Reset()
	tab_1.tabpage_ai.dw_net_dev.Reset()
end if
li_rc = tab_1.tabpage_ai.dw_net_dev.RowCount()
//------------------- APPEON END ---------------------

if li_rc = 0 then
	if ib_insertblankrow then  //Start Code Change ----02.09.2016 #V15 maha - action items trap
		tab_1.tabpage_ai.dw_net_dev.InsertRow( 0 )
	end if
	//------------------- APPEON BEGIN -------------------
	//$<add> Michael 06.23.2011
	//$<reason> V11.3 Action Item Dates
	//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_date",datetime(today(),now()))
	//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_user",gs_user_id)
	//------------------- APPEON END ---------------------
end if

tab_1.tabpage_report.dw_report_data.SetSort( "v_full_name_full_name a, facility_name1 a, action_date a" )
tab_1.tabpage_report.dw_report_data.Sort( )
//---------------------------- APPEON END ----------------------------


return 0

end function

public function long of_down_image (long al_rec_id, long al_prac_id, long al_app_id, string as_picname);//------------------------------------------------------------------------------
// Function: of_Down_Image()
//------------------------------------------------------------------------------
// Description: DownLoad Image to Local directory
// Arguments:
//		1 -- al_rec_id
//		2 -- al_prac_id
//		3 -- al_app_id
//		3 -- as_PicName
// Return Value: 
//	  -1 -- Failed
//		1 -- Sucess
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-09
//------------------------------------------------------------------------------
// Revision History:  
//				1.0   Initial version
//Removed the al_app_id in SQL statements below as it may be different and also not ncessary (V15.1 View Apps) - alfee 05.19.2015
//==============================================================================

long		ll_FileNo,ll_Cycle,ll_DataLen,ll_Count,ll_Start,ll_FileLen
Blob		lblb_Buffer

long 		READ_ONE_COUNT = 8000

SetPointer (HourGlass!)

if FileExists(as_PicName) then ll_FileLen = FileLength(as_PicName)

SELECT Datalength(net_dev_action_images.image_data)
  INTO :ll_DataLen
  FROM net_dev_action_images
WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id; 
//WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;

if IsNull(ll_DataLen) or ll_DataLen <= 0 then Return -1
if ll_DataLen = ll_FileLen then Return 1

ll_FileNo = FileOpen(as_PicName,StreamMode!,Write!,LockReadWrite!,Replace!)
if ll_FileNo <= 0 then Return -1

ll_Count = Ceiling(ll_DataLen/READ_ONE_COUNT)

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_COUNT then
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_COUNT + 1
		SELECTBLOB SubString(image_data,:ll_Start,:READ_ONE_COUNT)
		      INTO :lblb_Buffer
		      FROM net_dev_action_images
		     WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id ;
		     //WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;
		FileWrite(ll_FileNo,lblb_Buffer)
	next
else
	SELECTBLOB image_data
	      INTO :lblb_Buffer
	      FROM net_dev_action_images
 		WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id;
		//WHERE rec_id = :al_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;			
	
	for ll_Cycle = 1 To ll_Count
		FileWrite(ll_FileNo,BlobMid(lblb_Buffer,(ll_Cycle - 1) * READ_ONE_COUNT + 1,READ_ONE_COUNT))
	next
end if

FileClose(ll_FileNo)

SetPointer (Arrow!)

Return 1

end function

public function integer of_report_selected_ver9 (string as_report);//Start Code Change ----11.10.2008 #V85 maha - created to supercede of_report selected for easier reading
Integer li_retval
Long ll_prac_ids[1]
DataWindowChild dwchild
boolean lb_ret
string ls_report
//messagebox("",as_report)

if as_report = "NONE" then
	if tab_1.tabpage_report.rb_ai.checked then
		ls_report = "Status"
	elseif tab_1.tabpage_report.rb_ai_wn.checked then
		ls_report = "StatusWithNotes"
	elseif tab_1.tabpage_report.rb_par.checked then
		ls_report = "ParNums"		
	elseif tab_1.tabpage_report.rb_par_sum.checked then
		ls_report = "ParNumsSum"
	end if
else
	ls_report = as_report
end if
		

Choose case ls_report
	case "Status"  //button 1
		lb_ret = true
		IF is_group_by = "Practitioner" THEN
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_prac" //default dw prac folder  //Error? Preview data in PB Painter???
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_prac_ai" //default dw action items //*# ???
			end if
		ELSEIF is_group_by = "Client" THEN
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_payer_m"			
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rpt_by_payer_m_ai"  //*#
			end if
		ELSE //payor
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_payer"
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rpt_by_payer_ai"  //*#
			end if
		END IF
	case "StatusWithNotes" //button 2
		lb_ret = true
		IF is_group_by = "Practitioner" THEN
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_prac_wn"
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rpt_by_prac_wn_ai" //*#
			end if
		ELSEIF is_group_by = "Client" THEN 
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rep_by_payer_m_wn"
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_item_rt_by_payor_mwn_ai" //*#
			end if
		ELSE //payor
			if lb_from_prac_folder then
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rep_by_payer_wn"	
			else //action items
				tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_item_rpt_by_payor_wn_ai" //*#
			end if
		END IF
	case "ParNumsSum" //button 3
		lb_ret = false
		//Start Code Change ----10.30.2013 #V14 maha - added address link option
		if ib_show_ids_addr = true then  
			tab_1.tabpage_report.dw_report_data.DataObject = "d_rpt_par_numbers_summary_addr"
		else
			tab_1.tabpage_report.dw_report_data.DataObject = "d_rpt_par_numbers_summary"
		end if
		//End Code Change ----10.30.2013
		tab_1.tabpage_report.dw_report_data.of_SetTransObject( SQLCA )
		ll_prac_ids[1] = il_prac_id
		tab_1.tabpage_report.dw_report_data.Retrieve( ll_prac_ids[] )
		of_par_report_filter( )	
	case "ParNums" //button 4
		lb_ret = false
		//Start Code Change ----09.23.2013 #V14 maha - added address link option
		if ib_show_ids_addr = true then  
			tab_1.tabpage_report.dw_report_data.DataObject = "d_rpt_par_numbers_details_new_addr"
		else
			tab_1.tabpage_report.dw_report_data.DataObject = "d_rpt_par_numbers_details_new"
		end if
		//End Code Change ----09.23.2013 
		tab_1.tabpage_report.dw_report_data.of_SetTransObject( SQLCA )
		ll_prac_ids[1] = il_prac_id
		//----Begin Modified by alfee 03.25.2010 --------------------
		//<$Reason>For a Web bug - ticket #23583
		of_par_report_filter( )
		tab_1.tabpage_report.dw_report_data.Retrieve( ll_prac_ids[] )				
		//tab_1.tabpage_report.dw_report_data.Retrieve( ll_prac_ids[] )
		//of_par_report_filter( )		
		//----End Modified ------------
		
		//---------Begin Added by (Appeon)Stephen 06.09.2015 for Bug id 4555 - Plan Type not showing in the Participation Number Detail Report V14--------
		tab_1.tabpage_report.dw_report_data.GetChild( "net_dev_ids_plan_type", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve("Plan Type")
		//---------End Added ------------------------------------------------------

end choose

if lb_ret = true then	//action items reports
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 04.29.2015
	//<$>reason:program freezes in web client because of using a.object.data = b.oject.data, New Mexico Health Case#53521
	
	//	//--------Begin Modified by alfee 03.08.2010 -----------
	//	//$<reason>for ticket #23349 - Window freezed when trying to navigate to the Application 
	//	//Status tab in Action Item. the 'd_net_dev_action_items' is also modified for share data.
	//	//li_retval = tab_1.tabpage_ai.dw_net_dev.ShareData( tab_1.tabpage_report.dw_report_data ) //comment by Appeon long.zhang 04.24.2015 (Discrepancy on the order of the incomplete action items for C/S and Web in V14.2)
	//	tab_1.tabpage_report.dw_report_data.sharedataoff()  //added by Appeon long.zhang 04.24.2015 (Discrepancy on the order of the incomplete action items for C/S and Web in V14.2)
	//	//---------Begin Added by (Appeon)Stephen 03.18.2014 for  Bug 3974--------
	//	
	//	//if li_retval = -1 then //comment by Appeon long.zhang 04.24.2015 (Discrepancy on the order of the incomplete action items for C/S and Web in V14.2)
		tab_1.tabpage_report.dw_report_data.reset()
	//		//messagebox("Failure to sharedata in of_report_selected_v9",tab_1.tabpage_report.dw_report_data.dataobject)
	//		tab_1.tabpage_report.dw_report_data.object.data = tab_1.tabpage_ai.dw_net_dev.object.data
		if tab_1.tabpage_ai.dw_net_dev.RowCount() > 0 then
			li_retval = tab_1.tabpage_ai.dw_net_dev.rowscopy(1, tab_1.tabpage_ai.dw_net_dev.RowCount(), Primary!, tab_1.tabpage_report.dw_report_data, 1, Primary!)
			If li_retval = -1 Then
				messagebox("Report Error","RowsCopy:" + string(tab_1.tabpage_ai.dw_net_dev.dataobject) +' -> ' + string(tab_1.tabpage_report.dw_report_data))
			End If
		end if
	//	//end if
	//	//---------End Added ------------------------------------------------------
	//------------------- APPEON END -------------------
	
	//	//------------------- APPEON BEGIN -------------------
	//	//$<modify> Evan 05.13.2009
	//	//$<reason> APB have a bug for ShareData function
	//	//li_retval = tab_1.tabpage_ai.dw_net_dev.ShareData( tab_1.tabpage_report.dw_report_data )
	//	if tab_1.tabpage_ai.dw_net_dev.RowCount() > 0 then
	//		tab_1.tabpage_report.dw_report_data.object.data = tab_1.tabpage_ai.dw_net_dev.object.data
	//	else
	//		tab_1.tabpage_report.dw_report_data.Reset()
	//	end if
	//	//------------------- APPEON END ---------------------
	//--------End Modified ----------------------------------
	
	tab_1.tabpage_report.dw_report_data.SetSort(tab_1.tabpage_report.dw_report_data.Describe("DataWindow.Table.Sort") )
	tab_1.tabpage_report.dw_report_data.Sort()
	tab_1.tabpage_report.dw_report_data.groupcalc()

	gnv_appeondb.of_startqueue()

	tab_1.tabpage_report.dw_report_data.GetChild( "action_dept", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Action Department")

	tab_1.tabpage_report.dw_report_data.GetChild( "action_type", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Action Type")

	tab_1.tabpage_report.dw_report_data.GetChild( "action_status", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Action Status")
	
	tab_1.tabpage_report.dw_report_data.GetChild( "app_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( )

	gnv_appeondb.of_commitqueue()
end if


tab_1.tabpage_report.dw_report_data.GroupCalc( )
//tab_1.tabpage_ai.dw_net_dev.ShareData( tab_1.tabpage_report.dw_report_data ) //Delete by Evan 05.13.2009 --- The code is redundant.


tab_1.tabpage_report.dw_report_data.Modify( "datawindow.print.preview=Yes" )

Return 0
end function

public function integer of_par_report_filter ();//Start Code Change ----11.10.2008 #V85 maha - function added for filtering of participation reports
 //Start Code Change ----08.18.2015 #V15 maha = rewrote for better filtering via treeview

string ls_filter
integer res

IF il_app_id < 1 and  ii_facility_id < 1 THEN return 1

choose case is_tree_level
	case "1"
		IF ii_facility_id > 0 THEN
			ls_filter += " facility_facility_id = " + String( ii_facility_id ) + " and"
		END IF
	case "2" 
		IF ii_facility_id > 0 THEN
			ls_filter += " facility_facility_id = " + String( ii_facility_id ) + " and"
		END IF
		
		if il_loc_id > 0 then
			ls_filter += "  net_dev_ids_address_id  = " + String( il_loc_id ) + " and"
		else
			ls_filter += "  net_dev_ids_address_id  = " + String( 0 ) + " and"
		end if
	case "D"
		IF ii_facility_id > 0 THEN
			ls_filter += " facility_facility_id = " + String( ii_facility_id ) + " and"
		END IF

//Start Code Change ----09.17.2015 #V15 maha	- refined the logic to skip the filter if using 2 level tree view and eliminate the show ids variable
//		if ib_show_ids_addr = true then
//			if il_loc_id > 0 then
//				ls_filter += "  net_dev_ids_address_id  = " + String( il_loc_id ) + " and"
//			else
//				ls_filter += "  net_dev_ids_address_id  = " + String( 0 ) + " and"
//			end if
//		else
//			ls_filter += "  net_dev_ids_address_id  = " + String( 0 ) + " and"
//		end if
		
		if gi_intelliapp_type = 3 then //two level
			//skip filter
		else
			if il_loc_id > 0 then
				ls_filter += "  net_dev_ids_address_id  = " + String( il_loc_id ) + " and"
			else
				ls_filter += "  net_dev_ids_address_id  = " + String( 0 ) + " and"
			end if
		end if
//End Code Change ----09.17.2015	

		IF il_app_id > 0 THEN
			ls_filter += " app_hdr_app_id = " + String( il_app_id ) +  " and"
		END IF	
end choose


ls_filter = MidA(ls_filter,1, LenA(ls_filter) - 4 )
//messagebox("Set filter" ,ls_filter)
res = tab_1.tabpage_report.dw_report_data.setfilter(ls_filter)
if res < 1 then messagebox("of_part_report_filter","Set filter failed. Please contact IntelliSoft Support~n~n" + ls_filter)
tab_1.tabpage_report.dw_report_data.filter()
	
return 1
end function

public function integer of_set_security_nd ();//Start Code Change ----06.16.2009 #V92 maha - added
datawindow ldw1

ldw1 = tab_1.tabpage_ai.dw_net_dev

ldw1.modify("action_type.protect = 1")
ldw1.modify("action_user.protect = 1")
ldw1.modify("action_date.protect = 1")
ldw1.modify("due_date.protect = 1")
ldw1.modify("notes.protect = 1")
ldw1.modify("app_id.protect = 1")
ldw1.modify("action_status.protect = 1")
ldw1.modify("app_type.protect = 1")
ldw1.modify("action_dept.protect = 1")
ldw1.modify("gp_id.protect = 1")   //Start Code Change ----07.22.2015 #V15 maha
//ldw1.modify("b_notes.enabled = false") //Start Code Change ----10.10.2012 #V12 maha - removed

//Start Code Change ----10.10.2012 #V12 maha - added color mod
ldw1.Modify("action_type.background.color= '553648127'")
ldw1.Modify("action_user.background.color= '553648127'")
ldw1.Modify("action_date.background.color= '553648127'")
ldw1.Modify("due_date.background.color= '553648127'")
ldw1.Modify("notes.background.color= '553648127'")
ldw1.Modify("app_id.background.color= '553648127'")
ldw1.Modify("action_status.background.color= '553648127'")
ldw1.Modify("app_type.background.color= '553648127'")
ldw1.Modify("action_dept.background.color= '553648127'")
ldw1.Modify("gp_id.background.color= '553648127'")   //Start Code Change ----07.22.2015 #V15 maha
//End Code Change ----10.10.2012

ldw1 = tab_1.tabpage_ids.dw_ids

ldw1.modify("plan_type.protect = 1")
ldw1.modify("plan_assigned_id.protect = 1")
ldw1.modify("tax_id.protect = 1")
ldw1.modify("end_date.protect = 1")
ldw1.modify("start_date.protect = 1")
ldw1.modify("tier.protect = 1")

//Start Code Change ----10.10.2012 #V12 maha - added color mod
ldw1.Modify("plan_type.background.color= '553648127'")
ldw1.Modify("plan_assigned_id.background.color= '553648127'")
ldw1.Modify("tax_id.background.color= '553648127'")
ldw1.Modify("end_date.background.color= '553648127'")
ldw1.Modify("start_date.background.color= '553648127'")
ldw1.Modify("tier.background.color= '553648127'")

//tracking dw
ldw1 = tab_1.tabpage_ai.dw_tracking
ldw1.modify("assigned_user.protect = 1")
ldw1.modify("par_status.protect = 1")
ldw1.Modify("assigned_user.background.color= '553648127'")
ldw1.Modify("par_status.background.color= '553648127'")
ldw1.modify("gp_id.protect = 1")   //Start Code Change ----07.22.2015 #V15 maha
ldw1.Modify("gp_id.background.color= '553648127'")  //Start Code Change ----07.22.2015 #V15 maha
//End Code Change ----10.10.2012

//Start Code Change ----10.11.2012 #V12 maha - added appointment dw
//Note:as the dw is disabled, protect is not needed
ldw1 = tab_1.tabpage_ai.dw_appoint_stat
//ldw1.modify("apptmnt_type.protect = 1")
ldw1.Modify("apptmnt_type.background.color= '553648127'")
//ldw1.modify("date_rls_form_exp.protect = 1")
ldw1.Modify("date_rls_form_exp.background.color= '553648127'")
//ldw1.modify("apptmnt_start_date.protect = 1")
ldw1.Modify("apptmnt_start_date.background.color= '553648127'")
//ldw1.modify("apptmnt_end_date.protect = 1")
ldw1.Modify("apptmnt_end_date.background.color= '553648127'")
//ldw1.modify(".protect = 1")
ldw1.Modify("active_status.background.color= '553648127'")
//ldw1.modify(".protect = 1")
ldw1.Modify("pd_affil_stat_in_good_standing.background.color= '553648127'")
//End Code Change ----10.11.2012

tab_1.tabpage_notes.dw_notes.Object.notes.Edit.DisplayOnly='Yes' //(Appeon)Stephen 06.19.2015 - Bug id 4567 - Read Only user is missing notes scroll bar, SAAS 14.2 and Client Server 14.1 and 14.2

return 1
end function

public function integer of_bg_color (long al_rgb);long li_rgb

li_rgb = al_rgb

this.backcolor = li_rgb
tab_1.backcolor = li_rgb
tab_1.tabpage_ai.backcolor = li_rgb
tab_1.tabpage_ids.backcolor = li_rgb
tab_1.tabpage_notes.backcolor = li_rgb
tab_1.tabpage_report.backcolor = li_rgb
cbx_compl.backcolor = li_rgb //alfee 11.21.2010
//st_filter.backcolor = li_rgb//Start Code Change ----11.058.2014 #V14.2 maha - removed
//st_zoom.backcolor = li_rgb
//st_group_by.backcolor = li_rgb
//tab_1.tabpage_ai.gb_filter_1.backcolor = li_rgb
tab_1.tabpage_report.rb_ai.backcolor = li_rgb
tab_1.tabpage_report.rb_ai_wn.backcolor = li_rgb
tab_1.tabpage_report.rb_par.backcolor = li_rgb
tab_1.tabpage_report.rb_par_sum.backcolor = li_rgb
tab_1.tabpage_report.gb_filter_2.backcolor = li_rgb
gb_filter_1.backcolor = li_rgb  //Start Code Change ----01.19.2016 #V15 maha

return 1
end function

public function integer of_open_tracking ();long ll_app
long ll_facil
Long ll_row, ll_prac
long ll_loc  //maha05.22.2014
gs_pass_ids lst_ids
debugbreak()
//-------------Begin Modified by alfee 11.02.2010 -------------------------------
//<$Reason>For cases: 1. action item 2.individual group 3. Addtl filter


ll_row = tab_1.tabpage_ai.dw_net_dev.getrow()
if ll_row > 0 then
	ll_facil = tab_1.tabpage_ai.dw_net_dev.getitemnumber(ll_row, "facility_id")
	ll_prac = tab_1.tabpage_ai.dw_net_dev.getitemnumber(ll_row, "prac_id")
	ll_app = tab_1.tabpage_ai.dw_net_dev.getitemnumber(ll_row, "app_id")
	//Start Code Change ----05.22.2014 #V14.2 maha
	ll_loc = tab_1.tabpage_ai.dw_net_dev.getitemnumber(ll_row, "gp_id") 
	if isnull(ll_loc) then ll_loc = 0
	//End Code Change ----05.22.2014
end if

if isnull(ll_facil) or ll_facil < 1 or isnull(ll_prac) or ll_prac < 1 or isnull(ll_app) or ll_app < 1 then //data may be filtered 
	ll_facil = ii_facility_id
	if lb_from_prac_folder then ll_prac = il_prac_id 
	if gi_intelliapp_type > 0 then ll_app = il_app_id
end if

if isnull(ll_app) or ll_app < 1 then
	messagebox("Tracking function","You must select a specific Application to open the Tracker")
	return -1
end if
if isnull(ll_facil) or ll_facil < 1 then
	messagebox("Tracking function","You must select a specific Group to open the Tracker")
	return -1
end if
if isnull(ll_prac) or ll_prac < 1 then
	messagebox("Tracking function","You must select a specific Practitioner to open the Tracker")
	return -1
end if

lst_ids.l_app_id = ll_app
lst_ids.facility_id = ll_facil
lst_ids.prac_id = ll_prac
lst_ids.l_loc_ids[1] = ll_loc  //Start Code Change ----05.14.2014 #V14.2 maha

/*
ll_app = dw_payors.getitemnumber(dw_payors.getrow(),"app_id")
if ll_app < 1 then
	messagebox("Tracking function","You must select a specific Application to open the Tracker")
	return -1
end if

ll_facil = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"parent_facility_id")
if ll_facil < 1 then
	messagebox("Tracking function","You must select a specific Group to open the Tracker")
	return -1
end if

lst_ids.l_app_id = ll_app
lst_ids.facility_id = ll_facil
lst_ids.prac_id = gl_prac_id 
*/
//-------------End Modified ----------------------------------------------------

openwithparm(w_appl_track_prac,lst_ids)
end function

public function integer of_retrieve_detail ();//Retrieve detail data - called in the event of pfc_cst_retrieve_detail ()
//SK Practitioner Folder - alfee 09.14.2010

Integer li_rc
integer li_res //maha 08.03.2015
String ls_sql, ls_rtn
string ls_id, ls_action_status  //add by Stephen 06.14.2012 

//Modify datasource of dw_net_dev
ls_sql = is_sql


 //Start Code Change ----09.04.2015 #V15 maha
IF il_track_id > 0 then
	// ls_sql += " AND ( net_dev_action_items.track_id = " + String( ii_facility_id ) + ")"
	  ls_sql += " AND ( net_dev_action_items.track_id = " + String( il_track_id ) + ")"  //Start Code Change ----05.12.2016 #V15 maha - corrected
else
	IF ii_facility_id > 0 THEN ls_sql += " AND ( net_dev_action_items.facility_id = " + String( ii_facility_id ) + ")"
	IF il_app_id > 0 THEN ls_sql += " AND ( net_dev_action_items.app_id = " + String( il_app_id )  + ")"
	IF IsNull(il_app_id) THEN ls_sql += " AND ( net_dev_action_items.app_id is null "  + ")"
end if


//Start Code Change ----05.21.2014 #V14.2 maha
IF il_loc_id >= 0 THEN 
	ls_sql += " AND ( net_dev_action_items.gp_id = " + String( il_loc_id ) + ")"
ElseIF IsNull(il_loc_id) THEN 
	ls_sql += " AND ( net_dev_action_items.gp_id is null "  + ")"
else // -1 don't include gpid in query
	//ls_sql += " AND ( net_dev_action_items.gp_id = 0 " + ")"
end if
//Start Code Change ----04.30.2014

IF lb_from_prac_folder THEN //from Practitioner Appl. Status
	ls_sql = ls_sql + " AND ( net_dev_action_items.prac_id = " + String( il_prac_id )  + ")"
	IF ii_facility_id > 0 THEN
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '0'" )
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '0'" )			
	ELSE
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '56'" )
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '2583'" )		
	END IF	
END IF

 //Start Code Change ----08.03.2015 #V15 maha - added for ai filter
If is_user_id <> "All" then   //Start Code Change ----08.03.2015 #V15 maha
	ls_sql += " AND net_dev_action_items.action_user = '" + String( is_user_id ) + "'"
End if
 //End Code Change ----08.03.2015	

//Start Code Change ----02.09.2016 #V15 maha - rewrote filter so by default all but Complete show

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 06.14.2012
//$<reason> Bug 3126 : Action items not showing 
/*
if not ib_cbx_compl_checked then ls_sql += " AND net_dev_action_items.action_status in (90740, 90742) " //pending or incomplete - alfee 10.20.2010
*/
//ls_id = gnv_data.of_getitem("code_lookup" ,"lookup_code","upper(code)=upper('Pending') and upper(lookup_name)=upper('Action Status')")
//if not(isnull(ls_id) or ls_id = "") then
//	ls_action_status = ls_id
//end if
//ls_id = ""
//ls_id = gnv_data.of_getitem("code_lookup" ,"lookup_code","upper(code)=upper('InComplete') and upper(lookup_name)=upper('Action Status')")
//if not(isnull(ls_id) or ls_id = "") then
//	if isnull(ls_action_status) or ls_action_status="" then
//		ls_action_status = ls_id
//	else
//		ls_action_status +="," + ls_id
//	end if
//end if
//
//if not ib_cbx_compl_checked then 
//	if not(isnull(ls_action_status) or ls_action_status = "") then
//		ls_sql += " AND net_dev_action_items.action_status in ("+ls_action_status +")" 
//	end if
//end if
//------------------- APPEON END -------------------

ls_action_status = gnv_data.of_getitem("code_lookup" ,"lookup_code","upper(code)=upper('Complete') and upper(lookup_name)=upper('Action Status')")

if not ib_cbx_compl_checked then 
	if not(isnull(ls_action_status) or ls_action_status = "") then
		ls_sql += " AND ( net_dev_action_items.action_status <> "+ls_action_status +")" 
	end if
end if
//End Code Change ----02.09.2016

 //Start Code Change ----08.03.2015 #V15 maha - changed function call to eliminate failure with modify
li_res = tab_1.tabpage_ai.dw_net_dev.setsqlselect( ls_sql)
//ls_rtn = tab_1.tabpage_ai.dw_net_dev.Modify("datawindow.table.select='"+ ls_sql + "'")  
//IF LenA(ls_rtn) > 0 then 
IF li_res < 0 then	
	MessageBox("dw_net_dev - modify select failed",ls_rtn)
	//Clipboard(ls_rtn)
end if	
//End Code Change ----08.03.2015

tab_1.tabpage_ai.dw_net_dev.Modify("DataWindow.Table.UpdateTable='net_dev_action_items'")		

//Retrieve and filter data in dw_net_dev
tab_1.tabpage_ai.dw_net_dev.SetRedraw(false)
tab_1.tabpage_ai.dw_net_dev.SetTransObject( SQLCA )	

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.23.2014
//<$>reason:move script ,BugL102102  of V14.2 Issues of New Features by ISG
/*
//Start Code Change ----04.25.2014 #V14.2 maha
datawindowchild dwchild
tab_1.tabpage_ai.dw_net_dev.getchild( "gp_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve( il_prac_id )
dwchild.insertrow(1)
dwchild.setitem(1, "pd_address_gp_id", 0)
dwchild.setitem(1, "alias_street", "Not Linked")
//End Code Change ----04.25.2014 
*/
//------------------- APPEON END -------------------

li_rc = tab_1.tabpage_ai.dw_net_dev.Retrieve( )	

 //Start Code Change ----09.04.2015 #V15 maha - if no data retrieved via track id, try again with other parameters.
 if il_track_id > 0  and li_rc = 0 then
	li_rc = of_retrieve_detail_retry()
end if
//End Code Change ----09.04.2015

IF li_rc = 0 THEN
	if ib_insertblankrow = true then   //Start Code Change ----07.30.2015 #V15 maha - to allow supression in  action items screen
		messagebox("","insert")
		tab_1.tabpage_ai.dw_net_dev.InsertRow( 0 )
	end if
	//------------------- APPEON BEGIN -------------------
	//$<add> Michael 06.23.2011
	//$<reason> V11.3 Action Item Dates
	//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_date",datetime(today(),now()))
	//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_user",gs_user_id)
	//------------------- APPEON END ---------------------
ELSEIF li_rc < 0 then 
	Messagebox("Retrieve failed in of_retrieve_detail",  tab_1.tabpage_ai.dw_net_dev.dataobject + "~r~r" + ls_sql) 
	clipboard(ls_sql)
END IF	

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.23.2014
//<$>reason:il_prac_id changes after dw_net_dev.Retrieve ,BugL102102  of V14.2 Issues of New Features by ISG
datawindowchild dwchild
tab_1.tabpage_ai.dw_net_dev.getchild( "gp_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve( il_prac_id )
dwchild.insertrow(1)
dwchild.setitem(1, "pd_address_gp_id", 0)
dwchild.setitem(1, "alias_street", "Not Linked")
//------------------- APPEON END -------------------

IF NOT ib_filter_set THEN //quick filter
	tab_1.tabpage_ai.dw_net_dev.SetFilter( "active_status = 1" )
	tab_1.tabpage_ai.dw_net_dev.Filter( )
END IF

//Retrieve and filter data in other DataWindows
IF NOT ib_cbx_compl_changed THEN //if not called by cbx_compl - alfee 10.20.2010
	gnv_appeondb.of_startqueue() 
	tab_1.tabpage_ai.dw_appoint_stat.Retrieve( il_prac_id, ii_facility_id )	
	IF lb_from_prac_folder THEN 
		tab_1.tabpage_notes.dw_notes.Retrieve( il_prac_id )
		//Start Code Change ----06.07.2013 #V14 maha
		tab_1.tabpage_ids.dw_ids.getchild("address_id",dwchild)
		dwchild.settransobject(sqlca)
		dwchild.retrieve( il_prac_id)
		dwchild.insertrow(1)
		if ib_show_ids_addr then
			tab_1.tabpage_ids.dw_ids.modify("address_id.visible = True") 
			dwchild.SetItem(1, "pd_address_gp_id", 0) //Added by Appeon long.zhang 03.16.2015 (Requesting new V14.2 Web Package )
		end if
		//End Code Change ----06.07.2013
		tab_1.tabpage_ids.dw_ids.Retrieve( il_prac_id )
	END IF
	gnv_appeondb.of_commitqueue()

	IF lb_from_prac_folder THEN
		of_filter_ids( )	//filter IDs based on facility and app id and locid
		IF tab_1.tabpage_ids.dw_ids.RowCount() = 0 and ii_facility_id > 0 THEN
			tab_1.tabpage_ids.dw_ids.InsertRow( 0 )	 //Start Code Change ----01.25.2012 #V12 maha - added trap for 0 facility
			//Start Code Change ----10.21.2014 #V14.2 maha - add location id
			if il_loc_id > 0 then
			//	tab_1.tabpage_ids.dw_ids.setitem(1,"address_id", il_loc_id)
			end if
			//End Code Change ----10.21.2014
		End if
		
		IF tab_1.tabpage_notes.dw_notes.Rowcount()	= 0 THEN tab_1.tabpage_notes.dw_notes.InsertRow( 0 )			
	END IF
END IF //alfee 10.20.2010

//Set the Report tab page
of_report_selected_ver9( "NONE") 

tab_1.tabpage_ai.dw_net_dev.Sort( ) //Start Code Change ----05.02.2014 #V14.2 maha - sorting is peculiar in this dw calling sort does not work properly
//IF not lb_from_prac_folder THEN
//	tab_1.tabpage_ai.dw_net_dev.Sort( )
//	tab_1.tabpage_ai.dw_net_dev.SetRedraw(true)
//
//end if
tab_1.tabpage_ai.dw_net_dev.GroupCalc( ) 
tab_1.tabpage_ai.dw_net_dev.SetRedraw(true)


//debugbreak()
of_retrieve_tracking( )  //Start Code Change ----06.13.2012 #V12 maha

//Set others
st_as_msg.visible = false 
ddlb_zoom.Text = "100%"

//IF tab_1.SelectedTab = 1 THEN
//	tab_1.tabpage_ai.dw_net_dev.SetFocus( )
//ELSEIF tab_1.SelectedTab = 2 THEN
//	tab_1.tabpage_ids.dw_ids.SetFocus( )
//ELSEIF tab_1.SelectedTab = 3 THEN
//	tab_1.tabpage_notes.dw_notes.SetFocus( )
//END IF
	
RETURN 1
	






end function

public function integer of_retrieve_tracking ();//Start Code Change ----06.13.2012 #V12 maha - added
datawindow idw_tracking
long ll_id
//messagebox("", string(il_prac_id) + "-" + string( il_app_id) + "-" + string( ii_facility_id ))
//messagebox("", string(il_loc_id))
idw_tracking = tab_1.tabpage_ai.dw_tracking

if isnull(il_loc_id) then  il_loc_id = 0  //Start Code Change ----05.08.2014 #V14.2 maha

//Start Code Change ----04.08.2014 #V14.2 maha
//idw_tracking.retrieve(il_prac_id, il_app_id, ii_facility_id  )
//if idw_tracking.rowcount() = 0 then
//	if il_prac_id > 0 and  il_app_id > 0 and ii_facility_id > 0 then
//		idw_tracking.insertrow( 1)
//		idw_tracking.setitem(1,"prac_id",il_prac_id)
//		idw_tracking.setitem(1,"app_id",il_app_id)
//		idw_tracking.setitem(1,"facility_id",ii_facility_id)
//		idw_tracking.setitem(1,"active_status",1)
//		select max(track_id) into :ll_id from pd_appl_tracking;
//		if isnull(ll_id) then ll_id = 0
//		ll_id++
//		idw_tracking.setitem(1,"track_id",ll_id)
//		idw_tracking.update()
//		idw_tracking.retrieve(il_prac_id, il_app_id, ii_facility_id  )

//Start Code Change ----04.25.2014 #V14.2 maha
datawindowchild dwchild
idw_tracking.getchild( "gp_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve( il_prac_id )
dwchild.insertrow(1)
dwchild.setitem(1, "pd_address_gp_id", 0)
dwchild.setitem(1, "alias_street", "Not Linked")
//End Code Change ----04.25.2014

//maha 05.13.2016 - this needs to be rebuilt to retrieve by tracking id
idw_tracking.retrieve(il_prac_id, il_app_id, ii_facility_id, il_loc_id )

if idw_tracking.rowcount() = 0 then
	if il_prac_id > 0 and  il_app_id > 0 and ii_facility_id > 0 then
		idw_tracking.insertrow( 1)
		idw_tracking.setitem(1,"prac_id",il_prac_id)
		idw_tracking.setitem(1,"app_id",il_app_id)
		idw_tracking.setitem(1,"facility_id",ii_facility_id)
		idw_tracking.setitem(1,"gp_id",il_loc_id)
		idw_tracking.setitem(1,"active_status",1)
		select max(track_id) into :ll_id from pd_appl_tracking;
		if isnull(ll_id) then ll_id = 0
		ll_id++
		il_track_id = ll_id    //Start Code Change ----09.04.2015 #V15 maha 
		idw_tracking.setitem(1,"track_id",ll_id)
		idw_tracking.update()
		idw_tracking.retrieve(il_prac_id, il_app_id, ii_facility_id, il_loc_id )
		//need to calculate
	end if
else   //Start Code Change ----09.04.2015 #V15 maha  //existing record
	il_track_id = idw_tracking.getitemnumber(1,"track_id")
end if
//End Code Change ----04.08.2014

return 1


end function

public function integer of_change_facility ();//Start Code Change ----06.20.2012 #V12 maha
long ll_fac
integer res
long r 
datawindow ldw_actions

if ii_facility_id = 0 then
	messagebox("Change Facility","You must select from an individual Facility/Group to make this change.")
	return -1
end if

open(w_select_facility_group)

ll_fac = message.doubleparm

if ll_fac = 0 then return -1


res = messagebox ( "Change Facility/Group","Are you sure you wish to change the Facility/Group on these records?", question!,yesno!,2)
if res = 2 then return -1

ldw_actions = tab_1.tabpage_ai.dw_net_dev

//---------Begin Added by (Appeon)Harry 11.28.2014 for BugH091702--------
long ll_findrow
datastore	lds_save_for_pt
Long ll_rec_id
long ll_insertrow
long li_app_audit_facility
long li_ver_facility
String ls_user
Long li_default_user
ll_findrow = dw_orgs_facilities.find("parent_facility_id=" + string(ll_fac), 1, dw_orgs_facilities.rowcount())
if ll_findrow <= 0 then
	lds_save_for_pt = create datastore
	lds_save_for_pt.dataobject = 'd_pd_affil_stat_save_for_pt'
	lds_save_for_pt.settransobject( sqlca)
	ls_user =  'PUBLIC'
	if gs_cust_type = "I" then
		li_app_audit_facility = 1   
		li_ver_facility = 1
	else
		 SELECT  facility.default_audit_temp, facility.default_verif_facility,facility.default_user  
		 INTO :li_app_audit_facility, :li_ver_facility, :li_default_user
   		 FROM facility  
		 WHERE facility_id = :ll_fac;
		 if li_default_user = 1 then ls_user = gs_user_id
	end if
	ll_rec_id = gnv_app.of_Get_Id("RECORD_ID", 1) 
	ll_insertrow = lds_save_for_pt.insertrow(0)
	lds_save_for_pt.object.rec_id[ll_insertrow] = ll_rec_id
	lds_save_for_pt.object.prac_id[ll_insertrow] = il_prac_id
	lds_save_for_pt.object.parent_facility_id[ll_insertrow] = ll_fac
	lds_save_for_pt.object.seq_no[ll_insertrow] = 1
	lds_save_for_pt.object.apptmnt_type[ll_insertrow] = 'I'
	lds_save_for_pt.object.active_status[ll_insertrow] = 1
	lds_save_for_pt.object.verifying_facility[ll_insertrow] = li_ver_facility
	lds_save_for_pt.object.application_audit_facility[ll_insertrow] = li_app_audit_facility
	lds_save_for_pt.object.priority[ll_insertrow] = 1
	lds_save_for_pt.object.priority_user[ll_insertrow] = ls_user 
	lds_save_for_pt.object.affiliation_status[ll_insertrow] = 'M'
	if lds_save_for_pt.update() = 1 then
		Commit;
	end if
	
	destroy lds_save_for_pt
end if
//---------End Added ------------------------------------------------------

for r = 1 to ldw_actions.rowcount()
	ldw_actions.setitem(r,"facility_id", ll_fac)
next

if  tab_1.tabpage_ai.dw_tracking.rowcount() > 0 then
	for r = 1 to  tab_1.tabpage_ai.dw_tracking.rowcount()
		 tab_1.tabpage_ai.dw_tracking.setitem(r,"facility_id", ll_fac)
	next
else
	update pd_appl_tracking set facility_id = :ll_fac where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	commit using sqlca;
end if

for r = 1 to tab_1.tabpage_ids.dw_ids.rowcount()
	if not isnull(tab_1.tabpage_ids.dw_ids.getitemnumber(r,"rec_id")) then
		tab_1.tabpage_ids.dw_ids.setitem(r,"facility_id", ll_fac)
	end if
next



return 1

end function

public function integer of_set_par_status ();//Moved from the tab_1.tabpage_ai.dw_tracking.itemchanged() and modified for BugL082201 - alfee 09.26.2012
long ll_app
long ll_fac
long ll_prac
long ll_find
long ll_row
long ll_loc
integer li_stat
string ls_find

ll_row = tab_1.tabpage_ai.dw_tracking.getrow()
if ll_row < 1 then return 0

tab_1.tabpage_ai.dw_tracking.AcceptText()
ll_prac = tab_1.tabpage_ai.dw_tracking.getitemnumber( ll_row,"prac_id") 
ll_app = tab_1.tabpage_ai.dw_tracking.getitemnumber( ll_row,"app_id") 
ll_fac = tab_1.tabpage_ai.dw_tracking.getitemnumber( ll_row,"facility_id") 
li_stat =  tab_1.tabpage_ai.dw_tracking.getitemnumber( ll_row,"par_status") 
//Start Code Change ----05.29.2014 #V14.2 maha
ll_loc = tab_1.tabpage_ai.dw_tracking.getitemnumber( ll_row,"gp_id")  
ls_find = "prac_id = " + string(ll_prac) + " and app_id = " + string(ll_app) + " and parent_facility_id = " + string(ll_fac) + " and gp_id = " + string(ll_loc)  //05.29.2014 - added loc
//End Code Change ----05.29.2014
ll_find = dw_orgs_facilities.find( ls_find, 1, dw_orgs_facilities.rowcount())
if ll_find > 0 then 
	dw_orgs_facilities.setitem(ll_find,"pd_appl_tracking_par_status",li_stat)
end if

return 1
end function

public function integer of_refresh_dddw ();//$<add> 01.29.2013 By:long.zhang
//$<reason>refresh dddw after Modify datawindow protect property Bug 3394
//$ return type Integer

DataWindowChild dwchild

gnv_appeondb.of_startqueue( )

tab_1.tabpage_ai.dw_net_dev.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

tab_1.tabpage_ai.dw_net_dev.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

tab_1.tabpage_report.dw_report_data.GetChild( "app_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )	

tab_1.tabpage_report.dw_report_data.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

tab_1.tabpage_report.dw_report_data.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

tab_1.tabpage_report.dw_report_data.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")


tab_1.tabpage_ids.dw_ids.GetChild( "plan_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Plan Type")

//added tier field to net_dev_ids   -   12/16/02
tab_1.tabpage_ids.dw_ids.GetChild( "Tier", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Tier")

//Start Code Change ----06.07.2013 #V14 maha
tab_1.tabpage_ids.dw_ids.GetChild( "address_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(il_prac_id )

gnv_appeondb.of_commitqueue( )


return 1
end function

public function integer of_imp_appfile (integer al_row, datawindow adw_net_dev, string as_type);//====================================================================
//$<Function>: of_imp_appfile
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.15.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long	ll_rec_id,ll_prac_id,ll_app_id
long  ll_map_type, ll_action_type, ll_action_status
long  ll_incomplete, ll_type_code
integer li_data = 0  //maha 05.04.2016
integer li_return  //maha 05.17.2016
string ls_action_type, ls_action_status
string ls_type
str_parm lstr_img
 
ll_rec_id = adw_net_dev.GetItemNumber(al_row,"rec_id")
ll_prac_id = adw_net_dev.GetItemNumber(al_row,"prac_id")
ll_app_id = adw_net_dev.GetItemNumber(al_row,"app_id")
if isnull(ll_rec_id) or isnull(ll_prac_id) then 
	messagebox("Prompt","Please save the record before Uploading Application File!")
	return 1
end if
 
ll_action_type = adw_net_dev.GetItemNumber(al_row,"action_type")
ll_action_status = adw_net_dev.GetItemNumber(al_row,"action_status")
if adw_net_dev.GetItemNumber(al_row,"data_len") > 0 then li_data = 1  //Start Code Change ----05.04.2016 #V15 maha
gnv_appeondb.of_startqueue()
select code into :ls_action_type from code_lookup where lookup_name = 'Action Type' and lookup_code = :ll_action_type;
select code into :ls_action_status from code_lookup where lookup_name = 'Action Status' and lookup_code = :ll_action_status;
select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id;		
gnv_appeondb.of_commitqueue()	

if ll_map_type = 1 then  //Start Code Change ----10.15.2013 #V14 maha - changed from 2
	lstr_img.l_wf_id = ll_app_id
	lstr_img.l_doc_id = ll_rec_id
	lstr_img.l_ctx_id = ll_prac_id
//Start Code Change ----01.27.2015 #V14.2 maha	- modified to allow upload to completed actions
//	if ls_action_status = 'Incomplete' and ls_action_type = 'App Mail Payor' then
//	if ls_action_status = 'Incomplete'  then //changed to allow any action

 //Start Code Change ----05.04.2016 #V15 maha - added option so preview can be hidden
	if li_data = 1 then
		ls_type = 'Exist'
	else
		ls_type = 'New'
	end if
	
	lstr_img.s_type = ls_type
 //End Code Change ----05.04.2016
//	else
	//	if as_type = 'add' then return 1
//		lstr_img.s_type = 'Old'
//	end if
//End Code Change ----01.27.2015 

	openwithparm(w_app_imgfile, lstr_img)
//Start Code Change ----05.17.2016 #V152 maha
	li_return = message.doubleparm
end if

if  ls_type  = 'Exist' then
	li_return = -1
else
	//use return value
end if

return li_return
//End Code Change ----05.17.2016
end function

public function integer of_email_payor_complete (u_dw adw_net_dev, long al_row);//====================================================================
//$<Function>: of_email_payor_complete
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.20.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer li_skip
integer li_days
integer li_ans
integer li_nr
long ll_rec_id
long ll_rec
long ll_find
long ll_prac
long ll_facid
long ll_app_id
long ll_new_app_id
long ll_action_status
long li_row
long ll_complete
long ll_action_type
long ll_next
long ll_loc_id //maha 06.04.2014
Long ll_dept
string ls_this
string ls_find
date ld_due_date
datetime ldt_comp

ldt_comp = datetime(today(),now())

if al_row < 1 then Return 0

ll_complete = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Complete')")) 

//set completion values
adw_net_dev.setitem(al_row,"action_date", ldt_comp)
adw_net_dev.setitem(al_row,"action_status",ll_complete)
adw_net_dev.setitem(al_row,"action_user",gs_user_id)

//checkfor next step and create as required
ll_action_type =adw_net_dev.GetItemNumber(al_row,"action_type")
ls_this = gnv_data.of_getitem("app_steps","find step",string(ll_action_type)) //finds this step number

if ls_this = "0" then li_skip = 1
ll_next = long(gnv_data.of_getitem("app_steps","next step",ls_this)) //gets the next step number
if ll_next = 0 then  li_skip = 1
if li_skip = 0 then
	ll_prac =  adw_net_dev.getitemnumber(al_row,"prac_id")
	ll_facid = adw_net_dev.getitemnumber(al_row,"facility_id")	
	ll_app_id = adw_net_dev.getitemnumber(al_row,"app_id") 
	ll_loc_id = adw_net_dev.getitemnumber(al_row,"gp_id")  //Start Code Change ----06.04.2014 #V14.2 maha - mednax
	ll_dept = adw_net_dev.getitemnumber(al_row,"action_dept") //Added by Appeon long.zhang 03.15.2016 (for Alpha id 5041 - Email Payor not creating the next step  SAAS Build 03102016)
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.15.2016
	//<$>reason:add gp id to find, for Alpha id 5041 - Email Payor not creating the next step  SAAS Build 03102016
	//select count(rec_id) into :ll_find from net_dev_action_items where prac_id = :ll_prac and facility_id = :ll_facid and app_id = :ll_app_id and action_type = :ll_next and active_status = 1;
	if isnull(ll_loc_id) then 
		select count(rec_id) into :ll_find from net_dev_action_items where prac_id = :ll_prac and facility_id = :ll_facid and app_id = :ll_app_id and action_type = :ll_next and active_status = 1 and gp_id is null;
	else
		select count(rec_id) into :ll_find from net_dev_action_items where prac_id = :ll_prac and facility_id = :ll_facid and app_id = :ll_app_id and action_type = :ll_next and active_status = 1 and gp_id = :ll_loc_id ;
	end if
	//------------------- APPEON END -------------------		
	
	li_days = integer(gnv_data.of_getitem("app_steps","next days","lookup_code = " + string(ll_next))) 
	if li_days = 0 or isnull(li_days) then li_days = 30

	if ll_find = 0 then //item  does not exist
		if gnv_data.of_getitem("app_steps","auto_gen_next_step","")  = "1" then 
			li_ans = MessageBox( "Process step", "Would you like to add the next process step?", Question!, YesNo!, 1 )
		else //default is yes if not using message
			li_ans = 1
		end if
		if li_ans = 1 then
			ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Incomplete')"))
			li_nr = adw_net_dev.InsertRow( 0 )
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
			ld_due_date = RelativeDate(date( Today()), li_days )
			adw_net_dev.SetItem( li_nr, "rec_id", ll_rec_id )
			adw_net_dev.SetItem( li_nr, "prac_id",ll_prac)
			adw_net_dev.SetItem( li_nr, "seq_no", ll_rec_id )//Added by Appeon long.zhang 03.15.2016 (for Alpha id 5041 - Email Payor not creating the next step  SAAS Build 03102016)
			adw_net_dev.SetItem( li_nr, "action_type", ll_next)
			adw_net_dev.SetItem( li_nr, "action_user", gs_user_id )
			adw_net_dev.SetItem( li_nr, "action_status", ll_action_status ) //incomplete
			adw_net_dev.SetItem( li_nr, "facility_id",  ll_facid )
			adw_net_dev.SetItem( li_nr, "app_type", adw_net_dev.getitemstring(al_row,"app_type") )
			adw_net_dev.SetItem( li_nr, "app_id", ll_app_id ) 
			adw_net_dev.SetItem( li_nr, "due_date", ld_due_date )
			adw_net_dev.SetItem( li_nr, "active_status", 1 ) 
			adw_net_dev.SetItem( li_nr, "gp_id", ll_loc_id ) //Added by Appeon long.zhang 03.15.2016 (for Alpha id 5041 - Email Payor not creating the next step  SAAS Build 03102016)
			adw_net_dev.SetItem( li_nr, "action_dept", ll_dept )  //Added by Appeon long.zhang 03.15.2016 (for Alpha id 5041 - Email Payor not creating the next step  SAAS Build 03102016)
			adw_net_dev.SetItem( li_nr,"net_dev_action_items_create_date",datetime(today(),now()))
			adw_net_dev.SetItem( li_nr,"net_dev_action_items_create_user",gs_user_id)
		end if
	end if //not found
	
	adw_net_dev.accepttext()
	adw_net_dev.update()
	of_app_tracking_update(ll_prac,ll_facid,ll_app_id,integer(ls_this),ldt_comp,ll_loc_id)
end if //not skipped

return 1
end function

public function integer of_email_payor (u_dw adw_net_dev, string as_type);//====================================================================
//$<Function>: of_email_payor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.19.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row, ll_app_id, ll_map_type
long ll_rec_id, ll_prac_id, ll_action_type, ll_action_status
long ll_data_len, ll_rtn, ll_i, ll_cnt
long ll_email_id
long  ll_action_type_stan, ll_action_status_stan
long ll_selrow[]
integer li_export_id		
string ls_email, ls_filename
string ls_notetext, ls_subject, ls_emailcc
string ls_error[]  //maha 10.15.2013
boolean lb_first
gs_pass_ids  lg_pass_ids

gnv_appeondb.of_startqueue()
select lookup_code into :ll_action_type_stan from code_lookup where lookup_name = 'Action Type' and code = 'App Mail Payor';
select lookup_code into :ll_action_status_stan from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
gnv_appeondb.of_commitqueue()	

ll_i = 1
if as_type = 'Action' then	
	for ll_cnt = 1 to adw_net_dev.rowcount()
		if adw_net_dev.getitemnumber(ll_cnt , "selected") = 1 then
			ll_action_type = adw_net_dev.GetItemNumber(ll_cnt,"action_type")
			ll_action_status = adw_net_dev.GetItemNumber(ll_cnt,"action_status")
			if not(ll_action_type = ll_action_type_stan and ll_action_status = ll_action_status_stan) then continue	
			ll_selrow[ll_i] = ll_cnt
			ll_i += 1
		end if
	next
else		//prac folder
	for ll_cnt = 1 to adw_net_dev.rowcount()
		ll_action_type = adw_net_dev.GetItemNumber(ll_cnt,"action_type")
		ll_action_status = adw_net_dev.GetItemNumber(ll_cnt,"action_status")
		if not(ll_action_type = ll_action_type_stan and ll_action_status = ll_action_status_stan) then continue	
		ll_selrow[ll_i] =ll_cnt
		ll_i += 1
	next
end if
//debugbreak()
if upperbound(ll_selrow) < 1 then 
	ls_error[upperbound(ls_error) + 1] = "There are no Incomplete actions for App Mail Payor"  //Start Code Change ----10.15.2013 #V14 maha
	of_email_errors(ls_error)
	return -1
end if

lb_first = true
for ll_i = 1 to upperbound(ll_selrow)
	ll_row = ll_selrow[ll_i]
	if ll_row < 1 then 	return -1
	
	ll_rec_id = adw_net_dev.GetItemNumber(ll_row,"rec_id")
	ll_prac_id = adw_net_dev.GetItemNumber(ll_row,"prac_id")
	ll_app_id = adw_net_dev.GetItemNumber(ll_row,"app_id")
	
	ll_action_type = adw_net_dev.GetItemNumber(ll_row,"action_type")
	ll_action_status = adw_net_dev.GetItemNumber(ll_row,"action_status")
	
	gnv_appeondb.of_startqueue()
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.05.2014
	//<$>reason:add app_facility.email_address for Critical Bug 4337 
	//select mapping_type, email_address into :ll_map_type, :ls_email from app_hdr where app_id = :ll_app_id using sqlca;	
	select app_hdr.mapping_type, 
			email_address = (CASE RTRIM(ISNULL(app_hdr.email_address,'')) WHEN '' THEN  app_facility.email_address ELSE app_hdr.email_address END)
	 into :ll_map_type, :ls_email 
	from app_hdr,app_facility
	where app_hdr.app_id = :ll_app_id and ( app_hdr.facility_id = app_facility.facility_id )  using sqlca;	
	//------------------- APPEON END -------------------
	
	select file_name, Datalength(net_dev_action_images.image_data) into :ls_filename, :ll_data_len FROM net_dev_action_images
	  WHERE rec_id = :ll_rec_id AND prac_id = :ll_prac_id AND app_id = :ll_app_id using sqlca;	  
	gnv_appeondb.of_commitqueue()	
	
	//---------Begin Added by (Appeon)Stephen 12.01.2015 for BugA113001--------
	if IsNull(ls_filename) or Len(Trim(ls_filename))  < 1 then
		ls_filename = String(ll_rec_id) + "_" + String(ll_prac_id) + "_"  + String(ll_app_id) + ".tif"
	end if
	//---------End Added ------------------------------------------------------
	
	if isnull(ls_email) or ls_email = '' or ll_map_type <> 1 then  //Start Code Change ----10.15.2013 #V14 maha - changed from 2
		ls_error[upperbound(ls_error) + 1] = "There is no email address connected to the Payor for App_id: " + string(ll_app_id)   //Start Code Change ----10.15.2013 #V14 maha
		continue
	end if
	if ll_action_type = ll_action_type_stan and ll_action_status = ll_action_status_stan and ll_data_len > 0 then
		if isnull(ls_filename) or ls_filename = '' then 
			ls_error[upperbound(ls_error) + 1] = "There Image file the email for App Mail Payor"  //Start Code Change ----10.15.2013 #V14 maha
			continue
		end if
		
		SetPointer (HourGlass!)
		openwithparm( w_appeon_gifofwait, "Downloading Application file from Database..." )
		ls_filename = gs_temp_path + "Images\" + ls_filename
		ll_rtn = of_down_image(ll_rec_id, ll_prac_id, ll_app_id, ls_filename)
		SetPointer (Arrow!)
		IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)		
		if ll_rtn = -1 then return -1	
		
		if lb_first then
			OpenWithParm( w_fax_win, "Apps" + "-" + "Email")
			IF Message.StringParm = "Cancel" THEN
				Return -1
			END IF
			lg_pass_ids = Message.PowerObjectParm
		
			ls_notetext = lg_pass_ids.s_fax_message 
			ls_subject = lg_pass_ids.s_fax_subject	
			ls_emailcc = lg_pass_ids.s_stringval
			ll_email_id = lg_pass_ids.email_id
			
			select export_id into :li_export_id                    
				 from wf_email where email_id = :ll_email_id using sqlca;
			lb_first = false
		end if
			
		if of_send_email_payor(li_export_id, ll_prac_id, ls_email, ls_emailcc, ls_notetext, ls_filename, ls_subject, lg_pass_ids.b_attach) = -1 then return -1
		
		of_email_payor_complete(adw_net_dev, ll_row)
	else
		if ll_data_len = 0 then
			ls_error[upperbound(ls_error) + 1] = "There is no stored image data for the Application for emailing"  //Start Code Change ----10.15.2013 #V14 maha
		end if
	end if
next

if lb_first = false then
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.01.2014
	//<$>reason:a refresh issue by adding the next step to the bottom instead of the top
	//parent.triggerevent("pfc_cst_retrieve_detail")
	this.triggerevent("pfc_cst_retrieve_detail")
	//------------------- APPEON END -------------------
end if

if upperbound(ls_error) > 0 then  //Start Code Change ----10.15.2013 #V14 maha
	of_email_errors(ls_error)
end if

return 1
end function

public function integer of_send_email_payor (integer ai_export_id, long al_prac_id, string as_email, string as_emailcc, string as_notetext, string as_filename, string as_subject, blob ab_attach);//====================================================================
//$<Function>: 
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 09.16.2013 (V141 Email/Fax Applications to Payors)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_rtn
if  gi_email_type = 1 then //outlook
	n_cst_outlook lnv_Outlook
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return -1
	end if
	
	datastore lds_export
	pfc_n_cst_ai_export_apb lnv_export
	n_cst_word_utility lnv_word_outlook
	
	lnv_word_outlook = Create n_cst_word_utility
	lds_export = create datastore
	lnv_export = create pfc_n_cst_ai_export_apb
	
	if Not IsNull(ai_export_id) then 	
		if lnv_export.of_get_export_data(ai_export_id, al_prac_id, lds_export) = 1 then	
			if lds_export.rowcount() > 0 then	
				lnv_word_outlook.of_replace_export_text(as_notetext, al_prac_id, lds_export)	
				lnv_word_outlook.of_replace_export_text(as_subject, al_prac_id, lds_export)	//(Appeon)Harry 03.16.2015 - for Requesting new V14.2 Web Package - Bug # 4439 - Merge fields in subject are not populating
			end if
		end if
	end if
	
	destroy lnv_word_outlook
	destroy lds_export
	destroy lnv_export

	//added for Bug 4322 :long.zhang 12.03.2014
	do while Yield()
	loop

//	//------------------- APPEON BEGIN -------------------
//	//<$>added:long.zhang 12.02.2014
//	//<$>reason:show w_appeon_gifofwait for Bug 4322 
//	SetPointer (HourGlass!)
//	openwithparm( w_appeon_gifofwait, "Sending Email..." )
//	//------------------- APPEON END -------------------//
	
	ll_rtn = lnv_Outlook.of_Send(as_email, as_emailcc, "", as_subject, as_notetext, as_filename) 
	
//	//------------------- APPEON BEGIN -------------------
//	//<$>added:long.zhang 12.02.2014
//	//<$>reason:show w_appeon_gifofwait for Bug 4322 
//	SetPointer (Arrow!)
//	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)	
//	//------------------- APPEON END -------------------//		
	
	lnv_Outlook.of_Logoff()
	
	if ll_rtn <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if	
else
	n_cst_easymail_smtp lnv_mail	
	
	// Create Email object
	if lnv_mail.of_CreateObject() = -1 then
		f_show_message('create Email object','','','','')			
		Return -1
	end if
	
	Open(w_email_edit)
	w_email_edit.ole_word.of_Open(ab_attach)
	
	//merge mail
	n_cst_word_utility lnv_word
	lnv_word = Create n_cst_word_utility
	IF NOT IsNull(ai_export_id) THEN 
		//lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, al_prac_id, ai_export_id)  //Commented by (Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, as_subject, al_prac_id, ai_export_id) //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
	END IF
	Destroy lnv_word

	// Send email
	ll_rtn = lnv_Mail.of_SendHtml(gs_user_Id, as_email, as_emailcc,'', as_Subject, w_email_edit.ole_word, as_filename,True)	
	w_email_edit.ole_word.of_close()
	if isvalid(w_email_edit) then close(w_email_edit)
	if ll_rtn <> 0 then
		f_show_message('error_code_'+string(ll_rtn),'%1S%',String(ll_rtn),'','')
		lnv_mail.of_DeleteObject()
		Return -1
	end if
	lnv_mail.of_DeleteObject()
end if
end function

public function integer of_email_errors (string as_errors[]);//Start Code Change ----10.15.2013 #V14 maha - added
long ec
string ls_mess

for ec = 1 to upperbound(as_errors)
	if ec > 1 then ls_mess+= "~r"
	ls_mess+= as_errors[ec]
next

messagebox("Email Payor errors", "The following errors were generated email Applications:~r~r" + ls_mess)

return 1
	
end function

public function integer of_create_checklist (long al_temp, string as_app_type, long al_appt_stat_id, long al_parent);//Start Code Change ----03.17.2014 #V14.2 maha - copied from of_copy_required_data (appointment status) and modified for checklist creation

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
	idw_audit.SetItem( ll_insrow, "prac_id", il_prac_id )
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

public function integer of_out_to_md_ai (integer ai_facility_id, long ai_app_id, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type, boolean ab_complete);//Add an argument ai_rec_id which will replace the script 'll_rec_id = gnv_app.of_Get_Id("RECORD_ID")'
//change argument ai_rec_id from integer to long - alfee 03.19.2009

	Long ll_action_type
	Long ll_action_status
	Long ll_action_dept
	Long ll_rec_id
	String ls_action_notes
	String ls_app_type
	DateTime ldt_action_date
	Date ld_due_date
	
	datetime ldt_createdate //add Michael 06.24.2011 V11.3 Action Item Dates
	ldt_createdate = datetime(today(),now())//add Michael 06.24.2011 V11.3 Action Item Dates

	ld_due_date = Today()
	ls_app_type = as_apt_type  //Start Code Change ----04.25.2012 #V12 maha - mednax
	if isnull(al_loc) then al_loc = 0  //Start Code Change ----05.08.2014 #V14.2 maha
	

//Start Code Change ----05.06.2014 #V14.2 maha -mednax
if isnumber(as_action_type) then
	ll_action_type = long(as_action_type)
else
	ll_action_type=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = '"+upper(as_action_type)+"'"))
end if

//Start Code Change ----07.02.2014 #V14.2 maha
if ab_complete then
	ll_action_status=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION STATUS' and upper(code) = '"+upper('Complete')+"'"))	
else
	ll_action_status=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION STATUS' and upper(code) = '"+upper('Incomplete')+"'"))
end if
//End Code Change ----07.02.2014
	
ll_rec_id = ai_rec_id

SetNull( ldt_action_date )

	

//Start Code Change ----05.06.2014 #V14.2 maha - removed setting action department
	INSERT INTO net_dev_action_items  
   		    ( rec_id,   
	    	      prac_id,   
				   seq_no,
     	     	   action_type,   
			      action_date,   
//	    			action_dept,   
     	     	   action_user,   
		     	   next_action_date,   
			      notes,   
		     	   action_status,   
				   facility_id,
				   app_id,
				   app_type,
				   active_status,
					gp_id, //maha 05.05.2014 - location id
					create_date,//add Michael 06.24.2011 V11.3 Action Item Dates
					create_user, //add Michael 06.24.2011 V11.3 Action Item Dates
					due_date)  
	VALUES ( :ll_rec_id,   
     	      :il_prac_id,  
				:ll_rec_id,					
	    	   :ll_action_type,   
	     	   null,   
//				:ll_action_dept,   
	     		:is_assn_user,     //Start Code Change ----06.18.2014 #V14.2 maha - changed from gs_user_id   
				null,   
		     	'',   
			   :ll_action_status,   
	     		:ai_facility_id,
				:ai_app_id,
				:ls_app_type,
				1,
				:al_loc,
				:ldt_createdate,//add Michael 06.24.2011 V11.3 Action Item Dates
				:gs_user_id,//add Michael 06.24.2011 V11.3 Action Item Dates
				:ld_due_date)
 	USING SQLCA;
	//---------------------------- APPEON END ----------------------------

	IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
			Return -1
	END IF			
	
	RETURN 0

end function

public subroutine of_resize_manual ();//====================================================================
//$<Function>: of_resize_manual
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: risize dw_orgs_facilities menually
//$<Author>: (Appeon) long.zhang 10.17.2014
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long n
long w
userobject a_tab_page

a_tab_page = dw_orgs_facilities.GetParent()

n = dw_orgs_facilities.x + dw_orgs_facilities.width

w = tab_1.width
tab_1.x = n + 15

tab_1.width = a_tab_page.width - n - 20
w = tab_1.width

tab_1.tabpage_ai.dw_appoint_stat.width = w - 25

tab_1.tabpage_ai.dw_net_dev.width = w - 43

tab_1.tabpage_ai.dw_tracking.width = w - 43

cb_batch.width = dw_orgs_facilities.width
cb_ma.width = dw_orgs_facilities.width

//Added by Appeon long.zhang 11.20.2014
gb_filter_1.x = n+24
//gb_filter_1.width = tab_1.width - cb_track_recalc.width - 115

st_filter.x = gb_filter_1.x + 28
dw_qf.x = st_filter.x + st_filter.width - 9
st_group_by.x = dw_qf.x + dw_qf.width + 27
ddlb_group_by.x = st_group_by.x + st_group_by.width
st_zoom.x = ddlb_group_by.x + ddlb_group_by.width + 27
ddlb_zoom.x= st_zoom.x + st_zoom.width + 5
end subroutine

public function integer of_hide_fields (); //Start Code Change ----03.09.2015 #V15 maha
u_dw dw_actions
u_dw dw_tracking
long xpos

dw_actions = tab_1.tabpage_ai.dw_net_dev
dw_tracking = tab_1.tabpage_ai.dw_tracking

dw_actions.modify("gp_id.visible = false")
dw_actions.modify("gp_id_t.visible = false")
dw_tracking.modify("gp_id.visible = false")
dw_tracking.modify("t_location.visible = false")

if of_get_app_setting("set_40","I") = 4 then return 1 //Start Code Change ----05.13.2016 #V15 maha - for this option skip movement

////close up spaces
xpos = long(dw_actions.describe("app_id.x")) + long(dw_actions.describe("app_id.width")) + 100
dw_actions.modify("app_type.x = " + string(xpos)) 
dw_actions.modify("app_type_t.x = " + string(xpos))  
//dw_actions.modify("app_type_t.x = " + string(xpos -100))   //app type header moves over further to the left
xpos = xpos + long((dw_actions.describe("app_type.width"))) + 15
//dw_actions.modify("app_type_t.width = " + string(xpos - 85)) //recorrect the app_typ header
dw_actions.modify("action_dept.x = " + string(xpos))
dw_actions.modify("action_dept_t.x = " + string(xpos))
xpos = xpos + long((dw_actions.describe("action_dept.width"))) + 15

if gb_workflow then
	dw_actions.modify("net_dev_action_items_wf_id.x = " + string(xpos))
	dw_actions.modify("net_dev_action_items_wf_id_t.x = " + string(xpos))
	xpos = xpos + long((dw_actions.describe("net_dev_action_items_wf_id.width"))) + 15
else
	dw_actions.modify("net_dev_action_items_wf_id.visible = false")
	dw_actions.modify("net_dev_action_items_wf_id_t.visible = false")
//	xpos no change
end if

dw_actions.modify("net_dev_action_items_create_date.x = " + string(xpos))
dw_actions.modify("net_dev_action_items_create_date_t.x = " + string(xpos))
xpos = xpos + long((dw_actions.describe("net_dev_action_items_create_date.width"))) + 15	
dw_actions.modify("net_dev_action_items_create_user.x = " + string(xpos))
dw_actions.modify("net_dev_action_items_create_user_t.x = " + string(xpos))	
xpos = xpos + long((dw_actions.describe("net_dev_action_items_create_user.width"))) + 15
dw_actions.modify("net_dev_action_items_mod_date.x = " + string(xpos))
dw_actions.modify("net_dev_action_items_mod_date_t.x = " + string(xpos))	
xpos = xpos + long((dw_actions.describe("net_dev_action_items_mod_date.width"))) + 15
dw_actions.modify("net_dev_action_items_mod_user.x = " + string(xpos))
dw_actions.modify("net_dev_action_items_mod_user_t.x = " + string(xpos))	




return 1
end function

public function string of_down_notes (long al_rec_id);//====================================================================
//$<Function>: of_down_notes
//$<Arguments>:
// 	value    long    al_rec_id
//$<Return>:  string
//$<Description>: Download text for notes. Only PB client use it.
//$<Author>: (Appeon) long.zhang 04.17.2015 Bug 4484 for Case # 00053251: Maximum Length on Application Notes 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_Notes =''
string ls_data
string ls_all_data
Long ll_data_length
Long ll_start
Int li_loops
Int li_counter

SetPointer(HourGlass!)

IF appeongetclienttype() <> 'PB' Then return ''
	
// Open processs window
openwithparm( w_appeon_gifofwait, "Refreshing Notes from Database..." )

// Get file data from database
SELECT Datalength(notes)
INTO :ll_data_length
FROM net_dev_action_items
WHERE rec_id = :al_rec_id
USING SQLCA;

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	// Close process window
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	MessageBox("File Creation Error", "No Notes in database. ")
	RETURN ''
END IF

IF ll_data_length > 8000 THEN 
	 IF Mod(ll_data_length,8000) = 0 THEN 
		  li_loops = ll_data_length/8000 
	 ELSE 
		  li_loops = (ll_data_length/8000) + 1 
	 END IF 
ELSE 
	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	Yield()
	SetPointer(HourGlass!)
	
	ll_start = (li_counter - 1) * 8000 + 1
	SELECT substring(notes,:ll_start,8000)
	INTO :ls_data
	FROM net_dev_action_items
	WHERE rec_id = :al_rec_id
	USING SQLCA;

	ls_all_data += ls_data
NEXT 

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return ''
Else
	Return ls_all_data
END IF
end function

public function integer of_hide_tracking_fields (); //Start Code Change ----08.13.2015 #V15 maha
n_ds lds_data
u_dw ldw_detail
integer r
string ls_field
string ls_label
integer li_hide
boolean lb_created_data = false

ldw_detail = tab_1.tabpage_ai.dw_tracking

if isvalid(w_group_practice) then
	lds_data = w_group_practice.ids_datastore
else
	lds_data =  create n_ds
	lds_data.dataobject = "d_appl_tracker_fields_setup"
	lds_data.settransobject(sqlca)
	lds_data.retrieve()
	lb_created_data = true
end if	

for r = 1 to lds_data.rowcount()
	ls_field = lds_data.getitemstring(r,"field_name")
	ls_label = lds_data.getitemstring(r,"field_name_allias")
	li_hide = lds_data.getitemnumber(r,"use_validation")
	ldw_detail.Modify( ls_field + "_t.text = '" + ls_label + "'")	
	if li_hide = 1 then
		ldw_detail.Modify( ls_field + "_t.visible = '0'")	
		ldw_detail.Modify( ls_field + ".visible = '0'")	
	end if
next

if lb_created_data then destroy lds_data

return 1
end function

public function integer of_set_tree_level (string as_level); //Start Code Change ----08.18.2015 #V15 maha
if as_level = "tree.level.1" then 
	is_tree_level = "1"
elseif as_level = "tree.level.2" then 
	is_tree_level = "2"
elseif as_level = "detail" then 
	is_tree_level = "D"
end if

return 1
end function

public function integer of_goto_app (long al_fac, long al_loc, integer al_app); //Start Code Change ----08.25.2015 #V15 maha
long f
long r
string s
//messagebox("of_goto_app", "" ) //Comment by Appeon long.zhang 12.14.2015 (BugL120103)
if gi_intelliapp_type = 0 then
	messagebox("Not supported","This function is not supported for the current setting on the APPLICATION SETTING TREEVIEW SETTING in Application Settings")
	return 1
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.30.2015
//<$>reason:al_loc may be null and app_id may be 0. BugL123004.
//s = "parent_facility_id = " + string(al_fac) +  " and gp_id = " + string(al_loc) +  " and app_id = " + string(al_app)
s = "parent_facility_id = " + string(al_fac) 

If isNull(al_loc) Then al_loc = -1 //All

If  al_loc <> - 1 Then
	s +=  " and gp_id = " + string(al_loc)
End If

If al_app > 0 Then
	s +=  " and app_id = " + string(al_app)
End If
//------------------- APPEON END -------------------

//messagebox("of_goto_app", s )
f = dw_orgs_facilities.find( s  , 1, dw_orgs_facilities.rowcount())
if f < 0 then
	messagebox("of_goto_app","Find function failed.~r~r" + s )
elseif f > 0 then
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.23.2015
	//<$>reason:Use the existing function of_refresh_data() to open specifid application, BugL120202.		
//	r = dw_orgs_facilities.getrow()
//	dw_orgs_facilities.SelectRow( r, False )
//	dw_orgs_facilities.collapseall()
//	dw_orgs_facilities.expand(f, 1)
//	dw_orgs_facilities.expand(f, 2)
//	dw_orgs_facilities.SelectRow( 0, False )
//	dw_orgs_facilities.SelectRow( f, True )
//	dw_orgs_facilities.ScrollToRow( f )
//	dw_orgs_facilities.setrow(f)
//	dw_orgs_facilities.setfocus()
	ii_facility_id = al_fac
	il_app_id = al_app
	il_loc_id = al_loc
	of_refresh_data()
	//------------------- APPEON END -------------------	
	
end if



return 1
end function

public function integer of_check_tracking_id (); //Start Code Change ----09.04.2015 #V15 maha - added - called from treenodeselected and pfc_preupdate.

integer r

if il_track_id = 0 then return 1

for r = 1 to tab_1.tabpage_ai.dw_net_dev.rowcount( )
	if  isnull(tab_1.tabpage_ai.dw_net_dev.getitemnumber(r, "track_id")) then
		 tab_1.tabpage_ai.dw_net_dev.setitem(r, "track_id", il_track_id)
	end if
next

return 1
end function

public function long of_retrieve_detail_retry ();//Start Code Change ----09.04.2015 #V15 maha
//called from of_retrieve_detail when retrieve by track id returns no data
long r
string ls_sql
string ls_id
string ls_action_status
string ls_rtn
integer li_res

ls_sql = is_sql

IF ii_facility_id > 0 THEN ls_sql += " AND ( net_dev_action_items.facility_id = " + String( ii_facility_id ) + ")"
IF il_app_id > 0 THEN ls_sql += " AND ( net_dev_action_items.app_id = " + String( il_app_id )  + ")"
IF IsNull(il_app_id) THEN ls_sql += " AND ( net_dev_action_items.app_id is null "  + ")"

IF il_loc_id >= 0 THEN 
	ls_sql += " AND ( net_dev_action_items.gp_id = " + String( il_loc_id ) + ")"
ElseIF IsNull(il_loc_id) THEN 
	ls_sql += " AND ( net_dev_action_items.gp_id is null "  + ")"
else // -1 don't include gpid in query
	//ls_sql += " AND ( net_dev_action_items.gp_id = 0 " + ")"
end if

IF lb_from_prac_folder THEN //from Practitioner Appl. Status
	ls_sql = ls_sql + " AND ( net_dev_action_items.prac_id = " + String( il_prac_id )  + ")"
	IF ii_facility_id > 0 THEN
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '0'" )
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '0'" )			
	ELSE
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '56'" )
		tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '2583'" )		
	END IF	
END IF

 //Start Code Change ----08.03.2015 #V15 maha - added for ai filter
If is_user_id <> "All" then   //Start Code Change ----08.03.2015 #V15 maha
	ls_sql += " AND net_dev_action_items.action_user = '" + String( is_user_id ) + "'"
End if
 //End Code Change ----08.03.2015	

ls_id = gnv_data.of_getitem("code_lookup" ,"lookup_code","upper(code)=upper('Pending') and upper(lookup_name)=upper('Action Status')")
if not(isnull(ls_id) or ls_id = "") then
	ls_action_status = ls_id
end if
ls_id = ""
ls_id = gnv_data.of_getitem("code_lookup" ,"lookup_code","upper(code)=upper('InComplete') and upper(lookup_name)=upper('Action Status')")
if not(isnull(ls_id) or ls_id = "") then
	if isnull(ls_action_status) or ls_action_status="" then
		ls_action_status = ls_id
	else
		ls_action_status +="," + ls_id
	end if
end if

if not ib_cbx_compl_checked then 
	if not(isnull(ls_action_status) or ls_action_status = "") then
		ls_sql += " AND net_dev_action_items.action_status in ("+ls_action_status +")" 
	end if
end if


li_res = tab_1.tabpage_ai.dw_net_dev.setsqlselect( ls_sql)
 
IF li_res < 0 then	
	MessageBox("dw_net_dev - modify select failed",ls_rtn)
	//Clipboard(ls_rtn)
end if	

tab_1.tabpage_ai.dw_net_dev.Modify("DataWindow.Table.UpdateTable='net_dev_action_items'")		

tab_1.tabpage_ai.dw_net_dev.SetRedraw(false)
tab_1.tabpage_ai.dw_net_dev.SetTransObject( SQLCA )

r = tab_1.tabpage_ai.dw_net_dev.retrieve()

return r
end function

public function integer of_filter_from_grid (long al_type); //Start Code Change ----12.18.2015 #V15 maha
string ls_filter

//dw_orgs_facilities.CollapseAll()
//dw_orgs_facilities.selecttreenode( 1, 1, true)
////dw_orgs_facilities.setrow(1)
////dw_orgs_facilities.selectrow(0,false)
////dw_orgs_facilities.selectrow(1, true)
//
//li_act = message.longparm
//messagebox("long parm",li_act)
//li_act = message.wordparm
//messagebox("word parm",li_act)
//
//ls_filter = "net_dev_action_items.action_type = " + string(li_act)
//i = tab_1.tabpage_ai.dw_net_dev.setfilter(ls_filter)
//tab_1.tabpage_ai.dw_net_dev.filter()

dw_orgs_facilities.setrow(1)
dw_orgs_facilities.triggerevent(clicked!)
ls_filter = "action_type = " + string(al_type)
tab_1.tabpage_ai.dw_net_dev.setfilter(ls_filter)
tab_1.tabpage_ai.dw_net_dev.filter()

return 1


end function

public function integer of_post_resize ();//Start Code Change ----02.04.2016 #V15 maha
integer li_y

li_y = dw_orgs_facilities.y + dw_orgs_facilities.height -148

tab_1.y =  dw_orgs_facilities.y
tab_1.height =  dw_orgs_facilities.height

tab_1.tabpage_ai.dw_net_dev.y = tab_1.tabpage_ai.dw_appoint_stat.y + tab_1.tabpage_ai.dw_appoint_stat.height + 4
tab_1.tabpage_ai.dw_tracking.y = tab_1.height - tab_1.tabpage_ai.dw_tracking.height - 108
tab_1.tabpage_ai.dw_net_dev.height = tab_1.tabpage_ai.dw_tracking.y -tab_1.tabpage_ai.dw_net_dev.y - 8
tab_1.tabpage_ai.dw_net_dev.width =  tab_1.tabpage_ai.dw_tracking.width 

tab_1.tabpage_ids.dw_ids.height = tab_1.height - 124
tab_1.tabpage_ids.dw_ids.width = tab_1.tabpage_ai.dw_net_dev.width
tab_1.tabpage_notes.dw_notes.height = tab_1.height - 124
tab_1.tabpage_notes.dw_notes.width = tab_1.tabpage_ai.dw_net_dev.width
tab_1.tabpage_report.dw_report_data.height = tab_1.height - tab_1.tabpage_report.dw_report_data.y - 128
tab_1.tabpage_report.dw_report_data.width  = tab_1.tabpage_ai.dw_net_dev.width


of_resize_manual() //Added by Appeon long.zhang 04.15.2016 (Issues with V15 Build 4/13/16)

return 1
end function

public function integer of_app_view_load (long al_row, datawindow adw_net_dev, long al_type, string as_file);//Start Code Change ----05.17.2016 #V152 maha
long	ll_rec_id,ll_prac_id,ll_app_id
long  ll_map_type, ll_action_type, ll_action_status
long  ll_incomplete, ll_type_code
integer li_data = 0  //maha 05.04.2016
integer li_return  //maha 05.17.2016
string ls_action_type, ls_action_status
string ls_type
str_parm lstr_img
 
ll_rec_id = adw_net_dev.GetItemNumber(al_row,"rec_id")
ll_prac_id = adw_net_dev.GetItemNumber(al_row,"prac_id")
ll_app_id = adw_net_dev.GetItemNumber(al_row,"app_id")
if isnull(ll_rec_id) or isnull(ll_prac_id) then 
	messagebox("Prompt","Please save the record before Uploading Application File!")
	return 1
end if
 
ll_action_type = adw_net_dev.GetItemNumber(al_row,"action_type")
ll_action_status = adw_net_dev.GetItemNumber(al_row,"action_status")
if adw_net_dev.GetItemNumber(al_row,"data_len") > 0 then li_data = 1  //Start Code Change ----05.04.2016 #V15 maha
gnv_appeondb.of_startqueue()
select code into :ls_action_type from code_lookup where lookup_name = 'Action Type' and lookup_code = :ll_action_type;
select code into :ls_action_status from code_lookup where lookup_name = 'Action Status' and lookup_code = :ll_action_status;
select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id;		
gnv_appeondb.of_commitqueue()	

if ll_map_type = 1 then 
	lstr_img.l_wf_id = ll_app_id
	lstr_img.l_doc_id = ll_rec_id
	lstr_img.l_ctx_id = ll_prac_id

	if li_data = 1 then
		ls_type = 'Exist'
	else
		ls_type = 'New'
	end if
	
	lstr_img.s_type = ls_type
	lstr_img.s_module = as_file

	openwithparm(w_app_imgfile, lstr_img)

	li_return = message.doubleparm
end if

if  ls_type  = 'Exist' then
	li_return = -1
else
	//use return value
end if


return li_return
end function

on pfc_ia_cst_nv_net_dev_new_maha152.create
int iCurrent
call super::create
this.gb_filter_1=create gb_filter_1
this.cb_ma=create cb_ma
this.dw_payors=create dw_payors
this.st_as_msg=create st_as_msg
this.dw_facility_add=create dw_facility_add
this.cb_batch=create cb_batch
this.p_1=create p_1
this.cbx_compl=create cbx_compl
this.cb_change=create cb_change
this.st_filter=create st_filter
this.dw_qf=create dw_qf
this.st_group_by=create st_group_by
this.ddlb_group_by=create ddlb_group_by
this.st_zoom=create st_zoom
this.ddlb_zoom=create ddlb_zoom
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_filter_1
this.Control[iCurrent+2]=this.cb_ma
this.Control[iCurrent+3]=this.dw_payors
this.Control[iCurrent+4]=this.st_as_msg
this.Control[iCurrent+5]=this.dw_facility_add
this.Control[iCurrent+6]=this.cb_batch
this.Control[iCurrent+7]=this.p_1
this.Control[iCurrent+8]=this.cbx_compl
this.Control[iCurrent+9]=this.cb_change
this.Control[iCurrent+10]=this.st_filter
this.Control[iCurrent+11]=this.dw_qf
this.Control[iCurrent+12]=this.st_group_by
this.Control[iCurrent+13]=this.ddlb_group_by
this.Control[iCurrent+14]=this.st_zoom
this.Control[iCurrent+15]=this.ddlb_zoom
this.Control[iCurrent+16]=this.cb_3
end on

on pfc_ia_cst_nv_net_dev_new_maha152.destroy
call super::destroy
destroy(this.gb_filter_1)
destroy(this.cb_ma)
destroy(this.dw_payors)
destroy(this.st_as_msg)
destroy(this.dw_facility_add)
destroy(this.cb_batch)
destroy(this.p_1)
destroy(this.cbx_compl)
destroy(this.cb_change)
destroy(this.st_filter)
destroy(this.dw_qf)
destroy(this.st_group_by)
destroy(this.ddlb_group_by)
destroy(this.st_zoom)
destroy(this.ddlb_zoom)
destroy(this.cb_3)
end on

event constructor;call super::constructor;
inv_data_entry = CREATE pfc_cst_nv_data_entry_functions //maha 011306

lb_from_prac_folder = True

//-------Begin Added by alfee 07.25.2011 ----------------------
//<$Reason>allow use of old format dw
if of_get_app_setting("set_40","I") = 4 then
	tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items_no_group"
end if
//-------End Added ------------------------------------------------

//--------Begin Modified by alfee 09.15.2010 --------------------
//SK Practitioner Folder
if gb_sk_ver then dw_orgs_facilities.Height += cb_ma.height + 8
dw_payors.visible = False

if tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items_sk" or tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items_ai_sk" then
	tab_1.tabpage_ai.dw_net_dev.hscrollbar = true
end if	

//Start Code Change ----05.13.2016 #V15 maha - separated the two functions 
if of_get_app_setting("set_40","I") = 4 then
	tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items_no_group"
end if

//else
	 //Start Code Change ----03.09.2015 #V15 maha - added for two level exception
choose case gi_intelliapp_type
	case 0,3
		of_hide_fields()		
end choose
	 //End Code Change ----03.09.2015 
//end if
//End Code Change ----05.13.2016

tab_1.tabpage_ai.dw_tracking.of_SetDropDownCalendar( TRUE )   //Start Code Change ----08.13.2015 #V15 maha







////Start Code Change ----03.25.2008 #V8 maha - removed code for cb_ma
//CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		//dw_orgs_facilities.Title = "Add Payor / Hospital" //Delete by Evan 09/19/2008
//		//cb_1.Text = "Add Payor / Hospital"
//		dw_orgs_facilities.Height = 1470 //1560 //Start Code Change ----04.16.2008 #V8 maha
//		dw_payors.Visible = False
//		//MULTI SITE GROUP
//	CASE 1
//		//dw_orgs_facilities.Title = "Group" //Delete by Evan 09/19/2008
//		//cb_1.Text = "Add Payor / Hospital"	
//		dw_orgs_facilities.Height = 696	
//		//BILLING COMPANY
//	CASE 2
//		//dw_orgs_facilities.Title = "Client" //Delete by Evan 09/19/2008
//		//cb_1.Text = "Add Payor / Hospital"			
//		dw_orgs_facilities.Height = 696	
//END CHOOSE
////End Code Change---03.25.2008
//---------End Modified -----------------------------------------

//Start Code Change ----06.24.2010 V10 maha
if gb_sk_ver then 
	cb_batch.y = cb_ma.y
	cb_ma.visible = false  //Start Code Change ----03.29.2012 #V12 maha
	//dw_orgs_facilities.Height = 696 - (SK Practitioner Folder) commented by alfee 09.15.2010
	tab_1.tabpage_ai.dw_appoint_stat.dataobject = "d_pd_affil_status_sk"
	tab_1.tabpage_ai.dw_appoint_stat.settransobject(sqlca)
	tab_1.tabpage_ai.dw_appoint_stat.height = 102
	tab_1.tabpage_ai.dw_net_dev.y -= 150	
	tab_1.tabpage_ai.dw_net_dev.height += 150
	//-------Begin Commented by alfee 07.25.2011-------------
	//tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items_sk"
	//tab_1.tabpage_ai.dw_net_dev.settransobject(sqlca)
	//tab_1.tabpage_ai.dw_net_dev.hscrollbar = true
	//-------End Commented -------------------------------------
end if
//End Code Change---06.24.2010

 //Start Code Change ----09.17.2015 #V15 maha - modified logic
//Start Code Change ----06.12.2013 #V14 maha
//if of_get_app_setting("set_74","I") = 1 then
//	ib_show_ids_addr = true
//end if
choose case gi_intelliapp_type
	case 0,3
		if of_get_app_setting("set_74","I") = 1 then  //1 & 2 level only
			ib_show_ids_addr = true
		end if
	case else  //3 level
		ib_show_ids_addr = true
end choose
 //End Code Change ----09.17.2015

end event

event destructor;call super::destructor;destroy inv_data_entry //maha 011306

if IsValid(ids_spec_link) then
	Destroy ids_spec_link
end if

if IsValid(ids_all_spec) then
	Destroy ids_all_spec
end if

if IsValid(ids_address_link) then
	Destroy ids_address_link
end if

if IsValid(ids_all_addresses) then
	Destroy ids_all_addresses
end if

if IsValid(ids_hosp_link) then
	Destroy ids_hosp_link
end if

if IsValid(ids_all_hosp) then
	Destroy ids_all_hosp
end if

if IsValid(ids_cred_comms) then
	Destroy ids_cred_comms
end if

if IsValid(ids_cred_committees) then
	Destroy ids_cred_committees
end if

if IsValid(ids_address_linked) then
	Destroy ids_address_linked
end if

end event

event pfc_cst_retrieve_detail;call super::pfc_cst_retrieve_detail;//Retreve detail (SK Practitioner Folder - alfee 09.15.2010)
IF gi_intelliapp_type > 0 THEN //non single group
	RETURN of_retrieve_detail()
ELSE  //single group
	RETURN of_retrieve_detail(ii_facility_id)
END IF

RETURN 1
end event

type tab_1 from pfc_cst_nv_net_dev_prac_folder`tab_1 within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 992
integer y = 232
integer width = 3511
integer height = 1760
integer taborder = 40
string facename = "Segoe UI"
tabposition tabposition = tabsontop!
tabpage_ar tabpage_ar
end type

event tab_1::selectionchanged;call super::selectionchanged;dw_qf.Enabled = True
dw_qf.Modify("quick_filter.protect=0") //Add by Even 05.18.2009 --- Corrected BugS030405
ddlb_group_by.Enabled = True
dw_payors.Enabled = True
dw_orgs_facilities.Enabled = True
tab_1.tabpage_report.gb_filter_2.Text = "Filter"

//changed to ACTION
//tab_1.tabpage_ai.gb_filter_1.Visible = False
tab_1.tabpage_report.gb_filter_2.Visible = False
IF newindex = 1 THEN
//	tab_1.tabpage_ai.gb_filter_1.Visible = True
	//gb_filter.Visible = True
	st_filter.Visible = True
	dw_qf.Visible = True
	st_group_by.Visible = False
	ddlb_group_by.Visible = False
	st_zoom.Visible = False
	ddlb_zoom.Visible = False
//	cb_track_recalc.visible = true  //Start Code Change ----05.08.2014 #V14.2 maha  maha - removed 02.09.2016
//changed to REPORTS
ELSEIF newindex = 4 THEN
	//tab_1.tabpage_report.gb_filter_2.Visible = True	 //Start Code Change ----02.04.2016 #V15 maha - removed
	st_filter.Visible = True
	st_group_by.Visible = True
	dw_qf.Visible = True
	ddlb_group_by.Visible = True	
	st_zoom.Visible = True
	ddlb_zoom.Visible = True
//	cb_track_recalc.visible = false //Added by Appeon long.zhang 11.20.2014
	IF tab_1.tabpage_report.rb_par.Checked OR tab_1.tabpage_report.rb_par_sum.Checked THEN
		dw_qf.Enabled = False
		dw_qf.Modify("quick_filter.protect=1") //Add by Even 05.18.2009 --- Corrected BugS030405
		ddlb_group_by.Enabled = False
		//dw_payors.Enabled = False //Start Code Change ----11.10.2008 #V85 maha - removed to allow changing from reports
		//dw_orgs_facilities.Enabled = False
		tab_1.tabpage_report.gb_filter_2.Text = "Filters do not work for selected report"
	END IF
ELSE
	st_filter.Visible = False
	st_group_by.Visible = False
	dw_qf.Visible = False
	ddlb_group_by.Visible = False	
	st_zoom.Visible = False
	ddlb_zoom.Visible = False	
	//cb_track_recalc.visible = false //Added by Appeon long.zhang 11.20.2014
END IF



end event

on tab_1.create
this.tabpage_ar=create tabpage_ar
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_ar
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_ar)
end on

type tabpage_ai from pfc_cst_nv_net_dev_prac_folder`tabpage_ai within tab_1
integer y = 100
integer width = 3474
integer height = 1644
boolean border = true
long backcolor = 33551856
string picturename = ""
long picturemaskcolor = 12632256
dw_appoint_stat dw_appoint_stat
dw_tracking dw_tracking
end type

on tabpage_ai.create
this.dw_appoint_stat=create dw_appoint_stat
this.dw_tracking=create dw_tracking
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_appoint_stat
this.Control[iCurrent+2]=this.dw_tracking
end on

on tabpage_ai.destroy
call super::destroy
destroy(this.dw_appoint_stat)
destroy(this.dw_tracking)
end on

type dw_net_dev from pfc_cst_nv_net_dev_prac_folder`dw_net_dev within tabpage_ai
event ue_sertify ( )
integer x = 0
integer y = 248
integer width = 3387
integer height = 816
string dataobject = "d_net_dev_action_items_sk"
end type

event dw_net_dev::ue_sertify();//////////////////////////////////////////////////////////////////////
// Event: ue_sertify()
// Arguments:
//--------------------------------------------------------------------
// Return:  (none)
//--------------------------------------------------------------------
// Author:	 Harry 2016-05-18.
//--------------------------------------------------------------------
// Description: Application Electronic Signature - Sertifi
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long ll_find_row,j, ll_row
Datawindow ldw_browse
str_app_email lstr_app_email,lstr_sertifi_sign,lstr_sertifi_ref
n_ds lds_sertifi_update, lds_action_items
str_sertifi_doc lstr_sertifi_doc 

ll_row = This.GetRow( )
lstr_app_email.rec_id_list[1] = this.GetItemNumber(ll_row,  'rec_id')
lstr_app_email.prac_id_list[1] = this.GetItemNumber(ll_row,  'prac_id')
lstr_app_email.app_id_list[1] = this.GetItemNumber(ll_row,  'app_id')

//Create Sertifi Request
OpenWithParm(w_app_sertifi_request, lstr_app_email)

PowerObject lpo_pass
If Not Isvalid(Message.Powerobjectparm) Then Return
lpo_pass = Message.Powerobjectparm
If lpo_pass.classname( ) <> 'str_app_email' Then Return

lstr_app_email = lpo_pass

lstr_sertifi_doc.as_es_apicode = gnv_sertifi.is_apicode
lstr_sertifi_doc.as_es_fileid = lstr_app_email.as_sertifi_fileid

SetPointer(HourGlass!)

//Set check out status.
lds_sertifi_update = Create n_ds
lds_sertifi_update.dataobject = 'd_app_sertifi_update'
lds_sertifi_update.SetTransObject(SQLCA)


end event

event dw_net_dev::clicked;call super::clicked;long r
string s
integer res
Long ll_rowid,ll_Row //Added by Appeon long.zhang 01.22.2016 (Issue id 4943 - Toggling on Field Titles in Application Tracking)

IF dwo.Name = "facility_name" THEN
	This.SetSort( "facility_name" )
	This.Sort( )
	Return 
END IF

 //Start Code Change ----03.09.2015 #V15 maha - Note: unchecked the Extend Ancestor Code
r = this.getclickedrow()

if r > 0 then  //Start Code Change ----03.09.2015 #V15 maha - added if
	this.setrow(r)
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.22.2016
//<$>reason:Sort function code from Ancestor Code (Issue id 4943 - Toggling on Field Titles in Application Tracking)
if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return // Check arguments

if IsValid (inv_Sort) then 
	ll_rowid = This.GetRowIDFromRow(GetRow())
	If inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo )  = 1 Then
		ll_row = This.GetRowFromRowID(ll_rowid)
		If ll_Row > 0 Then
			This.ScrollToRow(ll_row)
			This.SetRow(ll_row)
		End If
	End If
End If
//------------------- APPEON END -------------------


//Start Code Change ----02.03.2016 #V15 maha -  moved from buttonclicked
if il_flag =  0 then return
il_flag =  0
long	ll_rec_id,ll_prac_id,ll_app_id
//-------------------APPEON END-----------------------
long  ll_map_type, ll_action_type, ll_action_status //(Appeon)Stephen 08.13.2013 - V141 Email/Fax Applications to Payors
long  ll_incomplete, ll_type_code
long  ll_Pos
string ls_action_type, ls_action_status
string ls_note_temp =''
string ls_file_ext
str_parm lstr_img

IF dwo.name = 'b_notes' THEN
	//------Begin Modified by Alfee 01.15.2010 ---------------
	//<$Reason> for a richtext bug in APB 6.0 
	//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))	
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 04.17.2015
	//<$>reason:notes(char(32766)) may be truncated when retrieve, Bug 4484 for Case # 00053251: Maximum Length on Application Notes)
	If (LenA(ls_notes) = 32766) and AppeonGetClientType() = "PB" and (this.getitemstatus(row, 'notes', primary!) = NotModified!)  Then	
		//get 	ls_notes from database
		ls_note_temp = of_down_notes(this.getitemnumber( row, 'rec_id'))
		If ls_note_temp <> '' Then 
			ls_notes = ls_note_temp
			This.SetItem( row, "notes", ls_notes )
			this.setitemstatus(row, 'notes', primary!, NotModified!)
		End If
	End If
	//------------------- APPEON END -------------------

	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 02.15.2016
	//<$>reason: Add Action Items - Applications - View Rights (V15.1 Applause Cycle 3 Bug #4992 - AI-Application Status: Can add a note to action item with read-only access)

//	//Start Code Change ----02.11.2016 #V15 maha
//	if w_mdi.of_security_access(1400) = 1 then //application readonly
//		gb_note_readonly = true
//	end if
//	//Start Code Change ----02.11.2016

	If ( Not IsValid(iw_actions) and w_mdi.of_security_access( 1400 ) < 2 ) or &
		( IsValid(iw_actions) and w_mdi.of_security_access( 5200 ) < 2 ) Then
		gb_note_readonly = True
	Else
		gb_note_readonly = False
	End If
	//------------------- APPEON END -------------------	
	
	OpenWithParm( w_ai_notes_new, ls_notes)
	
	//---------End Modfiied ------------------------------------------------------
	
//	IF appeongetclienttype() = 'WEB' THEN  
//		//OpenWithParm( w_ai_notes_web, "A" + This.GetItemString( row, "notes" ))
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
//	ELSE		
//		//OpenWithParm( w_ai_notes, "A" + This.GetItemString( row, "notes" ))  //Start Code Change ----03.03.2011 #V11 maha - added A to front
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))	//changed by long.zhang 08.25.2011 - removed A from front
//		//OpenWithParm( w_ai_notes_new, "A#" +  This.GetItemString( row, "notes" ))	//changed by long.zhang 08.25.2011 - removed A from front
//	END IF	
	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
	//------End Modified --------------------------------------		

	IF Message.StringParm = "Cancel" THEN
		il_flag = 1//add Michael 11.08.2011 Fixed Bug#2772:double-clicking causes my intellicred to crash
		Return -1
	ELSE
		//Start Code Change ----12.11.2015 #V15 maha - don't update if not changed
		if len(ls_notes) = len(Message.StringParm) then   
			//skip setting if the same
		else
			This.SetItem( row, "notes", Message.StringParm )
		end if
		//End Code Change ----12.11.2015
		//---------------------APPEON BEGIN-------------------
		//$<Modified> long.zhang 09.09.2011
		//$<Reason>Fix a Database error bug,if row status is DataModified then update
		this.accepttext( )
		if this.getitemstatus( row,0,primary!) = DataModified!	then
			this.update(true , false)    //Start Code Change ----02.13.2012 #V12 maha - changed to not reset flags so that the next step can be created        //Start Code Change ----10.28.2010 #V10 maha - save immediately
		end if	
		//-------------------APPEON END-----------------------
	END IF
ELSEIF dwo.name = "bcontact" then
	gs_pass_ids lstr_ids
	
	lstr_ids.facility_id = This.GetItemNumber( row, "facility_id")
	lstr_ids.l_app_id = This.GetItemNumber( row, "app_id")
	lstr_ids.prac_id = il_prac_id
	lstr_ids.s_stringval = This.GetItemstring( row, "notes") //Start Code Change ----08.22.2012 #V12 maha
	
	IF dw_payors.Visible THEN
		lstr_ids.sl_label1 = dw_orgs_facilities.Title
	ELSE
		lstr_ids.sl_label1 = "Facility"
	END IF
	//lstr_ids.sl_label2 = dw_payors.Title + " / App "
	lstr_ids.sl_label2 = dw_payors.Title + " / Organization "  //Start Code Change ----01.13.2015 #V14.2 maha - changed label
	
	//Added by Appeon long.zhang 02.14.2016 (V15.1 Applause Cycle 3 Bug #4992 - AI-Application Status: Can add a note to action item with read-only access)
	If IsValid(iw_actions) Then lstr_ids.ls_from_window = 'A'
		
	OpenWithParm( w_contact_information, lstr_ids )
	
	//Start Code Change ----08.23.2012 #V12 maha - added ability to save notes
	IF Message.StringParm = "Cancel" THEN
		il_flag = 1//add Michael 11.08.2011 Fixed Bug#2772:double-clicking causes my intellicred to crash
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )

		this.accepttext( )
		if this.getitemstatus( row,0,primary!) = DataModified!	then
			this.update(true , false)    //Start Code Change ----02.13.2012 #V12 maha - changed to not reset flags so that the next step can be created        //Start Code Change ----10.28.2010 #V10 maha - save immediately
		end if	
	END IF

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ELSEIF dwo.name = "b_enpreview" then  //display image
	String	ls_PicName,ls_PicDir	
	
	ll_rec_id = This.GetItemNumber(row,"rec_id")
	ll_prac_id = This.GetItemNumber(row,"prac_id")
	ll_app_id = This.GetItemNumber(row,"app_id")
	

	ll_action_type = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP OUT TO MD'"))
	
	
	if This.GetItemNumber(row,"action_type") <> ll_action_type then  //if not App out to MD
	//---------End Modfiied ----------------------------------------------------------------	
	//Start Code Change ----05.17.2016 #V152 maha
//		res = of_imp_appfile(row, this, 'view')
//		if res > 0 then
//			this.retrieve()
//		end if
		of_imp_appfile(row, this, 'view')
		this.retrieve()
		
		
	//Start Code Change ----05.17.2016
	else
	//---------End Added ------------------------------------------------------
		ls_PicDir = gs_temp_path + "Images\"
		if Not DirectoryExists(ls_PicDir) then CreateDirectory (ls_PicDir)
		
		SELECT file_name
		  INTO :ls_file_ext
		  FROM net_dev_action_images
		WHERE rec_id = :ll_rec_id AND prac_id = :ll_prac_id; 
		
		if not isnull(ls_file_ext) then
			ll_Pos = LastPos (ls_file_ext, "." )
			IF ll_Pos > 0 THEN 
				ls_file_ext = Mid (ls_file_ext, ll_Pos)  
				if pos(".doc, .docx, .jpg, .bmp, .pdf, .tif", lower(ls_file_ext)) < 1 then
					ls_file_ext = ".tif"
				end if
			else
				ls_file_ext = ".tif"
			end if
		else
			ls_file_ext = ".tif"
		end if

		ls_PicName = ls_PicDir + String(ll_rec_id) + "_" + String(ll_prac_id) + "_"  + String(ll_app_id) + ls_file_ext
		of_Down_Image(ll_rec_id,ll_prac_id,ll_app_id,ls_PicName)
			
		if FileExists(ls_PicName) then
		//	If Isvalid(w_image_display) Then Close(w_image_display) //alfee 07.14.2009
		//	OpenWithParm(w_image_display,ls_PicName)		
			If Isvalid(w_preview_app) Then Close(w_preview_app) //alfee 07.14.2009
			OpenWithParm(w_preview_app ,ls_PicName)
		else
			MessageBox(gnv_app.iapp_object.DisplayName,ls_PicName + " does not exist!")
		end if
	end if
	 
elseif dwo.name = "b_dispreview" then //(Appeon)Stephen 08.13.2013 - V141 Email/Fax Applications to Payors	
	ll_app_id = This.GetItemNumber(row,"app_id")
	select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id;		
	if ll_map_type = 1  then	 //Start Code Change ----10.15.2013 #V14 maha - changed from 2
		of_imp_appfile(row, this, 'new')
		if message.doubleparm = 1 then  //turn the icon green
			this.setitem(row, "data_len", 100)
			this.setitemstatus(row, "data_len", primary!, notmodified!)
		end if
	end if 
	
END IF

//---------Begin Added by (Appeon)Harry Application Electronic Signature - Sertifi--------
If dwo.name = "b_esign_ns" Then
	
End If
//---------End Added ----------------------------------------------------

il_flag = 1
//End Code Change ----02.03.2016 
end event

event dw_net_dev::editchanged;call super::editchanged;ib_save = True
end event

event dw_net_dev::pfc_deleterow;call super::pfc_deleterow;ib_save = True

Return Success
end event

event dw_net_dev::itemchanged;call super::itemchanged;
 //Start Code Change ----09.02.2015 #V15 maha
if dwo.name =  "app_id" then
	datawindowchild dwchild
	long z
	long r
	this.getchild( "app_id", dwchild)
	r = dwchild.find( "app_hdr_app_id = " + data, 1, dwchild.rowcount())
	if r > 0 then
		if dwchild.getitemnumber(r,"app_hdr_active_status") = 0 then
			messagebox("Inactive Application","The chosen application is inactive and cannot be selected.")
			z = this.getitemnumber(row,"app_id",primary!,true )
			this.setitem(row, "app_id", z)
			return 2
		end if
	end if
end if
 //End Code Change ----09.02.2015

ib_save = True
end event

event dw_net_dev::pfc_ddcalendar;call super::pfc_ddcalendar;ib_save = True

Return Success
end event

event dw_net_dev::buttonclicked;call super::buttonclicked;////------------------- APPEON BEGIN -------------------
////$<add> Michael 11.08.2011
////$<reason>Fixed Bug#2772:double-clicking causes my intellicred to crash
//if il_flag =  0 then return
//il_flag =  0
//long	ll_rec_id,ll_prac_id,ll_app_id
////-------------------APPEON END-----------------------
//long  ll_map_type, ll_action_type, ll_action_status //(Appeon)Stephen 08.13.2013 - V141 Email/Fax Applications to Payors
//long  ll_incomplete, ll_type_code
//long  ll_Pos
//string ls_action_type, ls_action_status
//string ls_note_temp =''
//string ls_file_ext
//str_parm lstr_img
//
//IF dwo.name = 'b_notes' THEN
//	//------Begin Modified by Alfee 01.15.2010 ---------------
//	//<$Reason> for a richtext bug in APB 6.0 
//	//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))	
//	string ls_notes
//	ls_notes = This.GetItemString( row, "notes" )
//	if isnull(ls_notes) then ls_notes = ""
//	
//	//------------------- APPEON BEGIN -------------------
//	//<$>added:long.zhang 04.17.2015
//	//<$>reason:notes(char(32766)) may be truncated when retrieve, Bug 4484 for Case # 00053251: Maximum Length on Application Notes)
//	If (LenA(ls_notes) = 32766) and AppeonGetClientType() = "PB" and (this.getitemstatus(row, 'notes', primary!) = NotModified!)  Then	
//		//get 	ls_notes from database
//		ls_note_temp = of_down_notes(this.getitemnumber( row, 'rec_id'))
//		If ls_note_temp <> '' Then 
//			ls_notes = ls_note_temp
//			This.SetItem( row, "notes", ls_notes )
//			this.setitemstatus(row, 'notes', primary!, NotModified!)
//		End If
//	End If
//	//------------------- APPEON END -------------------
//	
//	OpenWithParm( w_ai_notes_new, ls_notes)
//	//---------End Modfiied ------------------------------------------------------
//	
////	IF appeongetclienttype() = 'WEB' THEN  
////		//OpenWithParm( w_ai_notes_web, "A" + This.GetItemString( row, "notes" ))
////		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
////	ELSE		
////		//OpenWithParm( w_ai_notes, "A" + This.GetItemString( row, "notes" ))  //Start Code Change ----03.03.2011 #V11 maha - added A to front
////		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))	//changed by long.zhang 08.25.2011 - removed A from front
////		//OpenWithParm( w_ai_notes_new, "A#" +  This.GetItemString( row, "notes" ))	//changed by long.zhang 08.25.2011 - removed A from front
////	END IF	
//	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	//------End Modified --------------------------------------		
//
//	IF Message.StringParm = "Cancel" THEN
//		il_flag = 1//add Michael 11.08.2011 Fixed Bug#2772:double-clicking causes my intellicred to crash
//		Return -1
//	ELSE
//		//Start Code Change ----12.11.2015 #V15 maha - don't update if not changed
//		if len(ls_notes) = len(Message.StringParm) then   
//			//skip setting if the same
//		else
//			This.SetItem( row, "notes", Message.StringParm )
//		end if
//		//End Code Change ----12.11.2015
//		//---------------------APPEON BEGIN-------------------
//		//$<Modified> long.zhang 09.09.2011
//		//$<Reason>Fix a Database error bug,if row status is DataModified then update
//		this.accepttext( )
//		if this.getitemstatus( row,0,primary!) = DataModified!	then
//			this.update(true , false)    //Start Code Change ----02.13.2012 #V12 maha - changed to not reset flags so that the next step can be created        //Start Code Change ----10.28.2010 #V10 maha - save immediately
//		end if	
//		//-------------------APPEON END-----------------------
//	END IF
//ELSEIF dwo.name = "bcontact" then
//	gs_pass_ids lstr_ids
//	
//	lstr_ids.facility_id = This.GetItemNumber( row, "facility_id")
//	lstr_ids.l_app_id = This.GetItemNumber( row, "app_id")
//	lstr_ids.prac_id = il_prac_id
//	lstr_ids.s_stringval = This.GetItemstring( row, "notes") //Start Code Change ----08.22.2012 #V12 maha
//	
//	IF dw_payors.Visible THEN
//		lstr_ids.sl_label1 = dw_orgs_facilities.Title
//	ELSE
//		lstr_ids.sl_label1 = "Facility"
//	END IF
//	//lstr_ids.sl_label2 = dw_payors.Title + " / App "
//	lstr_ids.sl_label2 = dw_payors.Title + " / Organization "  //Start Code Change ----01.13.2015 #V14.2 maha - changed label
//	
//	OpenWithParm( w_contact_information, lstr_ids )
//	
//	//Start Code Change ----08.23.2012 #V12 maha - added ability to save notes
//	IF Message.StringParm = "Cancel" THEN
//		il_flag = 1//add Michael 11.08.2011 Fixed Bug#2772:double-clicking causes my intellicred to crash
//		Return -1
//	ELSE
//		This.SetItem( row, "notes", Message.StringParm )
//		//---------------------APPEON BEGIN-------------------
//		//$<Modified> long.zhang 09.09.2011
//		//$<Reason>Fix a Database error bug,if row status is DataModified then update
//		this.accepttext( )
//		if this.getitemstatus( row,0,primary!) = DataModified!	then
//			this.update(true , false)    //Start Code Change ----02.13.2012 #V12 maha - changed to not reset flags so that the next step can be created        //Start Code Change ----10.28.2010 #V10 maha - save immediately
//		end if	
//	END IF
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-07-09 By: Scofield
////$<Reason> Add image preview process.
//
//ELSEIF dwo.name = "b_enpreview" then  //display image
//	//messagebox("","b_enpreview") //Commented by (Appeon)Stephen 08.13.2013 - V141 Email/Fax Applications to Payors
//	String	ls_PicName,ls_PicDir	
//	
//	ll_rec_id = This.GetItemNumber(row,"rec_id")
//	ll_prac_id = This.GetItemNumber(row,"prac_id")
//	ll_app_id = This.GetItemNumber(row,"app_id")
//	
//	//---------Begin Added by (Appeon)Stephen 08.15.2013 for V141 Email/Fax Applications to Payors--------	
//	//---------Begin Modified by (Appeon)Alfee 10.22.2013  for BugA102201----------
//	//select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id;		
//	//if ll_map_type = 1 then //Start Code Change ----10.15.2013 #V14 maha - changed from 2
//	//Start Code Change ----10.15.2014 #V14.2 maha - changed for all image types
////	ll_action_type = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP MAIL PAYOR'"))
//	ll_action_type = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP OUT TO MD'"))
//	if This.GetItemNumber(row,"action_type") <> ll_action_type then
//	//---------End Modfiied ----------------------------------------------------------------	
//		of_imp_appfile(row, this, 'view')
//		this.retrieve()
//	else
//	//---------End Added ------------------------------------------------------
//		ls_PicDir = gs_temp_path + "Images\"
//		if Not DirectoryExists(ls_PicDir) then CreateDirectory (ls_PicDir)
//		
//		//---------Begin Modified by (Appeon)Stephen 12.01.2015 for BugA113001--------
//		//ls_PicName = ls_PicDir + String(ll_rec_id) + "_" + String(ll_prac_id) + "_"  + String(ll_app_id) + ".tif"		
//		SELECT file_name
//		  INTO :ls_file_ext
//		  FROM net_dev_action_images
//		WHERE rec_id = :ll_rec_id AND prac_id = :ll_prac_id; 
//		
//		if not isnull(ls_file_ext) then
//			ll_Pos = LastPos (ls_file_ext, "." )
//			IF ll_Pos > 0 THEN 
//				ls_file_ext = Mid (ls_file_ext, ll_Pos)  
//				if pos(".doc, .docx, .jpg, .bmp, .pdf, .tif", lower(ls_file_ext)) < 1 then
//					ls_file_ext = ".tif"
//				end if
//			else
//				ls_file_ext = ".tif"
//			end if
//		else
//			ls_file_ext = ".tif"
//		end if
//
//		ls_PicName = ls_PicDir + String(ll_rec_id) + "_" + String(ll_prac_id) + "_"  + String(ll_app_id) + ls_file_ext
//		//---------End Modfiied ------------------------------------------------------
//		of_Down_Image(ll_rec_id,ll_prac_id,ll_app_id,ls_PicName)
//			
//		if FileExists(ls_PicName) then
//			If Isvalid(w_image_display) Then Close(w_image_display) //alfee 07.14.2009		
//			OpenWithParm(w_image_display,ls_PicName)
//		else
//			MessageBox(gnv_app.iapp_object.DisplayName,ls_PicName + " is not exist!")
//		end if
//	end if
//	 
//elseif dwo.name = "b_dispreview" then //(Appeon)Stephen 08.13.2013 - V141 Email/Fax Applications to Payors	
//	ll_app_id = This.GetItemNumber(row,"app_id")
//	select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id;		
//	if ll_map_type = 1  then	 //Start Code Change ----10.15.2013 #V14 maha - changed from 2
//		of_imp_appfile(row, this, 'add')
//		if message.doubleparm = 1 then
//			this.setitem(row, "data_len", 100)
//			this.setitemstatus(row, "data_len", primary!, notmodified!)
//		end if
//	end if 
//	
//END IF
////---------------------------- APPEON END ----------------------------

//il_flag = 1//add Michael 11.08.2011 Fixed Bug#2772:double-clicking causes my intellicred to crash
end event

event dw_net_dev::retrieveend;call super::retrieveend;of_set_quick_filter( dw_qf.GetItemString( 1, "quick_filter" ) )
end event

event dw_net_dev::pfc_postupdate;//
// Add by andy 01/30/2010 V10.1 - Notification Alert
//
n_cst_notification_alert_upd lnv_na

lnv_na.of_update_alert_records( "net_dev_action_items", This)

// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

//--------------------------- APPEON BEGIN ---------------------------


//$<add> 11.08.2006 By: Jervis
//$<reason> modify workflow,refresh data when active status changed

//---Begin Modified by alfee 03.15.2010 ----
//<$Reason>for an issue of duplicate ids if any record is added in the
//Action tab and then an Ids record is added before Save is clicked.
//of_refresh_data()

if lb_from_prac_folder then
	post of_refresh_data() 
else //actions   //Start Code Change ----08.10.2015 #V15 maha
	iw_actions.of_refresh_appl_data()
end if
//---End Modified --------------------------

//Start Code Change ----04.24.2014 #V14.2 maha
//tab_1.tabpage_ai.dw_tracking.retrieve( il_prac_id, il_app_id, ii_facility_id   )  //Start Code Change ----10.04.2012 #V12 maha
tab_1.tabpage_ai.dw_tracking.retrieve( il_prac_id, il_app_id, ii_facility_id , il_loc_id  ) 
//End Code Change ----04.24.2014 

return 1
//---------------------------- APPEON END ----------------------------

end event

event dw_net_dev::constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-09 By: Scofield
//$<Reason> Init b_EnPreview and b_DisPreview's Enabled property.

long ll_StAppImgInDB

SELECT TOP 1 set_StAppImgInDB INTO :ll_StAppImgInDB FROM icred_settings ;
if ll_StAppImgInDB <> 1 then
	This.Modify("b_DisPreview.Visible = yes")
	This.Modify("b_EnPreview.Visible = no")
end if
//---------------------------- APPEON END ----------------------------

this.setrowfocusindicator( p_1) //Start Code Change ----12.11.2009 #V10 maha


//----------Begin Commented by alfee 07.25.2011----------------
//<$Reason>moved to the pfc_ia_cst_nv_net_dev_new.constructor() event;
//<$Reason>1.  pfc_ia_cst_nv_net_dev_new.constructor() - Change dataoject for dw_net_dev;
//<$Reason>2.  dw_net_dev.constructor() in pfc_cst_nv_net_dev_new - SetTransObject () and Initialize the DDDWs;
//<$Reason>Note: The DDDWs will be retrieved only one time once the dataoject is fixed.

//if of_get_app_setting("set_40","I") = 4 then//Start Code Change ----05.23.2011 #V11 maha - allow use of old format dw
//	this.dataobject = "d_net_dev_action_items_no_group"
//end if
//----------End Commented ---------------------------------------

end event

event dw_net_dev::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-09 By: Scofield
//$<Reason> Delete Image before delete record.

long	ll_Cycle,ll_Cnts,ll_rec_id,ll_prac_id,ll_app_id ,i
long ll_loc  //maha 11.10.2015
long ll_track   //maha 11.10.2015
long r   //maha 11.10.2015
long ll_facility //maha 11.10.2015
boolean ib_update = false   //maha 11.10.2015

ll_Cnts = This.DeletedCount()

if ll_cnts > 0 then
	for ll_Cycle = 1 to ll_Cnts
		ll_rec_id = This.GetItemNumber(ll_Cycle,'rec_id',Delete!,false)
//		ll_prac_id = This.GetItemNumber(ll_Cycle,'prac_id',Delete!,false)
//		ll_app_id = This.GetItemNumber(ll_Cycle,'app_id',Delete!,false)
//		ll_loc = This.GetItemNumber(ll_Cycle,'gp_id',Delete!,false)
		//Start Code Change ----08.12.2011 #V11 maha - does not rely on the other fields for delete
		//DELETE FROM net_dev_action_images WHERE rec_id = :ll_rec_id AND prac_id = :ll_prac_id AND app_id = :ll_app_id ;
		DELETE FROM net_dev_action_images WHERE rec_id = :ll_rec_id;
		//Start Code Change ----08.12.2011
	next
	
	COMMIT USING SQLCA;
end if

 //Start Code Change ----11.10.2015 #V15 maha - check to see if any rows are modified and set the r variable
for r = 1 to this.rowcount()
	IF This.GetItemStatus( r, 0, Primary! ) = DataModified! or This.GetItemStatus( r, 0, Primary! ) = NewModified! then //Add NewModified, Modified by Appeon long.zhang 12.02.2015 (BugL120201)
		ib_update = true
		exit
	end if
next

if ib_update = false then
	return 1
else
	ll_track = This.GetItemNumber(r,'track_id')
end if
 //End Code Change ----11.10.2015

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.26.2014
//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue

//Return Super::Event pfc_preupdate()
//creates next step and workflow
i =  Super::Event pfc_preupdate()

 //Start Code Change ----11.10.2015 #V15 maha - update tracking record - was removed from of_get_next_record
ll_facility = This.GetItemNumber(r,'facility_id')
ll_prac_id = This.GetItemNumber(r,'prac_id')
ll_app_id = This.GetItemNumber(r,'app_id')
ll_loc = This.GetItemNumber(r,'gp_id')
post of_app_tracking_update_new(ll_prac_id, ll_facility, ll_app_id, 0, datetime(today(),now()), ll_loc, ll_track)
 //End Code Change ----11.10.2015

 //Start Code Change ----09.04.2015 #V15 maha - set tracking ids
 if tab_1.tabpage_ai.dw_tracking.rowcount() > 0 then
	of_check_tracking_id()
end if
 //end Code Change ----09.04.2015
 
 
inv_data_entry.of_field_audit( This )

Return i
//------------------- APPEON END -------------------

//---------------------------- APPEON END ----------------------------




end event

event dw_net_dev::pfc_addrow;call super::pfc_addrow;//Start Code Change ----09.09.2008 #V85 maha
long ll_app
long  ll_action_status  //maha 02.08.2011

//--------Begin Modified by alfee 09.17.2010 ---------------------------
//SK Practitioner Folder
if il_app_id > 0 then this.setitem(this.getrow(),"app_id", il_app_id)
if il_loc_id > 0 then this.setitem(this.getrow(),"gp_id", il_loc_id)  //Start Code Change ----06.03.2014 #V14.2 maha

//IF dw_payors.Visible THEN
//	ll_app = dw_payors.getitemnumber(dw_payors.getrow(),"app_id" )
//	if ll_app > 0 then
//		this.setitem(this.getrow(),"app_id", ll_app)
//	end if
//end if
//----------End Modified -----------------------------------------------------

//Start Code Change ----02.08.2011 #V11 maha - set to incomplete and user
this.setitem(this.getrow(),"action_user", gs_user_id)
ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Incomplete')"))
this.setitem(this.getrow(),"action_status",  ll_action_status)
//End Code Change ----02.08.2011 

//------------------- APPEON BEGIN -------------------
//$<add> Michael 06.23.2011
//$<reason> V11.3 Action Item Dates
//this.setitem(this.getrow(),"net_dev_action_items_create_date", datetime(today(),now()))
//this.setitem(this.getrow(),"net_dev_action_items_create_user", gs_user_id)
//------------------- APPEON END ---------------------
return 1
//End Code Change---09.09.2008
end event

event dw_net_dev::pfc_predeleterow;call super::pfc_predeleterow;//Start Code Change ----11.13.2012 #V12 maha - delete tracking record
if this.rowcount() = 1 then
	tab_1.tabpage_ai.dw_tracking.deleterow( 1)
end if

inv_data_entry.of_field_audit_delete_last( this, this.getrow()) //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

return 1
end event

type tabpage_ids from pfc_cst_nv_net_dev_prac_folder`tabpage_ids within tab_1
integer y = 100
integer width = 3474
integer height = 1644
string picturename = ""
long picturemaskcolor = 12632256
end type

type dw_ids from pfc_cst_nv_net_dev_prac_folder`dw_ids within tabpage_ids
integer x = 0
integer y = 0
integer width = 3406
integer height = 1640
boolean hscrollbar = true
end type

event dw_ids::editchanged;call super::editchanged;ib_save = True
end event

event dw_ids::pfc_deleterow;call super::pfc_deleterow;ib_save = True

Return Success
end event

event dw_ids::itemchanged;call super::itemchanged;ib_save = True
end event

event dw_ids::pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i


li_rc = tab_1.tabpage_ids.dw_ids.RowCount()
//messagebox("", "fdfa")
FOR i = 1 TO li_rc
	IF LenA( tab_1.tabpage_ids.dw_ids.GetItemString( i, "plan_assigned_id" ) ) = 0 OR IsNull(tab_1.tabpage_ids.dw_ids.GetItemString( i, "plan_assigned_id" ) )THEN
		MessageBox("Required Data", "You must enter in a Plan ID.  Please Correct." )
		tab_1.tabpage_ids.dw_ids.SetRow( i )
		tab_1.tabpage_ids.dw_ids.ScrollToRow( i )
		tab_1.tabpage_ids.dw_ids.SetColumn( "plan_assigned_id" )
		tab_1.tabpage_ids.dw_ids.SetFocus( )
		tab_1.SelectTab( 2 )
		Return -1
	END IF
	IF IsNull( tab_1.tabpage_ids.dw_ids.GetItemNumber( i, "plan_type" ) ) THEN
		MessageBox("Required Data", "You must enter in a Plan Type.  Please Correct." )
		tab_1.tabpage_ids.dw_ids.SetRow( i )
		tab_1.tabpage_ids.dw_ids.ScrollToRow( i )
		tab_1.tabpage_ids.dw_ids.SetColumn( "plan_type" )
		tab_1.tabpage_ids.dw_ids.SetFocus( )
		tab_1.SelectTab( 2 )		
		Return -1
	END IF	
END FOR

	
li_rc = This.RowCount()

//Start Code Change ---- 10.05.2007 #V7 maha
// correct a bug for a specific setting
IF gi_intelliapp_type > 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.05.2006 By: Liang QingShi
	//$<reason> Fix a defect
	//il_app_id = dw_payors.getitemnumber(dw_payors.getrow(),'app_id')  - (SK Practitioner Folder - commented by alfee 09.14.2010)
	//---------------------------- APPEON END ----------------------------
	
	FOR i = 1 TO li_rc
		IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
			This.SetItem( i, "app_id", il_app_id )
		END IF
	END FOR
End if
//End Code Change---10.05.2007

 //Start Code Change ----09.17.2015 #V15 maha - set address id
FOR i = 1 TO li_rc
	IF isnull(This.GetItemnumber( i,"address_id"))  THEN
		This.SetItem( i, "address_id", 0 )
	END IF
END FOR
 //End Code Change ----09.17.2015

inv_data_entry.of_field_audit( This ) //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

Return 1
end event

event dw_ids::constructor;call super::constructor;if gb_sk_ver then //Start Code Change ----06.03.2013 #V14 maha
	this.width = 2850
end if
end event

event dw_ids::pfc_postinsertrow;call super::pfc_postinsertrow;if il_loc_id > 0 then
	this.setitem(this.getrow(), "address_id", il_loc_id)
end if

end event

event dw_ids::pfc_predeleterow;call super::pfc_predeleterow;inv_data_entry.of_field_audit_delete_last( this, this.getrow()) //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

return 1
end event

type tabpage_notes from pfc_cst_nv_net_dev_prac_folder`tabpage_notes within tab_1
integer y = 100
integer width = 3474
integer height = 1644
long backcolor = 16777215
string picturename = ""
long picturemaskcolor = 12632256
end type

type dw_notes from pfc_cst_nv_net_dev_prac_folder`dw_notes within tabpage_notes
integer width = 3401
integer height = 1644
boolean border = true
end type

event dw_notes::itemchanged;call super::itemchanged;ib_save = True //Added by Appeon long.zhang 10.08.2014 (Bug 4256/ V14.2 Testing / Notes Not Saving)
end event

event dw_notes::editchanged;call super::editchanged;ib_save = True //Added by Appeon long.zhang 10.08.2014 (Bug 4256/ V14.2 Testing / Notes Not Saving)
end event

type tabpage_report from pfc_cst_nv_net_dev_prac_folder`tabpage_report within tab_1
integer y = 100
integer width = 3474
integer height = 1644
long backcolor = 16777215
string picturename = ""
long picturemaskcolor = 12632256
gb_filter_2 gb_filter_2
cb_2 cb_2
end type

on tabpage_report.create
this.gb_filter_2=create gb_filter_2
this.cb_2=create cb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_filter_2
this.Control[iCurrent+2]=this.cb_2
end on

on tabpage_report.destroy
call super::destroy
destroy(this.gb_filter_2)
destroy(this.cb_2)
end on

type cb_export from pfc_cst_nv_net_dev_prac_folder`cb_export within tabpage_report
integer x = 2683
integer y = 0
integer width = 238
string facename = "Segoe UI"
end type

type rb_par_sum from pfc_cst_nv_net_dev_prac_folder`rb_par_sum within tabpage_report
integer x = 1243
integer width = 585
string facename = "Segoe UI"
long backcolor = 33551856
end type

event rb_par_sum::clicked;call super::clicked;of_report_selected_ver9( "ParNumsSum" )
dw_qf.Enabled = False
dw_qf.Modify("quick_filter.protect=1") //Add by Even 05.18.2009 --- Corrected BugS030405
ddlb_group_by.Enabled = False
//dw_payors.Enabled = False //Start Code Change ----11.10.2008 #V85 maha - removed
//dw_orgs_facilities.Enabled = False

gb_filter_2.Text = "Filters do not work for selected report."

end event

type rb_ai_wn from pfc_cst_nv_net_dev_prac_folder`rb_ai_wn within tabpage_report
integer x = 581
integer width = 663
string facename = "Segoe UI"
long backcolor = 33551856
end type

event rb_ai_wn::clicked;call super::clicked;of_report_selected_ver9( "StatusWithNotes" )
dw_qf.Enabled = True
dw_qf.Modify("quick_filter.protect=0") //Add by Even 05.18.2009 --- Corrected BugS030405
ddlb_group_by.Enabled = True
dw_payors.Enabled = True
dw_orgs_facilities.Enabled = True
gb_filter_2.Text = "Filter"
end event

type rb_par from pfc_cst_nv_net_dev_prac_folder`rb_par within tabpage_report
integer x = 1847
integer width = 727
string facename = "Segoe UI"
long backcolor = 33551856
end type

event rb_par::clicked;call super::clicked;of_report_selected_ver9( "ParNums" )
dw_qf.Enabled = False
dw_qf.Modify("quick_filter.protect=1") //Add by Even 05.18.2009 --- Corrected BugS030405
ddlb_group_by.Enabled = False
//dw_payors.Enabled = False   //Start Code Change ----11.10.2008 #V85 maha - removed
//dw_orgs_facilities.Enabled = False

gb_filter_2.Text = "Filters do not work for selected report."
end event

type rb_ai from pfc_cst_nv_net_dev_prac_folder`rb_ai within tabpage_report
integer x = 18
integer y = 8
integer width = 562
string facename = "Segoe UI"
long backcolor = 33551856
end type

event rb_ai::clicked;call super::clicked;of_report_selected_ver9( "Status" )
dw_qf.Enabled = True
dw_qf.Modify("quick_filter.protect=0") //Add by Even 05.18.2009 --- Corrected BugS030405
ddlb_group_by.Enabled = True
dw_payors.Enabled = True
dw_orgs_facilities.Enabled = True

gb_filter_2.Text = "Filter"
end event

type dw_report_data from pfc_cst_nv_net_dev_prac_folder`dw_report_data within tabpage_report
integer x = 0
integer y = 96
integer width = 3397
integer height = 1548
end type

event dw_report_data::constructor;call super::constructor;This.of_SetUpdateAble( False )
end event

type dw_orgs_facilities from pfc_cst_nv_net_dev_prac_folder`dw_orgs_facilities within pfc_ia_cst_nv_net_dev_new_maha152
event u_after_retrieve ( )
integer x = 18
integer y = 236
integer width = 969
integer height = 1748
boolean titlebar = false
string title = ""
string dataobject = "d_net_dev_tv_w_loc"
boolean hscrollbar = true
boolean resizable = true
boolean border = false
end type

event dw_orgs_facilities::u_after_retrieve();//-------Begin Added by alfee 09.14.2010 -----------------
//SK Practitioner Folder
long i, j, ll_cnt, ll_app_id, ll_found, ll_app_ids [], ll_app_id_last= -1
String ls_app_name, ls_app_nms[]

 //Start Code Change ----08.10.2015 #V15 maha
IF lb_from_prac_folder = False then  //action iterms
	if ii_facility_id > 0 then return
end if

//Insert applications for the Facility 'All' in the treeview datawindow
if gi_intelliapp_type > 0 then //non single group
	//Get a distinct application list
	ll_cnt = this.rowcount()
	for i = 1 to ll_cnt
		ll_app_id = this.getitemnumber(i,'app_id')
		ls_app_name = this.getitemstring(i,'application_name')
		for j = 1 to upperbound(ll_app_ids[])		
			if ll_app_id = ll_app_ids[j] then exit
		next
		if j > upperbound(ll_app_ids[])	 then //not existed
			if ll_app_id = 0 then continue 
			ll_app_ids[upperbound(ll_app_ids[]) + 1] = ll_app_id
			ls_app_nms[Upperbound(ls_app_nms[]) + 1] = ls_app_name
			ll_app_id_last = ll_app_id			
		end if		
	next
//debugbreak()	
	//Insert applications into the treeview datawindow
	if UpperBound(ll_app_ids[]) < 1 then
		ll_app_ids[1] = 0
		ls_app_nms[1] = '**No Payor / Hospital**'
	end if	
	for i = UpperBound(ll_app_ids[]) to 1 step -1
		this.insertrow(1)
		if lb_from_prac_folder then this.setitem(1, 'prac_id', il_prac_id)
		this.setitem(1, 'parent_facility_id', 0)
		this.setitem(1, 'parent_facility', 'All')		
		this.setitem(1, 'app_id', ll_app_ids[i])
		this.setitem(1, 'application_name', ls_app_nms[i])		
		this.setitem(1, 'sort_flag', 0)
		 //Start Code Change ----08.07.2015 #V15 maha
		this.setitem(1, 'gp_id', -1)
		this.setitem(1, 'alias_name', "All Locations")	
		 //End Code Change ----08.07.2015
	next	
	
	//refresh treeview datawindow
	this.sort()
	this.groupcalc( )
	ll_found = this.find("parent_facility_id <> 0", 1, this.rowcount())
	if ll_found > 0 then
		this.collapseall()
		//Start Code Change ----04.22.2014 #V14.2 maha
		this.expand(ll_found, 1)
		//Start Code Change ----11.05.2014 #V14.2 maha
		choose case gi_intelliapp_type
			case 1,2
				this.expand(ll_found, 2)
		end choose
		
 //Start Code Change ----08.25.2015 #V15 maha	- removed	
		this.setrow(ll_found)
//		this.scrolltorow(ll_found)
		
		if  gi_intelliapp_type = 3 then  //two level
			this.selecttreenode(ll_found, 2, true)
		else //three level
			this.selecttreenode(ll_found, 3, true)
		end if
		
		is_tree_level = "D"   //Start Code Change ----08.18.2015 #V15 maha
		
		//End Code Change ----11.05.2014
		//End Code Change ----04.22.2014
	end if
	
	this.setfocus()  //Start Code Change ----08.25.2015 #V15 maha

	return //
	
ELSE //facility level only
	This.InsertRow( 1 )
	This.SetItem( 1, "parent_facility", "All " )
	This.SetItem( 1, "parent_facility_id", 0 )	
	
	This.SelectRow( 0, False )	
	This.SelectRow( 2, True )
	This.ScrollToRow( 2 )
	This.SetRow( 2 )
end if












end event

event dw_orgs_facilities::rowfocuschanged;
if gi_intelliapp_type > 0 then return //non single group (SK Practitioner Folder - alfee 09.14.2010)

tab_1.tabpage_ai.dw_net_dev.SetRedraw ( false )
IF This.RowCount() > 0  THEN
	IF This.GetItemNumber( 1, "parent_facility_id" ) <> 0 THEN //maha 092204 moved inside rowcount trap
		Return 
	else
		ii_facility_id = This.GetItemNumber( currentrow, "parent_facility_id") //maha 112304 moved in front of the of_retrieve_detail
		of_retrieve_detail( ii_facility_id )
		//of_report_selected_ver9( "NONE") //Start Code Change ----11.10.2008 #V85 maha
		ib_report_filter = true
		tab_1.tabpage_ai.dw_net_dev.SetRedraw ( true )
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 02.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_ai.dw_appoint_stat.Retrieve( il_prac_id, ii_facility_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<add> 02.16.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
IF gi_intelliapp_type > 0 THEN
	il_app_id = 0
	IF ii_facility_id = 0 THEN
		dw_payors.DataObject = "d_net_dev_payors_hospitals_all"
		dw_payors.SetTRansObject( SQLCA )
		dw_payors.Retrieve( il_prac_id )
	ELSE	
		//messagebox("", "1")
		dw_payors.DataObject = "d_net_dev_payors_hospitals"
		dw_payors.SetTRansObject( SQLCA )	
		dw_payors.Retrieve( il_prac_id, ii_facility_id )
		//messagebox("", "2")		
	END IF
END IF
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

IF gi_intelliapp_type > 0 THEN
	il_app_id = 0
	IF ii_facility_id = 0 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-16
		//$<comment> 02.16.2006 By: Cao YongWang
		//$<reason>
		//$<modification> Move the following script to PT-15 and integrate them with other
		//$<modification> SQL statements to reduce client-server interactions.
		/*
		dw_payors.DataObject = "d_net_dev_payors_hospitals_all"
		dw_payors.SetTRansObject( SQLCA )
		dw_payors.Retrieve( il_prac_id )
		*/
		//---------------------------- APPEON END ----------------------------
	ELSE	
		//messagebox("", "1")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-17
		//$<comment> 02.16.2006 By: Cao YongWang
		//$<reason>
		//$<modification> Move the following script to PT-15 and integrate them with other
		//$<modification> SQL statements to reduce client-server interactions.
		/*
		dw_payors.DataObject = "d_net_dev_payors_hospitals"
		dw_payors.SetTRansObject( SQLCA )	
		dw_payors.Retrieve( il_prac_id, ii_facility_id )
		*/
		//---------------------------- APPEON END ----------------------------
		dw_payors.SetRow( 2 )
		dw_payors.ScrollToRow( 2 )
		//messagebox("", "2")		
	END IF
END IF

IF NOT ib_filter_set THEN
	tab_1.tabpage_ai.dw_net_dev.SetFilter( "active_status = 1" )
	tab_1.tabpage_ai.dw_net_dev.Filter( )
END IF

tab_1.tabpage_ai.dw_net_dev.SetRedraw ( true )

//st_as_msg.visible = false //maha 062905
end event

event dw_orgs_facilities::retrieveend;//--------Begin Modified by Nova 10.29.2008-----------
//PostEvent( "u_after_retrieve" )
triggerEvent( "u_after_retrieve" )
//--------End Modified -------------------------------

//$<del> 07.09.2008 by Andy
/*
CHOOSE CASE gi_intelliapp_type
		//SINGLE GROUP
	CASE 0
		dw_orgs_facilities.Title = "Payor / Hospital"
		//MULTI SITE GROUP
	CASE 1
		dw_orgs_facilities.Title = "Group"
		//BILLING COMPANY
	CASE 2
		dw_orgs_facilities.Title = "Client"
END CHOOSE
*/
//end del 07.09.2008



end event

event dw_orgs_facilities::retrievestart;call super::retrievestart;ib_done_retrieving_orgs = False
end event

event dw_orgs_facilities::clicked;Integer li_retval
Integer li_row

//Added by Appeon long.zhang 10.09.2015 (Case #57667 Issue with Application Notes)
If il_flag =  0 then 
	return 1
End If


//--------Begin Added by alfee 09.14.2010 -----------
//SK Practitioner Folder
string  ls_dw_band
str_dw_band lstr_band
debugbreak()
if gi_intelliapp_type > 0 then //non single group
	ls_dw_band = this.GetBandAtPointer()
	lstr_band = of_parse_bandinfo (ls_dw_band)
	of_set_tree_level(lstr_band.band)   //Start Code Change ----08.18.2015 #V15 maha - for report filtering
	if lstr_band.band = 'tree.level.1' then 
		if not this.isexpanded(lstr_band.row, 1)  then this.expand( lstr_band.row, 1)
	end if
	return //
end if
//--------End Added --------------------------------------

li_retval = of_save()

IF li_retval < 0 THEN
	Return 1
END IF

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	//tab_1.tabpage_ai.dw_net_dev.SetFocus( )
	Return -1
END IF



This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )


end event

event dw_orgs_facilities::constructor;//Override (SK Practitioner Folder - alfee 09.14.2010)

String ls_facility_label, ls_app_label, ls_label

SELECT TOP 1 app_stat_facility_label, app_stat_app_label INTO :ls_facility_label, :ls_app_label FROM icred_settings;
ls_label = trim(ls_facility_label)

//Start Code Change ----11.05.2014 #V14.2 maha - changed to case; added two level option
choose case gi_intelliapp_type
	case 1,2 //three level
		ls_label += ' / ' + Trim(ls_app_label)
		this.dataobject = 'd_net_dev_tv_w_loc'  //Start Code Change ----04.08.2014 #V14.2 maha
	case 3  //two level
		ls_label += ' / ' + Trim(ls_app_label)
		this.dataobject = 'd_net_dev_tv_2_level'  //Start Code Change ----04.08.2014 #V14.2 maha
	case 0
		this.dataobject = 'd_pd_affil_status_orgs_ia' 
end choose

//if gi_intelliapp_type > 0 then //MULTI SITE GROUP or BILLING COMPANY
//	ls_label += ' / ' + Trim(ls_app_label)
//	this.dataobject = 'd_net_dev_tv_w_loc'  //Start Code Change ----04.08.2014 #V14.2 maha
//	this.hscrollbar = True
//else
//	this.dataobject = 'd_pd_affil_status_orgs_ia' //Start Code Change ----06.13.2012 #V12 maha
//end if
//End Code Change ----11.05.2014 

this.of_SetUpdateAble( False )
this.of_SetTransObject(SQLCA)

if  Len(ls_label) > 0 then	this.Title = ls_label
end event

event dw_orgs_facilities::treenodeselected;call super::treenodeselected;//SK Practitioner Folder - alfee 09.14.2010


IF gi_intelliapp_type = 0 THEN RETURN //Return for single group 
IF row < 1 OR grouplevel < 1 THEN RETURN

//save data first if any
of_save ()

//Assign variables
ii_facility_id = This.GetItemNumber( row, "parent_facility_id") 
il_app_id = This.GetItemNumber( row, "app_id" )
//Start Code Change ----04.08.2014 #V14.2 maha
il_loc_id = This.GetItemNumber( row, "gp_id" )

//if isnull(il_loc_id) then messagebox("","gp id is null")
if isnull(il_loc_id) then il_loc_id = -1  //Start Code Change ----08.07.2015 #V15 maha - trap for "All" level records

//IF grouplevel = 1 THEN il_app_id = 0 //All applications or no application for the facility
//Start Code Change ----11.05.2014 #V14.2 maha
choose case gi_intelliapp_type
	case 1,2    //3 level
		IF grouplevel = 1 THEN
			il_app_id = 0 
			il_loc_id = -1
		elseif  grouplevel = 2 THEN
			il_app_id = 0
			//il_loc_id set above
		end if
	case 3  //two level
		IF grouplevel = 1 THEN
			il_app_id = 0 
			il_loc_id = -1
		end if
end choose
//Start Code Change ----04.08.2014
//End Code Change ----11.05.2014

if il_app_id = 0 then 
	il_track_id = 0   //Start Code Change ----09.04.2015 #V15 maha
else  //Start Code Change ----05.13.2016 #V15 maha
	 il_track_id = this.getitemnumber(row,"pd_appl_tracking_track_id")
end if

//Retrieve detail
parent.event pfc_cst_retrieve_detail ()

of_check_tracking_id( )  //Start Code Change ----09.04.2015 #V15 maha
end event

event dw_orgs_facilities::doubleclicked;call super::doubleclicked;gs_report_variables lst_arg
long ll_appid

if il_app_id < 1 or Isnull(il_app_id) then return  //alfee 11.02.2010
if row < 1 or IsNull(row) then return //alfee 09.08.2011

lst_arg.as_report_object = "d_rpt_net_dev_prac_notes_by_appl"
lst_arg.ai_num_variables = 1
lst_arg.as_var_type[1] = "N"
lst_arg.as_value[1] = string(il_prac_id)
lst_arg.as_var_type[2] = "N"
ll_appid = this.getitemnumber(row,"app_id") 
lst_arg.as_value[2] = string(ll_appid)
lst_arg.ai_num_variables = 2

if ll_appid > 0 then
	if isvalid(w_report_view) then close(w_report_view)
	openwithparm(w_report_view,lst_arg)
else
	messagebox("cant get app",ll_appid)
end if
	
end event

event dw_orgs_facilities::resize;call super::resize;//------------------- APPEON BEGIN -------------------
//<$>Modified:long.zhang 10.17.2014

////Start Code Change ----04.17.2014 #V14.2 maha
//long n
//long w
//
////debugbreak()
//
//n = this.x + this.width
//
//w = tab_1.width
//tab_1.x = n + 15
//
//tab_1.width = parent.width - n - 20
//w = tab_1.width
//
//tab_1.tabpage_ai.dw_appoint_stat.width = w - 25
////tab_1.tabpage_ai.dw_net_dev.x = n2
//tab_1.tabpage_ai.dw_net_dev.width = w - 40
////
////tab_1.tabpage_ai.dw_tracking.x = n
//tab_1.tabpage_ai.dw_tracking.width = w - 28

of_resize_manual()

//------------------- APPEON END -------------------



end event

event dw_orgs_facilities::pfc_addrow; //Start Code Change ----08.18.2015 #V15 maha
choose case tab_1.selectedtab
	case 1
		tab_1.tabpage_ai.dw_net_dev.triggerevent("pfc_addrow")
	case 2
		tab_1.tabpage_ids.dw_ids.triggerevent("pfc_addrow")
end choose

return 0
end event

type dw_appoint_stat from u_dw within tabpage_ai
integer width = 3387
integer height = 252
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_status_ia"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;Long nulllong
datawindowchild dwchild

This.SetTransObject( SQLCA )

dw_appoint_stat.of_SetDropDownCalendar( TRUE )
//dw_appoint_stat.iuo_calendar.of_Register(dw_appoint_stat.iuo_calendar.DDLB)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.11.2015
//<$>reason:V14.2 Bug # 4708 IntelliApp does not allow you to clear a flag setting on the Applications tab
SetNull(nulllong)
If tab_1.tabpage_ai.dw_appoint_stat.GetChild( "pd_affil_stat_in_good_standing", dwchild ) = 1 Then
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve()
	dwchild.InsertRow( 1 )
	dwchild.setitem(1,"lu_id", nulllong)
	dwchild.setitem(1,"display_value", '')
End If
//------------------- APPEON END -------------------

end event

event itemchanged;call super::itemchanged;//Start Code Change ----03.09.2010 #V10 maha - security for purge in status field
if w_mdi.of_security_access(7120) = 0 then
	if This.GetColumnName() = "active_status" and data = "2" THEN
		messagebox("Purge Security","You do not have security rights to Purge a practitioner.")
		this.setitem(row,"active_status", this.getitemnumber(row,"active_status", primary!,true))
		//this.accepttext( )
		return 1
	end if
end if
//End Code Change---03.09.2010

IF This.GetColumnName() = "active_status" AND (data = '3' OR data = '2') THEN
	Integer li_facility_id		
	Integer li_ans
	Integer li_rc
	Integer i
	String ls_msg_hdr
	Long    ll_orig_status
	integer li_central
	integer li_status
	string ls_stat
		
	IF data = '3' THEN
		ls_msg_hdr = "Inactive"
	ELSE
		ls_msg_hdr = "Purge"
	END IF

	//Start Code Change ----03.29.2010 #V10 maha - for central cred
	ls_stat = data
	li_status = integer(data)
	li_facility_id = This.GetItemNumber( row, "parent_facility_id" ) 
	//End Code Change---03.29.2010
	
	ll_orig_status = This.GetItemNumber(row, "active_status") //BugAn031901 - Andy 03/25/2010	

	IF ls_msg_hdr = "Inactive" THEN
//Start Code Change ----01.25.2012 #V12 maha	-  modify so as to not	make actions inactive
//		li_ans = MessageBox( ls_msg_hdr,  "This will cause all action items under this Payor/Hospital to become Inactive also.~n You will not be able to make them active again.~n~n        Continue?", Exclamation!, YesNo!, 2 )
	li_ans= 1
		IF li_ans = 1 THEN
			if li_ans = MessageBox( ls_msg_hdr,  "Are you Sure you wish to make this provider Inactive?", Question!, YesNo!, 2 ) then
			//Start Code Change ----06.07.2011 #V11 maha 	- modified to make all actions inactive , not just the current ones
//				li_rc = tab_1.tabpage_ai.dw_net_dev.RowCount()
//				FOR i = 1 TO li_rc
//					If tab_1.tabpage_ai.dw_net_dev.GetItemStatus(i,0,Primary!) = New! Then Continue //Added By Ken.Guo 06.25.2008
//					tab_1.tabpage_ai.dw_net_dev.SetItem( i, "active_status", 0 )
//				END FOR
				gnv_appeondb.of_startqueue()
				//tab_1.tabpage_ai.dw_net_dev.Update( )  //Commented By Ken.Guo 06.25.2008
//				update net_dev_action_items set active_status = 0 where prac_id = :il_prac_id and facility_id = :li_facility_id; //maha 01.25.2012

//				update pd_appl_tracking set active_status = 0 where facility_id = :li_facility_id AND	prac_id = : il_prac_id;
//End Code Change ----01.25.2012				
			//End Code Change ----06.07.2011
				tab_1.tabpage_ai.dw_net_dev.Trigger Event Pfc_Update(True,True)  //Added By Ken.Guo 06.25.2008
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 11.13.2015
				//<$>reason:Bug id 4846 - Data missing in Audit Trail
				//This.Update( )
				This.Post of_update(True,True)
				//------------------- APPEON END -------------------
				
				//Start Code Change ----03.30.2010 #V10 maha
				//------Begin Modified by alfee 04.01.2010 --------
				update pd_comm_review set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id = :li_facility_id;
				update pd_affil_dept set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id = :li_facility_id;
				update pd_affil_staff_cat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id = :li_facility_id;
				//update pd_comm_review set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
				//update pd_affil_dept set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
				//update pd_affil_staff_cat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;				
				//------End Modified ------------------------------
				//End Code Change---03.30.2010			
				gnv_appeondb.of_commitqueue()
			else
				IF AppeonGetClientType() = 'WEB' THEN This.SetItem(row, "active_status", ll_orig_status) // BugAn031901 - Andy 03/25/2010
				return 2 //alfee 12.11.2008						
			end if				
		ELSE
			IF AppeonGetClientType() = 'WEB' THEN This.SetItem(row, "active_status", ll_orig_status) // BugAn031901 - Andy 03/25/2010
			return 2 //alfee 12.11.2008					
		END IF
			
		//Start Code Change ----03.29.2010 #V10 maha - added Central cred functionality	
		select central_cred into :li_central from facility where facility_id = :li_facility_id;
		if li_central = 1 then
			choose case li_status
				case 0
					ls_stat = "History"
				case 1
					ls_stat = "Active"
				case 2
					ls_stat = "Purge"
				case 3
					ls_stat = "Inactive"
				case 4
					ls_stat = "Pending"
			end choose
			
			if li_status = 3 then
				i = messagebox("Status Update","You are changing the Active Status of your Central Facility to " + ls_stat + ".~r Do you wish to change all other Facilities for this practitioner to " + ls_stat + " including attached action records?" ,question!,yesno!,2)
			else
				i = messagebox("Status Update","You are changing the Active Status of your Central Facility to " + ls_stat + ".~r Do you wish to change all other Facilities for this practitioner to " + ls_stat + "?" ,question!,yesno!,2)
			end if
			
			if i = 1 then
				if li_status = 3 then //inactive
					gnv_appeondb.of_startqueue()								
					update pd_affil_stat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and parent_facility_id <> :li_facility_id;
					update pd_comm_review set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_dept set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_staff_cat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_attest_questions set active_status = 0 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					// update net_dev_action_items set active_status = 0 where active_status = 1 and prac_id = :il_prac_id;   //Start Code Change ----04.09.2015 #V15 maha
					commit using sqlca;					
					gnv_appeondb.of_commitqueue()							
				elseif li_status = 1 then //active					
					gnv_appeondb.of_startqueue()			
					//update pd_affil_stat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_stat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and parent_facility_id <> :li_facility_id; //alfee 04.01.2010
					update pd_comm_review set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_dept set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id  and facility_id <> :li_facility_id;
					update pd_affil_staff_cat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					commit using sqlca;					
					gnv_appeondb.of_commitqueue()													
				elseif li_status = 4 then //pending				
					gnv_appeondb.of_startqueue()								
					update pd_affil_stat set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and parent_facility_id <> :li_facility_id;
					update pd_comm_review set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_dept set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					update pd_affil_staff_cat set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :li_facility_id;
					commit using sqlca;				
					gnv_appeondb.of_commitqueue()									
				else
					messagebox("Status Update","You cannot change facilities to " + ls_stat + " in a batch." ,question!,yesno!,2)
				 end if		
			end if
			
		end if //central cred
		//End Code Change---03.29.2010
			
	ElSEIF ls_msg_hdr = 'Purge' THEN  //modified maha 082604 to function more like the Appt Stat Purge
			li_ans = MessageBox( ls_msg_hdr,  "Purge is used in preparation for deletion of the practitioner.  If you are just removing the connection to the Facility/Group, inactive is a better choice.  Setting to Purge will cause ALL data under this Payor/Hospital to be DELETED.     Continue?", Exclamation!, YesNo!, 2 )
			IF li_ans = 1 THEN
				if li_ans = MessageBox( ls_msg_hdr,  "Are you Sure?", Question!, YesNo!, 2 ) then
				//Start Code Change ----06.07.2011 #V11 maha 	- modified to delete all actions 
//					li_rc = tab_1.tabpage_ai.dw_net_dev.RowCount()
//					FOR i = 1 TO li_rc
//						tab_1.tabpage_ai.dw_net_dev.DeleteRow( 0 )
//					END FOR
					gnv_appeondb.of_startqueue()
					Delete from net_dev_action_items where facility_id = :li_facility_id AND	prac_id = : il_prac_id;
					Delete from pd_appl_tracking where facility_id = :li_facility_id AND	prac_id = : il_prac_id;
				//End Code Change ----06.07.2011
					tab_1.tabpage_ai.dw_net_dev.Update( )
					This.Update( )
					li_facility_id = This.GetItemNumber( row, "parent_facility_id" )
					DELETE 
					FROM net_dev_ids
					WHERE facility_id = :li_facility_id AND
							prac_id = : il_prac_id;
					IF SQLCA.SQLCODE = -1 THEN
						MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
						Return -1
					END IF
					gnv_appeondb.of_commitqueue()

					//---------Begin Added by Alfee on 12.11.2008-------------------------
					//<$Reason>Moved up the code
					gnv_appeondb.of_startqueue()
					dw_appoint_stat.Update( )		
					of_reset( )
					of_retrieve_facilities( )
					gnv_appeondb.of_commitqueue()
					//---------End Added --------------------------------------------------
	
					//DELETE 
					//FROM pd_address_link
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 2", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//					
					//DELETE 
					//FROM pd_affil_dept
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 4", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//
					//DELETE 
					//FROM pd_affil_staff_cat
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 5", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//
					//DELETE 
					//FROM pd_affil_staff_leave
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 6", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//
					//DELETE 
					//FROM pd_app_audit
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 7", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//
					//DELETE 
					//FROM pd_hosp_facility_link
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 8", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
					//
					//DELETE 
					//FROM pd_spec_facility_link
					//WHERE facility_id = :li_facility_id AND
					//		prac_id = : il_prac_id;
					//IF SQLCA.SQLCODE = -1 THEN
					//	MessageBox("SQL Error 9", SQLCA.SQLERRTEXT )
					//	Return -1
					//END IF
				else
					// BugAn031901 - Andy 03/25/2010
					IF AppeonGetClientType() = 'WEB' THEN This.SetItem(row, "active_status", ll_orig_status)
					return 2 //alfee 12.11.2008					
				end if
				MessageBox("Purge", "To completely remove practitioner from the system go to the System->Delete Practitioner menu option." )
			ELSE
				// BugAn031901 - Andy 03/25/2010
				IF AppeonGetClientType() = 'WEB' THEN This.SetItem(row, "active_status", ll_orig_status)
				return 2 //alfee 12.11.2008				
			END IF

			//--------Begin Commented by Alfee on 12.11.2008 -------------------------
			//<$Reason> Should be moved to the above
			/*  
			//dw_appoint_stat.DeleteRow( 0 )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-22
			//$<add> 03.29.2006 By: Cao YongWang
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
			gnv_appeondb.of_startqueue()
			//---------------------------- APPEON END ----------------------------
			dw_appoint_stat.Update( )
			
			of_reset( )
			of_retrieve_facilities( )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-23
			//$<add> 03.29.2006 By: Cao YongWang
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.> 
			gnv_appeondb.of_commitqueue()
			//---------------------------- APPEON END ----------------------------
			*/  
			//--------End Commented ---------------------------------------------------
		END IF
END IF
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_deleterow;Integer li_ans
Integer li_rc
Integer i
string ls_facil //maha 08.10.2010
string ls_app  //maha 08.10.2010


 //Start Code Change ----08.10.2010 #V10 maha - added variable to allow customized messages below
ls_facil = dw_orgs_facilities.title 
ls_app = dw_payors.title


//--------Begin Added by alfee 09.17.2010 -------------------
//SK Practitioner Folder
IF gi_intelliapp_type > 0 AND Pos(ls_facil, "/") > 0 THEN
	ls_facil = Left(ls_facil, Pos(ls_facil, "/") - 1)
END IF
//--------End Added --------------------------------------------

//Start Code Change ----08.03.2012 #V12 maha - redesigned trap broken when switched to tree-view
		//IF dw_orgs_facilities.RowCount() <= 2 THEN  //Start Code Change ----08.10.2010 #V10 maha - changed from 1 to allow for the 'ALL'
		//	MessageBox("Delete", "You need to have at least one " + ls_facil + " record." )
		//	Return 0
		//END IF
select count(rec_id) into :li_rc from pd_affil_stat where prac_id = :il_prac_id and parent_facility_id <> :ii_facility_id;

if li_rc < 1 then
		MessageBox("Delete", "You need to have at least one " + ls_facil + " record." )
	Return 0
end if
//End Code Change ----08.03.2012

if gs_cust_type = "I" then //Start Code Change ----06.16.2011 #V11 maha - only applicable for app
	if ii_facility_id = 1 then
		MessageBox("Delete", "You cannot delete this " + ls_facil + " from the practitioner." )
		return 0
	end if
end if

li_ans = MessageBox( "Deleting " + ls_facil,"Are you sure you want to delete this " + ls_facil + " , and ALL connected " + ls_app + " data including Action Items and Plan IDs?", Question!, YesNo!, 2 )
 //End Code Change ----08.10.2010 #V10 maha
 
IF li_ans = 1 THEN  //Start Code Change ----06.16.2011 #V11 maha - second trap
	if gs_cust_type = "I" then
		li_ans = MessageBox( "Deleting " + ls_facil,"Are you POSITIVE you want to delete this " + ls_facil + ".  This will delete ALL connected " + ls_app + " data including Action Items and Plan IDs?  THIS IS NOT JUST THE ACTION RECORD!", Question!, YesNo!, 2 )
	else
		li_ans = MessageBox( "Deleting the " + ls_facil,"Are you POSITIVE you want to delete this " + ls_facil + "?  This will delete the Appointment record and ALL connected " + ls_app + " data including Action Items and Plan IDs as well as connected Staff Category~r,Departmant, Committee, Address links data, etc.  THIS IS NOT JUST THE ACTION RECORD!", Question!, YesNo!, 2 )		
	end if
end if

IF li_ans = 1 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-24
	//$<add> 03.29.2006 By: Cao YongWang
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------
	delete from pd_affil_dept
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;

	delete from pd_comm_review
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
   delete from pd_affil_staff_cat
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_affil_staff_leave
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_address_link
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_questions
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_group_providers
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_hosp_facility_link 
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from pd_spec_facility_link 
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from net_dev_action_items
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	delete from net_dev_ids
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	//Start Code Change ----10.27.2014 #V14.2 maha - added
	delete from pd_appl_tracking
	where facility_id = :ii_facility_id and prac_id = :il_prac_id;
	
	Commit Using SQLCA;
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-25
	//$<add> 03.29.2006 By: Cao YongWang
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.	gnv_appeondb.of_commitqueue()
	//---------------------------- APPEON END ----------------------------
	
	//Start Code Change ---- 01.17.2006 #198 maha
	//inv_data_entry.of_field_audit( This ) //maha 011706
	inv_data_entry.of_field_audit_delete_last( this, this.getrow())  //Start Code Change ----08.03.2012 #V12 maha - changed to delete last function as the other did not work
	//End Code Change---01.17.2006 

	This.DeleteRow( This.GetRow() )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-26
	//$<add> 03.29.2006 By: Cao YongWang
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------
	This.Update()
	
	Commit Using SQLCA;
	
	dw_orgs_facilities.SetRedraw( False) //alfee 11.22.2010
	dw_orgs_facilities.Retrieve( il_prac_id,gs_user_id )
	dw_orgs_facilities.SetRedraw( True) //alfee 11.22.2010	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-27
	//$<add> 03.29.2006 By: Cao YongWang
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue()
	//---------------------------- APPEON END ----------------------------
END IF

Return -1
end event

event pfc_preupdate;call super::pfc_preupdate;
//Start Code Change ---- 01.17.2006 #199 maha
inv_data_entry.of_field_audit( This ) //maha 011706
//End Code Change---01.17.2006 
return 1
end event

event pfc_addrow;call super::pfc_addrow; //Start Code Change ----08.18.2015 #V15 maha
 return 0
end event

type dw_tracking from u_dw within tabpage_ai
event ue_tracking_loc_changed ( )
integer y = 1072
integer width = 3387
integer height = 568
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_appl_tracking_w_loc"
boolean vscrollbar = false
end type

event ue_tracking_loc_changed();//Start Code Change ----04.28.2014 #V14.2 maha
long ll_pre
long ll_post
long r


ll_pre = this.getitemnumber( 1, "gp_id", primary!, true)
ll_post = this.getitemnumber( 1, "gp_id", primary!, false)

//messagebox(string(ll_pre), string(ll_post))
for r = 1 to tab_1.tabpage_ai.dw_net_dev.rowcount()
	tab_1.tabpage_ai.dw_net_dev.setitem(r,"gp_id", ll_post)
next

//Start Code Change ----05.30.2014 #V14.2 maha
if this.getitemnumber( 1, "par_status", primary!, false) = 100 then
	long ll_null
	setnull(ll_null)
	this.setitem(1, "par_status", ll_null)
end if
//End Code Change ----05.30.2014


end event

event destructor;call super::destructor;this.settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;//Start Code Change ----09.14.2012 #V12 maha
//Moved to the of_set_par_status () for BugL082201 - alfee 09.26.2012

//long ll_app
//long ll_fac
//long ll_prac
//long ll_find
//integer li_stat
//string ls_find
//
//debugbreak()
//if dwo.name = "par_status" then
//	ll_prac = this.getitemnumber( row,"prac_id") 
//	ll_app = this.getitemnumber( row,"app_id") 
//	ll_fac = this.getitemnumber( row,"facility_id") 
//	li_stat =  this.getitemnumber( row,"par_status") 
//	ls_find = "prac_id = " + string(ll_prac) + " and app_id = " + string(ll_app) + " and parent_facility_id = " + string(ll_fac) 
//	ll_find = dw_orgs_facilities.find( ls_find, 1, dw_orgs_facilities.rowcount())
//	if ll_find < 0 then messagebox("Find error in dw_tracking.itemchanged",ls_find)
//	if ll_find > 0 then dw_orgs_facilities.setitem(ll_find,"pd_appl_tracking_par_status",li_stat)
//end if
//
//return 1
//Start Code Change ----04.28.2014 #V14.2 maha

ib_save = True //Added by Appeon long.zhang 10.28.2014

post event ue_tracking_loc_changed( )

return 0 
end event

event pfc_postupdate;call super::pfc_postupdate;//For BugL082201 - alfee  09.26.2012

return of_set_par_status () 
end event

event pfc_addrow;return 1  //Start Code Change ----03.13.2014 #V14.2 maha - added to prevent the manual addition of records.
end event

event pfc_preupdate;call super::pfc_preupdate;if this.rowcount() = 0 then return 1
if isnull(this.getitemnumber(1,"gp_id")) then 	//Start Code Change ----05.08.2014 #V14.2 maha
	this.setitem(1, "gp_id",  0) 
end if

return 1
end event

event resize;call super::resize;//of_resize_ manual()//Added by Appeon long.zhang 10.17.2014//Comment by Appeon long.zhang 04.15.2016 (Issues with V15 Build 4/13/16)
end event

event pfc_deleterow;call super::pfc_deleterow;//Added by Appeon long.zhang 10.28.2014
ib_save = True

Return Success
end event

event editchanged;call super::editchanged;ib_save = True //Added by Appeon long.zhang 10.28.2014
end event

event constructor;call super::constructor; //Start Code Change ----08.13.2015 #V15 maha
of_hide_tracking_fields()
end event

event buttonclicked;call super::buttonclicked; //Start Code Change ----10.29.2015 #V15 maha - moved from Screen button
if dwo.name = "b_change" then
	if of_change_facility() = 1 then
		if isvalid(w_prac_data_sk) then
			w_prac_data_sk.cb_save.triggerevent(clicked!)
		elseif isvalid(w_prac_data_intelliapp) then
			w_prac_data_intelliapp.cb_save.triggerevent(clicked!)
		else
			w_prac_data_1.cb_save.triggerevent(clicked!)
		end if
		
	end if
elseif  dwo.name = "b_recalc" then  //Start Code Change ----02.04.2016 #V15 maha - moved from screen button
	of_appl_tracking_update_dw(tab_1.tabpage_ai.dw_tracking,tab_1.tabpage_ai.dw_net_dev,1)
end if
end event

type gb_filter_2 from groupbox within tabpage_report
boolean visible = false
integer x = 5
integer width = 2903
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 32891346
boolean enabled = false
string text = "Filter"
end type

type cb_2 from commandbutton within tabpage_report
boolean visible = false
integer x = 2958
integer y = 4
integer width = 123
integer height = 64
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "sort"
end type

event clicked;string null_str

SetNull(null_str)

tab_1.tabpage_report.dw_report_data.SetSort(null_str)

tab_1.tabpage_report.dw_report_data.Sort( )
end event

type tabpage_ar from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3474
integer height = 1644
boolean border = true
long backcolor = 16777215
string text = "AR Data"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_ar dw_ar
end type

on tabpage_ar.create
this.dw_ar=create dw_ar
this.Control[]={this.dw_ar}
end on

on tabpage_ar.destroy
destroy(this.dw_ar)
end on

type dw_ar from u_dw within tabpage_ar
integer x = 14
integer y = 8
integer width = 3374
integer height = 1660
integer taborder = 11
string dataobject = "d_ar_data_mockup"
boolean border = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.insertrow(1)

end event

type gb_filter_1 from groupbox within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 997
integer y = 28
integer width = 2811
integer height = 196
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Filter"
borderstyle borderstyle = stylebox!
end type

type cb_ma from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 9
integer y = 128
integer width = 969
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Multi App"
end type

event clicked;of_multi_add()
end event

type dw_payors from u_dw within pfc_ia_cst_nv_net_dev_new_maha152
event ue_after_retrieve ( )
boolean visible = false
integer x = 14
integer y = 828
integer width = 974
integer taborder = 10
boolean titlebar = true
string title = "Payor / Hospital"
string dataobject = "d_net_dev_payors_hospitals"
end type

event ue_after_retrieve();IF tab_1.tabpage_ids.dw_ids.RowCount() = 0 AND il_app_id > 0 and ii_facility_id > 0 THEN //Start Code Change ----01.25.2012 #V12 maha - added trap for 0 facility
	tab_1.tabpage_ids.dw_ids.InsertRow( 0 )
END IF
end event

event clicked;Integer li_retval

li_retval = of_save()

IF li_retval < 0 THEN
	Return 1
END IF

Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	tab_1.tabpage_ai.dw_net_dev.SetFocus( )
	Return -1
END IF

ib_report_filter = true ////Start Code Change ----11.10.2008 #V85 maha
This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )

end event

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

//$<add> 07.07.2008 by Andy
String ls_lable
SELECT TOP 1 app_stat_app_label INTO :ls_lable FROM icred_settings;

IF LenA(Trim(ls_lable)) > 0 then
	this.Title = ls_lable
END IF
//end add 07.07.2008
end event

event retrieveend;call super::retrieveend;il_app_id = 0
IF This.RowCount() > 0 THEN
	This.InsertRow( 1 )
	This.SetItem( 1, "app_id", 0 )	
	This.SetItem( 1, "application_name", "All" )

	IF rowcount > 1 THEN
		//--------Begin Modified by  Nova 07.12.2010------------------------
		//		This.SetRow( 2 )
		//		This.SelectRow( 0, False )
		//		This.SelectRow( 2, True )
				This.SetRow( 1 )
				This.SelectRow( 0, False )
				This.SelectRow( 1, True )
		//--------End Modified --------------------------------------------
	END IF	
	
	of_filter_ids( )		
	
ELSE
	This.InsertRow( 1 )
	This.SetItem( 1, "app_id", 0 )		
	This.SetItem( 1, "application_name", "**No Payor / Hospital**" )	
	//tab_1.tabpage_ids.dw_ids.Reset( )
END IF


//messagebox("", "set to true")
//ib_done_retrieving_orgs = True


end event

event rowfocuschanged;call super::rowfocuschanged;String ls_sql
Integer li_rc

//messagebox("payor", "rowfocus" )
IF currentrow > 0 THEN

	IF This.GetItemNumber( 1, "app_id" ) <> 0 THEN
		Return
	END IF	

	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
	
	il_app_id = This.GetItemNumber( currentrow, "app_id" )
	ls_sql = is_sql
	
	IF il_app_id > 0 THEN
		//ls_sql = ls_sql + " AND net_dev_action_items.app_id = " + String( il_app_id ) //Commented By Ken.Guo 09-24-2008
		ls_sql = ls_sql + " AND net_dev_action_items.app_id = " + String( il_app_id ) //Added By Ken.Guo 09-24-2008
	ELSEIF IsNull(il_app_id) THEN
		ls_sql = ls_sql + " AND net_dev_action_items.app_id is null " //Added by Evan 12-31-2008
	END IF
	
	IF lb_from_prac_folder THEN
		ls_sql = ls_sql + " AND net_dev_action_items.prac_id = " + String( il_prac_id ) 
		IF ii_facility_id > 0 THEN
			ls_sql = ls_sql + " AND net_dev_action_items.facility_id = " + String( ii_facility_id )
		END IF
	ELSE
		IF ii_facility_id <> 0 THEN
			ls_sql = ls_sql + " AND net_dev_action_items.facility_id = " + String( ii_facility_id )
		END IF
	END IF
	
	tab_1.tabpage_ai.dw_net_dev.SetRedraw( False ) //alfee 11.22.2010
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-11-09 By: Cao YongWang
	//$<reason> Replaced SetSqlSelect function with modify function
	//	tab_1.tabpage_ai.dw_net_dev.SetSQlSelect( ls_sql )	
	//tab_1.tabpage_ai.dw_net_dev.modify('datawindow.table.select="'+ ls_sql + '"')	//Commented By Ken.Guo 09-24-2008
	tab_1.tabpage_ai.dw_net_dev.modify("datawindow.table.select='"+ ls_sql + "'")  //Added By Ken.Guo 09-24-2008. must use single quotes.
	//---------------------------- APPEON END ----------------------------
	tab_1.tabpage_ai.dw_net_dev.SetTransObject( SQLCA )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-28
	//$<add> 03.16.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.

 	gnv_appeondb.of_imdcall()
	//---------------------------- APPEON END ----------------------------
	li_rc = tab_1.tabpage_ai.dw_net_dev.Retrieve( )

	IF li_rc = 0 THEN
		tab_1.tabpage_ai.dw_net_dev.InsertRow( 0 )
		//------------------- APPEON BEGIN -------------------
		//$<add> Michael 06.23.2011
		//$<reason> V11.3 Action Item Dates
		//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_date",datetime(today(),now()))
		//tab_1.tabpage_ai.dw_net_dev.setitem(1,"net_dev_action_items_create_user",gs_user_id)
		//------------------- APPEON END ---------------------
		tab_1.tabpage_notes.dw_notes.InsertRow( 0 )		
	END IF

	tab_1.tabpage_ai.dw_net_dev.Modify("DataWindow.Table.UpdateTable='net_dev_action_items'")	
	
	IF tab_1.SelectedTab = 1 THEN
		tab_1.tabpage_ai.dw_net_dev.SetFocus( )
	ELSEIF tab_1.SelectedTab = 2 THEN
		tab_1.tabpage_ids.dw_ids.SetFocus( )
	ELSEIF tab_1.SelectedTab = 3 THEN
		tab_1.tabpage_notes.dw_notes.SetFocus( )
	END IF
	tab_1.tabpage_ai.dw_net_dev.SetRedraw( True ) //alfee 11.22.2010
END IF

IF gi_intelliapp_type > 0 THEN
	tab_1.tabpage_ai.dw_net_dev.SetRedraw( True )
END IF
st_as_msg.visible = false //maha 062905

of_filter_ids( )
if ib_report_filter then
	of_report_selected_ver9( "NONE") //Start Code Change ----11.10.2008 #V85 maha
	ib_report_filter = false
	ddlb_zoom.Text = "100%" //Add by Evan 05.18.2009 --- Corrected BugS030404
end if
end event

event rowfocuschanging;call super::rowfocuschanging;IF currentrow > 0 THEN
	IF tab_1.tabpage_ids.dw_ids.GetItemStatus( 1, 0, Primary! ) = New! THEN
		tab_1.tabpage_ids.dw_ids.DeleteRow( 1 )
	END IF
END IF

//Integer li_retval
//
//li_retval = of_save()
////messagebox("bottom", li_retval )
//IF li_retval < 0 THEN
//	Return 1
//END IF
//
end event

type st_as_msg from statictext within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 82
integer y = 2580
integer width = 3154
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_facility_add from u_dw within pfc_ia_cst_nv_net_dev_new_maha152
boolean visible = false
integer x = 507
integer y = 728
integer width = 361
integer height = 252
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_status_ia"
end type

type cb_batch from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 9
integer y = 32
integer width = 969
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Add"
end type

event clicked;
openwithparm(w_batch_add_apps_facilities_response, string(il_prac_id) + "*P" ) //Start Code Change ----12.11.2008 #V85 maha - changed window for modal problem

//Start Code Change ----04.28.2009 #V92 maha
if message.stringparm = "Print" then //when the user prints without creating action items the retrieval does not need to take place
	//skip retrieve
else
	dw_orgs_facilities.SetRedraw( False) //alfee 11.22.2010	
	dw_orgs_facilities.Retrieve( il_prac_id, gs_user_id )
	dw_orgs_facilities.SetRedraw( True) //alfee 11.22.2010	
	//Start Code Change ---- 11.17.2014 #V14.2 maha - added te be sure tabs are refreshed
	IF  Isvalid(w_prac_data_1) then
		w_prac_data_1.ib_app_audit_retrieved = False
		w_prac_data_1.ib_affil_stat_retrieved = False
		w_prac_data_1.ib_verif_info_retrieved = False
		w_prac_data_1.ib_priv_retrieved = False
	end if	
	//End Code Change ---- 11.17.2014
end if
//End Code Change---04.28.2009
end event

type p_1 from picture within pfc_ia_cst_nv_net_dev_new_maha152
boolean visible = false
integer x = 3840
integer y = 60
integer width = 82
integer height = 64
boolean bringtotop = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cbx_compl from checkbox within pfc_ia_cst_nv_net_dev_new_maha152
boolean visible = false
integer x = 2816
integer y = 240
integer width = 727
integer height = 68
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
string text = "Include All Status"
boolean checked = true
end type

event clicked;//alfee 10.20.2010

ib_cbx_compl_changed = true
ib_cbx_compl_checked = this.checked

Parent.event pfc_cst_retrieve_detail ()

ib_cbx_compl_changed = false

end event

event constructor;ib_cbx_compl_checked = cbx_compl.checked //alfee10.29.2010
end event

type cb_change from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
boolean visible = false
integer x = 2501
integer y = 40
integer width = 101
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change Facility/Group"
end type

event clicked;if of_change_facility() = 1 then
	if isvalid(w_prac_data_sk) then
		w_prac_data_sk.cb_save.triggerevent(clicked!)
	elseif isvalid(w_prac_data_intelliapp) then
		w_prac_data_intelliapp.cb_save.triggerevent(clicked!)
	else
		w_prac_data_1.cb_save.triggerevent(clicked!)
	end if
	
end if
end event

type st_filter from statictext within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 1029
integer y = 112
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Quick Filter:"
boolean focusrectangle = false
end type

type dw_qf from datawindow within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 1312
integer y = 104
integer width = 1006
integer height = 76
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_quick_filter"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild
Integer li_nr
Long ll_action_status
Long ll_par
Long ll_app_rcvd_prac
Long ll_app_rcvd_payor
Long ll_app_out_to_md

This.InsertRow( 0)

This.GetChild( "quick_filter", dwchild )

li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "No Filter Selected" )
dwchild.SetItem( li_nr, "filter_description", "No Filter Selected" )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1" )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-29
//$<modify> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
END IF

select lookup_code into :ll_par from code_lookup where lookup_name = 'Action Type' and code = 'PAR';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF

select lookup_code into :ll_app_out_to_md from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF


select lookup_code into :ll_app_rcvd_prac from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Prac' code to the Action Type lookup table." )
END IF

select lookup_code into :ll_app_rcvd_payor from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Payor';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Payor' code to the Action Type lookup table." )
END IF
*/
//select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
ll_action_status = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Status') + "' and upper(code) = '"+upper('Incomplete') +"'"))

//select lookup_code into :ll_par from code_lookup where lookup_name = 'Action Type' and code = 'PAR';
ll_par = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Type') + "' and upper(code) = '"+upper('PAR') +"'"))

//select lookup_code into :ll_app_out_to_md from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
ll_app_out_to_md = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Type') + "' and upper(code) = '"+upper('App Out To MD') +"'"))

//select lookup_code into :ll_app_rcvd_prac from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
ll_app_rcvd_prac = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Type') + "' and upper(code) = '"+upper('App Rcvd Prac') +"'"))

//select lookup_code into :ll_app_rcvd_payor from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Payor';
ll_app_rcvd_payor = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Type') + "' and upper(code) = '"+upper('App Rcvd Payor') +"'"))
//---------------------------- APPEON END ----------------------------

//Due Today
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Items Due TODAY" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of Action Item due TODAY." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND DaysAfter( due_date, today() ) = 0 AND action_status = " + String( ll_action_status )  )

//Over Due items
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Items Over Due" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of Action Item that are overdue." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND DaysAfter( today(), due_date ) < 0 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 1  )

//Application Not Back From Provider
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Applications Not Back From Provider" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of App Rcvd Prac Action Item that are overdue." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_app_rcvd_prac ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 2  )

//Applications needing printing
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Applications Needing Printed" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of Applications needing prining." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_app_out_to_md ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 2  )

//Application Not Back From Plan/Org
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "PAR # Not Back From Payor" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of Par # Action Items that are overdue." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND DaysAfter( today(), due_date ) <= 0 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 3  )

//Items Due in the next 7 days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Items Due in the next 7 days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of Action Item that are due in the next 7 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND DaysAfter( today(), due_date ) >= 0 AND DaysAfter( RelativeDate(today(),7), due_date ) <= 7 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 4  )

//Show Inactive History records
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Show History Records" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of all Action Item that are Inactive (History)." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 0" )
dwchild.SetItem( li_nr, "filter_index", 5  )

//Outstanding PAR # 0 - 30 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Outstanding PAR # 0 - 30 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of PAR Action Item that have been incomplete for between 1 - 30." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -30) AND action_date >= Today() )" )
dwchild.SetItem( li_nr, "filter_index", 6  )

//Outstanding PAR # 31 - 60 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Outstanding PAR # 30 - 60 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of PAR Action Item that have been incomplete for between 30 - 60 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -30) AND action_date >= RelativeDate( Today(), -60))" )
dwchild.SetItem( li_nr, "filter_index", 7  )

//Outstanding PAR # 61 - 90 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Outstanding PAR # 60 - 90 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of PAR Action Item that have been incomplete for between 60 - 90 days." )
//dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND action_date <= RelativeDate( Today(), -90)" )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -60) AND action_date >= RelativeDate( Today(), -90))" ) //alfee 01.11.2011
dwchild.SetItem( li_nr, "filter_index", 8  )

//Outstanding PAR # > 90 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Outstanding PAR # > 90 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of PAR Action Item that have been incomplete for over 90 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND action_date <= RelativeDate( Today(), -90)" )
dwchild.SetItem( li_nr, "filter_index", 9  )

//applications not received back from prac in last 15 days
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-30
//$<modify> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
select lookup_code into :ll_par from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Error 3", "You will need to add a 'App Rcvd Prac' code to the Action Status lookup table." )
END IF
*/
ll_par = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Type') + "' and upper(code) = '"+upper('App Rcvd Prac') +"'"))
//---------------------------- APPEON END ----------------------------

//Outstanding PAR # 1 - 7 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Apps Not Recieved From Prac 0 - 7 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of practitioners that have not sent back their applications for between 1 and 7 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -7) AND action_date >= Today() )" )
dwchild.SetItem( li_nr, "filter_index", 10  )

//Outstanding PAR # 7 - 15 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Apps Not Recieved From Prac 7 - 15 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of practitioners that have not sent back their applications for between 7 and 15 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -7) AND action_date >= RelativeDate( Today(), -15))" )
dwchild.SetItem( li_nr, "filter_index", 11  )

//Outstanding PAR # 15 - 30 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Apps Not Recieved From Prac 15 - 30 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of practitioners that have not sent back their applications for between 15 and 30 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -15) AND action_date >= RelativeDate( Today(), -30))" )
dwchild.SetItem( li_nr, "filter_index", 12  )

//Outstanding PAR # - 30 Days
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "Apps Not Recieved From Prac Over 30 Days" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of practitioners that have not sent back their applications for more than 30 days." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_type = " + String( ll_par ) + " AND action_status = " + String( ll_action_status ) + " AND (action_date <= RelativeDate( Today(), -30))" )
dwchild.SetItem( li_nr, "filter_index", 13  )


end event

event itemchanged;
//String ls_filter

//ls_filter = data

of_set_quick_filter( data )

//IF IsNull( ls_filter ) OR ls_filter = "" THEN
//	tab_1.tabpage_ai.dw_net_dev.SetFilter( "" )
//ELSE
//	tab_1.tabpage_ai.dw_net_dev.SetFilter( ls_filter )
//END IF
//
//tab_1.tabpage_ai.dw_net_dev.Filter( )
//
////st_as_msg.Visible = False
end event

type st_group_by from statictext within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 2336
integer y = 116
integer width = 238
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Group By:"
boolean focusrectangle = false
end type

type ddlb_group_by from dropdownlistbox within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 2574
integer y = 104
integer width = 663
integer height = 444
integer taborder = 60
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
string item[] = {"Practitioner","Payer","Client/Group"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.Text =  "Practitioner"
end event

event selectionchanged;//Is_group_by

IF index = 1 THEN
	is_group_by = "Practitioner"
ELSEIF index = 2 THEN
	is_group_by = "Payor"
ELSE
	is_group_by = "Client"
END IF

//of_report_selected( "" )
of_report_selected_ver9( "NONE") //Start Code Change ----11.10.2008 #V85 maha

//Integer li_facility_id
//
//IF index = 2 THEN
//	IF ib_status_with_notes THEN
//		tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_rep_by_payer_wn"
//	ELSE
//		tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_payer"
//	END IF
//	CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		//MULTI SITE GROUP
//	CASE 1
//		tab_1.tabpage_report.dw_report_data.Modify( "type_t.text = 'Group'" )
//		//BILLING COMPANY
//	CASE 2
//		tab_1.tabpage_report.dw_report_data.Modify( "type_t.text = 'Client'" )		
//	END CHOOSE	
//ELSEIF index = 3 THEN
//	tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_payer_m"
//	CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		//MULTI SITE GROUP
//	CASE 1
//		tab_1.tabpage_report.dw_report_data.Modify( "type_t.text = 'Group/Application'" )
//		//BILLING COMPANY
//	CASE 2
//		tab_1.tabpage_report.dw_report_data.Modify( "type_t.text = 'Client/Application'" )		
//	END CHOOSE		
//ELSEIF index = 1 THEN
//	IF ib_status_with_notes THEN
//		tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_prac_wn"		
//	ELSE
//		tab_1.tabpage_report.dw_report_data.DataObject = "d_net_dev_action_items_report_by_prac"
//	END IF
//END IF
//
//li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "parent_facility_id")
//tab_1.tabpage_report.dw_report_data.Reset()
//tab_1.tabpage_report.dw_report_data.SetTransObject( sqlca )
////tab_1.tabpage_report.dw_report_data.Modify("DataWindow.Zoom = 90")
//of_retrieve_detail( ii_facility_id )
//
//DataWindowChild dwchild
//
//tab_1.tabpage_report.dw_report_data.GetChild( "action_dept", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( "Action Department" )
//
//tab_1.tabpage_report.dw_report_data.GetChild( "action_type", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( "Action Type" )
//
//tab_1.tabpage_report.dw_report_data.GetChild( "action_status", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( "Action Status" )
//
//tab_1.tabpage_report.dw_report_data.GetChild( "app_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( )
//
//
//IF index = 2 THEN
//	tab_1.tabpage_report.dw_report_data.SetSort( "v_full_name_full_name A, facility_name1 A, action_date D" )
//ELSEIF index = 3 THEN
//	tab_1.tabpage_report.dw_report_data.SetSort( "facility_name1 A, app_id A, v_full_name_full_name A, action_date D" )
//ELSEIF index = 1 THEN
//	tab_1.tabpage_report.dw_report_data.SetSort( "facility_name1 A, v_full_name_full_name A, action_date D" )
//END IF
//
//tab_1.tabpage_report.dw_report_data.Sort()
end event

type st_zoom from statictext within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 3255
integer y = 112
integer width = 151
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Zoom:"
boolean focusrectangle = false
end type

type ddlb_zoom from dropdownlistbox within pfc_ia_cst_nv_net_dev_new_maha152
integer x = 3406
integer y = 104
integer width = 247
integer height = 524
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"100%","90%","80%","70%","60%","50%"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.Text = "90%"
end event

event selectionchanged;tab_1.tabpage_report.dw_report_data.Modify("DataWindow.Zoom = " + MidA(ddlb_zoom.Text, 1, LenA(ddlb_zoom.Text) -1 ) )
end event

type cb_3 from commandbutton within pfc_ia_cst_nv_net_dev_new_maha152
boolean visible = false
integer x = 233
integer y = 2056
integer width = 343
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "none"
end type

event clicked;long f

f = dw_orgs_facilities.getRow ()
//messagebox("",gi_intelliapp_type)
//	dw_orgs_facilities.SelectRow( 0, False )
//	dw_orgs_facilities.SelectRow( f, True )
end event

