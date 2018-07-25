$PBExportHeader$w_wv_user_edit.srw
forward
global type w_wv_user_edit from window
end type
type st_2 from statictext within w_wv_user_edit
end type
type st_1 from statictext within w_wv_user_edit
end type
type dw_facility from u_dw within w_wv_user_edit
end type
type dw_view from u_dw within w_wv_user_edit
end type
type sle_ldap_user from singlelineedit within w_wv_user_edit
end type
type st_ldap_user from statictext within w_wv_user_edit
end type
type st_audit_type from statictext within w_wv_user_edit
end type
type st_notes from statictext within w_wv_user_edit
end type
type st_4 from statictext within w_wv_user_edit
end type
type st_select_role from statictext within w_wv_user_edit
end type
type st_password from statictext within w_wv_user_edit
end type
type st_user_id from statictext within w_wv_user_edit
end type
type cb_close from commandbutton within w_wv_user_edit
end type
type cb_save from commandbutton within w_wv_user_edit
end type
type gb_account_detail from groupbox within w_wv_user_edit
end type
type gb_audit_type from groupbox within w_wv_user_edit
end type
type cb_browse from commandbutton within w_wv_user_edit
end type
type gb_ldap_user from groupbox within w_wv_user_edit
end type
type dw_user from datawindow within w_wv_user_edit
end type
type gb_1 from groupbox within w_wv_user_edit
end type
type gb_4 from groupbox within w_wv_user_edit
end type
end forward

global type w_wv_user_edit from window
integer width = 2798
integer height = 1692
boolean titlebar = true
string title = "User Edit"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
dw_facility dw_facility
dw_view dw_view
sle_ldap_user sle_ldap_user
st_ldap_user st_ldap_user
st_audit_type st_audit_type
st_notes st_notes
st_4 st_4
st_select_role st_select_role
st_password st_password
st_user_id st_user_id
cb_close cb_close
cb_save cb_save
gb_account_detail gb_account_detail
gb_audit_type gb_audit_type
cb_browse cb_browse
gb_ldap_user gb_ldap_user
dw_user dw_user
gb_1 gb_1
gb_4 gb_4
end type
global w_wv_user_edit w_wv_user_edit

type variables
string is_Style
string is_AuthType
string is_user_id
long il_prac_id

long il_max_user_facility_id
long il_max_user_view_id
boolean ib_security_user_changed = false

datastore ids_security_user
datastore ids_facility_all
datastore ids_data_view_all
end variables

forward prototypes
public function integer of_fillfields (ref datawindowchild adwc_role)
public function string of_getuserid (long al_prac_id)
public function integer of_uiadjust ()
public function integer of_save ()
public function integer of_save_new ()
end prototypes

public function integer of_fillfields (ref datawindowchild adwc_role);////////////////////////////////////////////////////////////////////////
//// $<function> of_FillFields
//// $<arguments>
////		ref datawindowchild	adwc_role
//// $<returns> integer
//// $<description> Fill fields
////////////////////////////////////////////////////////////////////////
//// $<add> 03.05.2012 by Evan
////////////////////////////////////////////////////////////////////////
//
//long ll_row
//long ll_role_id
//datetime ldt_expiration_date
//
//sle_user_id.Text = is_user_id
//if ids_security_user.RowCount() > 0 then
//	ll_role_id = ids_security_user.GetItemNumber(1, "wv_role_id")
//	ldt_expiration_date = ids_security_user.GetItemDateTime(1, "expiration_date")
//	sle_password.Text = ids_security_user.GetItemString(1, "user_password")
//	sle_ldap_user.Text = ids_security_user.GetItemString(1, "wv_ldap_user")
//else
//	SetNull(ldt_expiration_date)
//	sle_password.Text = "123"
//end if
//if not IsNull(ldt_expiration_date) then
//	cbx_never_expires.Checked = false
//	em_expiration_date.Text = String(ldt_expiration_date, "mm/dd/yyyy")
//	em_expiration_date.Enabled = true
//else
//	cbx_never_expires.Checked = true
//	em_expiration_date.Enabled = false
//end if
//	
//// User/Practitioner role
//if is_Style = "Practitioner" then
//	if ids_security_user.RowCount() > 0 then
//		dw_select_role.SetItem(1, "role_id", ll_role_id)
//	else
//		ll_row = adwc_role.Find("role_name = 'Practitioner'", 1, adwc_role.RowCount())
//		if ll_row > 0 then
//			dw_select_role.SetItem(1, "role_id", adwc_role.GetItemNumber(ll_row, "role_id"))
//		end if
//	end if
//elseif is_Style = "User" and ids_security_user.RowCount() > 0 then
//	dw_select_role.SetItem(1, "role_id", ll_role_id)
//end if
//adwc_role.InsertRow(1)

// Data Entry Auditing
//dw_audit_type.Event ue_Init()

Return 1
end function

public function string of_getuserid (long al_prac_id);//////////////////////////////////////////////////////////////////////
// $<function> of_GetUserId
// $<arguments>
//		value long	al_prac_id
// $<returns> string
// $<description> Get user id for practitioner user
//////////////////////////////////////////////////////////////////////
// $<add> 03.05.2012 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Count
string ls_user_id
string ls_first_name
string ls_last_name
string ls_like_value
n_cst_string lnv_string

gnv_appeondb.of_StartQueue()
SELECT user_id INTO :ls_user_id FROM security_users WHERE prac_id = :al_prac_id;
SELECT first_name, last_name INTO :ls_first_name, :ls_last_name FROM pd_basic WHERE prac_id = :al_prac_id;
gnv_appeondb.of_CommitQueue()

if IsNull(ls_user_id) or ls_user_id = "" then
	ls_user_id = Left(ls_first_name, 1) + Left(ls_last_name, 9)
	ls_user_id = Lower(ls_user_id)
	ls_user_id = lnv_string.of_GlobalReplace(ls_user_id, "'", "")
	ls_like_value = ls_user_id + "%"
	SELECT count(*) INTO :ll_Count FROM security_users WHERE user_id LIKE :ls_like_value;
	if ll_Count > 0 then ls_user_id += String(ll_Count)
end if

Return ls_user_id
end function

public function integer of_uiadjust ();//////////////////////////////////////////////////////////////////////
// $<function> of_UIAdjust
// $<arguments>
// $<returns> integer
// $<description> UI Adjust
//////////////////////////////////////////////////////////////////////
// $<add> 03.06.2012 by Evan
//////////////////////////////////////////////////////////////////////

if is_AuthType = "systemdb" then
//	gb_ldap_user.Hide()
//	st_ldap_user.Hide()
//	sle_ldap_user.Hide()
//	cb_browse.Hide()
//	gb_audit_type.Width = gb_account_detail.Width
//	dw_audit_type.Width = 2670
//	dw_audit_type.Modify("audit_type.width = 2645")
//else
//	gb_ldap_user.Show()
//	st_ldap_user.Show()
//	sle_ldap_user.Show()
//	
//	if is_AuthType = "windows" then
//		sle_ldap_user.Width = 786
//		sle_ldap_user.DisplayOnly = false
//		cb_browse.Hide()
//		st_ldap_user.Text = "Windows User ID:"
//	else
//		sle_ldap_user.Width = 704
//		sle_ldap_user.DisplayOnly = true
//		cb_browse.Show()
//		st_ldap_user.Text = "LDAP User ID:"
//	end if
//	dw_audit_type.Width = 1810
//	dw_audit_type.Modify("audit_type.width = 1778")
end if

Return 1
end function

public function integer of_save ();////////////////////////////////////////////////////////////////////////
//// $<function> of_Save
//// $<arguments>
//// $<returns> integer
//// $<description> Save
////////////////////////////////////////////////////////////////////////
//// $<add> 03.08.2012 by Evan
////////////////////////////////////////////////////////////////////////
//
//date ldt_date
//datetime ldt_expiration_date
//long ll_wv_role_id, ll_audit_type
//long ll_PracUserRec_RecordCount
//long ll_default_search_facility
//string ls_check_user_id1, ls_check_user_id2
//string ls_old_user_id, ls_new_user_id, ls_ldap_user
//
//// Get updated information
//ls_new_user_id = sle_user_id.Text
//ls_ldap_user = sle_ldap_user.Text
//ll_wv_role_id = dw_select_role.GetItemNumber(1, "role_id")
//ll_audit_type = dw_audit_type.GetItemNumber(1, "audit_type")
//if cbx_never_expires.Checked then
//	SetNull(ldt_expiration_date)
//else
//	em_expiration_date.GetData(ldt_date)
//	if ldt_date = 1900-01-01 then
//		SetNull(ldt_expiration_date)
//	else
//		ldt_expiration_date = DateTime(ldt_date, 00:00:00)
//	end if
//end if
//ll_PracUserRec_RecordCount = ids_security_user.RowCount()
//if ll_PracUserRec_RecordCount > 0 then
//	ls_old_user_id = ids_security_user.GetItemString(1, "user_id")
//end if
//
//// Check user name and LDAP user name, get max id
//gnv_appeondb.of_StartQueue()
//SELECT user_id INTO :ls_check_user_id1 FROM security_users WHERE user_id = :ls_new_user_id;
//SELECT user_id INTO :ls_check_user_id2 FROM security_users WHERE wv_ldap_user = :ls_ldap_user;
//SELECT user_facility_id, user_view_id INTO :il_max_user_facility_id, :il_max_user_view_id FROM ids;
//gnv_appeondb.of_CommitQueue()
//if is_Style = "Practitioner" then
//	if Len(ls_check_user_id1) > 0 and ls_check_user_id1 <> ls_old_user_id then
//		MessageBox("Prompt", "The user name you have selected is on file for another user. Please select another one.", Exclamation!);
//		sle_user_id.SetFocus()
//		Return -1
//	end if
//end if
//if is_AuthType <> "systemdb" and Trim(ls_ldap_user) <> "" then
//	if Len(ls_check_user_id2) > 0 and ls_check_user_id2 <> ls_old_user_id then
//		if is_AuthType = "ldap" then
//			MessageBox("Prompt", "Specified LDAP User Name [" + ls_ldap_user + "] has been linked to another WebView user. It must be unique. Please select another one.", Exclamation!);
//		else
//			MessageBox("Prompt", "Specified Windows User Name [" + ls_ldap_user + "] has been linked to another WebView user. It must be unique. Please select another one.", Exclamation!);
//		end if
//		sle_ldap_user.SetFocus()
//		Return -1
//	end if
//end if
//
//// Update security user
//gnv_appeondb.of_StartQueue()
//if ll_PracUserRec_RecordCount > 0 then	
//	// Modify security_users
//	if ib_security_user_changed then
//		if is_AuthType = "systemdb" then
//			UPDATE security_users SET
//				wv_role_id = :ll_wv_role_id,
//				user_id = :ls_new_user_id,
//				audit_type = :ll_audit_type,
//				expiration_date = :ldt_expiration_date
//			WHERE user_id = :ls_old_user_id;
//		else
//			UPDATE security_users SET
//				wv_role_id = :ll_wv_role_id,
//				user_id = :ls_new_user_id,
//				audit_type = :ll_audit_type,
//				expiration_date = :ldt_expiration_date,
//				wv_ldap_user = :ls_ldap_user 
//			WHERE user_id = :ls_old_user_id;
//		end if
//	end if
//	
//	if ls_old_user_id <> ls_new_user_id then
//		UPDATE security_login_tracking SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE security_user_views SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE security_user_facilities SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE security_user_department SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE sys_audit SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE sys_user_version SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE wv_report_que_det SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE wv_setting_audit_log SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE wv_letter_audit_log SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE esign SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE e_signature SET user_id = :ls_new_user_id WHERE user_id = :ls_old_user_id;
//		UPDATE wv_security_user SET logon_id = :ls_new_user_id WHERE logon_id = :ls_old_user_id;
//	end if
//else // New security_users
//	if is_AuthType = "systemdb" then
//		INSERT INTO security_users (prac_id, user_id, user_password, wv_role_id, audit_type, expiration_date, default_search_facility)
//				VALUES (:il_prac_id, :ls_new_user_id, '123', :ll_wv_role_id, :ll_audit_type, :ldt_expiration_date, 1);
//	else
//		INSERT INTO security_users (prac_id, user_id, user_password, wv_role_id, audit_type, expiration_date, default_search_facility, wv_ldap_user)
//				VALUES (:il_prac_id, :ls_new_user_id, '123', :ll_wv_role_id, :ll_audit_type, :ldt_expiration_date, 1, :ls_ldap_user);
//	end if
//end if
//
//// Update security facility, view and max id
//dw_facility.Event ue_Update()
//dw_view.Event ue_Update()
//if dw_facility.Tag = "New!" or dw_view.Tag = "New!" then
//	UPDATE ids SET user_facility_id = :il_max_user_facility_id, user_view_id = :il_max_user_view_id;
//end if
//COMMIT;
//gnv_appeondb.of_CommitQueue()
//
Return 1
end function

public function integer of_save_new (); //Start Code Change ----04.04.2017 #V153 maha - copied from of save and modified

date ldt_date
datetime ldt_expiration_date
long ll_wv_role, ll_audit_type
long ll_PracUserRec_RecordCount
long ll_default_search_facility
string ls_check_user_id1, ls_check_user_id2
string ls_user_id, ls_new_user_id, ls_ldap_user
boolean lb_failed = false

// Get updated information
ls_user_id = dw_user.getitemstring(1,"user_id")
ls_ldap_user = dw_user.getitemstring(1,"wv_ldap_user" )
ll_wv_role = dw_user.GetItemNumber(1, "wv_role_id")
ll_audit_type = dw_user.GetItemNumber(1, "audit_type")
ll_wv_role = dw_user.GetItemNumber(1, "default_view")

if isnull(ll_wv_role) then
	messagebox("Incomplete Data",  "WebView role is required.")
	lb_failed = true
end if

if isnull(ll_audit_type) then
	messagebox("Incomplete Data",  "Audit Type is required.")
	lb_failed = true
end if

if isnull(ll_wv_role) then
	messagebox("Incomplete Data",  "Webview View  is required.")
	lb_failed = true
end if

if lb_failed then return -1

// Check user name and LDAP user name, get max id
gnv_appeondb.of_StartQueue()
//SELECT user_id INTO :ls_check_user_id1 FROM security_users WHERE user_id = :ls_user_id;
SELECT user_id INTO :ls_check_user_id2 FROM security_users WHERE wv_ldap_user = :ls_ldap_user;
SELECT user_facility_id, user_view_id INTO :il_max_user_facility_id, :il_max_user_view_id FROM ids;
gnv_appeondb.of_CommitQueue()

//if Trim(ls_ldap_user) <> "" then
//	if Len(ls_check_user_id2) > 0 and ls_check_user_id2 <> ls_user_id then
//		if is_AuthType = "ldap" then
//			MessageBox("Prompt", "Specified LDAP User Name [" + ls_ldap_user + "] has been linked to another WebView user. It must be unique. Please select another one.", Exclamation!);
//		else
//			MessageBox("Prompt", "Specified Windows User Name [" + ls_ldap_user + "] has been linked to another WebView user. It must be unique. Please select another one.", Exclamation!);
//		end if
//		sle_ldap_user.SetFocus()
//		Return -1
//	end if
//end if

// Update security user
gnv_appeondb.of_StartQueue()

// Update security facility, view and max id
dw_facility.Event ue_Update()
dw_view.Event ue_Update()
dw_user.update()

gnv_appeondb.of_CommitQueue()

Return 1
end function

on w_wv_user_edit.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_facility=create dw_facility
this.dw_view=create dw_view
this.sle_ldap_user=create sle_ldap_user
this.st_ldap_user=create st_ldap_user
this.st_audit_type=create st_audit_type
this.st_notes=create st_notes
this.st_4=create st_4
this.st_select_role=create st_select_role
this.st_password=create st_password
this.st_user_id=create st_user_id
this.cb_close=create cb_close
this.cb_save=create cb_save
this.gb_account_detail=create gb_account_detail
this.gb_audit_type=create gb_audit_type
this.cb_browse=create cb_browse
this.gb_ldap_user=create gb_ldap_user
this.dw_user=create dw_user
this.gb_1=create gb_1
this.gb_4=create gb_4
this.Control[]={this.st_2,&
this.st_1,&
this.dw_facility,&
this.dw_view,&
this.sle_ldap_user,&
this.st_ldap_user,&
this.st_audit_type,&
this.st_notes,&
this.st_4,&
this.st_select_role,&
this.st_password,&
this.st_user_id,&
this.cb_close,&
this.cb_save,&
this.gb_account_detail,&
this.gb_audit_type,&
this.cb_browse,&
this.gb_ldap_user,&
this.dw_user,&
this.gb_1,&
this.gb_4}
end on

on w_wv_user_edit.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_facility)
destroy(this.dw_view)
destroy(this.sle_ldap_user)
destroy(this.st_ldap_user)
destroy(this.st_audit_type)
destroy(this.st_notes)
destroy(this.st_4)
destroy(this.st_select_role)
destroy(this.st_password)
destroy(this.st_user_id)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.gb_account_detail)
destroy(this.gb_audit_type)
destroy(this.cb_browse)
destroy(this.gb_ldap_user)
destroy(this.dw_user)
destroy(this.gb_1)
destroy(this.gb_4)
end on

event open;//====================================================================
// $<event> open()
// $<arguments>
// $<returns> long
// $<description> Open event
// $<add> (Appeon) evan 03.05.2012
//====================================================================

string ls_Parm[]
n_cst_string lnv_string
datawindowchild ldwc_role

// Get parameters
lnv_string.of_ParseToArray(Message.StringParm, "|", ls_Parm)
is_Style = ls_Parm[1]
is_AuthType = ls_Parm[3]

of_UIAdjust()
//choose case is_Style
//	case "User"
//		SetNull(il_prac_id)
		is_user_id = ls_Parm[2]
//		this.Title = "User Account Management"
//		st_notes.Text = "Please note: User Logon Id and User Password cannot be changed here."
//		st_user_id.Text = "User Logon Id:"
//		st_password.Text = "User Password:"
//		st_select_role.Text = "User Role:"
//		st_audit_type.Text = "User's Data Entry Auditing Level:"
//		sle_user_id.Enabled = false
//	case "Practitioner"
//		il_prac_id = Long(ls_Parm[2])
//		this.Title = "Practitioner Account Management"
//		st_notes.Text = "Please note: User Password cannot be changed here."
//		st_user_id.Text = "Practitioner Logon Id:"
//		st_password.Text = "Practitioner Password:"
//		st_select_role.Text = "Practitioner Role:"
//		st_audit_type.Text = "Practitioner's Data Entry Auditing Level:"
//		sle_user_id.Enabled = true
//		is_user_id = of_GetUserId(il_prac_id)
//end choose

// Retrieve user information
ids_security_user = Create datastore
ids_security_user.DataObject = "d_wv_security_user"
ids_security_user.SetTransObject(SQLCA)
//dw_select_role.GetChild("role_id", ldwc_role)
ldwc_role.SetTransObject(SQLCA)
ids_facility_all = Create datastore
ids_facility_all.DataObject = "d_facility_all"
ids_facility_all.SetTransObject(SQLCA)
ids_data_view_all = Create datastore
ids_data_view_all.DataObject = "d_data_view_list"
ids_data_view_all.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
ids_security_user.Retrieve(is_user_id)
ldwc_role.Retrieve()
dw_facility.Retrieve(is_user_id)
dw_view.Retrieve(is_user_id)
ids_facility_all.Retrieve()
ids_data_view_all.Retrieve()
gnv_appeondb.of_CommitQueue()
of_FillFields(ldwc_role)

dw_user.retrieve(is_user_id)   //Start Code Change ----04.04.2017 #V153 maha

// Initialize facility and view if is new
if dw_facility.RowCount() = 0 then
	dw_facility.Event ue_Init()
end if
if dw_view.RowCount() = 0 then
	dw_view.Event ue_Init()
end if
end event

event close;//====================================================================
// $<event> close()
// $<arguments>
// $<returns> long
// $<description> Close event
// $<add> (Appeon) evan 03.06.2012
//====================================================================

if IsValid(ids_security_user) then Destroy ids_security_user
if IsValid(ids_facility_all) then Destroy ids_facility_all
if IsValid(ids_data_view_all) then Destroy ids_data_view_all
end event

type st_2 from statictext within w_wv_user_edit
integer x = 1417
integer y = 636
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "View Access:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_wv_user_edit
integer x = 78
integer y = 628
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Facility Access:"
boolean focusrectangle = false
end type

type dw_facility from u_dw within w_wv_user_edit
event type integer ue_update ( )
event type integer ue_init ( )
string tag = "Modify!"
integer x = 73
integer y = 700
integer width = 1307
integer height = 848
integer taborder = 100
boolean bringtotop = true
string title = "Facility Access"
string dataobject = "d_wv_security_user_facility_access"
end type

event type integer ue_update();//====================================================================
// $<event> ue_update()
// $<arguments>
// $<returns> integer
// $<description> Update facility
// $<add> (Appeon) evan 03.07.2012
//====================================================================

long ll_Row
string ls_old_user_id
string ls_new_user_id
boolean lb_DoUpdate = false

if IsNull(il_max_user_facility_id) then il_max_user_facility_id = 0

// Set values for security user facilities

// Update data
if lb_DoUpdate then
	this.Update()
end if

Return 1
end event

event type integer ue_init();//====================================================================
// $<event> ue_init()
// $<arguments>
// $<returns> integer
// $<description> Initialize records
// $<add> (Appeon) evan 03.08.2012
//====================================================================

long ll_Row

this.Tag = "New!"

ids_facility_all.SetSort("facility_name A")
ids_facility_all.Sort()

for ll_Row = 1 to ids_facility_all.RowCount()
	this.InsertRow(0)
	this.SetItem(ll_Row, "facility_id", ids_facility_all.object.facility_id[ll_Row])
	this.SetItem(ll_Row, "facility_facility_name", ids_facility_all.object.facility_name[ll_Row])
	this.SetItem(ll_Row, "access_rights", 0)
next

Return 1
end event

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 03.05.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

type dw_view from u_dw within w_wv_user_edit
event type integer ue_update ( )
event type integer ue_init ( )
string tag = "Modify!"
integer x = 1413
integer y = 700
integer width = 1307
integer height = 848
integer taborder = 110
boolean bringtotop = true
string title = "View Access"
string dataobject = "d_wv_security_user_views_access"
end type

event type integer ue_update();//====================================================================
// $<event> ue_update()
// $<arguments>
// $<returns> integer
// $<description> Update view
// $<add> (Appeon) evan 03.08.2012
//====================================================================

long ll_Row
string ls_old_user_id
string ls_new_user_id
boolean lb_DoUpdate = false

if IsNull(il_max_user_view_id) then il_max_user_view_id = 0

// Set values for security user views
this.SetFilter("")
this.Filter()

//if this.Tag = "New!" then
//	for ll_Row = 1 to this.RowCount()
//		lb_DoUpdate = true
//		il_max_user_view_id ++
//		this.SetItem(ll_Row, "user_view_id", il_max_user_view_id)
//		this.SetItem(ll_Row, "user_id", sle_user_id.Text)
//	next
//else
//	ls_new_user_id = sle_user_id.Text
//	if ids_security_user.RowCount() > 0 then
//		ls_old_user_id = ids_security_user.GetItemString(1, "user_id")
//	end if
//	if ls_old_user_id <> ls_new_user_id then
//		for ll_Row = 1 to this.RowCount()
//			this.SetItem(ll_Row, "user_id", sle_user_id.Text)
//		next
//	end if
//	if this.ModifiedCount() > 0 then lb_DoUpdate = true
//end if

// Update data
if lb_DoUpdate then
	this.Update()
end if

Return 1
end event

event type integer ue_init();//====================================================================
// $<event> ue_init()
// $<arguments>
// $<returns> integer
// $<description> Initialize records
// $<add> (Appeon) evan 03.08.2012
//====================================================================

long ll_Row

this.Tag = "New!"

ids_data_view_all.SetSort("data_view_name A")
ids_data_view_all.Sort()

for ll_Row = 1 to ids_data_view_all.RowCount()
	this.InsertRow(0)
	this.SetItem(ll_Row, "view_id", ids_data_view_all.object.data_view_id[ll_Row])
	this.SetItem(ll_Row, "data_view_data_view_name", ids_data_view_all.object.data_view_name[ll_Row])
	this.SetItem(ll_Row, "data_view_type_c", ids_data_view_all.object.type_c[ll_Row])
	this.SetItem(ll_Row, "access_rights", 0)
next
this.SetFilter("data_view_type_c = 'P'")
this.Filter()

Return 1
end event

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 03.05.2012
//====================================================================

this.SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
end event

type sle_ldap_user from singlelineedit within w_wv_user_edit
integer x = 2907
integer y = 552
integer width = 704
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event rbuttondown;int li_rc

if Len(this.Text) > 0 and is_AuthType = "ldap" then
	li_rc = MessageBox("Prompt", "Are you sure you want to clear the LDAP User ID?", Question!, YesNo!)
	if li_rc = 1 then
		this.Text = ""
		ib_security_user_changed = true
	end if
end if
end event

event modified;ib_security_user_changed = true
end event

type st_ldap_user from statictext within w_wv_user_edit
integer x = 2866
integer y = 412
integer width = 453
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Windows User ID:"
boolean focusrectangle = false
end type

type st_audit_type from statictext within w_wv_user_edit
integer x = 160
integer y = 2192
integer width = 1760
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User~'s Data Entry Auditing Level:"
boolean focusrectangle = false
end type

type st_notes from statictext within w_wv_user_edit
integer x = 55
integer y = 2156
integer width = 2437
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Detail notes"
boolean focusrectangle = false
end type

type st_4 from statictext within w_wv_user_edit
integer x = 1970
integer y = 1984
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Account Expires:"
boolean focusrectangle = false
end type

type st_select_role from statictext within w_wv_user_edit
integer x = 1221
integer y = 1984
integer width = 718
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Role:"
boolean focusrectangle = false
end type

type st_password from statictext within w_wv_user_edit
integer x = 635
integer y = 1984
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Password:"
boolean focusrectangle = false
end type

type st_user_id from statictext within w_wv_user_edit
integer x = 55
integer y = 1984
integer width = 562
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Logon Id:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_wv_user_edit
integer x = 2318
integer y = 28
integer width = 425
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 03.05.2012
//====================================================================

Close(Parent)
end event

type cb_save from commandbutton within w_wv_user_edit
integer x = 1861
integer y = 28
integer width = 425
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Save
// $<add> (Appeon) evan 03.07.2012
//====================================================================

long ll_Row
string ls_role_name
datawindow ldw_browse

if of_Save_new() = 1 then
	// Refresh browse data window
//	ldw_browse = w_wv_user_painter.dw_browse
//	ll_Row = ldw_browse.GetRow()
//	if is_Style = "User" then
//		ls_role_name = dw_select_role.Event ue_GetRoleName()
//		ldw_browse.SetItem(ll_Row, "role_name", ls_role_name)
//		ldw_browse.SetItem(ll_Row, "wv_ldap_user", sle_ldap_user.Text)
//	else
//		ldw_browse.SetItem(ll_Row, "user_id", sle_user_id.Text)
//		ldw_browse.SetItem(ll_Row, "wv_ldap_user", sle_ldap_user.Text)
//	end if
	
	// Close edit window
	Close(Parent)
end if
end event

type gb_account_detail from groupbox within w_wv_user_edit
integer x = 9
integer y = 1904
integer width = 2734
integer height = 328
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Account Detail"
end type

type gb_audit_type from groupbox within w_wv_user_edit
integer x = 114
integer y = 2116
integer width = 1861
integer height = 256
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Entry Auditing"
end type

type cb_browse from commandbutton within w_wv_user_edit
integer x = 3278
integer y = 660
integer width = 91
integer height = 88
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Select LDAP user
// $<add> (Appeon) evan 03.07.2012
//====================================================================

string ls_ldap_user

OpenWithParm(w_wv_select_ldap_user, sle_ldap_user.Text)

ls_ldap_user = Message.StringParm
if Len(ls_ldap_user) > 0 then
	sle_ldap_user.Text = ls_ldap_user
	ib_security_user_changed = true
end if
end event

type gb_ldap_user from groupbox within w_wv_user_edit
integer x = 2862
integer y = 312
integer width = 850
integer height = 256
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "LDAP Linked User"
end type

type dw_user from datawindow within w_wv_user_edit
integer x = 59
integer y = 176
integer width = 2651
integer height = 340
integer taborder = 140
string title = "none"
string dataobject = "d_security_user_setup_wv_non_prac"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event buttonclicked;messagebox("Password Expires", "Clearing the Expiring date will only be effective if the system Expiration days setting is turned off.")
end event

type gb_1 from groupbox within w_wv_user_edit
integer x = 32
integer y = 572
integer width = 2734
integer height = 1004
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Access"
end type

type gb_4 from groupbox within w_wv_user_edit
integer x = 32
integer y = 112
integer width = 2734
integer height = 432
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Account Settings"
end type

