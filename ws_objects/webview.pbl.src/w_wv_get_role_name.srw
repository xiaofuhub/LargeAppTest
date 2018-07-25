$PBExportHeader$w_wv_get_role_name.srw
forward
global type w_wv_get_role_name from window
end type
type cb_2 from commandbutton within w_wv_get_role_name
end type
type cb_1 from commandbutton within w_wv_get_role_name
end type
type st_1 from statictext within w_wv_get_role_name
end type
type sle_name from singlelineedit within w_wv_get_role_name
end type
end forward

global type w_wv_get_role_name from window
integer width = 1751
integer height = 460
boolean titlebar = true
string title = "Get Role Name"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_name sle_name
end type
global w_wv_get_role_name w_wv_get_role_name

type variables
string is_Return
end variables

on w_wv_get_role_name.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_name=create sle_name
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_name}
end on

on w_wv_get_role_name.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_name)
end on

event close;CloseWithReturn(this, is_Return)
end event

type cb_2 from commandbutton within w_wv_get_role_name
integer x = 1381
integer y = 168
integer width = 329
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_wv_get_role_name
integer x = 1047
integer y = 168
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Get new role name
// $<add> (Appeon) evan 02.16.2012
//====================================================================

string ls_role_name

is_Return = Trim(sle_name.Text)
if is_Return = "" then
	MessageBox("Prompt", "Please enter a role name.")
	sle_name.SetFocus()
	Return
end if

select role_name into :ls_role_name
from wv_security_role
where role_name = :is_Return;
 
if Len(ls_role_name) > 0 then
	is_Return = ""
	MessageBox("Warning", "Current role already exists. Please create a new one.", Exclamation!)
	Return
END IF

Close(Parent)
end event

type st_1 from statictext within w_wv_get_role_name
integer x = 37
integer y = 104
integer width = 910
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please enter a new name for the role:"
boolean focusrectangle = false
end type

type sle_name from singlelineedit within w_wv_get_role_name
integer x = 37
integer y = 172
integer width = 983
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

