$PBExportHeader$w_button_template_roles.srw
forward
global type w_button_template_roles from window
end type
type cb_close from commandbutton within w_button_template_roles
end type
type cb_save from commandbutton within w_button_template_roles
end type
type dw_1 from datawindow within w_button_template_roles
end type
end forward

global type w_button_template_roles from window
integer width = 1888
integer height = 1900
boolean titlebar = true
string title = "Role Button Templates"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
dw_1 dw_1
end type
global w_button_template_roles w_button_template_roles

on w_button_template_roles.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.cb_close,&
this.cb_save,&
this.dw_1}
end on

on w_button_template_roles.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_close from commandbutton within w_button_template_roles
integer x = 1486
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
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

type cb_save from commandbutton within w_button_template_roles
integer x = 1125
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type dw_1 from datawindow within w_button_template_roles
integer x = 32
integer y = 132
integer width = 1801
integer height = 1648
integer taborder = 10
string title = "none"
string dataobject = "d_roles_with_template"
boolean livescroll = true
end type

