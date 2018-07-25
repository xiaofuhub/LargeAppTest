$PBExportHeader$w_contract_email_folder.srw
forward
global type w_contract_email_folder from w_email_folder
end type
end forward

global type w_contract_email_folder from w_email_folder
integer x = 214
integer y = 221
integer width = 4617
integer height = 1676
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
windowstate windowstate = normal!
end type
global w_contract_email_folder w_contract_email_folder

forward prototypes
public subroutine of_adjustsize ()
public subroutine of_refreshdata ()
public subroutine of_check_menu ()
end prototypes

public subroutine of_adjustsize ();//====================================================================
// Function: of_AdjustSize
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/07/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long	ll_XPos,ll_YPos

if IsValid(gw_Contract) then
	ll_XPos = gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_email.X  
	ll_YPos = gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_email.Y  
	
	This.Move(ll_XPos,ll_YPos)
	This.Resize(gw_Contract.tab_contract_details.width - ll_XPos ,gw_Contract.tab_contract_details.height - ll_YPos ) 
end if
end subroutine

public subroutine of_refreshdata ();//====================================================================
// Function: of_refreshdata
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/16/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

////change the menu
//If w_mdi.MenuName <> "m_pfe_cst_mail" Then
//	w_mdi.ChangeMenu(m_pfe_cst_mail)
//	w_mdi.of_menu_security(w_mdi.MenuName)
//End If
//
of_check_menu()


this.cb_close.visible = False
this.cb_refresh.visible = False
this.cb_selectback.visible = False
this.cb_selectback.enabled = False

this.rb_all.enabled = False
this.rb_all.checked = False
this.rb_select.enabled = True
this.rb_select.checked = True
ii_retrieve_type = 1

If IsValid(gw_Contract) then
	il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
End if

rb_select.text = 'Selected Contract - '+String(il_ctx_id)
//idw_folder_browse[ii_current_main_folder_id].reset()
////ib_retrieved_all[ii_current_main_folder_id] = False
//ib_retrieved_single[ii_current_main_folder_id] = False
// ii_current_retrieve_type[] = {-1,-1,-1,-1,-1,-1,-1,-1} 
of_reset_all()

this.rb_select.event clicked( )
end subroutine

public subroutine of_check_menu ();//Added By Mark Lee 02/17/2013
If  isvalid(m_pfe_cst_mail) Then 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', False)
End IF 
end subroutine

on w_contract_email_folder.create
call super::create
end on

on w_contract_email_folder.destroy
call super::destroy
end on

event open;call super::open;
//Added By Mark Lee 02/07/2013 disable the button attribute.
this.of_AdjustSize()	

this.cb_close.visible = False
this.cb_refresh.visible = False
this.cb_selectback.visible = False
this.cb_selectback.enabled = False

this.rb_all.enabled = False
this.rb_all.checked = False
this.rb_select.enabled = True
this.rb_select.checked = True
ii_retrieve_type = 1

If IsValid(gw_Contract) then
	il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
End if

this.rb_select.event clicked( )
end event

event timer;//Added By Mark Lee 02/17/2013  rewriter

end event

event ue_change_ctx;//Added By Mark Lee 02/18/2013  rewriter 
If al_ctx_id = 0 Then Return 0

If ab_check_select Then
	If This.of_get_select_type( ) = 0 Then 
		Return 0 //Only Selected Contract RadioButton has been check, then do it.
	End If
End If

//Integer li_ret				//Commented By Mark Lee 02/18/2013
//If ab_show_message and il_ctx_id <> 0 Then
//	This.Bringtotop = True
//	li_ret = Messagebox('Email','Display emails associated with Contract #' + String(al_ctx_id) + '?',Question!,yesno!) 
//	If li_ret = 2 Then Return 1
//End If

of_reset_all()
rb_select.enabled = True
rb_select.checked = True
rb_all.enabled = True
rb_all.checked = False
ii_retrieve_type = 1
il_ctx_id = al_ctx_id
of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,ii_retrieve_type)

il_pre_ctx_id_from_search_tab = al_ctx_id

Return 1
end event

type ole_mail_view from w_email_folder`ole_mail_view within w_contract_email_folder
end type

type cb_selectback from w_email_folder`cb_selectback within w_contract_email_folder
end type

type dw_search from w_email_folder`dw_search within w_contract_email_folder
end type

type lv_attachment from w_email_folder`lv_attachment within w_contract_email_folder
end type

type st_v_bar2 from w_email_folder`st_v_bar2 within w_contract_email_folder
end type

type st_tip from w_email_folder`st_tip within w_contract_email_folder
end type

type dw_drafts from w_email_folder`dw_drafts within w_contract_email_folder
end type

type dw_favorite from w_email_folder`dw_favorite within w_contract_email_folder
end type

type dw_history from w_email_folder`dw_history within w_contract_email_folder
end type

type dw_recycle from w_email_folder`dw_recycle within w_contract_email_folder
end type

type dw_inbox from w_email_folder`dw_inbox within w_contract_email_folder
end type

type st_v_bar from w_email_folder`st_v_bar within w_contract_email_folder
end type

type tv_mail from w_email_folder`tv_mail within w_contract_email_folder
end type

event tv_mail::selectionchanged;call super::selectionchanged;//Added By Mark Lee 02/07/2013
cb_selectback.enabled = False
rb_all.enabled = False
rb_select.enabled = True
end event

type cb_refresh from w_email_folder`cb_refresh within w_contract_email_folder
boolean visible = false
end type

type rb_all from w_email_folder`rb_all within w_contract_email_folder
end type

type rb_select from w_email_folder`rb_select within w_contract_email_folder
end type

type st_split from w_email_folder`st_split within w_contract_email_folder
end type

type cb_close from w_email_folder`cb_close within w_contract_email_folder
boolean visible = false
end type

type dw_sent_items from w_email_folder`dw_sent_items within w_contract_email_folder
end type

type rte_header from w_email_folder`rte_header within w_contract_email_folder
end type

type ole_1 from w_email_folder`ole_1 within w_contract_email_folder
end type

