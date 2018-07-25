$PBExportHeader$n_cst_update_data_clx.sru
forward
global type n_cst_update_data_clx from n_cst_update
end type
end forward

global type n_cst_update_data_clx from n_cst_update
end type
global n_cst_update_data_clx n_cst_update_data_clx

type variables
n_cst_clause inv_clause
end variables

forward prototypes
public function integer of_ver90_release_data1 ()
public subroutine of_upgrade_email_attachment ()
public subroutine of_upgrade_ai_alarm_attachment ()
public subroutine of_upgrade_alarm_attachment ()
public subroutine of_upgrade_alm_create ()
public subroutine of_upgrade_am_ai_alarm_attachment ()
public function integer of_ver95_release_data1 ()
public function integer of_ver95_release_data2 ()
public function integer of_ver110_release_data1 ()
public function integer of_ver100_release_data1 ()
public function integer of_ver105_release_data1 ()
public function integer of_clx110_updates ()
public function integer of_move_org_sent_items ()
public subroutine of_add_default_group_eamail ()
public function integer of_add_sertifi_tdl ()
public function integer of_add_webapprove_tdl ()
public subroutine of_alarm_convert_txt2doc ()
public subroutine of_fix_screen_depend_field ()
public function integer of_fix_alarm_create_action (string as_user_id, string as_email_id)
public function integer of_fix_alarm_create_action ()
public function integer of_backup_allscreen ()
public function integer of_backup_screen (long al_view_id, long al_screen_id)
public subroutine of_check_ids ()
public function integer of_patch_screen ()
public function integer of_ver115_release_data1 ()
public function integer of_ver120_release_data1 ()
public function integer of_clx120_updates ()
end prototypes

public function integer of_ver90_release_data1 ();//Added by Ken.Guo on 2009-01-09
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" Update dashboard_tabs_settings Set tab_position = 1 Where tab_position is null " 

//Added by Ken.Guo on 2009-01-09
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" Update security_users Set custom_colors = '16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215;16777215' Where custom_colors is null "

//Added by Ken.Guo on 2009-01-09
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'LstRvDTLtr') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Action Type' and code = 'LstRvDTLtr' and lookup_type='C') " + &
"	begin " + &
"	  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"	  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_1,modify_date) VALUES ( @li_id  ,'Contract Action Type' ,'LstRvDTLtr','Last Revistion Date Letter','S','LstRvDTLtr',getdate())  " + &
"	end "
//Added By Alan on 2009-1-15
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" Update security_users Set set_autoret = 1 Where set_autoret is null " 

//Added by Ken.Guo on 2009-01-09
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" Update icred_settings set group_access = 1 where group_access is null "

//Auto Generate Email Signature by jervis 01.20.2009
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update wf_email set auto_sign = 'Y' where auto_sign is null" 

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update CTX_NOTIFICATION set auto_sign = 'Y' where auto_sign is null" 

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update CTX_ai_NOTIFICATION set auto_sign = 'Y' where auto_sign is null" 

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update CTX_am_ai_NOTIFICATION set auto_sign = 'Y' where auto_sign is null" 

//Added by Ken.Guo on 2009-02-24
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update tdl_detail set use_graph = 0 where use_graph is null"

/*
//Added by Ken.Guo on 2009-02-25
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"If not exists( select 1 from dashboard_gadgets where gadget_id = 17 )~r~n" + &
"	Insert Into dashboard_gadgets values( 17,'u_gadget_17', 'To Do List Summary 1',0)~r~n" 

//Added by Ken.Guo on 2009-02-25
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"If not exists( select 1 from dashboard_gadgets where gadget_id = 18 )~r~n" + &
"	Insert Into dashboard_gadgets values( 18,'u_gadget_18', 'To Do List Summary 2',0)~r~n" 
*/

//Added by Ken.Guo on 2009-02-25
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"If Not exists(select id from dashboard_gadgets_report_list where id = 7 )~r~n" + &
"	Insert Into dashboard_gadgets_report_list(id,report_name) values(7,'To Do List')"

//move set_57 to set_90 for v141 isg-clx 
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set set_90 = IsNull(set_57,0) where set_90 is null "

//Version Number Increment Option - Jervis 02.26.2009
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set set_57 = 1 where set_57 is null"

//Added by Scofield on 2009-03-13
is_sql_statements[upperbound(is_sql_statements) + 1] = & 
"if NOT EXISTS (SELECT TOP 1 1 FROM ctx_tabpage_screen)~r~n" + &
"BEGIN~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (1,0,0,'tabpage_search',NULL,'Search')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (2,1,1,NULL,1,'Search Criteria')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (3,1,1,NULL,2,'Contract Browse')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (4,0,0,'tabpage_details',NULL,'Details')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (5,1,4,NULL,3,'Contract Detail')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (6,1,4,NULL,4,'Products')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (7,1,4,NULL,5,'Contract Dates')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (8,1,4,NULL,6,'Contracted Company Contact')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (9,1,4,NULL,7,'Our Company Contact')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (10,0,4,'tabpage_det_notes',NULL,'Notes')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (11,1,10,NULL,8,'Notes')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (12,0,4,'tabpage_det_custom',NULL,'Custom Data')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (13,1,12,NULL,9,'Custom Data')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (14,0,4,'tabpage_det_audit',NULL,'Audit Trail')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (15,1,14,NULL,10,'Audit Trail')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (16,0,4,'tabpage_det_linked',NULL,'Linked Contracts')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (17,1,16,NULL,43,'Linked Contracts')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (18,0,4,'tabpage_det_group',NULL,'Group Access')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (19,1,18,NULL,50,'Group Access')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (20,0,0,'tabpage_requirements',NULL,'Requirements')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (21,1,20,NULL,11,'Profile Selection')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (22,1,20,NULL,12,'Profile Detail')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (23,1,20,NULL,13,'Profile Detail')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (24,0,0,'tabpage_contacts',NULL,'Other Contacts')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (25,1,24,NULL,14,'Contacts List')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (26,1,24,NULL,15,'Contract Details')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (27,1,24,NULL,16,'Contract Information')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (28,1,24,NULL,17,'Contract Notes')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (29,0,0,'tabpage_locations',NULL,'Locations')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (30,1,29,NULL,18,'Contracted')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (31,1,29,NULL,19,'Facilities')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (32,1,29,NULL,20,'Associated Physicians')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (33,1,29,NULL,21,'Specialties')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (34,0,0,'tabpage_orgabizations',NULL,'Organizations')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (35,1,34,NULL,22,'Organization List')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (36,1,34,NULL,23,'Address')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (37,1,34,NULL,24,'Notes')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (38,1,34,NULL,25,'Organization Contacts')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (39,0,0,'tabpage_fee_schedules',NULL,'Fee Schedules')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (40,0,39,'tabpage_fee_browse',NULL,'Browse')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (41,1,40,NULL,26,'Fee Schedules')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (42,1,40,NULL,27,'Fee Schedule Locations')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (43,1,40,NULL,28,'Fees')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (44,1,40,NULL,29,'Providers')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (45,0,39,'tabpage_fee_notes',NULL,'Notes')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (46,1,45,NULL,30,'User Defined data')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (47,0,0,'tabpage_fee_sched2',NULL,'Fee Schedule (NM)')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (48,1,47,NULL,31,'Fee Schedule (Non Healthcare)')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (49,0,0,'tabpage_images',NULL,'Document Manager')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (50,0,49,'tabpage_dm_document',NULL,'Document')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (51,1,50,NULL,32,'Search Criteria')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (52,0,49,'tabpage_dm_workflow',NULL,'Work Flow')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (53,1,52,NULL,45,'Search Criteria')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (54,1,52,NULL,46,'Action Item Browse')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (55,1,52,NULL,47,'Action Item Detail')~r~n" + &
"	~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (56,0,49,'tabpage_dm_audit',NULL,'Audit Trail1')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (57,1,56,NULL,48,'Search Criteria')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (58,1,56,NULL,49,'Document Browse')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (59,0,0,'tabpage_action_items',NULL,'Action Items')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (60,1,59,NULL,33,'Action Item List')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (61,1,59,NULL,42,'Action Item Browse')~r~n" + &
"	~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (62,0,0,'tabpage_qrg',NULL,'QRG')~r~n" + &
"		INSERT INTO ctx_tabpage_screen VALUES (63,0,62,'tabpage_qrg_select',NULL,'Select Data')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (64,1,63,NULL,34,'Report Profiles')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (65,1,63,NULL,35,'Basic Information to Include')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (66,1,63,NULL,36,'Contract Contact Information to Include')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (67,1,63,NULL,37,'Precertifications Requirements')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (68,1,63,NULL,38,'Authorizations Requirements')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (69,1,63,NULL,39,'Fee Schedule Data to Include')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (70,1,63,NULL,40,'Organization Types to Include')~r~n" + &
"			INSERT INTO ctx_tabpage_screen VALUES (71,1,63,NULL,41,'Requirements to Include')~r~n" + &
"END"

//Added by Ken.Guo on 2009-04-20
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set reports_use_access = 1 where reports_use_access is null"

//move set_57 to set_90 for v141 isg-clx 
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set set_91 = IsNull(set_58,0) where set_91 is null "

//Version Number Increment type - Jervis 03.19.2009
//0-Major increment
//1-Minor increment
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set set_58 = 1 where set_58 is null"

//Fixed IntelliReport Data -- Jervis 04.27.2009 
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update conv_view_table  set conv_view_table.table_name =  conv_view_fields.table_name  " + &
"from conv_view_fields   " + &
"where conv_view_fields.sel_table_id = conv_view_table.cust_table_name and   " + &
"		conv_view_fields.view_id = conv_view_table.view_id and   " + &
"		conv_view_fields.project_id = conv_view_table.project_id and   " + &
"		conv_view_table.table_name is null and conv_view_fields.view_id is not null  " 


//Added By Ken.Guo 2009-05-18.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" update ctx_basic_info set master_contract_id = 0 Where master_contract_id is null"

//Added By Ken.Guo 2009-05-18.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ctx_basic_info Set master_contract_id = 0~r~n" + &
"Where ~r~n" + &
"Not Exists~r~n" + &
"(~r~n" + &
"	Select 1 From ctx_basic_info bb Where ctx_basic_info.master_contract_id = bb.ctx_id~r~n" + &
")~r~n" + &
"And ctx_basic_info.master_contract_id > 0 ~r~n" 

//Added By Ken.Guo 2009-05-18. Workaround APB Bug.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update dashboard_tabs_settings Set tab_position = 1 Where tab_position = 2 "

//Added By Ken.Guo 2009-06-16.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ctx_screen Set screen_name = 'Locations->Parent Organization' where  screen_name = 'Locations->Contracted' and screen_id = 18" 

//Added By Ken.Guo 2009-06-16.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ctx_screen Set screen_name = 'Locations->Group/Location' where  screen_name = 'Locations->Facilities' and screen_id = 19" 

//Added By Ken.Guo 2009-07-07.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update ctx_acp_template_clause_rules set used_master_ctx = 0 where used_master_ctx is null "

//Added By Ken.Guo 2009-07-13.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update ctx_ref_requirement set get_parent_data = 0 where get_parent_data is null "

//Added By Ken.Guo 2009-07-24.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update  security_rights_action set action_name = 'Report Button' where action_id = 6952 and action_name = 'Print Button' "

//Added By Ken.Guo 2009-07-31.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update icred_settings set email_encoding = 'windows-1252' where email_encoding is null"


//Added by Jervis 2009-8.3
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update export_fields set record_level = 'C' where record_level is null"


of_execute_sqls("of_ver90_release_data1")

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-02-24 By: Scofield
//$<Reason> Upgrade the email and alarm attachment.

if not IsValid(w_infodisp) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'update attachment, please stand by'
if isvalid(w_infodisp) then w_infodisp.center = true
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'update attachment, please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,4)

of_Upgrade_Email_Attachment()
if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)

of_Upgrade_Alarm_Attachment()
if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)

of_Upgrade_AI_Alarm_Attachment()
if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)

of_Upgrade_AM_AI_Alarm_Attachment()
if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)

//---------------------------- APPEON END ----------------------------

Return 1

end function

public subroutine of_upgrade_email_attachment ();//====================================================================
// Function: of_upgrade_email_attachment()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History: 
//Modify the d_mail_upgrade for Contract Email attachment only - (Appeon)Alfee for V141 ISG-CLX
//====================================================================

String	ls_AttachName
long		ll_Email_ID,ll_Attach_ID,ll_EmailCycle,ll_EmailCnt
long		ll_DataLen,ll_ReadCycle,ll_ReadCnts,ll_ReadPos
Blob		lblb_EmailAttach[],lb_Temp

long 		READ_ONE_LENGTH = 8000

CONSTANT STRING SEMICOLON = ";"

DataStore	lds_Email

lds_Email = Create DataStore
lds_Email.DataObject = "d_email_upgrade"
lds_Email.SetTransObject(SQLCA)
lds_Email.Retrieve()

ll_EmailCnt = lds_Email.RowCount()
for ll_EmailCycle = 1 to ll_EmailCnt
	ll_Email_ID = lds_Email.GetItemNumber(ll_EmailCycle,"Email_id")
	ls_AttachName = lds_Email.GetItemString(ll_EmailCycle,"Attach_Name")
	
	SELECT Max(attach_id) INTO :ll_Attach_ID FROM wf_email_attachment WHERE email_id = :ll_Email_ID;
	if IsNull(ll_Attach_ID) then ll_Attach_ID = 0 else CONTINUE
	ll_Attach_ID++
	
	INSERT INTO wf_email_attachment(email_id,attach_id,attach_name)
		  Values (:ll_Email_ID,:ll_Attach_ID,:ls_AttachName);
		  
	SELECT Datalength(attachment)
	  INTO :ll_DataLen
	  FROM wf_email
	 WHERE email_id = :ll_EMail_Id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_ReadPos = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(attachment,:ll_ReadPos,:READ_ONE_LENGTH) 
					INTO :lb_Temp
					FROM wf_email
				  WHERE email_id = :ll_EMail_Id;
			
			lblb_EmailAttach[ll_EmailCycle] += lb_Temp
		next
	else
		SELECTBLOB attachment
				INTO :lblb_EmailAttach[ll_EmailCycle]
				FROM wf_email
			  WHERE email_id = :ll_EMail_Id;
	end if
	
	UPDATEBLOB wf_email_attachment 
	       SET attachment = :lblb_EmailAttach[ll_EmailCycle] 
		  WHERE email_id = :ll_Email_ID AND attach_id = :ll_Attach_ID;
	
	ls_AttachName += SEMICOLON
	
	UPDATE wf_email SET Attach_Name = :ls_AttachName WHERE email_id = :ll_EMail_Id;
	
	Yield () //
next

COMMIT USING SQLCA;

Destroy lds_Email

end subroutine

public subroutine of_upgrade_ai_alarm_attachment ();//====================================================================
// Function: of_upgrade_ai_alarm_attachment()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_TabName,ls_ColName,ls_AttachName
long		ll_ctx_id,ll_item_id,ll_Attach_ID,ll_AlarmCycle,ll_AlarmCnt
long		ll_DataLen,ll_ReadCycle,ll_ReadCnts,ll_ReadPos

Blob		lblb_AlarmAttach[],lb_Temp
long 		READ_ONE_LENGTH = 8000

CONSTANT STRING SEMICOLON = ";"

DataStore	lds_Alarm

lds_Alarm = Create DataStore
lds_Alarm.DataObject = "d_ai_alarm_upgrade"
lds_Alarm.SetTransObject(SQLCA)
lds_Alarm.Retrieve()

ll_AlarmCnt = lds_Alarm.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnt
	ll_ctx_id = lds_Alarm.GetItemNumber(ll_AlarmCycle,"ctx_id")
	ll_item_id = lds_Alarm.GetItemNumber(ll_AlarmCycle,"ctx_action_item_id")
	ls_TabName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_table")
	ls_ColName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_column")
	ls_AttachName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Max(attach_id)
	  INTO :ll_Attach_ID
	  FROM ctx_ai_alarm_attachment
	 WHERE ctx_id = :ll_ctx_id AND item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if IsNull(ll_Attach_ID) then ll_Attach_ID = 0 else CONTINUE
	ll_Attach_ID++
	
	INSERT INTO ctx_ai_alarm_attachment(ctx_id,item_id,alm_table,alm_column,attach_id,alm_attachment_name)
		  Values (:ll_ctx_id,:ll_item_id,:ls_TabName,:ls_ColName,:ll_Attach_ID,:ls_AttachName);
		  
	SELECT Datalength(alm_attachment)
	  INTO :ll_DataLen
	  FROM ctx_ai_notification
	 WHERE ctx_id = :ll_ctx_id AND ctx_action_item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_ReadPos = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_ReadPos,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_ai_notification
				  WHERE ctx_id = :ll_ctx_id AND ctx_action_item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
			
			lblb_AlarmAttach[ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :lblb_AlarmAttach[ll_AlarmCycle]
				FROM ctx_ai_notification
			  WHERE ctx_id = :ll_ctx_id AND ctx_action_item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	end if
	
	UPDATEBLOB ctx_ai_alarm_attachment
	       SET alm_attachment = :lblb_AlarmAttach[ll_AlarmCycle]
		  WHERE ctx_id = :ll_ctx_id AND item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName AND attach_id = :ll_Attach_ID;
	
	ls_AttachName += SEMICOLON
	
	UPDATE ctx_ai_notification
	   SET alm_attachment_name = :ls_AttachName
	 WHERE ctx_id = :ll_ctx_id AND ctx_action_item_id = :ll_item_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	 
	 Yield () //
next

COMMIT USING SQLCA;

Destroy lds_Alarm

end subroutine

public subroutine of_upgrade_alarm_attachment ();//====================================================================
// Function: of_upgrade_alarm_attachment()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_TabName,ls_ColName,ls_AttachName
long		ll_ctx_id,ll_Attach_ID,ll_AlarmCycle,ll_AlarmCnt
long		ll_DataLen,ll_ReadCycle,ll_ReadCnts,ll_ReadPos

Blob		lblb_AlarmAttach[],lb_Temp
long 		READ_ONE_LENGTH = 8000

CONSTANT STRING SEMICOLON = ";"

DataStore	lds_Alarm

lds_Alarm = Create DataStore
lds_Alarm.DataObject = "d_alarm_upgrade"
lds_Alarm.SetTransObject(SQLCA)
lds_Alarm.Retrieve()

ll_AlarmCnt = lds_Alarm.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnt
	ll_ctx_id = lds_Alarm.GetItemNumber(ll_AlarmCycle,"ctx_id")
	ls_TabName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_table")
	ls_ColName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_column")
	ls_AttachName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Max(attach_id) 
	  INTO :ll_Attach_ID 
	  FROM ctx_alarm_attachment 
	 WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if IsNull(ll_Attach_ID) then ll_Attach_ID = 0 else CONTINUE
	ll_Attach_ID++
	
	INSERT INTO ctx_alarm_attachment(ctx_id,alm_table,alm_column,attach_id,alm_attachment_name)
		  Values (:ll_ctx_id,:ls_TabName,:ls_ColName,:ll_Attach_ID,:ls_AttachName);
		  
	SELECT Datalength(alm_attachment)
	  INTO :ll_DataLen
	  FROM ctx_notification
	 WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_ReadPos = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_ReadPos,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_notification
				  WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
			
			lblb_AlarmAttach[ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :lblb_AlarmAttach[ll_AlarmCycle]
				FROM ctx_notification
			  WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	end if
	
	UPDATEBLOB ctx_alarm_attachment 
	       SET alm_attachment = :lblb_AlarmAttach[ll_AlarmCycle] 
		  WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName AND attach_id = :ll_Attach_ID;
	
	ls_AttachName += SEMICOLON
	
	UPDATE ctx_notification 
	   SET alm_attachment_name = :ls_AttachName 
	 WHERE ctx_id = :ll_ctx_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	 
	 Yield () //
next

COMMIT USING SQLCA;

Destroy lds_Alarm

end subroutine

public subroutine of_upgrade_alm_create ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_update_dataof_upgrade_alm_create()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Upgrade alm_create column value. Change Email Address to User ID
//////////////////////////////////////////////////////////////////////
// $<add> 2010-03-01 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i,j,k
Long ll_cnt,ll_find
String ls_alm_create,ls_email_list[],ls_email_empty[]
String ls_user_id,ls_user_list
DataStore lds_alm_create[],lds_user_email
n_cst_string lnv_string

//Retrieve alarm data
For i = 1 to 3
	lds_alm_create[i] = Create DataStore
Next
lds_alm_create[1].dataobject = 'd_alm_create' 
lds_alm_create[2].dataobject = 'd_alm_ai_create' 
lds_alm_create[3].dataobject = 'd_alm_am_ai_create' 
For i = 1 to 3
	lds_alm_create[i].SetTransObject(SQLCA)
Next

lds_user_email = Create DataStore
lds_user_email.Dataobject = 'd_user_email'
lds_user_email.SetTransobject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_alm_create[1].Retrieve()
	lds_alm_create[2].Retrieve()
	lds_alm_create[3].Retrieve()
	lds_user_email.Retrieve()
gnv_appeondb.of_commitqueue( )

//replace alm_create data with User ID
For i = 1 to 3
	For j = 1 to lds_alm_create[i].rowcount( )
		ls_alm_create = trim(lds_alm_create[i].GetItemString(j,'alm_create'))
		If Not isnull(ls_alm_create) and ls_alm_create <> '' Then  
			ls_user_list = ''
			ls_email_list[] = ls_email_empty[]
			lnv_string.of_parsetoarray( ls_alm_create,";",ls_email_list[])
			For k = 1 to UpperBound(ls_email_list[])
				ll_find = 1
				Do while ll_find > 0 
					ll_find = lds_user_email.Find('lower(email_id) = "' + lower(trim(ls_email_list[k])) + '"' ,ll_find,lds_user_email.rowcount() )
					If ll_find > 0 Then
						ls_user_list += lds_user_email.GetItemString(ll_find,'user_id') + ';' 
						If ll_find = lds_user_email.rowcount() Then 
							Exit
						Else
							ll_find ++
						End If
					End If
				Loop
			Next
			If Len(ls_user_list) > 1 Then
				ls_user_list = Left(ls_user_list,len(ls_user_list) - 1)
				If ls_user_list <> ls_alm_create Then //Aviod repeat upgrade
					lds_alm_create[i].SetItem(j,'alm_create',ls_user_list)
				End If
			End If			
		End If
	Next
Next

//Update data.
If lds_alm_create[1].Modifiedcount( ) > 0 Then
	If lds_alm_create[1].update() <> 1 Then
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('lds_alm_create[1].update()', Sqlca.SQLErrText,'Upgrade contract alarm data')
		gb_upgrade_failed = TRUE
	End If
End If

If lds_alm_create[2].Modifiedcount( ) > 0 Then
	If lds_alm_create[2].update() <> 1 Then
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('lds_alm_create[2].update()', Sqlca.SQLErrText,'Upgrade contract action item alarm')
		gb_upgrade_failed = TRUE
	End If
End If

If lds_alm_create[3].Modifiedcount( ) > 0 Then
	If lds_alm_create[3].update() <> 1 Then
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('lds_alm_create[3].update()', Sqlca.SQLErrText,'Upgrade contract document action item alarm')
		gb_upgrade_failed = TRUE
	End If
End If


Return 
end subroutine

public subroutine of_upgrade_am_ai_alarm_attachment ();//====================================================================
// Function: of_upgrade_am_ai_alarm_attachment()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_TabName,ls_ColName,ls_AttachName
long		ll_doc_id,ll_seq_id,ll_Attach_ID,ll_AlarmCycle,ll_AlarmCnt
long		ll_DataLen,ll_ReadCycle,ll_ReadCnts,ll_ReadPos

Blob		lblb_AlarmAttach[],lb_Temp
long 		READ_ONE_LENGTH = 8000

CONSTANT STRING SEMICOLON = ";"

DataStore	lds_Alarm

lds_Alarm = Create DataStore
lds_Alarm.DataObject = "d_am_ai_alarm_upgrade"
lds_Alarm.SetTransObject(SQLCA)
lds_Alarm.Retrieve()

ll_AlarmCnt = lds_Alarm.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnt
	ll_doc_id = lds_Alarm.GetItemNumber(ll_AlarmCycle,"doc_id")
	ll_seq_id = lds_Alarm.GetItemNumber(ll_AlarmCycle,"seq_id")
	ls_TabName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_table")
	ls_ColName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_column")
	ls_AttachName = lds_Alarm.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Max(attach_id)
	  INTO :ll_Attach_ID
	  FROM ctx_am_ai_alarm_attachment
	 WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if IsNull(ll_Attach_ID) then ll_Attach_ID = 0 else CONTINUE
	ll_Attach_ID++
	
	INSERT INTO ctx_am_ai_alarm_attachment(doc_id,seq_id,alm_table,alm_column,attach_id,alm_attachment_name)
		  Values (:ll_doc_id,:ll_seq_id,:ls_TabName,:ls_ColName,:ll_Attach_ID,:ls_AttachName);
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_DataLen
	  FROM ctx_am_ai_notification
	 WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_DataLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_ReadPos = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_ReadPos,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_am_ai_notification
				  WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
			
			lblb_AlarmAttach[ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :lblb_AlarmAttach[ll_AlarmCycle]
				FROM ctx_am_ai_notification
			  WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	end if
	
	UPDATEBLOB ctx_am_ai_alarm_attachment
	       SET alm_attachment = :lblb_AlarmAttach[ll_AlarmCycle]
		  WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName AND attach_id = :ll_Attach_ID;
	
	ls_AttachName += SEMICOLON
	
	UPDATE ctx_am_ai_notification
	   SET alm_attachment_name = :ls_AttachName
	 WHERE doc_id = :ll_doc_id AND seq_id = :ll_seq_id AND alm_table = :ls_TabName AND alm_column = :ls_ColName;
	 
	 Yield () //
next

COMMIT USING SQLCA;

Destroy lds_Alarm

end subroutine

public function integer of_ver95_release_data1 ();//Added by Jervis 2009.8.14
//Unit Type For CPT Code
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Unit Type' and code = 'Piece') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Unit Type' and code = 'Piece' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES ( @li_id  ,'Unit Type','Piece','Piece')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Unit Type' and code = 'Hourly') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Unit Type' and code = 'Hourly' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES ( @li_id  ,'Unit Type','Hourly','Hourly')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Unit Type' and code = 'Weekly') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Unit Type' and code = 'Weekly' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES ( @li_id  ,'Unit Type','Weekly','Weekly')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Unit Type' and code = 'Monthly') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Unit Type' and code = 'Monthly' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES ( @li_id  ,'Unit Type','Monthly','Monthly')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Unit Type' and code = 'N/A') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Unit Type' and code = 'N/A' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES ( @li_id  ,'Unit Type','N/A','Not Applicable')   " + &
"end "

//Added By Ken.Guo 2009-08-24.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update ctx_basic_info set is_template = 0 where is_template is null"

//Added By Ken.Guo 2009-08-24.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ids set ctx_template_id = -1000 where ctx_template_id is null"

//Added By Ken.Guo 2009-08-26.
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"If not exists( select 1 from dashboard_gadgets where gadget_id = 17 ) " + &
"         Insert Into dashboard_gadgets values( 17,'u_gadget_17', 'Contract Templates',0) " 

//Added By Ken.Guo 2009-09-02.
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update dashboard_gadgets set gadget_auto_height = 1 where gadget_id = 17 and gadget_auto_height = 0 "

//Added By Ken.Guo 2009-09-02.
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update dashboard_tab_gadgets set gadget_rows_number = 5 where gadget_id = 17 and gadget_rows_number = 0"

//Added By Ken.Guo 2009-09-02. 
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update dashboard_tab_gadgets set gadget_rows_number = 0 where gadget_id in(Select gadget_id from dashboard_gadgets where gadget_auto_height = 0) and gadget_rows_number <> 0"

//Added by Scofield on 2009-09-18
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update Security_Users set set_autoresize = 1 where set_autoresize is null "

//Added by Scofield on 2009-09-22
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_basic_info set is_template = 0 where is_template is null"

//Added by jervis 2009-10-12
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_notification set alm_create = alm_mailto where alm_create is null and create_action_item = 'Y' and alm_mailto is not null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_ai_notification set alm_create = alm_mailto where alm_create is null and create_action_item = 'Y' and alm_mailto is not null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_am_ai_notification set alm_create = alm_mailto where alm_create is null and create_action_item = 'Y' and alm_mailto is not null"

//Added By Ken.Guo 2009-10-19.
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update icred_settings Set ocr_language = 0 where ocr_language is null" 

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update icred_settings Set ocr_mode = 0 where ocr_mode is null"

//Add by jervis 10.21.2009
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update ctx_am_doc_image set doc_ext_full = doc_ext where doc_ext_full is null"

//Added By Ken.Guo 2009-10-28.
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update icred_settings set ctx_browse_style = 0 where ctx_browse_style is null"

//BEGIN---Modify by Scofield on 2009-10-29
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Document Type' and code = 'Sell') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Document Type' and code = 'Sell' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Document Type' ,'Sell','Sell','S')  " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Document Type' and code = 'Buy') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Document Type' and code = 'Buy' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Document Type' ,'Buy','Buy','S')  " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Document Type' and code = 'Other') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Document Type' and code = 'Other' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Document Type' ,'Other','Other','S')  " + &
"end "
//END---Modify by Scofield on 2009-10-29

//BEGIN---Modify by Scofield on 2009-10-30
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_am_document set doc_type = 'Buy' where doc_type = 'B'"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_am_document set doc_type = 'Sell' where doc_type = 'S'"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_am_document set doc_type = 'Other' where doc_type = 'O'"
//END---Modify by Scofield on 2009-10-30

//Add by jervis 11.03.2009
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen_field_depend set base_field_dispaly = base_field where base_field_dispaly = ''"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen_field_depend set depend_field_dispaly = depend_field where depend_field_dispaly = ''"

//Add by jervis 11.09.2009-- for audit trail
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"  update sys_fields set field_name = 'expriation_date' where table_id = 1003 and field_id = 20030 "


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20235) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20235,0,'custom_date11','D',512,'Custom Date11')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20236) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20236,0,'custom_date12','D',512,'Custom Date12')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20237) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20237,0,'custom_date13','D',512,'Custom Date13')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20238) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20238,0,'custom_date14','D',512,'Custom Date14')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20239) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20239,0,'custom_date15','D',512,'Custom Date15')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20240) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20240,0,'custom_date16','D',512,'Custom Date16')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20241) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20241,0,'custom_date17','D',512,'Custom Date17')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20242) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20242,0,'custom_21','D',512,'Custom 21')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20243) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20243,0,'custom_22','D',512,'Custom 22')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20244) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20244,0,'custom_n11','D',512,'Custom N11')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20245) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20245,0,'custom_n12','D',512,'custom N12')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20246) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20246,0,'custom_n13','D',512,'Custom N13')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20247) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20247,0,'custom_n14','D',512,'Custom N14')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20248) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20248,0,'custom_n15','D',512,'Custom N15')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20249) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20249,0,'custom_n16','D',512,'Custom N16')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20250) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20250,0,'custom_n17','D',512,'Custom N17')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20251) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20251,0,'custom_n18','D',512,'Custom N18')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20252) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20252,0,'custom_n19','D',512,'Custom N19')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20253) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20253,0,'custom_n20','D',512,'Custom N20')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20254) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20254,0,'custom_n21','D',512,'Custom N21')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20255) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20255,0,'custom_n22','D',512,'Custom N22')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20256) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20256,0,'custom_n23','D',512,'Custom N23')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20257) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20257,0,'custom_n24','D',512,'Custom N24')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20258) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20258,0,'custom_n25','D',512,'Custom N25')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20259) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20259,0,'custom_n26','D',512,'Custom N26')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20260) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20260,0,'custom_n27','D',512,'Custom N27')   "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 20261) " + &
"  INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20261,0,'master_contract_id','I',512,'Master Contract ID')   "

//Added By Ken.Guo 2009-11-11.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set auto_ocr = 1 where auto_ocr is null "

//BEGIN---Modify by Scofield on 2009-12-02
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_ai_notification SET alm_action_title = 'Due Date' WHERE alm_action_title Is Null AND alm_column = 'due_date'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_am_ai_notification SET alm_action_title = 'Due Date' WHERE alm_action_title Is Null AND alm_column = 'due_date'"
//END---Modify by Scofield on 2009-12-02

//BEGIN---Modify by Scofield on 2009-12-03
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_action_items~r~n" + &
"   SET ctx_action_items.subject = wf_action_status.action_status_desc~r~n" + &
"  FROM ctx_action_items,wf_action_status~r~n" + &
" WHERE ctx_action_items.wf_id = wf_action_status.wf_id AND~r~n" + &
"       ctx_action_items.wf_action_type_id = wf_action_status.step_id AND~r~n" + &
"       ctx_action_items.action_status = wf_action_status.action_status_id AND~r~n" + &
"       ctx_action_items.wf_id is not Null and ctx_action_items.subject is Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_am_action_item~r~n" + &
"   SET ctx_am_action_item.subject = wf_action_status.action_status_desc~r~n" + &
"  FROM ctx_am_action_item,wf_action_status~r~n" + &
" WHERE ctx_am_action_item.wf_id = wf_action_status.wf_id AND~r~n" + &
"       ctx_am_action_item.wf_action_type_id = wf_action_status.step_id AND~r~n" + &
"       ctx_am_action_item.action_status = wf_action_status.action_status_id AND~r~n" + &
"       ctx_am_action_item.wf_id is not Null and ctx_am_action_item.subject is Null"
//END---Modify by Scofield on 2009-12-03

//Added By Ken.Guo 2009-12-16.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update security_users set doc_auto_retrieve = 1 where doc_auto_retrieve is null "

//Added By Ken.Guo 2009-12-17.  Delete Add other, change Add Buy to Add Doc, change Add Sell to Create Doc.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update security_roles_rights ~r~n" + &
"Set security_roles_rights.value_id = 2~r~n" + &
"Where ~r~n" + &
"security_roles_rights.Action_id = 6901~r~n" + &
"And security_roles_rights.value_id = 0~r~n" + &
"And (Select Count(1) From security_roles_rights b ~r~n" + &
"	Where b.role_id = security_roles_rights.role_id and b.action_id = 6926 and b.value_id > 0 ) > 0~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update security_rights_action Set action_name = 'Add Doc' Where action_id = 6901"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update security_rights_action Set action_name = 'Create Doc' Where action_id = 6902"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Delete from security_roles_rights where action_id = 6926"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Delete From security_rights_action Where action_id = 6926"

//Added By Ken.Guo 2009-12-24.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update security_users set contract_display_mode = 0 where contract_display_mode is null"

//Added By Ken.Guo 2009-12-29.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_user_tv_settings set hide_browse = 0 where hide_browse is null"

//Added By Ken.Guo 2009-12-29.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_user_tv_settings set max_width = 0 where max_width is null"

//Added By Jervis 2009-12-30.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_acp_clause set comment_disp = 0 where comment_disp is null"

//BEGIN---Modify by Scofield on 2010-01-04
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 1') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 1' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 1','Attribute 1','S')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 2') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 2' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 2','Attribute 2','S')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 3') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 3' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 3','Attribute 3','S')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 4') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 4' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 4','Attribute 4','S')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 5') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 5' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 5','Attribute 5','S')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 6') ~r~n" + &
"AND ~r~n" + &
"   Not Exists (select 1 ~r~n" + &
"                 from sys_code_lookup_audit ~r~n" + &
"                where lookup_name = 'Clause Attributes' and code = 'Attribute 6' and lookup_type = 'C')~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,'Clause Attributes' ,'Attribute 6','Attribute 6','S')~r~n" + &
"end"
//END---Modify by Scofield on 2010-01-04

//BEGIN---Modify by Scofield on 2010-01-04
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 1' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 1'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 2' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 2'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 3' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 3'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 4' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 4'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 5' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 5'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id   int~r~n" + &
"declare @ls_name varchar(255)~r~n" + &
"~r~n" + &
"if Not Exists (select 1~r~n" + &
"                 from code_lookup code_lookup_A,code_lookup code_lookup_B~r~n" + &
"                where code_lookup_A.lookup_name = 'Clause Attributes' and~r~n" + &
"                      code_lookup_A.code = 'Attribute 6' and~r~n" + &
"                      code_lookup_A.description = code_lookup_B.lookup_name~r~n" + &
"               )~r~n" + &
"begin~r~n" + &
"  select @li_id   = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  select @ls_name = description from code_lookup where lookup_name = 'Clause Attributes' and code = 'Attribute 6'~r~n" + &
"~r~n" + &
"  insert into code_lookup(lookup_code,lookup_name,code,description,type) ~r~n" + &
"       values (@li_id ,@ls_name ,'Attrib Code','Attrib Description','C')~r~n" + &
"end"

//END---Modify by Scofield on 2010-01-04

//BEGIN---Modify by Scofield on 2010-02-01
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists (select 1 from sys_lookup where lookup_name = 'Clause Attributes')~r~n" + &
"	insert into sys_lookup(lookup_name) values('Clause Attributes')"
//END---Modify by Scofield on 2010-02-01

//Add by jervis 01.04.2010
/*
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update code_lookup set custom_2= '1' where lookup_name = 'Contract Approval Status' and custom_2 is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update code_lookup set custom_3= '1' where lookup_name = 'Contract Approval Status' and custom_3 is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update code_lookup set custom_4= '1' where lookup_name = 'Contract Approval Status' and custom_4 is null"
*/
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_1= '0' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_1 is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_2= '1' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_2 is null and code = 'Approved'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_2= '0' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_2 is null and code <> 'Approved'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_3= '1' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_3 is null and code = 'Approved'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_3= '1' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_3 is null and code <> 'Approved'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update code_lookup set custom_4= '1' where (lookup_name = 'Clause Approval Status' or lookup_name = 'Contract Approval Status' ) and custom_4 is null"

//Added By Ken.Guo 2010-01-11.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_acp_clause set revision = 0 where revision is null" 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_acp_clause set checkout_status = 0 where checkout_status is null" 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_acp_clause set revision_control = 1 where revision_control is null" 


of_execute_sqls("of_ver95_release_data1")

Return 1

end function

public function integer of_ver95_release_data2 ();//Added By Ken.Guo 2010-01-13. 
inv_clause.of_ini_data( ) //This function must run after of_ver95_release_data1()

//Added By Ken.Guo 2010-01-19.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_acp_clause_image set doc_type = 'doc' where doc_type is null" 


//Add by jervis 01.20.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update code_lookup set lookup_name = 'Clause Approval Status' where lookup_name = 'Contract Approval Status'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update lookup_coltitle set lookup_name = 'Clause Approval Status' where lookup_name = 'Contract Approval Status'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_acp_clause_attribute SET clause_attribute_alias = Null"

//Added By Ken.Guo 2010-02-04.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update icred_settings set doc_name_format = 1 where doc_name_format is null"

////Added by jervis 2010-02-05
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"Update security_modules set Module_name = 'Report Writer' where module_id = 28 and Module_name = 'IntelliReport'"

//Added By Ken.Guo 2010-02-25.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update icred_settings set filter_documents = 0 where filter_documents is null"

//BEGIN---Modify by Scofield on 2010-03-02
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_action_items~r~n" + &
"   SET Start_Time = '1900-01-01 00:00:00'~r~n" + &
" WHERE Start_Time Is Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_action_items~r~n" + &
"   SET End_Time = '1900-01-01 00:00:00'~r~n" + &
" WHERE End_Time Is Null"
//END---Modify by Scofield on 2010-03-02

//Added By Ken.Guo 2010-03-09.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings Set screen_version = '0001' where screen_version is null"

//BEGIN---Modify by Scofield on 2010-03-16
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE icred_settings SET CalFilterName_1 = '1' WHERE CalFilterName_1 is Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE icred_settings SET CalFilterName_2 = '2' WHERE CalFilterName_2 is Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE icred_settings SET CalFilterName_3 = '3' WHERE CalFilterName_3 is Null"
//END---Modify by Scofield on 2010-03-16

//BEGIN---Modify by Scofield on 2010-03-17
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE icred_settings SET CalArrangeMode = 0 WHERE CalArrangeMode is Null"
//END---Modify by Scofield on 2010-03-17

of_execute_sqls("of_ver95_release_data2")

//Added By Ken.Guo 2010-03-01.
if not IsValid(w_infodisp) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update date alarm, please stand by ...'
This.of_upgrade_alm_create( ) 

Return 1

end function

public function integer of_ver110_release_data1 ();//Add SQL Here

IF gs_dbtype = "SQL" THEN //For performance on ASA DB - Alfee 09.08.2013
	//added by gavins 20120320 move grid from dw_sql to grid_sql
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen set grid_sql = dw_sql,  ~r~n" + &
	"					  grid_opsql = dw_opsql , ~r~n" + &
	"					  grid_dataobject = dataobject, ~r~n" + &
	"					  screen_style = 'G' , ~r~n" + &
	"					  dw_sql = null, ~r~n" + &
	"					  dw_opsql = null, ~r~n" + &
	"					  dataobject= null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  screen_id in( 4,6,7,11,16,18,20,21,22,25,26,27 )~r~n" 
	// 4,6,7,11,16,18,20,21,22,25,26,27,28,29,35,36,37,38,39,40,42,46,49,50,56,57
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen set grid_sql = dw_sql,  ~r~n" + &
	"					  grid_opsql = dw_opsql , ~r~n" + &
	"					  grid_dataobject = dataobject, ~r~n" + &
	"					  screen_style = 'G' , ~r~n" + &
	"					  dw_sql = null, ~r~n" + &
	"					  dw_opsql = null, ~r~n" + &
	"					  dataobject= null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  screen_id in(28,29,35,36,37,38,39,40,42,46,49,50,56,57 )~r~n" 
	
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen_bak set grid_sql = dw_sql,  ~r~n" + &
	"					  	  dw_sql = null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  ~r~n" + &
	"	screen_id in( 4,6,7,11,16,18) ~r~n" 
	
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen_bak set grid_sql = dw_sql,  ~r~n" + &
	"					  	  dw_sql = null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  ~r~n" + &
	"	screen_id in( 20,21,22,25,26,27,28 ) ~r~n" 
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen_bak set grid_sql = dw_sql,  ~r~n" + &
	"					  	  dw_sql = null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  ~r~n" + &
	"	screen_id in( 29,35,36,37,38,39 ) ~r~n" 
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"update ctx_screen_bak set grid_sql = dw_sql,  ~r~n" + &
	"					  	  dw_sql = null ~r~n" + &
	" where  datalength( dw_sql ) > 0 	and  (datalength(grid_sql) = 0 or grid_sql is null ) ~r~n" + &
	"	and patindex( '%processing=1%',dw_sql ) > 0 and  ~r~n" + &
	"	screen_id in( 39,40,42,46,49,50,56,57 ) ~r~n" 	

	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	" update ctx_screen_bak set screen_style =  ~r~n" + &
	" (case when grid_sql is null or datalength( grid_sql ) = 0 then 'F' else 'G' end ) ~r~n" + &
	"  where     isnull(screen_style , '' ) = '' and screen_id not in ( 2, 14, 43, 54 ) ~r~n"
	  
	  is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	 "  update ctx_screen_bak set screen_style =  'F'  ~r~n" + &
	 " where     isnull(screen_style , '' ) = '' and screen_id in ( 2, 14, 43, 54 ) ~r~n"
END IF

//Added By Ken.Guo 03/22/2012. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings Set hide_inactive_window = 1 Where hide_inactive_window is null"

//Added By Mark Lee 04/23/12 Fixed APB Bug 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  & 
"   update  export_fields set default_value = '' where default_value is null~r~n" 

//Added By Mark Lee 05/09/12	Email Subject was 'BUG: Using Templates - Dynamically Add User'
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"	Update ctx_templates_info Set ib_owner = 0 Where ib_owner is null ~r~n~r~n" 

//Added By Mark Lee 05/09/12	Email Subject was 'BUG: Using Templates - Dynamically Add User'
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"	Update ctx_templates_info Set ib_default_email = 0 Where ib_default_email is null~r~n~r~n" 

//added by gavins 20120528
 is_sql_statements[UpperBound(is_sql_statements) + 1] =  &  	
" delete from conv_view_pic   ~r~n" + &
" where  pic_filename is null or rtrim(pic_filename) = '' or pic_filename = '!'  or datalength( pic_bitmap)=0 or pic_bitmap is null   "

//Added By Ken.Guo 06/13/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 74)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(74,0,0,'tabpage_multi',null,'Custom Multi')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 75)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(75,0,74,'tabpage_header',null,'Header')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 76)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(76,1,75,null,53,'Browse')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 77)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(77,0,74,'tabpage_detail',null,'Detail')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 78)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(78,1,77,null,54,'Browse ')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 79)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(79,1,77,null,55,'Detail')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 80)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(80,1,50,null,56,'Browse')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 81)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(81,1,50,null,57,'History')"

//Added By Ken.Guo 06/19/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update  conv_view set  newpage_group = 0  Where newpage_group is null "

//Added By Ken.Guo 07/05/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set checkoutforapproval = 1 Where checkoutforapproval is null "

//Added By Ken.Guo 07/18/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 13 and charindex('clause,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'clause,b_1,t_1,t_2' where data_view_id = 1001 and screen_id = 13  ~r~n" 

//Added By Ken.Guo 07/18/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 51 and charindex('category,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'category,' where data_view_id = 1001 and screen_id = 51  ~r~n" 

//Added By Ken.Guo 07/18/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 52 and charindex('category,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'category,' where data_view_id = 1001 and screen_id = 52  ~r~n" 

//Added By Ken.Guo 07/20/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set dwsavepdfway = 1 where dwsavepdfway is null "

//Added By Mark Lee 08/09/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings ~r~n set https = 0 ~r~n where https is null~r~n"


//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from sys_tables where table_id = 1065) ~r~n" + &
"  INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1065,	'd_contract_det_custom_2',	'Contract/Details/Custom Data 2',	NULL,	0,	NULL,	NULL,	NULL,'C')~r~n" 


//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_tables where table_id = 1066) ~r~n" + &
"  INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1066,	'd_contract_multi_header',	'Contract/Custom Multi/Header',	NULL,	0,	NULL,	NULL,	NULL,'C') ~r~n" 

//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_tables where table_id = 1067) ~r~n" + &
" INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1067,	'd_contract_multi_detail',	'Contract/Custom Multi/Detail',	NULL,	0,	NULL,	NULL,	NULL,'C')~r~n" 

//Added By Ken.Guo 08/17/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set preload_word = 0 where preload_word is null "

//Added By Gavins 08/22/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set alarm_ways = 0 where alarm_ways is null "

////Added By Ken.Guo 08/28/2012. always using email plugin to send/receive email.
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"Update icred_settings set set_56 = 0"

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for USband Customer.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set default_copy_contract = '' Where default_copy_contract is null "

//Added By Ken.Guo 12/19/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_view = view_id where wf_triggered_view is null"

//Added By Ken.Guo 12/19/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_view = 'all' where wf_triggered_view is null"

//Added By Ken.Guo 12/20/2012. compatible old versio, so set the initial value.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_ctx_status = ~r~n" + &
"Convert(varchar(20),(select top 1 lookup_code from code_lookup where lookup_name = 'Contract Status' and code = 'Pending')) ~r~n" + &
"where wf_triggered_ctx_status is null"

//Added By Ken.Guo 12/20/2012.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_ctx_status = 'all' where wf_triggered_ctx_status is null"

//Added By Ken.Guo 03/15/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set es_apicode = 'DC1317FF-E03E-475D-87E7-AAE70E8D97A4' where es_apicode is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set es_apicode = 'DC1317FF-E03E-475D-87E7-AAE70E8D97A4' where es_apicode = '1e111366-9f69-102d-a0b1-db73b11b73f0' "


of_execute_sqls("of_ver110_release_data1")

Return 1

end function

public function integer of_ver100_release_data1 ();//Added By Ken.Guo 2010-03-26.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update em_smtp_accounts set pop3_port = 143 where pop3_port is null" //110->143 //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set email_start_date = GetDate() where email_start_date is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set email_tag = ' (CLX)' where email_tag is null"

//BEGIN---Modify by Scofield on 2010-03-31
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE ctx_contract_contacts~r~n" + &
"   SET ctx_contract_contacts.association = ctx_contacts.contact_type~r~n" + &
"  FROM ctx_contract_contacts,ctx_contacts~r~n" + &
" WHERE ctx_contract_contacts.contact_id = ctx_contacts.contact_id AND~r~n" + &
"       ctx_contract_contacts.association is Null AND~r~n" + &
"       ctx_contacts.contact_type is Not Null"
//END---Modify by Scofield on 2010-03-31

//BEGIN---Modify by Scofield on 2010-04-20
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 72)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(72,1,50,Null,51,'Added Document Properties')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 73)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES (73,1,50,Null,52,'Created Document Properties')"
//END---Modify by Scofield on 2010-04-20

//Added By Ken.Guo 2010-04-23.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_user_config set auto_add_ctx = 1 where auto_add_ctx is null"

//Added By Ken.Guo 2010-04-28.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_user_config set email_rule_type = 1 where email_rule_type is null"

//Added By Ken.Guo 2010-05-12.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set email_tag_mode = 1 where email_tag_mode is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_mail_items set mail_save_format = 'doc' where mail_save_format = 'w'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_mail_items set mail_save_format = 'eml' where mail_save_format = 'e'"

//BEGIN---Modify by Scofield on 2010-05-18
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update Security_Users Set AutoExport = 0 Where AutoExport is Null"
//END---Modify by Scofield on 2010-05-18

//Added By Ken.Guo 2010-05-19.
//is_sql_statements[upperbound(is_sql_statements) + 1] = & //Ken: need comment it.
//"update security_users set getting_started = 0 where getting_started is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 1 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(1, 'start_add_new_contract.jpg','start_add_new_contract_gray.jpg','Add New Contract')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 2 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(2, 'start_search_for_contract.jpg','start_search_for_contract_gray.jpg','Search For Contract')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 3 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(3, 'start_search_for_document.jpg','start_search_for_document_gray.jpg','Search For Document')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 4 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(4, 'start_full_text_search.jpg','start_full_text_search_gray.jpg','Full Text Search')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 5 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(5, 'start_view_calendar.jpg','start_view_calendar_gray.jpg','View Calendar')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 6 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(6, 'start_configure_email.jpg','start_configure_email_gray.jpg','Configure Email')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 7 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(7, 'start_email_templates.jpg','start_email_templates_gray.jpg','Email Templates')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 8 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(8, 'start_manage_users.jpg','start_manage_users_gray.jpg','Manager Users')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 9 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(9, 'start_customize_screens.jpg','start_customize_screens_gray.jpg','Customize Screens')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 10 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(10, 'start_edit_lookup_tables.jpg','start_edit_lookup_tables_gray.jpg','Edit Lookup Tables')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists(	select 1 from ctx_getting_started where id = 11 ) ~r~n" + &
"Insert Into ctx_getting_started (id, enable_picture,disable_picture,tips) ~r~n" + &
"	Values(11, 'start_view_contacts.jpg','start_view_contacts_gray.jpg','View Contats')~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If not exists( select 1 from dashboard_gadgets where gadget_id = 18 )~r~n" + &
"	Insert Into dashboard_gadgets values( 18,'u_gadget_18', 'Getting Started',0)"

//Added By Ken.Guo 2010-06-01.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"UPDATE lookup_coltitle	SET ColTitleText = 'To Do Enabled' ~r~n" + &
"WHERE lookup_coltitle.lookup_type = 'C' ~r~n" + &
"AND lookup_coltitle.lookup_name = 'Contract Status' ~r~n" + &
"AND lookup_coltitle.ColTitleName = 'cust_3_t' ~r~n" + &
"AND ColTitleText = 'Custom 3' "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update code_lookup Set custom_3 = 'YES' Where lookup_name = 'Contract Status' and custom_3 is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_bidq_doc set delete_flag = 1 where delete_flag is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_bidq_doc Set doc_type = 'Sell' Where doc_type = 'S'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_bidq_doc Set doc_type = 'Buy' Where doc_type = 'B'"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_bidq_doc Set doc_type = 'Other' Where doc_type = 'O'"

//Added By Ken.Guo 2010-08-05.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update security_users Set run_date_alarm = 1 Where run_date_alarm is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set email_alarm_type = 1 where email_alarm_type is null "

//Added By Ken.Guo 2010-08-06.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 10 where id  = 11 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 20 where id  = 1 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 30 where id  = 2 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 40 where id  = 3 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 50 where id  = 4 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 60 where id  = 6 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 70 where id  = 7 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 80 where id  = 8 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 90 where id  = 9 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 100 where id  = 10 and default_order is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_getting_started set default_order = 110 where id  = 5 and default_order is null"

//Added By Ken.Guo 2010-08-31.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update dashboard_tabs set gadget_title_font_color = 0 where gadget_title_font_color is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update dashboard_tabs set tab_text_color = 0 where tab_text_color is null"

//Add by jervis 08.31.2010
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"Update wf_workflow set wf_trigger_type = 'S' where wf_trigger_type is null and (wf_triggered_by = '100' or wf_triggered_by = '105')"

//Added By Ken.Guo 2010-09-09.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_screen Set Screen_name = 'Other Contacts->Contact Details' Where screen_id = 15 and Screen_name = 'Other Contacts->Contract Details'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_screen Set Screen_name = 'Other Contacts->Contact Information' Where screen_id = 16 and Screen_name = 'Other Contacts->Contract Information'"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_screen Set Screen_name = 'Other Contacts->Contact Notes' Where screen_id = 17 and Screen_name = 'Other Contacts->Contract Notes'"

//Added By Ken.Guo 2010-09-17.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update tdl_detail set tv_icon = 'Custom039!' Where tv_icon is null"


//Add by jervis 09.19.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow set wf_trigger_onlogin = 'N' where wf_trigger_onlogin is null and (wf_triggered_by = '100' or wf_triggered_by = '105')"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow set wf_trigger_onsave = 'Y' where wf_trigger_onsave is null and (wf_triggered_by = '100' or wf_triggered_by = '105')"

//Added By Ken.Guo 2010-10-20.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update icred_settings set ocr_engine_pdf = 1 where ocr_engine_pdf is null"

//Added By Ken.Guo 2010-10-22.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_acp_clause set append_paragraph = 1 where append_paragraph is null"

//Added By Jervis 2010-10-25.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update wf_advanced_update_criteria set field_parent = wf_advanced_update.field_name ~r~n" + &
"from wf_advanced_update ~r~n" + &
"where	wf_advanced_update_criteria.wf_id = wf_advanced_update.wf_id and  ~r~n" + &
"		wf_advanced_update_criteria.wf_step_id = wf_advanced_update.wf_step_id and  ~r~n" + &
"		wf_advanced_update_criteria.wf_status_id = wf_advanced_update.wf_status_id and  ~r~n" + &
"		wf_advanced_update_criteria.key_id = wf_advanced_update.key_id and  ~r~n" + &
"		wf_advanced_update_criteria.field_parent is null"

//Added By Jervis 2010-10-25.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update wf_action_status set wf_esign = 'N' where wf_esign is null"

//Added By Ken.Guo 2010-10-26.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update ctx_getting_started set enable_picture = 'start_view_contacts.jpg', disable_picture = 'start_view_contacts_gray.jpg', tips = 'View Contats' where id = 11 and tips = 'View Contrats'"

//Added By Ken.Guo 2010-11-03.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_mail_items set ctx_id_list = mail_ctx_id where ctx_id_list is null and mail_ctx_id is not null "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_mail_items set doc_id_list = mail_doc_id where doc_id_list is null and mail_doc_id is not null "


//Insert document->work flow fields  -- jervis 11.10.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200801) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200801,0,'','action_type', 'Action Type',6, 'N' ,6,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200802) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200802,0,'','action_date', 'Action Date',20, 'D' ,20,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200803) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200803,0,'','due_date', 'Due Date',20, 'D' ,20,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200804) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200804,0,'','action_user', 'User',153, 'C' ,153,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200805) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200805,0,'','action_status', 'Status',6, 'N' ,6,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200806) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200806,0,'','first_attempt', 'First Attempt',20, 'D' ,20,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200807) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200807,0,'','last_attempt', 'Last Attempt',20, 'D' ,20,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200808) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200808,0,'','custom_1', 'Custom 1',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200809) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200809,0,'','custom_2', 'Custom 2',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200810) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200810,0,'','custom_3', 'Custom 3',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200811) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200811,0,'','custom_4', 'Custom 4',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200812) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200812,0,'','custom_n1', 'Custom n1',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200813) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200813,0,'','custom_n2', 'Custom n2',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200814) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200814,0,'','custom_n3', 'Custom n3',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200815) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,200815,0,'','custom_n4', 'Custom n4',14, 'N' ,14,'','','','') "


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200816) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200816,0,'','custom_1', 'Custom 1',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200817) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200817,0,'','custom_2', 'Custom 2',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200818) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200818,0,'','custom_3', 'Custom 3',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200819) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200819,0,'','custom_4', 'Custom 4',100, 'C' ,100,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200820) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200820,0,'','custom_n1', 'Custom n1',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200821) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200821,0,'','custom_n2', 'Custom n2',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200822) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200822,0,'','custom_n3', 'Custom n3',14, 'N' ,14,'','','','') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_fields where field_id = 200823) " + &
"  INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200823,0,'','custom_n4', 'Custom n4',14, 'N' ,14,'','','','') "

//Change 'IntelliContract' to 'Contract' - jervis 11.18.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"update sys_tables set table_name_allias = Substring(table_name_allias,8,1000)" +&
"where table_name_allias like 'IntelliContract/%'"


//Add group access for compamy -- jervis 12.02.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"update icred_settings set company_group_access = 1 where company_group_access is null" 

//Added By Ken.Guo 2010-12-02.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update em_user_config set email_log = 2 where email_log = 1"

//Added By Ken.Guo 2010-12-03.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings set receive_email = 0 Where receive_email is null"

//Added By Ken.Guo 2010-12-06.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings set run_alarm = 1 Where run_alarm is null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update ctx_req_tmplt_element set show_word_ico = 1 Where show_word_ico is null"

//Added By Ken.Guo 2010-12-07.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update ctx_getting_started set tips = 'Manage Users' Where id = 8 and tips = 'Manager Users'"

//Added By Ken.Guo 2011-04-19.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update tdl_detail set user_type = 1 where user_type is null"


//Init contract custom status data -- jervis 04.26.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'ACTIVE') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'ACTIVE' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','ACTIVE','Active','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'HISTORY') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'HISTORY' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','HISTORY','History','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'EXPIRED') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'EXPIRED' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','EXPIRED','Expired','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'CANCELED') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'CANCELED' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','CANCELED','Canceled','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'INACTIVE') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'INACTIVE' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','INACTIVE','Inactive','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status1' and code = 'PENDING') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status1' and code = 'PENDING' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status1','PENDING','Pending','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'ACTIVE') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'ACTIVE' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','ACTIVE','Active','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'HISTORY') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'HISTORY' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','HISTORY','History','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'EXPIRED') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'EXPIRED' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','EXPIRED','Expired','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'CANCELED') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'CANCELED' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','CANCELED','Canceled','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'INACTIVE') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'INACTIVE' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','INACTIVE','Inactive','S','NA','YES')   " + &
"end "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Custom Status2' and code = 'PENDING') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Custom Status2' and code = 'PENDING' and lookup_type='C') " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_2,custom_3) VALUES ( @li_id  ,'Contract Custom Status2','PENDING','Pending','S','NA','YES')   " + &
"end "

//Added By Ken.Guo 2011-05-06. for Open PDF Mode
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings set openpdfwith = 2 Where openpdfwith is null"


of_execute_sqls("of_ver100_release_data1")

Return 1

end function

public function integer of_ver105_release_data1 ();
//Added By Ken.Guo 2011-05-26. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Contract Action Type' and code in( 'Esign','Doc-Esign','Doc-Esign-Request')) ~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type,custom_1) ~r~n" + &
"       values (@li_id ,'Contract Action Type' ,'Doc-Esign-Request','Document Electronic Signature Request','S','Doc-Esign-Request')~r~n" + &
"end~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings set esign = 1 where esign is null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings set es_apicode = '1e111366-9f69-102d-a0b1-db73b11b73f0' where es_apicode is null"

//Change Analysis to Custom Nulti - jervis 06.02.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"update SECURITY_SUB_MODULE set sub_module_name = 'Custom Multi' where module_id = 33 and sub_module_id = 390 and prod_id = 1"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"update Security_rights_action set Action_name = 'Custom Data 2' where Action_id = 2093 and Module_id = 33 and sub_module_id = 310"

//add custom2 and multi view -- jervis 06.08.2011
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1  from view_alias where v_name = 'v_ctx_custom2') " + &
"  INSERT INTO view_alias (v_name,v_alias,module,screen,sflag,p_name) VALUES ('v_ctx_custom2','Contract Custom Data 2',1,'10','Y','1-08.gif')  " //add screen id:10 - jervis 09.06.2011

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1  from view_alias where v_name = 'v_ctx_multi_header') " + &
"  INSERT INTO view_alias (v_name,v_alias,module,screen,sflag,p_name) VALUES ('v_ctx_multi_header','Contract Multi Header',1,'53','Y','1-09.gif')  "

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1  from view_alias where v_name = 'v_ctx_multi_detail') " + &
"  INSERT INTO view_alias (v_name,v_alias,module,screen,sflag,p_name) VALUES ('v_ctx_multi_detail','Contract Multi Detail',1,'55','Y','1-10.gif')  "

//Added By Ken.Guo 2011-06-28. 
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update security_users set refresh_sertifi = 1 where refresh_sertifi is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update security_users set refresh_sertifi_dm = 1 where refresh_sertifi_dm is null"

//add by jervis 07.01.2011
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_action_items set level_id1 = 0 where level_id1 is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_action_items set level_id2 = 0 where level_id2 is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_action_items set doc_id = 0 where doc_id is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_alm_snooze set level_id1 = 0 where level_id1 is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_alm_snooze set level_id2 = 0 where level_id2 is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_alm_snooze set doc_id = 0 where doc_id is null"

//Added By Ken.Guo 2011-07-14. 
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Status' and code = 'Signed')  " + &
"begin " + &
"  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Action Status','Signed','Electronic Signed','S')   " + &
"end "

//Added By Ken 08/05/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update ctx_notification Set alm_notification_days = 0 where alm_notification_days is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update ctx_ai_notification Set alm_notification_days = 0 where alm_notification_days is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update ctx_am_ai_notification Set alm_notification_days = 0 where alm_notification_days is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update wf_workflow set suppress_alert = 0 where suppress_alert is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update icred_settings set filter_template = 0 where filter_template is null"

//Update screenid for view alias - jervis 09.06.2011
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update view_alias set screen = '10' where v_name = 'v_ctx_custom2' and (screen is null or screen = '')"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update view_alias set screen = '53' where v_name = 'v_ctx_multi_header' and (screen is null or screen = '')"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update view_alias set screen = '55' where v_name = 'v_ctx_multi_detail' and (screen is null or screen = '')"

//Added By Ken 09/22/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update em_smtp_accounts set smtp_ssl = 0 Where smtp_ssl is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update em_smtp_accounts set pop3_ssl = 0 Where pop3_ssl is null"

//Added By Ken 09/29/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update security_users set check_email = 1 where check_email is null"

//Add by jervis 10.12.2011
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update view_alias set v_name = 'v_ctx_document' where v_name = 'v_ctx_Document'"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update icred_settings set use_opsyntax = 1 where use_opsyntax is NULL"

//Can't delete the special objects for optimize mode - jervis 10.18.2011
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen set fix_field = 'app_facility,status,category,fee_sched_calc_field_1,fee_sched_calc_field_2,fee_sched_calc_field_3' where screen_id in (2,9) and fix_field is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen set fix_field = 'app_facility,status,category' where screen_id in (1,3)  and fix_field is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen set fix_field = 'calc_field_1,calc_field_2,calc_field_3' where screen_id = 31  and fix_field is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"update ctx_screen set fix_field = 'readonly_flag' where screen_id in (46,47)  and fix_field is null"


//delete document audit painter tab
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"delete SECURITY_ROLES_RIGHTS where ACTION_ID = 6936"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"delete SECURITY_RIGHTS_ACTION where MODULE_ID = 33 and SUB_MODULE_ID = 370 and action_id = 6936"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"delete ctx_tabpage_screen where ts_id in (56,57,58)"

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"delete ctx_screen where screen_id = 48 or screen_id = 49"

//Added By Ken.Guo 2011-11-12.  for Thin Web Review/Approve
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Contract Action Type' and code in( 'WebApproval','Doc-Approval','Doc-Approval-Request')) ~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type,custom_1) ~r~n" + &
"       values (@li_id ,'Contract Action Type' ,'Doc-Approval-Request','Document Approval Request','S','Doc-Approval-Request')~r~n" + &
"end~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Status' and code = 'Approved')  " + &
"	begin " + &
"  		select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  		INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Action Status','Approved','Approved','S')   " + &
"	end  "  + &
"Else  " + &
"	Update code_lookup set type = 'S' Where lookup_name = 'Contract Action Status' and code = 'Approved'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Status' and code = 'ApprovedWithChanges')  " + &
"	begin " + &
"  		select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  		INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Action Status','ApprovedWithChanges','ApprovedWithChanges','S')   " + &
"	end  "  + &
"Else  " + &
"	Update code_lookup set type = 'S' Where lookup_name = 'Contract Action Status' and code = 'ApprovedWithChanges'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Status' and code = 'Rejected')  " + &
"	begin " + &
"  		select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  		INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Action Status','Rejected','Rejected','S')   " + &
"	end  "  + &
"Else  " + &
"	Update code_lookup set type = 'S' Where lookup_name = 'Contract Action Status' and code = 'Rejected'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"declare @li_id int " + &
"if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Status' and code = 'Submitted')  " + &
"	begin " + &
"  		select @li_id = max(lookup_code) + 1 from code_lookup " + &
"  		INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES ( @li_id  ,'Contract Action Status','Submitted','Submitted','S')   " + &
"	end  "  + &
"Else  " + &
"	Update code_lookup set type = 'S' Where lookup_name = 'Contract Action Status' and code = 'Submitted'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ids set approve_id = 10000 where approve_id is null"

//Added By Ken.Guo 12/10/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ctx_user_tv_settings set tv_type = 'row' where tv_type is null"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update ctx_user_tv_settings set show_data = 1 Where show_data is null"


//Added By Ken.Guo 12/27/2011. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"declare @li_id int~r~n" + &
"if Not Exists (select 1 ~r~n" + &
"                 from code_lookup ~r~n" + &
"                where lookup_name = 'Contract Document Status' and code = 'Signed') ~r~n" + &
"begin~r~n" + &
"  select @li_id = Max(lookup_code) + 1 from code_lookup~r~n" + &
"  insert into code_lookup (lookup_code,lookup_name,code,description,type,custom_1) ~r~n" + &
"       values (@li_id ,'Contract Document Status' ,'Signed','Signed','S','0')~r~n" + &
"end~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update code_lookup set code = 'Doc-Esign' where code = 'Esign' and lookup_name = 'Contract Action Type' and type = 'S'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update code_lookup set code = 'Doc-Approval' where code = 'WebApproval' and lookup_name = 'Contract Action Type' and type = 'S'"

//is_sql_statements[upperbound(is_sql_statements) + 1] =& 
//"Update security_users Set role_id = 1 where role_id is null"

//Added By Ken.Guo 01/04/2012. 

//---------Begin Modified by (Appeon)Stephen 10.29.2013 for  V14 Testing Bug #3715--------
/*
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'Doc-Approval-CheckIn') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Action Type' and code = 'Doc-Approval-CheckIn' and lookup_type='C') " + &
*/
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'Doc-Approval-CheckIn') " + &
"	begin " + &
"	  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"	  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_1,modify_date) VALUES ( @li_id  ,'Contract Action Type' , 'Doc-Approval-CheckIn','Document Approval Check In','S', 'Doc-Approval-CheckIn',getdate())  " + &
"	end "
//---------Modified end-----------------------------------------------------

//---------Begin Modified by (Appeon)Stephen 10.29.2013 for  V14 Testing Bug #3715--------
/*
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'Doc-Esign-CheckIn') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Action Type' and code = 'Doc-Esign-CheckIn' and lookup_type='C') " + &
*/
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'Doc-Esign-CheckIn') " + &
"	begin " + &
"	  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"	  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_1,modify_date) VALUES ( @li_id  ,'Contract Action Type' , 'Doc-Esign-CheckIn','Document Electronic Signature Check In','S', 'Doc-Esign-CheckIn',getdate())  " + &
"	end "
//---------Modified end-----------------------------------------------------

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update code_lookup set code = 'Doc-Esign-Request' where code = 'Doc-Esign' and lookup_name = 'Contract Action Type' and type = 'S'"

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"Update code_lookup set code = 'Doc-Approval-Request' where code = 'Doc-Approval' and lookup_name = 'Contract Action Type' and type = 'S'"

//added by gavin 2012-01-05
is_sql_statements[upperbound(is_sql_statements) + 1] =& 
" update security_users set refresh_sertifi_time = 60 where   refresh_sertifi_time  is null  "

is_sql_statements[upperbound(is_sql_statements) + 1] =& 
"update security_users set refresh_approve_time  = 60 where  refresh_approve_time  is null  "

//add by gavins 20120207
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(Select 1 from import_tables where table_id = 1008 and table_name = 'ctx_custom') " + &
"	Insert Into import_tables Values(1008,'ctx_custom','Custom Data 2',2) "

//Added By Ken.Guo 02/22/2012. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"	Update code_lookup set code = 'Rejected' Where lookup_name = 'Contract Action Status' and code = 'Reject' and type = 'S'"


of_execute_sqls("of_ver105_release_data1")

Return 1

end function

public function integer of_clx110_updates ();of_ver90_release_data1()

of_ver95_release_data1()
of_ver95_release_data2()

of_ver100_release_data1()
of_move_org_sent_items()
of_add_default_group_eamail() 
of_alarm_convert_txt2doc() 

of_ver105_release_data1()
of_add_sertifi_tdl() 
of_add_webapprove_tdl()
of_fix_screen_depend_field() 

Integer li_main_version
String ls_patch_version

//Added By Ken.Guo 03/20/2012. Fixed Create Action Item Bug One Time 
Select set_18,set_patch_ver Into :li_main_version, :ls_patch_version From icred_settings;
If li_main_version < 141 Or ( li_main_version = 141 And ls_patch_version < '002' ) Then
	This.of_fix_alarm_create_action( )
End If

of_ver110_release_data1( )

Return 1
end function

public function integer of_move_org_sent_items ();//////////////////////////////////////////////////////////////////////
// Function: of_move_org_sent_items()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-03-29
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Boolean lb_autocommit
String ls_err 
long ll_count,i,ll_max_id,ll_begin,ll_end, ll_step = 100
lb_autocommit = SQLCA.autocommit

Select Count(1),Max(id) Into :ll_count,:ll_max_id From em_sent_items where is_moved = 0 or is_moved is null;

If ll_count = 0 Then Return 0

SQLCA.autocommit = False

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Moving Original Sent Items, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Moving Original Sent Items, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_max_id)

i = 0
Do While (i - 1)*ll_step < ll_count
	Yield()
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Moving Original Sent Items ('+ String((i+1)*ll_step) + '/' + String(ll_max_id)+'), Please stand by'
	ll_begin = i*ll_step + 1
	ll_end =  (i+1)*ll_step
	w_infodisp.wf_step(ll_step)
	//Move Original Sent Items to New Table.
	Insert  em_mail_items (user_id,folder_id,sub_folder_id,mail_date,mail_subject,mail_importance,mail_from,
	mail_to,mail_cc,mail_rfc822,mail_attach_name,mail_type,mail_format,mail_ctx_id,mail_doc_id,mail_action_item_id,
	mail_fromclx,mail_save_format,last_modify_date,read_status,locked,deleted,flag,notes,ctx_id_list)
		Select user_id,3,3,sent_time,subject,0,mail_from,
		mail_to,mail_cc,mail_content,attach_name,mail_type,mail_format,ctx_id,doc_id,action_item_id,
		2,'doc',getdate(),1,0,0,0,'Move from old table',ctx_id_list
		From em_sent_items where (is_moved = 0 or is_moved is null) and (id >= :ll_begin and id <= :ll_end);
	
	//Commit and Set flag for original table column.
	If SQLCA.sqlcode < 0 Then
		ls_err = SQLCA.sqlerrtext
		Rollback;
		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('Insert SQL', ls_err,'Moving Original Sent Items')
		gb_upgrade_failed = TRUE
	Else
		Update em_sent_items Set is_moved = 1 Where (is_moved = 0 or is_moved is null) and (id >= :ll_begin and id <= :ll_end) ;
		If sqlca.sqlcode < 0 Then
			ls_err = SQLCA.sqlerrtext
			Rollback;
			gb_upgrade_failed = TRUE
			IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('Update SQL', ls_err,'Moving Original Sent Items')
		Else
			Commit;
		End If
	End If
	i++
Loop

w_infodisp.wf_step(ll_step)
SQLCA.autocommit = lb_autocommit
IF IsValid(w_infodisp) Then Close(w_infodisp)
Return 1
end function

public subroutine of_add_default_group_eamail ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_update_sql.of_add_default_group_eamail()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Add Default Group Email Template.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-19 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_Max_ID,ll_exists
Blob lb_data
oleobject ole_selection

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Default Group Email Template'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Adding Default Group Email Template, Please stand by...'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,5)


ll_Max_ID = gnv_app.of_get_id("email_id")

Select Count(1) Into :ll_exists from wf_email Where email_name = :gs_default_group_name;
If ll_exists > 0 Then 
	If isvalid(w_infodisp) Then Close(w_infodisp)
	Return  
End If

Insert Into wf_email(email_id,email_name,module,subject,auto_sign)
Values(:ll_max_id,:gs_default_group_name,'05','Contract Date Alarm(s)','Y');

w_infodisp.wf_step(2)

If SQLCA.sqlcode <> 0 Then 
	If isvalid(w_infodisp) Then Close(w_infodisp)
	Return
End If

Open(w_email_edit)
w_email_edit.ole_word.of_open()

If w_email_edit.ole_word.object.doctype <> 1 Then  //Word
	Delete From wf_email Where email_name = :gs_default_group_name;
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('', 'Failed to Create the Default Group Email Alarm Template(Not Install MS Word)','Default Group Email Alarm Template')
	gb_upgrade_failed = TRUE
	Close(w_email_edit)
	If isvalid(w_infodisp) Then Close(w_infodisp)
	Return 
End If

w_infodisp.wf_step(3)

w_email_edit.ole_word.object.ActiveDocument.Content.Select()
ole_selection = w_email_edit.ole_word.object.activedocument.ActiveWindow.Selection
ole_selection.TypeText('Hi, ~r~nThe following contract(s) requires your attention:~r~n$<Alarm List>$ ')

w_email_edit.ole_word.of_GetBlob(lb_data)
UPDATEBLOB wf_email SET email_message = :lb_data WHERE email_id = :ll_Max_ID;
	
If SQLCA.sqlcode <> 0 Then 
	Delete From wf_email Where email_name = :gs_default_group_name;
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('UPDATEBLOB wf_email SET email_message = :lb_data WHERE email_id = :ll_Max_ID;', 'Failed to Create the Default Group Email Alarm Template(Not Install MS Word)','Default Group Email Alarm Template')
	gb_upgrade_failed = TRUE	
	w_email_edit.ole_word.of_close()
	Close(w_email_edit)	
	If isvalid(w_infodisp) Then Close(w_infodisp)
	Return
End If

w_infodisp.wf_step(5)
w_email_edit.ole_word.of_close()
Close(w_email_edit)
If isvalid(w_infodisp) Then Close(w_infodisp)
Return 
	
end subroutine

public function integer of_add_sertifi_tdl ();//////////////////////////////////////////////////////////////////////
// Function: of_add_sertifi_tdl()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-21.
//--------------------------------------------------------------------
// Description: Add a default TDL with sertifi
// Modfiy History:  (Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Integer li_added
Long ll_max_tdl,ll_max_tdl_sub,ll_action_type
long ll_status_complete,ll_status_incomplete,ll_status_signed,ll_action_type_checkin

gnv_appeondb.of_startqueue( )
	Select es_added_tdl Into :li_added From ids;
	Select Max(tdl_id) Into :ll_max_tdl From TDL_Basic_info;
	Select lookup_code Into :ll_action_type From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-Request';
	Select lookup_code Into :ll_action_type_checkin From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-CheckIn';
	Select lookup_code Into :ll_status_complete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete';
	Select lookup_code Into :ll_status_incomplete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete';	
	Select lookup_code Into :ll_status_signed From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Signed';	
gnv_appeondb.of_commitqueue( )

If li_added = 1 Then Return 1
If isnull(ll_action_type) or isnull(ll_status_complete) or ll_action_type = 0 or ll_status_complete = 0 Then 
	Messagebox('','failed to add signature default To Do List.')
	Return -1
End If

If isnull(ll_max_tdl) Then
	ll_max_tdl = 1
Else
	ll_max_tdl ++
End If

//Insert TDL
long ll_cnt
select count(*) into :ll_cnt from TDL_Basic_info where tdl_name='Document - Electronic Signature Requests' and module='04';
if isnull(ll_cnt) then ll_cnt = 0
if ll_cnt > 0 then  //Modified By Jay Chen 10-21-2013
	update TDL_Basic_info set notes='Electronic signature on signature server.' where tdl_name='Document - Electronic Signature Requests' and module='04';
else
	Insert Into TDL_Basic_info(tdl_id,tdl_name,module,notes) Values(:ll_max_tdl,'Document - Electronic Signature Requests','04','Electronic signature on signature server.');
end if
If SQLCA.sqlcode <> 0 Then 
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item for Incomplete For Signer
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,1,null,1,'## Incomplete Requests - Documents are Pending Electronic Signature',1,:ll_action_type,
	:ll_status_incomplete,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	32,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id = 1;
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "incomplete" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item for InComplete For Sender
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,2,null,2,'## Incomplete Requests - Documents are NOT signed and Pending Check In',1,:ll_action_type_checkin,
	:ll_status_incomplete,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	32,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id in (1,2);
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "Incomplete2" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item for Complete for Sender
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,3,null,3,'## Completed Requests - Documents are signed and Pending Check In',1,:ll_action_type_checkin,
	:ll_status_signed,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	32,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id in (1,2,3);
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "Complete" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Set roles access
Insert Into tdl_security_roles_rights Select role_id,:ll_max_tdl,1 from  security_roles;
If SQLCA.sqlcode <> 0 Then 
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to set roles right of Signature Document. ' )
	gb_upgrade_failed = TRUE
End If


Update ids set es_added_tdl = 1;

Return 1





end function

public function integer of_add_webapprove_tdl ();//////////////////////////////////////////////////////////////////////
// Function: of_add_webapprove_tdl()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-11-22.
//--------------------------------------------------------------------
// Description: Add a default ToDoList with WebApprove
// Modfiy History:  (Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Integer li_added
Long ll_max_tdl,ll_max_tdl_sub,ll_action_type,ll_action_type_checkin
long ll_status_complete,ll_status_incomplete,ll_status_submitted

gnv_appeondb.of_startqueue( )
	Select webapprove_added_tdl Into :li_added From ids;
	Select Max(tdl_id) Into :ll_max_tdl From TDL_Basic_info;
	Select lookup_code Into :ll_action_type_checkin From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Approval-CheckIn';
	Select lookup_code Into :ll_action_type From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Approval-Request';
	Select lookup_code Into :ll_status_complete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete';
	Select lookup_code Into :ll_status_incomplete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete';	
	Select lookup_code Into :ll_status_submitted From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Submitted';	
gnv_appeondb.of_commitqueue( )

If li_added = 1 Then Return 1
If isnull(ll_action_type) or isnull(ll_status_complete) or ll_action_type = 0 or ll_status_complete = 0 Then 
	Messagebox('','failed to add web approval default To Do List.')
	Return -1
End If

If isnull(ll_max_tdl) Then
	ll_max_tdl = 1
Else
	ll_max_tdl ++
End If

//Insert TDL
Insert Into TDL_Basic_info(tdl_id,tdl_name,module,notes) Values(:ll_max_tdl,'Document - Approval Requests','04','Web Document Approval Requests.');
If SQLCA.sqlcode <> 0 Then 
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list for web approval. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item for Incomplete for Approver
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,1,null,1,'## Pending Approval - Approver',1,:ll_action_type,
	:ll_status_incomplete,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	31,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id = 1;
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "incomplete" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item with submitted for Sender 
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,2,null,2,'## Checked out for Approval - Sender',1,:ll_action_type_checkin,
	:ll_status_incomplete,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	31,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id in (1, 2);
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "Submitted" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Insert TDL Item for submitted for Sender
Insert Into tdl_detail(tdl_id,tdli_id,tdli_name,tdl_sort,verbiage,allow_drill_down,action_type,
	action_status,Print_flag,due_date,max_sends_flag,display01,display02,display03,display04,
	moveto,user_type,use_graph,tv_icon)
Values(:ll_max_tdl,3,null,3,'## Submitted and Ready for Check-in - Sender',1,:ll_action_type_checkin,
	:ll_status_submitted,-1,-1,0,'ctx_id','ctx_basic_info_app_facility','Doc_id','due_date',
	31,1,0,'Custom039!')	;
If SQLCA.sqlcode <> 0 Then 
	Delete from tdl_detail where tdl_id = :ll_max_tdl and tdli_id in (1,2,3);
	Delete from TDL_Basic_info where tdl_id = :ll_max_tdl;
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to add to do list item "Submitted" for signature. ' )
	gb_upgrade_failed = TRUE
	Return -1
End If

//Set roles access 
Insert Into tdl_security_roles_rights Select role_id,:ll_max_tdl,1 from  security_roles;
If SQLCA.sqlcode <> 0 Then 
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(2,'Failed to set roles right of web approval Document. ' )
	gb_upgrade_failed = TRUE
End If


Update ids set webapprove_added_tdl = 1;

Return 1





end function

public subroutine of_alarm_convert_txt2doc ();//////////////////////////////////////////////////////////////////////
// Function: of_alarm_convert_txt2doc()
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-05-20.
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_cnt,i,ll_ctx_id
String ls_table, ls_column,ls_filename_word,ls_alm_message
DataStore lds_alarms_txt
Blob lb_alm_data,lb_alm_data_word
n_cst_dm_utils lnv_dm_utils
oleobject lole_word
oleobject lole_document,lole_window
long ll_spent_time,ll_left_time,ll_cpu,ll_min,ll_sec

lds_alarms_txt = Create DataStore
lds_alarms_txt.DataObject = 'd_alarms_txt_format'
lds_alarms_txt.SetTransObject(SQLCA)
ll_cnt = lds_alarms_txt.Retrieve()


If ll_cnt <= 0 Then Return

//Create Word
Try
	If Not isvalid(lole_word) Then lole_word = Create oleobject
	IF lole_word.Connecttonewobject("word.application") = 0 THEN
		lole_word.Application.NormalTemplate.Saved = TRUE 
		lole_word.Visible = False
		lole_word.Application.Documents.Add()
		lole_document = lole_word.ActiveDocument
		lole_window = lole_document.ActiveWindow
	Else
		Return
	End If
Catch(OLERunTimeError err2)
	If isvalid(lole_word) Then Destroy lole_word
	Return
End Try 

//Open process bar
IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Convert Date Alarm Format'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Convert date alarm plain text to word format, please stand by...'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_cnt)

ll_cpu = cpu()
For i = 1 To ll_cnt
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Convert date alarm plain text to word format ('+String(i)+'/'+String(ll_cnt) + '), please stand by...'
	IF IsValid( w_infodisp ) THEN w_infodisp.wf_step(1)
	
	If Mod(i,5) = 0 Then
		ll_spent_time = cpu() - ll_cpu
		ll_left_time = ll_spent_time/i * (ll_cnt - i) / 1000
		ll_min = Truncate(ll_left_time/60,0)
		ll_sec = Mod(ll_left_time,60)
		IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Convert Date Alarm Format, ' + String(ll_min) + ' min ' + String(ll_sec) + ' sec remaining' 
	End If
	
	//Get the Alarm Message Data
	ll_ctx_id = lds_alarms_txt.GetItemNumber(i,'ctx_id')
	ls_table = lds_alarms_txt.GetItemString(i,'alm_table')
	ls_column = lds_alarms_txt.GetItemString(i,'alm_column')
	Select alm_message Into :ls_alm_message 
	From ctx_notification 
	Where ctx_id = :ll_ctx_id And alm_table = :ls_table And alm_column = :ls_column;

	//Generate file name
	ls_filename_word = lnv_dm_utils.of_gettempfilename('alarm_' + String(ll_ctx_id) +'_'+ ls_column )
	
	Try 
		//Delete old content
		lole_document.Content.Select()
		lole_window.Selection.Delete()
		
		//Insert new content
		lole_window.Selection.Typetext(ls_alm_message) //Replace with new text
		lole_document.saveas(ls_filename_word,0,false,'',false)
		gnv_shell.of_delete_recent( ls_filename_word, true)  

		//Check file
		If not FileExists(ls_filename_word) Then Continue
		
		//Upload to DB
		If lnv_dm_utils.of_readblob( ls_filename_word, lb_alm_data_word) > 0 Then
			UpdateBlob ctx_notification Set alm_message_blob = :lb_alm_data_word 
			Where ctx_id = :ll_ctx_id And alm_table = :ls_table And alm_column = :ls_column ;
		End If
		
		If FileExists(ls_filename_word) Then FileDelete(ls_filename_word)

	CATCH (OLERuntimeError  th2)
		messagebox('Error',th2.text )
		lole_document.Close(0) //wdDoNotSaveChanges
		lole_word.Quit(0) //wdDoNotSaveChanges
		lole_word.DisconnectObject( )
		If isvalid(lole_word) Then Destroy lole_word
		IF IsValid( w_infodisp ) Then Close(w_infodisp)
		RETURN 
	END TRY
Next

Try
	lole_document.Close(0) //wdDoNotSaveChanges
	lole_word.Quit(0) //wdDoNotSaveChanges
	lole_word.DisconnectObject( )
Catch(OLERunTimeError err3)
	//
End Try
If isvalid(lole_word) Then Destroy lole_word

IF IsValid( w_infodisp ) Then Close(w_infodisp)


end subroutine

public subroutine of_fix_screen_depend_field ();//Fixed bug. depend fields support every view now. 

Long li_exists_all,li_exists_null,li_exists,i,j,ll_cnt
Long ll_fields_cnt, ll_depend_cnt, ll_view_id, ll_screen_id
n_ds lds_depend_main, lds_depend_fields

lds_depend_main = Create n_ds
lds_depend_fields = Create n_ds
lds_depend_main.Dataobject = 'd_ctx_screen_fields_depend'
lds_depend_fields.Dataobject = 'd_ctx_lookup_depend_all'

lds_depend_main.SetTransObject(SQLCA)
lds_depend_fields.SetTransObject(SQLCA)

//Get Basic info
gnv_appeondb.of_startqueue( )
	Select Count(1) Into :li_exists_all From  ctx_lookup_depend;
	Select Count(1) Into :li_exists_null From  ctx_lookup_depend Where View_Id is null;
	lds_depend_main.Retrieve()
	lds_depend_fields.Retrieve()
gnv_appeondb.of_commitqueue( )
ll_depend_cnt =  lds_depend_main.RowCount()
ll_fields_cnt =  lds_depend_fields.RowCount()


If ll_depend_cnt = 0  or ll_fields_cnt = 0 Then Return

If li_exists_all > 0 and li_exists_all = li_exists_null Then  //Update only for first running
	
	//Show tips
	IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
	IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Generating Depend Field Data for Screen, Please stand by'
	IF IsValid(w_infodisp) THEN w_infodisp.Center = True
	IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Generating Depend Field Data for Screen, Please stand by'
	IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_depend_cnt + 1)
	
	//Add View/Screen Data for current Depend Fields Data, and Copy Depend Fields Data to Other View/Screen.
	For i = 1 To ll_depend_cnt
		
		If isvalid(w_infodisp) Then w_infodisp.wf_step(i)
		
		ll_view_id = lds_depend_main.GetItemNumber(i,'view_id')
		ll_screen_id = lds_depend_main.GetItemNumber(i,'base_screen_id')
		
		//Set Original Data's view id and screen id
		If i = ll_depend_cnt Then
			For j = 1 To ll_fields_cnt 
				lds_depend_fields.SetItem(j,'view_id', ll_view_id)
				lds_depend_fields.SetItem(j,'screen_id', ll_screen_id)			
			Next
			Exit
		End If
		
		//Copy data for other view/screen 
		ll_cnt = lds_depend_fields.Rowcount()
		lds_depend_fields.RowsCopy( 1,ll_fields_cnt, Primary!, lds_depend_fields,ll_cnt + 1, Primary!)
		For j = ll_cnt + 1 To  lds_depend_fields.Rowcount()
			lds_depend_fields.SetItem(j,'view_id', ll_view_id)
			lds_depend_fields.SetItem(j,'screen_id', ll_screen_id)
		Next
		
		//Save Data each 500 rows
		If lds_depend_fields.Modifiedcount( ) >= 500 Then
			If lds_depend_fields.Update() = 1 Then
			Else
				IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('of_fix_screen_depend_field(), Failed to update the depend field data.')
				gb_upgrade_failed = TRUE			
			End If			
		End If
		
	Next
	
	//Save Data
	If isvalid(w_infodisp) Then w_infodisp.wf_step(ll_depend_cnt + 1)
	If lds_depend_fields.Modifiedcount( ) > 0 Then
		If lds_depend_fields.Update() = 1 Then
		Else
			IF IsValid(gnv_logservice)THEN gnv_logservice.of_log('of_fix_screen_depend_field(), Failed to update the depend field data.')
			gb_upgrade_failed = TRUE			
		End If
	End If
	
	If isvalid(w_infodisp) Then Close(w_infodisp)
	
End If

	
	

end subroutine

public function integer of_fix_alarm_create_action (string as_user_id, string as_email_id);//////////////////////////////////////////////////////////////////////////////////////
// Function: of_fix_alarm_create_action
// Arguments:
// 	as_user_id
// 	as_email_id
//-----------------------------------------------------------------------------------
// Return:  integer
//-----------------------------------------------------------------------------------
// Author:	 Ken.Guo 03/20/2012.
//-----------------------------------------------------------------------------------
// Description: Fixed Create Action Item's Bug
//-----------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////

Long j
String ls_alarm_emails,ls_alarm_create
n_ds lds_alarms,lds_alarms_all,lds_Alarms_Templates


lds_alarms = Create n_ds
lds_alarms.dataobject = 'd_batch_update_alarm_emails'
lds_alarms.SetTransObject(SQLCA)

lds_alarms_all = Create n_ds
lds_alarms_all.dataobject = 'd_batch_update_all_alarm_emails'
lds_alarms_all.SetTransObject(SQLCA)

lds_Alarms_Templates = Create n_ds
lds_Alarms_Templates.dataobject = 'd_batch_update_all_alarm_template'
lds_Alarms_Templates.SetTransObject(SQLCA)

//Retrieve Data
gnv_appeondb.of_startqueue( )
	lds_alarms.Retrieve(Trim(as_email_id))
	lds_alarms_all.Retrieve(Trim(as_email_id))
	lds_Alarms_Templates.Retrieve(Trim(as_email_id))
gnv_appeondb.of_commitqueue( )	

//Update Classic Alarm
For j = 1 To lds_alarms.Rowcount()
	ls_alarm_emails = lds_alarms.GetItemString(j, 'alm_mailto')
	ls_alarm_create = lds_alarms.GetItemString(j, 'alm_create')
	If isnull(ls_alarm_create) Then ls_alarm_create = ''
	If Pos(Lower(ls_alarm_create) + ';',Lower(as_user_id) + ';'  ) = 0 Then
		If isnull(ls_alarm_create) or ls_alarm_create = '' Then
			lds_alarms.SetItem(j, 'alm_create', as_user_id)
		Else
			lds_alarms.SetItem(j, 'alm_create', ls_alarm_create + ';' + as_user_id)
		End If
	End If
Next

//Update Public Alarm
For j = 1 To lds_alarms_all.Rowcount()
	ls_alarm_emails = lds_alarms_all.GetItemString(j, 'alm_mailto')
	ls_alarm_create = lds_alarms_all.GetItemString(j, 'alm_create')
	If isnull(ls_alarm_create) Then ls_alarm_create = ''
	If Pos(Lower(ls_alarm_create) + ';',Lower(as_user_id) + ';'  ) = 0 Then
		If isnull(ls_alarm_create) or ls_alarm_create = '' Then
			lds_alarms_all.SetItem(j, 'alm_create', as_user_id)
		Else
			lds_alarms_all.SetItem(j, 'alm_create', ls_alarm_create + ';' + as_user_id)
		End If
	End If
Next

//Update Alarm Template
For j = 1 To lds_Alarms_Templates.Rowcount()
	ls_alarm_emails = lds_Alarms_Templates.GetItemString(j, 'alm_mailto')
	ls_alarm_create = lds_Alarms_Templates.GetItemString(j, 'alm_create')
	If isnull(ls_alarm_create) Then ls_alarm_create = ''
	If Pos(Lower(ls_alarm_create) + ';',Lower(as_user_id) + ';'  ) = 0 Then
		If isnull(ls_alarm_create) or ls_alarm_create = '' Then
			lds_Alarms_Templates.SetItem(j, 'alm_create', as_user_id)
		Else
			lds_Alarms_Templates.SetItem(j, 'alm_create', ls_alarm_create + ';' + as_user_id)
		End If
	End If
Next

//Save Data
gnv_appeondb.of_startqueue( )
	If lds_alarms.Modifiedcount( ) > 0 Then
		lds_alarms.Update()
	End If
	If lds_alarms_all.Modifiedcount( ) > 0 Then
		lds_alarms_all.Update()
	End If	
	If lds_Alarms_Templates.Modifiedcount( ) > 0 Then
		lds_Alarms_Templates.Update()
	End If		
gnv_appeondb.of_commitqueue( )	

//Destroy Object
If IsValid(lds_alarms) Then Destroy lds_alarms
If IsValid(lds_alarms_all) Then Destroy lds_alarms_all
If IsValid(lds_Alarms_Templates) Then Destroy lds_Alarms_Templates

Return 1
end function

public function integer of_fix_alarm_create_action ();//////////////////////////////////////////////////////////////////////////////////////
// Function: of_fix_alarm_create_action
// Arguments:
//-----------------------------------------------------------------------------------
// Return:  integer
//-----------------------------------------------------------------------------------
// Author:	 Ken.Guo 03/20/2012.
//-----------------------------------------------------------------------------------
// Description:Fixed Create Item Bug.
//-----------------------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////////////////////


String ls_EmailID, ls_UserID
n_ds lds_all_user_email
Long i

lds_all_user_email = Create n_ds
lds_all_user_email.Dataobject ='d_notification_users_select'
lds_all_user_email.SetTransObject(SQLCA)
lds_all_user_email.Retrieve()

For i = 1 To lds_all_user_email.RowCount()
	ls_UserID = lds_all_user_email.GetItemString(i,'user_id')
	ls_EmailID = lds_all_user_email.GetItemString(i,'email_id')
	of_fix_alarm_create_action(ls_UserID, ls_EmailID)
Next

Return 1
end function

public function integer of_backup_allscreen ();
IF Upper(gs_dbtype) = "ASA"  THEN RETURN 1

//
n_cst_update_screen lno_screen

String		ls_Version

lno_screen = create n_cst_update_screen  //added by gavins 20120314 grid
ls_Version = lno_screen.is_screen_version
If IsValid( lno_screen ) Then Destroy( lno_screen )


Long ll_count
SELECT count(*)  INTO :ll_count FROM  sysobjects   WHERE  name = 'ctx_screen'	AND   type = 'U';

//"select  @del_no= isnull(min( seq_no),0) " + &
//	"from  ctx_screen_bak " + &
//	" delete from  ctx_screen_bak " + &
//	"where seq_no=@del_no " + &
//modified by gavins 20120314 grid
if ll_count > 0 then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_ctx_screen'  AND  type = 'P') " + &
	"DROP PROCEDURE up_back_ctx_screen "
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"CREATE PROCEDURE  up_back_ctx_screen~r~n  " + &
	"AS~r~n  " + &
	"BEGIN ~r~n " + &
	" declare @del_no float ~r~n " + &
	" declare @max_no float ~r~n  " + &
	" declare @rowcount float ~r~n  " + &
	"if not exists (select TOP 1 1 " + &
	"from  sysobjects " + &
	"where  name='ctx_screen_bak' " + &
	"	and   type = 'U') ~r~n  " + &
	"begin ~r~n " + &
	"CREATE TABLE ctx_screen_bak( " + &
	"data_view_id int NOT NULL, " + &
	"screen_id int NOT NULL, " + &
	"dw_sql text  NULL, " + &
	"create_date datetime NULL, " + &
	"modify_date datetime NULL, " + &
	"backupdate datetime NOT NULL default getdate(), " + &
	"seq_no int NOT NULL,  " + &
	"version varchar(10)  NULL,  " + &
	"grid_sql text  NULL, screen_style varchar(1) null " + &
	")  ~r~n " + &
	"INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no, version, grid_sql, screen_style, user_id, notes ) " + &
	"SELECT data_view_id,screen_id,dw_sql,create_date,modify_date,1,'" + ls_Version + "',grid_sql, screen_style,'"+gs_user_id+"', 'Screen Upgrade'" + &
	"from ctx_screen ~r~n  " + &
	"end ~r~n  " + &
	"else ~r~n  " + &
	"begin ~r~n  " + &
	"if not exists( select 1 from syscolumns c , sysobjects t where ~r~n   " + &
	"c.id = t.id and c.name = 'version' and t.name = 'ctx_screen_bak' and t.type = 'U' )  " + &
	"alter table ctx_screen_bak add version varchar(10)  ~r~n  " + &
	"if not exists( select 1 from syscolumns c , sysobjects t where  ~r~n  " + &
	"c.id = t.id and c.name = 'grid_sql' and t.name = 'ctx_screen_bak' and t.type = 'U' )  " + &
	"alter table ctx_screen_bak add grid_sql text  ~r~n  " + &
	"set  @rowcount=20  ~r~n " + &
	"  if not exists( select 1 from syscolumns c , sysobjects t where  c.id = t.id and c.name = 'screen_style' and t.name = 'ctx_screen_bak' and t.type = 'U' )~r~n" + &
	" alter table ctx_screen_bak add screen_style varchar(1)~r~n  " + &
	"begin ~r~n  " + &
	"delete  ctx_screen_bak ~r~n   " + &
	 " from ctx_screen_bak b inner join  " + &
	 " ( select data_view_id, screen_id from ctx_screen_bak  group by data_view_id, screen_id having count(*)> @rowcount ) c   " + &
	 " on b.data_view_id = c.data_view_id and b.screen_id = c.screen_id	 where not exists     " + &
	 "(  select 1 from ctx_screen_bak a where a.seq_no < b.seq_no and a.data_view_id = b.data_view_id and a.screen_id = b.screen_id )   ~r~n " + &
	" end ~r~n " + &
	"select  @max_no=isnull(max(seq_no),0) +1 " + &
	"from  ctx_screen_bak " + &
	"INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no, version, grid_sql, screen_style,user_id, notes) " + &
	"SELECT data_view_id,screen_id,dw_sql,create_date,modify_date,@max_no,'" + ls_Version + "',grid_sql, screen_style, '"+gs_user_id+"','Screen Upgrade'  " + &
	"from ctx_screen ~r~n  " + &
	"end ~r~n " + &
	"end ~r~n  "
	
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_ctx_screen'  AND  type = 'P') " + &
	"Exec up_back_ctx_screen "
	
	of_execute_sqls("of_backup_allScreen")
END if


return 1

end function

public function integer of_backup_screen (long al_view_id, long al_screen_id);//added by gavins   backup screen 
//of_backup_screen
//long  al_view_id,  al_screen_id
//return 1

n_cst_update_screen lno_screen

String		ls_Version

Long ll_i
String ls_null[]


lno_screen = create n_cst_update_screen  //added by gavins 20120314 grid
ls_Version = lno_screen.is_screen_version
If IsValid( lno_screen ) Then Destroy( lno_screen )


is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from syscolumns c , sysobjects t where  " + &
"c.id = t.id and c.name = 'version' and t.name = 'ctx_screen_bak' and t.type = 'U' )  " + &
"alter table ctx_screen_bak add version varchar(10)  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from syscolumns c , sysobjects t where   " + &
"c.id = t.id and c.name = 'grid_sql' and t.name = 'ctx_screen_bak' and t.type = 'U' )  " + &
"alter table ctx_screen_bak add grid_sql text "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  & 
"  if not exists( select 1 from syscolumns c , sysobjects t where  c.id = t.id and c.name = 'screen_style' and t.name = 'ctx_screen_bak' and t.type = 'U' )~r~n" + &
" alter table ctx_screen_bak add screen_style varchar(1)  "
	 	 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" delete  ctx_screen_bak  " + &
" from ctx_screen_bak b inner join  " + &
" ( select data_view_id, screen_id from ctx_screen_bak  group by data_view_id, screen_id having count(*)> 20 ) c   " + &
" on b.data_view_id = c.data_view_id and b.screen_id = c.screen_id	 where not exists     " + &
" (  select 1 from ctx_screen_bak a where a.seq_no < b.seq_no and a.data_view_id = b.data_view_id and a.screen_id = b.screen_id )   " 


If al_Screen_id = -9999 Then
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	" INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no, version, grid_sql, screen_style, user_id, notes)   " + &
	"SELECT data_view_id,screen_id,dw_sql,create_date,modify_date, " + &
	"(select  isnull(max(seq_no),0) +1 from  ctx_screen_bak where data_view_id = " + string( al_view_id ) + " and screen_id = tab.screen_id  ) ,'" + ls_Version +  "',grid_sql, screen_style,  '"+gs_user_id+"', 'Screen Batch Design'   " + &
	" from ctx_screen  tab  where data_view_id = " + string( al_view_id ) 
Else
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	" INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no, version, grid_sql, screen_style, user_id, notes)   " + &
	"SELECT data_view_id,screen_id,dw_sql,create_date,modify_date, " + &
	"(select  isnull(max(seq_no),0) +1 from  ctx_screen_bak where data_view_id = " + string( al_view_id ) + " and screen_id = " + string( al_screen_id ) + "  ) ,'" + ls_Version +  "',grid_sql, screen_style,  '"+gs_user_id+"', 'Screen Design'   " + &
	" from ctx_screen  where data_view_id = " + string( al_view_id ) + "  and screen_id =  " +  string( al_screen_id ) 
End If



IF UPPERBOUND(is_sql_statements) > 0 THEN 
		FOR ll_i = 1 TO upperbound(is_sql_statements)
			of_execute(is_sql_statements[ll_i],"of_backup_screen" )
		NEXT	
END IF

is_sql_statements = ls_null
return 1
end function

public subroutine of_check_ids ();//Add function by jervis 06.26.2009
//Check IDs
String ls_null[]
long lid
long eid
long tid
long vid  //Start Code Change ----02.13.2008 #V8 maha
long fid  //Start Code Change ----02.13.2008 #V8 maha
long tid2
long vid2 //Start Code Change ----02.13.2008 #V8 maha
long fid2  //Start Code Change ----02.13.2008 #V8 maha
long eid2
long lid2
long lid2_address,lid2_code


gnv_appeondb.of_startqueue( )
select lookup_code_id,export_id,rights_id, user_view_id, user_facility_id 
into :lid,:eid,:tid, :vid, :fid from ids;


select max(export_id) into :eid2 from export_header;
select max(rights_id) into :tid2 from security_roles_rights;
select max(user_view_id) into :vid2 from security_user_views;
select max(user_facility_id) into :fid2 from security_user_facilities;
select max(lookup_code) into :lid2_address from address_lookup;
select max(lookup_code) into :lid2_code from code_lookup;
gnv_appeondb.of_commitqueue( )


is_sql_statements = ls_null

//export
if eid < eid2 then
	is_sql_statements[upperbound(is_sql_statements) + 1] = &
	"update ids set export_id = " + string(eid2)
end if

//rights
if tid < tid2 then
	is_sql_statements[upperbound(is_sql_statements) + 1] = &
	"update ids set rights_id = " + string(tid2)
end if


//lookups
if lid2_code < lid2_address then 
	lid2_code = lid2_address
end if

if lid < lid2_code then 
	lid = lid2_code
	is_sql_statements[upperbound(is_sql_statements) + 1] = &
	"update ids set lookup_code_id = " + string(lid)
end if


//facility id (user)
if fid < fid2 then
	is_sql_statements[upperbound(is_sql_statements) + 1] = &
	"update ids set user_facility_id = " + string(fid2)
end if


//view id (user)
if vid < vid2 then
	is_sql_statements[upperbound(is_sql_statements) + 1] = &
	"update ids set user_view_id  = " + string(vid2)
end if

of_execute_sqls("of_check_IDs")

end subroutine

public function integer of_patch_screen ();//
//====================================================================
// Function: of_patch_screen
//--------------------------------------------------------------------
// Description:fix those screen that emptied
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-07-13
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
n_ds			lds_Screen, lds_Describe
Integer		li_Row, li_i
String			ls_Free, ls_Grid, ls_Syntax, ls_lookuplist, ls_opsyntax
Long			ll_View, ll_Screen
Blob			lb_Syntax, lb_Opsyntax

lds_Screen = Create n_ds
lds_Describe = Create n_ds

lds_Screen.DataObject = 'ds_screen_upgrade_repair'
lds_Screen.SetTransObject( sqlca )
If lds_Screen.Retrieve( ) > 0 Then
	For li_i = 1 To lds_Screen.RowCount( )
		ls_Free = lds_Screen.GetItemString( li_i, 'dataobject' )
		ls_Grid = lds_Screen.GetItemString( li_i, 'grid_dataobject' )
		ll_View = lds_Screen.object.data_view_id[ li_i ] 
		ll_Screen = lds_Screen.object.screen_id[ li_i ] 
		ls_Syntax=''
		ls_opsyntax=''
		If Len( ls_Free ) > 0 Then
			lds_Describe.DataObject = ls_Free
			ls_Syntax = lds_Describe.Describe( "datawindow.syntax" )
			If Len( ls_Syntax ) > 10 Then
				lb_Syntax = Blob( ls_Syntax )
				gf_get_opsyntax( ls_Syntax ,"",ls_opsyntax,ls_lookuplist)
				lb_Opsyntax = Blob( ls_opsyntax )
				UpdateBlob ctx_Screen Set dw_sql = :lb_Syntax where screen_id = :ll_Screen and data_view_id = :ll_View;
				UpdateBlob ctx_Screen Set dw_opsql = :lb_Opsyntax where screen_id = :ll_Screen and data_view_id = :ll_View;
			End If
			
		End If
		ls_Syntax = ''
		ls_opsyntax =''
		If len( ls_Grid ) > 0 Then
			lds_Describe.DataObject = ls_Grid
			ls_Syntax = lds_Describe.Describe( "datawindow.syntax" )
			If Len( ls_Syntax  ) > 10 Then
				lb_Syntax = Blob( ls_Syntax )
				gf_get_opsyntax( ls_Syntax ,"",ls_opsyntax,ls_lookuplist)
				lb_Opsyntax = Blob( ls_opsyntax )
				UpdateBlob ctx_Screen Set grid_sql = :lb_Syntax where screen_id = :ll_Screen and data_view_id = :ll_View;
				UpdateBlob ctx_Screen Set grid_opsql = :lb_Opsyntax where screen_id = :ll_Screen and data_view_id = :ll_View;
			End If
		End If
		
	Next
	
End If

Destroy( lds_Describe  )
Destroy( lds_Screen  )

Return 0
end function

public function integer of_ver115_release_data1 ();//====================================================================
//$<Function>: of_ver115_release_data1()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Added By Mark Lee 07/10/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings ~r~n set track_viewing = 1 ~r~n where track_viewing is null~r~n"

//Added By Ken.Guo 07/18/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 13 and charindex('clause,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'clause,b_1,t_1,t_2' where data_view_id = 1001 and screen_id = 13  ~r~n" 

//Added By Mark Lee 07/25/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" Update icred_settings ~r~n" + &
" set base_clause_rule_on = 1001 ~r~n" + &
" where base_clause_rule_on is null"

//Added By Ken.Guo 07/27/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set dwsavepdfway = 1 where dwsavepdfway is null "

//Added By Mark Lee 08/09/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Update icred_settings ~r~n set https = 0 ~r~n where https is null~r~n"


//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from sys_tables where table_id = 1065) ~r~n" + &
"  INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1065,	'd_contract_det_custom_2',	'Contract/Details/Custom Data 2',	NULL,	0,	NULL,	NULL,	NULL,'C')~r~n" 


//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_tables where table_id = 1066) ~r~n" + &
"  INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1066,	'd_contract_multi_header',	'Contract/Custom Multi/Header',	NULL,	0,	NULL,	NULL,	NULL,'C') ~r~n" 

//Added By gavins 20120815
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1 from sys_tables where table_id = 1067) ~r~n" + &
" INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1067,	'd_contract_multi_detail',	'Contract/Custom Multi/Detail',	NULL,	0,	NULL,	NULL,	NULL,'C')~r~n" 

//Added By Ken.Guo 08/17/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set preload_word = 0 where preload_word is null "

//Added By Gavins 08/22/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set alarm_ways = 0 where alarm_ways is null "

//Begin - Added By Mark Lee 10/22/12  cancel comment, it is usefull now .
////Added By Ken.Guo 08/28/2012. always using email plugin to send/receive email.
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"Update icred_settings set set_56 = 0"
//End - Added By Mark Lee 10/22/12

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for USbank Customer.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set default_copy_contract = '' Where default_copy_contract is null "


//Added By Ken.Guo 09/28/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 13 and charindex('clause,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'clause,b_1,t_1,t_2' where data_view_id = 1001 and screen_id = 13  ~r~n" 

//Added By Ken.Guo 09/28/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 51 and charindex('category,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'category,' where data_view_id = 1001 and screen_id = 51  ~r~n" 

//Added By Ken.Guo 09/28/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(select fix_field from ctx_screen where data_view_id = 1001 and screen_id = 52 and charindex('category,', fix_field)> 0 ) ~r~n" + &
"Update ctx_screen set fix_field = Isnull(fix_field,'') + 'category,' where data_view_id = 1001 and screen_id = 52  ~r~n" 


of_execute_sqls("of_ver115_release_data1")

Return 1
end function

public function integer of_ver120_release_data1 ();//====================================================================
// Function: of_ver120_release_data1
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/22/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//
//====================================================================

//code here
//Added By Mark Lee 07/10/12
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"Update icred_settings ~r~n set track_viewing = 1 ~r~n where track_viewing is null~r~n"

//Added By Gavins 10/22/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set  Appointment_create= 0 where Appointment_create is null "

//Added By Gavins 10/22/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set  Appointment_times= 0 where Appointment_times is null "

//Added By Mark Lee 11/05/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set set_56 = 0 where set_56 is null "

//Added By Ken.Guo 11/19/2012.  initialize custom 2 tabpge data.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Insert into ctx_custom (ctx_id) (Select ctx_id from ctx_basic_info where not exists(select 1 from ctx_custom a where a.ctx_id = ctx_basic_info.ctx_id ))"

//Added By Gavins 11/21/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"  Update em_smtp_accounts set  protocol = 'POP3' where protocol is null "

//Added By Gavins 11/21/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"  Update em_mail_items set  protocoltype = 'POP3' where protocoltype is null and folder_id = 2  "

//Added By Gavins 12/06/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from sys_fields where field_id = 200825) " + &
"   INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1031,200825,30,'','alm_mailto', 'Alarm MailTo',2000, 'C' ,2000,'','','','')   "

//Added By Gavins 12/06/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from sys_fields where field_id = 200826) " + &
"   INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1031,200826,30,'','alm_create', 'Create Action Item',2000, 'C' ,2000,'','','','')   "

//Added By Mark Lee 12/07/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set  sync_category= 0 where sync_category is null "

//Added By Ken.Guo 12/19/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_view = view_id where wf_triggered_view is null"

//Added By Ken.Guo 12/19/2012
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_view = 'all' where wf_triggered_view is null"

//Added By Ken.Guo 12/20/2012. compatible old versio, so set the initial value.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_ctx_status = ~r~n" + &
"Convert(varchar(20),(select top 1 lookup_code from code_lookup where lookup_name = 'Contract Status' and code = 'Pending')) ~r~n" + &
"where wf_triggered_ctx_status is null"

//Added By Ken.Guo 12/20/2012.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update wf_workflow Set wf_triggered_ctx_status = 'all' where wf_triggered_ctx_status is null"

//Begin - Added By Mark Lee 01/15/2013 12 items
// Contract_Detail_Tab_Detail_Tab.x
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Detail_Tab_Detail_Tab.x' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Detail_Tab_Detail_Tab.x', '0.2839825660582948' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contract_Dates.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contract_Dates.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contract_Dates.height', '0.2240618101545254' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contract_Dates_Num
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contract_Dates_Num' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contract_Dates_Num', 'R1' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contract_Detail.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contract_Detail.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contract_Detail.height', '0.8002207505518764' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contract_Detail_Num
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contract_Detail_Num' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contract_Detail_Num', 'L1' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contracted_Company_Contact_Info.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contracted_Company_Contact_Info.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contracted_Company_Contact_Info.height', '0.1986754966887417' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Contracted_Company_Contact_Info_Num
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Contracted_Company_Contact_Info_Num' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Contracted_Company_Contact_Info_Num', 'R2' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Our_Company_Contact_Info.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Our_Company_Contact_Info.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Our_Company_Contact_Info.height', '0.1986754966887417' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Our_Company_Contact_Info_Num
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Our_Company_Contact_Info_Num' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Our_Company_Contact_Info_Num', 'R3' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Products.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Products.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Products.height', '0.1578366445916115' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Products_Num
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Products_Num' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Products_Num', 'L2' ,'" + gs_user_id + "',  getdate( ) ) "
//Contract_Tabpage_Details_Tab_Detail.height
is_sql_statements[upperbound(is_sql_statements) + 1] = &
" if not exists (select TOP 1 1 from security_viewid_options where view_id = 1000 and option_name= '" +'Contract_Tabpage_Details_Tab_Detail.height' + "')  " + &
"insert security_viewid_options( view_id, option_name, option_value,user_id, last_update )  values( 1000,'Contract_Tabpage_Details_Tab_Detail.height', '0.32560706401766' ,'" + gs_user_id + "',  getdate( ) ) "
//End - Added By Mark Lee 01/15/2013

//Added By Mark Lee 02/04/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if Not Exists(SELECT 1 FROM ctx_tabpage_screen WHERE ts_id = 82)~r~n" + &
"	INSERT INTO ctx_tabpage_screen VALUES(82,0,0,'tabpage_email',null,'Email Manager')"

//Added By Ken.Guo 02/05/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ids set picture_id = 0 Where picture_id is null"

//add by gavins 20130222
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(Select 1 from import_tables where table_id = 1009 and table_name = 'ctx_custom_multi_hdr') " + &
"	Insert Into import_tables Values(1009,'ctx_custom_multi_hdr','Custom Multi Header',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If Not Exists(Select 1 from import_tables where table_id = 1010 and table_name = 'ctx_custom_multi_detail') " + &
"	Insert Into import_tables Values(1010,'ctx_custom_multi_detail','Custom Multi Detail',2) "

//Added By Ken.Guo 03/12/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_smtp_accounts set protocol = 'IMAP4' ,  pop3_port = 143 where pop3_server is null"

//Added By Ken.Guo 03/15/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set es_apicode = 'DC1317FF-E03E-475D-87E7-AAE70E8D97A4' where es_apicode is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings set es_apicode = 'DC1317FF-E03E-475D-87E7-AAE70E8D97A4' where es_apicode = '1e111366-9f69-102d-a0b1-db73b11b73f0' "

//Added By Mark Lee 03/20/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select TOP 1 1  from view_alias where v_name = 'v_clause_library') ~r~n" + &
"INSERT INTO view_alias (v_name,v_alias,module,screen,sflag,p_name) ~r~n" + &
"VALUES ('v_clause_library','Clause Library',1,'d_clauses_painter_browse_new','Y','1-11.gif') "

//Added By Ken.Guo 04/09/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font = 'Courier New' where font is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font_size = 9 where font_size is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font_text_color = 0 where font_text_color is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font_italy = 0 where font_italy is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font_bold = 0 where font_bold is null"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_user_tv_settings Set font_underline = 0 where font_underline is null"

//Added By Mark Lee 06/17/2013 add the import aduit log. (Contract/Custom Multi/Header)
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update sys_tables set import_table_name = 'ctx_custom_multi_hdr' where table_name = 'd_contract_multi_header' and (import_table_name is null or import_table_name <> 'ctx_custom_multi_hdr') "
//(Contract/Custom Multi/Detail)
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update sys_tables set import_table_name = 'ctx_custom_multi_detail' where table_name = 'd_contract_multi_detail' and (import_table_name is null or import_table_name <> 'ctx_custom_multi_detail') "
//(Contract/Details/Custom Data 2)
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update sys_tables set import_table_name = 'ctx_custom' where table_name = 'd_contract_det_custom_2' and (import_table_name is null or import_table_name <> 'ctx_custom') "

//Added By Ken.Guo 07/03/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_smtp_accounts Set sendprotocol = 'SMTP' where sendprotocol is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_smtp_accounts Set sendauthmode_exchange = 0 where sendauthmode_exchange is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update em_smtp_accounts Set getauthmode_exchange = 0 where getauthmode_exchange is null"

//Added By Ken.Guo 09/23/2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings Set check_registry = 1 where check_registry is null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings Set check_trusted_sites = 1 where check_trusted_sites is null"

//Added By Jay Chen 10-18-2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings Set esign_type = 'sertifi' where esign_type is null ~r~n"

//Added By Jay Chen 10-18-2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_am_document Set esign_type = 'sertifi' where esign_type is null ~r~n"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update ctx_am_doc_audit Set esign_type = 'sertifi' where esign_type is null ~r~n"

//Added By Jay Chen 10-18-2013
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update icred_settings Set echo_apicode = 'XY5JXPL2M3X7I8M' where echo_apicode is null ~r~n"

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//Added By Jay Chen 04-03-2014
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"INSERT INTO ctx_screen (data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,boarder_style,screen_style,grid_dataobject,grid_modify) ~r~n" + &
"SELECT data_view_id,59,'tabpage_images','Document Manager->Document Browse Window->Search Criteria','dw_filter','d_doc_br_search','stylebox!','F',NULL,'Y' ~r~n" + &
"FROM data_view ~r~n" + &
"WHERE data_view_id >= 1001 and data_view_id NOT IN (SELECT data_view_id FROM ctx_screen WHERE screen_id = 59)"
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"INSERT INTO ctx_screen (data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,boarder_style,screen_style,grid_dataobject,grid_modify) ~r~n" + &
"SELECT data_view_id,60,'tabpage_images','Document Manager->Document Browse Window->Document Browse','dw_browse',NULL,'Y','G','d_doc_br_browse','Y' ~r~n" + &
"FROM data_view ~r~n" + &
"WHERE  data_view_id >= 1001 and data_view_id NOT IN (SELECT data_view_id FROM ctx_screen WHERE screen_id = 60)"
//---------End Added ------------------------------------------------------

of_execute_sqls("of_ver120_release_data1")

Return 1
end function

public function integer of_clx120_updates ();//====================================================================
//$<Function>: of_clx120_updates()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_ver115_release_data1()
of_ver120_release_data1()

Return 1
end function

on n_cst_update_data_clx.create
call super::create
end on

on n_cst_update_data_clx.destroy
call super::destroy
end on

event constructor;call super::constructor;inv_clause = Create n_cst_clause
end event

event destructor;call super::destructor;if isvalid(inv_clause) Then Destroy inv_clause
end event

