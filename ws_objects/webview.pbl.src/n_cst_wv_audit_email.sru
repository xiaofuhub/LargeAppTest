$PBExportHeader$n_cst_wv_audit_email.sru
forward
global type n_cst_wv_audit_email from nonvisualobject
end type
end forward

global type n_cst_wv_audit_email from nonvisualobject
end type
global n_cst_wv_audit_email n_cst_wv_audit_email

type variables

end variables

forward prototypes
public function integer of_add_email_record (long al_prac_id, integer ai_facility_id, string as_create_user, string as_accept_reject, datetime adt_create_date)
public function integer of_send (string as_accept_reject, long al_facility_id, u_dw adw_emails)
public function integer of_get_wv_audit_data (integer ai_export_id, long al_ae_id, integer al_facility_id, long al_prac_id, ref datastore ads_export)
public function integer of_dddw_field (ref datastore ads_detail)
end prototypes

public function integer of_add_email_record (long al_prac_id, integer ai_facility_id, string as_create_user, string as_accept_reject, datetime adt_create_date);//====================================================================
//$<Function>: of_add_email_record
//$<Arguments>:
// 	value    long        al_prac_id
// 	value    integer     ai_facility_id
// 	value    string      as_create_user
// 	value    string      as_accept_reject
// 	value    datetime    adt_create_date
//$<Return>:  integer -1:get PK failed/ -2:insert failed.
//$<Description>: Insert a record to wv_audit_email table, this record will be used to send email.
//$<Author>: (Appeon) long.zhang 06.30.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_ae_id

//Get PK
SELECT MAX(ae_id) INTO :ll_ae_id FROM wv_audit_email;
If SQLCA.SQLCODE < 0 Then
	Return -1
End If

If IsNull(ll_ae_id) Then
	ll_ae_id = 1
Else
	ll_ae_id ++
End If

//Insert Data
INSERT INTO wv_audit_email (
ae_id,
prac_id,
facility_id,
create_user,
accept_reject, 
sent_status,
create_date,
sent_date,
sent_user)
VALUES
(:ll_ae_id,
:al_prac_id,
:ai_facility_id,
:as_create_user,
:as_accept_reject,
0,
:adt_create_date,
NULL,
NULL);

If SQLCA.SQLNROWS <> 1 Then
	Rollback;
	Return -2
End If

Commit;

Return 1
end function

public function integer of_send (string as_accept_reject, long al_facility_id, u_dw adw_emails);//====================================================================
//$<Function>: of_send
//$<Arguments>:
// 	value    string    as_accept_reject
// 	value    long      al_facility_id
// 	value    u_dw      adw_emails
//$<Return>:  integer 0:canceled/ -1:failed/ 1:successful
//$<Description>: Send WV Audit Email main function.
//$<Author>: (Appeon) long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

pfc_cst_nv_fax nv_emailfax
datastore lds_facility,lds_pd_address
long ll_rowcount1,ll_rowcount2,ll_find
Long ll_rc, i
Long ll_prac_id
Long ll_facility_id
Long ll_cnt
Long ll_ae_ids[]
Long ll_prac_ids[]
Long ll_row_nos[]
Long ll_Return
Long ll_ae_id
String ls_message_title = 'Send WV Audit Email' //delete '"', modified by Appeon long.zhang 07.31.2017 (BugS072404)
String ls_prac_name
String ls_email_addresses[] 
String ls_emp_mail_login
String ls_facility_name
String ls_email_address
String ls_notetext
String ls_subject
String ls_emailcc
String ls_attachments[], ls_null[]
Int li_email_choice
Int li_export_id
Boolean lb_find_from_pd_address = False
gs_pass_ids  lg_pass_ids
	
//1.Check Email address
lds_facility = create datastore
lds_facility.dataobject = 'd_g_facility'
lds_pd_address = create datastore
lds_pd_address.dataobject = 'd_pd_address_pd_address_link'

gnv_appeondb.of_startqueue( )
lds_facility.settransobject(sqlca)
ll_rowcount1 = lds_facility.retrieve()
lds_pd_address.settransobject(sqlca)
ll_rowcount2 = lds_pd_address.retrieve()
gnv_appeondb.of_commitqueue( )

//For Web Version
ll_rowcount1 = lds_facility.rowcount()
ll_rowcount2 = lds_pd_address.rowcount()

//EMAIL From
li_email_choice = gi_email_type
ls_emp_mail_login= gnv_data.of_getitem("security_users","email_id","upper(user_id) = " + "'" + upper(gs_user_id) + "'")
IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
	MessageBox(ls_message_title, "You must setup an email login in the Security User Painter for user: " + gs_user_id )
	Return 0
END IF

ll_facility_id  = al_facility_id

//Loop all emails.
ll_rc = adw_emails.RowCount()
FOR i = 1 TO ll_rc
	IF adw_emails.GetItemNumber( i, "select_flag" )	= 0 THEN
		CONTINUE
	END IF			
	ll_prac_id = adw_emails.GetItemNumber( i, "prac_id" )
	ls_prac_name = adw_emails.GetItemString( i, "v_full_name_full_name" )
	

	//Get Facilty Name
	ll_find = lds_facility.find("facility_id = " + string(ll_facility_id),1,ll_rowcount1)
	if ll_find > 0 then
		ls_facility_name = lds_facility.getitemstring(ll_find,'facility_name')
	else
		MessageBox("Database Error", 'Facility Name not found' )
		Return 0
	END IF

	//Get email address from pd_address
	lb_find_from_pd_address = False
	ll_find = lds_pd_address.find("pd_address_link_prac_id = " + string(ll_prac_id) + " and pd_address_link_facility_id = " + string(ll_facility_id),1,ll_rowcount2)
	if ll_find > 0 then
		ls_email_address = lds_pd_address.getitemstring(ll_find,'pd_address_e_mail_address')
		IF Not(ls_email_address = "" OR IsNull( ls_email_address )) THEN
			lb_find_from_pd_address = True //found in pd_address
		END IF
	END IF
	
	//Find email address from user_security
	If Not lb_find_from_pd_address Then
		ls_email_address = gnv_data.of_getitem("security_users","email_id","prac_id = " +String(ll_prac_id) )
		IF ls_email_address = "" OR IsNull( ls_email_address ) THEN
			MessageBox( ls_message_title, "To send an EMAIL to " + ls_prac_name + " there must be at least one email address:~r~n" +&
					"1) Entered in the office address record that is marked as a MAILING address for the " + ls_facility_name + " facility.~r~n" +&
					"2) Entered in Setup - User Administrator - Email Properties for this provider.")						
			Return 0
		END IF
	End If
	
	//Remember them
	ll_cnt++
	ll_ae_ids[ll_cnt] = adw_emails.GetItemNumber(i, 'ae_id')	
	ls_email_addresses[ll_cnt] = ls_email_address
	ll_prac_ids[ll_cnt] = ll_prac_id
	ll_row_nos[ll_cnt] = i //Row no
END FOR

//Select Email Template ###
OpenWithParm( w_fax_win, "WV_AUDIT_EMAIL" + "-" + String(as_accept_reject))
IF Message.StringParm = "Cancel" THEN	
	Return 0
END IF

lg_pass_ids = Message.PowerObjectParm
ls_notetext = lg_pass_ids.s_fax_message 
ls_subject = lg_pass_ids.s_fax_subject	
ls_emailcc = lg_pass_ids.s_stringval

//Export Id
If as_accept_reject = 'A' Then //WV Audit Accept
	li_export_id = -97
ElseIf as_accept_reject = 'R' Then //WV Audit Reject
	li_export_id = -98
Else
	Return 0
End If

//Loop all ae_ids: Webview audit email Id.
For i =1 to ll_cnt
	ll_prac_id = ll_prac_ids[i]
	ls_email_address = ls_email_addresses[i]
	ll_ae_id = ll_ae_ids[i] 
	
	//Scroll to row
	Yield()
	adw_emails.SelectRow(0, False)
	adw_emails.SelectRow(ll_row_nos[i], True)
	adw_emails.ScrollToRow(ll_row_nos[i])	
	
	ls_attachments = ls_null
		
	//Send Email
	IF li_email_choice = 1 then
		n_cst_outlook lnv_Outlook
		if lnv_Outlook.of_Logon() = -1 then
			MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
			Return -1
		end if

		nv_emailfax = Create pfc_cst_nv_fax	
		ll_Return = nv_emailfax.of_email_new_wv_audit( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ll_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval, ll_ae_id, al_facility_id, li_export_id) 
							
		lnv_Outlook.of_Logoff()
		if ll_Return <> 1 then
			MessageBox("Mail Send", "Mail not sent.")
			destroy nv_emailfax
			Return -2
		end if
		destroy nv_emailfax
	ELSE
		n_cst_easymail_smtp lnv_mail
		
		// Create Email object
		if lnv_mail.of_CreateObject() = -1 then
			f_show_message('create Email object','','','','')
			Return -3
		end if
		
		nv_emailfax = Create pfc_cst_nv_fax	
		ll_Return = nv_emailfax.of_email_new_wv_audit( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ll_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval, ll_ae_id, al_facility_id, li_export_id) 
		if ll_Return <> 1 then
			f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
			lnv_mail.of_DeleteObject()
			destroy nv_emailfax
			Return -4
		end if
		lnv_mail.of_DeleteObject()
		destroy nv_emailfax
	END IF
	
	//Update wv_audit_email table. (update facility id too)
	UPDATE wv_audit_email 
	SET sent_status = 1,
	sent_date = getdate(),
	sent_user = :gs_user_id,
	facility_id = :ll_facility_id
	WHERE ae_id = :ll_ae_id;
	If SQLCA.SQLNROWS <> 1 Then
		Messagebox('of_send', 'Update Sent Status failed.')
		Return -5
	End If
Next

//release the memory.
destroy lds_facility
destroy lds_pd_address

Return 1




end function

public function integer of_get_wv_audit_data (integer ai_export_id, long al_ae_id, integer al_facility_id, long al_prac_id, ref datastore ads_export);//====================================================================
//$<Function>: of_get_wv_audit_data
//$<Arguments>:
// 	value        integer      li_export_id
// 	value        long         il_ae_id
// 	value        integer      il_facility_id
// 	reference    datastore    ads_export
//$<Return>:  integer
//$<Description>: Get data for WV Audit Email Templates. 
//				WV Audit Acceptance (export_id is always -97)
//				WV Audit Rejection (export_id is always -98)
//$<Author>: (Appeon) long.zhang 07.04.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_rtn
Long i, ll_cnt
String ls_data_screen
String ls_data_field
String ls_original_value
String ls_rejected_value

//1.Set dataobject
If ai_export_id = -97 or ai_export_id = -98 Then//WV Audit Acceptance:export_id -97,  WV Audit Rejection: export_id -98
	ads_export.dataobject = 'd_wv_audit_accept_reject_email'
	ads_export.SetTransObject(SQLCA);
Else
	Return -1
End If

//3.retrieve data
ll_rtn = ads_export.retrieve(al_facility_id, al_prac_id)
If ll_rtn <= 0 Then
	Return ll_rtn
End If

//4.Set other reject values using a loop
If ai_export_id = -98 Then //WV Audit Rejection 
	//4.1 Retrieve reject values
	datastore ds_reject
	ds_reject = Create datastore
	ds_reject.dataobject = 'ds_prac_audit_detail_email'
	ds_reject.SetTransObject(SQLCA);
	ll_rtn = ds_reject.Retrieve(al_ae_id)
	If ll_rtn = 0 Then //Failed to retrieve reject data
		Destroy ds_reject
		Return ll_rtn
	End If
	
	//Process dddw
	of_dddw_field(ds_reject)
	
	//4.2 Set values to ads_export.
	ll_cnt = ds_reject.RowCount()
	For i = 1 to ll_cnt
		//30 limitation
		If i > 30 Then Exit
			
		ls_data_screen = ds_reject.GetItemString(i, 'data_view_screen_screen_alias')
		ls_data_field = ds_reject.GetItemString(i, 'sys_fields_field_name_allias')
		ls_original_value = ds_reject.GetItemString(i, 'old_value')
		ls_rejected_value = ds_reject.GetItemString(i, 'new_value')
		
		ads_export.SetItem(1, 'data_screen_'+String(i), ls_data_screen)
		ads_export.SetItem(1, 'data_field__'+String(i), ls_data_field)
		ads_export.SetItem(1, 'original_value_'+String(i), ls_original_value)
		ads_export.SetItem(1, 'rejected_value_'+String(i), ls_rejected_value)
	Next

	Destroy ds_reject
End If



Return 1
end function

public function integer of_dddw_field (ref datastore ads_detail);//====================================================================
//$<Function>: of_dddw_field
//$<Arguments>:
// 	value    datastore    ads_detail
//$<Return>:  integer
//$<Description>: Copied from w_audit_trail.of_dddw_field and modified for datastore ads_detail.
//$<Author>: (Appeon) long.zhang 07.04.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_field_type, ls_lookup_name
long ll_row, ll_rec, ll_j
string ls_lookup_code, ls_lookup_code_old
string ls_field, ls_type, ls_value
string ls_sql, ls_table
datastore lds_lookup_new[]
datastore lds_lookup_old[]
string  ls_syntax, ls_error_create, ls_error_syntax
string ls_lookup_new[],ls_type_list[],ls_lookup_old[]
boolean lb_lookup
string   ls_sel_col

ll_j = 1
for ll_row = 1 to ads_detail.rowcount()
	ls_field_type = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		ads_detail.setitem(ll_row, 'new_value',  ads_detail.getitemstring(ll_row, 'sys_audit_new_value'))
		ads_detail.setitem(ll_row, 'old_value',  ads_detail.getitemstring(ll_row, 'sys_audit_old_value'))
		continue
	end if
	ls_lookup_code = ads_detail.getitemstring(ll_row, 'sys_audit_new_value')
	
	//---------Begin Modified by (Appeon)Stephen 07.10.2015 for Allegheny Issue accepting data from webview audit--------
	//if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	if isnull(ls_lookup_code) or ls_lookup_code = '' then 
		ls_lookup_code = ads_detail.getitemstring(ll_row, 'sys_audit_old_value')
		if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	end if
	ls_lookup_code = ads_detail.getitemstring(ll_row, 'sys_audit_new_value')
	//---------End Modfiied ------------------------------------------------------
	
	ls_type = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	ls_lookup_name = ''
	ls_lookup_name = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	ll_rec = ads_detail.getitemnumber(ll_row, 'sys_audit_rec_id') 
	if ls_type = 'A' then
		ls_table = 'address_lookup' 
		ls_sel_col = 'lookup_code'
		//if ls_lookup_name = 'Description' then ls_lookup_name = 'Entity_Name'
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_table = 'question_lookup'
		ls_sel_col = 'quest_id'
		ls_lookup_name = 'short_quest'
	else
		ls_table = 'code_lookup'
		ls_sel_col = 'lookup_code'
		ls_lookup_name = 'description'
	end if

    //if isnull(ls_lookup_code) then ls_lookup_code =''
	if isnull(ls_lookup_code) or Trim(ls_lookup_code) = '' then ls_lookup_code = '0' //For Error converting data type varchar to numeric db error, Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)
	
	ls_sql = "select " + ls_lookup_name + " from " + ls_table + " where " + ls_sel_col+" = '"+ls_lookup_code+"'"
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql,  'Style(Type=Form)', ls_error_syntax)
	IF Len(ls_error_syntax) > 0 THEN
		messagebox('prompt', ls_error_syntax)
		for ll_j = 1 to upperbound(lds_lookup_new) 
			destroy lds_lookup_new[ll_j]
			destroy lds_lookup_old[ll_j]
		next
		return -1
	ELSE
		 // Generate new DataWindow
		 lds_lookup_new[ll_j] = create datastore
	     lds_lookup_new[ll_j].Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			messagebox('prompt', ls_error_create)
			for ll_j = 1 to upperbound(lds_lookup_new) 
				destroy lds_lookup_new[ll_j]
				destroy lds_lookup_old[ll_j]
			next
			return -1
		END IF
	end if
	ls_lookup_new[ll_j] = ls_lookup_code
	
	ls_lookup_code = ads_detail.getitemstring(ll_row, 'sys_audit_old_value')
	
	//if isnull(ls_lookup_code) then ls_lookup_code = ''
	if isnull(ls_lookup_code) or Trim(ls_lookup_code) = '' then ls_lookup_code = '0' //For Error converting data type varchar to numeric db error, Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)	
	
	ls_sql = "select " + ls_lookup_name + " from " + ls_table +  " where " + ls_sel_col+" = '"+ls_lookup_code+"'"
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql,  'Style(Type=Form)', ls_error_syntax)
	IF Len(ls_error_syntax) > 0 THEN
		messagebox('prompt', ls_error_syntax)
		for ll_j = 1 to upperbound(lds_lookup_old) 
			destroy lds_lookup_new[ll_j]
			destroy lds_lookup_old[ll_j]
		next
		return -1
	ELSE
		 // Generate new DataWindow
		 lds_lookup_old[ll_j] = create datastore
	     lds_lookup_old[ll_j].Create(ls_syntax, ls_error_create)
		IF Len(ls_error_create) > 0 THEN
			messagebox('prompt', ls_error_create)
			for ll_j = 1 to upperbound(lds_lookup_old) 
				destroy lds_lookup_new[ll_j]
				destroy lds_lookup_old[ll_j]
			next
			return -1
		END IF
	end if

	ls_lookup_old[ll_j] = ls_lookup_code
	ls_type_list[ll_j] = ls_type
	ll_j++
next

gnv_appeondb.of_startqueue()
for ll_j = 1 to upperbound(ls_type_list)
	lds_lookup_new[ll_j].settransobject(sqlca)
	lds_lookup_old[ll_j].settransobject(sqlca)
	
	lds_lookup_new[ll_j].retrieve()
	lds_lookup_old[ll_j].retrieve()
next
gnv_appeondb.of_CommitQueue()

for ll_row = 1 to ads_detail.rowcount()
	ls_field_type = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		ads_detail.setitem(ll_row, 'new_value',  ads_detail.getitemstring(ll_row, 'sys_audit_new_value'))
		ads_detail.setitem(ll_row, 'old_value',  ads_detail.getitemstring(ll_row, 'sys_audit_old_value'))
		continue
	end if
	ls_lookup_code = ads_detail.getitemstring(ll_row, 'sys_audit_new_value')
	ls_lookup_code_old = ads_detail.getitemstring(ll_row, 'sys_audit_old_value')  //add by stephen 03.27.2012 -fax bug BugS032701
	//---------Begin Modified by (Appeon)Stephen 02.03.2017 for Bug id 5483 - WebView Audit Values not showing--------
	//if isnull(ls_lookup_code) then ls_lookup_code = '' 
	//if isnull(ls_lookup_code_old) then ls_lookup_code_old = '' 
	if isnull(ls_lookup_code) or ls_lookup_code = ''  then ls_lookup_code = '0'
	if isnull(ls_lookup_code_old) or ls_lookup_code_old = ''  then ls_lookup_code_old = '0'
	//---------End Modfiied ------------------------------------------------------
	
	ls_type = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	ls_lookup_name = ads_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	if ls_type = 'A' then
		//if ls_lookup_name = 'Description' then ls_lookup_name = 'Entity_Name'
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_lookup_name = 'short_quest'
	else
		ls_lookup_name = 'description'
	end if
	
	lb_lookup = false
	for ll_j = 1 to upperbound(ls_type_list)
		if ls_lookup_code = ls_lookup_new[ll_j] and ls_type = ls_type_list[ll_j] and ls_lookup_code_old = ls_lookup_old[ll_j] then
			lb_lookup = true
			exit
		end if
	next
	
	if lb_lookup = false then continue
	if lds_lookup_new[ll_j].rowcount() > 0 then
		ls_value = lds_lookup_new[ll_j].getitemstring(1,ls_lookup_name)
		ads_detail.setitem(ll_row, 'new_value', ls_value)
	end if
	
	
	if lds_lookup_old[ll_j].rowcount() > 0 then
		ls_value = lds_lookup_old[ll_j].getitemstring(1,ls_lookup_name)
		ads_detail.setitem(ll_row, 'old_value', ls_value)
	end if
next

for ll_j = 1 to upperbound(lds_lookup_old) 
	destroy lds_lookup_new[ll_j]
	destroy lds_lookup_old[ll_j]
next
			
return 1
end function

on n_cst_wv_audit_email.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_wv_audit_email.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

