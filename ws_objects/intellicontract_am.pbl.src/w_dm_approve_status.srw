$PBExportHeader$w_dm_approve_status.srw
forward
global type w_dm_approve_status from w_response
end type
type cb_tutorials from commandbutton within w_dm_approve_status
end type
type st_info from statictext within w_dm_approve_status
end type
type cb_refresh from commandbutton within w_dm_approve_status
end type
type cb_trigger2nd from commandbutton within w_dm_approve_status
end type
type cb_checkin from commandbutton within w_dm_approve_status
end type
type dw_approve_status from u_dw within w_dm_approve_status
end type
type dw_doc_status from u_dw within w_dm_approve_status
end type
type cb_close from commandbutton within w_dm_approve_status
end type
type gb_2 from groupbox within w_dm_approve_status
end type
type gb_3 from groupbox within w_dm_approve_status
end type
end forward

global type w_dm_approve_status from w_response
integer width = 3959
integer height = 1664
string title = "Approval Status"
long backcolor = 33551856
event ue_systemcommand pbm_syscommand
event type integer ue_previewdoc ( string as_filename )
cb_tutorials cb_tutorials
st_info st_info
cb_refresh cb_refresh
cb_trigger2nd cb_trigger2nd
cb_checkin cb_checkin
dw_approve_status dw_approve_status
dw_doc_status dw_doc_status
cb_close cb_close
gb_2 gb_2
gb_3 gb_3
end type
global w_dm_approve_status w_dm_approve_status

type variables

str_ctx_email istr_ctx_email,istr_ctx_emailnew
n_cst_webapprove inv_webapprove
n_cst_word_utility inv_word_utility
n_cst_dm_utils inv_dm_utils
boolean ib_gotemail = False

n_ds ids_webapprove
//Long il_approve_id
Decimal{1} idec_newest_revision
Integer ii_checkoutstatus

end variables

forward prototypes
public function boolean of_check_right ()
public function string of_combine_doc (string as_fullfile[], string as_user[])
public subroutine of_set_doc_status ()
end prototypes

event ue_systemcommand;If message.wordparm = 61536 Then // if click close (X) button on title bar.
	cb_close.Trigger Event Clicked()
End If

Return 1
end event

event type integer ue_previewdoc(string as_filename);str_add_doc lstr_add_doc
If Not FileExists(as_filename) Then Return -1

lstr_add_doc.filepathname = as_filename
lstr_add_doc.doc_from = 'WebApprove' 

OpenWithParm(w_document_view_response, lstr_add_doc)

Return  Message.doubleparm

end event

public function boolean of_check_right ();//Messagebox('','you have right....')

Return True
end function

public function string of_combine_doc (string as_fullfile[], string as_user[]);String ls_combinefile1
Long i

If UpperBound(as_fullfile[]) < 2 Then Return ''

ls_combinefile1 = as_fullfile[1]
For i = 2 To UpperBound(as_fullfile[])
	ls_combinefile1 = inv_word_utility.of_combine_doc( ls_combinefile1  , as_user[i - 1], as_fullfile[i], as_user[i])
	If Not FileExists(ls_combinefile1) Then Return ''
Next

Return ls_combinefile1


end function

public subroutine of_set_doc_status ();Long i
Decimal{1} ldec_revision

If dw_approve_status.rowcount() > 0 Then
	dw_doc_status.Reset()
	dw_doc_status.InsertRow(0)
	dw_doc_status.SetItem(1,'documentname',dw_approve_status.GetItemString(1,'file_name') )
	dw_doc_status.SetItem(1,'inviteremail',dw_approve_status.GetItemString(1,'sender_email') )
	dw_doc_status.SetItem(1,'inviter',dw_approve_status.GetItemString(1,'sender_user') )
	dw_doc_status.SetItem(1,'invitedate',dw_approve_status.GetItemDatetime(1,'sent_time') )
	dw_doc_status.SetItem(1,'approveid',dw_approve_status.GetItemnumber(1,'approve_id') )
	
	//Set doc status
	If dw_approve_status.Find('user_order = 1 and (approve_status = 0 or isnull(approve_status))', 1, dw_approve_status.rowcount() ) > 0 Then
		dw_doc_status.SetItem(1,'docstatus','Pending 1st Level Approval' )
		dw_doc_status.SetItem(1,'next_step','Waiting for Approver(s) to Approve Documents. No Action.') 
	ElseIf dw_approve_status.Find('user_order = 2 and (approve_status = 0 or isnull(approve_status))', 1, dw_approve_status.rowcount() ) > 0 Then
		dw_doc_status.SetItem(1,'docstatus','Pending 2nd Level Approval' )
		If dw_approve_status.Find('user_order = 1 and detail_flag = 1 ', 1, dw_approve_status.rowcount() ) > 0 Then
			 dw_doc_status.SetItem(1,'next_step','1st Level Approvals complete.  Click the Send To 2nd Level Approvers button to send document to 2nd Level Approvers. ')
		Else
			dw_doc_status.SetItem(1,'next_step','Waiting for Approver(s) to Approve Documents. No Action.')			
		End If
	Else
		dw_doc_status.SetItem(1,'docstatus','All Approver(s) Submitted' )
		dw_doc_status.SetItem(1,'next_step','All Approvals complete.  Click the Check In button to Check In Documents(s)')
	End If

	//Check Document expired.
	ldec_revision = dw_approve_status.GetItemDecimal(1, 'revision')
	If ( ldec_revision <> idec_newest_revision ) or ( ii_checkoutstatus <> 7 and ii_checkoutstatus <> 8 ) Then
		cb_trigger2nd.visible = False
		cb_checkin.visible = False
		dw_doc_status.SetItem(1,'docstatus','Web approval link is expired.' )
		dw_doc_status.SetItem(1,'next_step','No Action.') 
		dw_approve_status.Modify("selected.visible = '0' b_email.visible = '0'")
	End If
	
	//Set Button Status
	For i = 1 To dw_approve_status.Rowcount()
		If dw_approve_status.GetItemNumber(i, 'uploaded' ) > 0  Then
			//
		Else
			dw_approve_status.SetItem(i,'selected',0)
		End If
	Next

	If Not istr_ctx_email.ab_checkinright Then
		cb_checkin.enabled = False
	End If
	
	If dw_approve_status.GetItemNumber(dw_approve_status.rowcount(),'usable') = 0 Then
		cb_checkin.enabled = False
		cb_trigger2nd.enabled = False
	End If

	If dw_approve_status.Find('user_order = 2',1,dw_approve_status.rowcount() ) = 0 Then
		cb_trigger2nd.visible = False
	ElseIf dw_approve_status.Find('user_order = 2 and detail_flag <> 1',1,dw_approve_status.rowcount() ) = 0 Then
		cb_trigger2nd.enabled = False
	End If

	//Set checked by default
	If ( (cb_trigger2nd.visible and cb_trigger2nd.enabled) or (cb_checkin.visible and cb_checkin.enabled) ) and (lower(istr_ctx_email.doc_ext) = 'doc' or lower(istr_ctx_email.doc_ext) = 'docx')  Then
		For i = 1 To dw_approve_status.Rowcount()
			If dw_approve_status.GetItemNumber(i, 'compute_commited') = 1 Then
				dw_approve_status.SetItem(i,'selected', 1)
			End If
		Next
	End If
	
	
End If


end subroutine

on w_dm_approve_status.create
int iCurrent
call super::create
this.cb_tutorials=create cb_tutorials
this.st_info=create st_info
this.cb_refresh=create cb_refresh
this.cb_trigger2nd=create cb_trigger2nd
this.cb_checkin=create cb_checkin
this.dw_approve_status=create dw_approve_status
this.dw_doc_status=create dw_doc_status
this.cb_close=create cb_close
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_tutorials
this.Control[iCurrent+2]=this.st_info
this.Control[iCurrent+3]=this.cb_refresh
this.Control[iCurrent+4]=this.cb_trigger2nd
this.Control[iCurrent+5]=this.cb_checkin
this.Control[iCurrent+6]=this.dw_approve_status
this.Control[iCurrent+7]=this.dw_doc_status
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_dm_approve_status.destroy
call super::destroy
destroy(this.cb_tutorials)
destroy(this.st_info)
destroy(this.cb_refresh)
destroy(this.cb_trigger2nd)
destroy(this.cb_checkin)
destroy(this.dw_approve_status)
destroy(this.dw_doc_status)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;inv_word_utility = Create n_cst_word_utility 

istr_ctx_email = Message.Powerobjectparm
dw_approve_status.SetTransObject(SQLCA)
cb_refresh.event clicked()

If dw_approve_status.rowcount() = 0 Then
	Messagebox('IntelliSoft','The Web Approve Data doesn’t exist. It might be expired or have already been destroyed.')
	Close(This)
	Return
End If



end event

event close;call super::close;If isvalid(inv_word_utility) Then Destroy inv_word_utility
end event

type cb_tutorials from commandbutton within w_dm_approve_status
boolean visible = false
integer x = 59
integer y = 1448
integer width = 343
integer height = 92
integer taborder = 40
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

type st_info from statictext within w_dm_approve_status
integer x = 434
integer y = 1464
integer width = 1541
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

type cb_refresh from commandbutton within w_dm_approve_status
integer x = 3209
integer y = 1448
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;Long i
Decimal{1} ldec_revision
SetPointer(HourGlass!)

gnv_appeondb.of_startqueue( )
	dw_approve_status.Retrieve(istr_ctx_email.doc_id, istr_ctx_email.al_approve_id )
	Select revision,checkout_status Into :idec_newest_revision,:ii_checkoutstatus From ctx_am_document Where doc_id = :istr_ctx_email.doc_id;
gnv_appeondb.of_commitqueue( )

If dw_approve_status.Rowcount() = 0 Then Return

istr_ctx_email.revision = dw_approve_status.GetItemDecimal(1, 'revision')

istr_ctx_email.fullname = dw_approve_status.GetItemString(1, 'file_name') // include ext name
istr_ctx_email.doc_ext = right(istr_ctx_email.fullname, Len(istr_ctx_email.fullname) - Lastpos(istr_ctx_email.fullname,'.') )
istr_ctx_email.filename = Mid(istr_ctx_email.fullname, 1,Lastpos(istr_ctx_email.fullname,'.') - 1) //not include ext name

of_set_doc_status( )

end event

type cb_trigger2nd from commandbutton within w_dm_approve_status
integer x = 2126
integer y = 1448
integer width = 722
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send To 2nd Level Approvers"
end type

event clicked;Long ll_selected_cnt,ll_uploaded_cnt, ll_size,i, li_ret,li_incomplete_cnt,li_unsubmit_cnt
String ls_uploadedfile, ls_docfilelist[], ls_emaillist[],ls_emailaddress, ls_weblink, ls_notify_users2
str_ctx_email lstr_ctx_email
str_add_doc lstr_add_doc
blob lblb_data
String ls_email_message,ls_orgfile,ls_downloaded_file
Long ll_row, ll_row2
boolean	lb_Modify

SetPointer(HourGlass!)
If dw_approve_status.rowcount() = 0 Then Return 

//If Not of_check_right() Then Return 

ll_selected_cnt = dw_approve_status.GetItemNumber(dw_approve_status.Rowcount(),'selected_cnt')
If ll_selected_cnt = 0 Then 
	Messagebox('IntelliSoft','Please select a document to continue.')
	Return 
End If

If dw_approve_status.Find(' isnull(submit_time) and  user_order = 1 ', 1,dw_approve_status.rowcount() ) > 0 Then
	If Messagebox('IntelliSoft','Not all 1st approvers have submitted their document(s). Do you want to continue?' , question!, yesno!) = 2 Then
		Return
	End If
End If

If dw_approve_status.Find('selected = 1 and uploaded > 0 ', 1, dw_approve_status.rowcount()) = 0 Then
	//Use Original Document. Nobody upload new document
	lb_Modify = false
Else
	lb_Modify = true
	//Use New Document
	Choose Case lower(istr_ctx_email.doc_ext)
		Case 'doc','docx'
			If ll_selected_cnt = 0 Then
				Messagebox('IntelliSoft','Please select one or multiple documents to continue..')
				Return
			End If
			
			If ll_selected_cnt = 1 Then
				ll_row = dw_approve_status.Find('selected = 1', 1, dw_approve_status.rowcount())
				If ll_row <= 0 Then Return
				lstr_ctx_email = istr_ctx_email
				st_info.text = 'Downloading Document ...'		
				lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
				ls_uploadedfile = inv_webapprove.of_download_file(lstr_ctx_email)			
			Else
				//Combine Word if select multi documents
				gnv_debug.of_output( True, 'Word Version: ' + gs_word_version)
				IF gs_word_version = 'word2003' THEN 
					Messagebox('IntelliSoft','Multiple document selection is supported only if you have MS Word 2007 or above installed.', Exclamation!)
					Return			
				End If
				
				lstr_ctx_email = istr_ctx_email
				st_info.text = 'Downloading Documents ...'				
				ll_row2 = dw_approve_status.Find('selected = 1 and ( uploaded = 0 or isnull(uploaded) )', 1, dw_approve_status.rowcount())				
				If ll_row2 > 0 Then
					ls_orgfile =  inv_webapprove.of_download_org_file(lstr_ctx_email)		
					If Not fileexists(ls_orgfile) Then Return
					ls_emaillist[UpperBound(ls_emaillist) + 1] = 'Original'
					ls_docfilelist[UpperBound(ls_docfilelist[]) + 1] = ls_orgfile			
				End If
				ll_row = dw_approve_status.Find('selected = 1 and uploaded > 0 ', 1, dw_approve_status.rowcount())
				Do While ll_row > 0 
					lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
					ls_downloaded_file =  inv_webapprove.of_download_file(lstr_ctx_email)	
					If FileExists(ls_downloaded_file) Then
						ls_emaillist[UpperBound(ls_emaillist) + 1] = lstr_ctx_email.emailto
						ls_docfilelist[UpperBound(ls_docfilelist[]) + 1] =ls_downloaded_file
					Else
						Return
					End If
					If ll_row = dw_approve_status.rowcount() Then Exit
					ll_row = dw_approve_status.Find('selected = 1  and uploaded > 0', ll_row + 1, dw_approve_status.rowcount())
				Loop

				//Combine ls_docfilelist[]
				If UpperBound(ls_docfilelist[]) > 1 Then
					st_info.text = ''					
					If Messagebox('IntelliSoft','You have selected multi documents, it will combine the word files before send to 2nd approvers. Do you want to continue?', Question!, YesNO!) = 2 Then Return
					st_info.text = 'Combining Word Documents ...'									
					ls_uploadedfile = of_combine_doc(ls_docfilelist[],ls_emaillist[])
					st_info.text = ''			
					If FileExists(ls_uploadedfile) Then
						If Messagebox('IntelliSoft','Do you want to preview the combined document before send to 2nd approver(s)?', Question!,Yesno!) = 1 Then
							If Parent.event ue_previewdoc( ls_uploadedfile) <> 1 Then 
								Return
							End If
						End If
					End If
				Elseif UpperBound(ls_docfilelist[]) = 1 Then
					ls_uploadedfile = ls_docfilelist[1]
				Else
					Return
				End If
			End If
			
		Case Else
			ll_selected_cnt = dw_approve_status.GetItemNumber(dw_approve_status.Rowcount(),'selected_cnt')
			If ll_selected_cnt = 0 Then
				Messagebox('IntelliSoft','Please select one documents to continue.')
				Return			
			ElseIf ll_selected_cnt > 1 Then
				Messagebox('IntelliSoft','You have selected multiple documents. Please select one document to continue. Multiple selection is supported only for checking in Word documents.')
				Return				
			End If
			ll_row = dw_approve_status.Find('selected = 1 and uploaded > 0', 1, dw_approve_status.rowcount())
			If ll_row <= 0 Then Return
			lstr_ctx_email = istr_ctx_email
			lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
			st_info.text = 'Downloading Document ...'		
			ls_uploadedfile = inv_webapprove.of_download_file(lstr_ctx_email)
	End Choose
	
	If Not FileExists(ls_uploadedfile) Then
		Messagebox('Error','Failed to get the document.')
		Return
	End If	
	inv_dm_utils.of_readblob(ls_uploadedfile,lblb_data)
	ll_size = FileLength(ls_uploadedfile)
End If

//Send Email to 2nd approvers
dw_approve_status.SetRedraw(False)
dw_approve_status.SetFilter('user_order = 2 ')
dw_approve_status.Filter()

For i = 1 To dw_approve_status.Rowcount()
	st_info.text = 'Sending Email to 2nd level approver '+String(i) + '/' + String( dw_approve_status.Rowcount() ) +' ... '		
	ls_emailaddress = dw_approve_status.GetItemString(i, 'email_address')
	istr_ctx_emailnew.as_message = dw_approve_status.getitemString(i,'email_message')
	istr_ctx_emailnew.as_mail_subject = " for Document '" + dw_doc_status.GetItemString(1,'documentname') + "'"
	istr_ctx_emailnew.alm_appointment = dw_approve_status.GetItemString( i, 'alm_appointment' )
	li_ret = inv_webapprove.of_send_email( istr_ctx_emailnew, ls_emailaddress)
	If li_ret < 0 Then
		dw_approve_status.SetFilter('')
		dw_approve_status.Filter()	
		dw_approve_status.SetRedraw(True)
		Return 
	End If	
Next
dw_approve_status.SetFilter('')
dw_approve_status.Filter()	
dw_approve_status.SetRedraw(True)


//Update Data
st_info.text = 'Updating Status Data ...'
gnv_appeondb.of_startqueue( )
	If ll_size > 0 Then
		UpdateBlob ctx_am_image_approve Set Org_Image_file = :lblb_data Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision ;
		Update ctx_am_image_approve set file_size = :ll_size,new_file = 1 Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision ;
	End If
	Update ctx_am_image_approve_detail Set flag = 2 Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision and user_order = 1 ;
	Update ctx_am_image_approve_detail Set flag = 1 Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision and user_order = 2 ;
	Update ctx_am_action_item Set Action_Status = :inv_webapprove.il_InComplete  Where doc_id = :istr_ctx_email.doc_id and approve_id = :istr_ctx_email.al_approve_id and Action_Type = :inv_webapprove.il_DocCheckIN and  Action_Status = :inv_webapprove.il_submitted;	
	If lb_Modify Then //added by gavins 20121220  because this approver select a approve that not uploading doc.
		Update ctx_am_image_approve set file_modify = 1 Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision ;
	Else
		Update ctx_am_image_approve set file_modify = null Where doc_id = :istr_ctx_email.doc_id and revision = :istr_ctx_email.revision ;
	End If
gnv_appeondb.of_commitqueue( )

//Insert Action Item
Datetime ldt_duedate
ldt_duedate = DateTime(RelativeDate(Today(), 10) ,Now())

ls_notify_users2 = dw_approve_status.GetItemString(1,'notify_users2')
st_info.text = 'Creating Action Items ...'
inv_webapprove.of_create_action_items(istr_ctx_email.al_approve_id, istr_ctx_email, ls_notify_users2, 2,0,ldt_duedate)

cb_refresh.event clicked( )

st_info.text = ''

Messagebox('IntelliSoft','2nd level approvers successfully notified.')


end event

type cb_checkin from commandbutton within w_dm_approve_status
integer x = 2857
integer y = 1448
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check &In..."
end type

event clicked;Long ll_selected_cnt,ll_uploaded_cnt,ll_row,ll_row2
String ls_uploadedfile, ls_docfilelist[], ls_emaillist[],ls_orgfile,ls_downloaded_file
str_ctx_email lstr_ctx_email
str_add_doc lstr_add_doc
Boolean		lb_upload, lb_Modify

lstr_add_doc.ab_notmodified = False

SetPointer(HourGlass!)
If dw_approve_status.rowcount() = 0 Then Return 

ll_selected_cnt = dw_approve_status.GetItemNumber(dw_approve_status.Rowcount(),'selected_cnt')

lstr_ctx_email = istr_ctx_email
Choose Case lower(istr_ctx_email.doc_ext)
	Case 'doc','docx'
			If ll_selected_cnt = 0 Then
				IF gs_word_version = 'word2003' THEN 
					Messagebox('IntelliSoft','Please select one document to continue..')
				Else
					Messagebox('IntelliSoft','Please select one or multiple documents to continue..')
				End If
				Return
			ElseIf ll_selected_cnt > 1 Then
				IF gs_word_version = 'word2003' THEN 
					Messagebox('IntelliSoft','Multiple document selection is supported only if you have MS Word 2007 or above installed.', Exclamation!)
					Return			
				End If					
			End If

			If dw_approve_status.Find(' isnull(submit_time) ', 1,dw_approve_status.rowcount() ) > 0 Then
				If cb_trigger2nd.visible and cb_trigger2nd.enabled Then
					If Messagebox('Check In','Warning:  Not all approvers have submitted their documents. To trigger an email to be sent to the next level Approver(s), click the Send To 2nd Level Approvers button.' + &
						'~r~n~r~nAre you sure you want to continue to Check In?', question!, yesno!) = 2 Then
						Return
					End If
				Else
					If Messagebox('Check In','Not all approvers have submitted their documents. Do you want to continue to check in?' , question!, yesno!) = 2 Then
						Return
					End If
				End If
			End If
			
			
			/********************************************///added by gavins 20121220
			lb_upload = false
			lb_Modify = false
			ll_row = dw_approve_status.Find('selected = 1 ', 1, dw_approve_status.rowcount())
			Do While ll_row > 0 
				If  dw_approve_status.GetItemNumber(ll_row,'uploaded') > 0 Then
					lb_upload = true
				End If
				If dw_approve_status.GetItemNumber(ll_row,'file_modify') = 1	Then
					lb_Modify = true
				End If
				If ll_row = dw_approve_status.rowcount() Then Exit
				ll_row = dw_approve_status.Find('selected = 1', ll_row + 1, dw_approve_status.rowcount())
			Loop
			If  not lb_upload  and lb_Modify  Then
				If MessageBox( parent.title, 'The Approver you chose did not upload the document. The document uploaded by the 1st Approver will be used.~r~rDo you want to continue?' , question!, yesno!)=2 Then
					Return
				End If
			End If
			/********************************************/					
			
			If ll_selected_cnt = 1 Then
				ll_row = dw_approve_status.Find('selected = 1', 1, dw_approve_status.rowcount())
				If ll_row <= 0 Then Return
				st_info.text = 'Downloading Document ...'		
				lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
				If dw_approve_status.GetItemNumber(ll_row,'uploaded') = 0 or isnull( dw_approve_status.GetItemNumber(ll_row,'uploaded') ) Then
					ls_uploadedfile = inv_webapprove.of_download_org_file(lstr_ctx_email)
					lstr_add_doc.ab_notmodified = True
				Else
					ls_uploadedfile = inv_webapprove.of_download_file(lstr_ctx_email)			
				End If
			Else
				//Combine Word if select multi documents
				//gnv_debug.of_output( True, 'Word Version: ' + gs_word_version)
				
				st_info.text = 'Downloading Documents ...'				
				ll_row2 = dw_approve_status.Find('selected = 1 and ( uploaded = 0 or isnull(uploaded) )', 1, dw_approve_status.rowcount())				
				If ll_row2 > 0 Then
					ls_orgfile =  inv_webapprove.of_download_org_file(lstr_ctx_email)
					lstr_add_doc.ab_notmodified = True
					If Not fileexists(ls_orgfile) Then Return
					ls_emaillist[UpperBound(ls_emaillist) + 1] = 'Original'
					ls_docfilelist[UpperBound(ls_docfilelist[]) + 1] = ls_orgfile			
				End If
				ll_row = dw_approve_status.Find('selected = 1 and uploaded > 0 ', 1, dw_approve_status.rowcount())
				Do While ll_row > 0 
					lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
					ls_downloaded_file =  inv_webapprove.of_download_file(lstr_ctx_email)	
					If FileExists(ls_downloaded_file) Then
						ls_emaillist[UpperBound(ls_emaillist) + 1] = lstr_ctx_email.emailto
						ls_docfilelist[UpperBound(ls_docfilelist[]) + 1] =ls_downloaded_file
					Else
						Return
					End If
					If ll_row = dw_approve_status.rowcount() Then Exit
					ll_row = dw_approve_status.Find('selected = 1  and uploaded > 0', ll_row + 1, dw_approve_status.rowcount())
				Loop

				//Combine ls_docfilelist[]
				If UpperBound(ls_docfilelist[]) > 1 Then
					st_info.text = ''					
					If Messagebox('IntelliSoft','You have selected multi documents, it will combine the word files before check in. Do you want to continue?', Question!, YesNO!) = 2 Then Return
					st_info.text = 'Combining Word Documents ...'									
					ls_uploadedfile = of_combine_doc(ls_docfilelist[],ls_emaillist[])
					st_info.text = ''			
					If FileExists(ls_uploadedfile) Then
						If Messagebox('IntelliSoft','Do you want to preview the combined document before check in?', Question!,Yesno!) = 1 Then
							If Parent.event ue_previewdoc( ls_uploadedfile) <> 1 Then 
								Return
							End If
						End If
					End If
					
					lstr_add_doc.ab_notmodified = False
					
				Elseif UpperBound(ls_docfilelist[]) = 1 Then
					ls_uploadedfile = ls_docfilelist[1]
				Else
					Return
				End If
			End If
		
	Case Else

		If ll_selected_cnt = 0 Then
			Messagebox('Check In','Please select one documents to check in.')
			Return			
		ElseIf ll_selected_cnt > 1 Then
			Messagebox('Check In','You have selected multiple documents. Please select one document to check in. Multiple selection is supported only for checking in MS Word documents.')
			Return				
		End If

		If dw_approve_status.Find(' isnull(submit_time) ', 1,dw_approve_status.rowcount() ) > 0 Then
			If cb_trigger2nd.visible and cb_trigger2nd.enabled Then
				If Messagebox('Check In','Warning:  Not all approvers have submitted their documents. To trigger an email to be sent to the next level Approver(s), click the Send To 2nd Level Approvers button.' + &
					'~r~n~r~nAre you sure you want to continue to Check In?', question!, yesno!) = 2 Then
					Return
				End If
			Else
				If Messagebox('Check In','Not all approvers have submitted their documents. Do you want to continue to check in?' , question!, yesno!) = 2 Then
					Return
				End If
			End If
		End If


		/********************************************///added by gavins 20121220
		lb_upload = false
		lb_Modify = false
		ll_row = dw_approve_status.Find('selected = 1 ', 1, dw_approve_status.rowcount())
		Do While ll_row > 0 
			If  dw_approve_status.GetItemNumber(ll_row,'uploaded') > 0 Then
				lb_upload = true
			End If
			If dw_approve_status.GetItemNumber(ll_row,'file_modify') = 1	Then
				lb_Modify = true
			End If
			If ll_row = dw_approve_status.rowcount() Then Exit
			ll_row = dw_approve_status.Find('selected = 1', ll_row + 1, dw_approve_status.rowcount())
		Loop
		If  not lb_upload  and lb_Modify  Then
			If MessageBox( parent.title, 'The Approver you chose did not upload the document. The document uploaded by the 1st Approver will be used.~r~rDo you want to continue?' , question!, yesno!)=2 Then
				Return
			End If
		End If
		/********************************************/					
	
		ll_row = dw_approve_status.Find('selected = 1', 1, dw_approve_status.rowcount())
		If ll_row <= 0 Then Return
		lstr_ctx_email = istr_ctx_email
		lstr_ctx_email.emailto = dw_approve_status.GetItemString(ll_row,'email_address')
		st_info.text = 'Downloading Document ...'		
		If dw_approve_status.GetItemNumber(ll_row,'uploaded') = 0 or isnull( dw_approve_status.GetItemNumber(ll_row,'uploaded') ) Then
			ls_uploadedfile = inv_webapprove.of_download_org_file(lstr_ctx_email)		
			lstr_add_doc.ab_notmodified = True
		Else		
			ls_uploadedfile = inv_webapprove.of_download_file(lstr_ctx_email)
		End If
		
End Choose

st_info.text = ''		
If Not FileExists(ls_uploadedfile) Then
	Messagebox('Error','Failed to get the document.')
	Return
End If

//Check In the Document
lstr_add_doc.doc_id = istr_ctx_email.doc_id
lstr_add_doc.revision = istr_ctx_email.revision
lstr_add_doc.doc_from = istr_ctx_email.doc_from
lstr_add_doc.new = FALSE
lstr_add_doc.checkout_status = '7'
lstr_add_doc.operation = 'checkin'
lstr_add_doc.Revision_control = True
lstr_add_doc.filepathname = ls_uploadedfile
lstr_add_doc.filename = istr_ctx_email.fullname
lstr_add_doc.doc_ext = istr_ctx_email.doc_ext
lstr_add_doc.ab_approval = True
lstr_add_doc.al_approveid = istr_ctx_email.al_approve_id

OpenWithParm( w_dm_checkin_document, lstr_add_doc )

If Message.doubleparm <> 1 Then Return


CloseWithReturn(Parent, 1)




end event

type dw_approve_status from u_dw within w_dm_approve_status
integer x = 96
integer y = 588
integer width = 3776
integer height = 768
integer taborder = 20
string dataobject = "d_am_approve_status_new"
boolean hscrollbar = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

event buttonclicked;call super::buttonclicked;integer li_ret
String ls_fullname
String ls_file,ls_null
str_ctx_email lstr_ctx_email
Setnull(ls_null)
String ls_emailaddress, ls_weblink


SetPointer(HourGlass!)
lstr_ctx_email = istr_ctx_email
Choose Case dwo.name
	Case 'b_preview'
		lstr_ctx_email.emailto = dw_approve_status.GetItemString(row,'email_address')
		ls_fullname = inv_webapprove.of_download_file(lstr_ctx_email)
		If fileexists(ls_fullname) Then
			ShellExecuteA ( Handle( This ), ls_Null, ls_fullname , ls_Null, ls_Null, 4)
		End If
	Case 'b_email'
		ls_emailaddress = dw_approve_status.GetItemString(row, 'email_address')
		ls_weblink = dw_approve_status.GetItemString(row, 'web_link_name')
		lstr_ctx_email.as_message =  dw_approve_status.GetItemString(row, 'email_message')
		lstr_ctx_email.alm_appointment = dw_approve_status.GetItemString( row, 'alm_appointment' )
		li_ret = inv_webapprove.of_send_email( lstr_ctx_email, ls_emailaddress)
		If li_ret > 0 Then
			Messagebox('Email','Email sent successfully.')
		End If
	Case 'b_notes'
		OpenWithParm(w_approver_notes, dw_approve_status.GetItemString(row, 'comments'))
End Choose


end event

event itemchanged;call super::itemchanged;
If Row = 0 Then Return
Choose Case dwo.name
	Case 'selected'
		If data = '1' and (This.GetItemNumber(row,'uploaded') = 0 or isnull(This.GetItemNumber(row,'uploaded'))) Then
			Post Messagebox('IntelliSoft',"This Approver didn’t upload the document. The original document will be used for this Approver if you keep it selected. ")
		End If
End Choose
	
end event

type dw_doc_status from u_dw within w_dm_approve_status
integer x = 91
integer y = 100
integer width = 3776
integer height = 356
integer taborder = 10
string dataobject = "d_am_approve_doc_status"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type cb_close from commandbutton within w_dm_approve_status
integer x = 3561
integer y = 1448
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,0)
end event

type gb_2 from groupbox within w_dm_approve_status
integer x = 59
integer y = 24
integer width = 3854
integer height = 452
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Document Status"
end type

type gb_3 from groupbox within w_dm_approve_status
integer x = 59
integer y = 512
integer width = 3854
integer height = 900
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Approve Status"
end type

