$PBExportHeader$w_web_link_update.srw
forward
global type w_web_link_update from window
end type
type dw_1 from datawindow within w_web_link_update
end type
type cb_cancel from commandbutton within w_web_link_update
end type
type cb_ok from commandbutton within w_web_link_update
end type
end forward

global type w_web_link_update from window
integer width = 2423
integer height = 844
boolean titlebar = true
string title = "Web Address Update"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_web_link_update w_web_link_update

on w_web_link_update.create
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.dw_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_web_link_update.destroy
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;integer r
long v

v = message.doubleparm
dw_1.settransobject(sqlca)
r = dw_1.retrieve(v)

if r < 1 then
	messagebox("Web Link","Unable to get Lookup record associated with this verification.")
	close(this)
end if


end event

type dw_1 from datawindow within w_web_link_update
integer y = 8
integer width = 2400
integer height = 584
integer taborder = 10
string title = "none"
string dataobject = "d_web_address_update"
boolean border = false
boolean livescroll = true
end type

type cb_cancel from commandbutton within w_web_link_update
integer x = 1280
integer y = 624
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_ok from commandbutton within w_web_link_update
integer x = 873
integer y = 624
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;string ls_addr

dw_1.accepttext()
ls_addr =  dw_1.getitemstring(1,"web_address")
dw_1.update()

closewithreturn(parent, ls_addr)
end event

