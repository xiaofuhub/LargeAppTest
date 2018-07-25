$PBExportHeader$w_test_character.srw
forward
global type w_test_character from window
end type
type st_2 from statictext within w_test_character
end type
type cb_1 from commandbutton within w_test_character
end type
type st_1 from statictext within w_test_character
end type
type mle_1 from multilineedit within w_test_character
end type
end forward

global type w_test_character from window
integer width = 1449
integer height = 1012
boolean titlebar = true
string title = "Char Check"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
cb_1 cb_1
st_1 st_1
mle_1 mle_1
end type
global w_test_character w_test_character

type variables
long il_char
end variables

on w_test_character.create
this.st_2=create st_2
this.cb_1=create cb_1
this.st_1=create st_1
this.mle_1=create mle_1
this.Control[]={this.st_2,&
this.cb_1,&
this.st_1,&
this.mle_1}
end on

on w_test_character.destroy
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.mle_1)
end on

type st_2 from statictext within w_test_character
integer x = 352
integer y = 64
integer width = 192
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_test_character
integer x = 713
integer y = 64
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Read next"
end type

event clicked;long cnt
long i
string s

cnt = LenA(mle_1.text)

il_char++

if il_char > cnt then il_char = 1




s = MidA(mle_1.text, il_char,1)
i = AscA (s)
st_1.text = s
st_2.text = string(i)
end event

type st_1 from statictext within w_test_character
integer x = 133
integer y = 64
integer width = 192
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_test_character
integer x = 123
integer y = 228
integer width = 1230
integer height = 596
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

