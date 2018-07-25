$PBExportHeader$w_select_applications.srw
forward
global type w_select_applications from w_response
end type
type dw_1 from u_dw within w_select_applications
end type
type cb_1 from commandbutton within w_select_applications
end type
type cb_2 from commandbutton within w_select_applications
end type
end forward

global type w_select_applications from w_response
integer x = 233
integer y = 124
integer width = 2725
integer height = 2212
string title = "Select Application"
long backcolor = 33551856
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_select_applications w_select_applications

on w_select_applications.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_select_applications.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_1 from u_dw within w_select_applications
integer width = 2706
integer height = 1996
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_applications"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.Retrieve( )
end event

type cb_1 from commandbutton within w_select_applications
integer x = 1001
integer y = 2020
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
boolean default = true
end type

event clicked;gs_pass_ids lgs_app_ids
Integer li_rc
Integer i
Integer li_cnt

dw_1.AcceptText()

FOR i = 1 TO li_rc
	IF dw_1.GetItemNumber( i, "selected" ) = 1 THEN
		li_cnt++
		lgs_app_ids.i_ids[ li_cnt ] = dw_1.GetItemNumber( i, "app_id" )
	END IF
END FOR


CloseWithReturn( Parent, lgs_app_ids )
end event

type cb_2 from commandbutton within w_select_applications
integer x = 1262
integer y = 2020
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

