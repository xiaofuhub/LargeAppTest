$PBExportHeader$w_call_log_open_calls.srw
forward
global type w_call_log_open_calls from window
end type
type cb_close from commandbutton within w_call_log_open_calls
end type
type uo_1 from u_call_log_my_stuff within w_call_log_open_calls
end type
end forward

global type w_call_log_open_calls from window
integer width = 4457
integer height = 2364
boolean titlebar = true
string title = "Open Calls"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
uo_1 uo_1
end type
global w_call_log_open_calls w_call_log_open_calls

on w_call_log_open_calls.create
this.cb_close=create cb_close
this.uo_1=create uo_1
this.Control[]={this.cb_close,&
this.uo_1}
end on

on w_call_log_open_calls.destroy
destroy(this.cb_close)
destroy(this.uo_1)
end on

event open;uo_1.of_open()
end event

type cb_close from commandbutton within w_call_log_open_calls
integer x = 4082
integer y = 32
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(parent)
end event

type uo_1 from u_call_log_my_stuff within w_call_log_open_calls
integer width = 4448
integer height = 2268
integer taborder = 50
end type

on uo_1.destroy
call u_call_log_my_stuff::destroy
end on

