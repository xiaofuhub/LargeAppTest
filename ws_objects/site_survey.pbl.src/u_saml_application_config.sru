$PBExportHeader$u_saml_application_config.sru
forward
global type u_saml_application_config from userobject
end type
type cb_close from commandbutton within u_saml_application_config
end type
type cb_refresh from commandbutton within u_saml_application_config
end type
type cb_save from commandbutton within u_saml_application_config
end type
type cb_del from commandbutton within u_saml_application_config
end type
type cb_add from commandbutton within u_saml_application_config
end type
type dw_detail from u_dw within u_saml_application_config
end type
type tv_user from treeview within u_saml_application_config
end type
type dw_browse from u_dw within u_saml_application_config
end type
end forward

global type u_saml_application_config from userobject
integer width = 3954
integer height = 1648
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_close cb_close
cb_refresh cb_refresh
cb_save cb_save
cb_del cb_del
cb_add cb_add
dw_detail dw_detail
tv_user tv_user
dw_browse dw_browse
end type
global u_saml_application_config u_saml_application_config

type variables
string is_Type
string is_UserID
string is_ErrInfo
DataStore ids_User
TreeViewItem itvi_User
boolean ib_DoFilter = true

n_cst_encrypt in_Encrypt

n_cst_string inv_string

Window iw_parent
end variables

forward prototypes
public function integer of_createusertree (string as_userid)
public function integer of_filter (string as_userid)
public function integer of_findusertreeitem (string as_userid)
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

on u_saml_application_config.create
this.cb_close=create cb_close
this.cb_refresh=create cb_refresh
this.cb_save=create cb_save
this.cb_del=create cb_del
this.cb_add=create cb_add
this.dw_detail=create dw_detail
this.tv_user=create tv_user
this.dw_browse=create dw_browse
this.Control[]={this.cb_close,&
this.cb_refresh,&
this.cb_save,&
this.cb_del,&
this.cb_add,&
this.dw_detail,&
this.tv_user,&
this.dw_browse}
end on

on u_saml_application_config.destroy
destroy(this.cb_close)
destroy(this.cb_refresh)
destroy(this.cb_save)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.dw_detail)
destroy(this.tv_user)
destroy(this.dw_browse)
end on

event constructor;//of_CreateUserTree("")
end event

type cb_close from commandbutton within u_saml_application_config
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

event clicked;If isvalid(iw_parent) Then
	Close(iw_parent)
End If


end event

type cb_refresh from commandbutton within u_saml_application_config
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

event clicked;
long ll_Handle
parent.dw_browse.retrieve()

end event

type cb_save from commandbutton within u_saml_application_config
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

event clicked;String	ls_UserId, ls_app_name
long		ll_Row, ll_Count,i,ll_find

dw_browse.AcceptText()
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() <= 0 then Return


//Added By Ken.Guo 04/21/2014
For i = 1 To dw_browse.RowCount()
	ls_app_name = dw_browse.GetItemString(i, 'app_name')	
	If ls_app_name = '' or isnull(ls_app_name) Then
		Messagebox('Validation','Application Name cannot be empty.')
			dw_browse.ScrolltoRow(i)
			dw_browse.SetRow(i)
			dw_browse.SetFocus()
			dw_browse.SetColumn('app_name')		
		Return 
	End If
	If i <> dw_browse.RowCount() Then
		ll_find = dw_browse.Find('app_name = "'+ls_app_name+ '"', i+1, dw_browse.RowCount())
		If ll_find > 0 Then
			Messagebox('Validation','The existence of duplicate IdP Server Name "'+ls_app_name+'" , please check it.')
			dw_browse.ScrolltoRow(i)
			dw_browse.SetRow(i)
			dw_browse.SetFocus()
			dw_browse.SetColumn('app_name')
			Return
		End If
	End If
Next



if dw_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", is_ErrInfo, StopSign!)
end if


end event

type cb_del from commandbutton within u_saml_application_config
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
dw_browse.DeleteRow(0)
dw_browse.Event RowFocusChanged(dw_browse.GetRow())


end event

type cb_add from commandbutton within u_saml_application_config
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

// Insert row
ll_InsertRow = dw_browse.InsertRow(0)
dw_browse.ScrollToRow(ll_InsertRow)

end event

type dw_detail from u_dw within u_saml_application_config
event ue_keydown pbm_dwnkey
boolean visible = false
integer x = 663
integer y = 1456
integer width = 3255
integer height = 48
integer taborder = 30
string title = "none"
string dataobject = "d_email_detail"
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

type tv_user from treeview within u_saml_application_config
boolean visible = false
integer x = 73
integer y = 12
integer width = 78
integer height = 1492
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
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

type dw_browse from u_dw within u_saml_application_config
integer x = 32
integer y = 12
integer width = 3886
integer height = 1496
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_saml_sp_application_browse"
boolean hscrollbar = true
end type

event constructor;this.SetTransObject(SQLCA)
this.Retrieve()

end event

event dberror;call super::dberror;is_ErrInfo = SQLErrText
Return 1
end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

end event

