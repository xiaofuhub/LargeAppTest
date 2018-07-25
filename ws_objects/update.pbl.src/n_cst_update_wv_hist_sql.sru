$PBExportHeader$n_cst_update_wv_hist_sql.sru
forward
global type n_cst_update_wv_hist_sql from n_cst_update_wv_hist
end type
end forward

global type n_cst_update_wv_hist_sql from n_cst_update_wv_hist
end type

type variables
//for SQL Server - Alfee 12.10.2015
end variables

forward prototypes
public function integer of_startup_esign ()
public function integer of_startup_verify_db_setup ()
public function integer of_startup_verify_workflow_schema ()
public function integer of_startup_process ()
public function integer of_startup_dynamicgen_privviewopts_set ()
end prototypes

public function integer of_startup_esign ();is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select 1 from sysobjects where name = 'wv_esign_statement' and type = 'U') " + &
"CREATE TABLE wv_esign_statement " + &
"	(	facility_id					integer not null " + &
"		,appoint_type				char(1) not null " + &
"		,tab_type					varchar(30) not null " + &
"		,esign_statement			text  null " + &
"		,create_by 					varchar(10) null " + &
"		,create_date				datetime  null " + &
"		,last_updated_by 			varchar(10) null " + &
"		,last_updated_date			datetime  null " + &
"		, primary key (facility_id,appoint_type,tab_type) " + &
"	) "

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select 1 from sysobjects where name = 'wv_agreement_documents' and type = 'U') " + &
"CREATE TABLE wv_agreement_documents " + &
"	(	agreement_id				integer not null identity " + &
"		,facility_id					integer not null " + &
"		,appoint_type				char(1) not null " + &
"		,agreement_name				varchar(200) not null " + &
"		,file_type					varchar(10) not null default 'pdf' " + &
"		,file_data					image  null " + &
"		,description                varchar(255) null " + &
"		,create_by 					varchar(10) null " + &
"		,create_date				datetime  null " + &
"		,last_updated_by 			varchar(10) null " + &
"		,last_updated_date			datetime  null " + &
"		, primary key (agreement_id) " + &
"	) "

// Execute sqls
of_execute_sqls("of_startup_esign")

return 1
end function

public function integer of_startup_verify_db_setup ();is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='last_web_sql_update' and t.name='ids' and t.type = 'U') " + &
"alter table ids add last_web_sql_update datetime null "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='expiration_date' and t.name='security_users' and t.type = 'U') " + &
"ALTER TABLE security_users ADD expiration_date datetime null " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if exists ( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='user_password' and t.name='security_users' and t.type = 'U') " + &
"ALTER TABLE security_users alter column user_password varchar(255) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='object_key' and t.name='screen_help' and t.type = 'U') " + &
"ALTER TABLE screen_help	ADD object_key varchar(150) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='help_type' and t.name='screen_help' and t.type = 'U') " + &
"ALTER TABLE screen_help	ADD help_type varchar(150) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='available_to_user' and t.name='address_lookup' and t.type = 'U') " + &
"ALTER TABLE address_lookup ADD available_to_user varchar(30) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'security_roles_intellireport' and type = 'U') " + &
"CREATE TABLE security_roles_intellireport " + &
"			(report_id integer	NOT NULL " + &
"			, role_id integer NOT NULL  " + &
"			, access_rights integer NULL  " + &
"			, primary key (report_id, role_id)  " + &
"			)  " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='avail_status' and t.name='address_lookup' and t.type = 'U') " + &
"ALTER TABLE address_lookup ADD avail_status varchar(50) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='provider_agreement' and t.name='facility') " + &
"Begin " + &
"ALTER TABLE facility ADD provider_agreement varchar(255)  " + &
"End "
//"UPDATE facility SET provider_agreement = 'C:\IntelliCred\Application\Applications\Provider_Agreement.pdf' " + &

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_setting' and type = 'U') " + &
"Begin " + &
"CREATE TABLE wv_setting " + &  
"( " + &
"	wv_setting_id integer NULL , " + &
"	module_id integer NULL , " + &
"	setting_value  integer NULL , " + &
"	label    varchar (100) , " + &
"	detail   varchar (2000)  " + &
") " + &
"CREATE UNIQUE INDEX idx_unique_wvid ON wv_setting (wv_setting_id) " + &
"End "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_setting_audit_log' and type = 'U') " + &
"CREATE TABLE wv_setting_audit_log " + &
"	(wv_setting_audit_log_id integer " + &
"		, wv_setting_id integer " + &
"		, old_setting_value integer " + &
"		, new_setting_value integer " + &
"		, user_id varchar(100) " + &
"		, audit_date datetime " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_setting_option' and type = 'U') " + &
"CREATE TABLE wv_setting_option " + &
"		(wv_setting_option_id integer " + &
"			, wv_setting_id integer " + &
"			, option_value integer " + &
"			, option_desc_short varchar(100) " + &
"			, option_desc_long varchar(300) " + &
"		) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_affil_ltr_audit' and type = 'U') " + &
"CREATE TABLE wv_affil_ltr_audit " + &
"	(rec_id	integer " + &
"		, prac_id integer " + &
"		, user_id integer " + &
"		, audit_date datetime " + &
"		, ip_addr varchar(200) " + &
"	 )	"

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_security_right_action' and type = 'U') " + &
"CREATE TABLE wv_security_right_action " + &
"	(action_id integer " + &
"	, module_id integer " + &
"	, action_name varchar(200) " + &
"	, dddw_type integer " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_security_module' and type = 'U') " + &
"CREATE TABLE wv_security_module " + &
"	(module_id integer " + &
"	, software_version integer " + &
"	, parent_module_id integer " + &
"	, module_name varchar(200) " + &
"	)	" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_security_role_right' and type = 'U') " + &
"CREATE TABLE wv_security_role_right " + &
"	(role_right_id integer " + &
"	, role_id integer " + &
"	, action_id integer " + &
"	, value_id integer " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_security_user' and type = 'U') " + &
"CREATE TABLE wv_security_user " + &
"			(	user_id				integer " + &
"				, prac_id			integer " + &
"				, created_date		datetime " + &
"				, ip_addr			varchar(200) " + &
"				, hospital_name		varchar(200) " + &
"				, department_name	varchar(200) " + &
"				, address_line1		varchar(200) " + &
"				, address_line2		varchar(200) " + &
"				, city				varchar(200) " + &
"				, state				varchar(100) " + &
"				, zip				varchar(20) " + &
"				, logon_id			varchar(100) " + &
"				, logon_pwd			varchar(100) " + &
"				, status			integer " + &
"				, role_id			integer " + &
"				, user_type_id		integer	 " + &
"				, audit_type_id		integer " + &
"				, pref_win_top		integer " + &
"				, pref_win_left		integer " + &
"				, pref_view_id		integer " + &
"				, pref_facility_id	integer " + &
"				, email_id			varchar(100)  " + &
"				, email_address		varchar(100) " + &
"				, date_pwd_updated	datetime " + &
"			)	" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_letter' and type = 'U') " + &
"CREATE TABLE wv_letter " + &
"	(	wv_letter_id			integer " + &
"		, letter_name			varchar(100) " + &
"		, document_name			varchar(100) " + &
"		, letter_desc			varchar(200) " + &
"		, document_special_path	varchar(200) " + &
"		, letter_type_id		integer  " + &
"	)	"


is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_letter_criterion' and type = 'U') " + &
"CREATE TABLE wv_letter_criterion " + &
"	(	wv_letter_criterion_id	integer " + &
"		, wv_letter_id			integer " + &
"		, field_name			varchar(200) " + &
"		, field_value			varchar(200) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_letter_audit_log' and type = 'U') " + &
"CREATE TABLE wv_letter_audit_log  " + &
"	(	wv_letter_audit_log_id	integer " + &
"		, wv_letter_id			integer " + &
"		, original_file_name	varchar(100) " + &
"		, backup_file_name		varchar(100) " + &
"		, result_file_name		varchar(100) " + &
"		, user_id				varchar(100) " + &
"		, audit_date			datetime " + &
"	) " 
	
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_report_que' and type = 'U') " + &
"CREATE TABLE wv_report_que " + &
"	( " + &
"	    report_que_id          integer                        not null " + &
"	    , report_id            integer                        not null " + &
"	    , report_name          varchar(100)                   not null " + &
"	    , user_name            varchar(100)                   not null " + &
"	    , status               char(1)                        not null default '0' " + &
"	    , file_name            varchar(255) " + &
"	    , primary key (report_que_id) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_report_que_det' and type = 'U') " + &
"CREATE TABLE wv_report_que_det " + &
"	( " + &
"	    report_det_id        integer                        not null " + &
"	    , report_que_id        integer                        not null " + &
"	    , wizard_seq_no        float                          not null " + &
"	    , iprimary             integer                         default '0' " + &
"	    , additional           integer                         default '0' " + &
"	    , billing              integer                         default '0' " + &
"	    , home                 integer                         default '0' " + &
"	    , mailing              integer                         default '0' " + &
"	    , selected             integer " + &
"	    , code                 integer " + &
"	    , lookup_code          integer " + &
"	    , provider_type        varchar(50) " + &
"	    , user_id              varchar(50) " + &
"	    , from_date            datetime " + &
"	    , to_date              datetime " + &
"	    , p_status             integer " + &
"	    , prac_id              integer " + &
"	    , facility_id          integer " + &
"		, num_days             integer " + &
"		, group_prac           numeric(8,0) " + &
"		, multi_group          numeric(8,0) " + &
"	    , active               integer " + &
"	    , pending              integer " + &
"	    , inactive             integer " + &
"	    , history              integer " + &
"	    , primary key (report_det_id, report_que_id) " + &
"	)	 "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'e_signature' and type = 'U') " + &
"CREATE TABLE e_signature  " + &
"	(	rec_id					numeric(10,0) " + &
"		, prac_id				numeric(8,0) " + &
"	    , user_id		        varchar(150) " + &
"	    , computer_id	        varchar(50) " + &
"		, signature_notes		TEXT " + &
"		, signature_date		datetime " + &
"		, primary key (rec_id) " + &
"	) " 
	
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'priv_form' and type = 'U') " + &
"CREATE TABLE priv_form " + &
"	(	priv_form_id			numeric(10,0) " + &
"		, clinical_area_id		numeric(8,0) " + &
"		, priv_core_id			numeric(8,0) " + &
"	    , form_name		        varchar(150) " + &
"		, primary key (priv_form_id) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'priv_form_priv' and type = 'U') " + &
"CREATE TABLE priv_form_priv " + &
"	(	priv_form_priv_id		numeric(10,0) " + &
"		, priv_form_id			numeric(8,0) " + &
"		, procd_id				numeric(8,0) " + &
"		, primary key (priv_form_priv_id) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'agreement' and type = 'U') " + &
"CREATE TABLE agreement " + &
"	(	agreement_id			numeric(10,0) " + &
"		, facility_id			numeric(8,0) " + &
"	    , agreement_file        varchar(250) " + &
"		, primary key (agreement_id) " + &
"	)	" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'sys_painter' and type = 'U') " + &
"CREATE TABLE sys_painter " + &
"	(	painter_id				numeric(10,0) " + &
"	    , name		       	 	varchar(250) " + &
"		, description			TEXT " + &
"	    , active_as_of_version	numeric(10,0) " + &
"	    , webview               integer " + &
"	    , intellicred           integer " + &
"		, module_key			varchar(250) " + &
"		, primary key (painter_id) " + &
"	)	" 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'sys_login_audit' and type = 'U') " + &
"CREATE TABLE sys_login_audit " + &
"	(	rec_id					numeric(10,0) " + &
"	    , user_id	       	 	varchar(250) " + &
"		, login_date			datetime " + &
"	    , computer_id			varchar(250) " + &
"	    , computer_id2			varchar(250) " + &
"	    , application           integer " + &
"	    , success	            integer " + &
"		, primary key (rec_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'sys_error_log' and type = 'U') " + &
"CREATE TABLE sys_error_log " + &
"	(	rec_id					numeric(10,0) " + &
"	    , user_id	       	 	varchar(250) " + &
"		, error_date			datetime " + &
"	    , computer_id			varchar(250) " + &
"	    , browser				varchar(250) " + &
"	    , referrer				varchar(250) " + &
"	    , template				varchar(250) " + &
"	    , query_string			varchar(250) " + &
"	    , application           integer " + &
"		, diagnostics			TEXT " + &
"		, session_dump			TEXT " + &
"		, request_dump			TEXT " + &
"		, primary key (rec_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'sys_event_log' and type = 'U') " + &
"CREATE TABLE sys_event_log " + &
"	(	rec_id					numeric(10,0) " + &
"	    , user_id	       	 	varchar(250) " + &
"		, event_date			datetime " + &
"	    , computer_id			varchar(250) " + &
"	    , browser				varchar(250) " + &
"	    , referrer				varchar(250) " + &
"	    , template				varchar(250) " + &
"	    , query_string			varchar(250) " + &
"	    , application           integer " + &
"		, event_details			TEXT " + &
"		, primary key (rec_id) " + &
"	) " 
	
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_ldap_settings' and type = 'U') " + &
"create table wv_ldap_settings " + &
"	( " + &
"		appName       varchar(50) not null primary key, " + &
"		server_type   varchar(30), " + &
"		server_name   varchar(20), " + &
"		port          integer, " + &
"		start_str     varchar(255), " + &
"		filter        varchar(255), " + &
"		userdn        varchar(255), " + &
"		username      varchar(255), " + &
"		password      varchar(255), " + &
"		domain        varchar(30), " + &
"		custom_1      varchar(30), " + &
"		custom_2      varchar(30), " + &
"		custom_3      varchar(30) " + &
"	) " 
			
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_ldap_users' and type = 'U') " + &
"create table wv_ldap_users  " + &
"	( " + &
"		appName       varchar(50) not null, " + &
"		userAlias     varchar(20) not null, " + &
"		userdn		  varchar(255) not null, " + &
"		custom_1      varchar(30), " + &
"		custom_2      varchar(30), " + &
"		custom_3      varchar(30), " + &
"		Primary key (appName,userAlias) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_prac_de_status' and type = 'U') " + &
"Create table wv_prac_de_status ( " + &
"	Track_id numeric(16,0) not null, " + &
"	Prac_id numeric(16,0) not null, " + &
"	Facility_id numeric(16,0) null , " + &
"	Appt_stat_id numeric(16,0) not null, " + &
"	Screen_id integer null, " + &
"	Status integer null, " + &
"	Primary key (track_id) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wv_aff_letter_attest' and type = 'U') " + &
"Create table wv_aff_letter_attest ( " + &
"	attest_id numeric(10,0) identity not null, " + &
"	user_id varchar(30) null, " + &
"	attest_date datetime null, " + &
"	facility_name varchar(75) null, " + &
"	prac_id numeric(10,0) null, " + &
"	primary key (attest_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='esign_required' and t.name='wv_agreement_documents' and t.type = 'U') " + &
"ALTER TABLE  wv_agreement_documents ADD esign_required INTEGER "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='esign_text' and t.name='wv_agreement_documents' and t.type = 'U') " + &
"ALTER TABLE  wv_agreement_documents ADD esign_text VARCHAR(5000) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='esign_text' and t.name='wv_esign_log' and t.type = 'U') " + &
"ALTER TABLE wv_esign_log ADD esign_text VARCHAR(5000) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='agreement_id' and t.name='wv_esign_log' and t.type = 'U') " + &
"ALTER TABLE wv_esign_log ADD agreement_id NUMERIC(8,0) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " + &
"   c.name='letter_file' and t.name='wv_letter' and t.type = 'U') " + &
"ALTER TABLE wv_letter ADD letter_file IMAGE "

//for SQL only
is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"declare @li_flag int " + &
"select @li_flag = columnproperty(object_id('wv_esign_log'),'rec_id','IsIdentity') from ids; " + &
"if @li_flag=0 " + &
"	begin " + &
"		CREATE TABLE wv_esign_log_tmp( " + &
"			rec_id				integer IDENTITY NOT NULL  " + &
"			,facility_id		integer NOT NULL  " + &
"			,tab_type			varchar(30) NOT NULL " + &
"			,user_id			char(15) NOT NULL " + &
"			,prac_id			integer  NULL " + &
"			,user_date			datetime  NULL " + &
"			,notes				varchar(255) NULL " + &
"			,app_status_id		NUMERIC(10,0) NULL " + &
"			,isdisabled			integer  NULL " + &
"			,esign_text			VARCHAR(5000) NULL " + &
"			,agreement_id		NUMERIC(8,0) NULL " + &
"			,primary key (rec_id) " + &
"		) " + &
"		SET IDENTITY_INSERT wv_esign_log_tmp OFF " + &
"		INSERT INTO wv_esign_log_tmp( " + &
"			facility_id " + &
"			, tab_type " + &
"			, user_id " + &
"			, prac_id " + &
"			, user_date " + &
"			, notes " + &
"			, app_status_id " + &
"			, isdisabled " + &
"			, esign_text " + &
"			, agreement_id " + &
"		) SELECT 	facility_id " + &
"			, tab_type " + &
"			, user_id " + &
"			, prac_id " + &
"			, user_date " + &
"			, notes " + &
"			, app_status_id " + &
"			, isdisabled " + &
"			, esign_text " + &
"			, agreement_id FROM wv_esign_log " + &
"		DROP TABLE wv_esign_log " + &
"		EXEC sp_rename 'wv_esign_log_tmp','wv_esign_log' " + &
"	end "

// Execute sqls
of_execute_sqls("of_startup_verify_db_setup")	
	
Return 1
end function

public function integer of_startup_verify_workflow_schema ();is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_hdr' and type = 'U') " + &
"CREATE TABLE wf_hdr " + &
"	(	wf_id	numeric(8,0) " + &
"		, wf_key		varchar(100) " + &
"		, wf_desc		varchar(200) " + &
"		, facility_id	integer " + &
"		, active		integer	 " + &	
"		, template		integer	 " + &
"		, parent_wf_id	integer " + &
"		, b_template	integer " + &
"		, primary key (wf_id) " + &
"	) " 

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_step' and type = 'U') " + &
"CREATE TABLE wf_step " + &
"	(	wf_id	numeric(8,0) " + &
"		, wf_step_id		numeric(8,0) " + &
"		, name				varchar(100) " + &
"		, description		varchar(200) " + &
"		, dashboard_text	varchar(200) " + &
"		, dept_id			numeric(8,0) " + &
"		, days				integer " + &
"		, sort_order		integer " + &
"		, b_visible_to_prac	integer " + &
"		, primary key (wf_step_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_trigger' and type = 'U') " + &	
"CREATE TABLE wf_trigger " + &
"	(	wf_id	numeric(8,0) " + &
"		, wf_trigger_id		numeric(8,0) " + &
"		, sql				text " + &
"		, module			varchar(100) " + &
"		, primary key (wf_trigger_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_step_action' and type = 'U') " + &
"CREATE TABLE wf_step_action " + &
"	(	wf_step_action_id		numeric(8,0) " + &
"		, wf_step_id			numeric(8,0) " + &
"		, action_status			varchar(100) " + &
"		, bFirstAction			integer " + &
"		, bLastAction			integer " + &
"		, bPostToCommittee		integer " + &
"		, committee_id			integer " + &
"		, sort_order			integer " + &
"		, autoselect			varchar(100) " + &
"		, onselect				varchar(100) " + &
"		, onafterselect			varchar(100) " + &
"		, onautoselect			varchar(100) " + &
"		, b_visible_to_prac		integer " + &
"		, primary key (wf_step_action_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_step_role' and type = 'U') " + &
"CREATE TABLE wf_step_role " + &
"	(	wf_step_role_id				numeric(8,0) " + &
"		, wf_step_id				numeric(8,0) " + &
"		, role_id					numeric(8,0) " + &
"		, access_id					integer " + &
"		, primary key (wf_step_role_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_step_action_role' and type = 'U') " + &
"CREATE TABLE wf_step_action_role " + &
"	(	wf_step_action_role_id		numeric(8,0) " + &
"		, wf_step_action_id			numeric(8,0) " + &
"		, role_id					numeric(8,0) " + &
"		, access_id					integer " + &
"		, wf_step_id				integer " + &
"		, primary key (wf_step_action_role_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_step_action_email' and type = 'U') " + &	
"CREATE TABLE wf_step_action_email " + &
"	(	email_id				numeric(8,0) " + &
"		, wf_step_action_id		numeric(8,0) " + &
"		, interval				integer " + &
"		, max_send				numeric(8,0) " + &
"		, email_type_id			numeric(8,0) " + &
"		, subject				varchar(150) " + &
"		, email_message			varchar(2000) " + &
"		, primary key (email_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'email_recipient' and type = 'U') " + &
"CREATE TABLE email_recipient " + &
"	(	email_id				numeric(8,0) " + &
"		, email_recipient_id	numeric(8,0) " + &
"		, send_to_type_id		numeric(8,0) " + &
"		, recipient_type		numeric(8,0) " + &
"		, recipient				varchar(150) " + &
"		, primary key (email_recipient_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'sys_wf_dash_brws_hdr' and type = 'U') " + &
"CREATE TABLE sys_wf_dash_brws_hdr " + &
"	(	wf_dash_brws_hdr		numeric(8,0) " + &
"		, email_recipient_id	numeric(8,0) " + &
"		, data_set_id			numeric(8,0) " + &
"		, data_set_name			varchar(150) " + &
"		, primary key (wf_dash_brws_hdr) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'Sys_wf_dash_brws_flds' and type = 'U') " + &
"CREATE TABLE Sys_wf_dash_brws_flds " + &
"	(	data_set_id				numeric(8,0) " + &
"		, data_set_fld_id		numeric(8,0) " + &
"		, fld_name_label		varchar(150) " + &
"		, fld_fld_width			numeric(8,0) " + &
"		, fld_order				integer " + &
"		, wf_step_id			integer " + &
"		, read_write			numeric(8,0) " + &
"		, sql_table_name		varchar(150) " + &
"		, sql_field_name		varchar(150) " + &
"		, primary key (data_set_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_dash_brws_hdr' and type = 'U') " + &
"CREATE TABLE wf_dash_brws_hdr " + &
"	(	data_set_id				numeric(8,0) " + &
"		, data_set_name			varchar(150) " + &
"		, primary key (data_set_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_dash_brws_flds' and type = 'U') " + &
"CREATE TABLE wf_dash_brws_flds " + &
"	(	data_set_id				numeric(8,0) " + &
"		, data_set_fld_id		numeric(8,0) " + &
"		, fld_name_label		varchar(150) " + &
"		, fld_fld_width			integer " + &
"		, fld_order				integer " + &
"		, read_write			integer " + &
"		, sql_table_name		varchar(150) " + &
"		, sql_field_name		varchar(150) " + &
"		, wf_step_action_id		integer " + &
"		, primary key (data_set_fld_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_dash_brws_flds_step_access' and type = 'U') " + &
"CREATE TABLE wf_dash_brws_flds_step_access " + &
"	(	rec_id					numeric(8,0) " + &
"		, data_set_fld_id		numeric(8,0) " + &
"		, wf_step_id			numeric(8,0) " + &
"		, read_write			integer " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_action_items' and type = 'U') " + &
"CREATE TABLE wf_action_items " + &
"	(	rec_id					numeric(10,0) " + &
"		, prac_id				numeric(8,0) " + &
"		, facility_id			integer " + &
"		, wf_id					integer " + &
"		, wf_step_id			integer " + &
"		, wf_step_action_id		integer " + &
"		, seq					integer " + &
"		, active_status			numeric(8,0) " + &
"		, action_type			numeric(8,0) " + &
"		, action_dept			numeric(8,0) " + &
"		, action_division		numeric(8,0) " + &
"		, esignature_id			numeric(8,0) " + &
"		, action_user			integer " + &
"		, action_status			integer " + &
"		, contact_attempts		integer " + &
"		, current_record		integer " + &
"		, contact_first_attempt	datetime " + &
"		, contact_last_attempt	datetime " + &
"		, action_notes			text " + &
"		, action_due_date		datetime " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_clin_area_dept_link' and type = 'U') " + &
"CREATE TABLE wf_clin_area_dept_link " + &
"	(	rec_id					numeric(8,0) " + &
"		, clinical_area_id		numeric(8,0) " + &
"		, dept_id				numeric(8,0) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_priv_request' and type = 'U') " + &
"CREATE TABLE wf_priv_request " + &
"	(	rec_id						numeric(8,0) " + &
"		, prac_id					numeric(8,0) " + &
"		, procd_id					numeric(8,0) " + &
"		, prev_granted				integer " + &
"		, requested					integer " + &
"		, recommended				integer " + &
"		, recommended_w_conditions	integer " + &
"		, not_recommended			integer " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_priv_request' and type = 'U') " + &
"CREATE TABLE wf_priv_request " + &
"	(	rec_id						numeric(8,0) " + &
"		, doc_disp_name				varchar(250) " + &
"		, doc_file_name				varchar(250) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'wf_priv_request' and type = 'U') " + &
"CREATE TABLE wf_priv_request " + &
"	(	rec_id						numeric(8,0) " + &
"		, agreement_id				numeric(8,0) " + &
"		, prac_id					numeric(8,0) " + &
"		, esignature_id				numeric(8,0) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'esign' and type = 'U') " + &
"CREATE TABLE esign " + &
"	(	rec_id					numeric(8,0) " + &
"		, user_id				varchar(150) " + &
"		, prac_id				numeric(8,0) " + &
"		, sign_date				datetime " + &
"		, ip					varchar(150) " + &
"		, user_agent			varchar(150) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'esign_text' and type = 'U') " + &	
"CREATE TABLE esign_text " + &
"	(	rec_id					numeric(8,0) " + &
"		, descr					varchar(150) " + &
"		, agreement_text		text " + &
"		, primary key (rec_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'affil_question' and type = 'U') " + &	
"CREATE TABLE affil_question " + &
"	(	rec_id					numeric(8,0) " + &
"		, ques_id				numeric(8,0) " + &
"		, question				varchar(150) " + &
"		, primary key (rec_id) " + &
"	) "

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'affil_question_option' and type = 'U') " + &
"CREATE TABLE affil_question_option " + &
"	(	rec_id					numeric(8,0) " + &
"		, ques_id				numeric(8,0) " + &
"		, option_text			varchar(150) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists (select 1 from sysobjects where name = 'pd_affil_answer' and type = 'U') " + &
"CREATE TABLE pd_affil_answer " + &
"	(	rec_id					numeric(8,0) " + &
"		, prac_id				numeric(8,0) " + &
"		, ques_id				numeric(8,0) " + &
"		, answer_id				numeric(8,0) " + &
"		, primary key (rec_id) " + &
"	) "	

is_sql_statements[UpperBound(is_sql_statements) + 1] = &
"if not exists( select TOP 1 1 from sysobjects where name='FK_wf_step' and type = 'F') " + &
"BEGIN  " + &
"	ALTER " + &
"	TABLE	wf_step " + &
"		ADD CONSTRAINT FK_wf_step FOREIGN KEY (wf_id) " + &
"	      REFERENCES wf_hdr " + &
" " + &
"	ALTER " + &
"	TABLE	wf_step_action " + &
"		ADD CONSTRAINT FK_wf_step_action FOREIGN KEY (wf_step_id) " + &
"	      REFERENCES wf_step " + &
" " + &
"	ALTER " + &
"	TABLE	wf_trigger " + &
"		ADD CONSTRAINT FK_wf_trigger FOREIGN KEY (wf_id) " + &
"	      REFERENCES wf_hdr " + &
" " + &
"	ALTER " + &
"	TABLE	wf_step_action_role " + &
"		ADD CONSTRAINT FK_wf_step_action_role FOREIGN KEY (wf_step_action_id) " + &
"	      REFERENCES wf_step_action " + &
" " + &
"	ALTER " + &
"	TABLE	wf_step_action_email " + &
"		ADD CONSTRAINT FK_wf_step_action_email FOREIGN KEY (wf_step_action_id) " + &
"	      REFERENCES wf_step_action " + &
" " + &
"	ALTER " + &
"	TABLE	email_recipient " + &
"		ADD CONSTRAINT FK_email_recipient FOREIGN KEY (email_id) " + &
"	      REFERENCES wf_step_action_email " + &
"END "

// Execute sqls
of_execute_sqls("of_startup_verify_workflow_schema")	

RETURN 1				
end function

public function integer of_startup_process ();//Update history tables and data from WebView - Added for Pracview Mobile by alfee 12.16.2015

of_startup_esign ()
of_startup_verify_db_setup ()	
of_startup_verify_workflow_schema ()
of_startup_verify_painters ()
of_startup_verify_security_modules ()
of_startup_verify_security_role ()
of_startup_verify_security_role_rights ()
of_startup_dynamicgen_privviewopts_set ()
of_startup_upload_letter_into_db ()


RETURN 1
end function

public function integer of_startup_dynamicgen_privviewopts_set ();is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"if not exists (select 1 from sysobjects where name = 'wv_priv_view_settings' and type = 'U') " + &
"CREATE TABLE wv_priv_view_settings " + &
"	(	 field_name varchar (100) null, " + &
"		 field_label varchar (100) null , " + &
"		 field_visible varchar (100) null , " + &
"		 field_special varchar (100) null , " + &
"		 field_order varchar (100) null ) " 

// Execute sqls
of_execute_sqls("of_startup_dynamicgen_privviewopts_set")

RETURN 1
end function

on n_cst_update_wv_hist_sql.create
call super::create
end on

on n_cst_update_wv_hist_sql.destroy
call super::destroy
end on

