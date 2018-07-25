$PBExportHeader$n_cst_scheduler_back10_16.sru
forward
global type n_cst_scheduler_back10_16 from nonvisualobject
end type
end forward

global type n_cst_scheduler_back10_16 from nonvisualobject autoinstantiate
end type

type variables
integer ii_timer
long     il_rows_limited //(Appeon)Stephen 2013-06-25 - Bug 3581
long il_id_for_log = 11111 //maha 06.06.2016
boolean ib_all     //(Appeon)Stephen 2013-06-25 - Bug 3581
integer ii_pro_step         //(Appeon)stephen 12.30.2013
integer ii_retry_time  //(Appeon)Stephen 07.01.2015
integer ii_max_retries  //maha 11.17.2015
string  is_comp_flag  //(Appeon)Stephen 2013-07-08 - Bug 3600
string is_rpt_name  //maha 07.25.2016

DataStore ids_schedule
DataStore ids_schedule_log
DataStore ids_schedule_veri_log

DataStore ids_imp_opt
DataStore ids_imp_prj
DataStore ids_emp_opt

//assigned in w_auto_schedule.open()
u_dw idw_verif 
u_dw idw_verif_wc
listbox ilb_1



end variables

forward prototypes
public subroutine of_log_save ()
public function integer of_connect ()
public subroutine of_update_schedule ()
public function integer of_timer ()
public function integer of_run_aiq_exp_cred (ref string as_message, ref long al_proc_cnt)
public function integer of_run_aiq_emails (ref string as_message, ref long al_proc_cnt)
public function integer of_run_aiq_exp_appoint (ref string as_message, ref long al_proc_cnt)
public function integer of_run_aiq_notifications (ref string as_message, ref long al_proc_cnt)
public function integer of_run_aiq_print_reset (ref string as_message, ref long al_proc_cnt)
public function integer of_run_aiq_workflow (ref string as_message, ref long al_proc_cnt)
public function integer of_run_caqh_import (string as_file_path, ref string as_message, ref long al_proc_cnt)
public function integer of_run_export (integer ai_sched_id, ref string as_message, ref long al_proc_cnt)
public function integer of_run_import (integer ai_sched_id, ref string as_message, ref long al_proc_cnt)
public function integer of_run_project (long al_project_id, ref string as_message, ref long al_proc_cnt)
public function integer of_run_report (string as_sql, string as_save_path, string as_extend, ref string as_message, ref long al_proc_cnt)
public function integer of_test_item (integer ai_sched_id)
public function string of_set_filter (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, ref datastore ad_ds)
public function string of_set_where (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, ref datastore ad_ds)
public function string of_error_message (integer ai_mes)
public function integer of_run_verify_webcrawler (integer ai_sched_id, ref string as_message, ref long al_proc_cnt)
public function integer of_run_verify_npdb (integer ai_scheduler_id, integer ai_type, ref string as_message, ref long al_proc_cnt)
public function integer of_run_verify_scan_oig (integer ai_sched_id, ref string as_message, ref long al_proc_cnt)
public function integer of_log_schedule (integer ai_sched_id, integer ai_sched_type, string as_imp_exp, datetime ad_run_time, datetime ad_end_time, string as_error_code, long al_num_processed)
public function integer of_log_schedule_verif (integer ai_scheduler_id, string as_full_name, integer ai_screen_id, string as_ref_value, string as_doc_id, string as_note)
public function string of_get_impexp_nm (integer ai_sched_type, integer ai_imp_proj, integer ai_imp_exp_opt)
public subroutine of_set_verif_filter (datawindow adw_verif, string as_verify_type, integer ai_sub_type)
public function integer of_run_aiq_pendingchange (ref string as_message, ref long al_prac_cnt)
public function integer of_run_intellireport (integer ai_sched_id, ref string as_message, ref long al_proc_cnt)
public function integer of_run_caqh_roster_import (string as_type, ref string as_message, ref long al_proc_cnt)
public function boolean of_is_no_data_error (string as_error)
end prototypes

public subroutine of_log_save ();//Save log of schedule

IF ids_schedule_log.Update( ) = 1 THEN
	IF  ids_schedule_veri_log.Update( ) = 1  THEN
		COMMIT Using sqlca;
		ids_schedule_log.reset( )
		ids_schedule_veri_log.reset()
		//messagebox("","successfull")
	ELSE
		ROLLBACK Using sqlca;
		//messagebox("","failed")
	END IF
ELSE
	ROLLBACK Using sqlca;
	//messagebox("","failed")
END IF



end subroutine

public function integer of_connect ();//Test database is connected --Nova 01.30.2010 - v10.1 Scheduler Functionality
Integer i
Integer res = 1
String ls_mess
DateTime ldt_now
//Test database is connected
SELECT set_1 Into :i From icred_settings;
IF SQLCA.SQLCode = -1 THEN
	res = -1
ELSE
	IF ii_timer > 1000 THEN ii_timer = 0
	RETURN 1
END IF
//if connection fails attempt to reconnect
IF res = -1 THEN 
	DISCONNECT Using SQLCA;
	//clear the connection
	ii_timer++
	res = of_connect_to_db_no_mess()
	ldt_now = DateTime(Today(),Now())
	IF res = 1 THEN //if successful log reconnect
		ids_schedule.SetTransObject(SQLCA)
		ii_timer = 0
	ELSE //if failed log every five minutes
		IF ii_timer > 4 THEN
			ii_timer = 0
		END IF
	END IF
END IF


RETURN res



end function

public subroutine of_update_schedule ();
//Update schedule setting

IF ids_schedule.Update() = 1 THEN
	COMMIT Using sqlca;
ELSE
	ROLLBACK Using sqlca;
END IF
end subroutine

public function integer of_timer ();//Polling All schedule items - Nova 01.30.2010 - v10.1 Scheduler Functionality
//Reorganized by Alfee 02.05.2010

Integer r, li_rc, li_imp_proj, li_imp_exp_opt 
Integer li_sched_int, li_sched_type, li_sched_id
integer li_reset_fail  //maha 04.30.2015
integer li_rerun_fail //maha 04.30.2015
integer li_fail_cnt = 0 //maha 04.30.2015
integer li_max_attempts //maha 04.30.2015
integer li_fail_int //maha 04.30.2015
integer li_max  //maha 11.17.015
Long ll_proc_cnt 
String ls_current_dt, ls_sched_dt, ls_error_code, ls_sched_msg, ls_imp_exp
DateTime ldt_run_time, ldt_next_time, ldt_sched_time
DateTime ldt_org_time
boolean lb_IsTimerStop = false //Evan 12.29.2011

li_rc = ids_schedule.RowCount()
IF li_rc < 1 THEN RETURN -1

//Test database is connected
IF of_connect( ) < 1 THEN 
	//log??
	RETURN -1
END IF

//Get current datetime
ls_current_dt = String(Today(),'yyyy/mm/dd') + Space(1) + String(Now(),'hh:mm:00')

lb_IsTimerStop = true  //(Appeon)Stephen 07.01.2015 - Bug # 4579 - Scheduler auto shutdown is not working case # 55316
ii_retry_time += 1 //(Appeon)Stephen 07.01.2015 - Bug # 4579 - Scheduler auto shutdown is not working case # 55316

 //Start Code Change ----11.17.2015 #V15 maha - get the highest max attempts in the list
//FOR r = 1 To li_rc	
//	if ids_schedule.GetItemNumber( r, "active_status") = 1 THEN
//		li_max_attempts = ids_schedule.GetItemNumber(r, "fail_max_att") 
//		if ii_max_retries < li_max_attempts then ii_max_retries = li_max_attempts
//	end if
//next
//	messagebox("max retries", ii_max_retries)
 //Start Code Change ----11.17.2015


//Loop for each schedule
FOR r = 1 To li_rc	
	
	//skip the unqualified schedule
	IF ids_schedule.GetItemNumber( r, "active_status") <> 1 THEN CONTINUE
	ls_sched_dt = String(ids_schedule.GetItemDateTime(r, "next_start"),'yyyy/mm/dd hh:mm:00')
	
	//---------Begin Added by (Appeon)Stephen 07.01.2015 for Bug # 4579 - Scheduler auto shutdown is not working case # 55316--------
	li_max_attempts = ids_schedule.GetItemNumber(r, "fail_max_att")  
	li_rerun_fail = ids_schedule.GetItemNumber(r, "retry_fail")  

	if li_rerun_fail > 0 then
		if li_max_attempts = 0 or isnull(li_max_attempts) then li_max_attempts = 1
		if ii_retry_time > li_max_attempts then continue
	end if
	lb_IsTimerStop = false
	//---------End Added ------------------------------------------------------
	
	IF	ls_sched_dt > ls_current_dt THEN CONTINUE
	IF	ls_sched_dt < ls_current_dt AND ids_schedule.GetItemString(r, "run_overdue") = '0' THEN CONTINUE

	//initialize variables
	li_sched_id = ids_schedule.GetItemNumber( r, "sched_id")
	il_id_for_log =  li_sched_id  //Start Code Change ----06.06.2016 #V152 maha
	li_sched_type = ids_schedule.GetItemNumber( r, "sched_type")
	ldt_sched_time = ids_schedule.GetItemDateTime(r, "next_start")
	li_sched_int = ids_schedule.GetItemNumber(r, "interval_type")
	li_imp_proj	= ids_schedule.GetItemNumber(r, "imp_project")
	li_imp_exp_opt = ids_schedule.GetItemNumber(r, "imp_exp_option")	
	il_rows_limited = ids_schedule.GetItemNumber(r, "rows_limited")	 //(Appeon)Stephen 2013-06-25 - Bug 3581
	 //Start Code Change ----04.30.2015 #V15 maha
	li_reset_fail = ids_schedule.GetItemNumber(r, "reset_fail_time") 
	li_rerun_fail = ids_schedule.GetItemNumber(r, "retry_fail")
	
	//Start Code Change ----11.17.2015 #V15 maha - set defaults
	if isnull(li_rerun_fail) then li_rerun_fail = 0   
	if isnull(li_reset_fail) then li_reset_fail = 1
	//End Code Change ----11.17.2015	
	
	if li_rerun_fail > 0 then
		li_fail_cnt = ids_schedule.GetItemNumber(r, "use_org_time")  
		if isnull(li_fail_cnt) then li_fail_cnt = 0
		li_fail_cnt++
		
		li_max_attempts = ids_schedule.GetItemNumber(r, "fail_max_att")  
		if isnull(li_max_attempts) then //if not set no retry
			li_fail_cnt = 0
			li_rerun_fail = 0
		end if
		
		li_fail_int = ids_schedule.GetItemNumber(r, "fail_interval")  

		if isnull(li_fail_int) then  //set default
			li_fail_int = 10
		end if
			
	end if
	//Start Code Change ----04.30.2015
	
	ll_proc_cnt = 0
	ls_error_code = '' 
	ls_sched_msg = ''
	setnull(is_comp_flag) //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
	
	ldt_run_time = DateTime(Today(),Now())
	//dw_browse.Event RowFocusChanged(r) //run_overdue
	
	Timer(0, w_auto_schedule) //Added by Evan 12.29.2011 --- for fix pb exception
	//lb_IsTimerStop = true   //Commented by (Appeon)Stephen 07.01.2015 - Bug # 4579 - Scheduler auto shutdown is not working case # 55316
	
	//run the scheduled task
	CHOOSE CASE li_sched_type
		CASE 10 //Import
			of_run_import(li_sched_id, ls_sched_msg, ll_proc_cnt)
		CASE 20 //Export
			of_run_export(li_sched_id, ls_sched_msg, ll_proc_cnt)
			IF ids_schedule.GetItemNumber( r, "export_reset_audit") = 1 THEN //?
				UPDATE sys_audit Set exported = 0, export_date = :ldt_run_time Where exported = 1 And date_time_modified <= :ldt_run_time;
				COMMIT Using sqlca;
			END IF
		CASE 31 //AIQ - Exp Cred
			Of_run_aiq_exp_cred(ls_sched_msg, ll_proc_cnt)
		CASE 32 //AIQ - Exp Appoint
			Of_run_aiq_exp_appoint(ls_sched_msg, ll_proc_cnt)
		CASE 33 //AIQ - Print Reset
			Of_run_aiq_print_reset(ls_sched_msg, ll_proc_cnt)
		CASE 34 //AIQ - WorkFlow
			Of_run_aiq_workflow(ls_sched_msg, ll_proc_cnt)
		CASE 35 //AIQ - Emails(Contract)
			Of_run_aiq_emails(ls_sched_msg, ll_proc_cnt)
		CASE 36 //AIQ - Notifications
			Of_run_aiq_notifications(ls_sched_msg, ll_proc_cnt)
		CASE 37	//AIQ Pending Change added by  long.zhang 11.01.2013 (V14.1Group Location Effective Dates)
			of_run_aiq_pendingchange(ls_sched_msg,ll_proc_cnt)	
		CASE 41 //Verifi - OIG
			of_run_verify_scan_oig(li_sched_id, ls_sched_msg, ll_proc_cnt)
		CASE 4201 //Verif - NPDB Send
			of_run_verify_npdb(li_sched_id, 2, ls_sched_msg, ll_proc_cnt)
		CASE 4202 //Verif - NPDB Receive
			of_run_verify_npdb(li_sched_id, 1, ls_sched_msg, ll_proc_cnt)
		CASE 43 //Verif - Web Crawler
			of_run_verify_webcrawler(li_sched_id, ls_sched_msg, ll_proc_cnt)
		CASE 50 //CAQH File Import
			of_run_caqh_import(ids_schedule.GetItemString( r, "file_path"), ls_sched_msg, ll_proc_cnt)
		CASE 53 //CAQH Roster File Import-Return Roster File, Added by Appeon long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
			of_run_caqh_roster_import('LIST', ls_sched_msg, ll_proc_cnt)
		CASE 54 //CAQH Roster File Import-Roster Exception File, Added by Appeon long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
			of_run_caqh_roster_import('EXCEPTION', ls_sched_msg, ll_proc_cnt)
		CASE 60 //Report
			is_rpt_name = ids_schedule.GetItemString(r, "sched_name")
			of_run_report(ids_schedule.GetItemString(r, "retrieve_query"), ids_schedule.GetItemString(r, "file_path"), ids_schedule.GetItemString(r, "report_format"), ls_sched_msg, ll_proc_cnt)
		case 70  //(Appeon)Stephen 04.22.2014 - V142 Schedule IntelliReport
			of_run_intellireport(li_sched_id, ls_sched_msg, ll_proc_cnt)
	END CHOOSE
	
	 //Start Code Change ----04.30.2015 #V15 maha - moved fail test above time set
	IF LenA(ls_sched_msg) = 0 THEN 
		ids_schedule.SetItem(r,"last_success",ldt_run_time)
		ls_error_code = 'Successful.'
		ls_sched_msg = ls_error_code
		is_comp_flag = 'Y' //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
	ElseIf  li_sched_type = 10 And of_is_no_data_error(ls_sched_msg) Then //Import with no data, Added by Appeon long.zhang 10.30.2015 (Scheduler reports failure when an import points to a file with no data)
		ls_error_code = 'No data'
		is_comp_flag = 'N'
	ELSE 
		ls_error_code = 'Failure.'
		is_comp_flag = 'N' //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
	END IF
	ids_schedule.SetItem(r,"error_code",ls_error_code)	
	
	//refresh schedule setting
	//---------Begin Modified by (Appeon)Stephen 01.11.2016 for Bug id 4875 - Scheduler Resetting Time Incorrect--------
	//ldt_next_time = of_next_run_time(ids_schedule.GetItemNumber(r,"interval_length"), li_sched_int, Date(ldt_sched_time), Time(ldt_sched_time))	
	ldt_org_time = ids_schedule.GetItemDateTime(r, "org_run_time")
	if li_rerun_fail = 1 and li_fail_cnt > 0 and not isnull(ldt_org_time) then
		ldt_next_time = of_next_run_time(ids_schedule.GetItemNumber(r,"interval_length"), li_sched_int, Date(ldt_org_time), Time(ldt_org_time))	
	else
		ldt_next_time = of_next_run_time(ids_schedule.GetItemNumber(r,"interval_length"), li_sched_int, Date(ldt_sched_time), Time(ldt_sched_time))	
	end if	
	//---------End Modfiied ------------------------------------------------------
	
	 //Start Code Change ----11.17.2015 #V15 maha - restructured next set logic
	 ids_schedule.SetItem(r,"last_run",ldt_run_time)
	 
	 IF li_rerun_fail = 0 then  //normal no rerun
	 	if is_comp_flag = 'Y' then  //completed
			ids_schedule.SetItem(r,"next_start",ldt_next_time)
			li_fail_cnt = 0 //(Appeon)Stephen 12.09.2015 - Bug id 4875 - Scheduler Resetting Time Incorrect
		else
			if li_reset_fail = 1 then  //normal reset to next
				ids_schedule.SetItem(r,"next_start",ldt_next_time)
			else  //option to not reset
				//do not set next start
			end if
		end if
	ELSE  //using rerun on failure
		
		if is_comp_flag = 'Y' then
			choose case li_fail_cnt //num of attempts
				case 1   //if success on first attempt set next time
					ids_schedule.SetItem(r,"next_start",ldt_next_time)
					li_fail_cnt = 0 //(Appeon)Stephen 12.09.2015 - Bug id 4875 - Scheduler Resetting Time Incorrect
				case else
					ids_schedule.SetItem(r,"next_start", ids_schedule.GetItemDateTime(r, "org_run_time"))
					li_fail_cnt = 0
			end choose			
		else  //failure
			choose case li_fail_cnt //attempt
				case 1   //set the org time on the first fail
					//---------Begin Modified by (Appeon)Stephen 01.11.2016 for Bug id 4875 - Scheduler Resetting Time Incorrect--------
					//ids_schedule.SetItem(r,"org_run_time",ldt_next_time)	
					
					ldt_org_time = ids_schedule.GetItemDateTime(r, "next_start")
					ids_schedule.SetItem(r,"org_run_time",ldt_org_time)
					//---------End Modfiied ------------------------------------------------------
					
					ldt_next_time = of_next_run_time(li_fail_int, 1, today(), now())
					ids_schedule.SetItem(r,"next_start",ldt_next_time)
				case li_max_attempts //
					if li_reset_fail = 1 then  //reset the next on failure
						ids_schedule.SetItem(r,"next_start", ids_schedule.GetItemDateTime(r, "org_run_time"))
					else
						//don't reset the next run time
					end if
					li_fail_cnt = 0
				case else
					//messagebox("","setting next start on failure")
					ldt_next_time = of_next_run_time(li_fail_int, 1, today(), now())
					ids_schedule.SetItem(r,"next_start",ldt_next_time)
			end choose
		end if
	END IF
	
 //Start Code Change ----11.18.2015 #V15 maha	- removed.  The variable is reset further down in this code
//	   //---------Begin Added by (Appeon)Stephen 07.01.2015 for Bug # 4579 - Scheduler auto shutdown is not working case # 55316--------
//	if is_comp_flag = 'Y' or li_fail_cnt >= li_max_attempts then
//		lb_IsTimerStop = true
//	end if
//	//---------End Added ------------------------------------------------------	
 //End Code Change ----11.18.2015 		
		
			
			
//	//---------Begin Modified by (Appeon)Stephen 2013-06-26 for bug 3581--------
//	//ids_schedule.SetItem(r,"next_start",ldt_next_time)
//	//ids_schedule.SetItem(r,"last_run",ldt_run_time)
//	if is_comp_flag = 'Y' or li_reset_fail = 1 then //(Appeon)Stephen 06.23.2015 - Webcrawler set next schdule time on failure Case #55286
//		//---------Begin Modified by (Appeon)Stephen 07.14.2015 for  WebCrawler -- set next schedule time on failure --------
//		/*
//		if li_sched_type = 43 or li_sched_type = 41 then //OIG, WebCrawler
//			if ib_all then
//				ids_schedule.SetItem(r,"next_start",ldt_next_time)
//				ids_schedule.SetItem(r,"last_run",ldt_run_time)
//			else    
//				//---------Begin Commented by (Appeon)Stephen 05.31.2013 for  Webcrawler set next schdule time on failure Case #55286--------
//				/*
//				//Start Code Change ----04.30.2015 #V15 maha - reset option if some fail
//				if li_reset_fail = 1 then
//					ids_schedule.SetItem(r,"next_start",ldt_next_time)
//					ids_schedule.SetItem(r,"last_run",ldt_run_time)
//				else
//					//don't set
//				end if
//				*/
//			end if
//		else
//			ids_schedule.SetItem(r,"next_start",ldt_next_time)
//			ids_schedule.SetItem(r,"last_run",ldt_run_time)
//		end if
//		*/		
//		ids_schedule.SetItem(r,"next_start",ldt_next_time)
//		ids_schedule.SetItem(r,"last_run",ldt_run_time)
//		//---------End Modified ------------------------------------------------------
//	end if
//	
//    //---------Begin Added by (Appeon)Stephen 07.01.2015 for Bug # 4579 - Scheduler auto shutdown is not working case # 55316--------
//	if is_comp_flag = 'Y' or li_fail_cnt >= li_max_attempts then
//		lb_IsTimerStop = true
//	end if
//	//---------End Added ------------------------------------------------------
//	
////Start Code Change ----04.30.2015 #V15 maha - rerun failed reports
//	if is_comp_flag = 'N' and li_rerun_fail = 1 then
//		choose case li_fail_cnt //set above
//			case 1   //set the org time on the first fail
//				ids_schedule.SetItem(r,"org_run_time",ldt_next_time)
//				ldt_next_time = of_next_run_time(li_fail_int, 1, today(), now())
//				ids_schedule.SetItem(r,"next_start",ldt_next_time)
//			case li_max_attempts //
//				ids_schedule.SetItem(r,"next_start", ids_schedule.GetItemDateTime(r, "org_run_time"))
//				li_fail_cnt = 0
//			case else
//				ldt_next_time = of_next_run_time(li_fail_int, 1, today(), now())
//				ids_schedule.SetItem(r,"next_start",ldt_next_time)
//		end choose
//		
//		ids_schedule.SetItem(r,"last_run",ldt_run_time)
//			
//	else //successful or no rerun
//		//set in prior code block
//	end if	
 //End Code Change ----11.17.2015 
	//messagebox("li_fail_cnt",li_fail_cnt)
	//messagebox("ii_retry_time", ii_retry_time)
	ids_schedule.SetItem(r,"use_org_time",li_fail_cnt)  //set failed count
//End Code Change ----04.30.2015

	//set schedule log
	ls_imp_exp = of_get_impexp_nm(li_sched_type, li_imp_proj, li_imp_exp_opt) //get imp/exp name		
	of_log_schedule(li_sched_id, li_sched_type, ls_imp_exp, ldt_run_time, DateTime(Today(),Now()), ls_sched_msg, ll_proc_cnt)	
	yield()  //(Appeon)Stephen 11.15.2013 - Harvard Vanguard Scheduler Export Error
NEXT

//Update schedule log
of_log_save()

//update schedule settings
of_update_schedule()

//Start Code Change ----11.17.2015 #V15 maha - if highest retry is reached then reset for future runs
messagebox("ii_max_retries" ,ii_max_retries)
if ii_max_retries  = 0 then  //Start Code Change ----10.04.2016 #V152 maha
	lb_IsTimerStop = true
elseif ii_retry_time = ii_max_retries then 
	ii_retry_time = 0   
	lb_IsTimerStop = true
else
	lb_IsTimerStop = false
end if


	
w_auto_schedule.ib_ok_to_close = lb_IsTimerStop //(Appeon)Stephen 07.01.2015 - Bug # 4579 - Scheduler auto shutdown is not working case # 55316
if lb_IsTimerStop then Timer(60, w_auto_schedule) //Added by Evan 12.29.2011 --- for fix pb exception

RETURN 1

end function

public function integer of_run_aiq_exp_cred (ref string as_message, ref long al_proc_cnt);//run AIQ - Exp Cred --Nova 01.30.2010 - v10.1 Scheduler Functionality
Integer xtype

pfc_n_cst_ai_printletters lnv_exp_cred
lnv_exp_cred = Create pfc_n_cst_ai_printletters

xtype = of_get_app_setting("set_26","I")

Open(w_aiq_run)
IF IsValid(w_aiq_run) THEN w_aiq_run.st_1.Text = "Checking for Expiring Credential Verifications" //For checking validation modified by  Nova 08.27.2009

lnv_exp_cred.of_set_sched_flag(TRUE)
IF xtype = 1 THEN
	lnv_exp_cred.of_expiring_credentials_from_data()
ELSE
	lnv_exp_cred.of_expiring_credentials()
END IF

as_message = lnv_exp_cred.of_get_sched_msg( )
al_proc_cnt = lnv_exp_cred.of_get_sched_cnt( )

Destroy lnv_exp_cred
IF IsValid(w_aiq_run) THEN  Close(w_aiq_run)

RETURN 1


end function

public function integer of_run_aiq_emails (ref string as_message, ref long al_proc_cnt);//run AIQ - Emails --Nova 01.30.2010 - v10.1 Scheduler Functionality

IF gb_contract_module THEN
	n_cst_notification  lnvo_notification
	lnvo_notification =  Create n_cst_notification
	
	lnvo_notification.of_set_sched_flag( TRUE) 
	lnvo_notification.of_start_notification_process( )
	
	as_message = lnvo_notification.of_get_sched_msg( ) 
	al_proc_cnt = lnvo_notification.of_get_sched_cnt( ) 
	
	IF IsValid(lnvo_notification) THEN Destroy lnvo_notification
END IF

RETURN 1

end function

public function integer of_run_aiq_exp_appoint (ref string as_message, ref long al_proc_cnt);//run AIQ - Exp Appoint --Nova 01.30.2010 - v10.1 Scheduler Functionality

pfc_n_cst_ai_printletters lnv_exp_cred
lnv_exp_cred = Create pfc_n_cst_ai_printletters

Open(w_aiq_run)

IF IsValid(w_aiq_run) THEN w_aiq_run.st_1.Text = "Checking for Expiring Credential Verifications" //For checking validation modified by  Nova 08.27.2009

lnv_exp_cred.of_set_sched_flag( TRUE)
lnv_exp_cred.of_expiring_appointments( )

as_message = lnv_exp_cred.of_get_sched_msg( )
al_proc_cnt = lnv_exp_cred.of_get_sched_cnt( )

Destroy lnv_exp_cred

IF IsValid(w_aiq_run) THEN  Close(w_aiq_run)

RETURN 1


end function

public function integer of_run_aiq_notifications (ref string as_message, ref long al_proc_cnt);//run AIQ - Notifications --Nova 01.30.2010 - v10.1 Scheduler Functionality

n_cst_notification_alert lnv_notification_alert

lnv_notification_alert = Create n_cst_notification_alert
//debugbreak()
lnv_notification_alert.of_set_sched_flag(TRUE) 
lnv_notification_alert.of_Run()

as_message  = lnv_notification_alert.of_get_sched_msg() 
al_proc_cnt = lnv_notification_alert.of_get_sched_cnt() 

Destroy lnv_notification_alert

return 1

end function

public function integer of_run_aiq_print_reset (ref string as_message, ref long al_proc_cnt);//run AIQ - Print Reset --Nova 01.30.2010 - v10.1 Scheduler Functionality

pfc_n_cst_ai_printletters lnv_exp_cred
lnv_exp_cred = Create pfc_n_cst_ai_printletters

Open(w_aiq_run)
IF IsValid(w_aiq_run) THEN w_aiq_run.st_1.Text = "Checking for Expiring Credential Verifications" //For checking validation modified by  Nova 08.27.2009

lnv_exp_cred.of_set_sched_flag( TRUE)
lnv_exp_cred.of_resend_letters()
as_message = lnv_exp_cred.of_get_sched_msg( )
al_proc_cnt = lnv_exp_cred.of_get_sched_cnt( )

Destroy lnv_exp_cred
IF IsValid(w_aiq_run) THEN  Close(w_aiq_run)

RETURN 1



end function

public function integer of_run_aiq_workflow (ref string as_message, ref long al_proc_cnt);//run AIQ - WorkFlow --Nova 01.30.2010 - v10.1 Scheduler Functionality

n_cst_workflow_triggers	lnv_workflow
lnv_workflow = Create n_cst_workflow_triggers

lnv_workflow.of_set_sched_flag( TRUE)  
lnv_workflow.of_reminder_mail_process()
as_message = lnv_workflow.of_get_sched_msg() 
al_proc_cnt = lnv_workflow.of_get_sched_cnt()  

Destroy n_cst_workflow_triggers

return 1

end function

public function integer of_run_caqh_import (string as_file_path, ref string as_message, ref long al_proc_cnt);//run CAQH File Import --Nova 01.30.2010 - v10.1 Scheduler Functionality
//modified by alfee 03.17.2010

Integer i, ck, res, ok, no, ex
Integer li_parent, li_audit, li_verif
Long ll_facil, ll_app, ll_verif, ll_row_rtn
String ls_filename, ls_proc_path, ls_msg, ls_files[]
String ls_type, ls_affil, ls_parent
Boolean lb_p = True
Boolean lb_t = True

n_cst_message lnv_message
n_cst_caqh_import lnv_caqh
datastore lds_map_fields
datastore lds_set_default

lds_map_fields = Create datastore
lds_map_fields.DataObject = "d_caqh_mapping_fields"
lds_map_fields.SetTransObject( sqlca)

lds_set_default = Create datastore
lds_set_default.DataObject = "d_caqh_defaults"
lds_set_default.SetTransObject(sqlca)

IF lds_map_fields.RowCount() = 0 THEN
	res = lds_map_fields.Retrieve()
	IF res < 1 THEN
		as_message = lnv_message.of_get_message("Error","Failed to retrieve mapping data; unable to continue import" )
		Destroy lds_map_fields
		Destroy lds_set_default		
		RETURN -1
	END IF
END IF

lnv_caqh = Create n_cst_caqh_import
lnv_caqh.of_set_sched_flag(TRUE)

//
ll_row_rtn = lds_set_default.Retrieve( )
IF ll_row_rtn = 0 THEN
	IF gs_cust_type = "I" THEN  
		li_parent = 1
		li_audit = 1
		li_verif = 1
	ELSE
		as_message = lnv_message.of_get_message("Error","There is no a default setting for CAQH Import, please define it in the Utilities first." )
		Destroy lnv_caqh
		Destroy lds_map_fields
		Destroy lds_set_default		
		RETURN -1
		/* SELECT default_search_facility Into :ll_facil From security_users Where user_id = :gs_user_id;
		IF ll_facil > 0 THEN 
			SELECT facility_name, default_audit_temp, default_verif_facility Into :ls_parent , :ll_app, :ll_verif From facility Where facility_id = :ll_facil;
		END IF
		li_parent = ll_facil
		li_audit = ll_app
		li_verif = ll_verif */
	END IF
	ls_type = "I"
	ls_affil = "M"
	lb_p = True
	lb_t = True
ELSE
	li_parent = lds_set_default.GetItemNumber(1,"parent_id")
	IF li_parent > 0 THEN
		SELECT facility_name Into :ls_parent From facility Where facility_id = :li_parent;
   END IF
	li_audit = lds_set_default.GetItemNumber(1,"template_id")
	li_verif = lds_set_default.GetItemNumber(1,"verify_id")
	ls_type = lds_set_default.GetItemString(1,"app_type")
	ls_affil = lds_set_default.GetItemString(1,"affil_stat")
	IF lds_set_default.GetItemNumber(1,"set_title") = 1 THEN
		lb_p = True
	ELSE
		lb_p = False
	END IF
	IF lds_set_default.GetItemNumber(1,"set_prov_id") = 1 THEN
		lb_t = True
	ELSE
		lb_t = False
	END IF
END IF
//
lnv_caqh.of_set_appt_defaults(li_parent, li_audit, li_verif, ls_type, ls_affil, ls_parent, lb_p, lb_t)

//Get caqh xml file list 
IF IsValid(ilb_1) THEN
	ilb_1.DirList ( as_file_path + "*.xml", 0)
	FOR i = 1 To ilb_1.TotalItems()
		ls_files[i] = ilb_1.Text(i)
	NEXT
END IF

//Open the CAQH window 
IF UpperBound(ls_files) > 0 and NOT IsValid(w_caqh_xml_read) THEN
	 OpenWithParm(w_caqh_xml_read, 'invisible')
END IF
	
//Loop for each file
FOR i= 1 to	UpperBound(ls_files)
	ls_filename = ls_files[i]
	IF PosA(ls_filename, "ExtractIndex", 1) > 0 THEN CONTINUE 
	ls_proc_path =  as_file_path + "Processed\" + ls_filename
	ls_filename = as_file_path  + ls_filename
	//import xml file
	res = lnv_caqh.of_import_xml(ls_filename,i) 
	//
	IF res = 1 THEN //processed
		ok++
		ck = FileCopy ( ls_filename,ls_proc_path  ,True )
		IF ck = 1 THEN FileDelete ( ls_filename)
	ELSEIF res = 0 THEN //skipped
		ex++
		ck = FileCopy ( ls_filename, ls_proc_path ,True )
		IF ck = 1 THEN FileDelete ( ls_filename)
	ELSE //failed
		no++
	END IF	
NEXT

al_proc_cnt = ok + no + ex
IF no > 0 then
	ls_msg = lnv_message.of_get_message("CAQH Import", "Process Complete: " + String(ok) + " files imported; " + String(no) + " files failed; " + String(ex) + " provider exists;")
	as_message = lnv_caqh.of_get_sched_msg( )
	as_message += ls_msg
END IF

IF IsValid(w_caqh_xml_read) THEN Close(w_caqh_xml_read) 
		
Destroy lnv_caqh
Destroy lds_map_fields
Destroy lds_set_default

RETURN 1




end function

public function integer of_run_export (integer ai_sched_id, ref string as_message, ref long al_proc_cnt);//run Export --Nova 01.30.2010 - v10.1 Scheduler Functionality

Long prac_ids[]
String ls_presentation_str
String ls_sny_retrieve
String ls_dwsyntax_str
String ERRORS
String ls_path
string ls_param1 = ""  //maha 09.10.2014
string ls_name //maha 07.25.2016
Long ll_prac_row
long li_suc_pos //maha 09.08.2014
n_ds lds_export_retrieve
Long ll_export_id, ll_found
long ll_log  //maha 06.06.2016
Integer i
Integer li_export_type
datetime ldt_success //maha 09.08.2014
n_cst_message lnv_message

if ids_schedule.rowcount() < 1 then ids_schedule.Retrieve()
ll_found = ids_schedule.Find("sched_id = " + String(ai_sched_id), 1, ids_schedule.RowCount())
IF ll_found < 1 THEN RETURN -1

ls_sny_retrieve = ids_schedule.GetItemString(ll_found,"retrieve_query")
ls_path = ids_schedule.GetItemString(ll_found,"file_path")
ll_export_id = ids_schedule.GetItemNumber(ll_found,"imp_exp_option")

//Start Code Change ----09.08.2014 #V14.2 maha - set query based on last success date
li_suc_pos = pos(ls_sny_retrieve, "@lastsuccess@", 1) 
if li_suc_pos > 0 then
	ldt_success = ids_schedule.getitemdatetime( ll_found,"last_success")
	if isnull(ldt_success) then ldt_success = datetime(date('2014-01-01'), time('00:00:00'))
	ls_sny_retrieve = mid(ls_sny_retrieve,1,li_suc_pos - 1) + "'" + string(ldt_success,'yyyy-mm-dd hh:mm:ss') + "'" + mid(ls_sny_retrieve,li_suc_pos + 13) 
	ls_param1 = string(ldt_success,'yyyy-mm-dd hh:mm:ss')  //Start Code Change ----09.10.2014 #V14.2 maha
end if

//messagebox('ls_sny_retrieve',ls_sny_retrieve)
//Start Code Change ----09.08.2014


ls_presentation_str = "style(type=grid)"
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	as_message = lnv_message.of_get_message("Caution","SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF
lds_export_retrieve = Create n_ds
//---------Begin Modified by (Appeon)Stephen 11.11.2015 for Bug id 4841 - Export is failing V14.2 SAAS Build 7/29/2015--------
//lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
i = lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
if i <> 1 then
	as_message = lnv_message.of_get_message("Caution","Create datastore caused these errors: " + ERRORS)
	RETURN -1
end if
//---------End Modfiied ------------------------------------------------------

lds_export_retrieve.SetTransObject( SQLCA )

String ls_datatype
string  ls_coltype, ls_colname //(Appeon)Stephen 2013-09-11 - bug 3655
ls_datatype = lds_export_retrieve.Describe( "#1" + ".coltype")
ls_colname = lds_export_retrieve.Describe( "#1" + ".name") //(Appeon)Stephen 2013-09-11 - bug 3655
ls_coltype   = ls_datatype  //(Appeon)Stephen 2013-09-11 - bug 3655

CHOOSE CASE LeftA (ls_datatype,5)
	CASE "char(","char"
		ls_datatype = "C"
	CASE "date","datet","time","times"
		ls_datatype = "D"
	CASE "decim","numbe","doubl","real","long","ulong","int"
		ls_datatype = "N"
END CHOOSE

IF ls_datatype <> "N" THEN
	//---------Begin Commented by (Appeon)Stephen 05.31.2013 for bug 3655--------
	//as_message = lnv_message.of_get_message("Caution","SyntaxFromSQL caused these errors: " + ls_sny_retrieve)
	as_message = lnv_message.of_get_message("Caution","The first column must be numeric ("+ls_colname+"="+ls_coltype+"); SyntaxFromSQL caused these errors: " + ls_sny_retrieve)
	//---------End Commented ------------------------------------------------------
	RETURN -1
END IF

gnv_appeondb.of_startqueue()
lds_export_retrieve.Retrieve()

SELECT export_header.export_type
	INTO :li_export_type
	FROM export_header
	Where export_header.export_id = :ll_export_id ;
gnv_appeondb.of_commitqueue()

ll_prac_row = lds_export_retrieve.RowCount()
IF ll_prac_row < 1 THEN
	RETURN -2 
END IF

lds_export_retrieve.SetSort( "#1 A")
lds_export_retrieve.Sort()

FOR i = 1 To ll_prac_row
	prac_ids[i] = lds_export_retrieve.GetItemNumber(i,1)
NEXT

pfc_n_cst_ai_export_apb  lnv_export
lnv_export = Create pfc_n_cst_ai_export_apb

//il_export_id = ll_export_id
lnv_export.of_set_sched_flag(TRUE)
//IF li_export_type = 3 Or li_export_type = 4 THEN

select export_name into :ls_name from export_header where export_id = :ll_export_id;  //Start Code Change ----07.25.2016 #V152 maha
ll_log = of_log_sys_report("E","SCH","", ll_export_id, ls_name )  //Start Code Change ----06.06.2016 #V152 maha

IF li_export_type = 3 Or li_export_type = 4 Or li_export_type = 6 THEN //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)  //Start Code Change ----09.10.2014 #V14.2 maha - added param variable
	lnv_export.of_export_data_with_text_ctx( ll_export_id, prac_ids,ls_path,0 ,ls_param1,"","",1,ls_sny_retrieve)
ELSE
	lnv_export.of_export_data_with_text( ll_export_id, prac_ids,ls_path,0 ,ls_param1,"","",1,ls_sny_retrieve)  //Start Code Change ----09.10.2014 #V14.2 maha - added param variable
END IF
as_message = lnv_export.of_get_sched_msg( )
al_proc_cnt = lnv_export.of_get_sched_cnt( )

of_log_sys_report_end( ll_log, gl_export_rows_count, "")  //Start Code Change ----06.06.2016 #V152 maha

Destroy lds_export_retrieve
Destroy lnv_export

RETURN 1



end function

public function integer of_run_import (integer ai_sched_id, ref string as_message, ref long al_proc_cnt);//run Import --Nova 01.30.2010 - v10.1 Scheduler Functionality
Integer li_Return
Long ll_FindRow
Long ll_import_id
Long ll_proejct_id
Long ll_isoft_module
n_cst_import lnv_import

// Get import information
if ids_schedule.rowcount() < 1 then ids_schedule.retrieve()
ll_FindRow = ids_schedule.Find("sched_id=" + String(ai_sched_id), 1, ids_schedule.RowCount())
IF ll_FindRow <= 0 THEN RETURN -1
ll_import_id = ids_schedule.GetItemNumber(ll_FindRow, "imp_exp_option")
ll_proejct_id = ids_schedule.GetItemNumber(ll_FindRow, "imp_project")

//---------Begin Added by (Appeon)Stephen 12.30.2013 for V141 Import Modifications for Facility and Group--------
ii_pro_step = 0
ii_pro_step = ids_schedule.GetItemNumber(ll_FindRow, "imp_pro_step") 
//---------End Added ------------------------------------------------------

// Run import
IF ll_proejct_id > 0 THEN
	// Run import of project
	li_Return = of_run_project(ll_proejct_id, as_message, al_proc_cnt)
ELSEIF ll_import_id > 0 THEN
	// Get import type
	SELECT isoft_module Into :ll_isoft_module From import_hdr Where import_id = :ll_import_id;
	IF IsNull(ll_isoft_module) Or ll_isoft_module <= 0 THEN RETURN -1
	
	// Run import according to import type
	IF ll_isoft_module = 1 THEN // IntelliCred/App import
		lnv_import = Create n_cst_import_credapp
	//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
     elseIF ll_isoft_module = 3 THEN // facility/group
		lnv_import = Create n_cst_import_faci
	//---------End Added ------------------------------------------------------
	ELSE								// IntelliContract import
		lnv_import = Create n_cst_import_contract
	END IF		
	lnv_import.of_set_sched_flag(TRUE)	
	if ii_pro_step = 1 then lnv_import.ib_pro_steps = true //(Appeon)Stephen 12.26.2013 - V141 Import Modifications for Facility and Group
	li_Return = lnv_import.of_Execute(ll_import_id, False)
	as_message = lnv_import.of_get_sched_msg( )
	al_proc_cnt = lnv_import.of_get_sched_cnt( )	
	
	Destroy lnv_import
END IF

IF IsValid(w_import_progressbar) THEN Close(w_import_progressbar)

RETURN li_Return


end function

public function integer of_run_project (long al_project_id, ref string as_message, ref long al_proc_cnt);//run Import(project) --Nova 01.30.2010 - v10.1 Scheduler Functionality
Long ll_import_id
Long i, ll_RowCount
DataStore lds_data
n_cst_import lnv_import

lds_data  = Create DataStore
lds_data.DataObject = "d_import_ds_project"
lds_data.SetTransObject(SQLCA)
ll_RowCount = lds_data.Retrieve(al_project_id)
IF ll_RowCount <= 0 THEN RETURN -1

// Run imports associate with specify project.
FOR i = 1 To ll_RowCount
	ll_import_id = lds_data.Object.import_id[i]
	IF lds_data.Object.isoft_module[i] = 1 THEN 	// IntelliCred/App import
		lnv_import = Create n_cst_import_credapp
	//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
	elseif lds_data.Object.isoft_module[i] = 3 THEN
		lnv_import = Create n_cst_import_faci
	//---------End Added ------------------------------------------------------
	ELSE														// IntelliContract import
		lnv_import = Create n_cst_import_contract
	END IF
	
	if ii_pro_step = 1 then lnv_import.ib_pro_steps = true //(Appeon)Stephen 12.26.2013 - V141 Import Modifications for Facility and Group
	lnv_import.of_set_sched_flag(TRUE)	
	lnv_import.of_Execute(ll_import_id, False)
	as_message += lnv_import.of_get_sched_msg( )	
	al_proc_cnt += lnv_import.of_get_sched_cnt( )
	
	Destroy lnv_import
NEXT

Destroy lds_data
IF IsValid(w_import_progressbar) THEN Close(w_import_progressbar)

RETURN 1


end function

public function integer of_run_report (string as_sql, string as_save_path, string as_extend, ref string as_message, ref long al_proc_cnt);//run Report --Nova 01.30.2010 - v10.1 Scheduler Functionality
Long ll_cnt
long ll_log  //maha 06.06.2016
String ls_sql
String ls_presentation_str
String ls_dwsyntax_str
String ERRORS
String ls_extend
integer li_ok


datastore ds_report
n_cst_message lnv_message

ds_report = Create datastore

IF PosA(Upper(Trim(as_sql)),"SELECT",1) = 1 THEN
	//CREATE SYNTAX FOR export DW
	ls_presentation_str = "style(type=grid)"
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(as_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		IF PosA(ERRORS,"Table or view not found",1) > 0 THEN
			as_message = lnv_message.of_get_message("syntax error","Table not found (should have  prefix)")
		ELSE
			as_message = lnv_message.of_get_message("Caution","SyntaxFromSQL caused these errors: " + ERRORS)
		END IF
		RETURN -1
	END IF
	
	ds_report.Create( ls_dwsyntax_str, ERRORS)
	ds_report.SetTransObject( SQLCA )

//Start Code Change ----06.06.2016 #V152 maha

	ll_log = of_log_sys_report("Q","SCH","",il_id_for_log, is_rpt_name )  //Start Code Change ----07.25.2016 #V152 maha = added parameter
	al_proc_cnt = ds_report.Retrieve()
	of_log_sys_report_end( ll_log, al_proc_cnt, "") 
//Start Code Change ----06.06.2016 #V152 maha	


	//---------Begin Added by (Appeon)Stephen 12.31.2015 for Bug id 4858 - Scheduler Not Responding--------
	if al_proc_cnt < 0 then
		as_message = lnv_message.of_get_message("Caution", "Database Error:" + sqlca.sqlerrtext)
		destroy ds_report
		return -1
	end if		
	//---------End Added ------------------------------------------------------
	
	CHOOSE CASE Trim(as_extend)
		CASE  'Excel5!'
			ls_extend = ".xls"
			li_ok = ds_report.SaveAs(as_save_path+ls_extend,Excel5!, True) //Start Code Change ----04.12.2010 #V10 maha - changed to include header row
		CASE  'Excel8!'
			ls_extend = ".xls"
			li_ok = ds_report.SaveAs(as_save_path+ls_extend,Excel8!, True) //Start Code Change ----08.05.2011 #V11 maha - added, but now currently available in program
		CASE  'Excel!'
			ls_extend = ".xls"
			li_ok = ds_report.SaveAs(as_save_path+ls_extend,Excel!, True) //Start Code Change ----08.05.2011 #V11 maha - added, but now currently available
		CASE  'Text!'
			ls_extend = ".txt"
			li_ok = ds_report.SaveAs(as_save_path+ls_extend,Text!, True) //04.12.2010 #V10 maha
		CASE  'CSV!'
			ls_extend = ".csv"
			IF AppeonGetClientType() = 'PB' THEN
				li_ok = ds_report.SaveAs(as_save_path+ls_extend,CSV!, True) //04.12.2010 #V10 maha
			END IF
		CASE  'HTMLTable!'
			ls_extend = ".html"
			li_ok = ds_report.SaveAs(as_save_path+ls_extend,HTMLTable!, True) //04.12.2010 #V10 maha
		CASE  'XML!'
			ls_extend = ".xml"
			IF AppeonGetClientType() = 'PB' THEN
				li_ok = ds_report.SaveAs(as_save_path+ls_extend,XML!, True) //04.12.2010 #V10 maha
			END IF
		CASE  'PDF!'
			ls_extend = ".pdf"
			//--------Begin Modified by  Nova 04.27.2010------------------------
			//IF AppeonGetClientType() = 'PB' THEN
			//		ds_report.SaveAs(as_save_path+ls_extend,PDF!, true)
			//ELSE
			//	IF ds_report.Object.DataWindow.Print.Filename <> "" THEN ds_report.Object.DataWindow.Print.Filename = ""
			//	f_savedatastore(ds_report , as_save_path+ls_extend, '')
			// ds_report.Object.DataWindow.Print.Filename = as_save_path+ls_extend
			//END IF
			appeon_pdfservice lnv_pdf
			lnv_pdf = Create appeon_pdfservice
			li_ok = lnv_pdf.of_Print(ds_report, as_save_path+ls_extend)
			Destroy lnv_pdf
			//--------End Modified --------------------------------------------
		CASE ELSE
			/*statementblock*/
	END CHOOSE
END IF

//Start Code Change ----10.04.2016 #V152 maha - set failure for report
if li_ok < 1 then
	as_message = lnv_message.of_get_message("Report Error","File not saved; check file path and permissions")
	return -1
end if

RETURN 1






end function

public function integer of_test_item (integer ai_sched_id);//Test on a schedule item - Nova 01.30.2010 - v10.1 Scheduler Functionality
//Reorganized by Alfee 02.05.2010

Integer r, li_rc, li_imp_proj, li_imp_exp_opt  
Integer li_sched_int, li_sched_type, li_sched_id
Long ll_proc_cnt
String ls_current_dt, ls_sched_dt, ls_error_code, ls_sched_msg, ls_imp_exp
DateTime ldt_run_time, ldt_next_time, ldt_sched_time

li_rc = ids_schedule.RowCount()
IF li_rc < 1 THEN RETURN -1

r = ids_schedule.Find("sched_id = " + String(ai_sched_id), 1, ids_schedule.rowcount())
IF IsNull(r) OR r < 1 THEN RETURN -1

//Get current datetime
//ls_current_dt = String(Today(),'yyyy/mm/dd') + Space(1) + String(Now(),'hh:mm:00')

//initialize variables
li_sched_id = ai_sched_id
li_sched_type = ids_schedule.GetItemNumber( r, "sched_type")
ldt_sched_time = ids_schedule.GetItemDateTime(r, "next_start")
li_sched_int = ids_schedule.GetItemNumber(r, "interval_type")
li_imp_proj	= ids_schedule.GetItemNumber(r, "imp_project")
li_imp_exp_opt = ids_schedule.GetItemNumber(r, "imp_exp_option")	
il_rows_limited = ids_schedule.GetItemNumber(r, "rows_limited")	 //(Appeon)Stephen 2013-06-25 - Bug 3581
il_id_for_log =  li_sched_id   //(Appeon)Added by Harry 07.26.2016 - BugH070505
ll_proc_cnt = 0
ls_error_code = '' 
ls_sched_msg = ''

ldt_run_time = DateTime(Today(),Now())

//run the scheduled task
CHOOSE CASE li_sched_type
	CASE 10 //Import
		of_run_import(li_sched_id, ls_sched_msg, ll_proc_cnt)
	CASE 20 //Export
		of_run_export(li_sched_id, ls_sched_msg, ll_proc_cnt)
		IF ids_schedule.GetItemNumber( r, "export_reset_audit") = 1 THEN //??
			UPDATE sys_audit Set exported = 0, export_date = :ldt_run_time  Where exported = 1 And date_time_modified <= :ldt_run_time;
			COMMIT Using sqlca;
		END IF
	CASE 31 //AIQ - Exp Cred
		Of_run_aiq_exp_cred(ls_sched_msg, ll_proc_cnt)
	CASE 32 //AIQ - Exp Appoint
		Of_run_aiq_exp_appoint(ls_sched_msg, ll_proc_cnt)
	CASE 33 //AIQ - Print Reset
		Of_run_aiq_print_reset(ls_sched_msg, ll_proc_cnt)
	CASE 34 //AIQ - WorkFlow
		Of_run_aiq_workflow(ls_sched_msg, ll_proc_cnt)
	CASE 35 //AIQ - Emails
		Of_run_aiq_emails(ls_sched_msg, ll_proc_cnt)
	CASE 36 //AIQ - Notifications
		Of_run_aiq_notifications(ls_sched_msg, ll_proc_cnt)
	CASE 37	//AIQ Pending Change added by  long.zhang 11.01.2013 (V14.1Group Location Effective Dates)
		of_run_aiq_pendingchange(ls_sched_msg,ll_proc_cnt)		
	CASE 41 //Verifi - OIG
		of_run_verify_scan_oig(li_sched_id, ls_sched_msg, ll_proc_cnt)
	CASE 4201 //Verif - NPDB Send
		of_run_verify_npdb(li_sched_id, 2, ls_sched_msg, ll_proc_cnt)
	CASE 4202 //Verif - NPDB Receive
		of_run_verify_npdb(li_sched_id, 1, ls_sched_msg, ll_proc_cnt)
	CASE 43 //Verif - Web Crawler
		of_run_verify_webcrawler(li_sched_id, ls_sched_msg, ll_proc_cnt)
	CASE 50 //CAQH File Import
		of_run_caqh_import(ids_schedule.GetItemString(r, "file_path"), ls_sched_msg, ll_proc_cnt)
	CASE 53 //CAQH Roster File Import-Return Roster File, Added by Appeon long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
		of_run_caqh_roster_import('LIST', ls_sched_msg, ll_proc_cnt)
	CASE 54 //CAQH Roster File Import-Roster Exception File, Added by Appeon long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
		of_run_caqh_roster_import('EXCEPTION', ls_sched_msg, ll_proc_cnt)
	CASE 60 //Report
		is_rpt_name = ids_schedule.GetItemString(r, "sched_name")
		of_run_report(ids_schedule.GetItemString(r, "retrieve_query"), ids_schedule.GetItemString(r, "file_path"), ids_schedule.GetItemString(r, "report_format"), ls_sched_msg, ll_proc_cnt)
	case 70  //(Appeon)Stephen 04.22.2014 - V142 Schedule IntelliReport
		of_run_intellireport(li_sched_id, ls_sched_msg, ll_proc_cnt)
END CHOOSE

//refresh schedule setting
//ldt_next_time = of_next_run_time(ids_schedule.GetItemNumber(r,"interval_length"), li_sched_int, Date(ldt_sched_time), Time(ldt_sched_time))	
//ids_schedule.SetItem(r,"next_start",ldt_next_time)
ids_schedule.SetItem(r,"last_run",ldt_run_time)

IF LenA(ls_sched_msg) = 0 THEN 
	ids_schedule.SetItem(r,"last_success",ldt_run_time)
	ls_error_code = 'Successful.'
	ls_sched_msg = ls_error_code
	is_comp_flag = 'Y' //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
ElseIf  li_sched_type = 10 And of_is_no_data_error(ls_sched_msg) Then //Import with no data, Added by Appeon long.zhang 10.30.2015 (Scheduler reports failure when an import points to a file with no data)
	ls_error_code = 'No data'
	is_comp_flag = 'N'
ELSE 
	ls_error_code = 'Failure.'
	is_comp_flag = 'N' //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600
END IF
ls_sched_msg = 'Test - ' + ls_sched_msg //for test item
ids_schedule.SetItem(r,"error_code",ls_error_code)

//set schedule log
ls_imp_exp = of_get_impexp_nm(li_sched_type, li_imp_proj, li_imp_exp_opt) //get imp/exp name		
of_log_schedule(li_sched_id, li_sched_type, ls_imp_exp, ldt_run_time, DateTime(Today(),Now()), ls_sched_msg, ll_proc_cnt)		

//Update schedule log
of_log_save()

//update schedule settings
of_update_schedule()

RETURN 1

end function

public function string of_set_filter (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, ref datastore ad_ds);//Copied and modified from w_oig_on_demand - Nova 01.30.2010

long i
long ic
long r
long rc
integer p
string lname
string fname
string syear
string smonth
string sday
date d_dob
string dob
string ls_where 
n_cst_string ln_string

lname = upper(ad_ds.getitemstring(ai_row,"last_name"))
p = PosA(lname,"'",1) 
if p > 0 then
	lname = MidA(lname,1,p - 1) + "'" + MidA(lname,p )
end if
p = PosA(fname,"'",1) 
if p > 0 then
	lname = MidA(fname,1,p - 1) + "'" + MidA(fname,p  )
end if

fname = upper(ad_ds.getitemstring(ai_row,"first_name"))
if isnull(fname) then fname = ""
lname = ln_string.of_globalreplace(lname, "''", "'", False)
lname = ln_string.of_globalreplace(lname, '"', '', False)
fname = ln_string.of_globalreplace(fname, "''", "'", False)
fname= ln_string.of_globalreplace(fname, '"', '', False)
d_dob = date(ad_ds.getitemdatetime(ai_row,"date_of_birth"))
syear = MidA(string(year(d_dob)),3,2)
smonth = string(month(d_dob))
sday = string(day(d_dob))
if LenA(smonth) = 1 then smonth = "0" + smonth
if LenA(sday) = 1 then sday = "0" + sday

dob = smonth + "/" + sday + "/" + syear
if isnull(dob) then dob = ""
if ai_lname = 1 and ai_fname = 1 and ai_dob = 1 then
	ls_where = ls_where + ' upper(lastname) = "' + lname + '" and upper(firstname) = "' + fname + '" and dob = "' + dob + '"'
elseif ai_lname = 1 and ai_fname = 1 then
	ls_where = ls_where + ' upper(lastname) = "' + lname + '" and upper(firstname) = "' + fname + '"'
elseif ai_lname = 1 and ai_dob = 1 then
	ls_where = ls_where + ' upper(lastname) = "' + lname + '" and dob = "' + dob + '"'
elseif ai_fname = 1 and ai_dob = 1 then
	ls_where = ls_where + ' upper(firstname) = "' + fname + '" and dob = "' + dob + '"'
elseif ai_lname = 1 then
	ls_where = ls_where + ' upper(lastname) = "' + lname + '"'
elseif ai_fname = 1 then
	ls_where = ls_where + ' upper(firstname) = "' + fname + '"'
elseif ai_dob = 1 then
	ls_where = ls_where + " dob = '" + dob + "'"
else //never be executed by scheduler
	messagebox("Select Criteria","No match criteria was selected")
	return "Fail"
end if

return ls_where

end function

public function string of_set_where (integer ai_row, integer ai_lname, integer ai_fname, integer ai_dob, ref datastore ad_ds);//Copied and modified from w_oig_on_demand - Nova 01.30.2010

Integer p
String lname
String fname
String syear
String smonth
String sday
Date d_dob
String dob


n_cst_string ln_string

String ls_where = " ("


lname = Upper(ad_ds.GetItemString(ai_row,"last_name"))

p = PosA(lname,"'",1)
IF p > 0 THEN
	lname = MidA(lname,1,p - 1) + "'" + MidA(lname,p )
END IF
p = PosA(fname,"'",1)
IF p > 0 THEN
	lname = MidA(fname,1,p - 1) + "'" + MidA(fname,p  )
END IF

fname = Upper(ad_ds.GetItemString(ai_row,"first_name"))
IF IsNull(fname) THEN fname = ""

lname = ln_string.of_globalreplace(lname, "''", "'", False)
lname = ln_string.of_globalreplace(lname, "'", "''", False)
lname = ln_string.of_globalreplace(lname, '"', '', False)

fname = ln_string.of_globalreplace(fname, "''", "'", False)
fname = ln_string.of_globalreplace(fname, "'", "''", False)
fname = ln_string.of_globalreplace(fname, '"', '', False)


d_dob = Date(ad_ds.GetItemDateTime(ai_row,"date_of_birth"))
syear = MidA(String(Year(d_dob)),3,2)
smonth = String(Month(d_dob))
sday = String(Day(d_dob))
IF LenA(smonth) = 1 THEN smonth = "0" + smonth
IF LenA(sday) = 1 THEN sday = "0" + sday

dob = smonth + "/" + sday + "/" + syear
IF IsNull(dob) THEN dob = ""

IF ai_lname = 1 And ai_fname = 1 And ai_dob = 1 THEN
	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and upper(oig_data.firstname) = '" + fname + "' and oig_data.dob = '" + dob + "'"
ELSEIF ai_lname = 1 And ai_fname = 1 THEN
	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and upper(oig_data.firstname) = '" + fname + "'"
ELSEIF ai_lname = 1 And ai_dob = 1 THEN
	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "' and oig_data.dob = '" + dob + "'"
ELSEIF ai_fname = 1 And ai_dob = 1 THEN
	ls_where = ls_where + " upper(oig_data.firstname) = '" + fname + "' and oig_data.dob = '" + dob + "'"
ELSEIF ai_lname = 1 THEN
	ls_where = ls_where + " upper(oig_data.lastname) = '" + lname + "'"
ELSEIF ai_fname = 1 THEN
	ls_where = ls_where + " upper(oig_data.firstname) = '" + fname + "'"
ELSEIF ai_dob = 1 THEN
	ls_where = ls_where + " oig_data.dob = '" + dob + "'"
ELSE //never be executed by scheduler
	
	MessageBox("Select Criteria","No match criteria was selected")
	RETURN "Fail"
END IF


ls_where += ") "


RETURN ls_where

end function

public function string of_error_message (integer ai_mes);//Test database is connected --Nova 01.30.2010 - v10.1 Scheduler Functionality
string ls_mes

choose case ai_mes
	case 3
		ls_mes = "Not found on Site"
	case -10
		ls_mes = "Error retrieving Verification Data"
	case -20
		ls_mes = "Error retrieving Web Crawler"
	case -30
		ls_mes = "Crawler requires a password"
	case -40
		ls_mes = "Error retrieving crawler steps"
	case -901
		ls_mes = "Error building Crawler macro "
	case -902
		ls_mes = "Failed to connect to InternetMacros program"
	case -903
		ls_mes = "Crawler Failed on website"
	case -904
		ls_mes = "_ResultPage.htm file was not created"
	case else
		ls_mes = ""
end choose 

return ls_mes
end function

public function integer of_run_verify_webcrawler (integer ai_sched_id, ref string as_message, ref long al_proc_cnt);//Run Verif - Web Crawler --Nova 01.30.2010 - v10.1 Scheduler Functionality
//Reorganized by Alfee 02.06.2010

Integer li_status, li_facility_id
Long i, li_rc, ll_RowCount, li_wc_id, ll_prac_id
String ls_doc_id, ls_note, ls_ret, ls_Syntax, ls_ErrorText
String ls_verif_msg, ls_msg
Boolean lb_show, lb_crawler, lb_successful = TRUE
long  ll_rec_id
long  ll_rows

str_web_crawler lstr_web_crawler
n_cst_message lnv_message

//Check if WEB Crawl is enabled
IF of_get_app_setting("web_crawl","I") = 1 THEN 
	lb_crawler = True
END IF

//Get doc ids to verify
of_set_verif_filter(idw_verif,'web',0) //Dynamic set verify dw's sql
ll_RowCount = idw_verif.Retrieve()

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.14.2015
//<$>reason:Allegheny Scheduler
//IF ll_RowCount <= 0 THEN RETURN 0
IF ll_RowCount = 0 THEN 
	RETURN 0
Elseif ll_RowCount < 0 THEN 
	as_message = "Error: Failed to retrieve verification(s)."
	RETURN -1
End If
//------------------- APPEON END -------------------

//---------Begin ADD by (Appeon)Stephen 2013-06-25 for Bug 3581--------
ib_all = false
if isnull(il_rows_limited) or il_rows_limited = 0 then il_rows_limited = 5000
if il_rows_limited > 5000 then il_rows_limited = 5000
if idw_verif.RowCount() <= il_rows_limited then
	ll_rows = idw_verif.RowCount()
	ib_all = true
else
	ll_rows = il_rows_limited
end if
//---------End ADD ------------------------------------------------------

FOR i = 1 To ll_rows //(Appeon)Stephen 2013-06-25 - modify idw_verif.RowCount() to ll_rows - for Bug 3581--------
	lstr_web_crawler.ss_docid[i] = idw_verif.GetItemString(i,"doc_id")
NEXT

//Retrieve and filter verifs 
IF UpperBound(lstr_web_crawler.ss_docid[]) > 0 THEN
	li_rc = idw_verif_wc.Retrieve(lstr_web_crawler.ss_docid[] )
	IF li_rc < 1 THEN 
		as_message = "Error: Retrieving verification(s) error."
		RETURN -1		
	END IF		
END IF

//Set wc id & complete status
nvo_web_crawler_engine lnv_webcrawl
lnv_webcrawl.of_set_sched_flag(TRUE)
lnv_webcrawl.of_set_verifs( idw_verif_wc, lb_crawler)

//keep the sched msg
as_message = lnv_webcrawl.of_get_sched_msg( ) 

//Run Web Crawl and update verif_info
FOR i = 1 to li_rc	
	idw_verif_wc.AcceptText( )
	li_wc_id = idw_verif_wc.GetItemNumber( i, "web_crawler_id" )
	ls_doc_id = idw_verif_wc.GetItemString( i, "doc_id" )
	ll_prac_id = idw_verif_wc.GetItemNumber( i, "prac_id" )
	li_facility_id = idw_verif_wc.GetItemNumber( i, "facility_id" )
	ll_rec_id =  idw_verif_wc.GetItemNumber( i, "rec_id" )  //add by Stephen 07.02.2012  -V12.2 WebCrawler extract data
	
	//Continue for an unqualified record
	if Isnull(li_wc_id ) or li_wc_id < 1 then continue
	
	al_proc_cnt ++
	lnv_webcrawl.inv_message.of_set_message('') 	//reset the sched msg	

	//Run Web Crawl if this WC id was not failed before. 03.25.2010
	ls_ret = lnv_webcrawl.of_get_crawl_value(li_wc_id)
	if isnull(ls_ret) or LenA(trim(ls_ret)) < 1 then
		//Web crawl
		ls_ret = lnv_webcrawl.of_crawl_new(li_wc_id, ll_prac_id, ls_doc_id, lb_show, ll_rec_id, li_facility_id) //modify by Stephen 07.02.2012 - add rec_id,facility_id  -V12.2 WebCrawler extract data
		//keep wc id for failed crawls
		lnv_webcrawl.of_set_crawl_value(li_wc_id, ls_ret) 
	end if

	//Set verif rec based on the result 
	lnv_webcrawl.of_set_verifs_aftercrawl(idw_verif_wc, ls_ret, i)
	
	//Get message and Log for verif 
	li_status = idw_verif_wc.GetItemNumber(i, "complete_status")	
	ls_note = idw_verif_wc.GetItemString( i, "verif_info_notes" )
	ls_msg = lnv_webcrawl.of_parse_status(li_status)	
	IF IsNull(ls_note) THEN ls_note = ""
	ls_note = ls_msg + ": " + ls_note
	ls_verif_msg = lnv_webcrawl.of_get_sched_msg( )
	if LenA(ls_verif_msg) > 0 then ls_note += '~r~n' + ls_verif_msg	
	//---------Begin added by (Appeon)Stephen 2013-07-08 for Scheduler Feature Request 3600--------
	is_comp_flag = 'Y'
	if li_status <> 1 and li_status <> 2 then is_comp_flag = 'N'
	//---------End added ------------------------------------------------------
	
	of_log_schedule_verif(ai_sched_id, idw_verif_wc.Object.full_name[i], idw_verif_wc.Object.screen_id[i], idw_verif_wc.Object.reference_value[i], idw_verif_wc.Object.doc_id[i], ls_note)

	//Set flag for schedule log	
	//---------Begin Modified by (Appeon)Stephen 2013-07-08 for test bug--------
   // if li_status <> 1 or li_status <> 2 then lb_successful = FALSE
	if li_status <> 1 and li_status <> 2 then lb_successful = FALSE
	//---------End Modfiied ------------------------------------------------------	
NEXT

//Update verifs
idw_verif_wc.AcceptText( )
IF idw_verif_wc.Update() = 1 THEN
	COMMIT Using SQLCA;
ELSE
	ROLLBACK Using SQLCA;
	as_message = "Error: Web Crawl - Update failed. ~r~n" + as_message
	RETURN 0
END IF

IF NOT lb_successful THEN
	as_message = "Info: The Web Crawl is not completed for some verifications.~r~n" + as_message
END IF

RETURN 1











end function

public function integer of_run_verify_npdb (integer ai_scheduler_id, integer ai_type, ref string as_message, ref long al_proc_cnt);//Run Verif - NPDB --Nova 01.30.2010 - v10.1 Scheduler Functionality

Integer li_8
Long ll_RowCount
n_cst_message lnv_message

Constant Long ITP_INTERFACE  = 1 // USED FOR READ-ABILITY
Constant Long QRXS_INTERFACE = 2
 
//Dynamic set neet to verify dw's sql
of_set_verif_filter(idw_verif,'npdb query',ai_type)
//
ll_RowCount = idw_verif.Retrieve( )
al_proc_cnt =ll_RowCount

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.14.2015
//<$>reason:Allegheny Scheduler
//IF ll_RowCount <= 0 THEN RETURN 0
IF ll_RowCount = 0 THEN 
	RETURN 0
Elseif ll_RowCount < 0 THEN 
	as_message = "Error: Failed to retrieve verification(s)."
	RETURN -1
End If
//------------------- APPEON END -------------------

//get npdb format from ids
li_8 = of_get_app_setting("set_8","I") //npdb format QPRAC	0/ITP	1/QRXS	2/
CHOOSE CASE li_8
	CASE ITP_INTERFACE, QRXS_INTERFACE//ITP	1/QRXS	2/
		n_cst_npdb_control lnvo
		lnvo = Create n_cst_npdb_control
		lnvo.ib_do_not_open = True
		Message.DoubleParm = ai_type //2--SEND,1--recieve

		lnvo.of_set_sched_flag(ai_scheduler_id, TRUE)
		lnvo.of_run_npdb(idw_verif)
		
		as_message = lnvo.of_get_sched_msg( )
		al_proc_cnt = lnvo.of_get_sched_cnt( )
		
		IF IsValid(lnvo) THEN Destroy lnvo
	CASE ELSE //QPRAC  skip 
		as_message = lnv_message.of_get_message("Info","QPRAC skip")
		al_proc_cnt = 0
END CHOOSE

RETURN 1





end function

public function integer of_run_verify_scan_oig (integer ai_sched_id, ref string as_message, ref long al_proc_cnt);//Run Verifi - OIG --Nova 01.30.2010 - v10.1 Scheduler Functionality
//Reorganized by Alfee 02.23.2010

Integer li_cnt, li_sent, li_rtn, li_lname, li_fname, li_dob
Long i, ic, r, ll_found, ll_RowCount, ll_code, pracid, pracids[] 
String ls_sql_org, ls_where, ls_sql, ls_stype, ls_sanct_code
String ls_note, ls_FileName, ls_fullname, ls_doc_id, docids[]
Blob lblb_verif_picture
long ll_rows

DataStore lds_oig_prac, lds_verify, lds_oig_data, lds_report
n_cst_dm_utils lnv_file
n_cst_message lnv_message

//Get prac & doc ids to verify
of_set_verif_filter(idw_verif,'OIG QUERY',0) //Dynamic set verify dw's sql
ll_RowCount = idw_verif.Retrieve()

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.14.2015
//<$>reason:Allegheny Scheduler
//IF ll_RowCount <= 0 THEN RETURN 0
IF ll_RowCount = 0 THEN 
	RETURN 0
Elseif ll_RowCount < 0 THEN 
	as_message = "Error: Failed to retrieve verification(s)."
	RETURN -1
End If
//------------------- APPEON END -------------------

//---------Begin ADD by (Appeon)Stephen 2013-06-26 for Bug 3581--------
ib_all = false
if isnull(il_rows_limited) or il_rows_limited = 0 then il_rows_limited = 5000
if il_rows_limited > 5000 then il_rows_limited = 5000
if idw_verif.RowCount() < il_rows_limited then
	ll_rows = idw_verif.RowCount()
	ib_all = true
else
	ll_rows = il_rows_limited
end if
//---------End ADD ------------------------------------------------------

FOR i = 1 To ll_rows //(Appeon)Stephen 2013-06-26 - modify idw_verif.RowCount() to ll_rows - for Bug 3581--------
	pracids[i] = idw_verif.GetItemNumber(i,"prac_id")
	docids[i] = idw_verif.GetItemString(i,"doc_id")
NEXT

//Initialize variables and datastores
li_lname = 1
li_fname = 1
li_dob = 1

lds_oig_prac  = Create DataStore
lds_oig_prac.DataObject = "d_oig_prac_match_data"
lds_oig_prac.SetTransObject(SQLCA)

lds_verify  = Create DataStore
lds_verify.DataObject = "d_ver_sum_rec_view_oig"
lds_verify.SetTransObject(SQLCA)

lds_oig_data  = Create DataStore
lds_oig_data.DataObject = "d_oig_matched_data"
lds_oig_data.SetTransObject(SQLCA)

lds_report = Create DataStore
lds_report.DataObject = 'd_oig_matched_data_report'
lds_report.SetTransObject( SQLCA)

//Retrieve verif data 
gnv_appeondb.of_startqueue( )
lds_oig_prac.Retrieve(pracids[])
lds_verify.Retrieve(docids[])
gnv_appeondb.of_commitqueue( )

//Retrieve OIG data
ls_sql_org = lds_oig_data.GetSQLSelect() //get the original sql 
ic = lds_oig_prac.RowCount()
al_proc_cnt = ic //process count 

FOR i = 1 To ic
	IF i = 1 THEN
		ls_where = "WHERE " + of_set_where(i,li_lname,li_fname,li_dob,lds_oig_prac)
	ELSE
		ls_where += "OR" + of_set_where(i,li_lname,li_fname,li_dob,lds_oig_prac)
	END IF
NEXT
IF ic > 0 THEN
	ls_sql = ls_sql_org
	ls_sql = ls_sql + ls_where
	lds_oig_data.SetSQLSelect( ls_sql )
	lds_oig_data.SetTransObject( SQLCA )
	lds_oig_data.Retrieve( )
END IF

//Match for each prac
FOR i = 1 To ic
	//find in OIG data
	ls_where = of_set_filter(i, li_lname, li_fname, li_dob, lds_oig_prac)
	lds_oig_data.SetFilter(ls_where)
	lds_oig_data.Filter()
	r = lds_oig_data.RowCount( )
	
	//set match flag and copy any results
	lds_oig_prac.SetItem(i,"matchfound", r)
	IF r > 0 THEN
		IF r = 1 THEN
			lds_oig_prac.SetItem(i,"cust_10",lds_oig_data.GetItemString(1,"sanctype"))
		END IF
		lds_report.Reset( )
		lds_oig_data.RowsCopy (1, r, primary!, lds_report, 100000, primary! )

		//save report to DB---html format
		gnv_appeondll.of_parsepath(gs_temp_path)
		ls_FileName = gs_temp_path + "OIG_Match_Report.html"
		FileDelete(ls_FileName)
		lds_report.SaveAs(ls_FileName, HTMLTable!, False )
		DO WHILE True
			Yield()
			IF FileExists(ls_FileName) THEN EXIT
		LOOP
		lnv_file.of_ReadBlob(ls_FileName, lblb_verif_picture)
		
		pracid = lds_oig_prac.GetItemNumber(i,"prac_id")
		ll_found = lds_verify.Find( "prac_id = " + String(pracid), 1, lds_verify.RowCount() )
		IF ll_found > 0 THEN
			ls_doc_id = lds_verify.GetItemString(ll_found, "doc_id")
			UpdateBlob verif_info Set verification_picture = :lblb_verif_picture	Where doc_id = :ls_doc_id Using SQLCA;
			IF SQLCA.SQLCode <> -1 THEN 
				UPDATE verif_info	SET verification_picture_flag = 3 WHERE doc_id = :ls_doc_id Using SQLCA;
			END IF				
			IF SQLCA.SQLCode = -1 THEN
				as_message = lnv_message.of_get_message("SQL Error", SQLCA.SQLErrText)
				ROLLBACK Using SQLCA;				
				Destroy lds_oig_prac
				Destroy lds_verify
				Destroy lds_oig_data
				Destroy lds_report				
				RETURN -1
			END IF
		END IF
	ELSE
		lds_oig_prac.SetItem(i,"cust_10"," No Match")
		//lds_oig_data.SetItem(lds_oig_data.RowCount(),"sanctype",'None') ??
	END IF
NEXT

//Reset the lds_oig_data
lds_oig_data.SetSQLSelect( ls_sql_org )
lds_oig_data.SetTransObject( SQLCA )

//Set verif_info
ll_code = Long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + Upper('Credentials Verification Response') + "'" + " and upper(code) = 'SAT OIG'"))
FOR i = 1 To lds_oig_prac.RowCount()
	li_cnt = 0 //
	pracid = lds_oig_prac.GetItemNumber(i,"prac_id")
	ll_found = lds_verify.Find("prac_id = " + String(pracid), 1, lds_verify.RowCount())
	IF ll_found > 0 THEN
		li_cnt = lds_oig_prac.GetItemNumber(i,"matchfound")
		IF IsNull(li_cnt) THEN li_cnt = 0
		//get sanction description
		ls_stype = lds_oig_prac.GetItemString(i,"cust_10")
		ls_sanct_code = gnv_data.of_getitem("code_lookup" ,'description', "upper(lookup_name) = '" + Upper('OIG Sanctions') + "'" + " and upper(code) = '" + Upper(ls_stype) + "'")
		//set sent data
		IF IsNull(lds_verify.GetItemDateTime(ll_found,"first_sent")) THEN lds_verify.SetItem(ll_found,"first_sent",DateTime(Today(),Now()))
		lds_verify.SetItem(ll_found, "last_sent", DateTime(Today(),Now()))
		li_sent = lds_verify.GetItemNumber(ll_found,"number_sent")
		IF IsNull(li_sent) THEN
			lds_verify.SetItem(ll_found,"number_sent",1)
		ELSE
			li_sent++
			lds_verify.SetItem(ll_found,"number_sent",li_sent)
		END IF
		lds_verify.SetItem(ll_found,"print_flag",0)
		//set completed
		IF li_cnt = 0 THEN
			lds_verify.SetItem(ll_found,"date_recieved",DateTime(Today(),Now()))
			lds_verify.SetItem(ll_found,"user_name",gs_user_id)
			lds_verify.SetItem(ll_found,"response_code",ll_code)
			lds_verify.SetItem(ll_found,"user_name",gs_user_id)
		ELSEIF li_cnt = 1 THEN
			lds_verify.SetItem(ll_found, "notes", "1 match found  - " + ls_sanct_code)
		ELSE
			lds_verify.SetItem(ll_found, "notes", String(li_cnt) + " matches found")
		END IF
		//Start Code Change ----08.04.2011 #V11 maha - mod fields
		lds_verify.SetItem(ll_found,"mod_date",DateTime(Today(),Now()))
		lds_verify.SetItem(ll_found,"mod_user",gs_user_id)
		//End Code Change ----08.04.2011
	END IF
	ls_note = String(li_cnt) + " match(es) found"
	is_comp_flag = 'Y' //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600

	//Log for verification
	SELECT full_name Into :ls_fullname From v_full_name Where  prac_id = :pracid;
	of_log_schedule_verif(ai_sched_id,ls_fullname, lds_verify.Object.screen_id[i], lds_verify.Object.reference_value[i], lds_verify.Object.doc_id[i],ls_note)
NEXT

//Update verif info
li_rtn = lds_verify.Update()
IF li_rtn < 0 THEN
	lnv_message.of_MessageBox("Save Error","Unable to update verifications.",True)
ELSE
	COMMIT Using SQLCA;
END IF

as_message = lnv_message.of_get_message( )

Destroy lds_oig_prac
Destroy lds_verify
Destroy lds_oig_data
Destroy lds_report

RETURN 1

end function

public function integer of_log_schedule (integer ai_sched_id, integer ai_sched_type, string as_imp_exp, datetime ad_run_time, datetime ad_end_time, string as_error_code, long al_num_processed);//==============================APPEON BEGIN==========================
// Function: of_log_schedule()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	integer 	ai_sched_id        	
// 	value	integer 	ai_sched_type      	
// 	value	string  	as_imp_exp         	
// 	value	datetime	ad_run_time        	
// 	value	datetime	ad_time_to_parocess	
// 	value	string  	as_error_code      	
// 	value	long    	al_num_processed   	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Nova		Date: Jan 12,2010
//--------------------------------------------------------------------
// Modify History:
//==============================APPEON END============================

Long ll_rowno

ll_rowno = ids_schedule_log.InsertRow(0)

ids_schedule_log.SetRow(ll_rowno)
ids_schedule_log.Object.sched_id[ll_rowno] = ai_sched_id
ids_schedule_log.Object.Sched_type[ll_rowno] = ai_sched_type
ids_schedule_log.Object.Imp_exp[ll_rowno] = as_imp_exp
ids_schedule_log.Object.Run_time[ll_rowno] = ad_run_time
ids_schedule_log.Object.End_time[ll_rowno] = ad_end_time
ids_schedule_log.Object.Error_code[ll_rowno] = LeftA(as_error_code,500) //alfee 03.17.2010
ids_schedule_log.Object.Num_processed[ll_rowno] = al_num_processed
ids_schedule_log.Object.comp_flag[ll_rowno] = is_comp_flag //(Appeon)Stephen 2013-07-08 - Scheduler Feature Request 3600

RETURN 1

end function

public function integer of_log_schedule_verif (integer ai_scheduler_id, string as_full_name, integer ai_screen_id, string as_ref_value, string as_doc_id, string as_note);//Log for schedule of verification 

Long ll_rowno

ll_rowno = ids_schedule_veri_log.InsertRow(0)
ids_schedule_veri_log.SetRow(ll_rowno)
ids_schedule_veri_log.Object.Scheduler_id[ll_rowno] =ai_scheduler_id
ids_schedule_veri_log.Object.Date_run[ll_rowno] = DateTime(Today(),Now())
ids_schedule_veri_log.Object.Full_name[ll_rowno] =as_full_name
ids_schedule_veri_log.Object.screen[ll_rowno] = ai_screen_id
ids_schedule_veri_log.Object.reference_value[ll_rowno] =as_ref_value
ids_schedule_veri_log.Object.doc_id[ll_rowno] =as_doc_id
ids_schedule_veri_log.Object.note[ll_rowno] = LeftA(as_note,255) //alfee 03.17.2010
ids_schedule_veri_log.Object.comp_flag[ll_rowno] = is_comp_flag //(Appeon)Stephen 2013-07-08 -Scheduler Feature Request 3600

RETURN 1

end function

public function string of_get_impexp_nm (integer ai_sched_type, integer ai_imp_proj, integer ai_imp_exp_opt);//Get imp_exp name for import/export schedule - alfee 02.24.2010

Long ll_found
String ls_name

CHOOSE CASE ai_sched_type
	CASE 10 //import
		IF Not IsNull(ai_imp_exp_opt) THEN
			ls_name = String(ai_imp_exp_opt)
			ll_found = ids_imp_opt.Find("import_id = " + string(ai_imp_exp_opt), 1, ids_imp_opt.rowcount())
			IF ll_found > 0 THEN ls_name = ids_imp_opt.GetItemString(ll_found, "import_name")
		ELSEIF Not IsNull(ai_imp_proj) THEN
			ls_name = String(ai_imp_proj)
			ll_found = ids_imp_prj.Find("project_id = " + string(ai_imp_proj), 1, ids_imp_prj.rowcount())
			IF ll_found > 0 THEN ls_name = ids_imp_prj.GetItemString(ll_found, "project_name")
		END IF
	CASE 20  //export
		IF Not IsNull(ai_imp_exp_opt) THEN		
			ls_name = String(ai_imp_exp_opt)
			ll_found = ids_emp_opt.Find("export_id = " + string(ai_imp_exp_opt), 1, ids_emp_opt.rowcount())
			IF ll_found > 0 THEN ls_name = ids_emp_opt.GetItemString(ll_found, "export_name")		
		END IF
	CASE ELSE //other - NA
		ls_name = ""
END CHOOSE

RETURN ls_name


end function

public subroutine of_set_verif_filter (datawindow adw_verif, string as_verify_type, integer ai_sub_type);//Construct need to verfify dw sql --Nova 01.30.2010 - v10.1 Scheduler Functionality

String ls_where,ls_sql
String ls_original_sql_detail
Long ll_ver_method,ll_rowcount

ll_ver_method = Long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + Upper('verification method') + "'" + " and upper(code) = '" + Upper(as_verify_type) + "'"))

CHOOSE CASE Upper(as_verify_type)
	CASE 'NPDB QUERY'
		//adw_verif.DataObject = 'd_ver_sum_records_for_exp_app_npdb' //screen_id =1 ???

		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.14.2015
		//<$>reason: Allegheny Scheduler
		//adw_verif.DataObject = 'd_ver_summary_record_view_for_ai_all'//alfee 03.16.2010
		adw_verif.DataObject = 'd_ver_summary_record_view_for_sched'
		//------------------- APPEON END -------------------
		
		adw_verif.SetTransObject(sqlca)
		ls_original_sql_detail = adw_verif.object.datawindow.table.select
		IF ai_sub_type = 2 THEN //npdb--send
			//ls_where = ls_where + " AND verif_info.last_sent IS NULL AND verif_info.verification_method = " + String(ll_ver_method)
			ls_where = ls_where + " AND (verif_info.print_flag IS NULL OR verif_info.print_flag = 1 ) AND verif_info.verification_method = " + String(ll_ver_method)	//alfee 03.12.2010
		ELSE//npdb--recieve
			//ls_where = ls_where + " AND verif_info.last_sent IS  not NULL AND verif_info.verification_method = " + String(ll_ver_method)
			ls_where = ls_where + " AND verif_info.print_flag = 0 AND verif_info.verification_method = " + String(ll_ver_method)		//alfee 03.12.2010	
		END IF
	CASE 'OIG QUERY'
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.14.2015
		//<$>reason: Allegheny Scheduler
		//adw_verif.DataObject = 'd_ver_summary_record_view_for_ai_all'
		adw_verif.DataObject = 'd_ver_summary_record_view_for_sched'
		//------------------- APPEON END -------------------
		
		adw_verif.SetTransObject(sqlca)
		ls_original_sql_detail = adw_verif.Object.datawindow.Table.SELECT
		ls_where = ls_where + " AND verif_info.last_sent IS NULL AND verif_info.verification_method = " + String(ll_ver_method)
	CASE 'WEB'
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.13.2015
		//<$>reason: Allegheny Scheduler
		//adw_verif.DataObject = 'd_ver_summary_record_view_for_ai_all'
		adw_verif.DataObject = 'd_ver_summary_record_view_for_sched'
		//------------------- APPEON END -------------------
		
		adw_verif.SetTransObject(sqlca)
		ls_original_sql_detail = adw_verif.Object.datawindow.Table.SELECT
		ls_where = ls_where + " AND verif_info.verification_method = " + String(ll_ver_method)
	CASE ELSE
		/*statementblock*/
END CHOOSE
ls_sql = ls_original_sql_detail + ls_where

//Commented by alfee 03.05.2010
//IF adw_verif.DataObject = "d_ver_summary_record_view_for_ai_all" or adw_verif.DataObject = "d_ver_sum_records_for_exp_app_npdb" THEN
//	ls_sql = ls_sql + " AND security_user_facilities.user_id = '" + gs_user_id + "'" 
//END IF

adw_verif.SetSQLSelect ( ls_sql )
adw_verif.SetTransObject( sqlca )


end subroutine

public function integer of_run_aiq_pendingchange (ref string as_message, ref long al_prac_cnt);//====================================================================
//$<Function>: of_run_aiq_pendingchange
//$<Arguments>:
// 	reference    string    as_message
// 	reference    long      al_prac_cnt
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.01.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_pending_change ln_change

ln_change = create n_cst_pending_change

ln_change.of_run( )

as_message = ln_change.of_get_pending_msg()

al_prac_cnt = ln_change.of_get_pending_record()

destroy ln_change

return 1
end function

public function integer of_run_intellireport (integer ai_sched_id, ref string as_message, ref long al_proc_cnt);//====================================================================
//$<Function>: of_run_intellireport
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2014 (V142 Schedule IntelliReport)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_Return
Long ll_FindRow
Long ll_ireport_id
Long ll_proejct_id
Long ll_isoft_module
long ll_log //maha 06.07.2016
string ls_filepath

// Get ireport information
if ids_schedule.rowcount() < 1 then ids_schedule.retrieve()
ll_FindRow = ids_schedule.Find("sched_id=" + String(ai_sched_id), 1, ids_schedule.RowCount())
IF ll_FindRow <= 0 THEN RETURN -1
ll_ireport_id = ids_schedule.GetItemNumber(ll_FindRow, "imp_exp_option")
ll_proejct_id = ids_schedule.GetItemNumber(ll_FindRow, "imp_project")
ls_filepath = ids_schedule.GetItemString(ll_FindRow, "file_path")

gs_ireport_audit_from = "SCH"  //Start Code Change ----06.07.2016 #V152 maha - audit will be created from ireport window

openwithparm(w_custom_report, "schedule intellireport")
w_custom_report.dynamic of_sched_run(ll_ireport_id, ls_filepath, as_message)
close(w_custom_report)

gs_ireport_audit_from = "MAN" //Start Code Change ----06.07.2016 #V152 maha

return 1
end function

public function integer of_run_caqh_roster_import (string as_type, ref string as_message, ref long al_proc_cnt);//====================================================================
//$<Function>: of_run_caqh_roster_import
//$<Arguments>:
//	value			string		as_type LIST/EXCEPTION
// 	reference    string     as_message
// 	reference    long       al_proc_cnt
//$<Return>:  integer 1:success, -1:error
//$<Description>: Run caqh roster import, get Return Roster file and Exception file from caqh ftp.
//$<Author>: (Appeon) long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_return

openwithparm(w_caqh_roster, "Schedule Import")

li_return = w_caqh_roster.dynamic of_sched_run(as_type, as_message, al_proc_cnt)

close(w_caqh_roster)

//Clear as_message when No error
If li_return >= 0 Then as_message = ''

return li_return
end function

public function boolean of_is_no_data_error (string as_error);//====================================================================
//$<Function>: of_is_no_data_error
//$<Arguments>:
// 	value    string    as_error
//$<Return>:  boolean
//$<Description>: Analyse the error text to find out whether it only has no data errors.
//$<Author>: (Appeon) long.zhang 10.30.2015 (Scheduler reports failure when an import points to a file with no data)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_string
n_cst_string lnv_string

ls_string = ": " + "Failed to get import data. No data in the file." + '~r~n'

If  PosA(as_error, ls_string) > 0 Then
	ls_string = lnv_string.of_globalreplace( as_error, ls_string, '')
	If LenA(ls_string) > 0 Then //Still has other errors
		Return False
	Else
		Return True
	End If
Else
	Return False
End If

Return True

end function

on n_cst_scheduler_back10_16.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_scheduler_back10_16.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_schedule = create datastore
ids_schedule.DataObject = "d_sched_detail"
ids_schedule.settransobject(sqlca)

ids_schedule_log = Create DataStore
ids_schedule_log.DataObject = 'd_schedule_log'
ids_schedule_log.SetTransObject(sqlca)

ids_schedule_veri_log = Create DataStore
ids_schedule_veri_log.DataObject = 'd_schedule_veri_log'
ids_schedule_veri_log.SetTransObject( sqlca)

//for imp/exp
ids_imp_prj = Create DataStore
ids_imp_prj.DataObject = 'd_dddw_import_project'
ids_imp_prj.SetTransObject(sqlca)

ids_imp_opt = Create DataStore
ids_imp_opt.DataObject = 'd_dddw_import'
ids_imp_opt.SetTransObject(sqlca)

ids_emp_opt = Create DataStore
ids_emp_opt.DataObject = 'd_dddw_export_files'
ids_emp_opt.SetTransObject(sqlca)

gnv_appeondb.of_startqueue()
ids_imp_prj.Retrieve()
ids_imp_opt.Retrieve()
ids_emp_opt.Retrieve()
gnv_appeondb.of_commitqueue()

//
//dw_detail.Modify("report_format.Values='Excel	Excel!/Text	Text!/CSV	CSV!/HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/'")//HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/


end event

event destructor;Destroy ids_schedule
Destroy ids_schedule_log
Destroy ids_schedule_veri_log

Destroy ids_imp_opt
Destroy ids_imp_prj
Destroy ids_emp_opt
end event

