$PBExportHeader$w_de.srw
forward
global type w_de from window
end type
type st_2 from statictext within w_de
end type
type st_1 from statictext within w_de
end type
type sle_f from singlelineedit within w_de
end type
type sle_p from singlelineedit within w_de
end type
type cb_1 from commandbutton within w_de
end type
end forward

global type w_de from window
integer width = 1824
integer height = 792
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
sle_f sle_f
sle_p sle_p
cb_1 cb_1
end type
global w_de w_de

on w_de.create
this.st_2=create st_2
this.st_1=create st_1
this.sle_f=create sle_f
this.sle_p=create sle_p
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.st_1,&
this.sle_f,&
this.sle_p,&
this.cb_1}
end on

on w_de.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_f)
destroy(this.sle_p)
destroy(this.cb_1)
end on

type st_2 from statictext within w_de
integer x = 1033
integer y = 104
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facility"
boolean focusrectangle = false
end type

type st_1 from statictext within w_de
integer x = 219
integer y = 80
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prac"
boolean focusrectangle = false
end type

type sle_f from singlelineedit within w_de
integer x = 1024
integer y = 164
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "2"
borderstyle borderstyle = stylelowered!
end type

type sle_p from singlelineedit within w_de
integer x = 219
integer y = 160
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_de
integer x = 699
integer y = 368
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "run"
end type

event clicked;long prac
long facil

pfc_cst_nv_data_entry_functions nv_data

nv_data = pfc_cst_nv_data_entry_functions 

prac = long(sle_p.text)
facil = long(sle_f.text)

debugbreak()
nv_data.of_check_required_data( 2, prac, facil)






destroy nv_data
end event

