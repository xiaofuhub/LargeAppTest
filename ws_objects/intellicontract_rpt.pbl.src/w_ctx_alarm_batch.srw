$PBExportHeader$w_ctx_alarm_batch.srw
forward
global type w_ctx_alarm_batch from w_response
end type
type ole_message from u_email_edit within w_ctx_alarm_batch
end type
type cbx_min from checkbox within w_ctx_alarm_batch
end type
type cb_refresh from commandbutton within w_ctx_alarm_batch
end type
type cb_report from commandbutton within w_ctx_alarm_batch
end type
type tv_datefields from treeview within w_ctx_alarm_batch
end type
type st_unalarm_cnt from statictext within w_ctx_alarm_batch
end type
type st_ctx_cnt from statictext within w_ctx_alarm_batch
end type
type rb_not from radiobutton within w_ctx_alarm_batch
end type
type rb_all from radiobutton within w_ctx_alarm_batch
end type
type cb_load from commandbutton within w_ctx_alarm_batch
end type
type cb_field from commandbutton within w_ctx_alarm_batch
end type
type cb_help from commandbutton within w_ctx_alarm_batch
end type
type cb_default from commandbutton within w_ctx_alarm_batch
end type
type cb_ok from u_cb within w_ctx_alarm_batch
end type
type cb_cancel from u_cb within w_ctx_alarm_batch
end type
type dw_alm_det from u_dw_contract within w_ctx_alarm_batch
end type
type gb_1 from u_gb within w_ctx_alarm_batch
end type
type sle_subject from singlelineedit within w_ctx_alarm_batch
end type
type gb_2 from u_gb within w_ctx_alarm_batch
end type
type st_2 from statictext within w_ctx_alarm_batch
end type
type dw_alm_msg from u_dw_contract within w_ctx_alarm_batch
end type
type gb_3 from u_gb within w_ctx_alarm_batch
end type
type gb_4 from u_gb within w_ctx_alarm_batch
end type
type gb_5 from u_gb within w_ctx_alarm_batch
end type
type st_1 from statictext within w_ctx_alarm_batch
end type
end forward

global type w_ctx_alarm_batch from w_response
integer width = 4507
integer height = 2728
string title = "Batch Set Date Alarms"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
event type integer ue_updatecurrentctx ( )
event type integer ue_updateallctx ( )
ole_message ole_message
cbx_min cbx_min
cb_refresh cb_refresh
cb_report cb_report
tv_datefields tv_datefields
st_unalarm_cnt st_unalarm_cnt
st_ctx_cnt st_ctx_cnt
rb_not rb_not
rb_all rb_all
cb_load cb_load
cb_field cb_field
cb_help cb_help
cb_default cb_default
cb_ok cb_ok
cb_cancel cb_cancel
dw_alm_det dw_alm_det
gb_1 gb_1
sle_subject sle_subject
gb_2 gb_2
st_2 st_2
dw_alm_msg dw_alm_msg
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
st_1 st_1
end type
global w_ctx_alarm_batch w_ctx_alarm_batch

type variables
str_ctx_info istr_ctx_info[]
Long il_ctx_id_arr[], il_view_id
n_cst_array_db inv_array_db
String is_client_id, is_column_lable
n_ds ids_tabpage_prop, ids_tabpage_screen_default,ids_screen, ids_batch_alarms
w_appeon_gifofwait iw_appeon_gifofwait,iw_appeon_gifofwait2
Long il_first_tvi
str_batch_alarms istr_batch_alarms
str_pass istr_pass
Blob iblb_Message_default

//----Begin Added by Alfee on 06.11.2008 --------------
Long il_ctx_id, il_ai_id, il_doc_id, il_seq_id
long il_level_id1,il_level_id2
String is_table, is_column

Boolean ib_DW_Retrieve = FALSE //added by gavin 2011-12-28
Boolean ib_new_mode = True 
Boolean ib_users_modified = True
Boolean ib_attachment_modified = true
Boolean ib_attachment_from_template = false 
String is_attachment

n_cst_ctx_mail inv_mail 
DataWindowChild idwc_template 
//----End Added ---------------------------------------

CONSTANT STRING SEMICOLON = ";"				//Added by Scofield on 2009-02-23
Boolean ib_delete_attach = true				//Added by Scofield on 2009-02-23

//n_cst_contract inv_contract 08.23.2007 By Jervis

datastore ids_notification_templates
datastore ids_snooze_ctx //added by gavin  2011-12-28
datastore ids_snooze_template //added by gavin  2011-12-28


datastore ids_user_mail_map //Added By Ken.Guo 2010-03-02.
Boolean ib_reset = False //Added By Ken.Guo 09/27/2011. 

n_cst_string inv_string

n_ds ids_view_tab 


end variables

forward prototypes
public function integer wf_retrieve ()
public function integer of_add_notification_users (string as_userlist)
public function integer of_parse_keyvalues ()
public function boolean of_is_messagechanged ()
public subroutine of_set_messagechanged (boolean ab_changed)
public function integer of_set_insertfield ()
public function string of_getfilename (string as_pathname)
public function integer of_set_as_default ()
public function integer of_get_from_default ()
public subroutine of_add_merge_field (string as_merge_field, string as_type)
public subroutine of_ini_data ()
public function integer of_reset_action_items ()
public function integer of_add_notification_users (str_alarm_user astr_alarm, string as_type)
public function integer of_build_screen_fileds ()
public function string of_gettabpagetext (string as_tabname)
public function string of_getscreentext (long al_screen_id)
public function boolean of_gettabpagevisible (string as_tabname, boolean ab_maintab)
public function integer of_build_date_fields (long al_screen_id, string as_table, string as_notification_table, long al_handle)
public function integer of_get_date_alarm_info (long al_handle, ref str_batch_alarms astr_batch_alarms)
public subroutine of_goto_contract ()
public subroutine of_setfocus_detail_date_field (long al_screen_id, string as_column)
public function string of_gen_sql_report (string as_table, string as_column, string as_type)
public function integer of_update_attachment (str_alarm astr_alarm)
public function integer of_update_message (str_alarm astr_alarm)
public function integer of_update_snooze (str_alarm astr_alarm)
public function integer of_batch_update_alarms (str_alarm astr_alarm_base, str_alarm str_alarm_target[])
public function integer of_batch_update_alarms (ref str_alarm astr_alarm[])
public function integer of_get_default_message (long al_view_id, string as_alm_table, string as_alm_column, ref blob ablb_message)
end prototypes

event type integer ue_updatecurrentctx();//-----Begin Modified by Alfee on 06.11.2008-----------
//parent.event pfc_save( )

Long 		ll_rtn,ll_WfID,ll_Length, ll_handle
String 	ls_value
long ll_value, ll_cnt, i
str_alarm lstr_alarm[] 
n_ds lds_unset_alarm_report
String ls_sql_report

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()


//Added By Ken.Guo 2009-09-11.
if dw_alm_msg.RowCount() > 0 then
	ls_value = dw_alm_msg.GetItemString(1, "alm_mailto")
	if (IsNull(ls_value) or Len(Trim(ls_value)) < 1) then 
		MessageBox("Verification","The Users to Notify field cannot be empty!")
		dw_alm_msg.setfocus()
		dw_alm_msg.setcolumn("alm_mailto")
		Return -1
	End If
	
	If Not inv_string.of_check_name(ls_value,0, false)  Then
		Messagebox('Check Email Address','Single quote (~¡®), double quote (¡°) and tilde (~~) are not supported as a character in an email address. ')
		dw_alm_msg.SetColumn('alm_mailto')
		dw_alm_msg.SetFocus()
		Return -11
	End If
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_notification_days")
	if IsNull(ll_value) Then // or ll_value = 0) then  //Allow 0, KenGuo20110803
		MessageBox("Verification","The Days In Advance field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_notification_days")
		Return -1
	End If	
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_frequency")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Reminder Frequency field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_frequency")
		Return -1
	End If	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_total_tries")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Times to Remind field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_total_tries")
		Return -1
	End If		

	//Check Create Action Item. //Added By Ken 09/15/2011. 
	If (dw_alm_msg.GetItemString(1, 'alm_create') = '' or isnull(dw_alm_msg.GetItemString(1, 'alm_create') )) And &
		dw_alm_det.GetItemString( 1,'create_action_item') = 'Y'  Then
			If Messagebox('Verification','You have checked Create Action Item without assigning a user. Do you want to uncheck Create Action Item?',Question!,YesNo!) = 1 Then
				dw_alm_det.SetItem(1,'create_action_item','N')
			Else
				Return -1
			End If
	End If
End If

If is_table = '' or is_column = '' Then
	Messagebox('Update','Please select a date field in the tree view first.')
	Return 0
End If

TreeViewItem ltvi_ctx
String ls_array[]

ll_handle = tv_datefields.FindItem(CurrentTreeItem!, 0)
tv_datefields.GetItem(ll_handle, ltvi_ctx)
If ltvi_ctx.Selectedpictureindex <> 9 Then
	Messagebox('Update','Please select  a contract in the tree view first.')
	Return 0
End If

inv_string.of_parsetoarray( ltvi_ctx.data, ',', ls_array[])
If UpperBound(ls_array[]) < 4 Then 
	Messagebox('Update','Failed to get the Contract Date information. Please select  a contract in the tree view first and then try again.')
	Return -1
End If

//Get Alarms SQL
If Messagebox('Update ',  'Are you sure you want to set this date alarm only for Contract #'+String(ls_array[1])+' ?' , Question!, yesno!) = 2 Then
	Return 0
End If
ls_sql_report = of_gen_sql_report( is_table, is_column, 'all')	

If ls_sql_report = '' Then
	Return -1
End If

//Get CTX and Alarm List/Array
SetPointer(HourGlass!)
lds_unset_alarm_report = Create n_ds
lds_unset_alarm_report.DataObject = 'd_batch_alarm_analysis_report'
lds_unset_alarm_report.SetTransObject(SQLCA)
lds_unset_alarm_report.SetSqlSelect(ls_sql_report)
lds_unset_alarm_report.SetTransObject(SQLCA)
ll_cnt = lds_unset_alarm_report.Retrieve()
If  ll_cnt < 0 Then
	gnv_debug.of_output( True, 'Batch Set Alarms - Get SQL: ' + ls_sql_report)
	Messagebox('Error','Failed to retrieve the alarms. please open the debug log file to view the detail errors.')
End If

lds_unset_alarm_report.SetFilter('ctx_id = ' + ls_array[1] + ' and doc_id = ' + ls_array[2] + ' and ai_id = ' + ls_array[3] + ' and level_id1 = ' + ls_array[4] + ' and level_id2 = ' + ls_array[5])
lds_unset_alarm_report.Filter()

If lds_unset_alarm_report.RowCount() <> 1 Then
	Messagebox('Update','Failed to find the Contract Date information. Please select  a contract in the tree view first and then try again.')
End If

For i = 1 To lds_unset_alarm_report.RowCount()
	lstr_alarm[UpperBound(lstr_alarm[]) + 1].ctx_id = lds_unset_alarm_report.GetItemNumber(i, 'ctx_id')
	lstr_alarm[UpperBound(lstr_alarm[])].alm_table = is_table
	lstr_alarm[UpperBound(lstr_alarm[])].alm_column = is_column
	lstr_alarm[UpperBound(lstr_alarm[])].doc_id = lds_unset_alarm_report.GetItemNumber(i, 'doc_id')
	If is_table = 'ctx_action_item' Then
		lstr_alarm[UpperBound(lstr_alarm[])].level_id1 = lds_unset_alarm_report.GetItemNumber(i, 'ai_id')
	Else
		lstr_alarm[UpperBound(lstr_alarm[])].level_id1 = lds_unset_alarm_report.GetItemNumber(i, 'level_id1')
	End If
	lstr_alarm[UpperBound(lstr_alarm[])].level_id2 = lds_unset_alarm_report.GetItemNumber(i, 'level_id2')
Next

//Batch Set Update Alarms
ll_rtn = of_batch_update_alarms(lstr_alarm[])

If ll_rtn < 0 Then
	Messagebox('Error','Update Failed. ')
Else
	//Messagebox('Date Alarm','Update Successfully.')
	Messagebox('Date Alarm','Update Successful.') //Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
End If

If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report

end event

event type integer ue_updateallctx();//-----Begin Modified by Alfee on 06.11.2008-----------
//parent.event pfc_save( )

Long 		ll_rtn,ll_WfID,ll_Length
String 	ls_value
long ll_value, ll_cnt, i,ll_cnt_distinct, ll_pos
str_alarm lstr_alarm[] 
n_ds lds_unset_alarm_report,lds_unset_alarm_report_distinct
String ls_sql_report,ls_sql_report_distinct

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()


//Added By Ken.Guo 2009-09-11.
if dw_alm_msg.RowCount() > 0 then
	ls_value = dw_alm_msg.GetItemString(1, "alm_mailto")
	if (IsNull(ls_value) or Len(Trim(ls_value)) < 1) then 
		MessageBox("Verification","The Users to Notify field cannot be empty!")
		dw_alm_msg.setfocus()
		dw_alm_msg.setcolumn("alm_mailto")
		Return -1
	End If
	
	If Not inv_string.of_check_name(ls_value,0, false)  Then
		Messagebox('Check Email Address','Single quote (~¡®), double quote (¡°) and tilde (~~) are not supported as a character in an email address. ')
		dw_alm_msg.SetColumn('alm_mailto')
		dw_alm_msg.SetFocus()
		Return -11
	End If
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_notification_days")
	if IsNull(ll_value) Then // or ll_value = 0) then  //Allow 0, KenGuo20110803
		MessageBox("Verification","The Days In Advance field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_notification_days")
		Return -1
	End If	
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_frequency")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Reminder Frequency field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_frequency")
		Return -1
	End If	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_total_tries")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Times to Remind field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_total_tries")
		Return -1
	End If		

	//Check Create Action Item. //Added By Ken 09/15/2011. 
	If (dw_alm_msg.GetItemString(1, 'alm_create') = '' or isnull(dw_alm_msg.GetItemString(1, 'alm_create') )) And &
		dw_alm_det.GetItemString( 1,'create_action_item') = 'Y'  Then
			If Messagebox('Verification','You have checked Create Action Item without assigning a user. Do you want to uncheck Create Action Item?',Question!,YesNo!) = 1 Then
				dw_alm_det.SetItem(1,'create_action_item','N')
			Else
				Return -1
			End If
	End If
End If

If is_table = '' or is_column = '' Then
	Messagebox('Update','Please select a date field in the tree view first.')
	Return 0
End If

//Get Alarms SQL
If rb_all.checked Then
//	If Messagebox('Update ',  'Are you sure you want to batch set alarms for '+is_column_lable+', including all existing alarms?' , Question!, yesno!) = 2 Then
//		Return 0
//	End If
	ls_sql_report = of_gen_sql_report( is_table, is_column, 'all')	
Else
//	If Messagebox('Update ',  'Are you sure you want to batch set alarms for '+is_column_lable+' that do not already have alarms?' , Question!, yesno!) = 2 Then
//		Return 0
//	End If	
	ls_sql_report = of_gen_sql_report( is_table, is_column, 'not')	
End If

If ls_sql_report = '' Then
	Return -1
End If

//Get CTX and Alarm List/Array
SetPointer(HourGlass!)
lds_unset_alarm_report = Create n_ds
lds_unset_alarm_report.DataObject = 'd_batch_alarm_analysis_report'
lds_unset_alarm_report.SetTransObject(SQLCA)
lds_unset_alarm_report.SetSqlSelect(ls_sql_report)
lds_unset_alarm_report.SetTransObject(SQLCA)
//ll_cnt = lds_unset_alarm_report.Retrieve()

//Get CTX Distinct Count
lds_unset_alarm_report_distinct = Create n_ds
ll_pos = Pos(ls_sql_report,'From ctx_basic_info ctx_basic_info_2')
ls_sql_report_distinct = 'Select distinct ctx_basic_info_2.ctx_id ' +  Mid(ls_sql_report, ll_pos)
If ll_pos > 0 Then
	lds_unset_alarm_report_distinct.DataObject = 'd_batch_alarm_analysis_ctx_distinct'
	lds_unset_alarm_report_distinct.SetTransObject(SQLCA)
	lds_unset_alarm_report_distinct.SetSqlSelect(ls_sql_report_distinct)
	lds_unset_alarm_report_distinct.SetTransObject(SQLCA)
End If

//Retrieve Data
gnv_appeondb.of_startqueue( )
	lds_unset_alarm_report.Retrieve()
	lds_unset_alarm_report_distinct.Retrieve()
gnv_appeondb.of_commitqueue( )

ll_cnt = lds_unset_alarm_report.RowCount()
ll_cnt_distinct = lds_unset_alarm_report_distinct.RowCount()

//Warning Message
str_pass lstr_pass_warnning
lstr_pass_warnning.s_string = is_column_lable
lstr_pass_warnning.s_long[1] = ll_cnt //field count
lstr_pass_warnning.s_long[2] = ll_cnt_distinct //ctx_count
OpenWithParm(w_batch_alarm_message, lstr_pass_warnning)
If Message.Doubleparm <> 1 Then
	If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
	If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct		
	Return 0
End If

If  ll_cnt < 0 Then
	gnv_debug.of_output( True, 'Batch Set Alarms - Get SQL: ' + ls_sql_report)
	Messagebox('Error','Failed to retrieve the alarms. please open the debug log file to view the detail errors.')
	If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
	If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct		
	Return -1
End If
If ll_cnt = 0 Then
	Messagebox('Batch Set Alarm','No date alarms need set.')
	If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
	If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct	
	Return -2
End If
For i = 1 To ll_cnt
	lstr_alarm[UpperBound(lstr_alarm[]) + 1].ctx_id = lds_unset_alarm_report.GetItemNumber(i, 'ctx_id')
	lstr_alarm[UpperBound(lstr_alarm[])].alm_table = is_table
	lstr_alarm[UpperBound(lstr_alarm[])].alm_column = is_column
	lstr_alarm[UpperBound(lstr_alarm[])].doc_id = lds_unset_alarm_report.GetItemNumber(i, 'doc_id')
	If is_table = 'ctx_action_item' Then
		lstr_alarm[UpperBound(lstr_alarm[])].level_id1 = lds_unset_alarm_report.GetItemNumber(i, 'ai_id')
	Else
		lstr_alarm[UpperBound(lstr_alarm[])].level_id1 = lds_unset_alarm_report.GetItemNumber(i, 'level_id1')
	End If
	lstr_alarm[UpperBound(lstr_alarm[])].level_id2 = lds_unset_alarm_report.GetItemNumber(i, 'level_id2')
Next


//Batch Set Update Alarms
ll_rtn = of_batch_update_alarms(lstr_alarm[])
If ll_rtn < 0 Then
	If Messagebox('Error','Update Failed. Do you want to open the result report?', Question! ,YesNo!) = 2 Then
		If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
		If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct
		Return -3
	End If	
Else
	//If Messagebox('Batch Update','Update Successfully. Do you want to open the result report?',Question! ,YesNo!) = 2 Then
	If Messagebox('Batch Update','Update Successful. Do you want to open the result report?',Question! ,YesNo!) = 2 Then	 //Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
		If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
		If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct
		Return -4
	End If
End If

//Open Result Window
str_pass lstr_pass
lstr_pass.s_ds = lds_unset_alarm_report
lstr_pass.s_string_array[1] = is_table
lstr_pass.s_string_array[2] = is_column
lstr_pass.s_string_array[3] = is_column_lable
lstr_pass.s_string_array[13] = 'ds' //Pass DataStore 
For i = 1 To ll_cnt
	lds_unset_alarm_report.SetItem(i, 'result' , lstr_alarm[i].as_result )
Next 

OpenWithParm(w_batch_alarm_report,lstr_pass )

If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
If isvalid(lds_unset_alarm_report_distinct) Then Destroy lds_unset_alarm_report_distinct
end event

public function integer wf_retrieve ();blob lblb_empty

DataWindowChild	ldwc_Child
dw_alm_det.GetChild('wf_id',ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)


If Not isvalid(iw_appeon_gifofwait2) Then
	Open(iw_appeon_gifofwait2)
	Timer(0,iw_appeon_gifofwait2)
	If Isvalid(iw_appeon_gifofwait2) Then iw_appeon_gifofwait2.of_settext('Initializing Date Alarm Data...')
	If Isvalid(iw_appeon_gifofwait2) Then iw_appeon_gifofwait2.of_setposition(20)		
End If

//Initilize email template //DataWindowChild idwc_template
dw_alm_msg.Getchild( "alm_email_template_id", idwc_template)
idwc_template.Settransobject( SQLCA )

iblb_Message_default = lblb_empty
gnv_appeondb.of_startqueue( )
	ldwc_Child.Retrieve()
	idwc_template.Retrieve( )
	ids_user_mail_map.Retrieve()
	ids_view_tab.Retrieve()
	ids_snooze_template.Retrieve(il_view_id ,is_table,is_column)
	ids_notification_templates.Retrieve(il_view_id, is_table,is_column)
//	Delete from ctx_alm_snooze Where ctx_id = 0 and (view_id = 0 or view_id isnull ) and  alm_table =:is_table and alm_column = :is_column;
//	SelectBlob alm_message_blob Into :iblb_Message_default From ctx_notification_templates Where view_id = :il_view_id and alm_table = :is_table and alm_column = :is_column;
gnv_appeondb.of_commitqueue( )

of_get_default_message(il_view_id, is_table, is_column, iblb_Message_default )

ids_snooze_ctx.reset()
dw_alm_det.event pfc_retrieve( ) //Reset data

If Isvalid(iw_appeon_gifofwait2) Then iw_appeon_gifofwait2.of_setposition(80)	

ldwc_Child.InsertRow(1)
idwc_template.Insertrow( 1 )
idwc_template.SetItem( 1, "email_id", 0)
idwc_template.SetItem( 1, "email_name", "Blank Email")

//share data
dw_alm_det.ShareData(dw_alm_msg) //Alfee 02.22.2008

//Set Subject - jervis 12.02.2010
if dw_alm_msg.rowcount( ) > 0 then sle_subject.text = dw_alm_msg.GetItemString( 1,"alm_subject")

IF ib_new_mode And IsNull(dw_alm_msg.GetItemNumber(1, 'alm_email_template_id') ) THEN 
	dw_alm_msg.SetItem(1, 'alm_email_template_id', 0)
END IF

//Set insert field button
of_set_insertfield()
SetPointer(HourGlass!)
//Get and display alert message
IF ib_new_mode THEN
	If Len(iblb_Message_default) > 0 Then
		ole_Message.of_Open(iblb_Message_default)
		cb_load.enabled = True
	Else
		ole_Message.of_Open( )	
		cb_load.enabled = False
//		of_ini_data() //Added By Ken 09/15/2011. 
	End If
END IF

If Isvalid(iw_appeon_gifofwait2) Then iw_appeon_gifofwait2.of_setposition(100)	
If Isvalid(iw_appeon_gifofwait2) Then Close(iw_appeon_gifofwait2)	


return 0
end function

public function integer of_add_notification_users (string as_userlist);//Add notification users  - Alfee 06.11.2008

Long i, j
String ls_current_users[], ls_new_users[], ls_new_userlist, ls_mailto
n_cst_string lnv_string

IF Len(Trim(as_userlist)) < 1 THEN RETURN 0
IF dw_alm_msg.rowcount() < 1 THEN RETURN 0

dw_alm_msg.AcceptText() //alfee 12.10.2008
ls_mailto = dw_alm_msg.getitemstring(1, 'alm_mailto')
IF IsNull(ls_mailto) OR Len(Trim(ls_mailto)) < 1 THEN
	dw_alm_msg.SetItem(1, 'alm_mailto', as_userlist)
ELSE
	lnv_string.of_parsetoarray(Trim(ls_mailto), ';', ls_current_users)
	lnv_string.of_parsetoarray(Trim(as_userlist), ';', ls_new_users)
	FOR i = 1 to UpperBound(ls_new_users) 
		FOR j = 1 to UpperBound(ls_current_users)
			IF Upper(Trim(ls_new_users[i])) = Upper(Trim(ls_current_users[j])) THEN EXIT	
		NEXT
		//Skip the duplicated user
		IF j <= UpperBound(ls_current_users) THEN CONTINUE
		//Keep the user in new user list
		IF Len(ls_new_userlist) < 1 THEN
			ls_new_userlist = ls_new_users[i]
		ELSE
			ls_new_userlist += '; ' + ls_new_users[i]
		END IF
	NEXT
	//Add them to current user list	
	IF Len(ls_new_userlist) > 0 THEN 
		IF	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + '; '
		ls_mailto = ls_mailto + ls_new_userlist
		dw_alm_msg.SetItem(1, 'alm_mailto', ls_mailto)
	END IF
END IF	

RETURN 1
end function

public function integer of_parse_keyvalues ();
//Added By Ken.Guo 11/22/2012
istr_pass.s_string_array[2] = istr_batch_alarms.as_alm_table
istr_pass.s_string_array[3] = istr_batch_alarms.as_alm_column
istr_pass.s_string_array[4] = istr_batch_alarms.as_column_label
istr_pass.s_string_array[1] = '0' //ctx id or doc_id 
istr_pass.s_string_array[5] = '0' //seq no
istr_pass.s_string_array[6] = '0' //level id 1
istr_pass.s_string_array[7] = '0' //level id 2


is_table = istr_pass.s_string_array[2]
is_column = istr_pass.s_string_array[3]
is_column_lable = istr_pass.s_string_array[4]

CHOOSE CASE Upper(istr_pass.s_string_array[2])
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		il_ctx_id = long(istr_pass.s_string_array[1])
	CASE 'CTX_ACTION_ITEM'
		il_ctx_id = long(istr_pass.s_string_array[1])
		il_ai_id = long(istr_pass.s_string_array[5])
	CASE 'CTX_AM_ACTION_ITEM'
		il_doc_id = long(istr_pass.s_string_array[1])
		il_seq_id = long(istr_pass.s_string_array[5])
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' //add custom multi data  - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		il_ctx_id = long(istr_pass.s_string_array[1])
		il_doc_id = 0
		il_level_id1 =  long(istr_pass.s_string_array[6])
		il_level_id2 = long(istr_pass.s_string_array[7])
END CHOOSE

RETURN 1
end function

public function boolean of_is_messagechanged ();//Alfee 06.11.2008
IF ole_message.object.doctype <> 1 THEN RETURN FALSE

RETURN (not ole_message.object.activedocument.saved)
end function

public subroutine of_set_messagechanged (boolean ab_changed);//Alfee 06.11.2008
IF ole_message.object.doctype <> 1 THEN RETURN 

ole_message.object.activedocument.saved = (Not ab_changed)
end subroutine

public function integer of_set_insertfield ();//Alfee 06.11.2008
Long ll_email_id, ll_export_id, ll_found 

IF dw_alm_msg.RowCount( ) < 1 THEN RETURN 0

ll_email_id = dw_alm_msg.GetItemNumber(1,'alm_email_template_id')
IF IsNull(ll_email_id) OR ll_email_id = 0 THEN
	cb_field.Enabled = FALSE
	RETURN 1	
END IF

ll_found = idwc_template.Find('email_id = ' + String(ll_email_id), 1, idwc_template.RowCount())
IF ll_found > 0 THEN ll_export_id = idwc_template.GetItemNumber(ll_found,'export_id')
IF IsNull(ll_export_id ) or ll_export_id < 1 THEN
	cb_field.Enabled = FALSE
ELSE
	cb_field.Enabled = TRUE
END IF

RETURN 1

	

end function

public function string of_getfilename (string as_pathname);long	ll_Pos,ll_LastPos

as_PathName = Trim(as_PathName)

ll_Pos = Pos(as_PathName,"\")
do while ll_Pos > 0
	ll_LastPos = ll_Pos
	ll_Pos = Pos(as_PathName,"\",ll_Pos + 1)
loop

Return Trim(Mid(as_PathName,ll_LastPos + 1))

end function

public function integer of_set_as_default ();Boolean lb_new,lb_set_snooze = False
Long ll_Pos,ll_AttachCnts,i,ll_id,ll_find,ll_attach_id
String ls_PathName,ls_FileName,ls_AttachName[]
Blob lblb_attachment[]
n_cst_filesrv lnv_filesrv
String ls_Attachment
n_cst_ctx_mail lnv_mail 
Long ll_email_id
String ls_attach_name
String ls_attach_name_arr[]
Long ll_attach_id_arr[] 

If Not isvalid(gw_contract) Then Return -1

lnv_filesrv = Create n_cst_filesrv

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	Timer(0,w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Saving as Default Date Alarm...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)	
End If

SetPointer(HourGlass!)
dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()

DataStore lds_snooze_ctx
lds_snooze_ctx = Create DataStore
lds_snooze_ctx.Dataobject = 'd_ctx_alm_snooze'
lds_snooze_ctx.SetTransObject(SQLCA)

DataStore lds_snooze_template
lds_snooze_template = Create DataStore
lds_snooze_template.Dataobject = 'd_ctx_alm_snooze_template'
lds_snooze_template.SetTransObject(SQLCA)


gnv_appeondb.of_startqueue( )
	lds_snooze_ctx.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2) //add by jervis - 06.30.2011
	lds_snooze_template.Retrieve(il_view_id ,is_table,is_column)
	ids_notification_templates.Retrieve(il_view_id, is_table,is_column)
gnv_appeondb.of_commitqueue( )


ll_find = ids_notification_templates.Find('view_id = '+String(il_view_id) +' and alm_table = "' +String(is_table) +'" and alm_column = "'+String(is_column)+'"',1,ids_notification_templates.rowcount())
If ll_find <= 0 Then
	ll_find = ids_notification_templates.InsertRow(0)
	lb_new = True
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(30)

//Set Default Value
ids_notification_templates.SetItem(ll_find,'view_id',il_view_id)
ids_notification_templates.SetItem(ll_find,'alm_table',is_table)
ids_notification_templates.SetItem(ll_find,'alm_column',is_column)
ids_notification_templates.SetItem(ll_find,'alm_enabled',dw_alm_det.getItemString(1,'alm_enabled'))
ids_notification_templates.SetItem(ll_find,'alm_notification_days',dw_alm_det.getItemNumber(1,'alm_notification_days'))
ids_notification_templates.SetItem(ll_find,'alm_frequency',dw_alm_det.getItemNumber(1,'alm_frequency'))
ids_notification_templates.SetItem(ll_find,'alm_total_tries',dw_alm_det.getItemNumber(1,'alm_total_tries'))
ids_notification_templates.SetItem(ll_find,'alm_auto_increment_years',dw_alm_det.getItemNumber(1,'alm_auto_increment_years'))
ids_notification_templates.SetItem(ll_find,'alm_auto_increment_unit',dw_alm_det.getItemString(1,'alm_auto_increment_unit'))
ids_notification_templates.SetItem(ll_find,'create_action_item',dw_alm_det.getItemString(1,'create_action_item'))
ids_notification_templates.SetItem(ll_find,'alm_action_title',dw_alm_det.getItemString(1,'alm_action_title'))
ids_notification_templates.SetItem(ll_find,'wf_id',dw_alm_det.getItemNumber(1,'wf_id'))
ids_notification_templates.SetItem(ll_find,'alm_email_template_id',dw_alm_msg.getItemNumber(1,'alm_email_template_id'))
ids_notification_templates.SetItem(ll_find,'auto_sign',dw_alm_msg.getItemString(1,'auto_sign'))
ids_notification_templates.SetItem(ll_find,'alm_attachment_name',dw_alm_msg.getItemString(1,'alm_attachment_name'))
ids_notification_templates.SetItem(ll_find,'alm_mailto',dw_alm_msg.getItemString(1,'alm_mailto'))
ids_notification_templates.SetItem(ll_find,'alm_subject',dw_alm_msg.getItemString(1,'alm_subject'))
ids_notification_templates.SetItem(ll_find,'alm_create',dw_alm_msg.getItemString(1,'alm_create'))

//Save Snooze Advance Settings
For i = 1 To lds_snooze_template.RowCount()
	lds_snooze_template.DeleteRow(i)
Next

//Added By Ken.Guo 11/29/2012
If il_ctx_id = 0 Then
	lds_snooze_ctx.Reset()
	ids_snooze_ctx.RowsCopy(1,ids_snooze_ctx.RowCount(), Primary!,lds_snooze_ctx,1 , Primary!  )
End If

For i = 1 To lds_snooze_ctx.RowCount()
	lds_snooze_template.InsertRow(0)
	lds_snooze_template.SetItem(i,'ctx_id',0)
	//add level id - jervis 06.30.2011
	lds_snooze_template.SetItem(i,'doc_id',0)
	lds_snooze_template.SetItem(i,'level_id1',0)
	lds_snooze_template.SetItem(i,'level_id2',0)
	
	lds_snooze_template.SetItem(i,'view_id',il_view_id)
	lds_snooze_template.SetItem(i,'alm_table',is_table)
	lds_snooze_template.SetItem(i,'alm_column',is_column)
	If lds_snooze_ctx.GetItemNumber(i,'asnooze_executed') = 0 and lb_set_snooze = False and dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') > 0 Then
		lds_snooze_template.SetItem(i,'increment_value',dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') )
		lds_snooze_template.SetItem(i,'increment_unit',dw_alm_det.GetItemString(1,'alm_auto_increment_unit'))				
		lb_set_snooze = true
	Else
		lds_snooze_template.SetItem(i,'increment_value',lds_snooze_ctx.GetItemNumber(i,'increment_value') )
		lds_snooze_template.SetItem(i,'increment_unit',lds_snooze_ctx.GetItemString(i,'increment_unit'))		
	End If
	
	lds_snooze_template.SetItem(i,'asnooze_executed',0)	
	lds_snooze_template.SetItem(i,'snooze_loop',lds_snooze_ctx.GetItemNumber(i,'snooze_loop'))
Next
If lds_snooze_ctx.RowCount() > 0 and ids_notification_templates.GetItemNumber(ll_find,'alm_auto_increment_years') > 0 Then
	ids_notification_templates.SetItem(ll_find,'alm_auto_increment_years',lds_snooze_template.GetItemNumber(1,'increment_value'))
	ids_notification_templates.SetItem(ll_find,'alm_auto_increment_unit',lds_snooze_template.GetItemString(1,'increment_unit'))	
End If


If ids_notification_templates.update() = 1 Then
	//Attachment from an email template
	IF ib_attachment_from_template THEN
		ll_email_id = 	dw_alm_msg.GetItemNumber(1, 'alm_email_template_id')
		ls_attach_name = dw_alm_msg.GetItemString(1, 'alm_attachment_name')
		IF IsNull(ll_email_id) THEN ll_email_id = 0
		IF IsNull(ls_attach_name) THEN ls_attach_name = ''
		IF ll_email_id > 0 and Len(Trim(ls_attach_name)) > 0 THEN
			lnv_mail.of_get_mail_template_attachment(ll_email_id, ls_AttachName[],lblb_attachment[])	
		END IF
	END IF
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(40)
	
	//Save attachment from a local file
	ls_Attachment = is_Attachment
	if Not (IsNull(ls_Attachment) or Trim(ls_Attachment) = "") then
		if Right(ls_Attachment,1) <> SEMICOLON then ls_Attachment += SEMICOLON
		ll_Pos = Pos(ls_Attachment,SEMICOLON)
		do while ll_Pos > 0
			ls_PathName = Trim(Left(ls_Attachment,ll_Pos - 1))
			ls_FileName = of_GetFileName(ls_PathName)
			if FileExists(ls_PathName) and ls_FileName <> "" then
				ls_AttachName[UpperBound(ls_AttachName) + 1] = ls_FileName
				lnv_FileSrv.of_FileRead(ls_PathName,lblb_attachment[UpperBound(lblb_attachment[]) + 1])
			end if
			ls_Attachment = Trim(Mid(ls_Attachment,ll_Pos + 1))
			ll_Pos = Pos(ls_Attachment,SEMICOLON)
		loop
	end if
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(50)
	
	lds_snooze_template.update()
	
	//Acctach 
	ll_AttachCnts = UpperBound(lblb_attachment[])	
	gnv_appeondb.of_startqueue( )
	Delete From ctx_notification_templates_attachments Where view_id = :il_view_id and alm_table = :is_table and alm_column = :is_column;
	Select Max(id) Into :ll_id From ctx_notification_templates_attachments;
	gnv_appeondb.of_commitqueue( )
	If isnull(ll_id) Then ll_id = 0 
	For i = 1 To ll_AttachCnts
		ll_id++
		Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name)
			Values(:ll_id,:il_view_id, :is_table,:is_column,:ls_AttachName[i]);
		UpdateBlob ctx_notification_templates_attachments Set alm_attachment = :lblb_attachment[i] Where id = :ll_id;
	Next
	commit;
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(60)
	//Attach original saved file.
	
	If Not ib_delete_attach and Not ib_new_mode Then
		Choose Case Upper(is_table)
						
			Case 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
				DECLARE cur_attachment CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_alarm_attachment 
						WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column;
				OPEN  cur_attachment;
				FETCH cur_attachment INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:il_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_alarm_attachment Where ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next

			Case 'CTX_ACTION_ITEM'
				
				DECLARE cur_attachment_ai CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_ai_alarm_attachment 
						WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND item_id = :il_ai_id;
				OPEN  cur_attachment_ai;
				FETCH cur_attachment_ai INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment_ai INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment_ai;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:il_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_ai_alarm_attachment Where ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND item_id = :il_ai_id AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next				
				
				
			Case 'CTX_AM_ACTION_ITEM'	
				DECLARE cur_attachment_am_ai CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_am_ai_alarm_attachment 
						WHERE alm_table = :is_table AND alm_column = :is_column AND doc_id = :il_doc_id AND seq_id = :il_seq_id;
				OPEN  cur_attachment_am_ai;
				FETCH cur_attachment_am_ai INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment_am_ai INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment_am_ai;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:il_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_am_ai_alarm_attachment Where alm_table = :is_table AND alm_column = :is_column AND doc_id = :il_doc_id AND seq_id = :il_seq_id AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next			
			case else //add fee scheduce - jervis 08.02.2011
			//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'  //ADD cumtom mulit alarm - jervis 06.30.2011
				
		End Choose
	End If
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(80)

	//Save Message Body.
	Blob lblb_message
	IF ole_message.object.doctype <> 1 THEN 
		If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		RETURN 0
	End If
	ole_Message.of_GetBlob(lblb_message)
	gnv_appeondb.of_startqueue( )
	UpdateBlob ctx_notification_templates Set alm_message_blob = :lblb_message Where view_id = :il_view_id and alm_table = :is_table and alm_column = :is_column;
	Commit;
	gnv_appeondb.of_commitqueue( )
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(100)
Else
	Rollback;
	Messagebox('Error','Failed to save it, please call support.')
End If

If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
SetPointer(Arrow!)
cb_load.enabled = True
Messagebox('Contract Alarm ','Default alarm was set successfully.')

Return 1


end function

public function integer of_get_from_default ();long ll_find
n_cst_ctx_mail lnv_ctx_mail
String ls_AttachName[]
Blob lblb_attachment[]
Long ll_AttachCnts,ll_AttachCycle
String ls_color_disabled

ll_find = ids_notification_templates.Find('view_id = '+String(il_view_id) +' and alm_table = "' +String(is_table) +'" and alm_column = "'+String(is_column)+'"',1,ids_notification_templates.rowcount())
If ll_find <= 0 Then Return 1

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	Timer(0,w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Getting Default Date Alarm...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)	
End If

SetPointer(HourGlass!)

//Set Default Value
dw_alm_det.SetItem(1,'alm_table',ids_notification_templates.getItemString(ll_find,'alm_table'))
dw_alm_det.SetItem(1,'alm_column',ids_notification_templates.getItemString(ll_find,'alm_column'))
dw_alm_det.SetItem(1,'alm_enabled',ids_notification_templates.getItemString(ll_find,'alm_enabled'))
dw_alm_det.SetItem(1,'alm_notification_days',ids_notification_templates.getItemNumber(ll_find,'alm_notification_days'))
dw_alm_det.SetItem(1,'alm_frequency',ids_notification_templates.getItemNumber(ll_find,'alm_frequency'))
dw_alm_det.SetItem(1,'alm_total_tries',ids_notification_templates.getItemNumber(ll_find,'alm_total_tries'))
dw_alm_det.SetItem(1,'alm_auto_increment_years',ids_notification_templates.getItemNumber(ll_find,'alm_auto_increment_years'))
dw_alm_det.SetItem(1,'alm_auto_increment_unit',ids_notification_templates.getItemString(ll_find,'alm_auto_increment_unit'))
dw_alm_det.SetItem(1,'create_action_item',ids_notification_templates.getItemString(ll_find,'create_action_item'))
dw_alm_det.SetItem(1,'alm_action_title',ids_notification_templates.getItemString(ll_find,'alm_action_title'))
dw_alm_det.SetItem(1,'wf_id',ids_notification_templates.getItemNumber(ll_find,'wf_id'))
dw_alm_det.SetItem(1,'alm_email_template_id',ids_notification_templates.getItemNumber(ll_find,'alm_email_template_id'))
dw_alm_det.SetItem(1,'auto_sign',ids_notification_templates.getItemString(ll_find,'auto_sign'))
dw_alm_det.SetItem(1,'alm_attachment_name',ids_notification_templates.getItemString(ll_find,'alm_attachment_name'))
dw_alm_det.SetItem(1,'alm_mailto',ids_notification_templates.getItemString(ll_find,'alm_mailto'))
dw_alm_det.SetItem(1,'alm_subject',ids_notification_templates.getItemString(ll_find,'alm_subject'))
dw_alm_det.SetItem(1,'alm_create',ids_notification_templates.getItemString(ll_find,'alm_create'))
If ids_notification_templates.getItemString(ll_find,'create_action_item') = 'N' Then
	ls_color_disabled = dw_alm_det.Describe("alm_last_notification_sent.Background.Color")
	dw_alm_det.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )		
End If

//Get Message
If Len(iblb_Message_default) > 0 Then
	ole_Message.of_Open(iblb_Message_default)
	cb_load.enabled = True
Else
	ole_Message.of_Open( )	
	cb_load.enabled = False
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(50)	

//Get Snooze
Long i
ids_snooze_ctx.Reset()
For i = 1 To ids_snooze_template.RowCount()
	ids_snooze_ctx.InsertRow(0)
	ids_snooze_ctx.SetItem(i,'ctx_id',il_ctx_id)
	ids_snooze_ctx.SetItem(i,'doc_id',il_doc_id)
	ids_snooze_ctx.SetItem(i,'level_id1',il_level_id1)
	ids_snooze_ctx.SetItem(i,'level_id2',il_level_id2)
	ids_snooze_ctx.SetItem(i,'alm_table',is_table)
	ids_snooze_ctx.SetItem(i,'alm_column',is_column)
	ids_snooze_ctx.SetItem(i,'increment_value',ids_snooze_template.GetItemNumber(i,'increment_value') )
	ids_snooze_ctx.SetItem(i,'increment_unit',ids_snooze_template.GetItemString(i,'increment_unit'))
	ids_snooze_ctx.SetItem(i,'asnooze_executed',0)	
	ids_snooze_ctx.SetItem(i,'snooze_loop',ids_snooze_template.GetItemNumber(i,'snooze_loop'))
Next

//Get Attachements
ib_attachment_from_template = False
lnv_ctx_mail.of_get_almattach_template(il_view_id, is_table,is_column,ls_AttachName[],lblb_attachment[])
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(80)	
is_attachment = ''
ll_AttachCnts = UpperBound(lblb_attachment)
if ll_AttachCnts > 0 then
	for ll_AttachCycle = 1 to ll_AttachCnts
		If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(1)
		if Len(lblb_attachment[ll_AttachCycle]) > 0 then
			is_attachment += lnv_ctx_mail.of_write_attachfile(lblb_attachment[ll_AttachCycle],ls_AttachName[ll_AttachCycle]) + SEMICOLON
		end if
	next
	ib_attachment_modified = True
end if

If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_SetPosition(100)
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)	
Return 1
end function

public subroutine of_add_merge_field (string as_merge_field, string as_type);//Alfee 06.11.2008

If not len(as_merge_field) > 0 Then return

IF ole_message.Object.Doctype <> 1 THEN RETURN

//Commented By Ken.Guo 2010-12-06
//ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_merge_field + ">$")


//Jervis 03.30.2010
//Add as_type - Insert Subject/Body

If not len(as_merge_field) > 0 Then return

if as_type = 'body' then
	//--------Begin Modified by Alfee 11.23.2007---------
	//<$Reason>Replaced the email edit control with Word OCX
	IF ole_message.Object.Doctype <> 1 THEN RETURN
	
	ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_merge_field + ">$")
	//dw_email.replacetext("$<"+as_merge_field+">$")
	//--------End Modified --------------------------------
else
	//Begin - Modified By Ken.Guo 2010-12-06
	//sle_subject.replacetext( "$<"+as_merge_field+">$")
	//dw_alm_msg.SetItem(dw_alm_msg.GetRow(),'alm_subject',sle_subject.text)
	dw_alm_msg.SetFocus()
	If dw_alm_msg.GetColumnName() <> 'alm_subject' Then
		dw_alm_msg.SetColumn('alm_subject')
	End If
	dw_alm_msg.replacetext( "$<"+as_merge_field+">$")
	//End - Modified By Ken.Guo 2010-12-06	
end if
end subroutine

public subroutine of_ini_data ();//String ls_owner, ls_owner_email
//SELECT ctx_contacts.user_d,security_users.email_id  into :ls_owner, :ls_owner_email FROM ctx_contract_contacts,ctx_contacts,app_facility,security_users
//WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )
//	AND (ctx_contacts.facility_id = app_facility.facility_id)
//	AND ( ctx_contract_contacts.ctx_id = :il_ctx_id )
//	AND ctx_contract_contacts.owner = 'Y'
//	AND ctx_contract_contacts.ic_area = 'I'  
//	AND security_users.user_id = ctx_contacts.user_d ;
//	
//If 	ls_owner_email = '' or isnull(ls_owner_email) Then Return
//
//str_alarm_user lstr_alarm_user
//lstr_alarm_user.s_create_list = ls_owner
//lstr_alarm_user.s_to_list = ls_owner_email
//lstr_alarm_user.s_flag = 'Y'
//
//this.of_add_notification_users(lstr_alarm_user,'append')
end subroutine

public function integer of_reset_action_items ();//Added By Ken.Guo 09/27/2011.  Delete the action items.

Long ll_ctxid = 0,ll_action_id = 0,ll_doc_id = 0,ll_level_id1 = 0,ll_level_id2 = 0

Choose case lower(is_table)
	case 'ctx_basic_info','ctx_custom'
		ll_ctxid = dw_alm_det.getitemnumber( 1, "ctx_id")
		//delete from ctx_action_items where ctx_id = :ll_ctxid and alm_table = :is_table and alm_column = :is_column ;  
	case 'ctx_action_item','ctx_am_action_item'
		//No Action Items to delete
	case 'ctx_custom_multi_hdr','ctx_custom_multi_detail','ctx_fee_sched_nm'
		ll_ctxid = dw_alm_det.getitemnumber( 1, "ctx_id")
		ll_doc_id = dw_alm_det.getitemnumber( 1, "doc_id")
		ll_level_id1 = dw_alm_det.getitemnumber( 1, "level_id1")
		ll_level_id2 = dw_alm_det.getitemnumber( 1, "level_id2")
		//delete from ctx_action_items where  ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_level_id1 and level_id2 = :ll_level_id2 and alm_table = :is_table and alm_column = :is_column;			
	case else
		//
End Choose

//Update ctx_alm_snooze Set asnooze_executed = 0 where ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :is_table and alm_column = :is_column;	
delete from ctx_action_items where  ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_level_id1 and level_id2 = :ll_level_id2 and alm_table = :is_table and alm_column = :is_column;			


Return 1
end function

public function integer of_add_notification_users (str_alarm_user astr_alarm, string as_type);//Add notification users  - Alfee 06.11.2008

Long i, j
String ls_current_users[], ls_new_users[], ls_new_userlist, ls_mailto
string ls_create_users[],ls_create_list,ls_create_list_all,ls_create_arr[]
n_cst_string lnv_string
string	ls_currentAppointmentuser[] , ls_newAppointmentuser[], ls_appointment_list, ls_appointment



IF Len(Trim(astr_alarm.s_to_list)) < 1 THEN RETURN 0
IF dw_alm_msg.rowcount() < 1 THEN RETURN 0


dw_alm_msg.AcceptText() //alfee 12.10.2008


//Set user list
ls_mailto = dw_alm_msg.getitemstring(1, 'alm_mailto')
ls_create_list = dw_alm_msg.getitemstring(1, 'alm_create') //Added By Ken.Guo 03/20/2012. 
ls_appointment = dw_alm_msg.GetItemString( 1, 'alm_appointment' )//added by gavins 20121024

//---------Begin Modified by (Appeon)Harry 12.09.2014 for V142 ISG-CLX--------
/*
IF IsNull(ls_mailto) OR Len(Trim(ls_mailto)) < 1 THEN
	dw_alm_msg.SetItem(1, 'alm_mailto', lower(astr_alarm.s_to_list ))
ELSE
	lnv_string.of_parsetoarray(Trim(ls_mailto), ';', ls_current_users)
	lnv_string.of_parsetoarray(Trim(lower(astr_alarm.s_to_list )), ';', ls_new_users)
	FOR i = 1 to UpperBound(ls_new_users) 
		FOR j = 1 to UpperBound(ls_current_users)
			IF Upper(Trim(ls_new_users[i])) = Upper(Trim(ls_current_users[j])) THEN EXIT	
		NEXT
		//Skip the duplicated user
		IF j <= UpperBound(ls_current_users) THEN CONTINUE
		//Keep the user in new user list
		IF Len(ls_new_userlist) < 1 THEN
			ls_new_userlist = ls_new_users[i]
		ELSE
			ls_new_userlist += '; ' + ls_new_users[i]
		END IF
	NEXT
	//Add them to current user list	
	IF Len(ls_new_userlist) > 0 THEN 
		IF	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + '; '
		ls_mailto = ls_mailto + ls_new_userlist
		dw_alm_msg.SetItem(1, 'alm_mailto', ls_mailto)
	END IF
END IF
*/
dw_alm_msg.SetItem(1, 'alm_mailto', lower(astr_alarm.s_to_list ))
//---------End Modfiied ------------------------------------------------------

//added by gavins 20121024
dw_alm_msg.SetItem(1, 'alm_appointment', lower(astr_alarm.s_appointment   ))


//set create action item list
if astr_alarm.s_flag = 'N' then
	dw_alm_msg.SetItem(1, 'alm_create', "")
	dw_alm_det.SetItem( 1,'create_action_item','N')
else
	
	If lower(as_type) = 'append' Then
		//Added By Ken.Guo 03/20/2012. Append to create list
		If ls_create_list = '' or isnull(ls_create_list) Then
			ls_create_list_all = astr_alarm.s_create_list
		Else
			ls_create_list_all = ls_create_list +';'+ astr_alarm.s_create_list
		End If
		gnv_string.of_parsetoarray( ls_create_list_all,';', ls_create_arr[] )
		gnv_string.of_delete_duplicate(ls_create_arr[])
		gnv_string.of_arraytostring(ls_create_arr[], ';', ls_create_list_all)
		dw_alm_msg.SetItem(1, 'alm_create', ls_create_list_all )
	Else
		dw_alm_msg.SetItem(1, 'alm_create', astr_alarm.s_create_list )
	End If
	
	//dw_alm_msg.SetItem(1, 'alm_create', astr_alarm.s_create_list )
	dw_alm_det.SetItem( 1,'create_action_item','Y')
end if


RETURN 1
end function

public function integer of_build_screen_fileds ();//====================================================================
// Function: of_build_screen_fileds
//--------------------------------------------------------------------
// Description: Build Date Field TreeView
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 11/13/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_Text, ls_tabname
Long ll_handle_details,ll_handle_date, ll_handle_custom, ll_handle_custom2
Long ll_screen_id, ll_count,i, ll_notsetcount,ll_handle,ll_sum, ll_count_all
TreeViewItem ltvi_Item,ltvi_Item_null


If Not isvalid(iw_appeon_gifofwait) Then
	Open(iw_appeon_gifofwait)
	iw_appeon_gifofwait.of_settext('Building Date Fields Data...')
	Timer(0,iw_appeon_gifofwait)
End If


If isvalid(iw_appeon_gifofwait) Then
	iw_appeon_gifofwait.of_settext('Building Date Fields Data...')
	iw_appeon_gifofwait.of_setposition(30)
End If

tv_datefields.SetRedraw(False)

//Reset
Do While  tv_datefields.FindItem(RootTreeItem!,ll_handle ) > 0
	tv_datefields.Deleteitem( ll_handle )
Loop
ids_batch_alarms.Reset()
Delete From ctx_batch_alarm_analysis Where client_id = :is_client_id ;
is_table = ''
is_column = ''


//Insert Detail Tab
ls_tabname = 'tabpage_details'
If of_gettabpagevisible(ls_tabname,true) and w_Mdi.of_security_access(2090)  = 2 Then
	If isvalid(iw_appeon_gifofwait) Then
		iw_appeon_gifofwait.of_settext('Building Details Date Fields Data...')
		iw_appeon_gifofwait.of_setposition(35)
	End If
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Data = ls_tabname
	ls_Text = of_GetTabpageText(ls_tabname)
	ltvi_Item.Label = ls_Text
	ll_handle_details = tv_datefields.InsertItemLast(0, ltvi_Item)
	
	//Insert Date Screen 
	ll_screen_id = 5
	ls_Text = of_getscreentext(ll_screen_id)
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'ctx_basic_info','ctx_notification',ll_handle_date)
	
	//Insert Custom Screen
	ls_tabname = 'tabpage_det_custom' 
	If of_gettabpagevisible(ls_tabname,false) and w_Mdi.of_security_access(2091)  = 2 Then 
		ls_Text = of_GetTabpageText(ls_tabname) //use tab name replace screen titlebar text
		ll_screen_id = 9
		ltvi_Item = ltvi_Item_null
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
		ltvi_Item.Data = ll_screen_id
		ltvi_Item.Label = ls_Text
		ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
		of_build_date_fields(ll_screen_id,'ctx_basic_info','ctx_notification',ll_handle_date)		
	End If
	
	//Insert Custom2 Screen
	ls_tabname = 'tabpage_det_audit' 
	If of_gettabpagevisible(ls_tabname,false) and w_Mdi.of_security_access(2093)  = 2 Then 
		ls_Text = of_GetTabpageText(ls_tabname) //use tab name replace screen titlebar text
		ll_screen_id = 10
		ltvi_Item = ltvi_Item_null
		ltvi_Item.PictureIndex = 3
		ltvi_Item.SelectedPictureIndex = 4
		ltvi_Item.Data = ll_screen_id
		ltvi_Item.Label = ls_Text
		ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
		of_build_date_fields(ll_screen_id,'ctx_custom','ctx_notification',ll_handle_date)		
	End If	
	
	tv_datefields.expandall( ll_handle_details)
	
End If

//Insert FeeSchdule(NM) Tab
ls_tabname = 'tabpage_fee_sched2'
If of_gettabpagevisible(ls_tabname,true) and w_Mdi.of_security_access(2220)  = 2 Then
	If isvalid(iw_appeon_gifofwait) Then
		iw_appeon_gifofwait.of_settext('Building Fee Schedule Date Fields Data...')
		iw_appeon_gifofwait.of_setposition(45)
	End If	
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Data = ls_tabname
	ls_Text = of_GetTabpageText(ls_tabname)
	ltvi_Item.Label = ls_Text
	ll_handle_details = tv_datefields.InsertItemLast(0, ltvi_Item)
	
	//Insert FeeSchedule Screen 
	ll_screen_id = 31
	ls_Text = of_getscreentext(ll_screen_id)
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'ctx_fee_sched_nm','ctx_all_notification',ll_handle_date)
	tv_datefields.expandall( ll_handle_details)
End If

//Insert Document Action Items
ls_tabname = 'tabpage_images'
If of_gettabpagevisible(ls_tabname,true) and of_gettabpagevisible('tabpage_dm_workflow',false) and w_Mdi.of_security_access(2150)  = 2  and w_Mdi.of_security_access(6935) = 2 Then //documet manager main tab and Work flow sub tab
	If isvalid(iw_appeon_gifofwait) Then
		iw_appeon_gifofwait.of_settext('Building Document Work Flow Date Fields Data...')
		iw_appeon_gifofwait.of_setposition(55)
	End If	
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Data = ls_tabname
	ls_Text = of_GetTabpageText(ls_tabname)
	ltvi_Item.Label = ls_Text
	ll_handle_details = tv_datefields.InsertItemLast(0, ltvi_Item)
	
	//Insert document WF Screen 
	ll_screen_id = 47
	ls_text = of_GetTabpageText( 'tabpage_dm_workflow' ) // Using tab name
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'ctx_am_action_item','ctx_am_ai_notification',ll_handle_date)
	tv_datefields.expandall( ll_handle_details)
End If

//Insert Action Items
ls_tabname = 'tabpage_action_items'
If of_gettabpagevisible(ls_tabname,true)  and w_Mdi.of_security_access(2160) = 2 Then //
	If isvalid(iw_appeon_gifofwait) Then
		iw_appeon_gifofwait.of_settext('Building Action Item Date Fields Data...')
		iw_appeon_gifofwait.of_setposition(65)
	End If	
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Data = ls_tabname
	ls_Text = of_GetTabpageText(ls_tabname)
	ltvi_Item.Label = ls_Text
	ll_handle_details = tv_datefields.InsertItemLast(0, ltvi_Item)
	
	//Insert AI Detail Screen 
	ll_screen_id = 33
	ls_Text = of_getscreentext(ll_screen_id)
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'ctx_action_item','ctx_ai_notification',ll_handle_date)
	tv_datefields.expandall( ll_handle_details)
End If

//Insert Multi Custom Tab
ls_tabname = 'tabpage_multi'
If of_gettabpagevisible(ls_tabname,true) and w_Mdi.of_security_access(2170)  = 2 Then
	If isvalid(iw_appeon_gifofwait) Then
		iw_appeon_gifofwait.of_settext('Building Custom Multi Date Fields Data...')
		iw_appeon_gifofwait.of_setposition(75)
	End If	
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 1
	ltvi_Item.SelectedPictureIndex = 2
	ltvi_Item.Data = ls_tabname
	ls_Text = of_GetTabpageText(ls_tabname)
	ltvi_Item.Label = ls_Text
	ll_handle_details = tv_datefields.InsertItemLast(0, ltvi_Item)
	
	//Insert Multi Custom header Screen 
	ll_screen_id = 53
	ls_Text = of_getscreentext(ll_screen_id)
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'CTX_CUSTOM_MULTI_HDR','ctx_all_notification',ll_handle_date)
	
	//Insert Multi Custom Detail Screen 
	ll_screen_id = 55
	ls_Text = of_getscreentext(ll_screen_id)
	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 3
	ltvi_Item.SelectedPictureIndex = 4
	ltvi_Item.Data = ll_screen_id
	ltvi_Item.Label = ls_Text
	ll_handle_date = tv_datefields.InsertItemLast(ll_handle_details, ltvi_Item)
	of_build_date_fields(ll_screen_id,'CTX_CUSTOM_MULTI_DETAIL','ctx_all_notification',ll_handle_date)	
	tv_datefields.expandall( ll_handle_details)
	
End If


//Save Data
If ids_batch_alarms.Modifiedcount( ) > 0 Then
	If ids_batch_alarms.Update() <> 1 Then
		tv_datefields.SetRedraw(True)
		Messagebox('Error','Failed to save date alarm data to DB.')
//		Close(This)
		Return 1
	End If
End If

If isvalid(iw_appeon_gifofwait) Then
	iw_appeon_gifofwait.of_settext('Calculating Date Fields Count...')
	iw_appeon_gifofwait.of_setposition(85)
End If	

//Use SP to Calculate the alarms(Not Set) count 
 DECLARE lup_date_alarms PROCEDURE FOR up_calculate_date_alarms  
        :is_client_id;
 Execute lup_date_alarms;

//Set the count to the treeview item's label
ll_count = ids_batch_alarms.Retrieve(is_client_id)
For i = 1 To ll_count
	ll_handle_date = ids_batch_alarms.GetItemNumber(i, 'tv_handle')
	ll_notsetcount = ids_batch_alarms.GetItemNumber(i, 'count_notset')
	ll_count_all = ids_batch_alarms.GetItemNumber(i, 'count_all')
	If isnull(ll_notsetcount) Then ll_notsetcount = -1
	ltvi_Item = ltvi_Item_null
	tv_datefields.GetItem( ll_handle_date, ltvi_Item)
	ltvi_Item.Label = ltvi_Item.Label + ' (' +String(ll_notsetcount)+ '/'+String(ll_count_all)+')' 
	If ll_notsetcount > 0 or ( rb_all.checked and ll_count_all > 0) Then
		ltvi_Item.Children = True
	End If
	tv_datefields.SetItem(ll_handle_date,ltvi_Item )
Next 
If ll_Count > 0 Then
	ll_sum = ids_batch_alarms.GetItemNumber( ll_Count , 'compute_count')
Else
	ll_sum = 0
End If
st_unalarm_cnt.text = String(ll_sum) + ' Date Fields have no Alarm Set '

If isvalid(iw_appeon_gifofwait) Then
	iw_appeon_gifofwait.of_settext('Select Date Field...')
	iw_appeon_gifofwait.of_setposition(90)
End If	

If il_first_tvi > 0 Then
	tv_datefields.selectitem( il_first_tvi )
End If

If isvalid(iw_appeon_gifofwait) Then
	iw_appeon_gifofwait.of_setposition(100)
	Close(iw_appeon_gifofwait)
End If	

tv_datefields.SetRedraw(True)

Return 1
end function

public function string of_gettabpagetext (string as_tabname);long ll_FindRow
string ls_Text

ll_FindRow = ids_tabpage_prop.Find("tabpage_name = '" + as_tabname + "'", 1, ids_tabpage_prop.RowCount())
if ll_FindRow > 0 then
	ls_Text = ids_tabpage_prop.GetItemString(ll_FindRow, "text")
end if

//Get Default Text
If ls_text = '' or isnull(ls_text) Then
	ll_findrow = ids_tabpage_screen_default.Find('tabpage_name = "' + as_tabname + '"',1,ids_tabpage_screen_default.rowcount() )
	If ll_findrow > 0  Then
		ls_text = ids_tabpage_screen_default.GetItemString(ll_findrow, 'default_text')
	End If
End If

Return ls_Text

end function

public function string of_getscreentext (long al_screen_id);Long ll_findrow
String ls_text
ll_findrow = ids_screen.Find('screen_id = ' + String(al_screen_id) , 1, ids_screen.rowcount())

If ll_findrow > 0 Then
	ls_text = ids_screen.GetItemString(ll_findrow, 'titlebar_text' )
End If

//Get Default Text
If ls_text = '' or isnull(ls_text) Then
	ll_findrow = ids_tabpage_screen_default.Find('screen_id = ' + String(al_screen_id),1,ids_tabpage_screen_default.rowcount() )
	If ll_findrow > 0  Then
		ls_text = ids_tabpage_screen_default.GetItemString(ll_findrow, 'default_text')
	End If
End If

Return ls_text

end function

public function boolean of_gettabpagevisible (string as_tabname, boolean ab_maintab);long ll_FindRow

ll_FindRow = ids_tabpage_prop.Find("tabpage_name = '" + as_tabname + "'", 1, ids_tabpage_prop.RowCount())
If ll_FindRow > 0 Then
	If ids_tabpage_prop.GetItemString(ll_FindRow, "tab_visible") = 'F' Then
		Return False
	End If
End if

If ab_maintab Then
	ll_FindRow = ids_screen.Find('tab_name = "' +as_tabname+  '"',1 ,ids_screen.RowCount() )
	If ll_FindRow = 0 Then
		Return False			
	End If
End If

Return True

end function

public function integer of_build_date_fields (long al_screen_id, string as_table, string as_notification_table, long al_handle);//====================================================================
// Function: of_build_date_fields
//--------------------------------------------------------------------
// Description: Build Date Alarm Fields.
//--------------------------------------------------------------------
// Arguments:
//                al_screen_id
//                al_handle
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 11/15/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_view_id, ll_ret, ll_field_cnt,i, ll_PosY, ll_handle, ll_count, ll_row
String ls_syntax,ls_err, ls_ColType,ls_ColName,ls_ColVisible,ls_col_text,ls_data
n_ds lds_screen
TreeViewItem ltvi_Item,ltvi_Item_null

ll_view_id = istr_ctx_info[1].al_view_id

//Get Screen Syntax
ls_syntax = f_get_screen_syntax(ll_view_id, al_screen_id, true) 

//Create Screen
lds_screen = Create n_ds
If lds_screen.Create( ls_syntax,ls_err ) <> 1 Then
	gnv_debug.of_output( True, 'Failed to create ds, view_id = ' + String(ll_view_id) + ', screen_id = ' + string(al_screen_id) + '. '+ls_err+'~r~nScreen Syntax: ~r~n' + ls_syntax )
	Return -1
End If

//Find Date Field
ll_field_cnt = Long(lds_screen.describe("DataWindow.Column.Count"))
FOR i = 1 to ll_field_cnt
	ls_ColType =  lds_screen.describe("#" + string(i) + ".ColType")
	ls_ColName =  lds_screen.describe("#" + string(i) + ".Name")
	ls_ColVisible = lds_screen.describe("#" + string(i) + ".visible")
	ll_PosY =  Long(lds_screen.describe("#" + string(i) + ".Y"))
	If Lower(ls_ColType) <> 'datetime' or ls_ColVisible <> '1' or ll_PosY <= 0 Then
		Continue
	End If
	ls_col_text = lds_screen.describe(string(ls_ColName) + "_t.text")
	IF isnull(ls_col_text) or trim(ls_col_text) = '' or ls_col_text = '?' or ls_col_text = '!' Then
		ls_col_text = ls_ColName
	End If		
	//If the date file have no alarm button then continu
	If lds_screen.describe('b_'+string(ls_ColName) + ".type") <> 'button' Then
		Continue
	End If

	ltvi_Item = ltvi_Item_null
	ltvi_Item.PictureIndex = 5
	ltvi_Item.SelectedPictureIndex = 6
	ltvi_Item.Label = ls_col_text 
	ltvi_Item.Data = String(al_screen_id) +','+ as_notification_table + ',' + as_table + ',' + ls_ColName
	ll_handle = tv_datefields.InsertItemLast(al_handle, ltvi_Item)
	
	//Save Alarm Field to DB. calculate it using SP
	ll_row = ids_batch_alarms.InsertRow(0)
	ids_batch_alarms.SetItem(ll_row, 'client_id', is_client_id )
	ids_batch_alarms.SetItem(ll_row, 'screen_id', al_screen_id )
	ids_batch_alarms.SetItem(ll_row, 'alm_table', as_table )
	ids_batch_alarms.SetItem(ll_row, 'alm_column', ls_ColName )
	ids_batch_alarms.SetItem(ll_row, 'alm_column_lable', ls_col_text )
	ids_batch_alarms.SetItem(ll_row, 'notification_table', as_notification_table )
	ids_batch_alarms.SetItem(ll_row, 'tv_handle', ll_handle )
	If ll_row = 1 Then il_first_tvi = ll_handle
NEXT 	

If isvalid(lds_screen) Then Destroy lds_screen


Return 1 //Date filed count
end function

public function integer of_get_date_alarm_info (long al_handle, ref str_batch_alarms astr_batch_alarms);//====================================================================
// Function: of_get_date_alarm_info
//--------------------------------------------------------------------
// Description: Get Date Alarm info to Structure from TVI
//--------------------------------------------------------------------
// Arguments:
//                al_handle
//                astr_batch_alarms
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 11/22/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


TreeviewItem ltvi_date
String ls_label
Long ll_pos, ll_find


If al_handle <= 0 Then Return -1

tv_datefields.GetItem(al_handle, ltvi_date)
If ltvi_date.SelectedPictureIndex <> 6 Then Return -2

ll_pos = LastPos(ltvi_date.label,' (') 
If ll_pos <= 0 Then ll_pos = Len(ltvi_date.label) + 1
ls_label = Mid(ltvi_date.label, 1, ll_pos - 1 )

ll_find = ids_batch_alarms.Find('tv_handle = ' + String(al_handle), 1, ids_batch_alarms.Rowcount())
If ll_find > 0 Then
	astr_batch_alarms.al_handle = al_handle
	astr_batch_alarms.al_screen_id = ids_batch_alarms.GetItemNumber(ll_find, 'screen_id')
	astr_batch_alarms.as_alm_column = ids_batch_alarms.GetItemString(ll_find, 'alm_column')
	astr_batch_alarms.as_alm_table = ids_batch_alarms.GetItemString(ll_find, 'alm_table')
	If ls_label = '' or isnull(ls_label) Then
		astr_batch_alarms.as_column_label = ids_batch_alarms.GetItemString(ll_find, 'alm_column')
	Else
		astr_batch_alarms.as_column_label = ls_label
	End If
	astr_batch_alarms.as_notification_table = ids_batch_alarms.GetItemString(ll_find, 'notification_table')
Else
	Return -3
End If

Return 1
end function

public subroutine of_goto_contract ();//long		ll_EntryType,ll_ctx_id,ll_doc_id,ll_Row,ll_seq_id
//String	ls_ColName
//
//PowerObject lpo_NullParm
//
//ll_Row = This.GetRow()
//
//if ll_Row <= 0 or ll_Row > This.RowCount() then Return
//
//ll_ctx_id    = This.GetItemNumber(ll_Row,"ctx_id")
//ll_EntryType = This.GetItemNumber(ll_Row,"entry_type")
//ls_ColName   = This.GetItemString(ll_Row,"column_name")
//ll_doc_id    = This.GetItemNumber(ll_Row,"doc_id")
//ll_seq_id =  This.GetItemNumber(ll_Row,"seq_id")
//
//if ll_EntryType >= 20 then Return
//
//if Not IsValid(gw_Contract) then gf_OpenContractFolder(lpo_NullParm)
//
//if ll_EntryType = 11 then
//	Post gf_GoTo_Contract(ll_ctx_id,"20",0)
//elseif ll_EntryType = 12 then
//	Post gf_GoTo_Contract(ll_ctx_id,"100",0)
//elseif ll_EntryType = 13 then
//	Post gf_GoTo_Contract(ll_ctx_id,"92",ll_doc_id)
////Added By Ken.Guo 06/19/2012
//elseif ll_EntryType = 14 then //custom 2
//	Post gf_GoTo_Contract(ll_ctx_id,"22",ll_doc_id)
//elseif ll_EntryType = 15 then //ctx_custom_multi_hdr
//	Post gf_GoTo_Contract(ll_ctx_id,"111",ll_doc_id)
//elseif ll_EntryType = 16 then //ctx_custom_multi_detail
//	Post gf_GoTo_Contract(ll_ctx_id,"112",ll_doc_id)
//elseif ll_EntryType = 17 then //ctx_fee_sched_nm 2
//	Post gf_GoTo_Contract(ll_ctx_id,"80",ll_doc_id)
//
//end if
//
//Post of_SetdwColFocus(ll_EntryType,ls_ColName)
//
end subroutine

public subroutine of_setfocus_detail_date_field (long al_screen_id, string as_column);//====================================================================
// Function: of_setfocus_detail_date_field
//--------------------------------------------------------------------
// Description: Set Date field focus.
//--------------------------------------------------------------------
// Arguments:
//                as_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/04/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Choose Case al_screen_id
	Case 9
		gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Post SetFocus()
		gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.Post SetColumn(as_column)
	Case 5
		gw_contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates.Post SetFocus()
		gw_contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates.Post SetColumn(as_column)	
End Choose

end subroutine

public function string of_gen_sql_report (string as_table, string as_column, string as_type);//====================================================================
// Function: of_gen_sql_report
//--------------------------------------------------------------------
// Description:   get sql for retrieve alarms
//--------------------------------------------------------------------
// Arguments:
//                as_table
//                as_column
//                as_type   //all:  all alarms, not: not set alarms.
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/05/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_find, ll_pos_start, ll_pos_end, ll_pos_not,ll_pos_start2,ll_pos_all
String ls_sql, ls_sql_ctx, ls_sql_alarm,ls_sql_report, ls_table,ls_columnlable, ls_alarm_exists = '0'

//Get Original SQL 
ll_find = ids_batch_alarms.Find('alm_table = "' + as_table + '" and alm_column = "'  + as_column +  '"' ,1 , ids_batch_alarms.RowCount())
If ll_find <= 0 Then 
	Messagebox('Report','Failed to generate the report, please refresh again.')
	Return ''
End If
ls_sql = ids_batch_alarms.GetItemString(ll_find, 'sql_preview')
ls_columnlable = ids_batch_alarms.GetItemString(ll_find, 'alm_column_lable')
If ls_sql = '' or isnull(ls_sql) Then
	Messagebox('Report ', 'Failed to get SQL syntax.')
	Return  ''
End If

//Mid Count SQL Syntax
ll_pos_start = Pos(ls_sql, 'Select Count(1)')
ll_pos_start2 = LastPos(ls_sql, 'Select Count(1)')
ll_pos_end = Pos(ls_sql, ') Where id =' )
ll_pos_not = Pos(ls_sql,'and Not Exists(Select 1 ' )
ll_pos_all = Pos(ls_sql,') , count_all =')
If ll_pos_start = 0 or ll_pos_end = 0 or ll_pos_not = 0  Then
	gnv_debug.of_output( True, 'Report SQL for Date Alarm: ' + ls_sql )
	Messagebox('Report','The SQL syntax is incorrect')
	Return ''
End If
Choose Case Lower(as_type)
	Case 'all'   //All ctx alarms
		//ls_sql_alarm = Mid(ls_sql, ll_pos_start + Len('Select Count(1)') + 1, ll_pos_not - ll_pos_start - Len('Select Count(1)') - 1 )	
		ls_sql_alarm = Mid(ls_sql, ll_pos_start2 + Len('Select Count(1)') + 1, ll_pos_end - ll_pos_start2 - Len('Select Count(1)') - 1 )	
		ls_alarm_exists = '1'
	Case 'not'  //Not set alarms ctx
		//ls_sql_alarm = Mid(ls_sql, ll_pos_start + Len('Select Count(1)') + 1, ll_pos_end - ll_pos_start - Len('Select Count(1)') - 1 )
		ls_sql_alarm = Mid(ls_sql, ll_pos_start + Len('Select Count(1)') + 1, ll_pos_all - ll_pos_start - Len('Select Count(1)') - 1 )		
		ls_alarm_exists = '0'
	Case Else //Default = not
		ls_sql_alarm = Mid(ls_sql, ll_pos_start + Len('Select Count(1)') + 1, ll_pos_all - ll_pos_start - Len('Select Count(1)') - 1 )		
		ls_alarm_exists = '0'
End Choose

If as_table = 'ctx_action_item' Then 
	ls_table = 'ctx_action_items'
Else
	ls_table = as_table
End If

//Mix Report SQL
Choose Case Lower(as_table) 
	Case 'ctx_basic_info', 'ctx_custom'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = 0 , ai_id = 0, level_id1 = 0 , level_id2 = 0  ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = 0,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &		
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"		
	Case 'ctx_am_action_item'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = ctx_am_action_item.doc_id, ai_id = 0, level_id1 = ctx_am_action_item.seq_id, level_id2 = 0 ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = 0,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &		
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"				
	Case 'ctx_action_item'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = 0, ai_id = ctx_action_items.ctx_action_item_id, level_id1 = 0, level_id2 = 0  ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = alarm_table.ai_id,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &		
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"			
	Case 'ctx_custom_multi_hdr'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = 0, ai_id = 0, level_id1 = ctx_custom_multi_hdr.hdr_id, level_id2 = 0 ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = 0,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &		
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"			
	Case 'ctx_custom_multi_detail'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = 0, ai_id = 0, level_id1 = ctx_custom_multi_detail.hdr_id, level_id2 = ctx_custom_multi_detail.detail_id ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = 0,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &		
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"				
	Case 'ctx_fee_sched_nm'
		ls_sql_alarm = ' ( Select ctx_id, alarm_date = ' + ls_table + '.' + as_column  + ', doc_id = 0, ai_id = 0, level_id1 = ctx_fee_sched_nm.fee_sched_nm_id, level_id2 = 0 ' + ls_sql_alarm + ') alarm_table ~r~n '
		ls_sql_report = "Select result = space(50), alarm_exists = "+ ls_alarm_exists +", ctx_basic_info_2.ctx_id, category = code_lookup_c.code, status = code_lookup_s.code, Company = app_facility.facility_name , alarm_date = alarm_table.alarm_date ~r~n" + &
						  ", 	doc_id = alarm_table.doc_id, ai_id = 0,	level_id1 = alarm_table.level_id1, 	level_id2 = alarm_table.level_id2 ~r~n" + &
						"From ctx_basic_info ctx_basic_info_2 ~r~n" + &
						"Left Outer Join code_lookup code_lookup_c On (ctx_basic_info_2.category = code_lookup_c.lookup_code ) ~r~n" + &
						"Left Outer Join code_lookup code_lookup_s On (ctx_basic_info_2.status = code_lookup_s.lookup_code ) ~r~n" + &
						"Left Outer Join app_facility On (ctx_basic_info_2.app_facility = app_facility.facility_id), ~r~n"  +  ls_sql_alarm + &
						"Where ctx_basic_info_2.ctx_id = alarm_table.ctx_id"			
End Choose

Return ls_sql_report
end function

public function integer of_update_attachment (str_alarm astr_alarm);//Update attachment - Alfee 06.11.2008
String	ls_PathName,ls_FileName,ls_AttachName[],ls_attach_name
long		ll_email_id,ll_Pos,ll_AttachCycle,ll_AttachCnts,ll_AttachID
String 	ls_Attachment
Blob 		lblb_attachment[], lblb_attachment_temp, lblb_attachment_null

n_cst_filesrv lnv_filesrv

//Return if attachment not modified
//IF NOT ib_attachment_modified THEN RETURN 0

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-23 By: Scofield
//$<Reason> Save multi-attachment files to database.

lnv_filesrv = Create n_cst_filesrv

//Get attachment into blob
IF ib_attachment_from_template THEN
	//If attachment from an email template
	ll_email_id = 	dw_alm_msg.GetItemNumber(1, 'alm_email_template_id')
	ls_attach_name = dw_alm_msg.GetItemString(1, 'alm_attachment_name')
	IF IsNull(ll_email_id) THEN ll_email_id = 0
	IF IsNull(ls_attach_name) THEN ls_attach_name = ''
	IF ll_email_id > 0 and Len(Trim(ls_attach_name)) > 0 THEN
		inv_mail.of_get_mail_template_attachment(ll_email_id, ls_AttachName,lblb_attachment)	
	END IF
END IF

ls_Attachment = is_Attachment //Added By Ken.Guo 12/06/2012. Using local var.
if Not (IsNull(ls_Attachment) or Trim(ls_Attachment) = "") then
	//If attachment from a local file
	if Right(ls_Attachment,1) <> SEMICOLON then ls_Attachment += SEMICOLON
	
	ll_Pos = Pos(ls_Attachment,SEMICOLON)
	do while ll_Pos > 0
		ls_PathName = Trim(Left(ls_Attachment,ll_Pos - 1))
		ls_FileName = of_GetFileName(ls_PathName)
		if FileExists(ls_PathName) and ls_FileName <> "" then
			ls_AttachName[UpperBound(ls_AttachName) + 1] = ls_FileName
			lblb_attachment_temp = lblb_attachment_null
			lnv_FileSrv.of_FileRead(ls_PathName,lblb_attachment_temp)
			lblb_attachment[UpperBound(lblb_attachment) + 1] = lblb_attachment_temp 
		end if
		ls_Attachment = Trim(Mid(ls_Attachment,ll_Pos + 1))
		ll_Pos = Pos(ls_Attachment,SEMICOLON)
	loop
	/*
	IF Len(ls_Attachment) > 0 AND FileExists(ls_Attachment) THEN
		IF NOT (lnv_FileSrv.of_FileRead(ls_Attachment, lblb_attachment) > 0 ) THEN
			SetNull(lblb_attachment)
		END IF
	END IF
	*/
end if

ll_AttachCnts = UpperBound(lblb_attachment)

//if ll_AttachCnts <= 0 or ib_delete_attach then   //Added By Ken.Guo 12/05/2012. Delete first if exists.
	Choose Case Upper(astr_alarm.alm_table)
		Case 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
			DELETE FROM ctx_alarm_attachment
			      WHERE ctx_id = :astr_alarm.ctx_id AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
		Case 'CTX_ACTION_ITEM'
			DELETE FROM ctx_ai_alarm_attachment
			      WHERE ctx_id = :astr_alarm.ctx_id AND item_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
		Case 'CTX_AM_ACTION_ITEM'
			DELETE FROM ctx_am_ai_alarm_attachment
					WHERE doc_id = :astr_alarm.doc_id AND seq_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
		//Case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
		case else //add fee scheduce - jervis 08.02.2011
			DELETE FROM ctx_ALL_alarm_attachment
					WHERE ctx_id = :astr_alarm.ctx_id and doc_id = :astr_alarm.doc_id AND level_id1 = :astr_alarm.level_id1 and level_id2 = :astr_alarm.level_id2 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
	end choose
//end if

//Update attachment
IF ll_AttachCnts > 0 THEN
	CHOOSE CASE Upper(astr_alarm.alm_table)
		
		CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_alarm_attachment 
				 WHERE ctx_id = :astr_alarm.ctx_id AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_alarm_attachment(ctx_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:astr_alarm.ctx_id,:astr_alarm.alm_table,:astr_alarm.alm_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :astr_alarm.ctx_id AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_notification Set alm_attachment = :lblb_attachment 
			 	  Where ctx_id = :astr_alarm.ctx_id And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;
			*/
		CASE 'CTX_ACTION_ITEM'
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_ai_alarm_attachment 
				 WHERE ctx_id = :astr_alarm.ctx_id AND item_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_ai_alarm_attachment(ctx_id,item_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:astr_alarm.ctx_id,:astr_alarm.level_id1,:astr_alarm.alm_table,:astr_alarm.alm_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_ai_alarm_attachment
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :astr_alarm.ctx_id AND item_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_ai_notification Set alm_attachment = :lblb_attachment
		 	 	 Where ctx_id = :astr_alarm.ctx_id And ctx_action_item_id = :astr_alarm.level_id1 And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;	
			*/		
		CASE 'CTX_AM_ACTION_ITEM'
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id)
				  INTO :ll_AttachID
				  FROM ctx_am_ai_alarm_attachment
				 WHERE doc_id = :astr_alarm.doc_id AND seq_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_am_ai_alarm_attachment(doc_id,seq_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:astr_alarm.doc_id,:astr_alarm.level_id1,:astr_alarm.alm_table,:astr_alarm.alm_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_am_ai_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE doc_id = :astr_alarm.doc_id AND seq_id = :astr_alarm.level_id1 AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_am_ai_notification Set alm_attachment = :lblb_attachment 
			 	  Where doc_id = :astr_alarm.doc_id And seq_id = :astr_alarm.level_id1 And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;
			*/
		case else //add fee scheduce - jervis 08.02.2011
		//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_all_alarm_attachment 
				 WHERE ctx_id = :astr_alarm.ctx_id AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column and 
				 		 doc_id = :astr_alarm.doc_id AND level_id1 = :astr_alarm.level_id1 and level_id2 = :astr_alarm.level_id2;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_all_alarm_attachment(ctx_id,alm_table,alm_column,attach_id,alm_attachment_name,doc_id,level_id1,level_id2)
					  VALUES (:astr_alarm.ctx_id,:astr_alarm.alm_table,:astr_alarm.alm_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle],:astr_alarm.doc_id,:astr_alarm.level_id1,:astr_alarm.level_id2);
					  
				UPDATEBLOB ctx_all_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :astr_alarm.ctx_id AND alm_table = :astr_alarm.alm_table AND alm_column = :astr_alarm.alm_column AND attach_id = :ll_AttachID and 
					  			doc_id = :astr_alarm.doc_id AND level_id1 = :astr_alarm.level_id1 and level_id2 = :astr_alarm.level_id2;	 
			next
	END CHOOSE

END IF

Destroy lnv_filesrv

//---------------------------- APPEON END ----------------------------

//Execute update SQL statement
IF SQLCA.SQLCode = -1 THEN
	gnv_debug.of_output( True, 'Failed to update attachment. CTX ID:' + String(astr_alarm.ctx_id) + ', Table: '  +astr_alarm.alm_table + ', Column:' + astr_alarm.alm_column + ', Error: ' + SQLCA.SQLErrText )
	MessageBox("Save Attachment","Update attachment failed due to: " + SQLCA.SQLErrText)
	RETURN -1		
END IF

ib_attachment_modified = true

RETURN 1

end function

public function integer of_update_message (str_alarm astr_alarm);//Update attachment - Alfee 06.11.2008
String ls_sql
Blob lblb_message

//Return if no document opened or not modified
IF ole_message.object.doctype <> 1 THEN RETURN 0

//Save message to blob
ole_Message.of_GetBlob(lblb_message)

//Update message
CHOOSE CASE Upper(astr_alarm.alm_table)
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		UpdateBlob ctx_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :astr_alarm.ctx_id And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;		
	CASE 'CTX_ACTION_ITEM'
		UpdateBlob ctx_ai_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :astr_alarm.ctx_id And ctx_action_item_id = :astr_alarm.level_id1 And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;	
	CASE 'CTX_AM_ACTION_ITEM'
		UpdateBlob ctx_am_ai_notification Set alm_message_blob = :lblb_message 
		 	  Where doc_id = :astr_alarm.doc_id And seq_id = :astr_alarm.level_id1 And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column;
	//Case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		UpdateBlob ctx_all_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :astr_alarm.ctx_id And alm_table = :astr_alarm.alm_table And alm_column = :astr_alarm.alm_column and 
						doc_id = :astr_alarm.doc_id and level_id1 = :astr_alarm.level_id1 and level_id2 = :astr_alarm.level_id2;	
END CHOOSE

IF SQLCA.SQLCode = -1 THEN
	gnv_debug.of_output( True, 'Failed to update message. CTX ID:' + String(astr_alarm.ctx_id) + ', Table: '  +astr_alarm.alm_table + ', Column:' + astr_alarm.alm_column + ', Error: ' + SQLCA.SQLErrText )
	MessageBox("Save Message", "Update message failed due to: " + SQLCA.SQLErrText)
	RETURN -1
END IF

of_set_messagechanged(FALSE)

RETURN 1

end function

public function integer of_update_snooze (str_alarm astr_alarm);//////////////////////////////////////////////////////////////////////
// $<function>w_ctx_alarm::of_update_snooze()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Update Advance Snooze Settings.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-09-16 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long i
DataStore lds_snooze
lds_snooze = Create DataStore
lds_snooze.Dataobject = 'd_ctx_alm_snooze'
lds_snooze.SetTransObject(SQLCA)

ids_snooze_ctx.RowsCopy(1,ids_snooze_ctx.RowCount(), Primary!,lds_snooze,1 , Primary!  )

Delete From ctx_alm_snooze Where ctx_id = :astr_alarm.ctx_id and doc_id = :astr_alarm.doc_id  and level_id1 = :astr_alarm.level_id1 
	and level_id2 = :astr_alarm.level_id2 and  alm_table = :astr_alarm.alm_table and alm_column = :astr_alarm.alm_column;

If dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') = 0 Then
	//If no snooze
	Return 1
Else
	//Update
	For i = 1 to lds_snooze.RowCount()
		lds_snooze.SetItem(i,'ctx_id',astr_alarm.ctx_id)
		lds_snooze.SetItem(i,'doc_id',astr_alarm.doc_id)
		lds_snooze.SetItem(i,'level_id1',astr_alarm.level_id1 )
		lds_snooze.SetItem(i,'level_id2',astr_alarm.level_id2)
		lds_snooze.SetItem(i,'alm_table',astr_alarm.alm_table)
		lds_snooze.SetItem(i,'alm_column',astr_alarm.alm_column)		
	Next 
	For i = 1 to lds_snooze.RowCount()
		If lds_snooze.GetItemNumber(i,'asnooze_executed') = 0 Then
			If lds_snooze.GetitemNumber(i,'increment_value') <> dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') Then 
				lds_snooze.SetItem(i,'increment_value',dw_alm_det.GetItemNumber(1,'alm_auto_increment_years'))
			End If
			If lds_snooze.GetItemString(i,'increment_unit') <> dw_alm_det.GetItemString(1,'alm_auto_increment_unit') Then
				lds_snooze.SetItem(i,'increment_unit',dw_alm_det.GetItemString(1,'alm_auto_increment_unit'))
			End If
			Exit
		End If
	Next
	If lds_snooze.modifiedcount( ) > 0 Then
		lds_snooze.update()
	End If
End If

Return 1


end function

public function integer of_batch_update_alarms (str_alarm astr_alarm_base, str_alarm str_alarm_target[]);Long i, ll_count




Return  1
end function

public function integer of_batch_update_alarms (ref str_alarm astr_alarm[]);//====================================================================
// Function: of_batch_update_alarms
//--------------------------------------------------------------------
// Description: Batch update alarms.
//--------------------------------------------------------------------
// Arguments:
//                astr_alarm[]
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/05/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_rtn,i, ll_cnt
Boolean lb_error = False

If UpperBound(astr_alarm[]) = 0 Then Return 0

If Not isvalid(iw_appeon_gifofwait) Then
	Open(iw_appeon_gifofwait)
	iw_appeon_gifofwait.of_settext('Batch Updating Date Alarms...')
	Timer(0,iw_appeon_gifofwait)
	//iw_appeon_gifofwait.of_setposition(10)	
End If
ll_cnt = UpperBound(astr_alarm[]) 

For i = 1 To ll_cnt
	If astr_alarm[i].ctx_id = 0 Then Continue
	
	iw_appeon_gifofwait.of_setposition(i / ll_cnt * 100)
	iw_appeon_gifofwait.of_settext('Batch Updating Date Alarms '+String(i) +'/' + String(ll_cnt) +' ...')
	
	//Restore the status
	IF dw_alm_det.RowCount() > 0 THEN
		dw_alm_det.SetItemStatus(1, 0, Primary!, NewModified!)
	END IF	
	
	//Preset the first ctx to datawindow to Save First. 
	gnv_appeondb.of_startqueue( )
	Choose Case Lower(astr_alarm[i].alm_table)
		Case 'ctx_basic_info', 'ctx_custom'
			dw_alm_det.SetItem(1, 'ctx_id' ,astr_alarm[i].ctx_id  )
			dw_alm_det.SetItem(1, 'alm_table' ,astr_alarm[i].alm_table  )
			dw_alm_det.SetItem(1, 'alm_column' ,astr_alarm[i].alm_column  )
			DELETE FROM ctx_alarm_attachment WHERE ctx_id = :astr_alarm[i].ctx_id AND alm_table = :astr_alarm[i].alm_table AND alm_column = :astr_alarm[i].alm_column;
			Delete From ctx_alm_snooze Where ctx_id = :astr_alarm[i].ctx_id and alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;
			Delete From ctx_notification Where ctx_id = :astr_alarm[i].ctx_id and alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;
		Case 'ctx_am_action_item'
			dw_alm_det.SetItem(1, 'doc_id' ,astr_alarm[i].doc_id  )
			dw_alm_det.SetItem(1, 'seq_id' ,astr_alarm[i].level_id1  )
			dw_alm_det.SetItem(1, 'alm_table' ,astr_alarm[i].alm_table  )
			dw_alm_det.SetItem(1, 'alm_column' ,astr_alarm[i].alm_column  )
			DELETE FROM ctx_am_ai_alarm_attachment
				WHERE doc_id = :astr_alarm[i].doc_id AND seq_id = :astr_alarm[i].level_id1 AND alm_table =:astr_alarm[i].alm_table  AND alm_column =  :astr_alarm[i].alm_column;
			Delete From ctx_am_ai_notification Where doc_id = :astr_alarm[i].doc_id and seq_id = :astr_alarm[i].level_id1 and  alm_table = :astr_alarm[i].alm_table 
				and alm_column = :astr_alarm[i].alm_column;	
		Case 'ctx_action_item'
			dw_alm_det.SetItem(1, 'ctx_id' ,astr_alarm[i].ctx_id  )
			dw_alm_det.SetItem(1, 'ctx_action_item_id' ,astr_alarm[i].level_id1  )
			dw_alm_det.SetItem(1, 'alm_table' ,astr_alarm[i].alm_table  )
			dw_alm_det.SetItem(1, 'alm_column' ,astr_alarm[i].alm_column  )		
			DELETE FROM ctx_ai_alarm_attachment
				WHERE ctx_id =  :astr_alarm[i].ctx_id AND item_id = :astr_alarm[i].level_id1 AND alm_table =:astr_alarm[i].alm_table  AND alm_column = :astr_alarm[i].alm_column;	
			Delete From ctx_ai_notification Where ctx_id = :astr_alarm[i].ctx_id and ctx_action_item_id = :astr_alarm[i].level_id1 
				and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;						
		Case Else
			dw_alm_det.SetItem(1, 'ctx_id' ,astr_alarm[i].ctx_id  )
			dw_alm_det.SetItem(1, 'doc_id' ,astr_alarm[i].doc_id  )
			dw_alm_det.SetItem(1, 'level_id1' ,astr_alarm[i].level_id1  )
			dw_alm_det.SetItem(1, 'level_id2' ,astr_alarm[i].level_id2  )
			dw_alm_det.SetItem(1, 'alm_table' ,astr_alarm[i].alm_table  )
			dw_alm_det.SetItem(1, 'alm_column' ,astr_alarm[i].alm_column  )		
			DELETE FROM ctx_ALL_alarm_attachment
				WHERE ctx_id = :astr_alarm[i].ctx_id and doc_id =:astr_alarm[i].doc_id AND level_id1 = :astr_alarm[i].level_id1 and level_id2 = :astr_alarm[i].level_id2 AND alm_table =  :astr_alarm[i].alm_table AND alm_column = :astr_alarm[i].alm_column;		
			Delete From ctx_alm_snooze Where ctx_id = :astr_alarm[i].ctx_id and doc_id = :astr_alarm[i].doc_id  and level_id1 = :astr_alarm[i].level_id1 
				and level_id2 = :astr_alarm[i].level_id2 and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;					
			Delete From ctx_all_notification Where ctx_id = :astr_alarm[i].ctx_id and doc_id = :astr_alarm[i].doc_id  and level_id1 = :astr_alarm[i].level_id1 
				and level_id2 = :astr_alarm[i].level_id2 and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;					
	End Choose
	gnv_appeondb.of_commitqueue( )
	
	//Save Basic Alarm Setting for 1st Alarms
	ll_rtn = event pfc_save( )
	if ll_Rtn < 0 then 
		astr_alarm[i].as_result = 'Failed. Error -1'
		lb_error = True
		//Messagebox('Error -1','Failed to save alarm detail. CTX ID:' + String(astr_alarm[i].ctx_id) + ', Table: '  +astr_alarm[i].alm_table + ', Column:' + astr_alarm[i].alm_column + ', please close the window and try again.')
		//Exit
		Continue
		
	End If
	ib_users_modified = FALSE
	
	//Update Attachment for 1st Alarms
	ll_rtn = of_update_attachment(astr_alarm[i])
	if ll_Rtn < 0 then 
		lb_error = True
		astr_alarm[i].as_result = 'Failed. Error -2'
		//Messagebox('Error -2','Failed to save attachment. CTX ID:' + String(astr_alarm[i].ctx_id) + ', Table: '  +astr_alarm[i].alm_table + ', Column:' + astr_alarm[i].alm_column + ', please close the window and try again.')
		//Exit
		Continue
	End If
	
	//Update Message for 1st Alarms
	ll_rtn = of_update_message(astr_alarm[i])
	if ll_Rtn < 0 then 
		lb_error = True
		astr_alarm[i].as_result = 'Failed. Error -3'
		//Messagebox('Error -3','Failed to save message. CTX ID:' + String(astr_alarm[i].ctx_id) + ', Table: '  +astr_alarm[i].alm_table + ', Column:' + astr_alarm[i].alm_column + ', please close the window and try again.')
		//Exit
		Continue
	End If
	
	//Update Snooze for 1st Alarms
	If (lower(astr_alarm[i].alm_table) = 'ctx_fee_sched_nm' or Lower(astr_alarm[i].alm_table) = 'ctx_basic_info' or Lower(astr_alarm[i].alm_table) = 'ctx_custom'  or Lower(astr_alarm[i].alm_table) = 'ctx_custom_multi_hdr'  &
	or Lower(astr_alarm[i].alm_table) = 'ctx_custom_multi_detail') Then 
		of_update_snooze(astr_alarm[i]) 
	end if
	
	astr_alarm[i].as_result = 'Successful'
	
Next

If isvalid(iw_appeon_gifofwait) Then Close(iw_appeon_gifofwait)

If lb_error = True Then
	Return -1
Else
	Return 1
End If



/*
//Update remainder Alarms
For i = 2 To  UpperBound(astr_alarm[])
	If astr_alarm[i].ctx_id = 0 Then Continue
	
	//Delete orginal Alarms if exists
	gnv_appeondb.of_startqueue( )
		Choose Case Lower(astr_alarm[i].alm_table)
			Case 'ctx_basic_info', 'ctx_custom'
				Delete From ctx_notification Where ctx_id = :astr_alarm[i].ctx_id and alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;
				DELETE FROM ctx_alarm_attachment WHERE ctx_id = :astr_alarm[i].ctx_id AND alm_table = :astr_alarm[i].alm_table AND alm_column = :astr_alarm[i].alm_column;
				Delete From ctx_alm_snooze Where ctx_id = :astr_alarm[i].ctx_id and alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;
			Case 'ctx_am_action_item'
				Delete From ctx_am_ai_notification Where doc_id = :astr_alarm[i].doc_id and seq_id = :astr_alarm[i].level_id1 and  alm_table = :astr_alarm[i].alm_table 
					and alm_column = :astr_alarm[i].alm_column;
				DELETE FROM ctx_am_ai_alarm_attachment
					WHERE doc_id = :astr_alarm[i].doc_id AND seq_id = :astr_alarm[i].level_id1 AND alm_table =:astr_alarm[i].alm_table  AND alm_column =  :astr_alarm[i].alm_column;
				Delete From ctx_alm_snooze Where doc_id = :astr_alarm[i].doc_id and seq_id = :astr_alarm[i].level_id1 and  alm_table = :astr_alarm[i].alm_table 
					and alm_column = :astr_alarm[i].alm_column;				
			Case 'ctx_action_item'
				Delete From ctx_am_ai_notification Where ctx_id = :astr_alarm[i].ctx_id and ctx_action_item_id = :astr_alarm[i].level_id1 
					and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;		
				DELETE FROM ctx_ai_alarm_attachment
							WHERE ctx_id =  :astr_alarm[i].ctx_id AND item_id = :astr_alarm[i].level_id1 AND alm_table =:astr_alarm[i].alm_table  AND alm_column = :astr_alarm[i].alm_column;	
				Delete From ctx_alm_snooze Where ctx_id = :astr_alarm[i].ctx_id and ctx_action_item_id = :astr_alarm[i].level_id1 
					and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;									
			Case Else
				Delete From ctx_am_ai_notification Where ctx_id = :astr_alarm[i].ctx_id and doc_id = :astr_alarm[i].doc_id  and level_id1 = :astr_alarm[i].level_id1 
					and level_id2 = :astr_alarm[i].level_id2 and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;		
				DELETE FROM ctx_ALL_alarm_attachment
					WHERE ctx_id = :astr_alarm[i].ctx_id and doc_id =:astr_alarm[i].doc_id AND level_id1 = :astr_alarm[i].level_id1 and level_id2 = :astr_alarm[i].level_id2 AND alm_table =  :astr_alarm[i].alm_table AND alm_column = :astr_alarm[i].alm_column;		
				Delete From ctx_alm_snooze Where ctx_id = :astr_alarm[i].ctx_id and doc_id = :astr_alarm[i].doc_id  and level_id1 = :astr_alarm[i].level_id1 
					and level_id2 = :astr_alarm[i].level_id2 and  alm_table = :astr_alarm[i].alm_table and alm_column = :astr_alarm[i].alm_column;		
		End Choose
	gnv_appeondb.of_commitqueue( )

Next  
*/


Return 1


end function

public function integer of_get_default_message (long al_view_id, string as_alm_table, string as_alm_column, ref blob ablb_message);//====================================================================
// Function: of_get_default_message
//--------------------------------------------------------------------
// Description: Get Default Message Blob
//--------------------------------------------------------------------
// Arguments:
//                al_view_id
//                as_alm_table
//                as_alm_column
// ref          ablb_message
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/13/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp
long READ_ONE_LENGTH = 8000

SELECT Datalength(alm_message_blob)
INTO :ll_DataLen
FROM ctx_notification_templates
Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;

If sqlca.sqlcode <> 0 Then Return -1
If ll_DataLen <= 0 or isnull(ll_DataLen) Then Return 0

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_message_blob,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM ctx_notification_templates
		      Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;

		ablb_Message += lb_Temp
	next
else
	SELECTBLOB alm_message_blob
		INTO :ablb_Message
		FROM ctx_notification_templates
		Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;
end if


Return 1
end function

on w_ctx_alarm_batch.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.cbx_min=create cbx_min
this.cb_refresh=create cb_refresh
this.cb_report=create cb_report
this.tv_datefields=create tv_datefields
this.st_unalarm_cnt=create st_unalarm_cnt
this.st_ctx_cnt=create st_ctx_cnt
this.rb_not=create rb_not
this.rb_all=create rb_all
this.cb_load=create cb_load
this.cb_field=create cb_field
this.cb_help=create cb_help
this.cb_default=create cb_default
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_alm_det=create dw_alm_det
this.gb_1=create gb_1
this.sle_subject=create sle_subject
this.gb_2=create gb_2
this.st_2=create st_2
this.dw_alm_msg=create dw_alm_msg
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.cbx_min
this.Control[iCurrent+3]=this.cb_refresh
this.Control[iCurrent+4]=this.cb_report
this.Control[iCurrent+5]=this.tv_datefields
this.Control[iCurrent+6]=this.st_unalarm_cnt
this.Control[iCurrent+7]=this.st_ctx_cnt
this.Control[iCurrent+8]=this.rb_not
this.Control[iCurrent+9]=this.rb_all
this.Control[iCurrent+10]=this.cb_load
this.Control[iCurrent+11]=this.cb_field
this.Control[iCurrent+12]=this.cb_help
this.Control[iCurrent+13]=this.cb_default
this.Control[iCurrent+14]=this.cb_ok
this.Control[iCurrent+15]=this.cb_cancel
this.Control[iCurrent+16]=this.dw_alm_det
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.sle_subject
this.Control[iCurrent+19]=this.gb_2
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.dw_alm_msg
this.Control[iCurrent+22]=this.gb_3
this.Control[iCurrent+23]=this.gb_4
this.Control[iCurrent+24]=this.gb_5
this.Control[iCurrent+25]=this.st_1
end on

on w_ctx_alarm_batch.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.cbx_min)
destroy(this.cb_refresh)
destroy(this.cb_report)
destroy(this.tv_datefields)
destroy(this.st_unalarm_cnt)
destroy(this.st_ctx_cnt)
destroy(this.rb_not)
destroy(this.rb_all)
destroy(this.cb_load)
destroy(this.cb_field)
destroy(this.cb_help)
destroy(this.cb_default)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_alm_det)
destroy(this.gb_1)
destroy(this.sle_subject)
destroy(this.gb_2)
destroy(this.st_2)
destroy(this.dw_alm_msg)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.st_1)
end on

event pfc_postopen;call super::pfc_postopen;//====================================================================
// Event: pfc_postopen
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 11/22/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long i

gnv_win_backcolor.of_ChangeWindowBackColor(this) //?????????????? need Add to window list

If Not isvalid(iw_appeon_gifofwait) Then
	Open(iw_appeon_gifofwait)
	iw_appeon_gifofwait.of_settext('Building Date Fields Data...')
	Timer(0,iw_appeon_gifofwait)
	iw_appeon_gifofwait.of_setposition(10)	
End If

For i = 1 To UpperBound(istr_ctx_info[])
	il_ctx_id_arr[UpperBound(il_ctx_id_arr) + 1] = istr_ctx_info[i].al_ctx_id
Next

If isvalid(iw_appeon_gifofwait) Then
	iw_appeon_gifofwait.of_settext('Preparing Contract ID List...')
	iw_appeon_gifofwait.of_setposition(12)
End If

inv_array_db = Create n_cst_array_db
If inv_array_db.of_array_to_db( il_ctx_id_arr[], is_client_id) < 0 Then
	Messagebox('Error ','Failed to run SP up_array_to_row.')
	Close(This)
	Return 
End If

If AppeonGetClientType() = 'WEB' Then
	Delete From ctx_batch_alarm_analysis Where client_id = :is_client_id;
End If

of_build_screen_fileds()


end event

event pfc_endtran;call super::pfc_endtran;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Refresh global cache when ctx_notification changed.

//------Begin Modified by Alfee 02.26.2008 -------------
//<$Reason>for date alarm enhancement
//gnv_data.of_retrieve( "ctx_notification" )
gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve( "ctx_notification" )
gnv_data.of_retrieve( "ctx_ai_notification")
gnv_data.of_retrieve( "ctx_am_ai_notification")
gnv_data.of_retrieve( "ctx_all_notification" ) //jervis 07.08.2011
gnv_appeondb.of_commitqueue( )
//------End Modified -----------------------------------

RETURN success

//---------------------------- APPEON END ----------------------------
end event

event close;call super::close;//inv_array_db.of_delete_temp_data( is_client_id)

Delete From ctx_batch_alarm_analysis Where client_id = :is_client_id ;

String ls_value
If cbx_min.checked Then
	ls_value = 'Y'
Else
	ls_value = 'N'
End If
gnv_user_option.of_set_option_value( gs_user_id, 'min_batch_alarm_window_when_goto_contact' , ls_value)


ole_Message.of_Close() //Alfee 06.11.2008
If isvalid(ids_notification_templates) Then Destroy ids_notification_templates

If isvalid(ids_screen) Then Destroy ids_screen
If isvalid(ids_tabpage_prop) Then Destroy ids_tabpage_prop
If isvalid(ids_tabpage_screen_default) Then Destroy ids_tabpage_screen_default
If isvalid(ids_user_mail_map) Then Destroy ids_user_mail_map
If isvalid(inv_array_db) Then Destroy inv_array_db
If isvalid(ids_batch_alarms) Then Destroy ids_batch_alarms

end event

event closequery;////Override - Alfee 06.11.20
//Boolean lb_modified = FALSE
//
//dw_alm_det.AcceptText()
//dw_alm_msg.AcceptText()
//
//IF dw_alm_det.GetItemStatus( 1,0, Primary!) = NewModified! OR &
//   dw_alm_det.GetItemStatus( 1,0, Primary!) = DataModified! OR &
//	ib_users_modified THEN
//	lb_modified = TRUE
//ELSEIF ole_message.Object.DocType = 1 THEN
//	IF of_is_messagechanged() THEN
//		lb_modified = TRUE
//	END IF
//END IF
//
//if lb_modified then
//	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
//		Return 1
//	end if
//end if
////---------------------------- APPEON END ----------------------------
end event

event pfc_preopen;call super::pfc_preopen;str_ctx_info_array lstr_ctx_info_array
Long i, j

lstr_ctx_info_array = Message.powerobjectparm


istr_ctx_info[] = lstr_ctx_info_array.astr_ctx_info[]
////Delete duplicate ctx. Too slow when large data
//For i = 1 To UpperBound(lstr_ctx_info_array.astr_ctx_info[])
//	For J = 1 To UpperBound(istr_ctx_info[])
//		If lstr_ctx_info_array.astr_ctx_info[i].al_ctx_id = istr_ctx_info[J].al_ctx_id Then
//			Exit
//		End If
//	Next
//	//If not exists, added it
//	If J > UpperBound(istr_ctx_info[]) Then
//		istr_ctx_info[UpperBound(istr_ctx_info[]) + 1] = lstr_ctx_info_array.astr_ctx_info[i]
//	End If
//Next

If Upperbound(istr_ctx_info[] ) = 0 Then
	Close(This)
End If





end event

event open;call super::open;//Workaround APB Bug
if AppeonGetClientType() = "WEB" then
	This.Width  += 20
	This.Height += 15
end if

ids_screen = Create n_ds
ids_tabpage_prop = Create n_ds
ids_tabpage_screen_default = Create n_ds
ids_batch_alarms = Create n_ds
ids_screen.DataObject = "ds_contract_data_view_screens_list"
ids_screen.SetTransObject(SQLCA)
ids_tabpage_prop.DataObject = "d_tabpage_properties"
ids_tabpage_prop.SetTransObject(SQLCA)
ids_tabpage_screen_default.dataobject = 'd_tabpage_screen_default'
ids_tabpage_screen_default.SetTransObject(SQLCA)
ids_batch_alarms.dataobject = 'd_batch_alarm_analysis'
ids_batch_alarms.SetTransObject(SQLCA)

ids_user_mail_map = Create Datastore
ids_user_mail_map.dataobject = 'd_user_email'
ids_user_mail_map.SetTransobject(SQLCA)
ids_snooze_ctx = Create DataStore
ids_snooze_ctx.Dataobject = 'd_ctx_alm_snooze'
ids_snooze_ctx.SetTransObject(SQLCA)
ids_snooze_template = Create DataStore
ids_snooze_template.Dataobject = 'd_ctx_alm_snooze_template'
ids_snooze_template.SetTransObject(SQLCA)
ids_notification_templates = Create datastore
ids_notification_templates.dataobject = 'd_notification_templates'
ids_notification_templates.SetTransObject(SQLCA)
ids_view_tab = Create n_ds
ids_view_tab.dataobject = 'd_ctx_view_tab'
ids_view_tab.SetTransObject(SQLCA)

il_view_id = istr_ctx_info[1].al_view_id

ids_tabpage_prop.SetFilter('data_view_id = ' + String(il_view_id))

gnv_appeondb.of_startqueue( )
	ids_screen.Retrieve( il_view_id )
	ids_tabpage_prop.Retrieve( )
	ids_tabpage_screen_default.Retrieve()
gnv_appeondb.of_commitqueue( )

dw_alm_det.InsertRow(0)
dw_alm_msg.InsertRow(0)

st_ctx_cnt.text = String(UpperBound(istr_ctx_info[])) + " Contract Records Selected "

String ls_value
ls_value = gnv_user_option.of_get_option_value(gs_user_id, 'min_batch_alarm_window_when_goto_contact')
If ls_value = 'Y' Then
	cbx_min.checked = True
End If

//Need Check Status /????????????????????????????????????????????????
//Long ll_ctx_status
//String ls_alarm_enabled,ls_msg
//If istr_pass.s_string_array[2] = 'ctx_am_action_item' Then
//	//Added By Ken.Guo 02/27/2012. 
//	Select ctx_basic_info.status Into :ll_ctx_status  
//		From ctx_basic_info,ctx_am_document 
//		Where ctx_basic_info.ctx_id = ctx_am_document.ctx_id and ctx_am_document.doc_id = :istr_pass.s_string_array[1];
//Else
//	Select status Into :ll_ctx_status From ctx_basic_info Where ctx_id = :istr_pass.s_string_array[1];
//End If
//
//IF NOT IsNull(ll_ctx_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + String(ll_ctx_status))
//IF Upper(ls_alarm_enabled) <> 'YES' THEN
//	ls_msg = "Alarms can't be set because the Contract Status you have selected has the Alarmed Enabled flag set to No.  "
//	ls_msg +="To change this setting go to the System->Lookup Painter and select the Contract Status lookup table and change the Alarms Enabled Flag to Yes." 
//	MessageBox("Contract Alarms", ls_msg)
//	cb_cancel.event clicked( )
//	Return
//END IF


end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

type ole_message from u_email_edit within w_ctx_alarm_batch
integer x = 1609
integer y = 1152
integer width = 2802
integer height = 1296
integer taborder = 40
string binarykey = "w_ctx_alarm_batch.win"
end type

event onwordwpsselchange;call super::onwordwpsselchange;if isvalid(w_agreement_template_merge_fields) then
	w_agreement_template_merge_fields.rb_body.checked = true
end if
end event

type cbx_min from checkbox within w_ctx_alarm_batch
integer x = 82
integer y = 2092
integer width = 1349
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Minimize the window when going to contract"
end type

type cb_refresh from commandbutton within w_ctx_alarm_batch
integer x = 439
integer y = 2508
integer width = 384
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;Parent.of_build_screen_fileds( )
end event

type cb_report from commandbutton within w_ctx_alarm_batch
integer x = 37
integer y = 2508
integer width = 384
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Report"
end type

event clicked;Long ll_find, ll_pos_start, ll_pos_end
String ls_sql, ls_sql_ctx, ls_sql_alarm, ls_table,ls_columnlable
String ls_sql_report, ls_sql_report_all, ls_type

//Get Original SQL 
ll_find = ids_batch_alarms.Find('alm_table = "' + is_table + '" and alm_column = "'  + is_column +  '"' ,1 , ids_batch_alarms.RowCount())
If ll_find <= 0 Then 
	Messagebox('Report','Failed to generate the report, please refresh again.')
	Return
End If
ls_columnlable = ids_batch_alarms.GetItemString(ll_find, 'alm_column_lable')

ls_sql_report = Parent.of_gen_sql_report( is_table, is_column, 'not')
ls_sql_report_all = Parent.of_gen_sql_report( is_table, is_column, 'all')
If ls_sql_report = ''  or ls_sql_report_all = '' Then Return

If rb_all.checked Then 
	ls_type = 'all'
Else
	ls_type = 'not'
End If

//Open Report Window
str_pass lstr_pass
lstr_pass.s_string = ls_sql_report
lstr_pass.s_string_array[1] = is_table
lstr_pass.s_string_array[2] = is_column
lstr_pass.s_string_array[3] = ls_columnlable

lstr_pass.s_string_array[11] = ls_sql_report
lstr_pass.s_string_array[12] = ls_sql_report_all
lstr_pass.s_string_array[13] = ls_type

//Messagebox('',ls_sql_report)

OpenWithParm(w_batch_alarm_report,lstr_pass )


end event

type tv_datefields from treeview within w_ctx_alarm_batch
event ue_gotodatefield ( )
event ue_report ( )
event ue_refresh ( )
integer x = 78
integer y = 384
integer width = 1417
integer height = 1684
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean linesatroot = true
boolean disabledragdrop = false
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!","DataWindow5!","DataWindow!","GRAYflag.bmp","REDflag.bmp","contract_noalarm.gif","contract_alarm.gif","contract_select.gif"}
long picturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event ue_gotodatefield();Long		ll_EntryType,ll_ctx_id,ll_doc_id,ll_Row,ll_ai_id,ll_level_id1,ll_level_id2
String	ls_table,ls_column,ls_data,ls_array[]
Long ll_handle, ll_parent_handle,ll_screen_id
TreeviewItem ltvi_date,ltvi_ctx
n_cst_string lnv_string

PowerObject lpo_NullParm

ll_handle = This.FindItem(CurrentTreeItem!, 0 ) 
If ll_handle <= 0 Then
	Return
End If

This.GetItem(ll_handle,ltvi_ctx)
If ltvi_ctx.Selectedpictureindex <>  9  Then
	Return
End If

ll_parent_handle = This.FindItem(ParentTreeItem!,ll_handle)
If ll_parent_handle <= 0 Then
	Return
End If

This.GetItem(ll_parent_handle,ltvi_date)
If ltvi_date.Selectedpictureindex <> 6 Then
	Return
End If

ll_Row = ids_batch_alarms.Find('tv_handle = ' + String(ll_parent_handle),1,ids_batch_alarms.RowCount() )
If ll_Row <= 0 Then
	Return
End If
ls_data = ltvi_ctx.data
lnv_string.of_parsetoarray( ls_data, ',', ls_array[] )
If UpperBound(ls_array[]) < 3 Then Return
ll_ctx_id = Long(ls_array[1])
ll_doc_id = Long(ls_array[2])
ll_ai_id = Long(ls_array[3])
ll_level_id1 = Long(ls_array[4])
ll_level_id2 = Long(ls_array[5])
ls_table = ids_batch_alarms.GetItemString(ll_Row,"alm_table") 
ls_column = ids_batch_alarms.GetItemString(ll_Row,"alm_column") 
ll_screen_id = ids_batch_alarms.GetItemNumber(ll_Row,"screen_id") 

If cbx_min.checked Then
	Parent.windowstate = Minimized!
End If

if Not IsValid(gw_Contract) then gf_OpenContractFolder(lpo_NullParm)

Choose Case Lower(ls_table)
	Case 'ctx_basic_info'
		Post gf_GoTo_Contract(ll_ctx_id,"20", 0, 0, 0, ls_column)
		Post of_setfocus_detail_date_field(ll_screen_id,ls_column)
	Case 'ctx_custom'
		Post gf_GoTo_Contract(ll_ctx_id,"22", 0, 0, 0, ls_column)
	Case 'ctx_am_action_item'
		Post gf_GoTo_Contract(ll_ctx_id,"92", ll_doc_id, ll_level_id1, 0, ls_column)
	Case 'ctx_action_item'
		Post gf_GoTo_Contract(ll_ctx_id,"100", 0, ll_ai_id, 0, ls_column)
	Case 'ctx_custom_multi_hdr'
		Post gf_GoTo_Contract(ll_ctx_id,"111", 0, ll_level_id1, 0, ls_column)
	Case 'ctx_custom_multi_detail'
		Post gf_GoTo_Contract(ll_ctx_id,"112", 0, ll_level_id1, ll_level_id2, ls_column)
	Case 'ctx_fee_sched_nm'
		Post gf_GoTo_Contract(ll_ctx_id,"80",0, ll_level_id1, 0, ls_column)
End Choose


end event

event ue_report();cb_report.event clicked( )

end event

event ue_refresh();cb_refresh.event clicked( )
end event

event selectionchanged;//====================================================================
// Event: selectionchanged
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                oldhandle
//                newhandle
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/03/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

TreeViewItem ltvi_data,ltvi_date
str_batch_alarms lstr_batch_alarms
Long ll_date_level_item

//Get Date alarm Level Handle if use select CTX Level handle
If This.GetItem(newhandle, ltvi_data  ) = 1 Then
	If ltvi_data.selectedpictureindex = 9 Then // If CTX Level
		ll_date_level_item = This.FindItem(ParentTreeItem!, newhandle)
		If ll_date_level_item > 0 Then
			If This.GetItem(ll_date_level_item,ltvi_date) = 1 Then
				If ltvi_date.Selectedpictureindex <> 6 Then //Date alarm level
					ll_date_level_item = 0
				End If
			Else
				ll_date_level_item = 0
			End If
		End If
	End If
End If

If ll_date_level_item <= 0 Then
	ll_date_level_item = newhandle
End If

//Refresh Data for this date alarm level
If of_get_date_alarm_info(ll_date_level_item, lstr_batch_alarms) > 0 Then
	istr_batch_alarms = lstr_batch_alarms
	
	If lstr_batch_alarms.as_alm_table = is_table and lstr_batch_alarms.as_alm_column = is_column Then
		Return
	End If
	
	SetPointer(HourGlass!)
//	dw_alm_det.setredraw( False )
//	dw_alm_msg.setredraw( False )
//	ole_message.setredraw( False )
	Parent.SetRedraw(False)
	
	CHOOSE CASE Upper(lstr_batch_alarms.as_alm_table )
		CASE 'CTX_BASIC_INFO','CTX_CUSTOM' 
			dw_alm_det.dataobject = 'd_notification'
			dw_alm_msg.dataobject = 'd_notification_message'
		CASE 'CTX_ACTION_ITEM'
			dw_alm_det.dataobject = 'd_ai_notification'
			dw_alm_msg.dataobject = 'd_ai_notification_message'
		CASE 'CTX_AM_ACTION_ITEM'
			dw_alm_det.dataobject = 'd_am_ai_notification'
			dw_alm_msg.dataobject = 'd_am_ai_notification_message'
		//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' 
		Case Else 
			dw_alm_det.dataobject = 'd_all_notification'
			dw_alm_msg.dataobject = 'd_all_notification_message'
	END CHOOSE

	dw_alm_det.of_SetTransObject(SQLCA)
	dw_alm_msg.of_SetTransObject(SQLCA)

	//catch the message
	gb_1.text =  'Alarm Details for ' + lstr_batch_alarms.as_column_label
	
	ib_DW_Retrieve = False
	
	//Assign key values
	of_parse_keyvalues() 
	SetPointer(HourGlass!)
	wf_retrieve( )	
	
	If Upper(lstr_batch_alarms.as_alm_table ) = 'CTX_AM_ACTION_ITEM' Then
		dw_alm_det.SetItem(1,'doc_id',0)
	Else
		dw_alm_det.SetItem(1,'ctx_id',0)
	End If
	
//	dw_alm_det.setredraw( True )
//	dw_alm_msg.setredraw( True )
//	ole_message.setredraw( True )
	Parent.Post SetRedraw(True)
	
End If
SetPointer(Arrow!)


end event

event itempopulate;//====================================================================
// Event: itempopulate
//--------------------------------------------------------------------
// Description: Added Contract Level Data
//--------------------------------------------------------------------
// Arguments:
//                handle
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/03/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


TreeViewItem ltvi_date, ltvi_ctx,ltvi_null
String ls_table, ls_column, ls_sql_report, ls_lable, ls_data,ls_sql_report_all
Long ll_find, i, ll_row, ll_ctx_id, ll_doc_id, ll_ai_id,ll_level_id1, ll_level_id2, ll_count
n_ds lds_unset_alarm_report,lds_all_alarm_report

If This.GetItem(handle,ltvi_date ) = 1 Then
	If ltvi_date.Selectedpictureindex <> 6 Then 
		Return
	End If
	ll_find = ids_batch_alarms.Find('tv_handle = ' + String(handle) , 1, ids_batch_alarms.rowcount() )
	If ll_find <= 0 Then
		Return
	End If
	ls_table = ids_batch_alarms.GetitemString(ll_find, 'alm_table')
	ls_column = ids_batch_alarms.GetitemString(ll_find, 'alm_column')
	ls_sql_report = Parent.of_gen_sql_report( ls_table, ls_column,'not')	
	ls_sql_report_all = Parent.of_gen_sql_report( ls_table, ls_column,'all')	
	
	If ls_sql_report = '' or  ls_sql_report_all = '' Then
		Return
	End If
	
	SetPointer(HourGlass!)
	
	lds_unset_alarm_report = Create n_ds
	lds_unset_alarm_report.DataObject = 'd_batch_alarm_analysis_report'
	lds_unset_alarm_report.SetTransObject(SQLCA)
	If lds_unset_alarm_report.SetSqlSelect(ls_sql_report) < 0 Then
		gnv_debug.of_output( True, ls_sql_report)
		Messagebox('Error -1','Failed to set SQL.')
	End If
	lds_unset_alarm_report.SetTransObject(SQLCA)
	
	lds_all_alarm_report = Create n_ds
	lds_all_alarm_report.DataObject = 'd_batch_alarm_analysis_report'
	lds_all_alarm_report.SetTransObject(SQLCA)
	If lds_all_alarm_report.SetSqlSelect(ls_sql_report_all) < 0 Then
		gnv_debug.of_output( True, ls_sql_report)
		Messagebox('Error -2','Failed to set SQL.')
	End If
	lds_all_alarm_report.SetTransObject(SQLCA)
	
	gnv_appeondb.of_startqueue( )
		lds_all_alarm_report.Retrieve()
		lds_unset_alarm_report.Retrieve()
	gnv_appeondb.of_commitqueue( )

	If rb_all.checked Then
		ll_count = lds_all_alarm_report.RowCount()
		If (AppeonGetClientType() = 'WEB' and ll_count > 50) or  (AppeonGetClientType() = 'PB' and ll_count > 500) Then
			If Not isvalid(iw_appeon_gifofwait) Then
				Open(iw_appeon_gifofwait)
				iw_appeon_gifofwait.of_settext('Populating Data...')
				Timer(0,iw_appeon_gifofwait)
			End If		
		End If
		For i = 1 To ll_count
			If Isvalid(iw_appeon_gifofwait) Then iw_appeon_gifofwait.of_settext('Populating Data '+String(i) + '/' + String(ll_count)+'...')
			If Isvalid(iw_appeon_gifofwait) Then iw_appeon_gifofwait.of_setposition( i / ll_count * 100)
			ltvi_ctx = ltvi_null 
			ll_ctx_id = lds_all_alarm_report.GetItemNumber(i, 'ctx_id')
			ll_doc_id = lds_all_alarm_report.GetItemNumber(i, 'doc_id')
			ll_ai_id = lds_all_alarm_report.GetItemNumber(i, 'ai_id')
			ll_level_id1 = lds_all_alarm_report.GetItemNumber(i, 'level_id1')
			ll_level_id2 = lds_all_alarm_report.GetItemNumber(i, 'level_id2')
			ltvi_ctx.data = String(ll_ctx_id) + ',' + String(ll_doc_id) + ',' + String(ll_ai_id) + ',' + String(ll_level_id1) + ',' + String(ll_level_id2)
			ls_lable = 'CTX #' + String(ll_ctx_id) + ' ' + lds_all_alarm_report.GetItemString(i, 'company')
			If Len(ls_lable) > 40 Then 
				ls_lable = Mid(ls_lable,1, 37) + '...'
			End If
			ltvi_ctx.label = ls_lable
			If lds_unset_alarm_report.Find('ctx_id = ' + String(ll_ctx_id) + ' and doc_id = ' + String(ll_doc_id) + ' and ai_id = '+ String(ll_ai_id) +  ' and level_id1 = ' + String(ll_level_id1) + ' and level_id2 = ' + String(ll_level_id2) &
												,1, ll_count) > 0 Then
				ltvi_ctx.pictureindex = 7
				ltvi_ctx.selectedpictureindex = 9
			Else
				ltvi_ctx.pictureindex = 8
				ltvi_ctx.selectedpictureindex = 9				
			End If
			This.Insertitemlast( handle, ltvi_ctx )
		Next			
	Else
		ll_count = lds_unset_alarm_report.RowCount()
		If (AppeonGetClientType() = 'WEB' and ll_count > 50) or  (AppeonGetClientType() = 'PB' and ll_count > 500) Then
			If Not isvalid(iw_appeon_gifofwait) Then
				Open(iw_appeon_gifofwait)
				iw_appeon_gifofwait.of_settext('Populating Data...')
				Timer(0,iw_appeon_gifofwait)
			End If		
		End If		
		For i = 1 To ll_count
			If Isvalid(iw_appeon_gifofwait) Then iw_appeon_gifofwait.of_settext('Populating Data '+String(i) + '/' + String(ll_count)+'...')
			If Isvalid(iw_appeon_gifofwait) Then iw_appeon_gifofwait.of_setposition( i / ll_count * 100)			
			ltvi_ctx = ltvi_null 
			ll_ctx_id = lds_unset_alarm_report.GetItemNumber(i, 'ctx_id')
			ll_doc_id = lds_unset_alarm_report.GetItemNumber(i, 'doc_id')
			ll_ai_id = lds_unset_alarm_report.GetItemNumber(i, 'ai_id')
			ll_level_id1 = lds_unset_alarm_report.GetItemNumber(i, 'level_id1')
			ll_level_id2 = lds_unset_alarm_report.GetItemNumber(i, 'level_id2')			
			ltvi_ctx.data = String(ll_ctx_id) + ',' + String(ll_doc_id) + ',' + String(ll_ai_id) + ',' + String(ll_level_id1) + ',' + String(ll_level_id2)
			ls_lable = 'CTX #' + String(ll_ctx_id) + ' ' + lds_unset_alarm_report.GetItemString(i, 'company')
			If Len(ls_lable) > 40 Then 
				ls_lable = Mid(ls_lable,1, 37) + '...'
			End If
			ltvi_ctx.label = ls_lable
			ltvi_ctx.pictureindex = 7
			ltvi_ctx.selectedpictureindex = 9
			This.Insertitemlast( handle, ltvi_ctx )
		Next		
	End If

	If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
	If isvalid(lds_all_alarm_report) Then Destroy lds_all_alarm_report
End If

If Isvalid(iw_appeon_gifofwait) Then Close(iw_appeon_gifofwait)

end event

event rightclicked;//====================================================================
// Event: rightclicked
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                handle
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/03/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


m_batch_alarm_properties lm_batch_alarm_properties
Long ll_x, ll_y, ll_parent_handle, ll_row
TreeViewItem ltvi_date, ltvi_parent
String ls_lable

//Create Menu
if Not IsValid(lm_batch_alarm_properties) then
	lm_batch_alarm_properties = Create m_batch_alarm_properties
	lm_batch_alarm_properties.itv_datealarms = This
end if

//Set Menu
If This.GetItem(handle,ltvi_date ) = 1 Then
	If ltvi_date.Selectedpictureindex = 9 Then 
		gnv_app.of_modify_menu_attr( lm_batch_alarm_properties.m_report,'enabled', True)
		gnv_app.of_modify_menu_attr( lm_batch_alarm_properties.m_gotodatefield,'enabled', True)
		ll_parent_handle = This.FindItem(ParentTreeItem!,handle )
		ll_row = ids_batch_alarms.Find('tv_handle = ' + String(ll_parent_handle), 1, ids_batch_alarms.RowCount())
		If ll_row > 0 Then
			ls_lable = ids_batch_alarms.GetItemString(ll_row, 'alm_column_lable')
			lm_batch_alarm_properties.m_report.text = 'Report for ' + ls_lable
		End If
	End If
	If ltvi_date.Selectedpictureindex = 6 Then 
		gnv_app.of_modify_menu_attr( lm_batch_alarm_properties.m_report,'enabled', True)
		ll_row = ids_batch_alarms.Find('tv_handle = ' + String(handle), 1, ids_batch_alarms.RowCount())
		If ll_row > 0 Then
			ls_lable = ids_batch_alarms.GetItemString(ll_row, 'alm_column_lable')
			lm_batch_alarm_properties.m_report.text = 'Report for ' + ls_lable
		End If
	End If	
End If

//Set TV focus 
ll_x = Parent.PointerX()
ll_y = Parent.PointerY()
If handle > 0 Then
	This.SelectItem ( handle )
End If

//Popup Memu
lm_batch_alarm_properties.popmenu( ll_x, ll_y)
end event

type st_unalarm_cnt from statictext within w_ctx_alarm_batch
integer x = 78
integer y = 180
integer width = 754
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "0 Date Fields without Alarms"
boolean focusrectangle = false
end type

type st_ctx_cnt from statictext within w_ctx_alarm_batch
integer x = 78
integer y = 104
integer width = 1403
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "0 Contract Records Selected "
boolean focusrectangle = false
end type

type rb_not from radiobutton within w_ctx_alarm_batch
integer x = 69
integer y = 2372
integer width = 731
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Dates without Alarms"
boolean checked = true
end type

event clicked;cb_refresh.event clicked( )
end event

type rb_all from radiobutton within w_ctx_alarm_batch
integer x = 69
integer y = 2292
integer width = 1431
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All Dates (Overwrite existing alarms)"
end type

event clicked;If This.checked Then
	Messagebox('Alarms Option','If you choose this option, all alarms including existing alarms will be updated when you execute Batch Set Alarms function. '+ &
					+'~r~n~r~nThe data in the tree view are being refreshed now so as to display all contracts that include this date field.')
End IF

cb_refresh.event clicked( )
end event

type cb_load from commandbutton within w_ctx_alarm_batch
integer x = 1975
integer y = 2508
integer width = 384
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Load Default"
end type

event clicked;Parent.SetRedraw( False)
Parent.of_get_from_default( )
Parent.SetRedraw( True)
end event

type cb_field from commandbutton within w_ctx_alarm_batch
integer x = 3017
integer y = 2508
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert Field"
end type

event clicked;//Alfee 06.11.2008

long		ll_email_id, ll_export_id, ll_found
string	ls_merge_field
str_pass lstr_pass
DataWindowChild ldwc_1

IF dw_alm_msg.RowCount() < 1 THEN RETURN

//Check email template
ll_email_id = dw_alm_msg.GetItemNumber(1,'alm_email_template_id')
IF IsNull(ll_email_id) OR ll_email_id < 1 THEN 
	MessageBox("IntelliSoftGroup","There isn't an Email template found, please check it first!")
	RETURN
END IF

//Find and check export id
dw_alm_msg.Getchild( "alm_email_template_id", ldwc_1)
ldwc_1.Settransobject( SQLCA )
ll_found = ldwc_1.Find('email_id = ' + String(ll_email_id), 1, ldwc_1.Rowcount())
IF ll_found > 0 THEN ll_export_id = ldwc_1.GetItemNumber(ll_found,'export_id')

IF IsNull(ll_export_id) OR ll_export_id < 1 THEN 
	MessageBox("IntelliSoftGroup","There isn't a related export id found, please check it first!")
	RETURN
END IF

//Open merge fields window
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "ALARM"
lstr_pass.s_string_array[1] = 'body'

OpenWithParm(w_agreement_template_merge_fields,lstr_pass)
w_agreement_template_merge_fields.of_set_parent(parent)



end event

type cb_help from commandbutton within w_ctx_alarm_batch
integer x = 4101
integer y = 2508
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;//open(w_ctx_help)
end event

type cb_default from commandbutton within w_ctx_alarm_batch
integer x = 1573
integer y = 2508
integer width = 384
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Set As Default"
end type

event clicked;//Check Create Action Item. //Added By Ken 09/15/2011. 

String ls_value

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()

ls_value = dw_alm_msg.GetItemString(1, "alm_mailto")
if (IsNull(ls_value) or Len(Trim(ls_value)) < 1) then 
	If MessageBox("Verification","The Users to Notify field is empty, do you want to continue?",Question!, Yesno!) = 2 Then 
		dw_alm_msg.setfocus()
		dw_alm_msg.setcolumn("alm_mailto")
		Messagebox('Contract Alarm','Failed to set as default alarm.')
		Return -1
	End If
End If

If (dw_alm_msg.GetItemString(1, 'alm_create') = '' or isnull(dw_alm_msg.GetItemString(1, 'alm_create') )) And &
	dw_alm_det.GetItemString( 1,'create_action_item') = 'Y'  Then
		If Messagebox('Verification','You have checked Create Action Item without assigning a user. Do you want to uncheck Create Action Item?',Question!,YesNo!) = 1 Then
			dw_alm_det.SetItem(1,'create_action_item','N')
		Else
			Messagebox('Contract Alarm ','Failed to set as default alarm.')
			Return -1
		End If
End If

//Insert the word 'New' between the words all and start(name of field) - jervis 09.07.2010
If Messagebox('Contract Alarms',"This will set all new "+istr_pass.s_string_array[4] +" alarms to the settings you currently have in this Alarm window.  This will not affect existing alarms, Continue?",Question!,YesNo!) = 1 Then
	of_set_as_default()
End If



end event

type cb_ok from u_cb within w_ctx_alarm_batch
integer x = 3378
integer y = 2508
integer width = 343
integer taborder = 60
string text = "&Set Alarms"
end type

event clicked;call super::clicked;TreeViewItem ltvi_ctx
String ls_array[]
Long ll_handle
m_batch_update_alarms lm_batch_update_alarms

If is_table = '' Then
	Messagebox('Update','Please select a date field or contract in the tree view first.')
	Return
End If

ll_handle = tv_datefields.FindItem(CurrentTreeItem!, 0)
tv_datefields.GetItem(ll_handle, ltvi_ctx)
If ltvi_ctx.Selectedpictureindex = 9 Then
	lm_batch_update_alarms = Create m_batch_update_alarms
	lm_batch_update_alarms.iw_alarm = Parent
	lm_batch_update_alarms.popmenu( Parent.PointerX(), Parent.PointerY())
Else
	Parent.event ue_updateallctx( )
End If


end event

type cb_cancel from u_cb within w_ctx_alarm_batch
integer x = 3739
integer y = 2508
integer width = 343
integer taborder = 70
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;call super::clicked;ib_disableclosequery =  true
parent.event pfc_close( )
end event

type dw_alm_det from u_dw_contract within w_ctx_alarm_batch
string tag = "Alarm Details"
integer x = 1591
integer y = 64
integer width = 2834
integer height = 580
integer taborder = 10
string title = "Alarm Details"
string dataobject = "d_notification"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event pfc_retrieve;call super::pfc_retrieve;Integer li_setting //02.20.2008
Long ll_width //Alfee 06.27.2008
Blob	lblb_Message //Alfee 06.11.2008

//---------------Begin Modified by Alfee on 02.26.2008 ---------------------
//<$Reason>for date alarm enhancement

This.Reset()

CHOOSE CASE Upper(istr_pass.s_string_array[2])
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM' //add ctx_custom- jervis 05.11.2011
//		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])//modified by gavin 2011-12-28
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
//			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008
		end if
	CASE 'CTX_ACTION_ITEM'
//		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.ctx_action_item_id[1] = long(istr_pass.s_string_array[5])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4]
			//this.object.alm_date = istr_pass.s_datetime[1]
//			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008
		end if				
	CASE 'CTX_AM_ACTION_ITEM'
//		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.doc_id[1] = long(istr_pass.s_string_array[1])
			this.object.seq_id[1] = long(istr_pass.s_string_array[5])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
			//this.object.alm_date = istr_pass.s_datetime[1]
	//		this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008											
		end if	
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'  //ADD CUSTOM MULTI - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
//		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3],0, long(istr_pass.s_string_array[6]),long(istr_pass.s_string_array[7]))
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.doc_id[1] = 0
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
			this.object.level_id1[1] = long(istr_pass.s_string_array[6])
			this.object.level_id2[1] = long(istr_pass.s_string_array[7])
			//this.object.alm_date = istr_pass.s_datetime[1]
//			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008											
		end if	
END CHOOSE


//---------------Begin Added by Alfee 07.26.2007-----------------------------------
String ls_color_enabled, ls_color_disabled
ls_color_disabled = dw_alm_det.Describe("alm_last_notification_sent.Background.Color alm_notification_days.Background.Color")
//modified by alfee 09.11.2007 for new column of 'alm_action_title'
IF dw_alm_det.GetItemString(dw_alm_det.GetRow(), 'create_action_item') = 'Y' THEN
	dw_alm_det.Modify("alm_action_title.Protect = 0 alm_action_title.Background.Color= '" + ls_color_enabled + "'" )	
ELSE
	dw_alm_det.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )			
END IF
//Set work flow field according to the support setting - Alfee 03.27.2008
li_setting = of_get_app_setting("set_47","I")
IF li_setting = 1 THEN  
	dw_alm_det.Modify("wf_id.Visible = 1 wf_id_t.Visible = 1")
ELSE
	ll_width = Long(this.object.alm_last_wf_trigger.width) + Long(this.object.alm_last_wf_trigger.x) - Long(this.object.alm_action_title.x)
	dw_alm_det.Modify("wf_id.Visible = 0 wf_id_t.Visible = 0 alm_last_wf_trigger_t.Visible =0 alm_last_wf_trigger.Visible =0 t_5.Visible =0 " + "alm_action_title.width = " + String(ll_width))
END IF
//---------------End Added --------------------------------------------------------

dw_alm_det.Modify('b_reset.visible = 0') //Added By Ken.Guo 11/29/2012

//Added By Ken.Guo 2009-09-11.
If ib_new_mode Then
	of_get_from_default()
End If

IF ib_new_mode and dw_alm_det.RowCount() > 0 THEN 
	dw_alm_det.SetItemStatus(1, 0, Primary!, NotModified!) //Alfee 06.11.2008
END IF

return success


end event

event pfc_validation;call super::pfc_validation;




if not f_validstr(string(this.object.alm_notification_days[1] )) then 
	messagebox('Validation', 'Please enter a value for Notification days')
	return failure
end if


return success
end event

event pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.05.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
//$<modification> Comment out the following script to reduce client-server interaction.
//$<modification> refer to of_get_id for more information.
/*
this.object.record_id[1]= inv_contract.of_get_next_record_id( )
*/
long ll_rowcount_local,ll_WfID
LONG LL_MAX_ROW,ll_Length
LL_MAX_ROW = rowcount( )

Long ll_record_id = 0
String ls_alm_mailto//alfee 12.08.2008

for ll_rowcount_local = 1 to LL_MAX_ROW
	 if (not f_validstr(string(this.getitemNumber(ll_rowcount_local,'record_id')))) OR ll_rowcount_local = 1 then
			if ll_record_id = 0 then
				ll_record_id = gnv_app.of_get_id('RECORD_ID', LL_MAX_ROW)
			Else
				ll_record_id++
			end if

         this.setItem(ll_rowcount_local,'record_id', ll_record_id)
	 end if 
next
//---------------------------- APPEON end ----------------------------

dw_alm_msg.AcceptText() //Alfee 02.22.2008

Return success

end event

event itemchanged;call super::itemchanged;String ls_create_action_item
long ll_incream

String ls_color_enabled, ls_color_disabled, ls_action_title
ls_color_enabled = This.Describe("alm_notification_days.Background.Color")
ls_color_disabled = This.Describe("alm_last_notification_sent.Background.Color")
Choose Case dwo.name 
	Case'create_action_item' 
		If data = 'Y' Then
			This.Modify("alm_action_title.Protect = 0 alm_action_title.Background.Color= '" + ls_color_enabled + "'" )			
			ls_action_title = This.GetItemString(row,"alm_action_title")
			IF IsNull(ls_action_title) or Len(Trim(ls_action_title)) < 1 THEN 
				This.SetItem(row, "alm_action_title", Left(istr_pass.s_string_array[4], 20))
			END IF
			dw_alm_msg.post event buttonclicked(row,0,dw_alm_msg.object.b_sendto)
		Else
			This.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )						
		End If
		ll_incream = This.GetItemnumber(row,'alm_auto_increment_years')
		If data = 'N' and ll_incream > 0 Then
			Messagebox('Information','Because you have Auto Snooze selected and do not want an Action Item created, the system will automatically increment the Date field once the initial email reminder is sent.')
		End If
	Case 'alm_auto_increment_years'
		ls_create_action_item = This.GetItemString(row,'create_action_item')
		If ls_create_action_item = 'N' and long(data) > 0 Then
			Messagebox('Information','Because you have Auto Snooze selected and do not want an Action Item created, the system will automatically increment the Date field once the initial email reminder is sent.')
		End If		
End Choose


end event

event buttonclicked;call super::buttonclicked;str_pass lstr_pass_in,lstr_pass_out,lstr_alarm
String ls_ctx_id 

If dwo.name = 'b_snooze' Then
	This.AcceptText()
	lstr_pass_in.s_string_array[1] = String(il_ctx_id)
	lstr_pass_in.s_string_array[2] = is_table
	lstr_pass_in.s_string_array[3] = is_column	
	lstr_pass_in.s_string_array[4] = String(This.GetItemNumber(Row,'alm_auto_increment_years'))
	lstr_pass_in.s_string_array[5] = This.GetItemString(Row,'alm_auto_increment_unit')
	lstr_pass_in.s_string_array[6] = string(il_level_id1)
	lstr_pass_in.s_string_array[7] = string(il_level_id2)
	lstr_pass_in.s_ds = ids_snooze_ctx
	
	OpenWithParm(w_alm_snooze,lstr_pass_in)
	If isvalid(Message.powerobjectparm) Then
		lstr_pass_out = Message.powerobjectparm
		If lstr_pass_in <> lstr_pass_out Then
			This.SetItem(Row,'alm_auto_increment_years',Long(lstr_pass_out.s_string_array[4]))
			This.SetItem(Row,'alm_auto_increment_unit',lstr_pass_out.s_string_array[5])
		End If
		
		//Added By Ken.Guo 11/29/2012
		If il_ctx_id = 0 Then
			ids_snooze_ctx = lstr_pass_out.s_ds
		End If
		
	End If
End If

//Added By Ken.Guo 12/26/2012. Support Alarm Email Log
String ls_where, ls_alarm_type
TreeViewItem ltvi_ctx
n_cst_notification inv_notification
Long ll_handle
If dwo.name = 'b_log' Then
	If is_table = '' Then
		Messagebox('Email Log','Please select a date field or contract in the tree view first.')
		Return
	End If
	
	//add table clause
	inv_notification = Create n_cst_notification
	ls_alarm_type = inv_notification.of_get_alarm_type( is_table )
	ls_where  = ' Where 1 = 1 '
	ls_where += " and (alarm_type = '"+ls_alarm_type+"' or alarm_type = 'Group Email') "

	lstr_pass_in.s_string_array[1] = 'Email Log for ' + dw_alm_det.GetItemString(1, 'alm_action_title')

	//Add Column Clause
	If is_column <> '' Then
		ls_where += " And (CharIndex('(" + is_column + ")', em_mail_audit.field_name) > 0 or ( alarm_type = 'Group Email' And CharIndex('(" + is_column + ")', em_mail_audit.notes) > 0 And CharIndex('(" + ls_alarm_type + ")', em_mail_audit.alarm_type) > 0 )  )  " 
	End If
	
	//Add ctx clause
	ll_handle = tv_datefields.FindItem(CurrentTreeItem!, 0)
	tv_datefields.GetItem(ll_handle, ltvi_ctx)
	If ltvi_ctx.Selectedpictureindex = 9 Then
		//special CTX
		gnv_string.of_parsetoarray( ltvi_ctx.data , ',', lstr_alarm.s_string_array[] )  
		If UpperBound(lstr_alarm.s_string_array[]) >= 4 Then
			If lstr_alarm.s_string_array[1] <> '' and lstr_alarm.s_string_array[1] <> '0' Then
				ls_where += " And CharIndex('," + lstr_alarm.s_string_array[1] + ",', ',' + em_mail_audit.ctx_id_list + ',' )  > 0 " 
			End If
			If lstr_alarm.s_string_array[2] <> '' and lstr_alarm.s_string_array[2] <> '0' Then
				ls_where += " And CharIndex('," + lstr_alarm.s_string_array[2] + ",', ',' + em_mail_audit.doc_id_list + ',' ) > 0 " 
			End If		
			If lstr_alarm.s_string_array[3] <> '' and lstr_alarm.s_string_array[3] <> '0' Then
				ls_where += " And CharIndex('," + lstr_alarm.s_string_array[3] + ",', ',' + em_mail_audit.ai_id_list + ',' ) > 0 " 
			End If				
			If lstr_alarm.s_string_array[4] <> '' and lstr_alarm.s_string_array[4] <> '0' Then
				ls_where += " And CharIndex('," + lstr_alarm.s_string_array[4] + ",', ',' + em_mail_audit.level_id1_list + ',' ) > 0 " 
			End If			
			If lstr_alarm.s_string_array[5] <> '' and lstr_alarm.s_string_array[5] <> '0' Then
				ls_where += " And CharIndex('," + lstr_alarm.s_string_array[5] + ",', ','+ em_mail_audit.level_id2_list + ',' ) > 0 " 
			End If						
		End If
		lstr_pass_in.s_string_array[1] += ' for Contract #' + String(lstr_alarm.s_string_array[1])
	Else
		//ALL Selected CTXs ic_client_data
		ls_where += "And Exists (Select 1 From ic_client_data Where client_id = '"+is_client_id+"' and CharIndex(','+Convert(varchar(10),data_int)+ ',', ','+em_mail_audit.ctx_id_list + ',') > 0 ) "
		lstr_pass_in.s_string_array[1] += ' for Selected Contract(s)'
	End If
	
	If isvalid(inv_notification) Then Destroy inv_notification
	
	lstr_pass_in.s_string = ls_Where
	OpenWithParm(w_email_audit,lstr_pass_in )
End If

end event

event constructor;call super::constructor;This.InsertRow(0)
end event

type gb_1 from u_gb within w_ctx_alarm_batch
integer x = 1573
integer y = 12
integer width = 2871
integer height = 640
integer taborder = 0
long backcolor = 33551856
string text = "Alarm Details"
end type

type sle_subject from singlelineedit within w_ctx_alarm_batch
integer x = 2025
integer y = 936
integer width = 2377
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;dw_alm_msg.SetItem( 1,'alm_subject',this.text)
end event

event getfocus;if isvalid(w_agreement_template_merge_fields) then
	w_agreement_template_merge_fields.rb_subject.checked = true
end if
end event

type gb_2 from u_gb within w_ctx_alarm_batch
integer x = 1573
integer y = 664
integer width = 2871
integer height = 1816
integer taborder = 0
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Email Notification"
end type

type st_2 from statictext within w_ctx_alarm_batch
integer x = 1618
integer y = 1076
integer width = 457
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 80263581
string text = "Alert Message:"
boolean focusrectangle = false
end type

type dw_alm_msg from u_dw_contract within w_ctx_alarm_batch
string tag = "Alarm Details"
integer x = 1600
integer y = 720
integer width = 2825
integer height = 424
integer taborder = 20
boolean bringtotop = true
string title = "Alarm Details"
string dataobject = "d_notification_message"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_allow_save = false
end type

event itemchanged;call super::itemchanged;//Refresh alert message with the new email template - Alfee 06.11.2008
Long ll_email_id, ll_found
string ls_attach_name, ls_attach_ori
Blob lblb_Message, lblb_attachment
string ls_autosign
//n_cst_string lnv_string
string ls_create_users[],ls_create_list,ls_create_users_new[], ls_create_email_new[]
long ll_i,ll_count,i
string ls_subject

CHOOSE CASE Lower(dwo.name)
	CASE 'alm_email_template_id'
		if Not IsNumber(data) then return
		ll_email_id = long(data)
		IF ll_email_id < 0 THEN RETURN

		//Set insert field button
		Post of_set_insertfield()
				
		SetPointer(HourGlass!)
		SetRedraw(FALSE)
		
		//Set attachment from email template
		ll_found = idwc_template.Find('email_id = ' + String(data), 1, idwc_template.RowCount())
		IF ll_found > 0 THEN 
			ls_attach_name = idwc_template.GetItemString(ll_found, 'attach_name')
			ls_autosign = idwc_template.GetItemString(ll_found, 'auto_sign') //01.20.2009 By Jervis
			ls_subject = idwc_template.GetItemString(ll_found, 'subject') //03.29.2010 By Jervis
			this.SetItem(row,'auto_sign',ls_autosign)
			this.SetItem(row,'alm_subject',ls_subject) //03.29.2010 By Jervis
			//sle_subject.text = ls_subject
		end if
		
		ls_attach_ori = This.GetItemString(row, 'alm_attachment_name')				
		
		IF IsNull(ls_attach_name) THEN ls_attach_name = ''
		IF IsNull(ls_attach_ori) THEN ls_attach_ori = ''	
		IF Len(trim(ls_attach_ori)) > 0 OR Len(trim(ls_attach_name)) > 0 THEN
			This.SetItem(row, 'alm_attachment_name', ls_attach_name)
			ib_attachment_modified = TRUE
		END IF
		
		is_attachment = ''
		
		if ll_email_id = 0 then			//Added by Scofield on 2009-02-23
			ib_attachment_from_template= FALSE
		else
			ib_attachment_from_template= TRUE
		end if
		
		ib_delete_attach = true			//Added by Scofield on 2009-02-23
		
		//Get and open message from email template
		inv_mail.of_get_mail_template(ll_email_id, lblb_Message)
		ole_message.of_open(lblb_Message)	
		
		SetRedraw(TRUE)
		
		of_set_messagechanged(TRUE)
	case 'alm_mailto'		
		//Begin - Modified By Ken.Guo 2010-03-02
		//because alm_create field saved user_id, not saved email_id yet.
		
		/*
		//jervis 10.13.2009
		//set alm_create
		ls_create_list = this.GetItemString( row,"alm_create")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users)
		ll_count = UpperBound(ls_create_users)
		if ll_count > 0 then
			for ll_i = 1 to ll_count
				if Pos(data,trim(ls_create_users[ll_i])) =  0 then
					ls_create_users[ll_i] = ''
				end if
			next
			lnv_string.of_arraytostring( ls_create_users, ";", true, ls_create_list)
			this.SetItem( row, "alm_create",ls_create_list)
		end if
		*/
		long ll_find
		String ls_email
		ls_create_list = this.GetItemString( row,"alm_create")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
		For i = 1 To UpperBound(ls_create_users[])
			ll_find = ids_user_mail_map.Find('trim(lower(user_id)) = "' + trim(lower(ls_create_users[i])) + '"' ,1,ids_user_mail_map.rowcount())
			If ll_find <= 0 Then Continue
			ls_email = ids_user_mail_map.GetItemString(ll_find,'email_id')
			If Pos(lower(data),lower(trim(ls_email))) > 0 Then
				ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
			End If
		Next
		If UpperBound(ls_create_users_new[]) > 0 Then
			lnv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
		Else
			ls_create_list = ''
		End If
		this.SetItem( row, "alm_create",ls_create_list)
		//End - Modified By Ken.Guo 2010-03-02
		
		ls_create_users = ls_create_email_new
		ls_create_list = this.GetItemString( row,"alm_appointment")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
		For i = 1 To UpperBound(ls_create_users[])
			If Pos(lower(data),lower(trim(ls_create_users[i]))) > 0 Then
				ls_create_email_new[UpperBound(ls_create_email_new[]) + 1 ] = ls_create_users[i]
			End If
		Next
		If UpperBound(ls_create_users_new[]) > 0 Then
			lnv_string.of_arraytostring( ls_create_email_new, ";", true, ls_create_list)
		Else
			ls_create_list = ''
		End If
		this.SetItem( row, "alm_appointment",ls_create_list)
		
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;//Alfee 06.11.2008
Integer li_rtn
String docpath, docname, ls_userlist

String	ls_PathName,ls_FileName[],ls_AttachList,ls_FileList
long		ll_Rtn,ll_Cycle,ll_FileCnts

This.Accepttext( )
CHOOSE CASE Lower(dwo.name)
	CASE 'b_attach'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2009-02-23 By: Scofield
		//$<Reason> Select Multi-Files as Attachment.
		gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
		ll_Rtn = GetFileOpenName("Select File", ls_PathName, ls_FileName, "DOC", "All Files (*.*), *.*")
		gf_save_dir_path(ls_PathName) //Added by Ken.Guo on 2009-03-10
		//ChangeDirectory(gs_current_path)
		if ll_Rtn <> 1 then Return
		
		ll_FileCnts = UpperBound(ls_FileName)
		
		if ll_FileCnts > 1 then
			if Right(ls_PathName,1) <> "\" then ls_PathName += "\"
			
			for ll_Cycle = 1 to ll_FileCnts
				ls_FileList += ls_FileName[ll_Cycle] + SEMICOLON
				is_attachment += ls_PathName + ls_FileName[ll_Cycle] + SEMICOLON
			next
		elseif ll_FileCnts = 1 then
			ls_FileList += ls_FileName[ll_FileCnts] + SEMICOLON
			is_attachment += ls_PathName + SEMICOLON
		else
			Return
		end if
		
		ls_AttachList = Trim(dw_alm_msg.GetItemString(1,"alm_attachment_name"))
		if IsNull(ls_AttachList) then ls_AttachList = ""
		if Trim(ls_AttachList) <> "" and Right(ls_AttachList,1) <> SEMICOLON then ls_AttachList += SEMICOLON
		
		ls_AttachList += ls_FileList
		dw_alm_msg.SetItem(1, "alm_attachment_name", ls_AttachList)
		
		ib_attachment_modified = TRUE
		

	CASE 'b_clear'
		IF Len(Trim(dw_alm_msg.GetItemString(1, "alm_attachment_name"))) > 0 THEN
			dw_alm_msg.SetItem(1, "alm_attachment_name", '')
			is_attachment = ''
			ib_attachment_modified = TRUE
			ib_attachment_from_template = FALSE
			ib_delete_attach = true
		END IF
	CASE 'b_sendto'
		//Modify by jervis 10.12.2009
		str_alarm_user	lstr_alarm
		
		lstr_alarm.s_flag = dw_alm_det.GetItemString( 1,"create_action_item")
		lstr_alarm.s_to_list = this.GetItemString(row,'alm_mailto')
		lstr_alarm.s_create_list = this.GetItemString( row,'alm_create')
		lstr_alarm.s_type = istr_pass.s_string_array[2] //Added By Ken.Guo 2010-03-04.
		lstr_alarm.s_appointment = This.GetItemString(row, 'alm_appointment') //added by gavins 20121031
		Openwithparm(w_ctx_alarm_users,lstr_alarm)
		

		lstr_alarm = message.PowerObjectParm
		if isvalid(lstr_alarm) then
			of_add_notification_users(lstr_alarm,'')
		end if
END CHOOSE

end event

type gb_3 from u_gb within w_ctx_alarm_batch
integer x = 37
integer y = 12
integer width = 1490
integer height = 256
integer taborder = 20
long backcolor = 33551856
string text = "Alarm Summary"
end type

type gb_4 from u_gb within w_ctx_alarm_batch
integer x = 37
integer y = 308
integer width = 1490
integer height = 1876
integer taborder = 30
long backcolor = 33551856
string text = "Date Fields (Unset Alarm Count / All Count)"
end type

type gb_5 from u_gb within w_ctx_alarm_batch
integer x = 37
integer y = 2220
integer width = 1490
integer height = 260
integer taborder = 30
long backcolor = 33551856
string text = "Set Alarms Option"
end type

type st_1 from statictext within w_ctx_alarm_batch
boolean visible = false
integer x = 1234
integer y = 1056
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 80263581
string text = "Subject:"
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
09w_ctx_alarm_batch.bin 
2400000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000084924fe001d131c300000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000084924fe001d131c384924fe001d131c30000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003f5b0000217d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003f5b0000217d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19w_ctx_alarm_batch.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
