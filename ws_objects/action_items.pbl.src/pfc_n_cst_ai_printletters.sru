$PBExportHeader$pfc_n_cst_ai_printletters.sru
$PBExportComments$11-08-00
forward
global type pfc_n_cst_ai_printletters from pfc_n_cst_intcred_base
end type
end forward

global type pfc_n_cst_ai_printletters from pfc_n_cst_intcred_base
end type
global pfc_n_cst_ai_printletters pfc_n_cst_ai_printletters

type variables
w_action_items w_ai
n_ds ids_ai_detail

String is_letter_name
string is_doc_ids_exp[]
string is_process_type = "P"  //maha 07.09.2013
long il_ver_response
integer il_facility //maha 01.06.2009

n_cst_message inv_message //scheduler - alfee 03.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
boolean ib_from_utility = false
boolean ib_Priority_User = false //(Appeon)Stephen 02.28.2017 - Bug ID #5513
boolean ib_preserve_exp_appt  //maha 08.31.2017





end variables

forward prototypes
public function integer of_set_aiwin (window a_aiwin)
public function integer of_setactionitem (u_dw adw_share)
public function integer of_setactionitemdetaildw (u_dw adw_share)
public function integer of_updateverifdata (u_dw adw_detail)
public function integer of_connecttoweb (string as_web_address)
public function integer of_setdetaildw (u_dw dw)
public function integer of_expiring_credentials ()
public function integer of_resend_letters ()
public function integer of_expiring_appointments ()
public function integer of_reverify_credentials ()
public function integer of_dialphone (string as_phone)
public function integer of_copy_required_data (long ll_appt_stat_id, integer ai_app_audit_facility_id, integer ai_parent_facility_id, long al_prac_id)
public function integer of_start_reappointment_processing (u_dw adw_ver_copy, u_dw adw_action_items, integer ai_parent_facility, long al_prac_id, string as_ver_type)
public function integer of_expiring_credentials_from_data ()
public function integer of_run_ai_query (integer ai_from)
public function integer of_expiring_credentials_from_data_old ()
public subroutine of_missing_info_90_days_generate ()
public function integer of_missing_info_90_days_print (string as_doc_id[], u_dw adw_detail)
public function integer of_wv_initiated_workflow ()
public function integer of_run_export (long al_pracs[], long al_export, ref string as_path)
public function integer of_privilege_renewal (long al_prac, long al_facil, integer ai_manual, long al_appt_rec)
public function integer of_find_missing_verifs (long al_prac, long al_v_facil, integer ai_silent, string as_appt_type)
public function integer of_start_reappointment_processing_new (u_dw adw_ver_copy, u_dw adw_action_items, integer ai_parent_facility, long al_prac_id, string as_ver_type, integer ai_silent)
public function integer of_retrieve_recred (datawindow adw_verifs, long al_prac, long al_vfacil)
public function string of_set_i_r_filter (string as_type, integer ai_ver_facil)
public function integer of_exp_cred_letter_combined (long al_pracs[], string al_docids[], integer ai_facility, n_ds ads_rows, u_dw ads_docs, string as_from)
public function integer of_printletters_combined (string as_doc_id[], string as_affil_stat, string as_letter_name, string as_letter_type, u_dw adw_detail, string as_doc_name, boolean ab_print_preview, string as_sql, long al_pracids[], integer ai_facility, string as_funct_type, string as_from)
public function integer of_set_active_users ()
public function integer of_df_expiring_update ()
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_notificationalert ()
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_set_send_info (long al_row, string as_response, boolean ab_note)
public function integer of_meeting_create ()
public function long of_expiring_credentials_from_data_new (string as_from)
public function integer of_printletters (string as_doc_id[], string as_affil_stat, string as_letter_name, string as_letter_type, u_dw adw_detail, string as_doc_name, boolean ab_print_preview, string as_sql, long as_pracids[], long ai_facility, long al_parent, integer ai_screen)
public function integer of_intellibatch_update ()
public function integer of_pendingchange ()
public function integer of_appl_tracking_running_days ()
public function integer of_expiring_credentials_procd ()
public function integer of_expiring_credentials_org ()
public function integer of_run_ai_query_org (integer ai_from)
public function integer of_ama_profile (long al_pracid[], string as_docid[], boolean ab_single_prac, string as_from, long al_ama_id)
public function integer of_save_doc_to_db (string as_doc_id, string as_file_name, integer ai_type)
public function integer of_check_reports_store ()
public function integer of_exp_credentials_check_for_data (integer ai_screen)
public function integer of_expiring_credentials_from_data_utl (string as_from, integer ai_screen[])
end prototypes

public function integer of_set_aiwin (window a_aiwin);w_ai = a_aiwin

RETURN 0
end function

public function integer of_setactionitem (u_dw adw_share);
ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = "d_ver_summary_for_action_items"

adw_share.ShareData( ids_ai_detail )


RETURN 0
end function

public function integer of_setactionitemdetaildw (u_dw adw_share);Integer li_retval

ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = "d_ver_summary_for_action_items"

li_retval = adw_share.ShareData( ids_ai_detail )

messagebox("share retval", li_retval)

RETURN 0
end function

public function integer of_updateverifdata (u_dw adw_detail);Integer li_rec_id_cnt
Integer s

ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = "d_ver_summary_for_action_items"

adw_detail.ShareData( ids_ai_detail )
	
ids_ai_detail.SetFilter( "Upper(screen_name) = Upper('" + is_letter_name + "')" )
li_rec_id_cnt = ids_ai_detail.Filter( )
	
FOR s = 1 TO li_rec_id_cnt
	ids_ai_detail.SetItem( s, "number_sent", 1 )
	IF IsNull( ids_ai_detail.GetItemDateTime( s, "first_sent" ) ) THEN
		ids_ai_detail.SetItem( s, "first_sent", DateTime(Today(), Now()) )
	END IF
	ids_ai_detail.SetItem( s, "last_sent", DateTime(Today(), Now()) )
END FOR

RETURN 0
end function

public function integer of_connecttoweb (string as_web_address);//String ls_browser_path
//
//ls_browser_path = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "Paths","browser", "None")
//
IF LenA(as_web_address ) < 1 THEN
	MessageBox("Invalid WEB Address", "There is no web address setup for the selected entity." )
	Return -1
END IF
//
//Run( ls_browser_path + " " + as_web_address)

//maha rewrote 010505
inet iinet_base

if gi_citrix = 1 then
	of_open_web(as_web_address)
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.23.2006 By: Liang QingShi
	//$<reason>  GetContextService is currently unsupported. 
	//$<modification> Replace GetContextService with ShellExecuteA to provide the
	//$<modification> same functionality.
	/*
	GetContextService("Internet", iinet_base)
	iinet_base.HyperlinkToURL(as_web_address)
	*/
	String ls_url,ls_null
	setnull(ls_null)
	ls_url = as_web_address
	//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
	ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
	//---------End Modfiied ------------------------------------------------------
	//---------------------------- APPEON END ----------------------------

end if

Return 0
end function

public function integer of_setdetaildw (u_dw dw);ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = dw.DataObject

dw.ShareData( ids_ai_detail )


Return 0
end function

public function integer of_expiring_credentials ();//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.23.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

n_ds lds_exp_cred
n_ds lds_exp_copy
n_ds lds_last_verif_seq_no
n_ds lds_exp_cred_incomp  //maha 07.20.2015
datastore lds_new_verif//evan 05.16.2011

Long ll_ver_method_ltr 
Long ll_prac_id[]
Long ll_rec_id[]
long li_facility_id[]
Long ll_seq_row_cnt
long ll_exp_method  //maha 070909
long ll_psv_method //maha 070909
Long ll_seq_no
long ll_ref_row_num[]  //evan 05.16.2011
Long ll_rowcount //(Appeon)Harry 06.29.2015
long li_row_cnt
long ll_incomp_cnt //maha 07.20.2015
long r   //maha 07.20.2015
long ll_find   //maha 07.20.2015
long i
long li_nr
Integer nullint
integer cnt = 0
integer Bcnt = 0
integer li_option //maha 070909
integer li_exp_flag = 1  //maha 070909
integer li_priority //maha 09.03.09
DateTime nulldate
String ls_doc_id
string ls_fails = ""
string ls_user //maha 09.03.09
string ls_psv_user //maha 09.03.09
string ls_new_doc_id[] //evan 05.16.2011
string ls_err
string ls_find  //maha 07.20.2015



//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 1")
//---------------------------------------------------------------------------------------



SetNull( nullint )
SetNull( nulldate )
lds_exp_cred = CREATE n_ds
lds_exp_cred.DataObject = "d_exp_credentials"
lds_exp_cred.of_SetTransObject( SQLCA )
li_row_cnt = lds_exp_cred.Retrieve(  ) 
//<add> 06/27/2007 by: Andy set sort first
lds_exp_cred.setsort("rec_id A, prac_id A, facility_id A")
lds_exp_cred.sort()
//end of add



//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 2")
//---------------------------------------------------------------------------------------

 //Start Code Change ----07.20.2015 #V15 maha
lds_exp_cred_incomp = CREATE n_ds
lds_exp_cred_incomp.DataObject = "d_exp_credentials_incomp"
lds_exp_cred_incomp.of_SetTransObject( SQLCA )
ll_incomp_cnt = lds_exp_cred_incomp.Retrieve(  ) 
lds_exp_cred_incomp.setsort("rec_id A, prac_id A, facility_id A")
lds_exp_cred_incomp.sort()
 //End Code Change ----07.20.2015


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 3")
//---------------------------------------------------------------------------------------



lds_exp_copy = CREATE n_ds
lds_exp_copy.DataObject = "d_exp_credentials"
lds_exp_copy.of_SetTransObject( SQLCA )

lds_last_verif_seq_no = CREATE n_ds
//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt"
//this gets the max seq_no for all the items that will be retrieved in "d_exp_credentials"
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt_credentials"
//end of modify
lds_last_verif_seq_no.of_SetTransObject( SQLCA )

//comment 07/26/2007 by: Andy
//Reason:optimize
//the data source of d_last_verif_seq_no_forpt_credentials is not need arguments.
/*
FOR i = 1 TO li_row_cnt
	ll_rec_id[i] = lds_exp_cred.GetItemNumber( i, "rec_id" )
	ll_prac_id[i] = lds_exp_cred.GetItemNumber( i, "prac_id" )
	li_facility_id[i] = lds_exp_cred.GetItemNumber( i, "facility_id" )
next

if UpperBound(ll_rec_id) = 0 then
	ll_rec_id[1] = 0
end if

if UpperBound(ll_prac_id) = 0 then
	ll_prac_id[1] = 0
end if

if UpperBound(li_facility_id) = 0 then
	li_facility_id[1] = 0
end if
*/

//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.Retrieve( ll_rec_id, ll_prac_id, li_facility_id )
lds_last_verif_seq_no.Retrieve( )
//end of modify


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 4")
//---------------------------------------------------------------------------------------


if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 150



ll_ver_method_ltr = Long(gnv_data.of_getitem("code_lookup","lookup_code",&
"upper(lookup_name) = upper('verification method') AND upper(code) = upper('exp cred ltr')"))

//gnv_appeondb.of_startqueue( ) //evan 05.16.2011

//<add> 06/27/2007 by: Andy
Long    ll_rec_id_first      = -1
Long    ll_prac_id_first     = -1
Integer li_facility_id_first = -1
//end of add

inv_message.of_set_proc_cnt(li_row_cnt) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
ll_rowcount =  lds_last_verif_seq_no.rowcount( ) //(Appeon)Harry 06.29.2015
FOR i = 1 TO li_row_cnt
	//lds_exp_copy.reset() //evan 05.16.2011
	
	//<add> 07/26/2007 by: Andy
	ll_rec_id[i] = lds_exp_cred.GetItemNumber( i, "rec_id" )
	ll_prac_id[i] = lds_exp_cred.GetItemNumber( i, "prac_id" )
	li_facility_id[i] = lds_exp_cred.GetItemNumber( i, "facility_id" )
	//end of add
	
	
	//<add> 06/27/2007 by: Andy fixed a bug. 
	//attention:set sort first
	if ll_rec_id_first = ll_rec_id[i] and &
		ll_prac_id_first = ll_prac_id[i] and li_facility_id_first = li_facility_id[i] then
		//Start Code Change ---06.16.2008 #V81 maha - changed so that for duplicates only one exp cred verification will be created
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
		continue		
		//ll_seq_no++
	else
		
	 //Start Code Change ----07.20.2015 #V15 maha - if there is another existing verification that is incomplete, do not create another exp cred.
	ls_find =  'rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i])
	ll_find = lds_exp_cred_incomp.find(ls_find, 1, ll_incomp_cnt )

	
	if ll_find > 0 then
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
		continue
	end if
	 //End Code Change ----07.20.2015	
		
	//end of add
		//---------Begin Modified by (Appeon)Harry 06.29.2015--------
		/*
		//find out the last seq no used for this ver record
		lds_last_verif_seq_no.setfilter('rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i]))//modify by evan 05.10.2011
		lds_last_verif_seq_no.filter( )
		ll_seq_row_cnt = lds_last_verif_seq_no.rowcount( )
		*/
		ll_seq_row_cnt = lds_last_verif_seq_no.find( 'rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i]), 1, ll_rowcount)
		//---------End Modfiied --------------------------------
		IF  ll_seq_row_cnt < 1 THEN
			//gnv_appeondb.of_commitqueue( ) //evan 05.16.2011
 			//MessageBox("Error", "Error getting next sequence number." )
			//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Error", "Error getting next sequence number.",true)
			Return -1
		ELSE
			//ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( ll_seq_row_cnt, "last_seq_no" ) + 1 //(Appeon)Harry 06.29.2015
		END IF
		//<add> 06/27/2007 by: Andy 
		ll_rec_id_first = ll_rec_id[i]
		ll_prac_id_first = ll_prac_id[i]
		li_facility_id_first = li_facility_id[i]
	end if
	//end of add
	//Start Code Change ----07.09.2009 #V92 maha - added functionality to allow creation as PSV or duplicate EXP and PSV
	//Start Code Change ----08.31.2009 #V92 maha - add additional trap for historical verifications
	if lds_exp_cred.getitemnumber(i,"verif_info_data_status") = 2 or lds_exp_cred.getitemnumber(i,"verif_info_data_status") = 0 then //Start Code Change ----03.29.2010 #V10 maha - added trap for inactive
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)  //set the flag don't do anything else
	else
		li_option = lds_exp_cred.getitemnumber(i,"exp_options")
		ll_psv_method = lds_exp_cred.getitemnumber(i,"default_verif_means")
		//Start Code Change ----09.03.2009 #V92 maha - add assigned and priority
		ls_user  =  lds_exp_cred.getitemstring(i,"priority_user_exp")
		if isnull(ls_user) or LenA(ls_user) < 1 then ls_user = "PUBLIC"
		li_priority =  lds_exp_cred.getitemnumber(i,"priority_exp")
		if isnull(li_priority) then li_priority = 1
		ls_psv_user  =  lds_exp_cred.getitemstring(i,"priority_user")
		if isnull(ls_user) or LenA(ls_user) < 1 then ls_user = "PUBLIC"
		//End Code Change---09.03.2009
		if li_option = 1 then //create as PSV type not expiring
			ll_exp_method = ll_psv_method
			li_exp_flag = 1   //Start Code Change ----07.20.2015 #V15 maha - changed from 0
		else  //normal exp letter
			ll_exp_method = ll_ver_method_ltr
			li_exp_flag = 1
		end if
		//ll_seq_no = lds_exp_cred.GetItemNumber( i, "seq_no" )
		lds_exp_cred.RowsCopy(i, i, Primary!, lds_exp_copy, 100000, Primary!)
		//ll_seq_no++
		li_nr = lds_exp_copy.RowCount()
		lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
		lds_exp_copy.SetItem( li_nr, "first_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "last_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "number_sent", 0 )
		lds_exp_copy.SetItem( li_nr, "date_recieved", nulldate )
		lds_exp_copy.SetItem( li_nr, "user_name", "" )
		lds_exp_copy.SetItem( li_nr, "response_code", nullint )
		//Start Code Change ----09.03.2009 #V92 maha - add assigned and priority
//		lds_exp_copy.SetItem( li_nr, "priority_user", "PUBLIC" )
//		lds_exp_copy.SetItem( li_nr, "priority", 2 )
		//if ls_user <> "PUBLIC" then 
		lds_exp_copy.SetItem( li_nr, "priority_user", ls_user )
		//end if
		lds_exp_copy.SetItem( li_nr, "priority", li_priority )
		//Start Code Change ----09.03.2009 #V92 maha
		lds_exp_copy.SetItem( li_nr, "exp_credential_flag", li_exp_flag) //maha 070909
		lds_exp_copy.SetItem( li_nr, "verification_method", ll_exp_method) //maha 070909
		ls_doc_id = String( lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "prac_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "facility_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "seq_no" ) )
		lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
		lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
		
// <RP> !working
		
		ls_new_doc_id[upperbound(ls_new_doc_id) + 1] = ls_doc_id //evan 05.16.2011
		ll_ref_row_num[upperbound(ll_ref_row_num) + 1] = i //evan 05.16.2011
		//Start Code Change ----08.03.2011 #V11 maha - cleart prior mod values and add create
		lds_exp_copy.SetItem( li_nr, "mod_user", "" )
		lds_exp_copy.SetItem( li_nr, "mod_date", nulldate )
		lds_exp_copy.SetItem(li_nr, 'create_date', datetime(today(),Now()))
		lds_exp_copy.SetItem(li_nr, 'create_user', "Sys-AIQ")
		//End Code Change ----08.03.2011 
//			ELSE
//				lds_verif_info.SetItem(li_nr, 'mod_date', String(Now(), 'yyyy-mm-dd hh:m:ss'))
//				lds_verif_info.SetItem(li_nr, 'mod_user', gs_user_id)
//			END IF
		
		if li_option = 2 then //exp letter plus PSV  - copy the exp one just created and modify for PSV
			//copy the last row
			lds_exp_copy.RowsCopy(li_nr, li_nr, Primary!, lds_exp_copy, 100000, Primary!)
			//reset the data in the new record
			li_nr = lds_exp_copy.RowCount()
			ll_seq_no++
			lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
			lds_exp_copy.SetItem( li_nr, "priority_user", ls_psv_user )
			lds_exp_copy.SetItem( li_nr, "priority", 3 )
			lds_exp_copy.SetItem( li_nr, "exp_credential_flag", 1) //maha 070909    //Start Code Change ----07.20.2015 #V15 maha - changed from 0
			lds_exp_copy.SetItem( li_nr, "verification_method", ll_psv_method) //maha 070909
			ls_doc_id = String( lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "prac_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "facility_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "seq_no" ) )
			lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
			lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
			ls_new_doc_id[upperbound(ls_new_doc_id) + 1] = ls_doc_id //evan 05.16.2011
			ll_ref_row_num[upperbound(ll_ref_row_num) + 1] = i //evan 05.16.2011
		end if
		//End Code Change---07.09.2009	
	
		/* evan 05.16.2011
		IF lds_exp_copy.Update()  = 1 THEN
			COMMIT USING SQLCA;
			lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
			cnt++
		else
			ls_fails = ls_fails + " " +  ls_doc_id
			bcnt++
		end if
		*/
	end if //historical

	
END FOR


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 5")
//---------------------------------------------------------------------------------------

//gnv_appeondb.of_commitqueue( ) //evan 05.16.2011

//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> evan 05.16.2011
//$<reason> Performance tuning.
li_row_cnt = UpperBound(ls_new_doc_id)
if li_row_cnt > 0 then
	lds_new_verif = Create datastore
	lds_new_verif.DataObject = "d_exp_new_verif"
	lds_new_verif.SetTransObject(SQLCA)
	gnv_appeondb.of_StartQueue()
	lds_exp_copy.Update()
	COMMIT USING SQLCA;
	lds_new_verif.Retrieve(ls_new_doc_id[])
	gnv_appeondb.of_CommitQueue()
	for i = 1 to li_row_cnt
		if lds_new_verif.Find("doc_id = '" + ls_new_doc_id[i] + "'", 1, 999999) > 0 then
			lds_exp_cred.SetItem(ll_ref_row_num[i], "exp_credential_flag", 2)
			cnt ++
		else
			ls_fails = ls_fails + " " +  ls_new_doc_id[i]
			bcnt ++
		end if
	next
	Destroy lds_new_verif
end if
//------------------- APPEON END ---------------------


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 6")
//---------------------------------------------------------------------------------------

//MSKINNER 15 MARCH 2005 -- BEGIN
if isvalid(w_aiq_run) THEN w_aiq_run.r_status.width = 600
//MSKINNER 15 MARCH 2005 -- END
//debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.29.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_autocommit( )
//---------------------------- APPEON END ----------------------------

IF lds_exp_cred.Update ( True, False ) = 1 THEN
	COMMIT USING SQLCA;
	DESTROY lds_exp_cred
	DESTROY lds_exp_copy
	DESTROY lds_last_verif_seq_no
	
	if cnt > 1 then
	//	messagebox("Exp Cred records created",cnt)
	end if
	if bcnt > 1 then
		//messagebox("Exp Cred records failed",bcnt)
	end if
	if LenA(ls_fails) > 5 then
		//messagebox("Exp Cred Failure","The following records could not be created~r " + ls_fails)
		//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("Exp Cred Failure","The following records could not be created~r " + ls_fails,true)
		bcnt++
	end if
	
	return 1
else
	//MessageBox("Update Failed", "Update during expiring credentials query failed.")
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
//	messagebox("",SQLCA.SQLErrText)
	inv_message.of_MessageBox("Update Failed", "Update during expiring credentials query failed.",true)
	DESTROY lds_exp_cred
	DESTROY lds_exp_copy
	DESTROY lds_last_verif_seq_no
	return -1
END IF


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("of_expiring_credentials(): 7")
//---------------------------------------------------------------------------------------


end function

public function integer of_resend_letters ();n_ds lds_resend
Integer li_rc
Integer i
Long ll_seq_no
Integer li_facility_id
long ll_rec_id
long ll_pracid

lds_resend = CREATE n_ds;
lds_resend.DataObject = "d_resend_letters"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

inv_message.of_set_proc_cnt(li_rc) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality

if isvalid(w_aiq_run) then w_aiq_run.r_status.width = 900  //For checking validation modified by  Nova 08.27.2009
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	//MessageBox("Update Failed", "Update of veir_info table failed during resend letter query!" )
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox("Update Failed", "Update of veir_info table failed during resend letter query!",true)
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.24.2006 By: Jervis
//$<reason> 
lds_resend.DataObject = "d_resend_letters_app"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

inv_message.of_set_proc_cnt(li_rc, true) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality

if isvalid(w_aiq_run) then w_aiq_run.r_status.width = 950 //For checking validation modified by  Nova 08.27.2009
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	//MessageBox("Update Failed", "Update of net_dev_action_items table failed during resend letter query!" )
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox("Update Failed", "Update of net_dev_action_items table failed during resend letter query!",true)
	Return -1
END IF

//12.5.2006 By Jervis
lds_resend.DataObject = "d_resend_letters_Contract"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

inv_message.of_set_proc_cnt(li_rc, true)//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality

if isvalid(w_aiq_run) then w_aiq_run.r_status.width = 1000 //For checking validation modified by  Nova 08.27.2009
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	//MessageBox("Update Failed", "Update of net_dev_action_items table failed during resend letter query!" )
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox("Update Failed", "Update of net_dev_action_items table failed during resend letter query!",true)
	Return -1
END IF

//01.22.2007 By Jervis
lds_resend.DataObject = "d_resend_letters_Document"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )// maha app102105 removed arg from dw

inv_message.of_set_proc_cnt(li_rc, true) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality

if isvalid(w_aiq_run) then w_aiq_run.r_status.width = 1050 //For checking validation modified by  Nova 08.27.2009
FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
	//MessageBox("Update Failed", "Update of ctx_am_action_item table failed during resend letter query!" )
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
   inv_message.of_MessageBox("Update Failed", "Update of ctx_am_action_item table failed during resend letter query!",true)
	Return -1
END IF

//Start Code Change ----07.06.2011 #V11 maha - process action reset
lds_resend.DataObject = "d_resend_process_actions"
lds_resend.of_SetTransObject( SQLCA )
li_rc = lds_resend.Retrieve( )

FOR i = 1 TO li_rc
	lds_resend.SetItem( i, "print_flag", 1)
END FOR

IF lds_resend.Update() = -1 THEN
   inv_message.of_MessageBox("Update Failed", "Update of Process Actions table failed during resend letter query!",true)
	Return -1
END IF
//Start Code Change ----07.06.2011

destroy lds_resend
//---------------------------- APPEON END ----------------------------


Return 1
end function

public function integer of_expiring_appointments ();
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.17.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
n_ds lds_exp_appointments
n_ds lds_verif_info
Integer li_row_cnt
Integer i
integer tp //maha 071403
Integer li_facility_id
Integer li_nr
Integer li_last_seq_no  
Long ll_rec_id
Long ll_exp_ltr
Long ll_prac_id
String ls_doc_id

lds_exp_appointments = CREATE n_ds
lds_verif_info = CREATE n_ds
lds_verif_info.DataObject = "d_verif_info"
lds_verif_info.of_SetTransObject( SQLCA )
*/

datastore lds_exp_appointments_1
datastore lds_exp_appointments_2
datastore lds_exp_appointments_3
datastore lds_last_verif_seq_no
n_ds lds_verif_info
Integer li_row_cnt
Integer i
integer tp //maha 071403
Integer li_facility_id
Integer li_nr
Integer li_last_seq_no  
Long ll_rec_id
Long ll_exp_ltr
Long ll_prac_id
String ls_doc_id
long ll_r
datetime ld_exp_date  //maha 02.12.2015

//<add> 06/27/2007 by: Andy
Long    ll_prac_id_first    
Integer li_facility_id_first
Long    ll_last_cnt
//end of add

/* R.Avital v11.3
   Get create_user from verify_info
	Begin changes
*/
String ls_user
// R.Avital v11.3 END changes

lds_exp_appointments_1 = CREATE datastore
lds_exp_appointments_2 = CREATE datastore
lds_exp_appointments_3 = CREATE datastore
lds_last_verif_seq_no = CREATE datastore
lds_verif_info = CREATE n_ds
lds_verif_info.DataObject = "d_verif_info"
lds_verif_info.of_SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------
//Added for Work Flow. 2/11/2006 Henry
long ll_prac_ids[] , ll_rec_ids[], ll_screen_ids[],ll_facility_ids[],ll_wf_ids[]
long ll_wf_expiring
String	ls_override = 'N'
//End added for work flow
//---------------------------- APPEON END ----------------------------

ll_exp_ltr=long(gnv_data.of_getitem("code_lookup" ,'lookup_code', "upper(lookup_name) = '" + upper('verification method') + "'"+" and upper(code) = 'EXP APPT LTR'"))



gnv_appeondb.of_startqueue( )

lds_exp_appointments_1.DataObject = "d_exp_appt_allied_health"
lds_exp_appointments_1.SetTransObject( SQLCA )
lds_exp_appointments_1.Retrieve(  )

lds_exp_appointments_2.DataObject = "d_exp_provisional"
lds_exp_appointments_2.SetTransObject( SQLCA )
lds_exp_appointments_2.Retrieve()

lds_exp_appointments_3.DataObject = "d_exp_appointments_no_ah"  //Start Code Change ----05.26.2009 #V92 maha - changed from the d_exp_appointments dw object
lds_exp_appointments_3.SetTransObject( SQLCA )
lds_exp_appointments_3.Retrieve()

lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_for_pt"
lds_last_verif_seq_no.SetTransObject( SQLCA )
//ll_last_cnt = lds_last_verif_seq_no.Retrieve()
lds_last_verif_seq_no.Retrieve() //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX

//<add> 06/27/2007 by: Andy set sort first
lds_exp_appointments_1.setsort("prac_id A, parent_facility_id A")
lds_exp_appointments_1.sort()

lds_exp_appointments_2.setsort("prac_id A, parent_facility_id A")
lds_exp_appointments_2.sort()

lds_exp_appointments_3.setsort("prac_id A, parent_facility_id A")
lds_exp_appointments_3.sort()
//end of add

gnv_appeondb.of_commitqueue( )

ll_last_cnt = lds_last_verif_seq_no.RowCount() //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX

integer li_row_cnt_1,li_row_cnt_2,li_row_cnt_3
li_row_cnt_1 = lds_exp_appointments_1.rowcount()
li_row_cnt_2 = lds_exp_appointments_2.rowcount()
li_row_cnt_3 = lds_exp_appointments_3.rowcount()
ll_rec_id = gnv_app.of_get_id("RECORD_ID",(li_row_cnt_1+li_row_cnt_2+li_row_cnt_3)*3) - 1



for tp = 1 to 3	//maha 071403 loop and create the 3 types of letters
	choose case tp
		case 1 //exp allied health create the exp ah first and the exp appts that would be generated off the same records will not be created
			//MSKINNER 15 MARCH 2005 -- BEGIN
          if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1300
         //MSKINNER 15 MARCH 2005 -- END	
			li_row_cnt = li_row_cnt_1
		case 2 //exp provisional			
			//MSKINNER 15 MARCH 2005 -- BEGIN
          if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1500
         //MSKINNER 15 MARCH 2005 -- END
			li_row_cnt = li_row_cnt_2
		case 3 //exp appointments					
			li_row_cnt = li_row_cnt_3
	end choose
	
	inv_message.of_set_proc_cnt(li_row_cnt, true)//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
	
	lds_verif_info.reset()

	//<add> 06/27/2007 by: Andy
	ll_prac_id_first     = -1
	li_facility_id_first = -1
	//end of add
	
	FOR i = 1 TO li_row_cnt
		
		choose case tp
			case 3 //exp appointments
				ll_prac_id = lds_exp_appointments_3.GetItemNumber( i, "prac_id")
				li_facility_id = lds_exp_appointments_3.GetItemNumber( i, "parent_facility_id") 
				ld_exp_date = lds_exp_appointments_3.GetItemDatetime( i, "pd_affil_stat_apptmnt_end_date")   //Start Code Change ----02.12.2015 #V14.2 maha
				//lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Appointment Letter" ) Jervis 12.20.2006
			case 2 //exp provisional
				ll_prac_id = lds_exp_appointments_2.GetItemNumber( i, "prac_id")
				li_facility_id = lds_exp_appointments_2.GetItemNumber( i, "parent_facility_id") 
				ld_exp_date = lds_exp_appointments_2.GetItemDatetime( i, "pd_affil_stat_apptmnt_end_date") //Start Code Change ----02.12.2015 #V14.2 maha
				//lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Provisional Letter" ) Jervis 12.20.2006
			case 1 //exp allied health
				ll_prac_id = lds_exp_appointments_1.GetItemNumber( i, "prac_id")
				li_facility_id = lds_exp_appointments_1.GetItemNumber( i, "parent_facility_id") 
				ld_exp_date = lds_exp_appointments_1.GetItemDatetime( i, "pd_affil_stat_apptmnt_end_date")  //Start Code Change ----02.12.2015 #V14.2 maha
				//lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Allied Health Letter" ) Jervis 12.20.2006
		end choose
		
		If gb_workflow Then
			ll_wf_expiring = long(gnv_data.of_getitem("facility","facility_wf_expiring_appointment","facility_id="+string(li_facility_id)))
			If ll_wf_expiring > 0 Then
				ll_prac_ids[upperbound(ll_prac_ids) + 1]  = ll_prac_id
				ll_rec_ids[upperbound(ll_rec_ids) + 1] = ll_rec_id
				ll_screen_ids[upperbound(ll_screen_ids) + 1] = -10
				ll_facility_ids[upperbound(ll_facility_ids) + 1] = li_facility_id
				ll_wf_ids[upperbound(ll_wf_ids) + 1] = ll_wf_expiring
			End If
			ls_override = gnv_data.of_getitem( 'facility', 'facility_wf_exp_appt', 'facility_id=' + string(li_facility_id))
			if isnull(ls_override) Then ls_override = 'N'
		End If
		
		//if [x] Override IntelliCred Expiring Appointment Letter Action Item Creation is checked in facility painter
		//then just don't create the Exp Appt Ltr that the system normally creates.
		If ls_override <> 'Y' Then
			li_nr = lds_verif_info.InsertRow( 0 )				
			ll_rec_id ++	
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 12.20.2006 By: Jervis
			//$<reason> Fix a defect
			choose case tp
				case 3 //exp appointments
					lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Appointment Letter" )
				case 2 //exp provisional
					lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Provisional Letter" )
				case 1 //exp allied health
					lds_verif_info.SetItem( li_nr, "reference_value", "Expiring Allied Health Letter" )
			end choose
			//---------------------------- APPEON END ----------------------------

			lds_verif_info.SetItem( li_nr, "prac_id", ll_prac_id )
			lds_verif_info.SetItem( li_nr, "rec_id", ll_rec_id )
			lds_verif_info.SetItem( li_nr, "facility_id", li_facility_id )
			lds_verif_info.SetItem( li_nr, "direct_parent_facility_link", li_facility_id )
			
			//<add> 06/27/2007 by: Andy fixed a bug. 
			//attention:set sort first
			if ll_prac_id_first = ll_prac_id and li_facility_id_first = li_facility_id then 
				li_last_seq_no++
			else
			//end of add
				//Modify 07/26/2007 by: Andy
				//ll_r=lds_last_verif_seq_no.find('prac_id='+string(ll_prac_id)+' and verification_method='+string(ll_exp_ltr)+' and facility_id='+string(li_facility_id),1,lds_last_verif_seq_no.Rowcount())
				ll_r=lds_last_verif_seq_no.find('prac_id='+string(ll_prac_id)+' and verification_method='+string(ll_exp_ltr)+' and facility_id='+string(li_facility_id),1,ll_last_cnt)
				//end of modify
				if ll_r>0 then 
					li_last_seq_no = lds_last_verif_seq_no.getitemnumber(ll_r,'last_seq_no')
				else
					setnull(li_last_seq_no)	
				end if
				
				IF IsNull( li_last_seq_no ) THEN
					li_last_seq_no = 0
				END IF
				li_last_seq_no++
				//<add> 06/27/2007 by: Andy
				ll_prac_id_first     = ll_prac_id
				li_facility_id_first = li_facility_id
			end if
			//end of add
			
			lds_verif_info.SetItem( li_nr, "seq_no", li_last_seq_no )
			lds_verif_info.SetItem( li_nr, "screen_id", 1 )	
			lds_verif_info.SetItem( li_nr, "verification_method", ll_exp_ltr )	
			lds_verif_info.SetItem( li_nr, "priority_user", "Public" )	
			lds_verif_info.SetItem( li_nr, "priority", 2 )	
			lds_verif_info.SetItem( li_nr, "active_status", 1 )
			lds_verif_info.SetItem( li_nr, "exp_credential_flag", 1 )
			lds_verif_info.SetItem( li_nr, "print_flag", 1 )
			ls_doc_id = String( ll_rec_id ) + "-" + String( ll_prac_id ) + "-" + String( li_facility_id ) + "-" +  String( li_last_seq_no )	
			lds_verif_info.SetItem( li_nr, "doc_id", ls_doc_id )
			lds_verif_info.SetItem( li_nr, "expiration_date", ld_exp_date )  //Start Code Change ----02.12.2015 #V14.2 maha
//			 R.Avital v11.3
//		   	Get create_user from verify_info
//				Begin changes
			// maha modified 08.03.2011
//			ls_user = lds_verif_info.GetItemString(li_nr, 'create_date', Primary!, FALSE)
//			IF IsNull(ls_user) OR Trim(ls_user) = '' THEN  
//				ls_user = Trim(gs_user_id)
				lds_verif_info.SetItem(li_nr, 'create_date', datetime(today(),Now()))
				lds_verif_info.SetItem(li_nr, 'create_user', "Sys-AIQ")
				
//			ELSE
//				lds_verif_info.SetItem(li_nr, 'mod_date', String(Now(), 'yyyy-mm-dd hh:m:ss'))
//				lds_verif_info.SetItem(li_nr, 'mod_user', gs_user_id)
//			END IF
			// R.Avital v11.3	END changes
			
		End If
		
	END FOR
	
	IF lds_verif_info.Update() <> 1 THEN
		choose case tp
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2007.08.31 By: Jack
			//$<reason> Fix a defect.
			/*				
			case 3 //exp appointments
				MessageBox("Update Failed", "Expiring Appointment update to verif_info table failed!" )
			case 2 //exp provisional
				MessageBox("Update Failed", "Expiring Provisional update to verif_info table failed!" )
			case 1 //exp allied health
				MessageBox("Update Failed", "Expiring Allied Health update to verif_info table failed!" )
			*/
			case 3 //exp appointments
  				//MessageBox("Update Failed", "Failed to update Expiring Appointment to verif_info table!" )
				//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
				inv_message.of_MessageBox("Update Failed", "Failed to update Expiring Appointment to verif_info table!",true)  
			case 2 //exp provisional
  				//MessageBox("Update Failed", "Failed to update Expiring Provisional to verif_info table!" )
				//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
				inv_message.of_MessageBox("Update Failed", "Failed to update Expiring Provisional to verif_info table!",true)  
			case 1 //exp allied health
  				//MessageBox("Update Failed", "Failed to update Expiring Allied Health to verif_info table!" )
				inv_message.of_MessageBox("Update Failed", "Failed to update Expiring Allied Health to verif_info table!",true ) 
			//---------------------------- APPEON END ----------------------------
		end choose
		Return -1
	END IF
	
	COMMIT USING SQLCA;  

next
//---------------------------- APPEON END ----------------------------
//Added for work flow. Trigger of the related work flow for practitioner expiring appointment. 2/11/2006 Henry
ll_r = upperbound(ll_prac_ids)
If ll_r > 0 and gb_workflow Then
	n_cst_workflow_triggers lnv_triggers
	lnv_triggers = create n_cst_workflow_triggers
	str_action_item lstr_action[]
	for i = 1 to ll_r
		lstr_action[i].prac_id = ll_prac_ids[i]
		lstr_action[i].rec_id = ll_rec_ids[i]
		lstr_action[i].facility_id = ll_facility_ids[i]
		lstr_action[i].screen_id = ll_screen_ids[i]
		lstr_action[i].wf_id = ll_wf_ids[i]
	next
	
	if gb_autoschedule or ib_schedule then lnv_triggers.of_set_sched_flag(TRUE)//scheduler - alfee 03.09.2010
	
	lnv_triggers.of_workflow_triggers(lstr_action)
	
	if gb_autoschedule or ib_schedule then //scheduler - alfee 03.09.2010
		string ls_message
		ls_message = lnv_triggers.of_get_sched_msg( )
		if LenA(ls_message) > 0 then inv_message.of_messagebox('', ls_message, true)
	end if
	
	destroy lnv_triggers
End If
//End added for Work Flow

DESTROY lds_exp_appointments_1
DESTROY lds_exp_appointments_2
DESTROY lds_exp_appointments_3
DESTROY lds_last_verif_seq_no
DESTROY lds_verif_info

Return 0
end function

public function integer of_reverify_credentials ();//lds_reapp = CREATE n_ds
//lds_reapp.DataObject = adw_ver_copy.DataObject 
//lds_reapp.of_SetTransObject( SQLCA )
//adw_ver_copy.ShareData( lds_reapp )
//
//lds_exp_copy = CREATE n_ds
//lds_exp_copy.DataObject = "d_copy_verification"
//lds_exp_copy.of_SetTransObject( SQLCA )
//
//li_row_cnt = lds_reapp.RowCount()
//
//IF li_row_cnt = 0 THEN
//	Return 0
//END IF
//
//FOR i = 1 TO li_row_cnt
//	//if credential has (not) been selected then it does not have to be verified
//	IF lds_reapp.GetItemNumber( i, "selected" ) = 0 THEN
//		CONTINUE
//	END IF
//	lds_reapp.RowsCopy(i, i, Primary!, lds_exp_copy, 100000, Primary!)
//	li_seq_no = lds_reapp.GetItemNumber( i, "seq_no" )
//	li_seq_no++
//	li_nr = lds_exp_copy.RowCount()
//	lds_exp_copy.SetItem( li_nr , "seq_no", li_seq_no )
//	lds_exp_copy.SetItem( li_nr, "first_sent", nulldate )
//	lds_exp_copy.SetItem( li_nr, "last_sent", nulldate )
//	lds_exp_copy.SetItem( li_nr, "number_sent", 0 )
//	lds_exp_copy.SetItem( li_nr, "date_recieved", nulldate )
//	lds_exp_copy.SetItem( li_nr, "user_name", "" )
//	lds_exp_copy.SetItem( li_nr, "response_code", nullint )
//	lds_exp_copy.SetItem( li_nr, "priority_user", "PUBLIC" )
//	lds_exp_copy.SetItem( li_nr, "priority", 2 )
//	lds_exp_copy.SetItem( li_nr, "exp_credential_flag", 0)
//	//find out what the user has selected for the new verificatin method
//	ll_new_ver_method = lds_reapp.GetItemNumber( i, "new_verification_method" )
//	lds_exp_copy.SetItem( li_nr, "verification_method", ll_new_ver_method )
//	ls_doc_id = String( lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) )
//	ll_prac_id = lds_exp_copy.GetItemNumber( li_nr, "prac_id" )
//	ls_doc_id = ls_doc_id + String( ll_prac_id )
//	ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "facility_id" ) )
//	ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "seq_no" ) )
//	lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
//	lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
//	//make current verif entry inactive
//	lds_reapp.SetItem( i, "active_status", 0 )
//END FOR

RETURN 0
end function

public function integer of_dialphone (string as_phone);String ls_dialer_path
String ls_dialer_ini_path

ls_dialer_ini_path = ProfileString(gs_IniFilePathName, "Paths","dialer_ini_path", "None")

SetProfileString( ls_dialer_ini_path + "dialer.ini", "Speed Dial Settings", "Name1", "IntelliCred" )
SetProfileString( ls_dialer_ini_path + "dialer.ini", "Speed Dial Settings", "Number1", as_phone )
ls_dialer_path = ProfileString(gs_IniFilePathName, "Paths","dialer", "None")

Run( ls_dialer_path + "dialer.exe")

Return 0
end function

public function integer of_copy_required_data (long ll_appt_stat_id, integer ai_app_audit_facility_id, integer ai_parent_facility_id, long al_prac_id);n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
n_ds ldw_audit
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
String ls_version

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> Performance tuning. There is no need for the Web application to read local INI files. The Web application
//$<reason> reads INI files from the server.
//$<modification> Write the following script to make sure when IntelliCred runs on the Web, it does not read the local
//$<modification> INI files.

//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
//	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2007.08.31 By: Jack
		//$<reason> Fix a defect.
		/*
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		*/
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		//---------------------------- APPEON END ----------------------------
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

IF ls_version = "None" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Error", "Version number not setup.")
	*/
	MessageBox("Error", "Version number is not setup.")
	//---------------------------- APPEON END ----------------------------
	RETURN -1
END IF

//app audit
IF MidA( ls_version, 11, 1) <> "4" THEN
	RETURN 0
END IF


ldw_audit = CREATE n_ds
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.of_SetTransObject( SQLCA )

ldw_rqrd_data = CREATE n_ds
ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
ldw_rqrd_data.of_SetTransObject( SQLCA )

li_row_cnt = ldw_rqrd_data.Retrieve( ai_app_audit_facility_id, 'R' )

//<add> 06/27/2007 by: Andy set sort first
ldw_rqrd_data.setsort("app_audit_id A")
ldw_rqrd_data.sort()

Long    ll_app_audit_id_first= -1
//end of add

lds_last_app_audit_seq_no = CREATE n_ds
lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
lds_last_app_audit_seq_no.of_SetTransObject( SQLCA )

FOR i = 1 TO li_row_cnt
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.InsertRow( 0 )
	*/
	integer li_auto_generate,li_row
	li_auto_generate = ldw_rqrd_data.getitemnumber(i,'auto_generate')
	if li_auto_generate = 1 then
		continue
	end if
	li_row = ldw_audit.InsertRow( 0 )
	//---------------------------- APPEON END ----------------------------
	ll_record_id = gnv_app.of_get_id("RECORD_ID")
	ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.18.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "rec_id", ll_record_id )
	ldw_audit.SetItem( i, "appt_stat_id", ll_appt_stat_id )
	ldw_audit.SetItem( i, "prac_id", al_prac_id )
	ldw_audit.SetItem( i, "facility_id", ai_parent_facility_id )
	ldw_audit.SetItem( i, "app_audit_id", ll_app_audit_id )
	*/
	ldw_audit.SetItem( li_row, "rec_id", ll_record_id )
	ldw_audit.SetItem( li_row, "appt_stat_id", ll_appt_stat_id )
	ldw_audit.SetItem( li_row, "prac_id", al_prac_id )
	ldw_audit.SetItem( li_row, "facility_id", ai_parent_facility_id )
	ldw_audit.SetItem( li_row, "app_audit_id", ll_app_audit_id )
	
	//---------------------------- APPEON END ----------------------------
	
	//<add> 06/27/2007 by: Andy fixed a bug. 
	//attention:set sort first
	if ll_app_audit_id_first = ll_app_audit_id then 
		ll_seq_no++
	else
	//end of add
		//find out the last seq no used
		ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, al_prac_id, ai_app_audit_facility_id )	
		IF ll_seq_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		//<add> 06/27/2007 by: Andy 
		ll_app_audit_id_first = ll_app_audit_id
	end if
	//end of add
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	/*
	ldw_audit.SetItem( i, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( i, "active_status", 1 )
	ldw_audit.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		
	*/
	ldw_audit.SetItem( li_row, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( li_row, "active_status", 1 )
	ldw_audit.SetItem( li_row, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( li_row, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		
	ldw_audit.SetItem( li_row, "app_type", ldw_rqrd_data.GetItemString( i, "app_type" )	)		
	//---------------------------- APPEON END ----------------------------
END FOR

IF ldw_audit.Update() = -1 THEN
	messagebox("", sqlca.sqlerrtext)
	MessageBox( "Update Error" , "Error updating application audit data.")
	Return -1
END IF

DESTROY ldw_audit
DESTROY ldw_rqrd_data
DESTROY ldw_app_audit_facility
DESTROY lds_last_app_audit_seq_no

RETURN 0

end function

public function integer of_start_reappointment_processing (u_dw adw_ver_copy, u_dw adw_action_items, integer ai_parent_facility, long al_prac_id, string as_ver_type);
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 02.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define datastores for caching data.

/*
n_ds lds_last_app_audit_seq_no
n_ds 
n_ds lds_appt_dept
n_ds lds_appt_comms
n_ds lds_appt_leave
n_ds lds_appt_staff_cat
*/

//datastore lds_last_app_audit_seq_no
//datastore ldw_rqrd_data
datastore lds_appt_dept
datastore lds_appt_comms
datastore lds_appt_leave
datastore lds_appt_staff_cat
Long ll_verif_info_maxseqno
//---------------------------- APPEON END ----------------------------
datawindow ldw_audit
n_ds lds_reapp
//n_ds lds_reapp_copy
n_ds lds_action_items
n_ds lds_exp_copy
n_ds lds_appt_stat

Long ll_seq_row_cnt
Integer ll_exp_appt_ltr  
Integer li_retval
Long li_row_cnt
Integer i
integer t //maha 110800
integer trows //maha 110800
Long ll_seq_no
Integer li_nr
Integer nullint
Integer li_action_item_row
long li_parent_facility_id
long li_audit_facility_id
long li_verif_facility_id
Integer li_facility_row_cnt
integer li_set23 //maha 121602
integer li_set32 //maha 121602
integer li_no_copy  = 0//maha 030304

String ls_version
String ls_doc_id
String ls_rec_id
string ls_assn_user  //Start Code Change ---- 10.03.2006 #640 maha

Long ll_appt_stat_id
//Long ll_prac_id
Long ll_rec_id
Long ll_new_rec_id
Long ll_new_ver_method
Long ll_response_code  
Long ll_record_id
Long ll_app_audit_id
long ll_test1 //maha 110800
long ll_test2 //maha 110800

DateTime nulldate
DateTime dt_cust4
DateTime dt_prior_start
DateTime dt_prior_end
datetime ldt_now //maha 08.03.2011

SetNull( nullint )
SetNull( nulldate )

ldt_now = datetime(today(),Now())

adw_ver_copy.AcceptText()

/* R.Avital v11.3
	Add create_user/mod_user and create_date/mod_date
	to any update of verif_info
	Begin changes
*/
String ls_user
String ls_date
// R.Avital v11.3 END changes


//create appointment store
lds_appt_stat = CREATE n_ds
lds_appt_stat.DataObject = "d_pd_affil_status"
lds_appt_stat.of_SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

datawindowchild dwchild
lds_appt_stat.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
lds_appt_stat.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
lds_appt_stat.Retrieve( al_prac_id, ai_parent_facility,gs_user_id ) //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 02.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
li_row_cnt = lds_appt_stat.rowcount()
//---------------------------- APPEON END ----------------------------

//filter only active record
lds_appt_stat.SetFilter( "active_status = 1" )
lds_appt_stat.Filter( )

if lds_appt_stat.rowcount() < 1 then //maha 010303
	messagebox("Status Error","Unable to find ACTIVE appointment record for this practitioner and facility.~n The active status of the practitioner's Appointment record must be set to Active to complete the recredentialing process")
	return -1
end if 
//get verifiying facility
li_verif_facility_id = lds_appt_stat.GetItemNumber( 1, "verifying_facility" )

//\/******************* Verification creation *************************************
//create verif store
if as_ver_type <> "NOVER" then
	lds_reapp = CREATE n_ds
	lds_reapp.DataObject = adw_ver_copy.DataObject //adw_ver_copy should be d_copy_verification
	lds_reapp.of_SetTransObject( SQLCA )
	adw_ver_copy.ShareData( lds_reapp )
	//ll_prac_id = al_prac_id
	//messagebox("",gl_prac_id)
	//return -1
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<comment> 02.16.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Move the following script to PT-10. It is integrated with other SQL statements
	//$<modification> into Appeon Queue labels to reduce client-server interactions.
	/*
	li_row_cnt = lds_appt_stat.Retrieve( al_prac_id, ai_parent_facility,gs_user_id )
	*/
	//---------------------------- APPEON END ----------------------------
	
//	//create store to update active status this is lds_reapp without and deleted duplicates from other facilities 
//	lds_reapp_copy = CREATE n_ds
//	lds_reapp_copy.DataObject = "d_copy_verification"
//	lds_reapp_copy.of_SetTransObject( SQLCA )
//	li_retval = lds_reapp.RowsCopy(1,lds_reapp.rowcount() , Primary!, lds_reapp_copy, 100000, Primary!)
//	IF li_retval = -1 THEN
//		Messagebox("Error","Error copying to lds_reapp_copy")
//		Return -1
//	END IF
	//create copy store
	lds_exp_copy = CREATE n_ds
	lds_exp_copy.DataObject = "d_copy_verification"
	lds_exp_copy.of_SetTransObject( SQLCA )
	
	li_row_cnt = lds_reapp.RowCount()
	
	IF li_row_cnt = 0 THEN
		Return 0
	END IF

	//\/maha 110800 to test for duplicate verifications
	trows = li_row_cnt
	FOR i = 1 TO li_row_cnt //test for duplicate verifications
		IF lds_reapp.GetItemNumber( i, "selected" ) = 1 THEN
			ll_test1 = lds_reapp.GetItemNumber( i, "rec_id" )
			for t = 1 to trows
				IF lds_reapp.GetItemNumber( t, "selected" ) = 1 THEN
					ll_test2 = lds_reapp.GetItemNumber( t, "rec_id" )
					if i <> t and ll_test1 = ll_test2 then
						messagebox("Copy Error","There are duplicate records selected for reverification.~n~rPlease deselect the duplicates")
						return 0
					end if
				end if
			next
		end if
	next
	//\maha

	//<add> 06/27/2007 by: Andy set sort first
	lds_reapp.setsort("rec_id A, facility_id A")
	lds_reapp.sort()
	
	Long    ll_rec_id_first      = -1
	Integer li_facility_id_first = -1
	//end of add

	ll_seq_no = 0
	FOR i = 1 TO li_row_cnt   
		if lds_reapp.GetItemNumber( i, "facility_id" ) = li_verif_facility_id then //maha 011603 only reset active status if is the same facility
			lds_reapp.SetItem( i, "active_status", 0 )
			//Start Code Change ----08.03.2011 #V11 maha - set mod values
			lds_reapp.SetItem( i, "mod_user", gs_user_id )
			lds_reapp.SetItem( i, "mod_date", ldt_now)
			//End Code Change ----08.03.2011 

		end if
		//if credential has (not) been selected then it does not have to be reverified
		IF lds_reapp.GetItemNumber( i, "selected" ) = 0 THEN	
			CONTINUE
		END IF
		li_retval = lds_reapp.RowsCopy(i, i, Primary!, lds_exp_copy, 100000, Primary!)
		IF li_retval = -1 THEN
			Messagebox("Error","Error copying record")
			Return -1
		END IF
		//get just copied row number
		li_nr = lds_exp_copy.RowCount()
	
		ll_rec_id = lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) 
		
		//<add> 06/27/2007 by: Andy fixed a bug. 
		//attention:set sort first
		if ll_rec_id_first = ll_rec_id and li_facility_id_first = li_verif_facility_id then 
			ll_seq_no++
		else
		//end of add
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-13
		//$<modify> 02.21.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add a condition to make the application get the maximum value of
		//$<modification> ll_seq_no from database only in the first time when the following loop runs.
		/*
		The changed logic is incorrect.  The seq_no should be the max for practitioner/facility combination only.
		Changed back to original code. //Start Code Change ---- 10.03.2006 #641 maha
		*/
			SELECT Max( seq_no )  
			INTO :ll_seq_no  
			FROM verif_info  
			WHERE verif_info.rec_id = :ll_rec_id  and facility_id = :li_verif_facility_id; 
		
			/*
			IF ll_seq_no = 0 THEN
				SELECT Max( seq_no )  
				INTO :ll_seq_no  
				FROM verif_info;
			END IF
			*/
			//---------------------------- APPEON END ----------------------------
	
			if isnull(ll_seq_no) then ll_seq_no = 0
			ll_seq_no++
			//<add> 06/27/2007 by: Andy
			ll_rec_id_first = ll_rec_id
			li_facility_id_first = li_verif_facility_id
		end if
		//end of add
	
		lds_exp_copy.SetItem( li_nr , "facility_id", li_verif_facility_id )
		lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
		lds_exp_copy.SetItem( li_nr, "first_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "last_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "number_sent", 0 )
		lds_exp_copy.SetItem( li_nr, "date_recieved", nulldate )
		lds_exp_copy.SetItem( li_nr, "user_name", "" )
		lds_exp_copy.SetItem( li_nr, "response_code", nullint )
		//lds_exp_copy.SetItem( li_nr, "priority_user", "PUBLIC" ) //removed 010703
		lds_exp_copy.SetItem( li_nr, "priority", 2 )
		lds_exp_copy.SetItem( li_nr, "exp_credential_flag", 0)
		//find out what the user has selected for the new verificatin method
		ll_new_ver_method = lds_reapp.GetItemNumber( i, "new_verification_method" )
		lds_exp_copy.SetItem( li_nr, "verification_method", ll_new_ver_method )
		//concantenate doc_id
		ls_doc_id = String(ll_rec_id) + "-" + string(al_prac_id) + "-" + string(li_verif_facility_id) + "-" + string(ll_seq_no)
		lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
		lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
		//make current verif entry inactive
		lds_exp_copy.SetItem( li_nr, "verif_info_notes", "" ) // added 092800 maha
		lds_exp_copy.SetItem( li_nr, "active_status", 1 )
		//Start Code Change ----08.03.2011 #V11 maha - cleart prior mod values and add create
		lds_exp_copy.SetItem( li_nr, "mod_user", "" )
		lds_exp_copy.SetItem( li_nr, "mod_date", nulldate )
		lds_exp_copy.SetItem(li_nr, 'create_date', datetime(today(),now()))
		lds_exp_copy.SetItem(li_nr, 'create_user', gs_user_id + "-R")
		//End Code Change ----08.03.2011 
	END FOR
END IF	
//\******************* end of verification creation *************************************




	
li_parent_facility_id = ai_parent_facility


lds_appt_stat.SetItem( 1, "active_status", 0 )
//grab the last sequence number
ll_seq_no = lds_appt_stat.GetItemNumber( 1, "seq_no" )
ll_rec_id = lds_appt_stat.GetItemNumber( 1, "rec_id" )
//grab the audit and verifying and app audit facility id(s)
li_audit_facility_id = lds_appt_stat.GetItemNumber( 1, "application_audit_facility" )
li_verif_facility_id = lds_appt_stat.GetItemNumber( 1, "verifying_facility" )
dt_prior_start = lds_appt_stat.GetItemdatetime( 1, "apptmnt_start_date" )
dt_prior_end = lds_appt_stat.GetItemdatetime( 1, "apptmnt_end_date" )
//get a new record id
ll_new_rec_id = gnv_app.of_get_id("RECORD_ID")

//Start Code Change ---- 10.03.2006 #642 maha
select reap_user into :i from facility where facility_id = :li_parent_facility_id;
if isnull(i) then i = 0
choose case i
	case 0 //default
		ls_assn_user = "PUBLIC"
	case 1 //copy
		ls_assn_user = lds_appt_stat.GetItemstring( 1, "priority_user" )
	case 2 //current user
		ls_assn_user = gs_user_id
end choose
//End Code Change---10.03.2006

ll_appt_stat_id = ll_new_rec_id
//add a new row to appointment status
li_nr = lds_appt_stat.InsertRow( 0 )
lds_appt_stat.SetItem( li_nr, "rec_id", ll_new_rec_id )
lds_appt_stat.SetItem( li_nr, "prac_id", al_prac_id )
lds_appt_stat.SetItem( li_nr, "parent_facility_id", li_parent_facility_id )
ll_seq_no++
lds_appt_stat.SetItem( li_nr, "seq_no", ll_seq_no )
lds_appt_stat.SetItem( li_nr, "verifying_facility", li_verif_facility_id )
lds_appt_stat.SetItem( li_nr, "application_audit_facility", li_audit_facility_id )
lds_appt_stat.SetItem( li_nr, "apptmnt_type", "R" )
lds_appt_stat.SetItem( li_nr, "affiliation_status", lds_appt_stat.GetItemstring( 1, "affiliation_status" ) )//maha 112102
lds_appt_stat.SetItem( li_nr, "inital_appmnt_date", lds_appt_stat.GetItemdatetime( 1, "inital_appmnt_date" ) )//maha 112102
lds_appt_stat.SetItem( li_nr, "prior_appt_start", dt_prior_start )//maha 071403
lds_appt_stat.SetItem( li_nr, "prior_appt_end", dt_prior_end )//maha 071403
lds_appt_stat.SetItem( li_nr, "prov_status", 0 )//maha 092303
lds_appt_stat.SetItem( li_nr, "admit_priv", lds_appt_stat.GetItemnumber( 1, "admit_priv" ) )  //Start Code Change ---- 05.14.2007 #V7 maha
lds_appt_stat.SetItem( li_nr, "priority_user", ls_assn_user ) //Start Code Change ---- 10.03.2006 #643 maha
lds_appt_stat.SetItem( li_nr, "in_good_standing", lds_appt_stat.GetItemnumber( 1, "in_good_standing" ) )  //Start Code Change ----11.24.2014 #V14.2 maha - from other function

//SELECT set_23 INTO :li_set23 FROM icred_settings;
li_set23 = of_get_app_setting("set_23","I")
IF li_set23 = 1 THEN //copy cust 4
	dt_cust4 =  lds_appt_stat.GetItemdatetime( 1, "custom_4" ) //maha 121602 lij
	lds_appt_stat.SetItem( li_nr, "custom_4",dt_cust4 )
elseif li_set23 = 2 THEN //copy all custom
	debugbreak()
	lds_appt_stat.SetItem( li_nr, "custom_1", lds_appt_stat.GetItemstring( 1, "custom_1" )  )
	lds_appt_stat.SetItem( li_nr, "custom_2", lds_appt_stat.GetItemstring( 1, "custom_2" ) )
	lds_appt_stat.SetItem( li_nr, "custom_3", lds_appt_stat.GetItemstring( 1, "custom_3" ) )
	lds_appt_stat.SetItem( li_nr, "custom_4", lds_appt_stat.GetItemdatetime( 1, "custom_4" ) )
	lds_appt_stat.SetItem( li_nr, "custom_5", lds_appt_stat.GetItemdatetime( 1, "custom_5" ) )
end if

//staff category
//SELECT set_32 INTO :li_set32 FROM icred_settings; //inova rules maha 092303
li_set32 = of_get_app_setting("set_32","I")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Integrate the SQL statements in the following script and integrate
//$<modification> them into Appeon Queue labels to reduce client-server interactions.
//$<modification> Refer to PT-15/16/17/18 for more information.

lds_appt_staff_cat = CREATE datastore
lds_appt_staff_cat.DataObject = "d_pd_affil_staff_cat"
lds_appt_staff_cat.SetTransObject( SQLCA )

//department info
lds_appt_dept = CREATE datastore
lds_appt_dept.DataObject = "d_pd_affil_departments"
lds_appt_dept.SetTransObject( SQLCA )

//credentialing review commitee(s)
lds_appt_comms = CREATE datastore
lds_appt_comms.DataObject = "d_pd_comm_review"
lds_appt_comms.SetTransObject( SQLCA )

//leave info
lds_appt_leave = CREATE datastore
lds_appt_leave.DataObject = "d_pd_affil_leave"
lds_appt_leave.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_appt_staff_cat.Retrieve( ll_rec_id,gs_user_id )
lds_appt_dept.Retrieve( ll_rec_id,gs_user_id )
lds_appt_comms.Retrieve( ll_rec_id, gs_user_id )
lds_appt_leave.Retrieve( ll_rec_id, gs_user_id )

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<modify> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-14 and it is integrate with
//$<modification> other SQLs into Appeon labels to reduce client-server interactions.

/*
lds_appt_staff_cat = CREATE n_ds
lds_appt_staff_cat.DataObject = "d_pd_affil_staff_cat"
lds_appt_staff_cat.of_SetTransObject( SQLCA )
li_row_cnt = lds_appt_staff_cat.Retrieve( ll_rec_id,gs_user_id )
*/

li_row_cnt = lds_appt_staff_cat.Rowcount( )

//---------------------------- APPEON END ----------------------------

IF li_row_cnt > 0 THEN
	lds_appt_staff_cat.SetSort("seq_no")
	lds_appt_staff_cat.Sort()
	ll_seq_no = lds_appt_staff_cat.GetItemNumber( li_row_cnt , "seq_no" )
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		li_no_copy = 0
		//code rearranged 030304 maha
		//copy all records unless setting is 1 and the record is inactive
		//traditional method clears dates and set to active requested
		//set to 1 (inova) leaves dates and checks the values of the requested status
		IF li_set32 = 1 or li_set32 = 3 THEN //inova  //Start Code Change ----11.16.2012 #V12 maha - mod for kaleida
			if lds_appt_staff_cat.getItemnumber( i, "requested" ) = 0 then //dont copy inactive maha 081403
				li_no_copy = 1
			end if
		end if
		if li_no_copy = 0 then
			lds_appt_staff_cat.RowsCopy( i, i, Primary!, lds_appt_staff_cat, 1000, Primary! )
			lds_appt_staff_cat.SetItem( i, "active_status", 0 )
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "rec_id", ll_new_rec_id )
			
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "active_status", 1 )
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "seq_no", ll_seq_no )
			if li_set32 < 1 then //standard method null dates
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "from_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "to_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 1 )
		
			elseif li_set32 = 1 then  //inova requested rules maha 092303
				if not isnull(lds_appt_staff_cat.GetItemdatetime( i , "to_date" )) then
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 0 ) //history
				elseif not isnull(lds_appt_staff_cat.GetItemdatetime( i , "from_date" )) then
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 1 ) //active
				else
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 2 ) //requested
				end if
			elseif li_set32 = 3 then  //Start Code Change ----11.16.2012 #V12 maha - mod for kaleida
				//don't modify requested status
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "from_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "to_date", nulldate )
			end if
		end if
			
	END FOR
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<modify> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-14 and it is integrate with
//$<modification> other SQLs into Appeon labels to reduce client-server interactions.

/*
//department info
lds_appt_dept = CREATE n_ds
lds_appt_dept.DataObject = "d_pd_affil_departments"
lds_appt_dept.of_SetTransObject( SQLCA )
li_row_cnt = lds_appt_dept.Retrieve( ll_rec_id,gs_user_id )
*/

li_row_cnt = lds_appt_dept.Rowcount( )

//---------------------------- APPEON END ----------------------------

IF li_row_cnt > 0 THEN
	lds_appt_dept.SetSort("seq_no")
	lds_appt_dept.Sort()
	ll_seq_no = lds_appt_dept.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		lds_appt_dept.RowsCopy( i, i, Primary!, lds_appt_dept, 1000, Primary! )
		lds_appt_dept.SetItem( i, "active_status", 0 )
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "active_status", 1 )
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "seq_no", ll_seq_no )		
	END FOR
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-17
//$<modify> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-14 and it is integrate with
//$<modification> other SQLs into Appeon labels to reduce client-server interactions.

/*
//credentialing review commitee(s)
lds_appt_comms = CREATE n_ds
lds_appt_comms.DataObject = "d_pd_comm_review"
lds_appt_comms.of_SetTransObject( SQLCA )
li_row_cnt = lds_appt_comms.Retrieve( ll_rec_id, gs_user_id )
*/

li_row_cnt = lds_appt_comms.Rowcount( )

//---------------------------- APPEON END ----------------------------

IF li_row_cnt > 0 THEN
	lds_appt_comms.SetSort( "seq_no" )
	lds_appt_comms.Sort()
	ll_seq_no = lds_appt_comms.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++				
		lds_appt_comms.RowsCopy( i, i, Primary!, lds_appt_comms, 1000, Primary! )
		lds_appt_comms.SetItem( i, "active_status", 0 )//set org record to history
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "active_status", 1 )
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "review_results", nullint )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "date_back_from_review", nulldate )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "date_sent_for_review", nulldate )
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "seq_no", ll_seq_no )				
	END FOR
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<modify> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to PT-14 and it is integrate with
//$<modification> other SQLs into Appeon labels to reduce client-server interactions.

/*
//leave info
lds_appt_leave = CREATE n_ds
lds_appt_leave.DataObject = "d_pd_affil_leave"
lds_appt_leave.of_SetTransObject( SQLCA )
li_row_cnt = lds_appt_leave.Retrieve( ll_rec_id, gs_user_id )
*/

li_row_cnt = lds_appt_leave.Rowcount( )

//---------------------------- APPEON END ----------------------------

IF li_row_cnt > 0 THEN
	lds_appt_leave.SetSort("seq_no")
	lds_appt_leave.Sort()
	ll_seq_no = lds_appt_leave.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		lds_appt_leave.RowsCopy( i, i, Primary!, lds_appt_leave, 1000, Primary! )
		lds_appt_leave.SetItem( i, "active_status", 0 )
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "active_status", 1 )
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "seq_no", ll_seq_no )		
	END FOR
END IF

//add app audit list

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")


If appeongetclienttype() = 'PB' Then 
	IF NOT FileExists(gs_IniFilePathName) THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2007.08.31 By: Jack
		//$<reason> Fix a defect.
		/*
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		*/
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		//---------------------------- APPEON END ----------------------------
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

IF ls_version = "None" THEN
	//$<modify> 2007.08.31 By: Jack
	//$<reason> Fix a defect.
	/*
	MessageBox("Error", "Version number not setup.")
	*/
	MessageBox("Error", "Version number was not setup.")
	//---------------------------- APPEON END ----------------------------
	RETURN -1
END IF

//app audit
IF MidA( ls_version, 11, 1) <> "4" THEN
	RETURN 0
END IF


ldw_audit = CREATE datawindow
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.SetTransObject( SQLCA )


gnv_data.of_getitem( "code_lookup", 'lookup_code', "upper(code) = 'APP-RCVD'")
gnv_data.of_getitem( "code_lookup", 'lookup_code', "upper(code) = upper('Exp Appt Ltr')")
//---------------------------- APPEON END ----------------------------

IF adw_action_items.RowCount() > 0 THEN
	for i = 1 to adw_action_items.Rowcount( )	
		IF adw_action_items.GetItemNumber( i, "verification_method" ) = ll_exp_appt_ltr THEN
			if	adw_action_items.GetItemNumber( i, "prac_id" ) = al_prac_id and adw_action_items.GetItemNumber( i, "parent_facility_id" ) = ai_parent_facility then //trap for act items maha092503
				if isnull(adw_action_items.getItemdatetime( i, "date_recieved")) then
					adw_action_items.SetItem( i, "user_name", gnv_app.of_getuserid() )
					adw_action_items.SetItem( i, "date_recieved", Today() )
				end if
				if not isnull(ll_response_code) and ll_response_code <> 0 then //(Appeon)Harry 01.26.2015 -The INSERT statement conflicted with the FOREIGN KEY constraint "FK_verif_info1". 
					adw_action_items.SetItem( i, "response_code", ll_response_code  )
				end if
				adw_action_items.SetItem( i, "active_status", 0 )
				exit //once found drop loop
			end if
		END IF
	next
END IF


//commit work
commit;
sqlca.autocommit = false
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.18.2006 By: Jack (Inova)
//$<reason> Required Documents Check Box on Data Entry Screen.
long ll_prac_id[]
long ll_rec_id1[]
pfc_cst_nv_data_entry_functions lnv_data_entry
lnv_data_entry = create pfc_cst_nv_data_entry_functions
//---------------------------- APPEON END ----------------------------
// R.Avital v11.3 Begin Changes

SELECT create_date INTO :ls_user FROM verif_info
WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
USING SQLCA;
// R.Avital v11.3 END Changes

IF  as_ver_type <> "NOVER" then  //initiate recred process
	gnv_appeondb.of_startqueue( )
		
		lds_reapp.update(true,false)
		lds_exp_copy.update(true,false)
		adw_action_items.update(true,false)
		lds_appt_stat.update(true,false)
		lds_appt_staff_cat.update(true,false)
		lds_appt_dept.update(true,false)
		lds_appt_comms.update(true,false)
		lds_appt_leave.update(true,false)
		ldw_audit.update(true,false)
		
	gnv_appeondb.of_commitqueue( )
	
	//Open up window with new appointment status information
	gl_facility_id = li_parent_facility_id
	gl_prac_id = al_prac_id
	gs_param = "REAPP"
	Open( w_back_from_committee )
	IF Message.StringParm = "Cancel" THEN
		ROLLBACK USING SQLCA;
		sqlca.autocommit = true
		
		RETURN -1
	END IF
	
	lds_reapp.ResetUpdate()
	lds_exp_copy.ResetUpdate()
	adw_action_items.ResetUpdate()
	lds_appt_staff_cat.ResetUpdate()
	lds_appt_dept.ResetUpdate()
	lds_appt_stat.ResetUpdate()
	lds_appt_comms.ResetUpdate()
	adw_action_items.ResetUpdate()
	lds_appt_leave.ResetUpdate()
	ldw_audit.ResetUpdate()
//	ldw_rqrd_data.ResetUpdate()
//	lds_last_app_audit_seq_no.ResetUpdate()

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-01-25 By: Rodger Wu (attest quest)
	//$<reason> Generate attest questions from question template.
	//lnv_data_entry.of_generate_attest_questions( "reapp", ai_parent_facility, al_prac_id, ll_new_rec_id )
	//---------------------------- APPEON END ----------------------------

//	// R.Avital v11.3 Begin Changes
//	ls_date = String(Now(), 'yyyy-mm-dd hh:mm:ss')
//	IF IsNull(ls_user) OR Trim(ls_user) = '' THEN
//		ls_user = Trim(gs_user_id)
//		
//		UPDATE verif_info
//		SET create_date = :ls_date,
//			 create_user = :ls_user
//		WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//		USING SQLCA;
//	ELSE
//		UPDATE verif_info
//		SET mod_date = :ls_date,
//			 mod_user = :gs_user_id
//		WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//		USING SQLCA;
//	END IF
//
//COMMIT USING SQLCA;
//// R.Avital v11.3 END Changes

	gnv_appeondb.of_startqueue( )
		// move npdb, corresp letters etc. to history  //maha added here 03073
		//Start Code Change ----08.03.2011 #V11 maha -
	//	update verif_info set active_status = 0 where screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id;
		update verif_info set active_status = 0,mod_date = :ldt_now, mod_user = :gs_user_id where screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id and active_status = 1;
		//End Code Change ----08.03.2011 #V11
		//Start Code Change ----09.20.2010 #V10 maha - added reset of attest questions		
		update pd_attest_questions set active_status = 0 where prac_id = :al_prac_id and facility_id = :li_parent_facility_id;
		commit using sqlca;
	gnv_appeondb.of_commitqueue( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.18.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	ll_prac_id[1] = al_prac_id
	ll_rec_id1[1] = ll_rec_id
	ll_rec_id1[2] = ll_new_rec_id
	//long prac
//	lnv_data_entry.of_create_application_audit_record('R',ll_prac_id,0,ll_rec_id1,'')
	lnv_data_entry.of_app_audit_items_add( li_parent_facility_id, al_prac_id, ll_new_rec_id ,li_audit_facility_id,"Reapp",ldw_audit	, "R" )

	//destroy lnv_data_entry //Delete by Evan 12.08.2010
	
	//---------------------------- APPEON END ----------------------------

	sqlca.autocommit = true

	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 2007-01-26 By: Rodger Wu (attest quest)
	//$<reason> The following script line should be deleted.
	//Return 1
	//---------------------------- APPEON END ----------------------------

ELSE
	gnv_appeondb.of_startqueue( )

	
		adw_action_items.update(true,false)
		lds_appt_stat.update(true,false)
		lds_appt_staff_cat.update(true,false)
		lds_appt_dept.update(true,false)
		lds_appt_comms.update(true,false)
		lds_appt_leave.update(true,false)
		
	gnv_appeondb.of_commitqueue( )

	//Open up window with new appointment status information
	gl_facility_id = li_parent_facility_id
	gl_prac_id = al_prac_id
	gs_param = "REAPP"
	Open( w_back_from_committee )
		
	IF Message.StringParm = "Cancel" THEN
		ROLLBACK USING SQLCA;
		sqlca.autocommit = true
		RETURN -1
	END IF

	adw_action_items.ResetUpdate()
	lds_appt_staff_cat.ResetUpdate()
	lds_appt_dept.ResetUpdate()
	lds_appt_stat.ResetUpdate()
	lds_appt_comms.ResetUpdate()
	adw_action_items.ResetUpdate()
	lds_appt_leave.ResetUpdate()
	ldw_audit.ResetUpdate()
//	ldw_rqrd_data.ResetUpdate()
//	lds_last_app_audit_seq_no.ResetUpdate()

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-01-25 By: Rodger Wu (attest quest)
	//$<reason> Generate attest questions from question template.
//	lnv_data_entry.of_generate_attest_questions( "reapp", ai_parent_facility, al_prac_id, ll_new_rec_id )
	//---------------------------- APPEON END ----------------------------

//	// R.Avital v11.3 Begin Changes
//	ls_date = String(Now(), 'yyyy-mm-dd hh:mm:ss')
//	IF IsNull(ls_user) OR Trim(ls_user) = '' THEN
//		ls_user = Trim(gs_user_id)
//		
//		UPDATE verif_info
//		SET create_date = :ls_date,
//			 create_user = :ls_user
//		WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//		USING SQLCA;
//	ELSE
//		UPDATE verif_info
//		SET mod_date = :ls_date,
//			 mod_user = :gs_user_id
//		WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//		USING SQLCA;
//	END IF
//	COMMIT USING SQLCA;
//	// R.Avital v11.3 END Changes

	gnv_appeondb.of_startqueue( )
		// move npdb, corresp letters etc. to history  //maha added here 03073
		//Start Code Change ----08.03.2011 #V11 maha -
	//	update verif_info set active_status = 0 where screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id;
		update verif_info set active_status = 0,mod_date = :ldt_now, mod_user = :gs_user_id where screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id and active_status = 1;
		//End Code Change ----08.03.2011 #V11 maha -
		//Start Code Change ----09.20.2010 #V10 maha - added reset of attest questions		
		update pd_attest_questions set active_status = 0 where prac_id = :al_prac_id and facility_id = :li_parent_facility_id;
		commit using sqlca;
	gnv_appeondb.of_commitqueue( )
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.18.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	ll_prac_id[1] = al_prac_id
	ll_rec_id1[1] = ll_rec_id
	ll_rec_id1[2] = ll_new_rec_id
//	lnv_data_entry.of_create_application_audit_record('R',ll_prac_id,0,ll_rec_id1,'')
	lnv_data_entry.of_app_audit_items_add( li_parent_facility_id, al_prac_id, ll_new_rec_id ,li_audit_facility_id,"Reapp",ldw_audit	, "R" )

	//destroy lnv_data_entry //Delete by Evan 12.08.2010
	
	//---------------------------- APPEON END ----------------------------

	sqlca.autocommit = true

//	Return 1
END IF

//Start Code Change ----09.20.2010 #V10 maha - moved from twolocation inside if statement
//$<reason> Generate attest questions from question template.
lnv_data_entry.of_generate_attest_questions( "reapp", ai_parent_facility, al_prac_id, ll_new_rec_id )
//End Code Change ----09.20.2010

//Added for work Flow. Trigger the related work flow for practitioner reappointment. 2/11/2006 Henry
If gb_workflow Then //Enable the work flow
	long ll_wf_id
	ll_wf_id = long(gnv_data.of_getitem("facility", "facility_wf_reappointment_initiated" , "facility_id="+string(ai_parent_facility)))
	If ll_wf_id > 0 Then
		n_cst_workflow_triggers lnv_triggers
		lnv_triggers = create n_cst_workflow_triggers
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 11.17.2006 By: Jervis
		//$<reason> 
		//lnv_triggers.of_workflow_create_action_items( al_prac_id, 0, 1, ai_parent_facility, ll_wf_id)			
		str_action_item lstr_action
		lstr_action.prac_id = al_prac_id
		lstr_action.rec_id = 0
		lstr_action.screen_id = -10
		lstr_action.facility_id = ai_parent_facility
		lstr_action.wf_id = ll_wf_id
		lnv_triggers.of_workflow_create_action_items(lstr_action)
		//---------------------------- APPEON END ----------------------------
		destroy lnv_triggers
	End If
End If
//End added for Work Flow

IF as_ver_type = "NOVER" then
	DESTROY lds_exp_copy
	DESTROY lds_reapp
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.10.19 By: Frank.Gui
//$<reason> Change E-Sign flag
  UPDATE wv_esign_log  
     SET isdisabled = 1  
   WHERE ( wv_esign_log.facility_id = :ai_parent_facility ) AND  
         ( wv_esign_log.prac_id = :al_prac_id )   ;
//---------------------------- APPEON END ----------------------------
//DESTROY lds_last_app_audit_seq_no
//DESTROY ldw_rqrd_data
//End Code Change---10.30.2006
DESTROY ldw_audit
DESTROY lds_action_items
DESTROY lds_appt_dept
DESTROY lds_appt_comms
DESTROY lds_appt_stat
DESTROY lds_appt_staff_cat
DESTROY lds_appt_leave
destroy lnv_data_entry //Add by Evan 12.08.2010

RETURN 0

end function

public function integer of_expiring_credentials_from_data ();//Start Code Change ----10.13.2011 #V12 maha - testing as of this date shows that this funciton does not work
//last test, the facility array is not filled
//probably need to be re-written from scratch
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-23
//$<modify> 03.29.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Move the original scripts in of_expiring_credentials_from_data to of_expiring_credentials_from_data_old.
//$<modification> 2)Rewrite of_expiring_credentials_from_data.
//$<modification> The reason for the rewrite is: the original function hits the database over 1000 times and negatively affects
//$<modification> the runtime performance on the Web. After modification, the function hits the database only several times. 
//messagebox("Exp Cred","from data")
/*
//Original
of_expiring_credentials_from_data_old()
*/
long s
long sc
long d
long dc
long f
long fc
long cnt = 0
long tcnt = 0
integer chk
long ll_rec
long ll_prac
long ll_facil 
Long ll_seq
integer li_screen
string ls_screen_name
integer li_act_stat
integer li_complete = 1
long ll_resp_code = 2
long ll_verif_method = 1
string ls_ref_value
long ll_ref1no
string ls_datatype
long ll_ref1
long ll_ref2
long ll_ref_exp
integer li_days
string ls_ref1_lu
string ls_ref2_lu
string ls_ref1_lutype
string ls_ref2_lutype
string ls_ref1_dtype
string ls_ref2_dtype
string ls_ref1_lufield
string ls_ref2_lufield
string ls_ref1_name
string ls_ref2_name
string ls_refexp_name
string ls_priority_user
string ldw
integer li_priority
integer li_exp_flag
string ls_doc_id
integer exp_days
long ll_rowcount
long r
long ll_newrow
datetime ldt_exp_date
long ll_null_no
integer li_bs_year
datetime ld_exp
integer ll_code
integer ac
string ls_reference1
string ls_reference2
string ls_reference
integer li_month
datetime ldt_null_date
long ll_address_code
integer li_exp_days
date ld_exp_ret
integer li_found
integer clicks
long ll_lookup_address_r
integer li_option //maha 070909
long ll_exp_method  //maha 070909
long ll_psv_method //maha 070909
datastore lds_screen
datastore lds_facils
datastore lds_sys_field
datastore lds_verif
datastore lds_data

lds_screen = CREATE datastore
lds_screen.dataobject = "d_verif_screens_exp"
lds_facils = CREATE datastore
lds_facils.dataobject = "d_prac_affils_verif_forpt"
lds_sys_field = CREATE datastore
lds_sys_field.dataobject = "d_field_data_forpt"
lds_verif = CREATE datastore
lds_verif.dataobject = "d_verif_exp_4_record_forpt"
lds_verif.Settransobject(SQLCA)

//MSKINNER 15 MARCH 2005 -- BEGIN
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 100
//MSKINNER 15 MARCH 2005 -- END


setnull(ldt_null_date)
lds_sys_field.settransobject(sqlca)
lds_facils.settransobject(sqlca)
lds_screen.settransobject(sqlca)//d_verif_screens_exp
sc = lds_screen.retrieve()//gets all distinct verif rules where data_view = 1, screen > 1 and exp_days > 0 and the screen has an exp_field
if sc < 1 then 
	//messagebox("Expiring Credentials", "There are no verification rules set up for expiring Verifications.  Skipping this function.")
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Expiring Credentials", "There are no verification rules set up for expiring Verifications.  Skipping this function.",true)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.22.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_screen) then Destroy lds_screen
	if IsValid(lds_facils) then Destroy lds_facils
	if IsValid(lds_sys_field) then Destroy lds_sys_field
	if IsValid(lds_verif) then Destroy lds_verif
	//---------------------------- APPEON END ----------------------------	
	return -1
	
end if
ll_verif_method = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(code) = upper('Exp Cred Ltr')"))
if ll_verif_method < 1 then
	//messagebox("Missing Data", "You do not have a Verification Method lookup with the code of 'Exp Cred Ltr'.~rUnable to continue.")
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Missing Data", "You do not have a Verification Method lookup with the code of 'Exp Cred Ltr'.~rUnable to continue.",true)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.22.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_screen) then Destroy lds_screen
	if IsValid(lds_facils) then Destroy lds_facils
	if IsValid(lds_sys_field) then Destroy lds_sys_field
	if IsValid(lds_verif) then Destroy lds_verif
	//---------------------------- APPEON END ----------------------------	
	return -1
end if
clicks = integer(700/sc)

/*****         LOOP 1 BEGIN    *************************************************************************/
Long ll_ref1_arr[],ll_ref1_arr_i,ll_dataobject_arr_i,ll_dataobject_arr_cnt
String ls_dataobject, ls_dataobject_arr[]
Datastore lds_dataobject_arr[]
Boolean lb_existing

for s = 1 to sc //for each screen that has rules create the datastores and retrieve all records that are expiring
	li_screen = lds_screen.getitemnumber(s,"screen_id")
//	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1") //maha removed 10.13.2011
//	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")

	ll_ref1_arr_i ++
	ll_ref1_arr[ll_ref1_arr_i] = ll_ref1
	ll_ref1_arr_i ++
	ll_ref1_arr[ll_ref1_arr_i] = ll_ref2
	
	ls_dataobject = ""
	CHOOSE CASE li_screen
		CASE 4//"License"
			ls_dataobject = "d_exp_license_verif"
		CASE 5 //"DEA"
			ls_dataobject = "d_exp_dea_verif"
		CASE 9 //Special Certs
			ls_dataobject = "d_exp_spec_certs_verif"
		CASE 15 //"Insurance"
			ls_dataobject = "d_exp_insurance_verif"
		CASE 19 //"Board/Specialty"
			ls_dataobject = "d_exp_spec_verif"
		CASE 23 //Other Ids
			ls_dataobject = "d_exp_other_ids_verif"
		CASE else
			continue
	END CHOOSE
	if ls_dataobject = "" then
		continue
	end if

	lb_existing = FALSE
	FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
		IF ls_dataobject_arr[ll_dataobject_arr_i] = ls_dataobject THEN
			lb_existing = TRUE
			EXIT
		END IF
	END FOR
	
	IF NOT lb_existing THEN
		ll_dataobject_arr_cnt ++
		ls_dataobject_arr[ll_dataobject_arr_cnt] = ls_dataobject
		lds_dataobject_arr[ll_dataobject_arr_cnt] = Create Datastore
		lds_dataobject_arr[ll_dataobject_arr_cnt].Dataobject = ls_dataobject
		lds_dataobject_arr[ll_dataobject_arr_cnt].Settransobject( SQLCA )
	END IF
end for

gnv_appeondb.of_startqueue( )

lds_sys_field.Retrieve( ll_ref1_arr[] )

FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
	lds_dataobject_arr[ll_dataobject_arr_cnt].Retrieve( today() )  //retrieve the data from each screen
END FOR
	
gnv_appeondb.of_commitqueue( )
/*****         LOOP 1 END       *************************************************************************/

Long ll_code_arr[],ll_code_arr_i
Long ll_prac_arr[],ll_prac_arr_i
Integer li_screen_arr[],li_screen_arr_i

/*****         LOOP 2 BEGIN     *************************************************************************/
for s = 1 to sc //loop2 does two things- a) creates a list of address lookup codes; b) creates an array of pracs and of screens
	li_screen = lds_screen.getitemnumber(s,"screen_id")

	// get li_screen value in loop 2
	li_screen_arr_i ++
	li_screen_arr[li_screen_arr_i] = li_screen

	ls_screen_name = lds_screen.getitemstring(s,"screen_name")
	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
//	//Start Code Change ----07.09.2009 #V92 maha  //maha removed 10.13.2011
//	li_option = lds_screen.getitemnumber(s,"exp_options")
//	ll_psv_method = lds_screen.getitemnumber(s,"default_verif_means")
//	//End Code Change---07.09.2009
			//filter for the reference field and get progertys of that field
	lds_sys_field.SetFilter("field_id = " + String(ll_ref1))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref1  = 0
	else		//ref one data
		ls_ref1_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref1_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref1_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref1_lu = "Y" then
			ls_ref1_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref1_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if

	lds_sys_field.SetFilter("field_id = " + String(ll_ref2))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref2 = 0
	else	 //ref 2 data
		ls_ref2_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref2_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref2_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref2_lu = "Y" then
			ls_ref2_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref2_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if

	lds_sys_field.SetFilter("field_id = " + String(ll_ref_exp))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref_exp = 0
	else
		ls_refexp_name = lds_sys_field.getitemstring(1,"field_name")
	end if

	ls_dataobject = ""
	CHOOSE CASE li_screen
		CASE 4//"License"
			ls_dataobject = "d_exp_license_verif"
		CASE 5 //"DEA"
			ls_dataobject = "d_exp_dea_verif"
		CASE 9 //Special Certs
			ls_dataobject = "d_exp_spec_certs_verif"
		CASE 15 //"Insurance"
			ls_dataobject = "d_exp_insurance_verif"
		CASE 19 //"Board/Specialty"
			ls_dataobject = "d_exp_spec_verif"
		CASE 23 //Other Ids
			ls_dataobject = "d_exp_other_ids_verif"
		CASE else
			continue
	END CHOOSE
	if ls_dataobject = "" then
		continue
	end if
	
	//set the datastore to the appropriate screen
	FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
		IF ls_dataobject_arr[ll_dataobject_arr_i] = ls_dataobject THEN
			lds_data = lds_dataobject_arr[ll_dataobject_arr_i]
			EXIT
		END IF
	END FOR
	//get the rec count for that screen
	dc = lds_data.Rowcount()

	cnt = 0

	if dc < 1 then continue
	for d = 1 to dc
//		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")

		IF ll_ref_exp > 0 THEN
		ELSE
			continue
		END IF
	//*************** reference data *******************
	//this section is to get the list of lookup codes for addreess lookups
		IF ll_ref1 > 0 THEN
			IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
				ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
			elseif ls_ref1_dtype = "C" then
				ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
			elseif ls_ref1_dtype = "D" then
				ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
			end if
			if ls_ref1_lu = "Y" then
				ll_code = long(ls_reference1) 
				if ls_ref1_lutype = "A" then
					//get ll_code value in loop 2
					ll_code_arr_i ++
					ll_code_arr[ll_code_arr_i] = ll_code
				end if
			end if
		end if			
//		if isnull(ls_reference1) then ls_reference1 = ""
					
		//get reference 2 data
		IF ll_ref2 > 0 THEN
			IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
				ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
			elseif ls_ref2_dtype = "C" then
				ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
			elseif ls_ref2_dtype = "D" then
				ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
			end if
			if ls_ref2_lu = "Y" then
				ll_code = long(ls_reference2)
				if ls_ref2_lutype = "A" then
					//get ll_code value in loop 2
					ll_code_arr_i ++
					ll_code_arr[ll_code_arr_i] = ll_code
				end if
			end if
		END IF
		
		
		// set the array of prac ids
		ll_prac_arr_i ++
		ll_prac_arr[ll_prac_arr_i] = ll_prac
	next
next
/*****         LOOP 2 END       *************************************************************************/

gnv_appeondb.of_startqueue( )

//from the prac array retrieve appointment records for screens with verif rules
IF ll_prac_arr_i > 0 THEN
	lds_facils.retrieve(ll_prac_arr[],li_screen_arr[])
END IF
IF ll_code_arr_i > 0 THEN
	Datastore lds_address_lookup
	lds_address_lookup = Create Datastore
	lds_address_lookup.Dataobject = "d_lookup_address_search_all"
	lds_address_lookup.Settransobject( SQLCA )
	lds_address_lookup.retrieve(ll_code_arr[])
END IF

gnv_appeondb.of_commitqueue( )

Long ll_rec_arr[],ll_rec_arr_i
Long ll_facil_arr[],ll_facil_arr_i

/*****         LOOP 3 BEGIN     *************************************************************************/
for s = 1 to sc
	li_screen = lds_screen.getitemnumber(s,"screen_id")	//Add By Jervis 11-04-2008
	ls_dataobject = ""
	CHOOSE CASE li_screen
		CASE 4//"License"
			ls_dataobject = "d_exp_license_verif"
		CASE 5 //"DEA"
			ls_dataobject = "d_exp_dea_verif"
		CASE 9 //Special Certs
			ls_dataobject = "d_exp_spec_certs_verif"
		CASE 15 //"Insurance"
			ls_dataobject = "d_exp_insurance_verif"
		CASE 19 //"Board/Specialty"
			ls_dataobject = "d_exp_spec_verif"
		CASE 23 //Other Ids
			ls_dataobject = "d_exp_other_ids_verif"
		CASE else
			continue
	END CHOOSE
	if ls_dataobject = "" then
		continue
	end if
	
	FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
		IF ls_dataobject_arr[ll_dataobject_arr_i] = ls_dataobject THEN
			lds_data = lds_dataobject_arr[ll_dataobject_arr_i]
			EXIT
		END IF
	END FOR
	
	//set the array of recids and facilities
	dc = lds_data.Rowcount()
	for d = 1 to dc
		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")
		
		//get ll_rec value in loop 3
		ll_rec_arr_i++
		ll_rec_arr[ll_rec_arr_i] = ll_rec

		lds_facils.Setfilter( "prac_id = " + String(ll_prac) + " AND facility_ver_rules_screen_id = " + String(li_screen))
		lds_facils.Filter( )
		fc = lds_facils.Rowcount( )
		for f = 1 to fc
			ll_facil = lds_facils.getitemnumber(f,"verifying_facility")
			// get ll_facil value in loop 3
			ll_facil_arr_i ++
			ll_facil_arr[ll_facil_arr_i] = ll_facil
		next
	next
next
/*****         LOOP 3 END       *************************************************************************/
debugbreak()
IF ll_facil_arr_i > 0 THEN
	cnt = 	lds_verif.Retrieve( ll_rec_arr[], ll_prac_arr[], ll_facil_arr[])
	messagebox("cnt",cnt)
	if cnt < 0 then//Start Code Change ----10.13.2011 #V12 maha
		messagebox("","Failure to retrieve verif records")
		if IsValid(lds_screen) then Destroy lds_screen
		if IsValid(lds_facils) then Destroy lds_facils
		if IsValid(lds_sys_field) then Destroy lds_sys_field
		if IsValid(lds_verif) then Destroy lds_verif
		return -1
	end if
END IF

/*****         LOOP FINALLY BEGIN         ***************************************************************/
for s = 1 to sc
	li_screen = lds_screen.getitemnumber(s,"screen_id")
	ls_screen_name = lds_screen.getitemstring(s,"screen_name")
	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
	//Start Code Change ----10.13.2011 #V12 maha - moved from above where it had no purpose
	li_option = lds_screen.getitemnumber(s,"facility_ver_rules_exp_options") //modify Micheal 03.23.2012 add table name 'facility_ver_rules_'
	ll_psv_method = lds_screen.getitemnumber(s,"facility_ver_rules_default_verif_means")//modify Micheal 03.23.2012 add table name 'facility_ver_rules_'
	//End Code Change ----10.13.2011
	
	lds_sys_field.SetFilter("field_id = " + String(ll_ref1))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref1  = 0
	else		//ref one data
		ls_ref1_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref1_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref1_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref1_lu = "Y" then
			ls_ref1_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref1_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if

	lds_sys_field.SetFilter("field_id = " + String(ll_ref2))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref2 = 0
	else	 //ref 2 data
		ls_ref2_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref2_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref2_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref2_lu = "Y" then
			ls_ref2_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref2_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if

	lds_sys_field.SetFilter("field_id = " + String(ll_ref_exp))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref_exp = 0
	else
		ls_refexp_name = lds_sys_field.getitemstring(1,"field_name")
	end if

	ls_dataobject = ""
	CHOOSE CASE li_screen

		CASE 4//"License"
			ls_dataobject = "d_exp_license_verif"
			//MSKINNER 15 MARCH 2005 -- BEGIN
         if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Licenses"
         //MSKINNER 15 MARCH 2005 -- END
		CASE 5 //"DEA"
			ls_dataobject = "d_exp_dea_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring DEAs"

		CASE 9 //Special Certs
			ls_dataobject = "d_exp_spec_certs_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Special Certifications"

		CASE 15 //"Insurance"
			ls_dataobject = "d_exp_insurance_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Insurance Records"

		CASE 19 //"Board/Specialty"
			ls_dataobject = "d_exp_spec_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Board Certifications"

		CASE 23 //Other Ids
			ls_dataobject = "d_exp_other_ids_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Other IDS"

		CASE else
			//messagebox("Continue","This utility does not support Expiring verification Creation for the " + ls_screen_name + " screen.")
			continue
	END CHOOSE
	if ls_dataobject = "" then
		continue
	end if
	
	FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
		IF ls_dataobject_arr[ll_dataobject_arr_i] = ls_dataobject THEN
			lds_data = lds_dataobject_arr[ll_dataobject_arr_i]
			EXIT
		END IF
	END FOR
	
	dc = lds_data.Rowcount()

	cnt = 0

	if dc < 1 then continue
	for d = 1 to dc

		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")

		//move expiration date to verif info table if there is one
		IF ll_ref_exp > 0 THEN
			IF ls_refexp_name = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( "12-30-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				
			ELSEIF ls_refexp_name = "cert_expiration_year" THEN
				li_month = lds_data.GetItemNumber( d, "cert_expiration_month" )
				choose case li_month
					case 2
						li_days = 28
					case 1,3,5,7,8,10,12
						li_days = 31
					case else
						li_days = 31
				end choose
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( "12-31-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				else
					ldt_exp_date = DateTime(Date(String(li_month) + String(li_days) + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				end if
			ELSE
				ldt_exp_date = lds_data.GetItemDateTime( d, ls_refexp_name )
			END IF
		ELSE
			continue
		END IF
	//*************** reference data *******************
		IF ll_ref1 > 0 THEN
			IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
				ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
			elseif ls_ref1_dtype = "C" then
				ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
			elseif ls_ref1_dtype = "D" then
				ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
			end if
			if ls_ref1_lu = "Y" then
				ll_code = long(ls_reference1)
				if isnumber(ls_reference1) then ll_address_code = ll_code
				if ls_ref1_lutype = "A" then
					ll_lookup_address_r = lds_address_lookup.Find( "lookup_code = " + String(ll_code),1 ,lds_address_lookup.Rowcount() )
					ls_reference1 = ""
					If ll_lookup_address_r > 0 THEN
					if upper(ls_ref1_lufield) = "ENTITY NAME" THEN
						ls_reference1 = lds_address_lookup.GetitemString(ll_lookup_address_r, "entity_name")
					else
						ls_reference1 = lds_address_lookup.GetitemString(ll_lookup_address_r, "code")
					end if
					END IF
				elseif ls_ref1_lutype = "C" then
					if upper(ls_ref1_lufield) = "DESCRIPTION" THEN
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + String(ll_code))
					else
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_code))
					end if
				end if
			end if
		end if			
		if isnull(ls_reference1) then ls_reference1 = ""
					
		//get reference 2 data
		IF ll_ref2 > 0 THEN
			IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
				ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
			elseif ls_ref2_dtype = "C" then
				ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
			elseif ls_ref2_dtype = "D" then
				ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
			end if
			if ls_ref2_lu = "Y" then
				ll_code = long(ls_reference2)
				if isnumber(ls_reference2) then ll_address_code = ll_code
				if ls_ref2_lutype = "A" then
					ll_lookup_address_r = lds_address_lookup.Find( "lookup_code = " + String(ll_code),1 ,lds_address_lookup.Rowcount() )
					ls_reference2 = ""
					If ll_lookup_address_r > 0 THEN
					if upper(ls_ref2_lufield) = "ENTITY NAME" THEN
						ls_reference2 = lds_address_lookup.GetitemString(ll_lookup_address_r, "entity_name")
					else
						ls_reference2 = lds_address_lookup.GetitemString(ll_lookup_address_r, "code")
					end if
					END IF
				elseif ls_ref2_lutype = "C" then
					if upper(ls_ref2_lufield) = "DESCRIPTION" THEN
						ls_reference2 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + String(ll_code))
					else
						ls_reference2 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_code))
					end if
				end if
			end if
		END IF
		if isnull(ls_reference2) then ls_reference2 = ""
		ls_reference = ls_reference1 + " - " + ls_reference2
		
		IF li_screen = 4 THEN					
			ll_address_code = lds_data.GetItemNumber( d, "verifying_agency" )
		end if

		lds_facils.Setfilter( "prac_id = " + String(ll_prac) + " AND facility_ver_rules_screen_id = " + String(li_screen))
		lds_facils.Filter( )
		fc = lds_facils.Rowcount( )
		if fc < 1 then
			continue
		end if
		for f = 1 to fc
			li_found = 0
			ll_facil = lds_facils.getitemnumber(f,"verifying_facility")
			exp_days = lds_facils.getitemnumber(f,"exp_cred_que_letters_days")
			ls_priority_user = lds_facils.getitemstring(f,"priority_user")
			if RelativeDate ( today(), exp_days ) <  date(ldt_exp_date) then continue //skip if has not expired yet by these rules
			
			cnt = lds_verif.Find("rec_id = " + String(ll_rec) + " AND prac_id = " + String(ll_prac) +&
			" AND facility_id = " + String(ll_facil), 1 ,lds_verif.Rowcount())
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2007.08.31 By: Jack
			//$<reason> Fix a defect.
			/*
			if cnt < 0 then messagebox("retrieval failure",cnt)
			*/
 			if cnt < 0 then messagebox("Retrieval Failure",cnt)
			//---------------------------- APPEON END ----------------------------
			if cnt > 0 then
				continue
			else
				if isnull(ll_seq) or ll_seq = 0 Then					
					select max(seq_no) into :ll_seq from verif_info;
					if isnull(ll_seq) then ll_seq = 0
				end if
				ll_seq++
			
				//********* create verif ****************
				ll_newrow = lds_verif.insertrow(0)
				
				//Start Code Change ----07.09.2009 #V92 maha
				if li_option = 1 then //create as PSV type not expiring
					ll_exp_method = ll_psv_method
					li_exp_flag = 0
				else  //normal exp letter
					ll_exp_method = ll_verif_method
					li_exp_flag = 1
				end if
					
				lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
				lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
				lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
				lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
				lds_verif.setitem(ll_newrow,"screen_id",li_screen)
				lds_verif.setitem(ll_newrow,"active_status",1)
				lds_verif.setitem(ll_newrow,"number_sent",0)
				lds_verif.setitem(ll_newrow,"source","P")
				lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
				lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
				lds_verif.setitem(ll_newrow,"verification_method",ll_exp_method) //maha 070909
				lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
				lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
				lds_verif.setitem(ll_newrow,"priority",1)
				lds_verif.setitem(ll_newrow,"exp_credential_flag",li_exp_flag)  //maha 070909
				ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
				lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
				lds_verif.setitem(ll_newrow,"print_flag",1)
				lds_verif.setitem(ll_newrow,"notes","")
				// R.Avital v11.3 capture creation date and user
				// Begin changes
				lds_verif.SetItem(ll_newrow, 'create_date', DateTime(Today(), Now()))
				//lds_verif.SetItem(ll_newrow, 'create_user', Trim(gs_user_id) + "-")
				lds_verif.SetItem(ll_newrow, 'create_user', "Sys-AIQ")
				// R.Avital v11.3 END changes
				
				tcnt++	
				
				if li_option = 2 then //exp letter plus PSV  - copy the exp one just created and modify for PSV
					ll_seq++
					lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
					lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
					lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
					lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
					lds_verif.setitem(ll_newrow,"screen_id",li_screen)
					lds_verif.setitem(ll_newrow,"active_status",1)
					lds_verif.setitem(ll_newrow,"number_sent",0)
					lds_verif.setitem(ll_newrow,"source","P")
					lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
					lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
					lds_verif.setitem(ll_newrow,"verification_method",ll_psv_method)
					lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
					lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
					lds_verif.setitem(ll_newrow,"priority",1)
					lds_verif.setitem(ll_newrow,"exp_credential_flag",0)
					ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
					lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
					lds_verif.setitem(ll_newrow,"print_flag",1)
					lds_verif.setitem(ll_newrow,"notes","")
				end if
				//End Code Change---07.09.2009
			end if
			
		next
	next
	if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = w_aiq_run.r_status.width + clicks
next

inv_message.of_set_proc_cnt(lds_verif.rowcount()) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality

gnv_appeondb.of_autocommit()
lds_verif.update()
commit using sqlca;
/*****         LOOP FINALLY END           ***************************************************************/

destroy lds_screen
destroy lds_facils
destroy lds_sys_field
destroy lds_verif
destroy lds_data

FOR ll_dataobject_arr_i = 1 TO ll_dataobject_arr_cnt
	Destroy lds_dataobject_arr[ll_dataobject_arr_i]
END FOR

Destroy lds_address_lookup

if ib_from_utility = true then
	messagebox("Expiring Verifications","Expiring verifications for " + string(tcnt) + " records have been created")
end if

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 800
return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_run_ai_query (integer ai_from);// <RP> added 4.14.2016  //replaces original AIQ
datastore lds_exp_appt
long ll_row

//maha added 082903
integer xtype
integer db
string  ls_name//maha 04.18.2016
string  ls_exec_sql

//select set_26 into :xtype from icred_settings;
xtype = of_get_app_setting("set_26","I")

if gi_user_readonly = 1 then return 1  //Start Code Change ----02.06.2017 #V153 maha - skip if the user is readonly


//--------------------------- <RP> 3.21.2016 benchmark times-------------------------------------
gnv_app.of_benchmark("reset")
gnv_app.of_benchmark(this.className() + ".of_run_ai_query()")
//--------------------------------------------------------------------------------------------

//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("before open(w_aiq_run)")
//---------------------------------------------------------------------------------------


open(w_aiq_run)

//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after open(w_aiq_run)")
gnv_app.of_benchmark("before of_expiring_credentials()")
//---------------------------------------------------------------------------------------

//-------------------- <RP> 4.6.2016 ------------------------------------------------
long	ll_existing_verif_count
long	ll_duplicate_verif_count
long	ll_letter_count
long	ll_psv_count
long	ll_updated_count
long	ll_fail_count
//----------------------------------------------------------------------------------------


if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Checking for Expiring Credential Verifications" //For checking validation modified by  Nova 08.27.2009

if xtype = 1 then
	of_expiring_credentials_from_data()
else
//-------------------- <RP> 4.6.2016 ------------------------------------------------
//	of_expiring_credentials()
//Start Code Change ----04.18.2016 #V15 maha - if fail run original
	select name into :ls_name from sysobjects where name = 'up_expiring_credentials';
	IF isnull(ls_name) or ls_name = '' or gs_dbtype = "ASA" then
		of_expiring_credentials( )
	ELSE
		IF SQLCA.of_processExpiringCredentials( 'Sys-AIQ', datetime(today(), now()), ll_existing_verif_count, ll_duplicate_verif_count, ll_letter_count, ll_psv_count, 	ll_updated_count, 	ll_fail_count ) = -1 THEN
			of_expiring_credentials( )
		end if			
	END IF

//-------------------- end <RP> 4.6.2016 ------------------------------------------------
end if
ls_name = ""
//End Code Change ----04.18.2016


if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =   400  // 800

//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after of_expiring_credentials()")
gnv_app.of_benchmark("before of_resend_letters()")
//---------------------------------------------------------------------------------------


if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Checking for Letters that need to be reprinted" //For checking validation modified by  Nova 08.27.2009

//-----------------------------<RP> 4.8.2016--------------------------------------------
//of_resend_letters()

//Start Code Change ----04.18.2016 #V15 maha - if fail run original
select name into :ls_name from sysobjects where name = 'upresend_letters';
IF isnull(ls_name) or ls_name = '' or gs_dbtype = "ASA" then
	of_resend_letters( )
ELSE	
	IF SQLCA.of_resendLetters() = -1 THEN
		of_resend_letters( )
	END IF
End if
ls_name = ""
//End Code Change ----04.18.2016
//---------------------------- end <RP> 4.8.2016----------------------------------------

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  700    //1100


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after of_resend_letters()")
gnv_app.of_benchmark("before of_expiring_appointments()")
//---------------------------------------------------------------------------------------


if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Appointment Verifications"

//---------------------------<RP> 4.14.2016-----------------------------------------------
//of_expiring_appointments()
select name into :ls_name from sysobjects where name = 'up_expiring_appointments';
IF isnull(ls_name) or ls_name = '' then
	of_expiring_appointments( )
ELSE
	lds_exp_appt = CREATE datastore
	lds_exp_appt.dataobject = "d_exp_appt_wf_action"
	lds_exp_appt.setTransObject(SQLCA)
	
	IF lds_exp_appt.retrieve() < 0 THEN
		SQLCA.of_rollBack()
		//Start Code Change ----04.18.2016 #V15 maha - if fails use original function
		of_expiring_appointments( )
	ELSE
		SQLCA.of_commit()
		//Start Code Change ----04.18.2016 #V15 maha - moved within the commit else
		IF lds_exp_appt.rowCount() > 0 THEN
			n_cst_workflow_triggers lnv_triggers
			lnv_triggers = create n_cst_workflow_triggers
			str_action_item lstr_action[]
			for ll_row = 1 TO lds_exp_appt.rowCount()
				lstr_action[ll_row].prac_id = lds_exp_appt.object.prac_id[ll_row]
				lstr_action[ll_row].rec_id = lds_exp_appt.object.rec_id[ll_row]
				lstr_action[ll_row].facility_id = lds_exp_appt.object.facility_id[ll_row]
				lstr_action[ll_row].screen_id = lds_exp_appt.object.screen_id[ll_row]
				lstr_action[ll_row].wf_id = lds_exp_appt.object.wf_id[ll_row]
			next
			
			if gb_autoschedule or ib_schedule then lnv_triggers.of_set_sched_flag(TRUE)//scheduler - alfee 03.09.2010
			
			lnv_triggers.of_workflow_triggers(lstr_action)
			
			if gb_autoschedule or ib_schedule then //scheduler - alfee 03.09.2010
				string ls_message
				ls_message = lnv_triggers.of_get_sched_msg( )
				if LenA(ls_message) > 0 then inv_message.of_messagebox('', ls_message, true)
			end if
			destroy lnv_triggers
		else //(Appeon)Stephen 03.06.2017 - Issue with Recred in Orthonet's DB - case 00066831 
			ls_exec_sql = "exec up_expiring_appointments"
			EXECUTE Immediate :ls_exec_sql Using sqlca;
			IF sqlca.SQLCode = 0 THEN
				SQLCA.of_commit();
			end if
		END IF
	END IF	
End if
//------------------------- end <RP> 4.14.2016-------------------------------------------

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1000   //1495


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after of_expiring_appointments()")
gnv_app.of_benchmark("before of_intellibatch_update()")
//---------------------------------------------------------------------------------------


//Start Code Change ----06.03.2013 #V14 maha
if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating IntelliBatches"
	of_intellibatch_update( )
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1200



if ai_from = 1 then //daily login process
	//select set_33 into :db from icred_settings;
	db = of_get_app_setting("set_33","I")
	if db = 1 then
		string ls_path
		string ls_state

		select database_backup_path into :ls_path from ids;
		
		if isnull(ls_path) then
			messagebox("No path","A default save path must be specified from the utilities Back up Database function.")
		else
			if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "BACKING UP DATABASE (This may take a few minutes.)" //For checking validation modified by  Nova 08.27.2009
			setpointer(hourglass!)
			ls_state = "BACKUP DATABASE DIRECTORY " + "'" + ls_path + "'" + ";"
			if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 250
			//messagebox("",ls_state)
			execute immediate :ls_state using sqlca;
			setpointer(arrow!)
			if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1300
		end if
	end if
	
	//Start Code Change ----10.20.2016 #V152 maha - moved inside daily query
	//---------------------- <RP> 3.21.2016 ---------------------------------------------
	gnv_app.of_benchmark("after of_intellibatch_update()")
	gnv_app.of_benchmark("before of_appl_tracking_running_days()")
	//---------------------------------------------------------------------------------------
	
	//Start Code Change ----10.08.2015 #V15 maha
	if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating Application Tracking running dates"
		of_appl_tracking_running_days( )
	if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1300
	
	//---------------------- <RP> 3.21.2016 ---------------------------------------------
	gnv_app.of_benchmark("after of_appl_tracking_running_days()")
	gnv_app.of_benchmark("before if ai_from = 1")
	//---------------------------------------------------------------------------------------
	//End Code Change ----10.20.2016
end if


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if ai_from = 1")
gnv_app.of_benchmark("before of_missing_info_90_days_generate()")
//---------------------------------------------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-16 By: Rodger Wu (Inova)
//$<reason> Create verifications based on missing items existing 90 days.
w_aiq_run.r_status.width = 1400
of_missing_info_90_days_generate()


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_missing_info_90_days_generate()")
gnv_app.of_benchmark("before of_set_active_users()")
//---------------------------------------------------------------------------------------


//---------------------------- APPEON END ----------------------------
w_aiq_run.r_status.width = 1500
of_set_active_users() //Start Code Change ----05.15.2009 #V92 maha - for ameripath customzation


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_set_active_users()")
gnv_app.of_benchmark("before of_wv_Initiated_workflow()")
//---------------------------------------------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.09.2007 By: Jervis
//$<reason> WebView Practitioner Application Initiated Work Flow
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1700
if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Create Work Flow For WebView.This may take a few minutes." //For checking validation modified by  Nova 08.27.2009
of_wv_Initiated_workflow()
//---------------------------- APPEON END ----------------------------


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_wv_Initiated_workflow()")
gnv_app.of_benchmark("before of_df_expiring_update()")
//---------------------------------------------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//dataflow - joe 12.22.2009 
w_aiq_run.r_status.width = 1800
w_aiq_run.st_1.text = "Execute Data Flow. This may take a few minutes." 
of_df_expiring_update()
//---------------------------- APPEON END ----------------------------


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_df_expiring_update()")
gnv_app.of_benchmark("before of_NotificationAlert()")
//---------------------------------------------------------------------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> Evan 02.08.2010
//$<reason> V10.1 - Notification Alert
w_aiq_run.r_status.width = 1900
w_aiq_run.st_1.text = "Execute Notification Alert. This may take a few minutes."
of_NotificationAlert()

//---------------------------- APPEON END ----------------------------


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_NotificationAlert()")
gnv_app.of_benchmark("before of_meeting_create()")
//---------------------------------------------------------------------------------------


//Start Code Change ----08.08.2011 #V11 maha - meeting creation
//w_aiq_run.r_status.width =  2000
if isValid(w_aiq_run) then w_aiq_run.r_status.width =  2000	//long.zhang 09.04.2013 Null object reference
//w_aiq_run.st_1.text = "Execute Meeting Creation. This may take a few minutes."
if isValid(w_aiq_run) then w_aiq_run.st_1.text = "Execute Meeting Creation. This may take a few minutes."	//long.zhang 09.04.2013 Null object reference	
of_meeting_create( )
//End Code Change ----08.08.2011 


//---------------------- <RP> 3.21.2016 ---------------------------------------------
gnv_app.of_benchmark("after if of_meeting_create()")
gnv_app.of_benchmark("before of_pendingchange()")
//---------------------------------------------------------------------------------------


//-------------appeon begin----------------------
//<$>added:long.zhang 08.08.2013
//<$>reason:V14.1 Group Location Effective Dates
if isvalid(w_aiq_run) then w_aiq_run.r_status.width =  2100
if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Execute Pending Change. This may take a few minutes."
of_pendingchange( )
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 06.05.2017 for V15.4-WebView Reporting Functionality--------
gnv_app.of_benchmark("after if of_pendingchange()")
gnv_app.of_benchmark("before of_check_reports_store()")
if isvalid(w_aiq_run) then w_aiq_run.r_status.width =  2100
if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Delete any report files older than the Delete Days. This may take a few minutes."
of_check_reports_store()
//---------End Added ------------------------------------------------------

if isvalid(w_aiq_run) then  close(w_aiq_run)

//----------------- <RP> 3.21.2016--------------------------------------------------------------
gnv_app.of_benchmark("finish of_run_ai_query")
//gnv_app.of_displaybenchmark()
//---------------------------------------------------------------------------------------------------


return 1
end function

public function integer of_expiring_credentials_from_data_old ();long s
long sc
long d
long dc
long f
long fc
long cnt = 0
long tcnt = 0
integer chk
long ll_rec
long ll_prac
long ll_facil 
Long ll_seq
integer li_screen
string ls_screen_name
integer li_act_stat
integer li_complete = 1
long ll_resp_code = 2
long ll_verif_method = 1
string ls_ref_value
long ll_ref1no
string ls_datatype
long ll_ref1
long ll_ref2
long ll_ref_exp
integer li_days
string ls_ref1_lu
string ls_ref2_lu
string ls_ref1_lutype
string ls_ref2_lutype
string ls_ref1_dtype
string ls_ref2_dtype
string ls_ref1_lufield
string ls_ref2_lufield
string ls_ref1_name
string ls_ref2_name
string ls_refexp_name
string ls_priority_user
string ldw
integer li_priority
integer li_exp_flag
string ls_doc_id
integer exp_days
long ll_rowcount
long r
long ll_newrow
datetime ldt_exp_date
long ll_null_no
integer li_bs_year
datetime ld_exp
integer ll_code
integer ac
string ls_reference1
string ls_reference2
string ls_reference
integer li_month
datetime ldt_null_date
long ll_address_code
integer li_exp_days
date ld_exp_ret
integer li_found
integer clicks
datastore lds_screen
datastore lds_facils
datastore lds_sys_field
datastore lds_verif
datastore lds_data

lds_screen = CREATE datastore
lds_screen.dataobject = "d_verif_screens_exp"
lds_facils = CREATE datastore
lds_facils.dataobject = "d_prac_affils_verif"
lds_sys_field = CREATE datastore
lds_sys_field.dataobject = "d_field_data"
lds_verif = CREATE datastore
lds_verif.dataobject = "d_verif_exp_4_record"
lds_data = CREATE datastore

//MSKINNER 15 MARCH 2005 -- BEGIN
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 100
//MSKINNER 15 MARCH 2005 -- END


setnull(ldt_null_date)
lds_sys_field.settransobject(sqlca)
lds_facils.settransobject(sqlca)
lds_screen.settransobject(sqlca)//d_verif_screens_exp
sc = lds_screen.retrieve()//gets all distinct verif rules where data_view = 1, screen > 1 and exp_days > 0 and the screen has an exp_field
//st_sc.text = string(sc)
if sc < 1 then 
	messagebox("Expiring Credentials", "There are no verification rules set up for expiring Verifications.  Skipping this function.")
	return -1
	
end if

select lookup_code into :ll_verif_method from code_lookup where code = 'Exp Cred Ltr'; 
if ll_verif_method < 1 then
	messagebox("Missing Data", "You do not have a Verification Method lookup with the code of 'Exp Cred Ltr'.~rUnable to continue.")
	return -1
end if
clicks = integer(700/sc)
//debugbreak()
for s = 1 to sc
//	st_cs.text = string(s)
	li_screen = lds_screen.getitemnumber(s,"screen_id")
	ls_screen_name = lds_screen.getitemstring(s,"screen_name")
	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
	//messagebox("ll_ref_exp",ll_ref_exp)
	//ls_datatype = lds_screen.getitemstring(s,"field_type")
//	st_screen.text = ls_screen_name
	if lds_sys_field.retrieve(ll_ref1) < 1 then
		ll_ref1  = 0
		//messagebox("ll_ref1",ll_ref1)
	else		//ref one data
		ls_ref1_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref1_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref1_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref1_lu = "Y" then
			ls_ref1_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref1_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if
	if lds_sys_field.retrieve(ll_ref2) < 1 then
		ll_ref2 = 0
	else	 //ref 2 data
		ls_ref2_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref2_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref2_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref2_lu = "Y" then
			ls_ref2_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref2_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if
	//exp field
	if lds_sys_field.retrieve(ll_ref_exp) < 1 then //check for exp field (should be filtered for in retrieve)
		//messagebox("exp_ret",exp_ret)
		ll_ref_exp = 0
	else
		ls_refexp_name = lds_sys_field.getitemstring(1,"field_name")
	end if

	lds_data.dataobject = ""
	CHOOSE CASE li_screen

		CASE 4//"License"
			lds_data.dataobject = "d_exp_license_verif"
			//MSKINNER 15 MARCH 2005 -- BEGIN
         if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Licenses"
         //MSKINNER 15 MARCH 2005 -- END
			
			
		CASE 5 //"DEA"
			lds_data.dataobject = "d_exp_dea_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring DEAs"

		CASE 9 //Special Certs
			lds_data.dataobject = "d_exp_spec_certs_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Special Certifications"

		CASE 15 //"Insurance"
			lds_data.dataobject = "d_exp_insurance_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Insurance Records"

		CASE 19 //"Board/Specialty"
			lds_data.dataobject = "d_exp_spec_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Board Certifications"

		CASE 23 //Other Ids
			lds_data.dataobject = "d_exp_other_ids_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Other IDS"

		CASE else
			messagebox("Continue","This utility does not support Expiring verification Creation for the " + ls_screen_name + " screen.")
			continue
	END CHOOSE
	//lds_data.dataobject = ldw
	if lds_data.dataobject = "" then
		continue
	end if
	lds_data.settransobject(sqlca)
	dc = lds_data.retrieve(today())
//	messagebox("dc",dc)
	cnt = 0
//	st_cnt.text = string(dc)
	if dc < 1 then continue
	for d = 1 to dc
//		st_rec.text = string(d)
		
		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")
//		choose case ll_rec
//			case 13000,12956,12204,2042,2043
//				debugbreak()
//				//messagebox("recid",ll_ref_exp)
//		end choose
		//move expiration date to verif info table if there is one
		IF ll_ref_exp > 0 THEN
			IF ls_refexp_name = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( "12-30-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				
			ELSEIF ls_refexp_name = "cert_expiration_year" THEN
				li_month = lds_data.GetItemNumber( d, "cert_expiration_month" )
				choose case li_month
					case 2
						li_days = 28
					case 1,3,5,7,8,10,12
						li_days = 31
					case else
						li_days = 31
				end choose
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( "12-31-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				else
					ldt_exp_date = DateTime(Date(String(li_month) + String(li_days) + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
				end if
			ELSE
				ldt_exp_date = lds_data.GetItemDateTime( d, ls_refexp_name )
			END IF
		ELSE
			continue
		END IF
	//*************** reference data *******************
		//get reference 1 data
		
		IF ll_ref1 > 0 THEN
			IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
				ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
			elseif ls_ref1_dtype = "C" then
				ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
			elseif ls_ref1_dtype = "D" then
				ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
			end if
			if ls_ref1_lu = "Y" then
				ll_code = long(ls_reference1)
				if isnumber(ls_reference1) then ll_address_code = ll_code
				if ls_ref1_lutype = "A" then
					if upper(ls_ref1_lufield) = "ENTITY NAME" THEN
						select entity_name into :ls_reference1 from address_lookup where lookup_code = :ll_code;
					else
						select code into :ls_reference1 from address_lookup where lookup_code = :ll_code;
					end if
				elseif ls_ref1_lutype = "C" then
					if upper(ls_ref1_lufield) = "DESCRIPTION" THEN
						select description into :ls_reference1 from code_lookup where lookup_code = :ll_code;
					else
						select code into :ls_reference1 from code_lookup where lookup_code = :ll_code;
					end if
				end if
			end if
		end if			
		if isnull(ls_reference1) then ls_reference1 = ""
					
		//get reference 2 data
		IF ll_ref2 > 0 THEN
			IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
				ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
			elseif ls_ref2_dtype = "C" then
				ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
			elseif ls_ref2_dtype = "D" then
				ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
			end if
			if ls_ref2_lu = "Y" then
				ll_code = long(ls_reference2)
				if isnumber(ls_reference2) then ll_address_code = ll_code
				if ls_ref2_lutype = "A" then
					if upper(ls_ref2_lufield) = "ENTITY NAME" THEN
						select entity_name into :ls_reference2 from address_lookup where lookup_code = :ll_code;
					else
						select code into :ls_reference2 from address_lookup where lookup_code = :ll_code;
					end if
				elseif ls_ref2_lutype = "C" then
					if upper(ls_ref2_lufield) = "DESCRIPTION" THEN
						select description into :ls_reference2 from code_lookup where lookup_code = :ll_code;
					else
						select code into :ls_reference2 from code_lookup where lookup_code = :ll_code;
					end if
				end if
			end if
		END IF
		if isnull(ls_reference2) then ls_reference2 = ""
		ls_reference = ls_reference1 + " - " + ls_reference2
		
			//IF ls_screen_name = "Licensure" THEN
		IF li_screen = 4 THEN					
			ll_address_code = lds_data.GetItemNumber( d, "verifying_agency" )
		end if
		lds_facils.settransobject(sqlca)
		fc = lds_facils.retrieve(ll_prac,li_screen) //check the rules for each of the practitioners' verifying facilities 
		if fc < 1 then
			//messagebox("fc",fc)
			continue
		end if
		for f = 1 to fc
			li_found = 0
			ll_facil = lds_facils.getitemnumber(f,"verifying_facility")
			exp_days = lds_facils.getitemnumber(f,"exp_cred_que_letters_days")
			ls_priority_user = lds_facils.getitemstring(f,"priority_user")
			if RelativeDate ( today(), exp_days ) <  date(ldt_exp_date) then continue //skip if has not expired yet by these rules
			//select count(seq_no) into :cnt from verif_info where rec_id = :ll_prac and prac_id = :ll_prac and facility_id = :ll_facil and active_status = 1 and exp_credential_flag in (0,1);
			//d_verif_exp_4_record //any active record with no response code
			lds_verif.settransobject(sqlca)
			cnt = lds_verif.retrieve(ll_rec,ll_prac,ll_facil)
			if cnt < 0 then messagebox("retrieval failure",cnt)
			if cnt > 0 then
				continue
			else
				 //messagebox("",cnt)
				select max(seq_no) into :ll_seq from verif_info where rec_id = :ll_rec and prac_id = :ll_prac and facility_id = :ll_facil;
				if isnull(ll_seq) then ll_seq = 0
				ll_seq++
			
				//DaysAfter ( date1, date2 )
				//********* create verif ****************
				ll_newrow = lds_verif.insertrow(0)
				
				
				lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
				lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
				lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
				lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
				lds_verif.setitem(ll_newrow,"screen_id",li_screen)
				lds_verif.setitem(ll_newrow,"active_status",1)
				lds_verif.setitem(ll_newrow,"number_sent",0)
				lds_verif.setitem(ll_newrow,"source","P")
				lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
				lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
				lds_verif.setitem(ll_newrow,"verification_method",ll_verif_method)
				lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
				lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
				lds_verif.setitem(ll_newrow,"priority",1)
				lds_verif.setitem(ll_newrow,"exp_credential_flag",1)
				ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
				lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
				lds_verif.setitem(ll_newrow,"print_flag",0)
				lds_verif.setitem(ll_newrow,"notes","eieio")
				
				// R.Avital v11.3 capture creation date and user
				// Begin changes
				lds_verif.SetItem(ll_newrow, 'create_date', DateTime(Today(), Now()))
				lds_verif.SetItem(ll_newrow, 'create_user', Trim(gs_user_id))
				// R.Avital v11.3 END changes
				
				tcnt++			
//				st_added.text = string(tcnt)
				debugbreak()
				lds_verif.update()
				commit using sqlca;
			end if
			
		next
//		lds_verif.update()
//		commit using sqlca;
	next
		
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = w_aiq_run.r_status.width + clicks
next

destroy lds_screen
destroy lds_facils
destroy lds_sys_field
destroy lds_verif
destroy lds_data

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 800
return 1
end function

public subroutine of_missing_info_90_days_generate ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_n_cst_ai_printletters/of_missing_info_90_days_generate()
// $<arguments>
//		value	integer
// $<returns> (none)
// $<description> Create verifications based on missing items existing
// $<description> 90 days from date_app_rcvd.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-10-13 by Rodger Wu (Inova)

//Attention!!
/*
New DataWindows: 
	d_missinfo90_affil_stat
	d_missinfo90_existed_verif
	d_missinfo90_app_audit_incom
	d_missinfo90_verif_incom
	d_missinfo90_verif_maxsno
*/

//////////////////////////////////////////////////////////////////////
//comment 07/25/2007 by: Andy
n_ds lds_affil_stat, lds_verif_existed_90, lds_verif_maxsno//, lds_app_audit_incom, lds_verif_incom 
Integer i, li_found, li_rows, li_inserted, li_sno
//comment 07/25/2007 by: Andy
//Integer li_rows_verif_existed_90, li_rows_app_audit_incom, li_rows_verif_incom
Integer li_rows_verif_maxsno
Long ll_prac_id, ll_verif_fac, ll_recid_affil
//<add> 07/25/2007 by: Andy
Long ll_prac_id_first = -1, ll_verif_fac_first = -1, ll_recid_affil_first = -1

//comment 07/25/2007 by: Andy
//Long ll_rec_id_ar[], ll_fac_id_ar[], ll_prac_id_ar[]

lds_affil_stat = CREATE n_ds
lds_verif_existed_90 = CREATE n_ds
//comment 07/25/2007 by: Andy
//lds_app_audit_incom = CREATE n_ds
//lds_verif_incom = CREATE n_ds
lds_verif_maxsno = CREATE n_ds

//Modify 07/25/2007 by: Andy
//lds_affil_stat.DataObject = "d_missinfo90_affil_stat"				//Get pd_affil_stat records that exceed 90 days.
lds_affil_stat.DataObject = "d_missinfo90_affil_stat_new"				//Get pd_affil_stat records that exceed 90 days.
//end of modify
lds_verif_existed_90.DataObject = "d_missinfo90_existed_verif" //Get existed Missing Info 90 verification records, and this datastore will be used to update new Missing Info 90 records into database.
//comment 07/25/2007 by: Andy
//lds_app_audit_incom.DataObject = "d_missinfo90_app_audit_incom"//Get incomplete app. audit records.
//lds_verif_incom.DataObject = "d_missinfo90_verif_incom"        //Get incomplete verification records.
//end of comment

//Modify 07/25/2007 by: Andy
//lds_verif_maxsno.DataObject = "d_missinfo90_verif_maxsno"      //Get verification seq_no in order to avoid Primary Key violent.
lds_verif_maxsno.DataObject = "d_missinfo90_verif_maxsno_new"      //Get verification seq_no in order to avoid Primary Key violent.
//end of modify

lds_affil_stat.SetTransObject( SQLCA )
lds_verif_existed_90.SetTransObject( SQLCA )
//comment 07/25/2007 by: Andy
//lds_app_audit_incom.SetTransObject( SQLCA )
//lds_verif_incom.SetTransObject( SQLCA )
//end of comment
lds_verif_maxsno.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue()
lds_affil_stat.Retrieve()
lds_verif_existed_90.Retrieve()
//comment 07/25/2007 by: Andy
//lds_app_audit_incom.Retrieve()
//lds_verif_incom.Retrieve()
//end of comment 
gnv_appeondb.of_commitqueue()

//comment 07/25/2007 by: Andy
//li_rows_verif_existed_90 = lds_verif_existed_90.RowCount()
//li_rows_app_audit_incom = lds_app_audit_incom.Rowcount()
//li_rows_verif_incom = lds_verif_incom.Rowcount()
//end of comment 

/*
//comment 07/25/2007 by: Andy 
//Reason:Optimize.
//       Not only the data source of d_missinfo90_affil_stat_new 
//       but also the data source of d_missinfo90_verif_maxsno_new have already processed these.
For i = lds_affil_stat.RowCount() to 1 Step -1
	
	ll_prac_id = lds_affil_stat.GetItemNumber( i, "prac_id" )
	ll_verif_fac = lds_affil_stat.GetItemNumber( i, "verifying_facility" )
	ll_recid_affil = lds_affil_stat.GetItemNumber( i, "rec_id" )
	
	li_found = lds_verif_existed_90.Find( "prac_id = " + string( ll_prac_id ) + &
					" and facility_id = " + string( ll_verif_fac ), 1, li_rows_verif_existed_90 )
	if li_found > 0 then
		lds_affil_stat.DeleteRow( i )//Not necessary to add a 90 day letter if Missing Info 90 verification has existed.
		Continue;
	end if
	
	li_found = lds_app_audit_incom.Find( "appt_stat_id = " + string( ll_recid_affil ), 1, li_rows_app_audit_incom )
	if li_found > 0 then
		ll_prac_id_ar[ upperbound( ll_prac_id_ar ) + 1 ] = ll_prac_id
		ll_rec_id_ar[ upperbound( ll_rec_id_ar ) + 1 ] = ll_recid_affil
		ll_fac_id_ar[ upperbound( ll_fac_id_ar ) + 1 ] = ll_verif_fac
		continue;  //Incomplete app. audit record existed.
	end if
	
	li_found = lds_verif_incom.Find( "prac_id = " + string( ll_prac_id ) + " and facility_id = " + string( ll_verif_fac ), 1, li_rows_verif_incom )
	if li_found > 0 then
		ll_prac_id_ar[ upperbound( ll_prac_id_ar ) + 1 ] = ll_prac_id
		ll_rec_id_ar[ upperbound( ll_rec_id_ar ) + 1 ] = ll_recid_affil
		ll_fac_id_ar[ upperbound( ll_fac_id_ar ) + 1 ] = ll_verif_fac
		continue;  //Incomplete verification record existed.
	end if
	
	lds_affil_stat.DeleteRow( i )   //Not necessary to add a 90 day letter due to no incomplete record found.
	
Next
*/

if lds_affil_stat.Rowcount() < 1 then
	//<add> 07/25/2007 by: Andy
	if isValid(lds_affil_stat) then destroy lds_affil_stat
	if isValid(lds_verif_existed_90) then destroy lds_verif_existed_90
	if isValid(lds_verif_maxsno) then destroy lds_verif_maxsno
	//end of add
	Return //No requirement of generating Missing Info 90 letter.
end if

//Modify 07/25/2007 by: Andy
//li_rows_verif_maxsno = lds_verif_maxsno.Retrieve( ll_rec_id_ar, ll_prac_id_ar, ll_fac_id_ar )
li_rows_verif_maxsno = lds_verif_maxsno.Retrieve()
//end of modify

For i = 1 to lds_affil_stat.rowcount()
	ll_recid_affil = lds_affil_stat.GetItemNumber( i, "rec_id" )
	ll_prac_id = lds_affil_stat.GetItemNumber( i, "prac_id" )
	ll_verif_fac = lds_affil_stat.GetItemNumber( i, "verifying_facility" )
	
	//<add> 07/25/2007 by: Andy 
	//The data source of lds_affil_stat has already setted sort.
	if ll_prac_id_first = ll_prac_id and &
		ll_verif_fac_first = ll_verif_fac and ll_recid_affil_first = ll_recid_affil then
		li_sno ++
	else
	//end of add
		//Get max seq_no + 1.
		li_found = lds_verif_maxsno.Find( "rec_id = " + string( ll_recid_affil ) + " and prac_id = " + string( ll_prac_id ) + &
													 " and facility_id = " + string( ll_verif_fac ), 1, li_rows_verif_maxsno )
		if li_found > 0 then
			li_sno = lds_verif_maxsno.GetItemNumber( li_found, "seq_no" ) + 1
		else
			li_sno = 1
		end if
		//<add> 07/25/2007 by: Andy
		ll_prac_id_first = ll_prac_id
		ll_verif_fac_first = ll_verif_fac
		ll_recid_affil_first = ll_recid_affil
	end if
	//end of add
	
	//Add Missing Info 90 letter into database.
	li_inserted = lds_verif_existed_90.InsertRow( 0 )
	lds_verif_existed_90.SetItem( li_inserted, "rec_id", ll_recid_affil )
	lds_verif_existed_90.SetItem( li_inserted, "prac_id", ll_prac_id )
	lds_verif_existed_90.SetItem( li_inserted, "facility_id",  ll_verif_fac)
	lds_verif_existed_90.SetItem( li_inserted, "seq_no", li_sno )
	lds_verif_existed_90.SetItem( li_inserted, "screen_id", 1 )
	lds_verif_existed_90.SetItem( li_inserted, "verification_method", -300 ) //-300 means miss info 90 in code lookup.
	lds_verif_existed_90.SetItem( li_inserted, "reference_value", "Applications Audit Missing 90 days" )
	lds_verif_existed_90.SetItem( li_inserted, "doc_id", string(ll_recid_affil) + '-' + string( ll_prac_id ) + '-' + string( ll_verif_fac ) + '-' + string( li_sno ))
	lds_verif_existed_90.SetItem( li_inserted, "direct_parent_facility_link", lds_affil_stat.GetItemNumber( i, "parent_facility_id" ))
	//Start Code Change ----08.03.2011 #V11 maha - cleart prior mod values and add create
	lds_verif_existed_90.SetItem(li_inserted, 'create_date', datetime(today(),Now()))
	lds_verif_existed_90.SetItem(li_inserted, 'create_user', "Sys-AIQ")
		//End Code Change ----08.03.2011 
Next

if lds_verif_existed_90.Update() = 1 then
	Commit Using SQLCA;
else
	Rollback Using SQLCA;
	Messagebox( "IntelliSoft", "Generating Missing Info 90 days Letter failed!" )
end if

//<add> 07/25/2007 by: Andy
if isValid(lds_affil_stat) then destroy lds_affil_stat
if isValid(lds_verif_existed_90) then destroy lds_verif_existed_90
if isValid(lds_verif_maxsno) then destroy lds_verif_maxsno
//end of add
end subroutine

public function integer of_missing_info_90_days_print (string as_doc_id[], u_dw adw_detail);//////////////////////////////////////////////////////////////////////
// $<function>pfc_n_cst_ai_printletters/of_missing_info_90_days_print()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-10-17 by Rodger Wu (Inova)
/*
New DataWindows
    ds_verifications_getbydocid
	 ds_verifications_incom_getbypracid
	 ds_affil_stat_getbyrecid
Modified for added 3 fields called cdate_app_sent, cdate_app_rcvd and cdate_app_signed.
	 d_pd_app_audit_miss_rqst_data_pt
	 d_pd_app_audit_miss_rqst_data_w_vers_pt
*/
//////////////////////////////////////////////////////////////////////

n_ds lds_app_audit_incom, lds_address_info, lds_copy, lds_verif_incom
n_ds lds_verif_toprint, lds_affil_stat
Datastore lds_codelookup_affil_dept_description
Datastore lds_codelookup_affil_staff_description
Integer li_rows_verif_toprint, li_facility_id[], li_verif_fac[], li_last_num_sent, li_found
Long ll_prac_id[], ll_affil_stat_id[]
Long ll_codelookup_affil_dept_description
Long ll_codelookup_affil_staff_description
String ls_doc_id
Integer li_letters_toprint = 0
Boolean lb_allowtoprint[]

String ls_open_merge
Integer i
Integer m, n
String ls_descr
Integer li_prac_cnt
String ls_local_area_code
String ls_dept //maha 090304
Integer li_address_rc
String ls_fax_number
Integer li_miss_cnt
String ls_file_name = "ind_missing_info_request_90_days.doc"
String ls_doc_name
String ls_word_path
String ls_letter_path
String ls_note //maha 092403
String ls_reference //maha 083104
String ls_run_path //maha 021805
String ls_old_docpath //stephen 02.18.2014

ls_run_path = of_letter_paths("L")
ls_open_merge = of_letter_paths("D")

n_appeon_download lnv_download
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	lnv_download.of_parsepath( ls_open_merge)
End If

lds_verif_toprint = CREATE n_ds
lds_verif_toprint.DataObject = "ds_verifications_getbydocid"
lds_verif_toprint.SetTransObject( SQLCA )
li_rows_verif_toprint = lds_verif_toprint.Retrieve( as_doc_id )
if li_rows_verif_toprint < 1 then return 0;//no record needs to print.

for i = 1 to li_rows_verif_toprint
	ll_prac_id[i] = lds_verif_toprint.GetItemNumber( i, "prac_id" )
	ll_affil_stat_id[i] = lds_verif_toprint.GetItemNumber( i, "rec_id" )
	li_facility_id[i] = lds_verif_toprint.GetItemNumber( i, "direct_parent_facility_link" )
	li_verif_fac[i] = lds_verif_toprint.GetItemNumber( i, "facility_id" )
	lb_allowtoprint[i] = True
next

lds_app_audit_incom = Create n_ds //Get incomplete App.Audit records.
lds_app_audit_incom.DataObject = "d_pd_app_audit_rqrd_data_pt"
lds_app_audit_incom.of_SetTransObject( SQLCA )

lds_verif_incom = CREATE n_ds     //Get incomplete verifications records.
lds_verif_incom.DataObject = "ds_verifications_incom_getbypracid"
lds_verif_incom.SetTransObject( SQLCA )

lds_address_info = Create n_ds    //Used to take data.
lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data_pt"
lds_address_info.of_SetTransObject( SQLCA )

lds_copy = Create n_ds 
lds_copy.DataObject = "d_pd_app_audit_miss_rqst_data_pt"
lds_copy.of_SetTransObject( SQLCA )

lds_affil_stat = Create n_ds
lds_affil_stat.DataObject = "ds_affil_stat_getbyrecid"
lds_affil_stat.SetTransObject( SQLCA )

lds_codelookup_affil_dept_description = Create Datastore
lds_codelookup_affil_dept_description.Dataobject = "d_codelookup_affil_dept_description_pt"
lds_codelookup_affil_dept_description.Settransobject( SQLCA )

lds_codelookup_affil_staff_description = Create Datastore
lds_codelookup_affil_staff_description.Dataobject = "d_codelookup_affil_staff_description_pt"
lds_codelookup_affil_staff_description.Settransobject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_verif_incom.Retrieve( ll_prac_id )
lds_address_info.Retrieve( li_facility_id[ ], ll_prac_id[ ] )
lds_app_audit_incom.Retrieve( ll_affil_stat_id[] )
lds_affil_stat.Retrieve( ll_affil_stat_id[] )
lds_codelookup_affil_dept_description.Retrieve( ll_prac_id[], li_facility_id[] )
lds_codelookup_affil_staff_description.Retrieve( ll_prac_id[], li_facility_id[] )

gnv_appeondb.of_commitqueue( )


For i = 1 To li_rows_verif_toprint
	lds_address_info.SetFilter("pd_address_link_facility_id = " + String(li_facility_id[ i ]) + " and pd_address_link_prac_id = " + String(ll_prac_id[ i ]) )
	lds_address_info.Filter()
	li_address_rc = lds_address_info.Rowcount( )

	If li_address_rc < 1 Then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2007.08.31 By: Jack
		//$<reason> Fix a defect.
		/*
		MessageBox("Address", "You must have a mailing address links for practitioner id of " + String(ll_prac_id[ i ]) + " for facility_id " + String(li_facility_id[ i ]) + " before using this option.")
		*/
		MessageBox("Address", "You must have a mailing address link for practitioner id of " + String(ll_prac_id[ i ]) + " for facility_id " + String(li_facility_id[ i ]) + " before using this option.")
		//---------------------------- APPEON END ----------------------------
		lb_allowtoprint[i] = False
		Continue //GOTO ERROR
	Else

		lds_app_audit_incom.SetFilter( "appt_stat_id = " + String(ll_affil_stat_id[i]))
		lds_app_audit_incom.Filter( )

		li_miss_cnt = lds_app_audit_incom.RowCount()
		For m = 1 To li_miss_cnt
			If m > 60 Then //new trap 110304
				MessageBox("Missing information","There are more than 60 missing items.  This letter will generate only the first 60.")
				Exit
			Else
				ls_descr = lds_app_audit_incom.GetItemString( m, "pd_app_audit_fax_message" )
				ls_note = lds_app_audit_incom.GetItemString( m, "notes" )
				ls_reference = lds_app_audit_incom.GetItemString( m, "identifying_number" )
				lds_address_info.SetItem( 1, "cmissing_info_" + String( m ), ls_descr )
				lds_address_info.SetItem( 1, "missing_info__note_" + String( m ), ls_note )
				lds_address_info.SetItem( 1, "missing_info_reference_" + String( m ), ls_note )
			End If
		Next
		
		lds_verif_incom.SetFilter( "prac_id = " + string( ll_prac_id[i] ) + " and facility_id = " + string( li_verif_fac[i] ) )
		lds_verif_incom.Filter()
		li_miss_cnt = lds_verif_incom.Rowcount()
		For n = 1 to li_miss_cnt
			If m + n > 60 Then //new trap 110304
				MessageBox("Missing information","There are more than 60 missing items.  This letter will generate only the first 60.")
				Exit
			Else
				ls_descr = lds_verif_incom.GetItemString( n, "reference_value" )
				
				lds_address_info.SetItem( 1, "cmissing_info_" + String( m+n ), ls_descr )
				lds_address_info.SetItem( 1, "missing_info__note_" + String( m+n ), lds_verif_incom.GetItemString( n, "notes" ) )
				lds_address_info.SetItem( 1, "missing_info_reference_" + String( m+n ), '' )
			End If
		Next
		
		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(ll_prac_id[ i ]) +&
		" and facility_id = " + String(li_facility_id[ i ]) + " and lookup_code = department",1 ,lds_codelookup_affil_dept_description.rowcount()) 
		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
		lds_address_info.SetItem( 1, "prime_dept", ls_dept )
		ls_dept = '' //clear or the next blank will duplicate

		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(ll_prac_id[ i ]) +&
		" and facility_id = " + String(li_facility_id[ i ]) + " and lookup_code = section",1 ,lds_codelookup_affil_dept_description.rowcount()) 
		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
		lds_address_info.SetItem( 1, "prime_section", ls_dept )
		ls_dept = '' //clear or the next blank will duplicate

		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(ll_prac_id[ i ]) +&
		" and facility_id = " + String(li_facility_id[ i ]) + " and lookup_code = rank",1 ,lds_codelookup_affil_dept_description.rowcount()) 
		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
		lds_address_info.SetItem( 1, "prime_division", ls_dept )
		ls_dept = '' //clear or the next blank will duplicate

		ll_codelookup_affil_staff_description = lds_codelookup_affil_staff_description.Find( "prac_id = " + String(ll_prac_id[ i ]) +&
		" and facility_id = " + String(li_facility_id[ i ]) ,1 ,lds_codelookup_affil_staff_description.rowcount()) 
		If ll_codelookup_affil_staff_description > 0 Then ls_dept = lds_codelookup_affil_staff_description.GetitemString(ll_codelookup_affil_staff_description, "description")
		lds_address_info.SetItem( 1, "staff_cat", ls_dept )
		ls_dept = '' //clear or the next blank will duplicate

		ls_fax_number = lds_address_info.GetItemString( 1, "fax" )
		ls_local_area_code = ProfileString(gs_IniFilePathName, "Setup","local_area_code", "None")
		
		If IsNull( ls_local_area_code ) Or ls_local_area_code = "" Then
			MessageBox("Setup Error", "You must setup your local area code in the INTELLICRED.INI file under the [setup] section.")
			Return -1
		End If
		
		If PosA( ls_fax_number, "(" ) > 0 Then
			If MidA(ls_fax_number, PosA( ls_fax_number, "(" ) +1 ,3) = ls_local_area_code Then
				ls_fax_number = MidA( ls_fax_number, PosA( ls_fax_number, ")" ) +1, 100 )
			End If
		Else
			If MidA(ls_fax_number,1,3) = ls_local_area_code Then
				ls_fax_number = MidA( ls_fax_number, 4, 100 )
			End If
		End If
		
		lds_address_info.SetItem( 1, "fax", ls_fax_number )
	End If
	
	li_found = lds_affil_stat.Find( "rec_id = " + string( ll_affil_stat_id[i] ), 1, lds_affil_stat.rowcount() )
	if li_found > 0 then
		lds_address_info.SetItem( 1, "cdate_app_sent", string( lds_affil_stat.GetItemDateTime( li_found, "date_app_sent" ), "mm/dd/yyyy" ))
		lds_address_info.SetItem( 1, "cdate_app_rcvd", string( lds_affil_stat.GetItemDateTime( li_found, "date_app_rcvd" ), "mm/dd/yyyy" ))
		lds_address_info.SetItem( 1, "cdate_app_signed", string( lds_affil_stat.GetItemDateTime( li_found, "date_app_signed" ), "mm/dd/yyyy" ))
	end if
	
	lds_address_info.SetItem( 1, "cnumber_of_requests", lds_verif_toprint.GetItemNumber( i, "number_sent" ) )
	lds_address_info.RowsCopy(1,1,primary!,lds_copy,10000,primary!)
	li_letters_toprint++
Next

If lds_copy.RowCount() < 1 Then
	Destroy lds_app_audit_incom
	Destroy lds_address_info
	Destroy lds_copy
	Destroy lds_verif_incom
	Destroy lds_verif_toprint
	Destroy lds_codelookup_affil_dept_description
	Destroy lds_codelookup_affil_staff_description
	Return -1
End If

lds_copy.SaveAs( ls_open_merge + "ind_missing_info_request_90_days.txt", Text!, True ) //maha moved outside of loop 072903
ls_open_merge = ls_open_merge + "ind_missing_info_request_90_days.txt"

Integer li_word_storage_type
li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	Select facility.letter_path
		Into :ls_letter_path
		From facility
		Where facility.facility_id = :li_facility_id[1]   ;
ELSE
	n_appeon_storage_area lnv_storage_area
	IF lnv_storage_area.of_retrieve_doc_from_db( 1, ls_file_name, ls_letter_path) < 0 THEN
		Messagebox("Download File",'The MSWord document '+  ls_file_name  +'  does not exist in the database.')
		RETURN -1
	END IF
END IF

If SQLCA.SQLCode = -1 Then
	MessageBox("SQL ERROR", SQLCA.SQLErrText )

	Destroy lds_app_audit_incom
	Destroy lds_address_info
	Destroy lds_copy
	Destroy lds_verif_incom
	Destroy lds_verif_toprint
	Destroy lds_codelookup_affil_dept_description
	Destroy lds_codelookup_affil_staff_description
	Return -1
End If

ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")

ls_doc_name = ls_letter_path + ls_file_name

If Not FileExists( ls_doc_name ) Then
	MessageBox("Open Letter Error", "Invalid Word Letter path: " + ls_doc_name  )
	Return -1
End If

//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
if gi_citrix = 1 then
	ls_old_docpath = gnv_app.gnvlo_msword.is_directory
	gnv_app.gnvlo_msword.is_directory = gs_temp_path +"fax\"				
	if NOT DirectoryExists(gnv_app.gnvlo_msword.is_directory) then CreateDirectory(gnv_app.gnvlo_msword.is_directory)
end if
//---------End Added ------------------------------------------------------

// mskinner 04 oct 2005 - begin
gnv_app.gnvlo_msword.of_open_word_document( ls_doc_name, ls_open_merge, "Missing Information")
//of_open_letter(ls_doc_name, ls_open_merge,"Missing Information")
// mskinner 04 oct 2005 - end
if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = ls_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing

gs_fax lgs_fax
n_ds lds_letters
Integer li_Retval

lgs_fax.ss_message = "Did the Missing Information Letter print ok?"
lgs_fax.ss_letter_document_name = ls_doc_name + " /mpreview"
lgs_fax.ss_letter_name = "Missing Information Letter 90 days"
lgs_fax.sdw_letter = lds_copy
lgs_fax.ss_letter_type = "MissInfo90"


OpenWithParm( w_ai_print_msg_box, lgs_fax )

gs_fax_error_records lst_fax_error_records
lst_fax_error_records = Message.PowerObjectParm
If lst_fax_error_records.il_error_rec_num[ 1 ] = -2 Then
	Destroy lds_app_audit_incom
	Destroy lds_address_info
	Destroy lds_copy
	Destroy lds_verif_incom
	Destroy lds_verif_toprint
	Destroy lds_codelookup_affil_dept_description
	Destroy lds_codelookup_affil_staff_description
	Return -1
End If

for i = 1 to li_rows_verif_toprint
	
	if Not lb_allowtoprint[i] then continue;
	ls_doc_id = lds_verif_toprint.GetItemString( i, "doc_id" )
	
	li_found = adw_detail.Find( "doc_id = '" + ls_doc_id + "'", 1, adw_detail.rowcount() )
	if li_found > 0 then
		li_last_num_sent = adw_detail.GetItemNumber( i, "number_sent" )
		IF IsNull(li_last_num_sent) THEN li_last_num_sent = 0

		li_last_num_sent++
		adw_detail.SetItem( i, "number_sent", li_last_num_sent )
		adw_detail.SetItem( i, "print_flag", 0 )			
		IF IsNull( adw_detail.GetItemDateTime( i, "first_sent" ) ) THEN
			adw_detail.SetItem( i, "first_sent", DateTime(Today(), Now()) )
		END IF
	
		adw_detail.SetItem( i, "last_sent", DateTime( Today(), Now()) )
		//Start Code Change ----08.03.2011 #V11 maha - set prior mod values 
		adw_detail.SetItem( i, "mod_user", gs_user_id )
		adw_detail.SetItem( i, "mod_date", datetime(today(),now()) )
		//End Code Change ----08.03.2011 
	end if
next

//if all the letters were printed successfully then put a check next to the letter
//IF li_ltr_cnt = li_total_letters THEN 
	w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "num_printed", li_letters_toprint)
	w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "print_status", 1 )
//END IF 

//update the action item detail view by updating then re-retrieving data
IF adw_detail.Update() <> 1 THEN
	MessageBox("Update Failed", "Error while updating " + adw_detail.DataObject )
ELSE
	COMMIT USING SQLCA;
	adw_detail.event pfc_retrieve()
END IF
gnv_appeondb.of_autocommit( )

Destroy lds_app_audit_incom
Destroy lds_address_info
Destroy lds_copy
Destroy lds_verif_incom
Destroy lds_verif_toprint
Destroy lds_codelookup_affil_dept_description
Destroy lds_codelookup_affil_staff_description

Return 1;
end function

public function integer of_wv_initiated_workflow ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_wv_initiated_workflow
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//	Trigger off WebView Practitioner Application Initiated work flow
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

//When the IntelliCred User logs in to IntelliCred and the Action Items Query Runs,
//the program will look for pd_affil_stat.wvbeg_cred = 1.  For these records, 
//the Work Flow Trigger called WebView Practitioner Application Initiated will 
//create the Work Flow.
DataStore lds_addil_stat
datastore lds_esign_log
n_cst_workflow_triggers lnv_workflow
str_action_item  lstr_action
long ll_count,ll_i,ll_wv_begin_cred
long ll_rec_id,ll_prac_id,ll_facility_id
long ll_step


lds_addil_stat = Create DataStore
lds_esign_log = create datastore
lnv_workflow = create n_cst_workflow_triggers

lnv_workflow.of_set_message( false)	//08.28.2007 don't display message
gnv_appeondb.of_startqueue( )

lds_esign_log.dataobject = "d_wf_wv_esign_log"
lds_esign_log.SetTransObject(sqlca)
lds_esign_log.Retrieve()

lds_addil_stat.Dataobject = "d_wf_affil_stat"
lds_addil_stat.SetTransObject(sqlca)
ll_count = lds_addil_stat.Retrieve()

gnv_appeondb.of_commitqueue()

for ll_i = 1 to ll_count
	ll_wv_begin_cred = lds_addil_stat.GetItemNumber(ll_i,"wv_begin_cred")
	
	lstr_action.rec_id = lds_addil_stat.GetItemNumber(ll_i,"rec_id")
	lstr_action.prac_id = lds_addil_stat.GetItemNumber(ll_i,"prac_id")
	lstr_action.facility_id = lds_addil_stat.GetItemNumber(ll_i,"parent_facility_id")
	
	//Trigger off Work Flow for webview application_initiated
	if ll_wv_begin_cred = 1 then
		lstr_action.seq_no = lds_addil_stat.GetItemNumber(ll_i,"seq_no")
		lstr_action.wf_id = lds_addil_stat.GetItemNumber(ll_i,"wf_webview_application_initiated")
		lstr_action.screen_id = -10
		if lnv_workflow.of_workflow_create_action_items( lstr_action) = 1 then
			lds_addil_stat.SetItem(ll_i,"wv_begin_cred",2)
		end if
	end if
	
	if ll_wv_begin_cred = 2 then
		lds_esign_log.SetFilter("app_status_id = " + string(lstr_action.rec_id))
		lds_esign_log.Filter()
		if lds_esign_log.RowCount() = 5 then
			lstr_action.seq_no = lds_addil_stat.GetItemNumber(ll_i,"seq_no")
			lstr_action.wf_id = lds_addil_stat.GetItemNumber(ll_i,"facility_wf_webview_application_complete")
			lstr_action.screen_id = -10
			if lnv_workflow.of_workflow_create_action_items( lstr_action) = 1 then
				lds_addil_stat.SetItem(ll_i,"wv_begin_cred",3)
			end if
		end if
	end if
	if (isvalid(w_aiq_run) and w_aiq_run.r_status.width < w_aiq_run.r_1.width) then  w_aiq_run.r_status.width += 20
next


gnv_appeondb.of_autocommitrollback( )
lds_addil_stat.update()
commit;

if isvalid(lds_addil_stat) then destroy lds_addil_stat
if isvalid(lnv_workflow) then destroy lnv_workflow

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
//if isvalid(lds_addil_stat) then destroy lds_addil_stat
if IsValid(lds_esign_log) then Destroy lds_esign_log
//---------------------------- APPEON END ----------------------------

return 1

end function

public function integer of_run_export (long al_pracs[], long al_export, ref string as_path);// created 021704 maha called from of_printletters

integer i
string ls_path
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: WangChao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replace the visual object with an non-visual object.
//pfc_n_cst_ai_export n_export
pfc_n_cst_ai_export_apb n_export
//---------------------------- APPEON END ----------------------------
integer res

ls_path = as_path//gs_dir_path + "intellicred\letters\data\"// + ls_exp_name + ".txt" cahnged 022003 the file name is set in the export routine


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: WangChao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replace the visual object with an non-visual object.
//n_export = CREATE pfc_n_cst_ai_export
n_export = CREATE pfc_n_cst_ai_export_apb
//---------------------------- APPEON END ----------------------------
n_export.is_called_type = '4'	//08.29.2007 Export format set to .txt By Jervis
res = n_export.of_export_data_with_text( al_export, al_pracs[],ls_path,0 ,string(il_facility),"","",2,"")  //Start Code Change ----01.06.2010 #V10 maha - added prompt parameter


destroy n_export
//messagebox("res",res)
if res < 0 then
	return -1
else
	as_path = ls_path	//08.28.2007 By Jervis Reutrn path
	return 1
end if
end function

public function integer of_privilege_renewal (long al_prac, long al_facil, integer ai_manual, long al_appt_rec);integer p 
integer pc
integer cr
long ll_status
long ll_rec
datetime ldt_nulldate

if ai_manual = 1 then
	//open the privilege add window
	openwithparm(w_clin_area_select,"R*" + string(al_facil) + "@" + string(al_prac) )  //Start Code Change ----09.26.2011 #V12 maha - changed first parameter to R from P
	//user completes
	
else //automatic
	n_ds lds_privs
	lds_privs = create n_ds
	
	lds_privs.dataobject = "d_priv_recred_list"
	lds_privs.settransobject(sqlca)
	pc = lds_privs.retrieve(al_prac,al_facil) //this will get all 'granted' privs
	
	select max(rec_id) into :ll_rec from pd_priv_list;
	
	//ll_rec = gnv_app.of_get_id( "RECORD_ID" , pc )
	
	setnull(ldt_nulldate)
	ll_status =	long(gnv_data.of_getitem('code_lookup','lookup_code',"upper(lookup_name) = 'PRIVILEGE STATUS' and upper(code) = 'REQST'"))
	if ll_status =  0 then
		messagebox("Privilege update","There is no Requested lookup (Code = REQST) in the Privilege Status table.  Unable to process Privileges")
		return -1
	end if		
	
	//copy all existing granted privileges
	lds_privs.rowscopy( p, pc, primary!, lds_privs, 10000, primary!)
	
	for p = pc + 1 to lds_privs.rowcount()
		ll_rec++
		lds_privs.setitem(p,"rec_id", ll_rec )
		lds_privs.setitem(p,"ir_code", "R" )
		lds_privs.setitem(p,"status_code", ll_status )
		lds_privs.setitem(p,"start_date", ldt_nulldate )
		lds_privs.setitem(p,"end_date",ldt_nulldate  )
		lds_privs.setitem(p,"enter_date", today() )
		lds_privs.setitem(p,"app_stat_id", al_appt_rec )
	next
	
	for p = 1 to pc //send org records to history
		lds_privs.setitem(p,"active_status", 0 )
	next
	
	lds_privs.update()

end if


return 1
end function

public function integer of_find_missing_verifs (long al_prac, long al_v_facil, integer ai_silent, string as_appt_type);//Start Code Change ----function created 07.10.2008 #V81 maha - to get verification that are 'missing' from the provider folderinteger i
boolean rf1 = true
boolean rf2 = true
boolean rfx = true
datetime ldt_x
integer i
integer ic
integer d
integer dc
integer ck
integer v
integer vc
integer nr
integer li_active  //maha 04.21.2011
integer li_screen
long ll_rec
long ll_rec_created
long ll_seq
long ll_addr_id
long ll_temp
string ls_sql
string ls_table
string ls_field1
string ls_field2
string ls_type1
string ls_type2
string ls_typex //maha 05.07.2009
string ls_exp
string ls_exp_date //maha 05.07.2009
string ls_prac_field
string ls_rec_field
string ls_reference
string ls_r1
string ls_r2
string ls_sort
string ls_doc
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_screen
string lu
string lut
string luc
string luf
string ls_user_rule //maha 11.16.2011
datastore lds_rules
datastore lds_data
datastore lds_verif
datastore lds_verif_cur


//retrieve the list of screens that rules state are used for the appt type
lds_rules = create datastore
lds_data = create datastore
lds_verif = create datastore
lds_verif_cur = create datastore

lds_verif_cur.dataobject = "d_missing_verif_get_data_base"
lds_verif_cur.settransobject(sqlca)
lds_verif.dataobject = "d_copy_verification_missing"
lds_verif.settransobject(sqlca)
lds_rules.dataobject = "d_missing_verif_rules"
lds_rules.settransobject(sqlca)
ic = lds_rules.retrieve(as_appt_type, al_v_facil )
if ic = 0 then //Start Code Change ----03.16.2016 #V15 maha - return if there are no rules set up for add missing
	//messagebox("of_find_missing verif","Rules retrieval failure.")
	destroy lds_rules
	destroy lds_data
	destroy lds_verif
	destroy lds_verif_cur
	return 0
end if

// for each screen get the data records for the provider
for i = 1 to ic
	rf1 = true
	rf2 = true
	rfx = true //maha 05.07.2009
	ls_table = lds_rules.getitemstring ( i,"sys_tables_table_name")
	li_screen = lds_rules.getitemnumber ( i,"data_view_screen_screen_id")
	ls_screen = lds_rules.getitemstring( i,"data_view_screen_screen_name")
	ls_prac_field = ls_table + ".prac_id "
	ls_rec_field  = ls_table + ".rec_id, "
	ls_field1= lds_rules.getitemstring ( i,"sys_fields_ref_field1")
	ls_sort =  ls_table + "_rec_id A,  verif_info_active_status D"
	
	//Start Code Change ----08.22.2011 #V11 maha - added a trap for inappropriate screens
	choose case li_screen
		case 44,45,43,32
			continue
	end choose
	//Start Code Change ----08.22.2011 #V11 maha 
	
	if isnull(ls_field1) or LenA(ls_field1 ) = 0 then
		ls_field1 =  " ," + ls_table + "." + "cust_1"
		rf1 = false
	else
		ls_field1 =   " ," + ls_table + "." + ls_field1
		ls_type1 = lds_rules.getitemstring ( i,"sys_fields_field_type1")
	end if
	
	ls_field2 = lds_rules.getitemstring ( i,"sys_fields_ref_field2")
	if isnull(ls_field2) or LenA(ls_field2 ) = 0 then
		//Start Code Change ----06.28.2010 #V10 maha - causing error on Work gap - field needed for join
		//ls_field2 =  " ," + ls_table + "." + "cust_1"  
		ls_field2 =  " , place_holder = '' "
		ls_type2 = "C"
		//End Code Change ----06.28.2010
		rf2 = false
	else
		ls_field2 =  " ," + ls_table + "." + ls_field2 
		ls_type2 = lds_rules.getitemstring ( i,"sys_fields_field_type2")
	end if

	ls_exp = lds_rules.getitemstring ( i,"sys_fields_ref_fieldexp")
	if isnull(ls_exp) or LenA(ls_exp ) = 0 then
		ls_exp = ""
		//ls_exp =  " ," + ls_table + "." + "cust_d1"
		rfx = false
	else
		ls_exp =  " ," + ls_table + "." + ls_exp
		ls_typex = lds_rules.getitemstring ( i,"sys_fields_exp_type")
	end if         
	//Start Code Change ----06.18.2009 #V92 maha - exception for specialty with no board
	ls_sql = "Select distinct " + ls_rec_field + ls_prac_field + ls_field1 + ls_field2 +  ls_exp 
	
	if li_screen = 4 then  //Start Code Change ----04.21.2011 #V11 maha - add verifying agency field to get address code
		if ls_field1 <> "verifying_agency" and  ls_field2 <> "verifying_agency" then
			ls_sql+= ", verifying_agency "
		end if
	end if
	
	 if li_screen = 19 then
		ls_sql+= ", board_code "
	elseif  li_screen = 5 or  li_screen = 4 or  li_screen = 15  then //Start Code Change ----04.21.2011 #V11 maha - //license,insurance,dea
		ls_sql+= ", active_status "
	end if
	//End Code Change---06.18.2009
	
	ls_sql  = ls_sql + "  From " + ls_table //+ " LEFT OUTER JOIN verif_info ON " + ls_table + ".rec_id = verif_info.rec_id AND " + ls_table + ".prac_id = verif_info.prac_id "
	ls_sql  = ls_sql +  "  WHERE " + ls_table + ".prac_id = " + string(al_prac) +  ";"
	
	//openwithparm(w_sql_msg,ls_sql)
	
	ls_presentation_str = "style(type=grid)"		

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution on Add missing verifications function " + ls_sql, &
		"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
	//	MessageBox("ls_select_table",ls_select_table)
		
		RETURN -1
	END IF
	
	lds_data = CREATE n_ds
	ck = lds_data.Create( ls_dwsyntax_str, ERRORS)
	if ck < 1 then
		messagebox("error on data create",errors)
	end if
	 	
	//lds_data.SetSQLSelect ( ls_sql )
	lds_data.settransobject(sqlca)
	
	dc = lds_data.retrieve()
	lds_data.setsort(ls_sort )
	lds_data.sort()
	
	if dc > 0 then
		vc = lds_verif_cur.retrieve(al_prac, al_v_facil, li_screen )//Start Code Change ----03.04.2009 #V92 maha - set vc value
	end if
	
//	fields:
//	1 - rec
//	2 - prac
//	3 - ref1
//	4 - ref2
//	5 - exp

//check against the verifications to see if they exist
	for d = 1 to dc
		//Start Code Change ----06.18.2009 #V92 maha - exception for specialty with no board
		if li_screen= 19 then
			if isnull(lds_data.getitemnumber (d,"board_code")) then
				continue
			end if
		end if
		
		 //Start Code Change ----04.21.2011 #V11 maha
		if  li_screen = 5 or  li_screen = 4 or  li_screen = 15  then
			if lds_data.Describe("active_status.ColType") = "!" then messagebox("","no active status")
			li_active = lds_data.getitemnumber (d, "active_status")
			if isnull(li_active) or li_active = 0 then
				continue
			end if
		end if
		
		if li_screen = 4 then
			ll_addr_id = lds_data.GetItemNumber( d, "verifying_agency" )
		end if
		 //End Code Change ----04.21.2011
		//End Code Change---06.18.2009
		ll_rec = lds_data.getitemnumber (d,1) // recid
//	if li_screen = 10 then 	messagebox("",ll_rec)
		ll_rec_created = lds_verif_cur.find( "verif_info_rec_id = " + string(ll_rec),1, vc)  
//	if li_screen = 10 then 	messagebox("",ll_rec_created)	
		if ll_rec_created > 0 then continue  //if exists skip;

		 //if not exist  create verification records
		ll_rec = lds_data.getitemnumber (d,1)
		nr = lds_verif.insertrow(0)
		v++
		lds_verif.setitem(nr,"rec_id",ll_rec )
		lds_verif.setitem(nr,"prac_id",al_prac )
		lds_verif.setitem(nr,"facility_id",al_v_facil )
		lds_verif.setitem(nr,"screen_id",li_screen)
		//get seq no
		select max(seq_no) into :ll_seq from verif_info where prac_id = :al_prac and rec_id = :ll_rec and facility_id = :al_v_facil;
		if isnull(ll_seq)  then ll_seq = 0
		ll_seq++
		lds_verif.setitem(nr,"seq_no",ll_seq)
		lds_verif.setitem(nr,"active_status",1)
		ls_doc = string(ll_rec ) + "-" + string(al_prac ) + "-" + string(al_v_facil ) + "-" + string(ll_seq ) 
		lds_verif.setitem(nr,"doc_id", ls_doc)


		//create reference %^^&*&*%$!?%%!!!
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 08.24.2009
		//$<reason> It needs according to 'islookup' value to judge lookup field
		/*
		if rf1 = true then
			choose case ls_type1
				case "I","N"
					ll_temp =  lds_data.getitemnumber (d,3)
					lu = lds_rules.getitemstring ( i,"sys_fields_islookup1")
					lut = lds_rules.getitemstring ( i,"sys_fields_lookup_type1") 
					luf = lds_rules.getitemstring ( i,"sys_fields_lookup_field1")
					if lu = "Y" then
						if lut = "A" then
							ll_addr_id = ll_temp
							if Upper(luf) = "ENTITY_NAME" then
								select entity_name into :ls_r1 from address_lookup where lookup_code = :ll_temp;
							else
								select code into :ls_r1 from address_lookup where lookup_code = :ll_temp;
							end if
							//ls_r1 = gnv_data.of_getitem("address_lookup",lds_rules.getitemstring ( i,"sys_fields_lookup_field1"),"lookup_name = '" + lds_rules.getitemstring ( i,"sys_fields_lookup_table1") + "' and lookup_code = " + string(ll_temp))
						else //code lookup
							ls_r1 = gnv_data.of_getitem("code_lookup",lds_rules.getitemstring ( i,"sys_fields_lookup_field1"),"lookup_name = '" + lds_rules.getitemstring ( i,"sys_fields_lookup_table1") + "' and lookup_code = " + string(ll_temp))
						end if
					else
						ls_r1 = string(ll_temp)
					end if	
				case "C"
					ls_r1 = lds_data.getitemstring (d,3)
				case "D"
					ls_r1 = string(lds_data.getitemdatetime (d,3))
			end choose
		else
			ls_r1 = ""
		end if
		
		if isnull(ls_r1) then ls_r1 = ""
		
		if rf2 = true then
			choose case ls_type2
				case "I","N"
					ll_temp =  lds_data.getitemnumber (d,4)
					lu = lds_rules.getitemstring ( i,"sys_fields_islookup2")
					lut = lds_rules.getitemstring ( i,"sys_fields_lookup_type2") 
					luf = lds_rules.getitemstring ( i,"sys_fields_lookup_field2")
					if lu = "Y" then
						if lut = "A" then
							ll_addr_id = ll_temp
							if Upper(luf) = "ENTITY NAME" then
								select entity_name into :ls_r2 from address_lookup where lookup_code = :ll_temp;
							else
								select code into :ls_r2 from address_lookup where lookup_code = :ll_temp;
							end if	
						else
							ls_r2 = gnv_data.of_getitem("code_lookup",lds_rules.getitemstring ( i,"sys_fields_lookup_field2"),"lookup_name = '" + lds_rules.getitemstring ( i,"sys_fields_lookup_table2") + "' and lookup_code = " + string(ll_temp))
						end if
					else
						ls_r2 = string(ll_temp)
					end if	
				case "C"
					ls_r2 = lds_data.getitemstring (d,4)
				case "D"
					ls_r2 = string(lds_data.getitemdatetime (d,4))
			end choose
			
		else
			ls_r2 = ""
		end if
		
		if isnull(ls_r2) then ls_r2 = ""
		*/
		// Get reference 1 value
		ls_r1 = ""
		if rf1 = true then
			lu = lds_rules.getitemstring(i, "sys_fields_islookup1")
			if lu = "Y" then
				choose case ls_type1
					case "I", "N"
						ll_temp = lds_data.getitemnumber(d, 3)
					case "C"
						ll_temp = Long(lds_data.getitemstring(d, 3))
					case else
						SetNull(ll_temp)
				end choose
				if IsNull(ll_temp) = false then
					lut = lds_rules.getitemstring(i, "sys_fields_lookup_type1")
					luf = lds_rules.getitemstring(i, "sys_fields_lookup_field1")
					if lut = "A" then
						ll_addr_id = ll_temp
						if Upper(luf) = "ENTITY_NAME" then
							select entity_name into :ls_r1 from address_lookup where lookup_code = :ll_temp;
						else
							select code into :ls_r1 from address_lookup where lookup_code = :ll_temp;
						end if
						
					else
						ls_r1 = gnv_data.of_getitem("code_lookup", lds_rules.getitemstring(i, "sys_fields_lookup_field1"), "lookup_name = '" + lds_rules.getitemstring(i, "sys_fields_lookup_table1") + "' and lookup_code = " + string(ll_temp))
					end if
				end if
			else
				ls_r1 = String(lds_data.object.data[d,3])
				if ls_type1 = "D" then ls_r1 = mid(ls_r1,1,10)
			end if
		end if
		if IsNull(ls_r1) then ls_r1 = ""
		
		// Get reference 2 value
		ls_r2 = ""
		if rf2 = true then
			lu = lds_rules.getitemstring(i, "sys_fields_islookup2")
			if lu = "Y" then
				choose case ls_type2
					case "I", "N"
						ll_temp = lds_data.getitemnumber(d, 4)
					case "C"
						ll_temp = Long(lds_data.getitemstring(d, 4))
					case else
						SetNull(ll_temp)
				end choose
				if IsNull(ll_temp) = false then
					lut = lds_rules.getitemstring(i, "sys_fields_lookup_type2")
					luf = lds_rules.getitemstring(i, "sys_fields_lookup_field2")
					if lut = "A" then
						ll_addr_id = ll_temp
						if Upper(luf) = "ENTITY NAME" then
							select entity_name into :ls_r2 from address_lookup where lookup_code = :ll_temp;
						else
							select code into :ls_r2 from address_lookup where lookup_code = :ll_temp;
						end if
					else
						ls_r2 = gnv_data.of_getitem("code_lookup", lds_rules.getitemstring(i, "sys_fields_lookup_field2"), "lookup_name = '" + lds_rules.getitemstring(i, "sys_fields_lookup_table2") + "' and lookup_code = " + string(ll_temp))
					end if
				end if
			else
				ls_r2 = String(lds_data.object.data[d,4])
				if ls_type2 = "D" then ls_r2 = mid(ls_r2,1,10)
			end if
		end if
		if IsNull(ls_r2) then ls_r2 = ""
		//------------------- APPEON END ---------------------
		
		
		ls_reference = ls_r1 + " - " + ls_r2
		ls_reference = lefta(ls_reference,100)  //Start Code Change ----09.24.2015 #V15 maha
		
		lds_verif.setitem(nr,"reference_value", ls_reference)
				//debugbreak()
		lds_verif.setitem(nr,"verification_method", lds_rules.getitemnumber ( i,"facility_ver_rules_default_verif_means"))
		lds_verif.setitem(nr,"new_verification_method", lds_rules.getitemnumber ( i,"facility_ver_rules_default_verif_means"))
		
		//Start Code Change ----11.16.2011 #V12 maha - get user assignment
		ls_user_rule = lds_rules.getitemstring( i,"facility_ver_rules_priority_user")
		if isnull(ls_user_rule) then
			
			ls_user_rule = "PUBLIC"
		end if
		//End Code Change ----11.16.2011 
			
		lds_verif.setitem(nr,"priority" , 2)
		lds_verif.setitem(nr,"priority_user",ls_user_rule) //Start Code Change ----11.16.2011 #V12 maha - changed from public
		lds_verif.setitem(nr,"exp_credential_flag", 0)
		
		//get expiration date
		if rfx = true then
			//Start Code Change ----05.07.2009 #V92 maha - added trap for non-datetime datatype (primarily for specialty)
			choose case ls_typex
				case "I","N"
					ll_temp = lds_data.getitemnumber (d,5)
					ls_exp_date = string(ll_temp) + "-01-01"
					ldt_x = datetime( date (ls_exp_date ), time("00:00:00"))	
				case "D"
					ldt_x = lds_data.getitemdatetime (d,5)
			end choose
			//End Code Change---05.07.2009
			lds_verif.setitem(nr,"expiration_date", ldt_x)
		end if
		//????
		lds_verif.setitem(nr,"address_lookup_code",ll_addr_id )
		lds_verif.setitem(nr,"print_flag",1) //Start Code Change ----03.25.2009 #V92 maha - changed from 0
		lds_verif.setitem(nr,"selected",1)
		lds_verif.setitem(nr,"color",1)
		lds_verif.setitem(nr,"data_view_screen_screen_name",ls_screen)
		//Start Code Change ----08.03.2011 #V11 maha - add create
		lds_verif.SetItem(nr, 'create_date', datetime(today(),Now()))
		lds_verif.SetItem(nr, 'create_user', gs_user_id + "-A")
		//End Code Change ----08.03.2011 
		choose case li_screen
			case 4,5,15
				lds_verif.setitem(nr,"data_status",li_active)	
		end choose
		
	next
next		

//if silent, add to the provider verification (batch process)


//if manual display in window for user to accept.
if ai_silent = 0 then
	//Start Code Change ----12.17.2008 #V85 maha - added message instead of blank window
	if lds_verif.rowcount() < 1 then 
		messagebox("Check for Missing verifications","There are no missing verifications found per the current verification rules.")
	else
		openwithparm(w_missing_verifs,lds_verif)
	end if
elseif ai_silent = -1 then //new provider - new appointment
	//End Code Change---12.17.2008
	//Start Code Change ----03.25.2009 #V92 maha
	if lds_verif.rowcount() > 0  then 
		openwithparm(w_missing_verifs,lds_verif)
	end if
	//End Code Change---03.25.2009
else
	lds_verif.update()
	commit using sqlca;
end if
//lds_verif.rowscopy( 1, v, primary!, w_missing_verifs.dw_1,1000, primary!)


destroy lds_rules
destroy lds_data
destroy lds_verif
destroy lds_verif_cur

//messagebox("verifs created",v)

return 1






end function

public function integer of_start_reappointment_processing_new (u_dw adw_ver_copy, u_dw adw_action_items, integer ai_parent_facility, long al_prac_id, string as_ver_type, integer ai_silent);//Start Code Change ----06.05.2008 #V81 maha - new function for batch recred and manual recred
datastore lds_appt_dept
datastore lds_appt_comms
datastore lds_appt_leave
datastore lds_appt_staff_cat
datawindow ldw_audit 
n_ds lds_reapp
n_ds lds_action_items
n_ds lds_exp_copy
n_ds lds_appt_stat

Integer ll_exp_appt_ltr  
Integer li_retval
Integer i
integer t 
integer trows 
Integer li_nr
Integer nullint
Integer li_action_item_row
Integer li_facility_row_cnt
integer li_set23
integer li_set32 
integer li_no_copy  = 0
Integer li_facility_id_first = -1
	
Long ll_rec_id_first  = -1
Long ll_seq_no
String ls_version
String ls_doc_id
String ls_rec_id
string ls_assn_user 
string ls_runtype
string ls_old_user

Long li_row_cnt
Long ll_verif_info_maxseqno
Long ll_seq_row_cnt
long li_parent_facility_id
long li_audit_facility_id
long li_verif_facility_id
Long ll_appt_stat_id
Long ll_rec_id
Long ll_new_rec_id
Long ll_new_ver_method
Long ll_response_code  
Long ll_record_id
Long ll_app_audit_id
long ll_test1 
long ll_test2
long ll_prac_id[]
long ll_rec_id1[]
long ll_org_appt_stat_id //maha 11.05.2009
long nulllong //maha 02.15.2013
long ll_lu_method //maha 02.21.2013

DateTime nulldate
DateTime dt_cust4
DateTime dt_prior_start
DateTime dt_prior_end
DateTime ldt_now //maha 082808


/* R.Avital v11.3 add update to verif_info
	create_date/create_user or mod_date/mod_user
	Begin changes
*/

String ls_user
String ls_date
// R.Avital v11.3 END changes

pfc_cst_nv_data_entry_functions lnv_data_entry
lnv_data_entry = create pfc_cst_nv_data_entry_functions

ldt_now = datetime(today(),Now())
SetNull( nullint )
SetNull( nulldate )
SetNull( nulllong ) //maha 02.15.2013

adw_ver_copy.AcceptText()

//create appointment store
lds_appt_stat = CREATE n_ds
lds_appt_stat.DataObject = "d_pd_affil_status_active" //Start Code Change ----03.16.2016 #V15 maha - changed dwo d_pd_affil_status
lds_appt_stat.of_SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

datawindowchild dwchild
lds_appt_stat.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
lds_appt_stat.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
li_row_cnt = lds_appt_stat.Retrieve( al_prac_id, ai_parent_facility,gs_user_id )

gnv_appeondb.of_commitqueue( )
li_row_cnt = lds_appt_stat.rowcount()

//Start Code Change ----03.16.2016 #V15 maha - with change of dwo no longer need to filter
//filter only active record
//lds_appt_stat.SetFilter( "active_status = 1" )
//lds_appt_stat.Filter( )

//if lds_appt_stat.rowcount() < 1 then 
if li_row_cnt < 1 then
//End Code Change ----03.16.2016
	messagebox("Status Error","Unable to find ACTIVE appointment record for this practitioner and facility.~n The active status of the practitioner's Appointment record must be set to Active to complete the recredentialing process")
	return -1
end if 

ll_org_appt_stat_id =  lds_appt_stat.GetItemNumber( 1, "rec_id" ) ///Start Code Change ----11.05.2009 #V10 maha

//get verifiying facility
li_verif_facility_id = lds_appt_stat.GetItemNumber( 1, "verifying_facility" )

//\/******************* Verification creation *************************************
//create verif store
if as_ver_type <> "NOVER" then
	lds_reapp = CREATE n_ds
	lds_reapp.DataObject = adw_ver_copy.DataObject //adw_ver_copy should be d_copy_verification
	lds_reapp.of_SetTransObject( SQLCA )
	adw_ver_copy.ShareData( lds_reapp )

	//create copy store
	lds_exp_copy = CREATE n_ds
	lds_exp_copy.DataObject = "d_copy_verification"
	lds_exp_copy.of_SetTransObject( SQLCA )
	
	li_row_cnt = lds_reapp.RowCount()
	
	//Start Code Change ----03.16.2016 #V15 maha - modified to continue processing if no verifications
	IF li_row_cnt = 0 THEN
		//Return 0
		//skip this process	
	ELSE
		lds_reapp.setsort("rec_id A, facility_id A")
		lds_reapp.sort()	
	
		ll_seq_no = 0
		FOR i = 1 TO li_row_cnt   
			if lds_reapp.GetItemNumber( i, "facility_id" ) = li_verif_facility_id then //maha 011603 only reset active status if is the same facility
				lds_reapp.SetItem( i, "active_status", 0 )
			end if
			//if credential has (not) been selected then it does not have to be reverified
			IF lds_reapp.GetItemNumber( i, "selected" ) = 0 THEN	
				CONTINUE
			END IF
			li_retval = lds_reapp.RowsCopy(i, i, Primary!, lds_exp_copy, 100000, Primary!)
			IF li_retval = -1 THEN
				Messagebox("Error","Error copying record")
				Return -1
			END IF
			
			//get just copied row number
			li_nr = lds_exp_copy.RowCount()
			ll_rec_id = lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) 
			
			//attention:set sort first
			if ll_rec_id_first = ll_rec_id and li_facility_id_first = li_verif_facility_id then 
				ll_seq_no++
			else
			//end of add
	
				SELECT Max( seq_no )  
				INTO :ll_seq_no  
				FROM verif_info  
				WHERE verif_info.rec_id = :ll_rec_id  and facility_id = :li_verif_facility_id; 
	
				if isnull(ll_seq_no) then ll_seq_no = 0
				ll_seq_no++
				ll_rec_id_first = ll_rec_id
				li_facility_id_first = li_verif_facility_id
			end if
		
			lds_exp_copy.SetItem( li_nr , "facility_id", li_verif_facility_id )
			lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
			lds_exp_copy.SetItem( li_nr, "first_sent", nulldate )
			lds_exp_copy.SetItem( li_nr, "last_sent", nulldate )
			lds_exp_copy.SetItem( li_nr, "number_sent", 0 )
			lds_exp_copy.SetItem( li_nr, "date_recieved", nulldate )
			lds_exp_copy.SetItem( li_nr, "user_name", "" )
			lds_exp_copy.SetItem( li_nr, "response_code", nullint )
			//lds_exp_copy.SetItem( li_nr, "priority_user", "PUBLIC" ) //removed 010703
			lds_exp_copy.SetItem( li_nr, "priority", 2 )
			lds_exp_copy.SetItem( li_nr, "exp_credential_flag", 0)
			//find out what the user has selected for the new verificatin method
			ll_new_ver_method = lds_reapp.GetItemNumber( i, "new_verification_method" )
			//Start Code Change ----02.21.2013 #V12 maha - dynamic method based on lookup
			ll_lu_method = lds_reapp.getitemnumber( i, "address_lookup_verif_method")  //Start Code Change ----03.19.2013 #V12 maha - corrected error
			if ll_lu_method > 0 then ll_new_ver_method = ll_lu_method
			//End Code Change ----02.21.2013
			lds_exp_copy.SetItem( li_nr, "verification_method", ll_new_ver_method )
			//concantenate doc_id
			ls_doc_id = String(ll_rec_id) + "-" + string(al_prac_id) + "-" + string(li_verif_facility_id) + "-" + string(ll_seq_no)
			lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
			lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
			//make current verif entry inactive
			lds_exp_copy.SetItem( li_nr, "verif_info_notes", "" ) // added 092800 maha
			lds_exp_copy.SetItem( li_nr, "active_status", 1 )
			//Start Code Change ----08.03.2011 #V11 maha - clearrprior mod values and add create
			lds_exp_copy.SetItem( li_nr, "mod_user", "" )
			lds_exp_copy.SetItem( li_nr, "mod_date", nulldate )
			lds_exp_copy.SetItem(li_nr, 'create_date', datetime(today(),now()))
			lds_exp_copy.SetItem(li_nr, 'create_user', gs_user_id + "-R") // maha 03.22.2013 added -R
			//End Code Change ----08.03.2011 
		END FOR
	END IF // process vers
	//End Code Change ----03.16.2016 
END IF	
//\******************* end of verification creation *************************************


li_parent_facility_id = ai_parent_facility

lds_appt_stat.SetItem( 1, "active_status", 0 )
//grab the last sequence number
ll_seq_no = lds_appt_stat.GetItemNumber( 1, "seq_no" )
ll_rec_id = lds_appt_stat.GetItemNumber( 1, "rec_id" )
//grab the audit and verifying and app audit facility id(s)
li_audit_facility_id = lds_appt_stat.GetItemNumber( 1, "application_audit_facility" )
li_verif_facility_id = lds_appt_stat.GetItemNumber( 1, "verifying_facility" )
dt_prior_start = lds_appt_stat.GetItemdatetime( 1, "apptmnt_start_date" )
dt_prior_end = lds_appt_stat.GetItemdatetime( 1, "apptmnt_end_date" )
//get a new record id
ll_new_rec_id = gnv_app.of_get_id("RECORD_ID")


select reap_user into :i from facility where facility_id = :li_parent_facility_id;
if isnull(i) then i = 0
ls_old_user = lds_appt_stat.GetItemstring( 1, "priority_user" ) //(Appeon)Stephen 02.28.2017 - Bug ID #5513 for Case #00069440 assigning correct user name when initialing recred
choose case i
	case 0 //default
		ls_assn_user = "PUBLIC"
	case 1 //copy
		ls_assn_user = lds_appt_stat.GetItemstring( 1, "priority_user" )
	case 2 //current user
		ls_assn_user = gs_user_id
end choose

//---------Begin Added by (Appeon)Stephen 02.28.2017 for Bug ID #5513 for Case #00069440 assigning correct user name when initialing recred--------
if ls_old_user <> ls_assn_user then
	ib_Priority_User = true
end if
//---------End Added ------------------------------------------------------
ll_appt_stat_id = ll_new_rec_id

if isvalid(w_recred_batch) then w_recred_batch.il_appt_id = ll_new_rec_id // set in batch window if exists for priv functionality
//add a new row to appointment status
li_nr = lds_appt_stat.InsertRow( 0 )
lds_appt_stat.SetItem( li_nr, "rec_id", ll_new_rec_id )
lds_appt_stat.SetItem( li_nr, "prac_id", al_prac_id )
lds_appt_stat.SetItem( li_nr, "parent_facility_id", li_parent_facility_id )
ll_seq_no++
lds_appt_stat.SetItem( li_nr, "seq_no", ll_seq_no )
lds_appt_stat.SetItem( li_nr, "verifying_facility", li_verif_facility_id )
lds_appt_stat.SetItem( li_nr, "application_audit_facility", li_audit_facility_id )
lds_appt_stat.SetItem( li_nr, "apptmnt_type", "R" )
lds_appt_stat.SetItem( li_nr, "affiliation_status", lds_appt_stat.GetItemstring( 1, "affiliation_status" ) )
lds_appt_stat.SetItem( li_nr, "inital_appmnt_date", lds_appt_stat.GetItemdatetime( 1, "inital_appmnt_date" ) )
lds_appt_stat.SetItem( li_nr, "prior_appt_start", dt_prior_start )
lds_appt_stat.SetItem( li_nr, "prior_appt_end", dt_prior_end )
lds_appt_stat.SetItem( li_nr, "prov_status", 0 )
lds_appt_stat.SetItem( li_nr, "admit_priv", lds_appt_stat.GetItemnumber( 1, "admit_priv" ) )  
lds_appt_stat.SetItem( li_nr, "priority_user", ls_assn_user ) 
lds_appt_stat.SetItem( li_nr, "in_good_standing", lds_appt_stat.GetItemnumber( 1, "in_good_standing" ) )  //Start Code Change ----10.31.2014 #V14.2 maha


li_set23 = of_get_app_setting("set_23","I")
IF li_set23 = 1 THEN
	dt_cust4 =  lds_appt_stat.GetItemdatetime( 1, "custom_4" ) //lij custom
	lds_appt_stat.SetItem( li_nr, "custom_4",dt_cust4 )
elseif li_set23 = 2 THEN //copy all custom//Start Code Change ----12.02.2010 #V10 maha
	lds_appt_stat.SetItem( li_nr, "custom_1", lds_appt_stat.GetItemstring( 1, "custom_1" )  )
	lds_appt_stat.SetItem( li_nr, "custom_2", lds_appt_stat.GetItemstring( 1, "custom_2" ) )
	lds_appt_stat.SetItem( li_nr, "custom_3", lds_appt_stat.GetItemstring( 1, "custom_3" ) )
	lds_appt_stat.SetItem( li_nr, "custom_4", lds_appt_stat.GetItemdatetime( 1, "custom_4" ) )
	lds_appt_stat.SetItem( li_nr, "custom_5", lds_appt_stat.GetItemdatetime( 1, "custom_5" ) )
end if

//staff category
//SELECT set_32 INTO :li_set32 FROM icred_settings; //inova rules maha 092303
li_set32 = of_get_app_setting("set_32","I")

lds_appt_staff_cat = CREATE datastore
lds_appt_staff_cat.DataObject = "d_pd_affil_staff_cat"
lds_appt_staff_cat.SetTransObject( SQLCA )

//department info
lds_appt_dept = CREATE datastore
lds_appt_dept.DataObject = "d_pd_affil_departments"
lds_appt_dept.SetTransObject( SQLCA )

//credentialing review commitee(s)
lds_appt_comms = CREATE datastore
lds_appt_comms.DataObject = "d_pd_comm_review"
lds_appt_comms.SetTransObject( SQLCA )

//leave info
lds_appt_leave = CREATE datastore
lds_appt_leave.DataObject = "d_pd_affil_leave"
lds_appt_leave.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_appt_staff_cat.Retrieve( ll_rec_id,gs_user_id )
lds_appt_dept.Retrieve( ll_rec_id,gs_user_id )
lds_appt_comms.Retrieve( ll_rec_id, gs_user_id )
lds_appt_leave.Retrieve( ll_rec_id, gs_user_id )

gnv_appeondb.of_commitqueue( )

//staff cat creation
li_row_cnt = lds_appt_staff_cat.Rowcount( )

IF li_row_cnt > 0 THEN
	lds_appt_staff_cat.SetSort("seq_no")
	lds_appt_staff_cat.Sort()
	ll_seq_no = lds_appt_staff_cat.GetItemNumber( li_row_cnt , "seq_no" )
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		li_no_copy = 0
		//code rearranged 030304 maha
		//copy all records unless setting is 1 and the record is inactive
		//traditional method clears dates and set to active requested
		//set to 1 (inova) leaves dates and checks the values of the requested status
		IF li_set32 = 1 or li_set32 = 3 THEN //inova  //Start Code Change ----02.26.2013 #V12 maha - mod for kaleida
			if lds_appt_staff_cat.getItemnumber( i, "requested" ) = 0 then //dont copy inactive maha 081403
				li_no_copy = 1
			end if
		end if
		if li_no_copy = 0 then
			lds_appt_staff_cat.RowsCopy( i, i, Primary!, lds_appt_staff_cat, 1000, Primary! )
			lds_appt_staff_cat.SetItem( i, "active_status", 0 )
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "rec_id", ll_new_rec_id )
			
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "active_status", 1 )
			lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "seq_no", ll_seq_no )
			if li_set32 < 1 then //standard method null dates
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "from_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "to_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 1 )
		
			elseif li_set32 = 1 then  //inova requested rules maha 092303
				if not isnull(lds_appt_staff_cat.GetItemdatetime( i , "to_date" )) then
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 0 ) //history
				elseif not isnull(lds_appt_staff_cat.GetItemdatetime( i , "from_date" )) then
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 1 ) //active
				else
					lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "requested", 2 ) //requested
				end if
			elseif li_set32 = 3 then  //Start Code Change ----02.26.20213 #V12 maha - mod for kaleida
				//don't modify requested status
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "from_date", nulldate )
				lds_appt_staff_cat.SetItem( lds_appt_staff_cat.RowCount(), "to_date", nulldate )
			end if
		end if
			
	END FOR
END IF


//dept creation
li_row_cnt = lds_appt_dept.Rowcount( )

IF li_row_cnt > 0 THEN
	lds_appt_dept.SetSort("seq_no")
	lds_appt_dept.Sort()
	ll_seq_no = lds_appt_dept.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		lds_appt_dept.RowsCopy( i, i, Primary!, lds_appt_dept, 1000, Primary! )
		lds_appt_dept.SetItem( i, "active_status", 0 )
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "active_status", 1 )
		lds_appt_dept.SetItem( lds_appt_dept.RowCount(), "seq_no", ll_seq_no )		
	END FOR
END IF

//committees creation
li_row_cnt = lds_appt_comms.Rowcount( )

IF li_row_cnt > 0 THEN
	lds_appt_comms.SetSort( "seq_no" )
	lds_appt_comms.Sort()
	ll_seq_no = lds_appt_comms.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++				
		lds_appt_comms.RowsCopy( i, i, Primary!, lds_appt_comms, 1000, Primary! )
		lds_appt_comms.SetItem( i, "active_status", 0 )//set org record to history
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "active_status", 1 )
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "review_results", nullint )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "date_back_from_review", nulldate )		
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "date_sent_for_review", nulldate )
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "seq_no", ll_seq_no )				
		//Start Code Change ----02.15.2013 #V12 maha - added reset code the meeting and user
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "meeting_id", nulllong )
		lds_appt_comms.SetItem( lds_appt_comms.RowCount(), "approved_user", "" )
		//End Code Change ----02.15.2013
	END FOR
END IF

//leave creation
li_row_cnt = lds_appt_leave.Rowcount( )

IF li_row_cnt > 0 THEN
	lds_appt_leave.SetSort("seq_no")
	lds_appt_leave.Sort()
	ll_seq_no = lds_appt_leave.GetItemNumber( li_row_cnt , "seq_no" )	
	FOR i = 1 TO li_row_cnt
		ll_seq_no++
		lds_appt_leave.RowsCopy( i, i, Primary!, lds_appt_leave, 1000, Primary! )
		lds_appt_leave.SetItem( i, "active_status", 0 )
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "rec_id", ll_new_rec_id )		
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "active_status", 1 )
		lds_appt_leave.SetItem( lds_appt_leave.RowCount(), "seq_no", ll_seq_no )		
	END FOR
END IF


gnv_data.of_getitem( "code_lookup", 'lookup_code', "upper(code) = 'APP-RCVD'")

//EXP APPT letter set to HISTORY
 //Start Code Change ----07.22.2015 #V15 maha - the of_getitem was not setting a variable so the block of code did not do anything
ll_exp_appt_ltr = long(gnv_data.of_getitem( "code_lookup", 'lookup_code', "upper(code) = upper('Exp Appt Ltr')"))
 //Start Code Change ----10.22.2015 #V15 maha - clear any filter
adw_action_items.setfilter("")
adw_action_items.filter()
 //Code Change ----10.22.2015
//---------------------------- APPEON END ----------------------------
//IF gb_preserve_exp_appt_verif = TRUE then  //07.22.2015 #V15 maha - added skip of reset of active status
IF ib_preserve_exp_appt = TRUE then //Start Code Change ----08.31.2017 #V154 maha - changed variable
	//skip reset of letter
ELSE

	IF adw_action_items.RowCount() > 0 THEN
		for i = 1 to adw_action_items.Rowcount( )	
			IF adw_action_items.GetItemNumber( i, "verification_method" ) = ll_exp_appt_ltr THEN
				if	adw_action_items.GetItemNumber( i, "prac_id" ) = al_prac_id and adw_action_items.GetItemNumber( i, "parent_facility_id" ) = ai_parent_facility then //trap for act items maha092503
					if isnull(adw_action_items.getItemdatetime( i, "date_recieved")) then
						adw_action_items.SetItem( i, "user_name", gnv_app.of_getuserid() )
						adw_action_items.SetItem( i, "date_recieved", Today() )
					end if
					if not isnull(ll_response_code) and ll_response_code <> 0 then //(Appeon)Harry 01.26.2015 -The INSERT statement conflicted with the FOREIGN KEY constraint "FK_verif_info1". 
						adw_action_items.SetItem( i, "response_code", ll_response_code  )
					end if					
					adw_action_items.SetItem( i, "active_status", 0 )
					exit //once found drop loop
				end if
			END IF
		next
	END IF
END IF
 //End Code Change ----07.22.2015


//commit;
sqlca.autocommit = false

gnv_appeondb.of_startqueue( )

IF  as_ver_type <> "NOVER" then
	lds_reapp.update(true,false)
	lds_exp_copy.update(true,false)
end if

adw_action_items.update(true,false)
lds_appt_stat.update(true,false)
lds_appt_staff_cat.update(true,false)
lds_appt_dept.update(true,false)
lds_appt_comms.update(true,false)
lds_appt_leave.update(true,false)

		
gnv_appeondb.of_commitqueue( )
//@@@@need test
//open appointment window if manual
if ai_silent = 0 	then
	//Open up window with new appointment status information
	gl_facility_id = li_parent_facility_id
	gl_prac_id = al_prac_id
	gs_param = "REAPP"
	Open( w_back_from_committee )
	IF Message.StringParm = "Cancel" THEN
		ROLLBACK USING SQLCA;
		sqlca.autocommit = true
		
		RETURN -1
	END IF
end if

IF  as_ver_type <> "NOVER" then
	lds_reapp.ResetUpdate()
	lds_exp_copy.ResetUpdate()
end if
adw_action_items.ResetUpdate()
lds_appt_staff_cat.ResetUpdate()
lds_appt_dept.ResetUpdate()
lds_appt_stat.ResetUpdate()
lds_appt_comms.ResetUpdate()
adw_action_items.ResetUpdate()
lds_appt_leave.ResetUpdate()

//create attest questions
lnv_data_entry.of_generate_attest_questions( "reapp", ai_parent_facility, al_prac_id, ll_new_rec_id )

//Start Code Change ----08.27.2008 #V85 maha - set run type for log
if ai_silent = 1 then
	ls_runtype = "BAT"
else
	ls_runtype = "MAN"
end if
ldt_now = datetime (today(),now())
//End Code Change---08.27.2008

// move npdb, corresp letters etc. to history  //maha added here 03073
gnv_appeondb.of_startqueue( )

// R.Avital v11.3 Begin changes
// Incorporated existing code to update active_status to 0
// with the same existing criteria - commented out existing update
//SELECT create_user INTO :ls_user FROM verif_info
//WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//USING SQLCA;
//ls_date = String(Now(), 'yyyy-mm-dd hh:mm:ss')
//IF IsNull(ls_user) OR Trim(ls_user) = '' THEN	
//	UPDATE verif_info
//	SET create_date = :ls_date,
//		 create_user = :gs_user_id,
//		 active_status = 0
//	WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id
//	USING SQLCA;
//ELSE
//Start Code Change ----08.03.2011 #V11 maha  -  re-modified
//this sets all Screen id 1 items to history (NPDB, OIG, CORRESP, etc.)
	UPDATE verif_info
	SET mod_date = :ldt_now,
		 mod_user = :gs_user_id,
		 active_status = 0
	WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id and active_status = 1 and verification_method <> :ll_exp_appt_ltr
	USING SQLCA;
	//WHERE screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id and active_status = 1   //Start Code Change ----07.22.2015 #V15 maha - changed to not include exp letter (set above)
	
//END IF
//update verif_info set active_status = 0 where screen_id = 1 and prac_id = :al_prac_id and facility_id = :li_parent_facility_id;
// R.Avital v11.3 END changes

//Start Code Change ----08.27.2008 #V85 maha - create log entry
//Start Code Change ----11.07.2017 #V16 maha - added ver flag
if as_ver_type <> "NOVER" then
	insert into sys_recred_log (rec_id,prac_id, facility_id, date_run, run_by, run_type, with_ver) values( :ll_new_rec_id  , :al_prac_id ,:li_parent_facility_id  , :ldt_now, :gs_user_id ,  :ls_runtype, 'Y');
else //no verifcations
	insert into sys_recred_log (rec_id,prac_id, facility_id, date_run, run_by, run_type, with_ver) values( :ll_new_rec_id  , :al_prac_id ,:li_parent_facility_id  , :ldt_now, :gs_user_id ,  :ls_runtype, 'N');
end if
//End Code Change ----11.07.2017
//End Code Change---08.27.2008

//Start Code Change ----11.05.2009 #V10 maha - make attest quest historical
update pd_attest_questions set active_status = 0 where appt_stat_id = :ll_org_appt_stat_id;
//End Code Change---11.05.2009
commit using sqlca;


gnv_appeondb.of_commitqueue( )


//add app audit data
ll_prac_id[1] = al_prac_id
ll_rec_id1[1] = ll_rec_id
ll_rec_id1[2] = ll_new_rec_id

lnv_data_entry.of_app_audit_items_add( li_parent_facility_id, al_prac_id, ll_new_rec_id ,li_audit_facility_id,"Reapp",ldw_audit	, "R" )

destroy lnv_data_entry

sqlca.autocommit = true


//Added for work Flow. Trigger the related work flow for practitioner reappointment. 2/11/2006 Henry
If gb_workflow Then //Enable the work flow
	long ll_wf_id
	ll_wf_id = long(gnv_data.of_getitem("facility", "facility_wf_reappointment_initiated" , "facility_id="+string(ai_parent_facility)))
	If ll_wf_id > 0 Then
		n_cst_workflow_triggers lnv_triggers
		lnv_triggers = create n_cst_workflow_triggers
			
		str_action_item lstr_action
		lstr_action.prac_id = al_prac_id
		lstr_action.rec_id = 0
		lstr_action.screen_id = -10
		lstr_action.facility_id = ai_parent_facility
		lstr_action.wf_id = ll_wf_id
		lnv_triggers.of_workflow_create_action_items(lstr_action)
		
		destroy lnv_triggers
	End If
End If
//End added for Work Flow

IF as_ver_type = "NOVER" then
	DESTROY lds_exp_copy
	DESTROY lds_reapp
end if

  UPDATE wv_esign_log  
     SET isdisabled = 1  
   WHERE ( wv_esign_log.facility_id = :ai_parent_facility ) AND  
         ( wv_esign_log.prac_id = :al_prac_id )   ;

DESTROY ldw_audit
DESTROY lds_action_items
DESTROY lds_appt_dept
DESTROY lds_appt_comms
DESTROY lds_appt_stat
DESTROY lds_appt_staff_cat
DESTROY lds_appt_leave


RETURN 0

end function

public function integer of_retrieve_recred (datawindow adw_verifs, long al_prac, long al_vfacil);//Start Code Change ----07.17.2008 #V85 maha - Function Created to replace code in verification object so it can be used for action items and batch recreds
integer li_rc
integer i
integer li_check
long t
long del
long ll_test1
long ll_test2
long ll_rec
long ll_lookup_verif_method  //maha 02.21.2013
datetime ldt_end
datetime ldt_check


li_rc = adw_verifs.Retrieve( al_prac)
//set selected based on verify rule
FOR i = 1 TO li_rc
	IF adw_verifs.GetItemString( i, "verify_data" ) = "B" THEN
		adw_verifs.SetItem( i, "selected", 1 )
	//Start Code Change ----02.21.2013 #V12 maha
		ll_lookup_verif_method = adw_verifs.getitemnumber(i,"address_lookup_verif_method")
		if isnull(ll_lookup_verif_method) then ll_lookup_verif_method = 0 //Start Code Change ----02.21.2013 #V12 maha = added method
		if  ll_lookup_verif_method > 0 then adw_verifs.Setitem( i, "new_verification_method" , ll_lookup_verif_method)
	//End Code Change ----02.21.2013
		
	//Start Code Change ----08.12.2008 #V85 maha	
	// deselect hosp/training verifications based on check years setting.	 Note: this will only work for the full end_date field, not with month and year
		li_check = adw_verifs.getitemnumber(i,"check_back_years")
		if not isnull(li_check)  and li_check > 0 then
			ll_rec = adw_verifs.GetItemNumber( i, "rec_id" )
			//get end date
			if adw_verifs.GetItemNumber( i, "screen_id" ) = 10 then  //hospital
				select end_date into :ldt_end from pd_hosp_affil where rec_id = :ll_rec;
			elseif adw_verifs.GetItemNumber( i, "screen_id" ) = 7 then //training
				select end_date into :ldt_end from pd_training where rec_id = :ll_rec;
			end if
			//compare end date to today less check back years
			if not isnull(ldt_end) then
				t =  0 - li_check * 365
				if relativedate(today(),t ) > date(ldt_end) then
					adw_verifs.SetItem( i, "selected", 0 ) //if older than deselect
				end if
			end if
	
		end if
	//End Code Change---08.12.2008		
		
	ELSE
		adw_verifs.SetItem( i, "selected", 0 )
	END IF
	
	IF adw_verifs.GetItemnumber( i, "facility_id" ) = al_vfacil THEN
		adw_verifs.SetItem( i, "color", 1 )
	else
		adw_verifs.SetItem( i, "selected", 0 )
	end if
			
		

END FOR
adw_verifs.Sort()
adw_verifs.GroupCalc() 

FOR i = 1 TO li_rc
		ll_test1 = adw_verifs.GetItemNumber( i, "rec_id" )
		del = adw_verifs.GetItemNumber( i, "del" )
		if del = 1 then continue
		for t = 1 to li_rc
				ll_test2 = adw_verifs.GetItemNumber( t, "rec_id" )
				if i <> t and ll_test1 = ll_test2 and isnull(adw_verifs.GetItemnumber( i, "verification_id" )) and isnull(adw_verifs.GetItemnumber( t, "verification_id" )) then
					adw_verifs.SetItem( t, "del", 1 )
			   end if
		next
next
FOR i =  li_rc to 1 step -1
	if adw_verifs.getItemnumber( i, "del") = 1 then
		adw_verifs.SetItem( i, "selected", 0 )
	end if
next
	
return 1
end function

public function string of_set_i_r_filter (string as_type, integer ai_ver_facil);//Start Code Change ----09.30.2008 #V85 maha - added for ccvs customization; called from of_retrieve_detail
integer i
integer ic
integer li_screen
string ls_filter = " and ( screen_id =  1 or screen_id =  -10 or "   //maha 06.20.2017 = -10 for workflow
datastore lds_rules
//debugbreak()
lds_rules  = create datastore

lds_rules.dataobject = "d_ver_rules_for_ccvs_filter"
lds_rules.settransobject(sqlca)

ic = lds_rules.retrieve(  ai_ver_facil ) //get verif rules for facility

if ic > 0 then
	for i = 1 to ic
		li_screen  = lds_rules.getitemnumber(i, "screen_id")
		if li_screen > 1 then
			choose case as_type
				case 'R'  //if recred only get 'B' records
					if  lds_rules.getitemstring(i, "verify_data") = 'B' then
						ls_filter += " screen_id =  " + string(li_screen) + " or"
					end if
				case 'I' //if initial get all
					ls_filter += " screen_id =  " + string(li_screen) + " or"
			end choose
		end if
	next
end if

ls_filter = MidA( ls_filter ,1,LenA(ls_filter ) - 2) //strip off last 'or'

ls_filter = ls_filter + ") "

//is_i_r_filter = ls_filter

//messagebox("is_i_r_filter",is_i_r_filter)
destroy lds_rules

//of_ver_filter( )

return ls_filter
end function

public function integer of_exp_cred_letter_combined (long al_pracs[], string al_docids[], integer ai_facility, n_ds ads_rows, u_dw ads_docs, string as_from);//Start Code Change ----7.21.2008 #V85 maha - new function. Called from of_print letters_combined
long p
long i
long ic
long pc
integer li_found
integer chk
long ll_prac[]
long ll_prac_get
string ls_filter
string ls_field
long ll_method
string ls_doc
string ls_org_filter

//ads_docs is the verification records from the original screen action items or prac folder
//ads_rows is the letter ds

ll_prac[] = al_pracs[]

	//	get exception list of non retrieved providers / list of good providers  from base
	//	refilter by exp cred letter and base data pracs
	//	copy filtered rows to temp ds
	//	for each prac
	//		filter temp data
	//		extract data values and populate base data
	//	sort by name
	//	save data
//get prac list from verif data

choose case as_from
	case "AC"	
		ls_org_filter = w_action_items.is_combined_filters
	case "PV" //Start Code Change ----08.24.2011 #V11 maha - added for combined letter from verification screen
		ls_org_filter = w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.is_combined_filter
		
end choose
//ids_ai_detail.setredraw = false
//ls_org_filter = ids_ai_detail.describe("datawindow.table.filter") 
//messagebox("",ls_org_filter)

datetime ldt_exp
string ls_test
//	retrieve basic data
pc = ads_rows.retrieve(ll_prac[] , ai_facility, gs_user_id)
ll_method = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Verification Method' and upper(code) = 'EXP CRED LTR'"))
for p = 1 to upperbound(ll_prac)
	ll_prac_get = ll_prac[p]
	li_found = ads_rows.find("prac_id = " + string(ll_prac_get ),1,pc)
	if li_found > 0 then //if the prac base info is retrieved, then filter for the other exp cred letters
		//ls_filter = "prac_id = " + string(ll_prac_get ) + " and verification_method = " + string(ll_method ) + " and isnull(response_code) "
		ls_filter = "prac_id = " + string(ll_prac_get ) + " and verification_method = " + string(ll_method ) + " and isnull(response_code) and active_status = 1 " //Start Code Change ----08.24.2011 #V11 maha - added filter for active status from verification tab
		chk = ids_ai_detail.setfilter(ls_filter)
		if chk = -1 then messagebox ("of_exp_cred_combined function","Filter failed. Contact Support")
		ids_ai_detail.filter()
		ic = ids_ai_detail.rowcount()
			//debugbreak()
		for i = 1 to ic
			//--------Begin Added by Nova 08.11.2010------------------------
			if ic>20 then continue
			//--------End Added --------------------------------------------
			ls_field = "reference_" + string(i)
			ls_test = ads_rows.dataobject
			//messagebox("dataobject", ls_test)
			ls_test = ads_docs.getitemstring(i,"reference_value")
			ads_rows.setitem(li_found,ls_field, ls_test )//ads_docs.getitemstring(i,"verif_info_reference_value") )
			ls_field = "screen_" + string(i)
			ads_rows.setitem(li_found,ls_field, ads_docs.getitemstring(i,"screen_alias") )
			ls_field = "exp_date_" + string(i)
			ldt_exp = ads_docs.getitemdatetime(i,"expiration_date")
			ads_rows.setitem(li_found,ls_field, string(date(ldt_exp)) )
			is_doc_ids_exp[i] = ads_docs.getitemstring(i,"doc_id")
			//messagebox("doc_id",is_doc_ids_exp[i] )
			//of_set_send_info(i)
		next
	end if //found
next

//clear the filter
ids_ai_detail.setfilter(ls_org_filter)
ids_ai_detail.filter()
 //ids_ai_detail.setredraw = true

return 1
end function

public function integer of_printletters_combined (string as_doc_id[], string as_affil_stat, string as_letter_name, string as_letter_type, u_dw adw_detail, string as_doc_name, boolean ab_print_preview, string as_sql, long al_pracids[], integer ai_facility, string as_funct_type, string as_from);//Start Code Change ----06.13.2008 #V81 maha - new function for combining all print letter functionalities
//05.05.2011 maha added OFE tracking untested
Boolean lb_error_rec
Boolean lb_print_release 
Boolean lb_print_priv
Boolean lb_found
Boolean lb_print_label = False
Boolean lb_retrieved = false
boolean lb_exp_combined = false //maha 081308
Integer li_error_cnt
Integer e
//Integer li_doc_id_cnt
long li_doc_id_cnt //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
Integer d
Integer b
Integer li_len
Integer li_start_page
Integer li_to_page
Integer li_num_pages  
Integer l
Integer li_retval
Integer li_total_letter_path_cnt
Integer li_last_num_sent
Integer li_rc
Integer li_total_letters
Integer i
Integer li_val
Integer li_found
Integer s
Integer li_ent_cnt
Integer li_pos
Integer li_ans
Integer li_ltr_cnt
Integer li_verif_facility_id
Integer li_total_facilities_cnt
Integer li_verif_facility_ids_all[]
Integer li_address_cnt
integer li_setcopy
integer li_export_id = 0
integer li_export_on = 0 
integer li_corr_response = -1
integer res  
integer li_image_cnt
integer lcnt
integer li_store_in_db
Long ll_prac_id
Long ll_loop_count
long li_facility_id = ai_facility
long ll_ver_response 
long li_ltr_rec_cnt
long  ll_ids[]
string docid 
String ls_notes
String ls_doc_name  //the file name
String ls_path
String ls_letter
String ls_letter_from_path //the directory the letter is stored in
//String ls_file_name
String ls_image_file_name
String ls_image_path
String ls_letter_dw
String ls_style
String ls_entity[]
String ls_val
String ls_val_1
String ls_verifying_facility_name[]
String ls_word_path
String ls_added_data_to_letter
//String ls_letter_path
String ls_letter_paths_all[]
String ls_doc_id
String ls_verifying_facility_nm
string ls_from  //the file that gets copied
string ls_to  //the file that gets opened
string ls_c
string ls_run_path
string ls_open_doc
string ls_open_merge
string ls_exportname
String ls_group_syntax
String ls_grey
String ls_white
String ls_presentation_str
String ls_dwsyntax_str
String Errors
string ls_client_id
string ls_old_docpath //stephen 02.18.2014
n_ds lds_letter
n_appeon_download lnv_download
n_appeon_storage_area lnv_storage_area
n_cst_array_db ln_cst_array_db_case
gs_fax lgs_fax


li_setcopy = of_get_app_setting("set_6","I")
li_store_in_db = of_get_app_setting("set_50","I")

//as_doc_name is the name of the document (no path if using db storage)
//as_letter_name is the screen name for verif letters ; the document name for correspondence letters
ls_doc_name = as_doc_name 
is_letter_name = as_letter_name
ls_added_data_to_letter = as_funct_type
//debugbreak()
//messagebox("",ls_doc_name)

lgs_fax.ss_index = "0"  //Start Code Change ----02.10.2015 #V14.2 maha

gl_export_rows_count  = 0  //maha 05.06.2015 - used for trapping count mismatches when used as a letter datasource.

//Corresp letter name trap
if as_letter_type = "P" then //for correspondence letter get the export info
	select count(letter_name) into :lcnt from sys_letters where letter_name = :is_letter_name;	
	if lcnt < 1 then
		messagebox("Letter Error","Letter '" + is_letter_name + "' does not exist in the letter Painter.  Unable to run letter." )
		return -1
	else
//new	@@@@	select use_export, export_id, letter_name, added_data into :li_export_on,:li_export_id, :is_letter_name, :ls_added_data_to_letter from sys_letters where letter_name = :as_letter_name;		
		select use_export, export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters where letter_name = :as_letter_name;		
	end if
	//for type P letters get the response code value
	SELECT code_lookup.lookup_code  	INTO :il_ver_response	FROM code_lookup WHERE ( code_lookup.lookup_name = 'Credentials Verification Response' ) AND   ( code_lookup.code = 'N/A'  )   ;

//Start Code Change ----05.05.2011 #V11 maha - process tracking
elseif as_letter_type = "OFE" then   //uses corresp data source (7-2013)
	select count(letter_name) into :lcnt  from sys_letters, sys_storage_docs where  sys_letters.document_name =  sys_storage_docs.doc_name and cast(sys_storage_docs.dct_id as varchar)  =  :as_letter_name; //string(sys_storage_docs.dct_id)  =  :as_letter_name;	//modify by Stephen 09.09.2011 Cannot print OPPE/FPPE letters bug 2614	
	if lcnt < 1 then
		messagebox("Letter Error","Letter '" + as_doc_name + "' does not exist in the letter Painter.  Unable to run letter." )
		return -1
	else
		//new	@@@@	select use_export, export_id, letter_name, added_data into :li_export_on,:li_export_id, :is_letter_name, :ls_added_data_to_letter from sys_letters where letter_name = :as_letter_name;		
		//---------Begin Modified by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------
		//$Reason:Ambiguous column name 'export_id'
		  /*
			  select use_export, export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters, sys_storage_docs where  sys_letters.document_name =  sys_storage_docs.doc_name and  cast(sys_storage_docs.dct_id as varchar)  =  :as_letter_name;//string(sys_storage_docs.dct_id)  =  :as_letter_name; //modify by Stephen 09.09.2011 Cannot print OPPE/FPPE letters bug 2614			 
		  */
		 select use_export, sys_letters.export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters, sys_storage_docs where  sys_letters.document_name =  sys_storage_docs.doc_name and  cast(sys_storage_docs.dct_id as varchar)  =  :as_letter_name;//string(sys_storage_docs.dct_id)  =  :as_letter_name; //modify by Stephen 09.09.2011 Cannot print OPPE/FPPE letters bug 2614			
		//---------End Modfiied ------------------------------------------------------------------		
	end if
	
end if
//End Code Change ----05.05.2011

//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
if gi_citrix = 1 then
	ls_letter_from_path = gs_temp_path +"Letters\"
	if NOT DirectoryExists(ls_letter_from_path) then CreateDirectory(ls_letter_from_path)
end if
//---------End Added ------------------------------------------------------

//Down load the file from database if necessary; set letter from path
If li_store_in_db = 1 or  Upper( appeongetclienttype() ) = 'WEB' Then
	IF lnv_storage_area.of_retrieve_doc_from_db( ai_facility, ls_doc_name, ls_letter_from_path) < 0 THEN //
		Messagebox("Download File",'The MSWord document '+  ls_doc_name  +'  does not exist in the database. (of_printletters_combined)')
		RETURN -1
	END IF	
	lnv_download.of_parsepath( ls_open_merge) //checks for directory
else
	for i = 1 to 50 //loop through find end of path
		b =  PosA(ls_doc_name,"\",d + 1)
		if b = 0 then
			exit
		else
			d = b
		end if
	next
	ls_letter_from_path = MidA (ls_doc_name , 1, d )	
	ls_doc_name = MidA (ls_doc_name , d + 1)
End If

//set the save paths
ls_run_path = of_letter_paths("L") //letter path
ls_open_merge = of_letter_paths("D") //merge document path

//Start Code Change ----07.23.2009 #V92 maha - trap for letters opened on server
if li_setcopy = 1 then
	ls_to = ls_run_path + ls_doc_name
	ls_from = ls_letter_from_path + ls_doc_name  //ls_from used only for copy
else
	ls_to = ls_letter_from_path + ls_doc_name
end if

//---------Begin Added by (Appeon)Eugene 06.06.2013 for V141 ISG-CLX--------
gnv_rights.of_check_dir_right(ls_run_path, true, 'Letter Path')
gnv_rights.of_check_dir_right(ls_open_merge, true, 'Letter Path')
//---------End Added ------------------------------------------------------

//End Code Change---07.23.2009

//Start Code Change ----05.05.2011 #V11 maha - removed - duplicate of above
////Corresp letter name trap
//if as_letter_type = "P" then //for correspondence letter get the export info
//	select count(letter_name) into :lcnt from sys_letters where letter_name = :is_letter_name;	
//	if lcnt < 1 then
//		messagebox("Letter Error","Letter '" + is_letter_name + "' does not exist in the letter Painter.  Unable to run letter." )
//		return -1
//	else
////new	@@@@	select use_export, export_id, letter_name, added_data into :li_export_on,:li_export_id, :is_letter_name, :ls_added_data_to_letter from sys_letters where letter_name = :as_letter_name;		
//		select use_export, export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters where letter_name = :as_letter_name;		
//	end if
//end if
//end Code Change ----05.05.2011

li_pos = PosA( is_letter_name, "/" )  //replacing / and spaces with _
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1, 500 )
END IF

li_pos = PosA( is_letter_name, " " )
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1 )
END IF

li_pos = PosA( is_letter_name, " " )
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1 )
END IF
//debugbreak()
//set the name of the letter dw object
if as_letter_type = "P" then  //prac corresp letters
	if isnull(ls_added_data_to_letter) or  ls_added_data_to_letter = "" then ls_added_data_to_letter = "C"
	choose case ls_added_data_to_letter
		case "C" //regular corresp letter
			ls_letter_dw =  "d_ltr_general_corros_act_items" 
		case "A" // missing app audit
			
		case "B" //both app audit and verification
			
		case "V" //incomplete verifications
			
		case "N" //net dev
			
		case "P" //case review
			
		case "Q" //QA
			
	end choose
elseif as_letter_type = "M" then // missing info letter
	if ls_added_data_to_letter = "V" then
		//add the verifications to the missing letter
	end if
elseif as_letter_type = "OFE" then //Start Code Change ----05.05.2011 #V11 maha - process tracking
	ls_letter_dw =  "d_ltr_ofe_correspondence"
else
	choose case  ls_added_data_to_letter
		case "E" //exp cred letters combined
			ls_letter_dw = "d_ltr_exp_cred_combined"
			is_letter_name = "expiring_combined"
			lb_exp_combined = true
		case "F" //add facilities on exp appt letters	
			//customization requested but not approved 7-08
		case else //standard verif letter
			ls_letter_dw = Lower( "d_ltr_" + is_letter_name )
		end choose
end if
//messagebox("ls_letter_dw",ls_letter_dw)

//create the action items detail dw and share it with the one on the action item interface
ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = adw_detail.DataObject 
adw_detail.ShareData( ids_ai_detail )

//create the letters datawindow and retrieve using the doc id
lds_letter = CREATE n_ds

IF  lb_exp_combined = true then
	//debugbreak()
	lds_letter.dataobject = ls_letter_dw
	lds_letter.settransobject(sqlca)
	//messagebox("","1")
	of_exp_cred_letter_combined(al_pracids[], as_doc_id[] ,ai_facility, lds_letter, adw_detail, as_from)
	//messagebox("","2")
	lb_retrieved = true
	li_ltr_rec_cnt = lds_letter.rowcount()
	
//Start Code Change ----05.11.2011 #V11 maha -ofe letters 	
Elseif as_letter_type = "OFE" then
	for b = 1 to upperbound(as_doc_id)
		ll_ids[b] = long(as_doc_id[b])
	next
	lds_letter.dataobject = ls_letter_dw
	lds_letter.settransobject(sqlca)
	li_ltr_rec_cnt = lds_letter.retrieve(ll_ids[])
	lb_retrieved = True
	if li_ltr_rec_cnt < 0 then 
		MessageBox("Print Letter","OFE Letter object retrieve failed.  Contact ISG support." )
		return -1
	end if
//End CodeChange ----05.11.2011


ELSEIF as_sql = '' OR IsNull( as_sql ) THEN //verification letters
	/* Evan 02.06.2009
	If Upper(appeongetclienttype()) = 'WEB' Then
		Choose Case ls_letter_dw
			Case 'd_ltr_expiring_dea_registration_w_cat'  //long name
				lds_letter.DataObject = 'd_ltr_expiring_dea_registration_w_catweb'
			Case 'd_ltr_expiring_special_certifications' // long name
				lds_letter.DataObject = 'd_ltr_expiring_special_certificationsweb'
			Case Else 
				lds_letter.DataObject = ls_letter_dw + '_web'
		End Choose
	Else
		lds_letter.DataObject = ls_letter_dw 
	End If
	*/
	lds_letter.DataObject = ls_letter_dw //Evan 02.06.2009
	//---------------------------- APPEON END ----------------------------	
	li_retval =lds_letter.of_SetTransObject( SQLCA )
	//MessageBox("Letter dw","")
	IF li_retval =-1 THEN
		MessageBox("Letter dw","Invalid Letter Datawindow name  -" + ls_letter_dw )
		Return -1
	END IF
	
ELSE  //for all valid standard letters

	ls_group_syntax = ""
	ls_grey = String(rgb(192,192,192))
	ls_white = String(rgb(255,255,255))
	ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
	
	as_sql = as_sql + " AND ( doc_id IN ("
	
	li_doc_id_cnt = UpperBound( as_doc_id[] )

	FOR d = 1 TO li_doc_id_cnt
		as_sql = as_sql + "'" +  as_doc_id[d] + "',"
	END FOR
	
	as_sql = MidA( as_sql, 1, LenA( as_sql )-1 ) + "))"
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(as_sql, ls_presentation_str, ERRORS)
	
	//ClipBoard( as_sql )

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	END IF

	lds_letter.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN -1
	END IF
	
	lds_letter.SetTransObject( SQLCA )
	lds_letter.Retrieve( )
	li_ltr_rec_cnt = lds_letter.rowcount()  //(Appeon)Stephen 08.14.2014 - Issue printing 70+ letters
	lb_retrieved = True  
END IF

If lb_retrieved = False Then	
	//--------------- APPEON BEGIN ---------------
	//$<modify> Evan 02.06.2009
	//$<reason> Fixed a defect	about For Web Performance	
	/*
	If Upper(appeongetclienttype()) = 'WEB' Then
		ln_cst_array_db_case = Create n_cst_array_db
		ln_cst_array_db_case.of_array_to_db( as_doc_id, ls_client_id)
		li_ltr_rec_cnt = lds_letter.Retrieve( ls_client_id )
		ln_cst_array_db_case.of_delete_temp_data(ls_client_id)
		Destroy ln_cst_array_db_case
	Else
		li_ltr_rec_cnt = lds_letter.Retrieve( as_doc_id )
	End If
	*/
	li_ltr_rec_cnt = lds_letter.Retrieve( as_doc_id[] , gs_user_id)   //Start Code Change ----02.02.2017 #V153 maha - added user fields
	//--------------- APPEON END -----------------
End If

IF li_ltr_rec_cnt < 0 THEN
	MessageBox(" Retrieval Error", "Letter query failed. Contect ISG support." )
	RETURN -1
elseif li_ltr_rec_cnt = 0 THEN
	MessageBox(" Retrieval Error", "Letter query did not return any results. Check for missing data." )		
	RETURN -1
ELSE
//End Code Change ----04.04.2017
	//************************************************************************
	//EXPORT CODE
	//\/maha 110402 check and create export file for merge document 
	if gi_export_on = 1 then 
		if as_letter_type = "P" or as_letter_type = "OFE" then //for correspondence letter get the export info //Start Code Change ----05.05.2011 #V11 maha - process tracking added
			if li_export_on = 1 then
				if li_export_id > 0 then
					res = of_run_export(al_pracids[],li_export_id,ls_open_merge)
					lgs_fax.ss_index = "1"  //Start Code Change ----02.10.2015 #V14.2 maha
					if res < 1 then 
						messagebox("Export Error","Failed to create file from export.")
						li_export_on = 0
					else
						select export_name into :ls_exportname from export_header where export_id = :li_export_id;
					end if
				end if
			end if
		else
			IF as_letter_name = "expiring_appointment"  THEN
				SELECT reapp_export, reapp_export_id
				INTO:li_export_on,
					 :li_export_id 
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF
			elseif as_letter_name = "expiring_provisional" then
				SELECT prov_export, prov_export_id
				INTO:li_export_on,
					 :li_export_id
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF	
			elseif as_letter_name = "expiring_allied_health"  then
				SELECT reappah_export, reappah_export_id
				INTO:li_export_on,
					 :li_export_id
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF
			END IF
			if li_export_on = 1 then
				if li_export_id > 0 then
					res = of_run_export(al_pracids[],li_export_id,ls_open_merge) //returns the merge file name in ls_open_merge
					if res < 1 then 
						messagebox("Export Error","Failed to create file from export.")
						li_export_on = 0
					else
						lgs_fax.ss_merge_file_path = ls_open_merge  //Start Code Change ----01.05.2010 #V10 maha - get path value for mail labels
						select export_name into :ls_exportname from export_header where export_id = :li_export_id;
					end if
				end if
			end if	
		end if
	end if
	//\maha	
END IF

ls_style = "ind"

li_ltr_cnt = 0 //w_ai_print_letters.dw_letters.GetItemNumber( w_ai_print_letters.dw_letters.GetRow(), "ctotal_letters"  )

li_rc = lds_letter.RowCount( )
			
IF li_rc < 1 THEN
		RETURN -1 //CONTINUE
		messagebox("","no li_rc")
END IF
	//debugbreak()
//save the data source
lds_letter.SaveAs( ls_open_merge + is_letter_name + ".txt", Text!, True )		
lds_letter.SaveAs( ls_open_merge + "mailing_labels_ver_letter.txt", Text!, True )		
lds_letter.SaveAs( ls_open_merge + "ind_generic_corrospondence.txt", Text!, True )

//if running from an export set the merge variable to the export name 
if li_export_on = 1 then
	// return by of_run_export function if using an export
	else
		ls_open_merge =  ls_open_merge + is_letter_name + ".txt"
end if


//word path code removed 02 2405 maha 4.517 readded 071805 to allow as option
if li_setcopy = 5 then //specific setting to use old open word functionality
	ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
		
	If appeongetclienttype() = 'PB' Then
		IF NOT FileExists(gs_IniFilePathName) THEN
			MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
			Return -1
		END IF
	End If

	//check to see if ms word path set in ini file is correct
	IF NOT FileExists( ls_word_path ) THEN 
		MessageBox("Print Error", "Invalid MS Word for Windows path set in INI file: " + ls_word_path )
		Return -1
	END IF
end if

//s:\letters\education.doc"
//li_len = Len( ls_doc_name )
//debugbreak()
//COPY letter function	  @@@@@@@@@@@@@@@@@@@@@@@@@@	
IF li_setcopy = 1 THEN //copy letter
	if upper(ls_letter_from_path) = upper(ls_run_path) then //maha 050602 trap against copying to same location
		messagebox("Path error","Your letter path is set to " + ls_run_path + " ~rand the Copy Letters setting is turned on. ~rGo to System->Utilities->Application settings and set Copy Letters to No to run letters normally.")
		return -1
	end if
	//check to make sure letter and path exists
	IF NOT FileExists(ls_letter_from_path + ls_doc_name ) THEN
		MessageBox("Print Error", "Cannot find word letter " +  ls_doc_name + " in directory: " + ls_letter_from_path )
		Return -1
	else 
		//ls_from  = ls_letter_from_path + ls_doc_name //Start Code Change ----07.24.2009 #V92 maha  - removed as redundant
	END IF
			
	//copy letter  then run
	if fileexists(ls_to) then
		if FileDelete( ls_to) = false then //maha040705
			//messagebox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in " + gs_dir_path + "IntelliCred\Letters\Standard prior to copy.~r  Check letter properties to see if letter is Read Only.")
			messagebox("Copying letter from server","Unable to delete existing letter " + ls_to + " prior to copy.~r  Check letter properties to see if letter is Read Only.")  //Start Code Change ----02.28.2008 #V8 maha - corrected message to correct path
		end if
	end if

	CopyFileA( ls_from, ls_to, true )
				
	DO WHILE NOT FileExists( ls_to )
		ll_loop_count++
		IF ll_loop_count = 1000000 THEN
			MessageBox("Timeout", "Timed out trying to copy Word file.  ~rfrom: " + ls_from + "~r to: " + ls_to)
			EXIT
		END IF
	LOOP
ELSE //not copy//Start Code Change ----07.06.2009 #V92 maha - if not copy, set the open file to the from file
	//ls_to = ls_from  //Start Code Change ----07.24.2009 #V92 maha - not necessary
END IF
		
//check to make sure letter and path exists
IF NOT FileExists(ls_to ) THEN
	MessageBox("Print Error", "Invalid letter document path: " + ls_to)
	Return -1
END IF

if li_setcopy = 5 then //maha 071805 to allow old method cannot be used with copy letters
	Run( ls_word_path + " " + ls_to , Maximized!)//" /mpreview"
else
	//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
	if gi_citrix = 1 then
		ls_old_docpath = gnv_app.gnvlo_msword.is_directory
		gnv_app.gnvlo_msword.is_directory = gs_temp_path +"fax\"				
		if NOT DirectoryExists(gnv_app.gnvlo_msword.is_directory) then CreateDirectory(gnv_app.gnvlo_msword.is_directory)
	end if
	//---------End Added ------------------------------------------------------
	if gnv_app.gnvlo_msword.of_open_word_document( ls_to , ls_open_merge, "Verification") = -1 then
		if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = ls_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing
		return -1
	end if
	if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = ls_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing
		
end if
//@@@@@@@@@@@@@@@@@@ end of letter open @@@@@@@@@@@@@@@@@@@@@	
	
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or   Upper( appeongetclienttype() ) = 'WEB' Then
	IF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN 
		lgs_fax.ss_mail_label_doc = "mailing_labels_prac_corro_letters.doc"
	ELSE			
		lgs_fax.ss_mail_label_doc = "mailing_labels_ver_letter.doc"
	END IF
else
	IF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN 
		lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_prac_corro_letters.doc"
	ELSE			
		lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_ver_letter.doc"
	END IF
end if


//settings for print message box
lgs_fax.ss_message = "If the " + upper(is_letter_name) + " letter generated properly select process options below and click Continue. "
lgs_fax.ss_letter_name =  ls_style + "_" + is_letter_name + "_letter" 
lgs_fax.ss_letter_document_name = ls_doc_name// + "/mpreview"
lgs_fax.sdw_letter = lds_letter
if li_export_on=  1 then lgs_fax.ss_process_type = "Export"   //Start Code Change ----05.06.2015 #V15 maha  - part of trap for unmatched provider data in faxing

//@@@@@@@ may need addtional for missing/ appl
IF is_letter_name = "expiring_appointment"  OR is_letter_name = "expiring_provisional" OR is_letter_name = "expiring_allied_health" THEN
	lgs_fax.ss_letter_type = "ExpAppt"
elseif as_letter_type = "P" then //correspond letter
	lgs_fax.ss_letter_type = "Corro"
elseIF  lb_exp_combined = true then  //Start Code Change ----04.05.2010 #V11 maha
	lgs_fax.ss_letter_type = "ExpLtr"
ELSEIF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN
	lgs_fax.ss_letter_type = "ExpLtr"	
elseif ls_letter_dw = 'd_ltr_ofe_correspondence' then //add by stephen --09.09.2011 Cannot print OPPE/FPPE letters .Bug id 2614
	lgs_fax.ss_letter_type = "ExpLtr"	
ELSE
	lgs_fax.ss_letter_type = "Verif"			
END IF		
	
//wait for user to ok the printing
OpenWithParm( w_ai_print_msg_box, lgs_fax )
//debugbreak()
gs_fax_error_records lst_fax_error_records
lst_fax_error_records = Message.PowerObjectParm
IF lst_fax_error_records.il_error_rec_num[ 1 ] = -2 THEN		
	Return -1
END IF		
		
li_error_cnt = UpperBound( lst_fax_error_records.il_error_rec_num )
		
//update the action item detail screen with date/time user stamps

IF lb_exp_combined = true then
	for s = 1 to upperbound(as_doc_id[])
		ls_doc_id = as_doc_id[s]
		li_found = ids_ai_detail.Find( "doc_id = '" +  ls_doc_id + "'" , 1, 100000 )  //Start Code Change ----01.30.2012 #V12 maha - changed from 1000
		IF li_found < 1 THEN Continue
		of_set_send_info(li_found, "N", true)
		w_ai_print_letters.dw_letters.SetItem( li_found , "num_printed", li_rc)	//maha 051501	
		w_ai_print_letters.dw_letters.SetItem( li_found, "print_status", 1 )
	next
	
	
Else	//all letters other than the exp cred combined
	FOR s = 1 TO li_rc
		lb_error_rec = False
		FOR e = 1 TO li_error_cnt
			IF lst_fax_error_records.il_error_rec_num[e] = s THEN
				lb_error_rec = True
				Exit
			END IF
		END FOR
		IF lb_error_rec THEN
			CONTINUE
		END IF
		
		ls_doc_id = lds_letter.GetItemString( s, "doc_id" )
		li_found = ids_ai_detail.Find( "doc_id = '" +  ls_doc_id + "'" , 1, 100000 )   //Start Code Change ----01.30.2012 #V12 maha - changed from 1000
	
		IF li_found < 1 THEN Continue
	
	
	
		if as_letter_type = "P" and li_corr_response = 0 then// Correspondence (Approval) letters only and  if needs response is set to No complete the verification
			of_set_send_info(li_found, "Y", false)
		else
			of_set_send_info(li_found, "N", false)
		end if
	
	END FOR
	
	//if all the letters were printed successfully then put a check next to the letter
	IF li_ltr_cnt = li_total_letters THEN //@@@@@@ where get these values  also in combined sets or all letters
		w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "num_printed", li_rc)	//maha 051501	
		w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "print_status", 1 )
	END IF 
End If
						
//update the action item detail view by updating then re-retrieving data
IF ids_ai_detail.Update() <> 1 THEN
	MessageBox("Update Failed", "Error while updating " + adw_detail.DataObject )
ELSE
	COMMIT USING SQLCA;
	adw_detail.Event pfc_Retrieve()
END IF


Destroy ids_ai_detail
Destroy lds_letter
Destroy ids_ai_detail

Return 0
end function

public function integer of_set_active_users ();//Start Code Change ----05.15.2009 #V92 maha - added for ameripath customization

integer i
integer li_val
datetime ldt_comp

select disable_90_days into :i from security_settings;
//debugbreak()
if i > 0 then
	li_val = 0 - i
	ldt_comp = datetime(relativedate(today(), li_val),time('00:00:00'))
	update security_users set active_status = 0 where last_login_date < :ldt_comp;
end if

return 1
end function

public function integer of_df_expiring_update ();//update data for expiring data flows - dataflow: joe.zhang 12.21.2009

n_cst_dataflow lnv_dataflow


//update data 
Lnv_dataflow.of_df_update("P") //added by long.zhang 06.12.2012 V12.2 Privilege Suspension 
return lnv_dataflow.of_df_update("E")
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_notificationalert ();//////////////////////////////////////////////////////////////////////
// $<function> of_notificationalert
// $<arguments>
// $<returns> integer
// $<description> Run all of notification alert
//						(V10.1 - Notification Alert)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.08.2010
//////////////////////////////////////////////////////////////////////

n_cst_notification_alert lnv_Alert

lnv_Alert = Create n_cst_notification_alert
lnv_Alert.of_Run()
Destroy lnv_Alert

Return 1
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_set_send_info (long al_row, string as_response, boolean ab_note);//Start Code Change ----06.16.2008 #V81 maha - function created for setting sent values
//05.05.2011 maha added ab_note argument
long li_found
integer li_last_num_sent
string ls_notes

li_found = al_row

li_last_num_sent = ids_ai_detail.GetItemNumber( li_found, "number_sent" )
IF IsNull(li_last_num_sent) THEN
	li_last_num_sent = 0
END IF
li_last_num_sent++
ids_ai_detail.SetItem( li_found, "number_sent", li_last_num_sent )
ids_ai_detail.SetItem( li_found, "print_flag", 0 )			
IF IsNull( ids_ai_detail.GetItemDateTime( li_found, "first_sent" ) ) THEN
	ids_ai_detail.SetItem( li_found, "first_sent", DateTime(Today(), Now()) )
END IF

//Start Code Change ----05.05.2011 #V11 maha 
if ab_note then
	ls_notes = ids_ai_detail.GetItemString( li_found, "notes" ) 
	IF IsNull( ls_notes ) OR ls_notes = "" THEN
		ls_notes= ""
	END IF
	
	ls_notes+= " Notice Sent in combined letter."//Start Code Change ----02.10.2009 #V92 maha
	ids_ai_detail.SetItem( li_found, "notes", ls_notes )
end if
//End Code Change ----05.05.2011

//Start Code Change ----08.03.2011 #V11 maha - 
ids_ai_detail.SetItem( li_found, "mod_user", gs_user_id )
ids_ai_detail.SetItem( li_found, "mod_date",  DateTime(Today(), Now())  )
//End Code Change ----08.03.2011 
		
ids_ai_detail.SetItem( li_found, "last_sent", DateTime(Today(), Now()) )

if as_response = "Y" then // Correspondence (Approval) letters only
	ids_ai_detail.SetItem(  li_found, "response_code", il_ver_response )
	ids_ai_detail.SetItem(  li_found, "date_recieved", DateTime( Today(),Now()) )
	ids_ai_detail.SetItem(  li_found, "user_name", gs_user_id )
end if

return 1
end function

public function integer of_meeting_create ();//Start Code Change ----08.08.2011 #V11 maha - function created for auto meeting creation

n_ds lds_batch
n_cst_meeting_creation lnv_meet
integer res
integer r
integer rc
long ll_batch
datetime ldt_last  //passed by reference

lnv_meet = create n_cst_meeting_creation
lds_batch = create n_ds


lds_batch.dataobject = 'd_meeting_batch_auto_create'

lds_batch.settransobject(sqlca)
rc = lds_batch.retrieve( )

for r = 1 to rc
	ll_batch = lds_batch.getitemnumber(r,"batch_id")

	res = lnv_meet.of_create_meetings( ll_batch,"SYSTEM",ldt_last)

	//This logic had been moved to lnv_meet.of_create_meetings since 2012, Comment by Appeon long.zhang 04.18.2017 (BugL041801)
//	if res = 1 then
//		lds_batch.setitem(r,"last_created",ldt_last)
//	end if
next

//lds_batch.update() //This logic had been moved to lnv_meet.of_create_meetings since 2012, Comment by Appeon long.zhang 04.18.2017 (BugL041801)

destroy lnv_meet
destroy lds_batch



return 1
end function

public function long of_expiring_credentials_from_data_new (string as_from);//Start Code Change ----10.13.2011 #V12 maha - copied the oldest code to rework
//the of_expiring_credentials_from_data function is flawed and does not work

integer li_days
integer li_screen
integer li_priority
integer li_exp_flag
integer li_act_stat
integer li_exp_days
integer li_found
integer clicks
integer li_screen_array_cnt
integer li_screen_ids[]
integer li_bs_year
integer li_month
integer ll_code
integer ac
integer li_complete = 1
integer exp_days
integer li_max_exp_days

long ll_resp_code = 2
long ll_verif_method = 1
long ll_ref1no
long ll_ref1
long ll_ref2
long ll_ref_exp
long s
long sc
long d
long dc
long f
long fc
long pc
long cnt = 0
long tcnt = 0
integer chk
long ll_rec
long ll_prac
long ll_facil 
Long ll_seq
long ll_rowcount
long r
long ll_newrow
long ll_null_no
long ll_address_code
Long ll_ref1_arr[],ll_ref1_arr_i,ll_dataobject_arr_i,ll_dataobject_arr_cnt
long ll_prac_count
long ll_prac_list[]
long ll_rec_ids[]

string ls_screen_name
string ls_ref1_lu
string ls_ref2_lu
string ls_ref1_lutype
string ls_ref2_lutype
string ls_ref1_dtype
string ls_ref2_dtype
string ls_ref1_lufield
string ls_ref2_lufield
string ls_ref1_name
string ls_ref2_name
string ls_refexp_name
string ls_priority_user
string ls_ref_value
string ls_datatype
string ldw
string ls_reference1
string ls_reference2
string ls_reference
string ls_doc_id
String ls_dataobject, ls_dataobject_arr[]
string fil

datetime ld_exp
datetime ldt_exp_date
datetime ldt_null_date
datetime ldt_exp_ret

Boolean lb_existing

datastore lds_screen
datastore lds_facils
datastore lds_sys_field
datastore lds_verif
datastore lds_data
datastore lds_existing
Datastore lds_dataobject_arr[]
datastore lds_prac_list


//test for exp cred method
ll_verif_method = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(code) = upper('Exp Cred Ltr')"))
if ll_verif_method < 1 then
	inv_message.of_MessageBox("Missing Data", "You do not have a Verification Method lookup with the code of 'Exp Cred Ltr'.~rUnable to continue.",true)
	return -1
end if

ldt_exp_ret = datetime( relativedate(today(), li_max_exp_days + 60), time("00:00:00"))

lds_screen = CREATE datastore
lds_screen.dataobject = "d_verif_screens_exp" // all facility ver rules for exp verifs
lds_existing = CREATE datastore
lds_existing.dataobject = "d_verif_exp_4_record_ids" //
lds_facils = CREATE datastore
lds_facils.dataobject = "d_prac_affils_verif_all"//
lds_sys_field = CREATE datastore
lds_sys_field.dataobject = "d_field_data_forpt"//
lds_verif = CREATE datastore
lds_verif.dataobject = "d_verif_exp_4_record"//
lds_prac_list = CREATE datastore
lds_prac_list.dataobject = "d_exp_cred_prac_list"//
lds_data = CREATE datastore
setnull(ldt_null_date)
lds_sys_field.settransobject(sqlca)
lds_facils.settransobject(sqlca)
lds_screen.settransobject(sqlca)
lds_verif.settransobject(sqlca)
lds_prac_list.settransobject(sqlca)
lds_existing.settransobject(sqlca)

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 100

//gets all distinct verif rules where data_view = 1, screen > 1 and exp_days > 0 and the screen has an exp_field
sc = lds_screen.retrieve()
//st_sc.text = string(sc)
if sc < 1 then 
	inv_message.of_MessageBox("Expiring Credentials", "There are no verification rules set up for expiring Verifications.  Skipping this function.",true)
	if IsValid(lds_screen) then Destroy lds_screen
	if IsValid(lds_facils) then Destroy lds_facils
	if IsValid(lds_sys_field) then Destroy lds_sys_field
	if IsValid(lds_verif) then Destroy lds_verif
	return -1
end if

clicks = integer(700/sc)

//get all reference values field ids
for s = 1 to sc
	li_screen = lds_screen.getitemnumber(s,"screen_id")
	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
	r =  lds_screen.getitemnumber(s,"exp_field")

	ll_ref1_arr_i ++
	ll_ref1_arr[ll_ref1_arr_i] = ll_ref1
	ll_ref1_arr_i ++
	ll_ref1_arr[ll_ref1_arr_i] = ll_ref2
	ll_ref1_arr_i ++
	ll_ref1_arr[ll_ref1_arr_i] = ll_ref_exp
	//get the screens in an array to get rule data
	 li_screen_array_cnt++
	 li_screen_ids[ li_screen_array_cnt] = li_screen
next

//get the ref value data
d = lds_sys_field.Retrieve( ll_ref1_arr[] )
//messagebox("lds_sys_field retrieve",d)
//get the rules connected to 
//lds_rules.retrieve(li_screen_ids[]), //????

ll_prac_count = lds_prac_list.retrieve(ldt_exp_ret )
if ll_prac_count < 1 then
	messagebox("lds_prac_list retrieve - " + string(ll_prac_count), "No providers retrieved")
	return 1
end if

for d = 1 to ll_prac_count
	ll_prac_list[d] = lds_prac_list.getitemnumber(d,"prac_id")
next
//messagebox("lds_prac_list retrieve",upperbound(ll_prac_list))
//get all the practitioner appointments for the data screens
d = lds_facils.retrieve(ll_prac_list[],li_screen_ids[])
if d < 1 then
	messagebox("lds_facil retrieve - " + string(d), "No facility records retrieved")
	return 1
end if
//messagebox("lds_facil retrieve",d)

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
//------------------------------------------------------------------------------------------------------

if gnv_data.ids_address_lookup.rowcount() = 0 then
	gnv_data.ids_address_lookup.settransobject(sqlca)
	d = gnv_data.ids_address_lookup.retrieve()
	messagebox("address lookup ret",d)
end if

//for each data screen
for s = 1 to sc
	tcnt = 0
	//lds_verif.reset()
//	st_cs.text = string(s)
	li_screen = lds_screen.getitemnumber(s,"screen_id")
	ls_screen_name = lds_screen.getitemstring(s,"screen_name")
	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
	
	select max(exp_cred_que_letters_days) into :li_max_exp_days from facility_ver_rules  where screen_id = :li_screen;
	ldt_exp_ret = datetime( relativedate(today(), li_max_exp_days + 1), time("00:00:00"))
	
	
	//get ref 1 data
	lds_sys_field.SetFilter("field_id = " + String(ll_ref1))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref1  = 0
	else		//ref one data
		ls_ref1_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref1_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref1_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref1_lu = "Y" then
			ls_ref1_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref1_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if

	//get ref 2 data
	lds_sys_field.SetFilter("field_id = " + String(ll_ref2))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref2 = 0
	else	 //ref 2 data
		ls_ref2_dtype = lds_sys_field.getitemstring(1,"field_type")
		ls_ref2_name = lds_sys_field.getitemstring(1,"field_name")
		ls_ref2_lu = lds_sys_field.getitemstring(1,"lookup_field")
		if ls_ref2_lu = "Y" then
			ls_ref2_lutype = lds_sys_field.getitemstring(1,"lookup_type")
			ls_ref2_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
		end if
	end if
	//get exp field data
	lds_sys_field.SetFilter("field_id = " + String(ll_ref_exp))
	lds_sys_field.Filter( )
	If lds_sys_field.Rowcount( ) < 1 Then
		ll_ref_exp = 0
	else
		ls_refexp_name = lds_sys_field.getitemstring(1,"field_name")
	end if

	
	lds_data.dataobject = ""
	CHOOSE CASE li_screen

		CASE 4//"License"
			lds_data.dataobject = "d_exp_license_verif"
	         if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Licenses"

		CASE 5 //"DEA"
			lds_data.dataobject = "d_exp_dea_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring DEAs"

		CASE 9 //Special Certs
			lds_data.dataobject = "d_exp_spec_certs_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Special Certifications"

		CASE 15 //"Insurance"
			lds_data.dataobject = "d_exp_insurance_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Insurance Records"

		CASE 19 //"Board/Specialty"
			lds_data.dataobject = "d_exp_spec_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Board Certifications"

		CASE 23 //Other Ids
			lds_data.dataobject = "d_exp_other_ids_verif"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Other IDS"

		CASE else
			messagebox("Continue","This utility does not support Expiring verification Creation for the " + ls_screen_name + " screen.")
			continue
	END CHOOSE


	lds_data.settransobject(sqlca)
	//get the data for the specific screen
	dc = lds_data.retrieve(ldt_exp_ret)
//messagebox(string(li_screen),dc)
	if dc < 1 then continue
	
	cnt = 0

	//get the list of recids and retrieve verifs
	for d = 1 to dc	
		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_rec_ids[d] = ll_rec
	next
	
	d = lds_existing.retrieve(ll_rec_ids, ll_verif_method )
	//messagebox("verifs found",d)
	
	//go through list and create verifications for each facility where required
	for d = 1 to dc	
		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")

		//get expiration date value
		IF ll_ref_exp > 0 THEN
			//certificationexpires is not really supported by this function
//			IF ls_refexp_name = "certification_expires" THEN	
//				ldt_exp_date = DateTime(Date( "12-30-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
//				
//			ELSEIF ls_refexp_name = "cert_expiration_year" THEN
//				li_month = lds_data.GetItemNumber( d, "cert_expiration_month" )
//				choose case li_month
//					case 2
//						li_days = 28
//					case 1,3,5,7,8,10,12
//						li_days = 31
//					case else
//						li_days = 31
//				end choose
//				if isnull(li_month) then
//					ldt_exp_date = DateTime(Date( "12-31-" + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
//				else
//					ldt_exp_date = DateTime(Date(String(li_month) + String(li_days) + String( lds_data.GetItemNumber( d, ls_refexp_name ) ) ),Now())
//				end if
//			ELSE
				ldt_exp_date = lds_data.GetItemDateTime( d, ls_refexp_name )
//			END IF
		ELSE
			continue
		END IF
	//*************** reference data *******************
		//get reference 1 data
		
		IF ll_ref1 > 0 THEN
			IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
				ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
			elseif ls_ref1_dtype = "C" then
				ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
			elseif ls_ref1_dtype = "D" then
				ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
			end if
			if ls_ref1_lu = "Y" then
				ll_code = long(ls_reference1)
				if isnumber(ls_reference1) then ll_address_code = ll_code
				if ls_ref1_lutype = "A" then
					if upper(ls_ref1_lufield) = "ENTITY NAME" THEN
						ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
					else
						ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
					end if

				elseif ls_ref1_lutype = "C" then
					if upper(ls_ref1_lufield) = "DESCRIPTION" THEN
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
					else
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
					end if
				end if
			end if
		end if			
		if isnull(ls_reference1) then ls_reference1 = ""
					
		//get reference 2 data
		IF ll_ref2 > 0 THEN
			IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
				ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
			elseif ls_ref2_dtype = "C" then
				ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
			elseif ls_ref2_dtype = "D" then
				ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
			end if
			if ls_ref2_lu = "Y" then
				ll_code = long(ls_reference2)
				if isnumber(ls_reference2) then ll_address_code = ll_code
				if ls_ref2_lutype = "A" then
					if upper(ls_ref2_lufield) = "ENTITY NAME" THEN
						ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
					else
						ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
					end if
					
				elseif ls_ref2_lutype = "C" then
					if upper(ls_ref2_lufield) = "DESCRIPTION" THEN
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
					else
						ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
					end if
				end if
			end if
		END IF
		if isnull(ls_reference2) then ls_reference2 = ""
		ls_reference = ls_reference1 + " - " + ls_reference2
		
		//IF ls_screen_name = "Licensure" THEN exception for the code
		IF li_screen = 4 THEN					
			ll_address_code = lds_data.GetItemNumber( d, "verifying_agency" )
		end if
		
		choose case li_screen
			case 4,5,15
				li_act_stat =  lds_data.GetItemNumber( d, "active_status" )
		end choose
				
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@		
		//filter the appointment records
		fil = "prac_id = " + string(ll_prac) + " and screen_id = " + string(li_screen)

		fc = lds_facils.setfilter ( fil)
		if fc < 0 then messagebox("of_expiring_credentials_from_data_new","Bad filter for lds_facil")
		lds_facils.filter()
		fc = lds_facils.rowcount()
		
		if fc < 1 then
			//messagebox("fc",fc)
			continue
		end if
		for f = 1 to fc
			li_found = 0
			ll_facil = lds_facils.getitemnumber(f,"verifying_facility")
			exp_days = lds_facils.getitemnumber(f,"exp_cred_que_letters_days")
			ls_priority_user = lds_facils.getitemstring(f,"priority_user")
			if RelativeDate ( today(), exp_days ) <  date(ldt_exp_date) then continue //skip if has not expired yet by these rules

			//filter the verifs 
			fil = "prac_id = " + string(ll_prac) + " and rec_id = " + string(ll_rec) + " and facility_id = " + string(ll_facil) 
			cnt = lds_existing.setfilter( fil)
			if cnt < 0 then
				messagebox("of_expiring_credentials_from_data_new","Bad filter for lds_existing~r" + fil)
				return -1
			end if
			lds_existing.filter()
			cnt = lds_existing.rowcount()

			if cnt > 0 then  //this means a record exists
				continue
			else
				 //messagebox("",cnt)
				select max(seq_no) into :ll_seq from verif_info where rec_id = :ll_rec and prac_id = :ll_prac and facility_id = :ll_facil;
				if isnull(ll_seq) then ll_seq = 0
				ll_seq++

				
				//********* create verif ****************
				ll_newrow = lds_verif.insertrow(0)
				
				
				lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
				lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
				lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
				lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
				lds_verif.setitem(ll_newrow,"screen_id",li_screen)
				lds_verif.setitem(ll_newrow,"active_status",1)
				lds_verif.setitem(ll_newrow,"number_sent",0)
				lds_verif.setitem(ll_newrow,"source","P")
				lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
				lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
				lds_verif.setitem(ll_newrow,"verification_method",ll_verif_method)
				lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
				lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
				lds_verif.setitem(ll_newrow,"priority",1)
				lds_verif.setitem(ll_newrow,"exp_credential_flag",1)
				ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
				lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
				lds_verif.setitem(ll_newrow,"print_flag",0)
				lds_verif.setitem(ll_newrow,"notes","eieio")
				lds_verif.setitem(ll_newrow,"data_status",1)
				// R.Avital v11.3 capture creation date and user
				// Begin changes
				lds_verif.SetItem(ll_newrow, 'create_date', DateTime(Today(), Now()))
				lds_verif.SetItem(ll_newrow, 'create_user', Trim(gs_user_id) + "Sys-AIQ")
				// R.Avital v11.3 END changes
				
				tcnt++			
//				st_added.text = string(tcnt)

//				lds_verif.update()
//				commit using sqlca;
			end if
			
		next
		lds_verif.update()
		commit using sqlca;
	next
messagebox("screen count",tcnt)		
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = w_aiq_run.r_status.width + clicks
next

if as_from = "Utility" then
	tcnt = lds_verif.rowcount()
	messagebox("total count",tcnt)
	d = lds_verif.sharedata(w_exp_cred_create_util.dw_data)
	messagebox("share data", d)
end if

destroy lds_screen
destroy lds_facils
destroy lds_sys_field
destroy lds_verif
destroy lds_data
destroy lds_existing

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 800
return 1
end function

public function integer of_printletters (string as_doc_id[], string as_affil_stat, string as_letter_name, string as_letter_type, u_dw adw_detail, string as_doc_name, boolean ab_print_preview, string as_sql, long as_pracids[], long ai_facility, long al_parent, integer ai_screen);Boolean lb_error_rec
Boolean lb_print_release 
Boolean lb_print_priv
Boolean lb_found
Boolean lb_print_label = False
String ls_notes
String ls_doc_name
String ls_path
String ls_letter
String ls_file_name
String ls_image_file_name
String ls_image_path
String ls_letter_dw
String ls_style
String ls_entity[]
String ls_val
String ls_val_1
String ls_verifying_facility_name[]
String ls_word_path
String ls_letter_path
String ls_letter_paths_all[]
String ls_doc_id
String ls_verifying_facility_nm
string ls_from //maha 052802
string ls_to //maha 052802
string ls_c
string ls_run_path
string ls_open_doc
string ls_open_merge
string ls_export_merge //maha 073009
string ls_exportname
string ls_parent //maha 03.07.2012
string ls_old_docpath  //stephen 02.18.2014
n_ds lds_letter
Integer li_error_cnt
Integer e
Integer li_doc_id_cnt
Integer d
Integer b
Integer li_len
Integer li_start_page
Integer li_to_page
Integer li_num_pages  
Integer l
long li_ltr_rec_cnt//maha101000 to long
Integer li_retval
Integer li_total_letter_path_cnt
Integer li_last_num_sent
Integer li_rc
Integer li_total_letters
Integer i
Integer li_val
Integer li_found
Integer s
Integer li_ent_cnt
Integer li_pos
Integer li_ans
Integer li_ltr_cnt
Integer li_verif_facility_id
Integer li_total_facilities_cnt
Integer li_verif_facility_ids_all[]
Integer li_address_cnt
integer li_set6//maha
integer li_export_id = 0 //maha
integer li_export_on = 0  //maha 021704
integer li_corr_response = -1 //maha 041008 
Long ll_prac_id
Long ll_loop_count
long li_facility_id = ai_facility//maha 021704
long ll_ver_response //maha 041008
string docid //maha
integer res  //maha
integer li_image_cnt //maha 021904
integer lcnt, li_col
Long al_pracids[] //Modified ai_pracids to long type,  by Appeon long.zhang 08.07.2017 (Bug id 5753 - Can't populate Prac Corro letter from Action Items   SaaS V15.3 07212017)
gs_fax lgs_fax
Boolean lb_retrieved = false  //Ken.Guo 10/31/2007
ls_doc_name = as_doc_name  //Ken.Guo 11/01/2007 Fix bug

is_letter_name = as_letter_name
il_facility = ai_facility
//as_doc_name is the name of the document no path
//as_letter_name is the screen name for verif letters ; the document name for correspondence letters

//messagebox("as_letter_name",as_letter_name)
//Start Code Change ---- 01.23.2006 #215 maha
ls_run_path = of_letter_paths("L") //letter path
ls_open_merge = of_letter_paths("D") //merge document path
//messagebox("ls_open_merge",ls_open_merge)
//End Code Change---01.23.2006 

gl_export_rows_count  = 0  //maha 05.06.2015 - used for trapping count mismatches when used as a letter datasource.

//---------Begin Added by (Appeon)Eugene 06.06.2013 for V141 ISG-CLX--------
gnv_rights.of_check_dir_right(ls_run_path, true, 'Letter Path')
gnv_rights.of_check_dir_right(ls_open_merge, true, 'Letter Path')
//---------End Added ------------------------------------------------------

//Start Code Change ---- 09.27.2007 #V7 maha
if as_letter_type = "P" then //for correspondence letter get the export info
	select count(letter_name) into :lcnt from sys_letters where letter_name = :as_letter_name;	
	if lcnt < 1 then
		//Start Code Change ----03.25.2010 #V10 maha - add ability to select letter where not found
		open(w_select_letter)
		as_letter_name = message.stringparm
		if as_letter_name = "C" then
			//messagebox("Letter Error","Letter '" + as_letter_name + "' does not exist in the letter Painter.  Unable to run letter." )
			return -1
		else
			select use_export, export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters where letter_name = :as_letter_name;
		end if
		//End Code Change---03.25.2010
	else
		select use_export, export_id, letter_name into :li_export_on,:li_export_id, :is_letter_name from sys_letters where letter_name = :as_letter_name;		
	end if
end if
//End Code Change---09.27.2007
//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
if gi_citrix = 1 then
	ls_letter_path = gs_temp_path +"Letters\"
	if NOT DirectoryExists(ls_letter_path) then CreateDirectory(ls_letter_path)
end if
//---------End Added ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-24
//$<add> 01.13.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Create the downloading directory if it does not exist.
n_appeon_download lnv_download
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then

	//Down load the file from database
	n_appeon_storage_area lnv_storage_area

	IF lnv_storage_area.of_retrieve_doc_from_db( ai_facility, as_doc_name, ls_letter_path) < 0 THEN //
		Messagebox("Download File",'The MSWord document '+  as_doc_name  +'  does not exist in the database. (of_printletters)')
		RETURN -1
	END IF	
	
	as_doc_name = ls_letter_path + as_doc_name
	
	lnv_download.of_parsepath( ls_open_merge)
End If
//---------------------------- APPEON END ----------------------------

//SELECT set_6 INTO :li_set6 FROM icred_settings;
li_set6 = of_get_app_setting("set_6","I")
//messagebox("ls_open_merge",ls_open_merge)
//messagebox("as_doc_name",as_doc_name) //as_doc_name is the path and the letter name
//return 1
li_pos = PosA( is_letter_name, "/" )  //replacing / and spaces with _
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1, 500 )
END IF

li_pos = PosA( is_letter_name, " " )
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1 )
END IF

li_pos = PosA( is_letter_name, " " )
IF li_pos > 0 THEN
	is_letter_name = MidA( is_letter_name, 1, li_pos -1) + "_" + MidA( is_letter_name, li_pos+1 )
END IF

lgs_fax.ss_index = "0"  //Start Code Change ----02.10.2015 #V14.2 maha

ls_letter_dw = Lower( "d_ltr_" + is_letter_name )
if as_letter_type = "P" then ls_letter_dw =  "d_ltr_general_corros_act_items" //maha 081601
//messagebox("ls_letter_dw",ls_letter_dw)

//create the action items detail dw and share it with the one on the action item interface
ids_ai_detail = CREATE n_ds
ids_ai_detail.DataObject = adw_detail.DataObject 
adw_detail.ShareData( ids_ai_detail )
//messagebox("adw_detail.DataObject",adw_detail.DataObject)
//GarbageCollect ( )maha removed 073002

//create the letters datawindow and retrieve using the doc id
lds_letter = CREATE n_ds
IF as_sql = '' OR IsNull( as_sql ) THEN //verification letters
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10/31/2007 By: Ken.Guo
	//$<reason> For retrieve performance
	lds_letter.DataObject = ls_letter_dw
	/* Evan 02.06.2009
	If Upper(appeongetclienttype()) = 'WEB' Then
		Choose Case ls_letter_dw
			Case 'd_ltr_expiring_dea_registration_w_cat'  //long name
				lds_letter.DataObject = 'd_ltr_expiring_dea_registration_w_catweb'
			Case 'd_ltr_expiring_special_certifications' // long name
				lds_letter.DataObject = 'd_ltr_expiring_special_certificationsweb'
			Case Else 
				lds_letter.DataObject = ls_letter_dw + '_web'
		End Choose
	Else
		lds_letter.DataObject = ls_letter_dw 
	End If
	*/
	//---------------------------- APPEON END ----------------------------	
	li_retval =lds_letter.of_SetTransObject( SQLCA )
	//MessageBox("Letter dw","")
	IF li_retval =-1 THEN
		MessageBox("Letter dw","Invalid Letter Datawindow name  -" + ls_letter_dw )
		Return -1
	END IF
ELSE  //for all valid standard letters
	String ls_group_syntax
	String ls_grey
	String ls_white
	String ls_presentation_str
	String ls_dwsyntax_str
	String Errors
	ls_group_syntax = ""
	ls_grey = String(rgb(192,192,192))
	ls_white = String(rgb(255,255,255))
	ls_presentation_str = "style( type=Group) Column(Border=0) Datawindow(Color=" + ls_white + " )" + "Text(Border=6 Background.Color=" + ls_grey + ")"
	
	as_sql = as_sql + " AND ( doc_id IN ("
	
	li_doc_id_cnt = UpperBound( as_doc_id[] )

	FOR d = 1 TO li_doc_id_cnt
		as_sql = as_sql + "'" +  as_doc_id[d] + "',"
	END FOR
	
	as_sql = MidA( as_sql, 1, LenA( as_sql )-1 ) + "))"
	
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(as_sql, ls_presentation_str, ERRORS)
	
	//ClipBoard( as_sql )

	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	END IF

	lds_letter.Create( ls_dwsyntax_str, ERRORS)
	
	IF LenA(ERRORS) > 0 THEN
		MessageBox("Caution", &
		"Create cause these errors: " + ERRORS)
		RETURN -1
	END IF
	
	lds_letter.SetTransObject( SQLCA )
	lds_letter.Retrieve( )
	li_ltr_rec_cnt = lds_letter.rowcount()  //(Appeon)Stephen 08.14.2014 - Issue printing 70+ letters
	lb_retrieved = True  //Ken.Guo 10/31/2007
END IF


//messagebox("docid",docid)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10/31/2007 By: Ken.Guo
//$<reason> For Web Performance
//li_ltr_rec_cnt = lds_letter.Retrieve( as_doc_id )
//n_cst_arr_to_db
string ls_client_id
n_cst_array_db ln_cst_array_db_case
If lb_retrieved = False Then
	/* Evan 02.06.2009
	If Upper(appeongetclienttype()) = 'WEB' Then
		ln_cst_array_db_case = Create n_cst_array_db
		ln_cst_array_db_case.of_array_to_db( as_doc_id, ls_client_id)
		li_ltr_rec_cnt = lds_letter.Retrieve( ls_client_id )
		ln_cst_array_db_case.of_delete_temp_data(ls_client_id)
		Destroy ln_cst_array_db_case
	Else
		li_ltr_rec_cnt = lds_letter.Retrieve( as_doc_id )
	End If
	*/
	li_ltr_rec_cnt = lds_letter.Retrieve( as_doc_id, gs_user_id ) //Evan 02.06.2009   //Start Code Change ----02.02.2017 #V153 maha - user fields
End If
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Stephen 02.03.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
if lower(lds_letter.describe("#" +string(li_col)+".name")) = "prac_id"  then
	for li_col = 1 to lds_letter.rowcount()
		al_pracids[li_col] = lds_letter.getitemnumber(li_col, "prac_id")
	next
else
	al_pracids = as_pracids
end if
//---------End Added ------------------------------------------------------

//messagebox("li_ltr_rec_cnt",li_ltr_rec_cnt)
 //Start Code Change ----04.04.2017 #V153 maha - separate error for failed query
IF li_ltr_rec_cnt < 0 THEN
	MessageBox(" Retrieval Error", "Letter query failed. Contect ISG support." )
	RETURN -1
elseif li_ltr_rec_cnt = 0 THEN
	MessageBox(" Retrieval Error", "Letter query did not return any results. Check for missing data." )		
	RETURN -1
ELSE
//End Code Change ----04.04.2017
	//************************************************************************
	//EXPORT CODE
	//\/maha 110402 check and create export file for merge document 
	if gi_export_on = 1 then 
		if as_letter_type = "P" then //for correspondence letter get the export info
			//select use_export, export_id into :li_export_on,:li_export_id from sys_letters where letter_name = :as_letter_name;		
			select use_export, export_id,response_required into :li_export_on,:li_export_id, :li_corr_response from sys_letters where letter_name = :as_letter_name;	
			if li_export_on = 1 then
				if li_export_id > 0 then
					//---------Begin Modified by (Appeon)Stephen 02.03.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
					//res = of_run_export(as_pracids[],li_export_id,ls_open_merge) //the ls_open_merge is returned by the function					
					res = of_run_export(al_pracids[],li_export_id,ls_open_merge)
					lgs_fax.ss_index = "1"  //Start Code Change ----02.10.2015 #V14.2 maha
					//---------End Modfiied ------------------------------------------------------
					
					if res < 1 then 
						messagebox("Export Error","Failed to create file from export.")
						li_export_on = 0
					else
						//Start Code Change ----07.30.2009 #V92 maha - reset the open_merge path because need it to copy the export file for labels merge file
						ls_export_merge = ls_open_merge
						ls_open_merge = of_letter_paths("D") //reset the open path
						//select export_name into :ls_exportname from export_header where export_id = :li_export_id;
						//Start Code Change ----07.30.2009 #V92 maha
						//---------Begin Added by (Appeon)Stephen 02.03.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
						for li_col = 1 to integer(lds_letter.object.datawindow.column.count)
							if lower(lds_letter.describe("#" +string(li_col)+".name")) = "prac_id" or lower(lds_letter.describe("#" +string(li_col)+".name")) = "v_full_name_prac_id" then
								lds_letter.setsort("prac_id")
								lds_letter.sort()
								exit
							end if							
						next
						//---------End Added ------------------------------------------------------
					end if
				end if
			end if
		else
			IF as_letter_name = "expiring_appointment"  THEN
				SELECT reapp_export, reapp_export_id, facility_name
				INTO:li_export_on,
					 :li_export_id ,
					 :ls_parent
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF
			elseif as_letter_name = "expiring_provisional" then
				SELECT prov_export, prov_export_id, facility_name
				INTO:li_export_on,
					 :li_export_id,
					  :ls_parent
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF	
			elseif as_letter_name = "expiring_allied_health"  then
				SELECT reappah_export, reappah_export_id, facility_name
				INTO:li_export_on,
					 :li_export_id,
					  :ls_parent
				FROM facility
				WHERE facility_id = :ai_facility;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
					Return -1
				END IF
			elseif al_parent > 0 and ai_screen > 1 then  //Start Code Change ----03.07.2012 #V12 maha - added to populate parent_facility_name field
				SELECT facility_name
				INTO  :ls_parent
				FROM facility
				WHERE facility_id = :al_parent;
			END IF
			if li_export_on = 1 then
				if li_export_id > 0 then
					//messagebox("ls_open_merge",ls_open_merge)
					//---------Begin Modified by (Appeon)Stephen 02.03.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
					//res = of_run_export(as_pracids[],li_export_id,ls_open_merge) //the ls_open_merge is returned by the function					
					res = of_run_export(al_pracids[],li_export_id,ls_open_merge)
					lgs_fax.ss_index = "1"  //Start Code Change ----02.10.2015 #V14.2 maha
					//---------End Modfiied ------------------------------------------------------
					
					if res < 1 then 
						messagebox("Export Error","Failed to create file from export.")
						li_export_on = 0
					else
						//Start Code Change ----07.30.2009 #V92 maha - reset the open_merge path because need it to copy the export file for labels merge file
						ls_export_merge = ls_open_merge
						ls_open_merge = of_letter_paths("D") //reset the open path
						lgs_fax.ss_merge_file_path = ls_export_merge  //Start Code Change ----01.05.2010 #V10 maha - get path value for mail labels
						//select export_name into :ls_exportname from export_header where export_id = :li_export_id; //no longer used
						//End Code Change---07.30.2009
						//---------Begin Added by (Appeon)Stephen 02.03.2015 for Right Letter But Wrong Data Sent to Multiple Providers--------
						for li_col = 1 to integer(lds_letter.object.datawindow.column.count)
							if lower(lds_letter.describe("#" +string(li_col)+".name")) = "prac_id" or lower(lds_letter.describe("#" +string(li_col)+".name")) = "v_full_name_prac_id" then
								lds_letter.setsort("prac_id")
								lds_letter.sort()
								exit
							end if							
						next
						//---------End Added ------------------------------------------------------
					end if
				end if
			end if	
		end if
	end if
	//\maha	
	if pos(lower(as_letter_name),  "expiring") > 0 or (ai_screen > 1 and al_parent > 0) then  //Start Code Change ----03.07.2012 #V12 maha - added to populate parent_facility_name field
		for i = 1 to li_ltr_rec_cnt 
			lds_letter.setitem( i, "cparent_facility_name", ls_parent) 
		next
	end if
END IF

//If its a list letter figure out the different places it has to go
IF Upper(as_letter_type) = "L" THEN
	ls_style = "list"
	FOR i = 1 TO li_rc //maha 041008 - this block of code does nothing because li_rc has no value (0)
		ls_val = lds_letter.GetItemString(  i, "entity_name" )
		lb_found = False
		FOR s = 1 TO li_ent_cnt
			IF ls_val = ls_entity[ s ] THEN
				lb_found = True
				Exit
			END IF
		END FOR
		IF NOT lb_found THEN
			li_ent_cnt++
			li_total_letters++
			ls_entity[ li_ent_cnt ] = ls_val
		END IF
 	END FOR
ELSE
	li_total_letters = 1
	ls_style = "ind"
END IF


li_ltr_cnt = 0 //w_ai_print_letters.dw_letters.GetItemNumber( w_ai_print_letters.dw_letters.GetRow(), "ctotal_letters"  )

//loop through for each letter that needs to be printed



FOR i = 1 TO li_total_letters
//		IF w_ai_print_letters.dw_letters.GetItemnumber( 1, "num_printed" ) > 0  THEN  //maha added 051501
//		continue
//	END IF
	//for each letter path that is different a different letter will need to be printed
		// if its a list letter then filter out by each entity
		IF Upper(as_letter_type) = "L" THEN
			//lds_letter.SetFilter( " Upper(entity_name) = Upper('" + ls_entity[ i ] + "') AND verifying_facility = " + String( li_verif_facility_ids_all[l] ) )
			lds_letter.SetFilter( " Upper(entity_name) = Upper('" + ls_entity[ i ] + "')" )
			lds_letter.Filter()
		END IF
		
		li_rc = lds_letter.RowCount( )
			
		IF li_rc < 1 THEN
				RETURN -1 //CONTINUE
				messagebox("","no li_rc")
		END IF
		
	//	IF lds_letter.Describe( "doc_id" ) <> "!" THEN
		//lds_letter.SetSort( "doc_id" )
		//lds_letter.Sort( )
	//	END IF
		//if gi_citrix = 1 then //if citrix save to user folder

			//if running from an export set the merge variable to the export name 
	//Start Code Change ----07.30.2009 #V92 maha - moved the saveas code inside if and added copy file for the labels to print
		if li_export_on = 1 then //if export successful
				//08.28.2007 By Jervis return by of_run_export function
				//ls_open_merge =  ls_open_merge + ls_exportname + ".txt"
			//messagebox("export file",ls_open_merge)
			res = filecopy(ls_export_merge, ls_open_merge + "ind_generic_corrospondence.txt",false)
			ls_open_merge = ls_export_merge
		else
			//
			lds_letter.SaveAs( ls_open_merge + is_letter_name + ".txt", Text!, True )		
			lds_letter.SaveAs( ls_open_merge + "mailing_labels_ver_letter.txt", Text!, True )		
			lds_letter.SaveAs( ls_open_merge + "ind_generic_corrospondence.txt", Text!, True )
			//
			ls_open_merge =  ls_open_merge + is_letter_name + ".txt"
		end if


	 	//word path code removed 02 2405 maha 4.517 readded 071805 to allow as option
		if li_set6 = 5 then
			ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-25
			//$<modify> 01.17.2006 By: Cao YongWang
			//$<reason> There is no need to have the Web application read local INI files. The Web application
			//$<reason> reads INI files from Web server.
			//$<modification> Write the following script to make sure that when IntelliCred is running on the Web, it
			//$<modification> does not read local INI files.
			//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
			//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
			//	Return -1
			//END IF
			If appeongetclienttype() = 'PB' Then
				IF NOT FileExists(gs_IniFilePathName) THEN
   					MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
					Return -1
				END IF
			End If
			//---------------------------- APPEON END ----------------------------

	
			//get the verification letter path
			//ls_letter_path  = ls_letter_paths_all[ l ]
	
			//check to see if ms word path set in ini file is correct
			IF NOT FileExists( ls_word_path ) THEN 
  				MessageBox("Print Error", "Invalid MS Word for Windows path set in INI file: " + ls_word_path )
				Return -1
			END IF
		end if

		//s:\letters\education.doc"
		li_len = LenA( as_doc_name )

		//jad 4/25/02       why?
		FOR b = li_len TO 1 STEP -1	
			ls_letter = MidA( as_doc_name, b, 1 )
			IF ls_letter = "\" THEN
				EXIT
			END IF
		END FOR
		//break as_doc_name into path and letter
		ls_path = MidA( as_doc_name, 1, b )
		//messagebox("", ls_path ) //ls_path is the location where the letter if found before copying
		ls_file_name = MidA( as_doc_name, b+1, 100 )  //jad 4/25/02
		//ls_file_name = Mid( as_doc_name, 
		//messagebox("", ls_file_name )

		//copy down to local drive from network?	//jad 4/25/02	
		
		
		IF li_set6 = 1 THEN //copy letter
			if upper(ls_path) = upper(ls_run_path) then //maha 050602 trap against copying to same location
  				messagebox("Path error","Your letter path is set to " + ls_run_path + " ~rand the Copy Letters setting is turned on. ~rGo to System->Utilities->Application settings and set Copy Letters to No to run letters normally.")
				return -1
			end if
			//check to make sure letter and path exists
			IF NOT FileExists(as_doc_name ) THEN
				MessageBox("Print Error", "Cannot find word letter " + ls_file_name + " in directory: " + ls_path )
				Return -1
			else
				ls_from  = as_doc_name
			END IF
			
			ls_to = ls_run_path + ls_file_name
				//copy letter  then run
				if fileexists(ls_to) then
					if FileDelete( ls_to) = false then //maha040705
						//messagebox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in " + gs_dir_path + "IntelliCred\Letters\Standard prior to copy.~r  Check letter properties to see if letter is Read Only.")
						messagebox("Copying letter from server","Unable to delete existing letter " + ls_to + " prior to copy.~r  Check letter properties to see if letter is Read Only.")  //Start Code Change ----02.28.2008 #V8 maha - corrected message to correct path
					end if
				end if
				//messagebox("","copy " + as_doc_name + " C:\IntelliCred\Letters\Standard")
				//Run( ls_path + "copyltr.bat " + as_doc_name, Minimized! )
				CopyFileA( ls_from, ls_to, true )
				
				ls_letter_path = ls_to //"c:\intellicred\letters\standard\" + ls_file_name
				DO WHILE NOT FileExists( ls_to )
					ll_loop_count++
					IF ll_loop_count = 1000000 THEN
						MessageBox("Timeout", "Timed out trying to copy Word file.  ~rfrom: " + ls_from + "~r to: " + ls_to)
						EXIT
					END IF
				LOOP
		else //if not copied use as_doc_name
			ls_letter_path = as_doc_name
		END IF
		
		//check to make sure letter and path exists
		IF NOT FileExists(ls_letter_path ) THEN
			MessageBox("Print Error", "Invalid letter document path: " + ls_letter_path )
			Return -1
		END IF

		//as_affil_stat = "S" all the time right now because I decided there would be one letter for initial and reapp
//		as_affil_stat = "S"
//		IF as_affil_stat = "S" THEN
//			IF ab_print_preview THEN
//				ls_doc_name = as_doc_name + " /mpreview"
//			ELSE
//				ls_doc_name = as_doc_name //+ " /mmergeclose"					
//			END IF

//			Run( ls_word_path + " " + ls_doc_name, Maximized! )				
//		END IF
	
	
//@@@@@@@@  OPEN THE LETTER  @@@@@@@@@@@@@
		if li_set6 = 5 then //maha 071805 to allow old method cannot be used with copy letters
			Run( ls_word_path + " " + ls_letter_path , Maximized!)//" /mpreview"
		else
			//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
			if gi_citrix = 1 then
				ls_old_docpath = gnv_app.gnvlo_msword.is_directory
				gnv_app.gnvlo_msword.is_directory = gs_temp_path +"fax\"				
				if NOT DirectoryExists(gnv_app.gnvlo_msword.is_directory) then CreateDirectory(gnv_app.gnvlo_msword.is_directory)
			end if
			//---------End Added ------------------------------------------------------
			
			// mskinner 04 Oct 2005 - begin
			//Start Code Change ---- 03.27.2006 #345 maha added trap return
			if gnv_app.gnvlo_msword.of_open_word_document( ls_letter_path, ls_open_merge, "Verification") = -1 then
				if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = ls_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing
				return -1
			end if
			if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = ls_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing
			//End Code Change---03.27.2006
			//of_open_letter(ls_letter_path,ls_open_merge,"Verification")
			// mskinner 04 Oct 2005 - end 
		end if
	
	
		//jad  03/08/04 fax stuff


	//	ls_letter_path = gs_dir_path + "intellicred\letters\standard\"
//		ls_letter_path = ls_run_path
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 07.04.2006 By: LeiWei
		//$<reason> Doc save to db
		/*
		IF Pos( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN //changed 020201 maha
			lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_prac_corro_letters.doc"// + "/mpreview"
		ELSE			
			lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_ver_letter.doc"// + "/mpreview"
		END IF
		*/
		If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
	   Upper( appeongetclienttype() ) = 'WEB' Then
			IF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN //changed 020201 maha
				lgs_fax.ss_mail_label_doc = "mailing_labels_prac_corro_letters.doc"// + "/mpreview"
			ELSE			
				lgs_fax.ss_mail_label_doc = "mailing_labels_ver_letter.doc"// + "/mpreview"
			END IF
		else
			IF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN //changed 020201 maha
				lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_prac_corro_letters.doc"// + "/mpreview"
			ELSE			
				lgs_fax.ss_mail_label_doc = ls_run_path + "mailing_labels_ver_letter.doc"// + "/mpreview"
			END IF
		end if
		//---------------------------- APPEON END ----------------------------

		lgs_fax.ss_message = "If the " + upper(is_letter_name) + " letter generated properly select process options below and click Continue. "
		lgs_fax.ss_letter_name =  ls_style + "_" + is_letter_name + "_letter" 
		lgs_fax.ss_letter_document_name = ls_doc_name// + "/mpreview"
		lgs_fax.ss_process_type =  is_process_type   //Start Code Change ----07.09.2013 #V14 maha
		lgs_fax.sdw_letter = lds_letter
		if li_export_on=  1 then lgs_fax.ss_process_type = "Export"   //Start Code Change ----05.06.2015 #V15 maha  - part of trap for unmatched provider data in faxing

		IF is_letter_name = "expiring_appointment"  OR is_letter_name = "expiring_provisional" OR is_letter_name = "expiring_allied_health" THEN
			lgs_fax.ss_letter_type = "ExpAppt"
		elseif as_letter_type = "P" then //maha 062705
			lgs_fax.ss_letter_type = "Corro"
		ELSEIF PosA( Upper(ls_letter_dw), "EXPIRING" ) > 0 THEN
			lgs_fax.ss_letter_type = "ExpLtr"								
		ELSE
			lgs_fax.ss_letter_type = "Verif"			
		END IF		
		//messagebox("lettertype",lgs_fax.ss_letter_type)
		//end here	

		
		OpenWithParm( w_ai_print_msg_box, lgs_fax )		
		gs_fax_error_records lst_fax_error_records
		lst_fax_error_records = Message.PowerObjectParm
		IF lst_fax_error_records.il_error_rec_num[ 1 ] = -2 THEN		
			Return -1
		END IF		
		
		li_error_cnt = UpperBound( lst_fax_error_records.il_error_rec_num )
		
		//update the action item detail screen with date/time user stamps
		FOR s = 1 TO li_rc
			
			lb_error_rec = False
			FOR e = 1 TO li_error_cnt
				IF lst_fax_error_records.il_error_rec_num[e] = s THEN
					lb_error_rec = True
					Exit
				END IF
			END FOR
			IF lb_error_rec THEN
				CONTINUE
			END IF
			
			ls_doc_id = lds_letter.GetItemString( s, "doc_id" )
			li_found = ids_ai_detail.Find( "doc_id = '" +  ls_doc_id + "'" , 1, /*1000*/9999999 ) //Modify Michael 02.01.2012 problem with printing letters
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-08 By: Liu Hongxin
			//$<reason> Fix bug: if reprint, the print return 0.
			IF li_found < 1 THEN Continue
			//---------------------------- APPEON END ----------------------------
			li_last_num_sent = ids_ai_detail.GetItemNumber( li_found, "number_sent" )
			IF IsNull(li_last_num_sent) THEN
				li_last_num_sent = 0
			END IF
			li_last_num_sent++
			ids_ai_detail.SetItem( li_found, "number_sent", li_last_num_sent )
			ids_ai_detail.SetItem( li_found, "print_flag", 0 )			
			IF IsNull( ids_ai_detail.GetItemDateTime( li_found, "first_sent" ) ) THEN
				ids_ai_detail.SetItem( li_found, "first_sent", DateTime(Today(), Now()) )
			END IF
			//Start Code Change ----08.03.2011 #V11 maha - 
			ids_ai_detail.SetItem( li_found, "number_sent", li_last_num_sent )
			ids_ai_detail.SetItem( li_found, 'mod_user', gs_user_id)
			//End Code Change ----08.03.2011 #V11 
			
			//IF lst_fax_error_records.il_error_rec_num[ 1 ] = -5 OR lst_fax_error_records.il_error_rec_num[ 1 ] > 0 THEN		
				ls_notes = 	ids_ai_detail.GetItemString( li_found, "notes" ) 
				IF IsNull( ls_notes ) OR ls_notes = "" THEN
					ls_notes = ""
				END IF
				//messagebox("","in the adding notes fax if statement" )
				//ids_ai_detail.SetItem( li_found, "notes", ls_notes + " (Faxed-" + String(Today()) +")" )
			//END IF				
			ids_ai_detail.SetItem( li_found, "last_sent", DateTime(Today(), Now()) )
			//Start Code Change ----04.10.2008 #V8 maha
			if as_letter_type = "P" then // Correspondence (Approval) letters only
				if li_corr_response = 0 then //if needs response is set to No complete the verification
					SELECT code_lookup.lookup_code  	INTO :ll_ver_response	FROM code_lookup WHERE ( code_lookup.lookup_name = 'Credentials Verification Response' ) AND   ( code_lookup.code = 'N/A'  )   ;
					ids_ai_detail.SetItem(  li_found, "response_code", ll_ver_response )
					ids_ai_detail.SetItem(  li_found, "date_recieved", DateTime( Today(),Now()) )
					ids_ai_detail.SetItem(  li_found, "user_name", gs_user_id )
				end if
			end if
		//End Code Change---04.10.2008
		END FOR
						
		IF Upper(as_letter_type) = "L" THEN 
			li_ltr_cnt ++
		ELSE
			li_ltr_cnt = 1 //li_ltr_cnt = li_ltr_rec_cnt
		END IF
		
END FOR
	

//if all the letters were printed successfully then put a check next to the letter
IF li_ltr_cnt = li_total_letters THEN 
	w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "num_printed", li_rc)	//maha 051501	
	w_ai_print_letters.dw_letters.SetItem( w_ai_print_letters.dw_letters.GetRow(), "print_status", 1 )
END IF 

//update the action item detail view by updating then re-retrieving data
IF ids_ai_detail.Update() <> 1 THEN
	MessageBox("Update Failed", "Error while updating " + adw_detail.DataObject )
ELSE
	COMMIT USING SQLCA;
	adw_detail.Event pfc_Retrieve()
END IF


Destroy ids_ai_detail
Destroy lds_letter
Destroy ids_ai_detail

Return 0
end function

public function integer of_intellibatch_update ();//Start Code Change ----06.03.2013 #V14 maha - added

long b, bc
long e, ec
long u, uc, w
long ll_batches[]
long ll_was[]
long ll_now[]
long ll_id
long ll_prac
long ll_new
long ll_item
string ls_filter
string ls_sql
String ls_presentation_str
String ls_dwsyntax_str
string errors
n_ds lds_batch
n_ds lds_exist
n_ds lds_update
n_ds lds_new


lds_batch = create n_ds
lds_batch.dataobject = "d_batch_list_auto_update"
lds_batch.settransobject(sqlca)

lds_exist = create n_ds
lds_exist.dataobject = "d_batch_items_auto"
lds_exist.settransobject(sqlca)

lds_update = create n_ds

lds_new = create n_ds
lds_new.dataobject = "d_batch_items_auto"
lds_new.settransobject(sqlca)

bc = lds_batch.retrieve()

if bc = 0 then 
	destroy lds_batch
	destroy lds_exist
	destroy lds_update
	destroy lds_new
	return 1
end if

//get all ids
for b = 1 to bc
	ll_batches[b] = lds_batch.getitemnumber(b, "batch_id")
next
//get all pracs
lds_exist.retrieve(ll_batches[])


for b = 1 to bc
	ll_id = lds_batch.getitemnumber(b, "batch_id")
	ls_sql = lds_batch.getitemstring(b, "create_sql")
	lds_new.reset()
	
	//Start Code Change ----11.20.2014 #V14.2 maha 
	if isnull(ls_sql)  then 
		of_log_batch_change(ec, -1, ll_id, "Auto Update") 
		continue
	end if	
	//Start Code Change ----11.20.2014 #V14.2 maha - added lower
	if lower(mid(ls_sql, 1 ,6)) <> "select" then   
		of_log_batch_change(ec, -1, ll_id, "Auto Update") 
		continue
	end if
	
	if pos(lower(ls_sql), "prac_id", 1) = 0 or pos(lower(ls_sql), "prac_id", 1) > 40 then
		of_log_batch_change(ec, -1, ll_id, "Auto Update") ////Start Code Change ----11.20.2014 #V14.2 maha - log an error
		continue
	end if
	//End Code Change ----11.20.2014
	
	ls_filter = "batch_id = " + string(ll_id)
	lds_exist.setfilter(ls_filter)
	lds_exist.filter()
	ec = lds_exist.rowcount()
	
	ll_was[b] = ec
	
	ls_presentation_str = "style(type=grid)"		

	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN
//		MessageBox("Caution on export field " + ls_sql, &
//		"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
	//	MessageBox("ls_select_table",ls_select_table)
		of_log_batch_change(ec, -1, ll_id, "Auto Update") ////Start Code Change ----11.20.2014 #V14.2 maha - log an error
		continue
	END IF
	
	w = lds_update.Create( ls_dwsyntax_str, ERRORS)
	if w < 1 then
		of_log_batch_change(ec, -1, ll_id, "Auto Update") ////Start Code Change ----11.20.2014 #V14.2 maha - log an error
		//messagebox("error on create",errors)
		continue
	end if
	lds_update.SetTransObject( SQLCA )
	uc = lds_update.retrieve()

	ll_now[b] = uc
	
	//messagebox("", "Exist: " + string(ec) + "  Update: " + string(uc) )
	
	for e = ec to 1 step -1
		lds_exist.deleterow(e)
	next
	
	if uc > 0 then
		for u = 1 to uc
			ll_prac = lds_update.getitemnumber(u,1)				
			ll_new = lds_new.insertrow(0)
			lds_new.setitem(ll_new, "prac_id", ll_prac)
			lds_new.setitem(ll_new, "item_id", u)
			lds_new.setitem(ll_new, "batch_id", ll_id )
		next
	end if
	
	lds_exist.update()
	lds_new.update()
	
	//create log entry onlt if the counts are different
	if ec <> uc then
		of_log_batch_change(ec, uc, ll_id, "Auto Update")
	end if

next

destroy lds_batch
destroy lds_exist
destroy lds_update
destroy lds_new

return 1
end function

public function integer of_pendingchange ();//====================================================================
//$<Function>: of_pendingChange
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.08.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_pending_change ln_pending
ln_pending = create n_cst_pending_change
ln_pending.of_run( )
destroy ln_pending

return 1
end function

public function integer of_appl_tracking_running_days (); //Start Code Change ----10.07.2015 #V15 maha - designed to update running days on tracking records that are not complete
n_ds dw_tracking
long r
long rc
integer li_final
integer s
integer cnt
long li_days
date ld_first
date ld_final 
string ls_sql
string ls_where

dw_tracking  = create n_ds

dw_tracking.dataobject = "d_appl_tracking_day_total_update"
dw_tracking.settransobject(sqlca) 

ls_sql = dw_tracking.getsqlselect( )

li_final = integer(gnv_data.of_getitem("app_steps","last step",""))

Choose case li_final
	case 2
		ls_where = " And step_2 is null"
	case 3
		ls_where = " And step_3 is null"
	case 4
		ls_where = " And step_4 is null"
	case 5
		ls_where = " And step_5 is null"
	case 6
		ls_where = " And step_6 is null"
	case 7
		ls_where = " And step_7 is null"
	case 8
		ls_where = " And step_8 is null"
	case 9
		ls_where = " And step_9 is null"
	case 10
		ls_where = " And step_10 is null"
end choose

ls_sql+= ls_where

dw_tracking.setsqlselect( ls_sql)
dw_tracking.settransobject(sqlca) 

if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating Application Tracking running dates: Getting Tracking Records"  //Start Code Change ----10.20.2016 #V152 maha

rc = dw_tracking.retrieve()

//messagebox(string(rc), ls_sql)

if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating Application Tracking running dates: Setting Tracking Records"  //Start Code Change ----10.20.2016 #V152 maha

if rc < 1 then return 0


//for each tracking record
for r = 1 to rc
	setnull(ld_first)
	setnull(ld_final)
	//get the first completed step date
	for s = 1 to li_final   //check each step for a date
		choose case s
			case 1
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_1"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_1"))
					exit
				end if
			case 2
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_2"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_2"))
					exit
				end if
			case 3
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_3"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_3"))
					exit
				end if
			case 4
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_4"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_4"))
					exit
				end if
			case 5
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_5"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_5"))
					exit
				end if
			case 6
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_6"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_6"))
					exit
				end if
			case 7
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_7"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_7"))
					exit
				end if
			case 8
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_8"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_8"))
					exit
				end if
			case 9
				if not isnull (date(dw_tracking.getitemdatetime(r,"step_9"))) then
					ld_first = date(dw_tracking.getitemdatetime(r,"step_9"))
					exit
				end if
		end choose
	next
	//debugbreak()
	//get last date
	choose case li_final
		case 1
			ld_final = date(dw_tracking.getitemdatetime(r,"step_1"))
		case 2
			ld_final = date(dw_tracking.getitemdatetime(r,"step_2"))
		case 3
			ld_final = date(dw_tracking.getitemdatetime(r,"step_3"))
		case 4
			ld_final = date(dw_tracking.getitemdatetime(r,"step_4"))
		case 5
			ld_final = date(dw_tracking.getitemdatetime(r,"step_5"))
		case 6
			ld_final = date(dw_tracking.getitemdatetime(r,"step_6"))
		case 7
			ld_final = date(dw_tracking.getitemdatetime(r,"step_7"))
		case 8
			ld_final = date(dw_tracking.getitemdatetime(r,"step_8"))
		case 9
			ld_final = date(dw_tracking.getitemdatetime(r,"step_9"))
		case 10
			ld_final = date(dw_tracking.getitemdatetime(r,"step_10"))
	end choose


	//if no first date then set null
	if isnull(ld_first) then 
		setnull(li_days)
	else
		if isnull(ld_final) then ld_final = today()
		li_days = daysafter(ld_first,ld_final)
	end if
	
	dw_tracking.setitem(r,"days_total", li_days)

next

if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating Application Tracking running dates: Updating Tracking Records"  //Start Code Change ----10.20.2016 #V152 maha

dw_tracking.update()
//messagebox("","done")

destroy dw_tracking

return 1
end function

public function integer of_expiring_credentials_procd ();//Start Code Change ----04.04.2016 #V15 maha - function calling stored prodedure

//if the stored procedure does not exist, return
return -2


//rest of function
end function

public function integer of_expiring_credentials_org ();//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.23.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

n_ds lds_exp_cred
n_ds lds_exp_copy
n_ds lds_last_verif_seq_no
n_ds lds_exp_cred_incomp  //maha 07.20.2015
datastore lds_new_verif//evan 05.16.2011

Long ll_ver_method_ltr 
Long ll_prac_id[]
Long ll_rec_id[]
long li_facility_id[]
Long ll_seq_row_cnt
long ll_exp_method  //maha 070909
long ll_psv_method //maha 070909
Long ll_seq_no
long ll_ref_row_num[]  //evan 05.16.2011
Long ll_rowcount //(Appeon)Harry 06.29.2015
long li_row_cnt
long ll_incomp_cnt //maha 07.20.2015
long r   //maha 07.20.2015
long ll_find   //maha 07.20.2015
long i
long li_nr
Integer nullint
integer cnt = 0
integer Bcnt = 0
integer li_option //maha 070909
integer li_exp_flag = 1  //maha 070909
integer li_priority //maha 09.03.09
DateTime nulldate
String ls_doc_id
string ls_fails = ""
string ls_user //maha 09.03.09
string ls_psv_user //maha 09.03.09
string ls_new_doc_id[] //evan 05.16.2011
string ls_err
string ls_find  //maha 07.20.2015


SetNull( nullint )
SetNull( nulldate )
lds_exp_cred = CREATE n_ds
lds_exp_cred.DataObject = "d_exp_credentials"
lds_exp_cred.of_SetTransObject( SQLCA )
li_row_cnt = lds_exp_cred.Retrieve(  ) 
//<add> 06/27/2007 by: Andy set sort first
lds_exp_cred.setsort("rec_id A, prac_id A, facility_id A")
lds_exp_cred.sort()
//end of add


 //Start Code Change ----07.20.2015 #V15 maha
lds_exp_cred_incomp = CREATE n_ds
lds_exp_cred_incomp.DataObject = "d_exp_credentials_incomp"
lds_exp_cred_incomp.of_SetTransObject( SQLCA )
ll_incomp_cnt = lds_exp_cred_incomp.Retrieve(  ) 
lds_exp_cred_incomp.setsort("rec_id A, prac_id A, facility_id A")
lds_exp_cred_incomp.sort()
 //End Code Change ----07.20.2015



lds_exp_copy = CREATE n_ds
lds_exp_copy.DataObject = "d_exp_credentials"
lds_exp_copy.of_SetTransObject( SQLCA )

lds_last_verif_seq_no = CREATE n_ds
//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt"
//this gets the max seq_no for all the items that will be retrieved in "d_exp_credentials"
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt_credentials"
//end of modify
lds_last_verif_seq_no.of_SetTransObject( SQLCA )

//comment 07/26/2007 by: Andy
//Reason:optimize
//the data source of d_last_verif_seq_no_forpt_credentials is not need arguments.
/*
FOR i = 1 TO li_row_cnt
	ll_rec_id[i] = lds_exp_cred.GetItemNumber( i, "rec_id" )
	ll_prac_id[i] = lds_exp_cred.GetItemNumber( i, "prac_id" )
	li_facility_id[i] = lds_exp_cred.GetItemNumber( i, "facility_id" )
next

if UpperBound(ll_rec_id) = 0 then
	ll_rec_id[1] = 0
end if

if UpperBound(ll_prac_id) = 0 then
	ll_prac_id[1] = 0
end if

if UpperBound(li_facility_id) = 0 then
	li_facility_id[1] = 0
end if
*/

//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.Retrieve( ll_rec_id, ll_prac_id, li_facility_id )
lds_last_verif_seq_no.Retrieve( )
//end of modify


if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 150



ll_ver_method_ltr = Long(gnv_data.of_getitem("code_lookup","lookup_code",&
"upper(lookup_name) = upper('verification method') AND upper(code) = upper('exp cred ltr')"))

//gnv_appeondb.of_startqueue( ) //evan 05.16.2011

//<add> 06/27/2007 by: Andy
Long    ll_rec_id_first      = -1
Long    ll_prac_id_first     = -1
Integer li_facility_id_first = -1
//end of add

inv_message.of_set_proc_cnt(li_row_cnt) //Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
ll_rowcount =  lds_last_verif_seq_no.rowcount( ) //(Appeon)Harry 06.29.2015
FOR i = 1 TO li_row_cnt
	//lds_exp_copy.reset() //evan 05.16.2011
	
	//<add> 07/26/2007 by: Andy
	ll_rec_id[i] = lds_exp_cred.GetItemNumber( i, "rec_id" )
	ll_prac_id[i] = lds_exp_cred.GetItemNumber( i, "prac_id" )
	li_facility_id[i] = lds_exp_cred.GetItemNumber( i, "facility_id" )
	//end of add
	
	
	//<add> 06/27/2007 by: Andy fixed a bug. 
	//attention:set sort first
	if ll_rec_id_first = ll_rec_id[i] and &
		ll_prac_id_first = ll_prac_id[i] and li_facility_id_first = li_facility_id[i] then
		//Start Code Change ---06.16.2008 #V81 maha - changed so that for duplicates only one exp cred verification will be created
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
		continue		
		//ll_seq_no++
	else
		
	 //Start Code Change ----07.20.2015 #V15 maha - if there is another existing verification that is incomplete, do not create another exp cred.
	ls_find =  'rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i])
	ll_find = lds_exp_cred_incomp.find(ls_find, 1, ll_incomp_cnt )

	
	if ll_find > 0 then
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
		continue
	end if
	 //End Code Change ----07.20.2015	
		
	//end of add
		//---------Begin Modified by (Appeon)Harry 06.29.2015--------
		/*
		//find out the last seq no used for this ver record
		lds_last_verif_seq_no.setfilter('rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i]))//modify by evan 05.10.2011
		lds_last_verif_seq_no.filter( )
		ll_seq_row_cnt = lds_last_verif_seq_no.rowcount( )
		*/
		ll_seq_row_cnt = lds_last_verif_seq_no.find( 'rec_id = ' + string(ll_rec_id[i]) + ' and prac_id = ' + string(ll_prac_id[i]) + ' and facility_id = ' + string(li_facility_id[i]), 1, ll_rowcount)
		//---------End Modfiied --------------------------------
		IF  ll_seq_row_cnt < 1 THEN
			//gnv_appeondb.of_commitqueue( ) //evan 05.16.2011
 			//MessageBox("Error", "Error getting next sequence number." )
			//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Error", "Error getting next sequence number.",true)
			Return -1
		ELSE
			//ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( ll_seq_row_cnt, "last_seq_no" ) + 1 //(Appeon)Harry 06.29.2015
		END IF
		//<add> 06/27/2007 by: Andy 
		ll_rec_id_first = ll_rec_id[i]
		ll_prac_id_first = ll_prac_id[i]
		li_facility_id_first = li_facility_id[i]
	end if
	//end of add
	//Start Code Change ----07.09.2009 #V92 maha - added functionality to allow creation as PSV or duplicate EXP and PSV
	//Start Code Change ----08.31.2009 #V92 maha - add additional trap for historical verifications
	if lds_exp_cred.getitemnumber(i,"verif_info_data_status") = 2 or lds_exp_cred.getitemnumber(i,"verif_info_data_status") = 0 then //Start Code Change ----03.29.2010 #V10 maha - added trap for inactive
		lds_exp_cred.SetItem( i, "exp_credential_flag", 2)  //set the flag don't do anything else
	else
		li_option = lds_exp_cred.getitemnumber(i,"exp_options")
		ll_psv_method = lds_exp_cred.getitemnumber(i,"default_verif_means")
		//Start Code Change ----09.03.2009 #V92 maha - add assigned and priority
		ls_user  =  lds_exp_cred.getitemstring(i,"priority_user_exp")
		if isnull(ls_user) or LenA(ls_user) < 1 then ls_user = "PUBLIC"
		li_priority =  lds_exp_cred.getitemnumber(i,"priority_exp")
		if isnull(li_priority) then li_priority = 1
		ls_psv_user  =  lds_exp_cred.getitemstring(i,"priority_user")
		if isnull(ls_user) or LenA(ls_user) < 1 then ls_user = "PUBLIC"
		//End Code Change---09.03.2009
		if li_option = 1 then //create as PSV type not expiring
			ll_exp_method = ll_psv_method
			li_exp_flag = 1   //Start Code Change ----07.20.2015 #V15 maha - changed from 0
		else  //normal exp letter
			ll_exp_method = ll_ver_method_ltr
			li_exp_flag = 1
		end if
		//ll_seq_no = lds_exp_cred.GetItemNumber( i, "seq_no" )
		lds_exp_cred.RowsCopy(i, i, Primary!, lds_exp_copy, 100000, Primary!)
		//ll_seq_no++
		li_nr = lds_exp_copy.RowCount()
		lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
		lds_exp_copy.SetItem( li_nr, "first_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "last_sent", nulldate )
		lds_exp_copy.SetItem( li_nr, "number_sent", 0 )
		lds_exp_copy.SetItem( li_nr, "date_recieved", nulldate )
		lds_exp_copy.SetItem( li_nr, "user_name", "" )
		lds_exp_copy.SetItem( li_nr, "response_code", nullint )
		//Start Code Change ----09.03.2009 #V92 maha - add assigned and priority
//		lds_exp_copy.SetItem( li_nr, "priority_user", "PUBLIC" )
//		lds_exp_copy.SetItem( li_nr, "priority", 2 )
		//if ls_user <> "PUBLIC" then 
		lds_exp_copy.SetItem( li_nr, "priority_user", ls_user )
		//end if
		lds_exp_copy.SetItem( li_nr, "priority", li_priority )
		//Start Code Change ----09.03.2009 #V92 maha
		lds_exp_copy.SetItem( li_nr, "exp_credential_flag", li_exp_flag) //maha 070909
		lds_exp_copy.SetItem( li_nr, "verification_method", ll_exp_method) //maha 070909
		ls_doc_id = String( lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "prac_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "facility_id" ) ) + "-"
		ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "seq_no" ) )
		lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
		lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
		ls_new_doc_id[upperbound(ls_new_doc_id) + 1] = ls_doc_id //evan 05.16.2011
		ll_ref_row_num[upperbound(ll_ref_row_num) + 1] = i //evan 05.16.2011
		//Start Code Change ----08.03.2011 #V11 maha - cleart prior mod values and add create
		lds_exp_copy.SetItem( li_nr, "mod_user", "" )
		lds_exp_copy.SetItem( li_nr, "mod_date", nulldate )
		lds_exp_copy.SetItem(li_nr, 'create_date', datetime(today(),Now()))
		lds_exp_copy.SetItem(li_nr, 'create_user', "Sys-AIQ")
		//End Code Change ----08.03.2011 
//			ELSE
//				lds_verif_info.SetItem(li_nr, 'mod_date', String(Now(), 'yyyy-mm-dd hh:m:ss'))
//				lds_verif_info.SetItem(li_nr, 'mod_user', gs_user_id)
//			END IF
		
		if li_option = 2 then //exp letter plus PSV  - copy the exp one just created and modify for PSV
			//copy the last row
			lds_exp_copy.RowsCopy(li_nr, li_nr, Primary!, lds_exp_copy, 100000, Primary!)
			//reset the data in the new record
			li_nr = lds_exp_copy.RowCount()
			ll_seq_no++
			lds_exp_copy.SetItem( li_nr , "seq_no", ll_seq_no )
			lds_exp_copy.SetItem( li_nr, "priority_user", ls_psv_user )
			lds_exp_copy.SetItem( li_nr, "priority", 3 )
			lds_exp_copy.SetItem( li_nr, "exp_credential_flag", 1) //maha 070909    //Start Code Change ----07.20.2015 #V15 maha - changed from 0
			lds_exp_copy.SetItem( li_nr, "verification_method", ll_psv_method) //maha 070909
			ls_doc_id = String( lds_exp_copy.GetItemNumber( li_nr, "rec_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "prac_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "facility_id" ) ) + "-"
			ls_doc_id = ls_doc_id + String( lds_exp_copy.GetItemNumber( li_nr, "seq_no" ) )
			lds_exp_copy.SetItem( li_nr, "doc_id", ls_doc_id )
			lds_exp_copy.SetItem( li_nr, "print_flag", 1 )
			ls_new_doc_id[upperbound(ls_new_doc_id) + 1] = ls_doc_id //evan 05.16.2011
			ll_ref_row_num[upperbound(ll_ref_row_num) + 1] = i //evan 05.16.2011
		end if
		//End Code Change---07.09.2009	
	
		/* evan 05.16.2011
		IF lds_exp_copy.Update()  = 1 THEN
			COMMIT USING SQLCA;
			lds_exp_cred.SetItem( i, "exp_credential_flag", 2)
			cnt++
		else
			ls_fails = ls_fails + " " +  ls_doc_id
			bcnt++
		end if
		*/
	end if //historical

	
END FOR

//gnv_appeondb.of_commitqueue( ) //evan 05.16.2011

//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> evan 05.16.2011
//$<reason> Performance tuning.
li_row_cnt = UpperBound(ls_new_doc_id)
if li_row_cnt > 0 then
	lds_new_verif = Create datastore
	lds_new_verif.DataObject = "d_exp_new_verif"
	lds_new_verif.SetTransObject(SQLCA)
	gnv_appeondb.of_StartQueue()
	lds_exp_copy.Update()
	COMMIT USING SQLCA;
	lds_new_verif.Retrieve(ls_new_doc_id[])
	gnv_appeondb.of_CommitQueue()
	for i = 1 to li_row_cnt
		if lds_new_verif.Find("doc_id = '" + ls_new_doc_id[i] + "'", 1, 999999) > 0 then
			lds_exp_cred.SetItem(ll_ref_row_num[i], "exp_credential_flag", 2)
			cnt ++
		else
			ls_fails = ls_fails + " " +  ls_new_doc_id[i]
			bcnt ++
		end if
	next
	Destroy lds_new_verif
end if
//------------------- APPEON END ---------------------

//MSKINNER 15 MARCH 2005 -- BEGIN
if isvalid(w_aiq_run) THEN w_aiq_run.r_status.width = 600
//MSKINNER 15 MARCH 2005 -- END
//debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.29.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_autocommit( )
//---------------------------- APPEON END ----------------------------

IF lds_exp_cred.Update ( True, False ) = 1 THEN
	COMMIT USING SQLCA;
	DESTROY lds_exp_cred
	DESTROY lds_exp_copy
	DESTROY lds_last_verif_seq_no
	
	if cnt > 1 then
	//	messagebox("Exp Cred records created",cnt)
	end if
	if bcnt > 1 then
		//messagebox("Exp Cred records failed",bcnt)
	end if
	if LenA(ls_fails) > 5 then
		//messagebox("Exp Cred Failure","The following records could not be created~r " + ls_fails)
		//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("Exp Cred Failure","The following records could not be created~r " + ls_fails,true)
		bcnt++
	end if
	
	return 1
else
	//MessageBox("Update Failed", "Update during expiring credentials query failed.")
	//Added by Nova 01.30.2010 - v10.1 Scheduler Functionality
//	messagebox("",SQLCA.SQLErrText)
	inv_message.of_MessageBox("Update Failed", "Update during expiring credentials query failed.",true)
	DESTROY lds_exp_cred
	DESTROY lds_exp_copy
	DESTROY lds_last_verif_seq_no
	return -1
END IF


end function

public function integer of_run_ai_query_org (integer ai_from);//maha added 082903
integer xtype
integer db
integer res //maha 04.04.2016

//select set_26 into :xtype from icred_settings;
xtype = of_get_app_setting("set_26","I")

open(w_aiq_run) 

if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Checking for Expiring Credential Verifications" //For checking validation modified by  Nova 08.27.2009
if xtype = 1 then
	of_expiring_credentials_from_data()
else
	//Start Code Change ----04.04.2016 #V15 maha - prep for new function from stored procedure
	res = of_expiring_credentials_procd()  
	if res = -2 then
		of_expiring_credentials()
	end if
	//End Code Change ----04.04.2016
end if
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =   400  // 800

if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Checking for Letters that need to be reprinted" //For checking validation modified by  Nova 08.27.2009
of_resend_letters()
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  700    //1100

if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Appointment Verifications"
of_expiring_appointments()
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1000   //1495

//Start Code Change ----06.03.2013 #V14 maha
if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating IntelliBatches"
	of_intellibatch_update( )
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1200

//Start Code Change ----10.08.2015 #V15 maha
if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Updating Application Tracking running dates"
	of_appl_tracking_running_days( )
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width =  1300


if ai_from = 1 then //daily login process
	//select set_33 into :db from icred_settings;
	db = of_get_app_setting("set_33","I")
	if db = 1 then
		string ls_path
		string ls_state

		select database_backup_path into :ls_path from ids;
		
		if isnull(ls_path) then
			messagebox("No path","A default save path must be specified from the utilities Back up Database function.")
		else
			if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "BACKING UP DATABASE (This may take a few minutes.)" //For checking validation modified by  Nova 08.27.2009
			setpointer(hourglass!)
			ls_state = "BACKUP DATABASE DIRECTORY " + "'" + ls_path + "'" + ";"
			if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 250
			//messagebox("",ls_state)
			execute immediate :ls_state using sqlca;
			setpointer(arrow!)
			if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1300
		end if
	end if
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-16 By: Rodger Wu (Inova)
//$<reason> Create verifications based on missing items existing 90 days.
w_aiq_run.r_status.width = 1400
of_missing_info_90_days_generate()

//---------------------------- APPEON END ----------------------------
w_aiq_run.r_status.width = 1500
of_set_active_users() //Start Code Change ----05.15.2009 #V92 maha - for ameripath customzation

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.09.2007 By: Jervis
//$<reason> WebView Practitioner Application Initiated Work Flow
if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 1700
if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Create Work Flow For WebView.This may take a few minutes." //For checking validation modified by  Nova 08.27.2009
of_wv_Initiated_workflow()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//dataflow - joe 12.22.2009 
w_aiq_run.r_status.width = 1800
w_aiq_run.st_1.text = "Execute Data Flow. This may take a few minutes." 
of_df_expiring_update()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> Evan 02.08.2010
//$<reason> V10.1 - Notification Alert
w_aiq_run.r_status.width = 1900
w_aiq_run.st_1.text = "Execute Notification Alert. This may take a few minutes."
of_NotificationAlert()

//---------------------------- APPEON END ----------------------------

//Start Code Change ----08.08.2011 #V11 maha - meeting creation
//w_aiq_run.r_status.width =  2000
if isValid(w_aiq_run) then w_aiq_run.r_status.width =  2000	//long.zhang 09.04.2013 Null object reference
//w_aiq_run.st_1.text = "Execute Meeting Creation. This may take a few minutes."
if isValid(w_aiq_run) then w_aiq_run.st_1.text = "Execute Meeting Creation. This may take a few minutes."	//long.zhang 09.04.2013 Null object reference	
of_meeting_create( )
//End Code Change ----08.08.2011 

//-------------appeon begin----------------------
//<$>added:long.zhang 08.08.2013
//<$>reason:V14.1 Group Location Effective Dates
if isvalid(w_aiq_run) then w_aiq_run.r_status.width =  2100
if isvalid(w_aiq_run) then w_aiq_run.st_1.text = "Execute Pending Change. This may take a few minutes."
of_pendingchange( )
//-------------appeon End------------------------

if isvalid(w_aiq_run) then  close(w_aiq_run)

return 1
end function

public function integer of_ama_profile (long al_pracid[], string as_docid[], boolean ab_single_prac, string as_from, long al_ama_id);//Start Code Change ----05.23.2016 #V152 maha - function call for AMA profile API
long ll_ama_id
integer li_steps
integer res = 1
Int li_rtn //Added by Appeon long.zhang 06.01.2016
string ls_last
string ls_first
date ls_dob
string as_state
string ls_arg
string ls_value
string ls_xml
blob lblb_file
n_cst_ama_profiles inv_amaapi
str_ama_searchrequest      lstr_data
str_ama_searchmatchitem lstr_match_items[] //Modified to array, by Appeon long.zhang 06.01.2016

n_ds lds_prac

lds_prac = create n_ds
lds_prac.dataobject = "d_ama_api_get_prac_info"
lds_prac.settransobject(sqlca)

If UpperBound(al_pracid[]) = 0 Then Return 0 //Added by Appeon long.zhang 06.01.2016

lds_prac.retrieve(al_pracid[])
//debugbreak()
lstr_data.lastname = lds_prac.getitemstring(1, "last_name")
lstr_data.firstname = lds_prac.getitemstring(1, "first_name")
lstr_data.dateofbirth = lds_prac.getitemdatetime(1, "date_of_birth")

//Modified by Appeon long.zhang 06.01.2016
li_rtn = inv_amaapi.of_search( lstr_data, lstr_match_items[])
If li_rtn > 0 Then //successful
	ll_ama_id =  lstr_match_items[1].entityid
ElseIf li_rtn = 0 Then //no matched
	messagebox("Not Matched", inv_amaapi.of_get_errtext()) 
	Return 0
Else //-x failed
	messagebox("Failed", inv_amaapi.of_get_errtext()) 
	Return -1
End If	

//ll_ama_id = 5
inv_amaapi.of_single_full( ll_ama_id, ls_xml)

if fileexists(ls_xml) then
	of_save_doc_to_db( as_docid[1], ls_xml, 6)
else
	messagebox("Failed", ls_xml)
	res = -1
end if

destroy lds_prac





return res
end function

public function integer of_save_doc_to_db (string as_doc_id, string as_file_name, integer ai_type);//Start Code Change ----05.31.2016 #V152 maha - added
String ls_fname
Blob lblb_bitmap
n_cst_dm_utils lnv_file
String is_tempdir
string ls_text
string ls_notes 

if not fileexists(as_file_name) then
	Return -1
else
	SetPointer(HourGlass!)
	
	ls_fname = as_file_name
	
	lnv_file.of_ReadBlob(ls_fname, lblb_bitmap)


	UPDATEBLOB verif_info
	SET verification_picture = :lblb_bitmap
	WHERE doc_id = :as_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if

	
	UPDATE verif_info
	SET verification_picture_flag = :ai_type
	WHERE doc_id = :as_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if

end if

return 1
end function

public function integer of_check_reports_store ();//====================================================================
//$<Function>: of_check_reports_store
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.05.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_delete
long ll_srs_id
long ll_count, ll_cnt
datetime ldt_end
datastore lds_srs_setup

lds_srs_setup = create datastore
lds_srs_setup.dataobject = "d_reports_saved_browse"
lds_srs_setup.settransobject(sqlca)
//---------Begin Modified by (Appeon)Stephen 07.27.2017 for BugL071905--------
//lds_srs_setup.retrieve(gs_user_id)
lds_srs_setup.retrieve('master')
//---------End Modfiied ------------------------------------------------------
ll_count = lds_srs_setup.rowcount()

gnv_appeondb.of_startqueue( )
for ll_cnt = 1 to ll_count
	li_delete = lds_srs_setup.getitemnumber(ll_cnt , "delete_days")
	if isnull(li_delete) or li_delete = 0 then continue
	ll_srs_id = lds_srs_setup.getitemnumber(ll_cnt , "srs_id")
	ldt_end = datetime(RelativeDate(today(), li_delete * -1),time("00:00"))
	delete from sys_report_storage_files where srs_id = :ll_srs_id and do_not_delete = 0 and date_run < :ldt_end;
next
gnv_appeondb.of_commitqueue( )	

commit using sqlca;
return 1
end function

public function integer of_exp_credentials_check_for_data (integer ai_screen);//Start Code Change ----11.06.2017 #V16 maha - added 
long cc

choose case ai_screen
	CASE 4 //license
		SELECT count (distinct pd_license.rec_id) into :cc  FROM pd_affil_stat,  pd_license WHERE  pd_affil_stat.prac_id = pd_license.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_license.expiration_date < getdate() + 30  AND   pd_license.active_status = 1; 
	CASE 5 //"DEA"
		SELECT count (distinct pd_dea_state_csr.rec_id) into :cc  FROM pd_affil_stat,  pd_dea_state_csr WHERE  pd_affil_stat.prac_id = pd_dea_state_csr.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_dea_state_csr.expiration_date < getdate() + 30  AND   pd_dea_state_csr.active_status = 1; 
	CASE 9 //Special Certs
		SELECT count (distinct pd_special_certs.rec_id) into :cc  FROM pd_affil_stat,  pd_special_certs WHERE  pd_affil_stat.prac_id = pd_special_certs.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_special_certs.end_date < getdate() + 30  AND   pd_special_certs.active_status = 1; 
	CASE 15 //"Insurance"
		SELECT  count(distinct pd_insurance.rec_id) into :cc  FROM pd_affil_stat,  pd_insurance WHERE  pd_affil_stat.prac_id = pd_insurance.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_insurance.coverage_to < getdate() + 30  AND   pd_insurance.active_status = 1; 
	CASE 19 //"Board/Specialty"
		SELECT count (distinct pd_board_specialty.rec_id) into :cc  FROM pd_affil_stat,  pd_board_specialty WHERE  pd_affil_stat.prac_id = pd_board_specialty.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_board_specialty.certification_expires < getdate() + 30  AND  pd_board_specialty.board_code is not null; 
	CASE 23 //Other Ids
		SELECT count (distinct pd_other_ids.rec_id) into :cc  FROM pd_affil_stat, pd_other_ids WHERE  pd_affil_stat.prac_id = pd_other_ids.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_other_ids.exp_date < getdate() + 30  AND   pd_other_ids.active_status = 1; 
	CASE 71     //health history
		SELECT count (distinct pd_health_history.rec_id) into :cc  FROM pd_affil_stat, pd_health_history WHERE  pd_affil_stat.prac_id = pd_health_history.prac_id  and   pd_affil_stat.active_status in (1,4)  AND   pd_health_history.exp_date < getdate() + 30 ; 
	CASE else
		cc = -1
end choose



return cc
end function

public function integer of_expiring_credentials_from_data_utl (string as_from, integer ai_screen[]);//Start Code Change ----11.06.2017 #V16 maha - copied the ..._data_new function and reworked

integer li_days
integer li_screen
integer li_priority
integer li_exp_flag
integer li_act_stat
integer li_exp_days
integer li_found
integer clicks
integer li_screen_array_cnt
integer li_screen_ids[]
integer li_bs_year
integer li_month
integer ll_code
integer ac
integer li_complete = 1
integer exp_days
integer li_max_exp_days

long ll_resp_code = 2
long ll_verif_method = 1
long ll_ref1no
long ll_ref1
long ll_ref2
long ll_ref_exp
long s
long sc
long d
long dc
long f
long fc
long pc
long cnt = 0
long tcnt = 0
integer chk
long ll_rec
long ll_prac
long ll_facil 
Long ll_seq
long ll_rowcount
long r
long ll_newrow
long ll_null_no
long ll_address_code
Long ll_ref1_arr[],ll_ref1_arr_i,ll_dataobject_arr_i,ll_dataobject_arr_cnt
long ll_prac_count
long ll_prac_list[]
long ll_rec_ids[]

string ls_screen_name
string ls_ref1_lu
string ls_ref2_lu
string ls_ref1_lutype
string ls_ref2_lutype
string ls_ref1_dtype
string ls_ref2_dtype
string ls_ref1_lufield
string ls_ref2_lufield
string ls_ref1_name
string ls_ref2_name
string ls_refexp_name
string ls_priority_user
string ls_ref_value
string ls_datatype
string ldw
string ls_reference1
string ls_reference2
string ls_reference
string ls_doc_id
String ls_dataobject, ls_dataobject_arr[]
string fil
string ls_find

datetime ld_exp
datetime ldt_exp_date
datetime ldt_null_date
datetime ldt_exp_ret

Boolean lb_existing

datastore lds_screen
datastore lds_facils
datastore lds_sys_field
datastore lds_verif
datastore lds_data
datastore lds_existing
Datastore lds_dataobject_arr[]
datastore lds_prac_list


//test for exp cred method
ll_verif_method = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(code) = upper('Exp Cred Ltr')"))
if ll_verif_method < 1 then
	inv_message.of_MessageBox("Missing Data", "You do not have a Verification Method lookup with the code of 'Exp Cred Ltr'.~rUnable to continue.",true)
	return -1
end if

ldt_exp_ret = datetime( relativedate(today(), 30), time("00:00:00")) 
setnull(ldt_null_date)

lds_screen = CREATE datastore
lds_screen.dataobject = "d_verif_screens_exp_list" // all facility ver rules for exp verifs  ok
lds_screen.settransobject(sqlca)

if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 100

//gets all distinct verif rules where data_view = 1, screen > 1 and exp_days > 0 and the screen has an exp_field
sc = lds_screen.retrieve(ai_screen)

if sc < 1 then 
	inv_message.of_MessageBox("Expiring Credentials", "There are no verification rules set up for the Selected Verification screens.  Skipping this function.",true)
	return -1
end if

lds_verif = CREATE datastore
lds_verif.dataobject = "d_verif_exp_4_record"

for s = 1 to upperbound(ai_screen[])
	li_screen = ai_screen[s]
	ls_find = "screen_id = " + string(li_screen)
	
	choose case li_screen
		CASE 4 //license
			lds_data.dataobject = "d_exp_license_verif_no_vers"
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Licenses"
		CASE 5 //"DEA"
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring DEAs"
		CASE 9 //Special Certs
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Special Certifications"
		CASE 15 //"Insurance"
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Insurance Policies"
		CASE 19 //"Board/Specialty"
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Specialty Cerifications"
		CASE 23 //Other Ids
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Other Ids"		
		CASE 71   //Health
			lds_data.dataobject = ""
			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Health History"
	end choose
	
	li_found = lds_screen.find( ls_find, 1, lds_screen.rowcount())
	if li_found > 0 then
		ll_ref1 = lds_screen.getitemnumber(li_found,"reference_field_1")
		ll_ref2 = lds_screen.getitemnumber(li_found,"reference_field_2")
		ll_ref_exp = lds_screen.getitemnumber(li_found,"exp_field")
	else
		messagebox("Data error","Failed to get reference fields from sys_fields")
	end if
	
	//ref 1
	ls_ref1_dtype = gnv_data.of_getitem("sys_fields","field_type", "field_id = " + string(ll_ref1))
	ls_ref1_name = gnv_data.of_getitem("sys_fields","field_name", "field_id = " + string(ll_ref1))
	ls_ref1_lu =gnv_data.of_getitem("sys_fields","lookup_field", "field_id = " + string(ll_ref1))
	if ls_ref1_lu = "Y" then
		ls_ref1_lutype = gnv_data.of_getitem("sys_fields","lookup_type", "field_id = " + string(ll_ref1))
		ls_ref1_lufield = gnv_data.of_getitem("sys_fields","lookup_field_name", "field_id = " + string(ll_ref1))
	end if
	
	//ref2
	ls_ref2_dtype = gnv_data.of_getitem("sys_fields","field_type", "field_id = " + string(ll_ref2))
	ls_ref2_name = gnv_data.of_getitem("sys_fields","field_name", "field_id = " + string(ll_ref2))
	ls_ref2_lu =gnv_data.of_getitem("sys_fields","lookup_field", "field_id = " + string(ll_ref2))
	if ls_ref2_lu = "Y" then
		ls_ref2_lutype = gnv_data.of_getitem("sys_fields","lookup_type", "field_id = " + string(ll_ref2))
		ls_ref2_lufield = gnv_data.of_getitem("sys_fields","lookup_field_name", "field_id = " + string(ll_ref2))
	end if
	
	//exp
	ls_refexp_name = gnv_data.of_getitem("sys_fields","field_name", "field_id = " + string(ll_ref_exp)) 


	
	lds_data.settransobject(sqlca)
	dc = lds_data.retrieve(ldt_exp_ret)
	
	for d = 1 to dc
		ll_rec = lds_data.getitemnumber(d,"rec_id")
		ll_prac = lds_data.getitemnumber(d,"prac_id")
		ldt_exp_date = lds_data.GetItemDateTime( d, ls_refexp_name )
		
		ls_reference =  lds_data.getitemstring(d,"reference_value")
		
		if isnull(ls_reference) or ls_reference = "" then
			IF ll_ref1 > 0 THEN
				IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
					ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
				elseif ls_ref1_dtype = "C" then
					ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
				elseif ls_ref1_dtype = "D" then
					ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
				end if
				if ls_ref1_lu = "Y" then
					ll_code = long(ls_reference1)
					if isnumber(ls_reference1) then ll_address_code = ll_code
					if ls_ref1_lutype = "A" then
						if upper(ls_ref1_lufield) = "ENTITY NAME" THEN
							ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
						else
							ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
						end if
	
					elseif ls_ref1_lutype = "C" then
						if upper(ls_ref1_lufield) = "DESCRIPTION" THEN
							ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
						else
							ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
						end if
					end if
				end if
			end if			
			if isnull(ls_reference1) then ls_reference1 = ""
	
			IF ll_ref2 > 0 THEN
				IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
					ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
				elseif ls_ref2_dtype = "C" then
					ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
				elseif ls_ref2_dtype = "D" then
					ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
				end if
				if ls_ref2_lu = "Y" then
					ll_code = long(ls_reference2)
					if isnumber(ls_reference2) then ll_address_code = ll_code
					if ls_ref2_lutype = "A" then
						if upper(ls_ref2_lufield) = "ENTITY NAME" THEN
							ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
						else
							ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
						end if
						
					elseif ls_ref2_lutype = "C" then
						if upper(ls_ref2_lufield) = "DESCRIPTION" THEN
							ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
						else
							ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
						end if
					end if
				end if
			END IF
			
			if isnull(ls_reference2) then ls_reference2 = ""
			ls_reference = ls_reference1 + " - " + ls_reference2
		end if
			
		//********* create verif ****************
		ll_newrow = lds_verif.insertrow(0)
		
		lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
		lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
		lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
		lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
		lds_verif.setitem(ll_newrow,"screen_id",li_screen)
		lds_verif.setitem(ll_newrow,"active_status",1)
		lds_verif.setitem(ll_newrow,"number_sent",0)
		lds_verif.setitem(ll_newrow,"source","P")
		lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
		lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
		lds_verif.setitem(ll_newrow,"verification_method",ll_verif_method)
		lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
		lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
		lds_verif.setitem(ll_newrow,"priority",1)
		lds_verif.setitem(ll_newrow,"exp_credential_flag",1)
		ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
		lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
		lds_verif.setitem(ll_newrow,"print_flag",0)
		lds_verif.setitem(ll_newrow,"notes","eieio")
		lds_verif.setitem(ll_newrow,"data_status",1)
		lds_verif.SetItem(ll_newrow, 'create_date', DateTime(Today(), Now()))
		lds_verif.SetItem(ll_newrow, 'create_user', Trim(gs_user_id) + "Sys-AIQ")
				
		tcnt++						
	next
	
	lds_verif.update()
	commit using sqlca;
next



//
//			
//			
//
//	
//
//
//
//
//
//
//
//
//
//
//
//
//
//lds_existing = CREATE datastore
//lds_existing.dataobject = "d_verif_exp_4_record_ids" //
//lds_facils = CREATE datastore
//lds_facils.dataobject = "d_prac_affils_verif_all"//
//lds_sys_field = CREATE datastore
//lds_sys_field.dataobject = "d_field_data_forpt"//
//lds_verif = CREATE datastore
//lds_verif.dataobject = "d_verif_exp_4_record"//
//lds_prac_list = CREATE datastore
//lds_prac_list.dataobject = "d_exp_cred_prac_list"//
//lds_data = CREATE datastore
//
//lds_sys_field.settransobject(sqlca)
//lds_facils.settransobject(sqlca)
//lds_verif.settransobject(sqlca)
//lds_prac_list.settransobject(sqlca)
//lds_existing.settransobject(sqlca)
//
//clicks = integer(700/sc)
//
////get all reference values field ids
//for s = 1 to sc
//	li_screen = lds_screen.getitemnumber(s,"screen_id")
//	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
//	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
//	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
//	r =  lds_screen.getitemnumber(s,"exp_field")
//
//	ll_ref1_arr_i ++
//	ll_ref1_arr[ll_ref1_arr_i] = ll_ref1
//	ll_ref1_arr_i ++
//	ll_ref1_arr[ll_ref1_arr_i] = ll_ref2
//	ll_ref1_arr_i ++
//	ll_ref1_arr[ll_ref1_arr_i] = ll_ref_exp
//	//get the screens in an array to get rule data
//	 li_screen_array_cnt++
//	 li_screen_ids[ li_screen_array_cnt] = li_screen
//next
//
////get the ref value data
//d = lds_sys_field.Retrieve( ll_ref1_arr[] )
////messagebox("lds_sys_field retrieve",d)
////get the rules connected to 
////lds_rules.retrieve(li_screen_ids[]), //????
//
//ll_prac_count = lds_prac_list.retrieve(ldt_exp_ret )
//if ll_prac_count < 1 then
//	messagebox("lds_prac_list retrieve - " + string(ll_prac_count), "No providers retrieved")
//	return 1
//end if
//
//for d = 1 to ll_prac_count
//	ll_prac_list[d] = lds_prac_list.getitemnumber(d,"prac_id")
//next
////messagebox("lds_prac_list retrieve",upperbound(ll_prac_list))
////get all the practitioner appointments for the data screens
//d = lds_facils.retrieve(ll_prac_list[],li_screen_ids[])
//if d < 1 then
//	messagebox("lds_facil retrieve - " + string(d), "No facility records retrieved")
//	return 1
//end if
////messagebox("lds_facil retrieve",d)
//
////----------------------2.25.2016 RP added to implement just-in-time cache--------------------
//gnv_data.of_retrieveIfNecessary("address_lookup", FALSE)
////------------------------------------------------------------------------------------------------------
//
//if gnv_data.ids_address_lookup.rowcount() = 0 then
//	gnv_data.ids_address_lookup.settransobject(sqlca)
//	d = gnv_data.ids_address_lookup.retrieve()
//	messagebox("address lookup ret",d)
//end if
//
////for each data screen
//for s = 1 to sc
//	tcnt = 0
//	//lds_verif.reset()
////	st_cs.text = string(s)
//	li_screen = lds_screen.getitemnumber(s,"screen_id")
//	ls_screen_name = lds_screen.getitemstring(s,"screen_name")
//	ll_ref1 = lds_screen.getitemnumber(s,"reference_field_1")
//	ll_ref2 = lds_screen.getitemnumber(s,"reference_field_2")
//	ll_ref_exp = lds_screen.getitemnumber(s,"exp_field")
//	
//	select max(exp_cred_que_letters_days) into :li_max_exp_days from facility_ver_rules  where screen_id = :li_screen;
//	ldt_exp_ret = datetime( relativedate(today(), li_max_exp_days + 1), time("00:00:00"))
//	
//	
//	//get ref 1 data
//	lds_sys_field.SetFilter("field_id = " + String(ll_ref1))
//	lds_sys_field.Filter( )
//	If lds_sys_field.Rowcount( ) < 1 Then
//		ll_ref1  = 0
//	else		//ref one data
//		ls_ref1_dtype = lds_sys_field.getitemstring(1,"field_type")
//		ls_ref1_name = lds_sys_field.getitemstring(1,"field_name")
//		ls_ref1_lu = lds_sys_field.getitemstring(1,"lookup_field")
//		if ls_ref1_lu = "Y" then
//			ls_ref1_lutype = lds_sys_field.getitemstring(1,"lookup_type")
//			ls_ref1_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
//		end if
//	end if
//
//	//get ref 2 data
//	lds_sys_field.SetFilter("field_id = " + String(ll_ref2))
//	lds_sys_field.Filter( )
//	If lds_sys_field.Rowcount( ) < 1 Then
//		ll_ref2 = 0
//	else	 //ref 2 data
//		ls_ref2_dtype = lds_sys_field.getitemstring(1,"field_type")
//		ls_ref2_name = lds_sys_field.getitemstring(1,"field_name")
//		ls_ref2_lu = lds_sys_field.getitemstring(1,"lookup_field")
//		if ls_ref2_lu = "Y" then
//			ls_ref2_lutype = lds_sys_field.getitemstring(1,"lookup_type")
//			ls_ref2_lufield = lds_sys_field.getitemstring(1,"lookup_field_name")
//		end if
//	end if
//	//get exp field data
//	lds_sys_field.SetFilter("field_id = " + String(ll_ref_exp))
//	lds_sys_field.Filter( )
//	If lds_sys_field.Rowcount( ) < 1 Then
//		ll_ref_exp = 0
//	else
//		ls_refexp_name = lds_sys_field.getitemstring(1,"field_name")
//	end if
//
//	
//	lds_data.dataobject = ""
//	CHOOSE CASE li_screen
//
//		CASE 4//"License"
//			lds_data.dataobject = "d_exp_license_verif"
//	         if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Licenses"
//
//		CASE 5 //"DEA"
//			lds_data.dataobject = "d_exp_dea_verif"
//			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring DEAs"
//
//		CASE 9 //Special Certs
//			lds_data.dataobject = "d_exp_spec_certs_verif"
//			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Special Certifications"
//
//		CASE 15 //"Insurance"
//			lds_data.dataobject = "d_exp_insurance_verif"
//			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Insurance Records"
//
//		CASE 19 //"Board/Specialty"
//			lds_data.dataobject = "d_exp_spec_verif"
//			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Board Certifications"
//
//		CASE 23 //Other Ids
//			lds_data.dataobject = "d_exp_other_ids_verif"
//			if isvalid(w_aiq_run) then  w_aiq_run.st_1.text = "Checking for Expiring Other IDS"
//
//		CASE else
//			messagebox("Continue","This utility does not support Expiring verification Creation for the " + ls_screen_name + " screen.")
//			continue
//	END CHOOSE
//
//
//	lds_data.settransobject(sqlca)
//	//get the data for the specific screen
//	dc = lds_data.retrieve(ldt_exp_ret)
////messagebox(string(li_screen),dc)
//	if dc < 1 then continue
//	
//	cnt = 0
//
//	//get the list of recids and retrieve verifs
//	for d = 1 to dc	
//		ll_rec = lds_data.getitemnumber(d,"rec_id")
//		ll_rec_ids[d] = ll_rec
//	next
//	
//	d = lds_existing.retrieve(ll_rec_ids, ll_verif_method )
//	//messagebox("verifs found",d)
//	
//	//go through list and create verifications for each facility where required
//	for d = 1 to dc	
//		ll_rec = lds_data.getitemnumber(d,"rec_id")
//		ll_prac = lds_data.getitemnumber(d,"prac_id")
//
//		//get expiration date value
//		IF ll_ref_exp > 0 THEN
//
//				ldt_exp_date = lds_data.GetItemDateTime( d, ls_refexp_name )
//
//		ELSE
//			continue
//		END IF
//	//*************** reference data *******************
//		//get reference 1 data
//		
//		IF ll_ref1 > 0 THEN
//			IF ls_ref1_dtype = "N" or ls_ref1_dtype = "I" then
//				ls_reference1 =  string(lds_data.GetItemNumber( d, ls_ref1_name ))
//			elseif ls_ref1_dtype = "C" then
//				ls_reference1 =  lds_data.GetItemstring( d, ls_ref1_name )
//			elseif ls_ref1_dtype = "D" then
//				ls_reference1 =  string(date(lds_data.GetItemdatetime( d, ls_ref1_name )))
//			end if
//			if ls_ref1_lu = "Y" then
//				ll_code = long(ls_reference1)
//				if isnumber(ls_reference1) then ll_address_code = ll_code
//				if ls_ref1_lutype = "A" then
//					if upper(ls_ref1_lufield) = "ENTITY NAME" THEN
//						ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
//					else
//						ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
//					end if
//
//				elseif ls_ref1_lutype = "C" then
//					if upper(ls_ref1_lufield) = "DESCRIPTION" THEN
//						ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
//					else
//						ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
//					end if
//				end if
//			end if
//		end if			
//		if isnull(ls_reference1) then ls_reference1 = ""
//					
//		//get reference 2 data
//		IF ll_ref2 > 0 THEN
//			IF ls_ref2_dtype = "N" or ls_ref2_dtype = "I" then
//				ls_reference2 =  string(lds_data.GetItemNumber( d, ls_ref2_name ))
//			elseif ls_ref2_dtype = "C" then
//				ls_reference2 =  lds_data.GetItemstring( d, ls_ref2_name )
//			elseif ls_ref2_dtype = "D" then
//				ls_reference2 =  string(date(lds_data.GetItemdatetime( d, ls_ref2_name )))
//			end if
//			if ls_ref2_lu = "Y" then
//				ll_code = long(ls_reference2)
//				if isnumber(ls_reference2) then ll_address_code = ll_code
//				if ls_ref2_lutype = "A" then
//					if upper(ls_ref2_lufield) = "ENTITY NAME" THEN
//						ls_reference1 = gnv_data.of_getitem( "address_lookup", "entity_name", "lookup_code = " + string(ll_code))
//					else
//						ls_reference1 = gnv_data.of_getitem( "address_lookup", "code", "lookup_code = " + string(ll_code))
//					end if
//					
//				elseif ls_ref2_lutype = "C" then
//					if upper(ls_ref2_lufield) = "DESCRIPTION" THEN
//						ls_reference1 = gnv_data.of_getitem( "code_lookup", "description", "lookup_code = " + string(ll_code))
//					else
//						ls_reference1 = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + string(ll_code))
//					end if
//				end if
//			end if
//		END IF
//		if isnull(ls_reference2) then ls_reference2 = ""
//		ls_reference = ls_reference1 + " - " + ls_reference2
//		
//		//IF ls_screen_name = "Licensure" THEN exception for the code
//		IF li_screen = 4 THEN					
//			ll_address_code = lds_data.GetItemNumber( d, "verifying_agency" )
//		end if
//		
//		choose case li_screen
//			case 4,5,15
//				li_act_stat =  lds_data.GetItemNumber( d, "active_status" )
//		end choose
//				
////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@		
//		//filter the appointment records
//		fil = "prac_id = " + string(ll_prac) + " and screen_id = " + string(li_screen)
//
//		fc = lds_facils.setfilter ( fil)
//		if fc < 0 then messagebox("of_expiring_credentials_from_data_new","Bad filter for lds_facil")
//		lds_facils.filter()
//		fc = lds_facils.rowcount()
//		
//		if fc < 1 then
//			//messagebox("fc",fc)
//			continue
//		end if
//		for f = 1 to fc
//			li_found = 0
//			ll_facil = lds_facils.getitemnumber(f,"verifying_facility")
//			exp_days = lds_facils.getitemnumber(f,"exp_cred_que_letters_days")
//			ls_priority_user = lds_facils.getitemstring(f,"priority_user")
//			if RelativeDate ( today(), exp_days ) <  date(ldt_exp_date) then continue //skip if has not expired yet by these rules
//
//			//filter the verifs 
//			fil = "prac_id = " + string(ll_prac) + " and rec_id = " + string(ll_rec) + " and facility_id = " + string(ll_facil) 
//			cnt = lds_existing.setfilter( fil)
//			if cnt < 0 then
//				messagebox("of_expiring_credentials_from_data_new","Bad filter for lds_existing~r" + fil)
//				return -1
//			end if
//			lds_existing.filter()
//			cnt = lds_existing.rowcount()
//
//			if cnt > 0 then  //this means a record exists
//				continue
//			else
//				 //messagebox("",cnt)
//				select max(seq_no) into :ll_seq from verif_info where rec_id = :ll_rec and prac_id = :ll_prac and facility_id = :ll_facil;
//				if isnull(ll_seq) then ll_seq = 0
//				ll_seq++
//
//				
//				//********* create verif ****************
//				ll_newrow = lds_verif.insertrow(0)
//				
//				
//				lds_verif.setitem(ll_newrow,"rec_id",ll_rec)
//				lds_verif.setitem(ll_newrow,"prac_id",ll_prac)
//				lds_verif.setitem(ll_newrow,"facility_id",ll_facil)
//				lds_verif.setitem(ll_newrow,"seq_no",ll_seq)
//				lds_verif.setitem(ll_newrow,"screen_id",li_screen)
//				lds_verif.setitem(ll_newrow,"active_status",1)
//				lds_verif.setitem(ll_newrow,"number_sent",0)
//				lds_verif.setitem(ll_newrow,"source","P")
//				lds_verif.setitem(ll_newrow,"expiration_date",ldt_exp_date)
//				lds_verif.setitem(ll_newrow,"address_lookup_code",ll_address_code)
//				lds_verif.setitem(ll_newrow,"verification_method",ll_verif_method)
//				lds_verif.setitem(ll_newrow,"reference_value",ls_reference)
//				lds_verif.setitem(ll_newrow,"priority_user",ls_priority_user)
//				lds_verif.setitem(ll_newrow,"priority",1)
//				lds_verif.setitem(ll_newrow,"exp_credential_flag",1)
//				ls_doc_id = String( ll_rec ) + "-" + String( ll_prac ) + "-" + String( ll_facil ) + "-" + String( ll_seq )
//				lds_verif.setitem(ll_newrow,"doc_id",ls_doc_id)
//				lds_verif.setitem(ll_newrow,"print_flag",0)
//				lds_verif.setitem(ll_newrow,"notes","eieio")
//				lds_verif.setitem(ll_newrow,"data_status",1)
//				// R.Avital v11.3 capture creation date and user
//				// Begin changes
//				lds_verif.SetItem(ll_newrow, 'create_date', DateTime(Today(), Now()))
//				lds_verif.SetItem(ll_newrow, 'create_user', Trim(gs_user_id) + "Sys-AIQ")
//				// R.Avital v11.3 END changes
//				
//				tcnt++			
////				st_added.text = string(tcnt)
////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
////				lds_verif.update()
////				commit using sqlca;
//			end if
//			
//		next
//		lds_verif.update()
//		commit using sqlca;
//	next
//messagebox("screen count",tcnt)		
//if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = w_aiq_run.r_status.width + clicks
//next
//
//if as_from = "Utility" then
//	tcnt = lds_verif.rowcount()
//	messagebox("total count",tcnt)
//	d = lds_verif.sharedata(w_exp_cred_create_util.dw_data)
//	messagebox("share data", d)
//end if
//
////destroy lds_screen
////destroy lds_facils
////destroy lds_sys_field
//destroy lds_verif
//destroy lds_data
////destroy lds_existing
//
//if isvalid(w_aiq_run) then  w_aiq_run.r_status.width = 800
//

return 1
end function

on pfc_n_cst_ai_printletters.create
call super::create
end on

on pfc_n_cst_ai_printletters.destroy
call super::destroy
end on

