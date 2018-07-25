$PBExportHeader$w_security_banner.srw
forward
global type w_security_banner from window
end type
type dw_1 from datawindow within w_security_banner
end type
type cb_can from commandbutton within w_security_banner
end type
type cb_ok from commandbutton within w_security_banner
end type
end forward

global type w_security_banner from window
integer width = 3621
integer height = 1944
windowtype windowtype = response!
long backcolor = 23930409
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_can cb_can
cb_ok cb_ok
end type
global w_security_banner w_security_banner

type variables

end variables

on w_security_banner.create
this.dw_1=create dw_1
this.cb_can=create cb_can
this.cb_ok=create cb_ok
this.Control[]={this.dw_1,&
this.cb_can,&
this.cb_ok}
end on

on w_security_banner.destroy
destroy(this.dw_1)
destroy(this.cb_can)
destroy(this.cb_ok)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type dw_1 from datawindow within w_security_banner
integer x = 18
integer width = 3593
integer height = 1796
integer taborder = 10
string dataobject = "d_security_banner_text"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type cb_can from commandbutton within w_security_banner
integer x = 1819
integer y = 1804
integer width = 343
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean default = true
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_ok from commandbutton within w_security_banner
integer x = 1477
integer y = 1804
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Accept"
end type

event clicked;closewithreturn(parent,"OK")
end event

