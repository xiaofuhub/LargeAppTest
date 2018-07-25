$PBExportHeader$n_cst_update.sru
$PBExportComments$db_update tool
forward
global type n_cst_update from nonvisualobject
end type
end forward

global type n_cst_update from nonvisualobject
end type
global n_cst_update n_cst_update

type variables
String is_sql_statements[]



end variables

forward prototypes
public subroutine of_execute_sqls (string as_title)
public function integer of_execute (string as_sql, string as_title)
public function string of_get_development ()
public function integer of_common_updates ()
public function integer of_ver60_updates ()
public function integer of_ver70_updates ()
public function integer of_ver80_updates ()
public function string of_get_from_version ()
public function integer of_ver91_updates ()
public function integer of_ver92_updates ()
public function integer of_ver101_updates ()
public function integer of_ver111_updates ()
public function integer of_ver112_updates ()
public function integer of_ver113_updates ()
public function integer of_ver121_updates ()
public function integer of_ver122_updates ()
public function integer of_ver123_updates ()
public function integer of_ver141_updates ()
public function integer of_clx110_updates ()
public function integer of_ver142_updates ()
public function integer of_clx120_updates ()
public function integer of_ver151_updates ()
public function integer of_ai_procedures_15 ()
public function integer of_ver152_updates ()
public function integer of_ver153_updates ()
public function integer of_ver154_updates ()
public function integer of_ver161_updates ()
end prototypes

public subroutine of_execute_sqls (string as_title);//-----------------------------------------------------------------------------
// [PUBLIC]    : of_execute_sqls
// Arguments 	: string as_title
// Returns   	: [none]   
// Created By	: Alfee 01.30.2008
//------------------------------------------------------------------------------
Long ll_i
String ls_null[]

// IF IsValid(gnv_logservice)THEN gnv_logservice.of_log("work_flow", '****',as_title)
IF UPPERBOUND(is_sql_statements) > 0 THEN 
		if Not isvalid( w_infodisp ) then open(w_infodisp)
		if isvalid(w_infodisp) then w_infodisp.title = "Update DB - " + as_title + "()"
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = as_title
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statements))
			
		FOR ll_i = 1 TO upperbound(is_sql_statements)
			If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Modification ' +string(ll_i) +' of '+ string(upperbound(is_sql_statements)) +', Please stand by!'
			of_execute(is_sql_statements[ll_i],as_title)
			if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT	
     // if isvalid(w_infodisp) then close(w_infodisp)	    
END IF

is_sql_statements = ls_null

RETURN
end subroutine

public function integer of_execute (string as_sql, string as_title);Yield()

EXECUTE Immediate :as_sql Using Sqlca;
IF Sqlca.SQLCode <> 0 THEN
	
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(as_sql, Sqlca.SQLErrText,as_title)
	gb_upgrade_failed = TRUE
	RETURN -1
END IF
//IF Sqlca.AutoCommit = False THEN
	COMMIT Using Sqlca;
//END IF


RETURN 1

end function

public function string of_get_development ();//read inifile get development type
//development '0':No,'1':Yes
String ls_original_dev_setting
ls_original_dev_setting = ProfileString(gs_IniFilePathName, "setup", "development", "1")
RETURN ls_original_dev_setting

end function

public function integer of_common_updates ();RETURN 1

end function

public function integer of_ver60_updates ();RETURN 1
end function

public function integer of_ver70_updates ();RETURN 1
end function

public function integer of_ver80_updates ();RETURN 1
end function

public function string of_get_from_version ();//Get the version no upgraded from - Alfee 02.14.2008
Integer li_ver

select set_18 into :li_ver from icred_settings; 
If IsNull(li_ver) Then li_ver = 0
If gs_dbType = 'SQL' and li_ver < 55 then li_ver = 55

Return String(li_ver)

end function

public function integer of_ver91_updates ();//Alfee 07.11.2008
//change of_ver85_updates() to of_ver91_updates() - alfee 12.30.2008

RETURN 1
end function

public function integer of_ver92_updates ();//Alfee 03.03.2009

RETURN 1
end function

public function integer of_ver101_updates ();//Evan 09.29.2009

RETURN 1
end function

public function integer of_ver111_updates ();//Nova 06.23.2010
RETURN 1
end function

public function integer of_ver112_updates ();//Evan 01.10.2011

RETURN 1
end function

public function integer of_ver113_updates ();// For v113 db updates - evan 06.13.2011

RETURN 1
end function

public function integer of_ver121_updates ();// For v121 db updates - evan 10.13.2011

RETURN 1
end function

public function integer of_ver122_updates ();// For v122 db updates - stephen 06.04.2012

RETURN 1
end function

public function integer of_ver123_updates ();// For v123 db updates - alfee 12.03.2012

RETURN 1
end function

public function integer of_ver141_updates ();

RETURN 1
end function

public function integer of_clx110_updates ();//====================================================================
//$<Function>: of_clx110_updates()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Database Update from CLX (V8.5 - V11.0)
//$<Author>: (Appeon) Alfee 06.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

RETURN 1
end function

public function integer of_ver142_updates ();

RETURN 1
end function

public function integer of_clx120_updates ();//====================================================================
//$<Function>: of_clx120_updates()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Database Update from CLX 12
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

RETURN 1
end function

public function integer of_ver151_updates ();

RETURN 1
end function

public function integer of_ai_procedures_15 ();//Start Code Change ----04.18.2016 #V15 maha - added for <RP> stored procudures

//Start Code Change ----03.14.2016 #V15 maha - for RP
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'up_app_session_parms' AND TYPE = 'P') " + &
"BEGIN " + &
"	DROP PROCEDURE up_app_session_parms~r~n" + &
"END" 

 is_sql_statements[UpperBound(is_sql_statements) + 1] = & 
" create procedure up_app_session_parms " + &
"  @user_id char(12) " + &
"as " + &
"DECLARE " + &
"  @version_count int, " + &
"  @version_id varchar(75), " + &
"  @committee_count int " + &
"  SELECT " + &
"    @version_id = version_id " + &
"  FROM " + &
"    sys_user_version " + &
"  WHERE user_id = @user_id " + &
"  SELECT @version_count = @@rowcount " + &
"  SELECT @committee_count = count(*) " + &
"  FROM " + &
"    committee_lookup " + &
"  WHERE " + &
"    facility_id = 1 " + &
"  SELECT " + &
"    dbms_version = convert(char(300), @@version), " + &
"    version_count = @version_count, " + &
"    version_id = @version_id, " + &
"    committee_count = @committee_count "

 is_sql_statements[UpperBound(is_sql_statements) + 1] = &
" grant execute on up_app_session_parms to public " 
//End Code Change ----03.14.2016


//EXPIRING CREDENTIALS
//Start Code Change ----04.18.2016 #V15 maha - for <RP>
//  3.29.2016 - Initial version by Ronnie Po
//  Re-create the logic in pfc_n_cst_ai_printletters.of_expiring_credentials()
//  NOTE: Pass @update_dt from the client to preserve existing functionality
/* Temp table for facility_ver_rules */
/* Temp table to create new verifications - records where verif_info.response_code is NOT NULL*/
/* Temp table to hold last seq_no per (rec_id, prac_id, facility_id) */
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'up_expiring_credentials' AND TYPE = 'P') " + &
" drop procedure up_expiring_credentials "
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"create procedure up_expiring_credentials " + &
"  @calling_user varchar(15),  " + &
"  @update_dt datetime,  " + &
"  @existing_verif_count int OUTPUT, " + &
"  @duplicate_verif_count int OUTPUT, " + &
"  @letter_count int OUTPUT, " + &
"  @psv_count int OUTPUT, " + &
"  @updated_count int OUTPUT, " + &
"  @fail_count int OUTPUT " + &
"as " + &
"create table #tmp_fvr ( " + &
"  facility_id smallint, " + &
"  screen_id int, " + &
"  exp_cred_que_letters_days int, " + &
"  exp_cred_notification_dt datetime, " + &
"  exp_options int) " + &
"create table #tmp_vi ( " + &
"    row_id int,  " + &
"    rec_id numeric(10, 0), " + &
"    prac_id numeric(6, 0),    " + &
"    facility_id int,    " + &
"    min_seq_no int,    " + &
"    min_doc_id varchar(40), " + &
"    existing_verification_flag char(1), " + &
"    next_seq_no int, " + &
"    exp_options int, " + &
"    /* Need source priority_user for new PSV */ " + &
"    priority_user varchar(10), " + &
"    new_doc_id varchar(40),  " + &
"    new_verif_exists_flag char(1), " + &
"    letter_psv_indc char(1)) " + &
"create table #tmp_seq ( " + &
"    rec_id numeric(10, 0), " + &
"    prac_id numeric(6, 0),    " + &
"    facility_id int,    " + &
"    max_seq_no int, " + &
"    primary key ( " + &
"      rec_id, " + &
"      prac_id, " + &
"      facility_id    )) " + &
"  DECLARE @VERIFICATION_METHOD_LETTER int " + &
"  SELECT " + &
"    @VERIFICATION_METHOD_LETTER = lookup_code " + &
"  FROM " + &
"    code_lookup " + &
"  WHERE " + &
"    ( lookup_name = 'verification method' ) and " + &
"    ( code = 'exp cred ltr' ) " + &
"DECLARE " + &
"  @curr_dt datetime " + &
"DECLARE " + &
"  @last_error int, " + &
"  @last_rowcount int, " + &
"  @row_id_count int " + &
"  SELECT @curr_dt = getdate() " + &
"  INSERT #tmp_fvr " + &
"  SELECT " + &
"    facility_id, " + &
"    screen_id, " + &
"    exp_cred_que_letters_days, " + &
"    dateadd(day, exp_cred_que_letters_days, @curr_dt), " + &
"    exp_options " + &
"  FROM " + &
"    facility_ver_rules " + &
"  WHERE " + &
"    exp_cred_que_letters_days > 0 " + &
"  INSERT #tmp_vi " + &
"  SELECT " + &
"    ROW_NUMBER() OVER ( " + &
"      ORDER BY " + &
"        verif_info.rec_id,    " + &
"        verif_info.prac_id,    " + &
"        verif_info.facility_id " + &
"    ), " + &
"    verif_info.rec_id,    " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id,    " + &
"    min(verif_info.seq_no),    " + &
"    min(verif_info.doc_id), " + &
"    'N', " + &
"    NULL, " + &
"    #tmp_fvr.exp_options, " + &
"    NULL, " + &
"    '',  " + &
"    'N', " + &
"    'L' " + &
"  FROM " + &
"    #tmp_fvr, " + &
"    data_view_screen,    " + &
"    verif_info   " + &
"  WHERE " + &
"    ( verif_info.active_status = 1 ) AND   " + &
"    ( verif_info.expiration_date <= #tmp_fvr.exp_cred_notification_dt ) AND   " + &
"    ( verif_info.exp_credential_flag <> 2 ) AND   " + &
"    ( verif_info.response_code is not NULL )  AND   " + &
"    ((verif_info.data_status = 1) OR   " + &
"    (verif_info.data_status is null)) AND   " + &
"    ( verif_info.facility_id = #tmp_fvr.facility_id ) and   " + &
"    ( verif_info.screen_id = #tmp_fvr.screen_id ) and   " + &
"    ( data_view_screen.data_view_id = 1) AND   " + &
"    ( data_view_screen.screen_id > 1 ) and  " + &
"    ( data_view_screen.screen_id = #tmp_fvr.screen_id ) " + &
"  GROUP BY " + &
"    verif_info.rec_id,    " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id, " + &
"    #tmp_fvr.exp_options " + &
"  SELECT @row_id_count = @@rowcount " + &
"  UPDATE #tmp_vi " + &
"  SET " + &
"    priority_user = verif_info.priority_user " + &
"  FROM " + &
"    verif_info " + &
"  WHERE " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) and " + &
"    ( verif_info.seq_no = #tmp_vi.min_seq_no ) and " + &
"    ( verif_info.doc_id = #tmp_vi.min_doc_id ) " + &
"  INSERT #tmp_seq " + &
"  SELECT " + &
"    verif_info.rec_id,    " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id,  " + &
"    max(verif_info.seq_no)  " + &
"  FROM " + &
"    #tmp_vi,  " + &
"    verif_info  " + &
"  WHERE " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) " + &
"  GROUP BY " + &
"    verif_info.rec_id,    " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id " + &
"  UPDATE #tmp_vi " + &
"  SET " + &
"    next_seq_no = #tmp_seq.max_seq_no + 1, " + &
"    new_doc_id = convert(varchar, #tmp_vi.rec_id) + '-' + convert(varchar, #tmp_vi.prac_id) + '-' + convert(varchar, #tmp_vi.facility_id) + '-' + convert(varchar, #tmp_seq.max_seq_no + 1) " + &
"  FROM " + &
"    #tmp_seq " + &
"  WHERE " + &
"    ( #tmp_seq.rec_id = #tmp_vi.rec_id ) and " + &
"    ( #tmp_seq.prac_id = #tmp_vi.prac_id ) and " + &
"    ( #tmp_seq.facility_id = #tmp_vi.facility_id )  " + &
"  UPDATE #tmp_vi " + &
"  SET " + &
"    existing_verification_flag = 'Y' " + &
"  FROM " + &
"    #tmp_fvr, " + &
"    data_view_screen,  " + &
"    verif_info " + &
"  WHERE " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and  " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) and  " + &
"    ( verif_info.active_status = 1 ) AND   " + &
"    ( verif_info.expiration_date <= #tmp_fvr.exp_cred_notification_dt ) AND   " + &
"    ( verif_info.exp_credential_flag < 2 ) AND   " + &
"    ( verif_info.response_code is NULL )  AND   " + &
"    ((verif_info.data_status = 1) OR   " + &
"    (verif_info.data_status is null)) AND   " + &
"    ( verif_info.facility_id = #tmp_fvr.facility_id ) and   " + &
"    ( verif_info.screen_id = #tmp_fvr.screen_id ) and   " + &
"    ( data_view_screen.data_view_id = 1) AND   " + &
"    ( data_view_screen.screen_id > 1 ) and  " + &
"    ( data_view_screen.screen_id = #tmp_fvr.screen_id )  " + &
"BEGIN TRANSACTION " + &
"  UPDATE " + &
"    verif_info " + &
"  SET " + &
"    exp_credential_flag = 2 " + &
"  FROM " + &
"    #tmp_vi " + &
"  WHERE " + &
"    ( #tmp_vi.existing_verification_flag = 'Y' ) and " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) and " + &
"    ( verif_info.seq_no = #tmp_vi.min_seq_no ) and " + &
"    ( verif_info.doc_id = #tmp_vi.min_doc_id ) and  " + &
"    ( verif_info.exp_credential_flag <> 2 ) " + &
"  SELECT " + &
"    @last_error = @@error, " + &
"    @last_rowcount = @@rowcount " + &
"  IF @last_error <> 0 GOTO return_error " + &
"  SELECT " + &
"    @existing_verif_count = @last_rowcount " + &
"  DELETE FROM " + &
"    #tmp_vi " + &
"  WHERE " + &
"    ( existing_verification_flag = 'Y' ) " + &
"  UPDATE " + &
"    verif_info " + &
"  SET " + &
"    exp_credential_flag = 2 " + &
"  FROM " + &
"    #tmp_vi " + &
"  WHERE " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) and " + &
"    ( " + &
"      ( verif_info.seq_no > #tmp_vi.min_seq_no ) OR " + &
"      ( verif_info.doc_id > #tmp_vi.min_doc_id )    ) " + &
"  SELECT " + &
"    @last_error = @@error, " + &
"    @last_rowcount = @@rowcount " + &
"  IF @last_error <> 0 GOTO return_error " + &
"  SELECT " + &
"    @duplicate_verif_count = @last_rowcount " + &
"  INSERT INTO verif_info ( " + &
"      rec_id,    " + &
"      prac_id,    " + &
"      facility_id,    " + &
"      seq_no,    " + &
"      screen_id,    " + &
"      first_sent,    " + &
"      last_sent,    " + &
"      number_sent,    " + &
"      date_recieved,    " + &
"      user_name,    " + &
"      source,    " + &
"      response_code,    " + &
"      active_status,    " + &
"      verification_method,    " + &
"      expiration_date,    " + &
"      verification_id,    " + &
"      reference_value,    " + &
"      address_lookup_code,    " + &
"      verifying_facility,    " + &
"      priority_user,    " + &
"      priority,    " + &
"      exp_credential_flag,    " + &
"      doc_id,    " + &
"      print_flag,    " + &
"      data_status,    " + &
"      create_date,    " + &
"      create_user,    " + &
"      mod_date,    " + &
"      mod_user  ) " + &
"  SELECT " + &
"      vi.rec_id,    " + &
"      vi.prac_id,    " + &
"      vi.facility_id,    " + &
"      #tmp_vi.next_seq_no,    " + &
"      vi.screen_id,    " + &
"      first_sent = NULL,    " + &
"      last_sent = NULL,    " + &
"      number_sent = 0,    " + &
"      date_received = NULL,    " + &
"      user_name = '',    " + &
"      vi.source,    " + &
"      response_code = NULL,    " + &
"      vi.active_status,    " + &
"      verification_method = CASE #tmp_vi.exp_options WHEN 1 THEN fvr.default_verif_means ELSE @VERIFICATION_METHOD_LETTER END,    " + &
"      vi.expiration_date,    " + &
"      vi.verification_id,    " + &
"      vi.reference_value,    " + &
"      vi.address_lookup_code,    " + &
"      vi.verifying_facility,    " + &
"      priority_user = CASE ltrim(rtrim(isNull(fvr.priority_user_exp, ''))) WHEN '' THEN 'PUBLIC' ELSE fvr.priority_user_exp END,    " + &
"      priority = isNull(fvr.priority_exp, 1),    " + &
"      exp_credential_flag = 1,    " + &
"      doc_id = convert(varchar, vi.rec_id) + '-' + convert(varchar, vi.prac_id) + '-' + convert(varchar, vi.facility_id) + '-' + convert(varchar, #tmp_vi.next_seq_no), " + &
"      print_flag = 1,    " + &
"      vi.data_status,    " + &
"      create_date = @update_dt,    " + &
"      create_user = @calling_user,    " + &
"      mod_date = NULL,    " + &
"      mod_user = '' " + &
"  FROM " + &
"      #tmp_vi, " + &
"      verif_info vi, " + &
"      facility_ver_rules fvr " + &
"  WHERE " + &
"      ( vi.rec_id = #tmp_vi.rec_id ) and " + &
"      ( vi.prac_id = #tmp_vi.prac_id ) and " + &
"      ( vi.facility_id = #tmp_vi.facility_id ) and " + &
"      ( vi.seq_no = #tmp_vi.min_seq_no ) and " + &
"      ( vi.doc_id = #tmp_vi.min_doc_id ) and " + &
"      ( fvr.facility_id = vi.facility_id ) and " + &
"      ( fvr.screen_id = vi.screen_id ) " + &
"  SELECT " + &
"    @last_error = @@error, " + &
"    @last_rowcount = @@rowcount " + &
"  IF @last_error <> 0 GOTO return_error " + &
"  SELECT @letter_count = @last_rowcount " + &
"  INSERT INTO verif_info ( " + &
"      rec_id,    " + &
"      prac_id,    " + &
"      facility_id,    " + &
"      seq_no,    " + &
"      screen_id,    " + &
"      first_sent,    " + &
"      last_sent,    " + &
"      number_sent,    " + &
"      date_recieved,    " + &
"      user_name,    " + &
"      source,    " + &
"      response_code,    " + &
"      active_status,    " + &
"      verification_method,    " + &
"      expiration_date,    " + &
"      verification_id,    " + &
"      reference_value,    " + &
"      address_lookup_code,    " + &
"      verifying_facility,    " + &
"      priority_user,    " + &
"      priority,    " + &
"      exp_credential_flag,    " + &
"      doc_id,    " + &
"      print_flag,    " + &
"      data_status,    " + &
"      create_date,    " + &
"      create_user,    " + &
"      mod_date,    " + &
"      mod_user  ) " + &
"  SELECT " + &
"      vi.rec_id,    " + &
"      vi.prac_id,    " + &
"      vi.facility_id,    " + &
"      #tmp_vi.next_seq_no + 1,    " + &
"      vi.screen_id,    " + &
"      first_sent = NULL,    " + &
"      last_sent = NULL,    " + &
"      number_sent = 0,    " + &
"      date_received = NULL,    " + &
"      user_name = '',    " + &
"      vi.source,    " + &
"      response_code = NULL,    " + &
"      vi.active_status,    " + &
"      verification_method = fvr.default_verif_means,    " + &
"      vi.expiration_date,    " + &
"      vi.verification_id,    " + &
"      vi.reference_value,    " + &
"      vi.address_lookup_code,    " + &
"      vi.verifying_facility,    " + &
"      priority_user = CASE ltrim(rtrim(isNull(#tmp_vi.priority_user, ''))) WHEN '' THEN 'PUBLIC' ELSE #tmp_vi.priority_user END,    " + &
"      priority = 3,    " + &
"      exp_credential_flag = 1,    " + &
"      doc_id = convert(varchar, vi.rec_id) + '-' + convert(varchar, vi.prac_id) + '-' + convert(varchar, vi.facility_id) + '-' + convert(varchar, #tmp_vi.next_seq_no + 1), " + &
"      print_flag = 1,    " + &
"      vi.data_status,    " + &
"      create_date = @update_dt,    " + &
"      create_user = @calling_user,    " + &
"      mod_date = NULL,    " + &
"      mod_user = '' " + &
"  FROM " + &
"      #tmp_vi, " + &
"      verif_info vi, " + &
"      facility_ver_rules fvr " + &
"  WHERE " + &
"      ( #tmp_vi.exp_options = 2 ) and  " + &
"      ( vi.rec_id = #tmp_vi.rec_id ) and " + &
"      ( vi.prac_id = #tmp_vi.prac_id ) and " + &
"      ( vi.facility_id = #tmp_vi.facility_id ) and " + &
"      ( vi.seq_no = #tmp_vi.next_seq_no ) and " + &
"      ( vi.doc_id = convert(varchar, vi.rec_id) + '-' + convert(varchar, vi.prac_id) + '-' + convert(varchar, vi.facility_id) + '-' + convert(varchar, #tmp_vi.next_seq_no) ) and " + &
"      ( fvr.facility_id = vi.facility_id ) and " + &
"      ( fvr.screen_id = vi.screen_id ) " + &
"  SELECT " + &
"    @last_error = @@error, " + &
"    @last_rowcount = @@rowcount " + &
"  IF @last_error <> 0 GOTO return_error " + &
"  SELECT @psv_count = @last_rowcount " + &
"  INSERT #tmp_vi " + &
"  SELECT " + &
"    @row_id_count + " + &
"    ROW_NUMBER() OVER ( " + &
"      ORDER BY " + &
"        ltr.rec_id, " + &
"        ltr.prac_id,    " + &
"        ltr.facility_id    ),  " + &
"    ltr.rec_id, " + &
"    ltr.prac_id,    " + &
"    ltr.facility_id,    " + &
"    ltr.min_seq_no,    " + &
"    ltr.min_doc_id, " + &
"    ltr.existing_verification_flag, " + &
"    ltr.next_seq_no + 1, " + &
"    ltr.exp_options, " + &
"    ltr.priority_user, " + &
"    convert(varchar, ltr.rec_id) + '-' + convert(varchar, ltr.prac_id) + '-' + convert(varchar, ltr.facility_id) + '-' + convert(varchar, ltr.next_seq_no + 1), " + &
"    ltr.new_verif_exists_flag, " + &
"    'P' " + &
"  FROM " + &
"    #tmp_vi ltr " + &
"  WHERE " + &
"    ( ltr.exp_options = 2 ) " + &
"  SELECT @row_id_count = @row_id_count + @@rowcount " + &
"  UPDATE #tmp_vi " + &
"  SET " + &
"    new_verif_exists_flag = 'Y' " + &
"  FROM " + &
"    verif_info " + &
"  WHERE " + &
"    ( verif_info.doc_id = #tmp_vi.new_doc_id ) " + &
"  UPDATE " + &
"    verif_info " + &
"  SET " + &
"    exp_credential_flag = 2 " + &
"  FROM " + &
"    #tmp_vi " + &
"  WHERE " + &
"    ( #tmp_vi.letter_psv_indc = 'L' ) and " + &
"    ( #tmp_vi.new_verif_exists_flag = 'Y' ) and  " + &
"    ( verif_info.rec_id = #tmp_vi.rec_id ) and " + &
"    ( verif_info.prac_id = #tmp_vi.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_vi.facility_id ) and " + &
"    ( verif_info.seq_no = #tmp_vi.min_seq_no ) and " + &
"    ( verif_info.doc_id = #tmp_vi.min_doc_id ) " + &
"  SELECT " + &
"    @last_error = @@error, " + &
"    @last_rowcount = @@rowcount " + &
"  IF @last_error <> 0 GOTO return_error " + &
"  SELECT " + &
"    @updated_count = @last_rowcount " + &
"  SELECT @fail_count = count(*) " + &
"  FROM " + &
"    #tmp_vi " + &
"  WHERE " + &
"    new_verif_exists_flag = 'N' " + &
"  COMMIT TRANSACTION " + &
"  RETURN " + &
"  return_error: " + &
"  ROLLBACK TRANSACTION " + &
"  SELECT " + &
"    @existing_verif_count = -1, " + &
"    @duplicate_verif_count = -1, " + &
"    @letter_count = -1, " + &
"    @psv_count = -1, " + &
"    @updated_count = -1 "


//EXPIRING APPOINTMENTS
//Start Code Change ----04.18.2016 #V15 maha - for <RP>
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if object_id('up_expiring_appointments') is not null " + &
"  drop procedure up_expiring_appointments "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"create procedure up_expiring_appointments " + &
"as " + &
"create table #tmp_f ( " + &
"  facility_id int, " + &
"  reappointment_query_days int,  " + &
"  reappointment_query_dt datetime, " + &
"  wf_expiring_appointment int,  " + &
"  wf_exp_appt char(1)) " + &
"create table #tmp_pda ( " + &
"  row_id int PRIMARY KEY IDENTITY,  " + &
"  rec_id numeric(10, 0), " + &
"  prac_id numeric(6, 0),  " + &
"  parent_facility_id int, " + &
"  apptmnt_end_date datetime, " + &
"  type_code char(2) /* AH = Allied Health, PR = Provisional, NA = Not Allied Health */) " + &
"create table #tmp_seq ( " + &
"  row_id int,  " + &
"  prac_id numeric(6, 0), " + &
"  facility_id int,  " + &
"  type_code char(2)) " + &
"create table #tmp_seq_row ( " + &
"  prac_id numeric(6, 0), " + &
"  facility_id int, " + &
"  min_row_id int) " + &
"create table #tmp_pf_seq ( " + &
"  prac_id numeric(6, 0), " + &
"  facility_id int, " + &
"  incr_seq_no int, " + &
"  type_code char(2)) " + &
"create table #tmp_last_seq ( " + &
"  prac_id numeric(6, 0), " + &
"  facility_id int, " + &
"  last_seq_no int) " + &
"create table #tmp_action ( " + &
"  prac_id numeric(6, 0),  " + &
"  rec_id numeric(10, 0), " + &
"  screen_id int, " + &
"  facility_id int, " + &
"  wf_id int) " + &
"  DECLARE " + &
"    @CODE_EXP_APPT_LETTER numeric(6, 0) " + &
"  SELECT " + &
"    @CODE_EXP_APPT_LETTER = lookup_code " + &
"  FROM " + &
"    code_lookup " + &
"  WHERE " + &
"    ( lookup_name = 'verification method' ) and " + &
"    ( code = 'EXP APPT LTR' ) " + &
"  DECLARE @workflow_setting int " + &
"  SELECT " + &
"    @workflow_setting = isNull(set_47, 0) " + &
"  FROM " + &
"    icred_settings " + &
"DECLARE " + &
"  @num_rows int, " + &
"  @next_rec_id numeric(10, 0)  " + &
"DECLARE " + &
"  @last_rowcount int, " + &
"  @last_error int " + &
"DECLARE " + &
"  @curr_dt datetime " + &
"  SELECT	 " + &
"    @curr_dt = getdate() " + &
"  INSERT #tmp_f " + &
"  SELECT " + &
"    facility_id, " + &
"    reappointment_query_days, " + &
"    dateadd(day, reappointment_query_days, @curr_dt), " + &
"    wf_expiring_appointment, " + &
"    CASE @workflow_setting WHEN 1 THEN isNull(wf_exp_appt, 'N') ELSE 'N' END " + &
"  FROM " + &
"    facility " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date,    " + &
"    pd_affil_stat.verifying_facility, " + &
"    pd_affil_stat.apptmnt_end_date   " + &
"  FROM " + &
"    #tmp_f,  " + &
"    pd_affil_stat,    " + &
"    code_lookup,    " + &
"    pd_basic   " + &
"  WHERE " + &
"    ( pd_affil_stat.parent_facility_id = #tmp_f.facility_id ) and   " + &
"    ( pd_affil_stat.prac_id = pd_basic.prac_id ) and   " + &
"    ( pd_basic.prac_category = code_lookup.lookup_code ) and   " + &
"    (  pd_affil_stat.active_status = 1 ) AND " + &
"    ( upper(code_lookup.custom_6) = 'AH') and " + &
"    ( pd_affil_stat.apptmnt_end_date <= #tmp_f.reappointment_query_dt ) AND  " + &
"    ( #tmp_f.reappointment_query_days > 0 ) and  " + &
"    ( pd_affil_stat.prac_id not in ( " + &
"      SELECT DISTINCT " + &
"        verif_info.prac_id " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        ( verif_info.reference_value IN ( 'Expiring Appointment Letter', 'Expiring Allied Health Letter', 'Expiring Provisional Letter' ) ) and " + &
"        ( verif_info.active_status = 1 ) and " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id ) )    ) " + &
"  INSERT #tmp_pda (rec_id, prac_id, parent_facility_id, apptmnt_end_date, type_code) " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date, " + &
"    'AH' " + &
"  FROM " + &
"    #tmp_f,  " + &
"    pd_affil_stat,    " + &
"    code_lookup,    " + &
"    pd_basic   " + &
"  WHERE " + &
"    ( pd_affil_stat.parent_facility_id = #tmp_f.facility_id ) and   " + &
"    ( pd_affil_stat.prac_id = pd_basic.prac_id ) and   " + &
"    ( pd_basic.prac_category = code_lookup.lookup_code ) and   " + &
"    (  pd_affil_stat.active_status = 1 ) AND " + &
"    ( upper(code_lookup.custom_6) = 'AH') and " + &
"    ( pd_affil_stat.apptmnt_end_date <= #tmp_f.reappointment_query_dt ) AND  " + &
"    ( #tmp_f.reappointment_query_days > 0 ) AND " + &
"    NOT EXISTS ( " + &
"      SELECT * " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        ( verif_info.prac_id = pd_affil_stat.prac_id ) and  " + &
"        ( verif_info.reference_value IN ( 'Expiring Appointment Letter', 'Expiring Allied Health Letter', 'Expiring Provisional Letter' ) ) and " + &
"        ( verif_info.active_status = 1 ) and " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id )       ) " + &
"  SELECT @last_rowcount = @@rowcount " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date,    " + &
"    pd_affil_stat.verifying_facility,    " + &
"    pd_affil_stat.prov_status,    " + &
"    pd_affil_stat.init_prov_period_to ,  " + &
"    pd_affil_stat.apptmnt_end_date " + &
"  FROM " + &
"    pd_affil_stat,    " + &
"    facility   " + &
"  WHERE " + &
"    ( facility.facility_id = pd_affil_stat.parent_facility_id ) and   " + &
"    ( ( pd_affil_stat.active_status = 1 ) AND  " + &
"    ( pd_affil_stat.prov_status = 1 ) AND " + &
"    ( pd_affil_stat.init_prov_period_to <= getdate() + facility.reappointment_query_days ) AND   " + &
"    ( pd_affil_stat.prac_id not in ( " + &
"      SELECT DISTINCT " + &
"        verif_info.prac_id " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        ( verif_info.reference_value IN ('Expiring Appointment Letter', 'Expiring Allied Health Letter', 'Expiring Provisional Letter' ) ) and " + &
"        ( verif_info.active_status = 1 ) and  " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id )      )   )   ) " + &
"  INSERT #tmp_pda (rec_id, prac_id, parent_facility_id, apptmnt_end_date, type_code) " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date,    " + &
"    'PR' " + &
"  FROM " + &
"    pd_affil_stat,    " + &
"    #tmp_f   " + &
"  WHERE " + &
"    ( #tmp_f.facility_id = pd_affil_stat.parent_facility_id ) and   " + &
"    ( pd_affil_stat.active_status = 1 ) AND  " + &
"    ( pd_affil_stat.prov_status = 1 ) AND " + &
"    ( pd_affil_stat.init_prov_period_to <= #tmp_f.reappointment_query_dt ) AND   " + &
"    NOT EXISTS ( " + &
"      SELECT * " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        ( verif_info.prac_id = pd_affil_stat.prac_id ) and  " + &
"        ( verif_info.reference_value IN ('Expiring Appointment Letter', 'Expiring Allied Health Letter', 'Expiring Provisional Letter' ) ) and " + &
"        ( verif_info.active_status = 1 ) and  " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id )    ) " + &
"  SELECT @last_rowcount = @last_rowcount + @@rowcount " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date,    " + &
"    pd_affil_stat.verifying_facility, " + &
"    pd_affil_stat.apptmnt_end_date   " + &
"  FROM " + &
"    pd_affil_stat  LEFT OUTER JOIN verif_info  ON pd_affil_stat.prac_id = verif_info.prac_id,  " + &
"    pd_basic  LEFT OUTER JOIN code_lookup  ON pd_basic.prac_category = code_lookup.lookup_code,    " + &
"    facility   " + &
"  WHERE " + &
"    ( facility.facility_id = pd_affil_stat.parent_facility_id ) and   " + &
"    ( pd_affil_stat.prac_id = pd_basic.prac_id ) and   " + &
"    ( pd_affil_stat.active_status = 1 ) AND   " + &
"    ( ( code_lookup.custom_6 <> 'AH' )  or (code_lookup.custom_6 is null) ) and " + &
"    ( pd_affil_stat.prov_status <> 1 )  and " + &
"    ( pd_affil_stat.apptmnt_end_date <= getdate() + facility.reappointment_query_days ) AND " + &
"    ( facility.reappointment_query_days > 0 ) and  " + &
"    ( pd_affil_stat.prac_id not in ( " + &
"      SELECT DISTINCT " + &
"        verif_info.prac_id " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        (verif_info.reference_value = 'Expiring Appointment Letter' or verif_info.reference_value = 'Expiring Allied Health Letter' or verif_info.reference_value = 'Expiring Provisional Letter') and " + &
"        ( active_status = 1 ) and  " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id )      )     ) " + &
"  INSERT #tmp_pda (rec_id, prac_id, parent_facility_id, apptmnt_end_date, type_code) " + &
"  SELECT DISTINCT " + &
"    pd_affil_stat.rec_id,    " + &
"    pd_affil_stat.prac_id,    " + &
"    pd_affil_stat.parent_facility_id,    " + &
"    pd_affil_stat.apptmnt_end_date,    " + &
"    'NA' " + &
"  FROM " + &
"    pd_affil_stat  LEFT OUTER JOIN verif_info  ON pd_affil_stat.prac_id = verif_info.prac_id,  " + &
"    pd_basic  LEFT OUTER JOIN code_lookup  ON ( " + &
"      pd_basic.prac_category = code_lookup.lookup_code  ),    " + &
"    #tmp_f   " + &
"  WHERE " + &
"    ( #tmp_f.facility_id = pd_affil_stat.parent_facility_id ) and   " + &
"    ( pd_affil_stat.prac_id = pd_basic.prac_id ) and   " + &
"    ( pd_affil_stat.active_status = 1 ) AND   " + &
"    ( pd_affil_stat.prov_status <> 1 )  and " + &
"    ( isNull(code_lookup.custom_6, 'ZZ') <> 'AH' ) and " + &
"    ( pd_affil_stat.apptmnt_end_date <= #tmp_f.reappointment_query_dt ) AND " + &
"    ( #tmp_f.reappointment_query_days > 0 ) and  " + &
"    NOT EXISTS ( " + &
"      SELECT * " + &
"      FROM " + &
"        verif_info " + &
"      WHERE " + &
"        ( verif_info.prac_id = pd_affil_stat.prac_id ) and  " + &
"        ( verif_info.reference_value IN ('Expiring Appointment Letter', 'Expiring Allied Health Letter', 'Expiring Provisional Letter' ) ) and " + &
"        ( verif_info.active_status = 1 ) and  " + &
"        ( verif_info.facility_id = pd_affil_stat.parent_facility_id )    ) " + &
"  INSERT #tmp_seq " + &
"  SELECT " + &
"    ROW_NUMBER() OVER ( " + &
"      ORDER BY " + &
"        rec_id, " + &
"        prac_id, " + &
"        parent_facility_id, type_code     ), " + &
"    prac_id, " + &
"    parent_facility_id,  " + &
"    type_code " + &
"  FROM " + &
"    #tmp_pda " + &
"  ORDER BY " + &
"    rec_id, " + &
"    prac_id, " + &
"    parent_facility_id, " + &
"    type_code " + &
"  INSERT #tmp_seq_row " + &
"  SELECT " + &
"    prac_id, " + &
"    facility_id, " + &
"    min(row_id) " + &
"  FROM " + &
"    #tmp_seq " + &
"  GROUP BY " + &
"    prac_id, " + &
"    facility_id " + &
"  INSERT #tmp_pf_seq " + &
"  SELECT " + &
"    #tmp_seq.prac_id, " + &
"    #tmp_seq.facility_id, " + &
"    #tmp_seq.row_id - #tmp_seq_row.min_row_id + 1, " + &
"    #tmp_seq.type_code " + &
"  FROM " + &
"    #tmp_seq, " + &
"    #tmp_seq_row " + &
"  WHERE " + &
"    ( #tmp_seq_row.prac_id = #tmp_seq.prac_id ) and " + &
"    ( #tmp_seq_row.facility_id = #tmp_seq.facility_id ) " + &
"  INSERT #tmp_last_seq " + &
"  SELECT " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id,  " + &
"    last_seq_no = max(verif_info.seq_no)  " + &
"  FROM " + &
"    #tmp_pda,  " + &
"    verif_info " + &
"  WHERE " + &
"    ( verif_info.prac_id = #tmp_pda.prac_id ) and " + &
"    ( verif_info.facility_id = #tmp_pda.parent_facility_id ) and " + &
"    ( verif_info.verification_method = @CODE_EXP_APPT_LETTER ) " + &
"  GROUP BY " + &
"    verif_info.prac_id,    " + &
"    verif_info.facility_id " + &
"  SELECT @num_rows = count(*) " + &
"  FROM " + &
"    #tmp_pda " + &
"IF @num_rows < 1 RETURN " + &
"  UPDATE " + &
"    ids " + &
"  SET " + &
"    record_id = isNull(record_id, 0) + @num_rows " + &
" " + &
"  SELECT " + &
"    @next_rec_id = record_id - @num_rows " + &
"  FROM " + &
"    ids " + &
"  INSERT INTO verif_info ( " + &
"    rec_id, " + &
"    reference_value, " + &
"    prac_id, " + &
"    facility_id, " + &
"    direct_parent_facility_link, " + &
"    seq_no, " + &
"    screen_id,  " + &
"    verification_method,  " + &
"    priority_user, " + &
"    priority, " + &
"    active_status, " + &
"    exp_credential_flag, " + &
"    print_flag, " + &
"	doc_id, " + &
"    expiration_date, " + &
"    create_date, " + &
"    create_user ) " + &
"  SELECT " + &
"    rec_id = @next_rec_id + #tmp_pda.row_id - 1,  " + &
"    reference_value = " + &
"      CASE #tmp_pda.type_code " + &
"        WHEN 'AH' THEN 'Expiring Allied Health Letter' " + &
"        WHEN 'PR' THEN 'Expiring Provisional Letter' " + &
"        ELSE 'Expiring Appointment Letter' " + &
"      END,  " + &
"    #tmp_pda.prac_id,  " + &
"    #tmp_pda.parent_facility_id,  " + &
"    direct_parent_facility_link = #tmp_pda.parent_facility_id,  " + &
"    seq_no = isNull(#tmp_last_seq.last_seq_no, 0) + #tmp_pf_seq.incr_seq_no,  " + &
"    screen_id = 1,  " + &
"    verification_method = @CODE_EXP_APPT_LETTER,  " + &
"    priority_user= 'Public',  " + &
"    priority= 2,  " + &
"    active_status= 1,  " + &
"    exp_credential_flag = 1,  " + &
"    print_flag = 1,  " + &
"    doc_id = " + &
"      convert(varchar, @next_rec_id + #tmp_pda.row_id - 1) + '-' " + &
"      + convert(varchar, #tmp_pda.prac_id) + '-' " + &
"      + convert(varchar, #tmp_pda.parent_facility_id) + '-' " + &
"      + convert(varchar, isNull(#tmp_last_seq.last_seq_no, 0) + #tmp_pf_seq.incr_seq_no),  " + &
"    expiration_date = #tmp_pda.apptmnt_end_date,  " + &
"    create_date = getdate(),  " + &
"    create_user = 'Sys-AIQ' " + &
"  FROM " + &
"    #tmp_pda JOIN #tmp_pf_seq ON ( " + &
"      ( #tmp_pda.prac_id = #tmp_pf_seq.prac_id ) and " + &
"      ( #tmp_pda.parent_facility_id = #tmp_pf_seq.facility_id )   and " + &
"      ( #tmp_pda.type_code = #tmp_pf_seq.type_code )) " + &
"    LEFT OUTER JOIN #tmp_last_seq ON ( " + &
"      ( #tmp_pda.prac_id = #tmp_last_seq.prac_id ) and  " + &
"      ( #tmp_pda.parent_facility_id = #tmp_last_seq.facility_id )    ) " + &
"IF @workflow_setting = 1 " + &
"  INSERT #tmp_action " + &
"  SELECT " + &
"    #tmp_pda.prac_id,  " + &
"    rec_id = @next_rec_id + #tmp_pda.row_id - 1,  " + &
"    screen_id = -10,  " + &
"    #tmp_pda.parent_facility_id,  " + &
"    #tmp_f.wf_expiring_appointment " + &
"  FROM " + &
"    #tmp_f JOIN #tmp_pda ON ( #tmp_f.facility_id = #tmp_pda.parent_facility_id ) " + &
"    JOIN #tmp_pf_seq ON ( " + &
"      ( #tmp_pda.prac_id = #tmp_pf_seq.prac_id ) and " + &
"      ( #tmp_pda.parent_facility_id = #tmp_pf_seq.facility_id )   and " + &
"      ( #tmp_pda.type_code = #tmp_pf_seq.type_code )) " + &
"    LEFT OUTER JOIN #tmp_last_seq ON ( " + &
"      ( #tmp_pda.prac_id = #tmp_last_seq.prac_id ) and  " + &
"      ( #tmp_pda.parent_facility_id = #tmp_last_seq.facility_id )    ) " + &
"    WHERE " + &
"      ( #tmp_f.wf_expiring_appointment > 0 ) " + &
"  SELECT " + &
"    prac_id,  " + &
"    rec_id, " + &
"    screen_id, " + &
"    facility_id, " + &
"    wf_id " + &
"  FROM " + &
"    #tmp_action "


//RESEND LETTERS
//Start Code Change ----04.18.2016 #V15 maha - for <RP>
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if object_id('up_resend_letters') is not null " + &
"  drop procedure up_resend_letters "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"create procedure up_resend_letters " + &
"as " + &
"create table #tmp_fvr ( " + &
"  facility_id smallint, " + &
"  screen_id int, " + &
"  ver_letter_max_sends int,  " + &
"  ver_letter_resend_days int,  " + &
"  ver_letter_resend_dt datetime) " + &
" " + &
"DECLARE " + &
"  @curr_dt datetime " + &
"  SELECT	 " + &
"    @curr_dt = getdate() " + &
"  create table #tmp_wfa ( " + &
"    wf_id int, " + &
"    step_id int, " + &
"    action_status_id numeric(6, 0), " + &
"    resend_times int, " + &
"    day_interval int, " + &
"    interval_dt datetime) " + &
"  INSERT #tmp_fvr " + &
"  SELECT " + &
"    facility_id, " + &
"    screen_id, " + &
"    ver_letter_max_sends, " + &
"    ver_letter_resend_days,  " + &
"    dateadd(day, -1 * ver_letter_resend_days, @curr_dt) " + &
"  FROM " + &
"    facility_ver_rules " + &
"  INSERT #tmp_wfa " + &
"  SELECT " + &
"    wf_id, " + &
"    step_id, " + &
"    action_status_id, " + &
"    resend_times, " + &
"    day_interval,  " + &
"    dateadd(day, -1 * day_interval, @curr_dt) " + &
"  FROM " + &
"    wf_action_status " + &
"  WHERE " + &
"    ( process_flag = 1 ) and " + &
"    ( letter_id is not null )  " + &
"  UPDATE " + &
"    verif_info " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_fvr " + &
"  WHERE " + &
"    ( verif_info.screen_id = #tmp_fvr.screen_id ) and " + &
"    ( verif_info.facility_id = #tmp_fvr.facility_id ) and " + &
"    ( verif_info.response_code IS NULL ) and " + &
"    ( verif_info.print_flag = 0 ) and " + &
"    ( isNull(verif_info.number_sent, 0) < #tmp_fvr.ver_letter_max_sends ) and " + &
"    ( verif_info.last_sent <= #tmp_fvr.ver_letter_resend_dt ) and " + &
"    ( verif_info.verification_method <> 17 ) and " + &
"    ( verif_info.wf_id IS NULL ) " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating verif_info based on resend interval. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " + &
"  UPDATE " + &
"    verif_info " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_wfa " + &
"  WHERE " + &
"    ( verif_info.wf_id = #tmp_wfa.wf_id ) and   " + &
"    ( verif_info.wf_action_type_id = #tmp_wfa.step_id ) and   " + &
"    ( verif_info.response_code = #tmp_wfa.action_status_id ) and   " + &
"    ( verif_info.print_flag <= 0 ) and " + &
"    ( isnull(verif_info.number_sent,0) < #tmp_wfa.resend_times) and " + &
"    ( verif_info.last_sent <= #tmp_wfa.interval_dt )    " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating verif_info based on wf_action_status interval. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " + &
"  UPDATE " + &
"    net_dev_action_items " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_wfa " + &
"  WHERE " + &
"    ( net_dev_action_items.wf_id = #tmp_wfa.wf_id ) and " + &
"    ( net_dev_action_items.wf_action_type_id = #tmp_wfa.step_id ) and " + &
"    ( net_dev_action_items.action_status = #tmp_wfa.action_status_id ) and " + &
"    ( net_dev_action_items.print_flag <= 0 ) AND " + &
"    ( isnull(net_dev_action_items.number_sent,0) < #tmp_wfa.resend_times) AND   " + &
"    ( " + &
"      ( net_dev_action_items.last_sent <= #tmp_wfa.interval_dt ) or " + &
"      ( net_dev_action_items.last_sent IS NULL )    ) " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating net_dev_action_items. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " + &
"  UPDATE " + &
"    ctx_action_items " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_wfa " + &
"  WHERE " + &
"    ( ctx_action_items.wf_id = #tmp_wfa.wf_id ) and   " + &
"    ( ctx_action_items.wf_action_type_id = #tmp_wfa.step_id ) and   " + &
"    ( ctx_action_items.action_status = #tmp_wfa.action_status_id ) and   " + &
"    ( ctx_action_items.print_flag <= 0 ) AND " + &
"    ( isnull(ctx_action_items.no_attempts,0) < #tmp_wfa.resend_times) AND   " + &
"    ( " + &
"      ( ctx_action_items.last_attempt <= #tmp_wfa.interval_dt ) OR " + &
"      ( ctx_action_items.last_attempt is null )   ) " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating ctx_action_items. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " + &
"  UPDATE " + &
"    ctx_am_action_item " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_wfa " + &
"  WHERE " + &
"    ( ctx_am_action_item.wf_id = #tmp_wfa.wf_id ) and   " + &
"    ( ctx_am_action_item.wf_action_type_id = #tmp_wfa.step_id ) and   " + &
"    ( ctx_am_action_item.action_status = #tmp_wfa.action_status_id ) and   " + &
"    ( ctx_am_action_item.print_flag <= 0 ) AND " + &
"    ( isnull(ctx_am_action_item.attempt_times,0) < #tmp_wfa.resend_times) AND   " + &
"    ( " + &
"      ( ctx_am_action_item.last_attempt <= #tmp_wfa.interval_dt ) OR " + &
"      ( ctx_am_action_item.last_attempt is null )   ) " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating ctx_am_action_item. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " + &
"  DELETE FROM #tmp_fvr " + &
"  INSERT #tmp_fvr " + &
"  SELECT " + &
"    facility_id, " + &
"    screen_id, " + &
"    ver_letter_max_sends, " + &
"    ver_letter_resend_days,  " + &
"    dateadd(day, -1 * ver_letter_resend_days, @curr_dt) " + &
"  FROM " + &
"    facility_ver_rules " + &
"  WHERE " + &
"    screen_id = 1 " + &
"  UPDATE " + &
"    pd_process_actions " + &
"  SET " + &
"    print_flag = 1 " + &
"  FROM " + &
"    #tmp_fvr,    " + &
"    facility,  " + &
"    pd_affil_stat,    " + &
"    v_full_name,    " + &
"    pd_oppe_hrd " + &
"  WHERE " + &
"    ( pd_process_actions.facility_id = facility.facility_id ) and   " + &
"    ( pd_affil_stat.parent_facility_id = pd_process_actions.facility_id ) and   " + &
"    ( pd_affil_stat.prac_id = pd_process_actions.prac_id ) and   " + &
"    ( pd_process_actions.prac_id = v_full_name.prac_id ) and   " + &
"    ( pd_oppe_hrd.pd_oppe_hdr_id = pd_process_actions.function_id ) and   " + &
"    ( pd_oppe_hrd.facility_id = #tmp_fvr.facility_id ) and   " + &
"    ( ( pd_affil_stat.active_status in (1,4) ) AND   " + &
"    ( pd_process_actions.active_status = 1 ) AND   " + &
"    ( pd_process_actions.response_code is null ) AND   " + &
"    ( pd_process_actions.function_type in (2,3) ) AND   " + &
"    ( pd_process_actions.print_flag = 0 ) AND   " + &
"    (  pd_process_actions.last_sent <= #tmp_fvr.ver_letter_resend_dt ) )     " + &
"IF @@error <> 0 BEGIN " + &
"  RAISERROR ('An error occurred while updating pd_process_actions. Unable to resend letters.', 16, 1) " + &
"  RETURN " + &
"END " 

//Start Code Change ----04.26.2016 #V15 maha - ai graph last attempt
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if object_id('up_verification_graph_by_last_attemp') is not null " + &
"  drop procedure up_verification_graph_by_last_attemp "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"create procedure up_verification_graph_by_last_attemp " + &
"  @calling_user_id varchar(10) = NULL, " + &
"  @parent_facility_id int = NULL, " + &
"  @priority_user_id varchar(10) = NULL, " + &
"  @apptmnt_status varchar(1) = NULL, " + &
"  @screen_id int = NULL, " + &
"  @batch_id int = NULL " + &
"as " + &
"create table #tmp_ver(  " + &
"  verif_count int, " + &
"  code_lookup_code varchar(30), " + &
"  cdays_to_exp varchar(17)) " + &
"DECLARE @sql_text varchar(2000) " + &
"  SELECT " + &
"    @sql_text =  " + &
"  'INSERT #tmp_ver " + &
"  SELECT " + &
"    verif_count =  count(distinct verif_info.doc_id), " + &
"    code_lookup.code, " + &
"    cdays_to_exp = convert(varchar(17),  " + &
"      CASE verif_info.print_flag " + &
"        WHEN 0 THEN ''Awaiting Response'' " + &
"        ELSE '' Need Processed'' " + &
"      END   ) " + &
"  FROM " + &
"    code_lookup, " + &
"    data_view_screen, " + &
"    verif_info , " + &
"    pd_affil_stat'  + " + &
"  CASE WHEN ltrim(rtrim(isNull(@calling_user_id, ''))) = '' THEN '' " + &
"    ELSE ', " + &
"    security_user_facilities' " + &
"  END  + " + &
"  CASE WHEN isNull(@batch_id, 0) <= 0 THEN '' " + &
"    ELSE ', " + &
"    sys_batch_items' " + &
"  END  + ' " + &
"  WHERE " + &
"    ( verif_info.active_status = 1 ) and " + &
"    ( verif_info.response_code IS NULL)'  + " + &
"  CASE WHEN ltrim(rtrim(isNull(@calling_user_id, ''))) = '' THEN '' " + &
"    ELSE ' and " + &
"    ( security_user_facilities.access_rights = 1 ) and " + &
"    ( security_user_facilities.user_id = ''' + @calling_user_id + ''' ) and " + &
"    ( security_user_facilities.facility_id = pd_affil_stat.parent_facility_id )' " + &
"  END  + " + &
"  CASE WHEN isNull(@batch_id, 0) <= 0 THEN '' " + &
"    ELSE ' and " + &
"    ( sys_batch_items.batch_id = ' + convert(varchar, @batch_id) + ' ) and " + &
"    ( verif_info.prac_id = sys_batch_items.prac_id )' " + &
"  END  + " + &
"  CASE WHEN isNull(@parent_facility_id, 0) = 0 THEN '' " + &
"    ELSE ' and " + &
"    ( pd_affil_stat.parent_facility_id = ' + convert(varchar, @parent_facility_id) + ' )' " + &
"  END  + " + &
"  CASE WHEN ltrim(rtrim(isNull(@priority_user_id, 'All'))) = 'All' THEN '' " + &
"    ELSE ' and " + &
"    ( verif_info.priority_user = ''' + @priority_user_id + ''' )' " + &
"  END  + " + &
"  CASE WHEN isNull(@apptmnt_status, '') IN ('1', '2', '6') " + &
"    THEN ' and " + &
"    ( pd_affil_stat.apptmnt_type = ''' + CASE @apptmnt_status WHEN '1' THEN 'I' WHEN '2' THEN 'R' WHEN '6' THEN 'M' END + ''' )' " + &
"    ELSE '' " + &
"  END  +' and " + &
"    ( pd_affil_stat.active_status IN (1, 4) ) and " + &
"    ( data_view_screen.data_view_id = 1 )'  + " + &
"  CASE WHEN isNull(@screen_id, 0) <= 0 THEN '' " + &
"    ELSE ' and  " + &
"    ( data_view_screen.screen_id = ' + convert(varchar, @screen_id) + ' )' " + &
"  END  + ' and " + &
"    ( verif_info.screen_id = data_view_screen.screen_id ) and  " + &
"    ( verif_info.facility_id = pd_affil_stat.verifying_facility and data_view_screen.screen_id <> 1 or verif_info.facility_id = pd_affil_stat.parent_facility_id and data_view_screen.screen_id = 1) and  " + &
"    ( verif_info.prac_id = pd_affil_stat.prac_id ) and " + &
"    ( verif_info.verification_method = code_lookup.lookup_code ) " + &
"  GROUP BY " + &
"    code_lookup.code, " + &
"    verif_info.print_flag' " + &
"  EXECUTE (@sql_text) " + &
"  SELECT " + &
"    verif_count,  " + &
"    code_lookup_code,  " + &
"    cdays_to_exp  " + &
"  FROM " + &
"    #tmp_ver " + &
"  ORDER BY " + &
"    code_lookup_code,  " + &
"    cdays_to_exp " 

//Start Code Change ----04.26.2016 #V15 maha - ai graph all attempts
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if object_id('up_verification_graph_by_total_attemp') is not null " + &
"  drop procedure up_verification_graph_by_total_attemp"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"create procedure up_verification_graph_by_total_attemp " + &
"  @calling_user_id varchar(10) = NULL,  " + &
"  @parent_facility_id int = NULL, " + &
"  @priority_user_id varchar(10) = NULL, " + &
"  @apptmnt_status varchar(1) = NULL, " + &
"  @screen_id int = NULL, " + &
"  @batch_id int = NULL " + &
"as " + &
"create table #tmp_prac_verif ( " + &
"  verif_count int,  " + &
"  prac_id int,  " + &
"  code_lookup_code varchar(30),  " + &
"  number_sent int ) " + &
"create index ix_tmp_prac_verif_prac_id on #tmp_prac_verif ( " + &
"  prac_id) " + &
"create table #tmp_verif ( " + &
"  verif_count int,  " + &
"  code_lookup_code varchar(30),  " + &
"  number_sent int ) " + &
"DECLARE @sql_text varchar(2000) " + &
"IF isNull(@batch_id, 0) > 0 BEGIN " + &
"  SELECT @sql_text =  " + &
"'  INSERT #tmp_prac_verif " + &
"  SELECT " + &
"    verif_count = count(distinct verif_info.doc_id),   " + &
"    verif_info.prac_id,  " + &
"    code_lookup.code,  " + &
"    verif_info.number_sent   " + &
"  FROM " + &
"    verif_info,    " + &
"    code_lookup,  " + &
"    pd_affil_stat,  " + &
"    security_user_facilities " + &
"  WHERE " + &
"    ( verif_info.active_status = 1) and  " + &
"    ( verif_info.date_recieved is NULL ) and " + &
"    ( code_lookup.lookup_code = verif_info.verification_method ) and  " + &
"    ( pd_affil_stat.verifying_facility = verif_info.facility_id ) and " + &
"    ( security_user_facilities.access_rights = 1 ) and  " + &
"    ( security_user_facilities.facility_id = pd_affil_stat.parent_facility_id ) and  " + &
"    ( security_user_facilities.user_id = ''' + @calling_user_id + ''' )'  + " + &
"  CASE WHEN isNull(@parent_facility_id, 0) = 0 THEN '' " + &
"    ELSE ' and " + &
"    ( verif_info.facility_id = ' + convert(varchar, @parent_facility_id) + ' )' " + &
"  END  + " + &
"  CASE WHEN ltrim(rtrim(isNull(@priority_user_id, 'All'))) = 'All' THEN '' " + &
"    ELSE ' and " + &
"    ( verif_info.priority_user = ''' + @priority_user_id + ''' )' " + &
"  END  + " + &
"  CASE WHEN isNull(@apptmnt_status, '') IN ('1', '2', '6') " + &
"    THEN ' and " + &
"    ( pd_affil_stat.apptmnt_type = ''' + CASE @apptmnt_status WHEN '1' THEN 'I' WHEN '2' THEN 'R' WHEN '6' THEN 'M' END + ''' )' " + &
"    ELSE '' " + &
"  END  + " + &
"  CASE WHEN isNull(@screen_id, 0) <= 0 THEN '' " + &
"    ELSE ' and  " + &
"    ( verif_info.screen_id = ' + convert(varchar, @screen_id) + ' )' " + &
"  END  +' " + &
"  GROUP BY " + &
"    verif_info.prac_id, " + &
"    code_lookup.code,  " + &
"    verif_info.number_sent' " + &
"  EXECUTE (@sql_text) " + &
"  INSERT #tmp_verif " + &
"  SELECT " + &
"    sum(#tmp_prac_verif.verif_count), " + &
"    #tmp_prac_verif.code_lookup_code, " + &
"    #tmp_prac_verif.number_sent " + &
"  FROM " + &
"    sys_batch_items, " + &
"    #tmp_prac_verif " + &
"  WHERE " + &
"    ( sys_batch_items.batch_id = @batch_id ) and " + &
"    ( #tmp_prac_verif.prac_id = sys_batch_items.prac_id ) " + &
"  GROUP BY " + &
"    #tmp_prac_verif.code_lookup_code, " + &
"    #tmp_prac_verif.number_sent " + &
"  GOTO result_set " + &
"END " + &
"  SELECT @sql_text =  " + &
"'  INSERT #tmp_verif " + &
"  SELECT " + &
"    verif_count = count(distinct verif_info.doc_id),    " + &
"    code_lookup.code,  " + &
"    verif_info.number_sent   " + &
"  FROM " + &
"    verif_info,    " + &
"    code_lookup,  " + &
"    pd_affil_stat,  " + &
"    security_user_facilities' + " + &
"  CASE WHEN isNull(@batch_id, 0) <= 0 THEN '' " + &
"    ELSE ', " + &
"    sys_batch_items' " + &
"  END  +' " + &
"  WHERE " + &
"    ( verif_info.active_status = 1) and  " + &
"    ( verif_info.date_recieved is NULL ) and " + &
"    ( code_lookup.lookup_code = verif_info.verification_method ) and  " + &
"    ( pd_affil_stat.verifying_facility = verif_info.facility_id ) and " + &
"    ( security_user_facilities.access_rights = 1 ) and  " + &
"    ( security_user_facilities.facility_id = pd_affil_stat.parent_facility_id ) and  " + &
"    ( security_user_facilities.user_id = ''' + @calling_user_id + ''' )'  + " + &
"  CASE WHEN isNull(@parent_facility_id, 0) = 0 THEN '' " + &
"    ELSE ' and " + &
"    ( verif_info.facility_id = ' + convert(varchar, @parent_facility_id) + ' )' " + &
"  END  + " + &
"  CASE WHEN ltrim(rtrim(isNull(@priority_user_id, 'All'))) = 'All' THEN '' " + &
"    ELSE ' and " + &
"    ( verif_info.priority_user = ''' + @priority_user_id + ''' )' " + &
"  END  + " + &
"  CASE WHEN isNull(@apptmnt_status, '') IN ('1', '2', '6') " + &
"    THEN ' and " + &
"    ( pd_affil_stat.apptmnt_type = ''' + CASE @apptmnt_status WHEN '1' THEN 'I' WHEN '2' THEN 'R' WHEN '6' THEN 'M' END + ''' )' " + &
"    ELSE '' " + &
"  END  + " + &
"  CASE WHEN isNull(@screen_id, 0) <= 0 THEN '' " + &
"    ELSE ' and  " + &
"    ( verif_info.screen_id = ' + convert(varchar, @screen_id) + ' )' " + &
"  END  + " + &
"  CASE WHEN isNull(@batch_id, 0) <= 0 THEN '' " + &
"    ELSE ' and " + &
"    ( sys_batch_items.batch_id = ' + convert(varchar, @batch_id) + ' ) and " + &
"    ( verif_info.prac_id = sys_batch_items.prac_id )' " + &
"  END  +' " + &
"  GROUP BY " + &
"    code_lookup.code,  " + &
"    verif_info.number_sent' " + &
"  EXECUTE (@sql_text) " + &
"result_set: " + &
"  SELECT " + &
"    verif_count,  " + &
"    code_lookup_code,  " + &
"    number_sent " + &
"  FROM " + &
"    #tmp_verif " + &
"  ORDER BY " + &
"    code_lookup_code,  " + &
"    number_sent "








return 1
end function

public function integer of_ver152_updates ();

return 1
end function

public function integer of_ver153_updates ();

return 1
end function

public function integer of_ver154_updates ();return 1
end function

public function integer of_ver161_updates ();return 1
end function

on n_cst_update.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//by Alfee 01.30.2008

end event

event destructor;if isvalid(w_infodisp) then close(w_infodisp)	 

end event

