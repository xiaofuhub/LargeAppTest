$PBExportHeader$w_email_select.srw
forward
global type w_email_select from window
end type
type dw_1 from datawindow within w_email_select
end type
type cb_close from commandbutton within w_email_select
end type
type cb_select from commandbutton within w_email_select
end type
end forward

global type w_email_select from window
integer width = 2642
integer height = 2472
boolean titlebar = true
string title = "Select Email Template"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_close cb_close
cb_select cb_select
end type
global w_email_select w_email_select

event open;dw_1.settransobject( sqlca)
dw_1.retrieve()
end event

on w_email_select.create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_select=create cb_select
this.Control[]={this.dw_1,&
this.cb_close,&
this.cb_select}
end on

on w_email_select.destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_select)
end on

type dw_1 from datawindow within w_email_select
integer width = 2629
integer height = 2232
integer taborder = 10
string title = "none"
string dataobject = "d_email_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;integer t

t = this.getitemnumber(row,"email_id")

closewithreturn(parent,t)
end event

type cb_close from commandbutton within w_email_select
integer x = 1230
integer y = 2252
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_select from commandbutton within w_email_select
integer x = 873
integer y = 2252
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer t

t = dw_1.getitemnumber(dw_1.getrow() ,"email_id")

closewithreturn(parent,t)
end event

