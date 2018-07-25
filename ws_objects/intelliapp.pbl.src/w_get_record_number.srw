$PBExportHeader$w_get_record_number.srw
forward
global type w_get_record_number from w_response
end type
type st_1 from statictext within w_get_record_number
end type
type em_rec_no from editmask within w_get_record_number
end type
type cb_ok from commandbutton within w_get_record_number
end type
end forward

global type w_get_record_number from w_response
integer x = 1134
integer y = 700
integer width = 1289
integer height = 280
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
em_rec_no em_rec_no
cb_ok cb_ok
end type
global w_get_record_number w_get_record_number

event open;call super::open;em_rec_no.Text = Message.StringParm
end event

on w_get_record_number.create
int iCurrent
call super::create
this.st_1=create st_1
this.em_rec_no=create em_rec_no
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.em_rec_no
this.Control[iCurrent+3]=this.cb_ok
end on

on w_get_record_number.destroy
call super::destroy
destroy(this.st_1)
destroy(this.em_rec_no)
destroy(this.cb_ok)
end on

type st_1 from statictext within w_get_record_number
integer x = 41
integer y = 96
integer width = 640
integer height = 76
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
string text = "Enter new Record Number:"
boolean focusrectangle = false
end type

type em_rec_no from editmask within w_get_record_number
integer x = 686
integer y = 84
integer width = 247
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string minmax = "1~~99"
end type

type cb_ok from commandbutton within w_get_record_number
integer x = 951
integer y = 84
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
string text = "Ok"
boolean default = true
end type

event clicked;CloseWithReturn ( Parent, em_rec_no.Text )
end event

