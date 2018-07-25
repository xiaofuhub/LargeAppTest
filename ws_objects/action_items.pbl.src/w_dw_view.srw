$PBExportHeader$w_dw_view.srw
forward
global type w_dw_view from window
end type
type cb_3 from commandbutton within w_dw_view
end type
type dw_1 from datawindow within w_dw_view
end type
type cb_2 from commandbutton within w_dw_view
end type
type cb_1 from commandbutton within w_dw_view
end type
end forward

global type w_dw_view from window
integer x = 110
integer y = 128
integer width = 4411
integer height = 2732
boolean titlebar = true
string title = "NPDB Processing Exceptions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
cb_3 cb_3
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
end type
global w_dw_view w_dw_view

event open;//string ls_mess
//
//ls_mess = "EXCEPTIONS:~r~r" + message.stringparm
//
////messagebox("ls_mess",ls_mess )
//
//dw_1.settransobject(sqlca)
//dw_1.retrieve()
//dw_1.setitem(1,"print_space",ls_mess)
end event

on w_dw_view.create
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.dw_1,&
this.cb_2,&
this.cb_1}
end on

on w_dw_view.destroy
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_dw_view
integer x = 763
integer y = 60
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "add"
end type

event clicked;dw_1.insertrow(0)
end event

type dw_1 from datawindow within w_dw_view
integer x = 59
integer y = 212
integer width = 4233
integer height = 1268
integer taborder = 30
string dataobject = "d_npdb_exceptions"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_dw_view
integer x = 1769
integer y = 20
integer width = 247
integer height = 108
integer taborder = 20
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

type cb_1 from commandbutton within w_dw_view
integer x = 201
integer y = 36
integer width = 393
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print "
end type

event clicked;dw_1.print()
end event

