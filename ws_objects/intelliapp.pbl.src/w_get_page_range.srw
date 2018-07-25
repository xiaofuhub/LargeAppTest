$PBExportHeader$w_get_page_range.srw
forward
global type w_get_page_range from w_response
end type
type st_from from statictext within w_get_page_range
end type
type st_to from statictext within w_get_page_range
end type
type em_from from editmask within w_get_page_range
end type
type em_to from editmask within w_get_page_range
end type
type cb_ok from commandbutton within w_get_page_range
end type
type cb_cancel from commandbutton within w_get_page_range
end type
end forward

global type w_get_page_range from w_response
integer x = 1083
integer y = 388
integer width = 951
integer height = 720
string title = "Page Range"
long backcolor = 33551856
st_from st_from
st_to st_to
em_from em_from
em_to em_to
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_get_page_range w_get_page_range

on w_get_page_range.create
int iCurrent
call super::create
this.st_from=create st_from
this.st_to=create st_to
this.em_from=create em_from
this.em_to=create em_to
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_from
this.Control[iCurrent+2]=this.st_to
this.Control[iCurrent+3]=this.em_from
this.Control[iCurrent+4]=this.em_to
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_get_page_range.destroy
call super::destroy
destroy(this.st_from)
destroy(this.st_to)
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

type st_from from statictext within w_get_page_range
integer x = 183
integer y = 140
integer width = 247
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
string text = "From"
boolean focusrectangle = false
end type

type st_to from statictext within w_get_page_range
integer x = 494
integer y = 140
integer width = 247
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
string text = "To"
boolean focusrectangle = false
end type

type em_from from editmask within w_get_page_range
integer x = 178
integer y = 216
integer width = 229
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
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 1
string minmax = "1~~50"
end type

type em_to from editmask within w_get_page_range
integer x = 494
integer y = 216
integer width = 229
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
double increment = 1
string minmax = "1~~50"
end type

type cb_ok from commandbutton within w_get_page_range
integer x = 174
integer y = 392
integer width = 265
integer height = 84
integer taborder = 30
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

event clicked;Integer li_from
Integer li_to

li_from = Integer( em_from.Text )
li_to = Integer( em_to.Text )

IF li_from < 1 THEN
	MessageBox( "From", "The From value must be at least 1." )
	Return 0
END IF

IF li_to < 1 THEN
	MessageBox( "To", "The To value must be at least 1." )
	Return 0
END IF

IF li_from > li_to THEN
	MessageBox("Invalid Range", "The From value must be less than the To value." )
	Return 0
END IF

CloseWithReturn( Parent, em_from.Text + "-" + em_to.Text )

end event

type cb_cancel from commandbutton within w_get_page_range
integer x = 457
integer y = 392
integer width = 265
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

