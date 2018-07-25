$PBExportHeader$w_text_message.srw
forward
global type w_text_message from window
end type
type cb_2 from commandbutton within w_text_message
end type
type cb_1 from commandbutton within w_text_message
end type
type st_2 from statictext within w_text_message
end type
type mle_1 from multilineedit within w_text_message
end type
type st_1 from statictext within w_text_message
end type
type sle_1 from singlelineedit within w_text_message
end type
end forward

global type w_text_message from window
integer x = 425
integer y = 368
integer width = 1362
integer height = 592
boolean titlebar = true
string title = "Texting"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_2 st_2
mle_1 mle_1
st_1 st_1
sle_1 sle_1
end type
global w_text_message w_text_message

on w_text_message.create
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

on w_text_message.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;sle_1.SetFocus()
end event

type cb_2 from commandbutton within w_text_message
integer x = 1024
integer width = 306
integer height = 96
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

type cb_1 from commandbutton within w_text_message
integer x = 695
integer width = 306
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send(&S)"
end type

event clicked;integer r

r = len(mle_1.text)

if r > 160 then 
	messagebox("Max Length","Maximum text length is 160 charcters.  This message is " + string(r) + " characters.")
	return
end if


CloseWithReturn( Parent, mle_1.Text )
end event

type st_2 from statictext within w_text_message
integer x = 37
integer y = 40
integer width = 201
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Text:"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_text_message
integer x = 18
integer y = 120
integer width = 1307
integer height = 372
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 160
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_text_message
boolean visible = false
integer x = 558
integer y = 528
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

type sle_1 from singlelineedit within w_text_message
boolean visible = false
integer x = 768
integer y = 524
integer width = 151
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

