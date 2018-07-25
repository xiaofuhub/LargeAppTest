$PBExportHeader$w_isg_cvo_user_set.srw
forward
global type w_isg_cvo_user_set from w_popup
end type
type cb_close from commandbutton within w_isg_cvo_user_set
end type
type cb_ok from commandbutton within w_isg_cvo_user_set
end type
type dw_1 from datawindow within w_isg_cvo_user_set
end type
end forward

global type w_isg_cvo_user_set from w_popup
long backcolor = 33551856
cb_close cb_close
cb_ok cb_ok
dw_1 dw_1
end type
global w_isg_cvo_user_set w_isg_cvo_user_set

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_isg_cvo_user_set.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_isg_cvo_user_set.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

type cb_close from commandbutton within w_isg_cvo_user_set
integer x = 2062
integer y = 24
integer width = 379
integer height = 84
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

type cb_ok from commandbutton within w_isg_cvo_user_set
integer x = 1664
integer y = 24
integer width = 379
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;dw_1.update()
close(parent)
end event

type dw_1 from datawindow within w_isg_cvo_user_set
integer y = 124
integer width = 2450
integer height = 1260
integer taborder = 10
string title = "none"
string dataobject = "d_user_isg_cvo_set"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

