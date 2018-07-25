$PBExportHeader$w_priv_report_select.srw
forward
global type w_priv_report_select from window
end type
type cb_mock from commandbutton within w_priv_report_select
end type
type cb_11 from commandbutton within w_priv_report_select
end type
type cb_alt from commandbutton within w_priv_report_select
end type
end forward

global type w_priv_report_select from window
integer width = 1701
integer height = 456
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_mock cb_mock
cb_11 cb_11
cb_alt cb_alt
end type
global w_priv_report_select w_priv_report_select

on w_priv_report_select.create
this.cb_mock=create cb_mock
this.cb_11=create cb_11
this.cb_alt=create cb_alt
this.Control[]={this.cb_mock,&
this.cb_11,&
this.cb_alt}
end on

on w_priv_report_select.destroy
destroy(this.cb_mock)
destroy(this.cb_11)
destroy(this.cb_alt)
end on

type cb_mock from commandbutton within w_priv_report_select
integer x = 1083
integer y = 120
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Priv Reports"
end type

event clicked;open(w_privilege_report_mockup)
end event

type cb_11 from commandbutton within w_priv_report_select
integer x = 594
integer y = 116
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ver 11"
end type

event clicked;open(w_privilege_report)
end event

type cb_alt from commandbutton within w_priv_report_select
integer x = 155
integer y = 112
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "ver 11 alt"
end type

event clicked;open(w_privilege_report_10)
end event

