$PBExportHeader$w_copy_contract_management_rights.srw
$PBExportComments$Create by Jack 11/01/2006
forward
global type w_copy_contract_management_rights from w_response
end type
type cb_2 from commandbutton within w_copy_contract_management_rights
end type
type cb_1 from commandbutton within w_copy_contract_management_rights
end type
type dw_select_role from u_dw within w_copy_contract_management_rights
end type
type gb_select from groupbox within w_copy_contract_management_rights
end type
end forward

global type w_copy_contract_management_rights from w_response
integer width = 1966
integer height = 320
string title = "Copy Contract Management Rights"
boolean controlmenu = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_select_role dw_select_role
gb_select gb_select
end type
global w_copy_contract_management_rights w_copy_contract_management_rights

on w_copy_contract_management_rights.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_select_role=create dw_select_role
this.gb_select=create gb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_select_role
this.Control[iCurrent+4]=this.gb_select
end on

on w_copy_contract_management_rights.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_select_role)
destroy(this.gb_select)
end on

event open;call super::open;dw_select_role.of_SetTransObject( SQLCA )
dw_select_role.Retrieve()
dw_select_role.InsertRow( 0 )



end event

type cb_2 from commandbutton within w_copy_contract_management_rights
integer x = 1563
integer y = 84
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(Parent,0)

end event

type cb_1 from commandbutton within w_copy_contract_management_rights
integer x = 1221
integer y = 84
integer width = 334
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;long ll_role_id,ll_row
dw_select_role.accepttext()
ll_row = dw_select_role.getrow()
If ll_row <= 0 Then Return
ll_role_id = dw_select_role.getitemnumber(ll_row,'role_id')
closewithreturn(Parent,ll_role_id)


end event

type dw_select_role from u_dw within w_copy_contract_management_rights
integer x = 37
integer y = 84
integer width = 1143
integer height = 112
integer taborder = 20
string dataobject = "d_security_select_roles"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateable( False )
end event

type gb_select from groupbox within w_copy_contract_management_rights
integer x = 5
integer y = 16
integer width = 1938
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Role"
end type

