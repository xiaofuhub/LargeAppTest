$PBExportHeader$w_preview_app_mockup.srw
forward
global type w_preview_app_mockup from window
end type
type cb_3 from commandbutton within w_preview_app_mockup
end type
type cb_2 from commandbutton within w_preview_app_mockup
end type
type cb_1 from commandbutton within w_preview_app_mockup
end type
type dw_1 from datawindow within w_preview_app_mockup
end type
type uo_1 from pfc_cst_u_preview_app within w_preview_app_mockup
end type
end forward

global type w_preview_app_mockup from window
integer width = 4951
integer height = 2596
boolean titlebar = true
string title = "mockup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
uo_1 uo_1
end type
global w_preview_app_mockup w_preview_app_mockup

on w_preview_app_mockup.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.uo_1}
end on

on w_preview_app_mockup.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.uo_1)
end on

type cb_3 from commandbutton within w_preview_app_mockup
integer x = 731
integer y = 2372
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fax"
end type

type cb_2 from commandbutton within w_preview_app_mockup
integer x = 370
integer y = 2372
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email"
end type

type cb_1 from commandbutton within w_preview_app_mockup
integer x = 9
integer y = 2372
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

type dw_1 from datawindow within w_preview_app_mockup
integer y = 4
integer width = 1074
integer height = 2356
integer taborder = 80
boolean titlebar = true
string title = "Populated Applications"
string dataobject = "d_net_dev_action_items_ai_sk"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from pfc_cst_u_preview_app within w_preview_app_mockup
integer x = 1083
integer y = 8
integer taborder = 70
end type

on uo_1.destroy
call pfc_cst_u_preview_app::destroy
end on

