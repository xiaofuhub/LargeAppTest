$PBExportHeader$w_field_type_test.srw
forward
global type w_field_type_test from window
end type
type cb_1 from commandbutton within w_field_type_test
end type
type dw_1 from datawindow within w_field_type_test
end type
end forward

global type w_field_type_test from window
integer width = 1659
integer height = 944
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_field_type_test w_field_type_test

on w_field_type_test.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_field_type_test.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_field_type_test
integer x = 466
integer y = 520
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;string s

s = dw_1.Describe( "code.ColType") 

if left(s,3) = "cha" or left(s, 3) = "var" then
	s = of_strip_char("",s,"@NUM@" )
end if

messagebox("",s)
end event

type dw_1 from datawindow within w_field_type_test
integer x = 352
integer y = 28
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve("Action Type")



end event

