$PBExportHeader$w_documents_browse.srw
forward
global type w_documents_browse from w_sheet
end type
type cbx_retrieve from checkbox within w_documents_browse
end type
type cb_close from commandbutton within w_documents_browse
end type
type cb_retrieve from commandbutton within w_documents_browse
end type
type uo_1 from u_tabpg_document_browse within w_documents_browse
end type
end forward

global type w_documents_browse from w_sheet
integer width = 4105
integer height = 2136
string title = "Documents Browse"
windowstate windowstate = maximized!
long backcolor = 33551856
event ue_do ( string as_action )
cbx_retrieve cbx_retrieve
cb_close cb_close
cb_retrieve cb_retrieve
uo_1 uo_1
end type
global w_documents_browse w_documents_browse

type variables
integer ii_retrieve
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
long il_winview_just_open
long il_current_properties_view,il_current_properties_screen //Added By Jay Chen 04-04-2014
//---------End Added ------------------------------------------------------
end variables

forward prototypes
public subroutine of_set_menu ()
public subroutine of_hide_menu (m_pfe_cst_mdi_menu am_menu)
public function long of_get_ctx_view (long al_category, long al_ctx_id)
end prototypes

event ue_do(string as_action);uo_1.event ue_do(as_action)
end event

public subroutine of_set_menu ();
//If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract_am' Then
		w_mdi.changemenu(m_pfe_cst_mdi_menu_contract_am)
	End If
	w_mdi.of_menu_security("m_pfe_cst_mdi_menu_contract_am")
	uo_1.event ue_set_security( )
	of_hide_menu(m_pfe_cst_mdi_menu_contract_am)	
//End If

//Disable profile report - jervis 09.27.2011
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_reports.m_profilerpt,'enabled', false)
end subroutine

public subroutine of_hide_menu (m_pfe_cst_mdi_menu am_menu);Integer i,li_cnt

If gb_DocQuickView Then
	//Level 1 menu
	li_cnt = UpperBound(am_menu.Item[])
	For i = li_cnt To 1 Step -1
		am_menu.Item[i].visible = False
		gnv_app.of_modify_menu_attr( am_menu.Item[i],'enabled', False)
		//am_menu.Item[i].mergeoption = Exclude!
		gnv_app.of_modify_menu_attr( am_menu.m_file.Item[i],'toolbaritemvisible', False)
	Next
	am_menu.m_file.visible = False
	am_menu.m_file.m_contract.visible = False
	am_menu.visible = False
	
	//Files
	li_cnt = UpperBound(am_menu.m_file.Item[])
	For i = li_cnt To 1 Step -1
		am_menu.m_file.Item[i].visible = False
		gnv_app.of_modify_menu_attr( am_menu.m_file.Item[i],'toolbaritemvisible', False)
	Next	
	am_menu.m_file.m_close.visible = True
	gnv_app.of_modify_menu_attr( am_menu.m_file.m_close,'toolbaritemvisible', True)
	
	//Reports
	li_cnt = UpperBound(am_menu.m_reports.Item[])
	For i = li_cnt To 1 Step -1
		am_menu.m_reports.Item[i].visible = False
		gnv_app.of_modify_menu_attr( am_menu.m_reports.Item[i],'toolbaritemvisible', False)
	Next	

	//Help
	li_cnt = UpperBound(am_menu.m_help.Item[])
	For i = li_cnt To 1 Step -1
		am_menu.m_help.Item[i].visible = False
		gnv_app.of_modify_menu_attr( am_menu.m_help.Item[i],'toolbaritemvisible', False)
	Next	

	//Email folder
	gnv_app.of_modify_menu_attr( am_menu.m_system.m_emailsignature.m_emailsentitems,'toolbaritemvisible', False)

	
End If
end subroutine

public function long of_get_ctx_view (long al_category, long al_ctx_id);//====================================================================
// Function: of_get_ctx_view
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_category
// 	value    long    al_ctx_id
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-04-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//// (Appeon)Harry 05.06.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

Long ll_row
Long li_view_id
n_ds lds_ctx_group_user_view

lds_ctx_group_user_view = create n_ds
lds_ctx_group_user_view.dataobject = 'd_ctx_group_user_view_pt'
lds_ctx_group_user_view.settransobject(sqlca)
lds_ctx_group_user_view.Retrieve(gs_user_id)

//Get From Group Access
ll_row = lds_ctx_group_user_view.Find('ctx_group_access_ctx_id = ' + String(al_ctx_id) + ' And Upper(security_group_users_user_id) = "'+upper(gs_user_id)+'"',1,lds_ctx_group_user_view.RowCount()) 
If ll_Row > 0 Then
	li_view_id = lds_ctx_group_user_view.GetItemNumber(ll_row,'ctx_group_access_view_id')
	Return li_view_id
End If

//Get From Category from Code_Lookup	
li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(al_category)))

//Get From Default View
If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
End If
If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = 1001
End If

Return li_view_id
end function

on w_documents_browse.create
int iCurrent
call super::create
this.cbx_retrieve=create cbx_retrieve
this.cb_close=create cb_close
this.cb_retrieve=create cb_retrieve
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_retrieve
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.uo_1
end on

on w_documents_browse.destroy
call super::destroy
destroy(this.cbx_retrieve)
destroy(this.cb_close)
destroy(this.cb_retrieve)
destroy(this.uo_1)
end on

event open;call super::open;Select doc_auto_retrieve Into :ii_retrieve From security_users where user_id = :gs_user_id ;

If ii_retrieve = 1 Then
	cbx_retrieve.checked = True
End If

end event

event pfc_postopen;call super::pfc_postopen;String ls_express
If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '0' Then 
	uo_1.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name"  ')
Else
	uo_1.tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name + ~' ~' + String( doc_id )+ ~'.~' + String( revision ,~'##0.0~')"  ')
End If

//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
/*
If cbx_retrieve.checked Then
	cb_retrieve.event clicked( )
End If
*/
//Added By Jay Chen 04-03-2014
if isnull(il_winview_just_open) or il_winview_just_open = 0 then 
	If cbx_retrieve.checked Then
		cb_retrieve.event clicked( )
	End If
end if
//---------End Modfiied ------------------------------------------------------
uo_1.tab_1.tabpage_browse.dw_browse.SetFocus()

of_set_menu()
of_hide_menu(m_pfe_cst_mdi_menu_contract_am)


w_mdi.show()
w_mdi.WindowState = Maximized!

This.uo_1.tab_1.tabpage_browse.dw_filter.SetFocus()
end event

event activate;If Not gb_DocQuickView Then
	Super::Event Activate()
	of_set_menu()
End If



//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(uo_1.tab_1.tabpage_preview.ole_doc ) Then
	uo_1.tab_1.tabpage_preview.ole_doc.object.activate(true)
End If

//Added By Ken.Guo 2011-06-27. 
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	if Not uo_1.tab_1.tabpage_browse.dw_filter.Visible then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', false)		
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', true)
	end if

End If


end event

event close;call super::close;Integer li_retrieve
If cbx_retrieve.checked Then
	li_retrieve = 1
Else
	li_retrieve = 0
End If

If li_retrieve <> ii_retrieve Then
	Update security_users Set doc_auto_retrieve = :li_retrieve Where User_id = :gs_user_id;
End If

If gb_DocQuickView Then Halt Close

//Modified By Ken.Guo 2010-12-10
if w_mdi.menuname <> 'm_pfe_cst_mdi_menu' then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
End If
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.19.2008 By: Ken.Guo
////$<reason> when dashboard menu close, change to mdi menu.
//window lw_activesheet
//lw_activesheet = w_mdi.GetNextSheet(This)
//If Not isvalid(lw_activesheet) Then
//	//If no any sheet window.
//	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then
//		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
//		w_mdi.of_menu_security( w_mdi.MenuName )
//	End If
//End If
////---------------------------- APPEON END ----------------------------

end event

event resize;call super::resize;If newwidth <= 20 or newheight <= 100 Then Return 
uo_1.resize(newwidth - 20, newheight - 100 )

cb_retrieve.move(newwidth - 740,newheight - 140)
cb_close.move(newwidth - 388,newheight - 140)

cbx_retrieve.y = cb_close.y + 20
end event

event deactivate;call super::deactivate;////Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(uo_1.tab_1.tabpage_preview.ole_doc ) Then
//	uo_1.tab_1.tabpage_preview.ole_doc.object.activate(false)
//End If
end event

event pfc_preopen;call super::pfc_preopen;//====================================================================
// Event: pfc_preopen
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-01-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//// (Appeon)Harry 05.06.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

long ll_Dynamic,ll_SearchTab_View_id
Boolean	lb_DefaultViewSearch

if isnull(il_winview_just_open) or il_winview_just_open = 0 then 

	SELECT Dynamic_Search_Tab
	INTO :ll_Dynamic
	FROM security_users 
	WHERE user_id = :gs_user_id;
	
	if ll_Dynamic = 0  then
		lb_DefaultViewSearch = false
	else
		lb_DefaultViewSearch = true
	end if
	
	if lb_DefaultViewSearch then
		ll_SearchTab_View_id = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + Upper(gs_user_id) + "'"))
	end if
	if IsNull(ll_SearchTab_View_id) or ll_SearchTab_View_id = 0 then ll_SearchTab_View_id = 1001
	gl_SearchTab_document_View = ll_SearchTab_View_id
	
else
	gl_SearchTab_document_View = il_winview_just_open
end if

uo_1.triggerevent("ue_show_constructor")


end event

type cbx_retrieve from checkbox within w_documents_browse
integer x = 41
integer y = 1920
integer width = 571
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Auto Retrieve"
end type

type cb_close from commandbutton within w_documents_browse
integer x = 3447
integer y = 1896
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_retrieve from commandbutton within w_documents_browse
integer x = 3095
integer y = 1896
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Retrieve"
end type

event clicked;uo_1.event ue_retrieve( )

end event

type uo_1 from u_tabpg_document_browse within w_documents_browse
integer width = 4050
integer height = 1932
integer taborder = 80
end type

on uo_1.destroy
call u_tabpg_document_browse::destroy
end on

event ue_set_security;call super::ue_set_security;//of_hide_menu(m_pfe_cst_mdi_menu_contract_am)
Post of_hide_menu(m_pfe_cst_mdi_menu_contract_am)
end event

