$PBExportHeader$w_color_find_res.srw
forward
global type w_color_find_res from window
end type
type cb_3 from commandbutton within w_color_find_res
end type
type st_4 from statictext within w_color_find_res
end type
type st_a from statictext within w_color_find_res
end type
type cb_2 from commandbutton within w_color_find_res
end type
type sle_value from singlelineedit within w_color_find_res
end type
type cb_1 from commandbutton within w_color_find_res
end type
type st_3 from statictext within w_color_find_res
end type
type st_2 from statictext within w_color_find_res
end type
type st_1 from statictext within w_color_find_res
end type
type sle_blue from singlelineedit within w_color_find_res
end type
type sle_green from singlelineedit within w_color_find_res
end type
type sle_red from singlelineedit within w_color_find_res
end type
type r_1 from rectangle within w_color_find_res
end type
end forward

global type w_color_find_res from window
integer x = 1326
integer y = 628
integer width = 1243
integer height = 820
boolean titlebar = true
string title = "Find Color value"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
cb_3 cb_3
st_4 st_4
st_a st_a
cb_2 cb_2
sle_value sle_value
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_blue sle_blue
sle_green sle_green
sle_red sle_red
r_1 r_1
end type
global w_color_find_res w_color_find_res

on w_color_find_res.create
this.cb_3=create cb_3
this.st_4=create st_4
this.st_a=create st_a
this.cb_2=create cb_2
this.sle_value=create sle_value
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_blue=create sle_blue
this.sle_green=create sle_green
this.sle_red=create sle_red
this.r_1=create r_1
this.Control[]={this.cb_3,&
this.st_4,&
this.st_a,&
this.cb_2,&
this.sle_value,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_blue,&
this.sle_green,&
this.sle_red,&
this.r_1}
end on

on w_color_find_res.destroy
destroy(this.cb_3)
destroy(this.st_4)
destroy(this.st_a)
destroy(this.cb_2)
destroy(this.sle_value)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_blue)
destroy(this.sle_green)
destroy(this.sle_red)
destroy(this.r_1)
end on

type cb_3 from commandbutton within w_color_find_res
integer x = 965
integer y = 536
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;string s

s = sle_value.text

if len(s) > 0 then
	closewithreturn(parent, long(s))
else
	closewithreturn(parent, "Cancel")
end if


end event

type st_4 from statictext within w_color_find_res
integer x = 18
integer y = 616
integer width = 727
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Transparent = 553648127"
boolean focusrectangle = false
end type

type st_a from statictext within w_color_find_res
integer x = 46
integer y = 532
integer width = 741
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Buttonface = 67108864"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_color_find_res
integer x = 965
integer y = 628
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type sle_value from singlelineedit within w_color_find_res
integer x = 695
integer y = 420
integer width = 507
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_color_find_res
integer x = 407
integer y = 420
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calc"
end type

event clicked;long r
long g
long b
long val
integer mult = 256

r = long(sle_red.text)
g = long(sle_green.text)
b = long(sle_blue.text)

if r > 255 then 
	r = 255
	sle_red.text = "255"
end if

if g > 255 then 
	g = 255
	sle_green.text = "255"
end if

if b > 255 then 
	b = 255
	sle_blue.text = "255"
end if

val = (b*mult*mult) + (g*mult) + r

sle_value.text = string(val)

r_1.fillcolor = val







end event

type st_3 from statictext within w_color_find_res
integer x = 101
integer y = 288
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Blue"
boolean focusrectangle = false
end type

type st_2 from statictext within w_color_find_res
integer x = 101
integer y = 180
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Green"
boolean focusrectangle = false
end type

type st_1 from statictext within w_color_find_res
integer x = 101
integer y = 68
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Red"
boolean focusrectangle = false
end type

type sle_blue from singlelineedit within w_color_find_res
integer x = 398
integer y = 284
integer width = 247
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_green from singlelineedit within w_color_find_res
integer x = 398
integer y = 172
integer width = 247
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_red from singlelineedit within w_color_find_res
integer x = 398
integer y = 60
integer width = 247
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type r_1 from rectangle within w_color_find_res
integer linethickness = 4
long fillcolor = 16777215
integer x = 695
integer y = 48
integer width = 507
integer height = 332
end type

