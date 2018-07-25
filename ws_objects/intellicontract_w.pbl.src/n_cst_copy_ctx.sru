$PBExportHeader$n_cst_copy_ctx.sru
forward
global type n_cst_copy_ctx from nonvisualobject
end type
end forward

global type n_cst_copy_ctx from nonvisualobject
end type
global n_cst_copy_ctx n_cst_copy_ctx

forward prototypes
public function integer of_copy_document_manager (long al_ctx_id_source, long al_ctx_id_destin)
public function integer of_update_ctx_flag (long al_ctx_id, integer ai_flag)
public function long of_copy_ctx_data (str_copy_ctx astr_copy_ctx)
public function integer of_update_template_data (str_copy_ctx astr_copy_ctx, long al_template_id)
public function long of_copy_ctx_from_template (long al_template_id)
public function integer of_update_requirement_profile (long al_source_ctx_id, long al_target_ctx_id)
public subroutine of_locate_ctx (long al_ctx_id)
public subroutine of_show_contract_window ()
public function integer of_check_exist_contract ()
public function integer of_locate_ctx (long al_ctx_id, integer ai_tab_index)
public subroutine of_copy_alarms (str_copy_ctx astr_copy_ctx, long al_ctx_id, long al_ori_action_id[], long al_new_action_id[])
public subroutine of_copy_custom_data (str_copy_ctx astr_copy_ctx, long al_new_ctx_id)
public function integer of_insert_contact (long al_ctx_id, integer ai_ib_default_email, integer ai_ib_owner)
public subroutine of_copy_company_contact_data (str_copy_ctx astr_copy_ctx, long ai_new_ctx_id)
end prototypes

public function integer of_copy_document_manager (long al_ctx_id_source, long al_ctx_id_destin);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctx::of_copy_document_manager()
// $<arguments>
//		value	long	al_ctx_id_source		
//		value	long	al_ctx_id_destin		
// $<returns> integer
// $<description>
// $<description> this function is copy from w_copy_contract.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-24 by Ken.Guo
//////////////////////////////////////////////////////////////////////


long		ll_Cycle_01,ll_RowCnt_01,ll_Cycle_02,ll_RowCnt_02,ll_Cycle_03,ll_RowCnt_03
long		ll_doc_id_old,ll_doc_id_new,ll_doc_status,ll_Rtn
String	ls_RevControl

Decimal	ld_Revision

DataStore	lds_ctx_am_document_Source
DataStore	lds_ctx_am_doc_image_Source
DataStore	lds_ctx_am_document_clause_Source

DataStore	lds_ctx_am_document_Destin
DataStore	lds_ctx_am_doc_image_Destin
DataStore	lds_ctx_am_document_clause_Destin

/*
DataStore	lds_ctx_am_action_item_Source
DataStore	lds_ctx_am_doc_audit_Source
DataStore	lds_ctx_am_ai_notification_Source
DataStore	lds_ctx_am_ai_notification_users_Source
DataStore	lds_ctx_am_ai_alarm_attachment_Source
DataStore	lds_ctx_am_image_weblink_Source

DataStore	lds_ctx_am_action_item_Destin
DataStore	lds_ctx_am_doc_audit_Destin
DataStore	lds_ctx_am_ai_notification_Destin
DataStore	lds_ctx_am_ai_notification_users_Destin
DataStore	lds_ctx_am_ai_alarm_attachment_Destin
DataStore	lds_ctx_am_image_weblink_Destin

d_ctx_am_document_copy
d_ctx_am_doc_image_copy
d_ctx_am_action_item_copy
d_ctx_am_doc_audit_copy
d_ctx_am_document_clause_copy
d_ctx_am_ai_notification_copy
d_ctx_am_ai_notification_users_copy
d_ctx_am_ai_alarm_attachment_copy
d_ctx_am_image_weblink_copy
*/

///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_document_Source = Create DataStore
lds_ctx_am_document_Source.DataObject = "d_ctx_am_document_copy"
lds_ctx_am_document_Source.SetTransObject(SQLCA)

lds_ctx_am_document_Destin = Create DataStore
lds_ctx_am_document_Destin.DataObject = "d_ctx_am_document_copy"
lds_ctx_am_document_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_doc_image_Source = Create DataStore
lds_ctx_am_doc_image_Source.DataObject = "d_ctx_am_doc_image_copy"
lds_ctx_am_doc_image_Source.SetTransObject(SQLCA)

lds_ctx_am_doc_image_Destin = Create DataStore
lds_ctx_am_doc_image_Destin.DataObject = "d_ctx_am_doc_image_copy"
lds_ctx_am_doc_image_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////
lds_ctx_am_document_clause_Source = Create DataStore
lds_ctx_am_document_clause_Source.DataObject = "d_ctx_am_document_clause_copy"
lds_ctx_am_document_clause_Source.SetTransObject(SQLCA)

lds_ctx_am_document_clause_Destin = Create DataStore
lds_ctx_am_document_clause_Destin.DataObject = "d_ctx_am_document_clause_copy"
lds_ctx_am_document_clause_Destin.SetTransObject(SQLCA)
///////////////////////////////////////////////////////////////////////////////

ll_doc_status = long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Status') and upper(code) = upper('New')"))

lds_ctx_am_document_Source.Retrieve(al_ctx_id_source)
lds_ctx_am_document_Destin.Reset()
ll_RowCnt_01 = lds_ctx_am_document_Source.RowCount()

for ll_Cycle_01 = 1 to ll_RowCnt_01
	lds_ctx_am_document_Source.RowsCopy(ll_Cycle_01,ll_Cycle_01,Primary!,lds_ctx_am_document_Destin,ll_Cycle_01,Primary!)
	
	ll_doc_id_new = gnv_app.of_get_id("doc_id")
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"doc_id",ll_doc_id_new)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"ctx_id",al_ctx_id_destin)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"create_by",gs_user_id)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"create_date",Today())
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status",ll_doc_status)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status_by",gs_user_id)
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"status_date",Today())
	lds_ctx_am_document_Destin.SetItem(ll_Cycle_01,"checkout_status","0")
	lds_ctx_am_document_Destin.SetItemStatus(ll_Cycle_01,0,Primary!,NewModified!)
	
	ll_Rtn = lds_ctx_am_document_Destin.Update()
	if ll_Rtn = 1 then
		COMMIT USING SQLCA;
	else
		ROLLBACK USING SQLCA;
		CONTINUE
	end if
	
	ll_doc_id_old = lds_ctx_am_document_Source.GetItemNumber(ll_Cycle_01,"doc_id")
	lds_ctx_am_doc_image_Source.Retrieve(ll_doc_id_old)
	lds_ctx_am_doc_image_Destin.Reset()
	
	if lds_ctx_am_doc_image_Source.RowCount() <= 0 then CONTINUE
	ll_RowCnt_02 = 1		//Only copy the original revision
	for ll_Cycle_02 = 1 to ll_RowCnt_02
		ld_Revision = lds_ctx_am_doc_image_Source.GetItemDecimal(ll_Cycle_02,"Revision")
		
		if ld_Revision = 0.0 then
			ls_RevControl = "0"
		else
			ls_RevControl = "1"
		end if
		
		lds_ctx_am_doc_image_Source.RowsCopy(ll_Cycle_02,ll_Cycle_02,Primary!,lds_ctx_am_doc_image_Destin,ll_Cycle_02,Primary!)
		
		lds_ctx_am_doc_image_Destin.SetItem(ll_Cycle_02,"doc_id",ll_doc_id_new)
		lds_ctx_am_doc_image_Destin.SetItem(ll_Cycle_02,"modify_date",Today())
		lds_ctx_am_doc_image_Destin.SetItemStatus(ll_Cycle_02,0,Primary!,NewModified!)
		
		ll_Rtn = lds_ctx_am_doc_image_Destin.Update()
		if ll_Rtn = 1 then
			COMMIT USING SQLCA;
		else
			ROLLBACK USING SQLCA;
			CONTINUE
		end if
		
		UPDATE ctx_am_doc_image
			SET image_file = (SELECT image_file FROM ctx_am_doc_image WHERE doc_id = :ll_doc_id_old AND revision = :ld_Revision)
		 WHERE doc_id = :ll_doc_id_new AND revision = :ld_Revision;
		 
		UPDATE ctx_am_document
		   SET Revision = :ld_Revision,
				 Revision_control = :ls_RevControl,
				 checkout_by = null,
				 checkout_date = null
		 WHERE doc_id = :ll_doc_id_new;
		 
		COMMIT USING SQLCA;
		
		lds_ctx_am_document_clause_Source.Retrieve(ll_doc_id_old,ld_Revision)
		lds_ctx_am_document_clause_Destin.Reset()
		
		ll_RowCnt_03 = lds_ctx_am_document_clause_Source.RowCount()
		lds_ctx_am_document_clause_Source.RowsCopy(1,ll_RowCnt_03,Primary!,lds_ctx_am_document_clause_Destin,1,Primary!)
		for ll_Cycle_03 = 1 to ll_RowCnt_03
			lds_ctx_am_document_clause_Destin.SetItem(ll_Cycle_03,"doc_id",ll_doc_id_new)
			lds_ctx_am_document_clause_Destin.SetItemStatus(ll_Cycle_03,0,Primary!,NewModified!)
		next
		ll_Rtn = lds_ctx_am_document_clause_Destin.Update()
		if ll_Rtn = 1 then
			COMMIT USING SQLCA;
		else
			ROLLBACK USING SQLCA;
			CONTINUE
		end if
	next
next

Return 1
end function

public function integer of_update_ctx_flag (long al_ctx_id, integer ai_flag);//ai_flag 	0: Contracts		1: Template
update ctx_basic_info set is_template = :ai_flag where ctx_id = :al_ctx_id;
Return 1
end function

public function long of_copy_ctx_data (str_copy_ctx astr_copy_ctx);//Modified By Ken.Guo 2009-08-24 Copy from w_copy_contract cb_ok.clicked.
//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctx::of_copy_ctx_data()
// $<arguments>
//		value	str_copy_ctx	astr_copy_ctx		
// $<returns> long  new ctx id
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-24 by Ken.Guo
//////////////////////////////////////////////////////////////////////


long ll_ctx_id,ll_record_id,ll_element_id,ll_parent_comp_id,ll_loc_id,ll_org_id,ll_fee_sched_id,ll_fee_sched_id1
long ll_fee_sched_location_id,ll_fee_sched_location_id1,ll_fee_sched_data_id,ll_loc_id1
long ll_row,i,j,k,ll_cnt
boolean lb_copy
n_cst_workflow_triggers lnv_workflow
str_action_item lstr_action
long ll_ori_id[],ll_new_id[]
Long 		ll_getrow					//Added By Mark Lee 11/20/2012
string 	ls_company_name 
long 		ll_get_ctx_id, ll_app_facility

If astr_copy_ctx.si_is_template = 1 Then
	openwithparm( w_appeon_gifofwait, "Saving the selected contract as the template..." )					
Else
	//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
	Choose Case astr_copy_ctx.as_copy_sub_ctx
		Case 'Create Credit Sub Contract'
			openwithparm( w_appeon_gifofwait, "Creating Credit Sub Contract..." )
		Case 'Create Contract Sub Contract'
			openwithparm( w_appeon_gifofwait, "Creating Contract Sub Contract..." )
		Case Else
			openwithparm( w_appeon_gifofwait, "Copying the selected contract/template..." )
	End Choose
	
End If
timer(0,w_appeon_gifofwait)
SetPointer(HourGlass!)
datastore lds_detail
datastore lds_ctx_basic_info
datastore lds_company_contacts
datastore lds_ctx_contract_contacts
datastore lds_products
datastore lds_ctx_products
datastore lds_requirements
datastore lds_ctx_req_profile_hdr
datastore lds_profile_detail
datastore lds_ctx_elements
datastore lds_other_contacts
datastore lds_parent_organization
datastore lds_ctx_loc
datastore lds_group_locations
datastore lds_selected_facility
datastore lds_ctx_location_pracs
datastore lds_specialties
datastore lds_ctx_location_specialty
datastore lds_organization_list
datastore lds_ctx_orgs_contact
datastore lds_ctx_org_contact
datastore lds_fee_schedules
datastore lds_ctx_fee_sched_hdr
datastore lds_providers
datastore lds_ctx_fee_sched_pracs
datastore lds_fee_schedule_locations
datastore lds_ctx_fee_sched_locations
datastore lds_fees
datastore lds_ctx_fee_sched_data
datastore lds_fee_schedules2
datastore lds_ctx_fee_sched_nm
datastore lds_action_items
datastore lds_ctx_action_item
datastore lds_ctx_group_access
datastore lds_ctx_linked_provider//Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)

lds_detail = Create datastore
lds_detail.dataobject = 'd_contract_det_master'
lds_detail.settransobject(sqlca)

lds_ctx_basic_info = Create datastore
lds_ctx_basic_info.dataobject = 'd_ctx_basic_info'
lds_ctx_basic_info.settransobject(sqlca)

lds_company_contacts = Create datastore
lds_company_contacts.dataobject = 'd_contract_det_contact_external'
lds_company_contacts.settransobject(sqlca)

lds_ctx_contract_contacts = Create datastore
lds_ctx_contract_contacts.dataobject = 'd_ctx_contract_contacts'
lds_ctx_contract_contacts.settransobject(sqlca)

lds_products = Create datastore
lds_products.dataobject = 'd_ctx_products'
lds_products.settransobject(sqlca)

lds_ctx_products = Create datastore
lds_ctx_products.dataobject = 'd_ctx_products_copy'
lds_ctx_products.settransobject(sqlca)

/*
lds_requirements = Create datastore
lds_requirements.dataobject = 'd_profile_header'
lds_requirements.settransobject(sqlca)

lds_ctx_req_profile_hdr = Create datastore
lds_ctx_req_profile_hdr.dataobject = 'd_ctx_req_profile_hdr_copy'
lds_ctx_req_profile_hdr.settransobject(sqlca)

lds_profile_detail = Create datastore
lds_profile_detail.dataobject = 'd_contract_profile_req_existing'
lds_profile_detail.settransobject(sqlca)

lds_ctx_elements = Create datastore
lds_ctx_elements.dataobject = 'd_ctx_elements_copy'
lds_ctx_elements.settransobject(sqlca)
*/

lds_other_contacts = Create datastore
lds_other_contacts.dataobject = 'd_contract_det_contact_contact_copy'
lds_other_contacts.settransobject(sqlca)

lds_parent_organization = Create datastore
lds_parent_organization.dataobject = 'd_contract_multi_group_browse'
lds_parent_organization.settransobject(sqlca)

lds_ctx_loc = Create datastore
lds_ctx_loc.dataobject = 'd_ctx_loc_copy'
lds_ctx_loc.settransobject(sqlca)

lds_group_locations = Create datastore
lds_group_locations.dataobject = 'd_contract_group_linked_locations_copy'
lds_group_locations.settransobject(sqlca)

lds_selected_facility = Create datastore
lds_selected_facility.dataobject = 'd_contract_group_practitioners_existing1'
lds_selected_facility.settransobject(sqlca)

lds_ctx_location_pracs = Create datastore
lds_ctx_location_pracs.dataobject = 'd_ctx_location_pracs_copy'
lds_ctx_location_pracs.settransobject(sqlca)

lds_specialties = Create datastore
lds_specialties.dataobject = 'd_cntx_location_spec_copy'
lds_specialties.settransobject(sqlca)

lds_ctx_location_specialty = Create datastore
lds_ctx_location_specialty.dataobject = 'd_ctx_location_specialty_copy'
lds_ctx_location_specialty.settransobject(sqlca)

lds_organization_list = Create datastore
lds_organization_list.dataobject = 'd_org_search2_copy'
lds_organization_list.settransobject(sqlca)

lds_ctx_orgs_contact = Create datastore
lds_ctx_orgs_contact.dataobject = 'd_ctx_orgs_contact_copy'
lds_ctx_orgs_contact.settransobject(sqlca)

lds_ctx_org_contact = Create datastore
lds_ctx_org_contact.dataobject = 'd_ctx_org_contact_copy'
lds_ctx_org_contact.settransobject(sqlca)

lds_fee_schedules = Create datastore
lds_fee_schedules.dataobject = 'd_ctx_free_sched_hdr_copy'
lds_fee_schedules.settransobject(sqlca)

lds_ctx_fee_sched_hdr = Create datastore
lds_ctx_fee_sched_hdr.dataobject = 'd_ctx_fee_sched_hdr_copy'
lds_ctx_fee_sched_hdr.settransobject(sqlca)

lds_providers = Create datastore
lds_providers.dataobject = 'd_ctx_schedule_fee_pracs_copy'
lds_providers.settransobject(sqlca)

lds_ctx_fee_sched_pracs = Create datastore
lds_ctx_fee_sched_pracs.dataobject = 'd_ctx_fee_sched_pracs_copy'
lds_ctx_fee_sched_pracs.settransobject(sqlca)

lds_fee_schedule_locations = Create datastore 
lds_fee_schedule_locations.dataobject = 'd_ctx_schedule_fee_locations_copy'
lds_fee_schedule_locations.settransobject(sqlca)

lds_ctx_fee_sched_locations = Create datastore
lds_ctx_fee_sched_locations.dataobject = 'd_ctx_fee_sched_locations_copy'
lds_ctx_fee_sched_locations.settransobject(sqlca)

lds_fees = Create datastore
lds_fees.dataobject = 'd_ctx_schedule_fee_detail_copy1'
lds_fees.settransobject(sqlca)

lds_ctx_fee_sched_data = Create datastore
lds_ctx_fee_sched_data.dataobject = 'd_ctx_schedule_fee_detail_copy'
lds_ctx_fee_sched_data.settransobject(sqlca)

lds_fee_schedules2 = Create datastore
lds_fee_schedules2.dataobject = 'd_contract_fee_sched_nm'
lds_fee_schedules2.settransobject(sqlca)

lds_ctx_fee_sched_nm = Create datastore
lds_ctx_fee_sched_nm.dataobject = 'd_ctx_fee_sched_nm_copy'
lds_ctx_fee_sched_nm.settransobject(sqlca)

lds_action_items = Create datastore
lds_action_items.dataobject = 'd_cntx_action_items'
lds_action_items.settransobject(sqlca)

lds_ctx_action_item = create datastore
lds_ctx_action_item.dataobject = 'd_ctx_action_items_copy'
lds_ctx_action_item.settransobject(sqlca)

//Added By Ken.Guo 2009-05-20.
lds_ctx_group_access = Create datastore
lds_ctx_group_access.dataobject = 'd_contract_det_group_access'
lds_ctx_group_access.settransobject(sqlca)

//-------------appeon begin----------------------
//<$>added:long.zhang 04.15.2014
//<$>reason:v14.2 Provider-Contract direct linking
lds_ctx_linked_provider = create datastore
lds_ctx_linked_provider.dataobject = 'd_ctx_provider_direct_link'
lds_ctx_linked_provider.settransobject( sqlca)
//-------------appeon End------------------------


lds_detail.retrieve(astr_copy_ctx.sl_ctx_id )

If lds_detail.rowcount() < 1 Then 
	If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)
	Return -1
End If

ll_row = lds_ctx_basic_info.insertrow(0)

If astr_copy_ctx.si_is_template = 1 Then
	ll_ctx_id = gnv_app.of_get_id('ctx_template_id')
Else
	ll_ctx_id = gnv_app.of_get_id('CTX_ID')
End If


ll_record_id = gnv_app.of_get_id('RECORD_ID')
lds_ctx_basic_info.setitem(ll_row,'ctx_id',ll_ctx_id)
lds_ctx_basic_info.setitem(ll_row,'record_id',ll_record_id)
//add by Jack 07.06.2007
lds_ctx_basic_info.setitem(ll_row,'master_contract_id',0)
lds_ctx_basic_info.setitem(ll_row,'master_contract_name','')  

w_appeon_gifofwait.of_setposition(20)

lb_copy = False
If astr_copy_ctx.sb_contract_detail = 1 Then
	//Contract Detail
	lds_ctx_basic_info.setitem(ll_row,'status',lds_detail.getitemnumber(1,'status'))
	lds_ctx_basic_info.setitem(ll_row,'category',lds_detail.getitemnumber(1,'category'))
	If astr_copy_ctx.si_clear_company = 1 and astr_copy_ctx.si_is_template = 0 Then
		//Use defaule value: null
	Else
		lds_ctx_basic_info.setitem(ll_row,'app_facility',lds_detail.getitemnumber(1,'app_facility'))		
	End IF
	lds_ctx_basic_info.setitem(ll_row,'contract_type',lds_detail.getitemnumber(1,'contract_type'))
	lds_ctx_basic_info.setitem(ll_row,'dvision',lds_detail.getitemnumber(1,'dvision'))
	lds_ctx_basic_info.setitem(ll_row,'file_location',lds_detail.getitemstring(1,'file_location'))
	lds_ctx_basic_info.setitem(ll_row,'master_contract_id',lds_detail.getitemnumber(1,'master_contract_id'))
	lds_ctx_basic_info.setitem(ll_row,'master_contract_name',lds_detail.getitemstring(1,'master_contract_name'))	
	lb_copy = True
End If

//Begin - Added By Mark Lee 11/16/2012
If not isnull(astr_copy_ctx.as_master_contract_name ) and trim(astr_copy_ctx.as_master_contract_name) <> '' Then 
	lds_ctx_basic_info.setitem(ll_row,'master_contract_id',astr_copy_ctx.sl_ctx_id)
	lds_ctx_basic_info.setitem(ll_row,'master_contract_name',astr_copy_ctx.as_master_contract_name)	
End If
//End - Added By Mark Lee 11/16/2012

//Begin - Added By Mark Lee 11/20/2012
If isvalid(gw_contract) Then 
	ll_getrow = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getselectedrow(0)
	If ll_getrow > 0 then 
		ll_get_ctx_id = gw_contract.tab_contract_details.tabpage_search.il_ctx_id
		ls_company_name = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_getrow)+" )")
		ll_app_facility 	= gw_contract.tab_contract_details.tabpage_search.dw_search_det1.GetItemNumber(ll_getrow,"app_facility")
		//Copy Company Name Data From Selected Master Contract   
		If astr_copy_ctx.ai_ib_create_child = 1 Then 
			lds_ctx_basic_info.setitem(ll_row,'master_contract_id',ll_get_ctx_id)
			lds_ctx_basic_info.setitem(ll_row,'master_contract_name',string(ll_get_ctx_id) +'-'+ls_company_name)	
		End If
		//Create as Child Contract Record 
		If astr_copy_ctx.ai_ib_copy_m_company = 1 Then 
			lds_ctx_basic_info.setitem(ll_row,'app_facility', ll_app_facility)
		End If
	End If
End If
//End - Added By Mark Lee 11/20/2012

If astr_copy_ctx.sb_contract_dates = 1 Then
	//Contract Dates
	lds_ctx_basic_info.setitem(ll_row,'effective_date',lds_detail.getitemdatetime(1,'effective_date'))
	lds_ctx_basic_info.setitem(ll_row,'review_date',lds_detail.getitemdatetime(1,'review_date'))
	lds_ctx_basic_info.setitem(ll_row,'term_reason',lds_detail.getitemnumber(1,'term_reason'))
	lds_ctx_basic_info.setitem(ll_row,'version_number',lds_detail.getitemstring(1,'version_number'))
	lds_ctx_basic_info.setitem(ll_row,'version_date',lds_detail.getitemdatetime(1,'version_date'))
	lds_ctx_basic_info.setitem(ll_row,'expriation_date',lds_detail.getitemdatetime(1,'expriation_date'))
	lds_ctx_basic_info.setitem(ll_row,'review_by',lds_detail.getitemstring(1,'review_by'))
	lds_ctx_basic_info.setitem(ll_row,'last_revis_date',lds_detail.getitemdatetime(1,'last_revis_date'))	
	lds_ctx_basic_info.setitem(ll_row,'term_date',lds_detail.getitemdatetime(1,'term_date'))	
	lds_ctx_basic_info.setitem(ll_row,'other_date_1',lds_detail.getitemdatetime(1,'other_date_1'))	
	lb_copy = True
End If
If astr_copy_ctx.sb_custom_data = 1 Then
	//Custom Data
	lds_ctx_basic_info.setitem(ll_row,'custom_1',lds_detail.getitemstring(1,'custom_1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_2',lds_detail.getitemstring(1,'custom_2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_3',lds_detail.getitemstring(1,'custom_3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_4',lds_detail.getitemstring(1,'custom_4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_5',lds_detail.getitemstring(1,'custom_5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_6',lds_detail.getitemstring(1,'custom_6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_7',lds_detail.getitemstring(1,'custom_7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_8',lds_detail.getitemstring(1,'custom_8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_9',lds_detail.getitemstring(1,'custom_9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_10',lds_detail.getitemstring(1,'custom_10'))
	lds_ctx_basic_info.setitem(ll_row,'custom_11',lds_detail.getitemstring(1,'custom_11'))
	lds_ctx_basic_info.setitem(ll_row,'custom_12',lds_detail.getitemstring(1,'custom_12'))
	lds_ctx_basic_info.setitem(ll_row,'custom_13',lds_detail.getitemstring(1,'custom_13'))
	lds_ctx_basic_info.setitem(ll_row,'custom_14',lds_detail.getitemstring(1,'custom_14'))
	lds_ctx_basic_info.setitem(ll_row,'custom_15',lds_detail.getitemstring(1,'custom_15'))
	lds_ctx_basic_info.setitem(ll_row,'custom_16',lds_detail.getitemstring(1,'custom_16'))
	lds_ctx_basic_info.setitem(ll_row,'custom_17',lds_detail.getitemstring(1,'custom_17'))
	lds_ctx_basic_info.setitem(ll_row,'custom_18',lds_detail.getitemstring(1,'custom_18'))
	lds_ctx_basic_info.setitem(ll_row,'custom_19',lds_detail.getitemstring(1,'custom_19'))
	lds_ctx_basic_info.setitem(ll_row,'custom_20',lds_detail.getitemstring(1,'custom_20'))	
	lds_ctx_basic_info.setitem(ll_row,'custom_date1',lds_detail.getitemdatetime(1,'custom_date1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date2',lds_detail.getitemdatetime(1,'custom_date2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date3',lds_detail.getitemdatetime(1,'custom_date3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date4',lds_detail.getitemdatetime(1,'custom_date4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date5',lds_detail.getitemdatetime(1,'custom_date5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date6',lds_detail.getitemdatetime(1,'custom_date6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date7',lds_detail.getitemdatetime(1,'custom_date7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date8',lds_detail.getitemdatetime(1,'custom_date8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date9',lds_detail.getitemdatetime(1,'custom_date9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date10',lds_detail.getitemdatetime(1,'custom_date10'))	
	//Replace GetItemNumber to GetItemDecimal and Add custom_n11 - custom_n25 - jervis 08.09.2010
	lds_ctx_basic_info.setitem(ll_row,'custom_n1',lds_detail.getitemdecimal(1,'custom_n1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n2',lds_detail.getitemdecimal(1,'custom_n2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n3',lds_detail.getitemdecimal(1,'custom_n3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n4',lds_detail.getitemdecimal(1,'custom_n4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n5',lds_detail.getitemdecimal(1,'custom_n5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n6',lds_detail.getitemdecimal(1,'custom_n6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n7',lds_detail.getitemdecimal(1,'custom_n7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n8',lds_detail.getitemdecimal(1,'custom_n8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n9',lds_detail.getitemdecimal(1,'custom_n9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n10',lds_detail.getitemdecimal(1,'custom_n10'))	
	
	lds_ctx_basic_info.setitem(ll_row,'custom_n11',lds_detail.getitemdecimal(1,'custom_n11'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n12',lds_detail.getitemdecimal(1,'custom_n12'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n13',lds_detail.getitemdecimal(1,'custom_n13'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n14',lds_detail.getitemdecimal(1,'custom_n14'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n15',lds_detail.getitemdecimal(1,'custom_n15'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n16',lds_detail.getitemdecimal(1,'custom_n16'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n17',lds_detail.getitemdecimal(1,'custom_n17'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n18',lds_detail.getitemdecimal(1,'custom_n18'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n19',lds_detail.getitemdecimal(1,'custom_n19'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n20',lds_detail.getitemdecimal(1,'custom_n20'))	
	lds_ctx_basic_info.setitem(ll_row,'custom_n21',lds_detail.getitemdecimal(1,'custom_n21'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n22',lds_detail.getitemdecimal(1,'custom_n22'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n23',lds_detail.getitemdecimal(1,'custom_n23'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n24',lds_detail.getitemdecimal(1,'custom_n24'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n25',lds_detail.getitemdecimal(1,'custom_n25'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n26',lds_detail.getitemdecimal(1,'custom_n26'))
	lds_ctx_basic_info.setitem(ll_row,'custom_n27',lds_detail.getitemdecimal(1,'custom_n27'))
	
	lds_ctx_basic_info.setitem(ll_row,'custom_21',lds_detail.getitemstring(1,'custom_21'))
	lds_ctx_basic_info.setitem(ll_row,'custom_22',lds_detail.getitemstring(1,'custom_22'))	
	lds_ctx_basic_info.setitem(ll_row,'custom_date11',lds_detail.getitemdatetime(1,'custom_date11'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date12',lds_detail.getitemdatetime(1,'custom_date12'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date13',lds_detail.getitemdatetime(1,'custom_date13'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date14',lds_detail.getitemdatetime(1,'custom_date14'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date15',lds_detail.getitemdatetime(1,'custom_date15'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date16',lds_detail.getitemdatetime(1,'custom_date16'))
	lds_ctx_basic_info.setitem(ll_row,'custom_date17',lds_detail.getitemdatetime(1,'custom_date17'))
	
	//Add notes, percent,work_flow ... fields -- jervis 12.30.2010
	lds_ctx_basic_info.setitem(ll_row,'custom_notes_1',lds_detail.getitemstring(1,'custom_notes_1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_notes_2',lds_detail.getitemstring(1,'custom_notes_2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_notes_3',lds_detail.getitemstring(1,'custom_notes_3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_notes_4',lds_detail.getitemstring(1,'custom_notes_4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_notes_5',lds_detail.getitemstring(1,'custom_notes_5'))

	lds_ctx_basic_info.setitem(ll_row,'custom_percent_1',lds_detail.getitemdecimal(1,'custom_percent_1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_2',lds_detail.getitemdecimal(1,'custom_percent_2'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_3',lds_detail.getitemdecimal(1,'custom_percent_3'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_4',lds_detail.getitemdecimal(1,'custom_percent_4'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_5',lds_detail.getitemdecimal(1,'custom_percent_5'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_6',lds_detail.getitemdecimal(1,'custom_percent_6'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_7',lds_detail.getitemdecimal(1,'custom_percent_7'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_8',lds_detail.getitemdecimal(1,'custom_percent_8'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_9',lds_detail.getitemdecimal(1,'custom_percent_9'))
	lds_ctx_basic_info.setitem(ll_row,'custom_percent_10',lds_detail.getitemdecimal(1,'custom_percent_10'))
	lds_ctx_basic_info.setitem(ll_row,'work_flow_n1',lds_detail.getitemdecimal(1,'work_flow_n1'))
	lds_ctx_basic_info.setitem(ll_row,'work_flow_n2',lds_detail.getitemdecimal(1,'work_flow_n2'))
	lds_ctx_basic_info.setitem(ll_row,'work_flow_n3',lds_detail.getitemdecimal(1,'work_flow_n3'))
	lds_ctx_basic_info.setitem(ll_row,'work_flow_n4',lds_detail.getitemdecimal(1,'work_flow_n4'))
	lds_ctx_basic_info.setitem(ll_row,'work_flow_n5',lds_detail.getitemdecimal(1,'work_flow_n5'))
	
	//Add custom status field - jervis 04.19.2011
	lds_ctx_basic_info.setitem(ll_row,'custom_status1',lds_detail.getitemdecimal(1,'custom_status1'))
	lds_ctx_basic_info.setitem(ll_row,'custom_status2',lds_detail.getitemdecimal(1,'custom_status2'))

	
		
	lb_copy = True
End If
If astr_copy_ctx.sb_notes = 1 Then
	//Notes
	lds_ctx_basic_info.setitem(ll_row,'notes',lds_detail.getitemstring(1,'notes'))		
	lb_copy = True
End If
If astr_copy_ctx.sb_contracted_contacts = 1 Then
	If astr_copy_ctx.si_clear_company = 1 and astr_copy_ctx.si_is_template = 0 Then
		//Clean Contracted company contacts when clean company name - jervis 09.02.2011
	Else
		//Contracted Company Contacts
		lds_company_contacts.retrieve(astr_copy_ctx.sl_ctx_id,'E')
		For i = 1 To lds_company_contacts.rowcount()		
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_contract_contacts.insertrow(0)
			lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_company_contacts.getitemnumber(i,'contact_id'))
			lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_company_contacts.getitemstring(i,'ic_area'))
			lds_ctx_contract_contacts.setitem(ll_row,'association',lds_company_contacts.getitemstring(i,'association'))
			lds_ctx_contract_contacts.setitem(ll_row,'default_email',lds_company_contacts.getitemstring(i,'default_email'))
			lds_ctx_contract_contacts.setitem(ll_row,'owner',lds_company_contacts.getitemstring(i,'ctx_contract_contacts_owner'))
			lds_ctx_contract_contacts.setitem(ll_row,'access',lds_company_contacts.getitemstring(i,'access'))		
			lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
			lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
			//added by gavins 20121203
			lds_ctx_contract_contacts.setitem(ll_row,'association2',lds_company_contacts.getitemstring(i,'association2'))
			lds_ctx_contract_contacts.setitem(ll_row,'association3',lds_company_contacts.getitemstring(i,'association3'))
			lds_ctx_contract_contacts.setitem(ll_row,'association4',lds_company_contacts.getitemstring(i,'association4'))
			lds_ctx_contract_contacts.setitem(ll_row,'association5',lds_company_contacts.getitemstring(i,'association5'))
			lds_ctx_contract_contacts.setitem(ll_row,'association6',lds_company_contacts.getitemstring(i,'association6'))
			lds_ctx_contract_contacts.setitem(ll_row,'association7',lds_company_contacts.getitemstring(i,'association7'))
			lds_ctx_contract_contacts.setitem(ll_row,'association8',lds_company_contacts.getitemstring(i,'association8'))
			lds_ctx_contract_contacts.setitem(ll_row,'association9',lds_company_contacts.getitemstring(i,'association9'))
			lds_ctx_contract_contacts.setitem(ll_row,'association10',lds_company_contacts.getitemstring(i,'association10'))
			lb_copy = True
		Next
	End If
End If
If astr_copy_ctx.sb_our_contacts = 1 Then
	//Our Company Contacts  
	lds_company_contacts.retrieve(astr_copy_ctx.sl_ctx_id,'I')
	For i = 1 To lds_company_contacts.rowcount()		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_contract_contacts.insertrow(0)
		lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_company_contacts.getitemnumber(i,'contact_id'))
		lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_company_contacts.getitemstring(i,'ic_area'))
		lds_ctx_contract_contacts.setitem(ll_row,'association',lds_company_contacts.getitemstring(i,'association'))
		lds_ctx_contract_contacts.setitem(ll_row,'default_email',lds_company_contacts.getitemstring(i,'default_email'))
		lds_ctx_contract_contacts.setitem(ll_row,'owner',lds_company_contacts.getitemstring(i,'ctx_contract_contacts_owner'))
		lds_ctx_contract_contacts.setitem(ll_row,'access',lds_company_contacts.getitemstring(i,'access'))		
		lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
		//added by gavins 20121203
		lds_ctx_contract_contacts.setitem(ll_row,'association2',lds_company_contacts.getitemstring(i,'association2'))
		lds_ctx_contract_contacts.setitem(ll_row,'association3',lds_company_contacts.getitemstring(i,'association3'))
		lds_ctx_contract_contacts.setitem(ll_row,'association4',lds_company_contacts.getitemstring(i,'association4'))
		lds_ctx_contract_contacts.setitem(ll_row,'association5',lds_company_contacts.getitemstring(i,'association5'))
		lds_ctx_contract_contacts.setitem(ll_row,'association6',lds_company_contacts.getitemstring(i,'association6'))
		lds_ctx_contract_contacts.setitem(ll_row,'association7',lds_company_contacts.getitemstring(i,'association7'))
		lds_ctx_contract_contacts.setitem(ll_row,'association8',lds_company_contacts.getitemstring(i,'association8'))
		lds_ctx_contract_contacts.setitem(ll_row,'association9',lds_company_contacts.getitemstring(i,'association9'))
		lds_ctx_contract_contacts.setitem(ll_row,'association10',lds_company_contacts.getitemstring(i,'association10'))
		lb_copy = True
	Next
End if

w_appeon_gifofwait.of_setposition(30)
If astr_copy_ctx.sb_products = 1 Then
	//Products
	lds_products.retrieve(astr_copy_ctx.sl_ctx_id)
	For i = 1 To lds_products.rowcount()
		ll_record_id = gnv_app.of_get_id('RECORD_ID')		
		ll_row = lds_ctx_products.insertrow(0)
		lds_ctx_products.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_products.setitem(ll_row,'product_id',lds_products.getitemnumber(i,'product_id'))
		lds_ctx_products.setitem(ll_row,'product_type',lds_products.getitemnumber(i,'product_type'))
		lds_ctx_products.setitem(ll_row,'record_id',ll_record_id)		
		lds_ctx_products.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_products.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_products.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_products.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True		
	Next
End If
/* //Commented By Ken.Guo 2009-08-26
//Requirements
If astr_copy_ctx.sb_requirements = 1 Then
	
	lds_requirements.retrieve(astr_copy_ctx.sl_ctx_id)
	If lds_requirements.rowcount() > 0 Then		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		
		ll_row = lds_ctx_req_profile_hdr.insertrow(0)
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_req_profile_hdr_id',ll_ctx_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_req_profile_id',lds_requirements.getitemnumber(1,'ctx_req_profile_id')) // jervis 03.18.2009 hdr_ctx_req_profile_id to ctx_req_profile_id
		lds_ctx_req_profile_hdr.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_req_profile_hdr.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_req_profile_hdr.setitem(ll_row,'updated_at_date_time',today())
		
		gnv_appeondb.of_startqueue( )
		lds_profile_detail.retrieve(astr_copy_ctx.sl_ctx_id)
		select max(ctx_elements_id) into :ll_element_id from ctx_elements;
		gnv_appeondb.of_commitqueue( )
 
		If isnull(ll_element_id) Or ll_element_id = 0 Then
			ll_element_id = 1
		Else
			ll_element_id = ll_element_id + 1
		End If

		For i = 1 To lds_profile_detail.rowcount()			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')			
			ll_row = lds_ctx_elements.insertrow(0)
			lds_ctx_elements.setitem(ll_row,'ctx_elements_id',ll_element_id)
			lds_ctx_elements.setitem(ll_row,'ctx_req_profile_hdr_id',ll_ctx_id)
			lds_ctx_elements.setitem(ll_row,'ctx_req_tmplt_element_id',lds_profile_detail.getitemnumber(i,'ctx_req_tmplt_element_id'))
			lds_ctx_elements.setitem(ll_row,'char_value',lds_profile_detail.getitemstring(i,'char_value'))
			lds_ctx_elements.setitem(ll_row,'integer_value',lds_profile_detail.getitemnumber(i,'integer_value'))
			lds_ctx_elements.setitem(ll_row,'date_value',lds_profile_detail.getitemdatetime(i,'date_value'))
			lds_ctx_elements.setitem(ll_row,'field_value',lds_profile_detail.getitemstring(i,'field_value'))
			lds_ctx_elements.setitem(ll_row,'money_value',lds_profile_detail.getitemdecimal(i,'money_value'))
			lds_ctx_elements.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_elements.setitem(ll_row,'clause',lds_profile_detail.getitemstring(i,'clause'))			
			lds_ctx_elements.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_ctx_elements.setitem(ll_row,'inserted_at_date_time',today())
			lds_ctx_elements.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_ctx_elements.setitem(ll_row,'updated_at_date_time',today())
			ll_element_id++
		Next		
		lb_copy = True				
	End If
End If
*/

If astr_copy_ctx.sb_other_contacts = 1 Then
	//Other Contacts
	lds_other_contacts.retrieve(astr_copy_ctx.sl_ctx_id)
	For i = 1 To lds_other_contacts.rowcount()		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_contract_contacts.insertrow(0)
		lds_ctx_contract_contacts.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_contract_contacts.setitem(ll_row,'contact_id',lds_other_contacts.getitemnumber(i,'contact_id'))
		lds_ctx_contract_contacts.setitem(ll_row,'ic_area',lds_other_contacts.getitemstring(i,'ic_area'))
		lds_ctx_contract_contacts.setitem(ll_row,'association',lds_other_contacts.getitemstring(i,'association'))
		lds_ctx_contract_contacts.setitem(ll_row,'default_email','N')		
		lds_ctx_contract_contacts.setitem(ll_row,'notes',lds_other_contacts.getitemstring(i,'notes'))
		lds_ctx_contract_contacts.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_contract_contacts.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_contract_contacts.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True		
	Next
End If
If astr_copy_ctx.sb_locations  = 1 Then
	//Locations
	gnv_appeondb.of_startqueue( )
	lds_parent_organization.retrieve(astr_copy_ctx.sl_ctx_id)
	lds_group_locations.retrieve(astr_copy_ctx.sl_ctx_id)
	lds_selected_facility.retrieve(astr_copy_ctx.sl_ctx_id)
	lds_specialties.retrieve(astr_copy_ctx.sl_ctx_id)
	gnv_appeondb.of_commitqueue( )
	
	For i = 1 To lds_parent_organization.rowcount()
		ll_parent_comp_id = lds_parent_organization.getitemnumber(i,'parent_comp_id')
		ll_loc_id = lds_parent_organization.getitemnumber(i,'ctx_loc_loc_id')
		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_loc.insertrow(0)
		lds_ctx_loc.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_loc.setitem(ll_row,'parent_comp_id',ll_parent_comp_id)
		lds_ctx_loc.setitem(ll_row,'loc_id',ll_loc_id)
		lds_ctx_loc.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_loc.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_loc.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_loc.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_loc.setitem(ll_row,'updated_at_date_time',today())
		
		lds_group_locations.setfilter("parent_comp_id = " + string(ll_parent_comp_id))
		lds_group_locations.filter()
		For j = 1 To lds_group_locations.rowcount()
			ll_loc_id = lds_group_locations.getitemnumber(j,'loc_id')
			ll_parent_comp_id = lds_parent_organization.getitemnumber(i,'parent_comp_id')

			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_loc.insertrow(0)
			lds_ctx_loc.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_loc.setitem(ll_row,'parent_comp_id',ll_parent_comp_id)
			lds_ctx_loc.setitem(ll_row,'loc_id',ll_loc_id)			
			lds_ctx_loc.setitem(ll_row,'group_number',lds_group_locations.getitemstring(j,'group_number'))
			lds_ctx_loc.setitem(ll_row,'local',lds_group_locations.getitemnumber(j,'local'))
			lds_ctx_loc.setitem(ll_row,'custom_1',lds_group_locations.getitemstring(j,'custom_1'))
			lds_ctx_loc.setitem(ll_row,'custom_2',lds_group_locations.getitemstring(j,'custom_2'))			
			lds_ctx_loc.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_loc.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_ctx_loc.setitem(ll_row,'inserted_at_date_time',today())
			lds_ctx_loc.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_ctx_loc.setitem(ll_row,'updated_at_date_time',today())
			
			lds_selected_facility.setfilter("loc_id = " + string(ll_loc_id) + " and parent_comp_id = " + string(ll_parent_comp_id))
			lds_selected_facility.filter()
			For k = 1 To lds_selected_facility.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_location_pracs.insertrow(0)
				lds_ctx_location_pracs.setitem(ll_row,'ctx_id',ll_ctx_id)
				lds_ctx_location_pracs.setitem(ll_row,'record_id',ll_record_id)			
				lds_ctx_location_pracs.setitem(ll_row,'loc_id',lds_selected_facility.getitemnumber(k,'loc_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'parent_comp_id', lds_selected_facility.getitemnumber(k,'parent_comp_id'))
				lds_ctx_location_pracs.setitem(ll_row,'gp_rec_id',lds_selected_facility.getitemnumber(k,'pracs_gp_rec_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'prac_id',lds_selected_facility.getitemnumber(k,'prac_id'))			
				lds_ctx_location_pracs.setitem(ll_row,'status',lds_selected_facility.getitemnumber(k,'ctx_location_pracs_status'))			
				lds_ctx_location_pracs.setitem(ll_row,'start_date',lds_selected_facility.getitemdatetime(k,'start_date'))			
				lds_ctx_location_pracs.setitem(ll_row,'end_date',lds_selected_facility.getitemdatetime(k,'end_date'))			
			Next
				
			lds_specialties.setfilter("loc_id = " + string(ll_loc_id))
			lds_specialties.filter()
			For k = 1 To lds_specialties.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_location_specialty.insertrow(0)
				lds_ctx_location_specialty.setitem(ll_row,'ctx_id',ll_ctx_id)
				lds_ctx_location_specialty.setitem(ll_row,'record_id',ll_record_id)							
				lds_ctx_location_specialty.setitem(ll_row,'parent_comp_id',lds_specialties.getitemnumber(k,'parent_comp_id'))
				lds_ctx_location_specialty.setitem(ll_row,'loc_id',lds_specialties.getitemnumber(k,'loc_id'))			
				lds_ctx_location_specialty.setitem(ll_row,'prac_specialty',lds_specialties.getitemnumber(k,'prac_specialty'))			
			Next
		Next
		lb_copy = True				
	Next
End If
If astr_copy_ctx.sb_organizations = 1 Then
	//Organizations
	lds_organization_list.retrieve(astr_copy_ctx.sl_ctx_id)
	
	For i = 1 To lds_organization_list.rowcount()		
		ll_org_id = lds_organization_list.getitemnumber(i,'ctx_orgs_contact_org_id')
		
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_orgs_contact.insertrow(0)
		lds_ctx_orgs_contact.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_orgs_contact.setitem(ll_row,'org_id',ll_org_id)
		lds_ctx_orgs_contact.setitem(ll_row,'area',lds_organization_list.getitemstring(i,'ctx_orgs_contact_area'))
		lds_ctx_orgs_contact.setitem(ll_row,'notes',lds_organization_list.getitemstring(i,'notes'))
		lds_ctx_orgs_contact.setitem(ll_row,'record_id',ll_record_id)
		lds_ctx_orgs_contact.setitem(ll_row,'inserted_by_user',gs_user_id)
		lds_ctx_orgs_contact.setitem(ll_row,'inserted_at_date_time',today())
		lds_ctx_orgs_contact.setitem(ll_row,'updated_by_user',gs_user_id)
		lds_ctx_orgs_contact.setitem(ll_row,'updated_at_date_time',today())		
		lb_copy = True			
	Next
End If
w_appeon_gifofwait.of_setposition(40)
If astr_copy_ctx.sb_fee_schedule = 1 Then
	//Fee Schedule
//	If w_contract.tab_contract_details.tabpage_fee_schedules.visible = True Then
		
		gnv_appeondb.of_startqueue( )
		lds_fee_schedules.retrieve(astr_copy_ctx.sl_ctx_id)
		lds_providers.retrieve()
		lds_fee_schedule_locations.retrieve()
		lds_fees.retrieve()		
		select max(fee_sched_id) + 1 into :ll_fee_sched_id from ctx_fee_sched_hdr;		
		select max(fee_sched_location_id)  + 1 into :ll_fee_sched_location_id from ctx_fee_sched_locations;				
		select max(fee_sched_data_id) + 1 into :ll_fee_sched_data_id from CTX_FEE_SCHED_DATA;		
		gnv_appeondb.of_commitqueue( )
		
		If isnull(ll_fee_sched_id) Then  ll_fee_sched_id = 1
		If isnull(ll_fee_sched_location_id) Then ll_fee_sched_location_id = 1
		If isnull(ll_fee_sched_data_id) Then ll_fee_sched_data_id = 1				
		
		For i = 1 To lds_fee_schedules.rowcount()
			ll_fee_sched_id1 = lds_fee_schedules.getitemnumber(i,'fee_sched_id')
			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_fee_sched_hdr.insertrow(0)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_fee_sched_hdr.setitem(ll_row,'sched_type',lds_fee_schedules.getitemnumber(i,'sched_type'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'carve_out_type',lds_fee_schedules.getitemnumber(i,'carve_out_type'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'custom_1',lds_fee_schedules.getitemstring(i,'custom_1'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'custom_2',lds_fee_schedules.getitemstring(i,'custom_2'))
			lds_ctx_fee_sched_hdr.setitem(ll_row,'notes',lds_fee_schedules.getitemstring(i,'notes'))
			
			lds_providers.setfilter("fee_sched_id = " + string(ll_fee_sched_id1))
			lds_providers.filter()
			For j = 1 To lds_providers.rowcount()				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_fee_sched_pracs.insertrow(0)
				lds_ctx_fee_sched_pracs.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
				lds_ctx_fee_sched_pracs.setitem(ll_row,'record_id',ll_record_id)								
				lds_ctx_fee_sched_pracs.setitem(ll_row,'practitioner_id',lds_providers.getitemnumber(j,'practitioner_id'))
			Next
			
			lds_fee_schedule_locations.setfilter("fee_sched_id = " + string(ll_fee_sched_id1))
			lds_fee_schedule_locations.filter()
			For j = 1 To lds_fee_schedule_locations.rowcount()
				ll_fee_sched_location_id1 = lds_fee_schedule_locations.getitemnumber(j,'fee_sched_location_id')
				
				ll_record_id = gnv_app.of_get_id('RECORD_ID')
				ll_row = lds_ctx_fee_sched_locations.insertrow(0)
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_sched_location_id',ll_fee_sched_location_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_sched_id',ll_fee_sched_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'record_id',ll_record_id)
				lds_ctx_fee_sched_locations.setitem(ll_row,'location',lds_fee_schedule_locations.getitemnumber(j,'location'))
				lds_ctx_fee_sched_locations.setitem(ll_row,'rate',lds_fee_schedule_locations.getitemdecimal(j,'rate'))
				lds_ctx_fee_sched_locations.setitem(ll_row,'fee_bonus',lds_fee_schedule_locations.getitemnumber(j,'fee_bonus'))
				
				lds_fees.setfilter("fee_sched_location_id = " + string(ll_fee_sched_location_id1))
				lds_fees.filter()
				For k = 1 To lds_fees.rowcount()														
					ll_record_id = gnv_app.of_get_id('RECORD_ID')
					ll_row = lds_ctx_fee_sched_data.insertrow(0)
					lds_ctx_fee_sched_data.setitem(ll_row,'fee_sched_data_id',ll_fee_sched_data_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'fee_sched_location_id',ll_fee_sched_location_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'record_id',ll_record_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'cpt_code',lds_fees.getitemstring(k,'cpt_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'fee',lds_fees.getitemdecimal(k,'fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'office_fee',lds_fees.getitemdecimal(k,'office_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'facility_fee',lds_fees.getitemdecimal(k,'facility_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_fee',lds_fees.getitemdecimal(k,'custom_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'precert',lds_fees.getitemnumber(k,'precert'))
					lds_ctx_fee_sched_data.setitem(ll_row,'preauth',lds_fees.getitemnumber(k,'preauth'))
					lds_ctx_fee_sched_data.setitem(ll_row,'effective_date',lds_fees.getitemdatetime(k,'effective_date'))
					lds_ctx_fee_sched_data.setitem(ll_row,'expiration_date',lds_fees.getitemdatetime(k,'expiration_date'))
					lds_ctx_fee_sched_data.setitem(ll_row,'status',lds_fees.getitemnumber(k,'status'))
					lds_ctx_fee_sched_data.setitem(ll_row,'drg_code',lds_fees.getitemstring(k,'drg_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'rev_code',lds_fees.getitemstring(k,'rev_code'))
					lds_ctx_fee_sched_data.setitem(ll_row,'claim_type',lds_fees.getitemnumber(k,'claim_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'flat_fee',lds_fees.getitemnumber(k,'flat_fee'))
					lds_ctx_fee_sched_data.setitem(ll_row,'cpt_code_set',lds_fees.getitemnumber(k,'cpt_code_set'))
					lds_ctx_fee_sched_data.setitem(ll_row,'reimburse_type',lds_fees.getitemnumber(k,'reimburse_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'disc_start_perc',lds_fees.getitemnumber(k,'disc_start_perc'))
					lds_ctx_fee_sched_data.setitem(ll_row,'end_day',lds_fees.getitemnumber(k,'end_day'))
					lds_ctx_fee_sched_data.setitem(ll_row,'carve_out_day',lds_fees.getitemnumber(k,'carve_out_day'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_threshold',lds_fees.getitemdecimal(k,'sl_threshold'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_reimburse_type',lds_fees.getitemnumber(k,'sl_reimburse_type'))
					lds_ctx_fee_sched_data.setitem(ll_row,'sl_rate',lds_fees.getitemdecimal(k,'sl_rate'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_1',lds_fees.getitemstring(k,'custom_1'))
					lds_ctx_fee_sched_data.setitem(ll_row,'custom_2',lds_fees.getitemstring(k,'custom_2'))
					lds_ctx_fee_sched_data.setitem(ll_row,'inserted_by_user',gs_user_id)
					lds_ctx_fee_sched_data.setitem(ll_row,'inserted_at_date_time',today())					
					ll_fee_sched_data_id++
				Next									
				ll_fee_sched_location_id++
			Next			
			ll_fee_sched_id++
			lb_copy = True
		Next
//	End If
//	If w_contract.tab_contract_details.tabpage_fee_sched2.visible = True Then
		lds_fee_schedules2.retrieve(astr_copy_ctx.sl_ctx_id)
		For i = 1 To lds_fee_schedules2.rowcount()			
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ll_row = lds_ctx_fee_sched_nm.insertrow(0)
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'ctx_id',ll_ctx_id)
			lds_ctx_fee_sched_nm.setitem(ll_row,'record_id',ll_record_id)
			lds_ctx_fee_sched_nm.setitem(ll_row,'fee_sched_nm_id',lds_fee_schedules2.getitemnumber(i,'fee_sched_nm_id'))
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'billing_cycle',lds_fee_schedules2.getitemnumber(i,'billing_cycle'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'category',lds_fee_schedules2.getitemnumber(i,'category'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'service_item',lds_fee_schedules2.getitemnumber(i,'service_item'))			
			lds_ctx_fee_sched_nm.setitem(ll_row,'description',lds_fee_schedules2.getitemstring(i,'description'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'fee',lds_fee_schedules2.getitemdecimal(i,'fee'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'item_status',lds_fee_schedules2.getitemnumber(i,'item_status'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'start_date',lds_fee_schedules2.getitemdatetime(i,'start_date'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'end_date',lds_fee_schedules2.getitemdatetime(i,'end_date'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_fee1',lds_fee_schedules2.getitemdecimal(i,'custom_fee1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_fee2',lds_fee_schedules2.getitemdecimal(i,'custom_fee2'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_fee3',lds_fee_schedules2.getitemdecimal(i,'custom_fee3'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_int1',lds_fee_schedules2.getitemnumber(i,'custom_int1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text1',lds_fee_schedules2.getitemstring(i,'custom_text1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text2',lds_fee_schedules2.getitemstring(i,'custom_text2'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text3',lds_fee_schedules2.getitemstring(i,'custom_text3'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text4',lds_fee_schedules2.getitemstring(i,'custom_text4'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text5',lds_fee_schedules2.getitemstring(i,'custom_text5'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_text6',lds_fee_schedules2.getitemstring(i,'custom_text6'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n1',lds_fee_schedules2.getitemdecimal(i,'custom_n1'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n2',lds_fee_schedules2.getitemdecimal(i,'custom_n2'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n3',lds_fee_schedules2.getitemdecimal(i,'custom_n3'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n4',lds_fee_schedules2.getitemdecimal(i,'custom_n4'))
			lds_ctx_fee_sched_nm.setitem(ll_row,'custom_n5',lds_fee_schedules2.getitemdecimal(i,'custom_n5'))
			
			lds_ctx_fee_sched_nm.setitem(ll_row,'notes',lds_fee_schedules2.getitemstring(i,'notes'))					
			lb_copy = True
		Next			
//	End If
End If
w_appeon_gifofwait.of_setposition(50)
If astr_copy_ctx.sb_action_items = 1 Then
	//Action Items
	lds_action_items.retrieve(astr_copy_ctx.sl_ctx_id)
	For i = 1 To lds_action_items.rowcount()
		ll_record_id = gnv_app.of_get_id('RECORD_ID')
		ll_row = lds_ctx_action_item.insertrow(0)		
		lds_ctx_action_item.setitem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_action_item.setitem(ll_row,'record_id',ll_record_id)
		ll_ori_id[i] = lds_action_items.getitemnumber(i,'ctx_action_item_id')
		//lds_ctx_action_item.setitem(ll_row,'ctx_action_item_id',lds_action_items.getitemnumber(i,'ctx_action_item_id'))
		lds_ctx_action_item.setitem(ll_row,'action_type',lds_action_items.getitemnumber(i,'action_type'))
		lds_ctx_action_item.setitem(ll_row,'due_date',lds_action_items.getitemdatetime(i,'due_date'))
		lds_ctx_action_item.setitem(ll_row,'action_user',lds_action_items.getitemstring(i,'action_user'))
		lds_ctx_action_item.setitem(ll_row,'action_date',lds_action_items.getitemdatetime(i,'action_date'))
		lds_ctx_action_item.setitem(ll_row,'action_status',lds_action_items.getitemnumber(i,'action_status'))
		lds_ctx_action_item.setitem(ll_row,'wf_assigned_by',lds_action_items.getitemstring(i,'wf_assigned_by'))
		lds_ctx_action_item.setitem(ll_row,'inserted_at_date_time',lds_action_items.getitemdatetime(i,'inserted_at_date_time'))
		lds_ctx_action_item.setitem(ll_row,'no_attempts',lds_action_items.getitemnumber(i,'no_attempts'))
		lds_ctx_action_item.setitem(ll_row,'first_attempt',lds_action_items.getitemdatetime(i,'first_attempt'))
		lds_ctx_action_item.setitem(ll_row,'last_attempt',lds_action_items.getitemdatetime(i,'last_attempt'))
		lds_ctx_action_item.setitem(ll_row,'notes',lds_action_items.getitemstring(i,'notes'))
		lds_ctx_action_item.setitem(ll_row,'wf_step',lds_action_items.getitemnumber(i,'wf_step'))
		lds_ctx_action_item.setitem(ll_row,'wf_id',lds_action_items.getitemnumber(i,'wf_id'))
		lds_ctx_action_item.setitem(ll_row,'letter_flag',lds_action_items.getitemstring(i,'letter_flag'))
		lds_ctx_action_item.setitem(ll_row,'letter_to',lds_action_items.getitemnumber(i,'letter_to'))
		lds_ctx_action_item.setitem(ll_row,'letter_from',lds_action_items.getitemnumber(i,'letter_from'))
		lds_ctx_action_item.setitem(ll_row,'letter_id',lds_action_items.getitemnumber(i,'letter_id'))
		lds_ctx_action_item.setitem(ll_row,'wf_action_type_id',lds_action_items.getitemnumber(i,'wf_action_type_id'))
		lds_ctx_action_item.setitem(ll_row,'wf_complete_flag',lds_action_items.getitemstring(i,'wf_complete_flag'))
		lds_ctx_action_item.setitem(ll_row,'print_flag',lds_action_items.getitemnumber(i,'print_flag'))
		lds_ctx_action_item.setitem(ll_row,'assigned_to',lds_action_items.getitemnumber(i,'assigned_to'))
		
		//Added By Ken.Guo 2009-07-23.
		lds_ctx_action_item.setitem(ll_row,'custom_n1',lds_action_items.getitemdecimal(i,'custom_n1'))
		lds_ctx_action_item.setitem(ll_row,'custom_n2',lds_action_items.getitemdecimal(i,'custom_n2'))
		lds_ctx_action_item.setitem(ll_row,'custom_n3',lds_action_items.getitemdecimal(i,'custom_n3'))
		lds_ctx_action_item.setitem(ll_row,'custom_n4',lds_action_items.getitemdecimal(i,'custom_n4'))
		lds_ctx_action_item.setitem(ll_row,'custom_n5',lds_action_items.getitemdecimal(i,'custom_n5'))
		lds_ctx_action_item.setitem(ll_row,'custom_1',lds_action_items.getitemstring(i,'custom_1'))
		lds_ctx_action_item.setitem(ll_row,'custom_2',lds_action_items.getitemstring(i,'custom_2'))
		lds_ctx_action_item.setitem(ll_row,'custom_3',lds_action_items.getitemstring(i,'custom_3'))
		lds_ctx_action_item.setitem(ll_row,'custom_4',lds_action_items.getitemstring(i,'custom_4'))
		
		lb_copy = True				
	Next	
End If

w_appeon_gifofwait.of_setposition(60)
//Added By Ken.Guo 2009-05-20.
If astr_copy_ctx.sb_group_access = 1 Then
	ll_cnt = lds_ctx_group_access.Retrieve(astr_copy_ctx.sl_ctx_id)
	For i = 1 To ll_cnt
		ll_row = lds_ctx_group_access.InsertRow(0)
		lds_ctx_group_access.SetItem(ll_row,'ctx_id',ll_ctx_id)
		lds_ctx_group_access.SetItem(ll_row,'group_id',lds_ctx_group_access.GetItemNumber(i,'group_id'))
		lds_ctx_group_access.SetItem(ll_row,'access',lds_ctx_group_access.GetItemString(i,'access'))
		lds_ctx_group_access.SetItem(ll_row,'view_id',lds_ctx_group_access.GetItemNumber(i,'view_id'))
		lb_copy = True
	Next
End If

//Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
if astr_copy_ctx.sb_link_privider = 1 then
	ll_cnt = lds_ctx_linked_provider.retrieve( astr_copy_ctx.sl_ctx_id )
	For i = 1 to ll_cnt
		ll_row = lds_ctx_linked_provider.insertrow( 0)
		lds_ctx_linked_provider.setitem( ll_row,'Ctx_id',ll_ctx_id)
		lds_ctx_linked_provider.setitem( ll_row,'Prac_id',lds_ctx_linked_provider.getItemNumber(i,'prac_id'))
		lds_ctx_linked_provider.setitem( ll_row,'From_date',lds_ctx_linked_provider.getitemdatetime( i,'From_date'))
		lds_ctx_linked_provider.setitem( ll_row,'To_date',lds_ctx_linked_provider.getitemdatetime( i,'To_date'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_d1',lds_ctx_linked_provider.getitemdatetime( i,'Custom_d1'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_d2',lds_ctx_linked_provider.getitemdatetime( i,'Custom_d2'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_1',lds_ctx_linked_provider.getitemstring( i,'Custom_1'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_2',lds_ctx_linked_provider.getitemstring( i,'Custom_2'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_3',lds_ctx_linked_provider.getitemstring( i,'Custom_3'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_4',lds_ctx_linked_provider.getitemstring( i,'Custom_4'))
		lds_ctx_linked_provider.setitem( ll_row,'Custom_5',lds_ctx_linked_provider.getitemstring( i,'Custom_5'))
		lb_copy = True
	end for
end if

//Added By Ken.Guo 09/16/2013. Set flag.
If astr_copy_ctx.sb_custom_data2 = 1 or astr_copy_ctx.sb_custom_multi =  1 Then
	lb_copy = True
End If

If lb_copy = False Then 
	Destroy lds_detail
	Destroy lds_ctx_basic_info
	Destroy lds_company_contacts
	Destroy lds_ctx_contract_contacts
	Destroy lds_products
	Destroy lds_ctx_products
//	Destroy lds_requirements
//	Destroy lds_ctx_req_profile_hdr
//	Destroy lds_profile_detail
//	Destroy lds_ctx_elements
	Destroy lds_other_contacts
	Destroy lds_parent_organization
	Destroy lds_ctx_loc
	Destroy lds_group_locations
	Destroy lds_selected_facility
	Destroy lds_ctx_location_pracs
	Destroy lds_specialties
	Destroy lds_ctx_location_specialty
	Destroy lds_organization_list
	Destroy lds_ctx_orgs_contact
	Destroy lds_ctx_org_contact
	Destroy lds_fee_schedules
	Destroy lds_ctx_fee_sched_hdr
	Destroy lds_providers
	Destroy lds_ctx_fee_sched_pracs
	Destroy lds_fee_schedule_locations
	Destroy lds_ctx_fee_sched_locations
	Destroy lds_fees
	Destroy lds_ctx_fee_sched_data
	Destroy lds_fee_schedules2
	Destroy lds_ctx_fee_sched_nm
	Destroy lds_action_items
	Destroy lds_ctx_action_item
	Destroy lds_ctx_group_access
	Destroy lds_ctx_linked_provider//Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
	If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)
	
	//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
	Choose Case astr_copy_ctx.as_copy_sub_ctx
		Case 'Create Credit Sub Contract', 'Create Contract Sub Contract'
			gnv_debug.of_output( true, 'Failed to create Sub Contract. Please select the screens on the default copy contract window first. ')
		Case Else
			messagebox('Copy Contract Failed','The selected items have no data at all.')
	End Choose
	
	Return -1
End If

w_appeon_gifofwait.of_setposition(70)
gnv_appeondb.of_startqueue( )
lds_ctx_basic_info.update()
lds_ctx_contract_contacts.update()
lds_ctx_products.update()
//lds_ctx_req_profile_hdr.update()
//lds_ctx_elements.update()
lds_ctx_contract_contacts.update()
lds_ctx_loc.update()
w_appeon_gifofwait.of_setposition(75)
lds_ctx_location_pracs.update()
lds_ctx_location_specialty.update()
lds_ctx_orgs_contact.update()
lds_ctx_org_contact.update()
lds_ctx_fee_sched_hdr.update()
lds_ctx_fee_sched_pracs.update()
lds_ctx_fee_sched_locations.update()
lds_ctx_fee_sched_data.update()
lds_ctx_fee_sched_nm.update()
lds_ctx_action_item.update()
lds_ctx_group_access.update()
lds_ctx_linked_provider.update( ) //Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
gnv_appeondb.of_commitqueue( )

w_appeon_gifofwait.of_setposition(80)

//Add custom data 2 and multi copy - jervis 06.10.2011
of_copy_custom_data(astr_copy_ctx ,ll_ctx_id)

//Added By Mark Lee 11/20/2012
of_copy_company_contact_data(astr_copy_ctx ,ll_ctx_id)

 //Document Manager
If astr_copy_ctx.sb_document_manager = 1 Then
	of_Copy_Document_Manager(astr_copy_ctx.sl_ctx_id ,ll_ctx_id)
End If

//New action item id - jervis 12.31.2010
for i = 1 to lds_ctx_action_item.rowcount()
	ll_new_id[i] = lds_ctx_action_item.GetItemNumber(i,"ctx_action_item_id")
next
//Copy Alarms - jervis 08.19.2010
of_copy_alarms(astr_copy_ctx,ll_ctx_id,ll_ori_id,ll_new_id)


//Requirements Profile. //Added By Ken.Guo 2009-08-26.
If astr_copy_ctx.sb_requirements = 1 Then
	of_update_requirement_profile(astr_copy_ctx.sl_ctx_id,ll_ctx_id)
End If

If astr_copy_ctx.si_is_template = 0 Then
	//Insert current user to our company contact.
	If astr_copy_ctx.si_add_contact = 1 Then
		//Added By Mark Lee 05/09/12	
//		of_insert_contact(ll_ctx_id)
		of_insert_contact(ll_ctx_id,astr_copy_ctx.ai_ib_default_email,astr_copy_ctx.ai_ib_owner)
	End If
	
	//trigger workflow
	If astr_copy_ctx.sl_workflow > 0 and gb_workflow Then	//Add Gb_workflow - jervis 04.20.2010
		lnv_workflow = Create n_cst_workflow_triggers
		lstr_action.ctx_id = ll_ctx_id
		lstr_action.wf_id = astr_copy_ctx.sl_workflow
		lnv_workflow.of_workflow_create_action_items(lstr_action)
	End If
End If


w_appeon_gifofwait.of_setposition(90)

//Added By Ken.Guo 2009-08-24.
If astr_copy_ctx.si_is_template = 1 Then
	of_update_ctx_flag(ll_ctx_id,1)
	of_update_template_data(astr_copy_ctx,ll_ctx_id)
Else
	of_update_ctx_flag(ll_ctx_id,0)
End If
w_appeon_gifofwait.of_setposition(100)

Destroy lds_detail
Destroy lds_ctx_basic_info
Destroy lds_company_contacts
Destroy lds_ctx_contract_contacts
Destroy lds_products
Destroy lds_ctx_products
//Destroy lds_requirements
//Destroy lds_ctx_req_profile_hdr
//Destroy lds_profile_detail
//Destroy lds_ctx_elements
Destroy lds_other_contacts
Destroy lds_parent_organization
Destroy lds_ctx_loc
Destroy lds_group_locations
Destroy lds_selected_facility
Destroy lds_ctx_location_pracs
Destroy lds_specialties
Destroy lds_ctx_location_specialty
Destroy lds_organization_list
Destroy lds_ctx_orgs_contact
Destroy lds_ctx_org_contact
Destroy lds_fee_schedules
Destroy lds_ctx_fee_sched_hdr
Destroy lds_providers
Destroy lds_ctx_fee_sched_pracs
Destroy lds_fee_schedule_locations
Destroy lds_ctx_fee_sched_locations
Destroy lds_fees
Destroy lds_ctx_fee_sched_data
Destroy lds_fee_schedules2
Destroy lds_ctx_fee_sched_nm
Destroy lds_action_items
Destroy lds_ctx_action_item
Destroy lds_ctx_group_access
destroy lnv_workflow
Destroy lds_ctx_linked_provider//Added by Appeon long.zhang 04.15.2014 (v14.2 Provider-Contract direct linking)
If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)


Return ll_ctx_id

end function

public function integer of_update_template_data (str_copy_ctx astr_copy_ctx, long al_template_id);long ll_cnt ,i
datastore lds_ctx_template
lds_ctx_template = Create datastore

lds_ctx_template.dataobject = 'd_ctx_templates'
lds_ctx_template.settransobject(SQLCA)
lds_ctx_template.retrieve(al_template_id)

ll_cnt = lds_ctx_template.rowcount()

//Delete history data if exists.
For i = 1 to ll_cnt
	lds_ctx_template.deleterow(i)
Next

lds_ctx_template.InsertRow(0)

lds_ctx_template.SetItem(1,'template_name',astr_copy_ctx.ss_template_name)
lds_ctx_template.SetItem(1,'create_date',today())
lds_ctx_template.SetItem(1,'create_by',gs_user_id)
lds_ctx_template.SetItem(1,'ctx_id',al_template_id)
lds_ctx_template.SetItem(1,'original_ctx_id',astr_copy_ctx.sl_ctx_id)
lds_ctx_template.SetItem(1,'ib_contract_detail',astr_copy_ctx.sb_contract_detail)
lds_ctx_template.SetItem(1,'ib_contract_dates',astr_copy_ctx.sb_contract_dates)
lds_ctx_template.SetItem(1,'ib_custom_data',astr_copy_ctx.sb_custom_data)
lds_ctx_template.SetItem(1,'ib_notes',astr_copy_ctx.sb_notes)
lds_ctx_template.SetItem(1,'ib_contract_contacts',astr_copy_ctx.sb_contracted_contacts)
lds_ctx_template.SetItem(1,'ib_group_access',astr_copy_ctx.sb_group_access)
lds_ctx_template.SetItem(1,'ib_products',astr_copy_ctx.sb_products)
lds_ctx_template.SetItem(1,'ib_our_contacts',astr_copy_ctx.sb_our_contacts)
lds_ctx_template.SetItem(1,'ib_requirements',astr_copy_ctx.sb_requirements)
lds_ctx_template.SetItem(1,'ib_other_contacts',astr_copy_ctx.sb_other_contacts)
lds_ctx_template.SetItem(1,'ib_locations',astr_copy_ctx.sb_locations)
lds_ctx_template.SetItem(1,'ib_organizations',astr_copy_ctx.sb_organizations)
lds_ctx_template.SetItem(1,'ib_fee_schedule',astr_copy_ctx.sb_fee_schedule)
lds_ctx_template.SetItem(1,'ib_document_manager',astr_copy_ctx.sb_document_manager)
lds_ctx_template.SetItem(1,'ib_action_items',astr_copy_ctx.sb_action_items)
lds_ctx_template.SetItem(1,'notes',astr_copy_ctx.ss_template_comment)
lds_ctx_template.SetItem(1,'located_tab_index',astr_copy_ctx.si_located_tab )
lds_ctx_template.SetItem(1,'clear_company',astr_copy_ctx.si_clear_company )
lds_ctx_template.SetItem(1,'add_contact',astr_copy_ctx.si_add_contact )
lds_ctx_template.SetItem(1,'trigger_workflow', astr_copy_ctx.sl_workflow )

//Added By Mark Lee 05/09/12
lds_ctx_template.SetItem(1,'ib_default_email',astr_copy_ctx.ai_ib_default_email )
lds_ctx_template.SetItem(1,'ib_owner', astr_copy_ctx.ai_ib_owner )
//Added By Mark Lee 05/11/12
lds_ctx_template.SetItem(1,'ib_custom_data2',astr_copy_ctx.sb_custom_data2 )
lds_ctx_template.SetItem(1,'ib_custom_multi', astr_copy_ctx.sb_custom_multi )

//Added By Mark Lee 11/20/2012
lds_ctx_template.SetItem(1,'ib_create_child',astr_copy_ctx.ai_ib_create_child )
lds_ctx_template.SetItem(1,'ib_copy_m_company', astr_copy_ctx.ai_ib_copy_m_company )
lds_ctx_template.SetItem(1,'ib_copy_m_company_contact',astr_copy_ctx.ai_ib_copy_m_company_contact )

lds_ctx_template.SetItem(1,'ib_linked_provider',astr_copy_ctx.sb_link_privider  )//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)

gnv_appeondb.of_autocommitrollback( )
lds_ctx_template.update()


Return 1
end function

public function long of_copy_ctx_from_template (long al_template_id);Long ll_new_ctx_id
str_copy_ctx lstr_copy_ctx
n_cst_copy_ctx lnv_copy_ctx 
lnv_copy_ctx = Create n_cst_copy_ctx

//Added By Mark Lee 05/09/12	add column ib_create_child , ib_copy_m_company ,ib_copy_m_company_contact
//Added By Mark Lee 05/09/12	add column ib_owner and ib_default_email 
//Get template info
Select 
	ctx_id, 
	ib_contract_detail ,
	ib_contract_dates ,
	ib_custom_data,
	ib_notes ,
	ib_contract_contacts ,
	ib_group_access ,
	ib_products ,
	ib_our_contacts ,
	ib_requirements,
	ib_other_contacts ,
	ib_locations ,
	ib_organizations ,
	ib_fee_schedule ,
	ib_document_manager ,
	ib_action_items,
	located_tab_index,
	clear_company,
	add_contact,
	trigger_workflow,
	ib_default_email,
	ib_owner,
	ib_custom_data2,
	ib_custom_multi,
	ib_create_child,
	ib_copy_m_company,
	ib_copy_m_company_contact,
	ib_linked_provider//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
into 
	:lstr_copy_ctx.sl_ctx_id,
	:lstr_copy_ctx.sb_contract_detail,
	:lstr_copy_ctx.sb_contract_dates,
	:lstr_copy_ctx.sb_custom_data,
	:lstr_copy_ctx.sb_notes,
	:lstr_copy_ctx.sb_contracted_contacts,
	:lstr_copy_ctx.sb_group_access,
	:lstr_copy_ctx.sb_products,
	:lstr_copy_ctx.sb_our_contacts,
	:lstr_copy_ctx.sb_requirements,
	:lstr_copy_ctx.sb_other_contacts,
	:lstr_copy_ctx.sb_locations,
	:lstr_copy_ctx.sb_organizations,
	:lstr_copy_ctx.sb_fee_schedule,
	:lstr_copy_ctx.sb_document_manager,
	:lstr_copy_ctx.sb_action_items,
	:lstr_copy_ctx.si_located_tab,
	:lstr_copy_ctx.si_clear_company,
	:lstr_copy_ctx.si_add_contact,
	:lstr_copy_ctx.sl_workflow,
	:lstr_copy_ctx.ai_ib_default_email,
	:lstr_copy_ctx.ai_ib_owner,
	:lstr_copy_ctx.sb_custom_data2,
	:lstr_copy_ctx.sb_custom_multi,
	:lstr_copy_ctx.ai_ib_create_child,
	:lstr_copy_ctx.ai_ib_copy_m_company,
	:lstr_copy_ctx.ai_ib_copy_m_company_contact,
	:lstr_copy_ctx.sb_link_privider//Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
From ctx_templates_info
Where id = :al_template_id;

If sqlca.sqlcode <> 0 Then 
	Messagebox('Error','Failed to get the template information, please call support.')
	If isvalid(lnv_copy_ctx) Then Destroy(lnv_copy_ctx)
	Return -2
End If

//Create New CTX from Template.
ll_new_ctx_id = lnv_copy_ctx.of_copy_ctx_data(lstr_copy_ctx)

Return ll_new_ctx_id
end function

public function integer of_update_requirement_profile (long al_source_ctx_id, long al_target_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctx::of_update_requirement_profile()
// $<arguments>
//		value	long	al_source_ctx_id		
//		value	long	al_target_ctx_id		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_profile_cnt,ll_elements_cnt,i,j,ll_row,ll_record_id
long ll_profile_id,ll_element_id,ll_profile_id_org
DataStore lds_reqmnt_profile,lds_reqmnt_profile_copy, lds_reqmnt_elements,lds_reqmnt_elements_copy
lds_reqmnt_profile = Create DataStore
lds_reqmnt_profile_copy = Create datastore
lds_reqmnt_elements = Create DataStore
lds_reqmnt_elements_copy = Create DataStore
lds_reqmnt_profile.dataobject = 'd_profile_header'
lds_reqmnt_profile_copy.dataobject = 'd_ctx_req_profile_hdr_copy'
lds_reqmnt_elements.dataobject = 'd_contract_profile_req_existing'
lds_reqmnt_elements_copy.dataobject = 'd_ctx_elements_copy'
lds_reqmnt_profile.settransobject(sqlca)
lds_reqmnt_profile_copy.settransobject(sqlca)
lds_reqmnt_elements.settransobject(sqlca)
lds_reqmnt_elements_copy.settransobject(sqlca)


ll_profile_cnt = lds_reqmnt_profile.Retrieve(al_source_ctx_id)
If ll_profile_cnt = 0 Then Return 1

ll_record_id = gnv_app.of_get_id('RECORD_ID')
gnv_appeondb.of_startqueue( )
	Select Max(cTX_REQ_PROFILE_HDR_id) into :ll_profile_id From ctx_req_profile_hdr;
	select max(ctx_elements_id) into :ll_element_id from ctx_elements;
gnv_appeondb.of_commitqueue( )
If Isnull(ll_profile_id) Then ll_profile_id = 0
If Isnull(ll_element_id) Then ll_element_id = 0

For i = 1 To ll_profile_cnt
	ll_profile_id++
	ll_record_id++
	//Insert Profile data
	ll_row = lds_reqmnt_profile_copy.InsertRow(0)
	lds_reqmnt_profile_copy.SetItem(ll_row,'ctx_req_profile_hdr_id',ll_profile_id)
	lds_reqmnt_profile_copy.setitem(ll_row,'ctx_req_profile_id',lds_reqmnt_profile.getitemnumber(i,'ctx_req_profile_id')) // jervis 03.18.2009 hdr_ctx_req_profile_id to ctx_req_profile_id
	lds_reqmnt_profile_copy.setitem(ll_row,'ctx_id',al_target_ctx_id)
	lds_reqmnt_profile_copy.setitem(ll_row,'record_id',ll_record_id) 
	lds_reqmnt_profile_copy.setitem(ll_row,'inserted_by_user',gs_user_id)
	lds_reqmnt_profile_copy.setitem(ll_row,'inserted_at_date_time',today())
	lds_reqmnt_profile_copy.setitem(ll_row,'updated_by_user',gs_user_id)
	lds_reqmnt_profile_copy.setitem(ll_row,'updated_at_date_time',today())	
	
	ll_profile_id_org = lds_reqmnt_profile.getitemnumber(i,'ctx_req_profile_hdr_id')
	lds_reqmnt_elements.Retrieve(ll_profile_id_org)
	ll_elements_cnt = lds_reqmnt_elements.RowCount()
	For j = 1 To ll_elements_cnt
			ll_element_id++
			ll_record_id++	
			//Insert Requirement/Elements data
			ll_row = lds_reqmnt_elements_copy.insertrow(0)
			lds_reqmnt_elements_copy.setitem(ll_row,'ctx_elements_id',ll_element_id)
			lds_reqmnt_elements_copy.setitem(ll_row,'ctx_req_profile_hdr_id',ll_profile_id)
			lds_reqmnt_elements_copy.setitem(ll_row,'ctx_req_tmplt_element_id',lds_reqmnt_elements.getitemnumber(j,'ctx_req_tmplt_element_id'))
			lds_reqmnt_elements_copy.setitem(ll_row,'char_value',lds_reqmnt_elements.getitemstring(j,'char_value'))
			lds_reqmnt_elements_copy.setitem(ll_row,'integer_value',lds_reqmnt_elements.getitemnumber(j,'integer_value'))
			lds_reqmnt_elements_copy.setitem(ll_row,'date_value',lds_reqmnt_elements.getitemdatetime(j,'date_value'))
			lds_reqmnt_elements_copy.setitem(ll_row,'field_value',lds_reqmnt_elements.getitemstring(j,'field_value'))
			lds_reqmnt_elements_copy.setitem(ll_row,'money_value',lds_reqmnt_elements.getitemdecimal(j,'money_value'))
			lds_reqmnt_elements_copy.setitem(ll_row,'record_id',ll_record_id)
			lds_reqmnt_elements_copy.setitem(ll_row,'clause',lds_reqmnt_elements.getitemstring(j,'clause'))			
			lds_reqmnt_elements_copy.setitem(ll_row,'inserted_by_user',gs_user_id)
			lds_reqmnt_elements_copy.setitem(ll_row,'inserted_at_date_time',today())
			lds_reqmnt_elements_copy.setitem(ll_row,'updated_by_user',gs_user_id)
			lds_reqmnt_elements_copy.setitem(ll_row,'updated_at_date_time',today())
	Next
	
Next
If lds_reqmnt_profile_copy.update() <> 1 Then 
	Messagebox('Error','Failed to copy the requirement profile data.')
	Return 1
End IF
lds_reqmnt_elements_copy.update()
Commit;

//Update Image File
Update ctx_elements set 
	image_file = 
	(Select Image_file from ctx_elements se,ctx_req_profile_hdr sr 
	where se.ctx_req_profile_hdr_id = sr.ctx_req_profile_hdr_id
	and sr.ctx_id = :al_source_ctx_id
	and se.ctx_req_tmplt_element_id = te.ctx_req_tmplt_element_id 
	),
	modify_date = 
	( Select case when modify_date is null then null else getdate() end
	from ctx_elements se,ctx_req_profile_hdr sr 
	where se.ctx_req_profile_hdr_id = sr.ctx_req_profile_hdr_id
	and sr.ctx_id = :al_source_ctx_id
	and se.ctx_req_tmplt_element_id = te.ctx_req_tmplt_element_id 
	)
From ctx_elements te,ctx_req_profile_hdr
Where te.ctx_req_profile_hdr_id = ctx_req_profile_hdr.ctx_req_profile_hdr_id
and ctx_req_profile_hdr.ctx_id = :al_target_ctx_id ;

Return 1

	
end function

public subroutine of_locate_ctx (long al_ctx_id);of_locate_ctx(al_ctx_id,2)

////////////////////////////////////////////////////////////////////////
//// $<function>n_cst_copy_ctxof_locate_ctx()
//// $<arguments>
////		value	long	al_ctx_id		
//// $<returns> (none)
//// $<description>
//// $<description> Locate target ctx.
////////////////////////////////////////////////////////////////////////
//// $<add> 2009-08-27 by Ken.Guo
////////////////////////////////////////////////////////////////////////
//
////Locate new ctx.
//If al_ctx_id > 0 and isvalid(gw_contract) Then
//	gw_contract.setredraw(false)
//	gw_contract.tab_contract_details.setredraw(false)
//	gw_contract.tab_contract_details.tabpage_search.il_ctx_id = al_ctx_id
//	gw_contract.inv_contract_codes.of_set_ctx_id(al_ctx_id)
//	//gw_contract.tab_contract_details.tabpage_search.cb_1.triggerevent(clicked!)
//	gw_contract.tab_contract_details.tabpage_search.ib_retriev_detail = True
//	gw_contract.tab_contract_details.tabpage_search.ib_autoretrieve = True
//	gw_contract.tab_contract_details.tabpage_search.of_retrieve( )
//	gw_contract.inv_contract_codes.of_set_ctx_id(al_ctx_id)
//	gw_contract.wf_set_save_status(false)
//	gw_contract.wf_set_select('All',false)
//	gw_contract.tab_contract_details.tabpage_details.inv_contract_details.il_count = 0
//	gw_contract.of_select_details_tab()	
//	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
//	Post of_show_contract_window()
//End If
end subroutine

public subroutine of_show_contract_window ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctxof_show_contract_window()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Set Focus and Show window if it is hide(To No Flash).
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-27 by Ken.Guo
// Modified By Ken.Guo 2010-10-09. Moved to w_contract
//////////////////////////////////////////////////////////////////////
//
//gw_contract.setfocus()
//gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.SetColumn('app_facility')	
//gw_contract.setredraw(True)
//gw_contract.tab_contract_details.setredraw(True)	
//If gb_open_from_template = True Then
//	w_mdi.WindowState = Maximized!
//	w_mdi.Show()
//	gw_Contract.of_Show()
//	gb_open_from_template = False
//End If
//If gw_Contract.windowstate = Minimized! Then 
//	gw_Contract.windowstate = Maximized!
//End If
end subroutine

public function integer of_check_exist_contract ();//Check contract window. Detail tab sometimes(if no contacts data) can not allow to jump to search tab.
integer li_rc,li_tab_index
u_tabpg_contract_master luo_tabpg
If isvalid(gw_contract) Then
	li_tab_index = gw_contract.tab_contract_details.selectedtab
	If li_tab_index <> 1 Then
		luo_tabpg = gw_contract.tab_contract_details.control[li_tab_index]
		li_rc = luo_tabpg.Dynamic of_validation( )
		If li_rc < 0 Then 
			If gw_contract.windowstate = Minimized! Then gw_contract.windowstate = Maximized!
			Messagebox('IntelliSoft','Please save current contract before you create a new contract.')//(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoft"
			Return 0
		End If
	End If
End If
Return 1
end function

public function integer of_locate_ctx (long al_ctx_id, integer ai_tab_index);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctxof_locate_ctx()
// $<arguments>
//		value	long   	al_ctx_id   		
//		value	integer	ai_tab_index		
// $<returns> integer
// $<description>Locate target ctx and selected specail tab.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-28 by Ken.Guo
//////////////////////////////////////////////////////////////////////


String ls_tab_name
Choose Case ai_tab_index
	Case 1
		ls_tab_name = 'tabpage_search'
	Case 2
		If gw_contract.tab_contract_details.tabpage_details.visible = True Then
			ls_tab_name = 'tabpage_details'			
		Else
			ls_tab_name = 'tabpage_search'
		End If
	Case 3
		If gw_contract.tab_contract_details.tabpage_requirements.visible = True Then
			ls_tab_name = 'tabpage_requirements'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 4
			If gw_contract.tab_contract_details.tabpage_contacts.visible = True Then
			ls_tab_name = 'tabpage_contacts'			
		Else
			ls_tab_name = 'tabpage_search'
		End If
	Case 5
		If gw_contract.tab_contract_details.tabpage_locations.visible = True Then
			ls_tab_name = 'tabpage_locations'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 6
		If gw_contract.tab_contract_details.tabpage_orgabizations.visible = True Then
			ls_tab_name = 'tabpage_orgabizations'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 7
		If gw_contract.tab_contract_details.tabpage_fee_schedules.visible = True Then
			ls_tab_name = 'tabpage_fee_schedules'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 8
		If gw_contract.tab_contract_details.tabpage_fee_sched2.visible = True Then
			ls_tab_name = 'tabpage_fee_sched2'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 9
		ls_tab_name = ''
		If gw_contract.tab_contract_details.tabpage_images.visible = True Then
			ls_tab_name = 'tabpage_images'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case 10
		If gw_contract.tab_contract_details.tabpage_action_items.visible = True Then
			ls_tab_name = 'tabpage_action_items'			
		Else
			ls_tab_name = 'tabpage_search'
		End If		
	Case Else
		ls_tab_name = 'tabpage_search'
End Choose
		

//Locate new ctx.
If al_ctx_id > 0 and isvalid(gw_contract) Then
	gw_contract.setredraw(false)
	gw_contract.tab_contract_details.setredraw(false)
	gw_contract.tab_contract_details.tabpage_search.il_ctx_id = al_ctx_id
	gw_contract.inv_contract_codes.of_set_ctx_id(al_ctx_id)
	//gw_contract.tab_contract_details.tabpage_search.cb_1.triggerevent(clicked!)
	gw_contract.tab_contract_details.tabpage_search.ib_retriev_detail = True
	gw_contract.tab_contract_details.tabpage_search.ib_autoretrieve = True
	gw_contract.tab_contract_details.tabpage_search.of_retrieve( )
	gw_contract.inv_contract_codes.of_set_ctx_id(al_ctx_id)
	gw_contract.wf_set_save_status(false)
	gw_contract.wf_set_select('All',false)
	gw_contract.tab_contract_details.tabpage_details.inv_contract_details.il_count = 0
	//gw_contract.of_select_details_tab()	
	gw_contract.of_select_tabpage(ls_tab_name)
	
	//the contracted company name must be filled before the contract can be saved - jervis 09.05.2011
	if ai_tab_index = 2 and  gw_contract.tab_contract_details.tabpage_details.visible = True then
		gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.SetItemStatus( 1, 'app_facility',Primary!, DataModified!)
	end if
	
	//gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
	gw_contract.Post of_show_contract_window()
End If

Return 1
end function

public subroutine of_copy_alarms (str_copy_ctx astr_copy_ctx, long al_ctx_id, long al_ori_action_id[], long al_new_action_id[]);//Copy Alarms data -- Add by jervis 08.18.2010
//Add al_ori_action_id,al_new_action_id parm -- jervis 12.31.2010
long ll_i,ll_count

//Copy Alarms for Action Item  -- jervis 12.31.2010
if astr_copy_ctx.sb_action_items = 1 then
	ll_count = Upperbound(al_ori_action_id)
	for ll_i = 1 to ll_count
		insert into ctx_ai_notification(ctx_id,
			ctx_action_item_id,
			alm_table,
			alm_column,
			alm_message,
			alm_enabled,
			alm_notification_days,
			alm_post_notification_days,
			alm_total_tries,
			alm_action_item_posted,
			alm_frequency,
			create_action_item,
			record_id,
			alm_auto_increment_years,
			alm_action_title,
			wf_id,
			alm_auto_increment_unit,
			alm_email_template_id,
			alm_message_blob,
			alm_attachment_name,
			alm_attachment,
			alm_mailto,
			auto_sign,
			alm_create,
			alm_subject)
		SELECT :al_ctx_id,
			:al_new_action_id[ll_i],
			alm_table,
			alm_column,
			alm_message,
			alm_enabled,
			alm_notification_days,
			alm_post_notification_days,
			alm_total_tries,
			alm_action_item_posted,
			alm_frequency,
			create_action_item,
			record_id,
			alm_auto_increment_years,
			alm_action_title,
			wf_id,
			alm_auto_increment_unit,
			alm_email_template_id,
			alm_message_blob,
			alm_attachment_name,
			alm_attachment,
			alm_mailto,
			auto_sign,
			alm_create,
			alm_subject
	  FROM ctx_ai_notification
	  where ctx_id = :astr_copy_ctx.sl_ctx_id and ctx_action_item_id = :al_ori_action_id[ll_i];
	  
		insert into ctx_ai_alarm_attachment(ctx_id,
			item_id,
			alm_table,
			alm_column,
			attach_id,
			alm_attachment_name,
			alm_attachment
		)
		SELECT :al_ctx_id,
			:al_new_action_id[ll_i],
			alm_table,
			alm_column,
			attach_id,
			alm_attachment_name,
			alm_attachment
		FROM ctx_ai_alarm_attachment
		where ctx_id = :astr_copy_ctx.sl_ctx_id and item_id = :al_ori_action_id[ll_i];
	next
end if

//Copy alarm for Custom Data2	-- Jervis 06.10.2011
if astr_copy_ctx.sb_custom_data2 = 1 then
	insert into CTX_NOTIFICATION(ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
	)
	SELECT :al_ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
  FROM CTX_NOTIFICATION
  where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_custom';
  
	
	insert into ctx_alarm_attachment(ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	)
	SELECT :al_ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	FROM ctx_alarm_attachment
	where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_custom' ;
	
end if

//Copy for Contract alarms
If astr_copy_ctx.sb_contract_dates = 1 and astr_copy_ctx.sb_custom_data = 1 Then
	insert into CTX_NOTIFICATION(ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
	)
	SELECT :al_ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
  FROM CTX_NOTIFICATION
  where ctx_id = :astr_copy_ctx.sl_ctx_id;
  
	
	insert into ctx_alarm_attachment(ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	)
	SELECT :al_ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	FROM ctx_alarm_attachment
	where ctx_id = :astr_copy_ctx.sl_ctx_id;
elseif astr_copy_ctx.sb_contract_dates = 1 then
		insert into CTX_NOTIFICATION(ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
	)
	SELECT :al_ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
  FROM CTX_NOTIFICATION
  where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_basic_info' and 
		alm_column in ('effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2','last_revis_dateversion_date');
  
	
	insert into ctx_alarm_attachment(ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	)
	SELECT :al_ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	FROM ctx_alarm_attachment
	where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_basic_info' and 
		alm_column in('effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2','last_revis_dateversion_date');
	
elseif astr_copy_ctx.sb_custom_data = 1 then
		insert into CTX_NOTIFICATION(ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
	)
	SELECT :al_ctx_id,
      alm_message,
      alm_enabled,
      alm_table,
      alm_column,
      alm_notification_days,
      alm_post_notification_days,
      alm_total_tries,
      alm_action_item_posted,
      alm_frequency,
      create_action_item,
      record_id,
      alm_auto_increment_years,
      alm_action_title,
      wf_id,
      alm_auto_increment_unit,
      alm_email_template_id,
      alm_message_blob,
      alm_attachment_name,
      alm_attachment,
      alm_mailto,
      auto_sign,
      alm_create,
      alm_subject
  FROM CTX_NOTIFICATION
  where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_basic_info' and 
		alm_column not in ('effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2','last_revis_dateversion_date');
  
	
	insert into ctx_alarm_attachment(ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	)
	SELECT :al_ctx_id,
		alm_table,
		alm_column,
		attach_id,
		alm_attachment_name,
		alm_attachment
	FROM ctx_alarm_attachment
	where ctx_id = :astr_copy_ctx.sl_ctx_id and
  		alm_table = 'ctx_basic_info' and 
		alm_column not in ('effective_date','expriation_date','review_date','other_date_1','term_date','other_date_2','last_revis_dateversion_date');
end if

end subroutine

public subroutine of_copy_custom_data (str_copy_ctx astr_copy_ctx, long al_new_ctx_id);//Copy Custom data2 and custom multi -- Add by jervis 06.10.2011
long ll_i,ll_count

//Copy Custom data 2
if astr_copy_ctx.sb_custom_data2 = 1 then
	INSERT INTO ctx_custom
           (ctx_id
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_11
           ,custom_12
           ,custom_13
           ,custom_14
           ,custom_15
           ,custom_16
           ,custom_17
           ,custom_18
           ,custom_19
           ,custom_20
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_date6
           ,custom_date7
           ,custom_date8
           ,custom_date9
           ,custom_date10
           ,custom_date11
           ,custom_date12
           ,custom_date13
           ,custom_date14
           ,custom_date15
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_n6
           ,custom_n7
           ,custom_n8
           ,custom_n9
           ,custom_n10
           ,custom_n11
           ,custom_n12
           ,custom_n13
           ,custom_n14
           ,custom_n15
           ,custom_n16
           ,custom_n17
           ,custom_n18
           ,custom_n19
           ,custom_n20
           ,custom_n21
           ,custom_n22
           ,custom_n23
           ,custom_n24
           ,custom_n25
           ,custom_21
           ,custom_22
           ,custom_notes_1
           ,custom_notes_2
           ,custom_notes_3
           ,custom_notes_4
           ,custom_notes_5
           ,custom_money_1
           ,custom_money_2
           ,custom_money_3
           ,custom_percent_1
           ,custom_percent_2
           ,custom_percent_3
           ,custom_percent_4
           ,custom_percent_5
           ,custom_percent_6
           ,custom_percent_7
           ,custom_percent_8
           ,custom_percent_9
           ,custom_percent_10)
		select :al_new_ctx_id
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_11
           ,custom_12
           ,custom_13
           ,custom_14
           ,custom_15
           ,custom_16
           ,custom_17
           ,custom_18
           ,custom_19
           ,custom_20
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_date6
           ,custom_date7
           ,custom_date8
           ,custom_date9
           ,custom_date10
           ,custom_date11
           ,custom_date12
           ,custom_date13
           ,custom_date14
           ,custom_date15
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_n6
           ,custom_n7
           ,custom_n8
           ,custom_n9
           ,custom_n10
           ,custom_n11
           ,custom_n12
           ,custom_n13
           ,custom_n14
           ,custom_n15
           ,custom_n16
           ,custom_n17
           ,custom_n18
           ,custom_n19
           ,custom_n20
           ,custom_n21
           ,custom_n22
           ,custom_n23
           ,custom_n24
           ,custom_n25
           ,custom_21
           ,custom_22
           ,custom_notes_1
           ,custom_notes_2
           ,custom_notes_3
           ,custom_notes_4
           ,custom_notes_5
           ,custom_money_1
           ,custom_money_2
           ,custom_money_3
           ,custom_percent_1
           ,custom_percent_2
           ,custom_percent_3
           ,custom_percent_4
           ,custom_percent_5
           ,custom_percent_6
           ,custom_percent_7
           ,custom_percent_8
           ,custom_percent_9
           ,custom_percent_10
     from ctx_custom 
	  where ctx_id = :astr_copy_ctx.sl_ctx_id;
end if

//Copy Custom Multi
if astr_copy_ctx.sb_custom_multi =  1 then
	INSERT INTO ctx_custom_multi_hdr
           (ctx_id
           ,hdr_id
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_date6
           ,custom_date7
           ,custom_date8
           ,custom_date9
           ,custom_date10
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_n6
           ,custom_n7
           ,custom_n8
           ,custom_n9
           ,custom_n10
           ,custom_notes_1
           ,custom_notes_2
           ,custom_m1
           ,custom_m2
           ,custom_m3
           ,custom_m4
           ,custom_m5
           ,custom_percent_1
           ,custom_percent_2
           ,custom_percent_3
           ,custom_percent_4
           ,custom_percent_5)
		select :al_new_ctx_id
           ,hdr_id
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_date6
           ,custom_date7
           ,custom_date8
           ,custom_date9
           ,custom_date10
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_n6
           ,custom_n7
           ,custom_n8
           ,custom_n9
           ,custom_n10
           ,custom_notes_1
           ,custom_notes_2
           ,custom_m1
           ,custom_m2
           ,custom_m3
           ,custom_m4
           ,custom_m5
           ,custom_percent_1
           ,custom_percent_2
           ,custom_percent_3
           ,custom_percent_4
           ,custom_percent_5
		From ctx_custom_multi_hdr 
	  where ctx_id = :astr_copy_ctx.sl_ctx_id;
	  
	  
	  INSERT INTO ctx_custom_multi_detail
           (ctx_id
           ,hdr_id
           ,detail_id
           ,custom_int1
           ,custom_int2
           ,custom_int3
           ,custom_int4
           ,custom_int5
           ,custom_fee1
           ,custom_fee2
           ,custom_fee3
           ,custom_fee4
           ,custom_fee5
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_percent_1
           ,custom_percent_2
           ,custom_notes_1)
		select :al_new_ctx_id
           ,hdr_id
           ,detail_id
           ,custom_int1
           ,custom_int2
           ,custom_int3
           ,custom_int4
           ,custom_int5
           ,custom_fee1
           ,custom_fee2
           ,custom_fee3
           ,custom_fee4
           ,custom_fee5
           ,custom_1
           ,custom_2
           ,custom_3
           ,custom_4
           ,custom_5
           ,custom_6
           ,custom_7
           ,custom_8
           ,custom_9
           ,custom_10
           ,custom_date1
           ,custom_date2
           ,custom_date3
           ,custom_date4
           ,custom_date5
           ,custom_n1
           ,custom_n2
           ,custom_n3
           ,custom_n4
           ,custom_n5
           ,custom_percent_1
           ,custom_percent_2
           ,custom_notes_1
		from ctx_custom_multi_detail
		where ctx_id = :astr_copy_ctx.sl_ctx_id;
				
end if


end subroutine

public function integer of_insert_contact (long al_ctx_id, integer ai_ib_default_email, integer ai_ib_owner);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_copy_ctxof_insert_contact()
// $<arguments>
//		long	al_ctx_id		
// $<returns> integer
// $<description>
// $<description> Insert current user to our company contact.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-27 by Ken.Guo
//Added By Mark Lee 05/09/12	add condition about  'ai_ib_default_email' and  'ai_ib_owner' chooses
//////////////////////////////////////////////////////////////////////

long ll_contact_id,ll_cnt
long ll_record_id
long ll_contact_type
string ls_access,ls_contact_type
string 	ls_default_email,	ls_owner

gnv_appeondb.of_startqueue( )
	Select Top 1 contact_id,contact_type Into :ll_contact_id,:ll_contact_type From ctx_contacts Where user_d = :gs_user_id;
	Select top 1 access Into :ls_access From ctx_contract_contacts Where ctx_id = :al_ctx_id and contact_id = :ll_contact_id and ic_area = 'I';
gnv_appeondb.of_commitqueue( )

If isnull(ll_contact_id) Then Return 0

If sqlca.sqlcode = 0 Then
	If (ls_access <> 'F' or isnull(ls_access)) Then 
		Update ctx_contract_contacts set access = 'F' Where ctx_id = :al_ctx_id and contact_id = :ll_contact_id and ic_area = 'I';
		Return 0
	End If
	If ls_access = 'F' Then Return 1	
End IF

ll_record_id = gnv_app.of_get_id('RECORD_ID')
ls_contact_type = String(ll_contact_type)

//Begin - Added By Mark Lee 05/09/12
gnv_appeondb.of_startqueue( )
	If ai_ib_default_email  = 1 Then 
		ls_default_email = "Y"
		Update ctx_contract_contacts set default_email = 'N' Where ctx_id = :al_ctx_id  and ic_area = 'I' AND default_email = 'Y';
	Else
		ls_default_email = "N"
	End If 
	
	If ai_ib_owner  = 1 Then 
		ls_owner = "Y"
		Update ctx_contract_contacts set owner = 'N' Where ctx_id = :al_ctx_id  and ic_area = 'I' AND owner = 'Y';
	Else
		ls_owner = "N"
	End If 
gnv_appeondb.of_commitqueue( )
//End - Added By Mark Lee 05/09/12


//Added By Mark Lee 05/09/12
//Insert Into ctx_contract_contacts(
//	ctx_id,
//	contact_id,
//	ic_area,
//	default_email,
//	association,
//	owner,
//	Access,
//	record_id,
//	inserted_by_user,
//	inserted_at_date_time,
//	updated_by_user,
//	updated_at_date_time) 
//	Values(
//	:al_ctx_id,
//	:ll_contact_id,
//	'I',
//	'N',
//	:ls_contact_type,
//	'N',
//	'F',
//	:ll_record_id,
//	:gs_user_id,
//	getdate(),
//	:gs_user_id,
//	getdate()
//	) ;
Insert Into ctx_contract_contacts(
	ctx_id,
	contact_id,
	ic_area,
	default_email,
	association,
	owner,
	Access,
	record_id,
	inserted_by_user,
	inserted_at_date_time,
	updated_by_user,
	updated_at_date_time) 
	Values(
	:al_ctx_id,
	:ll_contact_id,
	'I',
	:ls_default_email,
	:ls_contact_type,
	:ls_owner,
	'F',
	:ll_record_id,
	:gs_user_id,
	getdate(),
	:gs_user_id,
	getdate()
	) ;
Commit;


Return 1
end function

public subroutine of_copy_company_contact_data (str_copy_ctx astr_copy_ctx, long ai_new_ctx_id);//====================================================================
// Function: of_copy_company_contact_data
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                astr_copy_ctx
//                ai_new_ctx_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/20/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 		ll_record_id, ll_get_ctx_id , ll_tmp
Datetime		ldt_today

If Not isnull(astr_copy_ctx.ai_ib_copy_m_company_contact) and astr_copy_ctx.ai_ib_copy_m_company_contact = 1 then
	IF isvalid(gw_contract) then 
		ll_get_ctx_id = gw_contract.tab_contract_details.tabpage_search.il_ctx_id

		Select count(1)
		Into : ll_tmp
		From CTX_CONTRACT_CONTACTS
		Where CTX_CONTRACT_CONTACTS.ctx_id = :ai_new_ctx_id and  CTX_CONTRACT_CONTACTS.ic_area = 'E'
		and CTX_CONTRACT_CONTACTS.contact_id  in (Select contact_id From CTX_CONTRACT_CONTACTS
																	Where CTX_CONTRACT_CONTACTS.ctx_id = :ll_get_ctx_id 
																	and  CTX_CONTRACT_CONTACTS.ic_area = 'E') ;
		If isnull(ll_tmp) or ll_tmp = 0 then 																	
			ll_record_id = gnv_app.of_get_id('RECORD_ID')
			ldt_today = Datetime(today())
			
			INSERT INTO CTX_CONTRACT_CONTACTS
					  (ctx_id ,contact_id  ,ic_area ,association ,notes ,default_email ,record_id ,inserted_by_user ,inserted_at_date_time
					  ,updated_by_user  ,updated_at_date_time ,owner ,access ,custom_n1  ,custom_n2 ,custom_n3,custom_percent_1
					  ,custom_percent_2  ,custom_1 ,custom_2  ,custom_3)
				Select :ai_new_ctx_id ,contact_id  ,ic_area ,association ,notes ,default_email ,record_id ,:gs_user_id ,:ldt_today
					  ,:gs_user_id  ,:ldt_today ,owner ,access ,custom_n1  ,custom_n2 ,custom_n3,custom_percent_1
					  ,custom_percent_2  ,custom_1 ,custom_2  ,custom_3
				From CTX_CONTRACT_CONTACTS
				WHere CTX_CONTRACT_CONTACTS.ctx_id = :ll_get_ctx_id
					and CTX_CONTRACT_CONTACTS.ic_area = 'E' ;				
		End If					
	End If	
End If
end subroutine

on n_cst_copy_ctx.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_copy_ctx.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

