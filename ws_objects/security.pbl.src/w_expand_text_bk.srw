$PBExportHeader$w_expand_text_bk.srw
forward
global type w_expand_text_bk from window
end type
type cb_2 from commandbutton within w_expand_text_bk
end type
type cb_1 from commandbutton within w_expand_text_bk
end type
type mle_1 from multilineedit within w_expand_text_bk
end type
end forward

global type w_expand_text_bk from window
integer x = 649
integer y = 340
integer width = 3250
integer height = 2260
boolean titlebar = true
string title = "Expanded Text"
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_expand_text_bk w_expand_text_bk

type variables
boolean ib_add_to_bottom = false
end variables

event open;string s

s = message.stringparm

mle_1.text = s
end event

on w_expand_text_bk.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_expand_text_bk.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type cb_2 from commandbutton within w_expand_text_bk
integer x = 1449
integer y = 1976
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"CANCEL")
end event

type cb_1 from commandbutton within w_expand_text_bk
integer x = 1193
integer y = 1976
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ok"
end type

event clicked;string s

//mle_1.accepttext()
s = mle_1.text

closewithreturn(parent,s)
end event

type mle_1 from multilineedit within w_expand_text_bk
integer x = 46
integer y = 40
integer width = 3150
integer height = 1892
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

