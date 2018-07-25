$PBExportHeader$w_session_info_utl.srw
forward
global type w_session_info_utl from window
end type
type cb_2 from commandbutton within w_session_info_utl
end type
type cb_1 from commandbutton within w_session_info_utl
end type
type dw_1 from datawindow within w_session_info_utl
end type
end forward

global type w_session_info_utl from window
integer width = 2469
integer height = 1596
boolean titlebar = true
string title = "User Sessions"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_session_info_utl w_session_info_utl

on w_session_info_utl.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_session_info_utl.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_session_info_utl
integer x = 2043
integer y = 36
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

type cb_1 from commandbutton within w_session_info_utl
integer x = 1673
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;dw_1.retrieve()
end event

type dw_1 from datawindow within w_session_info_utl
integer x = 55
integer y = 148
integer width = 2327
integer height = 1280
integer taborder = 10
string title = "none"
string dataobject = "d_session_info_utl"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

