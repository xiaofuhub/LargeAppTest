$PBExportHeader$w_future_days.srw
forward
global type w_future_days from window
end type
type em_1 from editmask within w_future_days
end type
type st_1 from statictext within w_future_days
end type
type cb_1 from commandbutton within w_future_days
end type
end forward

global type w_future_days from window
integer width = 1088
integer height = 624
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
em_1 em_1
st_1 st_1
cb_1 cb_1
end type
global w_future_days w_future_days

on w_future_days.create
this.em_1=create em_1
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.em_1,&
this.st_1,&
this.cb_1}
end on

on w_future_days.destroy
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_1)
end on

type em_1 from editmask within w_future_days
integer x = 347
integer y = 260
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_1 from statictext within w_future_days
integer x = 50
integer y = 48
integer width = 960
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "How many days from the print date should this be set?"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_future_days
integer x = 347
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
string text = "OK"
end type

event clicked;string s
integer i

s = em_1.text

if len(s) = 0 then
	s = "0"
end if

closewithreturn(parent,s)

end event

