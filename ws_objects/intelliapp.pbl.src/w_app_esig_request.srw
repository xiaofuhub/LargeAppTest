$PBExportHeader$w_app_esig_request.srw
forward
global type w_app_esig_request from w_response
end type
type ole_message from u_email_edit within w_app_esig_request
end type
type cb_custom from commandbutton within w_app_esig_request
end type
type cb_cancel from commandbutton within w_app_esig_request
end type
type dw_doc from u_dw within w_app_esig_request
end type
type dw_1 from u_dw within w_app_esig_request
end type
type cb_send from commandbutton within w_app_esig_request
end type
end forward

global type w_app_esig_request from w_response
integer width = 2921
integer height = 1716
string title = "Check Out – Send For Electronic Signature"
long backcolor = 33551856
ole_message ole_message
cb_custom cb_custom
cb_cancel cb_cancel
dw_doc dw_doc
dw_1 dw_1
cb_send cb_send
end type
global w_app_esig_request w_app_esig_request

type variables
str_ctx_email istr_ctx_email
n_cst_dm_utils inv_dm_utils
Datawindowchild idwc_email_template
Long il_last_export_id
DataStore ids_export
n_cst_filesrvwin32 inv_filesrv
n_cst_string inv_string

end variables

forward prototypes
public function integer of_download_doc ()
public subroutine of_set_documents ()
public function integer of_set_sertifi ()
public function integer of_check_data ()
public function integer of_set_message (long al_email_id)
protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, str_alarm_user astr_alarm_user)
end prototypes

public function integer of_download_doc ();Long i
String ls_pathfile[]

//Download Documents
If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Downloading the document(s)...")
inv_dm_utils.of_download_multi_files( istr_ctx_email.doc_id_list[], istr_ctx_email.revision_list[], ls_pathfile[])
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

//Check document
For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
	If Not FileExists(ls_pathfile[i]) Then
		Messagebox('Check Document','Failed to download the document (doc_id = '+String(istr_ctx_email.doc_id_list[i])+', revision = '+String(istr_ctx_email.revision_list[i])+')')
		Return -1
	End If
Next

istr_ctx_email.pathfilename_list[] = ls_pathfile[]

Return 1

end function

public subroutine of_set_documents ();Long i,ll_row
For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
	ll_row = dw_doc.InsertRow(0)
	dw_doc.SetItem(ll_row,'need_signed',1)
	dw_doc.SetItem(ll_row,'docname',istr_ctx_email.fullfilename_list[i])
	dw_doc.SetItem(ll_row,'ctx_id',istr_ctx_email.ctx_id_list[i])
	dw_doc.SetItem(ll_row,'doc_id',istr_ctx_email.doc_id_list[i])
	dw_doc.SetItem(ll_row,'revision',istr_ctx_email.revision_list[i])
Next


end subroutine

public function integer of_set_sertifi ();String ls_companyname,ls_filename
Long ll_ctx_id

If Not gnv_sertifi.of_check_sertifi( ) Then Return -1  

ll_ctx_id = istr_ctx_email.ctx_id_list[1]

Select A.facility_name Into :ls_companyname
From ctx_basic_info C Left Outer Join app_facility A On C.app_facility = A.facility_id
Where C.ctx_id = :ll_ctx_id;

If ls_companyname = '' or isnull(ls_companyname) Then
	ls_filename = 'Contract ' + String(ll_ctx_id) 
Else
	ls_filename = ls_companyname + ' Contract ' + String(ll_ctx_id) 
End If

dw_1.SetItem(1, 'assign_to', gs_user_id)
dw_1.SetItem(1, 'mail_from', gnv_sertifi.is_emailaddress )
dw_1.SetItem(1, 'due_date',  RelativeDate(today(), 10) )
dw_1.SetItem(1, 'filename',  ls_filename )

Return 1

end function

public function integer of_check_data ();String ls_filename,ls_signer,ls_myemail,ls_sec_signer

//Check File Name
ls_filename = dw_1.GetItemString(1,'filename')
If ls_filename = '' or isnull(ls_filename) Then
	Messagebox('Check','Please input the file name.')
	dw_1.Setcolumn('filename')
	dw_1.SetFocus()
	Return -1
End If

//Check Document
If dw_doc.rowcount() <= 0 Then
	Messagebox('Document','The document list is empty, please select a document and then check out again.')
	Return -2
End If
If dw_doc.GetItemNumber(dw_doc.rowcount(),'compute_sum') <= 0 Then
	Messagebox('Document','You must at least select one document for signature.')
	dw_doc.SetFocus()
	Return -3
End If

//Check First Signer
ls_signer = dw_1.GetItemString(1,'first_signer')
If ls_signer = '' or isnull(ls_signer) Then
	Messagebox('First Signer','Please input the First Signer Email Address.')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -4
End If

//Check Mail From
ls_myemail = dw_1.GetItemString(1,'mail_from')
If ls_myemail = '' or isnull(ls_myemail) Then
	Messagebox('Mail From','The Mail From can not be empty.')
	dw_1.SetColumn('mail_from')
	dw_1.SetFocus()
	Return -5
End If

//Check only non-signers can be added as CC
String ls_first_signer_arr[],ls_second_signer_arr[],ls_cc_arr[],ls_cc
Long i,j,k
ls_sec_signer = dw_1.GetItemString(1,'second_signer')
ls_cc = dw_1.GetItemString(1,'cc')
inv_string.of_parsetoarray(ls_signer , ';', ls_first_signer_arr[])
inv_string.of_parsetoarray(ls_sec_signer , ';', ls_second_signer_arr[])
inv_string.of_parsetoarray(ls_cc , ';', ls_cc_arr[])
For i = 1 To UpperBound(ls_cc_arr[])
	For j = 1 To UpperBound(ls_first_signer_arr[])
		If Lower(Trim(ls_cc_arr[i])) = Lower(Trim(ls_first_signer_arr[j])) Then
			Messagebox('CC',ls_cc_arr[i] + ' is already a signer, only non-signers can be added as CC for the request.')
			dw_1.SetColumn('cc')
			dw_1.SetFocus()				
			Return -6
		End If
	Next
	
	For j = 1 To UpperBound(ls_second_signer_arr[])
		If Lower(Trim(ls_cc_arr[i])) = Lower(Trim(ls_second_signer_arr[j])) Then
			Messagebox('CC',ls_cc_arr[i] + ' is already a signer, only non-signers can be added as CC for the request.')
			dw_1.SetColumn('cc')
			dw_1.SetFocus()			
			Return -7
		End If		
	Next
Next

//Check 1st 
If Not inv_string.of_check_name(ls_signer,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -8
End If

//Check 2nd
If Not inv_string.of_check_name(ls_sec_signer,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('second_signer')
	dw_1.SetFocus()
	Return -9
End If


Return 1
end function

public function integer of_set_message (long al_email_id);Long ll_found,ll_rtn
String ls_attach_name,ls_autosign,ls_subject
n_cst_ctx_mail lnv_mail
Blob lblb_Message
long ll_export_id
n_cst_word_utility lnv_word
Boolean lb_new_export
DataStore lds_temp

IF al_email_id < 0 THEN RETURN 1

SetPointer(HourGlass!)

//Set attachment from email template
ll_found = idwc_email_template.Find('email_id = ' + String(al_email_id), 1, idwc_email_template.RowCount())
If ll_found <= 0 Then Return 1

//Get and open message from email template
lnv_mail.of_get_mail_template(al_email_id, lblb_Message)
ole_message.of_open(lblb_Message)	

//Merge field
ll_export_id = idwc_email_template.GetItemNumber(ll_found,'export_id')
If ll_export_id > 0 Then
	lnv_word = Create n_cst_word_utility
	lds_temp = Create DataStore
	If Not isvalid(ids_export) Then ids_export = Create DataStore
	If il_last_export_id <> ll_export_id Then
		il_last_export_id = ll_export_id
		lb_new_export = True
	Else
		lb_new_export = False
		lds_temp = ids_export
	End If
	ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument, ls_subject,istr_ctx_email.ctx_id_list[1] , ll_export_id, lds_temp, lb_new_export)
	If ll_rtn > 0 Then
		ids_export = lds_temp
	Else
		il_last_export_id = -1
	End If
End If
	
//Copy the message to datawindow
ole_Message.Object.ActiveDocument.Content.Select()
ole_Message.Object.ActiveDocument.ActiveWindow.Selection.Copy()
Dw_1.SetFocus()
dw_1.SetItem(1,'email_message','')
dw_1.Setcolumn('email_message')
dw_1.paste()
dw_1.AcceptText()
ole_Message.of_close()
dw_1.Setcolumn('email_message')
Clipboard ('')

If Not isvalid(ids_export) and isvalid(lds_temp) Then Destroy lds_temp //Don't destroy it always. because ids_export = lds_temp
Return 1




end function

protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, str_alarm_user astr_alarm_user);Long i,j
String ls_arr_old[],ls_arr_new[],ls_new_userlist,ls_mailto
String ls_new_email_list
string	ls_currentAppointmentuser[] , ls_newAppointmentuser[], ls_appointment_list, ls_appointment


If isnull(as_old_email_list) Then as_old_email_list = ''
If isnull(astr_alarm_user.s_to_list ) Then 
	ls_new_email_list = ''
Else
	ls_new_email_list = astr_alarm_user.s_to_list 
End If

inv_string.of_parsetoarray( as_old_email_list, ';', ls_arr_old[] ) 
inv_string.of_parsetoarray( ls_new_email_list, ';', ls_arr_new[] )

ls_mailto = as_old_email_list

If ls_new_email_list = '' Then Return

FOR i = 1 to UpperBound(ls_arr_new[]) 
	FOR j = 1 to UpperBound(ls_arr_old[])
		IF Upper(Trim(ls_arr_new[i])) = Upper(Trim(ls_arr_old[j])) THEN EXIT	
	NEXT
	//Skip the duplicated user
	IF j <= UpperBound(ls_arr_old) THEN CONTINUE
	//Keep the user in new user list
	IF Len(ls_new_userlist) < 1 THEN
		ls_new_userlist = ls_arr_new[i]
	ELSE
		ls_new_userlist += ';' + ls_arr_new[i]
	END IF
NEXT
//Add them to current user list	
IF Len(ls_new_userlist) > 0 THEN 
	IF Len(Trim(ls_mailto)) > 0 And	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + ';'
	ls_mailto = ls_mailto + ls_new_userlist
	dw_1.SetItem(1, as_column_name, ls_mailto)
END IF

dw_1.SetItem(1, as_column_name + '_createlist', astr_alarm_user.s_create_list )

If lower(as_column_name) + '_createlist' <> 'cc_createlist' Then
	ls_appointment = dw_1.GetItemString( 1, 'alm_appointment' )//added by gavins 20121024
	//added by gavins 20121024
	If lower(as_column_name) + '_createlist' = 'first_signer_createlist' Then
		dw_1.SetItem(1, 'alm_appointment1', lower(astr_alarm_user.s_appointment   ))
	Else
		dw_1.SetItem(1, 'alm_appointment2', lower(astr_alarm_user.s_appointment   ))
	End If
	If Len(dw_1.getItemString( 1, 'alm_appointment1' ) ) > 1 And  Len( dw_1.getItemString( 1, 'alm_appointment2' )  ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment1' ) + ';' + dw_1.getItemString( 1, 'alm_appointment2' ) )
	ElseIf Len(dw_1.getItemString( 1, 'alm_appointment1' ) ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment1' ) )
	ElseIf Len(dw_1.getItemString( 1, 'alm_appointment2' ) ) > 1 Then
		dw_1.SetItem(1, 'alm_appointment', dw_1.getItemString( 1, 'alm_appointment2' ) )		
	End If
End If
Return 
end subroutine

on w_app_esig_request.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.cb_custom=create cb_custom
this.cb_cancel=create cb_cancel
this.dw_doc=create dw_doc
this.dw_1=create dw_1
this.cb_send=create cb_send
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.cb_custom
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_doc
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_send
end on

on w_app_esig_request.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.cb_custom)
destroy(this.cb_cancel)
destroy(this.dw_doc)
destroy(this.dw_1)
destroy(this.cb_send)
end on

event pfc_preopen;call super::pfc_preopen;inv_filesrv = n_cst_filesrvwin32 

istr_ctx_email = Message.Powerobjectparm
dw_1.InsertRow(0)
If of_download_doc() < 0 Then Close(This)
end event

event open;call super::open;//Set Sertifi data
If of_set_sertifi() < 1 Then 
	CloseWithReturn(This, 0)
	Return
End If

//Set document list
of_set_documents()

//Retrieve the email templates
dw_1.getchild('email_template',idwc_email_template)
idwc_email_template.SetTransObject(SQLCA)

//Retrieve User
datawindowchild ldwc_user
dw_1.getchild('assign_to',ldwc_user)
ldwc_user.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	idwc_email_template.Retrieve()
	ldwc_user.Retrieve()
gnv_appeondb.of_commitqueue( )

//Set Sender Display Name
String ls_send
Select top 1 first_name Into :ls_send from ctx_contacts Where user_d = :gs_user_id;
If isnull(ls_send) or ls_send = '' Then
	ls_send = gs_user_id
End If
dw_1.SetItem(1,'sender',ls_send)


inv_filesrv = Create n_cst_filesrvwin32
end event

event close;call super::close;If isvalid(ids_export) Then Destroy ids_export
If isvalid(inv_filesrv) Then Destroy inv_filesrv
end event

type ole_message from u_email_edit within w_app_esig_request
boolean visible = false
integer x = 969
integer y = 2900
integer width = 101
integer height = 100
integer taborder = 30
string binarykey = "w_app_esig_request.win"
end type

type cb_custom from commandbutton within w_app_esig_request
integer x = 46
integer y = 1504
integer width = 411
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Custom &Fields..."
end type

event clicked;
str_parm lstr_parm,lstr_parm_new

dw_1.AcceptText()

lstr_parm.s_array[1] = dw_1.GetItemString(1, 'custom_1')
lstr_parm.s_array[2] = dw_1.GetItemString(1, 'custom_2')
lstr_parm.s_array[3] = dw_1.GetItemString(1, 'custom_3')

OpenWithParm(w_dm_sertifi_custom_fields,lstr_parm)

If Isvalid(Message.powerobjectparm) Then
	lstr_parm_new = Message.powerobjectparm
	dw_1.SetItem(1,'custom_1',lstr_parm_new.s_array[1])
	dw_1.SetItem(1,'custom_2',lstr_parm_new.s_array[2])
	dw_1.SetItem(1,'custom_3',lstr_parm_new.s_array[3])
End If







end event

type cb_cancel from commandbutton within w_app_esig_request
integer x = 2523
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type dw_doc from u_dw within w_app_esig_request
integer x = 791
integer y = 176
integer width = 1984
integer height = 92
integer taborder = 20
string title = "none"
string dataobject = "d_app_esig_doc_request"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type dw_1 from u_dw within w_app_esig_request
integer width = 2917
integer height = 1476
integer taborder = 10
string title = "none"
string dataobject = "d_app_esig_request"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(false)
This.Post of_setdropdowncalendar(True)

end event

event itemchanged;call super::itemchanged;If dwo.name = 'email_template' Then
	If isnumber(data) Then
		Parent.of_set_message( Long(data))
	End If
End If


string			ls_create_list, ls_create_users[], ls_email, ls_create_users_new[], ls_email1, ls_email2
Long			i, ll_Find


If dwo.Name = 'first_signer'   Then

	ls_create_list = this.GetItemString( row,"alm_appointment1")
	inv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
	For i = 1 To UpperBound(ls_create_users[])
		If Pos(lower(data ),lower(trim( ls_create_users[i]))) > 0 Then
			ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
		End If
	Next
	If UpperBound(ls_create_users_new[]) > 0 Then
		inv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
	Else
		ls_create_list = ''
	End If
	this.SetItem( row, "alm_appointment1",ls_create_list)

	this.SetItem( row, "alm_appointment",ls_create_list + ';' + this.getitemstring( row, 'alm_appointment2' )  )
End If


If   dwo.Name = 'second_signer'  Then
		
	ls_create_list = this.GetItemString( row,"alm_appointment2")
	inv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
	For i = 1 To UpperBound(ls_create_users[])
		If Pos(lower(data ),lower(trim( ls_create_users[i]))) > 0 Then
			ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
		End If
	Next
	If UpperBound(ls_create_users_new[]) > 0 Then
		inv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
	Else
		ls_create_list = ''
	End If
	this.SetItem( row, "alm_appointment2",ls_create_list)

	this.SetItem( row, "alm_appointment",ls_create_list + ';' + this.getitemstring( row, 'alm_appointment1' )  )
End If
end event

event buttonclicked;call super::buttonclicked;str_alarm_user	lstr_alarm
String ls_columnname, ls_email_list,ls_email_list_temp,ls_email_arr[],ls_email_column
n_cst_string lnv_string

ls_columnname = dwo.name

Choose Case ls_columnname
	Case 'b_first'
		ls_email_column = 'first_signer'
	Case 'b_second'
		ls_email_column = 'second_signer'
	Case 'b_cc'
		ls_email_column = 'cc'
End Choose


Choose Case ls_columnname
	Case 'b_first','b_second','b_cc'
		lstr_alarm.s_flag = 'Y' 
		ls_email_list = This.GetItemString(row,ls_email_column)
		lnv_string.of_parsetoarray( ls_email_list, ';', ls_email_arr[])
		lnv_string.of_arraytostring( ls_email_arr[], ';', ls_email_list_temp)
		lstr_alarm.s_to_list = ls_email_list_temp
		lstr_alarm.s_create_list =  This.GetItemString(row,ls_email_column + '_createlist')
		lstr_alarm.s_type = 'Esign'
		If ls_email_column = 'first_signer' Then
			lstr_alarm.s_appointment = This.GetItemString( row , 'alm_appointment1')//added by gavins 20121031
		ElseIf ls_email_column = 'second_signer' Then
			lstr_alarm.s_appointment = This.GetItemString( row , 'alm_appointment2')//added by gavins 20121031
		End If
		Openwithparm(w_ctx_alarm_users,lstr_alarm)

		lstr_alarm = message.PowerObjectParm
		if isvalid(lstr_alarm) then
			of_update_email_list(ls_email_column,ls_email_list,lstr_alarm)
		end if		
End Choose

end event

type cb_send from commandbutton within w_app_esig_request
integer x = 2162
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send"
end type

event clicked;Long i,li_create_ai
String ls_fileID,ls_docid,ls_ret,ls_1stsigner[], ls_2ndsigner[],ls_ccarray[]
Blob lb_file,lb_download,lb_null
Boolean lb_result = True
String ls_filename,ls_emailfrom,ls_first_signer,ls_second_signer,ls_cc,ls_message,ls_sign_type
String ls_custom_1,ls_custom_2,ls_custom_3,ls_sender
Datetime ldt_duedate
w_appeon_gifofwait lw_appeon_gifofwait
String ls_1st_createlist,ls_2nd_createlist, ls_cc_createlist, ls_createlist, ls_ai_array[]

String							ls_AppointmentList, ls_to_AppointmentList[]
String							ls_errtext, ls_email_type, ls_computer_info, ls_ctxidlist, ls_docidlist, ls_xml
n_cst_easymail_smtp 	lnv_Mail
Long							ll_Return, li_send_result, ll_email_template_id
Long							ll_ctx_id_list[]
tns__referencedocumentpermission ltns__referencedocumentpermission[]

dw_1.AcceptText()
dw_doc.AcceptText()

SetPointer(HourGlass!)

//Check Data
If of_check_data() < 0 Then Return

ls_filename = dw_1.getitemString(1,'filename')
ls_emailfrom = dw_1.getitemString(1,'mail_from')
ls_first_signer = dw_1.getitemString(1,'first_signer')
ls_second_signer = dw_1.getitemString(1,'second_signer')
ls_cc = dw_1.getitemString(1,'cc') 

//Get Create List for Signer
ls_1st_createlist = dw_1.getitemString(1,'first_signer_createlist')
ls_2nd_createlist = dw_1.getitemString(1,'second_signer_createlist')
ls_cc_createlist = dw_1.getitemString(1,'cc_createlist')
If Len( ls_1st_createlist  ) > 0 Then
	ls_createlist = ls_1st_createlist
End If
If Len( ls_2nd_createlist  ) > 0 Then
	If ls_createlist <> '' Then
		ls_createlist = ls_createlist + ';' + ls_2nd_createlist
	Else
		ls_createlist = ls_2nd_createlist
	End If
End If
If Len( ls_cc_createlist  ) > 0 Then
	If ls_createlist <> '' Then
		ls_createlist = ls_createlist + ';' +  ls_cc_createlist
	Else
		ls_createlist = ls_cc_createlist
	End If
End If
inv_string.of_parsetoarray( ls_createlist, ';', ls_ai_array[])
inv_string.of_delete_duplicate( ls_ai_array[])
istr_ctx_email.as_user_arr[] = ls_ai_array[]

//Get Sign info
ls_message = dw_1.getitemString(1,'email_message') 
ls_sign_type = dw_1.getitemString(1,'sign_type') 
ls_custom_1 = dw_1.getitemString(1,'custom_1') 
ls_custom_2 = dw_1.getitemString(1,'custom_2') 
ls_custom_3 = dw_1.getitemString(1,'custom_3') 
istr_ctx_email.ai_create_ai = dw_1.getitemnumber(1,'create_action_item')
istr_ctx_email.adt_duedate = dw_1.getitemdatetime(1,'due_date')
ls_sender = dw_1.getitemString(1,'sender')

ll_email_template_id = dw_1.GetItemNumber(1,'Email_Template')
ls_AppointmentList = dw_1.GetItemString(1,'alm_appointment')
ldt_duedate = istr_ctx_email.adt_duedate

If isnull(ls_second_signer) Then ls_second_signer = ''
If isnull(ls_cc) Then ls_cc = ''
If isnull(ls_message) Then ls_message = ''
If isnull(ls_sign_type) Then ls_sign_type = ''
If isnull(ls_custom_1) Then ls_custom_1 = ''
If isnull(ls_custom_2) Then ls_custom_2 = ''
If isnull(ls_custom_3) Then ls_custom_3 = ''
If isnull(ls_sender) Then ls_sender = ''

istr_ctx_email.as_mail_from = ls_emailfrom
istr_ctx_email.as_sender = ls_sender

//Added By Ken.Guo 12/09/2011. Convert email list format. user single quote, replaced doule quote.
inv_string.of_parsetoarray( ls_first_signer, ';', ls_1stsigner[] )
inv_string.of_arraytostring(ls_1stsigner[], ',', ls_first_signer)

inv_string.of_parsetoarray( ls_second_signer, ';', ls_2ndsigner[] )
inv_string.of_arraytostring(ls_2ndsigner[], ',', ls_second_signer)

inv_string.of_parsetoarray( ls_cc, ';', ls_ccarray[] )
inv_string.of_arraytostring(ls_ccarray[], ',', ls_cc)


If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Sending the signature request...")		

Try
	//Create Request 
	istr_ctx_email.as_sertifi_fileid = gnv_sertifi.isoap_sertifi.createsignaturerequest( &
		gnv_sertifi.is_apicode ,ls_emailfrom, ls_sender, ls_filename, &
		ls_first_signer, ls_second_signer, ls_cc, 'false',ls_sign_type,'', ls_custom_1, ls_custom_2, ls_custom_3,'', ls_message)

	If Pos(Lower(istr_ctx_email.as_sertifi_fileid), 'error') > 0 or Trim(istr_ctx_email.as_sertifi_fileid) = '' Then
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Messagebox('Error','Failed to create sertifi electronic signature request. ~r~n' + istr_ctx_email.as_sertifi_fileid )
		Return -1 
	End If
	
	//Upload Document 
	For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
		lb_file = lb_null
		If inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file) < 0 Then 
			gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_ctx_email.as_sertifi_fileid)
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Messagebox('Error','Failed to open the document ' + istr_ctx_email.pathfilename_list[i] + '.')
			Return -1
		End If

		If dw_doc.GetItemNumber(i,'need_signed') = 1 Then
			ls_xml = ''
			istr_ctx_email.as_sertifi_docid[i] = gnv_sertifi.isoap_sertifi.adddocumenttorequest( gnv_sertifi.is_apicode,istr_ctx_email.as_sertifi_fileid, lb_file,istr_ctx_email.fullfilename_list[i] , istr_ctx_email.fullfilename_list[i] ,ls_xml)
			If Pos(Lower(istr_ctx_email.as_sertifi_docid[i]), 'error' ) > 0 or istr_ctx_email.as_sertifi_docid[i] = '' Then
				gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_ctx_email.as_sertifi_fileid)
				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
				Messagebox('Error','Failed to upload the document '+istr_ctx_email.fullfilename_list[i]+' to sertifi server. ~r~n' + istr_ctx_email.as_sertifi_docid[i])
				Return -1 
			End If
			gnv_debug.of_output(false, 'adddocumenttorequest: ' + ls_xml)
		Else
			ls_ret = ''
			ls_xml = ''
			ls_ret = gnv_sertifi.isoap_sertifi.AddReferenceDocumentToRequest( gnv_sertifi.is_apicode,istr_ctx_email.as_sertifi_fileid, lb_file,istr_ctx_email.fullfilename_list[i] , istr_ctx_email.fullfilename_list[i],false,ltns__referencedocumentpermission[], ls_xml  )
			If Pos(Lower(ls_ret), 'error' ) > 0 or ls_ret = '' Then
				gnv_sertifi.isoap_sertifi.removesignaturerequest(gnv_sertifi.is_apicode, istr_ctx_email.as_sertifi_fileid)
				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
				Messagebox('Error','Failed to upload the document '+istr_ctx_email.fullfilename_list[i]+' to sertifi server. ~r~n' + ls_ret)
				Return -1  
			End If
			gnv_debug.of_output(false,'AddReferenceDocumentToRequest: ' + ls_xml)
		End If
	Next

	//Invite now
	//gnv_sertifi.isoap_sertifi.invitesigners(gnv_sertifi.is_apicode, istr_ctx_email.as_sertifi_fileid, '')
	
	//__________send appointment_________________//added by gavins 20121025
	If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '1' And Len( ls_AppointmentList ) > 1 Then
		
		//Create Email object
		if lnv_Mail.of_CreateObject() = -1 then
			f_show_message('create Email object','','','','')
			Return -1
		end if
		
		inv_string.of_parsetoarray( ls_AppointmentList,';',ls_to_AppointmentList[])
		inv_string.of_delete_duplicate( ls_to_AppointmentList[])
		inv_string.of_arraytostring(ls_to_AppointmentList[], ';', ls_AppointmentList)
		
		li_send_result =0	
		
		If IsNull( ldt_duedate ) Then ldt_duedate = datetime( today( ) )
		lnv_Mail.of_setappointmentarguments( '', ldt_duedate , true,  ls_AppointmentList )
		ll_Return = lnv_Mail.of_sendtext(gs_user_id, ls_AppointmentList,'', '','Appointment for IntelliContract Sandbox Documents for E-signatue',ls_message ,'')  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "Contractlogix" to "IntelliContract"
		//Show Error Info	
		if ll_Return <> 0 then
			If lnv_Mail.is_sendprotocol = 'SMTP' Then
				f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
			Else
				f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
			End If
			lnv_Mail.of_DeleteObject()
			li_send_result = -1
		end if
		
		//Added Email Audit  
		If ll_Return <> 0 then 
			ls_errtext = gnv_message.of_get_error_message( ll_Return)
		End If
		ls_email_type = 'Electronic signature'
	
		ls_computer_info = lnv_Mail.of_get_compute_info( )
		
		ll_ctx_id_list[] = istr_ctx_email.ctx_id_list[]
		inv_string.of_delete_duplicate( ll_ctx_id_list[] )
		inv_string.of_arraytostring( ll_ctx_id_list, ',', ls_ctxidlist)
		inv_string.of_arraytostring( istr_ctx_email.doc_id_list[], ',', ls_docidlist)
		
		For i = 1 To UpperBound( istr_ctx_email.doc_id_list[] )
			update Ctx_am_document set alm_appointment = :ls_AppointmentList where Doc_id = :istr_ctx_email.doc_id_list[i];
		Next
		
		Insert Into em_mail_audit
		(user_id,mail_from,mail_to,mail_cc,mail_bcc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,notes,compute_info)
		Values 
		(:gs_user_id,:gs_user_id,:ls_AppointmentList,'','','Appointment for IntelliContract Sandbox Documents for E-signatue',getdate(),'', :ll_email_template_id,:ls_ctxidlist,:ls_docidlist,'',null,:ls_email_type,'',:li_send_result,:ls_errtext,null,:ls_computer_info);  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "Contractlogix" to "IntelliContract"
		
		lnv_Mail.of_DeleteObject()
	End If

	//_________________________________________//
Catch (RuntimeError  e1) 
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	Messagebox('Error',e1.Text)
	Return -1
End Try

SetPointer(Arrow!)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//Close

CloseWithReturn(Parent,istr_ctx_email)



end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_app_esig_request.bin 
2600000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000093838d8001d1699900000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000093838d8001d1699993838d8001d169990000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000002460000029500dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000002460000029500dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_app_esig_request.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
