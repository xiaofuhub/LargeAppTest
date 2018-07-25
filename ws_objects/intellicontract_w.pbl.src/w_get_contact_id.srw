$PBExportHeader$w_get_contact_id.srw
forward
global type w_get_contact_id from window
end type
type cb_2 from commandbutton within w_get_contact_id
end type
type sle_1 from singlelineedit within w_get_contact_id
end type
type cb_1 from commandbutton within w_get_contact_id
end type
end forward

global type w_get_contact_id from window
integer width = 626
integer height = 716
boolean titlebar = true
string title = "Untitled"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
sle_1 sle_1
cb_1 cb_1
end type
global w_get_contact_id w_get_contact_id

on w_get_contact_id.create
this.cb_2=create cb_2
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.sle_1,&
this.cb_1}
end on

on w_get_contact_id.destroy
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_get_contact_id
integer x = 325
integer y = 392
integer width = 197
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, -1)
end event

type sle_1 from singlelineedit within w_get_contact_id
integer x = 128
integer y = 128
integer width = 343
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

type cb_1 from commandbutton within w_get_contact_id
integer x = 123
integer y = 392
integer width = 183
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;long i

i = long(sle_1.text)

closewithreturn(parent,i )
end event

