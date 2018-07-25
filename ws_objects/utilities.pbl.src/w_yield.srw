$PBExportHeader$w_yield.srw
forward
global type w_yield from window
end type
type st_total from statictext within w_yield
end type
type st_of from statictext within w_yield
end type
type st_count from statictext within w_yield
end type
type cb_1 from commandbutton within w_yield
end type
end forward

global type w_yield from window
integer width = 1001
integer height = 604
boolean titlebar = true
string title = "Cancel"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_total st_total
st_of st_of
st_count st_count
cb_1 cb_1
end type
global w_yield w_yield

on w_yield.create
this.st_total=create st_total
this.st_of=create st_of
this.st_count=create st_count
this.cb_1=create cb_1
this.Control[]={this.st_total,&
this.st_of,&
this.st_count,&
this.cb_1}
end on

on w_yield.destroy
destroy(this.st_total)
destroy(this.st_of)
destroy(this.st_count)
destroy(this.cb_1)
end on

type st_total from statictext within w_yield
boolean visible = false
integer x = 498
integer y = 348
integer width = 274
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
boolean focusrectangle = false
end type

type st_of from statictext within w_yield
boolean visible = false
integer x = 416
integer y = 348
integer width = 105
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "of"
boolean focusrectangle = false
end type

type st_count from statictext within w_yield
boolean visible = false
integer x = 142
integer y = 348
integer width = 233
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_yield
integer x = 306
integer y = 148
integer width = 347
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Stop Function"
end type

event clicked;gi_yield = 1

close(parent)
end event

