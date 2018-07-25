$PBExportHeader$w_select_group_location.srw
forward
global type w_select_group_location from window
end type
type cb_can from commandbutton within w_select_group_location
end type
type cb_select from commandbutton within w_select_group_location
end type
type dw_1 from datawindow within w_select_group_location
end type
end forward

global type w_select_group_location from window
integer width = 2350
integer height = 1764
boolean titlebar = true
string title = "Select Group Location"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_can cb_can
cb_select cb_select
dw_1 dw_1
end type
global w_select_group_location w_select_group_location

type variables
long il_loc
end variables

on w_select_group_location.create
this.cb_can=create cb_can
this.cb_select=create cb_select
this.dw_1=create dw_1
this.Control[]={this.cb_can,&
this.cb_select,&
this.dw_1}
end on

on w_select_group_location.destroy
destroy(this.cb_can)
destroy(this.cb_select)
destroy(this.dw_1)
end on

event open;//Start Code Change ----04.10.2014 #V14.2 maha - screen created
dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_can from commandbutton within w_select_group_location
integer x = 1143
integer y = 1524
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

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_select from commandbutton within w_select_group_location
integer x = 777
integer y = 1524
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

event clicked;if il_loc = 0 then
	closewithreturn(parent,"Cancel")
else
	closewithreturn(parent,il_loc)
end if
end event

type dw_1 from datawindow within w_select_group_location
integer x = 41
integer y = 36
integer width = 2254
integer height = 1468
integer taborder = 10
string title = "none"
string dataobject = "d_group_search_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r

r = this.getclickedrow( )

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_loc = this.getitemnumber(r,"rec_id")
end event

