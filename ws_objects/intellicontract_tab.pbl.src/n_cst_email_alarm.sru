$PBExportHeader$n_cst_email_alarm.sru
forward
global type n_cst_email_alarm from nonvisualobject
end type
end forward

global type n_cst_email_alarm from nonvisualobject autoinstantiate
end type

type variables
str_group_alarm istr_group_alarm[],istr_null[]
String is_address
DataStore ids_ctx_order

n_cst_notification  invo_notification
n_cst_workflow_triggers	inv_workflow

end variables

forward prototypes
public subroutine of_run_email_alarm ()
public function integer of_group_send_email ()
public function integer of_group_get_email_template (ref string as_subject, ref string as_attach, ref blob ablb_message, ref boolean ab_sign)
public function integer of_sort_email (str_group_alarm astr_group_alarm)
public function long of_get_email_order (long al_index)
end prototypes

public subroutine of_run_email_alarm ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_email_alarmof_run_email_alarm()
// $<arguments>(None)
// $<returns> (none)
// $<description> Merge n_cst_notification.of_start_notification_process() and 
// $<description>			n_cst_workflow_triggers.of_reminder_mail_process() function.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_email_id



If Not Isvalid(invo_notification) Then invo_notification =  Create n_cst_notification
If Not Isvalid(inv_workflow) Then inv_workflow = Create n_cst_workflow_triggers

w_mdi.inv_statusbar.of_setrefreshrate( 0 )   //Added By Ken.Guo 2011-08-30. 
sleep(1)
If gnv_data.of_getitem( 'icred_settings', 'email_alarm_type', False) = '2' Then //Group

	//Get Group Email ID
	ll_email_id = Long(gnv_data.of_getItem( 'icred_settings', 'group_email_template', False))
	If isnull(ll_email_id) or ll_email_id <= 0 Then
		Messagebox('Group Email Alarm','You have not selected the Group Email Alarm template, please select it first in the Application Settings.')
		if IsValid(invo_notification) then Destroy invo_notification
		If Isvalid(inv_workflow) Then Destroy inv_workflow		
		Return
	End If

	gnv_Status_Info.of_display("Start Email notification, please wait...")

	//Pre Group Email Data
	invo_notification.of_pre_send_email( )
	inv_workflow.istr_group_alarm[] = invo_notification.istr_group_alarm[]
	//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	//inv_workflow.of_reminder_mail_process()
	inv_workflow.of_reminder_mail_process_ctx()  //(Appeon)Alfee 06.24.2013 - V141 ISG-CLX
	//---------End Modfiied ------------------------------------------------------
	
	//Send Group Email and update flags
	istr_group_alarm[] = inv_workflow.istr_group_alarm[]
	If This.of_group_send_email( ) > 0 Then
		//Update Other Date Alarm Flag or Action Item Flag
		invo_notification.of_group_update_counts( )
		inv_workflow.of_set_actionitem_flags()
	End If
Else
	invo_notification.of_start_notification_process( )
	//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	//inv_workflow.of_reminder_mail_process()
	inv_workflow.of_reminder_mail_process_ctx() //(Appeon)Alfee 06.24.2013 - V141 ISG-CLX
	//---------End Modfiied ------------------------------------------------------
End If

//n_cst_webapprove lnv_webapprove
//lnv_webapprove.of_refresh_status( ) //Move to system->Refresh Document Approval Data menu

w_mdi.inv_statusbar.of_setrefreshrate( 3 )

gnv_Status_Info.of_display('')

if IsValid(invo_notification) then Destroy invo_notification
If Isvalid(inv_workflow) Then Destroy inv_workflow	
end subroutine

public function integer of_group_send_email ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_email_alarmof_group_send_email()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Send Group Email
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Integer ll_return
Long ll_cnt,i,j,c,ll_email_id,ll_alarm_cnt,ll_col_cnt,ll_row_index,ll_col_index,ll_index
String ls_sender,ls_mailto,ls_attach,ls_subject,ls_text,ls_info
Blob ablb_message
Boolean lb_auto_sign
n_cst_easymail_smtp lnv_Mail
String ls_col_header[] = {'Contract ID','Company','Alarm Type','Date','Times Reminded','Notes'}
Long ll_col_width_per[] = {15, 25, 15, 15, 10, 20}
Long ll_cpu
String ls_reminder
Boolean lb_found ,lb_error_account
str_email_info lstr_email_info
oleobject lole_table,lole_range,lole_cell,lole_selection
String ls_ctx_id_list ,ls_ctx_id,ls_error_account,ls_doc_id_list,ls_ai_id_list,ls_notes,ls_doc_id,ls_ai_id, ls_level_id1, ls_level_id2,ls_level_id1_list,ls_level_id2_list
ll_col_cnt = UpperBound(ls_col_header[])
Long ll_email_template_id
integer li_send_result = 0
String ls_field_name, ls_alarm_type
Long ll_wf_id,ll_null

 SetNull(ll_null)

//Get Group Email Template
If of_group_get_email_template(ls_subject,ls_attach,ablb_message,lb_auto_sign) < 0 Then Return -1

ll_email_template_id = Long(gnv_data.of_getItem( 'icred_settings', 'group_email_template', False))

//Create Email object
if lnv_Mail.of_CreateObject() = -1 then
	f_show_message('create Email object','','','','')
	Return -1
end if

ll_cnt = UpperBound(istr_group_alarm[])
If ll_cnt = 0 Then Return 0

//Ping all Sender Email Account
lb_error_account = False
For i = 1 To ll_cnt
	gnv_Status_Info.of_display("[" + String(i) + "/" + String(ll_cnt)+ "] Checking Email Account "+ "...")
	ls_sender = istr_group_alarm[i].as_sender
	
	//If checked
	lb_found = False
	For j = 1 To i - 1 
		If ls_sender = istr_group_alarm[j].as_sender Then 
			lb_found = True
			Exit
		End If
	Next
	If lb_found Then Continue 
	
	//Ping Email Account
	ll_cpu = cpu()
	If Not lnv_Mail.of_pingserver( ls_sender ) Then
		ls_error_account += ls_sender + ','
		lb_error_account = True
		If cpu() - ll_cpu > 5000 Then Exit //If spend too much time, then return first.
	End If
Next
If lb_error_account Then
	ls_error_account = Left(ls_error_account,Len(ls_error_account) - 1)
	Messagebox('Email Alarm','Failed to connect to the Email Server.~r~n Please check the Email Account of user(s) "' + ls_error_account + '".')
	Return -1
End If

//Send Email for each Address/Sender
Open(w_email_edit)
For i = 1 To ll_cnt
	SetPointer(HourGlass!)
	gnv_Status_Info.of_display("Sending Email Alarms "+String(i) + " of " + String(ll_cnt)+ "...")
	ls_mailto = istr_group_alarm[i].as_email_address
	ls_ctx_id_list = ''
	ls_doc_id_list = ''
	ls_ai_id_list = ''
	ls_level_id1_list = ''
	ls_level_id2_list = ''
	ls_notes = ''
	
	//Open email message with group template
	If w_email_edit.ole_word.of_Open_Buffer(ablb_message) < 0 Then 
		w_email_edit.ole_word.of_Close()
		Close(w_email_edit)
		lnv_Mail.of_DeleteObject()	
		Return -1
	End If
	IF w_email_edit.ole_word.object.doctype <> 1 THEN 
		Close(w_email_edit)
		lnv_Mail.of_DeleteObject()	
		Return -1
	End If
	
	//Add Alarm List into message
	//ll_cpu = cpu()
	ll_alarm_cnt = UpperBound(istr_group_alarm[i].astr_alarm[])
	w_email_edit.ole_word.object.ActiveDocument.Content.Select()
	lb_found =  w_email_edit.ole_word.object.ActiveDocument.ActiveWindow.Selection.Find.Execute("\$\<Alarm List\>\$", false, true, true, false, false, true, 0, false, "", 0 ) 
	Do While lb_found
		
		ll_cpu = cpu()
		//Insert a Table
		lole_range = w_email_edit.ole_word.object.ActiveDocument.Range(w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.Start,w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection.End)		
		lole_table = w_email_edit.ole_word.object.ActiveDocument.Tables.Add(lole_range,ll_alarm_cnt + 1,ll_col_cnt)
		lole_table.Borders.Enable = True
		
		//Set all Cell to wdCellAlignVerticalCenter
		lole_table.Select()
		lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
		lole_selection.Cells.VerticalAlignment = 1 //wdCellAlignVerticalCenter
		
		ls_info += '~r~ninsert and table VerticalAlignment: ' + String((cpu() - ll_cpu))
		ll_cpu = cpu()
		
		//Set Columns Width and AlignCenter
		For c = 1 to ll_col_cnt
			lole_table.Columns.item(c).PreferredWidthType = 2 //wdPreferredWidthPercent
			lole_table.Columns.item(c).PreferredWidth = ll_col_width_per[c]
			lole_table.Columns.item(c).Select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			Choose Case c
				Case 1,4,5
					lole_selection.ParagraphFormat.Alignment = 1 //Center	
				Case 2,3,6 //Use Default value: Left
					//lole_selection.ParagraphFormat.Alignment = 0 //Left
			End Choose
		Next		
		
		ls_info += '~r~nSet column width: ' + String((cpu() - ll_cpu))
		ll_cpu = cpu()
		
		//Set Table Header 
		For c = 1 To ll_col_cnt
			lole_cell = lole_table.cell(1,c)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			lole_selection.TypeText(ls_col_header[c])
		Next		
		lole_table.rows.item(1).select()
		lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
		lole_selection.Font.Bold = True
		lole_selection.ParagraphFormat.Alignment = 1//  wdAlignParagraphCenter
		
		ls_info += '~r~nSet column header: ' + String((cpu() - ll_cpu))
		ll_cpu = cpu()
		
		//Sort Alarm Data
		This.of_sort_email(istr_group_alarm[i])
		
		//Set Alarm Data
		ll_index = ll_row_index
		For ll_row_index = 1 to ll_alarm_cnt //Rows
			
			//Get target Email index of array from sort ds
			ll_index = This.of_get_email_order(ll_row_index)
			
			//Insert Contract ID
			lole_cell = lole_table.cell(ll_row_index+1,1)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			ls_ctx_id = String(istr_group_alarm[i].astr_alarm[ll_index].ctx_id)
			lole_selection.TypeText(String(ls_ctx_id))
			//Add to ctx id list
			If Pos(',' + ls_ctx_id_list,','+ls_ctx_id+',') = 0 Then
				ls_ctx_id_list += ls_ctx_id + ','
			End If
			
			ls_doc_id = String(istr_group_alarm[i].astr_alarm[ll_index].doc_id)
			If Pos(',' + ls_doc_id_list,','+ls_doc_id+',') = 0 Then
				ls_doc_id_list += ls_doc_id + ','
			End If		
			ls_ai_id = String(istr_group_alarm[i].astr_alarm[ll_index].ai_id)
			If Pos(',' + ls_ai_id_list,','+ls_ai_id+',') = 0 Then
				ls_ai_id_list += ls_ai_id + ','
			End If		
			
			//Added By Ken.Guo 12/26/2012. Added Level id2 and level id2
			ls_level_id1 = String(istr_group_alarm[i].astr_alarm[ll_index].level_id1)
			If Pos(',' + ls_level_id1_list,','+ls_level_id1+',') = 0 Then
				ls_level_id1_list += ls_level_id1 + ','
			End If
			ls_level_id2 = String(istr_group_alarm[i].astr_alarm[ll_index].level_id2)
			If Pos(',' + ls_level_id2_list,','+ls_level_id2+',') = 0 Then
				ls_level_id2_list += ls_level_id2 + ','
			End If					
			
			//Insert Company
			lole_cell = lole_table.cell(ll_row_index+1,2)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			lole_selection.TypeText(istr_group_alarm[i].astr_alarm[ll_index].ctx_company)
			
			//Insert Alarm Type
			lole_cell = lole_table.cell(ll_row_index+1,3)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			lole_selection.TypeText(istr_group_alarm[i].astr_alarm[ll_index].as_column_name)
			
			//Insert Date
			lole_cell = lole_table.cell(ll_row_index+1,4)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			lole_selection.TypeText(String(istr_group_alarm[i].astr_alarm[ll_index].alm_date_value,'mm/dd/yyyy'))
			
			//Insert Times Reminded
			lole_cell = lole_table.cell(ll_row_index+1,5)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			If Left(istr_group_alarm[i].astr_alarm[ll_index].as_from ,2)= 'WF' and istr_group_alarm[i].astr_alarm[ll_index].alm_times_reminded <> 0 Then
				ls_reminder = 'At Least One'
			Else
				ls_reminder = String(istr_group_alarm[i].astr_alarm[ll_index].alm_times_reminded)			
			End If
			lole_selection.TypeText(ls_reminder)
			
			//Insert Notes
			lole_cell = lole_table.cell(ll_row_index+1,6)
			lole_cell.select()
			lole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
			lole_selection.TypeText(istr_group_alarm[i].astr_alarm[ll_index].as_notes)
			
			//Added By Ken.Guo 2010-11-16. Email Audit(notes field)
			If ls_notes <> '' Then ls_notes += '~r~n'
			ls_notes += 'CTX ID: ' + String(ls_ctx_id) + '~r~n'
			ls_notes += 'Company: ' + istr_group_alarm[i].astr_alarm[ll_index].ctx_company + '~r~n'
			If istr_group_alarm[i].astr_alarm[ll_index].doc_id > 0 Then
				ls_notes += 'Document: ' + String(istr_group_alarm[i].astr_alarm[ll_index].doc_id) + ', '  +  istr_group_alarm[i].astr_alarm[ll_index].doc_name
			End If
			If Left(istr_group_alarm[i].astr_alarm[ll_index].as_from ,2)= 'WF' Then
				ls_notes += 'Email Type: Due Date Reminder' + '~r~n'
				ls_notes += 'Work Flow: ' + gnv_data.of_getitem( 'wf_workflow','wf_name', 'wf_id = ' + String(istr_group_alarm[i].astr_alarm[ll_index].wf_id) ) + '~r~n'
			Else
				//Added By Ken.Guo 12/26/2012. Added Alarm Type for Group Email
				ls_alarm_type = invo_notification.of_get_alarm_type( istr_group_alarm[i].astr_alarm[ll_index].alm_table )
				ls_notes += 'Email Type: ' + ls_alarm_type + '~r~n'
			End If			
			ls_notes += 'Field Name: ' + istr_group_alarm[i].astr_alarm[ll_index].as_column_name + ' ('+ istr_group_alarm[i].astr_alarm[ll_index].alm_column + ')~r~n'
	
		Next
		ls_info += '~r~nSet column data: ' + String((cpu() - ll_cpu))	
		ll_cpu = cpu()
		//Messagebox('Debug Time',ls_info)
		
		w_email_edit.ole_word.object.ActiveDocument.Content.Select()
		lb_found =  w_email_edit.ole_word.object.ActiveDocument.ActiveWindow.Selection.Find.Execute("\$\<Alarm List\>\$", false, true, true, false, false, true, 0, false, "", 0 ) 
	Loop	

	//Set ctx_id_list for 
	gstr_email_info.ss_ctx_id_list = Left(ls_ctx_id_list,Len(ls_ctx_id_list) - 1)
	
	 lnv_Mail.of_set_combine_status(false) //(Appeon)Harry 03.11.2014 - for Bug # 3887
	//Send Email
	ll_Return = lnv_Mail.of_SendHtml( istr_group_alarm[i].as_sender, ls_MailTo, '', '',ls_subject , w_email_edit.ole_Word, ls_attach, lb_auto_sign,0,0,0  ) 
	
	//Track it if failed
	If ll_return <> 0 Then 
		gstr_email_info.ss_email_from = istr_group_alarm[i].astr_alarm[1].alm_table + '_alarm'
		gstr_email_info.sl_ctx_id = istr_group_alarm[i].astr_alarm[1].ctx_id
		gstr_email_info.ss_column_name = istr_group_alarm[i].astr_alarm[1].alm_column
		gstr_email_info.sl_action_id = istr_group_alarm[i].astr_alarm[1].ai_id
		gstr_email_info.sl_doc_id =istr_group_alarm[i].astr_alarm[1].doc_id
		gstr_email_info.sl_wf_id = istr_group_alarm[i].astr_alarm[1].wf_id
		If lnv_Mail.is_sendprotocol = 'SMTP' Then
			f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		Else
			f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
		End If
		//Reset Structure
		gstr_email_info = lstr_email_info	
		li_send_result = -1
		//Exit
	End If
	
	//Added By Ken.Guo 2010-11-15. Email Audit
	String ls_errtext,ls_attachfilename,ls_columnname,ls_computer_info
	n_cst_string lnv_string
	If ll_Return <> 0 then 
		ls_errtext = gnv_message.of_get_error_message( ll_Return)
	End If
	ls_attachfilename = lnv_string.of_get_file_name( ls_attach, ',') 
	ls_ctx_id_list = Mid(Left(ls_ctx_id_list,Len(ls_ctx_id_list) - 1),1,1000)
	ls_doc_id_list = Mid(Left(ls_doc_id_list,Len(ls_doc_id_list) - 1),1,1000)
	ls_ai_id_list =  Mid(Left(ls_ai_id_list,Len(ls_ai_id_list) - 1),1,1000)
	
	//Added By Ken.Guo 12/26/2012
	ls_level_id1_list =  Mid(Left(ls_level_id1_list,Len(ls_level_id1_list) - 1),1,1000)
	ls_level_id2_list =  Mid(Left(ls_level_id2_list,Len(ls_level_id2_list) - 1),1,1000)
	
	ls_notes = Mid(ls_notes,1,8000)
	If ls_ctx_id_list = '0' Then ls_ctx_id_list = ''
	If ls_doc_id_list = '0' Then ls_doc_id_list = ''
	If ls_ai_id_list = '0' Then ls_ai_id_list = ''
	If ls_level_id1_list = '0' Then ls_level_id1_list = ''
	If ls_level_id2_list = '0' Then ls_level_id2_list = ''
	
	If ll_alarm_cnt = 1 Then
		ls_field_name = istr_group_alarm[i].astr_alarm[ll_index].as_column_name + ' ('+ istr_group_alarm[i].astr_alarm[ll_index].alm_column + ')'
		ll_wf_id = 	istr_group_alarm[i].astr_alarm[ll_index].wf_id			
	Else
		ls_field_name = ''
		ll_wf_id = 	ll_null
	End If	
	ls_computer_info = lnv_Mail.of_get_compute_info( )
	
	//Modified By Ken.Guo 12/26/2012. Added Level id2 and level id2
	Insert Into em_mail_audit
	(user_id,mail_from,mail_to,mail_cc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,level_id1_list, level_id2_list,wf_id,alarm_type,field_name,send_result,error_text,notes,compute_info)
	Values 
	(:gs_user_id,:istr_group_alarm[i].as_sender,:ls_MailTo,'',:ls_subject,getdate(),:ls_attachfilename,:ll_email_template_id,:ls_ctx_id_list,:ls_doc_id_list,:ls_ai_id_list,:ls_level_id1_list, :ls_level_id2_list,:ll_wf_id,'Group Email',:ls_field_name,:li_send_result,:ls_errtext,:ls_notes,:ls_computer_info);

	If ll_return <> 0 Then  Exit
	
	//Reset Structure
	gstr_email_info = lstr_email_info
	
	//Close
	w_email_edit.ole_word.of_Close()
Next

IF w_email_edit.ole_word.object.doctype = 1 THEN 
	w_email_edit.ole_word.of_Close()
End If
Close(w_email_edit)
lnv_Mail.of_DeleteObject()	

If ll_return <> 0 Then 
	Return -1
Else
	Return 1
End If


end function

public function integer of_group_get_email_template (ref string as_subject, ref string as_attach, ref blob ablb_message, ref boolean ab_sign);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_notification.of_group_get_email_template()
// $<arguments>
//		reference	string 	as_subject  		
//		reference	string 	as_attach   		
//		reference	blob   	ablb_message		
//		reference	boolean	ab_sign     		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-10 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_email_id
String ls_attach[],ls_subject,ls_auto_sign
n_cst_ctx_mail lnv_mail

//Get Group Email ID
ll_email_id = Long(gnv_data.of_getItem( 'icred_settings', 'group_email_template', False))
If isnull(ll_email_id) or ll_email_id <= 0 Then
	Messagebox('Group Email Alarm','You have not selected the Group Email Alarm template, please select it first in the Application Settings.')
	Return -1
End If

//Get Template's subject and anto_sign 
Select subject,auto_sign Into :ls_subject,:ls_auto_sign From wf_email Where email_id = :ll_email_id;
If SQLCA.sqlcode <> 0 Then
	Messagebox('Group Email Alarm','Failed to get the Group Email Alarm Template (ID = '+String(ll_email_id)+').')
	Return -1
End If
If ls_subject = '' or isnull(ls_subject) Then
	as_subject = 'Contract Date Alarm(s)'
Else
	as_subject = ls_subject
End If

If ls_auto_sign = 'Y' Then
	ab_sign = True
Else
	ab_sign = False
End If

//Get Template's Message
lnv_mail.of_get_mail_template(ll_email_id, ablb_message)

//Get Template's Attachment
lnv_mail.of_get_mail_template_attachment(ll_email_id,ls_attach[])
For i = 1 To UpperBound(ls_attach[])
	as_attach += ls_attach[i] + ','
Next
If Len(as_attach) > 0 Then 
	as_attach = Mid(as_attach,1, Len(as_attach) - 1)
End If


Return 1
end function

public function integer of_sort_email (str_group_alarm astr_group_alarm);Long i,ll_row

If Not isvalid(ids_ctx_order) Then ids_ctx_order = Create DataStore
ids_ctx_order.DataObject = 'd_ctx_order'

For i = 1 To UpperBound(astr_group_alarm.astr_alarm[])
	ll_row = ids_ctx_order.InsertRow(0)
	ids_ctx_order.SetItem(ll_row,'Index',i)
	ids_ctx_order.SetItem(ll_row,'ctx_id',astr_group_alarm.astr_alarm[i].ctx_id)
Next
ids_ctx_order.SetSort('ctx_id ASC')
ids_ctx_order.Sort()

Return 1
end function

public function long of_get_email_order (long al_index);long ll_row,ll_index

ll_row = al_index
If Not isvalid(ids_ctx_order) Then Return al_index

If ids_ctx_order.RowCount() < ll_row Then Return al_index
ll_index = ids_ctx_order.GetItemNumber(ll_row,'index')
If ll_index > 0 Then
	Return ll_index
Else
	Return al_index	
End If


end function

on n_cst_email_alarm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_email_alarm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;
if IsValid(invo_notification) then Destroy invo_notification
If Isvalid(inv_workflow) Then Destroy inv_workflow
If Isvalid(ids_ctx_order) Then Destroy ids_ctx_order
end event

