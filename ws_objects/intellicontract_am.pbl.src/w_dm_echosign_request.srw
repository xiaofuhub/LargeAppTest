$PBExportHeader$w_dm_echosign_request.srw
forward
global type w_dm_echosign_request from w_response
end type
type cb_custom from commandbutton within w_dm_echosign_request
end type
type ole_message from u_email_edit within w_dm_echosign_request
end type
type cb_cancel from commandbutton within w_dm_echosign_request
end type
type dw_doc from u_dw within w_dm_echosign_request
end type
type dw_1 from u_dw within w_dm_echosign_request
end type
type cb_send from commandbutton within w_dm_echosign_request
end type
end forward

global type w_dm_echosign_request from w_response
integer width = 2921
integer height = 2592
string title = "Check Out – Send For Echosign Signature"
long backcolor = 33551856
cb_custom cb_custom
ole_message ole_message
cb_cancel cb_cancel
dw_doc dw_doc
dw_1 dw_1
cb_send cb_send
end type
global w_dm_echosign_request w_dm_echosign_request

type variables
str_ctx_email istr_ctx_email
n_cst_dm_utils inv_dm_utils
Datawindowchild idwc_email_template
Long il_last_export_id
DataStore ids_export
n_cst_filesrvwin32 inv_filesrv
n_cst_string inv_string

boolean ib_open = false //Added By Jay Chen 10-15-2013
end variables

forward prototypes
public function integer of_download_doc ()
public subroutine of_set_documents ()
public function integer of_set_sertifi ()
public function integer of_check_data ()
public function integer of_set_message (long al_email_id)
protected subroutine of_update_email_list (string as_column_name, string as_old_email_list, str_alarm_user astr_alarm_user)
public function integer of_readblob (string as_filename, ref blob ab_value)
end prototypes

public function integer of_download_doc ();Long i
String ls_pathfile[]

//Download Documents
If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Downloading the document(s)...")
inv_dm_utils.of_download_multi_files( istr_ctx_email.doc_id_list[], istr_ctx_email.revision_list[], ls_pathfile[])
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

//Check document
For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
	if UpperBound(ls_pathfile[]) <= 0 then //Added By Jay Chen 10-11-2013
		Messagebox('Check Document','Failed to download the document (doc_id = '+String(istr_ctx_email.doc_id_list[i])+', revision = '+String(istr_ctx_email.revision_list[i])+')')
		return -1
	end if
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

If Not gnv_echosign.of_check_sertifi( ) Then Return -1  

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
dw_1.SetItem(1, 'mail_from', gnv_echosign.is_emailaddress )
dw_1.SetItem(1, 'due_date',  RelativeDate(today(), 10) )
dw_1.SetItem(1, 'filename',  ls_filename )

Return 1

end function

public function integer of_check_data ();String ls_filename,ls_signer,ls_myemail,ls_sec_signer,ls_signtype,ls_message

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

//Check To Signer
ls_signer = dw_1.GetItemString(1,'first_signer')
If ls_signer = '' or isnull(ls_signer) Then
	Messagebox('To Signer','Please input the To Signer Email Address.')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -4
End If

////Check Mail From
//ls_myemail = dw_1.GetItemString(1,'mail_from')
//If ls_myemail = '' or isnull(ls_myemail) Then
//	Messagebox('Mail From','The Mail From can not be empty.')
//	dw_1.SetColumn('mail_from')
//	dw_1.SetFocus()
//	Return -5
//End If

//Check only non-signers can be added as CC
String ls_first_signer_arr[],ls_second_signer_arr[],ls_cc_arr[],ls_cc
Long i,j,k
ls_cc = dw_1.GetItemString(1,'cc')
inv_string.of_parsetoarray(ls_signer , ';', ls_first_signer_arr[])
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
Next

//Check 1st 
If Not inv_string.of_check_name(ls_signer,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('first_signer')
	dw_1.SetFocus()
	Return -8
End If

//Check sign type
ls_signtype = dw_1.GetItemString(1,'sign_type')
If ls_signtype = '' or isnull(ls_signtype) Then
	Messagebox('Sign Type','Please input the sign type.')
	dw_1.SetColumn('sign_type')
	dw_1.SetFocus()
	Return -9
End If

////Check email message
//ls_message = dw_1.GetItemString(1,'email_message')
//If ls_message = '' or isnull(ls_message) Then
//	Messagebox('Message','Please input the message.')
//	dw_1.SetColumn('email_message')
//	dw_1.SetFocus()
//	Return -10
//End If
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

public function integer of_readblob (string as_filename, ref blob ab_value);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_readblob()
// $<arguments>
//		value    	string	as_filename		:The specified file name.
//		reference	blob  	ab_value   		:The content of the specified file.
// $<returns> integer: 1 - Success;  -1 - Failure
// $<description>Read blob value of a specified file.
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
Long ll_FileLength, ll_readlength

if not fileexists(as_filename) then return -1

SetPointer(HourGlass!) 

//initilize variables
ll_FileLength = filelength(as_filename)
ab_value = Blob(Space(ll_FileLength),EncodingANSI!) //Modified By Ken.Guo 03/28/2012. EncodingANSI

//Read file to blob
//ll_readlength = AppeonReadFile(as_filename, ab_value, ll_FileLength)

int li_fnum,ll_bytes
li_fnum = FileOpen(as_filename, StreamMode!)
ll_bytes = FileReadEx(li_fnum, ab_value)
fileclose( li_fnum )

if ll_readlength < 0 then return -1

return 1

end function

on w_dm_echosign_request.create
int iCurrent
call super::create
this.cb_custom=create cb_custom
this.ole_message=create ole_message
this.cb_cancel=create cb_cancel
this.dw_doc=create dw_doc
this.dw_1=create dw_1
this.cb_send=create cb_send
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_custom
this.Control[iCurrent+2]=this.ole_message
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_doc
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_send
end on

on w_dm_echosign_request.destroy
call super::destroy
destroy(this.cb_custom)
destroy(this.ole_message)
destroy(this.cb_cancel)
destroy(this.dw_doc)
destroy(this.dw_1)
destroy(this.cb_send)
end on

event pfc_preopen;call super::pfc_preopen;inv_filesrv = n_cst_filesrvwin32 

istr_ctx_email = Message.Powerobjectparm
dw_1.InsertRow(0)
If of_download_doc() < 0 Then 
	//Close(This)
	ib_open = false
else
	ib_open = true
END IF
end event

event open;call super::open;//Added By Jay Chen 10-15-2013
if not ib_open then
	CloseWithReturn(This, 0)
	Return
End If

//Set Sertifi data  
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

dw_doc.modify("need_signed_t.visible = false")
dw_doc.modify("need_signed.visible = false")
			
end event

event close;call super::close;If isvalid(ids_export) Then Destroy ids_export
If isvalid(inv_filesrv) Then Destroy inv_filesrv
end event

type cb_custom from commandbutton within w_dm_echosign_request
boolean visible = false
integer x = 41
integer y = 2500
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

type ole_message from u_email_edit within w_dm_echosign_request
boolean visible = false
integer x = 969
integer y = 2900
integer width = 101
integer height = 100
integer taborder = 50
string binarykey = "w_dm_echosign_request.win"
end type

type cb_cancel from commandbutton within w_dm_echosign_request
integer x = 2519
integer y = 2368
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

type dw_doc from u_dw within w_dm_echosign_request
integer x = 791
integer y = 156
integer width = 1984
integer height = 452
integer taborder = 20
string title = "none"
string dataobject = "d_am_sertifi_doc_request"
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type dw_1 from u_dw within w_dm_echosign_request
integer x = 32
integer y = 24
integer width = 2848
integer height = 2304
integer taborder = 10
string title = "none"
string dataobject = "d_am_echosign_request"
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

type cb_send from commandbutton within w_dm_echosign_request
integer x = 2158
integer y = 2368
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
String ls_filename,ls_emailfrom,ls_first_signer,ls_second_signer,ls_cc,ls_message,ls_sign_type,ls_sign_flow
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
//tns__files ltns_files[]
string ls_docname,ls_dockeys,ls_dockeystemp,ls_error

dw_1.AcceptText()
dw_doc.AcceptText()

SetPointer(HourGlass!)

//Check Data
If of_check_data() < 0 Then Return

ls_filename = dw_1.getitemString(1,'filename')
ls_emailfrom = dw_1.getitemString(1,'mail_from')
ls_first_signer = dw_1.getitemString(1,'first_signer')
ls_cc = dw_1.getitemString(1,'cc') 

//Get Create List for Signer
ls_1st_createlist = dw_1.getitemString(1,'first_signer_createlist')
ls_cc_createlist = dw_1.getitemString(1,'cc_createlist')
If Len( ls_1st_createlist  ) > 0 Then
	ls_createlist = ls_1st_createlist
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
ls_sign_type = dw_1.getitemString(1,'sign_type')  //0:ESIGN 1:FAX
ls_sign_flow = '2' //0:SENDER_SIGNATURE_NOT_REQUIRED 1:SENDER_SIGNS_LAST 2:SENDER_SIGNS_FIRST
istr_ctx_email.ai_create_ai = dw_1.getitemnumber(1,'create_action_item')
istr_ctx_email.adt_duedate = dw_1.getitemdatetime(1,'due_date')
ls_sender = dw_1.getitemString(1,'sender')

ll_email_template_id = dw_1.GetItemNumber(1,'Email_Template')
ls_AppointmentList = dw_1.GetItemString(1,'alm_appointment')
ldt_duedate = istr_ctx_email.adt_duedate

If isnull(ls_cc) Then ls_cc = ''
If isnull(ls_message) Then ls_message = ''
If isnull(ls_sign_type) Then ls_sign_type = ''
If isnull(ls_sender) Then ls_sender = ''

istr_ctx_email.as_mail_from = ls_emailfrom
istr_ctx_email.as_sender = ls_sender

//Added By Ken.Guo 12/09/2011. Convert email list format. user single quote, replaced doule quote.
inv_string.of_parsetoarray( ls_first_signer, ';', ls_1stsigner[] )
inv_string.of_arraytostring(ls_1stsigner[], ',', ls_first_signer)

inv_string.of_parsetoarray( ls_cc, ';', ls_ccarray[] )
inv_string.of_arraytostring(ls_ccarray[], ',', ls_cc)

//Files
For i = 1 to dw_doc.rowcount()
//	ls_docname =  istr_ctx_email.pathfilename_list[i]
	ls_docname =  dw_doc.getitemstring(i,"docname")
	lb_file = lb_null
	If inv_filesrv.of_fileread( istr_ctx_email.pathfilename_list[i] , lb_file) < 0 Then 
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Messagebox('Error','Failed to open the document ' + istr_ctx_email.pathfilename_list[i] + '.')
		Return -1
	End If
//	ltns_files[i].docname = ls_docname
//	ltns_files[i].bfile = lb_file
	If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Sending the signature request...")		
	Try
		//Create Request 
//		ls_dockeystemp = gnv_echosign.isoap_echosign.senddocument(gnv_echosign.is_apicode,ls_filename,ls_first_signer,ls_sign_type,ls_sign_flow,ls_message,ltns_files)
		ls_dockeystemp = gnv_echosign.isoap_echosign.senddocument(gnv_echosign.is_apicode,ls_filename,ls_first_signer,ls_sign_type,ls_sign_flow,ls_message,ls_docname,lb_file,ls_cc)
		If lower(Left(ls_dockeystemp,5)) = 'error'  or trim(ls_dockeystemp) = "-1"  Then
			ls_error = ls_dockeystemp
			if len(ls_error) > 197 then ls_error = left(ls_error,197) + '...' //Added By Jay Chen 11-07-2013
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			gnv_debug.of_output(true, 'send document: [' + ls_docname +'] error:'+ ls_dockeystemp)
//			Messagebox('Error','Failed to send the documents request, please see the error log.~r~n~r~n'+ls_error)
			if len(ls_error) > 197 then //Modified By Jay Chen 11-14-2013
				Messagebox('Error','Failed to send the documents request, please see the error log.~r~n~r~n'+ls_error)
			else
				Messagebox('Error','Failed to send the documents request.~r~n~r~n'+ls_error)
			end if
			Return 
		End If
		ls_dockeys = ls_dockeys + ls_dockeystemp
	Catch (RuntimeError  e1) 
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Messagebox('Error',e1.Text)
		Return -1
	End Try
Next

if trim(ls_dockeys) = "-1"  Then
	ls_error = ls_dockeystemp
	if len(ls_error) > 197 then ls_error = left(ls_error,197) + '...' //Added By Jay Chen 11-07-2013
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	gnv_debug.of_output(true, 'send document: [' + ls_docname +'] error:'+ ls_dockeystemp)
	if len(ls_error) > 197 then //Modified By Jay Chen 11-14-2013
		Messagebox('Error','Failed to send the documents request, please see the error log.~r~n~r~n'+ls_error)
	else
		Messagebox('Error','Failed to send the documents request.~r~n~r~n'+ls_error)
	end if
	Return 
end if

inv_string.of_parsetoarray( ls_dockeys, '  ', istr_ctx_email.as_sertifi_docid[] )
	   
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
			(:gs_user_id,:gs_user_id,:ls_AppointmentList,'','','Appointment for IntelliContract Sandbox Documents for E-signatue',getdate(),'', :ll_email_template_id,:ls_ctxidlist,:ls_docidlist,'',null,:ls_email_type,'',:li_send_result,:ls_errtext,null,:ls_computer_info); //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "Contractlogix" to "IntelliContract"
		
			lnv_Mail.of_DeleteObject()
		End If

		//_________________________________________//
	
SetPointer(Arrow!)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//Close

istr_ctx_email.as_sertifi_fileid = ls_filename //Added By Jay Chen 10-12-2013
CloseWithReturn(Parent,istr_ctx_email)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_dm_echosign_request.bin 
2100000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000c555b21001d131be00000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000dc00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003d267e82f41ee8649010521915f71b13000000000c555b21001d131bec555b21001d131be0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000004000000dc00000000000000010000000200000003fffffffe000000050000000600000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00000246000002958000001080000005800000088000001080000014010100010000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100c8d0d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f6e6d300e3ba9200000000000000000000000000000001000000000000000100000000000003a8000000010000000000000000000000000000000000000000000000000000000000000000000000001234abcd00000246000002958000001080000005800000088000001080000014010100010000000000000000000000000000000000000000000000000000000000000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100c8d0d4000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f6e6d300e3ba9200000000000000000000000000000001000000000000000100000000000003a800000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_dm_echosign_request.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
