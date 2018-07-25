$PBExportHeader$w_var_test.srw
forward
global type w_var_test from window
end type
type cb_1 from commandbutton within w_var_test
end type
end forward

global type w_var_test from window
integer width = 818
integer height = 608
boolean titlebar = true
string title = "Variable"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_var_test w_var_test

on w_var_test.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_var_test.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_var_test
integer x = 197
integer y = 136
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;messagebox("gs_odbc",gs_odbc)
end event

