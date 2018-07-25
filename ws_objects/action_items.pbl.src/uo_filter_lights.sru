$PBExportHeader$uo_filter_lights.sru
forward
global type uo_filter_lights from userobject
end type
type st_4 from statictext within uo_filter_lights
end type
type r_1 from rectangle within uo_filter_lights
end type
type st_3 from statictext within uo_filter_lights
end type
type st_1 from statictext within uo_filter_lights
end type
type st_2 from statictext within uo_filter_lights
end type
type rr_ir from roundrectangle within uo_filter_lights
end type
type rr_s from roundrectangle within uo_filter_lights
end type
type rr_p from roundrectangle within uo_filter_lights
end type
end forward

global type uo_filter_lights from userobject
integer width = 992
integer height = 276
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_4 st_4
r_1 r_1
st_3 st_3
st_1 st_1
st_2 st_2
rr_ir rr_ir
rr_s rr_s
rr_p rr_p
end type
global uo_filter_lights uo_filter_lights

on uo_filter_lights.create
this.st_4=create st_4
this.r_1=create r_1
this.st_3=create st_3
this.st_1=create st_1
this.st_2=create st_2
this.rr_ir=create rr_ir
this.rr_s=create rr_s
this.rr_p=create rr_p
this.Control[]={this.st_4,&
this.r_1,&
this.st_3,&
this.st_1,&
this.st_2,&
this.rr_ir,&
this.rr_s,&
this.rr_p}
end on

on uo_filter_lights.destroy
destroy(this.st_4)
destroy(this.r_1)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.rr_ir)
destroy(this.rr_s)
destroy(this.rr_p)
end on

type st_4 from statictext within uo_filter_lights
integer x = 64
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Addt~'l Filter Status"
boolean focusrectangle = false
end type

type r_1 from rectangle within uo_filter_lights
integer linethickness = 4
long fillcolor = 33551856
integer x = 14
integer y = 20
integer width = 955
integer height = 200
end type

type st_3 from statictext within uo_filter_lights
integer x = 645
integer y = 52
integer width = 297
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Practitioner"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_filter_lights
integer x = 142
integer y = 52
integer width = 91
integer height = 48
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
string text = "I/R"
boolean focusrectangle = false
end type

type st_2 from statictext within uo_filter_lights
integer x = 352
integer y = 52
integer width = 174
integer height = 52
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
string text = "Screen"
boolean focusrectangle = false
end type

type rr_ir from roundrectangle within uo_filter_lights
integer linethickness = 4
long fillcolor = 255
integer x = 27
integer y = 52
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_s from roundrectangle within uo_filter_lights
integer linethickness = 4
long fillcolor = 255
integer x = 242
integer y = 52
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_p from roundrectangle within uo_filter_lights
integer linethickness = 4
long fillcolor = 255
integer x = 530
integer y = 52
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

