$PBExportHeader$w_create_db.srw
forward
global type w_create_db from window
end type
type cb_1 from commandbutton within w_create_db
end type
end forward

global type w_create_db from window
integer width = 2482
integer height = 1512
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
end type
global w_create_db w_create_db

on w_create_db.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_create_db.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_create_db
integer x = 421
integer y = 232
integer width = 1367
integer height = 788
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Tables"
end type

event clicked;
debugbreak()
f_wc_create_database ()
end event

