$PBExportHeader$w_insert_page.srw
forward
global type w_insert_page from w_response
end type
type cb_ok from commandbutton within w_insert_page
end type
type st_1 from statictext within w_insert_page
end type
type sle_page from singlelineedit within w_insert_page
end type
type cb_cancel from commandbutton within w_insert_page
end type
type sle_copy_page from singlelineedit within w_insert_page
end type
type st_2 from statictext within w_insert_page
end type
type st_3 from statictext within w_insert_page
end type
end forward

global type w_insert_page from w_response
integer x = 1074
integer y = 640
integer width = 1088
integer height = 624
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_ok cb_ok
st_1 st_1
sle_page sle_page
cb_cancel cb_cancel
sle_copy_page sle_copy_page
st_2 st_2
st_3 st_3
end type
global w_insert_page w_insert_page

on w_insert_page.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.st_1=create st_1
this.sle_page=create sle_page
this.cb_cancel=create cb_cancel
this.sle_copy_page=create sle_copy_page
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.sle_page
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.sle_copy_page
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
end on

on w_insert_page.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.sle_page)
destroy(this.cb_cancel)
destroy(this.sle_copy_page)
destroy(this.st_2)
destroy(this.st_3)
end on

type cb_ok from commandbutton within w_insert_page
integer x = 229
integer y = 464
integer width = 247
integer height = 84
integer taborder = 10
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

event clicked;CloseWithReturn( Parent, sle_page.Text + "-" + sle_copy_page.Text )

end event

type st_1 from statictext within w_insert_page
integer x = 78
integer y = 288
integer width = 475
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
string text = "Insert After Page:"
boolean focusrectangle = false
end type

type sle_page from singlelineedit within w_insert_page
integer x = 480
integer y = 280
integer width = 165
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "0"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_insert_page
integer x = 507
integer y = 464
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type sle_copy_page from singlelineedit within w_insert_page
integer x = 485
integer y = 136
integer width = 165
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "0"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_insert_page
integer x = 210
integer y = 148
integer width = 261
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
string text = "Copy Page:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_insert_page
integer x = 69
integer y = 24
integer width = 942
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Set Copy Page to 0 to insert Blank Page"
boolean focusrectangle = false
end type

