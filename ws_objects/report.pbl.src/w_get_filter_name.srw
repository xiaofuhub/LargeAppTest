$PBExportHeader$w_get_filter_name.srw
forward
global type w_get_filter_name from window
end type
type cb_1 from commandbutton within w_get_filter_name
end type
type cb_3 from commandbutton within w_get_filter_name
end type
type sle_1 from singlelineedit within w_get_filter_name
end type
type st_1 from statictext within w_get_filter_name
end type
end forward

global type w_get_filter_name from window
integer x = 1056
integer y = 484
integer width = 1714
integer height = 388
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
cb_3 cb_3
sle_1 sle_1
st_1 st_1
end type
global w_get_filter_name w_get_filter_name

event open;string mes

mes = message.stringparm

if mes = "A" then
	st_1.text = "New Filter Name:"
elseif mes = "S" then
	st_1.text = "Save Filter As:"
elseif mes = "B" then
	st_1.text = "New Batch Name:"
	this.title = "Batch Name"
//elseif mes = "S" then
//	st_1.text = "Save Batch As:"
end if
end event

on w_get_filter_name.create
this.cb_1=create cb_1
this.cb_3=create cb_3
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.cb_3,&
this.sle_1,&
this.st_1}
end on

on w_get_filter_name.destroy
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_get_filter_name
integer x = 1207
integer y = 108
integer width = 315
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;String ls_retval

if LenA(Trim(sle_1.Text)) > 0 then //Add by Evan 01/12/2008
	ls_retval = sle_1.Text 
	CloseWithReturn(Parent, ls_retval )
else
	MessageBox("Prompt", "Plese enter value.")
	sle_1.SetFocus()
end if
end event

type cb_3 from commandbutton within w_get_filter_name
integer x = 1207
integer y = 204
integer width = 315
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;CloseWithReturn(Parent,"Cancel" )
end event

type sle_1 from singlelineedit within w_get_filter_name
integer x = 73
integer y = 104
integer width = 1097
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
integer limit = 35
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_get_filter_name
integer x = 82
integer y = 24
integer width = 507
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
string text = "Filter name"
boolean focusrectangle = false
end type

