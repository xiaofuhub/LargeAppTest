$PBExportHeader$n_cst_email_checkin.sru
forward
global type n_cst_email_checkin from nonvisualobject
end type
end forward

global type n_cst_email_checkin from nonvisualobject
end type
global n_cst_email_checkin n_cst_email_checkin

type variables
n_ds ids_need_checkin_doc_list

end variables

forward prototypes
public function integer of_send_email ()
public function string of_gen_email_content (long al_row)
public function integer of_send_email (string as_mail_sender, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_subject, u_email_edit aole_word, string as_attachment, boolean ab_autosign)
end prototypes

public function integer of_send_email ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_email_checkinof_send_email()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Send Email to Checkin document.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_cnt
String ls_sender,ls_mail_content
String ls_mail_to,ls_subject
Integer li_ret 
String ls_doc_name
Long ll_ctx_id


ll_cnt = ids_need_checkin_doc_list.Retrieve()
If ll_cnt <= 0 Then Return 1

Select top 1 set_addresser into :ls_sender from icred_settings;
if IsNull(ls_sender) or Trim(ls_sender) = "" then
	ls_sender = gs_user_id
end if

Openwithparm( w_wait, "Start Email notification to checkin document, please wait..." )
w_wait.hpb_1.MaxPosition = ll_cnt 		
w_wait.hpb_1.Position = 0
w_wait.hpb_1.SetStep = 1
Open(w_email_edit)
w_email_edit.ole_word.of_open('',false)
For i = 1 to ll_cnt
	IF IsValid(w_wait) THEN w_wait.hpb_1.StepIt()
	ls_mail_content = This.of_gen_email_content(i)
	ls_mail_to = ids_need_checkin_doc_list.GetItemString(i,'sender_email')
	ls_doc_name = ids_need_checkin_doc_list.GetItemString(i,'file_name')
	ll_ctx_id = ids_need_checkin_doc_list.GetItemNumber(i,'ctx_id')
	ls_subject = 'The document "'+ls_doc_name+'" of Contract '+String(ll_ctx_id)+' requires your attention.'
	//li_ret = lnv_email_smtp.of_sendtext( ls_sender,ls_mail_to, '', '', ls_subject,ls_mail_content, '')
	li_ret = of_send_email( ls_sender,ls_mail_to, '', '', ls_subject,w_email_edit.ole_word , '',false)
	if li_ret = 0 then
		ids_need_checkin_doc_list.SetItem(i,'replied_email',1)
	end if
Next
IF IsValid(w_wait) THEN Close(w_wait)
If Isvalid(w_email_edit) Then Close(w_email_edit)

If ids_need_checkin_doc_list.modifiedcount( ) > 0 Then
	gnv_appeondb.of_autocommitrollback( )
	If ids_need_checkin_doc_list.Update() = 1 Then
		Commit;
		Return 1
	Else
		Rollback;
		Return -1
	End If
End If

Return 1
end function

public function string of_gen_email_content (long al_row);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_email_checkinof_gen_email_content()
// $<arguments>
//		long	al_row		
// $<returns> string
// $<description>
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////


//Use Default Text Email Content.
String ls_mail_content,ls_url,ls_cache
Long ll_begin
Long ll_ctx_id
ll_ctx_id = ids_need_checkin_doc_list.GetItemNumber(al_row,'ctx_id')

ls_mail_content = &
'The following document has been uploaded by the external user, please click the following URL to check it in.' + &
'~r~n ' + &
'~r~n Document Name: ' + ids_need_checkin_doc_list.GetItemString(al_row,'file_name') + &
'~r~n Contract ID: ' + String(ll_ctx_id) + &
'~r~n Contract Company: ' + ids_need_checkin_doc_list.GetItemString(al_row,'company') + &
'~r~n Last Upload Time: ' + String(ids_need_checkin_doc_list.GetItemDateTime(al_row,'upload_time'),'MM/DD/YYYY HH:MM:SS') + &
'~r~n ' + &
'~r~n ' 

oleobject lole_doc
lole_doc = w_email_edit.ole_word.Object.ActiveDocument
lole_doc.Content.Select()
lole_doc.ActiveWindow.Selection.Text = ls_mail_content

ls_url = ids_need_checkin_doc_list.GetItemString(al_row,'ctx_link_name')
ll_begin = lole_doc.ActiveWindow.Selection.End
lole_doc.Range(ll_begin - 1, ll_begin).Select()	
lole_doc.ActiveWindow.Selection.Text = "Use the following URL to check in:~r~n "
ll_begin = lole_doc.ActiveWindow.Selection.End
lole_doc.Range(ll_begin - 1, ll_begin).Select()		
lole_doc.Hyperlinks.Add(lole_doc.ActiveWindow.Selection.Range,ls_url)


Return ls_mail_content
end function

public function integer of_send_email (string as_mail_sender, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_subject, u_email_edit aole_word, string as_attachment, boolean ab_autosign);Integer 	li_ret
n_cst_easymail_smtp lnv_email_smtp

ab_autosign = False

if lnv_email_smtp.of_CreateObject() = -1 then
	Return -1
end if
li_ret = lnv_email_smtp.of_sendhtml( as_mail_sender,as_mail_to, as_mail_cc, as_mail_bcc, as_subject,aole_word , '',ab_autosign)

Return li_ret
end function

on n_cst_email_checkin.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_email_checkin.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_need_checkin_doc_list = Create n_ds
ids_need_checkin_doc_list.Dataobject = 'd_need_checkin_doc_list'
ids_need_checkin_doc_list.SetTransObject(SQLCA)

end event

event destructor;If Isvalid(ids_need_checkin_doc_list) Then Destroy ids_need_checkin_doc_list
end event

