$PBExportHeader$w_display_only_status.srw
forward
global type w_display_only_status from window
end type
type rb_e from radiobutton within w_display_only_status
end type
type rb_d from radiobutton within w_display_only_status
end type
type cb_2 from commandbutton within w_display_only_status
end type
type cb_1 from commandbutton within w_display_only_status
end type
end forward

global type w_display_only_status from window
integer x = 1056
integer y = 484
integer width = 1051
integer height = 456
windowtype windowtype = response!
long backcolor = 16777215
rb_e rb_e
rb_d rb_d
cb_2 cb_2
cb_1 cb_1
end type
global w_display_only_status w_display_only_status

on w_display_only_status.create
this.rb_e=create rb_e
this.rb_d=create rb_d
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.rb_e,&
this.rb_d,&
this.cb_2,&
this.cb_1}
end on

on w_display_only_status.destroy
destroy(this.rb_e)
destroy(this.rb_d)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type rb_e from radiobutton within w_display_only_status
integer x = 160
integer y = 188
integer width = 709
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Set All Fields Editable  "
boolean lefttext = true
end type

type rb_d from radiobutton within w_display_only_status
integer x = 160
integer y = 80
integer width = 709
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Set All Fields Display Only  "
boolean checked = true
boolean lefttext = true
end type

type cb_2 from commandbutton within w_display_only_status
integer x = 539
integer y = 304
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_display_only_status
integer x = 283
integer y = 304
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;string s

if rb_d.checked then
	s = "D"
else
	s = "E"
end if


closewithreturn(parent,s)
end event

