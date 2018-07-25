$PBExportHeader$w_select_profile_view.srw
forward
global type w_select_profile_view from w_response
end type
type cb_cancel from u_cb within w_select_profile_view
end type
type st_1 from statictext within w_select_profile_view
end type
type cb_ok from u_cb within w_select_profile_view
end type
type dw_select from u_dw within w_select_profile_view
end type
end forward

global type w_select_profile_view from w_response
integer x = 1170
integer y = 424
integer width = 1216
integer height = 528
string title = "Select Custom Profile"
long backcolor = 33551856
cb_cancel cb_cancel
st_1 st_1
cb_ok cb_ok
dw_select dw_select
end type
global w_select_profile_view w_select_profile_view

type variables
Integer ii_data_view_id = 1
end variables

on w_select_profile_view.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.cb_ok=create cb_ok
this.dw_select=create dw_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_select
end on

on w_select_profile_view.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.dw_select)
end on

type cb_cancel from u_cb within w_select_profile_view
integer x = 590
integer y = 260
integer height = 84
integer taborder = 10
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type st_1 from statictext within w_select_profile_view
integer x = 82
integer y = 52
integer width = 334
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select Profile"
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_select_profile_view
integer x = 229
integer y = 264
integer height = 84
integer taborder = 20
string text = "&OK"
boolean default = true
end type

event clicked;CloseWithReturn( Parent, ii_data_view_id )
end event

type dw_select from u_dw within w_select_profile_view
integer x = 73
integer y = 116
integer width = 1061
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_profile_view"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.SetRow( 1 )
This.ScrollToRow( 1 )





end event

event itemchanged;call super::itemchanged;ii_data_view_id = Integer( data )




end event

