$PBExportHeader$w_license_agree_setup.srw
forward
global type w_license_agree_setup from window
end type
type cb_3 from commandbutton within w_license_agree_setup
end type
type cb_2 from commandbutton within w_license_agree_setup
end type
type cb_1 from commandbutton within w_license_agree_setup
end type
type dw_agree from datawindow within w_license_agree_setup
end type
end forward

global type w_license_agree_setup from window
integer width = 3739
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_agree dw_agree
end type
global w_license_agree_setup w_license_agree_setup

event open;dw_agree.update()
end event

on w_license_agree_setup.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_agree=create dw_agree
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_agree}
end on

on w_license_agree_setup.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_agree)
end on

type cb_3 from commandbutton within w_license_agree_setup
integer x = 2469
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_agree.insertrow(1)
end event

type cb_2 from commandbutton within w_license_agree_setup
integer x = 2830
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_1 from commandbutton within w_license_agree_setup
integer x = 3191
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_agree from datawindow within w_license_agree_setup
integer x = 50
integer y = 180
integer width = 3483
integer height = 2148
integer taborder = 10
string title = "none"
string dataobject = "d_license_agreement_isg_setup"
end type

