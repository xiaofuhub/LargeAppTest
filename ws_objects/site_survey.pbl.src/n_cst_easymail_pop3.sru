$PBExportHeader$n_cst_easymail_pop3.sru
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type n_cst_easymail_pop3 from nonvisualobject
end type
end forward

global type n_cst_easymail_pop3 from nonvisualobject autoinstantiate
end type

type variables
OLEObject iole_POP3Mail,iole_message,iole_POP3SSL
DataStore ids_download_msg_id,ids_new_msg_id,ids_mail_attach
n_ds ids_received_msg
n_cst_encrypt in_Encrypt
StaticText ist_info
n_cst_dm_utils inv_dm_utils
w_Email_edit iw_Email_edit
Datawindow idw_em_inbox
n_cst_filesrv inv_cst_filesrv
Long il_received_cnt,il_ignored_cnt,il_err_cnt
String is_retrieve_type //"Auto",""
n_cst_easymail_smtp inv_easy_smtp
oleobject iole_word

String is_status  
Constant String IS_PROCESSING ='processing', IS_STOPING = 'stoping' , IS_COMPLETE = 'complete'

string	is_Messageid, is_Messagedate //added by gavins 20121121
end variables

forward prototypes
public function integer of_createobject ()
public subroutine of_setaccount (string as_account, string as_pwd)
public function boolean of_pingserver (boolean ab_show_msg)
public function long of_getmessageidlist ()
public function string of_get_email_tempdir ()
public function integer of_connect_pop3 (string as_user_id)
public function long of_get_email_list ()
public subroutine of_display (string as_info)
public subroutine of_set_tip_object (statictext ast_text)
public function string of_get_attach_list (oleobject aole_message)
public function integer of_disconnect_pop3 ()
public subroutine of_set_status (string as_status)
public function integer of_update_register (long al_email_id, string as_email_type, datetime adt_modify_date)
public function string of_get_email_name (long al_email_id, string as_email_type)
public function string of_get_Email_cachedir ()
public function string of_download_email (long al_mail_id, string as_email_type)
public function string of_eml2word (long al_email_id, string as_eml_file)
public function integer of_string2word (string as_text, string as_filename)
public function integer of_cache_msg_id (string as_user_id, string as_msg_id, integer ii_downloaded, string as_notes)
public function integer of_modify_file (string as_file)
public subroutine of_refresh_inbox ()
public subroutine of_set_inbox_dw (datawindow adw_inbox)
public function string of_get_Email_attachdir (long al_Emailid, string as_type)
public function string of_gen_nextfilename (string as_filename, integer ai_index)
public function boolean of_check_register (long al_email_id, string as_email_type, ref datetime adt_modify)
public function boolean of_check_register_attach (long al_attachid, string as_attach_name, ref datetime adt_modify)
public function integer of_update_register_attach (long al_attachment_id, string as_attach_fullname, datetime adt_modify_date)
public function datetime of_get_Email_date (oleobject aole_message)
public subroutine of_stop_receive ()
public function integer of_update_Email_blob (long al_Email_id, oleobject aole_message, string as_bodytext, ref string as_errtext)
public function string of_get_sort_rule (long al_maxrow)
public function long of_receive_msg (boolean ab_batch)
public function integer of_receive_Emails (string as_type)
public function integer of_log (string as_msg_id, string as_exe_type, long al_err_code, string as_err_text)
public function string of_download_attachment (long al_mail_id, long al_attach_id, string as_attach_name, string as_attach_type)
public function integer of_download_attachments (long al_Email_id, ref string as_attachlist[], ref string as_mimelist[], integer ai_type)
public function integer of_get_attach_mime (long al_mail_id, string as_eml_file, ref string as_attachlist[], ref string as_mimelist[], integer ai_type)
public function long of_receive_msg (string as_msg_id, boolean ab_checkbody)
public function integer of_do_attach (string as_emlfile, long al_emailid, long al_index, string as_dotype, ref string as_exportfile)
public function string of_get_ref_docname (long al_doc_id)
public function integer of_parse_msg (string as_msgfile, ref string as_from, ref string as_to, ref string as_cc, ref string as_bcc, ref string as_subject, ref string as_bodydocfile, ref datetime adt_date, ref integer ai_importtance, ref string as_attachlist[], integer ai_readed)
public function integer of_import_msg (str_import_msg astr_msg)
public function integer of_doc2html (string as_docname, ref string as_htmlname)
public function string of_eml2html (long al_email_id, string as_eml_file)
public function integer of_save_msg (integer ai_folder_id, integer ai_sub_folder_id, string as_subject, string as_bodydocfile, integer ai_importance, string as_from, string as_to, string as_cc, string as_attachlist[], datetime adt_email_date, integer ai_readed, string as_ctx_id, string as_doc_id, string as_ai_id)
public function long of_getunreademailcount (long al_email_folder_id, string as_user_id)
public function string of_get_attachname (oleobject aole_attachment)
public function integer of_setpop3info (string as_pop3server, integer al_pop3port, integer ai_pop3ssl)
public function integer of_setattachment (long al_emailid, long al_doc_id, string as_eml_file, ref string as_attach_list, ref u_lv_attachment alv_attach)
end prototypes

public function integer of_createobject ();long ll_Result

// Create POP3 object
if Not IsValid(iole_pop3Mail) then
	iole_pop3Mail = Create OLEObject	
end if

ll_Result = iole_pop3Mail.ConnectToNewObject("EasyMail.POP3")

// Set license key
if ll_Result = 0 then
	iole_pop3Mail.LicenseKey = 'Contractlogix (Single Developer)/00A0630310E21F00FB85'
else
	Return -1
end if


//Added By Ken 09/22/2011. 
// Create SMTP SSL object .
if Not IsValid(iole_POP3SSL) then
	iole_POP3SSL = Create OLEObject	
end if

ll_Result = iole_POP3SSL.ConnectToNewObject("EasyMail.SSL")

// Set license key
if ll_Result = 0 then
	iole_POP3SSL.LicenseKey = 'contractlogix (Single Developer)/00A0630510E253001C81'
	Return 1
else
	Return -2
end if

end function

public subroutine of_setaccount (string as_account, string as_pwd);If isnull(as_account) then as_account = ''
If isnull(as_pwd) then as_pwd = ''

iole_POP3Mail.Account = as_account
iole_POP3Mail.Password = as_pwd
end subroutine

public function boolean of_pingserver (boolean ab_show_msg);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_pingserver()
// $<arguments>
//		value	boolean	ab_show_msg		
// $<returns> boolean
// $<description> Connect to Server.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-03-25 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_ret 
String ls_errtext
ll_ret = iole_POP3Mail.Connect()
If ll_ret = 0 Then Return True
This.is_status = This.is_complete
Choose Case ll_ret
	Case 1 
		ls_errtext = 'Error connecting to host.'
	Case 2
		ls_errtext = 'Bad user name.'
	Case 3
		ls_errtext = 'A pending operation is in progress.'
	Case 4
		ls_errtext = 'Bad user name or password.'
	Case 6
		ls_errtext = 'Already connected to a mail server.'
	Case 7
		ls_errtext = 'The operation was canceled.'
	Case 11
		ls_errtext = 'Could not resolve host.'
	Case 12
		ls_errtext = 'Time out while trying to resolve host.'
	Case 13
		ls_errtext = 'Time out while trying to connect to host.'
	Case 32
		ls_errtext = 'A socket error has occurred.'
	Case 105
		ls_errtext = 'Invalid license key.'
	Case 128
		ls_errtext = 'Could not create thread.'
	Case 1024	
		ls_errtext = 'No authorization mode.'
End Choose		
If ab_show_msg Then
	Messagebox('POP3 testing','Failed to connect to POP3 Server. ~r~n'+ls_errtext)
End If
Return False

end function

public function long of_getmessageidlist ();String ls_msg_id

ls_msg_id = iole_POP3Mail.GetMessageIDList('~r~n',0)
ids_download_msg_id.ImportString(Text!,ls_msg_id)
Return ids_download_msg_id.rowcount()

end function

public function string of_get_email_tempdir ();String ls_EmailDirectory

ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email\POP3\Temp"
gnv_appeondll.of_parsepath(ls_EmailDirectory)
IF NOT DirectoryExists(ls_EmailDirectory) THEN 
	Messagebox('Email','Failed to create the Email temp directory '+ls_EmailDirectory+', please call support.')
	Return  gs_dir_path + gs_DefDirName
End If

gnv_rights.of_check_dir_right(ls_EmailDirectory, true, 'Email')
Return ls_EmailDirectory
end function

public function integer of_connect_pop3 (string as_user_id);String ls_server,ls_account,ls_pwd
Long ll_port
Integer li_pop3ssl

Of_display('Connecting POP Server...')
Select pop3_server,pop3_port,account,password,pop3_ssl
Into  :ls_server,:ll_port,:ls_account,:ls_pwd,:li_pop3ssl
From em_smtp_accounts
Where user_id = :as_user_id and is_default = 'Y';
If sqlca.sqlcode <> 0 Then
	is_status = IS_COMPLETE
	Messagebox('Email','You do not have Email account yet, please config it first.')
	Return -3
End If

If isnull(ls_server) or ls_server = '' or isnull(ll_port) or ll_port = 0 Then
	is_status = IS_COMPLETE
	Messagebox('Email','You have NOT configured the Incoming Mail settings, please configure it in the Email Account Maintenance window first.')
	Return -4	
End If

If ls_pwd <> '' and Not isnull(ls_pwd) Then 
	ls_pwd = in_encrypt.of_Decrypt(ls_pwd)	
End If
This.of_createobject()
This.of_setpop3Info(ls_server,ll_port,li_pop3ssl)
This.of_setaccount(ls_account,ls_pwd)
If Not This.of_pingserver(True) Then 
	Of_display('')
	Return -1
End If

Return 1

end function

public function long of_get_email_list ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_get_Email_list()
// $<arguments>(None)
// $<returns> long
// $<description> Get New Email list from Server.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_by_date,li_by_subject,li_by_all
long i,j,ll_msg_cnt
Datetime ldt_start_date
String ls_last_msg_id,ls_msg_id,ls_newest_msg_id
Long ll_msg_num,ll_ret
Integer li_step = 50, li_optimize_rows = 10
Long ll_find,ll_pos,ll_download_msg_cnt
String ls_sort_rule

SetPointer(HourGlass!)

iole_POP3Mail.Messages.DeleteAll()
ids_new_msg_id.Reset()
ids_download_msg_id.Reset()

iole_POP3Mail.TimeOut = 300

//Get Email Count from Server
Of_display('Counting Email items...')
ll_download_msg_cnt = iole_POP3Mail.GetDownloadableCount()
If ll_download_msg_cnt = 0 Then
	SetPointer(Arrow!)
	Return 0
End If

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("em_user_msg", FALSE)
//------------------------------------------------------------------------

//increase the optimize_rows where the mail count large than 5000
If ll_download_msg_cnt > 5000 Then
	li_optimize_rows = 50
End If

If ll_download_msg_cnt > 1 Then
	of_display('Getting the sort rule from the Email server...')
	ls_sort_rule = of_get_sort_rule(ll_download_msg_cnt)
Else
	ls_sort_rule = 'A'	
End If

If ls_sort_rule = '' Then
	Of_display('Downloading Emails ID list...')
	ls_msg_id = iole_POP3Mail.GetMessageIDList('~r~n',0)
	If Left(ls_msg_id ,4 ) = '-ERR' Then
		of_log('','GetMessageIDList()',0,ls_msg_id)
		Return -1
	End If
	ll_ret = ids_download_msg_id.ImportString(ls_msg_id)
	If ll_ret < 0 Then
		of_log('','ids_download_msg_id.ImportString()',ll_ret,'')
		Return -1
	End If
	ids_download_msg_id.Rowscopy( 1,ids_download_msg_id.RowCount(), Primary!, ids_new_msg_id, 1, Primary!)
	Return ids_new_msg_id.RowCount()	
End If

If ls_sort_rule = 'D' Then  //Newest -> Oldest
	Of_display('Getting Emails ID list...')
	//Check the newest mail from server.
	ls_newest_msg_id = iole_POP3Mail.GetMessageID(1)
	If Left(ls_newest_msg_id,4) = '-ERR' Then
		of_log('','iole_POP3Mail.GetMessageID(1)',0,ls_newest_msg_id)
		Return -1
	End If
	ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_newest_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
	If ll_find > 0 Then
		Return 0
	End If	
	
	//For performance, add below script
	If gnv_data.ids_em_user_msg_list.RowCount() > 0 Then
		ls_last_msg_id = gnv_data.ids_em_user_msg_list.GetItemString(1,'mail_msg_id')
		ll_msg_num = iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id)
		IF ll_msg_num = 1 Then Return 0
		If ll_msg_num > 1 and ll_msg_num < li_optimize_rows Then // if less than 10 or 50 mails
			For i = 1 To ll_msg_num - 1
				ls_msg_id = iole_POP3Mail.GetMessageID(i)
				If Left(ls_msg_id,4) = '-ERR' Then 
					of_log('','iole_POP3Mail.GetMessageID('+String(i)+')' , 0,ls_msg_id)
					Continue
				End If
				ids_new_msg_id.InsertRow(0)
				ids_new_msg_id.SetItem(ids_new_msg_id.rowcount(),'msg_full_id',ls_msg_id)
			Next
			//If no new Email come in when doing that,then return the result, otherwise use other statements to downlaod msg id.
			If iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id) = ll_msg_num Then
				ids_new_msg_id.SetSort('compute_id DESC')
				ids_new_msg_id.Sort()
				Return ids_new_msg_id.RowCount()
			Else
				ids_new_msg_id.Reset()
			End If
		End If
	End If
	
	//Download Message ID List from Server
	Of_display('Downloading Email message ID lists...')
	ls_msg_id = iole_POP3Mail.GetMessageIDList('~r~n',0)
	If Left(ls_msg_id,4) = '-ERR' Then 
		of_display('Error. Failed to get the Email message ID list.')
		of_log('','GetMessageIDList()',0,ls_msg_id)
		Messagebox('Error','Failed to get the Email message ID list.')
		Return -1
	End If
	ll_ret = ids_download_msg_id.ImportString(ls_msg_id)
	If ll_ret < 0 Then
		of_log('','ids_download_msg_id.ImportString()',ll_ret,'')
		Return -1
	End If	
	
	ll_download_msg_cnt = ids_download_msg_id.rowcount()
	If ll_download_msg_cnt = 0 Then
		of_display('Error. Failed to import the Email message id to datastore.')
		SetPointer(Arrow!)
		Return -1
	End If
	
	Of_display('Getting new Email message ID lists...')
	//Search all Email item when First run it
	If gnv_data.ids_em_user_msg_list.RowCount() = 0 Then
		ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
		ids_new_msg_id.SetSort('compute_id DESC')
		ids_new_msg_id.Sort()		
		Return ids_new_msg_id.RowCount()
	End If
	
	//Locate last msg position to find new messages.
	ls_last_msg_id = gnv_data.ids_em_user_msg_list.GetItemString(1,'mail_msg_id')
	ll_msg_num = iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id)
	IF ll_msg_num = 1 Then Return 0
	If ll_msg_num > 1 Then
		ids_download_msg_id.Rowscopy( 1,ll_msg_num - 1, Primary!, ids_new_msg_id, 1, Primary!)
		ids_new_msg_id.SetSort('compute_id DESC')
		ids_new_msg_id.Sort()		
		Return ids_new_msg_id.RowCount()
	End If
	
	//Analyse message One by One or By Step.
	If ll_msg_num <= 0 Then
		If ll_download_msg_cnt <= li_step Then
			//Find one by one when mail count <= 50
			For i = 1 to ll_download_msg_cnt
				ls_msg_id = ids_download_msg_id.GetItemString(i,'msg_id')
				ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
				If ll_find > 0 Then
					If i = 1 Then Return 0
					ids_download_msg_id.Rowscopy( 1,i - 1 , Primary!, ids_new_msg_id, 1, Primary!)
					ids_new_msg_id.SetSort('compute_id DESC')
					ids_new_msg_id.Sort()					
					Return ids_new_msg_id.RowCount()
				End If
			Next
			ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
			ids_new_msg_id.SetSort('compute_id DESC')
			ids_new_msg_id.Sort()			
			Return ids_new_msg_id.RowCount()
		Else
			//Find by step when mail count > 50
			ls_msg_id = ids_download_msg_id.GetItemString(1,'msg_id')
			ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
			If ll_find > 0 Then 
				Return 0
			Else
				i = 0
				Do While ll_find = 0
					i++
					If (i*li_step) <= ll_download_msg_cnt Then
						ls_msg_id = ids_download_msg_id.GetItemString(i*li_step,'msg_id')
						ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
						If ll_find > 0 Then
							//back forward search
							For j = (i - 1 )*li_step + 1 To i*li_step 
								ls_msg_id = ids_download_msg_id.GetItemString(j,'msg_id')
								ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
								If ll_find > 0 Then
									ids_download_msg_id.Rowscopy( 1, j - 1 , Primary!, ids_new_msg_id, 1, Primary!)
									ids_new_msg_id.SetSort('compute_id DESC')
									ids_new_msg_id.Sort()									
									Return ids_new_msg_id.RowCount()
								End If
							Next	
							//If error
							ids_download_msg_id.Rowscopy( 1,i*li_step - 1, Primary!, ids_new_msg_id, 1, Primary!)
							ids_new_msg_id.SetSort('compute_id DESC')
							ids_new_msg_id.Sort()							
							Return ids_new_msg_id.RowCount()
						Else
							Continue
						End If
					Else
						//If over count, then search from pre-step to bottom
						For j = (i - 1)*li_step + 1 To ll_download_msg_cnt
							ls_msg_id = ids_download_msg_id.GetItemString(j,'msg_id')
							ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
							If ll_find > 0 Then
								ids_download_msg_id.Rowscopy(  1, j - 1 , Primary!, ids_new_msg_id, 1, Primary!)
								ids_new_msg_id.SetSort('compute_id DESC')
								ids_new_msg_id.Sort()								
								Return ids_new_msg_id.RowCount()
							End If
						Next
						ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
						ids_new_msg_id.SetSort('compute_id DESC')
						ids_new_msg_id.Sort()						
						Return ids_new_msg_id.RowCount()			
					End If
				Loop
				ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
				ids_new_msg_id.SetSort('compute_id DESC')
				ids_new_msg_id.Sort()						
				Return ids_new_msg_id.RowCount()						
			End If
		End If
	End If
ElseIf ls_sort_rule = 'A' Then //Oldest -> Newest
	Of_display('Getting Email ID lists...')
	//Check the newest mail from server.
	ls_newest_msg_id = iole_POP3Mail.GetMessageID(ll_download_msg_cnt)
	If Left(ls_newest_msg_id,4) = '-ERR' Then
		of_log('','iole_POP3Mail.GetMessageID('+String(ll_download_msg_cnt)+')',0,ls_newest_msg_id)
		Return -1
	End If	

	ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_newest_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
	If ll_find > 0 Then
		Return 0
	End If	
	
	//For performance, add below script
	If gnv_data.ids_em_user_msg_list.RowCount() > 0 Then
		ls_last_msg_id = gnv_data.ids_em_user_msg_list.GetItemString(1,'mail_msg_id')
		ll_msg_num = iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id)
		IF ll_msg_num = ll_download_msg_cnt Then Return 0
		If ll_msg_num > 1 and (ll_download_msg_cnt - ll_msg_num) < li_optimize_rows Then // if less than 10 or 50 mails
			For i = ll_msg_num + 1 To ll_download_msg_cnt
				ls_msg_id = iole_POP3Mail.GetMessageID(i)
				If Left(ls_msg_id,4) = '-ERR' Then Continue
				ids_new_msg_id.InsertRow(0)
				ids_new_msg_id.SetItem(ids_new_msg_id.rowcount(),'msg_full_id',ls_msg_id)
			Next
			//If no new Email come in when doing that,then return the result, otherwise use other statements to downlaod msg id.
			If iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id) = ll_msg_num Then
				Return ids_new_msg_id.RowCount()
			Else
				ids_new_msg_id.Reset()
			End If
		End If
	End If
	
	//Download Message ID List from Server
	Of_display('Downloading Email message ID lists...')
	ls_msg_id = iole_POP3Mail.GetMessageIDList('~r~n',0)
	If Left(ls_msg_id,4) = '-ERR' Then 
		of_display('Error. Failed to get the Email message ID list.')
		of_log('','iole_POP3Mail.GetMessageIDList()',0,ls_msg_id)
		Messagebox('Error','Failed to get the Email message ID list.')
		Return -1
	End If	
	ll_ret = ids_download_msg_id.ImportString(ls_msg_id)
	If ll_ret < 0 Then
		of_log('','ids_download_msg_id.ImportString()',ll_ret,'')
		Return -1
	End If
	ll_download_msg_cnt = ids_download_msg_id.rowcount()
	If ll_download_msg_cnt = 0 Then
		of_display('Failed to get Email message ID list.')
		SetPointer(Arrow!)
		Return -1
	End If
	
	Of_display('Getting new Email ID lists...')
	//Search all Email item when First run it
	If gnv_data.ids_em_user_msg_list.RowCount() = 0 Then
		ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
		Return ids_new_msg_id.RowCount()
	End If
	
	//Locate last msg position to find new messages.
	ls_last_msg_id = gnv_data.ids_em_user_msg_list.GetItemString(1,'mail_msg_id')
	ll_msg_num = iole_POP3Mail.GetMessageNumFromID(ls_last_msg_id)
	IF ll_msg_num = ll_download_msg_cnt Then Return 0
	If ll_msg_num >= 1 Then
		ids_download_msg_id.Rowscopy( ll_msg_num + 1,ll_download_msg_cnt, Primary!, ids_new_msg_id, 1, Primary!)
		Return ids_new_msg_id.RowCount()
	End If
	
	//Analyse message One by One or By Step.
	If ll_msg_num <= 0 Then
		If ll_download_msg_cnt <= li_step Then
			//Find one by one when mail count <= 50
			For i = ll_download_msg_cnt To 1 Step -1
				ls_msg_id = ids_download_msg_id.GetItemString(i,'msg_id')
				ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
				If ll_find > 0 Then
					If i = ll_download_msg_cnt Then Return 0
					ids_download_msg_id.Rowscopy( i + 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
					Return ids_new_msg_id.RowCount()
				End If
			Next
			ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
			Return ids_new_msg_id.RowCount()
		Else
			//Find by step when mail count > 50
			ls_msg_id = ids_download_msg_id.GetItemString(ll_download_msg_cnt,'msg_id')
			ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
			If ll_find > 0 Then 
				Return 0
			Else
				i = 0
				Do While ll_find = 0
					i++
					//If (i*li_step + 1) <= ll_download_msg_cnt Then
					If ll_download_msg_cnt - i*li_step > 0 Then	
						ls_msg_id = ids_download_msg_id.GetItemString(ll_download_msg_cnt - i*li_step,'msg_id')
						ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
						If ll_find > 0 Then
							//back forward search
							For j = (ll_download_msg_cnt - (i - 1)*li_step) To (ll_download_msg_cnt - i*li_step) Step -1
								ls_msg_id = ids_download_msg_id.GetItemString(j,'msg_id')
								ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
								If ll_find > 0 Then
									ids_download_msg_id.Rowscopy( J + 1, ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
									Return ids_new_msg_id.RowCount()
								End If
							Next	
							//If error
							ids_download_msg_id.Rowscopy( (ll_download_msg_cnt - i*li_step + 1), ll_download_msg_cnt, Primary!, ids_new_msg_id, 1, Primary!)
							Return ids_new_msg_id.RowCount()
						Else
							Continue
						End If
					Else
						//If over count, then search from pre-step to bottom
						For j = (ll_download_msg_cnt - (i - 1)*li_step) To 1 Step -1
							ls_msg_id = ids_download_msg_id.GetItemString(j,'msg_id')
							ll_find = gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount())
							If ll_find > 0 Then
								ids_download_msg_id.Rowscopy(  J + 1, ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
								Return ids_new_msg_id.RowCount()
							End If
						Next
						ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
						Return ids_new_msg_id.RowCount()			
					End If
				Loop
				ids_download_msg_id.Rowscopy( 1,ll_download_msg_cnt , Primary!, ids_new_msg_id, 1, Primary!)
				Return ids_new_msg_id.RowCount()							
			End If
		End If
	End If
	
End If

SetPointer(Arrow!)
If ls_sort_rule = 'D' Then
	ids_new_msg_id.SetSort('compute_id DESC')
	ids_new_msg_id.Sort()		
End If
Return ids_new_msg_id.RowCount()
end function

public subroutine of_display (string as_info);If isvalid(ist_info) Then
	ist_info.Text = as_info
End If
end subroutine

public subroutine of_set_tip_object (statictext ast_text);ist_info = ast_text
end subroutine

public function string of_get_attach_list (oleobject aole_message);String ls_attach_list,ls_unit,ls_filename
Integer i
Long ll_size

For i = 1 To aole_message.Attachments.Count
	ls_filename = aole_message.Attachments.Item(i).filename
	If ls_filename = 'unknown.unk' Then 
		ls_filename = of_get_attachname(aole_message.Attachments.Item(i))
		//Continue
	End If
	ll_size = aole_message.Attachments.Item(i).size
	ll_size = inv_cst_filesrv.of_genfilesize(ll_size,ls_unit)
	If ls_attach_list = '' Then
		ls_attach_list = ls_filename + ' (' +String(ll_size) + ls_unit +  ')' 
	Else
		ls_attach_list += '; ' + ls_filename + ' (' +String(ll_size) + ls_unit +  ')' 
	End If
Next	

Return ls_attach_list
end function

public function integer of_disconnect_pop3 ();
If isvalid(iole_POP3Mail) Then
	iole_POP3Mail.disconnect()
End If

Return 1
end function

public subroutine of_set_status (string as_status);//IS_PROCESSING ='processing', IS_STOPING = 'stoping' , IS_COMPLETE = 'complete'
is_status = as_status
end subroutine

public function integer of_update_register (long al_email_id, string as_email_type, datetime adt_modify_date);String ls_regstr, ls_regupdate
Integer li_rtn

ls_regstr = of_get_Email_name(al_Email_id,as_Email_type)
ls_regupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
//li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\ContractLogix\Email",ls_regstr, regstring!, ls_regupdate) 
li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Email",ls_regstr, regstring!, ls_regupdate) 

Return li_rtn
end function

public function string of_get_email_name (long al_email_id, string as_email_type);String ls_ext
Choose Case Lower(as_Email_type)
	Case 'eml' 
		ls_ext = '.tmp'
	Case 'doc'
		ls_ext = '.doc'
	Case Else
		ls_ext = '.' + Lower(as_Email_type) 
End Choose

Return "Email_" + String(al_Email_id) + ls_ext

end function

public function string of_get_Email_cachedir ();String ls_EmailDirectory

ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email\POP3\Caches"
gnv_appeondll.of_parsepath(ls_EmailDirectory)
IF NOT DirectoryExists(ls_EmailDirectory) THEN 
	Messagebox('Email','Failed to create the Email temp directory '+ls_EmailDirectory+', please call support.')
	Return  gs_dir_path + gs_DefDirName
End If

Return ls_EmailDirectory
end function

public function string of_download_email (long al_mail_id, string as_email_type);String ls_filename
Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data	
Blob  lb_image_data
Datetime ldt_modify

//Default Email file name
ls_filename = this.of_get_Email_cachedir( ) + '\' + This.of_get_Email_name(al_mail_id, as_Email_type)

If FileExists(ls_filename) Then
	If of_check_register(al_mail_id,as_Email_type,ldt_modify) Then
		Return ls_filename
	End If
End If

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		SELECT Datalength(mail_rfc822)
		INTO :ll_data_length
		FROM em_mail_items
		WHERE id = :al_mail_id;
		
		IF SQLCA.SQLCODE = -1 THEN RETURN ''
		
		IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
			RETURN ''
		END IF
		
		//Get length of the blob
		IF ll_data_length > 8000 THEN 
			 IF Mod(ll_data_length,8000) = 0 THEN 
				  li_loops = ll_data_length/8000 
			 ELSE 
				  li_loops = (ll_data_length/8000) + 1 
			 END IF 
		ELSE 
			 li_loops = 1 
		END IF 
		
		//Display progress bar for the large blob
		li_NewStep = 20
		IF li_loops > li_NewStep THEN
			IF IsValid(w_appeon_gifofwait) THEN 
				//Keep the original progress bar
				lb_needrestore = TRUE
				ls_title = w_appeon_gifofwait.st_1.Text
				li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
				li_Position = w_appeon_gifofwait.hpb_1.Position
				li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
			ELSE
				OpenwithParm(w_appeon_gifofwait,"Getting the data...")
			END IF
			//Set the new progress bar
			li_loopsR = li_loops / li_NewStep
			IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
			w_appeon_gifofwait.st_1.Text = "Getting the data..."
			w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
			w_appeon_gifofwait.hpb_1.Position = 0
			w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
		END IF
		
		//Get and store the blob
		li_rtn = 1
		FOR li_counter = 1 to li_loops
			ll_start = (li_counter - 1) * 8000 + 1
			SELECTBLOB substring(mail_rfc822,:ll_start,8000)
					INTO :lb_data
					FROM em_mail_items
					WHERE id = :al_mail_id;
			IF SQLCA.SQLCODE = -1 THEN 
				li_rtn = -1
				EXIT
			END IF
			lb_all_data += lb_data
			
			//Change the progress bar
			IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
				IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
			ELSE
				IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
			END IF
		NEXT 
		
		//Restore Progress Bar
		IF IsValid(w_appeon_gifofwait) and li_loops > li_NewStep THEN 
			IF lb_needrestore THEN
				w_appeon_gifofwait.st_1.Text = ls_title
				w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
				w_appeon_gifofwait.hpb_1.Position = li_Position
				w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
			ELSE
				Close(w_appeon_gifofwait)
			END IF
		END IF
		
		//Store the blob
		lb_image_data = lb_all_data
//		inv_dm_utils.of_saveblob(ls_filename, lb_image_data)
//		Return ls_filename
ElSE
	//For WEB
	SELECTBLOB mail_rfc822
	INTO :lb_image_data
	FROM em_mail_items
	WHERE id = :al_mail_id;
	
	IF SQLCA.SQLCODE = -1 THEN 
		//MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return ''
	END IF
	
	//Added By Ken.Guo 2010-10-09.
	If isnull(lb_image_data) or Len(lb_image_data) = 0 Then
		Return ''
	End If
	
END IF

This.of_update_register(al_mail_id, as_Email_type, ldt_modify)
inv_dm_utils.of_saveblob(ls_filename, lb_image_data)


Return ls_filename
end function

public function string of_eml2word (long al_email_id, string as_eml_file);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3.of_eml2word()
// $<arguments>
//		value	long  	al_email_id		
//		value	string	as_eml_file		
// $<returns> string
// $<description>
// $<description> Email file to HTML format
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_html_dir,ls_html
String ls_bodytext
String ls_doc_name,ls_txt_name
Long ll_msg_num
blob lb_data
oleobject ole_document

If Not isvalid(iole_POP3Mail) Then
	This.of_createobject( )
End If
iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
ll_msg_num = iole_POP3Mail.LoadMessage(as_eml_file,0)
If ll_msg_num  > 0 Then
	If iole_POP3Mail.Messages.Item(ll_msg_num).LoadMessage(as_eml_file,0,2,0) = 0 Then
		iole_message = iole_POP3Mail.Messages.Item(ll_msg_num)
		ls_html_dir = iole_message.HTMLPartsDirectory
		If ls_html_dir <> '' Then
			ls_doc_name = ls_html_dir + '\' + This.of_get_Email_name(al_Email_id, 'doc')
			
			//modify html file to show picture.
			ls_html = ls_html_dir + '\index.htm'
			of_modify_file(ls_html)
			
			//convert html to word.
			If not isvalid(iole_word) Then
				iole_word = Create oleobject
				IF iole_word.Connecttonewobject("word.application") <> 0 THEN
					messagebox('Error','failed to create word')
					Destroy iole_word
					Return ''
				End If
			End If
			
			iole_word.Application.NormalTemplate.Saved = TRUE		
			Try
				ole_document = iole_word.Application.Documents.Open(ls_html,false,true)
				gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
				gnv_shell.of_delete_recent( ls_html, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				ole_document.saveas(ls_doc_name,0,false,'',false) //0: word format
				gnv_shell.of_delete_recent(ls_doc_name, true) //Delete Windows Recent Document
				ole_document.Close(0)
				Return ls_doc_name			
			Catch ( oleruntimeerror e2)
				messagebox('Error','Failed to open the Email.' + String(e2.line) + '~r~n' + e2.text)
				iole_word.Quit(0)
				iole_word.DisconnectObject( )
				destroy iole_word	
				Return ''
			End Try				
	
		Else
			ls_bodytext = iole_message.BodyText 
			//input bodytext to word
			ls_doc_name = This.of_get_Email_cachedir( ) + '\' + This.of_get_Email_name(al_Email_id, 'doc')
			
//			If Not isvalid(iw_Email_edit) Then Open(iw_Email_edit)
//			iw_Email_edit.ole_word.of_open()
//			iw_Email_edit.ole_word.of_inserttextlast(ls_bodytext,False)
//			iw_Email_edit.ole_word.object.ActiveDocument.Application.NormalTemplate.Saved = TRUE
//			If gs_ImageView_Version <> '4.0' Then iw_Email_edit.ole_word.object.FileSave = True
//			iw_Email_edit.ole_word.object.ActiveDocument.SaveAs(ls_doc_name, 0,false,'',false) 			
//			If gs_ImageView_Version <> '4.0' Then iw_Email_edit.ole_word.object.FileSave = False
//			gnv_shell.of_delete_recent(ls_doc_name, true) //Delete Windows Recent Document
//			iw_Email_edit.ole_word.of_close()
//			close(iw_Email_edit)
			If not isvalid(iole_word) Then
				iole_word = Create oleobject
				IF iole_word.Connecttonewobject("word.application") <> 0 THEN
					messagebox('Error','failed to create word')
					Destroy iole_word
					Return ''
				End If
			End If

			iole_word.Application.NormalTemplate.Saved = TRUE		
			Try
				ole_document = iole_word.Application.Documents.Add('',false,0,false)
				gnv_shell.of_delete_recent( ls_html, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				//iole_word.ActiveDocument.saveas(ls_doc_name,0,false,'',false) //0: word format
				ole_document.Activate()
				ole_document.ActiveWindow.Selection.TypeText(ls_bodytext)
				ole_document.saveas(ls_doc_name,0,false,'',false) //0: word format
				gnv_shell.of_delete_recent(ls_doc_name, true) //Delete Windows Recent Document
				//iole_word.ActiveDocument.Close(0)
				ole_document.close(0)
				Return ls_doc_name			
			Catch ( oleruntimeerror e3)
				messagebox('Error','Failed to open the Email.' + String(e2.line) + '~r~n' + e2.text)
				iole_word.Quit(0)
				iole_word.DisconnectObject( )
				destroy iole_word	
				Return ''
			End Try		
			Return ls_doc_name

		End If
	End If
End If

Return ''
end function

public function integer of_string2word (string as_text, string as_filename);Return 1
end function

public function integer of_cache_msg_id (string as_user_id, string as_msg_id, integer ii_downloaded, string as_notes);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3.of_cache_msg_id()
// $<arguments>
//		value	string 	as_user_id   		
//		value	string 	as_msg_id    		
//		value	integer	ii_downloaded	-1: download error; 0: need not download; 1: download	
//		value	string 	as_notes     		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-06 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_row
//----------------------2.25.2016 RP added for just-in-time cache service-----------------------------
gnv_data.of_initCache("em_user_msg")
//------------------------------------------------------------------------------------------------------------
ll_row = gnv_data.ids_em_user_msg_list.InsertRow(1)
If ll_row <= 0 Then Return -1

gnv_data.ids_em_user_msg_list.SetItem(ll_row,'user_id',as_user_id)
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'mail_msg_id',as_msg_id)
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'mail_downloaded',ii_downloaded)
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'mail_date',today())
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'notes',as_notes)
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'pop3_server',String(iole_POP3Mail.MailServer))
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'pop3_account',String(iole_POP3Mail.Account))

//added by gavins 20121120
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'protocoltype','POP3'  )
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'messageid',is_Messageid )
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'folder', 'inbox' )
gnv_data.ids_em_user_msg_list.SetItem(ll_row,'rfc822date',is_Messagedate )

If gnv_data.ids_em_user_msg_list.Update() = 1 Then
	Commit;
Else
	//----------------------2.25.2016 RP added for just-in-time cache service-----------------------------
	//gnv_data.of_retrieve('em_user_msg')
	gnv_data.of_retrieveIfNecessary("em_user_msg", TRUE)
	//------------------------------------------------------------------------------------------------------------
	This.of_log( as_msg_id, 'Cache MSG ID', -1, sqlca.sqlerrtext)
	Return -1
End If

Return 1
end function

public function integer of_modify_file (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_modify_file()
// $<arguments>
//		value	string	as_file		
// $<returns> integer
// $<description> Because some html can not display the picture.
// $<description> Modify the html to show the picture.
// Modify Steps:
// 1. Delete <!--[if gte vml 1]> ... <![endif]-->
// 2. Delete <![if !vml]>
// 3. Delete v:shapes="..."
// 4. Delte <![endif]>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_text
Blob lb_text
n_cst_filesrv lnv_cst_file

If Not FileExists(as_file) Then Return -1

lnv_cst_file = Create n_cst_filesrv
If lnv_cst_file.of_fileread( as_file, lb_text) < 0 Then 
	Destroy lnv_cst_file
	Return -1
End If
ls_text = String(lb_text,EncodingANSI!)

Long ll_pos1_start,ll_pos1_end,ll_pos2_start
Long ll_pos3_start,ll_pos3_end,ll_pos4_start
Long ll_next_pos = 1

ll_next_pos = Pos(ls_text,'</head>',1)
Do While ll_next_pos > 0
	ll_pos1_start = Pos(ls_text,'<!--[if gte vml 1]>',ll_next_pos)
	If ll_pos1_start <= 0 Then Exit
	ll_pos1_end = Pos(ls_text,'<![endif]-->',ll_pos1_start)
	ll_pos2_start = Pos(ls_text,'<![if !vml]>',ll_pos1_end)
	If ll_pos2_start <= 0 Then Exit
	If (ll_pos2_start - ll_pos1_end) <> 12 Then 
		ll_next_pos = ll_pos1_start + 19
		Continue
	End If
	ll_pos3_start = Pos(ls_text,'v:shapes="',ll_pos2_start)
	If ll_pos3_start <= 0 Then 
		ll_next_pos = ll_pos1_start + 19
		Continue				
	End If
	ll_pos3_end = Pos(ls_text,'">',ll_pos3_start)
	ll_pos4_start = Pos(ls_text,'<![endif]>',ll_pos3_end)
	If ll_pos4_start <= 0 Then Exit
	If (ll_pos4_start - ll_pos3_end) <> 2 Then 
		ll_next_pos = ll_pos1_start + 19
		Continue		
	End If
	
	ls_text = Replace(ls_text,ll_pos4_start,10,'')
	ls_text = Replace(ls_text,ll_pos3_start,ll_pos3_end - ll_pos3_start + 1,'')
	ls_text = Replace(ls_text,ll_pos2_start,12,'')
	ls_text = Replace(ls_text,ll_pos1_start,ll_pos1_end - ll_pos1_start + 12,'')
	
	ll_next_pos = ll_pos1_start
Loop

If lnv_cst_file.of_filewrite(as_file,ls_text,false) < 0 Then Return -1

Destroy lnv_cst_file
Return 1
end function

public subroutine of_refresh_inbox ();long ll_getrow
If isvalid(idw_em_inbox) Then
	ll_getrow =  idw_em_inbox.GetRow()
	If ids_received_msg.RowCount() = 0 Then Return 
	ids_received_msg.rowsmove( 1, ids_received_msg.RowCount(), Primary!, idw_em_inbox, 1, Primary!) 
	idw_em_inbox.ResetUpdate()	
	If ll_getrow > 0 Then
		idw_em_inbox.ScrolltoRow(1) //Scroll to top
		idw_em_inbox.SetRow(ll_getrow + 1)
		idw_em_inbox.SelectRow(0,False)
		idw_em_inbox.SelectRow(ll_getrow + 1,True)
	End If
End If
end subroutine

public subroutine of_set_inbox_dw (datawindow adw_inbox);idw_em_inbox = adw_inbox
end subroutine

public function string of_get_Email_attachdir (long al_Emailid, string as_type);String ls_EmailDirectory
If as_type = 'eml' Then //Attachment temp for EML file
	ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email\POP3\Temp\" + String(al_Emailid)
	gnv_appeondll.of_parsepath(ls_EmailDirectory)
	IF NOT DirectoryExists(ls_EmailDirectory) THEN 
		Messagebox('Email','Failed to create the Email temp directory '+ls_EmailDirectory+', please call support.')
		Return  gs_dir_path + gs_DefDirName
	End If
ElseIf as_type = 'doc' Then //MIME file(picture) for word file
	ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email\POP3\Caches\Attachments\" + String(al_Emailid) 
	gnv_appeondll.of_parsepath(ls_EmailDirectory)
	IF NOT DirectoryExists(ls_EmailDirectory) THEN 
		Messagebox('Email','Failed to create the Email temp directory '+ls_EmailDirectory+', please call support.')
		Return  gs_dir_path + gs_DefDirName
	End If	
End If
Return ls_EmailDirectory
end function

public function string of_gen_nextfilename (string as_filename, integer ai_index);Long ll_pos
ll_pos = LastPos(as_filename,'.')
If ll_pos = 0 Then
	Return as_filename + '(' + String(ai_index) + ')'
Else
	Return Mid(as_filename,1,ll_pos - 1) + '(' + String(ai_index) + ').' + Mid(as_filename,ll_pos + 1,Len(as_filename))
End If

end function

public function boolean of_check_register (long al_email_id, string as_email_type, ref datetime adt_modify);String ls_regstr, ls_regupdate,ls_modify
Integer li_rtn

//Email type.  eml, doc
ls_regstr = of_get_Email_name(al_Email_id,as_Email_type)

Select last_modify_date Into :adt_modify From em_mail_items Where id = :al_Email_id;
If isnull(adt_modify) Then adt_modify = datetime(1900-01-01,00:00:00)

ls_modify = String(adt_modify, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
//li_rtn = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\ContractLogix\Email",ls_regstr, regstring!, ls_regupdate) 
li_rtn = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Email",ls_regstr, regstring!, ls_regupdate) 
If ls_modify = ls_regupdate Then
	Return True
Else
	Return False
End If


Return False

end function

public function boolean of_check_register_attach (long al_attachid, string as_attach_name, ref datetime adt_modify);String ls_regstr, ls_regupdate,ls_modify
Integer li_rtn

Select last_modify_date Into :adt_modify From em_mail_item_attachments Where id = :al_attachid;
If isnull(adt_modify) Then adt_modify = datetime(1900-01-01,00:00:00)

ls_modify = String(adt_modify, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
//li_rtn = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\ContractLogix\Email\Attachments",as_attach_name, regstring!, ls_regupdate) 
li_rtn = gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Email\Attachments",as_attach_name, regstring!, ls_regupdate) 
If ls_modify = ls_regupdate Then
	Return True
Else
	Return False
End If



end function

public function integer of_update_register_attach (long al_attachment_id, string as_attach_fullname, datetime adt_modify_date);String ls_regstr, ls_regupdate
Integer li_rtn

ls_regupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
//li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\ContractLogix\Email\Attachments",as_attach_fullname, regstring!, ls_regupdate) 
li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Email\Attachments",as_attach_fullname, regstring!, ls_regupdate) 
Return li_rtn

end function

public function datetime of_get_Email_date (oleobject aole_message);Datetime ldt_Email_date
String ls_date
Integer li_pos1,li_pos2

If aole_message.Timestamps.Count > 0 Then
	ldt_Email_date = aole_message.Timestamps.Item(1).DateTime
	Return ldt_Email_date
Else
	 //Date format: Wed, 17 Jun 2009 08:41:03 +0800 (CST)
	ls_date = aole_message.date
	li_pos1 = Pos(ls_date,',')
	li_pos2 = Pos(ls_date,'+')
	If li_pos2 = 0 Then
		li_pos2 = Pos(ls_date,'-')
	End If
	ls_date = Trim(Mid(ls_date,li_pos1 + 1, li_pos2 - li_pos1 - 1 ))
	Select Convert(datetime,:ls_date) Into :ldt_Email_date from icred_settings;
	If isnull(ldt_Email_date) then ldt_Email_date = DateTime(Date('1900-01-01'),Time('00:00:00'))
	
End If

Return ldt_Email_date
end function

public subroutine of_stop_receive ();is_status = This.IS_STOPING
end subroutine

public function integer of_update_Email_blob (long al_Email_id, oleobject aole_message, string as_bodytext, ref string as_errtext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_update_Email_blob()
// $<arguments>
//		value    	long     	al_Email_id 		
//		value    	oleobject	aole_message	
//		value			string   	as_bodytext  		
//		reference	string   	as_errtext  		
// $<returns> integer
// $<description>
// $<description> Update the Message Temp file(*.eml) to DB.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-02 by Ken.Guo
//////////////////////////////////////////////////////////////////////
String ls_bodytext
String ls_temp_file
String ls_new_file
Blob lb_file
Datetime ldt_modify_date

ldt_modify_date = DateTime(Today(),Now())

//Get Email File
ls_temp_file = aole_message.TempMsgSourceFile
If Not FileExists(ls_temp_file) Then 
	as_errtext = 'The temp file of the Email does not exist.'
	Return -1
End If

//Read to Blob
If inv_dm_utils.of_readblob(ls_temp_file,lb_file) = 1 Then
	//Update Blob to DB
	UpdateBlob em_mail_items Set mail_rfc822 = :lb_file Where id = :al_Email_id;
	If SQLCA.sqlcode <> 0 Then 
		as_errtext = SQLCA.sqlerrtext
		Return -1
	End If
	
	Update em_mail_items Set mail_plaintext = :as_bodytext Where id = :al_Email_id;
	
	Update em_mail_items Set last_modify_date = :ldt_modify_date Where id = :al_Email_id;
	If SQLCA.sqlcode <> 0 Then 
		as_errtext = SQLCA.sqlerrtext
		Return -1
	End If
	
	//Copy Email File To Cache Dir
	ls_new_file = This.of_get_Email_cachedir() + '\' + This.of_get_Email_name(al_Email_id,'eml')
	If FileCopy(ls_temp_file,ls_new_file,True) = 1 Then
		of_update_register(al_Email_id, 'eml', ldt_modify_date)
	End If
	
Else
	as_errtext = 'Failed to write the file to Blob.'
	Return -1
End If


Return 1
end function

public function string of_get_sort_rule (long al_maxrow);//Date format: Wed, 17 Jun 2009 08:41:03 +0800 (CST)
String ls_server,ls_last_sort,ls_sort
Datetime ldt_date1,ldt_date2
String ls_date1,ls_date2,ls_timezone1,ls_timezone2
Long ll_seq1,ll_seq2,ll_sec1,ll_sec2
Integer li_pos1,li_pos2

If al_maxrow < 2 Then 
	Select Top 1 pop3_sort_rule into :ls_last_sort from em_smtp_accounts where Server = :ls_server;
	If isnull(ls_last_sort) Then ls_last_sort = ''
	Return ls_last_sort
End If

ls_server = iole_POP3Mail.MailServer

ll_seq1 = iole_POP3Mail.DownloadSingleMessageHeaders(1)
If ll_seq1 <= 0 Then 
	of_log('','iole_POP3Mail.DownloadSingleMessageHeaders(1)',ll_seq1,'')
	Return ''
End If
ll_seq2 = iole_POP3Mail.DownloadSingleMessageHeaders(al_maxrow)
If ll_seq2 <= 0 Then 
	of_log('','iole_POP3Mail.DownloadSingleMessageHeaders('+String(ll_seq2)+')',ll_seq2,'')
	Return ''
End If

ls_date1 = iole_POP3Mail.Messages.Item(ll_seq1).Date
ls_date2 = iole_POP3Mail.Messages.Item(ll_seq2).Date
//Date format: Wed, 17 Jun 2009 08:41:03 +0800 (CST)

li_pos1 = Pos(ls_date1,',')
li_pos2 = Pos(ls_date1,'+')
If li_pos2 = 0 Then
	li_pos2 = Pos(ls_date1,'-')
End If
ls_timezone1 = Mid(ls_date1,li_pos2, 5)
ls_date1 = Trim(Mid(ls_date1,li_pos1 + 1, li_pos2 - li_pos1 - 1))
If Left(ls_timezone1,1) = '+' Then
	ll_sec1 = Long(Mid(ls_timezone1,2,2)) * 3600 + Long(Mid(ls_timezone1,4,2)) * 60
Else
	ll_sec1 = 0 - (Long(Mid(ls_timezone1,2,2)) * 3600 + Long(Mid(ls_timezone1,4,2)) * 60)
End If

li_pos1 = Pos(ls_date2,',')
li_pos2 = LastPos(ls_date2,'+')
If li_pos2 = 0 Then
	li_pos2 = Pos(ls_date2,'-')
End If
ls_timezone2 = Mid(ls_date2,li_pos2, 5)
ls_date2 = Trim(Mid(ls_date2,li_pos1 + 1, li_pos2 - li_pos1 - 1))
If Left(ls_timezone2,1) = '+' Then
	ll_sec2 = Long(Mid(ls_timezone2,2,2)) * 3600 + Long(Mid(ls_timezone2,4,2)) * 60
Else
	ll_sec2 = 0 - (Long(Mid(ls_timezone2,2,2)) * 3600 + Long(Mid(ls_timezone2,4,2)) * 60)
End If

gnv_appeondb.of_startqueue( )
	Select DateAdd(Second,:ll_sec1,Convert(datetime,:ls_date1)), DateAdd(Second,:ll_sec2,Convert(datetime,:ls_date2)) Into :ldt_date1,:ldt_date2 from icred_settings;
	Select Top 1 pop3_sort_rule into :ls_last_sort from em_smtp_accounts where Server = :ls_server;
gnv_appeondb.of_commitqueue( )

If (ldt_date1 = ldt_date2) and ldt_date1 = DateTime(Date('1900-01-01'),Time('00:00:00')) Then
	of_log('','Failed to get the sort rule from the Email server.' + 'ls_date1 = ' + ls_date1 + '; ls_date'+String(al_maxrow)+' =' + ls_date2 ,0,'')
End If

If isnull(ls_last_sort) Then ls_last_sort = ''
If ldt_date1 = ldt_date2 Then Return ls_last_sort

If ldt_date1 < ldt_date2 Then
	ls_sort = 'A'	
Else
	ls_sort = 'D'
End If

If ls_sort <> ls_last_sort Then
	Update em_smtp_accounts set pop3_sort_rule = :ls_sort Where Server = :ls_server;
End If

Return ls_sort


end function

public function long of_receive_msg (boolean ab_batch);Integer li_by_date,li_by_subject,li_by_all,li_by_ctx,li_log,li_delete_server,li_keyword_mode
Datetime ldt_start_date
Long i,j,ll_msg_num,ll_seq
String ls_msg_id,ls_errtext

String ls_to,ls_from,ls_subject,ls_cc,ls_bcc
String ls_fromclx,ls_priority
Long ll_ctx_id,ll_doc_id,ll_ai_id
Datetime ldt_Email_date
String ls_temp_file,ls_attach_list
String ls_body_text,ls_sql_err
Integer li_import,li_fromclx,li_ret
Long ll_msg_cnt,ll_id
Boolean lb_receive
String ls_last_sort,ls_server

li_by_all = Integer(gnv_data.of_getItem("em_user_config", "Email_receive_all", False))
//li_keyword_mode = Integer(gnv_data.of_getItem("em_user_config", "Email_rule_type", False))
li_keyword_mode = Integer(gnv_data.of_getItem("icred_settings", "Email_tag_mode", False))

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("em_user_msg", FALSE)
//------------------------------------------------------------------------

If This.is_status = IS_STOPING Then Return 0

This.of_set_status(This.IS_PROCESSING )

//Reset vars
il_received_cnt = 0 
il_ignored_cnt = 0
il_err_cnt = 0

If ab_batch Then
	ll_msg_cnt = ids_new_msg_id.RowCount()
	If ll_msg_cnt = 0 Then Return 0
Else
	ll_msg_cnt = iole_POP3Mail.GetDownloadableCount()
	ls_server = iole_POP3Mail.MailServer
	Select Top 1 pop3_sort_rule into :ls_last_sort from em_smtp_accounts where Server = :ls_server;
	If isnull(ls_last_sort) or ls_last_sort = '' Then ls_last_sort = 'A'
End If

For i = 1 to ll_msg_cnt 
	is_Messageid = ''
	is_MessageDate = ''
	If is_status = IS_STOPING Then Exit
	
	If ab_batch Then
		ls_msg_id = ids_new_msg_id.GetItemString(i,'msg_id')
	Else
		If ls_last_sort = 'A' Then
			ls_msg_id = iole_POP3Mail.GetMessageID(i)
		Else
			ls_msg_id = iole_POP3Mail.GetMessageID(ll_msg_cnt - i + 1)
		End If
	End If
	
	of_display(is_retrieve_type + ' Receiving ' + String(i)  + '/' + String(ll_msg_cnt) + &
											'. (Received: ' + String(il_received_cnt) + &
											', Ignored: ' + String(il_ignored_cnt) + &
											', Errors: ' + String(il_err_cnt) + ')' )
	
	ls_to = ''
	ls_cc = ''
	ls_bcc = ''
	
	If Left(ls_msg_id,4) = '-ERR' Then Continue
	
	//If downloaded then ignore it.	
	If gnv_data.ids_em_user_msg_list.Find('mail_msg_id = "' + ls_msg_id + '"',1,gnv_data.ids_em_user_msg_list.RowCount()) > 0 Then 
		Continue
	End If
	
	If li_by_all = 1 Then
		If of_receive_msg(ls_msg_id,false) = -1 Then
			il_err_cnt++
			Exit
		Else
			il_received_cnt++
		End If
	Else
		lb_receive = False
		//Download Message Header to check
		ll_msg_num = iole_POP3Mail.GetMessageNumFromID(ls_msg_id)
		If ll_msg_num < 0 Then
			of_log(ls_msg_id,'GetMessageNumFromID('+String(ls_msg_id)+')',ll_msg_num,'')
			il_err_cnt++	
			Exit
		End If
		If li_keyword_mode = 1 Then
			ll_seq = iole_POP3Mail.DownloadSingleMessageHeaders(ll_msg_num)
			If ll_seq < 0 Then 
				of_log(ls_msg_id,'DownloadSingleMessageHeaders('+String(ll_msg_num)+')',ll_seq,'')
				il_err_cnt++
				Exit
			End If
			
			is_Messageid = iole_POP3Mail.Messages.Item(ll_seq).messageid //added by gavins 20121121
			is_MessageDate = iole_POP3Mail.Messages.Item(ll_seq).Date
			
			//If downloaded then ignore it.	
			If gnv_data.ids_em_user_msg_list.Find('messageid ="' + is_Messageid + '" and RFC822Date ="' +is_MessageDate + '"' ,1,gnv_data.ids_em_user_msg_list.RowCount()) > 0 Then
				Continue
			End If
			
			
			ls_subject = iole_POP3Mail.Messages.item(ll_seq).Subject
			//Check Subject
			If Pos(Upper(ls_subject),'CTX') > 0 Then 
				lb_receive = True
			End If
			
			//Check Custom Fields.
			//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
			//If iole_POP3Mail.Messages.item(ll_seq).GetHeaderField('X-FromContractLogix',0) = 'Yes' Then
			If iole_POP3Mail.Messages.item(ll_seq).GetHeaderField('X-FromIntelliSoft',0) = 'Yes' Then //Change 'X-FromContractLogix' for BugA081603 - Eugene 09.17.2013
			//---------End Modfiied ------------------------------------------------------
				lb_receive = True
			End If
		
			If lb_receive Then
				If of_receive_msg(ls_msg_id,false) = -1 Then
					il_err_cnt++
					Exit
				Else
					il_received_cnt++
				End If
			Else
				il_ignored_cnt++
				of_cache_msg_id(gs_user_id,ls_msg_id,0,'Need not receive this mail.')
				//of_log(ls_msg_id,'Need not receive this mail.',0,'')
			End If
		ElseIf li_keyword_mode = 2 Then
			li_ret = of_receive_msg(ls_msg_id,True) //Download , then check body text
			If li_ret = 0 Then
				il_ignored_cnt++
				of_cache_msg_id(gs_user_id,ls_msg_id,0,'Need not receive this mail.')
			Elseif li_ret < 0 Then
				il_err_cnt++
				Exit
			Elseif li_ret > 0 Then
				il_received_cnt++
			End If
			
		End If
	End If
	of_refresh_inbox()

Next

If is_status = IS_STOPING Then
	of_disconnect_pop3()
End If

Return 1
end function

public function integer of_receive_Emails (string as_type);If as_type = 'auto' Then 
	is_retrieve_type = 'Auto'
Else
	is_retrieve_type = ''
End If

If of_get_Email_list() = -1 Then
	of_receive_msg(False)
End If
of_receive_msg(True)
This.post of_set_status(This.IS_COMPLETE )
of_display(is_retrieve_type + ' Received: ' + String(il_received_cnt) + ', Ignored: ' + String(il_ignored_cnt) + ', Errors: ' + String(il_err_cnt)  )
Return 1
end function

public function integer of_log (string as_msg_id, string as_exe_type, long al_err_code, string as_err_text);Integer li_log
Long ll_filehandle
String ls_logfile,ls_err

li_log = Integer(gnv_data.of_getItem("em_user_config", "Email_log", False))

//Log off
If li_log = 0 Then Return 0

ls_logfile = gs_dir_path + gs_DefDirName + '\Email.Log'

ll_filehandle = FileOpen(ls_logfile, LineMode! , Write!, LockWrite!, Append!)
If ll_filehandle > 0 Then
	ls_err = String(today(),'mm/dd/yyyy HH:mm:ss') + ' '
	If as_msg_id <> '' Then
		ls_err += '~r~n~tEmail Message ID: ' + as_msg_id
	End If
	If as_exe_type <> '' Then
		ls_err += '~r~n~tAction: ' + as_exe_type
	End If
	
	If al_err_code <> 0 Then
		ls_err += '~r~n~tResult: ' + String(al_err_code)
	End If
	
	If as_err_text <> '' Then
		ls_err += '~r~n~tError: ' + as_err_text
	End If

	If FileWrite(ll_filehandle,ls_err) < 0 Then
		Messagebox('Error',' Failed to open ' + ls_logfile)
	End If
	FileClose(ll_filehandle)
Else
	Messagebox('Error',' Failed to open ' + ls_logfile)
End If


Return 1
end function

public function string of_download_attachment (long al_mail_id, long al_attach_id, string as_attach_name, string as_attach_type);
Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data	
Blob  lb_image_data
Datetime ldt_modify
String ls_attach_dir,ls_attach_sub_dir,ls_attach_pathname,ls_attach_regname

ls_attach_dir = of_get_Email_attachdir(al_mail_id,'doc')

If ls_attach_dir = '' Then Return ''
If as_attach_type = 'a' Then 
	//Attachment
	ls_attach_sub_dir = ls_attach_dir + '\' + String(al_attach_id) 
Else
	//MIME files
	ls_attach_sub_dir = ls_attach_dir + 'MIME'
End If

gnv_appeondll.of_parsepath(ls_attach_sub_dir)

ls_attach_pathname = ls_attach_sub_dir + '\' + as_attach_name

If of_check_register_attach(al_attach_id,ls_attach_regname,ldt_modify) Then
	If FileExists(ls_attach_pathname) Then
		Return ls_attach_pathname
	End If
Else
	If FileExists(ls_attach_pathname) Then
		If Not FileDelete(ls_attach_pathname) Then
			Messagebox('Error','Failed to delete the cache file ' + ls_attach_pathname + '.')
			Return ''			
		End If
	End If
End If

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		SELECT Datalength(image_file)
		INTO :ll_data_length
		FROM em_mail_item_attachments
		WHERE id = :al_attach_id;
		
		IF SQLCA.SQLCODE = -1 THEN RETURN ''
		
		IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
			RETURN ''
		END IF
		
		//Get length of the blob
		IF ll_data_length > 8000 THEN 
			 IF Mod(ll_data_length,8000) = 0 THEN 
				  li_loops = ll_data_length/8000 
			 ELSE 
				  li_loops = (ll_data_length/8000) + 1 
			 END IF 
		ELSE 
			 li_loops = 1 
		END IF 
		
		//Display progress bar for the large blob
		li_NewStep = 20
		IF li_loops > li_NewStep THEN
			IF IsValid(w_appeon_gifofwait) THEN 
				//Keep the original progress bar
				lb_needrestore = TRUE
				ls_title = w_appeon_gifofwait.st_1.Text
				li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
				li_Position = w_appeon_gifofwait.hpb_1.Position
				li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
			ELSE
				OpenwithParm(w_appeon_gifofwait,"Getting the attachment data...")
			END IF
			//Set the new progress bar
			li_loopsR = li_loops / li_NewStep
			IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
			w_appeon_gifofwait.st_1.Text = "Getting the attachment data..."
			w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
			w_appeon_gifofwait.hpb_1.Position = 0
			w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
		END IF
		
		//Get and store the blob
		li_rtn = 1
		FOR li_counter = 1 to li_loops
			ll_start = (li_counter - 1) * 8000 + 1
			SELECTBLOB substring(image_file,:ll_start,8000)
					INTO :lb_data
					FROM em_mail_item_attachments
					WHERE id = :al_attach_id;
			IF SQLCA.SQLCODE = -1 THEN 
				li_rtn = -1
				EXIT
			END IF
			lb_all_data += lb_data
			
			//Change the progress bar
			IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
				IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
			ELSE
				IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
			END IF
		NEXT 
		
		//Restore Progress Bar
		IF IsValid(w_appeon_gifofwait) and li_loops > li_NewStep THEN 
			IF lb_needrestore THEN
				w_appeon_gifofwait.st_1.Text = ls_title
				w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
				w_appeon_gifofwait.hpb_1.Position = li_Position
				w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
			ELSE
				Close(w_appeon_gifofwait)
			END IF
		END IF
		
		//Store the blob
		lb_image_data = lb_all_data

ElSE
	//For WEB
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	OpenwithParm(w_appeon_gifofwait,"Getting the attachment data...")
	Timer(1,w_appeon_gifofwait)
	
	SELECTBLOB image_file
	INTO :lb_image_data
	FROM em_mail_item_attachments
	WHERE id = :al_attach_id;
	
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return ''
	END IF
END IF

inv_dm_utils.of_saveblob(ls_attach_pathname, lb_image_data)
This.of_update_register_attach(al_attach_id, ls_attach_regname, ldt_modify)

Return ls_attach_pathname


end function

public function integer of_download_attachments (long al_Email_id, ref string as_attachlist[], ref string as_mimelist[], integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_download_attachments()
// $<arguments>
//		value    	long   	al_Email_id    		
//		reference	string 	as_attachlist[]		
//		reference	string 	as_mimelist[]  		
//		value    	integer	ai_type 1: attachment 2: Mime 3: Both       		 
// $<returns> integer
// $<description> Download attachment and MIME file from database
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_attach_id
String ls_empty[]
String ls_attach_name,ls_attach_type,ls_attach_pathname

DataStore lds_attach
lds_attach = Create DataStore
lds_attach.DataObject = 'd_em_mail_attach'
lds_attach.SetTransobject(SQLCA)
lds_attach.Retrieve(al_Email_id)

as_attachlist[] = ls_empty[]
as_mimelist[] = ls_empty[]
For i = 1 To lds_attach.RowCount()
	ll_attach_id = lds_attach.GetItemNumber(i,'id')
	ls_attach_name = lds_attach.GetItemString(i,'attachment_name')
	ls_attach_type = lds_attach.GetItemString(i,'type')
	If Upper(ls_attach_type) = 'A' and ai_type = 2 Then Continue
	If Upper(ls_attach_type) = 'M' and ai_type = 1 Then Continue
	ls_attach_pathname = This.of_download_attachment( al_Email_id, ll_attach_id, ls_attach_name, ls_attach_type)
	If ls_attach_pathname <> '' and FileExists(ls_attach_pathname) Then
		Choose Case Upper(ls_attach_type)
			Case 'A'
				as_attachlist[UpperBound(as_attachlist[]) + 1] = ls_attach_pathname
			Case 'M'
				as_mimelist[UpperBound(as_mimelist[]) + 1] = ls_attach_pathname
		End Choose
	End If
Next

Return 1


end function

public function integer of_get_attach_mime (long al_mail_id, string as_eml_file, ref string as_attachlist[], ref string as_mimelist[], integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_get_attach_mime()
// $<arguments>
//		value	long   	al_mail_id     		
//		value	string 	as_eml_file    		
//		reference	string 	as_attachlist[]		
//		reference	string 	as_mimelist[]  		
//		value	integer	ai_type  1: only get attach; 2: only get mime files; 3 get both.		
// $<returns> integer
// $<description>  Get Attachment file list and MIME list from a EML file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////


String ls_html_dir,ls_filename,ls_attach_dir
Long ll_msg_num
oleobject lole_word
Integer li_cnt,i
String ls_empty[]


//Reset Vars
as_attachlist[] = ls_empty[]
as_mimelist[] = ls_empty[]

If Not isvalid(iole_POP3Mail) Then
	This.of_createobject( )
End If

ls_attach_dir = of_get_Email_attachdir(al_mail_id,'eml')

//Load Message
iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
ll_msg_num = iole_POP3Mail.LoadMessage(as_eml_file,0)
If ll_msg_num  > 0 Then
	//Get Attachments	
	If ai_type = 1 or ai_type = 3 Then
		li_cnt = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Count
		For i = 1 To li_cnt
			ls_filename = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).FileName
			If ls_filename = 'unknown.unk' Then
				ls_filename = of_get_attachname(iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i))
				//Continue
			End If
			If iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).Save(ls_attach_dir + '\' + ls_filename,True) = 0 Then
				as_attachlist[UpperBound(as_attachlist[]) + 1 ] = ls_attach_dir + '\' + ls_filename
			End If
		Next
	End If
	
	//Get MIME Files
	If ai_type = 2 or ai_type = 3 Then	
		li_cnt = iole_POP3Mail.Messages.Item(ll_msg_num).MIMEParts.Count
		For i = 1 To li_cnt
			ls_filename = iole_POP3Mail.Messages.Item(ll_msg_num).MIMEParts.Item(i).FileName
			If ls_filename = 'unknown.unk' Then 
				ls_filename = of_get_attachname(iole_POP3Mail.Messages.Item(ll_msg_num).MIMEParts.Item(i))
				//Continue
			End If
			If iole_POP3Mail.Messages.Item(ll_msg_num).MIMEParts.Item(i).Save(ls_attach_dir + '\' + ls_filename, True) = 0 Then
				as_mimelist[UpperBound(as_mimelist[]) + 1 ] = ls_attach_dir + '\' + ls_filename				
			End If
		Next
	End If
End If

Return 1
end function

public function long of_receive_msg (string as_msg_id, boolean ab_checkbody);String ls_to,ls_from,ls_subject,ls_cc,ls_bcc
String ls_fromclx,ls_priority,ls_errtext
Long ll_msg_num,j
Datetime ldt_Email_date
String ls_temp_file,ls_attach_list
String ls_body_text,ls_sql_err
Integer li_import,li_fromclx,li_delete_server
Long ll_msg_cnt,ll_id,ll_seq,ll_seq1,ll_seq2
Integer li_keyword_mode
Long ll_start,ll_end
String ls_temp
String ls_ctx_id,ls_doc_id,ls_ai_id

//Delete Email temp files
iole_POP3Mail.Messages.DeleteAll()

//li_keyword_mode = Integer(gnv_data.of_getItem("em_user_config", "Email_rule_type", False))
li_keyword_mode = Integer(gnv_data.of_getItem("icred_settings", "Email_tag_mode", False))

ll_msg_num = iole_POP3Mail.GetMessageNumFromID(as_msg_id) 
If ll_msg_num < 0 Then
	of_log(as_msg_id,'GetMessageNumFromID('+String(as_msg_id)+')',ll_msg_num,'')
	Return -1	
End If

//Download Message with plaintext to get BodyText(not include HTML marker )
iole_POP3Mail.PreferredBodyFormat = 0 //PlainText
ll_seq1 = iole_POP3Mail.DownloadSingleMessage(ll_msg_num)
If ll_seq1 < 0 Then 
	of_log(as_msg_id,'DownloadSingleMessage('+String(ll_msg_num)+')',ll_seq1,'')
	Return -1
End If	
ls_body_text = iole_POP3Mail.Messages.Item(ll_seq1).BodyText

is_Messageid = iole_POP3Mail.Messages.Item(ll_seq1).messageid //added by gavins 20121121
is_MessageDate = iole_POP3Mail.Messages.Item(ll_seq1).Date

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("em_user_msg", FALSE)
//------------------------------------------------------------------------------------------------------

//If downloaded then ignore it.	
If gnv_data.ids_em_user_msg_list.Find('messageid ="' + is_Messageid + '" and RFC822Date ="' +is_MessageDate + '"' ,1,gnv_data.ids_em_user_msg_list.RowCount()) > 0 Then
	il_received_cnt  = il_received_cnt - 1
	return 0
End If

//Get Custom Fields
//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
//If iole_POP3Mail.Messages.item(ll_seq1).GetHeaderField('X-FromContractLogix',0) = 'Yes' Then
If iole_POP3Mail.Messages.item(ll_seq1).GetHeaderField('X-FromIntelliSoft',0) = 'Yes' Then //Change 'X-FromContractLogix' for BugA081603 - Eugene 09.17.2013
//---------End Modfiied ------------------------------------------------------
	li_fromclx = 1 //Always receive when come from contract logix.
	ls_ctx_id = String(iole_POP3Mail.Messages.item(ll_seq1).GetHeaderField('X-ContractID',0))
	ls_doc_id = String(iole_POP3Mail.Messages.item(ll_seq1).GetHeaderField('X-DocumentID',0))
	ls_ai_id = String(iole_POP3Mail.Messages.item(ll_seq1).GetHeaderField('X-ActionItemID',0))
Else
	li_fromclx = 0
End If

//Check Body Keywords , Get  CTX_ID, DOC_ID, AI_ID
If li_fromclx = 0 Then
		ll_start = LastPos(ls_body_text,'$$<|')
		ll_end = LastPos(ls_body_text,'|>$$')
		ls_temp = '(' + Mid(ls_body_text,ll_start,ll_end - ll_start + 5) + ')'//Format: $$<|CTX_ID = -1, DOC_ID = -1, AI_ID = -1|>$$
		If inv_easy_smtp.of_get_keyword(ls_temp, ls_ctx_id, ls_doc_id, ls_ai_id ) < 0 Then
			If ab_checkbody Then Return 0 //Ignore it
		End If
End If

//Download Message with HTML.
iole_POP3Mail.PreferredBodyFormat = 1 //HTML
ll_seq2 = iole_POP3Mail.DownloadSingleMessage(ll_msg_num)
If ll_seq2 < 0 Then 
	of_log(as_msg_id,'DownloadSingleMessage('+String(ll_msg_num)+')',ll_seq2,'')
	Return -1
End If	

If iole_POP3Mail.Messages.Item(ll_seq2).HTMLPartsDirectory <> '' Then
	ll_seq = ll_seq2
Else
	ll_seq = ll_seq1
End If

//Get Message Properties
For j = 1 To iole_POP3Mail.Messages.item(ll_seq).Recipients.count
	If iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).Type = 1 Then
		If ls_to = '' Then
			ls_to = String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 	
		Else
			ls_to += '; ' + String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 	
		End If
	ElseIf iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).Type = 2 Then
		If ls_cc = '' Then
			ls_cc = String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 
		Else
			ls_cc += '; ' + String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 
		End If
	ElseIf iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).Type = 3 Then	
		If ls_bcc = '' Then
			ls_bcc = String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 
		Else
			ls_bcc += '; ' + String(iole_POP3Mail.Messages.item(ll_seq).Recipients.Item(j).address) 
		End If
	End If
Next

is_Messageid = iole_POP3Mail.Messages.Item(ll_seq).messageid //added by gavins 20121121
is_MessageDate = iole_POP3Mail.Messages.Item(ll_seq).Date

//If downloaded then ignore it.	
If gnv_data.ids_em_user_msg_list.Find('messageid ="' + is_Messageid + '" and RFC822Date ="' +is_MessageDate + '"' ,1,gnv_data.ids_em_user_msg_list.RowCount()) > 0 Then
	il_received_cnt  = il_received_cnt - 1
	return 0
End If


ls_attach_list = of_get_attach_list(iole_POP3Mail.Messages.item(ll_seq))
ls_temp_file = iole_POP3Mail.Messages.item(ll_seq).TempMsgSourceFile
ls_from = String(iole_POP3Mail.Messages.item(ll_seq).FromAddr )
ls_subject = iole_POP3Mail.Messages.item(ll_seq).Subject
ls_priority = iole_POP3Mail.Messages.item(ll_seq).Priority
Choose Case ls_priority
	Case "1" //high
		li_import = 1
	Case "3","" //normal
		li_import = 0
	Case "4","5" //low
		li_import = -1
End Choose

If li_keyword_mode = 1 Then //Subject Mode
	inv_easy_smtp.of_get_keyword(ls_subject, ls_ctx_id, ls_doc_id,ls_ai_id)
End If

//ldt_Email_date = iole_POP3Mail.Messages.item(ll_seq).Timestamps.Item(1).DateTime
ldt_Email_date = of_get_Email_date(iole_POP3Mail.Messages.item(ll_seq))

//Save to DB
ids_received_msg.Reset()
ids_received_msg.InsertRow(0)
ids_received_msg.Setitem(1,'user_id',gs_user_id)
ids_received_msg.Setitem(1,'folder_id',2)
ids_received_msg.Setitem(1,'sub_folder_id',2)
ids_received_msg.Setitem(1,'mail_msg_id',as_msg_id)
ids_received_msg.Setitem(1,'mail_date',ldt_Email_date)
ids_received_msg.Setitem(1,'mail_subject',ls_subject)
ids_received_msg.Setitem(1,'mail_importance',li_import)
ids_received_msg.Setitem(1,'mail_from',ls_from)
ids_received_msg.Setitem(1,'mail_to',ls_to)
ids_received_msg.Setitem(1,'mail_cc',ls_cc)
ids_received_msg.Setitem(1,'mail_attach_name',ls_attach_list)
//ids_received_msg.Setitem(1,'mail_action_item_id',ll_ai_id)
ids_received_msg.Setitem(1,'mail_fromclx',li_fromclx)
ids_received_msg.Setitem(1,'mail_save_format','eml')
ids_received_msg.Setitem(1,'read_status',0)
ids_received_msg.Setitem(1,'locked',0)
ids_received_msg.Setitem(1,'deleted',0)
ids_received_msg.Setitem(1,'flag',0)
//ids_received_msg.Setitem(1,'mail_ctx_id',ll_ctx_id)
//ids_received_msg.Setitem(1,'mail_doc_id',ll_doc_id)
ids_received_msg.Setitem(1,'ctx_id_list',ls_ctx_id)
ids_received_msg.Setitem(1,'doc_id_list',ls_doc_id)
ids_received_msg.Setitem(1,'mail_action_item_id',Long(ls_ai_id))

//For checkin document in email item
If Pos(ls_ctx_id,',') = 0 Then
	ids_received_msg.SetItem(1,'mail_ctx_id',Long(ls_ctx_id))
End If
If Pos(ls_doc_id,',') = 0 Then
	ids_received_msg.SetItem(1,'mail_doc_id',Long(ls_doc_id))
End If	

ids_received_msg.Setitem(1,'protocoltype', 'POP3' )

If ids_received_msg.Update() <> 1 Then 
	ls_sql_err = sqlca.sqlerrtext 
	of_cache_msg_id(gs_user_id,as_msg_id,-1,ls_sql_err)
	of_log(as_msg_id,'of_cache_msg_id()',0,'Failed to update Mail Item to DB. ' + ls_sql_err)
	ids_received_msg.Reset()
	Return -2
End If

//Update Email File to DB
ll_id = ids_received_msg.GetItemNumber(1,'id')

If This.of_update_Email_blob( ll_id, iole_POP3Mail.Messages.item(ll_seq),ls_body_text,ls_errtext ) < 0 Then
	of_log(as_msg_id,'of_update_Email_blob('+String(ll_id)+')',0,ls_errtext)
	//Delete main record
	Delete From em_mail_items Where id = :ll_id;
	of_cache_msg_id(gs_user_id,as_msg_id,-1,ls_errtext)
	ids_received_msg.Reset()
	Return -3
End If
of_cache_msg_id(gs_user_id,as_msg_id,1,'')

li_delete_server = Integer(gnv_data.of_getItem("em_user_config", "Email_delete_from_server", False))
If li_delete_server = 1 then
	iole_POP3Mail.DeleteSingleMessage(ll_msg_num)
End If

//Delete Email temp files
iole_POP3Mail.Messages.DeleteAll()

Return 1
end function

public function integer of_do_attach (string as_emlfile, long al_emailid, long al_index, string as_dotype, ref string as_exportfile);Long ll_msg_num,i = 0,j = 0,k = 0
String ls_attachdir,ls_pathfilename,ls_filename
Long ll_ret,ll_attach_id
String ls_ext,ls_null,ls_attach_name,ls_attach_file,ls_attach_file_temp

If al_index <= 0 Then Return 0

If as_emlfile <> '' Then //EML's attachments
	If Not FileExists(as_emlfile) Then
		as_emlfile = This.of_download_Email( al_Emailid, 'eml')
	End If
	If Not FileExists(as_emlfile) Then
		Messagebox('Error','Failed to download the EML file from the database.')
		Return -1
	End If
	
	oleobject lole_word
	
	If Not isvalid(iole_POP3Mail) Then
		This.of_createobject( )
	End If
	
	ls_attachdir = This.of_get_Email_attachdir(al_Emailid,'eml')
	
	iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
	ll_msg_num = iole_POP3Mail.LoadMessage(as_emlfile,0)
	If ll_msg_num  > 0 Then
		If iole_POP3Mail.Messages.Item(ll_msg_num).attachments.count = 0 Then Return -1
		For i = 1 To iole_POP3Mail.Messages.Item(ll_msg_num).attachments.count
			ls_filename = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).filename
			If ls_filename = 'unknown.unk' Then 
				ls_filename = of_get_attachname(iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i))
				//Continue //Commented By Ken.Guo 2010-11-09
			End If
			j++
			//Search target attachment by index.
			If j = al_index Then
				//Generate file name
				//ls_filename = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).filename
				ls_pathfilename = ls_attachdir + '\' + ls_filename
				If FileExists(ls_pathfilename) Then
					Do While 1 = 1 
						If filedelete(ls_pathfilename) Then Exit
						k++
						ls_pathfilename = of_gen_nextfilename(ls_filename,k)
						If Not FileExists(ls_pathfilename) Then Exit
						If k = 100 Then
							Messagebox('Error','Failed to create the attachment name in the folder "' + ls_attachdir + '"')
							Return -1
						End If
					Loop
				End If
				
				//Export attachment
				ll_ret = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).Save(ls_pathfilename,True)
				If ll_ret <> 0 Then
					Messagebox('Error','Failed to export the attachment to '+ls_pathfilename+'. Error code is ' + String(ll_ret) + '.')
					Return -2
				End If	
				
				//inv_cst_filesrv.of_runfile(ls_pathfilename)
				Choose Case Lower(as_dotype) 
					Case 'open'
						//FileCopy(ls_pathfilename,ls_attach_file_temp,True)
						inv_cst_filesrv.of_runfile(ls_pathfilename)				
					Case 'saveas'
						inv_cst_filesrv.of_filesaveas( ls_pathfilename, True)
					Case 'checkin', 'add to document-ctx', 'add to document-select ctx'		//Added By Mark Lee 06/13/2013 add to type  'add to document-ctx' and 'add to document-select ctx'	
						as_exportfile = ls_pathfilename
					Case 'copy'
						FileCopy(ls_pathfilename,as_exportfile,True)
				End Choose

				Return 1
			End If
		Next
		Messagebox('Error','Failed to open the attachment, please call support.')		
		Return -3	
	Else
		Messagebox('Error','Failed to load the EML file, please call support.')		
		Return -4
	End If
Else //Word's attachments
	ids_mail_attach.Retrieve(al_Emailid,'a')
	If ids_mail_attach.Rowcount() = 0 or al_index > ids_mail_attach.Rowcount() Then
		Messagebox('Error','This Email item has no attachment in the database.')
		Return -1
	End If
	ll_attach_id = ids_mail_attach.GetItemNumber(al_index,'id')
	ls_attach_name = ids_mail_attach.GetItemString(al_index,'attachment_name')
	ls_attach_file = This.of_download_attachment( al_Emailid,ll_attach_id,ls_attach_name,'a') 
	If ls_attach_file <> '' Then
		ls_attach_file_temp = This.of_get_Email_attachdir( al_Emailid, 'eml') + '\' + ls_attach_name

		If FileExists(ls_attach_file_temp) Then
			Do While 1 = 1 
				If filedelete(ls_attach_file_temp) Then Exit
				k++
				ls_attach_file_temp = of_gen_nextfilename(ls_attach_file_temp,k)
				If Not FileExists(ls_attach_file_temp) Then Exit
				If k = 100 Then
					Messagebox('Error','Failed to create the file with the same name of attachment in the folder "' + This.of_get_Email_attachdir( al_Emailid, 'eml') + '"')
					Return -1
				End If
			Loop
		End If	
		Choose Case Lower(as_dotype) 
			Case 'open'
				FileCopy(ls_attach_file,ls_attach_file_temp,True)
				inv_cst_filesrv.of_runfile(ls_attach_file_temp)				
			Case 'saveas'
				inv_cst_filesrv.of_filesaveas( ls_attach_file, True)
			Case 'checkin', 'add to document-ctx', 'add to document-select ctx'		//Added By Mark Lee 06/13/2013 add to type  'add to document-ctx' and 'add to document-select ctx'	
				FileCopy(ls_attach_file,ls_attach_file_temp,True)
				as_exportfile = ls_attach_file_temp
			Case 'copy'
				FileCopy(ls_attach_file,as_exportfile)
		End Choose
	End If
	
End If

Return 1



end function

public function string of_get_ref_docname (long al_doc_id);String ls_doc_name,ls_doc_ext,ls_checkout_by,ls_checkout_status,ls_revision_control
Decimal ldec_revision

If al_doc_id <= 0 Then Return ''

SELECT	doc_name,   
			revision,   
			doc_ext,   
			checkout_by,   
			checkout_status,   
			revision_control 
Into	:ls_doc_name,
		:ldec_revision,
		:ls_doc_ext,
		:ls_checkout_by,
		:ls_checkout_status,
		:ls_revision_control
FROM ctx_am_document 
WHERE doc_id = :al_doc_id    ;	

If sqlca.sqlcode <> 0 Then
	Return ''
End If

If ls_checkout_status = '0' or isnull(ls_checkout_status) Then 
	Return ''
End If

If lower(ls_checkout_by) <> Lower(gs_user_id) Then
	Return ''
End If

Return gf_merge_file_name(ls_doc_name,ls_doc_ext,al_doc_id,ldec_revision)	

end function

public function integer of_parse_msg (string as_msgfile, ref string as_from, ref string as_to, ref string as_cc, ref string as_bcc, ref string as_subject, ref string as_bodydocfile, ref datetime adt_date, ref integer ai_importtance, ref string as_attachlist[], integer ai_readed);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3Script - of_parse_msg ( string as_msgfile, ref string as_from, ref string as_to, ref string as_cc, ref string as_bcc, ref string as_subject, ref string as_bodystring, ref string as_bodydocfile, ref datetime as_date, ref integer ai_importtance, ref string()
// $<arguments>
//		value    	string  	as_msgfile     		
//		reference	string  	as_from        		
//		reference	string  	as_to          		
//		reference	string  	as_cc          		
//		reference	string  	as_bcc         		
//		reference	string  	as_subject     		
//		reference	string  	as_bodydocfile 		
//		reference	datetime	as_date        		
//		reference	integer 	ai_importtance 		
//		reference	string  	as_attachlist[]	
//		reference	integer 	ai_readed 	
// $<returns> (none)
// $<description> Parse *.MSG file
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-05-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Oleobject lole_outlook,lole_mailitem
integer i,li_ret,li_importance,li_cnt
String ls_from,ls_to,ls_cc,ls_bcc
String ls_temp_dir 
long ll_size
n_cst_string lnv_string

//Added By Ken.Guo 07/18/2013. Reset them
String ls_empty[]
as_from  = ''       		
as_to    = ''      		
as_cc    = ''      		
as_bcc   = ''      		
as_subject = ''     		
as_bodydocfile = ''		
as_attachlist[] = ls_empty[]	


If Not FileExists(as_msgfile) Then
	Messagebox('Parse MSG','The MSG file '+as_msgfile+' does not exist.')
	Return -1
End If

ls_temp_dir = of_get_Email_tempdir()

lole_outlook = Create Oleobject
li_ret = lole_outlook.connecttonewobject( "Outlook.Application")
If li_ret <> 0 Then
	Messagebox('Error','Failed to connect to the MS OutLook, Please make sure the MS Outlook has been installed on your machine.')
	Return -1
End If
//Commented By Mark Lee 07/03/2013 moved to of_import_msg()
//Messagebox('Contract Logix', 'During the import, the MS Outlook will pop up a message box. Please always click the Allow button.')

lole_mailitem = Create Oleobject

Try 
	lole_mailitem = lole_outlook.CreateItemFromTemplate(as_msgfile)
	
	For i = 1 To lole_mailitem.Attachments.Count
		as_attachlist[i] = ls_temp_dir + '\' + lole_mailitem.Attachments.Item(i).filename
		lole_mailitem.Attachments.Item(i).SaveAsFile(as_attachlist[i])
	Next

	li_importance = lole_mailitem.Importance
	Choose Case li_importance
		Case 2 //olImportanceHigh
			ai_importtance = 1
		Case 0 //olImportanceLow
			ai_importtance = -1
		Case 1 //olImportanceNormal
			ai_importtance = 0
	End Choose
	
	If lole_mailitem.unread Then
		ai_readed = 0
	Else
		ai_readed = 1
	End If
	//as_searchtext = lnv_string.of_GlobalReplace(as_searchtext, "'", "")			
	If lole_mailitem.SenderEmailType = 'SMTP' Then
		li_cnt = lole_mailitem.Recipients.Count
		For i = 1 To li_cnt
			Choose Case lole_mailitem.Recipients.Item(i).Type
				Case 0 //Originator ?
					
				Case 1 //To
					as_to += lole_mailitem.Recipients.Item(i).Address + ';'
				Case 2 //Cc
					as_cc += lole_mailitem.Recipients.Item(i).Address + ';'
				Case 3 //Bcc
					as_bcc += lole_mailitem.Recipients.Item(i).Address + ';'
			End Choose
		Next	
		as_from = lole_mailitem.SenderEmailAddress	
	Else
		as_from = lole_mailitem.SenderName
		as_to = lnv_string.of_GlobalReplace(lole_mailitem.To, "'", "")
		as_cc = lnv_string.of_GlobalReplace(lole_mailitem.Cc, "'", "")
		as_bcc = lnv_string.of_GlobalReplace(lole_mailitem.Bcc, "'", "")
	End If
	
	//Check Parse Result.
	If as_from = '' Then
		Messagebox('Error','Failed to parse the MSG file.')
		If isvalid(lole_outlook) Then Destroy lole_outlook
		If isvalid(lole_mailitem) Then Destroy lole_mailitem
		Return -1
	End If	

	as_subject = lole_mailitem.Subject
	adt_date = lole_mailitem.ReceivedTime
	
	as_bodydocfile = ls_temp_dir + '\import_temp.doc'
	If FileExists(as_bodydocfile) Then
		If Not FileDelete(as_bodydocfile) Then
			Messagebox('Error','Failed to delete the temp file ' + as_bodydocfile )
			If isvalid(lole_outlook) Then Destroy lole_outlook
			If isvalid(lole_mailitem) Then Destroy lole_mailitem			
			Return -1
		End If
	End If
	lole_mailitem.SaveAs(as_bodydocfile,4)
	If Not FileExists(as_bodydocfile) Then
		Messagebox('Error','Failed to convert the MSG file to word format.')
		If isvalid(lole_outlook) Then Destroy lole_outlook
		If isvalid(lole_mailitem) Then Destroy lole_mailitem				
		Return -1
	End If
	
Catch (RuntimeError err1)
	Messagebox('Error', 'Failed to parse the MSG file. ' + err1.Text)
	If isvalid(lole_outlook) Then Destroy lole_outlook
	If isvalid(lole_mailitem) Then Destroy lole_mailitem	
	Return -1
End Try

Return 1
end function

public function integer of_import_msg (str_import_msg astr_msg);Integer li_importtance,li_readed
String ls_filename,ls_from,ls_to,ls_cc,ls_bcc
String ls_subject, ls_bodydocfile, ls_attachlist[]
Datetime ldt_date
String 	ls_fullname
Long 		i, ll_count

OpenWithParm(w_em_import_msg,astr_msg)

If Message.powerobjectparm.classname() <> 'str_import_msg' Then
	Return -1
End If
astr_msg = Message.powerobjectparm 

//Added By Mark Lee 07/03/2013
//If astr_msg.as_filename = '' Then
//	Return -1
//End If
IF isnull(astr_msg.as_filename) Then 
	Return -1
End IF 

ls_fullname = astr_msg.as_filename[1]
IF isnull(ls_fullname) or trim(ls_fullname) = "" Then
	Return -1
End IF 

//Added By Mark Lee 07/12/2013
IF not isnull(astr_msg.as_paste_way) and astr_msg.as_paste_way = 'outlook' Then
	// move to space which was use the paste mail.
Else
	//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
	//Messagebox('Contract Logix', 'During the import, the MS Outlook will pop up a message box. Please always click the Allow button.')		//Added By Mark Lee 07/03/2013
	Messagebox('IntelliSoft', 'During the import, the MS Outlook will pop up a message box. Please always click the Allow button.')
	//---------End Modfiied ------------------------------------------------------
End IF 
//Begin - Modified By Mark Lee 07/03/2013 add the for ... next loop
SetPointer(HourGlass!)
ll_count = Upperbound(astr_msg.as_filename)
For i = 1 to ll_count 
	ls_fullname = astr_msg.as_filename[i]
	IF isnull(ls_fullname) or trim(ls_fullname) = "" Then
		Post SetPointer(Arrow!)			//Added By Mark Lee 07/04/2013
		Return -1
	End IF 
	//If astr_msg.as_filename <> '' Then
	If ls_fullname <> '' Then
	//	If FileExists(astr_msg.as_filename) Then
		If FileExists(ls_fullname) Then
	//		If This.of_parse_msg(astr_msg.as_filename, ls_from, ls_to, ls_cc, ls_bcc, ls_subject, ls_bodydocfile, ldt_date, li_importtance, ls_attachlist[],li_readed) > 0 Then
			If This.of_parse_msg(ls_fullname, ls_from, ls_to, ls_cc, ls_bcc, ls_subject, ls_bodydocfile, ldt_date, li_importtance, ls_attachlist[],li_readed) > 0 Then
				If This.of_save_msg( astr_msg.al_folder_id, astr_msg.al_sub_folder_id, ls_subject, ls_bodydocfile, li_importtance, ls_from, ls_to, ls_cc, ls_attachlist[], ldt_date, li_readed, String(astr_msg.al_ctx_id), String(astr_msg.al_doc_id), String(astr_msg.al_ai_id )) > 0 Then
					//Begin - Added By Mark Lee 07/01/2013.
					IF not isnull(astr_msg.as_paste_way) and astr_msg.as_paste_way = 'outlook' Then
						FileDelete(astr_msg.as_filename[i]) 
					End IF 
					//End - Added By Mark Lee 07/01/2013.
					//Refresh folders
					If isvalid(w_Email_folder) Then
						ids_received_msg.Rowscopy( 1, 1, Primary!, w_Email_folder.idw_folder_browse[astr_msg.al_folder_id], 1, Primary!)
						w_Email_folder.idw_folder_browse[astr_msg.al_folder_id].resetupdate()
					End If
					//Added By Mark Lee 07/04/2013
					If isvalid(gw_contract) Then
						If gw_contract.tab_contract_details.Selectedtab = 12 Then 
							IF isvalid(w_contract_email_folder) then  
								ids_received_msg.Rowscopy( 1, 1, Primary!, w_contract_email_folder.idw_folder_browse[astr_msg.al_folder_id], 1, Primary!)
								w_contract_email_folder.idw_folder_browse[astr_msg.al_folder_id].resetupdate()							
							End IF 
						End IF 
					End If
				Else
					Post SetPointer(Arrow!)
					Return -1
				End If
			End If
		Else
			Post SetPointer(Arrow!)
			Messagebox('Import','Failed to Select/Paste the Email file.')
			Return -1
		End If
	End If
Next 
//End - Modified By Mark Lee 07/03/2013

Post SetPointer(Arrow!)
Messagebox('Import','Succeed to import the Email file.')			//Added By Mark Lee 07/12/2013
Return 1


end function

public function integer of_doc2html (string as_docname, ref string as_htmlname);String ls_doc_namenew  

//Added By Ken.Guo 12/12/2013
If Not FileExists(as_docname) Then
	gnv_debug.of_output(True, 'File is not exists. ' + as_docname + '.' )
	Messagebox('Error ' , 'File is not exists. ' + as_docname + '.' )
	Return -1	
End If
ls_doc_namenew = inv_easy_smtp.of_gettempfile( 'Tempconvert', 'doc')
If ls_doc_namenew = '' Then Return -1
If FileCopy(as_docname, ls_doc_namenew) <> 1 Then
	gnv_debug.of_output(True, 'Failed to copy ' + as_docname + ' to ' + ls_doc_namenew + '.' )
	Messagebox('Error ' , 'Failed to copy ' + as_docname + ' to ' + ls_doc_namenew + '.')
	Return -2
End IF

If not isvalid(iole_word) Then
	iole_word = Create oleobject
	IF iole_word.Connecttonewobject("word.application") <> 0 THEN
		messagebox('Error','failed to create word')
		Destroy iole_word
		Return -1
	End If
End If

iole_word.Application.NormalTemplate.Saved = TRUE		
Try
	oleobject ole_document
	ole_document = iole_word.Application.Documents.Open(ls_doc_namenew,false,true)
	gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( ls_doc_namenew, true) //Delete Windows Recent Document
	ole_document.saveas(as_htmlname,8,false,'',false) //8: HTML format
	gnv_shell.of_delete_recent(as_htmlname, true) //Delete Windows Recent Document
	ole_document.Close(0)
	
	//Added By Ken.Guo 12/12/2013.  USE NTKO control to save as html.
	w_email_edit lw_email_edit
	If Not FileExists(as_htmlname) Then
		Open(lw_email_edit)
		lw_email_edit.visible = true
		lw_email_edit.ole_word.of_open( as_docname, true)
		lw_email_edit.ole_word.Object.ActiveDocument.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2010-01-07.
		If gs_ImageView_Version <> '4.0' Then lw_email_edit.ole_word.Object.FileSave = True		
		//lw_email_edit.ole_word.Object.SaveAsHTMLFile(as_htmlname) //delete it. NTKO will popup a dialog window.
		lw_email_edit.ole_word.Object.ActiveDocument.saveas(as_htmlname,8,false,'',false)
		If gs_ImageView_Version <> '4.0' Then lw_email_edit.ole_word.Object.FileSave = False 
		lw_email_edit.ole_word.of_close( )
		Close(lw_email_edit)
		
		If Not FileExists(as_htmlname) Then
			Messagebox('Error 1','Failed to convert Doc to HTML file. Please open Windows Task Manager and look for the WINWORD.exe process and right click on that entry and click End Process. Then try again.')
			Return -1
		End If
	End If
	
	If Not FileExists(as_htmlname) Then
		Messagebox('Error 2','Failed to convert Doc to HTML file. Please open Windows Task Manager and look for the WINWORD.exe process and right click on that entry and click End Process. Then try again.')
		Return -1
	End If	
	
	Return 1			
Catch ( oleruntimeerror e2)
	messagebox('Error 3','Failed to open the Email.' + String(e2.line) + '~r~n' + e2.text)
	iole_word.Quit(0)
	iole_word.DisconnectObject( )
	destroy iole_word	
	Return -1
End Try		

Return 0
end function

public function string of_eml2html (long al_email_id, string as_eml_file);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3.of_eml2html()
// $<arguments>
//		value	long  	al_email_id		
//		value	string	as_eml_file		
// $<returns> string
// $<description>
// $<description> Email file to HTML format
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_html_dir,ls_html
String ls_bodytext
String ls_doc_name,ls_txt_name
Long ll_msg_num
blob lb_data

If Not isvalid(iole_POP3Mail) Then
	This.of_createobject( )
End If
iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
ll_msg_num = iole_POP3Mail.LoadMessage(as_eml_file,0)
If ll_msg_num  > 0 Then
	If iole_POP3Mail.Messages.Item(ll_msg_num).LoadMessage(as_eml_file,0,2,0) = 0 Then
		iole_message = iole_POP3Mail.Messages.Item(ll_msg_num)
		ls_html_dir = iole_message.HTMLPartsDirectory
		
		If ls_html_dir <> '' Then
			Return ls_html_dir + '\index.htm'
		Else //Plain Text
			ls_txt_name = of_get_email_cachedir() + '\' + This.of_get_Email_name(al_Email_id, 'txt')
			ls_bodytext = iole_message.BodyText 
			lb_data = Blob(ls_bodytext)
			AppeonWriteFile(ls_txt_name,lb_data,Len(lb_data))
			Return ls_txt_name
		End If
	End If
End If

Return ''
end function

public function integer of_save_msg (integer ai_folder_id, integer ai_sub_folder_id, string as_subject, string as_bodydocfile, integer ai_importance, string as_from, string as_to, string as_cc, string as_attachlist[], datetime adt_email_date, integer ai_readed, string as_ctx_id, string as_doc_id, string as_ai_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3Script - of_save_msg ( integer ai_folder_id, integer ai_sub_folder_id, datetime adt_Email_date, string as_subject, string as_bodydocfile, string as_bodystring, integer ai_importance, string as_from, string as_to, string as_cc, string as_attachlist[], inte()
// $<arguments>
//		value	integer 	ai_folder_id    		
//		value	integer 	ai_sub_folder_id		
//		value	datetime	adt_Email_date  		
//		value	string  	as_subject      		
//		value	string  	as_bodydocfile  		
//		value	integer 	ai_importance   		
//		value	string  	as_from         		
//		value	string  	as_to           		
//		value	string  	as_cc           		
//		value	string  	as_attachlist[] 		
//		value	integer 	ai_readed       		
//		value	long    	al_ctx_id       		
//		value	long    	al_doc_id       		
//		value	long    	al_ai_id        		
// $<returns> (none)
// $<description> Save the Parsed MSG information to DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-05-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_attachnamelist,ls_sql_err,ls_attach_filename
Long ll_id,i,ll_attach_id
Blob lblb_MailContent,lblb_attachment
String ls_unit
Long ll_size
DataStore lds_mail_attach

//Save to DB
ids_received_msg.Reset()
ids_received_msg.InsertRow(0)
ids_received_msg.Setitem(1,'user_id',gs_user_id)
ids_received_msg.Setitem(1,'folder_id',ai_folder_id)
ids_received_msg.Setitem(1,'sub_folder_id',ai_folder_id)
ids_received_msg.Setitem(1,'mail_msg_id','Imported MSG')
ids_received_msg.Setitem(1,'mail_date',adt_Email_date)
ids_received_msg.Setitem(1,'mail_subject',as_subject)
ids_received_msg.Setitem(1,'mail_importance',ai_importance)
ids_received_msg.Setitem(1,'mail_from',as_from)
ids_received_msg.Setitem(1,'mail_to',as_to)
ids_received_msg.Setitem(1,'mail_cc',as_cc)
ids_received_msg.Setitem(1,'mail_fromclx',3)
ids_received_msg.Setitem(1,'mail_save_format','doc')
ids_received_msg.Setitem(1,'read_status',ai_readed)
ids_received_msg.Setitem(1,'locked',0)
ids_received_msg.Setitem(1,'deleted',0)
ids_received_msg.Setitem(1,'flag',0)
//ids_received_msg.Setitem(1,'mail_ctx_id',al_ctx_id)
//ids_received_msg.Setitem(1,'mail_doc_id',al_doc_id)
//ids_received_msg.Setitem(1,'mail_action_item_id',al_ai_id)
ids_received_msg.Setitem(1,'ctx_id_list',as_ctx_id)
ids_received_msg.Setitem(1,'doc_id_list',as_doc_id)
ids_received_msg.Setitem(1,'mail_action_item_id',Long(as_ai_id))

//For checkin document in email item
If Pos(as_ctx_id,',') = 0 Then
	ids_received_msg.SetItem(1,'mail_ctx_id',Long(as_ctx_id))
End If
If Pos(as_doc_id,',') = 0 Then
	ids_received_msg.SetItem(1,'mail_doc_id',Long(as_doc_id))
End If	


For i = 1 To UpperBound(as_attachlist[])
	ll_size = FileLength(as_attachlist[i])
	ll_size = inv_cst_filesrv.of_genfilesize(ll_size,ls_unit)
	If ls_attachnamelist = '' Then
		ls_attachnamelist = Mid(as_attachlist[i],LastPos(as_attachlist[i],'\') + 1,Len(as_attachlist[i])) + ' (' +String(ll_size) + ls_unit +  ')' 
	Else
		ls_attachnamelist += '; ' + Mid(as_attachlist[i],LastPos(as_attachlist[i],'\') + 1,Len(as_attachlist[i])) + ' (' +String(ll_size) + ls_unit +  ')' 
	End If
Next	
ids_received_msg.Setitem(1,'mail_attach_name',ls_attachnamelist) 

If ids_received_msg.Update() <> 1 Then 
	ls_sql_err = sqlca.sqlerrtext 
	Messagebox('Error','Failed to save the MSG file to database.' + ls_sql_err)
	ids_received_msg.Reset()
	Return -2
End If

//Update Email File to DB
ll_id = ids_received_msg.GetItemNumber(1,'id')

inv_dm_utils.of_readblob( as_bodydocfile, lblb_MailContent)

//Update Email Word File to DB
If Len(lblb_MailContent) > 0 Then
	UPDATEBLOB em_mail_items SET mail_rfc822 = :lblb_MailContent WHERE id = :ll_id;
	If sqlca.sqlcode <> 0 Then
		Delete From em_mail_items Where id = :ll_id;
		Return -2
	End If	
End If

//Added By Ken.Guo 2010-04-12. Update Attachment to DB
If UpperBound(as_attachlist[]) > 0 Then
	lds_mail_attach = Create DataStore
	lds_mail_attach.DataObject = "d_em_mail_attach"
	lds_mail_attach.SetTransObject(SQLCA)	
	For i = 1 to UpperBound(as_attachlist[])
		If Not FileExists(as_attachlist[i]) Then Continue
		inv_dm_utils.of_readblob( as_attachlist[i], lblb_attachment)
		ls_attach_filename = Mid(as_attachlist[i],LastPos(as_attachlist[i],'\') + 1, Len(as_attachlist[i]))
		
		lds_mail_attach.Reset()
		lds_mail_attach.InsertRow(0)
		lds_mail_attach.SetItem(1,'mail_item_id',ll_id)
		lds_mail_attach.SetItem(1,'attachment_name',ls_attach_filename)
		lds_mail_attach.SetItem(1,'type','a') //a: attachment
		lds_mail_attach.SetItem(1,'last_modify_date',adt_Email_date)
		If lds_mail_attach.Update() = 1 Then
			ll_attach_id = lds_mail_attach.GetItemNumber(1,'id')
			UpdateBlob em_mail_item_attachments Set image_file = :lblb_attachment Where id = :ll_attach_id;
			If SQLCA.sqlcode <> 0 Then
				Delete from em_mail_item_attachments where id = :ll_attach_id;
				lds_mail_attach.Reset()
				Messagebox('Error -3','Failed to save the attachment "'+as_attachlist[i]+'" to Email Sent Items.')
				Continue
			End If
		Else
			lds_mail_attach.Reset()
		End If
	Next	
	Destroy lds_mail_attach
End If

Return 1

end function

public function long of_getunreademailcount (long al_email_folder_id, string as_user_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3.of_getunreademailcount()
// $<arguments>
//		value	long  	al_email_folder_id	
//								1: 'Email Folders' //All
//								2: 'Inbox'
//								3: 'Sent Items'
//								4: 'Drafts'
//								5: 'Favorite Items'
//								6: 'History Items'
//								7: 'Deleted Items' //invalid arguement. do not use 7.
//								8: 'Search Result'		
//		value	string	as_user_id     		
// $<returns> (none)
// $<description>
// $<description> Get unread email count.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-11-04 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_unread_cnt

Choose Case al_email_folder_id
	Case 1 //All
		Select count(1) Into :gl_unread_email_cnt
		From em_mail_items 
		Where em_mail_items.user_id = :as_user_id
		And (em_mail_items.read_status = 0 or em_mail_items.read_status is null);
	Case 7 //Delete item
		Select count(1) Into :gl_unread_email_cnt
		From em_mail_items 
		Where em_mail_items.user_id = :as_user_id
		And (em_mail_items.read_status = 0 or em_mail_items.read_status is null)
		And (em_mail_items.folder_id = :al_email_folder_id );			
	Case Else
		Select count(1) Into :gl_unread_email_cnt
		From em_mail_items 
		Where em_mail_items.user_id = :as_user_id
		And (em_mail_items.read_status = 0 or em_mail_items.read_status is null)
		And (em_mail_items.folder_id = :al_email_folder_id and em_mail_items.deleted = 0 );	
End Choose

Return gl_unread_email_cnt

end function

public function string of_get_attachname (oleobject aole_attachment);String ls_ContentType
String ls_filename = 'noname'

If aole_attachment.filename <> 'unknown.unk' Then 
	Return aole_attachment.filename
End If

ls_ContentType = aole_attachment.ContentSubType
Choose Case ls_ContentType 
	Case 'rfc822'
		ls_filename = 'noname.eml'
	Case ''
		ls_filename = ''
	Case ''
		ls_filename = ''
End Choose

Return ls_filename
end function

public function integer of_setpop3info (string as_pop3server, integer al_pop3port, integer ai_pop3ssl);if IsNull(as_POP3Server) then
	return -14
end if

if IsNull(al_POP3Port) then
	return -15
end if

iole_POP3Mail.MailServer = as_POP3Server
iole_POP3Mail.MailPort = al_POP3Port

iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
iole_POP3Mail.PreferredBodyFormat = 1 //0:plain text; 1:HTML
iole_POP3Mail.OptionFlags = 1
iole_POP3Mail.TimeOut = 30

//Added By Ken 09/22/2011. 
If ai_pop3ssl = 1 Then
	iole_POP3Mail.SSL = iole_POP3SSL
End If

Integer li_log
li_log = Integer(gnv_data.of_getItem("em_user_config", "Email_log", False))
If li_log = 2 Then
	iole_POP3Mail.LogFile = gs_dir_path + gs_DefDirName + '\Email.Log'
End If

Return 1

end function

public function integer of_setattachment (long al_emailid, long al_doc_id, string as_eml_file, ref string as_attach_list, ref u_lv_attachment alv_attach);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_easymail_pop3of_setattachment()
// $<arguments>
//		value    	string  	as_eml_file		
//		reference	u_lv_attachment	alv_attach 		
// $<returns> integer
// $<description> Set attachment list to ListView control.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_msg_num
Long ll_size
Long i
String ls_unit,ls_attachs[],ls_ref_docname,ls_attachname
n_cst_string lnv_string

	
alv_attach.DeleteItems()
alv_attach.of_reset_var()

If as_eml_file <> '' Then
	//EML's Attachments
	If Not isvalid(iole_POP3Mail) Then
		This.of_createobject( )
	End If
	iole_POP3Mail.TempDirectory = of_get_Email_tempdir()
	ll_msg_num = iole_POP3Mail.LoadMessage(as_eml_file,0)
	If ll_msg_num  > 0 Then
		If iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Count > 0 Then
			ls_ref_docname = of_get_ref_docname(al_doc_id)
			For i = 1 To iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Count
				ls_attachname = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).filename
				If ls_attachname = 'unknown.unk' Then 
					ls_attachname = of_get_attachname(iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i))
					//Continue
				End If
				ll_size = iole_POP3Mail.Messages.Item(ll_msg_num).Attachments.Item(i).size
				ll_size = inv_cst_filesrv.of_genfilesize(ll_size,ls_unit)
				If ls_ref_docname <> '' and Trim(Lower(lnv_string.of_globalreplace( ls_ref_docname, '.', ' ') )) = Trim(Lower( lnv_string.of_globalreplace( ls_attachname, '.', ' ') )) Then
					alv_attach.additem( ls_attachname + ' (' +String(ll_size) + ls_unit +  ')' , 2)
				Else
					alv_attach.additem( ls_attachname + ' (' +String(ll_size) + ls_unit +  ')' , 1)
				End If
				as_attach_list += ls_attachname + ' (' +String(ll_size) + ls_unit +  ')' + '; ' 
			Next
		End If
		alv_attach.of_set_var(al_Emailid,as_eml_file,'eml')
	End If
Else
	//Sent Item's Attachments.
	If Trim(as_attach_list) = '' Then Return 0
	lnv_string.of_parsetoarray( as_attach_list, ';', ls_attachs[])
	If UpperBound(ls_attachs[]) > 0 Then
		ls_ref_docname = of_get_ref_docname(al_doc_id)
	End If
	For i = 1 To UpperBound(ls_attachs[])
		ls_attachname = Mid(ls_attachs[i],1,LastPos(ls_attachs[i],'(') - 1)
		If ls_ref_docname <> '' and Trim(Lower(lnv_string.of_globalreplace( ls_ref_docname, '.', ' ') )) = Trim(Lower(lnv_string.of_globalreplace( ls_attachname, '.', ' ') )) Then
			alv_attach.additem( ls_attachs[i], 2)
		Else
			alv_attach.additem( ls_attachs[i], 1)
		End If
	Next
	alv_attach.of_set_var(al_Emailid,'','doc')
	
End If

Return 1
end function

on n_cst_easymail_pop3.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_easymail_pop3.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if IsValid(iole_pop3Mail) then
	iole_pop3Mail.Disconnect()
	iole_pop3Mail.DisconnectObject()
	Destroy iole_pop3Mail
end if

//Added By Ken 09/22/2011. 
if IsValid(iole_POP3SSL) then
	iole_POP3SSL.DisconnectObject()
	Destroy iole_POP3SSL
end if


If isvalid(ids_download_msg_id) Then Destroy ids_download_msg_id
If isvalid(ids_new_msg_id) Then Destroy ids_new_msg_id
If isvalid(inv_cst_filesrv) Then Destroy inv_cst_filesrv	
If isvalid(ids_mail_attach) Then Destroy ids_mail_attach

If Isvalid(iole_word) Then
	iole_word.Quit(0)
	iole_word.DisconnectObject( )
	Destroy iole_word	
End If
end event

event constructor;ids_download_msg_id = Create DataStore
ids_download_msg_id.DataObject = 'd_em_msg_id_list'

ids_new_msg_id = Create DataStore
ids_new_msg_id.DataObject = 'd_em_msg_id_list'

ids_received_msg = Create n_ds
ids_received_msg.DataObject = 'd_em_items'
ids_received_msg.SetTransObject(SQLCA)

inv_cst_filesrv = Create n_cst_filesrv

ids_mail_attach = Create DataStore
ids_mail_attach.Dataobject = 'd_em_mail_attach'
ids_mail_attach.SetTransobject(SQLCA)

This.of_set_status(This.IS_COMPLETE )
end event

