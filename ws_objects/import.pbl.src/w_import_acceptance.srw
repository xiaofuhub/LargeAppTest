$PBExportHeader$w_import_acceptance.srw
forward
global type w_import_acceptance from w_popup
end type
type st_1 from statictext within w_import_acceptance
end type
type rb_3 from radiobutton within w_import_acceptance
end type
type rb_2 from radiobutton within w_import_acceptance
end type
type rb_1 from radiobutton within w_import_acceptance
end type
type cb_2 from commandbutton within w_import_acceptance
end type
type cb_1 from commandbutton within w_import_acceptance
end type
type dw_3 from u_dw within w_import_acceptance
end type
type dw_2 from u_dw within w_import_acceptance
end type
type dw_1 from u_dw within w_import_acceptance
end type
type gb_1 from groupbox within w_import_acceptance
end type
end forward

global type w_import_acceptance from w_popup
integer width = 4635
integer height = 2904
long backcolor = 33551856
st_1 st_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type
global w_import_acceptance w_import_acceptance

on w_import_acceptance.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_3
this.Control[iCurrent+3]=this.rb_2
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.gb_1
end on

on w_import_acceptance.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type st_1 from statictext within w_import_acceptance
integer x = 178
integer y = 20
integer width = 1856
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "This is a mockup screen only"
boolean focusrectangle = false
end type

type rb_3 from radiobutton within w_import_acceptance
integer x = 1737
integer y = 460
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Not Accepted"
end type

type rb_2 from radiobutton within w_import_acceptance
integer x = 1102
integer y = 456
integer width = 558
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Accepted"
end type

type rb_1 from radiobutton within w_import_acceptance
integer x = 795
integer y = 456
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

type cb_2 from commandbutton within w_import_acceptance
integer x = 55
integer y = 440
integer width = 603
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept Selected Records"
end type

type cb_1 from commandbutton within w_import_acceptance
integer x = 4206
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type dw_3 from u_dw within w_import_acceptance
integer x = 1125
integer y = 580
integer width = 3387
integer height = 2168
integer taborder = 30
boolean titlebar = true
string title = "Data"
string dataobject = "d_impmockup1"
end type

type dw_2 from u_dw within w_import_acceptance
integer x = 37
integer y = 584
integer width = 1051
integer height = 2164
integer taborder = 20
boolean titlebar = true
string title = "Practitioner"
string dataobject = "d_impmockup2"
end type

type dw_1 from u_dw within w_import_acceptance
integer x = 23
integer y = 156
integer width = 4530
integer height = 208
integer taborder = 10
string dataobject = "d_impmockup3"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_import_acceptance
integer x = 709
integer y = 400
integer width = 1518
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter"
borderstyle borderstyle = stylebox!
end type

