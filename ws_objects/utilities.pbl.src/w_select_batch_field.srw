$PBExportHeader$w_select_batch_field.srw
forward
global type w_select_batch_field from window
end type
type cb_2 from commandbutton within w_select_batch_field
end type
type cb_1 from commandbutton within w_select_batch_field
end type
type dw_1 from datawindow within w_select_batch_field
end type
end forward

global type w_select_batch_field from window
integer width = 2016
integer height = 2088
boolean titlebar = true
string title = "Select Batch Field"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_select_batch_field w_select_batch_field

on w_select_batch_field.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_select_batch_field.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;integer tid

tid = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(tid)

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.02.2013
//$<reason> remove batch add screen setup
dw_1.insertrow(1)
dw_1.selectrow(0,false)
dw_1.selectrow(1,true)
//------------------- APPEON END -------------------
end event

type cb_2 from commandbutton within w_select_batch_field
integer x = 997
integer y = 1852
integer width = 343
integer height = 92
integer taborder = 30
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

type cb_1 from commandbutton within w_select_batch_field
integer x = 649
integer y = 1852
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

event clicked;long r

r = dw_1.getitemnumber(dw_1.getrow(),"sys_fields_field_id")

//Start Code Change ----12.03.2013 #V14 maha - removed
//if r < 1 then 
//	messagebox("Select Field","You have not selected a field")
//	return 0
//else
	closewithreturn(parent,r)  //Start Code Change ----08.16.2014 #V14.2 maha
//end if
//End Code Change ----12.03.2013


end event

type dw_1 from datawindow within w_select_batch_field
integer x = 64
integer y = 40
integer width = 1870
integer height = 1776
integer taborder = 10
string title = "none"
string dataobject = "d_sys_fields_lookups_select"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r

r = this.getclickedrow()

If r > 0 then this.setrow(r)
end event

event rowfocuschanged;this.selectrow( 0, false)
this.selectrow( currentrow, true)
end event

