$PBExportHeader$w_approver_notes.srw
forward
global type w_approver_notes from w_response
end type
type cb_1 from commandbutton within w_approver_notes
end type
type mle_note from multilineedit within w_approver_notes
end type
end forward

global type w_approver_notes from w_response
integer x = 946
integer y = 432
integer width = 1426
integer height = 1720
string title = "Approver Comments"
long backcolor = 33551856
cb_1 cb_1
mle_note mle_note
end type
global w_approver_notes w_approver_notes

on w_approver_notes.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.mle_note=create mle_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.mle_note
end on

on w_approver_notes.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.mle_note)
end on

event open;call super::open;mle_note.Text = Message.StringParm
end event

type cb_1 from commandbutton within w_approver_notes
integer x = 1102
integer y = 1524
integer width = 279
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
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type mle_note from multilineedit within w_approver_notes
integer x = 27
integer y = 32
integer width = 1339
integer height = 1464
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

