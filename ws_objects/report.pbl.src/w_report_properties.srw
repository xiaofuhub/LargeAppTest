$PBExportHeader$w_report_properties.srw
forward
global type w_report_properties from window
end type
type cb_ok from commandbutton within w_report_properties
end type
type dw_1 from datawindow within w_report_properties
end type
end forward

global type w_report_properties from window
integer width = 3131
integer height = 1436
boolean titlebar = true
string title = "Report Properties"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
dw_1 dw_1
end type
global w_report_properties w_report_properties

on w_report_properties.create
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_ok,&
this.dw_1}
end on

on w_report_properties.destroy
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;//Created 1/6/2012 - Nichole

integer li_rpt_id

li_rpt_id = message.doubleparm

dw_1.settransobject(sqlca)

dw_1.retrieve(li_rpt_id)
end event

type cb_ok from commandbutton within w_report_properties
integer x = 1303
integer y = 1232
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
boolean default = true
end type

event clicked;close (parent)
end event

type dw_1 from datawindow within w_report_properties
integer width = 3122
integer height = 1192
integer taborder = 10
string title = "none"
string dataobject = "d_report_prop_info"
boolean controlmenu = true
boolean vscrollbar = true
boolean livescroll = true
end type

