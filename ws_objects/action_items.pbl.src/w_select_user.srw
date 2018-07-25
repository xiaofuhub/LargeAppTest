$PBExportHeader$w_select_user.srw
forward
global type w_select_user from window
end type
type st_1 from statictext within w_select_user
end type
type cb_2 from commandbutton within w_select_user
end type
type cb_1 from commandbutton within w_select_user
end type
type dw_1 from datawindow within w_select_user
end type
end forward

global type w_select_user from window
integer width = 928
integer height = 404
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_select_user w_select_user

type variables
string is_user_id = "Cancel"
end variables

on w_select_user.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_select_user.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type st_1 from statictext within w_select_user
integer x = 215
integer y = 20
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Selelct User"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_select_user
integer x = 494
integer y = 228
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn( parent, "Cancel" )
end event

type cb_1 from commandbutton within w_select_user
integer x = 87
integer y = 228
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;closewithreturn( parent, is_user_id )
end event

type dw_1 from datawindow within w_select_user
integer x = 160
integer y = 88
integer width = 480
integer height = 92
integer taborder = 10
string title = "none"
string dataobject = "d_select_user_for_audit_trail"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_user_id = data
end event

event constructor;this.settransobject(sqlca)
this.insertrow(1)
end event

