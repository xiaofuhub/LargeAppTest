$PBExportHeader$w_priv_facility_select.srw
forward
global type w_priv_facility_select from window
end type
type dw_1 from datawindow within w_priv_facility_select
end type
type cb_can from commandbutton within w_priv_facility_select
end type
type cb_select from commandbutton within w_priv_facility_select
end type
end forward

global type w_priv_facility_select from window
integer width = 1696
integer height = 820
boolean titlebar = true
string title = "Select Facility for Form"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_can cb_can
cb_select cb_select
end type
global w_priv_facility_select w_priv_facility_select

type variables
long il_facil = 0
end variables

on w_priv_facility_select.create
this.dw_1=create dw_1
this.cb_can=create cb_can
this.cb_select=create cb_select
this.Control[]={this.dw_1,&
this.cb_can,&
this.cb_select}
end on

on w_priv_facility_select.destroy
destroy(this.dw_1)
destroy(this.cb_can)
destroy(this.cb_select)
end on

event open;long ll_temp

ll_temp = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_temp)
end event

type dw_1 from datawindow within w_priv_facility_select
integer width = 1682
integer height = 600
integer taborder = 10
string title = "none"
string dataobject = "d_priv_facility_select_report"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer i

i = this.getclickedrow()
this.setrow(i)
this.selectrow(0,false)
this.selectrow(i,true)

if i > 0 then
	il_facil = this.getitemnumber(i,"facility_id")
end if
end event

event doubleclicked;cb_select.triggerevent(clicked!)
end event

type cb_can from commandbutton within w_priv_facility_select
integer x = 827
integer y = 620
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

type cb_select from commandbutton within w_priv_facility_select
integer x = 462
integer y = 620
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

event clicked;if il_facil = 0 then
	messagebox("Facility Selection","Please select a facility, or click Cancel")
end if

closewithreturn(parent,il_facil)
end event

