$PBExportHeader$w_goto_page.srw
forward
global type w_goto_page from w_popup
end type
type st_1 from statictext within w_goto_page
end type
type cb_apply from commandbutton within w_goto_page
end type
type em_page from editmask within w_goto_page
end type
type cb_1 from commandbutton within w_goto_page
end type
end forward

global type w_goto_page from w_popup
integer x = 850
integer y = 804
integer width = 882
integer height = 664
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
cb_apply cb_apply
em_page em_page
cb_1 cb_1
end type
global w_goto_page w_goto_page

type variables
olecustomcontrol io_image_edit

String is_object_name
end variables

on w_goto_page.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_apply=create cb_apply
this.em_page=create em_page
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_apply
this.Control[iCurrent+3]=this.em_page
this.Control[iCurrent+4]=this.cb_1
end on

on w_goto_page.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_apply)
destroy(this.em_page)
destroy(this.cb_1)
end on

event open;call super::open;em_page.SetFocus( )


end event

type st_1 from statictext within w_goto_page
integer x = 311
integer y = 148
integer width = 320
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
string text = "Go To Page"
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_goto_page
integer x = 187
integer y = 384
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
string text = "&OK"
boolean default = true
end type

event clicked;if em_page.Text = "" then
	MessageBox("Error", "Please enter a page number or Cancel" )
	return
end if

CloseWithReturn ( w_goto_page, em_page.Text )
end event

type em_page from editmask within w_goto_page
integer x = 315
integer y = 220
integer width = 247
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string minmax = "1~~99"
end type

type cb_1 from commandbutton within w_goto_page
integer x = 448
integer y = 384
integer width = 247
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

event clicked;CloseWithReturn ( w_goto_page, "Cancel" ) //maha 042004
end event

