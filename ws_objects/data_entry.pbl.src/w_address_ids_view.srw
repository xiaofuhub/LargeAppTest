$PBExportHeader$w_address_ids_view.srw
forward
global type w_address_ids_view from window
end type
type cb_ok from commandbutton within w_address_ids_view
end type
type dw_1 from datawindow within w_address_ids_view
end type
end forward

global type w_address_ids_view from window
integer width = 2789
integer height = 1132
boolean titlebar = true
string title = "Connected Ids"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
dw_1 dw_1
end type
global w_address_ids_view w_address_ids_view

event open;long ll_id

ll_id = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_id)
end event

on w_address_ids_view.create
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_ok,&
this.dw_1}
end on

on w_address_ids_view.destroy
destroy(this.cb_ok)
destroy(this.dw_1)
end on

type cb_ok from commandbutton within w_address_ids_view
integer x = 1147
integer y = 896
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

event clicked;close(parent)
end event

type dw_1 from datawindow within w_address_ids_view
integer width = 2752
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_net_dev_ids_address"
boolean vscrollbar = true
boolean livescroll = true
end type

