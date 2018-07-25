$PBExportHeader$w_expand_text.srw
forward
global type w_expand_text from window
end type
type cb_ok from commandbutton within w_expand_text
end type
type cb_3 from commandbutton within w_expand_text
end type
type cb_2 from commandbutton within w_expand_text
end type
type cb_close from commandbutton within w_expand_text
end type
type mle_1 from multilineedit within w_expand_text
end type
end forward

global type w_expand_text from window
integer x = 110
integer y = 36
integer width = 3456
integer height = 2308
boolean titlebar = true
string title = "Text Value"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_ok cb_ok
cb_3 cb_3
cb_2 cb_2
cb_close cb_close
mle_1 mle_1
end type
global w_expand_text w_expand_text

event open;mle_1.Text = Message.StringParm



end event

on w_expand_text.create
this.cb_ok=create cb_ok
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_close=create cb_close
this.mle_1=create mle_1
this.Control[]={this.cb_ok,&
this.cb_3,&
this.cb_2,&
this.cb_close,&
this.mle_1}
end on

on w_expand_text.destroy
destroy(this.cb_ok)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.mle_1)
end on

type cb_ok from commandbutton within w_expand_text
integer x = 2482
integer y = 2088
integer width = 453
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;closewithreturn(parent,mle_1.text )
end event

type cb_3 from commandbutton within w_expand_text
boolean visible = false
integer x = 928
integer y = 2064
integer width = 453
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;long Job

Job = PrintOpen( )
Print(Job, "sql")

mle_1.Print(Job, 1,1)

PrintPage(Job)

PrintClose(Job )
end event

type cb_2 from commandbutton within w_expand_text
integer x = 1385
integer y = 2088
integer width = 530
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Place on Clipboard"
end type

event clicked;clipboard(mle_1.text)
end event

type cb_close from commandbutton within w_expand_text
integer x = 2949
integer y = 2088
integer width = 453
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type mle_1 from multilineedit within w_expand_text
integer y = 4
integer width = 3438
integer height = 2056
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
end type

