$PBExportHeader$w_init_recred_filter.srw
$PBExportComments$not used 8-03
forward
global type w_init_recred_filter from window
end type
type ddlb_1 from dropdownlistbox within w_init_recred_filter
end type
type cb_2 from commandbutton within w_init_recred_filter
end type
type cb_1 from commandbutton within w_init_recred_filter
end type
end forward

global type w_init_recred_filter from window
integer x = 1120
integer y = 1012
integer width = 942
integer height = 556
boolean titlebar = true
string title = "Appointment Type Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
ddlb_1 ddlb_1
cb_2 cb_2
cb_1 cb_1
end type
global w_init_recred_filter w_init_recred_filter

type variables
string is_type
end variables

on w_init_recred_filter.create
this.ddlb_1=create ddlb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.ddlb_1,&
this.cb_2,&
this.cb_1}
end on

on w_init_recred_filter.destroy
destroy(this.ddlb_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type ddlb_1 from dropdownlistbox within w_init_recred_filter
integer x = 183
integer y = 92
integer width = 553
integer height = 304
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Initial","Recredential","All"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	is_type = "I"
elseif index = 2 then
	is_type = "R"
else
	is_type = "A"
end if
end event

type cb_2 from commandbutton within w_init_recred_filter
integer x = 466
integer y = 228
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_1 from commandbutton within w_init_recred_filter
integer x = 197
integer y = 228
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;closewithreturn(parent,is_type)
end event

