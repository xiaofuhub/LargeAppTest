$PBExportHeader$w_demos.srw
forward
global type w_demos from window
end type
type cb_3 from commandbutton within w_demos
end type
type cb_2 from commandbutton within w_demos
end type
type cb_1 from commandbutton within w_demos
end type
end forward

global type w_demos from window
integer width = 1042
integer height = 1176
boolean titlebar = true
string title = "New Development"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_demos w_demos

on w_demos.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_demos.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_3 from commandbutton within w_demos
integer x = 219
integer y = 388
integer width = 517
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Launch Pad"
end type

event clicked;open(w_Launch_pad)
end event

type cb_2 from commandbutton within w_demos
integer x = 219
integer y = 228
integer width = 517
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scheduler screen"
end type

event clicked;open(w_auto_schedule)
end event

type cb_1 from commandbutton within w_demos
integer x = 219
integer y = 80
integer width = 517
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Notification Painter"
end type

event clicked;//open(w_notification_painter)
end event

