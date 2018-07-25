$PBExportHeader$w_audit_entity_delete.srw
forward
global type w_audit_entity_delete from window
end type
type cb_2 from commandbutton within w_audit_entity_delete
end type
type cb_1 from commandbutton within w_audit_entity_delete
end type
type dw_main from datawindow within w_audit_entity_delete
end type
end forward

global type w_audit_entity_delete from window
integer width = 3566
integer height = 1924
boolean titlebar = true
string title = "Deleted Providers"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_main dw_main
end type
global w_audit_entity_delete w_audit_entity_delete

on w_audit_entity_delete.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_main=create dw_main
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_main}
end on

on w_audit_entity_delete.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_main)
end on

type cb_2 from commandbutton within w_audit_entity_delete
integer x = 2766
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
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_main.SetSort(null_str)

dw_main.Sort( )
end event

type cb_1 from commandbutton within w_audit_entity_delete
integer x = 3141
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
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_main from datawindow within w_audit_entity_delete
integer x = 55
integer y = 156
integer width = 3415
integer height = 1584
integer taborder = 10
string title = "none"
string dataobject = "d_audit_entity_delete"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

