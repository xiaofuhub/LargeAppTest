$PBExportHeader$pfc_cst_u_security_roles_painter_contrac.sru
$PBExportComments$Create by Jack 10/27/2006
forward
global type pfc_cst_u_security_roles_painter_contrac from userobject
end type
type dw_4 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
end type
type dw_3 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
end type
type dw_2 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
end type
type dw_1 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
end type
type cb_cancel from commandbutton within pfc_cst_u_security_roles_painter_contrac
end type
type cb_ok from commandbutton within pfc_cst_u_security_roles_painter_contrac
end type
type cb_copy from commandbutton within pfc_cst_u_security_roles_painter_contrac
end type
type gb_2 from groupbox within pfc_cst_u_security_roles_painter_contrac
end type
type gb_3 from groupbox within pfc_cst_u_security_roles_painter_contrac
end type
type gb_4 from groupbox within pfc_cst_u_security_roles_painter_contrac
end type
type gb_1 from groupbox within pfc_cst_u_security_roles_painter_contrac
end type
end forward

global type pfc_cst_u_security_roles_painter_contrac from userobject
integer width = 2752
integer height = 1708
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_cancel cb_cancel
cb_ok cb_ok
cb_copy cb_copy
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_1 gb_1
end type
global pfc_cst_u_security_roles_painter_contrac pfc_cst_u_security_roles_painter_contrac

type variables
//w_security_roles_painter  iw_win


end variables

on pfc_cst_u_security_roles_painter_contrac.create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_copy=create cb_copy
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_1=create gb_1
this.Control[]={this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.cb_cancel,&
this.cb_ok,&
this.cb_copy,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_1}
end on

on pfc_cst_u_security_roles_painter_contrac.destroy
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_copy)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_1)
end on

type dw_4 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
integer x = 1426
integer y = 944
integer width = 1266
integer height = 672
integer taborder = 20
string dataobject = "d_contract_management_documents"
boolean livescroll = false
end type

event getfocus;//
end event

event losefocus;//
end event

event rbuttonup;//
end event

type dw_3 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
integer x = 50
integer y = 944
integer width = 1280
integer height = 672
integer taborder = 40
string dataobject = "d_contract_management_templates"
boolean livescroll = false
end type

event getfocus;//
end event

event losefocus;//
end event

event rbuttonup;//
end event

type dw_2 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
integer x = 1426
integer y = 164
integer width = 1266
integer height = 672
integer taborder = 20
string dataobject = "d_contract_management_clauses"
boolean livescroll = false
end type

event getfocus;//
end event

event losefocus;//
end event

event rbuttonup;//
end event

type dw_1 from u_dw_contract within pfc_cst_u_security_roles_painter_contrac
integer x = 50
integer y = 164
integer width = 1280
integer height = 672
integer taborder = 30
string dataobject = "d_contract_management_tracking"
end type

event getfocus;//
end event

event losefocus;//
end event

event rbuttonup;//
end event

type cb_cancel from commandbutton within pfc_cst_u_security_roles_painter_contrac
boolean visible = false
integer x = 14
integer y = 16
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;//Close( iw_win )

end event

type cb_ok from commandbutton within pfc_cst_u_security_roles_painter_contrac
integer x = 2386
integer y = 8
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;gnv_appeondb.of_startqueue( )
dw_1.Update()
dw_2.Update()
dw_3.Update()
dw_4.Update()
gnv_appeondb.of_commitqueue( )

end event

type cb_copy from commandbutton within pfc_cst_u_security_roles_painter_contrac
integer x = 2039
integer y = 8
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy"
end type

event clicked;long ll_role_id_old,ll_role_id_new,i,ll_rowcount_old,ll_rowcount_new
long ll_category,ll_types,ll_find
string ls_rights,ls_find
Datastore lds_contract_management_rights_old
Datastore lds_contract_management_rights_new

If dw_1.rowcount() <= 0 Then Return
cb_ok.Triggerevent( Clicked!)

ll_role_id_old = dw_1.getitemnumber(1,'role_id')

Open( w_copy_contract_management_rights )

ll_role_id_new = Message.doubleparm

If ll_role_id_new = 0 Or ll_role_id_old = ll_role_id_new Then
	Return
End If

This.SetRedraw( False )

lds_contract_management_rights_old = Create datastore
lds_contract_management_rights_old.dataobject = 'd_contract_management_rights'
lds_contract_management_rights_old.settransobject(sqlca)

lds_contract_management_rights_new = Create datastore
lds_contract_management_rights_new.dataobject = 'd_contract_management_rights'
lds_contract_management_rights_new.settransobject(sqlca)

gnv_appeondb.of_startqueue( )		
lds_contract_management_rights_old.retrieve(ll_role_id_old)
lds_contract_management_rights_new.retrieve(ll_role_id_new)
gnv_appeondb.of_commitqueue( )
ll_rowcount_old = lds_contract_management_rights_old.rowcount()
ll_rowcount_new = lds_contract_management_rights_new.rowcount()

For i = 1 To ll_rowcount_old
	ll_category = lds_contract_management_rights_old.getitemnumber(i,'category')
	ll_types = lds_contract_management_rights_old.getitemnumber(i,'types')
	ls_rights = lds_contract_management_rights_old.getitemstring(i,'rights')
	ls_find = "category = " + string(ll_category) + " And types = " + string(ll_types)
	ll_find = lds_contract_management_rights_new.find(ls_find,1,ll_rowcount_new)
	If ll_find > 0 Then
		lds_contract_management_rights_new.setitem(ll_find,'rights',ls_rights)
	End If
Next

If lds_contract_management_rights_new.Update() = -1 Then
	//MessageBox( "Update Error", "Update to Contract Management Rights table failed!" )
	MessageBox( "Update Error", "Failed to update Contract Management Rights table!" )
End If

This.SetRedraw( True )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_contract_management_rights_old) then Destroy lds_contract_management_rights_old
if IsValid(lds_contract_management_rights_new) then Destroy lds_contract_management_rights_new
//---------------------------- APPEON END ----------------------------
end event

type gb_2 from groupbox within pfc_cst_u_security_roles_painter_contrac
integer x = 1403
integer y = 100
integer width = 1321
integer height = 760
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Clauses"
end type

type gb_3 from groupbox within pfc_cst_u_security_roles_painter_contrac
integer x = 27
integer y = 880
integer width = 1335
integer height = 760
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Templates"
end type

type gb_4 from groupbox within pfc_cst_u_security_roles_painter_contrac
integer x = 1403
integer y = 880
integer width = 1321
integer height = 760
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Documents"
end type

type gb_1 from groupbox within pfc_cst_u_security_roles_painter_contrac
integer x = 27
integer y = 100
integer width = 1335
integer height = 760
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Contract Management/Tracking"
end type

