$PBExportHeader$n_cst_easymail_smtp.sru
$PBExportComments$(Appeon)Eugene  06.25.2013 - V141 ISG-CLX  replaced the same name object
forward
global type n_cst_easymail_smtp from nonvisualobject
end type
end forward

global type n_cst_easymail_smtp from nonvisualobject autoinstantiate
end type

type variables
OLEObject iole_SmtpMail
OLEObject iole_EAMail
blob iblb_MailContent
string is_user_id
String is_SendProtocol

n_cst_encrypt in_Encrypt

//(Appeon)Harry 01.22.2014 - V142 ISG-CLX
//---------Begin Added by (Eugene)Toney 06.26.2013 for V141 ISG-CLX-------- 
boolean ib_SaveSentMail = true //Evan 01.21.2010
boolean ib_combine_mail = true //Stephen 11.23.2011
n_cst_email_log inv_EmailLog   //Evan 06.08.2012
//---------End Added ------------------------------------------------------------------

n_ds ids_sent_msg 
n_cst_dm_utils inv_dm_utils
boolean ib_ExistsOutLook  //jervis 08.30.2011

//Added By Ken 09/22/2011. 
OLEObject iole_smtpssl

Boolean		ib_Appointment   // added by gavins 20121024
DateTime	idt_AppointmentDate
String			is_AppointmentType
String			is_AppointmentBody
String			is_AppointmentToEmail

String 		is_EmailLogFile  //(Appeon)Harry 07.03.2014 - Email Log
long    		il_EmailLogFileHandle  //(Appeon)Harry 07.03.2014 - Email Log
String 		is_EmailMessage = "" //(Appeon)Harry 07.03.2014 - Email Log

Boolean 		ib_Recruit = FALSE //alfee 10.24.2015
end variables

forward prototypes
public function integer of_createobject ()
public function integer of_deleteobject ()
public function integer of_setaccountaddress (string as_account, string as_password, string as_fromaddress)
public function integer of_sendtext (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attchment)
public function integer of_sendtext (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attchment)
public function integer of_sendhtml (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment)
public function integer of_parsetoarray (string as_mailto, string as_mailcc, string as_mailbcc, string as_attchment, ref string as_mailto_arr[], ref string as_mailcc_arr[], ref string as_mailbcc_arr[], ref string as_attchment_arr[])
public function integer of_send (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag)
public function boolean of_pingserver (string as_userid)
public function string of_getemailerror (long al_errno)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_email_edit au_email_edit, string as_attchment, boolean ab_sign)
public function string of_getattchmentname (string as_fullname)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_email_edit au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function integer of_sendhtml (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function integer of_send (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function string of_parse_value (string as_text)
public function string of_add_keyword (ref string as_subject, string as_ctx_id, string as_doc_id, string as_ai_id)
public function integer of_get_keyword (string as_subject, ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id)
public subroutine of_set_global_var (long al_ctx_id, long al_doc_id, long al_ai_id)
public function string of_get_company_name (string as_ctx_id_list)
public function string of_get_compute_info ()
public function integer of_getdefaultaccount (string as_userid, ref string as_server, ref long al_port, ref long al_authmode, ref string as_account, ref string as_password, ref string as_email, ref integer ai_smtpssl, ref integer ai_pop3ssl)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_word_edit au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_word_edit au_email_edit, string as_attchment, boolean ab_sign)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, w_email_edit_alarm au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, w_email_edit_alarm au_email_edit, string as_attchment, boolean ab_sign)
public function integer of_send_smtp (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag, integer al_ctx_id, integer al_doc_id, integer al_action_item_id)
public subroutine of_setlog ()
public function string of_gettempfile (string as_subject)
public function string of_createappointment (string as_subject, string as_body, datetime adt_date, string as_type)
public subroutine of_setappointmentarguments (boolean ab_appointment, datetime adt_appointmentdate, string as_appointmenttype)
public subroutine of_setappointmentarguments (string as_appointmenttype, datetime adt_appointmentdate, boolean ab_appointment, string as_appointmenttoemail)
public function string of_createappointment2007 (string as_subject, string as_body, datetime adt_date, string as_type)
public function integer of_getdefaultaccount (string as_userid, ref str_email_account astr_email_account)
public function integer of_createobject_ea ()
public function integer of_setsmtpinfo (str_email_account astr_email_account)
public function integer of_setaccountaddress (str_email_account astr_email_account)
public function integer of_setsmtpinfo_old (string as_mailserver, long al_mailport, long al_authmode, integer ai_smtpssl)
public function string of_gettempfile (string as_filename, string as_fileext)
public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment)
public subroutine of_set_combine_status (boolean ab_status)
public subroutine of_emaillog (string as_name, string as_value)
end prototypes

public function integer of_createobject ();long ll_Result

// Create SMTP object
if Not IsValid(iole_SmtpMail) then
	iole_SmtpMail = Create OLEObject	
end if

ll_Result = iole_SmtpMail.ConnectToNewObject("EasyMail.SMTP.6.5")

// Set license key
if ll_Result = 0 then
	iole_SmtpMail.LicenseKey = 'Contractlogix (Single Developer)/00A0630310E21F00FB85'
else
	Return -1
end if

//Added By Ken 09/22/2011. 
// Create SMTP SSL object
if Not IsValid(iole_SmtpSSL) then
	iole_SmtpSSL = Create OLEObject	
end if

ll_Result = iole_SmtpSSL.ConnectToNewObject("EasyMail.SSL")

// Set license key
if ll_Result = 0 then
	iole_SmtpSSL.LicenseKey = 'contractlogix (Single Developer)/00A0630510E253001C81'
	Return 1
else
	Return -2
end if

end function

public function integer of_deleteobject ();if IsValid(iole_SmtpMail) then
	iole_SmtpMail.DisconnectObject()
	Destroy iole_SmtpMail
end if

//Added By Ken 09/22/2011. 
if IsValid(iole_SmtpSSL) then
	iole_SmtpSSL.DisconnectObject()
	Destroy iole_SmtpSSL
end if

//Added By Ken.Guo 07/03/2013
if IsValid(iole_EAMail) then
	iole_EAMail.DisconnectObject()
	Destroy iole_EAMail
end if

Return 1
end function

public function integer of_setaccountaddress (string as_account, string as_password, string as_fromaddress);if IsNull(as_Account) then
	as_Account = ""
end if

if IsNull(as_Password) then
	as_Password = ""
end if

if IsNull(as_FromAddress) then
	//MessageBox(gnv_app.iapp_object.DisplayName,'EMail Address can not be null.')
	return -13
end if

If Isvalid(iole_SmtpMail) Then
	iole_SmtpMail.ESMTP_Account = as_Account
	iole_SmtpMail.ESMTP_Password = as_Password
	iole_SmtpMail.FromAddr = as_FromAddress
End If

//Added By Ken.Guo 07/03/2013
If Isvalid(iole_EAMail) Then
	iole_EAMail.UserName = as_Account
	iole_EAMail.Password = as_Password
	iole_EAMail.FromAddr = as_FromAddress
End If

Return 1

end function

public function integer of_sendtext (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attchment);integer ll_Return
string ls_MailTo[]
string ls_MailCc[]
string ls_MailBcc[]
string ls_Attchment[]
String	ls_Appointmentfile
String	ls_AppointmentEmail[], ls_EmailTo[], ls_Attchment2[]
Integer	li_i
Boolean	lb_SameAppointment

// Parse string to array
of_ParseToArray(as_MailTo, as_MailCc, as_MailBcc, as_Attchment, ls_MailTo[], ls_MailCc[], ls_MailBcc[], ls_Attchment[])
//--------------------------//added by gavins 20121024
If ib_Appointment Then
	If Isnull( as_Message ) Then  as_Message =  '' 

	ls_Appointmentfile = of_CreateAppointment( as_Subject, as_Message, idt_AppointmentDate, is_AppointmentType )
	If Len( ls_AppointmentFile ) > 0 Then
		ls_Attchment2 = ls_Attchment
		ls_Attchment2[ UpperBound( ls_Attchment ) + 1  ] = ls_AppointmentFile
	Else
		gnv_debug.of_output( true, "Failed to create appointment. subject=" + as_subject  )
	End If	

	is_AppointmentBody = '' 
	SetNull( idt_AppointmentDate )
	ib_Appointment = false
	is_AppointmentType = ''
	ls_Attchment = ls_Attchment2

End If
//--------------------------//
// Send email
//Begin - Added By Mark Lee 10/25/12
//ll_Return = of_Send(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, as_Message, "", ls_Attchment[], 1)
//If of_get_app_setting("set_56","I") = 1 then
If of_get_app_setting("set_56","I") = 1 And Not ib_Recruit Then //alfee 10.24.2015		
	ll_Return = of_Send_smtp(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, as_Message, "", ls_Attchment[], 1,0,0,0)
Else
	ll_Return = of_Send(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, as_Message, "", ls_Attchment[], 1)
End If
//End - Added By Mark Lee 10/25/12



Return ll_Return
end function

public function integer of_sendtext (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attchment);integer ll_Rtn
//long 		ll_Port,ll_Authmode,ll_Rtn
//string 	ls_Server,ls_Account,ls_Password,ls_Email
String ls_HtmlFile	
long		ll_EMail_Id,ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob		lblb_Signature,lb_Temp
long 		READ_ONE_LENGTH = 8000
//Integer li_smtpssl,li_pop3ssl

str_email_account lstr_email_account


//Commented By Ken.Guo 07/03/2013
//// Set SMTP information from user ID
//if of_GetDefaultAccount(as_UserID,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email,li_smtpssl,li_pop3ssl) = -1 then Return -1
//ll_Rtn = of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode,li_smtpssl)
//if ll_Rtn < 0 then return ll_Rtn
//ll_Rtn = of_SetAccountAddress(ls_Account, ls_Password, ls_Email)
//if ll_Rtn < 0 then return ll_Rtn

//Added By Ken.Guo 07/03/2013
If of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 Then Return -1
ll_Rtn = of_SetSmtpInfo(lstr_email_account)
if ll_Rtn < 0 then Return ll_Rtn
ll_Rtn = of_SetAccountAddress(lstr_email_account)
if ll_Rtn < 0 then Return ll_Rtn


SELECT Datalength(security_user_mailsetting.signature)
  INTO :ll_DataLen
  FROM security_user_mailsetting
 WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;

// Get signature from user ID
if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM security_user_mailsetting
		     WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
		
		lblb_Signature += lb_Temp
	next
else
	SELECTBLOB signature
	      INTO :lblb_Signature
	      FROM security_user_mailsetting
	     WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
end if

// Send email
is_user_id = as_UserID
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
   if Len(lblb_Signature) > 0 then   
  */
if LenA(lblb_Signature) > 0 then  
//---------End Modfiied ------------------------------------------------------------------
	// Merge signature
	Open(w_email_edit)
	//if w_email_edit.ole_word.of_Open(lblb_Signature) = -1 then Return -1
	if w_email_edit.ole_word.of_Open(lblb_Signature) < 0 then Return -1 //BugA090402  - Alfee 09.24.2013
	if w_email_edit.ole_word.of_InsertTextFirst(as_Message+ '~r~n') = -1 then Return -1 //Alfee 03.27.2008
	//if w_email_edit.ole_word.of_InsertTextFirst(as_Message) = -1 then Return -1
	w_email_edit.ole_word.of_GetBlob(iblb_MailContent)
	ls_HtmlFile = w_email_edit.ole_word.of_GetHtmlFile()	
	w_email_edit.ole_word.of_Close()
	Close(w_email_edit)
	
	// Send html mail
	ll_Rtn = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment)
else
	// Send text mail
	//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
	  /*
		iblb_MailContent = Blob(as_Message)	
	  */
	iblb_MailContent = Blob(as_Message,EncodingAnsi!) //Encoding – Nova 11.16.2010
	//---------End Modfiied ------------------------------------------------------------------	
	ll_Rtn = of_SendText(as_MailTo, as_MailCc, as_mailBcc, as_Subject, as_Message, as_Attchment)
end if


Return ll_Rtn

end function

public function integer of_sendhtml (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment);//Add by jervis 02.27.2009
return of_sendhtml(as_mailto,as_mailcc,as_mailbcc,as_subject,as_htmlfile,as_attchment,0,0,0)


end function

public function integer of_parsetoarray (string as_mailto, string as_mailcc, string as_mailbcc, string as_attchment, ref string as_mailto_arr[], ref string as_mailcc_arr[], ref string as_mailbcc_arr[], ref string as_attchment_arr[]);string ls_Temp
long i, ll_Return,ll_Pos
n_cst_string lnv_string
string ls_mailto_temp[]
string ls_mailcc_temp[]
string ls_mailbcc_temp[]
string ls_attchment_temp[]

//Replace '.com,' to '.com;' //Modified By Ken.Guo 2009-12-30
// Parse string to array
ll_Pos = Pos(as_mailto,".com,")
do while ll_Pos > 0
	as_mailto = Replace(as_mailto,ll_Pos,5,".com;")
	ll_Pos = Pos(as_mailto,".com,",ll_Pos + 5)
loop

ll_Pos = Pos(as_mailcc,".com,")
do while ll_Pos > 0
	as_mailcc = Replace(as_mailcc,ll_Pos,5,".com;")
	ll_Pos = Pos(as_mailcc,".com,",ll_Pos + 5)
loop

ll_Pos = Pos(as_mailbcc,".com,")
do while ll_Pos > 0
	as_mailbcc = Replace(as_mailbcc,ll_Pos,5,".com;")
	ll_Pos = Pos(as_mailbcc,".com,",ll_Pos + 5)
loop

ll_Pos = Pos(as_attchment,";")
do while ll_Pos > 0
	as_attchment = Replace(as_attchment,ll_Pos,1,",")
	ll_Pos = Pos(as_attchment,";",ll_Pos + 1)
loop

lnv_String.of_ParseToArray(as_mailto, ";", ls_mailto_temp[])
lnv_String.of_ParseToArray(as_mailcc, ";", ls_mailcc_temp[])
lnv_String.of_ParseToArray(as_mailbcc, ";", ls_mailbcc_temp[])
lnv_String.of_ParseToArray(as_attchment, ",", ls_attchment_temp[])

// To
for i = 1 to UpperBound(ls_mailto_temp[])
	ls_Temp = Trim(ls_mailto_temp[i])
	if Len(ls_Temp) > 0 then
		as_mailto_arr[UpperBound(as_mailto_arr) + 1] = ls_Temp
	end if
next
// CC
for i = 1 to UpperBound(ls_mailcc_temp[])
	ls_Temp = Trim(ls_mailcc_temp[i])
	if Len(ls_Temp) > 0 then
		as_mailcc_arr[UpperBound(as_mailcc_arr) + 1] = ls_Temp
	end if
next
// BCC
for i = 1 to UpperBound(ls_mailbcc_temp[])
	ls_Temp = Trim(ls_mailbcc_temp[i])
	if Len(ls_Temp) > 0 then
		as_mailbcc_arr[UpperBound(as_mailbcc_arr) + 1] = ls_Temp
	end if
next
// Attchment
for i = 1 to UpperBound(ls_attchment_temp[])
	ls_Temp = Trim(ls_attchment_temp[i])
	if Len(ls_Temp) > 0 then
		as_attchment_arr[UpperBound(as_attchment_arr) + 1] = ls_Temp
	end if
next

Return 1
end function

public function integer of_send (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag);//Add by jervis 02.27.2009
return of_send(as_mailto,as_mailcc,as_mailbcc,as_subject,as_message,as_htmlfile,as_attchment,ai_flag,0,0,0)


end function

public function boolean of_pingserver (string as_userid);//Modified By Ken.Guo 07/03/2013
Long ll_Result
str_email_account lstr_email_account
if of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 then Return false
Choose Case lstr_email_account.as_sendprotocol
	Case'SMTP'
		If Not IsValid(iole_SmtpMail) Then This.of_createobject( )
	Case 'OUTLOOK'
		//Using MAPI
	Case Else //EAGetMail: Exchange
		If Not IsValid(iole_EAMail) Then This.of_createobject_ea( )
End Choose

//Modified By Ken.Guo 07/03/2013
//if of_SetSmtpInfo(lstr_email_account.as_sendserver ,lstr_email_account.al_sendport ,lstr_email_account.ai_sendauthmode ,lstr_email_account.ai_sendssl ) < 0 then return false
//if of_SetAccountAddress(lstr_email_account.as_account , lstr_email_account.as_password , lstr_email_account.as_emailaddress ) < 0 then return false
if of_SetSmtpInfo(lstr_email_account ) < 0 then return false
if of_SetAccountAddress(lstr_email_account) < 0 then return false

If lstr_email_account.as_sendprotocol = 'SMTP' Then //Only SMTP support ping
	gnv_status_info.of_display( 'Checking Email SMTP Account...' )
	ll_Result = iole_SmtpMail.Connect(0)
	gnv_status_info.of_display( '')
	if ll_Result = 0 then
		Return true
	else
		Return false
	end if
Else 
	//How to ping exchange server by EASendEmail ActiveX???
End If

Return True

//Commented By Ken.Guo 07/03/2013
//long ll_Port
//long ll_Authmode
//long ll_Return
//string ls_Server
//string ls_Account
//string ls_Password
//string ls_Email
//long ll_Result
//Integer li_smtpssl,li_pop3ssl
//
//// Set SMTP information from user ID
//If Not IsValid(iole_SmtpMail) Then This.of_createobject( ) //Added By Ken.Guo 2010-03-10.
//if of_GetDefaultAccount(as_UserID,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email,li_smtpssl,li_pop3ssl) = -1 then Return false
//if of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode,li_smtpssl) < 0 then return false
//if of_SetAccountAddress(ls_Account, ls_Password, ls_Email) < 0 then return false
//
//// Try connect to SMTP server
//gnv_status_info.of_display( 'Checking Email SMTP Account...' )
//ll_Result = iole_SmtpMail.Connect(0)
//gnv_status_info.of_display( '')
//if ll_Result = 0 then
//	Return true
//else
//	Return false
//end if
end function

public function string of_getemailerror (long al_errno);String	ls_Rtn


If is_SendProtocol = 'SMTP' Then 
	Choose Case al_ErrNo
		Case -16
			ls_Rtn = "SMTP Server Secure Password Authentication can not be null."
		Case -15
			ls_Rtn = "SMTP Server port can not be null."
		Case -14
			ls_Rtn = "SMTP Server address can not be null."
		Case -13
			ls_Rtn = "EMail Address can not be null."
		Case -12
			ls_Rtn = "EMail Password can not be null."
		Case -11
			ls_Rtn = "EMail Account can not be null."
		Case -1
			//ls_Rtn = "The EMail account of addresser has not config."
			ls_Rtn = "The Email account of sender has not been configured properly." //Alfee 03.24.2008
		Case 1
			ls_Rtn = "An exception has occurred."
		case 3
			ls_Rtn = "The process has run out of memory."
		case 4
			ls_Rtn = "An error has occurred due to a problem with the message body or attachments."
		case 7
			ls_Rtn = "The from address was not formatted correctly or was rejected by the SMTP mail server. Some SMTP mail servers will only accept mail from particular addresses or domains. SMTP mail servers may also reject a from address if the server can not successfully do a reverse lookup on the from address."
		case 8
			ls_Rtn = "An error was reported in response to a recipient address. The SMTP server may refuse to handle mail for unknown recipients."
		Case 9
			ls_Rtn = "Port error, or other unknown errors."
		case 10
			ls_Rtn = "There was an error opening a file. If you have specified file attachments, ensure that they exist and that you have access to them."
		case 11
			ls_Rtn = "There was an error reading a file. If you have specified file attachments, ensure that they exist and the you have access to them."
		case 16
			ls_Rtn = "There was a problem with the connection and a socket error occurred."
		Case 17
			ls_Rtn = "SMTP Server error, or other unknown errors."
		case 19
			ls_Rtn = "Could not create thread."
		case 20
			ls_Rtn = "Cancelled as a result of calling the Cancel() method."
		case 24
			ls_Rtn = "Account or password error, or other unknown errors."
		case 27
			ls_Rtn = "Socket Timeout Error."
		Case 1001 //Added By Ken.Guo 12/11/2013
			ls_Rtn = "Failed to create HTML file. Please open Windows Task Manager and look for the WINWORD.exe process and right click on that entry and click End Process. Then try again."
		Case else
			ls_Rtn = "Unknown error."
	End Choose
Else
	Choose Case al_ErrNo
		Case 1001 //Added By Ken.Guo 12/11/2013
			ls_Rtn = "Failed to create HTML file. Please open Windows Task Manager and look for the WINWORD.exe process and right click on that entry and click End Process. Then try again."
		Case Else
			If isvalid(iole_EAMail) Then
				ls_Rtn = iole_EAMail.GetLastErrDescription() 
			End If
	End Choose
End If

return ls_Rtn

end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_email_edit au_email_edit, string as_attchment, boolean ab_sign);//Add by jervis 02.27.2009
return of_sendhtml(as_userid,as_mailto,as_mailcc,as_mailbcc,as_subject,au_email_edit,as_attchment,ab_sign,0,0,0)


end function

public function string of_getattchmentname (string as_fullname);integer li_Pos
integer i, li_Len
string  ls_Name

//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
	li_Len = Len(as_FullName)
	for i = li_Len to 1 step -1
		if Mid(as_FullName, i, 1) = "\" then
			ls_Name = Right(as_FullName, li_Len - i)
			Return ls_Name
		end if
	next      
  */
li_Len = LenA(as_FullName)
for i = li_Len to 1 step -1
	if MidA(as_FullName, i, 1) = "\" then
		ls_Name = RightA(as_FullName, li_Len - i)
		Return ls_Name
	end if
next  
//---------End Modfiied ------------------------------------------------------------------

Return ""
end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_email_edit au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id);//long 		ll_Port,ll_Authmode
Long ll_DataLen,ll_Start,ll_Cycle,ll_Count
integer ll_Return
Blob		lblb_Signature,lb_Temp
//string 	ls_Server,ls_Account,ls_Password,
String ls_Email,ls_HtmlFile
long 		READ_ONE_LENGTH = 8000
//Integer li_smtpssl, li_pop3ssl
str_email_account lstr_email_account //Added By Ken.Guo 07/03/2013

IF gi_email_type = 0 Then  //only for Easymail //Added If statement by Ken.Guo 06/04/2013
	// Set SMTP information from user ID
	if of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 then Return -1
//	//Modified By Mark Lee 04/18/2013  if use the outlook  send the email, don't check the smtp
//	IF gi_email_type = 0 Then 
		ll_Return = of_SetSmtpInfo(lstr_email_account)
		if  ll_Return < 0 then return ll_Return
//	End IF 
	ll_Return = of_SetAccountAddress(lstr_email_account)
	if  ll_Return < 0 then return ll_Return
End If

gs_CurAddresser = as_UserID	 //Added By Ken.Guo 06/04/2013. Copy from of_GetDefaultAccount()

if ab_sign then
	SELECT Datalength(security_user_mailsetting.signature)
	  INTO :ll_DataLen
	  FROM security_user_mailsetting
	 WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	
	// Get signature from user ID
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_Cycle = 1 To ll_Count
			ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM security_user_mailsetting
				  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
			
			lblb_Signature += lb_Temp
		next
	else
		SELECTBLOB signature
				INTO :lblb_Signature
				FROM security_user_mailsetting
			  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	end if
	
	// Send email
	if Len(lblb_Signature) > 0 then
		// Merge signature
		au_email_edit.of_InsertFileLast(lblb_Signature)
	end if
end if

// Send email
of_set_global_var(al_ctx_id,al_doc_id,al_action_item_id)
is_user_id = as_UserID
If gnv_data.of_getItem("icred_settings", "email_tag_mode", False) = '2' And &
   gnv_data.of_getItem("icred_settings", "receive_email", False) = '1' Then	//Added By Ken.Guo 2011-03-03. If No Receive Email Module, then needn't add keyword.Then
		If IsNull(al_ctx_id + al_doc_id + al_action_item_id) Or (al_ctx_id + al_doc_id + al_action_item_id) <> 0 Then //Add if statement for BugA081602 - Eugene 09.17.2013
			au_email_edit.of_add_keyword(gstr_email_info.ss_ctx_id_list ,gstr_email_info.ss_doc_id_list,gstr_email_info.ss_ai_id_list)
		End If
End If
au_email_edit.of_GetBlob(iblb_MailContent)
//Begin - Added By Mark Lee 10/15/12
//ls_HtmlFile = au_email_edit.of_GetHtmlFile()
//ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
If  of_get_app_setting("set_56","I") = 1 then
	ls_HtmlFile  = au_email_edit.of_gettxtfile()
	is_AppointmentBody = ls_HtmlFile//added by gavins 20121024
Else 
	ls_HtmlFile = au_email_edit.of_GetHtmlFile()
	If ib_Appointment Then //added by gavins 20121024
		is_AppointmentBody = au_email_edit.of_gettxtfile()
	End If
End If
ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) 
//End - Added By Mark Lee 10/15/12

Return ll_Return

end function

public function integer of_sendhtml (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment, long al_ctx_id, long al_doc_id, long al_action_item_id);integer ll_Return
string ls_MailTo[]
string ls_MailCc[]
string ls_MailBcc[]
string ls_Attchment[]
String	ls_Appointmentfile
String	ls_AppointmentEmail[], ls_EmailTo[], ls_Attchment2[]
Integer	li_i
Boolean	lb_SameAppointment

// Parse string to array
of_ParseToArray(as_MailTo, as_MailCc, as_MailBcc, as_Attchment, ls_MailTo[], ls_MailCc[], ls_MailBcc[], ls_Attchment[])

//--------------------------//added by gavins 20121024
If ib_Appointment Then
	If Isnull( is_AppointmentBody ) Then  is_AppointmentBody = ''

	ls_Appointmentfile = of_CreateAppointment( as_Subject, is_AppointmentBody, idt_AppointmentDate, is_AppointmentType )
	If Len( ls_AppointmentFile ) > 0 Then
		ls_Attchment2 = ls_Attchment
		ls_Attchment2[ UpperBound( ls_Attchment ) + 1  ] = ls_AppointmentFile
	Else
		gnv_debug.of_output( true, "Failed to create appointment. subject=" + as_subject + ", ctx_id=" + string(al_ctx_id ))
	End If	

	is_AppointmentBody = '' 
	SetNull( idt_AppointmentDate )
	ib_Appointment = false
	is_AppointmentType = ''
	ls_Attchment = ls_Attchment2

End If
//--------------------------//

//Begin - Added By Mark Lee 10/15/12
// Send email
//ll_Return = of_Send(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, "", as_HtmlFile, ls_Attchment[], 2,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
If of_get_app_setting("set_56","I") = 1 then
	ll_Return = of_Send_smtp(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, as_HtmlFile,"", ls_Attchment[],1,al_ctx_id,al_doc_id,al_action_item_id) 
Else
	ll_Return = of_Send(ls_MailTo[], ls_MailCc[], ls_MailBcc[], as_Subject, "",as_HtmlFile, ls_Attchment[], 2,al_ctx_id,al_doc_id,al_action_item_id) 
End If
//End - Added By Mark Lee 10/15/12


Return ll_Return
end function

public function integer of_send (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag, long al_ctx_id, long al_doc_id, long al_action_item_id);long   ll_id
long   i
Integer ll_Result = -1
string ls_MailTo
string ls_MailCc
string ls_MailBcc
string ls_Attachment,ls_attach_filename
string ls_Account
datastore lds_mail,lds_mail_attach
n_cst_outlook lnv_Outlook
string ls_encoding ,ls_from //Added By Ken.Guo 2009-07-31.
Datetime ldt_sent
Blob lblb_attachment
Long ll_attach_id
String ls_unit
decimal ldec_filesize
n_cst_filesrv lnv_filesrv
String ls_doc,ls_ctx


lnv_filesrv = Create n_cst_filesrv

If al_ctx_id < 0 Then al_ctx_id = 0
If al_doc_id < 0 Then al_doc_id = 0
If al_action_item_id < 0 Then al_action_item_id = 0

of_set_global_var(al_ctx_id,al_doc_id,al_action_item_id)

if IsNull(as_Subject) then as_Subject = ""
if IsNull(as_Message) then as_Message = ""

If is_SendProtocol = 'SMTP' Then
	iole_SmtpMail.Clear(1 + 2)   //Added By Ken.Guo 2009-05-13. Clear Recipients and attachments
Else
	iole_EAMail.ClearRecipient()
	iole_EAMail.ClearAttachment()
End If

//---------Begin Added by (Appeon)Harry 03.11.2014 for Bug # 3887--------
Boolean lb_combine_mail_temp
if not gb_contract_version  and gb_contract_module and al_ctx_id > 0 then
	lb_combine_mail_temp = ib_combine_mail
	of_set_combine_status(false)
end if
//---------End Added ------------------------------------------------------

// Add recipients
for i = 1 to UpperBound(as_MailTo[])
	
	if lnv_Outlook.of_LookupAccount(as_MailTo[i], ls_Account, 1) <> 0 then ls_Account = as_MailTo[i]  //jervis 08.09.2011
	If is_SendProtocol = 'SMTP' Then
		iole_SmtpMail.AddRecipient(as_MailTo[i], ls_Account, 1)   //To
	Else
		iole_EAMail.AddRecipient(as_MailTo[i], ls_Account, 0) //To
	End If
	if Len(ls_MailTo) > 0 then ls_MailTo += "; "
	ls_MailTo += as_MailTo[i]
next
of_emaillog('SendTo', ls_MailTo) //Added by (Appeon)Harry 08.11.2014 for Email Log
for i = 1 to UpperBound(as_MailCc[])
	if lnv_Outlook.of_LookupAccount(as_MailCc[i], ls_Account, 1) <> 0 then ls_Account = as_MailCc[i]
	If is_SendProtocol = 'SMTP' Then
		iole_SmtpMail.AddRecipient(as_MailCc[i], ls_Account, 2)   //CC
	Else
		iole_EAMail.AddRecipient(as_MailCC[i], ls_Account, 1) //CC
	End If
	if Len(ls_MailCc) > 0 then ls_MailCc += "; "
	ls_MailCc += as_MailCc[i]
next
of_emaillog('SendCc', ls_MailCc) //Added by (Appeon)Harry 08.11.2014 for Email Log
for i = 1 to UpperBound(as_MailBcc[])
	if lnv_Outlook.of_LookupAccount(as_MailBcc[i], ls_Account, 1) <> 0 then ls_Account = as_MailBcc[i]
	If is_SendProtocol = 'SMTP' Then
		iole_SmtpMail.AddRecipient(as_MailBcc[i], ls_Account, 3)  //BCC
	Else
		iole_EAMail.AddRecipient(as_MailBcc[i], ls_Account, 2)  //BCC
	End If
	if Len(ls_MailBcc) > 0 then ls_MailBcc += "; "
	ls_MailBcc += as_MailBcc[i]
next
of_emaillog('SendBcc', ls_MailBcc) //Added by (Appeon)Harry 08.11.2014 for Email Log

//---------Begin Added by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------//(Appeon)Harry 01.22.2014 - V142 ISG-CLX
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 11.17.2011
//$<reason> V12.1-Fax modification
if ib_combine_mail and upperbound(as_Attchment) > 1 then
	string  ls_outfile, ls_out[]
	
	if f_combine_file(as_Attchment, ls_outfile, 'email') = 1 then
		ls_out[1] = ls_outfile
		as_Attchment = ls_out
	end if
end if
//------------------- APPEON End -------------------
//---------End Added ------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 03.11.2014 for Bug # 3887--------
if not gb_contract_version  and gb_contract_module and al_ctx_id > 0 then
	of_set_combine_status(lb_combine_mail_temp)
end if
//---------End Added ------------------------------------------------------

// Add attachments
ls_Attachment = ''
for i = 1 to UpperBound(as_Attchment[])
	If is_SendProtocol = 'SMTP' Then 
		iole_SmtpMail.AddAttachment(as_Attchment[i], 0)
	Else
		iole_EAMail.AddAttachment(as_Attchment[i]) 
	End If

	ldec_filesize = lnv_filesrv.of_genfilesize(FileLength(as_Attchment[i]), ls_unit)
	If ls_Attachment = '' Then
		ls_Attachment =  of_GetAttchmentName(as_Attchment[i]) + ' (' +String(ldec_filesize) + ls_unit +  ')'
	Else
		ls_Attachment += '; ' + of_GetAttchmentName(as_Attchment[i]) + ' (' +String(ldec_filesize) + ls_unit +  ')'
	End If

next
If isvalid(lnv_filesrv) Then Destroy lnv_filesrv

//Add CTX key word for receive.
If gnv_data.of_getItem("icred_settings", "email_tag_mode", False) = '1' And &
   gnv_data.of_getItem("icred_settings", "receive_email", False) = '1' Then	//Added By Ken.Guo 2011-03-03. If No Receive Email Module, then needn't add keyword.
		If IsNull(al_ctx_id + al_doc_id + al_action_item_id) Or (al_ctx_id + al_doc_id + al_action_item_id) <> 0 Then //Add if statement for BugA081602 - Eugene 09.17.2013
			as_subject = This.of_add_keyword(as_subject, gstr_email_info.ss_ctx_id_list , gstr_email_info.ss_doc_id_list, gstr_email_info.ss_ai_id_list)
		End If
End If

// Send email
If is_SendProtocol = 'SMTP' Then 
	iole_SmtpMail.Subject = as_Subject
Else
	iole_EAMail.Subject = as_Subject
End If

if ai_Flag = 1 then
	
	If is_SendProtocol = 'SMTP' Then 
		iole_SmtpMail.BodyFormat = 0
		iole_SmtpMail.BodyText = as_Message
		
		//Modified By Ken.Guo 12/12/2011. http link has been wraped.
		//iole_SmtpMail.AutoWrap = 76		//Set to default value By jervis 02.17.2009
		If Pos(Lower(as_Message),'http://') > 0 or Pos(lower(as_Message),'https://') > 0 Then
			iole_SmtpMail.AutoWrap = 0
		Else
			iole_SmtpMail.AutoWrap = 76
		End If
	Else
		iole_EAMail.BodyFormat = 0
		iole_EAMail.BodyText = as_Message
	End If
	
	iblb_MailContent = Blob(as_Message) //Added By Ken.Guo 2010-10-18.
else
	//Added By Ken.Guo 12/11/2013
	If Not FileExists(as_HtmlFile) Then
		Return 1001
	End If
	
	If is_SendProtocol = 'SMTP' Then 
		iole_SmtpMail.BodyFormat = 1
		//If you set the body format to HTML, you should set the AutoWrap property to zero
		iole_SmtpMail.AutoWrap = 0		//02.17.2009 By jervis
		iole_SmtpMail.ImportBodyTextEx(as_HtmlFile, 2 + 4)
	Else
		iole_EAMail.BodyFormat = 1
		iole_EAMail.ImportMailEx(as_HtmlFile)
	End If
end if

//Added By Ken.Guo 2009-07-31. Add charset for email
ls_encoding = gnv_data.of_getitem('icred_settings', 'email_encoding', false)
If ls_encoding <> '' Then
	If is_SendProtocol = 'SMTP' Then 
		iole_SmtpMail.charset = ls_encoding
	Else
		iole_EAMail.charset = ls_encoding
	End If
End If 
	
If is_SendProtocol = 'SMTP' Then 
	//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
	//iole_SmtpMail.AddCustomHeader('X-FromContractLogix','Yes')
	iole_SmtpMail.AddCustomHeader('X-FromIntelliSoft','Yes') //Change 'X-FromContractLogix' for BugA081603 - Eugene 09.17.2013
	//---------End Modfiied ------------------------------------------------------
	If gstr_email_info.ss_ctx_id_list = '' Then
		iole_SmtpMail.AddCustomHeader('X-ContractID','N/A')
	Else
		iole_SmtpMail.AddCustomHeader('X-ContractID',gstr_email_info.ss_ctx_id_list)
	End If
	If gstr_email_info.ss_doc_id_list = '' Then
		iole_SmtpMail.AddCustomHeader('X-DocumentID','N/A')
	Else
		iole_SmtpMail.AddCustomHeader('X-DocumentID',gstr_email_info.ss_doc_id_list)
	End If
	If gstr_email_info.ss_ai_id_list = '' Then
		iole_SmtpMail.AddCustomHeader('X-ActionItemID','N/A')
	Else
		iole_SmtpMail.AddCustomHeader('X-ActionItemID',gstr_email_info.ss_ai_id_list)
	End If
Else
	//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
	//iole_EAMail.AddHeader('X-FromContractLogix','Yes')
	iole_EAMail.AddHeader('X-FromIntelliSoft','Yes')
	//---------End Modfiied ------------------------------------------------------
	If gstr_email_info.ss_ctx_id_list = '' Then
		iole_EAMail.AddHeader('X-ContractID','N/A')
	Else
		iole_EAMail.AddHeader('X-ContractID',gstr_email_info.ss_ctx_id_list)
	End If
	If gstr_email_info.ss_doc_id_list = '' Then
		iole_EAMail.AddHeader('X-DocumentID','N/A')
	Else
		iole_EAMail.AddHeader('X-DocumentID',gstr_email_info.ss_doc_id_list)
	End If
	If gstr_email_info.ss_ai_id_list = '' Then
		iole_EAMail.AddHeader('X-ActionItemID','N/A')
	Else
		iole_EAMail.AddHeader('X-ActionItemID',gstr_email_info.ss_ai_id_list)
	End If	
End If

//Added By Ken.Guo 03/15/2013. add log for debug mode.
If gnv_data.of_getitem('icred_settings', 'set_10', False) = '1' Then 
	This.of_setlog()
End If

If is_SendProtocol = 'SMTP' Then 
	ll_Result = iole_SmtpMail.Send()	
Else
	iole_EAMail.AutoCalendar = 0 //Added By Ken.Guo 01/07/2014
	ll_Result = iole_EAMail.SendMail()	
End If
//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
if ll_Result <> 0 then
	of_emaillog('Result', 'Error:' + String(ll_Result))
	FileWrite(il_EmailLogFileHandle,is_EmailMessage)
end if
is_EmailMessage = ""
//---------End Added ------------------------------------------------------
		
// Insert sent item if send successful
if ll_Result = 0 then
	ldt_sent = DateTime(Today(), Now())
	If is_SendProtocol = 'SMTP' Then 
		ls_from = iole_SmtpMail.FromAddr
	Else
		ls_from = iole_EAMail.FromAddr
	End If
	If Len(as_Subject) > 200 Then as_Subject = Mid(as_Subject, 1, 190) + '...'
	ls_ctx = gstr_email_info.ss_ctx_id_list 
	ls_doc = gstr_email_info.ss_doc_id_list 
	If Len(ls_ctx) > 2000 Then 
		ls_ctx = Mid(ls_ctx, 1, 990) 
		ls_ctx = Mid(ls_ctx, 1 , LastPos(ls_ctx,',') - 1)
	End If
	If Len(ls_doc) > 2000 Then 
		ls_doc = Mid(ls_doc, 1, 990) 
		ls_doc = Mid(ls_doc, 1 , LastPos(ls_doc,',') - 1)
	End If	
	
	ids_sent_msg.Reset()
	ids_sent_msg.InsertRow(0)
	ids_sent_msg.SetItem(1,'user_id',is_user_id)
	ids_sent_msg.SetItem(1,'folder_id',3)
	ids_sent_msg.SetItem(1,'sub_folder_id',3)
	ids_sent_msg.SetItem(1,'mail_msg_id','')
	ids_sent_msg.SetItem(1,'mail_date',ldt_sent)
	ids_sent_msg.SetItem(1,'mail_subject',as_Subject)
	ids_sent_msg.SetItem(1,'mail_importance',0)
	ids_sent_msg.SetItem(1,'mail_from',ls_from)
	ids_sent_msg.SetItem(1,'mail_to',ls_MailTo)
	ids_sent_msg.SetItem(1,'mail_cc',ls_MailCc)
	ids_sent_msg.SetItem(1,'mail_attach_name',ls_Attachment)
	ids_sent_msg.SetItem(1,'mail_fromclx',1)
	
	//Modified By Ken.Guo 10/26/2012
	if ai_Flag = 1 then
		ids_sent_msg.SetItem(1,'mail_save_format','txt')
	Else
		ids_sent_msg.SetItem(1,'mail_save_format','doc')
	End If
	
	ids_sent_msg.SetItem(1,'read_status',1)
	ids_sent_msg.SetItem(1,'locked',0)
	ids_sent_msg.SetItem(1,'deleted',0)
	ids_sent_msg.SetItem(1,'flag',0)
	ids_sent_msg.SetItem(1,'last_modify_date',ldt_sent)
	
	ids_sent_msg.SetItem(1,'ctx_id_list', ls_ctx ) //Added By Ken.Guo 2010-08-16. For Group Email Alarm
	ids_sent_msg.SetItem(1,'doc_id_list', ls_doc ) //Added By Ken.Guo 2010-10-26. For multi-select document and email.
	ids_sent_msg.SetItem(1,'mail_action_item_id',al_action_item_id)
	
	//For checkin document in email item
	If Pos(gstr_email_info.ss_ctx_id_list,',') = 0 Then
		ids_sent_msg.SetItem(1,'mail_ctx_id',Long(gstr_email_info.ss_ctx_id_list))
	End If
	If Pos(gstr_email_info.ss_doc_id_list,',') = 0 Then
		ids_sent_msg.SetItem(1,'mail_doc_id',Long(gstr_email_info.ss_doc_id_list))
	End If	
	
	If ids_sent_msg.Update() <> 1 Then
		//Messagebox('Error -101','Failed to save sent email to sent items.')
		Messagebox('Error -101','Failed to save sent email to sent items.' + '~r~n' + 'sqlcode:'+ string(sqlca.sqlcode) + ', sqlerrtext:' + sqlca.sqlerrtext) //(Appeon)Harry 03.31.2016 
		//ids_sent_msg.Reset()
		Return -101
	End If
	ll_id = 	ids_sent_msg.GetItemNumber(1,'id')
	//Added By Ken.Guo 2010-08-16.
	//Update Email Word File to DB
	If Len(iblb_MailContent) > 0 Then
		UPDATEBLOB em_mail_items SET mail_rfc822 = :iblb_MailContent WHERE id = :ll_id;
		If sqlca.sqlcode <> 0 Then
			Delete From em_mail_items Where id = :ll_id;
			Messagebox('Error -102','Failed to save sent email to sent items.')
			Return -102
		End If
	Elseif ai_Flag = 0 Then 
		//Added By Ken.Guo 2010-10-09.
		Delete From em_mail_items Where id = :ll_id;
		Messagebox('Error -103','Failed to save sent email to sent items.')
		Return -103		
	End If
	
	//Added By Ken.Guo 2010-04-12. Update Attachment to DB
	If UpperBound(as_Attchment[]) > 0 Then
		lds_mail_attach = Create DataStore
		lds_mail_attach.DataObject = "d_em_mail_attach"
		lds_mail_attach.SetTransObject(SQLCA)	
		For i = 1 to UpperBound(as_Attchment[])
			If Not FileExists(as_Attchment[i]) Then Continue
			inv_dm_utils.of_readblob( as_Attchment[i], lblb_attachment)
			ls_attach_filename = Mid(as_Attchment[i],LastPos(as_Attchment[i],'\') + 1, Len(as_Attchment[i]))
			
			lds_mail_attach.Reset()
			lds_mail_attach.InsertRow(0)
			lds_mail_attach.SetItem(1,'mail_item_id',ll_id)
			lds_mail_attach.SetItem(1,'attachment_name',ls_attach_filename)
			lds_mail_attach.SetItem(1,'type','a') //a: attachment
			lds_mail_attach.SetItem(1,'last_modify_date',ldt_sent)
			If lds_mail_attach.Update() = 1 Then
				ll_attach_id = lds_mail_attach.GetItemNumber(1,'id')
				UpdateBlob em_mail_item_attachments Set image_file = :lblb_attachment Where id = :ll_attach_id;
				If SQLCA.sqlcode <> 0 Then
					Delete from em_mail_item_attachments where id = :ll_attach_id;
					lds_mail_attach.Reset()
					Messagebox('Error -104','Failed to save the attachment "'+as_Attchment[i]+'" to Email Sent Items.')
					Continue
				End If
			Else
				lds_mail_attach.Reset()
				
			End If
		Next	
		Destroy lds_mail_attach
	End If

	//End - Modified By Ken.Guo 2010-04-02
	
	gs_CurAddresser = ""
end if

If isvalid(w_email_folder) and is_user_id = gs_user_id and ll_Result = 0 Then
	w_email_folder.Dynamic Function of_add_sentitem(ids_sent_msg)
End If

Return ll_Result

end function

public function string of_parse_value (string as_text);long ll_pos

ll_pos = Pos(as_text,'=')
If ll_pos < 0 Then Return ''
Return Trim(Mid(as_text,ll_pos + 1, Len(as_text)))
end function

public function string of_add_keyword (ref string as_subject, string as_ctx_id, string as_doc_id, string as_ai_id);//Subject Format 1: (CTX) 
//Subject Format 2: (CTX_ID = ###,###)
//Subject Format 3: (CTX_ID = ###,### & DOC_ID = ###,###)
//Subject Format 4: (CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###,###)

If of_get_keyword(as_subject,as_ctx_id,as_doc_id,as_ai_id) > 0 Then 
	Return as_subject
End If

If Len(as_ctx_id) > 0 Then
	as_subject = as_subject + ' (CTX_ID = ' +as_ctx_id
Else
	as_subject = as_subject + ' (CTX)'
	Return as_subject
End IF

If Len(as_doc_id) > 0 Then
	as_subject = as_subject + ' & DOC_ID = ' +as_doc_id
Else
	as_subject = as_subject + ')'
	Return as_subject	
End If

If Len(as_ai_id) > 0 Then
	as_subject = as_subject + ' & AI_ID = ' +as_ai_id + ')'
Else
	as_subject = as_subject + ')'
	Return as_subject	
End If


Return as_subject
end function

public function integer of_get_keyword (string as_subject, ref string as_ctx_id, ref string as_doc_id, ref string as_ai_id);//Subject Format 1: (CTX) 
//Subject Format 2: (CTX_ID = ###,###)
//Subject Format 3: (CTX_ID = ###,### & DOC_ID = ###,###)
//Subject Format 4: (CTX_ID = ###,### & DOC_ID = ###,### & AI_ID = ###,###)

Long ll_pos1,ll_pos2,ll_pos3,ll_pos4
String ls_ctx,ls_doc,ls_ai

as_subject = Upper(as_subject)

If Pos(as_subject,'CTX') <= 0 Then Return -1

ll_pos1 = Pos(as_subject,'CTX_ID')
If ll_pos1 <= 0 Then
	as_ctx_id = ''
	as_doc_id = ''
	as_ai_id = ''
	Return 1
End If

ll_pos2 = Pos(as_subject,'DOC_ID')
If ll_pos2 <= 0 Then
	ls_ctx = Mid(as_subject,ll_pos1, Pos(as_subject,')',ll_pos1) - ll_pos1)
	as_ctx_id = of_parse_value(ls_ctx)
	as_doc_id = ''
	as_ai_id = ''
	Return 1	
Else
	ls_ctx = Mid(as_subject,ll_pos1, Pos(as_subject,'&',ll_pos1) - ll_pos1)
	as_ctx_id = of_parse_value(ls_ctx)
End If

ll_pos3 = Pos(as_subject,'AI_ID')
If ll_pos3 <= 0 Then
	ls_doc = Mid(as_subject,ll_pos2, Pos(as_subject,')',ll_pos2) - ll_pos2)
	as_doc_id = of_parse_value(ls_doc)
	as_ai_id = ''
	Return 1		
Else
	ls_doc = Mid(as_subject,ll_pos2, Pos(as_subject,'&',ll_pos2) - ll_pos2)
	as_doc_id = of_parse_value(ls_doc)
	
	ls_ai = Mid(as_subject,ll_pos3, Pos(as_subject,')',ll_pos3) - ll_pos3)
	as_ai_id = of_parse_value(ls_ai)
End If


Return 1
end function

public subroutine of_set_global_var (long al_ctx_id, long al_doc_id, long al_ai_id);If gstr_email_info.ss_ctx_id_list = '' Then
	gstr_email_info.ss_ctx_id_list = String(al_ctx_id)
End If

If gstr_email_info.ss_doc_id_list = '' Then
	gstr_email_info.ss_doc_id_list = String(al_doc_id)
End If

If gstr_email_info.ss_ai_id_list = '' Then
	gstr_email_info.ss_ai_id_list = String(al_ai_id)
End If

If isnull(gstr_email_info.ss_ctx_id_list) Then gstr_email_info.ss_ctx_id_list = ''
If isnull(gstr_email_info.ss_doc_id_list) Then gstr_email_info.ss_doc_id_list = ''
If isnull(gstr_email_info.ss_ai_id_list) Then gstr_email_info.ss_ai_id_list = ''


Return 

end subroutine

public function string of_get_company_name (string as_ctx_id_list);DataStore lds_company
String ls_company 

lds_company = Create DataStore
lds_company.Dataobject = 'd_get_company_from_ctx'
lds_company.SetTransObject(SQLCA)
lds_company.Retrieve(as_ctx_id_list)

If lds_company.RowCount() = 1 Then
	ls_company = lds_company.GetItemString(1,'company')
	If isnull(ls_company) Then ls_company = ''
End If

Return ls_company
end function

public function string of_get_compute_info ();n_cst_systeminfo lnv_systeminfo
String ls_computer_name,ls_computer_ip
lnv_systeminfo = Create n_cst_systeminfo
ls_computer_name = lnv_systeminfo.of_get_computername()

ls_computer_ip = AppeonGetClientIp()



Return ls_computer_name + ' (' + ls_computer_ip + ')'
end function

public function integer of_getdefaultaccount (string as_userid, ref string as_server, ref long al_port, ref long al_authmode, ref string as_account, ref string as_password, ref string as_email, ref integer ai_smtpssl, ref integer ai_pop3ssl);Integer li_ad_status,li_ad_save_pwd, li_use_ad_pwd //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
String ls_ad_user, ls_ad_password //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
Boolean lb_ad_used_config //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)

gs_CurAddresser = as_UserID	

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.16.2016
//<$>reason:Copied from CLX, v15.3 AD Authentication
Select ad_status, ad_user, ad_password,ad_save_pwd into :li_ad_status, :ls_ad_user,:ls_ad_password,:li_ad_save_pwd  from security_users where user_id = :gs_CurAddresser;
If gnv_user_option.of_get_option_value('allow_ad_function') = '1'  and li_ad_status =1 and li_ad_save_pwd = 1 and Len(ls_ad_user) > 0 Then
	lb_ad_used_config = True
End If
//------------------- APPEON END -------------------

// Get default account of user
SELECT server,
		 port,
		 authmode,
		 account,
		 password,
		 email,
		 smtp_ssl,
		 pop3_ssl,
		 use_ad_password
  INTO :as_Server,
  		 :al_Port,
		 :al_Authmode,
		 :as_Account,
		 :as_Password,
		 :as_Email,
		 :ai_smtpssl,
		 :ai_pop3ssl,
		 :li_use_ad_pwd
  FROM em_smtp_accounts
 WHERE (user_id = :as_UserID) AND (is_default = 'Y');

if SQLCA.SQLCode = 0 then
	if Not IsNull(as_Password) then as_Password = in_encrypt.of_Decrypt(as_Password)		//Added by Scofield on 2008-11-12
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.16.2016
	//<$>reason:v15.3 AD Authentication
	If li_use_ad_pwd = 1 Then
		If lb_ad_used_config and Len(ls_ad_Password) >  0 Then
			as_Password = in_encrypt.of_Decrypt(ls_ad_Password)
			gnv_debug.of_output(false, 'Email Account for '+gs_CurAddresser+'. It uses AD saved password.')
		Else
			gnv_debug.of_output(false, 'It does not use AD saved password. the AD Account has not config for user '+gs_CurAddresser+'.')
		End If
	End If	
	//------------------- APPEON END -------------------
	
	Return 1
end if

// if there is no default account,then get the first account.
SELECT Top 1 server,
		 port,
		 authmode,
		 account,
		 password,
		 email,
		 smtp_ssl,
		 pop3_ssl,
		 use_ad_password
  INTO :as_Server,
  		 :al_Port,
		 :al_Authmode,
		 :as_Account,
		 :as_Password,
		 :as_Email,
		 :ai_smtpssl,
		 :ai_pop3ssl,
		 :li_use_ad_pwd
  FROM em_smtp_accounts
 WHERE user_id = :as_UserID;

if SQLCA.SQLCode = 0 then
	if Not IsNull(as_Password) then as_Password = in_encrypt.of_Decrypt(as_Password)		//Added by Scofield on 2008-11-12
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.16.2016
	//<$>reason:v15.3 AD Authentication
	If li_use_ad_pwd = 1 Then
		If lb_ad_used_config and Len(ls_ad_Password) > 0 Then
			as_Password = in_encrypt.of_Decrypt(ls_ad_Password)
			gnv_debug.of_output(false, 'Email Account for '+gs_CurAddresser+'. It uses AD saved password.')
		Else
			gnv_debug.of_output(false, 'It does not use AD saved password. the AD Account has not config for user '+gs_CurAddresser+'.')
		End If
	End If
	//------------------- APPEON END -------------------
	
	Return 1
else
	Return -1
end if

end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_word_edit au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id);//long 		ll_Port,ll_Authmode,
Long ll_DataLen,ll_Start,ll_Cycle,ll_Count
integer ll_Return
Blob		lblb_Signature,lb_Temp
//string 	ls_Server,ls_Account,ls_Password,
String ls_Email,ls_HtmlFile
long 		READ_ONE_LENGTH = 8000
//Integer li_smtpssl, li_pop3ssl

str_email_account lstr_email_account //Added By Ken.Guo 07/03/2013

// Set SMTP information from user ID
if of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 then Return -1
//Modified By Mark Lee 04/18/2013  if use the outlook  send the email, don't check the smtp
IF gi_email_type = 0 Then 
	ll_Return = of_SetSmtpInfo(lstr_email_account)
	if  ll_Return < 0 then return ll_Return
End IF 
ll_Return = of_SetAccountAddress(lstr_email_account)
if  ll_Return < 0 then return ll_Return

if ab_sign then
	SELECT Datalength(security_user_mailsetting.signature)
	  INTO :ll_DataLen
	  FROM security_user_mailsetting
	 WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	
	// Get signature from user ID
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_Cycle = 1 To ll_Count
			ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM security_user_mailsetting
				  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
			
			lblb_Signature += lb_Temp
		next
	else
		SELECTBLOB signature
				INTO :lblb_Signature
				FROM security_user_mailsetting
			  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	end if
	
	// Send email
	if Len(lblb_Signature) > 0 then
		// Merge signature
		au_email_edit.of_InsertFileLast(lblb_Signature)
	end if
end if

// Send email
of_set_global_var(al_ctx_id,al_doc_id,al_action_item_id)
is_user_id = as_UserID
If gnv_data.of_getItem("icred_settings", "email_tag_mode", False) = '2' And &
   gnv_data.of_getItem("icred_settings", "receive_email", False) = '1' Then	//Added By Ken.Guo 2011-03-03. If No Receive Email Module, then needn't add keyword.Then
		If IsNull(al_ctx_id + al_doc_id + al_action_item_id) Or (al_ctx_id + al_doc_id + al_action_item_id) <> 0 Then //Add if statement for BugA081602 - Eugene 09.17.2013
			au_email_edit.of_add_keyword(gstr_email_info.ss_ctx_id_list ,gstr_email_info.ss_doc_id_list,gstr_email_info.ss_ai_id_list)
		End If
End If
au_email_edit.of_GetBlob(iblb_MailContent)
//Begin - Added By Mark Lee 10/15/12
//ls_HtmlFile = au_email_edit.of_GetHtmlFile()
//ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
If  of_get_app_setting("set_56","I") = 1 then
	ls_HtmlFile  = au_email_edit.of_gettxtfile()
	is_AppointmentBody = ls_HtmlFile//added by gavins 20121024
Else 
	ls_HtmlFile = au_email_edit.of_GetHtmlFile()
	If ib_Appointment Then //added by gavins 20121024
		is_AppointmentBody = au_email_edit.of_gettxtfile()
	End If
End If
ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) 
//End - Added By Mark Lee 10/15/12

Return ll_Return

end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, u_word_edit au_email_edit, string as_attchment, boolean ab_sign);//Add by jervis 02.27.2009
return of_sendhtml(as_userid,as_mailto,as_mailcc,as_mailbcc,as_subject,au_email_edit,as_attchment,ab_sign,0,0,0)


end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, w_email_edit_alarm au_email_edit, string as_attchment, boolean ab_sign, long al_ctx_id, long al_doc_id, long al_action_item_id);//long 		ll_Port,ll_Authmode,
Long ll_DataLen,ll_Start,ll_Cycle,ll_Count
Blob		lblb_Signature,lb_Temp
//string 	ls_Server,ls_Account,ls_Password,
String ls_Email,ls_HtmlFile
long 		READ_ONE_LENGTH = 8000
//Integer li_smtpssl, li_pop3ssl

Integer ll_Return

str_email_account lstr_email_account 

// Set SMTP information from user ID
if of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 then Return -1
//Modified By Mark Lee 04/18/2013  if use the outlook  send the email, don't check the smtp
IF gi_email_type = 0 Then 
	ll_Return = of_SetSmtpInfo(lstr_email_account)
	if  ll_Return < 0 then return ll_Return
End If
ll_Return = of_SetAccountAddress(lstr_email_account)
if  ll_Return < 0 then return ll_Return

if ab_sign then
	SELECT Datalength(security_user_mailsetting.signature)
	  INTO :ll_DataLen
	  FROM security_user_mailsetting
	 WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	
	// Get signature from user ID
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_Cycle = 1 To ll_Count
			ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(signature,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM security_user_mailsetting
				  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
			
			lblb_Signature += lb_Temp
		next
	else
		SELECTBLOB signature
				INTO :lblb_Signature
				FROM security_user_mailsetting
			  WHERE security_user_mailsetting.user_id = :as_UserID AND flag = 1;
	end if
	
	// Send email
	if Len(lblb_Signature) > 0 then
		// Merge signature
		au_email_edit.of_InsertFileLast(lblb_Signature)
	end if
end if

// Send email
of_set_global_var(al_ctx_id,al_doc_id,al_action_item_id)
is_user_id = as_UserID
If gnv_data.of_getItem("icred_settings", "email_tag_mode", False) = '2' And &
   gnv_data.of_getItem("icred_settings", "receive_email", False) = '1' Then	//Added By Ken.Guo 2011-03-03. If No Receive Email Module, then needn't add keyword.Then
		If IsNull(al_ctx_id + al_doc_id + al_action_item_id) Or (al_ctx_id + al_doc_id + al_action_item_id) <> 0 Then //Add if statement for BugA081602 - Eugene 09.17.2013
			au_email_edit.of_add_keyword(gstr_email_info.ss_ctx_id_list ,gstr_email_info.ss_doc_id_list,gstr_email_info.ss_ai_id_list)
		End If
End If
au_email_edit.of_GetBlob(iblb_MailContent)
//Begin - Added By Mark Lee 10/15/12
//ls_HtmlFile = au_email_edit.of_GetHtmlFile()
//ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
If  of_get_app_setting("set_56","I") = 1 then
	ls_HtmlFile  = au_email_edit.of_gettxtfile()
	is_AppointmentBody = ls_HtmlFile//added by gavins 20121024
Else 
	ls_HtmlFile = au_email_edit.of_GetHtmlFile()
	If ib_Appointment Then //added by gavins 20121024
		is_AppointmentBody = au_email_edit.of_gettxtfile()
	End If
End If

ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, ls_HtmlFile, as_Attchment,al_ctx_id,al_doc_id,al_action_item_id) 
//End - Added By Mark Lee 10/15/12
Return ll_Return

end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, w_email_edit_alarm au_email_edit, string as_attchment, boolean ab_sign);//Add by jervis 02.27.2009
return of_sendhtml(as_userid,as_mailto,as_mailcc,as_mailbcc,as_subject,au_email_edit,as_attchment,ab_sign,0,0,0)


end function

public function integer of_send_smtp (string as_mailto[], string as_mailcc[], string as_mailbcc[], string as_subject, string as_message, string as_htmlfile, string as_attchment[], integer ai_flag, integer al_ctx_id, integer al_doc_id, integer al_action_item_id);//====================================================================
// Function: of_send_smtp
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_mailto[]
//                as_mailcc[]
//                as_mailbcc[]
//                as_subject
//                as_message
//                as_htmlfile
//                as_attchment[]
//                ai_flag
//                al_ctx_id
//                al_doc_id
//                al_action_item_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/15/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long   ll_id
long   i 
integer ll_Result = -1
string ls_MailTo
string ls_MailCc
string ls_MailBcc
string ls_Attachment,ls_attach_filename
string ls_Account
datastore lds_mail,lds_mail_attach
n_cst_outlook lnv_Outlook
string ls_encoding ,ls_from //Added By Ken.Guo 2009-07-31.
Datetime ldt_sent
Blob lblb_attachment
Long ll_attach_id
String ls_unit
decimal ldec_filesize
n_cst_filesrv lnv_filesrv
String ls_doc,ls_ctx

//Added By Mark Lee 10/15/12
mailmessage lmsg_send
mailReturnCode	mRet
mailsession lms_mail
Long			ll_cunt


lms_mail=create mailsession
mRet = lms_mail.maillogon(mailNewSession!)
if mRet <>mailreturnsuccess! then
	messagebox('IntelliSoft','log on email server failure!')
end if

lnv_filesrv = Create n_cst_filesrv

If al_ctx_id < 0 Then al_ctx_id = 0
If al_doc_id < 0 Then al_doc_id = 0
If al_action_item_id < 0 Then al_action_item_id = 0

of_set_global_var(al_ctx_id,al_doc_id,al_action_item_id)

if IsNull(as_Subject) then as_Subject = ""
if IsNull(as_Message) then as_Message = ""

// Add recipients
for i = 1 to UpperBound(as_MailTo[])
	if lnv_Outlook.of_LookupAccount(as_MailTo[i], ls_Account, 1) <> 0 then ls_Account = as_MailTo[i]  //jervis 08.09.2011
	//Begin - Added By Mark Lee 10/15/12
	ll_cunt++
	if pos(as_MailTo[i],'@')<=0 then
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailTo[i]
		lmsg_send.recipient[ll_cunt].name=as_MailTo[i]
	else
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailTo[i]
		lmsg_send.recipient[ll_cunt].name= left(as_MailTo[i],pos(as_MailTo[i],'@') - 1)
	end if
	lmsg_send.recipient[ll_cunt].recipienttype=mailto! 						
	//End - Added By Mark Lee 09/18/12

	if Len(ls_MailTo) > 0 then ls_MailTo += "; "
	ls_MailTo += as_MailTo[i]
next
for i = 1 to UpperBound(as_MailCc[])
	if lnv_Outlook.of_LookupAccount(as_MailCc[i], ls_Account, 1) <> 0 then ls_Account = as_MailCc[i]
	//Begin - Added By Mark Lee 09/18/12
	ll_cunt++
	if pos(as_MailCc[i],'@')<=0 then
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailCc[i]
		lmsg_send.recipient[ll_cunt].name=as_MailCc[i]
	else
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailCc[i]
		lmsg_send.recipient[ll_cunt].name= left(as_MailTo[i],pos(as_MailCc[i],'@') - 1)
	end if
	lmsg_send.recipient[ll_cunt].recipienttype=mailcc! 						
	//End - Added By Mark Lee 09/18/12
	if Len(ls_MailCc) > 0 then ls_MailCc += "; "
	ls_MailCc += as_MailCc[i]
next
for i = 1 to UpperBound(as_MailBcc[])
	if lnv_Outlook.of_LookupAccount(as_MailBcc[i], ls_Account, 1) <> 0 then ls_Account = as_MailBcc[i]
	//Begin - Added By Mark Lee 09/18/12
	ll_cunt++
	if pos(as_MailBcc[i],'@')<=0 then
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailBcc[i]
		lmsg_send.recipient[ll_cunt].name=as_MailBcc[i]
	else
		lmsg_send.recipient[ll_cunt].address='SMTP:'+as_MailBcc[i]
		lmsg_send.recipient[ll_cunt].name= left(as_MailTo[i],pos(as_MailBcc[i],'@') - 1)
	end if
	lmsg_send.recipient[ll_cunt].recipienttype=mailbcc! 						
	//End - Added By Mark Lee 09/18/12
	if Len(ls_MailBcc) > 0 then ls_MailBcc += "; "
	ls_MailBcc += as_MailBcc[i]
next

// Add attachments
ls_Attachment = ''
for i = 1 to UpperBound(as_Attchment[])
	//Begin - Added By Mark Lee 09/18/12
	lmsg_send.attachmentfile[i].filetype=mailattach!
	lmsg_send.attachmentfile[i].pathname=as_Attchment[i]	
//End - Added By Mark Lee 09/18/12	
	ldec_filesize = lnv_filesrv.of_genfilesize(FileLength(as_Attchment[i]), ls_unit)
	If ls_Attachment = '' Then
		ls_Attachment =  of_GetAttchmentName(as_Attchment[i]) + ' (' +String(ldec_filesize) + ls_unit +  ')'
	Else
		ls_Attachment += '; ' + of_GetAttchmentName(as_Attchment[i]) + ' (' +String(ldec_filesize) + ls_unit +  ')'
	End If

next
If isvalid(lnv_filesrv) Then Destroy lnv_filesrv

//Add CTX key word for receive.
If gnv_data.of_getItem("icred_settings", "email_tag_mode", False) = '1' And &
   gnv_data.of_getItem("icred_settings", "receive_email", False) = '1' Then	
		as_subject = This.of_add_keyword(as_subject, gstr_email_info.ss_ctx_id_list , gstr_email_info.ss_doc_id_list, gstr_email_info.ss_ai_id_list)
End If

// Send email
lmsg_send.subject=as_Subject 				//Added By Mark Lee 09/17/12
if ai_Flag = 1 then
	lmsg_send.notetext=as_Message			//Added By Mark Lee 09/17/12
	iblb_MailContent = Blob(as_Message) 	
end if

//Begin - Added By Mark Lee 10/12/12
mRet	=	lms_mail.mailsend(lmsg_send)
if mRet<>mailreturnsuccess! then
	messagebox('IntelliSoft','Sent email failure.'+'~r~n'+string(mRet))
else
	ll_Result = 0
//	messagebox('Contractlogix','sent email success.')
end if
//End - Added By Mark Lee 10/12/12

// Insert sent item if send successful
if ll_Result = 0 then
	ldt_sent = DateTime(Today(), Now())
//Begin - Added By Mark Lee 10/12/12
SELECT email_id 
INTO	:ls_from
FROM security_users  
   WHERE user_id = :is_user_id;	
//End - Added By Mark Lee 10/12/12
	
	If Len(as_Subject) > 200 Then as_Subject = Mid(as_Subject, 1, 190) + '...'
	ls_ctx = gstr_email_info.ss_ctx_id_list 
	ls_doc = gstr_email_info.ss_doc_id_list 
	If Len(ls_ctx) > 990 Then 
		ls_ctx = Mid(ls_ctx, 1, 990) 
		ls_ctx = Mid(ls_ctx, 1 , LastPos(ls_ctx,',') - 1)
	End If
	If Len(ls_doc) > 990 Then 
		ls_doc = Mid(ls_doc, 1, 990) 
		ls_doc = Mid(ls_doc, 1 , LastPos(ls_doc,',') - 1)
	End If	
	
	ids_sent_msg.Reset()
	ids_sent_msg.InsertRow(0)
	ids_sent_msg.SetItem(1,'user_id',is_user_id)
	ids_sent_msg.SetItem(1,'folder_id',3)
	ids_sent_msg.SetItem(1,'sub_folder_id',3)
	ids_sent_msg.SetItem(1,'mail_msg_id','')
	ids_sent_msg.SetItem(1,'mail_date',ldt_sent)
	ids_sent_msg.SetItem(1,'mail_subject',as_Subject)
	ids_sent_msg.SetItem(1,'mail_importance',0)
	ids_sent_msg.SetItem(1,'mail_from',ls_from)
	If Len(ls_MailTo) > 1990 Then ls_mailTo = Left(ls_MailTo, 1990) + '...' //Added By Ken.Guo 02/04/2013
	ids_sent_msg.SetItem(1,'mail_to',ls_MailTo)
	If Len(ls_MailCc) > 1990 Then ls_MailCc = Left(ls_MailCc, 1990) + '...' //Added By Ken.Guo 02/04/2013
	ids_sent_msg.SetItem(1,'mail_cc',ls_MailCc)
	ids_sent_msg.SetItem(1,'mail_attach_name',ls_Attachment)
	ids_sent_msg.SetItem(1,'mail_fromclx',1)
	ids_sent_msg.SetItem(1,'mail_save_format','txt') //Modified By Ken.Guo 10/26/2012. Modified 'doc' to 'txt'
	ids_sent_msg.SetItem(1,'read_status',1)
	ids_sent_msg.SetItem(1,'locked',0)
	ids_sent_msg.SetItem(1,'deleted',0)
	ids_sent_msg.SetItem(1,'flag',0)
	ids_sent_msg.SetItem(1,'last_modify_date',ldt_sent)
	
	ids_sent_msg.SetItem(1,'ctx_id_list', ls_ctx ) //Added By Ken.Guo 2010-08-16. For Group Email Alarm
	ids_sent_msg.SetItem(1,'doc_id_list', ls_doc ) //Added By Ken.Guo 2010-10-26. For multi-select document and email.
	ids_sent_msg.SetItem(1,'mail_action_item_id',al_action_item_id)
	
	//For checkin document in email item
	If Pos(gstr_email_info.ss_ctx_id_list,',') = 0 Then
		ids_sent_msg.SetItem(1,'mail_ctx_id',Long(gstr_email_info.ss_ctx_id_list))
	End If
	If Pos(gstr_email_info.ss_doc_id_list,',') = 0 Then
		ids_sent_msg.SetItem(1,'mail_doc_id',Long(gstr_email_info.ss_doc_id_list))
	End If	
	
	If ids_sent_msg.Update() <> 1 Then
		Messagebox('Error -101','Failed to save sent email to sent items.')
		//ids_sent_msg.Reset()
		Return -101
	End If
	ll_id = 	ids_sent_msg.GetItemNumber(1,'id')
	//Update Email Word File to DB
	If Len(iblb_MailContent) > 0 Then
		UPDATEBLOB em_mail_items SET mail_rfc822 = :iblb_MailContent WHERE id = :ll_id;
		If sqlca.sqlcode <> 0 Then
			Delete From em_mail_items Where id = :ll_id;
			Messagebox('Error -102','Failed to save sent email to sent items.')
			Return -102
		End If
	Elseif ai_Flag = 0 Then 
		Delete From em_mail_items Where id = :ll_id;
		Messagebox('Error -103','Failed to save sent email to sent items.')
		Return -103		
	End If
	
	If UpperBound(as_Attchment[]) > 0 Then
		lds_mail_attach = Create DataStore
		lds_mail_attach.DataObject = "d_em_mail_attach"
		lds_mail_attach.SetTransObject(SQLCA)	
		For i = 1 to UpperBound(as_Attchment[])
			If Not FileExists(as_Attchment[i]) Then Continue
			inv_dm_utils.of_readblob( as_Attchment[i], lblb_attachment)
			ls_attach_filename = Mid(as_Attchment[i],LastPos(as_Attchment[i],'\') + 1, Len(as_Attchment[i]))
			
			lds_mail_attach.Reset()
			lds_mail_attach.InsertRow(0)
			lds_mail_attach.SetItem(1,'mail_item_id',ll_id)
			lds_mail_attach.SetItem(1,'attachment_name',ls_attach_filename)
			lds_mail_attach.SetItem(1,'type','a') //a: attachment
			lds_mail_attach.SetItem(1,'last_modify_date',ldt_sent)
			If lds_mail_attach.Update() = 1 Then
				ll_attach_id = lds_mail_attach.GetItemNumber(1,'id')
				UpdateBlob em_mail_item_attachments Set image_file = :lblb_attachment Where id = :ll_attach_id;
				If SQLCA.sqlcode <> 0 Then
					Delete from em_mail_item_attachments where id = :ll_attach_id;
					lds_mail_attach.Reset()
					Messagebox('Error -104','Failed to save the attachment "'+as_Attchment[i]+'" to Email Sent Items.')
					Continue
				End If
			Else
				lds_mail_attach.Reset()
				
			End If
		Next	
		Destroy lds_mail_attach
	End If

	gs_CurAddresser = ""
end if

If isvalid(w_email_folder) and is_user_id = gs_user_id Then
	w_email_folder.Dynamic Function of_add_sentitem(ids_sent_msg)
End If

//Added By Mark Lee 09/17/12
lms_mail.maillogoff()
destroy lms_mail

Return ll_Result

end function

public subroutine of_setlog ();//

If isvalid(iole_SmtpMail) Then
	iole_SmtpMail.logfile = gs_dir_path + gs_DefDirName + '\Email.Log'
End If

If isvalid(iole_EAMail) Then
	iole_EAMail.LogFileName = gs_dir_path + gs_DefDirName + '\Email.Log'
End If


gnv_debug.of_output( true, 'Start sending emails.', false )


end subroutine

public function string of_gettempfile (string as_subject);//////////////////////////////////////////////////////////////////////
// $<function>u_email_editof_gettempfile()
// $<arguments>(None)
// $<returns> string
// $<description> Get the new temp file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-11 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_FileName,ls_FileName1
Long i,ll_max

ll_max = 1000 //max try times.
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Email\")
ls_FileName = gs_dir_path + gs_DefDirName + "\Email\"  

For i = 1 To ll_max
	ls_FileName =  ls_FileName + 'Appointment' +  String(i) + ".ics"
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "Email\ *.ics".',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
		
	Return ls_FileName
	
Next

Return ''
end function

public function string of_createappointment (string as_subject, string as_body, datetime adt_date, string as_type);//
String			ls_vcal, ls_attach_fullname, ls_Html, ls_keyword
Long			ll_Handle, ll_Pos, ll_pos2
n_cst_string	lnv_string


ls_attach_fullname = of_GetTempFile( '' )

as_body = lnv_string.of_globalreplace( as_body, '~r', '\n' )
as_body = lnv_string.of_globalreplace( as_body, '~n', '\n' )

//ls_keyword = '~r~n$$<|CTX_ID = '+as_ctx_id+' & DOC_ID = '+as_doc_id+' & AI_ID = '+String(as_ai_id)+'|>$$ - Do Not Delete'
ll_Pos = Pos( as_body,  '$$<|CTX_ID = ' ) 
If ll_Pos > 0 Then
	ll_Pos2 = Pos( as_body, '|>$$ - Do Not Delete' )
	as_body = Replace( as_body, ll_Pos, ll_Pos2 + Len( '|>$$ - Do Not Delete' ) - ll_Pos , '' )
End If

ls_vcal = "BEGIN:VCALENDAR"
ls_vcal += "~r~n"
ls_vcal += "PRODID:-//Microsoft Corporation//Outlook 11.0 MIMEDIR//EN"
ls_vcal += "~r~n"
ls_vcal += "VERSION:2.0"
ls_vcal += "~r~n"
ls_vcal += "METHOD:PUBLISH"
ls_vcal += "~r~n"
ls_vcal += "BEGIN:VEVENT"
ls_vcal += "~r~n"
If as_type = 'ALARM' Or   as_type = 'AIDUEDATE' Then
	ls_vcal += "DTEND:" + String( adt_date, 'yyyymmdd' ) + "T155900Z"
	ls_vcal += "~r~n"
	ls_vcal += "DTSTART:" +  string( RelativeDate ( date( adt_date ), -1 ), 'yyyymmdd' ) + "T160000Z"
Else
	ls_vcal += "DTSTART;VALUE=DATE:"+ String( adt_date, 'yyyymmdd' )
	ls_vcal += "~r~n"
	ls_vcal += "DTEND;VALUE=DATE:"+ string( RelativeDate ( date( adt_date ), 1 ), 'yyyymmdd' )
End If
ls_vcal += "~r~n"
ls_vcal += "TRANSP:TRANSPARENT"
ls_vcal += "~r~n"
ls_vcal += "SEQUENCE:0"
ls_vcal += "~r~n"
ls_vcal += "UID:040000008200E00074C5B7101A82E0080000000080C217A2BEB6CD010000000000000000100"
ls_vcal +=  "000006435B2D2FF0F704FA1A92F4DF446D5B8"+ String( today(), 'yyyymmdd' ) + string( now(), 'hhmmdd' ) +  string( rand(30000) ) 
ls_vcal += "~r~n"
ls_vcal += "DTSTAMP:" + string( today( ), 'yyyymmdd' ) + 'T' + string( now(), 'hhmmss' ) + 'Z' 
ls_vcal += "~r~n"
ls_vcal += "DESCRIPTION:" + as_body
ls_vcal += "~r~n"
ls_vcal += "SUMMARY:"+as_subject
ls_vcal += "~r~n"
ls_vcal += "PRIORITY:5"
ls_vcal += "~r~n"
ls_vcal += "X-MICROSOFT-CDO-IMPORTANCE:1"
ls_vcal += "~r~n"
ls_vcal += "CLASS:PUBLIC"
ls_vcal += "~r~n"
If as_type = 'ALARM' Then
	ls_vcal += "BEGIN:VALARM"  
	ls_vcal += "~r~n"
	ls_vcal += "TRIGGER:-PT20160M" 
	ls_vcal += "~r~n"
	ls_vcal += "ACTION:DISPLAY" 
	ls_vcal += "~r~n"
	ls_vcal += "DESCRIPTION:Reminder" 
	ls_vcal += "~r~n"
	ls_vcal += "END:VALARM" 
	ls_vcal += "~r~n"
End If
If as_type = 'AIDUEDATE' Then
	ls_vcal += "BEGIN:VALARM"  
	ls_vcal += "~r~n"
	ls_vcal += "TRIGGER:-PT10080M" 
	ls_vcal += "~r~n"
	ls_vcal += "ACTION:DISPLAY" 
	ls_vcal += "~r~n"
	ls_vcal += "DESCRIPTION:Reminder" 
	ls_vcal += "~r~n"
	ls_vcal += "END:VALARM" 
	ls_vcal += "~r~n"
End If
ls_vcal += "END:VEVENT"
ls_vcal += "~r~n"
ls_vcal += "END:VCALENDAR"

If Len( ls_attach_fullname ) > 0 Then
	ll_handle = fileopen( ls_attach_fullname, textmode! , write!, shared!, Replace!   )
	
	If FileWriteEx( ll_handle, ls_vcal ) < 0 Then
		gnv_debug.of_output( true, 'Failed to write *.ics ,subject=' + as_subject + ', date=' + string( adt_date ) )
		filedelete( ls_attach_fullname )
		fileclose( ll_handle )
		return ''
	End If
	
	Fileclose( ll_Handle )
End If



Return ls_attach_fullname

end function

public subroutine of_setappointmentarguments (boolean ab_appointment, datetime adt_appointmentdate, string as_appointmenttype);//is_AppointmentType = as_appointmenttype
//
//idt_AppointmentDate = adt_appointmentdate
//
//ib_Appointment = ab_appointment

of_setappointmentarguments( as_appointmenttype, adt_appointmentdate, ab_appointment , '' )
end subroutine

public subroutine of_setappointmentarguments (string as_appointmenttype, datetime adt_appointmentdate, boolean ab_appointment, string as_appointmenttoemail);is_AppointmentType = as_appointmenttype

idt_AppointmentDate = adt_appointmentdate

ib_Appointment = ab_appointment

is_AppointmentToEmail = as_appointmenttoemail
end subroutine

public function string of_createappointment2007 (string as_subject, string as_body, datetime adt_date, string as_type);//
String			ls_vcal, ls_attach_fullname, ls_Html
Long			ll_Handle
n_cst_string	lnv_string

ls_attach_fullname = of_GetTempFile( '' )

as_body = lnv_string.of_globalreplace( as_body, '~r~n', '\n' )
as_body = lnv_string.of_globalreplace( as_body, '~t', '  ' )
ls_Html = '<pre>' + as_body + '</pre></body></html>'

ls_vcal = "BEGIN:VCALENDAR"
ls_vcal += "~r~n"
ls_vcal += "PRODID:-//Microsoft Corporation//Outlook 12.0 MIMEDIR//EN"
ls_vcal += "~r~n"
ls_vcal += "VERSION:2.0"
ls_vcal += "~r~n"
ls_vcal += "METHOD:PUBLISH"
ls_vcal += "~r~n"
ls_vcal += "BEGIN:VEVENT"
ls_vcal += "~r~n"
ls_vcal += "DTSTART;VALUE=DATE:"+ String( adt_date, 'yyyymmdd' )
ls_vcal += "~r~n"
ls_vcal += "DTEND;VALUE=DATE:"+ string( RelativeDate ( date( adt_date ), 1 ), 'yyyymmdd' )
ls_vcal += "~r~n"
ls_vcal += "TRANSP:TRANSPARENT"
ls_vcal += "~r~n"
ls_vcal += "SEQUENCE:0"
ls_vcal += "~r~n"
ls_vcal += "DESCRIPTION:" + as_body
ls_vcal += "~r~n"
ls_vcal += "UID:040000008200E00074C5B7101A82E0080000000080C217A2BEB6CD010000000000000000100"
ls_vcal +=  "000006435B2D2FF0F704FA1A92F4DF446D5B8"+string( rand(30000) ) 
ls_vcal += "~r~n"
ls_vcal += 'X-ALT-DESC;FMTTYPE=text/html:<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">\n<HTML>\n<HEAD>\n<META NAME="Generator">\n<TITLE></TITLE>\n</HEAD>\n<BODY>\n<!-- Converted from text/rtf format -->\n\n' + ls_Html
ls_vcal += "~r~n"
ls_vcal += "DTSTAMP:" + string( today( ), 'yyyymmdd' ) + 'T' + string( now(), 'hhmmss' ) + 'Z' 
ls_vcal += "~r~n"
ls_vcal += "SUMMARY:"+as_subject
ls_vcal += "~r~n"
ls_vcal += "PRIORITY:5"
ls_vcal += "~r~n"
ls_vcal += "X-MICROSOFT-CDO-IMPORTANCE:1"
ls_vcal += "~r~n"
ls_vcal += "CLASS:PUBLIC"
ls_vcal += "~r~n"
If as_type = 'ALARM' Then
	ls_vcal += "BEGIN:VALARM"  
	ls_vcal += "~r~n"
	ls_vcal += "TRIGGER:-PT20160M" 
	ls_vcal += "~r~n"
	ls_vcal += "ACTION:DISPLAY" 
	ls_vcal += "~r~n"
	ls_vcal += "DESCRIPTION:Reminder" 
	ls_vcal += "~r~n"
	ls_vcal += "END:VALARM" 
	ls_vcal += "~r~n"
End If
If as_type = 'AIDUEDATE' Then
	ls_vcal += "BEGIN:VALARM"  
	ls_vcal += "~r~n"
	ls_vcal += "TRIGGER:-PT10080M" 
	ls_vcal += "~r~n"
	ls_vcal += "ACTION:DISPLAY" 
	ls_vcal += "~r~n"
	ls_vcal += "DESCRIPTION:Reminder" 
	ls_vcal += "~r~n"
	ls_vcal += "END:VALARM" 
	ls_vcal += "~r~n"
End If
ls_vcal += "END:VEVENT"
ls_vcal += "~r~n"
ls_vcal += "END:VCALENDAR"

If Len( ls_attach_fullname ) > 0 Then
	ll_handle = fileopen( ls_attach_fullname, textmode! , write!, shared!, Replace!   )
	
	If FileWriteEx( ll_handle, ls_vcal ) < 0 Then
		gnv_debug.of_output( true, 'Failed to write *.ics ,subject=' + as_subject + ', date=' + string( adt_date ) )
		filedelete( ls_attach_fullname )
		fileclose( ll_handle )
		return ''
	End If
	
	Fileclose( ll_Handle )
End If



Return ls_attach_fullname

end function

public function integer of_getdefaultaccount (string as_userid, ref str_email_account astr_email_account);//====================================================================
// Function: of_getdefaultaccount
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                ls_UserID
//                astr_emaill_account
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 07/03/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_Server,ls_Account,ls_Password,ls_Email,ls_sendprotocol
String ls_ad_user, ls_ad_password //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
Long ll_Port,ll_Authmode
Integer li_smtpssl,li_pop3ssl
Integer li_use_ad_pwd,li_ad_status,li_ad_save_pwd //Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)
Boolean lb_ad_used_config//Added by Appeon long.zhang 11.16.2016 (v15.3 AD Authentication)

gs_CurAddresser = as_UserID	
//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
of_emaillog('', "~r~n~r~n" +  String(Now(),"yyyy-mm-dd hh:mm:ss.fff") + " Logon User ID:" + gs_user_id)
of_emaillog('Addresser', as_UserID)
//---------End Added ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.16.2016
//<$>reason:v15.3 AD Authentication
Select ad_status, ad_user, ad_password,ad_save_pwd into :li_ad_status, :ls_ad_user,:ls_ad_password,:li_ad_save_pwd  from security_users where user_id = :gs_CurAddresser;
If gnv_user_option.of_get_option_value('allow_ad_function') = '1'  and li_ad_status =1 and li_ad_save_pwd = 1 and Len(ls_ad_user) > 0 Then
	lb_ad_used_config = True
End If
//------------------- APPEON END -------------------

// Get default account of user
SELECT server,
		 port,
		 authmode,
		 account,
		 password,
		 email,
		 smtp_ssl,
		 pop3_ssl,
		 sendprotocol,
		 use_ad_password
  INTO :ls_Server,
  		 :ll_Port,
		 :ll_Authmode,
		 :ls_Account,
		 :ls_Password,
		 :ls_Email,
		 :li_smtpssl,
		 :li_pop3ssl,
		 :ls_sendprotocol,
		 :li_use_ad_pwd
  FROM em_smtp_accounts
 WHERE (user_id = :as_UserID) AND (is_default = 'Y');

if SQLCA.SQLCode = 0 then
	if Not IsNull(ls_Password) then ls_Password = in_encrypt.of_Decrypt(ls_Password)		//Added by Scofield on 2008-11-12
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.16.2016
	//<$>reason:v15.3 AD Authentication
	If li_use_ad_pwd = 1 Then
		If lb_ad_used_config and len(ls_ad_Password) > 0 Then
			ls_Password = in_encrypt.of_Decrypt(ls_ad_Password)
			gnv_debug.of_output(false, 'Email Account for '+gs_CurAddresser+'. It uses AD saved password.')
		Else
			gnv_debug.of_output(false, 'It does not use AD saved password. the AD Account has not config for user '+gs_CurAddresser+'.')
		End If
	End If
	//------------------- APPEON END -------------------
	
	astr_email_account.as_user_id = as_userid
	astr_email_account.as_sendserver = ls_Server
	astr_email_account.al_sendport = ll_Port
	astr_email_account.ai_sendauthmode = ll_Authmode
	astr_email_account.as_account = ls_Account
	astr_email_account.as_password = ls_Password
	astr_email_account.as_emailaddress = ls_Email
	astr_email_account.ai_sendssl = li_smtpssl
	astr_email_account.ai_receivessl = li_pop3ssl
	astr_email_account.as_sendprotocol = ls_sendprotocol
	Return 1
end if

// if there is no default account,then get the first account.
SELECT Top 1 server,
		 port,
		 authmode,
		 account,
		 password,
		 email,
		 smtp_ssl,
		 pop3_ssl,
		 sendprotocol,
		 use_ad_password
  INTO :ls_Server,
  		 :ll_Port,
		 :ll_Authmode,
		 :ls_Account,
		 :ls_Password,
		 :ls_Email,
		 :li_smtpssl,
		 :li_pop3ssl,
		 :ls_sendprotocol,
		 :li_use_ad_pwd
  FROM em_smtp_accounts
 WHERE user_id = :as_UserID;

if SQLCA.SQLCode = 0 then
	if Not IsNull(ls_Password) then ls_Password = in_encrypt.of_Decrypt(ls_Password)		//Added by Scofield on 2008-11-12
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.16.2016
	//<$>reason:v15.3 AD Authentication
	If li_use_ad_pwd = 1 Then
		If lb_ad_used_config and Len(ls_ad_Password) > 0 Then
			ls_Password = in_encrypt.of_Decrypt(ls_ad_Password)
			gnv_debug.of_output(false, 'Email Account for '+gs_CurAddresser+'. It uses AD saved password.')
		Else
			gnv_debug.of_output(false, 'It does not use AD saved password. the AD Account has not config for user '+gs_CurAddresser+'.')
		End If
	End If
	//------------------- APPEON END -------------------
	
	astr_email_account.as_user_id = as_userid
	astr_email_account.as_sendserver = ls_Server
	astr_email_account.al_sendport = ll_Port
	astr_email_account.ai_sendauthmode = ll_Authmode
	astr_email_account.as_account = ls_Account
	astr_email_account.as_password = ls_Password
	astr_email_account.as_emailaddress = ls_Email
	astr_email_account.ai_sendssl = li_smtpssl
	astr_email_account.ai_receivessl = li_pop3ssl	
	astr_email_account.as_sendprotocol = ls_sendprotocol
	
	Return 1
else
	Return -1
end if

end function

public function integer of_createobject_ea ();long ll_Result

// Create SMTP object
if Not IsValid(iole_EAMail) then
	iole_EAMail = Create OLEObject	
end if

ll_Result = iole_EAMail.ConnectToNewObject("EASendMailObj.Mail")

// Set license key
if ll_Result = 0 then
	iole_EAMail.LicenseCode = 'ES-B1331025340-00269-E4E1D9F83CAV3UCD-1F97C41879AB8B89'
else
	Return -1
end if


Return 1
end function

public function integer of_setsmtpinfo (str_email_account astr_email_account);//====================================================================
// Function: of_setsmtpinfo
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                astr_email_account
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 07/03/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================



if IsNull(astr_email_account.as_SendServer ) then
	//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server address can not be null.')
	return -14
end if

if IsNull(astr_email_account.al_SendPort ) then
	//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server port can not be null.')
	return -15
end if

is_SendProtocol = astr_email_account.as_SendProtocol
Choose Case astr_email_account.as_SendProtocol
	Case 'SMTP'
		
		if IsNull(astr_email_account.ai_SendAuthMode ) then
			//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server Secure Password Authentication can not be null.')
			return -16
		end if	
		
		iole_SmtpMail.MailServer = astr_email_account.as_SendServer
		iole_SmtpMail.MailPort = astr_email_account.al_SendPort
		iole_SmtpMail.ESMTP_AuthMode = astr_email_account.ai_SendAuthMode
		
		//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
		of_emaillog('MailServer', astr_email_account.as_SendServer)
		of_emaillog('MailPort', String(astr_email_account.al_SendPort))
		of_emaillog('ESMTP_AuthMode', String(astr_email_account.ai_SendAuthMode))
		//---------End Added ------------------------------------------------------
		
		//Start Code by jervis 08052008
		//The SMTP Authentication standard calls for a parameter after the FROM address when 
		//sending authenticated email. Some mail server do not support this correctly. 
		//Turn off the parameter by setting the optionflags property
		iole_SmtpMail.optionflags =256
		//End code by Jervis 08052008
		
		iole_SmtpMail.BodyEncoding = 1 //02.17.2009 By Jervis
		
		//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
		Choose Case astr_email_account.ai_sendssl
			Case 0
				of_emaillog('SendSSL', 'None')
			Case 1
				of_emaillog('SendSSL', 'SSL')
			Case 2
				of_emaillog('SendSSL', 'TLS')
		End Choose
		//---------End Added ------------------------------------------------------
		
		//Added By Ken 09/22/2011. //modified by gavins 20121010       add  '2'  for tls
		If astr_email_account.ai_sendssl = 1 Or astr_email_account.ai_sendssl = 2  Then
			iole_SmtpMail.SSL = iole_SmtpSSL
			If astr_email_account.ai_sendssl = 2 Then
				iole_SmtpMail.StartTLS = 1
			End If
		End If
		
		iole_SmtpMail.Timeout = 60 //Added by Appeon long.zhang 07.13.2015 (SMTP timeout error Case# 55702)
	Case 'OUTLOOK'
		//
	Case Else //EASendMail: Exchange2003 | Exchange 2007
		If Not Isvalid(iole_EAMail) Then
			This.of_createobject_ea( )
		End If
		If Pos(astr_email_account.as_SendProtocol, '2007') > 0 Then
			iole_EAMail.Protocol = 1 //Exchange 2007 or above
		Else
			iole_EAMail.Protocol = 2 //Exchange 2000/2003
		End If
		//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
		iole_EAMail.Timeout = 300 //Added By Ken.Guo 04/03/2014
		//---------End Added ------------------------------------------------------
		iole_EAMail.ServerAddr = astr_email_account.as_SendServer
		iole_EAMail.AuthType = astr_email_account.ai_SendAuthMode_Exchange
		If astr_email_account.ai_sendssl = 1 or astr_email_account.ai_sendssl = 2 Then
			iole_EAMail.SSL_init()
		Else
			iole_EAMail.SSL_uninit()
		End If
			
End Choose

Return 1
end function

public function integer of_setaccountaddress (str_email_account astr_email_account);if IsNull(astr_email_account.as_account ) then
	astr_email_account.as_account = ""
end if

if IsNull(astr_email_account.as_Password) then
	astr_email_account.as_Password = ""
end if

if IsNull(astr_email_account.as_EmailAddress) then
	//MessageBox(gnv_app.iapp_object.DisplayName,'EMail Address can not be null.')
	return -13
end if

If Isvalid(iole_SmtpMail) Then
	iole_SmtpMail.ESMTP_Account = astr_email_account.as_account
	iole_SmtpMail.ESMTP_Password = astr_email_account.as_Password
	iole_SmtpMail.FromAddr = astr_email_account.as_EmailAddress
End If

//Added By Ken.Guo 07/03/2013
If Isvalid(iole_EAMail) Then
	iole_EAMail.UserName = astr_email_account.as_account
	iole_EAMail.Password = astr_email_account.as_Password
	iole_EAMail.FromAddr = astr_email_account.as_EmailAddress
End If

//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
of_emaillog('UserName', astr_email_account.as_account)
of_emaillog('From Address', astr_email_account.as_EmailAddress)
//---------End Added ------------------------------------------------------
		
Return 1

end function

public function integer of_setsmtpinfo_old (string as_mailserver, long al_mailport, long al_authmode, integer ai_smtpssl);//
//if IsNull(as_MailServer) then
//	//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server address can not be null.')
//	return -14
//end if
//
//if IsNull(al_MailPort) then
//	//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server port can not be null.')
//	return -15
//end if
//
//if IsNull(al_AuthMode) then
//	//MessageBox(gnv_app.iapp_object.DisplayName,'SMTP Server Secure Password Authentication can not be null.')
//	return -16
//end if
//
//iole_SmtpMail.MailServer = as_MailServer
//iole_SmtpMail.MailPort = al_MailPort
//iole_SmtpMail.ESMTP_AuthMode = al_AuthMode
//
////Start Code by jervis 08052008
////The SMTP Authentication standard calls for a parameter after the FROM address when 
////sending authenticated email. Some mail server do not support this correctly. 
////Turn off the parameter by setting the optionflags property
//iole_SmtpMail.optionflags =256
////End code by Jervis 08052008
//
//iole_SmtpMail.BodyEncoding = 1 //02.17.2009 By Jervis
//
////Added By Ken 09/22/2011. //modified by gavins 20121010       add  '2'  for tls
//If ai_smtpssl = 1 Or ai_smtpssl = 2  Then
//	iole_SmtpMail.SSL = iole_SmtpSSL
//	If ai_smtpssl = 2 Then
//		iole_SmtpMail.StartTLS = 1
//	End If
//End If
Return 1
//
end function

public function string of_gettempfile (string as_filename, string as_fileext);
//Added By Ken.Guo 12/11/2013
String ls_FileName,ls_FileName1, ls_filepath,ls_EmailDirectory
Long i,ll_max

ll_max = 1000 //max try times.

ls_filepath = gs_dir_path + gs_DefDirName + "\Email"
gnv_appeondll.of_parsepath(ls_filepath)
IF NOT DirectoryExists(ls_filepath) THEN RETURN ""

For i = 1 To ll_max
	ls_FileName = ls_filepath + "\" + as_filename + String(i) + "." + as_fileext
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "'+ls_filepath + '\'+as_filename+'*.'+as_fileext+'". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	ls_FileName1 = ls_filepath + "\~~$" + as_filename + String(i) + "." + as_fileext	 
	If FileExists(ls_filename1) Then
		If Not FileDelete(ls_filename1) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "'+ls_filepath + '\'+as_filename+'*.'+as_fileext+'". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	If i <> 1 Then gnv_debug.of_output(True, 'Failed to delete the ' + ls_filepath + '\' + as_filename + "*." + as_fileext + ' file. Now using ' + as_filename + String(i) +  "." + as_fileext + '.')
	Return ls_FileName
	
Next

Return ''
end function

public function integer of_sendhtml (string as_userid, string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_htmlfile, string as_attchment);//====================================================================
//$<Function>: of_sendhtml
//$<Arguments>:
// 	value    string    as_userid
// 	value    string    as_mailto
// 	value    string    as_mailcc
// 	value    string    as_mailbcc
// 	value    string    as_subject
// 	value    string    as_htmlfile
// 	value    string    as_attchment
//$<Return>:  integer
//$<Description>: from ISG
//$<Author>: (Appeon) Eugene 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
// (Appeon)Harry 01.22.2014 - V142 ISG-CLX Copy from ISG14.1
//====================================================================

//Send mail with mail authorization checking and sent items logging - Alfee 09.02.2011

long ll_Return, ll_Port, ll_Authmode
string ls_MailTo[], ls_MailCc[], ls_MailBcc[], ls_Attchment[]
string	ls_Server, ls_Account, ls_Password, ls_Email
Integer li_smtpssl, li_pop3ssl //Alfee 09.24.2013

//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
/*
// Set SMTP information from user ID
//if of_GetDefaultAccount(as_UserID,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email) = -1 then Return -1
if of_GetDefaultAccount(as_UserID,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email,li_smtpssl, li_pop3ssl) = -1 then Return -1 //BugA083002 - Alfee 09.24.2013


//ll_Return = of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode)
ll_Return = of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode,li_smtpssl) //BugA083002 - Alfee 09.24.2013
*/
str_email_account lstr_email_account 
if of_GetDefaultAccount(as_UserID,lstr_email_account) = -1 then Return -1
ll_Return = of_SetSmtpInfo(lstr_email_account)
//---------End Modfiied ------------------------------------------------------

if  ll_Return < 0 then return ll_Return

//ll_Return = of_SetAccountAddress(ls_Account, ls_Password, ls_Email)
ll_Return = of_SetAccountAddress(lstr_email_account) //(Appeon)Harry 06.05.2014 - V142 ISG-CLX
if  ll_Return < 0 then return ll_Return

is_user_id = as_UserID

//Get mail content for logging in email sent items
u_email_edit luo_email_edit
luo_email_edit = Create u_email_edit
luo_email_edit.of_readfile(luo_email_edit.of_GetEmailDir() + "\Email.doc", iblb_mailcontent)
Destroy luo_email_edit

// Send email
ll_Return = of_SendHtml(as_MailTo, as_MailCc, as_mailBcc, as_Subject, as_htmlfile, as_Attchment)

Return ll_Return
end function

public subroutine of_set_combine_status (boolean ab_status);//(Appeon)Harry 02.19.2014 - for Bug # 3887
ib_combine_mail = ab_status

end subroutine

public subroutine of_emaillog (string as_name, string as_value);//====================================================================
// Function: of_emaillog
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_name
//                as_value
//--------------------------------------------------------------------
// Returns:  None
//--------------------------------------------------------------------
// Author:        Harry          Date: 07/03/2014
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String ls_message
IF FileExists(is_EmailLogFile) THEN
	IF FileLength(is_EmailLogFile) > 2097152 THEN //2M
		FileClose(il_EmailLogFileHandle)
		FileCopy(is_EmailLogFile,is_EmailLogFile+".bak",True)
		FileDelete(is_EmailLogFile)
		
		il_EmailLogFileHandle = FileOpen(is_EmailLogFile,StreamMode!,Write!,Shared!,append!)
	END IF
END IF

if isnull(as_name) or len(as_name) <= 0 then
	ls_message = as_value
else
	ls_message = "~r~n"+ as_name + " = " + as_value
end if

is_EmailMessage = is_EmailMessage + ls_message
//FileWrite(il_EmailLogFileHandle,ls_message)
end subroutine

on n_cst_easymail_smtp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_easymail_smtp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;of_DeleteObject()
If isvalid(ids_sent_msg) Then Destroy  ids_sent_msg

FileClose(il_EmailLogFileHandle) //(Appeon)Harry 07.03.2014 - Email Log
end event

event constructor;ids_sent_msg = Create n_ds
ids_sent_msg.DataObject = 'd_em_items'
ids_sent_msg.SetTransObject(SQLCA)


//For IntelliContract - (BugA082104) Alfee 09.24.2013
If gb_contract_version Then ib_combine_mail = False 

if isnull(gs_dir_path) or gs_dir_path='' then return //(Appeon)Stephen 08.07.2014 - BugS073101
//---------Begin Added by (Appeon)Harry 07.03.2014 for Email Log--------
is_EmailLogFile = gs_dir_path + gs_DefDirName + "\EmailDebug.log"
IF NOT directoryexists( gs_dir_path + gs_DefDirName) THEN
	createdirectory( gs_dir_path + gs_DefDirName)
END IF

il_EmailLogFileHandle = FileOpen(is_EmailLogFile,StreamMode!,write!,shared!,append!)
//---------End Added ------------------------------------------------------
end event

