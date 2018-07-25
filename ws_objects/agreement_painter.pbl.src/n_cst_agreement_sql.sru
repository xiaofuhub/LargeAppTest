$PBExportHeader$n_cst_agreement_sql.sru
$PBExportComments$Create by Jack 11/30/2006
forward
global type n_cst_agreement_sql from nonvisualobject
end type
end forward

global type n_cst_agreement_sql from nonvisualobject autoinstantiate
end type

type variables
string is_sql_statments[]
end variables

forward prototypes
public subroutine of_update_version_7 ()
public subroutine of_execute ()
end prototypes

public subroutine of_update_version_7 ();//This function contained all db updates for IntelliContract Agreement Creation Module
long ll_num
string ls_key_name

is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table icred_settings add set_51 int null; "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update icred_settings set set_51 = 0 WHERE set_51 is null; "
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2007.09.21 By: Jack
//$<reason>Fix a defect.
/*
is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table code_lookup modify code varchar(30) not null; "
*/
IF gs_dbtype = "SQL" THEN
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table code_lookup alter column code varchar(30) not null; "
Else
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table code_lookup modify code varchar(30) not null; "
End If
//---------------------------- APPEON END ----------------------------

is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_scrn_id int null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_scrn_dataobject varchar(50) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_column_name varchar(50) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_lookup_type varchar(1) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD module_type int null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_uselink int null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_linkfromcolumn varchar(50) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_linktoscrnid int null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_linktocolumn varchar(50) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "ALTER TABLE export_fields ADD ctx_linktoscrndw varchar(50) null;"

//<add> andy 2007.05.29
is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table export_fields add ctx_column_datatype CHAR(1) null;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table export_fields add export_fields_expression VARCHAR(2000) null;"
//end of add

is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6800,6801,6802,6803);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 58, 4, 'Clause Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values ( 58, 580, 'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6800, 58, 580, 'View Rights', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values( 7300, 1, 6800, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 59, 4, 'Template Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 59,581,  'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6801, 59, 581, 'View Rights', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7301, 1, 6801, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version,module_name ,prod_id) values ( 60, 4, 'Document Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values (  60, 582,'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6802, 60, 582, 'View Rights', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7302, 1, 6802, 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 9,583, 'Contract Management Rights' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6803, 9, 583, 'View Rights', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) values ( 7303, 1, 6803, 2);"


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-19 By: Rodger Wu
//$<reason> 'Contract Category' will be the only category for all.
//is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from ctx_acp_contract_management_right where types in (2,3,4) and category not in ( select lookup_code from code_lookup where lookup_name = 'Contract Category'); "  //Comment by Jack 03/21/2007
is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from ctx_acp_contract_management_right where types in (3,4) and category not in ( select lookup_code from code_lookup where lookup_name = 'Contract Category'); "      //add by Jack 03/21/2007
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.12.2007 By: Jack
//$<reason> Fix a defect.
/*
DELETE FROM code_lookup WHERE lookup_name in ('Contract Clause Category','Contract Template Category', 'Contract Document Category' );
UPDATE code_lookup SET lookup_name = 'Z - Recycle Bin' WHERE lookup_name in ('Contract Clause Category','Contract Template Category', 'Contract Document Category' );
*/
DELETE FROM code_lookup WHERE lookup_name in ('Contract Template Category', 'Contract Document Category' );
UPDATE code_lookup SET lookup_name = 'Z - Recycle Bin' WHERE lookup_name in ('Contract Template Category', 'Contract Document Category' );

//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

ll_num = 0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.12.2007 By: Jack
//$<reason> Fix a defect.

SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Clause Category';
is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_contract_management_right where types = 2 and category not in (Select lookup_code from code_lookup where lookup_name = 'Contract Clause Category'); "
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_contract_management_right where types = 2;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Software', 'Software', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Maintenance', 'Maintenance', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Payor', 'Payor', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'IT Services', 'IT Services', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Marketing', 'Marketing', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Office Lease', 'Office Lease', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Clause Category', 'Equipment Lease', 'Equipment Lease', 'C')"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE ctx_acp_folder SET category = (SELECT a.lookup_code FROM code_lookup a,code_lookup b WHERE a.code = b.code AND a.lookup_name ='Contract Clause Category' and b.lookup_name = 'Contract Category' and ctx_acp_folder.category = b.lookup_code);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE ctx_acp_clause SET category = (SELECT a.lookup_code FROM code_lookup a,code_lookup b WHERE a.code = b.code AND a.lookup_name ='Contract Clause Category' and b.lookup_name = 'Contract Category' and ctx_acp_clause.category = b.lookup_code);"
End If
//---------------------------- APPEON END ----------------------------


SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Approval Status';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Approval Status', 'Pending', 'Pending', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Approval Status', 'Denied', 'Denied', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Approval Status', 'Approved', 'Approved', 'C');"
End If

SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Template Review Status';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Template Review Status', 'Pending', 'Pending', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Template Review Status', 'Declined', 'Declined', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Template Review Status', 'Approved', 'Approved', 'C');"
End If

SELECT count(lookup_code) INTO :ll_num FROM code_lookup WHERE lookup_name = 'Contract Document Review Status';
If ll_num = 0 Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Review Status', 'Pending', 'Pending', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Review Status', 'Declined', 'Declined', 'C');"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO  code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Document Review Status', 'Approved', 'Approved', 'C');"
End If

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1060,	'd_ctx_products',	'IntelliContract/Detail/Products',	NULL,	0,	NULL,	NULL,	NULL,'C');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1060,200700,10,'','product_type', 'Product Type',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1060,200701,20,'','product_id', 'Product Name',6, 'N' ,6,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1061,	'd_view_audit2_ctx',	'IntelliContract/Detail/Audit',	NULL,	0,	NULL,	NULL,	NULL,'C');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200702,0,'','prac_id', 'Contract Id',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200703,0,'','audit_type', 'Type',3, 'C' ,3,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200704,0,'','table_name_allias', 'Table Name',100, 'C' ,100,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200705,0,'','field_name_allias', 'Field Name',100, 'C' ,100,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200706,0,'','old_value', 'Old Value',100, 'C' ,100,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200707,0,'','new_value', 'New Value',100, 'C' ,100,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200708,0,'','user_id', 'User',20, 'C' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1061,200709,0,'','date_time_modified', 'Date',20, 'D' ,20,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "update sys_tables set table_name = 'd_sp_contract_search' where table_id = 1032"
is_sql_statments[upperbound(is_sql_statments) + 1] = "update sys_tables set table_name_allias = 'IntelliContract/Search/Contract Browse' where table_id = 1032"
is_sql_statments[upperbound(is_sql_statments) + 1] = "update sys_tables set screen_type = 'C' where table_id = 1032"

is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from sys_fields where table_id = 1032"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200710,0,'','owner', 'Owner',20, 'C' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200711,0,'','ctx_id', 'Contract ID',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200712,0,'','status', 'Status',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200713,0,'','app_facility', 'Company',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200714,0,'','product_name', 'Product Name',15, 'C' ,15,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200715,0,'','contracted_entity', 'Parent Organization',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200716,0,'','product_type', 'Product Type',15, 'C' ,15,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200717,0,'','category', 'Category',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200718,0,'','effective_date', 'Effective Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1032,200719,0,'','expriation_date', 'Expiration Date',20, 'D' ,20,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "update sys_tables set table_name = 'd_contract_group_practitioners_existing' where table_id = 1011"
is_sql_statments[upperbound(is_sql_statments) + 1] = "update sys_tables set screen_type = 'C' where table_id = 1011"
is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from sys_fields where table_id = 1011"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1011,200720,0,'','v_full_name_full_name', 'Practitioner',153, 'C' ,153,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1011,200721,0,'','ctx_location_pracs_status', 'Status',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1011,200722,0,'','start_date', 'Start Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1011,200723,0,'','end_date', 'End Date',20, 'D' ,20,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from sys_tables where table_id = 1016"
is_sql_statments[upperbound(is_sql_statments) + 1] = "delete from sys_fields where table_id = 1016"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1041,200724,0,'','full_name', 'Full Name',153, 'C' ,153,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1062,	'd_contract_fee_sched_nm',	'IntelliContract/Fee Schedule (NM)/Fee Schedule (Non Healthcare)',	NULL,	0,	NULL,	NULL,	NULL,'C');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200725,0,'','billing_cycle', 'Billing Cycle',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200726,0,'','category', 'Category',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200727,0,'','service_item', 'Service Item',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200728,0,'','description', 'Description',255, 'C' ,255,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200729,0,'','fee', 'Fee',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200730,0,'','item_status', 'Item Status',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200731,0,'','start_date', 'Start Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200732,0,'','end_date', 'End Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200733,0,'','custom_fee1', 'Custom Fee',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200734,0,'','custom_text1', 'Custom Int',153, 'C' ,153,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1062,200735,0,'','notes', 'Notes',153, 'C' ,153,'','','','');"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required,screen_type) VALUES (1063,	'd_cntx_action_items_browse',	'IntelliContract/Action Items/Action Item Browse',	NULL,	0,	NULL,	NULL,	NULL,'C');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200736,0,'','action_type', 'Action Type',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200737,0,'','action_date', 'Action Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200738,0,'','due_date', 'Due Date',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200739,0,'','action_user', 'User',153, 'C' ,153,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200740,0,'','action_status', 'Status',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200741,0,'','first_attempt', 'First Attempt',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200742,0,'','last_attempt', 'Last Attempt',20, 'D' ,20,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200743,0,'','no_attempts', '# Attempts',6, 'N' ,6,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200744,0,'','letter_from_name', 'Letter From',153, 'C' ,153,'','','','');"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1063,200745,0,'','letter_to_name', 'Letter To',153, 'C' ,153,'','','','');"

If gs_dbtype = "ASA" Then
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_contract_management_right (role_id integer not null,category numeric(6,0) not null,types  int not null,rights varchar(2) not null,primary key (role_id, category, types));"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_contract_management_right  add foreign key FK_CTX_ACP_REFERENCE_SECURITY (role_id) references security_roles (role_id)  on update restrict on delete cascade;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_contract_management_right  add foreign key FK_CTX_ACP_REFERENCE_CODE_LOOUP (category) references code_lookup (lookup_code) on update restrict   on delete cascade;"
  
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_folder (ctx_acp_folder_id  integer not null,folder_name varchar(50) not null,parent_folder_id integer null,grade integer null,category numeric(6,0) not null,primary key  (ctx_acp_folder_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_folder add foreign key FK_CTX_ACP_Folder_CODE_LOOKUP (category) references code_lookup (lookup_code) on update restrict   on delete cascade;"
		
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_clause (ctx_acp_clause_id numeric(6,0) not null,ctx_acp_folder_id integer not null,category numeric(6,0) not null,clause_name varchar(255) null,description varchar(255) null,information_message  varchar(255) null,approved_by varchar(20) null,date_approved datetime null,approval_status numeric(6,0) not null,image_file long binary null,create_date datetime null,modify_date datetime null,primary key  (ctx_acp_clause_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause  add foreign key FK_CTX_ACP__REFERENCE_CTX_ACP_  (ctx_acp_folder_id) references ctx_acp_folder (ctx_acp_folder_id) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause  add foreign key FK_CTX_ACP__REFERENCE_CODE_LO1  (category) references code_lookup (lookup_code) on update restrict  on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause  add foreign key FK_CTX_ACP__REFERENCE_CODE_LO2  (approval_status) references code_lookup (lookup_code) on update restrict   on delete cascade;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause modify information_message varchar(2000) null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add information_disp bit null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "update ctx_acp_clause set information_disp = 0 where information_disp is null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add export_id int Null;" //alfee 04.18.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add constraint FK_CTX_ACP_CLAUSE_REFERENCE_EXPORT_H foreign key (export_id) references export_header (export_id) on update restrict on delete cascade;" //alfee 04.18.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add page_break bit null;" //05.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "update ctx_acp_clause set page_break = 0 where page_break is null;" //05.28.2007
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_clause_rely (ctx_acp_clause_id numeric(6,0) not null,ctx_acp_clause_rely_id numeric(6,0) not null,primary key  (ctx_acp_clause_id, ctx_acp_clause_rely_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause_rely add foreign key FK_CTX_ACP__REFERENCE_CTX_ACP1 (ctx_acp_clause_id)	references ctx_acp_clause (ctx_acp_clause_id) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause_rely add foreign key FK_CTX_ACP__REFERENCE_CTX_ACP2 (ctx_acp_clause_rely_id) references ctx_acp_clause (ctx_acp_clause_id) on update restrict   on delete cascade;"
		
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_template (ctx_acp_template_id  numeric(6,0) not null,Category numeric(6,0) not null,Template_Name varchar(255) not null,export_id integer not null,wf_id integer null,Description varchar(255) null,Reviewed_By varchar(20) null,Date_Reviewed datetime null,Reviewed_Status numeric(6,0) not null,image_file long binary null,create_date datetime null,modify_date datetime null,primary key (ctx_acp_template_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add foreign key FK_CTX_ACP_TEMPLATE_CODE_LO1 (Category) references code_lookup (lookup_code) on update restrict  on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add foreign key FK_CTX_ACP__REFERENCE_EXPORT_H (export_id) references export_header (export_id) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add foreign key FK_CTX_ACP_TEMPLATE_CODE_LO2 (Reviewed_Status) references code_lookup (lookup_code) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add foreign key FK_CTX_ACP_TEMPLATE_WF_WORKFLOW(wf_id) references wf_workflow (wf_id) on update restrict on delete cascade;"
			
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_template_clause (ctx_acp_template_id  numeric(6,0) not null,ctx_acp_clause_id  numeric(6,0) not null,orders integer not null,primary key (ctx_acp_template_id, ctx_acp_clause_id));"	 
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template_clause add foreign key FK_CTX_ACP_TEMPLATE_CLASUE_1 (ctx_acp_template_id) references ctx_acp_template (ctx_acp_template_id) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template_clause add foreign key FK_CTX_ACP_TEMPLATE_CLASUE_2 (ctx_acp_clause_id) references ctx_acp_clause (ctx_acp_clause_id) on update restrict on delete cascade;"
		
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_document (ctx_acp_document_id  numeric(6,0) not null,Category numeric(6,0) not null,Document_Name varchar(255) not null,Document_Type varchar(5) null,wf_id integer null,Files varchar(255) null,Description varchar(255) null,Reviewed_By varchar(20) null,Date_Reviewed datetime null,Reviewed_Status numeric(6,0) not null,image_file long binary null,create_date datetime null,modify_date datetime null,primary key (ctx_acp_document_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add foreign key FK_CTX_ACP_DOCUMENT_CODE_LOO1 (Category) references code_lookup (lookup_code) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add foreign key FK_CTX_ACP_DOCUMENT_CODE_LOO2 (Reviewed_Status) references code_lookup (lookup_code) on update restrict on delete cascade;"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add foreign key FK_CTX_ACP_document_WF_WORKFLOW (wf_id) references wf_workflow (wf_id) on update restrict on delete cascade;"
Else
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_contract_management_right (role_id integer not null,category numeric(6,0) not null,types  int not null,rights varchar(2) not null,primary key (role_id, category, types));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_contract_management_right add constraint FK_CTX_ACP__REFERENCE_SECURITY foreign key (role_id)	references security_roles (role_id);"	
	//02.25.2007 By Jervis
	//is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_contract_management_right add constraint FK_CTX_ACP__REFERENCE_CODE_LOO foreign key (category) references code_lookup (lookup_code);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_contract_management_right add constraint FK_CTX_ACP__REFERENCE_CODE_LOO foreign key (category) references code_lookup (lookup_code) on update restrict on delete cascade;"

	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_folder (ctx_acp_folder_id  integer not null,folder_name varchar(50) not null,parent_folder_id integer null,grade integer null,category numeric(6,0) not null,primary key  (ctx_acp_folder_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add constraint FK_CTX_ACP_FOLDER_CODE_LOOKUP foreign key (category) references code_lookup (lookup_code);"

	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_clause (ctx_acp_clause_id numeric(6,0) not null,ctx_acp_folder_id integer not null,category numeric(6,0) not null,clause_name varchar(255) null,description varchar(255) null,information_message  varchar(255) null,approved_by varchar(20) null,date_approved datetime null,approval_status numeric(6,0) not null,image_file image null,create_date datetime null,modify_date datetime null,primary key  (ctx_acp_clause_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause	add constraint FK_CTX_ACP__REFERENCE_CTX_ACP_ foreign key (ctx_acp_folder_id)	references ctx_acp_folder (ctx_acp_folder_id);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause	add constraint FK_CTX_ACP__REFERENCE_CODE_LO1 foreign key (category)	references code_lookup (lookup_code);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause	add constraint FK_CTX_ACP__REFERENCE_CODE_LO2 foreign key (approval_status) references code_lookup (lookup_code);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add information_disp bit null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "update ctx_acp_clause set information_disp = 0 where information_disp is null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add export_id int NULL CONSTRAINT FK_CTX_ACP_CLAUSE_REFERENCE_EXPORT_H FOREIGN KEY (export_id) REFERENCES export_header (export_id);" //Alfee 04.18.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause add page_break bit null;" //05.28.2007
	is_sql_statments[upperbound(is_sql_statments) + 1] = "update ctx_acp_clause set page_break = 0 where page_break is null;" //05.28.2007
		
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_clause_rely (ctx_acp_clause_id numeric(6,0) not null,ctx_acp_clause_rely_id numeric(6,0) not null,primary key  (ctx_acp_clause_id, ctx_acp_clause_rely_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause_rely add constraint FK_CTX_ACP__REFERENCE_CTX_ACP1 foreign key (ctx_acp_clause_id) references ctx_acp_clause (ctx_acp_clause_id);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_clause_rely add constraint FK_CTX_ACP__REFERENCE_CTX_ACP2 foreign key (ctx_acp_clause_rely_id) references ctx_acp_clause (ctx_acp_clause_id);"

	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_template (ctx_acp_template_id  numeric(6,0) not null,Category numeric(6,0) not null,Template_Name varchar(255) not null,export_id integer not null,wf_id integer null,Description varchar(255) null,Reviewed_By varchar(20) null,Date_Reviewed datetime null,Reviewed_Status numeric(6,0) not null,image_file image null,create_date datetime null,modify_date datetime null,primary key (ctx_acp_template_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add constraint FK_CTX_ACP_TEMPLATE_CODE_LO1 foreign key (Category)	references code_lookup (lookup_code);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add constraint FK_CTX_ACP__REFERENCE_EXPORT_H foreign key (export_id)	references export_header (export_id);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add constraint FK_CTX_ACP_TEMPLATE_CODE_LO2 foreign key (Reviewed_Status) references code_lookup (lookup_code);"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template add constraint FK_CTX_ACP_TEMPLATE_WF_WORKFLOW foreign key (wf_id)	references wf_workflow (wf_id);"
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_template_clause (ctx_acp_template_id  numeric(6,0) not null,ctx_acp_clause_id  numeric(6,0) not null,orders integer not null,primary key (ctx_acp_template_id, ctx_acp_clause_id));"	 
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template_clause add constraint FK_CTX_ACP_TEMPLATE_CLASUE_1 foreign key (ctx_acp_template_id) references ctx_acp_template (ctx_acp_template_id);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_template_clause add constraint FK_CTX_ACP_TEMPLATE_CLASUE_2 foreign key (ctx_acp_clause_id) references ctx_acp_clause (ctx_acp_clause_id);"

	is_sql_statments[upperbound(is_sql_statments) + 1] = "create table ctx_acp_document (ctx_acp_document_id  numeric(6,0) not null,Category numeric(6,0) not null,Document_Name varchar(255) not null,Document_Type varchar(5) null,wf_id integer null,Files varchar(255) null,Description varchar(255) null,Reviewed_By varchar(20) null,Date_Reviewed datetime null,Reviewed_Status numeric(6,0) not null,image_file image null,create_date datetime null,modify_date datetime null,primary key (ctx_acp_document_id));"	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add constraint FK_CTX_ACP_DOCUMENT_CODE_LOO1 foreign key (Category) references code_lookup (lookup_code);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add constraint FK_CTX_ACP_DOCUMENT_CODE_LOO2 foreign key (Reviewed_Status) references code_lookup (lookup_code);"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "alter table ctx_acp_document add constraint FK_CTX_ACP_document_WF_WORKFLOW foreign key (wf_id) references wf_workflow (wf_id);"	

	/*******************************08.29.2007 By Jervis *********************************/
	//Use By Full Text Search
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table ctx_acp_clause add doctype varchar(10) null default 'doc';"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table ctx_acp_clause alter column doctype varchar(10) null default 'doc';"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Update ctx_acp_clause set doctype = 'doc' where doctype is null;"
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table ctx_acp_template add doctype varchar(10) null default 'doc';"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table ctx_acp_template alter column doctype varchar(10) null default 'doc';"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Update ctx_acp_template set doctype = 'doc' where doctype is null;"	

	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','information_message','drop'" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments)+1] = "Alter table ctx_acp_clause alter column information_message varchar(2000) null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','information_message','add'"
	
	/*
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_catalog 'ctx_acp_clause_catalog','create'"
	select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_clause');	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_clause','create','ctx_acp_clause_catalog','" + ls_key_name + "'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','clause_name','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','description','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','information_message','drop'" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments)+1] = "Alter table ctx_acp_clause alter column information_message varchar(2000) null;" //03.28.2007
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','information_message','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','approved_by','add'"
	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_clause','image_file','add',0,'doctype'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_full'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_change_tracking'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_background_updateindex'"


	is_sql_statments[upperbound(is_sql_statments) + 1] = "Alter table ctx_acp_template add doctype varchar(10) null;"
	is_sql_statments[upperbound(is_sql_statments) + 1] = "Update ctx_acp_template set doctype = 'doc';"	

	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_catalog 'ctx_acp_template_catalog','create'"
	select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_template');	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_template','create','ctx_acp_template_catalog','" + ls_key_name + "'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_template','Template_Name','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_template','Description','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_template','Reviewed_By','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_template','image_file','add',0,'doctype'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_full'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_change_tracking'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_background_updateindex'"


	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_catalog 'ctx_acp_document_catalog','create'"
	select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_document');	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_document','create','ctx_acp_document_catalog','" + ls_key_name + "'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_document','Document_Name','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_document','Files','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_document','Description','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_document','Reviewed_By','add'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_acp_document','image_file','add',0,'Document_Type'"
	 
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_full'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_change_tracking'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_background_updateindex'"
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.16.2007 By: Jack
	is_sql_statments[upperbound(is_sql_statments)+1] = "CREATE UNIQUE INDEX index_ctx_am_action_item_seq_id ON ctx_am_action_item(seq_id);"

	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_catalog 'ctx_am_action_item_catalog','create'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_am_action_item','create','ctx_am_action_item_catalog','index_ctx_am_action_item_seq_id'"
	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_column 'ctx_am_action_item','notes','add'"
	
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_full'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_change_tracking'"
	is_sql_statments[upperbound(is_sql_statments)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_background_updateindex'"
   //---------------------------- APPEON END ----------------------------
	*/
	/*******************************08.29.2007 By Jervis *********************************/

End If
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.10.2007 By: Jack
is_sql_statments[upperbound(is_sql_statments)+1] = "create unique index idx_export_field_name on export_fields (export_id,export_field_name);"
is_sql_statments[upperbound(is_sql_statments)+1] = "create unique index idx_code_lookup_name_code on code_lookup (lookup_name,code);"
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 12.11.2006 #V7 maha removed
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_contract_management_right;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_template_clause;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_template;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_document;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_clause_rely;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_clause;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM ctx_acp_folder;"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM code_lookup WHERE lookup_name = 'Contract Clause Category' AND code = 'All';"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM code_lookup WHERE lookup_name = 'Contract Template Category' AND code = 'All';"
//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM code_lookup WHERE lookup_name = 'Contract Document Category' AND code = 'All';"
//End Code Change---12.11.2006

//datastore lds_sql
//string ls_sql,ls_dataobject
//lds_sql = Create datastore
//ls_dataobject = 'd_contract_profile_req2'
//lds_sql.dataobject = ls_dataobject
//lds_sql.settransobject(sqlca)
//ls_sql = lds_sql.Describe("datawindow.syntax")
//UPDATE ctx_screen SET dw_sql = :ls_sql, modify_date = getdate() WHERE dataobject = :ls_dataobject;
//
//ls_dataobject = 'd_contract_profile_req_existing'
//lds_sql.dataobject = ls_dataobject
//lds_sql.settransobject(sqlca)
//ls_sql = lds_sql.Describe("datawindow.syntax")
//UPDATE ctx_screen SET dw_sql = :ls_sql, modify_date = getdate() WHERE dataobject = :ls_dataobject;
//destroy lds_sql
of_execute()

end subroutine

public subroutine of_execute ();long ll_i
string ls_null[]
boolean lb_ref_cache

If Upperbound(is_sql_statments) > 0 Then  lb_ref_cache  = True

If Upperbound(is_sql_statments) > 0 Then 
	
	If Not isvalid( w_infodisp ) Then Open(w_infodisp)

	If isvalid(w_infodisp) Then w_infodisp.title = 'Creating IntelliContract Agreement Creation Module tables, Please stand by'
	If isvalid(w_infodisp) Then w_infodisp.Center = True
	If isvalid(w_infodisp) Then w_infodisp.st_complete.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_3.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_information.visible = False
	If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Creating IntelliContract Agreement Creation Module Tabels, Please stand by for version 7.0: ' 
	If isvalid(w_infodisp) Then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statments))
		
	gnv_appeondb.of_startqueue( )
	
	For ll_i = 1 TO upperbound(is_sql_statments)
		If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'ModIfication:' +string(ll_i) +' of '+ string(upperbound(is_sql_statments)) +' Please stand by!'
		EXECUTE IMMEDIATE :is_sql_statments[LL_I] USING sqlca;
		Commit;
		If isvalid(w_infodisp) Then w_infodisp.wf_step_pbar(1)
	Next
	
	gnv_appeondb.of_commitqueue( )
	
	If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Commiting modIfications Please stand by!'
	
	If isvalid(w_infodisp) Then Close(w_infodisp)
	    
End If
is_sql_statments = ls_null


end subroutine

on n_cst_agreement_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_agreement_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

