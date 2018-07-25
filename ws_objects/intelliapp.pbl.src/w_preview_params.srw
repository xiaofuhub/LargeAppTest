$PBExportHeader$w_preview_params.srw
forward
global type w_preview_params from window
end type
type em_from from editmask within w_preview_params
end type
type em_to from editmask within w_preview_params
end type
type cb_2 from commandbutton within w_preview_params
end type
type rb_prac from radiobutton within w_preview_params
end type
type rb_default from radiobutton within w_preview_params
end type
type st_2 from statictext within w_preview_params
end type
type st_1 from statictext within w_preview_params
end type
type cb_1 from commandbutton within w_preview_params
end type
type cbx_print from checkbox within w_preview_params
end type
type cbx_page from checkbox within w_preview_params
end type
type gb_3 from groupbox within w_preview_params
end type
type gb_2 from groupbox within w_preview_params
end type
type gb_1 from groupbox within w_preview_params
end type
end forward

global type w_preview_params from window
integer x = 1056
integer y = 484
integer width = 1618
integer height = 580
windowtype windowtype = response!
long backcolor = 33551856
em_from em_from
em_to em_to
cb_2 cb_2
rb_prac rb_prac
rb_default rb_default
st_2 st_2
st_1 st_1
cb_1 cb_1
cbx_print cbx_print
cbx_page cbx_page
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_preview_params w_preview_params

on w_preview_params.create
this.em_from=create em_from
this.em_to=create em_to
this.cb_2=create cb_2
this.rb_prac=create rb_prac
this.rb_default=create rb_default
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.cbx_print=create cbx_print
this.cbx_page=create cbx_page
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.em_from,&
this.em_to,&
this.cb_2,&
this.rb_prac,&
this.rb_default,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.cbx_print,&
this.cbx_page,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_preview_params.destroy
destroy(this.em_from)
destroy(this.em_to)
destroy(this.cb_2)
destroy(this.rb_prac)
destroy(this.rb_default)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cbx_print)
destroy(this.cbx_page)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type em_from from editmask within w_preview_params
integer x = 114
integer y = 252
integer width = 247
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
end type

event modified;cbx_page.checked = false
end event

type em_to from editmask within w_preview_params
integer x = 425
integer y = 252
integer width = 247
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
end type

event modified;cbx_page.checked = false
end event

type cb_2 from commandbutton within w_preview_params
integer x = 795
integer y = 452
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type rb_prac from radiobutton within w_preview_params
integer x = 891
integer y = 236
integer width = 576
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Provider"
end type

type rb_default from radiobutton within w_preview_params
integer x = 887
integer y = 112
integer width = 608
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Default Provider"
boolean checked = true
end type

type st_2 from statictext within w_preview_params
integer x = 430
integer y = 184
integer width = 247
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "To:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_preview_params
integer x = 123
integer y = 184
integer width = 215
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "From:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_preview_params
integer x = 526
integer y = 452
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;string ret

string ls_page_from
string ls_page_to
string ls_prac
string ls_print


if not cbx_page.checked and em_from.text = "" and em_to.text = "" then
	messagebox("Page Range?","All Pages is unchecked, please enter a page range.")
	return
end if

if not em_from.text = "" and not em_to.text = "" then
	if integer(em_from.text) > integer(em_to.text) then
		messagebox("Page Range?","Start Page cannot be greater then the End page, please correct.")
	end if
end if


if cbx_page.checked then //get page values
	ls_page_from = "D"
	ls_page_to = "D"
else
	if em_from.text = "" then
		ls_page_from = "S"
	else
		ls_page_from = em_from.text
	end if
	if em_to.text = "" then
		ls_page_to = "E"
	else
		ls_page_to = em_to.text
	end if
end if

if rb_default.checked then
	ls_prac = "D"
else
	ls_prac = "P"
end if

if cbx_print.checked then //not used
	ls_print = "Y"
else
	ls_print = "N"
end if

ret = ls_page_from + "@" + ls_page_to + "@" + ls_prac + "@" + ls_print

closewithreturn(parent,ret)
end event

type cbx_print from checkbox within w_preview_params
boolean visible = false
integer x = 1774
integer y = 188
integer width = 681
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Print Selected Range"
end type

type cbx_page from checkbox within w_preview_params
integer x = 215
integer y = 92
integer width = 361
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All Pages"
boolean checked = true
end type

type gb_3 from groupbox within w_preview_params
boolean visible = false
integer x = 1723
integer y = 56
integer width = 768
integer height = 496
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Print"
end type

type gb_2 from groupbox within w_preview_params
integer x = 800
integer width = 768
integer height = 424
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Provider"
end type

type gb_1 from groupbox within w_preview_params
integer x = 14
integer width = 754
integer height = 424
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Page Range"
end type

