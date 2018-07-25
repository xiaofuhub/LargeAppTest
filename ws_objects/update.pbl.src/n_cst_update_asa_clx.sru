$PBExportHeader$n_cst_update_asa_clx.sru
forward
global type n_cst_update_asa_clx from n_cst_update
end type
end forward

global type n_cst_update_asa_clx from n_cst_update
end type
global n_cst_update_asa_clx n_cst_update_asa_clx

forward prototypes
public function integer of_ver90_release_table1 ()
public function integer of_ver90_release_table2 ()
public function integer of_ver90_release_storeprocedure1 ()
public function integer of_ver90_release_view1 ()
public function integer of_ver95_release_table1 ()
public function integer of_ver95_release_table2 ()
public function integer of_ver95_release_view1 ()
public function integer of_ver95_release_storeprocedure1 ()
public function integer of_ver100_release_table1 ()
public function integer of_ver100_release_table2 ()
public function integer of_ver100_release_storeprocedure1 ()
public function integer of_ver100_release_view1 ()
public function integer of_ver105_release_table1 ()
public function integer of_ver105_release_trigger1 ()
public function integer of_ver105_release_view1 ()
public function integer of_ver105_release_storeprocedure1 ()
public function integer of_ver110_release_storeprocedure1 ()
public function integer of_ver110_release_table1 ()
public function integer of_clx110_updates ()
public function integer of_clx120_updates ()
public function integer of_ver115_release_table1 ()
public function integer of_ver115_release_storeprocedure1 ()
public function integer of_ver120_release_table1 ()
public function integer of_ver120_release_view1 ()
public function integer of_ver120_release_storeprocedure1 ()
end prototypes

public function integer of_ver90_release_table1 ();is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if not exists( " + &
	"   select TOP 1 1 from sys.syscolumn c, sys.systable t " + &
	"   where c.table_id=t.table_id  " + &
	"     and c.column_name='tab_position' " + &
	"     and t.table_name='dashboard_tabs_settings') " + &
	" ALTER table dashboard_tabs_settings add tab_position integer null "  

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if not exists( " + &
	"   select TOP 1 1 from sys.syscolumn c, sys.systable t " + &
	"   where c.table_id=t.table_id  " + &
	"     and c.column_name='custom_colors' " + &
	"     and t.table_name='security_users') " + &
	" ALTER table security_users add custom_colors varchar(200) null  "

//Added by Scofield on 2009-01-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if not exists( " + &
	"   select TOP 1 1 from sys.syscolumn c, sys.systable t " + &
	"   where c.table_id=t.table_id  " + &
	"     and c.column_name='User_Type' " + &
	"     and t.table_name='tdl_detail') " + &
	"ALTER table tdl_detail add User_Type int null "
	
//Added By Alan on 2009-1-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if not exists( " + &
	"   select TOP 1 1 from sys.syscolumn c, sys.systable t " + &
	"   where c.table_id=t.table_id  " + &
	"     and c.column_name='set_autoret' " + &
	"     and t.table_name='security_users') " + &
	" alter table security_users add set_autoret int default 1 "

//Added By Ken.Guo on 2009-01-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if not exists( " + &
	"   select TOP 1 1 from sys.syscolumn c, sys.systable t " + &
	"   where c.table_id=t.table_id  " + &
	"     and c.column_name='group_access' " + &
	"     and t.table_name='icred_settings') " + &
	" ALTER table icred_settings add group_access integer null     "

//Added By Ken.Guo on 2009-01-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'security_groups' ) " + &
"	Create Table security_groups  " + &
"	( " + &
"		id  numeric(10,0) identity  not null, " + &
"		group_name varchar(50) not null, " + &
"		group_des varchar(200) null, " + &
"		Primary Key(id) " + &
"	) " 

//Added By Ken.Guo on 2009-01-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" if not exists( select 1 from sysobjects where name = 'security_group_users' ) " + &
"	Create Table security_group_users  " + &
"	( " + &
"		id  numeric(10,0) identity  not null, " + &
"		group_id numeric(10,0) not null, " + &
"		user_id varchar(10) not null, " + &
"		Primary Key(id) " + &
"	) " 

//Added By Ken.Guo on 2009-01-15
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" if not exists( select 1 from sysobjects where name = 'ctx_group_access' ) " + &
"	Create Table ctx_group_access  " + &
"	( " + &
"		ctx_id numeric(10,0) not null, " + &
"		group_id numeric(10,0) not null,	 " + &
"		access varchar(1) not null, " + &
"		view_id numeric(10,0) null, 	 " + &
"		notes varchar(100) null, " + &
"		Primary Key(ctx_id,group_id) " + &
"	) " 

//Auto Generate Email Signature by jervis 01.20.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_sign' and t.table_name='wf_email' ) " + &
" ALTER table wf_email add auto_sign varchar(1) null   "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_sign' and t.table_name='CTX_NOTIFICATION' ) " + &
" ALTER table CTX_NOTIFICATION add auto_sign varchar(1) null   "
	
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_sign' and t.table_name='CTX_ai_NOTIFICATION' ) " + &
" ALTER table CTX_ai_NOTIFICATION add auto_sign varchar(1) null   "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_sign' and t.table_name='CTX_am_ai_NOTIFICATION' ) " + &
" ALTER table CTX_am_ai_NOTIFICATION add auto_sign varchar(1) null   "
	
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If not exists( select 1 from sysobjects where name = 'ctx_report_syntax' )  " + &
"	CREATE TABLE ctx_report_syntax	" + &
"	( " + &
"		id numeric(18, 0) IDENTITY NOT NULL,	" + &
"		view_id numeric(8, 0) NULL,	" + &
"		dw_sql text NULL,	" + &
"		dw_syntax image NULL,	" + &
"		modify_date datetime NULL,	" + &
" 		PRIMARY KEY CLUSTERED(id)	" + &
"	)	" 	
	
//Add by Jervis 02.17.2009
//Add Send Flag for action item
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='reminder_last' and t.table_name='ctx_action_items' ) " + &
	"Alter table ctx_action_items add reminder_last datetime null   "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='escalation_last' and t.table_name='ctx_action_items' ) " + &
	"Alter table ctx_action_items add escalation_last datetime null   "
	
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='reminder_last' and t.table_name='ctx_am_action_item' ) " + &
	"Alter table ctx_am_action_item add reminder_last datetime null   "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='escalation_last' and t.table_name='ctx_am_action_item' ) " + &
	"Alter table ctx_am_action_item add escalation_last datetime null   "
	
//Added By Alan on 2009-2-20
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_id' and t.table_name='em_sent_items' ) " + &
	"Alter table em_sent_items add ctx_id int null   "
	
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_id' and t.table_name='em_sent_items' ) " + &
	"Alter table em_sent_items add doc_id int null   "	
	
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='action_item_id' and t.table_name='em_sent_items' ) " + &
	"Alter table em_sent_items add action_item_id int null   "		

//Added by Ken.Guo on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &	
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='use_graph' and t.table_name='tdl_detail' ) " + &
	"ALTER table tdl_detail add use_graph integer null~r~n" 
	
//Added by Ken.Guo on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='graph_category' and t.table_name='tdl_detail' ) " + &
	"ALTER table tdl_detail add graph_category varchar(50) null~r~n" 

//Added by Scofield on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1~r~n" + &
"                 from sysobjects~r~n" + &
"                where name='wf_email_attachment' and type = 'U')~r~n" + &
"CREATE TABLE wf_email_attachment~r~n" + &
"(	email_id             int,~r~n" + &
"	attach_id            int,~r~n" + &
"  attach_name          varchar(100),~r~n" + &
"	attachment           image, ~r~n" + &
"	CONSTRAINT PK_ATTACHMENT PRIMARY KEY (email_id,attach_id),~r~n" + &
"	CONSTRAINT FK_ATTACHMENT_EMAIL FOREIGN KEY (email_id) REFERENCES wf_email(email_id)~r~n" + &
")"

//Added by Scofield on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1~r~n" + &
"                 from sysobjects~r~n" + &
"                where name='ctx_alarm_attachment' and type = 'U')~r~n" + &
"CREATE TABLE ctx_alarm_attachment~r~n" + &
"(	ctx_id               int,~r~n" + &
"  alm_table            varchar(40),~r~n" + &
"  alm_column           varchar(40),~r~n" + &
"  attach_id            int,~r~n" + &
"  alm_attachment_name  varchar(100),~r~n" + &
"	alm_attachment       image, ~r~n" + &
"	CONSTRAINT PK_ALARM_ATTACHMENT PRIMARY KEY (ctx_id,alm_table,alm_column,attach_id),~r~n" + &
"	CONSTRAINT FK_ALARM_ATTACHMENT_NOTIFICATION FOREIGN KEY (ctx_id,alm_table,alm_column) REFERENCES ctx_notification(ctx_id,alm_table,alm_column)~r~n" + &
")"

//Added by Scofield on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1~r~n" + &
"                 from sysobjects~r~n" + &
"                where name='ctx_ai_alarm_attachment' and type = 'U')~r~n" + &
"CREATE TABLE ctx_ai_alarm_attachment~r~n" + &
"(	ctx_id               int,~r~n" + &
"  item_id              int,~r~n" + &
"  alm_table            varchar(40),~r~n" + &
"  alm_column           varchar(40),~r~n" + &
"  attach_id            int,~r~n" + &
"  alm_attachment_name  varchar(100),~r~n" + &
"	alm_attachment       image, ~r~n" + &
"	CONSTRAINT PK_AI_ALARM_ATTACHMENT PRIMARY KEY (ctx_id,item_id,alm_table,alm_column,attach_id),~r~n" + &
"	CONSTRAINT FK_AI_ALARM_ATTACHMENT_NOTIFICATION FOREIGN KEY (ctx_id,item_id,alm_table,alm_column) REFERENCES ctx_ai_notification(ctx_id,ctx_action_item_id,alm_table,alm_column)~r~n" + &
")"

//Added by Scofield on 2009-02-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1~r~n" + &
"                 from sysobjects~r~n" + &
"                where name='ctx_am_ai_alarm_attachment' and type = 'U')~r~n" + &
"CREATE TABLE ctx_am_ai_alarm_attachment~r~n" + &
"(	doc_id               int,~r~n" + &
"  seq_id               int,~r~n" + &
"  alm_table            varchar(40),~r~n" + &
"  alm_column           varchar(40),~r~n" + &
"  attach_id            int,~r~n" + &
"  alm_attachment_name  varchar(100),~r~n" + &
"	alm_attachment       image, ~r~n" + &
"	CONSTRAINT PK_AM_AI_ALARM_ATTACHMENT PRIMARY KEY (doc_id,seq_id,alm_table,alm_column,attach_id),~r~n" + &
"	CONSTRAINT FK_AM_AI_ALARM_ATTACHMENT_NOTIFICATION FOREIGN KEY (doc_id,seq_id,alm_table,alm_column) REFERENCES ctx_am_ai_notification(doc_id,seq_id,alm_table,alm_column)~r~n" + &
")"

/*
//Added by Ken.Guo on 2009-02-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"If not exists( select 1 from sysobjects where name = 'dashboard_todolist_summary' )~r~n" + &
"	Create Table dashboard_todolist_summary~r~n" + &
"	(~r~n" + &
"		id numeric(10) identity not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		tab_id	integer not null,~r~n" + &
"		summary_id	integer null,~r~n" + &
"		tdl_user varchar(50) null,~r~n" + &
"		tdl_id integer null,~r~n" + &
"		is_graph integer null,~r~n" + &
"		graph_type integer null,	~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"
*/

//Added by Ken.Guo on 2009-02-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tdl_user' and t.table_name='dashboard_gadgets_summary' ) " + &
"	ALTER table dashboard_gadgets_summary add tdl_user varchar(50) null~r~n" 

//Added by Ken.Guo on 2009-02-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tdl_id' and t.table_name='dashboard_gadgets_summary' ) " + &
"	ALTER table dashboard_gadgets_summary add tdl_id integer null~r~n" 

//Added by Ken.Guo on 2009-02-25
/*
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(	select 1 from syscolumns c, sysobjects t   ~r~n" + &
" where c.id=t.id  and c.name='tdli_id' and t.name='dashboard_gadgets_summary'	and t.type = 'U')~r~n" + &
"	ALTER table dashboard_gadgets_summary add tdli_id integer null~r~n" 
*/

//Added by jervis on 02.27.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Prompt_flag' and t.table_name='wf_action_status' ) " + &
"Alter table wf_action_status add Prompt_flag varchar(1) not null default 'N'"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Prompt_message' and t.table_name='wf_action_status' ) " + &
"Alter table wf_action_status add Prompt_message varchar(255) null"

//Added bu jervis on 03.06.2009
//Get Parent level Data in export painter
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='record_level' and t.table_name='export_fields' ) " + &
"Alter table export_fields add record_level varchar(1) null"

//Added by Scofield on 2009-03-12
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='view_id' and t.table_name='wf_workflow' ) " + &
"ALTER table wf_workflow add view_id int null~r~n"

//Added by Scofield on 2009-03-13
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if NOT EXISTS (SELECT TOP 1 1~r~n" + &
"                 FROM sysobjects~r~n" + &
"                WHERE name='ctx_tabpage_screen' and type = 'U')~r~n" + &
"CREATE TABLE ctx_tabpage_screen~r~n" + &
"(	ts_id          int,~r~n" + &
"	ts_type        int,~r~n" + &
"	parent_id      int,~r~n" + &
"	tabpage_name   varchar(200),~r~n" + &
"	screen_id      int,~r~n" + &
"	default_text   varchar(200), ~r~n" + &
"	CONSTRAINT PK_ctx_tabpage_screen PRIMARY KEY (ts_id)~r~n" + &
")"

//Added by Scofield on 2009-03-24
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Dynamic_Search_Tab' and t.table_name='security_users' ) " + &
"ALTER TABLE security_users ADD Dynamic_Search_Tab int null"

//Added by Ken on 2009-03-26
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"IF Not EXISTS(SELECT name 	  FROM 	 sysobjects WHERE  name = 'ctx_am_image_weblink'  AND 	 type = 'U')~r~n" + &
"	CREATE TABLE ctx_am_image_weblink~r~n" + &
"	(~r~n" + &
"	Ctx_id integer not null,~r~n" + &
"	Doc_id integer not null,~r~n" + &
"	Revision numeric(5,1) not null,~r~n" + &
"	Org_Image_file image null,~r~n" + &
"	New_Image_file image null,~r~n" + &
"	file_size integer null,~r~n" + &
"	file_name varchar(100) null,~r~n" + &
"	file_path varchar(300) null,~r~n" + &
"	sender_user varchar(50) null,~r~n" + &
"	sender_email varchar(100) null, ~r~n" + &
"	sent_time datetime null,~r~n" + &
"	download_time datetime null,~r~n" + &
"	upload_time datetime null,~r~n" + &
"	Replied_email integer null,~r~n" + &
"	flag int not null,~r~n" + &
"	Primary Key(Doc_id,Revision)~r~n" + &
"	)~r~n" 

//Added by Ken on 2009-03-26
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"	Declare @li_id int " + &
"	if not exists (select 1 from code_lookup where lookup_name = 'Contract Action Type' and code = 'DocCheckIN') AND not exists (select 1 from sys_code_lookup_audit where lookup_name = 'Contract Action Type' and code = 'DocCheckIN' and lookup_type='C') " + &
"	begin " + &
"	  select @li_id = max(lookup_code) + 1 from code_lookup " + &
"	  INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_1,modify_date) VALUES ( @li_id  ,'Contract Action Type' , 'DocCheckIN','Document Check In','S', 'DocCheckIN',getdate())  " + &
"	end "

//Added by Ken on 2009-03-30
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='web_link_name' and t.table_name='icred_settings' ) " + &
"	ALTER table icred_settings add web_link_name varchar(100) null  ~r~n" 

//Added by Ken on 2009-03-30
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='cache_name' and t.table_name='icred_settings' ) " + &
"	ALTER table icred_settings add cache_name varchar(100) null  ~r~n" 

//Added by Ken on 2009-04-15
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='web_link_name' and t.table_name='ctx_am_image_weblink' ) " + &
"	ALTER table ctx_am_image_weblink add web_link_name varchar(200) null  ~r~n" 

//Added by Ken on 2009-04-16
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_link_name' and t.table_name='ctx_am_image_weblink' ) " + &
"	ALTER table ctx_am_image_weblink add ctx_link_name varchar(200) null  ~r~n" 

//Added by Ken on 2009-04-20
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='reports_use_access' and t.table_name='icred_settings' ) " + &
"	ALTER table icred_settings add reports_use_access integer null  ~r~n" 

//Added by Ken on 2009-04-20
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'reports_except_roles' )~r~n" + &
"	Create Table reports_except_roles ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		roles_id numeric(10) not null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n"

//Added by Ken on 2009-04-20
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select top 1 1 from sysobjects where name = 'reports_except_users' )~r~n" + &
"	Create Table reports_except_users ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n" 

//Added by jervis on 2009-04-24
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select top 1 1 from sysobjects where name = 'wf_advanced_update' and type = 'U')~r~n" + &
"	Create Table wf_advanced_update ~r~n" + &
"	(~r~n" + &
"	wf_id	int	not null, ~r~n"	+ &
"	wf_step_id	int not null, ~r~n"	+ &
"	wf_status_id	int not null, ~r~n"	+ &
"	key_id	int IDENTITY not null, ~r~n"	+ &
"	view_id	int not null, ~r~n"	+ &
"	screen_id	int not null, ~r~n"	+ &
"	table_name	varchar(150)	not null, ~r~n"	+ &
"	field_name	varchar(255)	not null, ~r~n"	+ &
"	Field_label	varchar(255)	not null, ~r~n"	+ &
"	field_type	varchar(2)	null, ~r~n"	+ &	
"	operator	varchar(20)	null default '=', ~r~n"	+ &
"	field_value	varchar(255)	null, ~r~n"	+ &
"	field_display_value	varchar(255)	null, ~r~n"	+ &
"	lookup_name	varchar(40)	null, ~r~n"	+ &
"	Field_flag	char(1) null default 'V', ~r~n"	+ &	
"	field_expression	varchar(1000) null, ~r~n"	+ &
"	CONSTRAINT pk_wf_advanced_update PRIMARY KEY(wf_id, wf_step_id, wf_status_id,Key_id) ~r~n"	+ &
"	)~r~n" 

/*
drop table wf_advanced_update
go
Create table wf_advanced_update
(
	wf_id	int	not null,
	wf_step_id	int not null,
	wf_status_id	int not null,
	key_id	int IDENTITY(1,1) not null,
	view_id	int not null,
	screen_id	int not null,
	table_name	varchar(150)	not null,
	field_name	varchar(255)	not null,
	--Field_colName	varchar(255)	not null,
	Field_label	varchar(255)	not null,
	field_type	varchar(2)	null,	/*C-String, D-Date, N-Number */
	operator	varchar(20)	null default '=',
	field_value	varchar(255)	null,
	field_display_value	varchar(255)	null,
	lookup_name	varchar(40)	null,
	Field_flag	char(1) null default 'V',	/*V-Value, L- Lookup , E- Expression*/
	field_expression	varchar(1000) null
	CONSTRAINT pk_wf_advanced_update PRIMARY KEY(wf_id, wf_step_id, wf_status_id,Key_id)
)
*/

//BEGIN---Modify by Scofield on 2009-05-12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='MaxContractCnt' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD MaxContractCnt int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"UPDATE icred_settings SET MaxContractCnt = 0 WHERE MaxContractCnt is Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='MaxFullUserCnt' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD MaxFullUserCnt int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"UPDATE icred_settings SET MaxFullUserCnt = 0 WHERE MaxFullUserCnt is Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='MaxReadOnlyUserCnt' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD MaxReadOnlyUserCnt int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"UPDATE icred_settings SET MaxReadOnlyUserCnt = 0 WHERE MaxReadOnlyUserCnt is Null"
//END---Modify by Scofield on 2009-05-12

////Added By Ken.Guo 2009-05-22.
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"Alter Table em_sent_items alter column mail_from varchar(200)" 
//
////Added By Ken.Guo 2009-05-22.
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"Alter Table em_sent_items alter column mail_to varchar(200)" 
//
////Added By Ken.Guo 2009-05-22.
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"Alter Table em_sent_items alter column mail_cc varchar(200)" 
//
////Added By Ken.Guo 2009-05-22.
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"Alter Table em_sent_items alter column mail_bcc varchar(200)"

//Add By Jervis 05.22.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter Table ctx_am_action_item modify notes varchar(2000)"

//Added By Ken.Guo 2009-05-22.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter Table Wf_email modify attach_name varchar(500)"

//Added By Ken.Guo 2009-05-22.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter Table wf_email_attachment modify attach_name varchar(500)"

//Added By Ken.Guo 2009-05-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF NOT EXISTS (SELECT TOP 1 1 FROM sysindex  WHERE index_name = 'index_em_sent_items_ctx_id') " + &
"	CREATE INDEX index_em_sent_items_ctx_id  ON em_sent_items (ctx_id)"

//Added By Ken.Guo 2009-06-22.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='file_type' and t.table_name='ctx_am_image_weblink') " + &
"ALTER table ctx_am_image_weblink add file_type varchar(50) null  "

//Added by Scofield on 2009-06-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='image_file' and t.table_name='ctx_elements') " + &
"ALTER TABLE ctx_elements ADD image_file image Null"

//Added by Scofield on 2009-06-25
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='modify_date' and t.table_name='ctx_elements') " + &
"ALTER TABLE ctx_elements ADD modify_date datetime Null"

//Added By Ken.Guo 2009-06-30.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_ref_requirement' )~r~n" + &
"	Create Table ctx_ref_requirement ~r~n" + &
"	(~r~n" + &
"		id numeric(10,0) identity  not null,~r~n" + &
"		doc_or_template_id int not null,~r~n" + &
"		reqmnt_element_id int not null,~r~n" + &
"		reqmnt_type char(1) not null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n" 

//Added By Ken.Guo 2009-07-07.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='used_master_ctx' and t.table_name='ctx_acp_template_clause_rules') " + &
"ALTER table ctx_acp_template_clause_rules add used_master_ctx integer null"


of_execute_sqls("of_ver90_release_table1")

Return 1

end function

public function integer of_ver90_release_table2 ();//Added By Ken.Guo 2009-07-13.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='get_parent_data' and t.table_name='ctx_ref_requirement') " + &
"ALTER table ctx_ref_requirement add get_parent_data integer null " 

//Add by jervis.zhang 07.15.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n11' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n11 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n12' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n12 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n13' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n13 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n14' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n14 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n15' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n15 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n16' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n16 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n17' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n17 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n18' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n18 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n19' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n19 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n20' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n20 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n21' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n21 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n22' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n22 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n23' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n23 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n24' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n24 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n25' and t.table_name='ctx_basic_info') " + &
"alter table ctx_basic_info add custom_n25 numeric(12,2) null"


//Added By Ken.Guo 2009-07-23. ctx_action_items 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n1' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n1 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n2' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n2 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n3' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n3 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n4' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n4 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n1' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n1 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n5' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_n5 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_1' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_1 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_2' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_2 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_3' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_3 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_4' and t.table_name='ctx_action_items') " + &
"alter table ctx_action_items add custom_4 varchar(100) null"


//Added By Ken.Guo 2009-07-23. ctx_am_action_item 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n1' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n1 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n2' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n2 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n3' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n3 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n4' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n4 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n1' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n1 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_n5' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_n5 numeric(12,2) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_1' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_1 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_2' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_2 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_3' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_3 varchar(100) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='custom_4' and t.table_name='ctx_am_action_item') " + &
"alter table ctx_am_action_item add custom_4 varchar(100) null"


//Added By Ken.Guo 2009-07-31.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='email_encoding' and t.table_name='icred_settings') " + &
"ALTER table icred_settings add email_encoding varchar(50) null~r~n" 

//Added by Scofield on 2009-08-13
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='local' and t.table_name='ctx_loc') " + &
"ALTER TABLE ctx_loc MODIFY local varchar(255)"

//Added by Scofield on 2009-08-14 -  //Commented by (Appeon)Alfee 08.07.2013 - V141 ISG-CLX
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
//"   c.column_name='location' and t.table_name='ctx_fee_sched_locations') " + &
//"ALTER TABLE ctx_fee_sched_locations MODIFY location varchar(255)"

//Added by Scofield on 2009-08-14
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id  and " + &
"   c.column_name='description' and t.table_name='ctx_fee_sched_data') " + &
"ALTER TABLE ctx_fee_sched_data ADD description text Null"

of_execute_sqls("of_ver90_release_table2")

Return 1
end function

public function integer of_ver90_release_storeprocedure1 ();////Added by Scofield on 2009-01-14
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'up_ImportView' AND type = 'P') " + &
//"    DROP PROCEDURE up_ImportView"
//
////Added by Scofield on 2009-01-14
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create procedure up_ImportView~r~n" + &
//"	@SourceDBName nvarchar(100),~r~n" + &
//"	@TargetDBName nvarchar(100),~r~n" + &
//"	@ViewID nvarchar(100)~r~n" + &
//"As~r~n" + &
//"Begin~r~n" + &
//"	declare @MaxViewID	nvarchar(100)~r~n" + &
//"	declare @SqlString nvarchar(4000)~r~n" + &
//"	declare @ParmDefinition nvarchar(100)~r~n" + &
//"		~r~n" + &
//"	/*Get Seq No*/~r~n" + &
//"	select @SqlString = 'select @MaxViewIDOUT = isnull(max(data_view_id),0) + 1  from ' + @TargetDBName + '.dbo.data_view'~r~n" + &
//"	select @ParmDefinition = '@MaxViewIDOUT int Output'~r~n" + &
//"	exec sp_executesql @SqlString,@ParmDefinition,@MaxViewIDOUT=@MaxViewID output~r~n" + &
//"~r~n" + &
//"	/*Insert Data_View Table*/~r~n" + &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.data_view (data_view_id,data_view_name,type,type_c)'~r~n" + &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',data_view_name,type,type_c from ' + @SourceDBName + '.dbo.data_view where data_view_id = ' + @ViewID~r~n" + &
//"	~r~n" + &
//"	exec sp_executesql @SqlString~r~n" + &
//"~r~n" + &
//"	/*Insert Ctx_Screen Table*/~r~n" + &
//"	select  @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen (data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,titlebar_text,boarder_style)'~r~n" + &
//"	select 	@SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id,'   ~r~n" + &
//"	select  @SqlString = @SqlString + '  tab_name,   '~r~n" + &
//"	select  @SqlString = @SqlString + 'screen_name,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         dw_name,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         dataobject, '  ~r~n" + &
//"	select  @SqlString = @SqlString + '         description, '  ~r~n" + &
//"	select  @SqlString = @SqlString + '         dw_sql,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         create_date,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         modify_date,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         force_update,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         titlebar_visible,'   ~r~n" + &
//"	select  @SqlString = @SqlString + '         titlebar_text,   '~r~n" + &
//"	select  @SqlString = @SqlString + '         boarder_style  '~r~n" + &
//"	select  @SqlString = @SqlString + '	from ' + @SourceDBName + '.dbo.ctx_screen'~r~n" + &
//"	select  @SqlString = @SqlString + '	where data_view_id = ' + @ViewID~r~n" + &
//"	exec sp_executesql @SqlString~r~n" + &
//"	select Cast(@MaxViewID as int)~r~n" + &
//"end~r~n"

////Added by Ken.Guo on 2009-01-15
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'sp_contract_search' AND type = 'P') " + &
//"    DROP PROCEDURE sp_contract_search"
//
////Added by Ken.Guo on 2009-02-11
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"CREATE  PROCEDURE sp_contract_search(  @user_d VARCHAR(10)   )~r~n" + &
//" AS    ~r~n" + &
//"BEGIN      ~r~n" + &
//"SELECT DISTINCT ~r~n" + &
//"	ctx_basic_info.app_facility,    ~r~n" + &
//"	ctx_products.product_id product_code,     ~r~n" + &
//"	code_lookup.code product_name,       ~r~n" + &
//"	ctx_basic_info.effective_date,      ~r~n" + &
//"	ctx_basic_info.expriation_date,       ~r~n" + &
//"	ctx_basic_info.status,     ~r~n" + &
//"	ctx_basic_info.group_multi_loc_id,       ~r~n" + &
//"	ctx_basic_info.ctx_id,~r~n" + &
//" 	ctx_basic_info.master_contract_id,                             ~r~n" + &
//"	master_cnt = (SELECT Count(ctx_basic_info1.ctx_id) ~r~n" + &
//"			FROM ctx_basic_info ctx_basic_info1 ~r~n" + &
//"			WHERE ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id),  ~r~n" + &
//"	ctx_basic_info.category,        ~r~n" + &
//"	ctx_basic_info.facility_id,     ~r~n" + &
//"	ctx_basic_info.contract_type,       ~r~n" + &
//"	code_lookup1.code product_type, ~r~n" + &
//"	ctx_basic_info.reimbursment_menth,       ~r~n" + &
//"	ctx_basic_info.file_location,    ~r~n" + &
//"	ctx_basic_info.review_date,       ~r~n" + &
//"	ctx_basic_info.review_by,     ~r~n" + &
//"	ctx_basic_info.term_date,       ~r~n" + &
//"	ctx_basic_info.term_reason,     ~r~n" + &
//"	ctx_basic_info.last_revis_date,       ~r~n" + &
//"	ctx_basic_info.other_date_1,       ~r~n" + &
//"	ctx_basic_info.other_date_2,     ~r~n" + &
//"	ctx_basic_info.oc_signed_by,       ~r~n" + &
//"	ctx_basic_info.oc_title,      ~r~n" + &
//"	ctx_basic_info.oc_department,       ~r~n" + &
//"	ctx_basic_info.oc_legal_rep,       ~r~n" + &
//"	ctx_basic_info.cc_signed_by,     ~r~n" + &
//"	ctx_basic_info.cc_title,       ~r~n" + &
//"	ctx_basic_info.cc_department,       ~r~n" + &
//"	ctx_basic_info.cc_legal_rep,     ~r~n" + &
//"	ctx_basic_info.notes,       ~r~n" + &
//"	ctx_basic_info.keyword,       ~r~n" + &
//"	ctx_basic_info.dvision,   ~r~n" + &
//"	ctx_basic_info.custom_1,       ~r~n" + &
//"	ctx_basic_info.custom_2,       ~r~n" + &
//"	ctx_basic_info.custom_3,       ~r~n" + &
//"	ctx_basic_info.custom_4,       ~r~n" + &
//"	ctx_basic_info.custom_5,     ~r~n" + &
//"	ctx_basic_info.custom_6,       ~r~n" + &
//"	ctx_basic_info.custom_7,       ~r~n" + &
//"	ctx_basic_info.custom_8, ~r~n" + &
//"	ctx_basic_info.custom_9,       ~r~n" + &
//"	ctx_basic_info.custom_10,    ~r~n" + &
//"	ctx_basic_info.group_id,~r~n" + &
//"	ctx_basic_info.revision_reason,       ~r~n" + &
//"	ctx_basic_info.record_id ,   ~r~n" + &
//"	owner = upper((SELECT top 1 ctx_contacts.user_d       ~r~n" + &
//"			FROM ctx_contacts,ctx_contract_contacts       ~r~n" + &
//"			WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) ~r~n" + &
//"			AND (ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
//"			  AND ( ctx_contract_contacts.owner = 'Y' ) ~r~n" + &
//"			  AND ( ctx_contract_contacts.ic_area = 'I' ) )),   ~r~n" + &
//"	contracted_entity = (SELECT top 1 group_multi_loc.rec_id              ~r~n" + &
//"	  			FROM ctx_loc,                  group_multi_loc              ~r~n" + &
//"				WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id) ~r~n" + &
//"				AND ( ctx_loc.ctx_id = ctx_basic_info.ctx_id) ~r~n" + &
//"				AND ctx_loc.loc_id = 0),    ~r~n" + &
//"	app_facility.facility_name facility_name,   ~r~n" + &
//"	ctx_basic_info.custom_date1,      ~r~n" + &
//"	ctx_basic_info.custom_date2,      ~r~n" + &
//"	ctx_basic_info.custom_date3,      ~r~n" + &
//"	ctx_basic_info.custom_date4,  ~r~n" + &
//"	ctx_basic_info.custom_date5,      ~r~n" + &
//"	ctx_basic_info.inserted_by_user,    ~r~n" + &
//"	ctx_basic_info.inserted_at_date_time,      ~r~n" + &
//"	ctx_basic_info.updated_by_user,   ~r~n" + &
//"	ctx_basic_info.~r~n" + &
//"	updated_at_date_time,      ~r~n" + &
//"	ctx_basic_info.custom_11,      ~r~n" + &
//"	ctx_basic_info.custom_12,   ~r~n" + &
//"	ctx_basic_info.custom_13,      ~r~n" + &
//"	ctx_basic_info.custom_14,      ~r~n" + &
//"	ctx_basic_info.custom_15,  ~r~n" + &
//"	ctx_basic_info.custom_16,      ~r~n" + &
//"	ctx_basic_info.custom_17,      ~r~n" + &
//"	ctx_basic_info.custom_18,      ~r~n" + &
//"	ctx_basic_info.custom_19,      ~r~n" + &
//"	ctx_basic_info.custom_20,     ~r~n" + &
//"	ctx_basic_info.custom_date6,      ~r~n" + &
//"	ctx_basic_info.custom_date7,      ~r~n" + &
//"	ctx_basic_info.custom_date8,  ~r~n" + &
//"	ctx_basic_info.custom_date9,      ~r~n" + &
//"	ctx_basic_info.custom_date10,      ~r~n" + &
//"	ctx_basic_info.custom_date11,      ~r~n" + &
//"	ctx_basic_info.custom_date12,      ~r~n" + &
//"	ctx_basic_info.custom_date13,  ~r~n" + &
//"	ctx_basic_info.custom_date14,      ~r~n" + &
//"	ctx_basic_info.custom_date15,      ~r~n" + &
//"	ctx_basic_info.custom_n1, ~r~n" + &
//"	ctx_basic_info.custom_n2,      ~r~n" + &
//"	ctx_basic_info.custom_n3,      ~r~n" + &
//"	ctx_basic_info.custom_n4,      ~r~n" + &
//"	ctx_basic_info.custom_n5,      ~r~n" + &
//"	ctx_basic_info.custom_n6,  ~r~n" + &
//"	ctx_basic_info.custom_n7,      ~r~n" + &
//"	ctx_basic_info.custom_n8,      ~r~n" + &
//"	ctx_basic_info.custom_n9,    ~r~n" + &
//"	ctx_basic_info.custom_n10,      ~r~n" + &
//"	ctx_basic_info.version_number,      ~r~n" + &
//"	ctx_basic_info.version_date,      ~r~n" + &
//"	ctx_basic_info.master_contract_name ,~r~n" + &
//"	access = AA.access    ~r~n" + &
//"FROM  ctx_basic_info  ~r~n" + &
//"LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id  ~r~n" + &
//"LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code  ~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code~r~n" + &
//"LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id, ~r~n" + &
//"(~r~n" + &
//"SELECT DISTINCT TOP 100 Percent  ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END)~r~n" + &
//"FROM ctx_contract_contacts Left Outer Join~r~n" + &
//"(~r~n" + &
//"Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d ~r~n" + &
//"From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1~r~n" + &
//"Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = @user_d~r~n" + &
//"Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d~r~n" + &
//"Having Count(ctx_contract_contacts1.ctx_id) > 1~r~n" + &
//") ccc~r~n" + &
//"On ctx_contract_contacts.ctx_id = ccc.ctx_id~r~n" + &
//",ctx_contacts~r~n" + &
//"WHERE ctx_contacts.user_d = @user_d~r~n" + &
//"	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' )~r~n" + &
//"	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id ~r~n" + &
//"	AND ( ctx_contract_contacts.access IN ('F','R') ~r~n" + &
//"	OR ctx_contract_contacts.owner = 'Y' )~r~n" + &
//"	AND ctx_contract_contacts.ic_area = 'I'~r~n" + &
//"~r~n" + &
//"UNION ~r~n" + &
//"~r~n" + &
//"SELECT DISTINCT TOP 100 Percent ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access~r~n" + &
//"FROM ctx_group_access Left Outer Join ~r~n" + &
//"(~r~n" + &
//"Select ctx_group_access1.ctx_id, security_group_users1.user_id ~r~n" + &
//"From ctx_group_access ctx_group_access1,security_group_users security_group_users1~r~n" + &
//"Where ctx_group_access1.group_id = security_group_users1.group_id And security_group_users1.user_id = @user_d~r~n" + &
//"Group by ctx_group_access1.ctx_id, security_group_users1.user_id~r~n" + &
//"Having count(ctx_group_access1.ctx_id) > 1 ~r~n" + &
//") cga On ctx_group_access.ctx_id = cga.ctx_id ,~r~n" + &
//"security_group_users,~r~n" + &
//"icred_settings~r~n" + &
//"WHERE security_group_users.user_id = @user_d~r~n" + &
//"	AND (cga.ctx_id is null or ctx_group_access.access = 'F')~r~n" + &
//"	AND icred_settings.group_access = 1~r~n" + &
//"	AND ctx_group_access.group_id = security_group_users.group_id~r~n" + &
//"	AND ctx_group_access.access in ('F','R')~r~n" + &
//"	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"			AND ( ctx_contacts.user_d = security_group_users.user_id )~r~n" + &
//"			AND ( ctx_contract_contacts.ic_area = 'I' )~r~n" + &
//"			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id )~r~n" + &
//"			)~r~n" + &
//"~r~n" + &
//"UNION~r~n" + &
//"~r~n" + &
//"SELECT DISTINCT TOP 100 Percent ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END)~r~n" + &
//"FROM ctx_acp_contract_management_right, security_users, ctx_basic_info~r~n" + &
//"WHERE security_users.user_id = @user_d~r~n" + &
//"	AND ctx_acp_contract_management_right.types = 1~r~n" + &
//"	AND ctx_acp_contract_management_right.role_id = security_users.role_id~r~n" + &
//"	AND ctx_acp_contract_management_right.category = ctx_basic_info.category~r~n" + &
//"	AND ctx_acp_contract_management_right.rights In ('11','12')~r~n" + &
//"	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I') ~r~n" + &
//"			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
//"			UNION~r~n" + &
//"			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings~r~n" + &
//"			WHERE icred_settings.group_access = 1~r~n" + &
//"			AND (ctx_group_access.group_id = security_group_users.group_id )~r~n" + &
//"			AND ( security_group_users.user_id = security_users.user_id )	~r~n" + &
//"			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id )~r~n" + &
//"			)~r~n" + &
//") AA ~r~n" + &
//"WHERE ctx_basic_info.ctx_id = AA.ctx_id ~r~n" + &
//"ORDER BY ctx_basic_info.master_contract_id Asc, ctx_basic_info.ctx_id  Asc    ~r~n" + &				
//"~r~n" + &
//"END"

of_execute_sqls("of_ver90_release_storeprocedure1")
Return 1
end function

public function integer of_ver90_release_view1 ();////Added by Ken.Guo on 2009-01-15
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"If exists( select 1 from sysobjects where name = 'v_ctx_user_access' ) ~r~n" + &
//"	Drop view v_ctx_user_access~r~n"
//
////Added by Ken.Guo on 2009-02-12
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"CREATE VIEW v_ctx_user_access AS~r~n" + &
//"SELECT DISTINCT  ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END)~r~n" + &
//"	FROM ctx_contract_contacts Left Outer Join~r~n" + &
//"	(~r~n" + &
//"	Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d ~r~n" + &
//"	From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1~r~n" + &
//"	Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id ~r~n" + &
//"	Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d~r~n" + &
//"	Having Count(ctx_contract_contacts1.ctx_id) > 1~r~n" + &
//"	) ccc~r~n" + &
//"	On ctx_contract_contacts.ctx_id = ccc.ctx_id~r~n" + &
//"	,ctx_contacts~r~n" + &
//"	WHERE 	NOT ctx_contacts.user_d is null~r~n" + &
//"		AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' )~r~n" + &
//"		AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id ~r~n" + &
//"		AND ( ctx_contract_contacts.access IN ('F','R') ~r~n" + &
//"		OR ctx_contract_contacts.owner = 'Y' )~r~n" + &
//"		AND ctx_contract_contacts.ic_area = 'I'~r~n" + &
//"	~r~n" + &
//"	UNION ~r~n" + &
//"	~r~n" + &
//"	SELECT DISTINCT ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access~r~n" + &
//"	FROM ctx_group_access Left Outer Join ~r~n" + &
//"	(~r~n" + &
//"	Select ctx_group_access1.ctx_id, security_group_users1.user_id ~r~n" + &
//"	From ctx_group_access ctx_group_access1,security_group_users security_group_users1~r~n" + &
//"	Where ctx_group_access1.group_id = security_group_users1.group_id ~r~n" + &
//"	Group by ctx_group_access1.ctx_id, security_group_users1.user_id~r~n" + &
//"	Having count(ctx_group_access1.ctx_id) > 1 ~r~n" + &
//"	) cga1 On ctx_group_access.ctx_id = cga1.ctx_id ,~r~n" + &
//"	security_group_users,~r~n" + &
//"	icred_settings~r~n" + &
//"	WHERE	NOT security_group_users.user_id is null~r~n" + &
//"		AND (cga1.ctx_id is null or ctx_group_access.access = 'F')~r~n" + &
//"		AND icred_settings.group_access = 1~r~n" + &
//"		AND ctx_group_access.group_id = security_group_users.group_id~r~n" + &
//"		AND ctx_group_access.access in ('F','R')~r~n" + &
//"		AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"				WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"				AND ( ctx_contacts.user_d = security_group_users.user_id )~r~n" + &
//"				AND ( ctx_contract_contacts.ic_area = 'I' )~r~n" + &
//"				AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id )~r~n" + &
//"				)~r~n" + &
//"	~r~n" + &
//"	UNION~r~n" + &
//"	~r~n" + &
//"	SELECT DISTINCT ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END)~r~n" + &
//"	FROM ctx_acp_contract_management_right, security_users, ctx_basic_info~r~n" + &
//"	WHERE 	NOT security_users.user_id is null~r~n" + &
//"		AND ctx_acp_contract_management_right.types = 1~r~n" + &
//"		AND ctx_acp_contract_management_right.role_id = security_users.role_id~r~n" + &
//"		AND ctx_acp_contract_management_right.category = ctx_basic_info.category~r~n" + &
//"		AND ctx_acp_contract_management_right.rights In ('11','12')~r~n" + &
//"		AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"				WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"				AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I') ~r~n" + &
//"				AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
//"				UNION~r~n" + &
//"				SELECT 1 FROM ctx_group_access,security_group_users,icred_settings~r~n" + &
//"				WHERE icred_settings.group_access = 1~r~n" + &
//"				AND (ctx_group_access.group_id = security_group_users.group_id )~r~n" + &
//"				AND ( security_group_users.user_id = security_users.user_id )	~r~n" + &
//"				AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id )~r~n" + &
//"				)~r~n" + &
//""
//
//
//Added by Ken.Guo on 2009-01-21 -  //Commented by (Appeon)Alfee 08.07.2013 - V141 ISG-CLX
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"If exists( select 1 from sysobjects where name = 'v_ctx_default_external_contacts' )~r~n" + &
//"	Drop view v_ctx_default_external_contacts~r~n" 
//
////Added by Ken.Guo on 2009-01-21
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"~r~n" + &
//"Create View v_ctx_default_external_contacts~r~n" + &
//"As~r~n" + &
//"~r~n" + &
//"Select  ~r~n" + &
//"aa.ctx_id,~r~n" + &
//"cc.contact_id,~r~n" + &
//"cc.full_name,~r~n" + &
//"cc.contact_title,~r~n" + &
//"cc.contact_department,~r~n" + &
//"cc.contact_type,~r~n" + &
//"cc.user_d,~r~n" + &
//"cc.Email,~r~n" + &
//"full_phone = cc.Phone + (Case when cc.Phone_Ext is null or cc.Phone_Ext = '' Then '' Else ' Ext.'+cc.Phone_Ext End ),~r~n" + &
//"full_fax = cc.Fax + (Case when cc.Fax_Ext is null or cc.Fax_Ext = '' Then '' Else ' Ext.'+cc.Fax_Ext End )~r~n" + &
//"From 	~r~n" + &
//"	(Select ~r~n" + &
//"	ctx_id,~r~n" + &
//"	contact_id = (Select top 1 contact_id from ctx_contract_contacts~r~n" + &
//"			where ic_area = 'E' and default_email = 'Y' and ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id~r~n" + &
//"			Order By contact_id)~r~n" + &
//"	~r~n" + &
//"	From ~r~n" + &
//"	ctx_basic_info~r~n" + &
//"	) aa~r~n" + &
//"Left Outer Join~r~n" + &
//"	(~r~n" + &
//"	Select ~r~n" + &
//"	contact_id,~r~n" + &
//"	user_d,~r~n" + &
//"	full_name = last_name + ',' + first_name + ',' + middle_name,~r~n" + &
//"	contact_title = (CASE WHEN  a.Code IS NULL THEN Convert(Varchar(50),ctx_contacts.contact_title) ELSE  a.Code END),~r~n" + &
//"	contact_department = b.code,~r~n" + &
//"	contact_type = c.code,~r~n" + &
//"	Email = (select top 1 ccn.contact_email ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email'))~r~n" + &
//"	,~r~n" + &
//"	Phone = (select top 1 ccn.phone ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone')~r~n" + &
//"			order by ccn.contact_num_id)~r~n" + &
//"	,~r~n" + &
//"	Phone_Ext = (select top 1 ccn.ext ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone')~r~n" + &
//"			order by ccn.contact_num_id )~r~n" + &
//"	,~r~n" + &
//"	Fax = (select top 1 ccn.phone ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Fax')~r~n" + &
//"			order by ccn.contact_num_id	)~r~n" + &
//"	,~r~n" + &
//"	Fax_Ext = (select top 1 ccn.ext ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Fax') ~r~n" + &
//"			order by ccn.contact_num_id	)~r~n" + &
//"	~r~n" + &
//"	From ctx_contacts~r~n" + &
//"	Left Outer Join code_lookup a on Convert(Varchar,a.lookup_code) = Convert(Varchar,ctx_contacts.contact_title)~r~n" + &
//"	Left Outer Join code_lookup b on b.lookup_code = ctx_contacts.contact_department~r~n" + &
//"	Left Outer Join code_lookup c on c.lookup_code = ctx_contacts.contact_type~r~n" + &
//"	) cc~r~n" + &
//"On aa.contact_id = cc.contact_id"
//
////Added by Ken.Guo on 2009-01-22
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"If exists( select 1 from sysobjects where name = 'v_ctx_default_our_contacts' )~r~n" + &
//"	Drop view v_ctx_default_our_contacts~r~n" 
//
////Added by Ken.Guo on 2009-01-22
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"~r~n" + &
//"Create View v_ctx_default_our_contacts~r~n" + &
//"As~r~n" + &
//"~r~n" + &
//"Select  ~r~n" + &
//"aa.ctx_id,~r~n" + &
//"cc.contact_id,~r~n" + &
//"cc.full_name,~r~n" + &
//"cc.contact_title,~r~n" + &
//"cc.contact_department,~r~n" + &
//"cc.contact_type,~r~n" + &
//"cc.user_d,~r~n" + &
//"cc.Email,~r~n" + &
//"full_phone = cc.Phone + (Case when cc.Phone_Ext is null or cc.Phone_Ext = '' Then '' Else ' Ext.'+cc.Phone_Ext End ),~r~n" + &
//"full_fax = cc.Fax + (Case when cc.Fax_Ext is null or cc.Fax_Ext = '' Then '' Else ' Ext.'+cc.Fax_Ext End )~r~n" + &
//"From 	~r~n" + &
//"	(Select ~r~n" + &
//"	ctx_id,~r~n" + &
//"	contact_id = (Select top 1 contact_id from ctx_contract_contacts~r~n" + &
//"			where ic_area = 'I' and default_email = 'Y' and ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id~r~n" + &
//"			Order By contact_id)~r~n" + &
//"	~r~n" + &
//"	From ~r~n" + &
//"	ctx_basic_info~r~n" + &
//"	) aa~r~n" + &
//"Left Outer Join~r~n" + &
//"	(~r~n" + &
//"	Select ~r~n" + &
//"	contact_id,~r~n" + &
//"	user_d,~r~n" + &
//"	full_name = last_name + ',' + first_name + ',' + middle_name,~r~n" + &
//"	contact_title = (CASE WHEN  a.Code IS NULL THEN Convert(Varchar(50),ctx_contacts.contact_title) ELSE  a.Code END),~r~n" + &
//"	contact_department = b.code,~r~n" + &
//"	contact_type = c.code,~r~n" + &
//"	Email = (select top 1 ccn.contact_email ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Email'))~r~n" + &
//"	,~r~n" + &
//"	Phone = (select top 1 ccn.phone ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone')~r~n" + &
//"			order by ccn.contact_num_id)~r~n" + &
//"	,~r~n" + &
//"	Phone_Ext = (select top 1 ccn.ext ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Phone')~r~n" + &
//"			order by ccn.contact_num_id )~r~n" + &
//"	,~r~n" + &
//"	Fax = (select top 1 ccn.phone ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Fax')~r~n" + &
//"			order by ccn.contact_num_id	)~r~n" + &
//"	,~r~n" + &
//"	Fax_Ext = (select top 1 ccn.ext ~r~n" + &
//"			from ctx_contacts_numbers ccn ~r~n" + &
//"			where ccn.contact_id =  ctx_contacts.contact_id and~r~n" + &
//"				ccn.via = (select top 1 lookup_code from code_lookup where lookup_name = 'Contract Contact Via' and code = 'Fax') ~r~n" + &
//"			order by ccn.contact_num_id	)~r~n" + &
//"	~r~n" + &
//"	From ctx_contacts~r~n" + &
//"	Left Outer Join code_lookup a on Convert(Varchar,a.lookup_code) = Convert(Varchar,ctx_contacts.contact_title)~r~n" + &
//"	Left Outer Join code_lookup b on b.lookup_code = ctx_contacts.contact_department~r~n" + &
//"	Left Outer Join code_lookup c on c.lookup_code = ctx_contacts.contact_type~r~n" + &
//"	) cc~r~n" + &
//"On aa.contact_id = cc.contact_id"

//Added by Scofield on 2009-06-19
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_requirement') ~r~n" + &
"  drop view v_ctx_requirement"

//Added by Scofield on 2009-06-19
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create view v_ctx_requirement as~r~n" + &
"select ~r~n" + &
"       ctx_req_profile_hdr_1.ctx_id,~r~n" + &
"       ctx_req_profile.rqmnt_name,~r~n" + &
"       ctx_req_profile.rqmnt_description,~r~n" + &
"       ctx_rqmnt_category.category_name,~r~n" + &
"       ctx_req_tmplt_element.element_name,~r~n" + &
"       datavalue = (case ctx_req_tmplt_element.value_type~r~n" + &
"                         when 1 then convert(varchar,ctx_elements.date_value)~r~n" + &
"                         when 2 then ctx_elements.field_value~r~n" + &
"                         when 3 then ctx_elements.char_value~r~n" + &
"                         when 4 then convert(varchar,ctx_elements.integer_value)~r~n" + &
"                         when 5 then ctx_elements.field_value end),~r~n" + &
"       ctx_elements.clause~r~n" + &
"  from ctx_req_profile~r~n" + &
"       inner join ctx_req_profile_hdr as ctx_req_profile_hdr_1 on ctx_req_profile.ctx_req_profile_id = ctx_req_profile_hdr_1.ctx_req_profile_id~r~n" + &
"       inner join ctx_rqmnt_category on ctx_rqmnt_category.ctx_req_profile_id = ctx_req_profile_hdr_1.ctx_req_profile_id~r~n" + &
"       inner join ctx_req_tmplt_element on ctx_rqmnt_category.ctx_req_profile_id = ctx_req_tmplt_element.ctx_req_profile_id and ctx_rqmnt_category.ctx_rqmnt_category_id = ctx_req_tmplt_element.ctx_rqmnt_category_id~r~n" + &
"       inner join ctx_elements on ctx_elements.ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id and ctx_req_profile_hdr_1.ctx_req_profile_hdr_id = ctx_elements.ctx_req_profile_hdr_id~r~n" //+ &
//"order by ctx_req_profile_hdr_1.ctx_id"

//Added by Scofield on 2009-07-27
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_basic_info') ~r~n" + &
" drop view v_ctx_basic_info"

//Added by Scofield on 2009-07-27
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW  v_ctx_basic_info AS~r~n" + &
"SELECT ~r~n" + &
"       app_facility.facility_name AS Company_Name,~r~n" + &
"       app_facility.street AS Company_street_1,~r~n" + &
"       app_facility.street_2 AS Company_street_2,~r~n" + &
"       app_facility.city AS Company_city,~r~n" + &
"       app_facility.state AS Company_state,~r~n" + &
"       app_facility.zip AS Company_zip,~r~n" + &
"       app_facility.country AS Company_country,~r~n" + &
"       app_facility.phone AS Company_phone,~r~n" + &
"       app_facility.fax AS Company_fax,~r~n" + &
"       app_facility.web_address AS Company_web_address,~r~n" + &
"       app_facility.contact_type2 AS Company_contact_type2,~r~n" + &
"       app_facility.corp_office_flag AS Company_corp_office_flag,~r~n" + &
"       app_facility.corp_office_link AS Company_corp_office_link,~r~n" + &
"       code_lookup.code AS Contract_Category_code,~r~n" + &
"       code_lookup.description AS Contract_Category_description,~r~n" + &
"       code_lookup_1.code AS Contract_Status_code,~r~n" + &
"       code_lookup_2.code AS contract_type_code,~r~n" + &
"       code_lookup_2.description AS contract_type_Description,~r~n" + &
"       code_lookup_3.code AS term_reason_code,~r~n" + &
"       code_lookup_3.description AS term_Reason_Desciption,~r~n" + &
"       code_lookup_4.description AS product_type_desc,~r~n" + &
"       code_lookup_4.code AS product_type_code,~r~n" + &
"       code_lookup_5.code AS product_code,~r~n" + &
"       code_lookup_5.description AS product_description,~r~n" + &
"       ctx_basic_info.ctx_id,~r~n" + &
"       ctx_basic_info.category,~r~n" + &
"       ctx_basic_info.status,~r~n" + &
"       ctx_basic_info.facility_id,~r~n" + &
"       ctx_basic_info.contract_type,~r~n" + &
"       ctx_basic_info.product_type,~r~n" + &
"       ctx_basic_info.product_name,~r~n" + &
"       ctx_basic_info.reimbursment_menth,~r~n" + &
"       ctx_basic_info.file_location,~r~n" + &
"       ctx_basic_info.effective_date,~r~n" + &
"       ctx_basic_info.expriation_date,~r~n" + &
"       ctx_basic_info.review_date,~r~n" + &
"       ctx_basic_info.review_by,~r~n" + &
"       ctx_basic_info.term_date,~r~n" + &
"       ctx_basic_info.term_reason,~r~n" + &
"       ctx_basic_info.last_revis_date,~r~n" + &
"       ctx_basic_info.other_date_1,~r~n" + &
"       ctx_basic_info.other_date_2,~r~n" + &
"       ctx_basic_info.oc_signed_by,~r~n" + &
"       ctx_basic_info.oc_title,~r~n" + &
"       ctx_basic_info.oc_department,~r~n" + &
"       ctx_basic_info.oc_legal_rep,~r~n" + &
"       ctx_basic_info.cc_signed_by,~r~n" + &
"       ctx_basic_info.cc_title,~r~n" + &
"       ctx_basic_info.cc_department,~r~n" + &
"       ctx_basic_info.cc_legal_rep,~r~n" + &
"       ctx_basic_info.keyword,~r~n" + &
"       ctx_basic_info.dvision,~r~n" + &
"       ctx_basic_info.custom_1,~r~n" + &
"       ctx_basic_info.custom_2,~r~n" + &
"       ctx_basic_info.custom_3,~r~n" + &
"       ctx_basic_info.custom_4,~r~n" + &
"       ctx_basic_info.custom_5,~r~n" + &
"       ctx_basic_info.custom_6,~r~n" + &
"       ctx_basic_info.custom_7,~r~n" + &
"       ctx_basic_info.custom_8,~r~n" + &
"       ctx_basic_info.custom_9,~r~n" + &
"       ctx_basic_info.custom_10,~r~n" + &
"       ctx_basic_info.group_multi_loc_id,~r~n" + &
"       ctx_basic_info.revision_reason,~r~n" + &
"       ctx_basic_info.group_id,~r~n" + &
"       ctx_basic_info.record_id,~r~n" + &
"       ctx_basic_info.custom_11,~r~n" + &
"       ctx_basic_info.custom_12,~r~n" + &
"       ctx_basic_info.custom_13,~r~n" + &
"       ctx_basic_info.custom_14,~r~n" + &
"       ctx_basic_info.custom_15,~r~n" + &
"       ctx_basic_info.custom_16,~r~n" + &
"       ctx_basic_info.custom_17,~r~n" + &
"       ctx_basic_info.custom_18,~r~n" + &
"       ctx_basic_info.custom_19,~r~n" + &
"       ctx_basic_info.custom_20,~r~n" + &
"       ctx_basic_info.custom_date1,~r~n" + &
"       ctx_basic_info.custom_date2,~r~n" + &
"       ctx_basic_info.custom_date3,~r~n" + &
"       ctx_basic_info.custom_date4,~r~n" + &
"       ctx_basic_info.custom_date5,~r~n" + &
"       ctx_basic_info.custom_date6,~r~n" + &
"       ctx_basic_info.custom_date7,~r~n" + &
"       ctx_basic_info.custom_date8,~r~n" + &
"       ctx_basic_info.custom_date9,~r~n" + &
"       ctx_basic_info.custom_date10,~r~n" + &
"       ctx_basic_info.custom_n1,~r~n" + &
"       ctx_basic_info.custom_n2,~r~n" + &
"       ctx_basic_info.custom_n3,~r~n" + &
"       ctx_basic_info.custom_n4,~r~n" + &
"       ctx_basic_info.custom_n5,~r~n" + &
"       ctx_basic_info.custom_n6,~r~n" + &
"       ctx_basic_info.custom_n7,~r~n" + &
"       ctx_basic_info.custom_n8,~r~n" + &
"       ctx_basic_info.custom_n9,~r~n" + &
"       ctx_basic_info.custom_n10,~r~n" + &
"       ctx_basic_info.custom_n11,~r~n" + &
"       ctx_basic_info.custom_n12,~r~n" + &
"       ctx_basic_info.custom_n13,~r~n" + &
"       ctx_basic_info.custom_n14,~r~n" + &
"       ctx_basic_info.custom_n15,~r~n" + &
"       ctx_basic_info.custom_n16,~r~n" + &
"       ctx_basic_info.custom_n17,~r~n" + &
"       ctx_basic_info.custom_n18,~r~n" + &
"       ctx_basic_info.custom_n19,~r~n" + &
"       ctx_basic_info.custom_n20,~r~n" + &
"       ctx_basic_info.custom_n21,~r~n" + &
"       ctx_basic_info.custom_n22,~r~n" + &
"       ctx_basic_info.custom_n23,~r~n" + &
"       ctx_basic_info.custom_n24,~r~n" + &
"       ctx_basic_info.custom_n25,~r~n" + &
"       ctx_basic_info.version_number,~r~n" + &
"       ctx_basic_info.version_date,~r~n" + &
"       ctx_basic_info.notes,~r~n" + &
"       ctx_basic_info.app_facility,~r~n" + &
"       ctx_basic_info.master_contract_id AS master_ctx_id,~r~n" + &
"       ctx_basic_info.master_contract_name,~r~n" + &
"       code_lookup_6.code AS dvision_code,~r~n" + &
"       code_lookup_6.description AS dvision_description~r~n" + &
"  FROM (((((((ctx_basic_info LEFT OUTER JOIN code_lookup ON ctx_basic_info.category = code_lookup.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_basic_info.status = code_lookup_1.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_2 ON ctx_basic_info.contract_type = code_lookup_2.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_3 ON ctx_basic_info.term_reason = code_lookup_3.lookup_code)~r~n" + &
"       INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id)~r~n" + &
"       INNER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_6 ON ctx_basic_info.dvision = code_lookup_6.lookup_code~r~n" //+ &
//"ORDER BY ctx_basic_info.ctx_id"

//Added by Scofield on 2009-07-27
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_custom') ~r~n" + &
" drop view v_ctx_custom"

//Added by Scofield on 2009-07-27
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_custom AS ~r~n" + &
"SELECT ~r~n" + &
"       ctx_id,~r~n" + &
"       custom_1,~r~n" + &
"       custom_2,~r~n" + &
"       custom_3,~r~n" + &
"       custom_4,~r~n" + &
"       custom_5,~r~n" + &
"       custom_6,~r~n" + &
"       custom_7,~r~n" + &
"       custom_8,~r~n" + &
"       custom_9,~r~n" + &
"       custom_10,~r~n" + &
"       custom_11,~r~n" + &
"       custom_12,~r~n" + &
"       custom_13,~r~n" + &
"       custom_14,~r~n" + &
"       custom_15,~r~n" + &
"       custom_16,~r~n" + &
"       custom_17,~r~n" + &
"       custom_18,~r~n" + &
"       custom_19,~r~n" + &
"       custom_20,~r~n" + &
"       custom_date1,~r~n" + &
"       custom_date2,~r~n" + &
"       custom_date3,~r~n" + &
"       custom_date4,~r~n" + &
"       custom_date5,~r~n" + &
"       custom_date6,~r~n" + &
"       custom_date7,~r~n" + &
"       custom_date8,~r~n" + &
"       custom_date9,~r~n" + &
"       custom_date10,~r~n" + &
"       custom_date11,~r~n" + &
"       custom_date12,~r~n" + &
"       custom_date13,~r~n" + &
"       custom_date14,~r~n" + &
"       custom_date15,~r~n" + &
"       custom_n1,~r~n" + &
"       custom_n2,~r~n" + &
"       custom_n3,~r~n" + &
"       custom_n4,~r~n" + &
"       custom_n5,~r~n" + &
"       custom_n6,~r~n" + &
"       custom_n7,~r~n" + &
"       custom_n8,~r~n" + &
"       custom_n9,~r~n" + &
"       custom_n10,~r~n" + &
"       custom_n11,~r~n" + &
"       custom_n12,~r~n" + &
"       custom_n13,~r~n" + &
"       custom_n14,~r~n" + &
"       custom_n15,~r~n" + &
"       custom_n16,~r~n" + &
"       custom_n17,~r~n" + &
"       custom_n18,~r~n" + &
"       custom_n19,~r~n" + &
"       custom_n20,~r~n" + &
"       custom_n21,~r~n" + &
"       custom_n22,~r~n" + &
"       custom_n23,~r~n" + &
"       custom_n24,~r~n" + &
"       custom_n25~r~n" + &
"  FROM ctx_basic_info~r~n" //+ &
//"ORDER BY ctx_id"

of_execute_sqls("of_ver90_release_view1")

Return 1

end function

public function integer of_ver95_release_table1 ();//BEGIN---Modify by Scofield on 2009-08-12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_21' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_21 varchar(255) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_22' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_22 varchar(255) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n26' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_n26 numeric(12,2) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n27' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_n27 numeric(12,2) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date16' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_date16 datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date17' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_date17 datetime Null"
//END---Modify by Scofield on 2009-08-12

//Add by jervis 09.08.14
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='unit_type' and t.table_name='ctx_cpt_codes' ) " + &
"alter table ctx_cpt_codes add unit_type int null "

//Added By Ken.Guo 2009-08-17.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_templates_info' )~r~n" + &
"	Create Table ctx_templates_info ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		template_name varchar(50) not null,~r~n" + &
"		create_date datetime null,~r~n" + &
"		create_by varchar(50) null,~r~n" + &
"		ctx_id numeric(10,0) null,~r~n" + &
"		original_ctx_id numeric(10,0) null,~r~n" + &
"		ib_contract_detail bit null,~r~n" + &
"		ib_contract_dates bit null,~r~n" + &
"		ib_custom_data bit null,~r~n" + &
"		ib_notes bit null,~r~n" + &
"		ib_contract_contacts bit null,~r~n" + &
"		ib_group_access bit null,~r~n" + &
"		ib_products bit null,~r~n" + &
"		ib_our_contacts bit null,~r~n" + &
"		ib_requirements bit null,~r~n" + &
"		ib_other_contacts bit null,~r~n" + &
"		ib_locations bit null,~r~n" + &
"		ib_organizations bit null,~r~n" + &
"		ib_fee_schedule bit null,~r~n" + &
"		ib_document_manager bit null,~r~n" + &
"		ib_action_items bit null,~r~n" + &
"		notes varchar(200) null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n" 

//Add by jervis 08.20.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='money_value' and t.table_name='ctx_elements' ) " + &
"alter table ctx_elements add money_value numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='char_value' and t.table_name='ctx_req_tmplt_element' ) " + &
"alter table ctx_req_tmplt_element add char_value char(1) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='integer_value' and t.table_name='ctx_req_tmplt_element' ) " + &
"alter table ctx_req_tmplt_element add integer_value numeric(8,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='money_value' and t.table_name='ctx_req_tmplt_element' ) " + &
"alter table ctx_req_tmplt_element add money_value numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='date_value' and t.table_name='ctx_req_tmplt_element' ) " + &
"alter table ctx_req_tmplt_element add date_value datetime null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='field_value' and t.table_name='ctx_req_tmplt_element' ) " + &
"alter table ctx_req_tmplt_element add field_value varchar(50) null "

//Added By Ken.Guo 2009-08-24.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='is_template' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add is_template integer null  "

//Added By Zhangxingren 2009-08-24. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='view_id' and t.table_name='export_header' ) " + &
"alter table export_header add view_id int null"

//Added By Ken.Guo 2009-08-24.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_template_id' and t.table_name='ids' ) " + &
"ALTER table ids add ctx_template_id numeric(10,0) null  "

//Added By Ken.Guo 2009-08-28.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='located_tab_index' and t.table_name='ctx_templates_info' ) " + &
"ALTER table ctx_templates_info add located_tab_index integer null  ~r~n" 

//Added By Ken.Guo 2009-08-28.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='clear_company' and t.table_name='ctx_templates_info' ) " + &
"ALTER table ctx_templates_info add clear_company bit null  ~r~n" 

//Added By Ken.Guo 2009-08-28.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='add_contact' and t.table_name='ctx_templates_info' ) " + &
"ALTER table ctx_templates_info add add_contact bit null  "

//Added By Ken.Guo 2009-08-28.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='trigger_workflow' and t.table_name='ctx_templates_info' ) " + &
"ALTER table ctx_templates_info add trigger_workflow numeric(10) null  "

//Added by Scofield on 2009-08-28
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='DisplayLocation' and t.table_name='wf_action_types' ) " + &
"ALTER TABLE wf_action_types ADD DisplayLocation int Null"

//Added By Ken.Guo 2009-09-01.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'dashboard_gadget_other_properties' )~r~n" + &
"	Create Table dashboard_gadget_other_properties ~r~n" + &
"	(~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		tab_id  numeric(10,0) not null,~r~n" + &
"		gadget_id numeric(10,0) not null,~r~n" + &
"		property_name varchar(50) not null,~r~n" + &
"		property_value	varchar(200) null,~r~n" + &
"		Primary Key(user_id,tab_id,gadget_id,property_name)~r~n" + &
"	)~r~n" 

//Added by Scofield on 2009-09-08
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Relative_Days' and t.table_name='ctx_screen_datafill' ) " + &
"ALTER TABLE ctx_screen_datafill ADD Relative_Days int Null"

//Added By Ken.Guo 2009-09-10.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"~r~n" + &
"if not exists( select 1 from sysobjects where name = 'ctx_notification_templates' )~r~n" + &
"	Create Table ctx_notification_templates ~r~n" + &
"	(~r~n" + &
"		view_id numeric(10) not null,~r~n" + &
"		alm_table varchar(40) not null,~r~n" + &
"		alm_column varchar(40) not null,~r~n" + &
"		alm_message varchar(255) null,~r~n" + &
"		alm_enabled char(1) null,~r~n" + &
"		alm_notification_days integer null,~r~n" + &
"		alm_last_notification_sent datetime null,~r~n" + &
"		alm_post_notification_days integer null,~r~n" + &
"		alm_total_tries integer null,~r~n" + &
"		alm_action_item_posted integer null,~r~n" + &
"		alm_total_tries_counter integer null,~r~n" + &
"		alm_frequency integer null,~r~n" + &
"		create_action_item char(1) null,~r~n" + &
"		record_id numeric(10) null,~r~n" + &
"		alm_auto_increment_years integer null,~r~n" + &
"		alm_action_title varchar(40) null,~r~n" + &
"		wf_id integer null,~r~n" + &
"		alm_auto_increment_unit char(1) null,~r~n" + &
"		alm_last_wf_trigger datetime null,~r~n" + &
"		alm_email_template_id integer null,~r~n" + &
"		alm_message_blob image null,~r~n" + &
"		alm_attachment_name varchar(100) null,~r~n" + &
"		alm_attachment image null,~r~n" + &
"		alm_mailto varchar(2000) null,~r~n" + &
"		auto_sign varchar(1) null,~r~n" + &
"		Primary Key(view_id,alm_table,alm_column)		~r~n" + &
"	)~r~n" + &
""

//Added By Ken.Guo 2009-09-11.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_notification_templates_attachments' )~r~n" + &
"	Create Table ctx_notification_templates_attachments ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0)  not null,~r~n" + &
"		view_id numeric(10) not null,~r~n" + &
"		alm_table varchar(40) not null,~r~n" + &
"		alm_column varchar(40) not null,~r~n" + &
"		alm_attachment_name varchar(100) null,~r~n" + &
"		alm_attachment image null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n" + &
""

//Added By Ken.Guo 2009-09-14.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='attach_from_template' and t.table_name='ctx_notification_templates' ) " + &
"ALTER table ctx_notification_templates add attach_from_template integer null  ~r~n" + &
""

//Added By Ken.Guo 2009-09-15.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_alm_snooze' )~r~n" + &
"	Create Table ctx_alm_snooze ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		ctx_id numeric(10) not null,	~r~n" + &
"		alm_table varchar(40) not null,~r~n" + &
"		alm_column varchar(40) not null,~r~n" + &
"		increment_value integer  null,~r~n" + &
"		increment_unit char(1)  null,~r~n" + &
"		asnooze_executed integer null,~r~n" + &
"		snooze_loop integer null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"

//Added By Ken.Guo 2009-09-16.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='view_id' and t.table_name='ctx_alm_snooze' ) " + &
"ALTER table ctx_alm_snooze add view_id numeric(10,0) null  "

//Added by Scofield on 2009-09-18
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='set_autoresize' and t.table_name='security_users' ) " + &
"ALTER TABLE security_users ADD set_autoresize int Null"

//Added by jervis 09.22.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='code' and t.table_name='export_equiv_code' ) " + &
"	alter table export_equiv_code modify code varchar(30) null "

//Added by Scofield on 2009-09-22
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='is_template' and t.table_name='ctx_basic_info' ) " + &
	"ALTER TABLE ctx_basic_info MODIFY is_template DEFAULT 0 "

//Addby jervis 09.27.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_screen_field_depend' )~r~n" + &
"	create table ctx_screen_field_depend(~r~n" + &
"		rec_id int identity not null,~r~n" + &
"		view_id	int not null,~r~n" + &
"		base_field	varchar(100)	not null,~r~n" + &
"		depend_field	varchar(100) not null,~r~n" + &
"		CONSTRAINT PK_ctx_screen_field_depend  PRIMARY KEY(rec_id)~r~n" + &
"	)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_lookup_depend' )~r~n" + &
"	create table ctx_lookup_depend(~r~n" + &
"		rec_id int identity not null,~r~n" + &
"		base_lookup_code	numeric(6,0) not null,~r~n" + &
"		depend_lookup_code	numeric(6,0) not null,~r~n" + &
"		depend_type	int not null default 1,~r~n" + &
"		CONSTRAINT PK_ctx_lookup_depend  PRIMARY KEY(rec_id)~r~n" + &
"	)"

//Add by jervis 09.30.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='screen_visible' and t.table_name='ctx_screen' ) " + &
"ALTER TABLE ctx_screen ADD screen_visible varchar(1) Null default 'Y'"

//Added By Ken.Guo 2009-10-12.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'db_upgrade_log' )~r~n" + &
"	Create Table db_upgrade_log ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		upgrade_by varchar(50) null,~r~n" + &
"		upgrade_date datetime null,~r~n" + &
"		old_db_version varchar(50) null,~r~n" + &
"		new_db_version varchar(50) null,	~r~n" + &
"		app_version varchar(50) null, ~r~n" + &
"		from_cache_name varchar(50) null,~r~n" + &
"		upgrade_result varchaR(20) null,~r~n" + &
"		comment_info varchar(500) null,			~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"

//Add by jervis 10.12.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_create' and t.table_name='ctx_notification' ) " + &
"alter table ctx_notification add alm_create varchar(2000) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_create' and t.table_name='ctx_ai_notification' ) " + &
"alter table ctx_ai_notification add alm_create varchar(2000) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_create' and t.table_name='ctx_am_ai_notification' ) " + &
"alter table ctx_am_ai_notification add alm_create varchar(2000) null"

//Added By Ken.Guo 2009-10-19.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ocr_language' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add ocr_language integer null  ~r~n" 

//Added By Ken.Guo 2009-10-19.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ocr_mode' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add ocr_mode integer null  ~r~n" 

//Added by jervis 2009-10-21
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_ext_full' and t.table_name='ctx_am_doc_image' ) " + &
"ALTER TABLE ctx_am_doc_image ADD doc_ext_full varchar(10) Null"

//Added By Ken.Guo 2009-10-28.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_browse_style' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add ctx_browse_style integer null  ~r~n"

//BEGIN---Modify by Scofield on 2009-10-30
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table ctx_am_document modify doc_type varchar(30) not null"
//END---Modify by Scofield on 2009-10-30

//BEGIN---Modify by Scofield on 2009-11-02
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Received_By' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD Received_By varchar(20) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Received_Date' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD Received_Date datetime Null"
//END---Modify by Scofield on 2009-11-02

//Add by jervis 11.3.2009
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='base_screen_id' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend Add base_screen_id int not null default 0"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='depend_screen_id' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add depend_screen_id int not null default 0"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='base_field_dispaly' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add base_field_dispaly	varchar(255) not null default ''"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='depend_field_dispaly' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add depend_field_dispaly	varchar(255) not null default ''"

//Update data before drop column screen_id
int li_exists
SELECT 1 into :li_exists FROM sys.syscolumn c, sys.systable t 
WHERE c.table_id = t.table_id AND c.column_name = 'screen_id' 		
	AND t.table_name = 'ctx_screen_field_depend' ;

if li_exists = 1 then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
	"   c.column_name='screen_id' and t.table_name='ctx_screen_field_depend' ) " + &
	"Begin~r~n" + &
	"	update ctx_screen_field_depend set base_screen_id = screen_id where base_screen_id = 0 ~r~n" + &	
	"	update ctx_screen_field_depend set depend_screen_id = screen_id where depend_screen_id = 0  ~r~n" + &
	"End"
		
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"alter table ctx_screen_field_depend drop screen_id"
end if

li_exists = 0
SELECT 1 into :li_exists FROM sys.syscolumn c, sys.systable t 
WHERE c.table_id = t.table_id AND c.column_name = 'base_lookup_name' 		
	AND t.table_name = 'ctx_lookup_depend' ;	
	
if li_exists = 1 then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"alter table ctx_lookup_depend drop base_lookup_name"
end if


li_exists = 0
SELECT 1 into :li_exists FROM sys.syscolumn c, sys.systable t 
WHERE c.table_id = t.table_id AND c.column_name = 'depend_lookup_name' 		
	AND t.table_name = 'ctx_lookup_depend' ;	

if li_exists = 1 then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"alter table ctx_lookup_depend drop depend_lookup_name"
end if

/*
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if Exists(~r~n" + &
"   SELECT 1 ~r~n" + &
"     FROM syscolumns, sysobjects~r~n" + &
"    WHERE syscolumns.id   = sysobjects.id~r~n" + &
"      AND syscolumns.name = 'screen_id'~r~n" + &
"      AND sysobjects.name = 'ctx_screen_field_depend'~r~n" + &
"      AND sysobjects.type = 'U')~r~n" + &
"alter table ctx_screen_field_depend drop column screen_id"


is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if Not Exists(~r~n" + &
"   SELECT 1 ~r~n" + &
"     FROM syscolumns, sysobjects~r~n" + &
"    WHERE syscolumns.id   = sysobjects.id~r~n" + &
"      AND syscolumns.name = 'base_lookup_name'~r~n" + &
"      AND sysobjects.name = 'ctx_lookup_depend'~r~n" + &
"      AND sysobjects.type = 'U')~r~n" + &
"alter table ctx_lookup_depend drop column base_lookup_name"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if Not Exists(~r~n" + &
"   SELECT 1 ~r~n" + &
"     FROM syscolumns, sysobjects~r~n" + &
"    WHERE syscolumns.id   = sysobjects.id~r~n" + &
"      AND syscolumns.name = 'depend_lookup_name'~r~n" + &
"      AND sysobjects.name = 'ctx_lookup_depend'~r~n" + &
"      AND sysobjects.type = 'U')~r~n" + &
"alter table ctx_lookup_depend drop column depend_lookup_name"
*/

//Added By Ken.Guo 2009-11-11.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_ocr' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add auto_ocr integer null  "


//Add by jervis 2009-11-12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='base_screen_type' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add base_screen_type char(1) not null default 'M'  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='base_table' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add base_table varchar(128) null  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='depend_table' and t.table_name='ctx_screen_field_depend' ) " + &
"alter table ctx_screen_field_depend add depend_table varchar(128) null  "


//Add by jervis 2009-11-24
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'conv_view_pic' )~r~n" + &
"create table conv_view_pic~r~n" + &
"(~r~n" + &
"	view_id int  not null,~r~n" + &
"	Screen_id int not null default 0,~r~n" + &
"	pic_id	int identity not null,~r~n" + &
"	pic_type	varchar(10) null,~r~n" + &
"	pic_band	varchar(50) null,~r~n" + &
"	pic_name	varchar(50) null,~r~n" + &
"	pic_filename	varchar(100) null,~r~n" + &
"	pic_bitmap	image null,~r~n" + &
"	pic_x	int null,~r~n" + &
"	pic_y	int null,~r~n" + &
"	pic_width int null,~r~n" + &
"	pic_height int null,~r~n" + &
"	pic_tag	varchar(100),~r~n" + &
"	CONSTRAINT   pk_conv_view_pic primary key(view_id,Screen_id,pic_id)	~r~n" + &
")"

//Add by jervis 2009-12-02
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table conv_view_where modify table_field_name varchar(1200)"

//BEGIN---Modify by Scofield on 2009-12-03
//ctx_action_items
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Subject' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Subject varchar(255) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Start_Date' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Start_Date datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Start_Time' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Start_Time datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Duration' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Duration int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Duration_Type' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Duration_Type int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='End_Date' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD End_Date datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='End_Time' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD End_Time datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Priority' and t.table_name='ctx_action_items' ) " + &
"ALTER TABLE ctx_action_items ADD Priority int Null"

//ctx_am_action_item
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Subject' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Subject varchar(255) Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Start_Date' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Start_Date datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Start_Time' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Start_Time datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Duration' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Duration int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Duration_Type' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Duration_Type int Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='End_Date' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD End_Date datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='End_Time' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD End_Time datetime Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Priority' and t.table_name='ctx_am_action_item' ) " + &
"ALTER TABLE ctx_am_action_item ADD Priority int Null"
//END---Modify by Scofield on 2009-12-03

//Added By Ken.Guo 2009-12-16.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_auto_retrieve' and t.table_name='security_users' ) " + &
"ALTER table security_users add doc_auto_retrieve integer null  "

//Added By Ken.Guo 2009-12-18.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_user_tv_settings' )~r~n" + &
"	Create Table ctx_user_tv_settings ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		show_group integer null,~r~n" + &
"		group_by varchar(50) null,~r~n" + &
"		group_sort_type varchar(1) null,~r~n" + &
"		display_col1 varchar(50) null,~r~n" + &
"		display_col2 varchar(50) null,~r~n" + &
"		display_col3 varchar(50) null,~r~n" + &
"		display_col4 varchar(50) null,~r~n" + &
"		display_col5 varchar(50) null,~r~n" + &
"		display_sort_by varchar(50) null,~r~n" + &
"		display_sort_type varchar(1) null, ~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"

//Added By Ken.Guo 2009-12-22.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='displaycount' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add displaycount integer null ~r~n" 

//Added By Ken.Guo 2009-12-24.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='contract_display_mode' and t.table_name='security_users' ) " + &
"ALTER table security_users add contract_display_mode integer null~r~n" 

//Added By Ken.Guo 2009-12-29.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='hide_browse' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add hide_browse integer null ~r~n" 

//Added By Ken.Guo 2009-12-29.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='max_width' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add max_width integer null ~r~n" 


//Added By Jervis.zhang 2009.12.30
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='comment_disp' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add comment_disp bit null default 0 ~r~n" 

//BEGIN---Modify by Scofield on 2010-01-06
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if Not Exists (SELECT TOP 1 1~r~n" + &
"                 FROM sysobjects~r~n" + &
"                WHERE name='ctx_acp_clause_attribute' and type = 'U')~r~n" + &
"CREATE TABLE ctx_acp_clause_attribute~r~n" + &
"(	ctx_acp_clause_id         numeric(6,0),~r~n" + &
"	clause_attribute_id       numeric(6,0),~r~n" + &
"	clause_attribute_alias    varchar(255),~r~n" + &
"	CONSTRAINT PK_CTX_ACP_CLAUSE_ATTRIBUTE PRIMARY KEY (ctx_acp_clause_id,clause_attribute_id),~r~n" + &
"	CONSTRAINT FK_CLAUSE_ATTRIBUTE_CTX_ACP_CLAUSE FOREIGN KEY (ctx_acp_clause_id) REFERENCES ctx_acp_clause(ctx_acp_clause_id),~r~n" + &
"    CONSTRAINT FK_CLAUSE_ATTRIBUTE_CODE_LOOKUP FOREIGN KEY (clause_attribute_id) REFERENCES code_lookup(lookup_code)~r~n" + &
")"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if Not Exists (SELECT TOP 1 1~r~n" + &
"                 FROM sysobjects~r~n" + &
"                WHERE name='ctx_acp_clause_attr_value' and type = 'U')~r~n" + &
"CREATE TABLE ctx_acp_clause_attr_value~r~n" + &
"(	ctx_acp_clause_id         numeric(6,0),~r~n" + &
"	clause_attribute_id       numeric(6,0),~r~n" + &
"	clause_attribute_value_id numeric(6,0),~r~n" + &
"	CONSTRAINT PK_CTX_ACP_CLAUSE_ATTR_VALUE PRIMARY KEY (ctx_acp_clause_id,clause_attribute_id,clause_attribute_value_id),~r~n" + &
"	CONSTRAINT FK_CLAUSE_ATTR_VALUE_ACP_CLAUSE FOREIGN KEY (ctx_acp_clause_id,clause_attribute_id) REFERENCES ctx_acp_clause_attribute(ctx_acp_clause_id,clause_attribute_id),~r~n" + &
"	CONSTRAINT FK_CLAUSE_ATTR_VALUE_CODE_LOOKUP FOREIGN KEY (clause_attribute_value_id) REFERENCES code_lookup(lookup_code)~r~n" + &
")"
//END---Modify by Scofield on 2010-01-06

//BEGIN---Modify by Scofield on 2010-01-09
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalActItemFilter_0' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalActItemFilter_0 text Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalActItemFilter_1' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalActItemFilter_1 text Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalActItemFilter_2' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalActItemFilter_2 text Null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalActItemFilter_3' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalActItemFilter_3 text Null"

//END---Modify by Scofield on 2010-01-09

//Added By Ken.Guo 2010-01-11.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_acp_clause_audit' )~r~n" + &
"	Create Table ctx_acp_clause_audit ~r~n" + &
"	(~r~n" + &
"		audit_id numeric(10,0) identity not null,~r~n" + &
"		clause_id  numeric(10,0) not null,~r~n" + &
"		revision numeric(5,1) not null,~r~n" + &
"		actions varchar(200) not null,~r~n" + &
"		action_by varchar(50) null,~r~n" + &
"		action_date datetime null,~r~n" + &
"		notes varchar(255) null,~r~n" + &
"		Primary Key(audit_id)~r~n" + &
"	)" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_acp_clause_image' )~r~n" + &
"	Create Table ctx_acp_clause_image ~r~n" + &
"	(~r~n" + &
"		clause_id  numeric(10,0) not null,~r~n" + &
"		revision numeric(5,1) not null,~r~n" + &
"		image_file image null,~r~n" + &
"		modify_date datetime null,~r~n" + &
"		id_forcatalog int identity not null,~r~n" + &
"		Primary Key(clause_id,revision)~r~n" + &
"	)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='revision' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add revision numeric(5,1) null  ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='checkout_by' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add checkout_by varchar(50) null  ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='checkout_date' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add checkout_date datetime null  ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='checkout_status' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add checkout_status varchar(1) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='revision_control' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add revision_control varchar(1) null ~r~n" 
//End Ken.Guo 2010-01-11.

//Added By Ken.Guo 2010-01-19.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_type' and t.table_name='ctx_acp_clause_image' ) " + &
"ALTER table ctx_acp_clause_image add doc_type varchar(10) null  "

//Added By Ken.Guo 2010-02-04.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_name_format' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add doc_name_format integer null  ~r~n" 



of_execute_sqls("of_ver95_release_table1")

Return 1

end function

public function integer of_ver95_release_table2 ();//Added By Ken.Guo 2010-02-25.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='filter_documents' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add filter_documents integer null"

//Added By Ken.Guo 2010-02-25. from Zhangxingren
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table app_facility modify state varchar(5) null"

//BEGIN---Modify by Scofield on 2010-03-02
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"ALTER TABLE ctx_action_items MODIFY Start_Time DEFAULT '1900-01-01 00:00:00' " 
//END---Modify by Scofield on 2010-03-02

//Added By Ken.Guo 2010-03-09.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='screen_version' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add screen_version varchar(4)~r~n" 

//BEGIN---Modify by Scofield on 2010-03-16
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalFilterName_1' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalFilterName_1 varchar(255) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalFilterName_2' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalFilterName_2 varchar(255) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalFilterName_3' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalFilterName_3 varchar(255) Null"
//END---Modify by Scofield on 2010-03-16

//BEGIN---Modify by Scofield on 2010-03-17
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='CalArrangeMode' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD CalArrangeMode int Null"
//END---Modify by Scofield on 2010-03-17



of_execute_sqls("of_ver95_release_table2")

Return 1

end function

public function integer of_ver95_release_view1 ();//Added by Scofield on 2009-08-12
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_basic_info') ~r~n" + &
" drop view v_ctx_basic_info"

//Added by Scofield on 2009-08-12
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW  v_ctx_basic_info AS~r~n" + &
"SELECT ~r~n" + &
"       app_facility.facility_name AS Company_Name,~r~n" + &
"       app_facility.street AS Company_street_1,~r~n" + &
"       app_facility.street_2 AS Company_street_2,~r~n" + &
"       app_facility.city AS Company_city,~r~n" + &
"       app_facility.state AS Company_state,~r~n" + &
"       app_facility.zip AS Company_zip,~r~n" + &
"       app_facility.country AS Company_country,~r~n" + &
"       app_facility.phone AS Company_phone,~r~n" + &
"       app_facility.fax AS Company_fax,~r~n" + &
"       app_facility.web_address AS Company_web_address,~r~n" + &
"       app_facility.contact_type2 AS Company_contact_type2,~r~n" + &
"       app_facility.corp_office_flag AS Company_corp_office_flag,~r~n" + &
"       app_facility.corp_office_link AS Company_corp_office_link,~r~n" + &
"       code_lookup.code AS Contract_Category_code,~r~n" + &
"       code_lookup.description AS Contract_Category_description,~r~n" + &
"       code_lookup_1.code AS Contract_Status_code,~r~n" + &
"       code_lookup_2.code AS contract_type_code,~r~n" + &
"       code_lookup_2.description AS contract_type_Description,~r~n" + &
"       code_lookup_3.code AS term_reason_code,~r~n" + &
"       code_lookup_3.description AS term_Reason_Desciption,~r~n" + &
"       code_lookup_4.description AS product_type_desc,~r~n" + &
"       code_lookup_4.code AS product_type_code,~r~n" + &
"       code_lookup_5.code AS product_code,~r~n" + &
"       code_lookup_5.description AS product_description,~r~n" + &
"       ctx_basic_info.ctx_id,~r~n" + &
"       ctx_basic_info.category,~r~n" + &
"       ctx_basic_info.status,~r~n" + &
"       ctx_basic_info.facility_id,~r~n" + &
"       ctx_basic_info.contract_type,~r~n" + &
"       ctx_basic_info.product_type,~r~n" + &
"       ctx_basic_info.product_name,~r~n" + &
"       ctx_basic_info.reimbursment_menth,~r~n" + &
"       ctx_basic_info.file_location,~r~n" + &
"       ctx_basic_info.effective_date,~r~n" + &
"       ctx_basic_info.expriation_date,~r~n" + &
"       ctx_basic_info.review_date,~r~n" + &
"       ctx_basic_info.review_by,~r~n" + &
"       ctx_basic_info.term_date,~r~n" + &
"       ctx_basic_info.term_reason,~r~n" + &
"       ctx_basic_info.last_revis_date,~r~n" + &
"       ctx_basic_info.other_date_1,~r~n" + &
"       ctx_basic_info.other_date_2,~r~n" + &
"       ctx_basic_info.oc_signed_by,~r~n" + &
"       ctx_basic_info.oc_title,~r~n" + &
"       ctx_basic_info.oc_department,~r~n" + &
"       ctx_basic_info.oc_legal_rep,~r~n" + &
"       ctx_basic_info.cc_signed_by,~r~n" + &
"       ctx_basic_info.cc_title,~r~n" + &
"       ctx_basic_info.cc_department,~r~n" + &
"       ctx_basic_info.cc_legal_rep,~r~n" + &
"       ctx_basic_info.keyword,~r~n" + &
"       ctx_basic_info.dvision,~r~n" + &
"       ctx_basic_info.custom_1,~r~n" + &
"       ctx_basic_info.custom_2,~r~n" + &
"       ctx_basic_info.custom_3,~r~n" + &
"       ctx_basic_info.custom_4,~r~n" + &
"       ctx_basic_info.custom_5,~r~n" + &
"       ctx_basic_info.custom_6,~r~n" + &
"       ctx_basic_info.custom_7,~r~n" + &
"       ctx_basic_info.custom_8,~r~n" + &
"       ctx_basic_info.custom_9,~r~n" + &
"       ctx_basic_info.custom_10,~r~n" + &
"       ctx_basic_info.group_multi_loc_id,~r~n" + &
"       ctx_basic_info.revision_reason,~r~n" + &
"       ctx_basic_info.group_id,~r~n" + &
"       ctx_basic_info.record_id,~r~n" + &
"       ctx_basic_info.custom_11,~r~n" + &
"       ctx_basic_info.custom_12,~r~n" + &
"       ctx_basic_info.custom_13,~r~n" + &
"       ctx_basic_info.custom_14,~r~n" + &
"       ctx_basic_info.custom_15,~r~n" + &
"       ctx_basic_info.custom_16,~r~n" + &
"       ctx_basic_info.custom_17,~r~n" + &
"       ctx_basic_info.custom_18,~r~n" + &
"       ctx_basic_info.custom_19,~r~n" + &
"       ctx_basic_info.custom_20,~r~n" + &
"       ctx_basic_info.custom_21,~r~n" + &
"       ctx_basic_info.custom_22,~r~n" + &
"       ctx_basic_info.custom_date1,~r~n" + &
"       ctx_basic_info.custom_date2,~r~n" + &
"       ctx_basic_info.custom_date3,~r~n" + &
"       ctx_basic_info.custom_date4,~r~n" + &
"       ctx_basic_info.custom_date5,~r~n" + &
"       ctx_basic_info.custom_date6,~r~n" + &
"       ctx_basic_info.custom_date7,~r~n" + &
"       ctx_basic_info.custom_date8,~r~n" + &
"       ctx_basic_info.custom_date9,~r~n" + &
"       ctx_basic_info.custom_date10,~r~n" + &
"       ctx_basic_info.custom_date16,~r~n" + &
"       ctx_basic_info.custom_date17,~r~n" + &
"       ctx_basic_info.custom_n1,~r~n" + &
"       ctx_basic_info.custom_n2,~r~n" + &
"       ctx_basic_info.custom_n3,~r~n" + &
"       ctx_basic_info.custom_n4,~r~n" + &
"       ctx_basic_info.custom_n5,~r~n" + &
"       ctx_basic_info.custom_n6,~r~n" + &
"       ctx_basic_info.custom_n7,~r~n" + &
"       ctx_basic_info.custom_n8,~r~n" + &
"       ctx_basic_info.custom_n9,~r~n" + &
"       ctx_basic_info.custom_n10,~r~n" + &
"       ctx_basic_info.custom_n11,~r~n" + &
"       ctx_basic_info.custom_n12,~r~n" + &
"       ctx_basic_info.custom_n13,~r~n" + &
"       ctx_basic_info.custom_n14,~r~n" + &
"       ctx_basic_info.custom_n15,~r~n" + &
"       ctx_basic_info.custom_n16,~r~n" + &
"       ctx_basic_info.custom_n17,~r~n" + &
"       ctx_basic_info.custom_n18,~r~n" + &
"       ctx_basic_info.custom_n19,~r~n" + &
"       ctx_basic_info.custom_n20,~r~n" + &
"       ctx_basic_info.custom_n21,~r~n" + &
"       ctx_basic_info.custom_n22,~r~n" + &
"       ctx_basic_info.custom_n23,~r~n" + &
"       ctx_basic_info.custom_n24,~r~n" + &
"       ctx_basic_info.custom_n25,~r~n" + &
"       ctx_basic_info.custom_n26,~r~n" + &
"       ctx_basic_info.custom_n27,~r~n" + &
"       ctx_basic_info.version_number,~r~n" + &
"       ctx_basic_info.version_date,~r~n" + &
"       ctx_basic_info.notes,~r~n" + &
"       ctx_basic_info.app_facility,~r~n" + &
"       ctx_basic_info.master_contract_id AS master_ctx_id,~r~n" + &
"       ctx_basic_info.master_contract_name,~r~n" + &
"       code_lookup_6.code AS dvision_code,~r~n" + &
"       code_lookup_6.description AS dvision_description~r~n" + &
"  FROM (((((((ctx_basic_info LEFT OUTER JOIN code_lookup ON ctx_basic_info.category = code_lookup.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_basic_info.status = code_lookup_1.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_2 ON ctx_basic_info.contract_type = code_lookup_2.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_3 ON ctx_basic_info.term_reason = code_lookup_3.lookup_code)~r~n" + &
"       INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id)~r~n" + &
"       INNER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_6 ON ctx_basic_info.dvision = code_lookup_6.lookup_code~r~n" + &
"	WHERE ctx_basic_info.is_template = 0 ~r~n" //+ &
//"ORDER BY ctx_basic_info.ctx_id"

//Added By Ken.Guo 2010-03-10. Add default_email column
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='V_ctx_contract_contacts' and type = 'V')  " + &
"  drop view V_ctx_contract_contacts "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  V_ctx_contract_contacts " + &
"AS SELECT     contact_id,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS contact_phone,  " + &
"          (SELECT     TOP 1 contact_email  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code   " + &
"                                         FROM          code_lookup AS code_lookup_2  " + &
"                                        WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Email')  )) ) AS contact_email,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup AS code_lookup_1  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Fax') )) ) AS contact_Fax,   " + &
"          (SELECT     TOP 1 ext  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"           WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id)  AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS ext,   " + &
"            association, notes, owner, access, ctx_id, ic_area,default_email  " + &
"FROM         CTX_CONTRACT_CONTACTS  "

//Added by jervis on 2009-08-25
//Add money_value field. 
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_requirement') ~r~n" + &
" drop view v_ctx_requirement"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create view v_ctx_requirement as~r~n" + &
"select ~r~n" + &
"       ctx_req_profile_hdr_1.ctx_id,~r~n" + &
"       ctx_req_profile.rqmnt_name,~r~n" + &
"       ctx_req_profile.rqmnt_description,~r~n" + &
"       ctx_rqmnt_category.category_name,~r~n" + &
"       ctx_req_tmplt_element.element_name,~r~n" + &
"       datavalue = (case ctx_req_tmplt_element.value_type~r~n" + &
"                         when 1 then convert(varchar,ctx_elements.date_value)~r~n" + &
"                         when 2 then ctx_elements.field_value~r~n" + &
"                         when 3 then ctx_elements.char_value~r~n" + &
"                         when 4 then convert(varchar,ctx_elements.integer_value)~r~n" + &
"                         when 6 then convert(varchar,ctx_elements.money_value)~r~n" + &
"                         when 5 then ctx_elements.field_value end),~r~n" + &
"       ctx_elements.clause~r~n" + &
"  from ctx_req_profile~r~n" + &
"       inner join ctx_req_profile_hdr as ctx_req_profile_hdr_1 on ctx_req_profile.ctx_req_profile_id = ctx_req_profile_hdr_1.ctx_req_profile_id~r~n" + &
"       inner join ctx_rqmnt_category on ctx_rqmnt_category.ctx_req_profile_id = ctx_req_profile_hdr_1.ctx_req_profile_id~r~n" + &
"       inner join ctx_req_tmplt_element on ctx_rqmnt_category.ctx_req_profile_id = ctx_req_tmplt_element.ctx_req_profile_id and ctx_rqmnt_category.ctx_rqmnt_category_id = ctx_req_tmplt_element.ctx_rqmnt_category_id~r~n" + &
"       inner join ctx_elements on ctx_elements.ctx_req_tmplt_element_id = ctx_req_tmplt_element.ctx_req_tmplt_element_id and ctx_req_profile_hdr_1.ctx_req_profile_hdr_id = ctx_elements.ctx_req_profile_hdr_id~r~n" //+ &
//"order by ctx_req_profile_hdr_1.ctx_id"

//Added by jervis 08.28.2009
//Modify Contract_type to Contact_type
//Delete V_ctx_contract_contacts.association
//Add default_email column By Ken.Guo 2010-03-10
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_contacts_external' and type = 'V')  " + &
//"  drop view v_ctx_contacts_external "
//
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"CREATE VIEW  v_ctx_contacts_external " + &
//"as SELECT     CTX_BASIC_INFO.ctx_id, app_facility.facility_name, code_lookup.code AS contact_type_code,   " + &
//"                      code_lookup.description AS contact_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name,   " + &
//"                      CTX_CONTACTS.middle_name, code_lookup_4.description AS contact_title, code_lookup_1.code AS contract_department_code,   " + &
//"                      code_lookup_1.description AS contract_department_des, app_facility.street, app_facility.street_2, app_facility.street_3,   " + &
//"                      app_facility.city, app_facility.zip, app_facility.state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2,   " + &
//"                      CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6,   " + &
//"                      CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10,   " + &
//"                      V_ctx_contract_contacts.access, V_ctx_contract_contacts.owner, V_ctx_contract_contacts.notes,    " + &
//"                      V_ctx_contract_contacts.ext, V_ctx_contract_contacts.contact_Fax, V_ctx_contract_contacts.contact_email,   " + &
//"                      V_ctx_contract_contacts.contact_phone AS phone, NULL AS Phone_Type_code, NULL AS Phone_type_Description,   " + &
//"                      V_ctx_contract_contacts.contact_id,  " + &
//"                      V_ctx_contract_contacts.default_email as default_to  " + &
//"FROM         CTX_CONTACTS INNER JOIN  " + &
//"                      V_ctx_contract_contacts ON CTX_CONTACTS.contact_id = V_ctx_contract_contacts.contact_id INNER JOIN  " + &
//"                      CTX_BASIC_INFO INNER JOIN  " + &
//"                      app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ON   " + &
//"                      V_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id LEFT OUTER JOIN  " + &
// "                     code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code LEFT OUTER JOIN  " + &
// "                     code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code LEFT OUTER JOIN  " + &
// "                     code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code  "  + &
//"where V_ctx_contract_contacts.ic_area='e'  " //+ &
////"ORDER BY CTX_BASIC_INFO.ctx_id  " 

//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_contacts_internal' and type = 'V')  " + &
//"  drop view v_ctx_contacts_internal "
//
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"CREATE VIEW  v_ctx_contacts_internal " + &
//"as SELECT     CTX_BASIC_INFO.ctx_id, app_facility.facility_name, code_lookup.code AS contact_type_code,  " + &
//"                      code_lookup.description AS contact_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name,  " + &
//"                      CTX_CONTACTS.middle_name, code_lookup_4.description AS contact_title, code_lookup_1.code AS contract_department_code,  " + &
//"                      code_lookup_1.description AS contract_department_des, app_facility.street, app_facility.street_2, app_facility.street_3,  " + &
//"                      app_facility.city, app_facility.zip, app_facility.state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2,  " + &
//"                      CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6,  " + &
//"                      CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10,  " + &
//"                      V_ctx_contract_contacts.access, V_ctx_contract_contacts.owner, V_ctx_contract_contacts.notes,   " + &
//"                      V_ctx_contract_contacts.ext, V_ctx_contract_contacts.contact_Fax, V_ctx_contract_contacts.contact_email,  " + &
//"                      V_ctx_contract_contacts.contact_phone AS phone, NULL AS Phone_Type_code, NULL AS Phone_type_Description,  " + &
//"                      V_ctx_contract_contacts.contact_id, " + &
//"                      V_ctx_contract_contacts.default_email as default_to  " + &
//"FROM         CTX_CONTACTS INNER JOIN " + &
//"                      V_ctx_contract_contacts ON CTX_CONTACTS.contact_id = V_ctx_contract_contacts.contact_id INNER JOIN " + &
//"                      CTX_BASIC_INFO INNER JOIN " + &
//"                      app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ON  " + &
//"                      V_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id LEFT OUTER JOIN " + &
//"                      code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code LEFT OUTER JOIN " + &
//"                      code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code LEFT OUTER JOIN " + &
//"                      code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code " + &
//"where V_ctx_contract_contacts.ic_area='i'  " //+ &
////"ORDER BY CTX_BASIC_INFO.ctx_id " 

//BEGIN---Modify by Scofield on 2009-11-03
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists(SELECT TOP 1 1 FROM sysobjects WHERE name='v_ctx_Document' AND type = 'V')~r~n" + &
"   DROP VIEW v_ctx_document"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_document AS~r~n" + &
"SELECT ~r~n" + &
"       ctx_am_document.Doc_id,~r~n" + &
"       ctx_am_document.ctx_id,~r~n" + &
"       ctx_am_document.doc_name,~r~n" + &
"       ctx_am_document.Revision,~r~n" + &
"       ctx_am_document.doc_type,~r~n" + &
"       ctx_am_document.doc_ext,~r~n" + &
"       code_lookup_1.code AS category,~r~n" + &
"       ctx_am_document.Create_by,~r~n" + &
"       ctx_am_document.Create_date,~r~n" + &
"       code_lookup.code AS Status,~r~n" + &
"       ctx_am_document.Status_by,~r~n" + &
"       ctx_am_document.Status_date,~r~n" + &
"       ctx_am_document.Doc_from_name,~r~n" + &
"       ctx_am_document.checkout_by,~r~n" + &
"       ctx_am_document.checkout_date,~r~n" + &
"       CASE WHEN checkout_status=1 THEN 'Check out' ELSE 'Normal' END AS checkout_status,~r~n" + &
"       (SELECT COUNT(*) AS Expr1 FROM ctx_am_doc_audit WHERE (Doc_id = ctx_am_document.Doc_id)) AS audit_count~r~n" + &
"  FROM ctx_am_document INNER JOIN code_lookup ON ctx_am_document.Status = code_lookup.lookup_code~r~n" + &
"                       INNER JOIN code_lookup AS code_lookup_1 ON ctx_am_document.category = code_lookup_1.lookup_code~r~n" //+ &
//"ORDER BY ctx_am_document.ctx_id"
//END---Modify by Scofield on 2009-11-03


//Add by jervis -- 12.11.2009
//Drop ctx_notification_users info
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_basic_info_alarms' and type = 'V')  " + &
"  drop view v_ctx_basic_info_alarms "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  v_ctx_basic_info_alarms " + &
"as SELECT  " + &
"	ctx_basic_info.ctx_id,  " + &
"	app_facility.facility_name,  " + &
"	ctx_notification.alm_enabled,  " + &
"	ctx_notification.alm_notification_days,  " + &
"	ctx_notification.alm_last_notification_sent,  " + &
"	ctx_notification.alm_post_notification_days,  " + &
"	ctx_notification.alm_total_tries,  " + &
"	ctx_notification.alm_action_item_posted,  " + &
"	ctx_notification.alm_total_tries_counter,  " + &
"	ctx_notification.alm_frequency,  " + &
"	ctx_notification.create_action_item,  " + &
"	ctx_notification.alm_mailto  " + &
"FROM ctx_basic_info  " + &
"LEFT OUTER JOIN ctx_notification ON ctx_basic_info.ctx_id = ctx_notification.ctx_id  " + &
"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id  " + &
"GROUP BY ctx_basic_info.ctx_id,  " + &
"	app_facility.facility_name,  " + &
"	ctx_notification.alm_enabled,  " + &
"	ctx_notification.alm_notification_days,  " + &
"	ctx_notification.alm_last_notification_sent,  " + &
"	ctx_notification.alm_post_notification_days,  " + &
"	ctx_notification.alm_total_tries,  " + &
"	ctx_notification.alm_action_item_posted,  " + &
"	ctx_notification.alm_total_tries_counter,  " + &
"	ctx_notification.alm_frequency,  " + &
"	ctx_notification.create_action_item,  " + &
"	ctx_notification.alm_mailto  " //+ &
//"ORDER BY ctx_basic_info.ctx_id "

//Added By Ken.Guo 2010-02-05. Added alm_action_title from Jim
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_basic_info_alarms' and type = 'V')  " + &
"  drop view v_ctx_basic_info_alarms "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  v_ctx_basic_info_alarms as ~r~n" + &
"SELECT  ctx_basic_info.ctx_id,   app_facility.facility_name,   ~r~n" + &
"ctx_notification.alm_enabled,   ctx_notification.alm_notification_days,   ~r~n" + &
"ctx_notification.alm_last_notification_sent,   ctx_notification.alm_post_notification_days,   ~r~n" + &
"ctx_notification.alm_total_tries,   ctx_notification.alm_action_item_posted,  ~r~n" + &
" ctx_notification.alm_total_tries_counter,   ctx_notification.alm_frequency,   ~r~n" + &
"ctx_notification.create_action_item,   ctx_notification.alm_mailto,~r~n" + &
"ctx_notification.alm_action_title~r~n" + &
"FROM ctx_basic_info  LEFT OUTER JOIN ctx_notification ~r~n" + &
"ON ctx_basic_info.ctx_id = ctx_notification.ctx_id  ~r~n" + &
"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id  ~r~n" + &
"GROUP BY ctx_basic_info.ctx_id,   app_facility.facility_name,   ~r~n" + &
"ctx_notification.alm_enabled,   ctx_notification.alm_notification_days,   ~r~n" + &
"ctx_notification.alm_last_notification_sent,   ~r~n" + &
"ctx_notification.alm_post_notification_days,   ctx_notification.alm_total_tries,  ~r~n" + &
"ctx_notification.alm_action_item_posted,   ctx_notification.alm_total_tries_counter,  ~r~n" + &
"ctx_notification.alm_frequency,   ctx_notification.create_action_item,   ~r~n" + &
"ctx_notification.alm_mailto,  ctx_notification.alm_action_title~r~n" //+ &
//"ORDER BY ctx_basic_info.ctx_id"



of_execute_sqls("of_ver95_release_view1")

Return 1

end function

public function integer of_ver95_release_storeprocedure1 ();Return 1

//Added By Ken.Guo 2009-08-25.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists (SELECT name FROM sysobjects WHERE name = 'sp_contract_search' AND type = 'P') " + &
"    DROP PROCEDURE sp_contract_search"

//Added By Ken.Guo 2009-12-21.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"CREATE  PROCEDURE sp_contract_search(  @user_d VARCHAR(10)   )~r~n" + &
" AS    ~r~n" + &
"BEGIN      ~r~n" + &
"SELECT DISTINCT ~r~n" + &
"	ctx_basic_info.app_facility,    ~r~n" + &
"	ctx_products.product_id product_code,     ~r~n" + &
"	code_lookup.code product_name,       ~r~n" + &
"	ctx_basic_info.effective_date,      ~r~n" + &
"	ctx_basic_info.expriation_date,       ~r~n" + &
"	ctx_basic_info.status,     ~r~n" + &
"	ctx_basic_info.group_multi_loc_id,       ~r~n" + &
"	ctx_basic_info.ctx_id,~r~n" + &
" 	ctx_basic_info.master_contract_id,                             ~r~n" + &
"	master_cnt = (SELECT Count(ctx_basic_info1.ctx_id) ~r~n" + &
"			FROM ctx_basic_info ctx_basic_info1 ~r~n" + &
"			WHERE ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id and ctx_basic_info.is_template = 0 ),  ~r~n" + &
"	ctx_basic_info.category,        ~r~n" + &
"	ctx_basic_info.facility_id,     ~r~n" + &
"	ctx_basic_info.contract_type,       ~r~n" + &
"	code_lookup1.code product_type, ~r~n" + &
"	ctx_basic_info.reimbursment_menth,       ~r~n" + &
"	ctx_basic_info.file_location,    ~r~n" + &
"	ctx_basic_info.review_date,       ~r~n" + &
"	ctx_basic_info.review_by,     ~r~n" + &
"	ctx_basic_info.term_date,       ~r~n" + &
"	ctx_basic_info.term_reason,     ~r~n" + &
"	ctx_basic_info.last_revis_date,       ~r~n" + &
"	ctx_basic_info.other_date_1,       ~r~n" + &
"	ctx_basic_info.other_date_2,     ~r~n" + &
"	ctx_basic_info.oc_signed_by,       ~r~n" + &
"	ctx_basic_info.oc_title,      ~r~n" + &
"	ctx_basic_info.oc_department,       ~r~n" + &
"	ctx_basic_info.oc_legal_rep,       ~r~n" + &
"	ctx_basic_info.cc_signed_by,     ~r~n" + &
"	ctx_basic_info.cc_title,       ~r~n" + &
"	ctx_basic_info.cc_department,       ~r~n" + &
"	ctx_basic_info.cc_legal_rep,     ~r~n" + &
"	ctx_basic_info.notes,       ~r~n" + &
"	ctx_basic_info.keyword,       ~r~n" + &
"	ctx_basic_info.dvision,   ~r~n" + &
"	ctx_basic_info.custom_1,       ~r~n" + &
"	ctx_basic_info.custom_2,       ~r~n" + &
"	ctx_basic_info.custom_3,       ~r~n" + &
"	ctx_basic_info.custom_4,       ~r~n" + &
"	ctx_basic_info.custom_5,     ~r~n" + &
"	ctx_basic_info.custom_6,       ~r~n" + &
"	ctx_basic_info.custom_7,       ~r~n" + &
"	ctx_basic_info.custom_8, ~r~n" + &
"	ctx_basic_info.custom_9,       ~r~n" + &
"	ctx_basic_info.custom_10,    ~r~n" + &
"	ctx_basic_info.group_id,~r~n" + &
"	ctx_basic_info.revision_reason,       ~r~n" + &
"	ctx_basic_info.record_id ,   ~r~n" + &
"	owner = upper((SELECT top 1 ctx_contacts.user_d       ~r~n" + &
"			FROM ctx_contacts,ctx_contract_contacts       ~r~n" + &
"			WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) ~r~n" + &
"			AND (ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
"			  AND ( ctx_contract_contacts.owner = 'Y' ) ~r~n" + &
"			  AND ( ctx_contract_contacts.ic_area = 'I' ) )),   ~r~n" + &
"	contracted_entity = (SELECT top 1 group_multi_loc.rec_id              ~r~n" + &
"	  			FROM ctx_loc,                  group_multi_loc              ~r~n" + &
"				WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id) ~r~n" + &
"				AND ( ctx_loc.ctx_id = ctx_basic_info.ctx_id) ~r~n" + &
"				AND ctx_loc.loc_id = 0),    ~r~n" + &
"	app_facility.facility_name facility_name,   ~r~n" + &
"	ctx_basic_info.custom_date1,      ~r~n" + &
"	ctx_basic_info.custom_date2,      ~r~n" + &
"	ctx_basic_info.custom_date3,      ~r~n" + &
"	ctx_basic_info.custom_date4,  ~r~n" + &
"	ctx_basic_info.custom_date5,      ~r~n" + &
"	ctx_basic_info.inserted_by_user,    ~r~n" + &
"	ctx_basic_info.inserted_at_date_time,      ~r~n" + &
"	ctx_basic_info.updated_by_user,   ~r~n" + &
"	ctx_basic_info.~r~n" + &
"	updated_at_date_time,      ~r~n" + &
"	ctx_basic_info.custom_11,      ~r~n" + &
"	ctx_basic_info.custom_12,   ~r~n" + &
"	ctx_basic_info.custom_13,      ~r~n" + &
"	ctx_basic_info.custom_14,      ~r~n" + &
"	ctx_basic_info.custom_15,  ~r~n" + &
"	ctx_basic_info.custom_16,      ~r~n" + &
"	ctx_basic_info.custom_17,      ~r~n" + &
"	ctx_basic_info.custom_18,      ~r~n" + &
"	ctx_basic_info.custom_19,      ~r~n" + &
"	ctx_basic_info.custom_20,     ~r~n" + &
"	ctx_basic_info.custom_date6,      ~r~n" + &
"	ctx_basic_info.custom_date7,      ~r~n" + &
"	ctx_basic_info.custom_date8,  ~r~n" + &
"	ctx_basic_info.custom_date9,      ~r~n" + &
"	ctx_basic_info.custom_date10,      ~r~n" + &
"	ctx_basic_info.custom_date11,      ~r~n" + &
"	ctx_basic_info.custom_date12,      ~r~n" + &
"	ctx_basic_info.custom_date13,  ~r~n" + &
"	ctx_basic_info.custom_date14,      ~r~n" + &
"	ctx_basic_info.custom_date15,      ~r~n" + &
"	ctx_basic_info.custom_n1, ~r~n" + &
"	ctx_basic_info.custom_n2,      ~r~n" + &
"	ctx_basic_info.custom_n3,      ~r~n" + &
"	ctx_basic_info.custom_n4,      ~r~n" + &
"	ctx_basic_info.custom_n5,      ~r~n" + &
"	ctx_basic_info.custom_n6,  ~r~n" + &
"	ctx_basic_info.custom_n7,      ~r~n" + &
"	ctx_basic_info.custom_n8,      ~r~n" + &
"	ctx_basic_info.custom_n9,    ~r~n" + &
"	ctx_basic_info.custom_n10,      ~r~n" + &
"	ctx_basic_info.custom_n11,      ~r~n" + &
"	ctx_basic_info.custom_n12,      ~r~n" + &
"	ctx_basic_info.custom_n13,      ~r~n" + &
"	ctx_basic_info.custom_n14,      ~r~n" + &
"	ctx_basic_info.custom_n15,      ~r~n" + &
"	ctx_basic_info.custom_n16,      ~r~n" + &
"	ctx_basic_info.custom_n17,      ~r~n" + &
"	ctx_basic_info.custom_n18,      ~r~n" + &
"	ctx_basic_info.custom_n19,      ~r~n" + &
"	ctx_basic_info.custom_n20,      ~r~n" + &
"	ctx_basic_info.custom_n21,      ~r~n" + &
"	ctx_basic_info.custom_n22,      ~r~n" + &
"	ctx_basic_info.custom_n23,      ~r~n" + &
"	ctx_basic_info.custom_n24,      ~r~n" + &
"	ctx_basic_info.custom_n25,      ~r~n" + &
"	ctx_basic_info.version_number,      ~r~n" + &
"	ctx_basic_info.version_date,      ~r~n" + &
"	ctx_basic_info.master_contract_name ,~r~n" + &
"	access = AA.access   ,~r~n" + &
"	code_lookup2.code status_name,~r~n" + &
"	code_lookup3.code category_name,~r~n" + &
"	code_lookup4.code contract_type_name,~r~n" + &
"	code_lookup5.code dvision_name ~r~n" + &
"FROM  ctx_basic_info  ~r~n" + &
"LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id  ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code  ~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code~r~n" + &
"~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup2 ON ctx_basic_info.status = code_lookup2.lookup_code~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup3 ON ctx_basic_info.category = code_lookup3.lookup_code~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup4 ON ctx_basic_info.contract_type = code_lookup4.lookup_code~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup5 ON ctx_basic_info.dvision = code_lookup5.lookup_code~r~n" + &
"~r~n" + &
"LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id, ~r~n" + &
"(~r~n" + &
"SELECT DISTINCT ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END)~r~n" + &
"FROM ctx_contract_contacts Left Outer Join~r~n" + &
"(~r~n" + &
"Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d ~r~n" + &
"From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1~r~n" + &
"Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = @user_d~r~n" + &
"Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d~r~n" + &
"Having Count(ctx_contract_contacts1.ctx_id) > 1~r~n" + &
") ccc~r~n" + &
"On ctx_contract_contacts.ctx_id = ccc.ctx_id~r~n" + &
",ctx_contacts~r~n" + &
"WHERE ctx_contacts.user_d = @user_d~r~n" + &
"	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' )~r~n" + &
"	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id ~r~n" + &
"	AND ( ctx_contract_contacts.access IN ('F','R') ~r~n" + &
"	OR ctx_contract_contacts.owner = 'Y' )~r~n" + &
"	AND ctx_contract_contacts.ic_area = 'I'~r~n" + &
"~r~n" + &
"UNION ~r~n" + &
"~r~n" + &
"SELECT DISTINCT ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access~r~n" + &
"FROM ctx_group_access Left Outer Join ~r~n" + &
"(~r~n" + &
"Select ctx_group_access1.ctx_id, security_group_users1.user_id ~r~n" + &
"From ctx_group_access ctx_group_access1,security_group_users security_group_users1~r~n" + &
"Where ctx_group_access1.group_id = security_group_users1.group_id And security_group_users1.user_id = @user_d~r~n" + &
"Group by ctx_group_access1.ctx_id, security_group_users1.user_id~r~n" + &
"Having count(ctx_group_access1.ctx_id) > 1 ~r~n" + &
") cga On ctx_group_access.ctx_id = cga.ctx_id ,~r~n" + &
"security_group_users,~r~n" + &
"icred_settings~r~n" + &
"WHERE security_group_users.user_id = @user_d~r~n" + &
"	AND (cga.ctx_id is null or ctx_group_access.access = 'F')~r~n" + &
"	AND icred_settings.group_access = 1~r~n" + &
"	AND ctx_group_access.group_id = security_group_users.group_id~r~n" + &
"	AND ctx_group_access.access in ('F','R')~r~n" + &
"	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
"			AND ( ctx_contacts.user_d = security_group_users.user_id )~r~n" + &
"			AND ( ctx_contract_contacts.ic_area = 'I' )~r~n" + &
"			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id )~r~n" + &
"			)~r~n" + &
"~r~n" + &
"UNION~r~n" + &
"~r~n" + &
"SELECT DISTINCT ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END)~r~n" + &
"FROM ctx_acp_contract_management_right, security_users, ctx_basic_info~r~n" + &
"WHERE security_users.user_id = @user_d~r~n" + &
"	AND ctx_acp_contract_management_right.types = 1~r~n" + &
"	AND ctx_acp_contract_management_right.role_id = security_users.role_id~r~n" + &
"	AND ctx_acp_contract_management_right.category = ctx_basic_info.category~r~n" + &
"  And ctx_basic_info.is_template = 0 ~r~n" + &
"	AND ctx_acp_contract_management_right.rights In ('11','12')~r~n" + &
"	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
"			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I') ~r~n" + &
"			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
"			UNION~r~n" + &
"			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings~r~n" + &
"			WHERE icred_settings.group_access = 1~r~n" + &
"			AND (ctx_group_access.group_id = security_group_users.group_id )~r~n" + &
"			AND ( security_group_users.user_id = security_users.user_id )	~r~n" + &
"			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id )~r~n" + &
"			)~r~n" + &
") AA ~r~n" + &
"WHERE ctx_basic_info.ctx_id = AA.ctx_id and ctx_basic_info.is_template = 0 ~r~n" + &
"ORDER BY ctx_basic_info.master_contract_id Asc, ctx_basic_info.ctx_id  Asc    ~r~n" + &
"END"

of_execute_sqls("of_ver95_release_storeprocedure1")

Return 1
end function

public function integer of_ver100_release_table1 ();//Added By Ken.Guo 2010-03-26.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='is_moved' and t.table_name='em_sent_items' ) " + &
"ALTER table em_sent_items add is_moved integer null "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_server' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add pop3_server varchar(100)  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_port' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add pop3_port integer"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_sort_rule' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add pop3_sort_rule char(1) null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'em_mail_items' )~r~n" + &
"	Create Table em_mail_items ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		folder_id integer not null,~r~n" + &
"		sub_folder_id numeric(10,0) null,~r~n" + &
"		mail_msg_id varchar(100) null,~r~n" + &
"		mail_date datetime null,~r~n" + &
"		mail_subject varchar(200) null,~r~n" + &
"		mail_importance integer null,~r~n" + &
"		mail_from varchar(200) null,~r~n" + &
"		mail_to varchar(200) null,~r~n" + &
"		mail_cc varchar(200) null,~r~n" + &
"		mail_rfc822 image null,~r~n" + &
"		mail_plaintext text null,~r~n" + &
"		mail_attach_name varchar(500) null,~r~n" + &
"		mail_ctx_id numeric(10,0) null,~r~n" + &
"		mail_doc_id numeric(10,0) null,	~r~n" + &
"		mail_action_item_id numeric(10,0) null,~r~n" + &
"		mail_fromclx integer null,~r~n" + &
"		mail_save_format char(1) null,~r~n" + &
"		last_modify_date datetime null,~r~n" + &
"		read_status integer null,~r~n" + &
"		locked integer null,~r~n" + &
"		deleted integer null,~r~n" + &
"		flag integer null,	~r~n" + &
"		notes varchar(2000) null,	~r~n" + &
"		mail_type integer null,	~r~n" + &
"		mail_format integer null,	 ~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"


//Added By Ken.Guo 2010-04-07.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table em_mail_items modify mail_to varchar(1000)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table em_mail_items modify mail_from varchar(1000)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table em_mail_items modify mail_cc varchar(1000)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table em_mail_items modify mail_attach_name varchar(1000)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='mail_save_format' and t.table_name='em_mail_items' and c.width<>10 ) " + &
"alter table em_mail_items modify mail_save_format varchar(10)"

//Added By Ken.Guo 2010-03-26.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'em_user_msg_id' )~r~n" + &
"	Create Table em_user_msg_id ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		mail_msg_id varchar(100) not null,~r~n" + &
"		mail_date datetime null,~r~n" + &
"		mail_downloaded integer null,~r~n" + &
"		notes varchar(200) null,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='email_start_date' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add email_start_date datetime null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='email_tag' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add email_tag varchar(100) null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'em_user_config' )~r~n" + &
"	Create Table em_user_config ~r~n" + &
"	(~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		email_receive_start_date datetime null,~r~n" + &
"		email_receive_by_date integer null,~r~n" + &
"		email_receive_by_clx integer null,~r~n" + &
"		email_receive_by_subject integer null,~r~n" + &
"		email_receive_all integer null,~r~n" + &
"		email_log integer null,~r~n" + &
"		email_delete_from_server integer null,~r~n" + &
"		email_timer integer null,~r~n" + &
"		Primary Key(user_id)~r~n" + &
"	)"

//Added By Ken.Guo 2010-04-28.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='email_rule_type' and t.table_name='em_user_config' ) " + &
"ALTER table em_user_config add email_rule_type integer null  "

//Jervis 03.30.2010
//Add Subject field in Alarm Message
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_subject' and t.table_name='ctx_notification' ) " + &
"alter table ctx_notification add alm_subject varchar(255) null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_subject' and t.table_name='ctx_ai_notification' ) " + &
"alter table ctx_ai_notification add alm_subject varchar(255) null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_subject' and t.table_name='ctx_am_ai_notification' ) " + &
"alter table ctx_am_ai_notification add alm_subject varchar(255) null"

//BEGIN---Modify by Scofield on 2010-03-31
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"ALTER TABLE ctx_contract_contacts modify association varchar(100) Null"
//END---Modify by Scofield on 2010-03-31

//Added By Ken.Guo 2010-04-12.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'em_mail_item_attachments' )~r~n" + &
"	Create Table em_mail_item_attachments ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		mail_item_id numeric(10,0) not null,~r~n" + &
"		attachment_name varchar(200) not null,~r~n" + &
"		image_file image null,~r~n" + &
"		type char(1) null,~r~n" + &
"		CONSTRAINT FK_mail_items FOREIGN KEY (mail_item_id)~r~n" + &
"		   REFERENCES em_mail_items (id) on Delete CASCADE,~r~n" + &
"		Primary Key(id)~r~n" + &
"	)"

//Added By Ken.Guo 2010-04-14.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='last_modify_date' and t.table_name='em_mail_item_attachments' ) " + &
"ALTER table em_mail_item_attachments add last_modify_date datetime null  ~r~n" + &
""

//BEGIN---Modify by Scofield on 2010-04-14
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='left_bracket' and t.table_name='conv_view_where' ) " + &
"ALTER TABLE conv_view_where ADD left_bracket varchar(5) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='right_bracket' and t.table_name='conv_view_where' ) " + &
"ALTER TABLE conv_view_where ADD right_bracket varchar(5) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='logical' and t.table_name='conv_view_where' ) " + &
"ALTER TABLE conv_view_where ADD logical varchar(5) Null"

//END---Modify by Scofield on 2010-04-14

//BEGIN---Modify by Scofield on 2010-04-19
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_1' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_1 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_2' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_2 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_3' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_3 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_4' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_4 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_5' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_5 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_6' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_6 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_7' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_7 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_8' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_8 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_9' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_9 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_10' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_10 varchar(75) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n1' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n1 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n2' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n2 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n3' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n3 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n4' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n4 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n5' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n5 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n6' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n6 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n7' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n7 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n8' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n8 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n9' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n9 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n10' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_n10 numeric(12,2) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date1' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date1 datetime Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date2' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date2 datetime Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date3' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date3 datetime Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date4' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date4 datetime Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date5' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date5 datetime Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date6' and t.table_name='ctx_am_document' ) " + &
"ALTER TABLE ctx_am_document ADD custom_date6 datetime Null"
//END---Modify by Scofield on 2010-04-19

//Added By Ken.Guo 2010-04-21.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_server' and t.table_name='em_user_msg_id' ) " + &
"ALTER table em_user_msg_id add pop3_server varchar(100) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_account' and t.table_name='em_user_msg_id' ) " + &
"ALTER table em_user_msg_id add pop3_account varchar(100) null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='auto_add_ctx' and t.table_name='em_user_config' ) " + &
"ALTER table em_user_config add auto_add_ctx integer null  "

//BEGIN---Modify by Scofield on 2010-05-10
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_notes_1' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_notes_1 varchar(8000) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_notes_2' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_notes_2 varchar(8000) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_notes_3' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_notes_3 varchar(8000) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_notes_4' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_notes_4 varchar(8000) Null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_notes_5' and t.table_name='ctx_basic_info' ) " + &
"ALTER TABLE ctx_basic_info ADD custom_notes_5 varchar(8000) Null"
//END---Modify by Scofield on 2010-05-10

//Added By Ken.Guo 2010-05-12.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='email_tag_mode' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD email_tag_mode integer null~r~n"

//BEGIN---Modify by Scofield on 2010-05-18
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='AutoExport' and t.table_name='Security_Users' ) " + &
"ALTER TABLE Security_Users ADD AutoExport int Null"
//END---Modify by Scofield on 2010-05-18

//Added By Ken.Guo 2010-05-19.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='getting_started' and t.table_name='security_users' ) " + &
"alter table security_users add getting_started integer null "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If not exists( select 1 from sysobjects where name = 'dashboard_gadgets_getting_started' )~r~n" + &
"	Create Table dashboard_gadgets_getting_started~r~n" + &
"	(~r~n" + &
"	id numeric(10) identity not null,~r~n" + &
"	user_id varchar(50) not null,~r~n" + &
"	sort_result varchar(100) null,~r~n" + &
"	display_columns integer null,~r~n" + &
"	Primary Key(id)~r~n" + &
"	)  ~r~n"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If not exists( select 1 from sysobjects where name = 'ctx_getting_started' )~r~n" + &
"	Create Table ctx_getting_started~r~n" + &
"	(~r~n" + &
"	id integer not null,~r~n" + &
"	enable_picture varchar(100) not null,~r~n" + &
"	disable_picture varchar(100) not null,~r~n" + &
"	tips varchar(100) null,~r~n" + &
"	Primary Key(id)~r~n" + &
"	)  "

//Added By Ken.Guo 2010-06-03.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='id_forcelog' and t.table_name='ctx_fee_sched_nm' ) " + &
"ALTER table ctx_fee_sched_nm add id_forcelog integer  ~r~n"  //BugH082704 - alfee 11.28.2013
//"ALTER table ctx_fee_sched_nm add id_forcelog integer identity not null  ~r~n"

//Added By Ken.Guo 2010-07-01.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='delete_flag' and t.table_name='ctx_bidq_doc' ) " + &
"ALTER table ctx_bidq_doc add delete_flag integer null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table ctx_bidq_doc modify doc_type varchar(30)"

//Add by jervis 2010-07-19
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='fee_sched_calc_field_1' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add fee_sched_calc_field_1 money null default 0"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='fee_sched_calc_field_2' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add fee_sched_calc_field_2 money null default 0"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='fee_sched_calc_field_3' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add fee_sched_calc_field_3 money null default 0"

//Added By Ken.Guo 2010-08-06.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='default_order' and t.table_name='ctx_getting_started' ) " + &
"ALTER table ctx_getting_started add default_order integer null  "

//Added By Ken.Guo 2010-08-05.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='run_date_alarm' and t.table_name='security_users' ) " + &
"ALTER table security_users add run_date_alarm integer null  ~r~n" 

////Add by jervis 08.09.2010
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID('FK_EXPORT_F_REFERENCE_EXPORT_H') AND parent_object_id = OBJECT_ID('export_fields')) ~r~n" + &
//"ALTER TABLE export_fields DROP CONSTRAINT [FK_EXPORT_F_REFERENCE_EXPORT_H]"

//Added By Ken.Guo 2010-08-09.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='email_alarm_type' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add email_alarm_type integer null  ~r~n" 


//Added by jervis 08.09.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='newpage_group' and t.table_name='conv_view' ) " + &
"alter table conv_view add newpage_group char(1) default 0 null " 

//Added By Ken.Guo 2010-08-12.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='group_email_template' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add group_email_template numeric(10,0) null  ~r~n" 

//Added By Ken.Guo 2010-08-16.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_id_list' and t.table_name='em_mail_items' ) " + &
"ALTER table em_mail_items add ctx_id_list varchar(1000) null  "

//Added By Ken.Guo 2010-08-23.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ctx_id_list' and t.table_name='em_sent_items' ) " + &
"ALTER table em_sent_items add ctx_id_list varchar(1000) null  "

//Added By Ken.Guo 2010-08-31.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='gadget_title_font_color' and t.table_name='dashboard_tabs' ) " + &
"ALTER table dashboard_tabs add gadget_title_font_color numeric(10,0) null  ~r~n"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tab_text_color' and t.table_name='dashboard_tabs' ) " + &
"ALTER table dashboard_tabs add tab_text_color numeric(10,0) null  "

////Add by jervis 08.31.2010
////Add Trigge type fields on data value compraision
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if not exists(	select 1 from syscolumns c, sysobjects t   ~r~n" + &
//"where c.id=t.id  and c.name='wf_trigger_type' and t.name='wf_workflow'	and t.type = 'U')~r~n" + &
//"alter table wf_workflow add wf_trigger_type varchar(1) default 'S' null "
//

//Add by jervis 09.14.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='left_bracket' and t.table_name='wf_trigger_param_data_comparison' ) " + &
"alter table wf_trigger_param_data_comparison add left_bracket varchar(5)  NULL"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='right_bracket' and t.table_name='wf_trigger_param_data_comparison' ) " + &
"alter table wf_trigger_param_data_comparison add right_bracket varchar(5)  NULL"

//Added By Ken.Guo 2010-09-17.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tv_icon' and t.table_name='tdl_detail' ) " + &
"ALTER table tdl_detail add tv_icon varchar(30) null   " 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tab_icon' and t.table_name='ctx_tabpage_properties' ) " + &
"ALTER table ctx_tabpage_properties add tab_icon varchar(50) null  "


//Add by jervis 09.19.2010
//Add Trigge type fields on data value compraision
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_trigger_onlogin' and t.table_name='wf_workflow' ) " + &
"alter table wf_workflow add wf_trigger_onlogin varchar(1) default 'N' null "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_trigger_onsave' and t.table_name='wf_workflow' ) " + &
"alter table wf_workflow add wf_trigger_onsave varchar(1) default 'Y' null "

//Add by jervis 10.13.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'wf_advanced_update_criteria' )~r~n" + &
"CREATE TABLE wf_advanced_update_criteria(~r~n" + &
"	wf_id int NOT NULL,~r~n" + &
"	wf_step_id int NOT NULL,~r~n" + &
"	wf_status_id int NOT NULL,~r~n" + &
"	key_id int NOT NULL,~r~n" + &
"	seq_no int IDENTITY not null,~r~n" + &
"	view_id int NOT NULL,~r~n" + &
"	screen_id int NOT NULL,~r~n" + &
"	field_name varchar(50) NULL,~r~n" + &
"	field_label varchar(255) NULL,~r~n" + &
"	operator varchar(20) NULL DEFAULT ('='),~r~n" + &
"	Value varchar(255) NULL,~r~n" + &
"	logical varchar(5) NULL DEFAULT ('and'),~r~n" + &
"	module varchar(2) NULL,~r~n" + &
"	field_type varchar(2) NULL,~r~n" + &
"	table_name varchar(150) NULL,~r~n" + &
"	value_display varchar(75) NULL,~r~n" + &
"	lookup_code varchar(40) NULL,~r~n" + &
"	lookup_flag char(1) NULL DEFAULT ('V'),~r~n" + &
"	left_bracket varchar(5) NULL,~r~n" + &
"	right_bracket varchar(5) NULL,~r~n" + &
"	CONSTRAINT pk_wf_advanced_update_criteria PRIMARY KEY(wf_id ,wf_step_id,wf_status_id,key_id,seq_no)~r~n" + &
")"

//Added By Ken.Guo 2010-10-20.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ocr_engine_pdf' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add ocr_engine_pdf integer null  "

//Added By Ken.Guo 2010-10-20.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='append_paragraph' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add append_paragraph integer null  " 


//Added By Jervis 2010-10-25.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='field_parent' and t.table_name='wf_advanced_update_criteria' ) " + &
"alter table wf_advanced_update_criteria add field_parent varchar(50) null  " 

//Added By Jervis 2010-10-25.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_esign' and t.table_name='wf_action_status' ) " + &
"alter table wf_action_status add wf_esign char(1) default 'N' null"

//Added By Ken.Guo 2010-10-26.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_id_list' and t.table_name='em_mail_items' ) " + &
"ALTER table em_mail_items add doc_id_list varchar(1000) null  "

//Added By Ken.Guo 2010-11-03.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_1' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_1 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_2' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_2 numeric(12,4) null  ~r~n"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_3' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_3 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_4' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_4 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_5' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_5 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_6' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_6 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_7' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_7 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_8' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_8 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_9' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_9 numeric(12,4) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_percent_10' and t.table_name='ctx_basic_info' ) " + &
"ALTER table ctx_basic_info add custom_percent_10 numeric(12,4) null  "


of_execute_sqls("of_ver100_release_table1")

Return 1

end function

public function integer of_ver100_release_table2 ();//Added By Ken.Guo 2010-11-12.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'em_mail_audit' )~r~n" + &
"	Create Table em_mail_audit ~r~n" + &
"	(~r~n" + &
"		id  numeric(10,0) identity  not null,~r~n" + &
"		user_id varchar(50) not null,~r~n" + &
"		mail_from varchar(50) null,~r~n" + &
"		mail_to varchar(500) null,~r~n" + &
"		mail_cc varchar(500) null,~r~n" + &
"		mail_bcc varchar(500) null,~r~n" + &
"		mail_subject varchar(500) null,~r~n" + &
"		mail_date datetime null,~r~n" + &
"		mail_importance integer null,~r~n" + &
"		mail_attach_name varchar(1000) null,~r~n" + &
"		mail_template_id numeric(10,0) null,~r~n" + &
"		ctx_id_list varchar(1000) null,~r~n" + &
"		doc_id_list varchar(1000) null,~r~n" + &
"		ai_id_list varchar(1000) null,~r~n" + &
"		wf_id numeric(10,0) null,~r~n" + &
"		alarm_type varchar(50) null,~r~n" + &
"		field_name varchar(50) null,~r~n" + &
"		compute_info varchar(200) null,~r~n" + &
"		send_result integer null,~r~n" + &
"		notes varchar(8000) null,~r~n" + &
"		error_text varchar(200),~r~n" + &
"		Primary Key(id)~r~n" + &
"	)~r~n" 



//Add  group access for contact screen -- jervis 11.21.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'app_facility_group_access' )~r~n" + &
"CREATE TABLE app_facility_group_access~r~n" + &
"(~r~n" + &
"	facility_id int NOT NULL,~r~n" + &
"	group_id numeric(10, 0) NOT NULL,~r~n" + &
"	access varchar(1) NOT NULL,~r~n" + &
"	notes varchar(100) NULL,~r~n" + &
"	CONSTRAINT PK_app_facility_group_access PRIMARY KEY (facility_id ,group_id)~r~n" + &
")"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'app_facility_default_access' )~r~n" + &
"CREATE TABLE app_facility_default_access~r~n" + &
"(~r~n" + &
"	user_id varchar(25) not null,~r~n" + &
"	group_id numeric(10, 0) NOT NULL,~r~n" + &
"	access varchar(1) NOT NULL,~r~n" + &
"	notes varchar(100) NULL,~r~n" + &
"	CONSTRAINT PK_app_facility_default_access PRIMARY KEY (user_id ,group_id)~r~n" + &
")"

//Added By Ken.Guo 2010-11-30.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='send_email_log' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add send_email_log integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='send_email_log_to' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add send_email_log_to varchar(500) null  ~r~n" 

//Add group access for compamy -- jervis 12.02.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='company_group_access' and t.table_name='icred_settings' ) " + &
"alter table icred_settings add company_group_access int null  ~r~n" 

//Added By Ken.Guo 2010-12-03.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='receive_email' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add receive_email integer null  ~r~n" 

//Added By Ken.Guo 2010-12-06.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='run_alarm' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add run_alarm integer null  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='req_expand_status' and t.table_name='security_users' ) " + &
"ALTER table security_users add req_expand_status varchar(20) null  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='show_word_ico' and t.table_name='ctx_req_tmplt_element' ) " + &
"ALTER table ctx_req_tmplt_element add show_word_ico integer null  "

//Add by jervis 12.24.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='work_flow_n1' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add work_flow_n1 numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='work_flow_n2' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add work_flow_n2 numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='work_flow_n3' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add work_flow_n3 numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='work_flow_n4' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add work_flow_n4 numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='work_flow_n5' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add work_flow_n5 numeric(12,2) null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='blind_flag' and t.table_name='security_user_mailsetting' ) " + &
"alter table security_user_mailsetting add blind_flag char(1) default '0' null"

////limit 20 characters for password - jervis 01.21.2011
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if not exists(	select 1 from syscolumns c, sysobjects t   ~r~n" + &
//"where c.id=t.id  and c.name='user_password' and t.name='security_users'	and t.type = 'U')~r~n" + &
//"alter table security_users alter column user_password nvarchar(50) null "


//Add 'add lookup code..' in screen painter - jervis 01.26.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_screen_field_ex' )~r~n" + &
"CREATE TABLE ctx_screen_field_ex(~r~n" + &
"	data_view_id int NOT NULL,~r~n" + &
"	screen_id int NOT NULL,~r~n" + &
"	field_name varchar(50)  NOT NULL,~r~n" + &
"	field_Add varchar(1)  NULL default 'Y',~r~n" + &
" CONSTRAINT PK_ctx_screen_field_ex PRIMARY KEY ~r~n" + &
"(~r~n" + &
"	data_view_id ,~r~n" + &
"	screen_id ,~r~n" + &
"	field_name ~r~n" + &
"))"

//Added By Ken.Guo 2011-02-14.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter table ctx_am_document modify filename varchar(500) "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter table ctx_bidq_doc modify filename varchar(500) "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"Alter table Ctx_am_doc_audit modify filename varchar(500) "

////Modify table primary key - jervis 03.10.2011
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_table ~r~n" +  &
//"	DROP CONSTRAINT PK_conv_view_table ~r~n"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_table ADD CONSTRAINT ~r~n" +  &
//"	PK_conv_view_table PRIMARY KEY CLUSTERED  ~r~n" +  &
//"	( ~r~n" +  &
//"	view_id, ~r~n" +  &
//"	table_id ~r~n" +  &
//"	)  ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_links ~r~n" +  &
//"	DROP CONSTRAINT PK_CONV_VIEW_LINKS ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_links ADD CONSTRAINT ~r~n" +  &
//"	PK_CONV_VIEW_LINKS PRIMARY KEY CLUSTERED  ~r~n" +  &
//"	( ~r~n" +  &
//"	view_id, ~r~n" +  &
//"	link_id ~r~n" +  &
//"	) ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_fields ~r~n" +  &
//"	DROP CONSTRAINT PK_CONV_VIEW_FIELDS ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_fields ADD CONSTRAINT ~r~n" +  &
//"	PK_CONV_VIEW_FIELDS PRIMARY KEY CLUSTERED  ~r~n" +  &
//"	( ~r~n" +  &
//"	view_id, ~r~n" +  &
//"	field_id ~r~n" +  &
//"	) ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_where ~r~n" +  &
//"	DROP CONSTRAINT PK_CONV_VIEW_WHERE ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE conv_view_where ADD CONSTRAINT ~r~n" +  &
//"	PK_CONV_VIEW_WHERE PRIMARY KEY CLUSTERED  ~r~n" +  &
//"	( ~r~n" +  &
//"	view_id, ~r~n" +  &
//"	where_id ~r~n" +  &
//"	) ~r~n" 

//Added By Ken.Guo 2011-03-30.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table import_table_gen modify field_1 varchar(8000) null "


////Modify primary key -jervis 04.19.2011
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE SECURITY_ROLES_RIGHTS ~r~n" +  &
//"	DROP CONSTRAINT PK_SECURITY_ROLES_RIGHTS ~r~n" 
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE SECURITY_ROLES_RIGHTS ADD CONSTRAINT ~r~n" +  &
//"	PK_SECURITY_ROLES_RIGHTS PRIMARY KEY CLUSTERED  ~r~n" +  &
//"	( ~r~n" +  &
//"	ROLE_ID, ~r~n" +  &
//"	RIGHTS_ID ~r~n" +  &
//"	) ~r~n" 


//Add custom status field -- jervis 04.19.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_status1' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add custom_status1 int null "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_status2' and t.table_name='ctx_basic_info' ) " + &
"alter table ctx_basic_info add custom_status2 int null "

//Modify primary key -jervis 04.19.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='field_name' and t.table_name='sys_statusaudit' ) " + &
"alter table sys_statusaudit add field_name varchar(50)  " //CTX table for BugH082704  - alfee 11.28.2013
//"alter table sys_statusaudit add field_name varchar(50) not null default 'status' "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"ALTER TABLE sys_StatusAudit delete primary key ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"ALTER TABLE sys_StatusAudit ADD CONSTRAINT ~r~n" +  &
"	PK_sys_StatusAudit PRIMARY KEY CLUSTERED  ~r~n" +  &
"	( ~r~n" +  &
"	ctx_id, ~r~n" +  &
"	seq_no, ~r~n" +  &
"	field_name ~r~n" +  &
"	) ~r~n" 


//Added By Ken.Guo 2011-05-06. for Open PDF Mode
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='openpdfwith' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add openpdfwith integer null  ~r~n"




of_execute_sqls("of_ver100_release_table2")

Return 1

end function

public function integer of_ver100_release_storeprocedure1 ();

Return 1
end function

public function integer of_ver100_release_view1 ();//BEGIN---Modify by Scofield on 2010-04-13
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if Exists(SELECT 1 FROM sysobjects WHERE name = 'v_ctx_contacts_contacts')~r~n" + &
"   DROP VIEW v_ctx_contacts_contacts"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_contacts_contacts AS~r~n" + &
"SELECT ~r~n" + &
"       CTX_BASIC_INFO.ctx_id,~r~n" + &
"       app_facility.facility_name,~r~n" + &
"       app_facility.contact AS Company_Custom_ID#,~r~n" + &
"       v_ctx_contract_contacts.contact_id,~r~n" + &
"       v_ctx_contract_contacts.association,~r~n" + &
"       code_lookup.code AS contract_type_code,~r~n" + &
"       code_lookup.description AS contract_type_description,~r~n" + &
"       CTX_CONTACTS.first_name,~r~n" + &
"       CTX_CONTACTS.last_name,~r~n" + &
"       CTX_CONTACTS.middle_name,~r~n" + &
"       code_lookup_4.description AS contact_title,~r~n" + &
"       code_lookup_1.code AS contract_department_code,~r~n" + &
"       code_lookup_1.description AS contract_department_des,~r~n" + &
"       app_facility.street,~r~n" + &
"       app_facility.street_2,~r~n" + &
"       app_facility.street_3,~r~n" + &
"       app_facility.city,~r~n" + &
"       app_facility.zip,~r~n" + &
"       app_facility.state,~r~n" + &
"       CTX_CONTACTS.custom_1,~r~n" + &
"       CTX_CONTACTS.custom_2,~r~n" + &
"       CTX_CONTACTS.custom_3,~r~n" + &
"       CTX_CONTACTS.custom_4,~r~n" + &
"       CTX_CONTACTS.custom_5,~r~n" + &
"       CTX_CONTACTS.custom_6,~r~n" + &
"       CTX_CONTACTS.custom_7,~r~n" + &
"       CTX_CONTACTS.custom_8,~r~n" + &
"       CTX_CONTACTS.custom_9,~r~n" + &
"       CTX_CONTACTS.custom_10,~r~n" + &
"       v_ctx_contract_contacts.owner,~r~n" + &
"       v_ctx_contract_contacts.access,~r~n" + &
"       NULL AS Phone_Type_code,~r~n" + &
"       NULL AS Phone_type_Description,~r~n" + &
"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
"       v_ctx_contract_contacts.ext,~r~n" + &
"       v_ctx_contract_contacts.contact_email,~r~n" + &
"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
"       v_ctx_contract_contacts.notes~r~n" + &
"  FROM CTX_CONTACTS~r~n" + &
"       INNER JOIN v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
"       INNER JOIN CTX_BASIC_INFO ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ~r~n" + &
"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
" WHERE v_ctx_contract_contacts.ic_area='c'~r~n" //+ &
//"ORDER BY CTX_BASIC_INFO.ctx_id"

//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//"if Exists(SELECT 1 FROM sysobjects WHERE name = 'v_ctx_contacts_external')~r~n" + &
//"   DROP VIEW v_ctx_contacts_external"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//"CREATE VIEW v_ctx_contacts_external AS~r~n" + &
//"SELECT ~r~n" + &
//"       CTX_BASIC_INFO.ctx_id,~r~n" + &
//"       app_facility.facility_name,~r~n" + &
//"       app_facility.contact as Company_Custom_ID#,~r~n" + &
//"       code_lookup.code AS contact_type_code,~r~n" + &
//"       code_lookup.description AS contact_type_description,~r~n" + &
//"       CTX_CONTACTS.first_name,~r~n" + &
//"       CTX_CONTACTS.last_name,~r~n" + &
//"       CTX_CONTACTS.middle_name,~r~n" + &
//"       code_lookup_4.description AS contact_title,~r~n" + &
//"       code_lookup_1.code AS contract_department_code,~r~n" + &
//"       code_lookup_1.description AS contract_department_des,~r~n" + &
//"       app_facility.street,~r~n" + &
//"       app_facility.street_2,~r~n" + &
//"       app_facility.street_3,~r~n" + &
//"       app_facility.city,~r~n" + &
//"       app_facility.zip,~r~n" + &
//"       app_facility.state,~r~n" + &
//"       CTX_CONTACTS.custom_1,~r~n" + &
//"       CTX_CONTACTS.custom_2,~r~n" + &
//"       CTX_CONTACTS.custom_3,~r~n" + &
//"       CTX_CONTACTS.custom_4,~r~n" + &
//"       CTX_CONTACTS.custom_5,~r~n" + &
//"       CTX_CONTACTS.custom_6,~r~n" + &
//"       CTX_CONTACTS.custom_7,~r~n" + &
//"       CTX_CONTACTS.custom_8,~r~n" + &
//"       CTX_CONTACTS.custom_9,~r~n" + &
//"       CTX_CONTACTS.custom_10,~r~n" + &
//"       v_ctx_contract_contacts.access,~r~n" + &
//"       v_ctx_contract_contacts.owner,~r~n" + &
//"       v_ctx_contract_contacts.notes,~r~n" + &
//"       v_ctx_contract_contacts.ext,~r~n" + &
//"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
//"       v_ctx_contract_contacts.contact_email,~r~n" + &
//"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
//"       NULL AS Phone_Type_code,~r~n" + &
//"       NULL AS Phone_type_Description,~r~n" + &
//"       v_ctx_contract_contacts.contact_id,~r~n" + &
//"       v_ctx_contract_contacts.default_email as default_to  ~r~n" + &
//"  FROM CTX_CONTACTS~r~n" + &
//"       INNER JOIN~r~n" + &
//"       v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
//"       INNER JOIN CTX_BASIC_INFO~r~n" + &
//"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
//"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
//" WHERE v_ctx_contract_contacts.ic_area='e'~r~n" + &
//"ORDER BY CTX_BASIC_INFO.ctx_id"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if Exists(SELECT 1 FROM sysobjects WHERE name = 'v_ctx_contacts_internal')~r~n" + &
"   DROP VIEW v_ctx_contacts_internal"

//Add 'association' -- jervis 05.05.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_contacts_internal AS~r~n" + &
"SELECT ~r~n" + &
"       CTX_BASIC_INFO.ctx_id,~r~n" + &
"       app_facility.facility_name,~r~n" + &
"       app_facility.contact as Company_Custom_ID#,~r~n" + &
"       code_lookup.code AS contact_type_code,~r~n" + &
"       code_lookup.description AS contact_type_description,~r~n" + &
"       CTX_CONTACTS.first_name,~r~n" + &
"       CTX_CONTACTS.last_name,~r~n" + &
"       CTX_CONTACTS.middle_name,~r~n" + &
"       code_lookup_4.description AS contact_title,~r~n" + &
"       code_lookup_1.code AS contract_department_code,~r~n" + &
"       code_lookup_1.description AS contract_department_des,~r~n" + &
"       app_facility.street,~r~n" + &
"       app_facility.street_2,~r~n" + &
"       app_facility.street_3,~r~n" + &
"       app_facility.city,~r~n" + &
"       app_facility.zip,~r~n" + &
"       app_facility.state,~r~n" + &
"       CTX_CONTACTS.custom_1,~r~n" + &
"       CTX_CONTACTS.custom_2,~r~n" + &
"       CTX_CONTACTS.custom_3,~r~n" + &
"       CTX_CONTACTS.custom_4,~r~n" + &
"       CTX_CONTACTS.custom_5,~r~n" + &
"       CTX_CONTACTS.custom_6,~r~n" + &
"       CTX_CONTACTS.custom_7,~r~n" + &
"       CTX_CONTACTS.custom_8,~r~n" + &
"       CTX_CONTACTS.custom_9,~r~n" + &
"       CTX_CONTACTS.custom_10,~r~n" + &
"       v_ctx_contract_contacts.access,~r~n" + &
"       v_ctx_contract_contacts.owner,~r~n" + &
"       v_ctx_contract_contacts.notes,~r~n" + &
"       v_ctx_contract_contacts.ext,~r~n" + &
"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
"       v_ctx_contract_contacts.contact_email,~r~n" + &
"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
"       NULL AS Phone_Type_code,~r~n" + &
"       NULL AS Phone_type_Description,~r~n" + &
"       v_ctx_contract_contacts.contact_id,~r~n" + &
"       v_ctx_contract_contacts.association,~r~n" + &
"       v_ctx_contract_contacts.default_email as default_to~r~n" + &
"  FROM CTX_CONTACTS~r~n" + &
"       INNER JOIN v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
"       INNER JOIN CTX_BASIC_INFO ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ~r~n" + &
"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
" WHERE v_ctx_contract_contacts.ic_area='i'~r~n"// + &
//"ORDER BY CTX_BASIC_INFO.ctx_id"
//END---Modify by Scofield on 2010-04-13

//BEGIN---Modify by Scofield on 2010-05-12
//Left OUTER JOIN ctx_products - jervis 07.14.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_basic_info') ~r~n" + &
" drop view v_ctx_basic_info"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_basic_info AS~r~n" + &
"SELECT ~r~n" + &
"       app_facility.facility_name AS Company_Name,~r~n" + &
"       app_facility.street AS Company_street_1,~r~n" + &
"       app_facility.street_2 AS Company_street_2,~r~n" + &
"       app_facility.city AS Company_city,~r~n" + &
"       app_facility.state AS Company_state,~r~n" + &
"       app_facility.zip AS Company_zip,~r~n" + &
"       app_facility.country AS Company_country,~r~n" + &
"       app_facility.phone AS Company_phone,~r~n" + &
"       app_facility.fax AS Company_fax,~r~n" + &
"       app_facility.web_address AS Company_web_address,~r~n" + &
"       app_facility.contact_type2 AS Company_contact_type2,~r~n" + &
"       app_facility.corp_office_flag AS Company_corp_office_flag,~r~n" + &
"       app_facility.corp_office_link AS Company_corp_office_link,~r~n" + &
"       code_lookup.code AS Contract_Category_code,~r~n" + &
"       code_lookup.description AS Contract_Category_description,~r~n" + &
"       code_lookup_1.code AS Contract_Status_code,~r~n" + &
"       code_lookup_2.code AS contract_type_code,~r~n" + &
"       code_lookup_2.description AS contract_type_Description,~r~n" + &
"       code_lookup_3.code AS term_reason_code,~r~n" + &
"       code_lookup_3.description AS term_Reason_Desciption,~r~n" + &
"       code_lookup_4.description AS product_type_desc,~r~n" + &
"       code_lookup_4.code AS product_type_code,~r~n" + &
"       code_lookup_5.code AS product_code,~r~n" + &
"       code_lookup_5.description AS product_description,~r~n" + &
"       ctx_basic_info.ctx_id,~r~n" + &
"       ctx_basic_info.category,~r~n" + &
"       ctx_basic_info.status,~r~n" + &
"       ctx_basic_info.facility_id,~r~n" + &
"       ctx_basic_info.contract_type,~r~n" + &
"       ctx_basic_info.product_type,~r~n" + &
"       ctx_basic_info.product_name,~r~n" + &
"       ctx_basic_info.reimbursment_menth,~r~n" + &
"       ctx_basic_info.file_location,~r~n" + &
"       ctx_basic_info.effective_date,~r~n" + &
"       ctx_basic_info.expriation_date,~r~n" + &
"       ctx_basic_info.review_date,~r~n" + &
"       ctx_basic_info.review_by,~r~n" + &
"       ctx_basic_info.term_date,~r~n" + &
"       ctx_basic_info.term_reason,~r~n" + &
"       ctx_basic_info.last_revis_date,~r~n" + &
"       ctx_basic_info.other_date_1,~r~n" + &
"       ctx_basic_info.other_date_2,~r~n" + &
"       ctx_basic_info.oc_signed_by,~r~n" + &
"       ctx_basic_info.oc_title,~r~n" + &
"       ctx_basic_info.oc_department,~r~n" + &
"       ctx_basic_info.oc_legal_rep,~r~n" + &
"       ctx_basic_info.cc_signed_by,~r~n" + &
"       ctx_basic_info.cc_title,~r~n" + &
"       ctx_basic_info.cc_department,~r~n" + &
"       ctx_basic_info.cc_legal_rep,~r~n" + &
"       ctx_basic_info.keyword,~r~n" + &
"       ctx_basic_info.dvision,~r~n" + &
"       ctx_basic_info.custom_1,~r~n" + &
"       ctx_basic_info.custom_2,~r~n" + &
"       ctx_basic_info.custom_3,~r~n" + &
"       ctx_basic_info.custom_4,~r~n" + &
"       ctx_basic_info.custom_5,~r~n" + &
"       ctx_basic_info.custom_6,~r~n" + &
"       ctx_basic_info.custom_7,~r~n" + &
"       ctx_basic_info.custom_8,~r~n" + &
"       ctx_basic_info.custom_9,~r~n" + &
"       ctx_basic_info.custom_10,~r~n" + &
"       ctx_basic_info.group_multi_loc_id,~r~n" + &
"       ctx_basic_info.revision_reason,~r~n" + &
"       ctx_basic_info.group_id,~r~n" + &
"       ctx_basic_info.record_id,~r~n" + &
"       ctx_basic_info.custom_11,~r~n" + &
"       ctx_basic_info.custom_12,~r~n" + &
"       ctx_basic_info.custom_13,~r~n" + &
"       ctx_basic_info.custom_14,~r~n" + &
"       ctx_basic_info.custom_15,~r~n" + &
"       ctx_basic_info.custom_16,~r~n" + &
"       ctx_basic_info.custom_17,~r~n" + &
"       ctx_basic_info.custom_18,~r~n" + &
"       ctx_basic_info.custom_19,~r~n" + &
"       ctx_basic_info.custom_20,~r~n" + &
"       ctx_basic_info.custom_21,~r~n" + &
"       ctx_basic_info.custom_22,~r~n" + &
"       ctx_basic_info.custom_date1,~r~n" + &
"       ctx_basic_info.custom_date2,~r~n" + &
"       ctx_basic_info.custom_date3,~r~n" + &
"       ctx_basic_info.custom_date4,~r~n" + &
"       ctx_basic_info.custom_date5,~r~n" + &
"       ctx_basic_info.custom_date6,~r~n" + &
"       ctx_basic_info.custom_date7,~r~n" + &
"       ctx_basic_info.custom_date8,~r~n" + &
"       ctx_basic_info.custom_date9,~r~n" + &
"       ctx_basic_info.custom_date10,~r~n" + &
"       ctx_basic_info.custom_date16,~r~n" + &
"       ctx_basic_info.custom_date17,~r~n" + &
"       ctx_basic_info.custom_n1,~r~n" + &
"       ctx_basic_info.custom_n2,~r~n" + &
"       ctx_basic_info.custom_n3,~r~n" + &
"       ctx_basic_info.custom_n4,~r~n" + &
"       ctx_basic_info.custom_n5,~r~n" + &
"       ctx_basic_info.custom_n6,~r~n" + &
"       ctx_basic_info.custom_n7,~r~n" + &
"       ctx_basic_info.custom_n8,~r~n" + &
"       ctx_basic_info.custom_n9,~r~n" + &
"       ctx_basic_info.custom_n10,~r~n" + &
"       ctx_basic_info.custom_n11,~r~n" + &
"       ctx_basic_info.custom_n12,~r~n" + &
"       ctx_basic_info.custom_n13,~r~n" + &
"       ctx_basic_info.custom_n14,~r~n" + &
"       ctx_basic_info.custom_n15,~r~n" + &
"       ctx_basic_info.custom_n16,~r~n" + &
"       ctx_basic_info.custom_n17,~r~n" + &
"       ctx_basic_info.custom_n18,~r~n" + &
"       ctx_basic_info.custom_n19,~r~n" + &
"       ctx_basic_info.custom_n20,~r~n" + &
"       ctx_basic_info.custom_n21,~r~n" + &
"       ctx_basic_info.custom_n22,~r~n" + &
"       ctx_basic_info.custom_n23,~r~n" + &
"       ctx_basic_info.custom_n24,~r~n" + &
"       ctx_basic_info.custom_n25,~r~n" + &
"       ctx_basic_info.custom_n26,~r~n" + &
"       ctx_basic_info.custom_n27,~r~n" + &
"       ctx_basic_info.custom_notes_1,~r~n" + &
"       ctx_basic_info.custom_notes_2,~r~n" + &
"       ctx_basic_info.custom_notes_3,~r~n" + &
"       ctx_basic_info.custom_notes_4,~r~n" + &
"       ctx_basic_info.custom_notes_5,~r~n" + &
"       ctx_basic_info.version_number,~r~n" + &
"       ctx_basic_info.version_date,~r~n" + &
"       ctx_basic_info.notes,~r~n" + &
"       ctx_basic_info.app_facility,~r~n" + &
"       ctx_basic_info.master_contract_id AS master_ctx_id,~r~n" + &
"       ctx_basic_info.master_contract_name,~r~n" + &
"       code_lookup_6.code AS dvision_code,~r~n" + &
"       code_lookup_6.description AS dvision_description~r~n" + &
"  FROM (((((((ctx_basic_info LEFT OUTER JOIN code_lookup ON ctx_basic_info.category = code_lookup.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_basic_info.status = code_lookup_1.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_2 ON ctx_basic_info.contract_type = code_lookup_2.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_3 ON ctx_basic_info.term_reason = code_lookup_3.lookup_code)~r~n" + &
"       INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id)~r~n" + &
"       Left OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code)~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_6 ON ctx_basic_info.dvision = code_lookup_6.lookup_code~r~n" + &
"	WHERE ctx_basic_info.is_template = 0 ~r~n" //+ &
//"ORDER BY ctx_basic_info.ctx_id"
//END---Modify by Scofield on 2010-05-12


//Modify v_ctx_action_items,add subject... fields - jervis 07.29.2010
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_action_items' and type = 'V')  " + &
"  drop view v_ctx_action_items "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  v_ctx_action_items " + &
"as SELECT  " + &
"	ctx_action_items.ctx_action_item_id, " + &
"	ctx_action_items.ctx_id, " + &
"	ctx_action_items.action_type, " + &
"	ctx_action_items.action_date, " + &
"	ctx_action_items.due_date, " + &
"	ctx_action_items.action_user, " + &
"	ctx_action_items.action_status, " + &
"	ctx_action_items.notes, " + &
"	ctx_action_items.ALARMED, " + &
"	ctx_action_items.first_attempt, " + &
"	ctx_action_items.last_attempt, " + &
"	ctx_action_items.no_attempts, " + &
"	ctx_action_items.assigned_to, " + &
"	ctx_action_items.print_flag, " + &
"	ctx_action_items.inserted_by_user, " + &
"	ctx_action_items.inserted_at_date_time, " + &
"	ctx_action_items.updated_by_user, " + &
"	ctx_action_items.updated_at_date_time, " + &
"	ctx_action_items.record_id, " + &
"	ctx_action_items.Letter_flag, " + &
"	ctx_action_items.letter_to, " + &
"	ctx_action_items.letter_from, " + &
"	ctx_action_items.wf_step, " + &
"	ctx_action_items.letter_id, " + &
"	ctx_action_items.wf_id, " + &
"	ctx_action_items.Wf_action_type_id, " + &
"	ctx_action_items.wf_assigned_by, " + &
"	ctx_action_items.active_status, " + &
"	ctx_action_items.wf_complete_flag, " + &
"	ctx_action_items.alm_table, " + &
"	ctx_action_items.alm_column, " + &
"  custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_1, custom_2, custom_3, custom_4, Subject, Start_Date, Start_Time, " + &
"  Duration, Duration_Type, End_Date, End_Time, Priority  " + &
"FROM 	ctx_action_items " //+ &
//"ORDER BY ctx_action_items.ctx_action_item_id, " + &
//"	 ctx_action_items.ctx_id "


//Modify by jervis -- 12.21.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_custom') ~r~n" + &
" drop view v_ctx_custom"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_custom AS ~r~n" + &
"SELECT ~r~n" + &
"       ctx_id,~r~n" + &
"       custom_1,~r~n" + &
"       custom_2,~r~n" + &
"       custom_3,~r~n" + &
"       custom_4,~r~n" + &
"       custom_5,~r~n" + &
"       custom_6,~r~n" + &
"       custom_7,~r~n" + &
"       custom_8,~r~n" + &
"       custom_9,~r~n" + &
"       custom_10,~r~n" + &
"       custom_11,~r~n" + &
"       custom_12,~r~n" + &
"       custom_13,~r~n" + &
"       custom_14,~r~n" + &
"       custom_15,~r~n" + &
"       custom_16,~r~n" + &
"       custom_17,~r~n" + &
"       custom_18,~r~n" + &
"       custom_19,~r~n" + &
"       custom_20,~r~n" + &
"       custom_date1,~r~n" + &
"       custom_date2,~r~n" + &
"       custom_date3,~r~n" + &
"       custom_date4,~r~n" + &
"       custom_date5,~r~n" + &
"       custom_date6,~r~n" + &
"       custom_date7,~r~n" + &
"       custom_date8,~r~n" + &
"       custom_date9,~r~n" + &
"       custom_date10,~r~n" + &
"       custom_date11,~r~n" + &
"       custom_date12,~r~n" + &
"       custom_date13,~r~n" + &
"       custom_date14,~r~n" + &
"       custom_date15,~r~n" + &
"       custom_n1,~r~n" + &
"       custom_n2,~r~n" + &
"       custom_n3,~r~n" + &
"       custom_n4,~r~n" + &
"       custom_n5,~r~n" + &
"       custom_n6,~r~n" + &
"       custom_n7,~r~n" + &
"       custom_n8,~r~n" + &
"       custom_n9,~r~n" + &
"       custom_n10,~r~n" + &
"       custom_n11,~r~n" + &
"       custom_n12,~r~n" + &
"       custom_n13,~r~n" + &
"       custom_n14,~r~n" + &
"       custom_n15,~r~n" + &
"       custom_n16,~r~n" + &
"       custom_n17,~r~n" + &
"       custom_n18,~r~n" + &
"       custom_n19,~r~n" + &
"       custom_n20,~r~n" + &
"       custom_n21,~r~n" + &
"       custom_n22,~r~n" + &
"       custom_n23,~r~n" + &
"       custom_n24,~r~n" + &
"       custom_n25,~r~n" + &
"       custom_percent_1, custom_percent_2, " + &
"       custom_percent_3, custom_percent_4, custom_percent_5, custom_percent_6, custom_percent_7, custom_percent_9, custom_percent_10, " + &
"		  custom_percent_8, custom_21, custom_22, custom_n26, custom_n27, custom_date16, custom_date17" + &
"  FROM ctx_basic_info~r~n" //+ &
//"ORDER BY ctx_id"

//Alte view v_ctx_statusaudit add field name - jervis 04.20.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Alter VIEW v_ctx_stausaudit  " + &
"AS  " + &
"SELECT     a.ctx_id, a.seq_no, a.status, c.code AS status_code, c.description AS status_description, a.start_time, a.delay_days, a.user_id,a.field_name " + &
"FROM         sys_StatusAudit AS a LEFT OUTER JOIN  " + &
"             code_lookup AS c ON a.status = c.lookup_code " 





of_execute_sqls("of_ver100_release_view1")

Return 1

end function

public function integer of_ver105_release_table1 ();//Added By Ken.Guo 2010-03-26.
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if not exists(	select 1 from syscolumns c, sysobjects t   ~r~n" + &
//"where c.id=t.id  and c.name='is_moved' and t.name='em_sent_items'	and t.type = 'U')~r~n" + &
//"ALTER table em_sent_items add is_moved integer null "

//Add custom data 2 table - jervis 05.20.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_custom' )~r~n" + &
"CREATE TABLE ctx_custom( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	custom_1 varchar(255) NULL, ~r~n" + &
"	custom_2 varchar(255) NULL, ~r~n" + &
"	custom_3 varchar(255) NULL, ~r~n" + &
"	custom_4 varchar(255) NULL, ~r~n" + &
"	custom_5 varchar(255) NULL, ~r~n" + &
"	custom_6 varchar(255) NULL, ~r~n" + &
"	custom_7 varchar(255) NULL, ~r~n" + &
"	custom_8 varchar(255) NULL, ~r~n" + &
"	custom_9 varchar(255) NULL, ~r~n" + &
"	custom_10 varchar(255) NULL, ~r~n" + &
"	custom_11 varchar(255) NULL, ~r~n" + &
"	custom_12 varchar(255) NULL, ~r~n" + &
"	custom_13 varchar(255) NULL, ~r~n" + &
"	custom_14 varchar(255) NULL, ~r~n" + &
"	custom_15 varchar(255) NULL, ~r~n" + &
"	custom_16 varchar(255) NULL, ~r~n" + &
"	custom_17 varchar(255) NULL, ~r~n" + &
"	custom_18 varchar(255) NULL, ~r~n" + &
"	custom_19 varchar(255) NULL, ~r~n" + &
"	custom_20 varchar(255) NULL, ~r~n" + &
"	custom_date1 datetime NULL, ~r~n" + &
"	custom_date2 datetime NULL, ~r~n" + &
"	custom_date3 datetime NULL, ~r~n" + &
"	custom_date4 datetime NULL, ~r~n" + &
"	custom_date5 datetime NULL, ~r~n" + &
"	custom_date6 datetime NULL, ~r~n" + &
"	custom_date7 datetime NULL, ~r~n" + &
"	custom_date8 datetime NULL, ~r~n" + &
"	custom_date9 datetime NULL, ~r~n" + &
"	custom_date10 datetime NULL, ~r~n" + &
"	custom_date11 datetime NULL, ~r~n" + &
"	custom_date12 datetime NULL, ~r~n" + &
"	custom_date13 datetime NULL, ~r~n" + &
"	custom_date14 datetime NULL, ~r~n" + &
"	custom_date15 datetime NULL, ~r~n" + &
"	custom_n1 numeric(12, 2) NULL, ~r~n" + &
"	custom_n2 numeric(12, 2) NULL, ~r~n" + &
"	custom_n3 numeric(12, 2) NULL, ~r~n" + &
"	custom_n4 numeric(12, 2) NULL, ~r~n" + &
"	custom_n5 numeric(12, 2) NULL, ~r~n" + &
"	custom_n6 numeric(12, 2) NULL, ~r~n" + &
"	custom_n7 numeric(12, 2) NULL, ~r~n" + &
"	custom_n8 numeric(12, 2) NULL, ~r~n" + &
"	custom_n9 numeric(12, 2) NULL, ~r~n" + &
"	custom_n10 numeric(12, 2) NULL, ~r~n" + &
"	custom_n11 numeric(12, 2) NULL, ~r~n" + &
"	custom_n12 numeric(12, 2) NULL, ~r~n" + &
"	custom_n13 numeric(12, 2) NULL, ~r~n" + &
"	custom_n14 numeric(12, 2) NULL, ~r~n" + &
"	custom_n15 numeric(12, 2) NULL, ~r~n" + &
"	custom_n16 numeric(12, 2) NULL, ~r~n" + &
"	custom_n17 numeric(12, 2) NULL, ~r~n" + &
"	custom_n18 numeric(12, 2) NULL, ~r~n" + &
"	custom_n19 numeric(12, 2) NULL, ~r~n" + &
"	custom_n20 numeric(12, 2) NULL, ~r~n" + &
"	custom_n21 numeric(12, 2) NULL, ~r~n" + &
"	custom_n22 numeric(12, 2) NULL, ~r~n" + &
"	custom_n23 numeric(12, 2) NULL, ~r~n" + &
"	custom_n24 numeric(12, 2) NULL, ~r~n" + &
"	custom_n25 numeric(12, 2) NULL, ~r~n" + &
"	custom_21 varchar(255) NULL, ~r~n" + &
"	custom_22 varchar(255) NULL, ~r~n" + &
"	custom_notes_1 varchar(8000) NULL, ~r~n" + &
"	custom_notes_2 varchar(8000) NULL, ~r~n" + &
"	custom_notes_3 varchar(8000) NULL, ~r~n" + &
"	custom_notes_4 varchar(8000) NULL, ~r~n" + &
"	custom_notes_5 varchar(8000) NULL, ~r~n" + &
"	custom_money_1 money NULL, ~r~n" + &
"	custom_money_2 money NULL, ~r~n" + &
"	custom_money_3 money NULL, ~r~n" + &
"	custom_percent_1 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_2 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_3 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_4 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_5 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_6 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_7 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_8 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_9 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_10 numeric(12, 4) NULL, ~r~n" + &
"	CONSTRAINT pk_ctx_custom PRIMARY KEY(ctx_id)  ~r~n" + &
") ~r~n" 


//Added By Ken.Guo 2011-05-26.For Electronic Signature 
//For Support Module
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='esign' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add esign integer null  "

//For Application Sertifi API Code
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_apicode' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add es_apicode varchar(50) null  ~r~n" 

//For last refresh 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_last_refresh' and t.table_name='ids' ) " + &
"ALTER table ids add es_last_refresh datetime null  ~r~n" 

//For to do list of sertifi
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_added_tdl' and t.table_name='ids' ) " + &
"ALTER table ids add es_added_tdl integer null  ~r~n" 

//For Document Manager
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_apicode' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add es_apicode varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_fileid' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add es_fileid varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add es_docid varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_sender' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add es_sender varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_sender_email' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add es_sender_email varchar(100) null  ~r~n"

//For Document Manager Audit //Added By Ken.Guo 2011-06-13. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_apicode' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add es_apicode varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_fileid' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add es_fileid varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add es_docid varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_sender' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add es_sender varchar(50) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_sender_email' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add es_sender_email varchar(100) null  ~r~n"

//For Action Item
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_action_item' ) " + &
"ALTER table ctx_am_action_item add es_docid varchar(50) null  ~r~n" 

//Add custom id# in ids table -- jervis 06.02.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_id1' and t.table_name='ids' ) " + &
"alter table ids add custom_id1 int null" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_id2' and t.table_name='ids' ) " + &
"alter table ids add custom_id2 int null" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_id3' and t.table_name='ids' ) " + &
"alter table ids add custom_id3 int null" 

//Add custom fields - jervis 06.03.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_n1' and t.table_name='CTX_CONTRACT_CONTACTS' ) " + &
"ALTER TABLE CTX_CONTRACT_CONTACTS ~r~n" + &
"	ADD custom_n1 numeric(12, 2) NULL,~r~n" + &
"	ADD custom_n2 numeric(12, 2) NULL,~r~n" + &
"	ADD custom_n3 numeric(12, 2) NULL,~r~n" + &
"	ADD custom_percent_1 numeric(12, 4) NULL,~r~n" + &
"	ADD custom_percent_2 numeric(12, 4) NULL,~r~n" + &
"	ADD custom_1 varchar(255) NULL,~r~n" + &
"	ADD custom_2 varchar(255) NULL,~r~n" + &
"	ADD custom_3 varchar(255) NULL~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_custom_multi_hdr' )~r~n" + &
"CREATE TABLE dbo.ctx_custom_multi_hdr( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	hdr_id int NOT NULL, ~r~n" + &
"	custom_1 varchar(255) , ~r~n" + &
"	custom_2 varchar(255) , ~r~n" + &
"	custom_3 varchar(255) , ~r~n" + &
"	custom_4 varchar(255) , ~r~n" + &
"	custom_5 varchar(255) , ~r~n" + &
"	custom_6 varchar(255) , ~r~n" + &
"	custom_7 varchar(255) , ~r~n" + &
"	custom_8 varchar(255) , ~r~n" + &
"	custom_9 varchar(255) , ~r~n" + &
"	custom_10 varchar(255) , ~r~n" + &
"	custom_date1 datetime NULL, ~r~n" + &
"	custom_date2 datetime NULL, ~r~n" + &
"	custom_date3 datetime NULL, ~r~n" + &
"	custom_date4 datetime NULL, ~r~n" + &
"	custom_date5 datetime NULL, ~r~n" + &
"	custom_date6 datetime NULL, ~r~n" + &
"	custom_date7 datetime NULL, ~r~n" + &
"	custom_date8 datetime NULL, ~r~n" + &
"	custom_date9 datetime NULL, ~r~n" + &
"	custom_date10 datetime NULL, ~r~n" + &
"	custom_n1 numeric(12, 2) NULL, ~r~n" + &
"	custom_n2 numeric(12, 2) NULL, ~r~n" + &
"	custom_n3 numeric(12, 2) NULL, ~r~n" + &
"	custom_n4 numeric(12, 2) NULL, ~r~n" + &
"	custom_n5 numeric(12, 2) NULL, ~r~n" + &
"	custom_n6 numeric(12, 2) NULL, ~r~n" + &
"	custom_n7 numeric(12, 2) NULL, ~r~n" + &
"	custom_n8 numeric(12, 2) NULL, ~r~n" + &
"	custom_n9 numeric(12, 2) NULL, ~r~n" + &
"	custom_n10 numeric(12, 2) NULL, ~r~n" + &
"	custom_notes_1 varchar(8000) , ~r~n" + &
"	custom_notes_2 varchar(8000) , ~r~n" + &
"	custom_m1 money NULL DEFAULT ((0)), ~r~n" + &
"	custom_m2 money NULL DEFAULT ((0)), ~r~n" + &
"	custom_m3 money NULL DEFAULT ((0)), ~r~n" + &
"	custom_m4 money NULL DEFAULT ((0)), ~r~n" + &
"	custom_m5 money NULL DEFAULT ((0)), ~r~n" + &
"	custom_percent_1 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_2 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_3 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_4 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_5 numeric(12, 4) NULL, ~r~n" + &
" CONSTRAINT pk_ctx_custom_multi_hdr PRIMARY KEY (ctx_id,hdr_id) ~r~n" + &
") ~r~n" 


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_custom_multi_detail' )~r~n" + &
"CREATE TABLE dbo.ctx_custom_multi_detail( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	hdr_id int NOT NULL, ~r~n" + &
"	detail_id int NOT NULL, ~r~n" + &
"	custom_int1 int NULL, ~r~n" + &
"	custom_int2 int NULL, ~r~n" + &
"	custom_int3 int NULL, ~r~n" + &
"	custom_int4 int NULL, ~r~n" + &
"	custom_int5 int NULL, ~r~n" + &
"	custom_fee1 money NULL, ~r~n" + &
"	custom_fee2 money NULL, ~r~n" + &
"	custom_fee3 money NULL, ~r~n" + &
"	custom_fee4 money NULL, ~r~n" + &
"	custom_fee5 money NULL, ~r~n" + &
"	custom_1 varchar(255) , ~r~n" + &
"	custom_2 varchar(255) , ~r~n" + &
"	custom_3 varchar(255) , ~r~n" + &
"	custom_4 varchar(255) , ~r~n" + &
"	custom_5 varchar(255) , ~r~n" + &
"	custom_6 varchar(255) , ~r~n" + &
"	custom_7 varchar(255) , ~r~n" + &
"	custom_8 varchar(255) , ~r~n" + &
"	custom_9 varchar(255) , ~r~n" + &
"	custom_10 varchar(255) , ~r~n" + &
"	custom_date1 datetime NULL, ~r~n" + &
"	custom_date2 datetime NULL, ~r~n" + &
"	custom_date3 datetime NULL, ~r~n" + &
"	custom_date4 datetime NULL, ~r~n" + &
"	custom_date5 datetime NULL, ~r~n" + &
"	custom_n1 numeric(10, 3) NULL, ~r~n" + &
"	custom_n2 numeric(10, 3) NULL, ~r~n" + &
"	custom_n3 numeric(10, 3) NULL, ~r~n" + &
"	custom_n4 numeric(10, 3) NULL, ~r~n" + &
"	custom_n5 numeric(10, 3) NULL, ~r~n" + &
"	custom_percent_1 numeric(12, 4) NULL, ~r~n" + &
"	custom_percent_2 numeric(12, 4) NULL, ~r~n" + &
"	custom_notes_1 varchar(8000) , ~r~n" + &
" CONSTRAINT pk_ctx_custom_multi_detail PRIMARY KEY(	ctx_id ,hdr_id,detail_id) ~r~n" + &
") ~r~n"

//Added By Ken.Guo 2011-06-28. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='refresh_sertifi' and t.table_name='security_users' ) " + &
"ALTER table security_users add refresh_sertifi integer null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='refresh_sertifi_dm' and t.table_name='security_users' ) " + &
"ALTER table security_users add refresh_sertifi_dm integer null  "

//add by jervis 07.01.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_all_notification' )~r~n" + &
"CREATE TABLE ctx_all_notification( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	doc_id int not null, ~r~n" + &
"	level_id1 int NOT NULL, ~r~n" + &
"	level_id2 int not null, ~r~n" + &
"	alm_table varchar(40) , ~r~n" + &
"	alm_column varchar(40) , ~r~n" + &
"	alm_message varchar(255) , ~r~n" + &
"	alm_enabled char(1) , ~r~n" + &
"	alm_notification_days int NULL, ~r~n" + &
"	alm_last_notification_sent datetime NULL, ~r~n" + &
"	alm_post_notification_days int NULL, ~r~n" + &
"	alm_total_tries int NULL, ~r~n" + &
"	alm_action_item_posted int NULL, ~r~n" + &
"	alm_total_tries_counter int NULL, ~r~n" + &
"	alm_frequency int NULL, ~r~n" + &
"	create_action_item char(1) , ~r~n" + &
"	record_id numeric(10, 0) NOT NULL, ~r~n" + &
"	alm_auto_increment_years int NULL, ~r~n" + &
"	alm_action_title varchar(40) , ~r~n" + &
"	wf_id int NULL, ~r~n" + &
"	alm_auto_increment_unit char(1) , ~r~n" + &
"	alm_last_wf_trigger datetime NULL, ~r~n" + &
"	alm_email_template_id int NULL, ~r~n" + &
"	alm_message_blob image NULL, ~r~n" + &
"	alm_attachment_name varchar(100) , ~r~n" + &
"	alm_attachment image NULL, ~r~n" + &
"	alm_mailto varchar(2000) , ~r~n" + &
"	auto_sign varchar(1) , ~r~n" + &
"	alm_create varchar(2000) , ~r~n" + &
"	alm_subject varchar(255) , ~r~n" + &
"	alm_date datetime, ~r~n" + &
"CONSTRAINT pk_ctx_all_notification PRIMARY KEY (ctx_id ,doc_id,level_id1,level_id2,alm_table,alm_column) ~r~n" + &
")" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_all_alarm_attachment' )~r~n" + &
"CREATE TABLE ctx_all_alarm_attachment( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	doc_id int not null, ~r~n" + &
"	level_id1	int not null, ~r~n" + &
"	level_id2 int not null, ~r~n" + &
"	alm_table varchar(40) , ~r~n" + &
"	alm_column varchar(40) , ~r~n" + &
"	attach_id int NOT NULL, ~r~n" + &
"	alm_attachment_name varchar(100) , ~r~n" + &
"	alm_attachment image NULL, ~r~n" + &
" CONSTRAINT PK_ALL_ALARM_ATTACHMENT PRIMARY KEY (ctx_id,doc_id,level_id1,level_id2,	alm_table,alm_column,attach_id) ~r~n" + &
") " 


/*
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select 1 from sysobjects where name = 'ctx_all_notification_users' )~r~n" + &
"CREATE TABLE ctx_all_notification_users( ~r~n" + &
"	ctx_id int NOT NULL, ~r~n" + &
"	user_id varchar(10) , ~r~n" + &
"	alm_table varchar(40) , ~r~n" + &
"	alm_column varchar(40) , ~r~n" + &
"	doc_id int not null default 0, ~r~n" + &
"	level_id1	int not null default 0, ~r~n" + &
"	level_id2 int not null default 0, ~r~n" + &
"	record_id numeric(10, 0) NOT NULL, ~r~n" + &
" CONSTRAINT pk_ctx_all_notification_users PRIMARY KEY(ctx_id ,doc_id,level_id1,level_id2,user_id ,alm_table ,alm_column ) ~r~n" + &
")"
*/

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id1' and t.table_name='ctx_action_items' ) " + &
"alter table ctx_action_items add level_id1 int not null default 0"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id2' and t.table_name='ctx_action_items' ) " + &
"alter table ctx_action_items add level_id2 int not null default 0"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_id' and t.table_name='ctx_action_items' ) " + &
"alter table ctx_action_items add doc_id int not null default 0"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id1' and t.table_name='ctx_alm_snooze' ) " + &
"alter table ctx_alm_snooze add level_id1 int not null default 0"


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id2' and t.table_name='ctx_alm_snooze' ) " + &
"alter table ctx_alm_snooze add level_id2 int not null default 0"


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='doc_id' and t.table_name='ctx_alm_snooze' ) " + &
"alter table ctx_alm_snooze add doc_id int not null default 0"


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_date' and t.table_name='ctx_notification' ) " + &
"alter table ctx_notification add alm_date datetime null"

//add custom date fields in fee scheduce
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_date' and t.table_name='ctx_ai_notification' ) " + &
"alter table ctx_ai_notification add alm_date datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_date' and t.table_name='ctx_am_ai_notification' ) " + &
"alter table ctx_am_ai_notification add alm_date datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date1' and t.table_name='ctx_fee_sched_nm' ) " + &
"alter table ctx_fee_sched_nm add custom_date1 datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date2' and t.table_name='ctx_fee_sched_nm' ) " + &
"alter table ctx_fee_sched_nm add custom_date2 datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date3' and t.table_name='ctx_fee_sched_nm' ) " + &
"alter table ctx_fee_sched_nm add custom_date3 datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date4' and t.table_name='ctx_fee_sched_nm' ) " + &
"alter table ctx_fee_sched_nm add custom_date4 datetime null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='custom_date5' and t.table_name='ctx_fee_sched_nm' ) " + &
"alter table ctx_fee_sched_nm add custom_date5 datetime null"

//Added By Ken 08/15/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_subject' and t.table_name='ctx_notification_templates' ) " + &
"alter table ctx_notification_templates add alm_subject varchar(255) null"
 
//Added By Ken 08/20/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='suppress_alert' and t.table_name='wf_workflow' ) " + &
"ALTER table  wf_workflow add suppress_alert int null  ~r~n" 

//Added By Ken.Guo 2011-08-29.
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='filter_template' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add filter_template integer null  "

//Add tab visible - jervis 09.15.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tab_visible' and t.table_name='ctx_tabpage_properties' ) " + &
"alter table ctx_tabpage_properties add tab_visible char(1) default 'T' null"

//Added By Ken 09/22/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='smtp_ssl' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add smtp_ssl integer null  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='pop3_ssl' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add pop3_ssl integer null  "

//Added By Ken 09/29/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='check_email' and t.table_name='security_users' ) " + &
"ALTER table security_users add check_email integer null  " 

//Added By Jervis 10.11.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dw_opsql' and t.table_name='ctx_screen' ) " + &
"ALTER table ctx_screen add dw_opsql text null  " 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='use_opsyntax' and t.table_name='icred_settings' ) " + &
"ALTER TABLE icred_settings ADD	use_opsyntax int default 1 NULL"

//Added By Ken 10/18/2011. 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table conv_view_fields modify field_wizard_name varchar(255)"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table conv_view_fields modify field_alias varchar(255)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='fix_field' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add fix_field varchar(2000) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='lookup_list' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add lookup_list varchar(2000) null"

//Added By Ken.Guo 10/26/2011. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS(SELECT name  FROM sysobjects WHERE  name = 'ctx_am_image_approve'  AND ~t type = 'U')~r~n" + &
"~tCREATE TABLE ctx_am_image_approve~r~n" + &
"~t(~r~n" + &
"~tapprove_id numeric(10) not null,~r~n" + &
"~tCtx_id integer not null,~r~n" + &
"~tDoc_id integer not null,~r~n" + &
"~tRevision numeric(5,1) not null,~r~n" + &
"~tApprove_type varchar(20) null,~r~n" + &
"~tOrg_Image_file image null,~r~n" + &
"~tnew_file integer null,~r~n" + &
"~tfile_name varchar(100) null,~r~n" + &
"~tfile_size integer null,~r~n" + &
"~tfile_type varchar(50) null,~r~n" + &
"~tfile_path varchar(300) null,~r~n" + &
"~tsender_user varchar(50) null,~r~n" + &
"~tsender_email varchar(100) null, ~r~n" + &
"~temail_subject varchar(200) null, ~r~n" + &
"~temail_signature int null,~r~n" + &
"~tnotify_users varchar(2000) null, ~r~n" + &
"~tnotify_emails varchar(2000) null, ~r~n" + &
"~tnotify_users2 varchar(2000) null,  ~r~n" + &
"~tnotify_emails2 varchar(2000) null,  ~r~n" + &
"~tctx_link_name varchar(300) null,~t~r~n" + &
"~tsent_time datetime null,~r~n" + &
"~tsender_ai_id numeric(10) null,~r~n" + &
"~tReplied_email integer null,~r~n" + &
"~tflag int not null,~r~n" + &
"~tPrimary Key(approve_id,Doc_id,Revision)~r~n" + &
")" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS(SELECT name  FROM  sysobjects WHERE  name = 'ctx_am_image_approve_detail'  AND ~t type = 'U')~r~n" + &
"~tCREATE TABLE ctx_am_image_approve_detail~r~n" + &
"~t(~r~n" + &
"~tapprove_id numeric(10) not null,~r~n" + &
"~tDoc_id integer not null,~r~n" + &
"~tRevision numeric(5,1) not null,~r~n" + &
"~temail_address varchar(100) not null,~r~n" + &
"~temail_message varchar(8000) null,~r~n" + &
"~tweb_link_name varchar(300) null,~r~n" + &
"~tuser_id varchar(100) null,~r~n" + &
"~tcache_image_file image null,~r~n" + &
"~tNew_Image_file image null,~r~n" + &
"~tuser_order int not null,~r~n" + &
"~tsent_time datetime,~r~n" + &
"~tdownload_time datetime null,~t~r~n" + &
"~tupload_time datetime null,~r~n" + &
"~tsubmit_time datetime null,~r~n" + & 
"~tApprove_status int null,~r~n" + &
"~tcomments varchar(2000) null,~r~n" + &
"~tai_id numeric(10) null,~r~n" + &
"~tflag int null,~r~n" + &
"~tPrimary Key(approve_id,Doc_id,Revision,email_address,user_order)~r~n" + &
")" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS(SELECT name  FROM  sysobjects WHERE  name = 'ctx_am_image_approve_email_attach'  AND ~t type = 'U')~r~n" + &
"~tCREATE TABLE ctx_am_image_approve_email_attach~r~n" + &
"~t(~r~n" + &
"~tapprove_id numeric(10) not null,~r~n" + &
"~tseq_no integer  not null,~r~n" + &
"~tattach_name varchar(100) null,~r~n" + &
"~tattach_image image null,~r~n" + &
"~tPrimary Key(approve_id,seq_no)~r~n" + &
"~t)"

//Added By Ken.Guo 11/28/2011. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='notes' and t.table_name='ctx_action_items' ) " + &
"Alter Table ctx_action_items modify notes varchar(8000) null"

//For to do list of sertifi
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='webapprove_added_tdl' and t.table_name='ids' ) " + &
"ALTER table ids add webapprove_added_tdl integer null  ~r~n" 

//Added By Ken.Guo 12/05/2011.  for Web Approval Dcoument
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='approve_id' and t.table_name='ctx_am_action_item' ) " + &
"alter table ctx_am_action_item add approve_id numeric(10) null"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='approve_id' and t.table_name='ids' ) " + &
"ALTER table ids add approve_id numeric(10) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='approve_id' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add approve_id numeric(10) null  ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='approve_id' and t.table_name='ctx_am_doc_audit' ) " + &
"Alter table ctx_am_doc_audit add approve_id numeric(10) null ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tv_type' and t.table_name='ctx_user_tv_settings' ) " + &
"Alter table ctx_user_tv_settings add tv_type varchar(50) null ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='show_data' and t.table_name='ctx_user_tv_settings' ) " + &
"Alter table ctx_user_tv_settings add show_data integer null ~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"alter table em_mail_audit modify alarm_type varchar(100) null"

//added by gavin 2012-01-05
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='refresh_sertifi_time' and t.table_name='security_users' ) " + &
"  ALTER TABLE security_users ADD	refresh_sertifi_time int NULL "

is_sql_statements[upperbound(is_sql_statements) + 1] = &  
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='refresh_approve_time' and t.table_name='security_users' ) " + &
" ALTER TABLE security_users ADD 	refresh_approve_time int NULL "

//Added By Ken.Guo 01/17/2012. 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='view_id' and t.table_name='ctx_lookup_depend' ) " + &
"ALTER table ctx_lookup_depend add view_id numeric(10,0) null  " 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='screen_id' and t.table_name='ctx_lookup_depend' ) " + &
"ALTER table ctx_lookup_depend add screen_id numeric(10,0) null  " 


//added by gavin 2012-02-17
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS(SELECT name  FROM  sysobjects WHERE  name = 'security_user_options'  AND ~t type = 'U')~r~n" + &
"CREATE TABLE security_user_options~r~n" + &
"(~r~n" + &
"user_id varchar(50) not null,~r~n" + &
"option_name varchar(100)  not null,~r~n" + &
"option_value varchar(100) null,~r~n" + &
"last_update datetime null,~r~n" + &
"Primary Key(user_id,option_name)~r~n" + &
"~t)"


of_execute_sqls("of_ver105_release_table1")


Return 1

end function

public function integer of_ver105_release_trigger1 ();Return 1 

//add by jervis -- 07.08.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_custom_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_custom_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_custom_update on ctx_custom  ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(custom_date1) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date1 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date1' ~r~n" + &
"if update(custom_date2) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date2 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date2' ~r~n" + &
"if update(custom_date3) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date3 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date3' ~r~n" + &
"if update(custom_date4) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date4 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date4' ~r~n" + &
"if update(custom_date5) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date5 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date5' ~r~n" + &
"if update(custom_date6) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date6 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date6' ~r~n" + &
"if update(custom_date7) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date7 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date7' ~r~n" + &
"if update(custom_date8) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date8 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date8' ~r~n" + &
"if update(custom_date9) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date9 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date9' ~r~n" + &
"if update(custom_date10) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date10 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date10' ~r~n" + &
"if update(custom_date11) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date11 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date11' ~r~n" + &
"if update(custom_date12) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date12 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date12' ~r~n" + &
"if update(custom_date13) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date13 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date13' ~r~n" + &
"if update(custom_date14) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date14 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date14' ~r~n" + &
"if update(custom_date15) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date15 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_custom' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date15' ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_custom_multi_hdr_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_custom_multi_hdr_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_custom_multi_hdr_update on ctx_custom_multi_hdr  ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(custom_date1) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date1 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date1' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date2) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date2 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date2' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date3) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date3 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date3' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date4) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date4 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date4' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date5) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date5 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date5' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date6) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date6 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date6' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date7) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date7 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date7' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date8) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date8 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date8' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date9) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date9 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date9' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date10) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date10 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_hdr' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date10' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = 0 ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_custom_multi_detail_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_custom_multi_detail_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_custom_multi_detail_update on ctx_custom_multi_detail ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(custom_date1) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date1 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_detail' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date1' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = inserted.detail_id ~r~n" + &
"if update(custom_date2) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date2 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_detail' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date2' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = inserted.detail_id ~r~n" + &
"if update(custom_date3) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date3 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_detail' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date3' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = inserted.detail_id ~r~n" + &
"if update(custom_date4) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date4 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_detail' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date4' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = inserted.detail_id ~r~n" + &
"if update(custom_date5) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date5 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_custom_multi_detail' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date5' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.hdr_id and ctx_all_notification.level_id2 = inserted.detail_id ~r~n" 


is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_action_items_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_action_items_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_action_items_update on ctx_action_items ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(due_date) ~r~n" + &
"	update	ctx_ai_notification set ctx_ai_notification.alm_date = inserted.due_date from inserted  ~r~n" + &
"	where	ctx_ai_notification.ctx_id = inserted.ctx_id and ctx_ai_notification.alm_table = 'ctx_action_item' and  			 ~r~n" + &
"			ctx_ai_notification.alm_column = 'due_date' and ctx_ai_notification.ctx_action_item_id  = inserted.ctx_action_item_id ~r~n" + &
"if update(action_date) ~r~n" + &
"	update	ctx_ai_notification set ctx_ai_notification.alm_date = inserted.action_date from inserted  ~r~n" + &
"	where	ctx_ai_notification.ctx_id = inserted.ctx_id and ctx_ai_notification.alm_table = 'ctx_action_item' and  			 ~r~n" + &
"			ctx_ai_notification.alm_column = 'action_date' and ctx_ai_notification.ctx_action_item_id  = inserted.ctx_action_item_id ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_am_action_item_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_am_action_item_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_am_action_item_update on ctx_am_action_item ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(due_date) ~r~n" + &
"	update	ctx_am_ai_notification set ctx_am_ai_notification.alm_date = inserted.due_date from inserted  ~r~n" + &
"	where	ctx_am_ai_notification.doc_id = inserted.doc_id and ctx_am_ai_notification.alm_table = 'ctx_am_action_item' and  			 ~r~n" + &
"			ctx_am_ai_notification.alm_column = 'due_date' and ctx_am_ai_notification.seq_id  = inserted.seq_id ~r~n" + &
"if update(status_date) ~r~n" + &
"	update	ctx_am_ai_notification set ctx_am_ai_notification.alm_date = inserted.status_date from inserted  ~r~n" + &
"	where	ctx_am_ai_notification.doc_id = inserted.doc_id and ctx_am_ai_notification.alm_table = 'ctx_am_action_item' and  			 ~r~n" + &
"			ctx_am_ai_notification.alm_column = 'status_date' and ctx_am_ai_notification.seq_id  = inserted.seq_id ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_basic_info_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_basic_info_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_basic_info_update on ctx_basic_info  ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(custom_date1) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date1 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date1' ~r~n" + &
"if update(custom_date2) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date2 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date2' ~r~n" + &
"if update(custom_date3) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date3 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date3' ~r~n" + &
"if update(custom_date4) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date4 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date4' ~r~n" + &
"if update(custom_date5) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date5 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date5' ~r~n" + &
"if update(custom_date6) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date6 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date6' ~r~n" + &
"if update(custom_date7) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date7 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date7' ~r~n" + &
"if update(custom_date8) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date8 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date8' ~r~n" + &
"if update(custom_date9) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date9 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date9' ~r~n" + &
"if update(custom_date10) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date10 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date10' ~r~n" + &
"if update(custom_date11) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date11 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date11' ~r~n" + &
"if update(custom_date12) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date12 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date12' ~r~n" + &
"if update(custom_date13) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date13 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date13' ~r~n" + &
"if update(custom_date14) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date14 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date14' ~r~n" + &
"if update(custom_date15) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date15 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date15' ~r~n" + &
"if update(custom_date16) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date16 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date16' ~r~n" + &
"if update(custom_date17) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.custom_date17 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'custom_date17' ~r~n" + &
"if update(effective_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.effective_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'effective_date' ~r~n" + &
"if update(expriation_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.expriation_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'expriation_date' ~r~n" + &
"if update(review_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.review_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'review_date' ~r~n" + &
"if update(term_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.term_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'term_date' ~r~n" + &
"if update(other_date_1) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.other_date_1 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'other_date_1' ~r~n" + &
"if update(other_date_2) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.other_date_2 from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'other_date_2' ~r~n" + &
"if update(version_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.version_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'version_date' ~r~n" + &
"if update(last_revis_date) ~r~n" + &
"	update	ctx_notification set ctx_notification.alm_date = inserted.last_revis_date from inserted  ~r~n" + &
"	where	ctx_notification.ctx_id = inserted.ctx_id and ctx_notification.alm_table = 'ctx_basic_info' and   ~r~n" + &
"			ctx_notification.alm_column = 'last_revis_date' ~r~n" 

//add fee_sched_nm - jervis 08.03.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'tri_ctx_fee_sched_nm_update' and type = 'TR') ~r~n" + &
"	drop trigger tri_ctx_fee_sched_nm_update ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"create trigger tri_ctx_fee_sched_nm_update on ctx_fee_sched_nm  ~r~n" + &
"after update ~r~n" + &
"as ~r~n" + &
"if update(custom_date1) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date1 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_fee_sched_nm' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date1' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.fee_sched_nm_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date2) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date2 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_fee_sched_nm' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date2' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.fee_sched_nm_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date3) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date3 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_fee_sched_nm' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date3' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.fee_sched_nm_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date4) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date4 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_fee_sched_nm' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date4' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.fee_sched_nm_id and ctx_all_notification.level_id2 = 0 ~r~n" + &
"if update(custom_date5) ~r~n" + &
"	update	ctx_all_notification set ctx_all_notification.alm_date = inserted.custom_date5 from inserted  ~r~n" + &
"	where	ctx_all_notification.ctx_id = inserted.ctx_id and ctx_all_notification.alm_table = 'ctx_fee_sched_nm' and   ~r~n" + &
"			ctx_all_notification.alm_column = 'custom_date5' and ctx_all_notification.doc_id = 0 and ~r~n" + &
"			ctx_all_notification.level_id1 = inserted.fee_sched_nm_id and ctx_all_notification.level_id2 = 0 ~r~n"




of_execute_sqls("of_ver105_release_trigger1")

Return 1

end function

public function integer of_ver105_release_view1 ();//Modify by jervis -- 05.13.2010
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_custom') ~r~n" + &
" drop view v_ctx_custom"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_custom AS ~r~n" + &
"SELECT ~r~n" + &
"       ctx_id,~r~n" + &
"       custom_1,~r~n" + &
"       custom_2,~r~n" + &
"       custom_3,~r~n" + &
"       custom_4,~r~n" + &
"       custom_5,~r~n" + &
"       custom_6,~r~n" + &
"       custom_7,~r~n" + &
"       custom_8,~r~n" + &
"       custom_9,~r~n" + &
"       custom_10,~r~n" + &
"       custom_11,~r~n" + &
"       custom_12,~r~n" + &
"       custom_13,~r~n" + &
"       custom_14,~r~n" + &
"       custom_15,~r~n" + &
"       custom_16,~r~n" + &
"       custom_17,~r~n" + &
"       custom_18,~r~n" + &
"       custom_19,~r~n" + &
"       custom_20,~r~n" + &
"       custom_date1,~r~n" + &
"       custom_date2,~r~n" + &
"       custom_date3,~r~n" + &
"       custom_date4,~r~n" + &
"       custom_date5,~r~n" + &
"       custom_date6,~r~n" + &
"       custom_date7,~r~n" + &
"       custom_date8,~r~n" + &
"       custom_date9,~r~n" + &
"       custom_date10,~r~n" + &
"       custom_date11,~r~n" + &
"       custom_date12,~r~n" + &
"       custom_date13,~r~n" + &
"       custom_date14,~r~n" + &
"       custom_date15,~r~n" + &
"       custom_n1,~r~n" + &
"       custom_n2,~r~n" + &
"       custom_n3,~r~n" + &
"       custom_n4,~r~n" + &
"       custom_n5,~r~n" + &
"       custom_n6,~r~n" + &
"       custom_n7,~r~n" + &
"       custom_n8,~r~n" + &
"       custom_n9,~r~n" + &
"       custom_n10,~r~n" + &
"       custom_n11,~r~n" + &
"       custom_n12,~r~n" + &
"       custom_n13,~r~n" + &
"       custom_n14,~r~n" + &
"       custom_n15,~r~n" + &
"       custom_n16,~r~n" + &
"       custom_n17,~r~n" + &
"       custom_n18,~r~n" + &
"       custom_n19,~r~n" + &
"       custom_n20,~r~n" + &
"       custom_n21,~r~n" + &
"       custom_n22,~r~n" + &
"       custom_n23,~r~n" + &
"       custom_n24,~r~n" + &
"       custom_n25,~r~n" + &
"       custom_percent_1, custom_percent_2, " + &
"       custom_percent_3, custom_percent_4, custom_percent_5, custom_percent_6, custom_percent_7, custom_percent_9, custom_percent_10, " + &
"		  custom_percent_8, custom_21, custom_22, custom_n26, custom_n27, custom_date16, custom_date17," + &
"       ctx_basic_info.custom_notes_1,~r~n" + &
"       ctx_basic_info.custom_notes_2,~r~n" + &
"       ctx_basic_info.custom_notes_3,~r~n" + &
"       ctx_basic_info.custom_notes_4,~r~n" + &
"       ctx_basic_info.custom_notes_5~r~n" + &
"  FROM ctx_basic_info~r~n" //+ &
//"ORDER BY ctx_id"


//Added custom fields in ctx contract contact - jervis 06.03.2011
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='V_ctx_contract_contacts' and type = 'V')  " + &
"  drop view V_ctx_contract_contacts "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  V_ctx_contract_contacts " + &
"AS SELECT     contact_id,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS contact_phone,  " + &
"          (SELECT     TOP 1 contact_email  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code   " + &
"                                         FROM          code_lookup AS code_lookup_2  " + &
"                                        WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Email')  )) ) AS contact_email,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup AS code_lookup_1  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Fax') )) ) AS contact_Fax,   " + &
"          (SELECT     TOP 1 ext  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"           WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id)  AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS ext,   " + &
"            association, notes, owner, access, ctx_id, ic_area,default_email,  " + &
"				custom_n1,custom_n2,custom_n3,custom_percent_1,custom_percent_2,custom_1,custom_2,custom_3 " + &
"FROM         CTX_CONTRACT_CONTACTS  "


is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_contacts_external' and type = 'V')  " + &
"  drop view v_ctx_contacts_external "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_contacts_external AS~r~n" + &
"SELECT ~r~n" + &
"       CTX_BASIC_INFO.ctx_id,~r~n" + &
"       app_facility.facility_name,~r~n" + &
"       app_facility.contact as Company_Custom_ID#,~r~n" + &
"       code_lookup.code AS contact_type_code,~r~n" + &
"       code_lookup.description AS contact_type_description,~r~n" + &
"       CTX_CONTACTS.first_name,~r~n" + &
"       CTX_CONTACTS.last_name,~r~n" + &
"       CTX_CONTACTS.middle_name,~r~n" + &
"       code_lookup_4.description AS contact_title,~r~n" + &
"       code_lookup_1.code AS contract_department_code,~r~n" + &
"       code_lookup_1.description AS contract_department_des,~r~n" + &
"       app_facility.street,~r~n" + &
"       app_facility.street_2,~r~n" + &
"       app_facility.street_3,~r~n" + &
"       app_facility.city,~r~n" + &
"       app_facility.zip,~r~n" + &
"       app_facility.state,~r~n" + &
"       CTX_CONTACTS.custom_1,~r~n" + &
"       CTX_CONTACTS.custom_2,~r~n" + &
"       CTX_CONTACTS.custom_3,~r~n" + &
"       CTX_CONTACTS.custom_4,~r~n" + &
"       CTX_CONTACTS.custom_5,~r~n" + &
"       CTX_CONTACTS.custom_6,~r~n" + &
"       CTX_CONTACTS.custom_7,~r~n" + &
"       CTX_CONTACTS.custom_8,~r~n" + &
"       CTX_CONTACTS.custom_9,~r~n" + &
"       CTX_CONTACTS.custom_10,~r~n" + &
"       v_ctx_contract_contacts.access,~r~n" + &
"       v_ctx_contract_contacts.owner,~r~n" + &
"       v_ctx_contract_contacts.notes,~r~n" + &
"       v_ctx_contract_contacts.ext,~r~n" + &
"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
"       v_ctx_contract_contacts.contact_email,~r~n" + &
"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
"			v_ctx_contract_contacts.custom_n1,~r~n" + &
"			v_ctx_contract_contacts.custom_n2,~r~n" + &
"			v_ctx_contract_contacts.custom_n3,~r~n" + &
"			v_ctx_contract_contacts.custom_percent_1,~r~n" + &
"			v_ctx_contract_contacts.custom_percent_2,~r~n" + &
"			v_ctx_contract_contacts.custom_1 as contract_contact_custom_1,~r~n" + &
"			v_ctx_contract_contacts.custom_2 as contract_contact_custom_2,~r~n" + &
"			v_ctx_contract_contacts.custom_3 as contract_contact_custom_3,~r~n" + &
"       NULL AS Phone_Type_code,~r~n" + &
"       NULL AS Phone_type_Description,~r~n" + &
"       v_ctx_contract_contacts.contact_id,~r~n" + &
"       v_ctx_contract_contacts.default_email as default_to  ~r~n" + &
"  FROM CTX_CONTACTS~r~n" + &
"       INNER JOIN~r~n" + &
"       v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
"       INNER JOIN CTX_BASIC_INFO ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id~r~n" + &
"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
" WHERE v_ctx_contract_contacts.ic_area='e'~r~n" //+ &
//"ORDER BY CTX_BASIC_INFO.ctx_id"


//add ctx custom and multi view  by jervis -- 06.08.2011
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_multi_header') ~r~n" + &
" drop view v_ctx_multi_header"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_multi_header ~r~n" + &
"AS ~r~n" + &
"SELECT     ctx_id, hdr_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, custom_7, custom_8, custom_9, custom_10, custom_date1,  ~r~n" + &
"                      custom_date2, custom_date3, custom_date4, custom_date5, custom_date6, custom_date7, custom_date8, custom_date9, custom_date10, custom_n1,  ~r~n" + &
"                      custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7, custom_n8, custom_n9, custom_n10, custom_notes_1, custom_notes_2,  ~r~n" + &
"                      custom_m1, custom_m2, custom_m3, custom_m4, custom_m5, custom_percent_1, custom_percent_2, custom_percent_3, custom_percent_4,  ~r~n" + &
"                      custom_percent_5 ~r~n" + &
"FROM         ctx_custom_multi_hdr ~r~n"


is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_multi_detail') ~r~n" + &
" drop view v_ctx_multi_detail"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_multi_detail ~r~n" + &
"AS ~r~n" + &
"SELECT     ctx_id, hdr_id, detail_id, custom_int1, custom_int2, custom_int3, custom_int4, custom_int5, custom_fee1, custom_fee2, custom_fee3, custom_fee4,  ~r~n" + &
"                      custom_fee5, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, custom_7, custom_8, custom_9, custom_10, custom_date1,  ~r~n" + &
"                      custom_date2, custom_date3, custom_date4, custom_date5, custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_percent_1,  ~r~n" + &
"                      custom_percent_2, custom_notes_1 ~r~n" + &
"FROM         ctx_custom_multi_detail ~r~n" 


is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_ctx_custom2') ~r~n" + &
" drop view v_ctx_custom2"
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"CREATE VIEW v_ctx_custom2 ~r~n" + &
"AS ~r~n" + &
"SELECT     ctx_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, custom_7, custom_8, custom_9, custom_10, custom_11, custom_12,  ~r~n" + &
"                      custom_13, custom_14, custom_15, custom_16, custom_17, custom_18, custom_19, custom_20, custom_date1, custom_date2, custom_date3,  ~r~n" + &
"                      custom_date4, custom_date5, custom_date6, custom_date7, custom_date8, custom_date9, custom_date10, custom_date11, custom_date12,  ~r~n" + &
"                      custom_date13, custom_date14, custom_date15, custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7, custom_n8,  ~r~n" + &
"                      custom_n9, custom_n10, custom_n11, custom_n12, custom_n13, custom_n14, custom_n15, custom_n16, custom_n17, custom_n18, custom_n19,  ~r~n" + &
"                      custom_n20, custom_n21, custom_n22, custom_n23, custom_n24, custom_n25, custom_21, custom_22, custom_notes_1, custom_notes_2,  ~r~n" + &
"                      custom_notes_3, custom_notes_4, custom_notes_5, custom_money_1, custom_money_2, custom_money_3, custom_percent_1, custom_percent_2,  ~r~n" + &
"                      custom_percent_3, custom_percent_4, custom_percent_5, custom_percent_6, custom_percent_7, custom_percent_8, custom_percent_9,  ~r~n" + &
"                      custom_percent_10 ~r~n" + &
"FROM         ctx_custom ~r~n" 



of_execute_sqls("of_ver105_release_view1")

Return 1

end function

public function integer of_ver105_release_storeprocedure1 ();
////add by jervis 05.13.2011
////change numbers to words - jervis 05.26.2011
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'up_Num2Let' AND type = 'P') " + &
//"    DROP PROCEDURE up_Num2Let"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"CREATE Procedure up_Num2Let ~r~n" + &
//"	@Numero NUMERIC(20,2) ~r~n" + &
//"AS ~r~n" + &
//"BEGIN ~r~n" + &
//"	DECLARE @lnEntero INT, ~r~n" + &
//"	@lcRetorno VARCHAR(512), ~r~n" + &
//"	@lnTerna INT, ~r~n" + &
//"	@lcMiles VARCHAR(512), ~r~n" + &
//"	@lcCadena VARCHAR(512), ~r~n" + &
//"	@lnUnidades INT, ~r~n" + &
//"	@lnDecenas INT, ~r~n" + &
//"	@lnCentenas INT, ~r~n" + &
//"	@lnFraccion INT, ~r~n" + &
//"	@lnFrac1 varchar(2) ~r~n" + &
//"	SELECT @lnEntero = CAST(@Numero AS INT), ~r~n" + &
//"	@lnFraccion = (@Numero - @lnEntero) * 100, ~r~n" + &
//"	@lnFrac1 = case  ~r~n" + &
//"					when len(cast( @lnFraccion as varchar(2))) >1 then cast( @lnFraccion as varchar(2)) ~r~n" + &
//"					when len(cast( @lnFraccion as varchar(2))) =1 then '0'+cast( @lnFraccion as varchar(2)) ~r~n" + &
//"			   end, ~r~n" + &
//"	@lcRetorno = '', ~r~n" + &
//"	@lnTerna = 1 ~r~n" + &
//"	WHILE @lnEntero > 0 ~r~n" + &
//"	BEGIN ~r~n" + &
//"	SELECT @lcCadena = '' ~r~n" + &
//"	SELECT @lnUnidades = @lnEntero % 10 ~r~n" + &
//"	SELECT @lnEntero = CAST(@lnEntero/10 AS INT) ~r~n" + &
//"	SELECT @lnDecenas = @lnEntero % 10 ~r~n" + &
//"	SELECT @lnEntero = CAST(@lnEntero/10 AS INT) ~r~n" + &
//"	SELECT @lnCentenas = @lnEntero % 10 ~r~n" + &
//"	SELECT @lnEntero = CAST(@lnEntero/10 AS INT) ~r~n" + &
//"	SELECT @lcCadena = ~r~n" + &
//"	CASE ~r~n" + &
//"	WHEN @lnUnidades = 1 AND @lnTerna = 1 THEN 'Uno ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 1 AND @lnTerna <> 1 THEN 'Un ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 2 THEN 'Dos ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 3 THEN 'Tres ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 4 THEN 'Cuatro ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 5 THEN 'Cinco ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 6 THEN 'Seis ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 7 THEN 'Siete ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 8 THEN 'Ocho ' + @lcCadena ~r~n" + &
//"	WHEN @lnUnidades = 9 THEN 'Nueve ' + @lcCadena ~r~n" + &
//"	ELSE @lcCadena ~r~n" + &
//"	END ~r~n" + &
//"	SELECT @lcCadena = ~r~n" + &
//"	CASE ~r~n" + &
//"	WHEN @lnDecenas = 1 THEN ~r~n" + &
//"	CASE @lnUnidades ~r~n" + &
//"	WHEN 0 THEN 'Diez ' ~r~n" + &
//"	WHEN 1 THEN 'Once ' ~r~n" + &
//"	WHEN 2 THEN 'Doce ' ~r~n" + &
//"	WHEN 3 THEN 'Trece ' ~r~n" + &
//"	WHEN 4 THEN 'Catorce ' ~r~n" + &
//"	WHEN 5 THEN 'Quince ' ~r~n" + &
//"	ELSE 'Dieci' + @lcCadena ~r~n" + &
//"	END ~r~n" + &
//"	WHEN @lnDecenas = 2 AND @lnUnidades = 0 THEN 'Veinte ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 2 AND @lnUnidades <> 0 THEN 'Veinti' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 3 AND @lnUnidades = 0 THEN 'Treinta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 3 AND @lnUnidades <> 0 THEN 'Treinta y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 4 AND @lnUnidades = 0 THEN 'Cuarenta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 4 AND @lnUnidades <> 0 THEN 'Cuarenta y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 5 AND @lnUnidades = 0 THEN 'Cincuenta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 5 AND @lnUnidades <> 0 THEN 'Cincuenta y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 6 AND @lnUnidades = 0 THEN 'Sesenta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 6 AND @lnUnidades <> 0 THEN 'Sesenta y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 7 AND @lnUnidades = 0 THEN 'Setenta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 7 AND @lnUnidades <> 0 THEN 'Setenta Y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 8 AND @lnUnidades = 0 THEN 'Ochenta ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 8 AND @lnUnidades <> 0 THEN 'Ochenta y ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 9 AND @lnUnidades = 0 THEN 'Noventa ' + @lcCadena ~r~n" + &
//"	WHEN @lnDecenas = 9 AND @lnUnidades <> 0 THEN 'Noventa y ' + @lcCadena ~r~n" + &
//"	ELSE @lcCadena ~r~n" + &
//"	END ~r~n" + &
//"	SELECT @lcCadena = ~r~n" + &
//"	CASE ~r~n" + &
//"	WHEN @lnCentenas = 1 AND @lnUnidades = 0 AND @lnDecenas = 0 THEN 'Cien ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 1 AND NOT(@lnUnidades = 0 AND @lnDecenas = 0) THEN 'Ciento ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 2 THEN 'Doscientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 3 THEN 'Trescientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 4 THEN 'Cuatrocientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 5 THEN 'Quinientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 6 THEN 'Seiscientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 7 THEN 'Setecientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 8 THEN 'Ochocientos ' + @lcCadena ~r~n" + &
//"	WHEN @lnCentenas = 9 THEN 'Novecientos ' + @lcCadena ~r~n" + &
//"	ELSE @lcCadena ~r~n" + &
//"	END ~r~n" + &
//"	SELECT @lcCadena = ~r~n" + &
//"	CASE ~r~n" + &
//"	WHEN @lnTerna = 1 THEN @lcCadena ~r~n" + &
//"	WHEN @lnTerna = 2 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) THEN @lcCadena + ' Mil ' ~r~n" + &
//"	WHEN @lnTerna = 3 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) AND ~r~n" + &
//"	@lnUnidades = 1 AND @lnDecenas = 0 AND @lnCentenas = 0 THEN @lcCadena + ' Millon ' ~r~n" + &
//"	WHEN @lnTerna = 3 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) AND ~r~n" + &
//"	NOT (@lnUnidades = 1 AND @lnDecenas = 0 AND @lnCentenas = 0) THEN @lcCadena + ' Millones ' ~r~n" + &
//"	WHEN @lnTerna = 4 AND (@lnUnidades + @lnDecenas + @lnCentenas <> 0) THEN @lcCadena + ' Mil Millones ' ~r~n" + &
//"	ELSE '' ~r~n" + &
//"	END ~r~n" + &
//"	SELECT @lcRetorno = @lcCadena + @lcRetorno ~r~n" + &
//"	SELECT @lnTerna = @lnTerna + 1 ~r~n" + &
//"	END ~r~n" + &
//"	IF @lnTerna = 1 ~r~n" + &
//"	SELECT @lcRetorno = 'Cero' ~r~n" + &
//"	Select upper (RTRIM(@lcRetorno) + ' ' + LTRIM(@lnFrac1) + '/100') ~r~n" + &
//"END  ~r~n" 
//
////Modified By Ken.Guo 2011-06-30 --Add custom_21 ~ custom_date17
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'sp_contract_search' AND type = 'P') " + &
//"    DROP PROCEDURE sp_contract_search"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"CREATE  PROCEDURE sp_contract_search(  @user_d VARCHAR(10)   )~r~n" + &
//" AS    ~r~n" + &
//"BEGIN      ~r~n" + &
//"SELECT DISTINCT ~r~n" + &
//"	ctx_basic_info.app_facility,    ~r~n" + &
//"	ctx_products.product_id product_code,     ~r~n" + &
//"	code_lookup.code product_name,       ~r~n" + &
//"	ctx_basic_info.effective_date,      ~r~n" + &
//"	ctx_basic_info.expriation_date,       ~r~n" + &
//"	ctx_basic_info.status,     ~r~n" + &
//"	ctx_basic_info.group_multi_loc_id,       ~r~n" + &
//"	ctx_basic_info.ctx_id,~r~n" + &
//" 	ctx_basic_info.master_contract_id,                             ~r~n" + &
//"	master_cnt = (SELECT Count(ctx_basic_info1.ctx_id) ~r~n" + &
//"			FROM ctx_basic_info ctx_basic_info1 ~r~n" + &
//"			WHERE ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id and ctx_basic_info.is_template = 0 ),  ~r~n" + &
//"	ctx_basic_info.category,        ~r~n" + &
//"	ctx_basic_info.facility_id,     ~r~n" + &
//"	ctx_basic_info.contract_type,       ~r~n" + &
//"	code_lookup1.code product_type, ~r~n" + &
//"	ctx_basic_info.reimbursment_menth,       ~r~n" + &
//"	ctx_basic_info.file_location,    ~r~n" + &
//"	ctx_basic_info.review_date,       ~r~n" + &
//"	ctx_basic_info.review_by,     ~r~n" + &
//"	ctx_basic_info.term_date,       ~r~n" + &
//"	ctx_basic_info.term_reason,     ~r~n" + &
//"	ctx_basic_info.last_revis_date,       ~r~n" + &
//"	ctx_basic_info.other_date_1,       ~r~n" + &
//"	ctx_basic_info.other_date_2,     ~r~n" + &
//"	ctx_basic_info.oc_signed_by,       ~r~n" + &
//"	ctx_basic_info.oc_title,      ~r~n" + &
//"	ctx_basic_info.oc_department,       ~r~n" + &
//"	ctx_basic_info.oc_legal_rep,       ~r~n" + &
//"	ctx_basic_info.cc_signed_by,     ~r~n" + &
//"	ctx_basic_info.cc_title,       ~r~n" + &
//"	ctx_basic_info.cc_department,       ~r~n" + &
//"	ctx_basic_info.cc_legal_rep,     ~r~n" + &
//"	ctx_basic_info.notes,       ~r~n" + &
//"	ctx_basic_info.keyword,       ~r~n" + &
//"	ctx_basic_info.dvision,   ~r~n" + &
//"	ctx_basic_info.custom_1,       ~r~n" + &
//"	ctx_basic_info.custom_2,       ~r~n" + &
//"	ctx_basic_info.custom_3,       ~r~n" + &
//"	ctx_basic_info.custom_4,       ~r~n" + &
//"	ctx_basic_info.custom_5,     ~r~n" + &
//"	ctx_basic_info.custom_6,       ~r~n" + &
//"	ctx_basic_info.custom_7,       ~r~n" + &
//"	ctx_basic_info.custom_8, ~r~n" + &
//"	ctx_basic_info.custom_9,       ~r~n" + &
//"	ctx_basic_info.custom_10,    ~r~n" + &
//"	ctx_basic_info.group_id,~r~n" + &
//"	ctx_basic_info.revision_reason,       ~r~n" + &
//"	ctx_basic_info.record_id ,   ~r~n" + &
//"	owner = upper((SELECT top 1 ctx_contacts.user_d       ~r~n" + &
//"			FROM ctx_contacts,ctx_contract_contacts       ~r~n" + &
//"			WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) ~r~n" + &
//"			AND (ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
//"			  AND ( ctx_contract_contacts.owner = 'Y' ) ~r~n" + &
//"			  AND ( ctx_contract_contacts.ic_area = 'I' ) )),   ~r~n" + &
//"	contracted_entity = (SELECT top 1 group_multi_loc.rec_id              ~r~n" + &
//"	  			FROM ctx_loc,                  group_multi_loc              ~r~n" + &
//"				WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id) ~r~n" + &
//"				AND ( ctx_loc.ctx_id = ctx_basic_info.ctx_id) ~r~n" + &
//"				AND ctx_loc.loc_id = 0),    ~r~n" + &
//"	app_facility.facility_name facility_name,   ~r~n" + &
//"	ctx_basic_info.custom_date1,      ~r~n" + &
//"	ctx_basic_info.custom_date2,      ~r~n" + &
//"	ctx_basic_info.custom_date3,      ~r~n" + &
//"	ctx_basic_info.custom_date4,  ~r~n" + &
//"	ctx_basic_info.custom_date5,      ~r~n" + &
//"	ctx_basic_info.inserted_by_user,    ~r~n" + &
//"	ctx_basic_info.inserted_at_date_time,      ~r~n" + &
//"	ctx_basic_info.updated_by_user,   ~r~n" + &
//"	ctx_basic_info.~r~n" + &
//"	updated_at_date_time,      ~r~n" + &
//"	ctx_basic_info.custom_11,      ~r~n" + &
//"	ctx_basic_info.custom_12,   ~r~n" + &
//"	ctx_basic_info.custom_13,      ~r~n" + &
//"	ctx_basic_info.custom_14,      ~r~n" + &
//"	ctx_basic_info.custom_15,  ~r~n" + &
//"	ctx_basic_info.custom_16,      ~r~n" + &
//"	ctx_basic_info.custom_17,      ~r~n" + &
//"	ctx_basic_info.custom_18,      ~r~n" + &
//"	ctx_basic_info.custom_19,      ~r~n" + &
//"	ctx_basic_info.custom_20,     ~r~n" + &
//"	ctx_basic_info.custom_date6,      ~r~n" + &
//"	ctx_basic_info.custom_date7,      ~r~n" + &
//"	ctx_basic_info.custom_date8,  ~r~n" + &
//"	ctx_basic_info.custom_date9,      ~r~n" + &
//"	ctx_basic_info.custom_date10,      ~r~n" + &
//"	ctx_basic_info.custom_date11,      ~r~n" + &
//"	ctx_basic_info.custom_date12,      ~r~n" + &
//"	ctx_basic_info.custom_date13,  ~r~n" + &
//"	ctx_basic_info.custom_date14,      ~r~n" + &
//"	ctx_basic_info.custom_date15,      ~r~n" + &
//"	ctx_basic_info.custom_n1, ~r~n" + &
//"	ctx_basic_info.custom_n2,      ~r~n" + &
//"	ctx_basic_info.custom_n3,      ~r~n" + &
//"	ctx_basic_info.custom_n4,      ~r~n" + &
//"	ctx_basic_info.custom_n5,      ~r~n" + &
//"	ctx_basic_info.custom_n6,  ~r~n" + &
//"	ctx_basic_info.custom_n7,      ~r~n" + &
//"	ctx_basic_info.custom_n8,      ~r~n" + &
//"	ctx_basic_info.custom_n9,   ~r~n" + &
//"	ctx_basic_info.custom_n10,      ~r~n" + &
//"	ctx_basic_info.custom_n11,      ~r~n" + &
//"	ctx_basic_info.custom_n12,      ~r~n" + &
//"	ctx_basic_info.custom_n13,      ~r~n" + &
//"	ctx_basic_info.custom_n14,      ~r~n" + &
//"	ctx_basic_info.custom_n15,      ~r~n" + &
//"	ctx_basic_info.custom_n16,      ~r~n" + &
//"	ctx_basic_info.custom_n17,      ~r~n" + &
//"	ctx_basic_info.custom_n18,      ~r~n" + &
//"	ctx_basic_info.custom_n19,      ~r~n" + &
//"	ctx_basic_info.custom_n20,      ~r~n" + &
//"	ctx_basic_info.custom_n21,      ~r~n" + &
//"	ctx_basic_info.custom_n22,      ~r~n" + &
//"	ctx_basic_info.custom_n23,      ~r~n" + &
//"	ctx_basic_info.custom_n24,      ~r~n" + &
//"	ctx_basic_info.custom_n25,      ~r~n" + &
//"	ctx_basic_info.version_number,      ~r~n" + &
//"	ctx_basic_info.version_date,      ~r~n" + &
//"	ctx_basic_info.master_contract_name ,~r~n" + &
//"	ctx_basic_info.fee_sched_calc_field_1 ,~r~n" + &
//"	ctx_basic_info.fee_sched_calc_field_2 ,~r~n" + &
//"	ctx_basic_info.fee_sched_calc_field_3 ,~r~n" + &
//"	access = AA.access   ,~r~n" + &
//"	code_lookup2.code status_name,~r~n" + &
//"	code_lookup3.code category_name,~r~n" + &
//"	code_lookup4.code contract_type_name,~r~n" + &
//"	code_lookup5.code dvision_name ,~r~n" + &
//"	unread_email_cnt = 0, ~r~n" + &
//"	ctx_basic_info.custom_percent_1,~r~n" + &
//"	ctx_basic_info.custom_percent_2,~r~n" + &
//"	ctx_basic_info.custom_percent_3,~r~n" + &
//"	ctx_basic_info.custom_percent_4,~r~n" + &
//"	ctx_basic_info.custom_percent_5,~r~n" + &
//"	ctx_basic_info.custom_percent_6,~r~n" + &
//"	ctx_basic_info.custom_percent_7,~r~n" + &
//"	ctx_basic_info.custom_percent_8,~r~n" + &
//"	ctx_basic_info.custom_percent_9,~r~n" + &
//"	ctx_basic_info.custom_percent_10,~r~n" + &
//"	ctx_basic_info.work_flow_n1,~r~n" + &
//"	ctx_basic_info.work_flow_n2,~r~n" + &
//"	ctx_basic_info.work_flow_n3,~r~n" + &
//"	ctx_basic_info.work_flow_n4,~r~n" + &
//"	ctx_basic_info.work_flow_n5,~r~n" + &
//"	ctx_basic_info.custom_status1,~r~n" + &
//"	ctx_basic_info.custom_status2,~r~n" + &
//"	ctx_basic_info.custom_21,~r~n" + &
//"	ctx_basic_info.custom_22,~r~n" + &
//"	ctx_basic_info.custom_n26,~r~n" + &
//"	ctx_basic_info.custom_n27,~r~n" + &
//"	ctx_basic_info.custom_date16,~r~n" + &
//"	ctx_basic_info.custom_date17,~r~n" + &
//"	app_facility.city,~r~n" + &
//"	app_facility.state,~r~n" + &
//"	app_facility.country,~r~n" + &
//"	app_facility.zip,~r~n" + &
//"	app_facility.street~r~n" + &
//"FROM  ctx_basic_info  ~r~n" + &
//"LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id  ~r~n" + &
//"LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code  ~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code~r~n" + &
//"~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup2 ON ctx_basic_info.status = code_lookup2.lookup_code~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup3 ON ctx_basic_info.category = code_lookup3.lookup_code~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup4 ON ctx_basic_info.contract_type = code_lookup4.lookup_code~r~n" + &
//"LEFT OUTER JOIN code_lookup code_lookup5 ON ctx_basic_info.dvision = code_lookup5.lookup_code~r~n" + &
//"~r~n" + &
//"LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id, ~r~n" + &
//"(~r~n" + &
//"SELECT DISTINCT TOP 100 Percent  ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END)~r~n" + &
//"FROM ctx_contract_contacts Left Outer Join~r~n" + &
//"(~r~n" + &
//"Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d ~r~n" + &
//"From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1~r~n" + &
//"Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = @user_d~r~n" + &
//"Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d~r~n" + &
//"Having Count(ctx_contract_contacts1.ctx_id) > 1~r~n" + &
//") ccc~r~n" + &
//"On ctx_contract_contacts.ctx_id = ccc.ctx_id~r~n" + &
//",ctx_contacts~r~n" + &
//"WHERE ctx_contacts.user_d = @user_d~r~n" + &
//"	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' )~r~n" + &
//"	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id ~r~n" + &
//"	AND ( ctx_contract_contacts.access IN ('F','R') ~r~n" + &
//"	OR ctx_contract_contacts.owner = 'Y' )~r~n" + &
//"	AND ctx_contract_contacts.ic_area = 'I'~r~n" + &
//"~r~n" + &
//"UNION ~r~n" + &
//"~r~n" + &
//"SELECT DISTINCT TOP 100 Percent ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access~r~n" + &
//"FROM ~r~n" + &
//"ctx_group_access ,~r~n" + &
//"security_group_users,~r~n" + &
//"icred_settings~r~n" + &
//"WHERE	security_group_users.user_id = @user_d~r~n" + &
//"	AND ctx_group_access.group_id = security_group_users.group_id~r~n" + &
//"	AND ctx_group_access.access = ~r~n" + &
//"		(Case When Exists (Select u1.user_id,a1.ctx_id,a1.access ~r~n" + &
//"		From ctx_group_access a1,security_group_users u1~r~n" + &
//"		Where a1.group_id = u1.group_id ~r~n" + &
//"		And a1.ctx_id = ctx_group_access.ctx_id~r~n" + &
//"		And u1.user_id = security_group_users.user_id	~r~n" + &
//"		And a1.access = 'F') Then 'F' Else 'R' End) ~r~n" + &
//"	AND icred_settings.group_access = 1~r~n" + &
//"	AND ctx_group_access.access in ('F','R')~r~n" + &
//"	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"			AND ( ctx_contacts.user_d = security_group_users.user_id )~r~n" + &
//"			AND ( ctx_contract_contacts.ic_area = 'I' )~r~n" + &
//"			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id )~r~n" + &
//"			)~r~n" + &
//"~r~n" + &
//"UNION~r~n" + &
//"~r~n" + &
//"SELECT DISTINCT TOP 100 Percent ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END)~r~n" + &
//"FROM ctx_acp_contract_management_right, security_users, ctx_basic_info~r~n" + &
//"WHERE security_users.user_id = @user_d~r~n" + &
//"	AND ctx_acp_contract_management_right.types = 1~r~n" + &
//"	AND ctx_acp_contract_management_right.role_id = security_users.role_id~r~n" + &
//"	AND ctx_acp_contract_management_right.category = ctx_basic_info.category~r~n" + &
//"  And ctx_basic_info.is_template = 0 ~r~n" + &
//"	AND ctx_acp_contract_management_right.rights In ('11','12')~r~n" + &
//"	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts  ~r~n" + &
//"			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id ) ~r~n" + &
//"			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I') ~r~n" + &
//"			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + &
//"			UNION~r~n" + &
//"			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings~r~n" + &
//"			WHERE icred_settings.group_access = 1~r~n" + &
//"			AND (ctx_group_access.group_id = security_group_users.group_id )~r~n" + &
//"			AND ( security_group_users.user_id = security_users.user_id )	~r~n" + &
//"			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id )~r~n" + &
//"			)~r~n" + &
//") AA ~r~n" + &
//"WHERE ctx_basic_info.ctx_id = AA.ctx_id and ctx_basic_info.is_template = 0 ~r~n" + &
//"ORDER BY ctx_basic_info.master_contract_id Asc, ctx_basic_info.ctx_id  Asc    ~r~n" + &
//"END"
//

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists (SELECT name FROM sysobjects WHERE name = 'up_get_cachelist' AND type = 'P') " + &
"    DROP PROCEDURE up_get_cachelist"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"create procedure up_get_cachelist~r~n" + &
"as~r~n" + &
	"SELECT TOP 8000 screen_id = IDENTITY(1) INTO #t FROM sys.syscolumn a, sys.syscolumn b " + &
	"SELECT distinct lookup_list= SUBSTRING(A.lookup_list, B.screen_id, CHARINDEX(',', SUBSTRING(A.lookup_list +',', B.screen_id, 8000)) - 1) " + &
	" FROM ctx_screen A, #t B " + &
	" WHERE SUBSTRING(',' + A.lookup_list, B.screen_id, 1) = ',' and lookup_list <> '?' and lookup_list is not null and A.Screen_id <= 2  " + &
 	" order by lookup_list "+ &
	"DROP TABLE #t"

of_execute_sqls("of_ver105_release_storeprocedure1")

Return 1
end function

public function integer of_ver110_release_storeprocedure1 ();
//Add SQL Here
//added by gavins 20120227
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists (SELECT name FROM sysobjects WHERE name = 'sp_contract_search' AND type = 'P') " + &
"    DROP PROCEDURE sp_contract_search"

//added by gavins 20120227
//Modified By Ken.Guo 06/14/2012. Added Has_docs field.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" CREATE  PROCEDURE sp_contract_search ( @user_d VARCHAR(10)   ) ~r~n" + & 
"  AS     ~r~n" +  & 
" BEGIN       ~r~n" + & 
" SELECT DISTINCT  ~r~n" + & 
" 	ctx_basic_info.app_facility,     ~r~n" + & 
" 	ctx_products.product_id product_code,      ~r~n" + & 
" 	code_lookup.code product_name,        ~r~n" + & 
" 	ctx_basic_info.effective_date,       ~r~n" + & 
" 	ctx_basic_info.expriation_date,        ~r~n" + & 
" 	ctx_basic_info.status,      ~r~n" + & 
" 	ctx_basic_info.group_multi_loc_id,        ~r~n" + & 
" 	ctx_basic_info.ctx_id, ~r~n" + & 
"  	ctx_basic_info.master_contract_id,                              ~r~n" + & 
" 	master_cnt = (SELECT Count(ctx_basic_info1.ctx_id)  ~r~n" + & 
" 			FROM ctx_basic_info ctx_basic_info1  ~r~n" + & 
" 			WHERE ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id and ctx_basic_info.is_template = 0 ),   ~r~n" + & 
" 	ctx_basic_info.category,         ~r~n" + & 
" 	ctx_basic_info.facility_id,      ~r~n" + & 
" 	ctx_basic_info.contract_type,        ~r~n" + & 
" 	code_lookup1.code product_type,  ~r~n" + & 
" 	ctx_basic_info.reimbursment_menth,        ~r~n" + & 
" 	ctx_basic_info.file_location,     ~r~n" + & 
" 	ctx_basic_info.review_date,        ~r~n" + & 
" 	ctx_basic_info.review_by,      ~r~n" + & 
" 	ctx_basic_info.term_date,        ~r~n" + & 
" 	ctx_basic_info.term_reason,      ~r~n" + & 
" 	ctx_basic_info.last_revis_date,        ~r~n" + & 
" 	ctx_basic_info.other_date_1,        ~r~n" + & 
" 	ctx_basic_info.other_date_2,      ~r~n" + & 
" 	ctx_basic_info.oc_signed_by,        ~r~n" + & 
" 	ctx_basic_info.oc_title,       ~r~n" + & 
" 	ctx_basic_info.oc_department,        ~r~n" + & 
" 	ctx_basic_info.oc_legal_rep,        ~r~n" + & 
" 	ctx_basic_info.cc_signed_by,      ~r~n" + & 
" 	ctx_basic_info.cc_title,        ~r~n" + & 
" 	ctx_basic_info.cc_department,        ~r~n" + & 
" 	ctx_basic_info.cc_legal_rep,      ~r~n" + & 
" 	ctx_basic_info.notes,        ~r~n" + & 
" 	ctx_basic_info.keyword,        ~r~n" + & 
" 	ctx_basic_info.dvision,    ~r~n" + & 
" 	ctx_basic_info.custom_1,        ~r~n" + & 
" 	ctx_basic_info.custom_2,        ~r~n" + & 
" 	ctx_basic_info.custom_3,        ~r~n" + & 
" 	ctx_basic_info.custom_4,        ~r~n" + & 
" 	ctx_basic_info.custom_5,      ~r~n" + & 
" 	ctx_basic_info.custom_6,        ~r~n" + & 
" 	ctx_basic_info.custom_7,        ~r~n" + & 
" 	ctx_basic_info.custom_8,  ~r~n" + & 
" 	ctx_basic_info.custom_9,        ~r~n" + & 
" 	ctx_basic_info.custom_10,     ~r~n" + & 
" 	ctx_basic_info.group_id, ~r~n" + & 
" 	ctx_basic_info.revision_reason,        ~r~n" + & 
" 	ctx_basic_info.record_id ,    ~r~n" + & 
" 	owner = upper((SELECT top 1 ctx_contacts.user_d        ~r~n" + & 
" 			FROM ctx_contacts,ctx_contract_contacts        ~r~n" + & 
" 			WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )  ~r~n" + & 
" 			AND (ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id )  ~r~n" + & 
" 			  AND ( ctx_contract_contacts.owner = 'Y' )  ~r~n" + & 
" 			  AND ( ctx_contract_contacts.ic_area = 'I' ) )),    ~r~n" + & 
" 	contracted_entity = (SELECT top 1 group_multi_loc.rec_id               ~r~n" + & 
" 	  			FROM ctx_loc,                  group_multi_loc               ~r~n" + & 
" 				WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id)  ~r~n" + & 
" 				AND ( ctx_loc.ctx_id = ctx_basic_info.ctx_id)  ~r~n" + & 
" 				AND ctx_loc.loc_id = 0),     ~r~n" + & 
" 	app_facility.facility_name facility_name,    ~r~n" + & 
" 	ctx_basic_info.custom_date1,       ~r~n" + & 
" 	ctx_basic_info.custom_date2,       ~r~n" + & 
" 	ctx_basic_info.custom_date3,       ~r~n" + & 
" 	ctx_basic_info.custom_date4,   ~r~n" + & 
" 	ctx_basic_info.custom_date5,       ~r~n" + & 
" 	ctx_basic_info.inserted_by_user,     ~r~n" + & 
" 	ctx_basic_info.inserted_at_date_time,       ~r~n" + & 
" 	ctx_basic_info.updated_by_user,    ~r~n" + & 
" 	ctx_basic_info. ~r~n" + & 
" 	updated_at_date_time,       ~r~n" + & 
" 	ctx_basic_info.custom_11,       ~r~n" + & 
" 	ctx_basic_info.custom_12,    ~r~n" + & 
" 	ctx_basic_info.custom_13,       ~r~n" + & 
" 	ctx_basic_info.custom_14,       ~r~n" + & 
" 	ctx_basic_info.custom_15,   ~r~n" + & 
" 	ctx_basic_info.custom_16,       ~r~n" + & 
" 	ctx_basic_info.custom_17,       ~r~n" + & 
" 	ctx_basic_info.custom_18,       ~r~n" + & 
" 	ctx_basic_info.custom_19,       ~r~n" + & 
" 	ctx_basic_info.custom_20,      ~r~n" + & 
" 	ctx_basic_info.custom_date6,       ~r~n" + & 
" 	ctx_basic_info.custom_date7,       ~r~n" + & 
" 	ctx_basic_info.custom_date8,   ~r~n" + & 
" 	ctx_basic_info.custom_date9,       ~r~n" + & 
" 	ctx_basic_info.custom_date10,       ~r~n" + & 
" 	ctx_basic_info.custom_date11,       ~r~n" + & 
" 	ctx_basic_info.custom_date12,       ~r~n" + & 
" 	ctx_basic_info.custom_date13,   ~r~n" + & 
" 	ctx_basic_info.custom_date14,       ~r~n" + & 
" 	ctx_basic_info.custom_date15,       ~r~n" + & 
" 	ctx_basic_info.custom_n1,  ~r~n" + & 
" 	ctx_basic_info.custom_n2,       ~r~n" + & 
" 	ctx_basic_info.custom_n3,       ~r~n" + & 
" 	ctx_basic_info.custom_n4,       ~r~n" + & 
" 	ctx_basic_info.custom_n5,       ~r~n" + & 
" 	ctx_basic_info.custom_n6,   ~r~n" + & 
" 	ctx_basic_info.custom_n7,       ~r~n" + & 
" 	ctx_basic_info.custom_n8,       ~r~n" + & 
" 	ctx_basic_info.custom_n9,    ~r~n" + & 
" 	ctx_basic_info.custom_n10,       ~r~n" + & 
" 	ctx_basic_info.custom_n11,       ~r~n" + & 
" 	ctx_basic_info.custom_n12,       ~r~n" + & 
" 	ctx_basic_info.custom_n13,       ~r~n" + & 
" 	ctx_basic_info.custom_n14,       ~r~n" + & 
" 	ctx_basic_info.custom_n15,       ~r~n" + & 
" 	ctx_basic_info.custom_n16,       ~r~n" + & 
" 	ctx_basic_info.custom_n17,       ~r~n" + & 
" 	ctx_basic_info.custom_n18,       ~r~n" + & 
" 	ctx_basic_info.custom_n19,       ~r~n" + & 
" 	ctx_basic_info.custom_n20,       ~r~n" + & 
" 	ctx_basic_info.custom_n21,       ~r~n" + & 
" 	ctx_basic_info.custom_n22,       ~r~n" + & 
" 	ctx_basic_info.custom_n23,       ~r~n" + & 
" 	ctx_basic_info.custom_n24,       ~r~n" + & 
" 	ctx_basic_info.custom_n25,       ~r~n" + & 
" 	ctx_basic_info.version_number,       ~r~n" + & 
" 	ctx_basic_info.version_date,       ~r~n" + & 
" 	ctx_basic_info.master_contract_name , ~r~n" + & 
" 	ctx_basic_info.fee_sched_calc_field_1 , ~r~n" + & 
" 	ctx_basic_info.fee_sched_calc_field_2 , ~r~n" + & 
" 	ctx_basic_info.fee_sched_calc_field_3 , ~r~n" + & 
" 	access = AA.access   , ~r~n" + & 
" 	code_lookup2.code status_name, ~r~n" + & 
" 	code_lookup3.code category_name, ~r~n" + & 
" 	code_lookup4.code contract_type_name, ~r~n" + & 
" 	code_lookup5.code dvision_name , ~r~n" + & 
" 	unread_email_cnt = 0,  ~r~n" + & 
" 	ctx_basic_info.custom_percent_1, ~r~n" + & 
" 	ctx_basic_info.custom_percent_2, ~r~n" + & 
" 	ctx_basic_info.custom_percent_3, ~r~n" + & 
" 	ctx_basic_info.custom_percent_4, ~r~n" + & 
" 	ctx_basic_info.custom_percent_5, ~r~n" + & 
" 	ctx_basic_info.custom_percent_6, ~r~n" + & 
" 	ctx_basic_info.custom_percent_7, ~r~n" + & 
" 	ctx_basic_info.custom_percent_8, ~r~n" + & 
" 	ctx_basic_info.custom_percent_9, ~r~n" + & 
" 	ctx_basic_info.custom_percent_10, ~r~n" + & 
" 	ctx_basic_info.work_flow_n1, ~r~n" + & 
" 	ctx_basic_info.work_flow_n2, ~r~n" + & 
" 	ctx_basic_info.work_flow_n3, ~r~n" + & 
" 	ctx_basic_info.work_flow_n4, ~r~n" + & 
" 	ctx_basic_info.work_flow_n5, ~r~n" + & 
" 	ctx_basic_info.custom_status1, ~r~n" + & 
" 	ctx_basic_info.custom_status2, ~r~n" + & 
" 	ctx_basic_info.custom_21, ~r~n" + & 
" 	ctx_basic_info.custom_22, ~r~n" + & 
" 	ctx_basic_info.custom_n26, ~r~n" + & 
" 	ctx_basic_info.custom_n27, ~r~n" + & 
" 	ctx_basic_info.custom_date16, ~r~n" + & 
" 	ctx_basic_info.custom_date17, ~r~n" + & 
" 	app_facility.city, ~r~n" + & 
" 	app_facility.state, ~r~n" + & 
" 	app_facility.country, ~r~n" + & 
" 	app_facility.zip, ~r~n" + & 
" 	app_facility.street, ~r~n" + & 
" 	  ctx_custom.custom_1 as custom2_custom_1,   ~r~n" + & 
"          ctx_custom.custom_2 as custom2_custom_2,    ~r~n" + & 
"          ctx_custom.custom_3 as custom2_custom_3,    ~r~n" + & 
"          ctx_custom.custom_4 as custom2_custom_4,    ~r~n" + & 
"          ctx_custom.custom_5 as custom2_custom_5,    ~r~n" + & 
"          ctx_custom.custom_6 as custom2_custom_6,    ~r~n" + & 
"          ctx_custom.custom_7 as custom2_custom_7,    ~r~n" + & 
"          ctx_custom.custom_8 as custom2_custom_8,    ~r~n" + & 
"          ctx_custom.custom_9 as custom2_custom_9,    ~r~n" + & 
"          ctx_custom.custom_10 as custom2_custom_10,    ~r~n" + & 
"          ctx_custom.custom_11 as custom2_custom_11,    ~r~n" + & 
"          ctx_custom.custom_12 as custom2_custom_12,    ~r~n" + & 
"          ctx_custom.custom_13 as custom2_custom_13,    ~r~n" + & 
"          ctx_custom.custom_14 as custom2_custom_14,    ~r~n" + & 
"          ctx_custom.custom_15 as custom2_custom_15,    ~r~n" + & 
"          ctx_custom.custom_16 as custom2_custom_16,    ~r~n" + & 
"          ctx_custom.custom_17 as custom2_custom_17,    ~r~n" + & 
"          ctx_custom.custom_18 as custom2_custom_18,    ~r~n" + & 
"          ctx_custom.custom_19 as custom2_custom_19,    ~r~n" + & 
"          ctx_custom.custom_20 as custom2_custom_20,    ~r~n" + & 
"          ctx_custom.custom_date1 as custom2_custom_date1,    ~r~n" + & 
"          ctx_custom.custom_date2 as custom2_custom_date2,    ~r~n" + & 
"          ctx_custom.custom_date3 as custom2_custom_date3,    ~r~n" + & 
"          ctx_custom.custom_date4 as custom2_custom_date4,    ~r~n" + & 
"          ctx_custom.custom_date5 as custom2_custom_date5,    ~r~n" + & 
"          ctx_custom.custom_date6 as custom2_custom_date6,    ~r~n" + & 
"          ctx_custom.custom_date7 as custom2_custom_date7,    ~r~n" + & 
"          ctx_custom.custom_date8 as custom2_custom_date8,    ~r~n" + & 
"          ctx_custom.custom_date9 as custom2_custom_date9,    ~r~n" + & 
"          ctx_custom.custom_date10 as custom2_custom_date10,    ~r~n" + & 
"          ctx_custom.custom_date11 as custom2_custom_date11,    ~r~n" + & 
"          ctx_custom.custom_date12 as custom2_custom_date12,    ~r~n" + & 
"          ctx_custom.custom_date13 as custom2_custom_date13,    ~r~n" + & 
"          ctx_custom.custom_date14 as custom2_custom_date14,    ~r~n" + & 
"          ctx_custom.custom_date15 as custom2_custom_date15,    ~r~n" + & 
"          ctx_custom.custom_n1 as custom2_custom_n1,    ~r~n" + & 
"          ctx_custom.custom_n2 as custom2_custom_n2,    ~r~n" + & 
"          ctx_custom.custom_n3 as custom2_custom_n3,    ~r~n" + & 
"          ctx_custom.custom_n4 as custom2_custom_n4,    ~r~n" + & 
"          ctx_custom.custom_n5 as custom2_custom_n5,    ~r~n" + & 
"          ctx_custom.custom_n6 as custom2_custom_n6,    ~r~n" + & 
"          ctx_custom.custom_n7 as custom2_custom_n7,    ~r~n" + & 
"          ctx_custom.custom_n8 as custom2_custom_n8,    ~r~n" + & 
"          ctx_custom.custom_n9 as custom2_custom_n9,    ~r~n" + & 
"          ctx_custom.custom_n10 as custom2_custom_n10,    ~r~n" + & 
"          ctx_custom.custom_n11 as custom2_custom_n11,    ~r~n" + & 
"          ctx_custom.custom_n12 as custom2_custom_n12,    ~r~n" + & 
"          ctx_custom.custom_n13 as custom2_custom_n13,    ~r~n" + & 
"          ctx_custom.custom_n14 as custom2_custom_n14,    ~r~n" + & 
"          ctx_custom.custom_n15 as custom2_custom_n15,    ~r~n" + & 
"          ctx_custom.custom_n16 as custom2_custom_n16,    ~r~n" + & 
"          ctx_custom.custom_n17 as custom2_custom_n17,    ~r~n" + & 
"          ctx_custom.custom_n18 as custom2_custom_n18,    ~r~n" + & 
"          ctx_custom.custom_n19 as custom2_custom_n19,    ~r~n" + & 
"          ctx_custom.custom_n20 as custom2_custom_n20,    ~r~n" + & 
"          ctx_custom.custom_n21 as custom2_custom_n21,    ~r~n" + & 
"          ctx_custom.custom_n22 as custom2_custom_n22,    ~r~n" + & 
"          ctx_custom.custom_n23 as custom2_custom_n23,    ~r~n" + & 
"          ctx_custom.custom_n24 as custom2_custom_n24,    ~r~n" + & 
"          ctx_custom.custom_n25 as custom2_custom_n25,    ~r~n" + & 
"          ctx_custom.custom_21 as custom2_custom_21,    ~r~n" + & 
"          ctx_custom.custom_22 as custom2_custom_22,    ~r~n" + & 
"          ctx_custom.custom_notes_1 as custom2_custom_notes_1,    ~r~n" + & 
"          ctx_custom.custom_notes_2 as custom2_custom_notes_2,    ~r~n" + & 
"          ctx_custom.custom_notes_3 as custom2_custom_notes_3,    ~r~n" + & 
"          ctx_custom.custom_notes_4 as custom2_custom_notes_4,    ~r~n" + & 
"          ctx_custom.custom_notes_5 as custom2_custom_notes_5,    ~r~n" + & 
"          ctx_custom.custom_money_1 as custom2_custom_money_1,    ~r~n" + & 
"          ctx_custom.custom_money_2 as custom2_custom_money_2,    ~r~n" + & 
"          ctx_custom.custom_money_3 as custom2_custom_money_3,    ~r~n" + & 
"          ctx_custom.custom_percent_1 as custom2_custom_percent_1,    ~r~n" + & 
"          ctx_custom.custom_percent_2 as custom2_custom_percent_2,    ~r~n" + & 
"          ctx_custom.custom_percent_3 as custom2_custom_percent_3,    ~r~n" + & 
"          ctx_custom.custom_percent_4 as custom2_custom_percent_4,    ~r~n" + & 
"          ctx_custom.custom_percent_5 as custom2_custom_percent_5,    ~r~n" + & 
"          ctx_custom.custom_percent_6 as custom2_custom_percent_6,    ~r~n" + & 
"          ctx_custom.custom_percent_7 as custom2_custom_percent_7,    ~r~n" + & 
"          ctx_custom.custom_percent_8 as custom2_custom_percent_8,    ~r~n" + & 
"          ctx_custom.custom_percent_9 as custom2_custom_percent_9,    ~r~n" + & 
"          ctx_custom.custom_percent_10 as custom2_custom_percent_10,   ~r~n" + & 
"          has_docs = Isnull(ctx_am_documents.has_docs,0) ~r~n" + & 
" FROM  ctx_basic_info   ~r~n" + & 
" LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id   ~r~n" + & 
" LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code   ~r~n" + & 
" LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code ~r~n" + & 
" LEFT OUTER JOIN code_lookup code_lookup2 ON ctx_basic_info.status = code_lookup2.lookup_code ~r~n" + & 
" LEFT OUTER JOIN code_lookup code_lookup3 ON ctx_basic_info.category = code_lookup3.lookup_code ~r~n" + & 
" LEFT OUTER JOIN code_lookup code_lookup4 ON ctx_basic_info.contract_type = code_lookup4.lookup_code ~r~n" + & 
" LEFT OUTER JOIN code_lookup code_lookup5 ON ctx_basic_info.dvision = code_lookup5.lookup_code ~r~n" + & 
" LEFT OUTER JOIN ctx_custom ON ctx_basic_info.ctx_id = ctx_custom.ctx_id   ~r~n" + & 
" LEFT OUTER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id  ~r~n" + & 
" LEFT OUTER JOIN ( select count(1) has_docs, ctx_id from  ctx_am_document group by ctx_id ) ctx_am_documents ON ctx_basic_info.ctx_id = ctx_am_documents.ctx_id,   ~r~n" + & 
" ( ~r~n" + & 
" SELECT DISTINCT ctx_id = ctx_contract_contacts.ctx_id, user_id = ctx_contacts.user_d, access = (CASE ctx_contract_contacts.owner WHEN 'Y' THEN 'F' ELSE ctx_contract_contacts.access END) ~r~n" + & 
" FROM ctx_contract_contacts Left Outer Join ~r~n" + & 
" ( ~r~n" + & 
" Select ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d  ~r~n" + & 
" From ctx_contract_contacts ctx_contract_contacts1 ,ctx_contacts ctx_contacts1 ~r~n" + & 
" Where ctx_contract_contacts1.contact_id = ctx_contacts1.contact_id And ctx_contacts1.user_d = @user_d ~r~n" + & 
" Group By ctx_contract_contacts1.ctx_id,ctx_contacts1.user_d ~r~n" + & 
" Having Count(ctx_contract_contacts1.ctx_id) > 1 ~r~n" + & 
" ) ccc ~r~n" + & 
" On ctx_contract_contacts.ctx_id = ccc.ctx_id ~r~n" + & 
" ,ctx_contacts ~r~n" + & 
" WHERE ctx_contacts.user_d = @user_d ~r~n" + & 
" 	AND (ccc.ctx_id is null or ctx_contract_contacts.access = 'F' ) ~r~n" + & 
" 	AND ctx_contract_contacts.contact_id = ctx_contacts.contact_id  ~r~n" + & 
" 	AND ( ctx_contract_contacts.access IN ('F','R')  ~r~n" + & 
" 	OR ctx_contract_contacts.owner = 'Y' ) ~r~n" + & 
" 	AND ctx_contract_contacts.ic_area = 'I' ~r~n" + & 
" UNION  ~r~n" + & 
" SELECT DISTINCT ctx_id = ctx_group_access.ctx_id,user_id = security_group_users.user_id, access =  ctx_group_access.access ~r~n" + & 
" FROM  ~r~n" + & 
" ctx_group_access , ~r~n" + & 
" security_group_users, ~r~n" + & 
" icred_settings ~r~n" + & 
" WHERE	security_group_users.user_id = @user_d ~r~n" + & 
" 	AND ctx_group_access.group_id = security_group_users.group_id ~r~n" + & 
" 	AND ctx_group_access.access =  ~r~n" + & 
" 		(Case When Exists (Select u1.user_id,a1.ctx_id,a1.access  ~r~n" + & 
" 		From ctx_group_access a1,security_group_users u1 ~r~n" + & 
" 		Where a1.group_id = u1.group_id  ~r~n" + & 
" 		And a1.ctx_id = ctx_group_access.ctx_id ~r~n" + & 
" 		And u1.user_id = security_group_users.user_id	 ~r~n" + & 
" 		And a1.access = 'F') Then 'F' Else 'R' End)  ~r~n" + & 
" 	AND icred_settings.group_access = 1 ~r~n" + & 
" 	AND ctx_group_access.access in ('F','R') ~r~n" + & 
" 	AND NOT EXISTS	(SELECT 1 FROM ctx_contract_contacts, ctx_contacts   ~r~n" + & 
" 			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id )  ~r~n" + & 
" 			AND ( ctx_contacts.user_d = security_group_users.user_id ) ~r~n" + & 
" 			AND ( ctx_contract_contacts.ic_area = 'I' ) ~r~n" + & 
" 			AND ( ctx_contract_contacts.ctx_id = ctx_group_access.ctx_id ) ~r~n" + & 
" 			) ~r~n" + & 
" UNION ~r~n" + & 
" SELECT DISTINCT ctx_id = ctx_basic_info.ctx_id, user_id = security_users.user_id, access = (CASE ctx_acp_contract_management_right.rights WHEN '11' THEN 'F' WHEN '12' THEN 'R' ELSE 'N' END) ~r~n" + & 
" FROM ctx_acp_contract_management_right, security_users, ctx_basic_info ~r~n" + & 
" WHERE security_users.user_id = @user_d ~r~n" + & 
" 	AND ctx_acp_contract_management_right.types = 1 ~r~n" + & 
" 	AND ctx_acp_contract_management_right.role_id = security_users.role_id ~r~n" + & 
" 	AND ctx_acp_contract_management_right.category = ctx_basic_info.category ~r~n" + & 
"   And ctx_basic_info.is_template = 0  ~r~n" + & 
" 	AND ctx_acp_contract_management_right.rights In ('11','12') ~r~n" + & 
" 	AND NOT EXISTS (SELECT 1 FROM ctx_contract_contacts, ctx_contacts   ~r~n" + & 
" 			WHERE ( ctx_contacts.contact_id = ctx_contract_contacts.contact_id )  ~r~n" + & 
" 			AND ( ctx_contacts.user_d = security_users.user_id AND ctx_contract_contacts.ic_area = 'I')  ~r~n" + & 
" 			AND ( ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id )  ~r~n" + & 
" 			UNION ~r~n" + & 
" 			SELECT 1 FROM ctx_group_access,security_group_users,icred_settings ~r~n" + & 
" 			WHERE icred_settings.group_access = 1 ~r~n" + & 
" 			AND (ctx_group_access.group_id = security_group_users.group_id ) ~r~n" + & 
" 			AND ( security_group_users.user_id = security_users.user_id )	 ~r~n" + & 
" 			AND ( ctx_group_access.ctx_id = ctx_basic_info.ctx_id ) ~r~n" + & 
" 			) ~r~n" + & 
" ) AA  ~r~n" + & 
" WHERE ctx_basic_info.ctx_id = AA.ctx_id and ctx_basic_info.is_template = 0  ~r~n" + & 
" ORDER BY ctx_basic_info.master_contract_id Asc, ctx_basic_info.ctx_id  Asc     ~r~n" + & 
" END"


////added by gavins 20120320
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'up_ImportView' AND type = 'P') " + &
//"    DROP PROCEDURE up_ImportView"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create procedure up_ImportView~r~n" +  &
//"	@SourceDBName nvarchar(100),~r~n" +  &
//"	@TargetDBName nvarchar(100),~r~n" +  &
//"	@ViewID nvarchar(100),~r~n" +  &
//"	@NewViewName nvarchar(50)~r~n" +  &
//"As~r~n" +  &
//"Begin~r~n" +  &
//"	declare @MaxViewID	nvarchar(100)~r~n" +  &
//"	declare @SqlString nvarchar(4000)~r~n" +  &
//"	declare @ParmDefinition nvarchar(100)~r~n" +  &
//"		~r~n" +  &
//"	/*Get Seq No*/~r~n" +  &
//"	select @SqlString = 'select @MaxViewIDOUT = isnull(max(data_view_id),0) + 1  from ' + ~r~n" +  &
//"						@TargetDBName + '.dbo.data_view'~r~n" +  &
//"	select @ParmDefinition = '@MaxViewIDOUT int Output'~r~n" +  &
//"	exec sp_executesql @SqlString,@ParmDefinition,@MaxViewIDOUT=@MaxViewID output~r~n" +  &
//"	/*Insert Data_View Table*/~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.data_view (data_view_id,data_view_name,type,type_c)'~r~n" +  &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',~'~'' + @NewViewName + '~'~' ,type,type_c from '  ~r~n" +  &
//"			+ @SourceDBName + '.dbo.data_view where data_view_id = ' + @ViewID~r~n" +  &
//"	~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	/*Insert Tab Properties Table*/~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_tabpage_properties (data_view_id~r~n" +  &
//"						,tabpage_name ,text,text_color ,icon_visible,icon_update_date,icon,backcolor,~r~n" +  &
//"						tab_backcolor,tab_icon)'~r~n" +  &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',tabpage_name ,text,text_color ,icon_visible,~r~n" +  &
//"						icon_update_date,icon,backcolor,tab_backcolor,tab_icon from ' + @SourceDBName + ~r~n" +  &
//"						'.dbo.ctx_tabpage_properties where data_view_id = ' + @ViewID~r~n" +  &
//"	~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	/*Insert Ctx_Screen Table*/~r~n" +  &
//"	select  @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen (data_view_id,screen_id,tab_name,screen_name,~r~n" +  &
//"						dw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,~r~n" +  &
//"						titlebar_text,boarder_style,screen_visible, screen_style, grid_sql, grid_dataobject, grid_modify )'~r~n" +  &
//"	select 	@SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id,'   ~r~n" +  &
//"	select  @SqlString = @SqlString + '  tab_name,   '~r~n" +  &
//"	select  @SqlString = @SqlString + 'screen_name,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         dw_name,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         dataobject, '  ~r~n" +  &
//"	select  @SqlString = @SqlString + '         description, '  ~r~n" +  &
//"	select  @SqlString = @SqlString + '         dw_sql,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         create_date,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         modify_date,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         force_update,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         titlebar_visible,'   ~r~n" +  &
//"	select  @SqlString = @SqlString + '         titlebar_text,   '~r~n" +  &
//"	select  @SqlString = @SqlString + '         boarder_style,  '~r~n" +  &
//"	select  @SqlString = @SqlString + '         screen_visible,  '~r~n" +  &
//"	select  @SqlString = @SqlString + '			screen_style, '~r~n" +  &
//"	select  @SqlString = @SqlString + '			grid_sql, '~r~n" +  &
//"	select  @SqlString = @SqlString + '			grid_dataobject, '~r~n" +  &
//"	select  @SqlString = @SqlString + '			grid_modify '~r~n" +  &
//"	select  @SqlString = @SqlString + '	from ' + @SourceDBName + '.dbo.ctx_screen'~r~n" +  &
//"	select  @SqlString = @SqlString + '	where data_view_id = ' + @ViewID~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	~r~n" +  &
//"	/*insert Data Fill Settings*/~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_datafill (data_view_id~r~n" +  &
//"      ,screen_id~r~n" +  &
//"      ,field_name~r~n" +  &
//"      ,field_name_fill~r~n" +  &
//"      ,field_name_map~r~n" +  &
//"      ,modify_by~r~n" +  &
//"      ,modify_date~r~n" +  &
//"      ,Relative_Days)'~r~n" +  &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id~r~n" +  &
//"      ,field_name~r~n" +  &
//"      ,field_name_fill~r~n" +  &
//"      ,field_name_map~r~n" +  &
//"      ,modify_by~r~n" +  &
//"      ,modify_date~r~n" +  &
//"      ,Relative_Days from ' + @SourceDBName + '.dbo.ctx_screen_datafill where data_view_id = ' + @ViewID ~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	/*insert Field Depent Settings*/~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_field_depend (view_id~r~n" +  &
//"      ,base_field~r~n" +  &
//"      ,depend_field~r~n" +  &
//"      ,base_screen_id~r~n" +  &
//"      ,depend_screen_id~r~n" +  &
//"      ,base_field_dispaly~r~n" +  &
//"      ,depend_field_dispaly~r~n" +  &
//"      ,base_screen_type~r~n" +  &
//"      ,base_table~r~n" +  &
//"      ,depend_table)'~r~n" +  &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',base_field~r~n" +  &
//"      ,depend_field~r~n" +  &
//"      ,base_screen_id~r~n" +  &
//"      ,depend_screen_id~r~n" +  &
//"      ,base_field_dispaly~r~n" +  &
//"      ,depend_field_dispaly~r~n" +  &
//"      ,base_screen_type~r~n" +  &
//"      ,base_table~r~n" +  &
//"      ,depend_table from ' + @SourceDBName + '.dbo.ctx_screen_field_depend where view_id = ' + @ViewID ~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	/*isnert field extend property*/~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_field_ex (data_view_id~r~n" +  &
//"      ,screen_id~r~n" +  &
//"      ,field_name~r~n" +  &
//"      ,field_add)'~r~n" +  &
//"	select @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id~r~n" +  &
//"      ,field_name~r~n" +  &
//"      ,field_add from ' + @SourceDBName + '.dbo.ctx_screen_field_ex where data_view_id = ' + @ViewID ~r~n" +  &
//"	exec sp_executesql @SqlString~r~n" +  &
//"	select @SqlString = 'insert ' + @TargetDBName + '.dbo.conv_view_pic  ( view_id ~r~n" +  &
//"			,Screen_id ~r~n" +  &
//"			,pic_type ~r~n" +  &
//"			,pic_band ~r~n" +  &
//"			,pic_name ~r~n" +  &
//"			,pic_filename ~r~n" +  &
//"			,pic_bitmap ~r~n" +  &
//"			,pic_x ~r~n" +  &
//"			,pic_y ~r~n" +  &
//"			,pic_width ~r~n" +  &
//"			,pic_height ~r~n" +  &
//"			,pic_tag )' ~r~n" +  &
//"select @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id , ~r~n" +  &
//"				 pic_type,  ~r~n" +  &
//"				 pic_band,   ~r~n" +  &
//"				 pic_name,   ~r~n" +  &
//"				 substring( pic_filename,1,2 ) + ' +  ~r~n" +  &
//"				 'cast( ' + @MaxViewID + ' as varchar(10)) + ' +  ~r~n" +  &
//"				 '''_''' + ' + cast( screen_id as varchar(10)) + ' +  ~r~n" +  &
//"				 'substring( pic_filename, charindex( ' + '''_''' +  ~r~n" +  &
//"				 ',pic_filename, charindex( ' + '''_''' + ',pic_filename, 3 ) + 1 ),99)  ~r~n" +  &
//"				 ,pic_bitmap  ~r~n" +  &
//"				  ,pic_x  ~r~n" +  &
//"				  ,pic_y  ~r~n" +  &
//"				  ,pic_width  ~r~n" +  &
//"				  ,pic_height  ~r~n" +  &
//"				  ,pic_tag    ~r~n" +  &
//"				  from '+ @SourceDBName +'.dbo.conv_view_pic where view_id = ' +   ~r~n" +  &
//"				  @ViewID + ' and pic_type = '+ '''screen''' ;	 ~r~n" +  &
//"	exec sp_executesql @SqlString ~r~n" +  &
//"	select Cast(@MaxViewID as int)~r~n" +  &
//"end~r~n" 
//
////added by gavins 20120323
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (SELECT name FROM sysobjects WHERE name = 'sp_get_connect_value' AND type = 'P') " + &
//"    DROP PROCEDURE sp_get_connect_value"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create procedure [dbo].[sp_get_connect_value] ( @column varchar(100), @table varchar(200) ,@where varchar(1000), @value   varchar(8000) output )   as    ~r~n" +  &
// " begin    ~r~n" +  &
// " declare @select nvarchar(4000),  @ParmDefinition nvarchar(500)     ~r~n" +  &
// "  Set @value = ''    ~r~n" +  &
// " Set @select = N'select @value1 = @value1 + cast(  ' +  @column + ' as varchar(100)) + ''|'' from  ' + @table + ' where ' + @where      ~r~n" +  &
// " set @ParmDefinition =  N' @value1 varchar(8000) OUTPUT';    ~r~n" +  &
// " EXECUTE sp_executesql @select, @ParmDefinition,  @value1=@value OUTPUT;    ~r~n" +  &
// "  end  ~r~n" 
// 
// 
////Added By Ken.Guo 06/18/2012. Improve SQL Server 2008  full text search performance/ workaround SQL Server 2008's Bug
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (SELECT name FROM sysobjects WHERE name = 'sp_sql2008_improve' AND type = 'P')~r~n" + &
//"    DROP PROCEDURE sp_sql2008_improve~r~n" 
//
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"CREATE  PROCEDURE [dbo].[sp_sql2008_improve]~r~n" + &
//"as~r~n" + &
//"Begin~r~n" + &
//	"If CharIndex( 'Microsoft SQL Server 2005', @@version) = 0  ~r~n" + &	
//	"	DBCC TRACEON(4199, -1) ~r~n" + &
//"End"
//
////Added By Mark Lee 07/05/12 check SQL compatibility_level value
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'sp_sys_set' AND TYPE = 'P')~r~n" + &
//"BEGIN~r~n" + &
//"	DROP PROCEDURE sp_sys_set~r~n" + &
//"END~r~n" 
//
////Added By Mark Lee 08/14/12 add adjuge free space for database
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"CREATE PROCEDURE sp_sys_set(@arg VARCHAR(200),@outputs VARCHAR(1000) OUTPUT)~r~n" + &
//"AS~r~n" + &
//"BEGIN~r~n" + &
//"  DECLARE @sql NVARCHAR(500)~r~n" + &
//"  DECLARE @para NVARCHAR(500)~r~n" + &
//"  DECLARE @level INT~r~n" + &
//"  DECLARE @pos INT~r~n" + &
//"  DECLARE @p_version VARCHAR(50)~r~n" + &
//"~r~n" + &
//"  IF (@arg IS NULL ) OR (LTRIM(RTRIM(@arg)) = '')~r~n" + &
//"  BEGIN~r~n" + &
//"   RETURN ~r~n" + &
//"  END ~r~n" + &
//"  ELSE~r~n" + &
//"  BEGIN~r~n" + &
//"   IF @arg = 'compatibility_level' ~r~n" + &
//"   BEGIN~r~n" + &
//"    SET @p_version = CONVERT(VARCHAR(50),SERVERPROPERTY('PRODUCTVERSION'))~r~n" + &
//"    SET @pos = CHARINDEX('.',LTRIM(RTRIM(@p_version)))~r~n" + &
//"    IF @pos > 0 AND ( Isnumeric(LEFT(@p_version,@pos - 1)) > 0 )~r~n" + &
//"    BEGIN~r~n" + &
//"     SET @pos = convert(INT,LEFT(@p_version,@pos - 1))~r~n" + &
//"     IF @pos > 8 ~r~n" + &
//"     BEGIN~r~n" + &
//"      SET @sql = 'select @level = compatibility_level from sys.databases where name = db_name()'~r~n" + &
//"      SET @para = '@level int output'~r~n" + &
//"      EXEC SP_EXECUTESQL @sql, @para,@level OUTPUT~r~n" + &
//"      SELECT @outputs = convert(VARCHAR(1000),@level)~r~n" + &
//"     END~r~n" + &
//"     ELSE IF @pos <= 8 ~r~n" + &
//"     BEGIN~r~n" + &
//"      SET @sql = 'select  @level = cmptlevel from master.dbo.sysdatabases where name = db_name()'~r~n" + &
//"      SET @para = '@level int output'~r~n" + &
//"      EXEC SP_EXECUTESQL @sql, @para,@level OUTPUT~r~n" + &
//"      SELECT @outputs = convert(VARCHAR(1000),@level)~r~n" + &
//"     END~r~n" + &
//"    END ~r~n" + &
//"    ~r~n" + &
//"    RETURN~r~n" + &
//"   END ~r~n" + &
//"   ELSE IF @arg = 'freespace' ~r~n" + &
//"   BEGIN~r~n" + &
//" DECLARE @drivename CHAR(1)~r~n" + &
//" DECLARE @drivename2 CHAR(1)~r~n" + &
//" DECLARE @mb_free INT~r~n" + &
//" DECLARE @mb_free2 INT~r~n" + &
//"~r~n" + &
//" Select @outputs = ''~r~n" + &
//" SELECT @drivename=LEFT(filename,1) FROM sysfiles~r~n" + &
//" WHERE fileid = 1 ~r~n" + &
//"~r~n" + &
//" SELECT @drivename2=LEFT(filename,1) FROM sysfiles~r~n" + &
//" WHERE fileid = 2~r~n" + &
//"  ~r~n" + &
//" IF object_id('tempdb..#freespace') is not null ~r~n" + &
//" Begin~r~n" + &
//"  DROP TABLE #freespace~r~n" + &
//" End~r~n" + &
//" ~r~n" + &
//" CREATE TABLE #freespace(~r~n" + &
//" drive CHAR(1),~r~n" + &
//" mb_free INT~r~n" + &
//" )~r~n" + &
//"    ~r~n" + &
//" INSERT INTO #freespace~r~n" + &
//" EXEC xp_fixeddrives~r~n" + &
//"  ~r~n" + &
//" SELECT top 1 @mb_free = mb_free  FROM #freespace WHERE drive = @drivename~r~n" + &
//" SELECT top 1 @mb_free2 = mb_free FROM #freespace WHERE drive = @drivename2~r~n" + &
//"  ~r~n" + &
//" IF (isnumeric(@mb_free)= 1) and ( @mb_free < 50 ) ~r~n" + &
//" BEGIN~r~n" + &
//"  SELECT @outputs = '1The system detected that there is less than 50MB free disk space for your database.~r~n' +~r~n" + &
//"    'Please contact your database administrator to allocate more disk space ~r~n' +~r~n" + &
//"    'in order to avoid disrupting the normal operation of the system.'~r~n" + &
//" END~r~n" + &
//"  ~r~n" + &
//" IF (isnumeric(@mb_free2)= 1) and ( @mb_free2 < 50 ) ~r~n" + &
//" BEGIN~r~n" + &
//"  IF LEN(@outputs) = 0 ~r~n" + &
//"  BEGIN~r~n" + &
//"   SELECT @outputs = '2The system detected that there is less than 50MB free disk space for your database.~r~n' +~r~n" + &
//"     'Please contact your database administrator to allocate more disk space ~r~n' +~r~n" + &
//"     'in order to avoid disrupting the normal operation of the system.'~r~n" + &
//"  END         ~r~n" + &
//" END ~r~n" + &
//" ~r~n" + &
//" DROP TABLE #freespace~r~n" + &
//" ~r~n" + &
//" END~r~n" + &
//"~r~n" + &
//" END ~r~n" + &
//" ~r~n" + &
//"END ~r~n" + &
//""

of_execute_sqls("of_ver110_release_storeprocedure1")

Return 1
end function

public function integer of_ver110_release_table1 ();//Add SQL Here

//e.g.
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"IF Not EXISTS(SELECT name  FROM  sysobjects WHERE  name = 'security_user_options'  AND ~t type = 'U')~r~n" + &
//"CREATE TABLE security_user_options~r~n" + &
//"(~r~n" + &
//"user_id varchar(50) not null,~r~n" + &
//"option_name varchar(100)  not null,~r~n" + &
//"option_value varchar(100) null,~r~n" + &
//"last_update datetime null,~r~n" + &
//"Primary Key(user_id,option_name)~r~n" + &
//"~t)"


//added by gavins 20120302   required grid
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='screen_style' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add screen_style varchar(1)~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='grid_sql' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add   grid_sql text ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='grid_opsql' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add  grid_opsql text~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='grid_dataobject' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add  grid_dataobject varchar(200)~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='grid_modify' and t.table_name='ctx_screen' ) " + &
"alter table ctx_screen add  grid_modify varchar(1)~r~n" 

//Added By Mark Lee 04/23/12  added it for record logs
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
" IF Not EXISTS(SELECT 1  FROM  sysobjects WHERE  name = 'bidq_log_info'  AND  type = 'U')~r~n" + &
" Create Table bidq_log_info ~r~n" + &
" ( ~r~n" + &
" 	id  int IDENTITY NOT NULL, ~r~n" + &
"	style  char(1) NOT NULL,~r~n" + &
"	ctx_bidq int  NULL,~r~n" + &
"	doc_id int NULL,~r~n" + &
"	doc_name varchar(200)  NULL,~r~n" + &
"	paths varchar(200) NULL,~r~n" + &
"	errmsg varchar(2000) NULL,~r~n" + &
"	pass_fail varchar(10) NULL,~r~n" + &
"	user_id varchar(50)  NULL,~r~n" + &
"	log_date datetime  NULL,~r~n" + &
"	ctx_id int NULL,~r~n" + &
"	Primary Key(id) ~r~n" + &
"	) "

//Added By Ken.Guo 03/20/2012. Fix Date Alarm Template's Bug
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_create' and t.table_name='ctx_notification_templates' ) " + &
"ALTER table ctx_notification_templates add alm_create varchar(2000) null  "



//Added By Ken.Guo 03/20/2012.  Auto hide window when IE window is min or current IE tab is not ContractLogix
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='hide_inactive_window' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add hide_inactive_window integer null  "

//added by gavins 20120322 ctx_screen_bak add column
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select TOP 1 1 from  sysobjects where  name='ctx_screen_bak'     and   type = 'U') ~r~n" + &
" CREATE TABLE ctx_screen_bak( data_view_id int NOT NULL, screen_id int NOT NULL, dw_sql text  NULL, ~r~n" + &
" create_date datetime NULL, modify_date datetime NULL, backupdate datetime NOT NULL default getdate(), ~r~n" + &
" seq_no int NOT NULL,  version varchar(10)  NULL,  grid_sql text  NULL, screen_style varchar(1) NULL )  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='version' and t.table_name='ctx_screen_bak' ) " + &
" alter table ctx_screen_bak add version varchar(10)  "
 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  & 
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='grid_sql' and t.table_name='ctx_screen_bak' ) " + &
" alter table ctx_screen_bak add grid_sql text  "

//added by gavins 20120329 ctx_screen_bak add column	 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  & 
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='screen_style' and t.table_name='ctx_screen_bak' ) " + &
" alter table ctx_screen_bak add screen_style varchar(1)  "
	 	 
//Added By Mark Lee 04/23/12 Fixed APB Bug 
is_sql_statements[UpperBound(is_sql_statements) + 1] =  & 
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='default_value' and t.table_name='export_fields' ) " + &
"alter table export_fields modify default_value default '' "

//Modified By Mark Lee 04/25/12 move from object of n_cst_globaldata in event of of_retrieve
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='web_crawl' and t.table_name='icred_settings' ) " + &
" 		Alter table icred_settings add web_crawl integer null " 

//Modified By Mark Lee 04/25/12 move from object of n_cst_globaldata in event of of_retrieve
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='downloadurl' and t.table_name='icred_settings' ) " + &
"   Begin~r~n" + &
"		Alter table icred_settings add downloadurl varchar(255) null~r~n" + &
"   End "

//Added By Mark Lee 05/09/12	Email Subject was 'BUG: Using Templates - Dynamically Add User'
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_owner' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_owner bit default 0~r~n~r~n" + &
"End"

//Added By Mark Lee 05/09/12	Email Subject was 'BUG: Using Templates - Dynamically Add User'
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_default_email' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_default_email bit default 0~r~n~r~n" + &
"End"

//Added By Mark Lee 05/10/12 add copy data (Custom Data 2) function for contract module
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_custom_data2' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_custom_data2 bit NULL~r~n" + &
"End"
//Added By Mark Lee 05/10/12 add copy data (Custom multi) function for contract module
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_custom_multi' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_custom_multi bit NULL~r~n" + &
"End"

//added by gavins 20120521 add ctx_screen_original
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists (select  1 from  sysobjects where  name='ctx_screen_original'     and   type = 'U') ~r~n" + &
"create table ctx_screen_original ( data_view_id int , screen_id int ~r~n" + &
", dw_sql text, grid_sql text , pre_modifydate datetime, modifydate datetime,  primary key(  ~r~n" + &
"data_view_id, screen_id )) ~r~n" 

//added by gavins 20120528  
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='createtime' and t.table_name='conv_view_pic' ) " + &
"  alter table conv_view_pic add   createtime datetime default getdate( ) "

//Added By Ken.Guo 05/29/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='user_id' and t.table_name='ctx_screen_bak' ) " + &
"ALTER table ctx_screen_bak add user_id varchar(50) null  " 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='notes' and t.table_name='ctx_screen_bak' ) " + &
"ALTER table ctx_screen_bak add notes varchar(500) null  "

//Added By Ken.Guo 05/29/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='id_forcatalog' and t.table_name='ctx_custom_multi_hdr' ) " + &
"ALTER table ctx_custom_multi_hdr add id_forcatalog numeric(10,0) identity   "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='id_forcatalog' and t.table_name='ctx_custom_multi_detail' ) " + &
"ALTER table ctx_custom_multi_detail add id_forcatalog numeric(10,0) identity   "

//Added By Ken.Guo 07/05/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='checkoutforapproval' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add checkoutforapproval integer null  "

//Added By Ken.Guo 07/20/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dwsavepdfway' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add dwsavepdfway integer null  ~r~n"

//Added By Mark Lee 08/09/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='https' and t.table_name='icred_settings' ) " + &
"alter table icred_settings add https int ~r~n" 

//Added By gavins 20120815
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tfield_name' and t.table_name='sys_audit' ) " + &
"alter table sys_audit add tfield_name varchar(50) null  ~r~n" 

//Added By gavins 20120815
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tfield_name_allias' and t.table_name='sys_audit' ) " + &
"alter table sys_audit add tfield_name_allias varchar(50) null ~r~n" 

//Added By Ken.Guo 08/17/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='preload_word' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add preload_word int null  "


//Added By gavins 20120822( 1 special null or 0 normal )
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alarm_ways' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add alarm_ways int null  "

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='default_copy_contract' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add default_copy_contract varchar(2000) null  "

////Added By Ken.Guo 10/11/2012. Delete the unnecessary FK
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists(select TOP 1 1 from sys.sysforeignkey  where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_') " + &
//"alter table Ctx_Action_Items delete FOREIGN KEY FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_"

//added by gavins 20121220    
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='file_modify' and t.table_name='ctx_am_image_approve' ) " + &
" alter table ctx_am_image_approve add file_modify int null ~r~n"
 
 //Added By Ken.Guo 12/19/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_triggered_view' and t.table_name='wf_workflow' ) " + &
"ALTER table wf_workflow add wf_triggered_view varchar(2000) null  "

//Added By Ken.Guo 12/19/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_triggered_ctx_status' and t.table_name='wf_workflow' ) " + &
"ALTER table wf_workflow add wf_triggered_ctx_status varchar(2000) null  "

//Added By Ken.Guo 03/20/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists(select TOP 1 1 from sys.sysforeignkey  where role='FK_ctx_screen_datafill_ctx_screen') " + &
"ALTER TABLE ctx_screen_datafill DELETE FOREIGN KEY FK_ctx_screen_datafill_ctx_screen "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists(select TOP 1 1 from sys.sysforeignkey where role='FK_ctx_screen_datafill_ctx_screen') " + &
"ALTER TABLE ctx_screen_datafill ADD CONSTRAINT FK_ctx_screen_datafill_ctx_screen FOREIGN KEY(data_view_id, screen_id) REFERENCES ctx_screen (data_view_id, screen_id) ON DELETE CASCADE "
 
of_execute_sqls("of_ver110_release_table1")


Return 1
end function

public function integer of_clx110_updates ();
of_ver90_release_table1()
of_ver90_release_table2()
of_ver90_release_view1()
of_ver90_release_storeprocedure1()

of_ver95_release_table1()
of_ver95_release_table2()
of_ver95_release_view1()
of_ver95_release_storeprocedure1()

of_ver100_release_table1()
of_ver100_release_table2()
of_ver100_release_view1()
of_ver100_release_storeprocedure1()

of_ver105_release_table1()
of_ver105_release_view1()
of_ver105_release_storeprocedure1()
of_ver105_release_trigger1()

of_ver110_release_table1()
of_ver110_release_storeprocedure1()


RETURN 1
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

of_ver115_release_table1()
of_ver115_release_storeprocedure1()

of_ver120_release_table1()
of_ver120_release_view1()
of_ver120_release_storeprocedure1()

Return 1

end function

public function integer of_ver115_release_table1 ();//====================================================================
//$<Function>: of_ver115_release_table1()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Added By Mark Lee 07/10/12
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='track_viewing' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add track_viewing int  "

//Added By Mark Lee 07/19/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS(SELECT 1  FROM  sysobjects WHERE  name = 'sys_tracking_log'  AND  type = 'U')~r~n" + &
"CREATE TABLE sys_tracking_log(~r~n" + &
" session_id varchar(20) NOT NULL,~r~n" + &
" modules varchar(200) NOT NULL,~r~n" + &
" value1 varchar(200) NOT NULL,~r~n" + &
" value2 varchar(200) NULL,~r~n" + &
" value3 varchar(200) NULL,~r~n" + &
" notes varchar(2000) NULL,~r~n" + &
" open_datetime datetime NULL,~r~n" + &
" Foreign Key(session_id) references session_info(session_id) on delete cascade~r~n" + &
") "

//Added By Mark Lee 07/25/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='base_clause_rule_on' and t.table_name='icred_settings' ) " + &
" ALTER table icred_settings add base_clause_rule_on integer null  "

//Added By Ken.Guo 07/27/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dwsavepdfway' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add dwsavepdfway integer null  ~r~n"

//added by gavins 20120730
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( SELECT name  FROM  sysobjects WHERE  name = 'sys_dynamic_sql'  AND   type = 'U')~r~n" + &
"create table sys_dynamic_sql ( sessionid varchar(20) , id1 varchar(30) ,id2 varchar(30), id3 varchar(30), sqlstring varchar(6000), arg_numbers int, ~r~n" + &
"return_value1 varchar(100), return_value2 varchar(100), return_value3 varchar(100), occur_time datetime default(getdate() ),  primary key (sessionid, id1, id2,id3 ),~r~n" + &
"Foreign Key(sessionid) references session_info(session_id) on delete cascade )~r~n" 

//Added By Mark Lee 08/09/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='https' and t.table_name='icred_settings' ) " + &
"alter table icred_settings add https int ~r~n" 

//Added By gavins 20120815
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tfield_name' and t.table_name='sys_audit' ) " + &
"alter table sys_audit add tfield_name varchar(50) null  ~r~n" 

//Added By gavins 20120815
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tfield_name_allias' and t.table_name='sys_audit' ) " + &
"alter table sys_audit add tfield_name_allias varchar(50) null ~r~n" 

//Added By Ken.Guo 08/17/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='preload_word' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add preload_word int null  "

//Added By gavins 20120822( 1 special null or 0 normal )
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alarm_ways' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add alarm_ways int null  "

//Added By Ken.Guo 09/26/2012. Support Add sub contracts for US banK Customer.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='default_copy_contract' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add default_copy_contract varchar(2000) null  "

////Added By Ken.Guo 10/11/2012. Delete the unnecessary FK
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (select TOP 1 1 from sys.sysforeignkey  where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_') " + &
//"  ALTER TABLE Ctx_Action_Items drop foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_ "

of_execute_sqls("of_ver115_release_table1")

return 1
end function

public function integer of_ver115_release_storeprocedure1 ();//====================================================================
// Function: of_ver115_release_storeprocedure1
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/10/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//
//====================================================================


////added by gavins 20120723
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'uf_connect_string' AND xtype in (N'FN', N'IF', N'TF') ) " + &
//"    DROP function uf_connect_string"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create function  [dbo].[uf_connect_string] ( @class varchar(10),  @where1 varchar(100), @where2 varchar(100))returns varchar(8000) ~r~n" + &
//" as ~r~n" + &
//"	begin	~r~n" + &
//"		declare @returnstring varchar(4000), @name varchar(4000) ~r~n" + &
//"		set  @returnstring = '' ~r~n" + &
//"		if @class = '1'  ~r~n" + &
//"			begin ~r~n" + &
//"			   SELECT @returnstring = @returnstring + ISNULL( code_lookup_B.code , '' )+ ', ',  ~r~n" + &
//"				@name = IsNull	(ctx_acp_clause_attribute.clause_attribute_alias,code_lookup_A.description) +' = '  ~r~n" + &
//"			   FROM ctx_acp_clause_attribute,ctx_acp_clause_attr_value,code_lookup  ~r~n" + &
//"			    code_lookup_A,code_lookup	code_lookup_B ~r~n" + &
//"		  	    WHERE ctx_acp_clause_attribute.ctx_acp_clause_id = ctx_acp_clause_attr_value.ctx_acp_clause_id AND ~r~n" + &
//"			   ctx_acp_clause_attribute.clause_attribute_id = ctx_acp_clause_attr_value.clause_attribute_id AND ~r~n" + &
//"			   ctx_acp_clause_attribute.clause_attribute_id = code_lookup_A.lookup_code AND ~r~n" + &
//"			   ctx_acp_clause_attr_value.clause_attribute_value_id = code_lookup_B.lookup_code  ~r~n" + &
//"			   and ctx_acp_clause_attribute.ctx_acp_clause_id = @where1 and  ~r~n" + &
//"				ctx_acp_clause_attribute.clause_attribute_id  = @where2 order by  ~r~n" + &
//"				ctx_acp_clause_attr_value.clause_attribute_value_id ~r~n" + &
//"				set @returnstring = @name + left(@returnstring, len(@returnstring ) -1 ) ~r~n" + &
//"		     end  ~r~n" + &
//"		return @returnstring ~r~n" + &
//"	end " 
//
//
////added by gavins 20120730
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'up_dynamic_sql' AND type = 'P') " + &
//"    DROP PROCEDURE up_dynamic_sql"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create procedure [dbo].[up_dynamic_sql] @sessionid varchar(20)~r~n" + &
//"as~r~n" + &
//"declare @sql nvarchar(4000) , @outstring1 varchar(1000), @outstring2 varchar(1000), @outstring3 varchar(1000)~r~n" + &
//"declare @num int~r~n" + &
//"declare sqls cursor for select  sqlstring, arg_numbers  from sys_dynamic_sql~r~n" + &
//"where sessionid = @sessionid  FOR UPDATE of return_value1, return_value2, return_value3~r~n" + &
//"open sqls ~r~n" + &
//"fetch sqls into @sql, @num~r~n" + &
//"while @@FETCH_STATUS = 0 ~r~n" + &
//"	begin~r~n" + &
//"		if @num = 1~r~n" + &
//"			begin~r~n" + &
//"				exec sp_executesql @sql,~r~n" + &
//"				N'@outstring1 varchar(1000) out',~r~n" + &
//"				@outstring1 out~r~n" + &
//"			end ~r~n" + &
//"		 else if @num = 2~r~n" + &
//"			begin~r~n" + &
//"				exec sp_executesql @sql,~r~n" + &
//"				N'@outstring1 varchar(1000) out,@outstring2 varchar(1000) out',~r~n" + &
//"				@outstring1 out, @outstring2 out~r~n" + &
//"			end~r~n" + &
//"		 else if @num = 3~r~n" + &
//"			begin~r~n" + &
//"				exec sp_executesql @sql,~r~n" + &
//"				N'@outstring1 varchar(1000) out,@outstring2 varchar(1000) out,@outstring3 varchar(1000) out',~r~n" + &
//"				@outstring1 out	, @outstring2 out, @outstring3 out		~r~n" + &
//"			end~r~n" + &
//"		if @@ERROR <> 0 ~r~n" + &
//"			begin~r~n" + &
//"				set @outstring1 = 'error'~r~n" + &
//"			end~r~n" + &
//"			update 	sys_dynamic_sql set return_value1 = @outstring1, return_value2 = @outstring2~r~n" + &
//"					, return_value3 = @outstring3 where  current of sqls~r~n" + &
//"		fetch sqls into @sql, @num~r~n" + &
//"	end~r~n" + &
//"close sqls~r~n" + &
//"deallocate sqls~r~n" 
//
//
////Added By Mark Lee 08/14/12 add adjuge free space for database
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'sp_sys_set' AND TYPE = 'P')~r~n" + &
//"BEGIN~r~n" + &
//"	DROP PROCEDURE sp_sys_set~r~n" + &
//"END~r~n" 
//
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"~r~n" + &
//"CREATE PROCEDURE sp_sys_set(@arg VARCHAR(200),@outputs VARCHAR(1000) OUTPUT)~r~n" + &
//"AS~r~n" + &
//"BEGIN~r~n" + &
//"  DECLARE @sql NVARCHAR(500)~r~n" + &
//"  DECLARE @para NVARCHAR(500)~r~n" + &
//"  DECLARE @level INT~r~n" + &
//"  DECLARE @pos INT~r~n" + &
//"  DECLARE @p_version VARCHAR(50)~r~n" + &
//"~r~n" + &
//"  IF (@arg IS NULL ) OR (LTRIM(RTRIM(@arg)) = '')~r~n" + &
//"  BEGIN~r~n" + &
//"   RETURN ~r~n" + &
//"  END ~r~n" + &
//"  ELSE~r~n" + &
//"  BEGIN~r~n" + &
//"   IF @arg = 'compatibility_level' ~r~n" + &
//"   BEGIN~r~n" + &
//"    SET @p_version = CONVERT(VARCHAR(50),SERVERPROPERTY('PRODUCTVERSION'))~r~n" + &
//"    SET @pos = CHARINDEX('.',LTRIM(RTRIM(@p_version)))~r~n" + &
//"    IF @pos > 0 AND ( Isnumeric(LEFT(@p_version,@pos - 1)) > 0 )~r~n" + &
//"    BEGIN~r~n" + &
//"     SET @pos = convert(INT,LEFT(@p_version,@pos - 1))~r~n" + &
//"     IF @pos > 8 ~r~n" + &
//"     BEGIN~r~n" + &
//"      SET @sql = 'select @level = compatibility_level from sys.databases where name = db_name()'~r~n" + &
//"      SET @para = '@level int output'~r~n" + &
//"      EXEC SP_EXECUTESQL @sql, @para,@level OUTPUT~r~n" + &
//"      SELECT @outputs = convert(VARCHAR(1000),@level)~r~n" + &
//"     END~r~n" + &
//"     ELSE IF @pos <= 8 ~r~n" + &
//"     BEGIN~r~n" + &
//"      SET @sql = 'select  @level = cmptlevel from master.dbo.sysdatabases where name = db_name()'~r~n" + &
//"      SET @para = '@level int output'~r~n" + &
//"      EXEC SP_EXECUTESQL @sql, @para,@level OUTPUT~r~n" + &
//"      SELECT @outputs = convert(VARCHAR(1000),@level)~r~n" + &
//"     END~r~n" + &
//"    END ~r~n" + &
//"    ~r~n" + &
//"    RETURN~r~n" + &
//"   END ~r~n" + &
//"   ELSE IF @arg = 'freespace' ~r~n" + &
//"   BEGIN~r~n" + &
//" DECLARE @drivename CHAR(1)~r~n" + &
//" DECLARE @drivename2 CHAR(1)~r~n" + &
//" DECLARE @mb_free INT~r~n" + &
//" DECLARE @mb_free2 INT~r~n" + &
//"~r~n" + &
//" Select @outputs = ''~r~n" + &
//" SELECT @drivename=LEFT(filename,1) FROM sysfiles~r~n" + &
//" WHERE fileid = 1 ~r~n" + &
//"~r~n" + &
//" SELECT @drivename2=LEFT(filename,1) FROM sysfiles~r~n" + &
//" WHERE fileid = 2~r~n" + &
//"  ~r~n" + &
//" IF object_id('tempdb..#freespace') is not null ~r~n" + &
//" Begin~r~n" + &
//"  DROP TABLE #freespace~r~n" + &
//" End~r~n" + &
//" ~r~n" + &
//" CREATE TABLE #freespace(~r~n" + &
//" drive CHAR(1),~r~n" + &
//" mb_free INT~r~n" + &
//" )~r~n" + &
//"    ~r~n" + &
//" INSERT INTO #freespace~r~n" + &
//" EXEC xp_fixeddrives~r~n" + &
//"  ~r~n" + &
//" SELECT top 1 @mb_free = mb_free  FROM #freespace WHERE drive = @drivename~r~n" + &
//" SELECT top 1 @mb_free2 = mb_free FROM #freespace WHERE drive = @drivename2~r~n" + &
//"  ~r~n" + &
//" IF (isnumeric(@mb_free)= 1) and ( @mb_free < 50 ) ~r~n" + &
//" BEGIN~r~n" + &
//"  SELECT @outputs = '1The system detected that there is less than 50MB free disk space for your database.~r~n' +~r~n" + &
//"    'Please contact your database administrator to allocate more disk space ~r~n' +~r~n" + &
//"    'in order to avoid disrupting the normal operation of the system.'~r~n" + &
//" END~r~n" + &
//"  ~r~n" + &
//" IF (isnumeric(@mb_free2)= 1) and ( @mb_free2 < 50 ) ~r~n" + &
//" BEGIN~r~n" + &
//"  IF LEN(@outputs) = 0 ~r~n" + &
//"  BEGIN~r~n" + &
//"   SELECT @outputs = '2The system detected that there is less than 50MB free disk space for your database.~r~n' +~r~n" + &
//"     'Please contact your database administrator to allocate more disk space ~r~n' +~r~n" + &
//"     'in order to avoid disrupting the normal operation of the system.'~r~n" + &
//"  END         ~r~n" + &
//" END ~r~n" + &
//" ~r~n" + &
//" DROP TABLE #freespace~r~n" + &
//" ~r~n" + &
//" END~r~n" + &
//"~r~n" + &
//" END ~r~n" + &
//" ~r~n" + &
//"END ~r~n" + &
//""
//
//of_execute_sqls("of_ver115_release_storeprocedure1")
//
//


return 1
end function

public function integer of_ver120_release_table1 ();//====================================================================
// Function: of_ver120_release_table1
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
//Add SQL Here

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_notification' ) " + &
"alter table ctx_notification add alm_appointment varchar(2000) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_am_image_approve' ) " + &
"alter table ctx_am_image_approve add alm_appointment varchar(2000) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_am_image_approve_detail' ) " + &
"alter table ctx_am_image_approve_detail add alm_appointment varchar(200) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_am_document' ) " + &
"alter table ctx_am_document add alm_appointment varchar(2000) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Appointment_create' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add Appointment_create integer null  ~r~n"

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='Appointment_times' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add Appointment_times integer null  ~r~n"

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_ai_notification' ) " + &
"alter table ctx_ai_notification add alm_appointment varchar(2000) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_am_ai_notification' ) " + &
"alter table ctx_am_ai_notification add alm_appointment varchar(2000) null  ~r~n" 

//Added By gavins 20121022
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_appointment' and t.table_name='ctx_all_notification' ) " + &
"alter table ctx_all_notification add alm_appointment varchar(2000) null  ~r~n" 

//Added By Mark Lee 10/29/12
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='primary_doc' and t.table_name='ctx_am_document' ) " + &
"alter table ctx_am_document add primary_doc  char(1) null "

//Added By Mark Lee 11/12/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF Not EXISTS( select 1 from sysobjects  where name = 'ctx_search_user_filter' and type = 'U' ) ~r~n" + &
"Create table ctx_search_user_filter~r~n" + &
"(~r~n" + &
"column_name varchar(255) not null,~r~n" + &
"users_id varchar(50) not null,~r~n" + &
"sort varchar(1) not null,~r~n" + &
"col_type varchar(20) null,~r~n" + &
"lengths Integer null,~r~n" + &
"last_update datetime not null,~r~n" + &
"data_values varchar(500) null,~r~n" + &
"col_text varchar(500) null,~r~n" + &
"col_display varchar(500) null,~r~n" + &
"PRIMARY KEY (column_name ,users_id ,sort )~r~n" + &
") "

//Added By Ken.Guo 11/16/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_batch_alarm_analysis' )~r~n" + &
"~tCreate Table ctx_batch_alarm_analysis ~r~n" + &
"~t(~r~n" + &
"~t~tid  numeric(10,0) identity  not null,~r~n" + &
"~t~tclient_id varchar(20) not null,~r~n" + &
"~t~tscreen_id numeric(10,0) null,~r~n" + &
"~t~talm_table varchar(100)  null,~r~n" + &
"~t~talm_column varchar(100) null,~r~n" + &
"~t~tnotification_table varchar(100) null,~r~n" + &
"~t~ttv_handle numeric(10,0) null,~r~n" + &
"~t~tcount_notset numeric(10,0) null,~r~n" + &
"~t~tPrimary Key(id)~r~n" + &
"~t)"

//Begin - Added By Mark Lee 11/19/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_create_child' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_create_child bit ~r~n" + &
"End"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_copy_m_company' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_copy_m_company bit ~r~n" + &
"End"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='ib_copy_m_company_contact' and t.table_name='ctx_templates_info' ) " + &
"Begin~r~n" + &
"	Alter table ctx_templates_info add ib_copy_m_company_contact bit ~r~n" + &
"End"
//End - Added By Mark Lee 11/19/2012

//Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='receivedate' and t.table_name='em_smtp_accounts' ) " + &
"  alter table em_smtp_accounts add receivedate datetime null   ~r~n" 

//Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='protocol' and t.table_name='em_smtp_accounts' ) " + &
"  alter table em_smtp_accounts add protocol varchar(20) null   ~r~n" 
 
//Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &  
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='messageid' and t.table_name='em_user_msg_id' ) " + &
"  alter table em_user_msg_id add messageid varchar(200) null  ~r~n" 

  //Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='folder' and t.table_name='em_user_msg_id' ) " + &
 " alter table em_user_msg_id add folder varchar(200) null  ~r~n" 
  
  //Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='rfc822date' and t.table_name='em_user_msg_id' ) " + &
 " alter table em_user_msg_id add rfc822date varchar(100) null ~r~n" 

   //Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='protocoltype' and t.table_name='em_user_msg_id' ) " + &
"  alter table em_user_msg_id add protocoltype varchar(20) null  ~r~n" 

  //Added By gavins 20121121
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='protocoltype' and t.table_name='em_mail_items' ) " + &
 " alter table em_mail_items add protocoltype varchar(20) null  ~r~n" 

//Added By Mark Lee 11/26/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='use_tmp_directory' and t.table_name='export_header' ) " + &
"Begin~r~n" + &
"	Alter table export_header add use_tmp_directory int ~r~n" + &
"End"

//Added By Ken.Guo 11/29/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='sql_preview' and t.table_name='ctx_batch_alarm_analysis' ) " + &
"ALTER table ctx_batch_alarm_analysis add sql_preview varchar(8000) null  "

//Added By Ken.Guo 12/03/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='alm_column_lable' and t.table_name='ctx_batch_alarm_analysis' ) " + &
"ALTER table ctx_batch_alarm_analysis add alm_column_lable varchar(200) null  "

  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association2' and t.table_name='ctx_contract_contacts' ) " + &
 "alter table ctx_contract_contacts add association2 varchar(100) null   "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association3' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association3 varchar(100) null   "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association4' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association4 varchar(100) null   "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association5' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association5 varchar(100) null    "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association6' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association6 varchar(100) null    "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association7' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association7 varchar(100) null    "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association8' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association8 varchar(100) null    "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association9' and t.table_name='ctx_contract_contacts' ) " + &
 "alter table ctx_contract_contacts add association9 varchar(100) null    "
 
  //Added By gavins 20121203
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='association10' and t.table_name='ctx_contract_contacts' ) " + &
" alter table ctx_contract_contacts add association10 varchar(100) null    "

//Added By Mark Lee 12/06/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='sync_category' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add sync_category integer null  ~r~n"

//Added By Ken.Guo 12/07/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='count_all' and t.table_name='ctx_batch_alarm_analysis' ) " + &
"ALTER table ctx_batch_alarm_analysis add count_all integer null  "

//Added By Ken.Guo 12/19/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_triggered_view' and t.table_name='wf_workflow' ) " + &
"ALTER table wf_workflow add wf_triggered_view varchar(2000) null  "

//Added By Ken.Guo 12/19/2012
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='wf_triggered_ctx_status' and t.table_name='wf_workflow' ) " + &
"ALTER table wf_workflow add wf_triggered_ctx_status varchar(2000) null  "

//added by gavins 20121220    
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='file_modify' and t.table_name='ctx_am_image_approve' ) " + &
" alter table ctx_am_image_approve add file_modify int null ~r~n"
 
 //Added By Ken.Guo 12/26/2012
 is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id1_list' and t.table_name='em_mail_audit' ) " + &
"ALTER table em_mail_audit add level_id1_list varchar(5000) null  ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='level_id2_list' and t.table_name='em_mail_audit' ) " + &
"ALTER table em_mail_audit add level_id2_list varchar(5000) null  "
 
 //Added By Mark Lee 01/17/2013
  is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"IF not EXISTS(SELECT name  FROM  sysobjects WHERE  name = 'security_viewid_options'  AND ~t type = 'U')~r~n" + &
"CREATE TABLE security_viewid_options~r~n" + &
"(~r~n" + &
"view_id int not null,~r~n" + &
"option_name varchar(100)  not null,~r~n" + &
"option_value varchar(100) null,~r~n" + &
"last_update datetime null,~r~n" + &
"user_id varchar(50)  null,~r~n" + &
"Primary Key(view_id,option_name)~r~n" + &
"~t)"
 
//Added By Ken.Guo 01/23/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'system_options' )~r~n" + &
"~tCreate Table system_options ~r~n" + &
"~t(~r~n" + &
"option_name varchar(100)  not null,~r~n" + &
"option_value varchar(100) null,~r~n" + &
"last_update datetime null,~r~n" + &
"last_author varchar(50)  null,~r~n" + &
"Primary Key(option_name)~r~n" + &
"~t)"
 
 //Added By Ken.Guo 02/05/2013
 is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'ctx_pictures' )~r~n" + &
"~tCreate Table ctx_pictures ~r~n" + &
"~t(~r~n" + &
"~t~tid  numeric(10,0) not null,~r~n" + &
"~t~tfile_name varchar(255) null,~r~n" + &
"~t~tfile_image image null,~r~n" + &
"~t~tfile_ext varchar(20) null,~r~n" + &
"~t~tfile_height numeric(5) null,~r~n" + &
"~t~tfile_width numeric(5) null,~r~n" + &
"~t~tfile_size numeric(5) null,~r~n" + &
"~t~tlast_modified datetime null,~r~n" + &
"~t~tdescription varchar(500) null,~r~n" + &
"~t~tPrimary Key(id)~r~n" + &
"~t)~r~n" + &
""
 is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='picture_id' and t.table_name='ids' ) " + &
"ALTER table ids add picture_id int null  ~r~n" 

//Added By Mark Lee 02/20/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='access_utility_menu' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add access_utility_menu integer null  ~r~n"

//Added By Mark Lee 03/14/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='temp_usage' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add temp_usage integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dm_usage' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add dm_usage integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='negotiated' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add negotiated integer null  ~r~n"

//Added By Ken.Guo 03/20/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if  exists(select TOP 1 1 from sys.sysforeignkey  where role='FK_ctx_screen_datafill_ctx_screen') " + &
"  ALTER TABLE ctx_screen_datafill drop foreign key FK_ctx_screen_datafill_ctx_screen "
//"IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'FK_ctx_screen_datafill_ctx_screen') AND parent_object_id = OBJECT_ID(N'ctx_screen_datafill'))~r~n" + &
//"ALTER TABLE ctx_screen_datafill DROP CONSTRAINT FK_ctx_screen_datafill_ctx_screen~r~n" 

//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"ALTER TABLE ctx_screen_datafill  WITH CHECK ADD CONSTRAINT FK_ctx_screen_datafill_ctx_screen ~r~n" + &
//"FOREIGN KEY(data_view_id, screen_id)~r~n" + &
//"REFERENCES ctx_screen (data_view_id, screen_id)~r~n" + &
//"ON DELETE CASCADE~r~n" 

//Added By Mark Lee 03/25/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='temp_usage_last_date' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add temp_usage_last_date datetime null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dm_usage_last_date' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add dm_usage_last_date datetime null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='negotiated_last_date' and t.table_name='ctx_acp_clause' ) " + &
"ALTER table ctx_acp_clause add negotiated_last_date datetime null  ~r~n"

//Added By Ken.Guo 04/09/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font varchar(50) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font_size' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font_size integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font_text_color' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font_text_color numeric(10,0) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font_italy' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font_italy integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font_bold' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font_bold integer null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='font_underline' and t.table_name='ctx_user_tv_settings' ) " + &
"ALTER table ctx_user_tv_settings add font_underline integer null  ~r~n"

//Added By Mark Lee 05/09/2013 deal with if use a numeric from the string, we need replace point to quote in the Europe language, so we add this column.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dec_num' and t.table_name='security_viewid_options' ) " + &
"alter table security_viewid_options add dec_num decimal(15,6) null"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='dec_num' and t.table_name='security_user_options' ) " + &
"alter table security_user_options add dec_num decimal(15,6) null"

//Added By Mark Lee 06/10/2013 the column  tfield_name_allias does not enought longger.
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='tfield_name_allias' and t.table_name='sys_audit' ) " + &
"alter table sys_audit modify tfield_name_allias varchar(200) null ~r~n" 

//Added By Ken.Guo 07/03/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='sendprotocol' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add sendprotocol varchar(50) null  "

//Added By Ken.Guo 07/03/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='sendauthmode_exchange' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add sendauthmode_exchange integer null  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'em_exchange_uidl' )~r~n" + &
"~tCreate Table em_exchange_uidl ~r~n" + &
"~t(~r~n" + &
"~t~tid  numeric(10,0) identity  not null,~r~n" + &
"~t~tuser_id varchar(50) not null,~r~n" + &
"~t~temail_address varchar(100) not null,~r~n" + &
"~t~tuidl_file image null,~r~n" + &
"~t~tfile_size numeric(10,0) null,~r~n" + &
"~t~tmodified_date datetime null,~r~n" + &
"~t~tPrimary Key(id)~r~n" + &
"~t)~r~n" + &
""
//Added By Ken.Guo 07/27/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='getauthmode_exchange' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts add getauthmode_exchange integer null  "

//Added By Ken.Guo 08/06/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table em_mail_items modify mail_msg_id varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table em_user_msg_id modify mail_msg_id varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"alter table em_user_msg_id modify messageid varchar(500)"

//Added By Ken.Guo 08/15/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select 1 from sysobjects where name = 'report_auto_settings' )~r~n" + &
"~tCreate Table report_auto_settings ~r~n" + &
"~t(~r~n" + &
"~t~tid  numeric(10,0) identity  not null,~r~n" + &
"~t~treport_id int not null,~r~n" + &
"~t~toutput_type varchar(30) null,~r~n" + &
"~t~tfrequency int null,~r~n" + &
"~t~tinterval numeric(10,0) null,~r~n" + &
"~t~tactive_status int null,~r~n" + &
"~t~tlast_run datetime null,~r~n" + &
"~t~terror_code int null,~r~n" + &
"~t~trun_time datetime null,~r~n" + &
"~t~temail_subject varchar(500) null,~r~n" + &
"~t~temail_from varchar(500) null,~r~n" + &
"~t~temail_to varchar(500) null,~r~n" + &
"~t~temail_cc varchar(500) null,~r~n" + &
"~t~temail_message varchar(500) null,~r~n" + &
"~t~tPrimary Key(id)~r~n" + &
"~t)"


//Added By Ken.Guo 09/23/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='check_registry' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add check_registry integer null  "

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='check_trusted_sites' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add check_trusted_sites integer null  "

//Added By Jay Chen 10-18-2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='esign_type' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add esign_type varchar(50) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='echo_apicode' and t.table_name='icred_settings' ) " + &
"ALTER table icred_settings add echo_apicode varchar(50) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_fileid' and t.table_name='es_fileid' ) " + &
"ALTER table ctx_am_document modify es_fileid varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document modify es_docid varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_fileid' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit  modify es_fileid varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit  modify es_docid varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='es_docid' and t.table_name='ctx_am_action_item' ) " + &
"ALTER table ctx_am_action_item  modify es_docid varchar(500)"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='esign_type' and t.table_name='ctx_am_document' ) " + &
"ALTER table ctx_am_document add esign_type varchar(50) null  ~r~n"

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if not exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='esign_type' and t.table_name='ctx_am_doc_audit' ) " + &
"ALTER table ctx_am_doc_audit add esign_type varchar(50) null  ~r~n"

//Added By Ken.Guo 10/21/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
"if exists( select TOP 1 1 from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and " + &
"   c.column_name='server' and t.table_name='em_smtp_accounts' ) " + &
"ALTER table em_smtp_accounts modify server varchar(100) null  "

of_execute_sqls("of_ver120_release_table1")

Return 1
end function

public function integer of_ver120_release_view1 ();//====================================================================
// Function: of_ver120_release_view1
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//Add SQL Here

//e.g.
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//"CREATE VIEW v_ctx_custom2 ~r~n" + &
//"AS ~r~n" + &
//"SELECT     ctx_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, custom_7, custom_8, custom_9, custom_10, custom_11, custom_12,  ~r~n" + &
//"                      custom_13, custom_14, custom_15, custom_16, custom_17, custom_18, custom_19, custom_20, custom_date1, custom_date2, custom_date3,  ~r~n" + &
//"                      custom_date4, custom_date5, custom_date6, custom_date7, custom_date8, custom_date9, custom_date10, custom_date11, custom_date12,  ~r~n" + &
//"                      custom_date13, custom_date14, custom_date15, custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7, custom_n8,  ~r~n" + &
//"                      custom_n9, custom_n10, custom_n11, custom_n12, custom_n13, custom_n14, custom_n15, custom_n16, custom_n17, custom_n18, custom_n19,  ~r~n" + &
//"                      custom_n20, custom_n21, custom_n22, custom_n23, custom_n24, custom_n25, custom_21, custom_22, custom_notes_1, custom_notes_2,  ~r~n" + &
//"                      custom_notes_3, custom_notes_4, custom_notes_5, custom_money_1, custom_money_2, custom_money_3, custom_percent_1, custom_percent_2,  ~r~n" + &
//"                      custom_percent_3, custom_percent_4, custom_percent_5, custom_percent_6, custom_percent_7, custom_percent_8, custom_percent_9,  ~r~n" + &
//"                      custom_percent_10 ~r~n" + &
//"FROM         ctx_custom ~r~n" 

//Added gavins 20121203
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if exists (select TOP 1 1 from  sysobjects where  name='V_ctx_contract_contacts' and type = 'V')  " + &
"  drop view V_ctx_contract_contacts "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"CREATE VIEW  V_ctx_contract_contacts " + &
"AS SELECT     contact_id,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS contact_phone,  " + &
"          (SELECT     TOP 1 contact_email  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code   " + &
"                                         FROM          code_lookup AS code_lookup_2  " + &
"                                        WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Email')  )) ) AS contact_email,  " + &
"          (SELECT     TOP 1 phone  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"            WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id) AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup AS code_lookup_1  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Fax') )) ) AS contact_Fax,   " + &
"          (SELECT     TOP 1 ext  " + &
"            FROM          CTX_CONTACTS_NUMBERS AS A  " + &
"           WHERE      (contact_id = CTX_CONTRACT_CONTACTS.contact_id)  AND (via =  " + &
"                                       (SELECT     TOP 1 lookup_code  " + &
"                                         FROM          code_lookup  " + &
"                                         WHERE      (lookup_name = 'Contract Contact Via') AND (code = 'Phone') )) ) AS ext,   " + &
"            association, notes, owner, access, ctx_id, ic_area,default_email,  " + &
"				custom_n1,custom_n2,custom_n3,custom_percent_1,custom_percent_2,custom_1,custom_2,custom_3,association2, association3, association4, association5,association6, " + &
" association7,association8, association9, association10 " + &
"FROM         CTX_CONTRACT_CONTACTS  "

////Add 'association' -- gavins 20121203
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_contacts_internal' and type = 'V')  " + &
//"  drop view v_ctx_contacts_internal "
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//"CREATE VIEW v_ctx_contacts_internal AS~r~n" + &
//"SELECT TOP 100 PERCENT~r~n" + &
//"       CTX_BASIC_INFO.ctx_id,~r~n" + &
//"       app_facility.facility_name,~r~n" + &
//"       app_facility.contact as Company_Custom_ID#,~r~n" + &
//"       code_lookup.code AS contact_type_code,~r~n" + &
//"       code_lookup.description AS contact_type_description,~r~n" + &
//"       CTX_CONTACTS.first_name,~r~n" + &
//"       CTX_CONTACTS.last_name,~r~n" + &
//"       CTX_CONTACTS.middle_name,~r~n" + &
//"       code_lookup_4.description AS contact_title,~r~n" + &
//"       code_lookup_1.code AS contract_department_code,~r~n" + &
//"       code_lookup_1.description AS contract_department_des,~r~n" + &
//"       app_facility.street,~r~n" + &
//"       app_facility.street_2,~r~n" + &
//"       app_facility.street_3,~r~n" + &
//"       app_facility.city,~r~n" + &
//"       app_facility.zip,~r~n" + &
//"       app_facility.state,~r~n" + &
//"       CTX_CONTACTS.custom_1,~r~n" + &
//"       CTX_CONTACTS.custom_2,~r~n" + &
//"       CTX_CONTACTS.custom_3,~r~n" + &
//"       CTX_CONTACTS.custom_4,~r~n" + &
//"       CTX_CONTACTS.custom_5,~r~n" + &
//"       CTX_CONTACTS.custom_6,~r~n" + &
//"       CTX_CONTACTS.custom_7,~r~n" + &
//"       CTX_CONTACTS.custom_8,~r~n" + &
//"       CTX_CONTACTS.custom_9,~r~n" + &
//"       CTX_CONTACTS.custom_10,~r~n" + &
//"       v_ctx_contract_contacts.access,~r~n" + &
//"       v_ctx_contract_contacts.owner,~r~n" + &
//"       v_ctx_contract_contacts.notes,~r~n" + &
//"       v_ctx_contract_contacts.ext,~r~n" + &
//"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
//"       v_ctx_contract_contacts.contact_email,~r~n" + &
//"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
//"       NULL AS Phone_Type_code,~r~n" + &
//"       NULL AS Phone_type_Description,~r~n" + &
//"       v_ctx_contract_contacts.contact_id,~r~n" + &
//"       v_ctx_contract_contacts.association,~r~n" + &
//"       v_ctx_contract_contacts.association2,~r~n" + &
//"       v_ctx_contract_contacts.association3,~r~n" + &
//"       v_ctx_contract_contacts.association4,~r~n" + &
//"       v_ctx_contract_contacts.association5,~r~n" + &
//"       v_ctx_contract_contacts.association6,~r~n" + &
//"       v_ctx_contract_contacts.association7,~r~n" + &
//"       v_ctx_contract_contacts.association8,~r~n" + &
//"       v_ctx_contract_contacts.association9,~r~n" + &
//"       v_ctx_contract_contacts.association10,~r~n" + &
//"       v_ctx_contract_contacts.default_email as default_to~r~n" + &
//"  FROM CTX_CONTACTS~r~n" + &
//"       INNER JOIN v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
//"       INNER JOIN CTX_BASIC_INFO~r~n" + &
//"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
//"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
//" WHERE v_ctx_contract_contacts.ic_area='i'~r~n" + &
//"ORDER BY CTX_BASIC_INFO.ctx_id"
//
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"if exists (select TOP 1 1 from  sysobjects where  name='v_ctx_contacts_external' and type = 'V')  " + &
//"  drop view v_ctx_contacts_external "
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//"CREATE VIEW v_ctx_contacts_external AS~r~n" + &
//"SELECT TOP 100 PERCENT~r~n" + &
//"       CTX_BASIC_INFO.ctx_id,~r~n" + &
//"       app_facility.facility_name,~r~n" + &
//"       app_facility.contact as Company_Custom_ID#,~r~n" + &
//"       code_lookup.code AS contact_type_code,~r~n" + &
//"       code_lookup.description AS contact_type_description,~r~n" + &
//"       CTX_CONTACTS.first_name,~r~n" + &
//"       CTX_CONTACTS.last_name,~r~n" + &
//"       CTX_CONTACTS.middle_name,~r~n" + &
//"       code_lookup_4.description AS contact_title,~r~n" + &
//"       code_lookup_1.code AS contract_department_code,~r~n" + &
//"       code_lookup_1.description AS contract_department_des,~r~n" + &
//"       app_facility.street,~r~n" + &
//"       app_facility.street_2,~r~n" + &
//"       app_facility.street_3,~r~n" + &
//"       app_facility.city,~r~n" + &
//"       app_facility.zip,~r~n" + &
//"       app_facility.state,~r~n" + &
//"       CTX_CONTACTS.custom_1,~r~n" + &
//"       CTX_CONTACTS.custom_2,~r~n" + &
//"       CTX_CONTACTS.custom_3,~r~n" + &
//"       CTX_CONTACTS.custom_4,~r~n" + &
//"       CTX_CONTACTS.custom_5,~r~n" + &
//"       CTX_CONTACTS.custom_6,~r~n" + &
//"       CTX_CONTACTS.custom_7,~r~n" + &
//"       CTX_CONTACTS.custom_8,~r~n" + &
//"       CTX_CONTACTS.custom_9,~r~n" + &
//"       CTX_CONTACTS.custom_10,~r~n" + &
//"       v_ctx_contract_contacts.access,~r~n" + &
//"       v_ctx_contract_contacts.owner,~r~n" + &
//"       v_ctx_contract_contacts.notes,~r~n" + &
//"       v_ctx_contract_contacts.ext,~r~n" + &
//"       v_ctx_contract_contacts.contact_Fax,~r~n" + &
//"       v_ctx_contract_contacts.contact_email,~r~n" + &
//"       v_ctx_contract_contacts.contact_phone AS phone,~r~n" + &
//"			v_ctx_contract_contacts.custom_n1,~r~n" + &
//"			v_ctx_contract_contacts.custom_n2,~r~n" + &
//"			v_ctx_contract_contacts.custom_n3,~r~n" + &
//"			v_ctx_contract_contacts.custom_percent_1,~r~n" + &
//"			v_ctx_contract_contacts.custom_percent_2,~r~n" + &
//"			v_ctx_contract_contacts.custom_1 as contract_contact_custom_1,~r~n" + &
//"			v_ctx_contract_contacts.custom_2 as contract_contact_custom_2,~r~n" + &
//"			v_ctx_contract_contacts.custom_3 as contract_contact_custom_3,~r~n" + &
//"       NULL AS Phone_Type_code,~r~n" + &
//"       NULL AS Phone_type_Description,~r~n" + &
//"       v_ctx_contract_contacts.contact_id,~r~n" + &
//"       v_ctx_contract_contacts.association,~r~n" + &
//"       v_ctx_contract_contacts.association2,~r~n" + &
//"       v_ctx_contract_contacts.association3,~r~n" + &
//"       v_ctx_contract_contacts.association4,~r~n" + &
//"       v_ctx_contract_contacts.association5,~r~n" + &
//"       v_ctx_contract_contacts.association6,~r~n" + &
//"       v_ctx_contract_contacts.association7,~r~n" + &
//"       v_ctx_contract_contacts.association8,~r~n" + &
//"       v_ctx_contract_contacts.association9,~r~n" + &
//"       v_ctx_contract_contacts.association10,~r~n" + &
//"       v_ctx_contract_contacts.default_email as default_to  ~r~n" + &
//"  FROM CTX_CONTACTS~r~n" + &
//"       INNER JOIN~r~n" + &
//"       v_ctx_contract_contacts ON CTX_CONTACTS.contact_id = v_ctx_contract_contacts.contact_id~r~n" + &
//"       INNER JOIN CTX_BASIC_INFO~r~n" + &
//"       INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ON v_ctx_contract_contacts.ctx_id = CTX_BASIC_INFO.ctx_id~r~n" + &
//"       LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code~r~n" + &
//"       LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = Convert(varchar(50),code_lookup_4.lookup_code)~r~n" + &
//" WHERE v_ctx_contract_contacts.ic_area='e'~r~n" + &
//"ORDER BY CTX_BASIC_INFO.ctx_id"
//
//Added By Mark Lee 03/20/2013
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists(select 1 from sysobjects where name = 'v_clause_library') ~r~n" + &
"drop view v_clause_library ~r~n" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"Create View v_clause_library As    ~r~n" + &
"	SELECT ctx_acp_clause_id as clause_id,      ~r~n" + &
"		revision,          ~r~n" + &
"		folder_name = (select ctx_acp_folder.folder_name from ctx_acp_folder ~r~n" + &
"			where ctx_acp_folder.ctx_acp_folder_id = ctx_acp_clause.ctx_acp_folder_id ),           ~r~n" + &
"		clause_name,~r~n" + &
"        approved_by as reviewed_by,             ~r~n" + &
"        date_approved as date_reviewed, ~r~n" + &
"        approval_status as review_status,               ~r~n" + &
"        category,       ~r~n" + &
"        checkout_by,    ~r~n" + &
"        checkout_date,     ~r~n" + &
"        temp_usage as template_usage,~r~n" + &
"        dm_usage as document_manager_usage,    ~r~n" + &
"        negotiated,~r~n" + &
"        negotiated_percent =  (Case when dm_usage is null then 0.00~r~n" + &
"			when dm_usage = 0 then  0.00~r~n" + &
"			Else negotiated * 1.00 / dm_usage end )  , ~r~n" + &
"        description,    ~r~n" + &
"        information_message      ~r~n" + &
" FROM ctx_acp_clause"

of_execute_sqls("of_ver120_release_view1")

Return 1

end function

public function integer of_ver120_release_storeprocedure1 ();//====================================================================
// Function: of_ver120_release_storeprocedure1
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/19/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History: //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//
//====================================================================

//Added By Mark Lee 02/22/2013 for exec statement 
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'sp_exec_sql' AND TYPE = 'P')~r~n" + &
"BEGIN~r~n" + &
"	DROP PROCEDURE sp_exec_sql~r~n" + &
"END~r~n" 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Create PROCEDURE  sp_exec_sql (@arg VARCHAR(4000),@outputs VARCHAR(4000) OUTPUT) " + &
"AS " + &
"BEGIN " + &
"  DECLARE @sql VARCHAR(4000)   " + &
"  DECLARE @ErrorVar INT  " + &
"  IF (@arg IS NULL ) OR (LTRIM(RTRIM(@arg)) = '') " + &
"  BEGIN " + &
"	SELECT @outputs = '' " + &
"	RETURN  " + &
"  END  " + &
"  Execute(@arg)   " + &
"END "

//" Create PROCEDURE  sp_exec_sql (@arg VARCHAR(4000),@outputs VARCHAR(4000) OUTPUT)~r~n" + &
//"AS~r~n" + &
//"BEGIN~r~n" + &
//"  DECLARE @sql NVARCHAR(4000)  ~r~n" + &
//"  DECLARE @ErrorVar INT;  ~r~n" + &
//"  IF (@arg IS NULL ) OR (LTRIM(RTRIM(@arg)) = '')~r~n" + &
//"  BEGIN~r~n" + &
//"	SET @outputs = ''~r~n" + &
//"	RETURN ~r~n" + &
//"  END ~r~n" + &
//"  ~r~n" + &
//"  BEGIN TRY~r~n" + &
//"	Exec(@arg)~r~n" + &
//"  END TRY~r~n" + &
//"  BEGIN CATCH~r~n" + &
//"	SELECT @ErrorVar = @@ERROR~r~n" + &
//"	SELECT @outputs = 'SQL ERROR:'+CAST(@ErrorVar AS NVARCHAR(10)) + ' ERROR_MESSAGE:'+ ERROR_MESSAGE() ~r~n" + &
//"  END CATCH~r~n" + &
//"END "

////Added By Ken.Guo 11/21/2012
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"If Exists (SELECT name FROM sysobjects WHERE name = 'up_calculate_date_alarms' AND type = 'P')~r~n" + &
//"~tDROP PROCEDURE up_calculate_date_alarms~r~n" 
//
////You can NOT Change the KeyWord : 'Select Count(1)'    &   ') Where id ='     &    ') , count_all =' . They used by w_ctx_alarm_batch::of_gen_sql_report()
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"CREATE PROCEDURE up_calculate_date_alarms ~r~n" + &
//"(  ~r~n" + &
//"@as_client_id varchar(20)~t~t  ~r~n" + &
//")  ~r~n" + &
//"AS  ~r~n" + &
//"Begin  ~r~n" + &
//"~tDeclare @alm_table Varchar(100)~r~n" + &
//"~tDeclare @alm_column Varchar(100)~r~n" + &
//"~tDeclare @notification_table Varchar(100)~t~r~n" + &
//"~tDeclare @id numeric(10,0)~r~n" + &
//"~tDeclare @ls_sql varchar(8000)~r~n" + &
//"~tDeclare @ls_error varchar(100)~r~n" + &
//"~t~r~n" + &
//"~tDECLARE cur_alarms CURSOR FOR~r~n" + &
//"~tSELECT id,alm_table, alm_column,notification_table FROM ctx_batch_alarm_analysis~r~n" + &
//"~tWHERE client_id = @as_client_id~r~n" + &
//"~tORDER BY id~r~n" + &
//"~t~r~n" + &
//"~tOPEN cur_alarms~r~n" + &
//"~t~r~n" + &
//"~tFETCH NEXT FROM cur_alarms INTO @id,@alm_table, @alm_column, @notification_table~r~n" + &
//"~t~r~n" + &
//"~t~t~r~n" + &
//"~tWHILE @@FETCH_STATUS = 0~r~n" + &
//"~tBEGIN~r~n" + &
//"~t~tIf @alm_table = 'ctx_basic_info' or @alm_table = 'ctx_custom'~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ' +@alm_table + ',ic_client_data Where '+@alm_table+'.ctx_id = ic_client_data.data_int and  ic_client_data.client_id = ''' + @as_client_id + ~r~n" + &
//"~t~t~t''' And '+@alm_table+'.ctx_id > 0 and ' + @alm_table + '.' + @alm_column + ' is not null and Not Exists(Select 1 From '+ @notification_table +~r~n" + &
//"~t~t~t' Where '+@notification_table+'.ctx_id = '+@alm_table+'.ctx_id and '+~r~n" + &
//"~t~t~t@notification_table+'.alm_column = '''+@alm_column+''' and '+@notification_table+'.alm_table = '''+@alm_table +''' ) ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ' +@alm_table + ',ic_client_data Where '+@alm_table+'.ctx_id = ic_client_data.data_int and  ic_client_data.client_id = ''' + @as_client_id + ~r~n" + &
//"~t~t~t''' And '+@alm_table+'.ctx_id > 0 and ' + @alm_table + '.' + @alm_column + ' is not null~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~t~tElse If @alm_table = 'ctx_fee_sched_nm'~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_fee_sched_nm ,ic_client_data Where ctx_fee_sched_nm.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_fee_sched_nm.ctx_id > 0 and ctx_fee_sched_nm.' + @alm_column + ' is not null and Not Exists(Select 1 From ctx_all_notification Where ctx_all_notification.ctx_id = ctx_fee_sched_nm.ctx_id and ' + ~r~n" + &
//"~t~t~t' ctx_fee_sched_nm.fee_sched_nm_id = ctx_all_notification.level_id1 and ctx_all_notification.alm_column = '''+@alm_column+''' and ctx_all_notification.alm_table = ''ctx_fee_sched_nm'' ) ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_fee_sched_nm ,ic_client_data Where ctx_fee_sched_nm.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_fee_sched_nm.ctx_id > 0 and ctx_fee_sched_nm.' + @alm_column + ' is not null ~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~t~tElse If @alm_table = 'ctx_am_action_item'~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_am_action_item,ctx_am_document,ic_client_data Where ctx_am_action_item.doc_id = ctx_am_document.doc_id ~r~n" + &
//"~t~t~tand ctx_am_document.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_am_document.ctx_id > 0 and ctx_am_action_item.' + @alm_column   + ' is not null and Not Exists(Select 1 From ctx_am_ai_notification' +~r~n" + &
//"~t~t~t' Where ctx_am_ai_notification.doc_id = ctx_am_action_item.doc_id and ctx_am_ai_notification.seq_id = ctx_am_action_item.seq_id ~r~n" + &
//"~t~t~tand ctx_am_ai_notification.alm_column = '''+@alm_column+''' and ctx_am_ai_notification.alm_table = ''ctx_am_action_item'' ) ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_am_action_item,ctx_am_document,ic_client_data Where ctx_am_action_item.doc_id = ctx_am_document.doc_id ~r~n" + &
//"~t~t~tand ctx_am_document.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_am_document.ctx_id > 0 and ctx_am_action_item.' + @alm_column   + ' is not null ~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~t~tElse If @alm_table = 'ctx_action_item'~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_action_items,ic_client_data Where ctx_action_items.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_action_items.ctx_id > 0 and ctx_action_items.' + @alm_column   + ' is not null and Not Exists(Select 1 From ctx_ai_notification Where ctx_ai_notification.ctx_id = ctx_action_items.ctx_id ~r~n" + &
//"~t~t~tand ctx_action_items.ctx_action_item_id =  ctx_ai_notification.ctx_action_item_id and ctx_ai_notification.alm_column = '''+@alm_column+''' and ctx_ai_notification.alm_table = ''ctx_action_item'')  ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From ctx_action_items,ic_client_data Where ctx_action_items.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And ctx_action_items.ctx_id > 0 and ctx_action_items.' + @alm_column   + ' is not null ~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~t~tElse If @alm_table = 'CTX_CUSTOM_MULTI_HDR' ~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From CTX_CUSTOM_MULTI_HDR,ic_client_data Where CTX_CUSTOM_MULTI_HDR.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And CTX_CUSTOM_MULTI_HDR.ctx_id > 0 and CTX_CUSTOM_MULTI_HDR.' + @alm_column   + ' is not null and Not Exists(Select 1 From ctx_all_notification Where ctx_all_notification.ctx_id = CTX_CUSTOM_MULTI_HDR.ctx_id ~r~n" + &
//"~t~t~tand CTX_CUSTOM_MULTI_HDR.hdr_id = ctx_all_notification.level_id1 and ctx_all_notification.alm_column = '''+@alm_column+''' and ctx_all_notification.alm_table = ''CTX_CUSTOM_MULTI_HDR'' ) ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From CTX_CUSTOM_MULTI_HDR,ic_client_data Where CTX_CUSTOM_MULTI_HDR.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And CTX_CUSTOM_MULTI_HDR.ctx_id > 0 and CTX_CUSTOM_MULTI_HDR.' + @alm_column   + ' is not null ~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~r~n" + &
//"~t~tElse If @alm_table = 'CTX_CUSTOM_MULTI_DETAIL'~r~n" + &
//"~t~t~tSelect @ls_sql = 'Update ctx_batch_alarm_analysis Set count_notset = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From CTX_CUSTOM_MULTI_DETAIL,ic_client_data Where CTX_CUSTOM_MULTI_DETAIL.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And CTX_CUSTOM_MULTI_DETAIL.ctx_id > 0 and CTX_CUSTOM_MULTI_DETAIL.' + @alm_column   + ' is not null and Not Exists(Select 1 From ctx_all_notification Where ctx_all_notification.ctx_id = CTX_CUSTOM_MULTI_DETAIL.ctx_id and CTX_CUSTOM_MULTI_DETAIL.hdr_id = ctx_all_notification.level_id1 ~r~n" + &
//"~t~t~tand CTX_CUSTOM_MULTI_DETAIL.detail_id = ctx_all_notification.level_id2 and ctx_all_notification.alm_column = '''+@alm_column+''' and ctx_all_notification.alm_table = ''CTX_CUSTOM_MULTI_DETAIL'' ) ~r~n" + &
//"~t~t~t) , count_all = ~r~n" + &
//"~t~t~t(~r~n" + &
//"~t~t~tSelect Count(1) From CTX_CUSTOM_MULTI_DETAIL,ic_client_data Where CTX_CUSTOM_MULTI_DETAIL.ctx_id = ic_client_data.data_int and ic_client_data.client_id = ''' + @as_client_id +~r~n" + &
//"~t~t~t''' And CTX_CUSTOM_MULTI_DETAIL.ctx_id > 0 and CTX_CUSTOM_MULTI_DETAIL.' + @alm_column   + ' is not null ~r~n" + &
//"~t~t~t) Where id = '+ convert(Varchar(20),@id)~r~n" + &
//"~t~tElse~r~n" + &
//"~t~t~tBegin~r~n" + &
//"~t~t~t~tSelect 'Error, Not match',@alm_table,@alm_column~r~n" + &
//"~t~t~t~tFETCH NEXT FROM cur_alarms INTO @id,@alm_table, @alm_column, @notification_table~r~n" + &
//"~t~t~t~tContinue~t~r~n" + &
//"~t~t~tEnd~t~r~n" + &
//"~r~n" + &
//"~t~tEXEC (@ls_sql)~r~n" + &
//"~t~tUpdate ~tctx_batch_alarm_analysis Set sql_preview = @ls_sql Where id = @id~r~n" + &
//"~r~n" + &
//"~t~tSelect @ls_error = Convert(varchar(100), @@error)~r~n" + &
//"~t~tIf @ls_error <> '0' ~r~n" + &
//"~t~t~tInsert sys_debug_log(value, debug_date) Values('SP execute error '+@ls_error+'. SQL = '+ @ls_sql,getdate())~r~n" + &
//"~r~n" + &
//"~t~tFETCH NEXT FROM cur_alarms INTO @id,@alm_table, @alm_column, @notification_table~r~n" + &
//"~tEND~r~n" + &
//"~t~r~n" + &
//"~tCLOSE cur_alarms~r~n" + &
//"~tDEALLOCATE cur_alarms~r~n" + &
//"End "


////Added By Mark Lee 02/28/2013
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"IF EXISTS (SELECT name FROM sysobjects WHERE name = 'up_copy_lookup_data' AND TYPE = 'P')~r~n" + &
//"BEGIN~r~n" + &
//"	DROP PROCEDURE up_copy_lookup_data~r~n" + &
//"END~r~n" 
//
////Added By Mark Lee 10/18/2013
//is_sql_statements[upperbound(is_sql_statements) + 1] = &
//"CREATE Procedure  up_copy_lookup_data~r~n" + &
//" @SourceDBName nvarchar(100),  ~r~n" + &
//" @TargetDBName nvarchar(100),  ~r~n" + &
//" @lookup_name varchar(50),~r~n" + &
//" @ExistData integer,  ~r~n" + &
//" @UpdateData integer~r~n" + &
//"As  ~r~n" + &
//"Begin  ~r~n" + &
//" Declare @SqlString Nvarchar(4000)  ~r~n" + &
//" Declare @sql~t~tvarchar(4000), @sqls~t~tvarchar(4000)~r~n" + &
//" Declare @existsor int, @max_lookup_code int~r~n" + &
//" Declare @lookup_code int~r~n" + &
//" Declare @code varchar(50)~r~n" + &
//" DECLARE @ParmDefinition nvarchar(500) ~r~n" + &
//" ~r~n" + &
//" Select @sqls = 'SELECT distinct code FROM '+@SourceDBName+'.dbo.code_lookup WHERE lookup_name NOT IN ~r~n" + &
//"~t~t~t~t~t~t(SELECT lookup_name FROM '+@SourceDBName+'.dbo.sys_lookup ) and lookup_name = '''+@lookup_name+''' '~r~n" + &
//" ~r~n" + &
//" Exec('Declare code_lookup_cursor CURSOR FOR ' + @sqls) ~r~n" + &
//" Open code_lookup_cursor;~r~n" + &
//" Fetch Next From code_lookup_cursor Into @code ;~r~n" + &
//" ~r~n" + &
//" While @@FETCH_STATUS = 0 ~r~n" + &
//" Begin ~r~n" + &
//"~t SET @ParmDefinition = N'@existsor integer OUTPUT, @lookup_code integer OUTPUT' ~r~n" + &
//"~t~r~n" + &
//"~t /* adjust the data exist or not '+@TargetDBName+N'.dbo. */~r~n" + &
//"~t select @SqlString = N'SELECT @existsor = count(1), @lookup_code = lookup_code FROM '+@TargetDBName+N'.dbo.code_lookup WHERE lookup_name NOT IN ~r~n" + &
//"~t~t~t~t~t~t~t(SELECT lookup_name FROM '+@TargetDBName+N'.dbo.sys_lookup ) and lookup_name = '''+@lookup_name +N'''and code ='''+ @code + N''' Group by lookup_code '~r~n" + &
//"~t exec sp_executesql @SqlString, @ParmDefinition, @existsor OUTPUT, @lookup_code OUTPUT ; ~r~n" + &
//"~r~n" + &
//"~t If (@existsor is null or @existsor = 0  )~r~n" + &
//"~t Begin~r~n" + &
//"~t~t/* insert */~r~n" + &
//"~t~tselect @SqlString = N'Select @max_lookup_code = MAX(lookup_code) From '+@TargetDBName+N'.dbo.code_lookup '~r~n" + &
//"~t~texec sp_executesql @SqlString, N'@max_lookup_code integer OUTPUT', @max_lookup_code = @max_lookup_code OUTPUT;~r~n" + &
//"~t~tSelect @max_lookup_code = @max_lookup_code + 1~r~n" + &
//"~r~n" + &
//"~t~tselect @sql = 'INSERT INTO '+@TargetDBName+'.dbo.code_lookup (lookup_code,lookup_name,code,description~r~n" + &
//"~t~t~t   ,type,custom_1,custom_2,custom_3,custom_4,custom_5,custom_6,caqh_code,ic_n,ic_c,modify_date,Large_Description_1~r~n" + &
//"~t~t~t   ,Large_Description_2,Money_1,Money_2,Integer_1,Integer_2,Integer_3,Integer_4,Integer_5,Integer_6,Integer_7~r~n" + &
//"~t~t~t   ,Integer_8,datetime_1,datetime_2)~r~n" + &
//"~t~t~t~tSELECT Top 1 '+Cast(@max_lookup_code as varchar)+',lookup_name,code,description,type,custom_1~r~n" + &
//"~t~t~t~t  ,custom_2,custom_3,custom_4,custom_5,custom_6,caqh_code,ic_n,ic_c, GETDATE(),Large_Description_1,Large_Description_2~r~n" + &
//"~t~t~t~t  ,Money_1,Money_2,Integer_1,Integer_2,Integer_3,Integer_4,Integer_5,Integer_6,Integer_7,Integer_8,datetime_1,datetime_2~r~n" + &
//"~t~t~t~t  FROM '+@SourceDBName+'.dbo.code_lookup where lookup_name = '''+@lookup_name+''' and code = '''+@code+''' '~r~n" + &
//"~t~texecute (@sql)~r~n" + &
//"~t End ~r~n" + &
//"~t Else~r~n" + &
//"~t Begin~r~n" + &
//"~t~tIf (@ExistData = 0 and @UpdateData = 1 )~r~n" + &
//"~t~tBegin~r~n" + &
//"~t~t~tselect @sql =  'UPDATE '+@TargetDBName+'.dbo.code_lookup ~r~n" + &
//"~t~t~t~tSET lookup_name = b.lookup_name,code = b.code,description = b.description,type = b.type,custom_1 = b.custom_1~r~n" + &
//"~t~t~t~t~t,custom_2 = b.custom_2,custom_3 = b.custom_3,custom_4 = b.custom_4,custom_5 = b.custom_5,custom_6 = b.custom_6~r~n" + &
//"~t~t~t~t~t,caqh_code = b.caqh_code,ic_n = b.ic_n,ic_c = b.ic_c,modify_date = GETDATE() ,Large_Description_1 = b.Large_Description_1~r~n" + &
//"~t~t~t~t~t,Large_Description_2 = b.Large_Description_2,Money_1 = b.Money_1,Money_2 = b.Money_2,Integer_1 = b.Integer_1~r~n" + &
//"~t~t~t~t~t,Integer_2 = b.Integer_2,Integer_3 = b.Integer_3,Integer_4 = b.Integer_4,Integer_5 = b.Integer_5,Integer_6 = b.Integer_6~r~n" + &
//"~t~t~t~t~t,Integer_7 = b.Integer_7,Integer_8 = b.Integer_8,datetime_1 = b.datetime_1,datetime_2 = b.datetime_2~r~n" + &
//"~t~t~t~t~tFrom '+@SourceDBName+'.dbo.code_lookup b ,'+@TargetDBName+'.dbo.code_lookup a ~r~n" + &
//"~t~t~t~t~tWHERE  b.lookup_name = '''+@lookup_name+''' and b.code = '''+@code+''' and a.lookup_code = '+Cast(@lookup_code as varchar)~r~n" + &
//"~t~t~texecute (@sql)~r~n" + &
//"~t~tEnd ~r~n" + &
//"~t~t~r~n" + &
//"~t End ~r~n" + &
//"~t Fetch Next From code_lookup_cursor Into @code ;~r~n" + &
//"  End ~r~n" + &
//"  CLOSE code_lookup_cursor;~r~n" + &
//"  DEALLOCATE code_lookup_cursor;~r~n" + &
//" ~r~n" + &
//" End ~r~n"
//
////dataflow - alfee 03.23.2010 (to avoid a bug in APB 6.0) 
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//	"if exists (select name from sysobjects where name = 'sp_appeon_pkeys' and type = 'P') " + &
//	"DROP PROCEDURE sp_appeon_pkeys "
//	
//is_sql_statements[UpperBound(is_sql_statements) + 1] = &
//	"CREATE PROCEDURE sp_appeon_pkeys (@table_name varchar(50)) " + &
//	"AS " + &
//	"BEGIN " + &
//	"	Execute sp_pkeys @table_name " + &
//	"END " 
//
////Added By Mark Lee 10/18/2013
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"if exists (SELECT name FROM sysobjects WHERE name = 'up_ImportView' AND type = 'P') " + &
//"    DROP PROCEDURE up_ImportView"
//
//is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
//"create procedure up_ImportView~r~n" +  &
//"~t@SourceDBName nvarchar(100),~r~n" + &
//"~t@TargetDBName nvarchar(100),~r~n" + &
//"~t@ViewID nvarchar(100),~r~n" + &
//"~t@NewViewName nvarchar(50)~r~n" + &
//"As~r~n" + &
//"Begin~r~n" + &
//"~tdeclare @MaxViewID~tnvarchar(100)~r~n" + &
//"~tdeclare @SqlString nvarchar(4000)~r~n" + &
//"~tdeclare @ParmDefinition nvarchar(100)~r~n" + &
//"~t~t~r~n" + &
//"~t/*Get Seq No*/~r~n" + &
//"~tselect @SqlString = 'select @MaxViewIDOUT = isnull(max(data_view_id),0) + 1  from ' + ~r~n" + &
//"~t~t~t~t~t~t@TargetDBName + '.dbo.data_view'~r~n" + &
//"~tselect @ParmDefinition = '@MaxViewIDOUT int Output'~r~n" + &
//"~texec sp_executesql @SqlString,@ParmDefinition,@MaxViewIDOUT=@MaxViewID output~r~n" + &
//"~t/*Insert Data_View Table*/~r~n" + &
//"~t/*select @SqlString = 'insert ' + @TargetDBName + '.dbo.data_view (data_view_id,data_view_name,type,type_c)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',''' + @NewViewName + ''' ,type,type_c from '  ~r~n" + &
//"~t~t~t+ @SourceDBName + '.dbo.data_view where data_view_id = ' + @ViewID*/~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.data_view (data_view_id,data_view_name,type,type_c,win_backcolor)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',''' + @NewViewName + ''' ,type,type_c,win_backcolor from '  ~r~n" + &
//"~t~t~t+ @SourceDBName + '.dbo.data_view where data_view_id = ' + @ViewID~r~n" + &
//"~t~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~t/*Insert Tab Properties Table*/~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_tabpage_properties (data_view_id~r~n" + &
//"~t~t~t~t~t~t,tabpage_name ,text,text_color ,icon_visible,icon_update_date,icon,backcolor,~r~n" + &
//"~t~t~t~t~t~ttab_backcolor,tab_icon)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',tabpage_name ,text,text_color ,icon_visible,~r~n" + &
//"~t~t~t~t~t~ticon_update_date,icon,backcolor,tab_backcolor,tab_icon from ' + @SourceDBName + ~r~n" + &
//"~t~t~t~t~t~t'.dbo.ctx_tabpage_properties where data_view_id = ' + @ViewID~r~n" + &
//"~t~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~t/*Insert Ctx_Screen Table*/~r~n" + &
//"~tselect  @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen (data_view_id,screen_id,tab_name,screen_name,~r~n" + &
//"~t~t~t~t~t~tdw_name,dataobject,description,dw_sql,create_date,modify_date,force_update,titlebar_visible,~r~n" + &
//"~t~t~t~t~t~ttitlebar_text,boarder_style,screen_visible, screen_style, grid_sql, grid_dataobject, grid_modify )'~r~n" + &
//"~tselect ~t@SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id,'   ~r~n" + &
//"~tselect  @SqlString = @SqlString + '  tab_name,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + 'screen_name,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         dw_name,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         dataobject, '  ~r~n" + &
//"~tselect  @SqlString = @SqlString + '         description, '  ~r~n" + &
//"~tselect  @SqlString = @SqlString + '         dw_sql,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         create_date,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         modify_date,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         force_update,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         titlebar_visible,'   ~r~n" + &
//"~tselect  @SqlString = @SqlString + '         titlebar_text,   '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         boarder_style,  '~r~n" + &
//"~tselect  @SqlString = @SqlString + '         screen_visible,  '~r~n" + &
//"~tselect  @SqlString = @SqlString + '~t~t~tscreen_style, '~r~n" + &
//"~tselect  @SqlString = @SqlString + '~t~t~tgrid_sql, '~r~n" + &
//"~tselect  @SqlString = @SqlString + '~t~t~tgrid_dataobject, '~r~n" + &
//"~tselect  @SqlString = @SqlString + '~t~t~tgrid_modify '~r~n" + &
//"~tselect  @SqlString = @SqlString + '~tfrom ' + @SourceDBName + '.dbo.ctx_screen'~r~n" + &
//"~tselect  @SqlString = @SqlString + '~twhere data_view_id = ' + @ViewID~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~t~r~n" + &
//"~t/*insert Data Fill Settings*/~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_datafill (data_view_id~r~n" + &
//"      ,screen_id~r~n" + &
//"      ,field_name~r~n" + &
//"      ,field_name_fill~r~n" + &
//"      ,field_name_map~r~n" + &
//"      ,modify_by~r~n" + &
//"      ,modify_date~r~n" + &
//"      ,Relative_Days)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id~r~n" + &
//"      ,field_name~r~n" + &
//"      ,field_name_fill~r~n" + &
//"      ,field_name_map~r~n" + &
//"      ,modify_by~r~n" + &
//"      ,modify_date~r~n" + &
//"      ,Relative_Days from ' + @SourceDBName + '.dbo.ctx_screen_datafill where data_view_id = ' + @ViewID ~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~t/*insert Field Depent Settings*/~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_field_depend (view_id~r~n" + &
//"      ,base_field~r~n" + &
//"      ,depend_field~r~n" + &
//"      ,base_screen_id~r~n" + &
//"      ,depend_screen_id~r~n" + &
//"      ,base_field_dispaly~r~n" + &
//"      ,depend_field_dispaly~r~n" + &
//"      ,base_screen_type~r~n" + &
//"      ,base_table~r~n" + &
//"      ,depend_table)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',base_field~r~n" + &
//"      ,depend_field~r~n" + &
//"      ,base_screen_id~r~n" + &
//"      ,depend_screen_id~r~n" + &
//"      ,base_field_dispaly~r~n" + &
//"      ,depend_field_dispaly~r~n" + &
//"      ,base_screen_type~r~n" + &
//"      ,base_table~r~n" + &
//"      ,depend_table from ' + @SourceDBName + '.dbo.ctx_screen_field_depend where view_id = ' + @ViewID ~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~t/*isnert field extend property*/~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.ctx_screen_field_ex (data_view_id~r~n" + &
//"      ,screen_id~r~n" + &
//"      ,field_name~r~n" + &
//"      ,field_add)'~r~n" + &
//"~tselect @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id~r~n" + &
//"      ,field_name~r~n" + &
//"      ,field_add from ' + @SourceDBName + '.dbo.ctx_screen_field_ex where data_view_id = ' + @ViewID ~r~n" + &
//"~texec sp_executesql @SqlString~r~n" + &
//"~tselect @SqlString = 'insert ' + @TargetDBName + '.dbo.conv_view_pic  ( view_id ~r~n" + &
//"~t~t~t,Screen_id ~r~n" + &
//"~t~t~t,pic_type ~r~n" + &
//"~t~t~t,pic_band ~r~n" + &
//"~t~t~t,pic_name ~r~n" + &
//"~t~t~t,pic_filename ~r~n" + &
//"~t~t~t,pic_bitmap ~r~n" + &
//"~t~t~t,pic_x ~r~n" + &
//"~t~t~t,pic_y ~r~n" + &
//"~t~t~t,pic_width ~r~n" + &
//"~t~t~t,pic_height ~r~n" + &
//"~t~t~t,pic_tag )' ~r~n" + &
//"select @SqlString = @SqlString + 'select ' + @MaxViewID + ',screen_id , ~r~n" + &
//"~t~t~t~t pic_type,  ~r~n" + &
//"~t~t~t~t pic_band,   ~r~n" + &
//"~t~t~t~t pic_name,   ~r~n" + &
//"~t~t~t~t substring( pic_filename,1,2 ) + ' +  ~r~n" + &
//"~t~t~t~t 'cast( ' + @MaxViewID + ' as varchar(10)) + ' +  ~r~n" + &
//"~t~t~t~t '''_''' + ' + cast( screen_id as varchar(10)) + ' +  ~r~n" + &
//"~t~t~t~t 'substring( pic_filename, charindex( ' + '''_''' +  ~r~n" + &
//"~t~t~t~t ',pic_filename, charindex( ' + '''_''' + ',pic_filename, 3 ) + 1 ),99)  ~r~n" + &
//"~t~t~t~t ,pic_bitmap  ~r~n" + &
//"~t~t~t~t  ,pic_x  ~r~n" + &
//"~t~t~t~t  ,pic_y  ~r~n" + &
//"~t~t~t~t  ,pic_width  ~r~n" + &
//"~t~t~t~t  ,pic_height  ~r~n" + &
//"~t~t~t~t  ,pic_tag    ~r~n" + &
//"~t~t~t~t  from '+ @SourceDBName +'.dbo.conv_view_pic where view_id = ' +   ~r~n" + &
//"~t~t~t~t  @ViewID + ' and pic_type = '+ '''screen''' ;~t ~r~n" + &
//"~texec sp_executesql @SqlString ~r~n" + &
//"~tselect Cast(@MaxViewID as int)~r~n" + &
//"end~r~n"

of_execute_sqls("of_ver120_release_storeprocedure1")


return 1
end function

on n_cst_update_asa_clx.create
call super::create
end on

on n_cst_update_asa_clx.destroy
call super::destroy
end on

