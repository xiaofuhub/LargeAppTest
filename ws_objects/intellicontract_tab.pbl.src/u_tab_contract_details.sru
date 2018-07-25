$PBExportHeader$u_tab_contract_details.sru
$PBExportComments$[intellicontract_tab]  Tab  for the contract module
forward
global type u_tab_contract_details from u_tab
end type
type tabpage_search from u_tabpg_contract_search within u_tab_contract_details
end type
type tabpage_search from u_tabpg_contract_search within u_tab_contract_details
end type
type tabpage_details from u_tabpg_contract_det within u_tab_contract_details
end type
type tabpage_details from u_tabpg_contract_det within u_tab_contract_details
end type
type tabpage_requirements from u_tabpg_contract_requirements within u_tab_contract_details
end type
type tabpage_requirements from u_tabpg_contract_requirements within u_tab_contract_details
end type
type tabpage_contacts from u_tabpg_contract_contact within u_tab_contract_details
end type
type tabpage_contacts from u_tabpg_contract_contact within u_tab_contract_details
end type
type tabpage_locations from u_tabpg_contract_locations within u_tab_contract_details
end type
type tabpage_locations from u_tabpg_contract_locations within u_tab_contract_details
end type
type tabpage_orgabizations from u_tabpg_contract_organizations within u_tab_contract_details
end type
type tabpage_orgabizations from u_tabpg_contract_organizations within u_tab_contract_details
end type
type tabpage_fee_schedules from u_tabpg_contract_fee_schedules within u_tab_contract_details
end type
type tabpage_fee_schedules from u_tabpg_contract_fee_schedules within u_tab_contract_details
end type
type tabpage_fee_sched2 from u_tabpg_contract_fee_sched2 within u_tab_contract_details
end type
type tabpage_fee_sched2 from u_tabpg_contract_fee_sched2 within u_tab_contract_details
end type
type tabpage_images from u_tabpg_dm_manager within u_tab_contract_details
end type
type tabpage_images from u_tabpg_dm_manager within u_tab_contract_details
end type
type tabpage_action_items from u_tabpg_contract_action_items within u_tab_contract_details
end type
type tabpage_action_items from u_tabpg_contract_action_items within u_tab_contract_details
end type
type tabpage_multi from u_tabpg_contract_multi within u_tab_contract_details
end type
type tabpage_multi from u_tabpg_contract_multi within u_tab_contract_details
end type
type tabpage_email from u_tabpg_contract_email within u_tab_contract_details
end type
type tabpage_email from u_tabpg_contract_email within u_tab_contract_details
end type
end forward

global type u_tab_contract_details from u_tab
integer width = 3995
integer height = 2136
long backcolor = 33551856
boolean createondemand = true
alignment alignment = center!
tabpage_search tabpage_search
tabpage_details tabpage_details
tabpage_requirements tabpage_requirements
tabpage_contacts tabpage_contacts
tabpage_locations tabpage_locations
tabpage_orgabizations tabpage_orgabizations
tabpage_fee_schedules tabpage_fee_schedules
tabpage_fee_sched2 tabpage_fee_sched2
tabpage_images tabpage_images
tabpage_action_items tabpage_action_items
tabpage_multi tabpage_multi
tabpage_email tabpage_email
event ue_new ( )
event of_search ( )
end type
global u_tab_contract_details u_tab_contract_details

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.28.2006 By: Liang QingShi
//$<reason> Contract module modification
boolean ib_select1 = true,ib_select2 = true,ib_select3 = true,ib_select4 = true,ib_select5 = true,ib_select6 = true
boolean ib_select7 = true,ib_select8 = true,ib_select9 = true,ib_select10 = true,ib_select11 = true,ib_select12 = true
Boolean ib_select
//---------------------------- APPEON END ----------------------------

Boolean ib_showed = False

integer ii_Index //Add by Evan 12/08/2008
end variables

forward prototypes
public function u_tabpg of_gettabpage (integer ai_index)
public function integer of_set_contract_details (n_cst_contract anv_contract_details)
public function integer of_reset_retrived_status ()
public subroutine of_tab_visible (integer arg_view_id)
public subroutine of_set_select (string arg_tab, boolean arg_select)
public subroutine of_reset_det_retrived_status ()
public function integer of_refreshdocument ()
public subroutine of_refresh_group ()
public subroutine of_openctxworkflowstep (long al_oldindex, long al_newindex)
public subroutine of_create_menu_item ()
end prototypes

event of_search();
THIS.TABpage_search.CB_1.event clicked( )
end event

public function u_tabpg of_gettabpage (integer ai_index);/******************************************************************************************************************
**  [PUBLIC]   : of_GetTabPage( /*integer ai_index */)
**==================================================================================================================
**  Purpose   	: Return the specified tab page based upon the index, ai_index.
**==================================================================================================================
**  Arguments 	: [ai_index] index of the tabpage in the control array
**==================================================================================================================
**  Returns   	: [u_tabpg] The current tab page   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Return this.Control[ai_index]
end function

public function integer of_set_contract_details (n_cst_contract anv_contract_details);/******************************************************************************************************************
**  [PUBLIC]   : of_set_contract_details( /*n_cst_contract anv_contract_details */)
**==================================================================================================================
**  Purpose   	: BROADCAST THE COMMON USER OBJECT TO ALL OF THE TAB PAGES
**==================================================================================================================
**  Arguments 	: [n_cst_contract]  anv_contract_details
**==================================================================================================================
**  Returns   	: [SUCCESS]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner      1 July 2005         ? IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

u_tabpg_contract_master	ltpg_contract

integer i
long ll_j



setpointer(hourglass!)

FOR i= 1 TO  upperbound(this.Control)
    ltpg_contract = this.Control[i]
	 ltpg_contract.of_set_contract_details(anv_contract_details)
NEXT


/***********************************************************************************************************/
/**************** NOTE THE FOLLOWING NEED TO BE SET BECAUSE THE TAB IS NOT A DESCENDENT OF THIS ONE ********/
/***********************************************************************************************************/
tabpage_details.uo_1.inv_contract_details = anv_contract_details

////////////////////////////////////////////////////
// detail screeen
////////////////////////////////////////////////////

//tabpage_details.tab_1.tabpage_1.INv_contract_details = anv_contract_details
//tabpage_details.tab_1.tabpage_2.INv_contract_details = anv_contract_details

////////////////////////////////////////////////////
// fee schedule tab
////////////////////////////////////////////////////
this.tabpage_fee_schedules.tab_1.tabpage_fee_browse.inv_contract_details = anv_contract_details
this.tabpage_fee_schedules.tab_1.tabpage_fee_notes.inv_contract_details = anv_contract_details


////////////////////////////////////////////////////
// SUPORTING DOCUMENTS TAB
////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<Delete> 2007-01-09 By: Frank.Gui
//$<reason> Change Supporting Document to Documane Manager
//this.tabpage_images.tab_1.tabpage_browse.inv_contract_details = anv_contract_details
//this.tabpage_images.tab_1.tabpage_view	.inv_contract_details = anv_contract_details 
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-09 By: Frank.Gui
//$<reason> Add new functionalities for Dcoument Manager
this.tabpage_images.tab_1.tabpage_data.inv_contract_details = anv_contract_details
this.tabpage_images.tab_1.tabpage_action.inv_contract_details = anv_contract_details
//this.tabpage_images.tab_1.tabpage_audit.inv_contract_details = anv_contract_details
//---------------------------- APPEON END ----------------------------

//fix this.tabpage_images.tab_details.tabpage_image.tab_1.tabpage_browse.inv_contract_details  = anv_contract_details
///this.tabpage_images.tab_details.tabpage_image.tab_1.tabpage_scan.inv_contract_details  = anv_contract_details
//fixthis.tabpage_images.tab_details.tabpage_image.tab_1.tabpage_view.inv_contract_details  = anv_contract_details
//fixthis.tabpage_images.tab_details.tabpage_docs.tab_1.tabpage_1.inv_contract_details  = anv_contract_details 




////////////////////////////////////////////////////
// QRG
////////////////////////////////////////////////////
/*
THIS.TABpage_qrg.tab_1.tabpage_selection.inv_contract_details = anv_contract_details
THIS.TABpage_qrg.tab_1.tabpage_build.inv_contract_details = anv_contract_details
THIS.TABpage_qrg.tab_1.tabpage_preview.inv_contract_details = anv_contract_details
*/
//THIS.TABpage_qrg.tab_1.tabpage_selection.of_init_data( )

//Add custom multi data - jervis 05.31.2011
this.tabpage_multi.tab_multi.tabpage_header.inv_contract_details = anv_contract_details
this.tabpage_multi.tab_multi.tabpage_detail.inv_contract_details = anv_contract_details

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: LeiWei
//$<reason> Fix a defect.

////////////////////////////////////////////////////
// Action Item TAB
////////////////////////////////////////////////////
THIS.tabpage_action_items.tab_1.tabpage_browse.inv_contract_details = anv_contract_details
THIS.tabpage_action_items.tab_1.tabpage_detail.inv_contract_details = anv_contract_details

//---------------------------- APPEON END ----------------------------

setpointer(arrow!)
return SUccess
end function

public function integer of_reset_retrived_status ();
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 01 September 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

u_tabpg_contract_master	ltpg_contract

integer i

FOR i= 1 TO  upperbound(this.Control)
    ltpg_contract = this.Control[i]
	 ltpg_contract.event ue_reset_ib_retrieve( )
next
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
this.tabpage_details.uo_1.event ue_reset_ib_retrieve( )
this.tabpage_details.event ue_reset_ib_retrieve( )
*/
//---------------------------- APPEON END ----------------------------

tabpage_fee_schedules.tab_1.of_reset_retrived_status( )

/*  Image tab*/

//---------------------------- APPEON END ----------------------------
//$<modify> 01.27.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager.
//OLD:tabpage_images.tab_1.tabpage_browse.event ue_reset_ib_retrieve( )
tabpage_images.tab_1.tabpage_data.event ue_reset_ib_retrieve( )
tabpage_images.tab_1.tabpage_action.event ue_reset_ib_retrieve( )
//tabpage_images.tab_1.tabpage_audit.event ue_reset_ib_retrieve( )
//---------------------------- APPEON END ----------------------------

//tabpage_details.tabpage_images.tab_details.tabpage_image.tab_1.tabpage_browse.ib_retrieved = false
//fixtabpage_images.tab_details.tabpage_image.tab_1.tabpage_view.ib_retrieved = false

/************  qrg tab **********************************************************/
//comment by jervis 05.31.2011
//TABPage_qrg.TAB_1.OF_reset_retrived_status( )

//Add custom multi data -- jervis 05.11.2011
//tabpage_multi.tab_multi.OF_reset_retrived_status

return success
end function

public subroutine of_tab_visible (integer arg_view_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tab_contract_detailsof_tab_visible()
// $<arguments>
//		value	integer	arg_view_id		
// $<returns> (none)
// $<description>Contract module modIfication
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.25.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name[]
string ls_tab
integer li_num,i,li_find,li_rowcount
datastore lds_tab
lds_tab = create datastore
lds_tab.dataobject = 'd_contract_tab'
lds_tab.settransobject(sqlca)
gds_contract_screen = create datastore
gds_contract_screen.dataobject = 'd_contract_dw_sql_all'
gds_contract_screen.settransobject(sqlca)
setpointer(hourglass!)

If isnull(arg_view_id) Or arg_view_id = 0 Then arg_view_id = 1001
gnv_appeondb.of_startqueue( )		
li_rowcount = lds_tab.retrieve(arg_view_id)
gds_contract_screen.retrieve(arg_view_id)
gnv_appeondb.of_commitqueue( )		

li_rowcount = lds_tab.rowcount()
If li_rowcount <= 0 Then
	Destroy lds_tab
	Return
end if

ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_details'
ls_tab_name[3] = 'tabpage_requirements'
ls_tab_name[4] = 'tabpage_contacts'
ls_tab_name[5] = 'tabpage_locations'
ls_tab_name[6] = 'tabpage_orgabizations'
ls_tab_name[7] = 'tabpage_fee_schedules'
ls_tab_name[8] = 'tabpage_fee_sched2'
ls_tab_name[9] = 'tabpage_images'
ls_tab_name[10] = 'tabpage_action_items'
//ls_tab_name[11] = 'tabpage_analysis'
ls_tab_name[11] = 'tabpage_multi'
//ls_tab_name[12] = 'tabpage_qrg'
ls_tab_name[12] = 'tabpage_email'						//Added By Mark Lee 02/05/2013

li_num = upperbound(ls_tab_name)
For i = 1 to li_num
	ls_tab = ls_tab_name[i]
	choose case ls_tab
//		case 'tabpage_search'
//			li_find = lds_tab.find("tab_name = 'tabpage_search'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_search.visible = True
//			Else
//				tabpage_search.visible = False				
//			End If	
		case 'tabpage_details'
			li_find = lds_tab.find("tab_name = 'tabpage_details'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_details.visible = True
			Else
				tabpage_details.visible = False				
			End If	
		case 'tabpage_requirements'
			li_find = lds_tab.find("tab_name = 'tabpage_requirements'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_requirements.visible = True
			Else
				tabpage_requirements.visible = False				
			End If	
		case 'tabpage_contacts'
			li_find = lds_tab.find("tab_name = 'tabpage_contacts'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_contacts.visible = True
			Else
				tabpage_contacts.visible = False				
			End If	
		case 'tabpage_locations'
			li_find = lds_tab.find("tab_name = 'tabpage_locations'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_locations.visible = True
			Else
				tabpage_locations.visible = False				
			End If	
		case 'tabpage_orgabizations'
			li_find = lds_tab.find("tab_name = 'tabpage_orgabizations'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_orgabizations.visible = True
			Else
				tabpage_orgabizations.visible = False				
			End If	
		case 'tabpage_fee_schedules'
			li_find = lds_tab.find("tab_name = 'tabpage_fee_schedules'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_fee_schedules.visible = True
			Else
				tabpage_fee_schedules.visible = False				
			End If	
		case 'tabpage_fee_sched2'
			li_find = lds_tab.find("tab_name = 'tabpage_fee_sched2'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_fee_sched2.visible = True
			Else
				tabpage_fee_sched2.visible = False				
			End If	
		case 'tabpage_images'
			li_find = lds_tab.find("tab_name = 'tabpage_images'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_images.visible = True
			Else
				tabpage_images.visible = False				
			End If	
		case 'tabpage_action_items'
			li_find = lds_tab.find("tab_name = 'tabpage_action_items'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_action_items.visible = True
			Else
				tabpage_action_items.visible = False				
			End If	
		case 'tabpage_multi' 	//add custom multi data - jervis 05.31.2011
			li_find = lds_tab.find("tab_name = 'tabpage_multi'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_multi.visible = True
			Else
				tabpage_multi.visible = False				
			End If	
//		case 'tabpage_analysis'
//			li_find = lds_tab.find("tab_name = 'tabpage_analysis'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_analysis.visible = True
//			Else
//				tabpage_analysis.visible = False				
//			End If	
//		case 'tabpage_qrg'
//			li_find = lds_tab.find("tab_name = 'tabpage_qrg'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_qrg.visible = True
//			Else
//				tabpage_qrg.visible = False				
//			End If	
		Case 'tabpage_email'					//Added By Mark Lee 02/05/2013
			li_find = lds_tab.find("tab_name = 'tabpage_email'",1,li_rowcount)
			If li_find > 0 Then
				tabpage_email.visible = True
			Else
				tabpage_email.visible = False				
			End If	
	End choose
Next

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-07 By: Scofield
//$<Reason> Destroy lds_tab
if isValid(lds_tab) then
	Destroy lds_tab
end if
//---------------------------- APPEON END ----------------------------

//---------------------------- APPEON End ----------------------------

end subroutine

public subroutine of_set_select (string arg_tab, boolean arg_select);//////////////////////////////////////////////////////////////////////
// $<function>u_tab_contract_detailsof_set_select()
// $<arguments>
//		value	string 	arg_tab   		
//		value	boolean	arg_select		
// $<returns> (none)
// $<description> Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.22.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
choose case arg_tab
	case 'tabpage_search'
		ib_select1 = arg_select
		tabpage_search.ib_retriev_detail = True  //Add by Jack 06/11/2007
	case 'tabpage_details'
		ib_select2 = arg_select
	case 'tabpage_requirements'
		ib_select3 = arg_select
	case 'tabpage_contacts'
		ib_select4 = arg_select
	case 'tabpage_locations'
		ib_select5 = arg_select
	case 'tabpage_orgabizations'
		ib_select6 = arg_select
	case 'tabpage_fee_schedules'
		ib_select7 = arg_select
	case 'tabpage_fee_sched2'
		ib_select8 = arg_select
	case 'tabpage_images'
		ib_select9 = arg_select
	case 'tabpage_action_items'
		ib_select10 = arg_select
//	case 'tabpage_analysis'
//		ib_select11 = arg_select
//	case 'tabpage_qrg'
//		ib_select12 = arg_select
	case 'tabpage_multi' //add by jervis 06.02.2011
		ib_select11 = arg_select
	case 'tabpage_email'					//Added By Mark Lee 02/05/2013
		ib_select12 = arg_select		
	case 'All'
		ib_select1 = arg_select
		ib_select2 = arg_select
		ib_select3 = arg_select
		ib_select4 = arg_select
		ib_select5 = arg_select
		ib_select6 = arg_select
		ib_select7 = arg_select
		ib_select8 = arg_select
		ib_select9 = arg_select
		ib_select10 = arg_select
		ib_select11 = arg_select
		ib_select12 = arg_select
End choose



end subroutine

public subroutine of_reset_det_retrived_status ();//////////////////////////////////////////////////////////////////////
// $<function>u_tab_contract_detailsof_reset_det_retrived_status()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 09.18.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
this.tabpage_details.uo_1.event ue_reset_ib_retrieve( )
this.tabpage_details.event ue_reset_ib_retrieve( )

end subroutine

public function integer of_refreshdocument ();//////////////////////////////////////////////////////////////////////
// $<function>  of_refreshdocument
// $<arguments> (None)
// $<returns>   integer
// $<description> Refresh document after batch import
//////////////////////////////////////////////////////////////////////
// $<add> 12/08/2008 by Evan
//////////////////////////////////////////////////////////////////////

ib_select9 = false
if ii_Index = 9 then	
	this.Event SelectionChanged(1, 9)
else
	Return -1
end if

Return 1
end function

public subroutine of_refresh_group ();If ib_select2 Then
	This.tabpage_details.uo_1.tab_1.tabpage_group_access.of_refresh_group()
End If
end subroutine

public subroutine of_openctxworkflowstep (long al_oldindex, long al_newindex);//====================================================================
// Function: of_OpenCtxWorkFlowStep()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_OldIndex
// 	value    long    al_NewIndex
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-08-31
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Cycle,ll_RowCnts
long	ll_Location,ll_Cnts
long	ll_ctx_id

//Commented By Ken.Guo 11/07/2012
//if al_NewIndex = al_OldIndex then Return

choose case al_NewIndex
	case 1
		ll_Location = 1
	case 2
		ll_Location = 4
	case 3
		ll_Location = 20
	case 4
		ll_Location = 24
	case 5
		ll_Location = 29
	case 6
		ll_Location = 34
	case 7
		ll_Location = 39
	case 8
		ll_Location = 47
	case 9
		ll_Location = 49
	case 10
		ll_Location = 59
	case 11
		//ll_Location = 0
	case 12
		ll_Location = 62					
end choose

ll_ctx_id = tabpage_search.il_ctx_id

SELECT Count(*)
  INTO :ll_Cnts
  FROM ctx_action_items,wf_action_types
 WHERE ctx_action_items.wf_id = wf_action_types.wf_id and 
       ctx_action_items.wf_action_type_id = wf_action_types.step_id and
       ctx_action_items.ctx_id = :ll_ctx_id and
       ctx_action_items.action_user = :gs_user_id and
		 wf_action_types.DisplayLocation = :ll_Location and
       ctx_action_items.active_status >= 0 and
       ctx_action_items.wf_complete_flag <> 'Y';



//Added By Ken.Guo 11/07/2012
if IsValid(w_ctxwfstepstatus) then
	Close(w_ctxwfstepstatus)
End If

if ll_Cnts > 0 then
	//if IsValid(w_ctxwfstepstatus) then
	//	Show(w_ctxwfstepstatus)
	//else
		Open(w_ctxwfstepstatus)
	//end if
end if

end subroutine

public subroutine of_create_menu_item ();//====================================================================
// Function: of_create_menu_item
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/21/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 			ll_rowcount, i , ll_id, ll_tmp, ll_bound, ll_difference, j , k 
String 		ls_tempaltes_name, ls_item[]
menu 		lm_create[], lm_delete[]
Long 			ll_find,ll_find_item, ll_cnt
Boolean		lbn_template

If IsValid(m_pfe_cst_mdi_menu_contract_am) Then 

	this.tabpage_search.of_create_templates_list()
	lbn_template = m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.enabled
	ll_rowcount  =	this.tabpage_search.ids_templates_list.rowcount()
	ll_bound =  upperbound(m_pfe_cst_mdi_menu_contract_am.m_contract0.item[])
	If ll_rowcount > 0  Then 
		If ll_bound >= 9 Then
			For i = 9 to ll_bound step 1 
				m_pfe_cst_mdi_menu_contract_am.m_contract0.item[i].visible = False
			Next
		End If
		
		//create the item
		For i = 1 to ll_rowcount
			lm_create[i] = Create  m_menu_create_item_child
			ls_tempaltes_name =this.tabpage_search.ids_templates_list.GetItemString(i,'template_name')		
			If Isnull(ls_tempaltes_name) Then 
				ls_tempaltes_name = ''
			End If 
			ll_id 		= this.tabpage_search.ids_templates_list.GetItemNumber(i,'id')		
			ll_tmp = ll_bound + i 
			lm_create[i].text = ls_tempaltes_name
			lm_create[i].tag = string(ll_id)
			lm_create[i].visible = True
			m_pfe_cst_mdi_menu_contract_am.m_contract0.item[ll_tmp]= lm_create[i]
			m_pfe_cst_mdi_menu_contract_am.m_contract0.item[ll_tmp].tag = string(ll_id)
			m_pfe_cst_mdi_menu_contract_am.m_contract0.item[ll_tmp].visible =True
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.item[ll_tmp],'enabled', lbn_template)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.item[ll_tmp],'toolbaritemOrder', ll_tmp)				
		Next 		
				
		m_pfe_cst_mdi_menu_contract_am.m_contract0.hide()
		m_pfe_cst_mdi_menu_contract_am.m_contract0.show()
	Else
		//clear the delete module item
		If ll_bound >= 9 then 
			For i = 9 to ll_bound step 1 
				m_pfe_cst_mdi_menu_contract_am.m_contract0.item[i].visible = False
			Next
		End If
		m_pfe_cst_mdi_menu_contract_am.m_contract0.hide()				//Added By Mark Lee 12/17/2012
		m_pfe_cst_mdi_menu_contract_am.m_contract0.show()
	End If
End If

end subroutine

event selectionchanging;call super::selectionchanging;
/******************************************************************************************************************
**  [PUBLIC]   : event selectionchanging( /*integer oldindex*/, /*integer newindex */)
**==================================================================================================================
**  Purpose   	: This will trigger the ue_selectionchanging event on then currrent tab page. Wich will trigger the
**                pfc_validation  event. If the validation should fail the user will not be allowed to 
**                to change the tab untill the rewuired columns have data
**=================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long li_rc 
u_tabpg_contract_master	lu_tabpg

if Not IsValid(gw_contract) then Return 0 //Add by Evan 10/29/2008

SetPointer(HourGlass!) //Alfee 10.17.2008


if iw_parent.function dynamic wf_get_save_status() = false then
		If oldindex > 0 Then
			if oldindex <> newindex then	//Fix bug -- jervis 12.15.2010
				// get the current tab page index
				lu_tabpg = of_GetTabPage (oldindex)
				li_rc = lu_tabpg.Event ue_selectionchanging()
				// special case - tab in a tab
			else
				li_rc = 0
			end if
			if oldindex = 2 then
				//if this.tabpage_details.tab_1.tabpage_1.dw_1.event pfc_validation( ) = failure then
	          //  return 1 			
			   //end if	
			end if
		End If
end if

//Commented By Ken.Guo 2010-06-03. Otherwise FullTextSearch Error.
////Added By Ken.Guo 2009-08-27. To Refresh menu. Otherwise it will don't show contract menu when switch from other window
//If li_rc = 1 Then 
//	This.event selectionchanged( oldindex, oldindex)
//End If

if li_rc = 0 and oldindex <> newindex then //Fixed bug - jervis 12.07.2010
	//present the user with a "Changes have been made,  Save changes Yes/No"  message
	If Isvalid(m_pfe_cst_mdi_menu_contract) and oldindex <> newindex Then //Add oldindex <> newindex, APB Bug - jervis 11.19.2010
		if m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = true and oldindex <> 1 then
			if appeongetclienttype()="WEB" and oldindex = 9 and Isvalid(m_pfe_cst_mdi_menu_contract_am) then //(Appeon)Harry 12.08.2015 - APB Bug - for Database Error After "Save" Prompt Following Deletion Of Workflow Steps Then Deletion Of Document
			else
				if MessageBox('Save','Changes have been made,  Save changes?',Question!,YesNo!) = 1 then
					iw_parent.event dynamic ue_save()
				end if
			end if
		end if
	end if
end if

Return li_rc

end event

event selectionchanged;call super::selectionchanged;/******************************************************************************************************************
**  [PUBLIC]   :event selectionchanged( /*integer oldindex*/, /*integer newindex */)
**==================================================================================================================
**  Purpose   	: trigger ue_selectionchanged event on u_tabpg. Process Return Code. Which will run of_retrieve
**					- to retrieve the data for the tab
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  ModIfication Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long	ll_Right

u_tabpg_contract_master	lu_tabpg

if NewIndex <> OldIndex and IsValid(w_ctxwfstepstatus) then
	//Hide(w_ctxwfstepstatus)		//Added by Scofield on 2009-08-31
	Close(w_ctxwfstepstatus)		//APB Bug - jervis 01.24.2011
end if

if not IsValid(gw_contract) then Return 1 //Add by Evan 10/29/2008
ii_Index = NewIndex //Add by Evan 12/08/2008

if IsValid(w_SearchPage_Calendar) then
	if NewIndex = 1 then
		w_SearchPage_Calendar.Show()
	else
		w_SearchPage_Calendar.Hide()
	end if
end if

//Begin - Added By Mark Lee 10/29/12
If NewIndex = 1 then
	if IsValid(w_todolist_contract) then
		w_todolist_contract.Show()
	End If			
	if IsValid(w_tabpg_contract_doc_mgr) then
		w_tabpg_contract_doc_mgr.Show()
	End If	
Else
	if IsValid(w_todolist_contract) then
		w_todolist_contract.Hide()
	End If			
	if IsValid(w_tabpg_contract_doc_mgr) then
		w_tabpg_contract_doc_mgr.Hide()
	End If	
End If
//End - Added By Mark Lee 10/29/12
//Added By Mark Lee 02/07/2013
If NewIndex = 12 then
	if IsValid(w_contract_email_folder) then
		w_contract_email_folder.Show()
		w_contract_email_folder.of_refreshdata()
	Else
		Open(w_contract_email_folder,gw_contract)
		w_contract_email_folder.of_refreshdata()
	End If			
Else
	if IsValid(w_contract_email_folder) then
		w_contract_email_folder.Hide()
	End If			
End If


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.25.2006 By: Liang QingShi
//$<reason> Contract module modIfication
setpointer(hourglass!)

//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//w_mdi.of_menu_security(w_mdi.menuname) //Added By Ken.Guo 2009-10-13. 
IF appeongetclienttype () = "PB" THEN w_mdi.SetRedraw (False) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
w_mdi.of_menu_security(w_mdi.menuname) //Added By Ken.Guo 2009-10-13. 
IF appeongetclienttype () = "PB" THEN w_mdi.SetRedraw (True) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
//---------End Modfiied ------------------------------------------------------

This.SetRedraw( false)  //Jervis 05.26.2009 --Temporary add for John's require
choose case newindex
	case 1
		If ib_select1 = false Then
			iw_parent.FUNCTION DYNAMIC	wf_manage_tabs(True)  // Add by Jack 04/19/2007
			
			this.tabpage_search.inv_contract_details.is_mode = this.tabpage_search.inv_contract_details.edit
			
			ib_select1 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_Search.Event ue_set_screen_properties()		//Added by Scofield on 2008-12-22
		iw_parent.Dynamic Post Function of_set_searchtab_menu() //Added By Ken.Guo 2010-06-24.
		
		//Refresh Fee Schedule Calculate - jervis 08.26.2010
		if this.tabpage_fee_sched2.dw_fee_nm.RowCount() > 0 then
			if long(this.tabpage_search.dw_search_det1.Describe("fee_sched_calc_field_1.x")) > 0 then
				this.tabpage_search.dw_search_det1.SetItem(this.tabpage_search.dw_search_det1.GetRow(),"fee_sched_calc_field_1",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_1"))
			end if
			if long(this.tabpage_search.dw_search_det1.Describe("fee_sched_calc_field_2.x")) > 0 then
				this.tabpage_search.dw_search_det1.SetItem(this.tabpage_search.dw_search_det1.GetRow(),"fee_sched_calc_field_2",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_2"))
			end if
			if long(this.tabpage_search.dw_search_det1.Describe("fee_sched_calc_field_3.x")) > 0 then
				this.tabpage_search.dw_search_det1.SetItem(this.tabpage_search.dw_search_det1.GetRow(),"fee_sched_calc_field_3",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_3"))
			end if
		end if
		
	case 2
		If ib_select2 = false Then
			tabpage_details.uo_1.of_change_screen_detail()
			ib_select2 = true
			tabpage_details.uo_1.Event ue_set_tabpage_properties() //Jervis 08.17.2010
		End If
		
		//Begin - Added By Mark Lee 06/18/12 APB BUG
		If isvalid(gw_contract) Then
			gw_contract.wf_set_tabs_icon()
		End If 
		//End - Added By Mark Lee 06/18/12
			
		//Refresh Fee Schedule Calculate - jervis 08.26.2010
		if this.tabpage_fee_sched2.dw_fee_nm.RowCount() > 0 then
			if long(this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Describe("fee_sched_calc_field_1.x")) > 0 then
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItem(1,"fee_sched_calc_field_1",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_1"))
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItemStatus(1,"fee_sched_calc_field_1",Primary!,NotModified!)
			end if
			if long(this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Describe("fee_sched_calc_field_2.x")) > 0 then
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItem(1,"fee_sched_calc_field_2",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_2"))
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItemStatus(1,"fee_sched_calc_field_2",Primary!,NotModified!)
			end if
			if long(this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Describe("fee_sched_calc_field_3.x")) > 0 then
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItem(1,"fee_sched_calc_field_3",this.tabpage_fee_sched2.dw_fee_nm.GetItemDecimal(1,"calc_field_3"))
				this.Tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.SetItemStatus(1,"fee_sched_calc_field_3",Primary!,NotModified!)
			end if
		end if
		
	case 3
		If ib_select3 = false Then
			tabpage_requirements.ib_retrieved = false
			tabpage_requirements.of_create_dw()
			
			tabpage_requirements.dw_2.ib_retrieve_drop_downs = false
			tabpage_requirements.dw_2.event ue_populatedddws( )
			ib_select3 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_requirements.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
		//tabpage_requirements.dw_req_det.Post Setfocus() //Added By Ken.Guo 2009-07-24.		//Commented by Scofield on 2010-03-22
	case 4
		If ib_select4 = false Then
			tabpage_contacts.ib_retrieved = false
			tabpage_contacts.of_create_dw()
			tabpage_contacts.dw_search.ib_retrieve_drop_downs = false
			tabpage_contacts.dw_search.event ue_populatedddws( )
			
			tabpage_contacts.dw_detail.ib_retrieve_drop_downs = false
			tabpage_contacts.dw_detail.event ue_populatedddws( )
			
			tabpage_contacts.dw_phone.ib_retrieve_drop_downs = false
			tabpage_contacts.dw_phone.event ue_populatedddws( )
			
			tabpage_contacts.dw_notes.ib_retrieve_drop_downs = false
			tabpage_contacts.dw_notes.event ue_populatedddws( )
			ib_select4 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_contacts.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
	case 5
		If ib_select5 = false Then
			tabpage_locations.ib_retrieved = false
			tabpage_locations.of_create_dw()
			tabpage_locations.dw_doctors.ib_retrieve_drop_downs = false
			tabpage_locations.dw_doctors.event ue_populatedddws( )
			
			tabpage_locations.dw_spec.ib_retrieve_drop_downs = false
			tabpage_locations.dw_spec.event ue_populatedddws( )
			
			tabpage_locations.dw_main.ib_retrieve_drop_downs = false
			tabpage_locations.dw_main.event ue_populatedddws( )
			
			tabpage_locations.dw_detail.ib_retrieve_drop_downs = false
			tabpage_locations.dw_detail.event ue_populatedddws( )
			ib_select5 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_locations.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
	case 6
		If ib_select6 = false Then
			tabpage_orgabizations.ib_retrieved = false
			tabpage_orgabizations.of_create_dw()
			tabpage_orgabizations.dw_main.ib_retrieve_drop_downs = false
			tabpage_orgabizations.dw_main.event ue_populatedddws( )
			
			tabpage_orgabizations.dw_contacts.ib_retrieve_drop_downs = false
			tabpage_orgabizations.dw_contacts.event ue_populatedddws( )
			
			tabpage_orgabizations.dw_search.ib_retrieve_drop_downs = false
			tabpage_orgabizations.dw_search.event ue_populatedddws( )
			
			tabpage_orgabizations.dw_notes.ib_retrieve_drop_downs = false
			tabpage_orgabizations.dw_notes.event ue_populatedddws( )
			
			ib_select6 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_orgabizations.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
	case 7		
		If ib_select7 = false Then
			tabpage_fee_schedules.ib_retrieved = false
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.ib_retrieved = false
		   tabpage_fee_schedules.of_create_dw()
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.ib_retrieve_drop_downs = false
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_main.event ue_populatedddws( )
			
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_locations.ib_retrieve_drop_downs = false
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_locations.event ue_populatedddws( )
			
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.ib_retrieve_drop_downs = false
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_fee_schedule.event ue_populatedddws( )
			
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_codes.ib_retrieve_drop_downs = false
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_codes.event ue_populatedddws( )
			
			tabpage_fee_schedules.tab_1.tabpage_fee_notes.dw_1.ib_retrieve_drop_downs = false
			tabpage_fee_schedules.tab_1.tabpage_fee_notes.dw_1.event ue_populatedddws( )
			
			ib_select7 = true
			
			tabpage_fee_schedules.Event ue_set_tabpage_properties() //Jervis by 08.17.2010
		End If
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-09-27 By: Liu Hongxin
		//$<reason> New Required.
		If IsValid(tabpage_locations) Then
			tabpage_fee_schedules.tab_1.tabpage_fee_browse.dw_locations.Event ue_populatedddw_location(tabpage_locations.dw_detail)
		End If
		//---------------------------- APPEON END ----------------------------
		
		//Comment by jervis - 08.17.2010
		/*
		gw_contract.SetRedraw(false) //Add by Evan 10/15/2008
		tabpage_fee_schedules.Event ue_set_tabpage_properties() //Add by Evan 07/17/2008
		tabpage_fee_schedules.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
		gw_contract.SetRedraw(true) //Add by Evan 10/15/2008
		*/
	case 8
		If ib_select8 = false Then
			tabpage_fee_sched2.ib_retrieved = false
		   tabpage_fee_sched2.of_create_dw()
			tabpage_fee_sched2.dw_fee_nm.ib_retrieve_drop_downs = false
			tabpage_fee_sched2.dw_fee_nm.event ue_populatedddws( )
						
			ib_select8 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_fee_sched2.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
	case 9
		tabpage_images.SetRedraw( false )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 11.06.2008 By: Ken.Guo
		//$<reason> OCXs Check
		If Not ib_showed Then
			gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office
			ib_showed = True
		End If
		//---------------------------- APPEON END ----------------------------			
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 10/05/2007 By: Jervis
		//$<reason> Fixed a defect
		if oldindex = 1 or tabpage_images.inv_contract_details.of_get_old_ctx_id( ) <> tabpage_images.inv_contract_details.of_get_ctx_id( ) then
			tabpage_images.tab_1.tabpage_data.tab_1.selectedtab = 1
			If  tabpage_images.inv_contract_details.of_get_old_ctx_id( ) <> tabpage_images.inv_contract_details.of_get_ctx_id( )  Then tabpage_images.ib_retrieved = false //add by gavins 20120215
			tabpage_images.inv_contract_details.of_set_old_ctx_id(tabpage_images.inv_contract_details.of_get_ctx_id( ) ) 
		end if
		//---------------------------- APPEON END ----------------------------

		If ib_select9 = false Then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<comment> 01.17.2007 By: Frank.Gui
			//$<reason> Supporint Document is changed to Document Manager.
			/*
			tabpage_images.ib_retrieved = false
			tabpage_images.tab_1.tabpage_browse.ib_retrieved = false
		   tabpage_images.of_create_dw()
			tabpage_images.tab_1.tabpage_browse.dw_1.ib_retrieve_drop_downs = false
		   tabpage_images.tab_1.tabpage_browse.dw_1.event ue_populatedddws( )
			*/
			//---------------------------- APPEON END ----------------------------

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 01.17.2007 By: Frank.Gui
			//$<reason> 
			tabpage_images.ib_retrieved = false
			tabpage_images.tab_1.tabpage_data.ib_retrieved = false
			tabpage_images.tab_1.tabpage_action.ib_retrieved = false
			//tabpage_images.tab_1.tabpage_audit.ib_retrieved = false
			//---------------------------- APPEON END ----------------------------

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 04.18.2007 By: Jack
			//$<reason> 
		   tabpage_images.of_create_dw()
			tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter.ib_retrieve_drop_downs = false
		   tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter.event constructor( )
	
			//Added By Ken.Guo 04/01/2012. 
			tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.ib_retrieve_drop_downs = false
			tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.event constructor()

			
			//Start Code By Jervis 01.17.2008
			//Fixed BugJ011603
			tabpage_images.tab_1.tabpage_action.dw_filter.ib_retrieve_drop_downs = false
		   tabpage_images.tab_1.tabpage_action.dw_filter.event constructor( )
			tabpage_images.tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.ib_retrieve_drop_downs = false
		   tabpage_images.tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.event constructor( )	
			tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.ib_retrieve_drop_downs = false
		   tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.event constructor( )	
			//tabpage_images.tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.ib_retrieve_drop_downs = false
		   //tabpage_images.tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.event constructor( )
			
			tabpage_images.tab_1.Post Event SelectionChanged(1,1)			//Added by Scofield on 2010-05-11
	
			//End Code By Jervis 01.17.2008

			//---------------------------- APPEON END ----------------------------
			
			ib_select9 = true
			tabpage_images.Event ue_set_tabpage_properties() //Jervis 08.17.2010
		End If
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.09.2007 By: Davis
		//$<reason> Fix a defect.
		/*IF Isvalid(tabpage_images.tab_1.tabpage_browse.dw_1) THEN
			IF tabpage_images.tab_1.tabpage_browse.dw_1.Rowcount( ) > 0 THEN
				tabpage_images.tab_1.tabpage_browse.dw_1.event rowfocuschanged( tabpage_images.tab_1.tabpage_browse.dw_1.getrow() )
			END IF
		END IF		*/
		//---------------------------- APPEON END ----------------------------
		tabpage_images.Event ue_show_constructor() 
		tabpage_images.Post SetRedraw( true )
		//Comment by jervis - 08.17.2010
		/*
		gw_contract.SetRedraw(false) //Add by Evan 10/15/2008
		tabpage_images.Event ue_set_tabpage_properties() //Add by Evan 07/17/2008
		tabpage_images.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
		gw_contract.SetRedraw(true) //Add by Evan 10/15/2008
		*/
	case 10
		If ib_select10 = false Then
			tabpage_action_items.ib_retrieved = false
		   tabpage_action_items.of_create_dw()
			
			tabpage_action_items.tab_1.tabpage_browse.dw_1.ib_retrieve_drop_downs = false
			tabpage_action_items.tab_1.tabpage_browse.dw_1.event ue_populatedddws( )

			tabpage_action_items.tab_1.tabpage_detail.dw_1.ib_retrieve_drop_downs = false
			tabpage_action_items.tab_1.tabpage_detail.dw_1.event ue_populatedddws( )
			
			Tabpage_action_items.tab_1.tabpage_browse.of_ShowHideSearch(false)		//Added by Scofield on 2010-05-12
			Tabpage_action_items.tab_1.tabpage_detail.of_ShowHideSearch(false)		//Added by Scofield on 2010-05-12
			
			ib_select10 = true
		End If
		//Comment by jervis - 08.17.2010
		//tabpage_action_items.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
	case 11  //Add custom multi data screen - jervis 05.31.2011
		if ib_select11 = false then
			tabpage_multi.ib_retrieved = false
			tabpage_multi.tab_multi.tabpage_header.ib_retrieved = false
			tabpage_multi.of_create_dw()
			ib_select11 = true
			
			//Added By Ken.Guo 06/13/2012. Retrieve DDDW data after open again.
			tabpage_multi.tab_multi.tabpage_header.dw_header.ib_retrieve_drop_downs = False
			tabpage_multi.tab_multi.tabpage_detail.dw_browse.ib_retrieve_drop_downs = False
			tabpage_multi.tab_multi.tabpage_detail.dw_detail.ib_retrieve_drop_downs = False
			
		end if
	case 12			//Added By Mark Lee 02/05/2013
			if ib_select12 = false then
				ib_select12 = true
			End If 
		/*
		comment by jervis 05.31.2011
		If ib_select12 = false Then
			tabpage_qrg.ib_retrieved = false
			tabpage_qrg.tab_1.tabpage_selection.ib_retrieved = false
		   tabpage_qrg.of_create_dw()
			ib_select12 = true
			tabpage_qrg.Event ue_set_tabpage_properties() //Jervis 08.17.2010
		End If
		*/
		//Comment by jervis - 08.17.2010
		/*
		gw_contract.SetRedraw(false) //Add by Evan 10/15/2008
		tabpage_qrg.Event ue_set_tabpage_properties() //Add by Evan 07/17/2008
		tabpage_qrg.Event ue_set_screen_properties()  //Add by Evan 07/22/2008
		gw_contract.SetRedraw(true) //Add by Evan 10/15/2008
		*/
End choose

//---------------------------- APPEON End ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.30.2007 By: Jack
//$<reason> Fix a defect.
If newindex =  3 Then 
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', False)
	End If
Else
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'enabled', True)
	End If
End If	
//---------------------------- APPEON END ----------------------------


If iw_parent.function dynamic wf_get_save_status() = false Then
	If newindex > 0 Then
		lu_tabpg = of_GetTabPage (newindex)
		lu_tabpg.ib_retrieved = false //add by stephen 05.31.2013 --Bug 3548  //(Appeon)Harry 06.07.2013 - V141 ISG-CLX
		lu_tabpg.Event ue_selectionchanged ()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 05.09.2006 By: Liang QingShi
		//$<reason> Fix a defect.
		lu_tabpg.SetFocus()
		//---------------------------- APPEON End ----------------------------
	End If
End If
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.22.2007 By: Jack (Document Manager)
//$<reason> 
ib_select = True
tabpage_images.ib_browse = False
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////
// code added to fix get focus issue
/////////////////////////////////////////////////////////////////////
If newindex =  9 Then 
  //this.tabpage_images.tab_1.SelectedTab = 1
  //fix	this.tabpage_images.tab_details.tabpage_image.tab_1.SelectedTab = 1
  
  //--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 01.17.2007 By: Frank.Gui
	//$<reason> 
	//this.tabpage_images.tab_1.tabpage_browse.dw_1.setfocus( )
	//---------------------------- APPEON END ----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.17.2007 By: Frank.Gui
	//$<reason> 
	IF appeongetclienttype () = "PB" THEN w_mdi.SetRedraw (False) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
	w_mdi.changemenu( m_pfe_cst_mdi_menu_contract_am)
	w_mdi.of_menu_security('m_pfe_cst_mdi_menu_contract_am')

	of_create_menu_item()			//Added By Mark Lee 12/18/2012

	//BEGIN---Modify by Scofield on 2010-03-30
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		if IsValid(m_pfe_cst_mdi_menu_contract_am) then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		end if
	end if
	//END---Modify by Scofield on 2010-03-30
	IF appeongetclienttype () = "PB" THEN w_mdi.SetRedraw (True) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
	
	//tabpage_images.event ue_set_security() - commented by alfee 11.04.2008
	//---------------------------- APPEON END ----------------------------
	
	//BEGIN---Modify by Scofield on 2009-07-14
	if tabpage_images.tab_1.SelectedTab = 1 and tabpage_images.tab_1.tabpage_data.tab_1.SelectedTab = 2 then
		
		//Added By Ken.Guo 02/08/2012. 
		If tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.uo_2.visible Then
			tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.uo_2.uo_toolbar.Post SetFocus()				
		End If
		
		if IsValid(w_DocWFStepStatus) then
			Show(w_DocWFStepStatus)
		else
			Open(w_DocWFStepStatus)
		end if
	end if
	//END---Modify by Scofield on 2009-07-14
		
	tabpage_images.of_settingfiltertoolbar( ) //Added By Ken.Guo 2010-07-26.
else
	//if IsValid(w_DocWFStepStatus) then Hide(w_DocWFStepStatus)		//Added by Scofield on 2009-07-14
	if IsValid(w_DocWFStepStatus) then close(w_DocWFStepStatus)		//APB Bug - jervis 01.24.2011
	//Added By Mark Lee 12/18/2012
	//If isvalid(this.tabpage_search ) Then 
	If isvalid(this.tabpage_search ) and not ( oldindex = 1 and newindex =  2) Then  //(Appeon)Harry 09.12.2014 - for BugH061201
		this.tabpage_search.of_create_menu_item( )
	End if
End If

//Added By Ken.Guo 2010-07-26.
If newindex = 10 Then
	tabpage_action_items.of_setfiltertoolbar()
End If

//(Appeon)Harry 12.20.2013 - V141 for BugH112902 of IntelliContract History Issues
If newindex = 11 Then
	tabpage_multi.of_tabpage_setfocus()
End If

//Added By Mark Lee 02/17/2013
IF newindex = 12 Then
	w_mdi.changemenu( m_pfe_cst_mail)
	w_mdi.of_menu_security('m_pfe_cst_mail')
End IF 

//-------Begin Added by Alfee 09.30.2007--------------
//Security Control, moved from retrievestart event of u_dw_contract
lu_tabpg = of_GetTabPage (newindex)
w_mdi.SetRedraw (False) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
lu_tabpg.event ue_set_security( )
w_mdi.SetRedraw (True) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
//-------End Added -----------------------------------

//Added By Ken.Guo 2009-08-17.
w_mdi.SetRedraw (False) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 
If Isvalid(m_pfe_cst_mdi_menu_contract) Then
	If This.Selectedtab = 2 and w_mdi.of_security_access( 6956 ) > 0 Then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_saveas,'toolbaritemvisible', True)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_saveas,'toolbaritemvisible', False)
	End If
	If This.Selectedtab = 1 and  w_mdi.of_security_access( 6978 ) > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_display,'toolbaritemvisible', True)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_display,'toolbaritemvisible', False)
	End If
	//Added By Ken.Guo 2011-06-14.  Show Copy CTX menu
	If This.Selectedtab = 1 Then
		If w_mdi.of_security_access( 6989 ) = 1 Then //Added By Ken.Guo 04/17/2013
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', True)
		End If
//	//Begin - Added By Mark Lee 11/21/2012
//		m_pfe_cst_mdi_menu_contract.m_contract0.visible = True		
//		m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record.enabled = True
//		m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record.enabled = True
//	Else
//		m_pfe_cst_mdi_menu_contract.m_contract0.visible = False 
//	//End - Added By Mark Lee 11/21/2012					//Commented By Mark Lee 12/17/2012
	End If 
End IF
w_mdi.SetRedraw (True) //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX 

//Added by Nova on 2008-08-13
//dashboard
IF newindex <> 1 THEN
	IF Not IsValid(gnv_dashboard_data) THEN gnv_dashboard_data = Create n_cst_dashboard_data
	gnv_dashboard_data.of_update_gadgets_recent( 'CTX', tabpage_search.il_ctx_id, 0)
END IF

//Added By Ken.Guo 03/12/2012.  Refresh some DDDW data
If newindex = 1 and oldindex = 2 Then
	If This.tabpage_details.uo_1.ib_added_code_lookup Then
		This.tabpage_search.dw_search.event ue_refresh_some_dddw( )
		This.tabpage_details.uo_1.ib_added_code_lookup = False
	End If
End If

This.SetRedraw( true)  //Jervis 05.26.2009 --Temporary add for John's require

of_OpenCtxWorkFlowStep(OldIndex,NewIndex)

If newindex = 9 Then//added by gavins 20120802
	tabpage_images.post of_Setdwfocus( )
	
end if
Return success

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.25.2006 By: Liang QingShi
//$<reason> Contract module modification
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
datawindow ld_dw[]
gi_contract_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))

IF Isnull(gi_contract_view_id) OR  gi_contract_view_id = 0 THEN gi_contract_view_id = 1001 // Fix a defect. by davis 11.22.2006

of_tab_visible(gi_contract_view_id)
//---------------------------- APPEON END ----------------------------
end event

on u_tab_contract_details.create
this.tabpage_search=create tabpage_search
this.tabpage_details=create tabpage_details
this.tabpage_requirements=create tabpage_requirements
this.tabpage_contacts=create tabpage_contacts
this.tabpage_locations=create tabpage_locations
this.tabpage_orgabizations=create tabpage_orgabizations
this.tabpage_fee_schedules=create tabpage_fee_schedules
this.tabpage_fee_sched2=create tabpage_fee_sched2
this.tabpage_images=create tabpage_images
this.tabpage_action_items=create tabpage_action_items
this.tabpage_multi=create tabpage_multi
this.tabpage_email=create tabpage_email
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_search
this.Control[iCurrent+2]=this.tabpage_details
this.Control[iCurrent+3]=this.tabpage_requirements
this.Control[iCurrent+4]=this.tabpage_contacts
this.Control[iCurrent+5]=this.tabpage_locations
this.Control[iCurrent+6]=this.tabpage_orgabizations
this.Control[iCurrent+7]=this.tabpage_fee_schedules
this.Control[iCurrent+8]=this.tabpage_fee_sched2
this.Control[iCurrent+9]=this.tabpage_images
this.Control[iCurrent+10]=this.tabpage_action_items
this.Control[iCurrent+11]=this.tabpage_multi
this.Control[iCurrent+12]=this.tabpage_email
end on

on u_tab_contract_details.destroy
call super::destroy
destroy(this.tabpage_search)
destroy(this.tabpage_details)
destroy(this.tabpage_requirements)
destroy(this.tabpage_contacts)
destroy(this.tabpage_locations)
destroy(this.tabpage_orgabizations)
destroy(this.tabpage_fee_schedules)
destroy(this.tabpage_fee_sched2)
destroy(this.tabpage_images)
destroy(this.tabpage_action_items)
destroy(this.tabpage_multi)
destroy(this.tabpage_email)
end on

event pfc_postupdate;call super::pfc_postupdate;//$<add> 09.17.2010 By: Jervis
//$<reason> Trigger work flow by Contract Logix data value comparision
long ll_screen_id[], ll_empty[]
string ls_updateCol[], ls_empty[]
integer li_i,li_count
Long					ll_category,ll_ctx_id					//Added By Mark Lee 12/07/2012
datawindow 		ld_dw										//Added By Mark Lee 12/07/2012

If gb_workflow Then
	li_count = UpperBound(this.tabpage_details.uo_1.il_screen_id)
	if li_count > 0 then
		ll_screen_id = this.tabpage_details.uo_1.il_screen_id
		ls_updateCol = this.tabpage_details.uo_1.is_updatecol
	end if
	li_count = Upperbound(this.tabpage_fee_sched2.il_screen_id )
	if li_count > 0 then
		for li_i = 1 to li_count
			ll_screen_id[Upperbound(ll_screen_id) + 1] = this.tabpage_fee_sched2.il_screen_id[li_i]
			ls_updateCol[this.tabpage_fee_sched2.il_screen_id[li_i]] = this.tabpage_fee_sched2.is_updatecol[this.tabpage_fee_sched2.il_screen_id[li_i]]
		next
	end if
	
	li_count = UpperBound(this.Tabpage_action_items.il_screen_id)
	if li_count > 0 then
		for li_i = 1 to li_count
			ll_screen_id[Upperbound(ll_screen_id) + 1] = this.Tabpage_action_items.il_screen_id[li_i]
			ls_updateCol[this.Tabpage_action_items.il_screen_id[li_i]] = this.Tabpage_action_items.is_updatecol[this.Tabpage_action_items.il_screen_id[li_i]]
		next
	end if
	
	if UpperBound(ll_screen_id) > 0 then
		n_cst_workflow_triggers lnv_workflow
		lnv_workflow = create n_cst_workflow_triggers
		
		lnv_workflow.of_data_value_comparision(gi_contract_view_id, ll_screen_id, ls_updateCol,tabpage_search.il_ctx_id, 0, '03', 'I')
		Destroy lnv_workflow
		
		//Reset is_updatecol[] for all screens. Added by Ken.Guo 2011-08-20
		this.tabpage_details.uo_1.il_screen_id[] = ll_empty[]
		this.tabpage_details.uo_1.is_updatecol[] = ls_empty[]
		this.tabpage_fee_sched2.il_screen_id[] = ll_empty[]
		this.tabpage_fee_sched2.is_updatecol[] = ls_empty[]
		this.Tabpage_action_items.il_screen_id[] = ll_empty[] 
		this.Tabpage_action_items.is_updatecol[] = ls_empty[]		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2009-01-14 By: Scofield
		//$<Reason> Reset ib_retrieved variable to refresh action items
		
		if IsValid(gw_contract) then
			if IsValid(gw_contract.tab_contract_details) then
				if IsValid(gw_contract.tab_contract_details.tabpage_action_items) then
					gw_contract.tab_contract_details.tabpage_action_items.ib_retrieved = false
					//Refresh data when action item tab is selected.
					if this.selectedtab = 10 then this.tabpage_action_items.of_retrieve( )
				end if
				//Begin - Added By Mark Lee 12/07/2012
				If IsValid(gw_contract.tab_contract_details.tabpage_details) then
					If IsValid(gw_contract.tab_contract_details.tabpage_details) then
						If gw_contract.tab_contract_details.tabpage_details.uo_1.ibn_sync_category = True Then
							gw_contract.tab_contract_details.tabpage_details.uo_1.ibn_sync_category = False				//reset value
							
							ld_dw = gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1
							ll_category = ld_dw.GetItemNumber(ld_dw.GetRow(),'category')
							ll_ctx_id = gw_contract.tab_contract_details.tabpage_details.uo_1.il_ctx_id
							
							//sync category values
							Update ctx_am_document
							set category = :ll_category
							Where ctx_id = :ll_ctx_id ;

						End If
					End If
				End If
				//End - Added By Mark Lee 12/07/2012
			end if
		end if
		//---------------------------- APPEON END ----------------------------


	end if
End If


return 1

end event

type tabpage_search from u_tabpg_contract_search within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
integer taborder = 10
long picturemaskcolor = 12632256
string powertiptext = "Contract Search"
end type

type tabpage_details from u_tabpg_contract_det within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_requirements from u_tabpg_contract_requirements within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_contacts from u_tabpg_contract_contact within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
string text = "Other Contacts"
long picturemaskcolor = 12632256
string powertiptext = "Other Contacts"
end type

type tabpage_locations from u_tabpg_contract_locations within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
string powertiptext = "Locations"
end type

type tabpage_orgabizations from u_tabpg_contract_organizations within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_fee_schedules from u_tabpg_contract_fee_schedules within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_fee_sched2 from u_tabpg_contract_fee_sched2 within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_images from u_tabpg_dm_manager within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
string text = "Document Manager"
long picturemaskcolor = 12632256
string powertiptext = "Document Manager"
end type

type tabpage_action_items from u_tabpg_contract_action_items within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
long picturemaskcolor = 12632256
end type

type tabpage_multi from u_tabpg_contract_multi within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
end type

type tabpage_email from u_tabpg_contract_email within u_tab_contract_details
integer x = 18
integer y = 100
integer width = 3959
integer height = 2020
string text = "Email Manager"
string powertiptext = "Email Manager"
end type

