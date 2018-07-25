$PBExportHeader$u_saml_user_mapping.sru
forward
global type u_saml_user_mapping from userobject
end type
type cb_hlp from commandbutton within u_saml_user_mapping
end type
type cbx_samlhttps from checkbox within u_saml_user_mapping
end type
type cbx_onlysamluser from checkbox within u_saml_user_mapping
end type
type cbx_usesaml from checkbox within u_saml_user_mapping
end type
type cb_close from commandbutton within u_saml_user_mapping
end type
type cb_refresh from commandbutton within u_saml_user_mapping
end type
type cb_save from commandbutton within u_saml_user_mapping
end type
type cb_del from commandbutton within u_saml_user_mapping
end type
type cb_add from commandbutton within u_saml_user_mapping
end type
type cb_import from commandbutton within u_saml_user_mapping
end type
type dw_browse from datawindow within u_saml_user_mapping
end type
type tv_user from treeview within u_saml_user_mapping
end type
type dw_detail from datawindow within u_saml_user_mapping
end type
end forward

global type u_saml_user_mapping from userobject
integer width = 3954
integer height = 1656
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_hlp cb_hlp
cbx_samlhttps cbx_samlhttps
cbx_onlysamluser cbx_onlysamluser
cbx_usesaml cbx_usesaml
cb_close cb_close
cb_refresh cb_refresh
cb_save cb_save
cb_del cb_del
cb_add cb_add
cb_import cb_import
dw_browse dw_browse
tv_user tv_user
dw_detail dw_detail
end type
global u_saml_user_mapping u_saml_user_mapping

type variables
string is_Type
string is_UserID
string is_ErrInfo
DataStore ids_User
TreeViewItem itvi_User
boolean ib_DoFilter = true

n_cst_encrypt in_Encrypt

n_cst_string inv_string

window iw_parent
end variables

forward prototypes
public function integer of_createusertree (string as_userid)
public function integer of_filter (string as_userid)
public function integer of_findusertreeitem (string as_userid)
public subroutine ue_refresh_dddw ()
end prototypes

public function integer of_createusertree (string as_userid);long i, ll_Root
TreeViewItem ltvi_Item

// Get user information
ids_User = Create DataStore
ids_User.DataObject = "d_email_users"
ids_User.SetTransObject(SQLCA)
ids_User.Retrieve()
if Len(as_UserID) > 0 then
	ids_User.SetFilter("user_id = '" + as_UserID + "'")
	ids_User.Filter()
end if

tv_user.DeleteItem(0)
// Get user tree from Ds
ltvi_Item.Label = "User"
ltvi_Item.Data = ""
ltvi_Item.PictureIndex = 1
ltvi_Item.SelectedPictureIndex = 1

ll_Root = tv_user.InsertItemLast(0, ltvi_Item)

for i = 1 to ids_User.RowCount()
	ltvi_Item.Label = ids_User.GetItemString(i, "user_id")
	ltvi_Item.Data = ltvi_Item.Label
	ltvi_Item.PictureIndex = 2
	ltvi_Item.SelectedPictureIndex = 3
	tv_user.InsertItemLast(ll_Root, ltvi_Item)
next
tv_user.ExpandAll(ll_Root)

Return 1
end function

public function integer of_filter (string as_userid);if Len(as_UserID) > 0 then
	dw_browse.SetFilter("map_user_id = '" + as_UserID + "'")
else
	dw_browse.SetFilter("")
end if

dw_browse.Filter()
dw_browse.SetRow(1)
dw_browse.Event RowFocusChanged(1)

Return 1
end function

public function integer of_findusertreeitem (string as_userid);long ll_Handle
TreeViewItem ltvi_User

ll_Handle = tv_user.FindItem(RootTreeItem!, 0)
ll_Handle = tv_user.FindItem(ChildTreeItem!, ll_Handle)
tv_user.GetItem(ll_Handle, ltvi_User)
if String(ltvi_User.Data) = as_UserID then		
	Return ll_Handle
end if

do while ll_Handle > 0
	ll_Handle = tv_user.FindItem(NextTreeItem!, ll_Handle)
	tv_user.GetItem(ll_Handle, ltvi_User)
	if String(ltvi_User.Data) = as_UserID then		
		Return ll_Handle
	end if
loop

Return -1
end function

public subroutine ue_refresh_dddw ();DatawindowChild ldwc_name

dw_browse.GetChild('idp_server_id', ldwc_name)
ldwc_name.SettransObject(SQLCA)
ldwc_name.Retrieve()

end subroutine

on u_saml_user_mapping.create
this.cb_hlp=create cb_hlp
this.cbx_samlhttps=create cbx_samlhttps
this.cbx_onlysamluser=create cbx_onlysamluser
this.cbx_usesaml=create cbx_usesaml
this.cb_close=create cb_close
this.cb_refresh=create cb_refresh
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_import=create cb_import
this.dw_browse=create dw_browse
this.tv_user=create tv_user
this.dw_detail=create dw_detail
this.Control[]={this.cb_hlp,&
this.cbx_samlhttps,&
this.cbx_onlysamluser,&
this.cbx_usesaml,&
this.cb_close,&
this.cb_refresh,&
this.cb_save,&
this.cb_del,&
this.cb_add,&
this.cb_import,&
this.dw_browse,&
this.tv_user,&
this.dw_detail}
end on

on u_saml_user_mapping.destroy
destroy(this.cb_hlp)
destroy(this.cbx_samlhttps)
destroy(this.cbx_onlysamluser)
destroy(this.cbx_usesaml)
destroy(this.cb_close)
destroy(this.cb_refresh)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_import)
destroy(this.dw_browse)
destroy(this.tv_user)
destroy(this.dw_detail)
end on

event constructor;//of_CreateUserTree("")
string ls_use_saml = "0"
string ls_only_saml_user = "0"
string ls_force_https = "0"
select top 1 use_saml, only_saml_user , saml_force_https
into :ls_use_saml, :ls_only_saml_user , :ls_force_https
	from icred_settings using sqlca;
	
if ls_use_saml = "1" then
	cbx_usesaml.checked = true
	cbx_onlysamluser.enabled = true
	cbx_samlhttps.enabled = true
else
	cbx_usesaml.checked = false
	cbx_onlysamluser.enabled = false
	cbx_samlhttps.enabled =false
end if

if ls_only_saml_user = "1" then
	cbx_onlysamluser.checked = true
else
	cbx_onlysamluser.checked = false
end if

if ls_force_https = "1" then
	cbx_samlhttps.checked = true
else
	cbx_samlhttps.checked = false
end if

	
end event

type cb_hlp from commandbutton within u_saml_user_mapping
integer x = 2021
integer y = 1536
integer width = 96
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;//V15.3 SAML for WV (alfee 01.17.2017)

MessageBox("IntelliSoftGroup","The 3 options are for IntelliCred/App Web version only. For WebView, SAML Login can be set in System->Setup->WebView Settings. ")


end event

type cbx_samlhttps from checkbox within u_saml_user_mapping
integer x = 608
integer y = 1548
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Enforce HTTPS"
end type

type cbx_onlysamluser from checkbox within u_saml_user_mapping
integer x = 1184
integer y = 1548
integer width = 786
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Force User to Use SAML Only"
end type

type cbx_usesaml from checkbox within u_saml_user_mapping
integer x = 41
integer y = 1548
integer width = 466
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Enable SAML"
end type

event clicked;

if this.checked then
	cbx_onlysamluser.enabled = true
	cbx_samlhttps.enabled = true
else
	cbx_onlysamluser.enabled = false
	cbx_samlhttps.enabled = false
end if
end event

type cb_close from commandbutton within u_saml_user_mapping
integer x = 3589
integer y = 1536
integer width = 311
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;if isvalid(iw_parent) Then
	Close(iw_parent)
End If

end event

type cb_refresh from commandbutton within u_saml_user_mapping
integer x = 3259
integer y = 1536
integer width = 311
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;//Close(Parent)
long ll_Handle
parent.dw_browse.retrieve()
parent.of_CreateUserTree("")

ll_Handle = parent.of_FindUserTreeItem(is_UserID)
parent.tv_user.SelectItem(ll_Handle)
end event

type cb_save from commandbutton within u_saml_user_mapping
integer x = 2930
integer y = 1536
integer width = 311
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;boolean 	lb_AutoCommit
String	ls_UserId
long		ll_Row, ll_Count

n_ds lds_filter

string ls_usesaml = "0"
string ls_onlysamluser = "0"
string ls_saml_https = "0"
if cbx_usesaml.checked then ls_usesaml = "1"
if cbx_onlysamluser.checked then ls_onlysamluser = "1"
if cbx_samlhttps.checked then ls_saml_https = "1"


UPDATE icred_settings SET use_saml = :ls_usesaml, only_saml_user = :ls_onlysamluser , saml_force_https = :ls_saml_https ;
commit;

dw_browse.AcceptText()
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() <= 0 then Return

lds_filter = Create n_ds
lds_filter.dataobject = dw_browse.dataobject

//Added By Ken.Guo 04/21/2014. Check duplicate record.
String lidp_user_id,ls_user_id, ls_user_id_new
Long lidp_server_id,i,ll_find
lds_filter.Reset()
dw_browse.RowsCopy(1, dw_browse.FilteredCount(), Filter!, lds_filter, 1, Primary!)
For i = 1 To dw_browse.RowCount()
	lidp_user_id = dw_browse.GetItemString(i, 'idp_user_id')	
	lidp_server_id = dw_browse.GetItemNumber(i, 'idp_server_id')	
	ls_user_id = dw_browse.GetItemString(i, 'map_user_id')	
	
	If lidp_server_id = 0 Then  //*Add new server*
		setnull(lidp_server_id) 
		dw_browse.SetItem(i, 'idp_server_id',lidp_server_id )
	End If
	
	If isnull(lidp_server_id) Then
		Messagebox('Validation','The IdP Server Name cannot be empty.')
		dw_browse.ScrolltoRow(i)
		dw_browse.SetRow(i)
		dw_browse.SetFocus()
		dw_browse.SetColumn('idp_server_id')
		If isvalid(lds_filter) Then Destroy lds_filter
		Return
	End If
	
	If isnull(lidp_user_id) Then
		Messagebox('Validation','The IdP User cannot be empty.')
		dw_browse.ScrolltoRow(i)
		dw_browse.SetRow(i)
		dw_browse.SetFocus()
		dw_browse.SetColumn('idp_user_id')
		If isvalid(lds_filter) Then Destroy lds_filter		
		Return
	End If
	
	//Check current primary buffer
	If i <> dw_browse.RowCount() Then
		ll_find = dw_browse.Find('idp_user_id = "'+lidp_user_id+ '" and idp_server_id = ' + String(lidp_server_id), i+1, dw_browse.RowCount())
		If ll_find > 0 Then
			Messagebox('Validation','The existence of duplicate IdP User and Server Name with the current user, please check it.')
			dw_browse.ScrolltoRow(i)
			dw_browse.SetRow(i)
			dw_browse.SetFocus()
			dw_browse.SetColumn('idp_user_id')
			If isvalid(lds_filter) Then Destroy lds_filter			
			Return
		End If
	End If
	
	//Check Filter buffer
	ll_find = lds_filter.Find('idp_user_id = "'+lidp_user_id+ '" and idp_server_id = ' + String(lidp_server_id), 1, lds_filter.RowCount() )
	If ll_find > 0 Then
		ls_user_id_new = lds_filter.GetItemString(ll_find, 'map_user_id')
		Messagebox('Validation','The existence of duplicate IdP User and Server Name with the user "'+ls_user_id_new+'" , please check it.')
		dw_browse.ScrolltoRow(i)
		dw_browse.SetRow(i)
		dw_browse.SetFocus()
		dw_browse.SetColumn('idp_user_id')
		If isvalid(lds_filter) Then Destroy lds_filter		
		Return
	End If
Next
If isvalid(lds_filter) Then Destroy lds_filter



if dw_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", is_ErrInfo, StopSign!)
end if


end event

type cb_del from commandbutton within u_saml_user_mapping
integer x = 2601
integer y = 1536
integer width = 311
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long ll_FindRow
long ll_DefaultRow
string ls_UserID

if dw_browse.GetRow() <= 0 then Return
if MessageBox("Delete", "Are you sure you want to delete the selected record?", Question!, YesNo!) = 2 then
	Return
end if	

// Delete row
ls_UserID = dw_browse.GetItemString(dw_browse.GetRow(), "map_user_id")
dw_browse.DeleteRow(0)
dw_browse.Event RowFocusChanged(dw_browse.GetRow())


end event

type cb_add from commandbutton within u_saml_user_mapping
integer x = 2272
integer y = 1536
integer width = 311
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long ll_FindRow
long ll_InsertRow
string ls_UserID
string ls_Email


ll_InsertRow = dw_browse.InsertRow(0)

if is_Type = "ALL" then
	
	//Added By Ken.Guo 04/21/2014
	If String(itvi_User.Data) = '' and itvi_User.Label = 'User' Then
		Messagebox('Add','Please select a user first.')
		Return 
	End If
	
	if Len(String(itvi_User.Data)) > 0 then
		dw_browse.SetItem(ll_InsertRow, "map_user_id", String(itvi_User.Data))
	else
		dw_browse.SetItem(ll_InsertRow, "map_user_id", "ssotest")
	end if
else
	dw_browse.SetItem(ll_InsertRow, "map_user_id", is_UserID)
end if
ls_UserID = dw_browse.GetItemString(ll_InsertRow, "map_user_id")

dw_browse.ScrollToRow(ll_InsertRow)

end event

type cb_import from commandbutton within u_saml_user_mapping
boolean visible = false
integer x = 2162
integer y = 1536
integer width = 96
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Import User..."
end type

type dw_browse from datawindow within u_saml_user_mapping
integer x = 663
integer y = 12
integer width = 3255
integer height = 1492
integer taborder = 20
string title = "none"
string dataobject = "d_idp_users_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.SetTransObject(SQLCA)
this.Retrieve()

end event

event dberror;is_ErrInfo = SQLErrText
Return 1
end event

event retrieveend;//////////////////////////////////////////////////////////////////////
// $<event>  RetrieveEnd()
// $<arguments> long RowCount
// $<returns>   Long
// $<description> Set the decrypt password
//////////////////////////////////////////////////////////////////////
// $<add> 11/12/2008 by Scofield
//////////////////////////////////////////////////////////////////////

String		ls_Password	=space(100)
long		ll_Cycle, ll_pwd_len
integer li_val

SetPointer(HourGlass!)

//Added By Jay Chen 02-24-2014
/*
select set_45 into :li_val from icred_settings; 

for ll_Cycle = 1 to RowCount
	ls_Password = This.GetItemString(ll_Cycle,"password")
	ll_pwd_len = This.GetItemNumber(ll_Cycle,"pwd_len")
	if IsNull(ls_Password) then CONTINUE
	//Added By Mark Lee 12/30/2013
	if AppeonGetClientType() = 'WEB' then
		if ll_pwd_len - len(ls_Password) > 0  then 
			ls_Password =ls_Password + space(ll_pwd_len - len(ls_Password))
		end if 
	end if
//	ls_Password = in_encrypt.of_Decrypt(ls_Password) //Modified By Jay Chen 02-24-2014
	ls_Password = in_encrypt.of_decrypt_new(ls_Password , li_val)
	This.SetItem(ll_Cycle,"password",ls_Password)
	This.SetItemStatus(ll_Cycle,"password",Primary!,NotModified!)
next
*/
SetPointer(Arrow!)

end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
//dw_detail.ScrollToRow(CurrentRow)
end event

event updateend;//////////////////////////////////////////////////////////////////////
// $<event>  UpdateEnd()
// $<arguments> long RowsInserted, long RowsUpdated, long RowsDeleted
// $<returns>   Long
// $<description> Encrypt password then update to database
//////////////////////////////////////////////////////////////////////
// $<add> 11/12/2008 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_InputPass,ls_DBPass
long		ll_Cycle,ll_Count,ll_ID

SetPointer(HourGlass!)
/*
ll_Count = This.RowCount()
for ll_Cycle = 1 to ll_Count
	ll_ID = This.GetItemNumber(ll_Cycle,"ID")
	if IsNull(ll_ID) then CONTINUE
	
	SELECT Password INTO :ls_DBPass FROM em_smtp_accounts WHERE ID = :ll_ID ;
	
	ls_InputPass = This.GetItemString(ll_Cycle,"password")
	if IsNull(ls_InputPass) then
		if Not IsNull(ls_DBPass) then
			UPDATE em_smtp_accounts SET Password = NULL WHERE ID = :ll_ID ;
			if SQLCA.SQLCode <> 0 then Exit
		end if
	else
		ls_InputPass = in_encrypt.of_Encrypt(ls_InputPass)
		if IsNull(ls_DBPass) or ls_InputPass <> ls_DBPass then
			UPDATE em_smtp_accounts SET Password = :ls_InputPass WHERE ID = :ll_ID ;
			if SQLCA.SQLCode <> 0 then Exit
		end if
	end if
next

if SQLCA.SQLCode = 0 then
	COMMIT USING SQLCA;
else
	MessageBox(gnv_app.iapp_object.DisplayName,SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
end if
*/

SetPointer(Arrow!)

end event

event itemchanged;//Added By Ken.Guo 04/21/2014
Long ll_null
Setnull(ll_null)
Choose Case dwo.name
	Case 'idp_server_id'
		If data = '0' Then //*add new record*
			Setitem(row, 'idp_server_id', ll_null)
			iw_parent.Dynamic Event ue_do('addidpserver')
		End If
End Choose


end event

type tv_user from treeview within u_saml_user_mapping
integer x = 14
integer y = 12
integer width = 645
integer height = 1492
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
string picturename[] = {"Library!","Custom076!","Custom026!"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event selectionchanged;long i, ll_RowCount

// Get current item
dw_detail.AcceptText()
this.GetItem(NewHandle, itvi_User)

// Filter specify user accounts
if ib_DoFilter and is_Type = "ALL" then
	of_Filter(String(itvi_User.Data))
end if
end event

type dw_detail from datawindow within u_saml_user_mapping
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 663
integer y = 1456
integer width = 3255
integer height = 48
integer taborder = 30
string title = "none"
string dataobject = "d_email_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event buttonclicked;if dwo.name = "b_test" then // Add by Evan on 2008-03-24
	//cb_test.Event Clicked()
end if
end event

event itemchanged;/*
string ls_OldUserID
string ls_userid, ls_userid_dup //Alfee 08.22.2008

choose case dwo.name
	case "is_default"
		if this.object.is_default[row] = "Y" and Data = "N" then
			Return 2
		else
			of_SetDefault(Row)
		end if
		
	case "user_id"
		ls_OldUserID = this.object.user_id[row]
		Post of_ChangeUserID(Row, ls_OldUserID, Data)
		
	case "email"
		if this.object.is_default[row] = "Y" then
			of_SetRefEmail(this.object.user_id[row], Data)
		end if
		
		//Modified By Ken.Guo 2010-03-03
		//		//Check duplicate Email address - Alfee 08.22.2008
		//		ls_userid = this.object.user_id[row]
		//		ls_userid_dup = of_check_duplicate_address(ls_userid, data)
		//		IF Len(Trim(ls_userid_dup)) > 0 THEN 
		//		//Start Code Change ----09.17.2008 #V85 maha	
		//			if gb_contract_module or gb_contract_version then
		//				MessageBox("Email Duplication Warning",'The email address is duplicated with that of ' + ls_userid_dup + ".~r As this may cause problems with contract alarm notifications, it must be corrrected.", Exclamation! )
		//				return 1
		//			else
		//				MessageBox("Email Duplication Notice",'The email address entered is duplicated with that of ' + ls_userid_dup + " .", Information! )
		//			end if
		//		//End Code Change---09.17.2008
		//		END IF
	Case "protocol" //added by gavins 20121120
		If data = 'POP3' Then
			SetItem( Row, 'pop3_port', 110 )
		Else
			SetItem( Row, 'pop3_port', 143 )			
		End If		
end choose
*/
Return 0
end event

event itemerror;Return 1
end event

event other;if Message.Number = 522 then // Add by Evan on 2008-03-24
	Return 1
end if
end event

