$PBExportHeader$w_date_compute.srw
forward
global type w_date_compute from window
end type
type st_comp from statictext within w_date_compute
end type
type st_2 from statictext within w_date_compute
end type
type st_1 from statictext within w_date_compute
end type
type em_date from editmask within w_date_compute
end type
type sle_days from singlelineedit within w_date_compute
end type
type cb_1 from commandbutton within w_date_compute
end type
end forward

global type w_date_compute from window
integer width = 1285
integer height = 768
boolean titlebar = true
string title = "Date Calculation"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_comp st_comp
st_2 st_2
st_1 st_1
em_date em_date
sle_days sle_days
cb_1 cb_1
end type
global w_date_compute w_date_compute

on w_date_compute.create
this.st_comp=create st_comp
this.st_2=create st_2
this.st_1=create st_1
this.em_date=create em_date
this.sle_days=create sle_days
this.cb_1=create cb_1
this.Control[]={this.st_comp,&
this.st_2,&
this.st_1,&
this.em_date,&
this.sle_days,&
this.cb_1}
end on

on w_date_compute.destroy
destroy(this.st_comp)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_date)
destroy(this.sle_days)
destroy(this.cb_1)
end on

type st_comp from statictext within w_date_compute
integer x = 453
integer y = 304
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "  /  /"
boolean focusrectangle = false
end type

type st_2 from statictext within w_date_compute
integer x = 709
integer y = 40
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Days"
boolean focusrectangle = false
end type

type st_1 from statictext within w_date_compute
integer x = 242
integer y = 40
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Date"
boolean focusrectangle = false
end type

type em_date from editmask within w_date_compute
integer x = 215
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
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

type sle_days from singlelineedit within w_date_compute
integer x = 699
integer y = 128
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_date_compute
integer x = 453
integer y = 400
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Compute"
end type

event clicked;date ldt_date
integer li_days

ldt_date = date(em_date.text)
li_days = integer(sle_days.text)

st_comp.text = string(RelativeDate ( ldt_date, li_days))
end event

