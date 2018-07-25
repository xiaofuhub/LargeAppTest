$PBExportHeader$w_get_facility.srw
forward
global type w_get_facility from w_response
end type
type st_1 from statictext within w_get_facility
end type
type dw_select from u_dw within w_get_facility
end type
type cb_select from commandbutton within w_get_facility
end type
type cb_cancel from commandbutton within w_get_facility
end type
end forward

global type w_get_facility from w_response
integer x = 987
integer y = 716
integer width = 1975
integer height = 340
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
dw_select dw_select
cb_select cb_select
cb_cancel cb_cancel
end type
global w_get_facility w_get_facility

on w_get_facility.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_select=create dw_select
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_select
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.cb_cancel
end on

on w_get_facility.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.cb_select)
destroy(this.cb_cancel)
end on

type st_1 from statictext within w_get_facility
integer x = 59
integer y = 72
integer width = 1170
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select facility to which to copy verification entries"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_get_facility
integer x = 59
integer y = 136
integer width = 1321
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_facility"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )
This.of_SetUpdateAble( False )
end event

type cb_select from commandbutton within w_get_facility
integer x = 1399
integer y = 136
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
string text = "&Select"
boolean default = true
end type

event clicked;IF IsNull( dw_select.GetItemNumber( 1, "facility_id" ) ) THEN
	MessageBox("Select Error", "You must first select a facility." )
	dw_select.SetFocus( )
	Return -1
END IF

CloseWithReturn( Parent, String( dw_select.GetItemNumber( 1, "facility_id" )))
end event

type cb_cancel from commandbutton within w_get_facility
integer x = 1664
integer y = 136
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
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

