$PBExportHeader$n_cst_workflow_sql.sru
forward
global type n_cst_workflow_sql from nonvisualobject
end type
end forward

global type n_cst_workflow_sql from nonvisualobject autoinstantiate
end type

type variables
string is_init
string is_sql_statments[]
end variables

forward prototypes
public subroutine of_update_version_7 ()
public function integer of_execute (string as_sql)
public subroutine of_execute_sqls ()
end prototypes

public subroutine of_update_version_7 ();//This function contained all db updates for workflow
String ls_sql
//Update the secuity
Long ll_Module_id

if Not isvalid( w_infodisp ) then open(w_infodisp)

if isvalid(w_infodisp) then w_infodisp.title = 'Creating Work Flow Module tables, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating security roles for work flow module, Please stand by for version 7.0: ' 


Select Count(*) Into :ll_Module_id From security_modules Where module_name = 'Work Flow Painter';
If ll_Module_id = 0 Then
	Insert Into security_modules Values(61, 0,'Work Flow Painter', 1);
	Insert Into security_sub_module Values(600, 61, 'Main', 1);
	Insert Into security_rights_action Values(5830, 61, 600, 'View Rights', 2);
	
	Insert Into security_modules Values(62, 0,'Email Painter', 1);
	Insert Into security_sub_module Values(601, 62, 'Main', 1);
	Insert Into security_rights_action Values(5831, 62, 601, 'View Rights', 2);
	
	n_ds ds_roles, lds_rolerights
	Integer li_rows, i
	Long ll_roleid, ll_maxid, ll_found
	String ls_new_syntax, ls_error
	
	ds_roles = Create n_ds
	ds_roles.DataObject = "d_roles"
	ds_roles.SetTransObject( SQLCA )
	
	lds_rolerights = Create n_ds
	ls_sql = "select security_roles_rights.role_id, security_roles_rights.action_id from security_roles_rights "
	ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
	lds_rolerights.Create( ls_new_syntax, ls_error )
	lds_rolerights.SetTransObject(SQLCA)
	
	gnv_appeondb.of_startqueue()
	ds_roles.Retrieve()
	lds_rolerights.Retrieve()
	Select Max( rights_id ) Into :ll_maxid From security_roles_rights;
	gnv_appeondb.of_commitqueue()
	
	If IsNull( ll_maxid ) Then ll_maxid = 0;
	li_rows = ds_roles.RowCount()
	
	For i = 1 To li_rows
		ll_roleid = ds_roles.GetItemNumber( i, "role_id" )
		
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5830", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5830, 2);" )
		End If
		
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5831", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5831, 2);" )
		End If
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.27.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	UPDATE ids SET rights_id = :ll_maxid;	
	//---------------------------- APPEON END ----------------------------

	Destroy( ds_roles );
	Destroy( lds_rolerights );
End If

//Table Desigin for Work Flow. The tables related to Contract module have not been designed.
//1. Work Flow table
ls_sql = "ALTER TABLE ctx_acp_template DROP CONSTRAINT FK_CTX_ACP_TEMPLATE_WF_WORKFLOW ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE ctx_acp_document DROP CONSTRAINT FK_CTX_ACP_document_WF_WORKFLOW;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//ls_sql = "drop table wf_workflow;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = " &
	Create Table wf_workflow &
	( &
	wf_id   Integer  Not Null, &
	wf_name   varchar(255)  Not Null,   &
	wf_status  varchar(1)  Not Null  Default 'A', &
	wf_module  varchar(2)  Not Null,   &
	wf_prompt_falg   varchar(1)  Not Null  Default 'N', &
	wf_prompt_message  varchar(255),     &
	wf_triggered_by  varchar(3) Not Null,   &
	wf_description  varchar(255), &
	agreement_flag   varchar(1)  Not Null  Default 'N', &
	practitioner_falg  varchar(1)  Not Null  Default 'Y',   &
	comparison_type  varchar(1)  Not Null  Default 'Y', &
	wf_create_date  DateTime Not Null, &
	wf_update_date  DateTime Not Null, &
	CONSTRAINT pk_wf_workflow PRIMARY Key (wf_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE CTX_ACP_TEMPLATE ADD CONSTRAINT FK_CTX_ACP_TEMPLATE_WF_WORKFLOW FOREIGN KEY (wf_id) REFERENCES wf_workflow;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE ctx_acp_document ADD CONSTRAINT FK_CTX_ACP_document_WF_WORKFLOW FOREIGN KEY (wf_id) REFERENCES wf_workflow;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//Work Flow Trigger Parameters
//2. Action Items Parameters 
//ls_sql = "drop table wf_trigger_param_action_status;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "&
	Create Table wf_trigger_param_action_status &
	( &
	wf_id    Integer   Not Null, &
	action_type_id   numeric(6,0)   Not Null, &
	action_status_id   numeric(6,0)   Not Null, &
	CONSTRAINT pk_wf_parm_action_items PRIMARY Key (wf_id,action_type_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//3. Agreement Creation
//ls_sql = "drop table wf_trigger_param_agreement_creation;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = " &
	Create Table wf_trigger_param_agreement_creation &
	( &
	wf_id     Integer   Not Null, &
	doc_id     numeric(6,0)   Not Null, &
	doc_categorie     numeric(6,0)   Not Null, &
	CONSTRAINT pk_agreement_creation PRIMARY Key (wf_id,doc_id) &
	) ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//4. Practitioner Folder Data Value Comparison(only the field comparison or a SQL statement can be entered not both) or 
//IntelliContract Data Value Comparison
//ls_sql = "drop table wf_trigger_param_data_comparison;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = " &
	Create Table wf_trigger_param_data_comparison &
	( &
	wf_id   Integer  Not Null, &
	key_id   Integer  Not Null, &
	Type    varchar(1)  Not Null Default 'P',   &
	screen_id  Int   Not Null, &
	field_name  varchar(50) null, &
	field_label  varchar(255) null, &
	operator   varchar(20) null  Default '=',    &
	Value    varchar(255) null, &
	logical   varchar(5) null Default 'and', &
	sql_statement  Text null, &
	module  varchar(2) null, &
	CONSTRAINT pk_practitioner_data PRIMARY Key (wf_id,key_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//5. Work Flow Action Type
//ls_sql = "drop table wf_action_types;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = " &
	Create Table wf_action_types &
	( &
	wf_id     Integer  Not Null, &
	step_id    Integer  Not Null, &
	step_name   varchar(30), &
	action_type_id   numeric(6)  Not Null, &
	action_desc   varchar(255) null, &
	step_order   Integer  Not Null  Default 0,  &
	create_flag   varchar(1)  Not Null  Default 'N', &
	due_days   Integer   Not Null Default 0, &
	weekend_flag   varchar(1) null  Default 'Y',  &
	to_user    varchar(50) null,  &
	dept_chair_flag   varchar(1)  Not Null  Default 'N',  &
	by_user    varchar(50) null, &
	create_user_flag   varchar(1)  Not Null  Default 'Y', &
	mail_notify   Integer null, &
	send_to_user	varchar(50) null, &
	cc_user    varchar(50) null, &
	CONSTRAINT pk_action_type PRIMARY Key (wf_id,step_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "CREATE UNIQUE INDEX idx_step_order ON wf_action_types (wf_id , step_order );" 
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "CREATE INDEX idx_step_id ON wf_action_types (wf_id , step_id );"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//6. work flow action status
//ls_sql = "drop table wf_action_status;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = " &
	Create Table wf_action_status &
	( &
	wf_id     Integer   Not Null, &
	step_id    Integer   Not Null, &
	status_id   Integer   Not Null, &
	status_name   varchar(30), &
	action_status_id  numeric(6,0)   Null, &
	action_status_desc  varchar(255), &
	initial_flag   varchar(1)   Not Null  Default 'N', &
	complete_flag   varchar(1)   Not Null  Default 'N', &
	update_header_flag  varchar(1)   Not Null  Default 'N', &
	update_status_id  numeric(6,0) null, &
	to_step    Integer null, &
	trigger_flow   Integer null, &
	create_step   Integer null, &
	mail_notify   Integer null, &
	to_notify_user	varchar(50) null, &
	cc_notify_user    varchar(50) null, &
	mail_reminder    Integer null, &
	to_reminder_user	varchar(50) null, &
	cc_reminder_user  varchar(50) null, &
	days_reminder   Integer null, &
	days_every   Integer null, &
	send_count    Integer null , &
	mail_message    Integer, &
	to_message_user   varchar(10) null, &
	cc_message_user   varchar(10) null, &
	letter_id   integer null, &
	return_days   Integer null, &
	resend_times   Integer null, &
	day_interval   Integer null, &
	popup_flag   varchar(1)   Not Null  Default 'N', &
	include_note_flag  varchar(1)   Not Null  Default 'N', &
	process_flag  integer  Not Null  Default 0, &
	CONSTRAINT pk_action_status PRIMARY Key (wf_id,step_id,status_id) &
	);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "CREATE INDEX idx_status_id ON wf_action_status (wf_id , step_id , status_id );" 
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//ls_sql = "CREATE UNIQUE INDEX idx_action_status_id ON wf_action_status (wf_id , step_id , action_status_id );"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql


//7. Table of Email Painter
//ls_sql = "drop table wf_email;"
//is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = " &
	Create Table wf_email ( &
	email_id  Integer  Not Null , &
	email_name  varchar(100)  Not Null, &
	module   varchar(50)  Not Null, &
	Subject  varchar(255) null , &
	attach_name varchar(100) null , &
	attachment  image  null, &
	email_msg  Text  null, &
	PRIMARY Key (email_id)) ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "CREATE UNIQUE INDEX wf_email_id_x ON wf_email (email_id ) ;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//8. The following SQL changes are made to the existing tables
//Modify the Department chair table to add one column to store the chairperson 
//Alter table dept_chair add user_id char(10)
ls_sql = "Alter table dept_chair add user_id char(10) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//Modify the facility table add columns to store related Work flow
ls_sql = "Alter table facility add wf_expiring_appointment integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_reappointment_initiated integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_data_entry_complete integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_practitioner_status_change integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_new_practitioner integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_data_value_comparison integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table facility add wf_webview_application_complete integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//9. Modify the verif_info table to add some columns 
ls_sql = "Alter table verif_info add wf_step integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table verif_info add due_date datetime null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table verif_info add letter_id integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table verif_info add wf_id integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table verif_info add Wf_action_type_id numeric(6,0) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table verif_info add Wf_complete_flag varchar(1) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//10. Modify the net_dev_action_items table to add some columns 
ls_sql = "Alter table net_dev_action_items add wf_step integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table net_dev_action_items add letter_id integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table net_dev_action_items add wf_id integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table net_dev_action_items add Wf_action_type_id numeric(6,0) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table net_dev_action_items add wf_assigned_by varchar(20) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table net_dev_action_items add wf_complete_flag varchar(1) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//11. Modify the ids add a column to store the Work Flow's id
ls_sql = "Alter table ids add wf_id numeric(10,0) null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11.16.2006 By: Jervis
//$<reason> 
ls_sql = "Alter table ctx_action_items add wf_step integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add letter_id integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add wf_id integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add Wf_action_type_id numeric(6,0) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add wf_assigned_by varchar(50) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add active_status integer default 0"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table ctx_action_items add wf_complete_flag varchar(1) default 'N'"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.30.2007 By: Machongmin
//$<reason> Fix a defect.	
if gs_dbtype = 'ASA' then
	//ASA£º
	ls_sql = "ALTER TABLE CTX_ACTION_ITEMS	MODIFY inserted_at_date_time DEFAULT getdate()"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
else
	//Sqlserver£º
	ls_sql = "ALTER TABLE CTX_ACTION_ITEMS ADD CONSTRAINT DF_CTX_ACTION_ITEMS_inserted_at_date_time1 DEFAULT (getdate()) FOR inserted_at_date_time"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
end if


//---------------------------- APPEON END ----------------------------
//Added 11.21.2006
ls_sql = "Alter table wf_trigger_param_data_comparison add module varchar(2) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table wf_trigger_param_data_comparison add field_type varchar(2) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table wf_trigger_param_data_comparison add table_name varchar(150) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//Added 23.11.2006
If gs_dbtype = 'ASA' Then
	ls_sql = "Alter table wf_action_types modify to_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	ls_sql = "Alter table wf_action_types modify by_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007.08.20 By: Frank.Gui
	//$<reason> to_message_user and cc_message_user should be longer so that they can hold special values such as $$Assigned To User$$
	ls_sql = "Alter table wf_action_status modify to_message_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	ls_sql = "Alter table wf_action_status modify cc_message_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	//---------------------------- APPEON END ----------------------------

Else
	ls_sql = "Alter table wf_action_types alter column to_user varchar(50) null"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	ls_sql = "Alter table wf_action_types alter column by_user varchar(50) null"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007.08.20 By: Frank.Gui
	//$<reason>  to_message_user and cc_message_user should be longer so that they can hold special values such as $$Assigned To User$$
	ls_sql = "Alter table wf_action_status alter column  to_message_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	ls_sql = "Alter table wf_action_status alter column  cc_message_user varchar(50) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	//---------------------------- APPEON END ----------------------------
End If

ls_sql = "Alter table facility add wf_exp_appt varchar(1) default'N'"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "Alter table facility add wf_webview_application_initiated integer null;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "Alter table wf_action_status add set_step integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table wf_action_status add set_status numeric(6,0) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End added 23.11.2006

//Start------------27.11.2006 By Jervis---------------------------------
ls_sql = "alter table net_dev_action_items add print_flag int default 0"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table net_dev_action_items add first_sent datetime null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table net_dev_action_items add last_sent datetime null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table net_dev_action_items add number_sent int default 0"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End--------------27.11.2006 By Jervis


//Start------------01-12-2006 By Jervis
If gs_dbtype = 'ASA' Then
	ls_sql = "alter table wf_action_status modify action_status_id numeric(6,0) null"
else
	ls_sql = "alter table wf_action_status alter column action_status_id numeric(6,0) null"
end if
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//end------------------------------------------------------------------------

//Start code change -- 12.5.2006 Henry. modify the table structure base on the new issue requirement.
ls_sql = "alter table wf_action_status add set_wf_id integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End code change -- 12.5.2006

//Start code change----12.14.2006 By Jervis
ls_sql = "ALTER TABLE wf_action_types ADD CONSTRAINT FK_ACTION_TYPE_ID_CODE_LOOKUP_WF_ACTION_TYPES FOREIGN KEY (action_type_id) REFERENCES code_lookup"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_types ADD CONSTRAINT FK_MAIL_NOTIFY_WF_EMAIL_WF_ACTION_TYPES FOREIGN KEY (mail_notify) REFERENCES wf_email"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_status ADD CONSTRAINT FK_ACTION_STATUS_ID_CODE_LOOKUP_WF_ACTION_STATUS FOREIGN KEY (action_status_id) REFERENCES code_lookup"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_status ADD CONSTRAINT FK_MAIL_NOTIFY_WF_EMAIL_WF_ACTION_STATUS FOREIGN KEY (mail_notify) REFERENCES wf_email"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_status ADD CONSTRAINT FK_MAIL_REMINDER_WF_EMAIL_WF_ACTION_STATUS FOREIGN KEY (mail_reminder) REFERENCES wf_email"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_status ADD CONSTRAINT FK_MAIL_MESSAGE_WF_EMAIL_WF_ACTION_STATUS FOREIGN KEY (mail_message) REFERENCES wf_email"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE wf_action_status ADD CONSTRAINT FK_LETTER_ID_SYS_LETTERS_WF_ACTION_STATUS FOREIGN KEY (letter_id) REFERENCES sys_letters"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End code change-----12.14.2006

//start code changes -- 12.14.2006 Henry
ls_sql = "Alter table wf_email add export_id integer null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End code change-----12.14.2006


//Start code By Jervis 1.11.2007
ls_sql = "alter table wf_trigger_param_data_comparison add value_display varchar(75) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table wf_trigger_param_data_comparison add lookup_code varchar(40) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "alter table wf_trigger_param_data_comparison add lookup_flag char(1) null default 'N'"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
//End code

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-05-31 By: Wu ZhiJun
//$<reason> Extend the column's length

If gs_dbtype = 'ASA' Then
	ls_sql = "alter table wf_action_types modify cc_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status modify cc_notify_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status modify cc_reminder_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status modify cc_message_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
else
	ls_sql = "alter table wf_action_types alter column cc_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status alter column cc_notify_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status alter column cc_reminder_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
	
	ls_sql = "alter table wf_action_status alter column cc_message_user varchar(255) null;"
	is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
end if

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 26/03/2007 By: Jervis
//$<reason> For WebView
is_sql_statments[upperbound(is_sql_statments)+1] = "CREATE TABLE wv_esign_log (" + &
	"rec_id int NOT NULL, " + &
	"facility_id int NOT NULL, " + &
	"tab_type varchar(30) NOT NULL, " + &
	"user_id char(15) NOT NULL, " + &
	"prac_id int NULL, " + &
	"user_date datetime NULL, " + &
	"notes varchar(255) " + &
	"NULL , " + &
	"CONSTRAINT PK__wv_esign_log PRIMARY KEY NONCLUSTERED (rec_id)) ;"

//---------------------------- APPEON END ----------------------------

of_execute_sqls()

end subroutine

public function integer of_execute (string as_sql);string ls_sql

ls_sql = as_sql
//sle_1.text = ls_sql
execute immediate :ls_sql using sqlca;
commit using sqlca;

return 1
end function

public subroutine of_execute_sqls ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
string ls_null[]
boolean lb_ref_cache

IF UPPERBOUND(is_sql_statments) > 0 THEN  lb_ref_cache  = true

IF UPPERBOUND(is_sql_statments) > 0 THEN 
	   is_sql_statments[upperbound(is_sql_statments) + 1] = "commit;"

		if Not isvalid( w_infodisp ) then open(w_infodisp)

		if isvalid(w_infodisp) then w_infodisp.title = 'Creating Work Flow Module tables, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating Work Flow Module Tabels, Please stand by for version 7.0: ' 
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statments))
		
		
		gnv_appeondb.of_startqueue( )
		
		FOR ll_i = 1 TO upperbound(is_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(is_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :is_sql_statments[LL_I] using sqlca;
				 IF LenA(sqlca.sqlerrtext) > 0 THEN
					// Added by Davis 11.14.2006
					IF handle(getapplication()) = 0 THEN
//						messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(is_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					END IF
					// Added by Davis 11.14.2006

					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
		
		gnv_appeondb.of_commitqueue( )
		
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		
      if isvalid(w_infodisp) then close(w_infodisp)
	    
END IF


is_sql_statments = ls_null

return 
end subroutine

on n_cst_workflow_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_workflow_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

