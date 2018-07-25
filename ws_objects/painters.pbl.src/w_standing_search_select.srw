$PBExportHeader$w_standing_search_select.srw
forward
global type w_standing_search_select from window
end type
type st_1 from statictext within w_standing_search_select
end type
type dw_1 from datawindow within w_standing_search_select
end type
type cb_close from commandbutton within w_standing_search_select
end type
type cb_save from commandbutton within w_standing_search_select
end type
end forward

global type w_standing_search_select from window
integer width = 1083
integer height = 432
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
dw_1 dw_1
cb_close cb_close
cb_save cb_save
end type
global w_standing_search_select w_standing_search_select

type variables
integer ii_type
end variables

on w_standing_search_select.create
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.Control[]={this.st_1,&
this.dw_1,&
this.cb_close,&
this.cb_save}
end on

on w_standing_search_select.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_save)
end on

type st_1 from statictext within w_standing_search_select
integer x = 123
integer y = 32
integer width = 375
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Flag Type"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_standing_search_select
integer x = 105
integer y = 96
integer width = 859
integer height = 84
integer taborder = 30
string title = "none"
string dataobject = "d_standing_type"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dw_child

this.settransobject(sqlca)
this.retrieve()

this.getchild("display_value", dw_child)

dw_child.insertrow(1)
dw_child.setitem(1,"lu_id", -1)
dw_child.setitem(1,"display_value", "All Flagged records")
this.insertrow(1)
end event

event itemchanged;ii_type = integer(data)
end event

type cb_close from commandbutton within w_standing_search_select
integer x = 585
integer y = 272
integer width = 366
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Closewithreturn(parent,'Cancel')
end event

type cb_save from commandbutton within w_standing_search_select
integer x = 187
integer y = 272
integer width = 366
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

event clicked;Closewithreturn(parent,ii_type)
end event

