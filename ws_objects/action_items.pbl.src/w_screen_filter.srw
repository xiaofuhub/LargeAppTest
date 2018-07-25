$PBExportHeader$w_screen_filter.srw
$PBExportComments$not used 8-03
forward
global type w_screen_filter from window
end type
type st_1 from statictext within w_screen_filter
end type
type cb_2 from commandbutton within w_screen_filter
end type
type cb_1 from commandbutton within w_screen_filter
end type
type dw_1 from datawindow within w_screen_filter
end type
end forward

global type w_screen_filter from window
integer x = 1056
integer y = 484
integer width = 965
integer height = 488
boolean titlebar = true
string title = "Screen Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_screen_filter w_screen_filter

type variables
integer ii_screen
end variables

on w_screen_filter.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_screen_filter.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.insertrow(1)
end event

type st_1 from statictext within w_screen_filter
integer x = 73
integer y = 36
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
string text = "Select Screen"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_screen_filter
integer x = 480
integer y = 264
integer width = 201
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,-1)
end event

type cb_1 from commandbutton within w_screen_filter
integer x = 206
integer y = 264
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;closewithreturn(parent,ii_screen)
end event

type dw_1 from datawindow within w_screen_filter
integer x = 55
integer y = 104
integer width = 846
integer height = 88
integer taborder = 10
string dataobject = "d_select_screen_name"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_screen = integer(data)
end event

