$PBExportHeader$w_fppe_dept_criteria_de.srw
forward
global type w_fppe_dept_criteria_de from window
end type
type dw_1 from datawindow within w_fppe_dept_criteria_de
end type
end forward

global type w_fppe_dept_criteria_de from window
integer width = 3168
integer height = 1464
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
global w_fppe_dept_criteria_de w_fppe_dept_criteria_de

on w_fppe_dept_criteria_de.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_fppe_dept_criteria_de.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_fppe_dept_criteria_de
integer x = 27
integer y = 28
integer width = 3003
integer height = 1244
integer taborder = 10
string title = "none"
string dataobject = "d_fppe_dept_criteria_de"
boolean livescroll = true
end type

