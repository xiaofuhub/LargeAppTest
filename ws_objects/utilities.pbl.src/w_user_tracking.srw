$PBExportHeader$w_user_tracking.srw
forward
global type w_user_tracking from w_main
end type
type cb_refresh from commandbutton within w_user_tracking
end type
type st_licensekey from statictext within w_user_tracking
end type
type cb_ok from commandbutton within w_user_tracking
end type
type tab_1 from tab within w_user_tracking
end type
type tabpage_1 from userobject within tab_1
end type
type dw_onlineuser from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_onlineuser dw_onlineuser
end type
type tabpage_2 from userobject within tab_1
end type
type dw_filter from u_dw within tabpage_2
end type
type dw_log_tracking from u_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_filter dw_filter
dw_log_tracking dw_log_tracking
end type
type tabpage_3 from userobject within tab_1
end type
type dw_upgrade from u_dw within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_upgrade dw_upgrade
end type
type tab_1 from tab within w_user_tracking
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_user_tracking from w_main
integer width = 3017
integer height = 2040
string title = "User Tracking"
boolean maxbox = false
long backcolor = 33551856
cb_refresh cb_refresh
st_licensekey st_licensekey
cb_ok cb_ok
tab_1 tab_1
end type
global w_user_tracking w_user_tracking

type variables
String is_sql_org 
end variables

on w_user_tracking.create
int iCurrent
call super::create
this.cb_refresh=create cb_refresh
this.st_licensekey=create st_licensekey
this.cb_ok=create cb_ok
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_refresh
this.Control[iCurrent+2]=this.st_licensekey
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.tab_1
end on

on w_user_tracking.destroy
call super::destroy
destroy(this.cb_refresh)
destroy(this.st_licensekey)
destroy(this.cb_ok)
destroy(this.tab_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_user_tracking::open()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-01 by Ken.Guo
//////////////////////////////////////////////////////////////////////


st_licensekey.text = 'License Key: ' + String(gnv_session.is_license_key,'@@@ @@@@ @@@@@@@ @@@@@@@@')
end event

type cb_refresh from commandbutton within w_user_tracking
integer x = 2199
integer y = 1816
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;If tab_1.selectedtab = 1 Then
	tab_1.tabpage_1.dw_onlineuser.event pfc_retrieve( )
ElseIf tab_1.selectedtab = 2 Then
	tab_1.tabpage_2.dw_log_tracking.event pfc_retrieve( )
ElseIf tab_1.selectedtab = 3 Then
	tab_1.tabpage_3.dw_upgrade.event pfc_retrieve()
End If
end event

type st_licensekey from statictext within w_user_tracking
integer x = 69
integer y = 1816
integer width = 1134
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_user_tracking
integer x = 2565
integer y = 1816
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_user_tracking
integer x = 32
integer y = 20
integer width = 2912
integer height = 1764
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2875
integer height = 1648
long backcolor = 33551856
string text = "Online Users"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_onlineuser dw_onlineuser
end type

on tabpage_1.create
this.dw_onlineuser=create dw_onlineuser
this.Control[]={this.dw_onlineuser}
end on

on tabpage_1.destroy
destroy(this.dw_onlineuser)
end on

type dw_onlineuser from u_dw within tabpage_1
integer y = 12
integer width = 2871
integer height = 1632
integer taborder = 20
string dataobject = "d_user_tracking"
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.SetTransObject(SQLCA)
This.Post Event pfc_Retrieve()

end event

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)
Return This.Retrieve()

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2875
integer height = 1648
long backcolor = 33551856
string text = "Users Login log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_filter dw_filter
dw_log_tracking dw_log_tracking
end type

on tabpage_2.create
this.dw_filter=create dw_filter
this.dw_log_tracking=create dw_log_tracking
this.Control[]={this.dw_filter,&
this.dw_log_tracking}
end on

on tabpage_2.destroy
destroy(this.dw_filter)
destroy(this.dw_log_tracking)
end on

type dw_filter from u_dw within tabpage_2
integer y = 12
integer width = 2871
integer height = 216
integer taborder = 11
string dataobject = "d_user_tracking_filter"
end type

event constructor;call super::constructor;DatawindowChild ldwc_users,ldwc_action
This.of_setdropdowncalendar(True)
This.of_setupdateable(False)

This.Insertrow(0)
If This.Getchild('user_id',ldwc_users) = 1 Then
	ldwc_users.SetTransObject(SQLCA)
End If

If This.Getchild('log_action',ldwc_action) = 1 Then
	ldwc_action.SetTransObject(SQLCA)
End If

gnv_appeondb.of_startqueue( )
	ldwc_users.Retrieve()
	ldwc_action.Retrieve()
gnv_appeondb.of_commitqueue( )

This.SetItem(1,'user_id',gs_user_id)

end event

event buttonclicked;call super::buttonclicked;Choose Case dwo.name 
Case 'b_filter' 
	dw_log_tracking.Event pfc_retrieve()
Case 'b_clear'
	This.Reset()
	This.InsertRow(0)
End Choose
end event

type dw_log_tracking from u_dw within tabpage_2
integer y = 244
integer width = 2871
integer height = 1396
integer taborder = 11
string dataobject = "d_user_log_tracking"
end type

event constructor;call super::constructor;This.of_setupdateable(False)
//This.of_setrowmanager(True)
This.of_setrowselect(True)
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)
//This.inv_sort.of_SetColumnnameSource(This.inv_sort.HEADER)

This.SetTransObject(SQLCA)

is_sql_org = This.GetSQLSelect()

This.Post Event pfc_Retrieve()



end event

event pfc_retrieve;call super::pfc_retrieve;//////////////////////////////////////////////////////////////////////
// $<event>pfc_retrievedw_log_tracking()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Retrieve data by filter condition.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-01 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_user_id
String ls_action
Datetime ldt_start,ldt_end
String ls_sql

SetPointer(HourGlass!)

dw_filter.AcceptText()

ls_sql = is_sql_org + ' Where 1 = 1 '

ls_user_id = dw_filter.GetItemString(1,'user_id')
ls_action = dw_filter.GetItemString(1,'log_action')
ldt_start = dw_filter.GetItemDateTime(1,'date_start')
ldt_end = dw_filter.GetItemDateTime(1,'date_end')

If Not isnull(ls_user_id)  and ls_user_id <> '' Then
	ls_sql += " And user_id = '" + ls_user_id + "'"
End If

If Not isnull(ls_action)  and ls_action <> '' Then
	ls_sql += " And pass_fail = '" + ls_action + "'"
End If

If Not isnull(ldt_start) Then
	ls_sql += " And log_date >= Convert(Datetime,'"  + String(ldt_start,'yyyy-mm-dd') + " 00:00:00')"
End If

If Not isnull(ldt_end) Then
	ls_sql += " And log_date <= Convert(Datetime,'"  + String(ldt_end,'yyyy-mm-dd') + " 23:59:59')"
End If

ls_sql += ' ORDER BY security_login_tracking.log_date DESC   '

This.SetSQLselect(ls_sql)
This.SetTransobject(SQLCA)
This.Retrieve()

SetPointer(Arrow!)


Return 1


end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2875
integer height = 1648
long backcolor = 33551856
string text = "Upgrade log"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_upgrade dw_upgrade
end type

on tabpage_3.create
this.dw_upgrade=create dw_upgrade
this.Control[]={this.dw_upgrade}
end on

on tabpage_3.destroy
destroy(this.dw_upgrade)
end on

type dw_upgrade from u_dw within tabpage_3
integer y = 12
integer width = 2871
integer height = 1632
integer taborder = 10
string dataobject = "d_upgrade_log"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)
This.SetTransObject(SQLCA)
This.Post Event pfc_Retrieve()


end event

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)
Return This.Retrieve()

end event

