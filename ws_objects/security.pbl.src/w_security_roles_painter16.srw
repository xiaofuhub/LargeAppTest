$PBExportHeader$w_security_roles_painter16.srw
forward
global type w_security_roles_painter16 from w_response
end type
type cb_rename from commandbutton within w_security_roles_painter16
end type
type cb_close from u_cb within w_security_roles_painter16
end type
type cb_delete from u_cb within w_security_roles_painter16
end type
type cb_copy from u_cb within w_security_roles_painter16
end type
type cb_new from u_cb within w_security_roles_painter16
end type
type dw_select_role from u_dw within w_security_roles_painter16
end type
type tab_security from tab within w_security_roles_painter16
end type
type tabpage_roles from userobject within tab_security
end type
type uo_roles from pfc_cst_u_security_roles_painter within tabpage_roles
end type
type tabpage_roles from userobject within tab_security
uo_roles uo_roles
end type
type tabpage_user from userobject within tab_security
end type
type uo_user from pfc_cst_u_security_user_painter within tabpage_user
end type
type tabpage_user from userobject within tab_security
uo_user uo_user
end type
type tabpage_contract from userobject within tab_security
end type
type uo_contract from pfc_cst_u_security_roles_painter_contrac within tabpage_contract
end type
type tabpage_contract from userobject within tab_security
uo_contract uo_contract
end type
type tabpage_tdl from userobject within tab_security
end type
type uo_tdl from pfc_cst_u_tdl_role_painter within tabpage_tdl
end type
type tabpage_tdl from userobject within tab_security
uo_tdl uo_tdl
end type
type tab_security from tab within w_security_roles_painter16
tabpage_roles tabpage_roles
tabpage_user tabpage_user
tabpage_contract tabpage_contract
tabpage_tdl tabpage_tdl
end type
type gb_select from groupbox within w_security_roles_painter16
end type
end forward

global type w_security_roles_painter16 from w_response
integer x = 407
integer y = 388
integer width = 3099
integer height = 2520
string title = "Security Roles"
long backcolor = 33551856
cb_rename cb_rename
cb_close cb_close
cb_delete cb_delete
cb_copy cb_copy
cb_new cb_new
dw_select_role dw_select_role
tab_security tab_security
gb_select gb_select
end type
global w_security_roles_painter16 w_security_roles_painter16

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
boolean ib_retrieve
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_contract_management_rights (integer al_role_id)
public subroutine of_contract_management_rights_tab ()
public function integer of_tdl_rights ()
end prototypes

public function integer of_contract_management_rights (integer al_role_id);//////////////////////////////////////////////////////////////////////
// $<function>w_security_roles_painterof_contract_management_rights()
// $<arguments>
//		value	integer	al_role_id		
// $<returns> integer
// $<description> Contract Management Rights.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.31.2006 by Jack (IntelliContract Agreement Manager Painters)
//////////////////////////////////////////////////////////////////////
long ll_rowcount,ll_rowcount1,ll_row,i,ll_category,ll_find
string ls_filter
If tab_security.tabpage_contract.visible = False Then Return 1
If ib_retrieve Then
	datasTore lds_contract_management_rights
	datasTore lds_code_lookup
	lds_code_lookup = Create datasTore
	lds_code_lookup.dataobject = 'd_g_code_lookup'
	lds_code_lookup.settransobject(sqlca)
	
	lds_contract_management_rights = Create datasTore
	lds_contract_management_rights.dataobject = 'd_contract_management_rights'
	lds_contract_management_rights.settransobject(sqlca)
	
	gnv_appeondb.of_startqueue( )		
	lds_contract_management_rights.retrieve(al_role_id)
	lds_code_lookup.retrieve()
	gnv_appeondb.of_commitqueue( )
	
	ll_rowcount = lds_contract_management_rights.rowcount()
	
	ls_filter = "lookup_name = 'Contract Category'"
	lds_code_lookup.setfilter(ls_filter)
	lds_code_lookup.filter()
	ll_rowcount1 = lds_code_lookup.rowcount()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> 
	For i = 1 To ll_rowcount1
		ll_category = lds_code_lookup.getitemnumber(i,'lookup_code')
		//ll_find = lds_contract_management_rights.find("category = " + string(ll_category),1,ll_rowcount)
		ll_find = lds_contract_management_rights.find("category = " + string(ll_category) + " and types = 1",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.insertrow(0)
			lds_contract_management_rights.setitem(ll_row,'role_id',al_role_id)
			lds_contract_management_rights.setitem(ll_row,'category',ll_category)
			lds_contract_management_rights.setitem(ll_row,'types',1)
			lds_contract_management_rights.setitem(ll_row,'rights','11')
		End If
	Next
	
	
	
	//Start Changed 02.13.2007 By Jervis
	//Replace "Contract Clause Category" to "Contract Category"
	ls_filter = "lookup_name = 'Contract Clause Category'"  //Modify by Jack 03/12/2007
//	ls_filter = "lookup_name = 'Contract Category'"
	//End Changed
	
	lds_code_lookup.setfilter(ls_filter)
	lds_code_lookup.filter()
	ll_rowcount1 = lds_code_lookup.rowcount()
	ll_rowcount = lds_contract_management_rights.rowcount()	//Add By Jervis 02.14.2007
	For i = 1 To ll_rowcount1
		ll_category = lds_code_lookup.getitemnumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.find("category = " + string(ll_category) + " and types = 2",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.insertrow(0)
			lds_contract_management_rights.setitem(ll_row,'role_id',al_role_id)
			lds_contract_management_rights.setitem(ll_row,'category',ll_category)
			lds_contract_management_rights.setitem(ll_row,'types',2)
			lds_contract_management_rights.setitem(ll_row,'rights','21')
		End If
	Next
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> Replace "Contract Document Category" to "Contract Category"
	//ls_filter = "lookup_name = 'Contract Document Category'" //Rodger changed on Jan. 19, 2007.
	ls_filter = "lookup_name = 'Contract Category'"
	//---------------------------- APPEON END ----------------------------

	
	lds_code_lookup.setfilter(ls_filter)
	lds_code_lookup.filter()
	ll_rowcount1 = lds_code_lookup.rowcount()
	ll_rowcount = lds_contract_management_rights.RowCount() //Add by jervis 02.14.2007
	For i = 1 To ll_rowcount1
		ll_category = lds_code_lookup.getitemnumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.find("category = " + string(ll_category) + " and types = 3",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.insertrow(0)
			lds_contract_management_rights.setitem(ll_row,'role_id',al_role_id)
			lds_contract_management_rights.setitem(ll_row,'category',ll_category)
			lds_contract_management_rights.setitem(ll_row,'types',3)
			lds_contract_management_rights.setitem(ll_row,'rights','31')	
		End If
	Next

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> 
	//ls_filter = "lookup_name = 'Contract Document Category'"
	ls_filter = "lookup_name = 'Contract Category'"
	//---------------------------- APPEON END ----------------------------

	
	lds_code_lookup.setfilter(ls_filter)
	lds_code_lookup.filter()
	ll_rowcount1 = lds_code_lookup.rowcount()
	ll_rowcount = lds_contract_management_rights.Rowcount()
	For i = 1 To ll_rowcount1
		ll_category = lds_code_lookup.getitemnumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.find("category = " + string(ll_category) + " and types = 4",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.insertrow(0)
			lds_contract_management_rights.setitem(ll_row,'role_id',al_role_id)
			lds_contract_management_rights.setitem(ll_row,'category',ll_category)
			lds_contract_management_rights.setitem(ll_row,'types',4)
			lds_contract_management_rights.setitem(ll_row,'rights','41')	
		End If
	Next

	//---------------------------- APPEON END ----------------------------

	lds_contract_management_rights.Update()
	
	gnv_appeondb.of_startqueue( )	
	tab_security.tabpage_contract.uo_contract.dw_1.retrieve(al_role_id)
	tab_security.tabpage_contract.uo_contract.dw_2.retrieve(al_role_id)
	tab_security.tabpage_contract.uo_contract.dw_3.retrieve(al_role_id)
	tab_security.tabpage_contract.uo_contract.dw_4.retrieve(al_role_id)	
	gnv_appeondb.of_commitqueue( )
	
	ib_retrieve = False
	Destroy lds_code_lookup
	Destroy lds_contract_management_rights
End If

Return 1



end function

public subroutine of_contract_management_rights_tab ();//////////////////////////////////////////////////////////////////////
// $<function>w_security_roles_painter of_contract_management_rights_tab()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>Contract Management Rights.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.01.2006 by Jack (IntelliContract Agreement Manager Painters)
//////////////////////////////////////////////////////////////////////

If w_mdi.of_security_access( 6803 ) = 0 Then
	tab_security.tabpage_contract.visible = False
Else
   tab_security.tabpage_contract.visible = True
End If

end subroutine

public function integer of_tdl_rights ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-07 By: Allen
//$<reason> Setup Tdl Rights
IF Not gb_ToDoList THEN
	tab_security.tabpage_TDL.Visible = False
ELSE
	IF w_mdi.of_security_access( 5850 ) = 0 THEN
		IF tab_security.SelectedTab <> 3 THEN
			tab_security.SelectTab(1)
		END IF
		
		IF IsValid(w_todolist) THEN
			Close(w_todolist)
		END IF
		
		m_pfe_cst_master_menu.m_file.m_todolist.Visible = FALSE
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		//m_pfe_cst_master_menu.m_file.m_todolist.toolbaritemvisible = FALSE
		gnv_app.of_modify_menu_attr( m_pfe_cst_master_menu.m_file.m_todolist,'toolbaritemvisible', FALSE)
		//---------End Modfiied ------------------------------------------------------
		tab_security.tabpage_TDL.Visible = FALSE
	ELSE
		m_pfe_cst_master_menu.m_file.m_todolist.Visible = TRUE
		//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		//m_pfe_cst_master_menu.m_file.m_todolist.toolbaritemvisible = TRUE
		gnv_app.of_modify_menu_attr( m_pfe_cst_master_menu.m_file.m_todolist,'toolbaritemvisible', TRUE)
		//---------End Modfiied ------------------------------------------------------
		tab_security.tabpage_TDL.Visible = True
	END IF
END IF

Return 0
//---------------------------- APPEON END ----------------------------
end function

on w_security_roles_painter16.create
int iCurrent
call super::create
this.cb_rename=create cb_rename
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_copy=create cb_copy
this.cb_new=create cb_new
this.dw_select_role=create dw_select_role
this.tab_security=create tab_security
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rename
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_copy
this.Control[iCurrent+5]=this.cb_new
this.Control[iCurrent+6]=this.dw_select_role
this.Control[iCurrent+7]=this.tab_security
this.Control[iCurrent+8]=this.gb_select
end on

on w_security_roles_painter16.destroy
call super::destroy
destroy(this.cb_rename)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_copy)
destroy(this.cb_new)
destroy(this.dw_select_role)
destroy(this.tab_security)
destroy(this.gb_select)
end on

event open;call super::open;String 		ls_data //(Appeon)Harry 01.22.2014 - V142 ISG-CLX
tab_security.tabpage_roles.uo_roles.of_Set_Parent_Window( This )
//tab_security.tabpage_user.uo_user.of_Set_Parent_Window( This )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
//tab_security.tabpage_contract.uo_contract.iw_win = This
If gb_agreement_manager And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' Then
	of_contract_management_rights_tab()
Else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.25.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	tab_security.tabpage_contract.visible = False
	*/
	//Start Change By Jervis 08.04.2007
	//If gnv_data.of_getitem( "icred_settings", "set_51", FALSE) = '3' And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' Then
	//If (gnv_data.of_getitem( "icred_settings", "set_51", FALSE) = '3' or gb_contract_version)  And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' Then //04.10.2008 By Jervis
	if gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' then	//04.10.2008 By Jervis
	//End Change		
		tab_security.tabpage_contract.uo_contract.gb_1.width = 2684
		tab_security.tabpage_contract.uo_contract.gb_1.height = 1564

		tab_security.tabpage_contract.uo_contract.dw_1.width = tab_security.tabpage_contract.uo_contract.gb_1.width - 52
		tab_security.tabpage_contract.uo_contract.dw_1.height = tab_security.tabpage_contract.uo_contract.gb_1.height - 88
    	
		tab_security.tabpage_contract.uo_contract.dw_1.object.datawindow.zoom = 110

		tab_security.tabpage_contract.uo_contract.gb_2.visible = False
		tab_security.tabpage_contract.uo_contract.gb_3.visible = False
		tab_security.tabpage_contract.uo_contract.gb_4.visible = False	
		
		tab_security.tabpage_contract.uo_contract.dw_2.visible = False
		tab_security.tabpage_contract.uo_contract.dw_3.visible = False
		tab_security.tabpage_contract.uo_contract.dw_4.visible = False	
	Else
		tab_security.tabpage_contract.visible = False
	End If
	//---------------------------- APPEON END ----------------------------
End If

//Start Code Change ----12.14.2010 #V11 maha - sk security
if gb_sk_ver then
	cb_new.visible = false
	cb_copy.visible = false
	cb_delete.visible = false
end if
//End Code Change ----12.14.2010

//Start Code Change ----10.10.2012 #V12 maha
if gi_user_readonly = 1 then
	cb_new.visible = false
	cb_copy.visible = false
	cb_delete.visible = false
	cb_rename.visible = false
end if
//End Code Change ----10.10.2012

//Allen: To Do List Rights
tab_security.tabpage_tdl.uo_tdl.of_Set_Parent_Window( This )
of_tdl_rights()
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
//Begin - Added By Mark Lee 11/12/2012
If dw_select_role.rowcount( ) > 0 Then 
	ls_data = String(gnv_data.of_getitem('security_users','role_id',"user_id ='"+string(gs_user_id)+"'"))  
	IF not isnull(ls_data) Then 
		dw_select_role.setitem( dw_select_role.getrow(), 'role_id', Long(ls_data))
	End If
	dw_select_role.Post Event Itemchanged(dw_select_role.getrow(),dw_select_role.object.role_id,ls_data) //dynamic
End If
//End - Added By Mark Lee 11/12/2012
//---------End Added ------------------------------------------------------

end event

event pfc_save;call super::pfc_save;w_mdi.of_setup_security()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
IF gb_agreement_manager And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN
	of_contract_management_rights_tab()
ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.25.2007 By: Jack
	//$<reason> Fix a defect.
		/*
		tab_security.tabpage_contract.visible = False
	*/
	//--------Begin Modified by Nova 04.14.2008-----------
	//reason:fixed bug BugN041403(WEB&PB P2 )
	//If gnv_data.of_getitem( "icred_settings", "set_51", FALSE) = '3' And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' Then
	IF gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN
	//If gnv_data.of_getitem( "icred_settings", "set_51", FALSE) = '3' And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' Then
		tab_security.tabpage_contract.uo_contract.gb_1.Width = 2684
		tab_security.tabpage_contract.uo_contract.gb_1.Height = 1564
		
		tab_security.tabpage_contract.uo_contract.dw_1.Width = tab_security.tabpage_contract.uo_contract.gb_1.Width - 52
		tab_security.tabpage_contract.uo_contract.dw_1.Height = tab_security.tabpage_contract.uo_contract.gb_1.Height - 88
		
		tab_security.tabpage_contract.uo_contract.dw_1.Object.datawindow.zoom = 110
		
		tab_security.tabpage_contract.uo_contract.gb_2.Visible = False
		tab_security.tabpage_contract.uo_contract.gb_3.Visible = False
		tab_security.tabpage_contract.uo_contract.gb_4.Visible = False
		
		tab_security.tabpage_contract.uo_contract.dw_2.Visible = False
		tab_security.tabpage_contract.uo_contract.dw_3.Visible = False
		tab_security.tabpage_contract.uo_contract.dw_4.Visible = False
	ELSE
		tab_security.tabpage_contract.Visible = False
	END IF
	//---------------------------- APPEON END ----------------------------
END IF

//Allen: To Do List Rights
of_tdl_rights()
//---------------------------- APPEON END ----------------------------

if IsValid(w_Mdi) then w_Mdi.of_menu_security(w_Mdi.MenuName)		//Added by Scofield on 2010-01-13   //(Appeon)Eugene 06.20.2013 - V141 ISG-CLX

RETURN AncestorReturnValue

end event

event closequery;If Not tab_security.tabpage_roles.uo_roles.ib_update Then
	ib_closestatus = False
	Return 0
Else
	If Super::Event closequery() = 1 Then
		ib_closestatus = False
		Return 1
	End If	
End If

end event

type cb_rename from commandbutton within w_security_roles_painter16
integer x = 2331
integer y = 68
integer width = 338
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Rename"
end type

event clicked;//Start Code Change ----10.03.2012 #V12 maha
tab_security.tabpage_roles.uo_roles.of_rename() 
end event

type cb_close from u_cb within w_security_roles_painter16
integer x = 2706
integer y = 68
integer width = 338
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_delete from u_cb within w_security_roles_painter16
integer x = 1966
integer y = 68
integer width = 338
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete Role"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
of_delete()
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF tab_security.tabpage_roles.uo_roles.ii_id < 1 or&
   isnull(tab_security.tabpage_roles.uo_roles.ii_id ) THEN
	messagebox('Alert','Please first select a role.')
	return 
END IF
//---------------------------- APPEON END ----------------------------

IF tab_security.tabpage_roles.uo_roles.of_delete() < 0 THEN return
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.25.2006 By: Jack
//$<reason> 
tab_security.tabpage_contract.enabled = false
tab_security.tabpage_tdl.enabled = false

//Add by Jack 21.08.2007
tab_security.tabpage_contract.uo_contract.dw_1.reset()
tab_security.tabpage_contract.uo_contract.dw_2.reset()
tab_security.tabpage_contract.uo_contract.dw_3.reset()
tab_security.tabpage_contract.uo_contract.dw_4.reset()
tab_security.tabpage_tdl.uo_tdl.dw_tdl_role.reset()
tab_security.tabpage_tdl.uo_tdl.dw_select_user.reset()
tab_security.tabpage_tdl.uo_tdl.il_Role_id = 0  //Add by Jack 08.28.2007
long ll_role_id 
ll_role_id = tab_security.tabpage_roles.uo_roles.ii_id
delete from tdl_security_roles_rights Where role_id = :ll_role_id;
//End Add by Jack 21.08.2007

//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
tab_security.tabpage_roles.uo_roles.ii_id =-1
//---------------------------- APPEON END ----------------------------


end event

type cb_copy from u_cb within w_security_roles_painter16
integer x = 1586
integer y = 68
integer width = 338
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Copy &Role"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
of_copy_role(ii_id)
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF tab_security.tabpage_roles.uo_roles.ii_id < 1 or&
   isnull(tab_security.tabpage_roles.uo_roles.ii_id ) THEN
	messagebox('Alert','Please first select a role.')
	return 
END IF
//---------------------------- APPEON END ----------------------------

tab_security.tabpage_roles.uo_roles.of_copy_role(tab_security.tabpage_roles.uo_roles.ii_id)
//---------------------------- APPEON END ----------------------------
//of_enable_select_buttons()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.25.2006 By: Jack
//$<reason> 
tab_security.tabpage_contract.enabled = true
tab_security.tabpage_tdl.enabled = true
//---------------------------- APPEON END ----------------------------

end event

type cb_new from u_cb within w_security_roles_painter16
integer x = 1207
integer y = 68
integer width = 338
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Create Role"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
of_new(0)
*/
IF tab_security.tabpage_roles.uo_roles.of_new(0) < 0 THEN return
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.25.2006 By: Jack
//$<reason> 
tab_security.tabpage_contract.enabled = true
tab_security.tabpage_tdl.enabled = true

//---------------------------- APPEON END ----------------------------

end event

type dw_select_role from u_dw within w_security_roles_painter16
integer x = 50
integer y = 68
integer width = 1143
integer height = 92
integer taborder = 20
string dataobject = "d_security_select_roles"
boolean vscrollbar = false
boolean border = false
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
dw_select_role.of_SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------

This.Retrieve()
This.InsertRow( 0 )

This.of_SetUpdateable( False )
end event

event itemchanged;call super::itemchanged;This.AcceptText()
integer li_role //maha 07.12.2017

li_role = Integer(data)
tab_security.tabpage_roles.uo_roles.ii_id = li_role
ib_retrieve = True
//---------------------------- APPEON END ----------------------------



If tab_security.SelectedTab = 1 Then
	tab_security.tabpage_roles.uo_roles.ib_1 = true
	tab_security.tabpage_roles.uo_roles.ib_2 = true
//	tab_security.tabpage_roles.uo_roles.dw_modules.reset( )
//	tab_security.tabpage_roles.uo_roles.dw_sub_modules.reset()
	tab_security.tabpage_roles.uo_roles.dw_actions.Retrieve(li_role )
	//tab_security.tabpage_roles.uo_roles.of_filter_by_settings( ) //Start Code Change ----11.13.2012 #V12 maha
ElseIf tab_security.SelectedTab = 3 Then
	of_contract_management_rights(li_role)
ElseIf tab_security.SelectedTab = 4 Then	//To Do List by Allen
	tab_security.tabpage_tdl.uo_tdl.of_refresh(li_role)
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.25.2006 By: Jack
//$<reason> 
tab_security.tabpage_contract.enabled = true
tab_security.tabpage_tdl.enabled = true
tab_security.tabpage_roles.uo_roles.ib_update = False
//---------------------------- APPEON END ----------------------------

end event

type tab_security from tab within w_security_roles_painter16
event create ( )
event destroy ( )
integer y = 208
integer width = 3081
integer height = 2228
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_roles tabpage_roles
tabpage_user tabpage_user
tabpage_contract tabpage_contract
tabpage_tdl tabpage_tdl
end type

on tab_security.create
this.tabpage_roles=create tabpage_roles
this.tabpage_user=create tabpage_user
this.tabpage_contract=create tabpage_contract
this.tabpage_tdl=create tabpage_tdl
this.Control[]={this.tabpage_roles,&
this.tabpage_user,&
this.tabpage_contract,&
this.tabpage_tdl}
end on

on tab_security.destroy
destroy(this.tabpage_roles)
destroy(this.tabpage_user)
destroy(this.tabpage_contract)
destroy(this.tabpage_tdl)
end on

event selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
long ll_role_id
dw_select_role.accepttext()
If dw_select_role.getrow() <= 0 Then Return
ll_role_id = dw_select_role.getitemnumber(dw_select_role.getrow(),'role_id')

//Add by Jack 08.28.2007
If isnull(ll_role_id) or ll_role_id = 0 Then
//	tab_security.tabpage_roles.uo_roles.dw_modules.reset()
//	tab_security.tabpage_roles.uo_roles.dw_sub_modules.reset()
	tab_security.tabpage_roles.uo_roles.dw_actions.reset()
	Return
End If
//End add by Jack 08.28.2007

If newindex = 1 and oldindex <> -1 Then
	IF ll_role_id = tab_security.tabpage_roles.uo_roles.ii_id THEN RETURN
	tab_security.tabpage_roles.uo_roles.ib_1 = true
	tab_security.tabpage_roles.uo_roles.ib_2 = true
//	tab_security.tabpage_roles.uo_roles.dw_modules.reset( )
//	tab_security.tabpage_roles.uo_roles.dw_sub_modules.reset()
	tab_security.tabpage_roles.uo_roles.dw_actions.Retrieve( ll_role_id)
ElseIf newindex = 3 Then
	of_contract_management_rights(ll_role_id)
ElseIf newindex = 4 Then	//To Do List by Allen
	tab_security.tabpage_tdl.uo_tdl.of_refresh(ll_Role_id)
End If
//---------------------------- APPEON END ----------------------------

end event

event selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
long ll_role_id,ll_row
dw_select_role.accepttext()
ll_row = dw_select_role.getrow()
If ll_row > 0 Then
	ll_role_id = dw_select_role.getitemnumber(ll_row,'role_id')
End If
If isnull(ll_role_id) Or ll_role_id = 0 Then
	If newindex <> 1 Then
		Return 1
	End If
End If
//---------------------------- APPEON END ----------------------------

end event

type tabpage_roles from userobject within tab_security
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3045
integer height = 2112
long backcolor = 33551856
string text = "Roles"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_roles uo_roles
end type

on tabpage_roles.create
this.uo_roles=create uo_roles
this.Control[]={this.uo_roles}
end on

on tabpage_roles.destroy
destroy(this.uo_roles)
end on

type uo_roles from pfc_cst_u_security_roles_painter within tabpage_roles
event destroy ( )
integer x = 9
integer y = 24
integer width = 3031
integer height = 2112
integer taborder = 20
boolean bringtotop = true
integer ii_id = -1
end type

on uo_roles.destroy
call pfc_cst_u_security_roles_painter::destroy
end on

type tabpage_user from userobject within tab_security
boolean visible = false
integer x = 18
integer y = 100
integer width = 3045
integer height = 2112
long backcolor = 32891346
string text = "User Security"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_user uo_user
end type

on tabpage_user.create
this.uo_user=create uo_user
this.Control[]={this.uo_user}
end on

on tabpage_user.destroy
destroy(this.uo_user)
end on

type uo_user from pfc_cst_u_security_user_painter within tabpage_user
integer x = 64
integer y = 84
integer taborder = 30
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_user.destroy
call pfc_cst_u_security_user_painter::destroy
end on

type tabpage_contract from userobject within tab_security
integer x = 18
integer y = 100
integer width = 3045
integer height = 2112
boolean enabled = false
long backcolor = 33551856
string text = "Contract Management"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_contract uo_contract
end type

on tabpage_contract.create
this.uo_contract=create uo_contract
this.Control[]={this.uo_contract}
end on

on tabpage_contract.destroy
destroy(this.uo_contract)
end on

type uo_contract from pfc_cst_u_security_roles_painter_contrac within tabpage_contract
integer x = 50
integer y = 16
integer height = 1704
integer taborder = 30
end type

on uo_contract.destroy
call pfc_cst_u_security_roles_painter_contrac::destroy
end on

type tabpage_tdl from userobject within tab_security
string tag = "To Do List"
integer x = 18
integer y = 100
integer width = 3045
integer height = 2112
boolean enabled = false
long backcolor = 33551856
string text = "To Do List"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
string powertiptext = "To Do List"
uo_tdl uo_tdl
end type

on tabpage_tdl.create
this.uo_tdl=create uo_tdl
this.Control[]={this.uo_tdl}
end on

on tabpage_tdl.destroy
destroy(this.uo_tdl)
end on

type uo_tdl from pfc_cst_u_tdl_role_painter within tabpage_tdl
integer x = 55
integer y = 16
integer taborder = 30
end type

on uo_tdl.destroy
call pfc_cst_u_tdl_role_painter::destroy
end on

type gb_select from groupbox within w_security_roles_painter16
integer width = 3077
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Role"
end type

