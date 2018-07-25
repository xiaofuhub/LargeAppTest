$PBExportHeader$n_cst_globaldata.sru
forward
global type n_cst_globaldata from nonvisualobject
end type
end forward

global type n_cst_globaldata from nonvisualobject
end type
global n_cst_globaldata n_cst_globaldata

type variables
datastore 	ids_security_users
datastore 	ids_icred_settings
datastore	ids_ids


datastore 	ids_systables

datastore  ids_code_lookup,ids_code_lookup_dddw , ids_code_lookup_date

datastore ids_sys_fields
datastore ids_ctx_notification
datastore ids_ctx_ai_notification, ids_ctx_am_ai_notification //Alfee 02.26.2008

long il_ids_sys_fields_cnt

datastore ids_facility
datastore ids_data_view_screen

datastore ids_contract_search
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
datastore ids_image_type

//---------------------------- APPEON END ----------------------------

//Added for work flow. 6/11/2006 Henry
datastore ids_workflow
datastore ids_workflow_action
datastore ids_workflow_status
datastore ids_workflow_trigger_comp
datastore ids_workflow_trigger_item
datastore ids_screen_table_p
datastore ids_screen_table_c

//Added for work flow. 4/12/2006 Jervis
datastore ids_workflow_status_filter
datastore ids_template_clause_rules //for template dynamic adding rules - Alfee 11.12.2007

//Added for dddw question. 8/15/2008 Alan
datastore ids_question_lookup
datastore ids_address_lookup //alfee 09.08.2009

datastore ids_dataflow //DataFlow - alfee 12.21.2009

datastore ids_na // V10.1 - Notification Alert - Andy 01/21/2010

datastore ids_app_step_cache //maha 07.30.2010

datastore ids_process_step_cache //maha 06.27.2011  ofe process tracking
//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
datastore ids_clause
datastore ids_clause_attribute
datastore ids_ctx_all_notification
datastore ids_ctx_facility
datastore ids_dashboard_getting_started
datastore ids_data_view
//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//datastore ids_em_user_config
//datastore ids_em_user_msg_list
n_ds ids_em_user_msg_list,ids_em_user_config
//---------End Modfiied ------------------------------------------------------
datastore ids_field_depend
datastore ids_getting_started
datastore ids_lookup_depend
//---------End Added ------------------------------------------------------------------

datastore ids_pictures //(Appeon)Harry 03.19.2014 - V142 ISG-CLX

//-------------------------- Added 3.4.2016 by Intertech Consulting---------------------------------
datastore ids_app_session_parms
//---------------------------------------------------------------------------------------------------------

String is_cachename_retrieved[] //Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)

end variables

forward prototypes
public function string of_getitem (string as_tablename, string as_columnname, boolean ab_multirows)
public function string of_getitem (string as_tablename, string as_columnname, string as_condition)
public subroutine of_initdatacache ()
public subroutine of_init_table_reccount (long al_tableids[])
public subroutine of_set_dwchild_fromcache (string as_table_name, string as_condition, datawindowchild a_dwchild)
public subroutine of_get_data_from_cache (string as_table_name, string as_condition, datastore a_dwchild)
public function long of_findrow (string as_tablename, string as_condition)
public function string of_getitem (string as_tablename, long al_row, string as_columnname)
public function string of_get_table_name (integer al_screen, string as_module, string as_column)
public function string of_get_filter_data (string as_tablename, string as_condition, string as_name)
public function string of_get_sys_field_value (string as_table, string as_field, string as_get_field)
public function long of_retrieve (string as_cachename)
public function integer of_get_defaultdddwcache ()
public function integer of_insert_main_data (datawindow adw_main, datawindow adw_detail, string as_main_table_name, long al_main_currentrow, long al_detail_currentrow)
public subroutine of_refresh_all_data ()
public subroutine of_refresh_systemdatacache ()
public function string of_getitem (string as_tablename, string as_columnname, string as_condition, string as_case)
public function integer of_get_wf_status_data (string as_tablename, string as_condition, string as_name, ref long al_data[])
public function long of_retrieve_appeon (string as_cachename)
public function long of_retrieveifnecessary (string as_cachename, boolean ab_alwaysretrieve)
public function integer of_getcache (string as_cachename, ref datastore ads_cache, ref string as_dataobject)
public function integer of_initcache (string as_cachename)
public subroutine of_add_cachename_retrieved (string as_cachename)
public function boolean of_is_cachename_retrieved (string as_cachename)
end prototypes

public function string of_getitem (string as_tablename, string as_columnname, boolean ab_multirows);//
string	ls_value

//------------------------------------------------------------------------
// 2.23.2016 <RP> added
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN
	return ""
END IF
//------------------------------------------------------------------------

Choose Case as_tablename
	Case 'icred_settings'
		Choose Case Lower(as_columnname)
			//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			  /*
				Case "dev_title","downloadurl"	
			  */
			Case "dev_title","downloadurl","wv_db_version","set_patch_ver","PntDownLoadPath","set_addresser","license_info","web_link_name","cache_name","email_encoding","calfiltername_1","calfiltername_2","calfiltername_3","email_tag","send_email_log_to","es_apicode","esign_type","echo_apicode",&  
					"docusign_apicode","docusign_username","docusign_password","docusign_userid","docusign_accountid","only_saml_user", "use_saml","saml_force_https" //add "only_saml_user", "use_saml","saml_force_https", modified by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
			//---------End Modfiied ------------------------------------------------------------------			
				ls_value = ids_icred_settings.getitemstring( 1 , as_columnname)		
			Case else
				ls_value = String(ids_icred_settings.getitemnumber( 1 , as_columnname))
		End Choose
		//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
		//Added By Ken.Guo 07/01/2013. workaround license bug for DM.
		If ls_value = '0' and as_columnname = 'set_51' Then 
			ls_value = '3'  //3: Buy, 0: N/A, 1: Buy/Sell
		End If
		//---------End Added ------------------------------------------------------
	Case 'ids'
		Choose Case Lower(as_columnname)//Modify Michael 02.08.2012 added "wv_meeting_link" V12.1 meeting
			Case "intelliapp_app_path","imaging_path","install_type","picture_path","print_space","database_backup_path","oig_url","citrix_npdb_path","contract_path","wv_meeting_link"
				ls_value = ids_ids.getitemstring( 1 , as_columnname)		
			Case "last_oig_update","last_update","lookup_cache","screen_cache","screen_obj_cache","last_query", "pp_date","pp_end" //add "pp_xxx" by alfee 04.10.2013
				ls_value = String(ids_ids.getitemdatetime( 1 , as_columnname))
			Case else
				ls_value = String(ids_ids.getitemnumber( 1 , as_columnname))
		End Choose
	//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
	Case 'em_user_config' //Added By Ken.Guo 2010-03-26.
		If ids_em_user_config.rowcount() = 0 Then Return ''
		Choose Case Lower(as_columnname)
			Case 'email_receive_start_date'
				ls_value = String(ids_em_user_config.GetItemDateTime(1,as_columnname),'yyyy-mm-dd')
			Case Else //'email_receive_by_date','email_receive_by_clx','email_receive_by_subject','email_receive_all','email_log','email_delete_from_server','email_timer','email_rule_type'
				ls_value = String(ids_em_user_config.GetItemNumber(1,as_columnname))
		End Choose
	Case 'dashboard_gadgets_getting_started'
		Choose Case Lower(as_columnname)
			Case 'display_columns'
				ls_value = String(ids_dashboard_getting_started.GetItemNumber(1,as_columnname))
			Case 'sort_result'
				ls_value = ids_dashboard_getting_started.GetItemString(1,as_columnname)
		End Choose
	//---------End Added ------------------------------------------------------------------

End Choose

return ls_value
end function

public function string of_getitem (string as_tablename, string as_columnname, string as_condition);//
string	ls_value
long		ll_findrow

//------------------------------------------------------------------------
// 2.23.2016 <RP> added
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN
	return ""
END IF
//------------------------------------------------------------------------

ls_value = "@#"

Choose Case as_tablename	
	Case 'security_users'
		ll_findrow = ids_security_users.find(as_condition , 1,  ids_security_users.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			  /*
				Case "user_id","user_password","email_id"
					ls_value = ids_security_users.getitemstring(ll_findrow,  as_columnname)
				//Case "default_search_facility","default_view","role_id","contract_default_view"	, "set_tdl","set_task",	"set_1","set_2","set_3","set_4"
				Case "default_search_facility","default_view","role_id","contract_default_view"	, "set_tdl","set_task",	"set_1","set_2","set_3","set_4", "lic_agr_img", "lic_agr_asa" //Alfee 07.14.2008
					ls_value = String(ids_security_users.getitemnumber( ll_findrow, as_columnname))	
			  */
			Case "user_id","user_password","email_id","req_expand_status"
				ls_value = ids_security_users.getitemstring(ll_findrow,  as_columnname)
			//Case "default_search_facility","default_view","role_id","contract_default_view"	, "set_tdl","set_task",	"set_1","set_2","set_3","set_4"
			Case "default_search_facility","default_view","role_id","contract_default_view"	, "set_tdl","set_task",	"set_1","set_2","set_3","set_4", "lic_agr_img", "lic_agr_asa","doc_auto_retrieve","contract_display_mode" //Alfee 07.14.2008
				ls_value = String(ids_security_users.getitemnumber( ll_findrow, as_columnname))
			Case Else //Added by Ken.guo 2011-07-04
				ls_value = String(ids_security_users.getitemnumber( ll_findrow, as_columnname))			  
			//---------End Modfiied ------------------------------------------------------------------			
		End Choose
	Case 'code_lookup'
		ll_findrow = ids_code_lookup.find(as_condition , 1,  ids_code_lookup.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 11.16.2006 By: Jervis
			//$<reason> 
			//Case "code","description","lookup_name","custom_1","custom_2","custom_6","custom_3"
			Case "lookup_name","code","description","type","custom_1","custom_2","custom_3","custom_4","custom_5","custom_6","ic_c","large_description_1","large_description_2"
			//---------------------------- APPEON END ----------------------------
				ls_value = ids_code_lookup.getitemstring(ll_findrow,  as_columnname)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 08.23.2006 By: Liang QingShi
			//$<reason> Contract module modification
			/*
			Case "lookup_code","caqh_code"
			*/
			case "lookup_code","caqh_code","ic_n","money_1","money_2","integer_1","integer_2","integer_3","integer_4","integer_5","integer_6","integer_7","integer_8"
			//---------------------------- APPEON END ----------------------------
				ls_value = String(ids_code_lookup.getitemnumber( ll_findrow, as_columnname))

			case "modify_date","datetime_1","datetime_2"
				ls_value = string(ids_code_lookup.getitemdatetime( ll_findrow, as_columnname))
		End Choose
//Start Code Change ----10.13.2011 #V12 maha - added		
	Case 'address_lookup'
		//messagebox("rowcount",ids_address_lookup.rowcount()) //Commented by (Appeon)Stephen 09.03.2014 
		ll_findrow = ids_address_lookup.find(as_condition , 1,  ids_address_lookup.rowcount())
		If ll_findrow <= 0 Then Return ""
		
		Choose Case Lower(as_columnname)
			Case "lookup_name","code","entity_name","street1","street2","city","state","zip","country","phone","fax","email_address","web_address","type","custom_1","custom_2","custom_3","custom_4","custom_5","custom_6","ic_c","large_description_1","large_description_2"
				ls_value = ids_address_lookup.getitemstring(ll_findrow,  as_columnname)			
			//Start Code Change ----11.01.2017 #V16 maha - additional fields for Cert periods
			Case "period_months", "cme_cat2_hours", "cme_total_hours",  "cme_cat1_hours", "cme_cat1a_hours", "cme_cat2a_hours", "cme_cat1b_hours",  "cme_cat2b_hours", "look_back_months", "renewal_years", "monitor_days", "cert_period_end",  "calc_cmes", "special_rules", "period_track", "calc_from", "carry_over_notes", "notes"
				ls_value = ids_address_lookup.getitemstring(ll_findrow,  as_columnname)
			
			case "lookup_code","caqh_code","ic_n","money_1","money_2","integer_1","integer_2","integer_3","integer_4","integer_5","integer_6","integer_7","integer_8", "fee"
				ls_value = String(ids_address_lookup.getitemnumber( ll_findrow, as_columnname))
			//End Code Change ----11.01.2017 
			case "modify_date","datetime_1","datetime_2"
				ls_value = string(ids_address_lookup.getitemdatetime( ll_findrow, as_columnname))
		End Choose
//End Code Change ----10.13.2011		
	Case 'sys_tables'
		ll_findrow = ids_systables.find(as_condition , 1,  ids_systables.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			//Case "table_name" 	
			Case "table_name", "table_name_allias" //alfee 01.21.2010
				ls_value = ids_systables.getitemstring(ll_findrow,  as_columnname)
			Case "table_id", "facility_specific"
				ls_value = String(ids_systables.getitemnumber( ll_findrow, as_columnname))
		End Choose		
	Case 'sys_fields'
		//---------Begin Added by (Appeon)Stephen 11.21.2016 for another of the same error messages--------
		ids_sys_fields.SetFilter( "1=1" )			
		ids_sys_fields.Filter( )
		ids_sys_fields.SetFilter( "" )		
		//---------End Added ------------------------------------------------------
		If il_ids_sys_fields_cnt <> ids_sys_fields.Rowcount()  or il_ids_sys_fields_cnt < 1  Then
			//---------Begin Commented by (Appeon)Stephen 11.21.2016 for another of the same error messages --------
			/*
			ids_sys_fields.SetFilter( "" )
			ids_sys_fields.Filter( )
			*/
			//---------End Commented ------------------------------------------------------
			of_retrieve_appeon('sys_fields') //(Appeon)Stephen 09.18.2016 - another of the same error messages
		End If
		
		ll_findrow = ids_sys_fields.find(as_condition , 1,  ids_sys_fields.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "field_name","lookup_field","field_type","lookup_type","lookup_field_name","lookup_field_name","audit_fld","table_name", "lookup_code" ////Start Code Change ----11.28.2012 #V12 maha - added lookup_code (lookup table name)
				ls_value = ids_sys_fields.getitemstring(ll_findrow,  as_columnname)
			Case "table_id","field_id"
				ls_value = String(ids_sys_fields.getitemnumber( ll_findrow, as_columnname))
		End Choose
	Case 'ctx_notification'
		ll_findrow = ids_ctx_notification.find(as_condition , 1,  ids_ctx_notification.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "alm_enabled", "alm_table", "alm_column"
				ls_value = ids_ctx_notification.getitemstring(ll_findrow,  as_columnname)
			Case "ctx_id"
				ls_value = String(ids_ctx_notification.getitemnumber( ll_findrow, as_columnname))
			//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			Case 'alm_date'
				ls_value = String(ids_ctx_notification.getItemdatetime( ll_findrow, as_columnname))			
			//---------End Added ------------------------------------------------------------------
		End Choose
	//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
	Case 'ctx_all_notification' //jervis 07.04.2011
		ll_findrow = ids_ctx_notification.find(as_condition , 1,  ids_ctx_notification.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "alm_enabled", "alm_table", "alm_column"
				ls_value = ids_ctx_notification.getitemstring(ll_findrow,  as_columnname)
			Case "ctx_id","level_id1","levle_id2","doc_id"
				ls_value = String(ids_ctx_notification.getitemnumber( ll_findrow, as_columnname))
			case 'alm_date'
				ls_value = String(ids_ctx_notification.getItemdatetime( ll_findrow, as_columnname))
		End Choose		
	//---------End Added ------------------------------------------------------------------

	//--------Begin Added by Alfee 02.26.2008 -------------------------	
	//<$Reason>For Date Alarm Enhancement
	Case 'ctx_ai_notification'
		ll_findrow = ids_ctx_ai_notification.find(as_condition , 1,  ids_ctx_ai_notification.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "alm_enabled", "alm_table", "alm_column"
				ls_value = ids_ctx_ai_notification.getitemstring(ll_findrow,  as_columnname)
			Case "ctx_id", "ctx_action_item_id"
				ls_value = String(ids_ctx_ai_notification.getitemnumber( ll_findrow, as_columnname))
			//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			case 'alm_date'
				ls_value = String(ids_ctx_notification.getItemdatetime( ll_findrow, as_columnname))						
			//---------End Added ------------------------------------------------------------------
		End Choose		
	Case 'ctx_am_ai_notification'
		ll_findrow = ids_ctx_am_ai_notification.find(as_condition , 1,  ids_ctx_am_ai_notification.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "alm_enabled", "alm_table", "alm_column"
				ls_value = ids_ctx_am_ai_notification.getitemstring(ll_findrow,  as_columnname)
			Case "doc_id", "seq_id"
				ls_value = String(ids_ctx_am_ai_notification.getitemnumber( ll_findrow, as_columnname))
			//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			case 'alm_date'
				ls_value = String(ids_ctx_notification.getItemdatetime( ll_findrow, as_columnname))			
			//---------End Added ------------------------------------------------------------------
		End Choose				
	//--------End Added ------------------------------------------------
	Case 'facility'
		ll_findrow = ids_facility.find(as_condition, 1,  ids_facility.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "facility_name","dept_chair_user_id","facility_wf_exp_appt"
				ls_value = ids_facility.getitemstring(ll_findrow,  as_columnname)
			Case "facility_id","facility_wf_data_entry_complete","facility_wf_expiring_appointment", &
				  "facility_wf_reappointment_initiated","facility_wf_practitioner_status_change",&
				  "facility_wf_new_practitioner","facility_wf_data_value_comparison",&
				  "facility_wf_webview_application_complete",&
				  "facility_central_cred","facility_reap_user","facility_miss_letter_90","default_oppe_process","default_fppe_process"
				ls_value = String(ids_facility.getitemnumber( ll_findrow, as_columnname))
		End Choose
	Case 'data_view_screen'
		ll_findrow = ids_data_view_screen.find(as_condition , 1,  ids_data_view_screen.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "//"
				ls_value = ids_data_view_screen.getitemstring(ll_findrow,  as_columnname)
			Case "reference_field_1","reference_field_2","table_id","data_view_id"
				ls_value = String(ids_data_view_screen.getitemnumber( ll_findrow, as_columnname))
		End Choose
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	Case 'image_type'
		ll_findrow = ids_image_type.find(as_condition, 1,  ids_image_type.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "de_queue"
				ls_value = string(ids_image_type.getitemnumber(ll_findrow,  as_columnname))
			Case "image_type_id"
				ls_value = string(ids_image_type.getitemnumber(ll_findrow,  as_columnname))
			Case "default_pages"
				ls_value = string(ids_image_type.getitemnumber(ll_findrow,  as_columnname))
		End Choose
	
	//---------------------------- APPEON END ----------------------------
	
	//Added for work flow. 6/11/2006 Henry
	Case 'wf_workflow'
		ll_findrow = ids_workflow.find(as_condition, 1,  ids_workflow.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
			  /*
				Case "wf_id"	
			  */
			 Case "wf_id","suppress_alert"
			//---------End Modfiied ------------------------------------------------------------------			
				ls_value = string(ids_workflow.getitemnumber(ll_findrow,  as_columnname))
			Case "wf_name","wf_prompt_falg","wf_prompt_message","wf_module","wf_triggered_by","practitioner_falg","comparison_type","wf_status"
				ls_value = ids_workflow.getitemstring(ll_findrow,  as_columnname)
		End Choose
		
	Case 'wf_action_types'
		ll_findrow = ids_workflow_action.find(as_condition, 1,  ids_workflow_action.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "step_order","due_days","action_type_id","mail_notify"
				ls_value = string(ids_workflow_action.getitemnumber(ll_findrow,  as_columnname))
			Case "create_user_flag","by_user","weekend_flag","to_user","dept_chair_flag","cc_user","send_to_user"
				ls_value = ids_workflow_action.getitemstring(ll_findrow,  as_columnname)
		End Choose
	
	Case 'wf_action_status'
		ll_findrow = ids_workflow_status.find(as_condition, 1,  ids_workflow_status.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "status_id","action_status_id" ,"mail_notify","mail_reminder","days_reminder","days_every","send_count","mail_message","letter_id","process_flag"	//2006-11-15 add "letter_id" by jervis
				ls_value = string(ids_workflow_status.getitemnumber(ll_findrow,  as_columnname))
			Case "cc_notify_user","include_note_flag","cc_reminder_user","to_reminder_user","to_message_user","cc_message_user","to_notify_user"
				ls_value = ids_workflow_status.getitemstring(ll_findrow,  as_columnname)
		End Choose
	
	Case 'ctx_screen'
		If not isvalid(ids_screen_table_c) Then
			ids_screen_table_c = create datastore
			ids_screen_table_c.dataobject = 'd_screen_table_name_c'
			ids_screen_table_c.settransobject(SQLCA)
			ids_screen_table_c.retrieve( )
		End If
		
		ll_findrow = ids_screen_table_c.find(as_condition, 1,  ids_screen_table_c.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "screen_id"
				ls_value = string(ids_screen_table_c.getitemnumber(ll_findrow,  as_columnname))
		End Choose
		
	//End added for work flow
	
	//Added 11.30.2006 henry
	Case 'code_lookup_2'
		ll_findrow = ids_code_lookup_date.find(as_condition, 1,  ids_code_lookup_date.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "modify_date"
				ls_value = string(ids_code_lookup_date.getitemdatetime(ll_findrow,  as_columnname))
		End Choose
		
	//Start Code Change ----07.30.2010 #V10 maha
	Case "app_steps"
		long ll_type
		integer i
		integer li_step
		string ls_field
		
		ls_value = "0"
		if as_columnname = "find step" then
			ll_type = long(as_condition)
			
			for i = 1 to ids_app_step_cache.getitemnumber(1,"final_step") 
				ls_field = "step_" + string(i) + "_type"
				if ids_app_step_cache.getitemnumber(1,ls_field) = ll_type then
					ls_value = string(i)
					exit
				end if
			next
			return ls_value
		//Start Code Change ----04.09.2012 #V12 maha	- find the name of the field for the action type
		elseif as_columnname = "find step field" then
			ll_type = long(as_condition)
			
			for i = 1 to ids_app_step_cache.getitemnumber(1,"final_step") 
				ls_field = "step_" + string(i) + "_type"
				if ids_app_step_cache.getitemnumber(1,ls_field) = ll_type then
					ls_value = "step_" + string(i)   // the name of the app tracking field
					exit
				end if
			next
			return ls_value
		//End Code Change ----04.09.2012	
		
		elseif as_columnname = "next step" then //as_condition is the current step number
			if ids_app_step_cache.getitemnumber(1,"final_step") = integer(as_condition) then			//if highest step return
				return "F"	//Start Code Change ----06.20.2012 #V12 maha - changed from 0
			else
				li_step =  integer(as_condition) + 1
				ls_field = "step_" + string(li_step) + "_type"
				ll_type =  ids_app_step_cache.getitemnumber(1,ls_field)
				ls_value = string(ll_type)
			end if

		elseif as_columnname = "next days" then
			//ls_value = of_getitem("code_lookup", "cust_3",as_condition )
			ls_value = of_getitem("code_lookup", "custom_2",as_condition )  //Start Code Change ----10.07.2011 #V12 maha - corrected from cust_3
			return ls_value
		elseif as_columnname = "last step" then //Start Code Change ----08.05.2010 #V10 maha
			ls_value = string(ids_app_step_cache.getitemnumber(1,"final_step"))
		elseif as_columnname = "auto_gen_next_step" then //Start Code Change ----08.12.2011 #V11 maha
			ls_value = string(ids_app_step_cache.getitemnumber(1,"auto_gen_next_step"))

		end if
		//ls_value
	//End Code Change ----07.30.2010 
	
	//Start Code Change ----06.27.2011 #V11 maha - process steps
	Case "process_steps"
		long res
		long ll_pos
		integer rc
		string	ls_temp
		string ls_step
		integer li_find
		
		if as_columnname = "next_step" then
			//debugbreak()
			//1*234   ---temp_id * item_id
			//filter for the template
			ll_pos = pos(as_condition,"*",1)
			ls_temp = "temp_id = " + mid(as_condition,1 , ll_pos - 1)
			res = ids_process_step_cache.setfilter(ls_temp )
			if res < 0 then
				messagebox("of_getitem",  "Filter failed for process steps")
				return "0"
			else
				ids_process_step_cache.filter()
				ids_process_step_cache.sort() //resort the steps
				rc = ids_process_step_cache.rowcount()
				if rc = 0 then return "0"
			end if
		
			ls_step = mid(as_condition,ll_pos + 1)  
			if ls_step = "0" then //first step added
				ls_value = string(ids_process_step_cache.getitemnumber(1,"item_id")) + "*"
				if isnull(ids_process_step_cache.getitemnumber(1 ,"auto_complete")) then
					ls_value = ls_value + "0" 
				else
					ls_value = ls_value + string(ids_process_step_cache.getitemnumber(1 ,"auto_complete")) 
				end if
			else
				li_find = ids_process_step_cache.find("item_id = " + ls_step,1,1000)
				if li_find > 0 then
					if li_find = rc then //if last step
						return "0"
					else //get next step - 2 field values
						li_find++
						//field 1 - id
						ls_value = string(ids_process_step_cache.getitemnumber(li_find ,"item_id")) + "*"
						//field 2 - auto
						if isnull(ids_process_step_cache.getitemnumber(li_find ,"auto_complete")) then
							ls_value = ls_value + "0" 
						else
							ls_value = ls_value + string(ids_process_step_cache.getitemnumber(li_find ,"auto_complete")) 
						end if
					end if
				else //find not greater than 0
					return "0"
				end if
			end if
			return ls_value
			//return value  235*0
			ids_process_step_cache.setfilter("" ) //clear filter
			ids_process_step_cache.filter()
		else //column values - any other as_columnname
			//condition should be: item_id = ###
			li_find = ids_process_step_cache.find(as_condition,1,10000 )
			if li_find > 0 then
				choose case as_columnname
					case "due_days" , "auto_complete" ,"process_type","document_id"
						ls_value =  string( ids_process_step_cache.getitemnumber( li_find, as_columnname ))
					case "item_name"
						ls_value =  ids_process_step_cache.getitemstring( li_find, as_columnname )
				end choose
			end if
		end if
	//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
	//Added By Ken.Guo 2009-07-10.
	Case 'data_view'
		ll_findrow = ids_data_view.find(as_condition, 1,  ids_data_view.rowcount())
		If ll_findrow <= 0 Then Return ""
		Choose Case Lower(as_columnname)
			Case 'win_backcolor'
				ls_value = string(ids_data_view.getitemnumber(ll_findrow,  as_columnname))
			Case 'data_view_name'
				ls_value = ids_data_view.getitemstring(ll_findrow,  as_columnname)
		End Choose
	
	case 'ctx_facility'	// Add by jervis 12.10.2009
		ll_findrow = ids_ctx_facility.find(as_condition, 1,  ids_ctx_facility.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "facility_name"
				ls_value = ids_ctx_facility.getitemstring(ll_findrow,  as_columnname)
			Case "facility_id"
				ls_value = String(ids_ctx_facility.getitemnumber( ll_findrow, as_columnname))
		End Choose
		
	case 'clause' //Added By Ken.Guo 2011-05-03.
		ll_findrow = ids_clause.find(as_condition, 1,  ids_clause.rowcount())
		If ll_findrow <= 0 Then Return ""

		Choose Case Lower(as_columnname)
			Case "revision"
				ls_value = String(ids_clause.getitemdecimal(ll_findrow,  as_columnname))
			Case "clause_name"
				ls_value = ids_clause.getitemstring( ll_findrow, as_columnname)
		End Choose			
	//---------End Added ------------------------------------------------------------------		
End Choose

If ls_value = "@#" Then
//	debugbreak()
	If Handle(GetApplication()) = 0 Then
		//Messagebox("appeon","Invoke GlobalData function error!"+&
		Messagebox("Appeon","Invoke GlobalData function error!"+&
		"~r~ntablename:" + as_tablename +&
		"~r~ncolumnname:"+ as_columnname +&
		"~r~nconditione:"+ as_condition )
	End If
	
	Return ""
End If
//messagebox( as_columnname ,ls_value)
return ls_value
end function

public subroutine of_initdatacache ();
////
//ids_views.dataobject = 'd_dddw_select_view_with_user_param'
//ids_views.settransobject(SQLCA)
//
//ids_facilitys.dataobject = 'd_dddw_facility_w_picture'
//ids_facilitys.settransobject(sqlca)
//
//ids_views.retrieve(gs_user_id)
//ids_facilitys.retrieve(gs_user_id)
end subroutine

public subroutine of_init_table_reccount (long al_tableids[]);string  ls_tablename
long	  ll_reccount[] , ll_i , ll_tableid

For ll_i = 1 To upperbound(al_tableids)
	ll_tableid = al_tableids[ll_i]
	If ll_tableid <> 0 Then
		ls_tablename = gnv_data.of_getitem('sys_tables' , 'table_name' , 'table_id=' + string(ll_tableid))

	End If
Next


end subroutine

public subroutine of_set_dwchild_fromcache (string as_table_name, string as_condition, datawindowchild a_dwchild);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10/09/2007 By: Ken.Guo
//$<reason> For Performance,  Use Find replace SetFilter
/*
Choose Case as_table_name
	Case 'code_lookup'
		If len(as_condition) > 0 Then
			ids_code_lookup.setfilter(as_condition)
			ids_code_lookup.filter()
		End If
		IF a_dwchild.RowCount() > 0 THEN a_dwchild.ReSet()
		ids_code_lookup.rowscopy(1,ids_code_lookup.rowcount(),Primary! , a_dwchild , 1,Primary!)
		ids_code_lookup.setfilter("")
		ids_code_lookup.filter()
End Choose
*/

//------------------------------------------------------------------------
// 2.23.2016 <RP> added
IF of_retrieveIfNecessary(as_table_name, FALSE) = -1 THEN
	return
END IF
//------------------------------------------------------------------------

//Warning!!! Don't modify ids_code_lookup's Sort and Group Setting.
//Because below script base on it.
Long ll_start,ll_End,ll_findrow,ll_rowcount
Choose Case as_table_name
	Case 'code_lookup'
		IF a_dwchild.RowCount() > 0 THEN a_dwchild.ReSet()
		If LenA(as_condition) = 0 Then
			ids_code_lookup.rowscopy(1,ids_code_lookup.rowcount(),Primary! , a_dwchild , 1,Primary!)			
			Return
		End If
		ll_rowcount = ids_code_lookup.rowcount()
		ll_start = ids_code_lookup.find(as_condition,1,ll_rowcount)
		If ll_start > 0 Then
			ll_end = ids_code_lookup.GetItemNumber(ll_start,'group_count')
			ll_end = ll_start + ll_end - 1
			ids_code_lookup.rowscopy(ll_start,ll_end,Primary! , a_dwchild , 1,Primary!)
		End If
	Case 'question_lookup'
		IF a_dwchild.RowCount() > 0 THEN a_dwchild.ReSet()
		ids_question_lookup.rowscopy(1,ids_question_lookup.rowcount(),Primary! , a_dwchild , 1,Primary!)							
End Choose
//---------------------------- APPEON END ----------------------------
end subroutine

public subroutine of_get_data_from_cache (string as_table_name, string as_condition, datastore a_dwchild);//---------------2.25.2016 <RP> added for just-in-time caching----------------------------------
//IF of_initCache(as_table_name) = -1 THEN
IF of_retrieveIfNecessary(as_table_name, FALSE) = -1 THEN //Modified to of_retrieveIfNecessary by Appeon long.zhang 03.18.2016 (for performance changes bug)
	/* Invalid cache name */
	return
END IF
//-----------------------------------------------------------------------------------------------

Choose Case as_table_name
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 12.13.2006 By: Jervis
	//$<reason> 
	/*
	Case 'sys_fields'
		ids_sys_fields.rowscopy(1,ids_sys_fields.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If len(as_condition) > 0 Then
			a_dwchild.setfilter(as_condition)
			a_dwchild.filter()
		End If
	
	//Added for work flow. 6/11/2006 Henry
	Case 'wf_action_types'
		ids_workflow_action.rowscopy(1,ids_workflow_action.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If len(as_condition) > 0 Then
			a_dwchild.setfilter(as_condition)
			a_dwchild.filter()
		End If
	Case 'wf_action_status'
		ids_workflow_status.rowscopy(1,ids_workflow_status.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If len(as_condition) > 0 Then
			a_dwchild.setfilter(as_condition)
			a_dwchild.filter()
		End If
	Case 'wf_trigger_param_action_status'
		ids_workflow_trigger_item.rowscopy(1,ids_workflow_trigger_item.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If len(as_condition) > 0 Then
			a_dwchild.setfilter(as_condition)
			a_dwchild.filter()
		End If
	Case 'wf_trigger_param_data_comparison'
		ids_workflow_trigger_comp.rowscopy(1,ids_workflow_trigger_comp.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If len(as_condition) > 0 Then
			a_dwchild.setfilter(as_condition)
			a_dwchild.filter()
		End If
	//End added for work flow 
	*/
	Case 'sys_fields'
		if LenA(as_condition) > 0 then
			ids_sys_fields.SetFilter( as_condition)
			ids_sys_fields.Filter()
		end if
		ids_sys_fields.rowscopy(1,ids_sys_fields.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if LenA(as_condition) > 0 then
			ids_sys_fields.SetFilter( '')
			ids_sys_fields.Filter()
		end if
	Case 'wf_action_types'
		if LenA(as_condition) > 0 then
			ids_workflow_action.SetFilter( as_condition)
			ids_workflow_action.Filter()
		end if
		ids_workflow_action.rowscopy(1,ids_workflow_action.rowcount(),Primary! , a_dwchild , 1,Primary!)
		If LenA(as_condition) > 0 Then
			ids_workflow_action.setfilter('')
			ids_workflow_action.filter()
		End If
	Case 'wf_action_status'
		if LenA(as_condition) > 0 then
			ids_workflow_status.SetFilter( as_condition)
			ids_workflow_status.Filter()
		end if
		ids_workflow_status.rowscopy(1,ids_workflow_status.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if LenA(as_condition) > 0 then
			ids_workflow_status.SetFilter( '')
			ids_workflow_status.Filter()
		end if
	Case 'wf_trigger_param_action_status'
		if LenA(as_condition) > 0 then
			ids_workflow_trigger_item.SetFilter( as_condition)
			ids_workflow_trigger_item.Filter()
		end if
		ids_workflow_trigger_item.rowscopy(1,ids_workflow_trigger_item.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if LenA(as_condition) > 0 then
			ids_workflow_trigger_item.SetFilter( '')
			ids_workflow_trigger_item.Filter()
		end if
	Case 'wf_trigger_param_data_comparison'
		if LenA(as_condition) > 0 then
			ids_workflow_trigger_comp.SetFilter( as_condition)
			ids_workflow_trigger_comp.Filter()
		end if
		ids_workflow_trigger_comp.rowscopy(1,ids_workflow_trigger_comp.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if LenA(as_condition) > 0 then
			ids_workflow_trigger_comp.SetFilter( '')
			ids_workflow_trigger_comp.Filter()
		end if
	Case 'template_clause_rules' //Added by Alfee 11.12.2007
		if LenA(as_condition) > 0 then
			ids_template_clause_rules.SetFilter( as_condition)
			ids_template_clause_rules.Filter()
		end if
		ids_template_clause_rules.rowscopy(1,ids_template_clause_rules.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if LenA(as_condition) > 0 then
			ids_template_clause_rules.SetFilter( '')
			ids_template_clause_rules.Filter()
		end if				
	//---------------------------- APPEON END ----------------------------
	//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
	Case 'wf_workflow' //Added By Ken.Guo 12/24/2012
		if lenA(as_condition) > 0 then
			ids_workflow.SetFilter( as_condition)
			ids_workflow.Filter()
		end if
		ids_workflow.rowscopy(1,ids_workflow.rowcount(),Primary! , a_dwchild , 1,Primary!)
		if lenA(as_condition) > 0 then
			ids_workflow.SetFilter( '')
			ids_workflow.Filter()
		end if			
	//---------End Added ------------------------------------------------------------------

End Choose



end subroutine

public function long of_findrow (string as_tablename, string as_condition);//---------------2.25.2016 <RP> added for just-in-time caching----------------------------------
//IF of_initCache(as_tablename) = -1 THEN
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN //Modified to of_retrieveIfNecessary by Appeon long.zhang 03.18.2016 (for performance changes bug)
	/* Invalid cache name */
	return 0
END IF
//-----------------------------------------------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.10.2006 By: Jervis
//$<reason> Finds the row in a DataStore in which data meets a specified condition.
choose case lower(as_tablename)
	Case 'wf_workflow'
		return ids_workflow.find(as_condition, 1,  ids_workflow.rowcount())
	Case 'wf_action_types'
		return ids_workflow_action.find(as_condition, 1,  ids_workflow_action.rowcount())
	Case 'wf_action_status'
		return ids_workflow_status.find(as_condition, 1,  ids_workflow_status.rowcount())
	Case 'wf_trigger_param_data_comparison'
		return ids_workflow_trigger_comp.find(as_condition, 1,  ids_workflow_trigger_comp.rowcount())
	Case 'template_clause_rules' //Added by Alfee 11.12.2007
		return ids_template_clause_rules.find(as_condition, 1,  ids_template_clause_rules.rowcount())		
end choose
//---------------------------- APPEON END ----------------------------

end function

public function string of_getitem (string as_tablename, long al_row, string as_columnname);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.10.2006 By: Jervis
//$<reason> modify for workfow 
string	ls_value

ls_value = "@#"

if al_row <=0 then return ""

//------------------------------------------------------------------------
// 2.23.2016 <RP> added
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN
	return ""
END IF
//------------------------------------------------------------------------

Choose Case as_tablename	
	Case 'wf_workflow'
		Choose Case Lower(as_columnname)
			Case "wf_id"
				ls_value = string(ids_workflow.getitemnumber(al_row,  as_columnname))
			Case "wf_name","wf_prompt_falg","wf_prompt_message","wf_module","wf_triggered_by","practitioner_falg","comparison_type","wf_status"
				ls_value = ids_workflow.getitemstring(al_row,  as_columnname)
		End Choose
		
	Case 'wf_action_types'
		Choose Case Lower(as_columnname)
			Case "step_order","due_days","action_type_id","mail_notify"
				ls_value = string(ids_workflow_action.getitemnumber(al_row,  as_columnname))
			Case "create_user_flag","by_user","weekend_flag","to_user","dept_chair_flag","cc_user","send_to_user"
				ls_value = ids_workflow_action.getitemstring(al_row,  as_columnname)
		End Choose
	
	Case 'wf_action_status'
		Choose Case Lower(as_columnname)
			Case "status_id","action_status_id" ,"mail_notify","mail_reminder","days_reminder","days_every","send_count","mail_message","letter_id","process_flag"	//2006-11-15 add "letter_id" by jervis
				ls_value = string(ids_workflow_status.getitemnumber(al_row,  as_columnname))
			Case "cc_notify_user","include_note_flag","cc_reminder_user","to_reminder_user","to_message_user","cc_message_user","to_notify_user", "action_status_desc" //(Appeon)Harry 09.22.2014 - add "action_status_desc"
				ls_value = ids_workflow_status.getitemstring(al_row,  as_columnname)
		End Choose
	Case 'wf_trigger_param_data_comparison'
		Choose Case Lower(as_columnname)
			Case "screen_id"
				ls_value = string(ids_workflow_trigger_comp.getitemnumber(al_row,  as_columnname))
			case "table_name","field_name","operator","value","field_type"
				ls_value = ids_workflow_trigger_comp.getitemstring(al_row,  as_columnname)
		End Choose
End Choose

If ls_value = "@#" Then
	If Handle(GetApplication()) = 0 Then
		//Messagebox("appeon","Invoke GlobalData function error!"+&
		Messagebox("Appeon","Invoke GlobalData function error!"+&
		"~r~ntablename:" + as_tablename +&
		"~r~nrow:"+ string(al_row) +&
		"~r~ncolumnname:"+ as_columnname)
	End If
	
	Return ""
End If

return ls_value

//---------------------------- APPEON END ----------------------------
end function

public function string of_get_table_name (integer al_screen, string as_module, string as_column);
String ls_tablename
long	 ll_find

Choose Case as_module
	Case 'P'
		If not isvalid(ids_screen_table_p) Then
			ids_screen_table_p = create datastore
			ids_screen_table_p.dataobject = 'd_screen_table_name_p'
			ids_screen_table_p.settransobject(SQLCA)
			ids_screen_table_p.retrieve( )
		End If
		
		ll_find = ids_screen_table_p.find( "data_view_screen_screen_id="+string(al_screen), 1 , ids_screen_table_p.RowCount())
		If not ll_find > 0 Then return ''
		
		ls_tablename = ids_screen_table_p.GetItemString(ll_find , as_column)
		If MidA(ls_tablename, 1, 4) = 'dba.' Then ls_tablename = MidA(ls_tablename , 5)
	Case 'C'
		If not isvalid(ids_screen_table_c) Then
			ids_screen_table_c = create datastore
			ids_screen_table_c.dataobject = 'd_screen_table_name_c'
			ids_screen_table_c.settransobject(SQLCA)
			ids_screen_table_c.retrieve( )
		End If
		
		ll_find = ids_screen_table_c.find( "screen_id="+string(al_screen), 1 , ids_screen_table_c.RowCount())
		If not ll_find > 0 Then return ''
		//---------Begin Modified by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------		
		  /*
			ls_tablename = ids_screen_table_c.GetItemString(ll_find , as_column)	
		  */
		//Modified By Ken.Guo 03/26/2012
		//ls_tablename = ids_screen_table_c.GetItemString(ll_find , as_column)
		If as_column = 'dataobject' Then
			If ids_screen_table_c.GetItemString(ll_find,'screen_style') = 'G' Then
				ls_tablename = ids_screen_table_c.GetItemString(ll_find , 'grid_dataobject')
			Else
				ls_tablename = ids_screen_table_c.GetItemString(ll_find , as_column)
			End If
		Else
			ls_tablename = ids_screen_table_c.GetItemString(ll_find , as_column)
		End If
		//---------End Modfiied ------------------------------------------------------------------
End Choose

return ls_tablename
end function

public function string of_get_filter_data (string as_tablename, string as_condition, string as_name);long ll_i,ll_count
string ls_filter

//---------------2.25.2016 <RP> added for just-in-time caching----------------------------------
//IF of_initCache(as_tablename) = -1 THEN
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN //Modified to of_retrieveIfNecessary by Appeon long.zhang 03.18.2016 (for performance changes bug)
	/* Invalid cache name */
	return ""
END IF
//-----------------------------------------------------------------------------------------------

choose case as_tablename
	case "workflow_status_filter"
		ids_workflow_status_filter.Setfilter(as_condition)
		ids_workflow_status_filter.Filter()
		
		ll_count = ids_workflow_status_filter.Rowcount()
		
		for ll_i = 1 to ll_count
			if ll_i = 1 then
				ls_filter = "(" + as_name + " = " + string(ids_workflow_status_filter.GetItemNumber(ll_i,"action_status_id"))
			else
				ls_filter += " or " + as_name + " = " + string(ids_workflow_status_filter.GetItemNumber(ll_i,"action_status_id"))
			end if
		next
		if ls_filter <> "" then ls_filter += ")"
end choose
return ls_filter 
end function

public function string of_get_sys_field_value (string as_table, string as_field, string as_get_field);//Start Code Change ----04.14.2009 #V92 maha - fucntion added
//lookup_field, field_type, lookup_type, lookup_field_name, lookup_code
long ll_find
long ll_find2
long rc
string ls_return = ''
string ls_find
string ls_find2
string ls_table

//---------------2.25.2016 <RP> added for just-in-time caching----------------------------------
//IF of_initCache("sys_fields") = -1 THEN
IF of_retrieveIfNecessary("sys_fields", FALSE) = -1 THEN //Modified to of_retrieveIfNecessary by Appeon long.zhang 03.18.2016 (for performance changes bug)
	/* Error */
	return ""
END IF
//-----------------------------------------------------------------------------------------------

ls_table = as_table

//debugbreak()
if ids_sys_fields.filteredcount() > 0 then //filtered by field audit - alfee 12.18.2009
	ids_sys_fields.setfilter("")
	ids_sys_fields.filter()
end if

ls_find = "upper(sys_tables_table_name) = '" + upper(ls_table) + "' and upper(field_name) = '" + upper(as_field) + "'"
ls_find2 = "upper(sys_tables_table_name) = 'DBA." + upper(ls_table) + "' and upper(field_name) = '" + upper(as_field) + "'"

rc = ids_sys_fields.rowcount()
ll_find = ids_sys_fields.find( ls_find, 1, rc)


if ll_find = 0 then
	ll_find2 =  ids_sys_fields.find( ls_find2, 1, rc)
	//messagebox(string(ll_find2),ls_find2)
	if ll_find2 > 0 then
		ls_return = ids_sys_fields.getitemstring(ll_find2,as_get_field)
	end if
elseif ll_find > 0 then
	ls_return = ids_sys_fields.getitemstring(ll_find,as_get_field)
end if



return ls_return
end function

public function long of_retrieve (string as_cachename);//
//	2.22.2016	<RP>		Copied previous version of this function and saved as of_retrieve_appeon()
//							Cleaned up and rebuilt in place
//
//	2.25.2016	<RP>		Re-route to of_retrieveIfNecessary()
//
return of_retrieveIfNecessary(as_cachename, TRUE)

//string ls_sql
//long ll_ret
//datastore lds_cache
//string ls_dataobject
//
//if isvalid(w_open_message) then w_open_message.st_2.text = as_cachename //Start Code Change ----04.04.2013 #V12 maha
//
//IF of_getCache(as_cachename, lds_cache, ls_dataobject) = -1 THEN
//	return -1
//END IF
//
//IF as_cachename = 'wf_action_status' THEN
//	/* Need additional cache */
//	IF of_retrieve("workflow_status_filter") = -1 THEN
//		return -1
//	END IF
//END IF
//
//lds_cache.dataobject = ls_dataobject
//lds_cache.Settransobject(SQLCA)
//
//Choose case as_cachename
//	case 'em_user_msg', 'em_user_config', 'dashboard_getting_started'
//		ll_ret = lds_cache.Retrieve(gs_user_id)
//	CASE ELSE
//		ll_ret = lds_cache.retrieve()
//END CHOOSE
//
//Choose case as_cachename
//	Case 'sys_fields'
//		il_ids_sys_fields_cnt = ll_ret
//	Case "app_steps" //maha 07.30.2010 - application ateps
//		if appeongetclienttype() = 'PB' and lds_cache.rowcount() < 1 then
//			messagebox("Cache setup","Appl process steps cache failed")
//		end if
//End Choose
//
//Return ll_ret
//
end function

public function integer of_get_defaultdddwcache ();//====================================================================
//$<Function>: of_get_defaultdddwcache
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Toney 06.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Other Lookup caches
int li_use_opmode

IF NOT gb_contract_module THEN RETURN 0  //(Appeon)Alfee 06.20.2013 - V141 ISG-CLX

//---------------------------<RP> 3.1.2016 benchmark tests-----------------------------------------
gnv_app.of_benchmark("of_get_defaultdddwcache(): Before gnv_app.of_setcontraccache_register()")

gnv_app.of_setcontraccache_register( )

//gnv_app.of_benchmark("Label B")

gnv_app.of_benchmark("of_get_defaultdddwcache(): Before gnv_app.of_setcontraccache_code_lookup()")

gnv_app.of_setcontraccache_code_lookup(True)

//gnv_app.of_benchmark("Label C")
gnv_app.of_benchmark("of_get_defaultdddwcache(): Before gnv_app.of_set_contract_path()")
gnv_app.of_set_contract_path( )

//gnv_app.of_benchmark("Label D")

//------------------------------------ <RP> 3.3.2016--------------------------------------
// Use cache rather than direct select
//select use_opsyntax into :li_use_opmode from icred_settings;
li_use_opmode = Integer(of_getItem("icred_settings", "use_opsyntax", FALSE))
//----------------------------------------------------------------------------------------

if li_use_opmode = 1 then
	//---------Begin Modified by (Appeon)Alfee 07.15.2013 for V141 ISG-CLX--------
	if isvalid(w_open_message) then w_open_message.st_2.text = "CTX Lookup data" 
	//If Not isvalid(w_appeon_gifofwait) Then
	//	OpenWithParm(w_appeon_gifofwait,"Getting lookup data caches, Please wait...")// this may take a few minutes.  modify by gavin 2012-01-10		
	//Else
	//	w_appeon_gifofwait.of_settext("Getting lookup data caches, Please wait...")//this may take a few minutes. 
	//End If
	//---------End Modfiied ----------------------------------------------------------------	
	datastore lds_cache
	long ll_i,ll_count
	string ls_name
	lds_cache = create datastore
	lds_cache.dataobject = 'd_get_cachelist'
	lds_cache.SetTransobject( sqlca)
	ll_count = lds_cache.retrieve( )
	for ll_i = 1 to ll_count
		ls_name = lds_cache.GetItemString( ll_i,'lookup_list')
		if ls_name='?' or ls_name = '' or isnull(ls_name) then continue
		if gnv_app.inv_dwcache.of_isregistered(ls_name) = 1 then continue
		gnv_app.of_setcontraccache_code_lookup( ls_name)
	next
	destroy lds_cache
end if
//If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)  //close it after all event/function done.

gnv_app.of_benchmark("of_get_defaultdddwcache(): Return")

Return 1

end function

public function integer of_insert_main_data (datawindow adw_main, datawindow adw_detail, string as_main_table_name, long al_main_currentrow, long al_detail_currentrow);//====================================================================
// Function: of_insert_main_data
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                adw_main
//                adw_detail
//                as_main_table_name
//                al_main_currentrow
//                al_detail_currentrow
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/27/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.06.2013 - V141 ISG-CLX
//====================================================================
String 	ls_tmp,  ls_main_table,  ls_detail_table, ls_sql
Long 		ll_pos, ll_tmp, ll_col_cnt,  i 
n_cst_string 			lnv_cst_string 
String 	ls_detail_col, ls_main_col , ls_coltype


If isnull(as_main_table_name) Or trim(as_main_table_name) = '' Then
	Return 0
Else
	ls_main_table = lower(Trim(as_main_table_name)) + '_'
End If

ll_col_cnt =  Long(adw_detail.Describe("DataWindow.Column.Count"))
For i = 1 to ll_col_cnt 
	ls_detail_col = adw_detail.Describe("#"+String(i) + ".name")
	If Pos(lower(ls_detail_col), lower(ls_main_table)) > 0 then 
		ls_main_col = lnv_cst_string.of_globalreplace(ls_detail_col,ls_main_table,'',True)
		ls_coltype = adw_main.Describe(ls_main_col+".ColType")
		
		Choose Case Lower(Left ( ls_ColType , 3 ))
			CASE 'int','num','lon','ulo'
				adw_detail.SetItem(al_detail_currentrow,ls_detail_col,adw_main.GetItemNumber(al_main_currentrow,ls_main_col))
			Case 'dou','rea', 'dec', 'mon'
				adw_detail.SetItem(al_detail_currentrow,ls_detail_col,adw_main.GetItemDecimal (al_main_currentrow,ls_main_col))
			CASE 'dat'	
				If ls_ColType = 'date' Then
					adw_detail.SetItem(al_detail_currentrow,ls_detail_col,adw_main.GetItemDate(al_main_currentrow,ls_main_col))					
				ElseIf ls_ColType = 'datetime' Then 
					adw_detail.SetItem(al_detail_currentrow,ls_detail_col,adw_main.GetItemDateTime(al_main_currentrow,ls_main_col))				
				End If
			CASE 'var','cha'				
				adw_detail.SetItem(al_detail_currentrow,ls_detail_col,adw_main.GetItemString(al_main_currentrow,ls_main_col))
			Case Else
				//
		End Choose 

	End If
Next 

Return 1
end function

public subroutine of_refresh_all_data ();//====================================================================
//$<Function>: of_refresh_all_data
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Refresh System Cache Data
of_refresh_systemdatacache( )

//Refresh DDDW
Long ll_cnt,i
String ls_cachelist[]
If Not isvalid(w_appeon_gifofwait) Then
	OpenWithParm(w_appeon_gifofwait,"Refreshing lookup data caches, Please wait...")// this may take a few minutes.  modify by gavin 2012-01-10
Else
	w_appeon_gifofwait.of_settext("Refreshing lookup data caches, Please wait...")//this may take a few minutes.
End If
gnv_app.inv_dwcache.of_getregistered(ls_cachelist[])
ll_cnt = UpperBound(ls_cachelist[]) 
For i = 1 to ll_cnt
	If gnv_string.of_isexists(gnv_app.is_lookupnamelist[],lower(ls_cachelist[i])) Then
		gnv_app.of_setcontraccache_code_lookup( ls_cachelist[i])
	End If
Next


If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)



end subroutine

public subroutine of_refresh_systemdatacache ();//====================================================================
//$<Function>: of_refresh_systemdatacache
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Reconstructed by (Appeon) Alfee 06.20.2013
//====================================================================
//Getting data caches - jervis 10.25.2011

gnv_appeondb.of_startqueue() 

//General Data
of_retrieve('icred_settings') //cache data for icred_settings table
of_retrieve('security_users') //cache data for security_users table
of_retrieve('ids') //cache data for ids table
of_retrieve('sys_tables') //cache data for sys_tables table
of_retrieve('code_lookup') //cache data for code_lookup table
of_retrieve('sys_fields') //cache data for sys_fields and sys_tables table
of_retrieve('facility') //cache data for facility table
of_retrieve('data_view_screen') //cache data for data_view_screen table
of_retrieve('image_type') //cache data for image_type table	
of_retrieve('code_lookup_2') 
of_retrieve('wf_workflow')
of_retrieve('wf_action_types')
of_retrieve('wf_action_status')
of_retrieve('wf_trigger_param_data_comparison')
of_retrieve('wf_trigger_param_action_status')
of_retrieve('question_lookup') //cache data for question_lookup table - Added by Alan 08.20.2008
of_retrieve('data_view') //Added By Ken.Guo 2009-07-10.
of_retrieve( 'em_user_msg')//Added By Ken.Guo 2010-03-26.
of_retrieve( 'em_user_config') //Added By Ken.Guo 2010-03-26.
of_retrieve( 'dashboard_getting_started')
//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
of_retrieve( 'ctx_pictures') //Added By Ken.Guo 03/28/2013
//---------End Added ------------------------------------------------------

//Contract Data
IF gb_contract_module THEN
	of_retrieve('ctx_notification') //cache data for ctx_notification table
	of_retrieve('ctx_all_notification') //cache data for ctx_all_notification table - jervis 07.04.2011
	of_retrieve('ctx_ai_notification') //cache data for ctx_ai_notification table - Alfee 02.26.2008
	of_retrieve('ctx_am_ai_notification') //cache data for ctx_am_ai_notification table - Alfee 02.26.2008
	of_retrieve('template_clause_rules') //for dynamic add clauses - by Alfee 11.12.2007	 
	of_retrieve( 'ctx_facility')	//Added by jervis 2009-12-10
	of_retrieve('depend_field') //Added By jervis 2009-09-27.
	of_retrieve('depend_lookup') //Added By jervis 2009-09-27.
	of_retrieve( 'getting_started_data')
END IF

//IntelliCred Data
IF NOT gb_contract_version THEN
	of_retrieve('data_flow') 
	of_retrieve('alert_hdr') 
	of_retrieve('app_steps') 
	of_retrieve('process_steps')
	of_retrieve('address_lookup')  //Start Code Change ----03.29.2016 #V15 maha
END IF

gnv_appeondb.of_commitqueue()

end subroutine

public function string of_getitem (string as_tablename, string as_columnname, string as_condition, string as_case);//====================================================================
// Function: of_getitem
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_tablename
//                as_columnname
//                as_condition
//                as_case
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	mark		Date: 04/05/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//(Appeon)Toney 06.06.2013 - V141 ISG-CLX
//====================================================================
//
string	ls_value
long		ll_findrow

//------------------------------------------------------------------------
// 2.23.2016 <RP> added
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN
	return ""
END IF
//------------------------------------------------------------------------

ls_value = "@#"

If as_case = "Dotdd_Company" Then 
	Choose Case as_tablename	
		case 'facility' 
			ll_findrow = ids_ctx_facility.find(as_condition, 1,  ids_ctx_facility.rowcount())
			If ll_findrow <= 0 Then Return ""
	
			Choose Case Lower(as_columnname)
				Case "facility_name"
					ls_value = ids_ctx_facility.getitemstring(ll_findrow,  as_columnname)
				Case "facility_id"
					ls_value = String(ids_ctx_facility.getitemnumber( ll_findrow, as_columnname))
			End Choose
	End Choose
End If 

If ls_value = "@#" Then
	If Handle(GetApplication()) = 0 Then
		Messagebox("Appeon","Invoke GlobalData function error!"+&
		"~r~ntablename:" + as_tablename +&
		"~r~ncolumnname:"+ as_columnname +&
		"~r~nconditione:"+ as_condition )
	End If
	
	Return ""
End If

return ls_value
end function

public function integer of_get_wf_status_data (string as_tablename, string as_condition, string as_name, ref long al_data[]);//====================================================================
//$<Function>: of_get_wf_status_data
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_i,ll_count

//---------------2.25.2016 <RP> added for just-in-time caching----------------------------------
//IF of_initCache(as_tablename) = -1 THEN
IF of_retrieveIfNecessary(as_tablename, FALSE) = -1 THEN //Modified to of_retrieveIfNecessary by Appeon long.zhang 03.18.2016 (for performance changes bug)
	/* Invalid cache name */
	return -1
END IF
//-----------------------------------------------------------------------------------------------

choose case as_tablename
	case "workflow_status_filter"
		ids_workflow_status_filter.Setfilter(as_condition)
		ids_workflow_status_filter.Filter()
		
		ll_count = ids_workflow_status_filter.Rowcount()
		
		for ll_i = 1 to ll_count
			al_data[ll_i] = ids_workflow_status_filter.GetItemNumber(ll_i,"action_status_id")
		next
end choose
return 1
end function

public function long of_retrieve_appeon (string as_cachename);//
// 2.22.2016		<RP>		Copied and renamed the Appeon version of this function below
//							Cleaned up original of_retrieve() in place
//
//////////////////////////////////////////////////////////////////////
// $<function>n_cst_globaldataof_retrieve()
// $<arguments>
//		value	string	as_cachename		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
string ls_sql
long ll_ret = 1 //trap address lookup table retrieve error Added by  Nova 04.09.2010


if isvalid(w_open_message) then w_open_message.st_2.text = as_cachename //Start Code Change ----04.04.2013 #V12 maha

Choose case as_cachename
	Case 'icred_settings'
		ids_icred_settings.dataobject = 'd_g_icred_settings'
		ids_icred_settings.settransobject(SQLCA)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-08-07 By: Rodger Wu
		//$<reason> Fix a defect that exists in automatical updates of ASA database.
		
		/* ids_icred_settings.retrieve() */
		
		Integer li_return = 0
		
		li_return = ids_icred_settings.retrieve()
		//---------Begin Commented by (Appeon)Toney 05.31.2013 for V141 ISG-CLX--------
		//$Reason:Move to n_cst_update_sql.of_ver110_release_table1 ()
		  /*
			 if li_return < 0 then
				ls_sql = "Alter table icred_settings add web_crawl integer null; "
				execute immediate :ls_sql using sqlca;
				commit using sqlca;
				
				ls_sql = " Alter table icred_settings add downloadurl varchar(255) null; "
				execute immediate :ls_sql using sqlca;
				commit using sqlca;
				
				ids_icred_settings.retrieve()
			end if 
		  */
		//---------End Commented ------------------------------------------------------

		
		//---------------------------- APPEON END ----------------------------
	Case 'security_users'
		ids_security_users.dataobject = 'd_g_security_users'
		ids_security_users.settransobject(SQLCA)
		ids_security_users.retrieve()
	Case 'ids'
		ids_ids.dataobject = 'd_g_ids'
		ids_ids.settransobject(SQLCA)
		ids_ids.retrieve()
	Case 'sys_tables'
		ids_systables.dataobject = 'd_g_sys_tables'
		ids_systables.settransobject(SQLCA)
		ids_systables.retrieve()
	Case 'code_lookup'
		ids_code_lookup.dataobject = 'd_g_code_lookup'
		ids_code_lookup.settransobject(SQLCA)
		ids_code_lookup.retrieve()
	Case 'sys_fields'
		ids_sys_fields.dataobject = 'd_audit_fields_all'
		ids_sys_fields.settransobject(SQLCA)
		il_ids_sys_fields_cnt = ids_sys_fields.retrieve()
	Case 'ctx_notification'
		ids_ctx_notification.dataobject = 'd_g_ctx_notification'
		ids_ctx_notification.settransobject(SQLCA)
		ids_ctx_notification.retrieve()
	//---Begin Added by Alfee 02.26.2008--------
	Case 'ctx_ai_notification'
		ids_ctx_ai_notification.dataobject = 'd_g_ctx_ai_notification'
		ids_ctx_ai_notification.settransobject(SQLCA)
		ids_ctx_ai_notification.retrieve()
	Case 'ctx_am_ai_notification'
		ids_ctx_am_ai_notification.dataobject = 'd_g_ctx_am_ai_notification'
		ids_ctx_am_ai_notification.settransobject(SQLCA)
		ids_ctx_am_ai_notification.retrieve()
	//---End Added -----------------------------	
	Case 'facility'
		ids_facility.dataobject = 'd_g_facility'
		ids_facility.settransobject(SQLCA)
		ids_facility.retrieve()
	case 'data_view_screen'
		ids_data_view_screen.dataobject = 'd_g_data_view_screen'
		ids_data_view_screen.settransobject(SQLCA)
		ids_data_view_screen.retrieve()
	case 'contract_search'
		ids_contract_search.dataobject = 'd_contract_search_forpt'
		ids_contract_search.settransobject(SQLCA)
		ids_contract_search.retrieve()	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	case 'image_type'
		ids_image_type.dataobject = 'd_image_painter'
		ids_image_type.settransobject(SQLCA)
		ids_image_type.retrieve()		
	//---------------------------- APPEON END ----------------------------
	
	//Added for work flow. 6/11/2006 Henry
	case 'wf_workflow'
		ids_workflow.dataobject = 'd_g_workflow_data'
		ids_workflow.settransobject( sqlca)
		ids_workflow.retrieve( )
	case 'wf_action_types'
		ids_workflow_action.dataobject = 'd_g_action_types_data'
		ids_workflow_action.settransobject( sqlca)
		ids_workflow_action.retrieve( )
	case 'wf_action_status'
		ids_workflow_status.dataobject = 'd_g_action_status_data'
		ids_workflow_status.settransobject( sqlca)
		ids_workflow_status.retrieve( )
		
		//Added by Jervis 04.12.2006
		ids_workflow_status_filter.dataobject = "d_g_action_status_filter"
		ids_workflow_status_filter.settransobject(sqlca)
		ids_workflow_status_filter.retrieve()
	Case 'wf_trigger_param_data_comparison'
		ids_workflow_trigger_comp.dataobject = 'd_g_trigger_param_data_comparison_data'
		ids_workflow_trigger_comp.settransobject( sqlca)
		ids_workflow_trigger_comp.retrieve( )
	Case 'wf_trigger_param_action_status'
		ids_workflow_trigger_item.dataobject = 'd_g_trigger_param_action_status_data'
		ids_workflow_trigger_item.settransobject( sqlca)
		ids_workflow_trigger_item.retrieve( )
		//End added for work flow
	
	//Added 11.30.2006 
	Case 'code_lookup_2'
		ids_code_lookup_date.dataobject = 'd_code_lookup_modify_date_all'
		ids_code_lookup_date.settransobject( sqlca)
		ids_code_lookup_date.retrieve( )
	//-----Begin Added by Alfee 11.12.2007---------------
	case 'template_clause_rules' //for dynamic adding clauses' rules to templates
		ids_template_clause_rules.dataobject = 'd_dm_template_clause_rules'
		ids_template_clause_rules.settransobject( sqlca)
		ids_template_clause_rules.retrieve( )
	//-----End Added -------------------------------------	
	//-----Begin Added by Alan 19.08.2008----------------
	Case 'question_lookup'
		ids_question_lookup.dataobject = 'd_g_quest_lookup'
		ids_question_lookup.settransobject( sqlca)
		ids_question_lookup.retrieve( )
	//-----End Added -------------------------------------
	Case 'address_lookup' //currently called while printing applications or exporting multi-row data 
		ids_address_lookup.dataobject = 'd_address_lookup_all'
		ids_address_lookup.settransobject( sqlca)
		ll_ret=ids_address_lookup.retrieve( )
		//trap address lookup table retrieve error Added by  Nova 04.09.2010 
		//if ll_ret=-1 then messagebox("Retrieve Error","Address lookup  retrieve  failed. ") //commented by alfee 04.15.2010 - trapped in the call functions
	Case 'data_flow' //dataflow - alfee 12.21.2009 
		ids_dataflow.dataobject = 'd_data_flow_all'
		ids_dataflow.settransobject( sqlca)
		ids_dataflow.retrieve( )				
	Case 'alert_hdr' // V10.1 - Notification Alert - Andy 01/21/2010
		ids_na.dataobject = 'd_na_hdr_browse'
		ids_na.settransobject( sqlca)
		// Need retrieve all data - Andy 03/04/2010
//		ls_sql = ids_na.Object.DataWindow.table.Select
//		ls_sql += " Where alert_hdr.active_status = 1"
//		ids_na.SetSqlSelect(ls_sql)
		ids_na.retrieve( )
	Case "app_steps" //maha 07.30.2010 - application ateps
		ids_app_step_cache.dataobject = "d_sys_app_step_cache" 
		ids_app_step_cache.settransobject(sqlca)
		//-----Begin Modified by alfee 11.16.2010 ----------------------------
		ids_app_step_cache.retrieve()
		if appeongetclienttype() = 'PB' and ids_app_step_cache.rowcount() < 1 then
			messagebox("Cache setup","Appl process steps cache failed")
		end if
		//if ids_app_step_cache.retrieve() < 1 then messagebox("Cache setup","Appl process steps cache failed")
		//-----End Modified -----------------------------------------------------
	Case "process_steps"
		ids_process_step_cache.dataobject = "d_process_steps_cache"
		ids_process_step_cache.settransobject(sqlca)
		ids_process_step_cache.retrieve()	
	//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
	case 'ctx_all_notification' //jervis 07.04.2011
		ids_ctx_all_notification.dataobject = 'd_g_ctx_all_notification'
		ids_ctx_all_notification.settransobject(SQLCA)
		ids_ctx_all_notification.retrieve()	
	Case 'data_view' //Added By Ken.Guo 2009-07-10.
		ids_data_view.dataobject = 'd_g_data_view'
		ids_data_view.SetTransObject(SQLCA)
		ids_data_view.Retrieve()
	CASE 'depend_field'
		ids_field_depend.dataobject = 'd_depend_field_all'
		ids_field_depend.SetTransObject(SQLCA)
		ids_field_depend.Retrieve()
	case 'depend_lookup'
		ids_lookup_depend.dataobject = 'd_depend_lookup_all'
		ids_lookup_depend.SetTransObject(SQLCA)
		ids_lookup_depend.Retrieve()
	case 'ctx_facility'	//Jervis - 12.10.2009
		ids_ctx_facility.dataobject = 'd_g_ctx_facility'
		ids_ctx_facility.Settransobject( sqlca)
		ids_ctx_facility.Retrieve( )
	case 'em_user_msg' //Added By Ken.Guo 2010-03-26.
		ids_em_user_msg_list.dataobject = 'd_g_em_user_msg_list'
		ids_em_user_msg_list.Settransobject(SQLCA)
		ids_em_user_msg_list.Retrieve(gs_user_id)
	case 'em_user_config' //Added By Ken.Guo 2010-03-26.
		ids_em_user_config.dataobject = 'd_em_user_config'
		ids_em_user_config.Settransobject(SQLCA)
		ids_em_user_config.Retrieve(gs_user_id)	
	case 'getting_started_data' //Added By Ken.Guo 2010-05-19.
		ids_getting_started.dataobject = 'd_g_getting_started'
		ids_getting_started.Settransobject(SQLCA)
		ids_getting_started.Retrieve()				
	case 'dashboard_getting_started'//Added By Ken.Guo 2010-05-19.
		ids_dashboard_getting_started.dataobject = 'd_dashb_gadget_getting_started'
		ids_dashboard_getting_started.Settransobject(SQLCA)
		ids_dashboard_getting_started.Retrieve(gs_user_id)
	case 'clause_attribute' //Added By Ken.Guo 2010-12-16.
		ids_clause_attribute.dataobject = 'd_g_acp_clause_attr_val_list'
		ids_clause_attribute.Settransobject(SQLCA)
		ids_clause_attribute.Retrieve()		
	case 'clause' //Added By Ken.Guo 2011-05-03.
		ids_clause.dataobject = 'd_g_clause'
		ids_clause.Settransobject(SQLCA)
		ids_clause.Retrieve()	
	//---------End Added ------------------------------------------------------------------
	//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	case 'ctx_pictures' //Added By Ken.Guo 2011-05-03.
		ids_pictures.dataobject = 'd_g_pictures'
		ids_pictures.Settransobject(SQLCA)
		ids_pictures.Retrieve()	
	//---------End Added ------------------------------------------------------
End Choose

Return ll_ret //alfee 04.15.2010
end function

public function long of_retrieveifnecessary (string as_cachename, boolean ab_alwaysretrieve);//	Function of_retrieveIfNecessary()
//	
//	2.23.2016	<RP>		Initial version
//	3.4.2016		<RP>		Added "app_session_parms" to special handling case below
//
//	If ab_alwaysRetrieve, then refresh as_cachename
//	Else, refresh only if cache is empty
//
//	Returns:
//	Number of rows in as_cachename - success
//	-1 - error
//
string ls_descr
datastore lds_cache
string ls_dataobject
long ll_ret
Long ll_rowcnt//Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)

IF of_initCache(as_cachename) = -1 THEN
	return -1
END IF

IF of_getCache(as_cachename, lds_cache, ls_dataobject) = -1 THEN
	return -1
END IF

//-------------------------------------------------------------------------------------------
// Copied from Appeon's original of_retrieve()
if isvalid(w_open_message) then w_open_message.st_2.text = as_cachename
//-------------------------------------------------------------------------------------------


/* If here, then as_cachename is valid */
IF as_cachename = 'wf_action_status' THEN
	/* Need additional cache */
	IF of_retrieveIfNecessary("workflow_status_filter", ab_alwaysRetrieve) = -1 THEN
		return -1
	END IF
END IF

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.09.2017
//<$>reason:if rowcount = 0 and this cache was retrieved, don't retrieve it again and again, For Contracts Module Slowness.

//IF (lds_cache.rowCount() > 0) AND NOT ab_alwaysRetrieve THEN
//	ll_ret = lds_cache.rowCount()
ll_rowcnt = lds_cache.rowCount()
IF (ll_rowcnt > 0) AND NOT ab_alwaysRetrieve THEN
	ll_ret = ll_rowcnt
ElseIf (ll_rowcnt = 0) AND NOT ab_alwaysRetrieve AND of_is_cachename_retrieved(as_cachename) Then //If it was retrieved and no rows.
	ll_ret = 0	
ELSE
	gnv_appeondb.of_ImdCall() //Added by Appeon long.zhang 03.23.2016 (Used in web to retrieve immediately)
	
	/* Retrieve the cache. Check for special handling */
	Choose case as_cachename
		case 'em_user_msg', 'em_user_config', 'dashboard_getting_started', 'app_session_parms'
			ll_ret = lds_cache.Retrieve(gs_user_id)
		CASE ELSE
			ll_ret = lds_cache.retrieve()
	END CHOOSE
	
	if ll_ret >= 0 then //(Appeon)Stephen 05.02.2017 - V15.3 Critical Bug # 5625 - Can't upgrade to V15.3 client server - Getting error n_cst_globaldata
		of_add_cachename_retrieved(as_cachename) //Remember this cache has been retrieved.
	end if
	 
	// <RP>: taken from original Appeon version of of_retrieve()
	Choose case as_cachename
		Case 'sys_fields'
			il_ids_sys_fields_cnt = ll_ret
		Case "app_steps"
			if appeongetclienttype() = 'PB' and lds_cache.rowcount() < 1 then
				messagebox("Cache setup","Appl process steps cache failed")
			end if
	End Choose
END IF
//------------------- APPEON END -------------------

Return ll_ret

end function

public function integer of_getcache (string as_cachename, ref datastore ads_cache, ref string as_dataobject);//
//	of_getCache() - return corresponding datastore and dataobject for as_cachename
//
//	Description:
//		Hard coded cases are distilled from the code in original of_retrieve() method
//
//	2.23.2016	<RP>		Initial version
//
//	3.4.2016		<RP>		Added cache "app_session_parms" containing miscellaneous user session-based parameters
//
//	Returns: integer
//				1 - success
//				-1 - error
//

// Empty variable
datastore lds_cache

Choose case lower(as_cachename)
	Case 'icred_settings'
		ads_cache = ids_icred_settings
		as_dataobject = 'd_g_icred_settings'
	Case 'security_users'
		ads_cache = ids_security_users
		as_dataobject = 'd_g_security_users'
	Case 'ids'
		ads_cache = ids_ids
		as_dataobject = 'd_g_ids'
	Case 'sys_tables'
		ads_cache = ids_systables
		as_dataobject = 'd_g_sys_tables'
	Case 'code_lookup'
		ads_cache = ids_code_lookup
		as_dataobject = 'd_g_code_lookup'
	Case 'sys_fields'
		ads_cache = ids_sys_fields
		as_dataobject = 'd_audit_fields_all'
	Case 'ctx_notification'
		ads_cache = ids_ctx_notification
		as_dataobject = 'd_g_ctx_notification'
	Case 'ctx_ai_notification'
		ads_cache = ids_ctx_ai_notification
		as_dataobject = 'd_g_ctx_ai_notification'
	Case 'ctx_am_ai_notification'
		ads_cache = ids_ctx_am_ai_notification
		as_dataobject = 'd_g_ctx_am_ai_notification'
	Case 'facility'
		ads_cache = ids_facility
		as_dataobject = 'd_g_facility'
	case 'data_view_screen'
		ads_cache = ids_data_view_screen
		as_dataobject = 'd_g_data_view_screen'
	case 'contract_search'
		ads_cache = ids_contract_search
		as_dataobject = 'd_contract_search_forpt'
	case 'image_type'
		ads_cache = ids_image_type
		as_dataobject = 'd_image_painter'
	case 'wf_workflow'
		ads_cache = ids_workflow
		as_dataobject = 'd_g_workflow_data'
	case 'wf_action_types'
		ads_cache = ids_workflow_action
		as_dataobject = 'd_g_action_types_data'
	case 'wf_action_status'
		ads_cache = ids_workflow_status
		as_dataobject = 'd_g_action_status_data'
	case 'workflow_status_filter'
		ads_cache = ids_workflow_status_filter
		as_dataobject = 'd_g_action_status_filter'
	Case 'wf_trigger_param_data_comparison'
		ads_cache = ids_workflow_trigger_comp
		as_dataobject = 'd_g_trigger_param_data_comparison_data'
	Case 'wf_trigger_param_action_status'
		ads_cache = ids_workflow_trigger_item
		as_dataobject = 'd_g_trigger_param_action_status_data'
	Case 'code_lookup_2'
		ads_cache = ids_code_lookup_date
		as_dataobject = 'd_code_lookup_modify_date_all'
	case 'template_clause_rules'
		ads_cache = ids_template_clause_rules
		as_dataobject = 'd_dm_template_clause_rules'
	Case 'question_lookup'
		ads_cache = ids_question_lookup
		as_dataobject = 'd_g_quest_lookup'
	Case 'address_lookup'
		ads_cache = ids_address_lookup
		as_dataobject = 'd_address_lookup_all'
	Case 'data_flow'
		ads_cache = ids_dataflow
		as_dataobject = 'd_data_flow_all'
	Case 'alert_hdr'
		ads_cache = ids_na
		as_dataobject = 'd_na_hdr_browse'
	Case "app_steps"
		ads_cache = ids_app_step_cache
		as_dataobject = 'd_sys_app_step_cache'
	Case "process_steps"
		ads_cache = ids_process_step_cache
		as_dataobject = 'd_process_steps_cache'
	case 'ctx_all_notification'
		ads_cache = ids_ctx_all_notification
		as_dataobject = 'd_g_ctx_all_notification'
	Case 'data_view'
		ads_cache = ids_data_view
		as_dataobject = 'd_g_data_view'
	CASE 'depend_field'
		ads_cache = ids_field_depend
		as_dataobject = 'd_depend_field_all'
	case 'depend_lookup'
		ads_cache = ids_lookup_depend
		as_dataobject = 'd_depend_lookup_all'
	case 'ctx_facility'
		ads_cache = ids_ctx_facility
		as_dataobject = 'd_g_ctx_facility'
	case 'em_user_msg'
		ads_cache = ids_em_user_msg_list
		as_dataobject = 'd_g_em_user_msg_list'
	case 'em_user_config'
		ads_cache = ids_em_user_config
		as_dataobject = 'd_em_user_config'
	case 'getting_started_data'
		ads_cache = ids_getting_started
		as_dataobject = 'd_g_getting_started'
	case 'dashboard_getting_started', 'dashboard_gadgets_getting_started'
		ads_cache = ids_dashboard_getting_started
		as_dataobject = 'd_dashb_gadget_getting_started'
	case 'clause_attribute'
		ads_cache = ids_clause_attribute
		as_dataobject = 'd_g_acp_clause_attr_val_list'
	case 'clause'
		ads_cache = ids_clause
		as_dataobject = 'd_g_clause'
	case 'ctx_pictures'
		ads_cache = ids_pictures
		as_dataobject = 'd_g_pictures'
	//-----------<RP> added -----------------------------
	CASE 'app_session_parms'
		ads_cache = ids_app_session_parms
		as_dataobject = 'd_g_app_session_parms'
	//----------------------------------------------------------		
	Case else
		ads_cache = lds_cache
		as_dataobject = ""
		return - 1
End Choose

return 1

end function

public function integer of_initcache (string as_cachename);//	of_initCache()
//
//	Description:
//		For the given cache name, (1) instantiate the relevant datastore, (2) set its DataObject property and (3) setTransObject(SQLCA)
//	Returns:
//		1 - success
//		-1 - error
//	History:
//	2.25.2016	<RP>		Initial version
//
datastore lds_cache
string ls_dataobject, ls_test

IF of_getCache(as_cachename, lds_cache, ls_dataobject) = -1 THEN
	return -1
END IF

IF NOT isValid(lds_cache) THEN
	// From original constructor() event; ids_em_user_msg_list and ids_em_user_config are of type n_ds
	CHOOSE CASE as_cachename
		CASE "em_user_msg", "em_user_config"
			lds_cache = CREATE n_ds
		CASE ELSE
			lds_cache = CREATE datastore
	END CHOOSE
END IF

/* Test whether or not a dataobject has been set */
ls_test = trim(lds_cache.Describe("DataWindow.Bands"))
IF len(ls_test) = 0 THEN
	/* Try to assign the dataobject */
	lds_cache.dataobject = ls_dataobject
	lds_cache.setTransObject(SQLCA)
	/* Test to see if the dataobject is valid */
	ls_test = trim(lds_cache.Describe("DataWindow.Bands"))
	IF len(ls_test) = 0 THEN
		messageBox(this.className() + ".of_initCache()", "Error - invalid DataObject '" + ls_dataobject + "'")
		return -1
	END IF
END IF

return 1

end function

public subroutine of_add_cachename_retrieved (string as_cachename);//====================================================================
//$<Function>: of_add_cachename_retrieved
//$<Arguments>:
// 	value    string    as_catchname
//$<Return>:  (None)
//$<Description>: Remember that this cachename has been retrieved.
//$<Author>: (Appeon) long.zhang 03.09.2017 (Contracts Module Slowness)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If Not (of_is_cachename_retrieved(as_cachename)) Then &
	is_cachename_retrieved[UpperBound(is_cachename_retrieved[]) + 1] = as_cachename
end subroutine

public function boolean of_is_cachename_retrieved (string as_cachename);//====================================================================
//$<Function>: of_is_cachename_retrieved
//$<Arguments>:
// 	value    string    as_catchname
//$<Return>:  (None)
//$<Description>: Check whether this cachename was ever retrieved.
//$<Author>: (Appeon) long.zhang 03.09.2017 (Contracts Module Slowness)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_string lnv_string

Return lnv_string.of_isexists( is_cachename_retrieved[], as_cachename)


end function

on n_cst_globaldata.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_globaldata.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//
ids_icred_settings = create datastore
ids_security_users = create datastore
ids_ids = create datastore

//ids_views = create datastore
//ids_facilitys = create datastore

ids_systables = create datastore

ids_code_lookup = create datastore

ids_sys_fields = create datastore

ids_ctx_notification = create datastore
//---Begin Added by Alfee 02.26.2008--------
ids_ctx_ai_notification = create datastore
ids_ctx_am_ai_notification = create datastore
//---End Added -----------------------------

ids_facility = create datastore
ids_data_view_screen = create datastore

ids_contract_search = create datastore
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
ids_image_type = create datastore
//---------------------------- APPEON END ----------------------------

//Added for work flow. 6/11/2006 Henry
ids_workflow = create datastore
ids_workflow_action = create datastore
ids_workflow_status = create datastore
ids_workflow_trigger_comp = create datastore
ids_workflow_trigger_item = Create DataStore

//Added 11.30.2006 henry
ids_code_lookup_date = create datastore

//Added by Jervis 04.12.2006
ids_workflow_status_filter = create datastore

//Added by Alfee 11.12.2007
ids_template_clause_rules = Create datastore 

//Added by Alan 08.15.2008
ids_question_lookup = Create datastore 
ids_address_lookup = Create datastore  //alfee 09.08.2009
ids_dataflow = Create datastore //DataFlow - alfee 12.21.2009

ids_na = Create datastore // V10.1 - Notification Alert - Andy 01/21/2010

ids_app_step_cache = Create datastore //Start Code Change ----08.02.2010 #V10 maha
ids_process_step_cache = Create datastore //Start Code Change ----.2011 #V11 maha 

//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
ids_ctx_all_notification = create datastore
ids_data_view = Create datastore //Added By Ken.Guo 2009-07-10.
//Added by jervis 09.27.2009
ids_field_depend = CREATE datastore
ids_lookup_depend = CREATE datastore
ids_ctx_facility = create datastore //jervis 12.10.2009
//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//ids_em_user_msg_list = Create DataStore
//ids_em_user_config = Create DataStore
ids_em_user_msg_list = Create n_ds
ids_em_user_config = Create n_ds
ids_pictures = Create DataStore
//---------End Modfiied ------------------------------------------------------
ids_getting_started = Create DataStore
ids_dashboard_getting_started = Create DataStore
ids_clause_attribute = Create DataStore
ids_clause = Create DataStore
//---------End Added ------------------------------------------------------------------

//-------------------------- Added 3.4.2016 by Intertech Consulting---------------------------------
ids_app_session_parms = CREATE datastore
//---------------------------------------------------------------------------------------------------------

end event

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-07 By: Scofield
//$<Reason> Destroy these instance variables.

if IsValid(ids_security_users) then
	Destroy ids_security_users
end if

if IsValid(ids_icred_settings) then
	Destroy ids_icred_settings
end if

if IsValid(ids_ids) then
	Destroy ids_ids
end if

if IsValid(ids_systables) then
	Destroy ids_systables
end if

if IsValid(ids_code_lookup) then
	Destroy ids_code_lookup
end if

if IsValid(ids_code_lookup_dddw) then
	Destroy ids_code_lookup_dddw
end if

if IsValid(ids_code_lookup_date) then
	Destroy ids_code_lookup_date
end if

if IsValid(ids_sys_fields) then
	Destroy ids_sys_fields
end if

if IsValid(ids_ctx_notification) then
	Destroy ids_ctx_notification
end if

//---Begin Added by Alfee 02.26.2008--------
if IsValid(ids_ctx_ai_notification) then 
	Destroy ids_ctx_ai_notification
end if

if IsValid(ids_ctx_am_ai_notification) then
	Destroy ids_ctx_am_ai_notification
end if
//---End Added -----------------------------

if IsValid(ids_facility) then
	Destroy ids_facility
end if

if IsValid(ids_data_view_screen) then
	Destroy ids_data_view_screen
end if

if IsValid(ids_contract_search) then
	Destroy ids_contract_search
end if

if IsValid(ids_image_type) then
	Destroy ids_image_type
end if

if IsValid(ids_workflow) then
	Destroy ids_workflow
end if

if IsValid(ids_workflow_action) then
	Destroy ids_workflow_action
end if

if IsValid(ids_workflow_status) then
	Destroy ids_workflow_status
end if

if IsValid(ids_workflow_trigger_comp) then
	Destroy ids_workflow_trigger_comp
end if

if IsValid(ids_workflow_trigger_item) then
	Destroy ids_workflow_trigger_item
end if

if IsValid(ids_screen_table_p) then
	Destroy ids_screen_table_p
end if

if IsValid(ids_screen_table_c) then
	Destroy ids_screen_table_c
end if

if IsValid(ids_workflow_status_filter) then
	Destroy ids_workflow_status_filter
end if
//---------------------------- APPEON END ----------------------------

if IsValid(ids_template_clause_rules) then Destroy ids_template_clause_rules //alfee 11.12.2007
if IsValid(ids_address_lookup) then Destroy ids_address_lookup //alfee 09.08.2009
if isvalid(ids_dataflow) then Destroy ids_dataflow //dataflow - alfee 12.21.2009
if isvalid(ids_na) then Destroy ids_na // V10.1 - Notification Alert - Andy 01/21/2010

//---------Begin Added by (Appeon)Toney 06.06.2013 for V141 ISG-CLX--------
if IsValid(ids_ctx_all_notification) then
	Destroy ids_ctx_all_notification
end if

//Add by jervis 09.27.2009
if isvalid(ids_question_lookup) then destroy ids_question_lookup
if isvalid(ids_data_view) then destroy ids_data_view
if isvalid(ids_field_depend) then destroy ids_field_depend
if isvalid(ids_lookup_depend) then destroy ids_lookup_depend

if isvalid(ids_ctx_facility) then destroy ids_ctx_facility
If isvalid(ids_em_user_msg_list) then Destroy ids_em_user_msg_list
If isvalid(ids_em_user_config) then Destroy ids_em_user_config

If isvalid(ids_getting_started) then Destroy  ids_getting_started
If isvalid(ids_dashboard_getting_started) then Destroy  ids_dashboard_getting_started
If isvalid(ids_clause_attribute) then Destroy  ids_clause_attribute
If isvalid(ids_clause) then Destroy  ids_clause
//---------End Added ------------------------------------------------------------------
If isvalid(ids_pictures) then Destroy  ids_pictures //(Appeon)Harry 03.19.2014 - V142 ISG-CLX

//-------------------------- Added 3.4.2016 by Intertech Consulting---------------------------------
IF isValid(ids_app_session_parms) THEN DESTROY ids_app_session_parms
//---------------------------------------------------------------------------------------------------------

end event

