$PBExportHeader$w_print_report.srw
forward
global type w_print_report from window
end type
type cb_c from commandbutton within w_print_report
end type
type dw_1 from datawindow within w_print_report
end type
type cb_print from commandbutton within w_print_report
end type
end forward

global type w_print_report from window
integer width = 2825
integer height = 2552
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_c cb_c
dw_1 dw_1
cb_print cb_print
end type
global w_print_report w_print_report

on w_print_report.create
this.cb_c=create cb_c
this.dw_1=create dw_1
this.cb_print=create cb_print
this.Control[]={this.cb_c,&
this.dw_1,&
this.cb_print}
end on

on w_print_report.destroy
destroy(this.cb_c)
destroy(this.dw_1)
destroy(this.cb_print)
end on

event open;integer i
debugbreak()
i = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(i)
end event

type cb_c from commandbutton within w_print_report
integer x = 2437
integer y = 2372
integer width = 343
integer height = 92
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

type dw_1 from datawindow within w_print_report
integer x = 46
integer y = 40
integer width = 2715
integer height = 2312
integer taborder = 10
string title = "none"
string dataobject = "d_role_print"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_print from commandbutton within w_print_report
integer x = 2071
integer y = 2376
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_1.print()
end event

