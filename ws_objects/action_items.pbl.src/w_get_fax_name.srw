$PBExportHeader$w_get_fax_name.srw
forward
global type w_get_fax_name from w_response
end type
type sle_1 from singlelineedit within w_get_fax_name
end type
type st_1 from statictext within w_get_fax_name
end type
type cb_1 from commandbutton within w_get_fax_name
end type
type cb_2 from commandbutton within w_get_fax_name
end type
end forward

global type w_get_fax_name from w_response
integer x = 599
integer y = 868
integer width = 2231
integer height = 424
string title = "Fax Template"
long backcolor = 33551856
sle_1 sle_1
st_1 st_1
cb_1 cb_1
cb_2 cb_2
end type
global w_get_fax_name w_get_fax_name

on w_get_fax_name.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
end on

on w_get_fax_name.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type sle_1 from singlelineedit within w_get_fax_name
integer x = 55
integer y = 132
integer width = 1504
integer height = 92
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
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_get_fax_name
integer x = 55
integer y = 64
integer width = 594
integer height = 64
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
string text = "Select Fax Template"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_get_fax_name
integer x = 1591
integer y = 136
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;IF sle_1.Text = "" OR IsNull( sle_1.Text ) THEN
	MessageBox("Invalid Name", "You must enter a name for the Fax Template." )
	Return 1
END IF

CloseWithReturn( Parent, sle_1.Text )
end event

type cb_2 from commandbutton within w_get_fax_name
integer x = 1870
integer y = 136
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

