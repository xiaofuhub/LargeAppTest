$PBExportHeader$w_load_file_oppe.srw
forward
global type w_load_file_oppe from window
end type
type cb_1 from commandbutton within w_load_file_oppe
end type
end forward

global type w_load_file_oppe from window
integer width = 4133
integer height = 1900
boolean titlebar = true
string title = "Load Document"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_load_file_oppe w_load_file_oppe

on w_load_file_oppe.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_load_file_oppe.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_load_file_oppe
integer x = 2601
integer y = 60
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

