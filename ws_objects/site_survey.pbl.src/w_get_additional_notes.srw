$PBExportHeader$w_get_additional_notes.srw
forward
global type w_get_additional_notes from w_response
end type
type st_1 from statictext within w_get_additional_notes
end type
type cb_ok from commandbutton within w_get_additional_notes
end type
type cb_cancel from commandbutton within w_get_additional_notes
end type
type mle_text from multilineedit within w_get_additional_notes
end type
end forward

global type w_get_additional_notes from w_response
integer x = 293
integer y = 652
integer width = 3104
integer height = 384
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
mle_text mle_text
end type
global w_get_additional_notes w_get_additional_notes

on w_get_additional_notes.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.mle_text=create mle_text
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.mle_text
end on

on w_get_additional_notes.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.mle_text)
end on

event open;call super::open;mle_text.text = Message.StringParm
mle_text.SetFocus()
end event

type st_1 from statictext within w_get_additional_notes
integer x = 50
integer y = 60
integer width = 521
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Additional Notes:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_get_additional_notes
integer x = 2734
integer y = 128
integer width = 283
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;CloseWithReturn( Parent, mle_text.Text )
end event

type cb_cancel from commandbutton within w_get_additional_notes
integer x = 2734
integer y = 224
integer width = 283
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type mle_text from multilineedit within w_get_additional_notes
integer x = 41
integer y = 132
integer width = 2661
integer height = 176
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

