$PBExportHeader$w_group_billing_addr_select.srw
forward
global type w_group_billing_addr_select from w_response
end type
type cb_ok from commandbutton within w_group_billing_addr_select
end type
type cb_cancel from commandbutton within w_group_billing_addr_select
end type
type dw_1 from datawindow within w_group_billing_addr_select
end type
end forward

global type w_group_billing_addr_select from w_response
integer x = 214
integer y = 221
integer width = 4544
integer height = 2064
string title = "Select Billing Address"
boolean controlmenu = false
long backcolor = 33551856
cb_ok cb_ok
cb_cancel cb_cancel
dw_1 dw_1
end type
global w_group_billing_addr_select w_group_billing_addr_select

type variables
long il_loc
end variables

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_group_billing_addr_select.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.dw_1
end on

on w_group_billing_addr_select.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_1)
end on

type cb_ok from commandbutton within w_group_billing_addr_select
integer x = 1691
integer y = 24
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;closewithreturn(parent, il_loc)
end event

type cb_cancel from commandbutton within w_group_billing_addr_select
integer x = 2121
integer y = 24
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type dw_1 from datawindow within w_group_billing_addr_select
integer x = 5
integer y = 132
integer width = 4521
integer height = 1840
integer taborder = 10
string title = "none"
string dataobject = "d_group_prac_search_billing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;
if currentrow < 1 then return

il_loc = this.getitemnumber(currentrow,"rec_id")
end event

event doubleclicked;cb_ok.triggerevent(clicked!)
end event

