$PBExportHeader$n_cst_notification.sru
$PBExportComments$Contract notification user object
forward
global type n_cst_notification from nonvisualobject
end type
end forward

global type n_cst_notification from nonvisualobject
end type
global n_cst_notification n_cst_notification

type variables
//
n_ds ids_alm_status
n_ds ids_users //Alfee 08.20.2008
n_cst_datetime inv_datetime 

string is_primary_key 
constant long success = 1
constant LONG FILTER_FAILED = -200
constant long SECONDS_IN_A_DAY = 86400

mailSession  	ims_mSes		// Mail session.

// start code change --- 10.31.2005
constant string word_2003_path = 'C:\Program Files\Microsoft Office\OFFICE11\WINWORD.EXE'
constant string message_150 = 'The Contract Action type code AUTOMSG is missing. Please re-add it. Action Items have not been created.'
// end   code change --- 10.31.2005

// start code change --- 11.09.2005
n_ds lds_action_items
n_ds ids_action_type
string is_col_tab
//string is_alarm_from  //- Alfee 02.26.2008
boolean ib_need_update = FALSE //- Alfee 02.26.2008
boolean ib_message_displayed // indicates if the messagebox has been displayed
// end code change --- 11.09.2005

datetime ldtServerDate

//---Alfee 06.11.2008-----
//str_alarm istr_alm 		//for alarm setting 
str_export istr_exp[]     //for export data
n_ds ids_email_template //for email template info
n_ds ids_export_ctx 		//for export-ctx list, external datasource
//------------------------

boolean ib_inserted_action_item = false //Added By Ken.Guo 2009-09-11.
n_ds ids_sec_users //Added By Ken.Guo 2010-03-04.
boolean ib_group_email = false
str_group_alarm istr_group_alarm[],istr_null[]
String is_sa_address
Long il_index = 0,il_count
//String  is_alarm_from_list[] = {'ctx_basic_info','ctx_custom','ctx_action_item','ctx_am_action_item','ctx_custom_multi_hdr','ctx_custom_multi_detail'} //add ctx_custom - jervis 05.19.2011
n_ds    ids_alm[4]


Boolean		ib_SendStatus //added by gavins 20120821

//---------Begin Modified by (Appeon)Harry 06.27.2013 for V141 ISG-CLX--------
n_cst_message inv_message //scheduler - alfee 02.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
//---------End Modfiied ------------------------------------------------------

end variables

forward prototypes
public function integer of_start_notification_process ()
public function integer of_get_alarm_setting (n_ds adw_1, long al_row, ref str_alarm astr_alarm)
public function integer of_get_exp_ctx (n_ds ads_1[])
public function long of_check_alarms (ref n_ds adw)
public subroutine of_parse_users (string as_maillist, ref string as_users[])
public function integer of_group_send_email ()
public function integer of_group_generate_email (n_ds ads_status, long al_row)
public function integer of_pre_send_email ()
public subroutine of_group_update_counts ()
public function integer of_create_email_notification (str_alarm astr_alarm)
public function integer of_update_action_items (string ls_action_type, str_alarm astr_alm)
public function integer of_replace_merge_fields (oleobject ole_word, ref str_alarm astr_alm)
public function long of_send_mail (string as_sender, string as_mailto[], string as_mailcc[], string as_subject, string as_attachment, blob ablb_message, boolean ab_autosign, str_alarm astr_alm)
public function integer of_update_counters (str_alarm astr_alm)
public function long of_send_mail (n_ds adw)
public function integer of_insert_action_item (long al_ctx_id, long al_lookup_code, string as_user_id, string as_letter_flag, str_alarm astr_alm)
public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[], long al_docid[], long al_level_id1[], long al_level_id2[])
public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[])
public function long of_send_mail (string as_sender, string as_mailto[], string as_mailcc[], string as_subject, string as_attachment, blob ablb_message, boolean ab_autosign, str_alarm astr_alm, string as_alarm_ways)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (boolean ab_flag)
public function string of_get_alarm_type (string as_alm_table)
end prototypes

public function integer of_start_notification_process ();/******************************************************************************************************************
**  [PUBLIC]   : of_start_notification_process
**  Purpose   	: The is the main function to complete the notification process for sending emails
**               to users
**  Arguments 	: [none] 
**  Returns   	: [none]   
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 13 october 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**  Changed By      Change Date     Reason 
** ------------------------------------------------------------------------------------------------------------------
**	 Alfee.Shi	     08.20.2008      Date Alarm Enhancement on notification users in V8.5
********************************************************************************************************************/
integer i

gnv_status_info.of_display("Start Email notification, please wait...")

il_count = of_pre_send_email()

IF il_count > 0 THEN
//	openwithparm( w_wait, "Start Email notification, please wait..." )
//	w_wait.hpb_1.MaxPosition = il_count 		
//	w_wait.hpb_1.Position = 0
//	w_wait.hpb_1.SetStep = 1
	
END IF

try
ib_SendStatus = false
//Start notification process
If ib_group_email Then
	//Group Send Email
	of_group_send_email()
	of_group_update_counts()
Else
	FOR i = 1 to 4
		//is_alarm_from = is_alarm_from_list[i]		
		ids_alm_status = ids_alm[i]
		of_send_mail( ids_alm_status ) 
		If isvalid(ids_alm[i]) Then Destroy ids_alm[i]
	NEXT	
End If	

catch ( exception ex )
finally 
	If  IsValid( w_email_edit ) Then close( w_email_edit )//modified by gavins 20120821w_email_edit_alarm
	If  IsValid( w_email_edit_alarm ) Then close( w_email_edit_alarm )
	If ib_SendStatus Then MessageBox( 'Tips' , 'Failed to merge fields for some emails. Please check the email log and click ”Run Date Email Alarm Query “ to try again.' )
	ib_SendStatus = false
end try
	

//IF IsValid(w_wait) THEN Close(w_wait)
gnv_status_info.of_display("")

RETURN 0


end function

public function integer of_get_alarm_setting (n_ds adw_1, long al_row, ref str_alarm astr_alarm);//Get alarm setting into structure - Alfee 08.20.2008

str_alarm lstr_null

astr_alarm = lstr_null 
IF al_row > adw_1.RowCount() or al_row <= 0 THEN RETURN 0

astr_alarm.ctx_id = adw_1.getItemNumber(al_row, "ctx_id")	
astr_alarm.alm_table = adw_1.getItemString(al_row, 'alm_table')
astr_alarm.alm_column = adw_1.getItemString(al_row, 'alm_column')
astr_alarm.alm_email_template_id = adw_1.getItemNumber(al_row, 'alm_email_template_id')
astr_alarm.alm_attachment_name = adw_1.getItemString(al_row, 'alm_attachment_name')
astr_alarm.alm_message_length = adw_1.getItemNumber(al_row, "alm_message_length")	
astr_alarm.alm_attachment_length = adw_1.getItemNumber(al_row, "alm_attachment_length")	
astr_alarm.wf_id = adw_1.GetItemNumber(al_row,'wf_id')
astr_alarm.alm_mailto = adw_1.GetItemString(al_row,'alm_mailto')
astr_alarm.autosign	= adw_1.GetItemString(al_row,'auto_sign')
astr_alarm.alm_create = adw_1.GetItemString(al_row,'alm_create')	//10.12.2009 by jervis
astr_alarm.alm_subject = adw_1.GetItemString(al_row,'alm_subject')  //03.29.2010 by jervis

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
astr_alarm.as_appointment = adw_1.GetItemString(al_row,'alm_appointment') //added by gavins 20121029
//---------End Added ------------------------------------------------------

//Added By Ken.Guo 2010-08-09.
Long ll_cnt,ll_remind
astr_alarm.ctx_company = adw_1.GetItemString(al_row,'app_facility_facility_name') 
astr_alarm.ctx_category = adw_1.GetItemNumber(al_row,'ctx_basic_info_category')
choose case lower(astr_alarm.alm_table) 
	case 'ctx_basic_info','ctx_action_item','ctx_am_action_item'
		astr_alarm.alm_date_value = adw_1.GetItemDateTime(al_row, astr_alarm.alm_column )
	//case 'ctx_custom','ctx_custom_multi_hdr','ctx_custom_multi_detail'
	case else //add fee scheduce - jervis 08.02.2011
		astr_alarm.alm_date_value = adw_1.GetItemDateTime(al_row, 'alm_date' )
end choose

ll_cnt = adw_1.GetItemNumber(al_row,'alm_total_tries_counter')
If isnull(ll_cnt) Then ll_cnt = 0
//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
astr_alarm.al_alm_times = ll_cnt  //added by gavins 20121029
//---------End Added ------------------------------------------------------
ll_remind = adw_1.GetItemNumber(al_row,'alm_total_tries') - ll_cnt - 1
If isnull(ll_remind) or ll_remind < 0 Then ll_remind = 0 
astr_alarm.alm_times_reminded = ll_remind
astr_alarm.as_owner = adw_1.GetItemString(al_row,'owner')
astr_alarm.as_column_name = adw_1.GetItemString(al_row,'alm_column_name')

//CHOOSE CASE Upper(is_alarm_from)
CHOOSE CASE Upper(astr_alarm.alm_table) //jervis 06.28.2011
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		astr_alarm.as_alm_type =   'ALARM'//added by gavins 20121029
		//---------End Added ------------------------------------------------------
	CASE 'CTX_ACTION_ITEM'
		astr_alarm.ai_id = adw_1.getItemNumber(al_row, "ctx_action_item_id")	
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		astr_alarm.as_alm_type =   'AIDUEDATE'//added by gavins 20121029
		//---------End Added ------------------------------------------------------
	CASE 'CTX_AM_ACTION_ITEM'
		astr_alarm.doc_id = adw_1.getItemNumber(al_row, "doc_id")	
		astr_alarm.seq_id = adw_1.getItemNumber(al_row, "seq_id")	
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		astr_alarm.level_id1 = astr_alarm.seq_id //Added By Ken.Guo 12/26/2012
		//---------End Added ------------------------------------------------------
		astr_alarm.doc_name = adw_1.getItemString(al_row, "doc_name")					
		astr_alarm.as_notes = 'DOC ID = ' + String(astr_alarm.doc_id)
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		astr_alarm.as_alm_type =   'AIDUEDATE'//added by gavins 20121029
		//---------End Added ------------------------------------------------------
	case else	//add by jervis 06.28.2011
		astr_alarm.doc_id = adw_1.getItemNumber(al_row, "doc_id")	
		astr_alarm.level_id1 = adw_1.getItemNumber(al_row, "level_id1")	
		astr_alarm.level_id2 = adw_1.getItemNumber(al_row, "level_id2")	
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		astr_alarm.as_alm_type =   'AIDUEDATE'//added by gavins 20121029
		//---------End Added ------------------------------------------------------
END CHOOSE


RETURN 1
end function

public function integer of_get_exp_ctx (n_ds ads_1[]);//Get and keep an export-ctx list for performance tuning on exporting data - Alfee 06.11.2008

Long ll_alm_cnt, ll_template_cnt, ll_exp_cnt
Long i, ll_found, ll_row, ll_found_exp, ll_i_arr
Long ll_export_id, ll_ctx_id, ll_template_id

//email template
ll_template_cnt = ids_email_template.RowCount()
IF ll_template_cnt < 1 THEN RETURN 0

//from contract, action item or document manager...
FOR ll_i_arr = 1 to UpperBound(ads_1)

  //filter date alarms with email notifications
  ads_1[ll_i_arr].SetFilter('email_notification = 1')
  ads_1[ll_i_arr].Filter()

  //all of the alarms 	
  ll_alm_cnt = ads_1[ll_i_arr].RowCount()
  FOR i = 1 to ll_alm_cnt

	 //get export id by the email template id	
	 ll_export_id = -1
	 ll_template_id = ads_1[ll_i_arr].GetItemNumber(i,'alm_email_template_id')
	 ll_found = ids_email_template.Find('email_id = ' + String(ll_template_id), 1, ll_template_cnt)
	 IF ll_found > 0 THEN ll_export_id = ids_email_template.GetItemNumber(ll_found, 'export_id')

	 //store the export-ctx record if not duplicated
	 IF ll_export_id > 0 THEN 
		ll_ctx_id = ads_1[ll_i_arr].GetItemNumber(i, 'ctx_id')
		ll_exp_cnt = ids_export_ctx.RowCount()
		IF ll_exp_cnt > 0 THEN ll_found_exp = ids_export_ctx.Find('export_id = ' + String(ll_export_id) + ' And ctx_id = ' + String(ll_ctx_id), 1, ll_exp_cnt )
		IF ll_exp_cnt < 1 or ll_found_exp < 1 THEN		
			ll_row = ids_export_ctx.InsertRow(0)
			ids_export_ctx.SetItem(ll_row, 'export_id', ll_export_id)
			ids_export_ctx.SetItem(ll_row, 'ctx_id', ll_ctx_id)
		END IF
	 END IF	 
  NEXT
  
  //Restore alarms after filter
  ads_1[ll_i_arr].SetFilter('email_notification = 1 OR wf_trigger = 1')
  ads_1[ll_i_arr].Filter()
NEXT
	
RETURN 1
end function

public function long of_check_alarms (ref n_ds adw);//Check and filter unqualified alarms first for performance tuning on exporting data
//Added by Alfee on 06.11.2008
//Modified by Alfee on 08.20.2008, for date alarm enhancement on notification users in v8.5

Long ll_i, ll_ctx_id, ll_wf_id 
Long ll_frequency, ll_notificatin_days, ll_total_tries, ll_total_tries_counter
String ls_table, ls_column, ls_mailto 
Datetime LD_DATE, ll_relative_date, ldt_last_notification_date, ldt_last_wf_trigger 
Boolean lb_email_notificaiton, lb_wf_trigger

FOR ll_i = 1 TO adw.rowcount( )  //all of the alarms	
	 Yield() //Added By Ken.Guo 2010-11-25.
	 //Get current alarm info
	 lb_email_notificaiton = FALSE 
	 lb_wf_trigger = FALSE
	 ls_table  = adw.getItemString(ll_i, 'alm_table')
	 ls_column = adw.getItemString(ll_i, 'alm_column')
	 ll_notificatin_days = adw.getItemNumber(ll_i, 'alm_notification_days')
	 ll_total_tries_counter = adw.getItemNumber(ll_i, 'alm_total_tries_counter')
	 ll_total_tries = adw.getItemNumber(ll_i, 'alm_total_tries')
	 ll_frequency = adw.getItemNumber(ll_i,'alm_frequency')
	 ll_wf_id = adw.GetItemNumber(ll_i,'wf_id')
	 ldt_last_wf_trigger = adw.GetItemDateTime(ll_i,'alm_last_wf_trigger') 
	 ls_mailto = adw.GetItemString(ll_i,'alm_mailto') 
	 
	 ll_ctx_id = adw.getItemNumber(ll_i, "ctx_id")  //jervis 06.28.2011


	 //Added By Ken.Guo 2011-04-21.
	 If gnv_data.of_getitem('icred_settings', 'set_10', False) = '1' Then //Debug
		 gnv_debug.of_output(False,This.ClassName() + '.of_check_alarms(): '+&
		  'll_ctx_id = ' + String(ll_ctx_id) + &
		 ', ls_table = ' + gf_string(ls_table) + ', ls_column = ' + gf_string(ls_column) 	+', ll_notificatin_days = ' + gf_String(ll_notificatin_days) + &
		 ', ll_total_tries_counter = ' + gf_String(ll_total_tries_counter) + ', ll_total_tries = ' + gf_String(ll_total_tries) + &
		 ', ll_frequency = ' +  gf_String(ll_frequency) + ', ll_wf_id = ' + gf_String(ll_wf_id) + ', ldt_last_wf_trigger = ' + gf_String(ldt_last_wf_trigger) +&
		 ', ls_mailto = ' + gf_String(ls_mailto)	 )
	End If

	 adw.SetRow(ll_i) //Set current row
	 
	 //Set Email and Work Flow flags accordingly
	 IF ( NOT IsNull(ls_mailto) AND Len(Trim(ls_mailto)) > 0 ) & 
	 	 OR IsNull(ldt_last_wf_trigger) OR date(ldt_last_wf_trigger) = date('1900-01-01') THEN 
		
		choose case lower(ls_table) //jervis 07.04.2011
			case 'ctx_basic_info','ctx_action_item','ctx_am_action_item'
				LD_DATE = adw.GetItemDateTime(ll_i, ls_column)
			//case 'ctx_custom','ctx_custom_multi_hdr','ctx_custom_multi_detail'
			case else //add fee scheduce - jervis 08.02.2011
				LD_DATE = adw.GetItemDateTime(ll_i, 'alm_date')
		end choose
		// determine if it's in the range to alarm	
		ll_relative_date = inv_datetime.of_relativedatetime( LD_DATE ,  (ll_notificatin_days * SECONDS_IN_A_DAY) * -1 )

			// calculate the notification start date									
			IF (date(ldtServerDate) = date(ll_relative_date) ) OR date(ldtServerDate) >  date(ll_relative_date) THEN

				// determine when the last notification was sent out
				ldt_last_notification_date = adw.GetItemDateTime(ll_i,'alm_last_notification_sent') 
			
				// determine if it meets the criteria of sending Email 
				IF NOT IsNull(ls_mailto) AND Len(Trim(ls_mailto)) > 0 THEN 
					IF date(ldt_last_notification_date) = date('1900-01-01') or isnull(ldt_last_notification_date) THEN
						lb_email_notificaiton = TRUE							
					ELSEIF (ll_total_tries_counter < ll_total_tries )   or isnull(ll_total_tries_counter) then 
						//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
						//Modified By Jay Chen 02-13-2014
						//if abs(inv_datetime.of_SecondsAfter(ldt_last_notification_date, ldtServerDate)) >= (ll_frequency * SECONDS_IN_A_DAY)  then 
						if abs(DaysAfter(date(ldt_last_notification_date), date(ldtServerDate))) >= ll_frequency   then
						//---------End Modfiied ------------------------------------------------------
							lb_email_notificaiton = TRUE 
						end if
					END IF
				END IF
						
				// determine if it meets the criteria of triggering workflow
				IF IsNull(ldt_last_wf_trigger) OR date(ldt_last_wf_trigger) = date('1900-01-01') THEN
					if gb_workflow and Not IsNull(ll_wf_id) and Not IsNull(ll_ctx_id) Then
						lb_wf_trigger = TRUE
					end if
				END IF			
				
			 END IF
	 END IF 
	 
	 //Set alarm flags
	IF lb_email_notificaiton THEN 
		adw.SetItem(ll_i, 'email_notification', 1)
		If ib_group_email Then of_group_generate_email(adw,ll_i) //Added By Ken.Guo 2010-08-09.
	End If
	IF lb_wf_trigger THEN adw.SetItem(ll_i, 'wf_trigger', 1)		

NEXT

//Filter unqualified alarms 
adw.SetFilter("email_notification = 1 OR wf_trigger = 1")
adw.Filter()


RETURN 1


end function

public subroutine of_parse_users (string as_maillist, ref string as_users[]);//Get users ids from a mail address list - Alfee 08.20.2008

Long ll_cnt, i, ll_found
String ls_mails[], ls_find, ls_user
n_cst_string lnv_string

ll_cnt = ids_users.RowCount()
IF ll_cnt < 1 THEN RETURN 
IF IsNull(as_maillist) OR Len(Trim(as_maillist)) < 1 THEN RETURN 

lnv_string.of_parsetoarray(Trim(as_maillist), ';', ls_mails )

FOR i = 1 to UpperBound(ls_mails)
	ls_find = 'Lower(Trim(email_id)) = "' + Lower(Trim(ls_mails[i])) + '"'
	ll_found = ids_users.Find(ls_find, 1, ll_cnt)
	IF ll_found > 0 THEN 
		ls_user = ids_users.GetItemString(ll_found, 'user_id')
		as_users[UpperBound(as_users) + 1] = ls_user
	END IF
NEXT



end subroutine

public function integer of_group_send_email ();//Send Group Email

n_cst_email_alarm lnv_email_alarm
lnv_email_alarm.istr_group_alarm[] = istr_group_alarm[]
Return lnv_email_alarm.of_group_send_email( )

end function

public function integer of_group_generate_email (n_ds ads_status, long al_row);Long i,j
String ls_emaillist,ls_mailto[],ls_sender
Boolean lb_exists
n_cst_string lnv_string

str_alarm lstr_alarm
ls_emaillist = ads_status.GetItemString(al_row,'alm_mailto')
lnv_string.of_parsetoarray( ls_emaillist, ';', ls_mailto[])
If of_get_alarm_setting( ads_status,al_row,lstr_alarm) < 0 Then Return -1

If is_sa_address <> '' Then
	ls_sender = is_sa_address
Else
	ls_sender = lstr_alarm.as_owner
End If

For i = 1 To UpperBound(ls_mailto[])
	lb_exists = False
	For j = 1 To UpperBound(istr_group_alarm[])
		If Trim(Upper(ls_mailto[i])) = Trim(Upper(istr_group_alarm[j].as_email_address)) and &
			Trim(Upper(ls_sender)) = Trim(Upper(istr_group_alarm[j].as_sender)) Then
				lb_exists = True
				Exit
		End If
	Next
	If lb_exists Then
		istr_group_alarm[j].astr_alarm[UpperBound(istr_group_alarm[j].astr_alarm[]) + 1] = lstr_alarm
	Else
		istr_group_alarm[ UpperBound(istr_group_alarm[]) + 1 ].as_email_address = Trim(ls_mailto[i])
		istr_group_alarm[ UpperBound(istr_group_alarm[]) ].as_sender = Trim(ls_sender)
		istr_group_alarm[ UpperBound(istr_group_alarm[]) ].astr_alarm[1] = lstr_alarm
	End If
Next


Return 1
end function

public function integer of_pre_send_email ();Integer i

//Initilize alarm info
FOR i = 1 TO 4
	If Not isvalid(ids_alm[i]) Then
		ids_alm[i] = Create n_ds
	End If
NEXT

//Added By Ken.Guo 2010-08-09.
If gnv_data.of_getitem( 'icred_settings', 'email_alarm_type', False) = '2' Then
	ib_group_email = True
	istr_group_alarm[] = istr_null[]
End If

ids_alm[1].dataobject = 'd_alm_status'
//ids_alm[2].dataobject = 'd_alm_status'
ids_alm[2].dataobject = 'd_alm_ai_status'
ids_alm[3].dataobject = 'd_alm_am_ai_status'
ids_alm[4].dataobject = 'd_alm_all_status' //add by jervis 06.28.2011


gnv_appeondb.of_startqueue( )
FOR i = 1 TO 4
	ids_alm[i].of_settransobject(SQLCA)	
   ids_alm[i].Retrieve()
NEXT

ids_users.Retrieve() //Get user-email list
ids_email_template.Retrieve()  //Get email template
ids_sec_users.Retrieve()

//Get current datetime
CHOOSE CASE gs_dbType 
	CASE 'ASA'
		select getdate() into :ldtServerDate from ids	using SQLCA; //(Appeon)Harry 06.27.2013 - V141 ISG-CLX
	CASE 'SQL'
		select getdate() into :ldtServerDate from ids using SQLCA;
END CHOOSE
Select set_addresser into :is_sa_address from  icred_settings; 

gnv_appeondb.of_commitqueue( )

//Added By Ken.Guo 2011-04-21.
gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ldtServerDate = ' + String(ldtServerDate))
gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm[1].RowCount() = ' + String(ids_alm[1].RowCount() ))
gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm[2].RowCount() = ' + String(ids_alm[2].RowCount() ))
gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm[3].RowCount() = ' + String(ids_alm[3].RowCount() ))
gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm[4].RowCount() = ' + String(ids_alm[4].RowCount() ))
//gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm[5].RowCount() = ' + String(ids_alm[5].RowCount() ))

//Ken.Guo 2010-08-12. Discard the invalid records
ids_alm[1].RowsDiscard(1, ids_alm[1].FilteredCount(), Filter!) 
ids_alm[2].RowsDiscard(1, ids_alm[2].FilteredCount(), Filter!) 
If isnull(is_sa_address) Then is_sa_address = ''

//Check and filter unqualified alarms first - for performance tuning on exporting data
FOR i = 1 to 4
	//is_alarm_from = is_alarm_from_list[i]	
	of_check_alarms(ids_alm[i])
	il_count +=ids_alm[i].RowCount()
	gnv_debug.of_output(False,This.ClassName() + '.of_pre_send_email(): ids_alm['+String(i)+'].rowcount() = '+ String(ids_alm[i].rowcount()) )
NEXT

//Get an export-contract list for all email notifications
of_get_exp_ctx(ids_alm)

Return il_count
end function

public subroutine of_group_update_counts ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_notification.of_group_update_counts()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Update Alarm's data.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-10 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i
If Not ib_group_email Then Return 

try

FOR i = 1 to 4  //jervis 06.28.2011
	//is_alarm_from = is_alarm_from_list[i]		
	ids_alm_status = ids_alm[i]
	
	of_send_mail( ids_alm_status ) //only update alarm's data, do not send email.

	If isvalid(ids_alm[i]) Then Destroy ids_alm[i]
NEXT

catch ( exception ex )
finally 
	If  IsValid( w_email_edit ) Then close( w_email_edit )//modified by gavins 20120821
	If  IsValid( w_email_edit_alarm ) Then close( w_email_edit_alarm )
end try
end subroutine

public function integer of_create_email_notification (str_alarm astr_alarm);/******************************************************************************************************************
**  [PUBLIC]   : of_create_email_notification( )
**==================================================================================================================
**  Purpose   	: sets up the email for sending 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long 		ll_i, ll_ctx_id, ll_doc_id, ll_seq_id, ll_action_item_id,ll_AttachCycle,ll_AttachCnts
string 	ls_doc_name, ls_attach_fullname, ls_Company
string 	ls_mailto[], ls_mailcc[], ls_Message, ls_SendUser, ls_subject,ls_AttachName[]
Blob 		lblb_message, lblb_attachment[]

n_cst_ctx_mail lnv_ctx_mail

//Initialize variables
ll_ctx_id = astr_alarm.ctx_id  //use astr_alarm replace astr_alarm - jervis 06.28.2011
ls_mailto[1] = astr_alarm.alm_mailto

//Get company name
SELECT facility_name 
  INTO :ls_Company 
  FROM app_facility,ctx_basic_info 
 WHERE ctx_basic_info.app_facility = app_facility.facility_id 
	AND ctx_basic_info.ctx_id = :ll_ctx_id;
	
if IsNull(ls_Company) or ls_Company = '' then
	ls_Company = 'Contract'
else
	ls_Company = WordCap(ls_Company) + " contract "
end if

SELECT ctx_contacts.user_d
  INTO :ls_SendUser
  FROM ctx_contract_contacts,ctx_contacts,app_facility
 WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )
   AND (ctx_contacts.facility_id = app_facility.facility_id)
	AND ( ctx_contract_contacts.ctx_id = :ll_ctx_id )
	AND ctx_contract_contacts.owner = 'Y'
	AND ctx_contract_contacts.ic_area = 'I';

//Generate Email subject
If Trim(astr_alarm.alm_subject) = '' or isnull(astr_alarm.alm_subject) Then //Added By Ken.Guo 2011-05-09. Added if Statement.
	//CHOOSE CASE Upper(is_alarm_from)
	CHOOSE CASE Upper(astr_alarm.alm_table) //jervis 06.28.2011
		CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
			ls_subject = ls_Company + String(ll_ctx_id) + ' requires your attention.'
		CASE 'CTX_ACTION_ITEM'
			ls_subject = 'The action item of Contract ' + String(ll_ctx_id) + ' requires your attention.'
		CASE 'CTX_AM_ACTION_ITEM'
			ls_doc_name = astr_alarm.doc_name
			ls_subject = 'The document "' + Trim(ls_doc_name) + '" of Contract ' + String(ll_ctx_id) + ' requires your attention.' 
		case else		//add by jervis 06.28.2011
			ls_subject = ls_Company + String(ll_ctx_id) + ' requires your attention.'
	END CHOOSE
	astr_alarm.alm_subject = ls_subject
End If

//Get message into blob
lnv_ctx_mail.of_get_message(astr_alarm.alm_table, astr_alarm, lblb_message )

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-23 By: Scofield
//$<Reason> Get attachment files.

lnv_ctx_mail.of_get_attachment(astr_alarm.alm_table, astr_alarm, ls_AttachName, lblb_attachment)

ll_AttachCnts = UpperBound(lblb_attachment)
if ll_AttachCnts > 0 then
	for ll_AttachCycle = 1 to ll_AttachCnts
		if Len(lblb_attachment[ll_AttachCycle]) > 0 then
			ls_attach_fullname += lnv_ctx_mail.of_write_attachfile(lblb_attachment[ll_AttachCycle],ls_AttachName[ll_AttachCycle]) + ","
		end if
	next

	ls_attach_fullname = Left(ls_attach_fullname,len(ls_attach_fullname) - 1)
end if

/*
//Get attachment into blob	
lnv_ctx_mail.of_get_attachment(is_alarm_from, astr_alarm, lblb_attachment )

//Write blob into a temporary file
IF Len(lblb_attachment) > 0 THEN 
	ls_attach_fullname = lnv_ctx_mail.of_write_attachfile(lblb_attachment, astr_alarm.alm_attachment_name)
END IF
*/

//---------------------------- APPEON END ----------------------------
If gnv_data.of_getitem( 'icred_settings', 'alarm_ways', False) = '1' Then //added by gavins 20120822
	if astr_alarm.autosign = 'N' then
		of_send_mail(ls_SendUser, ls_mailto, ls_mailcc, ls_subject, ls_attach_fullname, lblb_message,false,astr_alarm, '1' )  //add astr_alarm -- 06.28.2011
	else
		of_send_mail(ls_SendUser, ls_mailto, ls_mailcc, ls_subject, ls_attach_fullname, lblb_message,true,astr_alarm, '1' )
	end if
Else
	//Send mail
	//Auto Generate Email Signature By Jerivs 01.20.2009
	if astr_alarm.autosign = 'N' then
		of_send_mail(ls_SendUser, ls_mailto, ls_mailcc, ls_subject, ls_attach_fullname, lblb_message,false,astr_alarm)  //add astr_alarm -- 06.28.2011
	else
		of_send_mail(ls_SendUser, ls_mailto, ls_mailcc, ls_subject, ls_attach_fullname, lblb_message,true,astr_alarm)
	end if
	
End If

return 0

end function

public function integer of_update_action_items (string ls_action_type, str_alarm astr_alm);/******************************************************************************************************************
**  [PUBLIC]   : of_update_action_items( )
**  Purpose   	: 
**  Arguments 	: [string]  ls_action_type
**  Returns   	: [none]   
**  Notes     	: 	   
**  Created By	: Michael B. Skinner xx September 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date            Reason
** ------------------------------------------------------------------------------------------------------------------
**   mskinner              09 November 2005        added case 
**   mskinner				   23 November 2005        The letter case will not be called.
**	  Alfee.Shi					20 August 2008          Date alarm enhancement in v8.5               	
********************************************************************************************************************/
long ll_h, ll_row, ll_lookup_code, ll_rowcount, ll_foundrow, ll_action_type
Long ll_ctx_id, ll_ctx_action_item_id, ll_no_attempts
string ls_letter_name, ls_table, ls_column, ls_notes, ls_user_id
String ls_users[], ls_null[]
Long ll_complete,ll_incomplete,ll_action_status,ll_alm_count //Added by Ken.Guo on 2009-02-19
datetime ldt_due_date_new //Added by Ken.Guo on 2009-02-19
n_cst_string lnv_string
String ls_EmailID, ls_EmailList 
Long ll_Find 

ll_complete = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Complete')")) //Added by Ken.Guo on 2009-02-19
ll_incomplete = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('InComplete')")) //Added by Ken.Guo on 2009-02-19

Choose case upper(ls_action_type)
	case 'L' // letters
		     choose case lower(is_col_tab)
					  case 'ctx_basic_info_effective_date'
							 ls_letter_name = 'EffDtLtr'
						case 	'ctx_basic_info_other_date_2'
							 ls_letter_name = 'Cus2DtLtr'
						case 'ctx_basic_info_term_date'
							  ls_letter_name = 'TermDtLtr'
						case 'ctx_basic_info_review_date'
							  ls_letter_name = 'RevDtLtr'
						case 'ctx_basic_info_expriation_date'
							  ls_letter_name = 'ExpDtLtr'
						case 'ctx_basic_info_other_date_1'
							 ls_letter_name = 'CusDtLtr'
						case else
							//---------Begin Modified by (Appeon)Harry 06.27.2013 for V141 ISG-CLX--------
							//messagebox('Missing Case' , is_col_tab)
							//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
							inv_message.of_MessageBox('Missing Case' , is_col_tab,true)
							//---------End Modfiied ------------------------------------------------------
				end choose 
			
				if ll_foundrow > 0 then 			 
					ll_action_type = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('"+ls_letter_name+"')"))
					IF ll_action_type > 0 THEN
						 of_insert_action_item(ll_action_type, ids_action_type.GetitemNumber(ll_foundrow,'lookup_code'), '','Y',astr_alm)  //09.03.2007
					END IF
				end if 

	case 'E'// email notification
		
			//Added By Ken.Guo 2010-08-10.
			if  UPPER(ids_alm_status.object.create_action_item[ids_alm_status.getrow()]) <> 'Y' then 
				Return 0
			End If		
		
		  choose case lower(is_col_tab)
					  case 'ctx_basic_info_effective_date'
							 ls_letter_name = 'AlmEffDt'							 
						case 	'ctx_basic_info_other_date_2'
							 ls_letter_name = 'AlmCus2DT'							 
						case 'ctx_basic_info_term_date'
							  ls_letter_name = 'AlmTmDt'							  
						case 'ctx_basic_info_review_date'
							  ls_letter_name = 'AlmRevDt'							  
						case 'ctx_basic_info_expriation_date'
							  ls_letter_name = 'AlmExpDt'							  
						case 'ctx_basic_info_other_date_1'
								 ls_letter_name = 'AlmCusDt'								 
						//case 'ctx_basic_info_term_date'	//Commented by Ken.Guo on 2008-12-24. Reduplicate 'Case' condition.
						//	 ls_letter_name = 'AlmTermDt'
						Case 'ctx_basic_info_last_revis_date' //Added this case by Ken.Guo on 2008-12-30
								ls_letter_name = 'AlmLstRvDT'									
						case else
						      ls_letter_name = 'AutoMsg'
			end choose
			
			ll_action_type = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('"+ls_letter_name+"')"))
			IF ll_action_type > 0 THEN
				//Parse user list from mail addresses
				//of_parse_users(astr_alm.alm_mailto, ls_users)
				
				//of_parse_users(astr_alm.alm_create, ls_users) //10.12.2009 by jervis
				lnv_string.of_parsetoarray( astr_alm.alm_create,";",ls_users[]) //Modified By Ken.Guo 2010-03-02
				
				//Initialize variables
				ll_ctx_id = astr_alm.ctx_id
				ls_table = astr_alm.alm_table
				ls_column = astr_alm.alm_column
				ls_notes = astr_alm.alm_subject
				ls_EmailList = astr_alm.alm_mailto
				//Create action item for each user
				FOR ll_h = 1 TO UpperBound(ls_users)
					ls_user_id = ls_users[ll_h]
					ll_ctx_action_item_id = 0
					ll_no_attempts = 0
					
					//Added By Ken.Guo 03/20/2012. Create AI for only receiver
					ll_Find = ids_sec_users.find('trim(lower(user_id)) = "' + trim(lower(ls_user_id)) + '"',1,ids_sec_users.rowcount())
					If ll_Find <= 0 Then 
						Continue
					End If
					ls_EmailID = ids_sec_users.GetItemString(ll_Find, 'email_id')
					If IsNull(ls_EmailID) Or ls_EmailID = '' Or Pos(Lower(ls_EmailList), Lower(ls_EmailID)) = 0 Then 
						Continue
					End If
					
					//Add clause - jervis 06.29.2011
					/*
					SELECT ctx_action_item_id, no_attempts, action_status INTO :ll_ctx_action_item_id, :ll_no_attempts, :ll_action_status
					  FROM ctx_action_items 
					 WHERE ctx_id = :ll_ctx_id AND action_user = :ls_user_id 
					 	AND alm_table = :ls_table AND alm_column = :ls_column ;
					*/
					SELECT ctx_action_item_id, no_attempts, action_status INTO :ll_ctx_action_item_id, :ll_no_attempts, :ll_action_status
					  FROM ctx_action_items 
					 WHERE ctx_id = :ll_ctx_id AND action_user = :ls_user_id 
					 	AND alm_table = :ls_table AND alm_column = :ls_column  and 
						 		doc_id = :astr_alm.doc_id and level_id1 = :astr_alm.level_id1 and level_id2 = :astr_alm.level_id2 ;
						 
					IF Isnull(ll_ctx_action_item_id) OR ll_ctx_action_item_id = 0 THEN							
						of_insert_action_item(ll_ctx_id,ll_action_type,ls_user_id,'N', astr_alm) //add astr_alm - jervis 06.29.2011 
					ELSE
						IF Isnull(ll_no_attempts) THEN ll_no_attempts = 0
						ll_no_attempts ++
						//--------------------------- APPEON BEGIN ---------------------------
						//$<modify> 02.19.2009 By: Ken.Guo
						//$<reason> If the old action items status is complete and the notification has been auto-snooze, 
						//$<reason> Then replace it with incomplete and reset attempts.
						/*
						Update ctx_action_items
						   Set no_attempts = :ll_no_attempts, last_attempt = :ldtServerDate
						 Where ctx_id = :ll_ctx_id AND action_user = :ls_user_id AND action_type = :ll_action_type AND ctx_action_item_id = :ll_ctx_action_item_id;
						 */
						
						
						choose case lower(ls_table)
							case 'ctx_basic_info','ctx_custom'
								Select alm_total_tries_counter Into :ll_alm_count 
								From CTX_NOTIFICATION 
								Where	ctx_id = :ll_ctx_id And alm_table = :ls_table and alm_column = :ls_column;
							case 'ctx_custom_multi_hdr,ctx_custom_multi_detail'
								Select alm_total_tries_counter Into :ll_alm_count 
								From CTX_all_NOTIFICATION 
								Where	ctx_id = :ll_ctx_id And alm_table = :ls_table and alm_column = :ls_column and 
										doc_id = :astr_alm.doc_id and level_id1 = :astr_alm.level_id1 and level_id2= :astr_alm.level_id2;
						end choose
								
						If isnull(ll_alm_count) Then ll_alm_count = 0
						
						If ll_action_status = ll_complete and ll_alm_count = 0 Then
							//If notification has been Auto-Snooze, Reset it. 
							choose case lower(ls_table)
								case 'ctx_basic_info','ctx_action_item','ctx_am_action_item'
									ldt_due_date_new = ids_alm_status.GetItemDateTime(ids_alm_status.GetRow(), ls_column)
								//case 'ctx_custom','ctx_custom_multi_hdr','ctx_custom_multi_detail'
								case else //add fee scheduce - jervis 08.02.2011
									ldt_due_date_new = ids_alm_status.GetItemDateTime(ids_alm_status.GetRow(), 'alm_date') //jervis 07.05.2011
							end choose
							
							Update ctx_action_items Set 
								action_type = :ll_action_type,
								action_status = :ll_incomplete,							
								due_date = :ldt_due_date_new,
								no_attempts = 1,
								first_attempt = :ldtServerDate,
								last_attempt = :ldtServerDate
							Where ctx_id = :ll_ctx_id AND ctx_action_item_id = :ll_ctx_action_item_id;														
						Else
							//Update NOTIFICATION 
							Update ctx_action_items
								Set no_attempts = :ll_no_attempts, last_attempt = :ldtServerDate
							 Where ctx_id = :ll_ctx_id AND action_user = :ls_user_id AND action_type = :ll_action_type AND ctx_action_item_id = :ll_ctx_action_item_id;															
						End If
						//---------------------------- APPEON END ----------------------------
					END IF				
				NEXT
			END IF		
			
end choose 

//Update to DB
IF lds_action_items.Modifiedcount( ) + lds_action_items.deletedcount( ) > 0 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2009-11-04 By: Ken.Guo
	//$<reason> Workaround APB bug, Failed to execute AcceptText(), why?
	//Second Workaround Way: Set action_type column's tab order = 0 for d_cntx_action_items.
	//lds_action_items.update()
	If lds_action_items.update(False,True) <> 1 Then
		Messagebox('Notification','Failed to insert the action items.')
	End If
	//---------------------------- APPEON END ----------------------------
END IF

return 0 
end function

public function integer of_replace_merge_fields (oleobject ole_word, ref str_alarm astr_alm);//Replace merge fields in current message - Alfee 06.11.2008

Long ll_found, i, ll_cnt, ll_current_row, ll_exportid, ll_ctx_ids[],ll_ret
String ls_subject
Boolean ib_new_export = TRUE
n_cst_word_utility lnv_word

//Return if no template or export id defined
IF NOT astr_alm.alm_email_template_id > 0 THEN RETURN 0

ll_found = ids_email_template.Find('email_id = ' + String(astr_alm.alm_email_template_id), 1, ids_email_template.RowCount())
IF ll_found > 0 THEN ll_exportid = ids_email_template.GetItemNumber(ll_found, 'export_id')	
IF IsNull(ll_exportid) or ll_exportid < 1 THEN RETURN 0

//Determine if a new export is needed 
ll_cnt = UpperBound(istr_exp)
FOR i = 1 to ll_cnt
	IF istr_exp[i].export_id = ll_exportid THEN 
		ib_new_export = FALSE
		ll_current_row = i
		EXIT
	END IF
NEXT
IF ib_new_export THEN  
	istr_exp[ll_cnt + 1].export_id = ll_exportid
	istr_exp[ll_cnt + 1].ds_export = Create DataStore
	ll_current_row = ll_cnt + 1	
	//Get ctx ids related to the export id
	ids_export_ctx.SetFilter('export_id = ' + String(ll_exportid))
	ids_export_ctx.Filter()
	FOR i = 1 to ids_export_ctx.RowCount()
		ll_ctx_ids[UpperBound(ll_ctx_ids) + 1] = ids_export_ctx.GetItemNumber(i, 'ctx_id')
	NEXT
END IF

//Added By Ken.Guo 2009-12-14. Use email template's subject.
ls_subject = ids_email_template.GetItemString(ll_found,'subject')
If (Not isnull(ls_subject) and Trim(ls_subject) <> '') and (Trim(astr_alm.alm_subject) = '' or isnull(astr_alm.alm_subject)) Then //Modified By Ken.Guo 2011-04-21
	astr_alm.alm_subject = ls_subject
End If

//Replace merge fields accordingly
lnv_word = Create n_cst_word_utility

//Added By Ken.Guo 2010-03-08. for web link '$<Web Link To Document Tab(Open Document)>$'
lnv_word.il_doc_id = astr_alm.doc_id 

//Add Replace Subject-- jervis 09.09.2009
//lnv_word.of_replace_export_word(ole_word, astr_alm.ctx_id, ll_exportid, istr_exp[ll_current_row].ds_export, ib_new_export, ll_ctx_ids )

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
lnv_word.ib_email = True//added by gavins 20130529
//---------End Added ------------------------------------------------------
ll_ret = lnv_word.of_replace_export_word(ole_word, astr_alm.alm_subject, astr_alm.ctx_id, ll_exportid, istr_exp[ll_current_row].ds_export, ib_new_export, ll_ctx_ids )
If ll_ret < 0 Then
	gnv_debug.of_output(true, 'Alarm Replace Export:' + String(ll_ret) +'~r~n' + &
					'ExportID: ' + String(ll_exportid) + ', Subject:'+astr_alm.alm_subject + ', CTX:' +  String(astr_alm.ctx_id) +', Table:'+ astr_alm.alm_table + ', Column:'+ astr_alm.alm_column )
	Destroy lnv_word
	//retry  //added by gavins 20120912
	lnv_word = Create n_cst_word_utility
	//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	lnv_word.ib_email = True//added by gavins 20130529
	//---------End Added ------------------------------------------------------
	ll_ret = lnv_word.of_replace_export_word(ole_word, astr_alm.alm_subject, astr_alm.ctx_id, ll_exportid, istr_exp[ll_current_row].ds_export, ib_new_export, ll_ctx_ids )
	If ll_ret < 0 Then
		Destroy lnv_word
		Return ll_ret								
	Else
	End If
					
End If

Destroy lnv_word

RETURN 1
end function

public function long of_send_mail (string as_sender, string as_mailto[], string as_mailcc[], string as_subject, string as_attachment, blob ablb_message, boolean ab_autosign, str_alarm astr_alm);Return of_Send_mail( as_sender, as_mailto, as_mailcc, as_subject, as_attachment, ablb_message, ab_autosign, astr_alm, '0' ) //modified by gavins 20120822

/*
//Send mail with richtext message - Created by Alfee on 06.11.2008
long		ll_Return,ll_Cycle, ll_found, ll_exportid,ll_opened = 1
String	ls_Mail_To, ls_Mail_CC
String	ls_Addresser,ls_err_text
n_cst_word_utility lnv_word
n_cst_easymail_smtp 	lnv_Mail
str_email_info lstr_email_info

String ls_alarm_type
Integer li_send_result = 0,li_merge_result = 0

If as_sender = '' or isnull(as_sender) Then as_sender = gs_user_id //Added By Ken.Guo 2011-04-21.

//Assign Email setting
for ll_Cycle = 1 to UpperBound(as_mailto)
	ls_Mail_To += as_mailto[ll_Cycle] + ";"
next
ls_mail_to = Mid(ls_mail_to, 1, Len(ls_mail_to) - 1)

for ll_Cycle = 1 to UpperBound(as_mailcc)
	ls_Mail_CC += as_mailcc[ll_Cycle] + ";"
next
ls_Mail_CC = Mid(ls_Mail_CC, 1, Len(ls_Mail_CC) - 1)

select top 1 set_addresser into :ls_Addresser from icred_settings;
if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = as_sender
end if

//Create Email object
if lnv_Mail.of_CreateObject() = -1 then
	f_show_message('create Email object','','','','')
	Return -1
end if

//Open message and replace merge fields
//Open(w_email_edit)
If Not IsValid( w_email_edit ) Then Open( w_email_edit )//modified by gavins 20120821

long ll_ret 
ll_ret = w_email_edit.ole_word.of_Open_Buffer(ablb_message)
//If Not IsNull( ablb_message ) Then
//	w_email_edit.ole_word.object.data = ablb_message
//	ll_ret = 1
//Else
//	If IsValid( w_email_edit.ole_word.Object )  Then w_email_edit.ole_word.of_Close()
//	ll_ret =  w_email_edit.ole_word.of_Open('')
//End If//added by gavins 20120821

If ll_ret < 0 Then 
	ls_err_text = 'Failed to open the email alarm message. ll_err = ' + String(ll_ret)
	gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')
	ll_opened = -1
Else
	IF w_email_edit.ole_word.object.doctype = 1 THEN //w_email_edit modified by gavins 20120821
		li_merge_result = of_replace_merge_fields(w_email_edit.ole_word.Object.ActiveDocument,astr_alm)
		If li_merge_result < 0 Then
			ls_err_text = 'Failed to merge email fields. merge result = ' + String(li_merge_result) 
			gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')	
			ll_opened = -11 		
			//added by gavins 20120821
			w_email_edit.ole_word.of_Close()
			If IsValid( w_email_edit.ole_word ) Then Destroy( w_email_edit.ole_word )
			If  IsValid( w_email_edit ) Then close( w_email_edit )
			ib_SendStatus = true
		End If
	
	Else
		ls_err_text = 'Failed to open the email alarm message. doctype <> 1. ' 
		gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')
		ll_opened = -2
	END IF	
End If


//Added By Ken.Guo 2009-05-22.
long ll_ai_id
//CHOOSE CASE Upper(is_alarm_from)
CHOOSE CASE Upper(astr_alm.alm_table) //jervis 06.28.2011
	CASE 'CTX_BASIC_INFO'
		ls_alarm_type = 'Contract Details Date Alarm'
	CASE 'CTX_ACTION_ITEM'
		ls_alarm_type = 'Contract Action Item Due Date Alarm'
		ll_ai_id = astr_alm.ai_id
	CASE 'CTX_AM_ACTION_ITEM'
		ls_alarm_type = 'Document Action Item Due Date Alarm'
		ll_ai_id = astr_alm.seq_id
	//Add custom - jervis 06.29.2011
	case 'CTX_CUSTOM' 
		ls_alarm_type = 'Contract Custom data Date Alarm'
	case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'
		ls_alarm_type = 'Contract Mulit Custom Data Date Alarm'
	case 'CTX_FEE_SCHED_NM'
		ls_alarm_type = 'Contract Fee Scheduce NM Date Alarm'
End Choose


//Send Email
If ll_opened > 0 Then
	ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_Mail_To, ls_Mail_CC, '',astr_alm.alm_subject , w_email_edit.ole_Word, as_attachment, ab_autosign,astr_alm.ctx_id,astr_alm.doc_id,ll_ai_id  ) //Modified By Ken.Guo 2009-12-14. Use email template's subject.
Else
	ll_Return = -1
End If

//Restore current directory
If DirectoryExists(Gs_Current_Directory) Then ChangeDirectory(Gs_Current_Directory)

//Close window, destroy Email object & temporary file
If  IsValid( w_email_edit ) Then w_email_edit.ole_word.of_Close()//modified by gavins 20120821
If  IsValid( w_email_edit ) Then Close(w_email_edit)

lnv_Mail.of_DeleteObject()
if FileExists(as_attachment) then FileDelete (as_attachment )

//Added Log info
if ll_Return <> 0 then
	//gstr_email_info.ss_email_from = is_alarm_from + '_alarm'
	gstr_email_info.ss_email_from = astr_alm.alm_table + '_alarm'
	gstr_email_info.sl_ctx_id = astr_alm.ctx_id
	gstr_email_info.ss_column_name = astr_alm.alm_column
	gstr_email_info.sl_action_id = astr_alm.ai_id
	gstr_email_info.sl_doc_id = astr_alm.doc_id
	gstr_email_info.sl_wf_id = astr_alm.wf_id
	If ll_opened > 0 Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	End If
	gstr_email_info = lstr_email_info
	li_send_result = -1
	//Return -1
end if

//Added By Ken.Guo 2010-11-15. Email Audit
String ls_errtext,ls_attachfilename,ls_columnname,ls_computer_info
n_cst_string lnv_string
If ll_Return <> 0 then 
	ls_errtext = gnv_message.of_get_error_message( ll_Return)
End If
ls_attachfilename = lnv_string.of_get_file_name( as_attachment, ',') 

If astr_alm.as_column_name <> '' and not isnull(astr_alm.as_column_name) Then
	ls_columnname = astr_alm.as_column_name +' ('+ astr_alm.alm_column + ')'
Else
	ls_columnname = astr_alm.alm_column
End If
ls_computer_info = lnv_Mail.of_get_compute_info( )

//Using open error info
If ll_Return = -1 and ll_opened < 0 Then
	ls_errtext = ls_err_text
End If

//truncate subject string if it too long
String ls_subject 
ls_subject = astr_alm.alm_subject
If Len(ls_subject) > 500 Then ls_subject = Mid(ls_subject, 1, 490) + '...'

//Insert to audit table
Insert Into em_mail_audit
(user_id,mail_from,mail_to,mail_cc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,compute_info)
Values 
(:gs_user_id,:ls_Addresser,:ls_Mail_To,:ls_Mail_CC,:ls_subject,getdate(),:ls_attachfilename,:astr_alm.alm_email_template_id,:astr_alm.ctx_id,:astr_alm.doc_id,:astr_alm.ai_id,:astr_alm.wf_id,:ls_alarm_type,:ls_columnname,:li_send_result,:ls_errtext,:ls_computer_info);

gstr_email_info = lstr_email_info //Added By Ken.Guo 2009-10-13.

if ll_Return <> 0 then Return -1

//Update alarm counters
of_update_counters(astr_alm) //jervis 06.28.2011

Return 1
*/
end function

public function integer of_update_counters (str_alarm astr_alm);/******************************************************************************************************************
**  [PUBLIC]   : of_update_counters
**  Purpose   	: 
**  Arguments 	: [none] 
**  Returns   	: [none]   
**  Notes     	: 	   
**  Created By	: Michael B. Skinner 14 October 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**  Changed By : Alfee.Shi  Change Date: 08.20.2008  Reason: Date Alarm Enhancement on notification users in V8.5
********************************************************************************************************************/
long ll_i 
long ll_rowcount
long ll_counter, ll_total_tries

ldtServerDate = f_get_server_dtm()
ll_i = ids_alm_status.GetRow()

ids_alm_status.setitem(ll_i,'alm_last_notification_sent', ldtServerDate)
ll_counter = ids_alm_status.GetItemNumber(ll_i,'alm_total_tries_counter')
ll_total_tries = ids_alm_status.GetItemNumber(ll_i,'alm_total_tries')

if isnull(ll_counter) then ll_counter = 0
if isnull(ll_total_tries) then ll_total_tries = 0

ids_alm_status.setitem(ll_i,'alm_total_tries_counter', 1+ ll_counter )
  
ib_need_update = TRUE

//Modified By Ken.Guo 2011-03-01
If UPPER(ids_alm_status.object.create_action_item[ids_alm_status.getrow()]) <> 'Y' Then
	ib_inserted_action_item = False
Else
	ib_inserted_action_item = True
End If

//IF (Upper(astr_alm.alm_table) = 'CTX_BASIC_INFO' or Upper(astr_alm.alm_table) = 'CTX_CUSTOM') THEN  //ADD CTX_CUSTOM - jervis 05.19.2011
//user astr_alarm, Add ctx_custom_multi_detail and ctx_custom_multi_hdr - jervis 06.28.2011
IF (Upper(astr_alm.alm_table) = 'CTX_BASIC_INFO' or lower(astr_alm.alm_table) = 'ctx_custom_multi_detail' or lower(astr_alm.alm_table) = 'ctx_custom_multi_hdr' or Upper(astr_alm.alm_table) = 'CTX_CUSTOM' or lower(astr_alm.alm_table) = 'ctx_fee_sched_nm')  THEN 
	of_update_action_items('E',astr_alm)  //add astr_alm - jervis 06.28.2011
end if


//Added By Ken.Guo 2009-09-11. Update Auto-Snooze yet if Not create action item.
long ll_ctx_id_arr[]
string ls_table_arr[],ls_column_arr[]
long ll_doc_id_arr[],ll_level_id1_arr[],ll_level_id2_arr[]  //jervis 06.30.2011
//If (lower(astr_alm.alm_table) = 'ctx_basic_info' or lower(astr_alm.alm_table) = 'ctx_custom') and ib_inserted_action_item = False and ll_counter = 0 Then
//If it is last email and action item is unchecked, then trigger Auto-Snooze.
If (lower(astr_alm.alm_table) = 'ctx_basic_info' or lower(astr_alm.alm_table) = 'ctx_custom' or lower(astr_alm.alm_table) = 'ctx_custom_multi_detail' or lower(astr_alm.alm_table) = 'ctx_custom_multi_hdr' or lower(astr_alm.alm_table) = 'ctx_fee_sched_nm') and ib_inserted_action_item = False and ll_total_tries = ll_counter + 1 Then
	ll_ctx_id_arr[1] = astr_alm.ctx_id
	ls_table_arr[1] = astr_alm.alm_table
	ls_column_arr[1] = astr_alm.alm_column
	if (lower(astr_alm.alm_table) = 'ctx_basic_info' or lower(astr_alm.alm_table) = 'ctx_custom') then
		This.of_update_ctx_notification( ll_ctx_id_arr[], ls_table_arr[], ls_column_arr[])
	else //add custom multi data - jervis 06.30.2011
		ll_doc_id_arr[1] = astr_alm.doc_id
		ll_level_id1_arr[1] = astr_alm.level_id1
		ll_level_id2_arr[1] = astr_alm.level_id2
		This.of_update_ctx_notification( ll_ctx_id_arr[], ls_table_arr[], ls_column_arr[],ll_doc_id_arr[],ll_level_id1_arr[],ll_level_id2_arr[])
	end if
	If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.tabpage_search.il_ctx_id = astr_alm.ctx_id and gw_contract.tab_contract_details.selectedtab = 2 Then
			gw_contract.SetRedraw(False)
			gw_contract.tab_contract_details.event selectionchanged( 2, 2)
			gw_contract.SetRedraw(True)
		End IF
	End If
End If

return 0
end function

public function long of_send_mail (n_ds adw);
//Prepare notifcation - Alfee 08.20.2008

Long ll_i, ll_ctx_id, ll_action_item_id, ll_doc_id, ll_seq_id, ll_wf_id 
String ls_table, ls_column, ls_filter_string 
str_alarm lstr_alm //add by jervis 06.28.2011

str_action_item lstr_action
n_cst_workflow_triggers lnv_triggers

lnv_triggers = create n_cst_workflow_triggers
lnv_triggers.of_set_message( false) //01.08.2009 By Jervis

inv_message.of_set_proc_cnt(adw.rowcount(), true) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality  //(Appeon)Harry 06.27.2013 - V141 ISG-CLX

for ll_i = 1 to adw.rowcount( )  //all of the alarms
	Yield() //Added By Ken.Guo 2010-11-25.
	//keep current alarm setting in structure 
	 of_get_alarm_setting(adw, ll_i, lstr_alm) 

	//For update action items
	 is_col_tab = lstr_alm.alm_table + '_' + lstr_alm.alm_column  //Added by Ken.Guo on 2008-12-24.
	 
	 //Set current row -  for of_update_counters()
	 adw.SetRow(ll_i) 

	 //Prepare email notification
	 IF adw.getItemNumber(ll_i, 'email_notification') = 1 THEN
		If ib_group_email Then
			il_index++
			gnv_status_info.of_display( "["+String(Long(il_index / il_count*100)) + "%]" + " Start Email Notification, Updating Counters" + ", please wait..." )
			This.of_update_counters(lstr_alm)  //Add parm lstr_alm - jervis 06.28.2011
		Else
			il_index++
			gnv_status_info.of_display( "["+String(Long(il_index / il_count*100)) + "%]" + " Start Email Notification, Sending Email" + ", please wait..." )
			IF IsValid(w_wait) THEN w_wait.hpb_1.StepIt()
			of_create_email_notification(lstr_alm)  //Add parm lstr_alm - jervis 06.28.2011
		End If
	 END IF
	 
	 //Prepare workflow triggering
	 //IF adw.getItemNumber(ll_i, 'wf_trigger') = 1 THEN
	 IF adw.getItemNumber(ll_i, 'wf_trigger') = 1 and gb_workflow THEN //01.08.2009 By Jervis
		lstr_action.ctx_id = lstr_alm.ctx_id
		lstr_action.wf_id = lstr_alm.wf_id
							
		
		IF lnv_triggers.of_workflow_create_action_items(lstr_action) = 1 THEN
			adw.SetItem(ll_i, 'alm_last_wf_trigger', ldtServerDate) 
			ib_need_update = TRUE
		END IF
		//---------Begin Modified by (Appeon)Harry 06.27.2013 for V141 ISG-CLX--------
		if gb_autoschedule or ib_schedule then //scheduler - alfee 03.11.2010
			string ls_msg
			ls_msg = lnv_triggers.of_get_sched_msg( )
			if LenA(ls_msg) > 0 then inv_message.of_messagebox("", ls_msg, true)	
		end if
		//---------End Modfiied ------------------------------------------------------
	 END IF		

	//update last sent and tries counter. move to here from bottom. after send a email then save a result.
	IF ib_need_update THEN 
		ib_need_update = False		
		If adw.update(False,True) <> 1 Then //Modified By Ken.Guo 2010-01-07
			adw.resetupdate()
			Messagebox('Notification','Failed to update the Date Alarm Status, please call support.~r~n' + sqlca.sqlerrtext )
			Continue
		End If	
	END IF

next

/*
//update last sent and tries counter
IF ib_need_update THEN 
	//adw.Update()
	If adw.update(False,True) <> 1 Then //Modified By Ken.Guo 2010-01-07
		Messagebox('Notification','Failed to update the Date Alarm Status, please call support.~r~n' + sqlca.sqlerrtext )
		Return -1
	End If	
	ib_need_update = FALSE
END IF
*/

destroy lnv_triggers

return 0


end function

public function integer of_insert_action_item (long al_ctx_id, long al_lookup_code, string as_user_id, string as_letter_flag, str_alarm astr_alm);
/******************************************************************************************************************
**  [PUBLIC]   : of_insert_action_item( /*long al_ctx_id*/, /*long al_lookup_code*/, /*string as_user_id */)
**==================================================================================================================
**  Purpose   	: Insert records into the action items table
**==================================================================================================================
**  Arguments 	: [long]    al_ctx_id, al_lookup_code
**             : [string]  as_user_id, as_letter_flag, as_table, as_column, as_notes
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_row

// only create the action item if checked!!
long ll_ctx_id_arr[]
string ls_table_arr[],ls_column_arr[]
if  UPPER(ids_alm_status.object.create_action_item[ids_alm_status.getrow()]) <> 'Y' then 
	Return 0
End If

ll_row = lds_action_items.insertrow(1)
lds_action_items.setitem(ll_row,'ctx_id' ,al_ctx_id )
lds_action_items.setitem(ll_row,'action_type' ,al_lookup_code  )
if f_validstr(as_user_id) then 
   lds_action_items.setitem(ll_row,'action_user' ,as_user_id)
end if 
if f_validstr(as_letter_flag) then 
   lds_action_items.setitem(ll_row,'letter_flag' ,as_letter_flag)
end if 
lds_action_items.setitem(ll_row,'first_attempt' ,date(ldtServerDate))
lds_action_items.setitem(ll_row,'last_attempt' ,date(ldtServerDate))
lds_action_items.setitem(ll_row,'no_attempts' ,1)
//----------Begin Added by Alfee 07.27.2007 ---------------------------
lds_action_items.setitem(ll_row,'alm_table', astr_alm.alm_table)
lds_action_items.setitem(ll_row,'alm_column', astr_alm.alm_column)
lds_action_items.setitem(ll_row,'notes', astr_alm.as_notes ) //09.03.2007
//----------End Added -------------------------------------------------
//add other id key -- jervis 06.29.2011
lds_action_items.setitem(ll_row,'doc_id', astr_alm.doc_id)
lds_action_items.setitem(ll_row,'level_id1', astr_alm.level_id1 ) 
lds_action_items.setitem(ll_row,'level_id2', astr_alm.level_id2 ) 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.20.2006 By: LeiWei
//$<reason> Implement new requirement.

// Set Due Date from the Contract Dates field that generated the alarm.
String ls_column
Datetime LD_DATE
//---------Begin Modified by Alfee on 04.11.2008----------
Long ll_i
ll_i = ids_alm_status.GetRow()
IF ll_i > 0 THEN
	ls_column = ids_alm_status.getItemString(ll_i, 'alm_column')
	choose case lower(astr_alm.alm_table)
		case 'ctx_basic_info','ctx_action_item','ctx_am_action_item'
			LD_DATE = ids_alm_status.GetItemDateTime(ll_i, ls_column)
		//case 'ctx_custom','ctx_custom_multi_hdr','ctx_custom_multi_detail'  //jervis 07.05.2011
		case else //add fee scheduce - jervis 08.02.2011
			LD_DATE = ids_alm_status.GetItemDateTime(ll_i, 'alm_date')
	end choose
	lds_action_items.setitem(ll_row,'due_date', LD_DATE)
END IF
/* IF ids_alm_status.Rowcount( ) = 1 THEN
	ls_column = ids_alm_status.getItemString(1, 'alm_column')
	LD_DATE = ids_alm_status.GetItemDateTime(1, ls_column)
	lds_action_items.setitem(ll_row,'due_date', LD_DATE)
END IF */
//---------End Modified -----------------------------------

// Set default action_status is 'InComplete'.
Long ll_action_status
ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('InComplete')"))
IF ll_action_status > 0 THEN lds_action_items.setitem(ll_row,'action_status' ,ll_action_status)

// Set today's date to aciton_date.
lds_action_items.setitem(ll_row,'action_date', Datetime(today()))

//---------------------------- APPEON END ----------------------------

ib_inserted_action_item = True //Added By Ken.Guo 2009-09-11.

return 0
end function

public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[], long al_docid[], long al_level_id1[], long al_level_id2[]);
//Update the CTX notification parms while the action items' changed to be complete status
//Added by Alfee 07.27.2007
Long i, j, ll_c, ll_t, ll_cnt, ll_cnt_years, ll_found
Long ll_delay, ll_ctx[] //Repace ll_years with ll_deplay - Alfee 02.22.2008
String ls_table[], ls_sql, ls_tabname, ls_colname, ls_criteria, ls_unit
Boolean lb_ctx_duplicate, lb_tab_duplicate
integer li_loop
Long n,ll_row,ll_next_snooze_value = -1,ll_i
String ls_next_snooze_unit
Datetime ldt_null
Long ll_null

SetNUll(ldt_null)
SetNUll(ll_null)
datastore lds_notification_years,lds_snooze

ll_cnt = UpperBound(as_column) 
IF ll_cnt < 1 THEN RETURN 0
IF Len(Trim(as_column[1])) < 1 THEN RETURN 0

lds_snooze = Create datastore
lds_notification_years = Create datastore


lds_notification_years.dataobject = 'd_alarm_all_notification_years'
lds_notification_years.SetTransObject(SQLCA)


lds_snooze.dataobject = 'd_ctx_alm_snooze_arr'
lds_snooze.SetTransObject(SQLCA)
lds_snooze.Retrieve(al_ctxid[],as_table[],as_column[],al_docid[],al_level_id1[],al_level_id2[]) //add level id - jervis 06.30.2011

//Get distinct ctx ids & table names
ll_c = 1
ll_t = 1
FOR i = 1 to ll_cnt
	IF i > 1 THEN 
		lb_ctx_duplicate = FALSE
		lb_tab_duplicate = FALSE
		FOR j = 1 to UpperBound(ll_ctx)
			IF ll_ctx[j] = al_ctxid[i] THEN 
				lb_ctx_duplicate = TRUE
				EXIT //Skip duplicated ctx id	
			END IF
		NEXT		
		FOR j = 1 to UpperBound(ls_table)
			IF ls_table[j] = as_table[i] THEN 
				lb_tab_duplicate = TRUE
				EXIT //Skip duplicated table name
			END IF
		NEXT
		IF Not lb_ctx_duplicate THEN 
			ll_ctx[ll_c] = al_ctxid[i]
			ll_c ++
		END IF
		IF Not lb_tab_duplicate THEN 
			ls_table[ll_t] = as_table[i]
			ll_t ++
		END IF			
	ELSE
		ll_ctx[ll_c] = al_ctxid[1]
		ls_table[ll_t] = as_table[1]
		ll_c ++
		ll_t ++		
	END IF	
NEXT

//Get all relative auto increment years
ll_cnt_years = lds_notification_years.Retrieve(ll_ctx[], ls_table[], as_column[],al_docid[],al_level_id1[],al_level_id2[]) //add level id - jervis 06.30.2011

IF ll_cnt_years < 1 THEN 
	If isvalid(lds_notification_years) Then Destroy lds_notification_years
	RETURN 0
End If

//Update alarm notification parameters
FOR i = 1 to ll_cnt
	IF IsNull(as_table[i]) or Len(Trim(as_table[i])) < 1 THEN Continue
	IF IsNull(as_column[i]) or Len(Trim(as_column[i])) < 1 THEN Continue
	if isnull(al_docid[i]) then continue
	if isnull(al_level_id1[i]) then continue
	if isnull(al_level_id2[i]) then continue

	ls_criteria  = "ctx_id = " + String(al_ctxid[i]) + " And alm_table = ' " 
	ls_criteria += as_table[i] + "' And alm_column = '" + as_column[i] + "' " 
	ls_criteria += " And doc_id = " + string(al_docid[i]) 
	ls_criteria += " And level_id1 = " + string(al_level_id1[i])
	ls_criteria += " And level_id2 = " + string(al_level_id2[i])
	ll_found = lds_notification_years.Find(ls_criteria, 1, ll_cnt_years)
	IF ll_found < 1 THEN Continue
	
	ll_delay = lds_notification_years.GetItemNumber(ll_found, 'alm_auto_increment_years')
	//----------------Begin Added by Alfee 02.22.2008-----------------------------------
	IF IsNull(ll_delay) or ll_delay <= 0 THEN Continue

	ls_unit = lds_notification_years.GetItemString(ll_found, 'alm_auto_increment_unit')
	IF Upper(ls_unit) = 'M' THEN 
		ls_unit = 'Month'
	ELSEIF Upper(ls_unit) = 'D' THEN
		ls_unit = 'Day'
	ELSE
		ls_UNIT = 'Year'
	END IF
	//----------------End Added --------------------------------------------------------
	
	ls_sql += "Update " + as_table[i] 
	//ls_sql += "   Set " + as_column[i] + " = DateAdd(year, " + String(ll_delay) + ", " + as_column[i] + ") "  
	ls_sql += "   Set " + as_column[i] + " = DateAdd(" + ls_unit + ", " + String(ll_delay) + ", " + as_column[i] + ") "  //Alfee 02.22.2008	
	ls_sql += " Where " + as_table[i] + ".ctx_id = " + String(al_ctxid[i]) + " "
	choose case lower(as_table[i] )
		case 'ctx_custom_multi_hdr'
			ls_sql += " and " + as_table[i] + ".hdr_id = " + String(al_level_id1[i]) + "; ~r~n"
			ls_sql += "Update ctx_all_notification" 
		case 'ctx_custom_multi_detail'
			ls_sql += " and " + as_table[i] + ".hdr_id = " + String(al_level_id1[i]) 
			ls_sql += " and " + as_table[i] + ".detail_id = " + String(al_level_id2[i]) + "; ~r~n"
			ls_sql += "Update ctx_all_notification" 
		case 'ctx_fee_sched_nm'  //jervis 08.02.2011
			ls_sql += " and " + as_table[i] + ".fee_sched_nm_id = " + String(al_level_id1[i]) + "; ~r~n"
			ls_sql += "Update ctx_all_notification" 
			
	end choose 
			

	//ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null" 
	ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null, alm_last_wf_trigger = Null " 	
	//ls_sql += "   ,alm_date == DateAdd(" + ls_unit + ", " + String(ll_delay) 	+ ", alm_date) "
	ls_sql += " Where ctx_id = " + String(al_ctxid[i]) 
	ls_sql += "   AND alm_table = '" + as_table[i] + "' AND alm_column = '" + as_column[i] + "' "
	ls_sql += " And doc_id = " + string(al_docid[i]) 
	ls_sql += " And level_id1 = " + string(al_level_id1[i])
	ls_sql += " And level_id2 = " + string(al_level_id2[i]) + "; ~r~n"
	
	//Added By Ken.Guo 2009-09-16.
	If isvalid(ids_alm_status) Then
		ll_i = ids_alm_status.GetRow()
		If ll_i > 0 Then
			ids_alm_status.setitem(ll_i,'alm_last_notification_sent',ldt_null )
			ids_alm_status.setitem(ll_i,'alm_total_tries_counter', ll_null )
		End If
	End If
	
	//Added By Ken.Guo 2009-09-16. //Set Next Snooze 
	
	lds_snooze.SetFilter('ctx_id = ' + String(al_ctxid[i]) + ' And alm_table = "'+as_table[i]+ '" And alm_column = "' +as_column[i]+ '"' + " And doc_id = " + string(al_docid[i]) + " And level_id1 = " + string(al_level_id1[i])+ " And level_id2 = " + string(al_level_id2[i]) )
	lds_snooze.Filter()
	lds_snooze.SetSort('id Asc')
	lds_snooze.Sort()
	If lds_snooze.RowCount() > 0 Then
		li_loop = lds_snooze.Getitemnumber(1,'snooze_loop')
		ll_row = lds_snooze.Find('asnooze_executed = 0',1, lds_snooze.RowCount())
		If ll_row > 0 Then
			lds_snooze.SetItem(ll_row,'asnooze_executed',1)
			If ll_row < lds_snooze.RowCount() Then
				ll_next_snooze_value = lds_snooze.GetItemNumber(ll_row + 1, 'increment_value')
				ls_next_snooze_unit  = lds_snooze.GetItemString(ll_row + 1, 'increment_unit')
			Else
				If li_loop = 1 Then
					ll_next_snooze_value = lds_snooze.GetItemNumber(1, 'increment_value')
					ls_next_snooze_unit  = lds_snooze.GetItemString(1, 'increment_unit')					
					For n = 1 To lds_snooze.RowCount()
						lds_snooze.SetItem(n,'asnooze_executed',0)
					Next
				End If
			End If
		Else
			If li_loop = 1 Then
				ll_next_snooze_value = lds_snooze.GetItemNumber(1, 'increment_value')
				ls_next_snooze_unit  = lds_snooze.GetItemString(1, 'increment_unit')					
				For n = 1 To lds_snooze.RowCount()
					lds_snooze.SetItem(n,'asnooze_executed',0)
				Next
			End If
		End If
		If ll_next_snooze_value > 0 Then
			lds_notification_years.SetItem(ll_found, 'alm_auto_increment_years',ll_next_snooze_value)
			lds_notification_years.SetItem(ll_found, 'alm_auto_increment_unit',ls_next_snooze_unit)
		End If
		
	End If
	
NEXT

IF Len(Trim(ls_sql)) > 0 THEN 
	EXECUTE IMMEDIATE :ls_sql ;	

	//Refresh the detail tabpage
	IF SQLCA.SQLCode = 0 and IsValid(gw_contract) THEN
		lds_notification_years.update()
		lds_snooze.update()
		//--------------------2.25.2016 RP modified for just-in-time cache-----------------------------------
		//gnv_data.ids_ctx_all_notification.Retrieve() //jervis 07.04.2011
		gnv_data.of_retrieveIfNecessary("ctx_all_notification", TRUE)
		//----------------------------------------------------------------------------------------------------------
		If isvalid(gw_contract) Then
			//gw_contract.tab_contract_details.of_set_select('tabpage_details', FALSE)	
			gw_contract.tab_contract_details.of_set_select('tabpage_multi', FALSE)	
		End If
	END IF		
END IF

If isvalid(lds_notification_years) Then Destroy lds_notification_years

Return 1

end function

public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[]);
//Update the CTX notification parms while the action items' changed to be complete status
//Added by Alfee 07.27.2007
Long i, j, ll_c, ll_t, ll_cnt, ll_cnt_years, ll_found
Long ll_delay, ll_ctx[] //Repace ll_years with ll_deplay - Alfee 02.22.2008
String ls_table[], ls_sql, ls_tabname, ls_colname, ls_criteria, ls_unit
Boolean lb_ctx_duplicate, lb_tab_duplicate
integer li_loop
Long n,ll_row,ll_next_snooze_value = -1,ll_i
String ls_next_snooze_unit
Datetime ldt_null
Long ll_null
long ll_zero[] //jervis 06.30.2011


SetNUll(ldt_null)
SetNUll(ll_null)
datastore lds_notification_years,lds_snooze

ll_cnt = UpperBound(as_column) 
IF ll_cnt < 1 THEN RETURN 0
ll_zero[ll_cnt] = 0

IF Len(Trim(as_column[1])) < 1 THEN RETURN 0

lds_snooze = Create datastore
lds_notification_years = Create datastore


lds_notification_years.dataobject = 'd_alarm_notification_years'
lds_notification_years.SetTransObject(SQLCA)


lds_snooze.dataobject = 'd_ctx_alm_snooze_arr'
lds_snooze.SetTransObject(SQLCA)
lds_snooze.Retrieve(al_ctxid[],as_table[],as_column[],ll_zero[],ll_zero[],ll_zero[])

//Get distinct ctx ids & table names
ll_c = 1
ll_t = 1
FOR i = 1 to ll_cnt
	IF i > 1 THEN 
		lb_ctx_duplicate = FALSE
		lb_tab_duplicate = FALSE
		FOR j = 1 to UpperBound(ll_ctx)
			IF ll_ctx[j] = al_ctxid[i] THEN 
				lb_ctx_duplicate = TRUE
				EXIT //Skip duplicated ctx id	
			END IF
		NEXT		
		FOR j = 1 to UpperBound(ls_table)
			IF ls_table[j] = as_table[i] THEN 
				lb_tab_duplicate = TRUE
				EXIT //Skip duplicated table name
			END IF
		NEXT
		IF Not lb_ctx_duplicate THEN 
			ll_ctx[ll_c] = al_ctxid[i]
			ll_c ++
		END IF
		IF Not lb_tab_duplicate THEN 
			ls_table[ll_t] = as_table[i]
			ll_t ++
		END IF			
	ELSE
		ll_ctx[ll_c] = al_ctxid[1]
		ls_table[ll_t] = as_table[1]
		ll_c ++
		ll_t ++		
	END IF	
NEXT

//Get all relative auto increment years
ll_cnt_years = lds_notification_years.Retrieve(ll_ctx[], ls_table[], as_column[])
IF ll_cnt_years < 1 THEN 
	If isvalid(lds_notification_years) Then Destroy lds_notification_years
	RETURN 0
End If

//Update alarm notification parameters
FOR i = 1 to ll_cnt
	IF IsNull(as_table[i]) or Len(Trim(as_table[i])) < 1 THEN Continue
	IF IsNull(as_column[i]) or Len(Trim(as_column[i])) < 1 THEN Continue

	ls_criteria  = "ctx_id = " + String(al_ctxid[i]) + " And alm_table = '" 
	ls_criteria += as_table[i] + "' And alm_column = '" + as_column[i] + "'"
	ll_found = lds_notification_years.Find(ls_criteria, 1, ll_cnt_years)
	IF ll_found < 1 THEN Continue
	
	ll_delay = lds_notification_years.GetItemNumber(ll_found, 'alm_auto_increment_years')
	//----------------Begin Added by Alfee 02.22.2008-----------------------------------
	IF IsNull(ll_delay) or ll_delay <= 0 THEN Continue

	ls_unit = lds_notification_years.GetItemString(ll_found, 'alm_auto_increment_unit')
	IF Upper(ls_unit) = 'M' THEN 
		ls_unit = 'Month'
	ELSEIF Upper(ls_unit) = 'D' THEN
		ls_unit = 'Day'
	ELSE
		ls_UNIT = 'Year'
	END IF
	//----------------End Added --------------------------------------------------------
	
	ls_sql += "Update " + as_table[i] 
	//ls_sql += "   Set " + as_column[i] + " = DateAdd(year, " + String(ll_delay) + ", " + as_column[i] + ") "  
	ls_sql += "   Set " + as_column[i] + " = DateAdd(" + ls_unit + ", " + String(ll_delay) + ", " + as_column[i] + ") "  //Alfee 02.22.2008	
	ls_sql += " Where " + as_table[i] + ".ctx_id = " + String(al_ctxid[i]) + "; ~r~n"

	ls_sql += "Update ctx_notification" 
	//ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null" 
	ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null, alm_last_wf_trigger = Null" 	
	//ls_sql += "   ,alm_date == DateAdd(" + ls_unit + ", " + String(ll_delay) 	+ ", alm_date) "
	ls_sql += " Where ctx_id = " + String(al_ctxid[i]) 
	ls_sql += "   AND alm_table = '" + as_table[i] + "' AND alm_column = '" + as_column[i] + "' ; ~r~n"
	
	//Added By Ken.Guo 2009-09-16.
	If isvalid(ids_alm_status) Then
		ll_i = ids_alm_status.GetRow()
		If ll_i > 0 Then
			ids_alm_status.setitem(ll_i,'alm_last_notification_sent',ldt_null )
			ids_alm_status.setitem(ll_i,'alm_total_tries_counter', ll_null )
		End If
	End If
	
	//Added By Ken.Guo 2009-09-16. //Set Next Snooze 
	lds_snooze.SetFilter('ctx_id = ' + String(al_ctxid[i]) + ' And alm_table = "'+as_table[i]+ '" And alm_column = "' +as_column[i]+ '" and doc_id = 0 and level_id1 = 0 and level_id2 = 0') //add levle_id - jervis 06.30.2011
	lds_snooze.Filter()
	lds_snooze.SetSort('id Asc')
	lds_snooze.Sort()
	If lds_snooze.RowCount() > 0 Then
		li_loop = lds_snooze.Getitemnumber(1,'snooze_loop')
		ll_row = lds_snooze.Find('asnooze_executed = 0',1, lds_snooze.RowCount())
		If ll_row > 0 Then
			lds_snooze.SetItem(ll_row,'asnooze_executed',1)
			If ll_row < lds_snooze.RowCount() Then
				ll_next_snooze_value = lds_snooze.GetItemNumber(ll_row + 1, 'increment_value')
				ls_next_snooze_unit  = lds_snooze.GetItemString(ll_row + 1, 'increment_unit')
			Else
				If li_loop = 1 Then
					ll_next_snooze_value = lds_snooze.GetItemNumber(1, 'increment_value')
					ls_next_snooze_unit  = lds_snooze.GetItemString(1, 'increment_unit')					
					For n = 1 To lds_snooze.RowCount()
						lds_snooze.SetItem(n,'asnooze_executed',0)
					Next
				End If
			End If
		Else
			If li_loop = 1 Then
				ll_next_snooze_value = lds_snooze.GetItemNumber(1, 'increment_value')
				ls_next_snooze_unit  = lds_snooze.GetItemString(1, 'increment_unit')					
				For n = 1 To lds_snooze.RowCount()
					lds_snooze.SetItem(n,'asnooze_executed',0)
				Next
			End If
		End If
		If ll_next_snooze_value > 0 Then
			lds_notification_years.SetItem(ll_found, 'alm_auto_increment_years',ll_next_snooze_value)
			lds_notification_years.SetItem(ll_found, 'alm_auto_increment_unit',ls_next_snooze_unit)
		End If
		
	End If
	
NEXT

IF Len(Trim(ls_sql)) > 0 THEN 
	EXECUTE IMMEDIATE :ls_sql ;	

	//Refresh the detail tabpage
	IF SQLCA.SQLCode = 0 and IsValid(gw_contract) THEN
		lds_notification_years.update()
		lds_snooze.update()
		//-----------------2.25.2016 RP modified for just-in-time cache-----------------------------
		//gnv_data.ids_ctx_notification.Retrieve() //added by Alfee 08.27.2007
		gnv_data.of_retrieveIfNecessary("ctx_notification", TRUE)
		//-------------------------------------------------------------------------------------------------
		If isvalid(gw_contract) Then
			gw_contract.tab_contract_details.of_set_select('tabpage_details', FALSE)	
		End If
	END IF		
END IF

If isvalid(lds_notification_years) Then Destroy lds_notification_years

Return 1

end function

public function long of_send_mail (string as_sender, string as_mailto[], string as_mailcc[], string as_subject, string as_attachment, blob ablb_message, boolean ab_autosign, str_alarm astr_alm, string as_alarm_ways);//Send mail with richtext message - Created by Alfee on 06.11.2008
long		ll_Return,ll_Cycle, ll_found, ll_exportid,ll_opened = 1
String	ls_Mail_To, ls_Mail_CC
String	ls_Addresser,ls_err_text
n_cst_word_utility lnv_word
n_cst_easymail_smtp 	lnv_Mail
str_email_info lstr_email_info
long ll_ret 
String ls_alarm_type
Integer li_send_result = 0,li_merge_result = 0
DateTime	ldt_duedate //(Appeon)Harry 03.10.2014 - V142 ISG-CLX

If as_sender = '' or isnull(as_sender) Then as_sender = gs_user_id //Added By Ken.Guo 2011-04-21.

//Assign Email setting
for ll_Cycle = 1 to UpperBound(as_mailto)
	ls_Mail_To += as_mailto[ll_Cycle] + ";"
next
ls_mail_to = Mid(ls_mail_to, 1, Len(ls_mail_to) - 1)

for ll_Cycle = 1 to UpperBound(as_mailcc)
	ls_Mail_CC += as_mailcc[ll_Cycle] + ";"
next
ls_Mail_CC = Mid(ls_Mail_CC, 1, Len(ls_Mail_CC) - 1)

select top 1 set_addresser into :ls_Addresser from icred_settings;
if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = as_sender
end if

//Create Email object
if lnv_Mail.of_CreateObject() = -1 then
	//---------Begin Modified by (Appeon)Harry 06.27.2013 for V141 ISG-CLX--------
	//f_show_message('create Email object','','','','')
	//--------Begin Modified by Nova 11.07.2008-----------
	if gb_AutoSchedule= false and ib_schedule = false then //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		f_show_message('create Email object','','','','')
	else
		inv_message.of_MessageBox("Error", "Failed to create email object!",StopSign!,true)
	end if
	//---------End Modfiied ------------------------------------------------------
	Return -1
end if

//Open message and replace merge fields
//Open(w_email_edit)
If as_alarm_ways = '1' Then
	If Not IsValid( w_email_edit_alarm ) Then Open( w_email_edit_alarm )
	
	
	ll_ret = w_email_edit_alarm.of_OpenWord(  ablb_message )
	
	
Else
	If Not IsValid( w_email_edit ) Then Open( w_email_edit )//modified by gavins 20120821
		
	ll_ret = w_email_edit.ole_word.of_Open_Buffer(ablb_message)
End If


If ll_ret < 0 Then 
	ls_err_text = 'Failed to open the email alarm message. ll_err = ' + String(ll_ret)
	gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')
	ll_opened = -1
Else
	If as_alarm_ways = '1' Then
		If IsValid( w_email_edit_alarm.iole_word.ActiveDocument ) Then
			li_merge_result = of_replace_merge_fields( w_email_edit_alarm.iole_word.ActiveDocument,astr_alm)
			If li_merge_result < 0 Then
				ls_err_text = 'Failed to merge email fields. merge result = ' + String(li_merge_result) 
				gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')	
				ll_opened = -11 		
				//added by gavins 20120821
				w_email_edit_alarm.of_Close()
				If  IsValid( w_email_edit_alarm ) Then close( w_email_edit_alarm )
				ib_SendStatus = true
			End If
		Else
			ls_err_text = 'Failed to open the email alarm message. invalidation ActiveDocument ' 
			gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + '.')
			w_email_edit_alarm.of_Close()
			If  IsValid( w_email_edit_alarm ) Then close( w_email_edit_alarm )
			ll_opened = -2
		End If
	Else
		IF w_email_edit.ole_word.object.doctype = 1 THEN //w_email_edit modified by gavins 20120821
			li_merge_result = of_replace_merge_fields(w_email_edit.ole_word.Object.ActiveDocument,astr_alm)
			If li_merge_result < 0 Then
				ls_err_text = 'Failed to merge email fields. merge result = ' + String(li_merge_result) 
				gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + ', word doctype = ' + string(  w_email_edit.ole_word.object.doctype )  + ',word status = ' + string( w_email_edit.ole_word.object.StatusCode)	+ '.' )
				ll_opened = -11 		
				//added by gavins 20120821
				w_email_edit.ole_word.of_Close()
				If IsValid( w_email_edit.ole_word ) Then Destroy( w_email_edit.ole_word )
				If  IsValid( w_email_edit ) Then close( w_email_edit )
				ib_SendStatus = true
			End If
		
		Else
			ls_err_text = 'Failed to open the email alarm message. doctype <> 1. ' 
			gnv_debug.of_output(true, ls_err_text +  ', CTX ID = ' + String(astr_alm.ctx_id) + ', Field Name = ' +  astr_alm.as_column_name + ',word Length = ' + string(Len( ablb_message )) +  ', word doctype = ' + string(  w_email_edit.ole_word.object.doctype )  + ',word status = ' + string( w_email_edit.ole_word.object.StatusCode)	+',word  DocSize = ' + string( w_email_edit.ole_word.object.DocSize)	+ '.' )
			ll_opened = -2
		END IF	
	End IF
End If

/*************************************************///check word if word do't replace
If as_alarm_ways = '1'  and ll_ret >= 0 Then
	If isvalid( w_email_edit_alarm.iole_word ) Then
		If w_email_edit_alarm.of_checkreplace( ) Then 
			gnv_debug.of_output(true, 'content is not replaced! ' )
			ll_opened = -60
			//added by gavins 20120821
			w_email_edit_alarm.of_Close()
			If  IsValid( w_email_edit_alarm ) Then close( w_email_edit_alarm )
			ib_SendStatus = true
		End If
	Else
		gnv_debug.of_output(true, 'ole_word is not valid! ' )
		ll_opened = -50
	End If
ElseIf as_alarm_ways <> '1'  and ll_ret >= 0 Then
	If IsValid( w_email_edit.ole_word ) Then
		If w_email_edit.ole_word.of_checkreplace( ) Then 
			gnv_debug.of_output(true, 'content is not replaced! ' )
			ll_opened = -60
			w_email_edit.ole_word.of_Close()
			If IsValid( w_email_edit.ole_word ) Then Destroy( w_email_edit.ole_word )
			If  IsValid( w_email_edit ) Then close( w_email_edit )
			ib_SendStatus = true
		End If
	Else
		gnv_debug.of_output(true, 'ole_word is not valid! ' )
		ll_opened = -50
	End If	
End If
/*************************************************/

//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
/*
//Added By Ken.Guo 2009-05-22.
long ll_ai_id
//CHOOSE CASE Upper(is_alarm_from)
CHOOSE CASE Upper(astr_alm.alm_table) //jervis 06.28.2011
	CASE 'CTX_BASIC_INFO'
		ls_alarm_type = 'Contract Details Date Alarm'
	CASE 'CTX_ACTION_ITEM'
		ls_alarm_type = 'Contract Action Item Due Date Alarm'
		ll_ai_id = astr_alm.ai_id
	CASE 'CTX_AM_ACTION_ITEM'
		ls_alarm_type = 'Document Action Item Due Date Alarm'
		ll_ai_id = astr_alm.seq_id
	//Add custom - jervis 06.29.2011
	case 'CTX_CUSTOM' 
		ls_alarm_type = 'Contract Custom data Date Alarm'
	case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'
		ls_alarm_type = 'Contract Mulit Custom Data Date Alarm'
	case 'CTX_FEE_SCHED_NM'
		ls_alarm_type = 'Contract Fee Scheduce NM Date Alarm'
End Choose
*/
//Added By Ken.Guo 2009-05-22.
long ll_ai_id
//CHOOSE CASE Upper(is_alarm_from)
CHOOSE CASE Upper(astr_alm.alm_table) //jervis 06.28.2011
	CASE 'CTX_BASIC_INFO'
		//ls_alarm_type = 'Contract Details Date Alarm'
	CASE 'CTX_ACTION_ITEM'
		//ls_alarm_type = 'Contract Action Item Due Date Alarm'
		ll_ai_id = astr_alm.ai_id
	CASE 'CTX_AM_ACTION_ITEM'
		//ls_alarm_type = 'Document Action Item Due Date Alarm'
		ll_ai_id = astr_alm.seq_id
	//Add custom - jervis 06.29.2011
	case 'CTX_CUSTOM' 
		//ls_alarm_type = 'Contract Custom data Date Alarm'
	case 'CTX_CUSTOM_MULTI_HDR'
		//ls_alarm_type = 'Contract Mulit Custom Data(Header) Date Alarm'
	case 'CTX_CUSTOM_MULTI_DETAIL' //Modified By Ken.Guo 12/26/2012
		//ls_alarm_type = 'Contract Mulit Custom Data(Detail) Date Alarm'
	case 'CTX_FEE_SCHED_NM'
		//ls_alarm_type = 'Contract Fee Scheduce NM Date Alarm'
End Choose
ls_alarm_type = This.of_get_alarm_type( astr_alm.alm_table )

//**************************************// added by gavins 20121026
ldt_duedate = astr_alm.alm_date_value
If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '1' And Len( astr_alm.as_appointment ) > 1 And &
	( gnv_data.of_getitem( 'icred_settings', 'appointment_times', False) = '1' Or (  gnv_data.of_getitem( 'icred_settings', 'appointment_times', False) = '0' And  astr_alm.al_alm_times = 0 ) ) Then
	If IsNull( ldt_duedate) Or String( ldt_duedate, 'yyyymmdd' ) = '19000101'  Then ldt_duedate = DateTime( today( ) )
	lnv_Mail.of_setappointmentarguments( true, ldt_duedate , astr_alm.as_alm_type )
End If
//**************************************//	

//---------End Modfiied ------------------------------------------------------

//Send Email
If ll_opened > 0 Then
	If as_alarm_ways = '1' Then
		ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_Mail_To, ls_Mail_CC, '',astr_alm.alm_subject , w_email_edit_alarm, as_attachment, ab_autosign,astr_alm.ctx_id,astr_alm.doc_id,ll_ai_id  ) //Modified By Ken.Guo 2009-12-14. Use email template's subject.
	Else
		ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_Mail_To, ls_Mail_CC, '',astr_alm.alm_subject , w_email_edit.ole_Word, as_attachment, ab_autosign,astr_alm.ctx_id,astr_alm.doc_id,ll_ai_id  ) //Modified By Ken.Guo 2009-12-14. Use email template's subject.
	End If
Else
	ll_Return = -1
End If

//Restore current directory
If DirectoryExists(Gs_Current_Directory) Then ChangeDirectory(Gs_Current_Directory)

//Close window, destroy Email object & temporary file
If  IsValid( w_email_edit ) Then w_email_edit.ole_word.of_Close()//modified by gavins 20120821
If  IsValid( w_email_edit ) Then Close(w_email_edit)

lnv_Mail.of_DeleteObject()
if FileExists(as_attachment) then FileDelete (as_attachment )

//Added Log info
if ll_Return <> 0 then
	//gstr_email_info.ss_email_from = is_alarm_from + '_alarm'
	gstr_email_info.ss_email_from = astr_alm.alm_table + '_alarm'
	gstr_email_info.sl_ctx_id = astr_alm.ctx_id
	gstr_email_info.ss_column_name = astr_alm.alm_column
	gstr_email_info.sl_action_id = astr_alm.ai_id
	gstr_email_info.sl_doc_id = astr_alm.doc_id
	gstr_email_info.sl_wf_id = astr_alm.wf_id
	If ll_opened > 0 Then
		//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		/*
		//---------Begin Modified by (Appeon)Harry 06.27.2013 for V141 ISG-CLX--------
		//f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		//--------Begin Modified by Nova 11.07.2008-----------
		if gb_AutoSchedule= false and ib_schedule = false then //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
			f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		else
			inv_message.of_MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!,true)
		end if
		//---------End Modfiied ------------------------------------------------------	
		*/
		If lnv_Mail.is_sendprotocol = 'SMTP' Then
			if gb_AutoSchedule= false and ib_schedule = false then //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
				f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
			else
				inv_message.of_MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!,true)
			end if
		Else
			f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
		End If
		//---------End Modfiied ------------------------------------------------------
	End If
	gstr_email_info = lstr_email_info
	li_send_result = -1
	//Return -1
end if

//Added By Ken.Guo 2010-11-15. Email Audit
String ls_errtext,ls_attachfilename,ls_columnname,ls_computer_info
n_cst_string lnv_string
If ll_Return <> 0 then 
	ls_errtext = gnv_message.of_get_error_message( ll_Return)
End If
ls_attachfilename = lnv_string.of_get_file_name( as_attachment, ',') 

If astr_alm.as_column_name <> '' and not isnull(astr_alm.as_column_name) Then
	ls_columnname = astr_alm.as_column_name +' ('+ astr_alm.alm_column + ')'
Else
	ls_columnname = astr_alm.alm_column
End If
ls_computer_info = lnv_Mail.of_get_compute_info( )

//Using open error info
If ll_Return = -1 and ll_opened < 0 Then
	ls_errtext = ls_err_text
End If

//truncate subject string if it too long
String ls_subject 
ls_subject = astr_alm.alm_subject
If Len(ls_subject) > 500 Then ls_subject = Mid(ls_subject, 1, 490) + '...'

//Insert to audit table
Insert Into em_mail_audit
(user_id,mail_from,mail_to,mail_cc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,compute_info)
Values 
(:gs_user_id,:ls_Addresser,:ls_Mail_To,:ls_Mail_CC,:ls_subject,getdate(),:ls_attachfilename,:astr_alm.alm_email_template_id,:astr_alm.ctx_id,:astr_alm.doc_id,:astr_alm.ai_id,:astr_alm.wf_id,:ls_alarm_type,:ls_columnname,:li_send_result,:ls_errtext,:ls_computer_info);

gstr_email_info = lstr_email_info //Added By Ken.Guo 2009-10-13.

if ll_Return <> 0 then Return -1

//Update alarm counters
of_update_counters(astr_alm) //jervis 06.28.2011

Return 1
end function

public function string of_get_sched_msg ();// (Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();// (Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_set_sched_flag (boolean ab_flag);// (Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function string of_get_alarm_type (string as_alm_table);//(Appeon)Harry 03.10.2014 - V142 ISG-CLX
//Added By Ken.Guo 12/26/2012
String ls_alarm_type

CHOOSE CASE Upper(as_alm_table)
	CASE 'CTX_BASIC_INFO'
		ls_alarm_type = 'Contract Details Date Alarm'
	CASE 'CTX_ACTION_ITEM'
		ls_alarm_type = 'Contract Action Item Due Date Alarm'
	CASE 'CTX_AM_ACTION_ITEM'
		ls_alarm_type = 'Document Action Item Due Date Alarm'
	case 'CTX_CUSTOM' 
		ls_alarm_type = 'Contract Custom data Date Alarm'
	case 'CTX_CUSTOM_MULTI_HDR'
		ls_alarm_type = 'Contract Mulit Custom Data(Header) Date Alarm'
	case 'CTX_CUSTOM_MULTI_DETAIL' //Modified By Ken.Guo 12/26/2012
		ls_alarm_type = 'Contract Mulit Custom Data(Detail) Date Alarm'
	case 'CTX_FEE_SCHED_NM'
		ls_alarm_type = 'Contract Fee Scheduce NM Date Alarm'
End Choose

Return ls_alarm_type

end function

on n_cst_notification.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_notification.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Alfee 08.20.2008

ids_alm_status = create n_ds
ids_alm_status.dataobject = 'd_alm_status'
ids_alm_status.of_settransobject( sqlca)

ids_users = create n_ds
ids_users.dataobject = 'd_notification_users_select'
ids_users.of_settransobject( sqlca)

lds_action_items = create n_ds
lds_action_items.dataobject = 'd_cntx_action_items'
lds_action_items.settransobject( sqlca)

//---Begin Added by Alfee on 06.11.2008----------
ids_email_template = create n_ds
ids_email_template.dataobject = 'd_ctx_email_template'
ids_email_template.settransobject( sqlca)

ids_export_ctx = create n_ds
ids_export_ctx.dataobject = 'd_alm_export_ctx'
ids_export_ctx.settransobject(sqlca)
//---End Added -----------------------------------

ids_sec_users = create n_ds
ids_sec_users.dataobject = 'd_sec_users'
ids_sec_users.settransobject(sqlca)



end event

event destructor;
long ll_row

/////////////////////////////////////////////////////////
// record ids need to be updated
/////////////////////////////////////////////////////////

//for ll_row = 1 to lds_action_items.rowcount()
//	lds_action_items.setItem(ll_row,'record_id', gnv_app.of_get_id('RECORD_ID') )
//next

//lds_action_items.update()


//-----------Begin Added by Alfee on 06.11.2008 ---------------------------
IF IsValid(ids_alm_status) THEN Destroy ids_alm_status
IF IsValid(lds_action_items) THEN Destroy lds_action_items
IF IsValid(ids_email_template) THEN Destroy ids_email_template
IF IsValid(ids_export_ctx) THEN Destroy ids_export_ctx
If IsValid(ids_sec_users) Then Destroy ids_sec_users
//-----------End Added ----------------------------------------------------
IF IsValid(ids_users) THEN Destroy ids_users //Alfee 08.20.2008
end event

