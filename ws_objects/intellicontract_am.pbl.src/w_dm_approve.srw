$PBExportHeader$w_dm_approve.srw
forward
global type w_dm_approve from w_response
end type
type ole_message from u_email_edit within w_dm_approve
end type
type cb_tutorials from commandbutton within w_dm_approve
end type
type dw_doc from u_dw within w_dm_approve
end type
type st_info from statictext within w_dm_approve
end type
type cb_cancel from commandbutton within w_dm_approve
end type
type cb_ok from commandbutton within w_dm_approve
end type
type dw_1 from u_dw within w_dm_approve
end type
end forward

global type w_dm_approve from w_response
integer x = 214
integer y = 221
integer width = 2889
integer height = 2004
string title = "Check Out - Send for Approval"
long backcolor = 33551856
ole_message ole_message
cb_tutorials cb_tutorials
dw_doc dw_doc
st_info st_info
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_dm_approve w_dm_approve

type variables
str_ctx_email istr_ctx_email
n_cst_dm_utils inv_dm_utils
Datawindowchild idwc_email_template
Long il_last_export_id
n_ds ids_export, ids_email_userid,ids_EmailAttach, ids_action_items, ids_webapprove
n_cst_filesrvwin32 inv_filesrv
n_cst_string inv_string
String is_web_link,is_user_email,is_weblink_root,is_cache_name
String is_attach_file
n_cst_ctx_mail inv_ctx_mail
Int wdFindStop = 0
Int wdReplaceNone = 0


Blob iblb_email_message
Long il_approve_id 
String is_email_weblinkkey = '~r~n~r~nPlease click the following URL:  '
String is_email_message
String is_template_message
end variables

forward prototypes
public function integer of_check_data ()
public function integer of_set_message (long al_email_id)
public subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list)
public function integer of_create_action_items ()
public function string of_getuserid (string as_emailaddress)
public function integer of_merge_message ()
public function integer of_getemailattach (ref string as_attachname[], ref blob ablb_attachdata[])
public function integer of_gen_web_link (string as_email_address, string as_userid, integer ai_user_order)
public subroutine of_set_document ()
public subroutine of_auto_add_approve_field ()
public function integer of_setcheckoutstatus ()
end prototypes

public function integer of_check_data ();String ls_first_approver,ls_second_approver
String ls_first_createai_users, ls_second_createai_users
String ls_approverlist[], ls_temp,ls_approverlist2[]
Long ll_cnt,i,j

//Check first_approver whether is empty
ls_first_approver = dw_1.GetItemString(1,'first_approver')
If ls_first_approver = '' or isnull(ls_first_approver) Then
	Messagebox('Email','Please input the first approvers email address.')
	dw_1.SetColumn('first_approver')
	dw_1.SetFocus()
	Return -1
End If

//Check 1st 
If Not inv_string.of_check_name(ls_first_approver,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('first_approver')
	dw_1.SetFocus()
	Return -2
End If

//Check 2nd
If Not inv_string.of_check_name(ls_second_approver,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
	dw_1.SetColumn('second_approver')
	dw_1.SetFocus()
	Return -3
End If

//Check duplicate data 
ls_second_approver = dw_1.GetItemString(1,'second_approver')
inv_string.of_parsetoarray( ls_first_approver, ';', ls_approverlist[])
inv_string.of_parsetoarray( ls_second_approver, ';', ls_approverlist2[])
For i = 1 To UpperBound(ls_approverlist2[])
	For j = 1 To UpperBound(ls_approverlist[])
		If Trim(Lower(ls_approverlist2[i])) = Trim(Lower(ls_approverlist[j])) Then
			Messagebox('Email','The email address "'+ls_approverlist2[i]+'" can~’t be both the first approver and the second approver. ')
			dw_1.SetColumn('second_approver')
			dw_1.SetFocus()			
			Return -4
		End If
	Next
Next

//Check duplicate data for 1st approvers
For i = 1 To UpperBound(ls_approverlist[])
	For j = 1 To UpperBound(ls_approverlist[])
		If i = j then Continue
		//---------Begin Modified by (Appeon)Harry 04.16.2014 for V142 ISG-CLX--------
		//If ls_approverlist[i] = ls_approverlist[j] Then
		If Trim(Lower(ls_approverlist[i])) = Trim(Lower(ls_approverlist[j])) Then
		//---------End Modfiied ------------------------------------------------------
			Messagebox('Email','The email address "'+ls_approverlist[i]+'" can~’t be duplicate. ')
			dw_1.SetColumn('first_approver')
			dw_1.SetFocus()	
			Return -5
		End If
	Next
Next

//Check duplicate data for 2nd approvers
For i = 1 To UpperBound(ls_approverlist2[])
	For j = 1 To UpperBound(ls_approverlist2[])
		If i = j then Continue
		//---------Begin Modified by (Appeon)Harry 04.16.2014 for V142 ISG-CLX--------
		//If ls_approverlist2[i] = ls_approverlist2[j] Then
		If Trim(Lower(ls_approverlist2[i])) = Trim(Lower(ls_approverlist2[j])) Then
		//---------End Modfiied ------------------------------------------------------
			Messagebox('Email','The email address "'+ls_approverlist2[i]+'" can~’t be duplicate. ')
			dw_1.SetColumn('second_approver')
			dw_1.SetFocus()
			Return -6
		End If
	Next
Next

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

public subroutine of_update_email_list (string as_column_name, string as_old_email_list, string as_new_email_list);Long i,j
String ls_arr_old[],ls_arr_new[],ls_new_userlist,ls_mailto

If isnull(as_old_email_list) Then as_old_email_list = ''
If isnull(as_new_email_list) Then as_new_email_list = ''

inv_string.of_parsetoarray( as_old_email_list, ';', ls_arr_old[] ) 
inv_string.of_parsetoarray( as_new_email_list, ';', ls_arr_new[] )

ls_mailto = as_old_email_list

If as_new_email_list = '' Then Return

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


Return 
end subroutine

public function integer of_create_action_items ();Integer li_creatai
String ls_notify_users
Datetime ldt_duedate

//create action items for 1st approvers
ls_notify_users = dw_1.GetItemString(1,'create_ai_list')
li_creatai = dw_1.GetItemNumber(1, 'create_action_item')
ldt_duedate = dw_1.GetItemDatetime(1,'due_date')
Return gnv_webapprove.of_create_action_items(il_approve_id,istr_ctx_email, ls_notify_users, 1,li_creatai,ldt_duedate )


end function

public function string of_getuserid (string as_emailaddress);Long ll_find
String ls_userid, ls_userlist

ls_userlist = dw_1.GetItemString(1,'create_ai_list') 

ll_find = ids_email_userid.Find('Lower(email_id) = Lower("' + as_emailaddress + '")', 1, ids_email_userid.RowCount()) 

If ll_find > 0 Then
	ls_userid = ids_email_userid.GetitemString(ll_find, 'user_id')
	If Pos(';' + Lower(ls_userlist) + ';', ';' +  Lower(ls_userid) + ';') > 0 Then
		Return ls_userid
	End If
End If

Return ''



end function

public function integer of_merge_message ();//Return gnv_webapprove.of_merge_message(ole_message, is_web_link)

Return 1

end function

public function integer of_getemailattach (ref string as_attachname[], ref blob ablb_attachdata[]);////////////////////////////////////////////////////////////////////////
//// Function: of_getemailattach
//// Arguments:
//// 	
////--------------------------------------------------------------------
//// Return:  integer
////--------------------------------------------------------------------
//// Author:	 Ken.Guo 11/17/2011.
////--------------------------------------------------------------------
//// Description: Upload Email Attachments to DB for email again feature.
////--------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
//
//String ls_attachlist[]
//Long i
//Blob lblb_data
//
//If is_attach_file = '' Then Return 056
//
//inv_string.of_parsetoarray(is_attach_file, ',', ls_attachlist[])
//
//If UpperBound(ls_attachlist[]) = 0 Then Return 0
//	
//For i = 1 To UpperBound(ls_attachlist[]) 
//	If Not FileExists(ls_attachlist[i]) Then Continue
//	as_attachname[UpperBound(as_attachname[]) + 1] = Mid(ls_attachlist[i], Lastpos(ls_attachlist[i], '\') + 1)
//	SetNull(lblb_data)
//	inv_dm_utils.of_readblob(ls_attachlist[i], lblb_data)
//	ablb_attachdata[UpperBound(ablb_attachdata[]) + 1] = lblb_data
//Next
//
//If UpperBound(as_attachname[]) = 0 Then Return -1
//
Return 1
end function

public function integer of_gen_web_link (string as_email_address, string as_userid, integer ai_user_order);//ctx_am_image_approve.flag : 1. wating approval 2. complete. 
//ctx_am_image_approve_detail.flag : 1. wating approval 2. approved. 0 Not started. 

String ls_weblink_name,ls_ie_url, ls_notify_emails,ls_notify_emails2,ls_notify_users2
String ls_file_name, ls_approve_type, ls_notify_users, ls_subject, ls_attachnamelist[]
Integer i, li_signature,j
Long ll_check_sn, ll_check_ret
Long ll_file_size
Blob lb_file_image
String ls_ctx_link,ls_email_message
String ls_file_type_des
Blob lb_attachdatalist[]
integer li_flag

String		ls_AppointmentList, ls_AppointmentList2, ls_Appointment

n_cst_dm_utils lnv_file_dm

SetPointer(HourGlass!)

//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
as_email_address =  trim(as_email_address)//(Appeon)Toney 11.07.2013 - V141 ISG-CLX,Fix BugT101702
//---------End Added ------------------------------------------------------

//If not exists in database, generate it from current URL
If isnull(is_weblink_root) or is_weblink_root = '' Then
	ls_ie_url = AppeonGetIEURL() //AppeonGetIEURL() will return the current web root URL, e.g. 'http://192.0.3.37/test_ken/'
	//Begin - Modified By Ken.Guo 03/26/2013
//		ls_weblink_name = ls_ie_url + 'fileservice/approvedoc.aspx'
//		If left(lower(ls_ie_url),7) = 'http://' Then
//			ls_ie_url = 'http://' + Mid(ls_ie_url,8,len(ls_ie_url))
//		ElseIf left(lower(ls_ie_url),8) = 'https://' Then
//			ls_ie_url = 'https://' + Mid(ls_ie_url,9,len(ls_ie_url))
//		End If
		//AppeonGetIEURL() will return the current web root URL, e.g. 'http://192.0.3.37/test_ken/'
		ls_ie_url = Mid(ls_ie_url,1,Len(ls_ie_url) - 1) //Cut last '/'
		ls_weblink_name = Mid(ls_ie_url,1,LastPos(ls_ie_url,'/'))
		ls_weblink_name = ls_weblink_name + 'fileservice/approvedoc.aspx'
	//End - Modified By Ken.Guo 03/26/2013
Else
	If Right(is_weblink_root,1) = '/' Then
		ls_weblink_name = is_weblink_root + 'approvedoc.aspx'
	Else
		ls_weblink_name = is_weblink_root + '/approvedoc.aspx'
	End If
End If

If isnull(is_cache_name) or is_cache_name = '' Then
	If gs_cachename <> '' Then
		is_cache_name = gs_cachename
	Else
		//Failed to get cache name/database name.
		Messagebox('IntelliSoft Error -1','Failed to get cache name, please call support.')  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoft"
		is_web_link = ''
		Return -1
	End If
End If

//Gen check SN
For i = 1 To Len(is_cache_name)
	ll_check_sn += Asc(Mid(Lower(is_cache_name),i,1))
Next
For i = 1 To Len(as_email_address)
	ll_check_sn += Asc(Mid(Lower(as_email_address),i,1))
Next
ll_check_sn += il_approve_id + Mod(il_approve_id,9) * il_approve_id

ls_notify_emails = dw_1.GetItemString(1,'first_approver')
ls_notify_users = dw_1.GetItemString(1,'create_ai_list')
ls_notify_emails2 = dw_1.GetItemString(1,'second_approver')
ls_notify_users2 = dw_1.GetItemString(1,'create_ai_list2')

ls_AppointmentList = dw_1.GetItemString( 1, 'alm_appointment' ) //added by gavins 20121026
ls_AppointmentList2= dw_1.GetItemString( 1, 'alm_appointment2' ) //added by gavins 20121026
//Gen Web Link
ls_weblink_name = ls_weblink_name + '?dbname=' + lower(is_cache_name)  + '&approveid=' + String(il_approve_id) + &
						+ '&email=' + as_email_address + '&ck=' + String(ll_check_sn) + ' 	'

ls_email_message = is_template_message + is_email_weblinkkey +'~r~n'+ ls_weblink_name + '~r~n'

If ai_user_order = 1 Then
	li_flag = 1 //started
ElseIf ai_user_order = 2 Then
	li_flag = 0 //not start
End If

For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
		
	//Gen CTX Link
	If gs_cachename <> '' Then
		ls_ctx_link = AppeonGetIEURL() + '?' + gs_cachename + '&' + String(istr_ctx_email.ctx_id_list[i] ) + '&91&'    + String(istr_ctx_email.doc_id_list[i] )
	Else
		ls_ctx_link = AppeonGetIEURL() + '?' + '&' + String(istr_ctx_email.ctx_id_list[i]) + '&91&'  +   String(istr_ctx_email.doc_id_list[i])	 
	End If
	
	If is_web_link = '' Then //Means it added the main record.
		//Get file name. include version info
		//ls_file_name = gf_merge_file_name(istr_ctx_email.filename_list[i] ,istr_ctx_email.doc_ext_list[i],istr_ctx_email.doc_id_list[i],istr_ctx_email.revision_list[i])
		ls_file_name = istr_ctx_email.fullfilename_list[i]
		ls_file_type_des = inv_filesrv.of_getfiletypedes(ls_file_name)
		
		of_getemailattach(ls_attachnamelist[],lb_attachdatalist[])
		
		gnv_appeondb.of_startqueue( )
			//Delete existed record
			Delete From ctx_am_image_approve_detail Where doc_id = :istr_ctx_email.doc_id_list[i] and revision = :istr_ctx_email.revision_list[i] ;
			Delete From ctx_am_image_approve Where doc_id = :istr_ctx_email.doc_id_list[i] and revision = :istr_ctx_email.revision_list[i] ;
//			Delete From ctx_am_image_approve_email_attach Where doc_id = :istr_ctx_email.doc_id_list[i] and revision = :istr_ctx_email.revision_list[i] ;
		
			//Insert record
			Insert Into ctx_am_image_approve(approve_id,ctx_id,doc_id,revision,Approve_type,file_name,file_type,sender_user,notify_users,notify_emails,notify_users2,notify_emails2,sender_email,email_subject,email_signature, sent_time,replied_email,flag,ctx_link_name) 
				Values(:il_approve_id,:istr_ctx_email.ctx_id_list[i],:istr_ctx_email.doc_id_list[i],:istr_ctx_email.revision_list[i],:ls_approve_type,:ls_file_name,:ls_file_type_des , :gs_user_id,:ls_notify_users,:ls_notify_emails,:ls_notify_users2,:ls_notify_emails2,:is_user_email,:ls_subject, :li_signature,getdate(),0,1,:ls_ctx_link);
			
			//Update blob Data to DB  modified by gavins 20121026
			Update ctx_am_image_approve set Org_Image_file = a.image_file,file_size = dataLength(a.image_file),new_file = 1 , alm_appointment = :ls_AppointmentList from ctx_am_doc_image a 
				where a.doc_id = ctx_am_image_approve.doc_id and a.revision = ctx_am_image_approve.revision
				and a.doc_id = :istr_ctx_email.doc_id_list[i] and a.revision = :istr_ctx_email.revision_list[i] ;
				
			//Check whether successfully	
			Select file_size	into :ll_check_ret from ctx_am_image_approve where doc_id = :istr_ctx_email.doc_id_list[i] and revision = :istr_ctx_email.revision_list[i] ;
	
			//Save Email Message
//			UpdateBlob  ctx_am_image_approve set email_message = :iblb_email_message Where  doc_id = :istr_ctx_email.doc_id_list[i] and revision = :istr_ctx_email.revision_list[i] ;
	
		gnv_appeondb.of_commitqueue( )
		
		If isnull(ll_check_ret) or ll_check_ret <= 0 Then
			MessageBox('Web Approve Error -1','Failed to generate the data. '+sqlca.sqlerrtext)
			RETURN -2
		END IF
	End If
	ls_Appointment = '' 
	If ai_user_order = 1 Then ///added by gavins 20121031
		If Pos( ls_AppointmentList, as_email_address ) > 0 Then ls_Appointment = as_email_address
	Else
		If Pos( ls_AppointmentList2, as_email_address ) > 0 Then ls_Appointment = as_email_address
	End If
	
	//Insert detail data.
	Insert into ctx_am_image_approve_detail(approve_id,Doc_id,Revision,email_address,email_message,web_link_name,user_id, user_order,sent_time, flag, alm_appointment )
	Values(:il_approve_id,:istr_ctx_email.doc_id_list[i],:istr_ctx_email.revision_list[i] ,:as_email_address,:ls_email_message,:ls_weblink_name,:as_userid,:ai_user_order, getdate(),:li_flag, :ls_Appointment) ;
	
	IF SQLCA.SQLCODE <> 0 THEN 
		MessageBox('Web Approve Error -2','Failed to generate the data. '+sqlca.sqlerrtext)
		RETURN -2
	END IF
Next

////Save Email's Attachment
//If ai_user_order = 1 Then
//	of_getemailattach(ls_attachnamelist[],lb_attachdatalist[])
//	For j = 1 To UpperBound(ls_attachnamelist[])
//		Insert Into ctx_am_image_approve_email_attach(approve_id, seq_no, attach_name) Values(:il_approve_id,:i, :ls_attachnamelist[i]) ;
//		UpdateBlob  ctx_am_image_approve_email_attach Set attach_image = :lb_attachdatalist[j] Where approve_id = :il_approve_id and seq_no = :i ;
//	Next
//End If


//Return WEB Link
is_web_link = ls_weblink_name
is_email_message = ls_email_message



Return 1

end function

public subroutine of_set_document ();Long i,ll_row
For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
	ll_row = dw_doc.InsertRow(0)
	dw_doc.SetItem(ll_row,'docname',istr_ctx_email.fullfilename_list[i])
	dw_doc.SetItem(ll_row,'ctx_id',istr_ctx_email.ctx_id_list[i])
	dw_doc.SetItem(ll_row,'doc_id',istr_ctx_email.doc_id_list[i])
	dw_doc.SetItem(ll_row,'revision',istr_ctx_email.revision_list[i])
Next
end subroutine

public subroutine of_auto_add_approve_field ();////Check Web Approve Link exists.  $<WebApproveDoc>$
//If ole_message.object.doctype = 1 Then 
//	ole_message.Object.ActiveDocument.Content.Select()
//	If Not ole_message.Object.ActiveDocument.ActiveWindow.Selection.Find.Execute(is_approve_var, false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone)  Then
//		ole_message.Object.ActiveDocument.ActiveWindow.Selection.Start = ole_message.Object.ActiveDocument.ActiveWindow.Selection.End
//		ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText('~r~nPlease click the following web link to approve the document: ~r~n')
//		ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText(is_approve_var)
//	End If
//End If
end subroutine

public function integer of_setcheckoutstatus ();//////////////////////////////////////////////////////////////////////
// Function: of_setcheckoutstatus
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 12/07/2011.
//--------------------------------------------------------------------
// Description: Set check out status of documents.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long i,ll_find,ll_row
Datetime ldt_now
ldt_now = datetime(today() , Now())

n_ds lds_am_document_update
lds_am_document_update = Create n_ds
lds_am_document_update.dataobject = 'd_am_checkout_sertifi_update'
lds_am_document_update.SetTransObject(SQLCA)

lds_am_document_update.Retrieve(istr_ctx_email.doc_id_list[])
If lds_am_document_update.rowcount() = 0 Then
	Messagebox('Error -1','Failed to modify the check out status of document, please calll support.')
	Return -1
End If

For i = 1 To UpperBound(istr_ctx_email.doc_id_list[])
	ll_find = lds_am_document_update.Find('doc_id = ' + String(istr_ctx_email.doc_id_list[i]), 1, lds_am_document_update.RowCount() )
	If ll_find > 0 Then
		lds_am_document_update.SetItem(ll_find, 'checkout_status','7')
		lds_am_document_update.SetItem(ll_find, 'checkout_date',today())
		lds_am_document_update.SetItem(ll_find, 'checkout_by',gs_user_id)
		lds_am_document_update.SetItem(ll_find, 'approve_id', il_approve_id)
	End If
Next

If lds_am_document_update.Update() <> 1 Then
	Messagebox('Error -2','Failed to modify the check out status of document, please calll support.')
	Return -2
End If

Return 1


end function

on w_dm_approve.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.cb_tutorials=create cb_tutorials
this.dw_doc=create dw_doc
this.st_info=create st_info
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.cb_tutorials
this.Control[iCurrent+3]=this.dw_doc
this.Control[iCurrent+4]=this.st_info
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.dw_1
end on

on w_dm_approve.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.cb_tutorials)
destroy(this.dw_doc)
destroy(this.st_info)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event pfc_preopen;call super::pfc_preopen;istr_ctx_email = Message.Powerobjectparm

end event

event open;call super::open;//ctx_am_image_approve.flag : 1: wating approval, 2: complete. 
//ctx_am_image_approve_detail.flag : 1: wating approval, 2: approved, -1: Not started. 
//ctx_am_image_approve_detail.Approve_status: 1: Approved, 2: Approved with Changes, 3: Rejected.

il_approve_id = gnv_app.of_get_id( 'approve_id', 1)

inv_filesrv = Create n_cst_filesrvwin32 

of_set_document()

dw_1.InsertRow(0)

//Retrieve the email templates DDDW
dw_1.getchild('email_template',idwc_email_template)
idwc_email_template.SetTransObject(SQLCA)

dw_1.SetItem(1,'Approve_type','Approve')
dw_1.SetItem(1, 'due_date',  RelativeDate(today(), 10) )

ids_email_userid = Create n_ds
ids_email_userid.Dataobject = 'd_notification_users_select'
ids_email_userid.SetTransobject(SQLCA)

ids_EmailAttach = Create n_ds
ids_EmailAttach.DataObject = "d_Email_Attach_all"
ids_EmailAttach.SetTransObject(SQLCA)

ids_action_items = Create n_ds
ids_action_items.DataObject = "d_am_action_items"
ids_action_items.SetTransObject(SQLCA)
 
ids_webapprove = Create n_ds
ids_webapprove.DataObject = "d_am_approve_detail_list"
ids_webapprove.SetTransObject(SQLCA)
 
 
//Retrieve ini data
gnv_appeondb.of_startqueue( )
	idwc_email_template.Retrieve()
	ids_email_userid.Retrieve()
	ids_EmailAttach.Retrieve()
	SELECT email  INTO :is_user_email FROM em_smtp_accounts WHERE (user_id = :gs_User_ID) AND (is_default = 'Y');
	Select web_link_name,cache_name Into :is_weblink_root,:is_cache_name From Icred_settings;
gnv_appeondb.of_commitqueue( )

inv_filesrv = Create n_cst_filesrvwin32
//---------Begin Added by (Appeon)Harry 01.28.2014 for V142 ISG-CLX--------
If isnull(is_weblink_root) Then is_weblink_root = '' //Added By Ken.Guo 03/26/2013
//---------End Added ------------------------------------------------------

If is_user_email = '' or isnull(is_user_email) Then
	Messagebox('Error','Please config you email account first.')
	Post CloseWithReturn(This, 0)
End If

//Open new message
ole_message.SetRedraw(False)
ole_message.of_open( )
If ole_message.object.doctype <> 1 Then 
	Messagebox('','Failed to use the office control, please exit application and try again.')
	Close(This)
End If
This.of_auto_add_approve_field( )
ole_message.SetRedraw(True)


end event

event close;call super::close;ole_Message.of_Close()

If isvalid(ids_export) Then Destroy ids_export
If isvalid(inv_filesrv) Then Destroy inv_filesrv
If isvalid(ids_email_userid) Then Destroy ids_email_userid
If isvalid(ids_EmailAttach) Then Destroy ids_EmailAttach

end event

event activate;call super::activate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

type ole_message from u_email_edit within w_dm_approve
boolean visible = false
integer x = 137
integer y = 1944
integer width = 229
integer height = 108
integer taborder = 30
string binarykey = "w_dm_approve.win"
end type

event constructor;call super::constructor;this.object.menubar(false)
end event

type cb_tutorials from commandbutton within w_dm_approve
boolean visible = false
integer x = 32
integer y = 1808
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Tutorials"
end type

event clicked;//---------Begin Modified by (Appeon)Harry 07.13.2013 for V141 ISG-CLX-------- 
//of_open_web("http://www.contractlogix.com/tutorials.asp")
of_open_web("http://intellisoftgroup.com/support/ViewletsGet.asp")
//---------End Modfiied ------------------------------------------------------

end event

type dw_doc from u_dw within w_dm_approve
integer x = 837
integer y = 60
integer width = 1966
integer height = 452
integer taborder = 20
string title = "none"
string dataobject = "d_am_approval_doc_request"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type st_info from statictext within w_dm_approve
integer x = 416
integer y = 1824
integer width = 1472
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
long bordercolor = 128
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_dm_approve
integer x = 2482
integer y = 1808
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
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_ok from commandbutton within w_dm_approve
integer x = 2121
integer y = 1808
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

event clicked;String ls_notify_emails,ls_notify_emails2, ls_emails_arr[], ls_emails_arr2[]
String ls_email,ls_userid,ls_subject, ls_ctxidlist,ls_docidlist
Long i, ll_email_template_id
long 		ll_Return,li_send_result = 0
String ls_errtext,ls_attachfilename,ls_to,ls_cc,ls_bcc,ls_email_type,ls_notes,ls_computer_info
Boolean lb_siganature = False
Long ll_ctx_id_list[]
n_cst_easymail_smtp 	lnv_Mail
n_cst_dm_utils lnv_dm_utils //Alfee 11.28.2007

String			ls_AppointmentList
DateTime	ldt_duedate

dw_1.AcceptText()
Setpointer(HourGlass!)

If Parent.of_check_data() < 0 Then Return 

is_web_link = ''

ls_notify_emails = dw_1.GetItemString(1,'first_approver')
ls_notify_emails2 = dw_1.GetItemString(1,'second_approver')
is_template_message = dw_1.GetItemString(1,'email_message')
If isnull(is_template_message) Then is_template_message = ' '
//If dw_1.GetItemNumber(1,'email_signature') = 1 Then lb_siganature = True

inv_string.of_parsetoarray( ls_notify_emails,';',ls_emails_arr[])
inv_string.of_delete_duplicate( ls_emails_arr[])

inv_string.of_parsetoarray( ls_notify_emails2,';',ls_emails_arr2[])
inv_string.of_delete_duplicate( ls_emails_arr2[])

//ls_subject = dw_1.GetItemString(1,'Subject')
ll_email_template_id = dw_1.GetItemNumber(1,'Email_Template')

if lnv_Mail.of_CreateObject() = -1 then
	f_show_message('Create Email Object','','','','')
	Return -1
end if

ls_AppointmentList = dw_1.GetItemString( 1, 'alm_appointment' )//added by gavins 20121026
ldt_duedate = dw_1.GetItemDatetime( 1, 'due_date' )

If UpperBound(ls_emails_arr[]) = 0 Then Return

//Gen CTX ID List and Doc ID List
ll_ctx_id_list[] = istr_ctx_email.ctx_id_list[]
inv_string.of_delete_duplicate( ll_ctx_id_list[] )
inv_string.of_arraytostring( ll_ctx_id_list, ',', ls_ctxidlist)
inv_string.of_arraytostring( istr_ctx_email.doc_id_list[], ',', ls_docidlist)

For i = 1 To UpperBound(ls_emails_arr[])
	st_info.text = 'Sending Email with first approver '+String(i) + '/' + String(UpperBound(ls_emails_arr[])) +' ... '
	
	//Build Web Approve Link	
	ls_userid = Parent.of_getuserid( ls_emails_arr[i] )
	If of_gen_web_link(ls_emails_arr[i],ls_userid,1) < 0 Then
		li_send_result = -5
		Messagebox('Error -5','Failed to merge the Web Approve Link, please call support.')
		Exit
	End If

	gstr_email_info.ss_ctx_id_list =  ls_ctxidlist
	gstr_email_info.ss_doc_id_list = ls_docidlist
	
	//**************************************// added by gavins 20121026
	If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '1' And Len( ls_AppointmentList ) > 1 Then   // And  Pos( ls_AppointmentList, ls_emails_arr[i] ) > 0
		If IsNull( ldt_duedate) Or String( ldt_duedate, 'yyyymmdd' ) = '19000101'  Then ldt_duedate = DateTime( today( ) )
		lnv_Mail.of_setappointmentarguments( true, ldt_duedate , '' )
	End If
	//**************************************//	
	//ll_Return = lnv_Mail.of_SendHtml(gs_user_id, ls_emails_arr[i], '', '', ls_subject, ole_message, is_attach_file,false,0,0,0)
	ll_Return = lnv_Mail.of_sendtext(gs_user_id, ls_emails_arr[i],'', '',gnv_webapprove.is_email_subject,is_email_message ,'')
	gstr_email_info.ss_ctx_id_list = ''
	gstr_email_info.ss_doc_id_list = ''

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
	ls_to =  ls_emails_arr[i]
	ls_cc = ''
	ls_bcc = ''
	ls_email_type = 'Checkout & WEB Approval'
	If ll_email_template_id = 0 Then Setnull(ll_email_template_id)
	ls_computer_info = lnv_Mail.of_get_compute_info( )
	
	Insert Into em_mail_audit
	(user_id,mail_from,mail_to,mail_cc,mail_bcc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,notes,compute_info)
	Values 
	(:gs_user_id,:gs_user_id,:ls_to,:ls_cc,:ls_bcc,:gnv_webapprove.is_email_subject,getdate(),'',:ll_email_template_id,:ls_ctxidlist,:ls_docidlist,'',null,:ls_email_type,'',:li_send_result,:ls_errtext,:ls_notes,:ls_computer_info);
	
	if ll_Return <> 0 then 
		lnv_Mail.of_DeleteObject()
		Exit
	End If
Next	

//Generate Second Approvers Data
If li_send_result = 0 Then 
	For i = 1 To UpperBound(ls_emails_arr2)
		ls_userid = Parent.of_getuserid( ls_emails_arr2[i] )
		st_info.text = 'Saving second approvers data ...'
		If of_gen_web_link(ls_emails_arr2[i],ls_userid,2) < 0 Then
			li_send_result = -5		
		End If
	Next
End If

st_info.text = ''	

lnv_Mail.of_DeleteObject()
If li_send_result < 0 Then
	ole_message.of_open( iblb_email_message )
	ole_message.SetRedraw(True)	
	Return li_send_result
End If

//Set check out status
Parent.of_setcheckoutstatus( )

//Create action item
st_info.text = 'Creating Action Items ...'	
of_create_action_items()

//Add audit trail in document manager
istr_ctx_email.al_approve_id = il_approve_id
lnv_dm_utils.of_add_audit_trail(istr_ctx_email.doc_id_list[],istr_ctx_email, ls_email_type)
st_info.text = ''	

ole_message.of_close()
ole_message.SetRedraw(True)	
CloseWithReturn(Parent, 1)		
end event

type dw_1 from u_dw within w_dm_approve
integer x = 27
integer y = 16
integer width = 2807
integer height = 1772
integer taborder = 10
string title = "none"
string dataobject = "d_am_approve_request"
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


string			ls_create_list, ls_create_users[], ls_email, ls_create_users_new[]
Long			i, ll_Find


If dwo.Name = 'first_approver' Then
	
	ls_create_list = this.GetItemString( row,"alm_appointment")
	inv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
	For i = 1 To UpperBound(ls_create_users[])
		If Pos(lower(data),lower(trim( ls_create_users[i]))) > 0 Then
			ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
		End If
	Next
	If UpperBound(ls_create_users_new[]) > 0 Then
		inv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
	Else
		ls_create_list = ''
	End If
	this.SetItem( row, "alm_appointment",ls_create_list)

	
End If

If dwo.Name = 'second_approver' Then
	
	ls_create_list = this.GetItemString( row,"alm_appointment2")
	inv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
	For i = 1 To UpperBound(ls_create_users[])
		If Pos(lower(data),lower(trim( ls_create_users[i]))) > 0 Then
			ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
		End If
	Next
	If UpperBound(ls_create_users_new[]) > 0 Then
		inv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
	Else
		ls_create_list = ''
	End If
	this.SetItem( row, "alm_appointment2",ls_create_list)

	
End If
end event

event buttonclicked;call super::buttonclicked;str_alarm_user	lstr_alarm
String  ls_email_list,ls_email_list_temp,ls_email_arr[],ls_email_column
n_cst_string lnv_string
integer li_rtn,li_i, i, j

String		ls_appointment, ls_currentAppointmentuser[], ls_newAppointmentuser[], ls_appointment_list

dw_1.AcceptText()

Choose Case dwo.name
	Case 'b_first'
		ls_email_column = 'first_approver'
		ls_email_list = This.GetItemString(row,ls_email_column)
		lstr_alarm.s_to_list = ls_email_list
		lstr_alarm.s_create_list = dw_1.GetItemString(1, 'create_ai_list')
		lstr_alarm.s_type = 'Review/Approve'
		lstr_alarm.s_flag = 'Y'
		lstr_alarm.s_appointment = dw_1.GetItemString(1, 'alm_appointment')
		Openwithparm(w_ctx_alarm_users,lstr_alarm)

		lstr_alarm = message.PowerObjectParm
		if isvalid(lstr_alarm) then
			of_update_email_list(ls_email_column,ls_email_list,lstr_alarm.s_to_list)
			dw_1.SetItem(1,'create_ai_list',lstr_alarm.s_create_list)
		end if		
	Case 'b_second'
		ls_email_column = 'second_approver'
		ls_email_list = This.GetItemString(row,ls_email_column)
		lstr_alarm.s_to_list = ls_email_list
		lstr_alarm.s_create_list = dw_1.GetItemString(1, 'create_ai_list2')
		lstr_alarm.s_type = 'Review/Approve'
		lstr_alarm.s_flag = 'Y'
		lstr_alarm.s_appointment = dw_1.GetItemString(1, 'alm_appointment2')
		Openwithparm(w_ctx_alarm_users,lstr_alarm)

		lstr_alarm = message.PowerObjectParm
		if isvalid(lstr_alarm) then
			of_update_email_list(ls_email_column,ls_email_list,lstr_alarm.s_to_list)
			dw_1.SetItem(1,'create_ai_list2',lstr_alarm.s_create_list)
		end if			
//	Case 'b_clear'
//		is_attach_file = ''
//		dw_1.Setitem(1,'attachment','')
//		
//	Case 'b_addattachment'
//		SetPointer( HourGlass! )
//		String docname[],docpath,ls_attachment,ls_oldattachment
//		ls_oldattachment = dw_1.GetItemString(1,'attachment')
//		
//		gf_load_dir_path() 
//		li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC", "All Files (*.*), *.*")	
//		gf_save_dir_path(docpath) 
//		IF li_rtn = 1 THEN
//			//Set email attachment field with filename		
//			lnv_string.of_arraytostring( docname,",",false,ls_attachment)
//			IF Len(Trim(ls_oldattachment)) > 0 Then
//				dw_1.SetItem(1,'attachment', ls_oldattachment + ',' + ls_attachment )
//			ELSE
//				dw_1.SetItem(1,'attachment', ls_attachment )
//			END IF
//
//			IF Upperbound(docname) = 1 THEN docpath = Left(docpath, LastPos(docpath ,"\") -1)		
//			FOR li_i = 1 to upperbound(docname)
//				//Set fullname variable
//				IF Len(Trim(is_attach_file)) > 0 Then
//					is_attach_file += "," + docpath + "\" + docname[li_i]
//				ELSE
//					is_attach_file = docpath + "\" + docname[li_i]
//				END IF			
//			NEXT
//		END IF

End Choose

If dwo.name = 'b_first'  Then
	ls_appointment = dw_1.GetItemString( 1, 'alm_appointment' )//added by gavins 20121024
	//added by gavins 20121024
	if isvalid(lstr_alarm) then
			dw_1.SetItem(1, 'alm_appointment', lower(lstr_alarm.s_appointment   ))
	End If
End If

If  dwo.Name = 'b_second' Then
	ls_appointment = dw_1.GetItemString( 1, 'alm_appointment2' )//added by gavins 20121024
	//added by gavins 20121024
	if isvalid(lstr_alarm) then
		dw_1.SetItem(1, 'alm_appointment2', lower(lstr_alarm.s_appointment   ))
	End If
End If


//modifed by gavins 20121031
//if isvalid(lstr_alarm) then
//		IF IsNull(ls_appointment) OR Len(Trim(ls_appointment)) < 1 THEN
//			dw_1.SetItem(1, 'alm_appointment2', lower(lstr_alarm.s_appointment   ))
//		ELSE
//			lnv_string.of_parsetoarray(Trim(ls_appointment), ';', ls_currentAppointmentuser)
//			lnv_string.of_parsetoarray(Trim(lower(lstr_alarm.s_appointment )), ';', ls_newAppointmentuser)
//			FOR i = 1 to UpperBound(ls_newAppointmentuser) 
//				FOR j = 1 to UpperBound(ls_currentAppointmentuser)
//					IF Upper(Trim(ls_newAppointmentuser[i])) = Upper(Trim(ls_currentAppointmentuser[j])) THEN EXIT	
//				NEXT
//				//Skip the duplicated user
//				IF j <= UpperBound(ls_currentAppointmentuser) THEN CONTINUE
//				//Keep the user in new user list
//				IF Len(ls_appointment_list) < 1 THEN
//					ls_appointment_list = ls_newAppointmentuser[i]
//				ELSE
//					ls_appointment_list += '; ' + ls_newAppointmentuser[i]
//				END IF
//			NEXT
//			//Add them to current user list	
//			IF Len(ls_appointment_list) > 0 THEN 
//				IF	Right(Trim(ls_appointment),1) <> ';' THEN ls_appointment = Righttrim(ls_appointment) + '; '
//				ls_appointment_list = ls_appointment + ls_appointment_list
//				dw_1.SetItem(1, 'alm_appointment2', ls_appointment_list)
//			END IF
//		END IF
//	End If
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_dm_approve.bin 
2800000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004d05e41001d172af00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000004d05e41001d172af4d05e41001d172af0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000052b000002ca00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000052b000002ca00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_dm_approve.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
