$PBExportHeader$w_user_select.srw
forward
global type w_user_select from window
end type
type cb_ok from commandbutton within w_user_select
end type
type cb_can from commandbutton within w_user_select
end type
type dw_users from datawindow within w_user_select
end type
end forward

global type w_user_select from window
integer width = 1678
integer height = 1900
boolean titlebar = true
string title = "Select User"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
cb_can cb_can
dw_users dw_users
end type
global w_user_select w_user_select

type variables
gs_pass_ids ist_ids
end variables

on w_user_select.create
this.cb_ok=create cb_ok
this.cb_can=create cb_can
this.dw_users=create dw_users
this.Control[]={this.cb_ok,&
this.cb_can,&
this.dw_users}
end on

on w_user_select.destroy
destroy(this.cb_ok)
destroy(this.cb_can)
destroy(this.dw_users)
end on

type cb_ok from commandbutton within w_user_select
integer x = 635
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
string text = "Select"
end type

event clicked;ist_ids.s_ids[1] = dw_users.getitemstring(dw_users.getrow(),"user_id")
ist_ids.s_ids[2] = dw_users.getitemstring(dw_users.getrow(),"user_name")
ist_ids.s_ids[3] = dw_users.getitemstring(dw_users.getrow(),"email_id")
closewithreturn(parent, ist_ids)
end event

type cb_can from commandbutton within w_user_select
integer x = 1262
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
string text = "Cancel"
end type

event clicked;ist_ids.s_ids[1] = "Cancel"
closewithreturn(parent, ist_ids)
end event

type dw_users from datawindow within w_user_select
integer x = 64
integer y = 152
integer width = 1541
integer height = 1624
integer taborder = 10
string title = "none"
string dataobject = "d_user_list_isg"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event doubleclicked;cb_ok.triggerevent(clicked!)
end event

