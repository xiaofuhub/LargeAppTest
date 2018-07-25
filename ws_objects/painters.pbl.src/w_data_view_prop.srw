$PBExportHeader$w_data_view_prop.srw
forward
global type w_data_view_prop from w_response
end type
type cb_2 from commandbutton within w_data_view_prop
end type
type cb_1 from commandbutton within w_data_view_prop
end type
type dw_prop from datawindow within w_data_view_prop
end type
end forward

global type w_data_view_prop from w_response
integer x = 214
integer y = 221
integer width = 2665
integer height = 516
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_prop dw_prop
end type
global w_data_view_prop w_data_view_prop

on w_data_view_prop.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_prop=create dw_prop
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_prop
end on

on w_data_view_prop.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_prop)
end on

event open;call super::open;integer li_view

li_view = message.doubleparm
dw_prop.settransobject(sqlca)
dw_prop.retrieve(li_view)
end event

type cb_2 from commandbutton within w_data_view_prop
integer x = 1321
integer y = 372
integer width = 402
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

event clicked;closewithreturn(parent, "Cancel")
end event

type cb_1 from commandbutton within w_data_view_prop
integer x = 905
integer y = 372
integer width = 402
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

event clicked;dw_prop.update()

closewithreturn(parent, "Update")
end event

type dw_prop from datawindow within w_data_view_prop
integer x = 37
integer y = 28
integer width = 2560
integer height = 316
integer taborder = 10
string title = "none"
string dataobject = "d_data_view_properties"
boolean livescroll = true
end type

