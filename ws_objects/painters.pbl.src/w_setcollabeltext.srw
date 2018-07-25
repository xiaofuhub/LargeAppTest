$PBExportHeader$w_setcollabeltext.srw
forward
global type w_setcollabeltext from window
end type
type cb_cancel from commandbutton within w_setcollabeltext
end type
type cb_ok from commandbutton within w_setcollabeltext
end type
type sle_collabel from singlelineedit within w_setcollabeltext
end type
type st_1 from statictext within w_setcollabeltext
end type
end forward

global type w_setcollabeltext from window
integer width = 1147
integer height = 472
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
sle_collabel sle_collabel
st_1 st_1
end type
global w_setcollabeltext w_setcollabeltext

on w_setcollabeltext.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_collabel=create sle_collabel
this.st_1=create st_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.sle_collabel,&
this.st_1}
end on

on w_setcollabeltext.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_collabel)
destroy(this.st_1)
end on

event open;String	ls_OriTitleText

ls_OriTitleText = Message.StringParm

This.Title = "Modify " + ls_OriTitleText + " column label"

sle_ColLabel.Text = ls_OriTitleText
sle_ColLabel.SelectText(1,-1)

end event

type cb_cancel from commandbutton within w_setcollabeltext
integer x = 672
integer y = 312
integer width = 288
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

event clicked;CloseWithReturn(Parent,-1)
end event

type cb_ok from commandbutton within w_setcollabeltext
integer x = 178
integer y = 312
integer width = 288
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

event clicked;String	ls_TitleText

ls_TitleText = sle_ColLabel.Text

if PosA(ls_TitleText,"~~") > 0 then
	MessageBox('Warning','The "~~" character is not allowed. Please remove it.',Exclamation!)
	sle_ColLabel.SetFocus()
	return
end if

CloseWithReturn(Parent,ls_TitleText)

end event

type sle_collabel from singlelineedit within w_setcollabeltext
integer x = 50
integer y = 152
integer width = 1042
integer height = 88
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

type st_1 from statictext within w_setcollabeltext
integer x = 50
integer y = 60
integer width = 1061
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "What would you like the column label to be?"
boolean focusrectangle = false
end type

