$PBExportHeader$w_npi_test.srw
forward
global type w_npi_test from window
end type
type sle_1 from singlelineedit within w_npi_test
end type
type cb_1 from commandbutton within w_npi_test
end type
end forward

global type w_npi_test from window
integer width = 855
integer height = 604
boolean titlebar = true
string title = "NPI num test"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_1 sle_1
cb_1 cb_1
end type
global w_npi_test w_npi_test

on w_npi_test.create
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_1}
end on

on w_npi_test.destroy
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_1 from singlelineedit within w_npi_test
integer x = 73
integer y = 72
integer width = 640
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

type cb_1 from commandbutton within w_npi_test
integer x = 219
integer y = 272
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "test"
end type

event clicked;//Start Code Change ---- 06.15.2007 #V7 maha added new

string s
integer i
string mess

s = sle_1.text

i = of_npi_validation(s,"test")

choose case i
	case 1
		mess = "Valid"
	case -1
		mess = "Invalid.  NPI number must be 10 Characters."
	case -2
		mess = "Invalid.  NPI number can contain Numerals only."
	case 1
		mess = "Invalid.  Not a valid NPI number"
end choose

messagebox("Result",mess)
end event

