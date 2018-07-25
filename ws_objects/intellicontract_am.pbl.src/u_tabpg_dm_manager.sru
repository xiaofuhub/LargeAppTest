$PBExportHeader$u_tabpg_dm_manager.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_dm_manager from u_tabpg_contract_master
end type
type tab_1 from tab within u_tabpg_dm_manager
end type
type tabpage_data from u_tabpg_dm_data within tab_1
end type
type tabpage_data from u_tabpg_dm_data within tab_1
end type
type tabpage_action from u_tabpg_dm_ai within tab_1
end type
type tabpage_action from u_tabpg_dm_ai within tab_1
end type
type tab_1 from tab within u_tabpg_dm_manager
tabpage_data tabpage_data
tabpage_action tabpage_action
end type
end forward

global type u_tabpg_dm_manager from u_tabpg_contract_master
integer width = 3863
integer height = 2012
long backcolor = 33551856
event ue_do ( string as_action )
event type integer ue_retrieve ( )
event ue_set_tabpage_properties ( )
event ue_set_screen_properties ( )
event ue_show_constructor pbm_constructor
tab_1 tab_1
end type
global u_tabpg_dm_manager u_tabpg_dm_manager

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2007 By: Jack (Document Manager)
//$<reason> 
boolean ib_browse
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_retrieve ()
public subroutine of_create_dw ()
public subroutine of_settingfiltertoolbar ()
public subroutine of_setdwfocus ()
end prototypes

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_do()
// $<arguments>
//		value	string	as_Action		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-09 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//messagebox('u_tabpg_dm_manager',as_action)output_email
CHOOSE CASE lower(as_action)
	CASE 'output_print'
		//open(w_dm_print_document)
		IF tab_1.selectedtab=1 THEN
			tab_1.tabpage_data.dynamic event ue_print()
		//ELSEIF tab_1.selectedtab=3 THEN
		//	tab_1.tabpage_audit.dynamic event ue_print()
		END IF  
	CASE 'output_email'
		//---Appeon Begin by alfee at 03.29.2007------------------
//		IF tab_1.selectedtab = 1 THEN // 01.19.2007 by Jack
//			tab_1.tabpage_data.dynamic event ue_do(as_action)
//		ELSEIF tab_1.selectedtab = 3 THEN
//			tab_1.tabpage_audit.dynamic event ue_do(as_action)
//		END IF  
		//OpenWithParm(w_dm_email_document_send, inv_contract_details.of_get_ctx_id())
		tab_1.tabpage_data.dynamic event ue_do(as_action)
		//---Appeon End--------------------------------------------		
	CASE 'output_saveas' // 01.19.2007 by Jack
		IF tab_1.selectedtab = 1 THEN
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		//ELSEIF tab_1.selectedtab = 3 THEN
		//	tab_1.tabpage_audit.dynamic event ue_do(as_action)
		END IF  
	case 'add_action_item','delete_action_item','workflow'	//15.01.2007 By Jervis
		this.tab_1.selectedtab = 2 //Set tab_1.tabpage_action.il_doc_id - Jervis 09.16.2010
		tab_1.tabpage_action.dynamic event ue_do(as_action)
	case 'save'		//15.01.2007 By Jervis
		IF tab_1.selectedtab = 1 THEN
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		ELSEIF tab_1.selectedtab = 2 THEN
			tab_1.tabpage_action.dynamic event ue_do(as_action)
		end if
	CASE 'report' // 01.17.2007 by Jack
		If tab_1.selectedtab = 1 Then
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		ElseIf tab_1.selectedtab = 2 then
			tab_1.tabpage_action.dynamic event ue_do(as_action)
		//elseif tab_1.selectedtab = 3 Then
		//	tab_1.tabpage_audit.dynamic event ue_do(as_action)
		End If			
	CASE 'select' // 01.18.2007 by Jack		
		If tab_1.selectedtab = 1 Then
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		ElseIf tab_1.selectedtab = 2 then
			tab_1.tabpage_action.dynamic event ue_do(as_action)
		//elseif tab_1.selectedtab = 3 Then
		//	tab_1.tabpage_audit.dynamic event ue_do(as_action)
		End If
	case 'print_letter'	//01.27.2007 By Jervis
		If tab_1.selectedtab = 2 then
			tab_1.tabpage_action.dynamic event ue_do(as_action)
		end if
	Case 'ue_show_sertifi_status' //Added By Ken.Guo 2011-06-20. 
		If tab_1.selectedtab = 1 Then
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		ElseIf tab_1.selectedtab = 2 then
			tab_1.tabpage_action.dynamic event ue_do(as_action)
		//elseif tab_1.selectedtab = 3 Then
		//	tab_1.tabpage_audit.dynamic event ue_do(as_action)
		End If		
	Case 'primary_document'			//Added By Mark Lee 10/29/2012
		//Begin - Added By Mark Lee 10/29/2012
		If tab_1.selectedtab = 1 Then
			tab_1.tabpage_data.dynamic event ue_do(as_action)
		End If
		//End - Added By Mark Lee 10/29/2012
	CASE ELSE
		tab_1.tabpage_data.dynamic event ue_do(as_action)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.30.2007 By: Jack (Document Manager)
		//$<reason> 
		If tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
			tab_1.tabpage_action.enabled = True
			//tab_1.tabpage_audit.enabled = True
			if IsValid(m_pfe_cst_mdi_menu_contract_am) then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', True)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.enabled = True
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'enabled', True) //by alfee at 03.22.2007
				
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', True)
			end if
		Else
			tab_1.tabpage_action.enabled = False
			//tab_1.tabpage_audit.enabled = False
			
			if IsValid(m_pfe_cst_mdi_menu_contract_am) then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'enabled', False)
				
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', False)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.enabled = False //by alfee at 03.22.2007		
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', False)
					
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', False)
			end if
		End If	
		//---------------------------- APPEON END ----------------------------
END CHOOSE

end event

event type integer ue_retrieve();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Jack (Document Manager)
//$<reason> 
tab_1.tabpage_data.event ue_retrieve()
CHOOSE CASE tab_1.selectedtab
	CASE 1
		If tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount() < 1 Then
			tab_1.tabpage_action.enabled = False
			//tab_1.tabpage_audit.enabled = False
		Else
			tab_1.tabpage_action.enabled = True
			//tab_1.tabpage_audit.enabled = True			
//			tab_1.tabpage_data.ib_browse = True
		End If
	CASE 2
		If tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount() < 1 Then
			tab_1.tabpage_action.enabled = False
			//tab_1.tabpage_audit.enabled = False
			ib_browse = True
			tab_1.selecttab(1)
			Return 0
		End If
//		tab_1.tabpage_action.event ue_retrieve()
	/*
	CASE 3
		long ll_doc_id_new,ll_doc_id_old
		dec{1} ldc_revision
		string ls_doc_ext
		If tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount() < 1 Then
			tab_1.tabpage_action.enabled = False
			tab_1.tabpage_audit.enabled = False
			ib_browse = True
			tab_1.selecttab(1)
			tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.reset()
			If tab_1.tabpage_audit.tab_1.selectedtab = 2 Then
				tab_1.tabpage_audit.tab_1.selecttab(1)
			End If
			tab_1.tabpage_audit.tab_1.tabpage_preview.enabled = False
			Return 0
		End If
		tab_1.tabpage_audit.tab_1.tabpage_preview.enabled = True
		ll_doc_id_new = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.getitemnumber(1,'doc_id')
		ldc_revision = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.getitemnumber(1,'revision')
		ls_doc_ext = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.getitemstring(1,'doc_ext')
		If tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
			ll_doc_id_old = tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.getitemnumber(1,'doc_id')
		Else
			ll_doc_id_old = 0
		End If
		If ll_doc_id_new <> ll_doc_id_old Then
			tab_1.tabpage_audit.event ue_retrieve(ll_doc_id_new,ldc_revision,ls_doc_ext)
		End If
	*/
END CHOOSE

return 0
//---------------------------- APPEON END ----------------------------

end event

event ue_set_tabpage_properties();long ll_FindRow
long ll_data_view_id

if not IsValid(gw_contract) then Return
ll_data_view_id = gw_contract.of_get_view_id()

// [Document] Set tabpage_data property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_dm_document")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_data, "computepage!", "Document", "computepage!")
tab_1.tabpage_data.tab_1.backcolor = tab_1.tabpage_data.backcolor
tab_1.tabpage_data.tab_1.tabpage_browse.backcolor = tab_1.tabpage_data.backcolor
tab_1.tabpage_data.tab_1.tabpage_browse.tabbackcolor = tab_1.tabpage_data.backcolor
tab_1.tabpage_data.tab_1.tabpage_preview.backcolor = tab_1.tabpage_data.backcolor
tab_1.tabpage_data.tab_1.tabpage_preview.tabbackcolor = tab_1.tabpage_data.backcolor

// [Work Flow] Set tabpage_action property
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_dm_workflow")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_action, "compute!", "Work Flow", "compute!")
tab_1.tabpage_action.tab_1.backcolor = tab_1.tabpage_action.backcolor
tab_1.tabpage_action.tab_1.tabpage_browse.backcolor = tab_1.tabpage_action.backcolor
tab_1.tabpage_action.tab_1.tabpage_browse.tabbackcolor = tab_1.tabpage_action.backcolor
tab_1.tabpage_action.tab_1.tabpage_detail.backcolor = tab_1.tabpage_action.backcolor
tab_1.tabpage_action.tab_1.tabpage_detail.tabbackcolor = tab_1.tabpage_action.backcolor

// [Audit Trail] Set tabpage_audit property
/*
ll_FindRow = gw_contract.of_get_tabpage_prop_row(ll_data_view_id, "tabpage_dm_audit")
gw_contract.of_set_tabpage_property(ll_FindRow, tab_1.tabpage_audit, "custom082!", "Audit Trail", "custom082!")
tab_1.tabpage_audit.tab_1.backcolor = tab_1.tabpage_audit.backcolor
tab_1.tabpage_audit.tab_1.tabpage_browse.backcolor = tab_1.tabpage_audit.backcolor
tab_1.tabpage_audit.tab_1.tabpage_browse.tabbackcolor = tab_1.tabpage_audit.backcolor
tab_1.tabpage_audit.tab_1.tabpage_preview.backcolor = tab_1.tabpage_audit.backcolor
tab_1.tabpage_audit.tab_1.tabpage_preview.tabbackcolor = tab_1.tabpage_audit.backcolor
*/
end event

event ue_set_screen_properties();// Set screen properties
tab_1.tabpage_data.Event ue_set_screen_properties()
tab_1.tabpage_action.Event ue_set_screen_properties()
//tab_1.tabpage_audit.Event ue_set_screen_properties()
end event

event ue_show_constructor;//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_constructor()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Refresh right and refresh object position
//////////////////////////////////////////////////////////////////////
// $<add> 11/07/2008 by Scofield
//////////////////////////////////////////////////////////////////////

long	ll_Right,ll_BottomPos,ll_Zoom

ll_Right = w_mdi.of_security_access(6924)

ll_Right = w_mdi.of_security_access(6935)
if ll_Right = 0 then
	tab_1.tabpage_action.Visible = false
else
	tab_1.tabpage_action.Visible = true
end if

tab_1.tabpage_data.Event ue_show_constructor()

end event

public function integer of_retrieve ();IF NOT ib_retrieved THEN
	ib_retrieved = TRUE
	//Start Coding By Jervis 01.30.2007
	tab_1.selecttab(1)
	//End Coding
	
	event ue_retrieve()
END IF


return success

end function

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_managerof_create_dw()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.18.2007 by Jack
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[], ldw_protect[]
string 		ls_way[], ls_expression[]

ls_tab_name = 'tabpage_images'
ld_dw[1] = tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter
ls_dw_name[1] = 'dw_filter'
ls_dataobject[1] = 'd_dm_browse_filter'

//Comment by Jack 04.27.2007
//ld_dw[2] = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse
//ls_dw_name[2] = 'dw_browse'
//ls_dataobject[2] = 'd_dm_doc_tree'

ld_dw[2] = tab_1.tabpage_action.dw_filter
ls_dw_name[2] = 'dw_filter'
ls_dataobject[2] = 'd_dm_ai_filter'

ld_dw[3] = tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse
ls_dw_name[3] = 'dw_browse'
ls_dataobject[3] = 'd_dm_doc_ai_browse'

ld_dw[4] = tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail
ls_dw_name[4] = 'dw_detail'
ls_dataobject[4] = 'd_dm_doc_ai_detail'

//add by gavins 20120213
ld_dw[5] = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse
ls_dw_name[5] = 'dw_browse'
ls_dataobject[5] = 'd_dm_doc_tree'

ld_dw[6] =  tab_1.tabpage_data.tab_1.tabpage_browse.dw_detail
ls_dw_name[6] = 'dw_detail'
ls_dataobject[6] = 'd_dm_doc_tree_detail'

/*
ld_dw[5] = tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter
ls_dw_name[5] = 'dw_filter'
ls_dataobject[5] = 'd_dm_audit_filter'

ld_dw[6] = tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse
ls_dw_name[6] = 'dw_browse'
ls_dataobject[6] = 'd_dm_doc_audit_browse'
*/

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)	

//Begin - Added By Mark Lee 09/10/12
ldw_protect[1] = ld_dw[4]
ls_way[1] = 'part'
//Modified By Ken.Guo 09/02/2013
//ls_expression[1] = "if((not isnull(wf_id)) or  active_status < 0 or  readonly_flag = 1 or wf_complete_flag = 'Y',1,0)"
ls_expression[1] = "if( ((not isnull(wf_id)) and wf_complete_flag = ~~'Y~~') or  active_status < 0 or readonly_flag = 1  ,1,0)"
If f_set_datawindow_protect(ldw_protect,ls_way,ls_expression) = -1 Then
	Messagebox("IntelliSoft","Set datawindow protect's property Failure!")  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX modify "Contractlogix" to "IntelliSoft"
End If
//Added By Ken.Guo 09/02/2013
ld_dw[4].Modify("action_type.protect='0~tif( (not isnull(wf_id))  or  active_status < 0 or readonly_flag = 1  ,1,0)' ")
//End - Added By Mark Lee 09/10/12

iw_parent.function dynamic wf_set_select('tabpage_images',true) 
//gw_contract.function dynamic wf_set_select('tabpage_images',true) 
tab_1.tabpage_action.of_set_docrevision( -1,-2)
//tab_1.tabpage_audit.of_set_docrevision( -1,-2)

//Added By Ken.Guo 2010-02-05.
String ls_express
//If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '0' Then 
//	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name" doc_name_t.text = "Document Name" ')
//Else
//	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name + ~' ~' + String( doc_id )+ ~'.~' + String( revision ,~'##0.0~')" doc_name_t.text = "Document Name && ID" ')
//End If
If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '0' Then 
	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name" ')
Else
	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name + ~' ~' + String( doc_id )+ ~'.~' + String( revision ,~'##0.0~')"  ')
End If




this.event ue_set_screen_properties( )  //Jervis 08.17.2010
end subroutine

public subroutine of_settingfiltertoolbar ();//====================================================================
// Function: of_SettingFilterToolBar()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// Modified By Ken.Guo 2010-07-26. Use ToolbatItemDown property.
//====================================================================

long	ll_Right,ll_Index

if Not IsValid(m_pfe_cst_mdi_menu_contract_am) then Return

ll_Right = w_mdi.of_security_access(6924)
if ll_Right = 0 then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	Return
end if

ll_Index = Tab_1.SelectedTab

Choose Case ll_Index
	Case 1
		if Tab_1.Tabpage_Data.Tab_1.SelectedTab = 1 then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Filter.Visible)
			
//			if Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Filter.Visible then//modify by gavins 20120705
//				Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Filter.Post SetFocus()
//			else
////				Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Browse.Post SetFocus()
//				If IsValid( Tab_1.tabpage_data.idw_lastdw ) Then 
//					tab_1.tabpage_data.idw_Lastdw.Post setFocus( )
//				Else
//					tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Post setFocus( )
//				End If
//			end if
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
		end if
	Case 2
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', tab_1.tabpage_action.dw_filter.Visible)
		
//		if tab_1.tabpage_action.dw_filter.Visible then//modify by gavins 20120705
//			tab_1.tabpage_action.dw_filter.Post SetFocus()
//		else
//			if tab_1.tabpage_action.tab_1.SelectedTab = 2 then
//				tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.Post SetFocus()
//			end if
//		end if
	/*
	Case 3
		if tab_1.tabpage_audit.tab_1.SelectedTab = 1 then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Visible)
			
			if tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Visible then
				tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Post SetFocus()
			else
				tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.Post SetFocus()
			end if
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
		end if
	*/
End Choose

end subroutine

public subroutine of_setdwfocus ();////====================================================================
// Function: of_SetDWFocus
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-07-05
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Integer		ll_Index

ll_Index = Tab_1.SelectedTab

Choose Case ll_Index
	Case 1

		if Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Filter.Visible then
			Tab_1.Tabpage_Data.Tab_1.Tabpage_Browse.dw_Filter.SetFocus()
		else
			If IsValid( Tab_1.tabpage_data.idw_lastdw ) Then 
				 tab_1.tabpage_data.idw_Lastdw.setFocus( )
			Else
				tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.setFocus( )
			End If
		end if
	Case 2
		if tab_1.tabpage_action.dw_filter.Visible then
			tab_1.tabpage_action.dw_filter.SetFocus()
		else
			if tab_1.tabpage_action.tab_1.SelectedTab = 2 then
				tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.SetFocus()
			Else
				tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.SetFocus()
			end if
		end if
		
		
End Choose
end subroutine

on u_tabpg_dm_manager.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_dm_manager.destroy
call super::destroy
destroy(this.tab_1)
end on

event constructor;call super::constructor;long	ll_Right

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
of_create_dw()
//---------------------------- APPEON END ----------------------------

if gb_AutoResize then  //(Appeon)Harry 10.22.2013 - For Testing Bug #3702:Resizing IntelliContract Window does not refresh
	this.of_setresize( true)
	this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
	this.inv_resize.of_SetMinSize( 1024, 768 )
	//this.inv_resize.of_SetOrigsize( 3995, 2000)
end if

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-05-13 By: Scofield
//$<Reason> Add the right to turn off the Search Criteria for document manager

ll_Right = w_mdi.of_security_access(6924)
if ll_Right = 0 then
	tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter.Visible = false
//	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Height + tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Y - tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter.Y
	tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.Y = tab_1.tabpage_data.tab_1.tabpage_browse.dw_filter.Y
	//modify and add by gavins 20120131	
	If tab_1.tabpage_data.tab_1.tabpage_browse.dw_detail.Visible Then
		tab_1.tabpage_data.Tab_1.TabPage_Browse.dw_Browse.Height = tab_1.tabpage_data.Tab_1.TabPage_Browse.Height -  tab_1.tabpage_data.Tab_1.TabPage_Browse.dw_detail.Height  - 10
	Else
		tab_1.tabpage_data.Tab_1.TabPage_Browse.dw_Browse.Height = tab_1.tabpage_data.Tab_1.TabPage_Browse.Height -  10		
	End If

	
	tab_1.tabpage_action.dw_filter.Visible = false
	tab_1.tabpage_action.tab_1.Y = tab_1.tabpage_data.tab_1.Y
	tab_1.tabpage_action.tab_1.Height = tab_1.tabpage_data.tab_1.Height
	tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.Height + tab_1.tabpage_action.dw_filter.Height
	tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.Height = tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.Height + tab_1.tabpage_action.dw_filter.Height
	
	/*
	tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Visible = false
	tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.Height + tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.Y - tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Y
	tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.Y = tab_1.tabpage_audit.tab_1.tabpage_browse.dw_filter.Y
	*/
end if

ll_Right = w_mdi.of_security_access(6935)
if ll_Right = 0 then tab_1.tabpage_action.Visible = false

/*
ll_Right = w_mdi.of_security_access(6936)
if ll_Right = 0 then tab_1.tabpage_audit.Visible = false
*/

//---------------------------- APPEON END ----------------------------

this.event ue_set_tabpage_properties( )	//Jervis 08.17.2010
end event

event ue_set_security;call super::ue_set_security;CHOOSE CASE tab_1.selectedtab
	CASE 1
		tab_1.tabpage_data.event ue_set_security()

	CASE 2
		tab_1.tabpage_data.ib_browse = False
		tab_1.tabpage_action.ib_browse = True
		tab_1.tabpage_action.event ue_set_security()
		ib_browse = True
		tab_1.tabpage_data.of_sethistorytoolbar( 3 )//add by gavins 20120203
	/*
	CASE 3
		tab_1.tabpage_data.ib_browse = False
		tab_1.tabpage_audit.ib_browse = True
		tab_1.tabpage_audit.event ue_set_security()
		ib_browse = True
	*/
END CHOOSE
//---------Begin Added by (Appeon)Harry 07.31.2015 for Bug 4638--------
int ll_cnt, i
boolean lb_exists = false
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_cnt = UpperBound(m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.Item[])
	For i = 1 To ll_cnt
		If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.Item[i].ToolbarItemVisible Then 
			lb_exists = true
			Exit
		End If
	Next
	if lb_exists then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option,'toolbaritemvisible', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option,'toolbaritemvisible', false)
	end if
end if
//---------End Added ------------------------------------------------------
This.of_settingfiltertoolbar( ) //Added By Ken.Guo 2010-07-26.
end event

event ue_selectionchanged;//overrided for performance tuning by alfee 11.04.2008

Choose Case inv_contract_details.is_mode
	Case inv_contract_details.new
		This.of_New( )
	Case inv_contract_details.edit
		This.of_Retrieve()
End Choose


end event

event ue_initinstancevar;call super::ue_initinstancevar;ib_browse = false
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_dm_manager
end type

type tab_1 from tab within u_tabpg_dm_manager
integer width = 3877
integer height = 2020
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
alignment alignment = center!
integer selectedtab = 1
tabpage_data tabpage_data
tabpage_action tabpage_action
end type

on tab_1.create
this.tabpage_data=create tabpage_data
this.tabpage_action=create tabpage_action
this.Control[]={this.tabpage_data,&
this.tabpage_action}
end on

on tab_1.destroy
destroy(this.tabpage_data)
destroy(this.tabpage_action)
end on

event selectionchanged;long	ll_Cycle,ll_RowCnts

DWItemStatus	ldwis_Status	

w_mdi.SetRedraw(False)  //(Appeon)Alfee 08.06.2013 for V141 ISG-CLX
of_SettingFilterToolBar()			//Added by Scofield on 2010-04-28


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.15.2007 By: Jack (Document Manager)
//$<reason> 
//tabpage_audit.ib_browse = False
tabpage_action.ib_browse = False
//---------------------------- APPEON END ----------------------------

IF newindex = 1 THEN
	//02.05.2007 By Jervis
	//Refresh data when update document status by work flow
	if tab_1.tabpage_action.of_get_update_status_flag( ) then
		tab_1.tabpage_data.event ue_retrieve()
		tab_1.tabpage_data.tab_1.tabpage_preview.dw_head.event pfc_retrieve()
		tab_1.tabpage_action.of_set_update_status_flag(false )
	end if
	
	//BEGIN---Modify by Scofield on 2009-04-21
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		if tab_1.tabpage_data.tab_1.SelectedTab = 1 then
			//---------Begin Modified by (Appeon)Harry 08.11.2015 for  Bug 4638--------
			//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', true)
			If w_mdi.of_security_access( 6990 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', false) 
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', True)					
			End If
			//---------End Modfiied ------------------------------------------------------
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', false)
		end if
	end if
	//END---Modify by Scofield on 2009-04-21
	
	//BEGIN---Modify by Scofield on 2009-07-13
	if tab_1.tabpage_data.tab_1.SelectedTab = 2 then
		if IsValid(w_DocWFStepStatus) then
			Show(w_DocWFStepStatus)
		else	//Add By Jervis 08.23.2010
			Open(w_DocWFStepStatus)
		end if
	end if
	//END---Modify by Scofield on 2009-07-13
ELSEIF newindex=2 THEN
	IF tabpage_data.of_get_doc_id() <> tabpage_action.of_get_doc_id() THEN
		tabpage_action.event ue_doc_changed(tabpage_action.of_get_doc_id(),tabpage_data.of_get_doc_id(),&
												tabpage_action.of_get_revision(),tabpage_data.of_get_revision())
	END IF
	tabpage_action.ib_browse = True
	ib_browse = True
	//BEGIN---Modify by Scofield on 2009-04-21
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', false)
	end if
	//END---Modify by Scofield on 2009-04-21
	
	//BEGIN---Modify by Scofield on 2010-02-23
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		ll_RowCnts = tabpage_action.tab_1.tabpage_detail.dw_detail.RowCount()
		for ll_Cycle = 1 to ll_RowCnts
			ldwis_Status = tabpage_action.tab_1.tabpage_detail.dw_detail.GetItemStatus(ll_Cycle,0,Primary!)
			if ldwis_Status <> NotModified! then Exit
		next
		
		if ll_Cycle <= ll_RowCnts then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'Enabled', true)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'Enabled', false)
		end if
	end if
	//END---Modify by Scofield on 2010-02-23
	
	//if IsValid(w_DocWFStepStatus) then Hide(w_DocWFStepStatus)		//Added by Scofield on 2009-07-13
	if IsValid(w_DocWFStepStatus) then close(w_DocWFStepStatus)		//APB Bug - jervis 01.24.2011
/*
ELSEIF newindex=3 THEN
	If tab_1.tabpage_audit.tab_1.selectedtab = 2 Then
		tab_1.tabpage_audit.tab_1.selecttab(1)
	End If
	If tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
		tab_1.tabpage_audit.tab_1.tabpage_preview.enabled = True
		tabpage_audit.event ue_doc_changed(tabpage_audit.of_get_doc_id(),tabpage_data.of_get_doc_id(),&
												tabpage_audit.of_get_revision(),tabpage_data.of_get_revision())
	Else		
		tab_1.tabpage_audit.tab_1.tabpage_browse.dw_browse.reset()
	
		tab_1.tabpage_audit.tab_1.tabpage_preview.enabled = False
	End If
	tabpage_audit.ib_browse = True
	ib_browse = True
	//BEGIN---Modify by Scofield on 2009-04-21
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', false)
	end if
	//END---Modify by Scofield on 2009-04-21
	
	//if IsValid(w_DocWFStepStatus) then Hide(w_DocWFStepStatus)		//Added by Scofield on 2009-07-13
	if IsValid(w_DocWFStepStatus) then close(w_DocWFStepStatus)		//APB Bug - jervis 01.24.2011
*/
END IF

If ib_browse Then
	tab_1.tabpage_data.ib_browse = True
	//parent.post event ue_set_security()
End If
parent.post event ue_set_security()
ib_browse = True

Post of_setdwfocus() //added by gavins 20120705

w_mdi.Post SetRedraw(True) //(Appeon)Alfee 08.06.2013 for V141 ISG-CLX

end event

type tabpage_data from u_tabpg_dm_data within tab_1
integer x = 18
integer y = 112
integer height = 1892
string text = "Document"
string picturename = "computepage!"
long picturemaskcolor = 12632256
string powertiptext = "Document"
end type

event constructor;call super::constructor;this.of_RegistResize( 1 )  // add by gavins 20120131
end event

type tabpage_action from u_tabpg_dm_ai within tab_1
integer x = 18
integer y = 112
integer width = 3840
string text = "Work Flow"
string picturename = "compute!"
long picturemaskcolor = 12632256
string powertiptext = "Work Flow"
end type

