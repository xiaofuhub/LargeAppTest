$PBExportHeader$w_report_wiz_copy_select.srw
forward
global type w_report_wiz_copy_select from window
end type
type cb_close from commandbutton within w_report_wiz_copy_select
end type
type cb_ok from commandbutton within w_report_wiz_copy_select
end type
type dw_reports from datawindow within w_report_wiz_copy_select
end type
end forward

global type w_report_wiz_copy_select from window
integer width = 1490
integer height = 512
boolean titlebar = true
string title = "Select Report  to copy to"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_ok cb_ok
dw_reports dw_reports
end type
global w_report_wiz_copy_select w_report_wiz_copy_select

type variables
integer rep
end variables

on w_report_wiz_copy_select.create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_reports=create dw_reports
this.Control[]={this.cb_close,&
this.cb_ok,&
this.dw_reports}
end on

on w_report_wiz_copy_select.destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_reports)
end on

type cb_close from commandbutton within w_report_wiz_copy_select
integer x = 1015
integer y = 240
integer width = 302
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_ok from commandbutton within w_report_wiz_copy_select
integer x = 649
integer y = 240
integer width = 302
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;closewithreturn(parent,rep)
end event

type dw_reports from datawindow within w_report_wiz_copy_select
integer x = 87
integer y = 92
integer width = 1211
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_report_names"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;rep = integer(data)
end event

