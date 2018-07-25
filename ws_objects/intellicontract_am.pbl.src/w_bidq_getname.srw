$PBExportHeader$w_bidq_getname.srw
forward
global type w_bidq_getname from window
end type
type cb_cancel from commandbutton within w_bidq_getname
end type
type cb_ok from commandbutton within w_bidq_getname
end type
type sle_name from singlelineedit within w_bidq_getname
end type
type st_project from statictext within w_bidq_getname
end type
end forward

global type w_bidq_getname from window
integer width = 1938
integer height = 264
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
sle_name sle_name
st_project st_project
end type
global w_bidq_getname w_bidq_getname

type variables
string is_Return = "cancel!"
end variables

on w_bidq_getname.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_name=create sle_name
this.st_project=create st_project
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.sle_name,&
this.st_project}
end on

on w_bidq_getname.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_name)
destroy(this.st_project)
end on

event close;CloseWithReturn(this, is_Return)
end event

type cb_cancel from commandbutton within w_bidq_getname
integer x = 1554
integer y = 96
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_bidq_getname
integer x = 1193
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;long ll_Exist
string ls_bidq_name

// Return if no enter document queue name or already exists
ls_bidq_name = Trim(sle_name.Text)
if ls_bidq_name = "" then
	Messagebox("Missing data", "Please enter the document queue name.")
	sle_name.SetFocus()
	Return
end if
SELECT Count(*) INTO :ll_Exist FROM ctx_bidq WHERE bidq_name = :ls_bidq_name;
If ll_Exist > 0 Then
	Messagebox("Document Queue Name", "This document queue name already exists. Please enter another one.")
	sle_name.SetFocus()
	Return
End If

// Close and return document queue name
is_Return = ls_bidq_name
Close(Parent)
end event

type sle_name from singlelineedit within w_bidq_getname
integer x = 37
integer y = 96
integer width = 1120
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_project from statictext within w_bidq_getname
integer x = 37
integer y = 24
integer width = 969
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please enter document queue name:"
boolean focusrectangle = false
end type

