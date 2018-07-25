$PBExportHeader$w_master_password.srw
forward
global type w_master_password from window
end type
type cb_1 from commandbutton within w_master_password
end type
type st_1 from statictext within w_master_password
end type
type cb_2 from commandbutton within w_master_password
end type
type em_1 from editmask within w_master_password
end type
type sle_2 from singlelineedit within w_master_password
end type
type cb_go from commandbutton within w_master_password
end type
end forward

global type w_master_password from window
integer width = 1175
integer height = 776
boolean titlebar = true
string title = "Today~'s Password"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_1 st_1
cb_2 cb_2
em_1 em_1
sle_2 sle_2
cb_go cb_go
end type
global w_master_password w_master_password

on w_master_password.create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_2=create cb_2
this.em_1=create em_1
this.sle_2=create sle_2
this.cb_go=create cb_go
this.Control[]={this.cb_1,&
this.st_1,&
this.cb_2,&
this.em_1,&
this.sle_2,&
this.cb_go}
end on

on w_master_password.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.em_1)
destroy(this.sle_2)
destroy(this.cb_go)
end on

event open;
if gi_test_mode = 1 then
	em_1.visible = true
	cb_go.visible = true
end if

em_1.text = string(today())
cb_go.triggerevent(clicked!)
end event

type cb_1 from commandbutton within w_master_password
integer x = 699
integer y = 268
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clipboard"
end type

event clicked;clipboard(sle_2.text)
end event

type st_1 from statictext within w_master_password
integer x = 3794
integer y = 48
integer width = 78
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 15780518
boolean focusrectangle = false
end type

event clicked;em_1.visible = true
cb_go.visible = true
end event

type cb_2 from commandbutton within w_master_password
integer x = 379
integer y = 476
integer width = 343
integer height = 92
integer taborder = 20
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

type em_1 from editmask within w_master_password
boolean visible = false
integer x = 366
integer y = 132
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

type sle_2 from singlelineedit within w_master_password
integer x = 32
integer y = 260
integer width = 640
integer height = 100
integer taborder = 20
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "OOOOOOOO"
end type

type cb_go from commandbutton within w_master_password
boolean visible = false
integer x = 379
integer y = 372
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;sle_2.text = of_day_password(date(em_1.text))
end event

