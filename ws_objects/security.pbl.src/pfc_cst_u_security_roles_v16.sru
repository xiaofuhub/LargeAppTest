$PBExportHeader$pfc_cst_u_security_roles_v16.sru
forward
global type pfc_cst_u_security_roles_v16 from userobject
end type
type cb_save from commandbutton within pfc_cst_u_security_roles_v16
end type
type dw_example from datawindow within pfc_cst_u_security_roles_v16
end type
type cb_coll from commandbutton within pfc_cst_u_security_roles_v16
end type
type cb_exp from commandbutton within pfc_cst_u_security_roles_v16
end type
type dw_select_role from u_dw within pfc_cst_u_security_roles_v16
end type
type st_1 from statictext within pfc_cst_u_security_roles_v16
end type
type dw_1 from u_dw within pfc_cst_u_security_roles_v16
end type
end forward

global type pfc_cst_u_security_roles_v16 from userobject
integer width = 1659
integer height = 2200
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_save cb_save
dw_example dw_example
cb_coll cb_coll
cb_exp cb_exp
dw_select_role dw_select_role
st_1 st_1
dw_1 dw_1
end type
global pfc_cst_u_security_roles_v16 pfc_cst_u_security_roles_v16

type variables
integer ii_role
end variables

on pfc_cst_u_security_roles_v16.create
this.cb_save=create cb_save
this.dw_example=create dw_example
this.cb_coll=create cb_coll
this.cb_exp=create cb_exp
this.dw_select_role=create dw_select_role
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_save,&
this.dw_example,&
this.cb_coll,&
this.cb_exp,&
this.dw_select_role,&
this.st_1,&
this.dw_1}
end on

on pfc_cst_u_security_roles_v16.destroy
destroy(this.cb_save)
destroy(this.dw_example)
destroy(this.cb_coll)
destroy(this.cb_exp)
destroy(this.dw_select_role)
destroy(this.st_1)
destroy(this.dw_1)
end on

type cb_save from commandbutton within pfc_cst_u_security_roles_v16
integer x = 1317
integer y = 268
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type dw_example from datawindow within pfc_cst_u_security_roles_v16
integer x = 14
integer y = 172
integer width = 1627
integer height = 88
integer taborder = 20
boolean enabled = false
string title = "none"
string dataobject = "d_role_setting_example"
boolean livescroll = true
end type

event constructor;this.insertrow(1)
end event

type cb_coll from commandbutton within pfc_cst_u_security_roles_v16
integer x = 338
integer y = 268
integer width = 325
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Collapse All"
end type

event clicked;dw_1.collapseall()
end event

type cb_exp from commandbutton within pfc_cst_u_security_roles_v16
integer x = 9
integer y = 268
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expand All"
end type

event clicked;dw_1.expandall()
end event

type dw_select_role from u_dw within pfc_cst_u_security_roles_v16
integer x = 5
integer y = 64
integer width = 1143
integer height = 92
integer taborder = 10
string dataobject = "d_security_select_roles"
boolean vscrollbar = false
boolean border = false
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
dw_select_role.of_SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------

This.Retrieve()
This.InsertRow( 0 )

This.of_SetUpdateable( False )
end event

event itemchanged;call super::itemchanged;This.AcceptText()

ii_role = Integer(data)

dw_1.retrieve(ii_role)


end event

type st_1 from statictext within pfc_cst_u_security_roles_v16
integer x = 32
integer y = 8
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Role"
boolean focusrectangle = false
end type

type dw_1 from u_dw within pfc_cst_u_security_roles_v16
integer x = 18
integer y = 372
integer width = 1623
integer height = 1812
integer taborder = 10
string dataobject = "d_role_treeview"
end type

event itemchanged;call super::itemchanged;This.SetItem( row, "value_id", Integer( data ) )
end event

event clicked;call super::clicked;
//dw_1.ExpandAllChildren(row,1)

string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)
//of_set_tree_level(lstr_band.band)   //Start Code Change ----08.18.2015 #V15 maha - for report filtering
if lstr_band.band = 'tree.level.1' then 
	if not this.isexpanded(lstr_band.row, 1)  then this.expand( lstr_band.row, 1)
end if
	
end event

