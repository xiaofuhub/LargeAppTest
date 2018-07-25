$PBExportHeader$w_email_account_edit.srw
$PBExportComments$(Appeon)Eugene 06.27.2013 - V141 ISG-CLX  replaced the same name object
forward
global type w_email_account_edit from window
end type
type cb_option from commandbutton within w_email_account_edit
end type
type cb_help from commandbutton within w_email_account_edit
end type
type dw_sysaddr from datawindow within w_email_account_edit
end type
type cb_test from commandbutton within w_email_account_edit
end type
type dw_detail from datawindow within w_email_account_edit
end type
type dw_browse from datawindow within w_email_account_edit
end type
type cb_save from commandbutton within w_email_account_edit
end type
type cb_close from commandbutton within w_email_account_edit
end type
type cb_add from commandbutton within w_email_account_edit
end type
type cb_del from commandbutton within w_email_account_edit
end type
type tv_user from treeview within w_email_account_edit
end type
end forward

global type w_email_account_edit from window
integer width = 3886
integer height = 1764
boolean titlebar = true
string title = "Account Maintenance"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_option cb_option
cb_help cb_help
dw_sysaddr dw_sysaddr
cb_test cb_test
dw_detail dw_detail
dw_browse dw_browse
cb_save cb_save
cb_close cb_close
cb_add cb_add
cb_del cb_del
tv_user tv_user
end type
global w_email_account_edit w_email_account_edit

type variables
string is_Type
string is_UserID
string is_ErrInfo
DataStore ids_User
TreeViewItem itvi_User
boolean ib_DoFilter = true

n_cst_encrypt in_Encrypt

n_cst_string inv_string
end variables

forward prototypes
public function integer of_createusertree (string as_userid)
public function integer of_setdefault (long al_currentrow)
public function integer of_findusertreeitem (string as_userid)
public function integer of_filter (string as_userid)
public function integer of_changeuserid (long al_row, string as_olduserid, string as_newuserid)
public function integer of_setrefemail (string as_userid, string as_email)
public function string of_check_duplicate_address (string as_userid, string as_email)
public subroutine of_set_used_saved_pwd ()
end prototypes

public function integer of_createusertree (string as_userid);long i, ll_Root
TreeViewItem ltvi_Item

// Get user information
ids_User = Create DataStore
ids_User.DataObject = "d_email_users"
ids_User.SetTransObject(SQLCA)
ids_User.Retrieve()
if Len(as_UserID) > 0 then
	//---------Begin Modified by (Appeon)Eugene 06.27.2013 for V141 ISG-CLX--------	
	  /*
		ids_User.SetFilter("user_id = '" + as_UserID + "'")	
	  */
	ids_User.SetFilter("upper(user_id) = '" + upper(as_UserID) + "'") //add by stephen 10.08.2012 -Can't see email settings from the Personal settings 	 bug 3290	  
	//---------End Modfiied ------------------------------------------------------------------	
	ids_User.Filter()
end if

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

public function integer of_setdefault (long al_currentrow);long ll_Start
long i, ll_End
string ls_UserID

if dw_detail.RowCount() = 1 then Return 1
ls_UserID = dw_detail.GetItemString(al_CurrentRow, "user_id")

ll_Start = 1
ll_End = al_CurrentRow - 1
if ll_End >= ll_Start then
	for i = ll_End to ll_Start step -1
		if dw_detail.GetItemString(i, "user_id") <> ls_UserID then
			Exit
		else
			dw_detail.SetItem(i, "is_default", "N")
		end if	
	next
end if

ll_Start = al_CurrentRow + 1
ll_End = dw_detail.RowCount()
for i = ll_Start to ll_End	
	if dw_detail.GetItemString(i, "user_id") <> ls_UserID then
		Exit
	else
		dw_detail.SetItem(i, "is_default", "N")
	end if	
next

dw_detail.SetItem(al_CurrentRow, "is_default", "Y")
of_SetRefEmail(ls_UserID, dw_detail.object.email[al_CurrentRow])

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

public function integer of_filter (string as_userid);//---------Begin Modified by (Appeon)Eugene 06.27.2013 for V141 ISG-CLX--------
  /*
if Len(as_UserID) > 0 then
	dw_browse.SetFilter("user_id = '" + as_UserID + "'")      
  */
 if LenA(as_UserID) > 0 then
 	dw_browse.SetFilter("upper(user_id) = '" + upper(as_UserID) + "'") //add by stephen 10.08.2012 -Can't see email settings from the Personal settings 	 bug 3290
//---------End Modfiied ------------------------------------------------------------------
else
	dw_browse.SetFilter("")
end if

dw_browse.Filter()
dw_browse.SetRow(1)
dw_browse.Event RowFocusChanged(1)

Return 1
end function

public function integer of_changeuserid (long al_row, string as_olduserid, string as_newuserid);long ll_Handle
long ll_FindRow
string ls_Default
string ls_UserFlag = "$USERID$"
boolean lb_ResetDefault = true

ll_Handle = of_FindUserTreeItem(as_NewUserID)
if ll_Handle <= 0 then Return -1

// Reset default
if dw_browse.GetItemString(al_Row, "is_default") = "Y" then
	if al_Row - 1 > 0 then
		if dw_browse.GetItemString(al_Row - 1, "user_id") = as_OldUserID then
			dw_browse.SetItem(al_Row - 1, "is_default", "Y")
			of_SetRefEmail(as_OldUserID, dw_browse.object.email[al_Row - 1])
			lb_ResetDefault = false
		end if
	end if
	if al_Row + 1 <= dw_browse.RowCount() and lb_ResetDefault then
		if dw_browse.GetItemString(al_Row + 1, "user_id") = as_OldUserID then
			dw_browse.SetItem(al_Row + 1, "is_default", "Y")
			of_SetRefEmail(as_OldUserID, dw_browse.object.email[al_Row + 1])
		end if
	end if
	if dw_browse.RowCount() = 1 then
		of_SetRefEmail(as_OldUserID, "")
	end if
end if

// Determine default value
dw_browse.SetItem(al_Row, "user_id", ls_UserFlag)
dw_browse.SetFilter("user_id = '" + as_NewUserID + "' OR user_id = '" + ls_UserFlag + "'")
dw_browse.Filter()
if dw_browse.RowCount() > 1 then
	ls_Default = "N"
else
	ls_Default = "Y"
end if

// Reset user_id and is_default
ll_FindRow = dw_browse.Find("user_id = '" + ls_UserFlag + "'", 1, dw_browse.RowCount())
if ll_FindRow > 0 then
	dw_browse.SetItem(ll_FindRow, "user_id", as_NewUserID)
	dw_browse.SetItem(ll_FindRow, "is_default", ls_Default)
	if ls_Default = "Y" then
		of_SetRefEmail(as_NewUserID, dw_browse.object.email[ll_FindRow])
	end if
	dw_browse.ScrollToRow(ll_FindRow)
	dw_browse.Event RowFocusChanged(ll_FindRow)
end if

// Refresh data
ib_DoFilter = false
tv_user.SelectItem(ll_Handle)
ib_DoFilter = true

Return 1
end function

public function integer of_setrefemail (string as_userid, string as_email);long ll_FindRow

//ll_FindRow = ids_User.Find("user_id = '" + as_UserID + "'", 1, ids_User.RowCount())
ll_FindRow = ids_User.Find("upper(user_id) = '" + Upper(as_UserID) + "'", 1, ids_User.RowCount()) //alfee 05.27.2014
if ll_FindRow > 0 then
	ids_User.SetItem(ll_FindRow, "email_id", as_Email)
end if

Return 1
end function

public function string of_check_duplicate_address (string as_userid, string as_email);//Verify if a duplicate email address existed - Alfee 08.22.2008
//Return a duplicate user id if found

Long i, ll_cnt, ll_found
String ls_find, ls_user, ls_email

IF IsNull(as_email) OR Len(Trim(as_email)) < 1 THEN RETURN ''

IF IsNull(as_userid) THEN as_userid = ''
as_userid = Lower(Trim(as_userid))
as_email = Lower(Trim(as_email))
ls_find = "Lower(Trim(user_id)) <> '" + as_userid  + "' AND Lower(Trim(email)) = '" + as_email + "'"

//Check in Primary! buffer
ll_cnt = dw_browse.RowCount()
IF ll_cnt > 1 THEN
	ll_found = dw_browse.Find(ls_find, 1, ll_cnt)
	IF ll_found > 0 THEN 
		ls_user = dw_browse.GetItemString(ll_found, 'user_id')
		RETURN ls_user
	END IF
END IF	

//Check in Filter! buffer
ll_cnt = dw_browse.FilteredCount()
FOR i = 1 to ll_cnt
	ls_email = dw_browse.Getitemstring( i,'email', Filter!, FALSE)
	ls_user = dw_browse.Getitemstring( i,'user_id', Filter!, FALSE)
	IF Lower(Trim(ls_email)) = as_email AND Lower(Trim(ls_user)) <> as_userid THEN RETURN ls_user
NEXT

RETURN ''
end function

public subroutine of_set_used_saved_pwd ();//====================================================================
//$<Function>: of_set_used_saved_pwd
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Show/Hide Use AD Saved Password Checkbox, Copied from CLX
//$<Author>: (Appeon) long.zhang 11.16.2016 (v15.3 AD Authentication)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_ad_status,li_ad_save_pwd
String ls_ad_user,ls_userid
If dw_detail.getrow() > 0 Then
	ls_userid = dw_detail.getitemstring(dw_detail.getrow(),'user_id')
	Select ad_status, ad_user, ad_save_pwd into :li_ad_status, :ls_ad_user, :li_ad_save_pwd  from security_users where user_id = :ls_userid;
	If gnv_user_option.of_get_option_value('allow_ad_function') = '1' and li_ad_status = 1 and li_ad_save_pwd = 1 and Len(ls_ad_user) > 0 Then 		
		dw_detail.modify('use_ad_password.visible = "1"')
	Else
		dw_detail.modify('use_ad_password.visible = "0"')
	End If
End If
end subroutine

on w_email_account_edit.create
this.cb_option=create cb_option
this.cb_help=create cb_help
this.dw_sysaddr=create dw_sysaddr
this.cb_test=create cb_test
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_add=create cb_add
this.cb_del=create cb_del
this.tv_user=create tv_user
this.Control[]={this.cb_option,&
this.cb_help,&
this.dw_sysaddr,&
this.cb_test,&
this.dw_detail,&
this.dw_browse,&
this.cb_save,&
this.cb_close,&
this.cb_add,&
this.cb_del,&
this.tv_user}
end on

on w_email_account_edit.destroy
destroy(this.cb_option)
destroy(this.cb_help)
destroy(this.dw_sysaddr)
destroy(this.cb_test)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.tv_user)
end on

event open;long 		ll_Handle,ll_LeftIndent,ll_TopIndent
integer 	li_Pos

// Get window message (Format: TYPE|USERID)
li_Pos = Pos(Message.StringParm, "|")
is_Type = Left(Message.StringParm, li_Pos - 1)
is_UserID = Right(Message.StringParm, Len(Message.StringParm) - li_Pos)

// Create user tree
choose case is_Type
	case "ALL"
		this.Title = "Email Account Maintenance (ALL)"
		of_CreateUserTree("")
		
	case "PERSONAL", "RECRUIT" //Added RECRUIT - alfee 10.24.2015
		this.Title = "Email Account Maintenance (" + is_UserID + ")"
		of_CreateUserTree(is_UserID)		
		of_Filter(is_UserID)
		
		//Added By Ken.Guo 2010-12-03.
		If dw_browse.RowCount() = 0 Then
			cb_add.event clicked( )
		End If
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-01-09 By: Scofield
		//$<Reason> Adjust the interface's appearance.

		tv_user.Visible = false
		dw_sysaddr.Visible = false
		This.Width = This.Width - tv_user.Width + 9
		ll_LeftIndent = tv_user.Width + 9
		dw_browse.x = dw_browse.x - ll_LeftIndent
		dw_detail.x = dw_detail.x - ll_LeftIndent
		cb_test.x = cb_test.x - ll_LeftIndent + 100
		cb_option.x = dw_browse.x
		cb_add.x = cb_add.x - ll_LeftIndent
		cb_del.x = cb_del.x - ll_LeftIndent
		cb_save.x = cb_save.x - ll_LeftIndent
		cb_close.x = cb_close.x - ll_LeftIndent
		cb_help.x = cb_help.x - ll_LeftIndent //Add by Evan on 05/05/2008
		
		ll_TopIndent = 250
		This.Height = This.Height - ll_TopIndent
		dw_browse.Height = dw_browse.Height - ll_TopIndent
		dw_detail.y = dw_detail.y - ll_TopIndent
		cb_test.y = cb_test.y - ll_TopIndent
		cb_option.y = cb_option.y - ll_TopIndent
		cb_add.y = cb_add.y - ll_TopIndent
		cb_del.y = cb_del.y - ll_TopIndent
		cb_save.y = cb_save.y - ll_TopIndent
		cb_close.y = cb_close.y - ll_TopIndent
		cb_help.y = cb_help.y - ll_TopIndent //Add by Evan on 05/05/2008
		//---------------------------- APPEON END ----------------------------
	case else
end choose

// Locate specify user
ll_Handle = of_FindUserTreeItem(is_UserID)
tv_user.SelectItem(ll_Handle)

dw_detail.object.user_id.protect = 1
dw_detail.object.user_id.background.color = dw_detail.Object.DataWindow.Color

//Added By Ken.Guo 2010-12-03.
If gnv_data.of_getitem('icred_settings', 'receive_email', False) <> '1' Then
	cb_option.visible = False
	dw_detail.modify("pop3_server.visible = '0' pop3_server_t.visible = '0' pop3_port.visible = '0' pop3_port_t.visible = '0' pop3_ssl.Visible = '0' protocol.visible='0' receivedate.visible='0' t_1.visible='0'")
	dw_browse.modify("pop3_server.visible = '0' pop3_server_t.visible = '0' pop3_port.visible = '0' pop3_port_t.visible = '0' pop3_ssl.Visible = '0' pop3_ssl_t.Visible='0' protocol.visible='0'")
End If

//Begin - Added By Mark Lee 12/05/2012
//If gnv_data.of_getitem('icred_settings', 'set_56', False) = '1' Then
//Start Code Change ----08.16.2017 #V154 maha - allow access to easymail settings
//If gnv_data.of_getitem('icred_settings', 'set_56', False) = '1'  And is_type <> "RECRUIT" Then	 //alfee 10.24.2015	
//	//dw_detail.modify("server_t.visible = '0' server.visible = '0' port_t.visible = '0' port.visible = '0' authmode.visible = '0' gb_1.Visible = '0' smtp_ssl.visible='0'")
//	dw_detail.modify("server_t.visible = '0' server.visible = '0' port_t.visible = '0' port.visible = '0' authmode.visible = '0' gb_1.Visible = '0' smtp_ssl.visible='0' sendprotocol.visible='0'") //(Appeon)Harry 06.04.2014 - V142 ISG-CLX
//	dw_browse.modify("server.visible = '0' port.visible = '0' authmode.visible = '0' smtp_ssl.visible = '0' ")
//End If
//End - Added By Mark Lee 12/05/2012




end event

event closequery;dw_detail.AcceptText()
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() + dw_sysaddr.ModifiedCount() > 0 then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then Return 1
end if
end event

event close;if IsValid(ids_User) then Destroy ids_User
end event

type cb_option from commandbutton within w_email_account_edit
integer x = 1001
integer y = 1552
integer width = 553
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email Receive Option..."
end type

event clicked;String ls_user_id 

ls_user_id = dw_browse.GetItemString(dw_browse.GetRow(),'user_id')
If ls_user_id = '' or isnull(ls_user_id) Then Return

Openwithparm(w_em_user_config,ls_user_id)
end event

type cb_help from commandbutton within w_email_account_edit
integer x = 3520
integer y = 1552
integer width = 311
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;//Open(w_email_help)
String  ls_downurl
inet linet_help
IF appeongetclienttype() = 'WEB' THEN
  SELECT Top 1 downloadurl Into :ls_downurl From icred_settings;
	IF Len(ls_downurl) > 0 THEN
		linet_help = Create inet
		linet_help.HyperLinkToURL(ls_downurl+'help\html\'+'email_config.htm')
		Destroy linet_help
	ELSE
		MessageBox("Error","Tring get help file path Failed.")
	END IF
else	
	ShowHelp(Gs_Current_Directory+"\help\Intellihelp.chm", Keyword!, "Email config")
end if
end event

type dw_sysaddr from datawindow within w_email_account_edit
integer y = 1552
integer width = 965
integer height = 92
integer taborder = 40
string title = "none"
string dataobject = "d_email_pub_addresser"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild ldwc_Child

this.SetTransObject(SQLCA)
this.Retrieve()

this.GetChild("set_addresser", ldwc_Child)
ldwc_Child.InsertRow(1)

end event

type cb_test from commandbutton within w_email_account_edit
boolean visible = false
integer x = 503
integer y = 1784
integer width = 448
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send &test Email "
end type

event clicked;String	ls_Server,ls_Account,ls_Password,ls_Email, ls_sendprotocol
String ls_pop3_server , ls_Protocol, ls_err_desc
String ls_ad_user,ls_userid, ls_ad_pwd //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
Long ll_pop3_port
long		ll_Row,ll_Port,ll_AuthMode,ll_Return,ll_sendauthmode_exchange,ll_getauthmode_exchange
Integer li_send_result = 0, li_smtpssl, li_pop3ssl, li_rtn
Integer li_ad_status,li_ad_save_pwd //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
str_email_account lstr_email_account //Added By Ken.Guo 07/03/2013

n_cst_easymail_smtp 	lnv_Mail
n_cst_easymail_pop3 	lnv_Mail_pop3
n_cst_easymail_eamail lnv_Mail_eamail //Added By Ken.Guo 07/27/2013
n_cst_easymail_imap4	lnv_Mail_imap4//added by gavins 20121127

ll_Row = dw_detail.GetRow()
if ll_Row <= 0 or ll_Row > dw_detail.RowCount() then return

dw_detail.AcceptText()
gs_CurAddresser = dw_detail.GetItemString(ll_Row,'user_id')
ls_Server = dw_detail.GetItemString(ll_Row,'Server')
ll_Port = dw_detail.GetItemNumber(ll_Row,'Port')
ll_AuthMode = dw_detail.GetItemNumber(ll_Row,'AuthMode')
ls_Account = dw_detail.GetItemString(ll_Row,'Account')
ls_Password = dw_detail.GetItemString(ll_Row,'Password')
ls_Email = dw_detail.GetItemString(ll_Row,'Email')
ls_pop3_server = dw_detail.GetItemString(ll_Row,'pop3_Server')
ll_pop3_Port = dw_detail.GetItemNumber(ll_Row,'pop3_Port')
li_smtpssl =  dw_detail.GetItemNumber(ll_Row,'smtp_ssl')
li_pop3ssl =  dw_detail.GetItemNumber(ll_Row,'pop3_ssl')
ls_Protocol = dw_detail.GetItemString(ll_Row,'protocol')//added by gavins 20121127

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.16.2016
//<$>reason:v15.3 AD Authentication
ls_userid = dw_detail.getitemstring(ll_row,'user_id')
If  gnv_user_option.of_get_option_value('allow_ad_function') = '1'  and  dw_detail.describe('use_ad_password.visible') = '1'  and dw_detail.getitemnumber(ll_row, 'use_ad_password') = 1 Then
	Select ad_status, ad_user,ad_password, ad_save_pwd into :li_ad_status, :ls_ad_user,:ls_ad_pwd, :li_ad_save_pwd  from security_users where user_id = :ls_userid;
	If li_ad_status = 1 and li_ad_save_pwd = 1 and Len(ls_ad_user) > 0 and Len(ls_ad_pwd) > 0 Then 		
		ls_Password = in_Encrypt.of_decrypt( ls_ad_pwd)
	Else
		gnv_debug.of_output(True, 'Test email account. It does not use saved AD password. it is using email accont~'s password.')
	End If
End If
//------------------- APPEON END -------------------

//Added By Ken.Guo 07/03/2013
ls_sendprotocol = dw_detail.GetItemString(ll_Row,'sendprotocol')
ll_sendauthmode_exchange = dw_detail.GetItemNumber(ll_Row,'sendauthmode_exchange')
ll_getauthmode_exchange = dw_detail.GetItemNumber(ll_Row,'getauthmode_exchange')
lstr_email_account.as_user_id = gs_CurAddresser
lstr_email_account.as_sendserver = ls_Server
lstr_email_account.al_sendport = ll_Port
lstr_email_account.ai_sendauthmode = ll_AuthMode
lstr_email_account.as_account = ls_Account
lstr_email_account.as_password = ls_Password
lstr_email_account.as_emailaddress = ls_Email
lstr_email_account.as_receiveserver = ls_Pop3_Server
lstr_email_account.al_receiveport = ll_pop3_Port
lstr_email_account.ai_sendssl = li_smtpssl
lstr_email_account.ai_receivessl = li_pop3ssl
lstr_email_account.as_receiveprotocol = ls_Protocol
lstr_email_account.as_sendprotocol = ls_sendprotocol
lstr_email_account.ai_sendauthmode_exchange = ll_sendauthmode_exchange
lstr_email_account.ai_receiveauthmode  = ll_getauthmode_exchange

if (IsNull(ls_Server) or Trim(ls_Server) = '' ) and dw_detail.describe( 'server.visible' ) = '1' then
	MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server address can not be null.')
	dw_detail.SetColumn('Server')
	dw_detail.SetFocus()
	return
end if

if IsNull(ll_Port) and dw_detail.describe( 'server.visible' ) = '1'   then
	MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server port can not be null.')
	dw_detail.SetColumn('Port')
	dw_detail.SetFocus()
	return
end if

//Added By Ken.Guo 2010-03-25.
If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '1' Then
	if IsNull(ls_pop3_server) or Trim(ls_pop3_server) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'Incoming Mail Server address can not be null.')
		dw_detail.SetColumn('POP3_Server')
		dw_detail.SetFocus()
		return
	end if
	if IsNull(ll_pop3_Port) then
		MessageBox(gnv_app.iapp_object.DisplayName,'Incoming Mail Server port can not be null.')
		dw_detail.SetColumn('POP3_Port')
		dw_detail.SetFocus()
		return
	end if
End If

if IsNull(ll_AuthMode) and dw_detail.describe( 'server.visible' ) = '1'  then
	MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server Secure Password Authentication can not be null.')
	dw_detail.SetColumn('AuthMode')
	dw_detail.SetFocus()
	return
end if

//BEGIN---Modify by Evan on 06/05/2008
if ll_AuthMode = 1 then
	if IsNull(ls_Account) or Trim(ls_Account) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'EMail Account can not be null.')
		dw_detail.SetColumn('Account')
		dw_detail.SetFocus()
		return
	end if
end if
//END---Modify by Evan on 06/05/2008

if IsNull(ls_Email) or Trim(ls_Email) = '' then
	MessageBox(gnv_app.iapp_object.DisplayName,'EMail Address can not be null.')
	dw_detail.SetColumn('Email')
	dw_detail.SetFocus()
	return
end if

//Modified By Ken.Guo 07/03/2013
If dw_detail.describe( 'server.visible' ) = '1'   Then
	If ls_sendprotocol = 'SMTP' Then
		li_rtn = lnv_Mail.of_CreateObject() 
	Else
		li_rtn = lnv_Mail.of_CreateObject_ea() 
	End If
	If li_rtn = -1 Then
		f_show_message('create Email object','','','','')
		dw_detail.SetColumn('Server')
		dw_detail.SetFocus()
		Return
	End If
End If

//Added By Ken.Guo 2010-03-25.
String ls_sort_rule
If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '1' Then
	If ls_Protocol = 'POP3' Then
		If lnv_Mail_pop3.of_createobject( ) = -1 Then
			f_show_message('create POP3 object','','','','')
			dw_detail.SetColumn('POP3_Server')
			dw_detail.SetFocus()	
			Return
		End If
		lnv_Mail_pop3.of_Setpop3Info(ls_pop3_Server, ll_pop3_Port, li_pop3ssl)
		lnv_Mail_pop3.of_SetAccount(ls_Account, ls_Password)
		If lnv_Mail_pop3.of_PingServer(True) = False Then 
			Return
		End If
		lnv_Mail_pop3.of_disconnect_pop3( )
	ElseIf ls_Protocol = 'IMAP4' Then//added by gavins 20121127
		If lnv_Mail_imap4.of_createobject( ) = -1 Then
			f_show_message('create imap4 object','','','','')
			dw_detail.SetColumn('POP3_Server')
			dw_detail.SetFocus()	
			Return
		End If
		lnv_Mail_imap4.of_setimap4info(ls_pop3_Server,ll_pop3_Port,li_pop3ssl)
		If lnv_Mail_imap4.of_PingServer(True, ls_pop3_Server,ls_account, ls_Password, li_pop3ssl ) = false Then 
			Return
		End If
		lnv_Mail_imap4.of_disconnect_imap4( )
	Else //Exchange2003/2007 //Added By Ken.Guo 07/27/2013
		If lnv_Mail_eamail.of_createobject( ) = -1 Then
			f_show_message('create eamail object','','','','')
			dw_detail.SetColumn('POP3_Server')
			dw_detail.SetFocus()	
			Return			
		End If
		lnv_Mail_eamail.of_seteaserverinfo( lstr_email_account )
		lnv_Mail_eamail.of_setlog(True)
		If lnv_Mail_eamail.of_pingserver( True ) = False Then
			Return
		End If
		lnv_Mail_eamail.of_disconnect_ea( )
	End If
End If

lnv_Mail.ib_Recruit = TRUE //alfee 10.24.2015
If dw_detail.describe( 'server.visible' ) = '1'   Then
	lnv_Mail.of_SetSmtpInfo(lstr_email_account)
	lnv_Mail.of_SetAccountAddress(lstr_email_account)
	
	//----------------------------------------------------//added by gavins 20121010
	lnv_Mail.of_Setlog( )   //write test email log
	
	//Send EMail
	gb_ShowEmailErrorMessage = True
	lnv_Mail.is_user_id = gs_CurAddresser //Added By Ken.Guo 2010-10-18.
	ll_Return = lnv_Mail.of_SendText(ls_Email, '', '','Test Mail', 'Hello,This is a test Mail', '')
ElseIF gi_email_type = 1 Then //send with Outlook //Added By Ken.Guo 06/04/2013
	gb_ShowEmailErrorMessage = True
	lnv_Mail.is_user_id = gs_CurAddresser 
	ll_Return = lnv_Mail.of_SendText(ls_Email, '', '','Test Mail', 'Hello,This is a test Mail', '')
End If

if ll_Return = 0 then
	li_send_result = 0
	MessageBox("Congratulation", "Email test is Successfull!")
else
	li_send_result = -1
	//Added by Nova.zhang on 2008-11-07
	If lstr_email_account.as_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		//Added By Ken.Guo 07/04/2013
		ls_err_desc = lnv_Mail.of_GeteMailError(ll_Return)
		f_show_message('error_code_'+string(ll_Return),'ALL',ls_err_desc,'','')
	End If
end if

gnv_debug.of_output( true, 'Email sending complete.', false ) //added by gavins 20121010

//Added By Ken.Guo 2010-11-15. Email Audit
String ls_errtext,ls_computer_info
n_cst_string lnv_string
If ll_Return <> 0 then 
	If lstr_email_account.as_sendprotocol = 'SMTP' Then
		ls_errtext = gnv_message.of_get_error_message( ll_Return)
	Else
		ls_errtext = ls_err_desc
	End If
End If
ls_computer_info = lnv_Mail.of_get_compute_info( )

If dw_detail.describe( 'server.visible' ) = '1'   Then
	Insert Into em_mail_audit
	(user_id,mail_from,mail_to,mail_cc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,compute_info)
	Values 
	(:gs_user_id,:gs_user_id,:ls_Email,'','Test Mail',getdate(),'',null,null,null,null,null,'Test Email','',:li_send_result,:ls_errtext,:ls_computer_info);
End IF


lnv_Mail.of_DeleteObject()

end event

type dw_detail from datawindow within w_email_account_edit
event ue_keydown pbm_dwnkey
integer x = 663
integer y = 812
integer width = 3191
integer height = 688
integer taborder = 30
string title = "none"
string dataobject = "d_email_detail"
boolean livescroll = true
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event itemerror;Return 1
end event

event itemchanged;string ls_OldUserID
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
		
		//---------Begin Modified by (Appeon)Eugene 06.27.2013 for V141 ISG-CLX--------
		  /*
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
		*/
		ls_userid = this.object.user_id[row]
		ls_userid_dup = of_check_duplicate_address(ls_userid, data)
		IF Len(Trim(ls_userid_dup)) > 0 THEN 
		//Start Code Change ----09.17.2008 #V85 maha	
			if gb_contract_module or gb_contract_version then
				MessageBox("Email Duplication Warning",'The email address is duplicated with that of ' + ls_userid_dup + ".~r As this may cause problems with contract alarm notifications, it must be corrrected.", Exclamation! )
				return 1
			else
				MessageBox("Email Duplication Notice",'The email address entered is duplicated with that of ' + ls_userid_dup + " .", Information! )
			end if
		//End Code Change---09.17.2008
		END IF
		//---------End Modfiied ------------------------------------------------------------------
	Case "protocol" //added by gavins 20121120
		If data = 'POP3' Then
			SetItem( Row, 'pop3_port', 110 )
		Else
			SetItem( Row, 'pop3_port', 143 )			
		End If		
end choose

Return 0
end event

event buttonclicked;if dwo.name = "b_test" then // Add by Evan on 2008-03-24
	cb_test.Event Clicked()
end if
end event

event other;if Message.Number = 522 then // Add by Evan on 2008-03-24
	Return 1
end if
end event

type dw_browse from datawindow within w_email_account_edit
integer x = 663
integer y = 12
integer width = 3191
integer height = 780
integer taborder = 20
string title = "none"
string dataobject = "d_email_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.SetTransObject(SQLCA)
this.Retrieve()
dw_browse.ShareData(dw_detail)
end event

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_detail.ScrollToRow(CurrentRow)

of_set_used_saved_pwd()//Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
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

String	ls_Password
long		ll_Cycle

SetPointer(HourGlass!)

for ll_Cycle = 1 to RowCount
	ls_Password = This.GetItemString(ll_Cycle,"password")
	if IsNull(ls_Password) then CONTINUE
	
	ls_Password = in_encrypt.of_Decrypt(ls_Password)
	This.SetItem(ll_Cycle,"password",ls_Password)
	This.SetItemStatus(ll_Cycle,"password",Primary!,NotModified!)
next

SetPointer(Arrow!)

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

SetPointer(Arrow!)

end event

type cb_save from commandbutton within w_email_account_edit
integer x = 2839
integer y = 1552
integer width = 311
integer height = 92
integer taborder = 80
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

ll_Row = dw_detail.GetRow()

//Added By Ken.Guo 12/05/2011. 
If ll_row > 0 Then
	If Not inv_string.of_check_name(dw_detail.GetItemString(1,'email' ),0,False) Then
		Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
		dw_detail.SetColumn('email')
		dw_detail.SetFocus()
		Return 
	End If
End If


if dw_sysaddr.ModifiedCount() > 0 then
	dw_sysaddr.Update()
end if

if dw_detail.AcceptText() = -1 then Return
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() <= 0 then Return

If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '1' Then
	
	select isnull( count(1), 0 ) into:ll_Count from em_mail_items  where protocoltype = 'IMAP4';
	
	If ll_row > 0 Then
		If dw_detail.GetItemString( dw_detail.GetRow( ), 'protocol' ) = 'IMAP4' And IsNull( dw_detail.GetItemDateTime( dw_detail.GetRow( ), 'receivedate' ) ) and ll_Count = 0 Then//added by gavins 20121121
			If MessageBox( 'Tips', 'After you set the protocol to IMAP4, if you didn’t set the start date for receiving emails you may receive emails ' + &
						'that are duplicated with the emails you have received with the POP3 protocol. Do you want to save the setting?' , question!, yesno! ) <> 1 Then
				Return
			End If
		End If
	End If
End If
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-09 By: Scofield
//$<Reason> Add verify.

//Modified By Alan on 2009-1-7 BugA112501
if ll_row > 0 then
	//if ll_Row <= 0 or ll_Row > dw_detail.RowCount() then return
	
	ls_UserId = dw_detail.GetItemString(ll_Row,'user_id')
	
	if IsNull(ls_UserId) or Trim(ls_UserId) = '' then
		MessageBox(gnv_app.iapp_object.DisplayName,'User id can not be null.')
		dw_detail.SetColumn('user_id')
		dw_detail.SetFocus()
		return
	end if
end if
//---------------------------- APPEON END ----------------------------

if dw_browse.Update() = 1 and ids_User.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", is_ErrInfo, StopSign!)
end if

dw_detail.object.user_id.protect = 1
dw_detail.object.user_id.background.color = dw_detail.Object.DataWindow.Color

gnv_sertifi.ib_isvalid_sertifi = false //Added By Ken.Guo 2011-07-15.  Sertifi email info need refresh.
gnv_echosign.ib_isvalid_sertifi = false //Added By Jay Chen 10-18-2013
end event

type cb_close from commandbutton within w_email_account_edit
integer x = 3200
integer y = 1552
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

event clicked;Close(Parent)
end event

type cb_add from commandbutton within w_email_account_edit
integer x = 2199
integer y = 1552
integer width = 311
integer height = 92
integer taborder = 60
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
dw_detail.AcceptText()
ll_InsertRow = dw_browse.InsertRow(0)

of_set_used_saved_pwd()//Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)

// Set init value
dw_browse.SetItem(ll_InsertRow, "port", 25)
dw_browse.SetItem(ll_InsertRow, "authmode", 1)
if is_Type = "ALL" then
	if Len(String(itvi_User.Data)) > 0 then
		dw_browse.SetItem(ll_InsertRow, "user_id", String(itvi_User.Data))
	else
		dw_browse.SetItem(ll_InsertRow, "user_id", "MASTER")
	end if

	dw_detail.object.user_id.protect = 0
	dw_detail.object.user_id.background.color = RGB(255,255,255)
else
	dw_browse.SetItem(ll_InsertRow, "user_id", is_UserID)
end if
ls_UserID = dw_browse.GetItemString(ll_InsertRow, "user_id")
dw_browse.SetItem(ll_InsertRow, "account", ls_UserID)
ls_Email = ls_UserID + "@"
dw_browse.SetItem(ll_InsertRow, "email", ls_Email)

// Set default
ll_FindRow = dw_browse.Find("user_id='" + ls_UserID + "' and is_default='Y'", 1, dw_browse.RowCount())
if ll_FindRow <= 0 then
	dw_browse.SetItem(ll_InsertRow, "is_default", "Y")
	of_SetRefEmail(ls_UserID, ls_Email)
else
	dw_browse.SetItem(ll_InsertRow, "is_default", "N")
end if

dw_browse.ScrollToRow(ll_InsertRow)
dw_browse.event rowfocuschanged( ll_InsertRow)//Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
dw_detail.SetColumn("user_id")
dw_detail.SetFocus()
end event

type cb_del from commandbutton within w_email_account_edit
integer x = 2519
integer y = 1552
integer width = 311
integer height = 92
integer taborder = 70
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
ls_UserID = dw_browse.GetItemString(dw_browse.GetRow(), "user_id")
dw_browse.DeleteRow(0)
dw_browse.Event RowFocusChanged(dw_browse.GetRow())

// Set default
ll_FindRow = dw_browse.Find("user_id='" + ls_UserID + "'", 1, dw_browse.RowCount())
if ll_FindRow > 0 then
	ll_DefaultRow = dw_browse.Find("user_id='" + ls_UserID + "' and is_default='Y'", 1, dw_browse.RowCount())
	if ll_DefaultRow <= 0 then
		dw_browse.SetItem(ll_FindRow, "is_default", "Y")
		of_SetRefEmail(ls_UserID, dw_browse.object.email[ll_FindRow])
	end if
else
	of_SetRefEmail(ls_UserID, "")
end if
end event

type tv_user from treeview within w_email_account_edit
integer x = 9
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

