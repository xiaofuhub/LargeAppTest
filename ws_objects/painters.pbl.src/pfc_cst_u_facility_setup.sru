$PBExportHeader$pfc_cst_u_facility_setup.sru
forward
global type pfc_cst_u_facility_setup from userobject
end type
type cb_links from commandbutton within pfc_cst_u_facility_setup
end type
type cb_notes from u_cb within pfc_cst_u_facility_setup
end type
type st_step from statictext within pfc_cst_u_facility_setup
end type
type cb_next_tab from u_cb within pfc_cst_u_facility_setup
end type
type cb_user from u_cb within pfc_cst_u_facility_setup
end type
type cb_add from u_cb within pfc_cst_u_facility_setup
end type
type cb_delete from u_cb within pfc_cst_u_facility_setup
end type
type cb_print from u_cb within pfc_cst_u_facility_setup
end type
type cb_save from u_cb within pfc_cst_u_facility_setup
end type
type cb_close from u_cb within pfc_cst_u_facility_setup
end type
type tab_facilty from tab within pfc_cst_u_facility_setup
end type
type tabpage_browse from userobject within tab_facilty
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_facilty
dw_browse dw_browse
end type
type tabpage_address from userobject within tab_facilty
end type
type tabpage_address from userobject within tab_facilty
end type
type tabpage_return from userobject within tab_facilty
end type
type tabpage_return from userobject within tab_facilty
end type
type tabpage_settings from userobject within tab_facilty
end type
type tabpage_settings from userobject within tab_facilty
end type
type tabpage_npdb from userobject within tab_facilty
end type
type tabpage_npdb from userobject within tab_facilty
end type
type tabpage_verif from userobject within tab_facilty
end type
type cb_copy_rules from commandbutton within tabpage_verif
end type
type mle_3 from multilineedit within tabpage_verif
end type
type mle_2 from multilineedit within tabpage_verif
end type
type mle_1 from multilineedit within tabpage_verif
end type
type cb_2 from commandbutton within tabpage_verif
end type
type dw_verif_rules from u_dw within tabpage_verif
end type
type dw_select_section from u_dw within tabpage_verif
end type
type dw_copy_rules from u_dw within tabpage_verif
end type
type tabpage_verif from userobject within tab_facilty
cb_copy_rules cb_copy_rules
mle_3 mle_3
mle_2 mle_2
mle_1 mle_1
cb_2 cb_2
dw_verif_rules dw_verif_rules
dw_select_section dw_select_section
dw_copy_rules dw_copy_rules
end type
type tabpage_committee from userobject within tab_facilty
end type
type cb_del_all from u_cb within tabpage_committee
end type
type cb_del_m from u_cb within tabpage_committee
end type
type cb_non_prac from u_cb within tabpage_committee
end type
type cb_batch from u_cb within tabpage_committee
end type
type cb_member from u_cb within tabpage_committee
end type
type dw_committee_mem from u_dw within tabpage_committee
end type
type dw_committee_d from u_dw within tabpage_committee
end type
type cb_add_committee from u_cb within tabpage_committee
end type
type dw_committee from u_dw within tabpage_committee
end type
type cb_del_committee from u_cb within tabpage_committee
end type
type gb_committee from groupbox within tabpage_committee
end type
type gb_comm_member from groupbox within tabpage_committee
end type
type tabpage_committee from userobject within tab_facilty
cb_del_all cb_del_all
cb_del_m cb_del_m
cb_non_prac cb_non_prac
cb_batch cb_batch
cb_member cb_member
dw_committee_mem dw_committee_mem
dw_committee_d dw_committee_d
cb_add_committee cb_add_committee
dw_committee dw_committee
cb_del_committee cb_del_committee
gb_committee gb_committee
gb_comm_member gb_comm_member
end type
type tabpage_dept_chair from userobject within tab_facilty
end type
type cb_1 from commandbutton within tabpage_dept_chair
end type
type cb_del_chair1 from u_cb within tabpage_dept_chair
end type
type cb_add_chair1 from u_cb within tabpage_dept_chair
end type
type dw_dc_browse from u_dw within tabpage_dept_chair
end type
type dw_dc_detail from u_dw within tabpage_dept_chair
end type
type tabpage_dept_chair from userobject within tab_facilty
cb_1 cb_1
cb_del_chair1 cb_del_chair1
cb_add_chair1 cb_add_chair1
dw_dc_browse dw_dc_browse
dw_dc_detail dw_dc_detail
end type
type tabpage_workflow from userobject within tab_facilty
end type
type tabpage_workflow from userobject within tab_facilty
end type
type tabpage_webview from userobject within tab_facilty
end type
type tabpage_webview from userobject within tab_facilty
end type
type tab_facilty from tab within pfc_cst_u_facility_setup
tabpage_browse tabpage_browse
tabpage_address tabpage_address
tabpage_return tabpage_return
tabpage_settings tabpage_settings
tabpage_npdb tabpage_npdb
tabpage_verif tabpage_verif
tabpage_committee tabpage_committee
tabpage_dept_chair tabpage_dept_chair
tabpage_workflow tabpage_workflow
tabpage_webview tabpage_webview
end type
type dw_detail from u_dw within pfc_cst_u_facility_setup
end type
end forward

global type pfc_cst_u_facility_setup from userobject
integer width = 4421
integer height = 2092
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_links cb_links
cb_notes cb_notes
st_step st_step
cb_next_tab cb_next_tab
cb_user cb_user
cb_add cb_add
cb_delete cb_delete
cb_print cb_print
cb_save cb_save
cb_close cb_close
tab_facilty tab_facilty
dw_detail dw_detail
end type
global pfc_cst_u_facility_setup pfc_cst_u_facility_setup

type variables
Long il_last_dept_chair
w_response iw_parent_window
long il_facility_id
Boolean ib_adding_new = False
Boolean ib_rules_added = True
Boolean ib_fld_error
Boolean ib_tab_change = False
Integer il_last_tab = 2
string is_openfrom = ""  //maha 04.02.2014

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> Performance tuning.
//$<modification> Define a variable to validate whether the application is running
//$<modification> on the Web.
Boolean ib_web = False
Boolean ib_retrieve_wf = False
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_set_parent_window (w_response aw_parent_window)
public function integer of_retrieve_detail ()
public function integer of_tab_order_off ()
public function integer of_se ()
public subroutine of_retrieve_work_flow ()
public subroutine of_filter_docs (boolean ab_warning)
public subroutine of_setlabel ()
public function integer of_retrieve_comm_detail ()
public function integer of_batch_add (gs_batch_search ast_search, long al_comm_id, long al_facility)
public function integer of_retrieve_committees ()
public function integer of_ro_security ()
public function integer of_rules_child ()
public function integer of_set_screen_color ()
end prototypes

public function integer of_set_parent_window (w_response aw_parent_window);iw_parent_window = aw_parent_window
of_ro_security( )  //Start Code Change ----08.22.2011 #V11 maha 

 //Start Code Change ----10.26.2015 #V15 maha - simple
 if of_get_app_setting("set_86","I") = 1 then
	cb_add.visible = false
	cb_delete.visible = false
	tab_facilty.tabpage_browse.visible = false
end if
 //End Code Change ----10.26.2015 
 
//Start Code Change ----11.09.2016 #V153 maha 
 if of_get_app_setting("set_35","I") < 2 then 
	dw_detail.modify("b_bill_rules.visible = false")
	dw_detail.modify("gb_bill.text = ''")
	dw_detail.modify("bill_ver.visible = false")
	dw_detail.modify("bill_apps.visible = false")
	dw_detail.modify("bill_recur.visible = false")	
end if
//End Code Change ----11.09.2016


RETURN 0
end function

public function integer of_retrieve_detail ();tab_facilty.tabpage_browse.dw_browse.of_SetTransObject( SQLCA )
tab_facilty.tabpage_browse.dw_browse.of_SetUpdateAble( False )

//Start Code Change ----11.01.2011 #V12 maha - moved to constructor of the DW
//tab_facilty.tabpage_verif.dw_verif_rules.of_SetTransObject( SQLCA )
//tab_facilty.tabpage_verif.dw_verif_rules.of_SetUpdateAble( True )
//tab_facilty.tabpage_verif.dw_verif_rules.of_SetReqColumn( True )
//End Code Change ----11.01.2011 

dw_detail.of_SetTransObject( SQLCA )
dw_detail.of_SetUpdateAble( True )
dw_detail.of_SetReqColumn( True )

tab_facilty.tabpage_verif.dw_select_section.of_Setupdateable(False)
tab_facilty.tabpage_verif.dw_select_section.of_SetTransObject( SQLCA )

tab_facilty.tabpage_browse.dw_browse.Retrieve( )

if gs_cust_type = 'I' then
	//dw_detail.object.default_data_view_id.visible = false
	dw_detail.object.appointment_years.visible = false
	dw_detail.object.default_verif_facility.visible = false
	dw_detail.object.default_audit_temp.visible = false
	dw_detail.object.default_appt_type.visible = false
	dw_detail.object.default_affil_status.visible = false
	dw_detail.object.default_user.visible = false
	dw_detail.object.default_user.visible = false
	dw_detail.object.priv_template.visible = false
	dw_detail.object.work_gap_check.visible = false
	dw_detail.object.ia_reapp_ai_process.visible = false
	dw_detail.object.reap_user.visible = false
	dw_detail.object.reappointment_query_days.visible = false
	dw_detail.object.reapp_doc_name.visible = false
	dw_detail.object.prov_doc_name.visible = false
	dw_detail.object.reappah_doc_name.visible = false
	dw_detail.object.reapp_export_id.visible = false
	dw_detail.object.prov_export_id.visible = false
	dw_detail.object.ia_reapp_app.visible = false
	dw_detail.object.reappah_app_id.visible = false
	dw_detail.object.reappah_export_id.visible = false
	dw_detail.object.prov_app_id.visible = false
	dw_detail.object.reapp_export.visible = false
	dw_detail.object.prov_export.visible = false
	dw_detail.object.reappah_export.visible = false
	dw_detail.object.t_21.visible = false
	dw_detail.object.dupeset.visible = false
end if

RETURN 0
end function

public function integer of_tab_order_off ();//dw_detail.AcceptText()
//
//dw_detail.SetTabOrder( "facility_name", 0 )
//dw_detail.SetTabOrder( "street", 0 )
//dw_detail.SetTabOrder( "street_2", 0 )
//dw_detail.SetTabOrder( "city", 0 )
//dw_detail.SetTabOrder( "state", 0 )
//dw_detail.SetTabOrder( "zip", 0 )
//dw_detail.SetTabOrder( "phone", 0 )
//dw_detail.SetTabOrder( "ext", 0 )
//dw_detail.SetTabOrder( "fax", 0 )
//dw_detail.SetTabOrder( "contact", 0 )
//dw_detail.SetTabOrder( "web_address", 0 )
//dw_detail.SetTabOrder( "email_address", 0 )
//dw_detail.SetTabOrder( "return_facility_name", 0 )
//dw_detail.SetTabOrder( "return_street", 0 )
//dw_detail.SetTabOrder( "return_street_2", 0 )
//dw_detail.SetTabOrder( "return_city", 0 )
//dw_detail.SetTabOrder( "return_state", 0 )
//dw_detail.SetTabOrder( "return_zip", 0 )
//dw_detail.SetTabOrder( "credentialing_contact_name", 0 )
//dw_detail.SetTabOrder( "credentialing_contact_title", 0 )
//dw_detail.SetTabOrder( "return_phone", 0 )
//dw_detail.SetTabOrder( "return_ext", 0 )
//dw_detail.SetTabOrder( "return_fax", 0 )
//dw_detail.SetTabOrder( "default_data_view_id", 0 )
//dw_detail.SetTabOrder( "npdb_facility_ein", 0 )
//dw_detail.SetTabOrder( "npdb_password", 0 )
//dw_detail.SetTabOrder( "npdb_agent_ein", 0 )
//dw_detail.SetTabOrder( "letter_path", 0 )
//dw_detail.SetTabOrder( "reappointment_query_days", 0 )


RETURN 1
end function

public function integer of_se ();tab_facilty.tabpage_dept_chair.Visible = False
tab_facilty.tabpage_verif.Visible = False
//tab_facilty.tabpage_settings.Visible = False
cb_user.Visible = False
cb_add.Visible = False
cb_delete.Visible = False

cb_print.x = cb_save.x
cb_save.x = cb_user.x

Return 1
end function

public subroutine of_retrieve_work_flow ();//
DataWindowChild ldwc_child

gnv_appeondb.of_startqueue( )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.18.2006 By: Jervis
//$<reason> 
string ls_module
if of_get_app_setting("set_9","I") = 1 then
	ls_module = "02"
else
	ls_module = "01"
end if


dw_detail.Getchild('wf_expiring_appointment' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'004')

dw_detail.Getchild('wf_reappointment_initiated' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'005')

dw_detail.Getchild('wf_data_entry_complete' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'007')

dw_detail.Getchild('wf_practitioner_status_change' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'006')

dw_detail.Getchild('wf_new_practitioner' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'003')

dw_detail.Getchild('wf_data_value_comparison' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'009')

dw_detail.Getchild('wf_webview_application_complete' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'101')

dw_detail.Getchild('wf_webview_application_initiated' , ldwc_child)
ldwc_child.settransobject(SQLCA)
ldwc_child.retrieve(ls_module,'103')

//---------------------------- APPEON END ----------------------------
gnv_appeondb.of_commitqueue()
end subroutine

public subroutine of_filter_docs (boolean ab_warning);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_facility_setupof_filter_doc()
// $<arguments>
//    value	boolean	ab_warning
// $<returns>   (none)
// $<description> Filter data of the dropdown datawindow for verification 
// $<description> documents and expiration documents.
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2006 by Rodger Wu
//////////////////////////////////////////////////////////////////////
string ls_letterpath
Integer li_return
datawindowchild ldwc_doc

if gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '0' and &
			appeongetclienttype() = 'PB' then return;
			
//if ab_warning then
//	if dw_detail.GetItemNumber( 1, "facility_id" ) = 1 then
//		li_return = MessageBox( "IntelliSoft", "  Once you change Letter Path, the three fields of Reappointment Document in this tab, ~r~n" + &
//															"Expiration Letter Name and Verification Letter Name in Verif rule tab need to be reset.~r~n" + &
//															"In addition, All fields of Word Document Name in Letter Painter need to check and reset also. ~r~n~r~n" + &
//															"Are you sure to continue?", Exclamation!, YesNo! )
//	else
//		li_return = MessageBox( "IntelliSoft", "  Once you change Letter Path, the three fields of Reappointment Document in this tab, ~r~n" + &
//															"Expiration Letter Name and Verification Letter Name in Verif rule tab need to be reset.~r~n~r~n" + &
//															"Are you sure to continue?", Exclamation!, YesNo! )		
//	end if
//	if li_return = 2 then
//		dw_detail.SetItem( 1, "letter_path", dw_detail.GetItemString( 1, "letter_path", Primary!, True ))
//		dw_detail.SetItemStatus( 1, "letter_path", Primary!, NotModified! )
//	end if
//end if

ls_letterpath = dw_detail.GetItemString( 1, "letter_path" )

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-07-13 By: Scofield
//$<Reason> Prevent popup filter dialog
if Not IsNull(ls_letterpath) then
//---------------------------- APPEON END ----------------------------
	dw_detail.GetChild( "reapp_doc_name", ldwc_doc )
	ldwc_doc.SetFilter( "area_id = " + string( ls_letterpath ))
	ldwc_doc.Filter()
	
	dw_detail.GetChild( "prov_doc_name", ldwc_doc )
	ldwc_doc.SetFilter( "area_id = " + string( ls_letterpath )  )
	ldwc_doc.Filter()
	
	dw_detail.GetChild( "reappah_doc_name", ldwc_doc )
	ldwc_doc.SetFilter( "area_id = " + string( ls_letterpath )  )
	ldwc_doc.Filter()
	
	tab_facilty.tabpage_verif.dw_verif_rules.GetChild( "exp_cred_letter_doc_nm", ldwc_doc )
	ldwc_doc.SetFilter( "area_id = " + string( ls_letterpath )  )
	ldwc_doc.Filter()
	
	tab_facilty.tabpage_verif.dw_verif_rules.GetChild( "init_veif_letter_doc_nm", ldwc_doc )
	ldwc_doc.SetFilter( "area_id = " + string( ls_letterpath ) )
	ldwc_doc.Filter()
end if

end subroutine

public subroutine of_setlabel ();//====================================================================
// Event: of_setlabel()
//--------------------------------------------------------------------
// Description:
// Dynamically modify the Screen title and the Facility detail tab (tabpage_address) label to the facility_label
//--------------------------------------------------------------------
// Arguments:
// 		
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Jul 07,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_label
SELECT TOP 1 app_stat_facility_label INTO :ls_label FROM icred_settings;	
if isnull(ls_label) or trim(ls_label) = '' then ls_label = 'Facility'
iw_parent_window.Title = ls_label + " Setup"
tab_facilty.tabpage_address.text = ls_label + " Address"
//cb_add.text = '&Add ' + ls_label
//cb_delete.text = '&Delete ' + ls_label
//cb_print.text = '&Print ' + ls_label

end subroutine

public function integer of_retrieve_comm_detail ();//////////////////////////////////////////////////////////////////////
// $<function> of_retrieve_comm_detail
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long  ll_comm_id, ll_row
datawindowchild ldwc_set

ll_row = tab_facilty.tabpage_committee.dw_committee.getrow()

if ll_row < 1 then 
	tab_facilty.tabpage_committee.dw_committee_d.insertrow(0)
	return 0
end if

ll_comm_id =  tab_facilty.tabpage_committee.dw_committee.getitemnumber(ll_row, "committee_id")
tab_facilty.tabpage_committee.dw_committee_d.getchild("meeting_setting", ldwc_set)

//tab_facilty.tabpage_committee.dw_committee_d.retrieve(ll_comm_id)
tab_facilty.tabpage_committee.dw_committee_d.scrolltorow(ll_row)
tab_facilty.tabpage_committee.dw_committee_mem.retrieve(ll_comm_id)
ldwc_set.settransobject(sqlca)
ldwc_set.retrieve(il_facility_id)

return 1
end function

public function integer of_batch_add (gs_batch_search ast_search, long al_comm_id, long al_facility);//////////////////////////////////////////////////////////////////////
// $<function> of_batch_add
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long i
long ic
long li_prac_id, li_facility_id
long li_find
long li_nr, li_row
string ls_full_name,ls_email

ic = upperbound(ast_search.li_prac_id[])
for i = 1 to ic
	li_prac_id = ast_search.li_prac_id[i] 
	
	if  upperbound(ast_search.ll_facility[]) < i then
		li_facility_id = al_facility
	else
		li_facility_id =  ast_search.ll_facility[i] 
	end if
	
	ls_email = ''
	ls_full_name = ''
	if li_prac_id < 0 then
		gnv_appeondb.of_StartQueue()
		select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id ;
		select cust_7 into :ls_email from pd_basic where prac_id = :li_prac_id ; 
		gnv_appeondb.of_CommitQueue()
	else
		select a.full_name,b.e_mail_address into :ls_full_name, :ls_email
		   from {oj v_full_name a left outer join v_mailing_address b on a.prac_id = b.prac_id and b.facility_id =:li_facility_id}
		 where a.prac_id = :li_prac_id ;
	end if
	
	li_find = tab_facilty.tabpage_committee.dw_committee_mem.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN
		
	ELSE
		li_nr =  tab_facilty.tabpage_committee.dw_committee_mem.InsertRow( 0 )
		
		 tab_facilty.tabpage_committee.dw_committee_mem.SetItem( li_nr, "prac_id", li_prac_id )
		 tab_facilty.tabpage_committee.dw_committee_mem.SetItem( li_nr, "v_full_name_full_name", ls_full_name )
		 tab_facilty.tabpage_committee.dw_committee_mem.SetItem( li_nr, "committee_id", al_comm_id )
		 tab_facilty.tabpage_committee.dw_committee_mem.SetItem( li_nr, "email_address", ls_email )
		 tab_facilty.tabpage_committee.dw_committee_mem.SetItem( li_nr, "facility_id", li_facility_id)
	end if
	
next

return 1

end function

public function integer of_retrieve_committees ();//Start Code Change ----08.09.2011 #V11 maha - created

tab_facilty.tabpage_committee.dw_committee.retrieve(il_facility_id)

tab_facilty.tabpage_committee.dw_committee.sharedata( tab_facilty.tabpage_committee.dw_committee_d)


return 1
end function

public function integer of_ro_security ();//Start Code Change ----08.22.2011 #V11 maha -  added ro secruity

if w_mdi.of_security_access(470) < 2 then
	dw_detail.enabled = false
	tab_facilty.tabpage_verif.dw_verif_rules.enabled = false
	tab_facilty.tabpage_committee.dw_committee_d.enabled = false
	tab_facilty.tabpage_committee.dw_committee_mem.enabled = false
//	tab_facilty.tabpage_dept_chair.dw_dc_detail.enabled = false
	tab_facilty.tabpage_committee.cb_batch.enabled = false
	tab_facilty.tabpage_committee.cb_del_all.enabled = false
	tab_facilty.tabpage_committee.cb_del_committee.enabled = false
	tab_facilty.tabpage_committee.cb_del_m.enabled = false
	tab_facilty.tabpage_committee.cb_member.enabled = false
	tab_facilty.tabpage_committee.cb_non_prac.enabled = false
	tab_facilty.tabpage_committee.cb_add_committee.enabled = false
	tab_facilty.tabpage_dept_chair.dw_dc_detail.enabled = false
	tab_facilty.tabpage_dept_chair.cb_del_chair1.enabled = false
	tab_facilty.tabpage_dept_chair.cb_add_chair1.enabled = false
	cb_add.enabled = false
	cb_delete.enabled = false
	cb_save.enabled = false
	cb_user.enabled = false
end if

return 1
end function

public function integer of_rules_child ();//Start Code Change ----11.01.2011 #V12 maha  - added
datawindowchild dwchild

tab_facilty.tabpage_verif.dw_verif_rules.getchild( "priority_user", dwchild)
dwchild.insertrow(1)

tab_facilty.tabpage_verif.dw_verif_rules.getchild( "priority_user_exp", dwchild)
dwchild.insertrow(1)

return 1
end function

public function integer of_set_screen_color ();//====================================================================
//$<Function>: of_set_screen_color
//$<Arguments>:
//$<Return>:  integer
//$<Description>: for setting screen names green, code in the dw_verif_rules pfc_postupdate event
//	called from retrieveend of dw_select_section  the select section dw object has a modification field (selected) that changes the color
//	For Bug id 4519 Missing green check marks in Facility Setup verifications screen
//$<Author>: (Appeon) long.zhang 05.08.2015
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer li_screen_id
string ls_verify_data
integer li_find
String ls_sql
datawindow ldw_select_section

ldw_select_section = tab_facilty.tabpage_verif.dw_select_section
If ldw_select_section.rowcount() < 1 Then return 1

ls_sql = 'select screen_id, verify_data from facility_ver_rules WHERE facility_id = '+ string(il_facility_id)

DECLARE rec_cursor DYNAMIC CURSOR FOR SQLSA ;

PREPARE SQLSA FROM :ls_sql ;

OPEN DYNAMIC rec_cursor;

FETCH rec_cursor INTO :li_screen_id, :ls_verify_data ;

DO WHILE sqlca.sqlcode = 0
	li_find = ldw_select_section.find('screen_id = '+ string(li_screen_id), 1, ldw_select_section.rowcount())
	If li_find > 0 Then
		If ls_verify_data = 'N' Then
			ldw_select_section.setitem(li_find, "selected", 0)
		Else
			ldw_select_section.setitem(li_find, "selected", 1)
		end if
	End If
	
	FETCH rec_cursor INTO :li_screen_id, :ls_verify_data ;
LOOP

CLOSE rec_cursor ;


return 1
end function

on pfc_cst_u_facility_setup.create
this.cb_links=create cb_links
this.cb_notes=create cb_notes
this.st_step=create st_step
this.cb_next_tab=create cb_next_tab
this.cb_user=create cb_user
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_print=create cb_print
this.cb_save=create cb_save
this.cb_close=create cb_close
this.tab_facilty=create tab_facilty
this.dw_detail=create dw_detail
this.Control[]={this.cb_links,&
this.cb_notes,&
this.st_step,&
this.cb_next_tab,&
this.cb_user,&
this.cb_add,&
this.cb_delete,&
this.cb_print,&
this.cb_save,&
this.cb_close,&
this.tab_facilty,&
this.dw_detail}
end on

on pfc_cst_u_facility_setup.destroy
destroy(this.cb_links)
destroy(this.cb_notes)
destroy(this.st_step)
destroy(this.cb_next_tab)
destroy(this.cb_user)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_print)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.tab_facilty)
destroy(this.dw_detail)
end on

event constructor;Integer li_cnt
integer li_val


//Start Code Change ----11.10.2009 #V10 maha
li_val = w_mdi.of_security_access( 470 ) //main access - if readonly add and delete are disabled even if specific rights are given
IF li_val  = 1 THEN
	dw_detail.enabled = false
	cb_save.enabled = false
	cb_add.Enabled = False
	cb_delete.Enabled = False	
END IF
 
//Facility address
li_val = w_mdi.of_security_access( 480 )
IF li_val  = 0 THEN
	tab_facilty.tabpage_address.Visible = False	
	//tab_facilty.tabpage_address.dw
END IF

//Facility return address
IF w_mdi.of_security_access( 500 ) = 0 THEN
	tab_facilty.tabpage_return.Visible = False	
	li_cnt++	
END IF

//global variables
IF w_mdi.of_security_access( 510 ) = 0 THEN
	tab_facilty.tabpage_settings.Visible = False	
	tab_facilty.tabpage_webview.visible = false //Start Code Change ----02.16.2011 #V11 maha 
	li_cnt++	
END IF

//verif rules
IF w_mdi.of_security_access( 520 ) = 0 THEN
	tab_facilty.tabpage_verif.Visible = False	
	li_cnt++	
END IF

//credentialing committee
IF w_mdi.of_security_access( 530 ) = 0 THEN
	tab_facilty.tabpage_committee.Visible = False	
	li_cnt++
END IF

//add facility
IF w_mdi.of_security_access( 533 ) = 0 THEN
	cb_add.Enabled = False	
END IF


//delete facility
IF w_mdi.of_security_access( 534 ) = 0 THEN
	cb_delete.Enabled = False	
END IF

//user painter
IF w_mdi.of_security_access( 900 ) = 0 THEN
	cb_user.Enabled = False
END IF												

IF gs_cust_type = "I" THEN
	tab_facilty.tabpage_dept_chair.Visible = False		
END IF

IF li_cnt = 5 THEN
	tab_facilty.tabpage_browse.dw_browse.Enabled = False
END IF

//Start Code Change ----02.16.2011 #V11 maha - hide tab if module off
if of_get_app_setting("set_47","I") = 0 then
	tab_facilty.tabpage_workflow.visible = false
end if

if of_get_app_setting("set_web","I") = 0 then
	tab_facilty.tabpage_webview.visible = false
end if
//End Code Change ----02.16.2011


//IF THIS IS INTELLICRED SE TURN SOME TABS OFF

IF gb_se_version THEN
	of_se( )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.07.2006 By: LeiWei
//$<reason> To implement the functionality of storing Word templates to both HDD and db.
//$<modification> Two dataobjects are used: 1) d_verification_setup (store templates to local HDD);
//$<modification> 2) d_verification_setup_database (store templates to db).

Integer li_word_storage_type
li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	dw_detail.Dataobject = "d_facility_setup"
	tab_facilty.tabpage_verif.dw_verif_rules.Dataobject = "d_verification_setup"
	dw_detail.of_SetTransObject( SQLCA )
	tab_facilty.tabpage_verif.dw_verif_rules.of_SetTransObject( SQLCA )
ELSE	
	dw_detail.Dataobject = "d_facility_setup_database"
	tab_facilty.tabpage_verif.dw_verif_rules.Dataobject = "d_verification_setup_database"
	dw_detail.of_SetTransObject( SQLCA )
	tab_facilty.tabpage_verif.dw_verif_rules.of_SetTransObject( SQLCA )
END IF	
//---------------------------- APPEON END ----------------------------

//------------ APPEON BEGIN ------------
//$<Add> 12.26.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if of_get_app_setting("set_8","I") = 1 then
	dw_detail.Modify("npdb_cc_exp_t.text = 'Credit Card Exp. (mmyyyy)'")
else
	dw_detail.Modify("npdb_cc_exp_t.text = 'Credit Card Exp. (yyyy-mm-dd)'")
end if
//------------ APPEON END --------------



end event

type cb_links from commandbutton within pfc_cst_u_facility_setup
integer x = 2519
integer y = 20
integer width = 503
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Group Links"
end type

event clicked;gs_pass_ids lst_ids

lst_ids.ls_from_window = "F"
lst_ids.facility_id = il_facility_id
openwithparm(w_group_facility_links, lst_ids)
end event

type cb_notes from u_cb within pfc_cst_u_facility_setup
integer x = 1271
integer y = 20
integer width = 407
integer height = 84
integer taborder = 21
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Notes"
end type

event clicked;call super::clicked; //Start Code Change ----05.15.2015 #V15 maha - copied from v14.1
	openwithparm(w_entity_note, string( il_facility_id ) + "*FAC")

end event

type st_step from statictext within pfc_cst_u_facility_setup
boolean visible = false
integer x = 3918
integer y = 128
integer width = 357
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Step 1 of 6"
boolean focusrectangle = false
end type

type cb_next_tab from u_cb within pfc_cst_u_facility_setup
boolean visible = false
integer x = 3451
integer y = 116
integer width = 347
integer height = 88
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = " Next-->   "
end type

event clicked;
IF il_last_tab = 7 THEN
	IF tab_facilty.tabpage_committee.dw_committee.RowCount() = 0 THEN
		MessageBox("Committee", "Please enter at least one committee and save." )
		Return -1
	END IF		
	IF cb_save.Event Clicked() = -1 THEN
		Return
	END IF
	ib_adding_new = False
	ib_rules_added = True
	This.Visible = False
	st_step.Visible = False
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<modify> 03.09.2006 By: LiuHongXin
	//$<reason> SelectTab() is unsupported if a tab page is invisible.
	//$<modification> Add script to set the tab page visible.
	/*
	tab_facilty.selectTab( 2 )
	cb_add.Enabled = True
	cb_delete.Enabled = True
	cb_save.Enabled = True
	cb_print.Enabled = True
	cb_user.Enabled = True
	tab_facilty.tabpage_browse.Visible = True
	tab_facilty.tabpage_address.Visible = True
	*/	
	tab_facilty.tabpage_address.Visible = True
	tab_facilty.selectTab( 2 )
	
	cb_add.Enabled = True
	cb_delete.Enabled = True
	cb_save.Enabled = True
	cb_print.Enabled = True
	cb_user.Enabled = True
	tab_facilty.tabpage_browse.Visible = True
	//---------------------------- APPEON END ----------------------------
	tab_facilty.tabpage_return.Visible = True
	tab_facilty.tabpage_settings.Visible = True
	tab_facilty.tabpage_npdb.Visible = True
	tab_facilty.tabpage_verif.Visible = True
	tab_facilty.tabpage_committee.Visible = True
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03.18.2006 By: Cao YongWang
	//$<reason> Fix a defect.
	//$<reason> Make Dept. Chair tab visible after add new facility. 
	tab_facilty.tabpage_dept_chair.Visible = True
	tab_facilty.tabpage_workflow.Visible = True //Added for Work Flow. 3/11/2006 Henry
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.26.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	gnv_data.ids_facility.retrieve()
	//---------------------------- APPEON END ----------------------------

//	MessageBox("User Painter", "To assign this facility to a user you need to update the User Painter.")	//Start Code Change ----03.29.2011 #V11 maha - removed message
	dw_detail.BringToTop = True
	Return
END IF

tab_facilty.SelectTab( il_last_tab )

IF ib_fld_error = True THEN
	This.BringToTop = True
	Return
ELSE
	tab_facilty.tabpage_browse.Visible = False
	tab_facilty.tabpage_address.Visible = False	
	tab_facilty.tabpage_return.Visible = False
	tab_facilty.tabpage_settings.Visible = False
	tab_facilty.tabpage_npdb.Visible = False
	tab_facilty.tabpage_verif.Visible = False
	tab_facilty.tabpage_committee.Visible = False
	il_last_tab ++
	CHOOSE CASE il_last_tab 
		CASE 3
			tab_facilty.tabpage_return.Visible = True
			st_step.Text = "Step 2 of 6"
		CASE 4
			tab_facilty.tabpage_settings.Visible = True
			st_step.Text = "Step 3 of 6"			
		CASE 5
			tab_facilty.tabpage_npdb.Visible = True
			st_step.Text = "Step 4 of 6"			
		CASE 6
			tab_facilty.tabpage_verif.Visible = True	
			st_step.Text = "Step 5 of 6"			
		CASE 7		
			tab_facilty.tabpage_committee.Visible = True
			st_step.Text = "Step 6 of 6"			
			This.Text = "Save"
	END CHOOSE
	tab_facilty.SelectTab( il_last_tab )				
END IF


This.BringToTop = True
st_step.Visible = True
st_step.BringToTop = True







end event

type cb_user from u_cb within pfc_cst_u_facility_setup
integer x = 2103
integer y = 20
integer width = 407
integer height = 84
integer taborder = 80
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&User Access"
end type

event clicked;//Start Code Change ----05.25.2011 #V11 maha - changed from user painter
//Open( w_security_user_painter )
gs_pass_ids lst_ids

lst_ids.l_app_id = dw_detail.getitemnumber(dw_detail.getrow(),"facility_id")
lst_ids.ls_ref_value = dw_detail.getitemstring(dw_detail.getrow(),"facility_name")
lst_ids.ls_from_window = "Facility"

openwithparm(w_facility_user_security,lst_ids)

end event

type cb_add from u_cb within pfc_cst_u_facility_setup
integer x = 439
integer y = 20
integer width = 407
integer height = 84
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr
Integer i
Integer li_rc
Integer li_facility_id
//messagebox("", dw_detail.dataobject)
IF iw_parent_window.Event pfc_save() < 0 THEN
	Return -1
END IF

//Start Code Change ----05.28.2014 #V14.2 maha
i = of_check_prac_facility_max("F") 
if i > 0 then
	MessageBox("Facility/Group Limit", "You have reached the limit of Facilities ( "  + string(i) + " ) as defined by the system setup, and cannot add any additional Facilities.  Contact IntelliSoft Group for Options.")
	this.enabled = false
	Return -1
END IF
//End Code Change ----05.28.2014

tab_facilty.SelectTab( 2 )

ib_adding_new = True
ib_rules_added = False

cb_next_tab.Visible = True
cb_next_tab.BringToTop = True
st_step.Visible = True
st_step.BringToTop = True

il_last_tab = 2
tab_facilty.tabpage_browse.Visible = False
tab_facilty.tabpage_return.Visible = False
tab_facilty.tabpage_settings.Visible = False
tab_facilty.tabpage_npdb.Visible = False
tab_facilty.tabpage_verif.Visible = False
tab_facilty.tabpage_committee.Visible = False
tab_facilty.tabpage_dept_chair.Visible = False
tab_facilty.tabpage_workflow.Visible = False //Added for Work Flow. 3/11/2006 Henry
tab_facilty.tabpage_webview.Visible = False //Start Code Change ----.2012 #V12 maha

cb_add.Enabled = False
cb_delete.Enabled = False
cb_save.Enabled = False
cb_print.Enabled = False
cb_user.Enabled = False

SELECT Max( facility.facility_id )  
INTO :li_facility_id  
FROM facility ;

li_facility_id ++

il_facility_id = li_facility_id

dw_detail.Reset()
dw_detail.visible = true  // Add by stephen 04.01.2011 --- Fixed a bug for web. 
dw_detail.bringtotop = true  // Add by stephen 04.01.2011 --- Fixed a bug for web. 
cb_next_tab.bringtotop = true   // Add by stephen 04.01.2011 --- Fixed a bug  for web. 

li_nr = dw_detail.InsertRow( 0 )
dw_detail.SetItem( li_nr, "facility_id", li_facility_id)
dw_detail.SetItem( li_nr, "appointment_years", 2)// maha 020801
dw_detail.SetItem( li_nr, "prov_export", 0)// maha 102303
dw_detail.SetItem( li_nr, "reapp_export", 0)// maha 102303
dw_detail.SetItem( li_nr, "reappah_export", 0)// maha 102303
//Start Code Change ----04.16.2012 #V12 maha
dw_detail.SetItem( li_nr, "reap_use_letter", 0)
dw_detail.SetItem( li_nr, "reap_use_app", 0)
dw_detail.SetItem( li_nr, "reap_use_privform", 0)
//End Code Change ----04.16.2012

dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )
dw_detail.SetFocus( )

tab_facilty.tabpage_verif.dw_verif_rules.Reset()
tab_facilty.tabpage_committee.dw_committee.Reset()
tab_facilty.tabpage_dept_chair.dw_dc_browse.Reset()
tab_facilty.tabpage_dept_chair.dw_dc_detail.Reset()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.28.2006 By: LiuHongXin
//$<reason> Fix a defect.
if cb_next_tab.Text = "Save" then
	cb_next_tab.Text = ' Next-->'
	st_step.Text = "Step 1 of 6"
end if
//---------------------------- APPEON END ----------------------------

//tab_facilty.tabpage_committee.Enabled = False
//ib_adding_new = False
end event

type cb_delete from u_cb within pfc_cst_u_facility_setup
integer x = 855
integer y = 20
integer width = 407
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Integer li_ans
long cnt
integer li_fac
long ll_ver_cnt //maha 

if dw_detail.rowcount( )=0 then return //Added by  Nova 10.10.2009
li_fac = dw_detail.GetItemNumber( 1, "facility_id" )
IF li_fac = 1 THEN
	MessageBox("Delete Error", "You can't delete the facility with the facility_id of 1!")
	RETURN -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.26.2007 By: Evan
//$<reason> New feature of import module.
//select count(rec_id) into :cnt from pd_affil_stat where parent_facility_id = :li_fac;
long ll_Count
gnv_appeondb.of_StartQueue()
select count(rec_id) into :cnt from pd_affil_stat where parent_facility_id = :li_fac;
select count(rec_id) into :ll_ver_cnt from pd_affil_stat where verifying_facility = :li_fac; //Start Code Change ----05.02.2011 #V11 maha  - added for untrapped user error
SELECT count(*) INTO :ll_Count FROM import_lookup_mapping A, import_lu_map_fields B
WHERE (A.ilm_id = B.ilm_id) AND
		(A.map_type = 'F') AND
		(is_lu_code = :li_fac);
gnv_appeondb.of_CommitQueue()

if ll_Count > 0 then
	MessageBox("Delete Error", "This facility has " + string(ll_Count) + " Import lookup mapping records connected to it.  You can't delete the facility unless those records are deleted first.")
	Return -1
end if
//---------------------------- APPEON END ----------------------------

IF cnt > 0 THEN //maha 101204
	MessageBox("Delete Error", "This facility has " + string(cnt) + " Appointment records connected to it (Parent Facility).  You can't delete the facility unless those records are deleted first.")
	RETURN -1
END IF

IF ll_ver_cnt > 0 THEN //Start Code Change ----05.02.2011 #V11 maha   //Start Code Change ----09.15.2013 #V14 maha - corrected variable in message from cnt
	MessageBox("Delete Error", "This facility has " + string(ll_ver_cnt) + " Appointment records connected to it (Verifying Facility).  You can't delete the facility unless those records are deleted first.")
	RETURN -1
END IF

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected Facility?", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return
END IF

iw_parent_window.SetRedraw( False )
//maha 101204 moved to above deleterow

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 02.10.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
DELETE 
FROM facility_ver_rules
WHERE facility_id = :il_facility_id;

DELETE 		//maha 102300
FROM committee_lookup
WHERE facility_id = :il_facility_id;

DELETE 		//maha 110600
FROM security_user_facilities
WHERE facility_id = :il_facility_id;
*/

gnv_appeondb.of_startqueue( )

DELETE 
FROM facility_ver_rules
WHERE facility_id = :il_facility_id;

DELETE   committee_members  //add by Stephen 06.22.2011 (V11.3 Committee Proc Upd)
FROM committee_members a, committee_lookup b
WHERE a.Committee_id = b.Committee_id
     AND b.facility_id = :il_facility_id;

DELETE 		//maha 102300
FROM committee_lookup
WHERE facility_id = :il_facility_id;

DELETE 		//maha 110600
FROM security_user_facilities
WHERE facility_id = :il_facility_id;

update facility set parent_id = null where parent_id = :il_facility_id; //Start Code Change ----10.01.2014 #V14.2 maha - clear any parents //maha 10.23.2014 -corrected statement

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dw_detail.DeleteRow( 0 )//maha 110600 this line moved to here from line 15 

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	Return -1
END IF


IF iw_parent_window.Event pfc_save( ) < 0 THEN
	Return -1
END IF

tab_facilty.tabpage_browse.dw_browse.Retrieve()

tab_facilty.SelectTab( 1 )

tab_facilty.tabpage_browse.dw_browse.ScrollToRow( 1 )
tab_facilty.tabpage_browse.dw_browse.SetRow( 1 )
tab_facilty.tabpage_browse.dw_browse.SelectRow( 0, False )
tab_facilty.tabpage_browse.dw_browse.SelectRow( 1, True )

tab_facilty.tabpage_browse.dw_browse.SetFocus( )

COMMIT USING SQLCA;

iw_parent_window.SetRedraw( True )

tab_facilty.tabpage_verif.Enabled = True
end event

type cb_print from u_cb within pfc_cst_u_facility_setup
integer x = 1687
integer y = 20
integer width = 407
integer height = 84
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;dw_detail.Print()
dw_detail.SetFocus( )

//------------------- APPEON BEGIN -------------------
//$<add> Evan 07.08.2009
//$<reason> Needs to reset position after printed on web (Corrected BugE060401)
choose case tab_facilty.SelectedTab
	case 2
		dw_detail.Object.DataWindow.VerticalScrollPosition = 0
	case 3
		dw_detail.Object.DataWindow.VerticalScrollPosition = 1888
	case 4
		dw_detail.Object.DataWindow.VerticalScrollPosition = 4190
	case 5
		dw_detail.Object.DataWindow.VerticalScrollPosition = 5800
	case 9
		dw_detail.Object.DataWindow.VerticalScrollPosition = 7680
end choose
//------------------- APPEON END ---------------------
end event

type cb_save from u_cb within pfc_cst_u_facility_setup
integer x = 23
integer y = 20
integer width = 407
integer height = 84
integer taborder = 70
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Integer li_find
Integer li_row, li_comm_row
Integer li_last_tab
Integer li_last_facility_id
Integer li_retval
Integer li_cr
long     ll_member_id
long     ll_commid
dwitemstatus ldws_new

dw_detail.AcceptText()

li_cr = dw_detail.GetRow()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.07.2006 By: Rodger Wu
//$<reason> fix a defect.
if li_cr < 1 then return;
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.11.2008 By: Evan
//$<reason> Fix BugS122705	about when clicking Add Committee twice, the following error occurs.
long ll_Row
tab_facilty.tabpage_committee.dw_committee_d.AcceptText()
tab_facilty.tabpage_committee.dw_committee.AcceptText()
for ll_Row = 1 to tab_facilty.tabpage_committee.dw_committee.RowCount()
	if IsNull(tab_facilty.tabpage_committee.dw_committee.GetItemString(ll_Row, "committee_name")) then
		MessageBox("Required Field", "Please enter the committee name.")
		tab_facilty.SelectTab( 7 )
		tab_facilty.tabpage_committee.dw_committee.ScrollToRow(ll_Row)
		tab_facilty.tabpage_committee.dw_committee.SetFocus()
		Return -1
	end if
next
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> Stephen 22.06.2011 
//$<reason> write member_id (V11.3 Committee Proc Upd)
select max(Member_id)
   into :ll_member_id
 from committee_members using sqlca ;
 
if isnull(ll_member_id) then ll_member_id = 0
ll_member_id = ll_member_id +1
for ll_row = 1 to tab_facilty.tabpage_committee.dw_committee_mem.RowCount()
	ldws_new = tab_facilty.tabpage_committee.dw_committee_mem.getitemstatus(ll_row, 0, primary!)
	if ldws_new = new! or ldws_new = newmodified! then
		tab_facilty.tabpage_committee.dw_committee_mem.setitem(ll_row, "Member_id", ll_member_id)
		ll_member_id = ll_member_id +1
	end if
next

li_comm_row = tab_facilty.tabpage_committee.dw_committee.getrow()
if li_comm_row > 0 then
	ll_commid = tab_facilty.tabpage_committee.dw_committee.getitemnumber(li_comm_row, 'committee_id')
end if
//---------------------------- APPEON END ----------------------------

IF IsNull( dw_detail.GetItemString( li_cr, "facility_name" ) ) THEN
	MessageBox("Required Field", "Please enter the facility name." )
	tab_facilty.SelectTab( 2 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "facility_name" )		
	Return -1
END IF

IF IsNull( dw_detail.GetItemString( li_cr, "street" ) )  THEN
	MessageBox("Required Field", "Please enter the street." )
	tab_facilty.SelectTab( 2 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "street" )	
	Return -1	
END IF


IF IsNull( dw_detail.GetItemString( li_cr, "return_facility_name" ) ) THEN
	MessageBox("Required Field", "Please enter the return facility name." )
	tab_facilty.SelectTab( 3 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "return_facility_name" )	
	Return -1	
END IF

IF IsNull( dw_detail.GetItemString( li_cr, "return_street" ) ) THEN
	MessageBox("Required Field", "Please enter the return street." )
	tab_facilty.SelectTab( 3 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "return_street" )	
	Return -1	
END IF

IF IsNull( dw_detail.GetItemNumber( li_cr, "default_data_view_id" ) ) THEN
	MessageBox("Required Field", "Please enter the default data view for this facility." )
	tab_facilty.SelectTab( 4 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "default_data_view_id" )	
	Return -1	
END IF

IF IsNull( dw_detail.GetItemString( li_cr, "letter_path" ) )THEN
	MessageBox("Required Field", "Please enter the default letter path for this facility." )
	tab_facilty.SelectTab( 4 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "letter_path" )	
	Return -1	
END IF

 //maha 071403 to set null check boxe
//if isnull("reapp_export") then dw_detail.setitem(1,"reapp_export",0)
//if isnull("prov_export") then dw_detail.setitem(1,"prov_export",0)
//if isnull("reappah_export") then dw_detail.setitem(1,"reappah_export",0)
//if isnull("oig_auto_lname") then dw_detail.setitem(1,"oig_auto_lname",0)
//if isnull("oig_auto_fname") then dw_detail.setitem(1,"oig_auto_fname",0)
//if isnull("oig_auto_dob") then dw_detail.setitem(1,"oig_auto_dob",0)
//if isnull("dupeset") then dw_detail.setitem(1,"dupeset",0)

 //Start Code Change ----04.17.2014 #V14.2 maha - moved from preupdate
if isnull(dw_detail.getitemnumber(1,"dupeset")) then dw_detail.SetItem( 1, "dupeset", 0)
if isnull(dw_detail.getitemnumber( 1,"oig_auto_lname")) then dw_detail.SetItem(  1, "oig_auto_lname", 0)
if isnull(dw_detail.getitemnumber(1,"oig_auto_fname")) then dw_detail.SetItem(  1, "oig_auto_fname", 0)
if isnull(dw_detail.getitemnumber(1,"oig_auto_dob")) then dw_detail.SetItem(  1, "oig_auto_dob", 0)
if isnull(dw_detail.getitemstring(1,"wf_exp_appt")) then dw_detail.SetItem(  1, "wf_exp_appt", 'N')
if isnull(dw_detail.getitemnumber(1,"prov_export")) then dw_detail.SetItem( 1, "prov_export", 0) 
if isnull(dw_detail.getitemnumber(1,"reapp_export")) then dw_detail.SetItem( 1, "reapp_export", 0) 
if isnull(dw_detail.getitemnumber(1,"reappah_export")) then dw_detail.SetItem( 1, "reappah_export", 0)
if isnull(dw_detail.getitemnumber(1,"is_parent")) then dw_detail.SetItem( 1, "is_parent", 0)  //Start Code Change ----04.17.2014 #V14.2 maha
 //End Code Change ----04.17.2014 


li_last_tab = tab_facilty.SelectedTab

li_retval = iw_parent_window.Event pfc_save( )
IF li_retval < 0 THEN
	Return -1
ELSEIF li_retval = 0 THEN
	Return 0
END IF

li_last_facility_id = dw_detail.GetItemNumber( 1, "facility_id" )

iw_parent_window.SetRedraw( False )

tab_facilty.tabpage_browse.dw_browse.Retrieve()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.15.2006 By: LeiWei
//$<reason> Fix a defect.
//li_row = tab_facilty.tabpage_browse.dw_browse.Find( "facility_id = " + String( li_last_facility_id ), 1, 10000 )
If Isnull(li_last_facility_id) Then
	li_row = 0
Else
	li_row = tab_facilty.tabpage_browse.dw_browse.Find( "facility_id = " + String( li_last_facility_id ), 1, 10000 )
End If
//---------------------------- APPEON END ----------------------------
IF li_row < 1 THEN
	Return -1
END IF
tab_facilty.tabpage_browse.dw_browse.SetRow( li_row )
tab_facilty.tabpage_browse.dw_browse.ScrollToRow( li_row )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> Stephen 22.06.2011 
//$<reason> (V11.3 Committee Proc Upd)
if li_comm_row > 0 then
	li_comm_row = tab_facilty.tabpage_committee.dw_committee.find("committee_id="+string(ll_commid)+"", 1, tab_facilty.tabpage_committee.dw_committee.rowcount())
	if li_comm_row > 0 then
		tab_facilty.tabpage_committee.dw_committee.selectrow(0, false)
		tab_facilty.tabpage_committee.dw_committee.selectrow(li_comm_row, true)
		tab_facilty.tabpage_committee.dw_committee.setrow(li_comm_row)
		tab_facilty.tabpage_committee.dw_committee.ScrollToRow(li_comm_row)
	end if
end if
//--------------------------- APPEON END ---------------------------

IF li_last_tab = 1 OR li_last_tab = 5 THEN
	tab_facilty.tabpage_browse.dw_browse.SetFocus( )
	dw_detail.Visible = False
ELSEIF li_last_tab = 6 THEN
	tab_facilty.tabpage_committee.dw_committee.SetFocus()
	dw_detail.Visible = False
ELSEIF li_last_tab = 8 THEN
	tab_facilty.tabpage_dept_chair.dw_dc_browse.Retrieve( il_facility_id )
	dw_detail.Visible = False
	tab_facilty.tabpage_dept_chair.dw_dc_browse.SelectRow( 0, False )			
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.15.2006 By: LeiWei
	//$<reason> Fix a defect.
	/*
	li_find = tab_facilty.tabpage_dept_chair.dw_dc_browse.Find( "dept_chair_id = " + String( il_last_dept_chair ), 1, 1000 )
	tab_facilty.tabpage_dept_chair.dw_dc_browse.SelectRow( li_find, True )
	*/
	If Isnull(il_last_dept_chair) Then
		li_find = 0
	Else
		li_find = tab_facilty.tabpage_dept_chair.dw_dc_browse.Find( "dept_chair_id = " + String( il_last_dept_chair ), 1, 1000 )
		tab_facilty.tabpage_dept_chair.dw_dc_browse.SelectRow( li_find, True )
	End If
	//---------------------------- APPEON END ----------------------------
	tab_facilty.tabpage_dept_chair.dw_dc_detail.SetFocus( )	
	tab_facilty.tabpage_dept_chair.dw_dc_detail.Retrieve( il_last_dept_chair )
ELSE
	dw_detail.Visible = True
	dw_detail.SetFocus( )

		IF li_last_tab = 2 THEN
			dw_detail.Object.DataWindow.VerticalScrollPosition='0'
		ELSEIF li_last_tab = 3 THEN
			dw_detail.Object.DataWindow.VerticalScrollPosition='1888'
		ELSEIF li_last_tab = 4 THEN
			dw_detail.Object.DataWindow.VerticalScrollPosition='4190'		
		END IF

END IF

COMMIT USING SQLCA;

IF tab_facilty.tabpage_committee.dw_committee.RowCount() = 0 THEN
	MessageBox("Committee", "Please enter at least one committee and save." )
	tab_facilty.SelectTab( 7 )  //Ken.Guo 2008-03-18  '6' changed to '7'
	tab_facilty.tabpage_committee.Enabled = true //maha 061301
	iw_parent_window.SetRedraw( True )
	Return -1
END IF	

tab_facilty.tabpage_verif.Enabled = True
//Added for Work Flow to refersh the cache data. 1/11/2006 Henry
gnv_data.of_retrieve('facility')
tab_facilty.SelectTab( li_last_tab )

iw_parent_window.SetRedraw( True )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/29/2008 By: Ken.Guo
//$<reason> Added it to workaround Web's bug.
//This bug exist in APB 5.1.0306. Later APB version have fixed it.
tab_facilty.Post SelectTab( li_last_tab )
//---------------------------- APPEON END ----------------------------

end event

type cb_close from u_cb within pfc_cst_u_facility_setup
integer x = 3995
integer y = 16
integer width = 407
integer height = 84
integer taborder = 90
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;
Close( iw_parent_window )
end event

type tab_facilty from tab within pfc_cst_u_facility_setup
integer x = 23
integer y = 116
integer width = 4384
integer height = 1964
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_address tabpage_address
tabpage_return tabpage_return
tabpage_settings tabpage_settings
tabpage_npdb tabpage_npdb
tabpage_verif tabpage_verif
tabpage_committee tabpage_committee
tabpage_dept_chair tabpage_dept_chair
tabpage_workflow tabpage_workflow
tabpage_webview tabpage_webview
end type

event selectionchanging;//IF ib_adding_new = False THEN
//	IF cb_save.Event Clicked() = -1 THEN
//		Return 1
//	END IF
//END IF

//IF newindex = 2 OR newindex = 3 OR newindex = 4 THEN
//	of_tab_order_off()
//END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/29/2008 By: Ken.Guo
//$<reason> Added it to workaround Web's bug.
//This bug exist in APB 5.1.0306. Later APB version have fixed it.
If NewIndex > 10 Then Return 0 
//---------------------------- APPEON END ----------------------------


//Start Code Change ----11.10.2009 #V10 maha - added readonly security to tabs
ib_tab_change = True

dw_detail.AcceptText()

Integer li_cr
integer ck
integer li_val

ib_fld_error = False

li_cr = dw_detail.GetRow()

IF oldindex = 2 THEN
	IF IsNull( dw_detail.GetItemString( li_cr, "facility_name" ) ) OR +&
		dw_detail.GetItemString( li_cr, "facility_name" ) = ""	THEN
		MessageBox("Required Field", "Please enter the facility name." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "facility_name" )		
		ib_fld_error = True
		Return 1
	END IF

	IF IsNull( dw_detail.GetItemString( li_cr, "street" ) ) OR +& 
		dw_detail.GetItemString( li_cr, "street" ) = "" THEN
		MessageBox("Required Field", "Please enter the street." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "street" )	
		ib_fld_error = True
		Return 1	
	END IF
ELSEIF oldindex = 3 THEN
	IF IsNull( dw_detail.GetItemString( li_cr, "return_facility_name" ) ) OR +&
		dw_detail.GetItemString( li_cr, "return_facility_name" ) = "" THEN
		MessageBox("Required Field", "Please enter the return facility name." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "return_facility_name" )	
		ib_fld_error = True
		Return 1	
	END IF

	IF IsNull( dw_detail.GetItemString( li_cr, "return_street" ) ) OR + & 
		dw_detail.GetItemString( li_cr, "return_street" ) = "" THEN
		MessageBox("Required Field", "Please enter the return street." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "return_street" )	
		ib_fld_error = True
		Return 1	
	END IF
ELSEIF oldindex = 4 THEN
	IF IsNull( dw_detail.GetItemNumber( li_cr, "default_data_view_id" )) OR +& 
		dw_detail.GetItemNumber( li_cr, "default_data_view_id" ) = 0  THEN
		MessageBox("Required Field", "Please enter the default data view for this facility." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "default_data_view_id" )	
		ib_fld_error = True
		Return 1	
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 07.05.2006 By: LeiWei
	//$<reason> Check word templete storage type
	
	/*
	IF IsNull( dw_detail.GetItemString( li_cr, "letter_path" ) ) OR +& 
		dw_detail.GetItemString( li_cr, "letter_path" ) = "" THEN
		MessageBox("Required Field", "Please enter the default letter path for this facility." )
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "letter_path" )	
		ib_fld_error = True
		Return 1	
	END IF

	IF Right(dw_detail.GetItemString( li_cr, "letter_path" ), 1 ) <> "\" THEN
		MessageBox("Validation Error", "The letter path field must end with the charactor \")
		dw_detail.SetFocus()
		dw_detail.SetColumn( "letter_path" )
		ib_fld_error = True
		Return 1
	END IF
	*/
	
	Integer li_word_storage_type
	
	li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
	IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0

	IF IsNull( dw_detail.GetItemString( li_cr, "letter_path" ) ) OR +& 
		dw_detail.GetItemString( li_cr, "letter_path" ) = "" THEN
		if Upper( AppeonGetClientType() ) = "WEB" OR li_word_storage_type = 1 then
			MessageBox("Required Field", "Please enter Letter Storage Area for this facility." )
		else
			MessageBox("Required Field", "Please enter the default letter path for this facility." )
		end if
		dw_detail.SetFocus( )	
		dw_detail.SetColumn( "letter_path" )	
		ib_fld_error = True
		Return 1	
	END IF

	IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
		IF RightA(dw_detail.GetItemString( li_cr, "letter_path" ), 1 ) <> "\" THEN
			MessageBox("Validation Error", "The letter path field must end with the charactor \")
			dw_detail.SetFocus()
			dw_detail.SetColumn( "letter_path" )
			ib_fld_error = True
			Return 1
		END IF
	END IF
	
	//---------------------------- APPEON END ----------------------------

END IF

//Start Code Change ----02.16.2011 #V11 maha changed to case statement added tab 9
choose case newindex
	case 1,6,7,8
		dw_detail.Visible = False
	case ELSE
		dw_detail.Visible = True	
END choose

//IF newindex = 1 OR newindex = 6 OR newindex = 7 OR newindex = 8  THEN
//	dw_detail.Visible = False
//ELSE
//	dw_detail.Visible = True	
//END IF

IF newindex = 2 THEN
		Parent.dw_detail.Object.DataWindow.VerticalScrollPosition = 0
		//Facility address
		li_val = w_mdi.of_security_access( 480 )
		IF li_val  = 1 THEN
			dw_detail.enabled = false
		elseif  li_val = 2 then
			dw_detail.enabled = true
		END IF
//		dw_detail.SetTabOrder( "facility_name", 1 )
//		dw_detail.SetTabOrder( "street", 2 )
//		dw_detail.SetTabOrder( "street_2", 3 )
//		dw_detail.SetTabOrder( "city", 4 )
//		dw_detail.SetTabOrder( "state", 5 )
//		dw_detail.SetTabOrder( "zip", 6 )
//		dw_detail.SetTabOrder( "phone", 7 )
//		dw_detail.SetTabOrder( "ext", 8 )
//		dw_detail.SetTabOrder( "fax", 9 )
//		dw_detail.SetTabOrder( "contact", 10 )
//		dw_detail.SetTabOrder( "web_address", 11 )
//		dw_detail.SetTabOrder( "email_address", 12 )		
//		dw_detail.SetColumn( "facility_name" )		
	ELSEIF newindex = 3 THEN
		dw_detail.Object.DataWindow.VerticalScrollPosition='1888'
		
		li_val = w_mdi.of_security_access( 500 )
		IF li_val  = 1 THEN
			dw_detail.enabled = false
		elseif  li_val = 2 then
			dw_detail.enabled = true
		END IF

//		dw_detail.SetTabOrder( "return_facility_name", 1 )
//		dw_detail.SetTabOrder( "return_street", 2 )
//		dw_detail.SetTabOrder( "return_street_2", 3 )
//		dw_detail.SetTabOrder( "return_city", 4 )
//		dw_detail.SetTabOrder( "return_state", 5 )
//		dw_detail.SetTabOrder( "return_zip", 6 )
//		dw_detail.SetTabOrder( "credentialing_contact_name", 7 )
//		dw_detail.SetTabOrder( "credentialing_contact_title", 8 )
//		dw_detail.SetTabOrder( "return_phone", 9 )
//		dw_detail.SetTabOrder( "return_ext", 10 )
//		dw_detail.SetTabOrder( "return_fax", 11 )
		dw_detail.SetColumn( "return_facility_name" )	
		IF dw_detail.GetItemString( li_cr, "return_facility_name" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_facility_name" ) )  THEN
			dw_detail.SetItem( li_cr, "return_facility_name", dw_detail.GetItemString( li_cr, "facility_name" ) )
		END IF
		IF dw_detail.GetItemString( li_cr, "return_street" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_street" ) )  THEN
			dw_detail.SetItem( li_cr, "return_street", dw_detail.GetItemString( li_cr, "street" ) )
		END IF		
		IF dw_detail.GetItemString( li_cr, "return_street_2" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_street_2" ) )  THEN
			dw_detail.SetItem( li_cr, "return_street_2", dw_detail.GetItemString( li_cr, "street_2" ) )
		END IF		
		IF dw_detail.GetItemString( li_cr, "return_city" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_city" ) )  THEN
			dw_detail.SetItem( li_cr, "return_city", dw_detail.GetItemString( li_cr, "city" ) )
		END IF		
		IF dw_detail.GetItemString( li_cr, "return_state" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_state" ) )  THEN
			dw_detail.SetItem( li_cr, "return_state", dw_detail.GetItemString( li_cr, "state" ) )
		END IF		
		IF dw_detail.GetItemString( li_cr, "return_zip" ) = "" OR +&
		   IsNull( dw_detail.GetItemString( li_cr, "return_zip" ) )  THEN
			dw_detail.SetItem( li_cr, "return_zip", dw_detail.GetItemString( li_cr, "zip" ) )
		END IF		
		
		
		
	ELSEIF newindex = 4 THEN		//settings
		dw_detail.Object.DataWindow.VerticalScrollPosition='4190'
		
		li_val = w_mdi.of_security_access( 510 )
		IF li_val  = 1 THEN
			dw_detail.enabled = false
		elseif  li_val = 2 then
			dw_detail.enabled = true
		END IF
//		dw_detail.SetTabOrder( "default_data_view_id", 1 )
//		dw_detail.SetTabOrder( "npdb_facility_ein", 2 )
//		dw_detail.SetTabOrder( "npdb_password", 3 )
//		dw_detail.SetTabOrder( "npdb_agent_ein", 4 )
//		dw_detail.SetTabOrder( "letter_path", 5 )
//		dw_detail.SetTabOrder( "reappointment_query_days", 6 )		
		dw_detail.SetColumn( "default_data_view_id" )
		IF ib_adding_new THEN
			datawindowchild dwchild
			dw_detail.GetChild( "default_verif_facility", dwchild )
			dwchild.InsertRow( 1 )
			dwchild.SetItem( 1, "facility_facility_name", dw_detail.GetItemString( dw_detail.GetRow(), "facility_name" ))
			dwchild.SetItem( 1, "facility_id", il_facility_id)			

			dw_detail.GetChild( "default_audit_temp", dwchild )
			dwchild.InsertRow( 1 )			
			dwchild.SetItem( 1, /*"facility_facility_name"*/"template_name", dw_detail.GetItemString( dw_detail.GetRow(), "facility_name" ))	//modify by stephen 07/26/2011 	Invalid DataWindow row/column 
			dwchild.SetItem( 1 , /*"facility_id"*/ "template_id", il_facility_id ) 	//modify by stephen 07/26/2011 	Invalid DataWindow row/column 	
			
		END IF
		
	ELSEIF newindex = 5 THEN //npdb settings
		dw_detail.Object.DataWindow.VerticalScrollPosition="6024"          //Start Code Change ----03.282017 #V153 maha     '5800'
		
		dw_detail.SetColumn( "npdb_query_type" )	
		
		//Start Code Change ----08.11.2011 #V11 maha - now covered in of_ro_security
//		li_val = w_mdi.of_security_access( 470 )
//		IF li_val  = 1 THEN
//			dw_detail.enabled = false
//		elseif  li_val = 2 then
//			dw_detail.enabled = true
//		END IF
		
		
	ELSEIF newindex = 6 THEN //verif rules

		IF ib_adding_new AND NOT ib_rules_added THEN
			Integer li_rc
			Integer i
			iw_parent_window.Event pfc_save()
			debugbreak()
			IF ib_rules_added = False THEN

				li_rc = tab_facilty.tabpage_verif.dw_copy_rules.RowCount()
				ck = tab_facilty.tabpage_verif.dw_copy_rules.RowsCopy( 1, li_rc, Primary!, tab_facilty.tabpage_verif.dw_verif_rules, 1, Primary! )
				if ck < 1 then
					messagebox("Error creating rules","Unable to create verification rules for this facility.  Contact IntelliSoft Technical Support")
				end if
				li_rc = tab_facilty.tabpage_verif.dw_verif_rules.rowcount()
				FOR i = 1 TO li_rc
					tab_facilty.tabpage_verif.dw_verif_rules.SetItem( i, "facility_id", il_facility_id )
					//----------------------APPEON BEGIN------------------------------
					//<$>added:long.zhang 04.17.2012
					//<$>Reason:Fixed a detect -Bug3019
					if IsNull(tab_facilty.tabpage_verif.dw_verif_rules.getItemnumber(i,'facility_ver_rules_compl_at_create')) then tab_facilty.tabpage_verif.dw_verif_rules.SetItem( i, "facility_ver_rules_compl_at_create", 0 )
					if IsNull(tab_facilty.tabpage_verif.dw_verif_rules.getItemString(i,'exp_reminder_doc')) then tab_facilty.tabpage_verif.dw_verif_rules.SetItem( i, "exp_reminder_doc",'' )
					if IsNull(tab_facilty.tabpage_verif.dw_verif_rules.getItemString(i,'ver_ltr_doc')) then tab_facilty.tabpage_verif.dw_verif_rules.SetItem( i, "ver_ltr_doc",'' )
					//----------------------APPEON END--------------------------------
				END FOR
	
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> PT-03
				//$<comment> 02.13.2006 By: owen chen
				//$<reason> Performance tuning
				//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

				/*
				tab_facilty.tabpage_verif.dw_verif_rules.Update()
				commit using sqlca;
				tab_facilty.tabpage_verif.dw_select_section.Reset()
				tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
				tab_facilty.tabpage_verif.dw_select_section.SelectRow( 1, True )
				*/
				gnv_appeondb.of_startqueue( )
				
				tab_facilty.tabpage_verif.dw_verif_rules.Update()
				commit using sqlca;
				
				gnv_appeondb.of_commitqueue( )
				
				tab_facilty.tabpage_verif.dw_select_section.Reset()
				tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
				tab_facilty.tabpage_verif.dw_select_section.SelectRow( 1, True )
				//---------------------------- APPEON END ----------------------------

				
				IF iw_parent_window.Event pfc_save() < 0 THEN
					Return 1
				END IF		
				ib_rules_added = True
			END IF
			
			ib_rules_added = True			
		END IF
		tab_facilty.tabpage_verif.dw_verif_rules.SetColumn( "required" )
		tab_facilty.tabpage_verif.dw_verif_rules.SetFocus()
		
		li_val = w_mdi.of_security_access( 520 )
		IF li_val  = 1 THEN
			tab_facilty.tabpage_verif.dw_verif_rules.enabled = false
		elseif  li_val = 2 then
			tab_facilty.tabpage_verif.dw_verif_rules.enabled = true
		END IF
		
	ELSEIF newindex = 7 THEN //committees
		tab_facilty.tabpage_committee.dw_committee.SetColumn( "committee_name" )
		tab_facilty.tabpage_committee.dw_committee.SetFocus()	
		
		li_val = w_mdi.of_security_access( 530 )
		IF li_val  = 1 THEN
			//tab_facilty.tabpage_committee.dw_committee.enabled = false //delete by Stephen 08.10.2011
			tab_facilty.tabpage_committee.cb_add_committee.enabled = false
			tab_facilty.tabpage_committee.cb_del_committee.enabled = false
			
			//------------------- APPEON BEGIN -------------------
			//$<add> Stephen 08.10.2011
			//$<reason> N/A  <V11.3 Committee Proc Upd>
			tab_facilty.tabpage_committee.cb_member.enabled = false
			tab_facilty.tabpage_committee.cb_batch.enabled = false
			tab_facilty.tabpage_committee.cb_non_prac.enabled = false
			tab_facilty.tabpage_committee.cb_del_m.enabled = false
			tab_facilty.tabpage_committee.cb_del_all.enabled = false
			tab_facilty.tabpage_committee.dw_committee_d.enabled = false
			tab_facilty.tabpage_committee.dw_committee_mem.modify("committee_chair.tabsequence = '0'")
			tab_facilty.tabpage_committee.dw_committee_mem.modify("email_address.tabsequence = '0'")
		elseif  li_val = 2 then
			tab_facilty.tabpage_committee.dw_committee.enabled = true
			tab_facilty.tabpage_committee.cb_member.enabled = true
			tab_facilty.tabpage_committee.cb_batch.enabled = true
			tab_facilty.tabpage_committee.cb_non_prac.enabled = true
			tab_facilty.tabpage_committee.cb_del_m.enabled = true
			tab_facilty.tabpage_committee.cb_del_all.enabled = true
			tab_facilty.tabpage_committee.dw_committee_d.enabled = true
			tab_facilty.tabpage_committee.dw_committee_mem.modify("committee_chair.tabsequence = '10'")
			tab_facilty.tabpage_committee.dw_committee_mem.modify("email_address.tabsequence = '20'")
			//------------------- APPEON END -------------------
		END IF

		
	ELSEIF newindex = 8 THEN
		//dw_dc_browse.Retrieve( il_facility_id )
		//Start Code Change ----08.11.2011 #V11 maha - now covered in of_ro_security
//		li_val = w_mdi.of_security_access( 470 )
//		IF li_val  = 1 THEN
//			tab_facilty.tabpage_dept_chair.dw_dc_browse.enabled = false
//			tab_facilty.tabpage_dept_chair.cb_add_chair1.visible = false
//			tab_facilty.tabpage_dept_chair.cb_del_chair1.visible = false
//		elseif  li_val = 2 then
//			tab_facilty.tabpage_dept_chair.dw_dc_browse.enabled = true
//		END IF
		
	ELSEIF newindex = 9 THEN //Added for Work Flow tab. 18/10/2006 Henry
		dw_detail.Object.DataWindow.VerticalScrollPosition="7952"                                   //'7680'

		//Retrieve for Work flow DDDW
		If not ib_retrieve_wf Then
			ib_retrieve_wf = true
			of_retrieve_work_flow()
		End If
		
		li_val = w_mdi.of_security_access( 470 )
		IF li_val  = 1 THEN
			dw_detail.enabled = false
		elseif  li_val = 2 then
			dw_detail.enabled = true
		END IF
		
	ELSEIF newindex = 10 THEN //Start Code Change ----02.16.2011 #V11 maha - WebView settings

		dw_detail.Object.DataWindow.VerticalScrollPosition="9860"                                    //'9350'
	END IF
	
	of_ro_security( )
//End Code Change---11.10.2009


dw_detail.SetFocus()		
end event

on tab_facilty.create
this.tabpage_browse=create tabpage_browse
this.tabpage_address=create tabpage_address
this.tabpage_return=create tabpage_return
this.tabpage_settings=create tabpage_settings
this.tabpage_npdb=create tabpage_npdb
this.tabpage_verif=create tabpage_verif
this.tabpage_committee=create tabpage_committee
this.tabpage_dept_chair=create tabpage_dept_chair
this.tabpage_workflow=create tabpage_workflow
this.tabpage_webview=create tabpage_webview
this.Control[]={this.tabpage_browse,&
this.tabpage_address,&
this.tabpage_return,&
this.tabpage_settings,&
this.tabpage_npdb,&
this.tabpage_verif,&
this.tabpage_committee,&
this.tabpage_dept_chair,&
this.tabpage_workflow,&
this.tabpage_webview}
end on

on tab_facilty.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_address)
destroy(this.tabpage_return)
destroy(this.tabpage_settings)
destroy(this.tabpage_npdb)
destroy(this.tabpage_verif)
destroy(this.tabpage_committee)
destroy(this.tabpage_dept_chair)
destroy(this.tabpage_workflow)
destroy(this.tabpage_webview)
end on

event selectionchanged;ib_tab_change = False

end event

type tabpage_browse from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
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
integer y = 4
integer width = 4343
integer height = 1840
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_facility_setup_browse"
boolean hscrollbar = true
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	tab_facilty.tabpage_browse.dw_browse.SetFocus( )
	Return -1
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event doubleclicked;tab_facilty.SelectTab( 2 )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/29/2008 By: Ken.Guo
//$<reason> Added it to workaround Web's bug.
//This bug exist in APB 5.1.0306. Later APB version have fixed it.
tab_facilty.Event SelectionChanging(2,1)
tab_facilty.Event SelectionChanging(1,2)
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 05.05.2011
//$<reason> Fixed a Bug(id 2388):the scroll wheel on mouse. 
ib_tab_change = False
//--------------------APPEON END ---------------------



//tab_facilty.tabpage_dept_chair.dw_dc_browse.Retrieve( This.GetItemNumber( This.GetRow(), "facility_id" ))
//maha moved to rfc event 041404
//IF tab_facilty.tabpage_dept_chair.dw_dc_browse.RowCount( ) = 0 THEN
//	tab_facilty.tabpage_dept_chair.dw_dc_detail.InsertRow( 0 )
//END IF
end event

event retrieveend;call super::retrieveend;Integer li_facility_id

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.20.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Have the application retrieve the database only when
//$<modification> rowcount=1.

/*
IF rowcount > 0 THEN
	li_facility_id = This.GetItemNumber( 1, "facility_id" )	
	dw_detail.Retrieve( li_facility_id )
	il_facility_id = li_facility_id
	IF tab_facilty.tabpage_verif.dw_select_section.RowCount() = 0 THEN
		tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
	END IF
END IF
*/
IF rowcount = 1 THEN
	li_facility_id = This.GetItemNumber( 1, "facility_id" )	
	dw_detail.Retrieve( li_facility_id )
	il_facility_id = li_facility_id
	IF tab_facilty.tabpage_verif.dw_select_section.RowCount() = 0 THEN
		tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
	END IF
END IF
//---------------------------- APPEON END ----------------------------


end event

event rowfocuschanged;call super::rowfocuschanged;IF This.RowCount() > 0 THEN
	il_facility_id = This.GetItemNumber( currentrow, "facility_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 02.10.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	tab_facilty.tabpage_committee.dw_committee.Retrieve( il_facility_id )
	dw_detail.Retrieve( il_facility_id )
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
	dw_detail.SetFocus()
	iw_parent_window.Title = "Facility Painter  ( " + This.GetItemString( currentrow, "facility_name" ) + " )"
	tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
	//maha moved from doubleclicked event 041404
	tab_facilty.tabpage_dept_chair.dw_dc_browse.Retrieve( This.GetItemNumber( This.GetRow(), "facility_id" ))
	*/

	int li_facilityid
	li_facilityid = This.GetItemNumber( This.GetRow(), "facility_id" )

	tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
	gnv_appeondb.of_startqueue( )

	//Start Code Change ----08.09.2011 #V11 maha - change to function call
	//tab_facilty.tabpage_committee.dw_committee.Retrieve( il_facility_id )
	of_retrieve_committees()
	
	dw_detail.Retrieve( il_facility_id )

	//maha moved from doubleclicked event 041404
	tab_facilty.tabpage_dept_chair.dw_dc_browse.Insertrow(0)
	tab_facilty.tabpage_dept_chair.dw_dc_browse.Retrieve( li_facilityid )
	gnv_appeondb.of_commitqueue( )
	
	tab_facilty.tabpage_dept_chair.dw_dc_browse.event rowfocuschanged(tab_facilty.tabpage_dept_chair.dw_dc_browse.getrow())
	
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
	dw_detail.SetFocus()
	
	//$<modify> 07.07.2008 by Andy
	String ls_label
	SELECT TOP 1 app_stat_facility_label INTO :ls_label FROM icred_settings;	
	if isnull(ls_label) or trim(ls_label) = '' then ls_label = 'Facility'
	//iw_parent_window.Title = "Facility Painter  ( " + This.GetItemString( currentrow, "facility_name" ) + " )"
	iw_parent_window.Title = ls_label + " Setup  ( " + This.GetItemString( currentrow, "facility_name" ) + " )"
	//end modify 07.07.2008
	//---------------------------- APPEON END ----------------------------
	
	IF tab_facilty.tabpage_dept_chair.dw_dc_browse.RowCount( ) = 0 THEN
		tab_facilty.tabpage_dept_chair.dw_dc_detail.InsertRow( 0 )
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.07.2006 By: Rodger Wu
	//$<reason> Filter data of the dropdown datawindow for verification 
	//$<reason> documents and expiration docuemnts.
	of_filter_docs( False )
	//---------------------------- APPEON END ----------------------------
END IF
end event

type tabpage_address from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Facility Address"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
end type

type tabpage_return from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Return Address"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
end type

type tabpage_settings from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Settings"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
end type

type tabpage_npdb from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "NPDB/OIG"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
end type

type tabpage_verif from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Verif. Rules"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_copy_rules cb_copy_rules
mle_3 mle_3
mle_2 mle_2
mle_1 mle_1
cb_2 cb_2
dw_verif_rules dw_verif_rules
dw_select_section dw_select_section
dw_copy_rules dw_copy_rules
end type

on tabpage_verif.create
this.cb_copy_rules=create cb_copy_rules
this.mle_3=create mle_3
this.mle_2=create mle_2
this.mle_1=create mle_1
this.cb_2=create cb_2
this.dw_verif_rules=create dw_verif_rules
this.dw_select_section=create dw_select_section
this.dw_copy_rules=create dw_copy_rules
this.Control[]={this.cb_copy_rules,&
this.mle_3,&
this.mle_2,&
this.mle_1,&
this.cb_2,&
this.dw_verif_rules,&
this.dw_select_section,&
this.dw_copy_rules}
end on

on tabpage_verif.destroy
destroy(this.cb_copy_rules)
destroy(this.mle_3)
destroy(this.mle_2)
destroy(this.mle_1)
destroy(this.cb_2)
destroy(this.dw_verif_rules)
destroy(this.dw_select_section)
destroy(this.dw_copy_rules)
end on

type cb_copy_rules from commandbutton within tabpage_verif
integer x = 823
integer y = 48
integer width = 402
integer height = 84
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Rules"
end type

event clicked;//Start Code Change ----11.20.2017 #V154 maha
long li_facil
integer res
integer r
integer rc
n_ds lds_rules


openwithparm(w_select_facility, "B")
li_facil = message.doubleparm

if li_facil < 1 then return

res = messagebox("Copy Rules","Are you sure you wish to delete the existing rules and copy from the selected Facility?", question!, yesno!, 2)
if res = 2 then return

//delete the existing rules
dw_verif_rules.reset()
delete from facility_ver_rules where facility_id = :il_facility_id;
commit using sqlca;

//get existing rules to copy
lds_rules = create n_ds
lds_rules.dataobject = "d_facility_rules_single"
lds_rules.settransobject(sqlca)
rc = lds_rules.retrieve(li_facil)

lds_rules.rowscopy( 1, rc, primary!, lds_rules, 1000,primary!) 

for r = rc + 1 to lds_rules.rowcount()
	lds_rules.setitem(r, "facility_id", il_facility_id)
next

lds_rules.update()

destroy lds_rules

dw_select_section.retrieve(1)
end event

type mle_3 from multilineedit within tabpage_verif
integer x = 2715
integer y = 1320
integer width = 1280
integer height = 420
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "For the ~'Expiring Credential Option~' setting, ~'Create as Primary Source~' will create a verification record with ~'New Verification Default Method~' verification method.  The ~'Both~' setting will create two verifications: An Expiring Credential letter to be sent to the Practitioner, and another used if the user verifies with the Primary Source.  For no expiring Verification creation set the days value to 0 or blank."
boolean border = false
end type

type mle_2 from multilineedit within tabpage_verif
integer x = 2715
integer y = 256
integer width = 1280
integer height = 376
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "The ~'Reset Print~' and ~'Max Attempts~' settings apply to both Verification and Expiring letters.  From the Basic Information Screen, the ~'Reset~' setting also applies to the Expiring Appointment letters.  The ~'Complete as New Verification~' setting will complete the verification when it is created using the Default Complete."
boolean border = false
end type

type mle_1 from multilineedit within tabpage_verif
integer x = 2715
integer y = 640
integer width = 1280
integer height = 676
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Some settings are specific to certain screens only.  For Hospital Affiliations and Training, the ~'Create Duplicate Letters~' setting will create two verification records for each record for these screens: one with a ~'_cc~' at the end of the reference.  This is so separate letters can be sent to the facility: one to verify affiliation and one to certify competency.  The ~'Check Back Affiliation Years~' setting comes into play in the recredentialing process.  Based on this setting and the ~'Check Back Date~' value on the Appointment record, verifications for the new appointment cycle will only be created if the end dates fall within the range specified."
boolean border = false
end type

type cb_2 from commandbutton within tabpage_verif
boolean visible = false
integer x = 2917
integer y = 1316
integer width = 247
integer height = 108
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "set false"
end type

event clicked;ib_rules_added = false
end event

type dw_verif_rules from u_dw within tabpage_verif
integer x = 754
integer y = 176
integer width = 1833
integer height = 1668
integer taborder = 30
string dataobject = "d_verification_setup_database"
boolean vscrollbar = false
end type

event buttonclicked;string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "Doc Files (*.DOC),*.DOC")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value = 1 THEN
	IF dwo.name = "exp_letter" THEN
		This.SetItem( row, "exp_cred_letter_doc_nm", named )	
	ELSE
		This.SetItem( row, "init_veif_letter_doc_nm", named )	
	END IF
END IF


end event

event itemchanged;call super::itemchanged;Integer li_screen_id
Integer li_found
String ls_fld_nm
String ls_data
Integer nullval
DataWindowChild dwchild

SetNull( nullval )

IF This.GetColumnName() =  "verify_data" THEN
	//IF data = "N" THEN
	//	This.SetItem( row, "exp_cred_que_letters_days", 0 )
	//END IF
END IF

//---------Begin Added by alfee 09.09.2011---------------
IF dwo.name =  "verify_data" THEN
	IF IsNull(This.GetItemNumber( row, "facility_ver_rules_compl_at_create" )) THEN
		This.SetItem(row, "facility_ver_rules_compl_at_create", 0)
	END IF
END IF
//---------End Added ---------------------------------------

ls_fld_nm = This.GetColumnName()
IF  ls_fld_nm = "default_verif_means" THEN
	This.GetChild( "default_verif_means", dwchild )
	li_found = dwchild.Find( "lookup_code = " + data, 1, 1000 )
	ls_data = dwchild.GetItemString( li_found, "code" )
	IF Upper( ls_data ) = "IVERIFY" THEN
		li_screen_id = This.GetItemNumber( row, "screen_id" )
		IF li_screen_id <> 4 AND li_screen_id <> 5 AND li_screen_id <> 6 AND li_screen_id <> 7 AND li_screen_id <> 20 THEN
			MessageBox( "iVerify", "iVerify can only be used to verify Education, Training, Licensure, DEA or Board Certification.  Please modify." ) 
		END IF
	END IF
END IF
end event

event constructor;call super::constructor;//Start Code Change ----11.01.2011 #V12 maha - moved from of_retrieve detail
this.of_SetTransObject( SQLCA )
this.of_SetUpdateAble( True )
this.of_SetReqColumn( True )
this.insertrow(1)
of_rules_child( )

end event

event pfc_postupdate;call super::pfc_postupdate;//Added by Appeon long.zhang 05.08.2015 (Bug id 4519 Missing green check marks in Facility Setup verifications screen)
of_set_screen_color()
return 0
end event

type dw_select_section from u_dw within tabpage_verif
event pfc_after_select ( )
event ue_goto_status ( )
integer width = 745
integer height = 1844
integer taborder = 20
boolean titlebar = true
string title = "Select Data Screen"
string dataobject = "d_data_view_screens_list"
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 08.03.2006 By: LeiWei
	//$<reason> Fix a defect.
	/*
	This.SelectRow( 0, False )
	This.SelectRow( li_row, True )
	This.ScrollToRow( li_row )
	*/
	//---------------------------- APPEON END ----------------------------
	
	This.SetRow( li_row )
END IF
end event

event retrieveend;call super::retrieveend;Integer li_screen_id

li_screen_id = This.GetItemNumber( 1, "screen_id" )
dw_verif_rules.Retrieve( il_facility_id, li_screen_id )

This.SelectRow( 1, True )

//Added by Appeon long.zhang 05.08.2015 (Bug id 4519 Missing green check marks in Facility Setup verifications screen)
of_set_screen_color()

end event

event rowfocuschanged;call super::rowfocuschanged;Integer li_screen_id
integer li_find
integer r

IF currentrow > 0 THEN
	IF IsValid(iw_parent_window) /*AND ib_adding_new = False*/ THEN  //Commented By Ken.Guo 05.23.2008.Fixed BugK052101.
		IF iw_parent_window.Event pfc_save( ) < 0 THEN
			Return -1
		END IF
	END IF
	li_screen_id = This.GetItemNumber( currentrow, "screen_id" )
	r = dw_verif_rules.Retrieve( il_facility_id, li_screen_id )
	
	//Start Code Change ----09.01.2011.2011 #V11 maha  -  added trap to copy rule is none exists
	if r = 0 then
		li_find = tab_facilty.tabpage_verif.dw_copy_rules.find("screen_id = " + string(li_screen_id), 1, 1000)
		if li_find > 0 then
			 tab_facilty.tabpage_verif.dw_copy_rules.rowscopy( li_find,li_find, primary! ,tab_facilty.tabpage_verif.dw_verif_rules ,1 ,primary!)
			 tab_facilty.tabpage_verif.dw_verif_rules.setitem ( 1,"facility_id", il_facility_id )
		end if
	end if
	//End Code Change ----09.01.2011.2011 

	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
	This.ScrollToRow( currentrow )




END IF

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

type dw_copy_rules from u_dw within tabpage_verif
boolean visible = false
integer x = 768
integer y = 656
integer width = 352
integer height = 204
integer taborder = 11
string dataobject = "d_facility_rules_all"
boolean vscrollbar = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.Retrieve( )
end event

type tabpage_committee from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Committees"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_del_all cb_del_all
cb_del_m cb_del_m
cb_non_prac cb_non_prac
cb_batch cb_batch
cb_member cb_member
dw_committee_mem dw_committee_mem
dw_committee_d dw_committee_d
cb_add_committee cb_add_committee
dw_committee dw_committee
cb_del_committee cb_del_committee
gb_committee gb_committee
gb_comm_member gb_comm_member
end type

on tabpage_committee.create
this.cb_del_all=create cb_del_all
this.cb_del_m=create cb_del_m
this.cb_non_prac=create cb_non_prac
this.cb_batch=create cb_batch
this.cb_member=create cb_member
this.dw_committee_mem=create dw_committee_mem
this.dw_committee_d=create dw_committee_d
this.cb_add_committee=create cb_add_committee
this.dw_committee=create dw_committee
this.cb_del_committee=create cb_del_committee
this.gb_committee=create gb_committee
this.gb_comm_member=create gb_comm_member
this.Control[]={this.cb_del_all,&
this.cb_del_m,&
this.cb_non_prac,&
this.cb_batch,&
this.cb_member,&
this.dw_committee_mem,&
this.dw_committee_d,&
this.cb_add_committee,&
this.dw_committee,&
this.cb_del_committee,&
this.gb_committee,&
this.gb_comm_member}
end on

on tabpage_committee.destroy
destroy(this.cb_del_all)
destroy(this.cb_del_m)
destroy(this.cb_non_prac)
destroy(this.cb_batch)
destroy(this.cb_member)
destroy(this.dw_committee_mem)
destroy(this.dw_committee_d)
destroy(this.cb_add_committee)
destroy(this.dw_committee)
destroy(this.cb_del_committee)
destroy(this.gb_committee)
destroy(this.gb_comm_member)
end on

type cb_del_all from u_cb within tabpage_committee
integer x = 3392
integer y = 1464
integer width = 558
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete All Members"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer 	li_ans
long 		ll_Cycle,ll_RowCnt

if  tab_facilty.tabpage_committee.dw_committee_mem.RowCount() < 1 then return
li_ans = MessageBox("Delete", "Are you sure you want to delete All of the member?", Question!, YesNo!, 1 )
IF li_ans = 1 THEN

	ll_RowCnt = tab_facilty.tabpage_committee.dw_committee_mem.RowCount()
	
	for ll_Cycle = 1 to ll_RowCnt
		tab_facilty.tabpage_committee.dw_committee_mem.DeleteRow(1)
	next
	
END IF

end event

type cb_del_m from u_cb within tabpage_committee
integer x = 3392
integer y = 1364
integer width = 558
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete Member"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_ans

if  tab_facilty.tabpage_committee.dw_committee_mem.getrow() < 1 then return
li_ans = MessageBox("Delete", "Are you sure you want to delete member?", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	tab_facilty.tabpage_committee.dw_committee_mem.DeleteRow( 0 )
END IF
end event

type cb_non_prac from u_cb within tabpage_committee
integer x = 3392
integer y = 1264
integer width = 558
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Add Non-Practitioners"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long i
long ic
long li_prac_id, li_facility_id
long li_find, ll_comm_id
long li_nr, li_row
string ls_full_name
gs_batch_search ist_search

if dw_committee_d.getrow() <1 then 
	return 0
end if 

li_row = tab_facilty.tabpage_committee.dw_committee_d.getrow()
if isnull(tab_facilty.tabpage_committee.dw_committee_d.getitemnumber(li_row,"facility_id")) then
	messagebox("Reminder","Please select Committee before adding member")
	return -1
end if

openwithparm(w_non_prac_painter,"S")

IF Message.DoubleParm = -1 THEN
	Return -1
else
	if not isvalid(message.powerobjectparm) then return 0
	ist_search = message.powerobjectparm
	
	ll_comm_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "committee_id" ) 
     li_facility_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "facility_id" ) 
	of_batch_add(ist_search, ll_comm_id, li_facility_id)
	
	tab_facilty.tabpage_committee.dw_committee_mem.SetFocus( )
END IF
end event

type cb_batch from u_cb within tabpage_committee
integer x = 3392
integer y = 1164
integer width = 558
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Batch Add Members"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long i
long ic
long li_prac_id, li_facility_id
long li_find, ll_comm_id
long li_nr, li_row
string ls_full_name
gs_batch_search ist_search

if dw_committee_d.getrow() <1 then 
	return 0
end if 

li_row = tab_facilty.tabpage_committee.dw_committee_d.getrow()
if isnull(tab_facilty.tabpage_committee.dw_committee_d.getitemnumber(li_row,"facility_id")) then
	messagebox("Reminder","Please select Committee before adding member")
	return -1
end if

openwithparm(w_batch_prac_select_new,"G")

if message.stringparm = "Cancel" then 
	return
else
	if not isvalid(message.powerobjectparm) then return 0
	ist_search = message.powerobjectparm
	ll_comm_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "committee_id" ) 
     li_facility_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "facility_id" ) 
	of_batch_add(ist_search, ll_comm_id, li_facility_id)

	tab_facilty.tabpage_committee.dw_committee_mem.SetFocus( )

end if
end event

type cb_member from u_cb within tabpage_committee
integer x = 3392
integer y = 1064
integer width = 558
integer taborder = 11
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Add Single Member"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_nr
Integer li_find
long li_prac_id, li_facility_id
String ls_full_name
integer li_row, i
integer ic
long    ll_comm_id
gs_batch_search ist_search

if dw_committee_d.getrow() <1 then 
	return 0
end if 

li_row = tab_facilty.tabpage_committee.dw_committee_d.getrow()
if isnull(tab_facilty.tabpage_committee.dw_committee_d.getitemnumber(li_row,"facility_id")) then
	messagebox("Reminder","Please select Committee before adding member")
	return -1
end if
gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String(tab_facilty.tabpage_committee.dw_committee_d.getitemnumber(li_row,"facility_id"))

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm

if not isvalid(message.powerobjectparm) then return 0
ll_comm_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "committee_id" ) 
li_facility_id = tab_facilty.tabpage_committee.dw_committee_d.getitemnumber( li_row, "facility_id" ) 
of_batch_add(ist_search, ll_comm_id, li_facility_id)

tab_facilty.tabpage_committee.dw_committee_mem.SetFocus( )


end event

type dw_committee_mem from u_dw within tabpage_committee
integer x = 14
integer y = 952
integer width = 4325
integer height = 876
integer taborder = 11
string dataobject = "d_committee_members"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if row > 0 then
	this.setrow(row)
	this.selectrow(0, false)
	this.selectrow(row, true)
end if


end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 08.17.2011 by Stephen
//////////////////////////////////////////////////////////////////////

if currentrow > 0 then
	this.setrow(currentrow)
	this.selectrow(0, false)
	this.selectrow(currentrow, true)
end if
end event

type dw_committee_d from u_dw within tabpage_committee
integer x = 1298
integer y = 164
integer width = 3026
integer height = 696
integer taborder = 11
string dataobject = "d_committee_detail_f"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.22.2011 by Stephen
//////////////////////////////////////////////////////////////////////

dwitemstatus ldws_new
integer li_old
integer li_ret
string   ls_ret
long     ll_comm_id, ll_row

ldws_new = this.getitemstatus(row, 0, primary!)
if not (ldws_new = new! or ldws_new = newmodified!) then
	choose case dwo.name
		case "active_status"
			li_old = this.getitemnumber(row, "active_status", primary!, false)
			if li_old = 1 and data = '0' then
				
				ll_comm_id = this.getitemnumber(row,"Committee_id")				
				select count(1)
				into   :ll_row
				from pd_comm_review a, pd_affil_stat b
				 where a.Committee_id = :ll_comm_id 
				 and a.rec_id = b.rec_id
				 and b.active_status in(1,4);
				//Start Code Change ----08.09.2011 #V11 maha  - modified code slightly to case statement adding no found record message		 
				if ll_row < 1 then //no connected committee records
					li_ret =  messagebox("Status change","Changing a committee to Inactive means that as new appointment are added, the inactive committees will not appear in the practitioner folder.~r~r Do you wish to change the status",question!,yesno!,2)
					if li_ret = 2 then
						this.setitem(row, "active_status", li_old)	
						return 2
					end if
				else
					open(w_modify_comm_status)
					ls_ret = message.stringparm	
					
					choose case ls_ret
						case "0"
							this.setitem(row, "active_status", li_old)					
							return	 2	
						case "1"	
							//leave all records
						case '2' 
							delete pd_comm_review
							from pd_comm_review a, pd_affil_stat b
						 	where a.Committee_id = :ll_comm_id 
							 and a.rec_id = b.rec_id
							 and b.active_status in(1,4);

					
						case  '3' 
							//Start Code Change ----.2011 #V12 maha - and (a.date_sent_for_review  is null  or a.date_back_from_review is null)
							delete pd_comm_review
							from pd_comm_review a, pd_affil_stat b
							 where a.Committee_id = :ll_comm_id 
							 and (a.date_sent_for_review  is null  and a.date_back_from_review is null)
							 and a.rec_id = b.rec_id
							 and b.active_status in(1,4);
					end choose
				end if

//					if isnull(ls_ret) or ls_ret = '0' or ls_ret = '1' then
//						this.setitem(row, "active_status", li_old)					
//						return	 2
//					end if
//					
//					if ls_ret = '2' then
//						delete pd_comm_review
//							from pd_comm_review a, pd_affil_stat b
//						 where a.Committee_id = :ll_comm_id 
//							 and a.rec_id = b.rec_id
//							 and b.active_status in(1,4);
//					end if
//					
//					if ls_ret = '3' then
//						delete pd_comm_review
//							from pd_comm_review a, pd_affil_stat b
//						 where a.Committee_id = :ll_comm_id 
//							 and (a.date_sent_for_review  is null  or a.date_back_from_review is null)
//							 and a.rec_id = b.rec_id
//							 and b.active_status in(1,4);
//					end if
//				end if
				//Start Code Change ----08.09.2011 #V11 maha
			end if
	end choose
end if
end event

event other;call super::other;//////////////////////////////////////////////////////////////////////
// $<event> other
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 08.18.2011  (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////

if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

type cb_add_committee from u_cb within tabpage_committee
integer x = 41
integer y = 64
integer width = 407
integer height = 84
integer taborder = 21
boolean bringtotop = true
string text = "Add Committee"
end type

event clicked;Integer li_nr
Integer li_committee_id

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.11.2008 By: Evan
//$<reason> Fix BugS122705	about when clicking Add Committee twice, the following error occurs.
//if dw_committee.rowcount() > 0 then cb_save.triggerevent(clicked!) //maha 102300
if dw_committee.ModifiedCount() > 0 then
	li_nr = cb_save.Event Clicked()
	if li_nr = -1 then Return
end if
//---------------------------- APPEON END ----------------------------

li_nr = dw_committee.InsertRow( 0 )

SELECT Max( committee_id )  
INTO :li_committee_id  
FROM committee_lookup  ;

li_committee_id++

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 02.13.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Comment out the following script since the previous script has already
//$<modification> obtained value for li_commitee_id.
/*
li_committee_id = gnv_app.of_get_id("COMMITTEE")
*/
//---------------------------- APPEON END ----------------------------

dw_committee.SetItem( li_nr, "committee_id", li_committee_id)
dw_committee.SetItem( li_nr, "facility_id", il_facility_id)
dw_committee.SetItem( li_nr, "active_status", 1) //add by Stephen 06.21.2011 (V11.3 Committee Proc Upd)
dw_committee.ScrollToRow( li_nr )
dw_committee.SetRow( li_nr )
dw_committee_d.SetFocus( )
dw_committee_d.setcolumn("committee_name")


end event

type dw_committee from u_dw within tabpage_committee
integer x = 27
integer y = 164
integer width = 1266
integer height = 696
integer taborder = 11
string dataobject = "d_committee_setup"
end type

event constructor;
This.of_SetTransObject( SQLCA )
ib_rmbmenu	= False

//add by Stephen 06.21.2011 (V11.3 Committee Proc Upd)
tab_facilty.tabpage_committee.dw_committee.sharedata(tab_facilty.tabpage_committee.dw_committee_d)
this.of_setupdateable(false) 

end event

event pfc_preupdate;call super::pfc_preupdate;integer i

for i = 1 to this.rowcount()
	if isnull(this.getitemstring(1,"committee_name")) then
		messagebox("Data entry error","Committee on line " + string(1) + " does not have a name.  Please enter name and resave.")
		return -1
	end if
next

return 1
end event

event retrieveend;call super::retrieveend;//////////////////////////////////////////////////////////////////////
// $<event> retrieveend
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 06.21.2011
//////////////////////////////////////////////////////////////////////

long ll_comm_id


if rowcount < 1 then return

this.setrow(1)

of_retrieve_comm_detail()
end event

event rowfocuschanged;call super::rowfocuschanged;//add by Stephen 06.21.2011 (V11.3 Committee Proc Upd)
if currentrow > 0 then
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
	of_retrieve_comm_detail()
end if
end event

event clicked;call super::clicked;//add by Stephen 06.21.2011 (V11.3 Committee Proc Upd)

//Start Code Change ----08.09.2011 #V11 maha 
integer r

r = this.getclickedrow( )

if row > 0 then
	this.selectrow(0,false)
	this.selectrow(r,true)
	//of_retrieve_comm_detail()
end if

//End Code Change ----08.09.2011


end event

event losefocus;call super::losefocus;//add by Stephen 06.21.2011 (V11.3 Committee Proc Upd)
this.AcceptText() 
end event

type cb_del_committee from u_cb within tabpage_committee
integer x = 453
integer y = 64
integer width = 453
integer height = 84
integer taborder = 11
boolean bringtotop = true
string text = "Delete Committee"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Delete committee (Corrected BugA120303)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.15.2009
//////////////////////////////////////////////////////////////////////

integer li_Row
integer li_Count1
integer li_Count2
integer li_committee_id
long  ll_RowCnt , ll_Cycle

li_Row = dw_committee.GetRow()
if li_Row <= 0 then Return
if MessageBox("Delete", "Are you sure you want to delete the selected committee?", Question!, YesNo!) = 2 then Return

li_committee_id = dw_committee.object.committee_id[li_Row]
if li_committee_id > 0 then
	gnv_appeondb.of_StartQueue()
	SELECT count(*) INTO :li_Count1 FROM pd_comm_review WHERE committee_id = :li_committee_id;
	SELECT count(*) INTO :li_Count2 FROM meetings WHERE committee = :li_committee_id;
	gnv_appeondb.of_CommitQueue()
	if li_Count1 > 0 then
		MessageBox("Delete Error", "There are " + string(li_Count1) + " committee review records connected to this committee. Delete the records before deleting the committee.", StopSign!)
		Return
	end if
	if li_Count2 > 0 then
		MessageBox("Delete Error", "There are " + string(li_Count2) + " meeting records connected to this committee. Delete the records before deleting the committee.", StopSign!)
		Return
	end if
end if

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 06.21.2011
//$<reason> V11.3 Committee Proc Upd
delete from committee_members where Committee_id = :li_committee_id;
//------------------- APPEON END -------------------

dw_committee.DeleteRow(li_Row)

cb_save.Event Clicked()
end event

type gb_committee from groupbox within tabpage_committee
integer x = 5
integer width = 4338
integer height = 884
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Committees"
end type

type gb_comm_member from groupbox within tabpage_committee
integer y = 892
integer width = 4347
integer height = 952
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Committee Members"
end type

type tabpage_dept_chair from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 16777215
string text = "Dept. Chair"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_1 cb_1
cb_del_chair1 cb_del_chair1
cb_add_chair1 cb_add_chair1
dw_dc_browse dw_dc_browse
dw_dc_detail dw_dc_detail
end type

on tabpage_dept_chair.create
this.cb_1=create cb_1
this.cb_del_chair1=create cb_del_chair1
this.cb_add_chair1=create cb_add_chair1
this.dw_dc_browse=create dw_dc_browse
this.dw_dc_detail=create dw_dc_detail
this.Control[]={this.cb_1,&
this.cb_del_chair1,&
this.cb_add_chair1,&
this.dw_dc_browse,&
this.dw_dc_detail}
end on

on tabpage_dept_chair.destroy
destroy(this.cb_1)
destroy(this.cb_del_chair1)
destroy(this.cb_add_chair1)
destroy(this.dw_dc_browse)
destroy(this.dw_dc_detail)
end on

type cb_1 from commandbutton within tabpage_dept_chair
boolean visible = false
integer x = 9
integer y = 1712
integer width = 247
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)
dw_dc_browse.SetSort(null_str)
dw_dc_browse.Sort( )

end event

type cb_del_chair1 from u_cb within tabpage_dept_chair
integer x = 2624
integer y = 1716
integer width = 407
integer height = 84
integer taborder = 100
string text = "Delete"
end type

event clicked;call super::clicked;Integer li_ans
Integer li_find


if dw_dc_detail.rowcount() < 1 then return

li_ans = MessageBox("Delete", "Are you sure you want to Delete the current record?", Question!, YesNo!, 1 ) // Modify by Evan 05.07.2009 --- Corrected BugS122704

IF li_ans = 2 THEN
	Return
END IF

dw_dc_detail.DeleteRow( dw_dc_detail.GetRow( ) )

dw_dc_detail.Update( )

dw_dc_browse.Retrieve( il_facility_id )

dw_dc_browse.SelectRow( 0, False )

if dw_dc_detail.GetRow() < 1 then return

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.18.2006 By: LeiWei
//$<reason> Fix a defect.
//li_find = dw_dc_browse.Find( "dept_chair_id = " + String( dw_dc_detail.GetItemNumber( dw_dc_detail.GetRow(), "dept_chair_id" ) ), 1, 10000 )
Long ll_dept_chair_id
ll_dept_chair_id = dw_dc_detail.GetItemNumber( dw_dc_detail.GetRow(), "dept_chair_id" ) 
If Isnull(ll_dept_chair_id) Then ll_dept_chair_id = 0
li_find = dw_dc_browse.Find( "dept_chair_id = " + String( ll_dept_chair_id ), 1, 10000 )
//---------------------------- APPEON END ----------------------------

dw_dc_browse.SelectRow( li_find, True )
dw_dc_browse.ScrollToRow( li_find )
dw_dc_browse.SetRow( li_find )
end event

type cb_add_chair1 from u_cb within tabpage_dept_chair
integer x = 2199
integer y = 1716
integer width = 407
integer height = 84
integer taborder = 11
string text = "Add"
end type

event clicked;call super::clicked;Integer li_rc

li_rc = dw_dc_detail.InsertRow( 0 )

dw_dc_detail.SetFocus( )

dw_dc_detail.SetColumn( "department_code" )

dw_dc_detail.SetRow( li_rc )
dw_dc_detail.ScrollToRow( li_rc )
end event

type dw_dc_browse from u_dw within tabpage_dept_chair
integer width = 2144
integer height = 1708
integer taborder = 11
string dataobject = "d_department_chair_browse"
end type

event retrieveend;call super::retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 02.21.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Have the application retrieve the database only when rowcount=1 to reduce calls to server.
/*
IF rowcount > 0 THEN
	dw_dc_detail.Retrieve( This.GetItemNumber( 1, "dept_chair_id" ) )
	dw_dc_detail.SetFocus( )
END IF
*/
IF rowcount = 1 THEN
	dw_dc_detail.Retrieve( This.GetItemNumber( 1, "dept_chair_id" ) )
	dw_dc_detail.SetFocus( )
END IF
//---------------------------- APPEON END ----------------------------


end event

event clicked;call super::clicked;IF row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( row, True )	
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;Long 	ll_dept_chair_id
//--------Begin Added by Nova 07.08.2009------------------------
//$<reason> Needs to reset dw_dc_detail (Corrected BugN052701)
dw_dc_detail.reset()
//--------End Added --------------------------------------------
IF currentrow > 0 THEN
	ll_dept_chair_id = This.GetItemNumber( currentrow, "dept_chair_id" )
	dw_dc_detail.Retrieve( 	ll_dept_chair_id  )
	dw_dc_detail.SetFocus( )
	dw_dc_detail.SetColumn( "department_code" )
END IF
end event

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.SetTransObject( SQLCA )

DataWindowChild dwchild

This.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.10.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
This.GetChild( "department_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Department")
dwchild.InsertRow( 1 )


This.GetChild( "section_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Section")
dwchild.InsertRow( 1 )
*/

This.GetChild( "department_code", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Department') + "'", dwchild)
dwchild.InsertRow( 1 )


This.GetChild( "section_code", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Section') + "'", dwchild)
dwchild.InsertRow( 1 )

//---------------------------- APPEON END ----------------------------





end event

type dw_dc_detail from u_dw within tabpage_dept_chair
integer x = 2149
integer width = 1618
integer height = 1708
integer taborder = 11
string dataobject = "d_department_chair_detail"
boolean vscrollbar = false
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 02.10.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
This.GetChild( "department_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Department")
dwchild.InsertRow( 1 )


This.GetChild( "section_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Section")
dwchild.InsertRow( 1 )
*/

This.GetChild( "department_code", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Department') + "'", dwchild)
dwchild.InsertRow( 1 )


This.GetChild( "section_code", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Section') + "'", dwchild)
dwchild.InsertRow( 1 )

//---------------------------- APPEON END ----------------------------




end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_dept_chair_id
Integer i
Integer li_rc

SELECT Max( dept_chair_id )
INTO :ll_dept_chair_id
FROM dept_chair;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
	Return -1
END IF


IF IsNull( ll_dept_chair_id ) THEN
	ll_dept_chair_id = 0
END IF

li_rc = This.RowCount()


FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		IF IsNull( This.GetItemNumber( i, "department_code" ) ) THEN
			MessageBox("Required Data", "You must select a Department for the Department Chair Record." )
			This.ScrollToRow( i )
			This.SetRow( i )
			This.SetFocus( )
			tab_facilty.SelectTab( 8 )
			Return -1
		END IF
		IF IsNull( This.GetItemString( i, "name" ) ) THEN
			MessageBox("Required Data", "You must select a chairperson Name for the Department Chair Record." )
			This.ScrollToRow( i )
			This.SetRow( i )
			This.SetFocus( )
			tab_facilty.SelectTab( 8 )
			Return -1
		END IF		
	END IF
END FOR


FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		ll_dept_chair_id++
		This.SetItem( i, "dept_chair_id", ll_dept_chair_id )
		This.SetItem( i, "facility_id", il_facility_id )		
	END IF
END FOR

il_last_dept_chair = This.GetItemNumber( This.GetRow( ), "dept_chair_id" )

Return 1
end event

event pfc_postupdate;call super::pfc_postupdate;dw_dc_browse.Retrieve( il_facility_id )

Return 1
end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-07-29 By: Scofield
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

type tabpage_workflow from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
long backcolor = 33551856
string text = "Work Flow"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
end type

type tabpage_webview from userobject within tab_facilty
integer x = 18
integer y = 100
integer width = 4347
integer height = 1848
boolean border = true
long backcolor = 33551856
string text = "WebView"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type dw_detail from u_dw within pfc_cst_u_facility_setup
event ue_scroll ( )
event ue_key pbm_dwnkey
integer x = 41
integer y = 224
integer width = 4343
integer height = 1840
integer taborder = 20
string dataobject = "d_facility_setup_database"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_scroll();IF NOT ib_tab_change THEN

	CHOOSE CASE  tab_facilty.SelectedTab 
		CASE 2
			dw_detail.Object.DataWindow.VerticalScrollPosition='0'
			dw_detail.SetColumn( "email_address" )				
		CASE 3
			dw_detail.Object.DataWindow.VerticalScrollPosition='1888'		
			dw_detail.SetColumn( "return_fax" )				
		CASE 4
			dw_detail.Object.DataWindow.VerticalScrollPosition='4190'				
			dw_detail.SetColumn( "work_gap_check" )						
		CASE 5
			dw_detail.Object.DataWindow.VerticalScrollPosition='5800'		
			dw_detail.SetColumn( "npdb_cert_date" )	
		CASE 9 //Added for Work flow. 18/10/2006 Henry
			dw_detail.Object.DataWindow.VerticalScrollPosition='7680'		
			dw_detail.SetColumn( "wf_expiring_appointment" )	
		CASE 10 //Added from WebView. 05/05/2011 Michael
			dw_detail.Object.DataWindow.VerticalScrollPosition ='9350'		
			dw_detail.SetColumn( "default_wv_reapp_template" )
	END CHOOSE

END IF
This.SetRedraw( True )
end event

event ue_key;//////////////////////////////////////////////////////////////////////
// $<event> ue_key
// $<arguments>
//			keycode			key
//			unsignedlong	keyflags
// $<returns> long
// $<description> DataWindow key event
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.07.2009
//////////////////////////////////////////////////////////////////////

string ls_Column

// Corrected BugS122610
ls_Column = this.GetColumnName()
choose case ls_Column
	case "email_address", "return_fax", "reappah_export_id", "oig_auto_dob", "wf_webview_application_complete"
		if Key = KeyTab! then Return 1
	case else
end choose

Return 0
end event

event pfc_postupdate;call super::pfc_postupdate;//Start Code Change ----05.21.2014 #V14.2 maha
datawindowchild dwchild

this.getchild( "parent_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
//Start Code Change ----05.21.2014 

//Integer li_rc
//Integer i

//IF ib_rules_added = False THEN
//
//	li_rc = tab_facilty.tabpage_verif.dw_copy_rules.RowCount()
//	tab_facilty.tabpage_verif.dw_copy_rules.RowsCopy( 1, li_rc, Primary!, tab_facilty.tabpage_verif.dw_verif_rules, 1, Primary! )
//	
//	FOR i = 1 TO li_rc
//		tab_facilty.tabpage_verif.dw_verif_rules.SetItem( i, "facility_id", il_facility_id )
//	END FOR
//	
//	li_rc = tab_facilty.tabpage_verif.dw_verif_rules.rowcount()
//	tab_facilty.tabpage_verif.dw_verif_rules.Update()
//	commit using sqlca;
//	tab_facilty.tabpage_verif.dw_select_section.Reset()
//	tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
//	tab_facilty.tabpage_verif.dw_select_section.SelectRow( 1, True )
//	IF iw_parent_window.Event pfc_save() < 0 THEN
//		Return 1
//	END IF		
//	ib_rules_added = True
//	MessageBox("User Painter", "To assign this facility to a user you need to update the User Painter.")
//END IF
//
//string ls_sql
//integer facid
//
//facid = this.getitemnumber(1,"facility_id")
////set verif rules for duplicate letters maha 041801
//if this.getitemnumber(1,"dupeset") = 1 then
//	Update facility_ver_rules 
//	set ver_ltr_doc = 'Y'	
//	where facility_id = :facid and screen_id in (7,10);
//
//else 
//	Update facility_ver_rules 
//	set ver_ltr_doc = 'N'	
//	where facility_id = :facid and screen_id in (7,10);
//end if
// 
// commit using sqlca;


RETURN 1


end event

event pfc_preupdate;call super::pfc_preupdate;long i
long u
long li_rc
long li_rec_id
long li_facility_id
long li_user_cnt
long ll_cnt //maha 06.04.2014
long li_access_rights = 0
n_ds lds_users
String ls_user_id
String ls_version
 nv_entity_functions lnv_ent

li_rc = This.RowCount() //Start Code Change ----03.21.2011 #V11 maha - readded


Integer li_word_storage_type
li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	if this.getitemstatus( 1, "letter_path", primary!) = datamodified! then
		this.setitem(1,"letter_path",of_check_path(this.GetItemString( 1, "letter_path" ),1)) 
	end if
END IF



//Start Code Change ----06.15.2011 #V11 maha - additional defaults set for checkboxes
FOR i = 1 TO li_rc  
	if isnull(dw_detail.getitemnumber(li_rc,"dupeset")) then dw_detail.SetItem(  li_rc, "dupeset", 0)
	if isnull(dw_detail.getitemnumber(li_rc,"oig_auto_lname")) then dw_detail.SetItem(  li_rc, "oig_auto_lname", 0)
	if isnull(dw_detail.getitemnumber(li_rc,"oig_auto_fname")) then dw_detail.SetItem(  li_rc, "oig_auto_fname", 0)
	if isnull(dw_detail.getitemnumber(li_rc,"oig_auto_dob")) then dw_detail.SetItem(  li_rc, "oig_auto_dob", 0)
	if isnull(dw_detail.getitemstring(li_rc,"wf_exp_appt")) then dw_detail.SetItem(  li_rc, "wf_exp_appt", 'N')
	if isnull(dw_detail.getitemnumber(li_rc,"prov_export")) then dw_detail.SetItem( li_rc, "prov_export", 0) 
	if isnull(dw_detail.getitemnumber(li_rc,"reapp_export")) then dw_detail.SetItem( li_rc, "reapp_export", 0) 
	if isnull(dw_detail.getitemnumber(li_rc,"reappah_export")) then dw_detail.SetItem( li_rc, "reappah_export", 0)
next
//End Code Change ----06.15.2011


lnv_ent = create nv_entity_functions //maha 072610

FOR i = 1 TO li_rc  
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		li_facility_id = This.GetItemNumber( i, "facility_id" )	
		lnv_ent.of_add_user_facility(li_facility_id, 0) //add user security maha 072610 // Modify by Stephen 03.29.2011 --- Fixed a bug.

	END IF
END FOR


//Start Code Change ----04.21.2014 #V14.2 maha - entity functionality
if this.getitemstatus(1,0,primary!) = datamodified! then
	li_facility_id = This.GetItemNumber( 1, "facility_id" )	
	select count(entity_id) into :ll_cnt from entity_lookup where facility_id = :li_facility_id;

	if ll_cnt > 0 then
		lnv_ent.of_update_entity_links(this,"F", li_facility_id)
	end if
	//Start Code Change ----10.23.2014 #V14.2 maha - check for parent
	 if this.getitemstatus(1,"is_parent" ,primary!) = datamodified! then
		if this.getitemnumber(1,"is_parent") = 0 and this.getitemnumber(1,"is_parent", primary!,true) = 1 then
			select count(parent_id) into :ll_cnt from facility where parent_id = :li_facility_id;
			if ll_cnt > 0 then 
				update facility set parent_id = null where parent_id = :li_facility_id;
			end if
		end if
	end if
	//Start Code Change ----10.23.2014
end if

destroy lnv_ent

RETURN Success
	
end event

event buttonclicked;call super::buttonclicked;string is_path
string docname, named
integer value


if dwo.name = "usedefault" then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.07.2006 By: Rodger Wu
	//$<reason> Open Letter Storage Area Painter for template management.
	/*
	//messagebox("","yes")
	select letter_path
	into :is_path
	from facility
	where facility_id = 1;
	this.setitem(this.getrow(),"letter_path",is_path)
	*/
	
	String ls_letterpath
	datawindowchild ldwc_child

	if gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
		Upper( appeongetclienttype() ) = 'WEB' then
		ls_letterpath = Trim( This.GetItemString( row, "letter_path" ) )
		if LenA( ls_letterpath ) > 0 then
			OpenWithParm( w_area_painter, ls_letterpath + "@path" )
		else
			Open( w_area_painter )
		end if
		
		
		// Refresh dddw
		gnv_appeondb.of_startqueue( )
		
		This.Getchild("letter_path",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )
		
		This.Getchild("reapp_doc_name",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )
		
		This.Getchild("prov_doc_name",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )
		
		This.Getchild("reappah_doc_name",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )

		tab_facilty.tabpage_verif.dw_verif_rules.Getchild("exp_cred_letter_doc_nm",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )

		tab_facilty.tabpage_verif.dw_verif_rules.Getchild("init_veif_letter_doc_nm",ldwc_child)
		ldwc_child.Settransobject(sqlca)
		ldwc_child.Retrieve( )
		
		gnv_appeondb.of_commitqueue( )
	else
		//messagebox("","yes")
		select letter_path
		into :is_path
		from facility
		where facility_id = 1;
		this.setitem(this.getrow(),"letter_path",is_path)
	end if
	//---------------------------- APPEON END ----------------------------
end if

if dwo.name = "brow_re" then
	value = GetFileOpenName("Select File", &
	+ docname, named, "DOC", &
		+ "Doc Files (*.DOC),*.DOC")
	this.setitem(this.getrow(),"reapp_doc_name",named)

end if

if dwo.name = "brow_pr" then
	value = GetFileOpenName("Select File", &
	+ docname, named, "DOC", &
		+ "Doc Files (*.DOC),*.DOC")
	this.setitem(this.getrow(),"prov_doc_name",named)

end if

if dwo.name = "brow_ah" then
	value = GetFileOpenName("Select File", &
	+ docname, named, "DOC", &
		+ "Doc Files (*.DOC),*.DOC")
	this.setitem(this.getrow(),"reappah_doc_name",named)

end if
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-07-29 By: Scofield
//$<Reason> Popup a dialog to input the phone

//String	ls_Phone,ls_fax,ls_RetParm
//
//if row > 0 and row <= This.RowCount() then
//	if dwo.name = 'b_phone' then
//		ls_Phone = This.GetItemString(row,'phone')
//		OpenWithParm(w_phonedetail,ls_Phone)
//		
//		ls_RetParm = Message.StringParm
//		
//		if ls_RetParm <> 'Cancel' then
//			This.SetItem(row,'phone',ls_RetParm)
//		end if
//		This.SetColumn('phone')
//	elseif dwo.name = 'b_fax' then
//		ls_fax = This.GetItemString(row,'fax')
//		if IsNull(ls_fax) then ls_fax = ""
//		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
//		
//		ls_RetParm = Message.StringParm
//		
//		if ls_RetParm <> 'Cancel' then
//			This.SetItem(row,'fax',ls_RetParm)
//		end if
//		This.SetColumn('fax')
//	elseif dwo.name = 'b_rtn_phone' then
//		ls_Phone = This.GetItemString(row,'return_phone')
//		OpenWithParm(w_phonedetail,ls_Phone)
//		
//		ls_RetParm = Message.StringParm
//		
//		if ls_RetParm <> 'Cancel' then
//			This.SetItem(row,'return_phone',ls_RetParm)
//		end if
//		This.SetColumn('return_phone')
//	elseif dwo.name = 'b_rtn_fax' then
//		ls_fax = This.GetItemString(row,'return_fax')
//		if IsNull(ls_fax) then ls_fax = ""
//		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
//		
//		ls_RetParm = Message.StringParm
//		
//		if ls_RetParm <> 'Cancel' then
//			This.SetItem(row,'return_fax',ls_RetParm)
//		end if
//		This.SetColumn('return_fax')
//	elseif dwo.name = 'b_cert_phone' then
//		ls_Phone = This.GetItemString(row,'npdb_cert_phone')
//		OpenWithParm(w_phonedetail,ls_Phone)
//		
//		ls_RetParm = Message.StringParm
//		
//		if ls_RetParm <> 'Cancel' then
//			This.SetItem(row,'npdb_cert_phone',ls_RetParm)
//		end if
//		This.SetColumn('npdb_cert_phone')
//	end if
//end if
//---------------------------- APPEON END ----------------------------

//Start Code Change ----03.25.2010 #V10 maha
if dwo.name = "b_aa90" then
	messagebox("App Audit 90 day letter","This setting will allow the creation of a letter Action added to the Practitioner Verification tab for notifying the provider that there are outstanding required document(s) still missing.")
end if
if dwo.name = "b_ccf" then
	messagebox("Central Credentialing Facility","This setting will allow all current appointment records to be set to inactive when the Status for the the Central Credentialing Facility is set to inactive from the Appointment Status screen.")
end if
//End Code Change ----03.25.2010	

//Start Code Change ----10.01.2014 #V14.2 maha
if dwo.name = "b_clear" then
	setnull(value)
	this.setitem(row,"parent_id", value)
end if
//End Code Change ----10.01.2014

//Start Code Change ----08.22.2016 #V153 maha
if dwo.name = "b_bill_rules" then
	openwithparm(w_facility_billing_rules, il_facility_id )
end if
//End Code Change ----08.22.2016
end event

event scrollvertical;call super::scrollvertical;
//------------------- APPEON BEGIN -------------------
//$<modify> Michael 05.05.2011
//$<reason> Fixed a Bug(id 2388):the scroll wheel on mouse. 
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.16.2006 By: Ye KaiChun
//$<reason> ScrollVertical is used to provide a special display effect.  
//$<reason> This effect has been implemented by VerticalScrollPosition workaround. 

//IF NOT ib_tab_change THEN
//	This.SetRedraw( False )
//	PostEvent( "ue_scroll" )
//END IF

If Upper(appeongetclienttype()) = "PB" Then
	IF NOT ib_tab_change THEN
		This.SetRedraw( False )
		PostEvent( "ue_scroll" )
	END IF
end if

//---------------------------- APPEON END ----------------------------
*/
IF NOT ib_tab_change THEN
	This.SetRedraw( False )
	PostEvent( "ue_scroll" )
END IF
//---------------------APPEON END ----------------------------
end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.07.2006 By: Rodger Wu
//$<modification> When a letter path is changed, letters in the corresponding letter path will
//$<modification> be changed accordingly.
if dwo.Name = "letter_path" and row > 0 then
	Post of_filter_docs( True )
end if
//---------------------------- APPEON END ----------------------------

 //Start Code Change ----04.07.2015 #V15 maha
 	string val
 if dwo.name = "zip" then
	this.accepttext( )
	val = this.getitemstring(1,"zip")
	of_zip_fill(val, "FAC1", this)
elseif dwo.name = "return_zip" then
	this.accepttext( )
	val = this.getitemstring(1,"return_zip")
	of_zip_fill(val, "FAC2", this)	
end if
end event

event other;call super::other;//////////////////////////////////////////////////////////////////////
// $<event> other
// $<arguments>
//			unsignedlong	wparam
//			long				lparam
// $<returns> long
// $<description> DataWindow other event
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.07.2009
//////////////////////////////////////////////////////////////////////

// Corrected BugS122610
if Message.Number = 522 then
	Return 1
end if
end event

event clicked;call super::clicked;//Start Code Change ----03.24.2016 #V15 maha - moved from buttonclicked as object type changed

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
	elseif dwo.name = 'b_rtn_phone' then
		ls_Phone = This.GetItemString(row,'return_phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'return_phone',ls_RetParm)
		end if
		This.SetColumn('return_phone')
	elseif dwo.name = 'b_rtn_fax' then
		ls_fax = This.GetItemString(row,'return_fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'return_fax',ls_RetParm)
		end if
		This.SetColumn('return_fax')
	elseif dwo.name = 'b_cert_phone' then
		ls_Phone = This.GetItemString(row,'npdb_cert_phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'npdb_cert_phone',ls_RetParm)
		end if
		This.SetColumn('npdb_cert_phone')
	end if
end if
end event

