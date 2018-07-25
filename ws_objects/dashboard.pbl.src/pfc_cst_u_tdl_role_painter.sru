$PBExportHeader$pfc_cst_u_tdl_role_painter.sru
$PBExportComments$Add To Do List Role Settings
forward
global type pfc_cst_u_tdl_role_painter from userobject
end type
type dw_missing from datawindow within pfc_cst_u_tdl_role_painter
end type
type cb_1 from commandbutton within pfc_cst_u_tdl_role_painter
end type
type dw_select_user from u_dw within pfc_cst_u_tdl_role_painter
end type
type st_1 from statictext within pfc_cst_u_tdl_role_painter
end type
type cb_close from commandbutton within pfc_cst_u_tdl_role_painter
end type
type cb_save from commandbutton within pfc_cst_u_tdl_role_painter
end type
type dw_tdl_role from u_dw within pfc_cst_u_tdl_role_painter
end type
type gb_2 from groupbox within pfc_cst_u_tdl_role_painter
end type
type gb_3 from groupbox within pfc_cst_u_tdl_role_painter
end type
type dw_user_role from u_dw within pfc_cst_u_tdl_role_painter
end type
end forward

global type pfc_cst_u_tdl_role_painter from userobject
integer width = 2985
integer height = 1700
long backcolor = 33551856
string text = "To Do List Roles"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
string powertiptext = "To Do List Roles"
dw_missing dw_missing
cb_1 cb_1
dw_select_user dw_select_user
st_1 st_1
cb_close cb_close
cb_save cb_save
dw_tdl_role dw_tdl_role
gb_2 gb_2
gb_3 gb_3
dw_user_role dw_user_role
end type
global pfc_cst_u_tdl_role_painter pfc_cst_u_tdl_role_painter

type variables
Long il_Role_id	//Role ID
String is_user_id	//User ID

w_security_roles_painter  iw_win
end variables

forward prototypes
public function integer of_set_parent_window (window aw_win)
public function integer of_refresh (long al_role_id)
end prototypes

public function integer of_set_parent_window (window aw_win);iw_win = aw_win

RETURN 1
end function

public function integer of_refresh (long al_role_id);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-05 By: Allen
//$<reason> Select Role
IF il_Role_id = al_Role_id THEN RETURN -1
datawindowchild dwc_child

IF il_Role_id = 0 THEN
	String ls_Sql, ls_Null
	dw_user_role.GetChild("tdl_other_user", dwc_child)
	ls_Sql = dwc_child.GetSqlSelect()
	ls_Sql = LeftA(ls_Sql, PosA(ls_Sql, "WHERE") - 1)
	ls_Null = dwc_child.Modify("DataWindow.Table.Select = '" + ls_Sql + "'")
	if LenA(ls_Null) > 0 then messagebox('',ls_Null)
	
	dwc_child.SetTransObject(Sqlca)
	dwc_child.Retrieve(-1)
	
	SetNull(ls_Null)
	dwc_child.InsertRow(1)
	dwc_child.SetItem(1, "User_id", ls_Null)
	dwc_child.SetItem(1, "User_Name", "(None)")
	dwc_child.SetItem(1, "role_id", 0)
END IF

dw_tdl_role.AcceptText()
dw_select_user.ReSet()

gnv_appeondb.of_StartQueue()
IF dw_tdl_role.ModifiedCount() > 0 THEN
	dw_tdl_role.Update()
	Commit;
END IF
dw_tdl_role.Retrieve(al_Role_id)
dw_select_user.Retrieve(al_Role_id)
gnv_appeondb.of_CommitQueue()

//Filter the Selected Module
n_cst_tdl_function ln_cst_tdl_function
ln_cst_tdl_function.of_filter_module(dw_tdl_role)

//Set Other User None and Filter Current User
dw_user_role.GetChild("tdl_other_user", dwc_child)
dwc_child.SetFilter("role_id <> " + String(al_Role_id))
dwc_child.Filter()
dwc_child.SetSort("Role_id, User_id")
dwc_child.Sort()

il_Role_id = al_Role_id
//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Long 			ll_row
//Begin - Added By Mark Lee 11/12/2012
If dw_select_user.rowcount( ) > 0 then 
	ll_row = dw_select_user.find( "User_id = '"+String(gs_user_id)+"' ",1,dw_select_user.rowcount( ))
	If ll_row > 0 Then
		dw_select_user.selectrow( 0,false)
		dw_select_user.selectrow( ll_row,true)
		dw_select_user.scrolltorow( ll_row)
	End If
End If	
//---------End Added ------------------------------------------------------

Return 0
//---------------------------- APPEON END ----------------------------
end function

on pfc_cst_u_tdl_role_painter.create
this.dw_missing=create dw_missing
this.cb_1=create cb_1
this.dw_select_user=create dw_select_user
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_tdl_role=create dw_tdl_role
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_user_role=create dw_user_role
this.Control[]={this.dw_missing,&
this.cb_1,&
this.dw_select_user,&
this.st_1,&
this.cb_close,&
this.cb_save,&
this.dw_tdl_role,&
this.gb_2,&
this.gb_3,&
this.dw_user_role}
end on

on pfc_cst_u_tdl_role_painter.destroy
destroy(this.dw_missing)
destroy(this.cb_1)
destroy(this.dw_select_user)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_tdl_role)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_user_role)
end on

type dw_missing from datawindow within pfc_cst_u_tdl_role_painter
boolean visible = false
integer x = 55
integer y = 1596
integer width = 128
integer height = 64
integer taborder = 80
string title = "none"
string dataobject = "d_tdl_basic_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within pfc_cst_u_tdl_role_painter
integer x = 850
integer y = 20
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find Missing"
end type

event clicked;//Start Code Change ----09.16.2014 #V14.2 maha
integer r
integer rc
integer nr
long ll_tdlid
string s  //maha
integer e


rc = dw_tdl_role.Retrieve(il_Role_id)
dw_missing.settransobject(sqlca)
dw_missing.retrieve()

if gb_contract_version then 
	s = "module = '03' or module = '04'"
else
	s = "module = '01' or module = '02' or module = '06'"
	
	if of_get_app_setting("set_automation","I") <> 0 then 	s+= " or module = '07'"

	if of_get_app_setting("set_recruit","I") = 1 then s+= " or module = '08'"

	if of_get_app_setting("set_web","I") = 1 then  s+= " or module = '09'"
end if

e = dw_missing.setfilter(s)
if e < 0 then messagebox("","Filter failed")
dw_missing.filter()
rc = dw_missing.rowcount()

for r = 1 to rc
	ll_tdlid = dw_missing.getitemnumber(r,"tdl_id")
	nr = dw_tdl_role.find("tdl_id = " + string(ll_tdlid), 1, dw_tdl_role.rowcount() )
	if nr = 0 then
		nr = dw_tdl_role.insertrow(0)
		dw_tdl_role.setitem(nr, "role_id", il_role_id)
		dw_tdl_role.setitem(nr, "tdl_id", ll_tdlid)
		dw_tdl_role.setitem(nr, "access_rights", 0)
	end if
next


//dw_tdl_role.update()
of_refresh( il_role_id)


end event

type dw_select_user from u_dw within pfc_cst_u_tdl_role_painter
integer x = 1257
integer y = 180
integer width = 1490
integer height = 1080
integer taborder = 30
string dataobject = "d_tdl_role_user"
boolean ib_isupdateable = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )
end event

event rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-04 By: Allen
//$<reason> Select User
IF CurrentRow < 1 THEN RETURN

String ls_Null
DatawindowChild dwc_child
dw_user_role.SetTransobject(SQLCA)//(Appeon)Eugene 06.04.2013 - V141 ISG-CLX

Is_user_id = this.GetItemString(CurrentRow, "User_id")
SetNull(ls_Null)

gnv_appeondb.of_StartQueue()
IF dw_user_role.ModifiedCount() > 0 THEN
	dw_user_role.Update()
	COMMIT;
END IF
//dw_user_role.retrieve(Is_user_id)
if Not IsNull(Is_user_id) then		//(Appeon)Eugene 06.04.2013 - V141 ISG-CLX
	dw_user_role.Retrieve(Is_user_id)
End If
gnv_appeondb.of_CommitQueue()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack
//$<reason> Fix a defect.
string ls_text
ls_text = "gb_1.text = 'Rights Settings for "  + Is_user_id + "'"
dw_user_role.modify(ls_text)
//---------------------------- APPEON END ----------------------------

SelectRow(0, False)
SelectRow(CurrentRow, True)
//---------------------------- APPEON END ----------------------------
end event

event retrieveend;call super::retrieveend;//---------Begin Added by (Appeon)Eugene 06.04.2013 for V141 ISG-CLX--------
if RowCount > 0 then
	dw_user_role.Enabled = true
	dw_user_role.Modify("tdl_rights.RadioButtons.3D='Yes'")
else
	dw_user_role.Enabled = false
	dw_user_role.Modify("tdl_rights.RadioButtons.3D='No'")
	dw_user_role.Modify("gb_1.Text = 'Rights Settings'")
end if

//---------End Added ------------------------------------------------------
end event

type st_1 from statictext within pfc_cst_u_tdl_role_painter
integer x = 50
integer y = 28
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To Do List"
boolean focusrectangle = false
end type

type cb_close from commandbutton within pfc_cst_u_tdl_role_painter
boolean visible = false
integer x = 9
integer y = 1400
integer width = 338
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-04 By: Allen
//$<reason> Close window
Close( iw_win )
//---------------------------- APPEON END ----------------------------
end event

type cb_save from commandbutton within pfc_cst_u_tdl_role_painter
integer x = 2464
integer y = 20
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-04 By: Allen
//$<reason> Save data
Integer li_retval

li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF
//---------------------------- APPEON END ----------------------------
end event

type dw_tdl_role from u_dw within pfc_cst_u_tdl_role_painter
integer x = 69
integer y = 184
integer width = 1065
integer height = 1348
integer taborder = 20
string dataobject = "d_dashboard_security_role"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-05 By: Allen
//$<reason> Select Row
IF Lower(dwo.Name) = 'tdl_id' THEN
	IF GetItemNumber(Row, 'access_rights') = 0 THEN
		SetItem(Row, 'access_rights', 1)
	ELSE
		SetItem(Row, 'access_rights', 0)
	END IF
END IF
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2007 By: Jack (Document Manager)
//$<reason> Fix a defect.
dw_tdl_role.of_SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------

end event

type gb_2 from groupbox within pfc_cst_u_tdl_role_painter
integer x = 14
integer y = 104
integer width = 1184
integer height = 1460
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "To Do List Category"
end type

type gb_3 from groupbox within pfc_cst_u_tdl_role_painter
integer x = 1230
integer y = 104
integer width = 1577
integer height = 1460
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "User To Do Rights"
end type

type dw_user_role from u_dw within pfc_cst_u_tdl_role_painter
integer x = 1248
integer y = 1256
integer width = 1504
integer height = 300
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_dashboard_user_access"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-12 By: Allen
//$<reason> 
IF Lower(dwo.Name) = "tdl_rights" THEN
	IF data <> "1" THEN
		String ls_Null
		SetNull(ls_Null)
		SetItem(row, "tdl_other_user", ls_Null)
	END IF
END IF
//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2007 By: Jack (Document Manager)
//$<reason> Fix a defect.
dw_user_role.of_SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------

end event

