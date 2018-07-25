$PBExportHeader$n_cst_update_wv_hist_data.sru
forward
global type n_cst_update_wv_hist_data from n_cst_update_wv_hist
end type
end forward

global type n_cst_update_wv_hist_data from n_cst_update_wv_hist
end type

type variables
//Data for both SQL & ASA - Alfee 12.10.2015
end variables

forward prototypes
public function integer of_startup_verify_db_setup ()
public function integer of_startup_verify_painters ()
public function integer of_startup_verify_security_modules ()
public function integer of_startup_verify_security_role ()
public function integer of_startup_verify_security_role_rights ()
public function integer of_startup_dynamicgen_privviewopts_set ()
public function integer of_startup_upload_letter_into_db ()
public function integer of_startup_process ()
end prototypes

public function integer of_startup_verify_db_setup ();is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting where wv_setting_id =1) " + &
"INSERT INTO wv_setting (wv_setting_id, module_id, setting_value, label, detail) VALUES (1, 0, 1, 'Require Affiliation Letter Logon', 'Users can be required to register to have access to printing of affiliation letters.') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting where wv_setting_id =2) " + &
"INSERT INTO wv_setting (wv_setting_id, module_id, setting_value, label, detail) VALUES (2, 1, 1, 'Require E-Signatures', 'This setting toggles E-signature requirements on and off.')  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting where wv_setting_id =5) " + &
"INSERT INTO wv_setting (wv_setting_id, module_id, setting_value, label, detail) VALUES (5, 1, 0, 'WebView Authentication Type', 'How primary authentication is done, using LDAP services, Integrated Windows Authentication or system DB.')  "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting where wv_setting_id =6) " + &
"INSERT INTO wv_setting (wv_setting_id, module_id, setting_value, label, detail) VALUES (6, 1, 0, 'Display link records', 'Users can Display records in pracview')	 "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =1) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (1, 1, 1, 'Yes', 'Yes - Require a logon account')	"

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =2) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (2, 1, 0, 'No', 'No - Do not require a logon account') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =3) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (3, 2, 1, 'Yes', 'Yes - Require e-signatures') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =4) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (4, 2, 0, 'No', 'No - Do not require e-signatures') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =5) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (5, 5, 0, 'System DB', 'Use system DB for primary authentication.')		"		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =6) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (6, 5, 1, 'Windows', 'Use Integrated Windows Authentication for primary authentication.')		"		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =7) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (7, 5, 2, 'LDAP', 'Use LDAP Service for primary authentication.')		"		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =8) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (8, 5, 3, 'Windows&System DB', 'Use Integrated Windows Authentication first. If it fails, then use system DB.')	"			 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =9) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (9, 5, 4, 'LDAP&System DB', 'Use LDAP Service first. If it fails, then use system DB.')	"			 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =10) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (10, 6, 1, 'Yes', 'Yes - display')		"		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting_option where wv_setting_option_id =11) " + &
"INSERT INTO wv_setting_option (wv_setting_option_id, wv_setting_id, option_value, option_desc_short, option_desc_long) " + &
"	VALUES (11, 6, 0, 'No', 'No - Do not display')	"	
	
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_setting where wv_setting_id =2) " + &
"INSERT INTO wv_security_user " + &
"			(	user_id " + &
"				, prac_id " + &
"				, created_date " + &
"				, ip_addr " + &
"				, hospital_name " + &
"				, department_name " + &
"				, address_line1 " + &
"				, address_line2 " + &
"				, city " + &
"				, state " + &
"				, zip " + &
"				, logon_id " + &
"				, logon_pwd " + &
"				, status " + &
"			)	 " + &			 
"			VALUES " + &
"			(	1 " + &
"				, 0 " + &
"				, getdate() " + &
"				, '' " + &
"				, 'Master Hospital'  " + &
"				, 'Master Dept'  " + &
"				, '1 Tara Blvd'  " + &
"				, 'Suite 301' " + &
"				, 'Nashau'  " + &
"				, 'NH'  " + &
"				, '03062'  " + &
"				, 'master'  " + &
"				, ''  " + &
"				, 1 " + &
"			) " 				 
			
//Replaced "if not exists (select 1 from wv_setting where wv_setting_id =2) " below for wv_letter_criterion & wv_letter - alfee 06.01.2016
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =1) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value)	 " + &			 
"	VALUES (1, 1, 'pd_affil_stat.active_status', '1') 	 "		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =2) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value)	 " + &			 
"	VALUES (2, 1, 'pd_affil_stat.in_good_standing', '1')	 "			 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =3) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value)	 " + &			 
"	VALUES (3, 2, 'pd_affil_stat.active_status', '2')		 "		 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =4) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value)	 " + &			 
"	VALUES (4, 2, 'pd_affil_stat.in_good_standing', '1')	 "			 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =5) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value)	 " + &			 
"	VALUES (5, 3, 'pd_affil_stat.active_status', '3')	 "			 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter_criterion where wv_letter_criterion_id =6) " + &
"INSERT INTO wv_letter_criterion (wv_letter_criterion_id, wv_letter_id, field_name, field_value) " + &				 
"	VALUES (6, 3, 'pd_affil_stat.in_good_standing', '1')	 "	

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter where wv_letter_id = 1) " + &
"INSERT INTO wv_letter (wv_letter_id, letter_name, document_name, letter_desc, letter_type_id) " + &
"	VALUES (1, 'Affiliation In Good Standing', 'aff_good_standing', 'Used for pracs in good standing', 1) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter where wv_letter_id = 2) " + &
"INSERT INTO wv_letter (wv_letter_id, letter_name, document_name, letter_desc, letter_type_id) " + &
"	VALUES (2, 'Affiliation Pending', 'aff_pending', 'Used for pracs not yet fully affiliated', 1) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_letter where wv_letter_id = 3) " + &
"INSERT INTO wv_letter (wv_letter_id, letter_name, document_name, letter_desc, letter_type_id) " + &
"	VALUES (3, 'Affiliation Inactive Good Standing', 'aff_inactive_good_standing', 'Used for pracs inactive but in good standing', 1) "

// Execute sqls
of_execute_sqls("of_startup_verify_db_setup")	

RETURN 1
end function

public function integer of_startup_verify_painters ();is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 1) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	1 " + &
"	, 'WebView Access Role Management' " + &
"	, 'Manage Roles that control user access within WebView' " + &
"	, 1.1 " + &
"	, 1 " + &
"	, 'roles' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 2) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	2 " + &
"	, 'WebView User Painter' " + &
"	, 'Manage All WebView Users and User Access' " + &
"	, 1.1 " + &
"	, 1 " + &
"	, 'user' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 4) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	4 " + &
"	, 'Letter Template Maintenance' " + &
"	, 'Maintain letter templates' " + &
"	, 1.1 " + &
"	, 1 " + &
"	, 'letters' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 5) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	5 " + &
"	, 'WebView Settings Maintenance' " + &
"	, 'Manage overall settings for WebView' " + &
"	, 1.1 " + &
"	, 1 " + &
"	, 'wv_settings' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 6) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	6 " + &
"	, 'Privilege View Options' " + &
"	, 'Manage view options from privilege viewing' " + &
"	, 1.1 " + &
"	, 1 " + &
"	, 'priv_view_painter' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 9) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	9 " + &
"	, 'e-Signature Agreements' " + &
"	, 'Manage agreement text for e-Signature verifications' " + &
"	, 5 " + &
"	, 1 " + &
"	, 'esign_text' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 11) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	11 " + &
"	, 'Screen Help' " + &
"	, 'Manage screen help text' " + &
"	, 5 " + &
"	, 1 " + &
"	, 'screen_help' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update sys_painter set name='WebView User Painter', description='Manage All WebView Users and User Access' where name='Practitioner Account Management' "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 12) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	12 " + &
"	, 'WebView Agreements Painter' " + &
"	, 'Manage All WebView Agreement Documents.' " + &
"	, 5 " + &
"	, 1 " + &
"	, 'agreement_painter' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 13) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	13 " + &
"	, 'Logo Image' " + &
"	, 'Manage Logo Image.' " + &
"	, 11.0 " + &
"	, 1 " + &
"	, 'logo_image' " + &
") "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from sys_painter where painter_id = 14) " + &
"INSERT INTO sys_painter (painter_id, name, description, active_as_of_version, webview, module_key) " + &
"VALUES " + &
"(	14 " + &
"	, 'Prac View Help' " + &
"	, 'Manage prac view help text.' " + &
"	, 11.0 " + &
"	, 1 " + &
"	, 'prac_view_help' " + &
") "

// Execute sqls
of_execute_sqls("of_startup_verify_painters")	

RETURN 1
end function

public function integer of_startup_verify_security_modules ();//1. wv_security_module
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 1) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(1,5,0,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 2) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(2,5,0,'Practitioner Search') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 3) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(3,5,0,'Print Letters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 4) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(4,5,NULL,'System') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 5) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(5,5,4,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 6) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(6,5,4,'Change Password') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 7) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(7,5,4,'Balloon Help') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 8) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(8,5,NULL,'Audit Trail') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 9) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(9,5,8,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 10) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(10,5,8,'Practitioner Data') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 11) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(11,5,8,'Affiliation Letter') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 12) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(12,5,8,'Lookups') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 13) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(13,5,NULL,'Output') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 14) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(14,5,13,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 15) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(15,5,13,'Correspondence Letters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 16) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(16,5,13,'IntelliReport') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 17) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(17,5,13,'Standard Reports') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 18) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(18,5,NULL,'Practitioner Folder') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 19) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(19,5,18,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 20) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(20,5,18,'Data Entry Audit') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 21) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(21,5,18,'Practitioner Dashboard') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 22) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(22,5,18,'Workflow Dashboard') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 23) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(23,5,18,'App Audit') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 24) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(24,5,18,'Meetings') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 25) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(25,5,18,'Credentialing Data') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 26) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(26,5,18,'Imaging') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 27) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(27,5,18,'Appointment Status') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 28) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(28,5,18,'Verification') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 29) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(29,5,18,'Net Dev') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 30) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(30,5,18,'Profile') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 31) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(31,5,18,'Practitioner Search') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 32) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(32,5,18,'Privileges') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 33) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(33,5,NULL,'Painters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 34) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(34,5,33,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 35) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(35,5,33,'Views') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 36) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(36,5,33,'Roles') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 37) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(37,5,33,'Screens') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 38) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(38,5,33,'Facilities') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 39) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(39,5,33,'Application Mappings') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 40) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(40,5,33,'Practitioner Accounts') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 41) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(41,5,33,'Workflow') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 42) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(42,5,33,'Affiliation Users') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 43) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(43,5,33,'Application Audit') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 44) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(44,5,33,'Letters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 45) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(45,5,33,'Profiles') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 46) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(46,5,33,'WebView Settings') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 47) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(47,5,33,'Lookups') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 48) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(48,5,33,'Image Types') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 49) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(49,5,NULL,'Administration') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 50) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(50,5,49,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 51) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(51,5,NULL,'Affiliation Letters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 52) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(52,5,51,'_root') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 53) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(53,5,51,'Practitioner Search') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 54) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(54,5,51,'Print Letters') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 55) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(55,5,18,'Agreements/Signature') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 56) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(56,5,18,'Attestation Questions') "


//2. wv_security_right_action
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 10) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (10,1,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 20) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (20,2,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 30) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (30,3,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 40) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (40,5,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 50) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (50,6,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 60) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (60,7,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 70) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (70,9,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 80) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (80,10,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 90) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (90,11,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 100) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (100,12,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 120) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (110,14,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 130) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (120,15,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 130) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (130,16,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 140) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (140,16,'Run Reports',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 150) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (150,16,'List Reports',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 160) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (160,17,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 170) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (170,19,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 180) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (180,20,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 190) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (190,21,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 200) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (200,21,'View Pri Source Verif',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 210) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (210,21,'View Req Suport Docs',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 220) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (220,21,'View Missing Credentials',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 230) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (230,22,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 240) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (240,23,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 250) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (250,24,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 260) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (260,25,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 270) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (270,26,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 280) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (280,27,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 290) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (290,28,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 300) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (300,29,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 310) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (310,30,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 320) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (320,31,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 330) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (330,31,'DOB',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 340) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (340,31,'Select Pending Practitioners',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 350) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (350,31,'SSN',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 360) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (360,31,'Select Inactive Practitioners',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 370) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (370,31,'Select Active Practitioners',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 380) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (380,31,'Status Indicators',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 390) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (390,32,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 400) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (400,34,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 410) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (410,35,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 420) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (420,36,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 430) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (430,37,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 440) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (440,38,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 450) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (450,39,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 460) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (460,40,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 470) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (470,41,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 480) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (480,42,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 490) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (490,43,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 500) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (500,44,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 510) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (510,45,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 520) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (520,46,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 530) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (530,47,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 540) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (540,48,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 550) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (550,50,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 560) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (560,52,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 570) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (570,53,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 580) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (580,54,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 590) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (590,55,'Access Rights',2) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 600) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (600,56,'Access Rights',2) "

//(Appeon)Stephen 06.26.2017 - V15.4-WebView Reporting Functionality
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_module where module_id = 60) " + &
"INSERT INTO wv_security_module (module_id, software_version, parent_module_id, module_name) VALUES(60,5,33,'Reports') "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from wv_security_right_action where action_id = 610) " + &
"INSERT INTO wv_security_right_action (action_id, module_id, action_name, dddw_type) VALUES (610,60,'Access Rights',2) "

// Execute sqls
of_execute_sqls("of_startup_verify_security_modules")	

RETURN 1
end function

public function integer of_startup_verify_security_role ();is_sql_statements[upperbound(is_sql_statements) + 1] = &
"If not exists (select TOP 1 1 from wv_security_role) " + &
"Begin " + &
"	INSERT INTO	wv_security_role (role_id, role_name) VALUES (1, 'Administrator') " + &
"	INSERT INTO	wv_security_role (role_id, role_name) VALUES (2, 'Nurse') " + &
"	INSERT INTO	wv_security_role (role_id, role_name) VALUES (3, 'Credentialing Specialist') " + &
"	INSERT INTO	wv_security_role (role_id, role_name) VALUES (4, 'Practitioner') " + &
"End "

// Execute sqls
of_execute_sqls("of_startup_verify_security_role")	

RETURN 1
end function

public function integer of_startup_verify_security_role_rights ();//Intialize data in wv_security_role_right on the basis of wv_security_right_action and wv_security_role
Long ll_cnt, ll_row, ll_rtn
Long ll_action_id, ll_role_id, ll_role_right_id, ll_value_id

DataStore lds_action_role, lds_role_right

Delete from wv_security_role_right where role_id = 0 and action_id = 0; //Work around the Case #00065079 - alfee 07.04.2016

lds_action_role = Create DataStore
lds_role_right = Create DataStore
lds_action_role.DataObject = 'd_wv_security_action_role'
lds_role_right.DataObject = 'd_wv_security_role_right'
lds_action_role.SetTransObject(SQLCA)
lds_role_right.SetTransObject(SQLCA)

ll_cnt = lds_action_role.Retrieve ()
IF ll_cnt > 0 THEN
	ll_value_id = 2
	SELECT IsNull(MAX(role_right_id),0) INTO :ll_role_right_id  FROM wv_security_role_right;
	
	FOR ll_row = 1 TO ll_cnt
		ll_role_right_id = ll_role_right_id + 1	
		ll_role_id = lds_action_role.GetItemNumber(ll_row, "role_id") //Case #00065079 - alfee 07.04.2016
		ll_action_id = lds_action_role.GetItemNumber(ll_row, "action_id")	//Case #00065079 - alfee 07.04.2016
		lds_role_right.InsertRow(0)
		lds_role_right.SetItem(ll_row, "role_right_id", ll_role_right_id)
		lds_role_right.SetItem(ll_row, "role_id", ll_role_id)
		lds_role_right.SetItem(ll_row, "action_id", ll_action_id)	
		lds_role_right.SetItem(ll_row, "value_id", ll_value_id)		
	NEXT
	
	lds_role_right.AcceptText()
	ll_rtn = lds_role_right.Update ()	
END IF	

Destroy lds_action_role
Destroy lds_role_right

//
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update SECURITY_MODULES	Set module_name='WebView' Where module_name='IntelliCred Web' "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"Update SECURITY_SUB_MODULE Set sub_module_name='Web Access'	Where sub_module_name='Web Administration' "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"delete SECURITY_ROLES_RIGHTS " +  &
"	from SECURITY_ROLES_RIGHTS,SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION " +  &
"	where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id " +  &
"	and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id " +  &
"	and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id " +  &
"	and SECURITY_RIGHTS_ACTION.Action_name<>'View Rights' " +  &
"	and SECURITY_MODULES.module_name ='WebView' " +  &
"	and SECURITY_SUB_MODULE.sub_module_name ='Web Access' " +  &
"	and SECURITY_ROLES_RIGHTS.action_id=SECURITY_RIGHTS_ACTION.action_id " +  &
"	and (SECURITY_SUB_MODULE.sub_module_id < 950 or SECURITY_SUB_MODULE.sub_module_id>1030) " 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"delete SECURITY_ROLES_RIGHTS " +  &
"	from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION " +  &
"	where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id " +  &
"	and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id " +  &
"	and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id " +  &
"	and SECURITY_MODULES.module_name ='WebView' " +  &
"	and SECURITY_SUB_MODULE.sub_module_name <>'Web Access' " +  &
"	and SECURITY_ROLES_RIGHTS.action_id=SECURITY_RIGHTS_ACTION.action_id " +  &	
"	and (SECURITY_SUB_MODULE.sub_module_id < 950 or SECURITY_SUB_MODULE.sub_module_id>1030) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"delete SECURITY_RIGHTS_ACTION " +  &
"	from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION " +  &
"	where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id " +  &
"	and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id " +  &
"	and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id " +  &
"	and SECURITY_RIGHTS_ACTION.Action_name<>'View Rights' " +  &
"	and SECURITY_MODULES.module_name ='WebView' " +  &
"	and SECURITY_SUB_MODULE.sub_module_name ='Web Access' " +  &
"	and (SECURITY_SUB_MODULE.sub_module_id < 950 or SECURITY_SUB_MODULE.sub_module_id>1030) " 

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"delete SECURITY_RIGHTS_ACTION " +  &
"	from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION " +  &
"	where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id " +  &
"	and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id " +  &
"	and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id " +  &
"	and SECURITY_MODULES.module_name ='WebView' " +  &
"	and SECURITY_SUB_MODULE.sub_module_name <>'Web Access' " +  &
"	and (SECURITY_SUB_MODULE.sub_module_id < 950 or SECURITY_SUB_MODULE.sub_module_id>1030) "

is_sql_statements[upperbound(is_sql_statements) + 1] = &
"delete from SECURITY_SUB_MODULE " +  &
"	where module_id=(select module_id from security_modules  " +  &
"						where module_name='WebView' " +  &
"					     and (SECURITY_SUB_MODULE.sub_module_id < 950 or SECURITY_SUB_MODULE.sub_module_id>1030) " +  &
"	) " + &
"	and sub_module_name <>'Web Access' " 

// Execute sqls
of_execute_sqls("of_startup_verify_security_role_rights")	

RETURN 1
end function

public function integer of_startup_dynamicgen_privviewopts_set ();is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select top 1 1 from wv_priv_view_settings) " + &
"Begin " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('clinical_area_description','Clinical Area','Yes','','1') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('priv_core_description','Privilege Description','Yes','','2') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('procd_name','Procedure Name','Yes','','3') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('core_procd_description','Procedure Description','Yes','','4') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('start_date','Start Date','Yes','','5') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('end_date','End Date','Yes','','6') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('status_code','Status Code','Yes','','7') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('ir_code','Initial/Reapply','Yes','','8') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('active_status','Status','Yes','','9') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('notes','Notes','Yes','','10') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('photo','Show Physician Photo','Yes','Yes','11') " + &
"insert into wv_priv_view_settings (field_name,field_label,field_visible,field_special,field_order) values ('printable','Allow Printing of Privileges','No','Yes','12') " + &
"End "

// Execute sqls
of_execute_sqls("of_startup_dynamicgen_privviewopts_set")	

RETURN 1
end function

public function integer of_startup_upload_letter_into_db ();//Upload 3 letter documents (in WebView folder) into wv_letter

//For WV Affletter functionality only and can be uploaded manually in WV Letter Template currently


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

on n_cst_update_wv_hist_data.create
call super::create
end on

on n_cst_update_wv_hist_data.destroy
call super::destroy
end on

