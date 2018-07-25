$PBExportHeader$w_appl_tracker_screen_painter.srw
forward
global type w_appl_tracker_screen_painter from window
end type
type cb_2 from commandbutton within w_appl_tracker_screen_painter
end type
type cb_1 from commandbutton within w_appl_tracker_screen_painter
end type
type dw_data from datawindow within w_appl_tracker_screen_painter
end type
end forward

global type w_appl_tracker_screen_painter from window
integer width = 2688
integer height = 1108
boolean titlebar = true
string title = "Application Tracking Field Utility"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_data dw_data
end type
global w_appl_tracker_screen_painter w_appl_tracker_screen_painter

on w_appl_tracker_screen_painter.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_data=create dw_data
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_data}
end on

on w_appl_tracker_screen_painter.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_data)
end on

event open;dw_data.settransobject(sqlca)
dw_data.retrieve()
end event

type cb_2 from commandbutton within w_appl_tracker_screen_painter
integer x = 2304
integer y = 20
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

type cb_1 from commandbutton within w_appl_tracker_screen_painter
integer x = 1934
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_data.update()
end event

type dw_data from datawindow within w_appl_tracker_screen_painter
integer x = 27
integer y = 124
integer width = 2624
integer height = 900
integer taborder = 10
string title = "none"
string dataobject = "d_appl_tracker_fields_setup"
boolean livescroll = true
end type

