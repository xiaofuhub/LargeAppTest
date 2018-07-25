$PBExportHeader$w_field_exceptions.srw
forward
global type w_field_exceptions from w_response
end type
type dw_1 from u_dw within w_field_exceptions
end type
type cb_1 from u_cb within w_field_exceptions
end type
type cb_2 from u_cb within w_field_exceptions
end type
type cb_3 from u_cb within w_field_exceptions
end type
end forward

global type w_field_exceptions from w_response
integer x = 23
integer y = 36
integer width = 2149
integer height = 1392
string title = "Field Exceptions List"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_field_exceptions w_field_exceptions

on w_field_exceptions.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
end on

on w_field_exceptions.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

type dw_1 from u_dw within w_field_exceptions
integer x = 46
integer y = 48
integer width = 2016
integer height = 1076
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_exceptions_list"
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( w_train_app.tr_training_data )
This.Retrieve( Integer( Message.StringParm ) )
end event

type cb_1 from u_cb within w_field_exceptions
integer x = 1335
integer y = 1164
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Parent.Event pfc_save()

Close( Parent )
end event

type cb_2 from u_cb within w_field_exceptions
integer x = 1705
integer y = 1164
integer taborder = 20
boolean bringtotop = true
string text = "&Cancel"
end type

event clicked;Close( Parent )
end event

type cb_3 from u_cb within w_field_exceptions
integer x = 969
integer y = 1164
integer taborder = 11
boolean bringtotop = true
string text = "&Print"
end type

event clicked;dw_1.Print()
end event

