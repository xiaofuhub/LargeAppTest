$PBExportHeader$n_cst_workflow_triggers.sru
forward
global type n_cst_workflow_triggers from nonvisualobject
end type
end forward

global type n_cst_workflow_triggers from nonvisualobject
end type
global n_cst_workflow_triggers n_cst_workflow_triggers

type variables
long		il_Mail_id,il_data_id,il_export_id		//Added by Scofield on 2007-11-26
long		il_doc_id										//Added by Scofield on 2009-07-23
Long 		ii_send_type = 0
string 	is_init
string 	is_dept_chairperson
String is_sa_address //Added By Ken.Guo 2010-08-13.

str_group_alarm istr_group_alarm[] //Added By Ken.Guo 2010-08-10.
DataStore		ids_EmailAttach						//Added by Scofield on 2009-02-20
n_cst_filesrv 	in_FileSrv								//Added by Scofield on 2009-02-20
str_ai_flag istr_ai_flag[],istr_ai_null[] //Added By Ken.Guo 2010-08-11.
str_action_item istr_action_item

private:
boolean 	ib_message = true	//08.28.2007

Constant String IS_REMINDER = '1'
Constant String IS_ESCALATION = '2'

//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
n_cst_message inv_message //scheduler - alfee 02.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
//---------End Modfiied ------------------------------------------------------

String is_err//Added by Appeon long.zhang 12.26.2014
pfc_cst_nv_data_entry_functions inv_data_entry//Added by Appeon long.zhang 12.26.2014
datastore ids_net_dev_action_items

end variables

forward prototypes
public function date of_daysafter (date ad_date, integer ai_plus, string as_weekend)
public function integer of_send_mail (str_action_item astr_action_item, integer ai_send_type)
public function integer of_status_changed (str_action_item astr_action)
public function integer of_create_action_items (str_action_item astr_action, string as_module)
public function integer of_workflow_create_action_items (str_action_item astr_action)
public function integer of_workflow_triggers (str_action_item astr_action[])
public function string of_get_userid (str_action_item astr_action, string as_user_id)
public function integer of_data_value_comparision_old (long al_screen_id, long al_key_id, long al_facility_id, string as_module, string as_runtype)
public function integer of_get_emailinfo (str_action_item astr_action, integer ai_mail_id, ref str_email astr_email)
public function string of_replace_export (str_action_item astr_action, long al_export_id, string as_message)
public function string of_get_emailaddress (str_action_item astr_action, string as_user_id, string as_to_user_id, string as_by_user_id)
public function boolean of_get_message ()
public subroutine of_set_message (boolean ab_flag)
public function string of_getfieldcomp (string as_module, string as_tablename, long al_key_id, long al_facility_id)
public function integer of_get_emailmessage (long al_email_id, ref blob ablb_msgdata)
public function integer of_resend_letters ()
public function string of_getupdatecol (ref datawindow adw_update)
public subroutine of_set_actionitem_notes (str_action_item astr_action, string as_to, string as_cc, string as_subject, string as_attachname)
public subroutine of_set_actionitem_flag (str_action_item astr_action, string as_to, string as_cc, string as_subject, string as_attachname, string as_send_type)
public subroutine of_getemailattachment (long al_email_id, long al_attach_id, ref blob ablb_attachment)
public function integer of_popup_prompt (str_action_item astr_action)
public subroutine of_build_fielddddw (long al_view_id, long al_screen_id, ref datawindow adw_screen, ref datawindowchild adwc_field, string as_triggered_by)
public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype)
public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype)
public function string of_replace_export (ref string as_message, ref datastore ads_export)
public function integer of_pre_group_email (str_action_item astr_action_item, string as_mailto, string as_mailcc)
public function integer of_set_actionitem_flags ()
public subroutine of_trigger_by_onlogin ()
public function integer of_data_value_comparision_bak09142010 (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype, string as_triggertype)
public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype, string as_triggertype)
public function integer of_advanced_update_10122010 (string as_module, long al_ctx_id, long al_doc_id, long al_wf_id, long al_step_id, long al_status_id)
public function integer of_advanced_update (string as_module, long al_ctx_id, long al_doc_id, long al_wf_id, long al_step_id, long al_status_id)
public function string of_replace_export (ref string as_message, ref datastore ads_export, long al_row)
public function integer of_send_mail (string as_by_user, string as_to_users, string as_cc_users, ref str_email astr_emailinfo, long al_ctx_id, long al_doc_id, long al_action_item_id)
public function integer of_create_sub_contracts (long al_ctx_id, long al_ai_id)
public function integer of_parse_default_copy_ctx (ref str_copy_ctx lstr_copy_ctx, string ls_value)
public function integer of_reminder_mail_process_ctx ()
public function integer of_send_mail (string as_by_user, string as_to_users, string as_cc_users, str_email astr_emailinfo)
public function integer of_reminder_mail_process_ic ()
public function integer of_reminder_mail_process ()
public function integer of_get_sched_cnt ()
public function string of_get_sched_msg ()
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_data_value_comparision (long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype)
public function integer of_compare (long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype)
end prototypes

public function date of_daysafter (date ad_date, integer ai_plus, string as_weekend);integer	li_daysnumber
integer 	li_weekdays , li_pluss
date ld_duedate

If as_weekend = 'Y' Then
	li_daysnumber = DayNumber(ad_date)
	If li_daysnumber + ai_plus <= 6 Then
		ld_duedate = RelativeDate(ad_date , ai_plus)
	Else
		If ai_plus <= 7 Then
			ld_duedate = RelativeDate(ad_date , ai_plus + 2)
		Else
			li_weekdays = mod(ai_plus , 5)
			If li_weekdays = 0 Then
				ld_duedate = RelativeDate(ad_date , (ai_plus/5) * 7)
			Else
				li_pluss = 	int(ai_plus/5)			
				If li_weekdays + li_daysnumber <= 6 Then
					li_pluss = li_pluss + li_weekdays
				Else
					li_pluss = li_pluss + li_weekdays + 2
				End If
				ld_duedate = RelativeDate(ad_date , li_pluss)
			End If
		End If
	End If
Else
	ld_duedate = RelativeDate(ad_date , ai_plus)
End If

return ld_duedate
end function

public function integer of_send_mail (str_action_item astr_action_item, integer ai_send_type);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_send_mail
//
//	Arguments:  
//		astr_action_item:Action Item Record information,include:
//			wf_id
//			wf_step_id
//			wf_step_status_id
//			due_date
//			dept_chair
//	ai_send_type:Send mail type
//						1-Work flow was created
//						2-Status was seleted
//						3-For Due Date
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
String 	ls_Assigned_To,ls_Assigned_By,ls_SendTo,ls_SendCC
String	ls_ToNotifyUser,ls_CCNotifyUser,ls_ToReminUser,ls_CCReminUser,ls_ToMessageUser,ls_CCMessageUser
String	ls_chair_flag,ls_create_user
String 	ls_Addresser		//11.29.2007 By Scofield
String 	ls_weekend_flag,ls_note_flag,ls_condition,ls_module
long 		ll_MailNotify_Type,ll_MailNotify_Status,ll_MailMessage,ll_MailReminder
long 		ll_due_date,ll_days_reminder,ll_days_every,ll_send_count,ll_row
date 		ld_due_date,ld_reminder_date
long		ll_Ret
long		ll_action_item_id //Added By Alan on 2009-2-19

ii_send_type = ai_send_type

str_email lstr_email_1,lstr_email_2

//istr_action_item = astr_action_item //Commented by (Appeon)Harry 09.06.2015- for Bug # 4704 

ls_module = gnv_data.of_getitem("wf_workflow" , 'wf_module' , 'wf_id=' + String(astr_action_item.wf_id))
astr_action_item.module = ls_module

istr_action_item = astr_action_item  //(Appeon)Harry 09.06.2015 - for Bug # 4704 

//Added By Alan on 2009-2-19
if astr_action_item.module = "03" then
	ll_action_item_id = astr_action_item.ctx_action_item_id
elseif  astr_action_item.module = "04" then
	ll_action_item_id = astr_action_item.seq_no
end if
//end
//If astr_action_item.ctx_action_item_id = 6146 Then
//	Messagebox('','')
//End If
		
choose case ai_send_type
	case 1,2		//Work flow was created or Status was selected
		//Gets Data from cache
		ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id)
		ll_row = gnv_data.of_findrow("wf_action_types",ls_condition)
		if ll_row < 1 then return -1
		ls_Assigned_To = gnv_data.of_getitem( "wf_action_types",ll_row,"to_user")
		ls_Assigned_By = gnv_data.of_getitem( "wf_action_types",ll_row,"by_user")
		ls_chair_flag = gnv_data.of_getitem( "wf_action_types",ll_row,"dept_chair_flag")
		
		//Get Department chairman
		if ls_chair_flag = "Y" and (ls_module = "01" or ls_module = "02") then
			//ls_Assigned_To = astr_action_item.dept_chair
			ls_Assigned_To = gnv_data.of_getItem("security_users","email_id","user_id = '" + astr_action_item.dept_chair + "'")
		else
			ls_Assigned_To = of_get_emailaddress(astr_action_item,ls_Assigned_To,"","")
		end if
		
		ls_Addresser = of_get_userid(astr_action_item,ls_Assigned_By)
		ls_Assigned_By = of_get_emailaddress(astr_action_item,ls_Assigned_By,"","")
		
		
		if ai_send_type = 1 then	//For Action Type Email send 02.06.2009 By Jervis
			ll_MailNotify_Type = long(gnv_data.of_getitem( "wf_action_types",ll_row,"mail_notify"))
			ls_SendTo = gnv_data.of_getitem( "wf_action_types",ll_row,"send_to_user")
			ls_SendCC = gnv_data.of_getitem( "wf_action_types",ll_row,"cc_user")
			
			If (astr_action_item.module='01' or astr_action_item.module='02') and (IsNull(ls_SendTo) or Trim(ls_SendTo) = '') Then return -1 //(Appeon)Stephen 07.19.2017 - Bug id 5719 - Workflow Step Execution Lag Issue V15.3 SaaS Build 06232017
			//Get email information
			of_Get_EmailInfo(astr_action_item,ll_MailNotify_Type,lstr_email_1)
			
			//Get Email address
			ls_SendTo = of_get_emailaddress(astr_action_item,ls_SendTo,ls_Assigned_To,ls_Assigned_By)
			ls_SendCC = of_get_emailaddress(astr_action_item,ls_SendCC,ls_Assigned_To,ls_Assigned_By)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2007-11-29 By: Scofield
			//$<Reason> Add addresser.
			//of_send_mail(ls_SendTo,ls_SendCC,lstr_email_1)
			il_Mail_id = ll_MailNotify_Type
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			//return of_send_mail(ls_Addresser,ls_SendTo,ls_SendCC,lstr_email_1)
			if astr_action_item.module = '03' or astr_action_item.module = '04' then
				return of_send_mail(ls_Addresser,ls_SendTo,ls_SendCC,lstr_email_1,0,0,0)
			else
				return of_send_mail(ls_Addresser,ls_SendTo,ls_SendCC,lstr_email_1)
			end if
			//---------End Modfiied ------------------------------------------------------
			//---------------------------- APPEON END ----------------------------
		end if
		
		if ai_send_type = 2 then	//for Action statue email send 02.06.2009 By Jervis
			//Get Action Status email info
			ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id) + " and status_id = " + String(astr_action_item.wf_step_status_id)
			ll_row = gnv_data.of_findrow("wf_action_status",ls_condition)
			if ll_row < 1 then return -1
			ll_MailNotify_Status = long(gnv_data.of_getitem( "wf_action_status",ll_row,"mail_notify"))
			ls_ToNotifyUser = gnv_data.of_getitem( "wf_action_status",ll_row,"to_notify_user")
			ls_CCNotifyUser = gnv_data.of_getitem( "wf_action_status",ll_row,"cc_notify_user")
			ls_note_flag = gnv_data.of_getitem( "wf_action_status",ll_row,"include_note_flag")
			
			//Get email information
			of_Get_EmailInfo(astr_action_item,ll_MailNotify_Status,lstr_email_2)
			
			//Include Action Item notes
			if ls_note_flag = "Y" then lstr_email_2.notes = astr_action_item.notes
		
			//Get Email address
			//ls_Assigned_To = gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_Assigned_To + "'")		//27-11-2006 move to of_get_emailaddress
			//ls_CCNotifyUser = gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_CCNotifyUser + "'")
			ls_ToNotifyUser = of_get_emailaddress(astr_action_item,ls_ToNotifyUser,ls_Assigned_To,ls_Assigned_By)
			ls_CCNotifyUser = of_get_emailaddress(astr_action_item,ls_CCNotifyUser,ls_Assigned_To,ls_Assigned_By)
		
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Modify> 2007-11-29 By: Scofield
			//$<Reason> Add addresser.
			
			//return of_send_mail(ls_ToNotifyUser,ls_CCNotifyUser,lstr_email_2)
			il_Mail_id = ll_MailNotify_Status
			
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			if astr_action_item.module = '03' or astr_action_item.module = '04' then
				//ll_Ret = of_send_mail(ls_Addresser,ls_ToNotifyUser,ls_CCNotifyUser,lstr_email_2)
				ll_Ret = of_send_mail(ls_Addresser,ls_ToNotifyUser,ls_CCNotifyUser,lstr_email_2,astr_action_item.ctx_id,astr_action_item.doc_id,ll_action_item_id)	//jervis 02.27.2009
				//Start code by Jervis 02.10.2009
				//Set notes of Action Item when send mail
				if ll_Ret = 1 then
					of_set_actionitem_notes(astr_action_item,ls_ToNotifyUser,ls_CCNotifyUser,lstr_email_2.subject,lstr_email_2.attach_name)
				end if
				//End code
				
				return ll_ret
			else
				return of_send_mail(ls_Addresser,ls_ToNotifyUser,ls_CCNotifyUser,lstr_email_2)
			end if
			//---------End Modfiied ------------------------------------------------------
			
			//---------------------------- APPEON END ----------------------------
		end if
	case 3		//For Due Date
		
		/*select t1.email_id,dept_chair_flag,due_days,weekend_flag
		into :ls_Assigned_To,:ls_chair_flag,:ll_due_date,:ls_weekend_flag
		from wf_action_types,security_users t1
		where wf_id = :astr_action_item.wf_id and step_id = :astr_action_item.wf_step_id and t1.user_id = to_user;
		*/
		//Gets data from cache
		ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id)
		ll_row = gnv_data.of_findrow("wf_action_types",ls_condition)
		if ll_row < 1 then return -1
		ls_Assigned_To = gnv_data.of_getitem( "wf_action_types",ll_row,"to_user")
		ls_Assigned_By = gnv_data.of_getitem( "wf_action_types",ll_row,"by_user")
		ls_chair_flag = gnv_data.of_getitem( "wf_action_types",ll_row,"dept_chair_flag")
		ll_due_date = long(gnv_data.of_getitem( "wf_action_types",ll_row,"due_days"))
		ls_weekend_flag = gnv_data.of_getitem( "wf_action_types",ll_row,"weekend_flag")
		
		/*
		select mail_reminder,isnull(t1.email_id,cc_reminder_user),isnull(t4.email_id,to_reminder_user),days_reminder,days_every,send_count,mail_message,t2.email_id,t3.email_id
		into 	:ll_MailReminder,:ls_SendCC,:ls_SendTo,:ll_days_reminder,:ll_days_every,:ll_send_count,:ll_MailMessage,:ls_ToMessageUser,:ls_CCMessageUser
		from 	wf_action_status left outer join security_users t1 on (cc_reminder_user = t1.user_id) &
				left outer join security_users t4 on (to_reminder_user = t4.user_id) & 
				left outer join security_users t2 on (to_message_user = t2.user_id) &
				left outer join security_users t3 on (cc_message_user = t3.user_id)
		where wf_id = :astr_action_item.wf_id and step_id = :astr_action_item.wf_step_id and status_id = :astr_action_item.wf_step_status_id;
		*/
		//29-11-2006 By Jervis Modify
		//ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id) + " and status_id = " + String(astr_action_item.wf_step_status_id)
		if isnull(astr_action_item.wf_action_status_id) then
			ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id) + " and action_status_id is null "
		else
			ls_condition = "wf_id = " + String(astr_action_item.wf_id) + " and step_id =" + String(astr_action_item.wf_step_id) + " and action_status_id = " + String(astr_action_item.wf_action_status_id)
		end if
		//29-11-2006 By Jervis 
		
		ll_row = gnv_data.of_findrow("wf_action_status",ls_condition)
		if ll_row < 1 then return -1
		ll_MailReminder = long(gnv_data.of_getitem( "wf_action_status",ll_row,"mail_reminder"))
		ls_ToReminUser = gnv_data.of_getitem( "wf_action_status",ll_row,"to_reminder_user")
		ls_CCReminUser = gnv_data.of_getitem( "wf_action_status",ll_row,"cc_reminder_user")
		ll_days_reminder = long(gnv_data.of_getitem( "wf_action_status",ll_row,"days_reminder"))
		ll_days_every = long(gnv_data.of_getitem( "wf_action_status",ll_row,"days_every"))
		ll_send_count = long(gnv_data.of_getitem( "wf_action_status",ll_row,"send_count"))
		ll_MailMessage = long(gnv_data.of_getitem( "wf_action_status",ll_row,"mail_message"))
		ls_ToMessageUser = gnv_data.of_getitem( "wf_action_status",ll_row,"to_message_user")
		ls_CCMessageUser = gnv_data.of_getitem( "wf_action_status",ll_row,"cc_message_user")
		ls_note_flag = gnv_data.of_getitem( "wf_action_status",ll_row,"include_note_flag") //(Appeon)Harry 09.06.2015 - Bug # 4704
		
		//ld_due_date = of_daysAfter(astr_action_item.create_date,ll_due_date,ls_weekend_flag)
		ld_due_date = astr_action_item.due_date
		ld_reminder_date = RelativeDate ( ld_due_date, - ll_days_reminder )
		
		//Get Department chairman
		if ls_chair_flag = "Y"  and (ls_module = "01" or ls_module = "02")then
			//ls_Assigned_To = astr_action_item.dept_chair
			ls_Assigned_To = gnv_data.of_getItem("security_users","email_id","user_id = '" + astr_action_item.dept_chair + "'")
		else
			ls_Assigned_To = of_get_emailaddress(astr_action_item,ls_Assigned_To,"","")
		end if
		ls_Addresser = of_get_userid(astr_action_item,ls_Assigned_By)
		ls_Assigned_By = of_get_emailaddress(astr_action_item,ls_Assigned_By,"","")
			
		//Send email reminder to Assigned to user and cc [user dddw] user [##] days before due date 
		//and resend reminder every [##] days until system has sent out [##] reminders then send [] escalation
		//message to [] and cc[]
		if ld_reminder_date > today() then	//
			return 1
		//---------Begin Modified by (Appeon)Harry 03.04.2014 for Bug  #3925--------
		//elseif RelativeDate(ld_reminder_date,ll_send_count * ll_days_every) < today() then //send escalation message
		elseif RelativeDate(ld_reminder_date,ll_send_count * ll_days_every) <= today() then //send escalation message
		//---------End Modfiied ------------------------------------------------------
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			if astr_action_item.module = '03' or astr_action_item.module = '04' then
				if not isnull(astr_action_item.escalation_date) then return 1 //only be sent only once by jervis 02.17.2009
			end if
			//---------End Modfiied ------------------------------------------------------
			
			//Get email information
			of_Get_EmailInfo(astr_action_item,ll_MailMessage,lstr_email_2)
			
			//Include Action Item notes
			if ls_note_flag = "Y" then lstr_email_2.notes = astr_action_item.notes  //(Appeon)Harry 09.06.2015 - Bug # 4704
			
			//Get email address
			//ls_ToMessageUser = gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_ToMessageUser + "'")
			ls_ToMessageUser = of_get_emailaddress(astr_action_item,ls_ToMessageUser,ls_Assigned_To,ls_Assigned_By)
			//ls_CCMessageUser = gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_CCMessageUser + "'")
			ls_CCMessageUser = of_get_emailaddress(astr_action_item,ls_CCMessageUser,ls_Assigned_To,ls_Assigned_By)
			
			//Send mail
			
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			if astr_action_item.module = '03' or astr_action_item.module = '04' then 
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-11-29 By: Scofield
				//$<Reason> Add addresser.
				
				If gnv_data.of_getitem( 'icred_settings', 'email_alarm_type', False) = '2' Then
					//Added By Ken.Guo 2010-08-11. For Group Email Alarm
					//Pre Group Email
					astr_action_item.alm_times_reminded = 0
					of_pre_group_email(astr_action_item,ls_ToMessageUser,ls_CCMessageUser)
					
					//Add Flags to Array
					istr_ai_flag[UpperBound(istr_ai_flag) + 1].astr_action_item = astr_action_item
					istr_ai_flag[UpperBound(istr_ai_flag)].as_To = ls_ToMessageUser
					istr_ai_flag[UpperBound(istr_ai_flag)].as_CC = ls_CCMessageUser
					istr_ai_flag[UpperBound(istr_ai_flag)].as_subject = lstr_email_2.subject
					istr_ai_flag[UpperBound(istr_ai_flag)].as_attach_name = lstr_email_2.attach_name
					istr_ai_flag[UpperBound(istr_ai_flag)].AS_flag= IS_ESCALATION
				Else
					ll_ret =  of_send_mail(ls_Addresser,ls_ToMessageUser,ls_CCMessageUser,lstr_email_2,astr_action_item.ctx_id,astr_action_item.doc_id,ll_action_item_id) //Modified By Alan on 2009-2-19
					//Start code by Jervis 02.10.2009
					//Set notes of Action Item when send mail
					if ll_Ret = 1 then
						//02.17.2009 By Jervis
						//of_set_actionitem_notes(astr_action_item,ls_ToMessageUser,ls_CCMessageUser,lstr_email_2.subject,lstr_email_2.attach_name)
						of_set_actionitem_flag(astr_action_item,ls_ToMessageUser,ls_CCMessageUser,lstr_email_2.subject,lstr_email_2.attach_name,IS_ESCALATION)
					end if
				End If
				return ll_ret
				//---------------------------- APPEON END ----------------------------
			else
				return of_send_mail(ls_Addresser,ls_ToMessageUser,ls_CCMessageUser,lstr_email_2)
			end if
			//---------End Modfiied ------------------------------------------------------
		elseif (ld_reminder_date = today() or mod(daysAfter(ld_reminder_date,today()),ll_days_every) = 0) then	//send reminder message
			if astr_action_item.reminder_date = today() then return 1

			//Get email information
			of_Get_EmailInfo(astr_action_item,ll_MailReminder,lstr_email_1)
			
			//Include Action Item notes
			if ls_note_flag = "Y" then lstr_email_1.notes = astr_action_item.notes  //(Appeon)Harry 09.06.2015 - Bug # 4704

			//Get Email address
			ls_ToReminUser = of_get_emailaddress(astr_action_item,ls_ToReminUser,ls_Assigned_To,ls_Assigned_By)
			ls_CCReminUser = of_get_emailaddress(astr_action_item,ls_CCReminUser,ls_Assigned_To,ls_Assigned_By)
			
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			//send mail
			if astr_action_item.module = '03' or astr_action_item.module = '04' then
				//--------------------------- APPEON BEGIN ---------------------------
				//$<Modify> 2007-11-29 By: Scofield
				//$<Reason> Add addresser.
				
				If gnv_data.of_getitem( 'icred_settings', 'email_alarm_type', False) = '2' Then
					//Added By Ken.Guo 2010-08-11. For Group Email Alarm
					//Pre Group Email
					astr_action_item.alm_times_reminded = -1 //means: at least one
					of_pre_group_email(astr_action_item,ls_ToReminUser,ls_CCReminUser)
					
					//Add Flags to Array
					istr_ai_flag[UpperBound(istr_ai_flag) + 1].astr_action_item = astr_action_item
					istr_ai_flag[UpperBound(istr_ai_flag)].as_To = ls_ToReminUser
					istr_ai_flag[UpperBound(istr_ai_flag)].as_CC = ls_CCReminUser
					istr_ai_flag[UpperBound(istr_ai_flag)].as_subject = lstr_email_2.subject
					istr_ai_flag[UpperBound(istr_ai_flag)].as_attach_name = lstr_email_2.attach_name
					istr_ai_flag[UpperBound(istr_ai_flag)].AS_flag= IS_REMINDER				
					
				Else
					ll_ret =  of_send_mail(ls_Addresser,ls_ToReminUser,ls_CCReminUser,lstr_email_1,astr_action_item.ctx_id,astr_action_item.doc_id,astr_action_item.ctx_action_item_id) //Modified By Alan on 2009-2-19
					//Start code by Jervis 02.10.2009
					//Set notes of Action Item when send mail
					if ll_Ret = 1 then
						//02.17.2009 By Jervis
						//of_set_actionitem_notes(astr_action_item,ls_ToReminUser,ls_CCReminUser,lstr_email_1.subject,lstr_email_1.attach_name)
						of_set_actionitem_flag(astr_action_item,ls_ToReminUser,ls_CCReminUser,lstr_email_1.subject,lstr_email_1.attach_name,IS_REMINDER)
					end if
				End If
				return ll_ret
				//---------------------------- APPEON END ----------------------------
			else
				return of_send_mail(ls_Addresser,ls_ToReminUser,ls_CCReminUser,lstr_email_1)
			end if
			//---------End Modfiied ------------------------------------------------------
		end if
end choose

return 1

end function

public function integer of_status_changed (str_action_item astr_action);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_status_changed
//
//	Arguments:  
//		astr_action:str_action_item,include:
//			long		wf_id
//			long		wf_step_id
//			long		wf_step_status_id
//			decimal{0}		wf_action_status_id
//			string		dept_chair
//			string		notes
//			date		due_date
//			decimal{0}		rec_id
//			decimal{0}		prac_id
//			long		facility_id
//			long		seq_no
//
//	Returns:  Returns 1 if it succeeds and -1 if an error occurs and 0 if no acton
//				 Returns 2 if update agreement manager header status
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////


long 	ll_step_status_id
long 	ll_ret
Long rtn,ll_row_update//Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
String 	ls_update_header_flag,ls_doc_ext
String ls_sql_old,ls_sql_new //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
Long 		ll_update_status_id,ll_init_status_id,ll_update_status_old_id
decimal	ldec_revision
long 	ll_to_step,ll_trigger_flow,ll_create_step
String 	ls_module,ls_triggered_by,ls_popup_flag
String ls_rtn
String ls_app_id_cond//Added by Appeon long.zhang 12.07.2016
String ls_gp_id_cond//Added by Appeon long.zhang 12.07.2016
str_action_item 		lstr_create_action, lstr_init,lstr_MoveTo
DataStore lds_action_status , lds_action_types
long		ll_find , ll_specify_step , ll_null
boolean	lb_update,lb_set_status
long ll_set_step,ll_set_status			//27-11-2006 by Jervis
long ll_set_wf			//12.5.2006 By jervis
str_add_audit lstr_add_audit		//02.07.2007 By Jervis
n_cst_dm_utils lnv_dm_utils		//02.07.2007 By Jervis
//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
datetime ldt_now  //maha 08.04.2011
				
ldt_now = datetime(today(),now())
//---------End Modfiied ------------------------------------------------------

ls_module = gnv_data.of_getitem("wf_workflow", "wf_module" , "wf_id=" + string(astr_action.wf_id))
ls_triggered_by = gnv_data.of_getitem("wf_workflow", "wf_triggered_by" , "wf_id=" + string(astr_action.wf_id))

SetPointer(HourGlass!)
debugbreak()
Choose case ls_module
	Case "01","02"
		If isnull(astr_action.wf_id) or isnull(astr_action.wf_step_id) or isnull(astr_action.rec_id) or  	&
			isnull(astr_action.prac_id) or isnull(astr_action.facility_id) or isnull(astr_action.seq_no) Then
			return -1
		End If
	Case "03"
		if isnull(astr_action.wf_id) or isnull(astr_action.wf_step_id) or isnull(astr_action.ctx_id) then
			return -1
		end if
	Case "04"
		if isnull(astr_action.wf_id) or isnull(astr_action.wf_step_id) or isnull(astr_action.doc_id) then
			return -1
		end if
	Case else
		return -1
End Choose

//Get the Action Status for the current action type
lds_action_status = Create DataStore
lds_action_status.dataobject = 'd_g_action_status_data'
lds_action_status.SetTransObject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_action_status', "wf_id="+string(astr_action.wf_id) + " and step_id=" + string(astr_action.wf_step_id) , lds_action_status)

//01-12-2006 By Jervis,Action_status_id can be set to null
if isnull(astr_action.wf_action_status_id) then
	ll_find = lds_action_status.find( "isnull(action_status_id)", 1, lds_action_status.RowCount())
else
	ll_find = lds_action_status.find( "action_status_id=" + string(astr_action.wf_action_status_id), 1, lds_action_status.RowCount())
end if

If not ll_find > 0 Then 
	destroy lds_action_status
	return 0
end if

//
lds_action_types = Create DataStore
lds_action_types.dataobject = 'd_g_action_types_data'
lds_action_types.SetTransObject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_action_types', "wf_id="+string(astr_action.wf_id) , lds_action_types)
lds_action_types.setsort("step_order")
lds_action_types.sort()

////match to step status id
//ll_ret =  of_get_step_status_id(astr_action.wf_id,astr_action.wf_step_id,astr_action.wf_action_status_id,ll_step_status_id)
//If ll_ret <= 0 Then Return ll_ret
ll_step_status_id = lds_action_status.GetItemnumber(ll_find , "status_id")

//Get the action status information from the cache data
ls_update_header_flag = lds_action_status.GetItemString(ll_find ,'update_header_flag')
ll_update_status_id = lds_action_status.GetItemNumber(ll_find ,'update_status_id')
ll_to_step = lds_action_status.GetItemNumber(ll_find ,'to_step')
ll_trigger_flow = lds_action_status.GetItemNumber(ll_find ,'trigger_flow')
ll_create_step = lds_action_status.GetItemNumber(ll_find ,'create_step')

//start-----27-11-2006 By Jervis----------
ll_set_step = lds_action_status.GetItemNumber(ll_find,"set_step")
ll_set_status = lds_action_status.GetItemNumber(ll_find,"set_status")

//12.5.2006 By Jervis
ll_set_wf = lds_action_status.GetItemNumber(ll_find,"set_wf_id")
//----------------------------------------

gnv_appeondb.of_startqueue()

//Start code By Jervis 02.17.2009
//Reset mail send flag to null
if ls_module = '03' then
	update ctx_action_items set reminder_last = null 
	where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
	
	update ctx_action_items set escalation_last = null 
	where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
elseif ls_module = '04' then
	update ctx_am_action_item set reminder_last = null 
	where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
	
	update ctx_am_action_item set escalation_last = null 
	where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
end if
//End code


/*
//Check for complete Action Item status.
If lds_action_status.GetItemString(ll_find , 'complete_flag') = 'Y' Then
	choose case ls_module
		case "01"
			update verif_info set wf_complete_flag = 'Y' 
			where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id 
			//and wf_id = :astr_action.wf_id and rec_id = :astr_action.rec_id and seq_no = :astr_action.seq_no;
			and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
			
		case "02"
			update net_dev_action_items set wf_complete_flag = "Y"
			//where rec_id = :astr_action.rec_id and wf_id = :astr_action.wf_id;
			where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id 
			and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
			
		case "03"
			update ctx_action_items set wf_complete_flag = "Y"
			//where ctx_action_item_id = :astr_action.ctx_action_item_id and ctx_id = :astr_action.ctx_id;
			where ctx_id = :astr_action.ctx_id and wf_complete_flag = 'N';
		case "04"
	end choose
	//If the status is the complete status, then return
	//return 1
End If
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.15.2006 By: Jervis
//$<reason> Popup Notes Dialog box when this status is selected
//<History> Modified By Ken.Guo 2010-06-29. Only show once prompt in batch add/create document module.
integer li_status
ls_popup_flag = lds_action_status.GetItemString(ll_find ,'popup_flag')
if ls_popup_flag = "Y" then
	//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
	if  ls_module = '01' or ls_module = '02' then
		//------Begin Modified by Alfee 01.15.2010 ---------------
		//<$Reason> for a richtext bug in APB 6.0 
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
		OpenWithParm( w_ai_notes_new,astr_action.notes)
	//	IF appeongetclienttype() = 'WEB' THEN  
	//		OpenWithParm( w_ai_notes_web, astr_action.notes)
	//	ELSE		
	//		OpenWithParm( w_ai_notes, astr_action.notes)
	//	END IF		
		//	OpenWithParm( w_ai_notes, astr_action.notes)
		//------End Modified --------------------------------------	
	
		If Message.StringParm <> "Cancel" Then
			astr_action.notes = message.stringparm
			choose case ls_module
				case "01"
					update verif_info set notes = :astr_action.notes , mod_date = :ldt_now   ,mod_user = :gs_user_id
					where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;
				case "02"
					update net_dev_action_items set notes = :astr_action.notes
					where rec_id = :astr_action.rec_id;
				case "03"
					update ctx_action_items set notes = :astr_action.notes
					where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id; 
				case "04"
					update ctx_am_action_item set notes = :astr_action.notes
					where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no; 
			end choose
	
		End If
	else
		If Not gnv_workflow_prompt.of_get_prompt_status( ) Then
			li_status = gnv_workflow_prompt.of_get_wf_ai_status(astr_action.wf_id ) 
			Choose Case li_status
				Case 0 // first run
					OpenWithParm( w_ai_notes, astr_action.notes)
					If Message.StringParm <> "Cancel" Then
						astr_action.notes = message.stringparm
						choose case ls_module
							case "01"
								update verif_info set notes = :astr_action.notes  , mod_date = :ldt_now   ,mod_user = :gs_user_id  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
								where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;
							case "02"
								update net_dev_action_items set notes = :astr_action.notes
								where rec_id = :astr_action.rec_id;
							case "03"
								update ctx_action_items set notes = :astr_action.notes
								where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id; 
							case "04"
								update ctx_am_action_item set notes = :astr_action.notes
								where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no; 
						end choose
						gnv_workflow_prompt.of_set_wf_ai_status(astr_action.wf_id, 1)
						gnv_workflow_prompt.of_set_wf_ai_notes( astr_action.wf_id, astr_action.notes)
					Else
						gnv_workflow_prompt.of_set_wf_ai_status(astr_action.wf_id, -1)
					End If
				Case 1 // direct add notes
					astr_action.notes = gnv_workflow_prompt.of_get_wf_ai_notes(astr_action.wf_id)
					choose case ls_module
						case "01"
							update verif_info set notes = :astr_action.notes +  (case when notes is null then '' else notes end)  , mod_date = :ldt_now   ,mod_user = :gs_user_id  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
							where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;
						case "02"
							update net_dev_action_items set notes = :astr_action.notes
							where rec_id = :astr_action.rec_id;
						case "03"
							update ctx_action_items set notes = :astr_action.notes +  (case when notes is null then '' else notes end) 
							where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id; 
						case "04"
							update ctx_am_action_item set notes = :astr_action.notes +  (case when notes is null then '' else notes end) 
							where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no; 
					end choose				
				Case -1 //direct ignore notes
					//N/A
			End Choose
		Else
			OpenWithParm( w_ai_notes, astr_action.notes)
			If Message.StringParm <> "Cancel" Then
				astr_action.notes = message.stringparm
				choose case ls_module
					case "01"
						update verif_info set notes = :astr_action.notes  , mod_date = :ldt_now   ,mod_user = :gs_user_id  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
						where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;
					case "02"
						update net_dev_action_items set notes = :astr_action.notes
						where rec_id = :astr_action.rec_id;
					case "03"
						update ctx_action_items set notes = :astr_action.notes
						where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id; 
					case "04"
						update ctx_am_action_item set notes = :astr_action.notes
						where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no; 
				end choose
			End If
			
		End If
	end if
	//---------End Modfiied ------------------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

//Update agreement header status field
If ls_update_header_flag = "Y" And ls_module = "04" Then
	//only module = 04-Contract Logix Agreement
	if not isnull(ll_update_status_id) then	//01.23.2007 By Jervis
	
		//Add By Jervis 02.07.2007
		select revision,doc_ext,status
		into :ldec_revision,:ls_doc_ext,:ll_update_status_old_id
		from ctx_am_document
		where doc_id = :astr_action.doc_id;
		//End Add
		
		update ctx_am_document set status = :ll_update_status_id ,status_date = getdate()
		where doc_id = :astr_action.doc_id;
	end if
End If

commit;
gnv_appeondb.of_commitqueue()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.07.2007 By: Jervis
//$<reason> 
if ls_doc_ext <> "" then
	string ls_old_status,ls_new_status
	lstr_add_audit.doc_id = astr_action.doc_id
	lstr_add_audit.revision = ldec_revision
	lstr_add_audit.doc_ext = ls_doc_ext
	lstr_add_audit.action = "Status Change"
	
	ls_old_status = gnv_data.of_getitem("code_lookup","code","lookup_code = " + string(ll_update_status_old_id))
	ls_new_status = gnv_data.of_getitem("code_lookup","code","lookup_code = " + string(ll_update_status_id))
	lstr_add_audit.notes = "Changed Status from " + ls_old_status + " to " + ls_new_status 
	lnv_dm_utils.of_add_audit_trail( lstr_add_audit )
end if
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX-------
if ls_module = '03' or ls_module = '04' then 
	//Advanced Update when change status - jervis 03.12.2009
	if of_Advanced_update(ls_module,astr_action.ctx_id,astr_action.doc_id,astr_action.wf_id,astr_action.wf_step_id, ll_step_status_id) < 0 then return -1
end if
//---------End Modfiied ------------------------------------------------------

//Send e-mail for action status changed
astr_action.wf_step_status_id = ll_step_status_id
of_send_mail(astr_action,2)


//Trigger the special work flow
If Not IsNull(ll_trigger_flow) and ll_trigger_flow > 0 Then
	//Call the process of trigger work flow....
	lstr_create_action = astr_action
	lstr_create_action.screen_id = -10
	lstr_create_action.wf_id = ll_trigger_flow
	of_workflow_create_action_items(lstr_create_action)
End If

//Create a specify Action Item Record(N/A -100)
If Not IsNull(ll_create_step) and ll_create_step <> -100 Then
	if ll_create_step = -4 then		//Create Action Item Record For Next Step
		//Select Top 1 step_id Into :ll_create_step From wf_action_types Where wf_id = :astr_action.wf_id And step_id > :astr_action.wf_step_id Order By step_order Asc;
		ll_find = lds_action_types.find("step_id="+string(astr_action.wf_step_id), 1, lds_action_types.rowcount())
		If ll_find > 0 and ll_find < lds_action_types.RowCount() Then
			ll_specify_step = lds_action_types.GetItemNumber(ll_find + 1 , 'step_id')
		End If
	elseif ll_create_step > 0 then	//Create Action Item REcord for Next ##
		//select step_id into :ll_create_step from wf_action_types where wf_id = :astr_action.wf_id and step_order = :ll_create_step;
		ll_find = lds_action_types.find("step_order="+string(ll_create_step), 1, lds_action_types.rowcount())
		If ll_find > 0  Then
			ll_specify_step = lds_action_types.GetItemNumber(ll_find, 'step_id')
		End If
	end if
	
	If not isnull(ll_specify_step) and ll_specify_step > 0  then
		lstr_create_action = astr_action
		lstr_create_action.wf_step_id = ll_specify_step
		//Call the process of create action item record
		if of_create_action_items(lstr_create_action,ls_module) <> 1 then 
			destroy lds_action_status
			destroy lds_action_types
			return -1
		end if
		//lb_update = true    //28-11-2006 by jervis comment
	End If
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.27.2006 By: Jervis
//$<reason> 
//Set step [dddw] to Status [dddw]
boolean lb_set_status_flag
if ll_set_wf > 0 and ll_set_step > 0 and ll_set_status > 0 then
	//Reset action item structure
	lstr_create_action = astr_action
	lb_set_status_flag = false
	choose case ls_module
		case "01"
			select t2.action_status_id,t1.wf_action_type_id,t1.notes,t1.due_date,t1.seq_no,t1.rec_id
			into :lstr_create_action.wf_action_status_id,:lstr_create_action.wf_step_id,:lstr_create_action.notes,:lstr_create_action.due_date,:lstr_create_action.seq_no,:lstr_create_action.rec_id
			from verif_info t1,wf_action_status t2
			where t1.prac_id = :astr_action.prac_id and t1.facility_id = :astr_action.facility_id and
					t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N' and 
					t2.wf_id = t1.wf_id and t2.step_id = t1.wf_action_type_id and t2.status_id = :ll_set_status;// and t1.response_code <> t2.action_status_id;
		case "02"
			//app_id and gp_id, Added by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
			select t2.action_status_id,t1.wf_action_type_id,t1.notes,t1.due_date,t1.seq_no,t1.rec_id
			into :lstr_create_action.wf_action_status_id,:lstr_create_action.wf_step_id,:lstr_create_action.notes,:lstr_create_action.due_date,:lstr_create_action.seq_no,:lstr_create_action.rec_id
			from net_dev_action_items t1,wf_action_status t2
			where t1.prac_id = :astr_action.prac_id and t1.facility_id = :astr_action.facility_id and
					(t1.app_id = :astr_action.app_id or (:astr_action.app_id is null and t1.app_id is null)) and 
					(t1.gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and t1.gp_id is null)) and
					t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N' and
					t2.wf_id = t1.wf_id and t2.step_id = t1.wf_action_type_id and t2.status_id = :ll_set_status;// and t1.action_status <> t2.action_status_id;
		case "03"
			select t2.action_status_id,t1.wf_action_type_id,t1.notes,t1.due_date
			into :lstr_create_action.wf_action_status_id,:lstr_create_action.wf_step_id,:lstr_create_action.notes,:lstr_create_action.due_date
			from ctx_action_items t1,wf_action_status t2
			where t1.ctx_id = :astr_action.ctx_id and
					t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N' and
					t2.wf_id = t1.wf_id and t2.step_id = t1.wf_action_type_id and t2.status_id = :ll_set_status;// and t1.action_status <> t2.action_status_id;
		case "04"
			select t2.action_status_id,t1.wf_action_type_id,t1.notes,t1.due_date
			into :lstr_create_action.wf_action_status_id,:lstr_create_action.wf_step_id,:lstr_create_action.notes,:lstr_create_action.due_date
			from ctx_am_action_item t1,wf_action_status t2
			where t1.doc_id = :astr_action.doc_id and
					t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N' and
					t2.wf_id = t1.wf_id and t2.step_id = t1.wf_action_type_id and t2.status_id = :ll_set_status;// and t1.action_status <> t2.action_status_id;
	end choose
	
	if sqlca.sqlcode <> -1 then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 12.26.2006 By: Jervis
		//$<reason> Create the step when the specified step is not created
		lb_set_status = false
		lstr_create_action.wf_step_status_id = ll_set_status
		lstr_create_action.wf_id = ll_set_wf
		lstr_create_action.wf_step_id = ll_set_step
		if sqlca.sqlcode = 100 then
			lstr_create_action.wf_action_status_id = long(gnv_data.of_getItem("wf_action_status","action_status_id","wf_id = "+ string(ll_set_wf) + " and step_id="+string(lstr_create_action.wf_step_id) + " and status_id =" + string(ll_set_status)))
			if of_create_action_items(lstr_create_action,ls_module) = 1 then
				lb_set_status = true
			end if
		end if
		//---------------------------- APPEON END ----------------------------
	
		gnv_appeondb.of_startqueue()
		if lb_set_status then
			choose case ls_module
				case "01"
					select t1.notes,t1.due_date,t1.seq_no,t1.rec_id
					into :lstr_create_action.notes,:lstr_create_action.due_date,:lstr_create_action.seq_no,:lstr_create_action.rec_id
					from verif_info t1
					where t1.prac_id = :astr_action.prac_id and t1.facility_id = :astr_action.facility_id and
							t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N';
				case "02"
					//app_id and gp_id, Added by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
					select t1.notes,t1.due_date,t1.seq_no,t1.rec_id
					into :lstr_create_action.notes,:lstr_create_action.due_date,:lstr_create_action.seq_no,:lstr_create_action.rec_id
					from net_dev_action_items t1
					where t1.prac_id = :astr_action.prac_id and t1.facility_id = :astr_action.facility_id and
							(t1.app_id = :astr_action.app_id or (:astr_action.app_id is null and t1.app_id is null)) and 
							(t1.gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and t1.gp_id is null)) and
							t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N';
				case "03"
					select t1.notes,t1.due_date
					into :lstr_create_action.notes,:lstr_create_action.due_date
					from ctx_action_items t1
					where t1.ctx_id = :astr_action.ctx_id and
							t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N';
				case "04"
					select t1.notes,t1.due_date
					into :lstr_create_action.notes,:lstr_create_action.due_date
					from ctx_am_action_item t1
					where t1.doc_id = :astr_action.doc_id and
							t1.wf_id = :ll_set_wf and t1.wf_action_type_id = :ll_set_step and t1.wf_complete_flag = 'N';
			end choose
		end if
		//lstr_create_action.wf_step_status_id = ll_set_status
		//lstr_create_action.wf_id = ll_set_wf
		choose case ls_module
			case "01"
				/*
				update verif_info set response_code = :lstr_create_action.wf_action_status_id
				where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and
						wf_id = :astr_action.wf_id and wf_step = :ll_set_step;
				*/ 
				update verif_info set response_code = :lstr_create_action.wf_action_status_id, mod_date = :ldt_now   ,mod_user ='Sys-WF' //"Sys-WF" (Appeon)Toney 09.29.2013 - V141 ISG-CLX History BugT092901 replace dobule quotation marks with single quotation marks //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
				where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and wf_complete_flag = 'N' and 
						wf_id = :ll_set_wf and wf_action_type_id = :ll_set_step and response_code <> :lstr_create_action.wf_action_status_id;
			case "02"

				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 12.26.2014
				//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue
				
//				update net_dev_action_items set action_status = :lstr_create_action.wf_action_status_id
//				where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and wf_complete_flag = 'N' and 
//						wf_id = :ll_set_wf and wf_action_type_id = :ll_set_step and action_status <> :lstr_create_action.wf_action_status_id;
				ls_sql_old = ids_net_dev_action_items.GetSqlSelect()
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 12.07.2016
				//<$>reason:Bug id 5427 - Workflow not working properly
//				ls_sql_new = ls_sql_old + " where prac_id = " + string(astr_action.prac_id) + " and facility_id = " + string(astr_action.facility_id) + &
//					" and wf_complete_flag = 'N' and " + &
//					" wf_id = " + string(ll_set_wf) + " and wf_action_type_id = " + string(ll_set_step) + " and action_status <> " +  string(lstr_create_action.wf_action_status_id)					
				If IsNull(astr_action.app_id) Then 
					ls_app_id_cond = " and  app_id is null " 
				Else
					ls_app_id_cond = " and  app_id = " + string(astr_action.app_id) 
				End If
				
				If IsNull(astr_action.gp_id) Then 
					ls_gp_id_cond = " and  (gp_id is null)" 
				Else
					ls_gp_id_cond = " and  gp_id = " + string(astr_action.gp_id) 
				End If		
				
				ls_sql_new = ls_sql_old + " where prac_id = " + string(astr_action.prac_id) + " and facility_id = " + string(astr_action.facility_id) + &
						ls_app_id_cond + ls_gp_id_cond + &
						" and wf_complete_flag = 'N' and " + &
						" wf_id = " + string(ll_set_wf) + " and wf_action_type_id = " + string(ll_set_step) + " and action_status <> " +  string(lstr_create_action.wf_action_status_id)
				//------------------- APPEON END -------------------

								
				//ids_net_dev_action_items.SetSqlSelect(ls_sql_new)	
				ls_rtn = ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_new  + '"') //Use 'Modify' for ASA database, added by long.zhang 04.21.2015  (issue:Batch Add process completing action status.)
				If ls_rtn = '' Then
					rtn = ids_net_dev_action_items.Retrieve()
					ls_rtn = ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_old  + '"') //Use 'Modify' for ASA database, added by long.zhang 04.21.2015  (issue:Batch Add process completing action status.)
	
					For ll_row_update = 1 to rtn
						ids_net_dev_action_items.SetItem( ll_row_update, "action_status", lstr_create_action.wf_action_status_id)
					Next
	
					inv_data_entry.of_field_audit( ids_net_dev_action_items, is_err )
					
					rtn = ids_net_dev_action_items.update()
				End If
				//------------------- APPEON END -------------------
			case "03"
				update ctx_action_items set action_status = :lstr_create_action.wf_action_status_id
				where ctx_id = :astr_action.ctx_id and wf_id = :ll_set_wf and wf_action_type_id = :ll_set_step and 
						action_status <> :lstr_create_action.wf_action_status_id and wf_complete_flag = 'N';
			case "04"
				update ctx_am_action_item set action_status = :lstr_create_action.wf_action_status_id
				where doc_id = :astr_action.doc_id and wf_id = :ll_set_wf and wf_action_type_id = :ll_set_step and 
						action_status <> :lstr_create_action.wf_action_status_id  and wf_complete_flag = 'N';
		end choose
		commit;
		gnv_appeondb.of_commitqueue()
		lb_set_status_flag = true
	end if
end if
//---------------------------- APPEON END ---------------------------- 


//Move to step
ll_specify_step = -99
If Not IsNull(ll_to_step ) Then
	ll_find = lds_action_types.find("step_id="+string(astr_action.wf_step_id) , 1 , lds_action_types.RowCount())
	Choose Case ll_to_step
		Case -100 //N/A
			//ll_to_step = astr_action.wf_step_id
		Case -5 					//first
			//Select Top 1 step_id Into :ll_to_step From wf_action_types Where wf_id = :astr_action.wf_id Order By step_order Asc;
			ll_specify_step = lds_action_types.GetItemNumber(1 , "step_id")
		Case -4 //Next
			//Select Top 1 step_id Into :ll_to_step From wf_action_types Where wf_id = :astr_action.wf_id And step_id > :astr_action.wf_step_id Order By step_order Asc;
			If ll_find > 0 and ll_find < lds_action_types.RowCount() Then
				ll_specify_step = lds_action_types.GetItemNumber(ll_find + 1 , 'step_id')
			End If
		Case -3 //Last
			//Select Top 1 step_id Into :ll_to_step From wf_action_types Where wf_id = :astr_action.wf_id  Order By step_order Desc;
			If ll_find > 0 and ll_find < lds_action_types.RowCount() Then
				ll_specify_step = lds_action_types.GetItemNumber(lds_action_types.RowCount() , 'step_id')
			End If
		Case -1 //End Work Flow
			ll_specify_step = -1
		Case Else				//other step
			//Select step_id Into :ll_to_step From wf_action_types Where wf_id = :astr_action.wf_id and step_order = :ll_to_step;
			ll_find = lds_action_types.find("step_order="+string(ll_to_step) , 1 , lds_action_types.RowCount())
			If ll_find > 0  Then
				ll_specify_step = lds_action_types.GetItemNumber(ll_find, 'step_id')
			End If
	End Choose
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.13.2007 By: Jervis
//$<reason> Create the work flow when move to step is not exists
if ll_specify_step > 0 then
	lstr_MoveTo = astr_action
	lstr_MoveTo.wf_step_id = ll_specify_step
	//Call the process of create action item record
	if of_create_action_items(lstr_MoveTo,ls_module) <> 1 then 
		//messagebox("","Failed to create the action item record")
	end if
end if
//---------------------------- APPEON END ----------------------------

//gnv_appeondb.of_startqueue()
//End Work flow
If ll_specify_step = -1 Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 12.01.2006 By: Jervis
	//$<reason> 
	/*
	Choose Case ls_module
		Case "01" 			//01-IntelliCred 
			update verif_info set active_status = -1
				where wf_id = :astr_action.wf_id 
				And prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id;
		Case "02" 			//02-IntelliApp
			update net_dev_action_items set active_status = -1
			where wf_id = :astr_action.wf_id and 
			prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id;
		Case "03"			//03-Contract Logix Tracking
			update ctx_action_items set active_status = -1
			where wf_id = :astr_action.wf_id and ctx_id = :astr_action.ctx_id;
		Case "04"			//04-Contract Logix Agreement 
	End Choose
	*/
	choose case ls_module
		case "01"
			update verif_info set wf_complete_flag = 'Y' ,  mod_date = :ldt_now   ,mod_user = 'Sys-WF'  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
			where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id 
			and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
			
		case "02"
			//add app_id and gp_id, modified by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
			update net_dev_action_items set wf_complete_flag = 'Y'
			where prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id 
			and (app_id = :astr_action.app_id or (:astr_action.app_id is null and app_id is null))  
			and (gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and gp_id is null)) 
			and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
		case "03"
			update ctx_action_items set wf_complete_flag = 'Y'
			where ctx_id = :astr_action.ctx_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
		case "04"
			update ctx_am_action_item set wf_complete_flag = 'Y'
			where doc_id = :astr_action.doc_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
	end choose
	//---------------------------- APPEON END ----------------------------

	destroy lds_action_status
	destroy lds_action_types
	commit;
	//gnv_appeondb.of_commitqueue()
	//return 1
	//02.05.2007 By Jervis
	If ls_update_header_flag = "Y" And ls_module = "04" Then
		return 2
	else
		Return 1
	end if
	
End If
	
//Move the specify step
If ll_specify_step  > 0 Then
	Choose Case ls_module
		Case "01" 			//01-IntelliCred 
			update verif_info set active_status = 1 ,  mod_date = :ldt_now   ,mod_user = 'Sys-WF'  //,response_code = :ll_init_status_id  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
				where wf_id = :astr_action.wf_id and wf_action_type_id = :ll_specify_step 
				and prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and wf_complete_flag = 'N';
		Case "02" 			//02-IntelliApp
			//add app_id and gp_id, modified by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
			update net_dev_action_items set active_status = 1//,action_status = :ll_init_status_id
			where wf_id = :astr_action.wf_id and wf_action_type_id = :ll_specify_step and 
			(app_id = :astr_action.app_id or (:astr_action.app_id is null and app_id is null))  and
			(gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and gp_id is null)) and
			prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and wf_complete_flag = 'N';
		Case "03"			//03-Contract Logix Tracking
			update ctx_action_items set active_status = 1
			where wf_id = :astr_action.wf_id and wf_action_type_id = :ll_specify_step and
				ctx_id = :astr_action.ctx_id and wf_complete_flag = 'N';
		Case "04"			//04-Contract Logix Agreement 
			update ctx_am_action_item set active_status = 1
			where wf_id = :astr_action.wf_id and wf_action_type_id = :ll_specify_step and
				doc_id = :astr_action.doc_id and wf_complete_flag = 'N';
	End Choose
	lb_update = true
End if
//End If

//don't find the special step
//if ll_specify_step = -99 then return 0


If lb_update Then
	/*
	//The status of current action item recoed will be set to inactive
	Choose Case ls_module
		Case "01" 			//01-IntelliCred 
			update verif_info set active_status = -1
			where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and
					facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;

		Case "02" 			//02-IntelliApp
			update net_dev_action_items set active_status = -1
			where rec_id = :astr_action.rec_id;
		Case "03"			//03-Contract Logix Tracking
			update ctx_action_items set active_status = -1
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
		Case "04"			//04-Contract Logix Agreement 
	End Choose
	*/
	//12.14.2006 By Jervis
	//The status of current action item record will be set to complete
	Choose Case ls_module
		Case "01" 			//01-IntelliCred 
			update verif_info set wf_complete_flag = 'Y' ,  mod_date = :ldt_now   ,mod_user = 'Sys-WF' //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
			where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id and
					facility_id = :astr_action.facility_id and seq_no = :astr_action.seq_no;

		Case "02" 			//02-IntelliApp
			update net_dev_action_items set wf_complete_flag = 'Y'
			where rec_id = :astr_action.rec_id;
		Case "03"			//03-Contract Logix Tracking
			update ctx_action_items set wf_complete_flag = 'Y'
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
		Case "04"			//04-Contract Logix Agreement 
			update ctx_am_action_item set wf_complete_flag = 'Y'
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
	End Choose
End If

commit;
//gnv_appeondb.of_commitqueue()

//12.27.2006 By Jervis
if lb_set_status_flag then
	of_status_changed(lstr_create_action)
end if

destroy lds_action_status
destroy lds_action_types

SetPointer(Arrow!)

//02.05.2007 By Jervis
If ls_update_header_flag = "Y" And ls_module = "04" Then
	return 2
else
	Return 1
end if



end function

public function integer of_create_action_items (str_action_item astr_action, string as_module);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_create_action_items
//
//	Arguments:  
//	
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
string ls_wf_name,ls_create_user_flag,ls_by_user,ls_weekend_flag,ls_to_user,ls_dept_chair_flag
long ll_rec_id,ll_step_order,ll_due_days,ll_action_type_id,ll_step_status_id,ll_action_status_id,ll_letter_id
Long ll_seq_no,li_count
date ld_due_days,ld_today
string ls_doc_id,ls_error
long ll_findrow
long ll_process_flag = 0
long ll_Identity		//02.06.2009 By Jervis
long ll_new_row
Boolean 		lb_autocommit

//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
datetime ldt_createdate //add Michael 06.24.2011 V11.3 Action Item Dates
ldt_createdate = datetime(today(),now())//add Michael 06.24.2011 V11.3 Action Item Dates
//---------End Modfiied ------------------------------------------------------
String ls_StatusDesc //(Appeon)Harry 09.22.2014 - for Bug # 4230

//Action Item have been created
choose case as_module
	case "01"
		select 1 into :li_count from verif_info 
		where wf_id = :astr_action.wf_id and wf_action_type_id = :astr_action.wf_step_id 
				and prac_id = :astr_action.prac_id 
				and facility_id = :astr_action.facility_id
				and wf_complete_flag = 'N';
	case "02"
		//add app_id and gp_id, modified by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
		select 1 into :li_count from net_dev_action_items
		where wf_id = :astr_action.wf_id and wf_action_type_id = :astr_action.wf_step_id and
				prac_id = :astr_action.prac_id and facility_id = :astr_action.facility_id and
				(app_id = :astr_action.app_id or (:astr_action.app_id is null and app_id is null)) and 
				(gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and gp_id is null ))
				and wf_complete_flag = 'N';
				//and active_status = 1;
	case "03"
		select 1 into :li_count from ctx_action_items
		where wf_id = :astr_action.wf_id and wf_action_type_id = :astr_action.wf_step_id and
				ctx_id = :astr_action.ctx_id 
				//and active_status = 1;
				and wf_complete_flag = 'N';
	case "04"
		select 1 into :li_count from ctx_am_action_item
		where wf_id = :astr_action.wf_id and wf_action_type_id = :astr_action.wf_step_id and
				doc_id = :astr_action.doc_id 
				//and active_status = 1;
				and wf_complete_flag = 'N';
end choose

if li_count > 0 then return 1

ls_wf_name = gnv_data.of_getitem("wf_workflow","wf_name","wf_id="+string(astr_action.wf_id))

//gnv_appeondb.of_startqueue()

//IntelliCred
if as_module = "01" then
	SELECT Max( verif_info.seq_no) into :ll_seq_no FROM verif_info  
	  	Where verif_info.wf_id =  :astr_action.wf_id and  verif_info.prac_id =:astr_action.prac_id 
		  AND  verif_info.facility_id = :astr_action.facility_id ;
end if

//Get Action Type Information
ll_findrow = gnv_data.of_findrow("wf_action_types","wf_id="+string(astr_action.wf_id) + " and step_id="+string(astr_action.wf_step_id))
if ll_findrow > 0 then
	ll_step_order 			= long(gnv_data.of_getitem("wf_action_types", ll_findrow,"step_order"  ))
	ls_create_user_flag 	= gnv_data.of_getitem("wf_action_types", ll_findrow,"create_user_flag" )
	ls_by_user				= gnv_data.of_getitem("wf_action_types", ll_findrow,"by_user"  )
	ll_due_days 			= long(gnv_data.of_getitem("wf_action_types", ll_findrow,"due_days" ))
	ls_weekend_flag 		= gnv_data.of_getitem("wf_action_types", ll_findrow,"weekend_flag" )
	ls_to_user 				= gnv_data.of_getitem("wf_action_types", ll_findrow,"to_user" )
	ls_dept_chair_flag 	= gnv_data.of_getitem("wf_action_types", ll_findrow,"dept_chair_flag")
	ll_action_type_id 	= long(gnv_data.of_getitem("wf_action_types", ll_findrow,"action_type_id"))
else
	Return 1				//Added by Scofield on 2008-12-10
end if

//Get Action Status Information
ll_findrow = gnv_data.of_findrow("wf_action_status","wf_id="+string(astr_action.wf_id) + " and step_id="+string(astr_action.wf_step_id) + " and initial_flag = 'Y'")
if ll_findrow > 0 then
	ll_step_status_id   = long(gnv_data.of_getitem("wf_action_status",ll_findrow, "status_id"))
	ll_action_status_id = long(gnv_data.of_getitem("wf_action_status", ll_findrow,"action_status_id"))
	ll_letter_id = long(gnv_data.of_getitem("wf_action_status", ll_findrow,"letter_id" ))
	ls_StatusDesc = gnv_data.of_getitem("wf_action_status", ll_findrow,"action_status_desc" )   //(Appeon)Harry 09.22.2014 - for Bug # 4230
	
	ll_process_flag = long(gnv_data.of_getitem("wf_action_status", ll_findrow,"process_flag" ))
	If ll_process_flag <> 1 Then ll_process_flag = 0
else
	Return 1				//Added by Scofield on 2008-12-10
end if

if (as_module = "01" or as_module = "02" ) then
	ll_rec_id = gnv_app.of_get_id("RECORD_ID")
	If isnull(ll_seq_no) Then 
		ll_seq_no = 1
	else
		ll_seq_no++
	end if
	if isnull(ll_rec_id) then ll_rec_id = 1
	
	if ls_dept_chair_flag = "Y" then
		ls_to_user = astr_action.dept_chair
	end if
end if

if ls_create_user_flag = "Y" then
	ls_by_user = gs_user_id
end if
ld_due_days = of_daysafter(today(),ll_due_days,ls_weekend_flag)
//Added By Mark Lee 06/25/12
//gnv_appeondb.of_autocommitrollback( )
lb_autocommit = sqlca.autocommit					//Added By Mark Lee 08/28/12	 This is cann't autocommit transaction
SQLCA.AutoCommit=false

//12.6.2006 By Jervis
astr_action.module = as_module  		//Use By of_get_userid

ls_to_user = of_get_userid(astr_action,ls_to_user)
ls_by_user = of_get_userid(astr_action,ls_by_user)

choose case as_module
	case "01"		//IntelliCred
		//ls_to_user = of_get_userid(astr_action,ls_to_user)
		//ls_by_user = of_get_userid(astr_action,ls_by_user)
		ls_doc_id = String( astr_action.rec_id ) + "-" + String( astr_action.prac_id ) + "-" + String( astr_action.facility_id ) +  "-" + String( ll_seq_no )
		insert into verif_info(
						wf_id,
						wf_action_type_id,
						active_status,
						user_name,
						wf_step,
						due_date,
						priority_user,
						verification_method,
						response_code,
						rec_id,
						prac_id,
						facility_id,
						seq_no,
						screen_id,
						reference_value,
						priority,
						print_flag,
						number_sent,
						doc_id,
						letter_id,
						wf_complete_flag,
						create_date,
						create_user		)
		values (	:astr_action.wf_id,
					:astr_action.wf_step_id,
					-1,
					:ls_by_user,
					:ll_step_order,
					:ld_due_days,
					:ls_to_user,
					:ll_action_type_id,
					:ll_action_status_id,
					//:astr_action.rec_id, //12.22.2006 By Jervis Fixed a defect
					:ll_rec_id,
					:astr_action.prac_id,
					:astr_action.facility_id,
					:ll_seq_no,
					-10,
					:ls_wf_name,
					1,
					:ll_process_flag,
					0,
					:ls_doc_id,
					:ll_letter_id,
					'N',
					:ldt_createdate, //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
					'Sys-WF');//long.zhang 04.17.2013 //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
	case "02"		//IntelliApp
		//ls_to_user = of_get_userid(astr_action,ls_to_user)
		//ls_by_user = of_get_userid(astr_action,ls_by_user)
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 12.26.2014
		//<$>reason:Modified by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
		/*
		insert into net_dev_action_items(
						wf_id,
						wf_action_type_id,
						active_status,
						wf_assigned_by,
						wf_step,
						due_date,
						action_user,
						action_type,
						action_status,
						rec_id,
						prac_id,
						facility_id,
						seq_no,
						letter_id,
						wf_complete_flag,
						number_sent,
						create_date,//add Michael 06.24.2011 V11.3 Action Item Dates //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
						create_user, //add Michael 06.24.2011 V11.3 Action Item Dates //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
						gp_id,
						app_id,
						print_flag)		
		values (	:astr_action.wf_id,
					:astr_action.wf_step_id,
					-1,
					:ls_by_user,
					:ll_step_order,
					:ld_due_days,
					:ls_to_user,
					:ll_action_type_id,
					:ll_action_status_id,
					:ll_rec_id,
					:astr_action.prac_id,
					:astr_action.facility_id,
					:ll_rec_id,
					:ll_letter_id,
					'N',
					0,
					:ldt_createdate,//add Michael 06.24.2011 V11.3 Action Item Dates //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
					'Sys-WF',	//long.zhang 04.17.2013 //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
					:astr_action.gp_id,   //(Appeon)Harry 11.14.2014 - 14.2 Bug fix for Workflow
					:astr_action.app_id,   //(Appeon)Harry 11.14.2014 - 14.2 Bug fix for Workflow
					:ll_process_flag);
			*/
		ids_net_dev_action_items.reset()
		ll_new_row = ids_net_dev_action_items.InsertRow(0)
		
		ids_net_dev_action_items.SetItem( ll_new_row, "wf_id", astr_action.wf_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "wf_action_type_id", astr_action.wf_step_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "active_status", -1)
		ids_net_dev_action_items.SetItem( ll_new_row, "wf_assigned_by", ls_by_user)
		ids_net_dev_action_items.SetItem( ll_new_row, "wf_step", ll_step_order)
		ids_net_dev_action_items.SetItem( ll_new_row, "due_date", ld_due_days)
		ids_net_dev_action_items.SetItem( ll_new_row, "action_user", ls_to_user)
		ids_net_dev_action_items.SetItem( ll_new_row, "action_type", ll_action_type_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "action_status", ll_action_status_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "rec_id", ll_rec_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "prac_id", astr_action.prac_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "facility_id", astr_action.facility_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "seq_no", ll_rec_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "letter_id", ll_letter_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "wf_complete_flag", 'N')
		ids_net_dev_action_items.SetItem( ll_new_row, "number_sent", 0)
		ids_net_dev_action_items.SetItem( ll_new_row, "create_date", ldt_createdate)
		ids_net_dev_action_items.SetItem( ll_new_row, "create_user", 'Sys-WF')
		ids_net_dev_action_items.SetItem( ll_new_row, "gp_id", astr_action.gp_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "app_id", astr_action.app_id)
		ids_net_dev_action_items.SetItem( ll_new_row, "track_id", astr_action.track_id)//Added by Appeon long.zhang 12.05.2016 (Bug id 5427 - Workflow not working properly)
		ids_net_dev_action_items.SetItem( ll_new_row, "print_flag", ll_process_flag)
			
		inv_data_entry.of_field_audit( ids_net_dev_action_items,is_err )
		
		ids_net_dev_action_items.update()	
		//------------------- APPEON END -------------------
	case "03"
		//04-12-2006 by Jervis
		//Get user ID from Owner
		//ls_to_user = of_get_userid(astr_action,ls_to_user)
		//ls_by_user = of_get_userid(astr_action,ls_by_user)
		
		//12.12.2006 By Jervis
		//Set the defaule value of inserted_at_date_time and action_date
		ld_today = today()
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 06.08.2007 By: Jack
		//$<reason> Fix a defect.
		long ll_letter_from,ll_letter_to
		ll_letter_from = f_get_contact_id(astr_action.ctx_id,'I')
		ll_letter_to = f_get_contact_id(astr_action.ctx_id,'E')
		
		//---------------------------- APPEON END ----------------------------
		
		insert into ctx_action_items(
						wf_id,
						wf_action_type_id,
						active_status,
						wf_assigned_by,
						wf_step,
						due_date,
						action_user,
						action_type,
						action_status,
						ctx_id,
						letter_id,
						wf_complete_flag,
						print_flag,
						no_attempts,
						action_date,
						inserted_at_date_time,
						letter_from,  //Add by Jack 06/08/2007
						letter_to,	  //Add by Jack 06/08/2007
						subject  //(Appeon)Harry 09.22.2014 - for Bug # 4230
						)		
		values (	:astr_action.wf_id,
					:astr_action.wf_step_id,
					-1,
					:ls_by_user,
					:ll_step_order,
					:ld_due_days,
					:ls_to_user,
					:ll_action_type_id,
					:ll_action_status_id,
					:astr_action.ctx_id,
					:ll_letter_id,
					'N',
					:ll_process_flag,
					0,
					:ld_today,
					:ld_today,
					:ll_letter_from,   //Add by Jack 06/08/2007
					:ll_letter_to,      //Add by Jack 06/08/2007
					:ls_StatusDesc //(Appeon)Harry 09.22.2014 - for Bug # 4230
					);
	case "04"
		//Get user ID from Owner
		//ls_to_user = of_get_userid(astr_action,ls_to_user)
		//ls_by_user = of_get_userid(astr_action,ls_by_user)
		
		ld_today = today()
		
		insert into ctx_am_action_item(
						wf_id,
						wf_action_type_id,
						active_status,
						wf_assigned_by,
						wf_step,
						due_date,
						action_order,
						action_user,
						action_type,
						action_status,
						doc_id,
						letter_id,
						wf_complete_flag,
						print_flag,
						Attempt_Times,
						status_date,
						create_date,
						subject  //(Appeon)Harry 09.22.2014 - for Bug # 4230
						)		
		values (	:astr_action.wf_id,
					:astr_action.wf_step_id,
					-1,
					:ls_by_user,
					:ll_step_order,
					:ld_due_days,
					:ll_step_order,
					:ls_to_user,
					:ll_action_type_id,
					:ll_action_status_id,
					:astr_action.doc_id,
					:ll_letter_id,
					'N',
					:ll_process_flag,
					0,
					:ld_today,
					:ld_today,
					:ls_StatusDesc //(Appeon)Harry 09.22.2014 - for Bug # 4230
					);
end choose

//Start Code By Jervis 02.06.2009 
//Start Code Change ----12.09.2016 #V153 maha - only use if contract (failure in ASA)
choose case as_module
	case "03","04"
		//Get Identity value
		select scope_identity() into :ll_Identity from ids;
		//End Code
end Choose
//End Code Change ----12.09.2016		
		
if sqlca.sqlcode <> 0 then
	ls_error = sqlca.sqlerrtext
	rollback;
	sqlca.autocommit	 = lb_autocommit				//Added By Mark Lee 08/28/12
	messagebox("Message","Failed to create Action Item Record for step." + "~r~n" + ls_error)
	return -1
else
	commit;
end if
	
sqlca.autocommit	 = lb_autocommit				//Added By Mark Lee 08/28/12


//Added By Ken.Guo 09/26/2012. Support Add sub contracts for USband Customer.
Long ll_ai_id
If astr_action.wf_id > 0 and as_module = '03' Then
	This.of_create_sub_contracts(astr_action.ctx_id, ll_Identity)
End If


//Adding for send initial email
astr_action.wf_step_status_id = ll_step_status_id
//return of_send_mail(astr_action,1) -- jervis 04.10.2009
of_send_mail(astr_action,1)

//Start Cod By Jervis 02.06.2009
//Trigger the action from Action Status in work flow
choose case as_module
	case '01'
		//IntelliCred
	case '02'
		//IntelliApp
	case '03'
		//Contract Logix
		astr_action.ctx_action_item_id = ll_Identity
	case '04'
		//DocumetManager
		astr_action.seq_no = ll_Identity
		//astr_action.ctx_id = ??
end choose

astr_action.wf_action_status_id = ll_action_status_id
//astr_action.wf_action_type_id = ll_action_type_id
astr_action.notes = ""
  
of_status_changed(astr_action)
return 1
//End code

end function

public function integer of_workflow_create_action_items (str_action_item astr_action);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_workflow_create_action_items
//
//	Arguments:  
//	   str_action_item:
//			wf_id
//			rec_id
//			prac_id
//			facility_id
//			screen_id
//			{
//			ctx_id
//			ctx_action_item_id
//			}
//			{
//			doc_id
//			}
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
datastore lds_action_status 
n_ds lds_verif_action   //12.12.2016 maha -changed from datastore for auditing
Datastore lds_action_types
Date		ld_duedate
String	ls_wf_name
long		ll_ins , i , ll_TypesCnt , ll_find
Long	ll_seq_no 
Integer	li_duedate,li_suppress_alert
String	ls_prompt_falg , ls_prompt_msg
long		ll_status , ll_rec_id,ll_letter_id,ll_step_status_id 
long		ll_process_flag = 0
String 	ls_doc_id,ls_module,ls_StatusDesc
long 		ll_init_step = 0	//03.17.2008 By Jervis Add
string 	ls_wf_status
boolean lb_do

lb_do = false //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
str_action_item lstr_action

//Only trigger status = Active - jervis 11.03.2010
ls_wf_status = gnv_data.of_getitem("wf_workflow" , 'wf_status' , 'wf_id=' + string(astr_action.wf_id))
if Upper(ls_wf_status) <> 'A' then return 0

SetPointer(HourGlass!)
ls_module = gnv_data.of_getitem("wf_workflow" , 'wf_module' , 'wf_id=' + string(astr_action.wf_id))
//PT-001 06.25.2007 By Jervis
ls_wf_name = gnv_data.of_getitem("wf_workflow" , 'wf_name' , 'wf_id=' + string(astr_action.wf_id))

//Added By Ken 08/20/2011. 
li_suppress_alert = Integer(gnv_data.of_getitem("wf_workflow" , 'suppress_alert' , 'wf_id=' + string(astr_action.wf_id)))

//12.6.2006 By Jervis
astr_action.module = ls_module		//Use By of_get_userid

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Jervis
//$<reason> Can't Create Work Flow When The Work Flow has been created and don't end.
string ls_message
choose case ls_module
	case "01"  //(Appeon)Stephen 12.16.2013 - add 'active_status =1' not count any historical verifications
		select count(*) into :i from verif_info where prac_id = :astr_action.prac_id 
			and facility_id = :astr_action.facility_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N' and active_status =1 ;
		ls_message = "~r~nPrac ID:" + string(astr_action.prac_id) +"~r~nFacility ID:" + string(astr_action.facility_id)
	case "02"
//Start Code Change ----12.06.2016 #V153 maha- modifed to be app and gp id based as well as prac/facility		
//		select count(*) into :i from net_dev_action_items where prac_id = :astr_action.prac_id 
//			and facility_id = :astr_action.facility_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
//			ls_message = "~r~nPrac ID:" + string(astr_action.prac_id) +"~r~nFacility ID:" + string(astr_action.facility_id)
		select count(*) into :i from net_dev_action_items where prac_id = :astr_action.prac_id 
			and facility_id = :astr_action.facility_id 
			and (app_id = :astr_action.app_id or (:astr_action.app_id is null and app_id is null )) 
			and (gp_id = :astr_action.gp_id or (:astr_action.gp_id is null and gp_id is null )) 
			and wf_id = :astr_action.wf_id and wf_complete_flag = 'N'; //add 'is null' for app_id and gp_id, Added by Appeon long.zhang 12.07.2016 (Bug id 5427 - Workflow not working properly)
			ls_message = "~r~nPrac ID:" + string(astr_action.prac_id) +"~r~nFacility ID:" + string(astr_action.facility_id) 
			
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 12.07.2016
			//<$>reason:Bug id 5427 - Workflow not working properly
			//ls_message +=	"~r~nApp ID:" + string(astr_action.app_id) +"~r~nGp ID:" + string(astr_action.gp_id)
			If IsNull(astr_action.app_id) Then
				ls_message += "~r~nApp ID:NULL"
			Else
				ls_message +=	"~r~nApp ID:" + string(astr_action.app_id)
			End If
			
			If IsNull(astr_action.gp_id) Then
				ls_message += "~r~nGp ID:NULL"
			Else
				ls_message +=	"~r~nGp ID:" + string(astr_action.gp_id)
			End If
			//------------------- APPEON END -------------------			

//End Code Change ----12.06.2016
	case "03"
		select count(*) into :i from ctx_action_items where ctx_id = :astr_action.ctx_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
		ls_message = "~r~nCTX ID:" + string(astr_action.ctx_id)
	case "04"
		select count(*) into :i from ctx_am_action_item where doc_id = :astr_action.doc_id and wf_id = :astr_action.wf_id and wf_complete_flag = 'N';
		ls_message = "~r~nCTX ID:" + string(astr_action.ctx_id)
		il_doc_id = astr_action.doc_id			//Added by Scofield on 2009-07-23
end choose

if i > 0 and of_get_message() then
	if isnull(ls_message) then ls_message = ""
	//Start Code Change ---- 10.17.2007 #V7 maha removed message do not readd
//	If (li_suppress_alert = 0 or isnull(li_suppress_alert)) and (ls_module = '03' or ls_module = '04')  Then //Added By Ken 08/20/2011. Added if statement  //(Appeon)Harry 06.24.2013 - V141 ISG-CLX
		MessageBox("Work Flow Creation","Failed to create Work Flow of " + ls_wf_name +", as the same Work Flow already exists and is not closed." +ls_message) //jervis 01.08.2009
//	End If
	return -1
end if
//---------------------------- APPEON END ----------------------------

lds_verif_action = Create n_ds // 12.12.2016 - maha - changed fromm datastore
choose case ls_module
	case "01"		//IntelliCred
		lds_verif_action.dataobject = 'd_wf_verif_action_adding'
	case "02"		//IntelliApp
		lds_verif_action.dataobject = 'd_wf_verif_action_adding_net'
	case "03"		//Contract Logix Contract Tracking
		lds_verif_action.dataobject = 'd_wf_ctx_action_adding'
	case "04"		//Contract Logix Agreement manager
		lds_verif_action.dataobject = 'd_wf_ctx_am_action_adding'
	case else
		return -1
end choose
lds_verif_action.settransobject(SQLCA)

lds_action_types = Create datastore
lds_action_types.dataobject = 'd_g_action_types_data'
lds_action_types.settransobject( SQLCA)

lds_action_status = Create DataStore
lds_action_status.dataobject = 'd_g_action_status_data'
lds_action_status.settransobject(SQLCA)

//Get the Work flow items from the cache data
gnv_data.of_get_data_from_cache('wf_action_types', 'wf_id=' + string(astr_action.wf_id) , lds_action_types)
lds_action_types.SetSort("step_order")
lds_action_types.Sort()

if lds_action_types.RowCount( )> 0 then ll_init_step = lds_action_types.GetItemNumber(1 , 'step_order')	//03.17.2008 By Jervis:Get frist step for workflow
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.07.2006 By: Jervis
//$<reason> 
lds_action_types.SetFilter( 'wf_id=' + string(astr_action.wf_id) + " and create_flag = 'Y'")
lds_action_types.Filter()
//---------------------------- APPEON END ----------------------------

gnv_data.of_get_data_from_cache('wf_action_status', 'wf_id=' + string(astr_action.wf_id) , lds_action_status)
//move to PT-001 06.25.2007 By Jervis
//ls_wf_name = gnv_data.of_getitem("wf_workflow" , 'wf_name' , 'wf_id=' + string(astr_action.wf_id))
ls_prompt_falg = gnv_data.of_getitem("wf_workflow" , 'wf_prompt_falg' , 'wf_id=' + string(astr_action.wf_id))
ls_prompt_msg = gnv_data.of_getitem("wf_workflow" , 'wf_prompt_message' , 'wf_id=' + string(astr_action.wf_id))

//Start Code Change ----07.19.2017 #V154 maha
//if ls_module = "01" or ls_module = "02" then
//	//Get the department chairperson for the selected practitioner
//	select top 1 dept_chair.user_id into: is_dept_chairperson from pd_affil_dept,dept_chair
//		where pd_affil_dept.facility_id = dept_chair.facility_id 
//		and pd_affil_dept.department = dept_chair.department_code
//		and pd_affil_dept.facility_id  = :astr_action.facility_id and pd_affil_dept.prac_id = :astr_action.prac_id 
//		and pd_affil_dept.active_status = 1 and pd_affil_dept.primary_dept = 1;
//end if

Integer li_ret
If ls_prompt_falg = 'Y' and of_get_message() Then	//08.28.2007
	//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
	if  ls_module ='01' or ls_module = '02' then
		//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		if not gb_autoschedule and not ib_schedule then //alfee 03.11.2010
			If Messagebox("Confirm Work Flow Creation" , ls_prompt_msg , Question!, YesNo!) = 2 Then return 0
		end if	
	else
		//Begin - Modified By Ken.Guo 2010-06-28
		//If Messagebox("Confirm Work Flow Creating" , ls_prompt_msg , Question!, YesNo!) = 2 Then return 0
		If gnv_workflow_prompt.of_get_wf_prompt(astr_action.wf_id) Then
			li_ret = Messagebox("Confirm Work Flow Creation" , ls_prompt_msg , Question!, YesNo!) 
			If li_ret = 1 Then
				gnv_workflow_prompt.of_set_wf_trigger(astr_action.wf_id, True)
			Else
				gnv_workflow_prompt.of_set_wf_trigger(astr_action.wf_id, False)
				Return 0
			End If			
		Else
			If Not gnv_workflow_prompt.of_get_wf_trigger(astr_action.wf_id) Then
				Return 0
			End If
		End If
		//End - Modified By Ken.Guo 2010-06-28
	end if
	//---------End Modfiied ------------------------------------------------------
End If
//
ll_TypesCnt = lds_action_types.Rowcount( )
If isnull(ll_seq_no) Then ll_seq_no = 0

//In IntelliApp, Get the id's for all action items
choose case ls_module
	case "01"	//IntelliCred
		ll_rec_id = gnv_app.of_get_id("RECORD_ID", ll_TypesCnt)
		
		For i = 1 To ll_TypesCnt
			ll_ins = lds_verif_action.insertrow(0)
			lds_verif_action.SetItem( ll_ins, 'wf_id' , astr_action.wf_id)
			lds_verif_action.SetItem( ll_ins, 'wf_action_type_id' , lds_action_types.GetItemNumber(i , 'step_id'))
		
			//Set the active status value
			//If lds_action_types.GetItemNumber(i , 'step_order') <> 0 Then
			If lds_action_types.GetItemNumber(i , 'step_order') <> ll_init_step Then //03.17.2008 By Jervis
				lds_verif_action.SetItem( ll_ins, 'active_status' , -1)
			Else
				lds_verif_action.SetItem( ll_ins, 'active_status' , 1)
			End If
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'create_user_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'user_name' , gs_user_id)
			Else
				lds_verif_action.SetItem( ll_ins, 'user_name' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'by_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'wf_step' , lds_action_types.GetItemNumber(i , 'step_order'))
			
			//Calculate the due date
			ld_duedate = of_daysafter(today(),lds_action_types.GetItemNumber(i , 'due_days'),lds_action_types.GetItemString(i , 'weekend_flag'))
			//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
			//lds_verif_action.SetItem( ll_ins, 'due_date' , ld_duedate)
			lds_verif_action.SetItem( ll_ins, 'due_date' , Date(ld_duedate))
			//---------End Modfiied ------------------------------------------------------
			//Set the user name value
			If lds_action_types.GetItemString(i , 'dept_chair_flag') = 'Y' Then
				//Start Code Change ----07.19.2017 #V154 maha - moved from above
				if lb_do = false then //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
					select top 1 dept_chair.user_id into: is_dept_chairperson from pd_affil_dept,dept_chair
						where pd_affil_dept.facility_id = dept_chair.facility_id 
						and pd_affil_dept.department = dept_chair.department_code
						and pd_affil_dept.facility_id  = :astr_action.facility_id and pd_affil_dept.prac_id = :astr_action.prac_id 
						and pd_affil_dept.active_status = 1 and pd_affil_dept.primary_dept = 1;
						lb_do = true
				end if
				lds_verif_action.SetItem( ll_ins, 'priority_user' , is_dept_chairperson)
			Else
				lds_verif_action.SetItem( ll_ins, 'priority_user' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'to_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'verification_method' , lds_action_types.GetItemnumber(i , 'action_type_id'))
			
			//Get the initial action status
			lds_action_status.SetFilter("step_id = " + string(lds_action_types.GetItemnumber(i , 'step_id')))
			lds_action_status.filter( )
			ll_find = lds_action_status.find("initial_flag='Y'" ,1, lds_action_status.Rowcount())
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 11.15.2006 By: Jervis
			//$<reason> 
			/*
			If ll_find > 0 Then
				ll_status = lds_action_status.GetItemnumber( ll_find, 'action_status_id')
			End If
			lds_verif_action.SetItem( ll_ins, 'response_code' , ll_status)
			*/
			If ll_find > 0 Then
				ll_status = lds_action_status.GetItemnumber( ll_find, 'action_status_id')
				ll_letter_id = lds_action_status.GetItemnumber( ll_find, 'letter_id')
				ll_step_status_id = lds_action_status.GetItemnumber( ll_find, 'status_id')
				ll_process_flag =  lds_action_status.GetItemnumber( ll_find, 'process_flag')
				If ll_process_flag <> 1 Then ll_process_flag = 0
			End If
			lds_verif_action.SetItem( ll_ins, 'response_code' , ll_status)
			lds_verif_action.SetItem( ll_ins, 'letter_id' , ll_letter_id)
			//---------------------------- APPEON END ----------------------------
				
			ll_seq_no++
			//12.20.2006 By Jervis ,move to down
			//ll_rec_id++   
			

			lds_verif_action.SetItem( ll_ins, 'rec_id' , ll_rec_id)
			lds_verif_action.SetItem( ll_ins, 'prac_id' , astr_action.prac_id)
			lds_verif_action.SetItem( ll_ins, 'facility_id' , astr_action.facility_id)
			lds_verif_action.SetItem( ll_ins, 'seq_no' , ll_seq_no)
			lds_verif_action.SetItem( ll_ins, 'screen_id' , astr_action.screen_id)
			lds_verif_action.SetItem( ll_ins, 'reference_value' , ls_wf_name)
			lds_verif_action.SetItem( ll_ins, 'priority' , 1)
			lds_verif_action.SetItem( ll_ins, 'print_flag' , ll_process_flag)
			lds_verif_action.SetItem( ll_ins, 'number_sent' , 0)
			lds_verif_action.SetItem( ll_ins, 'wf_complete_flag' , 'N')
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			//Start Code Change ----08.04.2011 #V11 maha -  create/mod dates
			lds_verif_action.SetItem( ll_ins, 'create_date' , datetime(today(),now())) 
			lds_verif_action.SetItem( ll_ins, 'create_user' , "Sys-WF") 
			//End Code Change ----08.04.2011
			//---------End Modfiied ------------------------------------------------------

			ls_doc_id = String( ll_rec_id ) + "-" + String( astr_action.prac_id ) + "-" + String( astr_action.facility_id ) +  "-" + String( ll_seq_no )
			lds_verif_action.SetItem( ll_ins, 'doc_id' , ls_doc_id)
			
			ll_rec_id++
		Next
	case "02"	//IntelliApp
		ll_rec_id = gnv_app.of_Get_Id("RECORD_ID" , ll_TypesCnt)
	
		For i = 1 To ll_TypesCnt
			ll_ins = lds_verif_action.insertrow(0)
			lds_verif_action.SetItem( ll_ins, 'wf_id' , astr_action.wf_id)
			lds_verif_action.SetItem( ll_ins, 'wf_action_type_id' , lds_action_types.GetItemNumber(i , 'step_id'))
		
			//Set the active status value
			//If lds_action_types.GetItemNumber(i , 'step_order') <> 0 Then
			If lds_action_types.GetItemNumber(i , 'step_order') <> ll_init_step Then //03.17.2008 By Jervis
				lds_verif_action.SetItem( ll_ins, 'active_status' , 1)   // -1)
			Else
				lds_verif_action.SetItem( ll_ins, 'active_status' , 1)
			End If
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'create_user_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , gs_user_id)
			Else
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'by_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'wf_step' , lds_action_types.GetItemNumber(i , 'step_order'))
			
			//Calculate the due date
			ld_duedate = of_daysafter(today(),lds_action_types.GetItemNumber(i , 'due_days'),lds_action_types.GetItemString(i , 'weekend_flag'))
			//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
			//lds_verif_action.SetItem( ll_ins, 'due_date' , ld_duedate)
			lds_verif_action.SetItem( ll_ins, 'due_date' , Date(ld_duedate))
			//---------End Modfiied ------------------------------------------------------
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'dept_chair_flag') = 'Y' Then
				//Start Code Change ----07.19.2017 #V154 maha - moved from above
				if lb_do = false then //(Appeon)Stephen 07.21.2017 - Critical performance issue with workflow action completion
					select top 1 dept_chair.user_id into: is_dept_chairperson from pd_affil_dept,dept_chair
						where pd_affil_dept.facility_id = dept_chair.facility_id 
						and pd_affil_dept.department = dept_chair.department_code
						and pd_affil_dept.facility_id  = :astr_action.facility_id and pd_affil_dept.prac_id = :astr_action.prac_id 
						and pd_affil_dept.active_status = 1 and pd_affil_dept.primary_dept = 1;
						lb_do = true
				end if
				lds_verif_action.SetItem( ll_ins, 'action_user' , is_dept_chairperson)
			Else
				lds_verif_action.SetItem( ll_ins, 'action_user' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'to_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'action_type' , lds_action_types.GetItemnumber(i , 'action_type_id'))
			
			//Get the initial action status
			lds_action_status.SetFilter("step_id = " + string(lds_action_types.GetItemnumber(i , 'step_id')))
			lds_action_status.filter( )
			ll_find = lds_action_status.find("initial_flag='Y'" ,1, lds_action_status.Rowcount())
			
			If ll_find > 0 Then
				ll_status = lds_action_status.GetItemnumber( ll_find, 'action_status_id')
				ll_letter_id = lds_action_status.GetItemnumber( ll_find, 'letter_id')
				ll_step_status_id = lds_action_status.GetItemnumber( ll_find, 'status_id')
				ll_process_flag =  lds_action_status.GetItemnumber( ll_find, 'process_flag')
				If ll_process_flag <> 1 Then ll_process_flag = 0
			End If
			
			lds_verif_action.SetItem( ll_ins, 'action_status' , ll_status)
			
			//Set the letter ID
			lds_verif_action.SetItem(ll_ins,"letter_id",ll_letter_id)
			//---------------------------- APPEON END ----------------------------
			
			debugbreak()
			ll_seq_no++  //12.20.2006 By Jervis Fixed a defect
			//
			lds_verif_action.SetItem( ll_ins, 'rec_id' , ll_rec_id)
			lds_verif_action.SetItem( ll_ins, 'prac_id' , astr_action.prac_id)
			lds_verif_action.SetItem( ll_ins, 'facility_id' , astr_action.facility_id)
			lds_verif_action.SetItem( ll_ins, 'seq_no' , ll_seq_no)
			lds_verif_action.SetItem( ll_ins, 'wf_complete_flag' , 'N')
			lds_verif_action.SetItem( ll_ins, 'print_flag' , ll_process_flag)
			lds_verif_action.SetItem( ll_ins, 'gp_id' , astr_action.gp_id) //(Appeon)Harry 11.14.2014 - 14.2 Bug fix for Workflow
			lds_verif_action.SetItem( ll_ins, 'app_id' , astr_action.app_id) //(Appeon)Harry 11.14.2014 - 14.2 Bug fix for Workflow
			lds_verif_action.SetItem( ll_ins, 'track_id' , astr_action.track_id) //Added by Appeon long.zhang 12.05.2016 (Bug id 5427 - Workflow not working properly)
			lds_verif_action.SetItem( ll_ins, 'app_hdr_application_name' , astr_action.app_name)  //(Appeon)Stephen 07.20.2017 - Critical performance issue with workflow action completion
			//---------Begin Modified by (Appeon)Harry 06.24.2013 for V141 ISG-CLX--------
			//$<add> Michael 07.12.2011
			//$<reason> V11.3 Action Item Dates
			lds_verif_action.SetItem( ll_ins, 'create_date' , datetime(today(),now()))
			lds_verif_action.SetItem( ll_ins, 'create_user' , "Sys-WF")
			
			inv_data_entry.of_field_audit(lds_verif_action)  //Start Code Change ----12.12.2016.2016 #V153 maha - audit data
			
			ll_rec_id++
		Next
		
		//inv_data_entry.of_field_audit( lds_verif_action , is_err)//Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
	case "03"	//Contract Logix Contract Tracking
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 06.08.2007 By: Jack
		//$<reason> Fix a defect.
		long ll_letter_from,ll_letter_to
		ll_letter_from = f_get_contact_id(astr_action.ctx_id,'I')
		ll_letter_to = f_get_contact_id(astr_action.ctx_id,'E')
		
		//---------------------------- APPEON END ----------------------------
		
		For i = 1 To ll_TypesCnt
			ll_ins = lds_verif_action.insertrow(0)
			lds_verif_action.SetItem( ll_ins, 'wf_id' , astr_action.wf_id)
			lds_verif_action.SetItem( ll_ins, 'wf_action_type_id' , lds_action_types.GetItemNumber(i , 'step_id'))
		
			//Set the active status value
			//If lds_action_types.GetItemNumber(i , 'step_order') <> 0 Then
			If lds_action_types.GetItemNumber(i , 'step_order') <> ll_init_step Then //03.17.2008 By Jervis
				lds_verif_action.SetItem( ll_ins, 'active_status' , -1)
			Else
				lds_verif_action.SetItem( ll_ins, 'active_status' , 1)
			End If
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'create_user_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , gs_user_id)
			Else
				//lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , lds_action_types.GetItemString(i , 'by_user'))
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'by_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'wf_step' , lds_action_types.GetItemNumber(i , 'step_order'))
			
			//Calculate the due date
			ld_duedate = of_daysafter(today(),lds_action_types.GetItemNumber(i , 'due_days'),lds_action_types.GetItemString(i , 'weekend_flag'))
			//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
			//lds_verif_action.SetItem( ll_ins, 'due_date' , ld_duedate)
			lds_verif_action.SetItem( ll_ins, 'due_date' , Date(ld_duedate))
			//---------End Modfiied ------------------------------------------------------
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'dept_chair_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'action_user' , is_dept_chairperson)
			Else
				//lds_verif_action.SetItem( ll_ins, 'action_user' , lds_action_types.GetItemString(i , 'to_user'))
				lds_verif_action.SetItem( ll_ins, 'action_user' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'to_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'action_type' , lds_action_types.GetItemnumber(i , 'action_type_id'))
			
			//Get the initial action status
			lds_action_status.SetFilter("step_id = " + string(lds_action_types.GetItemnumber(i , 'step_id')))
			lds_action_status.filter( )
			ll_find = lds_action_status.find("initial_flag='Y'" ,1, lds_action_status.Rowcount())
		
			If ll_find > 0 Then
				ls_StatusDesc = lds_action_status.GetItemString( ll_find, 'action_status_desc')	//Added by Scofield on 2009-12-08
				ll_status = lds_action_status.GetItemnumber( ll_find, 'action_status_id')
				ll_letter_id = lds_action_status.GetItemnumber( ll_find, 'letter_id')
				ll_step_status_id = lds_action_status.GetItemnumber( ll_find, 'status_id')
				ll_process_flag =  lds_action_status.GetItemnumber( ll_find, 'process_flag')
				If ll_process_flag <> 1 Then ll_process_flag = 0
			End If
			
			lds_verif_action.SetItem(ll_ins,'Subject',ls_StatusDesc)										//Added by Scofield on 2009-12-08
			lds_verif_action.SetItem(ll_ins,'action_status',ll_status)
			
			//Set the letter ID
			lds_verif_action.SetItem(ll_ins,"letter_id",ll_letter_id)
			lds_verif_action.SetItem(ll_ins,'ctx_id',astr_action.ctx_id)
			lds_verif_action.SetItem(ll_ins,'wf_complete_flag','N')
			lds_verif_action.SetItem(ll_ins,'print_flag',ll_process_flag)
			
			//12.12.2006 By Jervis
			lds_verif_action.SetItem(ll_ins,'action_date',today())
			lds_verif_action.SetItem(ll_ins,'inserted_at_date_time',today())
			
			//06.08.2007 By Jack
			If ll_letter_from > 0 Then
				lds_verif_action.SetItem(ll_ins,'letter_from',ll_letter_from)
			End If
			If ll_letter_to > 0 Then
				lds_verif_action.SetItem(ll_ins,'letter_to',ll_letter_to)
			End If
						
			//Adding for send initial email
			/*
			lstr_action.wf_id = astr_action.wf_id
			lstr_action.ctx_id = astr_action.ctx_id
			lstr_action.wf_step_id = lds_action_types.GetItemNumber(i , 'step_id')
			lstr_action.wf_step_status_id = ll_step_status_id
			of_send_mail(lstr_action,1)
			*/
		Next
	case "04"	//Contract Logix Agreement Manager
		For i = 1 To ll_TypesCnt
			ll_ins = lds_verif_action.insertrow(0)
			lds_verif_action.SetItem( ll_ins, 'wf_id' , astr_action.wf_id)
			lds_verif_action.SetItem( ll_ins, 'wf_action_type_id' , lds_action_types.GetItemNumber(i , 'step_id'))
		
			//Set the active status value
			//If lds_action_types.GetItemNumber(i , 'step_order') <> 0 Then
			If lds_action_types.GetItemNumber(i , 'step_order') <> ll_init_step Then //03.17.2008 By Jervis
				lds_verif_action.SetItem( ll_ins, 'active_status' , -1)
			Else
				lds_verif_action.SetItem( ll_ins, 'active_status' , 1)
			End If
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'create_user_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , gs_user_id)
			Else
				//lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , lds_action_types.GetItemString(i , 'by_user'))
				lds_verif_action.SetItem( ll_ins, 'wf_assigned_by' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'by_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'wf_step' , lds_action_types.GetItemNumber(i , 'step_order'))
			//Start 17.01.2007 By Jervis
			lds_verif_action.SetItem( ll_ins, 'action_order' , lds_action_types.GetItemNumber(i , 'step_order'))
			//End
			
			//Calculate the due date
			ld_duedate = of_daysafter(today(),lds_action_types.GetItemNumber(i , 'due_days'),lds_action_types.GetItemString(i , 'weekend_flag'))
			//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
			//lds_verif_action.SetItem( ll_ins, 'due_date' , ld_duedate)
			lds_verif_action.SetItem( ll_ins, 'due_date' , Date(ld_duedate))
			//---------End Modfiied ------------------------------------------------------
			
			//Set the user name value
			If lds_action_types.GetItemString(i , 'dept_chair_flag') = 'Y' Then
				lds_verif_action.SetItem( ll_ins, 'action_user' , is_dept_chairperson)
			Else
				//lds_verif_action.SetItem( ll_ins, 'action_user' , lds_action_types.GetItemString(i , 'to_user'))
				lds_verif_action.SetItem( ll_ins, 'action_user' , of_get_userid(astr_action,lds_action_types.GetItemString(i , 'to_user')))
			End If
			
			lds_verif_action.SetItem( ll_ins, 'action_type' , lds_action_types.GetItemnumber(i , 'action_type_id'))
			
			//Get the initial action status
			lds_action_status.SetFilter("step_id = " + string(lds_action_types.GetItemnumber(i , 'step_id')))
			lds_action_status.filter( )
			ll_find = lds_action_status.find("initial_flag='Y'" ,1, lds_action_status.Rowcount())
		
			If ll_find > 0 Then
				ls_StatusDesc = lds_action_status.GetItemString( ll_find, 'action_status_desc')	//Added by Scofield on 2009-12-08
				ll_status = lds_action_status.GetItemnumber( ll_find, 'action_status_id')
				ll_letter_id = lds_action_status.GetItemnumber( ll_find, 'letter_id')
				ll_step_status_id = lds_action_status.GetItemnumber( ll_find, 'status_id')
				ll_process_flag =  lds_action_status.GetItemnumber( ll_find, 'process_flag')
				If ll_process_flag <> 1 Then ll_process_flag = 0
			End If
			
			lds_verif_action.SetItem(ll_ins,'Subject',ls_StatusDesc)										//Added by Scofield on 2009-12-08
			lds_verif_action.SetItem(ll_ins,'action_status',ll_status)
			
			//Set the letter ID
			lds_verif_action.SetItem(ll_ins,"letter_id",ll_letter_id)
			lds_verif_action.SetItem(ll_ins,'doc_id', astr_action.doc_id)
			lds_verif_action.SetItem(ll_ins,'wf_complete_flag','N')
			lds_verif_action.SetItem(ll_ins,'print_flag',ll_process_flag)
			
			//12.12.2006 By Jervis
			lds_verif_action.SetItem(ll_ins,'status_date',today())
			lds_verif_action.SetItem(ll_ins,'create_date',today())
			
			
			//Adding for send initial email
			/*
			lstr_action.wf_id = astr_action.wf_id
			lstr_action.ctx_id = astr_action.ctx_id
			lstr_action.doc_id = astr_action.doc_id
			lstr_action.wf_step_id = lds_action_types.GetItemNumber(i , 'step_id')
			lstr_action.wf_step_status_id = ll_step_status_id
			of_send_mail(lstr_action,1)
			*/
		Next
end choose

//gnv_appeondb.of_autocommit()
if lds_verif_action.update()= 1 then
	commit;
else
	rollback;
	return -1
end if

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for USband Customer.
Long ll_ai_id
If astr_action.wf_id > 0 and ls_module = '03' and lds_verif_action.Rowcount() > 0 Then
	ll_ai_id = lds_verif_action.GetItemNumber(1, 'ctx_action_item_id')
	This.of_create_sub_contracts(astr_action.ctx_id, ll_ai_id)
End If

//add WF name for the original step after 'trigger by Action Item Change', Added by Appeon long.zhang 02.04.2017 (WF issues on Application tab bugid#5480)
//  Issue Statement: If the Workflow is triggered by completing the first step, the new step gets the wf_id but the original step never has the wf_id set
If astr_action.wf_id > 0 and ls_module = '02' and astr_action.trigger_by = "008" and lds_verif_action.Rowcount() > 0 &
	and astr_action.rec_id > 0 Then
	update net_dev_action_items set wf_id = :astr_action.wf_id, wf_complete_flag = 'N'
	where rec_id = :astr_action.rec_id and wf_id is null;
End If

//Start Cod By Jervis 02.06.2009
//Trigger the action from Action Status in work flow
For i = 1 To ll_TypesCnt
	choose case ls_module
		case '01','02'	//IntelliCred/App
			//Adding for send initial email
			//lstr_action.rec_id = ll_rec_id
//			lstr_action.rec_id = lds_verif_action.GetItemNumber( i, 'rec_id')
			lstr_action.prac_id = astr_action.prac_id
			lstr_action.wf_id = astr_action.wf_id
			lstr_action.wf_step_id = lds_action_types.GetItemNumber(i , 'step_id')
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 11.15.2006 By: Jervis
			//$<reason> 
			//lstr_action.wf_step_status_id = lds_action_status.GetItemnumber( ll_find, 'status_id')
			//lstr_action.wf_step_status_id = ll_step_status_id  02.06.2009
			//---------------------------- APPEON END ----------------------------

			lstr_action.dept_chair = is_dept_chairperson
			lstr_action.facility_id = astr_action.facility_id	//06/08/2007 By Jervis Fixed a bug
			
			//Send mail for action type
			of_send_mail(lstr_action,1)
		case '03'	//Contract Logix
			//Adding for send initial email
			lstr_action.wf_id = astr_action.wf_id
			lstr_action.ctx_id = astr_action.ctx_id
			lstr_action.wf_step_id = lds_action_types.GetItemNumber(i , 'step_id')
			//lstr_action.wf_step_status_id = ll_step_status_id 
			of_send_mail(lstr_action,1)
			
			lstr_action.ctx_action_item_id = lds_verif_action.GetItemNumber( i,'ctx_action_item_id')
			lstr_action.wf_action_status_id = lds_verif_action.GetItemNumber( i, 'action_status')
			lstr_action.notes = ""
			
			//trigger for action status in work flow
			of_status_changed(lstr_action)
			
			
		case '04'	//DocumetManager
			lstr_action.wf_id = astr_action.wf_id
			lstr_action.ctx_id = astr_action.ctx_id
			lstr_action.doc_id = astr_action.doc_id
			lstr_action.wf_step_id = lds_action_types.GetItemNumber(i , 'step_id')
			//lstr_action.wf_step_status_id = ll_step_status_id
			of_send_mail(lstr_action,1)
			
			lstr_action.seq_no = lds_verif_action.GetItemNumber( i,'seq_id')
			lstr_action.wf_action_status_id = lds_verif_action.GetItemNumber( i, 'action_status')
			lstr_action.notes = ""
			
			//trigger for action status in work flow
			of_status_changed(lstr_action)
	end choose
Next 

Destroy lds_action_status
Destroy lds_verif_action
Destroy lds_action_types

SetPointer(Arrow!)
Return 1

end function

public function integer of_workflow_triggers (str_action_item astr_action[]);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_workflow_triggers
//
//	Arguments:  
//	
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
long i 
//debugbreak()
For i = 1 To upperbound(astr_action)
	if astr_action[i].trigger_by = "008" then	//Trigger by Action Item Change
		//Gets work flow id
		if isnull(astr_action[i].wf_action_status_id) then
			select t2.wf_id 
			into :astr_action[i].wf_id
			from wf_workflow t1,wf_trigger_param_action_status t2
			where t1.wf_id = t2.wf_id and t1.wf_module = :astr_action[i].module
				and t2.action_type_id = :astr_action[i].wf_action_type_id 
				and t2.action_status_id is null;
		else
			select t2.wf_id 
			into :astr_action[i].wf_id
			from wf_workflow t1,wf_trigger_param_action_status t2
			where t1.wf_id = t2.wf_id and t1.wf_module = :astr_action[i].module
				and t2.action_type_id = :astr_action[i].wf_action_type_id 
				and t2.action_status_id = :astr_action[i].wf_action_status_id;
		end if
		if sqlca.sqlcode <> 0 then continue
	end if	
	
	of_workflow_create_action_items(astr_action[i])
Next

Return 1
end function

public function string of_get_userid (str_action_item astr_action, string as_user_id);String 	ls_create_user
long		ll_ConType,ll_Count

//Gets email address by user id
choose case as_user_id
	case "$$Owner$$"
		if astr_action.module = "03" or astr_action.module = "04" then
			SELECT ctx_contacts.user_d  
			into :ls_create_user
         FROM  ctx_contract_contacts,ctx_contacts
			WHERE ( ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  
					( ctx_contract_contacts.ctx_id = :astr_action.ctx_id ) AND  ( ctx_contract_contacts.ic_area = 'I' ) and ctx_contract_contacts.owner = 'Y';
			return ls_create_user
		else
			return as_user_id
		end if
	case "$$Assigned To User$$"
		//return gnv_data.of_getItem("security_users","email_id","user_id = '" + as_map_user_id + "'")
		return as_user_id
	case "$$Assigned By User$$"	//03.06.2007 By Jervis
		return as_user_id
	case "$$Practitioner$$"
		/*
		select e_mail_address 
		into :ls_create_user 
		from pd_address 
		where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id;
		*/
		return as_user_id
	case "$$Priority User$$"
		select priority_user 
		into :ls_create_user 
		from pd_affil_stat
		where prac_id = :astr_action.prac_id and parent_facility_id = :astr_action.facility_id;
		
		return ls_create_user
	case "$$Logged In User$$","System"	//03.06.2007 By Jervis
		return gs_user_id
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.13.2007 By: Machongmin
	//$<reason> Fix a defect.
	case "$$Document Created By$$" 
		//Start Change By Jervis
		if astr_action.module = "04" then
			select create_by into :ls_create_user from ctx_am_document where doc_id = :astr_action.doc_id;
		end if
		return ls_create_user
	//---------------------------- APPEON END ----------------------------	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2009-01-09 By: Scofield
	//$<Reason> Add Default To user.
	
	case "$$Default To$$"
		SELECT Top 1 ctx_contacts.user_d
		  INTO :as_user_id
		  FROM ctx_contract_contacts,ctx_contacts
		 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
				 ctx_contract_contacts.ctx_id = :astr_action.ctx_id AND
				 (ctx_contract_contacts.default_email = 'Y') AND
				 ctx_contract_contacts.ic_area = 'E';
				 
		Return as_user_id
	//---------------------------- APPEON END ----------------------------
	case else
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-08 By: Scofield
		//$<Reason> Get the user id according as the contact type.
		
		if astr_action.module = "03" or astr_action.module = "04" then
			if IsNumber(as_user_id) then
				ll_ConType = long(as_user_id)
				SELECT Count(*) 
				  INTO :ll_Count 
				  FROM code_lookup 
				 WHERE lookup_code = :ll_ConType AND lookup_name = 'Contract Contact Type';
				 
				if ll_Count > 0 then
					//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
					/*//modified by gavins 20121203
					SELECT Top 1 ctx_contacts.user_d
					  INTO :as_user_id
					  FROM ctx_contract_contacts,ctx_contacts
					 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
							 ctx_contract_contacts.ctx_id = :astr_action.ctx_id AND
							 ctx_contract_contacts.ic_area = 'I' AND
							 ctx_contract_contacts.association = :as_user_id ;
					*/		 
					SELECT Top 1 ctx_contacts.user_d
					  INTO :as_user_id
					  FROM ctx_contract_contacts,ctx_contacts
					 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
							 ctx_contract_contacts.ctx_id = :astr_action.ctx_id AND
							 ctx_contract_contacts.ic_area = 'I' AND
							 ( :as_user_id in ( ctx_contract_contacts.association    ,       ctx_contract_contacts.association2 ,
							  ctx_contract_contacts.association3,  ctx_contract_contacts.association4,
							 ctx_contract_contacts.association5,  ctx_contract_contacts.association6, 
							 ctx_contract_contacts.association7,  ctx_contract_contacts.association8,
							  ctx_contract_contacts.association9,  ctx_contract_contacts.association10               )  ) ;
					//---------End Modfiied ------------------------------------------------------
				end if
			end if
			
			if IsNumber(as_user_id) then as_user_id = ""
		end if
		//---------------------------- APPEON END ----------------------------
		Return as_user_id
End choose

end function

public function integer of_data_value_comparision_old (long al_screen_id, long al_key_id, long al_facility_id, string as_module, string as_runtype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in Contract Logix is contract id
// al_facility_id		facility id used in IntelliCred/App
// as_module			01-IntelliCred,02-IntelliApp,03-Contract Logix Tracking,04-Contract Logix Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_find
long 	ll_wf_id , ll_processed_id
integer	i , j, m , li_steps
Datastore lds_data_comparision
String	 ls_tablename , ls_comparision_sqls[] , ls_field_comp , ls_sql , ls_sql_comp
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id , ll_pre_screen
string	 ls_field_name, ls_operator, ls_value , ls_coltype
long		 ll_result[] , ll_pos
boolean   lb_trigger
str_action_item lstr_action

If not al_screen_id > 0 Then return -1

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "module='"+as_module+"' and screen_id =" + string(al_screen_id), lds_data_comparision)

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_comparision.Rowcount( ) 
If not li_steps > 0 Then return 1

lds_data_comparision.setsort( "wf_id asc")
lds_data_comparision.sort()

//
DECLARE exec_cur DYNAMIC CURSOR FOR SQLSA ;

//If one screen related more work flow, all work flows shoule be triggered
For i = 1 to li_steps
	lb_trigger = true
	
	ll_wf_id = lds_data_comparision.Getitemnumber( i, 'wf_id')
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	
	ll_find = gnv_data.of_findrow("wf_workflow","wf_id="+string(ll_wf_id))
	If not ll_find > 0 Then continue
	ll_processed_id = ll_wf_id
	
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue
			
			//F-Field Comparision, S-SQL statement comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				lds_data_comparision.setfilter("wf_id=" + string(ll_wf_id))
				lds_data_comparision.filter()
				For j = 1 to lds_data_comparision.RowCount()
					
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							//12.13.2006 By Jervis to fixed a defect
							//ls_tablename 	= gnv_data.of_get_table_name( al_screen_id , 'P' , 'sys_tables_table_name')
							ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
					
					
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
				
			Else //comparision with SQL statement
				lds_data_comparision.setfilter("wf_id=" + string(ll_wf_id))
				lds_data_comparision.filter()
				For j = 1 to lds_data_comparision.RowCount()
					
					ls_sql_comp = lds_data_comparision.getitemstring(j , 'sql_statement')
					If len(ls_sql_comp) > 0 Then 
						If pos(upper(ls_sql_comp) , ' WHERE ') > 0 Then
							ls_sql_comp = ls_sql_comp + " and prac_id = " + string(al_key_id)
						Else
							ls_sql_comp = ls_sql_comp + " where prac_id = " + string(al_key_id)
						End If
						
						ll_pos = pos(upper(ls_sql_comp) , ' FROM ' )
						If ll_pos > 0 Then
							ls_sql_comp = "select 1 " + mid(ls_sql_comp , ll_pos)
						End if
						ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_sql_comp
					End if
					
				Next
				
			End If
			
		Case '03' //Contract Logix tracking
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			//If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				lds_data_comparision.setfilter("wf_id=" + string(ll_wf_id))
				lds_data_comparision.filter()
				For j = 1 to lds_data_comparision.RowCount()
					
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where ctx_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where ctx_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
			End if
		Case '04' //Contract Logix Agreement
			
	End Choose
	lds_data_comparision.setfilter('')
	lds_data_comparision.filter( )
	lds_data_comparision.setsort( "wf_id asc")
	lds_data_comparision.sort()
	
	//Compare
	If upperbound(ls_comparision_sqls) > 0 Then
		For m = 1 to upperbound(ls_comparision_sqls)
			ls_sql = ls_comparision_sqls[m]

//			Prepare SQLSA From :ls_sql ;
//			Describe SQLSA Into SQLDA ;
//			Open Dynamic exec_cur Using Descriptor SQLDA ;
			//Fetch exec_cur using Descriptor SQLDA ;
//			
//			If SQLCA.sqlnrows > 0 Then //some result back
//				ll_result[m] = 1
//			Else // no result back
//				ll_result[m] = 0
//			End If

			PREPARE SQLSA FROM :ls_sql ;
			OPEN DYNAMIC exec_cur ;
			FETCH exec_cur INTO :ll_result[m] ;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.07.2006 By: Jervis
			//$<reason> Fix a defect for APB
			if sqlca.sqlcode <> 0 then
				ll_result[m] = 0
			end if
			//---------------------------- APPEON END ----------------------------

			close exec_cur;
		Next
	End If
	For m = 1 to upperbound(ll_result)
		If ll_result[m] <> 1 Then lb_trigger = false
	Next
	
	//trigger the related work flow
	If lb_trigger Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Return 1
end function

public function integer of_get_emailinfo (str_action_item astr_action, integer ai_mail_id, ref str_email astr_email);Long 		ll_data_length,ll_start
Integer 	li_loops,li_counter
Blob 		lb_data

//Get Email Information
//gnv_appeondb.of_startqueue( )
Select wf_email.email_name,
	wf_email.subject,
	wf_email.attach_name,
	wf_email.email_msg,
	export_id,
	Datalength(attachment),
	isnull(wf_email.auto_sign,'Y')
	Into :astr_email.name,
	:astr_email.subject,
	:astr_email.attach_name,
	:astr_email.message,
	:il_export_id,
	:ll_data_length,
	:astr_email.autosign				//Add By Jervis 01.20.2009
	From wf_email
	Where wf_email.email_id = :ai_Mail_id;

il_Mail_id = ai_Mail_id			//Added by Scofield on 2007-11-26

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
		Where wf_email.email_id = :ai_Mail_id;
		
		astr_email.attach += lb_data
	Next
Else
	SelectBlob attachment
	Into :astr_email.attach
	From wf_email
	Where wf_email.email_id = :ai_Mail_id;
End If
//gnv_appeondb.of_commitqueue( )

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-11-26 By: Scofield
//$<Reason> Save contract id Information.

if astr_action.module = "01" or astr_action.module = "02" then
	il_data_id = astr_action.prac_id
else
	il_data_id = astr_action.ctx_id
end if

//---------------------------- APPEON END ----------------------------

//astr_email.Message = of_replace_export(astr_action,il_export_id,astr_email.Message)		//Commented by Scofield on 2007-11-27

Return 1

end function

public function string of_replace_export (str_action_item astr_action, long al_export_id, string as_message);datastore lds_export
pfc_n_cst_ai_export_apb lnv_export
n_cst_string  lnv_string
string ls_begin_separator,ls_end_separator,ls_name,ls_value
long ll_begin,ll_end,ll_ret



ls_begin_separator = "$<"
ls_end_separator = ">$"

if al_export_id > 0 and match(as_message,"\$\<.*\>\$") then
	lds_export = create datastore
	lnv_export = create pfc_n_cst_ai_export_apb
	if astr_action.module = "01" or astr_action.module = "02" then
		ll_ret = lnv_export.of_get_export_data(al_export_id,astr_action.prac_id,lds_export)
	else
		ll_ret = lnv_export.of_get_export_data(al_export_id,astr_action.ctx_id,lds_export)
	end if
	
	if ll_ret > 0 then
		//Replace the filed flag for email message
		ll_begin = pos(as_message,ls_begin_separator,1)
		do while ll_begin > 0
			ll_end = pos(as_message,ls_end_separator,ll_begin + 2)
			
			//------Begin Modified by Alfee 05.08.2007-----------------------------
			if ll_end > 0 then
				ls_name = mid(as_message,ll_begin + 2,ll_end - ll_begin - 2)
				//if lds_export.Describe(ls_name+".x") <> "" then
				if IsNumber(lds_export.Describe(ls_name+".x")) then					
					ls_value = Trim(lds_export.GetItemString(1,ls_name))
					if isnull(ls_value) then ls_value = ""
					as_message = lnv_string.of_globalreplace( as_message, mid(as_message,ll_begin,ll_end - ll_begin + 2),ls_value)
					ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))					
				else
					ll_begin = pos(as_message,ls_begin_separator, ll_end)				
				end if
			Else//modfied by gavins 20130407
				exit
			end if
			//ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))
			//--------End Modified-----------------------------------
		loop
	end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.18.2007 By: Jack
	If isvalid(lnv_export.ids_export_data) Then
		destroy lnv_export.ids_export_data
	End If	
	//---------------------------- APPEON END ----------------------------
	destroy pfc_n_cst_ai_export_apb
	destroy lds_export
end if
return as_message
end function

public function string of_get_emailaddress (str_action_item astr_action, string as_user_id, string as_to_user_id, string as_by_user_id);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_get_emailaddress
//
//	Arguments:  none
//	as_user_id-
//	as_to_user_id-Assigned To User
//	as_by_user_id-Assigned By User
//
//	Returns:  none
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

long		ll_ConType,ll_SemPos,ll_Count,ll_Cycle,ll_EmailCnt
String	ls_Create_User,ls_MixAddr,ls_UserId,ls_EMailAddr,ls_SingEMail
n_cst_string lnv_string
string ls_EmailList[]
DataStore	lds_Email

//Gets email address by user id
choose case lower(as_user_id)		//Add Lower()  - jervis 09.25.2010
	case lower("$$Assigned To User$$")
		//Return gnv_data.of_getItem("security_users","email_id","user_id = '" + as_to_user_id + "'")
		Return as_to_user_id
	case lower("$$Assigned By User$$")
		Return as_by_user_id
	case lower("$$Practitioner$$")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 25/05/2007 By: Jervis
		//$<reason> 
		/*
		select e_mail_address 
		into :ls_create_user 
		from pd_address 
		where rec_id = :astr_action.rec_id and prac_id = :astr_action.prac_id;
		*/
		select top 1 e_mail_address 
		into :ls_create_user 
		from pd_address,pd_address_link 
		where pd_address.rec_id = pd_address_link.address_id and 
				pd_address.prac_id = pd_address_link.prac_id and  
				pd_address.prac_id = :astr_action.prac_id and 
				pd_address_link.facility_id = :astr_action.facility_id and
				pd_address_link.mailing = 1;
		//---------------------------- APPEON END ----------------------------

		
		Return ls_create_user
	case lower("$$Priority User$$")
		select priority_user 
		into :ls_create_user 
		from pd_affil_stat
		where prac_id = :astr_action.prac_id and parent_facility_id = :astr_action.facility_id;
		
		Return gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_create_user + "'")
	case lower("$$Owner$$")
		if astr_action.module = "03" or astr_action.module = "04" then
			SELECT ctx_contacts.user_d  
			into :ls_create_user
         FROM  ctx_contract_contacts,ctx_contacts
			WHERE ( ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  
					( ctx_contract_contacts.ctx_id = :astr_action.ctx_id ) AND  ( ctx_contract_contacts.ic_area = 'I' ) and ctx_contract_contacts.owner = 'Y';
			Return gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_create_user + "'")
		else
			Return ""
		end if
	case lower("$$Logged In User$$")		//03/06/2007
		Return gnv_data.of_getItem("security_users","email_id","user_id = '" + gs_user_id + "'")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.13.2007 By: Machongmin
	//$<reason> Fix a defect.
	case lower("$$Document Created By$$")
		//Start Change By Jervis 
		if astr_action.module = "04" then
			select create_by into :ls_create_user from ctx_am_document where doc_id = :astr_action.doc_id;
		end if
		Return gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_create_user + "'")
		
	//---------------------------- APPEON END ----------------------------	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2009-01-09 By: Scofield
	//$<Reason> Add Default To Email Address.
	
	Case lower("$$All OUR Contacts$$"),lower("$$Default To$$")
		lds_Email = Create DataStore
		
		if lower(as_user_id) = lower("$$All OUR Contacts$$") then
			lds_Email.DataObject = "d_AllOURContactEmail"
		elseif lower(as_user_id) = lower("$$Default To$$") then
			lds_Email.DataObject = "d_DefaultContactEmail"
		end if
		
		lds_Email.SetTransObject(SQLCA)
		lds_Email.Retrieve(astr_action.ctx_id)
		
		ll_EmailCnt = lds_Email.RowCount()
		for ll_Cycle = 1 to ll_EmailCnt
			ls_SingEMail = lds_Email.GetItemString(ll_Cycle,"ctx_contacts_numbers_contact_email")
			if IsNull(ls_SingEMail) or TRIM(ls_SingEMail) = "" then CONTINUE
			
			ls_EMailAddr += ls_SingEMail + ";"
		next
		
		if Len(ls_EMailAddr) > 0 then
			ls_EMailAddr = Mid(ls_EMailAddr,1,len(ls_EMailAddr) - 1)
		end if
		
		Destroy lds_Email
		
		Return ls_EMailAddr
	//---------------------------- APPEON END ----------------------------
	case else
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2007-05-30 By: Scofield
		//$<reason> Get EMail Address
		
		if astr_action.module = "03" or astr_action.module = "04" then
			if IsNumber(as_user_id) then
				ll_ConType = long(as_user_id)
				SELECT Count(*) INTO :ll_Count FROM code_lookup WHERE lookup_code = :ll_ConType AND lookup_name = 'Contract Contact Type';
				
				if ll_Count > 0 then
					/*
					//Modified by Scofield on 2008-04-07: Change to get userid's email address
					SELECT Top 1 em_smtp_accounts.Email
					  INTO :ls_EMailAddr
					  FROM ctx_contract_contacts,ctx_contacts,em_smtp_accounts
					 WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND
							 ctx_contacts.user_d = em_smtp_accounts.user_id AND
							 ctx_contract_contacts.ctx_id = :astr_action.ctx_id AND
							 ctx_contract_contacts.ic_area = 'I' AND
							 ctx_contract_contacts.association = :as_user_id AND
							 em_smtp_accounts.Is_Default = 'Y' AND
							 em_smtp_accounts.Email is not null ;
					*/
					//Return all email address for contact type - jervis 10.27.2010
					lds_email = create datastore
					lds_email.dataobject = 'd_wf_contype_address'
					lds_email.SettransObject( sqlca)
					if lds_email.Retrieve( astr_action.ctx_id,as_user_id) > 0 then
						ls_EmailList = lds_email.object.email.primary
						lnv_string.of_arraytostring( ls_EmailList, ";", false,ls_EMailAddr)
					end if
					if isvalid(lds_email) then  destroy lds_email
					if IsNull(ls_EMailAddr) then ls_EMailAddr = ""
					Return ls_EMailAddr
				end if
			end if
		end if
		
		if IsNull(as_user_id) then Return ''
		
		ls_MixAddr = Trim(as_user_id)
		do while Left(ls_MixAddr,1) = ";"
			ls_MixAddr = Trim(Mid(ls_MixAddr,2))
		loop
		do while Right(ls_MixAddr,1) = ";"
			ls_MixAddr = Trim(Mid(ls_MixAddr,1,Len(ls_MixAddr) - 1))
		loop
		
		ls_MixAddr += ";"
		ll_SemPos = Pos(ls_MixAddr,";")
		
		do while ll_SemPos > 0
			ls_UserId = Trim(Mid(ls_MixAddr,1,ll_SemPos - 1))
			ls_MixAddr = Trim(Mid(ls_MixAddr,ll_SemPos + 1))
			do while Left(ls_MixAddr,1) = ";"
				ls_MixAddr = Trim(Mid(ls_MixAddr,2))
			loop
			
			if Pos(ls_UserId,"$$") > 0 then			//Added by Scofield on 2010-01-22
				ls_SingEMail = of_get_emailaddress(astr_action,ls_UserId,as_to_user_id,as_by_user_id)
			elseif Pos(ls_UserId,"@") <= 0 then
				ls_SingEMail = gnv_data.of_getItem("security_users","email_id","user_id = '" + ls_UserId + "'")
			else
				ls_SingEMail = ls_UserId
			end if
			
			if Not(IsNull(ls_SingEMail) or Trim(ls_SingEMail) = '') then
				ls_EMailAddr += ls_SingEMail + ";"
			end if
			ll_SemPos = Pos(ls_MixAddr,";")
		loop
		ls_EMailAddr = Mid(ls_EMailAddr,1,len(ls_EMailAddr) - 1)
		Return ls_EMailAddr
		//---------------------------- APPEON END ----------------------------
End choose

end function

public function boolean of_get_message ();return ib_message
end function

public subroutine of_set_message (boolean ab_flag);ib_message = ab_flag
end subroutine

public function string of_getfieldcomp (string as_module, string as_tablename, long al_key_id, long al_facility_id);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-18 By: Scofield
//$<Reason> Construct the SQL syntax

String	ls_field_comp
						
if as_module = '03' then						
	if as_tablename = "ctx_contacts" then
		ls_field_comp = "Select 1 from ctx_contacts,ctx_contract_contacts where ctx_contacts.contact_id  = ctx_contract_contacts.contact_id and ctx_id = " + String(al_key_id) 
	else
		ls_field_comp 	= "Select 1 from " + as_tablename + " where ctx_id = " +string(al_key_id) 
	end if
else
	ls_field_comp 	= "Select 1 from " + as_tablename + " where Doc_id = " +string(al_facility_id)
end if

return ls_field_comp
//---------------------------- APPEON END ----------------------------

end function

public function integer of_get_emailmessage (long al_email_id, ref blob ablb_msgdata);long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long 	READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;
//---------Begin Added by (Appeon)Harry 08.30.2013 for V141 ISG-CLX--------
//Reason: BugT081501
String ls_module
Select module into :ls_module from wf_email where wf_email.email_id = :al_email_id;
if Isnull(ls_module) then ls_module = ""
If ls_module = '01' or ls_module = '02' then
	//----------------------APPEON BEGIN---------------------
	//<$>added:long.zhang 07.12.2012
	//<$>Reason:For a detect  -Bug 3156
	if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	//if  of_get_app_setting("set_56","I") = 1 then //outlook
			String ls_email_msg
			
			SELECT email_msg
			INTO :ls_email_msg 
			 FROM wf_email
			 WHERE wf_email.email_id = :al_EMail_Id;
			 
			 if not isnull(ls_email_msg) then
				ablb_MsgData = blob(ls_email_msg,EncodingANSI!)
			else
				ablb_MsgData = blob('',EncodingANSI!)
			end if
			return 1
	end if
	//------------------APPEON END-------------------------------
end if
//---------End Added ------------------------------------------------------
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

public function integer of_resend_letters ();//Add By Jervis 01.09.2009
//Checking for Letters that need to be reprinted

n_ds lds_resend
Integer li_rc
Integer i
//Long ll_seq_no
//Integer li_facility_id
//long ll_rec_id
//long ll_pracid


openwithparm( w_appeon_gifofwait, "Checking for Letters that need to be reprinted,Please wait..." )

lds_resend = CREATE n_ds;
//lds_resend.DataObject = "d_resend_letters"
//lds_resend.of_SetTransObject( SQLCA )
//li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw
//
//w_aiq_run.r_status.width = 900
//FOR i = 1 TO li_rc
//	lds_resend.SetItem( i, "print_flag", 1)
//END FOR
//
//IF lds_resend.Update() = -1 THEN
//	MessageBox("Update Failed", "Update of veir_info table failed during resend letter query!" )
//	Return -1
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.24.2006 By: Jervis
////$<reason> 
//lds_resend.DataObject = "d_resend_letters_app"
//lds_resend.of_SetTransObject( SQLCA )
//li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw
//
//w_aiq_run.r_status.width = 950
//FOR i = 1 TO li_rc
//	lds_resend.SetItem( i, "print_flag", 1)
//END FOR
//
//IF lds_resend.Update() = -1 THEN
//	MessageBox("Update Failed", "Update of net_dev_action_items table failed during resend letter query!" )
//	Return -1
//END IF

//12.5.2006 By Jervis
lds_resend.DataObject = "d_resend_letters_Contract"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

//w_aiq_run.r_status.width = 1000
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	MessageBox("Update Failed", "Update of ctx_action_items table failed during resend letter query!" )
	//Return -1
END IF

//01.22.2007 By Jervis
lds_resend.DataObject = "d_resend_letters_Document"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

//w_aiq_run.r_status.width = 1050
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	MessageBox("Update Failed", "Update of ctx_am_action_item table failed during resend letter query!" )
	//Return -1
END IF

destroy lds_resend
//---------------------------- APPEON END ----------------------------
if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

Return 1
end function

public function string of_getupdatecol (ref datawindow adw_update);//Get Modify Column to a string

String ls_modifyCol
Integer li_pos
String ls_dbname
Long ll_row,ll_col,ll_count_row,ll_count_col

If adw_Update.ModifiedCount( ) > 0 Then
	ll_count_row = adw_Update.RowCount()
	ll_count_col = Long(adw_Update.Describe("Datawindow.Column.count"))
	For ll_row = 1 To ll_count_row
		If adw_Update.GetItemStatus(ll_row,0,Primary!) = DataModified! Or adw_Update.GetItemStatus(ll_row,0,Primary!) = NewModified! Then
			For ll_col = 1 To ll_count_col
				If adw_Update.GetItemStatus( ll_row,ll_col,Primary!) = DataModified! Then
					//If adw_Update.GetItem(ll_row,ll_col,Primary!,Original!) = adw_Update.GetItem(ll_row,ll_col,Primary!) Then
					//	Continue
					//End If
					ls_dbname = adw_Update.Describe("#" + String(ll_col) + ".dbname")
					li_pos = lastpos(ls_dbname,".")
					If li_pos > 0 Then ls_dbname = Mid(ls_dbname,li_pos + 1)
					ls_modifyCol += "," + ls_dbname
				End If
			Next
		End If
	Next
End If

Return ls_modifyCol + ","


end function

public subroutine of_set_actionitem_notes (str_action_item astr_action, string as_to, string as_cc, string as_subject, string as_attachname);//Add code  By Jervis 02.10.2009
//has an email that goes out it would be nice if there was something in notes 
//which tracked the name of the email that went out and to whom

//Modify by jervis 02.17.2009
of_set_actionitem_flag(astr_action,as_to,as_cc,as_subject,as_attachname,'')
/*
string ls_notes
long ll_len

ls_notes = astr_action.notes

if ls_notes <> "" then ls_notes += "~r~n~r~n"

ls_notes += "Send date: " + string(today()) + "~r~n"
if not isnull(as_to) and as_to <> "" then ls_notes += 'To: ' + as_to + "~r~n"
if not isnull(as_cc) and as_cc <> "" then ls_notes += 'CC: ' + as_cc + "~r~n"
if not isnull(as_subject) then ls_notes += 'Subject: ' + as_subject + "~r~n"
if not isnull(as_attachname) then ls_notes += 'Attachement Name: ' + as_attachname + "~r~n"

//Max store 2000 char in action item notes
ll_len = len(ls_notes)
if ll_len > 2000 then 
	ls_notes = Mid(ls_notes,ll_len - 2000 + 1)
end if

choose case astr_action.module
	case '03'
		update ctx_action_items set notes = :ls_notes
		where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
	case '04'
		update ctx_am_action_item set notes = :ls_notes
		where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
end choose
*/
end subroutine

public subroutine of_set_actionitem_flag (str_action_item astr_action, string as_to, string as_cc, string as_subject, string as_attachname, string as_send_type);//Add code  By Jervis 02.10.2009
//has an email that goes out it would be nice if there was something in notes 
//which tracked the name of the email that went out and to whom
string ls_notes
long ll_len
date ld_today
string 	ls_note,  ls_tmp
long 		ll_pos
ls_notes = astr_action.notes
ls_note	= astr_action.notes		//Added By Mark Lee 06/25/12
//---------Begin Added by (Appeon)Toney 11.29.2013 for V141 ISG-CLX--------
//$Reason:Fix history BugT092401,convert parameter's null value to empty string
IF IsNull(ls_notes) THEN ls_notes = ""
IF IsNull(ls_note) THEN ls_note = ""
//---------End Added ------------------------------------------------------------------

ll_pos =	0
if ls_notes <> "" then ls_notes += "~r~n~r~n"

ls_notes += "Sent Date: " + string(today())  + ' ' + String(Now(), ' HH:MM:SS') + "~r~n"
if not isnull(as_to) and as_to <> "" then ls_notes += 'To: ' + as_to + "~r~n"
if not isnull(as_cc) and as_cc <> "" then ls_notes += 'CC: ' + as_cc + "~r~n"
if not isnull(as_subject) then ls_notes += 'Subject: ' + as_subject + "~r~n"
if not isnull(as_attachname) then ls_notes += 'Attachement Name: ' + as_attachname + "~r~n"

//Max store 500 char in action item notes //Modified By Ken.Guo 08/31/2012. external to 2000 char
ll_len = len(ls_notes)
if ll_len > 1990 then 
	ls_notes = Mid(ls_notes,1, 1990) + '...~r~n'
end if

ls_notes += '~r~n'

ld_today = today()
choose case astr_action.module
	case '03'
		//Begin - Added By Mark Lee 06/25/12 erase duplicate data in the notes columns
		If not isnull(ls_note) and trim(ls_note) <> '' Then
			Select notes
			Into :ls_tmp
			From ctx_action_items
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
			
			If not isnull(ls_tmp) then 
				ll_pos	= Pos(ls_tmp,ls_note)
			End If
		End IF 
		If ll_pos > 0 Then
			update ctx_action_items set notes = :ls_notes 
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;	
		Else
			//---------Begin Modified by (Appeon)Harry 09.06.2015 for Bug # 4704 -------
			//update ctx_action_items set notes = :ls_notes +  (case when notes is null then '' else notes end) 
			//where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
			ls_notes = "~r~n~r~n" + ls_notes
			update ctx_action_items set notes = (case when notes is null then '' else notes end) + :ls_notes 
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
			//---------End Modfiied ------------------------------------------------------
		End If
		//End - Added By Mark Lee 06/25/12
//		update ctx_action_items set notes = :ls_notes +  (case when notes is null then '' else notes end) 
//		where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
		//Add code By Jervis 02.17.20009
		//Set send flag for action item
		if as_send_type = IS_REMINDER then
			update ctx_action_items set reminder_last = :ld_today	//,notes = :ls_notes
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
		elseif as_send_type = IS_ESCALATION then
			update ctx_action_items set escalation_last = :ld_today	//,notes = :ls_notes
			where ctx_id = :astr_action.ctx_id and ctx_action_item_id = :astr_action.ctx_action_item_id;
		END IF
	case '04'
		//Begin - Added By Mark Lee 06/25/12  erase duplicate data in the notes columns
		If not isnull(ls_note) and trim(ls_note) <> '' Then
			Select notes
			Into :ls_tmp
			From ctx_am_action_item
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
			
			If not isnull(ls_tmp) then 
				ll_pos	= Pos(ls_tmp,ls_note)
			End If
		End IF 
		If ll_pos > 0 Then
			update ctx_am_action_item set notes = :ls_notes 
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;			
		Else
			//---------Begin Modified by (Appeon)Harry 09.06.2015 for Bug # 4704 -------
			//update ctx_am_action_item set notes = :ls_notes +  (case when notes is null then '' else notes end) 
			//where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
			ls_notes = "~r~n~r~n" + ls_notes
			update ctx_am_action_item set notes =  (case when notes is null then '' else notes end) + :ls_notes
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
			//---------End Modfiied ------------------------------------------------------
		End If
//		update ctx_am_action_item set notes = :ls_notes 
//		where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
		//End - Added By Mark Lee 06/25/12
		
		//Add code By Jervis 02.17.20009
		//Set send flag for action item
		if as_send_type = IS_REMINDER then
			update ctx_am_action_item set reminder_last = :ld_today	//,notes = :ls_notes
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
		elseif as_send_type = IS_ESCALATION then
			update ctx_am_action_item set escalation_last = :ld_today	//,notes = :ls_notes
			where doc_id = :astr_action.doc_id and seq_id = :astr_action.seq_no;
		END IF
end choose


end subroutine

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

public function integer of_popup_prompt (str_action_item astr_action);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_popup_prompt
//
//	Arguments:  
//		astr_action:str_action_item,include:
//			long		wf_id
//			long		wf_step_id
//			decimal{0}		wf_action_status_id
//
//	Returns:  
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2009 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
string ls_Prompt_message
string ls_prompt_falg
long ll_find
integer li_ret
datastore lds_action_status
string ls_esign
str_parm lstr_parm

//Init to 1
li_ret = 1

if isnull(astr_action.wf_id) or isnull(astr_action.wf_step_id) then return li_ret

//Get the Action Status for the current action type
lds_action_status = Create DataStore
lds_action_status.dataobject = 'd_g_action_status_data'
lds_action_status.SetTransObject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_action_status', "wf_id="+string(astr_action.wf_id) + " and step_id=" + string(astr_action.wf_step_id) , lds_action_status)

//01-12-2006 By Jervis,Action_status_id can be set to null
if isnull(astr_action.wf_action_status_id) then
	ll_find = lds_action_status.find( "isnull(action_status_id)", 1, lds_action_status.RowCount())
else
	ll_find = lds_action_status.find( "action_status_id=" + string(astr_action.wf_action_status_id), 1, lds_action_status.RowCount())
end if

If ll_find > 0 Then 
	//Get the flag of prompt when status change
	ls_prompt_falg = lds_action_status.GetItemString(ll_find ,'prompt_flag')
	
	//Pop-up Promtp
	if ls_prompt_falg = "Y" then
		ls_esign = lds_action_status.GetItemString(ll_find,"wf_esign")
		ls_Prompt_message = lds_action_status.GetItemString(ll_find,"prompt_message")
		if isnull(ls_Prompt_message) then ls_Prompt_message = "Are you sure you want to change the action status?"

		//Add E-Sign -- jervis 10.26.2010
		lstr_parm.s_array[1] = ls_esign
		lstr_parm.s_array[2] = ls_Prompt_message
		lstr_parm.s_array[3] = astr_action.as_assigned_to	//11.17.2010-jervis
		OpenWithParm(w_wf_prompt,lstr_parm)
		li_ret = Message.doubleparm
		//li_ret = MessageBox("Action Status changing",ls_prompt_message,Information!,OKCancel! )
	end if
end if
if isvalid(lds_action_status) then destroy lds_action_status
return li_ret

end function

public subroutine of_build_fielddddw (long al_view_id, long al_screen_id, ref datawindow adw_screen, ref datawindowchild adwc_field, string as_triggered_by);datawindow   ldw[] 
integer li_count,li_i,ll_row  

string ls_colname,ls_text,ls_error , ls_coltype , ls_tablename,ls_DbName
string ls_tab_name,ls_dw_name[],ls_dataobject[]
string ls_fieldname
string ls_dddwname

//parent.setredraw(false)

//<add> 06/20/2007 by: Andy
//String ls_wf_triggered_by

//ls_wf_triggered_by = dw_workflow.GetItemString(1,"wf_triggered_by")
//IF ISNULL(ls_wf_triggered_by) THEN ls_wf_triggered_by = ''
IF ISNULL(as_triggered_by) THEN as_triggered_by = ''

//if ls_wf_triggered_by = '105' then
if as_triggered_by = '105' then
	adw_screen.dataobject = 'd_dm_new_sell_document'
	adw_screen.settransobject(sqlca)
else			
	ls_tab_name = gnv_data.of_get_table_name( al_screen_id, 'C', 'tab_name')
	
	ldw[1] = adw_screen
	
	ls_dw_name[1] 		= gnv_data.of_get_table_name( al_screen_id, 'C', 'dw_name')
	ls_dataobject[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dataobject')
	
	f_create_contract_dw(al_view_id,ls_tab_name,ldw,ls_dw_name,ls_dataobject)
end if
//end of add

/* Comment 06/20/2007 by: Andy
ls_tab_name = gnv_data.of_get_table_name( al_screen_id, 'C', 'tab_name')

ldw[1] = adw_screen

ls_dw_name[1] 		= gnv_data.of_get_table_name( al_screen_id, 'C', 'dw_name')
ls_dataobject[1] 	= gnv_data.of_get_table_name( al_screen_id, 'C', 'dataobject')

f_create_contract_dw(1001,ls_tab_name,ldw,ls_dw_name,ls_dataobject)
*/

adw_screen.visible = false
li_count  = integer(adw_screen.Describe("DataWindow.Column.Count"))

If li_count > 0  Then
	//ls_tablename = adw_screen.Object.DataWindow.Table.UpdateTable		//Commented by Scofield on 2007-09-18
	
	For li_i = 1 to li_count
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modified> 2007-05-16 By: Wu ZhiJun
		//$<reason> Fix a bug
		ls_colname = adw_screen.Describe("#"+string(li_i) + ".name")
		
		if long(adw_screen.describe(ls_colname + ".y")) > long(adw_screen.describe("datawindow.detail.height")) then continue
		if long(adw_screen.describe(ls_colname + ".visible")) = 0 then continue
		
		ls_DbName = adw_screen.Describe("#"+string(li_i) + ".dbName")
		if Pos(ls_DbName,".") <= 0 then continue
		
		ls_tablename = Left(ls_DbName,Pos(ls_DbName,".") - 1)
		ls_fieldname = mid(ls_dbname,Pos(ls_DbName,".") + 1)
		//--------------------------- APPEON END -----------------------------
		
		ll_row = adwc_field.InsertRow(0)
		
		adwc_field.SetItem(ll_row,"data_view_screen_screen_id",al_screen_id)
		
		//adwc_field.SetItem(ll_row,"sys_fields_field_name",ls_colname)
		adwc_field.SetItem(ll_row,"sys_fields_field_name",ls_fieldname)
		
		ls_text = adw_screen.Describe( ls_colname + "_t.text")
		if ls_text = "?" or ls_text = "!" then ls_text = ""
		if ls_text = '' then ls_text = ls_colname
		adwc_field.SetItem(ll_row,"data_view_fields_field_label",ls_text)
		
		adwc_field.SetItem(ll_row,"data_view_fields_field_order",ll_row)
		
		ls_coltype = adw_screen.Describe("#"+string(li_i) + ".coltype")
		Choose Case Left ( ls_coltype , 5 )
			Case "char(", "char"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'S')
			Case "date"	,"datet"	,"time", "times"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'D')
			Case "decim","numbe", "doubl", "real","long", "ulong", "int"
				adwc_field.SetItem(ll_row,"sys_fields_field_type",'N')
		End Choose
		
		adwc_field.SetItem(ll_row,"table_name",ls_tablename)
		
		//modify 08/28/2007 by: Andy
		//if adw_screen.Describe(ls_colname+".dddw.name") = "d_dddw_code_lookup" then
		ls_dddwname = adw_screen.Describe(ls_colname+".dddw.name")
		if ls_dddwname = "d_dddw_code_lookup" or ls_dddwname = "dddw_dm_category" then
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","C")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_screen.Describe(ls_colname+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","Code")
		//add d_dddw_company_list -- jervis 04.15.2011
		elseif ls_dddwname = 'd_dddw_company' or ls_dddwname = 'd_dddw_company_list'  then	//Company dddw-jervis 12.9.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","P")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_screen.Describe(ls_colname+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","falicity_id")
		elseif ls_dddwname = 'd_dddw_users' then	//users dddw -- jervis 12.9.2009
			adwc_field.SetItem(ll_row,"sys_fields_lookup_type","U")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_field","Y")
			//adwc_field.SetItem(ll_row,"sys_fields_lookup_code",adw_screen.Describe(ls_colname+".tag"))
			adwc_field.SetItem(ll_row,"sys_fields_lookup_field_name","user_id")
		end if
	Next
Else
	MessageBox ( gnv_app.iapp_object.DisplayName, &
						"The DDDW of Field Data Retrieve failed!", information!, Ok!, 1)
End if

//parent.setredraw(true)


end subroutine

public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id[]		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in Contract Logix is contract id.
// al_facility_id		facility id used in IntelliCred/App. Doc id used in Document Manager
// as_module			01-IntelliCred,02-IntelliApp,03-Contract Logix Tracking,04-Contract Logix Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 1.1   1.12.2009 By Jervis:Marked obsolete for ContractLogix
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
string ls_UpdateCol[]
return of_data_value_comparision(al_view_id,al_screen_id,ls_updateCol[],al_key_id,al_facility_id,as_module,as_runtype)

/*
long	ll_find,ll_rowcount
long 	ll_wf_id , ll_processed_id
integer	i , j, m , li_steps
Datastore lds_data_comparision,lds_data_workflow
String	 ls_tablename , ls_comparision_sqls[] , ls_field_comp , ls_sql , ls_sql_comp
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id , ll_pre_screen
string	 ls_field_name, ls_operator, ls_value , ls_coltype,ls_filter
long		 ll_result[] , ll_pos
boolean   lb_trigger
string ls_empty[]		//05/16/2007 by jervis
long 	ll_empty[] 		//12.24.2008 By Jervis
str_action_item lstr_action

li_steps = upperbound(al_screen_id)
If not li_steps > 0 Then return -1

for i = 1 to li_steps
	if i = 1 then
		ls_filter = "(screen_id = " + string(al_screen_id[i])
	else
		ls_filter += " or screen_id = " + string(al_screen_id[i])
	end if
next
ls_filter += ")"

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_workflow = Create DataStore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_workflow.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
lds_data_workflow.settransobject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "module='"+as_module+"' and " + ls_filter, lds_data_workflow)

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_workflow.Rowcount( ) 
If not li_steps > 0 Then return 1

lds_data_workflow.setsort( "wf_id asc")
lds_data_workflow.sort()

//
DECLARE exec_cur DYNAMIC CURSOR FOR SQLSA ;

//If one screen related more work flow, all work flows shoule be triggered
For  i = 1 to li_steps
	lb_trigger = true
	ls_comparision_sqls = ls_empty	//05/16/2007 By Jervis
	ll_result = ll_empty	//12.24.2008 By Jervis
	ll_wf_id = lds_data_workflow.Getitemnumber( i, 'wf_id')
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 17/05/2007 By: Jervis
	//$<reason> 
	/*
	ll_find = gnv_data.of_findrow("wf_workflow","wf_id="+string(ll_wf_id))
	If not ll_find > 0 Then continue
	*/
	//Get the related work flow trigger parms for the current ll_wf_id from cache data
	lds_data_comparision.Reset()
	gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "wf_id=" + string(ll_wf_id), lds_data_comparision)
	ll_rowcount = lds_data_comparision.RowCount()
	//---------------------------- APPEON END ----------------------------

	
			
	ll_processed_id = ll_wf_id
	
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue
			
			//F-Field Comparision, S-SQL statement comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				For j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							//12.13.2006 By Jervis to fixed a defect
							//ls_tablename 	= gnv_data.of_get_table_name( al_screen_id , 'P' , 'sys_tables_table_name')
							ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
					
					
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
				
			Else //comparision with SQL statement
				For j = 1 to ll_rowcount
					ls_sql_comp = lds_data_comparision.getitemstring(j , 'sql_statement')
					If len(ls_sql_comp) > 0 Then 
						If pos(upper(ls_sql_comp) , ' WHERE ') > 0 Then
							ls_sql_comp = ls_sql_comp + " and prac_id = " + string(al_key_id)
						Else
							ls_sql_comp = ls_sql_comp + " where prac_id = " + string(al_key_id)
						End If
						
						ll_pos = pos(upper(ls_sql_comp) , ' FROM ' )
						If ll_pos > 0 Then
							ls_sql_comp = "select 1 " + mid(ls_sql_comp , ll_pos)
						End if
						ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_sql_comp
					End if
					
				Next
				
			End If
		Case '03','04' //Contract Logix tracking
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
			//j = gnv_data.of_FindRow("wf_trigger_param_data_comparison","wf_id=" + string(ll_wf_id))
			
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				//If j > 0 then	
				FOR j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					//ll_screen_id = long(gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"screen_id"))
					If j = 1 Then
						ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
						ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
							ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					/*
					ls_field_name 	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_name")
					ls_operator	  	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"operator")
					ls_value 		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"value")
					ls_coltype		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_type")
					*/
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
			End if
		//Case '04' //Contract Logix Agreement //Comment 06/20/2007 by: Andy
			
	End Choose
	
	//Compare
	
	If upperbound(ls_comparision_sqls) > 0 Then
		For m = 1 to upperbound(ls_comparision_sqls)
			ls_sql = ls_comparision_sqls[m]

			PREPARE SQLSA FROM :ls_sql ;
			OPEN DYNAMIC exec_cur ;
			FETCH exec_cur INTO :ll_result[m] ;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.07.2006 By: Jervis
			//$<reason> Fix a defect for APB
			if sqlca.sqlcode <> 0 then
				ll_result[m] = 0
			end if
			//---------------------------- APPEON END ----------------------------

			close exec_cur;
		Next
	End If
	For m = 1 to upperbound(ll_result)
		If ll_result[m] <> 1 Then lb_trigger = false
	Next
	
	//trigger the related work flow
	If lb_trigger Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		//<add> 06/20/2007 by: Andy 
		//Remark:al_facility_id equal to Doc id used in Document Manager
		lstr_action.doc_id = al_facility_id
		//end of add
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Destroy lds_data_workflow
Return 1
*/
end function

public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id[]		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in Contract Logix is contract id.
// al_facility_id		facility id used in IntelliCred/App. Doc id used in Document Manager
// as_module			01-IntelliCred,02-IntelliApp,03-Contract Logix Tracking,04-Contract Logix Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////

//Add trigger type argument - jervis 08.31.2010
return of_data_value_comparision(al_view_id,al_screen_id,as_updatecol,al_key_id,al_facility_id,as_module,as_runtype,'S')
 
/*
long	ll_find,ll_rowcount
long 	ll_wf_id , ll_processed_id
integer	i , j, m , li_steps
Datastore lds_data_comparision,lds_data_workflow
String	 ls_tablename , ls_comparision_sqls[] , ls_field_comp , ls_sql , ls_sql_comp
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id , ll_pre_screen
string	 ls_field_name, ls_operator, ls_value , ls_coltype,ls_filter
long		 ll_result[] , ll_pos
boolean   lb_trigger
boolean 	 lb_UpdateFlag
string ls_empty[]		//05/16/2007 by jervis
long 	ll_empty[] 		//12.24.2008 By Jervis
str_action_item lstr_action

li_steps = upperbound(al_screen_id)
If not li_steps > 0 Then return -1

for i = 1 to li_steps
	if i = 1 then
		ls_filter = "(screen_id = " + string(al_screen_id[i])
	else
		ls_filter += " or screen_id = " + string(al_screen_id[i])
	end if
next
ls_filter += ")"

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_workflow = Create DataStore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_workflow.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
lds_data_workflow.settransobject(SQLCA)

//Refresh cache - jervis 01.07.2010
gnv_data.of_retrieve("wf_trigger_param_data_comparison")

//Begin Modify by Scofield on 2009-03-12
gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_workflow_view_id) or wf_workflow_view_id = " + String(al_View_ID) + ") and " + ls_filter, lds_data_workflow)
//gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "module='"+as_module+"' and " + ls_filter, lds_data_workflow)
//End Modify by Scofield on 2009-03-12

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_workflow.Rowcount( ) 
If not li_steps > 0 Then return 1

lds_data_workflow.setsort( "wf_id asc")
lds_data_workflow.sort()

//
DECLARE exec_cur DYNAMIC CURSOR FOR SQLSA ;

//If one screen related more work flow, all work flows shoule be triggered
For  i = 1 to li_steps
	lb_trigger = true
	ls_comparision_sqls = ls_empty	//05/16/2007 By Jervis
	ll_result = ll_empty	//12.24.2008 By Jervis
	lb_UpdateFlag = false	//01.12.2009 By Jervis
	ll_wf_id = lds_data_workflow.Getitemnumber( i, 'wf_id')
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 17/05/2007 By: Jervis
	//$<reason> 
	/*
	ll_find = gnv_data.of_findrow("wf_workflow","wf_id="+string(ll_wf_id))
	If not ll_find > 0 Then continue
	*/
	//Get the related work flow trigger parms for the current ll_wf_id from cache data
	lds_data_comparision.Reset()
	gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "wf_id=" + string(ll_wf_id), lds_data_comparision)
	ll_rowcount = lds_data_comparision.RowCount()
	//---------------------------- APPEON END ----------------------------

	
			
	ll_processed_id = ll_wf_id
	
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			lb_UpdateFlag = true //01.12.2008 By Jervis
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue
			
			//F-Field Comparision, S-SQL statement comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				For j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							//12.13.2006 By Jervis to fixed a defect
							//ls_tablename 	= gnv_data.of_get_table_name( al_screen_id , 'P' , 'sys_tables_table_name')
							ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'S','C' //Character-- Add 'S' by jervis 03.12.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
					
					
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
				
			Else //comparision with SQL statement
				For j = 1 to ll_rowcount
					ls_sql_comp = lds_data_comparision.getitemstring(j , 'sql_statement')
					If len(ls_sql_comp) > 0 Then 
						If pos(upper(ls_sql_comp) , ' WHERE ') > 0 Then
							ls_sql_comp = ls_sql_comp + " and prac_id = " + string(al_key_id)
						Else
							ls_sql_comp = ls_sql_comp + " where prac_id = " + string(al_key_id)
						End If
						
						ll_pos = pos(upper(ls_sql_comp) , ' FROM ' )
						If ll_pos > 0 Then
							ls_sql_comp = "select 1 " + mid(ls_sql_comp , ll_pos)
						End if
						ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_sql_comp
					End if
					
				Next
				
			End If
		Case '03','04' //Contract Logix tracking
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
			//j = gnv_data.of_FindRow("wf_trigger_param_data_comparison","wf_id=" + string(ll_wf_id))
			
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				//If j > 0 then	
				FOR j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					//ll_screen_id = long(gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"screen_id"))
					If j = 1 Then
						ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
						ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
							ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					/*
					ls_field_name 	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_name")
					ls_operator	  	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"operator")
					ls_value 		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"value")
					ls_coltype		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_type")
					*/
					
					//01.12.2009 by Jervis:if include the column
					if UpperBound(as_UpdateCol) > 0 then  //Jervis 08.31.2010
						if pos(as_UpdateCol[ll_screen_id],"," + ls_field_name + ",") > 0 then lb_UpdateFlag = true	
					end if
				
					Choose Case ls_coltype
						Case 'S','C' //Character --Add 'S' by jervis 03.12.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
							if ls_operator = "is" then //Jervis 11.11.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
							else
								if isdate(ls_value) then
									ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
								else
									ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + ls_value //jervis 01.18.2010
								end if
							end if
					End Choose
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
			End if
		//Case '04' //Contract Logix Agreement //Comment 06/20/2007 by: Andy
			
	End Choose
	
	
	//1.12.2009 By Jervis 
	// It should ONLY trigger if the data in the fields that are in the Data Value Comparison-> Trigger Parameters of a work flow are changed to match criteria
	if UpperBound(as_UpdateCol) > 0  and lb_UpdateFlag = false then continue  //Add "UpperBound(as_UpdateCol) > 0 " - jervis 08.31.2010
	
	
	//Compare
	If upperbound(ls_comparision_sqls) > 0 Then
		For m = 1 to upperbound(ls_comparision_sqls)
			ls_sql = ls_comparision_sqls[m]

			PREPARE SQLSA FROM :ls_sql ;
			OPEN DYNAMIC exec_cur ;
			FETCH exec_cur INTO :ll_result[m] ;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.07.2006 By: Jervis
			//$<reason> Fix a defect for APB
			if sqlca.sqlcode <> 0 then
				ll_result[m] = 0
			end if
			//---------------------------- APPEON END ----------------------------

			close exec_cur;
		Next
	End If
	For m = 1 to upperbound(ll_result)
		If ll_result[m] <> 1 Then lb_trigger = false
	Next
	
	//trigger the related work flow
	If lb_trigger Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		//<add> 06/20/2007 by: Andy 
		//Remark:al_facility_id equal to Doc id used in Document Manager
		lstr_action.doc_id = al_facility_id
		//end of add
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Destroy lds_data_workflow
Return 1
*/
end function

public function string of_replace_export (ref string as_message, ref datastore ads_export);//Modified By Ken.Guo 2011-04-13
Return of_replace_export(as_message,ads_export,1) 

//n_cst_string  lnv_string
//string ls_begin_separator,ls_end_separator,ls_name,ls_value
//long ll_begin,ll_end,ll_ret
//
//ls_begin_separator = "$<"
//ls_end_separator = ">$"
//
//if match(as_message,"\$\<.*\>\$") then
//	//Replace the filed flag for email message
//	ll_begin = pos(as_message,ls_begin_separator,1)
//	do while ll_begin > 0
//		ll_end = pos(as_message,ls_end_separator,ll_begin + 2)
//		
//		//------Begin Modified by Alfee 05.08.2007-----------------------------
//		if ll_end > 0 then
//			ls_name = mid(as_message,ll_begin + 2,ll_end - ll_begin - 2)
//			if IsNumber(ads_export.Describe(ls_name+".x")) then					
//				ls_value = Trim(ads_export.GetItemString(1,ls_name))
//				if isnull(ls_value) then ls_value = ""
//				as_message = lnv_string.of_globalreplace( as_message, mid(as_message,ll_begin,ll_end - ll_begin + 2),ls_value)
//				ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))					
//			else
//				ll_begin = pos(as_message,ls_begin_separator, ll_end)				
//			end if
//		end if
//		//ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))
//		//--------End Modified-----------------------------------
//	loop
//
//end if
//return as_message
end function

public function integer of_pre_group_email (str_action_item astr_action_item, string as_mailto, string as_mailcc);String ls_mailto[],ls_mailcc[],ls_mailuser[],ls_sender
Integer i,j
Boolean lb_exist
n_cst_string lnv_string
lnv_string.of_parsetoarray( as_mailto, ';', ls_mailto[])
lnv_string.of_parsetoarray( as_mailcc, ';', ls_mailcc[])

//Merge MailTo and MailCc to Array
For i = 1 To UpperBound(ls_mailto[])
	lb_exist = False
	For j = 1 To UpperBound(ls_mailuser[])
		If Upper(Trim(ls_mailto[i])) = Upper(Trim(ls_mailuser[j])) Then
			lb_exist = True	
			Exit
		End If
	Next
	If Not lb_exist Then
		ls_mailuser[UpperBound(ls_mailuser[]) + 1] = ls_mailto[i]
	End If
Next
For i = 1 To UpperBound(ls_mailcc[])
	lb_exist = False
	For j = 1 To UpperBound(ls_mailuser[])
		If Upper(Trim(ls_mailcc[i])) = Upper(Trim(ls_mailuser[j])) Then
			lb_exist = True	
			Exit
		End If
	Next
	If Not lb_exist Then
		ls_mailuser[UpperBound(ls_mailuser[]) + 1] = ls_mailcc[i]
	End If
Next

//Generate Alarm Data to Structure
str_alarm lstr_alarm,lstr_null
lstr_alarm = lstr_null
lstr_alarm.ctx_id = astr_action_item.ctx_id
lstr_alarm.alm_table = astr_action_item.as_table
lstr_alarm.alm_column = astr_action_item.as_column
lstr_alarm.ctx_company = astr_action_item.as_company
lstr_alarm.ctx_category = astr_action_item.al_category
lstr_alarm.alm_date_value = Datetime(astr_action_item.due_date,Time('00:00:00'))
lstr_alarm.alm_times_reminded = astr_action_item.alm_times_reminded
lstr_alarm.ai_id = astr_action_item.ctx_action_item_id
lstr_alarm.doc_id = astr_action_item.doc_id
lstr_alarm.seq_id = astr_action_item.seq_no
lstr_alarm.as_owner = astr_action_item.as_owner
lstr_alarm.wf_id = astr_action_item.wf_id
lstr_alarm.as_column_name = 'Due Date'
lstr_alarm.as_notes = 'Work Flow = ' + astr_action_item.wf_name
If lstr_alarm.alm_table = 'ctx_am_action_item' Then
	lstr_alarm.as_from = "WF_DM"
	lstr_alarm.as_notes += "~r~nDOC ID = " + String(astr_action_item.doc_id)
Else
	lstr_alarm.as_from = "WF"
End If

If is_sa_address <> '' Then
	ls_sender = is_sa_address
Else
	ls_sender = lstr_alarm.as_owner
End If

//Add Email Data to Group Email Array
For i = 1 To UpperBound(ls_mailuser[])
	lb_exist = False
	For j = 1 To UpperBound(istr_group_alarm[])
		If Upper(Trim(ls_mailuser[i])) = Upper(Trim(istr_group_alarm[j].as_email_address)) and &
			Upper(Trim(ls_sender)) = Upper(Trim(istr_group_alarm[j].as_sender)) Then
				lb_exist = True
				Exit
		End If
	Next
	If lb_exist Then
		istr_group_alarm[j].astr_alarm[UpperBound(istr_group_alarm[j].astr_alarm[]) + 1] = lstr_alarm
	Else
		istr_group_alarm[ UpperBound(istr_group_alarm[]) + 1 ].as_email_address = Trim(ls_mailuser[i])
		istr_group_alarm[ UpperBound(istr_group_alarm[]) ].as_sender = Trim(ls_sender)
		istr_group_alarm[ UpperBound(istr_group_alarm[]) ].astr_alarm[1] = lstr_alarm
	End If
Next

Return 1
end function

public function integer of_set_actionitem_flags ();Long i
For i = 1 To UpperBound(istr_ai_flag)
	This.of_set_actionitem_flag( istr_ai_flag[i].astr_action_item, istr_ai_flag[i].as_to, istr_ai_flag[i].as_cc, istr_ai_flag[i].as_subject, istr_ai_flag[i].as_attach_name, istr_ai_flag[i].as_flag)
Next

Return 1
end function

public subroutine of_trigger_by_onlogin ();//Add by jervis 09.01.2010
//Trigger work flow when login contractlogix system
datastore lds_ctx_all
datastore lds_doc_all
datastore lds_view_list,lds_all_view
long ll_i,ll_j,i
long ll_count
long ll_ctx_id
long ll_doc_id
long ll_view_id
long ll_screen[]
string ls_updatecol[], ls_views,ls_view, ls_view_list[]
long ll_view_list[]


lds_ctx_all = create datastore
lds_doc_all = create datastore
lds_view_list = create datastore
lds_all_view = Create datastore 

lds_ctx_all.dataobject = "d_contract_access_pt"
lds_doc_all.dataobject = "d_dm_doc_all_list"
lds_view_list.dataobject = "d_wf_view_list"
lds_all_view.dataobject = 'd_select_views_choose'

lds_ctx_all.SetTransObject( sqlca)
lds_doc_all.SetTransObject( sqlca)
lds_view_list.SetTransObject( sqlca)
lds_all_view.SetTransObject( sqlca)

gnv_appeondb.of_startqueue( )
	lds_view_list.Retrieve( )
	lds_all_view.Retrieve()
gnv_appeondb.of_commitqueue( )

//Added By Ken.Guo 12/24/2012
If lds_view_list.Find( 'wf_triggered_view = "all"' , 1, lds_view_list.RowCount() ) > 0 Then
	If lds_all_view.rowcount() > 0  Then
		ll_view_list = lds_all_view.object.data_view_id.primary
	End If
Else
	For i = 1 To lds_view_list.RowCount()
		ls_view = lds_view_list.GetItemString( i, 'wf_triggered_view' )
		If ls_views = '' Then
			ls_views = ls_view
		Else
			If isnumber(ls_view) Then
				ls_views = ls_views + ',' + ls_view
			End If
		End If
	Next 
	If Len(ls_views) > 0 Then
		gnv_string.of_parsetoarray( ls_views, ',', ls_view_list[] )
		For i = 1 To UpperBound(ls_view_list[])
			ll_view_list[i] = Long(ls_view_list[i])
		Next
	End If

End If


//Begin - Added if statement By Mark Lee 08/02/12 the parameter null issues
If Not Isnull(ll_view_list) And UpperBound(ll_view_list) > 0  Then
	lds_ctx_all.Retrieve( gs_user_id,ll_view_list)
	lds_doc_all.Retrieve( gs_user_id,ll_view_list)
End If
//End - Added By Mark Lee 08/02/12

//Get Screen ID List
ll_screen[1] = 3 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_master'"))
ll_screen[2] = 5 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_contract_dates' and dataobject='d_contract_det_master_2'"))
ll_screen[3] = 8 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_notes'"))
ll_screen[4] = 9 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_1' and dataobject='d_contract_det_custom'"))
ll_screen[5] = 4 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_products' and dataobject='d_ctx_products'"))
ll_screen[6] = 7 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_occ' and dataobject='d_contract_det_contact_external'"))
ll_screen[7] = 6 //long(gnv_data.of_getitem("ctx_screen" , "screen_id" , "tab_name='tabpage_details' and dw_name='dw_ccc' and dataobject='d_contract_det_contact_external'"))

ll_count = lds_ctx_all.rowcount( )
for ll_i = 1 to ll_count
	Yield() //Added By Ken.Guo 2010-11-25.
	gnv_status_info.of_display( "["+String(Long(ll_i / ll_count*100)) + "%]"  +" Triggering Contract Folder Data Value Comparison Work Flow ,Please wait...")
	ll_ctx_id = lds_ctx_all.GetItemNumber( ll_i, "ctx_id")
	ll_view_id = lds_ctx_all.GetItemNumber( ll_i, "view_id")
	if ll_ctx_id > 0 then this.of_data_value_comparision( ll_view_id, ll_screen,ls_updatecol,ll_ctx_id,0, '03',"I","L")
next

ll_count = lds_doc_all.rowcount()
for ll_i = 1 to ll_count
	Yield() //Added By Ken.Guo 2010-11-25.
	gnv_status_info.of_display( "["+String(Long(ll_i / ll_count*100)) + "%]"  +" Triggering Document Manager Folder Data Value Comparison Work Flow,Please wait...")
	ll_ctx_id = lds_doc_all.GetItemNumber( ll_i, "ctx_id")
	ll_view_id = lds_doc_all.GetItemNumber( ll_i, "view_id")
	ll_doc_id = lds_doc_all.GetItemNumber( ll_i, "doc_id")
	if ll_ctx_id > 0 then this.of_data_value_comparision( ll_view_id, ll_screen,ls_updatecol,ll_ctx_id,ll_doc_id, '04',"I","L")
next

gnv_status_info.of_display("")

destroy lds_ctx_all
destroy lds_doc_all



end subroutine

public function integer of_data_value_comparision_bak09142010 (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype, string as_triggertype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id[]		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in Contract Logix is contract id.
// al_facility_id		facility id used in IntelliCred/App. Doc id used in Document Manager
// as_module			01-IntelliCred,02-IntelliApp,03-Contract Logix Tracking,04-Contract Logix Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
// as_triggertype		S-On Save, L-On Login  -- jervis 08.31.2010
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_find,ll_rowcount
long 	ll_wf_id , ll_processed_id
integer	i , j, m , li_steps
Datastore lds_data_comparision,lds_data_workflow
String	 ls_tablename , ls_comparision_sqls[] , ls_field_comp , ls_sql , ls_sql_comp
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id , ll_pre_screen
string	 ls_field_name, ls_operator, ls_value , ls_coltype,ls_filter
long		 ll_result[] , ll_pos
boolean   lb_trigger
boolean 	 lb_UpdateFlag
string ls_empty[]		//05/16/2007 by jervis
long 	ll_empty[] 		//12.24.2008 By Jervis
str_action_item lstr_action

li_steps = upperbound(al_screen_id)
If not li_steps > 0 Then return -1

for i = 1 to li_steps
	if i = 1 then
		ls_filter = "(screen_id = " + string(al_screen_id[i])
	else
		ls_filter += " or screen_id = " + string(al_screen_id[i])
	end if
next
ls_filter += ")"

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_workflow = Create DataStore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_workflow.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
lds_data_workflow.settransobject(SQLCA)


//Refresh cache - jervis 01.07.2010
gnv_data.of_retrieve("wf_trigger_param_data_comparison") 

//Begin Modify by Scofield on 2009-03-12
//Add Trigger type Filter - jervis 08.31.2010
gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_workflow_view_id) or wf_workflow_view_id = " + String(al_View_ID) + ") and " + &
											" wf_trigger_type = '" + as_triggertype + "' and " + ls_filter, lds_data_workflow)
//gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "module='"+as_module+"' and " + ls_filter, lds_data_workflow)
//End Modify by Scofield on 2009-03-12

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_workflow.Rowcount( ) 
If not li_steps > 0 Then 
	destroy lds_data_comparision
	destroy lds_data_workflow
	return 1
end if

lds_data_workflow.setsort( "wf_id asc")
lds_data_workflow.sort()

//
DECLARE exec_cur DYNAMIC CURSOR FOR SQLSA ;

//If one screen related more work flow, all work flows shoule be triggered
For  i = 1 to li_steps
	lb_trigger = true
	ls_comparision_sqls = ls_empty	//05/16/2007 By Jervis
	ll_result = ll_empty	//12.24.2008 By Jervis
	lb_UpdateFlag = false	//01.12.2009 By Jervis
	ll_wf_id = lds_data_workflow.Getitemnumber( i, 'wf_id')

	
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 17/05/2007 By: Jervis
	//$<reason> 
	/*
	ll_find = gnv_data.of_findrow("wf_workflow","wf_id="+string(ll_wf_id))
	If not ll_find > 0 Then continue
	*/
	//Get the related work flow trigger parms for the current ll_wf_id from cache data
	lds_data_comparision.Reset()
	gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "wf_id=" + string(ll_wf_id), lds_data_comparision)
	ll_rowcount = lds_data_comparision.RowCount()
	//---------------------------- APPEON END ----------------------------

	
			
	ll_processed_id = ll_wf_id
	
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			lb_UpdateFlag = true //01.12.2008 By Jervis
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue
			
			//F-Field Comparision, S-SQL statement comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				For j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							//12.13.2006 By Jervis to fixed a defect
							//ls_tablename 	= gnv_data.of_get_table_name( al_screen_id , 'P' , 'sys_tables_table_name')
							ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'S','C' //Character-- Add 'S' by jervis 03.12.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
					
					
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
				
			Else //comparision with SQL statement
				For j = 1 to ll_rowcount
					ls_sql_comp = lds_data_comparision.getitemstring(j , 'sql_statement')
					If len(ls_sql_comp) > 0 Then 
						If pos(upper(ls_sql_comp) , ' WHERE ') > 0 Then
							ls_sql_comp = ls_sql_comp + " and prac_id = " + string(al_key_id)
						Else
							ls_sql_comp = ls_sql_comp + " where prac_id = " + string(al_key_id)
						End If
						
						ll_pos = pos(upper(ls_sql_comp) , ' FROM ' )
						If ll_pos > 0 Then
							ls_sql_comp = "select 1 " + mid(ls_sql_comp , ll_pos)
						End if
						ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_sql_comp
					End if
					
				Next
				
			End If
		Case '03','04' //Contract Logix tracking
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
			//j = gnv_data.of_FindRow("wf_trigger_param_data_comparison","wf_id=" + string(ll_wf_id))
			
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				//If j > 0 then	
				FOR j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					//ll_screen_id = long(gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"screen_id"))
					If j = 1 Then
						ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
						ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
							ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					/*
					ls_field_name 	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_name")
					ls_operator	  	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"operator")
					ls_value 		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"value")
					ls_coltype		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_type")
					*/
					
					//01.12.2009 by Jervis:if include the column
					if UpperBound(as_UpdateCol) > 0 then  //Jervis 08.31.2010
						if pos(as_UpdateCol[ll_screen_id],"," + ls_field_name + ",") > 0 then lb_UpdateFlag = true	
					end if
				
					Choose Case ls_coltype
						Case 'S','C' //Character --Add 'S' by jervis 03.12.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
							if ls_operator = "is" then //Jervis 11.11.2009
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
							else
								if isdate(ls_value) then
									ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
								else
									ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + ls_value //jervis 01.18.2010
								end if
							end if
					End Choose
				Next
				If len(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
			End if
		//Case '04' //Contract Logix Agreement //Comment 06/20/2007 by: Andy
			
	End Choose
	
	
	//1.12.2009 By Jervis 
	// It should ONLY trigger if the data in the fields that are in the Data Value Comparison-> Trigger Parameters of a work flow are changed to match criteria
	if UpperBound(as_UpdateCol) > 0  and lb_UpdateFlag = false then continue  //Add "UpperBound(as_UpdateCol) > 0 " - jervis 08.31.2010
	
	
	//Compare
	If upperbound(ls_comparision_sqls) > 0 Then
		For m = 1 to upperbound(ls_comparision_sqls)
			ls_sql = ls_comparision_sqls[m]

			PREPARE SQLSA FROM :ls_sql ;
			OPEN DYNAMIC exec_cur ;
			FETCH exec_cur INTO :ll_result[m] ;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.07.2006 By: Jervis
			//$<reason> Fix a defect for APB
			if sqlca.sqlcode <> 0 then
				ll_result[m] = 0
			end if
			//---------------------------- APPEON END ----------------------------

			close exec_cur;
		Next
	End If
	For m = 1 to upperbound(ll_result)
		If ll_result[m] <> 1 Then lb_trigger = false
	Next
	
	//trigger the related work flow
	If lb_trigger Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		//<add> 06/20/2007 by: Andy 
		//Remark:al_facility_id equal to Doc id used in Document Manager
		lstr_action.doc_id = al_facility_id
		//end of add
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Destroy lds_data_workflow
Return 1
end function

public function integer of_data_value_comparision (long al_view_id, long al_screen_id[], string as_updatecol[], long al_key_id, long al_facility_id, string as_module, string as_runtype, string as_triggertype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id[]		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in Contract Logix is contract id.
// al_facility_id		facility id used in IntelliCred/App. Doc id used in Document Manager
// as_module			01-IntelliCred,02-IntelliApp,03-Contract Logix Tracking,04-Contract Logix Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
// as_triggertype		S-On Save, L-On Login  -- jervis 08.31.2010
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
// 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_find,ll_rowcount
long 	ll_wf_id , ll_processed_id
Datastore lds_data_comparision,lds_data_workflow
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id
str_action_item lstr_action
long li_trigger
integer i,li_steps
string ls_filter
string ls_where

li_steps = upperbound(al_screen_id)
If not li_steps > 0 Then return -1

for i = 1 to li_steps
	if i = 1 then
		ls_filter = "(screen_id = " + string(al_screen_id[i])
	else
		ls_filter += " or screen_id = " + string(al_screen_id[i])
	end if
next
ls_filter += ")"

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_workflow = Create DataStore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_workflow.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
lds_data_workflow.settransobject(SQLCA)


//Refresh cache - jervis 01.07.2010
gnv_data.of_retrieve("wf_trigger_param_data_comparison") 

//Begin - Modified By Ken.Guo 12/20/2012. Support Set View List and only Active Status WF can be triggered.
//Add Trigger type Filter - jervis 08.31.2010
//if as_triggertype = 'L' then	//jervis 09.19.2010
//	gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_workflow_view_id) or wf_workflow_view_id = " + String(al_View_ID) + ") and " + &
//											" wf_trigger_onlogin = 'Y' and " + ls_filter, lds_data_workflow)
//else
//	gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_workflow_view_id) or wf_workflow_view_id = " + String(al_View_ID) + ") and " + &
//											" wf_trigger_onsave = 'Y' and " + ls_filter, lds_data_workflow)
//end if
if as_triggertype = 'L' then	//jervis 09.19.2010
	gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_triggered_view) or wf_triggered_view = 'all' or Pos(wf_triggered_view , '" + String(al_View_ID) + "' ) > 0  ) and " + &
											" wf_trigger_onlogin = 'Y' and wf_status = 'A' and " + ls_filter, lds_data_workflow)
else
	gnv_data.of_get_data_from_cache('wf_trigger_param_data_comparison',"module = '" + as_module + "' and (IsNull(wf_triggered_view) or wf_triggered_view = 'all' or Pos(wf_triggered_view , '" + String(al_View_ID) + "' ) > 0  ) and " + &
											" wf_trigger_onsave = 'Y' and wf_status = 'A' and " + ls_filter, lds_data_workflow)
end if
//End - Modified By Ken.Guo 12/20/2012

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_workflow.Rowcount( ) 
If not li_steps > 0 Then 
	destroy lds_data_comparision
	destroy lds_data_workflow
	return 1
end if

lds_data_workflow.setsort( "wf_id asc")
lds_data_workflow.sort()



//If one screen related more work flow, all work flows shoule be triggered
For  i = 1 to li_steps
	ll_wf_id = lds_data_workflow.Getitemnumber( i, 'wf_id')

	
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	ll_processed_id = ll_wf_id

	//Get the related work flow trigger parms for the current ll_wf_id from cache data
	lds_data_comparision.Reset()
	gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "wf_id=" + string(ll_wf_id), lds_data_comparision)
	ll_rowcount = lds_data_comparision.RowCount()
			
	ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
	ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
	If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			li_trigger = -1
		Case '03','04' //Contract Logix tracking
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field
				//Compare
				li_trigger = f_ctx_find(al_key_id,lds_data_comparision,as_updatecol[],'2',ls_where)			
			End if
	End Choose
	

	//trigger the related work flow
	If li_trigger > 0 Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		//<add> 06/20/2007 by: Andy 
		//Remark:al_facility_id equal to Doc id used in Document Manager
		lstr_action.doc_id = al_facility_id
		//end of add
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Destroy lds_data_workflow
Return 1
end function

public function integer of_advanced_update_10122010 (string as_module, long al_ctx_id, long al_doc_id, long al_wf_id, long al_step_id, long al_status_id);datastore	lds_update
datastore	lds_screen
long ll_i
long ll_count,ll_row
string ls_tablename
string ls_fieldname
string ls_datatype
string ls_value
string ls_fieldflag
string ls_sql[]
long ll_screen_id
long ll_pre_screen_id
string ls_expression
n_cst_string lnvo_string

lds_update = create DataStore
lds_screen = create DataStore
lds_update.DataObject = "d_wf_advanced_update"
lds_update.SetSort( "Screen_id, field_flag ")
lds_update.SetTransObject( sqlca)
ll_count = lds_update.Retrieve( al_wf_id,al_step_id,al_status_id)

for ll_i = 1 to ll_count
	ll_screen_id = lds_update.GetItemNumber(ll_i,'screen_id')
	ls_fieldflag = lds_update.GetItemString(ll_i,'field_flag')
	ls_datatype = lds_update.GetItemString(ll_i,'field_type')
	ls_tablename = lds_update.GetItemString(ll_i,'table_name')
	ls_fieldname = lds_update.GetItemString(ll_i,'field_name')
	ls_value = lds_update.GetItemString(ll_i,'field_value')
	choose case ls_fieldflag
		case 'V','U'	//Value //Add 'U' type -- jervis 05.14.2010
			choose case ls_datatype
				case 'S','C'	//Char
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = '" + ls_value + "'"
				case 'D'			//date,datetime
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = Cast('" + ls_value + "' as datetime)"
				case 'N','I'	//Number
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
			end choose
		case 'L','C','P'	//Lookup, Add 'C','P' - jervis 05.14.2010
			//if Code lookup exists
			ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
		case 'E'	//Expression
			ls_expression= lds_update.GetItemString(ll_i,'field_expression')
			if ll_screen_id <> ll_pre_screen_id then
				if as_module = '03' then
					//Get DataObject Name
					lds_screen.dataobject = gnv_data.of_get_table_name( ll_screen_id, 'C', 'dataobject')
					lds_screen.SetTransObject( sqlca)
					ll_row = lds_screen.Retrieve(al_ctx_id )
					if ll_row = 1 then lds_screen.Modify( "create compute(band=Detail x='1' y='1' height='2' width='2' name=dynamic_compute_1 expression='')")
				elseif as_module = '04' then
				end if
			end if 
			if ll_row = 1 then
				//replace ' with "
				ls_expression  = lnvo_string.of_globalreplace( ls_expression, '~~', '~~~~')
				ls_expression  = lnvo_string.of_globalreplace( ls_expression, '"', '~~"')
				lds_screen.Modify( 'dynamic_compute_1.expression = "' + ls_expression + '"')
				
				choose case ls_datatype
					case 'S','C'	//Char
						ls_value = lds_screen.GetItemString( ll_row,"dynamic_compute_1")
						ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = '" + ls_value + "'"
					case 'D'			//date,datetime
						ls_value = string(lds_screen.GetItemDatetime( ll_row,"dynamic_compute_1"))
						ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = Cast('" + ls_value + "' as datetime)"
					case 'N','I'	//Number
						ls_value = string(lds_screen.GetItemNumber( ll_row,"dynamic_compute_1"))
						ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
				end choose
			end if
	end choose
	
	if as_module = '03'	then	//Contract
		//Screen ID,3-Contract Detail,5-Contract Date,9-Contract Custom Data,8-Contract Notes
		//if ll_screen_id = ..... then
		ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id)
	elseif as_module = '04' then	//Document Manager
		//if ll_screen_id = ..... then
		//ls_sql[ll_i] += " where doc_id = " + string(al_ctx_id)//fixed bug - jervis 05.14.2010
		ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id) 
	end if
	ll_pre_screen_id = ll_screen_id

	//Added By Ken.Guo 2010-06-11. update contract status track
	If ls_tablename = 'ctx_basic_info' and ls_fieldname = 'status' Then
		gf_statusaudit(al_ctx_id,long(ls_value),'status') //add 'status' -- jervis 04.25.2011
	End If
	
next

gnv_appeondb.of_startqueue( )
ll_count = UpperBound(ls_sql)
if ll_count > 0 then
	for ll_i = 1 to ll_count
		EXECUTE Immediate :ls_sql[ll_i] Using Sqlca;
	next
	commit;
end if
gnv_appeondb.of_commitqueue( )

//Refresh data when the contract window has been open- 5.15.2009  By Jervis
if ll_count > 0 and isvalid(gw_contract) then
	gw_contract.tab_contract_details.tabpage_details.ib_retrieved = false
	gw_contract.tab_contract_details.tabpage_details.uo_1.ib_retrieved = false
	gw_contract.tab_contract_details.tabpage_details.of_retrieve( )
end if


destroy lds_update
destroy lds_screen

return 1
end function

public function integer of_advanced_update (string as_module, long al_ctx_id, long al_doc_id, long al_wf_id, long al_step_id, long al_status_id);datastore	lds_update
datastore	lds_screen
datastore	lds_whereclause
long ll_i
long ll_count,ll_row
string ls_tablename
string ls_fieldname
string ls_datatype
string ls_value
string ls_fieldflag
string ls_sql[]
long ll_screen_id
long ll_pre_screen_id
string ls_expression
long ll_keyid
string ls_where
string ls_updatecol[]
n_cst_string lnvo_string

lds_update = create DataStore
lds_screen = create DataStore

lds_update.DataObject = "d_wf_advanced_update"
lds_update.SetSort( "Screen_id, field_flag ")
lds_update.SetTransObject( sqlca)
ll_count = lds_update.Retrieve( al_wf_id,al_step_id,al_status_id)

lds_whereclause = create dataStore
lds_whereclause.Dataobject = "d_wf_advanced_update_criteria"
lds_whereclause.SetTransObject( sqlca)

for ll_i = 1 to ll_count
	Yield() //Added By Ken.Guo 2010-11-25.
	ll_screen_id = lds_update.GetItemNumber(ll_i,'screen_id')
	ls_fieldflag = lds_update.GetItemString(ll_i,'field_flag')
	ls_datatype = lds_update.GetItemString(ll_i,'field_type')
	ls_tablename = lds_update.GetItemString(ll_i,'table_name')
	ls_fieldname = lds_update.GetItemString(ll_i,'field_name')
	ls_value = lds_update.GetItemString(ll_i,'field_value')
	ll_keyid = lds_update.GetItemNumber(ll_i,'key_id')
	ls_where = ""
	choose case ls_fieldflag
		case 'V','U'	//Value //Add 'U' type -- jervis 05.14.2010
			choose case ls_datatype
				case 'S','C'	//Char
					ls_value  = lnvo_string.of_globalreplace( ls_value, "'", "''") //replace ' to '' -- jervis 04.14.2011
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = '" + ls_value + "'"
				case 'D'			//date,datetime
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = Cast('" + ls_value + "' as datetime)"
				case 'N','I'	//Number
					ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
			end choose
		case 'L','C','P'	//Lookup, Add 'C','P' - jervis 05.14.2010
			//if Code lookup exists
			ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
		case 'E'	//Expression
			ls_expression= lds_update.GetItemString(ll_i,'field_expression')
			if ll_screen_id <> 31 and ll_screen_id <> 33 then	//Action Item and Fee Screens - jervis 11.03.2010
				if ll_screen_id <> ll_pre_screen_id then
					if as_module = '03' OR as_module = '04' then//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT112501,append as_module = '04' condition
						//Get DataObject Name
						lds_screen.dataobject = gnv_data.of_get_table_name( ll_screen_id, 'C', 'dataobject')
						lds_screen.SetTransObject( sqlca)
						ll_row = lds_screen.Retrieve(al_ctx_id )
						if ll_row = 1 then lds_screen.Modify( "create compute(band=Detail x='1' y='1' height='2' width='2' name=dynamic_compute_1 expression='')")
					//elseif as_module = '04' then//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT112501
					end if
				end if 
				if ll_row = 1 then
					//replace ' with "
					ls_expression  = lnvo_string.of_globalreplace( ls_expression, '~~', '~~~~')
					ls_expression  = lnvo_string.of_globalreplace( ls_expression, '"', '~~"')
					if lds_screen.Modify( 'dynamic_compute_1.expression = "' + ls_expression + '"') = '' then
						//PB Format Expresstion
						choose case ls_datatype
							case 'S','C'	//Char
								ls_value = lds_screen.GetItemString( ll_row,"dynamic_compute_1")
								ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = '" + ls_value + "'"
							case 'D'			//date,datetime
								ls_value = string(lds_screen.GetItemDatetime( ll_row,"dynamic_compute_1"))
								ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = Cast('" + ls_value + "' as datetime)"
							case 'N','I'	//Number
								ls_value = string(lds_screen.GetItemNumber( ll_row,"dynamic_compute_1"))
								ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_value 
						end choose
					else	//SQL Format Expression -- jervis 11.03.2010
						ls_expression= lds_update.GetItemString(ll_i,'field_expression')
						ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_expression 
					end if
				end if
			else //SQL Format Expression -- jervis 11.03.2010
				ls_sql[ll_i] = "update "+ ls_tablename + " set " + ls_fieldname + " = " + ls_expression 
			end if
	end choose
	
	if as_module = '03'	then	//Contract
		//Screen ID,3-Contract Detail,5-Contract Date,9-Contract Custom Data,8-Contract Notes
		if ll_screen_id = 31 or ll_screen_id = 33 then	//Fee Schedule or Action Item Screen - jervis 09.28.2010
			lds_whereclause.Retrieve(al_wf_id,al_step_id,al_status_id, ll_keyid,ll_screen_id )
			if f_ctx_find(al_ctx_id,lds_whereclause,ls_updatecol,'2',ls_where) >= 0 then
				ls_sql[ll_i] += " where 1=1  " + ls_where
			else
				ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id)
			end if
		else
			ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id)
		end if
	elseif as_module = '04' then	//Document Manager
		//ls_sql[ll_i] += " where doc_id = " + string(al_ctx_id)//fixed bug - jervis 05.14.2010
		if ll_screen_id = 31 or ll_screen_id = 33 then	//Fee Schedule or Action Item Screen - jervis 09.28.2010
			if f_ctx_find(al_ctx_id,lds_whereclause,ls_updatecol,'2',ls_where) >= 0 then
				ls_sql[ll_i] += " where 1=1 " + ls_where
			else
				ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id)
			end if
		else
			ls_sql[ll_i] += " where ctx_id = " + string(al_ctx_id) 
		end if
	end if
	ll_pre_screen_id = ll_screen_id

	//Added By Ken.Guo 2010-06-11. update contract status track
	If ls_tablename = 'ctx_basic_info' and ls_fieldname = 'status' Then
		gf_statusaudit(al_ctx_id,long(ls_value),'status')  //add 'status' -- jervis 04.25.2011
	End If
	
next

gnv_appeondb.of_startqueue( )
ll_count = UpperBound(ls_sql)
if ll_count > 0 then
	for ll_i = 1 to ll_count
		if Not (IsNull(ls_sql[ll_i]) or ls_sql[ll_i] = "") then  //(Appeon)Harry 11.28.2013 - V141 for BugH112602 of Reintegration Issues
			EXECUTE Immediate :ls_sql[ll_i] Using Sqlca;
		end if
	next
	commit;
end if
gnv_appeondb.of_commitqueue( )

//Refresh data when the contract window has been open- 5.15.2009  By Jervis
if ll_count > 0 and isvalid(gw_contract) then
	gw_contract.tab_contract_details.tabpage_details.ib_retrieved = false
	gw_contract.tab_contract_details.tabpage_details.uo_1.ib_retrieved = false
	gw_contract.tab_contract_details.tabpage_details.of_retrieve( )
end if


destroy lds_update
destroy lds_screen
destroy lds_whereclause

return 1
end function

public function string of_replace_export (ref string as_message, ref datastore ads_export, long al_row);n_cst_string  lnv_string
string ls_begin_separator,ls_end_separator,ls_name,ls_value
long ll_begin,ll_end,ll_ret

//Added By Ken.Guo 2011-04-13.
If al_row <= 0 Then al_row = 1
If ads_export.RowCount() = 0 Then Return as_message

ls_begin_separator = "$<"
ls_end_separator = ">$"

if match(as_message,"\$\<.*\>\$") then
	//Replace the filed flag for email message
	ll_begin = pos(as_message,ls_begin_separator,1)
	do while ll_begin > 0
		ll_end = pos(as_message,ls_end_separator,ll_begin + 2)
		
		//------Begin Modified by Alfee 05.08.2007-----------------------------
		if ll_end > 0 then
			ls_name = mid(as_message,ll_begin + 2,ll_end - ll_begin - 2)
			if IsNumber(ads_export.Describe(ls_name+".x")) then					
				ls_value = Trim(ads_export.GetItemString(al_row,ls_name))
				if isnull(ls_value) then ls_value = ""
				as_message = lnv_string.of_globalreplace( as_message, mid(as_message,ll_begin,ll_end - ll_begin + 2),ls_value)
				ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))					
			else
				ll_begin = pos(as_message,ls_begin_separator, ll_end)				
			end if
		Else//modfied by gavins 20130407
			exit
		end if
		//ll_begin = pos(as_message,ls_begin_separator,ll_begin + len(ls_value))
		//--------End Modified-----------------------------------
	loop

end if
return as_message
end function

public function integer of_send_mail (string as_by_user, string as_to_users, string as_cc_users, ref str_email astr_emailinfo, long al_ctx_id, long al_doc_id, long al_action_item_id);//Added By Alan on 2009-2-29
//overroad of_send_mail,add parameter

string 	ls_users[],ls_message,ls_filename,ls_Notes,ls_AttachName,ls_AttachList
integer 	ll_Return
string 	ls_mailto[],ls_mailcc[],ls_to_users,ls_cc_users
Blob		lbob_Message,lblb_Attach[]
long		ll_Cycle,ll_RowCnts,ll_AttachID,ll_Pos
str_email_info lstr_email_info
CONSTANT STRING COMMACHAR = ","
Integer li_send_result = 0

//--------------------------- APPEON BEGIN //---------------------------
//$<Modify> 2007-05-30 By: Scofield
//$<reason> Fix a defect

ls_to_users = Trim(as_to_users)
ls_cc_users = Trim(as_cc_users)

If IsNull(ls_to_users) or Trim(ls_to_users) = '' Then return -1
//---------------------------- APPEON END ----------------------------
if astr_emailinfo.name = "" then return -1	//02.03.2008 by Jervis: mail invalid.

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-20 By: Scofield
//$<Reason> Create multiple attachments

ids_EmailAttach.DataObject = "d_Email_Attach"
ids_EmailAttach.SetTransObject(SQLCA)
ids_EmailAttach.Retrieve(il_Mail_id)

ll_RowCnts = ids_EmailAttach.RowCount()
for ll_Cycle = 1 to ll_RowCnts
	ls_AttachName = ids_EmailAttach.GetItemString(ll_Cycle,"attach_name")
	ll_AttachID = ids_EmailAttach.GetItemNumber(ll_Cycle,"attach_id")
	
	of_GetEmailAttachment(il_Mail_id,ll_AttachID,lblb_Attach[UpperBound(lblb_Attach) + 1])
	if Len(lblb_Attach[UpperBound(lblb_Attach)]) > 0 then
		ls_FileName = gs_dir_path + gs_DefDirName + "\" + ls_AttachName
		in_FileSrv.of_FileWrite(ls_FileName, lblb_Attach[UpperBound(lblb_Attach)],false)
		
		ls_AttachList += ls_FileName + COMMACHAR
	end if
next

if Not (IsNull(ls_AttachList) or Trim(ls_AttachList) = "") then
	ls_AttachList = Left(ls_AttachList,Len(ls_AttachList) - 1)
end if

/*
if len(astr_emailinfo.attach_name) > 0 then
	ls_filename = gs_dir_path + gs_DefDirName + "\" + astr_emailinfo.attach_name
	lnv_filesrv = create n_cst_filesrv
	if FileExists(ls_filename) then	//06/20/2007 by Jervis
		FileDelete (ls_filename )
	end if
	if lnv_filesrv.of_filewrite(ls_filename,astr_emailinfo.attach,false) < 0 then
		destroy lnv_filesrv
		return -1
	end if
	destroy lnv_filesrv
end if
*/
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.
//long.zhang 12.19.2013 Moved From below
String	ls_Addresser

select top 1 set_addresser into :ls_Addresser from icred_settings;

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = as_by_user
end if
//---------------------------- APPEON END ----------------------------
//-------------appeon begin----------------------
//<$>added:long.zhang 12.19.2013
//<$>reason:V14.1 Check if the Email sender are corrected

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	inv_message.of_MessageBox('Send Email','Invalid Email sender. Please check if the system addresser was correctly  set in application settings~r~n' + &
	' or the set assigned by field was correctly set in work flow steps',true)
	return -1
end if

//-------------appeon End------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-26 By: Scofield
//$<Reason> Send blob data.

of_Get_EmailMessage(il_Mail_id,lbob_Message)

Open(w_email_edit)
w_email_edit.ole_word.of_Open(lbob_Message)

n_cst_word_utility lnv_word

lnv_word = Create n_cst_word_utility
lnv_word.il_doc_id = This.il_doc_id

//Add Subject-- jervis 09.09.2009
//lnv_word.of_replace_export_word(w_email_edit.ole_Word.Object.ActiveDocument, il_data_id, il_export_id)
lnv_word.of_set_str_action_item(istr_action_item)  //(Appeon)Harry 04.10.2014 -  for Bug 3998
lnv_word.of_replace_export_word(w_email_edit.ole_Word.Object.ActiveDocument, astr_emailinfo.subject,il_data_id, il_export_id)
Destroy lnv_word

ls_Notes = astr_emailinfo.notes
if Not IsNull(ls_Notes) and ls_Notes <> "" then
	w_email_edit.ole_word.of_InsertTextLast(ls_Notes)
end if

//---------------------------- APPEON END ----------------------------



//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//ll_Return = lnv_Redmail.of_start_email( ls_mailto,ls_mailcc, ls_message,astr_emailinfo.subject, ls_filename)

n_cst_easymail_smtp 	lnv_Mail

if lnv_Mail.of_CreateObject() = -1 then
	//Added by Nova.zhang on 2008-11-07
	f_show_message('create Email object','','','','')
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	Return -1
end if

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.
//------------Begin commented by long.zhang appeon 12.19.2013 Move to top
//String	ls_Addresser
//
//select top 1 set_addresser into :ls_Addresser from icred_settings;
//
//if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
//	ls_Addresser = as_by_user
//end if
//-------------End Comment------------------------------
//---------------------------- APPEON END ----------------------------

 lnv_Mail.of_set_combine_status(false) //(Appeon)Harry 03.11.2014 - for Bug # 3887
 
//--------------------------- APPEON BEGIN ---------------------------
//$<Moidfy > 2009-1-20 By: Jervis
//$<Reason> Auto Generate Email Signature, don't append any email signatures by Default.
if astr_emailinfo.autosign = 'N' then
	ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_to_users, ls_cc_users, '',astr_emailinfo.subject, w_email_edit.ole_Word, ls_AttachList,false,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
else
	ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_to_users, ls_cc_users, '',astr_emailinfo.subject, w_email_edit.ole_Word, ls_AttachList,true,al_ctx_id,al_doc_id,al_action_item_id) //Modified By Alan on 2009-2-19
end if
//---------------------------- APPEON END ----------------------------

w_email_edit.ole_word.of_Close()
Close(w_email_edit)

if ll_Return <> 0 then
	
	//Added By Ken.Guo 2009-10-13.
	gstr_email_info.ss_email_from =  'Work Flow'
	gstr_email_info.sl_ctx_id = istr_action_item.ctx_id
	gstr_email_info.sl_wf_id = istr_action_item.wf_id
	gstr_email_info.sl_doc_id = istr_action_item.doc_id
	
	//Added by Nova.zhang on 2008-11-07
	f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	lnv_Mail.of_DeleteObject()
	gstr_email_info = lstr_email_info //Added By Ken.Guo 2009-10-13.
	li_send_result = -1
	//return -1
end if

//Added By Ken.Guo 2010-11-15. Email Audit
String ls_errtext,ls_attachfilename,ls_columnname,ls_email_type,ls_computer_info
n_cst_string lnv_string
If ll_Return <> 0 then 
	ls_errtext = gnv_message.of_get_error_message( ll_Return)  
End If
ls_attachfilename = lnv_string.of_get_file_name( ls_AttachList, ',') 
If ii_send_type = 3 Then
	If istr_action_item.doc_id > 0 Then
		ls_email_type = 'Document Action Item Due Date Reminder'
	Else
		ls_email_type = 'Contract Action Item Due Date Reminder'
	End If
	ls_columnname = 'Due Date (due_date)'
Else
	ls_columnname = ''
	ls_email_type = 'Work Flow'
End If
ls_computer_info = lnv_Mail.of_get_compute_info( ) 

Insert Into em_mail_audit
(user_id,mail_from,mail_to,mail_cc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,compute_info)
Values 
(:gs_user_id,:ls_Addresser,:ls_to_users,:ls_cc_users,:astr_emailinfo.subject,getdate(),:ls_attachfilename,:il_Mail_id,:istr_action_item.ctx_id,:istr_action_item.doc_id,:istr_action_item.ctx_action_item_id,:istr_action_item.wf_id,:ls_email_type,:ls_columnname,:li_send_result,:ls_errtext,:ls_computer_info);

if ll_Return <> 0 then Return -1


lnv_Mail.of_DeleteObject()

gstr_email_info = lstr_email_info //Added By Ken.Guo 2009-10-13.

//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-20 By: Scofield
//$<Reason> Delete the email attach file after send mail.

if Right(ls_AttachList,1) <> COMMACHAR then ls_AttachList += COMMACHAR

ll_Pos = Pos(ls_AttachList,COMMACHAR)
do while ll_Pos > 0
	ls_FileName = Trim(Left(ls_AttachList,ll_Pos - 1))
	if FileExists(ls_FileName) then FileDelete(ls_FileName)
	
	ls_AttachList = Trim(Mid(ls_AttachList,ll_Pos + 1))
	ll_Pos = Pos(ls_AttachList,COMMACHAR)
loop

/*
if FileExists(ls_filename) then
	FileDelete (ls_filename )
end if
*/

//---------------------------- APPEON END ----------------------------

return 1

end function

public function integer of_create_sub_contracts (long al_ctx_id, long al_ai_id);//====================================================================
// Function: of_create_sub_contracts
//--------------------------------------------------------------------
// Description: Create Sub Contracts for US Bank Customer.
//--------------------------------------------------------------------
// Arguments:
//                al_ctx_id
//                al_ai_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 09/26/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_notes_contract, ll_notes_credit,ll_new_ctx_id1,ll_new_ctx_id2
String ls_key_contract = 'Create Contract Sub Contract'
String ls_key_credit = 'Create Credit Sub Contract'
Long ll_type_sub, ll_category_sub_contract, ll_category_sub_credit
String ls_default_copy_ctx, ls_company_name
str_copy_ctx lstr_copy_ctx
n_cst_copy_ctx lnv_copy_ctx
If al_ctx_id < 0 or isnull(al_ctx_id) Then Return 0
If al_ai_id <= 0 Then Return 0


//Get lookup data and default data
gnv_appeondb.of_startqueue( )
	Select Count(1) Into :ll_notes_contract From ctx_action_items 
	Where ctx_id = :al_ctx_id and ctx_action_item_id >= :al_ai_id and CharIndex( :ls_key_contract , Notes) > 0 ;
	
	Select Count(1) Into :ll_notes_credit From ctx_action_items 
	Where ctx_id = :al_ctx_id and ctx_action_item_id >= :al_ai_id and CharIndex( :ls_key_credit , Notes) > 0 ;
	
	Select app_facility.facility_name Into :ls_company_name  from ctx_basic_info, app_facility Where ctx_basic_info.app_facility = app_facility.facility_id and ctx_basic_info.ctx_id = :al_ctx_id;
	
	Select Top 1 lookup_code Into :ll_type_sub From code_lookup Where lookup_name='Contract Type' and Rtrim(Ltrim(custom_4))='SUB' ;
	Select Top 1 lookup_code Into :ll_category_sub_contract From code_lookup Where lookup_name='Contract Category' and Rtrim(Ltrim(custom_4))='CONTRACTSUB' ;
	Select Top 1 lookup_code Into :ll_category_sub_credit From code_lookup Where lookup_name='Contract Category' and Rtrim(Ltrim(custom_4))='CREDITSUB' ;
	Select Top 1 default_copy_contract Into :ls_default_copy_ctx From icred_settings;
gnv_appeondb.of_commitqueue( )

//Check Data
If ll_notes_credit = 0 and ll_notes_contract = 0 Then
	Return 0
End If
If ls_default_copy_ctx = '' Then
	gnv_debug.of_output(true, 'Please set the default copy contract settings first.')
	Return -1
End If
If isnull(ll_type_sub) or ll_type_sub = 0 Then
	gnv_debug.of_output(true, 'Please add a Contract Type with the value "SUB" in Lookup Painter for custom_4 field first.')
	Return -2
End If
If isnull(ll_category_sub_contract) or ll_category_sub_contract = 0 Then
	gnv_debug.of_output(true, 'Please add a Contract Category with the value "CONTRACTSUB" in Lookup Painter for custom_4 field first.')
	Return -3
End If
If isnull(ll_category_sub_credit) or ll_category_sub_credit = 0 Then
	gnv_debug.of_output(true, 'Please add a Contract Category with the value "CREDITSUB" in Lookup Painter for custom_4 field first.')
	Return -4
End If

//Parse Default Setting for Copy Contract
of_parse_default_copy_ctx(lstr_copy_ctx,ls_default_copy_ctx) 

//Set Other Data
lstr_copy_ctx.si_is_template = 0
lstr_copy_ctx.sl_ctx_id = al_ctx_id
If isnull(ls_company_name) Then
	ls_company_name = string(al_ctx_id) 
Else
	ls_company_name =  string(al_ctx_id) + '-' +ls_company_name
End If

//Create Contract Category Sub Contract 
If ll_notes_contract > 0 Then
	lnv_copy_ctx = Create n_cst_copy_ctx
	lstr_copy_ctx.as_copy_sub_ctx = ls_key_contract
	ll_new_ctx_id1 = lnv_copy_ctx.of_copy_ctx_data( lstr_copy_ctx)
	If isvalid(lnv_copy_ctx) then destroy lnv_copy_ctx
	If ll_new_ctx_id1 > 0 Then
		Update ctx_basic_info Set category =: ll_category_sub_contract, contract_type = :ll_type_sub, master_contract_id = :al_ctx_id, master_contract_name = :ls_company_name Where ctx_id = :ll_new_ctx_id1 ;
	End If
End If

//Create Credit Category Sub Contract
If ll_notes_credit > 0 Then
	lnv_copy_ctx = Create n_cst_copy_ctx
	lstr_copy_ctx.as_copy_sub_ctx = ls_key_credit
	ll_new_ctx_id2 = lnv_copy_ctx.of_copy_ctx_data( lstr_copy_ctx)
	If isvalid(lnv_copy_ctx) then destroy lnv_copy_ctx
	If ll_new_ctx_id2 > 0 Then
		Update ctx_basic_info Set category =: ll_category_sub_credit, contract_type = :ll_type_sub , master_contract_id = :al_ctx_id, master_contract_name = :ls_company_name Where ctx_id = :ll_new_ctx_id2 ;
	End If
End If


Return 1
end function

public function integer of_parse_default_copy_ctx (ref str_copy_ctx lstr_copy_ctx, string ls_value);//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
Long i
n_cst_string lnv_string 
String ls_value_arr[]

If ls_value = '' or isnull(ls_value) Then Return -1

lnv_string.of_parsetoarray( ls_value, ',',  ls_value_arr[])

For i = 1 To UpperBound(ls_value_arr[])
	If ls_value_arr[i] = '0' or isnull(ls_value_arr[i]) Then
		Continue
	End If
	Choose Case i
		Case 1
			lstr_copy_ctx.sb_contract_detail = 1
		Case 2
			lstr_copy_ctx.sb_contract_dates = 1
		Case 3
			lstr_copy_ctx.sb_custom_data = 1
		Case 4
			lstr_copy_ctx.sb_notes = 1
		Case 5
			lstr_copy_ctx.sb_contracted_contacts = 1
		Case 6
			lstr_copy_ctx.sb_our_contacts = 1
		Case 7
			lstr_copy_ctx.sb_products = 1
		Case 8
			lstr_copy_ctx.sb_requirements = 1
		Case 9
			lstr_copy_ctx.sb_other_contacts = 1
		Case 10
			lstr_copy_ctx.sb_locations = 1
		Case 11
			lstr_copy_ctx.sb_organizations = 1
		Case 12
			lstr_copy_ctx.sb_fee_schedule = 1
		Case 13
			lstr_copy_ctx.sb_action_items = 1
		Case 14
			lstr_copy_ctx.sb_document_manager = 1
		Case 15
			lstr_copy_ctx.sb_custom_data2 = 1
		Case 16
			lstr_copy_ctx.sb_custom_multi = 1
		Case 17
			lstr_copy_ctx.sb_group_access = 1
	End Choose
Next

Return 1
end function

public function integer of_reminder_mail_process_ctx ();//////////////////////////////////////////////////////////////////////////////
//	Function:  of_reminder_mail_process_ctx
//	Arguments:  none
//	Returns:  none
//	Description: Remind mail process for IntelliCred/App only
//////////////////////////////////////////////////////////////////////////////
//	Revision History:  Rewrite this funcion by Ken.Guo 2010-08-10.
//  (from CLX)Renamed by (Appeon)Alfee 06.21.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////////////

integer li_product,i,li_count
long ll_facility_id
long ll_prac[],ll_rowcount,ll_find
long ll_cnt 
string ls_sql
string ls_dept_chair[]
str_action_item   lstr_action[]
datastore lds_dept_chair,lds_reminder_due_date

//openwithparm( w_appeon_gifofwait, "Send E-Mail for Reminder Due Date,Please wait..." )
//gnv_status_info.of_display("Send E-Mail for Reminder Due Date,Please wait...")

lds_reminder_due_date = Create datastore
lds_reminder_due_date.dataobject = 'd_ctx_reminder_email'
lds_reminder_due_date.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_reminder_due_date.Retrieve()
	Select set_addresser into :is_sa_address from  icred_settings; 
gnv_appeondb.of_commitqueue( )
If isnull(is_sa_address) Then is_sa_address = ''
li_count = lds_reminder_due_date.rowcount()

//Send email
for i = 1 to li_count
	Yield() //Added By Ken.Guo 2010-11-25.
	gnv_status_info.of_display(  "["+String(Long(i / li_count*100)) + "%]"  + " Sending E-Mail for Reminder Due Date,Please wait...")
	lstr_action[i].ctx_action_item_id = lds_reminder_due_date.GetItemNumber(i,'ctx_action_item_id')
	lstr_action[i].ctx_id = lds_reminder_due_date.GetItemNumber(i,'ctx_id')
	lstr_action[i].doc_id = lds_reminder_due_date.GetItemNumber(i,'doc_id')
	lstr_action[i].seq_no = lds_reminder_due_date.GetItemNumber(i,'seq_id')
	lstr_action[i].wf_id = lds_reminder_due_date.GetItemNumber(i,'wf_id')
	lstr_action[i].wf_step_id = lds_reminder_due_date.GetItemNumber(i,'wf_action_type_id')
	lstr_action[i].due_date = Date(lds_reminder_due_date.GetItemDatetime(i,'due_date'))
	lstr_action[i].wf_action_status_id = lds_reminder_due_date.GetItemNumber(i,'action_status')
	lstr_action[i].reminder_date = Date(lds_reminder_due_date.GetItemDatetime(i,'reminder_last'))
	lstr_action[i].escalation_date = Date(lds_reminder_due_date.GetItemDatetime(i,'escalation_last'))
	
	//For Group Email
	lstr_action[i].al_category =  lds_reminder_due_date.GetItemNumber(i,'category')
	lstr_action[i].as_company =  lds_reminder_due_date.GetItemString(i,'facility_name')
	lstr_action[i].wf_name =  lds_reminder_due_date.GetItemString(i,'wf_workflow_wf_name')
	lstr_action[i].as_column = 'due_date'
	lstr_action[i].as_owner = lds_reminder_due_date.GetItemString(i,'owner')
	lstr_action[i].notes =  lds_reminder_due_date.GetItemString(i,'notes') //(Appeon)Harry 09.06.2015 - Bug # 4704 
	If lstr_action[i].doc_id > 0 Then
		lstr_action[i].as_table = 'ctx_am_action_item'
	Else
		lstr_action[i].as_table = 'ctx_action_item'
	End If
	
	of_send_mail(lstr_action[i],3)	
	yield()
next

gnv_status_info.of_display("")

//return 1
return li_count //for scheduler - (Appeon)Alfee 06.25.2013 - V141 ISG-CLX
end function

public function integer of_send_mail (string as_by_user, string as_to_users, string as_cc_users, str_email astr_emailinfo);n_cst_filesrv 				lnv_filesrv

String 	ls_users[],ls_message,ls_filename,ls_Notes
Integer 	ll_Return
String 	ls_mailto[],ls_mailcc[],ls_to_users,ls_cc_users
Blob		lbob_Message

//--------------------------- APPEON BEGIN //---------------------------
//$<Modify> 2007-05-30 By: Scofield
//$<reason> Fix a defect

ls_to_users = Trim(as_to_users)
ls_cc_users = Trim(as_cc_users)

IF IsNull(ls_to_users) Or Trim(ls_to_users) = '' THEN RETURN -1
//---------------------------- APPEON END ----------------------------
IF astr_emailinfo.Name = "" THEN RETURN -1 //02.03.2008 by Jervis: mail invalid.

//Save attact to temp dir
IF LenA(astr_emailinfo.attach_name) > 0 THEN
	ls_filename = gs_temp_path + astr_emailinfo.attach_name
	lnv_filesrv = Create n_cst_filesrv
	IF FileExists(ls_filename) THEN //06/20/2007 by Jervis
		FileDelete (ls_filename )
	END IF
	IF lnv_filesrv.of_filewrite(ls_filename,astr_emailinfo.attach,False) < 0 THEN
		Destroy lnv_filesrv
		RETURN -1
	END IF
	Destroy lnv_filesrv
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.
//long.zhnag 12.19.2013 Moved From below
String	ls_Addresser

SELECT Top 1 set_addresser Into :ls_Addresser From icred_settings;

IF IsNull(ls_Addresser) Or Trim(ls_Addresser) = "" THEN
	ls_Addresser = as_by_user
END IF
//---------------------------- APPEON END ----------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 12.19.2013
//<$>reason:V14.1 Check if the Email sender are corrected

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	inv_message.of_MessageBox('Send Email','Invalid Email sender. Please check if the system addresser was correctly  set in application settings~r~n' + &
	' or the set assigned by field was correctly set in work flow steps',true)
	return -1
end if

//-------------appeon End------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-26 By: Scofield
//$<Reason> Send blob data.

of_Get_EmailMessage(il_Mail_id,lbob_Message)

Open(w_email_edit)
w_email_edit.ole_word.of_Open(lbob_Message)

n_cst_word_utility lnv_word

lnv_word = Create n_cst_word_utility
lnv_word.of_set_str_action_item(istr_action_item)  //(Appeon)Harry 04.10.2014 -  for Bug 3998
//lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, il_data_id, il_export_id)  //Commented by (Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, astr_emailinfo.subject, il_data_id, il_export_id)  //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
if gb_autoschedule or ib_schedule then //scheduler - alfee 03.11.2010
	string ls_msg
	ls_msg = lnv_word.of_get_sched_msg( )
	if LenA(ls_msg) > 0 then inv_message.of_MessageBox("", ls_msg, TRUE)
end if	
Destroy lnv_word

ls_Notes = astr_emailinfo.notes
IF Not IsNull(ls_Notes) And ls_Notes <> "" THEN
	w_email_edit.ole_word.of_InsertTextLast(ls_Notes)
END IF

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//ll_Return = lnv_Redmail.of_start_email( ls_mailto,ls_mailcc, ls_message,astr_emailinfo.subject, ls_filename)

n_cst_easymail_smtp 	lnv_Mail

IF lnv_Mail.of_CreateObject() = -1 THEN
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	if gb_AutoSchedule= false and ib_schedule = false then //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		f_show_message('create Email object','','','','')
   else
		inv_message.of_MessageBox("Error", "Failed to create email object!",StopSign!,true)
	end if
	//--------End Modified -------------------------------
	RETURN -1
END IF
//-------------------Begin Commented by long.zhang appeon 12.19.2013 Moved to top----------------
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-02-22 By: Scofield
////$<Reason> Get the Addresser's user id.
//
//String	ls_Addresser
//
//SELECT Top 1 set_addresser Into :ls_Addresser From icred_settings;
//
//IF IsNull(ls_Addresser) Or Trim(ls_Addresser) = "" THEN
//	ls_Addresser = as_by_user
//END IF
////---------------------------- APPEON END ----------------------------
//-------------------End Commented--------------------------------------------------------
//Send EMail
ll_Return = lnv_Mail.of_SendHtml(ls_Addresser, ls_to_users, ls_cc_users, '',astr_emailinfo.Subject, w_email_edit.ole_word, ls_filename,True)
w_email_edit.ole_word.of_Close()
Close(w_email_edit)

IF ll_Return <> 0 THEN
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	if gb_AutoSchedule= false and ib_schedule = false then //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		f_show_message('error_code_'+String(ll_Return),'%1S%',String(ll_Return),'','')
	else
		inv_message.of_MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!,true)
	end if
	//--------End Modified -------------------------------
	lnv_Mail.of_DeleteObject()
	RETURN -1
END IF

lnv_Mail.of_DeleteObject()

//---------------------------- APPEON END ----------------------------
IF FileExists(ls_filename) THEN
	FileDelete (ls_filename )
END IF

RETURN 1


end function

public function integer of_reminder_mail_process_ic ();//////////////////////////////////////////////////////////////////////////////
//	Function:  of_reminder_mail_process_ic
//	Arguments:  none
//	Returns:  none
//	Description: Remind mail process for IntelliCred/App only
//////////////////////////////////////////////////////////////////////////////
//	Revision History:  
//  (from IC) Renamed by (Appeon)Alfee 06.25.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////////////
integer li_product,i,li_count
long ll_facility_id
long ll_prac[],ll_rowcount,ll_find
string ls_sql
string ls_dept_chair[]
str_action_item   lstr_action[]
datastore lds_dept_chair

ll_facility_id = long(gnv_data.of_getitem('security_users','default_search_facility',"upper(user_id)='" + upper(gs_user_id) + "'"))
li_product = of_get_app_setting('set_9', 'I')

//Return for IntelliContract product
if li_product = 4 then return 0  //(Appeon)Alfee 06.25.2013 - V141 ISG-CLX

openwithparm( w_appeon_gifofwait, "Send E-Mail,Please wait..." )

if li_product = 1 then	//IntelliApp
	ls_sql = "select rec_id,prac_id,facility_id,seq_no,wf_id,wf_action_type_id,due_date,action_status " + & 
				"from net_dev_action_items " + &
				"where facility_id = " + string(ll_facility_id) + " and active_status = 1 and wf_complete_flag = 'N' and wf_id > 0 and wf_action_type_id > 0"
elseif li_product = 4 then //IntelliContract
	ls_sql = "select ctx_action_item_id,ctx_id,0 as doc_id,wf_id,wf_action_type_id,due_date,action_status " + & 	
				"from ctx_action_items " + &
				"where active_status = 1 and wf_complete_flag = 'N' and wf_id > 0 and wf_action_type_id > 0 " + &
				"union all " + &
				"select 0,ctx_id,ctx_am_action_item.doc_id,ctx_am_action_item.wf_id,wf_action_type_id,due_date,action_status " + &
				"from ctx_am_action_item,ctx_am_document " + &
				"where active_status = 1 and wf_complete_flag = 'N' and ctx_am_action_item.wf_id > 0 and wf_action_type_id > 0 " +&
				" and ctx_am_action_item.doc_id = ctx_am_document.doc_id"	
else
	ls_sql = "select rec_id,prac_id,facility_id,seq_no,wf_id,wf_action_type_id,due_date,response_code " + & 
				"from verif_info " + &
				"where facility_id = " + string(ll_facility_id) + " and active_status = 1 and wf_complete_flag = 'N' and wf_id > 0 and wf_action_type_id > 0"
end if	

DECLARE Cur_action_item  DYNAMIC CURSOR FOR SQLSA;
PREPARE SQLSA FROM :ls_sql;
OPEN DYNAMIC Cur_action_item;
i = 1
if li_product = 4 then
	Fetch Cur_action_item into :lstr_action[i].ctx_action_item_id,:lstr_action[i].ctx_id,:lstr_action[i].doc_id,:lstr_action[i].wf_id,:lstr_action[i].wf_step_id,:lstr_action[i].due_date,:lstr_action[i].wf_action_status_id;	//11-21-2007 By Jervis Add Doc_ID
	do while sqlca.sqlcode = 0
		i++
		Fetch Cur_action_item into :lstr_action[i].ctx_action_item_id,:lstr_action[i].ctx_id,:lstr_action[i].doc_id,:lstr_action[i].wf_id,:lstr_action[i].wf_step_id,:lstr_action[i].due_date,:lstr_action[i].wf_action_status_id;
	loop
	close Cur_action_item;
	li_count = i - 1 
else
	Fetch Cur_action_item into :lstr_action[i].rec_id,:ll_prac[i],:lstr_action[i].facility_id,:lstr_action[i].seq_no,:lstr_action[i].wf_id,:lstr_action[i].wf_step_id,:lstr_action[i].due_date,:lstr_action[i].wf_action_status_id;
	do while sqlca.sqlcode = 0
		i++
		Fetch Cur_action_item into :lstr_action[i].rec_id,:ll_prac[i],:lstr_action[i].facility_id,:lstr_action[i].seq_no,:lstr_action[i].wf_id,:lstr_action[i].wf_step_id,:lstr_action[i].due_date,:lstr_action[i].wf_action_status_id;
	loop
	close Cur_action_item;

	//Gets department chiarman,performance turning 12.28.2006 By Jervis
	lds_dept_chair = create datastore
	lds_dept_chair.dataobject = "d_wf_dept_chair"
	lds_dept_chair.SetTransObject(sqlca)
	if isnull(UpperBound(ll_prac)) or UpperBound(ll_prac) < 1 then ll_prac[1] = 0 //(Appeon)Harry 01.21.2015 
	ll_rowcount = lds_dept_chair.Retrieve(ll_facility_id,ll_prac)

	li_count = i - 1 //scheduler -alfee 03.11.2010
	for i = 1 to li_count
		lstr_action[i].prac_id = ll_prac[i]
		ll_find = lds_dept_chair.Find("prac_id = "+string(ll_prac[i]),1,ll_rowcount)
		if ll_find > 0 then
			lstr_action[i].dept_chair = lds_dept_chair.GetItemString(ll_find,"user_id")
		end if
	next
	destroy lds_dept_chair
end if

inv_message.of_set_proc_cnt(li_count) 

//Send email
for i = 1 to li_count
	of_send_mail(lstr_action[i],3)	
	yield()
next

//close(w_download_popup)
if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)

//return 1
return li_count  //for scheduler - (Appeon)Alfee 06.25.2013 - V141 ISG-CLX


end function

public function integer of_reminder_mail_process ();//====================================================================
//$<Function>: of_reminder_mail_process()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Remind email process for both IC & CTX
//$<Author>: (Appeon) Alfee 06.25.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>: 
//====================================================================

Long ll_cnt_ic, ll_cnt_ctx

//For IntelliCred/App
IF NOT gb_contract_version THEN
	ll_cnt_ic = of_reminder_mail_process_ic ()
	IF ll_cnt_ic < 0 THEN ll_cnt_ic = 0
END IF

//For IntelliContract
IF gb_contract_module THEN
	ll_cnt_ctx = of_reminder_mail_process_ctx ()
	IF ll_cnt_ctx < 0 THEN ll_cnt_ctx = 0		
END IF

inv_message.of_set_proc_cnt(ll_cnt_ctx + ll_cnt_ic) 

RETURN 1
end function

public function integer of_get_sched_cnt ();// (Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function string of_get_sched_msg ();//(Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_set_sched_flag (boolean ab_flag);// (Appeon)Harry 06.27.2013 - V141 ISG-CLX
//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_data_value_comparision (long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id[]		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in IntelliContract is contract id.
// al_facility_id		facility id used in IntelliCred/App. Doc id used in Document Manager
// as_module			01-IntelliCred,02-IntelliApp,03-IntelliContract Tracking,04-IntelliContract Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
long	ll_find,ll_rowcount
long 	ll_wf_id , ll_processed_id
integer	i , j, m , li_steps
Datastore lds_data_comparision,lds_data_workflow
String	 ls_tablename , ls_comparision_sqls[] , ls_field_comp , ls_sql , ls_sql_comp
String	 ls_runtype , ls_comparision_type
long		 ll_screen_id , ll_pre_screen
string	 ls_field_name, ls_operator, ls_value , ls_coltype,ls_filter
long		 ll_result[] , ll_pos
boolean   lb_trigger
string ls_empty[]		//05/16/2007 by jervis
str_action_item lstr_action

li_steps = upperbound(al_screen_id)
If not li_steps > 0 Then return -1

for i = 1 to li_steps
	if i = 1 then
		ls_filter = "(screen_id = " + string(al_screen_id[i])
	else
		ls_filter += " or screen_id = " + string(al_screen_id[i])
	end if
next
ls_filter += ")"

//Get the related work flow trigger parms for the current screen id from cache data
lds_data_comparision = Create datastore
lds_data_workflow = Create DataStore
lds_data_comparision.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_workflow.dataobject = 'd_g_trigger_param_data_comparison_data'
lds_data_comparision.settransobject(SQLCA)
lds_data_workflow.settransobject(SQLCA)
gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "module='"+as_module+"' and " + ls_filter, lds_data_workflow)

//If there is not related work flow for the current screen then return directly.
li_steps = lds_data_workflow.Rowcount( ) 
If not li_steps > 0 Then return 1

lds_data_workflow.setsort( "wf_id asc")
lds_data_workflow.sort()

//
DECLARE exec_cur DYNAMIC CURSOR FOR SQLSA ;

//If one screen related more work flow, all work flows shoule be triggered
For  i = 1 to li_steps
	lb_trigger = true
	ls_comparision_sqls = ls_empty	//05/16/2007 By Jervis
	ll_wf_id = lds_data_workflow.Getitemnumber( i, 'wf_id')
	//If work flow has more than one field comparision, then make sure the work flow triggered just one time.
	If ll_wf_id = ll_processed_id then Continue
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 17/05/2007 By: Jervis
	//$<reason> 
	/*
	ll_find = gnv_data.of_findrow("wf_workflow","wf_id="+string(ll_wf_id))
	If not ll_find > 0 Then continue
	*/
	//Get the related work flow trigger parms for the current ll_wf_id from cache data
	lds_data_comparision.Reset()
	gnv_data.of_get_data_from_cache( 'wf_trigger_param_data_comparison', "wf_id=" + string(ll_wf_id), lds_data_comparision)
	ll_rowcount = lds_data_comparision.RowCount()
	//---------------------------- APPEON END ----------------------------

	
			
	ll_processed_id = ll_wf_id
	
	//Get the run type(each time or data entry complete) and comparision type(field or SQL statement)
	Choose Case as_module
		Case '01','02' //IntelliCred / IntelliApp
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue
			
			//F-Field Comparision, S-SQL statement comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				For j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					If j = 1 Then
						ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
						ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							//12.13.2006 By Jervis to fixed a defect
							//ls_tablename 	= gnv_data.of_get_table_name( al_screen_id , 'P' , 'sys_tables_table_name')
							ls_tablename 	= gnv_data.of_get_table_name( ll_screen_id , 'P' , 'sys_tables_table_name')
							ls_field_comp 	= "Select 1 from " + ls_tablename + " where prac_id = " +string(al_key_id) 
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
					
					
				Next
				If LenA(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
				
			Else //comparision with SQL statement
				For j = 1 to ll_rowcount
					ls_sql_comp = lds_data_comparision.getitemstring(j , 'sql_statement')
					If LenA(ls_sql_comp) > 0 Then 
						If PosA(upper(ls_sql_comp) , ' WHERE ') > 0 Then
							ls_sql_comp = ls_sql_comp + " and prac_id = " + string(al_key_id)
						Else
							ls_sql_comp = ls_sql_comp + " where prac_id = " + string(al_key_id)
						End If
						
						ll_pos = PosA(upper(ls_sql_comp) , ' FROM ' )
						If ll_pos > 0 Then
							ls_sql_comp = "select 1 " + MidA(ls_sql_comp , ll_pos)
						End if
						ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_sql_comp
					End if
					
				Next
				
			End If
		Case '03','04' //IntelliContract tracking
			ls_runtype = gnv_data.of_getitem( 'wf_workflow', 'practitioner_falg' , "wf_id="+string(ll_wf_id))
			ls_comparision_type = gnv_data.of_getitem( 'wf_workflow', 'comparison_type' , "wf_id="+string(ll_wf_id))
			If ls_runtype <> as_runtype Then Continue   //12.7.2006 By Jervis
			
			//j = gnv_data.of_FindRow("wf_trigger_param_data_comparison","wf_id=" + string(ll_wf_id))
			
			//F-Field Comparision
			If ls_comparision_type = 'F' Then //Comparision with Field 
				//If j > 0 then	
				FOR j = 1 to ll_rowcount
					ll_screen_id  	= lds_data_comparision.Getitemnumber( j , 'screen_id')
					//ll_screen_id = long(gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"screen_id"))
					If j = 1 Then
						ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
						ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
					Else
						If ll_screen_id <> lds_data_comparision.Getitemnumber( j - 1 , 'screen_id') Then
							ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
							ls_tablename 	= lds_data_comparision.getitemstring( j , 'table_name')
							ls_field_comp = of_getfieldcomp(as_module,ls_tablename,al_key_id,al_facility_id)
						End If
					End If
					
					ls_field_name 	= lds_data_comparision.GetItemString( j , 'field_name')
					ls_operator	  	= lds_data_comparision.GetItemString( j , 'operator')
					ls_value 		= lds_data_comparision.GetItemString( j , 'value')
					ls_coltype		= lds_data_comparision.GetItemString( j , 'field_type')
					/*
					ls_field_name 	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_name")
					ls_operator	  	= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"operator")
					ls_value 		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"value")
					ls_coltype		= gnv_data.of_getItem("wf_trigger_param_data_comparison",j,"field_type")
					*/
					Choose Case ls_coltype
						Case 'C' //Character
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
						Case 'I','N'//number
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " " +ls_value 
						Case 'D' //date & time
								ls_field_comp = ls_field_comp + " and " + ls_field_name + " " + ls_operator + " '" +ls_value + "'"
					End Choose
				Next
				If LenA(ls_field_comp) > 0 Then ls_comparision_sqls[upperbound(ls_comparision_sqls) + 1] = ls_field_comp
			End if
		//Case '04' //IntelliContract Agreement //Comment 06/20/2007 by: Andy
			
	End Choose
	
	//Compare
	If upperbound(ls_comparision_sqls) > 0 Then
		For m = 1 to upperbound(ls_comparision_sqls)
			ls_sql = ls_comparision_sqls[m]

			PREPARE SQLSA FROM :ls_sql ;
			OPEN DYNAMIC exec_cur ;
			FETCH exec_cur INTO :ll_result[m] ;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.07.2006 By: Jervis
			//$<reason> Fix a defect for APB
			if sqlca.sqlcode <> 0 then
				ll_result[m] = 0
			end if
			//---------------------------- APPEON END ----------------------------

			close exec_cur;
		Next
	End If
	For m = 1 to upperbound(ll_result)
		If ll_result[m] <> 1 Then lb_trigger = false
	Next
	
	//trigger the related work flow
	If lb_trigger Then
		lstr_action.prac_id = al_key_id
		lstr_action.ctx_id = al_key_id  //12.7.2006 By Jervis
		lstr_action.rec_id = 1
		lstr_action.facility_id = al_facility_id
		lstr_action.wf_id = ll_wf_id
		lstr_action.screen_id = -10
		//<add> 06/20/2007 by: Andy 
		//Remark:al_facility_id equal to Doc id used in Document Manager
		lstr_action.doc_id = al_facility_id
		//end of add
		of_workflow_create_action_items(lstr_action)
	End If
Next

Destroy lds_data_comparision
Destroy lds_data_workflow
Return 1
end function

public function integer of_compare (long al_screen_id[], long al_key_id, long al_facility_id, string as_module, string as_runtype);//////////////////////////////////////////////////////////////////////////////
//
//	function:  of_data_value_comparision
//
//	Access:    Public
//
//	Arguments:  
// al_screen_id		The screen id which need to compare data
// al_key_id			in IntelliCred/App is practitioner id. in IntelliContract is contract id
// al_facility_id		facility id used in IntelliCred/App
// as_module			01-IntelliCred,02-IntelliApp,03-IntelliContract Tracking,04-IntelliContract Agreement
// as_runtype        Y-run each time data saved, N-run when Data Entry Complete button clicked
//
//	Returns:  integer
//		Returns 1 if it succeeds and -1 if an error occurs 
//
//	Description:		
//		
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?.
//
//////////////////////////////////////////////////////////////////////////////
integer i

If Not isvalid( w_infodisp ) then open(w_infodisp)

If isvalid(w_infodisp) then w_infodisp.title = 'Trigger of the work flow for data value comparision, Please stand by'
If isvalid(w_infodisp) then w_infodisp.Center = TRUE
If isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
If isvalid(w_infodisp) then w_infodisp.st_3.visible = false
If isvalid(w_infodisp) then w_infodisp.st_information.visible = false
If isvalid(w_infodisp) then w_infodisp.st_1.text = 'Trigger of the work flow for data value comparision, Please stand by ' 
If isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(al_screen_id))

/*
For i = 1 to upperbound(al_screen_id)
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
	of_data_value_comparision(al_screen_id[i] , al_key_id , al_facility_id , as_module, as_runtype)
	
Next
*/

if isvalid(w_infodisp)  Then close(w_infodisp)
return 1
end function

on n_cst_workflow_triggers.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_workflow_triggers.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;f_SetFileSrv(in_FileSrv,true)				//Added by Scofield on 2009-02-20
ids_EmailAttach = Create DataStore		//Added by Scofield on 2009-02-20

inv_data_entry = CREATE pfc_cst_nv_data_entry_functions //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

ids_net_dev_action_items = Create n_cst_datastore//Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
ids_net_dev_action_items.DataObject = "d_wf_verif_action_adding_net"
ids_net_dev_action_items.SetTransObject( sqlca)

end event

event destructor;f_SetFileSrv(in_FileSrv,false)		//Added by Scofield on 2009-02-20
Destroy ids_EmailAttach					//Added by Scofield on 2009-02-20

destroy inv_data_entry //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
Destroy ids_net_dev_action_items //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
end event

