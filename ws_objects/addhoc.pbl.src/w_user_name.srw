$PBExportHeader$w_user_name.srw
forward
global type w_user_name from window
end type
type st_1 from statictext within w_user_name
end type
type sle_1 from singlelineedit within w_user_name
end type
type cb_1 from commandbutton within w_user_name
end type
end forward

global type w_user_name from window
integer x = 1056
integer y = 484
integer width = 1193
integer height = 340
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
sle_1 sle_1
cb_1 cb_1
end type
global w_user_name w_user_name

on w_user_name.create
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.sle_1,&
this.cb_1}
end on

on w_user_name.destroy
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
end on

type st_1 from statictext within w_user_name
integer x = 50
integer y = 44
integer width = 631
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Enter user name"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_user_name
integer x = 55
integer y = 136
integer width = 773
integer height = 92
integer taborder = 10
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

type cb_1 from commandbutton within w_user_name
integer x = 869
integer y = 136
integer width = 247
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

event clicked;string s

s = sle_1.text

if LenA(s) < 1 then
	//messagebox("???","Please enter user name")
	messagebox("Userame","Please enter a user name")
	return
end if

gs_user_id = s

close(parent)
end event

