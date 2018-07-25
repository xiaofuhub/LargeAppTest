$PBExportHeader$w_days_between_dates.srw
forward
global type w_days_between_dates from window
end type
type st_2 from statictext within w_days_between_dates
end type
type st_days from statictext within w_days_between_dates
end type
type cb_today from commandbutton within w_days_between_dates
end type
type cb_close from commandbutton within w_days_between_dates
end type
type cb_1 from commandbutton within w_days_between_dates
end type
type st_1 from statictext within w_days_between_dates
end type
type em_2 from editmask within w_days_between_dates
end type
type em_1 from editmask within w_days_between_dates
end type
end forward

global type w_days_between_dates from window
integer width = 1143
integer height = 720
boolean titlebar = true
string title = "Date Compare"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_days st_days
cb_today cb_today
cb_close cb_close
cb_1 cb_1
st_1 st_1
em_2 em_2
em_1 em_1
end type
global w_days_between_dates w_days_between_dates

on w_days_between_dates.create
this.st_2=create st_2
this.st_days=create st_days
this.cb_today=create cb_today
this.cb_close=create cb_close
this.cb_1=create cb_1
this.st_1=create st_1
this.em_2=create em_2
this.em_1=create em_1
this.Control[]={this.st_2,&
this.st_days,&
this.cb_today,&
this.cb_close,&
this.cb_1,&
this.st_1,&
this.em_2,&
this.em_1}
end on

on w_days_between_dates.destroy
destroy(this.st_2)
destroy(this.st_days)
destroy(this.cb_today)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.em_2)
destroy(this.em_1)
end on

type st_2 from statictext within w_days_between_dates
integer x = 334
integer y = 392
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "  days between"
boolean focusrectangle = false
end type

type st_days from statictext within w_days_between_dates
integer x = 87
integer y = 392
integer width = 233
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_today from commandbutton within w_days_between_dates
integer x = 521
integer y = 152
integer width = 311
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Today"
end type

event clicked;date d
string s

d = today()
s = string(d)
em_1.text = s
end event

type cb_close from commandbutton within w_days_between_dates
integer x = 517
integer y = 468
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_days_between_dates
integer x = 96
integer y = 468
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Compare"
end type

event clicked;date d1
date d2
long ll_days

d1 = date(em_1.text)
d2 = date(em_2.text)

if string(d1) = "1/1/1900" then
	Messagebox("","Please enter the first date")
	return
end if
if string(d2) = "1/1/1900" then
	Messagebox("","Please enter the second date")
	return
end if

ll_days = daysafter(d1,d2)

ll_days = abs(ll_days)

st_days.text = string(ll_days)
end event

type st_1 from statictext within w_days_between_dates
integer x = 82
integer y = 12
integer width = 1001
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Enter two dates and click Compare to find the days between the two."
boolean focusrectangle = false
end type

type em_2 from editmask within w_days_between_dates
integer x = 96
integer y = 268
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
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

type em_1 from editmask within w_days_between_dates
integer x = 96
integer y = 144
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
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

