$PBExportHeader$w_app_dupe_choices.srw
forward
global type w_app_dupe_choices from window
end type
type sle_1 from singlelineedit within w_app_dupe_choices
end type
type rb_3 from radiobutton within w_app_dupe_choices
end type
type rb_2 from radiobutton within w_app_dupe_choices
end type
type rb_1 from radiobutton within w_app_dupe_choices
end type
type st_1 from statictext within w_app_dupe_choices
end type
type cb_4 from commandbutton within w_app_dupe_choices
end type
type cb_3 from commandbutton within w_app_dupe_choices
end type
type cb_2 from commandbutton within w_app_dupe_choices
end type
type cb_1 from commandbutton within w_app_dupe_choices
end type
end forward

global type w_app_dupe_choices from window
integer x = 882
integer y = 624
integer width = 1609
integer height = 720
boolean titlebar = true
string title = "Duplicate Application Name"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
sle_1 sle_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_app_dupe_choices w_app_dupe_choices

type variables
string is_name
end variables

on w_app_dupe_choices.create
this.sle_1=create sle_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_app_dupe_choices.destroy
destroy(this.sle_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//maha 072004 called from w_import_apps

is_name = message.stringparm

st_1.text = "There currently is an application named " + is_name + " in the system. ~r What do you want to do with the application name?"

sle_1.text = is_name
end event

type sle_1 from singlelineedit within w_app_dupe_choices
integer x = 46
integer y = 324
integer width = 1477
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_3 from radiobutton within w_app_dupe_choices
integer x = 123
integer y = 1108
integer width = 1573
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Update connected Template and Application Action Item data "
end type

type rb_2 from radiobutton within w_app_dupe_choices
integer x = 123
integer y = 1016
integer width = 1573
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Delete old Application"
end type

type rb_1 from radiobutton within w_app_dupe_choices
integer x = 123
integer y = 932
integer width = 1573
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rename new Application"
end type

type st_1 from statictext within w_app_dupe_choices
integer x = 46
integer y = 36
integer width = 1509
integer height = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "There currently is an application named + ai_name + in the system.  What do you want to do with the new app?"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_app_dupe_choices
integer x = 539
integer y = 452
integer width = 485
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Rename New"
end type

event clicked;string s

if LenA(sle_1.text) < 1 then
	messagebox("","Enter New Name")
	return
else
	s = "N*" + sle_1.text
	closewithreturn(parent,s)
end if
end event

type cb_3 from commandbutton within w_app_dupe_choices
integer x = 1033
integer y = 452
integer width = 512
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add as Downloaded"
end type

event clicked;string s

	s = "C"
	closewithreturn(parent,s)

end event

type cb_2 from commandbutton within w_app_dupe_choices
integer x = 1783
integer y = 1024
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Replace "
end type

type cb_1 from commandbutton within w_app_dupe_choices
integer x = 46
integer y = 452
integer width = 485
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Rename Original"
end type

event clicked;string s

if LenA(sle_1.text) < 1 then
	messagebox("","Enter New Name")
	return
else
	s = "O*" + sle_1.text
	closewithreturn(parent,s)
end if
end event

