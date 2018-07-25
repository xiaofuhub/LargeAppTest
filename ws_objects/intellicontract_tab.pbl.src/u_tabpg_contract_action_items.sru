$PBExportHeader$u_tabpg_contract_action_items.sru
$PBExportComments$[intellicontract_tab] The contract locations Tab Page
forward
global type u_tabpg_contract_action_items from u_tabpg_contract_master
end type
type tab_1 from u_tab_action_items_det within u_tabpg_contract_action_items
end type
type tab_1 from u_tab_action_items_det within u_tabpg_contract_action_items
end type
end forward

global type u_tabpg_contract_action_items from u_tabpg_contract_master
integer width = 3922
integer height = 2080
long backcolor = 33551856
string text = "Action Items"
string powertiptext = "Action Items"
event ue_set_screen_properties ( )
tab_1 tab_1
end type
global u_tabpg_contract_action_items u_tabpg_contract_action_items

type variables


n_ds ids_get_default_address
str_pass lstr_pass 
boolean ib_open_window

//Add by jervis 09.17.2010
integer il_screen_id[]
string is_UpdateCol[]
end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
public subroutine of_setfiltertoolbar ()
public subroutine of_goto_row (long al_ctx_id, long al_ai_id, string as_column)
end prototypes

event ue_set_screen_properties();// Set screen properties
tab_1.tabpage_browse.Event ue_set_screen_properties()
tab_1.tabpage_detail.Event ue_set_screen_properties()

// Set tabpage properties
tab_1.tabpage_browse.backcolor = this.backcolor
tab_1.tabpage_browse.tabbackcolor = this.backcolor
tab_1.tabpage_detail.backcolor = this.backcolor
tab_1.tabpage_detail.tabbackcolor = this.backcolor

end event

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if not ib_retrieved then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: LeiWei
	//$<reason> Fix a defect.
	/*
	dw_1.event pfc_retrieve( )
	*/
	
	tab_1.tabpage_detail.of_retrieve( )
	
	tab_1.tabpage_detail.dw_1.Sharedata( tab_1.tabpage_browse.dw_1 )
	
	//---------------------------- APPEON END ----------------------------
end if

ib_retrieved = true

RETURN SUCcess
end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_action_itemsof_create_dw()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[], ldw_protect[]
string 	ls_way[], ls_expression[]

ls_tab_name = 'tabpage_action_items'
ld_dw[1] = tab_1.tabpage_detail.dw_1
ls_dw_name[1] = 'dw_1'
ls_dataobject[1] = 'd_cntx_action_items'

ld_dw[2] = tab_1.tabpage_browse.dw_1
ls_dw_name[2] = 'dw_1'
ls_dataobject[2] = 'd_cntx_action_items_browse'

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		

//Begin - Added By Mark Lee 09/10/12
ldw_protect[1] = ld_dw[1]
If w_mdi.of_security_access(6982) = 0 then	//Modify Other Users AI		//Added By Mark Lee 04/30/2013
	ls_way[1] = 'all'
//	ls_way[1] = 'part'	
//Added By Mark Lee 05/28/2013
	//Modified By Ken.Guo 09/02/2013
	//ls_expression[1] = "if((not isnull(wf_id)) or  active_status < 0 or  wf_complete_flag = ~~'Y~~' or readonly_flag = 1  ,1,0)"
	ls_expression[1] = "if( ((not isnull(wf_id)) and wf_complete_flag = ~~'Y~~') or  active_status < 0 or readonly_flag = 1  ,1,0)"
	If f_set_datawindow_protect(ldw_protect,ls_way,ls_expression) = -1 Then
		Messagebox("IntelliContract","Set datawindow protect's property Failure!")
	End If
	//Added By Ken.Guo 09/02/2013. For ActionType
	ld_dw[1].Modify("action_type.protect='0~tif( (not isnull(wf_id))  or  active_status < 0 or readonly_flag = 1  ,1,0)' ")
End If
//End - Added By Mark Lee 09/10/12

iw_parent.function dynamic wf_set_select('tabpage_action_items',true) 

this.event ue_set_screen_properties( )  //Jervis 08.17.2010

end subroutine

public subroutine of_setfiltertoolbar ();if IsValid(m_pfe_cst_mdi_menu_contract) then
	if Tab_1.SelectedTab = 1 then
		Tab_1.tabpage_browse.dw_1.Post SetFocus()
		if Tab_1.tabpage_browse.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', True)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', False)
		end if
	else
		Tab_1.tabpage_detail.dw_1.Post SetFocus()
		if Tab_1.tabpage_detail.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', True)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', False)
		end if
	end if
end if


end subroutine

public subroutine of_goto_row (long al_ctx_id, long al_ai_id, string as_column);//====================================================================
// Function: of_goto_row
//--------------------------------------------------------------------
// Description: Go to Target Row/Column
//--------------------------------------------------------------------
// Arguments:
//                al_ctx_id
//                al_ai_id
//                as_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/04/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_find

tab_1.Selecttab(2)
ll_find = tab_1.tabpage_detail.dw_1.Find('ctx_id = ' + String(al_ctx_id) + ' and ctx_action_item_id = '+ String (al_ai_id), 1,  tab_1.tabpage_detail.dw_1.RowCount() )
If ll_find > 0 Then
	tab_1.tabpage_detail.dw_1.ScrolltoRow(ll_find)
	tab_1.tabpage_detail.dw_1.SetRow(ll_find)
	tab_1.tabpage_detail.dw_1.SetColumn(as_column)
	tab_1.tabpage_detail.dw_1.SetFocus()
End If
end subroutine

on u_tabpg_contract_action_items.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_contract_action_items.destroy
call super::destroy
destroy(this.tab_1)
end on

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.28.2006 By: Liang QingShi
//$<reason> Contract module modification
of_create_dw()
//---------------------------- APPEON END ----------------------------


ids_get_default_address = create n_ds 
ids_get_default_address.dataobject = 'd_get_default_address'
ids_get_default_address.settransobject(sqlca)

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	//Added By Mark Lee 05/07/12
	this.of_setresize( true)
	this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
	this.inv_resize.of_register( st_1,inv_resize.scalerightbottom)
	this.inv_resize.of_setminsize( 800, 600 )
end if
end event

event ue_set_security;call super::ue_set_security;//Read Only control in child tab pages - added by Alfee 09.30.2007

integer          li_index, li_count 
boolean 			  lb_protect 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = tab_1.tabpage_browse.dw_1
lwo_temp[2] = tab_1.tabpage_detail.dw_1

//Get & set read only flag at tab page level
lb_protect = inv_contract_details.of_get_protect_tabpg()

//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	if lb_protect then
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT


of_setfiltertoolbar() //Added By Ken.Guo 2010-07-26.
end event

event ue_selectionchanged;//Override - Alfee 06.16.2008

CHOOSE CASE inv_contract_details.is_mode
	CASE inv_contract_details.new
		//this.of_new( )
		 THIS.of_retrieve() //a work flow can be triggered in a new mode
	CASE inv_contract_details.edit
		 THIS.of_retrieve()

END CHOOSE

/////////////////////////////////////////////////
// adjust the menu as needed
/////////////////////////////////////////////////
w_mdi.SetReDraw (False)  //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX
inv_contract_details.of_adjust_menu(this,'')
w_mdi.SetReDraw (True)  //(Appeon)Alfee 08.02.2013 - V141 ISG-CLX


end event

event ue_initinstancevar;call super::ue_initinstancevar;ib_open_window = false
end event

event pfc_updateprep;call super::pfc_updateprep;//add By Jervis 09.17.2010
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	il_screen_id[1] = 33 // long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_action_items' and dw_name='dw_1' and dataobject='d_cntx_action_items'"))
	is_UpdateCol[il_screen_id[1]] = lnv_workflow.of_getupdatecol( tab_1.tabpage_detail.dw_1 )
	destroy lnv_workflow
end if

return 1
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_action_items
integer x = 64
integer y = 2004
integer width = 3703
integer height = 60
long backcolor = 33551856
end type

type tab_1 from u_tab_action_items_det within u_tabpg_contract_action_items
integer width = 3936
integer height = 2008
integer taborder = 11
boolean bringtotop = true
end type

event selectionchanged;call super::selectionchanged;of_setfiltertoolbar()

/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-12-05 By: Scofield
//$<Reason> Control the Filter Menu item's visible status.

if IsValid(m_pfe_cst_mdi_menu_contract) then
	if NewIndex = 1 then
		if tabpage_browse.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'Enabled', false)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'Enabled', true)
		end if
	else
		if tabpage_detail.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'Enabled', false)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'Enabled', true)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------
*/
end event

