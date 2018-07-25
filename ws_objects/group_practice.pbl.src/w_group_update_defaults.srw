$PBExportHeader$w_group_update_defaults.srw
forward
global type w_group_update_defaults from window
end type
type dw_1 from datawindow within w_group_update_defaults
end type
type cb_ok from commandbutton within w_group_update_defaults
end type
end forward

global type w_group_update_defaults from window
integer width = 1221
integer height = 1596
boolean titlebar = true
string title = "Group Location Update Defaults"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_ok cb_ok
end type
global w_group_update_defaults w_group_update_defaults

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_group_update_defaults.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.Control[]={this.dw_1,&
this.cb_ok}
end on

on w_group_update_defaults.destroy
destroy(this.dw_1)
destroy(this.cb_ok)
end on

type dw_1 from datawindow within w_group_update_defaults
integer x = 50
integer y = 28
integer width = 1115
integer height = 1308
integer taborder = 10
string title = "none"
string dataobject = "d_group_update_defaults"
boolean livescroll = true
end type

type cb_ok from commandbutton within w_group_update_defaults
integer x = 421
integer y = 1356
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

event clicked;dw_1.update()
close(parent)
end event

