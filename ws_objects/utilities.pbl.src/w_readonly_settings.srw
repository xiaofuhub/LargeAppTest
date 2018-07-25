$PBExportHeader$w_readonly_settings.srw
forward
global type w_readonly_settings from window
end type
type dw_1 from datawindow within w_readonly_settings
end type
type cb_1 from commandbutton within w_readonly_settings
end type
end forward

global type w_readonly_settings from window
integer width = 2395
integer height = 1628
boolean titlebar = true
string title = "Read Only Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_1 cb_1
end type
global w_readonly_settings w_readonly_settings

on w_readonly_settings.create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_1}
end on

on w_readonly_settings.destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from datawindow within w_readonly_settings
integer x = 41
integer y = 28
integer width = 2290
integer height = 1344
integer taborder = 10
string title = "none"
string dataobject = "d_icred_set_readonly"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within w_readonly_settings
integer x = 955
integer y = 1400
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

