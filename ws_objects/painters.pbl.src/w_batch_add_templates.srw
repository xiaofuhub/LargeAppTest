$PBExportHeader$w_batch_add_templates.srw
forward
global type w_batch_add_templates from window
end type
type dw_1 from datawindow within w_batch_add_templates
end type
type dw_tv from datawindow within w_batch_add_templates
end type
end forward

global type w_batch_add_templates from window
integer width = 3749
integer height = 1688
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
dw_tv dw_tv
end type
global w_batch_add_templates w_batch_add_templates

on w_batch_add_templates.create
this.dw_1=create dw_1
this.dw_tv=create dw_tv
this.Control[]={this.dw_1,&
this.dw_tv}
end on

on w_batch_add_templates.destroy
destroy(this.dw_1)
destroy(this.dw_tv)
end on

type dw_1 from datawindow within w_batch_add_templates
integer x = 1029
integer y = 64
integer width = 1083
integer height = 120
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_tv from datawindow within w_batch_add_templates
integer x = 37
integer y = 40
integer width = 942
integer height = 1404
integer taborder = 10
string title = "none"
string dataobject = "d_sys_batch_add_field_tv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

