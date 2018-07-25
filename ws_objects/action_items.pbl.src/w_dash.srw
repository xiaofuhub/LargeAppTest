$PBExportHeader$w_dash.srw
forward
global type w_dash from window
end type
type uo_1 from pfc_cst_u_dashboard within w_dash
end type
end forward

global type w_dash from window
integer x = 5
integer y = 384
integer width = 1938
integer height = 1816
boolean titlebar = true
string title = "Task List"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
uo_1 uo_1
end type
global w_dash w_dash

on w_dash.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on w_dash.destroy
destroy(this.uo_1)
end on

event timer;uo_1.uo_1.f_settime( now( ))
end event

event open;Timer( 1 )
end event

type uo_1 from pfc_cst_u_dashboard within w_dash
event destroy ( )
integer height = 1716
integer taborder = 10
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_dashboard::destroy
end on

