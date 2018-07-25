$PBExportHeader$w_missing_data_report.srw
forward
global type w_missing_data_report from window
end type
type dw_1 from datawindow within w_missing_data_report
end type
end forward

global type w_missing_data_report from window
integer width = 4114
integer height = 2196
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_missing_data_report w_missing_data_report

on w_missing_data_report.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_missing_data_report.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_missing_data_report
integer x = 46
integer y = 192
integer width = 3611
integer height = 1680
integer taborder = 10
string title = "none"
string dataobject = "d_data_sys_field_required_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

