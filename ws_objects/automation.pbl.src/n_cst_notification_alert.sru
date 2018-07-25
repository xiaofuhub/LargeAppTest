$PBExportHeader$n_cst_notification_alert.sru
forward
global type n_cst_notification_alert from nonvisualobject
end type
end forward

global type n_cst_notification_alert from nonvisualobject
end type
global n_cst_notification_alert n_cst_notification_alert

type variables
datastore ids_alert_hdr
datastore ids_alert_steps
datastore ids_alert_records
datastore ids_new_record

datastore ids_pd_address
datastore ids_facility_ver_rules
datastore ids_prac_facility

datastore ids_verif_info
datastore ids_action_items

string   is_EmailType = "Easymail!"
string   is_alert_records_sql
datetime idt_CurrentTime
long     il_ver_seq_no
long     il_ai_rec_id
long     il_ai_seq_no

n_cst_outlook inv_outlook
n_cst_word_utility inv_word
pfc_n_cst_ai_export_apb inv_export

// SMTP Information for Current Step
string is_smtp_server
long   il_smtp_port
long   il_smtp_authmode
string is_smtp_account
string is_smtp_password
string is_smtp_email
long 	il_smtpssl //alfee 09.24.2013
String is_smtp_sendprotocol //Added by Appeon long.zhang 05.26.2015 ( Issue using easymail with notifications)

// Email Template for Current Step
string  is_em_email_from //evan 06.08.2012
string  is_em_subject
string  is_em_message
blob    iblb_em_message
string  is_em_message_html
string  is_em_attchment
string  is_em_email_to
string  is_em_email_cc  //stephen 05.10.2013
integer ii_em_email_prac
datastore ids_em_prac
datastore ids_verif_detail

// Email Template Cache for Current Alert
str_na_email_temp istr_email_temp[]

//scheduler - alfee 03.05.2010
n_cst_message inv_message 
Boolean ib_schedule = false 

long il_export_id //(Appeon)Harry 03.09.2015 


end variables

forward prototypes
public function integer of_run ()
public function integer of_buildexpiredrecord ()
public function integer of_cachedata ()
public function integer of_dostep (integer ai_step)
public function integer of_run (long al_alert_id)
public function boolean of_activestatusfieldexists (string as_table_name)
public function integer of_getexportdata ()
public function integer of_filteralertrecord (integer ai_step)
public function integer of_setstepvalue (integer ai_step)
public function integer of_stepprocess ()
public function integer of_destroyexportdata ()
public function integer of_savedata ()
public function boolean of_iscreateemail (integer ai_step)
public function long of_getemailmessage (long al_email_id, ref blob ablb_data)
public function long of_getemailattachment (long al_email_id, ref blob ablb_data)
public function integer of_getsmtpinfo (integer ai_step)
public function integer of_getemailtemplate (integer ai_step)
public function integer of_easymailsend (string as_mailto)
public function integer of_outlooksend (string as_mailto)
public function integer of_modifyupdateproperty (datastore ads_data)
public function integer of_runexpired (long al_alert_id)
public function integer of_runnew (long al_alert_id)
public function long of_getnewrecord ()
public function integer of_createactionitem (long al_rec_id, long al_prac_id, long al_facility_id, long al_action_type, long al_app_id)
public function integer of_createverification (long al_rec_id, long al_prac_id, long al_facility_id, string as_oppe_fppe, string as_facility_name, long al_alerttype)
public function string of_getemailaddress (long al_prac_id)
public function integer of_createemail (long al_prac_id)
public function integer of_set_sched_flag (boolean ab_flag)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function long of_getexpiredrecord ()
public function integer of_log (string as_message)
public function integer of_run_scheduledemail (long al_alert_id)
public function integer of_get_new_prac_alerts ()
public function integer of_exp_cred_notifi_combined (long al_pracs[], integer ai_facility, integer ai_active, ref datastore ads_exp)
end prototypes

public function integer of_run ();//////////////////////////////////////////////////////////////////////
// $<function> of_run
// $<arguments>
// $<returns> integer
// $<description> Run all of notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

long i, ll_Count
long ll_alert_id[]

of_CacheData()
ll_Count = ids_alert_hdr.RowCount()
if ll_Count < 1 then Return 1

ll_alert_id[] = ids_alert_hdr.object.alert_id[1, ll_Count]
for i = 1 to ll_Count
	of_Run(ll_alert_id[i])
next

Return 1
end function

public function integer of_buildexpiredrecord ();////////////////////////////////////////////////////////////////////////
// $<function> of_buildexpiredrecord
// $<arguments>
// $<returns> integer
// $<description> Insert new expiration records into alert_records table
//called from of_getexpiredrecord
////////////////////////////////////////////////////////////////////////
// $<add> Evan 01.13.2010
////////////////////////////////////////////////////////////////////////

long ll_alert_id
long ll_alert_type
long ll_facility_id
long ll_active_only
long ll_upper_range
long ll_method //(Appeon)Stephen 12.01.2016 - V15.3-Combined Expiring Credentials in Notifications
string ls_table_name
string ls_exp_date_field
string ls_new_recordset
string ls_exists_recordset
string ls_InsertSQL
string ls_CurrentYear
string ls_Today
string ls_upper_range_date
string ls_delete_record //(Appeon)Stephen 2013-09-07 - bug 3641 DEA/CSR Expiration
boolean lb_ActiveStatusFieldExists

ll_alert_id = ids_alert_hdr.object.alert_id[1]
ll_alert_type = ids_alert_hdr.object.alert_type[1]
ll_facility_id = ids_alert_hdr.object.facility_id[1]
ll_active_only = ids_alert_hdr.object.active_only[1]
ls_table_name = Lower(Trim(ids_alert_hdr.object.table_name[1]))
ls_exp_date_field = ids_alert_hdr.object.field_name[1]
ll_upper_range = ids_alert_hdr.object.upper_range[1]
ls_CurrentYear = String(idt_CurrentTime, "yyyy")
ls_Today = String(idt_CurrentTime, "yyyy-mm-dd")
if isnull(ll_upper_range) then ll_upper_range = 0 //(Appeon)Stephen 12.06.2016 - V15.3-Combined Expiring Credentials in Notifications
ls_upper_range_date = String(RelativeDate(Date(idt_CurrentTime), ll_upper_range), "yyyy-mm-dd") + " 23:59:59"
lb_ActiveStatusFieldExists = of_ActiveStatusFieldExists(ls_table_name)

//---------Begin Added by (Appeon)Harry 09.30.2016 ---------
If Pos(ls_table_name, '.') > 0 then ls_table_name = Mid(ls_table_name, Pos(ls_table_name, '.') + 1)
//---------End Added ------------------------------------------------------


//---------Begin Added by (Appeon)Harry 03.12.2015 for V151-Additional Notification Filters--------  
string ls_addtl_filter
ls_addtl_filter = ids_alert_hdr.object.addtl_filter[1]
//---------End Added ------------------------------------------------------

// Build expiration records sql
choose case ls_table_name
	case "pd_affil_stat"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0 where table_name = 'pd_affil_stat' and active_status = 1 and rec_id not in(select rec_id from pd_affil_stat) "
		//---------End Added ------------------------------------------------------
		
		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "             + &
		"  key_id              = convert(varchar,pd_affil_stat.rec_id) + '-' + convert(varchar,pd_affil_stat.prac_id) + '-' + convert(varchar,pd_affil_stat.parent_facility_id), " + &
		"  rec_id              = pd_affil_stat.rec_id, "                    + &
		"  prac_id             = pd_affil_stat.prac_id, "                   + &
		"  facility_id         = pd_affil_stat.parent_facility_id, "        + &
		"  exp_date            = pd_affil_stat." + ls_exp_date_field + ", " + &
		"  cre_active_status   = pd_affil_stat.active_status, "             + &
		"  affil_active_status = pd_affil_stat.active_status, "             + &
		"  active_status       = 1, "                                       + &
		"  table_name          = 'pd_affil_stat' "                          + &
		"from pd_affil_stat " + &
		"where (pd_affil_stat." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_new_recordset += "and (pd_affil_stat.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (pd_affil_stat.parent_facility_id = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case "pd_oppe_hrd"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0  where table_name = 'pd_oppe_hrd' and active_status = 1 and rec_id not in(select pd_oppe_hdr_id from pd_oppe_hrd) "
		//---------End Added ------------------------------------------------------
		
		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "           + &
		"  key_id              = convert(varchar,pd_oppe_hrd.pd_oppe_hdr_id) + '-' + convert(varchar,pd_oppe_hrd.prac_id) + '-' + convert(varchar,pd_oppe_hrd.facility_id), " + &
		"  rec_id              = pd_oppe_hrd.pd_oppe_hdr_id, "            + &
		"  prac_id             = pd_oppe_hrd.prac_id, "                   + &
		"  facility_id         = pd_oppe_hrd.facility_id, "               + &
		"  exp_date            = pd_oppe_hrd." + ls_exp_date_field + ", " + &
		"  cre_active_status   = pd_oppe_hrd.active_status, "             + &
		"  affil_active_status = pd_affil_stat.active_status, "           + &
		"  active_status       = 1, "                                     + &
		"  table_name          = 'pd_oppe_hrd' "                          + &
		"from pd_oppe_hrd, pd_affil_stat " + &
		"where (pd_oppe_hrd.prac_id = pd_affil_stat.prac_id) and (pd_oppe_hrd.facility_id = pd_affil_stat.parent_facility_id) and (pd_affil_stat.active_status = 1) and " + &
		"      (pd_oppe_hrd." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_new_recordset += "and (pd_oppe_hrd.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (pd_oppe_hrd.facility_id = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case "net_dev_action_items"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0  where table_name = 'net_dev_action_items' and active_status = 1 and rec_id not in(select rec_id from net_dev_action_items) "
		//---------End Added ------------------------------------------------------

		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "                    + &
		"  key_id              = convert(varchar,net_dev_action_items.rec_id) + '-' + convert(varchar,net_dev_action_items.prac_id) + '-' + convert(varchar,net_dev_action_items.facility_id), " + &
		"  rec_id              = net_dev_action_items.rec_id, "                    + &
		"  prac_id             = net_dev_action_items.prac_id, "                   + &
		"  facility_id         = net_dev_action_items.facility_id, "               + &
		"  exp_date            = net_dev_action_items." + ls_exp_date_field + ", " + &
		"  cre_active_status   = net_dev_action_items.active_status, "             + &
		"  affil_active_status = pd_affil_stat.active_status, "                    + &
		"  active_status       = 1, "                                              + &
		"  table_name          = 'net_dev_action_items' "                          + &
		"from net_dev_action_items, pd_affil_stat " + &
		"where (net_dev_action_items.prac_id = pd_affil_stat.prac_id) and (net_dev_action_items.facility_id = pd_affil_stat.parent_facility_id) and (pd_affil_stat.active_status = 1) and (isnull(net_dev_action_items.action_status,0) <> 90741) and " + &
		"      (net_dev_action_items." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_new_recordset += "and (net_dev_action_items.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (net_dev_action_items.facility_id = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case "pd_app_audit"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0  where table_name = 'pd_app_audit' and active_status = 1 and rec_id not in(select record_id from pd_app_audit) "
		//---------End Added ------------------------------------------------------

		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "            + &
		"  key_id              = convert(varchar,pd_app_audit.record_id) + '-' + convert(varchar,pd_app_audit.prac_id) + '-' + convert(varchar,pd_app_audit.facility_id), " + &
		"  rec_id              = pd_app_audit.record_id, "                 + &
		"  prac_id             = pd_app_audit.prac_id, "                   + &
		"  facility_id         = pd_app_audit.facility_id, "               + &
		"  exp_date            = pd_app_audit." + ls_exp_date_field + ", " + &
		"  cre_active_status   = pd_app_audit.active_status, "             + &
		"  affil_active_status = pd_affil_stat.active_status, "            + &
		"  active_status       = 1, "                                      + &
		"  table_name          = 'pd_app_audit' "                          + &
		"from pd_app_audit, pd_affil_stat, data_view_app_audit " + &
		"where (pd_app_audit.appt_stat_id = pd_affil_stat.rec_id) and (pd_affil_stat.apptmnt_type = data_view_app_audit.app_type) and (pd_app_audit.app_audit_id = data_view_app_audit.app_audit_id) and (pd_affil_stat.active_status = 1) and " + &
		"      (pd_app_audit." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_new_recordset += "and (pd_app_audit.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (pd_app_audit.facility_id = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case "verif_info"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0  where table_name = 'verif_info' and active_status = 1 and rec_id not in(select rec_id from verif_info) "
		//---------End Added ------------------------------------------------------

		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "          + &
		"  key_id              = verif_info.doc_id, "                    + &
		"  rec_id              = verif_info.rec_id, "                    + &
		"  prac_id             = verif_info.prac_id, "                   + &
		"  facility_id         = verif_info.facility_id, "               + &
		"  exp_date            = verif_info." + ls_exp_date_field + ", " + &
		"  cre_active_status   = verif_info.active_status, "             + &
		"  affil_active_status = pd_affil_stat.active_status, "          + &
		"  active_status       = 1, "                                    + &
		"  table_name          = 'verif_info' "                          + &
		"from verif_info, pd_affil_stat " + &
		"where (verif_info.prac_id = pd_affil_stat.prac_id) and (verif_info.facility_id = pd_affil_stat.parent_facility_id) and (pd_affil_stat.active_status = 1) and (verif_info.response_code is null) and " + &
		"      (verif_info." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_new_recordset += "and (verif_info.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (verif_info.facility_id = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case "meetings"
		//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
		ls_delete_record = " update alert_records set active_status =0  where table_name = 'meetings' and active_status = 1 and rec_id not in(select meeting_id from meetings) "
		//---------End Added ------------------------------------------------------

		// New recordset sql
		ls_new_recordset = &
		"select " + &
		"  alert_id            = " + String(ll_alert_id) + ", "        + &
		"  key_id              = convert(varchar,meetings.meeting_id) + '-' + convert(varchar,attendence.prac_id) + '-' + convert(varchar,meetings.facility), " + &
		"  rec_id              = meetings.meeting_id, "                + &
		"  prac_id             = attendence.prac_id, "                 + &
		"  facility_id         = meetings.facility, "                  + &
		"  exp_date            = meetings." + ls_exp_date_field + ", " + &
		"  cre_active_status   = attendence.active_status, "           + &
		"  affil_active_status = pd_affil_stat.active_status, "        + &
		"  active_status       = 1, "                                  + &
		"  table_name          = 'meetings' "                          + &
		"from meetings, attendence, pd_affil_stat " + &
		"where (meetings.meeting_id = attendence.meeting_id) and " + &
		"      (attendence.prac_id = pd_affil_stat.prac_id) and (meetings.facility = pd_affil_stat.parent_facility_id) and (pd_affil_stat.active_status = 1) and " + &
		"      (meetings." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') and " + &
		"      (meetings." + ls_exp_date_field + " > getdate()) "
		if ll_active_only = 1 then
			ls_new_recordset += "and (attendence.active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_new_recordset += "and (meetings.facility = " + String(ll_facility_id) + ")"
		end if
		// Exists recordset sql
		ls_exists_recordset = &
		"select key_id from alert_records " + &
		"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
		"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
		"      (exp_date <= '" + ls_upper_range_date + "') "
		if ll_active_only = 1 then
			ls_exists_recordset += "and (cre_active_status = 1) "
		end if
		if not IsNull(ll_facility_id) then
			ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
		end if
	case else // Credentials Table
		choose case ll_alert_type
			case 20 // Birthday
				//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
				ls_delete_record = " update alert_records set active_status =0  where table_name = 'pd_basic' and active_status = 1 and rec_id not in(select rec_id from pd_basic) "
				//---------End Added ------------------------------------------------------

				// New recordset sql
				ls_new_recordset = &
				"select " + &
				"  alert_id            = " + String(ll_alert_id) + ", "        + &
				"  key_id              = convert(varchar,pd_basic.rec_id) + '-' + convert(varchar,pd_basic.prac_id) + '-' + convert(varchar,pd_affil_stat.parent_facility_id), " + &
				"  rec_id              = pd_basic.rec_id, "                    + &
				"  prac_id             = pd_basic.prac_id, "                   + &
				"  facility_id         = pd_affil_stat.parent_facility_id, "   + &
				"  exp_date            = pd_basic." + ls_exp_date_field + ", " + &
				"  cre_active_status   = null, "                               + &
				"  affil_active_status = pd_affil_stat.active_status, "        + &
				"  active_status       = 1, "                                  + &
				"  table_name          = 'pd_basic' "                          + &
				"from pd_basic, pd_affil_stat " + &
				"where (pd_basic.prac_id = pd_affil_stat.prac_id) and (pd_affil_stat.active_status = 1) and " + &
				"      (('" + ls_CurrentYear + "-' + convert(char(5),pd_basic." + ls_exp_date_field + ",10)) <= '" + ls_upper_range_date + "') and " + &
				"      (('" + ls_CurrentYear + "-' + convert(char(5),pd_basic." + ls_exp_date_field + ",10)) > '" + ls_Today + "') "
				if not IsNull(ll_facility_id) then
					ls_new_recordset += "and (pd_affil_stat.parent_facility_id = " + String(ll_facility_id) + ")"
				end if
				// Exists recordset sql
				ls_exists_recordset = &
				"select key_id from alert_records " + &
				"where (alert_id = " + String(ll_alert_id) + ") and (table_name = 'pd_basic') and " + &
				"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
				"      (('" + ls_CurrentYear + "-' + convert(char(5),exp_date,10)) <= '" + ls_upper_range_date + "') "
				if not IsNull(ll_facility_id) then
					ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
				end if
			case 22 // V12.2 Scheduled Email - alfee 08.04.2012
				//add '' to key_id by long.zhang 08.24.2012	asa7 pop up w_sql_msg
				// New recordset sql
				ls_new_recordset = &
				"select top 1 " + &
				"  alert_id			= " + String(ll_alert_id) + ", "  + &
				"  key_id				= '" + String(ll_alert_id) + "', "  + &
				"  rec_id              	= null, " + &
				"  prac_id            	= null, " + &
				"  facility_id         	= null, " + &
				"  exp_date         	= '" + ls_Today + "', "  + &
				"  cre_active_status  = null, " + &
				"  affil_active_status = null, " + &
				"  active_status		   = 1, " 	+ &
				"  table_name          = null " + &
				"from ids " 
				// Exists recordset sql (for current day's incompleted record )
				ls_exists_recordset = "select key_id from alert_records where alert_id = " + String(ll_alert_id) + " and exp_date =  '" + ls_Today + "' and active_status = 1 "
			case 40 //(Appeon)Stephen 12.01.2016 - V15.3-Combined Expiring Credentials in Notifications
				ll_method = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Verification Method' and upper(code) = 'EXP CRED LTR'"))
				ls_delete_record = " update alert_records set active_status =2  where table_name = 'Exp Cred Combined' and active_status = 1 and  prac_id not in(select prac_id from verif_info where active_status = 1 and verification_method = " + string(ll_method ) + " and (response_code = 0 or response_code is null)) "
				ls_delete_record = ls_delete_record + " update alert_records set active_status =2  where table_name = 'Exp Cred Combined' and active_status = 1 and (step10 is not null) and prac_id in(select prac_id from verif_info where active_status = 1 and verification_method = " + string(ll_method ) + " and (response_code = 0 or response_code is null)) "
				
				ls_new_recordset = &
				"select " + &
				"  alert_id            = " + String(ll_alert_id) + ", "          + &
				"  key_id              = verif_info.prac_id, "                    + &
				"  rec_id              = min(verif_info.rec_id), "                    + &
				"  prac_id             = verif_info.prac_id, "                   + &
				"  facility_id         = min(verif_info.facility_id), "               + &
				"  exp_date            = min(verif_info.expiration_date), " + &
				"  cre_active_status   = min(verif_info.active_status), "             + &
				"  affil_active_status = min(pd_affil_stat.active_status), "          + &
				"  active_status       = 1, "                                    + &
				"  table_name          = 'Exp Cred Combined' "                          + &
				"from verif_info, pd_affil_stat " + &
				"where (verif_info.prac_id = pd_affil_stat.prac_id) and (verif_info.facility_id = pd_affil_stat.parent_facility_id and pd_affil_stat.verifying_facility >0)  and (verif_info.response_code is null) " 
				if ll_active_only = 1 then
					ls_new_recordset += " and (pd_affil_stat.active_status = 1)"
				else
					ls_new_recordset += " and (pd_affil_stat.active_status in (1,4))"
				end if
				ls_new_recordset += " and (verif_info.active_status = 1) "
				ls_new_recordset += " and verification_method = " + string(ll_method )
				if not IsNull(ll_facility_id) then
					ls_new_recordset += " and (verif_info.facility_id = " + String(ll_facility_id) + ")"
				end if
				ls_new_recordset += " group by verif_info.prac_id "
				// Exists recordset sql
				ls_exists_recordset = &
				"select key_id from alert_records " + &
				"where (alert_id = " + String(ll_alert_id) + ") and (table_name = 'Exp Cred Combined') and " + &
				"      (active_status = 1) " 
				
				ls_exists_recordset += " and (cre_active_status = 1) "				
				if not IsNull(ll_facility_id) then
					ls_exists_recordset += " and (facility_id = " + String(ll_facility_id) + ")"
				end if
			case else
				//---------Begin Added by (Appeon)Stephen 2013-09-07 for bug 3641 DEA/CSR Expiration--------
				ls_delete_record = " update alert_records set active_status =0  where table_name = '"+ls_table_name+"' and active_status = 1 and rec_id not in(select rec_id from "+ls_table_name+") "
				//---------End Added ------------------------------------------------------

				// New recordset sql
				ls_new_recordset = &
				"select " + &
				"  alert_id            = " + String(ll_alert_id) + ", "      + &
				"  key_id              = convert(varchar," + ls_table_name + ".rec_id) + '-' + convert(varchar," + ls_table_name + ".prac_id) + '-' + convert(varchar,pd_affil_stat.parent_facility_id), " + &
				"  rec_id              = " + ls_table_name + ".rec_id, "     + &
				"  prac_id             = " + ls_table_name + ".prac_id, "    + &
				"  facility_id         = pd_affil_stat.parent_facility_id, " + &
				"  exp_date            = " + ls_table_name + "." + ls_exp_date_field + ", "
				if lb_ActiveStatusFieldExists then
					ls_new_recordset += "cre_active_status = " + ls_table_name + ".active_status, "
				else
					ls_new_recordset += "cre_active_status = null, "
				end if
				ls_new_recordset += &
				"  affil_active_status = pd_affil_stat.active_status, "      + &
				"  active_status       = 1, "                                + &
				"  table_name          = '" + ls_table_name + "' "           + &
				"from " + ls_table_name + ", pd_affil_stat " + &
				"where (" + ls_table_name + ".prac_id = pd_affil_stat.prac_id) and (pd_affil_stat.active_status = 1) and " + &
				"      (" + ls_table_name + "." + ls_exp_date_field + " <= '" + ls_upper_range_date + "') "
				if ll_active_only = 1 and lb_ActiveStatusFieldExists then
					ls_new_recordset += "and (" + ls_table_name + ".active_status = 1) "
				end if
				if not IsNull(ll_facility_id) then
					ls_new_recordset += "and (pd_affil_stat.parent_facility_id = " + String(ll_facility_id) + ")"
				end if
				// Exists recordset sql
				ls_exists_recordset = &
				"select key_id from alert_records " + &
				"where (alert_id = " + String(ll_alert_id) + ") and (table_name = '" + ls_table_name + "') and " + &
				"      (active_status in (1,2)) and (affil_active_status = 1) and " + &
				"      (exp_date <= '" + ls_upper_range_date + "') "
				if ll_active_only = 1 and lb_ActiveStatusFieldExists then
					ls_exists_recordset += "and (cre_active_status = 1) "
				end if
				if not IsNull(ll_facility_id) then
					ls_exists_recordset += "and (facility_id = " + String(ll_facility_id) + ")"
				end if
		end choose
end choose

if Not IsNull(ls_addtl_filter) and len(ls_addtl_filter) > 0 then ls_new_recordset += " and " + ls_addtl_filter  //(Appeon)Harry 03.12.2015 - for V151-Additional Notification Filters

// Build insert sql
ls_InsertSQL = &
"INSERT INTO alert_records ~r~n" + &
"  (alert_id,key_id,rec_id,prac_id,facility_id,exp_date,cre_active_status,affil_active_status,active_status,table_name) ~r~n" + &
"SELECT ~r~n" + &
"  t_new_recordset.alert_id, ~r~n"            + &
"  t_new_recordset.key_id, ~r~n"              + &
"  t_new_recordset.rec_id, ~r~n"              + &
"  t_new_recordset.prac_id, ~r~n"             + &
"  t_new_recordset.facility_id, ~r~n"         + &
"  t_new_recordset.exp_date, ~r~n"            + &
"  t_new_recordset.cre_active_status, ~r~n"   + &
"  t_new_recordset.affil_active_status, ~r~n" + &
"  t_new_recordset.active_status, ~r~n"       + &
"  t_new_recordset.table_name ~r~n"           + &
"FROM (" + ls_new_recordset + ") t_new_recordset ~r~n" + &
"     LEFT OUTER JOIN ~r~n" + &
"     (" + ls_exists_recordset + ") t_exists_recordset ~r~n" + &
"     ON (t_new_recordset.key_id = t_exists_recordset.key_id) ~r~n" + &
"WHERE t_exists_recordset.key_id IS NULL"

// Execute insert sql
ls_InsertSQL = ls_delete_record + ls_InsertSQL //(Appeon)Stephen 2013-09-07 - bug 3641:DEA/CSR Expiration
EXECUTE IMMEDIATE :ls_InsertSQL;
if SQLCA.SQLCode <> 0 then	
	if not ib_schedule and not gb_autoschedule then //scheduler - alfee 03.18.2010
		openwithparm(w_sql_msg,ls_InsertSQL) //Start Code Change ----03.17.2010 #V10 maha
	end if		
	Return -1 
end if

Return 1
end function

public function integer of_cachedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_cachedata
// $<arguments>
// $<returns> integer
// $<description> Cache data before run notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

gnv_appeondb.of_StartQueue()
ids_alert_hdr.Retrieve()
ids_alert_steps.Retrieve()
ids_facility_ver_rules.Retrieve()
SELECT max(seq_no) INTO :il_ver_seq_no FROM verif_info;
SELECT max(seq_no) INTO :il_ai_seq_no FROM net_dev_action_items;
SELECT getdate() INTO :idt_CurrentTime FROM ids;
gnv_appeondb.of_CommitQueue()

if IsNull(il_ver_seq_no) then il_ver_seq_no = 0
if IsNull(il_ai_seq_no) then il_ai_seq_no = 0

Return 1
end function

public function integer of_dostep (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_dostep
// $<arguments>
//		integer	ai_step
// $<returns> integer
// $<description> Execute step of notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.15.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
long ll_ai_rec_id
long ll_rec_id
long ll_prac_id
long ll_facility_id
long ll_action_type
long ll_app_id
long ll_alert_type
string ls_oppe_fppe
string ls_facility_name
string ls_CurrentTime
string ls_CurrentYear
string ls_exp_date
datetime ldt_exp_date
boolean lb_IsCreateEmail = false
boolean lb_IsCreateVerification = false
boolean lb_IsCreateActionItem = false

// Filter specified Step alert records
ids_alert_records.SetFilter("affil_step = " + String(ai_Step))
ids_alert_records.Filter()
ll_RowCount = ids_alert_records.RowCount()
if ll_RowCount <= 0 then Return 1

// Get time information
ls_CurrentYear = String(idt_CurrentTime, "yyyy")
ls_CurrentTime = String(idt_CurrentTime, "yyyy-mm-dd hh:mm:ss")

// Determine if create email (for all notification alert)
if of_IsCreateEmail(ai_Step) then
	// Get smtp information
	if is_EmailType = "Easymail!" then
		of_GetSmtpInfo(ai_Step)
	end if
	// Get email template
	if of_GetEmailTemplate(ai_Step) = 1 then
		lb_IsCreateEmail = true
	end if
end if

// Determine if create verification (for OPPE/FPPE and Birthday)
ll_alert_type = ids_alert_hdr.object.alert_type[1]
if ll_alert_type = 12 or ll_alert_type = 20 then
	lb_IsCreateVerification = true
	is_em_subject = Trim(ids_alert_steps.object.subject[ai_Step])
end if

// Determine if create action item (for Appl Stat Items Due)
if ll_alert_type = 13 then
	lb_IsCreateActionItem = true
	ll_ai_rec_id = gnv_app.of_get_id("RECORD_ID", ll_RowCount)
	ll_action_type = ids_alert_steps.object.action_type[ai_Step]
	ll_app_id = ids_alert_steps.object.app_id[ai_Step]
end if

// Process alert records
for ll_Row = 1 to ll_RowCount
	// Get practitioner information
	ll_rec_id = ids_alert_records.object.rec_id[ll_Row]
	ll_prac_id = ids_alert_records.object.prac_id[ll_Row]
	ll_facility_id = ids_alert_records.object.facility_id[ll_Row]
	ldt_exp_date = ids_alert_records.object.exp_date[ll_Row]
	
	// Clear log
	ids_alert_records.object.last_result[ll_Row] = ""
	ids_alert_records.SetRow(ll_Row)
	
	// Create email
	if lb_IsCreateEmail then
		choose case ll_alert_type
			case 20 // Birthday
				ls_exp_date = ls_CurrentYear + "-" + String(ldt_exp_date, "mm-dd")
				if ls_exp_date > ls_CurrentTime then
					of_CreateEmail(ll_prac_id)
				else
					lb_IsCreateVerification = false
				end if
			case 21 // Meeting Notices
				if ldt_exp_date > idt_CurrentTime then
					of_CreateEmail(ll_prac_id)
				end if
			case else
				of_CreateEmail(ll_prac_id)
		end choose
	else
		of_Log("Failed: Create email settings is incorrect for Notification. ")
	end if
	
	// Create verification record
	if lb_IsCreateVerification then
		ls_oppe_fppe = ids_alert_records.object.oppe_fppe[ll_Row]
		ls_facility_name = ids_alert_records.object.facility_name[ll_Row]
		of_CreateVerification(ll_rec_id, ll_prac_id, ll_facility_id, ls_oppe_fppe, ls_facility_name, ll_alert_type)
		of_Log("Succeed: Verification Created. ")
	end if
	
	// Create action item record
	if lb_IsCreateActionItem then
		of_CreateActionItem(ll_ai_rec_id, ll_prac_id, ll_facility_id, ll_action_type, ll_app_id)
		of_Log("Succeed: Action Created. ")
		ll_ai_rec_id ++
	end if
next

Return 1
end function

public function integer of_run (long al_alert_id);//////////////////////////////////////////////////////////////////////
// $<function> of_run
// $<arguments>
//		long	al_alert_id
// $<returns> integer
// $<description> Run specified notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

integer li_Step
integer li_StepCount
integer li_alert_type
integer li_Return

// Filter specified notification alert settings
ids_alert_hdr.SetFilter("alert_id = " + String(al_alert_id))
ids_alert_steps.SetFilter("alert_id = " + String(al_alert_id))
ids_alert_hdr.Filter()
ids_alert_steps.Filter()

li_StepCount = ids_alert_steps.RowCount()
if ids_alert_hdr.GetRow() <> 1 then Return -1
if li_StepCount < 1 or li_StepCount > 10 then Return -1
//debugbreak()
// Run AIQ according to alert type
li_alert_type = ids_alert_hdr.object.alert_type[1]
choose case li_alert_type
	case 10, 11, 12, 13, 14, 15, 16, 40  //Expired Records //(Appeon)Stephen 11.30.2016 -add '40' V15.3-Combined Expiring Credentials in Notifications
		li_Return = of_RunExpired(al_alert_id)
	case 20, 21, 22 //Scheduled by Date - Add the '22' for V12.2 Scheduled Email - Alfee 08.04.2012
		li_Return = of_RunExpired(al_alert_id) 
	//case 22 //Scheduled Email an Attachment
		//li_Return = of_run_scheduledemail(al_alert_id)
	case 30     //Created Data
		li_Return = of_RunNew(al_alert_id)
	case else
		Return -1
end choose

Return li_Return
end function

public function boolean of_activestatusfieldexists (string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_activestatusfieldexists
// $<arguments>
//		string	as_table_name
// $<returns> integer
// $<description> Check active status field if exists in table
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.15.2010
//////////////////////////////////////////////////////////////////////

as_table_name = Lower(Trim(as_table_name))

choose case as_table_name
	case "pd_address", "pd_affil_dept", "pd_attest_questions"
		Return true
	case "pd_dea_state_csr", "pd_dues_fees", "pd_insurance", "pd_license"
		Return true
	case "pd_app_audit", "pd_affil_stat", "pd_oppe_hrd", "net_dev_action_items", "verif_info"
		Return true
	case "meetings"
		// The attendence table have active status field
		Return true
end choose

Return false
end function

public function integer of_getexportdata ();//////////////////////////////////////////////////////////////////////
// $<function> of_getexportdata
// $<arguments>
// $<returns> integer
// $<description> Get export data
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.20.2010
//////////////////////////////////////////////////////////////////////

long ll_prac_id[]
long ll_export_id
long ll_email_template
long ll_ElementCount
long i, j, ll_PracCount
long ll_method
integer li_Step
integer li_StepCount
integer li_alert_type
integer li_Index
integer li_facility_id
integer li_active_status
integer li_active[]
boolean lb_Exists
blob lblb_Null
string ls_sched_msg

SetNull(lblb_Null)
li_StepCount = ids_alert_steps.RowCount()
li_alert_type = ids_alert_hdr.object.alert_type[1]

//---------Begin Added by (Appeon)Stephen 11.30.2016 for V15.3-Combined Expiring Credentials in Notifications--------
li_facility_id = ids_alert_hdr.object.facility_id[1]
if isnull(li_facility_id) then li_facility_id = 0
li_active_status = ids_alert_hdr.object.active_only[1]
//---------End Added ------------------------------------------------------

if li_alert_type = 22 then return 1 //Do nothing for V12.2 Scheduled Email - alfee 08.04.2012 

// Get required information for export
for li_Step = 1 to li_StepCount
	// Check current step if need to export data
	if not of_IsCreateEmail(li_Step) then Continue

	// Get email template and export id of current step
	ll_email_template = ids_alert_steps.object.email_template[li_Step]
	ll_export_id = ids_alert_steps.object.export_id[li_Step]
	
	// Get prac ids of current step
	choose case li_alert_type
		case 10, 11, 12, 13, 14, 15, 16, 20, 21 //Expired Records and Scheduled by Date
			ids_alert_records.SetFilter("affil_step = " + String(li_Step))
			ids_alert_records.Filter()
			ll_PracCount = ids_alert_records.RowCount()
			if ll_PracCount > 0 then
				ll_prac_id[] = ids_alert_records.object.prac_id[1, ll_PracCount]
			end if
		case 30 //Created Data
			ll_PracCount = ids_new_record.RowCount()
			if ll_PracCount > 0 then
				ll_prac_id[] = ids_new_record.object.prac_id[1, ll_PracCount]
			end if
		case 40 //(Appeon)Stephen 11.30.2016 - V15.3-Combined Expiring Credentials in Notifications			
			ll_PracCount = ids_alert_records.RowCount()
			if ll_PracCount > 0 then
				ll_prac_id[] = ids_alert_records.object.prac_id[1, ll_PracCount]
			end if
	end choose
	
	// Find export id corresponding to export data
	li_Index = -1
	ll_ElementCount = UpperBound(istr_email_temp)
	for i = 1 to ll_ElementCount
		if ll_email_template = istr_email_temp[i].il_email_id then
			li_Index = i
		end if
	next
	if li_Index = -1 then
		li_Index = UpperBound(istr_email_temp) + 1
		istr_email_temp[li_Index].il_email_id = ll_email_template
		istr_email_temp[li_Index].il_export_id = ll_export_id
		istr_email_temp[li_Index].iblb_email_message = lblb_Null
		istr_email_temp[li_Index].iblb_attachment = lblb_Null
	end if
	
	// Get prac ids of export data
	ll_ElementCount = UpperBound(istr_email_temp[li_Index].il_prac_id)
	for i = 1 to ll_PracCount
		lb_Exists = false
		for j = 1 to ll_ElementCount
			if ll_prac_id[i] = istr_email_temp[li_Index].il_prac_id[j] then
				lb_Exists = true
				Exit
			end if
		next
		if not lb_Exists then
			ll_ElementCount ++
			istr_email_temp[li_Index].il_prac_id[ll_ElementCount] = ll_prac_id[i]
		end if
	next
next

// Export data process
ll_ElementCount = UpperBound(istr_email_temp)
for i = 1 to ll_ElementCount
	istr_email_temp[i].ids_export_data = Create datastore
	//---------Begin Added by (Appeon)Stephen 11.30.2016 for V15.3-Combined Expiring Credentials in Notifications--------
	if istr_email_temp[i].il_export_id = -99 then
		if not isvalid(ids_verif_detail) then
			ll_method = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Verification Method' and upper(code) = 'EXP CRED LTR'"))
			if li_active_status = 1 then
				li_active[1] = 1
			else
				li_active[1] = 1
				li_active[2] = 4
			end if
			ids_verif_detail = create datastore
			ids_verif_detail.dataobject = "d_ver_record_view_for_exp_comb"
			ids_verif_detail.settransobject(sqlca)
			ids_verif_detail.retrieve(li_facility_id, ll_method, li_active)
		end if
		if isnull(li_facility_id) then li_facility_id = 0
		of_exp_cred_notifi_combined(istr_email_temp[i].il_prac_id[], li_facility_id, li_active_status, istr_email_temp[i].ids_export_data)
	else
	//---------End Added ------------------------------------------------------
		if not IsNull(istr_email_temp[i].il_export_id) and UpperBound(istr_email_temp[i].il_prac_id) > 0 then
			inv_export.of_get_export_data(istr_email_temp[i].il_export_id, istr_email_temp[i].il_prac_id[], istr_email_temp[i].ids_export_data)
		end if
	end if
next

if gb_autoschedule or ib_schedule then //scheduler - alfee 03.11.2010
	ls_sched_msg = inv_export.of_get_sched_msg( )
	if LenA(ls_sched_msg) > 0 then inv_message.of_messagebox("", ls_sched_msg, true)
end if	

Return 1
end function

public function integer of_filteralertrecord (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_filteralertrecord
// $<arguments>
//		integer	ai_step
// $<returns> integer
// $<description> Filter alert records with step order
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

date ld_Today
long ll_alert_type
long ll_advance_days
string ls_range_date
string ls_CurrentYear
string ls_Filter

ld_Today = Date(idt_CurrentTime)
ls_CurrentYear = String(idt_CurrentTime, "yyyy")
ll_alert_type = ids_alert_hdr.object.alert_type[1]
ll_advance_days = ids_alert_steps.object.advance_days[ai_Step]
ls_range_date = String(RelativeDate(ld_Today, ll_advance_days), "yyyy-mm-dd")

// Build filter criteria
ls_Filter = "isnull(step" + String(ai_Step) + ") AND "
if ll_alert_type = 20 then // Birthday
	ls_Filter += "('" + ls_CurrentYear + "-' + string(exp_date, 'mm-dd')) <= '" + ls_range_date + "'"
elseif ll_alert_type = 22 then // V12.2 Scheduled Email - alfee 08.04.2012
	ls_Filter = "isnull(step" + String(ai_Step) + ") "
elseif ll_alert_type = 40 then //(Appeon)Stephen 12.02.2016 - V15.3-Combined Expiring Credentials in Notifications
	
else
	ls_Filter += "string(exp_date, 'yyyy-mm-dd') <= '" + ls_range_date + "'"
end if

// Filter records
ids_alert_records.SetFilter(ls_Filter)
ids_alert_records.Filter()

Return ids_alert_records.RowCount()
end function

public function integer of_setstepvalue (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_setstepvalue
// $<arguments>
//		integer	ai_step
// $<returns> integer
// $<description> Set step field value of alert records
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
long ll_alert_type //(Appeon)Stephen 12.02.2016 - V15.3-Combined Expiring Credentials in Notifications
string  ls_Value
string  ls_Today
string  ls_StepCol
integer li_StepCount
integer li_CurrentStep

li_StepCount = ai_Step
//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
ll_alert_type = ids_alert_hdr.object.alert_type[1]
if ll_alert_type = 40 then
	li_StepCount = 10
end if
//---------End Added ------------------------------------------------------

ls_Today = String(idt_CurrentTime, "yyyy-mm-dd")
// Filter alert records
ll_RowCount = of_FilterAlertRecord(ai_Step)

// Set step field value process
for ll_Row = 1 to ll_RowCount
	// Set affil_step flag
	ids_alert_records.SetItem(ll_Row, "affil_step", ai_Step)
	
	// Set step field value
	for li_CurrentStep = 1 to li_StepCount
		ls_StepCol = "step" + String(li_CurrentStep)
		if li_CurrentStep = li_StepCount then
			ids_alert_records.SetItem(ll_Row, ls_StepCol, ls_Today)
			//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
			if ll_alert_type = 40 then
				ids_alert_records.SetItem(ll_Row, "active_status", 2)
			end if
			//---------End Added ------------------------------------------------------
		else
			ls_Value = ids_alert_records.GetItemString(ll_Row, ls_StepCol)
			if IsNull(ls_Value) then
				ids_alert_records.SetItem(ll_Row, ls_StepCol, "NA")
				if ll_alert_type = 40 then exit //(Appeon)Stephen 12.13.2016 - V15.3-Combined Expiring Credentials in Notifications
			end if
		end if
	next
	
	// Set active_status as completed
	if ids_alert_records.object.complete_flag[ll_Row] = 1 and ll_alert_type <> 40 then //(Appeon)Stephen 12.13.2016 - add 'll_alert_type <> 40'  --V15.3-Combined Expiring Credentials in Notifications
		ids_alert_records.SetItem(ll_Row, "active_status", 2)
	end if
	
	//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
	if ll_alert_type = 40 then
		ids_alert_records.SetItem(ll_Row, "last_run", idt_CurrentTime)
	end if
	//---------End Added ------------------------------------------------------
next

Return 1
end function

public function integer of_stepprocess ();//////////////////////////////////////////////////////////////////////
// $<function> of_stepprocess
// $<arguments>
// $<returns> integer
// $<description> Execute each step process
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

integer li_Step
integer li_StepCount

li_StepCount = ids_alert_steps.RowCount()
for li_Step = 1 to li_StepCount
	of_DoStep(li_Step)
next

Return 1
end function

public function integer of_destroyexportdata ();//////////////////////////////////////////////////////////////////////
// $<function> of_destroyexportdata
// $<arguments>
// $<returns> integer
// $<description> Destroy export data
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

long ll_Null[]
integer i, li_Count
str_na_email_temp lstr_null[]

// Destroy export data
li_Count = UpperBound(istr_email_temp)
for i = 1 to li_Count
	istr_email_temp[i].il_prac_id[] = ll_Null[]
	if IsValid(istr_email_temp[i].ids_export_data) then
		Destroy istr_email_temp[i].ids_export_data		
	end if
next
istr_email_temp[] = lstr_null[]

Return 1
end function

public function integer of_savedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedata
// $<arguments>
// $<returns> integer
// $<description> Save data
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

integer li_run_frequency
datetime ldt_next_run_date

// Set next run date
li_run_frequency = ids_alert_hdr.object.run_frequency[1]
if li_run_frequency > 0 then
	ldt_next_run_date = DateTime(RelativeDate(Date(idt_CurrentTime), li_run_frequency), 00:00:00)
else
	ldt_next_run_date = DateTime(Date(idt_CurrentTime), 00:00:00)
end if
ids_alert_hdr.SetItem(1, "next_run_date", ldt_next_run_date)

// Update data
gnv_appeondb.of_StartQueue()
ids_alert_hdr.Update()
ids_alert_records.Update()
ids_verif_info.Update()
ids_action_items.Update()
ids_new_record.Update()
COMMIT;
gnv_appeondb.of_CommitQueue()

ids_alert_records.Reset()
ids_verif_info.Reset()
ids_action_items.Reset()
ids_new_record.Reset()

Return 1
end function

public function boolean of_iscreateemail (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_iscreateemail
// $<arguments>
//		integer	ai_step
// $<returns> boolean
// $<description> Determine if create email
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.21.2010
//////////////////////////////////////////////////////////////////////

if IsNull(ids_alert_steps.object.email_template[ai_Step]) then
	Return false
end if
if is_EmailType = "Easymail!" and not f_validstr(ids_alert_steps.object.email_from[ai_Step]) then
	Return false
end if
if not (f_validstr(ids_alert_steps.object.email_to[ai_Step]) or ids_alert_steps.object.email_prac[ai_Step] = 1) then
	Return false
end if

Return true
end function

public function long of_getemailmessage (long al_email_id, ref blob ablb_data);//////////////////////////////////////////////////////////////////////
// $<function> of_getemailmessage
// $<arguments>
//			 long	al_email_id
//		ref blob	ablb_data
// $<returns> long
// $<description> Get email message from template
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.25.2010
//////////////////////////////////////////////////////////////////////

blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops
long i, ll_ElementCount
integer li_Index

// Get email message from cache if exists
ll_ElementCount = UpperBound(istr_email_temp)
for i = 1 to ll_ElementCount
	if al_email_id = istr_email_temp[i].il_email_id then
		// The email message have been cached
		if not IsNull(istr_email_temp[i].iblb_email_message) then
			ablb_Data = istr_email_temp[i].iblb_email_message
			ll_data_length = LenA(ablb_Data)
			Return ll_data_length
		end if
		li_Index = i
		Exit
	end if
next

// Get email message from database
if gs_DBType = "ASA" or AppeonGetClientType() <> "PB" then
	SELECTBLOB email_message INTO :lb_all_data
	FROM wf_email
	WHERE email_id = :al_email_id;
else
	SELECT DataLength(email_message) INTO :ll_data_length
	FROM wf_email
	WHERE email_id = :al_email_id;
	
	if IsNull(ll_data_length) then ll_data_length = 0
	
	if ll_data_length > 8000 then
		if Mod(ll_data_length,8000) = 0 then
			ll_loops = ll_data_length / 8000
		else
			ll_loops = (ll_data_length / 8000) + 1
		end if
	elseif ll_data_length > 0 then
		ll_loops = 1
	end if
	
	for ll_counter = 1 to ll_loops
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(email_message,:ll_start,8000) INTO :lb_data
		FROM wf_email
		WHERE email_id = :al_email_id;
		lb_all_data += lb_data
	next
end if

// Set return data
ll_data_length = LenA(lb_all_data)
if ll_data_length >  0 then
	ablb_Data = lb_all_data
else
	ll_data_length = 0
	ablb_Data = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010
end if

// Cache data (Notes: The ablb_Data cannot be null)
if li_Index > 0 then
	istr_email_temp[li_Index].iblb_email_message = ablb_Data
else
	ll_ElementCount ++
	istr_email_temp[ll_ElementCount].il_email_id = al_email_id
	istr_email_temp[ll_ElementCount].iblb_email_message = ablb_Data
end if

Return ll_data_length
end function

public function long of_getemailattachment (long al_email_id, ref blob ablb_data);//////////////////////////////////////////////////////////////////////
// $<function> of_getemailattachment
// $<arguments>
//			 long	al_email_id
//		ref blob	ablb_data
// $<returns> long
// $<description> Get email attachment from template
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.25.2010
//////////////////////////////////////////////////////////////////////

blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops
long i, ll_ElementCount
integer li_Index

// Get email attachment from cache if exists
ll_ElementCount = UpperBound(istr_email_temp)
for i = 1 to ll_ElementCount
	if al_email_id = istr_email_temp[i].il_email_id then
		//if not IsNull(istr_email_temp[i].iblb_attachment) then
		if Len(istr_email_temp[i].iblb_attachment) > 0 then	//alfee 08.04.2012		
			ablb_Data = istr_email_temp[i].iblb_attachment
			ll_data_length = LenA(ablb_Data)
			Return ll_data_length
		end if
		li_Index = i
		Exit
	end if
next

// Get email attachment from database
if gs_DBType = "ASA" or AppeonGetClientType() <> "PB" then
	SELECTBLOB attachment INTO :lb_all_data
	FROM wf_email
	WHERE email_id = :al_email_id;
else
	SELECT DataLength(attachment) INTO :ll_data_length
	FROM wf_email
	WHERE email_id = :al_email_id;
	
	if IsNull(ll_data_length) then ll_data_length = 0
	
	if ll_data_length > 8000 then
		if Mod(ll_data_length,8000) = 0 then
			ll_loops = ll_data_length / 8000
		else
			ll_loops = (ll_data_length / 8000) + 1
		end if
	elseif ll_data_length > 0 then
		ll_loops = 1
	end if
	
	for ll_counter = 1 to ll_loops
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(attachment,:ll_start,8000) INTO :lb_data
		FROM wf_email
		WHERE email_id = :al_email_id;
		lb_all_data += lb_data
	next
end if

// Set return data
ll_data_length = LenA(lb_all_data)
if ll_data_length >  0 then
	ablb_Data = lb_all_data
else
	ll_data_length = 0
	ablb_Data = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010
end if

// Cache data (Notes: The ablb_Data cannot be null)
if li_Index > 0 then
	istr_email_temp[li_Index].iblb_attachment = ablb_Data
else
	ll_ElementCount ++
	istr_email_temp[ll_ElementCount].il_email_id = al_email_id
	istr_email_temp[ll_ElementCount].iblb_attachment = ablb_Data
end if

Return ll_data_length
end function

public function integer of_getsmtpinfo (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_getsmtpinfo
// $<arguments>
//		integer	ai_step
// $<returns> integer
// $<description> Get smtp infomation for step
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.28.2010
//////////////////////////////////////////////////////////////////////

string  ls_Temp[]
string  ls_smtp_info
n_cst_string lnv_string
n_cst_encrypt ln_encrypt

// Get addresser (V12.2-Email Logging) --- Added by evan 06.08.2012
is_em_email_from = ids_alert_steps.object.email_from[ai_Step]

gs_CurAddresser = is_em_email_from //(Appeon)Harry 06.27.2014 - email issue 

// Parse string to array
ls_smtp_info = ids_alert_steps.object.smtp_info[ai_Step]
lnv_string.of_ParseToArray(ls_smtp_info, "-S-", ls_Temp[])

//if UpperBound(ls_Temp[]) = 6 then
//if UpperBound(ls_Temp[]) = 7 then //BugA090401 - Alfee 09.24.2013
if UpperBound(ls_Temp[]) = 8 then //Added by Appeon long.zhang 05.26.2015 (Issue using easymail with notifications)
	is_smtp_server = ls_Temp[1]
	il_smtp_port = Long(ls_Temp[2])
	il_smtp_authmode = Long(ls_Temp[3])
	is_smtp_account = ls_Temp[4]
	is_smtp_password = ls_Temp[5]
	is_smtp_email = ls_Temp[6]
	il_smtpssl = Long(ls_Temp[7])  //Alfee 09.24.2013
	is_smtp_password = ln_encrypt.of_Decrypt(is_smtp_password)
	is_smtp_sendprotocol = ls_Temp[8] //Added by Appeon long.zhang 05.26.2015 (Issue using easymail with notifications)
else
	is_smtp_server = ""
	il_smtp_port = 0
	il_smtp_authmode = 0
	is_smtp_account = ""
	is_smtp_password = ""
	is_smtp_email = ""
	il_smtpssl = 0 //Alfee 09.24.2013
	is_smtp_sendprotocol = 'SMTP' //Added by Appeon long.zhang 05.26.2015 (Issue using easymail with notifications)
	Return -1
end if

Return 1
end function

public function integer of_getemailtemplate (integer ai_step);//////////////////////////////////////////////////////////////////////
// $<function> of_getemailtemplate
// $<arguments>
//		integer	ai_step
// $<returns> integer
// $<description> Get email template for step
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.28.2010
//////////////////////////////////////////////////////////////////////

long i, ll_ElementCount
long ll_email_template
long ll_alert_type //alfee 08.04.2012
string ls_attachment_file //alfee 08.04.2012
string ls_attach_name
blob lblb_Attachment


// Get email subject
is_em_subject = Trim(ids_alert_steps.object.subject[ai_Step])

// Get email message
ll_email_template = ids_alert_steps.object.email_template[ai_Step]
choose case is_EmailType
	case "Easymail!"
		if of_GetEmailMessage(ll_email_template, iblb_em_message) < 1 then
			Return -1
		end if		
	case "Outlook!"
		is_em_message = ids_alert_steps.object.email_msg[ai_Step]
		do while (pos(trim(is_em_message),"~r") = 1) //add by stephen 04.19.2013--Ticket # 00041301: Notifications are not being emailed
			is_em_message = mid(trim(is_em_message), 3)
		loop
		 
		if not f_validstr(is_em_message) then
			Return -1
		end if
end choose

// Get email attachment
is_em_attchment = '' //Reset it, Added by Appeon long.zhang 02.04.2016 (Email notifications attaching multiple times Case#61404 Bug_id#4965)
ls_attach_name = Trim(ids_alert_steps.object.attach_name[ai_Step])
if LenA(ls_attach_name) > 0 then
	if of_GetEmailAttachment(ll_email_template, lblb_Attachment) > 0 then
		is_em_attchment = gs_dir_path + "IntelliCred\" + ls_attach_name
		if w_email_edit.ole_word.of_WriteFile(is_em_attchment, lblb_Attachment) <> 1 then
			is_em_attchment = ""
		end if
	end if
end if

// Get additional attachments for V12.2 Scheduled Email - alfee 08.04.2012
ll_alert_type = ids_alert_hdr.object.alert_type[1]
if ll_alert_type = 22 then
	ls_attachment_file = ids_alert_steps.object.attachment_file[ai_Step]
	if len (ls_attachment_file) > 0 then
		is_em_attchment = ls_attachment_file + ", "  + is_em_attchment
	end if
end if

// Get recipients address
ii_em_email_prac = ids_alert_steps.object.email_prac[ai_Step]
//if ii_em_email_prac = 1 then debugbreak()
is_em_email_to = Trim(ids_alert_steps.object.email_to[ai_Step])
if IsNull(is_em_email_to) then is_em_email_to = ""

// Get export datastore
ll_ElementCount = UpperBound(istr_email_temp)
for i = 1 to ll_ElementCount
	if ll_email_template = istr_email_temp[i].il_email_id then
		ids_em_prac = istr_email_temp[i].ids_export_data
		il_export_id = istr_email_temp[i].il_export_id  //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		Exit
	end if
next

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.10.2013
//$<reason>get email cc --V12.3 add email cc
is_em_email_cc = ''
select   cc_recip into :is_em_email_cc                    
	  from wf_email where email_id = :ll_email_template; 
if isnull(is_em_email_cc) then is_em_email_cc =''
//------------------- APPEON END -------------------

Return 1
end function

public function integer of_easymailsend (string as_mailto);//////////////////////////////////////////////////////////////////////
// $<function> of_easymailsend
// $<arguments>
//		string	as_mailto
// $<returns> integer
// $<description> Send email with Easymail OCX
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.28.2010
//////////////////////////////////////////////////////////////////////

long ll_Return
string ls_MailCc
string ls_MailBcc
n_cst_easymail_smtp lnv_Easymail

// Create easymail object
lnv_Easymail.of_CreateObject()

//---------- APPEON BEGIN ----------
//$<modify> Evan 06.08.2012
//$<reason> V12.2-Email Logging
//lnv_Easymail.ib_SaveSentMail = false
lnv_Easymail.is_user_id = is_em_email_from
lnv_Easymail.iblb_MailContent = iblb_em_message
//---------- APPEON END ------------

//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
/*
// Set easymail object properties
//ll_Return = lnv_Easymail.of_SetSmtpInfo(is_smtp_server, il_smtp_port, il_smtp_authmode)
ll_Return = lnv_Easymail.of_SetSmtpInfo(is_smtp_server, il_smtp_port, il_smtp_authmode, il_smtpssl) //BugA090401 - Alfee 09.24.2013
if ll_Return < 0 then Return ll_Return
	
ll_Return = lnv_Easymail.of_SetAccountAddress(is_smtp_account, is_smtp_password, is_smtp_email)
if ll_Return < 0 then Return ll_Return
*/
str_email_account lstr_email_account 

lstr_email_account.as_sendserver = is_smtp_server
lstr_email_account.al_SendPort = il_smtp_port
lstr_email_account.ai_SendAuthMode = il_smtp_authmode
lstr_email_account.ai_sendssl = il_smtpssl
lstr_email_account.as_account = is_smtp_account
lstr_email_account.as_Password = is_smtp_password
lstr_email_account.as_EmailAddress = is_smtp_email
lstr_email_account.as_sendprotocol = is_smtp_sendprotocol //Added by Appeon long.zhang 05.26.2015 (Issue using easymail with notifications)

ll_Return = lnv_Easymail.of_SetSmtpInfo(lstr_email_account)
if ll_Return < 0 then Return ll_Return

ll_Return = lnv_Easymail.of_SetAccountAddress(lstr_email_account)
if ll_Return < 0 then Return ll_Return
//---------End Modfiied ------------------------------------------------------

// Send email
ls_MailCc = is_em_email_cc //add by stephen 05.10.2013 --add email cc --V12.3 add email cc
ll_Return = lnv_Easymail.of_SendHtml(as_MailTo, ls_MailCc, ls_MailBcc, is_em_subject, is_em_message_html, is_em_attchment)
lnv_Easymail.of_DeleteObject()

Return ll_Return //0 is Success
end function

public function integer of_outlooksend (string as_mailto);//////////////////////////////////////////////////////////////////////
// $<function> of_outlooksend
// $<arguments>
//		string	as_mailto
// $<returns> integer
// $<description> Send email with Outlook
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.28.2010
//////////////////////////////////////////////////////////////////////

long ll_Return
string ls_MailCc
string ls_MailBcc

if inv_Outlook.of_Logon() = -1 then
	Return -1
end if

ls_MailCc = is_em_email_cc //add by stephen 05.10.2013 --add email cc --V12.3 add email cc

ll_Return = inv_Outlook.of_Send(as_MailTo, ls_MailCc, ls_MailBcc, is_em_subject, is_em_message, is_em_attchment)
if ll_Return = 1 then
	Return 1
else
	Return -1
end if
end function

public function integer of_modifyupdateproperty (datastore ads_data);//////////////////////////////////////////////////////////////////////
// $<function> of_modifyupdateproperty
// $<arguments>
//		datastore	ads_data
// $<returns> integer
// $<description> Modify Alert Records datawindow update properties
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.03.2010
//////////////////////////////////////////////////////////////////////

// Modify datawindow's update property
ads_data.Modify("datawindow.table.updatetable= 'alert_records'")

// Modify column's update property
ads_data.Modify("ar_id.update = yes")
ads_data.Modify("rec_id.update = yes")
ads_data.Modify("prac_id.update = yes")
ads_data.Modify("facility_id.update = yes")
ads_data.Modify("exp_date.update = yes")
ads_data.Modify("active_status.update = yes")
ads_data.Modify("step1.update = yes")
ads_data.Modify("step2.update = yes")
ads_data.Modify("step3.update = yes")
ads_data.Modify("step4.update = yes")
ads_data.Modify("step5.update = yes")
ads_data.Modify("step6.update = yes")
ads_data.Modify("step7.update = yes")
ads_data.Modify("step8.update = yes")
ads_data.Modify("step9.update = yes")
ads_data.Modify("step10.update = yes")
ads_data.Modify("last_result.update = yes")
		
// Modify key field property
ads_data.Modify("ar_id.key = yes")

Return 1
end function

public function integer of_runexpired (long al_alert_id);//////////////////////////////////////////////////////////////////////
// $<function> of_runexpired
// $<arguments>
//		long	al_alert_id
// $<returns> integer
// $<description> Run specified notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

integer li_Step
integer li_StepCount
long ll_RowCount

// Get expiration records from credentail and alert_records tables
ll_RowCount = of_GetExpiredRecord()
if ll_RowCount <= 0 then
	of_SaveData()
	Return 1
end if
inv_message.of_set_proc_cnt(ll_RowCount, True) //scheduler - alfee 03.11.2010

// Set step field value of alert records
li_StepCount = ids_alert_steps.RowCount()
for li_Step = li_StepCount to 1 step -1
	of_SetStepValue(li_Step)
next

// Get export data for create email
of_GetExportData()

// Execute each step
of_StepProcess()

// Save data
of_SaveData()

// Destroy export data
of_DestroyExportData()

Return 1
end function

public function integer of_runnew (long al_alert_id);//////////////////////////////////////////////////////////////////////
// $<function> of_runnew
// $<arguments>
//		long	al_alert_id
// $<returns> integer
// $<description> Run specified notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

long i, ll_Row
long ll_RowCount
long ll_ai_rec_id
long ll_prac_id
long ll_facility_id
long ll_prac_facility
long ll_action_type
long ll_app_id
integer li_Step = 1
boolean lb_IsCreateEmail = false

// Get new records according to alert type
ll_RowCount = of_GetNewRecord()
if ll_RowCount <= 0 then
	of_SaveData()
	Return 1
end if
inv_message.of_set_proc_cnt(ll_RowCount, True) //scheduler - alfee 03.11.2010

// Get export data for create email
of_GetExportData()


// Determine if create email (one step only)
if of_IsCreateEmail(li_Step) then
	// Get smtp information
	if is_EmailType = "Easymail!" then
		of_GetSmtpInfo(li_Step)
	end if
	// Get email template
	if of_GetEmailTemplate(li_Step) = 1 then
		lb_IsCreateEmail = true
	end if
end if

// Process new records
ll_facility_id = ids_alert_hdr.object.facility_id[1]
if ll_facility_id = 0 then
	ll_ai_rec_id = gnv_app.of_get_id("RECORD_ID", ids_prac_facility.RowCount())
else //Evan 02.06.2012 - The ability to select facility for new practitioner
	ll_ai_rec_id = gnv_app.of_get_id("RECORD_ID", ll_RowCount)
end if
ll_action_type = ids_alert_steps.object.action_type[li_Step]
ll_app_id = ids_alert_steps.object.app_id[li_Step]


//------------------- APPEON BEGIN -------------------
//$<add> Stephen 12.07.2012
//$<reason> Action Items Query was run the system ‘Hung’ for a long period of time
if isvalid(w_aiq_run) and ll_RowCount > 30  then 
	w_aiq_run.st_2.visible = true
	w_aiq_run.r_2.visible = true
	w_aiq_run.r_status2.visible = true
end if
//------------------- APPEON END -------------------

for ll_Row = 1 to ll_RowCount
	// Get practitioner information
	ll_prac_id = ids_new_record.object.prac_id[ll_Row]
	
	// Create email
	if lb_IsCreateEmail then
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 12.06.2012
		//$<reason> Action Items Query was run the system ‘Hung’ for a long period of time
		/*	of_CreateEmail(ll_prac_id)*/
		if of_CreateEmail(ll_prac_id) <> 1 then
			of_DestroyExportData()
			if isvalid(w_aiq_run) and ll_RowCount > 30  then		
				w_aiq_run.setfocus()
				w_aiq_run.st_2.visible = false
				w_aiq_run.r_2.visible = false
				w_aiq_run.r_status2.visible = false
			end if	
			
			return 1
		end if
		
		if isvalid(w_aiq_run)  then		
			yield()
			w_aiq_run.setfocus()
			if ll_RowCount > 30 then				
				w_aiq_run.st_2.text = 'Sending Email...'
				w_aiq_run.r_2.width = 2094
				w_aiq_run.r_status2.width = integer(2094 * ll_Row / ll_RowCount)
			end if

		end if		
		//------------------- APPEON END -------------------	
	end if
	
	// Create action item record
	if ll_facility_id = 0 then
		ids_prac_facility.SetFilter("prac_id = " + String(ll_prac_id))
		ids_prac_facility.Filter()
		for i = 1 to ids_prac_facility.RowCount()
		//------------appeon begin---------------
		//<$>Modified:long.zhang 08.24.2012
		//<$>reason:	for a detect issue
		//ll_facility_id = ids_prac_facility.object.facility_id[i]
		//	of_CreateActionItem(ll_ai_rec_id, ll_prac_id, ll_facility_id, ll_action_type, ll_app_id)
			ll_prac_facility = ids_prac_facility.object.facility_id[i]	
			of_CreateActionItem(ll_ai_rec_id, ll_prac_id, ll_prac_facility, ll_action_type, ll_app_id)
			//--------------------appeon end-----------
			ll_ai_rec_id ++
		next
	else //Evan 02.06.2012 - The ability to select facility for new practitioner
		of_CreateActionItem(ll_ai_rec_id, ll_prac_id, ll_facility_id, ll_action_type, ll_app_id)
		ll_ai_rec_id ++
	end if
	
	// Set new record flag
	ids_new_record.SetItem(ll_Row, "is_new", 0)
next

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 12.07.2012
//$<reason> Action Items Query was run the system ‘Hung’ for a long period of time
if isvalid(w_aiq_run)  and ll_RowCount > 30  then		
	w_aiq_run.setfocus()
	w_aiq_run.st_2.visible = false
	w_aiq_run.r_2.visible = false
	w_aiq_run.r_status2.visible = false
end if		
//------------------- APPEON END -------------------

// Save data
of_SaveData()

// Destroy export data
of_DestroyExportData()

Return 1
end function

public function long of_getnewrecord ();//////////////////////////////////////////////////////////////////////
// $<function> of_getnewrecord
// $<arguments>
// $<returns> long
// $<description> Get new records of specified table
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.11.2010
//////////////////////////////////////////////////////////////////////

long ll_RowCount
long ll_alert_type
long ll_facility_id
string ls_SQLSelect

// Set data object according to alert type
//maha 10.26 change this to pass alert type as argument - called from of_runnew
ll_alert_type = 30  //  ids_alert_hdr.object.alert_type[1]
choose case ll_alert_type
	case 30 //New Practitioner
		ids_new_record.DataObject = "d_na_ds_pd_basic"
		ids_prac_facility.DataObject = "d_na_ds_pd_basic_facility"
	case else
		Return -1
end choose

// Build address records sql
//-------------------------appeon begin------------------
//<$>Modified:long.zhang appeon 03.06.2013
//<$>reason:should be sent to  mailing address only.  Bug 3430
//ls_SQLSelect = &
//"SELECT A.prac_id, " + &
//"		  A.e_mail_address " + &
//"FROM pd_address A, " + &
//"	  (select distinct prac_id from pd_basic where is_new = 1) B " + &
//"WHERE (A.prac_id = B.prac_id)"

//-------------appeon begin----------------------
//<$>added:long.zhang 08.07.2013
//<$>reason:Notifications for 0 days sending email to all contacts for all addresses

//ls_SQLSelect = &
//"SELECT A.prac_id, " + &
//"		  A.e_mail_address " + &
//"FROM pd_address A, " + &
//"	  (select distinct prac_id from pd_basic where is_new = 1) B, " + &
//"	 pd_address_link C " + &
//"WHERE (A.prac_id = B.prac_id) and (A.rec_id=C.address_id and C.mailing = 1)"
//
ls_SQLSelect = &
"SELECT A.prac_id, " + &
"		  A.e_mail_address, " + &
"C.mailing " + &
"FROM pd_address A, " + &
"	  (select distinct prac_id from pd_basic where is_new = 1) B, " + &
"	 pd_address_link C " + &
"WHERE (A.prac_id = B.prac_id) and (A.rec_id=C.address_id and C.mailing = 1)"
//-------------appeon End------------------------
//-----------------------appeon end--------------------
ids_pd_address.SetSQLSelect(ls_SQLSelect)

// Retrieve new records
ids_new_record.SetTransObject(SQLCA)
ids_prac_facility.SetTransObject(SQLCA)

//---------Begin Added by (Appeon)Stephen 09.12.2014 for Notification Setup--------
ll_facility_id = ids_alert_hdr.object.facility_id[1]
if isnull(ll_facility_id) then
	ll_facility_id = 0
end if
//---------End Added ------------------------------------------------------
	
gnv_appeondb.of_StartQueue()
//---------Begin Modified by (Appeon)Stephen 09.12.2014 for Notification Setup--------
//ids_new_record.Retrieve()
ids_new_record.Retrieve(ll_facility_id)
//---------End Modfiied ------------------------------------------------------
ids_prac_facility.Retrieve()
ids_pd_address.Retrieve()
gnv_appeondb.of_CommitQueue()
ll_RowCount = ids_new_record.RowCount()

Return ll_RowCount
end function

public function integer of_createactionitem (long al_rec_id, long al_prac_id, long al_facility_id, long al_action_type, long al_app_id);//////////////////////////////////////////////////////////////////////
// $<function> of_createactionitem
// $<arguments>
//		long		al_rec_id
//		long		al_prac_id
//		long		al_facility_id
//		long		al_action_type
//		long		al_app_id
// $<returns> integer
// $<description> Create action item record
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.11.2010
//////////////////////////////////////////////////////////////////////

long ll_InsertRow

il_ai_seq_no ++

ll_InsertRow = ids_action_items.InsertRow(0)
ids_action_items.SetItem(ll_InsertRow, "rec_id", al_rec_id)
ids_action_items.SetItem(ll_InsertRow, "prac_id", al_prac_id)
ids_action_items.SetItem(ll_InsertRow, "facility_id", al_facility_id)
ids_action_items.SetItem(ll_InsertRow, "seq_no", il_ai_seq_no)
ids_action_items.SetItem(ll_InsertRow, "active_status", 1)
ids_action_items.SetItem(ll_InsertRow, "print_flag", 0)
ids_action_items.SetItem(ll_InsertRow, "number_sent", 0)
ids_action_items.SetItem(ll_InsertRow, "action_type", al_action_type)
ids_action_items.SetItem(ll_InsertRow, "app_id", al_app_id)

//------------------- APPEON BEGIN -------------------
//$<add> Michael 06.23.2011
//$<reason> V11.3 Action Item Dates
ids_action_items.SetItem(ll_InsertRow, "create_date",datetime(today(),now()))
ids_action_items.SetItem(ll_InsertRow, "create_user","Sys-Notify")
//------------------- APPEON END ---------------------

Return 1
end function

public function integer of_createverification (long al_rec_id, long al_prac_id, long al_facility_id, string as_oppe_fppe, string as_facility_name, long al_alerttype);//////////////////////////////////////////////////////////////////////
// $<function> of_createverification
// $<arguments>
//		long		al_rec_id
//		long		al_prac_id
//		long		al_facility_id
//		string	as_oppe_fppe
//		string	as_facility_name
//		long		al_alerttype
// $<returns> integer
// $<description> Create verification record
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.01.2010
//////////////////////////////////////////////////////////////////////

long ll_FindRow
long ll_InsertRow
string ls_doc_id
string ls_reference_value

il_ver_seq_no ++
ls_doc_id = String(al_rec_id) + "-" + String(al_prac_id) + "-" + String(al_facility_id) +  "-" + String(il_ver_seq_no)

// Insert a verification record
ll_InsertRow = ids_verif_info.InsertRow(0)
ids_verif_info.SetItem(ll_InsertRow, "rec_id", al_rec_id)
ids_verif_info.SetItem(ll_InsertRow, "prac_id", al_prac_id)
ids_verif_info.SetItem(ll_InsertRow, "facility_id", al_facility_id)
ids_verif_info.SetItem(ll_InsertRow, "seq_no", il_ver_seq_no)
ids_verif_info.SetItem(ll_InsertRow, "doc_id", ls_doc_id)

ids_verif_info.SetItem(ll_InsertRow, "number_sent", 0)
ids_verif_info.SetItem(ll_InsertRow, "exp_credential_flag", 0)
ids_verif_info.SetItem(ll_InsertRow, "print_flag", 1)
ids_verif_info.SetItem(ll_InsertRow, "active_status", 1)
//Start Code Change ----08.04.2011 #V11 maha - create fields
ids_verif_info.SetItem(ll_InsertRow, "create_date", datetime(today(),now()))
ids_verif_info.SetItem(ll_InsertRow, "create_user", "Sys-Notif")
//End Code Change ----08.04.2011 #V11 maha

choose case al_AlertType
	case 12 //for OPPE/FPPE
		if LenA(as_oppe_fppe) > 0 and LenA(as_facility_name) > 0 then
			ls_reference_value = as_oppe_fppe + " - " + as_facility_name
		elseif LenA(as_oppe_fppe) > 0 then
			ls_reference_value = as_oppe_fppe
		else
			ls_reference_value = as_facility_name
		end if
		ids_verif_info.SetItem(ll_InsertRow, "reference_value", ls_reference_value)
		ids_verif_info.SetItem(ll_InsertRow, "verification_method", 10014) //10014 - Practitioner Correspondence
		ids_verif_info.SetItem(ll_InsertRow, "screen_id", 1) //1-Basic Information (is default)
	case 20 //for Birthday
		ll_FindRow = ids_facility_ver_rules.Find("facility_id = " + String(al_facility_id) + " and screen_id = 1", 1, ids_facility_ver_rules.RowCount())
		if ll_FindRow > 0 then
			ids_verif_info.SetItem(ll_InsertRow, "priority_user", ids_facility_ver_rules.object.priority_user[ll_FindRow])
			ids_verif_info.SetItem(ll_InsertRow, "priority", ids_facility_ver_rules.object.priority[ll_FindRow])
			ids_verif_info.SetItem(ll_InsertRow, "verification_method", 10014) //10014 - Practitioner Correspondence
		end if
		ids_verif_info.SetItem(ll_InsertRow, "reference_value", is_em_subject)
		ids_verif_info.SetItem(ll_InsertRow, "screen_id", 1) //1-Basic Information
end choose

Return 1
end function

public function string of_getemailaddress (long al_prac_id);//////////////////////////////////////////////////////////////////////
// $<function> of_getemailaddress
// $<arguments>
//		long	al_prac_id
// $<returns> string
// $<description> Get practitiner email address
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.18.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount
string ls_email
string ls_email_str
boolean lb_fix = false  //(Appeon)Stephen 01.14.2014 - Check email address

//ids_pd_address.SetFilter("prac_id = " + String(al_prac_id))
ids_pd_address.SetFilter("prac_id = " + String(al_prac_id)+" and mailing=1")//long.zhang 08.07.2013
ids_pd_address.Filter()
ll_RowCount = ids_pd_address.RowCount()

for ll_Row = 1 to ll_RowCount
	ls_email = Trim(ids_pd_address.object.e_mail_address[ll_Row])
	
	//---------Begin Modified by (Appeon)Stephen 01.14.2014 for Check email address--------
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 12.07.2012
	//$<reason> Check email address
//	if f_check_emailaddress(ls_email) = -1 then
//		ls_email_str = '-1'
//		return ls_email_str
//	end if
	if f_check_emailaddress(ls_email) = -1 then
		continue
	else
		lb_fix = true
	end if
	//---------End Modfiied ------------------------------------------------------
	if pos(ls_email_str, ls_email) > 0 then Continue  //(Appeon)Harry 05.12.2015 - for Notification issues
	
	if f_validstr(ls_email) then
		if LenA(ls_email_str) > 0 then ls_email_str += "; "
		ls_email_str += ls_email
	end if
next

//---------Begin Added by (Appeon)Stephen 01.14.2014 for Check email address--------
if lb_fix = false then
	ls_email_str = '-1'
	return ls_email_str
end if
//---------End Added ------------------------------------------------------

Return ls_email_str
end function

public function integer of_createemail (long al_prac_id);//////////////////////////////////////////////////////////////////////
// $<function> of_createemail
// $<arguments>
//		long	al_prac_id
// $<returns> integer
// $<description> Create email content and send
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.28.2010
//////////////////////////////////////////////////////////////////////

long   ll_Return
string ls_MailTo
string ls_prac_email
string ls_em_message_temp
string ls_sched_msg
integer   ll_ret  //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
string ls_em_subject  //(Appeon)Harry 05.12.2015 - for Notification issues

// Get recipients address
if ii_em_email_prac = 1 then
	ls_prac_email = of_GetEmailAddress(al_prac_id)
	if ls_prac_email = '-1' then 
		of_Log("Failed: Email not sent. No or invalid Email address. ") //alfee 06.12.2014
		return 1  //add by stephen 12.07.2012 --check email address
	end if
	
	if is_em_email_to = "" then
		ls_MailTo = ls_prac_email
	else
		ls_MailTo = is_em_email_to + ";" + ls_prac_email
	end if
else
	ls_MailTo = is_em_email_to
end if
//debugbreak()

ls_em_subject = is_em_subject   //(Appeon)Harry 05.12.2015 - for Notification issues
// Send email
choose case is_EmailType
	case "Easymail!"
		// Replace email template field
		ll_ret = w_email_edit.ole_word.of_Open(iblb_em_message)
		//---------Begin Added by (Appeon)Stephen 09.01.2017 for V15.4-WebView Reporting Functionality--------
		if ll_ret = -1 then
			of_Log("Failed:Can not create doc file. ")
			ll_ret = -1 
		end if
		//---------End Added ------------------------------------------------------
		//inv_word.of_replace_export_word(w_email_edit.ole_word.object.activedocument, al_prac_id, ids_em_prac)  //Commented by (Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		inv_word.of_replace_export_word(w_email_edit.ole_word.object.activedocument,  is_em_subject, al_prac_id, il_export_id, ids_em_prac, false) //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		is_em_message_html = w_email_edit.ole_word.of_GetHtmlFile()
		w_email_edit.ole_word.of_Close()
		// Send email
		ll_Return = of_EasymailSend(ls_MailTo)
		if ll_Return = 0 then
			of_Log("Succeed: Email Sent. ")
			ll_ret = 1    //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
		else
			of_Log("Failed: User email settings not properly set up. Error code is " + String(ll_Return) + ". ")
			ll_ret = -1    //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
		end if
	case "Outlook!"
		// Replace email template field
		ls_em_message_temp = is_em_message
		inv_word.of_replace_export_text(is_em_message, al_prac_id, ids_em_prac)
		inv_word.of_replace_export_text(is_em_subject, al_prac_id, ids_em_prac)  //(Appeon)Harry 03.16.2015 - for Requesting new V14.2 Web Package - Bug # 4439 - Merge fields in subject are not populating
		// Send email
		if of_OutlookSend(ls_MailTo) = 1 then
			of_Log("Succeed: Email Sent. ")
			ll_ret = 1    //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
		else
			of_Log("Failed: Email not sent. Outlook unknow error. ")
			ll_ret = -1    //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
		end if
		is_em_message = ls_em_message_temp
end choose
is_em_subject = ls_em_subject   //(Appeon)Harry 05.12.2015 - for Notification issues

if gb_autoschedule or ib_schedule then //scheduler - alfee 03.11.2010
	ls_sched_msg = inv_word.of_get_sched_msg( )
	if LenA(ls_sched_msg) > 0 then inv_message.of_messagebox("", ls_sched_msg, true)
end if	

//return 1       //delete by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
Return ll_ret   //add by stephen 12.06.2012  -- Action Items Query was run the system ‘Hung’ for a long period of time
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 03.05.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 03.05.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 03.05.2010

return inv_message.of_get_proc_cnt( )
end function

public function long of_getexpiredrecord ();//////////////////////////////////////////////////////////////////////
// $<function> of_getexpiredrecord
// $<arguments>
// $<returns> long
// $<description> Get expiration records from alert_records table
//called from of_runexpired
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.13.2010
//////////////////////////////////////////////////////////////////////

long ll_alert_id
long ll_alert_type
long ll_facility_id
long ll_active_only
long ll_upper_range
long ll_Step
long ll_RowCount
integer res //maha 031910
integer li_next_run_days //(Appeon)Stephen 12.01.2016 - V15.3-Combined Expiring Credentials in Notifications
string ls_Express
string ls_ExpCriteria
string ls_SQLSelect
string ls_Today //alfee 08.04.2012
string ls_table_name
string ls_CurrentYear
string ls_upper_range_date
boolean lb_ActiveStatusFieldExists

ll_alert_id = ids_alert_hdr.object.alert_id[1]
ll_alert_type = ids_alert_hdr.object.alert_type[1]
ll_facility_id = ids_alert_hdr.object.facility_id[1]
ll_active_only = ids_alert_hdr.object.active_only[1]
ls_table_name = ids_alert_hdr.object.table_name[1]
ll_upper_range = ids_alert_hdr.object.upper_range[1]
ls_Today = String(idt_CurrentTime, "yyyy-mm-dd") //alfee 08.04.2012
ls_CurrentYear = String(idt_CurrentTime, "yyyy")
ls_upper_range_date = String(RelativeDate(Date(idt_CurrentTime), ll_upper_range), "yyyy-mm-dd") + " 23:59:59"
lb_ActiveStatusFieldExists = of_ActiveStatusFieldExists(ls_table_name)
//---------Begin Added by (Appeon)Stephen 12.27.2016 for V15.3-Combined Expiring Credentials in Notifications--------
if ll_alert_type = 40 then
	ls_table_name = "Exp Cred Combined"
end if
//---------End Added ------------------------------------------------------

// Dynamic modify complete flag express according to step count
ll_RowCount = ids_alert_steps.RowCount()
if ll_RowCount < 1 then return 0 //(Appeon)Stephen 12.01.2016 - V15.3-Combined Expiring Credentials in Notifications
for ll_Step = 1 to ll_RowCount
	if LenA(ls_Express) > 0 then ls_Express += " or "
	ls_Express += "isnull(step" + String(ll_Step) + ")"
next
ls_Express = "if (" + ls_Express + ", 0, 1)"
ids_alert_records.object.complete_flag.expression = ls_Express

// Build expiration records sql
if ll_alert_type = 40 and ll_active_only <> 1 then //(Appeon)Stephen 03.20.2017 - V15.3 Bug # 5565 -Notifications: Issue with Exp Cred Combined 
	ls_ExpCriteria = &
	"(alert_records.alert_id = " + String(ll_alert_id) + ") AND (table_name = '" + ls_table_name + "') AND " + &
	"(alert_records.active_status = 1) AND (alert_records.affil_active_status in(1,4)) "
else
	ls_ExpCriteria = &
	"(alert_records.alert_id = " + String(ll_alert_id) + ") AND (table_name = '" + ls_table_name + "') AND " + &
	"(alert_records.active_status = 1) AND (alert_records.affil_active_status = 1) "
end if

if ll_alert_type = 20 then // Birthday
	ls_ExpCriteria += "AND (('" + ls_CurrentYear + "-' + convert(char(5),alert_records.exp_date,10)) <= '" + ls_upper_range_date + "') "
elseif ll_alert_type = 22 then //V12.2 Scheduled Email - alfee 08.04.2012
	ls_ExpCriteria = "(alert_records.alert_id = " + String(ll_alert_id) + ")  AND (alert_records.active_status = 1) AND " + &
	"(alert_records.exp_date = '" + ls_Today + "') "
elseif ll_alert_type = 40 then //(Appeon)Stephen 12.01.2016 - V15.3-Combined Expiring Credentials in Notifications
	li_next_run_days = ids_alert_steps.getitemnumber(1, "next_run_days")
	if isnull(li_next_run_days) then li_next_run_days = 0
	ls_ExpCriteria += " and (last_run is null or last_run <= '" + String(RelativeDate(Date(idt_CurrentTime), 0 - li_next_run_days ), "yyyy-mm-dd") + " 23:59:59" +"') "
else
	ls_ExpCriteria += "AND (alert_records.exp_date <= '" + ls_upper_range_date + "') "
end if
if ll_active_only = 1 and lb_ActiveStatusFieldExists then
	ls_ExpCriteria += "AND (alert_records.cre_active_status = 1) "
end if
if not IsNull(ll_facility_id) then
	ls_ExpCriteria += "AND (alert_records.facility_id = " + String(ll_facility_id) + ")"
end if
ls_SQLSelect = is_alert_records_sql + " WHERE " + ls_ExpCriteria
ids_alert_records.SetSQLSelect(ls_SQLSelect)
res = of_ModifyUpdateProperty(ids_alert_records)

// Build address records sql
//---------------------------appeon begin-------------------
//<$>Modified:long.zhang appeon 03.06.2013
//<$>reason:should be send mailing address only Bug 3430
//ls_SQLSelect = &
//"SELECT A.prac_id, " + &
//"		  A.e_mail_address " + &
//"FROM pd_address A, " + &
//"	  (select distinct prac_id from alert_records where " + ls_ExpCriteria + ") B " + &
//"WHERE (A.prac_id = B.prac_id)"

//-------------appeon begin----------------------
//<$>added:long.zhang 08.07.2013
//<$>reason:Notifications for 0 days sending email to all contacts for all addresses
//ls_SQLSelect = &
//"SELECT A.prac_id, " + &
//"		  A.e_mail_address " + &
//"FROM pd_address A, " + &
//"	  (select distinct prac_id from alert_records where " + ls_ExpCriteria + ") B, " + &
//"	 pd_address_link C " + &
//"WHERE (A.prac_id = B.prac_id) and (A.rec_id=C.address_id and C.mailing = 1)"

ls_SQLSelect = &
"SELECT A.prac_id, " + &
"		  A.e_mail_address, " + &
"		  C.mailing " + &
"FROM pd_address A, " + &
"	  (select distinct prac_id from alert_records where " + ls_ExpCriteria + ") B, " + &
"	 pd_address_link C " + &
"WHERE (A.prac_id = B.prac_id) and (A.rec_id=C.address_id and C.mailing = 1)"
//-------------appeon End------------------------
//---------------------------appeon end-------------------------
res = ids_pd_address.SetSQLSelect(ls_SQLSelect)
//DebugBreak()

// Get expiration records
ids_alert_records.SetFilter("")
ids_alert_records.Filter()
ids_alert_records.Reset()
ids_pd_address.Reset()

gnv_appeondb.of_StartQueue()
of_BuildExpiredRecord()
res = ids_alert_records.Retrieve()
res = ids_pd_address.Retrieve()
gnv_appeondb.of_CommitQueue()
ll_RowCount = ids_alert_records.RowCount()

Return ll_RowCount
end function

public function integer of_log (string as_message);//////////////////////////////////////////////////////////////////////
// $<function> of_log
// $<arguments>
//		string	as_message
// $<returns> integer
// $<description> Set last result value of alert record
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.01.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
string ls_last_result

ll_Row = ids_alert_records.GetRow()
if ll_Row < 1 then Return -1

ls_last_result = ids_alert_records.object.last_result[ll_Row]
if LenA(ls_last_result) > 0 then
	ls_last_result += "~r~n" + as_Message
else
	ls_last_result = as_Message
end if
ids_alert_records.SetItem(ll_Row, "last_result", ls_last_result)

Return 1
end function

public function integer of_run_scheduledemail (long al_alert_id);//Commened by alfee 08.04.2012 

//////////////////////////////////////////////////////////////////////
// $<function> of_run_scheduledemail
// $<arguments>
//		long	al_alert_id
// $<returns> integer
// $<description> Run specified notification alert
//////////////////////////////////////////////////////////////////////
// $<add> Michael 07.04.2012 V12.2 Notification Email an Attachment
//////////////////////////////////////////////////////////////////////

//integer li_Step = 1
//long   ll_Return
//string ls_MailTo
//string ls_em_message_temp
//string ls_sched_msg
//
//
////inv_message.of_set_proc_cnt(0, True) //scheduler - alfee 03.11.2010
//
//// Get smtp information
//if is_EmailType = "Easymail!" then
//	of_GetSmtpInfo(li_Step)
//end if
//
////get attchment
//is_em_attchment = ids_alert_steps.object.attachment_file[li_Step]
//// Get recipients address
//ls_MailTo = ids_alert_steps.object.email_to[li_Step]
//is_em_subject = 'The report you scheduled on ' + String(Today(), "mm/dd/yyyy")
//is_em_message = 'Attached you will find the report you scheduled.' 
//iblb_em_message =  blob(is_em_message,EncodingAnsi!)
// 
//// Send email
//choose case is_EmailType
//	case "Easymail!"
//		// Send email
//		w_email_edit.ole_word.of_Open(iblb_em_message)	
//		is_em_message_html = w_email_edit.ole_word.of_GetHtmlFile()
//		ll_Return = of_EasymailSend(ls_MailTo)
//		if ll_Return = 0 then
//			of_Log("Succeed: Email Sent. ")
//		else
//			of_Log("Failed: User email settings not properly set up. Error code is " + String(ll_Return) + ". ")
//		end if
//	case "Outlook!"	
//		// Send email 
//		if of_OutlookSend(ls_MailTo) = 1 then
//			of_Log("Succeed: Email Sent. ")
//		else
//			of_Log("Failed: Email not sent. Outlook unknow error. ")
//		end if
//		is_em_message = ls_em_message_temp
//end choose
//
//
//// Save data
//of_SaveData()
//
////if gb_autoschedule or ib_schedule then //scheduler - alfee 03.11.2010
////	ls_sched_msg = inv_word.of_get_sched_msg( )
////	if LenA(ls_sched_msg) > 0 then inv_message.of_messagebox("", ls_sched_msg, true)
////end if	


Return 1
end function

public function integer of_get_new_prac_alerts ();//Start Code Change ----10.26.2012 #V12 maha - added: run from w_prac_data_1.of_notification
datastore lds_alerts
integer rc
integer r
long ll_aid

lds_alerts = create datastore

lds_alerts.dataobject = "d_na_hdr_new_prac"

lds_alerts.settransobject(sqlca)
rc = lds_alerts.retrieve()

	
for r = 1 to rc
	ll_aid = lds_alerts.getitemnumber(r,"alert_id")
	of_runnew( ll_aid)
next

destroy lds_alerts

return 1

end function

public function integer of_exp_cred_notifi_combined (long al_pracs[], integer ai_facility, integer ai_active, ref datastore ads_exp);//====================================================================
//$<Function>: of_exp_cred_notifi_combined
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.30.2016 (V15.3-Combined Expiring Credentials in Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_found
integer chk
integer li_active[]
long ll_prac[]
long p
long i
long ic
long pc
long ll_prac_get
long ll_method
string ls_filter
string ls_prac_get
string ls_field
string ls_test
string ls_doc
string ls_org_filter
datetime ldt_exp

ll_prac[] = al_pracs[]
if ai_active = 1 then
	li_active[1] = 1
else
	li_active[1] = 1
	li_active[2] = 4
end if
ads_exp.dataobject = "d_notofi_exp_cred_combined"
ads_exp.settransobject(sqlca)
pc = ads_exp.retrieve(ll_prac[] , ai_facility, li_active[])

//delete Duplicate rows
for i = 1 to pc
	if i > ads_exp.rowcount() then exit
	ls_prac_get = ads_exp.getitemstring(i, "prac_id")
	for p = ads_exp.rowcount() to i +1 step -1
		if ads_exp.getitemstring(p, "prac_id") = ls_prac_get then
			ads_exp.deleterow(p)
		end if
	next
next
pc = ads_exp.rowcount()
 
ll_method = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Verification Method' and upper(code) = 'EXP CRED LTR'"))
for p = 1 to upperbound(ll_prac)
	ll_prac_get = ll_prac[p]
	li_found = ads_exp.find("prac_id = '" + string(ll_prac_get ) + "'",1,pc)
	if li_found > 0 then 
		ls_filter = "prac_id = " + string(ll_prac_get ) + " and verification_method = " + string(ll_method ) + " and isnull(response_code) and active_status = 1 "
		chk = ids_verif_detail.setfilter(ls_filter)
		if chk = -1 then messagebox ("of_exp_cred_combined function","Filter failed. Contact Support")
		ids_verif_detail.filter()
		ic = ids_verif_detail.rowcount()
		for i = 1 to ic
			if i > 20 then exit
			ls_field = "reference_" + string(i)
			ls_test = ads_exp.dataobject
			ls_test = ids_verif_detail.getitemstring(i,"reference_value")
			ads_exp.setitem(li_found,ls_field, ls_test )
			ls_field = "screen_" + string(i)
			ads_exp.setitem(li_found,ls_field, ids_verif_detail.getitemstring(i,"screen_alias") )
			ls_field = "exp_date_" + string(i)
			ldt_exp = ids_verif_detail.getitemdatetime(i,"expiration_date")
			ads_exp.setitem(li_found,ls_field, string(date(ldt_exp)) )
		next
	end if //found
next
 
//clear the filter
ids_verif_detail.setfilter(ls_org_filter)
ids_verif_detail.filter()
//ads_exp.saveas("d:\xx.csv", csv!, true)
return 1
end function

on n_cst_notification_alert.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_notification_alert.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

ids_alert_hdr = Create datastore
ids_alert_steps = Create datastore
ids_alert_records = Create datastore
ids_pd_address = Create datastore
ids_facility_ver_rules = Create datastore
ids_verif_info = Create datastore
ids_action_items = Create datastore
ids_new_record = Create datastore
ids_prac_facility = Create datastore



ids_alert_hdr.DataObject = "d_na_ds_alert_hdr"
ids_alert_steps.DataObject = "d_na_ds_alert_steps"
ids_alert_records.DataObject = "d_na_ds_alert_records"
ids_pd_address.DataObject = "d_na_ds_address"
ids_facility_ver_rules.DataObject = "d_na_ds_facility_ver_rules"
ids_verif_info.DataObject = "d_na_ds_verif_info"
ids_action_items.DataObject = "d_na_ds_action_items"

ids_alert_hdr.SetTransObject(SQLCA)
ids_alert_steps.SetTransObject(SQLCA)
ids_alert_records.SetTransObject(SQLCA)
ids_pd_address.SetTransObject(SQLCA)
ids_facility_ver_rules.SetTransObject(SQLCA)
ids_verif_info.SetTransObject(SQLCA)
ids_action_items.SetTransObject(SQLCA)

is_alert_records_sql = ids_alert_records.GetSQLSelect()
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
//if of_get_app_setting("set_56", "I") = 1 then
	is_EmailType = "Outlook!"
end if

inv_word = Create n_cst_word_utility
inv_export = Create pfc_n_cst_ai_export_apb
inv_export.is_called_type = "3" 
inv_export.ib_gen_rec_id = true

if not IsValid(w_email_edit) then
	Open(w_email_edit)
end if
end event

event destructor;//////////////////////////////////////////////////////////////////////
// $<event> destructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.12.2010
//////////////////////////////////////////////////////////////////////

Destroy ids_alert_hdr
Destroy ids_alert_steps
Destroy ids_alert_records
Destroy ids_pd_address
Destroy ids_facility_ver_rules
Destroy ids_verif_info
Destroy ids_action_items
Destroy ids_new_record
Destroy ids_prac_facility

Destroy inv_word
Destroy inv_export
Destroy ids_verif_detail //(Appeon)Stephen 11.30.2016 - V15.3-Combined Expiring Credentials in Notifications

if IsValid(w_email_edit) then
	Close(w_email_edit)
end if

inv_Outlook.of_Logoff()
end event

