$PBExportHeader$w_help_setup.srw
forward
global type w_help_setup from window
end type
type cb_add from commandbutton within w_help_setup
end type
type cb_save from commandbutton within w_help_setup
end type
type cb_1 from commandbutton within w_help_setup
end type
type rb_my from radiobutton within w_help_setup
end type
type rb_sys from radiobutton within w_help_setup
end type
type gb_1 from groupbox within w_help_setup
end type
type dw_1 from datawindow within w_help_setup
end type
end forward

global type w_help_setup from window
integer width = 3977
integer height = 2632
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_add cb_add
cb_save cb_save
cb_1 cb_1
rb_my rb_my
rb_sys rb_sys
gb_1 gb_1
dw_1 dw_1
end type
global w_help_setup w_help_setup

on w_help_setup.create
this.cb_add=create cb_add
this.cb_save=create cb_save
this.cb_1=create cb_1
this.rb_my=create rb_my
this.rb_sys=create rb_sys
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.cb_add,&
this.cb_save,&
this.cb_1,&
this.rb_my,&
this.rb_sys,&
this.gb_1,&
this.dw_1}
end on

on w_help_setup.destroy
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.cb_1)
destroy(this.rb_my)
destroy(this.rb_sys)
destroy(this.gb_1)
destroy(this.dw_1)
end on

type cb_add from commandbutton within w_help_setup
integer x = 2752
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_1.insertrow(1)
end event

type cb_save from commandbutton within w_help_setup
integer x = 2304
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
string text = "Save"
end type

event clicked;dw_1.update()
end event

type cb_1 from commandbutton within w_help_setup
integer x = 3570
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
string text = "Close"
end type

event clicked;close(parent)
end event

type rb_my from radiobutton within w_help_setup
integer x = 539
integer y = 84
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "My Help"
end type

type rb_sys from radiobutton within w_help_setup
integer x = 215
integer y = 80
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "System"
boolean checked = true
end type

type gb_1 from groupbox within w_help_setup
integer x = 69
integer y = 24
integer width = 997
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "System/Personal"
end type

type dw_1 from datawindow within w_help_setup
integer x = 41
integer y = 224
integer width = 3872
integer height = 2280
integer taborder = 10
string title = "none"
string dataobject = "d_help_display_setup"
boolean livescroll = true
end type

