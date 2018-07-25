$PBExportHeader$w_cp_desc.srw
forward
global type w_cp_desc from window
end type
type cb_cancel from commandbutton within w_cp_desc
end type
type cb_ok from commandbutton within w_cp_desc
end type
type mle_text from multilineedit within w_cp_desc
end type
end forward

global type w_cp_desc from window
integer width = 1394
integer height = 1784
boolean titlebar = true
string title = "Code Lookup Description"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
mle_text mle_text
end type
global w_cp_desc w_cp_desc

on w_cp_desc.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.mle_text=create mle_text
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.mle_text}
end on

on w_cp_desc.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.mle_text)
end on

event open;String	ls_Text

ls_Text = Message.StringParm

mle_Text.Text = ls_Text
mle_Text.SelectText(LenA(mle_Text.Text)+1,0)
end event

type cb_cancel from commandbutton within w_cp_desc
integer x = 704
integer y = 1572
integer width = 274
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,-1)
end event

type cb_ok from commandbutton within w_cp_desc
integer x = 407
integer y = 1572
integer width = 274
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;if LenA(mle_text.text) > 2000 then
	MessageBox('Warning','The number of characters input must be less than 2000',Exclamation!)
	return
end if

CloseWithReturn(Parent,mle_text.text)

end event

type mle_text from multilineedit within w_cp_desc
integer width = 1376
integer height = 1564
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

