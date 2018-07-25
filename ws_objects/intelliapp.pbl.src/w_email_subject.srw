$PBExportHeader$w_email_subject.srw
forward
global type w_email_subject from window
end type
type cb_2 from commandbutton within w_email_subject
end type
type cb_1 from commandbutton within w_email_subject
end type
type st_2 from statictext within w_email_subject
end type
type mle_1 from multilineedit within w_email_subject
end type
type st_1 from statictext within w_email_subject
end type
type sle_1 from singlelineedit within w_email_subject
end type
end forward

global type w_email_subject from window
integer x = 425
integer y = 368
integer width = 2665
integer height = 1824
boolean titlebar = true
string title = "Email"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
st_2 st_2
mle_1 mle_1
st_1 st_1
sle_1 sle_1
end type
global w_email_subject w_email_subject

on w_email_subject.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.mle_1=create mle_1
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_2,&
this.mle_1,&
this.st_1,&
this.sle_1}
end on

on w_email_subject.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;sle_1.SetFocus()
end event

type cb_2 from commandbutton within w_email_subject
integer x = 2267
integer y = 12
integer width = 306
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_email_subject
integer x = 1938
integer y = 12
integer width = 306
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send(&S)"
end type

event clicked;CloseWithReturn( Parent, sle_1.Text + "*" + mle_1.Text )
end event

type st_2 from statictext within w_email_subject
integer x = 69
integer y = 296
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Body:"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_email_subject
integer x = 18
integer y = 360
integer width = 2629
integer height = 1372
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_email_subject
integer x = 69
integer y = 76
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Subject:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_email_subject
integer x = 18
integer y = 148
integer width = 2624
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

