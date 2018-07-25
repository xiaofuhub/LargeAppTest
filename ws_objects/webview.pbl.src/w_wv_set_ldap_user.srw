$PBExportHeader$w_wv_set_ldap_user.srw
forward
global type w_wv_set_ldap_user from window
end type
type cb_close from commandbutton within w_wv_set_ldap_user
end type
type cb_save from commandbutton within w_wv_set_ldap_user
end type
type cb_del from commandbutton within w_wv_set_ldap_user
end type
type cb_add from commandbutton within w_wv_set_ldap_user
end type
type cb_reload from commandbutton within w_wv_set_ldap_user
end type
type dw_detail from u_dw within w_wv_set_ldap_user
end type
type dw_list from u_dw within w_wv_set_ldap_user
end type
end forward

global type w_wv_set_ldap_user from window
integer x = 215
integer y = 220
integer width = 2318
integer height = 1292
boolean titlebar = true
string title = "Initial LDAP Users"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
cb_del cb_del
cb_add cb_add
cb_reload cb_reload
dw_detail dw_detail
dw_list dw_list
end type
global w_wv_set_ldap_user w_wv_set_ldap_user

type variables
boolean ib_new = false
string    is_appname
end variables

forward prototypes
public subroutine of_retrieve_detail (integer ai_row)
end prototypes

public subroutine of_retrieve_detail (integer ai_row);//////////////////////////////////////////////////////////////////////
// $<function> of_retrieve_detail
// $<arguments>
// $<returns> none
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_appname, ls_user

if ai_row < 1 then return 
dw_list.selectrow(0, false)
dw_list.selectrow(ai_row, true)
dw_list.scrolltorow(ai_row)
ls_appname = dw_list.getitemstring(ai_row, "appname")
ls_user        = dw_list.getitemstring(ai_row, "useralias")
dw_detail.retrieve(ls_appname, ls_user)

end subroutine

on w_wv_set_ldap_user.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_reload=create cb_reload
this.dw_detail=create dw_detail
this.dw_list=create dw_list
this.Control[]={this.cb_close,&
this.cb_save,&
this.cb_del,&
this.cb_add,&
this.cb_reload,&
this.dw_detail,&
this.dw_list}
end on

on w_wv_set_ldap_user.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_reload)
destroy(this.dw_detail)
destroy(this.dw_list)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
is_appname = message.stringparm

dw_list.retrieve(is_appname)
if dw_list.rowcount() > 0 then 
	of_retrieve_detail(1)
else
	cb_add.event clicked()
end if
end event

event closequery;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance  (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
integer li_Result
dwitemstatus ldws_user, ldws_dn

dw_detail.accepttext()
if dw_detail.modifiedcount() > 0  then
	ldws_user = dw_detail.getitemstatus(1,"useralias",primary!)
	ldws_dn    = dw_detail.getitemstatus(1,"userdn",primary!)
	if dw_list.rowcount() = 1 and not(ldws_user = datamodified! or ldws_user = newmodified! or ldws_dn = datamodified! or ldws_dn = newmodified!) then return 0
	li_Result = MessageBox("Save", "Do you want to save changes?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			if cb_save.event clicked() = -1 then return 1
		case 2
			return 0
		case 3
			return 1
	end choose
	
end if
return 0
end event

type cb_close from commandbutton within w_wv_set_ldap_user
integer x = 1943
integer y = 36
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> Close window (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 03.20.2012 by Evan
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_save from commandbutton within w_wv_set_ldap_user
integer x = 32
integer y = 36
integer width = 453
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save User Alias"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_alias, ls_dn
integer li_row, li_cnt

if dw_detail.accepttext() = -1 then return -1
if dw_detail.getrow() < 1 then return 0

li_row = dw_detail.getrow()
ls_alias = dw_detail.getitemstring(li_row, "useralias")
ls_dn    = dw_detail.getitemstring(li_row, "userdn")

if isnull(ls_alias) or ls_alias = '' then
	messagebox("Prompt", "User Alias  is required.")
	dw_detail.setcolumn("useralias")
	return -1
end if

if ib_new then
	select count(1) into :li_cnt from wv_ldap_users where appname = :is_appname and useralias = :ls_alias;
	if li_cnt > 0 then
		messagebox("Prompt", "User Alias must  be unique.")
		return -1
	end if
end if

if isnull(ls_dn) or ls_dn = '' then
	messagebox("Prompt", "User DN  is required.")
	dw_detail.setcolumn("userdn")
	return -1
end if

if dw_detail.update() = 1 then
	commit using sqlca;
	ib_new = false
	cb_reload.event clicked()
	li_row = dw_list.find("useralias = '"+ls_alias+"'",1, dw_list.rowcount())
	of_retrieve_detail(li_row)
else
	MessageBox("Error", "Failed to save data.", StopSign!)
	rollback using sqlca;
	return -1
end if

end event

type cb_del from commandbutton within w_wv_set_ldap_user
integer x = 855
integer y = 36
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

if dw_detail.getrow() < 1 then return

if ib_new then
	dw_detail.deleterow(0)
	ib_new = false
else
	if messagebox("Prompt", "Are you sure you want to delete this user alias ?",Exclamation!, yesno!) = 1 then
		dw_detail.deleterow(0)
		
		if dw_detail.update() = 1 then 
			commit using sqlca;
		else
			MessageBox("Delete Error", SQLCA.SQLERRTEXT )
			rollback using sqlca;
			Return -1
		end if
		
	end if
end if

cb_reload.event clicked()
end event

type cb_add from commandbutton within w_wv_set_ldap_user
integer x = 498
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_row

if ib_new = false then
	ib_new = true
	dw_detail.reset()
	ll_row = dw_detail.insertrow(0)
	dw_detail.setitem(ll_row, "appname", is_appname)
	ll_row = dw_list.insertrow(0)
	dw_list.scrolltorow(ll_row)
	dw_list.selectrow(0, false)
	dw_list.selectrow(ll_row, true)
end if
end event

type cb_reload from commandbutton within w_wv_set_ldap_user
integer x = 1216
integer y = 36
integer width = 366
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reload Users"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

if ib_new then ib_new = false
dw_list.retrieve(is_appname)
if dw_list.rowcount() > 0 then 
	of_retrieve_detail(1)
else
	cb_add.event clicked()
end if
end event

type dw_detail from u_dw within w_wv_set_ldap_user
integer x = 18
integer y = 804
integer width = 2267
integer height = 384
integer taborder = 20
string dataobject = "d_wv_ldap_user_detail"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

type dw_list from u_dw within w_wv_set_ldap_user
integer x = 18
integer y = 136
integer width = 2267
integer height = 656
integer taborder = 10
string dataobject = "d_wv_ldap_user_list"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.01.2012 by Stephen
//////////////////////////////////////////////////////////////////////

if currentrow < 1 or ib_new then return
of_retrieve_detail(currentrow)
end event

