$PBExportHeader$w_entity_group_add_view.srw
forward
global type w_entity_group_add_view from window
end type
type cb_2 from commandbutton within w_entity_group_add_view
end type
type dw_1 from datawindow within w_entity_group_add_view
end type
type cb_1 from commandbutton within w_entity_group_add_view
end type
end forward

global type w_entity_group_add_view from window
integer width = 2802
integer height = 1016
boolean titlebar = true
string title = "Group"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
end type
global w_entity_group_add_view w_entity_group_add_view

type variables
long il_id
end variables

event open;il_id = message.doubleparm

if il_id = -1 then
	dw_1.insertrow(1)
else
	dw_1.retrieve(il_id)
end if
end event

on w_entity_group_add_view.create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.dw_1,&
this.cb_1}
end on

on w_entity_group_add_view.destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_entity_group_add_view
integer x = 1367
integer y = 808
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

type dw_1 from datawindow within w_entity_group_add_view
integer width = 2784
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "d_multi_group_detail"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_1 from commandbutton within w_entity_group_add_view
integer x = 1010
integer y = 808
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

event clicked;

if isnull(dw_1.getitemnumber(1,"rec_id")) then
	select max(rec_id) into :il_id from group_multi_loc;
	il_id++
	dw_1.setitem(1,"rec_id", il_id)
end if

dw_1.update()

closewithreturn(parent, il_id)
	
end event

