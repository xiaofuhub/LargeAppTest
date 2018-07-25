$PBExportHeader$w_appl_esign_action.srw
forward
global type w_appl_esign_action from window
end type
type cb_1 from commandbutton within w_appl_esign_action
end type
type dw_1 from datawindow within w_appl_esign_action
end type
end forward

global type w_appl_esign_action from window
integer width = 3177
integer height = 1724
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_appl_esign_action w_appl_esign_action

on w_appl_esign_action.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_appl_esign_action.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_appl_esign_action
integer x = 1312
integer y = 1488
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

type dw_1 from datawindow within w_appl_esign_action
integer x = 23
integer y = 12
integer width = 3077
integer height = 1444
integer taborder = 10
string title = "none"
string dataobject = "d_net_dev_action_items_sign"
boolean livescroll = true
end type

