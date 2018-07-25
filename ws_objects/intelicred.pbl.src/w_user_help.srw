$PBExportHeader$w_user_help.srw
forward
global type w_user_help from window
end type
type dw_1 from datawindow within w_user_help
end type
end forward

global type w_user_help from window
integer width = 4567
integer height = 3064
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_user_help w_user_help

on w_user_help.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_user_help.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_user_help
integer x = 69
integer y = 224
integer width = 4293
integer height = 2632
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

