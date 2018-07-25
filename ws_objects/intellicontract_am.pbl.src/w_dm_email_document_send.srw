$PBExportHeader$w_dm_email_document_send.srw
forward
global type w_dm_email_document_send from w_email_subject
end type
type sle_subject from singlelineedit within w_dm_email_document_send
end type
type st_3 from statictext within w_dm_email_document_send
end type
type sle_sendto from singlelineedit within w_dm_email_document_send
end type
type sle_attach from singlelineedit within w_dm_email_document_send
end type
type cb_ic from commandbutton within w_dm_email_document_send
end type
type cb_outlook from commandbutton within w_dm_email_document_send
end type
type st_5 from statictext within w_dm_email_document_send
end type
type rb_file from radiobutton within w_dm_email_document_send
end type
type rb_library from radiobutton within w_dm_email_document_send
end type
type rb_document from radiobutton within w_dm_email_document_send
end type
type cbx_1 from checkbox within w_dm_email_document_send
end type
type st_4 from statictext within w_dm_email_document_send
end type
type st_6 from statictext within w_dm_email_document_send
end type
type st_7 from statictext within w_dm_email_document_send
end type
type ddlb_item from dropdownlistbox within w_dm_email_document_send
end type
type gb_1 from groupbox within w_dm_email_document_send
end type
type dw_1 from u_dw within w_dm_email_document_send
end type
type cb_clear_attach from commandbutton within w_dm_email_document_send
end type
type st_file from statictext within w_dm_email_document_send
end type
type st_document from statictext within w_dm_email_document_send
end type
type st_library from statictext within w_dm_email_document_send
end type
type pb_file from picturebutton within w_dm_email_document_send
end type
type pb_library from picturebutton within w_dm_email_document_send
end type
type pb_document from picturebutton within w_dm_email_document_send
end type
type rb_ic from radiobutton within w_dm_email_document_send
end type
type rb_oc from radiobutton within w_dm_email_document_send
end type
type sle_sendbcc from singlelineedit within w_dm_email_document_send
end type
type cb_sendto from commandbutton within w_dm_email_document_send
end type
type cb_sendcc from commandbutton within w_dm_email_document_send
end type
type cb_sendbcc from commandbutton within w_dm_email_document_send
end type
type cb_resize from commandbutton within w_dm_email_document_send
end type
type cbx_clean from checkbox within w_dm_email_document_send
end type
type cb_paste_link from commandbutton within w_dm_email_document_send
end type
type st_sending_status from statictext within w_dm_email_document_send
end type
type ole_message from u_email_edit within w_dm_email_document_send
end type
type gb_2 from groupbox within w_dm_email_document_send
end type
type gb_3 from groupbox within w_dm_email_document_send
end type
type gb_4 from groupbox within w_dm_email_document_send
end type
end forward

global type w_dm_email_document_send from w_email_subject
integer x = 0
integer y = 0
integer width = 4027
integer height = 2820
boolean center = true
event ue_nclbuttondblclk pbm_nclbuttondblclk
event type integer ue_send ( )
event type integer ue_send_ctxs ( )
event postopen ( )
sle_subject sle_subject
st_3 st_3
sle_sendto sle_sendto
sle_attach sle_attach
cb_ic cb_ic
cb_outlook cb_outlook
st_5 st_5
rb_file rb_file
rb_library rb_library
rb_document rb_document
cbx_1 cbx_1
st_4 st_4
st_6 st_6
st_7 st_7
ddlb_item ddlb_item
gb_1 gb_1
dw_1 dw_1
cb_clear_attach cb_clear_attach
st_file st_file
st_document st_document
st_library st_library
pb_file pb_file
pb_library pb_library
pb_document pb_document
rb_ic rb_ic
rb_oc rb_oc
sle_sendbcc sle_sendbcc
cb_sendto cb_sendto
cb_sendcc cb_sendcc
cb_sendbcc cb_sendbcc
cb_resize cb_resize
cbx_clean cbx_clean
cb_paste_link cb_paste_link
st_sending_status st_sending_status
ole_message ole_message
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_dm_email_document_send w_dm_email_document_send

type variables
String is_attach_file
String is_path

String is_fullname[]
String is_filename[]
String is_fullname_clean[]  //Ken.Guo 2009-03-12	
String is_filename_clean[]  //Ken.Guo 2009-03-12
String is_fullname_org[]  //Ken.Guo 2009-03-12	
String is_filename_org[]  //Ken.Guo 2009-03-12
String is_fullname_convert[]
String is_filename_convert[]
String is_fullname_convert_clean[] //Ken.Guo 2009-03-12
String is_filename_convert_clean[] //Ken.Guo 2009-03-12
String is_fullname_convert_org[] //Ken.Guo 2009-03-12
String is_filename_convert_org[] //Ken.Guo 2009-03-12

Long il_doc_id[]
Long il_ctx_id,il_docid
Boolean ib_cc

str_add_doc istr_add_doc
str_ctx_email istr_ctx_email

datawindow idw_send //the datawindow to send email of contract detail

//----Begin Added by alfee 05.24.2007 -------------------------
Long il_exportid_last //keep last export id for email template
Long il_ctxid_last //keep exported contract id for email template
DataStore ids_export  
//----End Added ----------------------------------------------

string is_mail_signature //added by alfee 06.08.2007

long		il_export_id,il_Flag

n_cst_resize		inv_resize
n_cst_image_functions_cp inv_image_cp //Alfee 11.21.2008

n_cst_filesrv 	in_FileSrv				//Added by Scofield on 2009-02-20
DataStore		ids_EmailAttach		//Added by Scofield on 2009-02-20

String is_email_file_path //Added by Ken.Guo on 2009-03-13

String is_web_link 		//Added by Ken.Guo on 2009-03-26

Long il_email_id[] //Added by Ken.Guo on 2009-04-21

n_ds ids_ctx_default_contacts_email   //Added By Ken.Guo 2009-05-13

String is_temp_pdf[] //Added By Ken.Guo 2009-05-13
n_cst_easymail_pop3 inv_pop3

Boolean ib_attached_from_batch = False //Added By Ken.Guo 2010-07-05.
String is_attach_file_from_batch //Full name for email
n_cst_dm_utils inv_dm_utils //Added By Ken.Guo 2010-07-07.
String is_ctx_list,is_doc_list //Added By Ken.Guo 2010-10-26.
//Long il_ctx_id_list[]
Long il_email_template_id //Added By Ken.Guo 2010-11-16.

n_cst_string inv_string //Added By Ken.Guo 2011-03-02.


end variables

forward prototypes
public function integer of_save_attachment ()
public function string of_replace_export (long al_export_id, string as_message)
public function integer of_get_emailinfo (integer ai_mail_id, ref str_dm_email astr_email)
public subroutine of_convert_pdf (boolean ab_convert)
public function integer of_create_actionitem (string as_action_item)
public subroutine of_add_attachment (string as_from)
public subroutine of_seloccontacts ()
public subroutine of_seliccontacts (integer ai_sendtype)
public function integer of_get_emailmessage (long al_email_id, ref blob ablb_msgdata)
public function integer of_setresize (boolean ab_switch)
public subroutine of_convert_pdf_bk (boolean ab_convert)
public function boolean of_is_image2pdf (string as_doc_ext)
public function integer of_set_security ()
public subroutine of_getemailattachment (long al_email_id, long al_attach_id, ref blob ablb_attachment)
public subroutine of_delete_history_files ()
public subroutine of_generate_cleanfile (string as_fullname, string as_filename, string as_from)
public subroutine of_check_same_filename (ref string as_filename, ref string as_fullname, string as_from, boolean ab_copy)
public subroutine of_gen_attachment_name ()
public subroutine of_create_clean_version ()
public function integer of_gen_web_link ()
public subroutine of_retrieve_emails ()
public function integer of_merge_data (long al_ctx_id, long al_export_id, long al_ctx_id_list[])
public function integer of_create_actionitem (string as_sendto, string as_action_item)
public function long of_get_file_size (string as_filename, ref string as_unit)
public subroutine of_delete_temp_pdf ()
public function string of_get_file_type_des (string as_file_ext)
public function integer of_save_clause_attachment ()
public function integer of_open_email ()
public function integer of_get_email_attach (long al_mail_id, string as_mail_emlname, string as_mail_format, integer ai_type)
public function string of_gen_attachfilename_from_batch (boolean ab_pdf)
public function integer of_gen_attachfile_from_batch (long al_index)
public function integer of_create_actionitem (string as_sendto, string as_action_item, long al_doc_id)
public function integer of_add_attachment (string as_from, string as_fullname[])
public function boolean of_check_data ()
end prototypes

event ue_nclbuttondblclk;if This.Windowstate = Maximized! then
	This.Windowstate = Normal!
else
	This.Windowstate = Maximized!
end if

return 1

end event

event type integer ue_send();long 		ll_Return,li_send_result = 0

n_cst_easymail_smtp 	lnv_Mail
n_cst_dm_utils lnv_dm_utils //Alfee 11.28.2007

IF IsNull(sle_sendto.Text) OR Trim(sle_sendto.Text) = "" THEN
	MessageBox("Email Address required", "Email Address cannot be empty." )
	sle_sendto.SetFocus()
	Return -1
END IF

if lnv_Mail.of_CreateObject() = -1 then
	//Added by Nova.zhang on 2008-11-07
	f_show_message('create Email object','','','','')
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	Return -1
end if

//Added By Ken.Guo 2010-10-26.
gstr_email_info.ss_ctx_id_list = is_ctx_list
gstr_email_info.ss_doc_id_list = is_doc_list
//---------Begin Added by (Appeon)Harry 02.19.2014 for Bug # 3887--------
if gb_contract_module then
	lnv_Mail.of_set_combine_status(false) 
end if
//---------End Added ------------------------------------------------------

ll_Return = lnv_Mail.of_SendHtml(gs_user_id, sle_sendto.text, sle_1.text, sle_sendbcc.text,sle_subject.text, ole_message, is_attach_file,false,il_ctx_id,il_docid,0)
//END---Modify by Evan 2008-03-24

gstr_email_info.ss_ctx_id_list = ''
gstr_email_info.ss_doc_id_list = ''

if ll_Return <> 0 then
	//Added by Nova.zhang on 2008-11-07
	//---------Begin Modified by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
	//f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		If lnv_Mail.is_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If
	//---------End Modfiied ------------------------------------------------------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	lnv_Mail.of_DeleteObject()
	li_send_result = -1
	//return -1
end if

//Added By Ken.Guo 2010-11-15. Email Audit  
String ls_errtext,ls_attachfilename,ls_to,ls_cc,ls_bcc,ls_subject,ls_email_type,ls_notes,ls_computer_info
n_cst_string lnv_string
If ll_Return <> 0 then 
	ls_errtext = gnv_message.of_get_error_message( ll_Return)
End If
ls_attachfilename = lnv_string.of_get_file_name( is_attach_file, ',') 
ls_to = sle_sendto.text
ls_cc = sle_1.text
ls_bcc = sle_sendbcc.text
ls_subject = sle_subject.text
If Len(istr_ctx_email.as_mail_reply_mode) > 0 Then
	ls_email_type = WordCap(istr_ctx_email.as_mail_reply_mode) + ' Email'
Else
	ls_email_type = 'New Email'
End If
If il_email_template_id = 0 Then Setnull(il_email_template_id)
If Pos(is_ctx_list,',') > 0 Then
	ls_notes = lnv_Mail.of_get_company_name(is_ctx_list)
	If ls_notes <> '' Then ls_notes = 'Company: ' + ls_notes
End If
ls_computer_info = lnv_Mail.of_get_compute_info( )

Insert Into em_mail_audit
(user_id,mail_from,mail_to,mail_cc,mail_bcc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,notes,compute_info)
Values 
(:gs_user_id,:gs_user_id,:ls_to,:ls_cc,:ls_bcc,:ls_subject,getdate(),:ls_attachfilename,:il_email_template_id,:is_ctx_list,:is_doc_list,'',null,:ls_email_type,'',:li_send_result,:ls_errtext,:ls_notes,:ls_computer_info);


if ll_Return <> 0 then Return -1

lnv_Mail.of_DeleteObject()

of_delete_temp_pdf()   //Added By Ken.Guo 2009-05-20.

//Create action item
IF of_create_actionitem(ddlb_item.Text) < 0 THEN
	//MessageBox("Error","Failed to create action item!",StopSign!)	//Alfee 01.10.2008
	MessageBox("Error","Failed to create action item due to ~r~n" + SQLCA.SqlErrText,StopSign!)
	return -1
END IF

If istr_ctx_email.action_type <> 'CheckOut' Then //Added if condition by Ken.Guo 2009-04-13
	//Add audit trail in document manager - Alfee 11.28.2007
	lnv_dm_utils.of_add_audit_trail(il_doc_id)
End If

CloseWithReturn(This, 1)
Return 1

end event

event type integer ue_send_ctxs();//////////////////////////////////////////////////////////////////////
// $<event>ue_send_ctxsw_dm_email_document_send()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Send email with default person by multi CTXs.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Boolean lb_new_export,lb_exported = False
Long 	ll_Rtn,i,j
Blob lb_message,lb_dw_data
Long ll_find_row,ll_row[],ll_null[]
String ls_email,ls_email_all
Datawindow ldw_email
n_cst_easymail_smtp 	lnv_Mail
n_cst_word_utility lnv_word 
string ls_subject,ls_attach_file
String ls_errtext,ls_attachfilename,ls_to,ls_cc,ls_bcc,ls_email_type,ls_notes,ls_computer_info
n_cst_string lnv_cst_string
integer li_send_result = 0


If Left(istr_ctx_email.doc_from,4) <> 'CTXS' Then Return -1

if lnv_Mail.of_CreateObject() = -1 then
	f_show_message('create Email object','','','','')
	Return -1
end if

lnv_word = Create n_cst_word_utility

ole_Message.of_getblob(lb_message) //Orginal message. Unrepaced.

//Show processing window.
If isvalid(w_ctxs_email_send_result) Then Close(w_ctxs_email_send_result) //Current w_ctxs_email_send_result's Parent is This.
Open(w_ctxs_email_send_result,gw_contract) //Open w_ctxs_email_send_result with Parent--gw_contract.
//ids_ctx_default_contacts_email.GetFullState(lb_dw_data)
SetPointer(HourGlass!)
w_ctxs_email_send_result.dw_1.retrieve(istr_ctx_email.ctx_id_list[])
ldw_email = w_ctxs_email_send_result.dw_1
//ldw_email.SetFullstate(lb_dw_data)
w_ctxs_email_send_result.cb_close.enabled = False

//Sort Array
n_cst_string_appeon lnv_string
lnv_string.of_sortarray(istr_ctx_email.ctx_id_list[],'A')
//---------Begin Added by (Appeon)Harry 02.19.2014 for Bug # 3887--------
if gb_contract_module then
	lnv_Mail.of_set_combine_status(false) 
end if
//---------End Added ------------------------------------------------------

//Loop with each ctx_id 
For i = 1 To UpperBound(istr_ctx_email.ctx_id_list[])
	SetPointer(HourGlass!)
	//Restore Message
	st_sending_status.text = 'Sending... ' + String(i) + '/' + String(UpperBound(istr_ctx_email.ctx_id_list[]))
	
	ole_Message.setredraw(False)
	If i > 1 Then
		ole_Message.of_close( )
	End If
	ole_Message.of_open(lb_message)
	ll_row[] = ll_null[]
	ls_email = ''
	ls_email_all = ''
	
	il_ctx_id = istr_ctx_email.ctx_id_list[i]
	
	//Get Default Email Address.
	ll_find_row = ldw_email.Find('ctx_id = ' + String(il_ctx_id),1,ldw_email.rowcount())
	IF ll_find_row > 0 Then
		ll_row[UpperBound(ll_row[]) + 1 ] = ll_find_row
		ls_email = ldw_email.GetItemString(ll_find_row,'email_address')
		If Isnull(ls_email) Then ls_email = ''
		ls_email_all = ls_email 
		Do while (ll_find_row > 0) and (ll_find_row <> ldw_email.RowCount() ) 
			ll_find_row = ldw_email.Find('ctx_id = ' + String(il_ctx_id),ll_find_row + 1,ldw_email.rowcount())
			If ll_find_row > 0 Then
				ll_row[UpperBound(ll_row[]) + 1 ] = ll_find_row
				ls_email = ldw_email.GetItemString(ll_find_row,'email_address')
				If ls_email <> '' and Not isnull(ls_email) Then
					If ls_email_all = '' Then
						ls_email_all = ls_email 
					Else
						ls_email_all = ls_email_all + ';' + ls_email
					End If
				End If
			End If
		loop
	End If
	
	If ls_email_all = '' or Isnull(ls_email_all) Then
		//Write Result if no email address.
		For j = 1 To UpperBound(ll_row[])
			ldw_email.SetItem(ll_row[j],'sent_result','Failure. No default email address.')
		Next
		Continue
	End If
	
	//Add ls_subject -- jervis 09.09.2009
	ls_subject = sle_subject.text
	
	//Merge Data
	If il_export_id > 0 Then //Added By Ken.Guo 2011-01-24.Fixed bug. add if statement, otherwise it will return -1. 
		If Not lb_exported Then 
			//ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument,il_ctx_id, il_export_id, ids_export, True,istr_ctx_email.ctx_id_list[] )
			ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument,ls_subject,il_ctx_id, il_export_id, ids_export, True,istr_ctx_email.ctx_id_list[] )
			lb_exported = True
		Else
			ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument,ls_subject,il_ctx_id, il_export_id, ids_export, False,istr_ctx_email.ctx_id_list[] )
		End If
	End If
	
	//Added By Ken.Guo 2011-01-11.
	If ll_rtn < 0 Then
		ole_Message.setredraw(True)
		IF IsValid(lnv_word) THEN Destroy lnv_word		
		If isvalid(lnv_Mail) Then lnv_Mail.of_DeleteObject()
		Close(w_ctxs_email_send_result)
		Return -1
	End If
	
	ole_Message.setredraw(True)
	
	//Begin - Added By Ken.Guo 2010-07-05.
	If of_gen_attachfile_from_batch(i) < 0 Then 
		For j = 1 To UpperBound(ll_row[])
			ldw_email.SetItem(ll_row[j],'sent_result','Failure. Failed to generate the attachment(s).')
		Next		
		Continue
	End If
	If is_attach_file_from_batch = '' Then
		If is_attach_file = '' Then
			ls_attach_file = ''
		Else
			ls_attach_file = is_attach_file
		End If
	Else
		If is_attach_file = '' Then
			ls_attach_file = is_attach_file_from_batch
		Else
			ls_attach_file = is_attach_file_from_batch + ';' + is_attach_file
		End If
	End If
	//End - Added By Ken.Guo 2010-07-05.

	gstr_email_info.ss_ctx_id_list = String(il_ctx_id)
	gstr_email_info.ss_doc_id_list = ''

	//Send email
	//ll_rtn = lnv_Mail.of_SendHtml(gs_user_id, ls_email_all, sle_1.text, sle_sendbcc.text,sle_subject, ole_message, is_attach_file,false,il_ctx_id,0,0)
	ll_rtn = lnv_Mail.of_SendHtml(gs_user_id, ls_email_all, sle_1.text, sle_sendbcc.text,ls_subject, ole_message, ls_attach_file,false,il_ctx_id,0,0)

	gstr_email_info.ss_ctx_id_list = ''
	gstr_email_info.ss_doc_id_list = ''

	//Write send log
	If ll_rtn <> 0 Then
		For j = 1 To UpperBound(ll_row[])
			ldw_email.SetItem(ll_row[j],'sent_result','Failure. Error code is ' + String(ll_rtn) + '.')
		Next
	Else
		For j = 1 To UpperBound(ll_row[])
			ldw_email.SetItem(ll_row[j],'sent_result','Success.')
		Next
	End If


	//Added By Ken.Guo 2010-11-15. Email Audit  
	If ll_rtn <> 0 then 
		ls_errtext = gnv_message.of_get_error_message( ll_rtn)
		li_send_result = -1
	Else
		ls_errtext = ''
		li_send_result = 0
	End If
	ls_attachfilename = lnv_cst_string.of_get_file_name( ls_attach_file, ',') 
	//ls_to = sle_sendto.text
	ls_cc = sle_1.text
	ls_bcc = sle_sendbcc.text
	//ls_subject = sle_subject.text
	If Len(istr_ctx_email.as_mail_reply_mode) > 0 Then
		ls_email_type = WordCap(istr_ctx_email.as_mail_reply_mode) + ' Email'
	Else
		ls_email_type = 'New Email'
	End If
	If il_email_template_id = 0 Then Setnull(il_email_template_id)
	ls_computer_info = lnv_Mail.of_get_compute_info( )
	
	Insert Into em_mail_audit
	(user_id,mail_from,mail_to,mail_cc,mail_bcc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,compute_info)
	Values 
	(:gs_user_id,:gs_user_id,:ls_email_all,:ls_cc,:ls_bcc,:ls_subject,getdate(),:ls_attachfilename,:il_email_template_id,:il_ctx_id,'','',null,:ls_email_type,'',:li_send_result,:ls_errtext,:ls_computer_info);

	
	//Create action item
	If UpperBound(istr_ctx_email.doc_id_list[]) >= i Then
		of_create_actionitem(ls_email_all,ddlb_item.Text,istr_ctx_email.doc_id_list[i])
	Else
		of_create_actionitem(ls_email_all,ddlb_item.Text,0)
	End If
	
Next

of_delete_temp_pdf()   
ole_Message.setredraw(True)
IF IsValid(lnv_word) THEN Destroy lnv_word
lnv_Mail.of_DeleteObject()
w_ctxs_email_send_result.cb_close.enabled = True
w_ctxs_email_send_result.Show()
CloseWithReturn(This, 1)
Return 1


end event

event postopen();If Upper(istr_ctx_email.doc_from) = 'CTX_SEARCH' and istr_ctx_email.ctx_id  > 0  Then
	If sle_sendto.text = '' Then
		Messagebox('Email','There is no email address associated with the Default to contact.')
	End If
End If



end event

public function integer of_save_attachment ();String ls_attach_type
String ls_filename, ls_path
String ls_SourceFile
String ls_merge_file
Integer li_rtn
Long	 ll_export_id
str_doc_info	lstr_docinfo	//jervis 02.25.2009

n_cst_ovole_utils lnv_word
n_cst_dm_utils lnv_dm_utils
n_cst_filesrvwin32  lnv_filesvr

//ls_path = gs_dir_path + gs_DefDirName + "\Agreement\Manager\" + istr_ctx_email.filename + "." + istr_ctx_email.doc_ext
ls_path = gs_dir_path + gs_DefDirName + "\Agreement\Manager\" + gf_merge_file_name(istr_ctx_email.filename_list[1] ,istr_ctx_email.doc_ext_list[1] ,istr_ctx_email.doc_id_list[1] ,istr_ctx_email.revision_list[1]  ) //Modified by Ken.Guo 2009-04-14
ls_merge_file = gs_dir_path + gs_DefDirName + "\Agreement\" +"_"+ string(istr_ctx_email.doc_id_list[1] ) + "_out.doc"		
istr_ctx_email.fullfilename_list[1]  = ls_path //set full path name
		
//Get attachment document
SetPointer( HourGlass! )
Openwithparm(w_appeon_gifofwait, "Attaching document...")
li_rtn = lnv_dm_utils.of_download_file( istr_ctx_email.doc_id_list[1] , istr_ctx_email.revision_list[1] , ls_path)
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()

//IF Not FileExists( ls_path ) THEN -- Alfee 09.07.2007
IF li_rtn = -1 or Not FileExists( ls_path ) THEN 
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	RETURN -1
End IF

IF lower(istr_ctx_email.doc_ext_list[1]) <> 'doc' Then 
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
	Return 1
END IF


Choose Case Upper(istr_ctx_email.doc_from)
	Case 'DM'
		//---Appeon Beign - by alfee at 03.12.2007-----
		IF NOT IsValid(gw_contract) THEN RETURN -1
		lnv_word = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
		//If not isvalid(lnv_word) then lnv_word = create n_cst_ovole_utils
		//---Appeon End ---------------
	Case 'DM_BROWSE'
		IF NOT IsValid(w_documents_browse) THEN RETURN -1
		lnv_word = w_documents_browse.uo_1.inv_ole_utils_doc
End Choose
		
gnv_appeondb.of_startqueue( )	//jervis 02.25.2009
//Get export id
Select ctx_acp_template.export_id Into :ll_export_id
 	From ctx_am_document,ctx_acp_template
	Where ctx_am_document.doc_id = :istr_ctx_email.doc_id_list[1]
    And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;

//Start code by jervis 02.25.2009
select create_by,create_date,doc_name
into :lstr_docinfo.create_by,:lstr_docinfo.ver_date,:lstr_docinfo.doc_name
from ctx_am_document
where doc_id = :istr_ctx_email.doc_id_list[1] ;
gnv_appeondb.of_commitqueue( )
lstr_docinfo.ver_num = istr_ctx_email.revision_list[1]
//End code by jervis 02.25.2009

//Merge data		
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
Filecopy(ls_path, ls_merge_file , true)
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()		
//lnv_word.of_mergedata_auto(ll_export_id, istr_ctx_email.ctx_id, ls_merge_file, ls_path, true)				
lnv_word.of_mergedata_auto(ll_export_id, istr_ctx_email.ctx_id_list[1], ls_merge_file, ls_path, false,lstr_docinfo)	//jervis 02.25.2009				
FileDelete(ls_merge_file)

//Auto numbering
lnv_word.of_autonumbering(ls_path)

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) 
IF FileExists( ls_path ) THEN
	RETURN 1
ELSE
	RETURN -1
END IF

end function

public function string of_replace_export (long al_export_id, string as_message);//obsolete and commented by Alfee 10.28.2008

//string ls_begin_separator,ls_end_separator,ls_name,ls_value
//long ll_begin,ll_end,ll_ret
//
////datastore lds_export //Commented by alfee 05.24.2007
//pfc_n_cst_ai_export_apb lnv_export
//n_cst_string  lnv_string
//n_cst_ovole_utils lnv_ole_utils_doc	
//
//ls_begin_separator = "$<"
//ls_end_separator = ">$"
//
//if al_export_id > 0 and match(as_message,"\$\<.*\>\$") then
//	//lds_export = create datastore //Commented by alfee 05.24.2007
//	lnv_export = create pfc_n_cst_ai_export_apb	
//	//----Begin Modified by Alfee 05.24.2007---for performance--------	
//	lnv_export.is_called_type = '3' //for email template 
//	if il_exportid_last <> al_export_id or il_ctxid_last <> il_ctx_id then
//		//ll_ret = lnv_export.of_get_export_data(al_export_id,il_ctx_id,lds_export)
//		ll_ret = lnv_export.of_get_export_data(al_export_id,il_ctx_id,ids_export)
//		If ll_ret > 0 Then
//			il_exportid_last = al_export_id 
//			il_ctxid_last = il_ctx_id
//			//----Begin added by alfee at 03.23.2007-------
//			If isvalid(gw_contract) Then
//				lnv_ole_utils_doc	= gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
//				If isvalid(lnv_ole_utils_doc) THEN
//					lnv_ole_utils_doc.of_set_expinfo(il_ctx_id,al_export_id,"")		
//				End If
//			end if
//			//-----End added---------------------------------
//		End If
//	else
//		ll_ret = 1			
//	end if
//	//-----End Modified ------------------------------------------------
//	
//	if ll_ret > 0 then
//		//Replace the filed flag for email message
//		ll_begin = pos(as_message,ls_begin_separator,1)
//		do while ll_begin > 0
//			ll_end = pos(as_message,ls_end_separator,ll_begin + 2)			
//			if ll_end > 0 then
//				ls_name = mid(as_message,ll_begin + 2,ll_end - ll_begin - 2)
//			//------- Modified by Alfee 05.08.2007  Fix Bug---
//				//<$Reason>For invalid field(s) existed in email template
//				//-------Begin Modified by Alfee 05.24.2007----------
//				//if IsNumber(lds_export.Describe(ls_name+".x")) then
//				//	ls_value = Trim(lds_export.GetItemString(1,ls_name))
//				if IsNumber(ids_export.Describe(ls_name+".x")) then
//					ls_value = Trim(ids_export.GetItemString(1,ls_name))
//				//-------End Modified -------------------------------					
//					if isnull(ls_value) then ls_value = ""
//					as_message = lnv_string.of_globalreplace( as_message, mid(as_message,ll_begin,ll_end - ll_begin + 2),ls_value)
//					ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))					
//				ELSE
//					ll_begin = pos(as_message,ls_begin_separator, ll_end)
//				END IF
//				//	ls_value = Trim(lds_export.GetItemString(1,ls_name))
//				//	if isnull(ls_value) then ls_value = ""
//				//	as_message = lnv_string.of_globalreplace( as_message, mid(as_message,ll_begin,ll_end - ll_begin + 2),ls_value)	
//			//end if			
//			//ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))
//			end if
//			//-------End Modified----------------------------			
//		loop
//	end if
//	destroy pfc_n_cst_ai_export_apb
//	//destroy lds_export //commented by Alfee 05.24.2007
//end if

return as_message

end function

public function integer of_get_emailinfo (integer ai_mail_id, ref str_dm_email astr_email);Long 		ll_data_length,ll_start
Integer 	li_loops,li_counter
Blob 		lb_data

//Get Email Information
//gnv_appeondb.of_startqueue( )
Select wf_email.email_name,
	wf_email.subject,
	wf_email.attach_name,
	wf_email.email_msg,
	wf_email.export_id,
	Datalength(wf_email.attachment)
	Into :astr_email.name,
	:astr_email.subject,
	:astr_email.attach_name,
	:astr_email.message,
	:il_export_id,
	:ll_data_length
	From wf_email
	Where wf_email.email_id = :ai_mail_id;
	
If appeongetclienttype() = 'PB' And gs_dbtype = 'SQL' And ll_data_length > 0 Then
	If ll_data_length > 8000 Then
		If Mod(ll_data_length,8000) = 0 Then
			li_loops = ll_data_length/8000
		Else
			li_loops = (ll_data_length/8000) + 1
		End If
	Else
		li_loops = 1
	End If
	
	For li_counter = 1 To li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		SelectBlob substring(attachment,:ll_start,8000)
		Into :lb_data
		From wf_email
		Where wf_email.email_id = :ai_mail_id;
		
		astr_email.attach += lb_data
	Next
Else
	SelectBlob attachment
	Into :astr_email.attach
	From wf_email
	Where wf_email.email_id = :ai_mail_id;
End If

return 1

end function

public subroutine of_convert_pdf (boolean ab_convert);Integer 	li_file
Long 		ll_cnt, i, j, ll_pos,ll_Len, ll_cpu
String 	ls_ext, ls_temp, ls_SourceFile, ls_pdf_path,ls_prntrs,ls_DefPrinter
Boolean  lb_doc = FALSE, lb_img = FALSE //alfee 11.21.2008
boolean  lb_msg = true
Integer k, li_ret
Integer li_type //1: org, 2: clean


Oleobject lole_word
n_cst_filesrvwin32 lnv_filesvr

SetPointer(HourGlass!)

IF NOT ab_convert THEN Return //Added By Ken.Guo 2009-04-22

//If cbx_clean is checked, need convert org and clean files.
For k = 1 To 2
	SetPointer(HourGlass!)
	If k = 1 Then
		is_filename[] = is_filename_org[]
		is_fullname[] = is_fullname_org[]
		li_type = 1
	Else //k = 2
		If cbx_clean.checked Then
			is_filename[] = is_filename_clean[]
			is_fullname[] = is_fullname_clean[]
			li_type = 2
		Else
			Exit			
		End If
	End If
	
	ll_cnt = UpperBound(is_fullname)
	IF ll_cnt < 1 THEN Continue
	
//	//Un-convert to PDF, restore attachment field and variable 
//	IF NOT ab_convert THEN
//		is_attach_file = ""
//		FOR i = 1 TO ll_cnt
//			//Set attchment field and variable
//			IF i = 1 THEN 
//				sle_attach.text = is_filename[i]
//				is_attach_file = is_fullname[i]
//			ELSE
//				sle_attach.text += "," + is_filename[i]
//				is_attach_file += "," + is_fullname[i]			
//			END IF
//		NEXT
//		Destroy lole_word
//		Destroy lnv_filesvr		
//		RETURN
//	END IF
	
	//---------Begin Added by Alfee 03.25.2008----------------------------
	lb_doc = False
	lb_img = False
	FOR i = 1 to ll_cnt		
		IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
		ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
		//IF lower(ls_ext) = 'doc' THEN EXIT
		IF lower(ls_ext) = 'doc' THEN lb_doc = TRUE //alfee 11.21.2008
		IF of_is_image2pdf(ls_ext) THEN lb_img = TRUE //alfee 11.21.2008
	NEXT
	//IF lower(ls_ext) <> 'doc' THEN
	IF NOT lb_doc AND NOT lb_img THEN //alfee 11.21.2008
		If li_type = 2 Then Continue //Added By Ken.Guo 2009-04-22
		cbx_1.checked = False	
		Destroy lole_word
		Destroy lnv_filesvr			
		MessageBox("Convert to PDF","The documents are not supported to be saved as a PDF format!")	
		RETURN
	END IF
	//----------End Added ------------------------------------------------
	
	SetPointer(HourGlass!) //
	
	//---Appeon Begin by alfee 04.11.2007-------
	IF lb_doc THEN // alfee 11.21.2008
		//Check PDF Printer for Word dcoument
		if f_PrinterSetup(2) >= 2 then 
			cbx_1.checked = False
			return	//Added by Scofield on 2007-11-09
		end If
		ls_prntrs = PrintGetPrinters ( )
		//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
		//IF NOT Pos(lower(ls_prntrs),lower("Contract Logix PDF Writer")) > 0 THEN
		IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
			cbx_1.Checked = FALSE
			cbx_1.Enabled = FALSE
			//MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")
			MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
			RETURN
		END IF
		
		//Convert to PDF, get & convert all Word documents 
		//ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
		ls_SourceFile = gs_temp_pdf
		//ls_SourceFile = gs_dir_path + gs_DefDirName + "\PDFPrinter\temp\SampleOut.PDF" //Alfee 08.21.2007
		//---------End Modfiied ------------------------------------------------------
		
		//---------Begin Added by Alfee 08.22.2007----------------------
		//Delete temporary pdf file 
		IF FileExists(ls_SourceFile) THEN 
			//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
			/*
			IF Not FileDelete(ls_SourceFile) THEN 
				MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
				cbx_1.Checked = FALSE		
				RETURN
			END IF
			*/
			ll_cpu = cpu()
			li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
			do while li_ret = 1
				li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
			loop
			if li_ret = -1 then 
				cbx_1.Checked = FALSE		
				return
			end if
			//---------End Modfiied ------------------------------------------------------				
		END IF
		//----------End Added ----------------------------------------
		
		lole_word = Create oleobject
		IF lole_word.Connecttonewobject("word.application") <> 0 THEN
			Destroy lole_word //Alfee 01.17.2008
			cbx_1.checked = False
			Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
			RETURN
		END IF
		lole_word.Visible = FALSE	
		lole_word.Application.NormalTemplate.Saved = TRUE //moved here - alfee 11.21.2008	
	END IF
	
	TRY
	//lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008	
	If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Converting to PDF...")
	SetPointer(HourGlass!)
	FOR i = 1 to ll_cnt	
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
		IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
		ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2009-01-04 By: Ken.Guo
		//$<Reason> If the file has been converted , need overleap. for performance.
		If li_type = 2 Then //Added by Ken.Guo on 2009-03-13 //for Clean file
			If UpperBound(is_filename_convert_clean[]) >= i Then	
				If Lower(Mid(is_filename_convert_clean[i], LastPos(is_filename_convert_clean[i], ".") + 1)) = 'pdf' Then
					is_filename_convert[i] = is_filename_convert_clean[i]
					is_fullname_convert[i] = is_fullname_convert_clean[i]
					Continue
				End If	
			End If	
		Else
			If UpperBound(is_filename_convert_org[]) >= i Then	
				If Lower(Mid(is_filename_convert_org[i], LastPos(is_filename_convert_org[i], ".") + 1)) = 'pdf' Then
					is_filename_convert[i] = is_filename_convert_org[i]
					is_fullname_convert[i] = is_fullname_convert_org[i]
					Continue
				End If	
			End If			
		End If
		//---------------------------- APPEON END ----------------------------
		SetPointer(HourGlass!)
		IF lower(ls_ext) = 'doc' THEN
			//Delete temporary pdf file  - Alfee 08.22.2007
			IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
			
			//Open Word Document 		
			lole_word.Application.Documents.Open(is_fullname[i],false,true)	
			//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
			gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			//---------End Added ------------------------------------------------------
			gnv_shell.of_delete_recent( is_fullname[i], true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			//IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
				
			//Set pdf Printer and print to PDF format
			Try
				if f_PrinterSetup(2) >= 2 then return		//Added by Scofield on 2007-11-09
				
				ll_Len = 100
				ls_DefPrinter = SPACE(ll_Len)
				GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-12-09
	
				lole_word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
				lole_word.ActiveDocument.Printout( 0 )
				lole_word.ActiveDocument.Close(0)
				
				SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
			Catch(Throwable th1) //added by alfee 04.11.2007
				lole_word.ActiveDocument.Close(0)		
				lole_word.Quit(0)
				lole_word.DisconnectObject( )
				Destroy lole_word
				If isvalid(lnv_filesvr) Then Destroy lnv_filesvr					
				IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
				MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")			
				cbx_1.Checked = FALSE	
				RETURN
			End Try
	
			// Copy to pdf file
			ls_pdf_path = Left(is_fullname[i], Len(is_fullname[i]) - 3) + "pdf"
			If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
			//--------Begin Modified by Alfee 08.29.2007---------------		
			Do 
				//Yield()
				If FileExists(ls_sourcefile) Then 
					li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
				Else
					li_file = -1
				End If
			Loop While li_file = -1
			FileClose(li_file)
			//lnv_filesvr.of_filecopy(ls_sourcefile, ls_pdf_path )
			filecopy(ls_sourcefile, ls_pdf_path ,true) //APB Blob Bug - jervis 03.23.2010
			is_temp_pdf[UpperBound(is_temp_pdf[]) + 1] = ls_pdf_path   //Added By Ken.Guo 2009-05-20.
			/*Do While NOT lnv_filesvr.of_filecopy(ls_sourcefile, ls_pdf_path ) = 1
				Yield()
			Loop*/
			//--------End Modified ---------------------------------------
		ELSEIF of_is_image2pdf(ls_ext) THEN //alfee 11.21.2008
			//Convert image to PDF		
			ls_pdf_path = Left(is_fullname[i], Len(is_fullname[i]) - 3) + "pdf"
			inv_image_cp.of_convert2pdf(is_fullname[i], ls_pdf_path)		
			is_temp_pdf[UpperBound(is_temp_pdf[]) + 1] = ls_pdf_path   //Added By Ken.Guo 2009-05-20.
		END IF	
	NEXT
	
	Catch(Throwable th) //added by alfee 04.11.2007
		If isvalid(lole_word) Then	
			lole_word.Quit(0)
			lole_word.DisconnectObject( )		
			Destroy lole_word
		END IF
		If isvalid(lnv_filesvr) Then Destroy lnv_filesvr						
		IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		RETURN
	End Try
	
	//Quit Word application
	IF isvalid(lole_word) Then	//add if statement - alfee 11.21.2008
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
		Destroy lole_word
	END IF
	If isvalid(lnv_filesvr) Then Destroy lnv_filesvr					
	
	//Update attachment field and variable after convert
	is_attach_file = ""
	FOR i = 1 TO ll_cnt
		//Set attchment array
		is_fullname_convert[i] = is_fullname[i]
		is_filename_convert[i] = is_filename[i]
	  
		IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
		ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
		//IF lower(ls_ext) = 'doc'  THEN
		IF lower(ls_ext) = 'doc' OR of_is_image2pdf(ls_ext) THEN	//alfee 11.21.2008
			ls_temp = Left(is_fullname[i], Len(is_fullname[i]) - 3) + "pdf"
			IF FILEEXISTS(ls_temp) THEN
				is_fullname_convert[i] = ls_temp
				is_filename_convert[i] = Left(is_filename[i], Len(is_filename[i]) - 3) + "pdf"
			END IF
		END IF
	NEXT	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2009-03-13 By: Ken.Guo
	//$<reason> Set to cache
	If li_type = 2 Then
		is_fullname_convert_clean[] = is_fullname_convert[]
		is_filename_convert_clean[] = is_filename_convert[]
	Else
		is_fullname_convert_org[] = is_fullname_convert[]
		is_filename_convert_org[] = is_filename_convert[]
	End If
	//---------------------------- APPEON END ----------------------------
Next

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
end subroutine

public function integer of_create_actionitem (string as_action_item);
Return of_create_actionitem(Trim(sle_sendto.text),as_action_item)

/*  Overload it. Cut to of_create_actionitem(as_sendto,as_action_item) 
Long 		ll_action_type, ll_action_status,ll_Cycle
String 	ls_notes
Date 		ld_today

SetPointer(HourGlass!)

ld_today = today()

//----------Begin Modified by Alfee 06.12.2007-----------------
ls_notes = "To: " + Trim(sle_sendto.text) + '~r~n'
ls_notes += "CC: " + Trim(sle_1.text) + '~r~n'
ls_notes += "Attachments: " + Trim(sle_attach.text) 
//---------End Modified ---------------------------------------

ll_action_type = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Type' and code = 'Email'"))
ll_action_status = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Status' and code = 'Complete'"))

CHOOSE CASE Lower(Trim(as_action_item))
	CASE "parent level"
	   INSERT INTO ctx_action_items (
					   ctx_id, action_type, due_date, wf_assigned_by, 
						active_status, action_status, action_date, inserted_at_date_time, action_user, 
						no_attempts, first_attempt, last_attempt, print_flag,  notes)
			  VALUES (:il_ctx_id, :ll_action_type, Null, :gs_user_id,
						 0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 
						1, :ld_today, :ld_today, -1, :ls_notes) ;

		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.08.2009 By: Ken.Guo
		//$<reason>Refresh Action Items Cdata
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select10 = True Then
				w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve()
			End If			
		End If
		//---------------------------- APPEON END ----------------------------
		
	CASE "document manager work flow"
		//---------Added by alfee 04.26.2007 fix a bug--------
		IF UpperBound(il_doc_id) < 1 Then Return 0 //08.29.2007
		IF UpperBound(il_doc_id) = 1 Then 
			If IsNull(il_doc_id[1]) or il_doc_id[1] < 1 Then Return 0
		End If
		//-------End Added------------------------------------
		gnv_appeondb.of_startqueue()
		FOR ll_Cycle = 1 TO UpperBound(il_doc_id)
			INSERT INTO ctx_am_action_item(
							doc_id, action_type, due_date, wf_assigned_by,
							active_status, action_status, status_date, create_date, action_user, 
							attempt_times, first_attempt, last_attempt, print_flag, notes)
			  	 VALUES (:il_doc_id[ll_Cycle], :ll_action_type, Null, :gs_user_id,
							0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 					
							1, :ld_today, :ld_today, -1, :ls_notes) ;		
		NEXT
		gnv_appeondb.of_commitqueue()
		
		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//-------Added by alfee 05.04.2007 --------
		//Refresh Document->action item 
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select9 = True Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
			End If
		End If
		//-------End Added------------------------------------
		
END CHOOSE

SetPointer(Arrow!)


RETURN 1
*/
end function

public subroutine of_add_attachment (string as_from);Long 		ll_email_id,i
Integer 	li_rtn,li_i, ll_full_cnt, ll_file_cnt, ll_doc_cnt
Integer 	li_ctx_id
string 	docpath, docname[], ls_attachment, ls_filename
String ls_filename_temp,ls_fullname_temp
String ls_fullnamelist[]

n_cst_string 		lnv_string
n_cst_filesrv 		lnv_filesrv
str_doc_search  	lstr_pass

ll_full_cnt = UpperBound(is_fullname) 
ll_file_cnt = UpperBound(is_filename)
ll_doc_cnt = UpperBound(il_doc_id)

SetPointer( HourGlass! )
CHOOSE CASE Lower(as_from)
	CASE "file"
		gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
		li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC", "All Files (*.*), *.*")	
		gf_save_dir_path(docpath) //Added by Ken.Guo on 2009-03-10
		//ChangeDirectory(gs_current_path)
		IF li_rtn = 1 THEN
			//Set email attachment field with filename		
			lnv_string.of_arraytostring( docname,",",false,ls_attachment)
			IF Len(Trim(sle_attach.text)) > 0 Then
				sle_attach.text += "," + ls_attachment
			ELSE
				sle_attach.text = ls_attachment		
			END IF
			//docpath = Left(docpath, LastPos(docpath ,"\")) //by alfee 08.22.2007
			IF Upperbound(docname) = 1 THEN docpath = Left(docpath, LastPos(docpath ,"\") -1)		
			FOR li_i = 1 to upperbound(docname)
				//Set fullname variable
				IF Len(Trim(is_attach_file)) > 0 Then
					is_attach_file += "," + docpath + "\" + docname[li_i]
				ELSE
					is_attach_file = docpath + "\" + docname[li_i]
				END IF			
				//Set filename and fullname array
				ls_filename_temp = docname[li_i]	
				ls_fullname_temp = docpath + "\" + docname[li_i]	
				This.of_check_same_filename( ls_filename_temp, ls_fullname_temp, as_from, True) //Added by Ken.Guo on 2009-03-13
				is_filename[ll_file_cnt + li_i] = ls_filename_temp
				is_fullname[ll_full_cnt + li_i] = ls_fullname_temp
				of_generate_cleanfile(is_fullname[ll_full_cnt + li_i],is_filename[ll_file_cnt + li_i],as_from) //Added by Ken.Guo on 2009-03-12
			NEXT
		END IF
	CASE "library" //From document library
		//open browse window
		openwithparm(w_agreement_doc_search,'') 
		lstr_pass = message.powerobjectparm
		//Set email fields & Variables
		IF NOT isvalid(lstr_pass) THEN RETURN
		IF lstr_pass.l_count > 0 THEN
			//Set email attachment field with filename
			lnv_string.of_arraytostring( lstr_pass.s_filename ,",",false,ls_attachment)
			IF Len(Trim(sle_attach.text)) > 0 Then
				sle_attach.text += "," + ls_attachment
			ELSE
				sle_attach.text = ls_attachment
			END IF
			//Set fullname variable
			lnv_string.of_arraytostring( lstr_pass.s_pathname ,",",false,ls_attachment)
			IF Len(Trim(is_attach_file)) > 0 Then
				is_attach_file += "," + ls_attachment
			ELSE
				is_attach_file = ls_attachment
			END IF
			//Set filename and fullname array
			FOR li_i = 1 to upperbound(lstr_pass.s_filename)
				is_filename[ll_file_cnt + li_i] = lstr_pass.s_filename[li_i]			 
				is_fullname[ll_full_cnt + li_i] = lstr_pass.s_pathname[li_i]						
				of_generate_cleanfile(is_fullname[ll_full_cnt + li_i],is_filename[ll_file_cnt + li_i],as_from) //Added by Ken.Guo on 2009-03-12
			NEXT			
			/*
			FOR li_i = 1 to upperbound(lstr_pass.s_pathname)
				is_fullname[ll_full_cnt + li_i] = lstr_pass.s_pathname[li_i]						
			NEXT	
			*/
		END IF
	CASE "document", "attachment" //from document manager or current attachement
		//open browse window
		if Lower(as_from) = 'document' Then
			OPEN(w_dm_email_browse)
			lstr_pass = message.powerobjectparm
		else
			
			If UpperBound(istr_ctx_email.doc_id_list[]) = 0 Then 
				IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)	
				Return
			End If
			Openwithparm(w_appeon_gifofwait, "Attaching document...")
			If inv_dm_utils.of_download_multi_files( istr_ctx_email.doc_id_list[] ,istr_ctx_email.revision_list[] , ls_fullnamelist[]) < 0 Then
				IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)				
				Messagebox('Error','Failed to download the document.')
				Return
			End If
			If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
			lstr_pass.l_count =  UpperBound(istr_ctx_email.doc_id_list[])
			lstr_pass.doc_id[] = istr_ctx_email.doc_id_list[]
			lstr_pass.s_pathname[] = ls_fullnamelist[]
			For li_i = 1 to lstr_pass.l_count
				lstr_pass.s_filename[li_i] = Mid(ls_fullnamelist[li_i], LastPos(ls_fullnamelist[li_i],"\") + 1)
				is_doc_list += String(istr_ctx_email.doc_id_list[li_i]) + ','
			Next
			
			lnv_string.of_delete_duplicate(istr_ctx_email.ctx_id_list[])
			For li_i = 1 To UpperBound(istr_ctx_email.ctx_id_list[] )
				is_ctx_list += String(istr_ctx_email.ctx_id_list[li_i]) + ','
			Next
			
			is_ctx_list = Mid(is_ctx_list,1, Len(is_ctx_list) - 1)
			is_doc_list = Mid(is_doc_list,1, Len(is_doc_list) - 1)
			//End - Modified By Ken.Guo 2010-10-26

		end if
		//Set email fields & Variables	
		IF NOT isvalid(lstr_pass) THEN RETURN
		IF lstr_pass.l_count > 0 THEN
			//Set email attachment field with filename
			lnv_string.of_arraytostring( lstr_pass.s_filename ,",",false,ls_attachment)
			IF Len(Trim(sle_attach.text)) > 0 THEN
				sle_attach.text += "," + ls_attachment
			ELSE
				sle_attach.text = ls_attachment
			END IF
			//Set fullname variable
			lnv_string.of_arraytostring( lstr_pass.s_pathname ,",",false,ls_attachment)
			IF Len(Trim(is_attach_file)) > 0 THEN
				is_attach_file += "," + ls_attachment
			ELSE
				is_attach_file = ls_attachment
			END IF
			//Set filename and fullname array
			FOR li_i = 1 to upperbound(lstr_pass.s_filename)
				is_filename[ll_file_cnt + li_i] = lstr_pass.s_filename[li_i]			 
				is_fullname[ll_full_cnt + li_i] = lstr_pass.s_pathname[li_i]						
				of_generate_cleanfile(is_fullname[ll_full_cnt + li_i],is_filename[ll_file_cnt + li_i],as_from) //Added by Ken.Guo on 2009-03-12
			NEXT	
			/*
			FOR li_i = 1 to upperbound(lstr_pass.s_pathname)
				is_fullname[ll_full_cnt + li_i] = lstr_pass.s_pathname[li_i]
			NEXT
			*/
			//Set document id array from document manager
			FOR li_i = 1 to upperbound(lstr_pass.doc_id)
				il_doc_id[ll_doc_cnt + li_i] = lstr_pass.doc_id[li_i]
			NEXT
		END IF
	Case 'clause_attachment' //Added By Ken.Guo 2009-12-31.
			lstr_pass.l_count = 1
			lstr_pass.doc_id[1] = istr_ctx_email.doc_id
			lstr_pass.s_pathname[1] = istr_ctx_email.fullname
			lstr_pass.s_filename[1] = istr_ctx_email.filename 
		
			IF lstr_pass.l_count > 0 THEN
				//Set email attachment field with filename
				lnv_string.of_arraytostring( lstr_pass.s_filename ,",",false,ls_attachment)
				IF Len(Trim(sle_attach.text)) > 0 Then
					sle_attach.text += "," + ls_attachment
				ELSE
					sle_attach.text = ls_attachment
				END IF
				//Set fullname variable
				lnv_string.of_arraytostring( lstr_pass.s_pathname ,",",false,ls_attachment)
				IF Len(Trim(is_attach_file)) > 0 Then
					is_attach_file += "," + ls_attachment
				ELSE
					is_attach_file = ls_attachment
				END IF
				//Set filename and fullname array
				FOR li_i = 1 to upperbound(lstr_pass.s_filename)
					is_filename[ll_file_cnt + li_i] = lstr_pass.s_filename[li_i]			 
					is_fullname[ll_full_cnt + li_i] = lstr_pass.s_pathname[li_i]						
					of_generate_cleanfile(is_fullname[ll_full_cnt + li_i],is_filename[ll_file_cnt + li_i],as_from) //Added by Ken.Guo on 2009-03-12
				NEXT				
			End If
	
END CHOOSE


//Convert to PDF
IF cbx_1.Checked THEN of_convert_pdf(TRUE)

of_gen_attachment_name() //Added by Ken.Guo on 2009-03-13

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)

end subroutine

public subroutine of_seloccontacts ();
n_cst_outlook lnv_Outlook

//Added By Ken.Guo 2011-08-30.  Workaround APB Bug
w_mdi.inv_statusbar.of_setrefreshrate( 0 )
sleep(1)
//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
//lnv_Outlook.of_SelectContacts(sle_sendto, sle_1, sle_sendbcc)
lnv_Outlook.of_SelectXPContacts(sle_sendto, sle_1, sle_sendbcc) //modify by stephen 04.07.2013 -bug 3468:Questions on IntelliContract - Unable to verify smtp address 
//---------End Modfiied ------------------------------------------------------

w_mdi.inv_statusbar.of_setrefreshrate( 3 )
end subroutine

public subroutine of_seliccontacts (integer ai_sendtype);String 	ls_email, ls_addr

str_pass lstr_pass

lstr_pass.s_string = "EMail_Send"
lstr_pass.l_facility_id = -999

OpenWithParm ( w_contract_contact, lstr_pass)

ls_email = Trim(Message.StringParm)

if f_validstr(ls_email) then
	Choose Case ai_SendType
		Case 1	//Send To
			if sle_Sendto.Text <> "" then sle_Sendto.Text += ';'
			sle_Sendto.Text += ls_email
		Case 2	//Send CC
			if sle_1.Text <> "" then sle_1.Text += ';'
			sle_1.Text += ls_email
		Case 3	//Send BCC
			if sle_sendbcc.Text <> "" then sle_sendbcc.Text += ';'
			sle_sendbcc.Text += ls_email
	End Choose
end if

end subroutine

public function integer of_get_emailmessage (long al_email_id, ref blob ablb_msgdata);long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long 	READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
				INTO :lb_Temp
				FROM wf_email
			  WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_MsgData += lb_Temp
	next
else
	SELECTBLOB Email_Message
			INTO :ablb_MsgData
			FROM wf_email
		  WHERE wf_email.email_id = :al_EMail_Id;
end if

return 1

end function

public function integer of_setresize (boolean ab_switch);Integer	li_rc, li_v, li_vars
Integer li_origwidth, li_origheight

If IsNull (ab_switch) Then
	Return -1
End If

If ab_switch Then
	If IsNull(inv_resize) Or Not IsValid (inv_resize) Then
		inv_resize = Create n_cst_resize
		inv_resize.of_SetOrigSize ( this.width, this.height )
		li_rc = 1
	End If
Else
	If IsValid (inv_resize) Then
		Destroy inv_resize
		li_rc = 1
	End If
End If

Return li_rc

end function

public subroutine of_convert_pdf_bk (boolean ab_convert);Integer 	li_file, li_ret
Long 		ll_cnt, i, j, ll_pos,ll_Len, ll_cpu
String 	ls_ext, ls_temp, ls_SourceFile, ls_pdf_path,ls_prntrs,ls_DefPrinter
Oleobject lole_word
n_cst_filesrvwin32 lnv_filesvr
boolean lb_msg = true

ll_cnt = UpperBound(is_fullname)
IF ll_cnt < 1 THEN RETURN

//Un-convert to PDF, restore attachment field and variable 
IF NOT ab_convert THEN
	is_attach_file = ""
	FOR i = 1 TO ll_cnt
		//Set attchment field and variable
		IF i = 1 THEN 
			sle_attach.text = is_filename[i]
			is_attach_file = is_fullname[i]
		ELSE
			sle_attach.text += "," + is_filename[i]
			is_attach_file += "," + is_fullname[i]			
		END IF
	NEXT
	Destroy lole_word
	Destroy lnv_filesvr		
	RETURN
END IF

//---------Begin Added by Alfee 03.25.2008----------------------------
FOR i = 1 to ll_cnt		
	IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
	ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
	IF lower(ls_ext) = 'doc' THEN EXIT
NEXT
IF lower(ls_ext) <> 'doc' THEN
	cbx_1.checked = False	
	Destroy lole_word
	Destroy lnv_filesvr			
	MessageBox("Convert PDF","Only Word documents are supported!")	
	RETURN
END IF
//----------End Added ------------------------------------------------

//---Appeon Begin by alfee 04.11.2007-------
//Check PDF Printer
if f_PrinterSetup(2) >= 2 then return	//Added by Scofield on 2007-11-09
ls_prntrs = PrintGetPrinters ( )
//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
//IF NOT Pos(lower(ls_prntrs),lower("Contract Logix PDF Writer")) > 0 THEN
IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
	cbx_1.Checked = FALSE
	cbx_1.Enabled = FALSE
	//MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")
	MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
	RETURN
END IF


//Convert to PDF, get & convert all Word documents 
//ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
ls_SourceFile = gs_temp_pdf
//ls_SourceFile = gs_dir_path + gs_DefDirName + "\PDFPrinter\temp\SampleOut.PDF" //Alfee 08.21.2007
//---------End Modfiied ------------------------------------------------------

//---------Begin Added by Alfee 08.22.2007----------------------
//Delete temporary pdf file 
IF FileExists(ls_SourceFile) THEN 
	//---------Begin Modified by (Appeon)Stephen 02.13.2014 for PDF Printer Issues--------
	/*
	IF Not FileDelete(ls_SourceFile) THEN 
		MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
		cbx_1.Checked = FALSE		
		RETURN
	END IF
	*/
	ll_cpu = cpu()
	li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
	do while li_ret = 1
		li_ret = f_pdfprint_chk(ll_cpu, lb_msg)
	loop
	if li_ret = -1 then 
		cbx_1.Checked = FALSE		
		return
	end if
	//---------End Modfiied ------------------------------------------------------	
END IF
//----------End Added ----------------------------------------

lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN
END IF
lole_word.Visible = FALSE

TRY
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008	
If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Converting to PDF...")
FOR i = 1 to ll_cnt		
	IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
	ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
	IF lower(ls_ext) = 'doc' THEN
		//Delete temporary pdf file  - Alfee 08.22.2007
		IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
		
		//Open Word Document 		
		lole_word.Application.Documents.Open(is_fullname[i],false,true)
		//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		gnv_shell.of_delete_recent( is_fullname[i], true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
			
		//Set pdf Printer and print to PDF format
		Try
			if f_PrinterSetup(2) >= 2 then return		//Added by Scofield on 2007-11-09
			
			ll_Len = 100
			ls_DefPrinter = SPACE(ll_Len)
			GetDefaultPrinter(ls_DefPrinter,ll_Len)	//Added by Scofield on 2008-12-09
			
			lole_word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
			lole_word.ActiveDocument.Printout( 0 )
			lole_word.ActiveDocument.Close(0)
			
			SetDefaultPrinter(ls_DefPrinter)				//Added by Scofield on 2008-07-30
		Catch(Throwable th1) //added by alfee 04.11.2007
			lole_word.ActiveDocument.Close(0)		
			lole_word.Quit(0)
			lole_word.DisconnectObject( )
			Destroy lole_word
			If isvalid(lnv_filesvr) Then Destroy lnv_filesvr					
			IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
			MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")			
			cbx_1.Checked = FALSE	
			RETURN
		End Try
		
		
		// Copy to pdf file
		ls_pdf_path = Left(is_fullname[i], Len(is_fullname[i]) - 3) + "pdf"
		If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
		//--------Begin Modified by Alfee 08.29.2007---------------		
		Do 
			Yield()
			If FileExists(ls_sourcefile) Then 
				li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
			Else
				li_file = -1
			End If
		Loop While li_file = -1
		FileClose(li_file)
		lnv_filesvr.of_filecopy(ls_sourcefile, ls_pdf_path )
		/*Do While NOT lnv_filesvr.of_filecopy(ls_sourcefile, ls_pdf_path ) = 1
			Yield()
		Loop*/
		//--------End Modified ---------------------------------------
	END IF	
NEXT

Catch(Throwable th) //added by alfee 04.11.2007
	If isvalid(lole_word) Then	
		lole_word.Quit(0)
		lole_word.DisconnectObject( )		
		Destroy lole_word
	END IF
	If isvalid(lnv_filesvr) Then Destroy lnv_filesvr						
	IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
	RETURN
End Try

//Quit Word application
lole_word.Quit(0)
lole_word.DisconnectObject( )
Destroy lole_word
If isvalid(lnv_filesvr) Then Destroy lnv_filesvr					

//Update attachment field and variable after convert
is_attach_file = ""
FOR i = 1 TO ll_cnt
	//Set attchment array
	is_fullname_convert[i] = is_fullname[i]
	is_filename_convert[i] = is_filename[i]
  
	IF len(trim(is_fullname[i])) < 1 THEN CONTINUE
	ls_ext = Mid(is_fullname[i], LastPos(is_fullname[i], ".") + 1)
	IF lower(ls_ext) = 'doc'  THEN
		ls_temp = Left(is_fullname[i], Len(is_fullname[i]) - 3) + "pdf"
		IF FILEEXISTS(ls_temp) THEN
			is_fullname_convert[i] = ls_temp
			is_filename_convert[i] = Left(is_filename[i], Len(is_filename[i]) - 3) + "pdf"
		END IF
	END IF
	//Set attchment field
	IF i = 1 THEN 
		sle_attach.text = is_filename_convert[i]
	ELSE
		sle_attach.text += "," + is_filename_convert[i]
	END IF
	//Set files' fullname
	IF i = 1 THEN 
		is_attach_file = is_fullname_convert[i]
	ELSE
		is_attach_file += "," + is_fullname_convert[i]
	END IF
NEXT	

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
end subroutine

public function boolean of_is_image2pdf (string as_doc_ext);//Determine if it's an image file supported to be converted to a PDF format - alfee 11.21.2008


RETURN inv_image_cp.of_is_image2pdf(as_doc_ext)
end function

public function integer of_set_security ();//Set security accordingly - Alfee 12.10.2008

IF w_mdi.of_security_access(2150) = 0 THEN //document manager
	pb_document.Visible = FALSE
	st_document.Visible = FALSE
END IF

IF w_mdi.of_security_access(6802 ) = 0 THEN //document library painter
	pb_library.Visible = FALSE
	st_library.Visible = FALSE
END IF

RETURN 1
end function

public subroutine of_getemailattachment (long al_email_id, long al_attach_id, ref blob ablb_attachment);//====================================================================
// Function: of_GetEmailAttachment()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long	al_Email_id
// 	reference	blob	ablb_Attachment
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-18
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(Attachment)
  INTO :ll_DataLen
  FROM wf_email_attachment
 WHERE email_id = :al_EMail_Id AND attach_id = :al_attach_id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Attachment,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email_attachment
		     WHERE email_id = :al_EMail_Id AND attach_id = :al_attach_id;
		
		ablb_Attachment += lb_Temp
	next
else
	SELECTBLOB Attachment
	      INTO :ablb_Attachment
	      FROM wf_email_attachment
	     WHERE email_id = :al_EMail_Id AND attach_id = :al_attach_id;
end if

end subroutine

public subroutine of_delete_history_files ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_delete_history_files()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-16 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String	ls_TempDir
n_cst_filesrv inv_filesrv

f_SetFileSrv(inv_filesrv,TRUE)

ls_TempDir = is_email_file_path + "CleanDoc\"
inv_filesrv.of_deltree(ls_TempDir)
end subroutine

public subroutine of_generate_cleanfile (string as_fullname, string as_filename, string as_from);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_copyto_clean_dir()
// $<arguments>
//		value	string	as_fullname		
//		value	string	as_filename		
//		value	string	as_from
// $<returns> (none)
// $<description> 
// $<description> Copy a word document and accept all revisitons and remove all comments.
//////////////////////////////////////////////////////////////////////
// $<add> 03/12/2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_clean_path,ls_ext
Integer i
oleobject lole_word
Long ll_comments_cnt,ll_revi_cnt
String ls_cleanfile_fullname

//Create directory
ls_clean_path = is_email_file_path + "CleanDoc\" + as_from  
IF Not DirectoryExists( ls_clean_path ) THEN
	If Not f_createdirectory(ls_clean_path ) Then
		is_fullname_org[UpperBound(is_fullname_org[]) + 1] = as_fullname
		is_filename_org[UpperBound(is_filename_org[]) + 1] = as_filename	
		is_fullname_clean[UpperBound(is_fullname_clean[]) + 1] = ''
		is_filename_clean[UpperBound(is_fullname_clean[]) + 1] = ''		
		Messagebox('IntelliSoft','Failed to create temporary directory, please call support.')
		Return 
	End If
END IF

//Save original file path, For Restore
is_fullname_org[UpperBound(is_fullname_org[]) + 1] = as_fullname
is_filename_org[UpperBound(is_filename_org[]) + 1] = as_filename

//Generate word document
ls_ext = Mid(as_fullname, LastPos(as_fullname, ".") + 1)
If lower(ls_ext) = 'doc' Then
	lole_word = Create oleobject
	IF lole_word.Connecttonewobject("word.application") <> 0 THEN
		Destroy lole_word 
		is_fullname_clean[UpperBound(is_fullname_clean[]) + 1] = ''
		is_filename_clean[UpperBound(is_filename_clean[]) + 1] = ''
		Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
		RETURN
	END IF

	//Accept revisions and remove comments in word	
	Try
		lole_word.Visible = FALSE	
		lole_word.Application.NormalTemplate.Saved = TRUE
		lole_word.Application.Documents.Open(as_fullname,False,True)
		//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		gnv_shell.of_delete_recent( as_fullname, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		ll_revi_cnt = lole_word.ActiveDocument.Revisions.Count
		ll_revi_cnt += inv_dm_utils.of_get_sharps_revision_count( lole_word.ActiveDocument) //Added By Ken.Guo 2010-10-14.
		ll_comments_cnt = lole_word.ActiveDocument.Comments.Count
		
		If ll_revi_cnt > 0 or ll_comments_cnt > 0 Then
			as_filename = Left(as_filename,LastPos(as_filename, ".") - 1) + '(Clean).doc'
			ls_cleanfile_fullname = ls_clean_path + '\' + as_filename
			//If document have redline.
			If ll_revi_cnt > 0 Then
				//lole_word.ActiveDocument.Revisions.AcceptAll()
				lole_word.ActiveDocument.AcceptAllRevisions() //Modified By Ken.Guo 2010-10-14
			End If
			ll_comments_cnt = lole_word.ActiveDocument.Comments.Count
			For i = ll_comments_cnt To 1 Step -1
				lole_word.ActiveDocument.Comments[i].Delete()
			Next
			//SaveAs to clean dir
			If ll_revi_cnt > 0 or ll_comments_cnt > 0 Then
				lole_word.ActiveDocument.SaveAS(ls_cleanfile_fullname,0,false,'',false)
				gnv_shell.of_delete_recent( ls_cleanfile_fullname, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			Else
				FileCopy(as_fullname,ls_cleanfile_fullname,True)
			End If
		Else
			//If no redline
			ls_cleanfile_fullname = ''
			as_filename = ''
		End If
		lole_word.ActiveDocument.Close(0)		
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
	Catch(Throwable th1)
		lole_word.ActiveDocument.Close(0)		
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
		is_fullname_clean[UpperBound(is_fullname_clean[]) + 1] = ''
		is_filename_clean[UpperBound(is_filename_clean[]) + 1] = ''
		Destroy lole_word		
		Return
	End Try
	is_fullname_clean[UpperBound(is_fullname_clean[]) + 1] = ls_cleanfile_fullname
	is_filename_clean[UpperBound(is_filename_clean[]) + 1] = as_filename
Else
	//For other type document
	is_fullname_clean[UpperBound(is_fullname_clean[]) + 1] = ''
	is_filename_clean[UpperBound(is_filename_clean[]) + 1] = ''
End If

If isvalid(lole_word) Then Destroy lole_word

end subroutine

public subroutine of_check_same_filename (ref string as_filename, ref string as_fullname, string as_from, boolean ab_copy);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_check_same_filename()
// $<arguments>
//			string 	as_filename		
//			string 	as_fullname		
//				as_from		
//				ab_copy		
// $<returns> (none)
// $<description>
// $<description> If the file is exist, then copy to other dir, and rename it.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i,j
String ls_new_name,ls_all_name_string,ls_doc_path
Integer li_pos

ls_doc_path = is_email_file_path + as_from 

f_createdirectory(ls_doc_path)

For i = 1 To UpperBound(is_filename[])
	ls_all_name_string = ls_all_name_string + ',' + is_filename[i]
Next

For i = 1 to UpperBound(is_filename[])
	//If exist, need rename
	If as_filename = is_filename[i] Then
		Do While J <= 30 
			J++
			li_pos = LastPos(as_filename,'.')
			If li_pos = 0 Then li_pos = Len(as_filename) + 1
			ls_new_name = Left(as_filename,LastPos(as_filename,'.') - 1) + '_' + String(j) + Right(as_filename,Len(as_filename) - li_pos + 1)
			If Pos(ls_all_name_string,ls_new_name) > 0 Then 
				Continue
			Else
				If ab_copy Then
					FileCopy(as_fullname,ls_doc_path + '\' + ls_new_name , True)
					as_filename = ls_new_name
					as_fullname = ls_doc_path + '\' + ls_new_name
				Else
					//as_filename = ls_new_name
					//as_fullname = 'New path,Need rename'
				End If
				Return
			End If
		Loop
	End If
Next

Return 
end subroutine

public subroutine of_gen_attachment_name ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_gen_attachment_name()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
Decimal ldec_size
String ls_unit,ls_filename,ls_fullname
boolean lb_noclean

sle_attach.SetRedraw(False)
sle_attach.Text = ''
is_attach_file = ''

Integer li_file_nct

sle_attach.text = of_gen_attachfilename_from_batch(cbx_1.checked) //Added By Ken.Guo 2010-07-07.

li_file_nct = UpperBound(is_filename_org[])

If cbx_clean.checked Then
	If cbx_1.Checked Then
		//attach org PDF and clean PDF Files
		For i = 1 To li_file_nct
			If UpperBound(is_filename_convert_org[]) < i Then Continue
			If is_filename_convert_org[i] = '' Then Continue
			
			//Attache Org/PDF files
			ldec_size = of_get_file_size(is_fullname_convert_org[i],ls_unit)
			//Display name
			If sle_attach.Text = '' Then
				sle_attach.Text = is_filename_convert_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			Else
				sle_attach.Text += ';  ' + is_filename_convert_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			End If
			//Attachment path
			If is_attach_file = '' Then
				is_attach_file = is_fullname_convert_org[i]
			Else
				is_attach_file = is_attach_file + ',' + is_fullname_convert_org[i]
			End If
			
			//Attache Clean PDF file if exists
			If UpperBound(is_filename_convert_clean[]) < i Then Continue
			If is_filename_convert_clean[i] <> '' Then
				ldec_size = of_get_file_size(is_fullname_convert_clean[i],ls_unit)
				//Display name
				If sle_attach.Text = '' Then
					sle_attach.Text = is_filename_convert_clean[i] + ' (' + String(ldec_size) + ls_unit + ')'
				Else
					sle_attach.Text += ';  ' + is_filename_convert_clean[i] + ' (' + String(ldec_size) + ls_unit + ')'
				End If
				//Attachment path
				If is_attach_file = '' Then
					is_attach_file = is_fullname_convert_clean[i]
				Else
					is_attach_file = is_attach_file + ',' + is_fullname_convert_clean[i]
				End If
			else
				lb_noclean = true	//jervis 09.27.2009
			End If
		Next
	Else
		//attach org and clean file
		For i = 1 To li_file_nct
			If UpperBound(is_filename_org[]) < i Then Continue
			If is_filename_org[i] = '' Then Continue			
			//Attache Org files
			ldec_size = of_get_file_size(is_fullname_org[i],ls_unit)
			//Display name
			If sle_attach.Text = '' Then
				sle_attach.Text = is_filename_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			Else
				sle_attach.Text += ';  ' + is_filename_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			End If
			//Attachment path
			If is_attach_file = '' Then
				is_attach_file = is_fullname_org[i]
			Else
				is_attach_file = is_attach_file + ',' + is_fullname_org[i]
			End If
			
			//Attache Clean file if exists
			If UpperBound(is_filename_clean[]) < i Then Continue
			If is_filename_clean[i] <> '' Then
				ldec_size = of_get_file_size(is_fullname_clean[i],ls_unit)
				//Display name
				If sle_attach.Text = '' Then
					sle_attach.Text = is_filename_clean[i] + ' (' + String(ldec_size) + ls_unit + ')'
				Else
					sle_attach.Text += ';  ' + is_filename_clean[i] + ' (' + String(ldec_size) + ls_unit + ')'
				End If
				//Attachment path
				If is_attach_file = '' Then
					is_attach_file = is_fullname_clean[i]
				Else
					is_attach_file = is_attach_file + ',' + is_fullname_clean[i]
				End If
			else
				lb_noclean = true	//jervis 09.27.2009
			End If
		Next		
	End If
	IF lb_noclean Then //Added By Ken.Guo 2010-05-25. Add the if statement.
		if li_file_nct > 1 then
			MessageBox("IntelliSoft","Some of the documents you have attached have no tracked changes or have not been modified, which will not be converted to clean copy.")
		elseif li_file_nct = 1 then
			MessageBox("IntelliSoft","The document you have attached has no tracked changes.  Nothing to convert to clean copy.")
		end if
	End If

Else
	//Attach PDF or Org Files
	If cbx_1.Checked Then
		//For PDF Files
		For i = 1 To li_file_nct
			
			If UpperBound(is_filename_convert_org[]) < i Then Continue
			If is_filename_convert_org[i] = '' Then Continue
			
			ldec_size = of_get_file_size(is_fullname_convert_org[i],ls_unit)
			
			//Display name
			If sle_attach.Text = '' Then
				sle_attach.Text = is_filename_convert_org[1] + ' (' + String(ldec_size) + ls_unit + ')'
			Else
				sle_attach.Text += ';  ' + is_filename_convert_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			End If
			
			//Attachment path
			If is_attach_file = '' Then
				is_attach_file = is_fullname_convert_org[i]
			Else
				is_attach_file = is_attach_file + ',' + is_fullname_convert_org[i]
			End If
		Next
	Else
		//For ORG Files
		For i = 1 To li_file_nct

			ldec_size = of_get_file_size(is_fullname_org[i],ls_unit)
			
			//Display name
			If sle_attach.Text = '' Then
				sle_attach.Text = is_filename_org[1] + ' (' + String(ldec_size) + ls_unit + ')'
			Else
				sle_attach.Text += ';  ' + is_filename_org[i] + ' (' + String(ldec_size) + ls_unit + ')'
			End If
			
			//Attachment path
			If is_attach_file = '' Then
				is_attach_file = is_fullname_org[i]
			Else
				is_attach_file = is_attach_file + ',' + is_fullname_org[i]
			End If			
		Next
	End If	
End If

sle_attach.SetRedraw(True)

end subroutine

public subroutine of_create_clean_version ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_create_clean_version()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>
// $<description> Use clean version for doc
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-16 by Ken.Guo
//////////////////////////////////////////////////////////////////////


SetPointer(HourGlass!)

If cbx_1.checked Then
	Sleep(1) //PDF file sometime is locked and need some time to release it.
	of_convert_pdf(TRUE)	
//Else
//	If cbx_clean.Checked Then
//		is_filename[] = is_filename_clean[]
//		is_fullname[] = is_fullname_clean[]
//	Else
//		is_filename[] = is_filename_org[]
//		is_fullname[] = is_fullname_org[]	
//	End If	
End If

of_gen_attachment_name()	

end subroutine

public function integer of_gen_web_link ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_gen_web_link()
// $<arguments>(None)
// $<returns> string
// $<description>
// $<description> Generate Web Link
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////


String ls_weblink_root,ls_weblink_name,ls_ie_url
String ls_file_name,ls_user_email,ls_cache_name
Integer i
Long ll_check_sn
Long ll_file_size
Blob lb_file_image
String ls_ctx_link
String ls_file_type_des
n_cst_dm_utils lnv_file_dm

SetPointer(HourGlass!)

If of_save_attachment() < 0 Then
	Messagebox('Error','Failed to generate the attachment, please call support.')
	Return -1
End If

//Get web_link name and cache name if they have been set in Web Link Settings Window.
Select web_link_name,cache_name Into :ls_weblink_root,:ls_cache_name From Icred_settings;

//If not exists in database, generate it from current URL
If isnull(ls_weblink_root) or ls_weblink_root = '' Then
	ls_ie_url = AppeonGetIEURL()
	If left(lower(ls_ie_url),7) = 'http://' Then
		ls_ie_url = 'http://' + Mid(ls_ie_url,8,len(ls_ie_url))
	ElseIf left(lower(ls_ie_url),8) = 'https://' Then
		ls_ie_url = 'https://' + Mid(ls_ie_url,9,len(ls_ie_url))
	End If
	//AppeonGetIEURL() will return the current web root URL, e.g. 'http://192.0.3.37/test_ken/'
	ls_ie_url = Mid(ls_ie_url,1,Len(ls_ie_url) - 1) //Cut last '/'
	ls_weblink_root = Mid(ls_ie_url,1,LastPos(ls_ie_url,'/'))
	ls_weblink_root = ls_weblink_root + 'fileservice/index.aspx'
Else
	If Right(ls_weblink_root,1) = '/' Then
		ls_weblink_root += 'index.aspx'
	Else
		ls_weblink_root += '/index.aspx'
	End If
End If

If isnull(ls_cache_name) or ls_cache_name = '' Then
	If gs_cachename <> '' Then
		ls_cache_name = gs_cachename
	Else
		//Failed to get cache name/database name.
		Messagebox('IntelliSoft Error -1','Failed to get cache name, please call support.')
		is_web_link = ''
		Return -1
	End If
End If

//Gen check SN
For i = 1 To Len(ls_cache_name)
	ll_check_sn += Asc(Mid(Lower(ls_cache_name),i,1))
Next
ll_check_sn += istr_ctx_email.doc_id_list[1]  + istr_ctx_email.revision_list[1]  * 10

//Gen Web Link
ls_weblink_name = ls_weblink_root + '?dbname=' + lower(ls_cache_name) + '&doc_id=' + String(istr_ctx_email.doc_id_list[1] ) + &
						'&rev_id=' + String(istr_ctx_email.revision_list[1] ) + '&ck=' + String(ll_check_sn)

//Gen CTX Link
If gs_cachename <> '' Then
	ls_ctx_link = AppeonGetIEURL() + '?' + gs_cachename + '&' + String(istr_ctx_email.ctx_id_list[1] ) + '&91&'    + String(istr_ctx_email.doc_id_list[1] )
Else
	ls_ctx_link = AppeonGetIEURL() + '?' + '&' + String(istr_ctx_email.ctx_id_list[1]) + '&91&'  +   String(istr_ctx_email.doc_id_list[1])	 
End If

//Get file name. include version info
ls_file_name = gf_merge_file_name(istr_ctx_email.filename_list[1] ,istr_ctx_email.doc_ext_list[1],istr_ctx_email.doc_id_list[1],istr_ctx_email.revision_list[1])


//Get file type/desciption
//ls_file_type_des = of_get_file_type_des(istr_ctx_email.doc_ext_list[1])
//ls_file_type_des = ls_file_type_des + " (."+lower(istr_ctx_email.doc_ext_list[1])+")"
ls_file_type_des = in_FileSrv.of_getfiletypedes( istr_ctx_email.doc_ext_list[1])


//Get file size
ll_file_size = FileLength(istr_ctx_email.fullfilename_list[1])

//Set file to Blob
If lnv_file_dm.of_readblob(istr_ctx_email.fullfilename_list[1], lb_file_image) < 0 Then
	Messagebox('Web Link','Failed to read file to blob, please call support.')
	Return -1
End If

gnv_appeondb.of_startqueue( )
	//Get email address
	SELECT email  INTO :ls_user_email FROM em_smtp_accounts
	 WHERE (user_id = :gs_User_ID) AND (is_default = 'Y');
	//Delete existed record
	Delete From ctx_am_image_weblink Where doc_id = :istr_ctx_email.doc_id_list[1] and revision = :istr_ctx_email.revision_list[1] ;
gnv_appeondb.of_commitqueue( )

//Insert record
Insert Into ctx_am_image_weblink(ctx_id,doc_id,revision,file_name,file_type,file_size,web_link_name,sender_user,sender_email, sent_time,replied_email,flag,ctx_link_name) 
	Values(:istr_ctx_email.ctx_id_list[1],:istr_ctx_email.doc_id_list[1],:istr_ctx_email.revision_list[1],:ls_file_name,:ls_file_type_des, :ll_file_size ,:ls_weblink_name, :gs_user_id,:ls_user_email,getdate(),0,0,:ls_ctx_link);

//Update merged Data to DB
UpdateBlob ctx_am_image_weblink Set org_image_file = :lb_file_image where doc_id = :istr_ctx_email.doc_id_list[1] and revision = :istr_ctx_email.revision_list[1] ;
IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Web Link','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -2
END IF

//Return WEB Link
is_web_link = ls_weblink_name

Return 1

end function

public subroutine of_retrieve_emails ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_sendof_retrieve_emails()
// $<arguments>(None)
// $<returns> (none)
// $<description> Get default email for each CTX.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ids_ctx_default_contacts_email = Create n_ds
ids_ctx_default_contacts_email.DataObject = 'd_ctx_contract_email'
ids_ctx_default_contacts_email.SetTransObject(SQLCA)
ids_ctx_default_contacts_email.Retrieve(istr_ctx_email.ctx_id_list[])
end subroutine

public function integer of_merge_data (long al_ctx_id, long al_export_id, long al_ctx_id_list[]);
Return 1
end function

public function integer of_create_actionitem (string as_sendto, string as_action_item);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_sendof_create_actionitem()
// $<arguments>
//		value	string	as_sendto     		
//		value	string	as_action_item		
// $<returns> integer
// $<description> Overload. Copy from of_create_actionitem(as_action_item)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Return of_create_actionitem(as_sendto,as_action_item,0)

/*
Long 		ll_action_type, ll_action_status,ll_Cycle
String 	ls_notes
Date 		ld_today

SetPointer(HourGlass!)

If isnull(il_ctx_id) Then Return 1 //Added By Ken.Guo 2010-04-26.

ld_today = today()

//Added By Ken.Guo 2009-05-20.
If dw_1.GetItemNumber(1, "email_template") > 0 Then
	ls_notes = 'Email Template: ' + dw_1.Describe("Evaluate('LookUpDisplay(email_template) ', 1 )") + ' ~r~n' 
End If

//----------Begin Modified by Alfee 06.12.2007-----------------
If as_sendto <> '' Then 					ls_notes += "To: " + as_sendto + ' ~r~n'
If Trim(sle_1.text) <> '' Then 			ls_notes += "CC: " + Trim(sle_1.text) + ' ~r~n'
If Trim(sle_sendbcc.text) <> '' Then 	ls_notes += "BCC: " + Trim(sle_sendbcc.text) + ' ~r~n'
If Trim(sle_subject.Text) <> '' Then 	ls_notes += 'Subject: ' + Trim(sle_subject.Text) + ' ~r~n' 
If Trim(sle_attach.text)  <> '' Then 	ls_notes += "Attachments: " + Trim(sle_attach.text) + ' ~r~n' 
If Trim(is_web_link)  <> '' Then 		ls_notes += "Web Link: " + Trim(is_web_link) + ' ~r~n' 
//---------End Modified ---------------------------------------

ll_action_type = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Type' and code = 'Email'"))
ll_action_status = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Status' and code = 'Complete'"))

CHOOSE CASE Lower(Trim(as_action_item))
	CASE "parent level"
	   INSERT INTO ctx_action_items (
					   ctx_id, action_type, due_date, wf_assigned_by, 
						active_status, action_status, action_date, inserted_at_date_time, action_user, 
						no_attempts, first_attempt, last_attempt, print_flag,  notes)
			  VALUES (:il_ctx_id, :ll_action_type, Null, :gs_user_id,
						 0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 
						1, :ld_today, :ld_today, -1, :ls_notes) ;

		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.08.2009 By: Ken.Guo
		//$<reason>Refresh Action Items Cdata
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select10 = True Then
				w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve()
			End If			
		End If
		//---------------------------- APPEON END ----------------------------
		
	CASE "document manager work flow"
		//---------Added by alfee 04.26.2007 fix a bug--------
		IF UpperBound(il_doc_id) < 1 Then Return 0 //08.29.2007
		IF UpperBound(il_doc_id) = 1 Then 
			If IsNull(il_doc_id[1]) or il_doc_id[1] < 1 Then Return 0
		End If
		//-------End Added------------------------------------
		gnv_appeondb.of_startqueue()
		FOR ll_Cycle = 1 TO UpperBound(il_doc_id)
			INSERT INTO ctx_am_action_item(
							doc_id, action_type, due_date, wf_assigned_by,
							active_status, action_status, status_date, create_date, action_user, 
							attempt_times, first_attempt, last_attempt, print_flag, notes)
			  	 VALUES (:il_doc_id[ll_Cycle], :ll_action_type, Null, :gs_user_id,
							0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 					
							1, :ld_today, :ld_today, -1, :ls_notes) ;		
		NEXT
		gnv_appeondb.of_commitqueue()
		
		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//-------Added by alfee 05.04.2007 --------
		//Refresh Document->action item 
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select9 = True Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
			End If
		End If
		//-------End Added------------------------------------
		
END CHOOSE

SetPointer(Arrow!)

RETURN 1
*/
end function

public function long of_get_file_size (string as_filename, ref string as_unit);Decimal ldec_size
as_unit = ' KB'
ldec_size = FileLength (as_filename) / 1024
If ldec_size > 1024 Then
	ldec_size = ldec_size/1024
	as_unit = ' MB'
End If
Return Ceiling(ldec_size)
 

end function

public subroutine of_delete_temp_pdf ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_sendof_delete_temp_pdf()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Delete temp PDF files.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-20 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i

For i = 1 To UpperBound(is_temp_pdf[])
	FileDelete(is_temp_pdf[i])
Next


end subroutine

public function string of_get_file_type_des (string as_file_ext);String ls_file_type,ls_file_type_des
Integer li_ret
li_ret = RegistryGet("HKEY_CLASSES_ROOT\." + as_file_ext, "", RegString!, ls_file_type)

If  li_ret = 1 Then
	RegistryGet("HKEY_CLASSES_ROOT\" + ls_file_type, "", RegString!, ls_file_type_des)
End If

Return ls_file_type_des

end function

public function integer of_save_clause_attachment ();//
integer li_rtn
string ls_download_file,ls_new_path_file,ls_file_name
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause

IF Not Isvalid(w_appeon_gifofwait) THEN Open(w_appeon_gifofwait)
IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
li_rtn = lnv_clause.of_download_file( istr_ctx_email.doc_id, istr_ctx_email.revision, ls_download_file)
If li_rtn < 0 or Not fileexists(ls_download_file) Then
	If isvalid(lnv_clause) Then Destroy lnv_clause
	messagebox('Attachment','Failed to download the clause file, please call support.')
	Return -1
End If

istr_ctx_email.filename = gf_merge_file_name(istr_ctx_email.filename,istr_ctx_email.doc_ext,istr_ctx_email.doc_id,istr_ctx_email.revision) 
istr_ctx_email.fullname = is_email_file_path + istr_ctx_email.filename

FileCopy(ls_download_file,istr_ctx_email.fullname,True)

If isvalid(lnv_clause) Then Destroy lnv_clause
Return 1
end function

public function integer of_open_email ();String ls_text,ls_date
n_cst_datetime lnv_cst_datetime


ole_message.of_open( istr_ctx_email.as_mail_docname,true )

ls_date = String(istr_ctx_email.adt_mail_date ,'mmm dd yyyy HH:mm:ss')
ls_date = lnv_cst_datetime.of_DaynameOfWeek(Date(istr_ctx_email.adt_mail_date),True) + ', ' + ls_date

ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~n')
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
ole_message.object.ActiveDocument.ActiveWindow.Selection.InlineShapes.AddHorizontalLineStandard()
	
If istr_ctx_email.ai_fromctx = 3 Then
	//Ignore
Else
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('From: ' )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter(istr_ctx_email.as_mail_from)
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
	
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nSent: ' )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( ls_date )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
	
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nTo: ' )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_ctx_email.as_mail_to )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
	
	If istr_ctx_email.as_mail_cc <> '' Then
		ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
		ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nCc: ' )
		ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
		ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
		ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_ctx_email.as_mail_cc)
		ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
	End If
	
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter('~r~nSubject: ' )
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = True
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.object.ActiveDocument.ActiveWindow.Selection.End
	ole_message.object.ActiveDocument.ActiveWindow.Selection.InsertAfter( istr_ctx_email.as_mail_subject + '~r~n~r~n')
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Bold = False
	
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 2
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Name =  'Segoe UI' //'Tahoma'//
	
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 0
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Color = 0 //Blank
	ole_message.object.ActiveDocument.ActiveWindow.Selection.Range.Font.Size = 10
End If


ole_message.object.ActiveDocument.ActiveWindow.Selection.End = ole_message.object.ActiveDocument.ActiveWindow.Selection.Start

ole_message.object.ActiveDocument.Content.InsertBefore('~r~n')
ole_message.object.ActiveDocument.ActiveWindow.Selection.Start = 0
ole_message.object.ActiveDocument.ActiveWindow.Selection.End = ole_message.object.ActiveDocument.ActiveWindow.Selection.Start

ole_message.object.ActiveDocument.ActiveWindow.View.Type = 6 //wdWebView
ole_message.object.ActiveDocument.ActiveWindow.DocumentMap = False



//ole_message.object.ActiveDocument.ActiveWindow.Selection.InlineShapes.AddHorizontalLineStandard()
//ole_message.object.ActiveDocument.ActiveWindow.Selection.InlineShapes.AddHorizontalLineStandard()
/*
ls_text = &
'~r~n~r~nFrom: ' + istr_ctx_email.as_mail_from + &
'~r~nSent: ' + ls_date + &
'~r~nTo: ' + istr_ctx_email.as_mail_to

If istr_ctx_email.as_mail_cc <> '' Then
	ls_text += '~r~nCc: ' + istr_ctx_email.as_mail_cc
End If
ls_text += '~r~nSubject: ' + istr_ctx_email.as_mail_subject
ls_text += '~r~n'
ole_message.of_inserttextfirst(ls_text)
*/


/*
String ls_subject,ls_from,ls_to,ls_cc
String ls_header
//String ls_date
//n_cst_datetime lnv_cst_datetime

ls_subject = istr_ctx_email.as_mail_subject
ls_from = istr_ctx_email.as_mail_from
ls_to = istr_ctx_email.as_mail_to
ls_cc = istr_ctx_email.as_mail_cc
ls_date = String(istr_ctx_email.adt_mail_date ,'dd mmm yyyy HH:mm:ss')
ls_date = lnv_cst_datetime.of_DaynameOfWeek(Date(istr_ctx_email.adt_mail_date),True) + ', ' + ls_date

rte_header.displayonly = False
rte_header.selecttextall( )
rte_header.clear( )

//Add Subject with Bold
clipboard(ls_subject + ' ')
rte_header.Paste()
rte_header.selecttextall( )
rte_header.settextstyle( True, False,False,False,False,False)

//Add From with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
clipboard('~r~nFrom: ')
rte_header.Paste()
rte_header.settextstyle( False, False,False,False,False,False)
clipboard(ls_from + ' ')
rte_header.Paste()

//Add To with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
clipboard('~r~nTo: ')
rte_header.Paste()
rte_header.settextstyle( False, False,False,False,False,False)
clipboard(ls_to + ' ')
rte_header.Paste()

//Add Cc with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
clipboard('~r~nCc: ')
rte_header.Paste()
rte_header.settextstyle( False, False,False,False,False,False)
clipboard(ls_cc + ' ')
rte_header.Paste()

//Add Date with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
clipboard('~r~nDate: ')
rte_header.Paste()
rte_header.settextstyle( False, False,False,False,False,False)
clipboard(ls_date + ' ~r~n~r~n')
rte_header.Paste()

rte_header.scroll(0 - rte_header.LineCount())
clipboard('')

rte_header.selecttextall( )
rte_header.copy()

rte_header.displayonly = True
ole_message.object.ActiveDocument.ActiveWindow.Selection.Paste()
*/



Return 1
end function

public function integer of_get_email_attach (long al_mail_id, string as_mail_emlname, string as_mail_format, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_sendof_get_email_attach()
// $<arguments>
//		value	long   	al_mail_id     		
//		value	string 	as_mail_emlname		
//		value	string 	as_mail_format 		
//		value	integer	ai_type     1. attachment 2. Mime 3. Both   		
// $<returns> integer
// $<description> Get Email' attach or Mime file or both
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
String ls_attachlist[],ls_mimelist[]
String ls_filename,ls_email_dir

ls_email_dir = ole_message.of_getemaildir( )
ls_email_dir = ls_email_dir + '\Email_files'
gnv_appeondll.of_parsepath(ls_email_dir)

Choose Case Upper(as_mail_format)
	Case 'EML' //Email
		//Get from EML file
		inv_pop3.of_get_attach_mime(al_mail_id,as_mail_emlname,ls_attachlist[],ls_mimelist[],ai_type)
		
		//Gen Attachlist
		For i = 1 To UpperBound(ls_attachlist[])
			ls_filename = Mid(ls_attachlist[i],LastPos(ls_attachlist[i],'\') + 1,Len(ls_attachlist[i]))
			is_filename[UpperBound(is_filename[]) + 1] = ls_filename			
			is_fullname[UpperBound(is_fullname[]) + 1] = ls_attachlist[i]	
			of_generate_cleanfile(is_fullname[UpperBound(is_fullname[])],is_filename[UpperBound(is_fullname[])],'EMAIL') 			
		Next
		
		//Copy MIME file
		For i = 1 To UpperBound(ls_mimelist[])
			ls_filename = Mid(ls_mimelist[i],LastPos(ls_mimelist[i],'\') + 1,Len(ls_mimelist[i]))
			FileCopy(ls_mimelist[i],ls_email_dir + '\' + ls_filename,True)			
		Next
	Case 'DOC' //Word
		//download from DB
		inv_pop3.of_download_attachments( al_mail_id, ls_attachlist[], ls_mimelist[],ai_type)
		
		//Gen Attachlist
		For i = 1 To UpperBound(ls_attachlist[])
			ls_filename = Mid(ls_attachlist[i],LastPos(ls_attachlist[i],'\') + 1,Len(ls_attachlist[i]))
			is_filename[UpperBound(is_filename[]) + 1] = ls_filename			
			is_fullname[UpperBound(is_fullname[]) + 1] = ls_attachlist[i]	
			of_generate_cleanfile(is_fullname[UpperBound(is_fullname[])],is_filename[UpperBound(is_fullname[])],'EMAIL') 
		Next
		
		//Copy MIME file
		For i = 1 To UpperBound(ls_mimelist[])
			ls_filename = Mid(ls_mimelist[i],LastPos(ls_mimelist[i],'\') + 1,Len(ls_mimelist[i]))
			FileCopy(ls_mimelist[i],ls_email_dir + '\' + ls_filename,True)
		Next
		
End Choose
of_gen_attachment_name()	
Return 1
end function

public function string of_gen_attachfilename_from_batch (boolean ab_pdf);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_gen_attachfilename_from_batch()
// $<arguments>
//		value	boolean	ab_pdf		
// $<returns> string
// $<description>
// $<description> Gen Batch Add/Create/Imported Attachment Short Name display in sle_attach.text
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i,ll_pos
String ls_FileShortName,ls_FileExt
String ls_attachname
Choose Case Lower(istr_ctx_email.doc_from)
	Case 'ctxs_add','ctxs_create' //batch Add/Create doc to multi-contracts
		ls_FileShortName = Mid(istr_ctx_email.as_batch_file[1],LastPos(istr_ctx_email.as_batch_file[1],'\') + 1)
		ll_pos = LastPos(ls_FileShortName,'.')
		If ll_pos > 0 Then
			ls_FileExt = Mid(ls_FileShortName,LastPos(ls_FileShortName,'.') + 1)
			If Lower(ls_FileExt) = 'doc' or of_is_image2pdf(ls_FileExt) Then
				If ab_pdf Then
					Return Mid(ls_FileShortName, 1, ll_pos) + 'pdf'
				Else
					Return ls_FileShortName
				End If
			Else
				Return ls_FileShortName
			End If
		Else
			Return ls_FileShortName
		End If
	Case 'ctxs_import'  //batch import doc to multi-contracts
		For i = 1 To UpperBound(istr_ctx_email.as_batch_file[])
			ls_FileShortName = Mid(istr_ctx_email.as_batch_file[i],LastPos(istr_ctx_email.as_batch_file[i],'\') + 1) 
			ll_pos = LastPos(ls_FileShortName,'.')
			If ll_pos > 0 Then
				ls_FileExt = Mid(ls_FileShortName,LastPos(ls_FileShortName,'.') + 1)
				If Lower(ls_FileExt) = 'doc' or of_is_image2pdf(ls_FileExt) Then
					If ab_pdf Then
						ls_attachname += Mid(ls_FileShortName, 1, ll_pos) + 'pdf' +'; '
					Else
						ls_attachname += ls_FileShortName + '; '
					End If
				Else
					ls_attachname += ls_FileShortName + '; '
				End If
			Else
				ls_attachname += ls_FileShortName + '; '
			End If			
		Next
		Return Left( ls_attachname, Len(ls_attachname) - 2 )
End Choose

Return ''
end function

public function integer of_gen_attachfile_from_batch (long al_index);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_gen_attachfile_from_batch()
// $<arguments> Long al_index ctx_id index
// $<returns> integer
// $<description>
// $<description> Gen Batch Add/Create/Import Attachment File for Email Attachments
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-07 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_cnt,li_ret
String ls_attachname,ls_convertpdf,ls_cleanfile,ls_convertcleanpdf
n_cst_dm_utils lnv_dm_utils

If Upper(istr_ctx_email.doc_from) <> 'CTXS_ADD' and &
	Upper(istr_ctx_email.doc_from) <> 'CTXS_CREATE' and &
	Upper(istr_ctx_email.doc_from) <> 'CTXS_IMPORT'  Then 
	Return 0
End If

//Use Cache.
If ib_attached_from_batch Then Return 0

If Upper(istr_ctx_email.doc_from) = 'CTXS_CREATE' Then 
	istr_ctx_email.as_batch_file[1] = inv_dm_utils.of_download_file( istr_ctx_email.doc_id_list[al_index] , istr_ctx_email.revision_list[al_index] )
	If Not FileExists(istr_ctx_email.as_batch_file[1]) Then
		Return -1
	End If
End If

ll_cnt =  UpperBound(istr_ctx_email.as_batch_file[])
If ll_cnt = 0 Then Return 0

//Gen files
For i = 1 to ll_cnt
	If cbx_clean.checked Then
		ls_cleanfile = ''
		li_ret = lnv_dm_utils.of_create_clean_doc(istr_ctx_email.as_batch_file[i], ls_cleanfile, String(i)) 
		If li_ret = 0 Then
			ls_cleanfile = istr_ctx_email.as_batch_file[i]
		ElseIf li_ret < 0 Then
			Return -1			
		End If
		If cbx_1.checked Then //PDF
			ls_convertcleanpdf = Mid(ls_cleanfile, 1, LastPos(ls_cleanfile,'.') ) + 'pdf'
			li_ret = lnv_dm_utils.of_convert2pdf(ls_cleanfile, ls_convertcleanpdf)
			If li_ret > 0 Then
				ls_attachname += ls_convertcleanpdf + ','
			ElseIf li_ret = 0 Then
				ls_attachname += ls_cleanfile + ','
			Else
				Return -1
			End If
		Else
			ls_attachname += ls_cleanfile + ','
		End If
	Else
		If cbx_1.checked Then //PDF
			ls_convertpdf = Mid(istr_ctx_email.as_batch_file[i], 1, LastPos(istr_ctx_email.as_batch_file[i],'.') ) + 'pdf'
			li_ret = lnv_dm_utils.of_convert2pdf(istr_ctx_email.as_batch_file[i], ls_convertpdf)
			If li_ret > 0 Then
				ls_attachname += ls_convertpdf + ','
			ElseIf li_ret = 0 Then
				ls_attachname += istr_ctx_email.as_batch_file[i] + ','
			Else
				Return -1
			End If
		Else
			ls_attachname += istr_ctx_email.as_batch_file[i] + ','
		End If
	End If
Next

If Upper(istr_ctx_email.doc_from) = 'CTXS_CREATE' Then 
	ib_attached_from_batch = False
Else
	ib_attached_from_batch = True
End If

is_attach_file_from_batch = Mid(ls_attachname,1,Len(ls_attachname) - 1)


Return 1

end function

public function integer of_create_actionitem (string as_sendto, string as_action_item, long al_doc_id);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_create_actionitem()
// $<arguments>
//		value	string	as_sendto     		
//		value	string	as_action_item		
//		value	long		al_doc_id		//additional document id. from batch add/create document on search tab.
// $<returns> integer
// $<description> Overload. Copy from of_create_actionitem(as_action_item)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//il_doc_id[]: Attached From Document Manager.
//al_doc_id: Added by batch add/create on Search Tab.

Long 		ll_action_type, ll_action_status,ll_Cycle
String 	ls_notes
Date 		ld_today

SetPointer(HourGlass!)

If isnull(il_ctx_id) And UpperBound(istr_ctx_email.ctx_id_list[]) = 0  Then 
	Return 1 //Added By Ken.Guo 2010-04-26.
End If

If isnull(al_doc_id) Then al_doc_id = 0

ld_today = today()

//Added By Ken.Guo 2009-05-20.
If dw_1.GetItemNumber(1, "email_template") > 0 Then
	ls_notes = 'Email Template: ' + dw_1.Describe("Evaluate('LookUpDisplay(email_template) ', 1 )") + ' ~r~n' 
End If

//----------Begin Modified by Alfee 06.12.2007-----------------
If as_sendto <> '' Then 					ls_notes += "To: " + as_sendto + ' ~r~n'
If Trim(sle_1.text) <> '' Then 			ls_notes += "CC: " + Trim(sle_1.text) + ' ~r~n'
If Trim(sle_sendbcc.text) <> '' Then 	ls_notes += "BCC: " + Trim(sle_sendbcc.text) + ' ~r~n'
If Trim(sle_subject.Text) <> '' Then 	ls_notes += 'Subject: ' + Trim(sle_subject.Text) + ' ~r~n' 
If Trim(sle_attach.text)  <> '' Then 	ls_notes += "Attachments: " + Trim(sle_attach.text) + ' ~r~n' 
If Trim(is_web_link)  <> '' Then 		ls_notes += "Web Link: " + Trim(is_web_link) + ' ~r~n' 
//---------End Modified ---------------------------------------

ll_action_type = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Type' and code = 'Email'"))
ll_action_status = Long(gnv_data.of_getItem("code_lookup","lookup_code","lookup_name = 'Contract Action Status' and code = 'Complete'"))

CHOOSE CASE Lower(Trim(as_action_item))
	CASE "parent level"
		If UpperBound(istr_ctx_email.ctx_id_list[]) > 0 And Left(istr_ctx_email.doc_from,4) <> 'CTXS' Then //Added By Ken.Guo 2010-10-26. //Added By Ken.Guo 10/11/2011. Added 'CTXS'
			gnv_appeondb.of_startqueue()
			For ll_Cycle = 1 to UpperBound(istr_ctx_email.ctx_id_list[])
				INSERT INTO ctx_action_items (
								ctx_id, action_type, due_date, wf_assigned_by, 
								active_status, action_status, action_date, inserted_at_date_time, action_user, 
								no_attempts, first_attempt, last_attempt, print_flag,  notes)
					  VALUES (:istr_ctx_email.ctx_id_list[ll_Cycle], :ll_action_type, Null, :gs_user_id,
								 0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 
								1, :ld_today, :ld_today, -1, :ls_notes) ;								
			Next
			gnv_appeondb.of_commitqueue()
		Else
			INSERT INTO ctx_action_items (
							ctx_id, action_type, due_date, wf_assigned_by, 
							active_status, action_status, action_date, inserted_at_date_time, action_user, 
							no_attempts, first_attempt, last_attempt, print_flag,  notes)
				  VALUES (:il_ctx_id, :ll_action_type, Null, :gs_user_id,
							 0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 
							1, :ld_today, :ld_today, -1, :ls_notes) ;			
		End If


		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.08.2009 By: Ken.Guo
		//$<reason>Refresh Action Items Cdata
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select10 = True Then
				w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve()
			End If			
		End If
		//---------------------------- APPEON END ----------------------------
		
	CASE "document manager work flow"
		//---------Added by alfee 04.26.2007 fix a bug--------
		IF UpperBound(il_doc_id[]) < 1 and al_doc_id = 0 Then Return 0 //08.29.2007
		IF UpperBound(il_doc_id[]) = 1 and al_doc_id = 0 Then 
			If IsNull(il_doc_id[1]) or il_doc_id[1] < 1 Then Return 0
		End If
		//-------End Added------------------------------------
		gnv_appeondb.of_startqueue()
		FOR ll_Cycle = 1 TO UpperBound(il_doc_id)
			INSERT INTO ctx_am_action_item(
							doc_id, action_type, due_date, wf_assigned_by,
							active_status, action_status, status_date, create_date, action_user, 
							attempt_times, first_attempt, last_attempt, print_flag, notes)
			  	 VALUES (:il_doc_id[ll_Cycle], :ll_action_type, Null, :gs_user_id,
							0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 					
							1, :ld_today, :ld_today, -1, :ls_notes) ;		
		NEXT
		gnv_appeondb.of_commitqueue()
		
		//Added By Ken.Guo 2010-07-13.
		If al_doc_id > 0 Then
			INSERT INTO ctx_am_action_item(
							doc_id, action_type, due_date, wf_assigned_by,
							active_status, action_status, status_date, create_date, action_user, 
							attempt_times, first_attempt, last_attempt, print_flag, notes)
			  	 VALUES (:al_doc_id, :ll_action_type, Null, :gs_user_id,
							0, :ll_action_status, :ld_today, :ld_today, :gs_user_id, 					
							1, :ld_today, :ld_today, -1, :ls_notes) ;					
		End If
		
		IF SQLCA.Sqlcode <> 0 THEN RETURN -1
		
		//-------Added by alfee 05.04.2007 --------
		//Refresh Document->action item 
		IF IsValid(gw_contract) THEN 
			If w_contract.tab_contract_details.ib_select9 = True Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
			End If
		End If
		//-------End Added------------------------------------
		
END CHOOSE

SetPointer(Arrow!)

RETURN 1
end function

public function integer of_add_attachment (string as_from, string as_fullname[]);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_sendof_add_attachment()
// $<arguments>
//		value	string	as_from      		
//		value	string	as_fullname[]		
// $<returns> integer
// $<description>
// $<description> Add attachment with the files.
//////////////////////////////////////////////////////////////////////
// $<add> 2011-01-25 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Integer li_i
String ls_attachment,ls_filename_temp,ls_fullname_temp,ls_docpath,ls_docname
n_cst_string lnv_string


FOR li_i = 1 to upperbound(as_fullname[])
	
	ls_docname =  Mid(as_fullname[li_i], LastPos(as_fullname[li_i] ,"\") +1 )	
	ls_docpath = Left(as_fullname[li_i], LastPos(as_fullname[li_i] ,"\") -1)		

	//Set fullname variable
	IF Len(Trim(is_attach_file)) > 0 Then
		is_attach_file += "," + as_fullname[li_i]
	ELSE
		is_attach_file = as_fullname[li_i]
	END IF			
	
	//Set filename and fullname array
	ls_filename_temp = ls_docname
	ls_fullname_temp = as_fullname[li_i]
	This.of_check_same_filename( ls_filename_temp, ls_fullname_temp, as_from, True) //Added by Ken.Guo on 2009-03-13
	is_filename[UpperBound(is_filename[]) + 1] = ls_filename_temp
	is_fullname[UpperBound(is_filename[]) + 1] = ls_fullname_temp
	of_generate_cleanfile(ls_fullname_temp,ls_filename_temp,as_from) //Added by Ken.Guo on 2009-03-12
NEXT

This.of_gen_attachment_name( )

Return 1
end function

public function boolean of_check_data ();//Check To
If Not inv_string.of_check_name( sle_sendto.text,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	SetFocus(sle_sendto)	
	Return False
End If

//Check CC
If Not inv_string.of_check_name( sle_1.text,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	SetFocus(sle_1)	
	Return False
End If

//Check Bcc
If Not inv_string.of_check_name( sle_sendbcc.text,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	SetFocus(sle_sendbcc)	
	Return False
End If


Return True
end function

on w_dm_email_document_send.create
int iCurrent
call super::create
this.sle_subject=create sle_subject
this.st_3=create st_3
this.sle_sendto=create sle_sendto
this.sle_attach=create sle_attach
this.cb_ic=create cb_ic
this.cb_outlook=create cb_outlook
this.st_5=create st_5
this.rb_file=create rb_file
this.rb_library=create rb_library
this.rb_document=create rb_document
this.cbx_1=create cbx_1
this.st_4=create st_4
this.st_6=create st_6
this.st_7=create st_7
this.ddlb_item=create ddlb_item
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_clear_attach=create cb_clear_attach
this.st_file=create st_file
this.st_document=create st_document
this.st_library=create st_library
this.pb_file=create pb_file
this.pb_library=create pb_library
this.pb_document=create pb_document
this.rb_ic=create rb_ic
this.rb_oc=create rb_oc
this.sle_sendbcc=create sle_sendbcc
this.cb_sendto=create cb_sendto
this.cb_sendcc=create cb_sendcc
this.cb_sendbcc=create cb_sendbcc
this.cb_resize=create cb_resize
this.cbx_clean=create cbx_clean
this.cb_paste_link=create cb_paste_link
this.st_sending_status=create st_sending_status
this.ole_message=create ole_message
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_subject
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.sle_sendto
this.Control[iCurrent+4]=this.sle_attach
this.Control[iCurrent+5]=this.cb_ic
this.Control[iCurrent+6]=this.cb_outlook
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.rb_file
this.Control[iCurrent+9]=this.rb_library
this.Control[iCurrent+10]=this.rb_document
this.Control[iCurrent+11]=this.cbx_1
this.Control[iCurrent+12]=this.st_4
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.st_7
this.Control[iCurrent+15]=this.ddlb_item
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.dw_1
this.Control[iCurrent+18]=this.cb_clear_attach
this.Control[iCurrent+19]=this.st_file
this.Control[iCurrent+20]=this.st_document
this.Control[iCurrent+21]=this.st_library
this.Control[iCurrent+22]=this.pb_file
this.Control[iCurrent+23]=this.pb_library
this.Control[iCurrent+24]=this.pb_document
this.Control[iCurrent+25]=this.rb_ic
this.Control[iCurrent+26]=this.rb_oc
this.Control[iCurrent+27]=this.sle_sendbcc
this.Control[iCurrent+28]=this.cb_sendto
this.Control[iCurrent+29]=this.cb_sendcc
this.Control[iCurrent+30]=this.cb_sendbcc
this.Control[iCurrent+31]=this.cb_resize
this.Control[iCurrent+32]=this.cbx_clean
this.Control[iCurrent+33]=this.cb_paste_link
this.Control[iCurrent+34]=this.st_sending_status
this.Control[iCurrent+35]=this.ole_message
this.Control[iCurrent+36]=this.gb_2
this.Control[iCurrent+37]=this.gb_3
this.Control[iCurrent+38]=this.gb_4
end on

on w_dm_email_document_send.destroy
call super::destroy
destroy(this.sle_subject)
destroy(this.st_3)
destroy(this.sle_sendto)
destroy(this.sle_attach)
destroy(this.cb_ic)
destroy(this.cb_outlook)
destroy(this.st_5)
destroy(this.rb_file)
destroy(this.rb_library)
destroy(this.rb_document)
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.ddlb_item)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_clear_attach)
destroy(this.st_file)
destroy(this.st_document)
destroy(this.st_library)
destroy(this.pb_file)
destroy(this.pb_library)
destroy(this.pb_document)
destroy(this.rb_ic)
destroy(this.rb_oc)
destroy(this.sle_sendbcc)
destroy(this.cb_sendto)
destroy(this.cb_sendcc)
destroy(this.cb_sendbcc)
destroy(this.cb_resize)
destroy(this.cbx_clean)
destroy(this.cb_paste_link)
destroy(this.st_sending_status)
destroy(this.ole_message)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;Long ll_color
string ls_blind,ls_address

gnv_debug.of_output( false, 'begin open email window. ')	

Post Event postopen() //Added By Ken.Guo 2010-05-24.
of_set_security() //Alfee 11.10.2008
If isvalid(w_ctxs_email_send_result) Then Close(w_ctxs_email_send_result)   //Added By Ken.Guo 2009-05-140
is_email_file_path = gs_dir_path + gs_DefDirName + "\Agreement\Email\"
f_createdirectory(is_email_file_path)

f_SetFileSrv(in_FileSrv,true)				//Added by Scofield on 2009-02-20
ids_EmailAttach = Create DataStore		//Added by Scofield on 2009-02-20

inv_image_cp  = Create n_cst_image_functions_cp  //Alfee 11.21.2008

of_delete_history_files() //Added by Ken.Guo on 2009-03-13
this.of_setresize(true)

this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
this.inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_Register(dw_1, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(sle_sendto, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(sle_1, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(sle_sendbcc, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(sle_subject, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register(gb_4, this.inv_resize.FIXEDRIGHT)
this.inv_resize.of_Register(rb_ic, this.inv_resize.FIXEDRIGHT)
this.inv_resize.of_Register(rb_oc, this.inv_resize.FIXEDRIGHT)

this.inv_resize.of_Register(gb_1, this.inv_resize.SCALERIGHT)
this.inv_resize.of_Register(cb_clear_attach, this.inv_resize.FIXEDRIGHT)
this.inv_resize.of_Register(sle_attach, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register(gb_3, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(ole_message, this.inv_resize.SCALERIGHTBOTTOM)

this.inv_resize.of_Register(gb_2, this.inv_resize.FIXEDBOTTOM)
this.inv_resize.of_Register(st_6, this.inv_resize.FIXEDBOTTOM)
this.inv_resize.of_Register(ddlb_item, this.inv_resize.FIXEDBOTTOM)
this.inv_resize.of_Register(st_7, this.inv_resize.FIXEDBOTTOM)

this.inv_resize.of_Register(cb_resize, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_1, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_2, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(cb_paste_link, this.inv_resize.FIXEDRIGHTBOTTOM)
this.inv_resize.of_Register(st_sending_status, this.inv_resize.FIXEDRIGHTBOTTOM)

gnv_debug.of_output( false, 'open email window. after register resize service.')	

datawindowchild 	ldwc_1

ids_export = Create DataStore

dw_1.Getchild( "email_template", ldwc_1)
ldwc_1.Settransobject( SQLCA )
ldwc_1.Retrieve( )
ldwc_1.Insertrow( 1 )
ldwc_1.SetItem( 1, "email_id", 0)
ldwc_1.SetItem( 1, "email_name", "Blank Email")

dw_1.insertrow(1)
dw_1.SetItem(1, "email_template", 0)

IF isvalid(Message.PowerobjectParm) THEN
	istr_ctx_email = Message.PowerobjectParm
	il_ctx_id = istr_ctx_email.ctx_id
End If

If Upper(istr_ctx_email.doc_from) = 'CTX' or Upper(istr_ctx_email.doc_from) = 'CTX_SEARCH' or Upper(istr_ctx_email.doc_from) = 'DM' Then
	gnv_win_backcolor.of_ChangeWindowBackColor(this) //Add by Evan 11/24/2008 //Modified By Ken.Guo 2010-11-10. Added if statement.
End If

//Add blind flag -- jervis 01.12.2011
Select flag ,blind_flag Into :il_Flag,:ls_blind From security_user_mailsetting Where user_id = :gs_user_id;

gnv_debug.of_output( false, 'open email window. begin open document. ')	
If Upper(istr_ctx_email.doc_from) <> 'EMAIL' Then
	if il_Flag = 1 then
		ole_Message.of_Open(gs_user_id)
		ole_Message.of_inserttextfirst('~r~n~r~n~r~n')
	else
		ole_Message.of_Open()
	end if
	ole_message.object.ActiveDocument.ActiveWindow.Selection.GoTo(1, 1)
	gnv_debug.of_output( false, 'open email window. after opened document. ')	
End If

//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 ISG-CLX--------
////Added By Ken.Guo 2009-11-18. For SE product
//If gnv_data.of_getitem('icred_settings' ,'set_59' , False ) = '1' Then
//	pb_library.visible = False
//	st_library.visible = False
//	pb_document.x = pb_library.x
//	st_document.x = st_library.x
//End If
//---------End Commented ------------------------------------------------------

//BEGIN---Modify by Evan 09/26/2008
Try

	IF isvalid(Message.PowerobjectParm) THEN
		
		//BEGIN---Modify by Scofield on 2009-04-23
		if Not IsNull(istr_ctx_email.EmailTo) and Trim(istr_ctx_email.EmailTo) <> "" then
			sle_SendTo.Text = istr_ctx_email.EmailTo
		end if
		//END---Modify by Scofield on 2009-04-23
		
		//Added by Ken.Guo 2009-03-27
		If istr_ctx_email.is_weblink <> '1' Then
			cb_paste_link.visible = False 
		End If
		
		CHOOSE CASE Upper(istr_ctx_email.doc_from)
			//CASE "CTX" - Alfee 11.30.2007
			CASE "DM","DM_BROWSE"
				If UpperBound(istr_ctx_email.doc_id_list[]) > 0 then
					//il_docid = istr_ctx_email.doc_id //Added By Ken.Guo 2010-04-29.
					il_docid = istr_ctx_email.doc_id_list[1]
					//if istr_ctx_email.revision >= 0 Then
						//If of_save_attachment()	<> -1 Then 
							If istr_ctx_email.is_weblink = '1' Then
								// For Create ActionItems.
								il_doc_id[] = istr_ctx_email.doc_id_list[] 
								//Add web link logic Ken.Guo 2009-03-27
								This.of_gen_web_link()	
								//ole_Message.object.ActiveDocument.Hyperlinks.Add(ole_Message.object.ActiveDocument.ActiveWindow.Selection.Range,is_web_link)
								cb_paste_link.event clicked( )
							Else
								of_add_attachment("attachment")
							End If
						//End If
					//end if
				End If
			//----Begin Added by Alfee 11.30.2007 new requirement----			
				ddlb_item.selectitem(3)
			Case 'CTXS','CTXS_CREATE','CTXS_ADD','CTXS_IMPORT' //From Search DW, and selected multi-rows.
				sle_sendto.text = '<All Selected Contracts, Default To Contact Person>'// --Double clicked to display detail information.'
				sle_sendto.displayonly = False
				sle_sendto.underline = True
				sle_sendto.backcolor = sle_attach.backcolor
				cb_sendto.enabled = False
				pb_document.visible = False
				st_document.visible = False
				sle_sendto.pointer = 'HyperLink!'
				of_add_attachment(istr_ctx_email.doc_from)
				//Post of_retrieve_emails()
			Case 'CLAUSE' //Added By Ken.Guo 2009-12-31.
				ddlb_item.enabled = False
				If istr_ctx_email.doc_id > 0 then
					if istr_ctx_email.revision >= 0 Then
						If of_save_clause_attachment() <> -1 Then 
							of_add_attachment("clause_attachment")
						End If
					end if
				End If
			Case 'EMAIL'

				If istr_ctx_email.as_ctx_id_list = '0' Then istr_ctx_email.as_ctx_id_list = ''
				If istr_ctx_email.as_doc_id_list = '0' Then istr_ctx_email.as_doc_id_list = ''
				
				is_ctx_list = istr_ctx_email.as_ctx_id_list  //means send one email with multi document attachment.
				is_doc_list = istr_ctx_email.as_doc_id_list
				
				//Added By Ken.Guo 2011-03-02. 
				//Set il_ctx_id value when only one CTX, for using Email Template DDDW. 
				If is_ctx_list <> '' and isnumber(is_ctx_list) Then
					il_ctx_id = Long(is_ctx_list)
				Else
					//Added By Ken.Guo 2011-03-02. Comment below script. because user always want to use the email template.
//					//Disable Email template DDDW when used multi CTX,
//					ll_color = sle_attach.backcolor
//					dw_1.Modify("email_template.Background.Color = '"+String(ll_color)+"' ")					
//					dw_1.enabled = False							
				End If
				
				//Added By Ken.Guo 2011-03-02. 
				//Set istr_ctx_email.doc_id_list[] value to Insert Action Items.
				Long i
				String ls_ctx_id_arr[], ls_doc_id_arr[]
				inv_string.of_ParseToArray(is_ctx_list,',',ls_ctx_id_arr[] )
				For i = 1 To UpperBound(ls_ctx_id_arr[])
					istr_ctx_email.ctx_id_list[i] = Long(ls_ctx_id_arr[i])
				Next
				inv_string.of_ParseToArray(is_doc_list,',',ls_doc_id_arr[] )
				For i = 1 To UpperBound(ls_doc_id_arr[])
					istr_ctx_email.doc_id_list[i] = Long(ls_doc_id_arr[i])
				Next	
				il_doc_id[] = istr_ctx_email.doc_id_list[] //For insert action item and audit.
				
				Choose Case Upper(istr_ctx_email.as_mail_reply_mode)
					Case 'REPLY'
						sle_sendto.text = istr_ctx_email.as_mail_from
						If Left(istr_ctx_email.as_mail_subject,3) = 'RE:' or Left(istr_ctx_email.as_mail_subject,3) = 'FW:' Then 
							sle_subject.text = 'RE:' + Mid(istr_ctx_email.as_mail_subject,4,Len(istr_ctx_email.as_mail_subject))
						Else
							sle_subject.text = 'RE: ' + istr_ctx_email.as_mail_subject
						End If		
						This.of_get_email_attach( istr_ctx_email.al_mail_id , istr_ctx_email.as_mail_emlname , istr_ctx_email.as_mail_save_format,2 ) //Get MIME Files for EML. and get all for word file
					Case 'REPLYALL'
						sle_sendto.text = istr_ctx_email.as_mail_from + '; '+ istr_ctx_email.as_mail_to //Need delele myself Email address.
						sle_1.text = istr_ctx_email.as_mail_cc
						If Left(istr_ctx_email.as_mail_subject,3) = 'RE:' or Left(istr_ctx_email.as_mail_subject,3) = 'FW:' Then 
							sle_subject.text = 'RE:' + Mid(istr_ctx_email.as_mail_subject,4,Len(istr_ctx_email.as_mail_subject))
						Else
							sle_subject.text = 'RE: ' + istr_ctx_email.as_mail_subject
						End If
						This.of_get_email_attach( istr_ctx_email.al_mail_id , istr_ctx_email.as_mail_emlname , istr_ctx_email.as_mail_save_format,2 ) //Get MIME Files for EML. and get all for word file
					Case 'FORWARD'
						If Left(istr_ctx_email.as_mail_subject,3) = 'RE:' or Left(istr_ctx_email.as_mail_subject,3) = 'FW:' Then 
							sle_subject.text = 'FW:' + Mid(istr_ctx_email.as_mail_subject,4,Len(istr_ctx_email.as_mail_subject))
						Else
							sle_subject.text = 'FW: ' + istr_ctx_email.as_mail_subject
						End If	
						This.of_get_email_attach( istr_ctx_email.al_mail_id , istr_ctx_email.as_mail_emlname , istr_ctx_email.as_mail_save_format,3 ) //and get all
				End Choose
				
				gnv_debug.of_output( false, 'open new email window. before open document. ')	
				If Upper(istr_ctx_email.as_mail_reply_mode) = 'NEW' Then
					If il_Flag = 1 then
						ole_message.of_open(gs_user_id )
						ole_Message.of_inserttextfirst('~r~n~r~n~r~n')
						gnv_debug.of_output( false, 'open new email window. after open document. include e-signature. ')	
					Else
						ole_message.of_open( )
						gnv_debug.of_output( false, 'open new email window. after open document. ')	
					End If
				Else	
					This.of_open_email()
				End If
				ole_message.object.ActiveDocument.ActiveWindow.Selection.GoTo(1, 1)
			Case 'DOCUMENT_LIBRARY' //Added By Ken.Guo 2011-01-25.
				ddlb_item.enabled = False
				of_add_attachment(istr_ctx_email.doc_from, istr_ctx_email.as_batch_file[] )
			CASE ELSE
				//
		END CHOOSE
	
		If (isnull(il_ctx_id) or il_ctx_id = 0) And UpperBound(istr_ctx_email.ctx_id_list[]) = 0 and Len(is_ctx_list) = 0 Then
			ddlb_item.deleteitem(3)
			ddlb_item.deleteitem(2)
		ElseIf UpperBound(il_doc_id[]) = 0 And UpperBound(istr_ctx_email.doc_id_list[]) = 0	Then
			ddlb_item.deleteitem(3)
		End If
		ddlb_item.selectitem(1)
		
	END IF
Catch(RuntimeError e)
	Messagebox('Error',e.text )
End Try

If (Upper(istr_ctx_email.doc_from) = 'EMAIL' and (Upper(istr_ctx_email.as_mail_reply_mode) = 'REPLY' or Upper(istr_ctx_email.as_mail_reply_mode) = 'REPLYALL' )) Or sle_sendto.text <> '' Then
	ole_message.SetFocus()
	ole_message.object.ActiveDocument.ActiveWindow.SetFocus()
Else
	sle_sendto.Post SetFocus() //Added by Ken.Guo on 2009-01-08
	
	//Add Blind copy myself by default --jervis 1.12.2011
	if ls_blind = '1' then
		ls_address = gnv_data.of_getItem( "security_users", "email_id", "upper(user_id) = '" + upper(gs_user_id) + "'")
		if ls_address <> '' then 
			sle_sendbcc.text = ls_address + ";" + sle_sendbcc.text
		end if
	end if
End If

gnv_debug.of_output( false, 'after open email window. ')	
end event

event close;call super::close;ole_Message.of_Close()

if IsValid(ids_export) then
	Destroy ids_export
end if

IF IsValid(inv_image_cp) THEN Destroy inv_image_cp //alfee 11.21.2008

If isvalid(ids_ctx_default_contacts_email) Then Destroy ids_ctx_default_contacts_email 

f_SetFileSrv(in_FileSrv,false)			//Added by Scofield on 2009-02-20
Destroy ids_EmailAttach						//Added by Scofield on 2009-02-20

end event

event resize;call super::resize;
If IsValid (inv_resize) and This.windowstate <> minimized! Then
	inv_resize.Event pfc_Resize (sizetype, This.WorkSpaceWidth(), This.WorkSpaceHeight())
	
	dw_1.Modify("email_template.Width = " + String(dw_1.Width - 20))
	
	if SizeType = 0 then
		cb_resize.text = '&Maximized'
	elseif SizeType = 2 then
		cb_resize.text = '&Normal'
	end if
End If

end event

event key;call super::key;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-01-05 By: Scofield
//$<Reason> Add Ctrl+Enter ShortCuts to Send email.

if KeyDown(KeyControl!) and KeyDown(KeyEnter!) then
	cb_1.TriggerEvent(Clicked!)
end if
//---------------------------- APPEON END ----------------------------

end event

event activate;call super::activate;
//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

event deactivate;call super::deactivate;//
////Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(ole_message ) Then
//	ole_message.object.activate(false)
//End If
end event

type cb_2 from w_email_subject`cb_2 within w_dm_email_document_send
integer x = 3598
integer y = 2604
integer width = 338
integer height = 84
integer taborder = 250
string text = "C&ancel"
end type

event cb_2::clicked;CloseWithReturn(Parent, -1)
end event

type cb_1 from w_email_subject`cb_1 within w_dm_email_document_send
event ue_send ( )
integer x = 3259
integer y = 2604
integer width = 338
integer height = 84
integer taborder = 240
string text = "&Send"
end type

event cb_1::clicked;
//Added By Ken.Guo 12/02/2011. 
If Not Parent.of_check_data() Then Return 

//Added By Ken.Guo 2011-08-30.  Workaround APB Bug
w_mdi.inv_statusbar.of_setrefreshrate( 0 )
sleep(1)
gb_ShowEmailErrorMessage = True
If Left(istr_ctx_email.doc_from,4) = 'CTXS' Then
	Parent.event ue_send_ctxs( )
Else
	Parent.event ue_send( )
End If
w_mdi.inv_statusbar.of_setrefreshrate( 3 )

/*  Move to Parent.ue_send() Event
long 		ll_Return

n_cst_easymail_smtp 	lnv_Mail
n_cst_dm_utils lnv_dm_utils //Alfee 11.28.2007

IF IsNull(sle_sendto.Text) OR Trim(sle_sendto.Text) = "" THEN
	MessageBox("Email Address required", "Email Address cannot be empty." )
	sle_sendto.SetFocus()
	Return -1
END IF

if lnv_Mail.of_CreateObject() = -1 then
	//Added by Nova.zhang on 2008-11-07
	f_show_message('create Email object','','','','')
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	Return -1
end if

ll_Return = lnv_Mail.of_SendHtml(gs_user_id, sle_sendto.text, sle_1.text, sle_sendbcc.text,sle_subject.text, ole_message, is_attach_file,false)
//END---Modify by Evan 2008-03-24

if ll_Return <> 0 then
	
	//Added by Nova.zhang on 2008-11-07
	f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	lnv_Mail.of_DeleteObject()
	return -1
end if

lnv_Mail.of_DeleteObject()

//Create action item
IF of_create_actionitem(ddlb_item.Text) < 0 THEN
	//MessageBox("Error","Failed to create action item!",StopSign!)	//Alfee 01.10.2008
	MessageBox("Error","Failed to create action item due to ~r~n" + SQLCA.SqlErrText,StopSign!)
	return -1
END IF

If istr_ctx_email.action_type <> 'CheckOut' Then //Added if condition by Ken.Guo 2009-04-13
	//Add audit trail in document manager - Alfee 11.28.2007
	lnv_dm_utils.of_add_audit_trail(il_doc_id)
End If

CloseWithReturn(Parent, 1)
*/

end event

type st_2 from w_email_subject`st_2 within w_dm_email_document_send
boolean visible = false
integer y = 1044
integer width = 311
integer height = 56
string text = "Message"
end type

type mle_1 from w_email_subject`mle_1 within w_dm_email_document_send
boolean visible = false
integer y = 1356
integer width = 2162
integer height = 456
integer taborder = 210
end type

type st_1 from w_email_subject`st_1 within w_dm_email_document_send
boolean visible = false
integer x = 64
integer y = 144
integer width = 311
integer height = 56
string text = "To"
end type

type sle_1 from w_email_subject`sle_1 within w_dm_email_document_send
integer x = 448
integer y = 232
integer width = 2958
integer height = 76
integer taborder = 50
end type

type sle_subject from singlelineedit within w_dm_email_document_send
integer x = 448
integer y = 424
integer width = 2958
integer height = 76
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_dm_email_document_send
integer x = 27
integer y = 432
integer width = 402
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Subject:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_sendto from singlelineedit within w_dm_email_document_send
event lbuttonup pbm_lbuttonup
integer x = 448
integer y = 136
integer width = 2958
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event lbuttonup;//////////////////////////////////////////////////////////////////////
// $<event>lbuttonupsle_sendto()
// $<arguments>
//		value	unsignedlong	flags		
//		value	integer     	xpos 		
//		value	integer     	ypos 		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Blob lb_dw_data
If Left(istr_ctx_email.doc_from,4) = 'CTXS' Then
	If Not isvalid(w_ctxs_email_send_result) Then 
		Open(w_ctxs_email_send_result)
		w_ctxs_email_send_result.Show()
		SetPointer(HourGlass!)
		w_ctxs_email_send_result.dw_1.retrieve(istr_ctx_email.ctx_id_list[])
	End If
	//ids_ctx_default_contacts_email.GetFullState(lb_dw_data)
	//w_ctxs_email_send_result.dw_1.SetFullstate(lb_dw_data)
End If
end event

type sle_attach from singlelineedit within w_dm_email_document_send
event lbuttonup pbm_lbuttonup
integer x = 59
integer y = 676
integer width = 3881
integer height = 84
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean displayonly = true
end type

event lbuttonup;//////////////////////////////////////////////////////////////////////
// Event: lbuttonup()
// Arguments:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2009-04-24
//--------------------------------------------------------------------
// Description: HighLight the attachment's full name.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_text_all,ls_text_before,ls_text_back 
Integer li_pos,li_pos_before,li_pos_back
ls_text_all = sle_attach.text

If ls_text_all = '' Then Return 

li_pos = sle_attach.selectedstart( )
ls_text_before = Left(ls_text_all,li_pos - 1 )
ls_text_back = Mid(ls_text_all,li_pos)

li_pos_before = LastPos(ls_text_before,';')
li_pos_before++

li_pos_back = Pos(ls_text_back,';')
If li_pos_back = 0 Then li_pos_back = Len(ls_text_all)
li_pos_back = len(ls_text_before) + li_pos_back + 1

sle_attach.selecttext(0,0)
sle_attach.selecttext(li_pos_before , li_pos_back - li_pos_before)

end event

type cb_ic from commandbutton within w_dm_email_document_send
boolean visible = false
integer x = 914
integer y = 2416
integer width = 402
integer height = 84
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&IC Contacts "
end type

event clicked;String ls_email, ls_addr
str_pass lstr_pass

//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 2007-04-19 By: Wu ZhiJun
//$<reason> Fix a bug
//lstr_pass.s_string = "All LOCATIONS"
lstr_pass.s_string = "EMail_Send"
//--------------------------- APPEON END -----------------------------
lstr_pass.l_facility_id = -999	//a sign

OpenWithParm ( w_contract_contact, lstr_pass)

ls_email = Message.StringParm
IF f_validstr(trim(ls_email)) THEN
	IF ib_cc THEN
		IF f_validstr(trim(sle_1.Text)) THEN
			If Right(sle_1.Text,1) <> ";" THEN  sle_1.Text += ";"
		END IF
		sle_1.Text += ls_email + ";"
	ELSE
		IF f_validstr(trim(sle_sendto.Text)) THEN
			If Right(sle_sendto.Text,1) <> ";" THEN  sle_sendto.Text += ";"
		END IF
		sle_sendto.Text += ls_email + ";"
	END IF
END IF

end event

type cb_outlook from commandbutton within w_dm_email_document_send
boolean visible = false
integer x = 1317
integer y = 2416
integer width = 462
integer height = 84
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Outlook Contacts"
end type

event clicked;mailSession lmSes
mailReturnCode lmRet
mailMessage lmMsg

Long i

// Create a mail session
lmSes = CREATE mailSession

// Log on to the session
lmRet = lmSes.mailLogon(mailNewSession!)
IF lmRet <> mailReturnSuccess! THEN
    MessageBox("Mail", 'Logging in failed.')
    RETURN
END IF

lmRet = lmSes.mailAddress(lmMsg)
IF lmRet = mailReturnSuccess! THEN
	For i = 1 To UpperBound(lmMsg.recipient)
		IF lmMsg.recipient[i].RecipientType = mailto! THEN
			IF sle_sendto.Text = "" THEN
				sle_sendto.Text = lmMsg.recipient[i].name
			ELSE
				sle_sendto.Text += ";" + lmMsg.recipient[i].name
			END IF
		ELSE
			IF sle_1.Text = "" THEN
				sle_1.Text = lmMsg.recipient[i].name
			ELSE
				sle_1.Text += ";" + lmMsg.recipient[i].name
			END IF
		END IF
	Next
END IF

lmSes.mailLogoff()

DESTROY lmSes

end event

type st_5 from statictext within w_dm_email_document_send
boolean visible = false
integer x = 64
integer y = 244
integer width = 311
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "CC"
boolean focusrectangle = false
end type

type rb_file from radiobutton within w_dm_email_document_send
boolean visible = false
integer x = 59
integer y = 584
integer width = 343
integer height = 64
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "From File"
boolean checked = true
end type

type rb_library from radiobutton within w_dm_email_document_send
boolean visible = false
integer x = 453
integer y = 584
integer width = 645
integer height = 64
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From Document Library"
end type

type rb_document from radiobutton within w_dm_email_document_send
boolean visible = false
integer x = 1271
integer y = 584
integer width = 672
integer height = 64
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "From Document Manager"
end type

type cbx_1 from checkbox within w_dm_email_document_send
integer x = 2441
integer y = 592
integer width = 453
integer height = 64
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Convert to PDF"
end type

event clicked;SetPointer(HourGlass!)
IF This.Checked THEN 
	of_convert_pdf(TRUE)	
ELSE
	of_convert_pdf(FALSE)
END IF
SetPointer(HourGlass!)
of_gen_attachment_name() //Added by Ken.Guo on 2009-03-13
end event

type st_4 from statictext within w_dm_email_document_send
integer x = 27
integer y = 48
integer width = 402
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Template:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_dm_email_document_send
integer x = 64
integer y = 2276
integer width = 178
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Create"
boolean focusrectangle = false
end type

type st_7 from statictext within w_dm_email_document_send
integer x = 1490
integer y = 2620
integer width = 274
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Action Item"
boolean focusrectangle = false
end type

type ddlb_item from dropdownlistbox within w_dm_email_document_send
integer x = 64
integer y = 2612
integer width = 1394
integer height = 348
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "No"
boolean sorted = false
string item[] = {"No","Parent Level","Document Manager Work Flow"}
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_dm_email_document_send
integer x = 18
integer y = 516
integer width = 3954
integer height = 264
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Attachment"
end type

type dw_1 from u_dw within w_dm_email_document_send
integer x = 448
integer y = 28
integer width = 2958
integer height = 88
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_dm_email_template"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;Long 		ll_EMail_Id,ll_Rtn,ll_FieldCnt,i
String  	ls_FullName[],ls_Merge_Before_File,ls_Merge_After_File
Blob		lblb_MsgData
Boolean 	lb_new_export //Alfee 11.23.2007

n_cst_filesrv 			lnv_filesrv
str_dm_email 			lstr_email
n_cst_ovole_utils  	lnv_ole_utils_doc //Alfee 11.23.2007

if Not IsNumber(data) then return

SetPointer(HourGlass!)
ll_EMail_Id = long(data)
il_email_template_id = ll_EMail_Id

IF ll_EMail_Id > 0 THEN
	Parent.of_Get_EmailInfo(ll_EMail_Id, lstr_email)
	Parent.of_Get_EmailMessage(ll_EMail_Id,lblb_MsgData)
	
	//Save attachment in email template to temp dir
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2009-02-20 By: Scofield
	//$<Reason> Attach multiple attachments
	
	long 		ll_Cycle,ll_RowCnts,ll_AttachID
	String	ls_AttachName,ls_FileName
	Blob		lblb_Attach[]
	Boolean lb_exists
	
	//Ken.Guo. Check this email template's attachment whether exists in attachment list.
	For i = 1 to UpperBound(il_email_id[])
		If ll_EMail_Id = il_email_id[i] Then 
			lb_exists = True
			Exit
		End If 
	Next
	If Not lb_exists Then
		ids_EmailAttach.DataObject = "d_Email_Attach"
		ids_EmailAttach.SetTransObject(SQLCA)
		ids_EmailAttach.Retrieve(ll_EMail_Id)
		
		ll_RowCnts = ids_EmailAttach.RowCount()
		for ll_Cycle = 1 to ll_RowCnts
			ls_AttachName = ids_EmailAttach.GetItemString(ll_Cycle,"attach_name")
			ll_AttachID = ids_EmailAttach.GetItemNumber(ll_Cycle,"attach_id")
			
			of_GetEmailAttachment(ll_EMail_Id,ll_AttachID,lblb_Attach[UpperBound(lblb_Attach) + 1])
			
			if Len(lblb_Attach[UpperBound(lblb_Attach)]) > 0 then
				ls_FileName = gs_dir_path + gs_DefDirName + "\" + ls_AttachName
				in_FileSrv.of_FileWrite(ls_FileName, lblb_Attach[UpperBound(lblb_Attach)],false)
				
				/* Commented By Ken.Guo 2009-04-21
				if Len(Trim(sle_attach.text)) > 0 then sle_attach.text += ","
				sle_attach.text += ls_AttachName
				
				IF Len(Trim(is_attach_file)) > 0 Then is_attach_file += ","
				is_attach_file += ls_FileName
				*/
				is_filename[UpperBound(is_filename) + 1] = ls_AttachName
				is_fullname[UpperBound(is_fullname) + 1] = ls_FileName
				of_generate_cleanfile(is_fullname[UpperBound(is_fullname)],is_filename[UpperBound(is_filename)],'Email_Painter') //Added by Ken.Guo on 2009-03-12
			end if
		next
	
		//Added by Ken.Guo on 2009-03-13
		If cbx_clean.checked Then
			is_fullname[] = is_fullname_clean[]
			is_filename[] =  is_filename_clean[]
		End If		
			
		//Convert to PDF
		IF cbx_1.Checked THEN of_convert_pdf(TRUE)
	
		//Added by Ken.Guo on 2009-03-13
		of_gen_attachment_name() 
	End If
END IF
il_email_id[UpperBound(il_email_id) + 1] = ll_EMail_Id //Added by Ken.Guo on 2009-04-21




ole_Message.SetRedraw(FALSE)

//Set message with the email template and signature
ole_Message.of_Close()
if il_Flag = 1 then
	ole_Message.of_Open(gs_user_id)
	ole_Message.of_insertfilefirst(lblb_MsgData)
else
	ole_Message.of_Open(lblb_MsgData)
end if

//-----------Begin Modified by Alfee 11.23.2007-----------------------------------
IF ole_Message.Object.Doctype <> 1 THEN 
	ole_Message.SetRedraw(TRUE) 
	RETURN 
END IF

n_cst_word_utility lnv_word
lnv_word = Create n_cst_word_utility

//Begin - Modified By Ken.Guo 2010-12-21
//lnv_word.il_doc_id = istr_ctx_email.doc_id	//Added by Scofield on 2009-07-22
If UpperBound(istr_ctx_email.doc_id_list[]) > 0 Then
	lnv_word.il_doc_id = istr_ctx_email.doc_id_list[1]
Else
	lnv_word.il_doc_id = 0
End If
//End - Modified By Ken.Guo 2010-12-21

If Left(istr_ctx_email.doc_from,4) <> 'CTXS' Then   	//Added If condition By Ken.Guo 2009-05-13.
	If Upper(istr_ctx_email.doc_from) = 'DM' and isvalid(gw_contract) THEN 
		lnv_ole_utils_doc	= gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
	ElseIf Upper(istr_ctx_email.doc_from) = 'DM_BROWSE' and isvalid(w_documents_browse) Then
		lnv_ole_utils_doc	= w_documents_browse.uo_1.inv_ole_utils_doc
	End If	
	
	//Replace the fields with exported data in document
	lb_new_export = ( il_exportid_last <> il_export_id OR il_ctxid_last <> il_ctx_id ) //for performance tuning
	IF lb_new_export Then

		IF isvalid(lnv_ole_utils_doc) THEN 
			lb_new_export = lnv_ole_utils_doc.of_is_newexp(il_ctx_id, il_export_id,"", ids_export)	
			IF NOT lb_new_export THEN
				il_exportid_last = il_export_id 
				il_ctxid_last = il_ctx_id		
			END IF
		End If
	END IF
	//Add subject-jervis 09.09.2009
	//ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument, il_ctx_id, il_export_id, ids_export, lb_new_export)
	//---------Begin Added by (Appeon)Harry 03.03.2016 for bug_id#5021--------
	if il_docid > 0 then
		str_action_item lstr_action_item
		lstr_action_item.doc_id = il_docid
		lstr_action_item.module = '04'
		lnv_word.of_set_str_action_item(lstr_action_item)  
	end if
	//---------End Added ------------------------------------------------------
	ll_rtn = lnv_word.of_replace_export_word(ole_Message.Object.ActiveDocument, lstr_email.subject,il_ctx_id, il_export_id, ids_export, lb_new_export)
	
	//Reset the variables for performance tuning
	IF lb_new_export and ll_rtn > 0 THEN 
		il_exportid_last = il_export_id 
		il_ctxid_last = il_ctx_id
//		IF isvalid(gw_contract) THEN
//			lnv_ole_utils_doc	= gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
			IF isvalid(lnv_ole_utils_doc) THEN 
				lnv_ole_utils_doc.of_set_expinfo(il_ctx_id, il_export_id,"")		
			End If
//		END IF
	End If
End If

//Reset other email fields from template
sle_subject.text = lstr_email.subject

IF IsValid(lnv_word) THEN Destroy lnv_word

ole_Message.SetRedraw(TRUE)

end event

event itemerror;//override - alfee 10.15.2008
end event

event dberror;//override - Alfee 10.15.2008
end event

type cb_clear_attach from commandbutton within w_dm_email_document_send
integer x = 3570
integer y = 580
integer width = 357
integer height = 84
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&lear Attach"
end type

event clicked;String 	ls_temp[]
Long 		ll_temp[]

If sle_attach.text = "" Then Return
If Messagebox('IntelliSoft','Are you sure you want to delete the attachment(s)?',Question!,YesNo!) = 2 Then Return

//clear attachment field
sle_attach.text = ""

//Initilize variables
is_attach_file = ""
is_fullname[] = ls_temp[]
is_filename[] = ls_temp[]

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-05-19 By: Ken.Guo
//$<reason> For create action Item.
//il_doc_id = ll_temp
If istr_ctx_email.is_weblink = '1' Then
	il_doc_id[1] = istr_ctx_email.doc_id 
Else
	il_doc_id = ll_temp
End If
//---------------------------- APPEON END ----------------------------

is_fullname_convert[] = ls_temp[]
is_filename_convert[] = ls_temp[]

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-03-13 By: Ken.Guo
//$<reason> Reset var
is_fullname_clean[]   = ls_temp[]
is_filename_clean[]  = ls_temp[] 
is_fullname_org[]  = ls_temp[]
is_filename_org[]  = ls_temp[]
is_fullname_convert_clean[]  = ls_temp[]
is_filename_convert_clean[]  = ls_temp[]
is_fullname_convert_org[]  = ls_temp[]
is_filename_convert_org[]  = ls_temp[]
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2010-07-05.
istr_ctx_email.as_batch_file[] = ls_temp[]
is_attach_file_from_batch = ''
ib_attached_from_batch = False 

is_ctx_list = ''
is_doc_list = ''
end event

type st_file from statictext within w_dm_email_document_send
integer x = 197
integer y = 592
integer width = 242
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From File"
boolean focusrectangle = false
end type

type st_document from statictext within w_dm_email_document_send
integer x = 1408
integer y = 592
integer width = 626
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From Document Manager"
boolean focusrectangle = false
end type

type st_library from statictext within w_dm_email_document_send
integer x = 654
integer y = 592
integer width = 571
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From Document Library"
boolean focusrectangle = false
end type

type pb_file from picturebutton within w_dm_email_document_send
integer x = 55
integer y = 576
integer width = 114
integer height = 92
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Custom050!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;of_add_attachment('file')
end event

type pb_library from picturebutton within w_dm_email_document_send
integer x = 512
integer y = 576
integer width = 114
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "org.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;of_add_attachment('library')
end event

type pb_document from picturebutton within w_dm_email_document_send
integer x = 1271
integer y = 576
integer width = 114
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "Custom083!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;of_add_attachment('document')
end event

type rb_ic from radiobutton within w_dm_email_document_send
integer x = 3433
integer y = 160
integer width = 366
integer height = 64
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "IC Contacts "
boolean checked = true
end type

type rb_oc from radiobutton within w_dm_email_document_send
integer x = 3433
integer y = 268
integer width = 530
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Outlook Contacts"
end type

type sle_sendbcc from singlelineedit within w_dm_email_document_send
integer x = 448
integer y = 328
integer width = 2958
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_sendto from commandbutton within w_dm_email_document_send
integer x = 27
integer y = 132
integer width = 402
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&To..."
end type

event clicked;if rb_ic.Checked then
	of_SelICContacts(1)
elseif rb_oc.Checked then
	of_SelOCContacts()
end if

end event

type cb_sendcc from commandbutton within w_dm_email_document_send
integer x = 27
integer y = 228
integer width = 402
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cc..."
end type

event clicked;if rb_ic.Checked then
	of_SelICContacts(2)
elseif rb_oc.Checked then
	of_SelOCContacts()
end if

end event

type cb_sendbcc from commandbutton within w_dm_email_document_send
integer x = 27
integer y = 324
integer width = 402
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Bcc..."
end type

event clicked;if rb_ic.Checked then
	of_SelICContacts(3)
elseif rb_oc.Checked then
	of_SelOCContacts()
end if

end event

type cb_resize from commandbutton within w_dm_email_document_send
integer x = 2921
integer y = 2604
integer width = 338
integer height = 84
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Maximized"
end type

event clicked;if parent.windowstate = maximized! then
	parent.windowstate = normal!
else
	parent.windowstate = maximized!
end if

end event

type cbx_clean from checkbox within w_dm_email_document_send
integer x = 2907
integer y = 592
integer width = 571
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Create Clean Version"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cbx_clean::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)
Post of_create_clean_version()

end event

type cb_paste_link from commandbutton within w_dm_email_document_send
integer x = 2491
integer y = 2604
integer width = 425
integer height = 84
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Paste Web Link"
end type

event clicked;Try 
	ole_Message.object.ActiveDocument.Hyperlinks.Add(ole_Message.object.ActiveDocument.ActiveWindow.Selection.Range,is_web_link)
	ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText(" ")
Catch(throwable th)
End Try
end event

type st_sending_status from statictext within w_dm_email_document_send
integer x = 1838
integer y = 2620
integer width = 599
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217859
long backcolor = 33551856
boolean focusrectangle = false
end type

type ole_message from u_email_edit within w_dm_email_document_send
integer x = 37
integer y = 852
integer width = 3913
integer height = 1688
integer taborder = 210
boolean bringtotop = true
borderstyle borderstyle = stylebox!
string binarykey = "w_dm_email_document_send.win"
end type

type gb_2 from groupbox within w_dm_email_document_send
integer x = 18
integer y = 2552
integer width = 1792
integer height = 156
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Action Item"
end type

type gb_3 from groupbox within w_dm_email_document_send
integer x = 18
integer y = 796
integer width = 3959
integer height = 1760
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Message"
end type

type gb_4 from groupbox within w_dm_email_document_send
integer x = 3419
integer y = 8
integer width = 549
integer height = 496
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Contacts"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cw_dm_email_document_send.bin 
2100000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000013ad623001d17e9200000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000013ad623001d17e9213ad623001d17e920000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000587800002b9d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000587800002b9d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cw_dm_email_document_send.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
