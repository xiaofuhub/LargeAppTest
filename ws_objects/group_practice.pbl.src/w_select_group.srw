$PBExportHeader$w_select_group.srw
forward
global type w_select_group from w_response
end type
type dw_select from u_dw within w_select_group
end type
type cb_select from commandbutton within w_select_group
end type
type cb_cancel from commandbutton within w_select_group
end type
end forward

global type w_select_group from w_response
integer x = 987
integer y = 716
integer width = 1975
integer height = 440
string title = "Select Group"
boolean controlmenu = false
long backcolor = 33551856
dw_select dw_select
cb_select cb_select
cb_cancel cb_cancel
end type
global w_select_group w_select_group

type variables
long il_g = 0
end variables

on w_select_group.create
int iCurrent
call super::create
this.dw_select=create dw_select
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_select
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_select_group.destroy
call super::destroy
destroy(this.dw_select)
destroy(this.cb_select)
destroy(this.cb_cancel)
end on

type dw_select from u_dw within w_select_group
integer x = 59
integer y = 136
integer width = 1285
integer height = 76
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_group_select"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )
This.of_SetUpdateAble( False )
end event

event itemchanged;call super::itemchanged;il_g = long(data)
end event

type cb_select from commandbutton within w_select_group
integer x = 1399
integer y = 132
integer width = 247
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;IF il_g = 0 THEN
	MessageBox("Select Error", "You must first select a Group." )
	dw_select.SetFocus( )
	Return -1
END IF

CloseWithReturn( Parent, il_g)
end event

type cb_cancel from commandbutton within w_select_group
integer x = 1664
integer y = 132
integer width = 247
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, 0 )
end event

