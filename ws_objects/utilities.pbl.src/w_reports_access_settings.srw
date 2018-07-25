$PBExportHeader$w_reports_access_settings.srw
forward
global type w_reports_access_settings from window
end type
type cb_select_users from commandbutton within w_reports_access_settings
end type
type cb_select_roles from commandbutton within w_reports_access_settings
end type
type dw_reports_access from datawindow within w_reports_access_settings
end type
type st_2 from statictext within w_reports_access_settings
end type
type st_1 from statictext within w_reports_access_settings
end type
type cb_cancel from commandbutton within w_reports_access_settings
end type
type cb_ok from commandbutton within w_reports_access_settings
end type
type dw_users from datawindow within w_reports_access_settings
end type
type dw_roles from datawindow within w_reports_access_settings
end type
type gb_2 from groupbox within w_reports_access_settings
end type
type gb_3 from groupbox within w_reports_access_settings
end type
type gb_1 from groupbox within w_reports_access_settings
end type
type gb_4 from groupbox within w_reports_access_settings
end type
end forward

global type w_reports_access_settings from window
integer width = 2322
integer height = 1640
boolean titlebar = true
string title = "Reports Data Filter Settings"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_select_users cb_select_users
cb_select_roles cb_select_roles
dw_reports_access dw_reports_access
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_users dw_users
dw_roles dw_roles
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
gb_4 gb_4
end type
global w_reports_access_settings w_reports_access_settings

type variables
n_ds ids_reports_except_roles,ids_reports_except_users
end variables

forward prototypes
public function integer of_set_ui ()
end prototypes

public function integer of_set_ui ();dw_reports_access.AcceptText()

If dw_reports_access.GetItemNumber(1,'reports_use_access') = 1 Then
	//Enable
	dw_roles.Modify("access.checkbox.3D = 'YES'")
	dw_roles.Modify("access.Protect='0'")
	dw_roles.Modify("datawindow.color='"+String(RGB(255,255,255))+"'")
	dw_users.Modify("access.checkbox.3D = 'YES'")
	dw_users.Modify("access.Protect='0'")
	dw_users.Modify("datawindow.color='"+String(RGB(255,255,255))+"'")
	cb_select_roles.enabled = True
	cb_select_users.enabled = True
Else
	//Disable
	dw_roles.Modify("access.checkbox.3D = 'NO'")
	dw_roles.Modify("access.Protect='1'")
	dw_roles.Modify("datawindow.color='"+String(This.Backcolor)+"'")
	dw_users.Modify("access.checkbox.3D = 'NO'")
	dw_users.Modify("access.Protect='1'")
	dw_users.Modify("datawindow.color='"+String(This.Backcolor)+"'")	
	cb_select_roles.enabled = False
	cb_select_users.enabled = False
End If

Return 1

end function

on w_reports_access_settings.create
this.cb_select_users=create cb_select_users
this.cb_select_roles=create cb_select_roles
this.dw_reports_access=create dw_reports_access
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_users=create dw_users
this.dw_roles=create dw_roles
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_4=create gb_4
this.Control[]={this.cb_select_users,&
this.cb_select_roles,&
this.dw_reports_access,&
this.st_2,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_users,&
this.dw_roles,&
this.gb_2,&
this.gb_3,&
this.gb_1,&
this.gb_4}
end on

on w_reports_access_settings.destroy
destroy(this.cb_select_users)
destroy(this.cb_select_roles)
destroy(this.dw_reports_access)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_users)
destroy(this.dw_roles)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_4)
end on

event open;ids_reports_except_users = Create n_ds
ids_reports_except_roles = Create n_ds

ids_reports_except_users.DataObject = 'd_reports_except_users'
ids_reports_except_roles.DataObject = 'd_reports_except_roles'

ids_reports_except_users.SetTransObject(SQLCA)
ids_reports_except_roles.SetTransObject(SQLCA)
dw_reports_access.SetTransObject(SQLCA)
dw_roles.SetTransObject(SQLCA)
dw_users.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ids_reports_except_users.Retrieve()
	ids_reports_except_roles.Retrieve()
	dw_reports_access.Retrieve()
	dw_roles.Retrieve()
	dw_users.Retrieve()
gnv_appeondb.of_commitqueue( )

Post of_set_ui()

end event

type cb_select_users from commandbutton within w_reports_access_settings
integer x = 1161
integer y = 1260
integer width = 389
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;Long i
If This.Text = 'Select All' Then
	For i = 1 To dw_users.RowCount()
		dw_users.SetItem(i,'Access',1)
	Next
	This.Text = 'Deselect All'
Else
	For i = 1 To dw_users.RowCount()
		dw_users.SetItem(i,'Access',0)
	Next	
	This.Text = 'Select All'
End If

end event

type cb_select_roles from commandbutton within w_reports_access_settings
integer x = 87
integer y = 1260
integer width = 389
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;Long i
If This.Text = 'Select All' Then
	For i = 1 To dw_roles.RowCount()
		dw_roles.SetItem(i,'Access',1)
	Next
	This.Text = 'Deselect All'
Else
	For i = 1 To dw_roles.RowCount()
		dw_roles.SetItem(i,'Access',0)
	Next	
	This.Text = 'Select All'
End If

end event

type dw_reports_access from datawindow within w_reports_access_settings
integer x = 55
integer y = 100
integer width = 1083
integer height = 68
integer taborder = 20
string title = "none"
string dataobject = "d_reports_access_settings"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Post of_set_ui()
end event

type st_2 from statictext within w_reports_access_settings
integer x = 146
integer y = 240
integer width = 1376
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "contracts which the login user has permission to view. "
boolean focusrectangle = false
end type

type st_1 from statictext within w_reports_access_settings
integer x = 151
integer y = 180
integer width = 2080
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "If it is selected, the running result of Reports/Graphs and Rpt Writer only contains the "
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_reports_access_settings
integer x = 1893
integer y = 1432
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;integer li_ret
If dw_reports_access.ModifiedCount() + dw_roles.ModifiedCount() + dw_users.ModifiedCount() > 0 Then
	 li_ret = Messagebox('Save','Do you want to save the changes?',Question!,YesNoCancel!)
	If li_ret = 3 Then
		Return 
	ElseIf li_ret = 2 Then
		Close(Parent)
	Else
		cb_ok.event clicked( )
	End If
Else
	Close(Parent)	
End If


end event

type cb_ok from commandbutton within w_reports_access_settings
integer x = 1536
integer y = 1432
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_ok()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Save data.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-21 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret
Long i
Long ll_role_id,ll_row
String ls_user_id

dw_roles.AcceptText()
dw_users.AcceptText()
dw_reports_access.AcceptText()

//If No changes
If dw_roles.ModifiedCount() + dw_users.ModifiedCount() + dw_reports_access.ModifiedCount() = 0 Then
	Close(Parent)
	Return 1
End If

//Save reports settings
If dw_reports_access.update() = 1 Then
	Commit;
Else
	Rollback;
	Messagebox('Save Error -1','Failed to save data, please call support.~r~n' + sqlca.sqlerrtext)	
	Return -1
End If

//For roles
If dw_roles.modifiedcount( ) > 0 Then
	For i = 1 To dw_roles.RowCount()
		If dw_roles.GetItemStatus(i,'access',primary!) = DataModified! &
			And dw_roles.GetItemNumber(i,'access',primary!,True) <> dw_roles.GetItemNumber(i,'access',primary!,False) Then
				ll_role_id = dw_roles.GetItemNumber(i,'role_id')
				If dw_roles.GetItemNumber(i,'access') = 1 Then
					//Insert					
					ll_row = ids_reports_except_roles.InsertRow(0)
					ids_reports_except_roles.SetItem(ll_row,'roles_id',ll_role_id)
				Else
					//Delete
					ll_row = ids_reports_except_roles.Find('roles_id = ' + String(ll_role_id),1,ids_reports_except_roles.rowcount())
					If ll_row > 0 Then ids_reports_except_roles.DeleteRow(ll_row)
				End If
		End If
	Next
End If

//For users
If dw_users.modifiedcount( ) > 0 Then
	For i = 1 To dw_users.RowCount()
		If dw_users.GetItemStatus(i,'access',primary!) = DataModified! &
			And dw_users.GetItemNumber(i,'access',primary!,True) <> dw_users.GetItemNumber(i,'access',primary!,False) Then
				ls_user_id = dw_users.GetItemString(i,'user_id')
				If dw_users.GetItemNumber(i,'access') = 1 Then
					//Insert					
					ll_row = ids_reports_except_users.InsertRow(0)
					ids_reports_except_users.SetItem(ll_row,'user_id',ls_user_id)
				Else
					//Delete
					ll_row = ids_reports_except_users.Find('user_id = "' + ls_user_id + '"',1,ids_reports_except_users.rowcount())
					If ll_row > 0 Then ids_reports_except_users.DeleteRow(ll_row)
				End If
		End If
	Next
End If

//Save roles and users
If ids_reports_except_roles.Modifiedcount( ) + ids_reports_except_roles.Deletedcount( )+ &
	ids_reports_except_users.ModifiedCount() + ids_reports_except_users.DeletedCount() > 0 Then
	li_ret = gnv_appeondb.of_update(ids_reports_except_roles ,ids_reports_except_users) 
	If li_ret < 0 Then
		Messagebox('Save Error -2','Failed to save data, please call support.~r~n' + sqlca.sqlerrtext)	
		Return -2
	End If
End If

//Refresh data
If Isvalid(w_report) Then
	w_report.of_get_filter_status() 
End If
If Isvalid(w_custom_report) Then
	w_custom_report.of_get_filter_status() 
End If	

Close(Parent)

end event

type dw_users from datawindow within w_reports_access_settings
integer x = 1193
integer y = 480
integer width = 942
integer height = 728
integer taborder = 20
string dataobject = "d_select_users"
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_roles from datawindow within w_reports_access_settings
integer x = 123
integer y = 480
integer width = 942
integer height = 728
integer taborder = 20
string title = "none"
string dataobject = "d_select_roles"
boolean vscrollbar = true
boolean livescroll = true
end type

type gb_2 from groupbox within w_reports_access_settings
integer x = 1161
integer y = 412
integer width = 1010
integer height = 828
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Users"
end type

type gb_3 from groupbox within w_reports_access_settings
integer x = 91
integer y = 412
integer width = 1010
integer height = 828
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Roles"
end type

type gb_1 from groupbox within w_reports_access_settings
integer x = 32
integer y = 336
integer width = 2213
integer height = 1056
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Exception"
end type

type gb_4 from groupbox within w_reports_access_settings
integer x = 32
integer y = 44
integer width = 2213
integer height = 280
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Settings"
end type

