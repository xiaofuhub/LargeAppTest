$PBExportHeader$w_select_facility_for_prac_user.srw
forward
global type w_select_facility_for_prac_user from w_response
end type
type st_1 from statictext within w_select_facility_for_prac_user
end type
type dw_select from u_dw within w_select_facility_for_prac_user
end type
type cb_select from commandbutton within w_select_facility_for_prac_user
end type
type cb_cancel from commandbutton within w_select_facility_for_prac_user
end type
end forward

global type w_select_facility_for_prac_user from w_response
integer x = 987
integer y = 716
integer width = 1678
integer height = 368
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
dw_select dw_select
cb_select cb_select
cb_cancel cb_cancel
end type
global w_select_facility_for_prac_user w_select_facility_for_prac_user

on w_select_facility_for_prac_user.create
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

on w_select_facility_for_prac_user.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.cb_select)
destroy(this.cb_cancel)
end on

event open;call super::open; //Start Code Change ----05.31.2017 #V154 maha - for WV audit email
long ll_prac
datawindowchild dwchild

ll_prac = message.doubleparm

dw_select.insertrow(1)
dw_select.getchild("facility_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(ll_prac, gs_user_id)


end event

type st_1 from statictext within w_select_facility_for_prac_user
integer x = 69
integer y = 76
integer width = 1513
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Select Facility for which to Process the Email"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_select_facility_for_prac_user
integer x = 59
integer y = 164
integer width = 1010
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_facility_select_list"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
end event

type cb_select from commandbutton within w_select_facility_for_prac_user
integer x = 1088
integer y = 164
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
string text = "OK"
boolean default = true
end type

event clicked;IF IsNull( dw_select.GetItemNumber( 1, "facility_id" ) ) THEN
	MessageBox("Select Error", "You must first select a facility." )
	dw_select.SetFocus( )
	Return -1
END IF

CloseWithReturn( Parent, dw_select.GetItemNumber( 1, "facility_id" ))
end event

type cb_cancel from commandbutton within w_select_facility_for_prac_user
integer x = 1353
integer y = 164
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

event clicked;CloseWithReturn( Parent, 0 )
end event

