$PBExportHeader$w_date_format_test.srw
forward
global type w_date_format_test from window
end type
type cb_2 from commandbutton within w_date_format_test
end type
type cb_1 from commandbutton within w_date_format_test
end type
type dw_1 from datawindow within w_date_format_test
end type
end forward

global type w_date_format_test from window
integer width = 2807
integer height = 1988
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_date_format_test w_date_format_test

on w_date_format_test.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_date_format_test.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_date_format_test
integer x = 599
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
string text = "Test"
end type

event clicked;integer r
integer rc
string s
date d
datetime dt

rc = dw_1.rowcount()

for r =  1 to rc
	s = dw_1.getitemstring(r,1)
	d = date(s)
	s = string (d)
	dt = datetime(d, time('00:00:00')) 
	dw_1.setitem(r,3,dt)
	dw_1.setitem(r,2, s)
next

end event

type cb_1 from commandbutton within w_date_format_test
integer x = 119
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
string text = "Add"
end type

event clicked;dw_1.insertrow(0)
end event

type dw_1 from datawindow within w_date_format_test
integer x = 46
integer y = 208
integer width = 2647
integer height = 1600
integer taborder = 10
string title = "none"
string dataobject = "d_date_format_test"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

